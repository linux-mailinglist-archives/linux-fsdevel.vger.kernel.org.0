Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F4D28DB14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 10:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgJNITy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgJNITj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:19:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1D1C045867
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 22:51:12 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m22so2393885ots.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 22:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=faBNNQU2Gow7EJE7ViAaiknvkVVBrKWgjAapru1OHTQ=;
        b=T2AAuHUzhO6Bc7SeY8PGLrIaulabOmxasZjQry4bCmgWuaCjV078E3R6rmWr201xBa
         V3h3uI09VPhFRW2ljzHp938crm6aN/P4if38h/GPNpw+J9QzZ/il3ap71O9NdtSxkmtO
         Nj4eOrQwOVydJ5YUbRcKpri+aZDytO5btWoVcHw9KDeKKSyiKqlwsrioQVgq+0k0ua1a
         cR4FIX+kbhqv6kq8PrB0scWmPzpzvlQr9jduvKbEIQxIOPLXbyOGI7P0FRp12Tcx0vio
         hGWYERl9PUcLq+ohtchVXiqPNmoTxhscW6oJztEx+IBtxRel7VHyEnSSxStIjjyFtbay
         4/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=faBNNQU2Gow7EJE7ViAaiknvkVVBrKWgjAapru1OHTQ=;
        b=FS2UOu1+W8RfWsq8BjZvjyXcSraBW5ALUoCEb8C1hN3ZL8VNqOTH3jm+ks2QyeI1Ap
         aAr36q7go24BlyKs150nZ9TQbM4GZuZUAy3+9o4ACFMtOryUR01/Yq4TFD5s0ItiBeor
         iTabv0TUoWdb1mM7oYfWfFw12f0tYnHPOxxFnCeA3P14RAeHfQtYJuJOE0FTmZm9wCsA
         2jc0ElekIfuqmtt57cA7GQj1FPDi+oRuPNATEQnQ5HYac/hv4FFx29PEAm4k9ijloyVx
         veERVqV1g4mhWxQ+17msIbYK8ex9sSXT8oy20F6LqGPF3jKSNCSLnJNXZ7sH9SY/SHse
         701w==
X-Gm-Message-State: AOAM5325IQcBQSqK0niVlljtY8C1XFrqkkZcy4YOmdG3zxGlRNyJNSm3
        vXA1qwCvqWaAyvlmCvAV801z64yVK2bruA==
X-Google-Smtp-Source: ABdhPJxWfHTIfesWLn9sHIIL5TOnK6FKK6hZMbqDYuAU8LhtUsF/A/jstsh1MA2To9LghemduC2hLg==
X-Received: by 2002:a05:6830:2314:: with SMTP id u20mr2342824ote.259.1602654671277;
        Tue, 13 Oct 2020 22:51:11 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o14sm869102ota.63.2020.10.13.22.51.09
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 13 Oct 2020 22:51:09 -0700 (PDT)
Date:   Tue, 13 Oct 2020 22:50:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 0/4] Some more lock_page work..
In-Reply-To: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2010132230060.2516@eggly.anvils>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Oct 2020, Linus Torvalds wrote:

> So this is all just preliminary, but I'd really like to have people
> think more about the page fault handling of the page lock, and I have
> a small experimental series of patches for people to look at and maybe
> get the discussion started.
> 
> The three first patches are really just fairly trivial cleanups. They
> also likely don't really matter, because the *bulk* of all faults -
> particularly the ones that really shouldn't need any page locking
> games - should be all about just "filemap_map_pages()". Which is that
> optimistic "let's insert pages from the page cache as efficiently as
> possible" case.
> 
> That's how all the normal private pages that don't actually get
> modified (so executables, but also any load that uses mmap as a
> zero-copy read) should generally get populated.
> 
> That code doesn't actually do "lock_page()" itself (because it all
> runs under the RCU read lock), but it does to do a trylock, and give
> up if the page was locked. Which is fine as long as you don't get any
> contention, but any concurrent faults of the same page in different
> address spaces will then just mess with other faulters and cause it to
> fall out of the fast path.
> 
> And looking at that code, I'm pretty sure it doesn't actually *need*
> the page lock. It wants the page lock for two reasons:
> 
>  - the truncation worries (which may or may not be relevant - xfs
> wraps the map_pages with xfs_ilock)
> 
>  - compound page worries (sub-page mapcount updates and page splitting issues)
> 
> The compound page case I'm not sure about, but it's probably fine to
> just lock the page in that case - once we end up actually just mapping
> a hugepage, the number of page faults should be small enough that it
> probably doesn't matter.
> 
> The truncation thing could be handled like xfs does, but honestly, I
> think it can equally well be handled by just doing some operations in
> the right order, and double-checking that we don't race with truncate.
> IOW, first increasing the page mapcount, and then re-checking that the
> page still isn't locked and the mapping is still valid, and reachable
> in the xarray.
> 
> Because we can still just drop out of this loop and not populate the
> page table if we see anything odd going on, but if *this* code doesn't
> bother getting the page lock (and we make the COW code not do it
> either), then in all the normal cases you will never have that "fall
> out of the common case".
> 
> IOW, I think right now the thing that makes us fall back to the actual
> page lock is this code itself: by doing the 'trylock", it will make
> other users of the same page not able to do the fast-case. And I think
> the trylock is unnecessary.
> 
> ANYWAY. The patch I have here isn't actually that "just do the checks
> in the right order" patch. No, it's a dirty nasty "a private mapping
> doesn't need to be so careful" patch. Ugly, brutish and nasty. Not the
> right thing at all. But I'm doing it here simply because I wanted to
> test it out and get people to look at this.
> 
> This code is "tested" in the sense that it builds for me, and I'm
> actually running it right now. But I haven't actually stress-tested it
> or tried to see if it gets rid of some page lock heavy cases.
> 
> Comments?

I haven't even read a word you wrote yet (okay, apart from "Comments?"),
nor studied the patches; but have put them under my usual load, and the
only adjustment I've needed so far is

--- 5.9.0/mm/khugepaged.c	2020-10-11 14:15:50.000000000 -0700
+++ linux/mm/khugepaged.c	2020-10-13 21:44:26.000000000 -0700
@@ -1814,7 +1814,7 @@ static void collapse_file(struct mm_stru
 		xas_set(&xas, index);
 
 		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
-		VM_BUG_ON_PAGE(page_mapped(page), page);
+//		VM_BUG_ON_PAGE(page_mapped(page), page);
 
 		/*
 		 * The page is expected to have page_count() == 3:

But it's going to take a lot of diligence to get confident with them:
I have no grip on all the places in which we do assume page lock held.

The place to start looking will be 2.6.23's git history, in which
Nick IIRC introduced VM_FAULT_LOCKED: I thought it was an essential
step on the way to speculative page cache, but may be misremembering.

Or maybe when I actually read what you've said, I'll find that you
have already done that research.

Hugh
