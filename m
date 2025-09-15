Return-Path: <linux-fsdevel+bounces-61367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686D7B57AB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204E64818CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D60330CDA8;
	Mon, 15 Sep 2025 12:21:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0101030C35A;
	Mon, 15 Sep 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938874; cv=none; b=n1HsfQjcgyuTD5e21sqFRi+TaeHO7gurdpAPKSucOE88iCi4ZkR5UANI9eZhZnEDdbpjgHsBzhZcoH4JWN+EE3trbe5mwGt2E+LMzNefnQlWyncMR1Zb3/UPnRV+eEjBN+zLC9a9XI1pqCIw5AOHPFsAtr5iDLMr3ioHRUzQP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938874; c=relaxed/simple;
	bh=9RLcS91I7/JfJmj5gROsGNlF/zDbJRvo+2amvvvj6yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZykKVC7pyy/mtCA1vR/XeLkskmICdXY19JpPrfPvCxndFS44alE5iIUJ4F532oWvlsA4WuBwV4zI8geUSt6dNvu6T9GrDT/dhkkcCBBVl9rofLH8ppvpAvkcE5pfqExzTh/P8Q8g9s2W9uIlci+63ND7ILUaB00dcJvoAIgEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQNnR0pmTz9sxp;
	Mon, 15 Sep 2025 13:57:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CofbtF7b-0VV; Mon, 15 Sep 2025 13:57:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQNnQ5DNGz9sxl;
	Mon, 15 Sep 2025 13:57:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 981DC8B766;
	Mon, 15 Sep 2025 13:57:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id aYicW_kKuipv; Mon, 15 Sep 2025 13:57:30 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 227808B763;
	Mon, 15 Sep 2025 13:57:30 +0200 (CEST)
Message-ID: <99563c3d-7322-4164-81f3-0d28e91ed653@csgroup.eu>
Date: Mon, 15 Sep 2025 13:57:29 +0200
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
> 
> Also this allows us to change rd_size variable to static

Can you squash patches 6 to 9 all together ?

> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>   arch/arm/kernel/atags_parse.c | 12 ------------
>   drivers/block/brd.c           |  8 ++++----
>   include/linux/initrd.h        |  3 ---
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


