Return-Path: <linux-fsdevel+bounces-9117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D0483E4BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952A01F21A3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D850A74;
	Fri, 26 Jan 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVjEoRvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C641C95
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306827; cv=none; b=IC6QzxDPwGlpiCEYhM7I69zBend3cm8w6wyNwn5eu2aZt8eT88WVHdn008sw1+jKorfj9EGMm/0Gd0j17iVHwRBnrDrVfkDSQ8qtliqgcB3+4bm4vhah039w5tFGFXkTEDLqFGNfqVfnHYhAJzHf6JpyDF2nnZI68S4V6LOjz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306827; c=relaxed/simple;
	bh=3iCfr68jMbi52uveXBTHGF5XpWrJ2RmPB5uVaQpyoos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEDEJ+8RfmQrP+OiwcgJplsdsCku0rChZjQrpXoPldFm4PUYitisKaGX+IxZBC6iMMUvBAZ36/chfhcyzRGPwx2racle6jkzaq9ZJtZDIhxhauLF9prEC+fYVTD8Czmup+MlP0NwmBVpdtBZv56Wbj/q/YSwT9cZCr3dIjlQ/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVjEoRvx; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706306823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjHVq87doDd992hNB7+kP4O7NuR5v9YaoQfFLxLTrqA=;
	b=ZVjEoRvxqGIupQjKzFmvYbIk8B2wcOCHwSMMhn45BP3F/yzNTpxAUKlKcjyTbey4SiLPuJ
	PjBgvxHdLCALthC7p0ESI378nCTybpHxJJm8GSBAwj/KhSu55GzkFtRYR96Tv8nWlR74AN
	RhhtI32jXBpMW82rfDmYi14rI1ab9LM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-bcachefs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 2/5] eytzinger: Promote to include/linux/
Date: Fri, 26 Jan 2024 17:06:52 -0500
Message-ID: <20240126220655.395093-2-kent.overstreet@linux.dev>
In-Reply-To: <20240126220655.395093-1-kent.overstreet@linux.dev>
References: <20240126220655.395093-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

eytzinger trees are a faster alternative to binary search. They're a bit
more expensive to setup, but lookups perform much better assuming the
tree isn't entirely in cache.

Binary search is a worst case scenario for branch prediction and
prefetching, but eytzinger trees have children adjacent in memory and
thus we can prefetch before knowing the result of a comparison.

An eytzinger tree is a binary tree laid out in an array, with the same
geometry as the usual binary heap construction, but used as a search
tree instead.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/bset.c                         |   2 +-
 fs/bcachefs/journal_seq_blacklist.c        |   6 +-
 fs/bcachefs/replicas.c                     |  17 ++-
 fs/bcachefs/replicas.h                     |   3 +-
 fs/bcachefs/super-io.h                     |   2 +-
 fs/bcachefs/util.c                         | 145 +--------------------
 fs/bcachefs/util.h                         |   4 -
 {fs/bcachefs => include/linux}/eytzinger.h |  56 ++++----
 lib/sort.c                                 |  85 ++++++++++++
 9 files changed, 136 insertions(+), 184 deletions(-)
 rename {fs/bcachefs => include/linux}/eytzinger.h (78%)

diff --git a/fs/bcachefs/bset.c b/fs/bcachefs/bset.c
index 3fd1085b6c61..1d77aa55d641 100644
--- a/fs/bcachefs/bset.c
+++ b/fs/bcachefs/bset.c
@@ -9,12 +9,12 @@
 #include "bcachefs.h"
 #include "btree_cache.h"
 #include "bset.h"
-#include "eytzinger.h"
 #include "trace.h"
 #include "util.h"
 
 #include <asm/unaligned.h>
 #include <linux/console.h>
+#include <linux/eytzinger.h>
 #include <linux/random.h>
 #include <linux/prefetch.h>
 
diff --git a/fs/bcachefs/journal_seq_blacklist.c b/fs/bcachefs/journal_seq_blacklist.c
index 0200e299cfbb..024c9b1b323f 100644
--- a/fs/bcachefs/journal_seq_blacklist.c
+++ b/fs/bcachefs/journal_seq_blacklist.c
@@ -2,10 +2,11 @@
 
 #include "bcachefs.h"
 #include "btree_iter.h"
-#include "eytzinger.h"
 #include "journal_seq_blacklist.h"
 #include "super-io.h"
 
