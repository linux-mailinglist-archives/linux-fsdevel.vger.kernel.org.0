Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6155A07CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 06:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiHYETT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 00:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYETS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:19:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292759CCF2;
        Wed, 24 Aug 2022 21:19:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so24502071edd.13;
        Wed, 24 Aug 2022 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Rf7A1N3M8eXRQTfFVYNwPPvk6e2z76n204IQCLMe0go=;
        b=HfJjtGl1KtGKSrwt4GbSOLfKxPC1KxIVcSho7oaeTgJr2KYTfDPQPIx99inKyesWLS
         YZG1kDI9s8fNFkXuKAELT/oebz0Ta97HJPiil0S9Af2pWd1YQ7pW547xDPvVDwLwNN4z
         4jNn2dzeKtTWPlZ7RYy4ysJcb7VSFLsExikkCeI/pwruJUsbea695pDyb7MKHEiCsn/m
         JJkEqKz58tj4yJ1gBgmr3RsxSoSMhGbQcF03PCD4kWyNxj/w6JnfpQ83p7DkT3zs7J6v
         OOrB9Ko8YCOKypd6vEqv1GgrilMC6YaLyDj0ylGDZFpfmystH69A7aTJXLRRoM7OHDs1
         YfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Rf7A1N3M8eXRQTfFVYNwPPvk6e2z76n204IQCLMe0go=;
        b=u6KI+cVMdm0OuuOpv2+5U7PwUkNxcVj+O3sbG4/YbXG0Bq/b25oXsejab/e2t7GllP
         BrR74XesNUssJZxtg5mco+G0D86J62eyramcjiP829Gg+h6CFY3xWwANZg3Kkl8AWwWL
         ZfCVnLPBhRGZJx7G72NbGk6+Iu8CNOY/vxqfTypqi/yJU+bF6cKRGjC+WAWxvMayuInP
         sgVK1gsmWZpz5m0L1v4taiHJGfVKVUPGdBblrBkAtMnNfNMk7ZFX8Jx9Snj9jRoTkT9q
         l//uP2Kct6+IAFS7fozuLVSuaq8LIE/he/eo4H1k0D3xgIY0pVjmqf0E9NCaGGCIExRa
         wy2g==
X-Gm-Message-State: ACgBeo0+bqSVagv2WAXVMZcE/ItqzoGMnWl+MGFccAQTDvOj3OIR/Y+Y
        a8BJNYzRKA3FJmN8ui9oKzhLNQJYirg+Lh+cby0=
X-Google-Smtp-Source: AA6agR64o0dGJm1wGkJEebsAJmMWu3uZGUy52q4NvZOd0SKpY+lDQOoltvzUhV0MyBid91Sn6q6/kAyE5Ti5DNyI1UY=
X-Received: by 2002:a05:6402:328c:b0:446:bcc8:bf49 with SMTP id
 f12-20020a056402328c00b00446bcc8bf49mr1633351eda.309.1661401155587; Wed, 24
 Aug 2022 21:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220824044013.29354-1-qkrwngud825@gmail.com> <CAJZ5v0jmDeGn-L6U-=JOxOHVy3CRS8T5Y_06F50cL9bjUhgbPQ@mail.gmail.com>
 <CAD14+f1YEoqdnM8eTd2hUHSy+M4+AKQp6_FjV03TK=TSDxPfYw@mail.gmail.com> <CAJZ5v0hXAgA2xfYfvXk1GZgu6h+ZVOv_XwgzVS5cpmkiChm7gw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hXAgA2xfYfvXk1GZgu6h+ZVOv_XwgzVS5cpmkiChm7gw@mail.gmail.com>
