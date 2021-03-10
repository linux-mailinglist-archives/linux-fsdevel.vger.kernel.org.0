Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B783349F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 22:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhCJVmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 16:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhCJVlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:41:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613BEC061574;
        Wed, 10 Mar 2021 13:41:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bd6so30314604edb.10;
        Wed, 10 Mar 2021 13:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/qwFAyd2t4eeQ5y/zr+yw6AQn6TtGLfgsf4qZGMOj0=;
        b=IuZNGPtOkpq7xi8mg/JCqVEioZf5VKLjRUeEhu6DPobVhI9+q7izx2xlVN0mQCzaL8
         HQMk2lWBA/qp+IBC9BQV3Nzc/VH4aRN09q834QPs1M5nhmy6fViT35JVuBYlXot5I5b7
         YcwNUonY3kXQfEytf/YWjq0d+Zi3bNMUJ5+6I2HdGfT4sJxdDqL8UzhYJyAAvAcEk0aD
         rq7ARSvWXJ/2EgAja08AVrkvvdAlik6f4IeHG7WW8aKALJ/9wUZGfyD3x4MGLNjEk3dm
         abY4MdlSFEZLPt8XSUGrFAk5uOvlHsT5rp0Q2drj+3u+ewgeCkbiciBvAoOzl3K+xACW
         wS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/qwFAyd2t4eeQ5y/zr+yw6AQn6TtGLfgsf4qZGMOj0=;
        b=GUTNBQdVKC0h0ZNCYD6S5w2Ob/KoFlWWL695cWuu7YDAen2bQaT5yUx1uGlAzu/kzE
         zZntzQOQzspCbX2Rw5qQlMAffp2NEfRy3ArEhrh9bmgUn4rvw9O3jlYcqKLGBd4ciL8H
         wJbU01W6m3sW57xIgSCFl/SH9TB52BWm7N0vPL12ijd5t6MKzctDmChg4y1BNV8qoIeV
         e+cjbZRbNVDhAftYjAC6olAof0nC75m7QvUPIRPMCx4FBYSNqO9RUWu7qvUA3Njo//nv
         xjfpZhlCaoX1tH3pF6dStLy8HIgVB0JyJEQmpWTyI5Uc3dl51UzHGh8ktbWY8mu8NjYb
         RwFA==
X-Gm-Message-State: AOAM532ccPefVcX1Y0UyxzaVfgPi69AoGPhwqKDS4ois8wy5agkybjCa
        03LmRPEZ+JJqg/FIJyd1FPVEjczh7vP/qym6X54=
X-Google-Smtp-Source: ABdhPJywjTf6nT0poSBOpWK3Efk08tHVcrEHEq/GIItbAKb6sm9RkAFzPMqFnGoKno2pW+PgllbEO8q516idS5NzHK0=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr5428269eds.151.1615412509105;
 Wed, 10 Mar 2021 13:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20210310174603.5093-1-shy828301@gmail.com> <20210310174603.5093-14-shy828301@gmail.com>
 <CALvZod5q5LDEfUMuvO7V2hTf+oCsBGXKZn3tBByOXL952wqbRw@mail.gmail.com>
 <CAHbLzkpX0h2_FpeOWfrK3AO8RY4GE=wDqgSwFt69vn+roo6U3A@mail.gmail.com> <CALvZod4hSCBsXPisPT_Tai3kHW1Oo5k8z2ihbSgmLsMTAqWGHg@mail.gmail.com>
In-Reply-To: <CALvZod4hSCBsXPisPT_Tai3kHW1Oo5k8z2ihbSgmLsMTAqWGHg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 10 Mar 2021 13:41:37 -0800
Message-ID: <CAHbLzkp2pW+nR-7Z0w3mGG4+ZBgRy4X4O+nfn03hLWBfB1HVXw@mail.gmail.com>
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

On Wed, Mar 10, 2021 at 1:08 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Mar 10, 2021 at 10:54 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, Mar 10, 2021 at 10:24 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Wed, Mar 10, 2021 at 9:46 AM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > The number of deferred objects might get windup to an absurd number, and it
> > > > results in clamp of slab objects.  It is undesirable for sustaining workingset.
> > > >
> > > > So shrink deferred objects proportional to priority and cap nr_deferred to twice
> > > > of cache items.
> > > >
> > > > The idea is borrowed from Dave Chinner's patch:
> > > > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> > > >
> > > > Tested with kernel build and vfs metadata heavy workload in our production
> > > > environment, no regression is spotted so far.
> > >
> > > Did you run both of these workloads in the same cgroup or separate cgroups?
> >
> > Both are covered.
> >
>
> Have you tried just this patch i.e. without the first 12 patches?

No. It could be applied without the first 12 patches, but I didn't
test this combination specifically since I don't think it would have
any difference from with the first 12 patches. I tested running the
test case under root memcg, it seems equal to w/o the first 12 patches
and the only difference is where to get nr_deferred.
