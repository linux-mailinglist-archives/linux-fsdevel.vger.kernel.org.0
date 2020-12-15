Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839952DAE20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 14:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgLONiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 08:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgLONiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:38:46 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998BBC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 05:38:05 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id b5so7412080pjk.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 05:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqQtUUF8v33Jmoi4KsNYNxm+V8KvPZvIUDhNuJPsSpk=;
        b=crmpJe2KDqllH6uD1Kf3tFpZBzvrdCqywLDVfk6jq1MIyUxTgBToe8PSKD/zUM8Yxo
         2JqYZNUD+jLPbE4ao4VrJz4y/ArbTu392ix5ZnlIAe79vAQQi44gQ7jcRUDpcgmQq9kP
         TJjRgVcCNYTR1vOT/+yNzTKT3GhfqgvVvOpqkJEEv5zsPSvYIj9C8z+gaMjF3oA5I731
         /0kT/AfluTp1BcpFzLnqXBFB7o/gugtmC5Sm45E5s3lh6aR4SdjNC9gjb14Vg6npumlX
         o9dfKccg5LVbKoCakLRm3pYENc/7Z4spBCYUCP2gnLIWrxhZZcU2/gdC/cr2NjnCoi3z
         URTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqQtUUF8v33Jmoi4KsNYNxm+V8KvPZvIUDhNuJPsSpk=;
        b=tWrNyUzyEG+OOP3VNe1zyayHiSjJK7YTLqpeZBgwXjYN4U6i8NWgcF1OBn3Kb9ix1p
         mwJwpdDNCIuhLD+6nk2pwRHk/ZEzKcUQezhAZT3R8FRfjMV6UK+bytbcZp6x9EkhhuOG
         Y/6W0IIKktwJEvNN4jyS6Sttn7Hf0Muti9aQ9hFLBb4NcVnt9O6lGZBBOIiu3H/sRe+s
         7stDGrOFG35uh0H6KQBIijpEYX6zYWwSYQGrmGeLhTZkhH94Uawex3otHvFjozdW6V1a
         qSHH+19axgeMb7F5VICDHjxg9Y/1EUiol3MXrtDHWFZ5LXc6UWTDjOLV86q9iGjLJhru
         Hqpw==
X-Gm-Message-State: AOAM532tMWO9ydEfb4htJyKLbqqlNr+5rnegk9g8vt9JAOwQN32hGsiO
        5Uce+yT/GWF8WVB0FceFIXJNDWGyh1E1BAu+xn8o5Q==
X-Google-Smtp-Source: ABdhPJwGufK6wRVZz2t/Y5+TwVRmoNZ2XG3IEg5U0NDltpU68/Msw+lp7VJjfFCucHPVxZA9yJQjEQls+4uwTSmqXig=
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id
 b13-20020a170902ed0db02900dac83b5f40mr1162761pld.20.1608039484985; Tue, 15
 Dec 2020 05:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20201208041847.72122-1-songmuchun@bytedance.com>
 <20201208041847.72122-3-songmuchun@bytedance.com> <20201215133038.GO32193@dhcp22.suse.cz>
In-Reply-To: <20201215133038.GO32193@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 15 Dec 2020 21:37:28 +0800
Message-ID: <CAMZfGtWF9Lft=j-KKW9VYHLH0LL45TZ+pU9q6JHz7RByNWnpQg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/7] mm: memcontrol: convert
 NR_ANON_THPS account to pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Feng Tang <feng.tang@intel.com>, Neil Brown <neilb@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 9:30 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 08-12-20 12:18:42, Muchun Song wrote:
> > The unit of NR_ANON_THPS is HPAGE_PMD_NR. Convert the NR_ANON_THPS
> > account to pages.
>
> This changelog could benefit from some improvements. First of all you
> should be clear about the motivation. I believe the previous feedback
> was also to explicitly mention what effect this has on the pcp
> accounting flushing.

