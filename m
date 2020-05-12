Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18CB1CF41C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 14:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgELMSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729382AbgELMSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 08:18:10 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABAC05BD09
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 05:18:10 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id z9so4102560qvi.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NOIDf8+riiWlLuH1rf0st3ux5muRm+XJRCr0vDc2FGE=;
        b=lzxg0c/qP+R0N7iBfKn69OUvQI3hFlA9XTUov+HPlYbKr6cR0B8Bd9BzytU3PKATv7
         AtuCTV6DjTjNUeGTQa3aGw7u3CTsetXtPpHdQHWExALxC3LgKRCuuFCf33ZxfHKhDqp1
         MGZKpQqyp1t6IbPz5rUTFrhfQNJpCQOv8/1VBBeR9glwkOrBXkY51RkDGet1VDMaXs95
         ekpiiR8GtIgVCKLR1t4vDbAn/uo2fhvAESwcIWIxZAUow+x+1ubxllEV9j6Fhd8O8GaQ
         1SIij+rTM+/RVD7XSJBSbvKZNpZzr1PfdR7VMjt0obNaPhWwz1XeAlMEXD5uXOtZiymZ
         QK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NOIDf8+riiWlLuH1rf0st3ux5muRm+XJRCr0vDc2FGE=;
        b=iCray9Zyswd2V8/Z1S0DwHNeQgFIR3jmOtGLOlUxG0u6OCECf7hAJKUjkAPKE/QRW7
         ZiPBQNY367bh6Chcm+qLHYy3Xr6cEtpm8a1WIZKQkoIlFER0qJelBm2Izgv7m0GR4RCS
         +hZ128ig7vKOGwmue/QglZxljnXnvUUucofkKml4mwXE3SxiqVeRYbCjgyWEb+20HI56
         +jVORfAYqLpvb01D7aMASVJH0KOzyVyWxHydepoWOgzAGEewexZlhT5G+yiPtLykRYn1
         sLMM5wwUwnCoFBM8tdviORqGFB9tBHJhLfunSA+tadUQMq2ZutpzqrDfud0ThfjSDKWD
         pdtQ==
X-Gm-Message-State: AGi0PuYJQKpZ0MQlt1n8MJCm+ArtS9YsVKgt62rcaf3swAzOVFTbhzuF
        /vcQnHv6AsfqluOnbZWlcdUJ7g==
X-Google-Smtp-Source: APiQypLd52Soj0aVRstaY2BVD+/Hgra6Ac7QmUlLXUhi226+SqsYD0aWp0YXBdjgJokVo0CY1Fq0Ag==
X-Received: by 2002:a0c:ec8f:: with SMTP id u15mr20989782qvo.102.1589285889490;
        Tue, 12 May 2020 05:18:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id a1sm12059123qtj.65.2020.05.12.05.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 05:18:08 -0700 (PDT)
Date:   Tue, 12 May 2020 08:17:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-05-11-15-43 uploaded (mm/memcontrol.c, huge pages)
Message-ID: <20200512121750.GA397968@cmpxchg.org>
References: <20200511224430.HDJjRC68z%akpm@linux-foundation.org>
 <3b612c3e-ce52-ba92-eb02-0fa7fd38819f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b612c3e-ce52-ba92-eb02-0fa7fd38819f@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 09:41:24PM -0700, Randy Dunlap wrote:
> On 5/11/20 3:44 PM, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2020-05-11-15-43 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> > 
> > This tree is partially included in linux-next.  To see which patches are
> > included in linux-next, consult the `series' file.  Only the patches
> > within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> > linux-next.
> > 
> > 
> > A full copy of the full kernel tree with the linux-next and mmotm patches
> > already applied is available through git within an hour of the mmotm
> > release.  Individual mmotm releases are tagged.  The master branch always
> > points to the latest release, so it's constantly rebasing.
> > 
> > 	https://github.com/hnaz/linux-mm
> > 
> > The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> > contains daily snapshots of the -mm tree.  It is updated more frequently
> > than mmotm, and is untested.
> > 
> > A git copy of this tree is also available at
> > 
> > 	https://github.com/hnaz/linux-mm

Thanks for the report, Randy.

---

Randy reports:

> on x86_64:
> 
> In file included from ../arch/x86/include/asm/atomic.h:5:0,
>                  from ../include/linux/atomic.h:7,
>                  from ../include/linux/page_counter.h:5,
>                  from ../mm/memcontrol.c:25:
> ../mm/memcontrol.c: In function ‘memcg_stat_show’:
> ../include/linux/compiler.h:394:38: error: call to ‘__compiletime_assert_383’ declared with attribute error: BUILD_BUG failed
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ../include/linux/compiler.h:375:4: note: in definition of macro ‘__compiletime_assert’
>     prefix ## suffix();    \
>     ^~~~~~
> ../include/linux/compiler.h:394:2: note: in expansion of macro ‘_compiletime_assert’
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                      ^~~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>  #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })

The THP page size macros are CONFIG_TRANSPARENT_HUGEPAGE only.

We already ifdef most THP-related code in memcg, but not these
particular stats. Memcg used to track the pages as they came in, and
PageTransHuge() + hpage_nr_pages() work when THP is not compiled in.

Switching to native vmstat counters, memcg doesn't see the pages, it
only gets a count of THPs. To translate that to bytes, it has to know
how big the THPs are - and that's only available for CONFIG_THP.

Add the necessary ifdefs. /proc/meminfo, smaps etc. also don't show
the THP counters when the feature is compiled out. The event counts
(THP_FAULT_ALLOC, THP_COLLAPSE_ALLOC) were already conditional also.

Style touchup: HPAGE_PMD_NR * PAGE_SIZE is silly. Use HPAGE_PMD_SIZE.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 738d071ba1ef..47c685088a2c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1401,9 +1401,11 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		       (u64)memcg_page_state(memcg, NR_WRITEBACK) *
 		       PAGE_SIZE);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	seq_buf_printf(&s, "anon_thp %llu\n",
 		       (u64)memcg_page_state(memcg, NR_ANON_THPS) *
-		       HPAGE_PMD_NR * PAGE_SIZE);
+		       HPAGE_PMD_SIZE);
+#endif
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
 		seq_buf_printf(&s, "%s %llu\n", lru_list_name(i),
@@ -3752,7 +3754,9 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 static const unsigned int memcg1_stats[] = {
 	NR_FILE_PAGES,
 	NR_ANON_MAPPED,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	NR_ANON_THPS,
+#endif
 	NR_SHMEM,
 	NR_FILE_MAPPED,
 	NR_FILE_DIRTY,
@@ -3763,7 +3767,9 @@ static const unsigned int memcg1_stats[] = {
 static const char *const memcg1_stat_names[] = {
 	"cache",
 	"rss",
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	"rss_huge",
+#endif
 	"shmem",
 	"mapped_file",
 	"dirty",
@@ -3794,8 +3800,10 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 		if (memcg1_stats[i] == NR_ANON_THPS)
 			nr *= HPAGE_PMD_NR;
+#endif
 		seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
 	}
 
