Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC9436D518
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbhD1JzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 05:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbhD1JzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:55:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129DC06138C
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y22-20020a17090a8b16b0290150ae1a6d2bso8861744pjn.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rR+OvhVrb+QAHQ+jiVrkYgB4Dzl1YoXeDesY75cVJEI=;
        b=QvZJqE3ta2E/c3ZVQ+FxrxKL1VJJR+NIP4aPVZ3vheUWyux1jDovf//k/iN0z68sQ3
         ui2Zg4Owg7kHHJQnT+BuuFMMfwjIVtkab2zyIXz4WwGRigQA57PzG9HvF5d3kGm6kgPL
         ikcC3jjEBpbjZH8wnBtMWy158RctA+ANe6wb0kGi0s/bPMGhnu/yJ3nnbsP0Wzvcr3Ma
         yDMDnyyAPXKwlJJqCqCBanhk1okLxlS5l5OYz+QbIWLLn+h/6o+RIdFj9jQHbpxGZltj
         8hXbvNQpnhO8PG8FRAUqnqC3y15yMwipWjvJYNQQygKtYiUsSS6InGx4uvkhdT/6CAus
         eyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rR+OvhVrb+QAHQ+jiVrkYgB4Dzl1YoXeDesY75cVJEI=;
        b=QopTawAs5ndEq5ko2H5Kobq5E67xc8sr1ZgujiFr3OHT+uzGT0kjQziJO4vxrJ+CZc
         R57oOJFKzpaSkIGqF5cZTltFmy6vKs6tUUXlhuBntd72dJzaZgn6Se/uw8LmES17NAfs
         BrgaoZwCDZUlASCW4hfo4HuZbKwizVFu2UNRF2JnwLOKIxhoOxfyokPiS5ZGoRvNmOrW
         7PEhZiRY6KdK1sS4cw2af7pCDc8Q09VQoMhsD8YRXqWSqaoJ0r2VX/4soEvAntOYJGJT
         j9W8wGzhp254FUt1cSNLTa5e0YtJ9DLcRn+BPZfmeiSjCaBS+JWoIqD4KpsQE+uCCOp0
         J2cA==
X-Gm-Message-State: AOAM532dgZWYS8IUW32QYyiFd8qRJHWrnmwLiZwE6Cb+m268Pz02xIbb
        u1ILApRZnxL1yWT2bnFS2rmkng==
X-Google-Smtp-Source: ABdhPJx+BQwvCa+tWyaLztEOm3PIxKcql1j60oXvl+7x6kH9BoqBdjRVuQn6aVNZA3U5QJvl60B37w==
X-Received: by 2002:a17:90a:6c23:: with SMTP id x32mr18667949pjj.62.1619603666977;
        Wed, 28 Apr 2021 02:54:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.54.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:54:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 5/9] mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
Date:   Wed, 28 Apr 2021 17:49:45 +0800
Message-Id: <20210428094949.43579-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move memcg_online_kmem() to mem_cgroup_css_online() to simplify the
code. In this case, we can remove memcg_free_kmem().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9b9a5368a3e9..1610d501e7b5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3460,6 +3460,9 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (cgroup_memory_nokmem)
 		return 0;
 
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
 	BUG_ON(memcg->kmemcg_id >= 0);
 
 	memcg_id = memcg_alloc_cache_id();
@@ -3486,6 +3489,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	struct mem_cgroup *parent;
 	int kmemcg_id;
 
+	if (mem_cgroup_is_root(memcg))
+		return;
+
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
 		parent = root_mem_cgroup;
@@ -3499,14 +3505,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
-	memcg->kmemcg_id = -1;
-}
-
-static void memcg_free_kmem(struct mem_cgroup *memcg)
-{
-	/* css_alloc() failed, offlining didn't happen */
-	if (unlikely(memcg->kmemcg_id != -1))
-		memcg_offline_kmem(memcg);
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
@@ -3516,9 +3514,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 }
-static void memcg_free_kmem(struct mem_cgroup *memcg)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
@@ -5047,7 +5042,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
 	struct mem_cgroup *memcg, *old_memcg;
-	long error = -ENOMEM;
 
 	old_memcg = set_active_memcg(parent);
 	memcg = mem_cgroup_alloc();
@@ -5077,38 +5071,36 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	}
 
 	/* The following stuff does not apply to the root */
-	error = memcg_online_kmem(memcg);
-	if (error)
-		goto fail;
-
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_inc(&memcg_sockets_enabled_key);
 
 	return &memcg->css;
-fail:
-	mem_cgroup_id_remove(memcg);
-	mem_cgroup_free(memcg);
-	return ERR_PTR(error);
 }
 
 static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (memcg_online_kmem(memcg))
+		goto remove_id;
+
 	/*
 	 * A memcg must be visible for expand_shrinker_info()
 	 * by the time the maps are allocated. So, we allocate maps
 	 * here, when for_each_mem_cgroup() can't skip it.
 	 */
-	if (alloc_shrinker_info(memcg)) {
-		mem_cgroup_id_remove(memcg);
-		return -ENOMEM;
-	}
+	if (alloc_shrinker_info(memcg))
+		goto offline_kmem;
 
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
 	return 0;
+offline_kmem:
+	memcg_offline_kmem(memcg);
+remove_id:
+	mem_cgroup_id_remove(memcg);
+	return -ENOMEM;
 }
 
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
@@ -5166,7 +5158,6 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
-	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
 
-- 
2.11.0

