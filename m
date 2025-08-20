Return-Path: <linux-fsdevel+bounces-58364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 780D0B2D480
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 09:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E561BC7FA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 07:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96CA2D3A96;
	Wed, 20 Aug 2025 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQnfFDFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8B2D24A4;
	Wed, 20 Aug 2025 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673649; cv=none; b=TxcoJk/scBFg01dCvrM71U8UG4sC/dBy3mZ+NtYD7el9MpzGOvmNvhbxGTETK1NRJelYtu8jTiGB52N4/bcobvqiXrhhbGw3iCLcbsaTcRdEQMrsJ09IhbqxayXOYd3Pnfy9Pv/7eoIP4KC6Sa7/YgLuHEmPeqKTSe78m/DWMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673649; c=relaxed/simple;
	bh=RNuT8rolpmE1350wVDqZkO9I6NZ7Os8mz1M+GRaxmxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdajSNM9Kl/6CcW8B8Ik2qYHn2arOaIXpg8Ena9mmNSw5YIc7qztZPqsuffinkOjuz9cOCSvRp6o4ESxj042xPUaBqmeA00tsh1zCltWk06cEfVJSf3F5/XBTv0y+uZB5s8NiiRef97AwHY8wxID2M1jEK/iwMVnCdH8YE0zia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQnfFDFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071F4C113CF;
	Wed, 20 Aug 2025 07:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755673648;
	bh=RNuT8rolpmE1350wVDqZkO9I6NZ7Os8mz1M+GRaxmxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qQnfFDFKl2N8g9DijYw7VjJqcUUzwZK92nY4P2ZjHnSCpMAUQ3eyDA6UWU0hg06rt
	 05JffScD0bvWRVFsGfDYE/CID9uaExK9DA7gEiqhKJ18A8P2SWdUQSX2Wcy2iDanZ/
	 w/Wn/TgyUGpYpi/GWB/7YuqAc8nqr98FLsIrWcgV/NnjyGAvTYmJUHwlBidARaKRcK
	 aPtwbkrYdsE4pAZLQohFtI5lBpQZv8MqyAZwF6ADuvxq4h26AVzlfTsUUg/Bg6+5aj
	 gF9yKis26phVD/tgEgyeTWlghlS4AmQOcGiffcgG20yfIO8yM1FXBTdnrOsEjdGeWR
	 XrV4zDVw9E5Sw==
Message-ID: <90801327-0146-4852-b038-30a0595f46ea@kernel.org>
Date: Wed, 20 Aug 2025 16:04:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/8] block: check for valid bio while splitting
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, djwong@kernel.org,
 linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
 Keith Busch <kbusch@kernel.org>
References: <20250819164922.640964-1-kbusch@meta.com>
 <20250819164922.640964-2-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250819164922.640964-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 1:49 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We're already iterating every segment, so check these for a valid IO at
> the same time.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-map.c        |  2 +-
>  block/blk-merge.c      | 20 ++++++++++++++++----
>  include/linux/bio.h    |  4 ++--
>  include/linux/blkdev.h | 13 +++++++++++++
>  4 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 23e5d5ebe59ec..c5da9d37deee9 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -443,7 +443,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
>  	int ret;
>  
>  	/* check that the data layout matches the hardware restrictions */
> -	ret = bio_split_rw_at(bio, lim, &nr_segs, max_bytes);
> +	ret = bio_split_drv_at(bio, lim, &nr_segs, max_bytes);
>  	if (ret) {
>  		/* if we would have to split the bio, copy instead */
>  		if (ret > 0)
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be52..a0d8364983000 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -279,25 +279,29 @@ static unsigned int bio_split_alignment(struct bio *bio,
>  }
>  
>  /**
> - * bio_split_rw_at - check if and where to split a read/write bio
> + * bio_split_io_at - check if and where to split a read/write bio
>   * @bio:  [in] bio to be split
>   * @lim:  [in] queue limits to split based on
>   * @segs: [out] number of segments in the bio with the first half of the sectors
>   * @max_bytes: [in] maximum number of bytes per bio
> + * @len_align: [in] length alignment for each vector

Another thing: since this is a mask, maybe better to call it len_align_mask
like you did in patch 2 for bio_iov_iter_get_pages_aligned() ?

>   *
>   * Find out if @bio needs to be split to fit the queue limits in @lim and a
>   * maximum size of @max_bytes.  Returns a negative error number if @bio can't be
>   * split, 0 if the bio doesn't have to be split, or a positive sector offset if
>   * @bio needs to be split.
>   */
> -int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
> -		unsigned *segs, unsigned max_bytes)
> +int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
> +		unsigned *segs, unsigned max_bytes, unsigned len_align)
>  {
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
>  	struct bvec_iter iter;
>  	unsigned nsegs = 0, bytes = 0;
>  
>  	bio_for_each_bvec(bv, bio, iter) {
> +		if (bv.bv_offset & lim->dma_alignment || bv.bv_len & len_align)
> +			return -EINVAL;
> +
>  		/*
>  		 * If the queue doesn't support SG gaps and adding this
>  		 * offset would create a gap, disallow it.
> @@ -339,8 +343,16 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  	 * Individual bvecs might not be logical block aligned. Round down the
>  	 * split size so that each bio is properly block size aligned, even if
>  	 * we do not use the full hardware limits.
> +	 *
> +	 * Misuse may submit a bio that can't be split into a valid io. There
> +	 * may either be too many discontiguous vectors for the max segments
> +	 * limit, or contain virtual boundary gaps without having a valid block
> +	 * sized split. Catch that condition by checking for a zero byte
> +	 * result.
>  	 */
>  	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
> +	if (!bytes)
> +		return -EINVAL;
>  
>  	/*
>  	 * Bio splitting may cause subtle trouble such as hang when doing sync
> @@ -350,7 +362,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  	bio_clear_polled(bio);
>  	return bytes >> SECTOR_SHIFT;
>  }
> -EXPORT_SYMBOL_GPL(bio_split_rw_at);
> +EXPORT_SYMBOL_GPL(bio_split_io_at);
>  
>  struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
>  		unsigned *nr_segs)
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 46ffac5caab78..519a1d59805f8 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -322,8 +322,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
>  void bio_trim(struct bio *bio, sector_t offset, sector_t size);
>  extern struct bio *bio_split(struct bio *bio, int sectors,
>  			     gfp_t gfp, struct bio_set *bs);
> -int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
> -		unsigned *segs, unsigned max_bytes);
> +int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
> +		unsigned *segs, unsigned max_bytes, unsigned len_align);
>  
>  /**
>   * bio_next_split - get next @sectors from a bio, splitting if necessary
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 95886b404b16b..7f83ad2df5425 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1869,6 +1869,19 @@ bdev_atomic_write_unit_max_bytes(struct block_device *bdev)
>  	return queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
>  }
>  
> +static inline int bio_split_rw_at(struct bio *bio,
> +		const struct queue_limits *lim,
> +		unsigned *segs, unsigned max_bytes)
> +{
> +	return bio_split_io_at(bio, lim, segs, max_bytes, lim->dma_alignment);
> +}
> +
> +static inline int bio_split_drv_at(struct bio *bio,
> +		const struct queue_limits *lim,
> +		unsigned *segs, unsigned max_bytes)
> +{
> +	return bio_split_io_at(bio, lim, segs, max_bytes, 0);
> +}
>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>  
>  #endif /* _LINUX_BLKDEV_H */


-- 
Damien Le Moal
Western Digital Research

