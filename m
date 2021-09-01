Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390183FE14E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbhIARmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346141AbhIARmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:42:16 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599A3C061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:41:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a10so228915qka.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X47a3I4hEhBZ7dlV+A+sHbc97pXib7+eoy5ndeUC/TI=;
        b=VqOKKbbrSBuhFKMRNR0Ia2mNf7T780bVKLBOQH84t92wPPPn6N0g6OT3TZtoskO4e3
         JGlGPI66p6JPQErA6IaIqLkM9PSaiMowv5iVt69X6K2zpu2u4wxVGC/XmHbXf6yV7Ac0
         Bhnvain85DjiZ5r6nwm48n1VGerr0s7KiwaKr0dSeG/FFUcHwP7/N+mVBNYfXo43P9Rd
         ENIxm8aM3fmxuEx4WCeDq7dCcPDD2YUfNlq92bdaWqewTyvCbkiqgaFXdVXfNu17tfwb
         +h/V8thxXYKgnP7+Oi9WSSGfuCiDoWVcxoY8aWchVGrmqxtj1btIJnhfXLjaMn+RndhW
         36jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X47a3I4hEhBZ7dlV+A+sHbc97pXib7+eoy5ndeUC/TI=;
        b=HijAkVBUor+KW1TnBY76DFHw9+1Y/dbcJ2ruibcadXdqPyYn6wUfoG0RYd2M4S8Lt+
         N70PqkHTmYnQcVwdXDoBosROy32CCtrizAd+5uMtcIMt4KvWo2Eygs5LwDbPyCr6ZOaW
         nSkUbjKgSPC3DVVnIaWuo6HGoYgl7kfwHH2aiR/Rv4O/+rHOv9v1FldojOPzyauX4iV7
         +4cKqWBeHx1qehdWSF+mqG5Zx1Y3afhOddk1LGKYJdIr6GRPndAnEv+UU0Jw5LdRfYt2
         01/sKYjJTAeKTGlVo5WlOxxFR4QAVQvgJXfMRVD/eFWnqPsVEXWtP72jkILdzzl+DAD6
         /n6w==
X-Gm-Message-State: AOAM533Q0JC8un9c0eau39Gz8rij8zd+oq7Zt0fklpLQk63aooh/yN+m
        rnBAtJrPzgHW5jO7bSFNNiLK0A==
X-Google-Smtp-Source: ABdhPJz67u5SOCvcRFUZ/9z75OUbkd1IVLeBx70CkD5mv/yNfKQJDwzQJMI0LHgKc9PiM6OxxyDy1Q==
X-Received: by 2002:a05:620a:1388:: with SMTP id k8mr823968qki.152.1630518078495;
        Wed, 01 Sep 2021 10:41:18 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id g1sm292244qti.56.2021.09.01.10.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:41:17 -0700 (PDT)
Date:   Wed, 1 Sep 2021 13:43:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YS+7pzI7pttxtFHT@cmpxchg.org>
References: <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia>
 <YSjxlNl9jeEX2Yff@cmpxchg.org>
 <YSkyjcX9Ih816mB9@casper.infradead.org>
 <YS0WR38gCSrd6r41@cmpxchg.org>
 <YS0h4cFhwYoW3MBI@casper.infradead.org>
 <YS0/GHBG15+2Mglk@cmpxchg.org>
 <YS1PzKLr2AWenbHF@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS1PzKLr2AWenbHF@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:38:20PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 30, 2021 at 04:27:04PM -0400, Johannes Weiner wrote:
> > Right, page tables only need a pfn. The struct page is for us to
> > maintain additional state about the object.
> > 
> > For the objects that are subpage sized, we should be able to hold that
> > state (shrinker lru linkage, referenced bit, dirtiness, ...) inside
> > ad-hoc allocated descriptors.
> > 
> > Descriptors which could well be what struct folio {} is today, IMO. As
> > long as it doesn't innately assume, or will assume, in the API the
> > 1:1+ mapping to struct page that is inherent to the compound page.
> 
> Maybe this is where we fundamentally disagree.  I don't think there's
> any point in *managing* memory in a different size from that in which it
> is *allocated*.  There's no point in tracking dirtiness, LRU position,
> locked, etc, etc in different units from allocation size.  The point of
> tracking all these things is so we can allocate and free memory.  If
> a 'cache descriptor' reaches the end of the LRU and should be reclaimed,
> that's wasted effort in tracking if the rest of the 'cache descriptor'
> is dirty and heavily in use.  So a 'cache descriptor' should always be
> at least a 'struct page' in size (assuming you're using 'struct page'
> to mean "the size of the smallest allocation unit from the page
> allocator")

First off, we've been doing this with the slab shrinker for decades.

Second, you'll still be doing this when you track 4k struct pages in a
system that is trying to serve primarily higher-order pages. Whether
you free N cache descriptors to free a page, or free N pages to free a
compound page, it's the same thing. You won't avoid this problem.

> > > > Well yes, once (and iff) everybody is doing that. But for the
> > > > foreseeable future we're expecting to stay in a world where the
> > > > *majority* of memory is in larger chunks, while we continue to see 4k
> > > > cache entries, anon pages, and corresponding ptes, yes?
> > > 
> > > No.  4k page table entries are demanded by the architecture, and there's
> > > little we can do about that.
> > 
> > I wasn't claiming otherwise..?
> 
> You snipped the part of my paragraph that made the 'No' make sense.
> I'm agreeing that page tables will continue to be a problem, but
> everything else (page cache, anon, networking, slab) I expect to be
> using higher order allocations within the next year.

Some, maybe, but certainly not all of them. I'd like to remind you of
this analysis that Al did on the linux source tree with various page
sizes:

https://lore.kernel.org/linux-mm/YGVUobKUMUtEy1PS@zeniv-ca.linux.org.uk/

Page size	Footprint
4Kb		1128Mb
8Kb		1324Mb
16Kb		1764Mb
32Kb		2739Mb
64Kb		4832Mb
128Kb		9191Mb
256Kb		18062Mb
512Kb		35883Mb
1Mb		71570Mb
2Mb		142958Mb

Even just going to 32k more than doubles the cache footprint of this
one repo. This is a no-go from a small-file scalability POV.

I think my point stands: for the foreseeable future, we're going to
continue to see demand for 4k cache entries as well as an increasing
demand for 2M blocks in the page cache and for anonymous mappings.

We're going to need an allocation model that can handle this. Luckily,
we already do...

> > > > The slab allocator has proven to be an excellent solution to this
> > > > problem, because the mailing lists are not flooded with OOM reports
> > > > where smaller allocations fragmented the 4k page space. And even large
> > > > temporary slab explosions (inodes, dentries etc.) are usually pushed
> > > > back with fairly reasonable CPU overhead.
> > > 
> > > You may not see the bug reports, but they exist.  Right now, we have
> > > a service that is echoing 2 to drop_caches every hour on systems which
> > > are lightly loaded, otherwise the dcache swamps the entire machine and
> > > takes hours or days to come back under control.
> > 
> > Sure, but compare that to the number of complaints about higher-order
> > allocations failing or taking too long (THP in the fault path e.g.)...
> 
> Oh, we have those bug reports too ...
> 
> > Typegrouping isn't infallible for fighting fragmentation, but it seems
> > to be good enough for most cases. Unlike the buddy allocator.
> 
> You keep saying that the buddy allocator isn't given enough information to
> do any better, but I think it is.  Page cache and anon memory are marked
> with GFP_MOVABLE.  Slab, network and page tables aren't.  Is there a
> reason that isn't enough?

Anon and cache don't have the same lifetime, and anon isn't
reclaimable without swap. Yes, movable means we don't have to reclaim
them, but background reclaim happens anyway due to the watermarks, and
if that doesn't produce contiguous blocks by itself already then
compaction has to run on top of that. This is where we tend to see the
allocation latencies that prohibit THP allocations during page faults.

I would say the same is true for page tables allocated alongside
network buffers and unreclaimable slab pages. I.e. a burst in
short-lived network buffer allocations being interleaved with
long-lived page table allocations. Ongoing concurrency scaling is
going to increase the likelihood of those happening.

> I think something that might actually help is if we added a pair of new
> GFP flags, __GFP_FAST and __GFP_DENSE.  Dense allocations are those which
> are expected to live for a long time, and so the page allocator should
> try to group them with other dense allocations.  Slab and page tables
> should use DENSE,

You're really just recreating a crappier, less maintainable version of
the object packing that *slab already does*.

It's *slab* that is supposed to deal with internal fragmentation, not
the page allocator.

The page allocator is good at cranking out uniform, slightly big
memory blocks. The slab allocator is good at subdividing those into
smaller objects, neatly packed and grouped to facilitate contiguous
reclaim, while providing detailed breakdowns of per-type memory usage
and internal fragmentation to the user and to kernel developers.

[ And introspection and easy reporting from production are *really
  important*, because fragmentation issues develop over timelines that
  extend the usual testing horizon of kernel developers. ]

By trying to make compound pages the norm, you're making internal
fragmentation a first-class problem of the page allocator. This
conflates the problem space between slab and the page allocator and it
forces you to duplicate large parts of the solution.

This is not about whether it's technically achievable. It's about
making an incomprehensible mess of the allocator layering and having
to solve a difficult MM problem in two places. Because you're trying
to make compound pages into something they were never meant to be.

They're fine for the odd optimistic allocation that can either wait
forever to defragment or fall back gracefully. But there is just no
way these things are going to be the maintainable route for
transitioning to a larger page size.

As long as this is your ambition with the folio, I'm sorry but it's a
NAK from me.
