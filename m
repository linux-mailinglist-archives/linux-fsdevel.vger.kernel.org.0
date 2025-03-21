Return-Path: <linux-fsdevel+bounces-44695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C9A6B6CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 10:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5862F3B6C06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD11EB5F4;
	Fri, 21 Mar 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yhmPJ9/m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wkXp5JlQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C65374EA;
	Fri, 21 Mar 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548606; cv=none; b=qKjSNq3OnV3xcQAJxgkg8bNEO5Huxndb59Uu3/AlnpeN0QesdVm/Nr0BPQ92dY1mTS7RnnwQ5UioEHZvz4AIyyclGTXypidTWOQOPhET33cLtYOYsurhHpo+emVn7YLALfNvjFk2TSnaPFIrzDqwT1YHYKSp3SLRITjWWqXdsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548606; c=relaxed/simple;
	bh=xoNsETAwGnGqUy6v0axtvhEcA08DUOVN0nuY6ulJ9T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3TpyRd/vvIg02scPp0eTDFOhSf9cBcGJfRyjyrDSjd2CfHpHBsOXnlvqSWIreu4EyzJoeb/7FREgXBqKZhtM1U1rdfa+h0HAQFMa7Z1RgB1QcOFvgNB/TEDULgDA3xa5rixS3EwtqqzIp40BsPbtldhD8XZOFsXc1ZEbh1H0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yhmPJ9/m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wkXp5JlQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Mar 2025 10:16:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742548602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOlK+eL5r3AeVJKFxqRBPjUBz8BosDtwVqbakwZyR5o=;
	b=yhmPJ9/mxAs/zmob5oDztYhhJWRpID2yT3FffkinffCRdNMaO1oz2TLNCzmOiY0DwGJCpP
	2mUiQ3uVhUzouwZMr3hSbt196mg7NtspIFEdYWsaKRYe/SKvvKJOp9hTHpz7iF1KPLGsyO
	EQu9yHycOHVeyAyDWDl0tden8hs1nSz9bkBVJaqljV9PkgMjixNoy+qhEG5E0VS52vZx65
	4YfHqgujRbhU00OTqp0oJ7OxDNE9kCcscnzGgIrFb7lInYhzh4x7hoFsU3YDkK9h4pliqV
	tLtWpljyyuIsRvTbp2xc5HmMbBz2rDQTePPKEN0XXnzgBPIMomJr7iuyVZkSSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742548602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOlK+eL5r3AeVJKFxqRBPjUBz8BosDtwVqbakwZyR5o=;
	b=wkXp5JlQlBpwQcG9aAHc/DRX7H1HkmXg1y4UG7AYkvLjDXoNvVqGNqjMnQQ/OR7tlzCNXJ
	NVDacZNzjnehdjAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: support erofs as initrd
Message-ID: <20250321101029-8a3a1fea-223a-42c3-8528-a3239fb4b24e@linutronix.de>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>

On Thu, Mar 20, 2025 at 08:28:23PM +0100, Julian Stecklina via B4 Relay wrote:
> From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> 
> Add erofs detection to the initrd mount code. This allows systems to
> boot from an erofs-based initrd in the same way as they can boot from
> a squashfs initrd.
> 
> Just as squashfs initrds, erofs images as initrds are a good option
> for systems that are memory-constrained.
> 
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> ---
>  init/do_mounts_rd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index ac021ae6e6fa78c7b7828a78ab2fa3af3611bef3..7c3f8b45b5ed2eea3c534d7f2e65608542009df5 100644
> --- a/init/do_mounts_rd.c
> +++ b/init/do_mounts_rd.c
> @@ -11,6 +11,7 @@
>  
>  #include "do_mounts.h"
>  #include "../fs/squashfs/squashfs_fs.h"
> +#include "../fs/erofs/erofs_fs.h"
>  
>  #include <linux/decompress/generic.h>
>  
> @@ -47,6 +48,7 @@ static int __init crd_load(decompress_fn deco);
>   *	romfs
>   *	cramfs
>   *	squashfs
> + *	erofs
>   *	gzip
>   *	bzip2
>   *	lzma
> @@ -63,6 +65,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
>  	struct romfs_super_block *romfsb;
>  	struct cramfs_super *cramfsb;
>  	struct squashfs_super_block *squashfsb;
> +	struct erofs_super_block *erofsb;
>  	int nblocks = -1;
>  	unsigned char *buf;
>  	const char *compress_name;
> @@ -77,6 +80,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
>  	romfsb = (struct romfs_super_block *) buf;
>  	cramfsb = (struct cramfs_super *) buf;
>  	squashfsb = (struct squashfs_super_block *) buf;
> +	erofsb = (struct erofs_super_block *) buf;
>  	memset(buf, 0xe5, size);
>  
>  	/*
> @@ -165,6 +169,21 @@ identify_ramdisk_image(struct file *file, loff_t pos,
>  		goto done;
>  	}
>  
> +	/* Try erofs */
> +	pos = (start_block * BLOCK_SIZE) + EROFS_SUPER_OFFSET;
> +	kernel_read(file, buf, size, &pos);
> +
> +	if (erofsb->magic == EROFS_SUPER_MAGIC_V1) {

le32_to_cpu(erofsb->magic)

> +		printk(KERN_NOTICE
> +		       "RAMDISK: erofs filesystem found at block %d\n",
> +		       start_block);
> +
> +		nblocks = ((erofsb->blocks << erofsb->blkszbits) + BLOCK_SIZE - 1)
> +			>> BLOCK_SIZE_BITS;

le32_to_cpu(erofsb->blocks)

> +
> +		goto done;
> +	}
> +
>  	printk(KERN_NOTICE
>  	       "RAMDISK: Couldn't find valid RAM disk image starting at %d.\n",
>  	       start_block);
> 

This seems to be broken for cramfs and minix, too.


Thomas

