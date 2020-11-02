Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B52A3665
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 23:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgKBWVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 17:21:51 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2280 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgKBWVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604355710; x=1635891710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dTFvMUUMYOuHYP6C6sjwvOno8z3vF+b+NZoTf9DliaE=;
  b=iu2IdcGHPiCkzmWm9o5c9Ylmz8uw8pwgpr+dNg+DBuaDAO+yOAx1uJnS
   67LHkxlfigFof862lzwIKxVKbgpyHLabZM0cNHCotfgQmiXg5GcdeKkxN
   gOyyRDewGaEIzebCE7N+Xeh4p45zv3axAxIzdyilsVmUzm6WV2gOKGxCw
   VWJDDEvZWewnWw87Gsn/450vBi5b3MvhuvihC4Xti9KQx55UzVIlpmzCy
   8D5XLqaAU2aYq78p11kIuGMY4YEfRg8PG6sceaJrwzHZtyBxMVtaX23EV
   Hd8CqDgQQyJEP5semryYlsTNMVsSqskt2Z1+/sEXmvAYLPCeGavgiGjAi
   Q==;
IronPort-SDR: CBFDdCTJOLWtC7+tShjWXuCrb2TllQY4mXffBOyHlwRn08tn/l+mYlYW+cMX9me9Chbqt5Evcq
 4E6bAR3Z3uwOHOYEC8yoJi1naA9fSCzUpXb4KECLg+b7yxL1P7tVjBTPp8tIyPxbCOoq7G2s/S
 /kgAHLoxG49n7jcI2wMyfpw0hU+iHpwQG7GQu0gUiPUYoVXP1hUW7mia+woFycMr86R1IsqbuO
 oGEYIUSkAV7ipG0TkKeqar37I6bJGTGJ9cGjaxI/q57O5vE4G0eutlH2TWSZngjoPCzOdVkEuu
 czU=
X-IronPort-AV: E=Sophos;i="5.77,446,1596470400"; 
   d="scan'208";a="152793775"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 06:21:50 +0800
IronPort-SDR: Yf6tTYqM2sFAr+rei6vfJw2AfVOs23sAPwjTeYAga19yxIVNdaL2yu4gMBKgERS2FKEkvmZzhV
 h22wD8OnEVED5/ga4UHmlNNI7f9UZ/E4QhOYv3OPCsoYQG6yV+qT5hsyAWlHzsQI9/rsyuuWTo
 WnVKimOOh51rgfNtZEwwFVZiDRm3/DT8V+r/sRqEhfBpJWD44ip2oyc2TAqIk0nf81E4CUz/iL
 QIr9T/q4VFuv6jw3V3d5nIWKke+smbzKFy2eftkn/ChJfyQcj0FFHM5ntPGL6sOZbywCb/8VrC
 LCSSptI3wWda7C2OK8q00h/V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 14:06:49 -0800
IronPort-SDR: xV3oDOPIEYBXNA0fiiiluucEd6nXOTETB8XnWSZP4w7pB/9GIa4FQcLzgQtWT8dtCFEKw8kSAh
 iVl6JB3INjyfCpI1034uPdz4oJrjzMde1hli4te0ZJBi5F+JTsmM6p/88nFkEs0sfsAzaT5+tj
 05okwvq3CqMWo7HwWLIPuVltQJHVxv91pDh89UwpZ8dwp11/4obXPQVrJpiuDLiXmBVBnvK71i
 fqGf6SBQLSLWrjb/ssVVBml/xBGewLNMuAEIFw0am6Oj0pjylnxzLgb3JPWkxcrLYqWr/Hdmt2
 gDg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 02 Nov 2020 14:21:49 -0800
Received: (nullmailer pid 3794692 invoked by uid 1000);
        Mon, 02 Nov 2020 22:21:48 -0000
Date:   Tue, 3 Nov 2020 07:21:48 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 12/41] btrfs: implement zoned chunk allocator
Message-ID: <20201102222148.tc4e3li6qu4gmxeh@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <5b9798f6e4c317e6a2c433ef88ffeabe00b93bb3.1604065695.git.naohiro.aota@wdc.com>
 <54c78c27-37ad-7b42-7d0a-2b1b46c69dac@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <54c78c27-37ad-7b42-7d0a-2b1b46c69dac@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:09:58PM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>This commit implements a zoned chunk/dev_extent allocator. The zoned
