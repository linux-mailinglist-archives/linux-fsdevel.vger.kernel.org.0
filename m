Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD75B11D587
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 19:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfLLS3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 13:29:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35090 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbfLLS3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:29:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so3400922lja.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 10:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFYeLe4AYUGFszSVCe9rzGReH5534Kp7HFzyL7IgJoo=;
        b=gaEqyEltnYHeY4bwG67JYh7XhezoYwB/vlBuat5eb9B1wDrnC3gxSKR6wn2/kJ9gaN
         xQV2GF7RBP8bhWsGKKAD6uojhcOpaKl/HoD3iV1ESQk4Ak3DGeXjvNFW7PMlrhdEMozD
         y6r7JlXMbpP8G/nes7/wTMJB8Ait6DP/0iQww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFYeLe4AYUGFszSVCe9rzGReH5534Kp7HFzyL7IgJoo=;
        b=SoLmXdtPeISySxPd9WhxC8wcvQ9XwxSd4+6IRp56sEFYbGIKF/MIL3+qSjcK+HTDRL
         41JfsWyVwpk5Fu0dvJMiGYij9TP/d6wzc2Hl5Sa9Qy+PRC/TutDKnLVS1YT+Vj494aCD
         ydwBemHA3mgT5Sbc27lqSl6Lp1EqmGR1IW3UBsPQlndNU9cPnimM2oGx95NEp+1w3h0g
         c+U4EGuSRy3vkoFdFsBi1P+4X7aZ7nwzWV3t26SvPorXQ5pOBEsqPnbKnYKxFCu7rxYO
         hiKRPxD7E1XQ07oXz2zpQWpyG/IYKO4GIa0oP6uiVJbirVO0cPKNPtjH7YVw5ForTcJ0
         phxg==
X-Gm-Message-State: APjAAAVRK+Tax27hE+GMKCNDeXm4m5VM8EeJIimlyfMAWnswkwvycx/A
        KNrYykmkUwUdNZFz9Pk+na+85N/dNqw=
X-Google-Smtp-Source: APXvYqynFQ52UO3jXW6uB80v4DsrSDYE2e6Z+O85bvskp0y9Z+uBFKHriEc2Hm7i97EA4zctF9j0xw==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr6964841ljg.198.1576175360416;
        Thu, 12 Dec 2019 10:29:20 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x84sm3387272lfa.97.2019.12.12.10.29.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 10:29:19 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id n12so9042lfe.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 10:29:19 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr6767957lfj.61.1576175358789;
 Thu, 12 Dec 2019 10:29:18 -0800 (PST)
MIME-Version: 1.0
References: <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk> <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk> <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
 <20191212015612.GP32169@bombadil.infradead.org> <CAHk-=wjr1G0xXDs7R=2ZAB=YSs-WLk4GsVwLafw+96XVwo7jyg@mail.gmail.com>
 <20191212175200.GS32169@bombadil.infradead.org>
In-Reply-To: <20191212175200.GS32169@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 10:29:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4J91wMrEU12DP1r+rLiThQ6wDBb+UOzOuMDkusxtdhw@mail.gmail.com>
Message-ID: <CAHk-=wh4J91wMrEU12DP1r+rLiThQ6wDBb+UOzOuMDkusxtdhw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 9:52 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> 1. We could semi-sort the pages on the LRU list.  If we know we're going
> to remove a bunch of pages, we could take a batch of them off the list,
> sort them and remove them in-order.  This probably wouldn't be terribly
> effective.

I don't think the sorting is relevant.

Once you batch things, you already would get most of the locality
advantage in the cache if it exists (and the batch isn't insanely
large so that one batch already causes cache overflows).

The problem - I suspect - is that we don't batch at all. Or rather,
the "batching" does exist at a high level, but it's so high that
there's just tons of stuff going on between single pages. It is at the
shrink_page_list() level, which is pretty high up and basically does
one page at a time with locking and a lot of tests for each page, and
then we do "__remove_mapping()" (which does some more work) one at a
time before we actually get to __delete_from_page_cache().

So it's "batched", but it's in a huge loop, and even at that huge loop
level the batch size is fairly small. We limit it to SWAP_CLUSTER_MAX,
which is just 32.

Thinking about it, that SWAP_CLUSTER_MAX may make sense in some other
circumstances, but not necessarily in the "shrink clean inactive
pages" thing. I wonder if we could just batch clean pages a _lot_ more
aggressively. Yes, our batching loop is still very big and it might
not help at an L1 level, but it might help in the L2, at least.

In kswapd, when we have 28 GB of pages on the inactive list, a batch
of 32 pages at a time is pretty small ;)

> 2. We could change struct page to point to the xa_node that holds them.
> Looking up the page mapping would be page->xa_node->array and then
> offsetof(i_pages) to get the mapping.

I don't think we have space in 'struct page', and I'm pretty sure we
don't want to grow it. That's one of the more common data structures
in the kernel.

                         Linus
