Return-Path: <linux-fsdevel+bounces-60602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42097B49DE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 02:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5601E188AC7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 00:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691D4AEE2;
	Tue,  9 Sep 2025 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOWLOxo4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24E14286;
	Tue,  9 Sep 2025 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376889; cv=none; b=hTRkxCQmtkmq2MMGDZ10ZbNlbDMnp36Z9gzkhOsi+l2NplCyBMO3vHDjxMCZ/j1dnq5Ud8HiKPD8OjDw5x3aEbiMKXBzuk0uAMEXAgPEaNa7D4WQtafst54FkwLL+xJ3qa1N+ndpVorySYPD1C4YsDg8FMpC5IhgxJj2UmPRgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376889; c=relaxed/simple;
	bh=HTsCb1oDiC0QvYoU0wK26hVLcTbGDrlmKN2iL0nK59Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LleKrGoXl1VMbO0VeOIM/tqftqTAPleQpYIr8iNA1VdUxO2Iv+WMuQUpayM9o4Dd+4vDvwChQF0POCs6nOwgEpte9QAie45FICCVcshD6ujSZM8vdPF8BmuZXiNDxavkdg1Uf4hYd0I+dnwVIh/cOYKPifNbtYGh2Cw3ZtCEeis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOWLOxo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C20C4CEF1;
	Tue,  9 Sep 2025 00:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757376889;
	bh=HTsCb1oDiC0QvYoU0wK26hVLcTbGDrlmKN2iL0nK59Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOWLOxo4BzWDRUTrIyczukYbrDUi6BpGVpqF02LfVogMJjDzTgu3zKAIJw/24vuhl
	 JuBmK+DeME4iDYrssJTvZytKoo3/HNJ8ZHNOWQNFo4Z9j+2pxdz0a9VuvcbhTg8BzY
	 JNcxEgjTlcPeF0PHAmAPQlXzYOtkupbyeEHR26QhpokNikwMeN2YFrUPSha4oliOKc
	 yWVx6heegbO8GTlN1ZOOJZ/+TmR1ELaqBVSlvNGivewbF1rguAYWAexRIVnxckpgK3
	 CNE8r+6ygI/jfJ613WpJLiiarxIOUw/Ey+eSN1/WxFI0Y0ULHg5mP7Jov/SR0ztYhY
	 mXdEL5L7ST2ew==
Date: Tue, 9 Sep 2025 08:14:39 +0800
From: Gao Xiang <xiang@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, djwong@kernel.org,
	hch@infradead.org
Cc: brauner@kernel.org, miklos@szeredi.hu, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 11/16] iomap: add caller-provided callbacks for read
 and readahead
Message-ID: <aL9xb5Jw8tvIRMcQ@debian>
Mail-Followup-To: Joanne Koong <joannelkoong@gmail.com>, djwong@kernel.org,
	hch@infradead.org, brauner@kernel.org, miklos@szeredi.hu,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-12-joannelkoong@gmail.com>

Hi Joanne,

On Mon, Sep 08, 2025 at 11:51:17AM -0700, Joanne Koong wrote:
> Add caller-provided callbacks for read and readahead so that it can be
> used generically, especially by filesystems that are not block-based.
> 
> In particular, this:
> * Modifies the read and readahead interface to take in a
>   struct iomap_read_folio_ctx that is publicly defined as:
> 
>   struct iomap_read_folio_ctx {
> 	const struct iomap_read_ops *ops;
> 	struct folio *cur_folio;
> 	struct readahead_control *rac;
> 	void *private;
>   };
> 
>   where struct iomap_read_ops is defined as:
> 
>   struct iomap_read_ops {
>       int (*read_folio_range)(const struct iomap_iter *iter,
>                              struct iomap_read_folio_ctx *ctx,
>                              loff_t pos, size_t len);
>       int (*read_submit)(struct iomap_read_folio_ctx *ctx);
>   };
> 

No, I don't think `struct iomap_read_folio_ctx` has another
`.private` makes any sense, because:

 - `struct iomap_iter *iter` already has `.private` and I think
   it's mainly used for per-request usage; and your new
   `.read_folio_range` already passes
    `const struct iomap_iter *iter` which has `.private`
   I don't think some read-specific `.private` is useful in any
   case, also below.

 - `struct iomap_read_folio_ctx` cannot be accessed by previous
   .iomap_{begin,end} helpers, which means `struct iomap_read_ops`
   is only useful for FUSE read iter/submit logic.

Also after my change, the prototype will be:

int iomap_read_folio(const struct iomap_ops *ops,
		     struct iomap_read_folio_ctx *ctx, void *private2);
void iomap_readahead(const struct iomap_ops *ops,
		     struct iomap_read_folio_ctx *ctx, void *private2);

Is it pretty weird due to `.iomap_{begin,end}` in principle can
only use `struct iomap_iter *` but have no way to access
` struct iomap_read_folio_ctx` to get more enough content for
read requests.

Thanks,
Gao Xiang

