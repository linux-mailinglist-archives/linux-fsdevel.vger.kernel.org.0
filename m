Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31D02F51CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 19:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbhAMSRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 13:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbhAMSRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:17:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE10C061786;
        Wed, 13 Jan 2021 10:16:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id w1so4394248ejf.11;
        Wed, 13 Jan 2021 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvTiuc+2xyLYeRcrb0/52TJi7BbIHLk9GXdghe1/ck8=;
        b=pZPUepV9NQObFtttTju09UoUXtYfPvhPFMxJJB/J23vy/w7suSvVg4SitD9bojoBvX
         tZHoOYT/vsEeRa3TCCYHp3xxQfoUllu44wefJBFlV51UiI84FmW0Ccx+rFgH/qXDfVyx
         XGoS6McIM2OwNfboCHh9qUKM7FSTeWpqFwKMxOspG/Gi6huHl69CcfKpyCkSgs3SSNg8
         1fuRawRQDqcKdpLD0a3C7MCb+1Dju9aDuQ2u+SrVUAP7GnxXh1T8UtEMLJ1dKhUn5eCx
         jcoW1Sj3lQAJWvYsy30ygSj+FmotUiEM7c945ROEuwgk4FwuWJQtyrXZQSVnDiKJQ9pp
         YtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvTiuc+2xyLYeRcrb0/52TJi7BbIHLk9GXdghe1/ck8=;
        b=ffZeiPil3x14t628ZMmbSMhNSqUhHCqVdCpQecKrkhTUsf5f4wB+xfpbacwU1ozPY+
         puNVOoWbZrD6GA1TIxLoqpn05hkpbk2kLDAWFXBdAYRBrYghQbBM3GRXtrZTLLNv1R8O
         jwrM5exxq6UoMt0DvA6surQtPlYjhaXpLsSm97t8/cL7PKBj4hc5jqTnWa5kpZsjRuIH
         VZL5tUqTYfNMm3mwaKKp8Fya1cJ57uiO4XLhUqd1ankxxmdtjlMJFtkVCSaKOFlb/krZ
         ewW71SKz9sK9lTGc33gH104tnvPo8D44P4MZBECTxENSqZW3g3aNxkI+0UeBrl+k/wqw
         ISvg==
X-Gm-Message-State: AOAM533kZ5+fH4TPcPSBqtBuyA5hnfk+DxuW68jk3xccXZPGmhEZAFqg
        f/sR0mzBpSpFxAU5yNZJN6ImsPEGxJBaoPg8kdk=
X-Google-Smtp-Source: ABdhPJxKf+o87lFKMsfYidQ89N1P8F5iDs2JRQ1uKOS/Fdx6rj7HQIU4g9yoy/JxQWjP2BUmUsOFyCecnWuNpcRGlGM=
X-Received: by 2002:a17:907:546:: with SMTP id wk6mr2432952ejb.238.1610561784993;
 Wed, 13 Jan 2021 10:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-4-shy828301@gmail.com>
 <56d26993-1577-3747-2d89-1275d92f7a15@virtuozzo.com> <CAHbLzkqS2b7Eb_xDU3-6wR=LN5yr4nDeyyaynfLCzFJOinuUZw@mail.gmail.com>
 <35543012-882c-2e1e-f23b-d25a6fa41e67@virtuozzo.com> <CAHbLzkpXjzN_730iqR_PnU0-vv_rbHZM1dKdjhzEdY8rstzZDg@mail.gmail.com>
 <dca605d9-ace9-3660-3dc6-6b413e342053@virtuozzo.com> <CAHbLzkqebxLaBt2Ok=rrYHCJ1U1zT+VXGsjzHsOZq37D6eeP-A@mail.gmail.com>
In-Reply-To: <CAHbLzkqebxLaBt2Ok=rrYHCJ1U1zT+VXGsjzHsOZq37D6eeP-A@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 13 Jan 2021 10:16:13 -0800
Message-ID: <CAHbLzkrHKTm0kvHSGXziFjv4b_jbkyY4R+RYePPB89_4yT7W7A@mail.gmail.com>
Subject: Re: [v3 PATCH 03/11] mm: vmscan: use shrinker_rwsem to protect
 shrinker_maps allocation
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

