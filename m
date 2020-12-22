Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B072E04F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgLVDwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:52:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46443 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLVDwm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609162; x=1640145162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FsGwMWT1XdRFQq7DqeeoRexq/M4KpuVCHqlyoqzLbGw=;
  b=e+LPGUNNr/5RGDE91mNalhEuDjOJuECnaToaYvxYcQ3bldoBxiWF408X
   c+d6mlxRKAXBQBWNiijWessDLyFPfjMsNJcgcAMU3K6d5RVdJ6FZXrH0h
   rqDEMDjnSB9J0RmVL3h3Ae+5TK809tG0AMXL49yVdQI6/FZDpyy0ToTui
   wnp7nUU5OnkOfP/N97bGCoqdgrcr/Gax+lBHbD+qu0d3nuLXoEGLW5bDK
   ybD9RJpiv6X9RRP29pE1I/GGTOsDVwUVTQKQ1KFYeIWNYIukNcKyTFuxJ
   lmq+Zuc4dVnyKlZdwRvI6YsWUKADizAgD82r09AIaURPfXFLYwP5Gp9uh
   A==;
IronPort-SDR: YOTmcAduBLEtyBJo0OYBYwwnnt5rEX86JF2Y2b+2ZpWD+yVDPTGEZfO8DcXotrbR/6ibZhyFal
 Jw9k3ALIufnSP1YlV27K30Io+71/aAeaTvynhLB7YCQuFwjDz+eOTrFypYWpj4l5bXKtGq/tjv
 +Tvq/IqTCVaU5xVw4jtXId3sBsIUSz7y2SMvCzSOMO4ejUtVBQ8UXPNduJ8T3sClowMyGVjhI/
 iZwWb/Pg50NHlJuWpmqAyQTIaTY2U0elZvXuzlLs0HFZvDzKwrhynyYoOUNzsSEpTJzonXQfQ1
 jjY=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193747"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:38 +0800
IronPort-SDR: bmXmwKCxYXno/oBmUX+cKZfzgqVikZoT45KcsSh/OXJwq2cbETC3N6Fb0PPq4JrdXYf1lkB7FN
 bpNzhi0U1zvib4pCPWXxJBzAcuW3lNdG1YPLgRY/8Qalz/2Y8q0KJPVJ08Az7L4b0UKzOYB6KV
 /Jd0Un8fCZx9JAUHmN3OL9OL0CCpMFF+tsINKB6VK8VGj6/M7z3c/8vVVmCJjPG+Qf7E2LsRHY
 KCXTbAW+ly5B9uAiFz+zLg4PtEx1EBFgWMypTZyHzFsChRTKmpi+fQu+UFFMwx83ppD3lig63t
 fR/w85CtBgiVwBxDR8r/5HvW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:49 -0800
IronPort-SDR: a1OfIBz8EJTgh9l7xbJaEynMeZKO64zB+Iw5lal3AljS9JjXASVjAC8NVyUjh1ZB2oDhYM09ac
 GzUfBq0tX3VzEGkqVR9XZp74mDpvzWZ2+LDBKwF2GfTKtE1YleLx/KB5qNI5lIHOxXgfzBRgog
 Vpq5ujeLi5akU2vmQndBpbP4TnQ9kd7maIeb4+XfJX9MfoM69qq/XLuQGhOVSMOh79cE0Qktiz
 FmKstHxVkyrwfU8Me43sNnj/m1+LjpELUOFJgSGLc1qEbeqnhhECua7wjrxi1srrS5Rv4M2C1z
 GzU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:37 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 09/40] btrfs: implement zoned chunk allocator
Date:   Tue, 22 Dec 2020 12:49:02 +0900
Message-Id: <6c977b7099812637cff36d09ac1a8e6ea2e00519.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit implements a zoned chunk/dev_extent allocator. The zoned
allocator aligns the device extents to zone boundaries, so that a zone
reset affects only the device extent and does not change the state of
blocks in the neighbor device extents.

