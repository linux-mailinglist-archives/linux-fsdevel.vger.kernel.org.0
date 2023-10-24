Return-Path: <linux-fsdevel+bounces-991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711C07D4A36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EE31C20BBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058D41862F;
	Tue, 24 Oct 2023 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BpaBI1sO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC9210FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:33:47 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072FD10D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd73395bceso3079550b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136423; x=1698741223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9a2wn71CT7l6jmeDgx5GiWCiAo5KcsAe/ofRJgEyKw=;
        b=BpaBI1sOF3Vg2KWjcsoFc4eim7j4goubh7vr5fO7yf2OFD6D9u1NMFfP02JsctFh3f
         RjrZj7xmjaiO8WKTinKenvS1pnIthT7wHbInAcO7wdsbdIhKDKeUIuW6Xnw7chgSF5c3
         XUut4DcoOKbHzPiTQ7ipTErqYzgTUULhl7DKqTNX3TM5umNYe8+F2J0Kz5ecZDYi2/Fb
         VJHfFf5fDFJv6327DGsR7BcKcTU6gvuJepgnJBqv6u6pGAdWDFmAhIcEyt3V61K4hrxZ
         6JtRRJW/9f9AoyfBktlOtv5y48UHGSVpAlB9XJ2pk4PkG2toX8WTfRP8De1y7EGYoXCE
         2/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136423; x=1698741223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9a2wn71CT7l6jmeDgx5GiWCiAo5KcsAe/ofRJgEyKw=;
        b=vYKgHBDmWmZP4Ibc7GOZxVvBQefLKnVl8QOhJh/6LNSY2OuxdJan/cLuLD65gBjPig
         SpOIrNNju3NhM+gql9sLanY7W/EyaUmtGT9r/fGFvXswQCmK+2P3ikqlV2FlySUSivK0
         1koLySIw97vDDHCSbuqy/uIgFEUZ1mX23wQDSlmtv/TDWo97OQxwPEnvVlHgj+efH1zZ
         dTKQ/0UuDpulZ9RpLWKnakUUhd9/8XHE7tRDOLJC07TRbSEQqLKyk7tJfe/6uUyLJXNJ
         Ftafuptk6E4ET5j0vh7/kejsmsYujqte93CuO4mABNb5AIL3q0sq64PHmBgUKmnJG1iA
         eTLw==
X-Gm-Message-State: AOJu0YwE9iLwErzxscPC3tizPD8T3EFBWf3jnSjnZZ5Xi318hnmTKah4
	C5144uOVbEaSg6wn6OdZ4LMl6A==
X-Google-Smtp-Source: AGHT+IFzRPxA82XWrAQS8Sn4M56zSVzHTehtJ70fiMLI3XrPkvHNR56M5baqh4DLBP8UwYKZghrJfA==
X-Received: by 2002:a05:6a00:10c5:b0:68f:b5a3:5ec6 with SMTP id d5-20020a056a0010c500b0068fb5a35ec6mr14426161pfu.0.1698136423347;
        Tue, 24 Oct 2023 01:33:43 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.33.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:33:43 -0700 (PDT)
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
Subject: [PATCH v6 05/10] maple_tree: Add test for mtree_dup()
Date: Tue, 24 Oct 2023 16:32:53 +0800
Message-Id: <20231024083258.65750-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test for mtree_dup().
Test by duplicating different maple trees and then comparing the two
trees. Includes tests for duplicating full trees and memory allocation
failures on different nodes.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 tools/testing/radix-tree/maple.c | 361 +++++++++++++++++++++++++++++++
 1 file changed, 361 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index e5da1cad70ba..12b3390e9591 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35857,6 +35857,363 @@ static noinline void __init check_locky(struct maple_tree *mt)
 	mt_clear_in_rcu(mt);
 }
 
