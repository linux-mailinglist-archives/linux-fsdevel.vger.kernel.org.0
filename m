Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138963F6919
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhHXScB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhHXScA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:32:00 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1249C061757
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 11:31:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 14so24264184qkc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gpMGJOxOY38WGvjp8q/p0z+0mgwnmEnr/FQGV5yj6hE=;
        b=VH51QsDsUsaK+EEv1hdwjLlfQeUZQ51tZhgypX3yYYnp99lP66+L+vWQH7IE+hhvzV
         +8+VdHv4ZLtM7zPTkiHNrQT6XyiZ8dHk7jMVObDd30pozk2ll0+K/72EWenXTlOtmLI1
         dezuz52SaGnXdfHvhZntfE6KmFOPKdtxWQJUilw8eX3Iio54BUoagDEUXAiCJWEgETV+
         59SIGXkbkPYOxTrt21zQ5npeJD0YiX4EVHOWoBqLQo2kTjIs4lLoypWIZ+E2/jgY1cq/
         IhebJTpL7t/kQVWg7no3I1u9AwsvS2eQK3+uahKOc4+qHbikYcNyB3SSKPCJZ1fxgQEG
         WlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gpMGJOxOY38WGvjp8q/p0z+0mgwnmEnr/FQGV5yj6hE=;
        b=NLVZw+P2IMqRwEeXwjqG4bx7Jve4JQNr/gk3iGZSx80QpxF8VBcEYb7bNG7KLJej1y
         WLZPfJrrMnBqRGLTsGZVfSbNbWGdyEJ5L/A+d9P+wy526xPAmTEiz4fUQPNA2Nnspe/W
         aPuyfi/2HF2VUI8M7OVAWXOokzSK4KrEQoaPdsgiJTH3XvHNA4w94+rGR8+hRz422wcb
         UoBMG9PLaWcWGIIDBk31eY0nvWVOB8YLM4of4h0QFK6IqMo/+CFURFtmW9LzKPwfsCP3
         I0BHMVfhcuDTlIKh0k3CKEexBg445k/xMDx+e0HIHa4MspCJUh1ng+XWmRsrSR8X+1KN
         tExw==
X-Gm-Message-State: AOAM531aKLzmiixHSxQv3zA0jaN2Et3yrO6eNNkyvSeiVmC18OuMtGy8
        Efk1usCH/l8ZGG0FasxyjQRGRQ==
X-Google-Smtp-Source: ABdhPJx5Jkps4usp1pkSs96wQVGiTmDIzvD1gWhzjsRrmBiotq53juxvghRd/Pt1O9EDZzFgUhgu1w==
X-Received: by 2002:a37:9c8c:: with SMTP id f134mr19808525qke.50.1629829874185;
        Tue, 24 Aug 2021 11:31:14 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 12sm4820681qtt.16.2021.08.24.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 11:31:13 -0700 (PDT)
Date:   Tue, 24 Aug 2021 14:32:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSQeFPTMn5WpwyAa@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 11:15:48PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 23, 2021 at 05:26:41PM -0400, Johannes Weiner wrote:
> > However, this far exceeds the goal of a better mm-fs interface. And
> > the value proposition of a full MM-internal conversion, including
> > e.g. the less exposed anon page handling, is much more nebulous. It's
> > been proposed to leave anon pages out, but IMO to keep that direction
> > maintainable, the folio would have to be translated to a page quite
> > early when entering MM code, rather than propagating it inward, in
> > order to avoid huge, massively overlapping page and folio APIs.
> 
> I only intend to leave anonymous memory out /for now/.  My hope is
> that somebody else decides to work on it (and indeed Google have
> volunteered someone for the task).

Unlike the filesystem side, this seems like a lot of churn for very
little tangible value. And leaves us with an end result that nobody
appears to be terribly excited about.

