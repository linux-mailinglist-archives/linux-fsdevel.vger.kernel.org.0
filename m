Return-Path: <linux-fsdevel+bounces-375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B42B77C9DC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 05:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29411B20F26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 03:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCED154AF;
	Mon, 16 Oct 2023 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PWbmx9Yu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659B14F89
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 03:23:47 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C97FA
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5aaefc07e5cso1384655a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426615; x=1698031415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqxLSD3NSY9H2G/bHFoEqq0XRO6Fu01n0ZJ8sfPfXdw=;
        b=PWbmx9YuTWFcMGW/NMbyKnIWGT7N3bsKa9JcdoQIYmcFGMDqT0JvXqUu6YRG48FMQT
         ibe0yEPZ0WgTmMqOO5OBDhOP3YERdeMpsH90uYgBSCjSnbT2t51KBTML5XjTDZHQG8ly
         ZLllYNAaqrStKl/rJZ4C3sdROmXTTeR7WRzV83FuAsMAx6LbBDtr6txM4p/v4JFdvP6P
         0WaJFLZomueAfVemxBoCqcjXxhe4pSgwE7H62bU1L2p/aWr7+bU9LBBkOmrXvA/xHaP2
         FlWdVeUBz/2XggJbo5cBvIniXzTvyR47I3PO9uH80C+lZWX5Xj7EHqN/pYPZgJxWQCKu
         Rkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426615; x=1698031415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqxLSD3NSY9H2G/bHFoEqq0XRO6Fu01n0ZJ8sfPfXdw=;
        b=bKkhbvf7PewY2NqXHehqtZZ51Do/LUkvSPfI3VwCVCrUKarhupzY3ATRgMD4TSv7UH
         glSm25et8laGTlHPd6HLfBZ8zOkM01aOcy3Ogk4NTZVuhH3j//J0l+5M/U+I1tBOGZO+
         CR1Qi3LJiHr53XLmpyFxNhU6Jqk6s72jehO1eo4Sh02uJ5RuK6XgqD0aCo8aOEhvashl
         xdNmTG9pyhx9cP9cbTrnngVGwH5ofgvrK/lCZOJQD6XTcGClvwGd0NJgHPWGjsPjo05C
         ptJbTZ3UuJNdofqOiV6PKpqR9eywlrWZ6E8cccN+OxnUVVAnM0fhMyUV37Sv/qFrXA7D
         D4pQ==
X-Gm-Message-State: AOJu0Yyxt/NAiDNbvR0anR0ka5hTu1ynl5msVk2djBWXid3r0y/EmTLN
	eBWSPJD9qY+I5Sz+MBQDqmDJPQ==
X-Google-Smtp-Source: AGHT+IHmA+WtBu9NLQQzhIWS0nTFs0epfhl1qYL4Lf5DRNzLjrSSQh6nGRADfVlcdpst5WMiKPi/tw==
X-Received: by 2002:a17:90b:4fc2:b0:278:f907:719d with SMTP id qa2-20020a17090b4fc200b00278f907719dmr25042669pjb.48.1697426615383;
        Sun, 15 Oct 2023 20:23:35 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3452770pjz.52.2023.10.15.20.23.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Oct 2023 20:23:35 -0700 (PDT)
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
Subject: [PATCH v5 08/10] maple_tree: Update check_forking() and bench_forking()
Date: Mon, 16 Oct 2023 11:22:24 +0800
Message-Id: <20231016032226.59199-9-zhangpeng.00@bytedance.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Updated check_forking() and bench_forking() to use __mt_dup() to
duplicate maple tree.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c       | 117 ++++++++++++++++++------------------
 tools/include/linux/rwsem.h |   4 ++
 2 files changed, 62 insertions(+), 59 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index de470950714f..3e4597fb49d3 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1834,47 +1834,48 @@ static noinline void __init bench_mas_prev(struct maple_tree *mt)
 }
 #endif
 /* check_forking - simulate the kernel forking sequence with the tree. */
-static noinline void __init check_forking(struct maple_tree *mt)
+static noinline void __init check_forking(void)
 {
-
-	struct maple_tree newmt;
-	int i, nr_entries = 134;
+	struct maple_tree mt, newmt;
+	int i, nr_entries = 134, ret;
 	void *val;
-	MA_STATE(mas, mt, 0, 0);
-	MA_STATE(newmas, mt, 0, 0);
-	struct rw_semaphore newmt_lock;
+	MA_STATE(mas, &mt, 0, 0);
+	MA_STATE(newmas, &newmt, 0, 0);
+	struct rw_semaphore mt_lock, newmt_lock;
 
+	init_rwsem(&mt_lock);
 	init_rwsem(&newmt_lock);
 
-	for (i = 0; i <= nr_entries; i++)
-		mtree_store_range(mt, i*10, i*10 + 5,
-				  xa_mk_value(i), GFP_KERNEL);
+	mt_init_flags(&mt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
+	mt_set_external_lock(&mt, &mt_lock);
 
-	mt_set_non_kernel(99999);
 	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&newmt, &newmt_lock);
-	newmas.tree = &newmt;
-	mas_reset(&newmas);
-	mas_reset(&mas);
-	down_write(&newmt_lock);
-	mas.index = 0;
-	mas.last = 0;
-	if (mas_expected_entries(&newmas, nr_entries)) {
+
+	down_write(&mt_lock);
+	for (i = 0; i <= nr_entries; i++) {
+		mas_set_range(&mas, i*10, i*10 + 5);
+		mas_store_gfp(&mas, xa_mk_value(i), GFP_KERNEL);
+	}
+
+	down_write_nested(&newmt_lock, SINGLE_DEPTH_NESTING);
+	ret = __mt_dup(&mt, &newmt, GFP_KERNEL);
+	if (ret) {
 		pr_err("OOM!");
 		BUG_ON(1);
 	}
-	rcu_read_lock();
-	mas_for_each(&mas, val, ULONG_MAX) {
-		newmas.index = mas.index;
-		newmas.last = mas.last;
+
+	mas_set(&newmas, 0);
+	mas_for_each(&newmas, val, ULONG_MAX)
 		mas_store(&newmas, val);
-	}
-	rcu_read_unlock();
+
 	mas_destroy(&newmas);
+	mas_destroy(&mas);
 	mt_validate(&newmt);
-	mt_set_non_kernel(0);
 	__mt_destroy(&newmt);
+	__mt_destroy(&mt);
 	up_write(&newmt_lock);
+	up_write(&mt_lock);
 }
 
 static noinline void __init check_iteration(struct maple_tree *mt)
@@ -1977,49 +1978,51 @@ static noinline void __init check_mas_store_gfp(struct maple_tree *mt)
 }
 
 #if defined(BENCH_FORK)
