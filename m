Return-Path: <linux-fsdevel+bounces-1061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F7F7D52C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F9A1C20C69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB182C861;
	Tue, 24 Oct 2023 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d33QH23Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44CE2C864
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:47:42 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2251FC3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f61a639b9so61792557b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155250; x=1698760050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyxdpQkY+52gRKectHQ0ToMTqRIUgvQpNStJHRxgij8=;
        b=d33QH23Yxm3MKDKHMbVs+/7Z+ajwA+Z9Fr1B91dQxlrOqr63fJLQU7DEBzhHYSH2Ov
         AaNt+RSSZy0PBtl6ukVr46miJd/C3QxPg6KzHz6FYQ0JC9Qfqs0j5ltbOulOktxPQuTt
         nrh0+RZCaaTaMns6U/LId4/7YryoHX3kCwv6fzCqXIjIb3haHoaZQHpq83inLagixlot
         juRx33hDFTL7DaM3CBJGLy3/XBIWMBmzkiUuLDzDOLSOgOaaicm+7LO1y4akN/Xn0xLR
         rK6tW9VmtFp4JaMonEjaKCqp7zkeob3XuNvmSX2LXM1d3hnk0u1sxNKeMUrLdjMLWbB2
         bJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155250; x=1698760050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyxdpQkY+52gRKectHQ0ToMTqRIUgvQpNStJHRxgij8=;
        b=du/LM5CvyT1/Q7diC686VhNbo2XEhbpR1OUCHKNCuoSSGuEoti4HqY/o3GRQ8hq+vp
         GOIJbV83Mb/wkJxM4DOC3J4xM21sI/iWABmkKWT+DQxOnsTAuQhIy1tlH0RGnnOz/wrh
         2D4jPfECnOuTmxtZgDeXwctK1TL4DZvTI0yIXbxV3FCOHQCwOD2KmyFxGrCjygRk1Jh9
         7mm+hva/EcWLWkc9CpitaME4/dsGjAkDbpKE0x3Vau+3OOyD7gKFi5PygBYLkFHmd2f/
         XZgwA9ld/xRkSqlMO/xaPmIeBA2FAZOx1DxIQWTx65SZHVbFVwz82LDMq53AxkpTzWvc
         yrmg==
X-Gm-Message-State: AOJu0Yzeq6l0xcNqFZWYdH08aMz49TlOWAgFk7xZK0LieJCbKmpN5WA4
	zYO8mdiIj5Aq4vhG6LeyQqlxyEaRd+U=
X-Google-Smtp-Source: AGHT+IH6emT7vBUijCZAXTQg5qCnjqbhy63v478Fz+jbhTeMwMkT3/M97iqix7XYtIWpa3tPCFKbfUZWH1c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a0d:d84a:0:b0:5a8:5653:3323 with SMTP id
 a71-20020a0dd84a000000b005a856533323mr243310ywe.2.1698155250598; Tue, 24 Oct
 2023 06:47:30 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:19 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-23-surenb@google.com>
Subject: [PATCH v2 22/39] lib: add codetag reference into slabobj_ext
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

To store code tag for every slab object, a codetag reference is embedded
into slabobj_ext when CONFIG_MEM_ALLOC_PROFILING=y.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/memcontrol.h | 5 +++++
 lib/Kconfig.debug          | 1 +
 mm/slab.h                  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f3ede28b6fa6..853a24b5f713 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1613,7 +1613,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
  * if MEMCG_DATA_OBJEXTS is set.
  */
 struct slabobj_ext {
+#ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *objcg;
+#endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	union codetag_ref ref;
+#endif
 } __aligned(8);
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e1eda1450d68..482a6aae7664 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -973,6 +973,7 @@ config MEM_ALLOC_PROFILING
 	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
 	select PAGE_EXTENSION
+	select SLAB_OBJ_EXT
 	help
 	  Track allocation source code and record total allocation size
 	  initiated at that code location. The mechanism can be used to track
diff --git a/mm/slab.h b/mm/slab.h
index 60417fd262ea..293210ed10a9 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -457,6 +457,10 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 static inline bool need_slab_obj_ext(void)
 {
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	if (mem_alloc_profiling_enabled())
+		return true;
+#endif
 	/*
 	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
 	 * inside memcg_slab_post_alloc_hook. No other users for now.
-- 
2.42.0.758.gaed0368e0e-goog


