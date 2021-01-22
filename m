Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38BE2FFCC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhAVG3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:29:48 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51100 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbhAVG1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296838; x=1642832838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epcoJ9topUwoUj4xUUSEMGJ4qhHq6hU1NLqjTwOrDRw=;
  b=WuCHRjRJ138/6kXAc9HTzx674pl0TBKhMsTOk18B+EnbGtk09rxKxx7X
   wRWFvrszMxlAl9zqabNX8QO5aTB8bhHT7vYjvnTWpIx0otWnE1WQilbWz
   Sso9/ix/vsVFLi+peV17Yu6XNdee2eSlWRZbZn5Morh0ziqOns/UzH+ua
   se0sEW6gPCEnEjbBkhwwhT9ynGlmLRX1hCzUfmRHqLoJnC3zHFxpI9m5k
   2L3H4p7fNNEfAzwvd4gkldyxUd7EAnR5/SGnjc9CZszVA3tj7aAGFtke8
   CMYJmcKGrhdwuSI0w4GNcaberjkgV6ByxBSL2IaZSWCAWwyTjN2IYI2iw
   A==;
IronPort-SDR: pyJu//5oobF3W/xgZ+s42JX8JFdWY9SGqNAx7xOk5UkUlHGgdowW7M8sfDfI93aukIZQFWR8PG
 mu4U/pr0sDLAEbwdSvRj6idaVHecSSDKZ2wEkZVmAeMWWqSO/qIskFPlFbdVgEnaQUX/Ei5GZJ
 tsSVVmvGjLvik5ChoIK+uUrnwOtzi7kfGf61WoOk90V0UHHtf6U3fjzb+4+n7T5qbIazx8Bk82
 s87yTsu2s5LpnAbz8wq/MfdlPlsaBkS7bUtcZaQZ2bt3NaFiW98e0lmxunlbgpcb/hB3H9l4g5
 O4c=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392029"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:05 +0800
IronPort-SDR: dRuN+BhCVOLDvowO7r/+0vEmCluqe5Lg7mTzMEkYi8TFodiLkSkRfu2Zkr+rkGiZk1/ea9SNnl
 I5BVcoLXE8GHCUWuUFq3F20BXvTuQtazWq18862d4MQDTOjdfd0LWznbA9eRYNDA2YoMJTYMs8
 8iPSSbYWfZTLSUONWEyZIaymls67ISh4G23VLoEEY6/BsuCPjUdsAaaC7mMonMG7npPxMWE1Vp
 3j4lX4UZsCDQlqyyy0VnvDVHH0Ez7Mqf+cqCtOhLnkYANdNTYxJq4ZjQmTgLN2dAvA+QrrnSWg
 GpNsFffMel3/Nsb7+9K503Ed
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:37 -0800
IronPort-SDR: MgCtGmXx8ZSruxuAypVkPN9v1+jqqCar92BvIyCy4H36WpJV6dd8yLJYbwR70InnAp98/YfCEs
 DJKKtmaATVlroPh73f61SD/124jV21O1QwOVoXupsH9GvCn0HE9gmqaE6qfqSBhR7SePSAneBE
 JtcEkcdzxK+fwWJYCBnb/J854xwPl9oVw1JOlfhgg8IinpopWegZkRfjcfvN/4VgZewLGv58iU
 ZCGD+RDyZAg6zF0R9s1A5UaGPuSoUqs8+uyykFAKp2ppnDvh2PrUKBe/ApFJdfUlmwThZu/qYL
 R2U=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:04 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v13 27/42] btrfs: use ZONE_APPEND write for ZONED btrfs
Date:   Fri, 22 Jan 2021 15:21:27 +0900
Message-Id: <3ce68f36407d9aa3665c5d5b444382650a6e1967.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit enables zone append writing for zoned btrfs. When using zone
append, a bio is issued to the start of a target zone and the device
decides to place it inside the zone. Upon completion the device reports
the actual written position back to the host.

Three parts are necessary to enable zone append in btrfs. First, modify
the bio to use REQ_OP_ZONE_APPEND in btrfs_submit_bio_hook() and adjust
the bi_sector to point the beginning of the zone.

Secondly, records the returned physical address (and disk/partno) to the
ordered extent in end_bio_extent_writepage() after the bio has been
completed. We cannot resolve the physical address to the logical address
because we can neither take locks nor allocate a buffer in this end_bio
context. So, we need to record the physical address to resolve it later in
btrfs_finish_ordered_io().

And finally, rewrites the logical addresses of the extent mapping and
checksum data according to the physical address (using __btrfs_rmap_block).
If the returned address matches the originally allocated address, we can
skip this rewriting process.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c    | 15 +++++++--
 fs/btrfs/file.c         |  6 +++-
 fs/btrfs/inode.c        |  4 +++
 fs/btrfs/ordered-data.c |  3 ++
 fs/btrfs/ordered-data.h |  8 +++++
 fs/btrfs/volumes.c      | 15 +++++++++
 fs/btrfs/zoned.c        | 73 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h        | 12 +++++++
 8 files changed, 133 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b9fefa624760..e0d212fd5678 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2733,6 +2733,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 	u64 start;
 	u64 end;
 	struct bvec_iter_all iter_all;
+	bool first_bvec = true;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -2759,6 +2760,11 @@ static void end_bio_extent_writepage(struct bio *bio)
 		start = page_offset(page);
 		end = start + bvec->bv_offset + bvec->bv_len - 1;
 
+		if (first_bvec) {
+			btrfs_record_physical_zoned(inode, start, bio);
+			first_bvec = false;
+		}
+
 		end_extent_writepage(page, error, start, end);
 		end_page_writeback(page);
 	}
