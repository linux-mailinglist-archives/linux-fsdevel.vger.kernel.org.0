Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E27510EF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 04:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357236AbiD0CtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 22:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357233AbiD0Csx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:48:53 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B28F939A4
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 19:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651027543; x=1682563543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iz8dgRyK3nlTPbrBoKyLYl/46hZM7BSlBMRfgmhjIss=;
  b=VxN5kL8aYismlSqPQGVlQdI0OeRG+9sRUSI4Xxv6nreO2IvjlB71QLu1
   tnSzGlUQNXBDOlmheNpu2xQzujtaxJEZoQjXsstg1UHAWJ2KF8DKwcVEL
   PCdI8wKB9sA2lmLg0x5i/Rue229L+BDCTumhZtBC26UvunqZ49dS3vjm5
   dcpv7Cs07XbB67RlaetNtfcaeNwrCn0RloIbA1B24z2ECJo3MpYx5CRaB
   Hi0RufFOngDIQhC9G6GmuZOW/edtv97fL32kmXHJwdTnFG3VcWOqeinkv
   YL8lIWK6o2WwWNVMhtpfO0XfhuSTuYtTeAAIfdasTLhgDZq8nue49/avQ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="199805357"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 10:45:41 +0800
IronPort-SDR: twzd/hgq95/PavlF8FNFXdLxrPTtqaOqqqv8O58QVMqlrzQy8ihNImC7bnNznP6gltwJwBr/SH
 7XRZqxPXs3QiVhG6I3Y9Jryfajx9TcHPd7Gc0RmV5cc//c38cRiVO1G74qPytNTCabgB7EYqXs
 Hhyk5g1wYS10RZnmSrWOgBMnSbisCYejW8FQOcjyEZPB6jS/f8rTfNmyrKX4xvkREhYEnxRt6l
 Qn/bgDzalPCvWpo8T7Z+cb4938bYAd8nCaX3dEXeZajZGU2gOi9jlJmlY/Zq7Y56w3veFcFvdk
 CWns/7706IdskFaDXp51JeNN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 19:16:34 -0700
IronPort-SDR: NHZFxwuO3bhP5cmSn+OMpPr3yKDaoEefiCwg6tUyAWEmeF5sHPHDrrrZPA4CefeQrTEzLrIPE3
 SuFuLzJey0aEMP7gCAKtUTmhh2LT4DPuc6FNP5LGIOL2FDIckFVqqHLjbHjgeP2WgLOEArTdwU
 775Wu/n5fckEKehZDphKgZBuEqiKgf7EmFW6gt43OLYTLCB5P5U4AipE0c/oqCBdNA71fweEqP
 e15eJMw4VuPnM6Lg7QvJtcSDDLPbBwJRMoplyUjnlrNVZ21SVjWSYTzw/DbpXAZwTiL1lOpFhM
 mhw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 19:45:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp35b6Rd5z1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 19:45:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651027535; x=1653619536; bh=iz8dgRyK3nlTPbrBoKyLYl/46hZM7BSlBMR
        fgmhjIss=; b=kqHO0c1oLx2CAptGpcppyOeij/Lu5xGcbDy0ztbuf2mQoSaruqY
        CmnDLiWxZqnS4uEYen7ASZOuUwBuqfo7gF0Ug7xQAkefV7tyeV4QfxYBmMjI75ID
        AqtHfTb/zd2whqrnzfYHWdwPlaV6WxELmSaFB2rx/yDVqprOrSd4SQRYGx7lZ7sT
        Hbrg2ImbX1dTmMX9UX8f/CIUn40zaRgHWiuO4MgB1CndHP7yNXUadPhnIybQJ1AH
        ebBSc5lg9KYF1Q29nj10i8Q1b779rL66gTo6X+X5GVLr8YN+a/bEhw1csooW4Z9M
        8/pa+DBzQ4yL9qjrcXqzDD2qI6FRg2G2RFg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PDREGYSq-_Kz for <linux-fsdevel@vger.kernel.org>;
        Tue, 26 Apr 2022 19:45:35 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp35M67Knz1Rvlc;
        Tue, 26 Apr 2022 19:45:27 -0700 (PDT)
Message-ID: <7d1fdd1e-c854-4744-8bec-7d222fb9be76@opensource.wdc.com>
Date:   Wed, 27 Apr 2022 11:45:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 02/10] block: Add copy offload support infrastructure
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101921epcas5p341707619b5e836490284a42c92762083@epcas5p3.samsung.com>
 <20220426101241.30100-3-nj.shetty@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220426101241.30100-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/22 19:12, Nitesh Shetty wrote:
