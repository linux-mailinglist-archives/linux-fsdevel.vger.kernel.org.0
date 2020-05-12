Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974171CFBD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 19:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgELRQ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 13:16:56 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:33365 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgELRQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 13:16:56 -0400
Received: by mail-oo1-f67.google.com with SMTP id b3so1180916oob.0;
        Tue, 12 May 2020 10:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zrV9Na5hegEtMEkEu1KEFc/uSwqOLQP7YJGf/jtNHQc=;
        b=hbVi0dlBG/Af5wmbiKFsEhCGPHSB+mnXUqoEKaOh06WyX46hhMTDkbOnnwa2ukvqHH
         BPqhAf/SSxeGWFHzCoAUmr01q4ssaKrXOn98LFuj0CXyUDysFyEgzi/MJp0jGe+W5nSL
         V1OMICH7EHwkp1vrqwelSEe3vS+IfQP385kMGRrm7AoQk8Xi3jSnrsFfYlHhbLyor8a9
         s5dcFLWkCtysHISkta9+17KFD9Zr9t4nuVsdIjinnoA3yxkWpbQzevGVOuuRKOaDmhUT
         hV99HQrQTU7LkPTuE35fi3aR6VMjqlWpVcJS2FbksV/e0x7k1B8HkOWISl6+ZWDq2Tf8
         ZidQ==
X-Gm-Message-State: AGi0PuaTr3nJTW5myctIFsZmydh8h6GOwAthtFDtK7beIyKwyHwX5b5G
        Nr0B2WhaFBJF9MA0UDGT7MIA3C2zmXyLxub0/wCoPw==
X-Google-Smtp-Source: APiQypJ90cuUdqwS9GCMEDW5toqUx3hGQCswz4bCNJ1HffyAlcgQWXh/NB2EC2pbtqykmvgZCLvi8ISszTO5rm0LxwI=
X-Received: by 2002:a4a:d44a:: with SMTP id p10mr19049986oos.11.1589303814627;
 Tue, 12 May 2020 10:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200511224430.HDJjRC68z%akpm@linux-foundation.org>
 <3b612c3e-ce52-ba92-eb02-0fa7fd38819f@infradead.org> <20200512121750.GA397968@cmpxchg.org>
In-Reply-To: <20200512121750.GA397968@cmpxchg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 May 2020 19:16:43 +0200
Message-ID: <CAMuHMdXquJ9321qJmZj8fyWrzc3u_-AbKFQD9SoZ-A=wsRyVww@mail.gmail.com>
Subject: Re: mmotm 2020-05-11-15-43 uploaded (mm/memcontrol.c, huge pages)
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Johannes,

