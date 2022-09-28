Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E73A5EE1F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiI1QgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI1QgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:36:16 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22007A75C;
        Wed, 28 Sep 2022 09:36:15 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e205so10614579iof.1;
        Wed, 28 Sep 2022 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TzxuSkFY1lkU+KFzHI4Ik/1IQbyTkGI/h/ZDb60baw0=;
        b=ghh0QCywbcq9KUctQSaKs+ZzF6e5x1tsi7CRIHXbI+VxyVjv28yERT2n9Bd2auhS3C
         L0JLhdZq3yI6hteiem5oShET5qpTbX6vU0KLg/xR96SkCedgU0H1pR0H5cUP4DoVX8FQ
         GAy+AQpq+uGZnnBfJoUmIPi2AIy+X7Sw1dqDjzFFt0IBxCOYbuE9InEdf5/v3vAv66t+
         R/DEdTwIrqzbhpEjtT4nC5VEo8uyC24+gKTDYIbI7ws2j/rdgvg7bd/NZG0FUzSv/yhf
         xP4fiPZoTQtQXWJJXAJJ7GNC2JXKan8kug1kSWuQgT8x37t6IYa2G5ECC0a1u+0tnZmk
         9KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TzxuSkFY1lkU+KFzHI4Ik/1IQbyTkGI/h/ZDb60baw0=;
        b=dyzM62BXObbUZqxl0ufv0zk98r4KgQjxbwe0yJemCXMGpo/MEBAZzqXAB/91L46V2c
         Fi37aAVJPXG9lzlhftYet1ptspEJujc9QQSX7T848lOvwbD8G3n05bHwcydRQluA3XRN
         Bw68FyZtghM/lX/gYa+CKyuXkfmDobCHQdnGjmTDdxWyky/0nQL8H2YmhlO18vYt5NOv
         xYr5MIbXLybip88JT9bw6dTE8wSKrOYG37kUXbnj/dioMBunnjme4/LILMrs9UCiwwso
         vpY6RLZrQt1JK+9iBtxRlK2jwLdPilwxy6Z0vvD+db0CJOoG8EXwQkvvz4lfzZMW2COE
         kDIA==
X-Gm-Message-State: ACrzQf1vZ3Uf5iMXvm32LPOcF/uze4Z9QJnQO7Jc4qlp2ZAs7ehvDXVa
        nAPYTRqH5pi1U2rLlwl0dP18Fac79cicLIXUc+0=
X-Google-Smtp-Source: AMsMyM7s7gTrjG5ymH3U15IUsSK/Ewsk3Nv/sC9qIh/OUwZPjVtqqFjgvJyAbTuiV9RabeXQphO5cy2c2GW3Yq+W2es=
X-Received: by 2002:a05:6638:25cb:b0:35b:b1cd:c411 with SMTP id
 u11-20020a05663825cb00b0035bb1cdc411mr395294jat.308.1664382975350; Wed, 28
 Sep 2022 09:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-11-ojeda@kernel.org>
 <YzRoZwhxE4182cm2@liuwe-devbox-debian-v2>
In-Reply-To: <YzRoZwhxE4182cm2@liuwe-devbox-debian-v2>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 28 Sep 2022 18:36:04 +0200
Message-ID: <CANiq72kXHQSbGjavdOKgDK4FnGYCeC3B4ZfgZDU5KD_ZLKn7RQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/27] rust: add `macros` crate
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
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

On Wed, Sep 28, 2022 at 5:29 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> Just a general question: what is the house rule for adding new proc
> macros? They are powerful tools. I can see their value in `module!`
> because writing all that boilerplate by hand is just painful. Yet they
> are not straightforward to understand. It is difficult, just by looking
> at the macro, to fully grasp what the final code looks like (though the
> rsi target will help). Is there a concern that proc macro gets abused?

The rule is "use them as last resort". That is, they are not banned,
but they need to be justified: if there is an alternative that is not
too bad (e.g. in terms of ergonomics or implementation), then the
alternative should be used instead.

Nevertheless, sometimes they are very handy. Apart from `module!`
here, we are currently using them in the full repo for vtables [1] and
the Asahi M1 GPU driver is using them for versioning [2].

It is also possible to make proc macros easier to handle, for instance
if we end up deciding to allow utilities like the `syn` crate.

[1] https://github.com/Rust-for-Linux/linux/blob/fcad53ca9071c7bf6a412640a82e679bad6d1cd4/rust/macros/lib.rs#L99-L148
[2] https://github.com/AsahiLinux/linux/blob/3c8982e2c78c219bf96761445c8b73c2b3034fba/drivers/gpu/drm/asahi/fw/buffer.rs#L43-L56

Cheers,
Miguel
