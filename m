Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC134F1A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 21:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhC3TbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhC3Ta6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:30:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5083C061762
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 12:30:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h7so12785245qtx.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 12:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=20kDy5UZRdPQvDESiNWyAM6Z280f/+mlZeZgw4ir/sI=;
        b=rRTa2dvjAV0nRztkMpK6cMgOf4+D0yjhNIBShOikR/9klsUDf20a81mfJczPq/GnGp
         wtAI+G/Ru83gD0iEixYnDQnvM1YHd6XUvctytVp0KosBl5MY0ajkUbhh12ezD0eShS+P
         va7P7C7lyW80SZcavUCip38v+ou5jyaGef9P+TOZWZrNqHM65O4qUlQJiSpr1/tzUF+X
         /rNys2GuiyDr4LgkziHvBq+E+8avfrlQWzvjJOIHbXxCJsI0bvqAZYOUkMnhwb9CEPr8
         kYgFHoxkQiXPHvq5VS1nGObhp2SrJZeVRo0UP+Ul2CBBxhTyA42kwYF2TuNxrHs3KNFd
         iJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=20kDy5UZRdPQvDESiNWyAM6Z280f/+mlZeZgw4ir/sI=;
        b=DgrsHi/qnLJiRtYqBKQquPtIammCUCNR7nG/Wh6nwXBbzbXT176fBUSrZm+gpQCm3X
         Au9Z9uijtrdOxI0tlzlF86zOJxf9Mf0dFKfxYGk6VBbUIIaXK+GWLIzVPIYu+7APkZAD
         fTm+hz9aOFOFvdhM/ZIGP7Qg1ee2g6eesE5t31qw5aRy3LjCciBtCMkzDfFZNfMnnFvs
         2FLz2spP7d0bEFFCQn8MU46g9ERr2ClIoHnezY1UvfOD46niFlBqhpOxmnfmUCQ8fVn2
         L+2FAIKGlXRjf452HsWvxyoOMoBogO3NPgReZ95XvDhKkCDggCo7pOyinTX9XGEU5U/C
         h6EQ==
X-Gm-Message-State: AOAM530FdgjOt6I7Y8XF32QzvrOBo8aBJsHmxMYoz491zTL6ut0GyRoi
        sYfM2XMg5sJBVSiLG9pHBr1TjA==
X-Google-Smtp-Source: ABdhPJyYkyYtAxFf+VxQm2wkcAMNl5H5nVDwndxqYz8rHa5nXNjpx9HGcCpc9hVSiF4PZbOutt+o9Q==
X-Received: by 2002:ac8:5913:: with SMTP id 19mr29248772qty.391.1617132656391;
        Tue, 30 Mar 2021 12:30:56 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c19sm15493595qkl.78.2021.03.30.12.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 12:30:55 -0700 (PDT)
Date:   Tue, 30 Mar 2021 15:30:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <YGN8biqigvPP0SGN@cmpxchg.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
 <YF4eX/VBPLmontA+@cmpxchg.org>
 <20210329165832.GG351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329165832.GG351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy,

On Mon, Mar 29, 2021 at 05:58:32PM +0100, Matthew Wilcox wrote:
> I'm going to respond to some points in detail below, but there are a
> couple of overarching themes that I want to bring out up here.
> 
> Grand Vision
> ~~~~~~~~~~~~
> 
> I haven't outlined my long-term plan.  Partly because it is a _very_
> long way off, and partly because I think what I'm doing stands on its
> own.  But some of the points below bear on this, so I'll do it now.
> 
> Eventually, I want to make struct page optional for allocations.  It's too
> small for some things (allocating page tables, for example), and overly
> large for others (allocating a 2MB page, networking page_pool).  I don't
> want to change its size in the meantime; having a struct page refer to
> PAGE_SIZE bytes is something that's quite deeply baked in.

Right, I think it's overloaded and it needs to go away from many
contexts it's used in today.

I think it describes a real physical thing, though, and won't go away
as a concept. More on that below.

