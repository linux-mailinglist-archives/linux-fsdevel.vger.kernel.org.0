Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCD2F7344
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbhAOG7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:59:11 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41718 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbhAOG7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693949; x=1642229949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LfckCAVDVP6Zc1h7kEer9kYo+23V2IzuMdtgT95Ez00=;
  b=Mi2ziEypUstcjvinp0464vBkqCTxuzrOIkiF/JCn6HuUDcJomVONxmXg
   me52KtphvjmSlhvVsGmOfyOIgfOYA/sewe7+wiD4iczLI14c2cOgQkKr6
   l5AWPGXbvJPFQKqWRWJdqE+bg7ApLF556zsh3jMV6k+ge+z3L4y3h6yg2
   aoUVThdSuC3NPhkMxMp1uMNRmBSJIn2yc3oowf38Zf/Le2CaG+ESh8agW
   htJWyYffErlrHlujMxCVdz1Z81JwWfCNdorZY04n/clvJ3v+rX77/FjBF
   V0PkU6sbKZP/CEPawON4Fzp/IqDLtoY0aNqjcGTsdyqZ4H6WdXZKhhWVs
   g==;
IronPort-SDR: R1ubPIdrsvYLn7S6kThhPdX8MWoXyWY/3NsFZ5Y2qNfdXId/rfy/1LQ9afQL70YhQLCNNrDmUe
 s0Oie2m5HcODgQgylQ8cqrxg57xF2nDgpBv4q58yXlwudGhvktmRLB7RvlWAEXsuu/d7OR6RBT
 kVvbVqGmFOFy9CBb84TxrcO/e3GfyY0Pux1LFU2cU7Wt5SQ2NOLLhUuxY5JUcx79wKnM8WUWLu
 sKjkykmlFlrthyNiUuK93S4uKmzhNUVc9nS/sGrhWgjhECYQv1Gl9ggLMgYC1pmS25WlmNp54q
 n0E=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928270"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:49 +0800
IronPort-SDR: AESoyod5LascMI9Myjfk806hnpdGHWyaNt0Jy/OF3sHBmLFP5wdtBiojX1Yr/bCMeyrrqINOgd
 rIgadgev426OaJx6qt5kNxkYN1UV79xcYtcUgZZj0SwN3/NKIEAlBIL1KEtbDoxhMMlFdrImWe
 2/uG1A0kcMuQfEqqFVmQJZqBD/tCBD2NNgib6oOV9ZCBmk7Dwa+/ZsMECbd64JmGdXAaKeXfRW
 AEC5G3De509As1TIOGHq5lo7Pexvw4TfkD6tMg8x29pgouZwfwLjWetdPsQ6oNgYXEeBQNQHTL
 I5wt+2sC2Ur1gklbO8oKLyRv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:31 -0800
IronPort-SDR: KtBhbmrpp/jOBToy1yPiWWhhZl4+o/fohWPPs2UggIlgc5oNs2Aa55u+XhLeOkLkKYwjXL/ij4
 T4i27pVJiS7ar5pDwQjaCY8GfU3jRB56SrVMd4Fkrxq17rcVXDP1w8iRl6CziNmykYPMRU8k9W
 QAJL61C84PBE7wjL40aFwbzpmDl7VWS8POjvHikBCpr68iR1jspC58QEqPVtqb3WYmp/5OlSgt
 hVe1mSpK66BRITtCiay0OP/CEmY7zdCaRDcqjpw7wbYlltjZXL73VG0GJ5mHIRm8BaXlxoxM4j
 9xc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:48 -0800
Received: (nullmailer pid 1916464 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v12 22/41] btrfs: split ordered extent when bio is sent
Date:   Fri, 15 Jan 2021 15:53:26 +0900
Message-Id: <cb83b82d8a837a4293435157844606307227a128.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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
 fs/btrfs/inode.c        | 91 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.c | 85 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  2 +
 3 files changed, 178 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 37782b4cfd28..4df5900dd197 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2217,6 +2217,88 @@ static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
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
@@ -2252,6 +2334,15 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
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
index 79d366a36223..6e4ffb3861e7 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -898,6 +898,91 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
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
index 0bfa82b58e23..2ff238b78eda 100644
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

