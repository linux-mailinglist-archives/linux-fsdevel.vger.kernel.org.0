Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D7C350616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhCaSOI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhCaSOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:14:05 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47F1C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 11:14:03 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id c3so9252490qvz.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DGHBOgZ9z+ijGSYvMbAUScUUc1fpYcdzhLK1Gz/qsF4=;
        b=cjwRRU5r5DXi54jts92fcHzj7omC2BLIU9CC98t4b6qpx2gm1ClCcMmjFWsLdVupB3
         pILl7DfeVfiEo+03z0lg87b0ItP3mhhaaGNyQOJhbR/IKdK9WjQcO5YbF/6iBoSkA/zL
         aPs1DtpJC3fT0lWlCGtog20Mv9pCeYhZNrxKRTXrrCmF99BWK5+SAnLG3fxeBAax6sKN
         1Z1ckMiKLCdPzF7QOslY3GEB6+pI2MpWtPYWBIVjwdnqwa7OA+icj8qxSulAfiKjmg6+
         YJRE/DgkW1AJMyqXTOHFVaYHeHwLu92lUXsFyIVL0/CHISzazjPLou9hkYVt+o97aEtg
         xWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DGHBOgZ9z+ijGSYvMbAUScUUc1fpYcdzhLK1Gz/qsF4=;
        b=kJMCgNp47L3lIulOIvUwawkFqPbHY1PteyVnGvANJXVOQpC+dyuMpq3Hp23n8W6X1s
         psPrgWdQNU9LFxZKpM6oKVcybchNpo7mwsnGbtUlMT32Jl5JNOHewK+XB9SvVXtVMtG8
         vquLDKSqD8orocVmQClyR0kTjAK8cdv3sBMuIpte3QP5Ztk05tEaFn6dCodcPvsWydxA
         rz4nSDp2huOqN6nzKhTxkpn0z78U5wv/DNIiqGUDEQo2xVPbQexTyM/TocC7pQNVsNoo
         n+VBU9/YlLNXbZ19buGHaKmqdjJqrvvzKbgcOhOVsACND3s6m1cXAAlmtCSzdWAWdauy
         qUmw==
X-Gm-Message-State: AOAM5305Ea4Og5fbs8PPr1akAVgyE1AwJUb18jZQ1C6trdX+a0gOwZRp
        S7jTudyXky8SsLQXNE6HzFcwdTR9BcNCWw==
X-Google-Smtp-Source: ABdhPJxHXGUw0k/Ga6H629uZQFFYpj8+UNwg8mAcw6HBEcVeolwGGG6/iuNtXbxYieZFFWPJRCYZLQ==
X-Received: by 2002:a05:6214:20ad:: with SMTP id 13mr4038088qvd.35.1617214442555;
        Wed, 31 Mar 2021 11:14:02 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id m16sm1963179qkm.100.2021.03.31.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 11:14:01 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:14:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <YGS76CfjNc2jfYQ7@cmpxchg.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
 <YF4eX/VBPLmontA+@cmpxchg.org>
 <20210329165832.GG351017@casper.infradead.org>
 <YGN8biqigvPP0SGN@cmpxchg.org>
 <20210330210929.GR351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330210929.GR351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:09:29PM +0100, Matthew Wilcox wrote:
> On Tue, Mar 30, 2021 at 03:30:54PM -0400, Johannes Weiner wrote:
> > Hi Willy,
> > 
> > On Mon, Mar 29, 2021 at 05:58:32PM +0100, Matthew Wilcox wrote:
> > > I'm going to respond to some points in detail below, but there are a
> > > couple of overarching themes that I want to bring out up here.
> > > 
> > > Grand Vision
> > > ~~~~~~~~~~~~
> > > 
> > > I haven't outlined my long-term plan.  Partly because it is a _very_
> > > long way off, and partly because I think what I'm doing stands on its
> > > own.  But some of the points below bear on this, so I'll do it now.
> > > 
> > > Eventually, I want to make struct page optional for allocations.  It's too
> > > small for some things (allocating page tables, for example), and overly
> > > large for others (allocating a 2MB page, networking page_pool).  I don't
> > > want to change its size in the meantime; having a struct page refer to
> > > PAGE_SIZE bytes is something that's quite deeply baked in.
> > 
> > Right, I think it's overloaded and it needs to go away from many
> > contexts it's used in today.
> > 
> > I think it describes a real physical thing, though, and won't go away
> > as a concept. More on that below.
> 
> I'm at least 90% with you on this, and we're just quibbling over details
> at this point, I think.
> 
> > > In broad strokes, I think that having a Power Of Two Allocator
> > > with Descriptor (POTAD) is a useful foundational allocator to have.
> > > The specific allocator that we call the buddy allocator is very clever for
> > > the 1990s, but touches too many cachelines to be good with today's CPUs.
> > > The generalisation of the buddy allocator to the POTAD lets us allocate
> > > smaller quantities (eg a 512 byte block) and allocate descriptors which
> > > differ in size from a struct page.  For an extreme example, see xfs_buf
> > > which is 360 bytes and is the descriptor for an allocation between 512
> > > and 65536 bytes.
> > 
> > I actually disagree with this rather strongly. If anything, the buddy
> > allocator has turned out to be a pretty poor fit for the foundational
> > allocator.
> > 
> > On paper, it is elegant and versatile in serving essentially arbitrary
> > memory blocks. In practice, we mostly just need 4k and 2M chunks from
> > it. And it sucks at the 2M ones because of the fragmentation caused by
> > the ungrouped 4k blocks.
> 
> That's a very Intel-centric way of looking at it.  Other architectures
> support a multitude of page sizes, from the insane ia64 (4k, 8k, 16k, then
> every power of four up to 4GB) to more reasonable options like (4k, 32k,
> 256k, 2M, 16M, 128M).  But we (in software) shouldn't constrain ourselves
> to thinking in terms of what the hardware currently supports.  Google
> have data showing that for their workloads, 32kB is the goldilocks size.
> I'm sure for some workloads, it's much higher and for others it's lower.
> But for almost no workload is 4kB the right choice any more, and probably
> hasn't been since the late 90s.