Also, it checks that a region allocation is not overlapping any of the
super block zones, and ensures the region is empty.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 169 ++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h |   1 +
 fs/btrfs/zoned.c   | 144 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  25 +++++++
 4 files changed, 323 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2cdb5fe3e423..19c76cf9d2d2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1424,11 +1424,62 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 		 * make sure to start at an offset of at least 1MB.
 		 */
 		return max_t(u64, start, SZ_1M);
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		/*
+		 * We don't care about the starting region like regular
+		 * allocator, because we anyway use/reserve the first two
+		 * zones for superblock logging.
+		 */
+		return ALIGN(start, device->zone_info->zone_size);
 	default:
 		BUG();
 	}
 }
 
+static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
+					u64 *hole_start, u64 *hole_size,
+					u64 num_bytes)
+{
+	u64 zone_size = device->zone_info->zone_size;
+	u64 pos;
+	int ret;
+	int changed = 0;
+
+	ASSERT(IS_ALIGNED(*hole_start, zone_size));
+
+	while (*hole_size > 0) {
+		pos = btrfs_find_allocatable_zones(device, *hole_start,
+						   *hole_start + *hole_size,
+						   num_bytes);
+		if (pos != *hole_start) {
+			*hole_size = *hole_start + *hole_size - pos;
+			*hole_start = pos;
+			changed = 1;
+			if (*hole_size < num_bytes)
+				break;
+		}
+
+		ret = btrfs_ensure_empty_zones(device, pos, num_bytes);
+
+		/* Range is ensured to be empty */
+		if (!ret)
+			return changed;
+
+		/* Given hole range was invalid (outside of device) */
+		if (ret == -ERANGE) {
+			*hole_start += *hole_size;
+			*hole_size = 0;
+			return 1;
+		}
+
+		*hole_start += zone_size;
+		*hole_size -= zone_size;
+		changed = 1;
+	}
+
+	return changed;
+}
+
 /**
  * dev_extent_hole_check - check if specified hole is suitable for allocation
  * @device:	the device which we have the hole
@@ -1445,24 +1496,39 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 	bool changed = false;
 	u64 hole_end = *hole_start + *hole_size;
 
-	/*
-	 * Check before we set max_hole_start, otherwise we could end up
-	 * sending back this offset anyway.
-	 */
-	if (contains_pending_extent(device, hole_start, *hole_size)) {
-		if (hole_end >= *hole_start)
-			*hole_size = hole_end - *hole_start;
-		else
-			*hole_size = 0;
-		changed = true;
-	}
+	for (;;) {
+		/*
+		 * Check before we set max_hole_start, otherwise we could end up
+		 * sending back this offset anyway.
+		 */
+		if (contains_pending_extent(device, hole_start, *hole_size)) {
+			if (hole_end >= *hole_start)
+				*hole_size = hole_end - *hole_start;
+			else
+				*hole_size = 0;
+			changed = true;
+		}
+
+		switch (device->fs_devices->chunk_alloc_policy) {
+		case BTRFS_CHUNK_ALLOC_REGULAR:
+			/* No extra check */
+			break;
+		case BTRFS_CHUNK_ALLOC_ZONED:
+			if (dev_extent_hole_check_zoned(device, hole_start,
+							hole_size, num_bytes)) {
+				changed = true;
+				/*
+				 * The changed hole can contain pending
+				 * extent. Loop again to check that.
+				 */
+				continue;
+			}
+			break;
+		default:
+			BUG();
+		}
 
-	switch (device->fs_devices->chunk_alloc_policy) {
-	case BTRFS_CHUNK_ALLOC_REGULAR:
-		/* No extra check */
 		break;
-	default:
-		BUG();
 	}
 
 	return changed;
@@ -1515,6 +1581,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 
 	search_start = dev_extent_search_start(device, search_start);
 
+	WARN_ON(device->zone_info &&
+		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -4913,6 +4982,37 @@ static void init_alloc_chunk_ctl_policy_regular(
 	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 }
 
+static void init_alloc_chunk_ctl_policy_zoned(
+				      struct btrfs_fs_devices *fs_devices,
+				      struct alloc_chunk_ctl *ctl)
+{
+	u64 zone_size = fs_devices->fs_info->zone_size;
+	u64 limit;
+	int min_num_stripes = ctl->devs_min * ctl->dev_stripes;
+	int min_data_stripes = (min_num_stripes - ctl->nparity) / ctl->ncopies;
+	u64 min_chunk_size = min_data_stripes * zone_size;
+	u64 type = ctl->type;
+
+	ctl->max_stripe_size = zone_size;
+	if (type & BTRFS_BLOCK_GROUP_DATA) {
+		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
+						 zone_size);
+	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
+		ctl->max_chunk_size = ctl->max_stripe_size;
+	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
+		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
+		ctl->devs_max = min_t(int, ctl->devs_max,
+				      BTRFS_MAX_DEVS_SYS_CHUNK);
+	}
+
+	/* We don't want a chunk larger than 10% of writable space */
+	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
+			       zone_size),
+		    min_chunk_size);
+	ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
+	ctl->dev_extent_min = zone_size * ctl->dev_stripes;
+}
+
 static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 				 struct alloc_chunk_ctl *ctl)
 {
@@ -4933,6 +5033,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
 		break;
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
+		break;
 	default:
 		BUG();
 	}
