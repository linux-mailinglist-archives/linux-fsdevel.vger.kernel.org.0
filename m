Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9151511245C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfLDITf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:35 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32747 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfLDITa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447570; x=1606983570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=weOQDIbg5A3au1LrS36I3ofNEuVjw1L2FVj2RaFk/cs=;
  b=nkqP8kbopGP+dgUWGDVljxnierEgFUaV9XHnh7kE+OoD6OXpSgmq+zJj
   6vyNqLeCtF0CBjj8RdHQI/GkDT+YrsJE9OsL64Zoei6MYBV6PFIqU9a+w
   vML5qdAv097jz2DIAlinUba+SFcIO32DhEU13R3lP/n23V8rWDqUwCIB7
   ZDm31uQdEVsNeNs8zMfeaCQfC/dZgECSVXMf6fUzOmbnnbMKqBfZWuy97
   xAZAPT+v4qo06H9abIW+6g+ml9WP9uMLPd7xvuA0clHQd2v1dCXJdv6ms
   xRsEN5ITheuE8TsI3+n6klR8Dd+UEC39i/k2DifEUsUpzQuoL/VDktRYH
   g==;
IronPort-SDR: pYCWB8Tyq/q3LaVp14IlbknMQDT8+XD4tkHsQ2tjRIQmZuoa/5nZMeUenX8ylijIYkGBSMNwwT
 oLYt8JbyyXRxSbh4OBVeIcK2ojCZ4Rb5l6epqWvTXzu06Vtud+NPIpqTCWEp8RJypoM4hRFGr/
 Uxjv/+xuhkXpZEqo0HT2tI0Of4ePfnVDwE2ll6RIqIZ3w2pFjUgeHGlESDsbVLPNf0CHqkRhyB
 oWKe00Ky5vaNDtpjqxMiLmYyFFPsDIglwG8hxlYbnLVqW66GMaH32z88LSV5lzI65ssyrEunA/
 DkQ=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355024"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:28 +0800
IronPort-SDR: nCA0aeVAso6shZtVrwQ/nNuhPLSIDgPQexrkoz7rlWVJkq88YDZmX1L1/TokOnrqpzszt37+W5
 Shu/h/g8HmHiJK63093abfih/bK6u73IzTUC9E7swB2bzsODlPjWgbQaeRWjDeUEkvJDinn8rM
 AQH7WsxP/GS7ui05l4ae/guYLvC/ksFvcW1p7GA60JOG7bo81jBD/lC3xWjzTNxwHBT+lMi98o
 Rjfx6sOz/oZkIDHY5aaLvwKWF+5dsM8lgvzelPKT3ia0ijs11BW1rrQTC9nfE5L9eoebO77Wfv
 ZAKZucaO4+ofKJ7o56lWUve7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:13:53 -0800
IronPort-SDR: 0Ytsj2Tp5UVizCwxBzOr4sy/vpNqxuB8Wq/3OHXRHCiI2bOoqKEeKAO096kYPlL+R5YcQap8dv
 EARvM8x+kxvr+QMLx7T4aV9dDFsMPOBVcS+sqF7oB0FMy8KP67dG1NLz58wGe2QYBArDziZi+e
 ceOq3dP+jTbLB0K0f2pm7BD+7PWX3o4Tvauc2Pln0OXXmv9tJXi/WIr23YK3FTbcfVx3+Ugnt/
 sFa3uQX6LqSUU6l15aIBk9pQdHoEiD+tm29ckWYPzUkL/PTGJq0qcg0GhCaIQycP/gBq5v5io3
 14U=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 03/28] btrfs: Check and enable HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:10 +0900
Message-Id: <20191204081735.852438-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

HMZONED mode cannot be used together with the RAID5/6 profile for now.
Introduce the function btrfs_check_hmzoned_mode() to check this. This
function will also check if HMZONED flag is enabled on the file system and
if the file system consists of zoned devices with equal zone size.

Additionally, as updates to the space cache are in-place, the space cache
cannot be located over sequential zones and there is no guarantees that the
device will have enough conventional zones to store this cache. Resolve
this problem by completely disabling the space cache.  This does not
introduce any problems in HMZONED mode: all the free space is located after
the allocation pointer and no free space is located before the pointer.
There is no need to have such cache.

For the same reason, NODATACOW is also disabled.

Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
INODE_MAP_CACHE inode.

In summary, HMZONED will disable:

| Disabled features | Reason                                              |
|-------------------+-----------------------------------------------------|
| RAID5/6           | 1) Non-full stripe write cause overwriting of       |
|                   | parity block                                        |
|                   | 2) Rebuilding on high capacity volume (usually with |
|                   | SMR) can lead to higher failure rate                |
|-------------------+-----------------------------------------------------|
| space_cache (v1)  | In-place updating                                   |
| NODATACOW         | In-place updating                                   |
|-------------------+-----------------------------------------------------|
| fallocate         | Reserved extent will be a write hole                |
| INODE_MAP_CACHE   | Need pre-allocation. (and will be deprecated?)      |
|-------------------+-----------------------------------------------------|
| MIXED_BG          | Allocated metadata region will be write holes for   |
|                   | data writes                                         |
| async checksum    | Not to mix up bios by multiple workers              |

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h       |  3 ++
 fs/btrfs/dev-replace.c |  8 +++++
 fs/btrfs/disk-io.c     |  8 +++++
 fs/btrfs/hmzoned.c     | 74 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h     | 26 +++++++++++++++
 fs/btrfs/super.c       |  1 +
 fs/btrfs/volumes.c     |  5 +++
 7 files changed, 125 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e8fd8a8e59..44517802b9e5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -541,6 +541,9 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *free_space_root;
 
