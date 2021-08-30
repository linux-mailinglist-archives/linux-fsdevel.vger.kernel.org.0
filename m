Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4733FBD6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 22:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhH3U0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhH3U0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:26:12 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA7C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 13:25:18 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 14so17144827qkc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WEDPxaMsWJ5gP5fQ8qam5s8wdHZgTYnI4eKK6CIfTAo=;
        b=ApIeOltmzuoi/aa14OwPw1CExc2AvQyNaHG6txxC1YM0FYKiMMH3yf+DULo8LWfxUr
         6dy4hYt8s+wEbPgAOBPw+k2ZYmhhb5+a6a7cfb/eMV/hpkM74gyO9AcJWvPxmr6uFpFO
         z7DvDfKKcCByg2dDYZd2hSzuzKCPg+hSSdnSVhbag6iCIF7NiMVEnbE9Z2hhh0+N0wIJ
         rqIhc3JYnxEI2zy0NxW1mmRU7Yn3dlB8/dfyHevuLoikK0zMpcJ6A5XC2H/zMirpseSA
         XnG3vP+yXYQTEXWs8ugqjc3gZ8FlDm5DQwot6lXkoKh2Fu1vEjZ3B1brXveinSov8oa3
         x9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WEDPxaMsWJ5gP5fQ8qam5s8wdHZgTYnI4eKK6CIfTAo=;
        b=f5VaSIp+JfBz7ObyKyjneXRcd/UY0W4QD0BGl6DQDuHFEWv4iSQOza+a9CoWKCSjBu
         m0WS0YfHqot0BgOBc3RQrO8BOKb+lbJwzIXvQguX3kP26U6xVE5DGTMOpyf/OQt95MFg
         of143w8m5nCLUaXRLuv9LBT/qev7cGYnK/oi5XgBbb8NaZDnDurIRSK7trW99epWA1+z
         hUMZj1a7+ZfC1ySPhcTb6hC7pX1nFAa251jYocpkaN0PpPPbjpiZsoRkKT7TcIOj8KCc
         4ZbxCVTax5GGs+96dsWao8rH84TiAf+ELfWAncs4afBQnibBZbhYBLPIW1MFSmumHnuU
         +mNg==
X-Gm-Message-State: AOAM530UHH26KibJb1RwhhV0bHDbbTzCcStt95jgBi8YYQXWL2fA/n3U
        cHYchCPgzX3F+LUII7XDfm2PFM49nqi2zQ==
X-Google-Smtp-Source: ABdhPJw5mmxkfdAmR2Jd/SSEUI01x1XqVbWdcJJBOtHvkP47EX9pszaf6dzYTJF1dAi6SsTZw5rvZg==
X-Received: by 2002:a37:e301:: with SMTP id y1mr24808255qki.475.1630355117772;
        Mon, 30 Aug 2021 13:25:17 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id p22sm11821341qkj.16.2021.08.30.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:25:17 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:27:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YS0/GHBG15+2Mglk@cmpxchg.org>
References: <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia>
 <YSjxlNl9jeEX2Yff@cmpxchg.org>
 <YSkyjcX9Ih816mB9@casper.infradead.org>
 <YS0WR38gCSrd6r41@cmpxchg.org>
 <YS0h4cFhwYoW3MBI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0h4cFhwYoW3MBI@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 07:22:25PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 30, 2021 at 01:32:55PM -0400, Johannes Weiner wrote:
> > > The mistake you're making is coupling "minimum mapping granularity" with
> > > "minimum allocation granularity".  We can happily build a system which
> > > only allocates memory on 2MB boundaries and yet lets you map that memory
> > > to userspace in 4kB granules.
> > 
> > Yeah, but I want to do it without allocating 4k granule descriptors
> > statically at boot time for the entirety of available memory.
> 
> Even that is possible when bumping the PAGE_SIZE to 16kB.  It needs a
> bit of fiddling:
> 
> static int insert_page_into_pte_locked(struct mm_struct *mm, pte_t *pte,
>                         unsigned long addr, struct page *page, pgprot_t prot)
> {
>         if (!pte_none(*pte))
>                 return -EBUSY;
>         /* Ok, finally just insert the thing.. */
>         get_page(page);
>         inc_mm_counter_fast(mm, mm_counter_file(page));
>         page_add_file_rmap(page, false);
>         set_pte_at(mm, addr, pte, mk_pte(page, prot));
>         return 0;
> }
> 
> mk_pte() assumes that a struct page refers to a single pte.  If we
> revamped it to take (page, offset, prot), it could construct the
> appropriate pte for the offset within that page.

