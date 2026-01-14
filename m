Return-Path: <linux-fsdevel+bounces-73846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C4D21AC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8C06301D5E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802238E13E;
	Wed, 14 Jan 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceNiYypR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E03559DF;
	Wed, 14 Jan 2026 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431408; cv=none; b=My9WBBYKkf4qkj+LdoIvtkbvF1GAJPDtFCbBZfk+1zNz2I0ETTTf4xVS5h9kF/oJRXQvhpSGOX5sZBj8xOHVCsdbxrrXNG+oFafbKP4mDdJJctBjJYaPkDEm7/7WARnZW/9ysHnYZyjDX5rSGCfT+/ued1tHlplAYZFX2ZXooG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431408; c=relaxed/simple;
	bh=ijfh3A4w/VLFKZXz+nAlGhxsg5eknxIGI1Z1U/L1oKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNmrfpVmrVx5EqOCKJSZHqrwpilvw2gRlPd0o5ogW063BFk2d8aODpaO0eTGRWip/x1ZKc9clo3LdQsOILFEqa1hZk8CgTXvHsNSw97ykZTSUDspYhDQV1OjRJjbEjatQdySXBegZ0Q0B8m8kZSbIjVRG65Zyx6/qRSVvPE7kqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceNiYypR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CABC4CEF7;
	Wed, 14 Jan 2026 22:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768431407;
	bh=ijfh3A4w/VLFKZXz+nAlGhxsg5eknxIGI1Z1U/L1oKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceNiYypRi8PRxD6O/kbGcmhzu0g06iCsc3hxbsrO9vDNlCUA1BzYjDMo6uZtjuFub
	 RGDgpEP3wHR0lzVVMfbp9l3Ec5bfNE/cxeTSx3AgH4WQLirPrR/zUyMdH4tkDwMOp/
	 9pwLUmLewcAYzXX1IkUaq6oGnEDGb6OiAMf2WyM/Q7hksEEA/V4izZRz0C0kOe7qv6
	 2VanJjzcQSw4N0gx1VOyg2BBstfzsEHtg7aGxMyMOSIxoYcanNGxHKS8Ifk5vX3LhN
	 /4o45rhgN42t72jUkZZY6/dDYkL38llpiL95iwX9nuufywdqoMhFXfr12sPwoydDpC
	 QK/oGbaJr5CjQ==
Date: Wed, 14 Jan 2026 14:56:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/14] iomap: rename IOMAP_DIO_DIRTY to
 IOMAP_DIO_USER_BACKED
Message-ID: <20260114225646.GP15551@frogsfrogsfrogs>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074145.3396036-12-hch@lst.de>

On Wed, Jan 14, 2026 at 08:41:09AM +0100, Christoph Hellwig wrote:
> Match the more descriptive iov_iter terminology instead of encoding
> what we do with them for reads only.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 6f7036e72b23..3f552245ecc2 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -21,7 +21,7 @@
>  #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
>  #define IOMAP_DIO_NEED_SYNC	(1U << 29)
>  #define IOMAP_DIO_WRITE		(1U << 30)
> -#define IOMAP_DIO_DIRTY		(1U << 31)
> +#define IOMAP_DIO_USER_BACKED	(1U << 31)
>  
>  struct iomap_dio {
>  	struct kiocb		*iocb;
> @@ -214,7 +214,7 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
>  {
>  	struct iomap_dio *dio = bio->bi_private;
>  
> -	if (dio->flags & IOMAP_DIO_DIRTY) {
> +	if (dio->flags & IOMAP_DIO_USER_BACKED) {
>  		bio_check_pages_dirty(bio);
>  	} else {
>  		bio_release_pages(bio, false);
> @@ -330,7 +330,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>  
>  	if (dio->flags & IOMAP_DIO_WRITE)
>  		task_io_account_write(ret);
> -	else if (dio->flags & IOMAP_DIO_DIRTY)
> +	else if (dio->flags & IOMAP_DIO_USER_BACKED)
>  		bio_set_pages_dirty(bio);
>  
>  	/*
> @@ -676,7 +676,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			goto out_free_dio;
>  
>  		if (user_backed_iter(iter))
> -			dio->flags |= IOMAP_DIO_DIRTY;
> +			dio->flags |= IOMAP_DIO_USER_BACKED;
>  
>  		ret = kiocb_write_and_wait(iocb, iomi.len);
>  		if (ret)
> -- 
> 2.47.3
> 
> 

