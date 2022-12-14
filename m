Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7A64C392
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 06:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiLNFoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 00:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLNFoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 00:44:03 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CFD21834
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 21:44:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f9so1293881pgf.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 21:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCyBGX9yuodtjDkOmCPXQhwD7RhUKbMjerSvvjTppvg=;
        b=AcVchgKOPItRAfX4Zzrj/yP2MnWlbT65AcMB6rczCa3vgzszbYY2/60rvAx1yeez7m
         N2Vl65DJ33GKvVN0BAm6Az5seRv2inJ21weVrOWlQt3nIk5sOH22gJLunJ9Pbqwv34iG
         kB166bJtwFrJ3kxOqwqtR7AEhHd6m1WDufgNXhOxkVrDKDFZZXTyzOh6g+Bz2P0A5NOq
         B8oDnkBrW1h2RbsON/KBlSNev6ZaaV1KNu3wb6orT6fVb7F6JOA4CVUwKq1EHK1I67Yp
         ddPJzfGMcHRTJg/233FZxyqxEIb5n1quAbyvhVaPHinrDq021VYmbr0SId8jj7t0d6xu
         7R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCyBGX9yuodtjDkOmCPXQhwD7RhUKbMjerSvvjTppvg=;
        b=ZXPn4UOR9VCQnf9vl6mdj1HU6Zoyg1uZ4sliG3UFVynxhTJFdRqifMJdhWQ7Cmn8Tn
         HvI02z7TEG4jCSgb80yE3YA6gelfU0J5wy0E1sgqDRKqf98XdiS/uhd9V+WdqX7p/dMY
         tbgWSkRVLqcZAgn5nwQ3xQovbiYD0SL4xOJwsO837UV8sRs7cFmAULDF4w1SLbZS0AUO
         taochsOyOgDSjA6deS47Tu3GDWxAVCxRV0c/CvDYYoYPCrk6V4JHHMLO9QQsKpzWtClX
         giK6QMX7YZ+ItiYddIe4mb90pOsJkXJZhDOD+MvjGl0NU5BcuKvRKmusbb8hL6Qo41pQ
         Mrbg==
X-Gm-Message-State: ANoB5pnYW/Ij7jBsfS1aNVzZgCMyzegytOAzMtaeyzuq89yQOqLep7wh
        YwrUVow2vOeVYfZ9r5T0xrdmWQ==
X-Google-Smtp-Source: AA0mqf5/K9sX6AcROUuJ3XZz06qIpuPg9IaDEgO3qQi6+SyR3u/moatDpL2XnH/8YqRsRTSbpZs/zQ==
X-Received: by 2002:a62:be0c:0:b0:56c:410f:7db8 with SMTP id l12-20020a62be0c000000b0056c410f7db8mr21738896pff.28.1670996641560;
        Tue, 13 Dec 2022 21:44:01 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id y28-20020aa78f3c000000b005625d5ae760sm8797979pfr.11.2022.12.13.21.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 21:44:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5KYf-008EGw-Qr; Wed, 14 Dec 2022 16:43:57 +1100
