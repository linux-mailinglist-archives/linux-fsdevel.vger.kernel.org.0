Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C383674E3D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 04:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGKCCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 22:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGKCCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:02:34 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D15ABF;
        Mon, 10 Jul 2023 19:02:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R0PJd2DNqz4f3mLs;
        Tue, 11 Jul 2023 10:02:25 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLMxuKxkk2rFNg--.4720S3;
        Tue, 11 Jul 2023 10:02:27 +0800 (CST)
Subject: Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net,
        jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Donald Buczek <buczek@molgen.mpg.de>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-3-sergei.shtepa@veeam.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f935840e-12a7-c37b-183c-27e2d83990ea@huaweicloud.com>
Date:   Tue, 11 Jul 2023 10:02:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230612135228.10702-3-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLMxuKxkk2rFNg--.4720S3
X-Coremail-Antispam: 1UD129KBjvAXoWfuF43JF45uF18WF18Kw45KFg_yoW8uFy5Co
        WSqrsxZF1rArW7GrZ7tr97AF13u34DGw4UGa9xCrs8Z3W2yw1jkws2kF45J3ZYgF1rtr4f
        Aa43Z3ykJFs5tF4rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI
        62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
        ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

�� 2023/06/12 21:52, Sergei Shtepa д��:
> The block device filtering mechanism is an API that allows to attach
> block device filters. Block device filters allow perform additional
> processing for I/O units.
> 
> The idea of handling I/O units on block devices is not new. Back in the
> 2.6 kernel, there was an undocumented possibility of handling I/O units
> by substituting the make_request_fn() function, which belonged to the
> request_queue structure. But none of the in-tree kernel modules used
> this feature, and it was eliminated in the 5.10 kernel.
> 
> The block device filtering mechanism returns the ability to handle I/O
> units. It is possible to safely attach filter to a block device "on the
> fly" without changing the structure of block devices stack.
> 
> Co-developed-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@infradead.org>
> Tested-by: Donald Buczek <buczek@molgen.mpg.de>
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>   MAINTAINERS                     |   3 +
>   block/Makefile                  |   3 +-
>   block/bdev.c                    |   1 +
>   block/blk-core.c                |  27 ++++
>   block/blk-filter.c              | 213 ++++++++++++++++++++++++++++++++
>   block/blk.h                     |  11 ++
>   block/genhd.c                   |  10 ++
>   block/ioctl.c                   |   7 ++
>   block/partitions/core.c         |  10 ++
>   include/linux/blk-filter.h      |  51 ++++++++
>   include/linux/blk_types.h       |   2 +
>   include/linux/blkdev.h          |   1 +
>   include/uapi/linux/blk-filter.h |  35 ++++++
>   include/uapi/linux/fs.h         |   3 +
>   14 files changed, 376 insertions(+), 1 deletion(-)
>   create mode 100644 block/blk-filter.c
>   create mode 100644 include/linux/blk-filter.h
>   create mode 100644 include/uapi/linux/blk-filter.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d801b8985b43..8336b6143a71 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3585,6 +3585,9 @@ M:	Sergei Shtepa <sergei.shtepa@veeam.com>
>   L:	linux-block@vger.kernel.org
>   S:	Supported
>   F:	Documentation/block/blkfilter.rst
> +F:	block/blk-filter.c
> +F:	include/linux/blk-filter.h
> +F:	include/uapi/linux/blk-filter.h
>   
>   BLOCK LAYER
>   M:	Jens Axboe <axboe@kernel.dk>
> diff --git a/block/Makefile b/block/Makefile
> index 46ada9dc8bbf..041c54eb0240 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -9,7 +9,8 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
>   			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
>   			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
>   			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
> -			disk-events.o blk-ia-ranges.o early-lookup.o
> +			disk-events.o blk-ia-ranges.o early-lookup.o \
> +			blk-filter.o
>   
>   obj-$(CONFIG_BOUNCE)		+= bounce.o
>   obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
> diff --git a/block/bdev.c b/block/bdev.c
> index 5c46ff107706..369f73b6097a 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -429,6 +429,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>   		return NULL;
>   	}
>   	bdev->bd_disk = disk;
> +	bdev->bd_filter = NULL;
>   	return bdev;
>   }
>   
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 2ae22bebeb3e..ede04c6ad021 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -18,6 +18,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/blk-pm.h>
>   #include <linux/blk-integrity.h>
> +#include <linux/blk-filter.h>
>   #include <linux/highmem.h>
>   #include <linux/mm.h>
>   #include <linux/pagemap.h>
> @@ -586,8 +587,24 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>   	return BLK_STS_OK;
>   }
>   
> +static bool submit_bio_filter(struct bio *bio)
> +{
> +	if (bio_flagged(bio, BIO_FILTERED))
> +		return false;
> +
> +	bio_set_flag(bio, BIO_FILTERED);
> +	return bio->bi_bdev->bd_filter->ops->submit_bio(bio);
> +}
> +
>   static void __submit_bio(struct bio *bio)
>   {
> +	/*
> +	 * If there is a filter driver attached, check if the BIO needs to go to
> +	 * the filter driver first, which can then pass on the bio or consume it.
> +	 */
> +	if (bio->bi_bdev->bd_filter && submit_bio_filter(bio))
> +		return;
> +
>   	if (unlikely(!blk_crypto_bio_prep(&bio)))
>   		return;
>   
> @@ -677,6 +694,15 @@ static void __submit_bio_noacct_mq(struct bio *bio)
>   	current->bio_list = NULL;
>   }
>   
> +/**
> + * submit_bio_noacct_nocheck - re-submit a bio to the block device layer for I/O
> + *	from block device filter.
> + * @bio:  The bio describing the location in memory and on the device.
> + *
> + * This is a version of submit_bio() that shall only be used for I/O that is
> + * resubmitted to lower level by block device filters.  All file  systems and
> + * other upper level users of the block layer should use submit_bio() instead.
> + */
>   void submit_bio_noacct_nocheck(struct bio *bio)
>   {
>   	blk_cgroup_bio_start(bio);
> @@ -704,6 +730,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>   	else
>   		__submit_bio_noacct(bio);
>   }
> +EXPORT_SYMBOL_GPL(submit_bio_noacct_nocheck);
>   
>   /**
>    * submit_bio_noacct - re-submit a bio to the block device layer for I/O
> diff --git a/block/blk-filter.c b/block/blk-filter.c
> new file mode 100644
> index 000000000000..bf31da6acf67
> --- /dev/null
> +++ b/block/blk-filter.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2023 Veeam Software Group GmbH */
> +#include <linux/blk-filter.h>
> +#include <linux/blk-mq.h>
> +#include <linux/module.h>
> +
> +#include "blk.h"
> +
> +static LIST_HEAD(blkfilters);
> +static DEFINE_SPINLOCK(blkfilters_lock);
> +
> +static inline struct blkfilter_operations *__blkfilter_find(const char *name)
> +{
> +	struct blkfilter_operations *ops;
> +
> +	list_for_each_entry(ops, &blkfilters, link)
> +		if (strncmp(ops->name, name, BLKFILTER_NAME_LENGTH) == 0)
> +			return ops;
> +
> +	return NULL;
> +}
> +
> +static inline struct blkfilter_operations *blkfilter_find_get(const char *name)
> +{
> +	struct blkfilter_operations *ops;
> +
> +	spin_lock(&blkfilters_lock);
> +	ops = __blkfilter_find(name);
> +	if (ops && !try_module_get(ops->owner))
> +		ops = NULL;
> +	spin_unlock(&blkfilters_lock);
> +
> +	return ops;
> +}
> +
> +int blkfilter_ioctl_attach(struct block_device *bdev,
> +		    struct blkfilter_name __user *argp)
> +{
> +	struct blkfilter_name name;
> +	struct blkfilter_operations *ops;
> +	struct blkfilter *flt;
> +	int ret;
> +
> +	if (copy_from_user(&name, argp, sizeof(name)))
> +		return -EFAULT;
> +
> +	ops = blkfilter_find_get(name.name);
> +	if (!ops)
> +		return -ENOENT;
> +
> +	ret = freeze_bdev(bdev);
> +	if (ret)
> +		goto out_put_module;
> +	blk_mq_freeze_queue(bdev->bd_queue);
> +
> +	if (bdev->bd_filter) {
> +		if (bdev->bd_filter->ops == ops)
> +			ret = -EALREADY;
> +		else
> +			ret = -EBUSY;
> +		goto out_unfreeze;
> +	}
> +
> +	flt = ops->attach(bdev);
> +	if (IS_ERR(flt)) {
> +		ret = PTR_ERR(flt);
> +		goto out_unfreeze;
> +	}
> +
> +	flt->ops = ops;
> +	bdev->bd_filter = flt;
> +
> +out_unfreeze:
> +	blk_mq_unfreeze_queue(bdev->bd_queue);
> +	thaw_bdev(bdev);
> +out_put_module:
> +	if (ret)
> +		module_put(ops->owner);
> +	return ret;
> +}
> +
> +static void __blkfilter_detach(struct block_device *bdev)
> +{
> +	struct blkfilter *flt = bdev->bd_filter;
> +	const struct blkfilter_operations *ops = flt->ops;
> +
> +	bdev->bd_filter = NULL;
> +	ops->detach(flt);
> +	module_put(ops->owner);
> +}
> +
> +void blkfilter_detach(struct block_device *bdev)
> +{
> +	if (bdev->bd_filter) {
> +		blk_mq_freeze_queue(bdev->bd_queue);
> +		__blkfilter_detach(bdev);
> +		blk_mq_unfreeze_queue(bdev->bd_queue);
> +	}
> +}
> +
> +int blkfilter_ioctl_detach(struct block_device *bdev,
> +		    struct blkfilter_name __user *argp)
> +{
> +	struct blkfilter_name name;
> +	int error = 0;
> +
> +	if (copy_from_user(&name, argp, sizeof(name)))
> +		return -EFAULT;
> +
> +	blk_mq_freeze_queue(bdev->bd_queue);
> +	if (!bdev->bd_filter) {
> +		error = -ENOENT;
> +		goto out_unfreeze;
> +	}
> +	if (strncmp(bdev->bd_filter->ops->name, name.name,
> +			BLKFILTER_NAME_LENGTH)) {
> +		error = -EINVAL;
> +		goto out_unfreeze;
> +	}
> +
> +	__blkfilter_detach(bdev);
> +out_unfreeze:
> +	blk_mq_unfreeze_queue(bdev->bd_queue);
> +	return error;
> +}
> +
> +int blkfilter_ioctl_ctl(struct block_device *bdev,
> +		    struct blkfilter_ctl __user *argp)
> +{
> +	struct blkfilter_ctl ctl;
> +	struct blkfilter *flt;
> +	int ret;
> +
> +	if (copy_from_user(&ctl, argp, sizeof(ctl)))
> +		return -EFAULT;
> +
> +	ret = blk_queue_enter(bdev_get_queue(bdev), 0);
> +	if (ret)
> +		return ret;
> +
> +	flt = bdev->bd_filter;
> +	if (!flt || strncmp(flt->ops->name, ctl.name, BLKFILTER_NAME_LENGTH)) {
> +		ret = -ENOENT;
> +		goto out_queue_exit;
> +	}
> +
> +	if (!flt->ops->ctl) {
> +		ret = -ENOTTY;
> +		goto out_queue_exit;
> +	}
> +
> +	ret = flt->ops->ctl(flt, ctl.cmd, u64_to_user_ptr(ctl.opt),
> +			    &ctl.optlen);
> +out_queue_exit:
> +	blk_queue_exit(bdev_get_queue(bdev));
> +	return ret;
> +}
> +
> +ssize_t blkfilter_show(struct block_device *bdev, char *buf)
> +{
> +	ssize_t ret = 0;
> +
> +	blk_mq_freeze_queue(bdev->bd_queue);
> +	if (bdev->bd_filter)
> +		ret = sprintf(buf, "%s\n", bdev->bd_filter->ops->name);
> +	else
> +		ret = sprintf(buf, "\n");
> +	blk_mq_unfreeze_queue(bdev->bd_queue);
> +
> +	return ret;
> +}
> +
> +/**
> + * blkfilter_register() - Register block device filter operations
> + * @ops:	The operations to register.
> + *
> + * Return:
> + *	0 if succeeded,
> + *	-EBUSY if a block device filter with the same name is already
> + *	registered.
> + */
> +int blkfilter_register(struct blkfilter_operations *ops)
> +{
> +	struct blkfilter_operations *found;
> +	int ret = 0;
> +
> +	spin_lock(&blkfilters_lock);
> +	found = __blkfilter_find(ops->name);
> +	if (found)
> +		ret = -EBUSY;
> +	else
> +		list_add_tail(&ops->link, &blkfilters);
> +	spin_unlock(&blkfilters_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blkfilter_register);
> +
> +/**
> + * blkfilter_unregister() - Unregister block device filter operations
> + * @ops:	The operations to unregister.
> + *
> + * Important: before unloading, it is necessary to detach the filter from all
> + * block devices.
> + *
> + */
> +void blkfilter_unregister(struct blkfilter_operations *ops)
> +{
> +	spin_lock(&blkfilters_lock);
> +	list_del(&ops->link);
> +	spin_unlock(&blkfilters_lock);
> +}
> +EXPORT_SYMBOL_GPL(blkfilter_unregister);
> diff --git a/block/blk.h b/block/blk.h
> index 9582fcd0df41..2c14fa938d8c 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -7,6 +7,8 @@
>   #include <xen/xen.h>
>   #include "blk-crypto-internal.h"
>   
> +struct blkfilter_ctl;
> +struct blkfilter_name;
>   struct elevator_type;
>   
>   /* Max future timer expiry for timeouts */
> @@ -454,6 +456,15 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>   
>   extern const struct address_space_operations def_blk_aops;
>   
> +int blkfilter_ioctl_attach(struct block_device *bdev,
> +		    struct blkfilter_name __user *argp);
> +int blkfilter_ioctl_detach(struct block_device *bdev,
> +		    struct blkfilter_name __user *argp);
> +int blkfilter_ioctl_ctl(struct block_device *bdev,
> +		    struct blkfilter_ctl __user *argp);
> +void blkfilter_detach(struct block_device *bdev);
> +ssize_t blkfilter_show(struct block_device *bdev, char *buf);
> +
>   int disk_register_independent_access_ranges(struct gendisk *disk);
>   void disk_unregister_independent_access_ranges(struct gendisk *disk);
>   
> diff --git a/block/genhd.c b/block/genhd.c
> index 4e5fd6aaa883..d9aca0797886 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -25,6 +25,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/badblocks.h>
>   #include <linux/part_stat.h>
> +#include <linux/blk-filter.h>
>   #include "blk-throttle.h"
>   
>   #include "blk.h"
> @@ -648,6 +649,7 @@ void del_gendisk(struct gendisk *disk)
>   		remove_inode_hash(part->bd_inode);
>   		fsync_bdev(part);
>   		__invalidate_device(part, true);
> +		blkfilter_detach(part);
>   	}
>   	mutex_unlock(&disk->open_mutex);
>   
> @@ -1033,6 +1035,12 @@ static ssize_t diskseq_show(struct device *dev,
>   	return sprintf(buf, "%llu\n", disk->diskseq);
>   }
>   
> +static ssize_t disk_filter_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return blkfilter_show(dev_to_bdev(dev), buf);
> +}
> +
>   static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
>   static DEVICE_ATTR(ext_range, 0444, disk_ext_range_show, NULL);
>   static DEVICE_ATTR(removable, 0444, disk_removable_show, NULL);
> @@ -1046,6 +1054,7 @@ static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
>   static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
>   static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
>   static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
> +static DEVICE_ATTR(filter, 0444, disk_filter_show, NULL);
>   
>   #ifdef CONFIG_FAIL_MAKE_REQUEST
>   ssize_t part_fail_show(struct device *dev,
> @@ -1092,6 +1101,7 @@ static struct attribute *disk_attrs[] = {
>   	&dev_attr_events_async.attr,
>   	&dev_attr_events_poll_msecs.attr,
>   	&dev_attr_diskseq.attr,
> +	&dev_attr_filter.attr,
>   #ifdef CONFIG_FAIL_MAKE_REQUEST
>   	&dev_attr_fail.attr,
>   #endif
> diff --git a/block/ioctl.c b/block/ioctl.c
> index c7d7d4345edb..170020d1ce0e 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -2,6 +2,7 @@
>   #include <linux/capability.h>
>   #include <linux/compat.h>
>   #include <linux/blkdev.h>
> +#include <linux/blk-filter.h>
>   #include <linux/export.h>
>   #include <linux/gfp.h>
>   #include <linux/blkpg.h>
> @@ -546,6 +547,12 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>   		return blkdev_pr_preempt(bdev, argp, true);
>   	case IOC_PR_CLEAR:
>   		return blkdev_pr_clear(bdev, argp);
> +	case BLKFILTER_ATTACH:
> +		return blkfilter_ioctl_attach(bdev, argp);
> +	case BLKFILTER_DETACH:
> +		return blkfilter_ioctl_detach(bdev, argp);
> +	case BLKFILTER_CTL:
> +		return blkfilter_ioctl_ctl(bdev, argp);
>   	default:
>   		return -ENOIOCTLCMD;
>   	}
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 87a21942d606..8e2834566c38 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -10,6 +10,7 @@
>   #include <linux/ctype.h>
>   #include <linux/vmalloc.h>
>   #include <linux/raid/detect.h>
> +#include <linux/blk-filter.h>
>   #include "check.h"
>   
>   static int (*const check_part[])(struct parsed_partitions *) = {
> @@ -200,6 +201,12 @@ static ssize_t part_discard_alignment_show(struct device *dev,
>   	return sprintf(buf, "%u\n", bdev_discard_alignment(dev_to_bdev(dev)));
>   }
>   
> +static ssize_t part_filter_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return blkfilter_show(dev_to_bdev(dev), buf);
> +}
> +
>   static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
>   static DEVICE_ATTR(start, 0444, part_start_show, NULL);
>   static DEVICE_ATTR(size, 0444, part_size_show, NULL);
> @@ -208,6 +215,7 @@ static DEVICE_ATTR(alignment_offset, 0444, part_alignment_offset_show, NULL);
>   static DEVICE_ATTR(discard_alignment, 0444, part_discard_alignment_show, NULL);
>   static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
>   static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
> +static DEVICE_ATTR(filter, 0444, part_filter_show, NULL);
>   #ifdef CONFIG_FAIL_MAKE_REQUEST
>   static struct device_attribute dev_attr_fail =
>   	__ATTR(make-it-fail, 0644, part_fail_show, part_fail_store);
> @@ -222,6 +230,7 @@ static struct attribute *part_attrs[] = {
>   	&dev_attr_discard_alignment.attr,
>   	&dev_attr_stat.attr,
>   	&dev_attr_inflight.attr,
> +	&dev_attr_filter.attr,
>   #ifdef CONFIG_FAIL_MAKE_REQUEST
>   	&dev_attr_fail.attr,
>   #endif
> @@ -284,6 +293,7 @@ static void delete_partition(struct block_device *part)
>   
>   	fsync_bdev(part);
>   	__invalidate_device(part, true);
> +	blkfilter_detach(part);

bdev_disk_changed() is not handled, where delete_partition() and
add_partition() will be called, this means blkfilter for partiton will
be removed after partition rescan. Am I missing something?

Thanks,
Kuai
>   
>   	drop_partition(part);
>   }
> diff --git a/include/linux/blk-filter.h b/include/linux/blk-filter.h
> new file mode 100644
> index 000000000000..0afdb40f3bab
> --- /dev/null
> +++ b/include/linux/blk-filter.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2023 Veeam Software Group GmbH */
> +#ifndef _LINUX_BLK_FILTER_H
> +#define _LINUX_BLK_FILTER_H
> +
> +#include <uapi/linux/blk-filter.h>
> +
> +struct bio;
> +struct block_device;
> +struct blkfilter_operations;
> +
> +/**
> + * struct blkfilter - Block device filter.
> + *
> + * @ops:	Block device filter operations.
> + *
> + * For each filtered block device, the filter creates a data structure
> + * associated with this device. The data in this structure is specific to the
> + * filter, but it must contain a pointer to the block device filter account.
> + */
> +struct blkfilter {
> +	const struct blkfilter_operations *ops;
> +};
> +
> +/**
> + * struct blkfilter_operations - Block device filter operations.
> + *
> + * @link:	Entry in the global list of filter drivers
> + *		(must not be accessed by the driver).
> + * @owner:	Module implementing the filter driver.
> + * @name:	Name of the filter driver.
> + * @attach:	Attach the filter driver to the block device.
> + * @detach:	Detach the filter driver from the block device.
> + * @ctl:	Send a control command to the filter driver.
> + * @submit_bio:	Handle bio submissions to the filter driver.
> + */
> +struct blkfilter_operations {
> +	struct list_head link;
> +	struct module *owner;
> +	const char *name;
> +	struct blkfilter *(*attach)(struct block_device *bdev);
> +	void (*detach)(struct blkfilter *flt);
> +	int (*ctl)(struct blkfilter *flt, const unsigned int cmd,
> +		   __u8 __user *buf, __u32 *plen);
> +	bool (*submit_bio)(struct bio *bio);
> +};
> +
> +int blkfilter_register(struct blkfilter_operations *ops);
> +void blkfilter_unregister(struct blkfilter_operations *ops);
> +
> +#endif /* _UAPI_LINUX_BLK_FILTER_H */
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index deb69eeab6bd..5ba313b3b11d 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -75,6 +75,7 @@ struct block_device {
>   	 * path
>   	 */
>   	struct device		bd_device;
> +	struct blkfilter	*bd_filter;
>   } __randomize_layout;
>   
>   #define bdev_whole(_bdev) \
> @@ -341,6 +342,7 @@ enum {
>   	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
>   	BIO_REMAPPED,
>   	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
> +	BIO_FILTERED,		/* bio has already been filtered */
>   	BIO_FLAG_LAST
>   };
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f4c339d9dd03..e7a4a4866792 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -842,6 +842,7 @@ void blk_request_module(dev_t devt);
>   
>   extern int blk_register_queue(struct gendisk *disk);
>   extern void blk_unregister_queue(struct gendisk *disk);
> +void submit_bio_noacct_nocheck(struct bio *bio);
>   void submit_bio_noacct(struct bio *bio);
>   struct bio *bio_split_to_limits(struct bio *bio);
>   
> diff --git a/include/uapi/linux/blk-filter.h b/include/uapi/linux/blk-filter.h
> new file mode 100644
> index 000000000000..18885dc1b717
> --- /dev/null
> +++ b/include/uapi/linux/blk-filter.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (C) 2023 Veeam Software Group GmbH */
> +#ifndef _UAPI_LINUX_BLK_FILTER_H
> +#define _UAPI_LINUX_BLK_FILTER_H
> +
> +#include <linux/types.h>
> +
> +#define BLKFILTER_NAME_LENGTH	32
> +
> +/**
> + * struct blkfilter_name - parameter for BLKFILTER_ATTACH and BLKFILTER_DETACH
> + *      ioctl.
> + *
> + * @name:       Name of block device filter.
> + */
> +struct blkfilter_name {
> +	__u8 name[BLKFILTER_NAME_LENGTH];
> +};
> +
> +/**
> + * struct blkfilter_ctl - parameter for BLKFILTER_CTL ioctl
> + *
> + * @name:	Name of block device filter.
> + * @cmd:	The filter-specific operation code of the command.
> + * @optlen:	Size of data at @opt.
> + * @opt:	Userspace buffer with options.
> + */
> +struct blkfilter_ctl {
> +	__u8 name[BLKFILTER_NAME_LENGTH];
> +	__u32 cmd;
> +	__u32 optlen;
> +	__u64 opt;
> +};
> +
> +#endif /* _UAPI_LINUX_BLK_FILTER_H */
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..7904f157b245 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -189,6 +189,9 @@ struct fsxattr {
>    * A jump here: 130-136 are reserved for zoned block devices
>    * (see uapi/linux/blkzoned.h)
>    */
> +#define BLKFILTER_ATTACH	_IOWR(0x12, 140, struct blkfilter_name)
> +#define BLKFILTER_DETACH	_IOWR(0x12, 141, struct blkfilter_name)
> +#define BLKFILTER_CTL		_IOWR(0x12, 142, struct blkfilter_ctl)
>   
>   #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
>   #define FIBMAP	   _IO(0x00,1)	/* bmap access */
> 

