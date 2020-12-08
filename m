Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C02D2503
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 08:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgLHHyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 02:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgLHHyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:54:22 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A5FC061794
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 23:53:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id r4so2438048pls.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 23:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yOAVZjGe0LBykCQztVKp2D4Gmc2eJlF3ZDhvK2CW4w=;
        b=I6+h+plxzfDytT3JY5089iYAUGryc03SX1u46qY0mKqZS/nBI9KbegEu4vDHyaZvR8
         1gN8VtP1D147cTFIn3dimmElmmW76jgsNjvyGHLhCTrWY/PbxZ2JNdKmCFX4ErbFkjK6
         HjxKS1TkSg3AOZFe/5hrIX2hAd2b44RDj1bMTGPEEXKy3iMOS7DPGQyzMTKIGLaEinoL
         QMwcLKR5xgMkmSRwfs3nkZLQtNfN/Kn3deg57xuctwnL+SjgCSeNvHrAVcebgTrCUkC9
         5VfC3mjMfe9zjGzylGzR1BMiECSMMYtrSnV24QfimsEQvbnmPOGGuiScUPM2EVmWBFSc
         mGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yOAVZjGe0LBykCQztVKp2D4Gmc2eJlF3ZDhvK2CW4w=;
        b=gkflHjejXLrYM/9XyvFmFk//8XYj1wkJVXUuMJjC97EquyTJ11dHTfRFKlp7in2Sha
         xeRKfYtFbBjkTxtwkg+nDyp3DxZUn27AT0Eqon/fa7DxofGl9QPZcxzGITWy74tULJjn
         b8oJwgnFKgIgbRNfX7IpmTW7sfBlm4GLKhFp7SfVPBXzHBr/b4thXX05hKtU2pitlh/S
         0DzYa/mmW5vnh1j2sKmuQ2PIpL/fPRjO3lwmM3w5NKiwJazVhvaUxJ5skt+iyFBXrBAF
         rAbl4FC9Iddpb+hTZtPv8ruMeEXM0HyFZ3ySDDipoSeTq64co7yu1t+D8KZhLqO1Vv9h
         MwHg==
X-Gm-Message-State: AOAM532bVDiWBFing1H4pPLsvioJW5I5QJHRW2y1ZBeZvAC48Xlgcs28
        kZNxeMRo1ObTQ/A0P5GerYweLzST+utHlgfWvcPyJA==
X-Google-Smtp-Source: ABdhPJwCu+RkIOjZ4EZmnfUZRQMKj2S2yjYBnRNWVVVOr4SzPLOF3SVcLmbjbu4HCM5OrM7HcnuIy//60ukVPxOJPPs=
X-Received: by 2002:a17:902:76c8:b029:d9:d6c3:357d with SMTP id
 j8-20020a17090276c8b02900d9d6c3357dmr20261768plt.34.1607414021513; Mon, 07
 Dec 2020 23:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20201208041847.72122-1-songmuchun@bytedance.com>
 <20201208041847.72122-8-songmuchun@bytedance.com> <CAM9Jb+jg7dD3u4b8P4X_6ginSM3UwVtmbdQzjaencb0r3_bAuQ@mail.gmail.com>