But the folio abstraction is too low-level to use JUST for file cache
and NOT for anon. It's too close to the page layer itself and would
duplicate too much of it to be maintainable side by side.

That's why I asked why it couldn't be a more abstract memory unit for
managing file cache. With a clearer delineation between that and how
the backing memory is implemented - 1 page, N pages, maybe just a part
of a page later on. And not just be a different name for a head page.

It appears David is asking the same in the parallel subthread.

> > It's also not clear to me that using the same abstraction for compound
> > pages and the file cache object is future proof. It's evident from
> > scalability issues in the allocator, reclaim, compaction, etc. that
> > with current memory sizes and IO devices, we're hitting the limits of
> > efficiently managing memory in 4k base pages per default. It's also
> > clear that we'll continue to have a need for 4k cache granularity for
> > quite a few workloads that work with large numbers of small files. I'm
> > not sure how this could be resolved other than divorcing the idea of a
> > (larger) base page from the idea of cache entries that can correspond,
> > if necessary, to memory chunks smaller than a default page.
> 
> That sounds to me exactly like folios, except for the naming.

Then I think you misunderstood me.

> From the MM point of view, it's less churn to do it your way, but
> from the point of view of the rest of the kernel, there's going to
> be unexpected consequences.  For example, btrfs didn't support page
> size != block size until just recently (and I'm not sure it's
> entirely fixed yet?)
> 
> And there's nobody working on your idea.  At least not that have surfaced
> so far.  The folio patch is here now.
> 
> Folios are also variable sized.  For files which are small, we still only
> allocate 4kB to cache them.  If the file is accessed entirely randomly,
> we only allocate 4kB chunks at a time.  We only allocate larger folios
> when we think there is an advantage to doing so.
> 
> This benefit is retained if someone does come along to change PAGE_SIZE
> to 16KiB (or whatever).  Folios can still be composed of multiple pages,
> no matter what the PAGE_SIZE is.

The folio doc says "It is at least as large as %PAGE_SIZE";
folio_order() says "A folio is composed of 2^order pages";
page_folio(), folio_pfn(), folio_nr_pages all encode a N:1
relationship. And yes, the name implies it too.

This is in direct conflict with what I'm talking about, where base
page granularity could become coarser than file cache granularity.

Are we going to bump struct page to 2M soon? I don't know. Here is
what I do know about 4k pages, though:

- It's a lot of transactional overhead to manage tens of gigs of
  memory in 4k pages. We're reclaiming, paging and swapping more than
  ever before in our DCs, because flash provides in abundance the
  low-latency IOPS required for that, and parking cold/warm workload
  memory on cheap flash saves expensive RAM. But we're continously
  scanning thousands of pages per second to do this. There was also
  the RWF_UNCACHED thread around reclaim CPU overhead at the higher
  end of buffered IO rates. There is the fact that we have a pending
  proposal from Google to replace rmap because it's too CPU-intense
  when paging into compressed memory pools.

- It's a lot of internal fragmentation. Compaction is becoming the
  default method for allocating the majority of memory in our
  servers. This is a latency concern during page faults, and a
  predictability concern when we defer it to khugepaged collapsing.

- struct page is statically eating gigs of expensive memory on every
  single machine, when only some of our workloads would require this
  level of granularity for some of their memory. And that's *after*
  we're fighting over every bit in that structure.

Base page size becoming bigger than cache entries in the near future
doesn't strike me as an exotic idea. The writing seems to be on the
wall. But the folio appears full of assumptions that conflict with it.

Sure, the patch is here now. But how much time will all the churn buy
us before we may need a do-over? Would clean, incremental changes to
the cache entry abstraction even be possible after we have anon and
all kinds of other compound page internals hanging off of it as well?

Wouldn't it make more sense to decouple filesystems from "paginess",
as David puts it, now instead? Avoid the risk of doing it twice, avoid
the more questionable churn inside mm code, avoid the confusing
proximity to the page and its API in the long-term...
