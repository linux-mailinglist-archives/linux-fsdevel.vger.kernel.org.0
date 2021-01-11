Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE942F1DD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 19:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390017AbhAKSUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 13:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389767AbhAKSUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:20:21 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C07C061786;
        Mon, 11 Jan 2021 10:19:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 6so1004628ejz.5;
        Mon, 11 Jan 2021 10:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TiGfJ4b+uUyCz0bZkTsf3ZnO6K0/f+2uw7mhU/La8k=;
        b=tt4wioaGGBseRvOBgkH77rYiL5O8piO5XeNlA4he/HK/s+yTyasV9J84ycFlIuo6c+
         X5g/1b20cRxoeA3vC2I1hi/fwAPfhsdjLOHuHYIuxN9fY1q4vhdlweEkS6g8R8VyBRHd
         N3k8/8+pWUb/TbssdDWmysaFPRd66WpgHEjXzk5rJ5AfnQOE7AzSw+Tm/HHbwq5WaAiv
         bQ2MQRr5aXxNe2PQWaXpB2Uo5Gu5i4cHbY6kwV/Hhc1HuV/Uz4zsy1OMJEozKU1sW0vi
         fK6sGz8BWo/TeE910w/2q4VclWPrOMuIsXwPWbWkHXCrTbQ33CYzEuVm/TEWFuhZdOKR
         VeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TiGfJ4b+uUyCz0bZkTsf3ZnO6K0/f+2uw7mhU/La8k=;
        b=H+R/G94An1vxdm3v24QlVlRFkJdNO8ZHyF+eFdyFLIKVLoWipQepDAtS4A5CVB83sY
         6AcIWZJE146ezXYb7aQPO5VgQoWFfc5F18JQvGRukrir8dLuGpH1yFcdwiMGERimGOcJ
         89SROndaGo1w3Py3y1zubeUdeJVutZs162guIOpwNNeCTi1H0hi/U+oUQAEyS+E5mFXC
         jRmGfURNImAOiRjTZdalA9kBH4Ny3rNJTC+wqLxR6UKUP9JkvXVak1200ifMZvnjE8uy
         FhA1XQzsbAyeqwETF4PF7/qwWLqQpddWMphnWkQIoQZ/t6tsWlprD70WzrSZJHI/NDNR
         Iwlg==
X-Gm-Message-State: AOAM531HjU5lclFLUsQZgWE8D+lLZesV7GxMJgJYRkrhJ3C9ghE6s4qN
        PCLhythcHevBg7RtJodN1V9yr2VzTItyWu/UBmQ=
X-Google-Smtp-Source: ABdhPJyK6q7foHdbCNzZ7wmzcMRWW6YKl4r7s2yN1CwDdXH7Fy0dBtE4h9xflzepsWYDR/Q+FGklcUk/TpNsKSUjjOo=
X-Received: by 2002:a17:907:20a4:: with SMTP id pw4mr476166ejb.499.1610389179199;
 Mon, 11 Jan 2021 10:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-7-shy828301@gmail.com>
 <ce786c09-64bd-b7fc-4fe8-c4862440c129@virtuozzo.com>
In-Reply-To: <ce786c09-64bd-b7fc-4fe8-c4862440c129@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Jan 2021 10:19:26 -0800
Message-ID: <CAHbLzkrMpPtGgZxv8KRKWOHM09+rFV=wN=i+8xF4r2s0BYQP8g@mail.gmail.com>
Subject: Re: [v3 PATCH 06/11] mm: memcontrol: rename shrinker_map to shrinker_info
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
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

