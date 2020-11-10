Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003FD2AD4EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgKJL2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:33 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11959 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgKJL22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007706; x=1636543706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oZ6XJA7lr1BItXgAy0Yw153M9ql2BHRRcn4NLImZx2k=;
  b=LsdP8OA9Q8xU90M2ZwNyC0FfNJBmVWWvy43Y9qWl7NAk6yb6+SrHKWku
   7qtNJKknMGRqAXifsCPYKQ4TnoBRXtgqsFjUgTa55LVZTwGclinWv81gF
   Go71wZ4KqV9djGgIWDBR+7VCuWH9YtaNQfidhFhhUzrQTRwhcIr3t5atp
   oGt9F3KG7ifpCFau4SbjPHbMQj0jS5lEc6ELPIf3M6ZyJp7ZapkRW2QsX
   F3HLJPHFTm3TzmphBqRGf6QaHwWhlQAgI+QQPTVWFoVBgpEbDyveuHA8B
   NLizSl2SGI7E3ciMKO9IVNTSA2QIBfaudCuScM5mRX/XKqhtUW3u7Y9qB
   g==;
IronPort-SDR: DR5wlgsUITB1U3ME75tXLjW2MKqq0PHvn9S/FFnIU3j3Y3vn1X3w9vZSGWfGfIUr95HSkM4sbt
 VDGVNAcUOtCNM6iJWoLos6wEM0Xmw+6DzxymOg5o+M7MiF6+nQLt4CESdMCpGGO3CUaClJpSZY
 H5hi4JTS3l78FBOats/2C1zJMGZBDi31DNQFvZFyXE2704FAHjMM+50gEylOOw41KEzu6CYSbB
 if92vbg+W0rs88IRVvdPot1y/2L6JIHC/cbX2RzW1c1i28082PRHcVBn33g/Z8F+DdF9/SdOyO
 wLQ=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376454"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:23 +0800
IronPort-SDR: Cz5jK+WRgc6sCp1571BHSx9nwlrjcdOMPWoo7kllEmC8l4JQKju9p4bFQNioMuNDllMdxGwa3t
 8vLteGXILM7v0QsxSNxpyuOdNUxDhejdFyFwEBCg844hOemSJ/yo3v2ZwGqRlvr/ycTYQxB1LI
 hEjs+JAzfVfF0txZyf4ESNbN7f/wZfP0kpKcMKiVpF5KWXzUuU+bm+ZemUUnXsRzNHjrMBU6S1
 0fAigvD0Nig+umG6xLqnb8bHFsdc+ezr7+zglNkpk2p7yNJJybc8hPkivWpgaweIh/gJ8ANzH4
 FLphWl+/KwuBg198evvBsMqI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:24 -0800
IronPort-SDR: 6B+iP75FK+1YahDgjCdfLrEwExQnownIxE0GBrvkXLB3Ea7owSX5otWJYd6kezaRdHVdCNiHWL
 jK7tI+JbZSGh3I3PgrJRqP7gFsu2Wx6lRbHhq6UXYk3Ctw3fplWrmUHHe51ElznuoSvFfPymW/
 BjNkG9Bxia8PCb8lqCj9dnbWJow3jKjIH2bGHcP6tevDllO5pigQGe19NthKQjAnTcXXxHoCYL
 C1hNMLHNlws99fVfBhCHikaSuMOy2lGqbCDW+WboHqcb9wanbJsBhrgsD9hM8zR7vSBqukvQ2R
 400=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 11/41] btrfs: implement log-structured superblock for ZONED mode
Date:   Tue, 10 Nov 2020 20:26:14 +0900
Message-Id: <5aa30b45e2e29018e19e47181586f3f436759b69.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Superblock (and its copies) is the only data structure in btrfs which has a
fixed location on a device. Since we cannot overwrite in a sequential write
required zone, we cannot place superblock in the zone. One easy solution is
limiting superblock and copies to be placed only in conventional zones.
However, this method has two downsides: one is reduced number of superblock
copies. The location of the second copy of superblock is 256GB, which is in
a sequential write required zone on typical devices in the market today.
So, the number of superblock and copies is limited to be two.  Second
downside is that we cannot support devices which have no conventional zones
at all.

