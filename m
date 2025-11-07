Return-Path: <linux-fsdevel+bounces-67404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A62C3E582
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 04:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C353AA28E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28A72FCC10;
	Fri,  7 Nov 2025 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AArFEai1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488CD2FBDFE;
	Fri,  7 Nov 2025 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486109; cv=none; b=m2jSHmMf5Nui/efsXqQrSIkle13xNGJx6qQxCE4zM80zCpLF68YPUqe3IE5JG3mBIhd7VLg3qfZK5z33/3uO5EDTtLYixUR3ngM8oYlo9xGmpDA659GukEMpXXdEm1HdRHwM6Z4WiiJKQxwzfksuEruYlCmgp2iJSCe30lMg5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486109; c=relaxed/simple;
	bh=aybGlQtaizqxHm41GGb/A/kHPgiZ2DKdD6qW18vbYSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTDEEDaaPn0JsrPCIBmvLdxLh09jgucYAkzCCPvZeirkSGWRIksJTFsVSp4w7HUrY2icCHoebI6BxZ1cF10FAbVAIk0d2KU7eDpSpsQfAofOZEH1IQFHd4bcM744XzXjAe6ps52Wb4m8R4HG7t1Pxe2BtSmLYJfzHzmM+Mpemzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AArFEai1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574C7C4CEF8;
	Fri,  7 Nov 2025 03:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486108;
	bh=aybGlQtaizqxHm41GGb/A/kHPgiZ2DKdD6qW18vbYSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AArFEai1JWZvh3gNP8XXmOc05q7SzaAXjuoWU0mV5vEgOlhQmmKJVxOSjfyYixzQ3
	 vi82Fll+cAMAtHKg5Lc2nmYm35CFw6RaVGYIddIgCeVmuAmi8kPUd/YxBcEAwliYah
	 zPEU5HCIRHS7YFmStaNogEcPvh2NS1I1GhGKzUL9cZgVfMCusGEzPbZSSzj9CkDd89
	 TXbfVN7y49QKub/B1CKJMsDTvnUrR+Nng2KhsMM2MYdnmrpR1r/lQ0E2av3VPQ7hUg
	 RRxPX1oCj2I1VH6+kZC4VNVNo6mOF5i0q+LZ/0Enom+4fOBRcusaIwS0Z6M74aMIgl
	 JhJIpAzozGX8w==
Date: Thu, 6 Nov 2025 19:26:48 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/9] mempool: update kerneldoc comments
Message-ID: <20251107032648.GA16450@sol>
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093517.1603379-2-hch@lst.de>

On Fri, Oct 31, 2025 at 10:34:31AM +0100, Christoph Hellwig wrote:
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 1c38e873e546..d7c55a98c2be 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -372,18 +372,15 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
>  EXPORT_SYMBOL(mempool_resize);
>  
>  /**
> - * mempool_alloc - allocate an element from a specific memory pool
> - * @pool:      pointer to the memory pool which was allocated via
> - *             mempool_create().
> - * @gfp_mask:  the usual allocation bitmask.
> + * mempool_alloc - allocate an element from a memory pool
> + * @pool:	pointer to the memory pool
> + * @gfp_mask:	GFP_* flags.
>   *
> - * this function only sleeps if the alloc_fn() function sleeps or
> - * returns NULL. Note that due to preallocation, this function
> - * *never* fails when called from process contexts. (it might
> - * fail if called from an IRQ context.)
> - * Note: using __GFP_ZERO is not supported.
> + * Note: This function only sleeps if the alloc_fn callback sleeps or returns
> + * %NULL.  Using __GFP_ZERO is not supported.

Maybe put the note about __GFP_ZERO being unsupported directly in the
description of @gfp_mask.

>   *
> - * Return: pointer to the allocated element or %NULL on error.
> + * Return: pointer to the allocated element or %NULL on error. This function
> + * never returns %NULL when @gfp_mask allows sleeping.

Is "allows sleeping" exactly the same as "__GFP_DIRECT_RECLAIM is set"?
The latter is what the code actually checks for.

>  /**
> - * mempool_free - return an element to the pool.
> - * @element:   pool element pointer.
> - * @pool:      pointer to the memory pool which was allocated via
> - *             mempool_create().
> + * mempool_free - return an element to a mempool
> + * @element:	pointer to element
> + * @pool:	pointer to the memory pool
> + *
> + * Returns @elem to @pool if its needs replenishing, else free it using
> + * the free_fn callback in @pool.
>   *
> - * this function only sleeps if the free_fn() function sleeps.
> + * This function only sleeps if the free_fn callback sleeps.
>   */
>  void mempool_free(void *element, mempool_t *pool)

"if its needs" => "if it needs" and "@elem" => "@element"

- Eric