@@ -5059,6 +5162,38 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
 	return 0;
 }
 
+static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
+				    struct btrfs_device_info *devices_info)
+{
+	u64 zone_size = devices_info[0].dev->zone_info->zone_size;
+	/* Number of stripes that count for block group size */
+	int data_stripes;
+
+	/*
+	 * It should hold because:
+	 *    dev_extent_min == dev_extent_want == zone_size * dev_stripes
+	 */
+	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min);
+
+	ctl->stripe_size = zone_size;
+	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
+	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
+
+	/* stripe_size is fixed in ZONED. Reduce ndevs instead. */
+	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
+		ctl->ndevs = div_u64(div_u64(ctl->max_chunk_size * ctl->ncopies,
+					     ctl->stripe_size) + ctl->nparity,
+				     ctl->dev_stripes);
+		ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
+		data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
+		ASSERT(ctl->stripe_size * data_stripes <= ctl->max_chunk_size);
+	}
+
+	ctl->chunk_size = ctl->stripe_size * data_stripes;
+
+	return 0;
+}
+
 static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 			      struct alloc_chunk_ctl *ctl,
 			      struct btrfs_device_info *devices_info)
@@ -5086,6 +5221,8 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	switch (fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		return decide_stripe_size_regular(ctl, devices_info);
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		return decide_stripe_size_zoned(ctl, devices_info);
 	default:
 		BUG();
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 59d9d47f173d..c8841b714f2e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -216,6 +216,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
 enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_REGULAR,
+	BTRFS_CHUNK_ALLOC_ZONED,
 };
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fc43a650cd79..b1ece6b978dd 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include "ctree.h"
 #include "volumes.h"
 #include "zoned.h"
 #include "rcu-string.h"
