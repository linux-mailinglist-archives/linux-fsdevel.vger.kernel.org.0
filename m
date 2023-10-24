Return-Path: <linux-fsdevel+bounces-1062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB97D52CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931921C20CE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7367036B13;
	Tue, 24 Oct 2023 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xw8/uaWh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1834CF7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:47:44 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAEC19B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cad450d5fso5175150276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155253; x=1698760053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxcZ43bmgT/q64Ul96+yH7BdLzW8wJzWTibIuRMuFN0=;
        b=Xw8/uaWh99jt2xK+xyr1zz5Kog3gL8WpEHA8dZdPGys2OtC5Gg4NK91d9N0ir3H00c
         R2Dpet4fW7D7lwetzBo7Enb+ojL426Q9VupFcKmzMzdjYTpCev6wIhqDkN1j8CAZjMSj
         y+QI8uxm/F07lzVG7qdFCoty3+28RQ5/9y9OwEEPkqgc7J3IUmadDUEXrzeegxbEZtme
         M+/QDZ+86ie414B0L4rzjXLjtkfQGn7kdaQQSFU6OEvJycCa1KFpT797l09/Ib2ZHsHz
         tOrx2lot5IA7HEjgP1G4C043iIJ5YrELcPUr054LXB/3i1dAgt1AkE+Q2MnZWvHoGi4X
         IAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155253; x=1698760053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxcZ43bmgT/q64Ul96+yH7BdLzW8wJzWTibIuRMuFN0=;
        b=fS80ASaRz0+xps6HKP/RSaaJd0zP/dQcWddWeaxBwQ0DO8vx3mXaMfO6a6QGbLE0fg
         g6lpDvyPgSoaEDQXZSQuTCZenDj+LQGWtpfXN2qjGmF7DOfq0HdAf9zVcSJBzRhzTkCP
         +i4ugic8vL/DxMgkT288iuAPpJwAzjwBGZnBQRhk2ebpfENpmDmhuuseroSSOSjCJ2j5
         7Y8+KvrxriSIx1ec+tq5BqMC74CuOGKfBOAssRuYZfz7kgp3JFYwHXGb7niyD4ECyN+e
         K20tmWB0SY+OtdUU2Sf9NcZYUySKe/yO3DlTYM24T35XCgQn33wz0yvtDDc2zqSMUH8l
         8jfA==
X-Gm-Message-State: AOJu0Yya8HKwy98IfXLJu028Ws2MNiEy4GJpV/eliZlpxqiaHRUJ6udz
	yJnJUz5j08diKfTWBtF7CfXgQ84f5cw=
X-Google-Smtp-Source: AGHT+IHLiWJmtuPzRqvJDSScUKUh0y8YokFyWjfHx2rxdH2c6l653IiepUePcxPp47iOlZTgh6t0s/pZmOY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:d05:0:b0:d9a:5b63:a682 with SMTP id
 5-20020a250d05000000b00d9a5b63a682mr216305ybn.13.1698155252840; Tue, 24 Oct
 2023 06:47:32 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:20 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-24-surenb@google.com>
Subject: [PATCH v2 23/39] mm/slab: add allocation accounting into slab
 allocation and free paths
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

Account slab allocations using codetag reference embedded into slabobj_ext.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/slab_def.h |  2 +-
 include/linux/slub_def.h |  4 ++--
 mm/slab.c                |  4 +++-
 mm/slab.h                | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index a61e7d55d0d3..23f14dcb8d5b 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -107,7 +107,7 @@ static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *sla
  *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
  */
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct slab *slab, void *obj)
+					const struct slab *slab, const void *obj)
 {
 	u32 offset = (obj - slab->s_mem);
 	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index deb90cf4bffb..43fda4a5f23a 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -182,14 +182,14 @@ static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *sla
 
 /* Determine object index from a given position */
 static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
-					  void *addr, void *obj)
+					  void *addr, const void *obj)
 {
 	return reciprocal_divide(kasan_reset_tag(obj) - addr,
 				 cache->reciprocal_size);
 }
 
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct slab *slab, void *obj)
+					const struct slab *slab, const void *obj)
 {
 	if (is_kfence_address(obj))
 		return 0;
diff --git a/mm/slab.c b/mm/slab.c
index cefcb7499b6c..18923f5f05b5 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3348,9 +3348,11 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 					 unsigned long caller)
 {
+	struct slab *slab = virt_to_slab(objp);
 	bool init;
 
-	memcg_slab_free_hook(cachep, virt_to_slab(objp), &objp, 1);
+	memcg_slab_free_hook(cachep, slab, &objp, 1);
+	alloc_tagging_slab_free_hook(cachep, slab, &objp, 1);
 
 	if (is_kfence_address(objp)) {
 		kmemleak_free_recursive(objp, cachep->flags);
diff --git a/mm/slab.h b/mm/slab.h
index 293210ed10a9..4859ce1f8808 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -533,6 +533,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
+static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects)
+{
+	struct slabobj_ext *obj_exts;
+	int i;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return;
+
+	for (i = 0; i < objects; i++) {
+		unsigned int off = obj_to_index(s, slab, p[i]);
+
+		alloc_tag_sub(&obj_exts[off].ref, s->size);
+	}
+}
+
+#else
+
+static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
 #ifdef CONFIG_MEMCG_KMEM
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
@@ -827,6 +853,12 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 					 s->flags, flags);
 		kmsan_slab_alloc(s, p[i], flags);
 		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+		/* obj_exts can be allocated for other reasons */
+		if (likely(obj_exts) && mem_alloc_profiling_enabled())
+			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+#endif
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
-- 
2.42.0.758.gaed0368e0e-goog


