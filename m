Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D5111DCD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfLMEK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:10:58 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11892 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfLMEK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210257; x=1607746257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mhe5PGEWWycCzKvFzkOsE0Tfx/7HD095eI1zKoe8Ikk=;
  b=WJsyQzoq4Fga/Ctm8bsFTa0/otGM6bn+Yp9mvxIrRZd/c5zVxmqTYkJU
   wDvLuI2InzUIxPtRgOm1R0m/eeHGOKzwk48IrDQCjC8+OrAcyNzD6xKSh
   5nUSw1zLaUUBtX2Zzn1cdGWNeDNlL5L+xTPJVmJUb47iMHVc49XseJ8eO
   IPEbHcOv/5WxFY8cmk7ODVvosUn5IjI4KqDp9fIXxbcOBbM+iH+wd2UIZ
   3WPpne4QoWGlMl0Lj179duQTZngzO2kwV3lu6AZkvyWjG/Aup/yKEQycz
   YOi0VMZ1tdSv7l7me4BRhNqL0ySGutZzCkzVKyIF0Bsiiq6Rwdz6ML3HR
   w==;
IronPort-SDR: jC+okgSzENtPzUIL0zH6dgN+qMXVdUpZnTGC340J+3KQCj5ntM0uCFKNIwg4bjCueLudLcqSjO
 6/xBDhSIX1XNIu2EVh3EfgBgnOtRLou14KQmWOAwnOliZ3MngD+KuYCq1MLMZtVPM+lkHD5Eig
 Np0BVotGibnhNKiut2zsqf9ST32tPDBnyj5xPsfDPqIIONNUXzqTsByN6ghs4GA0rjNvhnWcJW
 +oi4Bc4yOB60Uftg5KxE7vES7E93XCEEz3CwW8lL6NrlPS+TgpMAMi60UAfdiG4if4Zk9slBhL
 l4Q=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860120"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:10:57 +0800
IronPort-SDR: AtYq+cAeJiL29HUGc4XFnI0dxkZLA8mlqc0JsV14rhtxhi6DIGHLU/IDX4M/qeubu3Lmat8jrK
 TmpMyznHHARyDeCwAPmNoLQUS+VTNDAboekhfv0GHbJW+LVC0ztfYxK4AgAlPGyVMakul977He
 6DWwvmPP2nyliR7KXBn7SDzvELvXZIBaog11lVBfVGHUonLTa03Prnh6nS3L97QoALZ/5v2bcR
 wjQjKeLA888Yfvr8MZkRLcrR1X1uR+vZUg9NDU6JxhFWGjUooUyQ4IzBHUqZfYXBpY5d9OoN+W
 InxW8+bg20rHLoJa6yJEmcq2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:28 -0800
IronPort-SDR: WRQ4b6O25O4ySWiyXQe48v7P3p2JKvIYiJuF0oaANQDd7aXVzSS/oy/BFL9YOSqNVMUPGUs+yp
 pRVcJoNs6zq640ILXdc8CaMVjd0x50rFYRpNDTYelUrGsuknMjspCIZXD82GkXuDnqcREzdOPb
 FbUPCbJdcDDps8u6KMjsDd5vcGCIjn0kUoEA2QxAuq5YgFaZQmTPh5jvOs+0bCk+oRF65ef3Q2
 /z+MZmiIDBhFsK15vfsTa+Ju7/CXU5INf79VMEkldi3YFmYWpz6VEkRDNye5zPrHxH2oc+VZlJ
 ta4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:10:55 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 09/28] btrfs: align device extent allocation to zone boundary
Date:   Fri, 13 Dec 2019 13:08:56 +0900
Message-Id: <20191213040915.3502922-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In HMZONED mode, align the device extents to zone boundaries so that a zone
reset affects only the device extent and does not change the state of
blocks in the neighbor device extents. Also, check that a region allocation
is always over empty zones and it is not over any locations of super block
zones.

This patch also add a verification in verify_one_dev_extent() to check if
the device extent is align to zone boundary.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 55 ++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h | 15 +++++++++
 fs/btrfs/volumes.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index a74011650145..6263c8aee082 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -12,6 +12,7 @@
 #include "volumes.h"
 #include "hmzoned.h"
 #include "rcu-string.h"
