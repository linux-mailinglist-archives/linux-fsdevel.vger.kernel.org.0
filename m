Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FF1124DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfLDI1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLDI1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448078; x=1606984078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyFEVNdxrKbsPoFlkUzanLUNBnNj0svoO45/fjA8xoU=;
  b=h3nP9Lcl7X3i8DY73c3P9MBKJnHew3H/HWDUMXgqA8fwlSWRhAYiSVvM
   c3Px6d392KNtDQ4+sL1IMMPc2ni9LNGAIXsVwKzXr2KANqIQ2QthBL9HA
   4SJuaPSvA6ObWLEZ/NkCU+hYIblHAKdX6o6l+U0lVjnizLnUf5FTuge8j
   Vr6q/hpO46LP/QxAwidaDCQX0sKr7yW5yFE3iqmzexlhZ/QW4dSDi5pSb
   aNI24GaUGmdj9sy2PVonvRL9vPikxMAeBLThGgbhd9TOTex4i5ee4TWNs
   6thNrO/zI9e7lOygEeX3HibEsz/qH1Yu+4L1reDpb+1mKqDcRyk3YCvRj
   w==;
IronPort-SDR: Xmchn2s/akEZzQ+g5RIumXbV/XCrbahoLX+7JR6H7V1aEnYuEgsQfFL4t1RRg83S1NSFy4w7ks
 rPUDTmGDyHCs/AY1RWBG+Ws8zRZ2Bm+qq70DmTeiLRFoUXUnQP3l2e7prx6qnXYhDOJeJZIjDV
 2aM+LFddKi32/ZKHQDk6aVhwFagHWLkQJmArvzw11atbjZqoPurxrnlzzumzM3JAAGTIt/9G3V
 q6A3x2dwsRI1O3gABVhCEOwUhTyBxb06jQBBNM2H46GGOaeDv4GiBgciQifG07YaoRboY9itmw
 hIU=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031755"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:57 +0800
IronPort-SDR: r46LPXJSf3Xa1nSgJWdthJMmZKy5Q0uhYYPQEN9l10iYoIWYIlE0n8RDOseZ21EQjpwALU/QMP
 49QQKvjJqpdFQtSVaq+IfvEaMXW+l1VEDho4rnefucuRiOYngmiJ0xFILwPgZ/k3MXx2FsTSNP
 pW5UOXZf4fFgxaxkT/UUBrUtvI17YBjJg7cD+Du2l4WxBLofngFVm9q/ewdkJMRcyStbnLr2W1
 mi/QW2itwHkYyGZBtG4iP+896JE2yS0KNsZx9cbgrkD5El3KUSYqP5Qe8fbzWXvXn8cV28dmC7
 SP8iPCj835WzI4zBJrXFySF0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:38 -0800
IronPort-SDR: pe1aBi0sDVQgMMTSbl2G8xLn8VSskCdy2CDwFTMpUz+gJEEyR+ctbM/Iqdu5UrM/KYW1MR4FjG
 t5jNUYxyalzZksfY1DM85lE2qBXyP/6GuBm7JtLSWdGGusw7wAf02hHYo0SvrFr+jeViDSMNrz
 rzBaCCumE6JpM2Il14/aAlcA/Rd0LrLzyhXhEqv7wCeTAaL4TDuf8O5gnT4MRv4VDU4OM2A3pq
 dyBZStThtY75gdviLByxkz8pnyrkvNAH4WLcb+/j3H9h3z58mt9A9cEmFYTnZu8PZtes/pOWwp
 WG4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:50 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 10/15] btrfs-progs: align device extent allocation to zone boundary
Date:   Wed,  4 Dec 2019 17:25:08 +0900
Message-Id: <20191204082513.857320-11-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/hmzoned.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 common/hmzoned.h | 23 +++++++++++++++
 kerncompat.h     |  2 ++
 volumes.c        | 76 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 163 insertions(+), 8 deletions(-)

diff --git a/common/hmzoned.c b/common/hmzoned.c
index 5080bd7dea5b..2cbf2fc88cb0 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -24,6 +24,8 @@
 #include "common/messages.h"
 #include "mkfs/common.h"
 #include "common/hmzoned.h"
+#include "volumes.h"
+#include "disk-io.h"
 
 #define BTRFS_REPORT_NR_ZONES	8192
 
@@ -435,6 +437,74 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 	return ret_sz;
 }
 
