Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AAC3F9A98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245264AbhH0OGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbhH0OGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:06:21 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B5C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 07:05:33 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id l4so3979707qvl.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mZZ2GJOqbD627yDd8PxmA7ZK7E+daVtcBKB5g7fmVmo=;
        b=K3MT73Ixrnvebe5Zl6Aji0mjUHK9hnQ+4WZzC+98XvZT5HHdMieKFjqvtLtXEOb6au
         4lJTYZtnuoQI0bz6qP06wk0IBgT/EhmovIYR+Nx3A5K8eQ8BK2b0pEcfPhXNnO/W6SQ/
         PS7+Ttp9NEaUBS3cBbDe8KBLQEvpWkDS+T0V0CQdPkuyh2t2zhIKo1HZ1++c8O/g4usF
         dBL5GbvRvR1kfX7vl59xVklI7zqWt1ekKgGtDoBjNpLFNjqdx+x8J0RlvieEZE8pjmBF
         0fNVHyiKUpXM7Gy2Jkpl9nIi2oOziKAp/fym8cKaQHMKaFxNmW8lb+GQi9tVIaXfee9C
         IZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZZ2GJOqbD627yDd8PxmA7ZK7E+daVtcBKB5g7fmVmo=;
        b=IMGJdjusWCmW2QqC8Q76Z/GhzelwXDmsePiikoG+3w1PK2x/9geIbxNQk7S6TpFNSc
         HFPZp2klgh05n1jqWE9TVaeSIEmvEmYUpvj085qDIsfMTVokqSMs1ttftObAI57qI+5g
         otw24ust5WroPaNxb9jybqUIB0izYer/MKTfp0o/y6VQW9sssKrKe+RvPh0DNa8gG56O
         jmMfnJC5HNgkNSyGefng+pZy45dcw+f3J4W1fjES9L1tA5ndVaaFlLTwBNi9Ssspq28h
         8sHhNdRTosxjdvQt2J2BRj9SWxlpHAnmTM47j2ZIXDxxntfh3LfMy6Jb5g9Y2m+V4Z+V
         wnXg==
X-Gm-Message-State: AOAM53289rgYL4J+C2jMRtUR207Dp2KcbD0omLkXMvO4J1dm8ofreLGO
        yIU2nz+SAztDOgLNVidH5SZC6Pdk8L27tg==
X-Google-Smtp-Source: ABdhPJyB5hwxHPVFEgZdJaR13uGxqzcrL2WCzgBa8Jr4z8v/kEfh1KkxoGej/fzaYogkl2VRWDmwnQ==
X-Received: by 2002:ad4:482d:: with SMTP id h13mr9781285qvy.5.1630073132206;
        Fri, 27 Aug 2021 07:05:32 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id w18sm3384738qto.91.2021.08.27.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 07:05:31 -0700 (PDT)
Date:   Fri, 27 Aug 2021 10:07:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSjxlNl9jeEX2Yff@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826004555.GF12597@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 25, 2021 at 05:45:55PM -0700, Darrick J. Wong wrote:
> Pardon my ignorance, but ... how would adding yet another layer help a
> filesystem?  No matter how the software is structured, we have to set up
> and manage the (hardware) page state for programs, and we must keep that
> coherent with the file space mappings that we maintain.  I already know
> how to deal with pages and dealing with "folios" seems about the same.
> Adding another layer of caching structures just adds another layer of
> cra^Wcoherency management for a filesystem to screw up.
> 
> The folios change management of memory pages enough to disentangle the
> page/compound page confusion that exists now, and it seems like a
> reasonable means to supporting unreasonable things like copy on write
> storage for filesystems with a 56k block size.
> 
> (And I'm sure I'll get tons of blowback for this, but XFS can manage
> space in weird units like that (configure the rt volume, set a 56k rt
> extent size, and all the allocations are multiples of 56k); if we ever
> wanted to support reflink on /that/ hot mess, it would be awesome to be
> able to say that we're only going to do 56k folios in the page cache for
> those files instead of the crazy writeback games that the prototype
> patchset does now.)

I'm guessing the reason you want 56k blocks is because with a larger
filesystems and faster drives it would be a more reasonable unit for
managing this amount of data than 4k would be.

We have the same thoughts in MM and growing memory sizes. The DAX
stuff said from the start it won't be built on linear struct page
mappings anymore because we expect the memory modules to be too big to
manage them with such fine-grained granularity. But in practice, this
is more and more becoming true for DRAM as well. We don't want to
allocate gigabytes of struct page when on our servers only a very
small share of overall memory needs to be managed at this granularity.

Folio perpetuates the problem of the base page being the floor for
cache granularity, and so from an MM POV it doesn't allow us to scale
up to current memory sizes without horribly regressing certain
filesystem workloads that still need us to be able to scale down.


But there is something more important that I wish more MM people would
engage on: When you ask for 56k/2M/whatever buffers, the MM has to be
able to *allocate* them.

I'm assuming that while you certainly have preferences, you don't rely
too much on whether that memory is composed of a contiguous chunk of
4k pages, a single 56k page, a part of a 2M page, or maybe even
discontig 4k chunks with an SG API. You want to manage your disk space
one way, but you could afford the MM some flexibility to do the right
thing under different levels of memory load, and allow it to scale in
the direction it needs for its own purposes.

But if folios are also the low-level compound pages used throughout
the MM code, we're tying these fs allocations to the requirement of
being physically contiguous. This is a much more difficult allocation
problem. And from the MM side, we have a pretty poor track record of
serving contiguous memory larger than the base page size.

Since forever have non-MM people assumed that because the page
allocator takes an order argument you could make arbitrary 2^n
requests. When they inevitably complain that it doesn't work, even
under light loads, we tell them "lol order-0 or good luck".

Compaction has improved our ability to serve these requests, but only
*if you bring the time for defragmentation*. Many allocations
don't. THP has been around for years, but honestly it doesn't really
work in general purpose environments. Yeah if you have some HPC number
cruncher that allocates all the anon at startup and then runs for
hours, it's fine. But in a more dynamic environment after some uptime,
the MM code just isn't able to produce these larger pages reliably and
within a reasonable deadline. I'm assuming filesystem workloads won't
bring the necessary patience for this either.

We've effectively declared bankruptcy on this already. Many requests
have been replaced with kvmalloc(), and THP has been mostly relegated
to the optimistic background tinkering of khugepaged. You can't rely
on it, so you need to structure your expectations around it, and
perform well when it isn't. This will apply to filesystems as well.

I really don't think it makes sense to discuss folios as the means for
enabling huge pages in the page cache, without also taking a long hard
look at the allocation model that is supposed to back them. Because
you can't make it happen without that. And this part isn't looking so
hot to me, tbh.

Willy says he has future ideas to make compound pages scale. But we
have years of history saying this is incredibly hard to achieve - and
it certainly wasn't for a lack of constant trying.

Decoupling the filesystems from struct page is a necessary step. I can
also see an argument for abstracting away compound pages to clean up
the compound_head() mess in all the helpers (although I'm still not
convinced the wholesale replacement of the page concept is the best
way to achieve this). But combining the two objectives, and making
compound pages the basis for huge page cache - after everything we
know about higher-order allocs - seems like a stretch to me.
