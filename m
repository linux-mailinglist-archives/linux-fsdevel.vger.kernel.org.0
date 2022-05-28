Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90684536E80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 23:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiE1Uz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 16:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiE1Uz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 16:55:27 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12939813F5
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 May 2022 13:55:26 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y17so125710ilj.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 May 2022 13:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=r7QmQVT3bPec5yVUeLtA/QOYilI1zqMiltj748Bz6z0=;
        b=TJtz719hFfkjzMYcqiCSegfXfagOEVGSaXkPJSxEZahltOupjJkbjiMq/uaQRodqGb
         MGbg6jafngWcNDSgJMFJz4fYyLgdJLzpHQIuWJQzZZvDRwrxBRqIZV0Q0wxRYuleOIm4
         I9xNnqyHUJBi9o1JIk4jEkKv6dZCujqyr30Qci5Y7VVVcnA/OXDZAoUUqdP/rYzzrN+d
         9XSHnEYHzP0NtL0s4PH3J2M5xGfTcSp+CSr+BTkfJ0CLor27kiFPDbZN7c1Y3Wl3BZV4
         x4A4dwRU6vofklxNjvuUQ3vRnk9Y0ts/mYXk8e9n38CtBN5hozVpWRhrPG10z0lRIA/j
         f2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=r7QmQVT3bPec5yVUeLtA/QOYilI1zqMiltj748Bz6z0=;
        b=Ys+s7xllb975sbhNYrIcLPSYZvRmmDP4t6FuEzmiBVKocMWDwFjEcauIMYyUmXEYrj
         xjarqNvrDaXfIr/wI1DODVvmb/Tpo4JeSxgXBw5HC38XGPoj9DNAiiM+w93E90os3M6e
         s31s+PqkMsQ4sM+JNo5EEM5El2IB0/iLABJ/rDLrNDjvNoPXl576eXZRn08TODQD6ZU0
         8qPGaDIVtWQZJnj9kKHncfFEOMmusOI8DY92y6zlFapw5IWBhdWQi02FZSvUJjQFw6qv
         cKy/Ar43rkNne5FXH13ArIemoffdrcOxpS6HIqhbamUb59Civc11TLlW2D3P97l718Hq
         Pirg==
X-Gm-Message-State: AOAM530bEaMHgAWHvQ2UDJw3034W7AT/t9PUTCQyn81c30exiXPu7XWo
        AkYTMIB7PN9ykUO4QMnIYN8wnPX8erJGwI83Voc=
X-Google-Smtp-Source: ABdhPJzWphefEUl+c/YZD7TuQxjggFQwJOPePdrtKM3NH2OybADwFVC96wLpwvJBdkiQsH+7nCXSvBFuAYXqufLwdYo=
X-Received: by 2002:a05:6e02:1a88:b0:2d1:f00:78b0 with SMTP id
 k8-20020a056e021a8800b002d10f0078b0mr25379520ilv.20.1653771325418; Sat, 28
 May 2022 13:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk> <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk> <YoutEnMCVdwlzboT@casper.infradead.org>
 <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk> <2ae13aa9-f180-0c71-55db-922c0f18dc1b@kernel.dk>
 <Yo+S4JtT6fjwO5GL@zx2c4.com> <YpCjaL9QuuCB23A5@gmail.com> <YpCnMaT823RM3qU5@gmail.com>
 <YpCps3oyGOZZNZ3z@zn.tnic>
In-Reply-To: <YpCps3oyGOZZNZ3z@zn.tnic>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 28 May 2022 22:54:49 +0200
Message-ID: <CA+icZUWBrZqst6qCCYNsGBzZstRx-=TTT+fOD9=RVVJkWmgxbw@mail.gmail.com>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 28, 2022 at 10:35 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, May 27, 2022 at 12:25:53PM +0200, Ingo Molnar wrote:
> > Turns out Boris just sent a competing optimization to clear_user() 3 days ago:
> >
> >   https://lore.kernel.org/r/YozQZMyQ0NDdD8cH@zn.tnic
>
> Yes, and that one needs to be properly measured and verified it doesn't
> impact any workload. I have been working on this for a while now so
> let's all relax ourselves - it'll get fixed properly eventually.
>
> What you could do in the meantime is, run it and see if your
> microbenchmarks are happy with it.
>
> Because clear_user() doesn't matter one whit in real workloads, as we
> realized upthread.
>

Can you CC me on further evolution of this patch?

What was the (Git) base for it?

Can you describe your or a test-case on how to test it?

Unfortunately, I cannot get the patch from the above link with the b4 tool.

link="https://lore.kernel.org/all/YozQZMyQ0NDdD8cH@zn.tnic/"
b4 -d am $link

Gives a strange collection of akpm mm patchset.

Thanks.

-Sedat-

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
