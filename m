Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8422D2E0511
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgLVDyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:54:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46436 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgLVDyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609277; x=1640145277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZPXNzG0U93Slup/YL94VuSnNANiIyriRuqgV+FyhWdk=;
  b=dGJUjR4OZjQU8Te2Aq6WqiJeKS71aUMZX/YrWIxWWkg1Cd5nBf4zbbn3
   6+5ECt14sXn0fd7gv2N5n3kqWwKPO3tHgRAEcY8yzW+Hmc0a/JUG/KWUe
   EGJYaogz7HZHI+dWw3nSdWvzVYEuhWVY2Kwc5NI92OcvUqmKWVKsUpUNz
   Ox9ZcNsQWJuEPuUL8YyJBvM6ttFlAhRrNW68YrHXlboQFCO3vYChLmet6
   XqzNbk6bkdhIaIhilOGJxuJU9ABng5k1KrjihSDYYUyGHHezl1XPsSoBK
   e0tn0uO3jKSoXb2aW/oKYO2mZVGPXS8/wE1IKEPTpy35KDoGzDj/sWxxK
   A==;
IronPort-SDR: 4phThRdXx9U1DLwoLavYhMbbz8MCiwAUfILtFMIkAP0yVQNErf7z1iwpe4YVZtDvm2lE4noLr7
 2P2QmbMYsFiG9jY2OljttRKmwyjHIGqO99xT8BIoCi9l9mkDsdKuZ90SX8IxvhC/k8tWPcKa/r
 Smq9/q7jWMF4xdELNAEbmLAl97Ym5AstUaQbDSds93EYoyeM9BPSHo1kkilyYXaSZH4huu5UB2
 Yq6xNQ0VziX97qm1SKyYv8pFRE4bJ2iVTcI2dJuVbRhtdNIpBb8B+3YdarnIjD4y1qXQT24cVd
 Rcc=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193814"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:04 +0800
IronPort-SDR: KkAajbTiooSHNy18sLBf2pHOX9C3SAoxU7Kh4tUIkMLS1mxGxQkxwnYeurXSZYgXQ8R7J/DDG7
 j6lBhXzl3zAjVDXU4ERGixKyYOysizjPOJDe1gbIaNFFFX25ixHjwoFjCXQII3V4Xh0q3Xg0mv
 AKZXAs8zaa9cMzNPkFjSL3ZLVFExmHaSsjBGihWAXyDL5oD0IidkdMrXQj16NttnqJ5VU0Rtaf
 pttQ36DgqdcDOf0Bv76VAP+w2M4kFz9o/upBTjoW7dFp+gKXjiC4ySYyGvF40bA54WmkVtUF0W
 VBGecg1NcehHoIFghqcSY2oT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:15 -0800
IronPort-SDR: SdmTzsSstStzVAhL2dc8M/7vjj5wFAhAMVWEWalzru8oZXANMo3YQStGERcawjbLIlvb+g1wab
 POCWE2N9MZe4nfPsMIqbeL/fadHDOzG7CiZqyIUHpbPak0iRRqebg6JfU0Ci2/bIzfC/7av+Mi
 r78YC/WiunMjlAufmkTdEMPpPsKzT2PnUam5UB4AWx+S31faQELtvjlMfxtkSkow4tqY/T/Zus
 wy16rIc8SB0EP2sveovkXsyTkz47JGim8O991VTK36iRSYx6z8P8+95hBhB4NoCsueZj68Riyp
 zWY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:03 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v11 25/40] btrfs: use ZONE_APPEND write for ZONED btrfs
Date:   Tue, 22 Dec 2020 12:49:18 +0900
Message-Id: <7f7891de68acb153cb8b56747e2f38362f5f4d7a.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
index d59b13f7ddcf..0cffb6901e58 100644
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
@@ -3579,6 +3585,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	size_t blocksize;
 	int ret = 0;
 	int nr = 0;
+	int opf = REQ_OP_WRITE;
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
@@ -3625,6 +3632,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		offset = em->block_start + extent_offset;
 		block_start = em->block_start;
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+		if (btrfs_use_zone_append(inode, em))
+			opf = REQ_OP_ZONE_APPEND;
 		free_extent_map(em);
 		em = NULL;
 
@@ -3651,7 +3660,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
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
index 15e0c7714c7f..0ca5b6c9f0ef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -50,6 +50,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2828,6 +2829,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	bool clear_reserved_extent = true;
 	unsigned int clear_bits = EXTENT_DEFRAG;
 
+	if (ordered_extent->disk)
+		btrfs_rewrite_logical_zoned(ordered_extent);
+
 	start = ordered_extent->file_offset;
 	end = start + ordered_extent->num_bytes - 1;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4f8f48e7a482..db3797bc8bb5 100644
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
index f9964276f85f..6fdf44a2dea9 100644
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
index 322396ac3f8e..d2b86aa1fc72 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6521,6 +6521,21 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
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
index 72735e948b6e..a4def29e7851 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1217,3 +1217,71 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
 
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