> In broad strokes, I think that having a Power Of Two Allocator
> with Descriptor (POTAD) is a useful foundational allocator to have.
> The specific allocator that we call the buddy allocator is very clever for
> the 1990s, but touches too many cachelines to be good with today's CPUs.
> The generalisation of the buddy allocator to the POTAD lets us allocate
> smaller quantities (eg a 512 byte block) and allocate descriptors which
> differ in size from a struct page.  For an extreme example, see xfs_buf
> which is 360 bytes and is the descriptor for an allocation between 512
> and 65536 bytes.

I actually disagree with this rather strongly. If anything, the buddy
allocator has turned out to be a pretty poor fit for the foundational
allocator.

On paper, it is elegant and versatile in serving essentially arbitrary
memory blocks. In practice, we mostly just need 4k and 2M chunks from
it. And it sucks at the 2M ones because of the fragmentation caused by
the ungrouped 4k blocks.

The great thing about the slab allocator isn't just that it manages
internal fragmentation of the larger underlying blocks. It also groups
related objects by lifetime/age and reclaimability, which dramatically
mitigates the external fragmentation of the memory space.

The buddy allocator on the other hand has no idea what you want that
4k block for, and whether it pairs up well with the 4k block it just
handed to somebody else. But the decision it makes in that moment is
crucial for its ability to serve larger blocks later on.

We do some mobility grouping based on how reclaimable or migratable
the memory is, but it's not the full answer.

A variable size allocator without object type grouping will always
have difficulties producing anything but the smallest block size after
some uptime. It's inherently flawed that way.

What HAS proven itself is having the base block size correspond to a
reasonable transaction unit for paging and page reclaim, then fill in
smaller ranges with lifetime-aware slabbing, larger ranges with
vmalloc and SG schemes, and absurdly large requests with CMA.

We might be stuck with serving order-1, order-2 etc. for a little
while longer for the few users who can't go to kvmalloc(), but IMO
it's the wrong direction to expand into.

Optimally the foundational allocator would just do one block size.

> There are times when we need to get from the physical address to
> the descriptor, eg memory-failure.c or get_user_pages().  This is the
> equivalent of phys_to_page(), and it's going to have to be a lookup tree.
> I think this is a role for the Maple Tree, but it's not ready yet.
> I don't know if it'll be fast enough for this case.  There's also the
> need (particularly for memory-failure) to determine exactly what kind
> of descriptor we're dealing with, and also its size.  Even its owner,
> so we can notify them of memory failure.

A tree could be more memory efficient in the long term, but for
starters a 2M page could have a

	struct smallpage *smallpages[512];

member that points to any allocated/mapped 4k descriptors. The page
table level would tell you what you're looking at: a pmd is simple, a
pte would map to a 4k pfn, whose upper bits identify a struct page
then a page flag would tell you whether we have a pte-mapped 2M page
or whether the lower pfn bits identify an offset in smallpages[].

It's one pointer for every 4k of RAM, which is a bit dumb, but not as
dumb as having an entire struct page for each of those ;)

> What I haven't touched on anywhere in this, is whether a folio is the
> descriptor for all POTA or whether it's specifically the page cache
> descriptor.  I like the idea of having separate descriptors for objects
> in the page cache from anonymous or other allocations.  But I'm not very
> familiar with the rmap code, and that wants to do things like manipulate
> the refcount on a descriptor without knowing whether it's a file or
> anon page.  Or neither (eg device driver memory mapped to userspace.
> Or vmalloc memory mapped to userspace.  Or ...)

The rmap code is all about the page type specifics, but once you get
into mmap, page reclaim, page migration, we're dealing with fully
fungible blocks of memory.

I do like the idea of using actual language typing for the different
things struct page can be today (fs page), but with a common type to
manage the fungible block of memory backing it (allocation state, LRU
& aging state, mmap state etc.)

New types for the former are an easier sell. We all agree that there
are too many details of the page - including the compound page
implementation detail - inside the cache library, fs code and drivers.

