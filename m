Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4E2A36A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 23:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgKBWkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 17:40:20 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61586 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgKBWkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604356818; x=1635892818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=apMNkkccARfVkYeFaEEfEnImaKqX/68X77AygHBK+Gk=;
  b=KrinIXt5iA0ZKyFgvzurueLEQ37i0YaN25gQl7Fcgf+VvY4+Sbvrg0Rz
   1ef4rfpRrfpUZA9jaKYfmytirSRqAEdmKr51vFH6/MAUpfCIzQ3nAkheT
   vlL3QbLyGGE7yGbegILQJpRWTQK6QnL2KBUSTIZkA5UhjPN+a9GHhDTcN
   AmHgFvyHeQnOVurh48H6bOBc2rhcvpG08p5zGjJacT+woDhOesu6J2Qy4
   s3NVeGefVH2ja7PH5tgex4Z/GVngCuY8cc2mnKpv8xB66jS/jSZhR2YLt
   DvmfceBTJ5g+/fbPc/jYGX5agiwvr4p4YagpwVNfHRv1q4DHK9H9tBBwW
   A==;
IronPort-SDR: 7+sLcznGs9v1bRzgpNfac58xGu9+AEnm1JM18JvWwYIZImdQpCFAiGzSUdjlPV8dvSDRxU8yQB
 UYpGqqsc44uZxqWCaHZGximrJT3QlG0JdjnkXhLL28Lxz2LVVCxwihj+Dv0iZkeCn9a7gx5Zi8
 Afk+H/w215IxNCGvxyeYlbvd7vGUbHBOpk7pOEnyxQIM7F4MKUiB/kuuyRsjBRQP1/DeNl2OFK
 N5lvILjl1rIWiWgy16e9rdW6t0TKZlDDFXtVc0G42jNX40VSJyALZqYKs8cu4P1NVGMZAg6izt
 g08=
X-IronPort-AV: E=Sophos;i="5.77,446,1596470400"; 
   d="scan'208";a="261537283"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 06:40:17 +0800
IronPort-SDR: PeK1RqJxeb8PTVrvo63/Mqwz8EqFPe/hKS2TCoCEi6A6svXRG8Figk2qsnKQSDpl0jYI5fMt10
 yLU4+juk4cRspla7COgn36BKya1RpXBUjTUvPhvDuEJcOsFE/D5dUCdDR6DejoOfG9hVP/JER1
 BVOmtk5xcwfSB6q/pUCTraxS1iDx4BSHmGQXAgjnGp6XiiTrgqXnyMJJ6oSpIgulHj+D/6kyup
 dN6Uzz88mgERGz/38K5Uc1HGMligfqv/iCFGBzEv1SN0mQuZc2k2GrQltSq3Hw8fGacXM80DEV
 fyWGVM9VXwFF63x5SKYCiJmc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 14:25:17 -0800
IronPort-SDR: CO5SYmQfgyrqcDAn2ixAsCFPyuiOihyAB0QCY5mht0RkA57rEkXOvNyCpqsUwHEL80/DjJ7QUu
 7rLRytVWewyegb5piNWrLeIekVgIHlwCSExb/6ZVWU4zgRxSUK+niNsaYlISNPzshE5BB0kodn
 Rws9cpyaXbisLJ3xO63jwXVdiTq8G8Qvt5+bE1WODE6LeLVkzlLDdPZa4A/vtWWK5OHowE071W
 rLI/ZQ7rRIQL0tlruFZden7810Zfhqxkr9v/uH9bMWvRlzvDUD2qs6XOKigO2kufq4sHcXty9k
 Mk4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 02 Nov 2020 14:40:17 -0800
Received: (nullmailer pid 3854873 invoked by uid 1000);
        Mon, 02 Nov 2020 22:40:15 -0000
Date:   Tue, 3 Nov 2020 07:40:15 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 14/41] btrfs: load zone's alloction offset
Message-ID: <20201102224015.alsmlunz3swpn54t@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <1bbbf9d4ade0c5aeeaebd0772c90f360ceafa9b3.1604065695.git.naohiro.aota@wdc.com>
 <1730f278-39d5-cd82-7cd5-a48d826df2ef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1730f278-39d5-cd82-7cd5-a48d826df2ef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:25:42PM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>Zoned btrfs must allocate blocks at the zones' write pointer. The device's
