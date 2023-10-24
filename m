Return-Path: <linux-fsdevel+bounces-1067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A957D52E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72276281A9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6C238DE9;
	Tue, 24 Oct 2023 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucFwQQs+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8637147
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:47:53 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A31FFE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a909b4e079so52564727b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155259; x=1698760059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MflihaSbuQmiTaEEI/kjjxwB9AeuC8B0gJ477WMkrk=;
        b=ucFwQQs+COKiOglcNfgXT8um79ZuAveCmtzV6U4Ex0cObEiNt1dT5ZFt43wmImjuk6
         pyMJhJimhXlpE9dk3pu2mE2O/wv1NVaalM2/5ohjB2YP88VqQPw5nzoYitKY8djpuVco
         fAzjEO6YrNG1i6Gc2aHQnpNFIQW1uTwxt4bblAP8ViybxSbvVXFNUAsDlf4oFU1xyW3D
         E73xzAaR33HRuU9u2ZAkSXeoaNIC8fIf5H1qGcu42VOrtqPYZvUlfVuBfLfAu8VFIxOE
         7rc79YpnyH3hWzYhuOuSvChx+Y6fwhT/QNdDdr0PBaDXkRivdWTfRJ2KkJDiRj+oDjLF
         qktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155259; x=1698760059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MflihaSbuQmiTaEEI/kjjxwB9AeuC8B0gJ477WMkrk=;
        b=KOqbk0kk+qP2YfIFPjKS6b+KQgouOkfjn9ipTcoPVsoMWD33LSpY3PzfI0EJveRnSw
         H18XHvAHN6DD/iLYZZoOBkoeoOyNcYPzaQgOoN13hfwpAz5rGpazAdIaVXhAXkHQQqCV
         6wOR8p5WRNApD0XDyUkds9EYIlmlFyRjDSo/WwSJcGbCC4l806i3L4+d3P7yYn54Sy/X
         C8AO1Hf/MYgbQZhjzN72B+72lRIkLyk0oIjQ/HsRzUbdj3tf0+oPXhd5X7KFQdSL+ZMr
         5uQW4+PXGbESwOuwVfWx/ktH/l2um8Rh9iTilrs1/aykAaSL7DUAA0npuOY2AAbcJtws
         yGPg==
X-Gm-Message-State: AOJu0YzmKmlbJKvK/ZI+vmHflvkJpTog+5QkLVGnLwv0yV6EsmRmrqGt
	kwlvdTber78e3n+GbJbRLk0r7vlNRkw=
X-Google-Smtp-Source: AGHT+IEn9RJ/YYka9nhFwipeWEC4kTkdUXBs4fb0JEteWf5skbl81x+dboQnU840QIKuLVpVMJxwXpn7baA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a5b:8c1:0:b0:da0:5452:29e4 with SMTP id
 w1-20020a5b08c1000000b00da0545229e4mr18077ybq.0.1698155259614; Tue, 24 Oct
 2023 06:47:39 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:23 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-27-surenb@google.com>
Subject: [PATCH v2 26/39] mempool: Hook up to memory allocation profiling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

This adds hooks to mempools for correctly annotating mempool-backed
allocations at the correct source line, so they show up correctly in
/sys/kernel/debug/allocations.

Various inline functions are converted to wrappers so that we can invoke
alloc_hooks() in fewer places.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mempool.h | 73 ++++++++++++++++++++---------------------
 mm/mempool.c            | 34 ++++++++-----------
 2 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 4aae6c06c5f2..9fa126aa19b5 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -5,6 +5,8 @@
 #ifndef _LINUX_MEMPOOL_H
 #define _LINUX_MEMPOOL_H
 
+#include <linux/sched.h>
+#include <linux/alloc_tag.h>
 #include <linux/wait.h>
 #include <linux/compiler.h>
 
@@ -39,18 +41,32 @@ void mempool_exit(mempool_t *pool);
 int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		      mempool_free_t *free_fn, void *pool_data,
 		      gfp_t gfp_mask, int node_id);
-int mempool_init(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
+
+int mempool_init_noprof(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		 mempool_free_t *free_fn, void *pool_data);
+#define mempool_init(...)						\
+	alloc_hooks(mempool_init_noprof(__VA_ARGS__))
 
 extern mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 			mempool_free_t *free_fn, void *pool_data);
