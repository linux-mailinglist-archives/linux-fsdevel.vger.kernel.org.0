Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA74AD221
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 08:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbiBHHWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 02:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiBHHWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:22:35 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 23:22:34 PST
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B579C0401F1
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 23:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644304954; x=1675840954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g64yFGZnZtBlZZe3pHAgbpNwncCobKe+4KHoTihhnoo=;
  b=qM2pT2ztrco4jXTcfcgMkL+iwnVMJs6z6NAiD3J76tunZ2idQQPbbIsL
   ymjpViPj2P29dMtMSYTUa4G8Ap0uowbF7vAdzEwFF99tQSYYRLuBQkd3L
   HKBAz1pZLoSgLkPU3vvT99+JrZW2oG9UMYrMKKqLi+vMpKAFZxqYJ+4LV
   xf/OZ4a3DM7ovL4PUFnH8G8PV4C982HzXUXnlA04tU8Iy0r/89UBLu0SS
   39gCcpNEH2Xah+wvN6AMDMkrmYWl2vGaeyjh5XAEL8tfge+qmDLb1uzNc
   0zM9QU0/0bhDl9uUdCqzX6dl/UOSpuOQ4fKz6Gn+BrDlpuZabWe9VFAyu
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,352,1635177600"; 
   d="scan'208";a="304299409"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2022 15:21:30 +0800
IronPort-SDR: uudDHOMuekZBpOFvTwhui4fSr7nm/e0H+JSdZcCyKHsjnpcB+Nz2VD2871Dwd/XYA8lfNKa/Tc
 /un4GM5/iO2JFLNfxOQkm95M9KA62As52g+H56E95/gO7Lz18dwblOB2psvEwOADNXr21sPYea
 VO4MgdnQa7nUMmnBQKW+SW7ed/ykV3rL1OCrC9NuRoRMa4aGyleraJ4Dw+8icAZs3u9Kbpf/5Q
 X6IdTFzqX0gacu4EDaBrBZpDGFwUQa18U+DyY9rX03U3NiGgJ6zOUZJKS/kFwo+AF0GUaSAa4+
 hPUjuq28Ebo2oGRIVWgb57CF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:54:31 -0800
IronPort-SDR: U+UeXlqYTM+GIqv4SVw9IdJeeyYL2ic4+DWv+E/wLoR2pykzqDoJd+V6Nj8aXkJhmMMONpFPAj
 ryvjF5GBj9VgpoJp3f4dUq2MwttpowIT4ji5OvhDAZPSybIg7i6oewa0Nov2QYbcJxYzZVHetW
 0Xdg2VebV8Vl7Sk3NLXQ9L8nQDV+Lsw8YFNFQFHEkSwcpQmPMCGzks/8aGh1w8gAgc0Nxm/Toj
 Sa83O6HM0fvhTLNATO8+kWpSX1vYMp6O6gHFAp0w+SxNaB0qZidn4pki7kUUPLtfwtWw5q932y
 Esc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 23:21:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtDvt4YFJz1SVp1
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 23:21:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644304888; x=1646896889; bh=g64yFGZnZtBlZZe3pHAgbpNwncCobKe+4KH
        oTihhnoo=; b=Jmk3FSvN9MTej2lXj5KsM13/ush1bdJf0JQ/3Tzh6JRInwS7Qhg
        P6hGMUmE43eqaqnxT3y5Ed49uqFtzzeIJORGxcEqNhp8BtYSIH6Fq+pw+6kAj1vI
        GedIEIJDVEuFcR1i/gDOXKw7F8GPdWAUQCiTf9VfufZ7EAgOjoBJXsaHkJLnc6DY
        wSJppU8DZPqJ7XRhmoz/yjwMlbJ9eI4h80mmlfWzckWnTtuZYvT+j7y+ni0XWakY
        yK39K0Yg2RQB5/qrroElsr8caihQS0WUxZbYjWZYpMV7EuQRpjtoi654w/vZ6v7s
        X7v/C/LlEc4AeyO3ULtWfoV6h2uEoRCvn0w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bkv3rLA6O_mG for <linux-fsdevel@vger.kernel.org>;
        Mon,  7 Feb 2022 23:21:28 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtDvj1HkYz1Rwrw;
        Mon,  7 Feb 2022 23:21:20 -0800 (PST)
