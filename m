Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71D34ADD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCZRsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhCZRsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:48:17 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F5BC0613AA
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 10:48:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g15so6063282qkl.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rt7+HTA/2CLzV1i70E0AKartOxdm4iJIzlacuo9e8fY=;
        b=tGXVuHbQlvBi1jhyOHu69f2QNklihlivh/XOPBZz4AQkG8MDFhncUZz5QF71DBQ7TO
         oRhdNmCMJ7+fmed0OCX64AICovtDDWB62Dw495GxOiCs6zz69IEbDnarPNYeO3FLDUUe
         FlmIXUAmlzBYGZS4t37xypDYCIidtoUArCCUhO1awxe7pAN53tsby3RLqQWFSAVX5KXt
         QfaDVhJxtejSdYVg8DA4i0fBfXYB1udlC1MmjUEdSH3DKTNRdH7A/FBLQbQTguTGF2BM
         dsb2F77ihM4Q+8hM9f1VhT5LkPPOo+tPuZRyybslBIe79Qh0FbOih9HZagqj2dkPlTc+
         BCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rt7+HTA/2CLzV1i70E0AKartOxdm4iJIzlacuo9e8fY=;
        b=dtd8XDH4nqn5z6RlEX/vCXR5c9HDl3HX/PTA8jgMvEoQOJVLWuvQyqmiva/kxRDSC3
         P8EgHKbZ5+MdKXn5HrRNvPwMJ4x9Gp0pR6tbYVHQHbsLNDfeU6qUGr2bXwljmaMb5/t3
         NV/Nzli+XBirZJMln7CEwB+iJw6Kjryn+cp/PqfFSGomRqJeRjCUWNHDyZNtTcJrvla9
         I0AnRzWxgbb8wbICsyRORfYTkuUfpnXZ7hl7od0uH9P/tXOjoEnUDq1J4UQtuKpRimh7
         8C0NmP7PheTs8qIS0Y1zihdqXoleiBkR2WtFfnb5YYLyq9JyurppDSKZi537G3T1NTD/
         htoQ==
X-Gm-Message-State: AOAM531QSqFmuw7N3cNOIPL1xy5hxIcl6PJfeZEAjT72I+k+TScvEZMi
        H9UmY5aAc2zNUem5AYRFgwt+NA==
X-Google-Smtp-Source: ABdhPJxmYdPXJeXFGWC9Yo9XPOA0Y5gzi1Sfmmprpnrvf80Wcyq9D5Z4HGvVoeyScc4heSWNnly/fg==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr14326489qkk.402.1616780896593;
        Fri, 26 Mar 2021 10:48:16 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id r133sm7438957qke.20.2021.03.26.10.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:48:15 -0700 (PDT)
Date:   Fri, 26 Mar 2021 13:48:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <YF4eX/VBPLmontA+@cmpxchg.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324062421.GQ1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 06:24:21AM +0000, Matthew Wilcox wrote:
> On Tue, Mar 23, 2021 at 08:29:16PM -0400, Johannes Weiner wrote:
> > On Mon, Mar 22, 2021 at 06:47:44PM +0000, Matthew Wilcox wrote:
> > > On Mon, Mar 22, 2021 at 01:59:24PM -0400, Johannes Weiner wrote:
> One of the patches I haven't posted yet starts to try to deal with kmap()/mem*()/kunmap():
> 
>     mm: Add kmap_local_folio
>     
>     This allows us to map a portion of a folio.  Callers can only expect
>     to access up to the next page boundary.
>     
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 7902c7d8b55f..55a29c9d562f 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -73,6 +73,12 @@ static inline void *kmap_local_page(struct page *page)
>         return __kmap_local_page_prot(page, kmap_prot);
>  }
>  
> +static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> +{
> +       struct page *page = &folio->page + offset / PAGE_SIZE;
> +       return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
> +}
> 
> Partly I haven't shared that one because I'm not 100% sure that 'byte
> offset relative to start of folio' is the correct interface.  I'm looking
> at some users and thinking that maybe 'byte offset relative to start
> of file' might be better.  Or perhaps that's just filesystem-centric
> thinking.

Right, this doesn't seem specific to files just because they would be
the primary users of it.

