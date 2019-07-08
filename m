Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94966286D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfGHSi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 14:38:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34887 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfGHSi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:38:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so19094642qto.2;
        Mon, 08 Jul 2019 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3lVu/iKD/K+MkjqEazvwur7I01jMg1dkzaZer2S9oA=;
        b=YfLFUrl+20e4r98mXvMBY+vubLWsf8qJEBjalOL+ZNXGcDJ8h6mD0JYgGd2qtlWy9R
         KjOBwepDq37okiS+qjuYomP8An36emcMIcuLAkDo3hy5tXg1uKH7R1uc66K3pjIJbbag
         tfrYWS7Wqx33+mYX9dd1Yx7385QxPTehGonBm+4IVYjtX9ulp468eIYUMTuMGZGut+mU
         vP+FeUzUYIE5ZMcnPXjoSpW/tBhQbcmlCjRhMOazoqZQlSj45dSl0tJDvs4N7w7dS3wL
         5XGrvlG5lQZwPf1npJjwIwwuASX4IF045nkLCzB2SPh6VBG+NA9ZIrZSwqAZ0UaIKXqc
         1trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3lVu/iKD/K+MkjqEazvwur7I01jMg1dkzaZer2S9oA=;
        b=URCAXTENyWZ132NSIpU8G9AfeWIGcUhUBkc+f6wbKCz8pn2A/hh2QBuhgRezmxFYhe
         Y66P0pOZfDIEfqe0IBSZaAg4zfOnN1OAtciF4lPK4jOz3BiC/SDKwSCxlmTAdPF7fIP8
         oM7Thl7ZPEfTa/uoqH8HnjjyZuB3enIzcjgaEvcGdlt0x3Ph9VJrT9WeIySipXbZXxFY
         D+akA5s8hIs0Bmw+2AxgqCF5jVACNez8/ac4UISyfhhunfZl91/tPiUjzNpCknqrOnpG
         qgwRn0IxqyfQHM/x7Tao2EHAbl2zgdfnDgFl6/LE8xVIm6523yo08meh/XGQozBWAXzk
         9T1w==
X-Gm-Message-State: APjAAAVte8LUO0+3g4vtdMrRdusLGrqEiaNAznOiCJFBPlegEn6gJdxq
        J1tAfaebVJntHhtT1VaHLO6mS4aqJcMOcFWr+hU=
X-Google-Smtp-Source: APXvYqxQ+GsKisl7JGXz4BZrXRf7Ul/53FWI6HeLxHv3uBB453gcAzlClCptgbI9Oj1fEazcQKom0gai0+TLra1rvZ0=
X-Received: by 2002:a05:6214:1447:: with SMTP id b7mr12745932qvy.89.1562611107655;
 Mon, 08 Jul 2019 11:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190707050058.CO3VsTl8T%akpm@linux-foundation.org> <CAK8P3a2KVPsX-3VZdVXAa1yAJDevMwQ9VQdx5j8tyMDydb76FQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2KVPsX-3VZdVXAa1yAJDevMwQ9VQdx5j8tyMDydb76FQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Jul 2019 11:38:11 -0700
Message-ID: <CAHbLzkr8h0t+2xs6f7htKZFdKDbsD5F4z-AAt+CDa-uVwSkQ1Q@mail.gmail.com>
Subject: Re: mmotm 2019-07-06-22-00 uploaded
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, rdunlap@infradead.org,
        Yang Shi <yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 8, 2019 at 7:29 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Jul 7, 2019 at 7:05 AM <akpm@linux-foundation.org> wrote:
>
> > * mm-move-mem_cgroup_uncharge-out-of-__page_cache_release.patch
> > * mm-shrinker-make-shrinker-not-depend-on-memcg-kmem.patch
> > * mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-fix.patch
> > * mm-thp-make-deferred-split-shrinker-memcg-aware.patch
>
> mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-fix.patch fixes
> the compile-time error when memcg_expand_shrinker_maps() is not
> declared, but now we get a linker error instead because the
> function is still not built into the kernel:
>
> mm/vmscan.o: In function `prealloc_shrinker':
> vmscan.c:(.text+0x328): undefined reference to `memcg_expand_shrinker_maps'

Sorry for chiming in late, I just came back from vacation.

The below patch should fix the issue, which is for linux-next
2019-07-08 on top of Andrew's fix. And, this patch fixed the redundant
#ifdef CONFIG_MEMCG problem pointed out by Randy. Copied Randy too.

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b7a1f98..5c4b15eb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -128,9 +128,8 @@ struct mem_cgroup_per_node {

        struct mem_cgroup_reclaim_iter  iter[DEF_PRIORITY + 1];

-#ifdef CONFIG_MEMCG
        struct memcg_shrinker_map __rcu *shrinker_map;
-#endif
+
        struct rb_node          tree_node;      /* RB tree node */
        unsigned long           usage_in_excess;/* Set to the value by which */
                                                /* the soft limit is exceeded*/
@@ -1296,6 +1295,8 @@ static inline bool
mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
 void memcg_kmem_put_cache(struct kmem_cache *cachep);
 extern int memcg_expand_shrinker_maps(int new_id);
+extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+                                  int nid, int shrinker_id);

 #ifdef CONFIG_MEMCG_KMEM
 int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
@@ -1363,8 +1364,6 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
        return memcg ? memcg->kmemcg_id : -1;
 }

-extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
-                                  int nid, int shrinker_id);
 #else

 static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
@@ -1405,9 +1404,6 @@ static inline void memcg_get_cache_ids(void)
 static inline void memcg_put_cache_ids(void)
 {
 }
-
-static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
-                                         int nid, int shrinker_id) { }
 #endif /* CONFIG_MEMCG_KMEM */

 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2ce3bda..dca063b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -313,6 +313,7 @@ void memcg_put_cache_ids(void)
 EXPORT_SYMBOL(memcg_kmem_enabled_key);

 struct workqueue_struct *memcg_kmem_cache_wq;
+#endif

 static int memcg_shrinker_map_size;
 static DEFINE_MUTEX(memcg_shrinker_map_mutex);
@@ -436,14 +437,6 @@ void memcg_set_shrinker_bit(struct mem_cgroup
*memcg, int nid, int shrinker_id)
        }
 }

-#else /* CONFIG_MEMCG_KMEM */
-static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
-{
-       return 0;
-}
-static void memcg_free_shrinker_maps(struct mem_cgroup *memcg) { }
-#endif /* CONFIG_MEMCG_KMEM */
-
 /**
  * mem_cgroup_css_from_page - css of the memcg associated with a page
  * @page: page of interest
>
>       Arnd
>
