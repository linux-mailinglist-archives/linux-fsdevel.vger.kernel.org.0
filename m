Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C048F554
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 22:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfHOUFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 16:05:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38182 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbfHOUFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:05:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FK4QMk002775;
        Thu, 15 Aug 2019 20:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zbLSa6W0EuiTMTGJ10AKmzZODTdbzm2Hj3NPVCPtPyY=;
 b=Kza/hdXhucTULvENXgBL7h+svfGm7Ib/OMek9SxSFitnZYfi6p4fCdY4y1dN8Wv4rYSH
 ij3j14O4NU5LZhjtYFaKHrlWV+wEHdfpBMDENsjcfFeQu/FYZKNPtaHwau5wuap6Qtwf
 immzaTZLmgZi++Hba4eYFkMmOoIq6+EqvigEEa/zrVCUfWz8eCXtj063t2+FO1rYLqfi
 OIJfS5Hc2sgYh30TBIG5spcSQm7Clg/Ya6IOOKdjTSIj7Omqsr3GTn31XN81lVkei40F
 07zbjvvCaQw96DbI1ZRqj1wzEx7p5NxpJQTfK77cWD+Zjy02fjbHZSAwIc8VFjnZVonv Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u9pjqvtes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 20:05:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FK3QIj097997;
        Thu, 15 Aug 2019 20:05:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ucpyspsys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 20:05:40 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7FK5aB7016146;
        Thu, 15 Aug 2019 20:05:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 13:05:35 -0700
Date:   Thu, 15 Aug 2019 13:05:34 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: fixes for 5.3-rc5
Message-ID: <20190815200534.GF15186@magnolia>
References: <20190815171347.GD15186@magnolia>
 <CAHk-=wiHuHLK49LKQhtERXaq0OYUnug4DJZFLPq9RHEG2Cm+bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHuHLK49LKQhtERXaq0OYUnug4DJZFLPq9RHEG2Cm+bQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150189
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150189
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 12:38:33PM -0700, Linus Torvalds wrote:
> Pulled. Just a quick note:
> 
> On Thu, Aug 15, 2019 at 10:13 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > - Convert more directory corruption debugging asserts to actual
> >   EFSCORRUPTED returns instead of blowing up later on.
> 
> The proper error code looks like an obvious improvement, but I do
> wonder if there should be some (ratelimited) system logging too?
> 
> I've seen a lot of programs that don't report errors very clearly and
> might just silently stop running and as a sysadmin I'd think I'd
> rather have something in the system logs than users saying "my app
> crashes at startup"/
> 
> Maybe the logging ends up being there already - just done later. It
> wasn't obvious from the patch, and I didn't check the whole callchain
> (only direct callers).

Metadata update failures hitting EFSCORRUPTED will leave a fair amount
of spew in dmesg both when we find the corrupt metadata and the update
transaction is aborted (which takes the filesystem down).  Read errors
get logged if we spot an error within a block but aren't consistently
logged when we discover problems between separate metadata objects.

FWIW I've wondered off and on if the VFS syscalls should be generating
some kind of audit trail when something returns an error message to
userspace?

--D

>                   Linus
