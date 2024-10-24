Return-Path: <linux-fsdevel+bounces-32738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C29AE627
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3838288816
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8211F76C3;
	Thu, 24 Oct 2024 13:23:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6592C1F5849;
	Thu, 24 Oct 2024 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776194; cv=none; b=t6tZUyH/1hPieJQWdw3+MBdF3x683EO2JVvaOcQQb71ktXkhq2g8+5PZWgDA2Rb/jpvm1ZM/L+b0S6azCERqfMKqwJa8RIDunmN1dVq3kuL/7FpBzoVY/xZnZZv3XIMjReIWK1L9V2dWOxuYU/w6vnufu8lDr4lXZ2lLH/MjmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776194; c=relaxed/simple;
	bh=ii9Z9dftvnQW8Iv/xDEHb/DrDFqLPq4c6nEjelfBW9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EyEOZKWe9WfQZUI2TBxoNZahVIIG4b9K4+/TstOye9XTPD+wVpLUXczZea7XKWjkNfTCxXtYrM1hFVkkJ2/WbLnSN7oa/5piRpIiCtWGDQbeZl2ujpJRpiW4Y74393B0gOvCz6QLk/qJAOCOWyNeailAWZQYd+VVVOeKl0R/PQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZ66R6GPHz4f3l8Z;
	Thu, 24 Oct 2024 21:22:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3C7CA1A018D;
	Thu, 24 Oct 2024 21:23:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHusYpShpn7tb6Ew--.444S16;
	Thu, 24 Oct 2024 21:23:07 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	chuck.lever@oracle.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 6.6 12/28] maple_tree: clean up inlines for some functions
Date: Thu, 24 Oct 2024 21:19:53 +0800
Message-Id: <20241024132009.2267260-13-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHusYpShpn7tb6Ew--.444S16
X-Coremail-Antispam: 1UD129KBjvJXoWfJrykWrykCFyrtr1Dtr4kXrb_yoWkGw4Upa
	4UCFyUtrsFqFy0gFWvyr4UA34a9wn3KrW3Xw12gwnYvFy5tryrXFn5Za4Fyr45J348ZFy3
	Ja1Ygrn5Ca13JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsG
	vfC2KfnxnUUI43ZEXa7sREzuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

commit 271f61a8b41dcd86e1ecc2e0455bcc071bc7dde4 upstream.

There are a few functions which were inlined but are somewhat too large to
inline, so remove the inline key word.

There are also several very small functions which are used in critical
code sections which gcc was not inlining, so make this more strict and use
__always_line for these functions.

Link: https://lkml.kernel.org/r/20231101171629.3612299-8-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/maple_tree.c | 78 ++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3df7e3456205..d1416276f1ef 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -217,23 +217,24 @@ static inline unsigned int mt_attr(struct maple_tree *mt)
 	return mt->ma_flags & ~MT_FLAGS_HEIGHT_MASK;
 }
 
-static inline enum maple_type mte_node_type(const struct maple_enode *entry)
+static __always_inline enum maple_type mte_node_type(
+		const struct maple_enode *entry)
 {
 	return ((unsigned long)entry >> MAPLE_NODE_TYPE_SHIFT) &
 		MAPLE_NODE_TYPE_MASK;
 }
 
-static inline bool ma_is_dense(const enum maple_type type)
+static __always_inline bool ma_is_dense(const enum maple_type type)
 {
 	return type < maple_leaf_64;
 }
 
-static inline bool ma_is_leaf(const enum maple_type type)
+static __always_inline bool ma_is_leaf(const enum maple_type type)
 {
 	return type < maple_range_64;
 }
 
-static inline bool mte_is_leaf(const struct maple_enode *entry)
+static __always_inline bool mte_is_leaf(const struct maple_enode *entry)
 {
 	return ma_is_leaf(mte_node_type(entry));
 }
@@ -242,7 +243,7 @@ static inline bool mte_is_leaf(const struct maple_enode *entry)
  * We also reserve values with the bottom two bits set to '10' which are
  * below 4096
  */
-static inline bool mt_is_reserved(const void *entry)
+static __always_inline bool mt_is_reserved(const void *entry)
 {
 	return ((unsigned long)entry < MAPLE_RESERVED_RANGE) &&
 		xa_is_internal(entry);
@@ -295,7 +296,8 @@ static inline bool mas_searchable(struct ma_state *mas)
 	return true;
 }
 
