Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5000759CB88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 00:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiHVWfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 18:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbiHVWfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:35:23 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D34491E3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 15:35:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bx38so11924378ljb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=/3Qz2I07qNsEqmUXX8sV18RiE73NXZbJtJL/a6pTzOM=;
        b=oWPtAluKai50SM+qKue2D41Qzws4/k+V5RWd5eefNxz1X9aicH59ZvpfnjRJXMaLQs
         oqxP/yJYA/pA0XUC3IAQ2pMsUZC5KWJCBsJB87xXEHpXJYh3UsodLH0bSrdVTyW8PqVU
         fl7bU/ZoUTjyKr6lYqkht34lemnsdk4xtG++3RabmhF1f8ccW1cPhtNqTlSyiEEcsLzu
         YmlkZJbQ8uLeYszYrnjAf1BiPDqMYPF7w2OYYQuBY8Qlu0DW1tannUkwgTEalQVTDxVO
         5e5PuucVBSjpt4Fd7T9Y4gljaVUNRJApsbm1Vq6Mzh8cdPFYHKbekz+4ISdZpBbhyJKO
         Yejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=/3Qz2I07qNsEqmUXX8sV18RiE73NXZbJtJL/a6pTzOM=;
        b=LNsdXBv3VNHd0BcRYMNPAKsPZDo9sLvdGdYa9KCB2qp3jYhNX6JqswKB3LwDdzVfc5
         blTAYDrJ8WtMRCl/aDTK3EXDCqHDD1EwXVQl0eZD1SYw0fkOC6g2VyifNm40ojcypU94
         5qR6jIV//zHRx1KTrwXNoNQHBy6AWaHx9U51068PIN9lKOuktwa3QwPu6jTvfIRLwZ9v
         /Sdl+JcLeCWJMGP3OqN0jZ84nuqCuutbfACi9crUKmCAGCDL3xmzA1/EfC4pJa7AkNE3
         +l43Arooxy4jhQoUN/LE5LeXFE/CusL2RBFxqp4YhMO5DeUUjnKzMzDnwDaGthHfbRKN
         qcvg==
X-Gm-Message-State: ACgBeo2br67hmisaVITcHnfvwKOIrikQ17KAVOdL67KtZolH7TMK65Pm
        IErvGAfE6hj+u4ac8DpBG45+ADTOO+5itwAJ8Q78bw==
X-Google-Smtp-Source: AA6agR7Tldikzvhh2Bk23FXDw9lViwJukpyd5ZjJCRNzpjlVddMHxOB5z715HFFouGcVhLUk2TreqJEweh3FvxQ/Ygg=
X-Received: by 2002:a2e:9dc5:0:b0:25e:6fa0:1243 with SMTP id
 x5-20020a2e9dc5000000b0025e6fa01243mr6684227ljj.513.1661207718102; Mon, 22
 Aug 2022 15:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-24-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-24-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Aug 2022 15:35:05 -0700
Message-ID: <CAKwvOd=y5T9bh4398K+5=82q=vVbkjQQ76KyXLy-qoM2Tph08A@mail.gmail.com>
Subject: Re: [PATCH v9 23/27] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 On Fri, Aug 5, 2022 at 8:44 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Having most of the new files in place, we now enable Rust support
> in the build system, including `Kconfig` entries related to Rust,
> the Rust configuration printer and a few other bits.

Cool, I'm finally happy with this patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

I built and boot tested with CONFIG_RUST enabled, played with
CLIPPY=3D1, and built all of the new make targets for rust.

Thanks for all of the work that went into these series from all of the
authors and Miguel for your determination. Keep it up!

I've left comments on other patches (and I will leave one on
rust/compiler_builtins.rs because I still don't like that approach)
and there may be small cleanups we can do here or there, but I think
we're in good shape to land something and start iterating on it
upstream.  I'll file bugs in your issue tracker for small nits I come
across, but so far, it's been more-so questions.

---

LWN recently demonstrated that most fixes are in relatively younger
code: https://lwn.net/Articles/902854/

An analysis of 0day exploits found in the wild in 2021 showed that for
Android, researchers are attacking drivers:
https://googleprojectzero.blogspot.com/2022/04/the-more-you-know-more-you-k=
now-you.html

Multiple independent reports cite high numbers (70% or more) of memory
safety issues in native code:
https://www.memorysafety.org/docs/memory-safety/

I have colleagues that are developing a microkernel (they then use a
memory unsafe language for their kernel as well :^P ) to move as much
functionality as possible into lower levels of privilege.  It's
interesting and I wish them well, but I also prefer more incremental
approaches to existing solutions, and suspect the way of the monolith
to still give us the best performance.

I learned an interesting word the other day: Corten Steel
from the YouTube channel Practical Engineering (it's a great channel
on Civil Engineering):
https://www.youtube.com/watch?v=3D2RbiCOFffRs&t=3D523s
transcript:

>> I should also note that there are even steel alloys whose rust is protec=
tive! Weathering steel (sometimes known by its trade name of Corten Steel) =
is a group of alloys that are naturally resilient against rust because of p=
assivation. A special blend of elements, including manganese, nickel, silic=
on, and chromium don=E2=80=99t keep the steel from rusting, but they allow =
the layer of rust to stay attached, forming a protective layer that signifi=
cantly slows corrosion.

My hope is that Rust may provide a layer of Corten Steel to the Linux
kernel to help us protect newly written driver code from memory safety
related issues, so that Linux remains the best option for developing
products for the next 30 years. I also suspect it may bring in a whole
new generation of hackers to the kernel ecosystem.  That is my
blessing for Rust in the Linux kernel.
--
Thanks,
~Nick Desaulniers
