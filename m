Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F435693A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350830AbhDGKQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 06:16:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40518 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233746AbhDGKQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:16:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137A3brU054162;
        Wed, 7 Apr 2021 06:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=87UggfMIVp6Gf5olhVLLk5wrxUtCzE80ID2noSbNS88=;
 b=qnqe79bEE8iFwkDuBxrkdDFseFdbC8E8iP3UCgtHfBcmxxLm0xeTRfOb1E4G94GrnEo1
 YQsr+4p1EiTA5sKUoaHUXDFyrB/PbG51BiMUv7g7/EJfb+gn2ZkxSfKddRGuCzpd89Bx
 ur2zJQJue6HSmauH6d9XmlOQZgwWRUCDiDxpdA4fwa4lVetWtnAE4T54nQqnXp6NRB8q
 hWyVwG9AXhxbAkFFQzj5fYkd636DvuqhA8oPGaEwgm5qydCGTDSlm+NscJliiMhaF93B
 tsSYHWNbZvoNmBYEjJ+iSCnTk8kyG811bZ+gtxV1UPDhOxXNlHOPIBaYN3vIb4LUo8q8 cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpg4ytg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 06:16:31 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 137A4Z6K059582;
        Wed, 7 Apr 2021 06:16:30 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpg4ysw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 06:16:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137A3FpP010982;
        Wed, 7 Apr 2021 10:16:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbw8kqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 10:16:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137AGQtf37290340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 10:16:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3ADD52054;
        Wed,  7 Apr 2021 10:16:26 +0000 (GMT)
Received: from localhost (unknown [9.85.69.78])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5D8855204E;
        Wed,  7 Apr 2021 10:16:26 +0000 (GMT)
Date:   Wed, 7 Apr 2021 15:46:25 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
        Ritesh Harjani <riteshh@gmail.com>
Subject: Re: [PATCH 3/3] fsdax: Output address in dax_iomap_pfn() and rename
 it
Message-ID: <20210407101625.mmz4dg7bf342mvfp@riteshh-domain>
References: <20210407063207.676753-1-ruansy.fnst@fujitsu.com>
 <20210407063207.676753-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407063207.676753-4-ruansy.fnst@fujitsu.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MP-udSHZIrOD5XCWtdSJdS1BDJ3nTM25
X-Proofpoint-GUID: IDKlxdH1nb6AJ0VUVamH8la5swD62Vj2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_07:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070070
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/04/07 02:32PM, Shiyang Ruan wrote:
> Add address output in dax_iomap_pfn() in order to perform a memcpy() in
> CoW case.  Since this function both output address and pfn, rename it to
> dax_iomap_direct_access().
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@gmail.com>

Same here. It should be either of below.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
OR
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

> ---
>  fs/dax.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