On Tue, Jan 12, 2021 at 1:23 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Jan 11, 2021 at 1:34 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >
> > On 11.01.2021 21:57, Yang Shi wrote:
> > > On Mon, Jan 11, 2021 at 9:34 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > >>
> > >> On 11.01.2021 20:08, Yang Shi wrote:
> > >>> On Wed, Jan 6, 2021 at 1:55 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > >>>>
> > >>>> On 06.01.2021 01:58, Yang Shi wrote:
> > >>>>> Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> > >>>>> exclusively, the read side can be protected by holding read lock, so it sounds
> > >>>>> superfluous to have a dedicated mutex.  This should not exacerbate the contention
> > >>>>> to shrinker_rwsem since just one read side critical section is added.
> > >>>>>
> > >>>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
> > >>>>> ---
> > >>>>>  mm/vmscan.c | 16 ++++++----------
> > >>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
> > >>>>>
> > >>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> > >>>>> index 9db7b4d6d0ae..ddb9f972f856 100644
> > >>>>> --- a/mm/vmscan.c
> > >>>>> +++ b/mm/vmscan.c
> > >>>>> @@ -187,7 +187,6 @@ static DECLARE_RWSEM(shrinker_rwsem);
> > >>>>>  #ifdef CONFIG_MEMCG
> > >>>>>
> > >>>>>  static int memcg_shrinker_map_size;
> > >>>>> -static DEFINE_MUTEX(memcg_shrinker_map_mutex);
> > >>>>>
> > >>>>>  static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
> > >>>>>  {
> > >>>>> @@ -200,8 +199,6 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
> > >>>>>       struct memcg_shrinker_map *new, *old;
> > >>>>>       int nid;
> > >>>>>
> > >>>>> -     lockdep_assert_held(&memcg_shrinker_map_mutex);
> > >>>>> -
> > >>>>>       for_each_node(nid) {
> > >>>>>               old = rcu_dereference_protected(
> > >>>>>                       mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> > >>>>> @@ -250,7 +247,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> > >>>>>       if (mem_cgroup_is_root(memcg))
> > >>>>>               return 0;
> > >>>>>
> > >>>>> -     mutex_lock(&memcg_shrinker_map_mutex);
> > >>>>> +     down_read(&shrinker_rwsem);
> > >>>>>       size = memcg_shrinker_map_size;
> > >>>>>       for_each_node(nid) {
> > >>>>>               map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
> > >>>>> @@ -261,7 +258,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> > >>>>>               }
> > >>>>>               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
> > >>>>
> > >>>> Here we do STORE operation, and since we want the assignment is visible
> > >>>> for shrink_slab_memcg() under down_read(), we have to use down_write()
> > >>>> in memcg_alloc_shrinker_maps().
> > >>>
> > >>> I apologize for the late reply, these emails went to my SPAM again.
> > >>
> > >> This is the second time the problem appeared. Just add my email address to allow list,
> > >> and there won't be this problem again.
> > >
> > > Yes, I thought clicking "not spam" would add your email address to the
> > > allow list automatically. But it turns out not true.
> > >
> > >>
> > >>> Before this patch it was not serialized by any lock either, right? Do
> > >>> we have to serialize it? As Johannes mentioned if shrinker_maps has
> > >>> not been initialized yet, it means the memcg is a newborn, there
> > >>> should not be significant amount of reclaimable slab caches, so it is
> > >>> fine to skip it. The point makes some sense to me.
> > >>>
> > >>> So, the read lock seems good enough.
> > >>
> > >> No, this is not so.
> > >>
> > >> Patch "[v3 PATCH 07/11] mm: vmscan: add per memcg shrinker nr_deferred" adds
> > >> new assignments:
> > >>
> > >> +               info->map = (unsigned long *)((unsigned long)info + sizeof(*info));
> > >> +               info->nr_deferred = (atomic_long_t *)((unsigned long)info +
> > >> +                                       sizeof(*info) + m_size);
> > >>
> > >> info->map and info->nr_deferred are not visible under READ lock in shrink_slab_memcg(),
> > >> unless you use WRITE lock in memcg_alloc_shrinker_maps().
> > >
> > > However map and nr_deferred are assigned before
> > > rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new). The
> > > shrink_slab_memcg() checks shrinker_info pointer.
> > > But that order might be not guaranteed, so it seems a memory barrier
> > > before rcu_assign_pointer should be good enough, right?
> >
> > Yes, and here are some more:
> >
> > 1)There is rcu_dereference_protected() dereferrencing in rcu_dereference_protected(),
> >   but in case of we use READ lock in memcg_alloc_shrinker_maps(), the dereferrencing
> >   is not actually protected.
> >
> > 2)READ lock makes memcg_alloc_shrinker_info() racy against memory allocation fail.
> >   memcg_alloc_shrinker_info()->memcg_free_shrinker_info() may free memory right
> >   after shrink_slab_memcg() dereferenced it. You may say shrink_slab_memcg()->mem_cgroup_online()
> >   protects us from it?! Yes, sure, but this is not the thing we want to remember
> >   in the future, since this spreads modularity.
> >
> > Why don't we use WRITE lock? It prohibits shrinking of SLAB during memcg_alloc_shrinker_info()->kvzalloc()?
>
> Yes, it is the main concern.
>
> > Yes, but it is not a problem, since page cache is still shrinkable, and we are able to
> > allocate memory. WRITE lock means better modularity, and it gives us a possibility
> > not to think about corner cases.
>
> I do agree using write lock makes life easier. I'm just not sure how
> bad the impact would be, particularly with vfs metadata heavy workload
> (the most memory is consumed by slab cache rather than page cache).
> But I think I can design a simple test case, which generates global
> memory pressure with slab cache (i.e. negative dentry cache), then
> create significant amount of memcgs (i.e. 10k), then check if the
> memcgs creation time is lengthened or not.

