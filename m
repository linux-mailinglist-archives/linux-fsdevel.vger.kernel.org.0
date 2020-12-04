Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82262CE46D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 01:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgLDAXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 19:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLDAXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:23:46 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047DDC061A4F;
        Thu,  3 Dec 2020 16:23:06 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cm17so4076908edb.4;
        Thu, 03 Dec 2020 16:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BQ4XmRXJ5tJU8cInjEvRj0foj83VwXtchWn6lsH22k=;
        b=rjY13WWf2DfIGGqwhIce1xx6USao8fCscXZaRajag8S8qcaqLmaiaegoeQucW4nbwW
         DAn4DDQXDDe5oYRbLmPMNOlX3aS12EffgCOJZEFdUYTnr2WE4Nltn3N23wxtu2irC/EN
         8PKiCgEgtmp+Y8YGaY30UBbk7sCDYt01zeiRQlWlMklPdeeVNOqoI2Jnkx5f2Uo4448S
         HFIbMpTld7jT1quZDidaRMfA5AIHe4N6FbFAyqziJcWJIkM4Ku6XNGNXPUU9Ak9d1ekS
         RL2F+26H5kjnudBCEBFBb3JR/oy9oDzxXGQKLPzhgF7JOWPiqbZ42OtBqOL0KQuqtey8
         VH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BQ4XmRXJ5tJU8cInjEvRj0foj83VwXtchWn6lsH22k=;
        b=MSP11ZRD0M+pMd0WPmw9FPNWdjYS2TtZ8SjedO33ipOCAYC6NM7bHMzKMsVSBaVHWV
         AIR+mG6KAGgypB2tP5agPok35LwVeELjVhZKXpEutkmLiFdO2LHzTUnDYlz/sIQgmmq+
         v40sCoN1xHR4Ncc7yn/hFQtNlWKZPLUnwYFvtKiwPuKiHd3WZ5vGGY7aiCVpFvT6o1bQ
         UcXOY8DSb46v2ISg01U+rlOM5oFkayZDNjpHhPkUGPWnQtIVkzlFlfxJ9sA3ZFv/c46R
         7HzhHkW9vzE48wQI69Q7xfX1lQr5JW92bk2alN9Omv4tHIzj3Dw4THqOgW/g7YHQ2Tbm
         a7qA==
X-Gm-Message-State: AOAM531mtdBdfb2ge8sjMyyfpy7ViH/C6mWTch6riwjELlHqfJmTXX0Z
        yy3tnbELuanZCnYpyOQa15DDIJtKpqZ4LTYhwg4=
X-Google-Smtp-Source: ABdhPJzCo4SHEUWMcFzF1/m19jYL7aZWsHDZNE0y3CX9ULPe5r9BI1aIBCScbllQJa2E6Yq6ZptvDLN/PTHVT7Cl/20=
X-Received: by 2002:aa7:d54a:: with SMTP id u10mr5220398edr.168.1607041384684;
 Thu, 03 Dec 2020 16:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-6-shy828301@gmail.com>
 <20201203030632.GG1375014@carbon.DHCP.thefacebook.com> <CAHbLzkrU0X2LRRiG_rXdOf8tP7BR=46ccJR=3AM6CkWbscBWRw@mail.gmail.com>
 <CAHbLzkpAsoOWeRuFeTM2+YbjfqxY2U3vK7EYX2Nui=YVOBXFpw@mail.gmail.com>
 <20201203200715.GB1571588@carbon.DHCP.thefacebook.com> <CAHbLzkoUaLehmngW7geCDj+Fzd5+tkk3tBsbcdHuSXUXKLBuyw@mail.gmail.com>
 <20201203233055.GA1669930@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201203233055.GA1669930@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Dec 2020 16:22:52 -0800
