Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C104273EEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIVJvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 05:51:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:58380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgIVJvu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:51:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3226EADCD;
        Tue, 22 Sep 2020 09:52:25 +0000 (UTC)
Subject: Re: [PATCH 07/13] block: lift setting the readahead size into the
 block layer
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
References: <20200921080734.452759-1-hch@lst.de>
 <20200921080734.452759-8-hch@lst.de>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <c6bb4a65-33f5-8e96-fe61-c8b91372d76a@suse.de>
Date:   Tue, 22 Sep 2020 17:51:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921080734.452759-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/9/21 16:07, Christoph Hellwig wrote:
> Drivers shouldn't really mess with the readahead size, as that is a VM
> concept.  Instead set it based on the optimal I/O size by lifting the
> algorithm from the md driver when registering the disk.  Also set
> bdi->io_pages there as well by applying the same scheme based on
> max_sectors.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

For the bcache part,

Acked-by: Coly Li <colyli@suse.de>


Thanks.

Coly Li


> ---
>  block/blk-settings.c         |  5 ++---
>  block/blk-sysfs.c            |  9 +++++++++
>  drivers/block/aoe/aoeblk.c   |  1 -
>  drivers/block/drbd/drbd_nl.c | 12 +-----------
>  drivers/md/bcache/super.c    |  3 ---
>  drivers/md/raid0.c           | 16 ----------------
>  drivers/md/raid10.c          | 24 +-----------------------
>  drivers/md/raid5.c           | 13 +------------
>  8 files changed, 14 insertions(+), 69 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 76a7e03bcd6cac..01049e9b998f1d 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -452,6 +452,8 @@ EXPORT_SYMBOL(blk_limits_io_opt);
>  void blk_queue_io_opt(struct request_queue *q, unsigned int opt)
>  {
>  	blk_limits_io_opt(&q->limits, opt);
> +	q->backing_dev_info->ra_pages =
> +		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
>  }
>  EXPORT_SYMBOL(blk_queue_io_opt);
>  
> @@ -628,9 +630,6 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
>  		printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
>  		       top, bottom);
>  	}
> -
> -	t->backing_dev_info->io_pages =
> -		t->limits.max_sectors >> (PAGE_SHIFT - 9);
>  }
>  EXPORT_SYMBOL(disk_stack_limits);
>  
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 81722cdcf0cb21..83915b4a1fc3ad 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -854,6 +854,15 @@ int blk_register_queue(struct gendisk *disk)
>  		percpu_ref_switch_to_percpu(&q->q_usage_counter);
>  	}
>  
> +	/*
> +	 * For read-ahead of large files to be effective, we need to read ahead
> +	 * at least twice the optimal I/O size.
> +	 */
> +	q->backing_dev_info->ra_pages =
> +		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> +	q->backing_dev_info->io_pages =
> +		queue_max_sectors(q) >> (PAGE_SHIFT - 9);
> +
>  	ret = blk_trace_init_sysfs(dev);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> index d8cfc233e64b93..c34e71b0c4a98c 100644
> --- a/drivers/block/aoe/aoeblk.c
> +++ b/drivers/block/aoe/aoeblk.c
> @@ -406,7 +406,6 @@ aoeblk_gdalloc(void *vp)
>  	WARN_ON(d->gd);
>  	WARN_ON(d->flags & DEVFL_UP);
>  	blk_queue_max_hw_sectors(q, BLK_DEF_MAX_SECTORS);
> -	q->backing_dev_info->ra_pages = SZ_2M / PAGE_SIZE;
>  	blk_queue_io_opt(q, SZ_2M);
>  	d->bufpool = mp;
>  	d->blkq = gd->queue = q;
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index aaff5bde391506..f8fb1c9b1bb6c1 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1360,18 +1360,8 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
>  	decide_on_discard_support(device, q, b, discard_zeroes_if_aligned);
>  	decide_on_write_same_support(device, q, b, o, disable_write_same);
>  
> -	if (b) {
> +	if (b)
>  		blk_stack_limits(&q->limits, &b->limits, 0);
> -
> -		if (q->backing_dev_info->ra_pages !=
> -		    b->backing_dev_info->ra_pages) {
> -			drbd_info(device, "Adjusting my ra_pages to backing device's (%lu -> %lu)\n",
> -				 q->backing_dev_info->ra_pages,
> -				 b->backing_dev_info->ra_pages);
> -			q->backing_dev_info->ra_pages =
> -						b->backing_dev_info->ra_pages;
> -		}
> -	}
>  	fixup_discard_if_not_supported(q);
>  	fixup_write_zeroes(device, q);
>  }
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 48113005ed86ad..6bfa771673623e 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1427,9 +1427,6 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
>  	if (ret)
>  		return ret;
>  
> -	dc->disk.disk->queue->backing_dev_info->ra_pages =
> -		max(dc->disk.disk->queue->backing_dev_info->ra_pages,
> -		    q->backing_dev_info->ra_pages);
>  	blk_queue_io_opt(dc->disk.disk->queue,
>  		max(queue_io_opt(dc->disk.disk->queue), queue_io_opt(q)));
>  
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index f54a449f97aa79..aa2d7279176880 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -410,22 +410,6 @@ static int raid0_run(struct mddev *mddev)
>  		 mdname(mddev),
>  		 (unsigned long long)mddev->array_sectors);
>  
> -	if (mddev->queue) {
> -		/* calculate the max read-ahead size.
> -		 * For read-ahead of large files to be effective, we need to
> -		 * readahead at least twice a whole stripe. i.e. number of devices
> -		 * multiplied by chunk size times 2.
> -		 * If an individual device has an ra_pages greater than the
> -		 * chunk size, then we will not drive that device as hard as it
> -		 * wants.  We consider this a configuration error: a larger
> -		 * chunksize should be used in that case.
> -		 */
> -		int stripe = mddev->raid_disks *
> -			(mddev->chunk_sectors << 9) / PAGE_SIZE;
> -		if (mddev->queue->backing_dev_info->ra_pages < 2* stripe)
> -			mddev->queue->backing_dev_info->ra_pages = 2* stripe;
> -	}
> -
>  	dump_zones(mddev);
>  
>  	ret = md_integrity_register(mddev);
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 9956a04ac13bd6..5d1bdee313ec33 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3873,19 +3873,6 @@ static int raid10_run(struct mddev *mddev)
>  	mddev->resync_max_sectors = size;
>  	set_bit(MD_FAILFAST_SUPPORTED, &mddev->flags);
>  
> -	if (mddev->queue) {
> -		int stripe = conf->geo.raid_disks *
> -			((mddev->chunk_sectors << 9) / PAGE_SIZE);
> -
> -		/* Calculate max read-ahead size.
> -		 * We need to readahead at least twice a whole stripe....
> -		 * maybe...
> -		 */
> -		stripe /= conf->geo.near_copies;
> -		if (mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
> -			mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
> -	}
> -
>  	if (md_integrity_register(mddev))
>  		goto out_free_conf;
>  
> @@ -4723,17 +4710,8 @@ static void end_reshape(struct r10conf *conf)
>  	conf->reshape_safe = MaxSector;
>  	spin_unlock_irq(&conf->device_lock);
>  
> -	/* read-ahead size must cover two whole stripes, which is
> -	 * 2 * (datadisks) * chunksize where 'n' is the number of raid devices
> -	 */
> -	if (conf->mddev->queue) {
> -		int stripe = conf->geo.raid_disks *
> -			((conf->mddev->chunk_sectors << 9) / PAGE_SIZE);
> -		stripe /= conf->geo.near_copies;
> -		if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
> -			conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
> +	if (conf->mddev->queue)
>  		raid10_set_io_opt(conf);
> -	}
>  	conf->fullsync = 0;
>  }
>  
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 9a7d1250894ef1..7ace1f76b14736 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7522,8 +7522,6 @@ static int raid5_run(struct mddev *mddev)
>  		int data_disks = conf->previous_raid_disks - conf->max_degraded;
>  		int stripe = data_disks *
>  			((mddev->chunk_sectors << 9) / PAGE_SIZE);
> -		if (mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
> -			mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
>  
>  		chunk_size = mddev->chunk_sectors << 9;
>  		blk_queue_io_min(mddev->queue, chunk_size);
> @@ -8111,17 +8109,8 @@ static void end_reshape(struct r5conf *conf)
>  		spin_unlock_irq(&conf->device_lock);
>  		wake_up(&conf->wait_for_overlap);
>  
> -		/* read-ahead size must cover two whole stripes, which is
> -		 * 2 * (datadisks) * chunksize where 'n' is the number of raid devices
> -		 */
> -		if (conf->mddev->queue) {
> -			int data_disks = conf->raid_disks - conf->max_degraded;
> -			int stripe = data_disks * ((conf->chunk_sectors << 9)
> -						   / PAGE_SIZE);
> -			if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
> -				conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
> +		if (conf->mddev->queue)
>  			raid5_set_io_opt(conf);
> -		}
>  	}
>  }
>  
> 