>>write pointer position can be mapped to a logical address within a block
>>group. This commit adds "alloc_offset" to track the logical address.
>>
>>This logical address is populated in btrfs_load_block-group_zone_info()
>
>btrfs_load_block_group_zone_info()
>

Fixed. Thanks.

>>from write pointers of corresponding zones.
>>
>>For now, zoned btrfs only support the SINGLE profile. Supporting non-SINGLE
>>profile with zone append writing is not trivial. For example, in the DUP
>>profile, we send a zone append writing IO to two zones on a device. The
>>device reply with written LBAs for the IOs. If the offsets of the returned
>>addresses from the beginning of the zone are different, then it results in
>>different logical addresses.
>>
>>We need fine-grained logical to physical mapping to support such separated
>>physical address issue. Since it should require additional metadata type,
>>disable non-SINGLE profiles for now.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/block-group.c |  15 ++++
>>  fs/btrfs/block-group.h |   6 ++
>>  fs/btrfs/zoned.c       | 153 +++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/zoned.h       |   6 ++
>>  4 files changed, 180 insertions(+)
>>
>>diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>index e989c66aa764..920b2708c7f2 100644
>>--- a/fs/btrfs/block-group.c
>>+++ b/fs/btrfs/block-group.c
>>@@ -15,6 +15,7 @@
>>  #include "delalloc-space.h"
>>  #include "discard.h"
>>  #include "raid56.h"
>>+#include "zoned.h"
>>  /*
>>   * Return target flags in extended format or 0 if restripe for this chunk_type
>>@@ -1935,6 +1936,13 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>>  			goto error;
>>  	}
>>+	ret = btrfs_load_block_group_zone_info(cache);
>>+	if (ret) {
>>+		btrfs_err(info, "failed to load zone info of bg %llu",
>>+			  cache->start);
>>+		goto error;
>>+	}
>>+
>>  	/*
>>  	 * We need to exclude the super stripes now so that the space info has
>>  	 * super bytes accounted for, otherwise we'll think we have more space
>>@@ -2161,6 +2169,13 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>>  	cache->last_byte_to_unpin = (u64)-1;
>>  	cache->cached = BTRFS_CACHE_FINISHED;
>>  	cache->needs_free_space = 1;
>>+
>>+	ret = btrfs_load_block_group_zone_info(cache);
>>+	if (ret) {
>>+		btrfs_put_block_group(cache);
>>+		return ret;
>>+	}
>>+
>>  	ret = exclude_super_stripes(cache);
>>  	if (ret) {
>>  		/* We may have excluded something, so call this just in case */
>>diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>>index adfd7583a17b..14e3043c9ce7 100644
>>--- a/fs/btrfs/block-group.h
>>+++ b/fs/btrfs/block-group.h
>>@@ -183,6 +183,12 @@ struct btrfs_block_group {
>>  	/* Record locked full stripes for RAID5/6 block group */
>>  	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
>>+
>>+	/*
>>+	 * Allocation offset for the block group to implement sequential
>>+	 * allocation. This is used only with ZONED mode enabled.
>>+	 */
>>+	u64 alloc_offset;
>>  };
>>  static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
>>diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>index 4411d786597a..0aa821893a51 100644
>>--- a/fs/btrfs/zoned.c
>>+++ b/fs/btrfs/zoned.c
>>@@ -3,14 +3,20 @@
>>  #include <linux/bitops.h>
>>  #include <linux/slab.h>
>>  #include <linux/blkdev.h>
>>+#include <linux/sched/mm.h>
>>  #include "ctree.h"
>>  #include "volumes.h"
>>  #include "zoned.h"
>>  #include "rcu-string.h"
>>  #include "disk-io.h"
>>+#include "block-group.h"
>>  /* Maximum number of zones to report per blkdev_report_zones() call */
>>  #define BTRFS_REPORT_NR_ZONES   4096
>>+/* Invalid allocation pointer value for missing devices */
>>+#define WP_MISSING_DEV ((u64)-1)
>>+/* Pseudo write pointer value for conventional zone */
>>+#define WP_CONVENTIONAL ((u64)-2)
>>  static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
>>  			     void *data)
>>@@ -733,3 +739,150 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>>  	return 0;
>>  }
>>+
>>+int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>>+{
>>+	struct btrfs_fs_info *fs_info = cache->fs_info;
>>+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
>>+	struct extent_map *em;
>>+	struct map_lookup *map;
>>+	struct btrfs_device *device;
>>+	u64 logical = cache->start;
>>+	u64 length = cache->length;
>>+	u64 physical = 0;
>>+	int ret;
>>+	int i;
>>+	unsigned int nofs_flag;
>>+	u64 *alloc_offsets = NULL;
>>+	u32 num_sequential = 0, num_conventional = 0;
>>+
>>+	if (!btrfs_is_zoned(fs_info))
>>+		return 0;
>>+
>>+	/* Sanity check */
>>+	if (!IS_ALIGNED(length, fs_info->zone_size)) {
>>+		btrfs_err(fs_info, "unaligned block group at %llu + %llu",
>>+			  logical, length);
>>+		return -EIO;
>>+	}
>>+
>>+	/* Get the chunk mapping */
>>+	read_lock(&em_tree->lock);
>>+	em = lookup_extent_mapping(em_tree, logical, length);
>>+	read_unlock(&em_tree->lock);
>>+
>>+	if (!em)
>>+		return -EINVAL;
>>+
>>+	map = em->map_lookup;
>>+
>>+	/*
>>+	 * Get the zone type: if the group is mapped to a non-sequential zone,
>>+	 * there is no need for the allocation offset (fit allocation is OK).
>>+	 */
>>+	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets),
>>+				GFP_NOFS);
>>+	if (!alloc_offsets) {
>>+		free_extent_map(em);
>>+		return -ENOMEM;
>>+	}
>>+
>>+	for (i = 0; i < map->num_stripes; i++) {
>>+		bool is_sequential;
>>+		struct blk_zone zone;
>>+
>>+		device = map->stripes[i].dev;
>>+		physical = map->stripes[i].physical;
>>+
>>+		if (device->bdev == NULL) {
>>+			alloc_offsets[i] = WP_MISSING_DEV;
>>+			continue;
>>+		}
>>+
>>+		is_sequential = btrfs_dev_is_sequential(device, physical);
>>+		if (is_sequential)
>>+			num_sequential++;
>>+		else
>>+			num_conventional++;
>>+
>>+		if (!is_sequential) {
>>+			alloc_offsets[i] = WP_CONVENTIONAL;
>>+			continue;
>>+		}
>>+
>>+		/*
>>+		 * This zone will be used for allocation, so mark this
>>+		 * zone non-empty.
>>+		 */
>>+		btrfs_dev_clear_zone_empty(device, physical);
>>+
>>+		/*
>>+		 * The group is mapped to a sequential zone. Get the zone write
>>+		 * pointer to determine the allocation offset within the zone.
>>+		 */
>>+		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
>>+		nofs_flag = memalloc_nofs_save();
>>+		ret = btrfs_get_dev_zone(device, physical, &zone);
>>+		memalloc_nofs_restore(nofs_flag);
>>+		if (ret == -EIO || ret == -EOPNOTSUPP) {
>>+			ret = 0;
>>+			alloc_offsets[i] = WP_MISSING_DEV;
>>+			continue;
>>+		} else if (ret) {
>>+			goto out;
>>+		}
>>+
>>+		switch (zone.cond) {
>>+		case BLK_ZONE_COND_OFFLINE:
>>+		case BLK_ZONE_COND_READONLY:
>>+			btrfs_err(fs_info, "Offline/readonly zone %llu",
>>+				  physical >> device->zone_info->zone_size_shift);
>>+			alloc_offsets[i] = WP_MISSING_DEV;
>>+			break;
>>+		case BLK_ZONE_COND_EMPTY:
>>+			alloc_offsets[i] = 0;
>>+			break;
>>+		case BLK_ZONE_COND_FULL:
>>+			alloc_offsets[i] = fs_info->zone_size;
>>+			break;
>>+		default:
>>+			/* Partially used zone */
>>+			alloc_offsets[i] =
>>+				((zone.wp - zone.start) << SECTOR_SHIFT);
>>+			break;
>>+		}
>>+	}
>>+
>>+	if (num_conventional > 0) {
>>+		/*
>>+		 * Since conventional zones does not have write pointer, we
>>+		 * cannot determine alloc_offset from the pointer
>>+		 */
>>+		ret = -EINVAL;
>>+		goto out;
>>+	}
>
>Does this mean we can't have zoned with a device that has conventional 
>and sequential zones?  I thought such things existed currently?  
>Thanks,
>
>Josef