Date:   Wed, 14 Dec 2022 16:43:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 09/11] iomap: fs-verity verification on page read
Message-ID: <20221214054357.GI3600936@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-10-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213172935.680971-10-aalbersh@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:29:33PM +0100, Andrey Albershteyn wrote:
> Add fs-verity page verification in read IO path. The verification
> itself is offloaded into workqueue (provided by fs-verity).
> 
> The work_struct items are allocated from bioset side by side with
> bio being processed.
> 
> As inodes with fs-verity doesn't use large folios we check only
> first page of the folio for errors (set by fs-verity if verification
> failed).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 80 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/iomap.h  |  5 +++
>  2 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 91ee0b308e13d..b7abc2f806cfc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -17,6 +17,7 @@
>  #include <linux/bio.h>
>  #include <linux/sched/signal.h>
>  #include <linux/migrate.h>
> +#include <linux/fsverity.h>
>  #include "trace.h"
>  
>  #include "../internal.h"
> @@ -42,6 +43,7 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>  }
>  
>  static struct bio_set iomap_ioend_bioset;
> +static struct bio_set iomap_readend_bioset;
>  
>  static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
> @@ -189,9 +191,39 @@ static void iomap_read_end_io(struct bio *bio)
>  	int error = blk_status_to_errno(bio->bi_status);
>  	struct folio_iter fi;
>  
> -	bio_for_each_folio_all(fi, bio)
> +	bio_for_each_folio_all(fi, bio) {
> +		/*
> +		 * As fs-verity doesn't work with multi-page folios, verity
> +		 * inodes have large folios disabled (only single page folios
> +		 * are used)
> +		 */
> +		if (!error)
> +			error = PageError(folio_page(fi.folio, 0));
> +
>  		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
> +	}
> +
>  	bio_put(bio);
> +	/* The iomap_readend has been freed by bio_put() */
> +}
> +
> +static void iomap_read_work_end_io(
> +	struct work_struct *work)
> +{
> +	struct iomap_readend *ctx =
> +		container_of(work, struct iomap_readend, read_work);
> +	struct bio *bio = &ctx->read_inline_bio;
> +
> +	fsverity_verify_bio(bio);
> +	iomap_read_end_io(bio);
> +}
> +
> +static void iomap_read_work_io(struct bio *bio)
> +{
> +	struct iomap_readend *ctx =
> +		container_of(bio, struct iomap_readend, read_inline_bio);
> +
> +	fsverity_enqueue_verify_work(&ctx->read_work);
>  }

Ok, so fsverity simple queues this to a global workqueue it has set
up as WQ_UNBOUND | WQ_HIGHPRI with, effectively, one worker thread
per CPU. This will work for simple cases and to get the basic
infrastructure in place, but there are problems here that we will
need to address.

1. High priority workqueues are used within XFS to ensure that data
IO completion cannot stall processing of journal IO completions. We
use them to prevent IO priority inversion deadlocks.

That is, journal IO completions use a WQ_HIGHPRI workqueue to ensure
that they are scheduled ahead of data IO completions as data IO
completions may require journal IO to complete before they can make
progress (e.g. to ensure transaction reservations in IO completion
can make progress).

Hence using a WQ_HIGHPRI workqueue directly in the user data IO path
is a potential filesystem livelock/deadlock vector. At best, it's
going to impact on the latency of journal commits and hence anything
that is running data integrity operations whilst fsverity read
operations are in progress.

The second thing is that the fsverity workqueue is global - it
creates a cross-filesystem contention point. That means a single
busy fsverity filesystem will create unpredictable IO latency for
filesystems that only use fsverity sparingly. i.e. heavy amounts of
fsverity work on one filesystem will impact the performance of
journal and other IO operations on all other active filesystems due
to fsverity using WQ_HIGHPRI.

This sort of workqueue setup is typically fine for a single user
device that has lots of otherwise idle CPU that can be co-opted for
create concurrency in IO completion work where there would otherwise
been none (e.g. an Android phone).

However, it is less than ideal for a high concurrent application
using AIO or io_uring to push a couple of million IOPS through the
filesystem. In these sitations, we don't want IO completion work to
be spread outi because there is no idle CPU for them to be run on.
Instead, locality is king - we want them run on the same CPU that
already has the inode, bio, and other objects hot in the cache.

So, really, for XFS we want per-filesystem, locality preserving
per-cpu workqueues for fsverity work as we get IO concurrency (and
therefore fsverity work concurrency) from the application IO
patterns. And it avoids all potential issues with using WQ_HIGHPRI
for journal IO to avoid data IO completion deadlocks.


