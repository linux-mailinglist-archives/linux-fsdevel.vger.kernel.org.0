Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E1438D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfFMPJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:09:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34712 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732371AbfFMN7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:59:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so22650805qtu.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7/wwP73Rmwv2oX6WgY9L8tV3nZFxh0BFz9mVMjZ9eDw=;
        b=zN0eaAjBRKEAF7wyunO1c81hHLsBqXRf5wBu9ZgU/KA+UCJSSOU4KTjShEqxMgNa9H
         KGUP+TxWE86lLkh8Zq+SDlaT8zLSHBvJvyxR7qaraxPNNYdW5+Z+bX2QTiOSzDLCzoBv
         0Ccc3wtPcgDejXXkxAhFEOo5DgVe2VyuBRpUob2F2mAI4eoI3/z7ccMnvBhsDRkjZFfz
         HlYNbyhNLFyhf34e0avcBMYc8eW1W3n4lPiYcPNzCsqKp1E6hITw6Q9CQ2L1C6kZkXdj
         kYAK+ftGhNJEkrMzTgCE8jbkkjgvowhwiu648WHuUrWPblLpyoin9POEyRkuhWyNTvwL
         yvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7/wwP73Rmwv2oX6WgY9L8tV3nZFxh0BFz9mVMjZ9eDw=;
        b=fJ4cM+IyDdW8YMMxxZeDNWmiXJUU8HzrTgEl0JQdXauj1RjQBkp8vX+aQPVAd6x/cn
         DnPM8wdAu26ZQGwvu72j2zRHF+nW35TB9S1/vAdmZoNoszVY9ZayrbNAkc2lXRzl1xJ+
         pe2q4Y21k7VScHyWpafWDGSiJvn6TbGC7ZqYNbR+xAJTQyg9/q4S32Lp0bKrno/8Lj37
         +d5aUKtEajzH6/ikc50ak7Lm6c5SQ+iUBPL8psgApSVx+Si8PRmgNlsY1v6VxqllsdHU
         ljvpjq26H2hWNGdj36gzlS8h3Y88RJyZ0mitGj5TTsy+1IjDyn9qSw5EQg7TDvB8KpIQ
         RvIA==
X-Gm-Message-State: APjAAAVCYDAVmm7xco/c/9NYqUHzxzWAOsPaCPeNVuT9Uy2TXKT3FMD/
        sUZuz70b4f8mbk3lptsxIbPU2w==
X-Google-Smtp-Source: APXvYqyemN7766+ajZJKT2g5ywFxsMiGqQlVVqDb8RBrMgyh3kNU5GnOGQXUwDN7Ta75/P9BRL7+/g==
X-Received: by 2002:ac8:152:: with SMTP id f18mr72304199qtg.84.1560434340859;
        Thu, 13 Jun 2019 06:59:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id u7sm1404209qkh.61.2019.06.13.06.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:59:00 -0700 (PDT)