@@ -3581,6 +3587,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	struct extent_map *em;
 	int ret = 0;
 	int nr = 0;
+	int opf = REQ_OP_WRITE;
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
@@ -3627,6 +3634,10 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 		/* Note that em_end from extent_map_end() is exclusive */
 		iosize = min(em_end, end + 1) - cur;
+
+		if (btrfs_use_zone_append(inode, em))
+			opf = REQ_OP_ZONE_APPEND;
+
 		free_extent_map(em);
 		em = NULL;
 
@@ -3652,8 +3663,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			       page->index, cur, end);
 		}
 
-		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 page, disk_bytenr, iosize,
+		ret = submit_extent_page(opf | write_flags, wbc, page,
+					 disk_bytenr, iosize,
 					 cur - page_offset(page), &epd->bio,
 					 end_bio_extent_writepage,
 					 0, 0, 0, false);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d81ae1f518f2..eaa1e473e75e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2174,8 +2174,12 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * commit waits for their completion, to avoid data loss if we fsync,
 	 * the current transaction commits before the ordered extents complete
 	 * and a power failure happens right after that.
+	 *
+	 * For zoned btrfs, if a write IO uses a ZONE_APPEND command, the
+	 * logical address recorded in the ordered extent may change. We
+	 * need to wait for the IO to stabilize the logical address.
 	 */
-	if (full_sync) {
+	if (full_sync || btrfs_is_zoned(fs_info)) {
 		ret = btrfs_wait_ordered_range(inode, start, len);
 	} else {
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 286eee122657..c67bfe9a8434 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -50,6 +50,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2878,6 +2879,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
+	if (ordered_extent->disk)
+		btrfs_rewrite_logical_zoned(ordered_extent);
+
 	btrfs_free_io_failure_record(inode, start, end);
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 538378fe0853..e39744a14f0a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -199,6 +199,9 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
+	entry->physical = (u64)-1;
+	entry->disk = NULL;
+	entry->partno = (u8)-1;
 	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
 		set_bit(type, &entry->flags);
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 3bf2f62fce5c..a74c459bbfac 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -127,6 +127,14 @@ struct btrfs_ordered_extent {
 	struct completion completion;
 	struct btrfs_work flush_work;
 	struct list_head work_list;
+
+	/*
+	 * used to reverse-map physical address returned from ZONE_APPEND
+	 * write command in a workqueue context.
+	 */
+	u64 physical;
+	struct gendisk *disk;
+	u8 partno;
 };
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e69754af2eba..4cb5e940356e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6507,6 +6507,21 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	btrfs_io_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
+	/*
+	 * For zone append writing, bi_sector must point the beginning of the
+	 * zone
+	 */
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		if (btrfs_dev_is_sequential(dev, physical)) {
+			u64 zone_start = round_down(physical,
+						    fs_info->zone_size);
+
+			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
+		} else {
+			bio->bi_opf &= ~REQ_OP_ZONE_APPEND;
+			bio->bi_opf |= REQ_OP_WRITE;
+		}
+	}
 	btrfs_debug_in_rcu(fs_info,
 	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d026257a43a9..aa158735a1e6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1252,3 +1252,76 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
 
 	return ret;
 }
+
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio)
+{
+	struct btrfs_ordered_extent *ordered;
+	u64 physical = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
+	if (bio_op(bio) != REQ_OP_ZONE_APPEND)
+		return;
+
+	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), file_offset);
+	if (WARN_ON(!ordered))
+		return;
+
+	ordered->physical = physical;
+	ordered->disk = bio->bi_disk;
+	ordered->partno = bio->bi_partno;
+
+	btrfs_put_ordered_extent(ordered);
+}
+
+void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
+{
+	struct extent_map_tree *em_tree;
+	struct extent_map *em;
+	struct inode *inode = ordered->inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_ordered_sum *sum;
+	struct block_device *bdev;
+	u64 orig_logical = ordered->disk_bytenr;
+	u64 *logical = NULL;
+	int nr, stripe_len;
+
+	/*
+	 * Zoned devices should not have partitions. So, we can assume it
+	 * is 0.
+	 */
+	ASSERT(ordered->partno == 0);
+	bdev = bdgrab(ordered->disk->part0);
+	if (WARN_ON(!bdev))
+		return;
+
+	if (WARN_ON(btrfs_rmap_block(fs_info, orig_logical, bdev,
+				     ordered->physical, &logical, &nr,
+				     &stripe_len)))
+		goto out;
+
+	WARN_ON(nr != 1);
+
+	if (orig_logical == *logical)
+		goto out;
+
+	ordered->disk_bytenr = *logical;
+
+	em_tree = &BTRFS_I(inode)->extent_tree;
+	write_lock(&em_tree->lock);
+	em = search_extent_mapping(em_tree, ordered->file_offset,
+				   ordered->num_bytes);
+	em->block_start = *logical;
+	free_extent_map(em);
+	write_unlock(&em_tree->lock);
+
+	list_for_each_entry(sum, &ordered->list, list) {
+		if (*logical < orig_logical)
+			sum->bytenr -= orig_logical - *logical;
+		else
+			sum->bytenr += *logical - orig_logical;
+	}
+
+out:
+	kfree(logical);
+	bdput(bdev);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 92888eb86055..cf420964305f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -47,6 +47,9 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em);
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio);
+void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -139,6 +142,15 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
 {
 	return false;
 }
+
+static inline void btrfs_record_physical_zoned(struct inode *inode,
+					       u64 file_offset, struct bio *bio)
+{
+}
+
+static inline void btrfs_rewrite_logical_zoned(
+				struct btrfs_ordered_extent *ordered) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

