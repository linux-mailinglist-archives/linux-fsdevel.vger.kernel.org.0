Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E63413AEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhIUTrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhIUTq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:46:58 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2742C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 12:45:29 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a14so403106qvb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P2hKmqMNICJwJyh1tO1otHne+fYy7MxE4cSSZC9424M=;
        b=yHL9t8dBl+W232Ka9BmRxn8xqfpjDWEUy2RLMqu4cD8h1HGOyxipU7OdjzSUsOTvOh
         EeY+vEAC1WnTCOPuR/u8qU9LXTqJRnkgD0rwrCofRUHmyuAZrSkvdLQgTFDda2XILX/W
         X6clX+/l56NUc/8nY2ufoUeYyNonDjaYuGvVMojK4+loULtOECzxaFKfZLwZxzaNbvOx
         2QGPmPAfCGIRPG6EZvMNTdxDJJePSNcOHOJesfrITIfddMdfZc5QhmFLMTvWTcQe0L8Q
         qKot7nKnxqy6fL8++3alQPt/pgvJLry4GYieFHAzvwVMo3+77KVvfMnDxT6UmiNgMjdz
         2FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P2hKmqMNICJwJyh1tO1otHne+fYy7MxE4cSSZC9424M=;
        b=aDEtVBHzteeOmEEqTpORJChTnphodon4GcYMqUpCJD8TsZqCINDDQ8S8UviODPpUep
         F7O5DNibaoEJoCkzyW4XDi7wxh3qTcOKRGykGg+qyMcvG2dmoMZ8AomI392r43RE4sBH
         IK/hsDe3YaPhW4LQwBgF4udgi1eD8kgjliPL6xbt/np02FfDzAtw4oCkikiBjAnzHsoC
         H6a1H1mzOkfGKhXu9FioRZVfJ/WJ97dHk3B9RU6Ut0xQt8rSfjAHP30emXSYrf01d5k3
         6el55HsQZYxN0vSZZxy948yvzrrDOhu3REPwUTVpvLAPRz+39suq436znS5FCerWG0Lc
         4rAA==
X-Gm-Message-State: AOAM531n/ahatwZGwNP07YzW+P1v21ndjSr9zm714a2BfIJagoHJXYOo
        TuEnwgOcv9Pr0mjSzOL8yXoRKw==
X-Google-Smtp-Source: ABdhPJz+bInVP0iEiev9C6j+xKFeGElydsdCkEEIqZMerZU8HbM1KHRbndTjuYpHMP9b5NRAjiKjmQ==
X-Received: by 2002:a0c:f10b:: with SMTP id i11mr32469556qvl.67.1632253528873;
        Tue, 21 Sep 2021 12:45:28 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id p9sm6384101qkm.23.2021.09.21.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:45:28 -0700 (PDT)
Date:   Tue, 21 Sep 2021 15:47:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUo20TzAlqz8Tceg@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUfvK3h8w+MmirDF@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just a note upfront:

This discussion is now about whether folio are suitable for anon pages
as well. I'd like to reiterate that regardless of the outcome of this
discussion I think we should probably move ahead with the page cache
bits, since people are specifically blocked on those and there is no
dependency on the anon stuff, as the conversion is incremental.

On Mon, Sep 20, 2021 at 03:17:15AM +0100, Matthew Wilcox wrote:
> I don't believe it is realistic to disentangle file pages and anon
> pages from each other.  Thanks to swap and shmem, both file pages and
> anon pages need to be able to be moved in and out of the swap cache.

Yes, the swapcache is actually shared code and needs a shared type.

However, once swap and shmem are fully operating on *typed* anon and
file pages, there are no possible routes of admission for tail pages
into the swapcache:

	vmscan:
	add_to_swap_cache(anon_page->page);

	shmem:
	delete_from_swap_cache(file_page->page);

and so the justification for replacing page with folio *below* those
entry points to address tailpage confusion becomes nil: there is no
confusion. Move the anon bits to anon_page and leave the shared bits
in page. That's 912 lines of swap_state.c we could mostly leave alone.

The same is true for the LRU code in swap.c. Conceptually, already no
tailpages *should* make it onto the LRU. Once the high-level page
instantiation functions - add_to_page_cache_lru, do_anonymous_page -
have type safety, you really do not need to worry about tail pages
deep in the LRU code. 1155 more lines of swap.c.

And when you've ensured that tail pages can't make it onto the LRU,
that takes care of the entire page reclaim code as well; converting it
wholesale to folio again would provide little additional value. 4707
lines of vmscan.c.

And with the page instantiation functions typed, nobody can pass tail
pages into memcg charging code, either. 7509 lines of memcontrol.c.

But back to your generic swapcache example: beyond the swapcache and
the page LRU management, there really isn't a great deal of code that
is currently truly type-agnostic and generic like that. And the rest
could actually benefit from being typed more tightly to bring out what
is actually going on.

The anon_page->page relationship may look familiar too. It's a natural
type hierarchy between superclass and subclasses that is common in
object oriented languages: page has attributes and methods that are
generic and shared; anon_page and file_page encode where their
implementation differs.

A type system like that would set us up for a lot of clarification and
generalization of the MM code. For example it would immediately
highlight when "generic" code is trying to access type-specific stuff
that maybe it shouldn't, and thus help/force us refactor - something
that a shared, flat folio type would not.

And again, higher-level types would take care of the tail page
confusion in many (most?) places automatically.

> The swap cache shares a lot of code with the page cache, so changing
> how the swap cache works is also tricky.

The overlap is actually fairly small right now. Add and delete
routines are using the raw xarray functions. Lookups use the most
minimal version of find_get_page(), which wouldn't be a big deal to
open-code until swapcache and pagecache would *actually* be unified.