Did a test on a VM with two nodes (80 cpus) + 16GB memory. The test
does the below firstly:
* Generate negative dentry cache from all cpus to fill up the memory
* Run kernel build with 80 processes

The memory would be filled up and there should be multiple parallel
reclaimers running simultaneously (at least 2 kswapd processes, at
most 80 reclaimers), then create 10K memcgs (memcgs creation need
allocate shrinker_info with acquiring shrinker_rwsem).

The result is:

Read lock
real    7m17.891s
user    0m28.061s
sys     2m33.170s

Write lock
real    7m5.431s
user    0m20.400s
sys     2m53.162s

The one with write lock has longer sys time, it should not be caused
by the lock contention since the lock is rwsem, it might spend more
time in reclaiming pages. But it had a little bit shorter wall time
spent. And OOMs didn't happen either.

So, it seems using write lock didn't have a noticeable impact.

>
> >
> > >>
> > >> Nowhere in your patchset you convert READ lock to WRITE lock in memcg_alloc_shrinker_maps().
> > >>
> > >> So, just use the true lock in this patch from the first time.
> > >>
> > >>>>
> > >>>>>       }
> > >>>>> -     mutex_unlock(&memcg_shrinker_map_mutex);
> > >>>>> +     up_read(&shrinker_rwsem);
> > >>>>>
> > >>>>>       return ret;
> > >>>>>  }
> > >>>>> @@ -276,9 +273,8 @@ static int memcg_expand_shrinker_maps(int new_id)
> > >>>>>       if (size <= old_size)
> > >>>>>               return 0;
> > >>>>>
> > >>>>> -     mutex_lock(&memcg_shrinker_map_mutex);
> > >>>>>       if (!root_mem_cgroup)
> > >>>>> -             goto unlock;
> > >>>>> +             goto out;
> > >>>>>
> > >>>>>       memcg = mem_cgroup_iter(NULL, NULL, NULL);
> > >>>>>       do {
> > >>>>> @@ -287,13 +283,13 @@ static int memcg_expand_shrinker_maps(int new_id)
> > >>>>>               ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
> > >>>>>               if (ret) {
> > >>>>>                       mem_cgroup_iter_break(NULL, memcg);
> > >>>>> -                     goto unlock;
> > >>>>> +                     goto out;
> > >>>>>               }
> > >>>>>       } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> > >>>>> -unlock:
> > >>>>> +out:
> > >>>>>       if (!ret)
> > >>>>>               memcg_shrinker_map_size = size;
> > >>>>> -     mutex_unlock(&memcg_shrinker_map_mutex);
> > >>>>> +
> > >>>>>       return ret;
> > >>>>>  }
> > >>>>>
> > >>>>>
> > >>>>
> > >>>>
> > >>
> > >>
> >
> >
