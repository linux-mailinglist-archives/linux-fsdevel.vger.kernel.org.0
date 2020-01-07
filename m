Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B812413277E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgAGNWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 08:22:46 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34531 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgAGNWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:22:46 -0500
Received: by mail-il1-f196.google.com with SMTP id s15so45728539iln.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 05:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NI5D+6HBv2vXGauCHFmQ6Ym7RwGjVACGaqPZU9aEMx0=;
        b=qeiyQMTzMXoDkoGYEawF+3LImgcij7GlOX5efVHQjiMXbruhAMpfV62yLGGhIvhu9L
         p3v8PXxGq6yl5n1bDZHzgQlVA5l7vyuu2LMsm2BxckmywPuJ0TX4Jmsshfy2QOkIPC4Z
         8wK7KoVQzm4HftyPqjlZhUuaNNE5JZUedNXnaSA7l7siiRrcPU4ZmvPCMsIJUY3kOwGK
         BMZnV5rASdD8Ba9FmzqGfzPTZke0FvxscwbHR5Zn9LiEBt0gALT+SMdDl51X1JXp2Vry
         FzkPXdzVsjFu9V0q16dmbtoLlXoSxUH0RcROi9VhNo4FRBd1Tpik5oJ16iYk4E4ST0wT
         mUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NI5D+6HBv2vXGauCHFmQ6Ym7RwGjVACGaqPZU9aEMx0=;
        b=bOOAdLIig16qdWAh+gZhBIWFfp4BB0GO16KxHxH8QV/JqHtJ4GMQ2Tor0br9WtaUHe
         AWT3a6yOn9Ono9+v9COkLSNXDxPQM3cyr3bo3nQrrNk+YCj+BYl01Lk2meAGRX1pVqhY
         de9+iFv5uOaxEGyciQ9TbB+6Wp3k7Bno/B6yDbUR5JSHu9F/FsPyfv3win5CmU3yqHyS
         mr53j993ZMJsPiGfu1ZY6AP4NRpYFavEjqN6LcwnRAxu0k1vLlLPLLa9R/FUPTFlW8dp
         6P8C3isqNO+I1EtDoxYYFTweSmRDSzBuzi7HYuo/q2G4OrJWL/iZPb3HOztBZojfzeFE
         26Og==
X-Gm-Message-State: APjAAAUVHpo6F7I9xNJI6I0ACQLMuVHbj4uJE7j1bTaIVVHlIvSluHFJ
        TPrRaTJ2T0q9jOvvmH1Pag0QI6cIh9AGEoKq3f/gmg==
X-Google-Smtp-Source: APXvYqwO6B1feqA4p0tYLeeJMe9D20vrmn8I3hI5FWL/fpSImc5ZhCnZUUjCXRQ4iU2tdMOYizyUAgsp9YEgcwvX+Gc=
X-Received: by 2002:a92:911b:: with SMTP id t27mr89595979ild.142.1578403365699;
 Tue, 07 Jan 2020 05:22:45 -0800 (PST)
MIME-Version: 1.0
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-5-git-send-email-laoar.shao@gmail.com> <20200104033558.GD23195@dread.disaster.area>
 <CALOAHbAzDth8g8+Z5hH9QnOp02UZ5+3eQf9wAQyJM-LAhmaL9A@mail.gmail.com>
 <20200104212331.GG23195@dread.disaster.area> <CALOAHbBGRSfRTH7RYXfgAqtixuYvu=tRrr7zQyAvofrzktW=vA@mail.gmail.com>
 <20200106001713.GH23195@dread.disaster.area> <CALOAHbD31GmGz17kNCOvw2kDvZE43=eAVT=1ww_+AF2T-R6A2w@mail.gmail.com>
 <20200106213103.GJ23195@dread.disaster.area>
