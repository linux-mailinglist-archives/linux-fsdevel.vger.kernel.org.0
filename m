Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1039AEB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390202AbfHWMHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 08:07:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729830AbfHWMHI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:07:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FD14ADF1;
        Fri, 23 Aug 2019 12:07:06 +0000 (UTC)
Subject: Re: [PATCH v4 03/27] btrfs: Check and enable HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
 <20190823101036.796932-4-naohiro.aota@wdc.com>
From:   Johannes Thumshirn <jthumshirn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=jthumshirn@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9c947b6c-c74d-24eb-ff6b-b448c8acfa40@suse.de>
Date:   Fri, 23 Aug 2019 14:07:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823101036.796932-4-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/08/2019 12:10, Naohiro Aota wrote:
> HMZONED mode cannot be used together with the RAID5/6 profile for now.
> Introduce the function btrfs_check_hmzoned_mode() to check this. This
> function will also check if HMZONED flag is enabled on the file system and
> if the file system consists of zoned devices with equal zone size.
> 
> Additionally, as updates to the space cache are in-place, the space cache
> cannot be located over sequential zones and there is no guarantees that the
> device will have enough conventional zones to store this cache. Resolve
> this problem by disabling completely the space cache.  This does not
completely disabling ~^

> introduces any problems with sequential block groups: all the free space is
introduce ~^

> located after the allocation pointer and no free space before the pointer.
                                           is located? ~^