+	/* Zone size when in HMZONED mode */
+	u64 zone_size;
+
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f639dde2a679..9286c6e0b636 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -21,6 +21,7 @@
 #include "rcu-string.h"
 #include "dev-replace.h"
 #include "sysfs.h"
+#include "hmzoned.h"
 
 static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				       int scrub_ret);
@@ -202,6 +203,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return PTR_ERR(bdev);
 	}
 
+	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
+		btrfs_err(fs_info,
+			  "zone type of target device mismatch with the filesystem!");
+		ret = -EINVAL;
+		goto error;
+	}
+
 	sync_blockdev(bdev);
 
 	devices = &fs_info->fs_devices->devices;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e0edfdc9c82b..ff418e393f82 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -41,6 +41,7 @@
 #include "tree-checker.h"
 #include "ref-verify.h"
 #include "block-group.h"
+#include "hmzoned.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -3082,6 +3083,13 @@ int __cold open_ctree(struct super_block *sb,
 
 	btrfs_free_extra_devids(fs_devices, 1);
 
+	ret = btrfs_check_hmzoned_mode(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to init hmzoned mode: %d",
+				ret);
+		goto fail_block_groups;
+	}
+
 	ret = btrfs_sysfs_add_fsid(fs_devices, NULL);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index e37335625f76..9a04240910f6 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -172,3 +172,77 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 
 	return 0;
 }
+
+int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 hmzoned_devices = 0;
+	u64 nr_devices = 0;
+	u64 zone_size = 0;
+	int incompat_hmzoned = btrfs_fs_incompat(fs_info, HMZONED);
+	int ret = 0;
+
+	/* Count zoned devices */
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (!device->bdev)
+			continue;
+		if (bdev_zoned_model(device->bdev) == BLK_ZONED_HM ||
+		    (bdev_zoned_model(device->bdev) == BLK_ZONED_HA &&
+		     incompat_hmzoned)) {
+			hmzoned_devices++;
+			if (!zone_size) {
+				zone_size = device->zone_info->zone_size;
+			} else if (device->zone_info->zone_size != zone_size) {
+				btrfs_err(fs_info,
+					  "Zoned block devices must have equal zone sizes");
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+		nr_devices++;
+	}
+
+	if (!hmzoned_devices && !incompat_hmzoned)
+		goto out;
+
+	if (!hmzoned_devices && incompat_hmzoned) {
+		/* No zoned block device found on HMZONED FS */
+		btrfs_err(fs_info, "HMZONED enabled file system should have zoned devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (hmzoned_devices && !incompat_hmzoned) {
+		btrfs_err(fs_info,
+			  "Enable HMZONED mode to mount HMZONED device");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fs_info->zone_size = zone_size;
+
+	if (hmzoned_devices != nr_devices) {
+		btrfs_err(fs_info,
+			  "zoned devices cannot be mixed with regular devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
+	 * __btrfs_alloc_chunk(). Since we want stripe_len == zone_size,
+	 * check the alignment here.
+	 */
+	if (!IS_ALIGNED(zone_size, BTRFS_STRIPE_LEN)) {
+		btrfs_err(fs_info,
+			  "zone size is not aligned to BTRFS_STRIPE_LEN");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
+		   fs_info->zone_size);
+out:
+	return ret;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 0f8006f39aaf..8e17f64ff986 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -9,6 +9,8 @@
 #ifndef BTRFS_HMZONED_H
 #define BTRFS_HMZONED_H
 
+#include <linux/blkdev.h>
+
 struct btrfs_zoned_device_info {
 	/*
 	 * Number of zones, zone size and types of zones if bdev is a
@@ -26,6 +28,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
+int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -37,6 +40,14 @@ static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	return 0;
 }
 static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
+static inline int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
+
+	btrfs_err(fs_info, "Zoned block devices support is not enabled");
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -89,4 +100,19 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device,
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
 
+static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
+						struct block_device *bdev)
+{
+	u64 zone_size;
+
+	if (btrfs_fs_incompat(fs_info, HMZONED)) {
+		zone_size = (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;
+		/* Do not allow non-zoned device */
+		return bdev_is_zoned(bdev) && fs_info->zone_size == zone_size;
+	}
+
+	/* Do not allow Host Manged zoned device */
+	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
+}
+
 #endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a98c3c71fc54..616f5abec267 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -44,6 +44,7 @@
 #include "backref.h"
 #include "space-info.h"
 #include "sysfs.h"
+#include "hmzoned.h"
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 18ea8dfce244..ab3590b310af 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2395,6 +2395,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
+	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	if (fs_devices->seeding) {
 		seeding_dev = 1;
 		down_write(&sb->s_umount);
-- 
2.24.0

