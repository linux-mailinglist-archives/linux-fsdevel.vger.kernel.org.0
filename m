Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4C9564F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfHTExX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfHTExX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276803; x=1597812803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ai677rvWpTtGocwHpjzEcXgOD/ERjn3uyQqzNuN/eTU=;
  b=X1I7QPODNrmP5n6qfVBx9Jvz5J7EvrIL6XYK+X9FgWvrTnm2xaiXjZ0H
   ALfFPtW7XB074h7qIG9IhDxoUTEaUn0U4QHd/RtjnGKx5QvNRrIBrXYXN
   7hC8++H444bfKj0aOQhB4RcmZdcJ7DoLOCGkUjZGA7tUG2S0CUohd9mLz
   vndDsKne70noXYBV0Im2kVW2EwOaoPVM6QWYUkhulCGjyX2oIUc9ARUgE
   YZtYxLu3zcZrKaIKKO9s8JDkHhrJfO9CJWSJYH1nyhrfuHaSk+I4thAGm
   dp0k5LsJQa3kS4yrw6zW1jdRrHRMPDOhuFR5JW0IYNCKi1NKNWrUWZfpE
   w==;
IronPort-SDR: TRTg6VnBOEZ6l4Q2nT4YsuoCaSb/cm7fp8kX8vEwMIABvSudHq9Fi4NJaoZ6F4iaaA7kkmsqlw
 byYj6vCkY+YPLrV/Cc7qN/mNi3MvSf5AvHFdoFvGheuIhKOBPc8j6DhuYm+x/335TqGo9yK7B6
 HpeHYPpgjk/drkLZLI7B4N6bQ/otos8UW183kXl0m789JHE5Myo7apwTQWP1HtFGv3vO4qhsEh
 djqUyszdqhEKkhmr+Ti18907RUpvkML6SygTVsfSk2WkfP8172lWbgNSbWJ7/WNH3HTouprI3B
 fSk=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136311"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:22 +0800
IronPort-SDR: RZ1QMgk56b6PgUsx0kcPjnWs6iOSsTM2xUIi3GTnegtWvS7KFr0PKYPFDwcfF39RYf5SQIuY7d
 4m2wMDyB5B7xwC6iLf1WjdzRbmU9j0yrwPui9gT2llyEaCEYZslbZJZicyOC0zer8VA/mZk+Lu
 gGHmRkls7SUomrjCmwcKtoGhtFXPC3yYYBfWmvqE491I/xyO3xBhvZexQvYtfF666B1yfIYZUo
 HE8BfSVjyChVAD8zsRU0JJ8AGA/mO9pnZeFmdgKibRMy868+lTN1SY6MUmOd1grKejfyseUE8b
 N5G7ljFPwhLB00DvPLJf3Um0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:46 -0700
IronPort-SDR: my0DR+dwR3izy2tnqKK06TihZuC7EGipzY1zZVH2EeeO/ltdnvGFSBNMOSUjnPWPhhjRFhYQBq
 w6gUE2wod+GitNZhcZ0rbx/uDR4bef+bmzeJgPq4RV6kOVpcx/ugW3z4aAwqYbkDIttHhzmOBR
 dPXYBdJbzEW/+KdLxQ/L4mAh0TskHsS57qj1mKN9iujgPAgPoUQLJBe+rQF1SiztF0mZlJWc6B
 WIfwiilrc6IunTfGEBeXtsJL8RdJFKEtnFL2NbHmCRGmp7ctWkZ033tHRFR/RS54znIb1V4Exx
 /EM=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:19 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 10/15] btrfs-progs: align device extent allocation to zone boundary
Date:   Tue, 20 Aug 2019 13:52:53 +0900
Message-Id: <20190820045258.1571640-11-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/hmzoned.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 common/hmzoned.h |  2 ++
 kerncompat.h     |  2 ++
 volumes.c        | 72 ++++++++++++++++++++++++++++++++++++++++------
 volumes.h        |  7 +++++
 5 files changed, 149 insertions(+), 8 deletions(-)

diff --git a/common/hmzoned.c b/common/hmzoned.c
index 12eb8f551853..b1d9f5574d35 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -26,6 +26,8 @@
 #include "common/messages.h"
 #include "mkfs/common.h"
 #include "common/hmzoned.h"
+#include "volumes.h"
+#include "disk-io.h"
 
 #define BTRFS_REPORT_NR_ZONES	8192
 
@@ -272,3 +274,75 @@ int zero_zone_blocks(int fd, struct btrfs_zone_info *zinfo, off_t start,
 
 	return 0;
 }
