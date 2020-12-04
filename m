Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA91E2CF617
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 22:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgLDVY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 16:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLDVY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 16:24:58 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F6DC061A4F;
        Fri,  4 Dec 2020 13:24:18 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a16so10738439ejj.5;
        Fri, 04 Dec 2020 13:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VRyy2mIR9R2s4KEvZSf0TZQU5cMvBdUTpBXR67Yg4w=;
        b=Fx1W6InFbjgF3uwf+wclPDSG7WaC1oU2BXCYMbgWTdK1MpEIEZ96SJkmawi8lQcZjl
         q5mT+5bHFo8l+SBhqTnZQkaQbCsEKhz0GpkLAHNM+oQLCBEsq9FQmYidX+s4m12EH0Gj
         TytrsOW0Mpy+8xJRgPAxkR/oI/WO6wZipiw9gEIsz//F2yP9i+2LCicC9rdik1XPSx9O
         XB9O/JPvBR3lTd8WyFRxftQt8eCPXG5UUuQXrEP7G7WXlEUUlFBKw+fAIBwbk6gBRGd5
         8FFhbH69cuYHzwfeXVaBGbaGWJGPmGpjuyrBxnEq84ULEFhUSMDP1FkhkWPfI/dygyI6
         yd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VRyy2mIR9R2s4KEvZSf0TZQU5cMvBdUTpBXR67Yg4w=;
        b=qDtLxwXCYjk6kOR4+aw9PdKXyMSj0OeVMvk2Rs19bf+HQXyxtv7LL4ewOF1bbHQLF/
         +IpE7DQHUrNljB14DwNq1P+WH196YX3sC6n4WYNsQDkWsJhaRN5WEglqp0l1ZQ3TC8+I
         O9j1MsIyDn1CvG1tZReX3GdI+OjBhS2ELfbk5263haFZ0w8TgLFYIlNdbsXkfQfW2HJW
         RiHsD9OqP0lbvtihop6ZkTJouZ2W5e16nsfnImeIJE1gkBEu4Hwt5nhbDDRT5Bq+OINn
         SIaX51GYkCtSt9gxhLEIgG6RcYYsiXwYVRi8NE88xhrvzITrZvFCfJNf35HzVcsF51Qj
         j7JA==
X-Gm-Message-State: AOAM531METpst4RGvKmXNq7Z6wgWZAQX+OYNcyuK5A1fmhiO+1xPDqya
        BpggmyY6VyCA9Wv3VPvah3lJ0ftj1CnDoQ2w3fvpw9EAsmc=
X-Google-Smtp-Source: ABdhPJzN4H1vvxoGFeAqYPIaab7Y4YUufn38fkMPI2rl416ynOt7h2dtXuEw0sO6Fsi3+bPnLORwXE8914qRWzD2xGI=
X-Received: by 2002:a17:906:24c3:: with SMTP id f3mr8805401ejb.238.1607117056968;
 Fri, 04 Dec 2020 13:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-5-shy828301@gmail.com>
 <20201203030104.GF1375014@carbon.DHCP.thefacebook.com> <CAHbLzkoUNuKHT_4w8QaWCQA3xs2vTW4Xii26a5vpVqxrDVSX_Q@mail.gmail.com>
 <20201203200820.GC1571588@carbon.DHCP.thefacebook.com> <CAHbLzkrbd+gBUngiRa3OJhO3q_Z7x3w6+jkX2CkXG0Zm=jufQA@mail.gmail.com>
 <20201204185247.GA182921@cmpxchg.org>
In-Reply-To: <20201204185247.GA182921@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Dec 2020 13:24:04 -0800
Message-ID: <CAHbLzkqf5=C6dMJjHzqNMZUSdO_eONd9ciOsUE-CdHGqkvBTJQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] mm: vmscan: use a new flag to indicate shrinker is registered
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 4, 2020 at 10:54 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Dec 03, 2020 at 02:25:20PM -0800, Yang Shi wrote:
> > On Thu, Dec 3, 2020 at 12:09 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Dec 02, 2020 at 08:59:40PM -0800, Yang Shi wrote:
> > > > On Wed, Dec 2, 2020 at 7:01 PM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Wed, Dec 02, 2020 at 10:27:20AM -0800, Yang Shi wrote:
> > > > > > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > > > > > This approach is fine with nr_deferred atthe shrinker level, but the following
> > > > > > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > > > > > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > > > > > from unregistering correctly.
> > > > > >
> > > > > > Introduce a new "state" field to indicate if shrinker is registered or not.
> > > > > > We could use the highest bit of flags, but it may be a little bit complicated to
> > > > > > extract that bit and the flags is accessed frequently by vmscan (every time shrinker
> > > > > > is called).  So add a new field in "struct shrinker", we may waster a little bit
> > > > > > memory, but it should be very few since there should be not too many registered
> > > > > > shrinkers on a normal system.
> > > > > >
> > > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > > ---
> > > > > >  include/linux/shrinker.h |  4 ++++
> > > > > >  mm/vmscan.c              | 13 +++++++++----
> > > > > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > > > > > index 0f80123650e2..0bb5be88e41d 100644
> > > > > > --- a/include/linux/shrinker.h
> > > > > > +++ b/include/linux/shrinker.h
> > > > > > @@ -35,6 +35,9 @@ struct shrink_control {
> > > > > >
> > > > > >  #define SHRINK_STOP (~0UL)
> > > > > >  #define SHRINK_EMPTY (~0UL - 1)
> > > > > > +
> > > > > > +#define SHRINKER_REGISTERED  0x1
> > > > > > +
> > > > > >  /*
> > > > > >   * A callback you can register to apply pressure to ageable caches.
> > > > > >   *
> > > > > > @@ -66,6 +69,7 @@ struct shrinker {
> > > > > >       long batch;     /* reclaim batch size, 0 = default */
> > > > > >       int seeks;      /* seeks to recreate an obj */
> > > > > >       unsigned flags;
> > > > > > +     unsigned state;
> > > > >
> > > > > Hm, can't it be another flag? It seems like we have a plenty of free bits.
> > > >
> > > > I thought about this too. But I was not convinced by myself that
> > > > messing flags with state is a good practice. We may add more flags in
> > > > the future, so we may end up having something like:
> > > >
> > > > flag
> > > > flag
> > > > flag
> > > > state
> > > > flag
> > > > flag
> > > > ...
> > > >
> > > > Maybe we could use the highest bit for state?
> > >
> > > Or just
> > > state
> > > flag
> > > flag
> > > flag
> > > flag
> > > flag
> > > ...
> > >
> > > ?
> >
> > It is fine too. We should not add more states in foreseeable future.
>
> It's always possible to shuffle things around for cleanup later on,
> too. We don't have to provide binary compatibility for existing flags,
> and changing a couple of adjacent bits isn't a big deal to keep things
> neat. Or am I missing something?

No. It is definitely not a big deal.