In-Reply-To: <CAM9Jb+jg7dD3u4b8P4X_6ginSM3UwVtmbdQzjaencb0r3_bAuQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Dec 2020 15:53:05 +0800
Message-ID: <CAMZfGtV=tc3=ZbePPEWTA2ziDb1hw8KzJXc+Uiedx+xmXY--XA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 7/7] mm: memcontrol: make the slab
 calculation consistent
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
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
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 8, 2020 at 3:21 PM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> > Although the ratio of the slab is one, we also should read the ratio
> > from the related memory_stats instead of hard-coding. And the local
> > variable of size is already the value of slab_unreclaimable. So we
> > do not need to read again.
> >
> > We can drop the ratio in struct memory_stat. This can make the code
> > clean and simple. And get rid of the awkward mix of static and runtime
> > initialization of the memory_stats table.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 112 ++++++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 73 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a40797a27f87..841ea37cc123 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1511,49 +1511,78 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> >
> >  struct memory_stat {
> >         const char *name;
> > -       unsigned int ratio;
> >         unsigned int idx;
> >  };
> >
> >  static const struct memory_stat memory_stats[] = {
> > -       { "anon", PAGE_SIZE, NR_ANON_MAPPED },
> > -       { "file", PAGE_SIZE, NR_FILE_PAGES },
> > -       { "kernel_stack", 1024, NR_KERNEL_STACK_KB },
> > -       { "pagetables", PAGE_SIZE, NR_PAGETABLE },
> > -       { "percpu", 1, MEMCG_PERCPU_B },
> > -       { "sock", PAGE_SIZE, MEMCG_SOCK },
> > -       { "shmem", PAGE_SIZE, NR_SHMEM },
> > -       { "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
> > -       { "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
> > -       { "file_writeback", PAGE_SIZE, NR_WRITEBACK },
> > +       { "anon",                       NR_ANON_MAPPED                  },
> > +       { "file",                       NR_FILE_PAGES                   },
> > +       { "kernel_stack",               NR_KERNEL_STACK_KB              },
> > +       { "pagetables",                 NR_PAGETABLE                    },
> > +       { "percpu",                     MEMCG_PERCPU_B                  },
> > +       { "sock",                       MEMCG_SOCK                      },
> > +       { "shmem",                      NR_SHMEM                        },
> > +       { "file_mapped",                NR_FILE_MAPPED                  },
> > +       { "file_dirty",                 NR_FILE_DIRTY                   },
> > +       { "file_writeback",             NR_WRITEBACK                    },
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -       { "anon_thp", PAGE_SIZE, NR_ANON_THPS },
> > -       { "file_thp", PAGE_SIZE, NR_FILE_THPS },
> > -       { "shmem_thp", PAGE_SIZE, NR_SHMEM_THPS },
> > +       { "anon_thp",                   NR_ANON_THPS                    },
> > +       { "file_thp",                   NR_FILE_THPS                    },
> > +       { "shmem_thp",                  NR_SHMEM_THPS                   },
> >  #endif
> > -       { "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
> > -       { "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> > -       { "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
> > -       { "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
> > -       { "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
> > -
> > -       /*
> > -        * Note: The slab_reclaimable and slab_unreclaimable must be
> > -        * together and slab_reclaimable must be in front.
> > -        */
> > -       { "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
> > -       { "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
> > +       { "inactive_anon",              NR_INACTIVE_ANON                },
> > +       { "active_anon",                NR_ACTIVE_ANON                  },
> > +       { "inactive_file",              NR_INACTIVE_FILE                },
> > +       { "active_file",                NR_ACTIVE_FILE                  },
> > +       { "unevictable",                NR_UNEVICTABLE                  },
> > +       { "slab_reclaimable",           NR_SLAB_RECLAIMABLE_B           },
> > +       { "slab_unreclaimable",         NR_SLAB_UNRECLAIMABLE_B         },
> >
> >         /* The memory events */
> > -       { "workingset_refault_anon", 1, WORKINGSET_REFAULT_ANON },
> > -       { "workingset_refault_file", 1, WORKINGSET_REFAULT_FILE },
> > -       { "workingset_activate_anon", 1, WORKINGSET_ACTIVATE_ANON },
> > -       { "workingset_activate_file", 1, WORKINGSET_ACTIVATE_FILE },
> > -       { "workingset_restore_anon", 1, WORKINGSET_RESTORE_ANON },
> > -       { "workingset_restore_file", 1, WORKINGSET_RESTORE_FILE },
> > -       { "workingset_nodereclaim", 1, WORKINGSET_NODERECLAIM },
> > +       { "workingset_refault_anon",    WORKINGSET_REFAULT_ANON         },
> > +       { "workingset_refault_file",    WORKINGSET_REFAULT_FILE         },
> > +       { "workingset_activate_anon",   WORKINGSET_ACTIVATE_ANON        },
> > +       { "workingset_activate_file",   WORKINGSET_ACTIVATE_FILE        },
> > +       { "workingset_restore_anon",    WORKINGSET_RESTORE_ANON         },
> > +       { "workingset_restore_file",    WORKINGSET_RESTORE_FILE         },
> > +       { "workingset_nodereclaim",     WORKINGSET_NODERECLAIM          },
> >  };
> >
> > +/* Translate stat items to the correct unit for memory.stat output */
> > +static int memcg_page_state_unit(int item)
> > +{
> > +       int unit;
> > +
> > +       switch (item) {
> > +       case MEMCG_PERCPU_B:
> > +       case NR_SLAB_RECLAIMABLE_B:
> > +       case NR_SLAB_UNRECLAIMABLE_B:
> > +       case WORKINGSET_REFAULT_ANON:
> > +       case WORKINGSET_REFAULT_FILE:
> > +       case WORKINGSET_ACTIVATE_ANON:
> > +       case WORKINGSET_ACTIVATE_FILE:
> > +       case WORKINGSET_RESTORE_ANON:
> > +       case WORKINGSET_RESTORE_FILE:
> > +       case WORKINGSET_NODERECLAIM:
> > +               unit = 1;
> > +               break;
> > +       case NR_KERNEL_STACK_KB:
> > +               unit = SZ_1K;
> > +               break;
> > +       default:
> > +               unit = PAGE_SIZE;
> > +               break;
>  break not needed here, or maybe we can return for every case,
> that will avoid "unit" variable.

Yeah, thanks.

>
> > +       }
> > +
> > +       return unit;
> > +}
> > +
> > +static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
> > +                                                   int item)
> > +{
> > +       return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
> > +}
> > +
> >  static char *memory_stat_format(struct mem_cgroup *memcg)
> >  {
> >         struct seq_buf s;
> > @@ -1577,13 +1606,12 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> >         for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
> >                 u64 size;
> >
> > -               size = memcg_page_state(memcg, memory_stats[i].idx);
> > -               size *= memory_stats[i].ratio;
> > +               size = memcg_page_state_output(memcg, memory_stats[i].idx);
> >                 seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
> >
> >                 if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
> > -                       size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> > -                              memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
> > +                       size +=
> (memcg,
> > +                                                       NR_SLAB_RECLAIMABLE_B);
> >                         seq_buf_printf(&s, "slab %llu\n", size);
> >                 }
> >         }
> > @@ -6377,6 +6405,12 @@ static int memory_stat_show(struct seq_file *m, void *v)
> >  }
> >
> >  #ifdef CONFIG_NUMA
> > +static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
> > +                                                    int item)
> > +{
> > +       return lruvec_page_state(lruvec, item) * memcg_page_state_unit(item);
> > +}
> > +
> >  static int memory_numa_stat_show(struct seq_file *m, void *v)
> >  {
> >         int i;
> > @@ -6394,8 +6428,8 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
> >                         struct lruvec *lruvec;
> >
> >                         lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> > -                       size = lruvec_page_state(lruvec, memory_stats[i].idx);
> > -                       size *= memory_stats[i].ratio;
> > +                       size = lruvec_page_state_output(lruvec,
> > +                                                       memory_stats[i].idx);
> >                         seq_printf(m, " N%d=%llu", nid, size);
> >                 }
> >                 seq_putc(m, '\n');
> > --
> > 2.11.0
> >
> >



-- 
Yours,
Muchun
