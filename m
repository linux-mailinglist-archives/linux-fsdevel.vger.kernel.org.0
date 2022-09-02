Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDD5AA53D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 03:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiIBBqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 21:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiIBBq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:46:27 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ADD4D247
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662083184; x=1693619184;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s/pEcQWbpoeTLCyab6Ap6TariBRem4AckSzVvuEamAk=;
  b=avnCk0k8FZuokDokwISANmcX+BIdWqiQAYdZkAFuhHw7a0WIHerMYI+Y
   y3yRO8YhztsZOMrvDiZFHxzi6a/3H1qzWbIv3C+rqoYkb2Pxd9caFXJet
   Aota10mpbT1E1iJLompNHci+0869cnbDyi4Z3f3HAxjDhm55QST6HPzOe
   QVBkhxkoWOHDrIzN/rk6ULiy1At9pcFs8ZvCEDUBDGjT4INpfwJsYybgp
   oxcv5ByiKX3fGj74HNtAcdtYIE54mz3O45kx7XF+ld2JNmgVJoP1IkCqz
   uLlLUfzYQD/koFBbel79EZIyc+iwL+Tus1RmrpqOXNCuReMMCksnwI910
   g==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="210774016"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 09:46:21 +0800
IronPort-SDR: mN1BhnS1GAQtTmsY34gAWbPwwK0hVTBJzzU/Xh5FFHKn15bluF/1QsevODAFlDeWSl+rPiMNFJ
 mCu5I9G8ITeem1Q6cqHGE1nVhCmVdUiBxlRy3S93CiS4fDy6hn4Ge5MbJ3K4Kc5anuo9n9EAdl
 tCV3xD0YXhXrkFzbKPEPJSboJwuPi4+rjz5O1e2hBFdcRgOYQeB3amivlaZEZPirMy5vn/zMUZ
 HA4aDvL7oJJPeGdsrksWBnla+yWeJn5Zwv8adgVTGyyHz/PTBm2bC6vWRYgxtl7qMeW5k3BwvF
 yuTIGiSMxsf7rArzQLHpK0VV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 18:01:26 -0700
IronPort-SDR: 7JwmsFSwuTbJN0rqA4McWi2R7KsnsK6OIaHhC9iCW25f0qmKFdvE5FipuklJvFFVykIKAhELO2
 BDi+G3kqU/08Im6wcrv0NhietoD80StoM/AfgFV6L4XMi9AC+Bn3EfTWI1+Vk4B30Op8EoOzvQ
 tgfJs6Kk0kZFQRO9TxJlsJjD2URqkP9N2580P9y4VRpKgxrdcFWepRHemkXNB1WXmfXKVGqBXS
 o6JMKB5EF7Uprg6tOm6IPamMRWj3SKZG1yJ/XQdEsT/eQtwPh/1MUh7QtPRp5l/wgm3Bo47t9p
 jXQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 18:46:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJgk41xghz1RWxq
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 18:46:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662083177; x=1664675178; bh=s/pEcQWbpoeTLCyab6Ap6TariBRem4AckSz
        VvuEamAk=; b=kOglcIa+7dwAE5H3yUvarGWQ00g9ztXwR8fPF7GFY1AN9B6oTg9
        rQ9OOwLEMJkF5nggQvCkmCpFFWCVIkY7LFqCV3PADY5GSc0UKfUKZn8zCCtuuPmO
        keBCpabauY+7+C9yFY9rz4oM/cNKtXx9D6C9SPVLhcILjXsCIJuNnhIzDmCsBWG5
        M3gDVBaluWgCs3Gy2wLfSo+Mg1poMc6wPQeoJBJaolzJw6ueJLb2N6aDpHm35k0p
        RGco+mVKeLGZuSMa7lVd0oWVc9gsqOcA3LAwyuY1vYynnynuEesKbnJI7tDee1JL
        p22dqh4GoDO8dJBJjwMPBzAccoIghUxCKQA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tfqihTPDuC-t for <linux-fsdevel@vger.kernel.org>;
        Thu,  1 Sep 2022 18:46:17 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJgjy1pR9z1RvLy;
        Thu,  1 Sep 2022 18:46:14 -0700 (PDT)
Message-ID: <d02a11c0-ea7c-8921-8993-5c9d3645c7ad@opensource.wdc.com>
Date:   Fri, 2 Sep 2022 10:46:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-17-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220901074216.1849941-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/22 16:42, Christoph Hellwig wrote:
> The current btrfs zoned device support is a little cumbersome in the data
> I/O path as it requires the callers to not support more I/O than the
> supported ZONE_APPEND size by the underlying device.  This leads to a lot

