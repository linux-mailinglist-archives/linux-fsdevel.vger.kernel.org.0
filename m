Return-Path: <linux-fsdevel+bounces-61321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318C8B57934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E5D17CD31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BA33054E5;
	Mon, 15 Sep 2025 11:50:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DDF304BAF;
	Mon, 15 Sep 2025 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937052; cv=none; b=jWghFRx5HvU8ZKd7bie3+QKRWDE6kE4L+PZcd4XK60xvHkdjvyE7gS+KismSFTbCNoW8MIG9jhP9c5RxFnPDcVhDYI+S/iXqb4s0ASXgqwKXmJ0PVgVTxLu2hlLaniyk9l5ZHiSF5l56CJmtquOROjuTuY2ZbVYS1uNCeN9/7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937052; c=relaxed/simple;
	bh=X5HY0Wbrex5Ut2NzBhql+1NJ3xP8s+GYl6qMTFC+JS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYlc3/qQD3A7eutmeHn9Qk5AvOx64FHelvEFF0ufQE8RRVOmU/WYot9pbPPsjB8wk3p38JH+cZjuKB6Xx3FbpU1nfLxpgOquLWusRUYK5YDQqnarjulPzRK6XXwxOyQrNS0JErJaZpns2FpQ0VOZMD9hFmE5il2tCXPr9nvhxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQMty1PZPz9sxj;
	Mon, 15 Sep 2025 13:17:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3y6qLNUbAYQ5; Mon, 15 Sep 2025 13:17:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQMtx060wz9sxg;
	Mon, 15 Sep 2025 13:17:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BF74D8B766;
	Mon, 15 Sep 2025 13:17:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LLgTqAL1YNfN; Mon, 15 Sep 2025 13:17:12 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F017B8B763;
	Mon, 15 Sep 2025 13:17:11 +0200 (CEST)
Message-ID: <8b56da8e-42d1-4548-8e39-286010c5d84a@csgroup.eu>
Date: Mon, 15 Sep 2025 13:17:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 01/62] init: remove deprecated "load_ramdisk"
 command line parameter, which does nothing
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
 <20250913003842.41944-2-safinaskar@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250913003842.41944-2-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/09/2025 à 02:37, Askar Safin a écrit :
> [Vous ne recevez pas souvent de courriers de safinaskar@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> This is preparation for initrd removal


Squash patch 1 and patch 2 together and say this is cleanup of two 
options deprecated by commit c8376994c86c ("initrd: remove support for 
multiple floppies") with the documentation by commit 6b99e6e6aa62 
("Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"")

Christophe


> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 2 --
>   arch/arm/configs/neponset_defconfig             | 2 +-
>   init/do_mounts.c                                | 7 -------
>   3 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 747a55abf494..d3b05ce249ff 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3275,8 +3275,6 @@
>                          If there are multiple matching configurations changing
>                          the same attribute, the last one is used.
> 
> -       load_ramdisk=   [RAM] [Deprecated]
> -
>          lockd.nlm_grace_period=P  [NFS] Assign grace period.
>                          Format: <integer>
> 
> diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
> index 2227f86100ad..16f7300239da 100644
> --- a/arch/arm/configs/neponset_defconfig
> +++ b/arch/arm/configs/neponset_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
>   CONFIG_ZBOOT_ROM_TEXT=0x80000
>   CONFIG_ZBOOT_ROM_BSS=0xc1000000
>   CONFIG_ZBOOT_ROM=y
> -CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
> +CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
>   CONFIG_FPE_NWFPE=y
>   CONFIG_PM=y
>   CONFIG_MODULES=y
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 6af29da8889e..0f2f44e6250c 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -34,13 +34,6 @@ static int root_wait;
> 
>   dev_t ROOT_DEV;
> 
> -static int __init load_ramdisk(char *str)
> -{
> -       pr_warn("ignoring the deprecated load_ramdisk= option\n");
> -       return 1;
> -}
> -__setup("load_ramdisk=", load_ramdisk);
> -
>   static int __init readonly(char *str)
>   {
>          if (*str)
> --
> 2.47.2
> 
> 


