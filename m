Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E23275870
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 15:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIWNLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 09:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWNLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600866712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDxFW0Zci5a4gqRLOX3WWCWSqU2y/VaKVhoCtZvVWrs=;
        b=ZGkP/NDrjVBk1hUW9PJbmxuCpHuhhvIf3SFU4pV3x5gxuOkxj6a03Z+ce7SuFwAUM+4Cba
        5C0jt8EpUefShXxsIquWkIQZD/qiCoNBmDUSW5itd56Zb46PpQSM8CYgG+/BNX5SwnQf0n
        nNoo9+NxvQIRbGLQ/xfRY3m85uAcr0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-LjZwdbeiODmyd-uDEwuOfA-1; Wed, 23 Sep 2020 09:11:47 -0400
X-MC-Unique: LjZwdbeiODmyd-uDEwuOfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5830B802B4C;
        Wed, 23 Sep 2020 13:11:45 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B90DB78822;
        Wed, 23 Sep 2020 13:11:44 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08NDBiOY022621;
        Wed, 23 Sep 2020 09:11:44 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08NDBhOr022617;
        Wed, 23 Sep 2020 09:11:43 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 23 Sep 2020 09:11:43 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jan Kara <jack@suse.cz>
cc:     Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: NVFS XFS metadata (was: [PATCH] pmem: export the symbols
 __copy_user_flushcache and __copy_from_user_flushcache)
In-Reply-To: <20200923095739.GC6719@quack2.suse.cz>
Message-ID: <alpine.LRH.2.02.2009230841110.1800@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com> <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com> <20200922050314.GB12096@dread.disaster.area> <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com> <20200923095739.GC6719@quack2.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 23 Sep 2020, Jan Kara wrote:

> On Tue 22-09-20 12:46:05, Mikulas Patocka wrote:
> > > mapping 2^21 blocks requires a 5 level indirect tree. Which one if going 
> > > to be faster to truncate away - a single record or 2 million individual 
> > > blocks?
> > > 
> > > IOWs, we can take afford to take an extra cacheline miss or two on a
> > > tree block search, because we're accessing and managing orders of
> > > magnitude fewer records in the mapping tree than an indirect block
> > > tree.
> > > 
> > > PMEM doesn't change this: extents are more time and space efficient
> > > at scale for mapping trees than indirect block trees regardless
> > > of the storage medium in use.
> > 
> > PMEM doesn't have to be read linearly, so the attempts to allocate large 
> > linear space are not needed. They won't harm but they won't help either.
> > 
> > That's why NVFS has very simple block allocation alrogithm - it uses a 
> > per-cpu pointer and tries to allocate by a bit scan from this pointer. If 
> > the group is full, it tries a random group with above-average number of 
> > free blocks.
> 
> I agree with Dave here. People are interested in 2MB or 1GB contiguous
> allocations for DAX so that files can be mapped at PMD or event PUD levels
> thus saving a lot of CPU time on page faults and TLB.

NVFS has upper limit on block size 1MB. So, should raise it to 2MB? Will 
2MB blocks be useful to someone?

Is there some API how userspace can ask the kernel for aligned allocation? 
fallocate() doesn't seem to offer an option for alignment.

> > EXT4 uses bit scan for allocations and people haven't complained that it's 
> > inefficient, so it is probably OK.
> 
> Yes, it is more or less OK but once you get to 1TB filesystem size and
> larger, the number of block groups grows enough that it isn't that great
> anymore. We are actually considering new allocation schemes for ext4 for
> this large filesystems...

NVFS can run with block size larger than page size, so you can reduce the 
number of block groups by increasing block size.

(ext4 also has bigalloc feature that will do it)

> > If you think that the lack of journaling is show-stopper, I can implement 
> > it. But then, I'll have something that has complexity of EXT4 and 
> > performance of EXT4. So that there will no longer be any reason why to use 
> > NVFS over EXT4. Without journaling, it will be faster than EXT4 and it may 
> > attract some users who want good performance and who don't care about GID 
> > and UID being updated atomically, etc.
> 
> I'd hope that your filesystem offers more performance benefits than just
> what you can get from a lack of journalling :). ext4 can be configured to

I also don't know how to implement journling on persistent memory :) On 
EXT4 or XFS you can pin dirty buffers in memory until the journal is 
flushed. This is obviously impossible on persistent memory. So, I'm 
considering implementing only some lightweight journaling that will 
guarantee atomicity between just a few writes.

> run without a journal as well - mkfs.ext4 -O ^has_journal. And yes, it does
> significantly improve performance for some workloads but you have to have
> some way to recover from crashes so it's mostly used for scratch
> filesystems (e.g. in build systems, Google uses this feature a lot for some
> of their infrastructure as well).
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

I've run "dir-test /mnt/test/ 8000000 8000000" and the result is:
EXT4 with journal	- 5m54,019s
EXT4 without journal	- 4m4,444s
NVFS			- 2m9,482s

Mikulas

