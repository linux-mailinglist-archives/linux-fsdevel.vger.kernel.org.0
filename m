Return-Path: <linux-fsdevel+bounces-370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7507C9DBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 05:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F166DB20DA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 03:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC571847C;
	Mon, 16 Oct 2023 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wjvmw20A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC58473
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 03:23:04 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AEFE6
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:02 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-578b4981526so2263949a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426582; x=1698031382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/sF1y4M8+5TE0GCNNK3GGgEnktBWwP9VwP8zP44L9Y=;
        b=Wjvmw20A0vzoI9yy3cXL1/qhTvtoyXEg8kP58mGYKExPejxPwqPtE+22xC0kc66kre
         koYDfV71yjtc37b/XaAy7QXbQ2sJAiKx9/vkzf6zcRuxT3R6Tsas55XYHEHsk/BirbA/
         Hd8CSp24le7lAgBZBmNuGcuBA5jPhrsEZkWJjDj/YQo0T1BQ+rz7iAEVaSvZYAVBynaQ
         7uLKLMBXJ1phjCXKrEJYdyti8GsFjwKjEEexxIm5UMycxMYStd8xKqgZrsh6BIXzNauZ
         ZaECUHPyUprV/IN175cHee4mMu6YZ0ynigkuzVpfmT3GyjOISDHL1ySURf1K0h1gf3Ak
         Rwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426582; x=1698031382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/sF1y4M8+5TE0GCNNK3GGgEnktBWwP9VwP8zP44L9Y=;
        b=nlSPm3PAr7fFxr5kapM1GddrFXTE13bOxgDju4YUndpR/aqTVjuiQmU4dzMFpwBCKj
         2lpqLMA1e+wBfGoPb3dW/0lPIEP77shG8PCbO1sNnswfSziIJfOcMKL6jPdIiW3nNE5Y
         Gd5aZynuDzL+8LmjvwyrRWR4JVgneDIMvbgyxg1TuGgCmE5JD8vOFAylMAVfHTP5zVjf
         YT1mrreA6Dy0rAG3ptScnXkYdh7/l6+cT7x57221FrCCVhgwDcPmIgJqyofhO22GKTyV
         2WuUCDS0jluKp13tUEK9I7PSbbfFx8I/kj10EX0KxhOFKIuxx9VBIg8LmbKv7qYzibIK
         9VnA==
X-Gm-Message-State: AOJu0YzYKF3tHWaGIpVBgqDo8zTDGG/ZyQDCzOqtX8SU5B7hSLZzg2qi
	Z9eundpKecI84pZyovDTHseUYw==
X-Google-Smtp-Source: AGHT+IGNszmmv6OXzfGiuGTzwsi3NCAXv1mbwF37K+8hIyYvm0XADpPiEGL9AP+98FGCJGisbDNSWQ==
X-Received: by 2002:a05:6a20:7f9a:b0:140:a25:1c1d with SMTP id d26-20020a056a207f9a00b001400a251c1dmr36624545pzj.51.1697426581541;
        Sun, 15 Oct 2023 20:23:01 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3452770pjz.52.2023.10.15.20.22.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Oct 2023 20:23:01 -0700 (PDT)
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
Subject: [PATCH v5 03/10] maple_tree: Introduce interfaces __mt_dup() and mtree_dup()
Date: Mon, 16 Oct 2023 11:22:19 +0800
Message-Id: <20231016032226.59199-4-zhangpeng.00@bytedance.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce interfaces __mt_dup() and mtree_dup(), which are used to
duplicate a maple tree. They duplicate a maple tree in Depth-First
Search (DFS) pre-order traversal. It uses memcopy() to copy nodes in the
source tree and allocate new child nodes in non-leaf nodes. The new node
is exactly the same as the source node except for all the addresses
stored in it. It will be faster than traversing all elements in the
source tree and inserting them one by one into the new tree. The time
complexity of these two functions is O(n).

The difference between __mt_dup() and mtree_dup() is that mtree_dup()
handles locks internally.

Analysis of the average time complexity of this algorithm:

For simplicity, let's assume that the maximum branching factor of all
non-leaf nodes is 16 (in allocation mode, it is 10), and the tree is a
full tree.

