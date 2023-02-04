Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B568A73A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 01:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjBDA0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 19:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjBDA0T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 19:26:19 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5608E6A5
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 16:26:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-507aac99fdfso66049837b3.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Feb 2023 16:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIcPLTJXUSQxI1A4pL/V2b6Q9BN8Fk+8wa9H/4PEokU=;
        b=L4dWu2NPGiRQ+SxmAlADu6aP3M7eG10ImnR/uquy95c6/xZZCMA34VDM4B333FzvXx
         k9cMuO1PorgGUIezeCHT54jEKU4p7Dt/nyhirWyrfg1w7E7v/5x8CIo066rPv29UGAdG
         nzMFp4BVBWweKZo5kzd35nHPDWgNQ3Jd7U2JFkfBROmXELttWjCVzQ8+sG9WxcC7gvMR
         y0RBDyDwx8VoSvuZONbJWLByGHLKOmy6JF0NNo+bc2VNPB6+mY0+E4hhxCFhwWsiwZFR
         JF6n3TnpFNEn8ibOMsXICGlpuk9jCDKh/DkDkAbVVUfXjx8Dk7qpNsDlMKoALWaFn3r1
         3Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIcPLTJXUSQxI1A4pL/V2b6Q9BN8Fk+8wa9H/4PEokU=;
        b=mTn17EhzLcEqiOTakBXapWNhNK4Zq2dXczpddCAEuaO87iSpt76CYrPAJjrryrfz0P
         hW3Vq1bMdnFOk8j/iJugcYTF22aSDsggDKacZ83YvJiOCpyzhlr0aPH2Tg71Z7gagJw4
         gH49Rzv097amfPRgP4m+T//IAi70KMLCkhXE4or6u56F46iS0/ixwIWgkp8Bw9VjO8SC
         rt64m9sOJpt1PP06klapjPSIom1BbYPSyqo0LvXQbNcfq8EtGeV988pjWXoMeox6ay7n
         C0yrdChq3rRxKlJ7gNMKg07GZWC7mV7H1IQ3Hk/ARJTAS5YjO1TrO17ZZ29txVONIlsV
         qTSQ==
X-Gm-Message-State: AO0yUKXfqohY0IJYjpHteh2xhlV2VrtLt6kndl71evur5tii07wMli5X
        1RlAu/xeWlcFDTWLsl5x++T84CSh1D43hA==
X-Google-Smtp-Source: AK7set/2OtzJesiIW5C91Xyq9qdtlKp4fyRJ5d2agaAL0ngPKBXru2DD13PJ848goucY0XFPcqpa0shTmX5DYQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:aa4c:0:b0:506:5e35:e3bc with SMTP id
 z12-20020a81aa4c000000b005065e35e3bcmr1640502ywk.139.1675470375588; Fri, 03
 Feb 2023 16:26:15 -0800 (PST)
Date:   Sat, 4 Feb 2023 00:26:13 +0000
In-Reply-To: <CAJD7tkZ7H-fGa3x3kbbdKgvzDDRZrGGZ6oazTA-7aNUQ7X1Pmg@mail.gmail.com>
Mime-Version: 1.0
References: <20230202233229.3895713-1-yosryahmed@google.com>
 <20230203000057.GS360264@dread.disaster.area> <CAJD7tkazLFO8sc1Ly7+2_SGTxDq2XuPnvxxTnpQyXQELmq+m4A@mail.gmail.com>
 <Y90kK5jnxBbE9tV4@cmpxchg.org> <CAJD7tkZ7H-fGa3x3kbbdKgvzDDRZrGGZ6oazTA-7aNUQ7X1Pmg@mail.gmail.com>
