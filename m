Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613E7597851
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbiHQU4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241761AbiHQU4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:56:34 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DACA927F;
        Wed, 17 Aug 2022 13:56:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z72so2766129iof.12;
        Wed, 17 Aug 2022 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2F8UapFM6fvTc5fGCMprtfZuN5LHlZVrraMyXumfVqE=;
        b=LbgMGsGKphl7X2/Jn0u5eMcUeY0mew1lHqKEqfLaBcD42X17Re8z5rpOQYmW5Vtdo9
         tsbQAaIFqFo5BvaBx68dsfnuUwQq92cWSEI/zxlhcsjD+kx3hydeBmsw4hEX1VPxHNvw
         tKWoDZfnYemoNlsbZC7T5Vg/Y7CgUmUyqnX6JuDfQU0jfZ/7c2KoYLaCTzWOhZsNLkVP
         vqeWW/J4WU3sDEN/7KdViU1V3Y9L/UKbFfVhaY7IJ3DWdEMKtg8uJdqyaFYcyhIYcwBa
         fVXnH6CAm8WsCTJgnXY6K1pGRxlZiwyjtMG1yPSDD/ZtE6bHaFuxIcURQjWPG9D+DslS
         ipSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2F8UapFM6fvTc5fGCMprtfZuN5LHlZVrraMyXumfVqE=;
        b=mX/m7Rk10kWwjaZUStBjmmTzu9xYgrTmgaYkbXjiXyMTiSB2DTDb2kS1hDSRWqrH4G
         9JKcGtO/axXs21B7rBpxw6N7rXv7EF1jOYful0wl09lAh8DNqozhEwuMbl05d4V7es2+
         3SsEJy7F5qJR4pkfptXWsV0tA7siOXjam/WshiZdeq+kjhDOmaXYi4Q/FC2GI6xMN2Ti
         oHo5Fg0FpOsTHGneaK6Mc7IKMmo4nzSxfpAEzh3JHu03oQdbSCXqvS+WOplVxvlv8LMs
         WCusQkNXbpT+5viiYV8j0RWAzPVLo7p3xkDt6dY9lx1BpfNJ98om5JcpNluerZDQOFJV
         oS9g==
X-Gm-Message-State: ACgBeo0R1EOoZuYZI2iTEz2/CngqZXnat7lGtVu0meSTWN7+aT2CV3g0
        QZlmXpA4XOuArOXeHnm6VlSCjbrBlVrZQtyIgoU=
X-Google-Smtp-Source: AA6agR7W0/vJMmLEu2GKK6hHojDe0NnOQN0sm9gqWwqOLGfYNe/j8D+Y8j9wEt1Kx9LD5aIinElIOM+NZfs9EfUUXfw=
X-Received: by 2002:a5d:8618:0:b0:684:6469:596b with SMTP id
 f24-20020a5d8618000000b006846469596bmr10939iol.177.1660769793009; Wed, 17 Aug
 2022 13:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-24-ojeda@kernel.org>
 <202208171324.FB04837@keescook>
In-Reply-To: <202208171324.FB04837@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 17 Aug 2022 22:56:21 +0200
Message-ID: <CANiq72=E9c0YNvww6r=Zj1SHNV9OjvNMUFPD_w8_yJNTX-7-eQ@mail.gmail.com>
Subject: Re: [PATCH v9 23/27] Kbuild: add Rust support
To:     Kees Cook <keescook@chromium.org>
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
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

On Wed, Aug 17, 2022 at 10:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> It'd be nice to split this up into maybe per-target patches, but given
> how long this has been getting developed, I'd prefer to avoid blocking
> on that, and just get this series landed so we can move to incremental
> fixes/additions.

When I started the series, I considered several approaches, and in the
end opted for "setup as much as possible before the flag-patch that
enables the Kbuild support", which was simple, though indeed the
Kbuild patch remained fairly big.

Then some people commented on that patch over several versions, so I
kept the simple strategy :)

What I can look into is moving the optional targets out of this patch,
putting them after the "flag-patch", since they may be considered
"additional features" anyway. In fact, for the trimming down in v9, I
thought about removing them entirely. It will not change things too
much, since they are small, but it may help.

For v9 I nevertheless attempted to simplify this patch by doing the
"move all new, big files to their own patch" (see my reply at [1]), so
it is fairly smaller than in previous versions.

[1] https://lore.kernel.org/lkml/CANiq72nzOQSd2vsh2_=0YpGNpY=7agokbgi_vBc5_GF4-02rsA@mail.gmail.com/

Cheers,
Miguel
