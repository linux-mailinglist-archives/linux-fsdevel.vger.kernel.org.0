Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06712A06EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgJ3Nwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21978 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgJ3Nw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065948; x=1635601948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8pg+cbadi/K8dJKqVoIbiNqcCKziYwvXwKeM1hNSr4=;
  b=iM4T+e0Mx7RHq+cs/eEc2y9DGQOcdsTdWAo1esX3je1Df4aD4SxHluxS
   g9V7wartrwggYWwKX9G1dn9R/+iK36TzHqoand/rYs0ZNOqGkdwp0Q/D4
   M3gf6Lxh8y1N3pAXLxJxkZuB6I7RPnhivdJx0bOw4Ck63i+kFLRzOonZa
   smfX+4CF2rLVNF9akZYNpefmBaBvedu9ITbSQBSTiOe9Fs34zANGwQQe2
   r9Gomz78k0BzmUg2SQCAoWnoyS5a2O+nzvurdTn6lk+JZLMUBkn5Sj1/R
   8ZD3jWx9FPhJqPpn2qBEbQsUhyAM3NhtVdC25FDwr+p47NCDVxy6CAKPC
   g==;
IronPort-SDR: pfcEXdXSEGIyuAxmPwgrQ+Kn+oKf3nX0sD18xMawcsUjPaJQfTQdfHfRVqbWNNQ0EN99wpH6cp
 GikEn2ue3fdfFui7d0u52Du6ANywmN9I1GbABC1SiLaMVqFUgYK8A7NT6ab4cRu9lQBx0k0lLx
 O0TCsqiAOUkyoVBSUN8rf+7SDHdaJyQ56lK+DLVZVjTw0nbVs+/6XgJRLXCZSnwwc/VwaxMIJN
 Uv0iwwNxfu7s1pA7r7rjs00wp4FsZiUtxw//OQ2U0TPZ/96zQjw+IuD7x1rsxtA+Xnz438pbW4
 RWw=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806581"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:28 +0800
IronPort-SDR: 2cgb+bBGL7mLrTQ41G0ewBM0MAmC1UaKbuj9amPx4z6BQ/Tp59aHAIbnjMxkUG6LdqZHxd/chi
 nXoxg2hlM/h2IrmiYUukoKhIKubVfAxQACLVHgpv8CP84Xdf9ChRvFfNuA+s0LEFyrUr99AcII
 sRimiLI0D5uHChVLIAUdBhfxeHqKMe/7EjIjnh6G+ZCjlMFLtDjTzO7zazbv0yOPgDF63VX6YY
 rP07YVtJUMFK3ybeHBpemdw4kpoy28bfIH7EezIKLRXMUSI9cH63vHSa0byuWuM1HhbkB9foF9
 3Y7k+tgDK7Q3A+U/GsZ8HYPw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:42 -0700
IronPort-SDR: b5SpNraWoCi5Sd0BhXW1iDbfg2ztX6iliiIaSNMZdCuDYSPjUYb0CgXIiWY8nzPVEDzvewXsPh
 rfC/4WtcrtXdgGBl6izJr1m4qkGT8cJ1dXU/Pj0S1HIVthoGak40sAEwm3cCT2J33KG9rRoCaa
 nprXJP+QHBXbj/6G0Qq1hkU2adqI8t7RGD3/G0ZpCS/q8fITnd1dvQoey1mvW0vQuWQ5anKWWA
 Cp3tTxVzreBuQ+qBo5YXaJxgyh9FERE/kFrsTL7joWaWE7dkSVtOor86NP0Y4Fh/X/FH9A0UjK
 aKc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:27 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v9 05/41] btrfs: Check and enable ZONED mode