> > But for that to work, we'll need the allocator to produce huge pages
> > at the necessary rate, too. The current implementation likely won't
> > scale. Compaction is expensive enough that we have to weigh when to
> > allocate huge pages for long-lived anon regions, let alone allocate
> > them for streaming IO cache entries.
> 
> Heh, I have that as a work item for later this year -- give the page
> allocator per-cpu lists of compound pages, not just order-0 pages.
> That'll save us turning compound pages back into buddy pages, only to
> turn them into compound pages again.
> 
> I also have a feeling that the page allocator either needs to become a
> sub-allocator of an allocator that deals in, say, 1GB chunks of memory,
> or it needs to become reluctant to break up larger orders.  eg if the
> dcache asks for just one more dentry, it should have to go through at
> least one round of reclaim before we choose to break up a high-order
> page to satisfy that request.

Slub already allocates higher-order pages for dentries:

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
dentry            133350 133350    192   42    2 : tunables    0    0    0 : slabdata   3175   3175      0

                                               ^ here

and it could avoid even more internal fragmentation with bigger
orders. It only doesn't because of the overhead of allocating them.

If the default block size in the allocator were 2M, we'd also get slab
packing at that granularity, and we wouldn't have to worry about small
objects breaking huge pages any more than we worry about slab objects
fragmenting 4k pages today.

> > But if the overwhelming number of requests going to the page allocator
> > are larger than 4k pages - anon regions? check. page cache? likely a
> > sizable share. slub? check. network? check - does it even make sense
> > to have that as the default block size for the page allocator anymore?
> > Or even allocate struct page at this granularity?
> 
> Yep, others have talked about that as well.  I think I may even have said
> a few times at LSFMM, "What if we just make PAGE_SIZE 2MB?".  After all,
> my first 386 Linux system was 4-8MB of RAM (it got upgraded).  The 16GB
> laptop that I now have is 2048 times more RAM, so 4x the number of pages
> that system had.
> 
> But people seem attached to being able to use smaller page sizes.
> There's that pesky "compatibility" argument.

Right, that's why I'm NOT saying we should eliminate the support for
4k chunks in the page cache and page tables. That's still useful if
you have lots of small files.

I'm just saying it doesn't have to be the default that everything is
primarily optimized for. We can make the default allocation size of
the allocator correspond to a hugepage and have a secondary allocator
level for 4k chunks. Like slab, but fixed-size and highmem-aware.

It makes sense to make struct page 2M as well. It would save a ton of
memory on average and reduce the pressure we have on struct page's
size today.

And we really don't need struct page at 4k just to support this unit
of paging when necesary: page tables don't care, they use pfns and can
point to any 4k offset, struct page or no struct page. For the page
cache, we can move mapping, index, lru. etc from today's struct page
into an entry descriptor that could either sit in a native 2M struct
page (just like today), or be be allocated on demand and point into a
chunked struct page. Same for <2M anonymous mappings.

Hey, didn't you just move EXACTLY those fields into the folio? ;)

All this to reiterate, I really do agree with the concept of a new
type of object for paging, page cache entries, etc. But I think there
are good reasons to assume that this unit of paging needs to support
sizes smaller than the standard page size used by the kernel at large,
and so 'bundle of pages' is not a good way of defining it.

It can easily cause problems down the line again if people continue to
assume that there is at least one PAGE_SIZE struct page in a folio.

And it's not obvious to me why it really NEEDS to be 'bundle of pages'
instead of just 'chunk of memory'.

> > So I think transitioning away from ye olde page is a great idea. I
> > wonder this: have we mapped out the near future of the VM enough to
> > say that the folio is the right abstraction?
> > 
> > What does 'folio' mean when it corresponds to either a single page or
> > some slab-type object with no dedicated page?
> > 
> > If we go through with all the churn now anyway, IMO it makes at least
> > sense to ditch all association and conceptual proximity to the
> > hardware page or collections thereof. Simply say it's some length of
> > memory, and keep thing-to-page translations out of the public API from
> > the start. I mean, is there a good reason to keep this baggage?
> > 
> > mem_t or something.
> > 
> > mem = find_get_mem(mapping, offset);
> > p = kmap(mem, offset - mem_file_offset(mem), len);
> > copy_from_user(p, buf, len);
> > kunmap(mem);
> > SetMemDirty(mem);
> > put_mem(mem);
> 
> I think there's still value to the "new thing" being a power of two
> in size.  I'm not sure you were suggesting otherwise, but it's worth
> putting on the table as something we explicitly agree on (or not!)