+#include <linux/eytzinger.h>
+
 /*
  * journal_seq_blacklist machinery:
  *
@@ -119,8 +120,7 @@ int bch2_journal_seq_blacklist_add(struct bch_fs *c, u64 start, u64 end)
 	return ret ?: bch2_blacklist_table_initialize(c);
 }
 
-static int journal_seq_blacklist_table_cmp(const void *_l,
-					   const void *_r, size_t size)
+static int journal_seq_blacklist_table_cmp(const void *_l, const void *_r)
 {
 	const struct journal_seq_blacklist_table_entry *l = _l;
 	const struct journal_seq_blacklist_table_entry *r = _r;
diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index cc2672c12031..75fdce373f76 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -6,12 +6,15 @@
 #include "replicas.h"
 #include "super-io.h"
 
+#include <linux/sort.h>
+
 static int bch2_cpu_replicas_to_sb_replicas(struct bch_fs *,
 					    struct bch_replicas_cpu *);
 
 /* Some (buggy!) compilers don't allow memcmp to be passed as a pointer */
-static int bch2_memcmp(const void *l, const void *r, size_t size)
+static int bch2_memcmp(const void *l, const void *r,  const void *priv)
 {
+	size_t size = (size_t) priv;
 	return memcmp(l, r, size);
 }
 
