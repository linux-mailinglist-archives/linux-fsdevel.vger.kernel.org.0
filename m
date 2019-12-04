Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB2112467
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfLDITo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:44 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32758 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfLDITm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447582; x=1606983582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Scgk1UGcHjVUcY8q8+HTOzN6mjROoby6LofxBATJgk0=;
  b=iib5ezi/V2/FA5Q1arlbVXLciTmdy6ONg0He3/cacniAJSc9GY8+pqyI
   yjCf20IjGCf7zEbTsdKbdV0bfi7V2MPFS1xNWsVPUu4uBee813nnm06N3
   ywPyBVCCvkeGy1qKKv7lNLKKG+jio+x1+dl02D5ar1VzS7WbDJR8xJuox
   NnwXmITjI/WdUAv9EoeuZf+zok7EKCzOvAOm0AgTiw4TAlJP82ufXR+xK
   RHlQx6+l0unz5nVIH3tmA6+hT2H7wgHGiHXre44ZJ9O8DYupYKKHb2FIi
   YGXQxG6241W7pGDghqNufGQ9EuzvxWKqwle2k4x1gDoMBdaYcBkGiDQDv
   Q==;
IronPort-SDR: 55wiYCs0sRIdMiuCOmPkW1kfg7u0MSjskskzIuuHth+ReBYsAcl1iG/wnieqgpw9QvKXUXqcQM
 LkQOcWmX+KmgvkXNxiytladakjAiLCqcWccar9gjh7c/IyOeUIWaCu5S9xl25EBvIVYanhNQvn
 ALnfx2ybL+tmPwvOb9ikTZ6axarLXXPbfBRPnQaFJ3SZu22/tpoEy1/EaQVr7JQNBrHXSssXKb
 10MrAirYi08ikYq90Hb8KiyNlsSFZFfrawaPZCIsWH83XH+W4tPntrBUGzFQxQLVv9qxijUH1b
 OwI=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355055"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:42 +0800
IronPort-SDR: nPHcUXaiNb9vMuQ4/7yqnusDwKX3DhAHQpml9CykAzBKldL32qavlJ9rCqqYZ64rSmoK4dGN2P
 yL3KUAlG4dnxgNi2COUzcqvYzDVHqDLZEDkEHyK4wFq+0rqCNqHcrEbnLK7zkQNsJ+/mCYyqq7
 Z/LtVmGOojx0PDm7tWIqPE1kjE+wkT4WeLEQ0Nw0nvTexZCu8ozphLJfxKyEzEKfPgf1cHdDbO
 1+8Ge01h9hwNnSzvmecJhNBqW8lq3N/LR/I5URc1+1QR/3dXGsGcsyxfKfymkaGTH/wW9beH+k
 sB9okT76AqL5RSpZht0ZS1E8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:07 -0800
IronPort-SDR: FDmbYRKd+IEix9ZsQbMmRdkPhSdKYvmk4BT8bk/BVdccS/X7GoPeZX6BZwvJhArauHhK+mxMef
 KI39QZCQXcW8YqMAEJYqqK22iEuqvn+xxAkoDbMwQ5sUbMNUa6CX39T0LhnFoOnfdHNqGY43gW
 CVdY9kg+oe8l16gaxvGfqybl5jSBwYxOYakGkmOw8Y0yrIg78/sdlX7Gb9fySEojq/45VnL2bT
 02GqI2QvZAP+sRkH7+ZVfLV+nX/z5BPbaC8S4NBUKoRmpBg4AFHeVY/E44g7dSOL7yydyh8ZRi
 U54=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:39 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 09/28] btrfs: align device extent allocation to zone boundary
Date:   Wed,  4 Dec 2019 17:17:16 +0900
Message-Id: <20191204081735.852438-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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
 fs/btrfs/hmzoned.c | 55 +++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h | 15 +++++++++
 fs/btrfs/volumes.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 599c493f44b0..9a814ad1b0a5 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -12,6 +12,7 @@
 #include "volumes.h"
 #include "hmzoned.h"
 #include "rcu-string.h"
+#include "disk-io.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -553,3 +554,57 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
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
index a260648cecca..d058ea613627 100644
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
@@ -1403,6 +1404,14 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	 * at an offset of at least 1MB.
 	 */
 	search_start = max_t(u64, search_start, SZ_1M);
+	/*
+	 * For a zoned block device, skip the first zone of the device
+	 * entirely.
+	 */
+	if (device->zone_info)
+		zone_size = device->zone_info->zone_size;
+	search_start = max_t(u64, search_start, zone_size);
+	search_start = btrfs_zone_align(device, search_start);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1467,12 +1476,21 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
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
@@ -1512,6 +1530,14 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
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
@@ -1529,6 +1555,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 		ret = 0;
 
 out:
+	ASSERT(zone_size == 0 || IS_ALIGNED(max_hole_start, zone_size));
 	btrfs_free_path(path);
 	*start = max_hole_start;
 	if (len)
@@ -4778,6 +4805,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int i;
 	int j;
 	int index;
+	int hmzoned = btrfs_fs_incompat(info, HMZONED);
 
 	BUG_ON(!alloc_profile_is_valid(type, 0));
 
@@ -4819,10 +4847,25 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
@@ -4857,6 +4900,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (total_avail == 0)
 			continue;
 
+		if (hmzoned && total_avail < max_stripe_size * dev_stripes)
+			continue;
+
 		ret = find_free_dev_extent(device,
 					   max_stripe_size * dev_stripes,
 					   &dev_offset, &max_avail);
@@ -4875,6 +4921,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			continue;
 		}
 
+		if (hmzoned && max_avail < max_stripe_size * dev_stripes)
+			continue;
+
 		if (ndevs == fs_devices->rw_devices) {
 			WARN(1, "%s: found more than %llu devices\n",
 			     __func__, fs_devices->rw_devices);
@@ -4893,6 +4942,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
+again:
 	/*
 	 * Round down to number of usable stripes, devs_increment can be any
 	 * number so we can't use round_down()
@@ -4934,6 +4984,17 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
@@ -4947,6 +5008,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	/* align to BTRFS_STRIPE_LEN */
 	stripe_size = round_down(stripe_size, BTRFS_STRIPE_LEN);
 
+	ASSERT(!hmzoned || stripe_size == info->zone_size);
+
 	map = kmalloc(map_lookup_size(num_stripes), GFP_NOFS);
 	if (!map) {
 		ret = -ENOMEM;
@@ -7541,6 +7604,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
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

