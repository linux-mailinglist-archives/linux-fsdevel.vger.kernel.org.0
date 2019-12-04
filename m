Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B600A112463
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLDITo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:44 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32758 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfLDITj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447580; x=1606983580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GmDmouJEcBAkjoHoXOkAiNFj2vkL83uf+AHWFskaApM=;
  b=VPXJcux6cvmSHCk2QwmQwgYQQ7Ga1n7g8LUKOxzn/PUGmP4JKkttj17V
   Zh+mjsUC131BmoyPFNHJDofntu7TVbEI4kIvK7WWoHJy8rmSm0Sj3ikKv
   qLjpm/rivez72pVNFJcBs85QMXVUvJ/CiaA48dQw+bbrP2H23lRK04w++
   LW5dHQYmS0LMJ7UgaUBPemwtcLL+mCglGefpwze/mBWHZT5MJGUzjyAME
   jC70CAw/FGav1H4Jli9tUqDMdqB2Or22+E2VOg3D0qiWTzh/37jXrfXBK
   CjsXKlu5XMvjRGyvey5WD5Dgx9ftHEiL81DcGf/zvXjKMI5nHGyBrIcyr
   Q==;
IronPort-SDR: p2wqKvnp5O3qM0ArAUJsedU7RJGhNuDy6zByf1h/6QBNFIg+H4h5lLtErmUGnlQw8X3eLJyHfZ
 8HVILa79DIFC4VsuJkLmBJ2fI1abjLJwGXJcMJQtPbR3VUhwI+QhqQ4boX7vIJ+ibPD9LEXirO
 rm61TlLa8NCDVjjpHlzc/E9hNGjysVvIGMPBYHN5cW0z3KqpDoo+00BevUeHOoTcEYqOFMEeXH
 D6eH+D/4hVenAESFtTpARaZDIBClvfPk8LhDbwkcmAAvwW93domCTZfErpEeDm/Xjw5arQerM5
 8fs=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355052"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:39 +0800
IronPort-SDR: cttNUQuWn+qTkihR6DHA8ibEWkBuuEjiRoN4dR+Z1SEI+5G+xXvCPLZU9G7IkUGx6Xhk/PTbZv
 zL8rwmmMO3TeFGEr+D1b82KWrEOl9ZD+ZWJjbP3kWKtnnSfcBy+YLIF5jEmU3Zu1xpWc9HxQui
 nmYLqKYB7TG0dZa3c6M2UNlJBX4ISrq6NvXrEcO/Maqcu4qY5P7t9AxQoTHmiTiEp1dgjNblYr
 sJI9ai75/Y9AWdOIJbmVrUoYg2+5gekDRh4KNigNfMIpAL5Ol4SUZNVk/yeTSAvDDRtC903naM
 9yPHhtWqkmYyLq+6PL1Wn9/s
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:04 -0800
IronPort-SDR: /7/V/WviIAEjdR81zpYZ+u0Y/7+a7w1NcyzdXp9FYnxDJjyCjnZtWkkeg7YMIe+ClqfB5Ue65B
 V17NwbHU3SeWwuhP3MMSobGDZqMYrdW75csDKd+9OyaFsUwwHVeIzAKN4/OjhNjXTEMAt8yKcO
 8YLgBTdUXMKpOuFYsCLckyzMbBAaUf/vaRJzg6A4TC4uksNAgyZgB6QoOIoqqEWTCBzOHK+tgB
 cO76jaPg+tgxrkzNM5CweZc8rn/33EN3/GbIBMXvqlkyDEqvGyoXjBhYSzLleVvlou9ABxPvJy
 fPs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:36 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 08/28] btrfs: implement log-structured superblock for HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:15 +0900
Message-Id: <20191204081735.852438-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
zone is filled up, start writing into the second zone and reset the first
one. We can determine the postion of the latest superblock by reading write
pointer information from a device.

The following zones are reserved as the circular buffer on HMZONED btrfs.