-extern mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
+
+extern mempool_t *mempool_create_node_noprof(int min_nr, mempool_alloc_t *alloc_fn,
 			mempool_free_t *free_fn, void *pool_data,
 			gfp_t gfp_mask, int nid);
+#define mempool_create_node(...)					\
+	alloc_hooks(mempool_create_node_noprof(__VA_ARGS__))
+
+#define mempool_create(_min_nr, _alloc_fn, _free_fn, _pool_data)	\
+	mempool_create_node(_min_nr, _alloc_fn, _free_fn, _pool_data,	\
+			    GFP_KERNEL, NUMA_NO_NODE)
 
 extern int mempool_resize(mempool_t *pool, int new_min_nr);
 extern void mempool_destroy(mempool_t *pool);
-extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
+
+extern void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask) __malloc;
+#define mempool_alloc(...)						\
+	alloc_hooks(mempool_alloc_noprof(__VA_ARGS__))
+
 extern void mempool_free(void *element, mempool_t *pool);
 
 /*
@@ -61,19 +77,10 @@ extern void mempool_free(void *element, mempool_t *pool);
 void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data);
 void mempool_free_slab(void *element, void *pool_data);
 
-static inline int
-mempool_init_slab_pool(mempool_t *pool, int min_nr, struct kmem_cache *kc)
-{
-	return mempool_init(pool, min_nr, mempool_alloc_slab,
-			    mempool_free_slab, (void *) kc);
-}
-
-static inline mempool_t *
-mempool_create_slab_pool(int min_nr, struct kmem_cache *kc)
-{
-	return mempool_create(min_nr, mempool_alloc_slab, mempool_free_slab,
-			      (void *) kc);
-}
+#define mempool_init_slab_pool(_pool, _min_nr, _kc)			\
+	mempool_init(_pool, (_min_nr), mempool_alloc_slab, mempool_free_slab, (void *)(_kc))
+#define mempool_create_slab_pool(_min_nr, _kc)			\
+	mempool_create((_min_nr), mempool_alloc_slab, mempool_free_slab, (void *)(_kc))
 
 /*
  * a mempool_alloc_t and a mempool_free_t to kmalloc and kfree the
@@ -82,17 +89,12 @@ mempool_create_slab_pool(int min_nr, struct kmem_cache *kc)
 void *mempool_kmalloc(gfp_t gfp_mask, void *pool_data);
 void mempool_kfree(void *element, void *pool_data);
 
-static inline int mempool_init_kmalloc_pool(mempool_t *pool, int min_nr, size_t size)
-{
-	return mempool_init(pool, min_nr, mempool_kmalloc,
-			    mempool_kfree, (void *) size);
-}
-
-static inline mempool_t *mempool_create_kmalloc_pool(int min_nr, size_t size)
-{
-	return mempool_create(min_nr, mempool_kmalloc, mempool_kfree,
-			      (void *) size);
-}
+#define mempool_init_kmalloc_pool(_pool, _min_nr, _size)		\
+	mempool_init(_pool, (_min_nr), mempool_kmalloc, mempool_kfree,	\
+		     (void *)(unsigned long)(_size))
+#define mempool_create_kmalloc_pool(_min_nr, _size)			\
+	mempool_create((_min_nr), mempool_kmalloc, mempool_kfree,	\
+		       (void *)(unsigned long)(_size))
 
 /*
  * A mempool_alloc_t and mempool_free_t for a simple page allocator that
@@ -101,16 +103,11 @@ static inline mempool_t *mempool_create_kmalloc_pool(int min_nr, size_t size)
 void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data);
 void mempool_free_pages(void *element, void *pool_data);
 
-static inline int mempool_init_page_pool(mempool_t *pool, int min_nr, int order)
-{
-	return mempool_init(pool, min_nr, mempool_alloc_pages,
-			    mempool_free_pages, (void *)(long)order);
-}
-
-static inline mempool_t *mempool_create_page_pool(int min_nr, int order)
-{
-	return mempool_create(min_nr, mempool_alloc_pages, mempool_free_pages,
-			      (void *)(long)order);
-}
+#define mempool_init_page_pool(_pool, _min_nr, _order)			\
+	mempool_init(_pool, (_min_nr), mempool_alloc_pages,		\
+		     mempool_free_pages, (void *)(long)(_order))
+#define mempool_create_page_pool(_min_nr, _order)			\
+	mempool_create((_min_nr), mempool_alloc_pages,			\
+		       mempool_free_pages, (void *)(long)(_order))
 
 #endif /* _LINUX_MEMPOOL_H */
