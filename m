Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E74587D54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 15:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiHBNqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 09:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiHBNqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:46:05 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D513D29;
        Tue,  2 Aug 2022 06:46:02 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r70so10643019iod.10;
        Tue, 02 Aug 2022 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ColewwI6l3g5ZDtLvTS82d/pMaZ2whxLZFnC491Bn6M=;
        b=Ix9fPoJ51D0qSPNpA+0N27SSr+MNMIyYRhiTE7KDWG2BBH2bO6g80DXYnJnms6YJjG
         agUuOKCD9wiLdQ++JXvVGshqkEc8jxhyZXYsdpoauxQCswodvgdOoEDts4s54Ghpbktb
         vUGPGAO5uX2H8URrsKOvTlDlM9wx7V0BdREsaLOQlEg9gcsSoCWN2ZqxBjxNBxXC98n7
         rmdqT/SparDIm/Ml8dTc/TzNdWkvacAdxkfHXMUkpv8D//AosWIR2t3EGy/AaSJxJ8IF
         oB9E+nbhcEuuHe8zonZZK1ucnrxX31t2oWw/hOQxYs7RO/jvYm6dpNY/E1kQfJvrcc6P
         XNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ColewwI6l3g5ZDtLvTS82d/pMaZ2whxLZFnC491Bn6M=;
        b=c0kq/+9po6+Yy2yVLra72q1Lp2HxAS6BGMQY2OdT/XGJ1xbLP/064vjYm2y3yf/Sgv
         e5Ce24swQ3SZ3DWRc04A/rIgObdmwK6NSb+ZY5cLnC03q4SYny4rchKQ8TY194KQwV/a
         WvDyOtuLSh7ayJGWWEXfwer8QvxbW6vcn24E3kpo8KwqLDsp684jw5uJ7LkB1trpmIN/
         G2dtGb2750opWnKB9lzfe+402+BlvysdCu3SKGApMBq1Gcj3KV4qFTlAMTYwcygifCN8
         jWWvlnXFdhdRzmLQp0SmnV8sM94RayB8txGHcm73k6+U2PK4tSpPxU+DSI933zzN6WJ7
         iHOA==
X-Gm-Message-State: AJIora8tT7xr5AFTksVeG7FQsD6W1uyEsQjV934y03TObx3G5dv891kG
        6qjS5P/w+Ozl5lNt4dGB1Gc8TC6Z5vACR6Tr5MIhIKfF
X-Google-Smtp-Source: AGRyM1uCQS8jcQ0eTYdpzXJtMC+GsUZV7viJg2lh4yuiqsyHiT1OZ2XaNk9WVUmOTbXEr/cMDTnXeLewlffITgyBAM4=
X-Received: by 2002:a05:6638:dd1:b0:341:5666:dd0a with SMTP id
 m17-20020a0566380dd100b003415666dd0amr8504893jaj.199.1659447961680; Tue, 02
 Aug 2022 06:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <YukYByl76DKqa+iD@casper.infradead.org>
In-Reply-To: <YukYByl76DKqa+iD@casper.infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Aug 2022 15:45:50 +0200
Message-ID: <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com>
Subject: Re: [PATCH v8 00/31] Rust support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        live-patching@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy,

On Tue, Aug 2, 2022 at 2:26 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> None of this (afaict) has been discussed on linux-fsdevel.  And I may
> have missed somethiing, but I don't see the fs module in this series
> of patches.  Could linux-fsdevel be cc'd on the development of Rust
> support for filesystems in the future?

In order to provide example drivers and kernel modules, we need to
have some safe abstractions for them, thus we are adding some as we
need them.

More importantly, the abstractions also serve as a showcase of how
they may be written in the future if Rust support is merged.

This does not mean these abstractions are a final design or that we
plan to develop them independently of subsystem maintainers. In fact,
we would prefer the opposite: in the future, when the support is
merged and more people start having more experience with Rust, we hope
that the respective kernel maintainers start developing and
maintaining the abstractions themselves.

But we have to start somewhere, and at least provide enough examples
to serve as guidance and to show that it is actually possible to write
abstractions that restrict the amount of unsafe code.

And, of course, if you are already interested in developing them, that
would be actually great and we would love your input and/or that you
join us.

As for the `fs` module, I see in lore 2 patches didn't make it
through, but I didn't get a bounce (I do get bounces for the
rust-for-linux ML, but I was told that was fine as long as LKML got
them). Sorry about that... I will ask what to do.

Meanwhile, you can see the patches in this branch:

    https://github.com/Rust-for-Linux/linux.git rust-next

Cheers,
Miguel
