Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D902F734C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbhAOG7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:59:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41699 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbhAOG7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693974; x=1642229974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9q+ZrrqpzILsI7/cUu1g9dMj4Qx2Rm+ZlOOskHzjCws=;
  b=G316UuQr/F4X1Ztt+3EqAcG365w9lKAq7mfSehZeQFYlr4Tu+dv/SZVT
   RZBlgV7VQdP3OLgCioTbQKVe7x0tJsbIiuwkM+TOWRsn6myn+URtBKfWV
   iAhRcvrcFOr89ACXq0uW7B2uv33LRnTLkkxnrle2IwjjxcTjhDoRJlWoT
   1GByGbJsxg/4MPkntuffi3RPfw9vHmgxZzVY6bKGMPRLA44/zXZTMRxvh
   fCD8iQgKr66QCw40TwQXMrCoJtlYIgIyZHwuA7LQlIGpf9zDYRe8+7rmR
   o4Bht3F4ZNPrTeHO0bH2nprO9F17zmcqhVq/GVIdKnFi9QDsvJwQZbbTm
   A==;
IronPort-SDR: ITAynqIWugoQ7w7BLDmxtl0Xbeymu8jzwjkD0YxPvYlX6HNH34vRhMnaO+6qWpzAF5NIgtaRkT
 suaULQ5+Phmk1Fuu981sVUbY7q8mlIXAbc4YSa5L/o7OMszJ57GUzc2IFfkeNmBqW8PXHedxmb
 f2DOWywW6XujubHvwcloxK/YvZ/9H6h1CfrV93D3whyBKnchcVL/5vyDWrDQnrh2wX3cHWYd/u
 CGDPq+X1nrrKR+y3mfUHfwrJ9TzWO/NhazJyHpyf545qVWbOjcZvFzfhXcORjC5xwRRKxOYnGW
 1T0=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928282"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:57 +0800
IronPort-SDR: hRUVq9OKcmaR03V1JqU1A6zJ1gJWh/mrpznd8zixKq2II74p0fevtq5p9lo4rHXOQvUoVm5xnp
 Gl3ZaJyBy9ViPSrKHovvXPKHgYMpsXT4IrVG2lWDTxZW/tQIoOGluue8xtm985yGEmsfrEeD7b
 dUK7xpJ6LpNIS/PY6WZwa6JSZC39Xj7vEJQJL635KAbNn7vVOMfkfiw5t2D1GDRMinjWuP3m+i
 hp0YMsOJPVrxsbG5s0qmRcNq/mM0zMPteS1LWPLaTWrlfSqk+Y2sNJP3sZIgIwpG+4U7OxN4+z
 0qR1M6tfywgfbMFDm525Nx7v
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:39 -0800
IronPort-SDR: roxMngERzAAEkN7k8U0Stu/hd+BSHCIRXCmGf3oZOaaJafw+8xK1emh7dCri2X1d35aF43YMn9
 DGT+GS+7shpYlYFmngHPa5D7FW9wuZzcrSyapN/9p7eO6Z07wR32RqijkrtoV0Y5UytNOMkN7C
 MaFZiyWg874Ai5HLNT5NJfVb8z83u4vsUQ0WltTk3XkVIv82ej1zFV0aQOtWv8XPmy/ykAFE9B
 6HJvJURYQQhF3EbCuhYsZyXvuh49s7xylafqceDHigfZVUJtj4rxXeju5bWoGiABJFPFLsila6
 o+4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:56 -0800
Received: (nullmailer pid 1916472 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v12 26/41] btrfs: use ZONE_APPEND write for ZONED btrfs
Date:   Fri, 15 Jan 2021 15:53:30 +0900
Message-Id: <69bc6601a2c82457f5f7e40744d6dbebd328e958.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c    | 11 ++++++-
 fs/btrfs/file.c         |  2 +-
 fs/btrfs/inode.c        |  4 +++
 fs/btrfs/ordered-data.c |  3 ++
 fs/btrfs/ordered-data.h |  8 +++++
 fs/btrfs/volumes.c      | 15 +++++++++
 fs/btrfs/zoned.c        | 68 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h        | 12 ++++++++
 8 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 41fccfbaee15..214b330dc490 100644
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
@@ -3580,6 +3586,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	size_t blocksize;
 	int ret = 0;
 	int nr = 0;
+	int opf = REQ_OP_WRITE;
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
@@ -3626,6 +3633,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		offset = em->block_start + extent_offset;
 		block_start = em->block_start;
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+		if (btrfs_use_zone_append(inode, em))
+			opf = REQ_OP_ZONE_APPEND;
 		free_extent_map(em);
 		em = NULL;
 
@@ -3652,7 +3661,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			       page->index, cur, end);
 		}
 
-		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
+		ret = submit_extent_page(opf | write_flags, wbc,
 					 page, offset, iosize, pg_offset,
 					 &epd->bio,
 					 end_bio_extent_writepage,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e65223e3510d..5c120d8d060d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2176,7 +2176,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * the current transaction commits before the ordered extents complete
 	 * and a power failure happens right after that.
 	 */
-	if (full_sync) {
+	if (full_sync || btrfs_is_zoned(fs_info)) {
 		ret = btrfs_wait_ordered_range(inode, start, len);
 	} else {
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4df5900dd197..6b5f273a0d83 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -50,6 +50,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2830,6 +2831,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	bool clear_reserved_extent = true;
 	unsigned int clear_bits = EXTENT_DEFRAG;
 
+	if (ordered_extent->disk)
+		btrfs_rewrite_logical_zoned(ordered_extent);
+
 	start = ordered_extent->file_offset;
 	end = start + ordered_extent->num_bytes - 1;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 5c0df39d0503..ac1f9fd348eb 100644
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
index 2ff238b78eda..635c398a173f 100644
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
index 5752cc470158..c8c94e5081eb 100644
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
index fed014211f32..6d11081fde7d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1252,3 +1252,71 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
 
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
+	bdev = bdget_disk(ordered->disk, ordered->partno);
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

