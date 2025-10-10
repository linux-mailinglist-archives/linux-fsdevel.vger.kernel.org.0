Return-Path: <linux-fsdevel+bounces-63804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BBCBCE659
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 21:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E65543541
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F99F30146F;
	Fri, 10 Oct 2025 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4DtP1zW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD531D6193;
	Fri, 10 Oct 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124691; cv=none; b=aTihdudJj5RkQ/gqgcsYHVtjYRy46OpxX4AqrvCaknqL4ofOphpuhuZOMMbXxu5izlWGMMU7Cl3EBAPshxJht+yXurkWJq9IqFFRk3IF9MA5Zoig1/+hoc+hEKma6Oz3QWFfACI+231uCoY8BoFeYw9yrEh6lCQAMUTpFh1mcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124691; c=relaxed/simple;
	bh=AiHgADCO575LW3Jd7nNp0VaAAqwI7NoyKpnJZKEjRNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1nlNCr8ge9BgMV1re6mdCNuEKmFczV6jlELXEbEzksmrFykCR/+KQWcWxH1FEofGG9rfdzyM4nvg4nYVP0am7wSsS7Ko8ZlwUVnUpyPqnBc8XGVLYu6txNNwlgjYo2AaEcvVpGCR0IIxDQf2gBagtxZrJMIYTdyoTTHya0WxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4DtP1zW4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PCNi5/OuVnRwhbzGyuTsh6ukiwTm+O6EJKLlJ1B2gEw=; b=4DtP1zW44Vb6QBKbJyt2gzFny1
	yvoH5OtVcCy5Ms02majpKQ1uofu1fe3sIP/2IwWe1pCnQE1bX/8S8BSzkwIvvlSHeCqkZdgpfQzr9
	l1DJFzOWWnoL1D328ZjMcbAmNQAJvPWCjCuiLz0JQmgF36GPQmgapZSILT2ZZnvEKTjGFe4YT7Bnw
	ooE7Hco/w4VVet2bxVfVNpG2TcG1kU6a8lC9wtEY55wtgG6NGbFAcZ99cGEbz9k7PPnniY3FpdeAu
	ZxsMIKZ7IfV2CP/X40W2eXqppC5Ws+ANhxeYX9gxltQ7OeitlW10UYQMb6/T8ERzySBkf2wXv9sGm
	b7s1whdw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7Ipn-00000009FkH-15gP;
	Fri, 10 Oct 2025 19:31:23 +0000
Message-ID: <07ae142e-4266-44a3-9aa1-4b2acbd72c1b@infradead.org>
Date: Fri, 10 Oct 2025 12:31:22 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
To: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>,
 Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>,
 linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
 initramfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Krzysztof Kozlowski <krzk@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Jessica Clarke <jrtc27@jrtc27.com>, Nicolas Schichan <nschichan@freebox.fr>,
 David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-3-safinaskar@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251010094047.3111495-3-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/10/25 2:40 AM, Askar Safin wrote:
> Remove linuxrc initrd code path, which was deprecated in 2020.
> 
> Initramfs and (non-initial) RAM disks (i. e. brd) still work.
> 
> Both built-in and bootloader-supplied initramfs still work.
> 
> Non-linuxrc initrd code path (i. e. using /dev/ram as final root
> filesystem) still works, but I put deprecation message into it
> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 +-
>  fs/init.c                                     | 14 ---
>  include/linux/init_syscalls.h                 |  1 -
>  include/linux/initrd.h                        |  2 -
>  init/do_mounts.c                              |  4 +-
>  init/do_mounts.h                              | 18 +---
>  init/do_mounts_initrd.c                       | 85 ++-----------------
>  init/do_mounts_rd.c                           | 17 +---
>  8 files changed, 17 insertions(+), 128 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 521ab3425504..24d8899d8a39 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4285,7 +4285,7 @@
>  			Note that this argument takes precedence over
>  			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
>  
> -	noinitrd	[RAM] Tells the kernel not to load any configured
> +	noinitrd	[Deprecated,RAM] Tells the kernel not to load any configured
>  			initial RAM disk.
>  
>  	nointremap	[X86-64,Intel-IOMMU,EARLY] Do not enable interrupt
> @@ -5299,7 +5299,7 @@
>  	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
>  			See Documentation/admin-guide/blockdev/ramdisk.rst.
>  
> -	ramdisk_start=	[RAM] RAM disk image start address
> +	ramdisk_start=	[Deprecated,RAM] RAM disk image start address
>  
>  	random.trust_cpu=off
>  			[KNL,EARLY] Disable trusting the use of the CPU's

There are more places in Documentation/ that refer to "linuxrc".
Should those also be removed or fixed?

accounting/delay-accounting.rst
admin-guide/initrd.rst
driver-api/early-userspace/early_userspace_support.rst
power/swsusp-dmcrypt.rst
translations/zh_CN/accounting/delay-accounting.rst


Thanks.