+#include "disk-io.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -550,3 +551,57 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 				  zone_sectors * 2,
 				  GFP_NOFS);
 }
+
+/*
+ * btrfs_check_allocatable_zones - check if spcecifeid region is
+ *                                 suitable for allocation
+ * @device:	the device to allocate a region
+ * @pos:	the position of the region
+ * @num_bytes:	the size of the region
+ *
+ * In non-ZONED device, anywhere is suitable for allocation. In ZONED
+ * device, check if
+ * 1) the region is not on non-empty sequential zones,
+ * 2) all zones in the region have the same zone type,
+ * 3) it does not contain super block location.
+ */
+bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
+				   u64 num_bytes)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u64 nzones, begin, end;
+	u64 sb_pos;
+	u8 shift;
+	int i;
+
+	if (!zinfo)
+		return true;
+
+	shift = zinfo->zone_size_shift;
+	nzones = num_bytes >> shift;
+	begin = pos >> shift;
+	end = begin + nzones;
+
+	ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
+
+	if (end > zinfo->nr_zones)
+		return false;
+
+	/* check if zones in the region are all empty */
+	if (btrfs_dev_is_sequential(device, pos) &&
+	    find_next_zero_bit(zinfo->empty_zones, end, begin) != end)
+		return false;
+
+	if (btrfs_dev_is_sequential(device, pos)) {
+		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+			sb_pos = sb_zone_number(zinfo->zone_size, i);
+			if (!(end < sb_pos || sb_pos + 1 < begin))
+				return false;
+		}
+
+		return find_next_zero_bit(zinfo->seq_zones, end, begin) == end;
+	}
+
+	return find_next_bit(zinfo->seq_zones, end, begin) == end;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 55041a26ae3c..d54b4ae8cf8b 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -38,6 +38,8 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 u64 btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw);
 int btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
 int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
+bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
+				   u64 num_bytes);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -82,6 +84,11 @@ static inline int btrfs_reset_sb_log_zones(struct block_device *bdev,
 {
 	return 0;
 }
+static inline bool btrfs_check_allocatable_zones(struct btrfs_device *device,
+						 u64 pos, u64 num_bytes)
+{
+	return true;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -160,4 +167,12 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device,
 		!btrfs_dev_is_sequential(device, pos);
 }
 
+static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
+{
+	if (!device->zone_info)
+		return pos;
+
+	return ALIGN(pos, device->zone_info->zone_size);
+}
+
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a260648cecca..d5b280b59733 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1393,6 +1393,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	u64 max_hole_size;
 	u64 extent_end;
 	u64 search_end = device->total_bytes;
+	u64 zone_size = 0;
 	int ret;
 	int slot;
 	struct extent_buffer *l;
@@ -1403,6 +1404,15 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	 * at an offset of at least 1MB.
 	 */
 	search_start = max_t(u64, search_start, SZ_1M);
+	/*
+	 * For a zoned block device, skip the first zone of the device
+	 * entirely.
+	 */
+	if (device->zone_info) {
+		zone_size = device->zone_info->zone_size;
+		search_start = max_t(u64, search_start, zone_size);
+		search_start = btrfs_zone_align(device, search_start);
+	}
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1467,12 +1477,21 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 			 */
 			if (contains_pending_extent(device, &search_start,
 						    hole_size)) {
+				search_start = btrfs_zone_align(device,
+								search_start);
 				if (key.offset >= search_start)
 					hole_size = key.offset - search_start;
 				else
 					hole_size = 0;
 			}
 
+			if (!btrfs_check_allocatable_zones(device, search_start,
+							   num_bytes)) {
+				search_start += zone_size;
+				btrfs_release_path(path);
+				goto again;
+			}
+
 			if (hole_size > max_hole_size) {
 				max_hole_start = search_start;
 				max_hole_size = hole_size;
@@ -1512,6 +1531,14 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 		hole_size = search_end - search_start;
 
 		if (contains_pending_extent(device, &search_start, hole_size)) {
+			search_start = btrfs_zone_align(device, search_start);
+			btrfs_release_path(path);
+			goto again;
+		}
+
+		if (!btrfs_check_allocatable_zones(device, search_start,
+						   num_bytes)) {
+			search_start += zone_size;
 			btrfs_release_path(path);
 			goto again;
 		}
@@ -1529,6 +1556,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 		ret = 0;
 
 out:
+	ASSERT(zone_size == 0 || IS_ALIGNED(max_hole_start, zone_size));
 	btrfs_free_path(path);
 	*start = max_hole_start;
 	if (len)
@@ -4778,6 +4806,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int i;
 	int j;
 	int index;
+	bool hmzoned = btrfs_fs_incompat(info, HMZONED);
 
 	BUG_ON(!alloc_profile_is_valid(type, 0));
 
@@ -4819,10 +4848,25 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		BUG();
 	}
 
+	if (hmzoned) {
+		max_stripe_size = info->zone_size;
+		max_chunk_size = round_down(max_chunk_size, info->zone_size);
+	}
+
 	/* We don't want a chunk larger than 10% of writable space */
 	max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
 			     max_chunk_size);
 