+static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	unsigned int zno;
+
+	if (!zone_is_sequential(zinfo, pos))
+		return true;
+
+	zno = pos / zinfo->zone_size;
+	return zinfo->zones[zno].cond == BLK_ZONE_COND_EMPTY;
+}
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
+ * 3) it does not contain super block location
+ */
+bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
+				   u64 num_bytes)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u64 nzones, begin, end;
+	u64 sb_pos;
+	bool is_sequential;
+	int i;
+
+	if (!zinfo || zinfo->model == ZONED_NONE)
+		return true;
+
+	nzones = num_bytes / zinfo->zone_size;
+	begin = pos / zinfo->zone_size;
+	end = begin + nzones;
+
+	ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
+
+	if (end > zinfo->nr_zones)
+		return false;
+
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		sb_pos = sb_zone_number(zinfo->zone_size, i);
+		if (!(end < sb_pos || sb_pos + 1 < begin))
+			return false;
+	}
+
+	is_sequential = btrfs_dev_is_sequential(device, pos);
+
+	while (num_bytes) {
+		if (is_sequential && !btrfs_dev_is_empty_zone(device, pos))
+			return false;
+		if (is_sequential != btrfs_dev_is_sequential(device, pos))
+			return false;
+
+		pos += zinfo->zone_size;
+		num_bytes -= zinfo->zone_size;
+	}
+
+	return true;
+}
+
 #endif
 
 int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
diff --git a/common/hmzoned.h b/common/hmzoned.h
index 920f992dbb93..3444e2c1b0f5 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -19,6 +19,7 @@
 #define __BTRFS_HMZONED_H__
 
 #include <stdbool.h>
+#include "volumes.h"
 
 #ifdef BTRFS_ZONED
 #include <linux/blkzoned.h>
@@ -67,6 +68,8 @@ static inline size_t sbwrite(int fd, void *buf, off_t offset)
 	return btrfs_sb_io(fd, buf, offset, WRITE);
 }
 int btrfs_wipe_sb_zones(int fd, struct btrfs_zoned_device_info *zinfo);
+bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
+				   u64 num_bytes);
 #else
 static inline bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo,
 				      u64 bytenr)
@@ -97,6 +100,26 @@ static inline int btrfs_wipe_sb_zones(int fd,
 {
 	return 0;
 }
+static inline bool btrfs_check_allocatable_zones(struct btrfs_device *device,
+						 u64 pos, u64 num_bytes)
+{
+	return true;
+}
+
 #endif /* BTRFS_ZONED */
 
+static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
+{
+	return zone_is_sequential(device->zone_info, pos);
+}
+static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+
+	if (!zinfo || zinfo->model == ZONED_NONE)
+		return pos;
+
+	return ALIGN(pos, zinfo->zone_size);
+}
+
 #endif /* __BTRFS_HMZONED_H__ */
diff --git a/kerncompat.h b/kerncompat.h
index c38643437747..58cdcf921c5e 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -28,6 +28,7 @@
 #include <assert.h>
 #include <stddef.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <stdint.h>
 
 #include <features.h>
