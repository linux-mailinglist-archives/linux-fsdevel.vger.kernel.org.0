Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7830259E68F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbiHWQEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 12:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbiHWQEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:04:14 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77100B7EF3;
        Tue, 23 Aug 2022 05:16:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y187so10734380iof.0;
        Tue, 23 Aug 2022 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qnlJbX7XO6SmNHU1bkg4hqymkER7fnKUTpqUuxqDC9Q=;
        b=YvkTldU56/KpYM/Q8lcjGj20r11xH73ScpVMfAJtufI/U10FglJMjHhHHXenufeP6H
         vwJF4VKfMLUOGuN/Ua9u/Pe2ldy5pEc0aOkanmbjmDEC0Fat0o9y72yF4o3KnaIuBvYX
         oox9tOffcxVjxvPm6v058yOrWSq9WziZzVJ89/og/LnYTqDPeN6o6irdH+dmnaTByX2G
         dVqo6nJhGl2YcKwW+g2mhGsbX8jcnWI3lTJuKlVci6IRshzUlRKxlIDtpx4HvS8Ggpj9
         ZWFLZKmO3B5TzTaJvbCBk7J+zga3aOc9LO6sA7oFd6sJhZXjX6qmoUIwrbaNFo7ACftp
         yMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qnlJbX7XO6SmNHU1bkg4hqymkER7fnKUTpqUuxqDC9Q=;
        b=o5YvyFhPKJP8D1kkjs2JTT6qJCks4/w78wyY8r+STvfCMw8pdFKSQPhrHtCo/alr7B
         KGXAy0ux4eFZx87VgYrs6AzunA6OXXBCg0biBf5KGsmbx6fioZUYHE4OwxL6mfHvhmB+
         12WxaqA5hWH8vNCUM89i+vyN6lHslWJNNbSLiVOBF6Znax3rWmNO53zpTJ/IbXeF8S6B
         0n7xOv7b4gGpmWmiYTO2vuBzvqOE1XaO27kBzCrnbIuHk0jHEAVyazHSXq+1YM7noOvM
         FHlP4smixv2u5MhPisLGuBrkp3c7wAxoGPVOUnLw/nNxpE9G1c+ttky7msaoy+xYS+z/
         HYrw==
X-Gm-Message-State: ACgBeo1alse8daDOX5GnzoVVLJ+I0hcouxLV8W0rrHa0mGJNMTMTaotK
        kvKa+hwwKH7tMRx3wFtOYEDxj0tOMSycxN2NCj8=
X-Google-Smtp-Source: AA6agR65nLgIPp9dQRo/ThNtejGzyHMH3W7NSoUePFPp3ZDLsb4T5keII5Ok366GmAN6alr6UifMSJMIdk3AEK609RA=
X-Received: by 2002:a5d:8953:0:b0:67c:aa4c:2b79 with SMTP id
 b19-20020a5d8953000000b0067caa4c2b79mr11241778iot.172.1661256971635; Tue, 23
 Aug 2022 05:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-21-ojeda@kernel.org>
 <CAKwvOdndYxQ+KgVhC8F3vWnHDT8pD3px8cKjinu-khn25_FSYw@mail.gmail.com> <CANiq72nA0WwfnSaNxxz27iM5LXPELQVzTAQGBE30SXeLGVEf1A@mail.gmail.com>
In-Reply-To: <CANiq72nA0WwfnSaNxxz27iM5LXPELQVzTAQGBE30SXeLGVEf1A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 23 Aug 2022 14:16:00 +0200
Message-ID: <CANiq72mZ6eiKRP59uFgPh=nV-_GavpuEM0zwPwM9BhtytmQbqw@mail.gmail.com>
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

On Tue, Aug 23, 2022 at 2:12 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> For instance, using the test header to print the libclang version,
> this works for me:
>
>     $ bindgen scripts/rust_is_available_bindgen_libclang.h
>     ... clang version 14.0.6 (https://github.com/llvm/llvm-project.git ...
>
>     $ LIBCLANG_PATH=.../libclang-6.0.so.1 \
>       bindgen scripts/rust_is_available_bindgen_libclang.h
>     ... clang version 6.0.0 (tags/RELEASE_600/final) ...

By the way, a while ago I requested an easier way to check the
libclang version directly from bindgen, and Emilio quickly added it
(thanks a lot!): since `bindgen` 0.60.0 you can do:

    $ bindgen --version --verbose
    bindgen 0.60.0
    Clang: clang version 14.0.6 (https://github.com/llvm/ ...

Cheers,
Miguel
