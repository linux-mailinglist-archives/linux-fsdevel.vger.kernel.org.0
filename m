Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15033E2F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 01:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCQAok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 20:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhCQAoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:44:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A2C06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 17:44:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v2so345586lft.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 17:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hdc3Z4qXX9l8XXJJcPsajObPuLYLca+A1Hq/au570EA=;
        b=YqsIQMoBpBXzCzWbXra19j5jdGRkI2qmReN0oKioV0Shal06ZaKrGs1JdX7FzgzYcr
         nVdCUGWHZEm/QGFrHGtKf2wWR/L5xQyhWnIB3r3hvDiwBN64JQlL/ROMD8G8P5PUnBxO
         I6l7MXffemgprdgtj4mLDpX7ZtfZ2Y1ecu3YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hdc3Z4qXX9l8XXJJcPsajObPuLYLca+A1Hq/au570EA=;
        b=cm4VKEowNYhUIUohViVQ20REkl0o5WR5bVaNJMRJ00kd0aZ0eNKxkyoWHfF48jesL9
         UGFfCKLsSxL+hS40mXQM0iQ1GPTyP2DFZ+T9hf56E/Tmx0rBnuUe1JQvsZC6ntNpz9jx
         lDR3jTMqidu561Oyp4BKi1YbkJQAs1dIQpXsD6wKJT4X+gdx8w1wd65BFjj4uxPTVkz2
         vOrztrTGAhUVBicCaVdtdhGhpTFwx7YyPb/ZMFP7hAkr40IHnz4iTVWKh9xL+YT9PiFw
         f1A4K+C6DV9jdbmfQVWsFVksxXMxpnGXafY++DhGTl8Is8DbBb5TAg8Imy9P6ugjgrXH
         KgqA==
X-Gm-Message-State: AOAM531Rr+coFTst9wsC/3b36Lijx8mTdVTUc95T+cYaEalTOmw7itp1
        P2XXfJXrPtQtg22A6bCQ53wVhOeuoarEtA==
X-Google-Smtp-Source: ABdhPJylZOnyI8GLhmCubFrl5TFZaqLn9ewM7xYA4Ql4wH5j/oIU8Qb2hD/X3uSe7egXoDe4OOn83A==
X-Received: by 2002:ac2:562a:: with SMTP id b10mr793998lff.384.1615941848298;
        Tue, 16 Mar 2021 17:44:08 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r5sm3311266ljh.128.2021.03.16.17.44.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 17:44:07 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id m22so370497lfg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 17:44:06 -0700 (PDT)
X-Received: by 2002:ac2:4250:: with SMTP id m16mr745431lfl.40.1615941846610;
 Tue, 16 Mar 2021 17:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
 <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk> <20210316190707.GD3420@casper.infradead.org>
In-Reply-To: <20210316190707.GD3420@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Mar 2021 17:43:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSGsRj7xwhSMQ6dAQiz53xA39pOG+XA_WeTgwBBu4uqg@mail.gmail.com>
Message-ID: <CAHk-=wjSGsRj7xwhSMQ6dAQiz53xA39pOG+XA_WeTgwBBu4uqg@mail.gmail.com>
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for PG_private_2/PG_fscache
To:     Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Adding btrfs people explicitly, maybe they see this on the fs-devel
list, but maybe they don't react .. ]

On Tue, Mar 16, 2021 at 12:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> This isn't a problem with this patch per se, but I'm concerned about
> private2 and expected page refcounts.

Ugh. You are very right.

It would be good to just change the rules - I get the feeling nobody
actually depended on them anyway because they were _so_ esoteric.

> static inline int is_page_cache_freeable(struct page *page)
> {
>         /*
>          * A freeable page cache page is referenced only by the caller
>          * that isolated the page, the page cache and optional buffer
>          * heads at page->private.
>          */
>         int page_cache_pins = thp_nr_pages(page);
>         return page_count(page) - page_has_private(page) == 1 + page_cache_pins;

You're right, that "page_has_private()" is really really nasty.

The comment is, I think, the traditional usage case, which used to be
about page->buffers. Obviously these days it is now about
page->private with PG_private set, pointing to buffers
(attach_page_private() and detach_page_private()).

But as you point out:

> #define PAGE_FLAGS_PRIVATE                              \
>         (1UL << PG_private | 1UL << PG_private_2)
>
> So ... a page with both flags cleared should have a refcount of N.
> A page with one or both flags set should have a refcount of N+1.

Could we just remove the PG_private_2 thing in this context entirely,
and make the rule be that

 (a) PG_private means that you have some local private data in
page->private, and that's all that matters for the "freeable" thing.

 (b) PG_private_2 does *not* have the same meaning, and has no bearing
on freeability (and only the refcount matters)

I _)think_ the btrfs behavior is to only use PagePrivate2() when it
has a reference to the page, so btrfs doesn't care?

I think fscache is already happy to take the page count when using
PG_private_2 for locking, exactly because I didn't want to have any
confusion about lifetimes. But this "page_has_private()" math ends up
meaning it's confusing anyway.

btrfs people? What are the semantics for PG_private_2? Is it just a
flag, and you really don't want it to have anything to do with any
page lifetime decisions? Or?

        Linus
