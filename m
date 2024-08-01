Return-Path: <linux-fsdevel+bounces-24721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8195A94408E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 04:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71515B2414D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 01:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58301332A1;
	Thu,  1 Aug 2024 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AffpXN67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF8200A3;
	Thu,  1 Aug 2024 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474595; cv=none; b=HhfamAEKzlvopxum+gphajU4c/BaFW84w5PJnedu4fqJ5MJXisx3ul8xoatB68EXpbclsxD6y+Hj98Laq6HAFf+BEZEyAm0xUfpLYfaDmU94n2wP99BPnvdDdWC9cFTCp/I/lE5ofvQwHQSZaP5DS7uK5MMbQcg4uad60t35+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474595; c=relaxed/simple;
	bh=qhsAo2ibH7djtNeXhPFIuXx4A0vb5UzzHc/vePKTiLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnsOHNf8xDy29zUyUsEqJbNqR7+sLr4D/6CIy54r+2q1iCGjY4XfvOjOTav9wmmDWgsW0fTzujdhATw6Hd84/ukwKowEgguPdboix8UGpxlIpWAh2tn1swTJBA4CZWWkliNhWBcJ276r60gEpD0NYjpOjIPupj0dB3pBwM4c6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AffpXN67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F288C116B1;
	Thu,  1 Aug 2024 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722474594;
	bh=qhsAo2ibH7djtNeXhPFIuXx4A0vb5UzzHc/vePKTiLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AffpXN67+pPQRqJDhAIkSoZgijCKAAGva0tLUoypSgL6XS7H0cpF770wqaIexgCe0
	 Lt5SYdy8RXCjcu3bIUeUJ2tsbhECHddD2nWAewBY2qzeBGgC6XVJ1fNWNURXJq4fLK
	 VzyHwZARjs1DAh3776Angzju5NkVSuIKnN+L1D5UDxl+4zsIpiB6xasLxC4nt4nZ4t
	 kV9lYT2QHXDmUGq+mPijY9HfDZR1F5ynsdAuyEGJ/2xRxWL10PcQg5ABe0arCIsUl5
	 T8tbTlsLZ+eKt02R2Bk6P9QpLQYqTbvIqIovRzuv1VDpXL/O3Hp7O95J4DV6XtoLWS
	 Pi8Hrd51H0G2A==
Date: Thu, 1 Aug 2024 01:09:53 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Richard Fung <richardfung@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] fuse: fs-verity: aoid out-of-range comparison
Message-ID: <20240801010953.GA1835661@google.com>
References: <20240730142802.1082627-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730142802.1082627-1-arnd@kernel.org>

On Tue, Jul 30, 2024 at 04:27:52PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang points out that comparing the 16-bit size of the digest against
> SIZE_MAX is not a helpful comparison:
> 
> fs/fuse/ioctl.c:130:18: error: result of comparison of constant 18446744073709551611 with expression of type '__u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
>             ~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This either means tha tthe check can be removed entirely, or that the
> intended comparison was for the 16-bit range. Assuming the latter was
> intended, compare against U16_MAX instead.
> 
> Fixes: 9fe2a036a23c ("fuse: Add initial support for fs-verity")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/fuse/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index 572ce8a82ceb..5711d86c549d 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -127,7 +127,7 @@ static int fuse_setup_measure_verity(unsigned long arg, struct iovec *iov)
>  	if (copy_from_user(&digest_size, &uarg->digest_size, sizeof(digest_size)))
>  		return -EFAULT;
>  
> -	if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
> +	if (digest_size > U16_MAX - sizeof(struct fsverity_digest))
>  		return -EINVAL;
>  
>  	iov->iov_len = sizeof(struct fsverity_digest) + digest_size;

I think this was just defensive coding to ensure that the assignment to iov_len
can't overflow regardless of the type of digest_size.  You can remove the check
if you want to, though isn't the tautological comparison warning disabled by the
kernel build system anyway?  Anyway, it does not make sense to use U16_MAX here.

- Eric

