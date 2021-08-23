Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6353F52D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 23:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhHWVZq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhHWVZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:25:44 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C3C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 14:25:01 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t4so6445330qkb.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rFm1OeTA67q6+Ox7ZeDoPnLQPHqm+qvBnfSJlYS48GI=;
        b=J9H51Cd9V1SHaSBkCeV3m7v6aK33OllLPSk2HbNQpv8ykecbCEZrLGXXkbN/WJBGwI
         ZQ/QA4GwGhOsSAruXvfUjmfr2tcYtwyHuyMJwiwdL6c8N3R6t0XdpDFvroCyfIWbSmko
         iFu3SehppMkpteN9bAcoZOVOiVyrwMln+FH//yUlv8pscvhg4+ui8s28rs7nhiTNYFNO
         bLg9OUyO3UDXWS6cetEn5B4eIvAaWl7hixyOWrxhix/j1A7oE6tkgLZSig0l3lAqoqax
         OfEUBW3AyNzbtYnAFlIDq8CJp3HiGeBRP5uA8FZQSMX+U+a6vh52t2kqQDcf5SaTvAU+
         W8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rFm1OeTA67q6+Ox7ZeDoPnLQPHqm+qvBnfSJlYS48GI=;
        b=U8qf4+n/WK+b2on1l5+ea7jhhsbyljlcOhmAFuMAnalO59fVB6n14v812dnuOyuWhy
         kv5MT+BAsguV9vFR6rQvPfg7v8n34BGw6QSOze5UlZ6Ekr+6MgZxlhGfIo3FiyGKxpme
         NbtxrITRh/qoCNCFk++BBoxxwpFdC8lKr8KUoX5zXGOUNzmeC3DExAwAOaohHIY/MtRH
         vtIb8Khs1aBAMO1OcFu7cNGSbeaf3s3Y6qkeadE8jETKVxqLFWRWO3C6yqPnVLDQzayN
         K+Q8i7TI0NZLwO5rW5Tq0xPJHgza4gH8NjI2b4JTOPpWu2oe9fSlyMmFeOrL9azOXAVD
         liNQ==
X-Gm-Message-State: AOAM532T5MbvhbOXhpOmy8KFAS/LWvaqpkdJE7SohAbWVkMxZLE3Nxo5
        /nrDzFYMBk1lDd3wDXjnP03wbA==
X-Google-Smtp-Source: ABdhPJwjpnChjk6PVNru/JPKLrrjhzM0iSABCMfGqqq0BplI/+4JE0INTEKMzLYMVZmdm/mLK09yDA==
X-Received: by 2002:a37:9d09:: with SMTP id g9mr22917986qke.269.1629753900524;
        Mon, 23 Aug 2021 14:25:00 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id d129sm9382198qkf.136.2021.08.23.14.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 14:24:59 -0700 (PDT)
Date:   Mon, 23 Aug 2021 17:26:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSQSkSOWtJCE4g8p@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSPwmNNuuQhXNToQ@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 08:01:44PM +0100, Matthew Wilcox wrote:
> Hi Linus,
> 
> I'm sending this pull request a few days before the merge window
> opens so you have time to think about it.  I don't intend to make any
> further changes to the branch, so I've created the tag and signed it.
> It's been in Stephen's next tree for a few weeks with only minor problems
> (now addressed).
> 
> The point of all this churn is to allow filesystems and the page cache
> to manage memory in larger chunks than PAGE_SIZE.  The original plan was
> to use compound pages like THP does, but I ran into problems with some
> functions that take a struct page expect only a head page while others
> expect the precise page containing a particular byte.
> 
> This pull request converts just parts of the core MM and the page cache.
> For 5.16, we intend to convert various filesystems (XFS and AFS are ready;
> other filesystems may make it) and also convert more of the MM and page
> cache to folios.  For 5.17, multi-page folios should be ready.
> 
> The multi-page folios offer some improvement to some workloads.  The 80%
> win is real, but appears to be an artificial benchmark (postgres startup,
> which isn't a serious workload).  Real workloads (eg building the kernel,
> running postgres in a steady state, etc) seem to benefit between 0-10%.
> I haven't heard of any performance losses as a result of this series.
> Nobody has done any serious performance tuning; I imagine that tweaking
> the readahead algorithm could provide some more interesting wins.
> There are also other places where we could choose to create large folios
> and currently do not, such as writes that are larger than PAGE_SIZE.
> 
> I'd like to thank all my reviewers who've offered review/ack tags:
> 
> Christoph Hellwig <hch@lst.de>
> David Howells <dhowells@redhat.com>
> Jan Kara <jack@suse.cz>
> Jeff Layton <jlayton@kernel.org>
> Johannes Weiner <hannes@cmpxchg.org>

Just to clarify, I'm only on this list because I acked 3 smaller,
independent memcg cleanup patches in this series. I have repeatedly
expressed strong reservations over folios themselves.

The arguments for a better data interface between mm and filesystem in
light of variable page sizes are plentiful and convincing. But from an
MM point of view, it's all but clear where the delineation between the
page and folio is, and what the endgame is supposed to look like.

One one hand, the ambition appears to substitute folio for everything
that could be a base page or a compound page even inside core MM
code. Since there are very few places in the MM code that expressly
deal with tail pages in the first place, this amounts to a conversion
of most MM code - including the LRU management, reclaim, rmap,
migrate, swap, page fault code etc. - away from "the page".

However, this far exceeds the goal of a better mm-fs interface. And
the value proposition of a full MM-internal conversion, including
e.g. the less exposed anon page handling, is much more nebulous. It's
been proposed to leave anon pages out, but IMO to keep that direction
maintainable, the folio would have to be translated to a page quite
early when entering MM code, rather than propagating it inward, in
order to avoid huge, massively overlapping page and folio APIs.

It's also not clear to me that using the same abstraction for compound
pages and the file cache object is future proof. It's evident from
scalability issues in the allocator, reclaim, compaction, etc. that
with current memory sizes and IO devices, we're hitting the limits of
efficiently managing memory in 4k base pages per default. It's also
clear that we'll continue to have a need for 4k cache granularity for
quite a few workloads that work with large numbers of small files. I'm
not sure how this could be resolved other than divorcing the idea of a
(larger) base page from the idea of cache entries that can correspond,
if necessary, to memory chunks smaller than a default page.

A longer thread on that can be found here:
https://lore.kernel.org/linux-fsdevel/YFja%2FLRC1NI6quL6@cmpxchg.org/

As an MM stakeholder, I don't think folios are the answer for MM code.
