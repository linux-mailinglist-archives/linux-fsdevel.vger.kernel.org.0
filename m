Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7B26D3F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 08:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIQGup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQGup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAF5C06174A;
        Wed, 16 Sep 2020 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FT9kKWqO44LtdODqEL2MRar9ou6XSVxG66enGGgs8Es=; b=g5CcHwamwpXA0o1C6qQ9TZ56eP
        VOarKxr3hUyo+hJpsUhl01pWk1xTjBiFdw+lBU55OAClpb1VcZ8EEikff0FSz8RJJy1MCNTY80Rbb
        M8JVGM8OzPsNYvf1r6H7nZQGwtF3LORlpwgMHWiUGk4nnf9RmoNfCDEcrX6/VM2bhzCVnm23CXHLh
        vsbapnZKgfigwTxcdVp8K9LYMBKCcJQy5+8V5ATsTk1eQ/Hrs5II0+RfkZjMuZeKV/HTowP9yGvM+
        e15KNpMXlQ2UT1mbVV93jxwsSVV8yCPQozn32YNC4AReBIWmF0f+XXjnF/IAuf1q7Y8/BrIztF/CB
        AETmfowA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kInkQ-0003E4-5e; Thu, 17 Sep 2020 06:50:26 +0000
Date:   Thu, 17 Sep 2020 07:50:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] pmem: export the symbols __copy_user_flushcache and
 __copy_from_user_flushcache
Message-ID: <20200917065026.GA11920@infradead.org>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:40:13AM -0700, Dan Williams wrote:
> > Before nvfs gets included in the kernel, I need to distribute it as a
> > module. So, it would make my maintenance easier. But if you don't want to
> > export it now, no problem, I can just copy __copy_user_flushcache from the
> > kernel to the module.
> 
> That sounds a better plan than exporting symbols with no in-kernel consumer.

Exporting symbols without a user is a complete no-go.

> > > My first question about nvfs is how it compares to a daxfs with
> > > executables and other binaries configured to use page cache with the
> > > new per-file dax facility?
> >
> > nvfs is faster than dax-based filesystems on metadata-heavy operations
> > because it doesn't have the overhead of the buffer cache and bios. See
> > this: http://people.redhat.com/~mpatocka/nvfs/BENCHMARKS
> 
> ...and that metadata problem is intractable upstream? Christoph poked
> at bypassing the block layer for xfs metadata operations [1], I just
> have not had time to carry that further.
> 
> [1]: "xfs: use dax_direct_access for log writes", although it seems
> he's dropped that branch from his xfs.git

I've pushed the old branch out again:

    http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-log-dax

The main sticking points here are:

 - currently all our nvdimm/DAX code does totally pointless pmem_flush
   calls just to be on the safe side.  That probably is one of the big
   speedups of nova and other academic snake oil projects over our
   stack.  We need to handle this properly
 - what do we do about write error handling?  That is the other big
   thing in the pmem/dax stack that all of the direct writers (including
   MAP_SYNC mmaps) pretty much ignore

Once that is sorted out we can not just put the log changes like above
in, but also move the buffer cache over to do a direct access and
basically stop using the block layer for a pure DAX XFS.
