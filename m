Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC32A06F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgJ3NxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22003 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgJ3NxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065985; x=1635601985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=02M8HP7ut5Il9mNyWYYOoNBBrENfs4CDnW9YNkJqdJ4=;
  b=L2Fh3LZtbFcY35cycLlBoduGDao4t7lmnhO72UZimxJMTAzqqhGwbqTM
   qPKRdksWcOlGoRnAnSKSyVpwW99/8tqdFyYq352jxO11pTNXE1NXDOQWb
   jdll4FTekoh8BDyhz5KHCG6azNoGu+9PvjEmc+bgksiRqj9gFRljBCuhg
   dB3YjXHt506/9ObRbfIWhKXyZD7wMNMTd/hf8Q8NbMV5SbBhtMz6RYZ3Z
   +7FYAMvc8Mnt6gnwUntbFmyNQ5xUBRhquCs6DHKzvfbMToxDmAE9+mUTq
   ZCkTaH35/VWx9B2Me/5n56YV8xC4akS8Te3YJAE7D89J0vHyF6/72wh3/
   g==;
IronPort-SDR: OKlmIT53tuQ5QBthkVaQ6f1PMuEKH/dQ0dIlkP2OhrVyfII0hIuGa8jvWKg8kXbiHZqZThO5pJ
 SUA/vMvyRVa1FXDDTRFuXLmEkp9qmUwwOZ69hSu/GI+Z5wcbtrlISJ/UsGC8ooY+um4HJQ3UGo
 Fs2xjwxWG6fn7SWcmpQBMw9nuVY+e5s/kG8GIhsvnwvpYUdkar2AJ3ihYIHTYgjCen+PkKvcOo
 rqvywC7i99PGPSTOB9OFCHNDY/4LW2y0MFPutahZ9aZLZSFZWJehpH99Ghwq7ztWvs83CxOpZX
 7Us=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806626"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:52 +0800
IronPort-SDR: TUFh+eITbAr5wggl+YHTwbxAkQBIe487YZlcsykrb/IOkOaVwr+6ahAjVFJ6ZAQXyunzvOz5vu
 Kud3zQ5oDI2UrG7k6gz9OwsURmhUvVCT2UtrGGbBuoGvATJ4siSsnFf1HIJ25aR3ctUTC7BENS
 A8yHNq1C8SggitJA73iVuxeej9gKIfrLbLcLhDgeKHkIGL9dvfqeHGTlqk5X9E2MrYK7dvH6sY
 mow4LZzrrRVI8C2cenia/hTYVUgqzkhWUIvKMzKJo9eRTM5lOHM19ZmxG3Kep+jo2gJKFIhxf6
 ktlhrQR5oY6IAJmImEdt6Eti
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:06 -0700
IronPort-SDR: vx8hBVEygsN9YhWD4Zsn8Uk7R6WPiwWJ8zknEOTDFOqW0WZ9J26xy+Qc8HVzqnM+RlXvXWynVz
 1hTwVsLMXUyYwfcTIiVeo3z8vbZORjZcPZCODIdWvfqbdJEfFiogTYR0BxqTS/FlEnY0l/h6kW
 8f/HZsZTPEQ1cj4TdHFYPYaV2VaQLJZmjnUuC+Hjl8Aa4eGVeF85fqvNBQbcgBUlKoLUcXgDfx
 RESmxqtGGs/UYXn2ItHp/kPUAmgCBSXWcO9/EFHyUERasAlMRLJDvzGEj9X2L/NsCt919ZlLbS
 EBE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:51 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v9 25/41] btrfs: use ZONE_APPEND write for ZONED btrfs
Date:   Fri, 30 Oct 2020 22:51:32 +0900
Message-Id: <51cdc96d68f84eb93a310a96b6b7ad6e070dd1ac.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent_io.c    | 12 +++++++-
 fs/btrfs/file.c         |  2 +-
 fs/btrfs/inode.c        |  4 +++
 fs/btrfs/ordered-data.c |  3 ++
 fs/btrfs/ordered-data.h |  8 +++++
 fs/btrfs/volumes.c      |  9 ++++++
 fs/btrfs/zoned.c        | 68 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h        |  9 ++++++
 8 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 764257eb658f..3f49febafc69 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2743,6 +2743,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 	u64 start;
 	u64 end;
 	struct bvec_iter_all iter_all;
+	bool first_bvec = true;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -2769,6 +2770,11 @@ static void end_bio_extent_writepage(struct bio *bio)
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
@@ -3531,6 +3537,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	size_t blocksize;
 	int ret = 0;
 	int nr = 0;
+	int opf = REQ_OP_WRITE;
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
@@ -3543,6 +3550,9 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
+	if (btrfs_is_zoned(inode->root->fs_info))
+		opf = REQ_OP_ZONE_APPEND;
+
 	/*
 	 * we don't want to touch the inode after unlocking the page,
 	 * so we update the mapping writeback index now
@@ -3603,7 +3613,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			       page->index, cur, end);
 		}
 
-		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
+		ret = submit_extent_page(opf | write_flags, wbc,
 					 page, offset, iosize, pg_offset,
 					 &epd->bio,
 					 end_bio_extent_writepage,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 68938a43081e..f41cdcbf44f5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2226,7 +2226,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * the current transaction commits before the ordered extents complete
 	 * and a power failure happens right after that.
 	 */
-	if (full_sync) {
+	if (full_sync || fs_info->zoned) {
 		ret = btrfs_wait_ordered_range(inode, start, len);
 	} else {
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6b2569dfc3bd..6d40affa833f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -51,6 +51,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2676,6 +2677,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	bool clear_reserved_extent = true;
 	unsigned int clear_bits;
 
+	if (ordered_extent->disk)
+		btrfs_rewrite_logical_zoned(ordered_extent);
+
 	start = ordered_extent->file_offset;
 	end = start + ordered_extent->num_bytes - 1;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 28fb9d5f48d3..b2d185d4479e 100644
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
index e346b03bd66a..084c609afd83 100644
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
index a0056b205964..26669007d367 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6498,6 +6498,15 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	btrfs_io_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
+	/*
+	 * For zone append writing, bi_sector must point the beginning of the
+	 * zone
+	 */
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		u64 zone_start = round_down(physical, fs_info->zone_size);
+
+		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
+	}
 	btrfs_debug_in_rcu(fs_info,
 	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		bio_op(bio), bio->bi_opf, (u64)bio->bi_iter.bi_sector,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b45ca33282d9..50393d560c9a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1052,3 +1052,71 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	}
 	spin_unlock(&trans->releasing_ebs_lock);
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
+	if (WARN_ON(__btrfs_rmap_block(fs_info, orig_logical, bdev,
+				       ordered->physical, &logical, &nr,
+				       &stripe_len)))
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
index 845623932fa5..d3ed4d7dae2b 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -44,6 +44,9 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio);
+void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -113,6 +116,12 @@ static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
 static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
+static inline void btrfs_record_physical_zoned(struct inode *inode,
+					       u64 file_offset, struct bio *bio)
+{
+}
+static inline void
+btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

