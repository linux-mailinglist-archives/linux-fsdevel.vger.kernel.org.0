Return-Path: <linux-fsdevel+bounces-59698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95CCB3C736
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 03:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D4A568657
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F7244687;
	Sat, 30 Aug 2025 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uriF07YL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33802AE89;
	Sat, 30 Aug 2025 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756518868; cv=none; b=m2aJPxNhYUFOmKgyWcXvnCE+d9cBQmMl1yv5LiI2dtNSf/rqPtD224j1EuINCvzkyVHSHBh+oBWO0Xx9F6DaCVadSEtoeknXXjmV7WSP3QT9IR+UnbhnBGkn5pEn6DKbXxW6OYvxYvtcMN6BFemDvrFz+SkMNjzqqUCcU1dJ+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756518868; c=relaxed/simple;
	bh=4bT8b30BNHVy7B1e3+UjgAydd+tzAM6C7InIzM7W1TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS+q5NsnjMRS2Defoc3V/l4/ZKhKL3PlCdFLT2yUJItCDaKwvoDYHUJHWnhTDRBHnEkSmLJ3gbcdZaEyiyOvaWzxAvrOPxDZafUs/Tldc1FwreumQEboul+kKJQ91Sw49Z0t8joWhTuvAs4yhznUxXAVGIFVx3iUQj6OA3tkyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uriF07YL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CD6C4CEF7;
	Sat, 30 Aug 2025 01:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756518868;
	bh=4bT8b30BNHVy7B1e3+UjgAydd+tzAM6C7InIzM7W1TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uriF07YLsKoEGiQsmdne7MizqXD3nzanrdYQDjIoEoQDewVrld4TCm+aMhX2BvWmp
	 rQS7WY+Eo5vWo1me3zhH+mlkgX6wifofEsuWMMQrOi/dDkLVckfssmT+BGFTRPf2Al
	 /QoLW6nYBj7REoLQHOQydDjGCDtCnMb6RalCozrCL25ypGkX2vOaWaNLz1Km1UFxA5
	 YZsQSJlFuvfnxlIri84xs5F4h0oEfJGT7CObJVLhgGBCMbvrlx0xhf1ZCCVAEEPDJ1
	 GR21JJhxLHrRBjm5utNOwwJKMc570+ynN2Tu5w/KoADBQQ1n+lPEpYg1K0gJWcrvJS
	 Jp6TTGrEqlpyg==
Date: Sat, 30 Aug 2025 09:54:07 +0800
From: Gao Xiang <xiang@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 13/16] iomap: add a private arg for read and readahead
Message-ID: <aLJZv5L6q0FH5F8a@debian>
Mail-Followup-To: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu, hch@infradead.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-14-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-14-joannelkoong@gmail.com>

Hi Joanne,

On Fri, Aug 29, 2025 at 04:56:24PM -0700, Joanne Koong wrote:
> Add a void *private arg for read and readahead which filesystems that
> pass in custom read callbacks can use. Stash this in the existing
> private field in the iomap_iter.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  block/fops.c           | 4 ++--
>  fs/erofs/data.c        | 4 ++--
>  fs/gfs2/aops.c         | 4 ++--
>  fs/iomap/buffered-io.c | 8 ++++++--
>  fs/xfs/xfs_aops.c      | 4 ++--
>  fs/zonefs/file.c       | 4 ++--
>  include/linux/iomap.h  | 4 ++--
>  7 files changed, 18 insertions(+), 14 deletions(-)
> 

...

>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> -		const struct iomap_read_ops *read_ops)
> +		const struct iomap_read_ops *read_ops, void *private)
>  {
>  	struct iomap_iter iter = {
>  		.inode		= folio->mapping->host,
>  		.pos		= folio_pos(folio),
>  		.len		= folio_size(folio),
> +		.private	= private,
>  	};

Will this whole work be landed for v6.18?

If not, may I ask if this patch can be shifted advance in this
patchset for applying separately (I tried but no luck).

Because I also need some similar approach for EROFS iomap page
cache sharing feature since EROFS uncompressed I/Os go through
iomap and extra information needs a proper way to pass down to 
iomap_{begin,end} with extra pointer `.private` too.

Thanks,
Gao Xiang

