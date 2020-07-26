Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E975B22E224
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGZTGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGZTGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:06:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F6C0619D2;
        Sun, 26 Jul 2020 12:06:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so737308pjb.1;
        Sun, 26 Jul 2020 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhvPLwCPXjMqFU2x4gEnxP4JjTqrO6GiJqIFdd+1yaY=;
        b=W6kZST4BhAg8j6aAzIOCVIsrh6bIit/0aLvxBm75a4a194r0fukEv3cBdzfg05ZQ+4
         j1OcMjy52PUg5c4JKaqkPD+rZEHfxs4gV6Cph35S/Vp9IoNA2IXusr5vhlQDRRl0mxxH
         YKCMl3NIkqx2xS40Phzh9Ri23iauKkDzsvRDB1ibmTHzFYk8DSAsKUgPhvyZHYdgH/Wn
         3XjC1g4pAaFV4Z1JIz3eqPo4YVgGSUvC64+QgKsm1wQQ10QN/4ZeA9wOMLsCuphEH+t1
         alc2DXv1K5/JMNntu53Xw/iqRJ3pyzdoBdkk2yXAvGBAM43xCJ3H1SiEIyO0ffrlqSfR
         KCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qhvPLwCPXjMqFU2x4gEnxP4JjTqrO6GiJqIFdd+1yaY=;
        b=r4x6SI6Jv80lXDXQFIvZOBF/sBuzaCDrm92qAHIGroQ9D5bNfh2JTsZv3nCemqvGTL
         p4HrX8h+/ZtexVITGmnxiU9m6fgYRQFV6GLQHnueVyR6dkGqDOBO0PZjKJU+vsvqmx+C
         +vtEt41ipXsTQAdbVAs2gUobuoek+m/NXSn6f2a7Xsx8PFOSdsOC+RSoRDE7PeYKcYdH
         coIkiApCXO3rmEHNShAtfyyfJceXTcznZ5UEtrJPsA6wHWj+3IgojayGUiOM6UDFkZhT
         GS23DUHw8kKL29nLvH1HxhZb70Y9TbWBqt1PEOiVpW23U3vI8owEHxAxlvpfl/0dSfRl
         ZbOg==
X-Gm-Message-State: AOAM530XBumrW7JH2QBG7Nz3Z3yDt0nhIMZSjEoAr/hMn05CaS3FkxAV
        D5DZAlIcuTP1gRVVPYIMwD0=
X-Google-Smtp-Source: ABdhPJzRH4Cwo8GKdnDVU07rflKqs4ddrzgi88E3WWwZnPBfqLP6xNZSSBxRrE9jOOyxKIw1tGTGqg==
X-Received: by 2002:a17:902:6a82:: with SMTP id n2mr16617932plk.27.1595790403131;
        Sun, 26 Jul 2020 12:06:43 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id o11sm12418242pfp.88.2020.07.26.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 12:06:41 -0700 (PDT)
Date:   Sun, 26 Jul 2020 12:06:39 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 10/14] bdi: remove BDI_CAP_SYNCHRONOUS_IO
Message-ID: <20200726190639.GA560221@google.com>
References: <20200726150333.305527-1-hch@lst.de>
 <20200726150333.305527-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726150333.305527-11-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 05:03:29PM +0200, Christoph Hellwig wrote:
> BDI_CAP_SYNCHRONOUS_IO is only checked in the swap code, and used to
> decided if ->rw_page can be used on a block device.  Just check up for
> the method instead.  The only complication is that zram needs a second
> set of block_device_operations as it can switch between modes that
> actually support ->rw_page and those who don't.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/brd.c           |  1 -
>  drivers/block/zram/zram_drv.c | 19 +++++++++++++------
>  drivers/nvdimm/btt.c          |  2 --
>  drivers/nvdimm/pmem.c         |  1 -
>  include/linux/backing-dev.h   |  9 ---------
>  mm/swapfile.c                 |  2 +-
>  6 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 2723a70eb85593..cc49a921339f77 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -403,7 +403,6 @@ static struct brd_device *brd_alloc(int i)
>  	disk->flags		= GENHD_FL_EXT_DEVT;
>  	sprintf(disk->disk_name, "ram%d", i);
>  	set_capacity(disk, rd_size * 2);
> -	brd->brd_queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
>  
>  	/* Tell the block layer that this is not a rotational device */
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, brd->brd_queue);
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 9100ac36670afc..d73ddf018fa65f 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -52,6 +52,9 @@ static unsigned int num_devices = 1;
>   */
>  static size_t huge_class_size;
>  
> +static const struct block_device_operations zram_devops;
> +static const struct block_device_operations zram_wb_devops;
> +
>  static void zram_free_page(struct zram *zram, size_t index);
>  static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
>  				u32 index, int offset, struct bio *bio);
> @@ -408,8 +411,7 @@ static void reset_bdev(struct zram *zram)
>  	zram->backing_dev = NULL;
>  	zram->old_block_size = 0;
>  	zram->bdev = NULL;
> -	zram->disk->queue->backing_dev_info->capabilities |=
> -				BDI_CAP_SYNCHRONOUS_IO;
> +	zram->disk->fops = &zram_devops;
>  	kvfree(zram->bitmap);
>  	zram->bitmap = NULL;
>  }
> @@ -528,8 +530,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  	 * freely but in fact, IO is going on so finally could cause
>  	 * use-after-free when the IO is really done.
>  	 */
> -	zram->disk->queue->backing_dev_info->capabilities &=
> -			~BDI_CAP_SYNCHRONOUS_IO;
> +	zram->disk->fops = &zram_wb_devops;
>  	up_write(&zram->init_lock);

