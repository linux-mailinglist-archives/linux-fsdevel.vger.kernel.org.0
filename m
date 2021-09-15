Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9172440CC06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhIOR4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 13:56:25 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33294 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhIOR4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:56:24 -0400
Received: by mail-wr1-f46.google.com with SMTP id t18so5280409wrb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 10:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EmDG0wBX8eiDSOx5X4lVDdCTChXbSWXuxhuaSYB5sX8=;
        b=vmMMRgEML4XlJ61zEcdlI/X466455miNc8L6dV93k23Y9jC+RCGH5lKMCxRmG4LTnx
         rT46dib5J6JF84RshDg5dBAMWuzzISansRjIc4k/7UQTARNYFB3S4jTzHTrRBtJYjMxv
         JLDwC4VuGW6KIejRO18W9sfwk6tDDOBS7ySZUDMxIuVYQ/+eG7yNO1ZI6BvSEVGd58Bk
         llpJCd1Wt3QOqOwNg/QoOMM1o1O9dFJaj9tYK/UMD7Rr+dBqDqboY/Hf9j2btP0CRkzg
         iRgqYWdEUpfKy8ccqKQ0sRW7OiK+9kN9ghP2vj6zKbSWhJUcyN8ghTg1EMOXp3LV3Ncd
         4JIw==
X-Gm-Message-State: AOAM533I08g31Rvz9MrcPehyHKXSOCZp9mtvuwb7Pxgdhd/oL2Rj7bWa
        7smY6pZPJkarPxq8Ozbo4aXlhA==
X-Google-Smtp-Source: ABdhPJxEHL5qn1sYpNbENbccZFQQ7lHF7hLtIMCMwyOh/EB7aIVnB4n2WCLxfWw0Ag7/DrILCyaoXg==
X-Received: by 2002:adf:ee49:: with SMTP id w9mr1433829wro.158.1631728504173;
        Wed, 15 Sep 2021 10:55:04 -0700 (PDT)
Received: from fedora.tometzki.de (p200300e68f0105009e5bc999bd8eb7e0.dip0.t-ipconnect.de. [2003:e6:8f01:500:9e5b:c999:bd8e:b7e0])
        by smtp.gmail.com with ESMTPSA id c9sm732906wrf.77.2021.09.15.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 10:55:03 -0700 (PDT)
Date:   Wed, 15 Sep 2021 19:55:01 +0200
From:   Damian Tometzki <dtometzki@fedoraproject.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUIzdTyFBITDIPnj@fedora.tometzki.de>
Reply-To: Damian Tometzki <dtometzki@fedoraproject.org>
Mail-Followup-To: Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUIT2/xXwvZ4IErc@cmpxchg.org>
User-Agent: Mutt
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello together,

I am an outsider and  following the discussion here on the subject. 
Can we not go upsream with the state of development ? 
Optimizations will always be there and new kernel releases too.

I can not assess the risk but I think a decision must be made. 

Damian
 

