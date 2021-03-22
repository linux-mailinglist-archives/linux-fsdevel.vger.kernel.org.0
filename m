Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F59344DF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 19:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCVR7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhCVR73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:59:29 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FEBC061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:59:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id t5so9108478qvs.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3tW5FS73Z71P6K0t+SWrxwMHeSjJgqydDxKdhSwwjsI=;
        b=OduhdWT/vuj5dcpPd9VCBbWHY+tZNB+b78Fy/1QK7HB2OfeTj+uFop5G8r+Me8Raaq
         rEbomPKeULAj2SO8TB2UOjYFEyOpnopkQEB8/JXX3cfq037JoW5O6b8+DAugLgKCXEmw
         pspEx0r8wXUxhRqVw/kTUpRNDeAwdJLG7M+nYrfjU5DMPu96zA7RtmpdC4s0MiDl6BnA
         0IxG5fqS2WSkDcecl8K4CrzZNJXHyN4mI/+6jC7k6p1VydjOsDndV8t44hM9FmXX3iIf
         xQhHYpd1jEvoWn9OjKC8Svo3DTrvGYLu5z6czSN9PRJRxA8o3yx8bXAPEYVxfCHDXbIV
         mjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3tW5FS73Z71P6K0t+SWrxwMHeSjJgqydDxKdhSwwjsI=;
        b=OJtdpLPaHA4RRxoWpSKvHP9oSm2D7ImoaF9/9oDQlzg4BSq61crxba9iAvP6xn2dSN
         CdzV2Oqa7dVxB01iG+PwGFlBfLs7EL8z9km55eZTwLiBsdxRsbEj9DLZRiHu7KSjM9Zp
         hpaHXX1Zv6GkIjqm3fc3wbZuiP+kF7FojzeOugJsVRpNOXLZj+3HcSANW5Ymw9JuexoQ
         JSboQNih+CXXerSGlFaBYsriHcHCMzGns/x/NTmQm9Gz/bKZBBYKXpoSF5FYWvYODTxd
         fUka4+hK1efOlTuIVaSXzKFbGWm5qqieGbZEW5I7AHhupWNHDcsI3mG/R3xs1h8243ME
         JpTg==
X-Gm-Message-State: AOAM532XQXPMI80NJYOWWnWkWjvvaqVMV+MfnuruAVjJX8nKXYw/jcDQ
        1g/X/M8w1VBq7x2tGhtURIfkOg==
X-Google-Smtp-Source: ABdhPJzoBehbHbQuiCGVnZz0UStxWXiZmLz4h7BLRs4yncS1FgXzNF2X65GrLZMvZblfqSGPbGw/UQ==
X-Received: by 2002:a0c:9ad7:: with SMTP id k23mr958345qvf.52.1616435966072;
        Mon, 22 Mar 2021 10:59:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b54e])
        by smtp.gmail.com with ESMTPSA id h8sm11266266qkk.116.2021.03.22.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:59:25 -0700 (PDT)
Date:   Mon, 22 Mar 2021 13:59:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <YFja/LRC1NI6quL6@cmpxchg.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 05:40:37AM +0000, Matthew Wilcox (Oracle) wrote:
> Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
> exist which show the benefits of a larger "page size".  As an example,
> an earlier iteration of this idea which used compound pages got a 7%
> performance boost when compiling the kernel using kernbench without any
> particular tuning.
> 
> Using compound pages or THPs exposes a serious weakness in our type
> system.  Functions are often unprepared for compound pages to be passed
> to them, and may only act on PAGE_SIZE chunks.  Even functions which are
> aware of compound pages may expect a head page, and do the wrong thing
> if passed a tail page.
> 
> There have been efforts to label function parameters as 'head' instead
> of 'page' to indicate that the function expects a head page, but this
> leaves us with runtime assertions instead of using the compiler to prove
> that nobody has mistakenly passed a tail page.  Calling a struct page
> 'head' is also inaccurate as they will work perfectly well on base pages.
> The term 'nottail' has not proven popular.
> 
> We also waste a lot of instructions ensuring that we're not looking at
> a tail page.  Almost every call to PageFoo() contains one or more hidden
> calls to compound_head().  This also happens for get_page(), put_page()
> and many more functions.  There does not appear to be a way to tell gcc
> that it can cache the result of compound_head(), nor is there a way to
> tell it that compound_head() is idempotent.
> 
> This series introduces the 'struct folio' as a replacement for
> head-or-base pages.  This initial set reduces the kernel size by
> approximately 6kB, although its real purpose is adding infrastructure
> to enable further use of the folio.
> 
> The intent is to convert all filesystems and some device drivers to work
> in terms of folios.  This series contains a lot of explicit conversions,
> but it's important to realise it's removing a lot of implicit conversions
> in some relatively hot paths.  There will be very few conversions from
> folios when this work is completed; filesystems, the page cache, the
> LRU and so on will generally only deal with folios.

