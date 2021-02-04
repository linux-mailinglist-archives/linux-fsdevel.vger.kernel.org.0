Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55830F0B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhBDK1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:27:14 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54276 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbhBDK1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434419; x=1643970419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KolP6sIqJFiajal3qZFLebkQx5lIkXWZXRORVj0y+lg=;
  b=jmqlWXStDRgwOPiuMQGZTz/HfAKJ7TOPPz1mgDNQS6rGvtFd4C1AR8rQ
   D7ZosI5O87SSUzET1PTZhLqN4O33mWLp/RdT5DcbiuKemlAYOaCmxNUWV
   XPBKDyryobPkRf+2vxtQQOhiidU4WdRHtXdD80TZuIW4BEAy1FD/KviXt
   6mB8Jtm/8TsGuyZCy1q4AEOHfEljskRsijssZ3wLcdfS1B8pVzOvMwrn9
   cGkBwEzNF6FgRnj+gUjE4a34IqoiCqyQZE6vEKH53HgcG1dZ1OWCsGv0+
   kmN2X2eAGj2pW+YybjohqToHmA/dJrb0hOyRo1dz9iOf0Qe/E8RdXN0ZM
   Q==;
IronPort-SDR: cy0hqFnE0CHhhvyI4ipSbsRku5eJIicmFGd65YbzXp/0yyuWkRBQNYHKzq69N0rpnH3W5gLckj
 Z5N/yaClyvJeZYgF0KCWf2mGv7OSWqKk/omAbbkgJochyT8YmTbo8Fj9H87U+38THjxSCnT0KS
 BEBFhYp0w4nivjdCS+7qwHzz2Uq5ieg1naD84vD9uazb/p+uojyrQJb+RdUpd+LLlueP4ydi86
 S/8/hcA27q/ypV4XmRZ+5yFwGuTfCRtE5sHAt4wnFTVGcfqcj99GaTpPA4mEMUyk36mZ4MMrje
 Sns=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108015"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:24 +0800
IronPort-SDR: saTF6oQlzqcFnpV3yvy9zAf3nJY6i9MQ8NARWDtUxEnEDILf2FaaOmbGaKQeLDuSXMf5/NcP+i
 sHWRW6l1gewXv7KycHrhiaX2igZEhbZPfQQPtIKbCxv0HptMV9Jqu8xhVzmEMu+jRyPW0XLBLO
 wmZPLC6/Iqn6QqqhuwyicaHNtQkNynx6yBMEtShwZJIW/O1UpGym/jfgflNvlbrGzDSNxvgjUY
 etcAubY/Vku+BM6bM/0reGmUhFFhdMFpffN9qm4FkDVZ+/GmJxmbTFFgGMqpcQ+mZ1+eFOiBtc
 +r7Zxy2AJqaaMnEMjcq4Zpo3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:27 -0800
IronPort-SDR: /h9jjG196lsNf5GxjuxgOTPsA3GQPACoDUlIYjLmPktxnVwzWl6ETAUXda0eXsSKEovTkDm0Ou
 eJlV2pj8mFs0FOlXWZiuB2TMhAiFsuPpQzeLgT7GdUbAjogo/l/XGvaZdiD+/iwn/8hW3+EqEB
 2FHOad2zoZiBTv9qtLbmqiK70W9ERkX2olLND6YeKWAe2QCvShwbWpIX7OpMnF9MPpIE/paOKv
 6e+bHV3c+ZtoiLN0jW9DCevhuZHJXCckQx4uRCnxg4CZdKixaW4khMEatFCXH9S5k+w6idQBlj
 Ki8=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:23 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 21/42] btrfs: zoned: split ordered extent when bio is sent
Date:   Thu,  4 Feb 2021 19:22:00 +0900
Message-Id: <333ff02fff5aa3133b1bfe0eccc3806d3032b0c9.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a zone append write, the device decides the location the data is being
written to. Therefore we cannot ensure that two bios are written
consecutively on the device. In order to ensure that an ordered extent
maps to a contiguous region on disk, we need to maintain a "one bio ==
one ordered extent" rule.

Implement splitting of an ordered extent and extent map on bio submission
to adhere to the rule.

extract_ordered_extent() hooks into btrfs_submit_data_bio() and splits the
corresponding ordered extent so that the ordered extent's region fits into
one bio and the corresponding device limits.

Several sanity checks need to be done in extract_ordered_extent() e.g.

- We cannot split once end_bio'd ordered extent because we cannot divide
  ordered->bytes_left for the split ones
- We do not expect a compressed ordered extent
- We should not have checksum list because we omit the list splitting.
  Since the function is called before btrfs_wq_submit_bio() or
  btrfs_csum_one_bio(), this sholud be always ensured.

