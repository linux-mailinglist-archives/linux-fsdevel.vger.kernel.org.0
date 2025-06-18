Return-Path: <linux-fsdevel+bounces-52028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46AADE90C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 12:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122EF4054CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6167828A70D;
	Wed, 18 Jun 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM2RbvzL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801B28A1DE;
	Wed, 18 Jun 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242411; cv=none; b=einyedjsxDEcR+ApDlr9yQQcC/h/rp4xbhfqsW5ono8rxEBgUn4nvm0ndNqVla19KTLx8uXsT6gTCPMOrr9Gzumdul8P7wCqg1/QIQ2zhGS6xWYp8B3mLSMvGZcasVilcSFOjl7PxFDK3UaMGzpPLty4neXVlCinCy34b3zgA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242411; c=relaxed/simple;
	bh=t9YTMjcFoRPKCBEtoXpkY5oOZ5Xw6/T8Pr/WAK5wAFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuiVg8eQlgUcpEAJvFuGHH8eWjlDrYwhQD+oFeDDovIuJyH4N5/xS7h5mDQMVN8g+R5CRmZ2rqzzOAF9wIDjyiH/9j64CieRSl1bvcKJQ18Cbt/T6s7vMdHl/S/v8dkGp0QkHRqPkvzZSpW5r6kw3n/mmC5ZjUo/s8cCkP5unoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM2RbvzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8295CC4CEE7;
	Wed, 18 Jun 2025 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750242411;
	bh=t9YTMjcFoRPKCBEtoXpkY5oOZ5Xw6/T8Pr/WAK5wAFc=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vM2RbvzLncp47uUBkXnx/3BLw+Fd/VI1m33D/ORr34N6cIWMPR5izYI8q12G9etHg
	 +ylIUK+kzhEcpIzLGF3oCX9akl4qR0T0Re4HYvzrvBbuNADqH6PB2R/3hNSxnTkRIS
	 MmL+hDRiXNZz9Om/y8DpgANI0/KmKLKRn0uNmKACNtl/u2Qrytq4V2lLmUQl5NoysU
	 YgwneZjWOUNiIFYxn9cxOfybQ57SRLfeehAkzlsMUhxusXy55K/YscdIkyqv64jtQt
	 9Nxm8q/IV6Fj47HwCH92pqcoLoIP+w2SuuuxWfu7rfhFyeIcwCIF6iXAz+aQCy/aPR
	 3JvHR6OUHU8Cg==
Message-ID: <6a4eb76e-a203-4be1-9816-09c25b76db4b@kernel.org>
Date: Wed, 18 Jun 2025 12:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2] fs/buffer: remove comment about hard sectorsize
To: Pankaj Raghav <p.raghav@samsung.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>
Cc: kernel@pankajraghav.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250618075821.111459-1-p.raghav@samsung.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250618075821.111459-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2025 09.58, Pankaj Raghav wrote:
> Commit e1defc4ff0cf ("block: Do away with the notion of hardsect_size")
> changed hardsect_size to logical block size. The comment on top still
> says hardsect_size.
> 
> Remove the comment as the code is pretty clear. While we are at it,
> format the relevant code.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/buffer.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 8cf4a1dc481e..a14d281c6a74 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1122,9 +1122,8 @@ __getblk_slow(struct block_device *bdev, sector_t block,
>  {
>  	bool blocking = gfpflags_allow_blocking(gfp);
>  
> -	/* Size must be multiple of hard sectorsize */
> -	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
> -			(size < 512 || size > PAGE_SIZE))) {
> +	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> +		     (size < 512 || size > PAGE_SIZE))) {

Nit: Would it make sense to use SECTOR_SIZE here instead of the hard-coded 512?

>  		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
>  					size);
>  		printk(KERN_ERR "logical block size: %d\n",
> 
> base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

