Return-Path: <linux-fsdevel+bounces-1284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C347D8D93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0943A2822C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 03:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E914424;
	Fri, 27 Oct 2023 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gUfK4XBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D094412
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 03:40:07 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D192A10EB
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:40:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-280109daaaaso31073a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698378001; x=1698982801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6aKxmDhD/mYQG3DiCaoAvSr06SUW/o1u/OdA/jXWcA=;
        b=gUfK4XBiyuJQsRUSzTCgJ0rAi8hoRbfnRRzYUwFee4JHd3gSxL0kB/r1+wHssEhVLP
         ckxEL67mWu+skIyfMy1P2zu0cu/vk6XEIehAJf8nGIm8oz4Yaoiz0N2B0PETE14nPMqV
         4Oh5EknwEM8DIdK0L88J7I4FkS+NvW6z4xiarDtpdtD9mXdEiE1uZScqz5Wf6jZOnBpv
         YBv7unUCdMfE5ZZrop7RhRORwG4tgaO4EBd0L3pClDInQ8VFcilPq8qY4iW5TW4s8SNG
         849ZWNu5EehxcR6dwqBVbTYTLi3LETOlRpnHK/pTmTXH9xx3+wrXv99vtyKdMPy4K170
         Kw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698378001; x=1698982801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6aKxmDhD/mYQG3DiCaoAvSr06SUW/o1u/OdA/jXWcA=;
        b=vLGZyv5iQEkQJfrXH6Gf6AkOwYaKNrdoJglQf+QMBE49kTqzCIJmy860gpKgGxqnV7
         ofxB1U3jHiHjmSCN8vYRThN9ScyVQQIMDz77wMUkrJ12UfmqZj5WdudkgtfXoiHGysQQ
         MLkt4wO26bfXOVo0qo6G97fha3MF75J406ArRsE3KAZSP7oy6vrzOooBkIOCGVXXSkli
         dEGFtI1KAz/uA3QnHoKPcJwxIDuwJLqTl+UJfqIpuxsPGxJFdTOIcXqVO7lKl1hjmCfd
         WAVXqDJkO7syZXMFkSUochdmi57zq5P62srbWCVql2JgRRJguK/YMuyR04dViZOpYcbp
         ehEg==
X-Gm-Message-State: AOJu0YwFkm1NTXVBQCQ5c5DcBQj6KEHfkQHHH9isMUFvGROSYNJXKRCR
	HzgeFkeS6KT6GA2/8eLGTTGLtg==
X-Google-Smtp-Source: AGHT+IH1injlMTgSGoHntNmgiaj1ZHobC4M78EJdUrrHo1lR+rYQIgDSUugUVcu6Xg6S9M0L5Xxffw==
X-Received: by 2002:a17:90b:1912:b0:27d:3be:8e13 with SMTP id mp18-20020a17090b191200b0027d03be8e13mr1371267pjb.12.1698378000792;
        Thu, 26 Oct 2023 20:40:00 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm2345676pjb.44.2023.10.26.20.39.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Oct 2023 20:40:00 -0700 (PDT)
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
Subject: [PATCH v7 08/10] maple_tree: Update check_forking() and bench_forking()
Date: Fri, 27 Oct 2023 11:38:43 +0800
Message-Id: <20231027033845.90608-9-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
References: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updated check_forking() and bench_forking() to use __mt_dup() to
duplicate maple tree.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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