Ha, I wasn't thinking about minimum alignment. I used the byte offsets
because I figured that's what's natural to the fs and saw no reason to
have it think in terms of page size in this example.

From an implementation pov, since anything in the page cache can end
up in a page table, it probably doesn't make a whole lot of sense to
allow quantities smaller than the smallest unit of paging supported by
the processor. But I wonder if that's mostly something the MM would
care about when it allocates these objects, not necessarily something
that needs to be reflected in the interface or the filesystem.

The other point I was trying to make was just the alternate name. As I
said above, I think 'bundle of pages' as a concept is a strategic
error that will probably come back to haunt us.

I also have to admit, I really hate the name. We may want to stop
people thinking of PAGE_SIZE, but this term doesn't give people any
clue WHAT to think of. Ten years down the line, when the possible
confusion between folio and page and PAGE_SIZE has been eradicated,
people still will have to google what a folio is, and then have a hard
time retaining a mental image. I *know* what it is and I still have a
hard time reading code that uses it.

That's why I drafted around with the above code, to see if it would go
down easier. I think it does. It's simple, self-explanatory, but
abstract enough as to not make assumptions around its implementation.
Filesystem look up cache memory, write data in it, mark memory dirty.

Maybe folio makes more sense to native speakers, but I have never
heard this term. Of course when you look it up, it's "something to do
with pages" :D

As a strategy to unseat the obsolete mental model around pages, IMO
redirection would be preferable to confusion.

> > There are 10k instances of 'page' in mm/ outside the page allocator, a
> > majority of which will be the new thing. 14k in fs. I don't think I
> > have the strength to type shrink_folio_list(), or explain to new
> > people what it means, years after it has stopped making sense.
> 
> One of the things I don't like about the current iteration of folio
> is that getting to things is folio->page.mapping.  I think it does want
> to be folio->mapping, and I'm playing around with this:
> 
>  struct folio {
> -       struct page page;
> +       union {
> +               struct page page;
> +               struct {
> +                       unsigned long flags;
> +                       struct list_head lru;
> +                       struct address_space *mapping;
> +                       pgoff_t index;
> +                       unsigned long private;
> +                       atomic_t _mapcount;
> +                       atomic_t _refcount;
> +               };
> +       };
>  };
> 
> +static inline void folio_build_bug(void)
> +{
> +#define FOLIO_MATCH(pg, fl)                                            \
> +BUILD_BUG_ON(offsetof(struct page, pg) != offsetof(struct folio, fl));
> +
> +       FOLIO_MATCH(flags, flags);
> +       FOLIO_MATCH(lru, lru);
> +       FOLIO_MATCH(mapping, mapping);
> +       FOLIO_MATCH(index, index);
> +       FOLIO_MATCH(private, private);
> +       FOLIO_MATCH(_mapcount, _mapcount);
> +       FOLIO_MATCH(_refcount, _refcount);
> +#undef FOLIO_MATCH
> +       BUILD_BUG_ON(sizeof(struct page) != sizeof(struct folio));
> +}
> 
> with the intent of eventually renaming page->mapping to page->__mapping
> so people can't look at page->mapping on a tail page.  If we even have
> tail pages eventually.  I could see a future where we have pte_to_pfn(),
> pfn_to_folio() and are completely page-free (... the vm_fault would
> presumably return a pfn instead of a page at that point ...).  But that's
> too ambitious a project to succeed any time soon.
>
> There's a lot of transitional stuff in these patches where I do
> &folio->page.  I cringe a little every time I write that.

Instead of the union in there, could you do this?

	struct thing {
		struct address_space *mapping;
		pgoff_t index;
		...
	};

	struct page {
		union {
			struct thing thing;
			...
		}
	}

and use container_of() to get to the page in those places?

> So yes, let's ask the question of "Is this the right short term, medium
> term or long term approach?"  I think it is, at least in broad strokes.
> Let's keep refining it.

Yes, yes, and yes. :)