Message-ID: <CAHbLzkowkLEfBp=dXcnX9_w87E5ZifRW9af+s8DGaXDkM8__PQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] mm: memcontrol: add per memcg shrinker nr_deferred
To:     Roman Gushchin <guro@fb.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 3, 2020 at 3:31 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Dec 03, 2020 at 02:49:00PM -0800, Yang Shi wrote:
> > On Thu, Dec 3, 2020 at 12:07 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Thu, Dec 03, 2020 at 10:03:44AM -0800, Yang Shi wrote:
> > > > On Wed, Dec 2, 2020 at 8:54 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > >
> > > > > On Wed, Dec 2, 2020 at 7:06 PM Roman Gushchin <guro@fb.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 02, 2020 at 10:27:21AM -0800, Yang Shi wrote:
> > > > > > > Currently the number of deferred objects are per shrinker, but some slabs, for example,
> > > > > > > vfs inode/dentry cache are per memcg, this would result in poor isolation among memcgs.
> > > > > > >
> > > > > > > The deferred objects typically are generated by __GFP_NOFS allocations, one memcg with
> > > > > > > excessive __GFP_NOFS allocations may blow up deferred objects, then other innocent memcgs
> > > > > > > may suffer from over shrink, excessive reclaim latency, etc.
> > > > > > >
> > > > > > > For example, two workloads run in memcgA and memcgB respectively, workload in B is vfs
> > > > > > > heavy workload.  Workload in A generates excessive deferred objects, then B's vfs cache
> > > > > > > might be hit heavily (drop half of caches) by B's limit reclaim or global reclaim.
> > > > > > >
> > > > > > > We observed this hit in our production environment which was running vfs heavy workload
> > > > > > > shown as the below tracing log:
> > > > > > >
> > > > > > > <...>-409454 [016] .... 28286961.747146: mm_shrink_slab_start: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > > > > > > nid: 1 objects to shrink 3641681686040 gfp_flags GFP_HIGHUSER_MOVABLE|__GFP_ZERO pgs_scanned 1 lru_pgs 15721
> > > > > > > cache items 246404277 delta 31345 total_scan 123202138
> > > > > > > <...>-409454 [022] .... 28287105.928018: mm_shrink_slab_end: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > > > > > > nid: 1 unused scan count 3641681686040 new scan count 3641798379189 total_scan 602
> > > > > > > last shrinker return val 123186855
> > > > > > >
> > > > > > > The vfs cache and page cache ration was 10:1 on this machine, and half of caches were dropped.
> > > > > > > This also resulted in significant amount of page caches were dropped due to inodes eviction.
> > > > > > >
> > > > > > > Make nr_deferred per memcg for memcg aware shrinkers would solve the unfairness and bring
> > > > > > > better isolation.
> > > > > > >
> > > > > > > When memcg is not enabled (!CONFIG_MEMCG or memcg disabled), the shrinker's nr_deferred
> > > > > > > would be used.  And non memcg aware shrinkers use shrinker's nr_deferred all the time.
> > > > > > >
> > > > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > > > ---
> > > > > > >  include/linux/memcontrol.h |   9 +++
> > > > > > >  mm/memcontrol.c            | 112 ++++++++++++++++++++++++++++++++++++-
> > > > > > >  mm/vmscan.c                |   4 ++
> > > > > > >  3 files changed, 123 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > > > > > index 922a7f600465..1b343b268359 100644
> > > > > > > --- a/include/linux/memcontrol.h
> > > > > > > +++ b/include/linux/memcontrol.h
> > > > > > > @@ -92,6 +92,13 @@ struct lruvec_stat {
> > > > > > >       long count[NR_VM_NODE_STAT_ITEMS];
> > > > > > >  };
> > > > > > >
> > > > > > > +
> > > > > > > +/* Shrinker::id indexed nr_deferred of memcg-aware shrinkers. */
> > > > > > > +struct memcg_shrinker_deferred {
> > > > > > > +     struct rcu_head rcu;
> > > > > > > +     atomic_long_t nr_deferred[];
> > > > > > > +};
> > > > > >
> > > > > > The idea makes total sense to me. But I wonder if we can add nr_deferred to
> > > > > > struct list_lru_one, instead of adding another per-memcg per-shrinker entity?
> > > > > > I guess it can simplify the code quite a lot. What do you think?
> > > > >
> > > > > Aha, actually this exactly was what I did at the first place. But Dave
> > > > > NAK'ed this approach. You can find the discussion at:
> > > > > https://lore.kernel.org/linux-mm/20200930073152.GH12096@dread.disaster.area/.
> > >
> > > Yes, this makes sense for me. Thank you for the link!
> > >
> > > >
> > > > I did prototypes for both approaches (move nr_deferred to list_lru or
> > > > to memcg). I preferred the list_lru approach at the first place. But
> > > > Dave's opinion does make perfect sense to me. So I dropped that
> > > > list_lru one. That email elaborated why moving nr_deferred to list_lru
> > > > is not appropriate.
> > >
> > > Hm, shouldn't we move list_lru to memcg then? It's not directly related
> > > to your patchset, but maybe it's something we should consider in the future.
> >
> > I haven't thought about this yet. I agree we could look into it
> > further later on.
> >
> > >
> > > What worries me is that with your patchset we'll have 3 separate
> > > per-memcg (per-node) per-shrinker entity, each with slightly different
> > > approach to allocate/extend/reparent/release. So it begs for some
> > > unification. I don't think it's a showstopper for your work though, it
> > > can be done later.
> >
> > Off the top of my head, we may be able to have shrinker_info struct,
> > it should look like:
> >
> > struct shrinker_info {
> >     atomic_long_t nr_deferred;
> >     /* Just one bit is used now */
> >     u8 map:1;
> > }
> >
> > struct memcg_shrinker_info {
> >     struct rcu_head rcu;
> >     /* Indexed by shrinker ID */
> >     struct shrinker_info info[];
> > }
> >
> > Then in struct mem_cgroup_per_node, we could have:
> >
> > struct mem_cgroup_per_node {
> >     ....
> >     struct memcg_shrinker_info __rcu *shrinker_info;
> >     ....
> > }
> >
> > In this way shrinker_info should be allocated to all memcgs, including
> > root. But shrinker could ignore root's map bit. We may waste a little
> > bit memory, but we get unification.
> >
> > Would that work?
>
> Hm, not exactly, then you'll an ability to iterate with
>         for_each_set_bit(i, map->map, shrinker_nr_max)...

Instead we could just iterate each shrinker_info struct to check if
its map is set.

> But you can probably do something like:
>
> struct shrinker_info {
>    atomic_long_t nr_deferred;
>
>    struct list_lru_one[]; /* optional, depends on the shrinker implementation */
> };
>
> struct memcg_shrinker_info {
>     /* Indexed by shrinker ID */
>     unsigned long *map[];
>     struct shrinker_info *shrinker_info[];

Both map and shrinker_info has to be extendable, so they have to be
struct with rcu_head. So actually it is the same with separate
shrinker_map and shrinker_deferred, but under one struct. Actually I
tried this in my prototype, but I gave up it since it didn't simplify
the code IMHO.

> }
>
> Then you'll be able to allocate individual shrinker_info structures on-demand.
>
> But, please, take this all with a grain of salt, I didn't check if it's all really
> possible or there are some obstacles.

Thanks a lot for all the kind suggestions. I'd agree with you we could
revisit the unification later on. It seems there is not a simple and
straightforward way to unify them at the first glance. There might be
more evils in the detail.

>
> Thanks!