+/*
+ * Compares two nodes except for the addresses stored in the nodes.
+ * Returns zero if they are the same, otherwise returns non-zero.
+ */
+static int __init compare_node(struct maple_enode *enode_a,
+			       struct maple_enode *enode_b)
+{
+	struct maple_node *node_a, *node_b;
+	struct maple_node a, b;
+	void **slots_a, **slots_b; /* Do not use the rcu tag. */
+	enum maple_type type;
+	int i;
+
+	if (((unsigned long)enode_a & MAPLE_NODE_MASK) !=
+	    ((unsigned long)enode_b & MAPLE_NODE_MASK)) {
+		pr_err("The lower 8 bits of enode are different.\n");
+		return -1;
+	}
+
+	type = mte_node_type(enode_a);
+	node_a = mte_to_node(enode_a);
+	node_b = mte_to_node(enode_b);
+	a = *node_a;
+	b = *node_b;
+
+	/* Do not compare addresses. */
+	if (ma_is_root(node_a) || ma_is_root(node_b)) {
+		a.parent = (struct maple_pnode *)((unsigned long)a.parent &
+						  MA_ROOT_PARENT);
+		b.parent = (struct maple_pnode *)((unsigned long)b.parent &
+						  MA_ROOT_PARENT);
+	} else {
+		a.parent = (struct maple_pnode *)((unsigned long)a.parent &
+						  MAPLE_NODE_MASK);
+		b.parent = (struct maple_pnode *)((unsigned long)b.parent &
+						  MAPLE_NODE_MASK);
+	}
+
+	if (a.parent != b.parent) {
+		pr_err("The lower 8 bits of parents are different. %p %p\n",
+			a.parent, b.parent);
+		return -1;
+	}
+
+	/*
+	 * If it is a leaf node, the slots do not contain the node address, and
+	 * no special processing of slots is required.
+	 */
+	if (ma_is_leaf(type))
+		goto cmp;
+
+	slots_a = ma_slots(&a, type);
+	slots_b = ma_slots(&b, type);
+
+	for (i = 0; i < mt_slots[type]; i++) {
+		if (!slots_a[i] && !slots_b[i])
+			break;
+
+		if (!slots_a[i] || !slots_b[i]) {
+			pr_err("The number of slots is different.\n");
+			return -1;
+		}
+
+		/* Do not compare addresses in slots. */
+		((unsigned long *)slots_a)[i] &= MAPLE_NODE_MASK;
+		((unsigned long *)slots_b)[i] &= MAPLE_NODE_MASK;
+	}
+
+cmp:
+	/*
+	 * Compare all contents of two nodes, including parent (except address),
+	 * slots (except address), pivots, gaps and metadata.
+	 */
+	return memcmp(&a, &b, sizeof(struct maple_node));
+}
+
+/*
+ * Compare two trees and return 0 if they are the same, non-zero otherwise.
+ */
+static int __init compare_tree(struct maple_tree *mt_a, struct maple_tree *mt_b)
+{
+	MA_STATE(mas_a, mt_a, 0, 0);
+	MA_STATE(mas_b, mt_b, 0, 0);
+
+	if (mt_a->ma_flags != mt_b->ma_flags) {
+		pr_err("The flags of the two trees are different.\n");
+		return -1;
+	}
+
+	mas_dfs_preorder(&mas_a);
+	mas_dfs_preorder(&mas_b);
+
+	if (mas_is_ptr(&mas_a) || mas_is_ptr(&mas_b)) {
+		if (!(mas_is_ptr(&mas_a) && mas_is_ptr(&mas_b))) {
+			pr_err("One is MAS_ROOT and the other is not.\n");
+			return -1;
+		}
+		return 0;
+	}
+
+	while (!mas_is_none(&mas_a) || !mas_is_none(&mas_b)) {
+
+		if (mas_is_none(&mas_a) || mas_is_none(&mas_b)) {
+			pr_err("One is MAS_NONE and the other is not.\n");
+			return -1;
+		}
+
+		if (mas_a.min != mas_b.min ||
+		    mas_a.max != mas_b.max) {
+			pr_err("mas->min, mas->max do not match.\n");
+			return -1;
+		}
+
+		if (compare_node(mas_a.node, mas_b.node)) {
+			pr_err("The contents of nodes %p and %p are different.\n",
+			       mas_a.node, mas_b.node);
+			mt_dump(mt_a, mt_dump_dec);
+			mt_dump(mt_b, mt_dump_dec);
+			return -1;
+		}
+
+		mas_dfs_preorder(&mas_a);
+		mas_dfs_preorder(&mas_b);
+	}
+
+	return 0;
+}
+
+static __init void mas_subtree_max_range(struct ma_state *mas)
+{
+	unsigned long limit = mas->max;
+	MA_STATE(newmas, mas->tree, 0, 0);
+	void *entry;
+
+	mas_for_each(mas, entry, limit) {
+		if (mas->last - mas->index >=
+		    newmas.last - newmas.index) {
+			newmas = *mas;
+		}
+	}
+
+	*mas = newmas;
+}
+
+/*
+ * build_full_tree() - Build a full tree.
+ * @mt: The tree to build.
+ * @flags: Use @flags to build the tree.
+ * @height: The height of the tree to build.
+ *
+ * Build a tree with full leaf nodes and internal nodes. Note that the height
+ * should not exceed 3, otherwise it will take a long time to build.
+ * Return: zero if the build is successful, non-zero if it fails.
+ */
+static __init int build_full_tree(struct maple_tree *mt, unsigned int flags,
+		int height)
+{
+	MA_STATE(mas, mt, 0, 0);
+	unsigned long step;
+	int ret = 0, cnt = 1;
+	enum maple_type type;
+
+	mt_init_flags(mt, flags);
+	mtree_insert_range(mt, 0, ULONG_MAX, xa_mk_value(5), GFP_KERNEL);
+
+	mtree_lock(mt);
+
+	while (1) {
+		mas_set(&mas, 0);
+		if (mt_height(mt) < height) {
+			mas.max = ULONG_MAX;
+			goto store;
+		}
+
+		while (1) {
+			mas_dfs_preorder(&mas);
+			if (mas_is_none(&mas))
+				goto unlock;
+
+			type = mte_node_type(mas.node);
+			if (mas_data_end(&mas) + 1 < mt_slots[type]) {
+				mas_set(&mas, mas.min);
+				goto store;
+			}
+		}
+store:
+		mas_subtree_max_range(&mas);
+		step = mas.last - mas.index;
+		if (step < 1) {
+			ret = -1;
+			goto unlock;
+		}
+
+		step /= 2;
+		mas.last = mas.index + step;
+		mas_store_gfp(&mas, xa_mk_value(5),
+				GFP_KERNEL);
+		++cnt;
+	}
+unlock:
+	mtree_unlock(mt);
+
+	MT_BUG_ON(mt, mt_height(mt) != height);
+	/* pr_info("height:%u number of elements:%d\n", mt_height(mt), cnt); */
+	return ret;
+}
+
+static noinline void __init check_mtree_dup(struct maple_tree *mt)
+{
+	DEFINE_MTREE(new);
+	int i, j, ret, count = 0;
+	unsigned int rand_seed = 17, rand;
+
+	/* store a value at [0, 0] */
+	mt_init_flags(mt, 0);
+	mtree_store_range(mt, 0, 0, xa_mk_value(0), GFP_KERNEL);
+	ret = mtree_dup(mt, &new, GFP_KERNEL);
+	MT_BUG_ON(&new, ret);
+	mt_validate(&new);
+	if (compare_tree(mt, &new))
+		MT_BUG_ON(&new, 1);
+
+	mtree_destroy(mt);
+	mtree_destroy(&new);
+
+	/* The two trees have different attributes. */
+	mt_init_flags(mt, 0);
+	mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+	ret = mtree_dup(mt, &new, GFP_KERNEL);
+	MT_BUG_ON(&new, ret != -EINVAL);
+	mtree_destroy(mt);
+	mtree_destroy(&new);
+
+	/* The new tree is not empty */
+	mt_init_flags(mt, 0);
+	mt_init_flags(&new, 0);
+	mtree_store(&new, 5, xa_mk_value(5), GFP_KERNEL);
+	ret = mtree_dup(mt, &new, GFP_KERNEL);
+	MT_BUG_ON(&new, ret != -EINVAL);
+	mtree_destroy(mt);
+	mtree_destroy(&new);
+
+	/* Test for duplicating full trees. */
+	for (i = 1; i <= 3; i++) {
+		ret = build_full_tree(mt, 0, i);
+		MT_BUG_ON(mt, ret);
+		mt_init_flags(&new, 0);
+
+		ret = mtree_dup(mt, &new, GFP_KERNEL);
+		MT_BUG_ON(&new, ret);
+		mt_validate(&new);
+		if (compare_tree(mt, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(mt);
+		mtree_destroy(&new);
+	}
+
+	for (i = 1; i <= 3; i++) {
+		ret = build_full_tree(mt, MT_FLAGS_ALLOC_RANGE, i);
+		MT_BUG_ON(mt, ret);
+		mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+
+		ret = mtree_dup(mt, &new, GFP_KERNEL);
+		MT_BUG_ON(&new, ret);
+		mt_validate(&new);
+		if (compare_tree(mt, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(mt);
+		mtree_destroy(&new);
+	}
+
+	/* Test for normal duplicating. */
+	for (i = 0; i < 1000; i += 3) {
+		if (i & 1) {
+			mt_init_flags(mt, 0);
+			mt_init_flags(&new, 0);
+		} else {
+			mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+		}
+
+		for (j = 0; j < i; j++) {
+			mtree_store_range(mt, j * 10, j * 10 + 5,
+					  xa_mk_value(j), GFP_KERNEL);
+		}
+
+		ret = mtree_dup(mt, &new, GFP_KERNEL);
+		MT_BUG_ON(&new, ret);
+		mt_validate(&new);
+		if (compare_tree(mt, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(mt);
+		mtree_destroy(&new);
+	}
+
+	/* Test memory allocation failed. */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i = 0; i < 30; i += 3) {
+		mtree_store_range(mt, j * 10, j * 10 + 5,
+					  xa_mk_value(j), GFP_KERNEL);
+	}
+
+	/* Failed at the first node. */
+	mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+	mt_set_non_kernel(0);
+	ret = mtree_dup(mt, &new, GFP_NOWAIT);
+	mt_set_non_kernel(0);
+	MT_BUG_ON(&new, ret != -ENOMEM);
+	mtree_destroy(mt);
+	mtree_destroy(&new);
+
+	/* Random maple tree fails at a random node. */
+	for (i = 0; i < 1000; i += 3) {
+		if (i & 1) {
+			mt_init_flags(mt, 0);
+			mt_init_flags(&new, 0);
+		} else {
+			mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
+		}
+
+		for (j = 0; j < i; j++) {
+			mtree_store_range(mt, j * 10, j * 10 + 5,
+					  xa_mk_value(j), GFP_KERNEL);
+		}
+		/*
+		 * The rand() library function is not used, so we can generate
+		 * the same random numbers on any platform.
+		 */
+		rand_seed = rand_seed * 1103515245 + 12345;
+		rand = rand_seed / 65536 % 128;
+		mt_set_non_kernel(rand);
+
+		ret = mtree_dup(mt, &new, GFP_NOWAIT);
+		mt_set_non_kernel(0);
+		if (ret != 0) {
+			MT_BUG_ON(&new, ret != -ENOMEM);
+			count++;
+			mtree_destroy(mt);
+			continue;
+		}
+
+		mt_validate(&new);
+		if (compare_tree(mt, &new))
+			MT_BUG_ON(&new, 1);
+
+		mtree_destroy(mt);
+		mtree_destroy(&new);
+	}
+
+	/* pr_info("mtree_dup() fail %d times\n", count); */
+	BUG_ON(!count);
+}
+
 extern void test_kmem_cache_bulk(void);
 
 void farmer_tests(void)
@@ -35904,6 +36261,10 @@ void farmer_tests(void)
 	check_null_expand(&tree);
 	mtree_destroy(&tree);
 
+	mt_init_flags(&tree, 0);
+	check_mtree_dup(&tree);
+	mtree_destroy(&tree);
+
 	/* RCU testing */
 	mt_init_flags(&tree, 0);
 	check_erase_testset(&tree);
-- 
2.20.1