In-Reply-To: <20200106213103.GJ23195@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 7 Jan 2020 21:22:09 +0800
Message-ID: <CALOAHbBCCgWT-hku-nFXHOgQ47E_tY2tnwAMjPuePihX4b-rZw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make memcg visible to lru walker isolation function
To:     Dave Chinner <david@fromorbit.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 5:31 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jan 06, 2020 at 10:41:22PM +0800, Yafang Shao wrote:
> > On Mon, Jan 6, 2020 at 8:17 AM Dave Chinner <david@fromorbit.com> wrote:
> > > We can clean up the code a lot by getting rid of the unnecessary
> > > indenting by doing this:
> > >
> > >         /* iterate the global lru first */
> > >         isolated = list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
> > >                                         nr_to_walk);
> > >         if (!list_lru_memcg_aware(lru))
> > >                 return isolated;
> > >
> > >         nlru = &lru->node[nid];
> > >         for_each_mem_cgroup(memcg) {
> > >                 /* already scanned the root memcg above */
> > >                 if (is_root_memcg(memcg))
> > >                         continue;
> > >                 if (*nr_to_walk <= 0)
> > >                         break;
> > >                 spin_lock(&nlru->lock);
> > >                 isolated += __list_lru_walk_one(nlru, memcg,
> > >                                                 isolate, cb_arg,
> > >                                                 nr_to_walk);
> > >                 spin_unlock(&nlru->lock);
> > >         }
> > >         return isolated;
> > >
> >
> > That's eaiser to understand.
> > I wil change it like this in next version.
>
> Thanks!
>
> > >
> > > And so to architecture... This all makes me wonder why we still
> > > special case the memcg LRU lists here.
> >
> > Can't agree more.
> > The first time I read this code, I wondered why not assign an
> > non-negtive number to kmemcg_id of the root_mem_cgroup and then use
> > memcg_lrus as well.
>
> Yeah, I've been wondering why the ID is -1 instead of 0 when we
> have a global variable that stores the root memcg that we can
> compare pointers directly against via is_root_memcg(). all it seems
> to do is make things more complex by having to special case the root
> memcg....
>
> From that perspective, I do like your change to use the memcg
> iterator functions rather than a for loop over the range of indexes,
> but I'd much prefer to see this method used consistently everywhere
> rather than the way we've duplicated lots of code by tacking memcgs
> onto the side of the non-memcg code paths.
>

Agreed, that would be better.
I will think about it.

> > > Ever since we went to
> > > per-node memcg lru lists (~2015, iirc), there's been this special
> > > hidden hack for the root memcg to use the global list. and one that
> > > I have to read lots of code to remind myself it exists every time I
> > > have to did into this code again.
> > >
> > > I mean, if the list is not memcg aware, then it only needs a single
> > > list per node - the root memcg list. That could be easily stored in
> > > the memcg_lrus array for the node rather than a separate global
> > > list, and then the node iteration code all starts to look like this:
> > >
> > >         nlru = &lru->node[nid];
> > >         for_each_mem_cgroup(memcg) {
> > >                 spin_lock(&nlru->lock);
> > >                 isolated += __list_lru_walk_one(nlru, memcg,
> > >                                                 isolate, cb_arg,
> > >                                                 nr_to_walk);
> > >                 spin_unlock(&nlru->lock);
> > >                 if (*nr_to_walk <= 0)
> > >                         break;
> > >
> > >                 /* non-memcg aware lists only have a root memcg list */
> > >                 if (!list_lru_memcg_aware(lru))
> > >                         break;
> > >         }
> > >
> > > Hence for the walks in the !list_lru_memcg_aware(lru) case, the
> > > list_lru_from_memcg() call in __list_lru_walk_one() always returns
> > > just the root list. This makes everything use the same iteration
> > > interface, and when you configure out memcg then we simply code the
> > > the iterator to run once and list_lru_from_memcg() always returns
> > > the one list...
> > >
> >
> > Agree with you that it is a better architecture, and I also want to
> > change it like this.
> > That would be more clear and easier for maintiance.
> > But it requires lots of code changes, should we address it in another
> > separate patchset ?
>
> Yes. I think this is a separate piece of work as it spans much more
> than just the list-lru infrastructure.
>

Got it.

> > > And, FWIW, I noticed that the list_lru memcg code assumes we only
> > > ever put objects from memcg associated slab pages in the list_lru.
> > > It calls memcg_from_slab_page() which makes no attempt to verify the
> > > page is actually a slab page. That's a landmine just waiting to get
> > > boom - list-lru can store any type of object the user wants, not
> > > just slab pages. e.g. the binder code stores pages in the list-lru,
> > > not slab objects, and so the only reason it doesn't go boom is that
> > > the lru-list is not configured to be memcg aware....
> > >
> >
> > Another new issue.
> > I will try to dignose what hiddened in this landmine is, and after I
> > understand it clearly I will submit a new patchset.
>
> The problem is memcg_from_slab_page() uses page->slab_cache directly
> to retreive the owner memcg without first checking the
> PageSlab(page) flag. If it's not a slab page, we need to get the
> memcg from page->memcg, not page->slab_cache->memcg_params.memcg.
>
> see page_cgroup_ino() for how to safely get the owner memcg from a
> random page of unknown type...
>

Understood, many thanks for your explanation.


Thanks
Yafang
