Return-Path: <linux-fsdevel+bounces-75377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MdUOCTOJdWk2GAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 04:08:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C627F8F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 04:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA1A5300C93A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 03:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D52220ADD6;
	Sun, 25 Jan 2026 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="FxZ36P1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7760137930;
	Sun, 25 Jan 2026 03:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769310498; cv=pass; b=EVRJcitrSi2rOIwvuKorHNBqJaDdBgzYYbVNsIkyMixdjrDPXNtt3rodI/edYVX+H/Ggela6mlUz2YF3Q32qEicDpYLDQCdHGOavG4JcmOoarZPap1/upBJH30ol67FmGTuq/uA/NDZ/MowmBQGRRZraFdj4L+mHDnproiqSjfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769310498; c=relaxed/simple;
	bh=fZGyKcnEI4GCF17KJ6vbSSVlIRLqdDR7bQ60eBCLdU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jlT+vuOO830ERhOrszjvKXp019FEzP+dpTFYuc5SIKrJQeNIUvPjvDmMdldhWdgczd8iO5/gp15b1fFBEyytivcarPfuOMeeXKO4Wg8W5LaHqGfVJ38u9ILnI+I55hZpQKpZcye7vOdENUypD5qvUOQMYJYqjHjwR3Xc6bjpj+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=FxZ36P1t; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1769310468; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j6eQEKzdCFLs2Fpb9vzYdTxANBXfbJ/+itUFxT1WAEK0+wkvgXvkrV6kE7TNhmTObMEnWfDmPI5Rh9SVMh5nLOLKRIL5IoTTjfiw7mvOQOjTLNg0SVuCjDAFeOB12meuwsP4kXIX+DzN0+BPV9i6dH/1FStk2wYThw73xxXN27U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769310468; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IWK8DEohCafYWSIpTSGiK8gYHfXsETGWDbBdfTpGetc=; 
	b=ELwlLRrkBEGC1+ntMJIkpNkDX1oxBwGzf7LCL5JSK5oJCFiltgurdEgfpSFNCeZt5HlEDmPMt3RIl5JSLmbVaYNMJAX7NQK7OVPLdetboFBn2tBHJiuMS5LYlUfom+iQTk/ERecYfWOlTGwYbscf9iIehLFoT4C6xDR4NY0McmA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769310468;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=IWK8DEohCafYWSIpTSGiK8gYHfXsETGWDbBdfTpGetc=;
	b=FxZ36P1tLqidla3EoHwQdZrg5rfqbFevRr/BUxN0SwDV1HshVZjdYNdyR/X5mSCi
	2hkQju7vQazsPaRCV+FUpWPPQSIKHOVAflIhlperVXeFeqym9jxBTEjX7TfQtOehvV5
	1ca5E0/Db/aDYp99LjQxQwYd7IIHq734fBbKHm6w=
Received: by mx.zohomail.com with SMTPS id 1769310465937305.19096778081985;
	Sat, 24 Jan 2026 19:07:45 -0800 (PST)
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
Subject: [PATCH v2] hfsplus: validate btree bitmap during mount and handle corruption gracefully
Date: Sun, 25 Jan 2026 08:37:33 +0530
Message-Id: <20260125030733.1384703-1-shardul.b@mpiricsoftware.com>
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
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75377-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DMARC_DNSFAIL(0.00)[mpiricsoftware.com : SPF/DKIM temp error,quarantine];
	DKIM_TRACE(0.00)[mpiricsoftware.com:?];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	TO_DN_SOME(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[mpiricsoftware.com:s=mpiric];
	NEURAL_SPAM(0.00)[0.963];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:mid,mpiricsoftware.com:email]
X-Rspamd-Queue-Id: 77C627F8F5
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
- Create and use 'hfsplus_validate_btree_bitmap()' to return bool
  indicating corruption
- Check corruption flag in 'hfsplus_fill_super()' after all btree opens
- Mount read-only with consolidated warning message when corruption
  detected
- Preserve existing btree validation logic and error handling patterns

This prevents kernel panics from corrupted syzkaller-generated HFS+ images
while enabling data recovery by mounting read-only instead of failing.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Link: https://lore.kernel.org/all/784415834694f39902088fa8946850fc1779a318.camel@ibm.com/
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v2 changes:
  - Fix compiler warning about comparing u16 bitmap_off with PAGE_SIZE which
can exceed u16 maximum on some architectures
  - Cast bitmap_off to unsigned int for the PAGE_SIZE comparison to avoid
tautological constant-out-of-range comparison warning.
  - Link: https://lore.kernel.org/oe-kbuild-all/202601251011.kJUhBF3P-lkp@intel.com/

 fs/hfsplus/btree.c      | 69 +++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/hfsplus_fs.h |  1 +
 fs/hfsplus/super.c      |  7 +++++
 3 files changed, 77 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 229f25dc7c49..0fb8c7c06afe 100644
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
+	    (unsigned int) bitmap_off >= PAGE_SIZE)
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
@@ -176,6 +238,13 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	tree->max_key_len = be16_to_cpu(head->max_key_len);
 	tree->depth = be16_to_cpu(head->depth);
 
+	/* Validate bitmap: node 0 must be marked allocated */
+	if (hfsplus_validate_btree_bitmap(tree, head)) {
+		struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+
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