Message-ID: <20230204002613.f3ao52cpqf6wwxar@google.com>
Subject: Re: [RFC PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>,
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
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 03, 2023 at 07:28:49AM -0800, Yosry Ahmed wrote:
> On Fri, Feb 3, 2023 at 7:11 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Feb 02, 2023 at 04:17:18PM -0800, Yosry Ahmed wrote:
> > > On Thu, Feb 2, 2023 at 4:01 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > Patch 1 is just refactoring updating reclaim_state into a helper
> > > > > function, and renames reclaimed_slab to just reclaimed, with a comment
> > > > > describing its true purpose.
> > > > >
> > > > > Patch 2 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
> > > > >
> > > > > The original draft was a little bit different. It also kept track of
> > > > > uncharged objcg pages, and reported them only in memcg reclaim and only
> > > > > if the uncharged memcg is in the subtree of the memcg under reclaim.
> > > > > This was an attempt to make reporting of memcg reclaim even more
> > > > > accurate, but was dropped due to questionable complexity vs benefit
> > > > > tradeoff. It can be revived if there is interest.
> > > > >
> > > > > Yosry Ahmed (2):
> > > > >   mm: vmscan: refactor updating reclaimed pages in reclaim_state
> > > > >   mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
> > > > >
> > > > >  fs/inode.c           |  3 +--
> > > >
> > > > Inodes and inode mapping pages are directly charged to the memcg
> > > > that allocated them and the shrinker is correctly marked as
> > > > SHRINKER_MEMCG_AWARE. Freeing the pages attached to the inode will
> > > > account them correctly to the related memcg, regardless of which
> > > > memcg is triggering the reclaim.  Hence I'm not sure that skipping
> > > > the accounting of the reclaimed memory is even correct in this case;
> > >
> > > Please note that we are not skipping any accounting here. The pages
> > > are still uncharged from the memcgs they are charged to (the allocator
> > > memcgs as you pointed out). We just do not report them in the return
> > > value of try_to_free_mem_cgroup_pages(), to avoid over-reporting.
> >
> > I was wondering the same thing as Dave, reading through this. But
> > you're right, we'll catch the accounting during uncharge. Can you
> > please add a comment on the !cgroup_reclaim() explaining this?
> 
> Sure! If we settle on this implementation I will send another version
> with a comment and fix the build problem in patch 2.
> 
> >
> > There is one wrinkle with this, though. We have the following
> > (simplified) sequence during charging:
> >
> >         nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
> >                                                     gfp_mask, reclaim_options);
> >
> >         if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> >                 goto retry;
> >
> >         /*
> >          * Even though the limit is exceeded at this point, reclaim
> >          * may have been able to free some pages.  Retry the charge
> >          * before killing the task.
> >          *
> >          * Only for regular pages, though: huge pages are rather
> >          * unlikely to succeed so close to the limit, and we fall back
> >          * to regular pages anyway in case of failure.
> >          */
> >         if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
> >                 goto retry;
> >
> > So in the unlikely scenario where the first call doesn't make the
> > necessary headroom, and the shrinkers are the only thing that made
> > forward progress, we would OOM prematurely.
> >
> > Not that an OOM would seem that far away in that scenario, anyway. But I
> > remember long discussions with DavidR on probabilistic OOM regressions ;)
> >
> 
> Above the if (nr_reclaimed...) check we have:
> 
> if (gfp_mask & __GFP_NORETRY)
>     goto nomem;
> 
> , and below it we have:
> 
> if (nr_retries--)
>     goto retry;
> 
> So IIUC we only prematurely OOM if we either have __GFP_NORETRY and
> cannot reclaim any LRU pages in the first try, or if the scenario
> where only shrinkers were successful to reclaim happens in the last
> retry. Right?
> 

We don't call oom-killer for __GFP_NORETRY. Also note that the retry
(from nr_retries) after the reclaim includes page_counter_try_charge().
So, even if try_to_free_mem_cgroup_pages() have returned 0 after
reclaiming the slab memory of the memcg, the page_counter_try_charge()
should succeed if the reclaimed slab objects have created enough margin.