@@ -39,7 +42,8 @@ void bch2_replicas_entry_sort(struct bch_replicas_entry_v1 *e)
 
 static void bch2_cpu_replicas_sort(struct bch_replicas_cpu *r)
 {
-	eytzinger0_sort(r->entries, r->nr, r->entry_size, bch2_memcmp, NULL);
+	eytzinger0_sort_r(r->entries, r->nr, r->entry_size,
+			  bch2_memcmp, NULL, (void *)(size_t)r->entry_size);
 }
 
 static void bch2_replicas_entry_v0_to_text(struct printbuf *out,
@@ -824,10 +828,11 @@ static int bch2_cpu_replicas_validate(struct bch_replicas_cpu *cpu_r,
 {
 	unsigned i;
 
-	sort_cmp_size(cpu_r->entries,
-		      cpu_r->nr,
-		      cpu_r->entry_size,
-		      bch2_memcmp, NULL);
+	sort_r(cpu_r->entries,
+	       cpu_r->nr,
+	       cpu_r->entry_size,
+	       bch2_memcmp, NULL,
+	       (void *)(size_t)cpu_r->entry_size);
 
 	for (i = 0; i < cpu_r->nr; i++) {
 		struct bch_replicas_entry_v1 *e =
diff --git a/fs/bcachefs/replicas.h b/fs/bcachefs/replicas.h
index 654a4b26d3a3..983cce782ac2 100644
--- a/fs/bcachefs/replicas.h
+++ b/fs/bcachefs/replicas.h
@@ -3,9 +3,10 @@
 #define _BCACHEFS_REPLICAS_H
 
 #include "bkey.h"
-#include "eytzinger.h"
 #include "replicas_types.h"
 
+#include <linux/eytzinger.h>
+
 void bch2_replicas_entry_sort(struct bch_replicas_entry_v1 *);
 void bch2_replicas_entry_to_text(struct printbuf *,
 				 struct bch_replicas_entry_v1 *);
diff --git a/fs/bcachefs/super-io.h b/fs/bcachefs/super-io.h
index 95e80e06316b..f37620919e11 100644
--- a/fs/bcachefs/super-io.h
+++ b/fs/bcachefs/super-io.h
@@ -3,12 +3,12 @@
 #define _BCACHEFS_SUPER_IO_H
 
 #include "extents.h"
-#include "eytzinger.h"
 #include "super_types.h"
 #include "super.h"
 #include "sb-members.h"
 
 #include <asm/byteorder.h>
+#include <linux/eytzinger.h>
 
 static inline bool bch2_version_compatible(u16 version)
 {
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index d7ea95abb9df..c7cf9c6fcf9a 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -11,6 +11,7 @@
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
+#include <linux/eytzinger.h>
 #include <linux/freezer.h>
 #include <linux/kthread.h>
 #include <linux/log2.h>
@@ -24,7 +25,6 @@
 #include <linux/sched/clock.h>
 #include <linux/mean_and_variance.h>
 
-#include "eytzinger.h"
 #include "util.h"
 
 static const char si_units[] = "?kMGTPEZY";
@@ -863,149 +863,6 @@ void memcpy_from_bio(void *dst, struct bio *src, struct bvec_iter src_iter)
 	}
 }
 
-static int alignment_ok(const void *base, size_t align)
-{
-	return IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
-		((unsigned long)base & (align - 1)) == 0;
-}
-
-static void u32_swap(void *a, void *b, size_t size)
-{
-	u32 t = *(u32 *)a;
-	*(u32 *)a = *(u32 *)b;
-	*(u32 *)b = t;
-}
-
-static void u64_swap(void *a, void *b, size_t size)
-{
-	u64 t = *(u64 *)a;
-	*(u64 *)a = *(u64 *)b;
-	*(u64 *)b = t;
-}
-
-static void generic_swap(void *a, void *b, size_t size)
-{
-	char t;
-
-	do {
-		t = *(char *)a;
-		*(char *)a++ = *(char *)b;
-		*(char *)b++ = t;
-	} while (--size > 0);
-}
-
-static inline int do_cmp(void *base, size_t n, size_t size,
-			 int (*cmp_func)(const void *, const void *, size_t),
-			 size_t l, size_t r)
-{
-	return cmp_func(base + inorder_to_eytzinger0(l, n) * size,
-			base + inorder_to_eytzinger0(r, n) * size,
-			size);
-}
-
-static inline void do_swap(void *base, size_t n, size_t size,
-			   void (*swap_func)(void *, void *, size_t),
-			   size_t l, size_t r)
-{
-	swap_func(base + inorder_to_eytzinger0(l, n) * size,
-		  base + inorder_to_eytzinger0(r, n) * size,
-		  size);
-}
-
-void eytzinger0_sort(void *base, size_t n, size_t size,
-		     int (*cmp_func)(const void *, const void *, size_t),
-		     void (*swap_func)(void *, void *, size_t))
-{
-	int i, c, r;
-
-	if (!swap_func) {
-		if (size == 4 && alignment_ok(base, 4))
-			swap_func = u32_swap;
-		else if (size == 8 && alignment_ok(base, 8))
-			swap_func = u64_swap;
-		else
-			swap_func = generic_swap;
-	}
-
-	/* heapify */
-	for (i = n / 2 - 1; i >= 0; --i) {
-		for (r = i; r * 2 + 1 < n; r = c) {
-			c = r * 2 + 1;
-
-			if (c + 1 < n &&
-			    do_cmp(base, n, size, cmp_func, c, c + 1) < 0)
-				c++;
-
-			if (do_cmp(base, n, size, cmp_func, r, c) >= 0)
-				break;
-
-			do_swap(base, n, size, swap_func, r, c);
-		}
-	}
-
-	/* sort */
-	for (i = n - 1; i > 0; --i) {
-		do_swap(base, n, size, swap_func, 0, i);
-
-		for (r = 0; r * 2 + 1 < i; r = c) {
-			c = r * 2 + 1;
-
-			if (c + 1 < i &&
-			    do_cmp(base, n, size, cmp_func, c, c + 1) < 0)
-				c++;
-
-			if (do_cmp(base, n, size, cmp_func, r, c) >= 0)
-				break;
-
-			do_swap(base, n, size, swap_func, r, c);
-		}
-	}
-}
-
-void sort_cmp_size(void *base, size_t num, size_t size,
-	  int (*cmp_func)(const void *, const void *, size_t),
-	  void (*swap_func)(void *, void *, size_t size))
-{
-	/* pre-scale counters for performance */
-	int i = (num/2 - 1) * size, n = num * size, c, r;
-
-	if (!swap_func) {
-		if (size == 4 && alignment_ok(base, 4))
-			swap_func = u32_swap;
-		else if (size == 8 && alignment_ok(base, 8))
-			swap_func = u64_swap;
-		else
-			swap_func = generic_swap;
-	}
-
-	/* heapify */
-	for ( ; i >= 0; i -= size) {
-		for (r = i; r * 2 + size < n; r  = c) {
-			c = r * 2 + size;
-			if (c < n - size &&
-			    cmp_func(base + c, base + c + size, size) < 0)
-				c += size;
-			if (cmp_func(base + r, base + c, size) >= 0)
-				break;
-			swap_func(base + r, base + c, size);
-		}
-	}
-
-	/* sort */
-	for (i = n - size; i > 0; i -= size) {
-		swap_func(base, base + i, size);
-		for (r = 0; r * 2 + size < i; r = c) {
-			c = r * 2 + size;
-			if (c < i - size &&
-			    cmp_func(base + c, base + c + size, size) < 0)
-				c += size;
-			if (cmp_func(base + r, base + c, size) >= 0)
-				break;
-			swap_func(base + r, base + c, size);
-		}
-	}
-}
-
 static void mempool_free_vp(void *element, void *pool_data)
 {
 	size_t size = (size_t) pool_data;
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index 0059481995ef..c3b11c3d24ea 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -737,10 +737,6 @@ static inline void memset_u64s_tail(void *s, int c, unsigned bytes)
 	memset(s + bytes, c, rem);
 }
 
-void sort_cmp_size(void *base, size_t num, size_t size,
-	  int (*cmp_func)(const void *, const void *, size_t),
-	  void (*swap_func)(void *, void *, size_t));
-
 /* just the memmove, doesn't update @_nr */
 #define __array_insert_item(_array, _nr, _pos)				\
 	memmove(&(_array)[(_pos) + 1],					\
diff --git a/fs/bcachefs/eytzinger.h b/include/linux/eytzinger.h
similarity index 78%
rename from fs/bcachefs/eytzinger.h
rename to include/linux/eytzinger.h
index b04750dbf870..9565a5c26cd5 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/include/linux/eytzinger.h
@@ -1,27 +1,37 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _EYTZINGER_H
-#define _EYTZINGER_H
+#ifndef _LINUX_EYTZINGER_H
+#define _LINUX_EYTZINGER_H
 
 #include <linux/bitops.h>
 #include <linux/log2.h>
 
-#include "util.h"
+#ifdef EYTZINGER_DEBUG
+#define EYTZINGER_BUG_ON(cond)		BUG_ON(cond)
+#else
+#define EYTZINGER_BUG_ON(cond)
+#endif
 
 /*
  * Traversal for trees in eytzinger layout - a full binary tree layed out in an
- * array
- */
-
-/*
- * One based indexing version:
+ * array.
  *
- * With one based indexing each level of the tree starts at a power of two -
- * good for cacheline alignment:
+ * Consider using an eytzinger tree any time you would otherwise be doing binary
+ * search over an array. Binary search is a worst case scenario for branch
+ * prediction and prefetching, but in an eytzinger tree every node's children
+ * are adjacent in memory, thus we can prefetch children before knowing the
+ * result of the comparison, assuming multiple nodes fit on a cacheline.
+ *
+ * Two variants are provided, for one based indexing and zero based indexing.
+ *
+ * Zero based indexing is more convenient, but one based indexing has better
+ * alignment and thus better performance because each new level of the tree
+ * starts at a power of two, and thus if element 0 was cacheline aligned, each
+ * new level will be as well.
  */
 
 static inline unsigned eytzinger1_child(unsigned i, unsigned child)
 {
-	EBUG_ON(child > 1);
+	EYTZINGER_BUG_ON(child > 1);
 
 	return (i << 1) + child;
 }
@@ -58,7 +68,7 @@ static inline unsigned eytzinger1_last(unsigned size)
 
 static inline unsigned eytzinger1_next(unsigned i, unsigned size)
 {
-	EBUG_ON(i > size);
+	EYTZINGER_BUG_ON(i > size);
 
 	if (eytzinger1_right_child(i) <= size) {
 		i = eytzinger1_right_child(i);
@@ -74,7 +84,7 @@ static inline unsigned eytzinger1_next(unsigned i, unsigned size)
 
 static inline unsigned eytzinger1_prev(unsigned i, unsigned size)
 {
-	EBUG_ON(i > size);
+	EYTZINGER_BUG_ON(i > size);
 
 	if (eytzinger1_left_child(i) <= size) {
 		i = eytzinger1_left_child(i) + 1;
@@ -101,7 +111,7 @@ static inline unsigned __eytzinger1_to_inorder(unsigned i, unsigned size,
 	unsigned shift = __fls(size) - b;
 	int s;
 
-	EBUG_ON(!i || i > size);
+	EYTZINGER_BUG_ON(!i || i > size);
 
 	i  ^= 1U << b;
 	i <<= 1;
@@ -126,7 +136,7 @@ static inline unsigned __inorder_to_eytzinger1(unsigned i, unsigned size,
 	unsigned shift;
 	int s;
 
-	EBUG_ON(!i || i > size);
+	EYTZINGER_BUG_ON(!i || i > size);
 
 	/*
 	 * sign bit trick:
@@ -164,7 +174,7 @@ static inline unsigned inorder_to_eytzinger1(unsigned i, unsigned size)
 
 static inline unsigned eytzinger0_child(unsigned i, unsigned child)
 {
-	EBUG_ON(child > 1);
+	EYTZINGER_BUG_ON(child > 1);
 
 	return (i << 1) + 1 + child;
 }
@@ -231,11 +241,9 @@ static inline unsigned inorder_to_eytzinger0(unsigned i, unsigned size)
 	     (_i) != -1;				\
 	     (_i) = eytzinger0_next((_i), (_size)))
 
-typedef int (*eytzinger_cmp_fn)(const void *l, const void *r, size_t size);
-
 /* return greatest node <= @search, or -1 if not found */
 static inline ssize_t eytzinger0_find_le(void *base, size_t nr, size_t size,
-					 eytzinger_cmp_fn cmp, const void *search)
+					 cmp_func_t cmp, const void *search)
 {
 	unsigned i, n = 0;
 
@@ -244,7 +252,7 @@ static inline ssize_t eytzinger0_find_le(void *base, size_t nr, size_t size,
 
 	do {
 		i = n;
-		n = eytzinger0_child(i, cmp(search, base + i * size, size) >= 0);
+		n = eytzinger0_child(i, cmp(search, base + i * size) >= 0);
 	} while (n < nr);
 
 	if (n & 1) {
@@ -274,8 +282,8 @@ static inline ssize_t eytzinger0_find_le(void *base, size_t nr, size_t size,
 	_i;								\
 })
 
-void eytzinger0_sort(void *, size_t, size_t,
-		    int (*cmp_func)(const void *, const void *, size_t),
-		    void (*swap_func)(void *, void *, size_t));
+void eytzinger0_sort_r(void *, size_t, size_t,
+		       cmp_r_func_t, swap_r_func_t, const void *);
+void eytzinger0_sort(void *, size_t, size_t, cmp_func_t, swap_func_t);
 
-#endif /* _EYTZINGER_H */
+#endif /* _LINUX_EYTZINGER_H */
diff --git a/lib/sort.c b/lib/sort.c
index b399bf10d675..3dfa83d86bbb 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -290,3 +290,88 @@ void sort(void *base, size_t num, size_t size,
 	return sort_r(base, num, size, _CMP_WRAPPER, SWAP_WRAPPER, &w);
 }
 EXPORT_SYMBOL(sort);
+
+#include <linux/eytzinger.h>
+
+static inline int eytzinger0_do_cmp(void *base, size_t n, size_t size,
+			 cmp_r_func_t cmp_func, const void *priv,
+			 size_t l, size_t r)
+{
+	return do_cmp(base + inorder_to_eytzinger0(l, n) * size,
+		      base + inorder_to_eytzinger0(r, n) * size,
+		      cmp_func, priv);
+}
+
+static inline void eytzinger0_do_swap(void *base, size_t n, size_t size,
+			   swap_r_func_t swap_func, const void *priv,
+			   size_t l, size_t r)
+{
+	do_swap(base + inorder_to_eytzinger0(l, n) * size,
+		base + inorder_to_eytzinger0(r, n) * size,
+		size, swap_func, priv);
+}
+
+void eytzinger0_sort_r(void *base, size_t n, size_t size,
+		       cmp_r_func_t cmp_func,
+		       swap_r_func_t swap_func,
+		       const void *priv)
+{
+	int i, c, r;
+
+	if (!swap_func) {
+		if (is_aligned(base, size, 8))
+			swap_func = SWAP_WORDS_64;
+		else if (is_aligned(base, size, 4))
+			swap_func = SWAP_WORDS_32;
+		else
+			swap_func = SWAP_BYTES;
+	}
+
+	/* heapify */
+	for (i = n / 2 - 1; i >= 0; --i) {
+		for (r = i; r * 2 + 1 < n; r = c) {
+			c = r * 2 + 1;
+
+			if (c + 1 < n &&
+			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
+				c++;
+
+			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
+				break;
+
+			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
+		}
+	}
+
+	/* sort */
+	for (i = n - 1; i > 0; --i) {
+		eytzinger0_do_swap(base, n, size, swap_func, priv, 0, i);
+
+		for (r = 0; r * 2 + 1 < i; r = c) {
+			c = r * 2 + 1;
+
+			if (c + 1 < i &&
+			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
+				c++;
+
+			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
+				break;
+
+			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(eytzinger0_sort_r);
+
+void eytzinger0_sort(void *base, size_t n, size_t size,
+		     cmp_func_t cmp_func,
+		     swap_func_t swap_func)
+{
+	struct wrapper w = {
+		.cmp  = cmp_func,
+		.swap = swap_func,
+	};
+
+	return eytzinger0_sort_r(base, n, size, _CMP_WRAPPER, SWAP_WRAPPER, &w);
+}
+EXPORT_SYMBOL_GPL(eytzinger0_sort);
-- 
2.43.0