We also need to split an extent map by creating a new one. If not,
unpin_extent_cache() complains about the difference between the start of
the extent map and the file's logical offset.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c        | 95 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.c | 78 +++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  2 +
 3 files changed, 175 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d7a9c770dc3b..750482a06d67 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2215,6 +2215,92 @@ static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
+static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
+					   struct bio *bio, loff_t file_offset)
+{
+	struct btrfs_ordered_extent *ordered;
+	struct extent_map *em = NULL, *em_new = NULL;
+	struct extent_map_tree *em_tree = &inode->extent_tree;
+	u64 start = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 len = bio->bi_iter.bi_size;
+	u64 end = start + len;
+	u64 ordered_end;
+	u64 pre, post;
+	int ret = 0;
+
+	ordered = btrfs_lookup_ordered_extent(inode, file_offset);
+	if (WARN_ON_ONCE(!ordered))
+		return BLK_STS_IOERR;
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
+	ret = btrfs_split_ordered_extent(ordered, pre, post);
+	if (ret)
+		goto out;
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
+	/*
+	 * We cannot reuse em_new here but have to create a new one, as
+	 * unpin_extent_cache() expects the start of the extent map to be the
+	 * logical offset of the file, which does not hold true anymore after
+	 * splitting.
+	 */
+	em_new = create_io_em(inode, em->start + pre, len,
+			      em->start + pre, em->block_start + pre, len,
+			      len, len, BTRFS_COMPRESS_NONE,
+			      BTRFS_ORDERED_REGULAR);
+	if (IS_ERR(em_new)) {
+		ret = PTR_ERR(em_new);
+		goto out;
+	}
+	free_extent_map(em_new);
+
+out:
+	free_extent_map(em);
+	btrfs_put_ordered_extent(ordered);
+
+	return errno_to_blk_status(ret);
+}
+
 /*
  * extent_io.c submission hook. This does the right thing for csum calculation
  * on write, or reading the csums from the tree before a read.
@@ -2250,6 +2336,15 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
 
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct page *page = bio_first_bvec_all(bio)->bv_page;
+		loff_t file_offset = page_offset(page);
+
+		ret = extract_ordered_extent(BTRFS_I(inode), bio, file_offset);
+		if (ret)
+			goto out;
+	}
+
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
 		if (ret)
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e8dee1578d4a..2dc707f02f00 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -920,6 +920,84 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 	}
 }
 
+static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
+				u64 len)
+{
+	struct inode *inode = ordered->inode;
+	u64 file_offset = ordered->file_offset + pos;
+	u64 disk_bytenr = ordered->disk_bytenr + pos;
+	u64 num_bytes = len;
+	u64 disk_num_bytes = len;
+	int type;
+	unsigned long flags_masked = ordered->flags & ~(1 << BTRFS_ORDERED_DIRECT);
+	int compress_type = ordered->compress_type;
+	unsigned long weight;
+	int ret;
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
+		ret = btrfs_add_ordered_extent_compress(BTRFS_I(inode),
+				file_offset, disk_bytenr, num_bytes,
+				disk_num_bytes, compress_type);
+	} else if (test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags)) {
+		ret = btrfs_add_ordered_extent_dio(BTRFS_I(inode), file_offset,
+				disk_bytenr, num_bytes, disk_num_bytes, type);
+	} else {
+		ret = btrfs_add_ordered_extent(BTRFS_I(inode), file_offset,
+				disk_bytenr, num_bytes, disk_num_bytes, type);
+	}
+
+	return ret;
+}
+
+int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
+				u64 post)
+{
+	struct inode *inode = ordered->inode;
+	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
+	struct rb_node *node;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	int ret = 0;
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
+	node = tree_insert(&tree->tree, ordered->file_offset, &ordered->rb_node);
+	if (node)
+		btrfs_panic(fs_info, -EEXIST,
+			"zoned: inconsistency in ordered tree at offset %llu",
+			    ordered->file_offset);
+
+	spin_unlock_irq(&tree->lock);
+
+	if (pre)
+		ret = clone_ordered_extent(ordered, 0, pre);
+	if (post)
+		ret = clone_ordered_extent(ordered, pre + ordered->disk_num_bytes,
+					   post);
+
+	return ret;
+}
+
 int __init ordered_data_init(void)
 {
 	btrfs_ordered_extent_cache = kmem_cache_create("btrfs_ordered_extent",
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index cca3307807e8..c400be75a3f1 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -201,6 +201,8 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					u64 end,
 					struct extent_state **cached_state);
+int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
+			       u64 post);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.30.0

