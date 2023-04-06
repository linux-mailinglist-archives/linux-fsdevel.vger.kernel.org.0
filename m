Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146BC6D9F0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjDFRoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbjDFRoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:44:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74513E
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 10:44:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id cw23so3268574ejb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680803043; x=1683395043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgunQKgjebnF9/8Pl+g6YNmqfUk6jNisGsID9O/PX0w=;
        b=ccSPSMRUDSc0bpLAhvDCPyES07oKwyIPZNwuQ/IwZoOgNBsMXGbH+jhpzcy2CVs6qe
         gf9q7XlZX6ZhtppOGmeAjo6xywnsdB5dv2HzOpUbMN2fJXWuqZGuAWO9sgExTpbJehI8
         TQunqGBOG6XHxog87yLj7Wv+VJD0njH/KctbHt8uMNWNiqLCpf6zzT6ZRYdVL6JeTJfG
         /y/8SaqX1OEijhY6eIOBA47tJsskssjQsL7B5zdEouMlCtKuog897UwiSIWk8QHAEyy+
         /vEQSxwnWA+KRfv4bkA1zaiaNt33qeMlHVQTQ99RhLlotsKTTZjVtOa9Uh8XO8Ni/IN4
         F//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803043; x=1683395043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgunQKgjebnF9/8Pl+g6YNmqfUk6jNisGsID9O/PX0w=;
        b=F7h6xA5nrQAc1R6m8VSuUzBftMOBqGyzA5pD6fgSDdccmvU22quApzQhzZDf7YQu8q
         nS59zxDPCULjpVQQs1mHrhHG39gu+7Ezfumh1lsixWMB1yjiXegb7PlxTxFkSK1DP0wp
         9I6lNqK/Ym+v0MnjR9RHYn4o4tfk9et9FE0e6gQRlIQvyZFh9GSOCGG2CufnRVPXVEeH
         rukWuxlrruNV5bD1/TwMUcQpitDro3RHurTmvJTfV7d6dQJoaKcYdTjVCIhxRJqAaiLG
         5wF548nGjFhaIT1zYSE5ak/ItMZ6gz/zqxkPvb3pk8KHk3r7Im9qkmneajODmmhwiuFV
         uRHQ==
X-Gm-Message-State: AAQBX9e2kUVBR6sxmAwwVrtR/sIR1MGgWqWjGEYcf1iwx1mXqZp60ZDi
        fYBxMla0+WT9rJzdToDUlzoDFvyJuNzAlZDPLTFGRQ==
X-Google-Smtp-Source: AKy350YZCB81x1cGqgvlEBOWniXPPvM6+lltZphTq903yxpYwzfZBjlDbC3vDoI0wZFDeqDHeUfEbCrCYBOWbFRwrmI=
X-Received: by 2002:a17:906:3b07:b0:935:3085:303b with SMTP id
 g7-20020a1709063b0700b009353085303bmr3722546ejf.15.1680803043263; Thu, 06 Apr
 2023 10:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230405185427.1246289-1-yosryahmed@google.com>
 <20230405185427.1246289-3-yosryahmed@google.com> <7ce03e4323b95c1e8fd3faed32c9b285162fe5a8.camel@linux.intel.com>
