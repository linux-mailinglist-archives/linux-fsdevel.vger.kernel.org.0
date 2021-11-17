Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0C45443E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 10:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhKQJzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 04:55:35 -0500
Received: from mail-vk1-f172.google.com ([209.85.221.172]:37681 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhKQJze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:55:34 -0500
Received: by mail-vk1-f172.google.com with SMTP id e64so1274204vke.4;
        Wed, 17 Nov 2021 01:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaTH6dG+9OWuk5kLfq7Obj05Cb3d8CS7ODxUbCSsHLY=;
        b=hehaOcivLeOZdPbXAUg/kY+nfhCojFZMe0c6M69o03c3uv8qcZnwFWp4IOgi1l2vt7
         UBA7qhewIqoXF65TbLxYUt0wu/fJocko09gIk1cv+6W5CWKBEaKU4lgvKphRB+H4CPtO
         ymmCmpCOxapu5msM5ZWnBk8FGJy6H0Z7SW38cHvQxPBS097I5hovy+IrLnumlvm8IL0p
         mRhPJEYOnw3hD1QKyzODDbLDSJywakOeaspcDHimCRL3oLHTrJIJVfM0guZXpnFoxhzQ
         xGQbGwB8FJvPuSOzDUKJ5493f4wUgLrMj0RQRsoniRfuqFvnrIuphrBhvdhVamyCkQAM
         nyIA==
X-Gm-Message-State: AOAM531VjGmBN0Q5SnBJW3xHrVUD+kCul7nmBo0TPepYRRLju62p/dKN
        GUF44W7PiXotyGI2lcW055/eVwzdnuY42g==
X-Google-Smtp-Source: ABdhPJxssKJnTS7lyevwjlZazaFRI63UxBqJV9h9WuFWesZ19yrFdAj3a41H0urJq5N56aVs1v0HBg==
X-Received: by 2002:a05:6122:1696:: with SMTP id 22mr86804241vkl.2.1637142755296;
        Wed, 17 Nov 2021 01:52:35 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id y22sm12106344vsy.33.2021.11.17.01.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 01:52:34 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id ay21so4488549uab.12;
        Wed, 17 Nov 2021 01:52:34 -0800 (PST)
X-Received: by 2002:a05:6102:2910:: with SMTP id cz16mr66332901vsb.9.1637142754433;
 Wed, 17 Nov 2021 01:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20211108040551.1942823-1-willy@infradead.org> <20211108040551.1942823-2-willy@infradead.org>
 <YYozKaEXemjKwEar@infradead.org> <YZKCx1cwBXOZcTA4@casper.infradead.org>
 <YZNQnd887/TcPH7H@infradead.org> <YZQnWU9ABBlXJKa5@casper.infradead.org>
In-Reply-To: <YZQnWU9ABBlXJKa5@casper.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Nov 2021 10:52:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXhUbMK8Sp1Zj-cNMSK2Tq1bZ3egX_LXihQpmHULkBk_Q@mail.gmail.com>
Message-ID: <CAMuHMdXhUbMK8Sp1Zj-cNMSK2Tq1bZ3egX_LXihQpmHULkBk_Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/28] csky,sparc: Declare flush_dcache_folio()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 2:22 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Nov 15, 2021 at 10:33:01PM -0800, Christoph Hellwig wrote:
> > I see how this works no, but it is pretty horrible.  Why not something
> > simple like the patch below?  If/when an architecture actually
> > wants to override flush_dcache_folio we can find out how to best do
> > it:
>
> I'll stick this one into -next and see if anything blows up:
>
> From 14f55de74c68a3eb058cfdbf81414148b9bdaac7 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Sat, 6 Nov 2021 17:13:35 -0400
> Subject: [PATCH] Add linux/cacheflush.h
>
> Many architectures do not include asm-generic/cacheflush.h, so turn
> the includes on their head and add linux/cacheflush.h which includes
> asm/cacheflush.h.
>
> Move the flush_dcache_folio() declaration from asm-generic/cacheflush.h
> to linux/cacheflush.h and change linux/highmem.h to include
> linux/cacheflush.h instead of asm/cacheflush.h so that all necessary
> places will see flush_dcache_folio().
>
> More functions should have their default implementations moved in the
> future, but those are for follow-on patches.  This fixes csky, sparc and
> sparc64 which were missed in the commit which added flush_dcache_folio().
>
> Fixes: 08b0b0059bf1 ("mm: Add flush_dcache_folio()")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  arch/m68k/include/asm/cacheflush_mm.h |  1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
