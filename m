Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E02F7324
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbhAOG5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:57:33 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41647 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693852; x=1642229852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WDIeswTFr360RUHtfzwCDoCtwuRsed0xJjPDMP++dpY=;
  b=roKHHTDze/of/1OI3WN99Xk6q4TcPhVftBo1NRkU3kTHZP/+Vm8mMAxy
   0zdA71EBlFj7iCoNgtsbBcoEh3TBp37h+J4q+XydzEVR0aijIAVDaj+KQ
   YClkg/1qIq5qZR8UFGHiJvErGJu+OVsViEk7OkeHE0TpFUcEDMTm2sqFP
   6ZJt7fl1Zh/GXwLloHFU+jx/LZZ6bGpORjZka7MqkFTt0zCcOk4paffHy
   X55Hi3+GsbRy4CEzbnuPZEdkHtfIHXNJH2khtADJWon4kpfcFCZRGgFSF
   EWH6mlGOmSSG8/vvqBgYMYlDHp2OUJey0O4kxM0AOV5dnfe6m0GrM0L9m
   A==;
IronPort-SDR: crYqjOXPSuxXCRGPLJg5gaR+U4to1zibTJkh/3bJoWtydCAZRSlkR+FgUKL/C9A7Yrxc76y5hz
 vyaGcvl77LLQIHww6dFJmGZXtC/Q3G7MLQYmi0VqVmcD1o178r7nzQXopd9WwkB9kd04xnGvuB
 eZ7wC2hnGVK7a/dYDGzC042M154M7ZmuJvVwckRowZWzpJJQEkDQy2pKlxNo3c6J6qVAsQ1Lpo
 lZ2LEfPZNx35t/2/pttlJvOKG3qUvCnDQ1lNSa+922zeQ8D67pvEOJg2DSnUCxusUlmseviY1u
 Fc8=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928214"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:23 +0800
IronPort-SDR: yoCmTO3tuYFuaNI1DuRePgyaWNhkNBvH/EYRxgJ783yFYqN5f58ZqstOyDsDPjOd0orEqOZ5BR
 gIJ7WewxpaZm96/Fz0h+Sr+i20zi4caVSBfx9m1acKeo9xX7luElHqIB85jlXfdxwdbT3fQtEL
 jpseFl5RYEW1tdqtrYPCU33Cp+F/ojnN+rNd+91H/l9yJ6qJEplvawFJzHHYXHUf6b8ALlHeB+
 vJkbNcI1h05RxDHQuTLmPjYnHK6HW7ttTAPTv23yPwmKt4QcIQmuP1JaWldbbaWlSfYRBMFWPV
 uHigC0o5MF6yvEpA9DXDLKEg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:05 -0800
IronPort-SDR: 1jJ0s8N94cB+5epa3ZgecYpfqjFjZB57hHp+H/fkGT64N0iH1RisZC7ThZrP+2I2as4GZVaKu8
 YEAkrPPD2MdOTOmH6+NUbZE0BqkC2wgVnfMjfXO50m+jrlXfkXft96WjM3dDccrealrU+1u0Uc
 qPnExrKs50XIra1D6dCJuVYDUZwRyZcyy6cdmpBlWe2WvslsESou5cEsYSgpCpNsGIfXMJlnGo
 5v6zw/UXzK6aIOo8+e1LGcnrSlBCSNGnjvBXTMC2uhaSnYs6OqBGPUu+qq+obKgYem0qRVzM/B
 CWk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:22 -0800
Received: (nullmailer pid 1916438 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 09/41] btrfs: implement zoned chunk allocator
Date:   Fri, 15 Jan 2021 15:53:13 +0900
Message-Id: <b54a64d8ede237d9678226160d5aa9dda31aba7c.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 169 ++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h |   1 +
 fs/btrfs/zoned.c   | 144 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  25 +++++++
 4 files changed, 323 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7d92b11ea603..4f02b570736e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1415,11 +1415,62 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
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
@@ -1436,24 +1487,39 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
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
@@ -1506,6 +1572,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 
 	search_start = dev_extent_search_start(device, search_start);
 
+	WARN_ON(device->zone_info &&
+		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -4899,6 +4968,37 @@ static void init_alloc_chunk_ctl_policy_regular(
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
@@ -4919,6 +5019,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
 		break;
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
+		break;
 	default:
 		BUG();
 	}
@@ -5045,6 +5148,38 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
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
@@ -5072,6 +5207,8 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	switch (fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		return decide_stripe_size_regular(ctl, devices_info);
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		return decide_stripe_size_zoned(ctl, devices_info);
 	default:
 		BUG();
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1997a4649a66..98a447badd6a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -213,6 +213,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
 enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_REGULAR,
+	BTRFS_CHUNK_ALLOC_ZONED,
 };
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 13b240e5db4e..ae5f49fe4fb4 100644
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
@@ -557,6 +559,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
+	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 
 	/*
 	 * Check mount options here, because we might change fs_info->zoned
@@ -779,3 +782,144 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
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
+ * @return:	position of allocatable zones
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

