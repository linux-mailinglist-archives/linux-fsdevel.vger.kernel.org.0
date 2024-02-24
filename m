Return-Path: <linux-fsdevel+bounces-12641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF724862216
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 02:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B91283D4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63767DDCB;
	Sat, 24 Feb 2024 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TVYB3G0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD28CA4A;
	Sat, 24 Feb 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739432; cv=none; b=uaJ/5lP+CXmcr6E7ruR2BHnIoyFoozwmx8csFEOmzY8G+bNaKkey9o2NGXnixzpLPPKHw84SOgSbKXGpjA7IiDKdLWQCIWa6JLf52n/5hjLxgjHcaSn5PYdkkrS69LsISpiWEK4w1fZZ9PLp/Ut8UOhymartqmz9NVJJD4HdDXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739432; c=relaxed/simple;
	bh=xi6nVk0C04NkzR7H2GZk/dICTy1LUs3OH0IEQVV1NDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSTFGLQYGTjq0D6gqAUqR7yf9Niux7r7ApalwB9ERo63n8kBBNrSM2F8LUkYZ71wvNjZPRLsCELhWyw/ynTOJ6a+H8ZX6dskOGWjOEU0JRSgwf0OYylbdpXHOlxGUPKs/al9vAShYjFUrtbeZW7ObT3zI+GT1L4D/Sel+WwOMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TVYB3G0c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=06UnnJyhnElyuP2IJrtOSRTp1BF1dFG21xSI11X6/3g=; b=TVYB3G0c87xVqJOIVHuyTu8RtT
	fDG2tL0IzR9zpeos133a6nAsWtGMB4xc2zcpXBEKl7OopDPtSiayNNt3Dc6wgo6x5N4AwqFfkJUDU
	cwKAJW3PqqcytmKt/8vjUHPnuHYjwapv0JpBW6x7ZViJOfGM3GuxGaRtWKKIM1u6VJqhNp6gc1c9N
	okBZ/NHOYZinVgYsOcUFmvUkArxlD6/o1aM7zdeo19BxJ1Lt0wc03VApp71yd8x8xp/R+OR39ro1r
	aVA+z1/Xn7tE9md4VocP5NoEciGjGg8kQa/k2stXGYmlTvlj/cXU0FWCywXf7TiXFmAJ0y7+1qCGp
	Lnf++ZSQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdhBL-0000000BpTS-26Er;
	Sat, 24 Feb 2024 01:50:27 +0000
Message-ID: <161f53c9-65ba-422d-b08e-2e5d88a208a2@infradead.org>
Date: Fri, 23 Feb 2024 17:50:26 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/20] famfs: Add Kconfig and Makefile plumbing
Content-Language: en-US
To: John Groves <John@Groves.net>, John Groves <jgroves@micron.com>,
 Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Cc: john@jagalactic.com, Dave Chinner <david@fromorbit.com>,
 Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com,
 gregory.price@memverge.com
References: <cover.1708709155.git.john@groves.net>
 <1225d42bc8756c016bb73f8a43095a384b08524a.1708709155.git.john@groves.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1225d42bc8756c016bb73f8a43095a384b08524a.1708709155.git.john@groves.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/23/24 09:42, John Groves wrote:
> Add famfs Kconfig and Makefile, and hook into fs/Kconfig and fs/Makefile
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/Kconfig        |  2 ++
>  fs/Makefile       |  1 +
>  fs/famfs/Kconfig  | 10 ++++++++++
>  fs/famfs/Makefile |  5 +++++
>  4 files changed, 18 insertions(+)
>  create mode 100644 fs/famfs/Kconfig
>  create mode 100644 fs/famfs/Makefile
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 89fdbefd1075..8a11625a54a2 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -141,6 +141,8 @@ source "fs/autofs/Kconfig"
>  source "fs/fuse/Kconfig"
>  source "fs/overlayfs/Kconfig"
>  
> +source "fs/famfs/Kconfig"
> +
>  menu "Caches"
>  
>  source "fs/netfs/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index c09016257f05..382c1ea4f4c3 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -130,3 +130,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
>  obj-$(CONFIG_EROFS_FS)		+= erofs/
>  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
>  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> +obj-$(CONFIG_FAMFS)             += famfs/
> diff --git a/fs/famfs/Kconfig b/fs/famfs/Kconfig
> new file mode 100644
> index 000000000000..e450928d8912
> --- /dev/null
> +++ b/fs/famfs/Kconfig
> @@ -0,0 +1,10 @@
> +
> +
> +config FAMFS
> +       tristate "famfs: shared memory file system"
> +       depends on DEV_DAX && FS_DAX
> +       help
> +         Support for the famfs file system. Famfs is a dax file system that
> +	 can support scale-out shared access to fabric-attached memory
> +	 (e.g. CXL shared memory). Famfs is not a general purpose file system;
> +	 it is an enabler for data sets in shared memory.

Please use one tab + 2 spaces to indent help text (below the "help" keyword)
as documented in Documentation/process/coding-style.rst.

> diff --git a/fs/famfs/Makefile b/fs/famfs/Makefile
> new file mode 100644
> index 000000000000..8cac90c090a4
> --- /dev/null
> +++ b/fs/famfs/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_FAMFS) += famfs.o
> +
> +famfs-y := famfs_inode.o famfs_file.o

-- 
#Randy

