Return-Path: <linux-fsdevel+bounces-78822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDE5N5beomkV7gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:24:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB791C2EDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67936308C2F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9170842E011;
	Sat, 28 Feb 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="i6w27UYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB111421EE9;
	Sat, 28 Feb 2026 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772281469; cv=pass; b=W+jcgw1WMFDFdGfZpfz3WB0y6lNhwUBqf+jC6j9AGLaj0XkowjOjr1AXfp7yI/g6tLxcY6uM55X/l9smQjp9hoHrBPFfy0Q9AFFSYFSlgctXi4EFOT4l5qE5EQ6xwVUWlKSZT3Uk82z4hr+g1vgLl56Xaf3gJF47DtOYXiAHDt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772281469; c=relaxed/simple;
	bh=QlpfaqnfiAJKueVBPMFM59rsH19GQ7nBBUP21TBB7Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOb93HAX61SYCVsN/ze51E+XMKVKhanDSYRHavqvGEnMF7bASDT6yrmXC5MNtJGYTWypSH9eAQhV1m/JBMTmmUyPns9dEWHhEmtOHo7TeRZhSqFR9AAocyVA9yJ5CjTBvBwErND78jSItYllcq62CsdOtR9e+XlBctPXPy2BR1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=i6w27UYa; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1772281399; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I7BddgN+KE4XsTKRCflWvxrNxayyhlWBn8XBtDwArs01hX12yuVHWm7rY73Qf6fJ67wc0nWrNPVc3enI2LWCq70b9vfVamTeVxSphmcKvnEB3Ox9EOW2tCoGb0d3R2CsrZ2dCggQ/6MpD0lmQd+nIFr4GYE9QlpiymvbAjBEONE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772281399; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wYt2H6kHY1UF1JYY5uKYhQ/9LANzexon3qFvyMq2Q0w=; 
	b=azzPS666WxljPehMJgiw0T5vH5cF/C9qf8Fh8NfSvfCaUlo6//13Z5OQgc6ov71DBjcxkaZLdutvnc9RMKG/K/XPgF+eGe0Z14QdOsblUPv5cQk9wfevW1h1hR1U85ixtfVqZik6QF+CRd2AcrHQnBz+9d7HqlVogZdKGGG9jQo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772281399;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=wYt2H6kHY1UF1JYY5uKYhQ/9LANzexon3qFvyMq2Q0w=;
	b=i6w27UYa+eMDNL2SfvWzvGkvPOfgvzec/q4EN0p3eUhYwqv44JPEPAhbl7HOWQ5c
	ukT+yuZJUxx7c9xq1ClVEC2YOf5rSclN3TjDIQVI0EH76gSDRYqHzbKDmmFnr9ZhGU3
	+LHtXB3eNosYc/sPpkMCYyGUJTbMgRXZu5oeoVmY=
Received: by mx.zohomail.com with SMTPS id 1772281397042429.53615914485624;
	Sat, 28 Feb 2026 04:23:17 -0800 (PST)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v5 1/2] hfsplus: refactor b-tree map page access and add node-type validation
Date: Sat, 28 Feb 2026 17:53:04 +0530
Message-Id: <20260228122305.1406308-2-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
References: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,mpiric.us,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78822-lists,linux-fsdevel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpiricsoftware.com:mid,mpiricsoftware.com:dkim,mpiricsoftware.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BB791C2EDF
X-Rspamd-Action: no action

In HFS+ b-trees, the node allocation bitmap is stored across multiple
records. The first chunk resides in the b-tree Header Node at record
index 2, while all subsequent chunks are stored in dedicated Map Nodes
at record index 0.

This structural quirk forces callers like hfs_bmap_alloc() and
hfs_bmap_free() to duplicate boilerplate code to validate offsets, correct
lengths, and map the underlying pages via kmap_local_page(). There is
also currently no strict node-type validation before reading these
records, leaving the allocator vulnerable if a corrupted image points a
map linkage to an Index or Leaf node.

Introduce a unified bit-level API to encapsulate the map record access:
1. A new 'struct hfs_bmap_ctx' to cleanly pass state and safely handle
   page math across all architectures.
2. 'hfs_bmap_get_map_page()': Automatically validates node types
   (HFS_NODE_HEADER vs HFS_NODE_MAP), infers the correct record index,
   and handles page-boundary math for records that span multiple pages.
3. 'hfs_bmap_test_bit()' and 'hfs_bmap_clear_bit()': Clean wrappers that
   internally handle page mapping/unmapping for single-bit operations.