-static noinline void __init bench_forking(struct maple_tree *mt)
+static noinline void __init bench_forking(void)
 {
-
-	struct maple_tree newmt;
-	int i, nr_entries = 134, nr_fork = 80000;
+	struct maple_tree mt, newmt;
+	int i, nr_entries = 134, nr_fork = 80000, ret;
 	void *val;
-	MA_STATE(mas, mt, 0, 0);
-	MA_STATE(newmas, mt, 0, 0);
-	struct rw_semaphore newmt_lock;
+	MA_STATE(mas, &mt, 0, 0);
+	MA_STATE(newmas, &newmt, 0, 0);
+	struct rw_semaphore mt_lock, newmt_lock;
 
+	init_rwsem(&mt_lock);
 	init_rwsem(&newmt_lock);
-	mt_set_external_lock(&newmt, &newmt_lock);
 
-	for (i = 0; i <= nr_entries; i++)
-		mtree_store_range(mt, i*10, i*10 + 5,
-				  xa_mk_value(i), GFP_KERNEL);
+	mt_init_flags(&mt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
+	mt_set_external_lock(&mt, &mt_lock);
+
+	down_write(&mt_lock);
+	for (i = 0; i <= nr_entries; i++) {
+		mas_set_range(&mas, i*10, i*10 + 5);
+		mas_store_gfp(&mas, xa_mk_value(i), GFP_KERNEL);
+	}
 
 	for (i = 0; i < nr_fork; i++) {
-		mt_set_non_kernel(99999);
-		mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
-		newmas.tree = &newmt;
-		mas_reset(&newmas);
-		mas_reset(&mas);
-		mas.index = 0;
-		mas.last = 0;
-		rcu_read_lock();
-		down_write(&newmt_lock);
-		if (mas_expected_entries(&newmas, nr_entries)) {
-			printk("OOM!");
+		mt_init_flags(&newmt,
+			      MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
+		mt_set_external_lock(&newmt, &newmt_lock);
+
+		down_write_nested(&newmt_lock, SINGLE_DEPTH_NESTING);
+		ret = __mt_dup(&mt, &newmt, GFP_KERNEL);
+		if (ret) {
+			pr_err("OOM!");
 			BUG_ON(1);
 		}
-		mas_for_each(&mas, val, ULONG_MAX) {
-			newmas.index = mas.index;
-			newmas.last = mas.last;
+
+		mas_set(&newmas, 0);
+		mas_for_each(&newmas, val, ULONG_MAX)
 			mas_store(&newmas, val);
-		}
+
 		mas_destroy(&newmas);
-		rcu_read_unlock();
 		mt_validate(&newmt);
-		mt_set_non_kernel(0);
 		__mt_destroy(&newmt);
 		up_write(&newmt_lock);
 	}
+	mas_destroy(&mas);
+	__mt_destroy(&mt);
+	up_write(&mt_lock);
 }
 #endif
 
@@ -3615,9 +3618,7 @@ static int __init maple_tree_seed(void)
 #endif
 #if defined(BENCH_FORK)
 #define BENCH
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	bench_forking(&tree);
-	mtree_destroy(&tree);
+	bench_forking();
 	goto skip;
 #endif
 #if defined(BENCH_MT_FOR_EACH)
@@ -3650,9 +3651,7 @@ static int __init maple_tree_seed(void)
 	check_iteration(&tree);
 	mtree_destroy(&tree);
 
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_forking(&tree);
-	mtree_destroy(&tree);
+	check_forking();
 
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_mas_store_gfp(&tree);
diff --git a/tools/include/linux/rwsem.h b/tools/include/linux/rwsem.h
index 83971b3cbfce..f8bffd4a987c 100644
--- a/tools/include/linux/rwsem.h
+++ b/tools/include/linux/rwsem.h
@@ -37,4 +37,8 @@ static inline int up_write(struct rw_semaphore *sem)
 {
 	return pthread_rwlock_unlock(&sem->lock);
 }
+
+#define down_read_nested(sem, subclass)		down_read(sem)
+#define down_write_nested(sem, subclass)	down_write(sem)
+
 #endif /* _TOOLS_RWSEM_H */
-- 
2.20.1


