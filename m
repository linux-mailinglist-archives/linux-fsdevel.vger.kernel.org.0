Return-Path: <linux-fsdevel+bounces-75175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFILLs67cmniowAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:07:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6AE6EAE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C01B8300609A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22EE29AB02;
	Fri, 23 Jan 2026 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/esw17X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1CA2BDC28;
	Fri, 23 Jan 2026 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769126848; cv=none; b=PYM7BbUUDWjjwcleVVehw45QG7MQhr+cZbm1RB0hwUz1e229KZ82dz/a1iEd4myR+G2xucacuGbuh7SNw5yAiNap6a9yUCR3A+0cRxOFybXmfBK6VKUWzegNYOPfH09Hq6ZoM5rd27mL2D5VpCzvHLCHBiP0lDe3NQBchQOg62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769126848; c=relaxed/simple;
	bh=L9/fOtC0nbI7S+9zwfYXHTeN4bBLzvfJkicAyzhxjHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO6L/9wRrcMG14UPo4k80gC2bGW1Qw6X1SoeDrFaFp3bbahBtHyPla3fyYYcpK9a8vNOBJ//JhZ0PaC0kqOXQIko3BLO1oKwNQvqJvqrKq5U+NKEHoAcsDXE0oeyMQYYfpf4osQ/TIqz9Wcr9ULucJTpmqs/OCTQMXJvU7vH4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/esw17X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26D6C116C6;
	Fri, 23 Jan 2026 00:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769126846;
	bh=L9/fOtC0nbI7S+9zwfYXHTeN4bBLzvfJkicAyzhxjHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/esw17XlXMhc/Mxh8lCm7J0XI5cOxPl9rs99YlLxPQKbTPG3SUvGjxe9rDkkn2T2
	 AvADHWaSkRL/zmikv04lvoK+cMSoHjLl9fuIAtQz7MBZMNyjZM9q2sThtWtBOLNGqs
	 Nxb8PPxLjYqw6biyyw+UrBH83Y1hhGrZMphOU1fW5hp0Jb+C38/mm743BpvUykh5q7
	 tb93G5QVrhzM6F0lQ8tDdw10BxxhUB7EYGcEfQTuIemd17fVEjNz4HeKuPQN1JlVfz
	 GCazN8x/QVSgmVdGyPSjFYQiPDrruSvkxGJ0n/nnn0YyUMoZBB3a7Hn9YWdDp/xPu+
	 abelhKCB9I9FA==
Date: Thu, 22 Jan 2026 16:07:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/15] block: prepare generation / verification helpers
 for fs usage
Message-ID: <20260123000726.GI5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-5-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75175-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD6AE6EAE9
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:12AM +0100, Christoph Hellwig wrote:
> Return the status from verify instead of directly stashing it in the bio,
> and rename the helpers to use the usual bio_ prefix for things operating
> on a bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bio-integrity-auto.c |  4 ++--
>  block/blk.h                |  6 ++++--
>  block/t10-pi.c             | 12 ++++++------
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
> index 5345d55b9998..f68a17a8dbc2 100644
> --- a/block/bio-integrity-auto.c
> +++ b/block/bio-integrity-auto.c
> @@ -39,7 +39,7 @@ static void bio_integrity_verify_fn(struct work_struct *work)
>  		container_of(work, struct bio_integrity_data, work);
>  	struct bio *bio = bid->bio;
>  
> -	blk_integrity_verify_iter(bio, &bid->saved_bio_iter);
> +	bio->bi_status = bio_integrity_verify(bio, &bid->saved_bio_iter);
>  	bio_integrity_finish(bid);
>  	bio_endio(bio);
>  }
> @@ -100,7 +100,7 @@ void bio_integrity_prep(struct bio *bio, unsigned int action)
>  
>  	/* Auto-generate integrity metadata if this is a write */
>  	if (bio_data_dir(bio) == WRITE && bip_should_check(&bid->bip))
> -		blk_integrity_generate(bio);
> +		bio_integrity_generate(bio);
>  	else
>  		bid->saved_bio_iter = bio->bi_iter;
>  }
> diff --git a/block/blk.h b/block/blk.h
> index 886238cae5f1..d222ce4b6dfc 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -695,8 +695,10 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>  	      const struct blk_holder_ops *hops, struct file *bdev_file);
>  int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
>  
> -void blk_integrity_generate(struct bio *bio);
> -void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter);
> +void bio_integrity_generate(struct bio *bio);
> +blk_status_t bio_integrity_verify(struct bio *bio,
> +		struct bvec_iter *saved_iter);
> +
>  void blk_integrity_prepare(struct request *rq);
>  void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
>  
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index 0c4ed9702146..d27be6041fd3 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -372,7 +372,7 @@ static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
>  	}
>  }
>  
> -void blk_integrity_generate(struct bio *bio)
> +void bio_integrity_generate(struct bio *bio)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
> @@ -404,7 +404,7 @@ void blk_integrity_generate(struct bio *bio)
>  	}
>  }
>  
> -void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
> +blk_status_t bio_integrity_verify(struct bio *bio, struct bvec_iter *saved_iter)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
> @@ -439,11 +439,11 @@ void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
>  		}
>  		kunmap_local(kaddr);
>  
> -		if (ret) {
> -			bio->bi_status = ret;
> -			return;
> -		}
> +		if (ret)
> +			return ret;
>  	}
> +
> +	return BLK_STS_OK;
>  }
>  
>  void blk_integrity_prepare(struct request *rq)
> -- 
> 2.47.3
> 
> 

