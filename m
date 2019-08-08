Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36C485E52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbfHHJbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59627 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbfHHJbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256678; x=1596792678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NdguPa/k7TlJRTExHv9E8y7kWVjAudq+c5Ss5Jg+4+U=;
  b=EBuApeMQcjLMOdV9aAojDsh4AkrLpa2RxgwiS86fxyvIEtHBI8lVKhTL
   GR1ry5b5mdjOD5hQrNtdQP3G1wYvNJUfzb2jdMgI3nMcsMVz7VzXSkZ0F
   q/YrgmJPO8y/bWZh2xr6IHqGhjAE3srgJ9dlGbHckiI28IY6Z/7eEUQkF
   EghvWWGwH1pYApDL8ukvtjPTcJ+zm46ieXmQ8AQ0ib1IDPV5nlhHvsWet
   kuwIFUF6MDKQtlNTNEL3ujrjM6uwnemCmaKsjNtPHJ0PqSTbHK3wXAbTQ
   yLQ6U4RjeHUO0GT9F+/Pu9zrlrqHGq+8Kecav2hi5SCZiuvuPvXysX7ZV
   Q==;
IronPort-SDR: +7jvxuXeA1wtUlKB7wPM9iiLAPRoo7gw1lLEH9VUFIc39DU0EGCVkGgf19Cf2otwhMCuCdZL+g
 9/iYEOetac4VQuUGaZ2R38gkf5QIIn3TEXSkzNzU/4hneJcaxcmws6rirPALdPFCO35TvNldAn
 FhZ7g2LbQk1299uisy9kwjBZ+0Yh1LFVEuctOOqg6sF/6XDpxw2kXql02b+fMQVdtqtYid5Bvc
 PO3J9oO8m8vR0x/09QDKItxuxkA2WW0HLvf8BU6KNtIrn7wv0MnckDQjv52WsBRat4SXrbGtCV
 H8o=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363302"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:18 +0800
IronPort-SDR: QBtah0HMme2AhIVFNRoVhk9/4Js0yWPXWb82EHSXDIMDvGvQq+LXCAVi0Jq2b+pSU0suAFCqYV
 WSmV87Y0HUSm9Wwk9u9QTX66e6gWl4lRvHqYXVL2IbWkjnbT8+B1qx6Wu8o//LU2On2ymVnERZ
 KPTTQ1zq4Ik99ZxeJ43Exu96KAlRAijvTLsfy3VlBipOlqiqoUAzQDQn0jr6x8j7PnqyJI2K20
 J/SOOoHuN9kz8pYlqkcz6LTMT1LfpCvl46OwMJo6niSALNYl2A2dp8Loc2BDJllfVrCbus8Smk
 h1SJo50G6VKu6bNB/d1H8Fhz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:02 -0700
IronPort-SDR: vokvck1VcQAObBlggLxw3sf4HA7mnm5uPrvGn+51ns0AA/Nuj9kgDDXBoNGgl9b2DeuPyq08VQ
 5lVndZDqLiFfLZqkcoXxAt4Ar9BxPi5hdObJ78okMesX9bZk1Q5/xder9gdEvNa1ciUqaztC2Y
 1s44M10caILCcM4PZytdNf6muOPsfOF0NP1RgEqdb3Q6GWq8CfVi0YV9QpH2wi5mTV7DiuLOws
 dSd2hOdhZ7p6rg/60gTI46A+ChW/HZ5bld2pQGmR31tWEpzu+HDYqR49fgWhN29xloO7iql3vN
 Tig=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:17 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 03/27] btrfs: Check and enable HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:14 +0900
Message-Id: <20190808093038.4163421-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
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
this problem by disabling completely the space cache.  This does not
introduces any problems with sequential block groups: all the free space is
located after the allocation pointer and no free space before the pointer.
There is no need to have such cache.

For the same reason, NODATACOW is also disabled.

Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
INODE_MAP_CACHE inode.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h       |  3 ++
 fs/btrfs/dev-replace.c |  8 +++++
 fs/btrfs/disk-io.c     |  8 +++++
 fs/btrfs/hmzoned.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h     | 18 ++++++++++++
 fs/btrfs/super.c       |  1 +
 fs/btrfs/volumes.c     |  5 ++++
 7 files changed, 110 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 299e11e6c554..a00ce8c4d678 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -713,6 +713,9 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *free_space_root;
 
+	/* Zone size when in HMZONED mode */
+	u64 zone_size;
+
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 6b2e9aa83ffa..2cc3ac4d101d 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -20,6 +20,7 @@
 #include "rcu-string.h"
 #include "dev-replace.h"
 #include "sysfs.h"
+#include "hmzoned.h"
 
 static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				       int scrub_ret);
@@ -201,6 +202,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
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
index 5f7ee70b3d1a..8854ff2e5fa5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -40,6 +40,7 @@
 #include "compression.h"
 #include "tree-checker.h"
 #include "ref-verify.h"
+#include "hmzoned.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -3123,6 +3124,13 @@ int open_ctree(struct super_block *sb,
 
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
index bfd04792dd62..512674d8f488 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -160,3 +160,70 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 
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
+	if (!hmzoned_devices && incompat_hmzoned) {
+		/* No zoned block device found on HMZONED FS */
+		btrfs_err(fs_info, "HMZONED enabled file system should have zoned devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!hmzoned_devices && !incompat_hmzoned)
+		goto out;
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
index ffc70842135e..29cfdcabff2f 100644
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
@@ -25,6 +27,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone, gfp_t gfp_mask);
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
+int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
@@ -76,4 +79,19 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device,
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
index 78de9d5d80c6..d7879a5a2536 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -43,6 +43,7 @@
 #include "free-space-cache.h"
 #include "backref.h"
 #include "space-info.h"
+#include "hmzoned.h"
 #include "tests/btrfs-tests.h"
 
 #include "qgroup.h"
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8e5a894e7bde..755b2ec1e0de 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2572,6 +2572,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
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
2.22.0

