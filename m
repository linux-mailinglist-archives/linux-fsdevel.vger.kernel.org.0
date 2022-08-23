Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE659E55A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 16:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbiHWOuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243281AbiHWOtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:49:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E42EF415;
        Tue, 23 Aug 2022 05:13:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n202so5204067iod.6;
        Tue, 23 Aug 2022 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Cyy+0Wr2/FQFq8AiuJF/AP46kwKgBUKjMZGYMyzEjI0=;
        b=EKOOtdBHyv4VP+YhKmoDJ9DcGZRVFDsK2vOWoj9zQ6zeHtMqh/yZx9iH/MhmJUbyVg
         gun7TgAS2d60qy4CMsHL7CC6xhym4NzcDtxSvYIA7twB+tPFB7cOgS7ZG3iK7jf6AgY1
         lLrTKo/Yul/3WC96WwPLmIvldy4LS7+v60EGBpp916LZOh55k2eHSfXEI0GNFjS9P9Un
         m7M2/N7rGrvXJbSGU1gZfHOru32NG/PTH2B0SkMZG8f/XQ4OsoGPf6ND1meDxXSougNS
         Mz3k8nqhxhqvbYju/0VBaaamPau1n/8cC02uA3t2MNIHI7eLsgNg8DXGC7d9vF3vxuhI
         KhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Cyy+0Wr2/FQFq8AiuJF/AP46kwKgBUKjMZGYMyzEjI0=;
        b=OxLyeFhmKskazTWPLc7QNVw/CCJh1NIFMhwsrCMKnjs785AvgfPdJ0mW6MVHbVV2LK
         0mew+yRv+lpDAX4uaTB0ntU1dcwmaXOGtRBcmypYiANzqRAHJRL7FOgG7QVOTRw8aN3F
         2BFWcZoY7ugnTecNU8X7EZU3C3hOEj6igKmqgPF9LEqhtBysBaK6quEuOStBhkfTrDOD
         x5a5bvhJDul+ECgULCATfQ3IH9wDoieQJOgiSnf/c40FAayRydtHN4zeo8Omk17y7+JS
         mhEDfJ+HZNbSDK7Dbn3GkOr/vk3UsMHEPOacPhYUHkuWnCb+qoauOSJw+FBK55OfG/A2
         ourw==
X-Gm-Message-State: ACgBeo2TsGY7Phtkc2o1fDrd7yDjN2LuR2/SU39cgHohVgt8uncLf8NB
        YrIAfOCwgISXf5vXkrUqTfq8vUV3L9J9CfZsTQE=
X-Google-Smtp-Source: AA6agR4fuWtvTLj+xpcNEt1aREO3AwEB7XmRPoUgKPyeIKcu3wNqTOOxEhe9+Xkmj8N+6lhY/kg2PzVNlPK1Stv1nfc=
X-Received: by 2002:a05:6602:368a:b0:688:3aa5:19ab with SMTP id
 bf10-20020a056602368a00b006883aa519abmr10566870iob.44.1661256762815; Tue, 23
 Aug 2022 05:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-21-ojeda@kernel.org>
 <CAKwvOdndYxQ+KgVhC8F3vWnHDT8pD3px8cKjinu-khn25_FSYw@mail.gmail.com>
In-Reply-To: <CAKwvOdndYxQ+KgVhC8F3vWnHDT8pD3px8cKjinu-khn25_FSYw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 23 Aug 2022 14:12:31 +0200
Message-ID: <CANiq72nA0WwfnSaNxxz27iM5LXPELQVzTAQGBE30SXeLGVEf1A@mail.gmail.com>
Subject: Re: [PATCH v9 20/27] scripts: add `rust_is_available.sh`
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Finn Behrens <me@kloenk.de>, Miguel Cano <macanroj@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
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

On Mon, Aug 22, 2022 at 10:09 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> because I'm using clang built from source from ToT.  Is this supposed
> to mean that I can't use clang-16, clang-14, clang-13, clang-12, or
> clang-11 (in the kernel we support clang-11+) in order to use rust?
> I'm guessing that's going to hinder adoption.  Is there a way to

No, it is only a warning, so you can proceed if you want to risk it.

However, is there a reason you would like to mix the versions?

If not, please point `bindgen` to your newer libclang (see below).

> specify which libclang version bindgen should be using?

Yes, see below.

> I have libclang built in my clang sources,
> llvm-project/llvm/build/lib/libclang.so.  I also tried:
>
> $ CLANG_PATH=/android0/llvm-project/llvm/build/lib/libclang.so.15 make
> LLVM=1 -j72 rustavailable

`CLANG_PATH` is for pointing to a `clang` executable, not `libclang`.

Instead, please try `LIBCLANG_PATH` (note the `LIB` there).

For instance, using the test header to print the libclang version,
this works for me:

    $ bindgen scripts/rust_is_available_bindgen_libclang.h
    ... clang version 14.0.6 (https://github.com/llvm/llvm-project.git ...

    $ LIBCLANG_PATH=.../libclang-6.0.so.1 \
      bindgen scripts/rust_is_available_bindgen_libclang.h
    ... clang version 6.0.0 (tags/RELEASE_600/final) ...

If the above does not work, for details on how the dependency is
resolved, please see:

    https://github.com/KyleMayes/clang-sys#linking
    https://github.com/KyleMayes/clang-sys#dependencies
    https://github.com/KyleMayes/clang-sys#environment-variables
    https://github.com/rust-lang/rust-bindgen#environment-variables

I will add a note about this to the docs.

Cheers,
Miguel
