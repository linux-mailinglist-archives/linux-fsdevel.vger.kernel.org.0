Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B97419FEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 22:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbhI0UPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 16:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhI0UPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:15:48 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F6CC061575;
        Mon, 27 Sep 2021 13:14:10 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b65so37865056qkc.13;
        Mon, 27 Sep 2021 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dhNnXoM4/kD5Ud9oMMKJyEm+bWRWXvGwSSto7Gxhiho=;
        b=aTv822IQ2e0pZ2pxXxky0UTQdahhhbjP/V6fwFenhlv1ZZ3Wq5FjDa/aDGaZCiWj1F
         Pdwc8lVSon0UCQfNi/fPqmCMRNsVpXE0cRKBW2IBb3gmQXf2s1fZDKkl2LO5oEQYzhz3
         Znv9OEEqWXNzQfkqZDLepum3CD+uq16RsQxCtlFUK4GrZOMulM8fq0Y+Q+DaNRr5W0Zg
         T5NpZCNfsLTKaBMosjjSd9eciABpZ0AhK6N04bvSga2DqQoFK2OFrXyW150k6Vh5s1ks
         MBXlUJuKKo7tud+tE5KMhm07che6oUuqokvAQuUxdMdQbdVLPXDnB0cVNo7arQe6THXu
         9S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dhNnXoM4/kD5Ud9oMMKJyEm+bWRWXvGwSSto7Gxhiho=;
        b=qDRQFoEjK02h9O44lsTgYgsbpDBJBkzHo2uTNeEkmhJBNf2HhpIdOqHmJH7ZRRY3dk
         JRYYgVvbzE/zhRiOzOSld9dfBIWLTaDUyEi6+J9rBZ+dvecDXnFCOWhq8wyyZ5Nupstu
         fAmYJGHXza5vIjRk2ahe3r8KUuCqlYnA0lbomD4KaoRAnVlX55Xj8DjUDeQ1bLMdgQqJ
         FYeqrevgnQgI2UXLnLempyTEnz1Wh0tt32fwSyTCshNUkuUoRAniENC+Ep4TgP08lMNc
         X/LOkAExWFBn0bIVeAdHJBPZDqxh2hBjbmD/0Ot3iFgV7u97/qBRe/6Q9OJ0IaFmc3Gq
         XmSw==
X-Gm-Message-State: AOAM530oBJc5yRYk40NzA4qohmpZ6SdUOjU7jP0z1QqpWfHrnocnsqID
        teG7SK2TaJ2NNDna0jBF9g==
X-Google-Smtp-Source: ABdhPJzu2wGNBljA0kG0GtLh/W3YGkvKnpEn3R2o7i+qb0H+dY3qQYmJHWnt75JTQp8fpXyln6LRAw==
X-Received: by 2002:a37:6487:: with SMTP id y129mr1859019qkb.419.1632773649193;
        Mon, 27 Sep 2021 13:14:09 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 14sm11299016qty.93.2021.09.27.13.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:14:08 -0700 (PDT)
Date:   Mon, 27 Sep 2021 16:14:06 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <YVImDtfdgo+RXBe+@moria.home.lan>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org>
 <YVII7eM7P42riwoI@moria.home.lan>
 <751358b2-aec2-43a3-cbbe-1f8c4469b6d3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751358b2-aec2-43a3-cbbe-1f8c4469b6d3@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 09:07:21PM +0200, Vlastimil Babka wrote:
> On 9/27/2021 8:09 PM, Kent Overstreet wrote:
> > On Mon, Sep 27, 2021 at 07:05:26PM +0100, Matthew Wilcox wrote:
> >> On Mon, Sep 27, 2021 at 07:48:15PM +0200, Vlastimil Babka wrote:
> >>> Won't be easy to cram all that into two unsigned long's, or even a single
> >>> one. We should avoid storing anything in the free page itself. Allocating
> >>> some external structures to track free pages is going to have funny
> >>> bootstrap problems. Probably a major redesign would be needed...
> >>
> >> Wait, why do we want to avoid using the memory that we're allocating?
> > 
> > The issue is where to stick the state for free pages. If that doesn't fit in two
> > ulongs, then we'd need a separate allocation, which means slab needs to be up
> > and running before free pages are initialized.
> 
> So that's what I meant by the funny bootstrap problems - slab allocates pages
> from the buddy allocator. And well, not just bootstrap, imagine free memory
> becomes low, we need to reclaim pages, and in order to turn full pages to free
> buddy pages we need to allocate these slab structures, and the slab is full too
> and needs to allocate more backing pages...
> 
> By "major redesign" I meant e.g. something along - bitmaps of free pages per
> each order? (instead of the free lists) Hm but I guess no, the worst case times
> searching for free pages would just suck...

We can have arrays of pointers to free pages - then within struct page we'd keep
the index of that page in the freelist array. To take a page off the middle of
the freelist we'd just swap it with the one at the end. And instead of using a
literal array, we'd want to use a simple radix tree.