In-Reply-To: <7ce03e4323b95c1e8fd3faed32c9b285162fe5a8.camel@linux.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 6 Apr 2023 10:43:26 -0700
Message-ID: <CAJD7tkaDcCDhBdM+CwpmZYtaJL1JqsRzt9CXTH_+rzprM9eZ0A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm: vmscan: refactor reclaim_state helpers
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 6, 2023 at 10:32=E2=80=AFAM Tim Chen <tim.c.chen@linux.intel.co=
m> wrote:
>
> On Wed, 2023-04-05 at 18:54 +0000, Yosry Ahmed wrote:
> > During reclaim, we keep track of pages reclaimed from other means than
> > LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
> > which we stash a pointer to in current task_struct.
> >
> > However, we keep track of more than just reclaimed slab pages through
> > this. We also use it for clean file pages dropped through pruned inodes=
,
> > and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add
> > a helper function that wraps updating it through current, so that futur=
e
> > changes to this logic are contained within mm/vmscan.c.
> >
> > Additionally, add a flush_reclaim_state() helper to wrap using
> > reclaim_state->reclaimed to updated sc->nr_reclaimed, and use that
> > helper to add an elaborate comment about why we only do the update for
> > global reclaim.
> >
> > Finally, move set_task_reclaim_state() next to flush_reclaim_state() so
> > that all reclaim_state helpers are in close proximity for easier
> > readability.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  fs/inode.c           |  3 +-
> >  fs/xfs/xfs_buf.c     |  3 +-
> >  include/linux/swap.h | 17 +++++++++-
> >  mm/slab.c            |  3 +-
> >  mm/slob.c            |  6 ++--
> >  mm/slub.c            |  5 ++-
> >  mm/vmscan.c          | 75 ++++++++++++++++++++++++++++++++------------
> >  7 files changed, 78 insertions(+), 34 deletions(-)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 4558dc2f13557..e60fcc41faf17 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -864,8 +864,7 @@ static enum lru_status inode_lru_isolate(struct lis=
t_head *item,
> >                               __count_vm_events(KSWAPD_INODESTEAL, reap=
);
> >                       else
> >                               __count_vm_events(PGINODESTEAL, reap);
> > -                     if (current->reclaim_state)
> > -                             current->reclaim_state->reclaimed_slab +=
=3D reap;
> > +                     mm_account_reclaimed_pages(reap);
> >               }
> >               iput(inode);
> >               spin_lock(lru_lock);
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index 54c774af6e1c6..15d1e5a7c2d34 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -286,8 +286,7 @@ xfs_buf_free_pages(
> >               if (bp->b_pages[i])
> >                       __free_page(bp->b_pages[i]);
> >       }
> > -     if (current->reclaim_state)
> > -             current->reclaim_state->reclaimed_slab +=3D bp->b_page_co=
unt;
> > +     mm_account_reclaimed_pages(bp->b_page_count);
> >
> >       if (bp->b_pages !=3D bp->b_page_array)
> >               kmem_free(bp->b_pages);
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 209a425739a9f..e131ac155fb95 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -153,13 +153,28 @@ union swap_header {
> >   * memory reclaim
> >   */
> >  struct reclaim_state {
> > -     unsigned long reclaimed_slab;
> > +     /* pages reclaimed outside of LRU-based reclaim */
> > +     unsigned long reclaimed;
> >  #ifdef CONFIG_LRU_GEN
> >       /* per-thread mm walk data */
> >       struct lru_gen_mm_walk *mm_walk;
> >  #endif
> >  };
> >
> > +/*
> > + * mm_account_reclaimed_pages(): account reclaimed pages outside of LR=
U-based
> > + * reclaim
> > + * @pages: number of pages reclaimed
> > + *
> > + * If the current process is undergoing a reclaim operation, increment=
 the
> > + * number of reclaimed pages by @pages.
> > + */
> > +static inline void mm_account_reclaimed_pages(unsigned long pages)
> > +{
> > +     if (current->reclaim_state)
> > +             current->reclaim_state->reclaimed +=3D pages;
> > +}
> > +
> >  #ifdef __KERNEL__
> >
> >  struct address_space;
> > diff --git a/mm/slab.c b/mm/slab.c
> > index dabc2a671fc6f..64bf1de817b24 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -1392,8 +1392,7 @@ static void kmem_freepages(struct kmem_cache *cac=
hep, struct slab *slab)
> >       smp_wmb();
> >       __folio_clear_slab(folio);
> >
> > -     if (current->reclaim_state)
> > -             current->reclaim_state->reclaimed_slab +=3D 1 << order;
> > +     mm_account_reclaimed_pages(1 << order);
> >       unaccount_slab(slab, order, cachep);
> >       __free_pages(&folio->page, order);
> >  }
> > diff --git a/mm/slob.c b/mm/slob.c
> > index fe567fcfa3a39..79cc8680c973c 100644
> > --- a/mm/slob.c
> > +++ b/mm/slob.c
> > @@ -61,7 +61,7 @@
> >  #include <linux/slab.h>
> >
> >  #include <linux/mm.h>
> > -#include <linux/swap.h> /* struct reclaim_state */
> > +#include <linux/swap.h> /* mm_account_reclaimed_pages() */
> >  #include <linux/cache.h>
> >  #include <linux/init.h>
> >  #include <linux/export.h>
> > @@ -211,9 +211,7 @@ static void slob_free_pages(void *b, int order)
> >  {
> >       struct page *sp =3D virt_to_page(b);
> >
> > -     if (current->reclaim_state)
> > -             current->reclaim_state->reclaimed_slab +=3D 1 << order;
> > -
> > +     mm_account_reclaimed_pages(1 << order);
> >       mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
> >                           -(PAGE_SIZE << order));
> >       __free_pages(sp, order);
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 39327e98fce34..7aa30eef82350 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -11,7 +11,7 @@
> >   */
> >
> >  #include <linux/mm.h>
> > -#include <linux/swap.h> /* struct reclaim_state */
> > +#include <linux/swap.h> /* mm_account_reclaimed_pages() */
> >  #include <linux/module.h>
> >  #include <linux/bit_spinlock.h>
> >  #include <linux/interrupt.h>
> > @@ -2063,8 +2063,7 @@ static void __free_slab(struct kmem_cache *s, str=
uct slab *slab)
> >       /* Make the mapping reset visible before clearing the flag */
> >       smp_wmb();
> >       __folio_clear_slab(folio);
> > -     if (current->reclaim_state)
> > -             current->reclaim_state->reclaimed_slab +=3D pages;
> > +     mm_account_reclaimed_pages(pages);
> >       unaccount_slab(slab, order, s);
> >       __free_pages(&folio->page, order);
> >  }
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index c82bd89f90364..049e39202e6ce 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -188,18 +188,6 @@ struct scan_control {
> >   */
> >  int vm_swappiness =3D 60;
> >
> > -static void set_task_reclaim_state(struct task_struct *task,
> > -                                struct reclaim_state *rs)
> > -{
> > -     /* Check for an overwrite */
> > -     WARN_ON_ONCE(rs && task->reclaim_state);
> > -
> > -     /* Check for the nulling of an already-nulled member */
> > -     WARN_ON_ONCE(!rs && !task->reclaim_state);
> > -
> > -     task->reclaim_state =3D rs;
> > -}
> > -
> >  LIST_HEAD(shrinker_list);
> >  DECLARE_RWSEM(shrinker_rwsem);
> >
> > @@ -511,6 +499,59 @@ static bool writeback_throttling_sane(struct scan_=
control *sc)
> >  }
> >  #endif
> >
> > +static void set_task_reclaim_state(struct task_struct *task,
> > +                                struct reclaim_state *rs)
> > +{
> > +     /* Check for an overwrite */
> > +     WARN_ON_ONCE(rs && task->reclaim_state);
> > +
> > +     /* Check for the nulling of an already-nulled member */
> > +     WARN_ON_ONCE(!rs && !task->reclaim_state);
> > +
> > +     task->reclaim_state =3D rs;
> > +}
> > +
> > +/*
> > + * flush_reclaim_state(): add pages reclaimed outside of LRU-based rec=
laim to
> > + * scan_control->nr_reclaimed.
> > + */
> > +static void flush_reclaim_state(struct scan_control *sc,
> > +                             struct reclaim_state *rs)
> > +{
> > +     /*
> > +      * Currently, reclaim_state->reclaimed includes three types of pa=
ges
> > +      * freed outside of vmscan:
> > +      * (1) Slab pages.
> > +      * (2) Clean file pages from pruned inodes.
> > +      * (3) XFS freed buffer pages.
> > +      *
> > +      * For all of these cases, we have no way of finding out whether =
these
> > +      * pages were related to the memcg under reclaim. For example, a =
freed
> > +      * slab page could have had only a single object charged to the m=
emcg
>
> Minor nits:
> s/could have had/could have
>
> > +      * under reclaim. Also, populated inodes are not on shrinker LRUs
> > +      * anymore except on highmem systems.
> > +      *
> > +      * Instead of over-reporting the reclaimed pages in a memcg recla=
im,
> > +      * only count such pages in global reclaim. This prevents unneces=
sary
>
> May be clearer to say:
> This prevents under-reclaimaing the target memcg, and unnecessary

Thanks, will rephrase for the next version!

>
> > +      * retries during memcg charging and false positive from proactiv=
e
> > +      * reclaim (memory.reclaim).
> > +      *
>
> Tim
>