-static inline struct maple_node *mte_to_node(const struct maple_enode *entry)
+static __always_inline struct maple_node *mte_to_node(
+		const struct maple_enode *entry)
 {
 	return (struct maple_node *)((unsigned long)entry & ~MAPLE_NODE_MASK);
 }
@@ -372,12 +374,12 @@ static inline bool mte_has_null(const struct maple_enode *node)
 	return (unsigned long)node & MAPLE_ENODE_NULL;
 }
 
-static inline bool ma_is_root(struct maple_node *node)
+static __always_inline bool ma_is_root(struct maple_node *node)
 {
 	return ((unsigned long)node->parent & MA_ROOT_PARENT);
 }
 
-static inline bool mte_is_root(const struct maple_enode *node)
+static __always_inline bool mte_is_root(const struct maple_enode *node)
 {
 	return ma_is_root(mte_to_node(node));
 }
@@ -387,7 +389,7 @@ static inline bool mas_is_root_limits(const struct ma_state *mas)
 	return !mas->min && mas->max == ULONG_MAX;
 }
 
-static inline bool mt_is_alloc(struct maple_tree *mt)
+static __always_inline bool mt_is_alloc(struct maple_tree *mt)
 {
 	return (mt->ma_flags & MT_FLAGS_ALLOC_RANGE);
 }
@@ -526,11 +528,12 @@ void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
  *
  * Return: The slot in the parent node where @enode resides.
  */