To solve these two problems, we employ superblock log writing. It uses two
zones as a circular buffer to write updated superblocks. Once the first
zone is filled up, start writing into the second buffer. Then, when the
both zones are filled up and before start writing to the first zone again,
it reset the first zone.

We can determine the position of the latest superblock by reading write
pointer information from a device. One corner case is when the both zones
are full. For this situation, we read out the last superblock of each
zone, and compare them to determine which zone is older.

The following zones are reserved as the circular buffer on ZONED btrfs.

- The primary superblock: zones 0 and 1
- The first copy: zones 16 and 17
- The second copy: zones 1024 or zone at 256GB which is minimum, and next
  to it

If these reserved zones are conventional, superblock is written fixed at
the start of the zone without logging.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |   9 ++
 fs/btrfs/disk-io.c     |  41 ++++-
 fs/btrfs/scrub.c       |   3 +
 fs/btrfs/volumes.c     |  21 ++-
 fs/btrfs/zoned.c       | 329 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  44 ++++++
 6 files changed, 435 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c0f1d6818df7..6b4831824f51 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1723,6 +1723,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 static int exclude_super_stripes(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
+	const bool zoned = btrfs_is_zoned(fs_info);
 	u64 bytenr;
 	u64 *logical;
 	int stripe_len;
@@ -1744,6 +1745,14 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 		if (ret)
 			return ret;
 
+		/* Shouldn't have super stripes in sequential zones */
+		if (zoned && nr) {
+			btrfs_err(fs_info,
+				  "zoned: block group %llu must not contain super block",
+				  cache->start);
+			return -EUCLEAN;
+		}
+
 		while (nr--) {
 			u64 len = min_t(u64, stripe_len,
 				cache->start + cache->length - logical[nr]);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e76ac4da208d..509085a368bb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3423,10 +3423,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 {
 	struct btrfs_super_block *super;
 	struct page *page;
-	u64 bytenr;
+	u64 bytenr, bytenr_orig;
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	int ret;
+
+	bytenr_orig = btrfs_sb_offset(copy_num);
+	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
+	if (ret == -ENOENT)
+		return ERR_PTR(-EINVAL);
+	else if (ret)
+		return ERR_PTR(ret);
 
-	bytenr = btrfs_sb_offset(copy_num);
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
 		return ERR_PTR(-EINVAL);
 
@@ -3440,7 +3447,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 		return ERR_PTR(-ENODATA);
 	}
 
-	if (btrfs_super_bytenr(super) != bytenr) {
+	if (btrfs_super_bytenr(super) != bytenr_orig) {
 		btrfs_release_disk_super(super);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3495,7 +3502,8 @@ static int write_dev_supers(struct btrfs_device *device,
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
-	u64 bytenr;
+	int ret;
+	u64 bytenr, bytenr_orig;
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
@@ -3507,12 +3515,21 @@ static int write_dev_supers(struct btrfs_device *device,
 		struct bio *bio;
 		struct btrfs_super_block *disk_super;
 
-		bytenr = btrfs_sb_offset(i);
+		bytenr_orig = btrfs_sb_offset(i);
+		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
+		if (ret == -ENOENT) {
+			continue;
+		} else if (ret < 0) {
+			btrfs_err(device->fs_info, "couldn't get super block location for mirror %d",
+				  i);
+			errors++;
+			continue;
+		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
 
-		btrfs_set_super_bytenr(sb, bytenr);
+		btrfs_set_super_bytenr(sb, bytenr_orig);
 
 		crypto_shash_digest(shash, (const char *)sb + BTRFS_CSUM_SIZE,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
@@ -3557,6 +3574,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			bio->bi_opf |= REQ_FUA;
 
 		btrfsic_submit_bio(bio);
+		btrfs_advance_sb_log(device, i);
 	}
 	return errors < i ? 0 : -1;
 }
@@ -3573,6 +3591,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 	int i;
 	int errors = 0;
 	bool primary_failed = false;
+	int ret;
 	u64 bytenr;
 
 	if (max_mirrors == 0)
@@ -3581,7 +3600,15 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 	for (i = 0; i < max_mirrors; i++) {
 		struct page *page;
 
-		bytenr = btrfs_sb_offset(i);
+		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
+		if (ret == -ENOENT) {
+			break;
+		} else if (ret < 0) {
+			errors++;
+			if (i == 0)
+				primary_failed = true;
+			continue;
+		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf63f1e27a27..aa1b36cf5c88 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -20,6 +20,7 @@
 #include "rcu-string.h"
 #include "raid56.h"
 #include "block-group.h"
+#include "zoned.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -3704,6 +3705,8 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(scrub_dev, bytenr))
+			continue;
 
 		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
 				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 10827892c086..db884b96a5ea 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1282,7 +1282,8 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
 }
 
 static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
-						       u64 bytenr)
+						       u64 bytenr,
+						       u64 bytenr_orig)
 {
 	struct btrfs_super_block *disk_super;
 	struct page *page;
@@ -1313,7 +1314,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 	/* align our pointer to the offset of the super block */
 	disk_super = p + offset_in_page(bytenr);
 
-	if (btrfs_super_bytenr(disk_super) != bytenr ||
+	if (btrfs_super_bytenr(disk_super) != bytenr_orig ||
 	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
 		btrfs_release_disk_super(p);
 		return ERR_PTR(-EINVAL);
@@ -1348,7 +1349,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
 	struct block_device *bdev;
-	u64 bytenr;
+	u64 bytenr, bytenr_orig;
+	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
 
@@ -1358,14 +1360,18 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	 * So, we need to add a special mount option to scan for
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
-	bytenr = btrfs_sb_offset(0);
 	flags |= FMODE_EXCL;
 
 	bdev = blkdev_get_by_path(path, flags, holder);
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
-	disk_super = btrfs_read_disk_super(bdev, bytenr);
+	bytenr_orig = btrfs_sb_offset(0);
+	ret = btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr_orig);
 	if (IS_ERR(disk_super)) {
 		device = ERR_CAST(disk_super);
 		goto error_bdev_put;
@@ -2029,6 +2035,11 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 		if (IS_ERR(disk_super))
 			continue;
 
+		if (bdev_is_zoned(bdev)) {
+			btrfs_reset_sb_log_zones(bdev, copy_num);
+			continue;
+		}
+
 		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
 
 		page = virt_to_page(disk_super);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f87d35cb9235..84ade8c19ddc 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -10,6 +10,9 @@
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
 
+/* Number of superblock log zones */
+#define BTRFS_NR_SB_LOG_ZONES 2
+
 static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
 			     void *data)
 {
@@ -20,6 +23,106 @@ static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
 	return 0;
 }
 
+static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
+			    u64 *wp_ret)
+{
+	bool empty[BTRFS_NR_SB_LOG_ZONES];
+	bool full[BTRFS_NR_SB_LOG_ZONES];
+	sector_t sector;
+
+	ASSERT(zones[0].type != BLK_ZONE_TYPE_CONVENTIONAL &&
+	       zones[1].type != BLK_ZONE_TYPE_CONVENTIONAL);
+
+	empty[0] = (zones[0].cond == BLK_ZONE_COND_EMPTY);
+	empty[1] = (zones[1].cond == BLK_ZONE_COND_EMPTY);
+	full[0] = (zones[0].cond == BLK_ZONE_COND_FULL);
+	full[1] = (zones[1].cond == BLK_ZONE_COND_FULL);
+
+	/*
+	 * Possible state of log buffer zones
+	 *
+	 *   E I F
+	 * E * x 0
+	 * I 0 x 0
+	 * F 1 1 C
+	 *
+	 * Row: zones[0]
+	 * Col: zones[1]
+	 * State:
+	 *   E: Empty, I: In-Use, F: Full
+	 * Log position:
+	 *   *: Special case, no superblock is written
+	 *   0: Use write pointer of zones[0]
+	 *   1: Use write pointer of zones[1]
+	 *   C: Compare SBs from zones[0] and zones[1], use the newer one
+	 *   x: Invalid state
+	 */
+
+	if (empty[0] && empty[1]) {
+		/* Special case to distinguish no superblock to read */
+		*wp_ret = zones[0].start << SECTOR_SHIFT;
+		return -ENOENT;
+	} else if (full[0] && full[1]) {
+		/* Compare two super blocks */
+		struct address_space *mapping = bdev->bd_inode->i_mapping;
+		struct page *page[BTRFS_NR_SB_LOG_ZONES];
+		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
+		int i;
+
+		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+			u64 bytenr = ((zones[i].start + zones[i].len) << SECTOR_SHIFT) -
+				BTRFS_SUPER_INFO_SIZE;
+
+			page[i] = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
+			if (IS_ERR(page[i])) {
+				if (i == 1)
+					btrfs_release_disk_super(super[0]);
+				return PTR_ERR(page[i]);
+			}
+			super[i] = page_address(page[i]);
+		}
+
+		if (super[0]->generation > super[1]->generation)
+			sector = zones[1].start;
+		else
+			sector = zones[0].start;
+
+		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++)
+			btrfs_release_disk_super(super[i]);
+	} else if (!full[0] && (empty[1] || full[1])) {
+		sector = zones[0].wp;
+	} else if (full[0]) {
+		sector = zones[1].wp;
+	} else {
+		return -EUCLEAN;
+	}
+	*wp_ret = sector << SECTOR_SHIFT;
+	return 0;
+}
+
+/*
+ * The following zones are reserved as the circular buffer on ZONED btrfs.
+ *  - The primary superblock: zones 0 and 1
+ *  - The first copy: zones 16 and 17
+ *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
+ *    next to it
+ */
+static inline u32 sb_zone_number(u8 shift, int mirror)
+{
+	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
+
+	switch (mirror) {
+	case 0:
+		return 0;
+	case 1:
+		return 16;
+	case 2:
+		return min(btrfs_sb_offset(mirror) >> shift, 1024ULL);
+	}
+
+	return 0;
+}
+
 static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 			       struct blk_zone *zones, unsigned int *nr_zones)
 {
@@ -122,6 +225,52 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		goto out;
 	}
 
+	/* Validate superblock log */
+	nr_zones = BTRFS_NR_SB_LOG_ZONES;
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		u32 sb_zone = sb_zone_number(zone_info->zone_size_shift, i);
+		u64 sb_wp;
+		int sb_pos = BTRFS_NR_SB_LOG_ZONES * i;
+
+		if (sb_zone + 1 >= zone_info->nr_zones)
+			continue;
+
+		sector = sb_zone << (zone_info->zone_size_shift - SECTOR_SHIFT);
+		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,
+					  &zone_info->sb_zones[sb_pos],
+					  &nr_zones);
+		if (ret)
+			goto out;
+
+		if (nr_zones != BTRFS_NR_SB_LOG_ZONES) {
+			btrfs_err_in_rcu(device->fs_info,
+			 "zoned: failed to read super block log zone info at devid %llu zone %u",
+					 device->devid, sb_zone);
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		/*
+		 * If zones[0] is conventional, always use the beggining of
+		 * the zone to record superblock. No need to validate in
+		 * that case.
+		 */
+		if (zone_info->sb_zones[BTRFS_NR_SB_LOG_ZONES * i].type ==
+		    BLK_ZONE_TYPE_CONVENTIONAL)
+			continue;
+
+		ret = sb_write_pointer(device->bdev,
+				       &zone_info->sb_zones[sb_pos], &sb_wp);
+		if (ret != -ENOENT && ret) {
+			btrfs_err_in_rcu(device->fs_info,
+				"zoned: super block log zone corrupted devid %llu zone %u",
+					 device->devid, sb_zone);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
+
 	kfree(zones);
 
 	device->zone_info = zone_info;
@@ -304,3 +453,183 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 
 	return 0;
 }
+
+static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
+			   int rw, u64 *bytenr_ret)
+{
+	u64 wp;
+	int ret;
+
+	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
+		return 0;
+	}
+
+	ret = sb_write_pointer(bdev, zones, &wp);
+	if (ret != -ENOENT && ret < 0)
+		return ret;
+
+	if (rw == WRITE) {
+		struct blk_zone *reset = NULL;
+
+		if (wp == zones[0].start << SECTOR_SHIFT)
+			reset = &zones[0];
+		else if (wp == zones[1].start << SECTOR_SHIFT)
+			reset = &zones[1];
+
+		if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
+			ASSERT(reset->cond == BLK_ZONE_COND_FULL);
+
+			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
+					       reset->start, reset->len,
+					       GFP_NOFS);
+			if (ret)
+				return ret;
+
+			reset->cond = BLK_ZONE_COND_EMPTY;
+			reset->wp = reset->start;
+		}
+	} else if (ret != -ENOENT) {
+		/* For READ, we want the precious one */
+		if (wp == zones[0].start << SECTOR_SHIFT)
+			wp = (zones[1].start + zones[1].len) << SECTOR_SHIFT;
+		wp -= BTRFS_SUPER_INFO_SIZE;
+	}
+
+	*bytenr_ret = wp;
+	return 0;
+
+}
+
+int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
+			       u64 *bytenr_ret)
+{
+	struct blk_zone zones[BTRFS_NR_SB_LOG_ZONES];
+	unsigned int zone_sectors;
+	u32 sb_zone;
+	int ret;
+	u64 zone_size;
+	u8 zone_sectors_shift;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	u32 nr_zones;
+
+	if (!bdev_is_zoned(bdev)) {
+		*bytenr_ret = btrfs_sb_offset(mirror);
+		return 0;
+	}
+
+	ASSERT(rw == READ || rw == WRITE);
+
+	zone_sectors = bdev_zone_sectors(bdev);
+	if (!is_power_of_2(zone_sectors))
+		return -EINVAL;
+	zone_size = zone_sectors << SECTOR_SHIFT;
+	zone_sectors_shift = ilog2(zone_sectors);
+	nr_zones = nr_sectors >> zone_sectors_shift;
+
+	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	if (sb_zone + 1 >= nr_zones)
+		return -ENOENT;
+
+	ret = blkdev_report_zones(bdev, sb_zone << zone_sectors_shift,
+				  BTRFS_NR_SB_LOG_ZONES, copy_zone_info_cb,
+				  zones);
+	if (ret < 0)
+		return ret;
+	if (ret != BTRFS_NR_SB_LOG_ZONES)
+		return -EIO;
+
+	return sb_log_location(bdev, zones, rw, bytenr_ret);
+}
+
+int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
+			  u64 *bytenr_ret)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u32 zone_num;
+
+	if (!zinfo) {
+		*bytenr_ret = btrfs_sb_offset(mirror);
+		return 0;
+	}
+
+	zone_num = sb_zone_number(zinfo->zone_size_shift, mirror);
+	if (zone_num + 1 >= zinfo->nr_zones)
+		return -ENOENT;
+
+	return sb_log_location(device->bdev,
+			       &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror],
+			       rw, bytenr_ret);
+}
+
+static inline bool is_sb_log_zone(struct btrfs_zoned_device_info *zinfo,
+				  int mirror)
+{
+	u32 zone_num;
+
+	if (!zinfo)
+		return false;
+
+	zone_num = sb_zone_number(zinfo->zone_size_shift, mirror);
+	if (zone_num + 1 >= zinfo->nr_zones)
+		return false;
+
+	if (!test_bit(zone_num, zinfo->seq_zones))
+		return false;
+
+	return true;
+}
+
+void btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	struct blk_zone *zone;
+
+	if (!is_sb_log_zone(zinfo, mirror))
+		return;
+
+	zone = &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror];
+	if (zone->cond != BLK_ZONE_COND_FULL) {
+
+		if (zone->cond == BLK_ZONE_COND_EMPTY)
+			zone->cond = BLK_ZONE_COND_IMP_OPEN;
+
+		zone->wp += (BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT);
+
+		if (zone->wp == zone->start + zone->len)
+			zone->cond = BLK_ZONE_COND_FULL;
+
+		return;
+	}
+
+	zone++;
+	ASSERT(zone->cond != BLK_ZONE_COND_FULL);
+	if (zone->cond == BLK_ZONE_COND_EMPTY)
+		zone->cond = BLK_ZONE_COND_IMP_OPEN;
+
+	zone->wp += (BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT);
+
+	if (zone->wp == zone->start + zone->len)
+		zone->cond = BLK_ZONE_COND_FULL;
+}
+
+int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
+{
+	sector_t zone_sectors;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	u8 zone_sectors_shift;
+	u32 sb_zone;
+	u32 nr_zones;
+
+	zone_sectors = bdev_zone_sectors(bdev);
+	zone_sectors_shift = ilog2(zone_sectors);
+	nr_zones = nr_sectors >> zone_sectors_shift;
+
+	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	if (sb_zone + 1 >= nr_zones)
+		return -ENOENT;
+
+	return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
+				sb_zone << zone_sectors_shift,
+				zone_sectors * BTRFS_NR_SB_LOG_ZONES, GFP_NOFS);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 81c00a3ed202..de9d7dd8c351 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 #include <linux/blkdev.h>
+#include "volumes.h"
+#include "disk-io.h"
 
 struct btrfs_zoned_device_info {
 	/*
@@ -17,6 +19,7 @@ struct btrfs_zoned_device_info {
 	u32 nr_zones;
 	unsigned long *seq_zones;
 	unsigned long *empty_zones;
+	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
 };
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -26,6 +29,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
+int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
+			       u64 *bytenr_ret);
+int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
+			  u64 *bytenr_ret);
+void btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
+int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -54,6 +63,30 @@ static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 	return 0;
 }
 
+static inline int btrfs_sb_log_location_bdev(struct block_device *bdev,
+					     int mirror, int rw,
+					     u64 *bytenr_ret)
+{
+	*bytenr_ret = btrfs_sb_offset(mirror);
+	return 0;
+}
+
+static inline int btrfs_sb_log_location(struct btrfs_device *device, int mirror,
+					int rw, u64 *bytenr_ret)
+{
+	*bytenr_ret = btrfs_sb_offset(mirror);
+	return 0;
+}
+
+static inline void btrfs_advance_sb_log(struct btrfs_device *device,
+					int mirror) { }
+
+static inline int btrfs_reset_sb_log_zones(struct block_device *bdev,
+					   int mirror)
+{
+	return 0;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -121,4 +154,15 @@ static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
 	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
 }
 
+static inline bool btrfs_check_super_location(struct btrfs_device *device,
+					      u64 pos)
+{
+	/*
+	 * On a non-zoned device, any address is OK. On a zoned device,
+	 * non-SEQUENTIAL WRITE REQUIRED zones are capable.
+	 */
+	return device->zone_info == NULL ||
+	       !btrfs_dev_is_sequential(device, pos);
+}
+
 #endif
-- 
2.27.0

