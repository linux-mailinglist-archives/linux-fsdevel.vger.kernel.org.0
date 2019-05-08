Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2817DEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 18:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfEHQQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 12:16:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57740 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEHQQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 12:16:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48G985m111661;
        Wed, 8 May 2019 16:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=A8FQGGyK66jwWHzp8sKGXimEVEnxEZzoDY+qCyvUAHA=;
 b=dGdMSRmCTJKFyCeZXYBW5RZZJ6uH7SF5l0bBec4xe7XW+QKLtdcEN3Sq/A+MuhGnBina
 JB3jk6TCst7VJckGD52aM/jbhbORfgFk2yLzO5DMLvfRT5dQ0s6UN4Q26O2VhP9OrgqW
 itzku36ALbyrFQIdzbGMkxGD3O4laotsFs+6G4uiYZr8Se94fTxuFDrEgOP3jdloXEYU
 IBTLoGkjs3ZWLy0HnO44lfp2qQS+mtw0rP/rHqOYaGP30t11EBa9A5xADHCYcHYiUjvZ
 3tOOEbGk649zOqtNIrKIZE+vx2vDWYbVPMfS0FF+N6RA3m9bIQTXONbsNqfWMdm6Jqam BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s94b6567m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 16:16:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48GF32c124545;
        Wed, 8 May 2019 16:16:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2s94ba75b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 16:16:28 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x48GGQas017698;
        Wed, 8 May 2019 16:16:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 May 2019 09:16:26 -0700
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ric Wheeler <ricwheeler@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
Subject: Re: Testing devices for discard support properly
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
        <20190507220449.GP1454@dread.disaster.area>
Date:   Wed, 08 May 2019 12:16:24 -0400
In-Reply-To: <20190507220449.GP1454@dread.disaster.area> (Dave Chinner's
        message of "Wed, 8 May 2019 08:04:50 +1000")
Message-ID: <yq1ef58ly5j.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905080100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905080100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Dave,

> My big question here is this:
>
> - is "discard" even relevant for future devices?

It's hard to make predictions. Especially about the future. But discard
is definitely relevant on a bunch of current drives across the entire
spectrum from junk to enterprise. Depending on workload,
over-provisioning, media type, etc.

Plus, as Ric pointed out, thin provisioning is also relevant. Different
use case but exactly the same plumbing.

> IMO, trying to "optimise discard" is completely the wrong direction
> to take. We should be getting rid of "discard" and it's interfaces
> operations - deprecate the ioctls, fix all other kernel callers of
> blkdev_issue_discard() to call blkdev_fallocate()

blkdev_fallocate() is implemented using blkdev_issue_discard().

> and ensure that drive vendors understand that they need to make
> FALLOC_FL_ZERO_RANGE and FALLOC_FL_PUNCH_HOLE work, and that
> FALLOC_FL_PUNCH_HOLE | FALLOC_FL_NO_HIDE_STALE is deprecated (like
> discard) and will be going away.

Fast, cheap, easy. Pick any two.

The issue is that -- from the device perspective -- guaranteeing zeroes
requires substantially more effort than deallocating blocks. To the
point where several vendors have given up making it work altogether and
either report no discard support or silently ignore discard requests
causing you to waste queue slots for no good reason.

So while instant zeroing of a 100TB drive would be nice, I don't think
it's a realistic goal given the architectural limitations of many of
these devices. Conceptually, you'd think it would be as easy as
unlinking an inode. But in practice the devices keep much more (and
different) state around in their FTLs than a filesystem does in its
metadata.

Wrt. device command processing performance:

1. Our expectation is that REQ_DISCARD (FL_PUNCH_HOLE |
   FL_NO_HIDE_STALE), which gets translated into ATA DSM TRIM, NVMe
   DEALLOCATE, SCSI UNMAP, executes in O(1) regardless of the number of
   blocks operated on.

   Due to the ambiguity of ATA DSM TRIM and early SCSI we ended up in a
   situation where the industry applied additional semantics
   (deterministic zeroing) to that particular operation. And that has
   caused grief because devices often end up in the O(n-or-worse) bucket
   when determinism is a requirement.

2. Our expectation for the allocating REQ_ZEROOUT (FL_ZERO_RANGE), which
   gets translated into NVMe WRITE ZEROES, SCSI WRITE SAME, is that the
   command executes in O(n) but that it is faster -- or at least not
   worse -- than doing a regular WRITE to the same block range.

3. Our expectation for the deallocating REQ_ZEROOUT (FL_PUNCH_HOLE),
   which gets translated into ATA DSM TRIM w/ whitelist, NVMe WRITE
   ZEROES w/ DEAC, SCSI WRITE SAME w/ UNMAP, is that the command will
   execute in O(1) for any portion of the block range described by the
   I/O that is aligned to and a multiple of the internal device
   granularity. With an additional small O(n_head_LBs) + O(n_tail_LBs)
   overhead for zeroing any LBs at the beginning and end of the block
   range described by the I/O that do not comprise a full block wrt. the
   internal device granularity.

Does that description make sense?

The problem is that most vendors implement (3) using (1). But can't make
it work well because (3) was -- and still is for ATA -- outside the
scope of what the protocols can express.

And I agree with you that if (3) was implemented correctly in all
devices, we wouldn't need (1) at all. At least not for devices with an
internal granularity << total capacity.

-- 
Martin K. Petersen	Oracle Linux Engineering