Date:   Fri, 30 Oct 2020 22:51:12 +0900
Message-Id: <599d306d41880e3e3242120a40a78b81f6ed0473.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit introduces the function btrfs_check_zoned_mode() to check if
ZONED flag is enabled on the file system and if the file system consists of
zoned devices with equal zone size.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 10 ++++++
 fs/btrfs/dev-replace.c |  7 ++++
 fs/btrfs/disk-io.c     | 11 ++++++
 fs/btrfs/super.c       |  1 +
 fs/btrfs/volumes.c     |  5 +++
 fs/btrfs/zoned.c       | 78 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       | 26 ++++++++++++++
 7 files changed, 138 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f4e35b..25fd4e97dd2a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -948,6 +948,12 @@ struct btrfs_fs_info {
 	/* Type of exclusive operation running */
 	unsigned long exclusive_operation;
 
+	/* Zone size when in ZONED mode */
+	union {
+		u64 zone_size;
+		u64 zoned;
+	};
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
@@ -3595,4 +3601,8 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
 }
 #endif
 
+static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)
+{
+	return fs_info->zoned != 0;
+}
 #endif
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 6f6d77224c2b..5e3554482af1 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
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
 
 	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 764001609a15..9bc51cff48b8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -42,6 +42,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "space-info.h"
+#include "zoned.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -2976,6 +2977,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 		btrfs_info(fs_info, "has skinny extents");
 
+	fs_info->zoned = features & BTRFS_FEATURE_INCOMPAT_ZONED;
+
 	/*
 	 * flag our filesystem as having big metadata blocks if
 	 * they are bigger than the page size
@@ -3130,7 +3133,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	btrfs_free_extra_devids(fs_devices, 1);
 
+	ret = btrfs_check_zoned_mode(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to init ZONED mode: %d",
+				ret);
+		goto fail_block_groups;
+	}
+
 	ret = btrfs_sysfs_add_fsid(fs_devices);
+
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
 				ret);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ed55014fd1bd..3312fe08168f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -44,6 +44,7 @@
 #include "backref.h"
 #include "space-info.h"
 #include "sysfs.h"
+#include "zoned.h"
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e787bf89f761..10827892c086 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2518,6 +2518,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
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
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5657d654bc44..e1cdff5af3a3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -174,3 +174,81 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 
 	return 0;
 }
+
+int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 hmzoned_devices = 0;
+	u64 nr_devices = 0;
+	u64 zone_size = 0;
+	int incompat_zoned = btrfs_is_zoned(fs_info);
+	int ret = 0;
+
+	/* Count zoned devices */
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		enum blk_zoned_model model;
+
+		if (!device->bdev)
+			continue;
+
+		model = bdev_zoned_model(device->bdev);
+		if (model == BLK_ZONED_HM ||
+		    (model == BLK_ZONED_HA && incompat_zoned)) {
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
+	if (!hmzoned_devices && !incompat_zoned)
+		goto out;
+
+	if (!hmzoned_devices && incompat_zoned) {
+		/* No zoned block device found on ZONED FS */
+		btrfs_err(fs_info,
+			  "ZONED enabled file system should have zoned devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (hmzoned_devices && !incompat_zoned) {
+		btrfs_err(fs_info,
+			  "Enable ZONED mode to mount HMZONED device");
+		ret = -EINVAL;
+		goto out;
+	}
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
+	fs_info->zone_size = zone_size;
+
+	btrfs_info(fs_info, "ZONED mode enabled, zone size %llu B",
+		   fs_info->zone_size);
+out:
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 483229e27908..c4c63c4294f2 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_ZONED_H
 #define BTRFS_ZONED_H
 
+#include <linux/blkdev.h>
+
 struct btrfs_zoned_device_info {
 	/*
 	 * Number of zones, zone size and types of zones if bdev is a
@@ -20,6 +22,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
+int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -31,6 +34,14 @@ static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	return 0;
 }
 static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
+static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	btrfs_err(fs_info, "Zoned block devices support is not enabled");
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -83,4 +94,19 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device,
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
 
+static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
+						struct block_device *bdev)
+{
+	u64 zone_size;
+
+	if (btrfs_is_zoned(fs_info)) {
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
-- 
2.27.0