Did you mean: "...as it requires the callers to not issue I/O larger than
the supported ZONE_APPEND size for the underlying device." ?
I think you do mean that :)

> of extra accounting.  Instead change btrfs_submit_bio so that it can take
> write bios of arbitrary size and form from the upper layers, and just
> split them internally to the ZONE_APPEND queue limits.  Then remove all
> the upper layer warts catering to limited write sized on zoned devices,
> including the extra refcount in the compressed_bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/compression.c | 112 ++++++++---------------------------------
>  fs/btrfs/compression.h |   3 --
>  fs/btrfs/extent_io.c   |  74 ++++++---------------------
>  fs/btrfs/inode.c       |   4 --
>  fs/btrfs/volumes.c     |  40 +++++++++------
>  fs/btrfs/zoned.c       |  20 --------
>  fs/btrfs/zoned.h       |   9 ----
>  7 files changed, 62 insertions(+), 200 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 5e8b75b030ace..f89cac08dc4a4 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -255,57 +255,14 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
>  static void end_compressed_bio_write(struct btrfs_bio *bbio)
>  {
>  	struct compressed_bio *cb = bbio->private;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
>  
> -	if (bbio->bio.bi_status)
> -		cb->status = bbio->bio.bi_status;
> -
> -	if (refcount_dec_and_test(&cb->pending_ios)) {
> -		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
> +	cb->status = bbio->bio.bi_status;
> +	queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
>  
> -		queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
> -	}
>  	bio_put(&bbio->bio);
>  }
>  
> -/*
> - * Allocate a compressed_bio, which will be used to read/write on-disk
> - * (aka, compressed) * data.
> - *
> - * @cb:                 The compressed_bio structure, which records all the needed
> - *                      information to bind the compressed data to the uncompressed
> - *                      page cache.
> - * @disk_byten:         The logical bytenr where the compressed data will be read
> - *                      from or written to.
> - * @endio_func:         The endio function to call after the IO for compressed data
> - *                      is finished.
> - */
> -static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
> -					blk_opf_t opf,
> -					btrfs_bio_end_io_t endio_func)
> -{
> -	struct bio *bio;
> -
> -	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, cb->inode, endio_func, cb);
> -	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
> -
> -	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> -		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
> -		struct extent_map *em;
> -
> -		em = btrfs_get_chunk_map(fs_info, disk_bytenr,
> -					 fs_info->sectorsize);
> -		if (IS_ERR(em)) {
> -			bio_put(bio);
> -			return ERR_CAST(em);
> -		}
> -
> -		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);
> -		free_extent_map(em);
> -	}
> -	refcount_inc(&cb->pending_ios);
> -	return bio;
> -}
> -
>  /*
>   * worker function to build and submit bios for previously compressed pages.
>   * The corresponding pages in the inode should be marked for writeback
> @@ -329,16 +286,12 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  	struct compressed_bio *cb;
>  	u64 cur_disk_bytenr = disk_start;
>  	blk_status_t ret = BLK_STS_OK;
> -	const bool use_append = btrfs_use_zone_append(inode, disk_start);
> -	const enum req_op bio_op = REQ_BTRFS_ONE_ORDERED |
> -		(use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE);
>  
>  	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>  	       IS_ALIGNED(len, fs_info->sectorsize));
>  	cb = kmalloc(sizeof(struct compressed_bio), GFP_NOFS);
>  	if (!cb)
>  		return BLK_STS_RESOURCE;
> -	refcount_set(&cb->pending_ios, 1);
>  	cb->status = BLK_STS_OK;
>  	cb->inode = &inode->vfs_inode;
>  	cb->start = start;
> @@ -349,8 +302,15 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
>  	cb->nr_pages = nr_pages;
>  
> -	if (blkcg_css)
> +	if (blkcg_css) {
>  		kthread_associate_blkcg(blkcg_css);
> +		write_flags |= REQ_CGROUP_PUNT;
> +	}
> +
> +	write_flags |= REQ_BTRFS_ONE_ORDERED;
> +	bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_WRITE | write_flags,
> +			      cb->inode, end_compressed_bio_write, cb);
> +	bio->bi_iter.bi_sector = cur_disk_bytenr >> SECTOR_SHIFT;
>  
>  	while (cur_disk_bytenr < disk_start + compressed_len) {
>  		u64 offset = cur_disk_bytenr - disk_start;
> @@ -358,19 +318,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  		unsigned int real_size;
>  		unsigned int added;
>  		struct page *page = compressed_pages[index];
> -		bool submit = false;
> -
> -		/* Allocate new bio if submitted or not yet allocated */
> -		if (!bio) {
> -			bio = alloc_compressed_bio(cb, cur_disk_bytenr,
> -				bio_op | write_flags, end_compressed_bio_write);
> -			if (IS_ERR(bio)) {
> -				ret = errno_to_blk_status(PTR_ERR(bio));
> -				break;
> -			}
> -			if (blkcg_css)
> -				bio->bi_opf |= REQ_CGROUP_PUNT;
> -		}
> +
>  		/*
>  		 * We have various limits on the real read size:
>  		 * - page boundary
> @@ -380,36 +328,21 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  		real_size = min_t(u64, real_size, compressed_len - offset);
>  		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
>  
> -		if (use_append)
> -			added = bio_add_zone_append_page(bio, page, real_size,
> -					offset_in_page(offset));
> -		else
> -			added = bio_add_page(bio, page, real_size,
> -					offset_in_page(offset));
> -		/* Reached zoned boundary */
> -		if (added == 0)
> -			submit = true;
> -
> +		added = bio_add_page(bio, page, real_size, offset_in_page(offset));
> +		/*
> +		 * Maximum compressed extent is smaller than bio size limit,
> +		 * thus bio_add_page() should always success.
> +		 */
> +		ASSERT(added == real_size);
>  		cur_disk_bytenr += added;
> -
> -		/* Finished the range */
> -		if (cur_disk_bytenr == disk_start + compressed_len)
> -			submit = true;
> -
> -		if (submit) {
> -			ASSERT(bio->bi_iter.bi_size);
> -			btrfs_bio(bio)->file_offset = start;
> -			btrfs_submit_bio(fs_info, bio, 0);
> -			bio = NULL;
> -		}
> -		cond_resched();
>  	}
>  
> +	/* Finished the range */
> +	ASSERT(bio->bi_iter.bi_size);
> +	btrfs_bio(bio)->file_offset = start;
> +	btrfs_submit_bio(fs_info, bio, 0);
>  	if (blkcg_css)
>  		kthread_associate_blkcg(NULL);
> -
> -	if (refcount_dec_and_test(&cb->pending_ios))
> -		finish_compressed_bio_write(cb);
>  	return ret;
>  }
>  
> @@ -613,7 +546,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		goto out;
>  	}
>  
> -	refcount_set(&cb->pending_ios, 1);
>  	cb->status = BLK_STS_OK;
>  	cb->inode = inode;
>  
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 1aa02903de697..25876f7a26949 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -30,9 +30,6 @@ static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
>  #define	BTRFS_ZLIB_DEFAULT_LEVEL		3
>  
>  struct compressed_bio {
> -	/* Number of outstanding bios */
> -	refcount_t pending_ios;
> -
>  	/* Number of compressed pages in the array */
>  	unsigned int nr_pages;
>  
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 33e80f8dd0b1b..40dadc46e00d8 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2597,7 +2597,6 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
>  	u32 real_size;
>  	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
>  	bool contig = false;
> -	int ret;
>  
>  	ASSERT(bio);
>  	/* The limit should be calculated when bio_ctrl->bio is allocated */
> @@ -2646,12 +2645,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
>  	if (real_size == 0)
>  		return 0;
>  
> -	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> -		ret = bio_add_zone_append_page(bio, page, real_size, pg_offset);
> -	else
> -		ret = bio_add_page(bio, page, real_size, pg_offset);
> -
> -	return ret;
> +	return bio_add_page(bio, page, real_size, pg_offset);
>  }
>  
>  static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
> @@ -2666,7 +2660,7 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>  	 * to them.
>  	 */
>  	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
> -	    bio_op(bio_ctrl->bio) == REQ_OP_ZONE_APPEND) {
> +	    btrfs_use_zone_append(inode, logical)) {
>  		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
>  		if (ordered) {
>  			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
> @@ -2680,17 +2674,15 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>  	bio_ctrl->len_to_oe_boundary = U32_MAX;
>  }
>  
> -static int alloc_new_bio(struct btrfs_inode *inode,
> -			 struct btrfs_bio_ctrl *bio_ctrl,
> -			 struct writeback_control *wbc,
> -			 blk_opf_t opf,
> -			 btrfs_bio_end_io_t end_io_func,
> -			 u64 disk_bytenr, u32 offset, u64 file_offset,
> -			 enum btrfs_compression_type compress_type)
> +static void alloc_new_bio(struct btrfs_inode *inode,
> +			  struct btrfs_bio_ctrl *bio_ctrl,
> +			  struct writeback_control *wbc, blk_opf_t opf,
> +			  btrfs_bio_end_io_t end_io_func,
> +			  u64 disk_bytenr, u32 offset, u64 file_offset,
> +			  enum btrfs_compression_type compress_type)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	struct bio *bio;
> -	int ret;
>  
>  	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, &inode->vfs_inode, end_io_func,
>  			      NULL);
> @@ -2708,40 +2700,14 @@ static int alloc_new_bio(struct btrfs_inode *inode,
>  
>  	if (wbc) {
>  		/*
> -		 * For Zone append we need the correct block_device that we are
> -		 * going to write to set in the bio to be able to respect the
> -		 * hardware limitation.  Look it up here:
> +		 * Pick the last added device to support cgroup writeback.  For
> +		 * multi-device file systems this means blk-cgroup policies have
> +		 * to always be set on the last added/replaced device.
> +		 * This is a bit odd but has been like that for a long time.
>  		 */
> -		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> -			struct btrfs_device *dev;
> -
> -			dev = btrfs_zoned_get_device(fs_info, disk_bytenr,
> -						     fs_info->sectorsize);
> -			if (IS_ERR(dev)) {
> -				ret = PTR_ERR(dev);
> -				goto error;
> -			}
> -
> -			bio_set_dev(bio, dev->bdev);
> -		} else {
> -			/*
> -			 * Otherwise pick the last added device to support
> -			 * cgroup writeback.  For multi-device file systems this
> -			 * means blk-cgroup policies have to always be set on the
> -			 * last added/replaced device.  This is a bit odd but has
> -			 * been like that for a long time.
> -			 */
> -			bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
> -		}
> +		bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
>  		wbc_init_bio(wbc, bio);
> -	} else {
> -		ASSERT(bio_op(bio) != REQ_OP_ZONE_APPEND);
>  	}
> -	return 0;
> -error:
> -	bio_ctrl->bio = NULL;
> -	btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
> -	return ret;
>  }
>  
>  /*
> @@ -2767,7 +2733,6 @@ static int submit_extent_page(blk_opf_t opf,
>  			      enum btrfs_compression_type compress_type,
>  			      bool force_bio_submit)
>  {
> -	int ret = 0;
>  	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
>  	unsigned int cur = pg_offset;
>  
> @@ -2784,12 +2749,9 @@ static int submit_extent_page(blk_opf_t opf,
>  
>  		/* Allocate new bio if needed */
>  		if (!bio_ctrl->bio) {
> -			ret = alloc_new_bio(inode, bio_ctrl, wbc, opf,
> -					    end_io_func, disk_bytenr, offset,
> -					    page_offset(page) + cur,
> -					    compress_type);
> -			if (ret < 0)
> -				return ret;
> +			alloc_new_bio(inode, bio_ctrl, wbc, opf, end_io_func,
> +				      disk_bytenr, offset,
> +				      page_offset(page) + cur, compress_type);
>  		}
>  		/*
>  		 * We must go through btrfs_bio_add_page() to ensure each
> @@ -3354,10 +3316,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  		 * find_next_dirty_byte() are all exclusive
>  		 */
>  		iosize = min(min(em_end, end + 1), dirty_range_end) - cur;
> -
> -		if (btrfs_use_zone_append(inode, em->block_start))
> -			op = REQ_OP_ZONE_APPEND;
> -
>  		free_extent_map(em);
>  		em = NULL;
>  
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9c562d36e4570..1a0bf381f2437 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7727,10 +7727,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>  	iomap->offset = start;
>  	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
>  	iomap->length = len;
> -
> -	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
> -		iomap->flags |= IOMAP_F_ZONE_APPEND;
> -
>  	free_extent_map(em);
>  
>  	return 0;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e497b63238189..0d828b58cc9c3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6632,13 +6632,22 @@ struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
>  	return bio;
>  }
>  
> -static struct bio *btrfs_split_bio(struct bio *orig, u64 map_length)
> +static struct bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
> +				   struct bio *orig, u64 map_length,
> +				   bool use_append)
>  {
>  	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
>  	struct bio *bio;
>  
> -	bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
> -			&btrfs_clone_bioset);
> +	if (use_append) {
> +		unsigned int nr_segs;
> +
> +		bio = bio_split_rw(orig, &fs_info->limits, &nr_segs,
> +				   &btrfs_clone_bioset, map_length);
> +	} else {
> +		bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
> +				&btrfs_clone_bioset);
> +	}
>  	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
>  
>  	btrfs_bio(bio)->file_offset = orig_bbio->file_offset;
> @@ -6970,16 +6979,10 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
>  	 */
>  	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
>  		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +		u64 zone_start = round_down(physical, dev->fs_info->zone_size);
>  
> -		if (btrfs_dev_is_sequential(dev, physical)) {
> -			u64 zone_start = round_down(physical,
> -						    dev->fs_info->zone_size);
> -
> -			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
> -		} else {
> -			bio->bi_opf &= ~REQ_OP_ZONE_APPEND;
> -			bio->bi_opf |= REQ_OP_WRITE;
> -		}
> +		ASSERT(btrfs_dev_is_sequential(dev, physical));
> +		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
>  	}
>  	btrfs_debug_in_rcu(dev->fs_info,
>  	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
> @@ -7179,9 +7182,11 @@ static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bio *bio,
>  			       int mirror_num)
>  {
>  	struct btrfs_bio *bbio = btrfs_bio(bio);
> +	struct btrfs_inode *bi = BTRFS_I(bbio->inode);
>  	u64 logical = bio->bi_iter.bi_sector << 9;
>  	u64 length = bio->bi_iter.bi_size;
>  	u64 map_length = length;
> +	bool use_append = btrfs_use_zone_append(bi, logical);
>  	struct btrfs_io_context *bioc = NULL;
>  	struct btrfs_io_stripe smap;
>  	int ret;
> @@ -7193,8 +7198,11 @@ static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bio *bio,
>  		goto fail;
>  
>  	map_length = min(map_length, length);
> +	if (use_append)
> +		map_length = min(map_length, fs_info->max_zone_append_size);
> +
>  	if (map_length < length) {
> -		bio = btrfs_split_bio(bio, map_length);
> +		bio = btrfs_split_bio(fs_info, bio, map_length, use_append);
>  		bbio = btrfs_bio(bio);
>  	}
>  
> @@ -7210,9 +7218,9 @@ static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bio *bio,
>  	}
>  
>  	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
> -		struct btrfs_inode *bi = BTRFS_I(bbio->inode);
> -
> -		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		if (use_append) {
> +			bio->bi_opf &= ~REQ_OP_WRITE;
> +			bio->bi_opf |= REQ_OP_ZONE_APPEND;
>  			ret = btrfs_extract_ordered_extent(btrfs_bio(bio));
>  			if (ret)
>  				goto fail_put_bio;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 6e04fbbd76b92..988e9fc5a6b7b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1818,26 +1818,6 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
>  	return btrfs_zoned_issue_zeroout(tgt_dev, physical_pos, length);
>  }
>  
> -struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
> -					    u64 logical, u64 length)
> -{
> -	struct btrfs_device *device;
> -	struct extent_map *em;
> -	struct map_lookup *map;
> -
> -	em = btrfs_get_chunk_map(fs_info, logical, length);
> -	if (IS_ERR(em))
> -		return ERR_CAST(em);
> -
> -	map = em->map_lookup;
> -	/* We only support single profile for now */
> -	device = map->stripes[0].dev;
> -
> -	free_extent_map(em);
> -
> -	return device;
> -}
> -
>  /**
>   * Activate block group and underlying device zones
>   *
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 0f22b22fe359f..74153ab52169f 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -64,8 +64,6 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
>  int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
>  int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
>  				  u64 physical_start, u64 physical_pos);
> -struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
> -					    u64 logical, u64 length);
>  bool btrfs_zone_activate(struct btrfs_block_group *block_group);
>  int btrfs_zone_finish(struct btrfs_block_group *block_group);
>  bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags);
> @@ -209,13 +207,6 @@ static inline int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev,
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline struct btrfs_device *btrfs_zoned_get_device(
> -						  struct btrfs_fs_info *fs_info,
> -						  u64 logical, u64 length)
> -{
> -	return ERR_PTR(-EOPNOTSUPP);
> -}
> -
>  static inline bool btrfs_zone_activate(struct btrfs_block_group *block_group)
>  {
>  	return true;

-- 
Damien Le Moal
Western Digital Research

