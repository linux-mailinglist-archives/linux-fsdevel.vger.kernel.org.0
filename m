Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA74334BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 23:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhCJWmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 17:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhCJWlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:41:35 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F36C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 14:41:12 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u18so27784203ljd.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 14:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2aOtT0quJ6cX5cHdDYWURmJdnr1SZyARqHb+TRhWKsc=;
        b=Admg/aj1vlbLYpEOJCM2lhdq/aDSricEuYzBabbhb1it9hfceFpiAV/QPXNtTppyq5
         qJnLuVOPgsMjRRJvrtooBcJa1ICxA404GQRiGdmTC7VtvIiEEAQ5u2o3Qo3h/bPs5C33
         Jr8NW/brQ2b0x6WvgUWz+29Ef6F7s6V+G2Vxul/WxSiuxRMM+wPWYBL1ssttKcscE8sz
         I2vZwaFCpz7zOPimjCwaRNBNkotBUYJy6r/wbWRH1ToEUWcaT64D3LYLEhPJDDLOEbOH
         q6dnYsfovRc1OvqghC5s/bwY/KgotFmCfGCuuvAjMWQdAXYTVauVuUfHRlGBA04pydqy
         MknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2aOtT0quJ6cX5cHdDYWURmJdnr1SZyARqHb+TRhWKsc=;
        b=JZaaQJeZ/G11nmQuQcTFDON24QobnHhsk+x8/EAj848NTAYa/AzqDw/poG/eoaA4aV
         Sdxb3Wb75owj21eIR4a8iy9du0dyCmDbv3ZExOm2n4+NlcDtlHROuNLf9ZLwCQ0PEM0n
         tuYvJe39aSaii0ERfV9rbiEmwkIK2dtk4Gn+Hl9ucJfJn/7EbbjATVLjLX4QRAUX3otk
         I3VsZOOu0xKUU5r6bYJXAbFpshLchOVfxcYpyd6j5Vd4jcIt/Ehk/bF8iGVo15YJG1HL
         Vxa0jvSUy0lsR8apNomhZL/K6DkvM6fnPLofG1arFZ5BJrYq+j90g5/xBQ2z8DU27MHM
         hgPA==
X-Gm-Message-State: AOAM532TEpktA9CflaH7uuIOCY6+ODjea0JmE2bOGL8AFYluyIJeCyYW
        zpsEkijP/35NicEGsjkKSiShNXGBB8qea66iVtBIqQ==
X-Google-Smtp-Source: ABdhPJzO0krkvJnPAScZsauNzEoSnpIAXNs5veHGggmbR9hLkK41l1MbiXUv0Ytk3FD7vCI/xJhtrgANOKssdCikqlY=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr3158803ljc.0.1615416071164;
 Wed, 10 Mar 2021 14:41:11 -0800 (PST)
MIME-Version: 1.0
References: <20210310174603.5093-1-shy828301@gmail.com> <20210310174603.5093-14-shy828301@gmail.com>
 <CALvZod5q5LDEfUMuvO7V2hTf+oCsBGXKZn3tBByOXL952wqbRw@mail.gmail.com>
 <CAHbLzkpX0h2_FpeOWfrK3AO8RY4GE=wDqgSwFt69vn+roo6U3A@mail.gmail.com>
 <CALvZod4hSCBsXPisPT_Tai3kHW1Oo5k8z2ihbSgmLsMTAqWGHg@mail.gmail.com> <CAHbLzkp2pW+nR-7Z0w3mGG4+ZBgRy4X4O+nfn03hLWBfB1HVXw@mail.gmail.com>
In-Reply-To: <CAHbLzkp2pW+nR-7Z0w3mGG4+ZBgRy4X4O+nfn03hLWBfB1HVXw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Mar 2021 14:40:59 -0800
Message-ID: <CALvZod5B+JZT2WK=_fKH7tfpXG=NLhwhN=Y83y4+HmsG8TT2LA@mail.gmail.com>
Subject: Re: [v9 PATCH 13/13] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 1:41 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Mar 10, 2021 at 1:08 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Wed, Mar 10, 2021 at 10:54 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Wed, Mar 10, 2021 at 10:24 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > On Wed, Mar 10, 2021 at 9:46 AM Yang Shi <shy828301@gmail.com> wrote:
> > > > >
> > > > > The number of deferred objects might get windup to an absurd number, and it
> > > > > results in clamp of slab objects.  It is undesirable for sustaining workingset.
> > > > >
> > > > > So shrink deferred objects proportional to priority and cap nr_deferred to twice
> > > > > of cache items.
> > > > >
> > > > > The idea is borrowed from Dave Chinner's patch:
> > > > > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> > > > >
> > > > > Tested with kernel build and vfs metadata heavy workload in our production
> > > > > environment, no regression is spotted so far.
> > > >
> > > > Did you run both of these workloads in the same cgroup or separate cgroups?
> > >
> > > Both are covered.
> > >
> >
> > Have you tried just this patch i.e. without the first 12 patches?
>
> No. It could be applied without the first 12 patches, but I didn't
> test this combination specifically since I don't think it would have
> any difference from with the first 12 patches. I tested running the
> test case under root memcg, it seems equal to w/o the first 12 patches
> and the only difference is where to get nr_deferred.

I am trying to measure the impact of this patch independently. One
point I can think of is the global reclaim. The first 12 patches do
not aim to improve the global reclaim but this patch will. I am just
wondering what would be negative if any of this patch.