Message-ID: <2e976611-6ba1-f986-91ce-d7f59fe4dd47@opensource.wdc.com>
Date:   Tue, 8 Feb 2022 16:21:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 03/10] block: Add copy offload support infrastructure
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>, mpatocka@redhat.com
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        osandov@fb.com, djwong@kernel.org, josef@toxicpanda.com,
        clm@fb.com, dsterba@suse.com, tytso@mit.edu, jack@suse.com,
        joshi.k@samsung.com, arnav.dawn@samsung.com,
        SelvaKumar S <selvakuma.s1@samsung.com>
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
 <20220207141348.4235-1-nj.shetty@samsung.com>
 <CGME20220207141918epcas5p4f9badc0c3f3f0913f091c850d2d3bd81@epcas5p4.samsung.com>
 <20220207141348.4235-4-nj.shetty@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220207141348.4235-4-nj.shetty@samsung.com>
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

On 2/7/22 23:13, Nitesh Shetty wrote:
> Introduce blkdev_issue_copy which supports source and destination bdevs,
> and a array of (source, destination and copy length) tuples.

s/a/an

> Introduce REQ_COP copy offload operation flag. Create a read-write

REQ_COPY ?

> bio pair with a token as payload and submitted to the device in order.
> the read request populates token with source specific information which
> is then passed with write request.
> Ths design is courtsey Mikulas Patocka<mpatocka@>'s token based copy

s/Ths design is courtsey/This design is courtesy of

> 
> Larger copy operation may be divided if necessary by looking at device
> limits.

may or will ?
by looking at -> depending on the ?

> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>  block/blk-lib.c           | 216 ++++++++++++++++++++++++++++++++++++++
>  block/blk-settings.c      |   2 +
>  block/blk.h               |   2 +
>  include/linux/blk_types.h |  20 ++++
>  include/linux/blkdev.h    |   3 +
>  include/uapi/linux/fs.h   |  14 +++
>  6 files changed, 257 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 1b8ced45e4e5..3ae2c27b566e 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -135,6 +135,222 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  }
>  EXPORT_SYMBOL(blkdev_issue_discard);
>  
> +/*
> + * Wait on and process all in-flight BIOs.  This must only be called once
> + * all bios have been issued so that the refcount can only decrease.
> + * This just waits for all bios to make it through bio_copy_end_io. IO
> + * errors are propagated through cio->io_error.
> + */
> +static int cio_await_completion(struct cio *cio)
> +{
> +	int ret = 0;
> +
> +	while (atomic_read(&cio->refcount)) {
> +		cio->waiter = current;
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +		blk_io_schedule();
> +		/* wake up sets us TASK_RUNNING */
> +		cio->waiter = NULL;
> +		ret = cio->io_err;

Why is this in the loop ?

> +	}
> +	kvfree(cio);
> +
> +	return ret;
> +}
> +
> +static void bio_copy_end_io(struct bio *bio)
> +{
> +	struct copy_ctx *ctx = bio->bi_private;
> +	struct cio *cio = ctx->cio;
> +	sector_t clen;
> +	int ri = ctx->range_idx;
> +
> +	if (bio->bi_status) {
> +		cio->io_err = bio->bi_status;
> +		clen = (bio->bi_iter.bi_sector - ctx->start_sec) << SECTOR_SHIFT;
> +		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
> +	}
> +	__free_page(bio->bi_io_vec[0].bv_page);
> +	kfree(ctx);
> +	bio_put(bio);
> +
> +	if (atomic_dec_and_test(&cio->refcount) && cio->waiter)
> +		wake_up_process(cio->waiter);

This looks racy: the cio->waiter test and wakeup are not atomic.

> +}
> +
> +/*
> + * blk_copy_offload	- Use device's native copy offload feature
> + * Go through user provide payload, prepare new payload based on device's copy offload limits.
> + */
> +int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
> +		struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
> +{
> +	struct request_queue *sq = bdev_get_queue(src_bdev);
> +	struct request_queue *dq = bdev_get_queue(dst_bdev);
> +	struct bio *read_bio, *write_bio;
> +	struct copy_ctx *ctx;
> +	struct cio *cio;
> +	struct page *token;
> +	sector_t src_blk, copy_len, dst_blk;
> +	sector_t remaining, max_copy_len = LONG_MAX;
> +	int ri = 0, ret = 0;
> +
> +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> +	if (!cio)
> +		return -ENOMEM;
> +	atomic_set(&cio->refcount, 0);
> +	cio->rlist = rlist;
> +
> +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_sectors,
> +			(sector_t)dq->limits.max_copy_sectors);

