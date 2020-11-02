Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935A52A35C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 22:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgKBVHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 16:07:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62777 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKBVHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604352115; x=1635888115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wi7gpaO9aibJBbywGESlJKUht5W9NaV5w+4a5wibAhk=;
  b=q28Ns33jUbQoPz06ELQymU6P3etn/4wl/RCvV7IL2bvoATgJjIrcWXFQ
   MTuNXwDStOSOJkMtE086E9wUOJp5onUx2nCPGe3TWEsjLG6aaw/HPp69V
   TF/mSWUXyFA6wRa5SB/I8LBD4eMg1/2vZJzu72YL36fwvx7rPhRysaZuv
   hpXHCBKa7IqvJJeesQGgrZ0lISlkuqEe/P2FYt4maa83I6J+umPCJt2Rb
   VfiQeCmwNRdTzsBUKsgy56Ggwo1XkvgoSyKKnfjumOTsEPZu8dx3HI3JP
   oZW5DnafvM1tJVyk5JbHLnNfO/DFAVyGYCWhtaT38sFjyq9wVQzxaqf04
   w==;
IronPort-SDR: sB1fJg5ZTwYM9iJdLC1uOjQHSP/Pst/FhxeX+MBPTEhpOQhqA4GU5eFuTkzAJyyP6qRXuSOkys
 ajN97BBMjs9yWswM1K4Bon6dzpHnK8ELvqlUrC0gu+hA4qVIAZZQ6gxdla7YsdoIckT5shXe1L
 AQ3EcNR4PgjUTroFBgUkk9nrEeJpe/ofOKMWvqyVSN8dx8dtobc4bTVpfqDAlJ6/P2X9bCBSp4
 g3gh8TSetlukNagsHD6f/COAaYZggS6MTcJVKvLbb/3Sxr0MN9sFjsbf5BkKx4nWiHUdjOfPDz
 T7g=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="255125273"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 05:21:55 +0800
IronPort-SDR: 9aE5msbpA9fXz9MSWWZkZd1AhzLlmw8BYb9XrMIk4ClInb/1m4+Vtzt0JeJiOSHp7zVlLSBrg/
 stN/GYcUIBpGYCSyU1ZPxDw+4YMVlRGdszovBobDXVVkJVmhFT2R8ldXweJajs0mtGRiM7J0JT
 AnQGisrO71saeIeeOJYB6FF8qxj1rg46laBzeat+ptGWdW3kAgIKJs+nuhbf0/Dn2Lyw36lEIv
 lUEYLCCwnLCrMCdM/zgxgW54pL57C+eztpgHox3DHEQtsvQOo/dUHte7kNqjymEFCcEY5dPhRb
 f8lD+Ea9CLOvOrTAEepLCDJ7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 12:52:34 -0800
IronPort-SDR: TVGTuNL2fxqnsOinKLP6w8lN/A5cBcTPQFu6/oCBhUvYILTCD7+1KF2Otpg+Ewui+7s8Z4wlGT
 /AiMBDlmd5ayfYythZwxT4fhkBOD9SMMC7aNzdRANhR+i6TiSsgBrd+W6fZra/SC33N9HQ9LYf
 b8S4VcYUY4DWhIogTlJsimQ1f6aQLutFHssXhcgZkF3xsPKtuawwUtjLiinyNDTYyxVBbrGvj3
 B/C22BwUTazvs2qCdLBEbm6OtuHOuTQxZgNhxr5+hZXmopTZUMXBgjvgmtulr/D6ZY/MvxAQoA
 Kuo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 02 Nov 2020 13:07:35 -0800
Received: (nullmailer pid 3723226 invoked by uid 1000);
        Mon, 02 Nov 2020 21:07:33 -0000
Date:   Tue, 3 Nov 2020 06:07:33 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v9 04/41] btrfs: Get zone information of zoned block
 devices