> > > > I think the code should still be accounting for all pages that
> > > > belong to the memcg being scanned that are reclaimed, not ignoring
> > > > them altogether...
> > >
> > > 100% agree. Ideally I would want to:
> > > - For pruned inodes: report all freed pages for global reclaim, and
> > > only report pages charged to the memcg under reclaim for memcg
> > > reclaim.
> >
> > This only happens on highmem systems at this point, as elsewhere
> > populated inodes aren't on the shrinker LRUs anymore. We'd probably be
> > ok with a comment noting the inaccuracy in the proactive reclaim stats
> > for the time being, until somebody actually cares about that combination.
> 
> Interesting, I did not realize this. I guess in this case we may get
> away with just ignoring non-LRU reclaimed pages in memcg reclaim
> completely, or go an extra bit and report uncharged objcg pages in
> memcg reclaim. See below.
> 
> >
> > > - For slab: report all freed pages for global reclaim, and only report
> > > uncharged objcg pages from the memcg under reclaim for memcg reclaim.
> > >
> > > The only problem is that I thought people would think this is too much
> > > complexity and not worth it. If people agree this should be the
> > > approach to follow, I can prepare patches for this. I originally
> > > implemented this for slab pages, but held off on sending it.
> >
> > I'd be curious to see the code!
> 
> I think it is small enough to paste here. Basically instead of just
> ignoring reclaim_state->reclaimed completely in patch 2, I counted
> uncharged objcg pages only in memcg reclaim instead of freed slab
> pages, and ignored pruned inode pages in memcg reclaim. So I guess we
> can go with either:
> - Just ignore freed slab pages and pages from pruned inodes in memcg
> reclaim (current RFC).
> - Ignore pruned inodes in memcg reclaim (as you explain above), and
> use the following diff instead of patch 2 for slab.
> - Use the following diff for slab AND properly report freed pages from
> pruned inodes if they are relevant to the memcg under reclaim.
> 
> Let me know what you think is best.
> 

I would prefer the currect RFC instead of the other two options. Those
options are slowing down (and adding complexity) to the uncharge code
path for the accuracy which no one really need or should care about.

> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index bc1d8b326453..37f799901dfb 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -162,6 +162,7 @@ struct reclaim_state {
>  };
> 
>  void report_freed_pages(unsigned long pages);
> +bool report_uncharged_pages(unsigned long pages, struct mem_cgroup *memcg);
> 
>  #ifdef __KERNEL__
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ab457f0394ab..a886ace70648 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3080,6 +3080,13 @@ static void obj_cgroup_uncharge_pages(struct
> obj_cgroup *objcg,
>         memcg_account_kmem(memcg, -nr_pages);
>         refill_stock(memcg, nr_pages);
> 
> +       /*
> +        * If undergoing memcg reclaim, report uncharged pages and drain local
> +        * stock to update the memcg usage.
> +        */
> +       if (report_uncharged_pages(nr_pages, memcg))
> +               drain_local_stock(NULL);
> +
>         css_put(&memcg->css);
>  }
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 207998b16e5f..d4eced2b884b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -204,17 +204,54 @@ static void set_task_reclaim_state(struct
> task_struct *task,
>         task->reclaim_state = rs;
>  }
> 
> +static bool cgroup_reclaim(struct scan_control *sc);
> +
>  /*
>   * reclaim_report_freed_pages: report pages freed outside of LRU-based reclaim
>   * @pages: number of pages freed
>   *
> - * If the current process is undergoing a reclaim operation,
> + * If the current process is undergoing a non-cgroup reclaim operation,
>   * increment the number of reclaimed pages by @pages.
>   */
>  void report_freed_pages(unsigned long pages)
>  {
> -       if (current->reclaim_state)
> -               current->reclaim_state->reclaimed += pages;
> +       struct reclaim_state *rs = current->reclaim_state;
> +       struct scan_control *sc;
> +
> +       if (!rs)
> +               return;
> +
> +       sc = container_of(rs, struct scan_control, reclaim_state);
> +       if (!cgroup_reclaim(sc))
> +               rs->reclaimed += pages;
> +}
> +
> +/*
> + * report_uncharged_pages: report pages uncharged outside of LRU-based reclaim
> + * @pages: number of pages uncharged
> + * @memcg: memcg pages were uncharged from
> + *
> + * If the current process is undergoing a cgroup reclaim operation, increment
> + * the number of reclaimed pages by @pages, if the memcg under
> reclaim is @memcg
> + * or an ancestor of it.
> + *
> + * Returns true if an update was made.
> + */
> +bool report_uncharged_pages(unsigned long pages, struct mem_cgroup *memcg)
> +{
> +       struct reclaim_state *rs = current->reclaim_state;
> +       struct scan_control *sc;
> +
> +       if (!rs)
> +               return false;
> +
> +       sc = container_of(rs, struct scan_control, reclaim_state);
> +       if (cgroup_reclaim(sc) &&
> +           mem_cgroup_is_descendant(memcg, sc->target_mem_cgroup)) {
> +               rs->reclaimed += pages;
> +               return true;
> +       }
> +       return false;
>  }
> 
>  LIST_HEAD(shrinker_list);
