Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122C8419ED9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 21:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhI0TG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbhI0TGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:06:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EDBC061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 12:05:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t10so81705315lfd.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njYGm4bP8jNmCvAFiZ06l8r+GHPtzvHRo47ySu3ATw4=;
        b=WpoF5VpG9djMUN3T0RVGAnKMGpUra/IoZu0YoYu2B7CPTwwNjgNcKC8FXNWXh0DJZH
         acFfw8Hzzhmqsm38B6oYPJzRykCp1dhW8V1tHhoR5FzMH5Sq3dPFJWChUqzPzWjhbDN5
         bWCPIHRDbbzEqw0lQhknGBKzayIfJ3+riydfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njYGm4bP8jNmCvAFiZ06l8r+GHPtzvHRo47ySu3ATw4=;
        b=cNS5y/2Qg57iNM3mzySPi0JDIsxM8doaQpIWMlE5Xv37I7R4Pi4DEBrohO7SPl5wx9
         Hx5AUdldeRaty9kHe/4+J+vdRji0O2E/7+9rRvzf+iX2TDWHnmDPgPwCOk0MiiVsK7xi
         hMRmkAJGWNJeUqFkE6BnvSyVNznuBZmgowWDFKZu22cqONBB4HMSYQe4+dBs4e/zI5iQ
         ++w7WQF2qQ1vtxeA9CDDwjEnqO0IXgPPmMRUypHwGGXK//C6j0GnQW+Ef9r4v2HCa7y5
         tv+HYzV0gGc8Fn8HA3YQW+FeDn8mw2wqyKRRDaTiAxroREIIhEYC0/fM8vp//Ld5LgVc
         q7eA==
X-Gm-Message-State: AOAM532R+D0yn+s+tPEpjSnVmY/0HQyuGuoTNuc89u7xXR6bfagOCRuM
        +M94dq2VemO9encDGHlVJd2H1cWwkbhVLpkZxlk=
X-Google-Smtp-Source: ABdhPJyvN+Ml9zGJG5xAJ4Cx60jZ4T+Oti3YzKWVWyg8B6JHZcVW6Wny0zyaCVvP/7uouRB3IRcQBw==
X-Received: by 2002:a05:6512:2302:: with SMTP id o2mr1342140lfu.297.1632769515384;
        Mon, 27 Sep 2021 12:05:15 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id h21sm1683858lfe.12.2021.09.27.12.05.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 12:05:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x27so81950488lfu.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 12:05:13 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr1576330ljh.68.1632769513513;
 Mon, 27 Sep 2021 12:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org> <YVII7eM7P42riwoI@moria.home.lan>
 <YVIJg+kNqqbrBZFW@casper.infradead.org> <b57911a4-3963-aa65-1f8e-46578b3c0623@redhat.com>
 <df6ad8ab-b3a9-6264-e699-28422a74f995@suse.cz>
In-Reply-To: <df6ad8ab-b3a9-6264-e699-28422a74f995@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Sep 2021 12:04:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQE3eZdFgtoeRmXVsO93c-nSbdheTvtUJcztJaE_KKEw@mail.gmail.com>
Message-ID: <CAHk-=whQE3eZdFgtoeRmXVsO93c-nSbdheTvtUJcztJaE_KKEw@mail.gmail.com>
Subject: Re: Struct page proposal
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:53 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> I was thinking of debug_pagealloc (unmaps free pages from direct map) but yeah,
> the list is longer.

In fact, the _original_ free page list was in the page itself, not in
'struct page'.

The original reason to move it into 'struct page' ended up being
performance, iirc.

Because of how now the free page list was always in the same cache
line set, the page allocator caused horrendous cache patterns on
direct-mapped caches.

Direct-mapped caches may thankfully be gone, and we have a lot of
other things that end up having that property of "same offset within a
page" just because of allocation patterns (task struct allocations
being but one example), but it might still be something to try to
avoid.

               Linus