@@ -354,6 +355,7 @@ static inline void assert_trace(const char *assertion, const char *filename,
 
 /* Alignment check */
 #define IS_ALIGNED(x, a)                (((x) & ((typeof(x))(a) - 1)) == 0)
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
 
 static inline int is_power_of_2(unsigned long n)
 {
diff --git a/volumes.c b/volumes.c
index d92052e19330..148169d5b2a2 100644
--- a/volumes.c
+++ b/volumes.c
@@ -496,6 +496,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	int slot;
 	struct extent_buffer *l;
 	u64 min_search_start;
+	u64 zone_size = 0;
 
 	/*
 	 * We don't want to overwrite the superblock on the drive nor any area
@@ -504,6 +505,14 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	 */
 	min_search_start = max(root->fs_info->alloc_start, (u64)SZ_1M);
 	search_start = max(search_start, min_search_start);
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
@@ -512,6 +521,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	max_hole_start = search_start;
 	max_hole_size = 0;
 
+again:
 	if (search_start >= search_end) {
 		ret = -ENOSPC;
 		goto out;
@@ -556,6 +566,13 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 			goto next;
 
 		if (key.offset > search_start) {
+			if (!btrfs_check_allocatable_zones(device, search_start,
+							   num_bytes)) {
+				search_start += zone_size;
+				btrfs_release_path(path);
+				goto again;
+			}
+
 			hole_size = key.offset - search_start;
 
 			/*
@@ -598,6 +615,13 @@ next:
 	 * search_end may be smaller than search_start.
 	 */
 	if (search_end > search_start) {
+		if (!btrfs_check_allocatable_zones(device, search_start,
+						   num_bytes)) {
+			search_start += zone_size;
+			btrfs_release_path(path);
+			goto again;
+		}
+
 		hole_size = search_end - search_start;
 
 		if (hole_size > max_hole_size) {
@@ -613,6 +637,7 @@ next:
 		ret = 0;
 
 out:
+	ASSERT(zone_size == 0 || IS_ALIGNED(max_hole_start, zone_size));
 	btrfs_free_path(path);
 	*start = max_hole_start;
 	if (len)
@@ -641,6 +666,11 @@ int btrfs_insert_dev_extent(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 
+	/* Check alignment to zone for a zoned block device */
+	ASSERT(!device->zone_info ||
+	       device->zone_info->model != ZONED_HOST_MANAGED ||
+	       IS_ALIGNED(start, device->zone_info->zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -1045,17 +1075,13 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int max_stripes = 0;
 	int min_stripes = 1;
 	int sub_stripes = 1;
-	int dev_stripes __attribute__((unused));
-				/* stripes per dev */
+	int dev_stripes;	/* stripes per dev */
 	int devs_max;		/* max devs to use */
-	int devs_min __attribute__((unused));
-				/* min devs needed */
+	int devs_min;		/* min devs needed */
 	int devs_increment __attribute__((unused));
 				/* ndevs has to be a multiple of this */
-	int ncopies __attribute__((unused));
-				/* how many copies to data has */
-	int nparity __attribute__((unused));
-				/* number of stripes worth of bytes to
+	int ncopies;		/* how many copies to data has */
+	int nparity;		/* number of stripes worth of bytes to
 				   store parity information */
 	int looped = 0;
 	int ret;
@@ -1063,6 +1089,8 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int stripe_len = BTRFS_STRIPE_LEN;
 	struct btrfs_key key;
 	u64 offset;
+	bool hmzoned = info->fs_devices->hmzoned;
+	u64 zone_size = info->fs_devices->zone_size;
 
 	if (list_empty(dev_list)) {
 		return -ENOSPC;
@@ -1163,13 +1191,40 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 				    btrfs_super_stripesize(info->super_copy));
 	}
 
+	if (hmzoned) {
+		calc_size = zone_size;
+		max_chunk_size = max(max_chunk_size, zone_size);
+		max_chunk_size = round_down(max_chunk_size, zone_size);
+	}
+
 	/* we don't want a chunk larger than 10% of the FS */
 	percent_max = div_factor(btrfs_super_total_bytes(info->super_copy), 1);
 	max_chunk_size = min(percent_max, max_chunk_size);
 
+	if (hmzoned) {
+		int min_num_stripes = devs_min * dev_stripes;
+		int min_data_stripes = (min_num_stripes - nparity) / ncopies;
+		u64 min_chunk_size = min_data_stripes * zone_size;
+
+		max_chunk_size = max(round_down(max_chunk_size,
+						zone_size),
+				     min_chunk_size);
+	}
+
 again:
 	if (chunk_bytes_by_type(type, calc_size, num_stripes, sub_stripes) >
 	    max_chunk_size) {
+		if (hmzoned) {
+			/*
+			 * calc_size is fixed in HMZONED. Reduce
+			 * num_stripes instead.
+			 */
+			num_stripes = max_chunk_size * ncopies / calc_size;
+			if (num_stripes < min_stripes)
+				return -ENOSPC;
+			goto again;
+		}
+
 		calc_size = max_chunk_size;
 		calc_size /= num_stripes;
 		calc_size /= stripe_len;
@@ -1180,6 +1235,9 @@ again:
 
 	calc_size /= stripe_len;
 	calc_size *= stripe_len;
+
+	ASSERT(!hmzoned || calc_size == zone_size);
+
 	INIT_LIST_HEAD(&private_devs);
 	cur = dev_list->next;
 	index = 0;
@@ -1261,6 +1319,8 @@ again:
 		if (ret < 0)
 			goto out_chunk_map;
 
+		ASSERT(!zone_size || IS_ALIGNED(dev_offset, zone_size));
+
 		device->bytes_used += calc_size;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
-- 
2.24.0