> Introduce blkdev_issue_copy which supports source and destination bdevs,
> and an array of (source, destination and copy length) tuples.
> Introduce REQ_COPY copy offload operation flag. Create a read-write
> bio pair with a token as payload and submitted to the device in order.
> Read request populates token with source specific information which
> is then passed with write request.
> This design is courtesy Mikulas Patocka's token based copy
> 
> Larger copy will be divided, based on max_copy_sectors,
> max_copy_range_sector limits.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>  block/blk-lib.c           | 232 ++++++++++++++++++++++++++++++++++++++
>  block/blk.h               |   2 +
>  include/linux/blk_types.h |  21 ++++
>  include/linux/blkdev.h    |   2 +
>  include/uapi/linux/fs.h   |  14 +++
>  5 files changed, 271 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 09b7e1200c0f..ba9da2d2f429 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -117,6 +117,238 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cio->lock, flags);
> +	if (cio->refcount) {
> +		cio->waiter = current;
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +		spin_unlock_irqrestore(&cio->lock, flags);
> +		blk_io_schedule();
> +		/* wake up sets us TASK_RUNNING */
> +		spin_lock_irqsave(&cio->lock, flags);
> +		cio->waiter = NULL;
> +		ret = cio->io_err;
> +	}
> +	spin_unlock_irqrestore(&cio->lock, flags);
> +	kvfree(cio);

cio is allocated with kzalloc() == kmalloc(). So why the kvfree() here ?

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
> +	unsigned long flags;
> +	bool wake = false;
> +
> +	if (bio->bi_status) {
> +		cio->io_err = bio->bi_status;
> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - ctx->start_sec;
> +		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);

long line.

> +	}
> +	__free_page(bio->bi_io_vec[0].bv_page);
> +	kfree(ctx);
> +	bio_put(bio);
> +
> +	spin_lock_irqsave(&cio->lock, flags);
> +	if (((--cio->refcount) <= 0) && cio->waiter)
> +		wake = true;
> +	spin_unlock_irqrestore(&cio->lock, flags);
> +	if (wake)
> +		wake_up_process(cio->waiter);
> +}
> +
> +/*
> + * blk_copy_offload	- Use device's native copy offload feature
> + * Go through user provide payload, prepare new payload based on device's copy offload limits.

long line.

> + */
> +int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
> +		struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)

long line.

rlist is an array, but rlist naming implies a list. Why not call that
argument "ranges" ?

The argument ordering is also strange. I would make that:

blk_copy_offload(struct block_device *src_bdev,
	         struct block_device *dst_bdev,
		 struct range_entry *rlist, int nr_srcs,
		 gfp_t gfp_mask)

