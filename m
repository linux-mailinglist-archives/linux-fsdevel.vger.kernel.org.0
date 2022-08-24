Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B359FDB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiHXPBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 11:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiHXPBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:01:03 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24772275D1;
        Wed, 24 Aug 2022 08:01:02 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-33dac4c9cbcso18565787b3.12;
        Wed, 24 Aug 2022 08:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=w/neHTaTWq1ptoHqjo7z/PdpJgw6jeoMDrumR+964UM=;
        b=wCMFsd5lcjrJIMZLuL7T2u2RYP4DMljk/WS35U1k9/Kx5apmh+CvMBgKjpG/U1xy0a
         pFshGd/BueXIxi1AMny+xScLaRaDCP7livOl6WxyGlFbMQ95nA2KJDoi3y7vw4BQk9PC
         FmDFlC4BJgsqW/1qhjmLoEud97i06OCg9PvsGdiAIOBvMbB27DeBPnn3+yQNcz+Fb+VU
         zS+rGfZ+DgSLwoUxz0MwB6j6e0N0XsXa2Tmst0NeNKK8b7RIpVNLv6amNQj/rLHc4Oq9
         fnt2voWGgG8WEA7jM73Pmdmx2YSPlR3e9/RMCkNP1U682z3iwSCA6IgDk/u5y81C4cDq
         zWGw==
X-Gm-Message-State: ACgBeo00zUnjcaNQlq0N3c6xs3nB2ToqLq8kpHgLt5+bSWeukGHkU299
        TIZpbSeG7vMSucIDvmmr2tbeLGzHpRVv0UeJk6U=
X-Google-Smtp-Source: AA6agR6/lAmWch493Semg1Kd4FFp/bUFNZNfcthgZaX2pgKcypwxarkt1Qr548YVHjI6HNTUbTAocunJffuYpdMzP2I=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr29627443ybm.137.1661353261244; Wed, 24
 Aug 2022 08:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220824044013.29354-1-qkrwngud825@gmail.com> <CAJZ5v0jmDeGn-L6U-=JOxOHVy3CRS8T5Y_06F50cL9bjUhgbPQ@mail.gmail.com>
 <CAD14+f1YEoqdnM8eTd2hUHSy+M4+AKQp6_FjV03TK=TSDxPfYw@mail.gmail.com>
In-Reply-To: <CAD14+f1YEoqdnM8eTd2hUHSy+M4+AKQp6_FjV03TK=TSDxPfYw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Aug 2022 17:00:49 +0200
Message-ID: <CAJZ5v0hXAgA2xfYfvXk1GZgu6h+ZVOv_XwgzVS5cpmkiChm7gw@mail.gmail.com>
Subject: Re: [PATCH] PM: suspend: select SUSPEND_SKIP_SYNC too if
 PM_USERSPACE_AUTOSLEEP is selected
To:     Juhyung Park <qkrwngud825@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        chrome-platform@lists.linux.dev, Len Brown <len.brown@intel.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 3:36 PM Juhyung Park <qkrwngud825@gmail.com> wrote:
>
> Hi Rafael,
>
> On Wed, Aug 24, 2022 at 10:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Aug 24, 2022 at 6:41 AM Juhyung Park <qkrwngud825@gmail.com> wrote:
> > >
> > > Commit 2fd77fff4b44 ("PM / suspend: make sync() on suspend-to-RAM build-time
> > > optional") added an option to skip sync() on suspend entry to avoid heavy
> > > overhead on platforms with frequent suspends.
> > >
> > > Years later, commit 261e224d6a5c ("pm/sleep: Add PM_USERSPACE_AUTOSLEEP
> > > Kconfig") added a dedicated config for indicating that the kernel is subject to
> > > frequent suspends.
> > >
> > > While SUSPEND_SKIP_SYNC is also available as a knob that the userspace can
> > > configure, it makes sense to enable this by default if PM_USERSPACE_AUTOSLEEP
> > > is selected already.
> > >
> > > Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
> > > ---
> > >  kernel/power/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > > index 60a1d3051cc7..5725df6c573b 100644
> > > --- a/kernel/power/Kconfig
> > > +++ b/kernel/power/Kconfig
> > > @@ -23,6 +23,7 @@ config SUSPEND_SKIP_SYNC
> > >         bool "Skip kernel's sys_sync() on suspend to RAM/standby"
> > >         depends on SUSPEND
> > >         depends on EXPERT
> > > +       default PM_USERSPACE_AUTOSLEEP
> >
> > Why is this better than selecting SUSPEND_SKIP_SYNC from PM_USERSPACE_AUTOSLEEP?
>
> That won't allow developers to opt-out from SUSPEND_SKIP_SYNC when
> they still want PM_USERSPACE_AUTOSLEEP.

I see.

It is not particularly clear, so at least please mention it in the changelog.


> (Can't think of a valid reason
> for this though, as PM_USERSPACE_AUTOSLEEP is only used by Android and
> probably Chromium, afaik.)
>
> I don't think SUSPEND_SKIP_SYNC is critical enough to enforce when
> PM_USERSPACE_AUTOSLEEP is enabled, but I don't have a strong opinion
> on this either.
> (We could do `imply SUSPEND_SKIP_SYNC` from PM_USERSPACE_AUTOSLEEP,
> but that doesn't look good semantically imho.)
>
> If you want, I can send a v2 with 'PM_USERSPACE_AUTOSLEEP select
> SUSPEND_SKIP_SYNC'.

Personally, I would use "select" and I would amend the
PM_USERSPACE_AUTOSLEEP help text to say that it will disable sync on
suspend by default explicitly.

IMV otherwise it is more confusing than it needs to be.

I'm also wondering about a particular use case addressed by this
change.  Is there any?
