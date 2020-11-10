Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69342AD4F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgKJL2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:37 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11943 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbgKJL22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007708; x=1636543708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w4p5zdBX3vuqMNItg1rplArk4UwYLA38qFidJsIoKEo=;
  b=QxyjHWqLwCIVvmaGFkTISTHiJcpG5QG/eMxDNTIXuh/17DIUxu8erYqh
   WH5R06HxWtn+nv/QHjnH6bkOtBcoxikmgj/c8R18Ku5DkLOkrGAk4ZTvI
   y7rwdn4Jtg1Rrt3xSM/YEqP2J7RdDLAaBLuzz1pumuys0lQ9Sw0pmwXOy
   IN80aReRYzrLvP3JQQzZ65cC3/I3rOgEOufJWWpR6Lo5dhOBLDnl3Dx2l
   qCf0bVY2pbjwQbrygv/ZUgKUiW/4lAMSLoWNE3beDWH9rcPPYmkLDK+pY
   52+6bSwDejRXCZWJhcRIV647cAH29aqdYpj++lwA5PeTuLgUMTTEL7DBS
   A==;
IronPort-SDR: 244UC/lTLKx9mhLrVdLhxJsphFOHubmZ4GGmVhulwGgnJpVqodZpSeL+acxb4eYwnD15Z7BurR
 bY7rZqm7p5dM2p2ETdOz550+ws4jpcXH092bidl4aOmtvo0GYVH25Mzm4b/2betmegL7KyfixA
 l6wZAl475FRIGji3b/Ql79Me/bW+lBBRYL5StV9Sy3sn2gUjoS4JGiWyVihp3Odg9gl5yMRJgr
 OvAhzI0Ffrs3p511t306fK3lAKrcVSjW0PBJZutpNTLeR5nj0avfdm4bPORfgFRIpYQ6hRZtG0
 RMU=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376459"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:25 +0800
IronPort-SDR: mdbKvykhfkXQvBgMLQvrR+mbTV4dJ9YLVOdVST+6D4awOHcN1H7iO1Z+05XyG4Z3hQUI2PBc3P
 mgZPzg6RhE04cPyxFeX6zvmbffiVnROx485fSCqTrjifGMe2NuO/Jf1Qti7UUrcpxLviigg4al
 hMw7JgfSw/B1X3KBt7/djF8MBRV/EiujaeNt2FkajDgqCmfQvNyuc8gffx9AJg6skCstcDpmSf
 /dpBdw+Xec0jYpgRAfaAxvhq/haBiS80iA5kwSFCU2O0l/oscKKCardFJnHqgPOEf3/KqLTfI3
 F82jTYYwp3qymryJ0xndxkhq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:25 -0800
IronPort-SDR: DPgnxvo9Kb5dg9Jm6PTtH3ndBZ4D4igthqp9UZDDOShA8AHIO791cCalwLxKEayJrJxr9V1JmT
 lV2boVfsPKoGSKcoJc8C9HS7x7v5lAfP3j6GkaRD/u6LVY2/CFK+ePdqzBzqI1R2Pn2aVVBCyO
 +6LmFuo0RX8K1bKyrcHW7Z9ozsiDpESJOqu89xgLe33NdmfsUmCm/EFS3cCzF+0fttJ6CiMaw6
 nfx8KR292CZYWoDDtCxIvslyF1A5d2T7SvBJx+PlREPwFmlEdPmjg+IipSc57J0sjbsBrCelVt
 Yas=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 12/41] btrfs: implement zoned chunk allocator
Date:   Tue, 10 Nov 2020 20:26:15 +0900
Message-Id: <e7896fe18651e3ad12a96ff3ec3255e3127c8239.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
 fs/btrfs/volumes.c | 136 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |   1 +
 fs/btrfs/zoned.c   | 144 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  34 +++++++++++
 4 files changed, 315 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index db884b96a5ea..7831cf6c6da4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1416,6 +1416,21 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 	return false;
 }
 
+static inline u64 dev_extent_search_start_zoned(struct btrfs_device *device,
+						u64 start)
+{
+	u64 tmp;
+
+	if (device->zone_info->zone_size > SZ_1M)
+		tmp = device->zone_info->zone_size;
+	else
+		tmp = SZ_1M;
+	if (start < tmp)
+		start = tmp;
+
+	return btrfs_align_offset_to_zone(device, start);
+}
+
 static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 {
 	switch (device->fs_devices->chunk_alloc_policy) {
@@ -1426,11 +1441,57 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 		 * make sure to start at an offset of at least 1MB.
 		 */
 		return max_t(u64, start, SZ_1M);
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		return dev_extent_search_start_zoned(device, start);
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
@@ -1463,6 +1524,10 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		/* No extra check */
 		break;
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		changed |= dev_extent_hole_check_zoned(device, hole_start,
+						       hole_size, num_bytes);
+		break;
 	default:
 		BUG();
 	}
@@ -1517,6 +1582,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 
 	search_start = dev_extent_search_start(device, search_start);
 
+	WARN_ON(device->zone_info &&
+		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -4907,6 +4975,37 @@ static void init_alloc_chunk_ctl_policy_regular(
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
@@ -4927,6 +5026,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
 		break;
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
+		break;
 	default:
 		BUG();
 	}
@@ -5053,6 +5155,38 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
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
@@ -5080,6 +5214,8 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	switch (fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		return decide_stripe_size_regular(ctl, devices_info);
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		return decide_stripe_size_zoned(ctl, devices_info);
 	default:
 		BUG();
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9c07b97a2260..0249aca668fb 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -213,6 +213,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
 enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_REGULAR,
+	BTRFS_CHUNK_ALLOC_ZONED,
 };
 
 struct btrfs_fs_devices {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 84ade8c19ddc..ed5de1c138d7 100644
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
@@ -424,6 +426,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
+	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 
 	btrfs_info(fs_info, "zoned mode enabled with zone size %llu",
 		   fs_info->zone_size);
@@ -633,3 +636,144 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
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
index de9d7dd8c351..ec2391c52d8b 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -35,6 +35,11 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
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
@@ -87,6 +92,26 @@ static inline int btrfs_reset_sb_log_zones(struct block_device *bdev,
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
@@ -165,4 +190,13 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device,
 	       !btrfs_dev_is_sequential(device, pos);
 }
 
+static inline u64 btrfs_align_offset_to_zone(struct btrfs_device *device,
+					     u64 pos)
+{
+	if (!device->zone_info)
+		return pos;
+
+	return ALIGN(pos, device->zone_info->zone_size);
+}
+
 #endif
-- 
2.27.0

