Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F684334C20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 00:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhCJXBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 18:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhCJXBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:01:33 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C47C061574;
        Wed, 10 Mar 2021 15:01:33 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mm21so42091050ejb.12;
        Wed, 10 Mar 2021 15:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1OhGlJz2j6YTYfzWFHdwbgV7PiLTTKaD5d9gsHnl1E=;
        b=lW9tBi577tyTEpO0bVugV0TKRv6FllVdghAXpihF0GR4vMLzn0uSraikC/rbKnuPYJ
         r5jAHQTZ/EnQknxboJLonWglrqlTh/g3klmXPo/QOGAIz7Y+dk/tISVVbNUAH0KGBpWV
         iMvXTPXW1c5IcYFETm0fA3JpvbH0vxcicS9CSZaB0aJURFnqEiafMc/4UIKR52neb+v1
         jsdVFgZfr8uv99djkzUxiOK5WoctFNNHVaS4Tg8kYlazUr4IiRJIDuZBvlqHaK84Eliy
         55YciVi6/r2iVCksW9DMsaQcCYFxhF5JBgazUoPzAmJmd2Lpp502Qpuzg5pLIwvoSxbh
         FvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1OhGlJz2j6YTYfzWFHdwbgV7PiLTTKaD5d9gsHnl1E=;
        b=d7L+GOqj88uzABAZlwzf5r2JUPT96mcfKMGTRqvY+eytGlegXTxopjASQtQZ/eHWqT
         H21cWcmXiyk1jzw7Mow5cWob6ugfNFLUUT8Cafsk46+HmH1vOndaxgLj6q6Mz290oX2W
         3uzhJ7XeKRxfz8mGezHEFX8WfRCru0xUL1dcikspkAqAnwCperq5vb67keKhQ96DeRqb
         FA0nMBSM36lNA6efGMmrLI5f2vcBiMsV8Q+rU2V7AWzhOIdKix5ZmD+5WGrQyMVPTfqc
         oNRkkaYAsKDCvl53MQmU7upLEpjbmNuEtqx1dokbT5C8XWJL011KZNlhT/7+RoDNi67H
         Cd4A==
X-Gm-Message-State: AOAM531LZ/ro4Pu6ekFUVPgquTaKiPrs5Upz7RFPyzu0SPR2usiHXlsF
        ovVNQUOZvoTaoaXANM3c2pB1ZThWuuDm5s4CAKg=
X-Google-Smtp-Source: ABdhPJyY+VKalzfc/sF2/xknKh2RDncIBUn9TMdHzcFeNKNt27z04V3g7uqrolj9U24rxex3L59xU3HgbnW/g+ZIOnQ=
X-Received: by 2002:a17:906:3088:: with SMTP id 8mr185785ejv.499.1615417292149;
 Wed, 10 Mar 2021 15:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20210310174603.5093-1-shy828301@gmail.com> <20210310174603.5093-14-shy828301@gmail.com>
 <CALvZod5q5LDEfUMuvO7V2hTf+oCsBGXKZn3tBByOXL952wqbRw@mail.gmail.com>
 <CAHbLzkpX0h2_FpeOWfrK3AO8RY4GE=wDqgSwFt69vn+roo6U3A@mail.gmail.com>
 <CALvZod4hSCBsXPisPT_Tai3kHW1Oo5k8z2ihbSgmLsMTAqWGHg@mail.gmail.com>
 <CAHbLzkp2pW+nR-7Z0w3mGG4+ZBgRy4X4O+nfn03hLWBfB1HVXw@mail.gmail.com> <CALvZod5B+JZT2WK=_fKH7tfpXG=NLhwhN=Y83y4+HmsG8TT2LA@mail.gmail.com>
In-Reply-To: <CALvZod5B+JZT2WK=_fKH7tfpXG=NLhwhN=Y83y4+HmsG8TT2LA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 10 Mar 2021 15:01:20 -0800
Message-ID: <CAHbLzkrju=bYk3mrBUxhL8uq9Q=H0Nw4dqD3sDx8G7AJY-n=Wg@mail.gmail.com>
Subject: Re: [v9 PATCH 13/13] mm: vmscan: shrink deferred objects proportional
 to priority
To:     Shakeel Butt <shakeelb@google.com>
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

On Wed, Mar 10, 2021 at 2:41 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Mar 10, 2021 at 1:41 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, Mar 10, 2021 at 1:08 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Wed, Mar 10, 2021 at 10:54 AM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 10, 2021 at 10:24 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > On Wed, Mar 10, 2021 at 9:46 AM Yang Shi <shy828301@gmail.com> wrote:
> > > > > >
> > > > > > The number of deferred objects might get windup to an absurd number, and it
> > > > > > results in clamp of slab objects.  It is undesirable for sustaining workingset.
> > > > > >
> > > > > > So shrink deferred objects proportional to priority and cap nr_deferred to twice
> > > > > > of cache items.
> > > > > >
> > > > > > The idea is borrowed from Dave Chinner's patch:
> > > > > > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> > > > > >
> > > > > > Tested with kernel build and vfs metadata heavy workload in our production
> > > > > > environment, no regression is spotted so far.
> > > > >
> > > > > Did you run both of these workloads in the same cgroup or separate cgroups?
> > > >
> > > > Both are covered.
> > > >
> > >
> > > Have you tried just this patch i.e. without the first 12 patches?
> >
> > No. It could be applied without the first 12 patches, but I didn't
> > test this combination specifically since I don't think it would have
> > any difference from with the first 12 patches. I tested running the
> > test case under root memcg, it seems equal to w/o the first 12 patches
> > and the only difference is where to get nr_deferred.
>
> I am trying to measure the impact of this patch independently. One
> point I can think of is the global reclaim. The first 12 patches do
> not aim to improve the global reclaim but this patch will. I am just
> wondering what would be negative if any of this patch.

Feel free to do so. More tests from more workloads are definitely
appreciated. That could give us more confidence about this patch or
catch regression sooner.