- The primary superblock: zones 0 and 1
- The first copy: zones 16 and 17
- The second copy: zones 1024 or zone at 256GB which is minimum, and next
  to it

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |   9 ++
 fs/btrfs/disk-io.c     |  19 ++-
 fs/btrfs/hmzoned.c     | 276 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h     |  40 ++++++
 fs/btrfs/scrub.c       |   3 +
 fs/btrfs/volumes.c     |  18 ++-
 6 files changed, 354 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6934a5b8708f..acfa0a9d3c5a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1519,6 +1519,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 static int exclude_super_stripes(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
+	bool hmzoned = btrfs_fs_incompat(fs_info, HMZONED);
 	u64 bytenr;
 	u64 *logical;
 	int stripe_len;
@@ -1549,6 +1550,14 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 			if (logical[nr] + stripe_len <= cache->start)
 				continue;
 
+			/* shouldn't have super stripes in sequential zones */
+			if (hmzoned) {
+				btrfs_err(fs_info,
+		"sequentil allocation bg %llu should not have super blocks",
+					  cache->start);
+				return -EUCLEAN;
+			}
+
 			start = logical[nr];
 			if (start < cache->start) {
 				start = cache->start;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ff418e393f82..deca9fd70771 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3386,8 +3386,12 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 	struct buffer_head *bh;
 	struct btrfs_super_block *super;
 	u64 bytenr;
+	u64 bytenr_orig;
+
+	bytenr_orig = btrfs_sb_offset(copy_num);
+	if (btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr))
+		return -EUCLEAN;
 
-	bytenr = btrfs_sb_offset(copy_num);
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
 		return -EINVAL;
 
@@ -3400,7 +3404,7 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 		return -EIO;
 
 	super = (struct btrfs_super_block *)bh->b_data;
-	if (btrfs_super_bytenr(super) != bytenr ||
+	if (btrfs_super_bytenr(super) != bytenr_orig ||
 		    btrfs_super_magic(super) != BTRFS_MAGIC) {
 		brelse(bh);
 		return -EINVAL;
@@ -3466,7 +3470,7 @@ static int write_dev_supers(struct btrfs_device *device,
 	int i;
 	int ret;
 	int errors = 0;
-	u64 bytenr;
+	u64 bytenr, bytenr_orig;
 	int op_flags;
 
 	if (max_mirrors == 0)
@@ -3475,12 +3479,13 @@ static int write_dev_supers(struct btrfs_device *device,
 	shash->tfm = fs_info->csum_shash;
 
 	for (i = 0; i < max_mirrors; i++) {
-		bytenr = btrfs_sb_offset(i);
+		bytenr_orig = btrfs_sb_offset(i);
+		bytenr = btrfs_sb_log_location(device, i, WRITE);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
 
-		btrfs_set_super_bytenr(sb, bytenr);
+		btrfs_set_super_bytenr(sb, bytenr_orig);
 
 		crypto_shash_init(shash);
 		crypto_shash_update(shash, (const char *)sb + BTRFS_CSUM_SIZE,
@@ -3518,6 +3523,8 @@ static int write_dev_supers(struct btrfs_device *device,
 		ret = btrfsic_submit_bh(REQ_OP_WRITE, op_flags, bh);
 		if (ret)
 			errors++;
+		else if (btrfs_advance_sb_log(device, i))
+			errors++;
 	}
 	return errors < i ? 0 : -1;
 }
@@ -3541,7 +3548,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
 	for (i = 0; i < max_mirrors; i++) {
-		bytenr = btrfs_sb_offset(i);
+		bytenr = btrfs_sb_log_location(device, i, READ);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index e890d2ab8cd9..599c493f44b0 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -16,6 +16,26 @@
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
 
+static int sb_write_pointer(struct blk_zone *zone, u64 *wp_ret);
+
+static inline u32 sb_zone_number(u64 zone_size, int mirror)
+{
+	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
+
+	switch (mirror) {
+	case 0:
+		return 0;
+	case 1:
+		return 16;
+	case 2:
+		return min(btrfs_sb_offset(mirror) / zone_size, 1024ULL);
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
 static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 			       struct blk_zone *zones, unsigned int *nr_zones)
 {
@@ -115,6 +135,39 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		goto free_zones;
 	}
 
+	nr_zones = 2;
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		u32 sb_zone = sb_zone_number(zone_info->zone_size, i);
+		u64 sb_wp;
+
+		if (sb_zone + 1 >= zone_info->nr_zones)
+			continue;
+
+		sector = sb_zone << (zone_info->zone_size_shift - SECTOR_SHIFT);
+		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,
+					  &zone_info->sb_zones[2 * i],
+					  &nr_zones);
+		if (ret)
+			goto free_zones;
+		if (nr_zones != 2) {
+			btrfs_err_in_rcu(device->fs_info,
+			"failed to read SB log zone info at device %s zone %u",
+					 rcu_str_deref(device->name), sb_zone);
+			ret = -EIO;
+			goto free_zones;
+		}
+
+		ret = sb_write_pointer(&zone_info->sb_zones[2 * i], &sb_wp);
+		if (ret != -ENOENT && ret) {
+			btrfs_err_in_rcu(device->fs_info,
+				"SB log zone corrupted: device %s zone %u",
+					 rcu_str_deref(device->name), sb_zone);
+			ret = -EUCLEAN;
+			goto free_zones;
+		}
+	}
+
+
 	kfree(zones);
 
 	device->zone_info = zone_info;
@@ -277,3 +330,226 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 
 	return 0;
 }
+
+static int sb_write_pointer(struct blk_zone *zones, u64 *wp_ret)
+{
+	bool empty[2];
+	bool full[2];
+	sector_t sector;
+
+	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		*wp_ret = zones[0].start << SECTOR_SHIFT;
+		return -ENOENT;
+	}
+
+	empty[0] = zones[0].cond == BLK_ZONE_COND_EMPTY;
+	empty[1] = zones[1].cond == BLK_ZONE_COND_EMPTY;
+	full[0] = zones[0].cond == BLK_ZONE_COND_FULL;
+	full[1] = zones[1].cond == BLK_ZONE_COND_FULL;
+
+	/*
+	 * Possible state of log buffer zones
+	 *
+	 *   E I F
+	 * E * x 0
+	 * I 0 x 0
+	 * F 1 1 x
+	 *
+	 * Row: zones[0]
+	 * Col: zones[1]
+	 * State:
+	 *   E: Empty, I: In-Use, F: Full
+	 * Log position:
+	 *   *: Special case, no superblock is written
+	 *   0: Use write pointer of zones[0]
+	 *   1: Use write pointer of zones[1]
+	 *   x: Invalid state
+	 */
+
+	if (empty[0] && empty[1]) {
+		/* special case to distinguish no superblock to read */
+		*wp_ret = zones[0].start << SECTOR_SHIFT;
+		return -ENOENT;
+	} else if (full[0] && full[1]) {
+		/* cannot determine which zone has the newer superblock */
+		return -EUCLEAN;
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
+int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
+			       u64 *bytenr_ret)
+{
+	struct blk_zone zones[2];
+	unsigned int nr_zones_rep = 2;
+	unsigned int zone_sectors;
+	u32 sb_zone;
+	int ret;
+	u64 wp;
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
+	sb_zone = sb_zone_number(zone_size, mirror);
+	if (sb_zone + 1 >= nr_zones)
+		return -ENOENT;
+
+	ret = blkdev_report_zones(bdev, sb_zone << zone_sectors_shift, zones,
+				  &nr_zones_rep);
+	if (ret)
+		return ret;
+	if (nr_zones_rep != 2)
+		return -EIO;
+
+	ret = sb_write_pointer(zones, &wp);
+	if (ret != -ENOENT && ret)
+		return -EUCLEAN;
+
+	if (rw == READ && ret != -ENOENT) {
+		if (wp == zones[0].start << SECTOR_SHIFT)
+			wp = (zones[1].start + zones[1].len) << SECTOR_SHIFT;
+		wp -= BTRFS_SUPER_INFO_SIZE;
+	}
+	*bytenr_ret = wp;
+
+	return 0;
+}
+
+u64 btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u64 base, wp;
+	u32 zone_num;
+	int ret;
+
+	if (!zinfo)
+		return btrfs_sb_offset(mirror);
+
+	zone_num = sb_zone_number(zinfo->zone_size, mirror);
+	if (zone_num + 1 >= zinfo->nr_zones)
+		return U64_MAX - BTRFS_SUPER_INFO_SIZE;
+
+	base = (u64)zone_num << zinfo->zone_size_shift;
+	if (!test_bit(zone_num, zinfo->seq_zones))
+		return base;
+
+	/* sb_zones should be kept valid during runtime */
+	ret = sb_write_pointer(&zinfo->sb_zones[2 * mirror], &wp);
+	if (ret != -ENOENT && ret)
+		return U64_MAX - BTRFS_SUPER_INFO_SIZE;
+	if (rw == WRITE || ret == -ENOENT)
+		return wp;
+	if (wp == base)
+		wp = base + zinfo->zone_size * 2;
+	return wp - BTRFS_SUPER_INFO_SIZE;
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
+	zone_num = sb_zone_number(zinfo->zone_size, mirror);
+	if (zone_num + 1 >= zinfo->nr_zones)
+		return false;
+
+	if (!test_bit(zone_num, zinfo->seq_zones))
+		return false;
+
+	return true;
+}
+
+int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	struct blk_zone *zone;
+	struct blk_zone *reset = NULL;
+	int ret;
+
+	if (!is_sb_log_zone(zinfo, mirror))
+		return 0;
+
+	zone = &zinfo->sb_zones[2 * mirror];
+	if (zone->cond != BLK_ZONE_COND_FULL) {
+		if (zone->cond == BLK_ZONE_COND_EMPTY)
+			zone->cond = BLK_ZONE_COND_IMP_OPEN;
+		zone->wp += (BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT);
+		if (zone->wp == zone->start + zone->len) {
+			zone->cond = BLK_ZONE_COND_FULL;
+			reset = zone + 1;
+			goto reset;
+		}
+		return 0;
+	}
+
+	zone++;
+	ASSERT(zone->cond != BLK_ZONE_COND_FULL);
+	if (zone->cond == BLK_ZONE_COND_EMPTY)
+		zone->cond = BLK_ZONE_COND_IMP_OPEN;
+	zone->wp += (BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT);
+	if (zone->wp == zone->start + zone->len) {
+		zone->cond = BLK_ZONE_COND_FULL;
+		reset = zone - 1;
+	}
+
+reset:
+	if (!reset || reset->cond == BLK_ZONE_COND_EMPTY)
+		return 0;
+
+	ASSERT(reset->cond == BLK_ZONE_COND_FULL);
+
+	ret = blkdev_reset_zones(device->bdev, reset->start, reset->len,
+				 GFP_NOFS);
+	if (!ret) {
+		reset->cond = BLK_ZONE_COND_EMPTY;
+		reset->wp = reset->start;
+	}
+	return ret;
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
+	sb_zone = sb_zone_number(zone_sectors << SECTOR_SHIFT, mirror);
+	if (sb_zone + 1 >= nr_zones)
+		return -ENOENT;
+
+	return blkdev_reset_zones(bdev,
+				  sb_zone << zone_sectors_shift,
+				  zone_sectors * 2,
+				  GFP_NOFS);
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index d9ebe11afdf5..55041a26ae3c 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -10,6 +10,8 @@
 #define BTRFS_HMZONED_H
 
 #include <linux/blkdev.h>
+#include "volumes.h"
+#include "disk-io.h"
 
 struct btrfs_zoned_device_info {
 	/*
@@ -21,6 +23,7 @@ struct btrfs_zoned_device_info {
 	u32 nr_zones;
 	unsigned long *seq_zones;
 	unsigned long *empty_zones;
+	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
 };
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -30,6 +33,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
 int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
+int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
+			       u64 *bytenr_ret);
+u64 btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw);
+int btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
+int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -53,6 +61,27 @@ static inline int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 {
 	return 0;
 }
+static inline int btrfs_sb_log_location_bdev(struct block_device *bdev,
+					     int mirror, int rw,
+					     u64 *bytenr_ret)
+{
+	*bytenr_ret = btrfs_sb_offset(mirror);
+	return 0;
+}
+static inline u64 btrfs_sb_log_location(struct btrfs_device *device, int mirror,
+					int rw)
+{
+	return btrfs_sb_offset(mirror);
+}
+static inline int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
+{
+	return 0;
+}
+static inline int btrfs_reset_sb_log_zones(struct block_device *bdev,
+					   int mirror)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -120,4 +149,15 @@ static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
 	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
 }
 
+static inline bool btrfs_check_super_location(struct btrfs_device *device,
+					      u64 pos)
+{
+	/*
+	 * On a non-zoned device, any address is OK. On a zoned
+	 * device, non-SEQUENTIAL WRITE REQUIRED zones are capable.
+	 */
+	return device->zone_info == NULL ||
+		!btrfs_dev_is_sequential(device, pos);
+}
+
 #endif
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 21de630b0730..af7cec962619 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -19,6 +19,7 @@
 #include "rcu-string.h"
 #include "raid56.h"
 #include "block-group.h"
+#include "hmzoned.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -3709,6 +3710,8 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(scrub_dev, bytenr))
+			continue;
 
 		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
 				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ab3590b310af..a260648cecca 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1218,12 +1218,17 @@ static void btrfs_release_disk_super(struct page *page)
 	put_page(page);
 }
 
-static int btrfs_read_disk_super(struct block_device *bdev, u64 bytenr,
+static int btrfs_read_disk_super(struct block_device *bdev, int mirror,
 				 struct page **page,
 				 struct btrfs_super_block **disk_super)
 {
 	void *p;
 	pgoff_t index;
+	u64 bytenr;
+	u64 bytenr_orig = btrfs_sb_offset(mirror);
+
+	if (btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr))
+		return 1;
 
 	/* make sure our super fits in the device */
 	if (bytenr + PAGE_SIZE >= i_size_read(bdev->bd_inode))
@@ -1250,7 +1255,7 @@ static int btrfs_read_disk_super(struct block_device *bdev, u64 bytenr,
 	/* align our pointer to the offset of the super block */
 	*disk_super = p + offset_in_page(bytenr);
 
-	if (btrfs_super_bytenr(*disk_super) != bytenr ||
+	if (btrfs_super_bytenr(*disk_super) != bytenr_orig ||
 	    btrfs_super_magic(*disk_super) != BTRFS_MAGIC) {
 		btrfs_release_disk_super(*page);
 		return 1;
@@ -1287,7 +1292,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	struct btrfs_device *device = NULL;
 	struct block_device *bdev;
 	struct page *page;
-	u64 bytenr;
 
 	lockdep_assert_held(&uuid_mutex);
 
@@ -1297,14 +1301,13 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	 * So, we need to add a special mount option to scan for
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
-	bytenr = btrfs_sb_offset(0);
 	flags |= FMODE_EXCL;
 
 	bdev = blkdev_get_by_path(path, flags, holder);
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
-	if (btrfs_read_disk_super(bdev, bytenr, &page, &disk_super)) {
+	if (btrfs_read_disk_super(bdev, 0, &page, &disk_super)) {
 		device = ERR_PTR(-EINVAL);
 		goto error_bdev_put;
 	}
@@ -7371,6 +7374,11 @@ void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_pat
 		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
 			continue;
 
+		if (bdev_is_zoned(bdev)) {
+			btrfs_reset_sb_log_zones(bdev, copy_num);
+			continue;
+		}
+
 		disk_super = (struct btrfs_super_block *)bh->b_data;
 
 		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-- 
2.24.0