diff --git a/mm/mempool.c b/mm/mempool.c
index 734bcf5afbb7..4fd949178449 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -230,17 +230,17 @@ EXPORT_SYMBOL(mempool_init_node);
  *
  * Return: %0 on success, negative error code otherwise.
  */
-int mempool_init(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
-		 mempool_free_t *free_fn, void *pool_data)
+int mempool_init_noprof(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
+			mempool_free_t *free_fn, void *pool_data)
 {
 	return mempool_init_node(pool, min_nr, alloc_fn, free_fn,
 				 pool_data, GFP_KERNEL, NUMA_NO_NODE);
 
 }
-EXPORT_SYMBOL(mempool_init);
+EXPORT_SYMBOL(mempool_init_noprof);
 
 /**
- * mempool_create - create a memory pool
+ * mempool_create_node - create a memory pool
  * @min_nr:    the minimum number of elements guaranteed to be
  *             allocated for this pool.
  * @alloc_fn:  user-defined element-allocation function.
@@ -255,17 +255,9 @@ EXPORT_SYMBOL(mempool_init);
  *
  * Return: pointer to the created memory pool object or %NULL on error.
  */
-mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
-				mempool_free_t *free_fn, void *pool_data)
-{
-	return mempool_create_node(min_nr, alloc_fn, free_fn, pool_data,
-				   GFP_KERNEL, NUMA_NO_NODE);
-}
-EXPORT_SYMBOL(mempool_create);
-
-mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
-			       mempool_free_t *free_fn, void *pool_data,
-			       gfp_t gfp_mask, int node_id)
+mempool_t *mempool_create_node_noprof(int min_nr, mempool_alloc_t *alloc_fn,
+				      mempool_free_t *free_fn, void *pool_data,
+				      gfp_t gfp_mask, int node_id)
 {
 	mempool_t *pool;
 
@@ -281,7 +273,7 @@ mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
 
 	return pool;
 }
-EXPORT_SYMBOL(mempool_create_node);
+EXPORT_SYMBOL(mempool_create_node_noprof);
 
 /**
  * mempool_resize - resize an existing memory pool
@@ -377,7 +369,7 @@ EXPORT_SYMBOL(mempool_resize);
  *
  * Return: pointer to the allocated element or %NULL on error.
  */
-void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
+void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 {
 	void *element;
 	unsigned long flags;
@@ -444,7 +436,7 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 	finish_wait(&pool->wait, &wait);
 	goto repeat_alloc;
 }
-EXPORT_SYMBOL(mempool_alloc);
+EXPORT_SYMBOL(mempool_alloc_noprof);
 
 /**
  * mempool_free - return an element to the pool.
@@ -515,7 +507,7 @@ void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data)
 {
 	struct kmem_cache *mem = pool_data;
 	VM_BUG_ON(mem->ctor);
-	return kmem_cache_alloc(mem, gfp_mask);
+	return kmem_cache_alloc_noprof(mem, gfp_mask);
 }
 EXPORT_SYMBOL(mempool_alloc_slab);
 
@@ -533,7 +525,7 @@ EXPORT_SYMBOL(mempool_free_slab);
 void *mempool_kmalloc(gfp_t gfp_mask, void *pool_data)
 {
 	size_t size = (size_t)pool_data;
-	return kmalloc(size, gfp_mask);
+	return kmalloc_noprof(size, gfp_mask);
 }
 EXPORT_SYMBOL(mempool_kmalloc);
 
@@ -550,7 +542,7 @@ EXPORT_SYMBOL(mempool_kfree);
 void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data)
 {
 	int order = (int)(long)pool_data;
-	return alloc_pages(gfp_mask, order);
+	return alloc_pages_noprof(gfp_mask, order);
 }
 EXPORT_SYMBOL(mempool_alloc_pages);
 
-- 
2.42.0.758.gaed0368e0e-goog


