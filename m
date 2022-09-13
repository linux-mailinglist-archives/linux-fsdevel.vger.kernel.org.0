Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ADA5B6803
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 08:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiIMGi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 02:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIMGi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:38:26 -0400
X-Greylist: delayed 52187 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 23:38:24 PDT
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B09A4F183;
        Mon, 12 Sep 2022 23:38:24 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 28D6c01e019386;
        Tue, 13 Sep 2022 15:38:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 28D6c01e019386
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663051081;
        bh=tV9nEuhwkJ7n1kuPj+d/5yMKIVBWOfelLB6nLnhI3Mk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nm7qyo/ZC8X5f+9Ia6Hy/XzQk6ncm8qP33zbXv9UtHpUJqgVPmyYTyw7o7AuLActU
         5krhadDZtEg101BvUQFJNd1U/RdwtulP5zGgTYqYqDFNeHECFrtCWOuPiSLIDpPUFK
         KFMXczU460o4Nvr+PVrQHFsRkhQVf5EH6lUjhczfQEfdYrc0pt/UAgEj9lYT1qVQTj
         6OZ3+oMpCx+uxWqLzDQ/DDmyF1hh+O2+JGBZ38ANs4Leadxx4DkWXquNBPMqiI0SSS
         7wMzK7FsiuYTTJLuK/vWGzpDX3xVQXPb+UM2YPGCPXpKYczsWn/nYkHbVWwAL/Gc6k
         OLKmroaCMPRtg==
X-Nifty-SrcIP: [209.85.210.52]
Received: by mail-ot1-f52.google.com with SMTP id ck2-20020a056830648200b0065603aef276so1995683otb.12;
        Mon, 12 Sep 2022 23:38:00 -0700 (PDT)
X-Gm-Message-State: ACgBeo1sRIqBoChayjWSBZpZfaeb8cxVeiFDzbbA/aza6viJgoso2UFC
        JBdO3BwumHd1PttITVtGwUudAlTwiBfKjLNGF1M=
X-Google-Smtp-Source: AA6agR4ojz4kLyVwdg7KfNkE5DVjkROUMO6/BtwnXe2vVwLJN+exmsnfjgUzLo1y5NNjY/Xb+Bo/6iEHpf8JX1AtcYE=
X-Received: by 2002:a05:6830:658b:b0:63b:3501:7167 with SMTP id
 cn11-20020a056830658b00b0063b35017167mr12198963otb.343.1663051079814; Mon, 12
 Sep 2022 23:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-24-ojeda@kernel.org>
 <CAK7LNAQ=JfmrnGAUNXm_4RTz0fOhzfYC=htZ-VuEx=HAJPNtmw@mail.gmail.com> <CANiq72kZEqAwr_m14mAFjHsFJTLjj7i4He0qyrprubpmBfOFdw@mail.gmail.com>
In-Reply-To: <CANiq72kZEqAwr_m14mAFjHsFJTLjj7i4He0qyrprubpmBfOFdw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 13 Sep 2022 15:37:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzund0a=t6gz3Mfex3j6jMfjYW--nqv9x_wY=RzSR-=g@mail.gmail.com>
Message-ID: <CAK7LNASzund0a=t6gz3Mfex3j6jMfjYW--nqv9x_wY=RzSR-=g@mail.gmail.com>
Subject: Re: [PATCH v9 23/27] Kbuild: add Rust support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        patches@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
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
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 1:18 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Masahiro,
>
> On Mon, Sep 12, 2022 at 5:08 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > I have not figured out where this difference comes from.
>
> It is the `RUSTC_BOOTSTRAP` environment variable: it allows to use
> unstable featuers in the stable compiler.


Thanks, I learned a new thing.


>
> We currently set it in the global `Makefile`, but we could be more
> explicit and do it on each command if you think that would be better.


I checked "make compile_commands.json", but it collects build commands
only for C.


I did not see any bad scenario with the current approach.








>
> If you want that we keep using the global export, then we can add a
> comment explaining this to clarify.
>
> Cheers,
> Miguel
--
Best Regards
Masahiro Yamada