You missed my point entirely.

It's not about the exact page sizes, it's about the fragmentation
issue when you mix variable-sized blocks without lifetime grouping.

Anyway, we digressed quite far here. My argument was simply that it's
conceivable we'll switch to a default allocation block and page size
that is larger than the smallest paging size supported by the CPU and
the kernel. (Various architectures might support multiple page sizes,
but once you pick one, that's the smallest quantity the kernel pages.)

That makes "bundle of pages" a short-sighted abstraction, and folio a
poor name for pageable units.

I might be wrong about what happens to PAGE_SIZE eventually (even
though your broader arguments around allocator behavior and
fragmentation don't seem to line up with my observations from
production systems, or the evolution of how we manage allocations of
different sizes) - but you also haven't made a good argument why the
API *should* continue to imply we're dealing with one or more pages.

Yes, it's a bit bikesheddy. But you're proposing an abstraction for
one of the most fundamental data structures in the operating system,
with tens of thousands of instances in almost all core subsystems.

"Bundle of pages (for now) with filesystem data (and maybe anon data
since it's sort of convenient in terms of data structure, for now)"
just doesn't make me go "Yeah, that's it."

I would understand cache_entry for the cache; mem for cache and file
(that discussion trailed off); pageable if we want to imply a sizing
and alignment constraints based on the underlying MMU.

I would even prefer kerb, because at least it wouldn't be misleading
if we do have non-struct page backing in the future.

> > The great thing about the slab allocator isn't just that it manages
> > internal fragmentation of the larger underlying blocks. It also groups
> > related objects by lifetime/age and reclaimability, which dramatically
> > mitigates the external fragmentation of the memory space.
> > 
> > The buddy allocator on the other hand has no idea what you want that
> > 4k block for, and whether it pairs up well with the 4k block it just
> > handed to somebody else. But the decision it makes in that moment is
> > crucial for its ability to serve larger blocks later on.
> > 
> > We do some mobility grouping based on how reclaimable or migratable
> > the memory is, but it's not the full answer.
> 
> I don't think that's entirely true.  The vast majority of memory in any
> machine is either anonymous or page cache.  The problem is that right now,
> all anonymous and page cache allocations are order-0 (... or order-9).
> So the buddy allocator can't know anything useful about the pages and will
> often allocate one order-0 page to the page cache, then allocate its buddy
> to the slab cache in order to allocate the radix_tree_node to store the
> pointer to the page in (ok, radix tree nodes come from an order-2 cache,
> but it still prevents this order-9 page from being assembled).
> 
> If the movable allocations suddenly start being order-3 and order-4,
> the unmovable, unreclaimable allocations are naturally going to group
> down in the lower orders, and we won't have the problem that a single
> dentry blocks the allocation of an entire 2MB page.

I don't follow what you're saying here.

> > A variable size allocator without object type grouping will always
> > have difficulties producing anything but the smallest block size after
> > some uptime. It's inherently flawed that way.
> 
> I think our buddy allocator is flawed, to be sure, but only because
> it doesn't handle movable hints more aggressively.  For example, at
> the point that a largeish block gets a single non-movable allocation,
> all the movable allocations within that block should be migrated out.
> If the offending allocation is freed quickly, it all collapses into a
> large, useful chunk, or if not, then it provides a sponge to soak up
> other non-movable allocations.

The object type implies aging rules and typical access patterns that
are not going to be captured purely by migratability. As such, the
migratetype alone will always perform worse than full type grouping.

E.g. a burst of inodes and dentries allocations can claim a large
number of blocks from movable to reclaimable, which will then also be
used to serve concurrent allocations of a different type that may have
much longer lifetimes. After the inodes and dentries disappear again,
you're stuck with very sparsely populated reclaimable blocks.

They can still be reclaimed, but they won't free up as easily as a
contiguous run of bulk-aged inodes and dentries.

You also cannot easily move reclaimable objects out of the block when
an unmovable allocation claims it the same way, so this is sort of a
moot proposal anyway.

The slab allocator isn't a guarantee, but I don't see why you're
arguing we should leave additional lifetime/usage hints on the table.

> > As drivers go, I think there are slightly different requirements to
> > filesystems, too. For filesystems, when the VM can finally do it (and
> > the file range permits it), I assume we want to rather transparently
> > increase the unit of data transfer from 4k to 2M. Most drivers that
> > currently hardcode alloc_page() or PAGE_SIZE OTOH probably don't want
> > us to bump their allocation sizes.
> 
> If you take a look at my earlier work, you'll see me using a range of
> sizes in the page cache, starting at 16kB and gradually increasing to
> (theoretically) 2MB, although the algorithm tended to top out around
> 256kB.  Doing particularly large reads could see 512kB/1MB reads, but
> it was very hard to hit 2MB in practice.  I wasn't too concerned at the
> time, but my point is that we do want to automatically tune the size
> of the allocation unit to the workload.  An application which reads in
> 64kB chunks is giving us a pretty clear signal that they want to manage
> memory in 64kB chunks.

You missed my point here, but it sounds like we agree that drivers who
just want a fixed buffer should not use the same type that filesystems
use for dynamic paging units.

> > > It'd probably be better to have the dcache realise that its old entries
> > > aren't useful any more and age them out instead of relying on memory
> > > pressure to remove old entries, so this is probably an unnecessary
> > > digression.
> > 
> > It's difficult to identify a universally acceptable line for
> > usefulness of caches other than physical memory pressure.
> > 
> > The good thing about the memory pressure threshold is that you KNOW
> > somebody else has immediate use for the memory, and you're justified
> > in recycling and reallocating caches from the cold end.
> > 
> > Without that, you'd either have to set an arbitrary size cutoff or an
> > arbitrary aging cutoff (not used in the last minute e.g.). But optimal
> > settings for either of those depend on the workload, and aren't very
> > intuitive to configure.
> 
> For the dentry cache, I think there is a more useful metric, and that's
> length of the hash chain.  If it gets too long, we're spending more time
> walking it than we're saving by having entries cached.  Starting reclaim
> based on "this bucket of the dcache has twenty entries in it" would
> probably work quite well.

That might work for this cache, but it's not a generic solution to
fragmentation caused by cache positions building in the absence of
memory pressure.

> > Our levels of internal fragmentation are historically low, which of
> > course is nice by itself. But that's also what's causing problems in
> > the form of external fragmentation, and why we struggle to produce 2M
> > blocks. It's multitudes easier to free one 2M slab page of
> > consecutively allocated inodes than it is to free 512 batches of
> > different objects with conflicting lifetimes, ages, or potentially
> > even reclaimability.
> 
> Unf.  I don't think freeing 2MB worth of _anything_ is ever going to be
> easy enough to rely on.  My actual root filesystem:
> 
> xfs_inode         143134 144460   1024   32    8 : tunables    0    0    0 : slabdata   4517   4517      0
> 
> So we'd have to be able to free 2048 of those 143k inodes, and they all
> have to be consecutive (and aligned).  I suppose we could model that and
> try to work out how many we'd have to be able to free in order to get all
> 2048 in any page free, but I bet it's a variant of the Birthday Paradox,
> and we'd find it's something crazy like half of them.

How is it different than freeing a 4k page in 1995?

The descriptor size itself may not have scaled at the same rate as
overall memory size. But that also means the cache position itself is
much less a concern in terms of memory consumed and fragmented.

Case in point, this is 141M. Yes, probably with a mixture of some hot
and a long tail of cold entries. It's not really an interesting
reclaim target.

When slab cache positions become a reclaim concern, it's usually when
they spike due to a change in the workload. And then you tend to get
contiguous runs of objects with a similar age.

> Without slab gaining the ability to ask users to relocate allocations,
> I think any memory sent to slab is never coming back.

Not sure what data you're basing this on.

> So ... even if I accept every part of your vision as the way things
> are going to be, I think the folio patchset I have now is a step in the
> right direction.  I'm going to send a v6 now and hope it's not too late
> for this merge window.

I don't think folio as an abstraction is cooked enough to replace such
a major part of the kernel with it. so I'm against merging it now.

I would really like to see a better definition of what it actually
represents, instead of a fluid combination of implementation details
and conveniences.
