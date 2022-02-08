Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CB4AD047
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 05:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346863AbiBHESC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 23:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244191AbiBHESB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:18:01 -0500
X-Greylist: delayed 195 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 20:18:00 PST
Received: from condef-03.nifty.com (condef-03.nifty.com [202.248.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F1AC0401DC;
        Mon,  7 Feb 2022 20:18:00 -0800 (PST)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-03.nifty.com with ESMTP id 2184BomB007335;
        Tue, 8 Feb 2022 13:11:50 +0900
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2184BHd9013266;
        Tue, 8 Feb 2022 13:11:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2184BHd9013266
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644293478;
        bh=j+aPXdq2sicmNcexcHQA/oJ6M8by9veF/5qbR5FdEAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rVvdXfg38TArY3w3QYhn1Uw2hhDdN5Q+UFPtxx+zqe7FFMjw60XeWxqYl/jhsH6Td
         EpytE8eF0T4lDLkue7Df/JP/Ku/x6xfFejGNjJCv2/1GMKcvLbplFLAE1iB3IrLACv
         b9qaTVnlKugwrFoBGsmzS/4xv6ksUkFpm5JJ8rGUAt1IS+1Pdvot7IXojMYqsargrp
         OxHZHRRvbDCpHWIoQhcDrmFWCQ1iHrgA/dtMJOkN8pIW6jlLwU9AYVxwVOg1LpRfhq
         KNkJUkxYZ8U4d083XxnYc7BNegV0EugcJpQF0aUN6eBbfRDU9HTM9TGfyEUC+0j4Uy
         26HiHcqm0MJnw==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id om7so1827244pjb.5;
        Mon, 07 Feb 2022 20:11:17 -0800 (PST)
X-Gm-Message-State: AOAM532ZYqPmMVPTAoC75lm8n0vvgfIGp8LG17v0fSusYJaJEUlLANnW
        bCc7hLz3QD59P1i6UyzGsYOxDchkmzYvMsVfU14=
X-Google-Smtp-Source: ABdhPJy4Kyyql8eQlLfvhsuGVW6htuxsp20B0z3n+90WIg7ccLHI9OZNKuoLNUKr/MQH0Ozr2+TR7zD0OI+oVCQGWkE=
X-Received: by 2002:a17:903:22cd:: with SMTP id y13mr2749421plg.99.1644293476950;
 Mon, 07 Feb 2022 20:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20220125064027.873131-1-masahiroy@kernel.org> <CAKwvOdm=-x1EP_xu2V_OZNdPid=gacVzCTx+=uSYqzCv+1Rbfw@mail.gmail.com>
 <87h79rsbxe.fsf@collabora.com> <CAK7LNARSDZUyt_JXhQLKW++9p0NqM1FHncqGMqXPqfU7m3tizA@mail.gmail.com>
In-Reply-To: <CAK7LNARSDZUyt_JXhQLKW++9p0NqM1FHncqGMqXPqfU7m3tizA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Feb 2022 13:10:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASU=FeOjkZKB=mM-UnfH-hCY0y64y5h3b0qgDDXs1faHA@mail.gmail.com>
Message-ID: <CAK7LNASU=FeOjkZKB=mM-UnfH-hCY0y64y5h3b0qgDDXs1faHA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: unify cmd_copy and cmd_shipped
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Michal Simek <monstr@monstr.eu>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Jan 26, 2022 at 7:11 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Nick Desaulniers <ndesaulniers@google.com> writes:
> >
> > > On Mon, Jan 24, 2022 at 10:41 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >>
> > >> cmd_copy and cmd_shipped have similar functionality. The difference is
> > >> that cmd_copy uses 'cp' while cmd_shipped 'cat'.
> > >>
> > >> Unify them into cmd_copy because this macro name is more intuitive.
> > >>
> > >> Going forward, cmd_copy will use 'cat' to avoid the permission issue.
> > >> I also thought of 'cp --no-preserve=mode' but this option is not
> > >> mentioned in the POSIX spec [1], so I am keeping the 'cat' command.
> > >>
> > >> [1]: https://pubs.opengroup.org/onlinepubs/009695299/utilities/cp.html
> > >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied to linux-kbuild.



> > >> ---
> > >>
> > >>  arch/microblaze/boot/Makefile     |  2 +-
> > >>  arch/microblaze/boot/dts/Makefile |  2 +-
> > >>  fs/unicode/Makefile               |  2 +-
> > >>  scripts/Makefile.lib              | 12 ++++--------
> > >>  usr/Makefile                      |  4 ++--
> > >>  5 files changed, 9 insertions(+), 13 deletions(-)
> > >>
> > >> diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
> > >> index cff570a71946..2b42c370d574 100644
> > >> --- a/arch/microblaze/boot/Makefile
> > >> +++ b/arch/microblaze/boot/Makefile
> > >> @@ -29,7 +29,7 @@ $(obj)/simpleImage.$(DTB).ub: $(obj)/simpleImage.$(DTB) FORCE
> > >>         $(call if_changed,uimage)
> > >>
> > >>  $(obj)/simpleImage.$(DTB).unstrip: vmlinux FORCE
> > >> -       $(call if_changed,shipped)
> > >> +       $(call if_changed,copy)
> > >>
> > >>  $(obj)/simpleImage.$(DTB).strip: vmlinux FORCE
> > >>         $(call if_changed,strip)
> > >> diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
> > >> index ef00dd30d19a..b84e2cbb20ee 100644
> > >> --- a/arch/microblaze/boot/dts/Makefile
> > >> +++ b/arch/microblaze/boot/dts/Makefile
> > >> @@ -12,7 +12,7 @@ $(obj)/linked_dtb.o: $(obj)/system.dtb
> > >>  # Generate system.dtb from $(DTB).dtb
> > >>  ifneq ($(DTB),system)
> > >>  $(obj)/system.dtb: $(obj)/$(DTB).dtb
> > >> -       $(call if_changed,shipped)
> > >> +       $(call if_changed,copy)
> > >>  endif
> > >>  endif
> > >>
> > >> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> > >> index 2f9d9188852b..74ae80fc3a36 100644
> > >> --- a/fs/unicode/Makefile
> > >> +++ b/fs/unicode/Makefile
> > >> @@ -31,7 +31,7 @@ $(obj)/utf8data.c: $(obj)/mkutf8data $(filter %.txt, $(cmd_utf8data)) FORCE
> > >>  else
> > >>
> > >>  $(obj)/utf8data.c: $(src)/utf8data.c_shipped FORCE
> > >
> > > do we want to retitle the _shipped suffix for this file to _copy now, too?
> > > fs/unicode/Makefile:11
> > > fs/unicode/Makefile:33
> > > fs/unicode/Makefile:34
> >
> > I think _copy doesn't convey the sense that this is distributed with the
> > kernel tree, even though it is also generated from in-tree sources.
> > Even if that is not the original sense of _shipped (is it?), it makes
> > sense to me that way, but _copy doesn't.
> >
> > The patch looks good to me, though.
> >
> > Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >
> >
> > >
>
> I only renamed the action part (cmd_shipped -> cmd_copy)
> because I thought it was clearer.
>
> Actually I do not get the sense of _shipped pretty much, but
> I think we can keep the file suffix part (utf8data.c_shipped) as is.
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
