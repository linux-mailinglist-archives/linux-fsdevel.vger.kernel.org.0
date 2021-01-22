Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8133F2FFCA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbhAVG0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:26:53 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51039 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbhAVG0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296790; x=1642832790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x9xVk1qfO5sKEHjzVtilwbPyG0KageDh5Su97jQ96XI=;
  b=mS2UMUTXOX2gD6/yi9927+JlVmKDClXxEEZwIpFnq7wFklVER8nbz16g
   +TLIUFM4N9H639rVdYguP5lr+nTrP/xHLvn5YI5vSqoc5kfREIBFNxBPV
   06XcNO5rTICkQBjT3ijg/OELlyElqvSEbSzmvLIvYhbuH8O3Wa38gzxku
   5hFsm23LZbOZHeLXaEvn8CYLxNIVlCcYmeoxCQAKZIx4MNCfhfgcsPBcA
   LOk9Uy6jcHm2UCGnB7L8ZzHts3TLa6wA91Jmmh+LnSeDncIVJJDtLLwEH
   8uN7pKDiSOS28xB5086aYlX0Ej9FbD/QM3SfFlCJZTqL4FWBqEDQdRpDk
   Q==;
IronPort-SDR: TqKhS2AKmRbowWncQUVu29kQORqi0PiJ8TpYE7QyzjaXQVkXtJ5G+4hdMYw7az+x319Mco4U+s
 Tpjkvwhv8azlTt9tKkbzs3f7nD/kAyQ1XnFSJoK7nM5BY9siqI0MO2Kry4DoX/FEFs68x7i6Ls
 GJcxNNQRRvwinzgEvoqA9QVsh99A1HPnZcTQIMyP8xKDQWZJ9UDVvjgEubTU9v63cmhPPka3Dw
 tiaXXcIChA5hK003s09gQxmRBbMyu6YdJUDUyriDgYzsIwjC1fbaHJJ2ua3+4EClD0Sv8R9q3c
 BQA=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392013"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:57 +0800
IronPort-SDR: C2f1APWRGfN2zZsreHS21upmG5lTGryoJB5+3VTJA8gm1dBlOnhTRuzsodRNpMAiG8BGfNkYPI
 5DqeuwZQibcb7bbwXr83KZ69pBbIEHeewHQ1CUcmsq/XACbR/sTaJpD4DQREEW9ltdNaRal+yu
 thnmkpVmpUu2srSFQCVAr0PQbjqfmG4pT8G+xviZRxDXrJWdHQfveD6Ln7iGdUA9D+TSoLFh88
 avEZXLEczAQG3RdYys/o/BtcAWvkD7qXvGILuyfKWcevIGYYjcpOCG7pKzKohRHgSnMyh6LtPY
 UGC1EqOMUHu+LPhczbF7jsXH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:29 -0800
IronPort-SDR: /h3SnWcpEP14V/Or/6p16T0mXXD/MJ38FJRoJNCiB1xMFC6lcOH6uDconDxQwO7owu7Egamm0v
 fsLCiiBDImeos+G9vtVuesIH6feFZaPtoggOPRGcvmJhrtlVzs7tICQnbBdqgGBfROCqO2MuYA
 un+dYpmJhB5s9cPH8PWJmHlQfcd0SHfyetVeb5qhKz4c6SGoKOdcthfIGUgijW7EOMQC4Wg2j9
 i9flXYYYDtimes4q8UasRY1/hmKLPTVuaqJ/f1FaD9MaeJ8jAiV8/I7K5ahwNmvXAJffddXJIa
 uLk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:56 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v13 22/42] btrfs: split ordered extent when bio is sent
Date:   Fri, 22 Jan 2021 15:21:22 +0900
Message-Id: <25b86d9571b1af386f1711d0d0ae626ae6a86b35.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
 fs/btrfs/inode.c        | 95 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.c | 85 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  2 +
 3 files changed, 182 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e1c1f37b3f6..ab97d4349515 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2217,6 +2217,92 @@ static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
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
@@ -2252,6 +2338,15 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
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
index d5d326c674b1..4dd935d602b8 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -910,6 +910,91 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
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
+	unsigned long flags_masked =
+		ordered->flags & ~(1 << BTRFS_ORDERED_DIRECT);
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
+							file_offset,
+							disk_bytenr, num_bytes,
+							disk_num_bytes, type,
+							compress_type);
+	} else if (test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags)) {
+		ret = btrfs_add_ordered_extent_dio(BTRFS_I(inode), file_offset,
+						   disk_bytenr, num_bytes,
+						   disk_num_bytes, type);
+	} else {
+		ret = btrfs_add_ordered_extent(BTRFS_I(inode), file_offset,
+					       disk_bytenr, num_bytes,
+					       disk_num_bytes, type);
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
+		ret = clone_ordered_extent(ordered, 0, pre);
+	if (post)
+		ret = clone_ordered_extent(ordered,
+					   pre + ordered->disk_num_bytes,
+					   post);
+
+	return ret;
+}
+
 int __init ordered_data_init(void)
 {
 	btrfs_ordered_extent_cache = kmem_cache_create("btrfs_ordered_extent",
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 46194c2c05d4..3bf2f62fce5c 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -190,6 +190,8 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					u64 end,
 					struct extent_state **cached_state);
+int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
+			       u64 post);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.27.0

