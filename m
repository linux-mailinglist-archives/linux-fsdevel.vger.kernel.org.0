Return-Path: <linux-fsdevel+bounces-28617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791796C6B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22A21F271B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95C1E4102;
	Wed,  4 Sep 2024 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bdIOm6mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A771DA319;
	Wed,  4 Sep 2024 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475748; cv=none; b=qt+0Dm0A2qRXXVNSIMnvzvDywk9CJTQiCDcwPztkfvYvz6o8aSsyY7ke8T/aPa2lSGE5f0t8Cfb4lG4QGG6wT6+o3cUZXLnI3jJ5dlYpRgbcgYv/DE8+Jb/nX1oDfE+AbhBvhf353euMsvIfrygA7Db2A7TUg7oE0T1dQalrjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475748; c=relaxed/simple;
	bh=ApmWLbLcEQSXRsPXYH3SXfjZpbujIr9o5LmOAI4rS+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C25l49v3xXiYVER1UNnS5CWslmIRjPYBOuIaeWDtP8mS8IaymbQt1Rcocm92sJpQlTRk4BXVI4mu6pe8HNzPcVRtxUQtNc1Mt542M/fDpg9gESdeBndOG6MmAsRt5ngBsR3iG+V2KF2Dj1apbt6l/jkq+5Cf7Ama1Jv1Glegsow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bdIOm6mc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725475741;
	bh=ApmWLbLcEQSXRsPXYH3SXfjZpbujIr9o5LmOAI4rS+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdIOm6mczsOIIwRmDhQ6HYRAOALg+RsD4kqLDGeXDmJUXNmaUORY4m4y/Z327hivs
	 gWrpmTk+YHvblVYvVizcpQZHlVNj82Vrav0yq0VEHtfJBm6svSP+obypUySqQ+kPSc
	 3WJiT/72um3LCZbQBxdC0AyY8lbK2mCPRuA/tJ+A=
Date: Wed, 4 Sep 2024 20:49:01 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/23] initrd: mark initrd support as deprecated
Message-ID: <70ab2c0f-ca6b-441a-8d28-8597724e4013@t-8ch.de>
References: <20200714190427.4332-1-hch@lst.de>
 <20200714190427.4332-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714190427.4332-15-hch@lst.de>

Hi,

On 2020-07-14 21:04:18+0000, Christoph Hellwig wrote:
> The classic initial ramdisk has been replaced by the much more
> flexible and efficient initramfs a long time.  Warn about it being
> removed soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  init/do_mounts_initrd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
> index 57ad5b2da8f5f5..e08669187d63be 100644
> --- a/init/do_mounts_initrd.c
> +++ b/init/do_mounts_initrd.c
> @@ -75,6 +75,8 @@ static void __init handle_initrd(void)
>  	extern char *envp_init[];
>  	int error;
>  
> +	pr_warn("using deprecated initrd support, will be removed in 2021.\n");
> +

I stumbled upon this today.
Apparently the "soon" never happened in 2021.

If this is still meant to happen I can send a series to remove it.

>  	real_root_dev = new_encode_dev(ROOT_DEV);
>  	create_dev("/dev/root.old", Root_RAM0);
>  	/* mount initrd on rootfs' /root */
> -- 
> 2.27.0