Refactor hfs_bmap_alloc() and hfs_bmap_free() to utilize this new API.
This deduplicates the allocator logic, hardens the map traversal against
fuzzed images, and provides the exact abstractions needed for upcoming
mount-time validation checks.

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/btree.c         | 186 +++++++++++++++++++++++++++----------
 include/linux/hfs_common.h |   2 +
 2 files changed, 141 insertions(+), 47 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 1220a2f22737..87650e23cd65 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -129,6 +129,116 @@ u32 hfsplus_calc_btree_clump_size(u32 block_size, u32 node_size,
 	return clump_size;
 }
 
+/* Context for iterating b-tree map pages */
+struct hfs_bmap_ctx {
+	unsigned int page_idx;
+	unsigned int off;
+	u16 len;
+};
+
+/*
+ * Maps the specific page containing the requested byte offset within the map
+ * record.
+ * Automatically handles the difference between header and map nodes.
+ * Returns the mapped data pointer, or an ERR_PTR on failure.
+ * Note: The caller is responsible for calling kunmap_local(data).
+ */
+static u8 *hfs_bmap_get_map_page(struct hfs_bnode *node, struct hfs_bmap_ctx *ctx,
+				u32 byte_offset)
+{
+	u16 rec_idx, off16;
+	unsigned int page_off; /* 32-bit math prevents LKP overflow warnings */
+
+	if (node->this == HFSPLUS_TREE_HEAD) {
+		if (node->type != HFS_NODE_HEADER) {
+			pr_err("hfsplus: invalid btree header node\n");
+			return ERR_PTR(-EIO);
+		}
+		rec_idx = HFSPLUS_BTREE_HDR_MAP_REC_INDEX;
+	} else {
+		if (node->type != HFS_NODE_MAP) {
+			pr_err("hfsplus: invalid btree map node\n");
+			return ERR_PTR(-EIO);
+		}
+		rec_idx = HFSPLUS_BTREE_MAP_NODE_REC_INDEX;
+	}
+
+	ctx->len = hfs_brec_lenoff(node, rec_idx, &off16);
+	if (!ctx->len)
+		return ERR_PTR(-ENOENT);
+
+	if (!is_bnode_offset_valid(node, off16))
+		return ERR_PTR(-EIO);
+
+	ctx->len = check_and_correct_requested_length(node, off16, ctx->len);
+
+	if (byte_offset >= ctx->len)
+		return ERR_PTR(-EINVAL);
+
+	page_off = off16 + node->page_offset + byte_offset;
+	ctx->page_idx = page_off >> PAGE_SHIFT;
+	ctx->off = page_off & ~PAGE_MASK;
+
+	return kmap_local_page(node->page[ctx->page_idx]);
+}
+
+/**
+ * hfs_bmap_test_bit - test a bit in the b-tree map
+ * @node: the b-tree node containing the map record
+ * @bit_idx: the bit index relative to the start of the map record
+ *
+ * Returns 1 if set, 0 if clear, or a negative error code on failure.
+ */
+static int hfs_bmap_test_bit(struct hfs_bnode *node, u32 bit_idx)
+{
+	struct hfs_bmap_ctx ctx;
+	u8 *data, byte, m;
+	int res;
+
+	data = hfs_bmap_get_map_page(node, &ctx, bit_idx / 8);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	byte = data[ctx.off];
+	kunmap_local(data);
+
+	/* In HFS+ bitmaps, bit 0 is the MSB (0x80) */
+	m = 1 << (~bit_idx & 7);
+	res = (byte & m) ? 1 : 0;
+
+	return res;
+}
+
+/**
+ * hfs_bmap_clear_bit - clear a bit in the b-tree map
+ * @node: the b-tree node containing the map record
+ * @bit_idx: the bit index relative to the start of the map record
+ *
+ * Returns 0 on success, -EALREADY if already clear, or negative error code.
+ */
+static int hfs_bmap_clear_bit(struct hfs_bnode *node, u32 bit_idx)
+{
+	struct hfs_bmap_ctx ctx;
+	u8 *data, m;
+
+	data = hfs_bmap_get_map_page(node, &ctx, bit_idx / 8);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	m = 1 << (~bit_idx & 7);
+
+	if (!(data[ctx.off] & m)) {
+		kunmap_local(data);
+		return -EALREADY;
+	}
+
+	data[ctx.off] &= ~m;
+	set_page_dirty(node->page[ctx.page_idx]);
+	kunmap_local(data);
+
+	return 0;
+}
+
 /* Get a reference to a B*Tree and do some initial checks */
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 {
@@ -374,11 +484,8 @@ int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)
 struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 {
 	struct hfs_bnode *node, *next_node;
-	struct page **pagep;
+	struct hfs_bmap_ctx ctx;
 	u32 nidx, idx;
-	unsigned off;
-	u16 off16;
-	u16 len;
 	u8 *data, byte, m;
 	int i, res;
 
@@ -390,30 +497,25 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	node = hfs_bnode_find(tree, nidx);
 	if (IS_ERR(node))
 		return node;
-	len = hfs_brec_lenoff(node, 2, &off16);
-	off = off16;
 
-	if (!is_bnode_offset_valid(node, off)) {
+	data = hfs_bmap_get_map_page(node, &ctx, 0);
+	if (IS_ERR(data)) {
+		res = PTR_ERR(data);
 		hfs_bnode_put(node);
-		return ERR_PTR(-EIO);
+		return ERR_PTR(res);
 	}
-	len = check_and_correct_requested_length(node, off, len);
 
-	off += node->page_offset;
-	pagep = node->page + (off >> PAGE_SHIFT);
-	data = kmap_local_page(*pagep);
-	off &= ~PAGE_MASK;
 	idx = 0;
 
 	for (;;) {
-		while (len) {
-			byte = data[off];
+		while (ctx.len) {
+			byte = data[ctx.off];
 			if (byte != 0xff) {
 				for (m = 0x80, i = 0; i < 8; m >>= 1, i++) {
 					if (!(byte & m)) {
 						idx += i;
-						data[off] |= m;
-						set_page_dirty(*pagep);
+						data[ctx.off] |= m;
+						set_page_dirty(node->page[ctx.page_idx]);
 						kunmap_local(data);
 						tree->free_nodes--;
 						mark_inode_dirty(tree->inode);
@@ -423,13 +525,13 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 					}
 				}
 			}
-			if (++off >= PAGE_SIZE) {
+			if (++ctx.off >= PAGE_SIZE) {
 				kunmap_local(data);
-				data = kmap_local_page(*++pagep);
-				off = 0;
+				data = kmap_local_page(node->page[++ctx.page_idx]);
+				ctx.off = 0;
 			}
 			idx += 8;
-			len--;
+			ctx.len--;
 		}
 		kunmap_local(data);
 		nidx = node->next;
@@ -443,22 +545,21 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			return next_node;
 		node = next_node;
 
-		len = hfs_brec_lenoff(node, 0, &off16);
-		off = off16;
-		off += node->page_offset;
-		pagep = node->page + (off >> PAGE_SHIFT);
-		data = kmap_local_page(*pagep);
-		off &= ~PAGE_MASK;
+		data = hfs_bmap_get_map_page(node, &ctx, 0);
+		if (IS_ERR(data)) {
+			res = PTR_ERR(data);
+			hfs_bnode_put(node);
+			return ERR_PTR(res);
+		}
 	}
 }
 
 void hfs_bmap_free(struct hfs_bnode *node)
 {
 	struct hfs_btree *tree;
-	struct page *page;
 	u16 off, len;
 	u32 nidx;
-	u8 *data, byte, m;
+	int res;
 
 	hfs_dbg("node %u\n", node->this);
 	BUG_ON(!node->this);
@@ -495,24 +596,15 @@ void hfs_bmap_free(struct hfs_bnode *node)
 		}
 		len = hfs_brec_lenoff(node, 0, &off);
 	}
-	off += node->page_offset + nidx / 8;
-	page = node->page[off >> PAGE_SHIFT];
-	data = kmap_local_page(page);
-	off &= ~PAGE_MASK;
-	m = 1 << (~nidx & 7);
-	byte = data[off];
-	if (!(byte & m)) {
-		pr_crit("trying to free free bnode "
-				"%u(%d)\n",
-			node->this, node->type);
-		kunmap_local(data);
-		hfs_bnode_put(node);
-		return;
+
+	res = hfs_bmap_clear_bit(node, nidx);
+	if (res == -EALREADY) {
+		pr_crit("trying to free free bnode %u(%d)\n",
+				node->this, node->type);
+	} else if (!res) {
+		tree->free_nodes++;
+		mark_inode_dirty(tree->inode);
 	}
-	data[off] = byte & ~m;
-	set_page_dirty(page);
-	kunmap_local(data);
+
 	hfs_bnode_put(node);
-	tree->free_nodes++;
-	mark_inode_dirty(tree->inode);
 }
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index dadb5e0aa8a3..be24c687858e 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -510,6 +510,8 @@ struct hfs_btree_header_rec {
 #define HFSPLUS_NODE_MXSZ			32768
 #define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
 #define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
+#define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		2	/* Map (bitmap) record in Header node */
+#define HFSPLUS_BTREE_MAP_NODE_REC_INDEX	0	/* Map record in Map Node */
 #define HFSPLUS_BTREE_HDR_USER_BYTES		128
 
 /* btree key type */
-- 
2.34.1