>>allocator aligns the device extents to zone boundaries, so that a zone
>>reset affects only the device extent and does not change the state of
>>blocks in the neighbor device extents.
>>
>>Also, it checks that a region allocation is not overlapping any of the
>>super block zones, and ensures the region is empty.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/volumes.c | 131 +++++++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/volumes.h |   1 +
>>  fs/btrfs/zoned.c   | 126 +++++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/zoned.h   |  30 +++++++++++
>>  4 files changed, 288 insertions(+)
>>
>>diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>index db884b96a5ea..78c62ef02e6f 100644
>>--- a/fs/btrfs/volumes.c
>>+++ b/fs/btrfs/volumes.c
>>@@ -1416,6 +1416,14 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
>>  	return false;
>>  }
>>+static inline u64 dev_extent_search_start_zoned(struct btrfs_device *device,
>>+						u64 start)
>>+{
>>+	start = max_t(u64, start,
>>+		      max_t(u64, device->zone_info->zone_size, SZ_1M));
>>+	return btrfs_zone_align(device, start);
>>+}
>>+
>>  static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>>  {
>>  	switch (device->fs_devices->chunk_alloc_policy) {
>>@@ -1426,11 +1434,57 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>>  		 * make sure to start at an offset of at least 1MB.
>>  		 */
>>  		return max_t(u64, start, SZ_1M);
>>+	case BTRFS_CHUNK_ALLOC_ZONED:
>>+		return dev_extent_search_start_zoned(device, start);
>>  	default:
>>  		BUG();
>>  	}
>>  }
>>+static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
>>+					u64 *hole_start, u64 *hole_size,
>>+					u64 num_bytes)
>>+{
>>+	u64 zone_size = device->zone_info->zone_size;
>>+	u64 pos;
>>+	int ret;
>>+	int changed = 0;
>>+
>>+	ASSERT(IS_ALIGNED(*hole_start, zone_size));
>>+
>>+	while (*hole_size > 0) {
>>+		pos = btrfs_find_allocatable_zones(device, *hole_start,
>>+						   *hole_start + *hole_size,
>>+						   num_bytes);
>>+		if (pos != *hole_start) {
>>+			*hole_size = *hole_start + *hole_size - pos;
>>+			*hole_start = pos;
>>+			changed = 1;
>>+			if (*hole_size < num_bytes)
>>+				break;
>>+		}
>>+
>>+		ret = btrfs_ensure_empty_zones(device, pos, num_bytes);
>>+
>>+		/* range is ensured to be empty */
>>+		if (!ret)
>>+			return changed;
>>+
>>+		/* given hole range was invalid (outside of device) */
>>+		if (ret == -ERANGE) {
>>+			*hole_start += *hole_size;
>>+			*hole_size = 0;
>>+			return 1;
>>+		}
>>+
>>+		*hole_start += zone_size;
>>+		*hole_size -= zone_size;
>>+		changed = 1;
>>+	}
>>+
>>+	return changed;
>>+}
>>+
>>  /**
>>   * dev_extent_hole_check - check if specified hole is suitable for allocation
>>   * @device:	the device which we have the hole
>>@@ -1463,6 +1517,10 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
>>  	case BTRFS_CHUNK_ALLOC_REGULAR:
>>  		/* No extra check */
>>  		break;
>>+	case BTRFS_CHUNK_ALLOC_ZONED:
>>+		changed |= dev_extent_hole_check_zoned(device, hole_start,
>>+						       hole_size, num_bytes);
>I'm confused here, we check to make sure the pending stuff doesn't 
>overlap with non-empty zones.  However we don't ever actually mark 
>zones as non-empty except on mount.  I realize that if we allocate 
>this zone then it appears pending and thus we won't allocate with this 
>zone again while the fs is mounted, but it took me a while to realize 
>this.  Is there a reason to not mark a zone as non-empty when we 
>allocate from it?

It's marking the zones as non-empty. Allocated zones eventually
construct a block group in btrfs_make_block_group(). The function calls
btrfs_load_block_group_zone_info() and that will clear the empty flag.

