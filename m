Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469932A3074
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 17:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgKBQxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 11:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgKBQxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:53:39 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46095C061A04
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 08:53:39 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id da2so4212095qvb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 08:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oe1L6iMU++vy043gbHMob04eq7urBjlabi6ES8vxfY4=;
        b=lmOSm6bycS9V3BtcVTDj7praloODOriSLtI3rYdnUlEtv3wAaNyPsSmVNbeiHjnePG
         To1aa4zbaLCK+qAhQwXkYqxvmwi7HWp7lCY0VfZcSzhE2828fKLM0Rhvr2bIG/iHblTM
         AobVB4lPktnz1lK/RENUvBPW2XFahvez0Ad2uE+W3MweetSJm6EFoQKHkTlYitatxcFw
         FtNGzhCYRFjtZ5Q9Ijp95NfgWq26p4aPFBoGMAUcjVKR6KOPsfmpzBhZaXNiCOqwdqpJ
         QisxR98ivab7Cp+JnzE1aO1Lu2eQ8JJjZoICqMFvXNRrpq0KwP3KRSmX7tV4nPOEoWgc
         RlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oe1L6iMU++vy043gbHMob04eq7urBjlabi6ES8vxfY4=;
        b=hSjohhCAAbxIEdk6qI1PMbLvobY71xzc/Kzb7avQiisJIlcRtFYoExZRys+LPumXkf
         Y37J712rRUtlfgrhYDUlGj/6nO6+UdbrGekgIXD9lMsDqJrsBYvjt6XJ9IdfOn4TwUkp
         0FZAbBGeGM1ysMQe2mrNvGAGqvZXJgDWclE3iIJocu8q665HzRumUzDE3UnJTN1d5nAR
         R5RdZ6651MpRGgzgDLZX2RJS1E/Yq0hZvcyJRb/Gy9nFWP01brtEDV2j3Jmxq7YY8Sg8
         NDUAjMsYECrwRbwATAbMsXQ/+Q2eGm9iXJCWnqCqHQ8MvTMb2oirdF8hqUzKYlSd1cNY
         zFQA==
X-Gm-Message-State: AOAM532vf4ZXLEokYWKBoFp5rBUayl6iGLsC5aoJw8llkTSeIxJ+YECl
        FlC119IoU92bX7GVJm7bhSN3HGWtW/F5Qw==
X-Google-Smtp-Source: ABdhPJwR83uPsUfvWopHF1wam7+qvWDl4aDVAcMmWJ7dnGArz+JnJayULhv/TgQ6V50GAiO4JhosOw==
X-Received: by 2002:a0c:9e0e:: with SMTP id p14mr22104580qve.25.1604336018106;
        Mon, 02 Nov 2020 08:53:38 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d9::116a? ([2620:10d:c091:480::1:f39e])
        by smtp.gmail.com with ESMTPSA id b77sm8211183qkg.57.2020.11.02.08.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:53:37 -0800 (PST)
