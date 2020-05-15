Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818671D4D9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 14:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgEOMZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 08:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgEOMZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 08:25:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3275C05BD0B
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 05:25:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so834648plt.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bm1fAyG7yZavy9O90p1YkTKfmJanzeKvfx2jV+h6w2Q=;
        b=mO9NPpo9BoTez+GQFpFt+Y3Cq/lG5g+yDRA4ftiV8ORIKSH8v5BAPa9DGSz1K6BrvB
         OZIUrB91xEiaBbi9USZ/NlzeicZNr6N4UsDeRuVinZtLxKLjG9q6xxEkHuvnCmJ8QXDH
         3gxFI9TH5fOpeWJ+WJtC87IszNA++1G54plFnlVbWpvCXCNhJ2Uo2+wle2cXiEkxulo6
         fIqTVOJm6R92VPR5adK2c3B8rEL6s7NQRN0UDNpidt88M4dm51jnL4kuDaZHtdaiPjwk
         OvRDms0Y/BlxHKP15cz6Vkm3sBqQWjOc2yIvtdz74eW5NoW6b+nrfDKW9ZeEKdzhP98W
         IdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bm1fAyG7yZavy9O90p1YkTKfmJanzeKvfx2jV+h6w2Q=;
        b=XzqDrsbVD4AuYnqPo2nDBLAu5IJ3n/57qLc3sAvrRJHT0VVmFCElz5FrwIsSohAqQd
         lQiqZa1Aya1h3xqmW8+gwxinCA4Xrw5HnFSrlDLYqonVSF/yEx4XwLMTQwPMiQhAamTt
         Jl8dJZKnaIChItmET+jSxtoLNVKtGojxbShSkMqWye+fYMKo8/Fd2TzITRe0pHBiYuNM
         GT/egKA5hYk3q8b3LGR3mCLL0ag6cYZvau48/030yKI4RdYYpUT8nC51tevQuyyjyy7k
         Tb14C2EMImPhOXDOWHqVJABrYQBJrBGXpz+oEFIpIuvx2iCm7er9viyCjXkZFOARaVVa
         96YQ==
X-Gm-Message-State: AOAM530NuPoxxGU3QZc4DUP6+tNrkqdub+rMOWJ4IAEEGLB70NEZEIvi
        WYeSLf414qlw5xg5ozmoI6l7oA==
X-Google-Smtp-Source: ABdhPJxodWiVpnp/bpk1spKFiU7lxS4aXxV09hAXu63vFlSE+V2nv5d8z4dCbHLg6VnBvKtknCleww==
X-Received: by 2002:a17:90b:1104:: with SMTP id gi4mr2989366pjb.115.1589545544694;
        Fri, 15 May 2020 05:25:44 -0700 (PDT)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id k73sm1100151pje.55.2020.05.15.05.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 05:25:44 -0700 (PDT)
Date:   Fri, 15 May 2020 12:25:40 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@kernel.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v13 00/12] Inline Encryption Support
Message-ID: <20200515122540.GA143740@google.com>
References: <20200514003727.69001-1-satyat@google.com>
 <20200514051053.GA14829@sol.localdomain>
 <8fa1aafe-1725-e586-ede3-a3273e674470@kernel.dk>
 <20200515074127.GA13926@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515074127.GA13926@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 12:41:27AM -0700, Christoph Hellwig wrote:
> On Thu, May 14, 2020 at 09:48:40AM -0600, Jens Axboe wrote:
> > I have applied 1-5 for 5.8. Small tweak needed in patch 3 due to a header
> > inclusion, but clean apart from that.
> 
> I looked at this a bit more as it clashed with my outstanding
> q_usage_counter optimization, and I think we should move the
> blk_crypto_bio_prep call into blk-mq, similar to what we do about
> the integrity_prep call.  Comments?
> 
> ---
> From b7a78be7de0f39ef972d6a2f97a3982a422bf3ab Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 15 May 2020 09:32:40 +0200
> Subject: block: move blk_crypto_bio_prep into blk_mq_make_request
> 
> Currently blk_crypto_bio_prep is called for every block driver, including
> stacking drivers, which is probably not the right thing to do.  Instead
> move it to blk_mq_make_request, similar to how we handle integrity data.
> If we ever grow a low-level make_request based driver that wants
> encryption it will have to call blk_crypto_bio_prep manually, but I really
> hope we don't grow more non-stacking make_request drivers to start with.
One of the nice things about the current design is that regardless of what
request queue an FS sends an encrypted bio to, blk-crypto will be able to handle
the encryption (whether by using hardware inline encryption, or using the
blk-crypto-fallback). The FS itself does not need to worry about what the
request queue is.

But if we move blk_crypto_bio_prep into blk_mq_make_request, the FS loses this
ability to not care about the underlying request queue - it can no longer send a
bio with an encryption context to queue such that q->make_request_fn !=
blk_mq_make_request_fn. To restore that ability, we'll need to add calls to
blk_crypto_bio_prep to every possible make_request_fn (although yes, if we do
decide to add the call to blk_crypto_bio_prep in multiple places, I think it'll
be fine to only add it to the non-stacking make_request_fns).

Also, I tried to look through the patch with the q_usage_counter optimization -
is it this one?

[PATCH 4/4] block: allow blk_mq_make_request to consume the q_usage_counter reference

> 
> This also means we only need to do the crypto preparation after splitting
> and bouncing the bio, which means we don't bother allocating the fallback
> context for a bio that might only be a dummy and gets split or bounced
> later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 13 +++++--------
>  block/blk-mq.c   |  2 ++
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 1e97f99735232..ac59afaa26960 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1131,12 +1131,10 @@ blk_qc_t generic_make_request(struct bio *bio)
>  			/* Create a fresh bio_list for all subordinate requests */
>  			bio_list_on_stack[1] = bio_list_on_stack[0];
>  			bio_list_init(&bio_list_on_stack[0]);
> -			if (blk_crypto_bio_prep(&bio)) {
> -				if (q->make_request_fn)
> -					ret = q->make_request_fn(q, bio);
> -				else
> -					ret = blk_mq_make_request(q, bio);
> -			}
> +			if (q->make_request_fn)
> +				ret = q->make_request_fn(q, bio);
> +			else
> +				ret = blk_mq_make_request(q, bio);
>  
>  			blk_queue_exit(q);
>  
> @@ -1185,8 +1183,7 @@ blk_qc_t direct_make_request(struct bio *bio)
>  		return BLK_QC_T_NONE;
>  	if (unlikely(bio_queue_enter(bio)))
>  		return BLK_QC_T_NONE;
> -	if (blk_crypto_bio_prep(&bio))
> -		ret = blk_mq_make_request(q, bio);
> +	ret = blk_mq_make_request(q, bio);
>  	blk_queue_exit(q);
>  	return ret;
>  }
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d2962863e629f..0b5a0fa0d124b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2033,6 +2033,8 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  	blk_queue_bounce(q, &bio);
>  	__blk_queue_split(q, &bio, &nr_segs);
>  
> +	if (!blk_crypto_bio_prep(&bio))
> +		return BLK_QC_T_NONE;
>  	if (!bio_integrity_prep(bio))
>  		return BLK_QC_T_NONE;
>  
> -- 
> 2.26.2
> 
