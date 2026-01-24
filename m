Return-Path: <linux-fsdevel+bounces-75361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOeBA7UcdWnkAwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:25:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F947EB6C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E08B13011BDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDB02367DF;
	Sat, 24 Jan 2026 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="fz0s2ndq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1E1459FA;
	Sat, 24 Jan 2026 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769282732; cv=pass; b=s6BopPMJN0rUk4sk4E0J7D35QJbo1BuK0Q7YWqsspcIeGf7jEX1chMLef/6QWEvUSNU1r4LB651TE/kfc1XmmXrsQcpv+y7Zs6wvYUsKDcBLBjXEWoSA4xvg3wNYPx4/7itocH6M0G+WF9msP3397yoyNF8E8KmBI5aoqJO/Bl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769282732; c=relaxed/simple;
	bh=ARxKrc5ICs+x0kuUhhmTevpSYSmB7S+gS1vBTQNhXrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uxzsinOX4+TJQpMtZr6+u4KDkhWjt1wMf6gUcxnLoKyLwB7NwQfzoFBfQYsfHbQZYkB2IkRmH2tORDuDAAMlxWXNpLVFfJ23o+AY5AF8zUct5iy+KWaNdlYWPmtGhpdNFf9DMe027yKqxZ3n5Dj57jsjsrMNUDD6B5qdeKG2wh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=fz0s2ndq; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1769282712; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nu3FXspp7UGp3vj6OUxAlzfv6MOaN+VR5S0EDI3wE1hiDUGZLYRQhiboef3VRsMahAWJBSxi45DtOVdDMieJUqzgqXaBsRmLzow3M2RHBQoTL+/+SqTdI8ucNB82yDol5WdIXX+ixip87RiRXCwxxFmhwB3aGGieS/Th9JKPE+o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769282712; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WH0+/VK2kS30gVereF8cujZldhmw0rDktKxZGymIlvM=; 
	b=BghsOv9uXuGTHAfiahcJ0ceKKk1U3J74HuTyqEbSCQshZLUGkzXQKeZA5pfLdMTaWRHvwAGcC6KqdI6vt9T65YIkV5tKcN7Kw1GfjMGaema+ktnL/us7TrrPUh6z8QDCc8JGXXP3QZL/T7MvASBOdq/WrDZb569Rq0XqVgZGp18=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769282712;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=WH0+/VK2kS30gVereF8cujZldhmw0rDktKxZGymIlvM=;
	b=fz0s2ndqe+ewLFcq0UEo6KJ84M9PgsxyXfCoAFMDLGbsyCV1awqH6wF0TgjqQJ5j
	RFasHbR0BKRT3k5zHGhPPyC6A8PVbIpD5F4oRIQYbaP3AihAn3bcfxL6ZJissXy0O/2
	q8NbdJr26wAzbyvKOJxknLexnL/FRK/xqU3moaAo=
Received: by mx.zohomail.com with SMTPS id 176928271038570.14315400400324;
	Sat, 24 Jan 2026 11:25:10 -0800 (PST)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com,
	janak@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH] hfsplus: validate btree bitmap during mount and handle corruption gracefully
Date: Sun, 25 Jan 2026 00:55:01 +0530
Message-Id: <20260124192501.748071-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75361-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 66F947EB6C
X-Rspamd-Action: no action

Add bitmap validation during HFS+ btree open to detect corruption where
node 0 (header node) is not marked allocated. When corruption is detected,
mount the filesystem read-only instead of failing the mount, allowing data
recovery from corrupted images.