+	if (hmzoned) {
+		int min_num_stripes = devs_min * dev_stripes;
+		int min_data_stripes = (min_num_stripes - nparity) / ncopies;
+		u64 min_chunk_size = min_data_stripes * info->zone_size;
+
+		max_chunk_size = max(round_down(max_chunk_size,
+						info->zone_size),
+				     min_chunk_size);
+	}
+
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
 			       GFP_NOFS);
 	if (!devices_info)
@@ -4857,6 +4901,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (total_avail == 0)
 			continue;
 
+		if (hmzoned && total_avail < max_stripe_size * dev_stripes)
+			continue;
+
 		ret = find_free_dev_extent(device,
 					   max_stripe_size * dev_stripes,
 					   &dev_offset, &max_avail);
@@ -4875,6 +4922,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			continue;
 		}
 
+		if (hmzoned && max_avail < max_stripe_size * dev_stripes)
+			continue;
+
 		if (ndevs == fs_devices->rw_devices) {
 			WARN(1, "%s: found more than %llu devices\n",
 			     __func__, fs_devices->rw_devices);
@@ -4893,6 +4943,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
+again:
 	/*
 	 * Round down to number of usable stripes, devs_increment can be any
 	 * number so we can't use round_down()
@@ -4934,6 +4985,17 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	 * we try to reduce stripe_size.
 	 */
 	if (stripe_size * data_stripes > max_chunk_size) {
+		if (hmzoned) {
+			/*
+			 * stripe_size is fixed in HMZONED. Reduce ndevs
+			 * instead.
+			 */
+			ASSERT(nparity == 0);
+			ndevs = div_u64(max_chunk_size * ncopies,
+					stripe_size * dev_stripes);
+			goto again;
+		}
+
 		/*
 		 * Reduce stripe_size, round it up to a 16MB boundary again and
 		 * then use it, unless it ends up being even bigger than the
@@ -4947,6 +5009,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	/* align to BTRFS_STRIPE_LEN */
 	stripe_size = round_down(stripe_size, BTRFS_STRIPE_LEN);
 
+	ASSERT(!hmzoned || stripe_size == info->zone_size);
+
 	map = kmalloc(map_lookup_size(num_stripes), GFP_NOFS);
 	if (!map) {
 		ret = -ENOMEM;
@@ -7541,6 +7605,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		ret = -EUCLEAN;
 		goto out;
 	}
+
+	if (dev->zone_info) {
+		u64 zone_size = dev->zone_info->zone_size;
+
+		if (!IS_ALIGNED(physical_offset, zone_size) ||
+		    !IS_ALIGNED(physical_len, zone_size)) {
+			btrfs_err(fs_info,
+"dev extent devid %llu physical offset %llu len %llu is not aligned to device zone",
+				  devid, physical_offset, physical_len);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
 out:
 	free_extent_map(em);
 	return ret;
-- 
2.24.0

