Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A596D2AD500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgKJL2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12009 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbgKJL2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007722; x=1636543722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/awjwcguPNehCkzUxeqKOKxd1bHu539Hs6ykxdiN6Co=;
  b=qZuwAD9ngFRRWE6bGcyFL2PiDTxCW1hwfZ3KKEToCe8x94pujBlEqnNT
   XBoOQ5YDnYenGZa3fyffmHIxznRlcP/8Yu+NFvECdrDWLHOH7FdkW9idh
   /cINC7JS5zKN7+ir2V46X/XXM7OW3ITzqMew2PzmPSoA9tiy0jfWNpr3b
   miy4Cx+4nQwmsUTx8ldrTKx1+KAgqA2uhFEe6TlJ1AHBLngdm6TEH+t8v
   yf4XC8jlToRcgtoPMskVS917UHt5qTktHAtG+uyn5fWHdTkzd+ri2ZGGG
   9Wj1gWxMfhXvTkfPkMPO/UqpHGgiqVGNENIY+A1nL9vVZz1GYXqsqWWhr
   w==;
IronPort-SDR: 4Saj9jdsEDqjzg/SxhUIf63GunzsWUvUg75bTsMcOfbrzly8a94te1ka4ykcxEqDDeOiorN2GA
 fInVSSiMQpVvHdb5gfMJ3CdOhMtEZdk/lLWChh4uC53tCeBo5czXkdu/PE1MbxJTb8makwVoPm
 RD/KpyuDw3WoHuI9MCVVwzgal1LE3O7GfsYEd9luWrBCKGPRwvZrzgxdIkXiMI0/5F+56zuv7X
 moObdQWSdN+lpqPVxR32OBySIN/wBDyBWBBj/z9Nl7BsMv3mbKbs9vA5hQ+W6mcM/6+45yyHHo
 9wM=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376571"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:42 +0800
IronPort-SDR: SB7R1iVPAaSg2poCHX/kzzVJwP7q+j74QsV8ZsWOmQT+7fs960sTKIKt91qDk3/+16q39zbnzt
 m0UhvnWVlsiXh2PjEO9G+iMYn3B+s8kG3EUNR37+sfh5cZr+undWWt33zss5JEtApQrbitn177
 j0skg4Q1jiRzdcM+/NRL7B6w4y3R3K/q3W6gxZRwSsqtkhIui/vzKGtPpXA2/iUuAT5kvMsnF+
 8ncHGQt1XXb/6utRzGqfABCBW21eoJ1Peh2DvreHydl6kPtZQjBfNJbZ8dB8gctfqmowDbB4Ls
 L/Egzw0qMGtBj0EgJfhCP0ao
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:43 -0800
IronPort-SDR: XOfvAHvO7a+D5bX5A4aI4Nd1qA5z+g0d1ng90DK26yvljDmX0+gmcNPArvPh5q2KwnTH+qVzYF
 qMPfRT4Edchbabxzk9/0l9GH7ljhOsHg/U5MTp5ffsEnCVUUi4owIMkeiYAQSk0UIZT60i8uHp
 nc2viLRKGUDcnn4ghQmLM5bBWYxlgol6DZJxG/yOuIIYEr0kpeo5fiIOIzO+24hzlfnJAEcr2M
 1dRqlvujj39rUt1I8QlUYa5/DWdEydTZSSA9H6NkUGAR+b/BmWdNrdQW1Ffd+t4HAtUpQ2vJ8Y
 VMI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:42 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 23/41] btrfs: split ordered extent when bio is sent
Date:   Tue, 10 Nov 2020 20:26:26 +0900
Message-Id: <4c6d82729e000c4552fceae4a64b2a869c93eb8c.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c        | 89 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.c | 76 +++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  2 +
 3 files changed, 167 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 591ca539e444..df85d8dea37c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2158,6 +2158,86 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
+int extract_ordered_extent(struct inode *inode, struct bio *bio,
+			   loff_t file_offset)
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