Date:   Thu, 13 Jun 2019 09:58:59 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 02/19] btrfs: Get zone information of zoned block devices
Message-ID: <20190613135858.re7jp6tsfjpg2pnl@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-3-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-3-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:08PM +0900, Naohiro Aota wrote:
> If a zoned block device is found, get its zone information (number of zones
> and zone size) using the new helper function btrfs_get_dev_zonetypes().  To
> avoid costly run-time zone report commands to test the device zones type
> during block allocation, attach the seqzones bitmap to the device structure
> to indicate if a zone is sequential or accept random writes.
> 
> This patch also introduces the helper function btrfs_dev_is_sequential() to
> test if the zone storing a block is a sequential write required zone.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/volumes.c | 143 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  33 +++++++++++
>  2 files changed, 176 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1c2a6e4b39da..b673178718e3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -786,6 +786,135 @@ static int btrfs_free_stale_devices(const char *path,
>  	return ret;
>  }
>  
> +static int __btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
> +				 struct blk_zone **zones,
> +				 unsigned int *nr_zones, gfp_t gfp_mask)
> +{
> +	struct blk_zone *z = *zones;
> +	int ret;
> +
> +	if (!z) {
> +		z = kcalloc(*nr_zones, sizeof(struct blk_zone), GFP_KERNEL);
> +		if (!z)
> +			return -ENOMEM;
> +	}
> +
> +	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT,
> +				  z, nr_zones, gfp_mask);
> +	if (ret != 0) {
> +		btrfs_err(device->fs_info, "Get zone at %llu failed %d\n",
> +			  pos, ret);
> +		return ret;
> +	}
> +
> +	*zones = z;
> +
> +	return 0;
> +}
> +
> +static void btrfs_destroy_dev_zonetypes(struct btrfs_device *device)
> +{
> +	kfree(device->seq_zones);
> +	kfree(device->empty_zones);
> +	device->seq_zones = NULL;
> +	device->empty_zones = NULL;
> +	device->nr_zones = 0;
> +	device->zone_size = 0;
> +	device->zone_size_shift = 0;
> +}
> +
> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
> +		       struct blk_zone *zone, gfp_t gfp_mask)
> +{
> +	unsigned int nr_zones = 1;
> +	int ret;
> +
> +	ret = __btrfs_get_dev_zones(device, pos, &zone, &nr_zones, gfp_mask);
> +	if (ret != 0 || !nr_zones)
> +		return ret ? ret : -EIO;
> +
> +	return 0;
> +}
> +
> +int btrfs_get_dev_zonetypes(struct btrfs_device *device)
> +{
> +	struct block_device *bdev = device->bdev;
> +	sector_t nr_sectors = bdev->bd_part->nr_sects;
> +	sector_t sector = 0;
> +	struct blk_zone *zones = NULL;
> +	unsigned int i, n = 0, nr_zones;
> +	int ret;
> +
> +	device->zone_size = 0;
> +	device->zone_size_shift = 0;
> +	device->nr_zones = 0;
> +	device->seq_zones = NULL;
> +	device->empty_zones = NULL;
> +
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
> +
> +	device->zone_size = (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;
> +	device->zone_size_shift = ilog2(device->zone_size);
> +	device->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
> +	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
> +		device->nr_zones++;
> +
> +	device->seq_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
> +				    sizeof(*device->seq_zones), GFP_KERNEL);
> +	if (!device->seq_zones)
> +		return -ENOMEM;
> +
> +	device->empty_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
> +				      sizeof(*device->empty_zones), GFP_KERNEL);
> +	if (!device->empty_zones)
> +		return -ENOMEM;
> +
> +#define BTRFS_REPORT_NR_ZONES   4096
> +
> +	/* Get zones type */
> +	while (sector < nr_sectors) {
> +		nr_zones = BTRFS_REPORT_NR_ZONES;
> +		ret = __btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,
> +					    &zones, &nr_zones, GFP_KERNEL);
> +		if (ret != 0 || !nr_zones) {
> +			if (!ret)
> +				ret = -EIO;
> +			goto out;
> +		}
> +
> +		for (i = 0; i < nr_zones; i++) {
> +			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
> +				set_bit(n, device->seq_zones);
> +			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
> +				set_bit(n, device->empty_zones);
> +			sector = zones[i].start + zones[i].len;
> +			n++;
> +		}
> +	}
> +
> +	if (n != device->nr_zones) {
> +		btrfs_err(device->fs_info,
> +			  "Inconsistent number of zones (%u / %u)\n", n,
> +			  device->nr_zones);
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	btrfs_info(device->fs_info,
> +		   "host-%s zoned block device, %u zones of %llu sectors\n",
> +		   bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
> +		   device->nr_zones, device->zone_size >> SECTOR_SHIFT);
> +
> +out:
> +	kfree(zones);
> +
> +	if (ret)
> +		btrfs_destroy_dev_zonetypes(device);
> +
> +	return ret;
> +}
> +
>  static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  			struct btrfs_device *device, fmode_t flags,
>  			void *holder)
> @@ -842,6 +971,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  	device->mode = flags;
>  
> +	/* Get zone type information of zoned block devices */
> +	ret = btrfs_get_dev_zonetypes(device);
> +	if (ret != 0)
> +		goto error_brelse;
> +
>  	fs_devices->open_devices++;
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>  	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> @@ -1243,6 +1377,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
>  	}
>  
>  	blkdev_put(device->bdev, device->mode);
> +	btrfs_destroy_dev_zonetypes(device);
>  }
>  
>  static void btrfs_close_one_device(struct btrfs_device *device)
> @@ -2664,6 +2799,13 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	mutex_unlock(&fs_info->chunk_mutex);
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
> +	/* Get zone type information of zoned block devices */
> +	ret = btrfs_get_dev_zonetypes(device);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto error_sysfs;
> +	}
> +
>  	if (seeding_dev) {
>  		mutex_lock(&fs_info->chunk_mutex);
>  		ret = init_first_rw_device(trans);
> @@ -2729,6 +2871,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	return ret;
>  
>  error_sysfs:
> +	btrfs_destroy_dev_zonetypes(device);
>  	btrfs_sysfs_rm_device_link(fs_devices, device);
>  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>  	mutex_lock(&fs_info->chunk_mutex);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index b8a0e8d0672d..1599641e216c 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -62,6 +62,16 @@ struct btrfs_device {
>  
>  	struct block_device *bdev;
>  
> +	/*
> +	 * Number of zones, zone size and types of zones if bdev is a
> +	 * zoned block device.
> +	 */
> +	u64 zone_size;
> +	u8  zone_size_shift;
> +	u32 nr_zones;
> +	unsigned long *seq_zones;
> +	unsigned long *empty_zones;
> +

Also make a struct btrfs_zone_info and have a pointer to one here if we have
zone devices.  Thanks,

Josef
