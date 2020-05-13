Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2891D1B51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 18:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgEMQlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 12:41:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43270 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgEMQlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 12:41:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DGXB6H169943;
        Wed, 13 May 2020 16:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=z3WykGLnspcKA18JV+DbvKUDOIknyu+oP3oUZLL37xI=;
 b=lKiD3NVRXwj4fJSlHkC4mW320iTUs+xAowm4QlP4fyv9YQl2p1NktJrlbI74c9ZxFRfL
 lPWG/OLyV0JyEQeWwMejo6yLBHclVwXZQtDgdOFrtJoxnTVYjEJOvidtcp+YPBTVCejJ
 QBIBWk/SGuW1wJcGr5wBGY/MLrgi7A1NOeX8S5ti+IA5tuPQWAulrBjKJpO89JreuujO
 KdC1C4u9Ujcm5Hez9GCpNKEviF7ohrf7sm4J2tpCaQ4UiKQMkGiIqWNIxwgVpBO3ElPi
 /1gWY0N0k297bVCiSQ39mc3hTMi+uDZRCgCX1r6uwYDdwdlwGiDi3IbH7WaZ1E4gBIXP ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3100xwnbas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 16:41:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DGbuVK185648;
        Wed, 13 May 2020 16:41:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3100yavft7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 16:41:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04DGfLaL032724;
        Wed, 13 May 2020 16:41:21 GMT
Received: from localhost (/10.159.244.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 09:41:20 -0700
Date:   Wed, 13 May 2020 09:41:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Xu, Yanfei" <yanfei.xu@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: BUG:loop:blk_update_request: I/O error, dev loop6, sector 49674
 op 0x9:(WRITE_ZEROES)
Message-ID: <20200513164119.GD1984748@magnolia>
References: <dac81506-0065-ee64-fcd1-c9f1d002b4fb@windriver.com>
 <c51460e0-1abb-799d-9ee9-de9c39315eda@windriver.com>
 <8f3eeb22-2e85-aa3f-6287-b3c467d39a8e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f3eeb22-2e85-aa3f-6287-b3c467d39a8e@kernel.dk>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=1 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130144
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[add fsdevel to cc]

On Tue, May 12, 2020 at 08:22:08PM -0600, Jens Axboe wrote:
> On 5/12/20 8:14 PM, Xu, Yanfei wrote:
> > Hi,
> > 
> > After operating the /dev/loop which losetup with an image placed in**tmpfs,
> > 
> > I got the following ERROR messages:
> > 
> > ----------------[cut here]---------------------
> > 
> > [  183.110770] blk_update_request: I/O error, dev loop6, sector 524160 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > [  183.123949] blk_update_request: I/O error, dev loop6, sector 522 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > [  183.137123] blk_update_request: I/O error, dev loop6, sector 16906 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > [  183.150314] blk_update_request: I/O error, dev loop6, sector 32774 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > [  183.163551] blk_update_request: I/O error, dev loop6, sector 49674 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > [  183.176824] blk_update_request: I/O error, dev loop6, sector 65542 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > [  183.190029] blk_update_request: I/O error, dev loop6, sector 82442 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > [  183.203281] blk_update_request: I/O error, dev loop6, sector 98310 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > [  183.216531] blk_update_request: I/O error, dev loop6, sector 115210 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > [  183.229914] blk_update_request: I/O error, dev loop6, sector 131078 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> > 
> > 
> > I have found the commit which introduce this issue by git bisect :
> > 
> >     commit :efcfec57[loop: fix no-unmap write-zeroes request behavior]
> 
> Please CC the author of that commit too. Leaving the rest quoted below.
> 
> > Kernrel version: Linux version 5.6.0
> > 
> > Frequency: everytime
> > 
> > steps to reproduce:
> > 
> >   1.git clone mainline kernel
> > 
> >   2.compile kernel with ARCH=x86_64, and then boot the system with it
> > 
> >     (seems other arch also can reproduce it )
> > 
> >   3.make an image by "dd of=/tmp/image if=/dev/zero bs=1M count=256"
> > 
> >   *4.**place the image in tmpfs directory*
> > 
> >   5.losetup /dev/loop6 /PATH/TO/image
> > 
> >   6.mkfs.ext2 /dev/loop6
> > 
> > 
> > Any comments will be appreciated.

Hm, you got IO failures here because shmem_fallocate doesn't support
FL_ZERO_RANGE range.  That might not be too hard to add, but there's a
broader problem of detecting fallocate support--

The loop driver assumes that if the file has an fallocate method then
it's safe to set max_discard_sectors (and now max_write_zeroes_sectors)
to UINT_MAX>>9.  There's currently no good way to detect which modes are
supported by a filesystem's ->fallocate function, or to discover the
required granularity.

Right now we tell application developers that the way to discover the
conditions under which fallocate will work is to try it and see if they
get EOPNOTSUPP.

One way to "fix" this would be to fix lo_fallocate to set RQF_QUIET if
the filesystem returns EOPNOTSUPP, which gets rid of the log messages.
We probably ought to zero out the appropriate max_*_sectors if we get
EOPNOTSUPP.

--D

> > 
> > 
> > Thanks,
> > 
> > Yanfei
> > 
> > 
> > 
> > 
> > 
> 
> 
> -- 
> Jens Axboe
> 
