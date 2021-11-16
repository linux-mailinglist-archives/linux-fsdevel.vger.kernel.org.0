Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3494452CBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 09:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKPI37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 03:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhKPI3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:29:49 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79554C061766
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 00:26:52 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id u60so55105639ybi.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 00:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKTpTAX3CYcAD+IfMc5iTmWOWQYhJZdkd6G9+skmKnQ=;
        b=gMmx7dgxqaA7QTjdaKaFPvDJxy1ssDsKXV7f/rOMTRbVk7zXCTwG0IYULnNVxmhfuW
         /Az0pi37GxMZLFvhhc/08M9TSqUupI6qbq9NLM7ppj5thNPBv5H2kJjWDnNkiF93In5H
         RBvfO1u19+aOjUBmwGj+kbMkWgFUPHnyxlgRKI+eKN/nS84Zn5Jkg99t1M+slP9GkPAV
         7tw0j1+J31k5zF6730r+kAdfo7CyskLxypKXKyQYRW+KNxlxL+zn4IavkIlKnvebHhex
         p2/Pdmg1+Cl7bAc3QO4eeTg+lTMj6KIpx/GwMMVbPZ6zEQ14NYAt2sNkxUjjh9KF4yDi
         h1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKTpTAX3CYcAD+IfMc5iTmWOWQYhJZdkd6G9+skmKnQ=;
        b=ybScyG8/cfgI8aVHxKYP1bArY5KRHyKUUxs2kE7qkykOI01ZmuQJRIJvbHlt1jDey6
         2NraxZ68PiRg4asm6T0ajSDCGTAnPpJIZRiAj9wzOWmNfIgqUfpkSNFDeS1HiykK5LJ+
         FD8NxWLX57/5x0n4Yya1lCln/LWwZ36t4bOHm0HHiGJRV6Qhnln0ryd6EQrJOnNwpdo6
         WyZivo8cD7HD45vOzm+Op9QWDl15XnzlMq5GYxqLPDyNo8AxlxlXirQ7k7X6Hp+9KtCU
         onykdGBcHyv7bPuXStQlEQ6x3iNUrkHWsS4I+VmYXPwHiBQH89osz98QfetbQ5up1xdg
         GbxA==
X-Gm-Message-State: AOAM530CC1QLYcnpUWbz2xX/e8hm9NsCoc7c6KqfMMa8Bu9bT48o58Gb
        Lbn7vVZ9FjHN1ZS75AJdrawVx947JWEj6s6FtHN+uA==
X-Google-Smtp-Source: ABdhPJyuPf9385jYLaCNMzCNlglLQO7CWM0XIyiQcDFli3VOF9khrUAzVZ+ZPBI+xkwVw4LGnbWd5CowLLzCjVixjp0=
X-Received: by 2002:a25:d15:: with SMTP id 21mr6055391ybn.141.1637051211812;
 Tue, 16 Nov 2021 00:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20211101093518.86845-1-songmuchun@bytedance.com> <20211115210917.96f681f0a75dfe6e1772dc6d@linux-foundation.org>
In-Reply-To: <20211115210917.96f681f0a75dfe6e1772dc6d@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 16 Nov 2021 16:26:12 +0800
Message-ID: <CAMZfGtX+GkVf_7D8G+Ss32+wYy1bcMgDpT5FJDA=a9gdjW36-w@mail.gmail.com>
Subject: Re: [PATCH 0/4] remove PDE_DATA()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, gladkov.alexey@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 1:09 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon,  1 Nov 2021 17:35:14 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > I found a bug [1] some days ago, which is because we want to use
> > inode->i_private to pass user private data. However, this is wrong
> > on proc fs. We provide a specific function PDE_DATA() to get user
> > private data. Actually, we can hide this detail by storing
> > PDE()->data into inode->i_private and removing PDE_DATA() completely.
> > The user could use inode->i_private to get user private data just
> > like debugfs does. This series is trying to remove PDE_DATA().
>
> Why can't we do
>
> /*
>  * comment goes here
>  */
> static inline void *PDE_DATA(struct inode *inode)
> {
>         return inode->i_private;
> }
>
> to abstract things a bit and to reduce the patch size?
>
> otoh, that upper-case thing needs to go, so the patch size remains the
> same anyway.
>
> And perhaps we should have a short-term
>
> #define PDE_DATA(i) pde_data(i)

Right. This way is the easiest way to reduce the patch size.
Actually, I want to make all PDE_DATA() go away, which
makes this patch series go big.

>
> because new instances are sure to turn up during the development cycle.
>
> But I can handle that by staging the patch series after linux-next and
> reminding myself to grep for new PDE_DATA instances prior to
> upstreaming.

I'd be happy if you could replace PDE_DATA() with inode->i_private.
In this case, should I still introduce pde_data() and perform the above
things to make this series smaller?

Thanks.