>
>
>>+		break;
>>  	default:
>>  		BUG();
>>  	}
>>@@ -1517,6 +1575,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
>>  	search_start = dev_extent_search_start(device, search_start);
>>+	WARN_ON(device->zone_info &&
>>+		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
>>+
>>  	path = btrfs_alloc_path();
>>  	if (!path)
>>  		return -ENOMEM;
>>@@ -4907,6 +4968,37 @@ static void init_alloc_chunk_ctl_policy_regular(
>>  	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
>>  }
>>+static void
>>+init_alloc_chunk_ctl_policy_zoned(struct btrfs_fs_devices *fs_devices,
>>+				  struct alloc_chunk_ctl *ctl)
>>+{
>>+	u64 zone_size = fs_devices->fs_info->zone_size;
>>+	u64 limit;
>>+	int min_num_stripes = ctl->devs_min * ctl->dev_stripes;
>>+	int min_data_stripes = (min_num_stripes - ctl->nparity) / ctl->ncopies;
>>+	u64 min_chunk_size = min_data_stripes * zone_size;
>>+	u64 type = ctl->type;
>>+
>>+	ctl->max_stripe_size = zone_size;
>>+	if (type & BTRFS_BLOCK_GROUP_DATA) {
>>+		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
>>+						 zone_size);
>>+	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
>>+		ctl->max_chunk_size = ctl->max_stripe_size;
>>+	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
>>+		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
>>+		ctl->devs_max = min_t(int, ctl->devs_max,
>>+				      BTRFS_MAX_DEVS_SYS_CHUNK);
>>+	}
>>+
>>+	/* We don't want a chunk larger than 10% of writable space */
>>+	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
>>+			       zone_size),
>>+		    min_chunk_size);
>>+	ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
>>+	ctl->dev_extent_min = zone_size * ctl->dev_stripes;
>>+}
>>+
>>  static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
>>  				 struct alloc_chunk_ctl *ctl)
>>  {
>>@@ -4927,6 +5019,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
>>  	case BTRFS_CHUNK_ALLOC_REGULAR:
>>  		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
>>  		break;
>>+	case BTRFS_CHUNK_ALLOC_ZONED:
>>+		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
>>+		break;
>>  	default:
>>  		BUG();
>>  	}
>>@@ -5053,6 +5148,40 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
>>  	return 0;
>>  }
>>+static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
>>+				    struct btrfs_device_info *devices_info)
>>+{
>>+	u64 zone_size = devices_info[0].dev->zone_info->zone_size;
>>+	/* number of stripes that count for block group size */
>>+	int data_stripes;
>>+
>>+	/*
>>+	 * It should hold because:
>>+	 *    dev_extent_min == dev_extent_want == zone_size * dev_stripes
>>+	 */
>>+	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min);
>>+
>>+	ctl->stripe_size = zone_size;
>>+	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
>>+	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
>>+
>>+	/*
>>+	 * stripe_size is fixed in ZONED. Reduce ndevs instead.
>>+	 */
>>+	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
>>+		ctl->ndevs = div_u64(div_u64(ctl->max_chunk_size * ctl->ncopies,
>>+					     ctl->stripe_size) + ctl->nparity,
>>+				     ctl->dev_stripes);
>>+		ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
>>+		data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
>>+		ASSERT(ctl->stripe_size * data_stripes <= ctl->max_chunk_size);
>>+	}
>>+
>>+	ctl->chunk_size = ctl->stripe_size * data_stripes;
>>+
>>+	return 0;
>>+}
>>+
>>  static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>>  			      struct alloc_chunk_ctl *ctl,
>>  			      struct btrfs_device_info *devices_info)
>>@@ -5080,6 +5209,8 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>>  	switch (fs_devices->chunk_alloc_policy) {
>>  	case BTRFS_CHUNK_ALLOC_REGULAR:
>>  		return decide_stripe_size_regular(ctl, devices_info);
>>+	case BTRFS_CHUNK_ALLOC_ZONED:
>>+		return decide_stripe_size_zoned(ctl, devices_info);
>>  	default:
>>  		BUG();
>>  	}
>>diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>>index 9c07b97a2260..0249aca668fb 100644
>>--- a/fs/btrfs/volumes.h
>>+++ b/fs/btrfs/volumes.h
>>@@ -213,6 +213,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>>  enum btrfs_chunk_allocation_policy {
>>  	BTRFS_CHUNK_ALLOC_REGULAR,
>>+	BTRFS_CHUNK_ALLOC_ZONED,
>>  };
>>  struct btrfs_fs_devices {
>>diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>index d5487cba203b..4411d786597a 100644
>>--- a/fs/btrfs/zoned.c
>>+++ b/fs/btrfs/zoned.c
>>@@ -1,11 +1,13 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>+#include <linux/bitops.h>
>>  #include <linux/slab.h>
>>  #include <linux/blkdev.h>
>>  #include "ctree.h"
>>  #include "volumes.h"
>>  #include "zoned.h"
>>  #include "rcu-string.h"
>>+#include "disk-io.h"
>>  /* Maximum number of zones to report per blkdev_report_zones() call */
>>  #define BTRFS_REPORT_NR_ZONES   4096
>>@@ -328,6 +330,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>>  	fs_info->zone_size = zone_size;
>>  	fs_info->max_zone_append_size = max_zone_append_size;
>>+	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
>>  	btrfs_info(fs_info, "ZONED mode enabled, zone size %llu B",
>>  		   fs_info->zone_size);
>>@@ -607,3 +610,126 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
>>  				sb_zone << zone_sectors_shift, zone_sectors * 2,
>>  				GFP_NOFS);
>>  }
>>+
>>+/*
>>+ * btrfs_check_allocatable_zones - find allocatable zones within give region
>>+ * @device:	the device to allocate a region
>>+ * @hole_start: the position of the hole to allocate the region
>>+ * @num_bytes:	the size of wanted region
>>+ * @hole_size:	the size of hole
>>+ *
>>+ * Allocatable region should not contain any superblock locations.
>>+ */
>>+u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>>+				 u64 hole_end, u64 num_bytes)
>>+{
>>+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
>>+	u8 shift = zinfo->zone_size_shift;
>>+	u64 nzones = num_bytes >> shift;
>>+	u64 pos = hole_start;
>>+	u64 begin, end;
>>+	u64 sb_pos;
>>+	bool have_sb;
>>+	int i;
>>+
>>+	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
>>+	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
>>+
>>+	while (pos < hole_end) {
>>+		begin = pos >> shift;
>>+		end = begin + nzones;
>>+
>>+		if (end > zinfo->nr_zones)
>>+			return hole_end;
>>+
>>+		/* check if zones in the region are all empty */
>>+		if (btrfs_dev_is_sequential(device, pos) &&
>>+		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
>>+			pos += zinfo->zone_size;
>>+			continue;
>>+		}
>>+
>>+		have_sb = false;
>>+		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
>>+			sb_pos = sb_zone_number(zinfo->zone_size, i);
>>+			if (!(end < sb_pos || sb_pos + 1 < begin)) {
>>+				have_sb = true;
>>+				pos = (sb_pos + 2) << shift;
>>+				break;
>>+			}
>>+		}
>>+		if (!have_sb)
>>+			break;
>>+	}
>>+
>>+	return pos;
>>+}
>>+
>>+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
>>+			    u64 length, u64 *bytes)
>>+{
>>+	int ret;
>>+
>>+	*bytes = 0;
>>+	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET,
>>+			       physical >> SECTOR_SHIFT, length >> SECTOR_SHIFT,
>>+			       GFP_NOFS);
>>+	if (ret)
>>+		return ret;
>>+
>>+	*bytes = length;
>>+	while (length) {
>>+		btrfs_dev_set_zone_empty(device, physical);
>>+		physical += device->zone_info->zone_size;
>>+		length -= device->zone_info->zone_size;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>>+{
>>+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
>>+	u8 shift = zinfo->zone_size_shift;
>>+	unsigned long begin = start >> shift;
>>+	unsigned long end = (start + size) >> shift;
>>+	u64 pos;
>>+	int ret;
>>+
>>+	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
>>+	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
>>+
>>+	if (end > zinfo->nr_zones)
>>+		return -ERANGE;
>>+
>>+	/* all the zones are conventional */
>>+	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
>>+		return 0;
>>+
>
>This check is duplicated below.
>

This one checks if bits from begin to end is all cleared (= all zones are
conventional). OTOH, the below checks if all the bits are set (= all zones
are sequential).

>>+	/* all the zones are sequential and empty */
>>+	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
>>+	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
>>+		return 0;
>>+
>>+	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
>>+		u64 reset_bytes;
>>+
>>+		if (!btrfs_dev_is_sequential(device, pos) ||
>>+		    btrfs_dev_is_empty_zone(device, pos))
>>+			continue;
>>+
>>+		/* free regions should be empty */
>>+		btrfs_warn_in_rcu(
>>+			device->fs_info,
>>+			"resetting device %s zone %llu for allocation",
>>+			rcu_str_deref(device->name), pos >> shift);
>>+		WARN_ON_ONCE(1);
>>+
>>+		ret = btrfs_reset_device_zone(device, pos, zinfo->zone_size,
>>+					      &reset_bytes);
>>+		if (ret)
>>+			return ret;
>
>This seems bad, as we could just have corruption right?  So we're 
>resetting the zone which could lose us data right?  Shouldn't we just 
>bail here?  Thanks,
>
>Josef

Yes.. This happens 1) when we freed up the region but forget to reset the
zones, or 2) when we lost the allocation information. For the first case, it's
OK to reset the zones here. For the second case, it's still as much
dangerous as regular device since the regular btrfs will overwrite the
data in that case anyway. I admit it's much safer to bail out here, so I
can change this to error exiting.
