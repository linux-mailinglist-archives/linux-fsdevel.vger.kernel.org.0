Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DD339D650
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFGHvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 03:51:04 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:17928 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGHvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:51:03 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jun 2021 03:51:02 EDT
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-06.nifty.com with ESMTP id 1577ejMR032763;
        Mon, 7 Jun 2021 16:40:45 +0900
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 1577e4cr029736;
        Mon, 7 Jun 2021 16:40:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1577e4cr029736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1623051605;
        bh=EKJEqB3Q6tIfy2A4ywMNYaG/WTIqmzMmTredZAM1eyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rCbmr+PJtfqOvYdx+tg6tNe+ulGgWc8DM4wPOwDOMxO464uhW3SM4YIp8ouiWr6D2
         yFDq3SUMr6K9d+k5CD8oaK0+wjbbkRKpgzxm5gU6Jt6sHwUJgPukt+Ie+EUJidvouB
         QCipHwGMraBCrfZK+6+YKhTBqf1Ry9qjyiqwPM/8++rBqeoo5ZmqM3pP0yXVOqriyR
         KAOmcpss4ARyFtb8cITGpqkbe3DgZZR7YsNJvfFhcNz9GrjTi5d/JwxNdvLO3yrTJ5
         Pw7WfuQyhmz6+DkHWz7V0TVVxdSewlTy3Q2hCQmMNnHwBP8yFWvNhLBsudkRKgWHHz
         To5r+JyNQhNtg==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id j15so8412318vsf.2;
        Mon, 07 Jun 2021 00:40:04 -0700 (PDT)
X-Gm-Message-State: AOAM530ilV7x9BOYsxhMHcnwVwqHaih58l/6kueGfJCzvVlGiGTj+8dd
        PXKRy3Ke8jMTTkQathvLHaRFAv3O3xAwgDA5ZIY=
X-Google-Smtp-Source: ABdhPJwPmFut2nTxArXa07v4xPlHzxrJ0sLjVDtvrdtLChTFpKiR9239Z6WTj44UnleODc79Z+HXDtosElosU9UFvGs=
X-Received: by 2002:aa7:99c9:0:b029:2e9:e084:e1de with SMTP id
 v9-20020aa799c90000b02902e9e084e1demr15812551pfi.80.1623051593156; Mon, 07
 Jun 2021 00:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210227183910.221873-1-masahiroy@kernel.org> <CAK7LNASL_X43_nMTz1CZQB+jiLCRAJbh-wQdc23QV0pWceL_Lw@mail.gmail.com>
 <20210228064936.zixrhxlthyy6fmid@24bbad8f3778>
In-Reply-To: <20210228064936.zixrhxlthyy6fmid@24bbad8f3778>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 7 Jun 2021 16:39:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASY_+_38XEMLZAf7txr4EdukkcFL8pnGGe2XyhQ9F4oDQ@mail.gmail.com>
Message-ID: <CAK7LNASY_+_38XEMLZAf7txr4EdukkcFL8pnGGe2XyhQ9F4oDQ@mail.gmail.com>
Subject: Re: [PATCH RFC] x86: remove toolchain check for X32 ABI capability
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fangrui Song <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jethro Beekman <jethro@fortanix.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 28, 2021 at 3:49 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sun, Feb 28, 2021 at 12:15:16PM +0900, Masahiro Yamada wrote:
> > On Sun, Feb 28, 2021 at 3:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > This commit reverts 0bf6276392e9 ("x32: Warn and disable rather than
> > > error if binutils too old").
> > >
> > > The help text in arch/x86/Kconfig says enabling the X32 ABI support
> > > needs binutils 2.22 or later. This is met because the minimal binutils
> > > version is 2.23 according to Documentation/process/changes.rst.
> > >
> > > I would not say I am not familiar with toolchain configuration, but
> >
> > I mean:
> > I would not say I am familiar ...
> > That is why I added RFC.
> >
> > I appreciate comments from people who are familiar
> > with toolchains (binutils, llvm).
> >
> > If this change is not safe,
> > we can move this check to Kconfig at least.
>
> Hi Masahiro,
>
> As Fangrui pointed out, there are two outstanding issues with x32 with
> LLVM=1, both seemingly related to LLVM=1.

Is this still a problem for Clang built Linux?



> https://github.com/ClangBuiltLinux/linux/issues/514

I am not tracking the status.
What was the conclusion?

> https://github.com/ClangBuiltLinux/linux/issues/1141


This got marked "unreproducible"

>
> Additionally, there appears to be one from Arnd as well but that one has
> received no triage yet.
>
> https://github.com/ClangBuiltLinux/linux/issues/1205

Same as well.


>
> I intend to test this patch as well as a few others at some point in the
> coming week although I am having to play sysadmin due to moving servers
> so I might not be able to get to it until later in the week.
>
> Cheers,
> Nathan
>


-- 
Best Regards
Masahiro Yamada