From:   Juhyung Park <qkrwngud825@gmail.com>
Date:   Thu, 25 Aug 2022 13:19:03 +0900
Message-ID: <CAD14+f0D4j_76vuPTpGZ+aYKKD3W3NC+reW8vMh=hDHP=wp-SA@mail.gmail.com>
Subject: Re: [PATCH] PM: suspend: select SUSPEND_SKIP_SYNC too if
 PM_USERSPACE_AUTOSLEEP is selected
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        chrome-platform@lists.linux.dev, Len Brown <len.brown@intel.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:01 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 24, 2022 at 3:36 PM Juhyung Park <qkrwngud825@gmail.com> wrote:
> >
> > Hi Rafael,
> >
> > On Wed, Aug 24, 2022 at 10:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Wed, Aug 24, 2022 at 6:41 AM Juhyung Park <qkrwngud825@gmail.com> wrote:
> > > >
> > > > Commit 2fd77fff4b44 ("PM / suspend: make sync() on suspend-to-RAM build-time
> > > > optional") added an option to skip sync() on suspend entry to avoid heavy
> > > > overhead on platforms with frequent suspends.
> > > >
> > > > Years later, commit 261e224d6a5c ("pm/sleep: Add PM_USERSPACE_AUTOSLEEP
> > > > Kconfig") added a dedicated config for indicating that the kernel is subject to
> > > > frequent suspends.
> > > >
> > > > While SUSPEND_SKIP_SYNC is also available as a knob that the userspace can
> > > > configure, it makes sense to enable this by default if PM_USERSPACE_AUTOSLEEP
> > > > is selected already.
> > > >
> > > > Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
> > > > ---
> > > >  kernel/power/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > > > index 60a1d3051cc7..5725df6c573b 100644
> > > > --- a/kernel/power/Kconfig
> > > > +++ b/kernel/power/Kconfig
> > > > @@ -23,6 +23,7 @@ config SUSPEND_SKIP_SYNC
> > > >         bool "Skip kernel's sys_sync() on suspend to RAM/standby"
> > > >         depends on SUSPEND
> > > >         depends on EXPERT
> > > > +       default PM_USERSPACE_AUTOSLEEP
> > >
> > > Why is this better than selecting SUSPEND_SKIP_SYNC from PM_USERSPACE_AUTOSLEEP?
> >
> > That won't allow developers to opt-out from SUSPEND_SKIP_SYNC when
> > they still want PM_USERSPACE_AUTOSLEEP.
>
> I see.
>
> It is not particularly clear, so at least please mention it in the changelog.

Will do.

>
>
> > (Can't think of a valid reason
> > for this though, as PM_USERSPACE_AUTOSLEEP is only used by Android and
> > probably Chromium, afaik.)
> >
> > I don't think SUSPEND_SKIP_SYNC is critical enough to enforce when
> > PM_USERSPACE_AUTOSLEEP is enabled, but I don't have a strong opinion
> > on this either.
> > (We could do `imply SUSPEND_SKIP_SYNC` from PM_USERSPACE_AUTOSLEEP,
> > but that doesn't look good semantically imho.)
> >
> > If you want, I can send a v2 with 'PM_USERSPACE_AUTOSLEEP select
> > SUSPEND_SKIP_SYNC'.
>
> Personally, I would use "select" and I would amend the
> PM_USERSPACE_AUTOSLEEP help text to say that it will disable sync on
> suspend by default explicitly.
>
> IMV otherwise it is more confusing than it needs to be.

Agreed.

>
> I'm also wondering about a particular use case addressed by this
> change.  Is there any?

I've personally manually enabled SUSPEND_SKIP_SYNC for all my Android
kernels for the past 7-8 years (even before SUSPEND_SKIP_SYNC was
implemented upstream) as it was quite apparent that the sync() path
during suspend was quite expensive, more so when the phone was under a
"suspend storm" which tries to enter suspend dozens of times per
second but was aborted/awakened due to devices with spurious
interrupts or suspend code path failures.

Do note that I do not represent any vendor at this moment.

Also, I think I'll have to mention that Google's Android kernel
(GKI/ACK) currently does not enable SUSPEND_SKIP_SYNC by default while
some OEMs do (can't think of which ones to be specific). So this
changes the default Android behavior, which is why I cc'ed Kalesh and
f2fs folks. I do not know if SUSPEND_SKIP_SYNC on Android was simply
overlooked or was consciously disabled. Android userspace also doesn't
change this via sysfs knob.

I still think this patch makes enough sense, but I'd love to hear
others' thoughts.

Thanks.