> What I do believe is possible is something Kent hinted at; treating
> anon pages more like file pages.  I also believe that shmem should
> be able to write pages to swap without moving the pages into the
> swap cache first.  But these two things are just beliefs.  I haven't
> tried to verify them and they may come to nothing.

Treating anon and file pages the same where possible makes sense. It's
simple: the more code that can be made truly generic and be shared
between subclasses, the better.

However, for that we first have to identify what parts actually are
generic, and what parts are falsely shared and shoehorned into
equivalency due to being crammed into the same overloaded structure.

For example, page->mapping for file is an address_space and the page's
membership in that tree structure is protected by the page
lock. page->mapping for anon is... not that. The pointer itself is
ad-hoc typed to point to an anon_vma instead. And anon_vmas behave
completely differently from a page's pagecache state.

The *swapcache* state of an anon page is actually much closer to what
the pagecache state of a file page is. And since it would be nice to
share more of the swapcache and pagecache *implementation*, it makes
sense that the relevant page attributes would correspond as well.

(Yeah, page->mapping and page->index are used "the same way" for rmap,
but that's a much smaller, read-only case. And when you look at how
"generic" the rmap code is - with its foo_file and foo_anon functions,
and PageAnon() checks, and conditional page locking in the shared
bits-- the attribute sharing at the page level really did nothing to
help the implementation be more generic.)

It really should be something like:

	struct page {
		/* pagecache/swapcache state */
		struct address_space *address_space;
		pgoff_t index;
		lock_t lock;
	}

	struct file_page {
		struct page;
	}

	struct anon_page {
		struct page;
		struct anon_vma *anon_vma;
		pgoff_t offset;
	};

to recognize the difference in anon vs file rmapping and locking,
while recognizing the similarity between swapcache and pagecache.

A shared folio would perpetuate false equivalencies between anon and
file which make it difficult to actually split out and refactor what
*should* be generic vs what should be type-specific. And instead lead
to more "generic" code littered with FolioAnon() conditionals.

And in the name of tail page cleanup it would churn through thousands
of lines of code where there is no conceptual confusion about tail
pages to begin with.

Proper type inheritance would allow us to encode how things actually
are implemented right now and would be a great first step in
identifying what needs to be done in order to share more code.

And it would take care of so many places re: tail pages that it's a
legitimate question to ask: how many places would actually be *left*
that *need* to deal with tail pages? Couldn't we bubble
compound_head() and friends into these few select places and be done?

> I also want to split out slab_page and page_table_page from struct page.
> I don't intend to convert either of those to folios.
> 
> I do want to make struct page dynamically allocated (and have for
> a while).  There are some complicating factors ...
> 
> There are two primary places where we need to map from a physical
> address to a "memory descriptor".  The one that most people care about
> is get_user_pages().  We have a page table entry and need to increment
> the refcount on the head page, possibly mark the head page dirty, but
> also return the subpage of any compound page we find.  The one that far
> fewer people care about is memory-failure.c; we also need to find the
> head page to determine what kind of memory has been affected, but we
> need to mark the subpage as HWPoison.
> 
> Both of these need to be careful to not confuse tail and non-tail pages.

That makes sense.

But gup() as an interface to the rest of the kernel is rather strange:
It's not a generic page table walker that can take a callback argument
to deal with whatever the page table points to. It also doesn't return
properly typed objects: it returns struct page which is currently a
wildcard for whatever people cram into it.

> So yes, we need to use folios for anything that's mappable to userspace.
> That's not just anon & file pages but also network pools, graphics card
> memory and vmalloc memory.  Eventually, I think struct page actually goes
> down to a union of a few words of padding, along with ->compound_head.
> Because that's all we're guaranteed is actually there; everything else
> is only there in head pages.

(Side question: if GUP can return tail pages, how does that map to
folios?)

Anyway, I don't see that folio for everything mappable is the obvious
conclusion, because it doesn't address what is really weird about gup.

While a folio interface would clean up the head and tail page issue,
it maintains the incentive of cramming everything that people want to
mmap and gup into the same wildcard type struct. And still leave the
bigger problem of ad-hoc typing that wildcard ("What is the thing that
was returned? Anon? File? GPU memory?") to the user.

I think rather than cramming everything that can be mmapped into folio
for the purpose of GUP and tail pages - even when these objects have
otherwise little in common - it would make more sense to reconsider
how GUP as an interface deals with typing. Some options:

  a) Make it a higher-order function that leaves typing fully to the
     provided callback. This makes it clear (and greppable) which
     functions need to be wary about tail pages, and type inference in
     general.

  b) Create an intermediate mmap type that can map to one of the
     higher-order types like anon or file, but never to a tail
     page. This sounds like what you want struct page to be
     long-term. But this sort of depends on the side question above -
     what if pte maps tail page?

  c) Provide a stricter interface for known higher-order types
     (get_anon_pages...). Supporting new types means adding more entry
     function, which IMO is preferable to cramming more stuff into a
     wildcard struct folio.

  d) A hybrid of a) and c) to safely cover common cases, while
     allowing "i know what i'm doing" uses.

In summary, I think a page type hierarchy would do wonders to clean up
anon and file page implementations, and encourage and enable more code
sharing down the line, while taking care of tail pages as well.

This leaves the question how many places are actually *left* to deal
with tail pages in MM. Folios are based on the premise that the
confusion is simply everywhere, and that everything needs to be
converted first to be safe. This is convenient because it means we
never have to identify which parts truly *do* need tailpage handling,
truly *need* the compound_head() lookups. Yes, compound_head() has to
go from generic page flags testers. But as per the examples at the
top, I really don't think we need to convert every crevice of the MM
code to folio before we can be reasonably sure that removing it is
safe. I really want to to see a better ballpark analysis of what parts
need to deal with tail pages to justify all this churn for them.