>  struct iomap_readpage_ctx {
> @@ -264,6 +296,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	loff_t orig_pos = pos;
>  	size_t poff, plen;
>  	sector_t sector;
> +	struct iomap_readend *readend;
>  
>  	if (iomap->type == IOMAP_INLINE)
>  		return iomap_read_inline_data(iter, folio);
> @@ -276,7 +309,21 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  
>  	if (iomap_block_needs_zeroing(iter, pos)) {
>  		folio_zero_range(folio, poff, plen);
> -		iomap_set_range_uptodate(folio, iop, poff, plen);
> +		if (!fsverity_active(iter->inode)) {
> +			iomap_set_range_uptodate(folio, iop, poff, plen);
> +			goto done;
> +		}
> +
> +		/*
> +		 * As fs-verity doesn't work with folios sealed inodes have
> +		 * multi-page folios disabled and we can check on first and only
> +		 * page
> +		 */
> +		if (fsverity_verify_page(folio_page(folio, 0)))
> +			iomap_set_range_uptodate(folio, iop, poff, plen);
> +		else
> +			folio_set_error(folio);

This makes me wonder if this should be a iomap->page_op method
rather than calling fsverity code directly. i.e. if the filesystem
knows that it fsverity is enabled on the inode during it's
iomap_begin() callout, and that state *must not change* until the IO
is complete. Hence it can set a iomap flag saying
IOMAP_F_READ_VERIFY and add a page_ops vector with a "verify_folio"
callout. Then this code can do:

	if (iomap_block_needs_zeroing(iter, pos)) {
		folio_zero_range(folio, poff, plen);
		if (iomap->flags & IOMAP_F_READ_VERIFY) {
			if (!iomap->page_ops->verify_folio(folio, poff, plen)) {
				folio_set_error(folio);
				goto done;
			}
		}
		iomap_set_range_uptodate(folio, iop, poff, plen);
		got done;
	}

> @@ -297,8 +344,18 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  
>  		if (ctx->rac) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> +		if (fsverity_active(iter->inode)) {
> +			ctx->bio = bio_alloc_bioset(iomap->bdev,
> +					bio_max_segs(nr_vecs), REQ_OP_READ,
> +					GFP_NOFS, &iomap_readend_bioset);
> +			readend = container_of(ctx->bio,
> +					struct iomap_readend,
> +					read_inline_bio);
> +			INIT_WORK(&readend->read_work, iomap_read_work_end_io);
> +		} else {
> +			ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
>  				     REQ_OP_READ, gfp);
> +		}
>  		/*
>  		 * If the bio_alloc fails, try it again for a single page to
>  		 * avoid having to deal with partial page reads.  This emulates
> @@ -311,7 +368,11 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  		if (ctx->rac)
>  			ctx->bio->bi_opf |= REQ_RAHEAD;
>  		ctx->bio->bi_iter.bi_sector = sector;
> -		ctx->bio->bi_end_io = iomap_read_end_io;
> +		if (fsverity_active(iter->inode))
> +			ctx->bio->bi_end_io = iomap_read_work_io;
> +		else
> +			ctx->bio->bi_end_io = iomap_read_end_io;


Hmmm. OK, why not just always use the iomap_readend_bioset, put
a flags field in it and then do this check in iomap_read_end_io()?

i.e.

struct iomap_read_ioend {
	bool			queue_work;
	struct work_struct	work;	/* post read work (fs-verity) */
	struct bio		inline_bio;/* MUST BE LAST! */
};


Then always allocate from the iomap_read_ioend_bioset, and do:

		ctx->bio->bi_end_io = iomap_read_end_io;
		if (iomap->flags & IOMAP_F_VERITY) {
			read_ioend->queue_work = true;
			INIT_WORK(&read_ioend->work, iomap_read_ioend_work);
		}

The in iomap_read_end_io():

	if (ioend->queue_work) {
		fsverity_enqueue_verify_work(&ctx->work);
		return;
	}
	iomap_read_end_io(bio);

And if we put a fs supplied workqueue into the iomap as well, then
we have a mechanism for the filesystem to supply it's own workqueue
for fsverity, fscrypt, or any other read-side post-IO data processing
functions filesystems care to add.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
