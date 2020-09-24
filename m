Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC372774AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgIXPAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 11:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728164AbgIXPAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600959628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ZooZd+2Abb0NioOnlAqnGdn71WL8pkXeAG+ycQqMKg=;
        b=cwxTD3Xrx9CNV+pKKOsIj9d03ZzDffDC5J598VOsp2eKfJqVkDUICUa12acp9V8S3zedvy
        7Nh0cfT6+fofJeaP7deBZnllRbJ7Y/4gEyCwaHIKNdlmkEcWmJrCn/vmQb2GUpH3K2Xa8R
        9U0wChDToqzOKZlOH2xP4vkjjKOWbpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-lTQRB-_VPU2rFBtOwp75YA-1; Thu, 24 Sep 2020 11:00:25 -0400
X-MC-Unique: lTQRB-_VPU2rFBtOwp75YA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A61C1017DD1;
        Thu, 24 Sep 2020 15:00:22 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37D877368C;
        Thu, 24 Sep 2020 15:00:22 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08OF0LbJ018758;
        Thu, 24 Sep 2020 11:00:21 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08OF0KDN018754;
        Thu, 24 Sep 2020 11:00:21 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 24 Sep 2020 11:00:20 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
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
In-Reply-To: <20200922172553.GL32101@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2009240853200.3485@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com> <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com> <20200922050314.GB12096@dread.disaster.area> <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com> <20200922172553.GL32101@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 22 Sep 2020, Matthew Wilcox wrote:

> > > The NVFS indirect block tree has a fan-out of 16,
> > 
> > No. The top level in the inode contains 16 blocks (11 direct and 5 
> > indirect). And each indirect block can have 512 pointers (4096/8). You can 
> > format the device with larger block size and this increases the fanout 
> > (the NVFS block size must be greater or equal than the system page size).
> > 
> > 2 levels can map 1GiB (4096*512^2), 3 levels can map 512 GiB, 4 levels can 
> > map 256 TiB and 5 levels can map 128 PiB.
> 
> But compare to an unfragmented file ... you can map the entire thing with
> a single entry.  Even if you have to use a leaf node, you can get four
> extents in a single cacheline (and that's a fairly naive leaf node layout;
> I don't know exactly what XFS uses)

But the benchmarks show that it is comparable to extent-based filesystems.

> > > Rename is another operation that has specific "operation has atomic
> > > behaviour" expectations. I haven't looked at how you've
> > > implementated that yet, but I suspect it also is extremely difficult
> > > to implement in an atomic manner using direct pmem updates to the
> > > directory structures.
> > 
> > There is a small window when renamed inode is neither in source nor in 
> > target directory. Fsck will reclaim such inode and add it to lost+found - 
> > just like on EXT2.
> 
> ... ouch.  If you have to choose, it'd be better to link it to the second
> directory then unlink it from the first one.  Then your fsck can detect
> it has the wrong count and fix up the count (ie link it into both
> directories rather than neither).

I admit that this is lame and I'll fix it. Rename is not so 
performance-critical, so I can add a small journal for this.

> > If you think that the lack of journaling is show-stopper, I can implement 
> > it. But then, I'll have something that has complexity of EXT4 and 
> > performance of EXT4. So that there will no longer be any reason why to use 
> > NVFS over EXT4. Without journaling, it will be faster than EXT4 and it may 
> > attract some users who want good performance and who don't care about GID 
> > and UID being updated atomically, etc.
> 
> Well, what's your intent with nvfs?  Do you already have customers in mind
> who want to use this in production, or is this somewhere to play with and
> develop concepts that might make it into one of the longer-established
> filesystems?

I develop it just because I thought it may be interesting. So far, it 
doesn't have any serious users (the physical format is still changing). I 
hope that it could be useable as a general purpose root filesystem when 
Optane DIMMs become common.

Mikulas

