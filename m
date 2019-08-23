Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D949ACB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404292AbfHWKLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47768 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404268AbfHWKL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555088; x=1598091088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PkAGPuAf4+o4HCUGAm6uDU8nUmd88+ZJFmJYjWagg+0=;
  b=epF/c+mr2DRIWVKWjA6X2xF92cIbfdqB0L7r1qPx7U7fAe7ecf+Nq0ns
   6WTWaD4KlcXaGbpSPUli/LzcpxFDw3Zug7ynHovM+lVsiB5XxC8WU9Hzm
   nwkENFquRcQU753AMXDgvJh8X+EZetm9o27LmfhPBLXi1fdra1tihw882
   RFcx/IrdqYG//zb4brKQvgeEwQzq7HiAtblX9fts0rkd4mGrujwCdRg24
   nZ7fDwWuHQdSUWcKeILFnIleXApPkIa4aWgzVZE5bf+RmUB3wsh0At6Zt
   xZbRFxiL7+JogpXuYfyfx+0WSvG3R20wdSVNyHFtS51ZV6e8cudugqL1V
   g==;
IronPort-SDR: 3MefvuzC0cZrOBxyyajj7ESpaTUpD8Esjwo3XNPIYSlKSJJ1I0i/xGAZKLltVdvO8KCZGQlKWe
 V/h/MbdpFGkxAHglk++unoWuU3ApT6bjSYiNGBEDbgmUqvVURZPDiS5kII+fNozJ/TnzEYXROq
 2XWR04gZkwE9jcBNTlMX59iDpAt4RKfk5k9+UYmP3bzhk8kMmMyqDzbEU+yD8Zm9vXZuw3aIzV
 eiQ1nIKDUxn2TalmzmIu6C9ic0cZyuXsi+BXTe6CIAvBj4p6ODL8l+Uq4YYKUBrA2KYzI9tO1W
 L0E=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096243"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:28 +0800
IronPort-SDR: gQjDT3bz/andIA3NtXxzj1hTsu4WA7Sn0OtjE5gJCE88gw+IJRjm/cXTLPtLe8ChObTC/yI6vJ
 Z3g8wRl60keHBmskKBvItn5zrsfYM7c199m56dUKd5Ft7/02zlA8Li6oFcyV+qmq4pZHA2WC8j
 wiG3xc3tn9pnqqKNLnXVELgNTqjtirI3r3vEO4tM/v1PWP1IXbz894TIDQ8K/sl1VYfnGN+k53
 rwwFvpmRgeOZL7vCDqH6XmzUwgXksK7FOBMncAndjZZ6iT6M/I1tcXzvnVmGKePlRD4qShq0yB
 qOHfPvTTS7t7qnOrR8d20b3B
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:46 -0700
IronPort-SDR: W1rTRW+bL5WrNQGF2uZpe4okjYMatRNenp+9NVuCVm8s1hDPvYoGN+Ocg/P9Q8aYzYWYfmo6cC
 qgIyxwBUFaEBPKH5W9G2PfdjMLfVeb9gFRlsyJJ7JkWf3bluhtde55yFluV3I7Jg3H4mCRYDKU
 Ecb/QTpmJnASRC4DlMQhKFJhJjUBbbW/NArBpPO7wRVsPjD1GFfbldy1mnA6c6mtn/5heeCDG/
 Kfh7VTqt0NB0q6/V5AzR9qnI7Soaw3AqSq6qKBrsr1itYC52PUd+yi+XNxg27aDuFr0siJo8xI
 qAA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:27 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 09/27] btrfs: align device extent allocation to zone boundary
Date:   Fri, 23 Aug 2019 19:10:18 +0900
Message-Id: <20190823101036.796932-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In HMZONED mode, align the device extents to zone boundaries so that a zone
reset affects only the device extent and does not change the state of
blocks in the neighbor device extents. Also, check that a region allocation
is always over empty same-type zones and it is not over any locations of
super block copies.