> There is no need to have such cache.
> 
> For the same reason, NODATACOW is also disabled.
> 
> Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
> INODE_MAP_CACHE inode.
> 
> In summary, HMZONED will disable:
> 
> | Disabled features | Reason                                              |
> |-------------------+-----------------------------------------------------|
> | RAID5/6           | 1) Non-full stripe write cause overwriting of       |
> |                   | parity block                                        |
> |                   | 2) Rebuilding on high capacity volume (usually with |
> |                   | SMR) can lead to higher failure rate                |
> |-------------------+-----------------------------------------------------|
> | space_cache (v1)  | In-place updating                                   |
> | NODATACOW         | In-place updating                                   |
> |-------------------+-----------------------------------------------------|
> | tree-log          | Partial write out of metadata creates write holes   |
> |-------------------+-----------------------------------------------------|
> | fallocate         | Reserved extent will be a write hole                |
> | INODE_MAP_CACHE   | Need pre-allocation. (and will be deprecated?)      |
> |-------------------+-----------------------------------------------------|
> | MIXED_BG          | Allocated metadata region will be write holes for   |
> |                   | data writes                                         |
> | async checksum    | Not to mix up bios by multiple workers              |
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/ctree.h       |  3 ++
>  fs/btrfs/dev-replace.c |  8 +++++
>  fs/btrfs/disk-io.c     |  8 +++++
>  fs/btrfs/hmzoned.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/hmzoned.h     | 18 ++++++++++++
>  fs/btrfs/super.c       |  1 +
>  fs/btrfs/volumes.c     |  5 ++++
>  7 files changed, 110 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 94660063a162..221259737703 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -712,6 +712,9 @@ struct btrfs_fs_info {
>  	struct btrfs_root *uuid_root;
>  	struct btrfs_root *free_space_root;
>  
> +	/* Zone size when in HMZONED mode */
> +	u64 zone_size;
> +
>  	/* the log root tree is a directory of all the other log roots */
>  	struct btrfs_root *log_root_tree;
>  
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 6b2e9aa83ffa..2cc3ac4d101d 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -20,6 +20,7 @@
>  #include "rcu-string.h"
>  #include "dev-replace.h"
>  #include "sysfs.h"
> +#include "hmzoned.h"
>  
>  static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>  				       int scrub_ret);
> @@ -201,6 +202,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  		return PTR_ERR(bdev);
>  	}
>  
> +	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
> +		btrfs_err(fs_info,
> +			  "zone type of target device mismatch with the filesystem!");
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
>  	sync_blockdev(bdev);
>  
>  	devices = &fs_info->fs_devices->devices;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 97beb351a10c..3f5ea92f546c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -40,6 +40,7 @@
>  #include "compression.h"
>  #include "tree-checker.h"
>  #include "ref-verify.h"
> +#include "hmzoned.h"
>  
>  #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
>  				 BTRFS_HEADER_FLAG_RELOC |\
> @@ -3121,6 +3122,13 @@ int open_ctree(struct super_block *sb,
>  
>  	btrfs_free_extra_devids(fs_devices, 1);
>  
> +	ret = btrfs_check_hmzoned_mode(fs_info);
> +	if (ret) {
> +		btrfs_err(fs_info, "failed to init hmzoned mode: %d",
> +				ret);
> +		goto fail_block_groups;
> +	}
> +
>  	ret = btrfs_sysfs_add_fsid(fs_devices, NULL);
>  	if (ret) {
>  		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
> diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
> index 23bf58d3d7bb..ca58eee08a70 100644
> --- a/fs/btrfs/hmzoned.c
> +++ b/fs/btrfs/hmzoned.c
> @@ -157,3 +157,70 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  
>  	return 0;
>  }
> +
> +int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 hmzoned_devices = 0;
> +	u64 nr_devices = 0;
> +	u64 zone_size = 0;
> +	int incompat_hmzoned = btrfs_fs_incompat(fs_info, HMZONED);
> +	int ret = 0;
> +
> +	/* Count zoned devices */
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (!device->bdev)
> +			continue;
> +		if (bdev_zoned_model(device->bdev) == BLK_ZONED_HM ||
> +		    (bdev_zoned_model(device->bdev) == BLK_ZONED_HA &&
> +		     incompat_hmzoned)) {
> +			hmzoned_devices++;
> +			if (!zone_size) {
> +				zone_size = device->zone_info->zone_size;
> +			} else if (device->zone_info->zone_size != zone_size) {
> +				btrfs_err(fs_info,
> +					  "Zoned block devices must have equal zone sizes");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		}
> +		nr_devices++;
> +	}
> +
> +	if (!hmzoned_devices && incompat_hmzoned) {
> +		/* No zoned block device found on HMZONED FS */
> +		btrfs_err(fs_info, "HMZONED enabled file system should have zoned devices");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!hmzoned_devices && !incompat_hmzoned)
> +		goto out;
> +
> +	fs_info->zone_size = zone_size;
> +
> +	if (hmzoned_devices != nr_devices) {
> +		btrfs_err(fs_info,
> +			  "zoned devices cannot be mixed with regular devices");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
> +	 * __btrfs_alloc_chunk(). Since we want stripe_len == zone_size,
> +	 * check the alignment here.
> +	 */
> +	if (!IS_ALIGNED(zone_size, BTRFS_STRIPE_LEN)) {
> +		btrfs_err(fs_info,
> +			  "zone size is not aligned to BTRFS_STRIPE_LEN");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
> +		   fs_info->zone_size);
> +out:
> +	return ret;
> +}
> diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
> index ffc70842135e..29cfdcabff2f 100644
> --- a/fs/btrfs/hmzoned.h
> +++ b/fs/btrfs/hmzoned.h
> @@ -9,6 +9,8 @@
>  #ifndef BTRFS_HMZONED_H
>  #define BTRFS_HMZONED_H
>  
> +#include <linux/blkdev.h>
> +
>  struct btrfs_zoned_device_info {
>  	/*
>  	 * Number of zones, zone size and types of zones if bdev is a
> @@ -25,6 +27,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  		       struct blk_zone *zone, gfp_t gfp_mask);
>  int btrfs_get_dev_zone_info(struct btrfs_device *device);
>  void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
> +int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);


While we're at it, shouldn't all the functions in hmzoned.[ch] have a
!CONFIG_BLK_DEV_ZONED compat wrapper and hmzoned.o is dependent on
CONFIG_BLK_DEV_ZONED?

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
