Return-Path: <linux-fsdevel+bounces-19816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5188C9F2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C6D1F21A6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7EB136E26;
	Mon, 20 May 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF28tbLn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECF28E7;
	Mon, 20 May 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217211; cv=none; b=o16U9RWi3Yw+1yYU1MiVXS6FlYkICFJ6dGWfyNzDYolzcUT1L9EAzJ3Thac0M+hJYmF+ZDeegpB9P+SCU24sH71QwE90aPGRfyhj6SIBFdFiDTG7rTnA6EpwVe68A6RuhBMeoyR1v6xloqMH65Y3dBMXpkO/NVa+VE/qpWbGOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217211; c=relaxed/simple;
	bh=6RnVIwxpdPu2quHrapU91k6GMCQR93bNvVmrk8LVkS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkYHCH1Moa0kiqP9zxJ70pusqJiZcZifYy+cC4n34WuLkrxHb+Rf7raEFAksfh25HBkWhcADc+0ZryKfnPMJfjsnSq/fqXwow0Wu2P0hZBFMB2op2GVcQHCk5xHml3bhp2ioQf+xdI0aXCE6bxrGuIfc5Dg2wL4d8gEqhn4jy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF28tbLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE63C2BD10;
	Mon, 20 May 2024 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716217210;
	bh=6RnVIwxpdPu2quHrapU91k6GMCQR93bNvVmrk8LVkS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oF28tbLntmCzHKO6rQoXTZ3wKS2octb5Jh6K7EmZBCBXNUFfb9Nz1Ajdy2nO9Hg6i
	 XH7BjC2Ird+JGwRVmNhYqZy92ZhQbsr0HNPXjFb0fZLNNC41MVNmz3haLdyF98Qnzj
	 7RIeTux/Yy0jcBFDHe5A9TzSj/0iWQ9kiXWX0kmAFy12DYxTuJdfnfaIIIoDgrdMzd
	 ROqbDuj7O5sFlDYxBNYp4yVwskKIQr9qUQc3Bnz14LyBtSwhMAesbcDurXhZ+CwrKz
	 bMxZchDGqjooqICZYNYs/QGUCBjCyX7PXC5YqgnAi5/S/iRCxQ99JjQCCqClqOpfm4
	 MoZvH6ZaVtHFA==
Message-ID: <8f60ed88-1978-4d7c-9149-aee672aa1b09@kernel.org>
Date: Mon, 20 May 2024 17:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/20 12:20, Nitesh Shetty wrote:
> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
> Since copy is a composite operation involving src and dst sectors/lba,
> each needs to be represented by a separate bio to make it compatible
> with device mapper.

Why ? The beginning of the sentence isn't justification enough for the two new
operation codes ? The 2 sentences should be reversed for easier reading:
justification first naturally leads to the reader understanding why the codes
are needed.

Also: s/opcode/operations


> We expect caller to take a plug and send bio with destination information,
> followed by bio with source information.

expect ? Plugging is optional. Does copy offload require it ? Please clarify this.

> Once the dst bio arrives we form a request and wait for source

arrives ? You mean "is submitted" ?

s/and wait for/and wait for the

> bio. Upon arrival of source bio we merge these two bio's and send

s/arrival/submission ?

s/of/of the
s/bio's/BIOs
s/and send/and send the
s/down to/down to the

> corresponding request down to device driver.
> Merging non copy offload bio is avoided by checking for copy specific
> opcodes in merge function.

Super unclear... What are you trying to say here ? That merging copy offload
BIOs with other BIOs is not allowed ? That is already handled. Only BIOs &
requests with the same operation can be merged. The code below also suggests
that you allow merging copy offloads... So I really do not understand this.

> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  block/blk-core.c          |  7 +++++++
>  block/blk-merge.c         | 41 +++++++++++++++++++++++++++++++++++++++
>  block/blk.h               | 16 +++++++++++++++
>  block/elevator.h          |  1 +
>  include/linux/bio.h       |  6 +-----
>  include/linux/blk_types.h | 10 ++++++++++
>  6 files changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ea44b13af9af..f18ee5f709c0 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -122,6 +122,8 @@ static const char *const blk_op_name[] = {
>  	REQ_OP_NAME(ZONE_FINISH),
>  	REQ_OP_NAME(ZONE_APPEND),
>  	REQ_OP_NAME(WRITE_ZEROES),
> +	REQ_OP_NAME(COPY_SRC),
> +	REQ_OP_NAME(COPY_DST),
>  	REQ_OP_NAME(DRV_IN),
>  	REQ_OP_NAME(DRV_OUT),
>  };
> @@ -838,6 +840,11 @@ void submit_bio_noacct(struct bio *bio)
>  		 * requests.
>  		 */
>  		fallthrough;
> +	case REQ_OP_COPY_SRC:
> +	case REQ_OP_COPY_DST:
> +		if (!q->limits.max_copy_sectors)
> +			goto not_supported;
> +		break;
>  	default:
>  		goto not_supported;
>  	}
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 8534c35e0497..f8dc48a03379 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -154,6 +154,20 @@ static struct bio *bio_split_write_zeroes(struct bio *bio,
>  	return bio_split(bio, lim->max_write_zeroes_sectors, GFP_NOIO, bs);
>  }
>  
> +static struct bio *bio_split_copy(struct bio *bio,
> +				  const struct queue_limits *lim,
> +				  unsigned int *nsegs)
> +{
> +	*nsegs = 1;
> +	if (bio_sectors(bio) <= lim->max_copy_sectors)
> +		return NULL;
> +	/*
> +	 * We don't support splitting for a copy bio. End it with EIO if
> +	 * splitting is required and return an error pointer.
> +	 */
> +	return ERR_PTR(-EIO);
> +}

Hmm... Why not check that the copy request is small enough and will not be split
when it is submitted ? Something like blk_check_zone_append() does with
REQ_OP_ZONE_APPEND ? So adding a blk_check_copy_offload(). That would also
include the limits check from the previous hunk.

> +
>  /*
>   * Return the maximum number of sectors from the start of a bio that may be
>   * submitted as a single request to a block device. If enough sectors remain,
> @@ -362,6 +376,12 @@ struct bio *__bio_split_to_limits(struct bio *bio,
>  	case REQ_OP_WRITE_ZEROES:
>  		split = bio_split_write_zeroes(bio, lim, nr_segs, bs);
>  		break;
> +	case REQ_OP_COPY_SRC:
> +	case REQ_OP_COPY_DST:
> +		split = bio_split_copy(bio, lim, nr_segs);
> +		if (IS_ERR(split))
> +			return NULL;
> +		break;

See above.

>  	default:
>  		split = bio_split_rw(bio, lim, nr_segs, bs,
>  				get_max_io_size(bio, lim) << SECTOR_SHIFT);
> @@ -925,6 +945,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>  	if (!rq_mergeable(rq) || !bio_mergeable(bio))
>  		return false;
>  
> +	if (blk_copy_offload_mergable(rq, bio))
> +		return true;
> +
>  	if (req_op(rq) != bio_op(bio))
>  		return false;
>  
> @@ -958,6 +981,8 @@ enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
>  {
>  	if (blk_discard_mergable(rq))
>  		return ELEVATOR_DISCARD_MERGE;
> +	else if (blk_copy_offload_mergable(rq, bio))
> +		return ELEVATOR_COPY_OFFLOAD_MERGE;
>  	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
>  		return ELEVATOR_BACK_MERGE;
>  	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
> @@ -1065,6 +1090,20 @@ static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
>  	return BIO_MERGE_FAILED;
>  }
>  
> +static enum bio_merge_status bio_attempt_copy_offload_merge(struct request *req,
> +							    struct bio *bio)
> +{
> +	if (req->__data_len != bio->bi_iter.bi_size)
> +		return BIO_MERGE_FAILED;
> +
> +	req->biotail->bi_next = bio;
> +	req->biotail = bio;
> +	req->nr_phys_segments++;
> +	req->__data_len += bio->bi_iter.bi_size;

Arg... You seem to be assuming that the source BIO always comes right after the
destination request... What if copy offloads are being concurrently issued ?
Shouldn't you check somehow that the pair is a match ? Or are you relying on the
per-context plugging which prevents that from happening in the first place ? But
that would assumes that you never ever sleep trying to allocate the source BIO
after the destination BIO/request are prepared and plugged.

> +
> +	return BIO_MERGE_OK;
> +}
> +
>  static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
>  						   struct request *rq,
>  						   struct bio *bio,
> @@ -1085,6 +1124,8 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
>  		break;
>  	case ELEVATOR_DISCARD_MERGE:
>  		return bio_attempt_discard_merge(q, rq, bio);
> +	case ELEVATOR_COPY_OFFLOAD_MERGE:
> +		return bio_attempt_copy_offload_merge(rq, bio);
>  	default:
>  		return BIO_MERGE_NONE;
>  	}
> diff --git a/block/blk.h b/block/blk.h
> index 189bc25beb50..6528a2779b84 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -174,6 +174,20 @@ static inline bool blk_discard_mergable(struct request *req)
>  	return false;
>  }
>  
> +/*
> + * Copy offload sends a pair of bio with REQ_OP_COPY_DST and REQ_OP_COPY_SRC
> + * operation by taking a plug.
> + * Initially DST bio is sent which forms a request and
> + * waits for SRC bio to arrive. Once SRC bio arrives
> + * we merge it and send request down to driver.
> + */
> +static inline bool blk_copy_offload_mergable(struct request *req,
> +					     struct bio *bio)
> +{
> +	return (req_op(req) == REQ_OP_COPY_DST &&
> +		bio_op(bio) == REQ_OP_COPY_SRC);
> +}

