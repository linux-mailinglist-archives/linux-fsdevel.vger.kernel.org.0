Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833CE587E9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbiHBPJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 11:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiHBPJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:09:19 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4A27FEE;
        Tue,  2 Aug 2022 08:09:18 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j20so5678186ila.6;
        Tue, 02 Aug 2022 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnTubc6T2moNEJDYoN4cgfDzPxoHQtes0c+6H3Y5Dww=;
        b=pkkYVaCXoDjN3BxJA9fdnVundUXhEs1ZNjfqqqRGarF5AV++es8DHqocJO+FlDtBo2
         K9VLQBHIKirR+kBAZXEW9X3tax+LPb3OLjnPtBLoJhQvOpYVhyum0CDwjRQmi8N3QLG9
         qVZKGbs47r3RtFLMkEjxsxA5QRB0Pkop+q4m7mjlwSgMKR5zZqDQjBomHGV1Us1vun9a
         vz+DnLQ27XHfdmEC6MvRGoByNQNFIbb1wMouC5XlTA9YXSvZ12GajCS96japFxJgfg9b
         tHVgeXFpFd/wEAlJhB2ZChsOmOVxsmNul/LP5dMDpuISoJLCiJvTU58sqjiz4XsvWNCB
         Ou/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnTubc6T2moNEJDYoN4cgfDzPxoHQtes0c+6H3Y5Dww=;
        b=ezLDAmC6BHmFs42TUEiMJrWk68fzsM8u6A+ZX1eNNXAZNZaksw1+J4auCXRX6ue0aZ
         Gk0xJHAb081hhcUxIiD2QgfqY2XxDCY6NWevAtWSXh+IzUruc1+hJ7hW7xFV/TaiAK2k
         Z7ktxvRTP+6edKyT/49XTEq3hz+8YN8PJ4IYUr3SUQ72wuAT2+3RX8yiS3RsZZFnS7DD
         CyTfGBv1u5tbwmrHbncBMpQnReoysvoI32CSithMhAHYS4dh3wnhOYyOPQPilNDYYMqK
         P/9P1QqNSIqeZcti+AeggwmvXK/nUnI7UlUJXW1s6fRdzn5vhpuYn19qQHeNa7WGHUYI
         PkSQ==
X-Gm-Message-State: AJIora/6NvwLb4B9ZdIwlPvsEYEk4XVuYwzs9uS636pBZmPxEuZpHwX8
        NntW69t02RHSEUEX0rXe4KtG6IcV86IW8j5et0A=
X-Google-Smtp-Source: AGRyM1s/X7XdR0/a8lkQRbVcBP+dwZOZipEH93h8R/VlEWYf/KISRMdds5FIhduFNaDE0FsZQymaRLP6g1Da/s6WJVw=
X-Received: by 2002:a05:6e02:17c6:b0:2dd:d9dc:6387 with SMTP id
 z6-20020a056e0217c600b002ddd9dc6387mr8296085ilu.321.1659452957891; Tue, 02
 Aug 2022 08:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <YukYByl76DKqa+iD@casper.infradead.org>
 <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com> <YukuUtuXm/xPUuoP@casper.infradead.org>
In-Reply-To: <YukuUtuXm/xPUuoP@casper.infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Aug 2022 17:09:05 +0200
Message-ID: <CANiq72kgwssTSE7F+4xkRrXBGVgHeWxCyjeZ-NHLUXWnFjMyTg@mail.gmail.com>
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

On Tue, Aug 2, 2022 at 4:01 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> No objections to any of this.  I love the idea of being able to write
> filesystems in Rust.  I just think it would go more smoothly if
> linux-fsdevel were involved more closely so people at least have the
> option of being able to follow design decisions, and hopefully influence
> them.  That goes both ways, of course; I hardly think our current
> operations structures are the optimum way to implement a filesystem,
> and having fresh eyes say things like "But that shouldn't be part of the
> address_space_operations" can impel better abstractions.

I will send the patches to fsdevel then!

As for following development closely and design decisions, we have
been doing it in GitHub so far pre-merge, so the easiest until the
merge (for us) would be to ping you there. We can also send you copies
of the `fs` related patches too if you would like that. I would highly
recommend joining the monthly informal calls too.

(I appreciate the kind answer, by the way!)

> The obvious answer is to split out the 'fs module' into its own patch
> ;-)  I presume it was part of the kernel crate which would have been
> either patch 17 or 11 in that series?

Yeah, patch 17, exactly (patch 11 is the `alloc` import). I have asked
Konstantin privately about them.

In any case, I will split the patches further for v9 which should help.

Meanwhile, you can also see the `fs` module here, if you are curious:

    https://github.com/Rust-for-Linux/linux/blob/rust-next/rust/kernel/fs.rs
    https://github.com/Rust-for-Linux/linux/blob/rust-next/rust/kernel/fs/param.rs

Cheers,
Miguel