On Tue, May 12, 2020 at 2:20 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> On Mon, May 11, 2020 at 09:41:24PM -0700, Randy Dunlap wrote:
> > On 5/11/20 3:44 PM, Andrew Morton wrote:
> > > The mm-of-the-moment snapshot 2020-05-11-15-43 has been uploaded to
> > >
> > >    http://www.ozlabs.org/~akpm/mmotm/
> > >
> > > mmotm-readme.txt says
> > >
> > > README for mm-of-the-moment:
> > >
> > > http://www.ozlabs.org/~akpm/mmotm/
> > >
> > > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > > more than once a week.
> > >
> > > You will need quilt to apply these patches to the latest Linus release (5.x
> > > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > > http://ozlabs.org/~akpm/mmotm/series
> > >
> > > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > > followed by the base kernel version against which this patch series is to
> > > be applied.
> > >
> > > This tree is partially included in linux-next.  To see which patches are
> > > included in linux-next, consult the `series' file.  Only the patches
> > > within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> > > linux-next.
> > >
> > >
> > > A full copy of the full kernel tree with the linux-next and mmotm patches
> > > already applied is available through git within an hour of the mmotm
> > > release.  Individual mmotm releases are tagged.  The master branch always
> > > points to the latest release, so it's constantly rebasing.
> > >
> > >     https://github.com/hnaz/linux-mm
> > >
> > > The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> > > contains daily snapshots of the -mm tree.  It is updated more frequently
> > > than mmotm, and is untested.
> > >
> > > A git copy of this tree is also available at
> > >
> > >     https://github.com/hnaz/linux-mm
>
> Thanks for the report, Randy.
>
> ---
>
> Randy reports:
>
> > on x86_64:
> >
> > In file included from ../arch/x86/include/asm/atomic.h:5:0,
> >                  from ../include/linux/atomic.h:7,
> >                  from ../include/linux/page_counter.h:5,
> >                  from ../mm/memcontrol.c:25:
> > ../mm/memcontrol.c: In function ‘memcg_stat_show’:
> > ../include/linux/compiler.h:394:38: error: call to ‘__compiletime_assert_383’ declared with attribute error: BUILD_BUG failed
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >                                       ^
> > ../include/linux/compiler.h:375:4: note: in definition of macro ‘__compiletime_assert’
> >     prefix ## suffix();    \
> >     ^~~~~~
> > ../include/linux/compiler.h:394:2: note: in expansion of macro ‘_compiletime_assert’
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >   ^~~~~~~~~~~~~~~~~~~
> > ../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
> >  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                      ^~~~~~~~~~~~~~~~~~
> > ../include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
> >  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >                      ^~~~~~~~~~~~~~~~
> > ../include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
> >  #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>
> The THP page size macros are CONFIG_TRANSPARENT_HUGEPAGE only.
>
> We already ifdef most THP-related code in memcg, but not these
> particular stats. Memcg used to track the pages as they came in, and
> PageTransHuge() + hpage_nr_pages() work when THP is not compiled in.
>
> Switching to native vmstat counters, memcg doesn't see the pages, it
> only gets a count of THPs. To translate that to bytes, it has to know
> how big the THPs are - and that's only available for CONFIG_THP.
>
> Add the necessary ifdefs. /proc/meminfo, smaps etc. also don't show
> the THP counters when the feature is compiled out. The event counts
> (THP_FAULT_ALLOC, THP_COLLAPSE_ALLOC) were already conditional also.
>
> Style touchup: HPAGE_PMD_NR * PAGE_SIZE is silly. Use HPAGE_PMD_SIZE.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 738d071ba1ef..47c685088a2c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1401,9 +1401,11 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>                        (u64)memcg_page_state(memcg, NR_WRITEBACK) *
>                        PAGE_SIZE);
>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         seq_buf_printf(&s, "anon_thp %llu\n",
>                        (u64)memcg_page_state(memcg, NR_ANON_THPS) *
> -                      HPAGE_PMD_NR * PAGE_SIZE);
> +                      HPAGE_PMD_SIZE);
> +#endif
>
>         for (i = 0; i < NR_LRU_LISTS; i++)
>                 seq_buf_printf(&s, "%s %llu\n", lru_list_name(i),
> @@ -3752,7 +3754,9 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  static const unsigned int memcg1_stats[] = {
>         NR_FILE_PAGES,
>         NR_ANON_MAPPED,
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         NR_ANON_THPS,
> +#endif
>         NR_SHMEM,
>         NR_FILE_MAPPED,
>         NR_FILE_DIRTY,
> @@ -3763,7 +3767,9 @@ static const unsigned int memcg1_stats[] = {
>  static const char *const memcg1_stat_names[] = {
>         "cache",
>         "rss",
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         "rss_huge",
> +#endif
>         "shmem",
>         "mapped_file",
>         "dirty",
> @@ -3794,8 +3800,10 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>                 if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
>                         continue;
>                 nr = memcg_page_state_local(memcg, memcg1_stats[i]);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>                 if (memcg1_stats[i] == NR_ANON_THPS)
>                         nr *= HPAGE_PMD_NR;
> +#endif
>                 seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
>         }

Fixes the build issue with m68k/allmodconfig, too.
Not boot-tested.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