This function is really not needed at all (used in one place only).

> +
>  static inline unsigned int blk_rq_get_max_segments(struct request *rq)
>  {
>  	if (req_op(rq) == REQ_OP_DISCARD)
> @@ -323,6 +337,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
>  	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_COPY_SRC:
> +	case REQ_OP_COPY_DST:
>  		return true; /* non-trivial splitting decisions */

See above. Limits should be checked on submission.

>  	default:
>  		break;
> diff --git a/block/elevator.h b/block/elevator.h
> index e9a050a96e53..c7a45c1f4156 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -18,6 +18,7 @@ enum elv_merge {
>  	ELEVATOR_FRONT_MERGE	= 1,
>  	ELEVATOR_BACK_MERGE	= 2,
>  	ELEVATOR_DISCARD_MERGE	= 3,
> +	ELEVATOR_COPY_OFFLOAD_MERGE	= 4,
>  };
>  
>  struct blk_mq_alloc_data;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index d5379548d684..528ef22dd65b 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -53,11 +53,7 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
>   */
>  static inline bool bio_has_data(struct bio *bio)
>  {
> -	if (bio &&
> -	    bio->bi_iter.bi_size &&
> -	    bio_op(bio) != REQ_OP_DISCARD &&
> -	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
> -	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
> +	if (bio && (bio_op(bio) == REQ_OP_READ || bio_op(bio) == REQ_OP_WRITE))
>  		return true;

This change seems completely broken and out of place. This would cause a return
of false for zone append operations.

>  
>  	return false;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 781c4500491b..7f692bade271 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -342,6 +342,10 @@ enum req_op {
>  	/* reset all the zone present on the device */
>  	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
>  
> +	/* copy offload src and dst operation */

s/src/source
s/dst/destination
s/operation/operations

> +	REQ_OP_COPY_SRC		= (__force blk_opf_t)18,
> +	REQ_OP_COPY_DST		= (__force blk_opf_t)19,
> +
>  	/* Driver private requests */
>  	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
>  	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
> @@ -430,6 +434,12 @@ static inline bool op_is_write(blk_opf_t op)
>  	return !!(op & (__force blk_opf_t)1);
>  }
>  
> +static inline bool op_is_copy(blk_opf_t op)
> +{
> +	return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
> +		(op & REQ_OP_MASK) == REQ_OP_COPY_DST);
> +}

May be use a switch here to avoid the double masking of op ?

> +
>  /*
>   * Check if the bio or request is one that needs special treatment in the
>   * flush state machine.

-- 
Damien Le Moal
Western Digital Research


