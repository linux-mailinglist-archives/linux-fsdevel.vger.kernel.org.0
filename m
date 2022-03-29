Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737DD4EB54C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 23:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiC2Vay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 17:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiC2Vay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:30:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464BB9198
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 14:29:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bt26so32522946lfb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rY33JzN2MGT/ULYx0pnOgIpPm5mpxR9vJ2LmFtTzaYk=;
        b=EMdH4BsTqd5T/ortsWVmEHMIqdVON057YKnu3fBYGZKO9756KwefhyVz06rNMxjRp5
         guYmswMCT/w7TllHi5NvlWSFF91vENwgv8ivCu0HdJJSxBTU0jNm3q0sUl3KsNegwcWr
         NoTqPu7SPcbOxDllKSd4O0gQmpsxMErcSq1ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rY33JzN2MGT/ULYx0pnOgIpPm5mpxR9vJ2LmFtTzaYk=;
        b=uzv0izUuYdOkzttXzuQffxD0jOr5ij+IJIfFxwDyxbm67W2EDO4sJSddsFP1FADw9/
         1ahn47s+LOMwZ+IIkjAoWuGh/V8O6nRAs8uNZ2sokXtw9l/FymgansExLst/ShLiGu3B
         pSkmzNzptbRODFhWfIrpPK0JU+TPhGlZ1DG5xOraHaVUYHrtDX4ey22rYJHhU/6jrGUR
         4O8lJQUgO/JHn6k4iGPK9D8RSzwk0DziQZH7mAKxGVg5IIru/SP0pR3iXuZN63CHMfq0
         SQqrie3TduAvsbX/yNVeU1BOwOZSliP96WtygjBa+koz1d65DE3r1fcDeGiTtFeTFU4a
         vUiw==
X-Gm-Message-State: AOAM533ZN6k4idU1t10tG0k4p9+YJBHLQo98dEBIeGCDvAb/nnAuK0hw
        JLF3uxEo+OLEDjGQrDHeGcQCwW2YWHh5GWri
X-Google-Smtp-Source: ABdhPJxrRmK4h5v+oMeuaOTVH8MN6MV0TFyat6Zh7YiCguAdFJ85ZF64nAWXkAWw7hq5yISN7B84AQ==
X-Received: by 2002:a05:6512:3404:b0:44a:310f:72f7 with SMTP id i4-20020a056512340400b0044a310f72f7mr4505969lfr.47.1648589348596;
        Tue, 29 Mar 2022 14:29:08 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m22-20020a0565120a9600b0044a93d21093sm878495lfu.279.2022.03.29.14.29.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 14:29:08 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id m3so32499899lfj.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 14:29:07 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr4373188lfb.435.1648589347481; Tue, 29
 Mar 2022 14:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
 <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com>
 <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67> <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <20220329102347.iu6mlbv5c76ci3j7@wittgenstein> <20220329144047.35zsrw24p2t2ggmg@wittgenstein>
In-Reply-To: <20220329144047.35zsrw24p2t2ggmg@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 14:28:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfvCpb2qy1d4g6GzWO7HJz+peoG9FKG+qLBi_F3Zb7mA@mail.gmail.com>
Message-ID: <CAHk-=wgfvCpb2qy1d4g6GzWO7HJz+peoG9FKG+qLBi_F3Zb7mA@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 7:40 AM Christian Brauner <brauner@kernel.org> wrote:
>
> I think alloc_fdtable() does everything correctly.

So I agree that alloc_fdtable() _works_, but it's certainly a bit opaque.

The reason it works is that

        nr *= (1024 / sizeof(struct file *));

and in practice, since a "sizeof(struct file *)" is either 4 or 8,
that will multiply 'nr' by either 256 or 128.

End result: 'nr' will most definitely always be a multiple of
BITS_PER_LONG, at least until we end up with 128-bit machines, in
which case the multiplier will be only 64.

So I'm inclined to add an explicit ALIGN() there too. I just verified
that at least clang notices that "hey, after multiplying by 128 and
the subsequent ALIGN() is a no-op".

Sadly, gcc seems to be too stupid to realize that. I'm surprised.

But it seems to be because gcc has terminally confused itself and
actually combined the shifts in roundup_pow_of_two() with the
multiply, and as a result has lost sight of the fact that we just
shifted by 7.

So that's a bit sad, but the extra two instructions gcc inserts are
pretty harmless in the end, and the clarification is worth it. And
maybe some day gcc will figure it out.

               Linus
