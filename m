Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B262AE74C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 05:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgKKEM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 23:12:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47868 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgKKEMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 23:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605067943; x=1636603943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ad/b7YCocoBccbl0Mfvflg6ViEBPUcE/tK9LhtGJj7s=;
  b=SSu8DYrbDRqjt/jP2pJaY8uiDXBNieH67vtI2koL0u+giQ/a2ExU9nGC
   SgZOiF/6zQYbZkAxiRBAG5tf//5c+ZHc+V4W/pk5A+9VHP+Ir57SemD88
   Msg/S2PREUyjLxMJAftGQulu+70PJN8AprEsnIwTR8oj0xRP/HTDpitnu
   3copbPiVQ7W3PbxorlCRoAeq4jopQUz7B6HpP7p3xEgeIkbk28Zppntk0
   VATY7yTtIs/YuPSg1qdNpyOrX9GYSDNT8Ox5dhCn8KNfr5Rm+F4Pn8Tnb
   1NGeFB/ByVUag7H12Vs1+BnrU739MC4KeY53GMH1fPjiiGX5VR2v7yKOk
   Q==;
IronPort-SDR: X83VzzaK0OIT4fEzx+TJ+vf9M3KpG2EPKL//pQLCODs2FhhvDAMeLme7xxMD2o4DLLbCU9Cc5n
 0jKegapaDdP+7LbeLgiscT/wrAausZMULsTcI2pG0w38Ut+9G5NQSrXByUXaklbpGN+DTuTCF7
 OE2gDIZEtTsD63OfVdG1ZUKf+axFOXKjR7edeP6j93hgF1INPkJwiAEDhX6wqpbsI7uK0nLb48
 M2LJJGIFTQQ2Nun9/rx6xGJ3jcFrDJhDMj+ynUwBrY4+8mYGBzSiSgmkEEASBCJcKc7FoD+n6t
 NOo=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="156835235"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 12:12:23 +0800
IronPort-SDR: do83mpx7DkNvbJ39SfW6/Uky5Czhk5yCVyQ9FXyFZZqAJ1em2NNKmG6MvUhby31Mz2hkzZCV8l
 JLhzN2oNpkzhyelQ/dw3KZmUKI7WgBldtmULNG0gk2SAmFLi2WvPT6hNZNI5q1s69iaHuIGhLY
 dYV1UyVxeNMcLy7bimejSscSt1ErDbxbf7SM8x6IZK5RkttRUH1wzAWRRO+crPxE2plKxkRCSo
 X88hzZJmVxLUETx8lUk6ZWKIVdQKDw4KZ7X8H78r70VOqr8r0aOgSTb2CYrZa275HqgftJ5EWk
 rali4+NHZwOpa5WLM1NaZtDh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 19:57:09 -0800
IronPort-SDR: cHhjameu6/PhZwsZZD8AN74YvzjvGg4rIurpq2jXAYp8yi2rFatB2udw29HB6HKa0V0qrKzYQJ
 kOzWMKWkB0+fqVu/nRECA/MWCDehQh6IqNMSP3r52+roJip/j6vOtepYKysURtKkvBWBYYRQrR
 kcf1AdwDLiZljYs91iAun6PaAlvL4ZfAuc8XKQfMqUS01GOIvHbdQIJuJQInNNiBxj+pcQDoZX
 CCl96Ktnaon1dv6lrDGLKPn6ZY403S19dXZB3UepjijuCkrRFaR2NYuQZQtYbRk3ZnuifnJydF
 bOM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 20:12:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v10.1 23/41] btrfs: split ordered extent when bio is sent
Date:   Wed, 11 Nov 2020 13:12:11 +0900
Message-Id: <4415e35840b438c93a93776c07e93aedeb2abff1.1605067408.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <4c6d82729e000c4552fceae4a64b2a869c93eb8c.1605007036.git.naohiro.aota@wdc.com>
References: <4c6d82729e000c4552fceae4a64b2a869c93eb8c.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a zone append write, the device decides the location the data is
written to. Therefore we cannot ensure that two bios are written
consecutively on the device. In order to ensure that a ordered extent maps
to a contiguous region on disk, we need to maintain a "one bio == one
ordered extent" rule.

This commit implements the splitting of an ordered extent and extent map
on bio submission to adhere to the rule.

[testbot] made extract_ordered_extent static
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c        | 89 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.c | 76 +++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  2 +
 3 files changed, 167 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 591ca539e444..ee3f3ab1b964 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2158,6 +2158,86 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