> +{
> +	struct request_queue *sq = bdev_get_queue(src_bdev);
> +	struct request_queue *dq = bdev_get_queue(dst_bdev);
> +	struct bio *read_bio, *write_bio;
> +	struct copy_ctx *ctx;
> +	struct cio *cio;
> +	struct page *token;
> +	sector_t src_blk, copy_len, dst_blk;
> +	sector_t remaining, max_copy_len = LONG_MAX;
> +	unsigned long flags;
> +	int ri = 0, ret = 0;
> +
> +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> +	if (!cio)
> +		return -ENOMEM;
> +	cio->rlist = rlist;
> +	spin_lock_init(&cio->lock);
> +
> +	max_copy_len = min_t(sector_t, sq->limits.max_copy_sectors, dq->limits.max_copy_sectors);
> +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
> +			(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;

But max_copy_range_sectors is for one sector only, right ? So what is this
second min3() doing ? It is mixing up total length and one range length.
The device should not have reported a per range max length larger than the
total length in the first place, right ? If it does, that would be a very
starnge device...

> +
> +	for (ri = 0; ri < nr_srcs; ri++) {
> +		cio->rlist[ri].comp_len = rlist[ri].len;
> +		src_blk = rlist[ri].src;
> +		dst_blk = rlist[ri].dst;
> +		for (remaining = rlist[ri].len; remaining > 0; remaining -= copy_len) {
> +			copy_len = min(remaining, max_copy_len);
> +
> +			token = alloc_page(gfp_mask);
> +			if (unlikely(!token)) {
> +				ret = -ENOMEM;
> +				goto err_token;
> +			}
> +
> +			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> +			if (!ctx) {
> +				ret = -ENOMEM;
> +				goto err_ctx;
> +			}
> +			ctx->cio = cio;
> +			ctx->range_idx = ri;
> +			ctx->start_sec = dst_blk;
> +
> +			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!read_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
> +			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> +			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
> +			read_bio->bi_iter.bi_size = copy_len;
> +			ret = submit_bio_wait(read_bio);
> +			bio_put(read_bio);
> +			if (ret)
> +				goto err_read_bio;
> +
> +			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!write_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
> +			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
> +			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
> +			write_bio->bi_iter.bi_size = copy_len;
> +			write_bio->bi_end_io = bio_copy_end_io;
> +			write_bio->bi_private = ctx;
> +
> +			spin_lock_irqsave(&cio->lock, flags);
> +			++cio->refcount;

Shouldn't this be an atomic_t ?

And wrap lines please. Many are too long.

> +			spin_unlock_irqrestore(&cio->lock, flags);
> +
> +			submit_bio(write_bio);
> +			src_blk += copy_len;
> +			dst_blk += copy_len;
> +		}
> +	}
> +
> +	/* Wait for completion of all IO's*/
> +	return cio_await_completion(cio);
> +
> +err_read_bio:
> +	kfree(ctx);
> +err_ctx:
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

Reverse the if condition and return to avoid the else.

> +		if ((rlist[i].dst & align_mask) || (rlist[i].src & align_mask) ||
> +				(rlist[i].len & align_mask))
> +			return -EINVAL;
> +		rlist[i].comp_len = 0;
> +	}
> +
> +	if (len && len >= MAX_COPY_TOTAL_LENGTH)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static inline bool blk_check_copy_offload(struct request_queue *src_q,
> +		struct request_queue *dest_q)
> +{
> +	if (blk_queue_copy(dest_q) && blk_queue_copy(src_q))
> +		return true;
> +
> +	return false;

return blk_queue_copy(dest_q) && blk_queue_copy(src_q);

would be simpler.

> +}
> +
> +/*
> + * blkdev_issue_copy - queue a copy
> + * @src_bdev:	source block device
> + * @nr_srcs:	number of source ranges to copy
> + * @rlist:	array of source/dest/len
> + * @dest_bdev:	destination block device
> + * @gfp_mask:   memory allocation flags (for bio_alloc)
> + *
> + * Description:
> + *	Copy source ranges from source block device to destination block device.
> + *	length of a source range cannot be zero.
> + */
> +int blkdev_issue_copy(struct block_device *src_bdev, int nr,
> +		struct range_entry *rlist, struct block_device *dest_bdev, gfp_t gfp_mask)

same comment as above about args order and naming.

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

Where do you check the number of ranges against what the device can do ?

> +
> +	if (bdev_read_only(dest_bdev))
> +		return -EPERM;
> +
> +	ret = blk_copy_sanity_check(src_bdev, dest_bdev, rlist, nr);
> +	if (ret)
> +		return ret;

nr check should be in this function...

> +
> +	if (blk_check_copy_offload(src_q, dest_q))

...which should be only one function with this one.

> +		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blkdev_issue_copy);
> +
>  static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>  		struct bio **biop, unsigned flags)
> diff --git a/block/blk.h b/block/blk.h
> index 434017701403..6010eda58c70 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -291,6 +291,8 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
>  		break;
>  	}
>  
> +	if (unlikely(op_is_copy(bio->bi_opf)))
> +		return false;
>  	/*
>  	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
>  	 * This is a quick and dirty check that relies on the fact that
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index c62274466e72..f5b01f284c43 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -418,6 +418,7 @@ enum req_flag_bits {
>  	/* for driver use */
>  	__REQ_DRV,
>  	__REQ_SWAP,		/* swapping request. */
> +	__REQ_COPY,		/* copy request */
>  	__REQ_NR_BITS,		/* stops here */
>  };
>  
> @@ -443,6 +444,7 @@ enum req_flag_bits {
>  
>  #define REQ_DRV			(1ULL << __REQ_DRV)
>  #define REQ_SWAP		(1ULL << __REQ_SWAP)
> +#define REQ_COPY		(1ULL << __REQ_COPY)
>  
>  #define REQ_FAILFAST_MASK \
>  	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
> @@ -459,6 +461,11 @@ enum stat_group {
>  	NR_STAT_GROUPS
>  };
>  
> +static inline bool op_is_copy(unsigned int op)
> +{
> +	return (op & REQ_COPY);
> +}
> +
>  #define bio_op(bio) \
>  	((bio)->bi_opf & REQ_OP_MASK)
>  
> @@ -533,4 +540,18 @@ struct blk_rq_stat {
>  	u64 batch;
>  };
>  
> +struct cio {
> +	struct range_entry *rlist;

naming... This is an array, right ?

> +	struct task_struct *waiter;     /* waiting task (NULL if none) */
> +	spinlock_t lock;		/* protects refcount and waiter */
> +	int refcount;
> +	blk_status_t io_err;
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
> index 3596fd37fae7..c6cb3fe82ba2 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1121,6 +1121,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
>  int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp);
> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> +		struct range_entry *src_rlist, struct block_device *dest_bdev, gfp_t gfp_mask);
>  
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index bdf7b404b3e7..822c28cebf3a 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,20 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/* Maximum no of entries supported */
> +#define MAX_COPY_NR_RANGE	(1 << 12)

This value should be used also when setting the limits in the previous
patch. max_copy_nr_ranges and max_hw_copy_nr_ranges must be bounded by it.

> +
> +/* maximum total copy length */
> +#define MAX_COPY_TOTAL_LENGTH	(1 << 27)

Same for this one. And where does this magic number come from ?

> +
> +/* Source range entry for copy */
> +struct range_entry {
> +	__u64 src;
> +	__u64 dst;
> +	__u64 len;
> +	__u64 comp_len;

Please describe the fields of this structure. The meaning of them is
really not clear from the names.

> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1


-- 
Damien Le Moal
Western Digital Research
