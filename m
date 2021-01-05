Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A6F2EB444
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 21:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbhAEUb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 15:31:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51272 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbhAEUbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:31:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105KTMk3068731;
        Tue, 5 Jan 2021 20:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eZSBFhamGrQpMeqc4Oy2MNaowbrfBFp+pS4RKmYAnTc=;
 b=WU1yw3j4Sk7BiXNHZ+fLxnECk2T/4wZzZPPYWHcLf6I6LYKwvdE2A4JO9QjMkfLUetMc
 lV2F8YC6hTYWSDzqryNezjrT8XB712cnkOOM/D15XjkVMvxWmd+pj9thNX0v6OmPkpxl
 sKhm4bJB/N7C+8ap5ffxKQ93xmmH74yVHw2/rpIJPQvk2BT4shs91zh5H4Vdhppnodau
 /fEf9R0mf54C4BWbGFq6BDpGiUJyi4aIy3tCmQN8mObeBIPL2DGhUoIb1YZG82ONAgHJ
 MpczDF2w0A8i9+2Gl1lAYi68ftRgQyIfRGHxO9TbsULMbHm48/IDBSfDo5NJdIC9iy1W 4w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35tg8r2nhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 20:30:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105KUNLT152917;
        Tue, 5 Jan 2021 20:30:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35uxnt6kgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 20:30:36 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 105KUUXH032624;
        Tue, 5 Jan 2021 20:30:30 GMT
Received: from [10.175.190.169] (/10.175.190.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 12:30:30 -0800
Subject: Re: [LSFMMBPF 2021] A status update
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvme@vger.kernel.org" <linux-nvme@vger.kernel.org>
References: <fd5264ac-c84d-e1d4-01e2-62b9c05af892@toxicpanda.com>
 <20201212172957.GE2443@casper.infradead.org>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <0b356707-1ad1-a147-cd5e-224a1a8658a0@oracle.com>
Date:   Tue, 5 Jan 2021 20:30:26 +0000
MIME-Version: 1.0
In-Reply-To: <20201212172957.GE2443@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050119
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/20 5:29 PM, Matthew Wilcox wrote:
> And most urgently, when should we have the GUP meeting?  On the call,
> I suggested Friday the 8th of January, but I'm happy to set something
> up for next week if we'd like to talk more urgently.  Please propose a
> date & time.  I know we have people in Portugal and Nova Scotia who need
> to be involved live, so a time friendly to UTC+0 and UTC-4 would be good.

FWIW, I would suggest the same time as you had for PageFolio (18h GMT / 10pm PT / 13h ET)
given it can cover many tz in a not-so-bothersome time.

But instead of Jan 8 perhaps better for next week (Jan 15) in case folks
are still in new year holidays (given we are in the first week of the year).

	Joao
