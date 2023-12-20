Return-Path: <linux-fsdevel+bounces-6540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F81819725
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 04:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E191F264DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83886156F0;
	Wed, 20 Dec 2023 03:26:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8F14F7F;
	Wed, 20 Dec 2023 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SvzW05Kpjz4f3lD0;
	Wed, 20 Dec 2023 11:26:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E99411A0A10;
	Wed, 20 Dec 2023 11:26:41 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP1 (Coremail) with SMTP id cCh0CgDn6hDuXoJl2ZOBEA--.53812S3;
	Wed, 20 Dec 2023 11:26:40 +0800 (CST)
Message-ID: <64fdffaa-9a8f-df34-42e7-ccca81e95c3c@huaweicloud.com>
Date: Wed, 20 Dec 2023 11:26:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH 3/7] block: Add config option to not allow writing to
 mounted devices
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Kees Cook <keescook@google.com>, syzkaller <syzkaller@googlegroups.com>,
 Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, yangerkun <yangerkun@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-3-jack@suse.cz>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <20231101174325.10596-3-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6hDuXoJl2ZOBEA--.53812S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKr4xtFy8CFy3WFW3Xw43KFg_yoW3AryfpF
	WUGFy3Cry8KFnrWFs3Z3Wxur1agw1Iy343GasIgw10krZ0yFn2gF4vgryUtFy0yrZ3JF4U
	ZF48uryjkFy2krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2023/11/2 1:43, Jan Kara 写道:
> Writing to mounted devices is dangerous and can lead to filesystem
> corruption as well as crashes. Furthermore syzbot comes with more and
> more involved examples how to corrupt block device under a mounted
> filesystem leading to kernel crashes and reports we can do nothing
> about. Add tracking of writers to each block device and a kernel cmdline
> argument which controls whether other writeable opens to block devices
> open with BLK_OPEN_RESTRICT_WRITES flag are allowed. We will make
> filesystems use this flag for used devices.
>
> Note that this effectively only prevents modification of the particular
> block device's page cache by other writers. The actual device content
> can still be modified by other means - e.g. by issuing direct scsi
> commands, by doing writes through devices lower in the storage stack
> (e.g. in case loop devices, DM, or MD are involved) etc. But blocking
> direct modifications of the block device page cache is enough to give
> filesystems a chance to perform data validation when loading data from
> the underlying storage and thus prevent kernel crashes.
>
> Syzbot can use this cmdline argument option to avoid uninteresting
> crashes. Also users whose userspace setup does not need writing to
> mounted block devices can set this option for hardening.
>
> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   block/Kconfig             | 20 +++++++++++++
>   block/bdev.c              | 62 ++++++++++++++++++++++++++++++++++++++-
>   include/linux/blk_types.h |  1 +
>   include/linux/blkdev.h    |  2 ++
>   4 files changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/block/Kconfig b/block/Kconfig
> index f1364d1c0d93..ca04b657e058 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -78,6 +78,26 @@ config BLK_DEV_INTEGRITY_T10
>   	select CRC_T10DIF
>   	select CRC64_ROCKSOFT
>   
> +config BLK_DEV_WRITE_MOUNTED
> +	bool "Allow writing to mounted block devices"
> +	default y
> +	help
> +	When a block device is mounted, writing to its buffer cache is very
> +	likely going to cause filesystem corruption. It is also rather easy to
> +	crash the kernel in this way since the filesystem has no practical way
> +	of detecting these writes to buffer cache and verifying its metadata
> +	integrity. However there are some setups that need this capability
> +	like running fsck on read-only mounted root device, modifying some
> +	features on mounted ext4 filesystem, and similar. If you say N, the
> +	kernel will prevent processes from writing to block devices that are
> +	mounted by filesystems which provides some more protection from runaway
> +	privileged processes and generally makes it much harder to crash
> +	filesystem drivers. Note however that this does not prevent
> +	underlying device(s) from being modified by other means, e.g. by
> +	directly submitting SCSI commands or through access to lower layers of
> +	storage stack. If in doubt, say Y. The configuration can be overridden
> +	with the bdev_allow_write_mounted boot option.
> +
>   config BLK_DEV_ZONED
>   	bool "Zoned block device support"
>   	select MQ_IOSCHED_DEADLINE
> diff --git a/block/bdev.c b/block/bdev.c
> index 3f27939e02c6..d75dd7dd2b31 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -30,6 +30,9 @@
>   #include "../fs/internal.h"
>   #include "blk.h"
>   
> +/* Should we allow writing to mounted block devices? */
> +static bool bdev_allow_write_mounted = IS_ENABLED(CONFIG_BLK_DEV_WRITE_MOUNTED);
> +
>   struct bdev_inode {
>   	struct block_device bdev;
>   	struct inode vfs_inode;
> @@ -730,7 +733,34 @@ void blkdev_put_no_open(struct block_device *bdev)
>   {
>   	put_device(&bdev->bd_device);
>   }
> -	
> +
> +static bool bdev_writes_blocked(struct block_device *bdev)
> +{
> +	return bdev->bd_writers == -1;
> +}
> +
> +static void bdev_block_writes(struct block_device *bdev)
> +{
> +	bdev->bd_writers = -1;
> +}
> +
> +static void bdev_unblock_writes(struct block_device *bdev)
> +{
> +	bdev->bd_writers = 0;
> +}
> +
> +static bool blkdev_open_compatible(struct block_device *bdev, blk_mode_t mode)
> +{
> +	if (!bdev_allow_write_mounted) {
> +		/* Writes blocked? */
> +		if (mode & BLK_OPEN_WRITE && bdev_writes_blocked(bdev))
> +			return false;
> +		if (mode & BLK_OPEN_RESTRICT_WRITES && bdev->bd_writers > 0)
> +			return false;
> +	}
> +	return true;
> +}
> +
>   /**
>    * bdev_open_by_dev - open a block device by device number
>    * @dev: device number of block device to open
> @@ -773,6 +803,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>   	if (ret)
>   		goto free_handle;
>   
> +	/* Blocking writes requires exclusive opener */
> +	if (mode & BLK_OPEN_RESTRICT_WRITES && !holder)
> +		return ERR_PTR(-EINVAL);
> +
>   	bdev = blkdev_get_no_open(dev);
>   	if (!bdev) {
>   		ret = -ENXIO;
> @@ -800,12 +834,21 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>   		goto abort_claiming;
>   	if (!try_module_get(disk->fops->owner))
>   		goto abort_claiming;
> +	ret = -EBUSY;
> +	if (!blkdev_open_compatible(bdev, mode))
> +		goto abort_claiming;
>   	if (bdev_is_partition(bdev))
>   		ret = blkdev_get_part(bdev, mode);
>   	else
>   		ret = blkdev_get_whole(bdev, mode);
>   	if (ret)
>   		goto put_module;
> +	if (!bdev_allow_write_mounted) {
> +		if (mode & BLK_OPEN_RESTRICT_WRITES)
> +			bdev_block_writes(bdev);

Hi, Jan

When a partition device is mounted, I think maybe it's better to block 
writes on the whole device at same time.

Allowing the whole device to be opened for writing when mounting a 
partition device, did you have any special considerations before?

Thanks.

> +		else if (mode & BLK_OPEN_WRITE)
> +			bdev->bd_writers++;
> +	}
>   	if (holder) {
>   		bd_finish_claiming(bdev, holder, hops);
>   
> @@ -901,6 +944,14 @@ void bdev_release(struct bdev_handle *handle)
>   		sync_blockdev(bdev);
>   
>   	mutex_lock(&disk->open_mutex);
> +	if (!bdev_allow_write_mounted) {
> +		/* The exclusive opener was blocking writes? Unblock them. */
> +		if (handle->mode & BLK_OPEN_RESTRICT_WRITES)
> +			bdev_unblock_writes(bdev);
> +		else if (handle->mode & BLK_OPEN_WRITE)
> +			bdev->bd_writers--;
> +	}
> +
>   	if (handle->holder)
>   		bd_end_claim(bdev, handle->holder);
>   
> @@ -1069,3 +1120,12 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>   
>   	blkdev_put_no_open(bdev);
>   }
> +
> +static int __init setup_bdev_allow_write_mounted(char *str)
> +{
> +	if (kstrtobool(str, &bdev_allow_write_mounted))
> +		pr_warn("Invalid option string for bdev_allow_write_mounted:"
> +			" '%s'\n", str);
> +	return 1;
> +}
> +__setup("bdev_allow_write_mounted=", setup_bdev_allow_write_mounted);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 749203277fee..52e264d5a830 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -66,6 +66,7 @@ struct block_device {
>   #ifdef CONFIG_FAIL_MAKE_REQUEST
>   	bool			bd_make_it_fail;
>   #endif
> +	int			bd_writers;
>   	/*
>   	 * keep this out-of-line as it's both big and not needed in the fast
>   	 * path
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 7afc10315dd5..0e0c0186aa32 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -124,6 +124,8 @@ typedef unsigned int __bitwise blk_mode_t;
>   #define BLK_OPEN_NDELAY		((__force blk_mode_t)(1 << 3))
>   /* open for "writes" only for ioctls (specialy hack for floppy.c) */
>   #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
> +/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
> +#define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
>   
>   struct gendisk {
>   	/*


