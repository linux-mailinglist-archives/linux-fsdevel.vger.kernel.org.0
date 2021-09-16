Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3949C40E9F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345412AbhIPSg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbhIPSgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:36:52 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8992CC0C1313
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 09:52:27 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t4so8419440qkb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HAG5t8Z6ZEmVnImWD/owvbZJjgcyGUf+8Wn6GyvNoFM=;
        b=VTqVNNm2O8pJO4b3NHdXPRmem/Wt3z9n05yAcxx2qvOhfmrice3etnyU90GK+x0FNi
         lo+88o2dANmif0jii33+xmrRuxiM2W+AHeBMiU/jZ59ZHZ9TUL6lCdM9XXS81/xs3qJm
         XCaQ3nILmL8d1SocJo5KVdak5tD68p4wUT5zzkVxGRH6v0KegaXBBjs6bvlROKfPYqJU
         oxpxthvG84THdz0GjYcvyI2+kydMmH3T60xOSadb5kgDzRwOgHxFyi8YzBj6epMjC4OY
         pKfE/uzSHV2azFiA0aFAeQcvBgBzjkd9N+l7A8isjX2+TjrDI/kBaWwHaLyaJjhTnHRZ
         CU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HAG5t8Z6ZEmVnImWD/owvbZJjgcyGUf+8Wn6GyvNoFM=;
        b=CNVMyVnZgE5rkjKVNPm82Yqq64EZXCXR+FEeePet5C8LcCgN/iEvTJQTDVxmOoTu5F
         a6NJ+fQgXywH/nqLpoeFFzOJR+7dBajXHpjLiTsNKzE4mkNppbmFhCx+ggZ5bxyAop53
         FsdmZnQFKnbA1OTRKJ7T5fIOeGP/PiQ6WgEviK829TwXjykVI/2XOWprlk2VgaZWURC0
         73K8ZQFNwRujVUv/v2Hohc+Eopfn/JxxSSOa51mKKAm60OS/c77SheT2RYO7Fsm1TtQQ
         NFE8TEYSFLB9SQEhYfhjAbj4cHS6BrgYcolu6dfBwISPBuk/DUWHJR3mRCP5MhR1wjl+
         8J2g==
X-Gm-Message-State: AOAM53033Z2hN6gN6rgLpTM1plZK/BXe22beqxMNL/7nZUoCa7myIm0R
        rVyW32QAvgdbD2irXnqW5jMozA==
X-Google-Smtp-Source: ABdhPJz7oneNVTKwE4NCpHHvSfKLXdSijXEUphoFdTu4KBPlwqFlhcpi1NFmxR67Yj6eyAq5yD62Zg==
X-Received: by 2002:a05:620a:110d:: with SMTP id o13mr6065351qkk.108.1631811146475;
        Thu, 16 Sep 2021 09:52:26 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id c193sm2932863qkg.120.2021.09.16.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:52:25 -0700 (PDT)
Date:   Thu, 16 Sep 2021 12:54:22 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUN2vokEM8wgASk8@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916025854.GE34899@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 07:58:54PM -0700, Darrick J. Wong wrote:
> On Wed, Sep 15, 2021 at 11:40:11AM -0400, Johannes Weiner wrote:
> > On Fri, Sep 10, 2021 at 04:16:28PM -0400, Kent Overstreet wrote:
> > > One particularly noteworthy idea was having struct page refer to
> > > multiple hardware pages, and using slab/slub for larger
> > > alloctions. In my view, the primary reason for making this change
> > > isn't the memory overhead to struct page (though reducing that would
> > > be nice);
> > 
> > Don't underestimate this, however.
> > 
> > Picture the near future Willy describes, where we don't bump struct
> > page size yet but serve most cache with compound huge pages.
> > 
> > On x86, it would mean that the average page cache entry has 512
> > mapping pointers, 512 index members, 512 private pointers, 1024 LRU
> > list pointers, 512 dirty flags, 512 writeback flags, 512 uptodate
> > flags, 512 memcg pointers etc. - you get the idea.
> > 
> > This is a ton of memory. I think this doesn't get more traction
> > because it's memory we've always allocated, and we're simply more
> > sensitive to regressions than long-standing pain. But nevertheless
> > this is a pretty low-hanging fruit.
> > 
> > The folio makes a great first step moving those into a separate data
> > structure, opening the door to one day realizing these savings. Even
> > when some MM folks say this was never the intent behind the patches, I
> > think this is going to matter significantly, if not more so, later on.
> 
> So ... I chatted with Kent the other day, who suggested to me that maybe
> the point you're really after is that you want to increase the hw page
> size to reduce overhead while retaining the ability to hand out parts of
> those larger pages to the page cache, and folios don't get us there?