sq->limits.max_copy_sectors is already by definition smaller than
LONG_MAX, so there is no need for the min3 here.

> +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
> +			(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;> +
> +	for (ri = 0; ri < nr_srcs; ri++) {
> +		cio->rlist[ri].comp_len = rlist[ri].len;
> +		for (remaining = rlist[ri].len, src_blk = rlist[ri].src, dst_blk = rlist[ri].dst;
> +			remaining > 0;
> +			remaining -= copy_len, src_blk += copy_len, dst_blk += copy_len) {

This is unreadable.

> +			copy_len = min(remaining, max_copy_len);
> +
> +			token = alloc_page(gfp_mask);
> +			if (unlikely(!token)) {
> +				ret = -ENOMEM;
> +				goto err_token;
> +			}
> +
> +			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!read_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
> +			read_bio->bi_iter.bi_size = copy_len;
> +			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> +			ret = submit_bio_wait(read_bio);
> +			if (ret) {
> +				bio_put(read_bio);
> +				goto err_read_bio;
> +			}
> +			bio_put(read_bio);
> +			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> +			if (!ctx) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}

This should be done before the read.

> +			ctx->cio = cio;
> +			ctx->range_idx = ri;
> +			ctx->start_sec = rlist[ri].src;
> +
> +			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!write_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +
> +			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
> +			write_bio->bi_iter.bi_size = copy_len;
> +			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
> +			write_bio->bi_end_io = bio_copy_end_io;
> +			write_bio->bi_private = ctx;
> +			atomic_inc(&cio->refcount);
> +			submit_bio(write_bio);
> +		}
> +	}
> +
> +	/* Wait for completion of all IO's*/
> +	return cio_await_completion(cio);
> +
> +err_read_bio:
> +	__free_page(token);
> +err_token:
> +	rlist[ri].comp_len = min_t(sector_t, rlist[ri].comp_len, (rlist[ri].len - remaining));
> +
> +	cio->io_err = ret;
> +	return cio_await_completion(cio);
> +}
> +
> +static inline int blk_copy_sanity_check(struct block_device *src_bdev,
> +		struct block_device *dst_bdev, struct range_entry *rlist, int nr)
> +{
> +	unsigned int align_mask = max(
> +			bdev_logical_block_size(dst_bdev), bdev_logical_block_size(src_bdev)) - 1;
> +	sector_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (rlist[i].len)
> +			len += rlist[i].len;
> +		else
> +			return -EINVAL;
> +		if ((rlist[i].dst & align_mask) || (rlist[i].src & align_mask) ||
> +				(rlist[i].len & align_mask))
> +			return -EINVAL;
> +		rlist[i].comp_len = 0;
> +	}
> +
> +	if (!len && len >= MAX_COPY_TOTAL_LENGTH)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static inline bool blk_check_copy_offload(struct request_queue *src_q,
> +		struct request_queue *dest_q)
> +{
> +	if (dest_q->limits.copy_offload == BLK_COPY_OFFLOAD &&
> +			src_q->limits.copy_offload == BLK_COPY_OFFLOAD)
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * blkdev_issue_copy - queue a copy
> + * @src_bdev:	source block device
> + * @nr_srcs:	number of source ranges to copy
> + * @src_rlist:	array of source ranges
> + * @dest_bdev:	destination block device
> + * @gfp_mask:   memory allocation flags (for bio_alloc)
> + * @flags:	BLKDEV_COPY_* flags to control behaviour
> + *
> + * Description:
> + *	Copy source ranges from source block device to destination block device.
> + *	length of a source range cannot be zero.
> + */
> +int blkdev_issue_copy(struct block_device *src_bdev, int nr,
> +		struct range_entry *rlist, struct block_device *dest_bdev,
> +		gfp_t gfp_mask, int flags)
> +{
> +	struct request_queue *src_q = bdev_get_queue(src_bdev);
> +	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
> +	int ret = -EINVAL;
> +
> +	if (!src_q || !dest_q)
> +		return -ENXIO;
> +
> +	if (!nr)
> +		return -EINVAL;
> +
> +	if (nr >= MAX_COPY_NR_RANGE)
> +		return -EINVAL;
> +
> +	if (bdev_read_only(dest_bdev))
> +		return -EPERM;
> +
> +	ret = blk_copy_sanity_check(src_bdev, dest_bdev, rlist, nr);
> +	if (ret)
> +		return ret;
> +
> +	if (blk_check_copy_offload(src_q, dest_q))
> +		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(blkdev_issue_copy);
> +
>  /**
>   * __blkdev_issue_write_same - generate number of bios with same page
>   * @bdev:	target blockdev
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 818454552cf8..4c8d48b8af25 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -545,6 +545,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_segment_size = min_not_zero(t->max_segment_size,
>  					   b->max_segment_size);
>  
> +	t->max_copy_sectors = min_not_zero(t->max_copy_sectors, b->max_copy_sectors);

Why min_not_zero ? If one of the underlying drive does not support copy
offload, you cannot report that the top drive does.

> +
>  	t->misaligned |= b->misaligned;
>  
>  	alignment = queue_limit_alignment_offset(b, start);
> diff --git a/block/blk.h b/block/blk.h
> index abb663a2a147..94d2b055750b 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -292,6 +292,8 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
>  		break;
>  	}
>  
> +	if (unlikely(op_is_copy(bio->bi_opf)))
> +		return false;
>  	/*
>  	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
>  	 * This is a quick and dirty check that relies on the fact that
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 5561e58d158a..0a3fee8ad61c 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -418,6 +418,7 @@ enum req_flag_bits {
>  	/* for driver use */
>  	__REQ_DRV,
>  	__REQ_SWAP,		/* swapping request. */
> +	__REQ_COPY,		/* copy request*/
>  	__REQ_NR_BITS,		/* stops here */
>  };
>  
> @@ -442,6 +443,7 @@ enum req_flag_bits {
>  
>  #define REQ_DRV			(1ULL << __REQ_DRV)
>  #define REQ_SWAP		(1ULL << __REQ_SWAP)
> +#define REQ_COPY		(1ULL << __REQ_COPY)
>  
>  #define REQ_FAILFAST_MASK \
>  	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
> @@ -498,6 +500,11 @@ static inline bool op_is_discard(unsigned int op)
>  	return (op & REQ_OP_MASK) == REQ_OP_DISCARD;
>  }
>  
> +static inline bool op_is_copy(unsigned int op)
> +{
> +	return (op & REQ_COPY);
> +}
> +
>  /*
>   * Check if a bio or request operation is a zone management operation, with
>   * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special case
> @@ -532,4 +539,17 @@ struct blk_rq_stat {
>  	u64 batch;
>  };
>  
> +struct cio {
> +	atomic_t refcount;
> +	blk_status_t io_err;
> +	struct range_entry *rlist;
> +	struct task_struct *waiter;     /* waiting task (NULL if none) */
> +};
> +
> +struct copy_ctx {
> +	int range_idx;
> +	sector_t start_sec;
> +	struct cio *cio;
> +};
> +
>  #endif /* __LINUX_BLK_TYPES_H */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f63ae50f1de3..15597488040c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1120,6 +1120,9 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		struct bio **biop);
>  struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  		gfp_t gfp_mask);
> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> +		struct range_entry *src_rlist, struct block_device *dest_bdev,
> +		gfp_t gfp_mask, int flags);
>  
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index bdf7b404b3e7..55bca8f6e8ed 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,20 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/* Maximum no of entries supported */
> +#define MAX_COPY_NR_RANGE	(1 << 12)
> +
> +/* maximum total copy length */
> +#define MAX_COPY_TOTAL_LENGTH	(1 << 21)
> +
> +/* Source range entry for copy */
> +struct range_entry {
> +	__u64 src;
> +	__u64 dst;
> +	__u64 len;
> +	__u64 comp_len;
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1


-- 
Damien Le Moal
Western Digital Research
