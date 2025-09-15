Return-Path: <linux-fsdevel+bounces-61362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC58B57A7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1126C17D336
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8F23074B4;
	Mon, 15 Sep 2025 12:20:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6A30748B;
	Mon, 15 Sep 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938852; cv=none; b=W45yyp6IP1TWuEUmkvCFi29nC6NwjB9ywsrfy1/8s2XYt1hDe9kqpaLtvUZ8KAUnkR5T1QGq70j5f5uWDF+4UTS3jrwlYIuY5yXX/l7FKiclNhrBu0S5IwiaFPKe1A/nEAl5Cnxzgil7VSyA0cCMP8p4hMs/MPDZGfFnhxsRP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938852; c=relaxed/simple;
	bh=hzJRZ6RsW9x4FoXCvtGRPheB3cJRywWrGb2f60WiArY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5NZXTT03GSJ9R9MWnHI0NTGXUk8WSdbwwK7Rw5kdC2GsRlbeCzF+69wxRl1nu5j7E2LaCbqNPS6age97csXXb+P+zAjxZLHzHX6u8/Z9GclMtLHhhWqBza9hxRgVuWbud+f/OU/sVPYXU5rIeUVc39PhkGs8gSV4z2EKplDbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQNk651SSz9sxh;
	Mon, 15 Sep 2025 13:54:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zyKNPbK2UxYX; Mon, 15 Sep 2025 13:54:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQNk52qX4z9sxf;
	Mon, 15 Sep 2025 13:54:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 307338B766;
	Mon, 15 Sep 2025 13:54:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kYegUs-5AFEi; Mon, 15 Sep 2025 13:54:37 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 92F668B763;
	Mon, 15 Sep 2025 13:54:36 +0200 (CEST)
Message-ID: <a246ee31-1ea3-4278-b103-65fda6e692a9@csgroup.eu>
Date: Mon, 15 Sep 2025 13:54:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 08/62] arm: init: remove FLAG_RDLOAD and
 FLAG_RDPROMPT
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
 <20250913003842.41944-9-safinaskar@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250913003842.41944-9-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/09/2025 à 02:37, Askar Safin a écrit :
> [Vous ne recevez pas souvent de courriers de safinaskar@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> They are unused since previous commit

Since which commit ?

> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>   Documentation/arch/arm/setup.rst | 4 ++--
>   arch/arm/kernel/atags_compat.c   | 2 --
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
> index 8e12ef3fb9a7..be77d4b2aac1 100644
> --- a/Documentation/arch/arm/setup.rst
> +++ b/Documentation/arch/arm/setup.rst
> @@ -35,8 +35,8 @@ below:
>       =====   ========================
>       bit 0   1 = mount root read only
>       bit 1   unused
> -    bit 2   0 = load ramdisk
> -    bit 3   0 = prompt for ramdisk
> +    bit 2   unused
> +    bit 3   unused
>       =====   ========================
> 
>    rootdev
> diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
> index b9747061fa97..8d04edee3066 100644
> --- a/arch/arm/kernel/atags_compat.c
> +++ b/arch/arm/kernel/atags_compat.c
> @@ -44,8 +44,6 @@ struct param_struct {
>              unsigned long ramdisk_size;         /*  8 */
>              unsigned long flags;                /* 12 */
>   #define FLAG_READONLY  1
> -#define FLAG_RDLOAD    4
> -#define FLAG_RDPROMPT  8
>              unsigned long rootdev;              /* 16 */
>              unsigned long video_num_cols;       /* 20 */
>              unsigned long video_num_rows;       /* 24 */
> --
> 2.47.2
> 
> 