+static int extract_ordered_extent(struct inode *inode, struct bio *bio,
+				  loff_t file_offset)
+{
+	struct btrfs_ordered_extent *ordered;
+	struct extent_map *em = NULL, *em_new = NULL;
+	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
+	u64 start = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 len = bio->bi_iter.bi_size;
+	u64 end = start + len;
+	u64 ordered_end;
+	u64 pre, post;
+	int ret = 0;
+
+	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), file_offset);
+	if (WARN_ON_ONCE(!ordered))
+		return -EIO;
+
+	/* No need to split */
+	if (ordered->disk_num_bytes == len)
+		goto out;
+
+	/* We cannot split once end_bio'd ordered extent */
+	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* We cannot split a compressed ordered extent */
+	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* We cannot split a waited ordered extent */
+	if (WARN_ON_ONCE(wq_has_sleeper(&ordered->wait))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
+	/* bio must be in one ordered extent */
+	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Checksum list should be empty */
+	if (WARN_ON_ONCE(!list_empty(&ordered->list))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pre = start - ordered->disk_bytenr;
+	post = ordered_end - end;
+
+	btrfs_split_ordered_extent(ordered, pre, post);
+
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, ordered->file_offset, len);
+	if (!em) {
+		read_unlock(&em_tree->lock);
+		ret = -EIO;
+		goto out;
+	}
+	read_unlock(&em_tree->lock);
+
+	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
+	em_new = create_io_em(BTRFS_I(inode), em->start + pre, len,
+			      em->start + pre, em->block_start + pre, len,
+			      len, len, BTRFS_COMPRESS_NONE,
+			      BTRFS_ORDERED_REGULAR);
+	free_extent_map(em_new);
+
+out:
+	free_extent_map(em);
+	btrfs_put_ordered_extent(ordered);
+
+	return ret;
+}
+
 /*
  * extent_io.c submission hook. This does the right thing for csum calculation
  * on write, or reading the csums from the tree before a read.
@@ -2192,6 +2272,15 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
 
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct page *page = bio_first_bvec_all(bio)->bv_page;
+		loff_t file_offset = page_offset(page);
+
+		ret = extract_ordered_extent(inode, bio, file_offset);
+		if (ret)
+			goto out;
+	}
+
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
 		if (ret)
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 87bac9ecdf4c..35ef25e39561 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -943,6 +943,82 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 	}
 }
 
+static void clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
+				 u64 len)
+{
+	struct inode *inode = ordered->inode;
+	u64 file_offset = ordered->file_offset + pos;
+	u64 disk_bytenr = ordered->disk_bytenr + pos;
+	u64 num_bytes = len;
+	u64 disk_num_bytes = len;
+	int type;
+	unsigned long flags_masked =
+		ordered->flags & ~(1 << BTRFS_ORDERED_DIRECT);
+	int compress_type = ordered->compress_type;
+	unsigned long weight;
+
+	weight = hweight_long(flags_masked);
+	WARN_ON_ONCE(weight > 1);
+	if (!weight)
+		type = 0;
+	else
+		type = __ffs(flags_masked);
+
+	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered->flags)) {
+		WARN_ON_ONCE(1);
+		btrfs_add_ordered_extent_compress(BTRFS_I(inode), file_offset,
+						  disk_bytenr, num_bytes,
+						  disk_num_bytes, type,
+						  compress_type);
+	} else if (test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags)) {
+		btrfs_add_ordered_extent_dio(BTRFS_I(inode), file_offset,
+					     disk_bytenr, num_bytes,
+					     disk_num_bytes, type);
+	} else {
+		btrfs_add_ordered_extent(BTRFS_I(inode), file_offset,
+					 disk_bytenr, num_bytes, disk_num_bytes,
+					 type);
+	}
+}
+
+void btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
+				u64 post)
+{
+	struct inode *inode = ordered->inode;
+	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
+	struct rb_node *node;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+	spin_lock_irq(&tree->lock);
+	/* Remove from tree once */
+	node = &ordered->rb_node;
+	rb_erase(node, &tree->tree);
+	RB_CLEAR_NODE(node);
+	if (tree->last == node)
+		tree->last = NULL;
+
+	ordered->file_offset += pre;
+	ordered->disk_bytenr += pre;
+	ordered->num_bytes -= (pre + post);
+	ordered->disk_num_bytes -= (pre + post);
+	ordered->bytes_left -= (pre + post);
+
+	/* Re-insert the node */
+	node = tree_insert(&tree->tree, ordered->file_offset,
+			   &ordered->rb_node);
+	if (node)
+		btrfs_panic(fs_info, -EEXIST,
+				"zoned: inconsistency in ordered tree at offset %llu",
+				ordered->file_offset);
+
+	spin_unlock_irq(&tree->lock);
+
+	if (pre)
+		clone_ordered_extent(ordered, 0, pre);
+	if (post)
+		clone_ordered_extent(ordered, pre + ordered->disk_num_bytes, post);
+}
+
 int __init ordered_data_init(void)
 {
 	btrfs_ordered_extent_cache = kmem_cache_create("btrfs_ordered_extent",
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index c3a2325e64a4..e346b03bd66a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -193,6 +193,8 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					u64 end,
 					struct extent_state **cached_state);
+void btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
+				u64 post);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.27.0