It's a slightly tougher sell to say that the core VM code itself
(outside the cache library) needs a tighter abstraction for the struct
page building block and the compound page structure. At least at this
time while we're still sorting out how it all may work down the line.
Certainly, we need something to describe fungible memory blocks:
either a struct page that can be 4k and 2M compound, or a new thing
that can be backed by a 2M struct page or a 4k struct smallpage. We
don't know yet, so I would table the new abstraction type for this.

I generally don't think we want a new type that does everything that
the overloaded struct page already does PLUS the compound
abstraction. Whatever name we pick for it, it'll always be difficult
to wrap your head around such a beast.

IMO starting with an explicit page cache descriptor that resolves to
struct page inside core VM code (and maybe ->fault) for now makes the
most sense: it greatly mitigates the PAGE_SIZE and tail page issue
right away, and it's not in conflict with, but rather helps work
toward, replacing the fungible memory unit behind it.

There isn't too much overlap or generic code between cache and anon
pages such that sharing a common descriptor would be a huge win (most
overlap is at the fungible memory block level, and the physical struct
page layout of course), so I don't think we should aim for a generic
abstraction for both.

As drivers go, I think there are slightly different requirements to
filesystems, too. For filesystems, when the VM can finally do it (and
the file range permits it), I assume we want to rather transparently
increase the unit of data transfer from 4k to 2M. Most drivers that
currently hardcode alloc_page() or PAGE_SIZE OTOH probably don't want
us to bump their allocation sizes.

There ARE instances where drivers allocate pages based on buffer_size
/ PAGE_SIZE and then interact with virtual memory. Those are true VM
objects that could grow transparently if PAGE_SIZE grows, and IMO they
should share the "fungible memory block" abstraction the VM uses.

But there are also many instances where PAGE_SIZE just means 4006 is a
good size for me, and struct page is useful for refcounting. Those
just shouldn't use whatever the VM or the cache layer are using and
stop putting additional burden on an already tricky abstraction.

> On Fri, Mar 26, 2021 at 01:48:15PM -0400, Johannes Weiner wrote:
> > On Wed, Mar 24, 2021 at 06:24:21AM +0000, Matthew Wilcox wrote:
> > > On Tue, Mar 23, 2021 at 08:29:16PM -0400, Johannes Weiner wrote:
> > > > On Mon, Mar 22, 2021 at 06:47:44PM +0000, Matthew Wilcox wrote:
> > > > > On Mon, Mar 22, 2021 at 01:59:24PM -0400, Johannes Weiner wrote:
> > > One of the patches I haven't posted yet starts to try to deal with kmap()/mem*()/kunmap():
> > > 
> > >     mm: Add kmap_local_folio
> > >     
> > >     This allows us to map a portion of a folio.  Callers can only expect
> > >     to access up to the next page boundary.
> > >     
> > >     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > 
> > > diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> > > index 7902c7d8b55f..55a29c9d562f 100644
> > > --- a/include/linux/highmem-internal.h
> > > +++ b/include/linux/highmem-internal.h
> > > @@ -73,6 +73,12 @@ static inline void *kmap_local_page(struct page *page)
> > >         return __kmap_local_page_prot(page, kmap_prot);
> > >  }
> > >  
> > > +static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> > > +{
> > > +       struct page *page = &folio->page + offset / PAGE_SIZE;
> > > +       return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
> > > +}
> > > 
> > > Partly I haven't shared that one because I'm not 100% sure that 'byte
> > > offset relative to start of folio' is the correct interface.  I'm looking
> > > at some users and thinking that maybe 'byte offset relative to start
> > > of file' might be better.  Or perhaps that's just filesystem-centric
> > > thinking.
> > 
> > Right, this doesn't seem specific to files just because they would be
> > the primary users of it.
> 
> Yeah.  I think I forgot to cc you on this:
> 
> https://lore.kernel.org/linux-fsdevel/20210325032202.GS1719932@casper.infradead.org/
> 
> and "byte offset relative to the start of the folio" works just fine:
> 
> +	offset = offset_in_folio(folio, diter->pos);
> +
> +map:
> +	diter->entry = kmap_local_folio(folio, offset);