On Wed, 15. Sep 11:40, Johannes Weiner wrote:
> On Fri, Sep 10, 2021 at 04:16:28PM -0400, Kent Overstreet wrote:
> > One particularly noteworthy idea was having struct page refer to
> > multiple hardware pages, and using slab/slub for larger
> > alloctions. In my view, the primary reason for making this change
> > isn't the memory overhead to struct page (though reducing that would
> > be nice);
> 
> Don't underestimate this, however.
> 
> Picture the near future Willy describes, where we don't bump struct
> page size yet but serve most cache with compound huge pages.
> 
> On x86, it would mean that the average page cache entry has 512
> mapping pointers, 512 index members, 512 private pointers, 1024 LRU
> list pointers, 512 dirty flags, 512 writeback flags, 512 uptodate
> flags, 512 memcg pointers etc. - you get the idea.
> 
> This is a ton of memory. I think this doesn't get more traction
> because it's memory we've always allocated, and we're simply more
> sensitive to regressions than long-standing pain. But nevertheless
> this is a pretty low-hanging fruit.
> 
> The folio makes a great first step moving those into a separate data
> structure, opening the door to one day realizing these savings. Even
> when some MM folks say this was never the intent behind the patches, I
> think this is going to matter significantly, if not more so, later on.
> 
> > Fortunately, Matthew made a big step in the right direction by making folios a
> > new type. Right now, struct folio is not separately allocated - it's just
> > unionized/overlayed with struct page - but perhaps in the future they could be
> > separately allocated. I don't think that is a remotely realistic goal for _this_
> > patch series given the amount of code that touches struct page (thing: writeback
> > code, LRU list code, page fault handlers!) - but I think that's a goal we could
> > keep in mind going forward.
> 
> Yeah, agreed. Not doable out of the gate, but retaining the ability to
> allocate the "cache entry descriptor" bits - mapping, index etc. -
> on-demand would be a huge benefit down the road for the above reason.
> 
> For that they would have to be in - and stay in - their own type.
> 
> > We should also be clear on what _exactly_ folios are for, so they don't become
> > the new dumping ground for everyone to stash their crap. They're to be a new
> > core abstraction, and we should endeaver to keep our core data structures
> > _small_, and _simple_.
> 
> Right. struct page is a lot of things and anything but simple and
> obvious today. struct folio in its current state does a good job
> separating some of that stuff out.
> 
> However, when we think about *which* of the struct page mess the folio
> wants to address, I think that bias toward recent pain over much
> bigger long-standing pain strikes again.
> 
> The compound page proliferation is new, and we're sensitive to the
> ambiguity it created between head and tail pages. It's added some
> compound_head() in lower-level accessor functions that are not
> necessary for many contexts. The folio type safety will help clean
> that up, and this is great.
> 
> However, there is a much bigger, systematic type ambiguity in the MM
> world that we've just gotten used to over the years: anon vs file vs
> shmem vs slab vs ...
> 
> - Many places rely on context to say "if we get here, it must be
>   anon/file", and then unsafely access overloaded member elements:
>   page->mapping, PG_readahead, PG_swapcache, PG_private
> 
> - On the other hand, we also have low-level accessor functions that
>   disambiguate the type and impose checks on contexts that may or may
>   not actually need them - not unlike compound_head() in PageActive():
> 
>   struct address_space *folio_mapping(struct folio *folio)
>   {
> 	struct address_space *mapping;
> 
> 	/* This happens if someone calls flush_dcache_page on slab page */
> 	if (unlikely(folio_test_slab(folio)))
> 		return NULL;
> 
> 	if (unlikely(folio_test_swapcache(folio)))
> 		return swap_address_space(folio_swap_entry(folio));
> 
> 	mapping = folio->mapping;
> 	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
> 		return NULL;
> 
> 	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
>   }
> 
>   Then we go identify places that say "we know it's at least not a
>   slab page!" and convert them to page_mapping_file() which IS safe to
>   use with anon. Or we say "we know this MUST be a file page" and just
>   access the (unsafe) mapping pointer directly.
> 
> - We have a singular page lock, but what it guards depends on what
>   type of page we're dealing with. For a cache page it protects
>   uptodate and the mapping. For an anon page it protects swap state.
> 
>   A lot of us can remember the rules if we try, but the code doesn't
>   help and it gets really tricky when dealing with multiple types of
>   pages simultaneously. Even mature code like reclaim just serializes
>   the operation instead of protecting data - the writeback checks and
>   the page table reference tests don't seem to need page lock.
> 
>   When the cgroup folks wrote the initial memory controller, they just
>   added their own page-scope lock to protect page->memcg even though
>   the page lock would have covered what it needed.
> 
> - shrink_page_list() uses page_mapping() in the first half of the
>   function to tell whether the page is anon or file, but halfway
>   through we do this:
> 
> 	  /* Adding to swap updated mapping */
>           mapping = page_mapping(page);
> 
>   and then use PageAnon() to disambiguate the page type.
> 
> - At activate_locked:, we check PG_swapcache directly on the page and
>   rely on it doing the right thing for anon, file, and shmem pages.
>   But this flag is PG_owner_priv_1 and actually used by the filesystem
>   for something else. I guess PG_checked pages currently don't make it
>   this far in reclaim, or we'd crash somewhere in try_to_free_swap().
> 
>   I suppose we're also never calling page_mapping() on PageChecked
>   filesystem pages right now, because it would return a swap mapping
>   before testing whether this is a file page. You know, because shmem.
> 
> These are just a few examples from an MM perspective. I'm sure the FS
> folks have their own stories and examples about pitfalls in dealing
> with struct page members.
> 
> We're so used to this that we don't realize how much bigger and
> pervasive this lack of typing is than the compound page thing.
> 
> I'm not saying the compound page mess isn't worth fixing. It is.
> 
> I'm saying if we started with a file page or cache entry abstraction
> we'd solve not only the huge page cache, but also set us up for a MUCH
> more comprehensive cleanup in MM code and MM/FS interaction that makes
> the tailpage cleanup pale in comparison. For the same amount of churn,
> since folio would also touch all of these places.
> 