If that is the case, shouldn't there in the long term only be very
few, easy to review instances of things like compound_head(),
PAGE_SIZE etc. deep in the heart of MM? And everybody else should 1)
never see tail pages and 2) never assume a compile-time page size?

What are the higher-level places that in the long-term should be
dealing with tail pages at all? Are there legit ones besides the page
allocator, THP splitting internals & pte-mapped compound pages?

I do agree that the current confusion around which layer sees which
types of pages is a problem. But I also think a lot of it is the
result of us being in a transitional period where we've added THP in
more places but not all code and data structures are or were fully
native yet, and so we had things leak out or into where maybe they
shouldn't be to make things work in the short term.

But this part is already getting better, and has gotten better, with
the page cache (largely?) going native for example.

Some compound_head() that are currently in the codebase are already
unnecessary. Like the one in activate_page().

And looking at grep, I wouldn't be surprised if only the page table
walkers need the page_compound() that mark_page_accessed() does. We
would be better off if they did the translation once and explicitly in
the outer scope, where it's clear they're dealing with a pte-mapped
compound page, instead of having a series of rather low level helpers
(page flags testing, refcount operations, LRU operations, stat
accounting) all trying to be clever but really just obscuring things
and imposing unnecessary costs on the vast majority of cases.

So I fully agree with the motivation behind this patch. But I do
wonder why it's special-casing the commmon case instead of the rare
case. It comes at a huge cost. Short term, the churn of replacing
'page' with 'folio' in pretty much all instances is enormous.

And longer term, I'm not convinced folio is the abstraction we want
throughout the kernel. If nobody should be dealing with tail pages in
the first place, why are we making everybody think in 'folios'? Why
does a filesystem care that huge pages are composed of multiple base
pages internally? This feels like an implementation detail leaking out
of the MM code. The vast majority of places should be thinking 'page'
with a size of 'page_size()'. Including most parts of the MM itself.

The compile-time check is nice, but I'm not sure it would be that much
more effective at catching things than a few centrally placed warns
inside PageFoo(), get_page() etc. and other things that should not
encounter tail pages in the first place (with __helpers for the few
instances that do). And given the invasiveness of this change, they
ought to be very drastically better at it, and obviously so, IMO.

>  Documentation/core-api/mm-api.rst |   7 +
>  fs/afs/write.c                    |   3 +-
>  fs/cachefiles/rdwr.c              |  19 ++-
>  fs/io_uring.c                     |   2 +-
>  include/linux/memcontrol.h        |  21 +++
>  include/linux/mm.h                | 156 +++++++++++++++----
>  include/linux/mm_types.h          |  52 +++++++
>  include/linux/mmdebug.h           |  20 +++
>  include/linux/netfs.h             |   2 +-
>  include/linux/page-flags.h        | 120 +++++++++++---
>  include/linux/pagemap.h           | 249 ++++++++++++++++++++++--------
>  include/linux/swap.h              |   6 +
>  include/linux/vmstat.h            | 107 +++++++++++++
>  mm/Makefile                       |   2 +-
>  mm/filemap.c                      | 237 ++++++++++++++--------------
>  mm/folio-compat.c                 |  37 +++++
>  mm/memory.c                       |   8 +-
>  mm/page-writeback.c               |  62 ++++++--
>  mm/swapfile.c                     |   8 +-
>  mm/util.c                         |  30 ++--
>  20 files changed, 857 insertions(+), 291 deletions(-)
>  create mode 100644 mm/folio-compat.c