Thank you. Will update.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  drivers/base/node.c |  3 +--
> >  fs/proc/meminfo.c   |  2 +-
> >  mm/huge_memory.c    |  3 ++-
> >  mm/memcontrol.c     | 20 ++++++--------------
> >  mm/page_alloc.c     |  2 +-
> >  mm/rmap.c           |  7 ++++---
> >  6 files changed, 15 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 04f71c7bc3f8..ec35cb567940 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -461,8 +461,7 @@ static ssize_t node_read_meminfo(struct device *dev,
> >                            nid, K(sunreclaimable)
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >                            ,
> > -                          nid, K(node_page_state(pgdat, NR_ANON_THPS) *
> > -                                 HPAGE_PMD_NR),
> > +                          nid, K(node_page_state(pgdat, NR_ANON_THPS)),
> >                            nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
> >                                   HPAGE_PMD_NR),
> >                            nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
> > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > index d6fc74619625..a635c8a84ddf 100644
> > --- a/fs/proc/meminfo.c
> > +++ b/fs/proc/meminfo.c
> > @@ -129,7 +129,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >       show_val_kb(m, "AnonHugePages:  ",
> > -                 global_node_page_state(NR_ANON_THPS) * HPAGE_PMD_NR);
> > +                 global_node_page_state(NR_ANON_THPS));
> >       show_val_kb(m, "ShmemHugePages: ",
> >                   global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
> >       show_val_kb(m, "ShmemPmdMapped: ",
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 10dd3cae5f53..66ec454120de 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2178,7 +2178,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >               lock_page_memcg(page);
> >               if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
> >                       /* Last compound_mapcount is gone. */
> > -                     __dec_lruvec_page_state(page, NR_ANON_THPS);
> > +                     __mod_lruvec_page_state(page, NR_ANON_THPS,
> > +                                             -HPAGE_PMD_NR);
> >                       if (TestClearPageDoubleMap(page)) {
> >                               /* No need in mapcount reference anymore */
> >                               for (i = 0; i < HPAGE_PMD_NR; i++)
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 8818bf64d6fe..b18e25a5cdf3 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1532,7 +1532,7 @@ static struct memory_stat memory_stats[] = {
> >        * on some architectures, the macro of HPAGE_PMD_SIZE is not
> >        * constant(e.g. powerpc).
> >        */
> > -     { "anon_thp", 0, NR_ANON_THPS },
> > +     { "anon_thp", PAGE_SIZE, NR_ANON_THPS },
> >       { "file_thp", 0, NR_FILE_THPS },
> >       { "shmem_thp", 0, NR_SHMEM_THPS },
> >  #endif
> > @@ -1565,8 +1565,7 @@ static int __init memory_stats_init(void)
> >
> >       for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -             if (memory_stats[i].idx == NR_ANON_THPS ||
> > -                 memory_stats[i].idx == NR_FILE_THPS ||
> > +             if (memory_stats[i].idx == NR_FILE_THPS ||
> >                   memory_stats[i].idx == NR_SHMEM_THPS)
> >                       memory_stats[i].ratio = HPAGE_PMD_SIZE;
> >  #endif
> > @@ -4088,10 +4087,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
> >               if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
> >                       continue;
> >               nr = memcg_page_state_local(memcg, memcg1_stats[i]);
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -             if (memcg1_stats[i] == NR_ANON_THPS)
> > -                     nr *= HPAGE_PMD_NR;
> > -#endif
> >               seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
> >       }
> >
> > @@ -4122,10 +4117,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
> >               if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
> >                       continue;
> >               nr = memcg_page_state(memcg, memcg1_stats[i]);
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -             if (memcg1_stats[i] == NR_ANON_THPS)
> > -                     nr *= HPAGE_PMD_NR;
> > -#endif
> >               seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
> >                                               (u64)nr * PAGE_SIZE);
> >       }
> > @@ -5653,10 +5644,11 @@ static int mem_cgroup_move_account(struct page *page,
> >                       __mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
> >                       __mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
> >                       if (PageTransHuge(page)) {
> > -                             __dec_lruvec_state(from_vec, NR_ANON_THPS);
> > -                             __inc_lruvec_state(to_vec, NR_ANON_THPS);
> > +                             __mod_lruvec_state(from_vec, NR_ANON_THPS,
> > +                                                -nr_pages);
> > +                             __mod_lruvec_state(to_vec, NR_ANON_THPS,
> > +                                                nr_pages);
> >                       }
> > -
> >               }
> >       } else {
> >               __mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 469e28f95ce7..1700f52b7869 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5580,7 +5580,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
> >                       K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
> >                       K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
> >                                       * HPAGE_PMD_NR),
> > -                     K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
> > +                     K(node_page_state(pgdat, NR_ANON_THPS)),
> >  #endif
> >                       K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
> >                       node_page_state(pgdat, NR_KERNEL_STACK_KB),
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 08c56aaf72eb..f59e92e26b61 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1144,7 +1144,8 @@ void do_page_add_anon_rmap(struct page *page,
> >                * disabled.
> >                */
> >               if (compound)
> > -                     __inc_lruvec_page_state(page, NR_ANON_THPS);
> > +                     __mod_lruvec_page_state(page, NR_ANON_THPS,
> > +                                             HPAGE_PMD_NR);
> >               __mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
> >       }
> >
> > @@ -1186,7 +1187,7 @@ void page_add_new_anon_rmap(struct page *page,
> >               if (hpage_pincount_available(page))
> >                       atomic_set(compound_pincount_ptr(page), 0);
> >
> > -             __inc_lruvec_page_state(page, NR_ANON_THPS);
> > +             __mod_lruvec_page_state(page, NR_ANON_THPS, HPAGE_PMD_NR);
> >       } else {
> >               /* Anon THP always mapped first with PMD */
> >               VM_BUG_ON_PAGE(PageTransCompound(page), page);
> > @@ -1292,7 +1293,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
> >       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> >               return;
> >
> > -     __dec_lruvec_page_state(page, NR_ANON_THPS);
> > +     __mod_lruvec_page_state(page, NR_ANON_THPS, -HPAGE_PMD_NR);
> >
> >       if (TestClearPageDoubleMap(page)) {
> >               /*
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs



--
Yours,
Muchun