On Wed, Jan 6, 2021 at 3:39 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.01.2021 01:58, Yang Shi wrote:
> > The following patch is going to add nr_deferred into shrinker_map, the change will
> > make shrinker_map not only include map anymore, so rename it to a more general
> > name.  And this should make the patch adding nr_deferred cleaner and readable and make
> > review easier.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/memcontrol.h |  8 ++---
> >  mm/memcontrol.c            |  6 ++--
> >  mm/vmscan.c                | 66 +++++++++++++++++++-------------------
> >  3 files changed, 40 insertions(+), 40 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index d128d2842f22..e05bbe8277cc 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -96,7 +96,7 @@ struct lruvec_stat {
> >   * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
> >   * which have elements charged to this memcg.
> >   */
> > -struct memcg_shrinker_map {
> > +struct memcg_shrinker_info {
>
> Reviewing your next patch actively using new fields in this structure,
> I strongly insist on renaming it in "struct shrinker_info" instead of that.
>
> Otherwise, lines of function declarations become too long.

Yes, agreed. Will incorporate in v4.

>
> >       struct rcu_head rcu;
> >       unsigned long map[];
> >  };
> > @@ -118,7 +118,7 @@ struct mem_cgroup_per_node {
> >
> >       struct mem_cgroup_reclaim_iter  iter;
> >
> > -     struct memcg_shrinker_map __rcu *shrinker_map;
> > +     struct memcg_shrinker_info __rcu        *shrinker_info;
> >
> >       struct rb_node          tree_node;      /* RB tree node */
> >       unsigned long           usage_in_excess;/* Set to the value by which */
> > @@ -1581,8 +1581,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
> >       return false;
> >  }
> >
> > -extern int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg);
> > -extern void memcg_free_shrinker_maps(struct mem_cgroup *memcg);
> > +extern int memcg_alloc_shrinker_info(struct mem_cgroup *memcg);
> > +extern void memcg_free_shrinker_info(struct mem_cgroup *memcg);
> >  extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> >                                  int nid, int shrinker_id);
> >  #else
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 817dde366258..126f1fd550c8 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5248,11 +5248,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
> >       struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> >
> >       /*
> > -      * A memcg must be visible for memcg_expand_shrinker_maps()
> > +      * A memcg must be visible for memcg_expand_shrinker_info()
> >        * by the time the maps are allocated. So, we allocate maps
> >        * here, when for_each_mem_cgroup() can't skip it.
> >        */
> > -     if (memcg_alloc_shrinker_maps(memcg)) {
> > +     if (memcg_alloc_shrinker_info(memcg)) {
> >               mem_cgroup_id_remove(memcg);
> >               return -ENOMEM;
> >       }
> > @@ -5316,7 +5316,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
> >       vmpressure_cleanup(&memcg->vmpressure);
> >       cancel_work_sync(&memcg->high_work);
> >       mem_cgroup_remove_from_trees(memcg);
> > -     memcg_free_shrinker_maps(memcg);
> > +     memcg_free_shrinker_info(memcg);
> >       memcg_free_kmem(memcg);
> >       mem_cgroup_free(memcg);
> >  }
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 9761c7c27412..0033659abf9e 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -187,20 +187,20 @@ static DECLARE_RWSEM(shrinker_rwsem);
> >  #ifdef CONFIG_MEMCG
> >  static int shrinker_nr_max;
> >
> > -static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
> > +static void memcg_free_shrinker_info_rcu(struct rcu_head *head)
> >  {
> > -     kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> > +     kvfree(container_of(head, struct memcg_shrinker_info, rcu));
> >  }
> >
> > -static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
> > -                                      int size, int old_size)
> > +static int memcg_expand_one_shrinker_info(struct mem_cgroup *memcg,
> > +                                       int size, int old_size)
> >  {
> > -     struct memcg_shrinker_map *new, *old;
> > +     struct memcg_shrinker_info *new, *old;
> >       int nid;
> >
> >       for_each_node(nid) {
> >               old = rcu_dereference_protected(
> > -                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> > +                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
> >               /* Not yet online memcg */
> >               if (!old)
> >                       return 0;
> > @@ -213,17 +213,17 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
> >               memset(new->map, (int)0xff, old_size);
> >               memset((void *)new->map + old_size, 0, size - old_size);
> >
> > -             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> > -             call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
> > +             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
> > +             call_rcu(&old->rcu, memcg_free_shrinker_info_rcu);
> >       }
> >
> >       return 0;
> >  }
> >
> > -void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
> > +void memcg_free_shrinker_info(struct mem_cgroup *memcg)
> >  {
> >       struct mem_cgroup_per_node *pn;
> > -     struct memcg_shrinker_map *map;
> > +     struct memcg_shrinker_info *info;
> >       int nid;
> >
> >       if (mem_cgroup_is_root(memcg))
> > @@ -231,16 +231,16 @@ void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
> >
> >       for_each_node(nid) {
> >               pn = mem_cgroup_nodeinfo(memcg, nid);
> > -             map = rcu_dereference_protected(pn->shrinker_map, true);
> > -             if (map)
> > -                     kvfree(map);
> > -             rcu_assign_pointer(pn->shrinker_map, NULL);
> > +             info = rcu_dereference_protected(pn->shrinker_info, true);
> > +             if (info)
> > +                     kvfree(info);
> > +             rcu_assign_pointer(pn->shrinker_info, NULL);
> >       }
> >  }
> >
> > -int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> > +int memcg_alloc_shrinker_info(struct mem_cgroup *memcg)
> >  {
> > -     struct memcg_shrinker_map *map;
> > +     struct memcg_shrinker_info *info;
> >       int nid, size, ret = 0;
> >
> >       if (mem_cgroup_is_root(memcg))
> > @@ -249,20 +249,20 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> >       down_read(&shrinker_rwsem);
> >       size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
> >       for_each_node(nid) {
> > -             map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
> > -             if (!map) {
> > -                     memcg_free_shrinker_maps(memcg);
> > +             info = kvzalloc(sizeof(*info) + size, GFP_KERNEL);
> > +             if (!info) {
> > +                     memcg_free_shrinker_info(memcg);
> >                       ret = -ENOMEM;
> >                       break;
> >               }
> > -             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
> > +             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
> >       }
> >       up_read(&shrinker_rwsem);
> >
> >       return ret;
> >  }
> >
> > -static int memcg_expand_shrinker_maps(int new_id)
> > +static int memcg_expand_shrinker_info(int new_id)
> >  {
> >       int size, old_size, ret = 0;
> >       struct mem_cgroup *memcg;
> > @@ -279,7 +279,7 @@ static int memcg_expand_shrinker_maps(int new_id)
> >       do {
> >               if (mem_cgroup_is_root(memcg))
> >                       continue;
> > -             ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
> > +             ret = memcg_expand_one_shrinker_info(memcg, size, old_size);
> >               if (ret) {
> >                       mem_cgroup_iter_break(NULL, memcg);
> >                       goto out;
> > @@ -293,13 +293,13 @@ static int memcg_expand_shrinker_maps(int new_id)
> >  void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> >  {
> >       if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
> > -             struct memcg_shrinker_map *map;
> > +             struct memcg_shrinker_info *info;
> >
> >               rcu_read_lock();
> > -             map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
> > +             info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> >               /* Pairs with smp mb in shrink_slab() */
> >               smp_mb__before_atomic();
> > -             set_bit(shrinker_id, map->map);
> > +             set_bit(shrinker_id, info->map);
> >               rcu_read_unlock();
> >       }
> >  }
> > @@ -330,7 +330,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >               goto unlock;
> >
> >       if (id >= shrinker_nr_max) {
> > -             if (memcg_expand_shrinker_maps(id)) {
> > +             if (memcg_expand_shrinker_info(id)) {
> >                       idr_remove(&shrinker_idr, id);
> >                       goto unlock;
> >               }
> > @@ -666,7 +666,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >                       struct mem_cgroup *memcg, int priority)
> >  {
> > -     struct memcg_shrinker_map *map;
> > +     struct memcg_shrinker_info *info;
> >       unsigned long ret, freed = 0;
> >       int i;
> >
> > @@ -676,12 +676,12 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >       if (!down_read_trylock(&shrinker_rwsem))
> >               return 0;
> >
> > -     map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
> > -                                     true);
> > -     if (unlikely(!map))
> > +     info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> > +                                      true);
> > +     if (unlikely(!info))
> >               goto unlock;
> >
> > -     for_each_set_bit(i, map->map, shrinker_nr_max) {
> > +     for_each_set_bit(i, info->map, shrinker_nr_max) {
> >               struct shrink_control sc = {
> >                       .gfp_mask = gfp_mask,
> >                       .nid = nid,
> > @@ -692,7 +692,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >               shrinker = idr_find(&shrinker_idr, i);
> >               if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
> >                       if (!shrinker)
> > -                             clear_bit(i, map->map);
> > +                             clear_bit(i, info->map);
> >                       continue;
> >               }
> >
> > @@ -703,7 +703,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >
> >               ret = do_shrink_slab(&sc, shrinker, priority);
> >               if (ret == SHRINK_EMPTY) {
> > -                     clear_bit(i, map->map);
> > +                     clear_bit(i, info->map);
> >                       /*
> >                        * After the shrinker reported that it had no objects to
> >                        * free, but before we cleared the corresponding bit in
> >
>
>
