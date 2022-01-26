Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0077A49C132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiAZCUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:20:19 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:29093 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiAZCUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:20:19 -0500
X-Greylist: delayed 70697 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 21:20:18 EST
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 20Q2K38l011369;
        Wed, 26 Jan 2022 11:20:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 20Q2K38l011369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1643163603;
        bh=NdWl0KwbxPAcxWKk3OI0mf1nWCR1CFOUSSVdy5q/57Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RGbUPJMgEgFXMr11YWFoRNcrMdGZaHn8f+NckfU36XynBUzWcokfuuKDD2MjYtxFT
         wJAIsFzZpyYTNPV3kMGl7kJtJXbQb329v2c6DYfSLq8xTwyFlS610JPog4+sfKCdLQ
         7HukkDOPnZG6m7PuuIfIeBwlJ6rOffs+qBLgRm/hQpsyUKrYuCB0ZS+NKVueSfJi03
         PAeGWc/Bw3pUCod5AGCrb6Se3JiBP2AvbuvOLdzM5TG+fPiSSbt4zqvEONC3dt/tzd
         oIrOV1LjwpwAe+r4bNwBZt3QXQnWZpk/cgrgbk/6lfCgxDAuI8A9JL2xVh6djDiKXc
         2aCfkaYn1ipCQ==
X-Nifty-SrcIP: [209.85.215.175]
Received: by mail-pg1-f175.google.com with SMTP id h23so19842640pgk.11;
        Tue, 25 Jan 2022 18:20:03 -0800 (PST)
X-Gm-Message-State: AOAM533rEizy1uNPKcVs8lgySKfGBG3PZNU0S7HwhcmPiIPISdQcKZ7j
        DvvDG2EW+7IYgco6Bci2WZfnWQNzl0VIrZzvoys=
X-Google-Smtp-Source: ABdhPJwwWgQ3DGgDxHDnKrFh4JmbcnC+EjCTj7R4RHw0SwNIZ3GLRZEWfZKMQiRBZtpo2DoTmIpgGbD2r08mQv+5xxs=
X-Received: by 2002:a05:6a00:a8e:b0:4bd:22a:bb1d with SMTP id
 b14-20020a056a000a8e00b004bd022abb1dmr21071279pfl.32.1643163602190; Tue, 25
 Jan 2022 18:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20220125064027.873131-1-masahiroy@kernel.org> <CAKwvOdm=-x1EP_xu2V_OZNdPid=gacVzCTx+=uSYqzCv+1Rbfw@mail.gmail.com>
 <87h79rsbxe.fsf@collabora.com>
In-Reply-To: <87h79rsbxe.fsf@collabora.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 26 Jan 2022 11:19:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSDZUyt_JXhQLKW++9p0NqM1FHncqGMqXPqfU7m3tizA@mail.gmail.com>
Message-ID: <CAK7LNARSDZUyt_JXhQLKW++9p0NqM1FHncqGMqXPqfU7m3tizA@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 7:11 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Nick Desaulniers <ndesaulniers@google.com> writes:
>
> > On Mon, Jan 24, 2022 at 10:41 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >>
> >> cmd_copy and cmd_shipped have similar functionality. The difference is
> >> that cmd_copy uses 'cp' while cmd_shipped 'cat'.
> >>
> >> Unify them into cmd_copy because this macro name is more intuitive.
> >>
> >> Going forward, cmd_copy will use 'cat' to avoid the permission issue.
> >> I also thought of 'cp --no-preserve=mode' but this option is not
> >> mentioned in the POSIX spec [1], so I am keeping the 'cat' command.
> >>
> >> [1]: https://pubs.opengroup.org/onlinepubs/009695299/utilities/cp.html
> >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >> ---
> >>
> >>  arch/microblaze/boot/Makefile     |  2 +-
> >>  arch/microblaze/boot/dts/Makefile |  2 +-
> >>  fs/unicode/Makefile               |  2 +-
> >>  scripts/Makefile.lib              | 12 ++++--------
> >>  usr/Makefile                      |  4 ++--
> >>  5 files changed, 9 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
> >> index cff570a71946..2b42c370d574 100644
> >> --- a/arch/microblaze/boot/Makefile
> >> +++ b/arch/microblaze/boot/Makefile
> >> @@ -29,7 +29,7 @@ $(obj)/simpleImage.$(DTB).ub: $(obj)/simpleImage.$(DTB) FORCE
> >>         $(call if_changed,uimage)
> >>
> >>  $(obj)/simpleImage.$(DTB).unstrip: vmlinux FORCE
> >> -       $(call if_changed,shipped)
> >> +       $(call if_changed,copy)
> >>
> >>  $(obj)/simpleImage.$(DTB).strip: vmlinux FORCE
> >>         $(call if_changed,strip)
> >> diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
> >> index ef00dd30d19a..b84e2cbb20ee 100644
> >> --- a/arch/microblaze/boot/dts/Makefile
> >> +++ b/arch/microblaze/boot/dts/Makefile
> >> @@ -12,7 +12,7 @@ $(obj)/linked_dtb.o: $(obj)/system.dtb
> >>  # Generate system.dtb from $(DTB).dtb
> >>  ifneq ($(DTB),system)
> >>  $(obj)/system.dtb: $(obj)/$(DTB).dtb
> >> -       $(call if_changed,shipped)
> >> +       $(call if_changed,copy)
> >>  endif
> >>  endif
> >>
> >> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> >> index 2f9d9188852b..74ae80fc3a36 100644
> >> --- a/fs/unicode/Makefile
> >> +++ b/fs/unicode/Makefile
> >> @@ -31,7 +31,7 @@ $(obj)/utf8data.c: $(obj)/mkutf8data $(filter %.txt, $(cmd_utf8data)) FORCE
> >>  else
> >>
> >>  $(obj)/utf8data.c: $(src)/utf8data.c_shipped FORCE
> >
> > do we want to retitle the _shipped suffix for this file to _copy now, too?
> > fs/unicode/Makefile:11
> > fs/unicode/Makefile:33
> > fs/unicode/Makefile:34
>
> I think _copy doesn't convey the sense that this is distributed with the
> kernel tree, even though it is also generated from in-tree sources.
> Even if that is not the original sense of _shipped (is it?), it makes
> sense to me that way, but _copy doesn't.
>
> The patch looks good to me, though.
>
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
>
> >

I only renamed the action part (cmd_shipped -> cmd_copy)
because I thought it was clearer.

Actually I do not get the sense of _shipped pretty much, but
I think we can keep the file suffix part (utf8data.c_shipped) as is.


-- 
Best Regards
Masahiro Yamada