The bitmap validation checks the node allocation bitmap in the btree header
node (record #2) and verifies that bit 7 (MSB) of the first byte is set,
indicating node 0 is allocated. This is a fundamental invariant that must
always hold.

Implementation details:
- Add 'btree_bitmap_corrupted' flag to 'struct hfsplus_sb_info' to track
  corruption at superblock level
- Create and use 'hfsplus_validate_btree_bitmap()' to return bool indicating corruption
- Check corruption flag in 'hfsplus_fill_super()' after all btree opens
- Mount read-only with consolidated warning message when corruption detected
- Preserve existing btree validation logic and error handling patterns

This prevents kernel panics from corrupted syzkaller-generated HFS+ images
while enabling data recovery by mounting read-only instead of failing.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Link: https://lore.kernel.org/all/784415834694f39902088fa8946850fc1779a318.camel@ibm.com/
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/btree.c      | 68 +++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/hfsplus_fs.h |  1 +
 fs/hfsplus/super.c      |  7 +++++
 3 files changed, 76 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 229f25dc7c49..c451da7eae25 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -129,6 +129,68 @@ u32 hfsplus_calc_btree_clump_size(u32 block_size, u32 node_size,
 	return clump_size;
 }
 
+/*
+ * Validate that node 0 (header node) is marked allocated in the bitmap.
+ * This is a fundamental invariant - node 0 must always be allocated.
+ * Returns true if corruption is detected (node 0 bit is unset).
+ * Note: head must be from kmap_local_page(page) that is still mapped.
+ * This function accesses the page through head pointer, so it must be
+ * called before kunmap_local(head).
+ */
+static bool hfsplus_validate_btree_bitmap(struct hfs_btree *tree,
+					  struct hfs_btree_header_rec *head)
+{
+	u8 *page_base;
+	u16 rec_off_tbl_off;
+	__be16 rec_data[2];
+	u16 bitmap_off, bitmap_len;
+	u8 *bitmap_ptr;
+	u8 first_byte;
+	unsigned int node_size = tree->node_size;
+
+	/*
+	 * Get base page pointer. head points to:
+	 * kmap_local_page(page) + sizeof(struct hfs_bnode_desc)
+	 */
+	page_base = (u8 *)head - sizeof(struct hfs_bnode_desc);
+
+	/*
+	 * Calculate offset to record 2 entry in record offset table.
+	 * Record offsets are at end of node: node_size - (rec_num + 2) * 2
+	 * Record 2: (2+2)*2 = 8 bytes from end
+	 */
+	rec_off_tbl_off = node_size - (2 + 2) * 2;
+
+	/* Only validate if record offset table is on the first page */
+	if (rec_off_tbl_off + 4 > node_size || rec_off_tbl_off + 4 > PAGE_SIZE)
+		return false; /* Skip validation if offset table not on first page */
+
+	/* Read record 2 offset table entry (length and offset, both u16) */
+	memcpy(rec_data, page_base + rec_off_tbl_off, 4);
+	bitmap_off = be16_to_cpu(rec_data[1]);
+	bitmap_len = be16_to_cpu(rec_data[0]) - bitmap_off;
+
+	/*
+	 * Validate bitmap offset is within node and after bnode_desc.
+	 * Also ensure bitmap is on the first page.
+	 */
+	if (bitmap_len == 0 ||
+	    bitmap_off < sizeof(struct hfs_bnode_desc) ||
+	    bitmap_off >= node_size ||
+	    bitmap_off >= PAGE_SIZE)
+		return false; /* Skip validation if bitmap not accessible */
+
+	/* Read first byte of bitmap */
+	bitmap_ptr = page_base + bitmap_off;
+	first_byte = bitmap_ptr[0];
+
+	/* Check if node 0's bit (bit 7, MSB) is set */
+	if (!(first_byte & 0x80))
+		return true; /* Corruption detected */
+
+	return false;
+}
+
 /* Get a reference to a B*Tree and do some initial checks */
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 {
@@ -176,6 +238,12 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	tree->max_key_len = be16_to_cpu(head->max_key_len);
 	tree->depth = be16_to_cpu(head->depth);
 
+	/* Validate bitmap: node 0 must be marked allocated */
+	if (hfsplus_validate_btree_bitmap(tree, head)) {
+		struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+		sbi->btree_bitmap_corrupted = true;
+	}
+
 	/* Verify the tree and set the correct compare function */
 	switch (id) {
 	case HFSPLUS_EXT_CNID:
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 45fe3a12ecba..b925878333d4 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -154,6 +154,7 @@ struct hfsplus_sb_info {
 
 	int part, session;
 	unsigned long flags;
+	bool btree_bitmap_corrupted;	/* Bitmap corruption detected during btree open */
 
 	int work_queued;               /* non-zero delayed work is queued */
 	struct delayed_work sync_work; /* FS sync delayed work */
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index aaffa9e060a0..b3facd23d758 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -534,6 +534,13 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 		atomic_set(&sbi->attr_tree_state, HFSPLUS_VALID_ATTR_TREE);
 	}
+
+	/* Check for bitmap corruption and mount read-only if detected */
+	if (sbi->btree_bitmap_corrupted) {
+		pr_warn("HFS+ (device %s): btree bitmap corruption detected, mounting read-only; run fsck.hfsplus to repair\n",
+			sb->s_id);
+		sb->s_flags |= SB_RDONLY;
+	}
 	sb->s_xattr = hfsplus_xattr_handlers;
 
 	inode = hfsplus_iget(sb, HFSPLUS_ALLOC_CNID);
-- 
2.34.1


