Return-Path: <linux-fsdevel+bounces-60209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978C4B42B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572D17C491B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A336B3112C4;
	Wed,  3 Sep 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWdEW7bK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0953B2D46CB;
	Wed,  3 Sep 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932265; cv=none; b=ZDRInsMbj3RcH96uGl8bBt9XtdGUa+wLXrVgvbMQC8Ou1fC17uBR7CSppD95NMy7Re724/0ThInoxsXnfldORzTS/Ht/HlNSZU56cIj84zuPXx8nMo/wxN03ILUE7oBPRz7rVfhJXlkLSzeph0i8d+5Q3IQAu5cZAvVQ586xU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932265; c=relaxed/simple;
	bh=IxxiMTaQgwOHVsT2m5W7178Bx/SUs3qe0M0lyVcgi04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNXmw6O4sjA+FIC7fSmzOTYN1QDZOTt9d1bp1HDHeR2iIVJa6ukHhzgMKREp7Tgb+MiUyuoDFAtxsvANe5Yl7sqzcUiPlIIoYadxqZkPwfZCmXUjNZ+WlDHxo0LiO+NgtsHkQxpEHui+aZbtb4UnMknsnTXRcQi6KYE9Erf46+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWdEW7bK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A11C4CEE7;
	Wed,  3 Sep 2025 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932264;
	bh=IxxiMTaQgwOHVsT2m5W7178Bx/SUs3qe0M0lyVcgi04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWdEW7bKz8AQIhXRG8AFGbpSnSyczDs5crI9iw+Ynnq0pH5+HdawtKm3fAIpjgTTx
	 a8DYK8gNWiEPVjbRVccQUZI5fSj+mxv2AXxLFnzbLMuchylSG3BQ2CITE6Olsn0eim
	 QqeVLQlNFzHz1JXw1WI8iLCjhdn7SoQWFtyNpdWQb+4V5YrHMOGXkbgGRCLz30X3Fh
	 6uLYq/PYn5i2pYwwXS+FKosJIr/vEqO3VYqLwQLpWM0+qcpyqB/1NMarSndHdZf7/I
	 s5+Una/rXROLGa44jye5C2I5xnB8f+iyFoEghe3XnPePiyw2m/zSlYPEJi6ihb+sVb
	 ArxBkhYVG45Cw==
Date: Wed, 3 Sep 2025 13:44:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 09/16] iomap: rename iomap_readpage_ctx struct to
 iomap_readfolio_ctx
Message-ID: <20250903204424.GP1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-10-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-10-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:20PM -0700, Joanne Koong wrote:
> ->readpage was deprecated and reads are now on folios.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

For this and the previous rename patches,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 743112c7f8e6..a3a9b6146c2f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -317,7 +317,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
>  	return 0;
>  }
>  
> -struct iomap_readpage_ctx {
> +struct iomap_readfolio_ctx {
>  	struct folio		*cur_folio;
>  	bool			folio_unlocked;
>  	struct readahead_control *rac;
> @@ -357,7 +357,7 @@ static void iomap_read_end_io(struct bio *bio)
>  }
>  
>  static void iomap_read_folio_range_async(struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
> +		struct iomap_readfolio_ctx *ctx, loff_t pos, size_t plen)
>  {
>  	struct folio *folio = ctx->cur_folio;
>  	const struct iomap *iomap = &iter->iomap;
> @@ -426,7 +426,7 @@ static void iomap_readfolio_submit(const struct iomap_iter *iter)
>  }
>  #else
>  static void iomap_read_folio_range_async(struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx, loff_t pos, size_t len)
> +		struct iomap_readfolio_ctx *ctx, loff_t pos, size_t len)
>  {
>  	WARN_ON_ONCE(1);
>  }
> @@ -445,7 +445,7 @@ static void iomap_readfolio_submit(const struct iomap_iter *iter)
>  #endif /* CONFIG_BLOCK */
>  
>  static int iomap_readfolio_iter(struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx)
> +		struct iomap_readfolio_ctx *ctx)
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	loff_t pos = iter->pos;
> @@ -491,7 +491,7 @@ static int iomap_readfolio_iter(struct iomap_iter *iter,
>  }
>  
>  static void iomap_readfolio_complete(const struct iomap_iter *iter,
> -		const struct iomap_readpage_ctx *ctx)
> +		const struct iomap_readfolio_ctx *ctx)
>  {
>  	iomap_readfolio_submit(iter);
>  
> @@ -506,7 +506,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  		.pos		= folio_pos(folio),
>  		.len		= folio_size(folio),
>  	};
> -	struct iomap_readpage_ctx ctx = {
> +	struct iomap_readfolio_ctx ctx = {
>  		.cur_folio	= folio,
>  	};
>  	int ret;
> @@ -523,7 +523,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
>  static int iomap_readahead_iter(struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx)
> +		struct iomap_readfolio_ctx *ctx)
>  {
>  	int ret;
>  
> @@ -567,7 +567,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  		.pos	= readahead_pos(rac),
>  		.len	= readahead_length(rac),
>  	};
> -	struct iomap_readpage_ctx ctx = {
> +	struct iomap_readfolio_ctx ctx = {
>  		.rac	= rac,
>  	};
>  
> -- 
> 2.47.3
> 
> 

