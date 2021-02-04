Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE42830F0BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhBDK3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:29:25 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54296 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhBDK1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434463; x=1643970463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fsauJOpb526VofpGQha169pb7Izr+PSkvRzwONpQEzo=;
  b=YwPrqQVnecv8FSTt9GyC0qAwmqgxr7c6zZXdQCRfqoQF/+az1znDxrmU
   fLXeFzzkuqB8YrraHDIpsg22jwIBfvrcLFdLK4xVfG9N9wQcKfLSjVGVJ
   adyJafsV4mYknd7MCGrbECjetUqpEW30KHUYAqU07F21hBsjpL7ZpxIQ6
   rOx8gwk57Ume2mPQl9NU+uuHyirP/6QR0+7ytCfxKWzg8g4+xszDRdDBh
   fEIRxBOOnM9kblbFegqn6wrsWbiw+PtPwRNxIF5mpB7Zgr3iZOBPtidfi
   qLCNS/rhrLobdc5d/pFhZ9D3JRwvmLbcZ1/kzKPXeqNyVoaNBdlzT/fAC
   g==;
IronPort-SDR: XUAj6/eh/+ZBNmyfg3ME3S0tjhXMD/uxgFEFIQVCtvHv+ZJu3Ln8w+dej6JqUlOvpG/5aCVTrn
 o9VGp5/SvXppXCU5tt/uhAxUtW8HlbRzxuiFf143Xs/9aBdfaw3ow9rYbi6zSaXxhDlmKJqcHH
 b+p6GESyMMBAdGQs0yawcqCWw4ZbXf21PpLz2jKQf6R3HpGf/UMMV02h0gPXRLUjgVkEr8iPsA
 BElKoK3fqHEG2At271jZaoi9wDAjfVkIFjw0nkLwIDQD8scP2w+VcMLtMUX7lmi4tGsPQ0BHhy
 w8s=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108035"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:32 +0800
IronPort-SDR: DF87ztK29XbVFDl67bMr9ugk75H35fmH2QukOvK9bmXhkIFiq2L3X9GV4A92912WLFImefxtLc
 fp3tKQltTKcHnIIOcy5PTh9nyrq69ZzcDoNdwM+S8jSiX609IKDfnNRpps/5ZaAAlrcqPPNS7z
 4l6QBWNM0GtqQ9VjBO6iIS8V/QCHBudRMB9lXK2DQGOt6ghqiKSUktUOyKpJZvEm4koCAfuis7
 vZIro/EnZjUjW4zYYaZN4Gru8vjA6Fb3bpYdF1ysidj11Z9yKNk65VnKyP6kccY7BP5kzFW/OA
 pJVqa+idG2Y8BUYP8nwk2AP+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:35 -0800
IronPort-SDR: 7P6jW0Qkjvaklp2CiGXBfTTu9LlqEY013Tyg/lcLsbiR4bKPKLV8xbRyi7ASXBdJgq7rj4sD20
 a87p0/YfbAUPGWB6C1p5djRIuLAKKTBFbW2c/zesW+DxzNi0W3HpTPRtbJtB09t1aQMVJRfJzN
 dRf2aHKT4IB5wDub/WJ7AfgLNP5jFC9PpSUdTgrXrY8+slCYstUyCmVl0S6oT/wWl1c0tEF/50
 PKq9LGFexSAAF//UAfaxll/KJLsoB9jiBbV+EZpkmXMqgdudRNz/QBCXLhWi/gO3a/C+BHE8tX
 qHc=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:30 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 26/42] btrfs: zoned: use ZONE_APPEND write for zoned btrfs
Date:   Thu,  4 Feb 2021 19:22:05 +0900
Message-Id: <722508271fd7a4873f59f4470237ad41a78a8bf6.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
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

Secondly, record the returned physical address (and disk/partno) to the
ordered extent in end_bio_extent_writepage() after the bio has been
completed. We cannot resolve the physical address to the logical address
because we can neither take locks nor allocate a buffer in this end_bio
context. So, we need to record the physical address to resolve it later in
btrfs_finish_ordered_io().