+#include "disk-io.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -529,6 +531,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
+	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 
 	/*
 	 * Check mount options here, because we might change fs_info->zoned
@@ -746,3 +749,144 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 				sb_zone << zone_sectors_shift,
 				zone_sectors * BTRFS_NR_SB_LOG_ZONES, GFP_NOFS);
 }
+
+/*
+ * btrfs_check_allocatable_zones - find allocatable zones within give region
+ * @device:	the device to allocate a region
+ * @hole_start: the position of the hole to allocate the region
+ * @num_bytes:	the size of wanted region
+ * @hole_size:	the size of hole
+ *
+ * Allocatable region should not contain any superblock locations.
+ */
+u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
+				 u64 hole_end, u64 num_bytes)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u8 shift = zinfo->zone_size_shift;
+	u64 nzones = num_bytes >> shift;
+	u64 pos = hole_start;
+	u64 begin, end;
+	bool have_sb;
+	int i;
+
+	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
+
+	while (pos < hole_end) {
+		begin = pos >> shift;
+		end = begin + nzones;
+
+		if (end > zinfo->nr_zones)
+			return hole_end;
+
+		/* Check if zones in the region are all empty */
+		if (btrfs_dev_is_sequential(device, pos) &&
+		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
+			pos += zinfo->zone_size;
+			continue;
+		}
+
+		have_sb = false;
+		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+			u32 sb_zone;
+			u64 sb_pos;
+
+			sb_zone = sb_zone_number(shift, i);
+			if (!(end <= sb_zone ||
+			      sb_zone + BTRFS_NR_SB_LOG_ZONES <= begin)) {
+				have_sb = true;
+				pos = ((u64)sb_zone + BTRFS_NR_SB_LOG_ZONES) << shift;
+				break;
+			}
+
+			/*
+			 * We also need to exclude regular superblock
+			 * positions
+			 */
+			sb_pos = btrfs_sb_offset(i);
+			if (!(pos + num_bytes <= sb_pos ||
+			      sb_pos + BTRFS_SUPER_INFO_SIZE <= pos)) {
+				have_sb = true;
+				pos = ALIGN(sb_pos + BTRFS_SUPER_INFO_SIZE,
+					    zinfo->zone_size);
+				break;
+			}
+		}
+		if (!have_sb)
+			break;
+
+	}
+
+	return pos;
+}
+
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes)
+{
+	int ret;
+
+	*bytes = 0;
+	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET,
+			       physical >> SECTOR_SHIFT, length >> SECTOR_SHIFT,
+			       GFP_NOFS);
+	if (ret)
+		return ret;
+
+	*bytes = length;
+	while (length) {
+		btrfs_dev_set_zone_empty(device, physical);
+		physical += device->zone_info->zone_size;
+		length -= device->zone_info->zone_size;
+	}
+
+	return 0;
+}
+
+int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u8 shift = zinfo->zone_size_shift;
+	unsigned long begin = start >> shift;
+	unsigned long end = (start + size) >> shift;
+	u64 pos;
+	int ret;
+
+	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
+
+	if (end > zinfo->nr_zones)
+		return -ERANGE;
+
+	/* All the zones are conventional */
+	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
+		return 0;
+
+	/* All the zones are sequential and empty */
+	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
+	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
+		return 0;
+
+	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
+		u64 reset_bytes;
+
+		if (!btrfs_dev_is_sequential(device, pos) ||
+		    btrfs_dev_is_empty_zone(device, pos))
+			continue;
+
+		/* Free regions should be empty */
+		btrfs_warn_in_rcu(
+			device->fs_info,
+			"zoned: resetting device %s (devid %llu) zone %llu for allocation",
+			rcu_str_deref(device->name), device->devid,
+			pos >> shift);
+		WARN_ON_ONCE(1);
+
+		ret = btrfs_reset_device_zone(device, pos, zinfo->zone_size,
+					      &reset_bytes);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 058a57317c05..de5901f5ae66 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -36,6 +36,11 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 			  u64 *bytenr_ret);
 void btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
 int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
+u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
+				 u64 hole_end, u64 num_bytes);
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes);
+int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -92,6 +97,26 @@ static inline int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror
 	return 0;
 }
 
+static inline u64 btrfs_find_allocatable_zones(struct btrfs_device *device,
+					       u64 hole_start, u64 hole_end,
+					       u64 num_bytes)
+{
+	return hole_start;
+}
+
+static inline int btrfs_reset_device_zone(struct btrfs_device *device,
+					  u64 physical, u64 length, u64 *bytes)
+{
+	*bytes = 0;
+	return 0;
+}
+
+static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
+					   u64 start, u64 size)
+{
+	return 0;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

