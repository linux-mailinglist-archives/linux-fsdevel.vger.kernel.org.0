Return-Path: <linux-fsdevel+bounces-371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB217C9DBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 05:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111FB1C208D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 03:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF08BE6;
	Mon, 16 Oct 2023 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i7jsGdw0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1658495
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 03:23:10 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFB0EA
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so1743221b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426588; x=1698031388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXZWHgZHrQ6fRhi1dWH8Hwu+H4KBhNEo2ODkb4cUdHA=;
        b=i7jsGdw0ITgbB+sXok0kbvMVrmxqxWdLOsPKKGXRS7ZV+Ib32o4zDlQNIYOlzoCgF1
         yE2Ajf9i0s+IDxGRVfs4J/vlG95B3IvV0ZCBvsUOIGdG+YKLo3SVkcMrESaxUZE/FbeT
         4T8s04fybllvgRqqMnojQbfs/gEM0PY6ku0LwMpCrMXt2StGilC1J+qJxapzyt5/99kl
         EVmVLty5j4Bz/BH8HIwj60ApI0i6bJrsIy2ysfh7mOgMO7Lb1HmbBjcn+PyrYhTfoo+d
         DG/8RbemO3WNH+ectz5QHapeEy8QplLnpv331f0XaHl7CvQvAbgBsOoJwiabiFdNwA7q
         A0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426588; x=1698031388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXZWHgZHrQ6fRhi1dWH8Hwu+H4KBhNEo2ODkb4cUdHA=;
        b=YPRwH2O9t7LjrHkUmkKPOSWBoK4yLskfEOANFGF6yjhepuYp9i1Wvy56RDLnRyKS1t
         fmUOaMY5oLM2HOxI9j66R8/6vfnrJEWNkNN6FREtIhHmJKaV246D+byQOaR5CyPSXNcr
         d9SF+bN9IlHjsXm/9FCEj3WAlH752byeQPmVdQ7IeeTWKL36B+nNQgfMZYdjiz/f4b4h
         saJNO5xTyGl7RKQwSelKgQJnM3AyhSrxnD47rDPHSOH5EgvHdmBnw1iXSXUYn9SMyznD
         9ZkJ3mey5ayf69zo5v1686ht6wUrvK+sWlr2JEnuhVJIAi8J0xGvLjIJObxUAj7Hy22b
         pQlw==
X-Gm-Message-State: AOJu0YxD0jNp7A2BMUa+7YOrWobwO0lUzlPSHeaUMm6efSFvouwrrUfh
	4CunCg05t6OL9OuTz8qUHNtzXw==
X-Google-Smtp-Source: AGHT+IHJ/d4Imcp6odYT1h7aWQHUYbM1ac42oVm99u/t154/4XdiI3P2y5GHneaRUB847sqBMYQ7vA==
X-Received: by 2002:a05:6a21:7784:b0:173:318:b1ec with SMTP id bd4-20020a056a21778400b001730318b1ecmr12877225pzc.35.1697426588170;
        Sun, 15 Oct 2023 20:23:08 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3452770pjz.52.2023.10.15.20.23.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Oct 2023 20:23:08 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: Liam.Howlett@oracle.com,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	willy@infradead.org,
	brauner@kernel.org,
	surenb@google.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	oliver.sang@intel.com,
	mst@redhat.com
Cc: zhangpeng.00@bytedance.com,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 04/10] radix tree test suite: Align kmem_cache_alloc_bulk() with kernel behavior.
Date: Mon, 16 Oct 2023 11:22:20 +0800
Message-Id: <20231016032226.59199-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When kmem_cache_alloc_bulk() fails to allocate, leave the freed pointers
in the array. This enables a more accurate simulation of the kernel's
behavior and allows for testing potential double-free scenarios.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 tools/testing/radix-tree/linux.c | 45 +++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index 61fe2601cb3a..4eb442206d01 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -93,13 +93,9 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 	return p;
 }
 
-void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
+void __kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 {
 	assert(objp);
-	uatomic_dec(&nr_allocated);
-	uatomic_dec(&cachep->nr_allocated);
-	if (kmalloc_verbose)
-		printf("Freeing %p to slab\n", objp);
 	if (cachep->nr_objs > 10 || cachep->align) {
 		memset(objp, POISON_FREE, cachep->size);
 		free(objp);
@@ -111,6 +107,15 @@ void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 	}
 }
 
+void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
+{
+	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
+	if (kmalloc_verbose)
+		printf("Freeing %p to slab\n", objp);
+	__kmem_cache_free_locked(cachep, objp);
+}
+
 void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 {
 	pthread_mutex_lock(&cachep->lock);
@@ -141,18 +146,17 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 	if (kmalloc_verbose)
 		pr_debug("Bulk alloc %lu\n", size);
 
-	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
-		if (cachep->non_kernel < size)
-			return 0;
-
-		cachep->non_kernel -= size;
-	}
-
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs >= size) {
 		struct radix_tree_node *node;
 
 		for (i = 0; i < size; i++) {
+			if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+				if (!cachep->non_kernel)
+					break;
+				cachep->non_kernel--;
+			}
+
 			node = cachep->objs;
 			cachep->nr_objs--;
 			cachep->objs = node->parent;
@@ -163,11 +167,19 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 	} else {
 		pthread_mutex_unlock(&cachep->lock);
 		for (i = 0; i < size; i++) {
+			if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+				if (!cachep->non_kernel)
+					break;
+				cachep->non_kernel--;
+			}
+
 			if (cachep->align) {
 				posix_memalign(&p[i], cachep->align,
 					       cachep->size);
 			} else {
 				p[i] = malloc(cachep->size);
+				if (!p[i])
+					break;
 			}
 			if (cachep->ctor)
 				cachep->ctor(p[i]);
@@ -176,6 +188,15 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 		}
 	}
 
+	if (i < size) {
+		size = i;
+		pthread_mutex_lock(&cachep->lock);
+		for (i = 0; i < size; i++)
+			__kmem_cache_free_locked(cachep, p[i]);
+		pthread_mutex_unlock(&cachep->lock);
+		return 0;
+	}
+
 	for (i = 0; i < size; i++) {
 		uatomic_inc(&nr_allocated);
 		uatomic_inc(&cachep->nr_allocated);
-- 
2.20.1