Yeah, that looks great to me!

> > > > But for that to work, we'll need the allocator to produce huge pages
> > > > at the necessary rate, too. The current implementation likely won't
> > > > scale. Compaction is expensive enough that we have to weigh when to
> > > > allocate huge pages for long-lived anon regions, let alone allocate
> > > > them for streaming IO cache entries.
> > > 
> > > Heh, I have that as a work item for later this year -- give the page
> > > allocator per-cpu lists of compound pages, not just order-0 pages.
> > > That'll save us turning compound pages back into buddy pages, only to
> > > turn them into compound pages again.
> > > 
> > > I also have a feeling that the page allocator either needs to become a
> > > sub-allocator of an allocator that deals in, say, 1GB chunks of memory,
> > > or it needs to become reluctant to break up larger orders.  eg if the
> > > dcache asks for just one more dentry, it should have to go through at
> > > least one round of reclaim before we choose to break up a high-order
> > > page to satisfy that request.
> > 
> > Slub already allocates higher-order pages for dentries:
> > 
> > slabinfo - version: 2.1
> > # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
> > dentry            133350 133350    192   42    2 : tunables    0    0    0 : slabdata   3175   3175      0
> > 
> >                                                ^ here
> > 
> > and it could avoid even more internal fragmentation with bigger
> > orders. It only doesn't because of the overhead of allocating them.
> 
> Oh, yes.  Sorry, I didn't explain myself properly.  If we have a
> lightly-loaded system with terabytes of memory (perhaps all the jobs
> it is running are CPU intensive and don't need much memory), the system
> has a tendency to clog up with negative dentries.  Hundreds of millions
> of them.  We rely on memory pressure to get rid of them, and when there
> finally is memory pressure, it takes literally hours.
> 
> If there were a slight amount of pressure to trim the dcache at the point
> when we'd otherwise break up an order-4 page to get an order-2 page,
> the system would work much better.  Obviously, we do want the dcache to
> be able to expand to the point where it's useful, but at the point that
> it's no longer useful, we need to trim it.
> 
> It'd probably be better to have the dcache realise that its old entries
> aren't useful any more and age them out instead of relying on memory
> pressure to remove old entries, so this is probably an unnecessary
> digression.

It's difficult to identify a universally acceptable line for
usefulness of caches other than physical memory pressure.

The good thing about the memory pressure threshold is that you KNOW
somebody else has immediate use for the memory, and you're justified
in recycling and reallocating caches from the cold end.

Without that, you'd either have to set an arbitrary size cutoff or an
arbitrary aging cutoff (not used in the last minute e.g.). But optimal
settings for either of those depend on the workload, and aren't very
intuitive to configure.

Such a large gap between the smallest object and the overall size of
memory is just inherently difficult to manage. More below.

> > If the default block size in the allocator were 2M, we'd also get slab
> > packing at that granularity, and we wouldn't have to worry about small
> > objects breaking huge pages any more than we worry about slab objects
> > fragmenting 4k pages today.
> 
> Yup.  I definitely see the attraction of letting the slab allocator
> allocate in larger units.  On the other hand, you have to start worrying
> about underutilisation of the memory at _some_ size, and I'd argue the
> sweet spot is somewhere between 4kB and 2MB today.  For example:
> 
> fat_inode_cache      110    110    744   22    4 : tunables    0    0    0 : slabdata      5      5      0
> 
> That's currently using 20 pages.  If slab were only allocating 2MB slabs
> from the page allocator, I'd have 1.9MB of ram unused in that cache.

Right, we'd raise internal fragmentation to a worst case of 2M (minus
minimum object size) per slab cache. As a ratio of overall memory,
this isn't unprecedented, though: my desktop machine has 32G and my
phone has 8G. Divide those by 512 for a 4k base page comparison and
you get memory sizes common in the mid to late 90s.