-static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
+static __always_inline
+unsigned int mte_parent_slot(const struct maple_enode *enode)
 {
 	unsigned long val = (unsigned long)mte_to_node(enode)->parent;
 
-	if (val & MA_ROOT_PARENT)
+	if (unlikely(val & MA_ROOT_PARENT))
 		return 0;
 
 	/*
@@ -546,7 +549,8 @@ static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
  *
  * Return: The parent maple node.
  */
-static inline struct maple_node *mte_parent(const struct maple_enode *enode)
+static __always_inline
+struct maple_node *mte_parent(const struct maple_enode *enode)
 {
 	return (void *)((unsigned long)
 			(mte_to_node(enode)->parent) & ~MAPLE_NODE_MASK);
@@ -558,7 +562,7 @@ static inline struct maple_node *mte_parent(const struct maple_enode *enode)
  *
  * Return: true if dead, false otherwise.
  */
-static inline bool ma_dead_node(const struct maple_node *node)
+static __always_inline bool ma_dead_node(const struct maple_node *node)
 {
 	struct maple_node *parent;
 
@@ -574,7 +578,7 @@ static inline bool ma_dead_node(const struct maple_node *node)
  *
  * Return: true if dead, false otherwise.
  */
-static inline bool mte_dead_node(const struct maple_enode *enode)
+static __always_inline bool mte_dead_node(const struct maple_enode *enode)
 {
 	struct maple_node *parent, *node;
 
@@ -730,7 +734,7 @@ static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
  * Return: The pivot at @piv within the limit of the @pivots array, @mas->max
  * otherwise.
  */
-static inline unsigned long
+static __always_inline unsigned long
 mas_safe_pivot(const struct ma_state *mas, unsigned long *pivots,
 	       unsigned char piv, enum maple_type type)
 {
@@ -812,20 +816,20 @@ static inline bool mt_write_locked(const struct maple_tree *mt)
 		lockdep_is_held(&mt->ma_lock);
 }
 
-static inline bool mt_locked(const struct maple_tree *mt)
+static __always_inline bool mt_locked(const struct maple_tree *mt)
 {
 	return mt_external_lock(mt) ? mt_lock_is_held(mt) :
 		lockdep_is_held(&mt->ma_lock);
 }
 
-static inline void *mt_slot(const struct maple_tree *mt,
+static __always_inline void *mt_slot(const struct maple_tree *mt,
 		void __rcu **slots, unsigned char offset)
 {
 	return rcu_dereference_check(slots[offset], mt_locked(mt));
 }
 
-static inline void *mt_slot_locked(struct maple_tree *mt, void __rcu **slots,
-				   unsigned char offset)
+static __always_inline void *mt_slot_locked(struct maple_tree *mt,
+		void __rcu **slots, unsigned char offset)
 {
 	return rcu_dereference_protected(slots[offset], mt_write_locked(mt));
 }
@@ -837,8 +841,8 @@ static inline void *mt_slot_locked(struct maple_tree *mt, void __rcu **slots,
  *
  * Return: The entry stored in @slots at the @offset.
  */
-static inline void *mas_slot_locked(struct ma_state *mas, void __rcu **slots,
-				       unsigned char offset)
+static __always_inline void *mas_slot_locked(struct ma_state *mas,
+		void __rcu **slots, unsigned char offset)
 {
 	return mt_slot_locked(mas->tree, slots, offset);
 }
@@ -851,8 +855,8 @@ static inline void *mas_slot_locked(struct ma_state *mas, void __rcu **slots,
  *
  * Return: The entry stored in @slots at the @offset
  */
-static inline void *mas_slot(struct ma_state *mas, void __rcu **slots,
-			     unsigned char offset)
+static __always_inline void *mas_slot(struct ma_state *mas, void __rcu **slots,
+		unsigned char offset)
 {
 	return mt_slot(mas->tree, slots, offset);
 }
@@ -863,7 +867,7 @@ static inline void *mas_slot(struct ma_state *mas, void __rcu **slots,
  *
  * Return: The pointer to the root of the tree
  */
-static inline void *mas_root(struct ma_state *mas)
+static __always_inline void *mas_root(struct ma_state *mas)
 {
 	return rcu_dereference_check(mas->tree->ma_root, mt_locked(mas->tree));
 }
@@ -1437,10 +1441,8 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
  * Uses metadata to find the end of the data when possible.
  * Return: The zero indexed last slot with data (may be null).
  */
-static inline unsigned char ma_data_end(struct maple_node *node,
-					enum maple_type type,
-					unsigned long *pivots,
-					unsigned long max)
+static __always_inline unsigned char ma_data_end(struct maple_node *node,
+		enum maple_type type, unsigned long *pivots, unsigned long max)
 {
 	unsigned char offset;
 
@@ -4344,7 +4346,7 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 
 }
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
+static __always_inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 {
 retry:
 	mas_set(mas, index);
@@ -4353,7 +4355,7 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 		goto retry;
 }
 
-static inline bool mas_rewalk_if_dead(struct ma_state *mas,
+static __always_inline bool mas_rewalk_if_dead(struct ma_state *mas,
 		struct maple_node *node, const unsigned long index)
 {
 	if (unlikely(ma_dead_node(node))) {
@@ -4372,7 +4374,7 @@ static inline bool mas_rewalk_if_dead(struct ma_state *mas,
  * The prev node value will be mas->node[mas->offset] or MAS_NONE.
  * Return: 1 if the node is dead, 0 otherwise.
  */
-static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
+static int mas_prev_node(struct ma_state *mas, unsigned long min)
 {
 	enum maple_type mt;
 	int offset, level;
@@ -4533,8 +4535,8 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
  * The next value will be mas->node[mas->offset] or MAS_NONE.
  * Return: 1 on dead node, 0 otherwise.
  */
-static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
-				unsigned long max)
+static int mas_next_node(struct ma_state *mas, struct maple_node *node,
+		unsigned long max)
 {
 	unsigned long min;
 	unsigned long *pivots;
@@ -5675,7 +5677,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 }
 EXPORT_SYMBOL_GPL(mas_expected_entries);
 
-static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
+static bool mas_next_setup(struct ma_state *mas, unsigned long max,
 		void **entry)
 {
 	bool was_none = mas_is_none(mas);
@@ -5791,8 +5793,7 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
 }
 EXPORT_SYMBOL_GPL(mt_next);
 
-static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
-		void **entry)
+static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry)
 {
 	if (unlikely(mas->index <= min)) {
 		mas->node = MAS_UNDERFLOW;
@@ -5941,8 +5942,7 @@ EXPORT_SYMBOL_GPL(mas_pause);
  *
  * Returns: True if entry is the answer, false otherwise.
  */
-static inline bool mas_find_setup(struct ma_state *mas, unsigned long max,
-		void **entry)
+static __always_inline bool mas_find_setup(struct ma_state *mas, unsigned long max, void **entry)
 {
 	if (mas_is_active(mas)) {
 		if (mas->last < max)
@@ -6058,7 +6058,7 @@ EXPORT_SYMBOL_GPL(mas_find_range);
  *
  * Returns: True if entry is the answer, false otherwise.
  */
-static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
+static bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
 	if (mas_is_active(mas)) {
-- 
2.39.2


