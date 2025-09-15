Return-Path: <linux-fsdevel+bounces-61361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01BB57A62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2083B5582
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3E307489;
	Mon, 15 Sep 2025 12:20:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13DD27FD49;
	Mon, 15 Sep 2025 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938840; cv=none; b=KTkBWnsxxdJSSXJa5t7R9k/5iGbELLcN1SBBrjvQR37fJjidliedAGbNwNAN42pAHRtvovt/VVvWcCNluDVUoannPwcBaE2bKCqm9M2WJgsVQqffrZGsitcSViIhPoWxU+eWdBDM8L66Hn7LFrkUHXN+Evwo3I3xlvlh+7EAkh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938840; c=relaxed/simple;
	bh=D/7KskjWGePd5lUSyB950r7KaGQ+t6CMELLiiCCjoR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU4AUazivDeU3t+9gZkBhGYS8zye33+zt8Ha10Te78XdnKag4yWWLhtm8RKhy9xZ1dP/jfohKrqG7azNxX+0XU9Ah3cvp/S+md5JV6CBBGhy9OfhSnJ2e5j/fjFrnIb2vXkkekSR6E7LMWt74m3rOKWzhm4FVSO43VOfYgXxOGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQNhn1N0hz9sxb;
	Mon, 15 Sep 2025 13:53:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id anqguhIbwei8; Mon, 15 Sep 2025 13:53:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQNhm09sdz9sxY;
	Mon, 15 Sep 2025 13:53:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CE0528B766;
	Mon, 15 Sep 2025 13:53:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xl8Y1gVm9bTH; Mon, 15 Sep 2025 13:53:27 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B538F8B763;
	Mon, 15 Sep 2025 13:53:26 +0200 (CEST)
Message-ID: <b7ecad05-9880-4443-b2d2-843cf6fcc937@csgroup.eu>
Date: Mon, 15 Sep 2025 13:53:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 06/62] arm: init: remove special logic for setting
 brd.rd_size
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
 Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>,
 Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>,
 Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
 initramfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
 linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>,
 Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
References: <20250913003842.41944-1-safinaskar@gmail.com>
 <20250913003842.41944-7-safinaskar@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250913003842.41944-7-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/09/2025 à 02:37, Askar Safin a écrit :
> [Vous ne recevez pas souvent de courriers de safinaskar@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> There is no any reason for having special mechanism
> for setting ramdisk size.

That's you opinion.

You should explain why.

> 
> Also this allows us to change rd_size variable to static
> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>   arch/arm/kernel/atags_parse.c | 12 ------------
>   drivers/block/brd.c           |  8 ++++----
>   include/linux/initrd.h        |  3 ---

What about:

arch/mips/kernel/setup.c:early_param("rd_size", rd_size_early);

Is it unrelated ?

>   3 files changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
> index a3f0a4f84e04..615d9e83c9b5 100644
> --- a/arch/arm/kernel/atags_parse.c
> +++ b/arch/arm/kernel/atags_parse.c
> @@ -87,18 +87,6 @@ static int __init parse_tag_videotext(const struct tag *tag)
>   __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
>   #endif
> 
> -#ifdef CONFIG_BLK_DEV_RAM
> -static int __init parse_tag_ramdisk(const struct tag *tag)
> -{
> -       if (tag->u.ramdisk.size)
> -               rd_size = tag->u.ramdisk.size;
> -
> -       return 0;
> -}
> -
> -__tagtable(ATAG_RAMDISK, parse_tag_ramdisk);
> -#endif
> -
>   static int __init parse_tag_serialnr(const struct tag *tag)
>   {
>          system_serial_low = tag->u.serialnr.low;
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 0c2eabe14af3..72f02d2b8a99 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -27,6 +27,10 @@
> 
>   #include <linux/uaccess.h>
> 
> +static unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
> +module_param(rd_size, ulong, 0444);
> +MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
> +
>   /*
>    * Each block ramdisk device has a xarray brd_pages of pages that stores
>    * the pages containing the block device's contents.
> @@ -209,10 +213,6 @@ static int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
>   module_param(rd_nr, int, 0444);
>   MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
> 
> -unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
> -module_param(rd_size, ulong, 0444);
> -MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
> -
>   static int max_part = 1;
>   module_param(max_part, int, 0444);
>   MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
> index 6320a9cb6686..b42235c21444 100644
> --- a/include/linux/initrd.h
> +++ b/include/linux/initrd.h
> @@ -5,9 +5,6 @@
> 
>   #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
> 
> -/* size of a single RAM disk */
> -extern unsigned long rd_size;
> -
>   /* 1 if it is not an error if initrd_start < memory_start */
>   extern int initrd_below_start_ok;
> 
> --
> 2.47.2
> 
> 