Our levels of internal fragmentation are historically low, which of
course is nice by itself. But that's also what's causing problems in
the form of external fragmentation, and why we struggle to produce 2M
blocks. It's multitudes easier to free one 2M slab page of
consecutively allocated inodes than it is to free 512 batches of
different objects with conflicting lifetimes, ages, or potentially
even reclaimability.

I don't think we'll have much of a choice when it comes to trading
some internal fragmentation to deal with our mounting external
fragmentation problem.

[ Because of the way fragmentation works I also don't think that 1G
  would be a good foundational block size. It either wastes a crazy
  amount of memory on internal fragmentation, or you allow external
  fragmentation and the big blocks deteriorate with uptime anyway.

  There really is such a thing as a page: a goldilocks quantity of
  memory, given the overall amount of RAM in a system, that is optimal
  as a paging unit and intersection point for the fragmentation axes.

  This never went away. It just isn't 4k anymore on modern systems.
  And we're creating a bit of a mess by adapting various places (page
  allocator, slab, page cache, swap code) to today's goldilocks size
  while struct page lags behind and doesn't track reality anymore.

  I think there is a lot of value in disconnecting places from struct
  page that don't need it, but IMO all in the context of the broader
  goal of being able to catch up struct page to what the real page is.

  We may be able to get rid of the 4k backward-compatible paging units
  eventually when we all have 1TB of RAM. But the concept of a page in
  a virtual memory system isn't really going anywhere. ]

> > > But people seem attached to being able to use smaller page sizes.
> > > There's that pesky "compatibility" argument.
> > 
> > Right, that's why I'm NOT saying we should eliminate the support for
> > 4k chunks in the page cache and page tables. That's still useful if
> > you have lots of small files.
> > 
> > I'm just saying it doesn't have to be the default that everything is
> > primarily optimized for. We can make the default allocation size of
> > the allocator correspond to a hugepage and have a secondary allocator
> > level for 4k chunks. Like slab, but fixed-size and highmem-aware.
> > 
> > It makes sense to make struct page 2M as well. It would save a ton of
> > memory on average and reduce the pressure we have on struct page's
> > size today.
> > 
> > And we really don't need struct page at 4k just to support this unit
> > of paging when necesary: page tables don't care, they use pfns and can
> > point to any 4k offset, struct page or no struct page. For the page
> > cache, we can move mapping, index, lru. etc from today's struct page
> > into an entry descriptor that could either sit in a native 2M struct
> > page (just like today), or be be allocated on demand and point into a
> > chunked struct page. Same for <2M anonymous mappings.
> > 
> > Hey, didn't you just move EXACTLY those fields into the folio? ;)
> 
> You say page tables don't actually need a struct page, but we do use it.
> 
>                 struct {        /* Page table pages */
>                         unsigned long _pt_pad_1;        /* compound_head */
>                         pgtable_t pmd_huge_pte; /* protected by page->ptl */
>                         unsigned long _pt_pad_2;        /* mapping */
>                         union {
>                                 struct mm_struct *pt_mm; /* x86 pgds only */
>                                 atomic_t pt_frag_refcount; /* powerpc */
>                         };
> #if ALLOC_SPLIT_PTLOCKS
>                         spinlock_t *ptl;
> #else
>                         spinlock_t ptl;
> #endif
>                 };
> 
> It's a problem because some architectures would really rather
> allocate 2KiB page tables (s390) or would like to support 4KiB page
> tables on a 64KiB base page size kernel (ppc).
> 
> [actually i misread your comment initially; you meant that page
> tables point to PFNs and don't care what struct backs them ... i'm
> leaving this in here because it illustrates a problem with change
> struct-page-size-to-2MB]

Yes, I meant what page table entries point to.

The page table (directories) themselves are still 4k as per the
architecture, and they'd also have to use smallpage descriptors.

I don't immediately see why they couldn't, though. It's not that many,
especially if pmd mappings are common (a 4k pmd can map 1G worth of
address space).