Subject: Re: [PATCH v9 04/41] btrfs: Get zone information of zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <feca5ea7b6dc1a62eddbc00e01452b92523c8f36.1604065694.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <69081702-5b34-1362-6e76-6769083a912c@toxicpanda.com>
Date:   Mon, 2 Nov 2020 11:53:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <feca5ea7b6dc1a62eddbc00e01452b92523c8f36.1604065694.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> If a zoned block device is found, get its zone information (number of zones
> and zone size) using the new helper function btrfs_get_dev_zone_info().  To
> avoid costly run-time zone report commands to test the device zones type
> during block allocation, attach the seq_zones bitmap to the device
> structure to indicate if a zone is sequential or accept random writes. Also
> it attaches the empty_zones bitmap to indicate if a zone is empty or not.
> 
> This patch also introduces the helper function btrfs_dev_is_sequential() to
> test if the zone storing a block is a sequential write required zone and
> btrfs_dev_is_empty_zone() to test if the zone is a empty zone.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/Makefile      |   1 +
>   fs/btrfs/dev-replace.c |   5 ++
>   fs/btrfs/super.c       |   5 ++
>   fs/btrfs/volumes.c     |  19 ++++-
>   fs/btrfs/volumes.h     |   4 +
>   fs/btrfs/zoned.c       | 176 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/zoned.h       |  86 ++++++++++++++++++++
>   7 files changed, 294 insertions(+), 2 deletions(-)
>   create mode 100644 fs/btrfs/zoned.c
>   create mode 100644 fs/btrfs/zoned.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index e738f6206ea5..0497fdc37f90 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -16,6 +16,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>   btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>   btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
>   btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
> +btrfs-$(CONFIG_BLK_DEV_ZONED) += zoned.o
>   
>   btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
>   	tests/extent-buffer-tests.o tests/btrfs-tests.o \
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 20ce1970015f..6f6d77224c2b 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -21,6 +21,7 @@
>   #include "rcu-string.h"
>   #include "dev-replace.h"
>   #include "sysfs.h"
> +#include "zoned.h"
>   
>   /*
>    * Device replace overview
> @@ -291,6 +292,10 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>   	device->fs_devices = fs_info->fs_devices;
>   
> +	ret = btrfs_get_dev_zone_info(device);
> +	if (ret)
> +		goto error;
> +
>   	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>   	list_add(&device->dev_list, &fs_info->fs_devices->devices);
>   	fs_info->fs_devices->num_devices++;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 8840a4fa81eb..ed55014fd1bd 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)
>   #endif
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   			", ref-verify=on"
> +#endif
> +#ifdef CONFIG_BLK_DEV_ZONED
> +			", zoned=yes"
> +#else
> +			", zoned=no"
>   #endif
>   			;
>   	pr_info("Btrfs loaded, crc32c=%s%s\n", crc32c_impl(), options);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 58b9c419a2b6..e787bf89f761 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -31,6 +31,7 @@
>   #include "space-info.h"
>   #include "block-group.h"
>   #include "discard.h"
> +#include "zoned.h"
>   
>   const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>   	[BTRFS_RAID_RAID10] = {
> @@ -374,6 +375,7 @@ void btrfs_free_device(struct btrfs_device *device)
>   	rcu_string_free(device->name);
>   	extent_io_tree_release(&device->alloc_state);
>   	bio_put(device->flush_bio);
> +	btrfs_destroy_dev_zone_info(device);
>   	kfree(device);
>   }
>   
> @@ -667,6 +669,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>   	device->mode = flags;
>   
> +	/* Get zone type information of zoned block devices */
> +	ret = btrfs_get_dev_zone_info(device);
> +	if (ret != 0)
> +		goto error_free_page;
> +
>   	fs_devices->open_devices++;
>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>   	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> @@ -1143,6 +1150,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>   		device->bdev = NULL;
>   	}
>   	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> +	btrfs_destroy_dev_zone_info(device);
>   
>   	device->fs_info = NULL;
>   	atomic_set(&device->dev_stats_ccnt, 0);
> @@ -2543,6 +2551,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	}
>   	rcu_assign_pointer(device->name, name);
>   
> +	device->fs_info = fs_info;
> +	device->bdev = bdev;
> +
> +	/* Get zone type information of zoned block devices */
> +	ret = btrfs_get_dev_zone_info(device);
> +	if (ret)
> +		goto error_free_device;
> +
>   	trans = btrfs_start_transaction(root, 0);
>   	if (IS_ERR(trans)) {
>   		ret = PTR_ERR(trans);
> @@ -2559,8 +2575,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   					 fs_info->sectorsize);
>   	device->disk_total_bytes = device->total_bytes;
>   	device->commit_total_bytes = device->total_bytes;
> -	device->fs_info = fs_info;
> -	device->bdev = bdev;
>   	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>   	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
>   	device->mode = FMODE_EXCL;
> @@ -2707,6 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   		sb->s_flags |= SB_RDONLY;
>   	if (trans)
>   		btrfs_end_transaction(trans);
> +	btrfs_destroy_dev_zone_info(device);
>   error_free_device:
>   	btrfs_free_device(device);
>   error:
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index bf27ac07d315..9c07b97a2260 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -51,6 +51,8 @@ struct btrfs_io_geometry {
>   #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
>   #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
>   
> +struct btrfs_zoned_device_info;
> +
>   struct btrfs_device {
>   	struct list_head dev_list; /* device_list_mutex */
>   	struct list_head dev_alloc_list; /* chunk mutex */
> @@ -64,6 +66,8 @@ struct btrfs_device {
>   
>   	struct block_device *bdev;
>   
> +	struct btrfs_zoned_device_info *zone_info;
> +
>   	/* the mode sent to blkdev_get */
>   	fmode_t mode;
>   
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> new file mode 100644
> index 000000000000..5657d654bc44
> --- /dev/null
> +++ b/fs/btrfs/zoned.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/slab.h>
> +#include <linux/blkdev.h>
> +#include "ctree.h"
> +#include "volumes.h"
> +#include "zoned.h"
> +#include "rcu-string.h"
> +
> +/* Maximum number of zones to report per blkdev_report_zones() call */
> +#define BTRFS_REPORT_NR_ZONES   4096
> +
> +static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
> +			     void *data)
> +{
> +	struct blk_zone *zones = data;
> +
> +	memcpy(&zones[idx], zone, sizeof(*zone));
> +
> +	return 0;
> +}
> +
> +static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
> +			       struct blk_zone *zones, unsigned int *nr_zones)
> +{
> +	int ret;
> +
> +	if (!*nr_zones)
> +		return 0;
> +
> +	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
> +				  copy_zone_info_cb, zones);
> +	if (ret < 0) {
> +		btrfs_err_in_rcu(device->fs_info,
> +				 "get zone at %llu on %s failed %d", pos,
> +				 rcu_str_deref(device->name), ret);
> +		return ret;
> +	}
> +	*nr_zones = ret;
> +	if (!ret)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +int btrfs_get_dev_zone_info(struct btrfs_device *device)
> +{
> +	struct btrfs_zoned_device_info *zone_info = NULL;
> +	struct block_device *bdev = device->bdev;
> +	sector_t nr_sectors = bdev->bd_part->nr_sects;
> +	sector_t sector = 0;
> +	struct blk_zone *zones = NULL;
> +	unsigned int i, nreported = 0, nr_zones;
> +	unsigned int zone_sectors;
> +	int ret;
> +	char devstr[sizeof(device->fs_info->sb->s_id) +
> +		    sizeof(" (device )") - 1];
> +
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
> +
> +	if (device->zone_info)
> +		return 0;
> +
> +	zone_info = kzalloc(sizeof(*zone_info), GFP_KERNEL);
> +	if (!zone_info)
> +		return -ENOMEM;
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +	ASSERT(is_power_of_2(zone_sectors));
> +	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
> +	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
> +	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
> +	if (!IS_ALIGNED(nr_sectors, zone_sectors))
> +		zone_info->nr_zones++;
> +
> +	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
> +	if (!zone_info->seq_zones) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	zone_info->empty_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
> +	if (!zone_info->empty_zones) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
> +			sizeof(struct blk_zone), GFP_KERNEL);
> +	if (!zones) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Get zones type */
> +	while (sector < nr_sectors) {
> +		nr_zones = BTRFS_REPORT_NR_ZONES;
> +		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
> +					  &nr_zones);
> +		if (ret)
> +			goto out;
> +
> +		for (i = 0; i < nr_zones; i++) {
> +			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
> +				set_bit(nreported, zone_info->seq_zones);
> +			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
> +				set_bit(nreported, zone_info->empty_zones);
> +			nreported++;
> +		}
> +		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
> +	}
> +
> +	if (nreported != zone_info->nr_zones) {
> +		btrfs_err_in_rcu(device->fs_info,
> +				 "inconsistent number of zones on %s (%u / %u)",
> +				 rcu_str_deref(device->name), nreported,
> +				 zone_info->nr_zones);
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	kfree(zones);
> +
> +	device->zone_info = zone_info;
> +
> +	devstr[0] = 0;
> +	if (device->fs_info)
> +		snprintf(devstr, sizeof(devstr), " (device %s)",
> +			 device->fs_info->sb->s_id);
> +
> +	rcu_read_lock();
> +	pr_info(

Why isn't this btrfs_info() ?  Thanks,

Josef