This patch also add a verification in verify_one_dev_extent() to check if
the device extent is align to zone boundary.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c |  6 ++++
 fs/btrfs/hmzoned.c     | 56 ++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h     | 10 ++++++
 fs/btrfs/volumes.c     | 77 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8b7eb22d508a..1020469ca61b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7638,6 +7638,12 @@ int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
 		min_free = div64_u64(min_free, dev_min);
 	}
 
+	/* We cannot allocate size less than zone_size anyway */
+	if (index == BTRFS_RAID_DUP)
+		min_free = max_t(u64, min_free, 2 * fs_info->zone_size);
+	else
+		min_free = max_t(u64, min_free, fs_info->zone_size);
+
 	mutex_lock(&fs_info->chunk_mutex);
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
 		u64 dev_offset;
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 4e4e727302d4..94f4f67e0548 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -12,6 +12,7 @@
 #include "volumes.h"
 #include "hmzoned.h"
 #include "rcu-string.h"
+#include "disk-io.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -261,3 +262,58 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 
 	return 0;
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
+ * 1) the region is not on non-empty zones,
+ * 2) all zones in the region have the same zone type,
+ * 3) it does not contain super block location, if the zones are
+ *    sequential.
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
+	if (find_next_zero_bit(zinfo->empty_zones, end, begin) != end)
+		return false;
+
+	if (btrfs_dev_is_sequential(device, pos)) {
+		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+			sb_pos = btrfs_sb_offset(i);
+			if (!(sb_pos + BTRFS_SUPER_INFO_SIZE <= pos ||
+			      pos + end <= sb_pos))
+				return false;
+		}
+
+		return find_next_zero_bit(zinfo->seq_zones, end, begin) == end;
+	}
+
+	return find_next_bit(zinfo->seq_zones, end, begin) == end;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 83579b2dc0a4..396ece5f9410 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -29,6 +29,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
 int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
+bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
+				   u64 num_bytes);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
@@ -95,4 +97,12 @@ static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
 	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
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
index ffa4de09666d..16094fc68552 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1572,6 +1572,7 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
 	u64 max_hole_size;
 	u64 extent_end;
 	u64 search_end = device->total_bytes;
+	u64 zone_size = 0;
 	int ret;
 	int slot;
 	struct extent_buffer *l;
@@ -1582,6 +1583,14 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
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
@@ -1646,12 +1655,21 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
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
@@ -1691,6 +1709,14 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
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
@@ -1708,6 +1734,7 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
 		ret = 0;
 
 out:
+	ASSERT(zone_size == 0 || IS_ALIGNED(max_hole_start, zone_size));
 	btrfs_free_path(path);
 	*start = max_hole_start;
 	if (len)
@@ -4951,6 +4978,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int i;
 	int j;
 	int index;
+	int hmzoned = btrfs_fs_incompat(info, HMZONED);
 
 	BUG_ON(!alloc_profile_is_valid(type, 0));
 
@@ -4991,10 +5019,25 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
@@ -5029,6 +5072,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (total_avail == 0)
 			continue;
 
+		if (hmzoned && total_avail < max_stripe_size * dev_stripes)
+			continue;
+
 		ret = find_free_dev_extent(device,
 					   max_stripe_size * dev_stripes,
 					   &dev_offset, &max_avail);
@@ -5047,6 +5093,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			continue;
 		}
 
+		if (hmzoned && max_avail < max_stripe_size * dev_stripes)
+			continue;
+
 		if (ndevs == fs_devices->rw_devices) {
 			WARN(1, "%s: found more than %llu devices\n",
 			     __func__, fs_devices->rw_devices);
@@ -5065,6 +5114,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
+again:
 	/* round down to number of usable stripes */
 	ndevs = round_down(ndevs, devs_increment);
 
@@ -5103,6 +5153,17 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
@@ -5116,6 +5177,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	/* align to BTRFS_STRIPE_LEN */
 	stripe_size = round_down(stripe_size, BTRFS_STRIPE_LEN);
 
+	ASSERT(!hmzoned || stripe_size == info->zone_size);
+
 	map = kmalloc(map_lookup_size(num_stripes), GFP_NOFS);
 	if (!map) {
 		ret = -ENOMEM;
@@ -7742,6 +7805,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
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
2.23.0