Yes, that's one of the points.

It's exporting the huge page model we've been using for anonymous
memory to the filesystems, even though that model has shown
significant limitations in practice: it doesn't work well out of the
box, the necessary configuration is painful and complicated, and even
when done correctly it still has high allocation latencies. It's much
more "handtuned HPC workload" than "general purpose feature".

Fixing this is an open problem. I don't know for sure if we need to
increase the page size for that, but neither does anybody else. This
is simply work and experiments that haven't been done on the MM side.

Exposing the filesystems to that implementation now exposes them to
the risk of a near-term do-over, and puts a significantly higher
barrier on fixing the allocation model down the line.

There isn't a technical reason for this coupling the filesystems that
tightly to the allocation model. It's just that the filesystem people
would like a size-agnostic cache object, and some MM folks would like
to clean up the compound page mess, and folio tries to do both of
these things at once.

> > > Fortunately, Matthew made a big step in the right direction by making folios a
> > > new type. Right now, struct folio is not separately allocated - it's just
> > > unionized/overlayed with struct page - but perhaps in the future they could be
> > > separately allocated. I don't think that is a remotely realistic goal for _this_
> > > patch series given the amount of code that touches struct page (thing: writeback
> > > code, LRU list code, page fault handlers!) - but I think that's a goal we could
> > > keep in mind going forward.
> > 
> > Yeah, agreed. Not doable out of the gate, but retaining the ability to
> > allocate the "cache entry descriptor" bits - mapping, index etc. -
> > on-demand would be a huge benefit down the road for the above reason.
> > 
> > For that they would have to be in - and stay in - their own type.
> > 
> > > We should also be clear on what _exactly_ folios are for, so they don't become
> > > the new dumping ground for everyone to stash their crap. They're to be a new
> > > core abstraction, and we should endeaver to keep our core data structures
> > > _small_, and _simple_.
> > 
> > Right. struct page is a lot of things and anything but simple and
> > obvious today. struct folio in its current state does a good job
> > separating some of that stuff out.
> > 
> > However, when we think about *which* of the struct page mess the folio
> > wants to address, I think that bias toward recent pain over much
> > bigger long-standing pain strikes again.
> > 
> > The compound page proliferation is new, and we're sensitive to the
> > ambiguity it created between head and tail pages. It's added some
> > compound_head() in lower-level accessor functions that are not
> > necessary for many contexts. The folio type safety will help clean
> > that up, and this is great.
> > 
> > However, there is a much bigger, systematic type ambiguity in the MM
> > world that we've just gotten used to over the years: anon vs file vs
> > shmem vs slab vs ...
> > 
> > - Many places rely on context to say "if we get here, it must be
> >   anon/file", and then unsafely access overloaded member elements:
> >   page->mapping, PG_readahead, PG_swapcache, PG_private
> > 
> > - On the other hand, we also have low-level accessor functions that
> >   disambiguate the type and impose checks on contexts that may or may
> >   not actually need them - not unlike compound_head() in PageActive():
> > 
> >   struct address_space *folio_mapping(struct folio *folio)
> >   {
> > 	struct address_space *mapping;
> > 
> > 	/* This happens if someone calls flush_dcache_page on slab page */
> > 	if (unlikely(folio_test_slab(folio)))
> > 		return NULL;
> > 
> > 	if (unlikely(folio_test_swapcache(folio)))
> > 		return swap_address_space(folio_swap_entry(folio));
> > 
> > 	mapping = folio->mapping;
> > 	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
> > 		return NULL;
> > 
> > 	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
> >   }
> > 
> >   Then we go identify places that say "we know it's at least not a
> >   slab page!" and convert them to page_mapping_file() which IS safe to
> >   use with anon. Or we say "we know this MUST be a file page" and just
> >   access the (unsafe) mapping pointer directly.
> > 
> > - We have a singular page lock, but what it guards depends on what
> >   type of page we're dealing with. For a cache page it protects
> >   uptodate and the mapping. For an anon page it protects swap state.
> > 
> >   A lot of us can remember the rules if we try, but the code doesn't
> >   help and it gets really tricky when dealing with multiple types of
> >   pages simultaneously. Even mature code like reclaim just serializes
> >   the operation instead of protecting data - the writeback checks and
> >   the page table reference tests don't seem to need page lock.
> > 
> >   When the cgroup folks wrote the initial memory controller, they just
> >   added their own page-scope lock to protect page->memcg even though
> >   the page lock would have covered what it needed.
> > 
> > - shrink_page_list() uses page_mapping() in the first half of the
> >   function to tell whether the page is anon or file, but halfway
> >   through we do this:
> > 
> > 	  /* Adding to swap updated mapping */
> >           mapping = page_mapping(page);
> > 
> >   and then use PageAnon() to disambiguate the page type.
> > 
> > - At activate_locked:, we check PG_swapcache directly on the page and
> >   rely on it doing the right thing for anon, file, and shmem pages.
> >   But this flag is PG_owner_priv_1 and actually used by the filesystem
> >   for something else. I guess PG_checked pages currently don't make it
> >   this far in reclaim, or we'd crash somewhere in try_to_free_swap().
> > 
> >   I suppose we're also never calling page_mapping() on PageChecked
> >   filesystem pages right now, because it would return a swap mapping
> >   before testing whether this is a file page. You know, because shmem.
> 
> (Yes, it would be helpful to fix these ambiguities, because I feel like
> discussions about all these other non-pagecache uses of memory keep
> coming up on fsdevel and the code /really/ doesn't help me figure out
> what everyone's talking about before the discussion moves on...)

Excellent.

However, after listening to Kent and other filesystem folks, I think
it's important to point out that the folio is not a dedicated page
cache page descriptor that will address any of the above examples.

The MM POV (and the justification for both the acks and the naks of
the patchset) is that it's a generic, untyped compound page
abstraction, which applies to file, anon, slab, networking
pages. Certainly, the folio patches as of right now also convert anon
page handling to the folio. If followed to its conclusion, the folio
will have plenty of members and API functions for non-pagecache users
and look pretty much like struct page today, just with a dynamic size.

I know Kent was surprised by this. I know Dave Chinner suggested to
call it "cache page" or "cage" early on, which also suggests an
understanding of a *dedicated* cache page descriptor.

I don't think the ambiguous folio name and the ambiguous union with
the page helped in any way in aligning fs and mm folks on what this
thing is actually supposed to be!

I agree with what I think the filesystems want: instead of an untyped,
variable-sized block of memory, I think we should have a typed page
cache desciptor.

That would work better for the filesystems, and I think would also
work better for the MM code down the line and fix the above examples.

The headpage/tailpage cleanup would come free with that.

> > These are just a few examples from an MM perspective. I'm sure the FS
> > folks have their own stories and examples about pitfalls in dealing
> > with struct page members.
> 
> We do, and I thought we were making good progress pushing a lot of that
> into the fs/iomap/ library.  With fs iomap, disk filesystems pass space
> mapping data to the iomap functions and let them deal with pages (or
> folios).  IOWs, filesystems don't deal with pages directly anymore, and
> folios sounded like an easy transition (for a filesystem) to whatever
> comes next.  At some point it would be nice to get fscrypt and fsverify
> hooked up so that we could move ext4 further off of buffer heads.
> 
> I don't know how we proceed from here -- there's quite a bit of
> filesystems work that depended on the folios series actually landing.
> Given that Linus has neither pulled it, rejected it, or told willy what
> to do, and the folio series now has a NAK on it, I can't even start on
> how to proceed from here.

I think divide and conquer is the way forward.

The crux of the matter is that folio is trying to 1) replace struct
page as the filesystem interface to the MM and 2) replace struct page
as the internal management object for file and anon, and conceptually
also slab & networking pages all at the same time.

As you can guess, goals 1) and 2) have vastly different scopes.

Replacing struct page in the filesystem isn't very controversial, and
filesystem folks seem uniformly ready to go. I agree.

Replacing struct page in MM code is much less clear cut. We have some
people who say it'll be great, some people who say we can probably
figure out open questions down the line, and we have some people who
have expressed doubts that all this churn will ever be worth it. I
think it's worth replacing, but not with an untyped compound thing.

It's sh*tty that the filesystem people are acutely blocked on
large-scope, long-term MM discussions they don't care about.

It's also sh*tty that these MM discussions are rushed by folks who
aren't familiar with or care too much about the MM internals.

This friction isn't necessary. The folio conversion is an incremental
process. It's not like everything in MM code has been fully converted
already - some stuff deals with the folio, most stuff with the page.

An easy way forward that I see is to split this large, open-ended
project into more digestible pieces. E.g. separate 1) and 2): merge a
"size-agnostic cache page" type now; give MM folks the time they need
to figure out how and if they want to replace struct page internally.

That's why I suggested to drop the anon page conversion bits in
swap.c, workingset.c, memcontrol.c etc, and just focus on the
uncontroversial page cache bits for now.
