Return-Path: <linux-fsdevel+bounces-58365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FE1B2D484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 09:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730D7583500
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2104F2D3226;
	Wed, 20 Aug 2025 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa0TXD15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E12BCF46;
	Wed, 20 Aug 2025 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673807; cv=none; b=i5sxsYAa/uc24WGyQr6Cy6UiZJLIKkZQCJygMtn1T6gNLNzKeROppZDWZisHkF9LCU8AqPsDvQly++9+h5Z+cGnTGw9CvLOmHmBA7NoyqVHf3LM/mJcJxCoDdC5g46YCQyN/tRD6xJ4oFXRC8SgaWAY2LEfELezEugcLaFCZ8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673807; c=relaxed/simple;
	bh=oX3qTwyzTlmvZuMYmlAwJ5/Jlf/5idOrkvJS2GRaUKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOfv2d9uqJGR+HH3AI2ssPtXAFROzU+NiCmSWvNdYctPJWbQh8zvEk3kEaE+TQ3RTuYgdwuLOA/Tee4R8T2SMZfKTlAEoDis4k2fJwKmzFle7BiFlTy2banHgUHAZl50mEqThs7wd4A2ZEpfJ74522VdT3HBVWDIuooPJIu2/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa0TXD15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF00C4CEEB;
	Wed, 20 Aug 2025 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755673805;
	bh=oX3qTwyzTlmvZuMYmlAwJ5/Jlf/5idOrkvJS2GRaUKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aa0TXD15F4zX5V8delnWEBcvkXxcuvCD2ONZkpywc74GZ0hhX7AJOgTANlKi/lNA8
	 6+IKq8lF/7+BxJbd7DdwnK5Tur9uuFqqP/jH5jKmxU9mNgyfvSSwrD0rKdh8rBWxM1
	 o8NSTTIqXgFkWEjrXSiuBPivYXFLHLyjUi5wf9Cdv47I9X9AndoNS7zfwcF8GpLKyG
	 PpbOJQkFNKA7jOyxHJjREDtxzzcw7QqCFYQhYDJr/hLrcAtG28ApP87tNFjGlMJbSc
	 yueIqNt50nld6VEBfEziV+jicBh3KPg8HvIGAkGuGXIq7YdU/zck+Z7eumO+x6RCml
	 ZdQFiirCLVBcQ==
Message-ID: <e2520739-e4c2-49e7-a5b1-3b205c79ef21@kernel.org>
Date: Wed, 20 Aug 2025 16:07:18 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 3/8] block: align the bio after building it
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, djwong@kernel.org,
 linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
 Keith Busch <kbusch@kernel.org>
References: <20250819164922.640964-1-kbusch@meta.com>
 <20250819164922.640964-4-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250819164922.640964-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 1:49 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Instead of ensuring each vector is block size aligned while constructing
> the bio, just ensure the entire size is aligned after it's built. This
> makes getting bio pages more flexible to accepting device valid io
> vectors that would otherwise get rejected by alignment checks.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

[...]

> +/*
> + * Aligns the bio size to the len_align_mask, releasing any excessive bio vecs
> + * that  __bio_iov_iter_get_pages may have inserted and reverts that length for
> + * the next iteration.
> + */
> +static int bio_align(struct bio *bio, struct iov_iter *iter,
> +			    unsigned len_align_mask)
> +{
> +	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
> +
> +	if (!nbytes)
> +		return 0;
> +
> +	iov_iter_revert(iter, nbytes);
> +	bio->bi_iter.bi_size -= nbytes;
> +	while (nbytes) {
> +		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> +
> +		if (nbytes < bv->bv_len) {
> +			bv->bv_len -= nbytes;
> +			nbytes = 0;

Nit: remove the "nbytes = 0" and do a break here ?

> +		} else {
> +			bio_release_page(bio, bv->bv_page);
> +			bio->bi_vcnt--;
> +			nbytes -= bv->bv_len;
> +		}
> +	}
> +
> +	if (!bio->bi_iter.bi_size)
> +		return -EFAULT;
> +	return 0;
> +}
> +



-- 
Damien Le Moal
Western Digital Research