Right, page tables only need a pfn. The struct page is for us to
maintain additional state about the object.

For the objects that are subpage sized, we should be able to hold that
state (shrinker lru linkage, referenced bit, dirtiness, ...) inside
ad-hoc allocated descriptors.

Descriptors which could well be what struct folio {} is today, IMO. As
long as it doesn't innately assume, or will assume, in the API the
1:1+ mapping to struct page that is inherent to the compound page.

> Independent of _that_, the biggest problem we face (I think) in getting
> rid of memmap is that it offers the pfn_to_page() lookup.  If we move to a
> dynamically allocated descriptor for our arbitrarily-sized memory objects,
> we need a tree to store them in.  Given the trees we currently have,
> our best bet is probably the radix tree, but I dislike its glass jaws.
> I'm hoping that (again) the maple tree becomes stable soon enough for
> us to dynamically allocate memory descriptors and store them in it.
> And that we don't discover a bootstrapping problem between kmalloc()
> (for tree nodes) and memmap (to look up the page associated with a node).
> 
> But that's all a future problem and if we can't even take a first step
> to decouple filesystems from struct page then working towards that would
> be wasted effort.

Agreed. Again, I'm just advocating to keep the doors open on that, and
avoid the situation where the filesystem folks run off and convert to
a flexible folio data structure, and the MM people run off and convert
all compound pages to folio and in the process hardcode assumptions
and turn it basically into struct page again that can't easily change.

> > > > Willy says he has future ideas to make compound pages scale. But we
> > > > have years of history saying this is incredibly hard to achieve - and
> > > > it certainly wasn't for a lack of constant trying.
> > > 
> > > I genuinely don't understand.  We have five primary users of memory
> > > in Linux (once we're in a steady state after boot):
> > > 
> > >  - Anonymous memory
> > >  - File-backed memory
> > >  - Slab
> > >  - Network buffers
> > >  - Page tables
> > > 
> > > The relative importance of each one very much depends on your workload.
> > > Slab already uses medium order pages and can be made to use larger.
> > > Folios should give us large allocations of file-backed memory and
> > > eventually anonymous memory.  Network buffers seem to be headed towards
> > > larger allocations too.  Page tables will need some more thought, but
> > > once we're no longer interleaving file cache pages, anon pages and
> > > page tables, they become less of a problem to deal with.
> > > 
> > > Once everybody's allocating order-4 pages, order-4 pages become easy
> > > to allocate.  When everybody's allocating order-0 pages, order-4 pages
> > > require the right 16 pages to come available, and that's really freaking
> > > hard.
> > 
> > Well yes, once (and iff) everybody is doing that. But for the
> > foreseeable future we're expecting to stay in a world where the
> > *majority* of memory is in larger chunks, while we continue to see 4k
> > cache entries, anon pages, and corresponding ptes, yes?
> 
> No.  4k page table entries are demanded by the architecture, and there's
> little we can do about that.

I wasn't claiming otherwise..?

> > Memory is dominated by larger allocations from the main workloads, but
> > we'll continue to have a base system that does logging, package
> > upgrades, IPC stuff, has small config files, small libraries, small
> > executables. It'll be a while until we can raise the floor on those
> > much smaller allocations - if ever.
> > 
> > So we need a system to manage them living side by side.
> > 
> > The slab allocator has proven to be an excellent solution to this
> > problem, because the mailing lists are not flooded with OOM reports
> > where smaller allocations fragmented the 4k page space. And even large
> > temporary slab explosions (inodes, dentries etc.) are usually pushed
> > back with fairly reasonable CPU overhead.
> 
> You may not see the bug reports, but they exist.  Right now, we have
> a service that is echoing 2 to drop_caches every hour on systems which
> are lightly loaded, otherwise the dcache swamps the entire machine and
> takes hours or days to come back under control.

Sure, but compare that to the number of complaints about higher-order
allocations failing or taking too long (THP in the fault path e.g.)...

Typegrouping isn't infallible for fighting fragmentation, but it seems
to be good enough for most cases. Unlike the buddy allocator.
