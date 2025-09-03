Return-Path: <linux-fsdevel+bounces-60205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20248B42AD9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10984189EBDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180ED2E2DDD;
	Wed,  3 Sep 2025 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQTZI6rP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664952DC35B;
	Wed,  3 Sep 2025 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931198; cv=none; b=LIgRew4FyXMG6RP9JQhgVVADBkmFdnE83pZqYA/heN0p+2JkDHkMlqCVqk9+ft+pjPWajHPTerkNzLJnvXfG108oB3SrjyBGBwfkps5duLVNhsEqNZk8VT2kbdy7RFVW7TGtBLGX1Gy06S7qLUOhBBjt8zk2jA4NRjxmyGl0UiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931198; c=relaxed/simple;
	bh=yzJ7tpDQKiRoIEm24FW4xmAUnoM81UbH6YqcZFRrUuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smRFwvI1Cg3QaovINq1+dv49vHUg/t4T6RvavqfPxl3SCH1cBChIyHM1HID8mypkccL38E7Uy+2amcxPMSc2uCP9a+Vj6JHafq2TXlzX5uK4eBLCgLTsdFRhkBF9NWd8ImwmZ8+watD+802WrywZ+GX50QysBptdZZZsjNP50Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQTZI6rP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53A9C4CEE7;
	Wed,  3 Sep 2025 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756931197;
	bh=yzJ7tpDQKiRoIEm24FW4xmAUnoM81UbH6YqcZFRrUuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQTZI6rPAeU1x44ynEMzL7cG5qu/W7C+IUULCcuS18F9d4jZON75wB2jDZ5d71Mlv
	 6JbCr5RG1sBTWzD2f/LtSI40YFw5NEtjE2TMyFT2SbTKM5GzgXd4ePvGX+ySE96ahj
	 iuZmDpZTdAJLElxaOVJcOtWu1ajROL3WE42Kc+67OILEbaX74vYfs0SZgMbHNYgcFI
	 /e36OrxSA3TxpNzz7DSDSle1m4hR6nru4uWnptTKlTzsmQofUpNFQaLbPt+yq0ArmH
	 6/pVdpAaVcusE3MZ9GnwU6XFS1uaeMmDcvojv7snP+h+YkC3XTizJPosi/rNPfFF0/
	 xN+TcMKu+5odQ==
Date: Wed, 3 Sep 2025 13:26:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 02/16] iomap: rename cur_folio_in_bio to
 folio_unlockedOM
Message-ID: <20250903202637.GL1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-3-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:13PM -0700, Joanne Koong wrote:
> The purpose of struct iomap_readpage_ctx's cur_folio_in_bio is to track
> if the folio needs to be unlocked or not. Rename this to folio_unlocked
> to make the purpose more clear and so that when iomap read/readahead
> logic is made generic, the name also makes sense for filesystems that
> don't use bios.

Hrmmm.  The problem is, "cur_folio_in_bio" captures the meaning that the
(locked) folio is attached to the bio, so the bio_io_end function has to
unlock the folio.  The readahead context is basically borrowing the
folio and cannot unlock the folio itelf.

The name folio_unlocked doesn't capture the change in ownership, it just
fixates on the lock state which (imo) is a side effect of the folio lock
ownership.

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f8bdb2428819..4b173aad04ed 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -352,7 +352,7 @@ static void iomap_read_end_io(struct bio *bio)
>  
>  struct iomap_readpage_ctx {
>  	struct folio		*cur_folio;
> -	bool			cur_folio_in_bio;
> +	bool			folio_unlocked;

Maybe this ought to be called cur_folio_borrowed?

	/*
	 * Folio readahead can transfer ownership of a folio lock to
	 * an external reader (e.g. bios) with the expectation that
	 * the new owner will unlock the folio when the readahead is
	 * complete.  Under these circumstances, the readahead context
	 * is merely borrowing the folio and must not unlock it.
	 */
	bool			cur_folio_borrowed;

>  	struct bio		*bio;
>  	struct readahead_control *rac;
>  };
> @@ -367,7 +367,7 @@ static void iomap_read_folio_range_async(const struct iomap_iter *iter,
>  	loff_t length = iomap_length(iter);
>  	sector_t sector;
>  
> -	ctx->cur_folio_in_bio = true;
> +	ctx->folio_unlocked = true;

	ctx->cur_folio_borrowed = true;

>  	if (ifs) {
>  		spin_lock_irq(&ifs->state_lock);
>  		ifs->read_bytes_pending += plen;
> @@ -480,9 +480,9 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  
>  	if (ctx.bio) {
>  		submit_bio(ctx.bio);
> -		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
> +		WARN_ON_ONCE(!ctx.folio_unlocked);
>  	} else {
> -		WARN_ON_ONCE(ctx.cur_folio_in_bio);
> +		WARN_ON_ONCE(ctx.folio_unlocked);
>  		folio_unlock(folio);
>  	}
>  
> @@ -503,13 +503,13 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  	while (iomap_length(iter)) {
>  		if (ctx->cur_folio &&
>  		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
> -			if (!ctx->cur_folio_in_bio)
> +			if (!ctx->folio_unlocked)
>  				folio_unlock(ctx->cur_folio);
>  			ctx->cur_folio = NULL;
>  		}
>  		if (!ctx->cur_folio) {
>  			ctx->cur_folio = readahead_folio(ctx->rac);
> -			ctx->cur_folio_in_bio = false;
> +			ctx->folio_unlocked = false;

			ctx->cur_folio_borrowed = false;

>  		}
>  		ret = iomap_readpage_iter(iter, ctx);
>  		if (ret)
> @@ -552,10 +552,8 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  
>  	if (ctx.bio)
>  		submit_bio(ctx.bio);
> -	if (ctx.cur_folio) {
> -		if (!ctx.cur_folio_in_bio)
> -			folio_unlock(ctx.cur_folio);
> -	}
> +	if (ctx.cur_folio && !ctx.folio_unlocked)
> +		folio_unlock(ctx.cur_folio);

	if (ctx.cur_folio && !ctx.cur_folio_borrowed)
		folio_unlock(ctx.cur_folio);

>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -- 
> 2.47.3
> 
> 

