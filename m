Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5561CF960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgELPha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730818AbgELPh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 11:37:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF740C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 08:37:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d21so6483183ljg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3mfWUpC6bH/0PPzXG5Sq3RBRbSppz1EWcuNQTMG4no=;
        b=OtmcAawdVwZKG0M4kx0M+jrAJrJ1G8XEe6FS6/gIpKW8YlvvcI+MbEI73prV/Re8NB
         kfVrqKnsXX/z8j2S9JCcSMF+x9IrlFuT/dRhsCYoWSO9brOKkkel3EoQT9HVHNkOAFZR
         u3SK7kTeFtpAVEIs+r01cEzhEPtSvAoIMgaPmloMPyD3Sr3wevwmfBffVsZkDrv0tiew
         Ej6+/AVE05h8zDM0MwzyKbGmq6f9TF8ftwLcPe3t24NEOU0sxN5kl8ufSEKoc3N4xNzD
         S9oXqMeVmjGsNSGA3d2JW1HsaLgJyKm6mEFB19vsJrI2yzuz6Ih6kU4pvoADlSdXFnaV
         +paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3mfWUpC6bH/0PPzXG5Sq3RBRbSppz1EWcuNQTMG4no=;
        b=UWq1I8LOGHJfYfi1yeZjT4wHmPGPv3vNOlp/niGOQn+in59Q/ig5VB3b75GwsSXOKc
         eftp6Hmuh1ZvHDc7kBio60WtLakSsZJ7dS7Q2TyBtvv0NVcD83ey1cwtBvKM6TirQskn
         sybVGeHc9shDpy4H/EWH7oYjzxSZKKK1xJqRa2ICnPAPZHVUGzMBLeWHOrfpxOK22feD
         GTGe5EAKCPmicKJb/Iwdb4PD8qwgofnh8YbrbT4pvOU1mzuVQf2sPIevMZ/YMQAzSzjj
         y4hLYQsJn5e5JlU4HvshFNoOLFvdxY3QVZnKmaEEHlxfS8b18Tza0uTLSi/grGJdWxZB
         S+Kg==
X-Gm-Message-State: AOAM5302B9aQXLW+oRa7OKSPwpDSlStnjx6Kvgng4aNO6JTgng3/mbvu
        baJ596esyzEn79F6rvS0UQnPzzNPNXYi+zYnXK+bUA==
X-Google-Smtp-Source: ABdhPJzSzvPBzHJJyhmdNxeCDNn0RGhxwM4L9OsASaWkxZEseTcQrITCOOAq3lvC6NY1FGK3OODa4SHdRTxY9uynbbg=
X-Received: by 2002:a2e:9455:: with SMTP id o21mr14273685ljh.245.1589297847090;
 Tue, 12 May 2020 08:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200511224430.HDJjRC68z%akpm@linux-foundation.org>
 <3b612c3e-ce52-ba92-eb02-0fa7fd38819f@infradead.org> <20200512121750.GA397968@cmpxchg.org>
In-Reply-To: <20200512121750.GA397968@cmpxchg.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 May 2020 21:07:15 +0530
Message-ID: <CA+G9fYvZ1SFX1b7+3_X9L+snPxV_zGHykuDD96Me+gM++BYTBg@mail.gmail.com>
Subject: Re: mmotm 2020-05-11-15-43 uploaded (mm/memcontrol.c, huge pages)
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Build tested and build pass on x86_64.

>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

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
>


-- 
Linaro LKFT
https://lkft.linaro.org