Message-ID: <20201102210733.sot4bjllqy2eqsax@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <feca5ea7b6dc1a62eddbc00e01452b92523c8f36.1604065694.git.naohiro.aota@wdc.com>
 <69081702-5b34-1362-6e76-6769083a912c@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <69081702-5b34-1362-6e76-6769083a912c@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 11:53:35AM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>If a zoned block device is found, get its zone information (number of zones
>>and zone size) using the new helper function btrfs_get_dev_zone_info().  To
>>avoid costly run-time zone report commands to test the device zones type
>>during block allocation, attach the seq_zones bitmap to the device
>>structure to indicate if a zone is sequential or accept random writes. Also
>>it attaches the empty_zones bitmap to indicate if a zone is empty or not.
>>
>>This patch also introduces the helper function btrfs_dev_is_sequential() to
>>test if the zone storing a block is a sequential write required zone and
>>btrfs_dev_is_empty_zone() to test if the zone is a empty zone.
>>
>>Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>>---
>>  fs/btrfs/Makefile      |   1 +
>>  fs/btrfs/dev-replace.c |   5 ++
>>  fs/btrfs/super.c       |   5 ++
>>  fs/btrfs/volumes.c     |  19 ++++-
>>  fs/btrfs/volumes.h     |   4 +
>>  fs/btrfs/zoned.c       | 176 +++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/zoned.h       |  86 ++++++++++++++++++++
>>  7 files changed, 294 insertions(+), 2 deletions(-)
>>  create mode 100644 fs/btrfs/zoned.c
>>  create mode 100644 fs/btrfs/zoned.h
>>
>>diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
>>index e738f6206ea5..0497fdc37f90 100644
>>--- a/fs/btrfs/Makefile
>>+++ b/fs/btrfs/Makefile
>>@@ -16,6 +16,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
>>  btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
>>+btrfs-$(CONFIG_BLK_DEV_ZONED) += zoned.o
>>  btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
>>  	tests/extent-buffer-tests.o tests/btrfs-tests.o \
>>diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
>>index 20ce1970015f..6f6d77224c2b 100644
>>--- a/fs/btrfs/dev-replace.c
>>+++ b/fs/btrfs/dev-replace.c
>>@@ -21,6 +21,7 @@
>>  #include "rcu-string.h"
>>  #include "dev-replace.h"
>>  #include "sysfs.h"
>>+#include "zoned.h"
>>  /*
>>   * Device replace overview
>>@@ -291,6 +292,10 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>>  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>>  	device->fs_devices = fs_info->fs_devices;
>>+	ret = btrfs_get_dev_zone_info(device);
>>+	if (ret)
>>+		goto error;
>>+
>>  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>>  	list_add(&device->dev_list, &fs_info->fs_devices->devices);
>>  	fs_info->fs_devices->num_devices++;
>>diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>index 8840a4fa81eb..ed55014fd1bd 100644
>>--- a/fs/btrfs/super.c
>>+++ b/fs/btrfs/super.c
>>@@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)
>>  #endif
>>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>  			", ref-verify=on"
>>+#endif
>>+#ifdef CONFIG_BLK_DEV_ZONED
>>+			", zoned=yes"
>>+#else
>>+			", zoned=no"
>>  #endif
>>  			;
>>  	pr_info("Btrfs loaded, crc32c=%s%s\n", crc32c_impl(), options);
>>diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>index 58b9c419a2b6..e787bf89f761 100644
>>--- a/fs/btrfs/volumes.c
>>+++ b/fs/btrfs/volumes.c
>>@@ -31,6 +31,7 @@
>>  #include "space-info.h"
>>  #include "block-group.h"
>>  #include "discard.h"
>>+#include "zoned.h"
>>  const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>>  	[BTRFS_RAID_RAID10] = {
>>@@ -374,6 +375,7 @@ void btrfs_free_device(struct btrfs_device *device)
>>  	rcu_string_free(device->name);
>>  	extent_io_tree_release(&device->alloc_state);
>>  	bio_put(device->flush_bio);
>>+	btrfs_destroy_dev_zone_info(device);
>>  	kfree(device);
>>  }
>>@@ -667,6 +669,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>>  	device->mode = flags;
>>+	/* Get zone type information of zoned block devices */
>>+	ret = btrfs_get_dev_zone_info(device);
>>+	if (ret != 0)
>>+		goto error_free_page;
>>+
>>  	fs_devices->open_devices++;
>>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>>  	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
>>@@ -1143,6 +1150,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>>  		device->bdev = NULL;
>>  	}
>>  	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>>+	btrfs_destroy_dev_zone_info(device);
>>  	device->fs_info = NULL;
>>  	atomic_set(&device->dev_stats_ccnt, 0);
>>@@ -2543,6 +2551,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>  	}
>>  	rcu_assign_pointer(device->name, name);
>>+	device->fs_info = fs_info;
>>+	device->bdev = bdev;
>>+
>>+	/* Get zone type information of zoned block devices */
>>+	ret = btrfs_get_dev_zone_info(device);
>>+	if (ret)
>>+		goto error_free_device;
>>+
>>  	trans = btrfs_start_transaction(root, 0);
>>  	if (IS_ERR(trans)) {
>>  		ret = PTR_ERR(trans);
>>@@ -2559,8 +2575,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>  					 fs_info->sectorsize);
>>  	device->disk_total_bytes = device->total_bytes;
>>  	device->commit_total_bytes = device->total_bytes;
>>-	device->fs_info = fs_info;
>>-	device->bdev = bdev;
>>  	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>>  	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
>>  	device->mode = FMODE_EXCL;
>>@@ -2707,6 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>  		sb->s_flags |= SB_RDONLY;
>>  	if (trans)
>>  		btrfs_end_transaction(trans);
>>+	btrfs_destroy_dev_zone_info(device);
>>  error_free_device:
>>  	btrfs_free_device(device);
>>  error:
>>diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>>index bf27ac07d315..9c07b97a2260 100644
>>--- a/fs/btrfs/volumes.h
>>+++ b/fs/btrfs/volumes.h
>>@@ -51,6 +51,8 @@ struct btrfs_io_geometry {
>>  #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
>>  #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
>>+struct btrfs_zoned_device_info;
>>+
>>  struct btrfs_device {
>>  	struct list_head dev_list; /* device_list_mutex */
>>  	struct list_head dev_alloc_list; /* chunk mutex */
>>@@ -64,6 +66,8 @@ struct btrfs_device {
>>  	struct block_device *bdev;
>>+	struct btrfs_zoned_device_info *zone_info;
>>+
>>  	/* the mode sent to blkdev_get */
>>  	fmode_t mode;
>>diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>new file mode 100644
>>index 000000000000..5657d654bc44
>>--- /dev/null
>>+++ b/fs/btrfs/zoned.c
>>@@ -0,0 +1,176 @@
>>+// SPDX-License-Identifier: GPL-2.0
>>+
>>+#include <linux/slab.h>
>>+#include <linux/blkdev.h>
>>+#include "ctree.h"
>>+#include "volumes.h"
>>+#include "zoned.h"
>>+#include "rcu-string.h"
>>+
>>+/* Maximum number of zones to report per blkdev_report_zones() call */
>>+#define BTRFS_REPORT_NR_ZONES   4096
>>+
>>+static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
>>+			     void *data)
>>+{
>>+	struct blk_zone *zones = data;
>>+
>>+	memcpy(&zones[idx], zone, sizeof(*zone));
>>+
>>+	return 0;
>>+}
>>+
>>+static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>>+			       struct blk_zone *zones, unsigned int *nr_zones)
>>+{
>>+	int ret;
>>+
>>+	if (!*nr_zones)
>>+		return 0;
>>+
>>+	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
>>+				  copy_zone_info_cb, zones);
>>+	if (ret < 0) {
>>+		btrfs_err_in_rcu(device->fs_info,
>>+				 "get zone at %llu on %s failed %d", pos,
>>+				 rcu_str_deref(device->name), ret);
>>+		return ret;
>>+	}
>>+	*nr_zones = ret;
>>+	if (!ret)
>>+		return -EIO;
>>+
>>+	return 0;
>>+}
>>+
>>+int btrfs_get_dev_zone_info(struct btrfs_device *device)
>>+{
>>+	struct btrfs_zoned_device_info *zone_info = NULL;
>>+	struct block_device *bdev = device->bdev;
>>+	sector_t nr_sectors = bdev->bd_part->nr_sects;
>>+	sector_t sector = 0;
>>+	struct blk_zone *zones = NULL;
>>+	unsigned int i, nreported = 0, nr_zones;
>>+	unsigned int zone_sectors;
>>+	int ret;
>>+	char devstr[sizeof(device->fs_info->sb->s_id) +
>>+		    sizeof(" (device )") - 1];
>>+
>>+	if (!bdev_is_zoned(bdev))
>>+		return 0;
>>+
>>+	if (device->zone_info)
>>+		return 0;
>>+
>>+	zone_info = kzalloc(sizeof(*zone_info), GFP_KERNEL);
>>+	if (!zone_info)
>>+		return -ENOMEM;
>>+
>>+	zone_sectors = bdev_zone_sectors(bdev);
>>+	ASSERT(is_power_of_2(zone_sectors));
>>+	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
>>+	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
>>+	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
>>+	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>>+		zone_info->nr_zones++;
>>+
>>+	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
>>+	if (!zone_info->seq_zones) {
>>+		ret = -ENOMEM;
>>+		goto out;
>>+	}
>>+
>>+	zone_info->empty_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
>>+	if (!zone_info->empty_zones) {
>>+		ret = -ENOMEM;
>>+		goto out;
>>+	}
>>+
>>+	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
>>+			sizeof(struct blk_zone), GFP_KERNEL);
>>+	if (!zones) {
>>+		ret = -ENOMEM;
>>+		goto out;
>>+	}
>>+
>>+	/* Get zones type */
>>+	while (sector < nr_sectors) {
>>+		nr_zones = BTRFS_REPORT_NR_ZONES;
>>+		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
>>+					  &nr_zones);
>>+		if (ret)
>>+			goto out;
>>+
>>+		for (i = 0; i < nr_zones; i++) {
>>+			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
>>+				set_bit(nreported, zone_info->seq_zones);
>>+			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
>>+				set_bit(nreported, zone_info->empty_zones);
>>+			nreported++;
>>+		}
>>+		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
>>+	}
>>+
>>+	if (nreported != zone_info->nr_zones) {
>>+		btrfs_err_in_rcu(device->fs_info,
>>+				 "inconsistent number of zones on %s (%u / %u)",
>>+				 rcu_str_deref(device->name), nreported,
>>+				 zone_info->nr_zones);
>>+		ret = -EIO;
>>+		goto out;
>>+	}
>>+
>>+	kfree(zones);
>>+
>>+	device->zone_info = zone_info;
>>+
>>+	devstr[0] = 0;
>>+	if (device->fs_info)
>>+		snprintf(devstr, sizeof(devstr), " (device %s)",
>>+			 device->fs_info->sb->s_id);
>>+
>>+	rcu_read_lock();
>>+	pr_info(
>
>Why isn't this btrfs_info() ?  Thanks,

Because, we might not have device->fs_info set at this point. At the mount
time, this function is called under btrfs_open_devices() in
btrfs_mount_root(). OTOH, device->fs_info is set under open_ctree() which
is called later than btrfs_open_devices().

Using btrfs_info() here results in printing "BTRFS info (device <unknown>):
..." at the mount time, which is an annoying look in my opinion. So, I
followed the "scanned by ..." message style in device_list_add().

I'll add a description comment here.