Under the given conditions, if there is a maple tree with n elements,
the number of its leaves is n/16. From bottom to top, the number of
nodes in each level is 1/16 of the number of nodes in the level below.
So the total number of nodes in the entire tree is given by the sum of
n/16 + n/16^2 + n/16^3 + ... + 1. This is a geometric series, and it has
log(n) terms with base 16. According to the formula for the sum of a
geometric series, the sum of this series can be calculated as (n-1)/15.
Each node has only one parent node pointer, which can be considered as
an edge. In total, there are (n-1)/15-1 edges.

This algorithm consists of two operations:

1. Traversing all nodes in DFS order.
2. For each node, making a copy and performing necessary modifications
   to create a new node.

For the first part, DFS traversal will visit each edge twice. Let
T(ascend) represent the cost of taking one step downwards, and
T(descend) represent the cost of taking one step upwards. And both of
them are constants (although mas_ascend() may not be, as it contains a
loop, but here we ignore it and treat it as a constant). So the time
spent on the first part can be represented as
((n-1)/15-1) * (T(ascend) + T(descend)).

For the second part, each node will be copied, and the cost of copying a
node is denoted as T(copy_node). For each non-leaf node, it is necessary
to reallocate all child nodes, and the cost of this operation is denoted
as T(dup_alloc). The behavior behind memory allocation is complex and
not specific to the maple tree operation. Here, we assume that the time
required for a single allocation is constant. Since the size of a node
is fixed, both of these symbols are also constants. We can calculate
that the time spent on the second part is
((n-1)/15) * T(copy_node) + ((n-1)/15 - n/16) * T(dup_alloc).

Adding both parts together, the total time spent by the algorithm can be
represented as:

((n-1)/15) * (T(ascend) + T(descend) + T(copy_node) + T(dup_alloc)) -
n/16 * T(dup_alloc) - (T(ascend) + T(descend))

Let C1 = T(ascend) + T(descend) + T(copy_node) + T(dup_alloc)
Let C2 = T(dup_alloc)
Let C3 = T(ascend) + T(descend)

Finally, the expression can be simplified as:
((16 * C1 - 15 * C2) / (15 * 16)) * n - (C1 / 15 + C3).

This is a linear function, so the average time complexity is O(n).

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/maple_tree.h |   3 +
 lib/maple_tree.c           | 290 +++++++++++++++++++++++++++++++++++++
 2 files changed, 293 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index f91dbc7fe091..a452dd8a1e5c 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -329,6 +329,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
 		void *entry, gfp_t gfp);
 void *mtree_erase(struct maple_tree *mt, unsigned long index);
 
+int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
+int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
+
 void mtree_destroy(struct maple_tree *mt);
 void __mt_destroy(struct maple_tree *mt);
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ca7039633844..6e0ad83f14e3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4,6 +4,10 @@
  * Copyright (c) 2018-2022 Oracle Corporation
  * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
  *	    Matthew Wilcox <willy@infradead.org>