And finally, rewrites the logical addresses of the extent mapping and
checksum data according to the physical address using btrfs_rmap_block.
If the returned address matches the originally allocated address, we can
skip this rewriting process.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c    | 15 +++++++--
 fs/btrfs/file.c         |  6 +++-
 fs/btrfs/inode.c        |  4 +++
 fs/btrfs/ordered-data.c |  3 ++
 fs/btrfs/ordered-data.h |  8 +++++
 fs/btrfs/volumes.c      | 14 ++++++++
 fs/btrfs/zoned.c        | 73 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h        | 12 +++++++
 8 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 72b1a23d17f9..4c186a5f9efa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2735,6 +2735,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 	u64 start;
 	u64 end;
 	struct bvec_iter_all iter_all;
+	bool first_bvec = true;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -2761,6 +2762,11 @@ static void end_bio_extent_writepage(struct bio *bio)
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
@@ -3665,6 +3671,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	struct extent_map *em;
 	int ret = 0;
 	int nr = 0;
+	int opf = REQ_OP_WRITE;
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
@@ -3711,6 +3718,10 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 		/* Note that em_end from extent_map_end() is exclusive */
 		iosize = min(em_end, end + 1) - cur;
+
+		if (btrfs_use_zone_append(inode, em))
+			opf = REQ_OP_ZONE_APPEND;
+
 		free_extent_map(em);
 		em = NULL;
 
@@ -3736,8 +3747,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
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
index 5a54f78faed5..0152524599e6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2168,8 +2168,12 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * commit waits for their completion, to avoid data loss if we fsync,
 	 * the current transaction commits before the ordered extents complete
 	 * and a power failure happens right after that.
+	 *
+	 * For zoned filesystem, if a write IO uses a ZONE_APPEND command, the
+	 * logical address recorded in the ordered extent may change. We need
+	 * to wait for the IO to stabilize the logical address.
 	 */
-	if (full_sync) {
+	if (full_sync || btrfs_is_zoned(fs_info)) {
 		ret = btrfs_wait_ordered_range(inode, start, len);
 	} else {
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 31545e503b9e..6dbab9293425 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -50,6 +50,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2874,6 +2875,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
+	if (ordered_extent->disk)
+		btrfs_rewrite_logical_zoned(ordered_extent);
+
 	btrfs_free_io_failure_record(inode, start, end);
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index fe235ab935d3..985a21558437 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -199,6 +199,9 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
+	entry->physical = (u64)-1;
+	entry->disk = NULL;
+	entry->partno = (u8)-1;
 
 	ASSERT(type == BTRFS_ORDERED_REGULAR ||
 	       type == BTRFS_ORDERED_NOCOW ||
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index c400be75a3f1..99e0853e4d3b 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -139,6 +139,14 @@ struct btrfs_ordered_extent {
 	struct completion completion;
 	struct btrfs_work flush_work;
 	struct list_head work_list;
+
+	/*
+	 * Used to reverse-map physical address returned from ZONE_APPEND write
+	 * command in a workqueue context
+	 */
+	u64 physical;
+	struct gendisk *disk;
+	u8 partno;
 };
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 400375aaa197..a4d47c6050f7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6500,6 +6500,20 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	btrfs_io_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
+	/*
+	 * For zone append writing, bi_sector must point the beginning of the
+	 * zone
+	 */
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		if (btrfs_dev_is_sequential(dev, physical)) {
+			u64 zone_start = round_down(physical, fs_info->zone_size);
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
index f6c68704c840..050aea447332 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1247,3 +1247,76 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
 
 	return ret;
 }
+
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio)
+{
+	struct btrfs_ordered_extent *ordered;
+	const u64 physical = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
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
index 14d578328cbe..04f7b21652b6 100644
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
@@ -139,6 +142,15 @@ static inline bool btrfs_use_zone_append(struct btrfs_inode *inode,
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
2.30.0

