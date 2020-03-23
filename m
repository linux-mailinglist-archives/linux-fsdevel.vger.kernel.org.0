Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BD818F872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 16:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCWPVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 11:21:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgCWPVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:21:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NF9KZR118132;
        Mon, 23 Mar 2020 15:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zE4D52tgEN49T+Cl6dWeOECY4EVZp7WCUSOL0e06lSM=;
 b=dt/NnxV7tWjWUmuOtTRP6v1x67UniZ7/R2U2mZOJI1jB/wRBn7IP/ZhZYDi3puAA8bgJ
 uovkD6vduPlv6jWW3powKJRzXBHrqJr6Qedn91aH0JSX+XAl7RSwBuByfQKRZhDvoFS9
 msTiCb4lWigf4DmHxWFt/jzf9l1ImVONYkAP/FC8hjlGQKpXCiWJ5GuJXGzZL6Sf0QzT
 gWiAm9qb/eYnI2WR2qWd1XHATUIk539WdJYMvQEpgXG7Bft7ICnKmquza0V8jYpLmyEu
 106eMvJAYHVkGAt0owONRcBfwotfqH7MgezSRNMlO8Xa52G76NZK1vzJZXLHOzg0vzwv Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ywavky771-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 15:21:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NFJpr3068524;
        Mon, 23 Mar 2020 15:21:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2yxw7fn7ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 15:21:11 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02NFL7V9015843;
        Mon, 23 Mar 2020 15:21:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 08:21:06 -0700
Date:   Mon, 23 Mar 2020 08:21:05 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] hibernate: Allow uswsusp to write to swap
Message-ID: <20200323152105.GB29351@magnolia>
References: <20200304170646.GA31552@dumbo>
 <5202091.FuziMeULnI@kreacher>
 <20200322112314.GA22738@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322112314.GA22738@dumbo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230086
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 22, 2020 at 12:23:14PM +0100, Domenico Andreoli wrote:
> On Sun, Mar 22, 2020 at 08:14:21AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, March 4, 2020 6:06:46 PM CET Domenico Andreoli wrote:
> > > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > > 
> > > It turns out that there is one use case for programs being able to
> > > write to swap devices, and that is the userspace hibernation code.
> > > 
> > > Quick fix: disable the S_SWAPFILE check if hibernation is configured.
> > > 
> > > Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
> > > Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > > Reported-by: Marian Klein <mkleinsoft@gmail.com>
> > > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > > 
> > > v2:
> > >  - use hibernation_available() instead of IS_ENABLED(CONFIG_HIBERNATE)
> > >  - make Fixes: point to the right commit
> > 
> > This looks OK to me.
> > 
> > Has it been taken care of already, or am I expected to apply it?
> 
> I don't know who is supposed to take it, I did not receive any notification.

Hmmm.  I thought it had been picked up by akpm (see "[alternative-merged]
vfs-partially-revert-dont-allow-writes-to-swap-files.patch removed from
-mm tree" from 5 March), but it's not in mmotm now, so I'll put this in my
vfs tree for 5.7.

Also, since apparently my previous RVB apparently never made it to the
internet,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> > 
> > > ---
> > >  fs/block_dev.c |    4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > Index: b/fs/block_dev.c
> > > ===================================================================
> > > --- a/fs/block_dev.c
> > > +++ b/fs/block_dev.c
> > > @@ -34,6 +34,7 @@
> > >  #include <linux/task_io_accounting_ops.h>
> > >  #include <linux/falloc.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/suspend.h>
> > >  #include "internal.h"
> > >  
> > >  struct bdev_inode {
> > > @@ -2001,7 +2002,8 @@ ssize_t blkdev_write_iter(struct kiocb *
> > >  	if (bdev_read_only(I_BDEV(bd_inode)))
> > >  		return -EPERM;
> > >  
> > > -	if (IS_SWAPFILE(bd_inode))
> > > +	/* uswsusp needs write permission to the swap */
> > > +	if (IS_SWAPFILE(bd_inode) && !hibernation_available())
> > >  		return -ETXTBSY;
> > >  
> > >  	if (!iov_iter_count(from))
> > > 
> > 
> > 
> > 
> > 
> 
> -- 
> rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
> ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