For zram, regardless of BDI_CAP_SYNCHRONOUS_IO, it have used rw_page
every time on read/write path. This one with next patch will make zram
use bio instead of rw_page when it's declared !BDI_CAP_SYNCHRONOUS_IO,
which introduce regression for performance.

In the swap code, BDI_CAP_SYNCHRONOUS_IO is used to avoid swap cache
when the page was private. bdev_read_page is not designed to rely on
synchronous operation. That's why this patch breaks the old behavior.

>  
>  	pr_info("setup backing device %s\n", file_name);
> @@ -1819,6 +1820,13 @@ static const struct block_device_operations zram_devops = {
>  	.owner = THIS_MODULE
>  };
>  
> +static const struct block_device_operations zram_wb_devops = {
> +	.open = zram_open,
> +	.submit_bio = zram_submit_bio,
> +	.swap_slot_free_notify = zram_slot_free_notify,
> +	.owner = THIS_MODULE
> +};
> +
>  static DEVICE_ATTR_WO(compact);
>  static DEVICE_ATTR_RW(disksize);
>  static DEVICE_ATTR_RO(initstate);
> @@ -1946,8 +1954,7 @@ static int zram_add(void)
>  	if (ZRAM_LOGICAL_BLOCK_SIZE == PAGE_SIZE)
>  		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
>  
> -	zram->disk->queue->backing_dev_info->capabilities |=
> -			(BDI_CAP_STABLE_WRITES | BDI_CAP_SYNCHRONOUS_IO);
> +	zram->disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
>  	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
>  
>  	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 412d21d8f64351..b4184dc9b41eb4 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1540,8 +1540,6 @@ static int btt_blk_init(struct btt *btt)
>  	btt->btt_disk->private_data = btt;
>  	btt->btt_disk->queue = btt->btt_queue;
>  	btt->btt_disk->flags = GENHD_FL_EXT_DEVT;
> -	btt->btt_disk->queue->backing_dev_info->capabilities |=
> -			BDI_CAP_SYNCHRONOUS_IO;
>  
>  	blk_queue_logical_block_size(btt->btt_queue, btt->sector_size);
>  	blk_queue_max_hw_sectors(btt->btt_queue, UINT_MAX);
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 94790e6e0e4ce1..436b83fb24ad61 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -478,7 +478,6 @@ static int pmem_attach_disk(struct device *dev,
>  	disk->queue		= q;
>  	disk->flags		= GENHD_FL_EXT_DEVT;
>  	disk->private_data	= pmem;
> -	disk->queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
>  	nvdimm_namespace_disk_name(ndns, disk->disk_name);
>  	set_capacity(disk, (pmem->size - pmem->pfn_pad - pmem->data_offset)
>  			/ 512);
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 52583b6f2ea05d..860ea33571bce5 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -122,9 +122,6 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
>   * BDI_CAP_NO_WRITEBACK:   Don't write pages back
>   * BDI_CAP_NO_ACCT_WB:     Don't automatically account writeback pages
>   * BDI_CAP_STRICTLIMIT:    Keep number of dirty pages below bdi threshold.
> - *
> - * BDI_CAP_SYNCHRONOUS_IO: Device is so fast that asynchronous IO would be
> - *			   inefficient.
>   */
>  #define BDI_CAP_NO_ACCT_DIRTY	0x00000001
>  #define BDI_CAP_NO_WRITEBACK	0x00000002
> @@ -132,7 +129,6 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
>  #define BDI_CAP_STABLE_WRITES	0x00000008
>  #define BDI_CAP_STRICTLIMIT	0x00000010
>  #define BDI_CAP_CGROUP_WRITEBACK 0x00000020
> -#define BDI_CAP_SYNCHRONOUS_IO	0x00000040
>  
>  #define BDI_CAP_NO_ACCT_AND_WRITEBACK \
>  	(BDI_CAP_NO_WRITEBACK | BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_ACCT_WB)
> @@ -174,11 +170,6 @@ static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
>  long congestion_wait(int sync, long timeout);
>  long wait_iff_congested(int sync, long timeout);
>  
> -static inline bool bdi_cap_synchronous_io(struct backing_dev_info *bdi)
> -{
> -	return bdi->capabilities & BDI_CAP_SYNCHRONOUS_IO;
> -}
> -
>  static inline bool bdi_cap_stable_pages_required(struct backing_dev_info *bdi)
>  {
>  	return bdi->capabilities & BDI_CAP_STABLE_WRITES;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6c26916e95fd4a..18eac97b10e502 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3230,7 +3230,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	if (bdi_cap_stable_pages_required(inode_to_bdi(inode)))
>  		p->flags |= SWP_STABLE_WRITES;
>  
> -	if (bdi_cap_synchronous_io(inode_to_bdi(inode)))
> +	if (p->bdev && p->bdev->bd_disk->fops->rw_page)
>  		p->flags |= SWP_SYNCHRONOUS_IO;
>  
>  	if (p->bdev && blk_queue_nonrot(bdev_get_queue(p->bdev))) {
> -- 
> 2.27.0
> 
