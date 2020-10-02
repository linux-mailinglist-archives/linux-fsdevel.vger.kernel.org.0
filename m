Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D450028142E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgJBNjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 09:39:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44140 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBNjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:39:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092DdCbP002579;
        Fri, 2 Oct 2020 13:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=IGKJaZlfnNTO7i1ACoOSSaJeeqkjoUmn20eh8oo34nQ=;
 b=d+z/rtGhWiCJ9nhO4QwFqUb3sjZyFyx1kAFuEdHbEn3LVKDOlWWesQxkcRiQgbvQ8dg0
 n6f8YIvWI5xJXAiVIw0wDyWLRiYiI23BSothepklnQfKCMtlkbEtv3hgzDmaIBE64Gkt
 Nmvp/PmET8no1hGOFIqDoIfCBzuGpeGjXYNiAbu77gUMPX7SYcOLVmK8FtYVtQPCel0+
 LJrMhTDFj6dREwR/jGULuV8d6ibNkiVpB7sUE/Ci8l+sRRwwbFolDby2DPIBSsZKZ19/
 DQEvNF2OwNgsiTWtFV4VGaD1I/5oHhChKGXNyHuwk5wzYwlfvI85X4gJ37aAH6X0cfVY 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33sx9njych-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 13:39:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092DZsoO062792;
        Fri, 2 Oct 2020 13:39:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33tfk3hnnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Oct 2020 13:39:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 092Dd7Ij026447;
        Fri, 2 Oct 2020 13:39:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Oct 2020 06:39:06 -0700
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v8 01/41] block: add bio_add_zone_append_page
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k0w8g3rw.fsf@ca-mkp.ca.oracle.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
        <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
Date:   Fri, 02 Oct 2020 09:39:04 -0400
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
        (Naohiro Aota's message of "Fri, 2 Oct 2020 03:36:08 +0900")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020107
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Naohiro/Johannes,

> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which
> is intended to be used by file systems that directly add pages to a bio
> instead of using bio_iov_iter_get_pages().

Why use the hardware limit? For filesystem I/O we generally use the
queue soft limit to prevent I/Os getting too big which can lead to very
unpredictable latency in mixed workloads.

max_zone_append_sectors also appears to be gated exclusively by hardware
constraints. Is there user-controllable limit in place for append
operations?

-- 
Martin K. Petersen	Oracle Linux Engineering