+ *
+ * Algorithm for duplicating Maple Tree
+ * Copyright (c) 2023 ByteDance
+ * Author: Peng Zhang <zhangpeng.00@bytedance.com>
  */
 
 /*
@@ -6475,6 +6479,292 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
 }
 EXPORT_SYMBOL(mtree_erase);
 
+/*
+ * mas_dup_free() - Free an incomplete duplication of a tree.
+ * @mas: The maple state of a incomplete tree.
+ *
+ * The parameter @mas->node passed in indicates that the allocation failed on
+ * this node. This function frees all nodes starting from @mas->node in the
+ * reverse order of mas_dup_build(). There is no need to hold the source tree
+ * lock at this time.
+ */
+static void mas_dup_free(struct ma_state *mas)
+{
+	struct maple_node *node;
+	enum maple_type type;
+	void __rcu **slots;
+	unsigned char count, i;
+
+	/* Maybe the first node allocation failed. */
+	if (mas_is_none(mas))
+		return;
+
+	while (!mte_is_root(mas->node)) {
+		mas_ascend(mas);
+
+		if (mas->offset) {
+			mas->offset--;
+			do {
+				mas_descend(mas);
+				mas->offset = mas_data_end(mas);
+			} while (!mte_is_leaf(mas->node));
+
+			mas_ascend(mas);
+		}
+
+		node = mte_to_node(mas->node);
+		type = mte_node_type(mas->node);
+		slots = ma_slots(node, type);
+		count = mas_data_end(mas) + 1;
+		for (i = 0; i < count; i++)
+			((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
+
+		mt_free_bulk(count, slots);
+	}
+
+	node = mte_to_node(mas->node);
+	mt_free_one(node);
+}
+
+/*
+ * mas_copy_node() - Copy a maple node and replace the parent.
+ * @mas: The maple state of source tree.
+ * @new_mas: The maple state of new tree.
+ * @parent: The parent of the new node.
+ *
+ * Copy @mas->node to @new_mas->node, set @parent to be the parent of
+ * @new_mas->node. If memory allocation fails, @mas is set to -ENOMEM.
+ */
+static inline void mas_copy_node(struct ma_state *mas, struct ma_state *new_mas,
+		struct maple_pnode *parent)
+{
+	struct maple_node *node = mte_to_node(mas->node);
+	struct maple_node *new_node = mte_to_node(new_mas->node);
+	unsigned long val;
+
+	/* Copy the node completely. */
+	memcpy(new_node, node, sizeof(struct maple_node));
+
+	/* Update the parent node pointer. */
+	val = (unsigned long)node->parent & MAPLE_NODE_MASK;
+	new_node->parent = ma_parent_ptr(val | (unsigned long)parent);
+}
+
+/*
+ * mas_dup_alloc() - Allocate child nodes for a maple node.
+ * @mas: The maple state of source tree.
+ * @new_mas: The maple state of new tree.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * This function allocates child nodes for @new_mas->node during the duplication
+ * process. If memory allocation fails, @mas is set to -ENOMEM.
+ */
+static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
+		gfp_t gfp)
+{
+	struct maple_node *node = mte_to_node(mas->node);
+	struct maple_node *new_node = mte_to_node(new_mas->node);
+	enum maple_type type;
+	unsigned char request, count, i;
+	void __rcu **slots;
+	void __rcu **new_slots;
+	unsigned long val;
+
+	/* Allocate memory for child nodes. */
+	type = mte_node_type(mas->node);
+	new_slots = ma_slots(new_node, type);
+	request = mas_data_end(mas) + 1;
+	count = mt_alloc_bulk(gfp, request, (void **)new_slots);
+	if (unlikely(count < request)) {
+		if (count)
+			mt_free_bulk(count, new_slots);
+
+		memset(new_slots, 0, request * sizeof(void *));
+		mas_set_err(mas, -ENOMEM);
+		return;
+	}
+
+	/* Restore node type information in slots. */
+	slots = ma_slots(node, type);
+	for (i = 0; i < count; i++) {
+		val = (unsigned long)mt_slot_locked(mas->tree, slots, i);
+		val &= MAPLE_NODE_MASK;
+		((unsigned long *)new_slots)[i] |= val;
+	}
+}
+
+/*
+ * mas_dup_build() - Build a new maple tree from a source tree
+ * @mas: The maple state of source tree, need to be in MAS_START state.
+ * @new_mas: The maple state of new tree, need to be in MAS_START state.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * This function builds a new tree in DFS preorder. If the memory allocation
+ * fails, the error code -ENOMEM will be set in @mas, and @new_mas points to the
+ * last node. mas_dup_free() will free the incomplete duplication of a tree.
+ *
+ * Note that the attributes of the two trees need to be exactly the same, and the
+ * new tree needs to be empty, otherwise -EINVAL will be set in @mas.
+ */
+static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
+		gfp_t gfp)
+{
+	struct maple_node *node;
+	struct maple_pnode *parent = NULL;
+	struct maple_enode *root;
+	enum maple_type type;
+
+	if (unlikely(mt_attr(mas->tree) != mt_attr(new_mas->tree)) ||
+	    unlikely(!mtree_empty(new_mas->tree))) {
+		mas_set_err(mas, -EINVAL);
+		return;
+	}
+
+	mas_start(mas);
+	if (mas_is_ptr(mas) || mas_is_none(mas)) {
+		root = mt_root_locked(mas->tree);
+		goto set_new_tree;
+	}
+
+	node = mt_alloc_one(gfp);
+	if (!node) {
+		new_mas->node = MAS_NONE;
+		mas_set_err(mas, -ENOMEM);
+		return;
+	}
+
+	type = mte_node_type(mas->node);
+	root = mt_mk_node(node, type);
+	new_mas->node = root;
+	new_mas->min = 0;
+	new_mas->max = ULONG_MAX;
+	root = mte_mk_root(root);
+
+	while (1) {
+		mas_copy_node(mas, new_mas, parent);
+
+		if (!mte_is_leaf(mas->node)) {
+			/* Only allocate child nodes for non-leaf nodes. */
+			mas_dup_alloc(mas, new_mas, gfp);
+			if (unlikely(mas_is_err(mas)))
+				return;
+		} else {
+			/*
+			 * This is the last leaf node and duplication is
+			 * completed.
+			 */
+			if (mas->max == ULONG_MAX)
+				goto done;
+
+			/* This is not the last leaf node and needs to go up. */
+			do {
+				mas_ascend(mas);
+				mas_ascend(new_mas);
+			} while (mas->offset == mas_data_end(mas));
+
+			/* Move to the next subtree. */
+			mas->offset++;
+			new_mas->offset++;
+		}
+
+		mas_descend(mas);
+		parent = ma_parent_ptr(mte_to_node(new_mas->node));
+		mas_descend(new_mas);
+		mas->offset = 0;
+		new_mas->offset = 0;
+	}
+done:
+	/* Specially handle the parent of the root node. */
+	mte_to_node(root)->parent = ma_parent_ptr(mas_tree_parent(new_mas));
+set_new_tree:
+	/* Make them the same height */
+	new_mas->tree->ma_flags = mas->tree->ma_flags;
+	rcu_assign_pointer(new_mas->tree->ma_root, root);
+}
+
+/**
+ * __mt_dup(): Duplicate an entire maple tree
+ * @mt: The source maple tree
+ * @new: The new maple tree
+ * @gfp: The GFP_FLAGS to use for allocations
+ *
+ * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
+ * traversal. It uses memcopy() to copy nodes in the source tree and allocate
+ * new child nodes in non-leaf nodes. The new node is exactly the same as the
+ * source node except for all the addresses stored in it. It will be faster than
+ * traversing all elements in the source tree and inserting them one by one into
+ * the new tree.
+ * The user needs to ensure that the attributes of the source tree and the new
+ * tree are the same, and the new tree needs to be an empty tree, otherwise
+ * -EINVAL will be returned.
+ * Note that the user needs to manually lock the source tree and the new tree.
+ *
+ * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
+ * the attributes of the two trees are different or the new tree is not an empty
+ * tree.
+ */
+int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
+{
+	int ret = 0;
+	MA_STATE(mas, mt, 0, 0);
+	MA_STATE(new_mas, new, 0, 0);
+
+	mas_dup_build(&mas, &new_mas, gfp);
+
+	if (unlikely(mas_is_err(&mas))) {
+		ret = xa_err(mas.node);
+		if (ret == -ENOMEM)
+			mas_dup_free(&new_mas);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(__mt_dup);
+
+/**
+ * mtree_dup(): Duplicate an entire maple tree
+ * @mt: The source maple tree
+ * @new: The new maple tree
+ * @gfp: The GFP_FLAGS to use for allocations
+ *
+ * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
+ * traversal. It uses memcopy() to copy nodes in the source tree and allocate
+ * new child nodes in non-leaf nodes. The new node is exactly the same as the
+ * source node except for all the addresses stored in it. It will be faster than
+ * traversing all elements in the source tree and inserting them one by one into
+ * the new tree.
+ * The user needs to ensure that the attributes of the source tree and the new
+ * tree are the same, and the new tree needs to be an empty tree, otherwise
+ * -EINVAL will be returned.
+ *
+ * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
+ * the attributes of the two trees are different or the new tree is not an empty
+ * tree.
+ */
+int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
+{
+	int ret = 0;
+	MA_STATE(mas, mt, 0, 0);
+	MA_STATE(new_mas, new, 0, 0);
+
+	mas_lock(&new_mas);
+	mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
+
+	mas_dup_build(&mas, &new_mas, gfp);
+	mas_unlock(&mas);
+
+	if (unlikely(mas_is_err(&mas))) {
+		ret = xa_err(mas.node);
+		if (ret == -ENOMEM)
+			mas_dup_free(&new_mas);
+	}
+
+	mas_unlock(&new_mas);
+
+	return ret;
+}
+EXPORT_SYMBOL(mtree_dup);
+
 /**
  * __mt_destroy() - Walk and free all nodes of a locked maple tree.
  * @mt: The maple tree
-- 
2.20.1