+
+static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zone_info *zinfo = &device->zone_info;
+	unsigned int zno;
+
+	if (!zone_is_sequential(zinfo, pos))
+		return true;
+
+	zno = pos / zinfo->zone_size;
+	return zinfo->zones[zno].cond == BLK_ZONE_COND_EMPTY;
+}
+
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
+	struct btrfs_zone_info *zinfo = &device->zone_info;
+	u64 nzones, begin, end;
+	u64 sb_pos;
+	bool is_sequential;
+	int i;
+
+	if (zinfo->model == ZONED_NONE)
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
+	is_sequential = btrfs_dev_is_sequential(device, pos);
+	if (is_sequential) {
+		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+			sb_pos = btrfs_sb_offset(i);
+			if (!(sb_pos + BTRFS_SUPER_INFO_SIZE <= pos ||
+			      pos + end <= sb_pos))
+				return false;
+		}
+	}
+
+	while (num_bytes) {
+		if (!btrfs_dev_is_empty_zone(device, pos))
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
diff --git a/common/hmzoned.h b/common/hmzoned.h
index 75812716ffd9..93759291871f 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -53,6 +53,8 @@ enum btrfs_zoned_model zoned_model(const char *file);
 size_t zone_size(const char *file);
 int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
 			struct btrfs_zone_info *zinfo);
+bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
+				   u64 num_bytes);
 
 #ifdef BTRFS_ZONED
 bool zone_is_sequential(struct btrfs_zone_info *zinfo, u64 bytenr);
diff --git a/kerncompat.h b/kerncompat.h
index 9fdc58e25d43..b5105df20a3e 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -28,6 +28,7 @@
 #include <assert.h>
 #include <stddef.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <stdint.h>
 
 #include <features.h>
@@ -345,6 +346,7 @@ static inline void assert_trace(const char *assertion, const char *filename,
 
 /* Alignment check */
 #define IS_ALIGNED(x, a)                (((x) & ((typeof(x))(a) - 1)) == 0)
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
 
 static inline int is_power_of_2(unsigned long n)
 {
diff --git a/volumes.c b/volumes.c
index a0ebed547faa..14ca3df0efdb 100644
--- a/volumes.c
+++ b/volumes.c
@@ -465,6 +465,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	int slot;
 	struct extent_buffer *l;
 	u64 min_search_start;
+	u64 zone_size;
 
 	/*
 	 * We don't want to overwrite the superblock on the drive nor any area
@@ -473,6 +474,13 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	 */
 	min_search_start = max(root->fs_info->alloc_start, (u64)SZ_1M);
 	search_start = max(search_start, min_search_start);
+	/*
+	 * For a zoned block device, skip the first zone of the device
+	 * entirely.
+	 */
+	zone_size = device->zone_info.zone_size;
+	search_start = max_t(u64, search_start, zone_size);
+	search_start = btrfs_zone_align(device, search_start);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -481,6 +489,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	max_hole_start = search_start;
 	max_hole_size = 0;
 
+again:
 	if (search_start >= search_end) {
 		ret = -ENOSPC;
 		goto out;
@@ -525,6 +534,13 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
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
@@ -567,6 +583,13 @@ next:
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
@@ -610,6 +633,10 @@ int btrfs_insert_dev_extent(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 
+	/* Check alignment to zone for a zoned block device */
+	ASSERT(device->zone_info.model != ZONED_HOST_MANAGED ||
+	       IS_ALIGNED(start, device->zone_info.zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -1012,17 +1039,13 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int max_stripes = 0;
 	int min_stripes = 1;
 	int sub_stripes;	/* sub_stripes info for map */
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
@@ -1030,6 +1053,8 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int stripe_len = BTRFS_STRIPE_LEN;
 	struct btrfs_key key;
 	u64 offset;
+	bool hmzoned = info->fs_devices->hmzoned;
+	u64 zone_size = info->fs_devices->zone_size;
 
 	if (list_empty(dev_list)) {
 		return -ENOSPC;
@@ -1116,13 +1141,39 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 				    btrfs_super_stripesize(info->super_copy));
 	}
 
+	if (hmzoned) {
+		calc_size = zone_size;
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
+			num_stripes = max_chunk_size / calc_size;
+			if (num_stripes < min_stripes)
+				return -ENOSPC;
+			goto again;
+		}
+
 		calc_size = max_chunk_size;
 		calc_size /= num_stripes;
 		calc_size /= stripe_len;
@@ -1133,6 +1184,9 @@ again:
 
 	calc_size /= stripe_len;
 	calc_size *= stripe_len;
+
+	ASSERT(!hmzoned || calc_size == zone_size);
+
 	INIT_LIST_HEAD(&private_devs);
 	cur = dev_list->next;
 	index = 0;
@@ -1214,6 +1268,8 @@ again:
 		if (ret < 0)
 			goto out_chunk_map;
 
+		ASSERT(!zone_size || IS_ALIGNED(dev_offset, zone_size));
+
 		device->bytes_used += calc_size;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
diff --git a/volumes.h b/volumes.h
index b5e7a07df5a8..d1326d068ca3 100644
--- a/volumes.h
+++ b/volumes.h
@@ -323,4 +323,11 @@ static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
 	return zone_is_sequential(&device->zone_info, pos);
 }
+static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
+{
+	if (device->zone_info.model == ZONED_NONE)
+		return pos;
+
+	return ALIGN(pos, device->zone_info.zone_size);
+}
 #endif
-- 
2.23.0

