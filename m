Return-Path: <linux-fsdevel+bounces-61319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C33B5791B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2D07B0078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA75302CB3;
	Mon, 15 Sep 2025 11:50:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBFE3009E7;
	Mon, 15 Sep 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937038; cv=none; b=RhgpmOtNIKVUIkJfFmZxPMZHW/SFHybs+cqzOTVw8EnsSwSjOtqHda0idhnSE4TqTSa8FcrcbltZpVkdnWHmma2cLpFnR+3/YE0E9QL8aDy7ZHuBHncR2smb2pkSarF3JSCUUiQtoyw129jgjEtL8t+N9aeRDiEKndRh+Dpl6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937038; c=relaxed/simple;
	bh=a0VRXbta8K9gtk+IGHOwOU6MaIwzucwt5cPvZhkP+xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHbQsrk3JqQEy7tJ5SvGf8UVLyLSqDHQl/YKRK3b6NUFnQaS3lAtif9EkhF6RelfSez/7oB5LWNM+qe+ju9bq9pLtl2qtEfG6s+SYrEInN8d8TKksNY77Lxo4ZV0z6SJ2WXi8ISFApobG5jUEyDa9Ax/4ZB7LSKFVj7T4PA69fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cQNTb42Jgz9syc;
	Mon, 15 Sep 2025 13:43:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfGBSkOtiCmq; Mon, 15 Sep 2025 13:43:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cQNTZ1TZpz9syZ;
	Mon, 15 Sep 2025 13:43:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E29168B766;
	Mon, 15 Sep 2025 13:43:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id bAFn8JW7pVEL; Mon, 15 Sep 2025 13:43:45 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E4998B763;
	Mon, 15 Sep 2025 13:43:44 +0200 (CEST)
Message-ID: <ba78173a-9312-40fc-a88a-d94764ed6010@csgroup.eu>
Date: Mon, 15 Sep 2025 13:43:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 04/62] init: x86, arm, sh, sparc: remove variable
 rd_image_start, which controls starting block number of initrd
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
 <20250913003842.41944-5-safinaskar@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250913003842.41944-5-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/09/2025 à 02:37, Askar Safin a écrit :
> [Vous ne recevez pas souvent de courriers de safinaskar@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> This is preparation for initrd removal
> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>   Documentation/arch/x86/boot.rst       | 4 ++--
>   arch/arm/kernel/atags_parse.c         | 2 --
>   arch/sh/include/asm/setup.h           | 1 -
>   arch/sh/kernel/head_32.S              | 2 +-
>   arch/sh/kernel/setup.c                | 9 +--------
>   arch/sparc/boot/piggyback.c           | 4 ++--
>   arch/sparc/kernel/head_32.S           | 4 ++--
>   arch/sparc/kernel/head_64.S           | 6 ++++--
>   arch/sparc/kernel/setup_32.c          | 5 -----
>   arch/sparc/kernel/setup_64.c          | 5 -----
>   arch/x86/boot/header.S                | 2 +-
>   arch/x86/include/uapi/asm/bootparam.h | 5 +----
>   arch/x86/kernel/setup.c               | 5 -----
>   include/linux/initrd.h                | 3 ---
>   init/do_mounts_rd.c                   | 8 +++-----
>   15 files changed, 17 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> index 77e6163288db..118aa7b69667 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst
> @@ -189,7 +189,7 @@ Offset/Size Proto           Name                    Meaning
>   01F1/1         ALL(1)          setup_sects             The size of the setup in sectors
>   01F2/2         ALL             root_flags              If set, the root is mounted readonly
>   01F4/4         2.04+(2)        syssize                 The size of the 32-bit code in 16-byte paras
> -01F8/2         ALL             ram_size                DO NOT USE - for bootsect.S use only
> +01F8/2         ALL             ram_size                DO NOT USE - for bootsect.S use only - used to control initrd, which was removed from Linux in 2025

Is this change really needed/usefull. Here people can think it shall not 
be used because it is removed in 2025. But it reality it was already 
DO-NOT-USE 20 years old.

>   01FA/2         ALL             vid_mode                Video mode control
>   01FC/2         ALL             root_dev                Default root device number
>   01FE/2         ALL             boot_flag               0xAA55 magic number
> @@ -308,7 +308,7 @@ Offset/size:        0x1f8/2
>   Protocol:      ALL
>   ============   ===============
> 
> -  This field is obsolete.
> +  This field is obsolete. Used to control initrd, which was removed from Linux in 2025.

Same comment, this field has been obsolete long before the removal of 
initrd in 2025 so that new comment bring confusion.

> 
>   ============   ===================
>   Field name:    vid_mode
> diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
> index 4ec591bde3df..a3f0a4f84e04 100644
> --- a/arch/arm/kernel/atags_parse.c
> +++ b/arch/arm/kernel/atags_parse.c
> @@ -90,8 +90,6 @@ __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
>   #ifdef CONFIG_BLK_DEV_RAM
>   static int __init parse_tag_ramdisk(const struct tag *tag)
>   {
> -       rd_image_start = tag->u.ramdisk.start;
> -
>          if (tag->u.ramdisk.size)
>                  rd_size = tag->u.ramdisk.size;
> 
> diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
> index 84bb23a771f3..d1b97c5726e4 100644
> --- a/arch/sh/include/asm/setup.h
> +++ b/arch/sh/include/asm/setup.h
> @@ -10,7 +10,6 @@
>   #define PARAM  ((unsigned char *)empty_zero_page)
> 
>   #define MOUNT_ROOT_RDONLY (*(unsigned long *) (PARAM+0x000))
> -#define RAMDISK_FLAGS (*(unsigned long *) (PARAM+0x004))
>   #define ORIG_ROOT_DEV (*(unsigned long *) (PARAM+0x008))
>   #define LOADER_TYPE (*(unsigned long *) (PARAM+0x00c))
>   #define INITRD_START (*(unsigned long *) (PARAM+0x010))
> diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
> index b603b7968b38..4382c0f058c8 100644
> --- a/arch/sh/kernel/head_32.S
> +++ b/arch/sh/kernel/head_32.S
> @@ -28,7 +28,7 @@
>          .section        .empty_zero_page, "aw"
>   ENTRY(empty_zero_page)
>          .long   1               /* MOUNT_ROOT_RDONLY */
> -       .long   0               /* RAMDISK_FLAGS */
> +       .long   0               /* RAMDISK_FLAGS - used to control initrd, which was removed from Linux in 2025 */
>          .long   0x0200          /* ORIG_ROOT_DEV */
>          .long   1               /* LOADER_TYPE */
>          .long   0x00000000      /* INITRD_START */
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index d66f098e9e9f..50f1d39fe34f 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -70,8 +70,6 @@ EXPORT_SYMBOL(sh_mv);
> 
>   extern int root_mountflags;
> 
> -#define RAMDISK_IMAGE_START_MASK       0x07FF
> -
>   static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
> 
>   static struct resource code_resource = {
> @@ -273,19 +271,14 @@ void __init setup_arch(char **cmdline_p)
> 
>          printk(KERN_NOTICE "Boot params:\n"
>                             "... MOUNT_ROOT_RDONLY - %08lx\n"
> -                          "... RAMDISK_FLAGS     - %08lx\n"
>                             "... ORIG_ROOT_DEV     - %08lx\n"
>                             "... LOADER_TYPE       - %08lx\n"
>                             "... INITRD_START      - %08lx\n"
>                             "... INITRD_SIZE       - %08lx\n",
> -                          MOUNT_ROOT_RDONLY, RAMDISK_FLAGS,
> +                          MOUNT_ROOT_RDONLY,
>                             ORIG_ROOT_DEV, LOADER_TYPE,
>                             INITRD_START, INITRD_SIZE);
> 
> -#ifdef CONFIG_BLK_DEV_RAM
> -       rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
> -#endif
> -
>          if (!MOUNT_ROOT_RDONLY)
>                  root_mountflags &= ~MS_RDONLY;
>          setup_initial_init_mm(_text, _etext, _edata, _end);
> diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
> index 6d74064add0a..a9cc55254ff8 100644
> --- a/arch/sparc/boot/piggyback.c
> +++ b/arch/sparc/boot/piggyback.c
> @@ -220,8 +220,8 @@ int main(int argc,char **argv)
> 
>          /*
>           * root_flags = 0
> -        * root_dev = 1 (RAMDISK_MAJOR)
> -        * ram_flags = 0
> +        * root_dev = 1 (1 used to mean RAMDISK_MAJOR, i. e. initrd, which was removed from Linux)

At the end of your series RAMDISK_MAJOR still exists so this comment is 
wrong.

> +        * ram_flags = 0 (used to control initrd, which was removed from Linux in 2025)
>           * sparc_ramdisk_image = "PAGE aligned address after _end")
>           * sparc_ramdisk_size = size of image
>           */

Shouldn't this block be droped entirely ?

> diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
> index 38345460d542..46f0e39b9037 100644
> --- a/arch/sparc/kernel/head_32.S
> +++ b/arch/sparc/kernel/head_32.S
> @@ -65,7 +65,7 @@ empty_zero_page:      .skip PAGE_SIZE
>   EXPORT_SYMBOL(empty_zero_page)
> 
>          .global root_flags
> -       .global ram_flags
> +       .global ram_flags /* used to control initrd, which was removed from Linux in 2025 */

Can we remove this line completely instead of adding a comment ?

>          .global root_dev
>          .global sparc_ramdisk_image
>          .global sparc_ramdisk_size
> @@ -81,7 +81,7 @@ root_flags:
>          .half   1
>   root_dev:
>          .half   0
> -ram_flags:
> +ram_flags: /* used to control initrd, which was removed from Linux in 2025 */

Same, why not remove this object completely ?

>          .half   0
>   sparc_ramdisk_image:
>          .word   0
> diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
> index cf0549134234..4480c0532fe9 100644
> --- a/arch/sparc/kernel/head_64.S
> +++ b/arch/sparc/kernel/head_64.S
> @@ -52,7 +52,9 @@ stext:
>    * Fields should be kept upward compatible and whenever any change is made,
>    * HdrS version should be incremented.
>    */
> -        .global root_flags, ram_flags, root_dev
> +        .global root_flags
> +        .global ram_flags /* used to control initrd, which was removed from Linux in 2025 */

Same, can you remove them ?
Such comments in the code are generaly pointless, you can recover 
history with 'git log'.

> +        .global root_dev
>           .global sparc_ramdisk_image, sparc_ramdisk_size
>          .global sparc_ramdisk_image64
> 
> @@ -71,7 +73,7 @@ root_flags:
>           .half   1
>   root_dev:
>           .half   0
> -ram_flags:
> +ram_flags: /* used to control initrd, which was removed from Linux in 2025 */

Same, remove.

>           .half   0
>   sparc_ramdisk_image:
>           .word   0
> diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
> index eb60be31127f..fb46fb3acf54 100644
> --- a/arch/sparc/kernel/setup_32.c
> +++ b/arch/sparc/kernel/setup_32.c
> @@ -170,8 +170,6 @@ static void __init boot_flags_init(char *commands)
> 
>   extern unsigned short root_flags;
>   extern unsigned short root_dev;
> -extern unsigned short ram_flags;
> -#define RAMDISK_IMAGE_START_MASK       0x07FF
> 
>   extern int root_mountflags;
> 
> @@ -335,9 +333,6 @@ void __init setup_arch(char **cmdline_p)
>          if (!root_flags)
>                  root_mountflags &= ~MS_RDONLY;
>          ROOT_DEV = old_decode_dev(root_dev);
> -#ifdef CONFIG_BLK_DEV_RAM
> -       rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
> -#endif
> 
>          prom_setsync(prom_sync_me);
> 
> diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
> index f728f1b00aca..79b56613c6d8 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c
> @@ -143,8 +143,6 @@ static void __init boot_flags_init(char *commands)
> 
>   extern unsigned short root_flags;
>   extern unsigned short root_dev;
> -extern unsigned short ram_flags;
> -#define RAMDISK_IMAGE_START_MASK       0x07FF
> 
>   extern int root_mountflags;
> 
> @@ -640,9 +638,6 @@ void __init setup_arch(char **cmdline_p)
>          if (!root_flags)
>                  root_mountflags &= ~MS_RDONLY;
>          ROOT_DEV = old_decode_dev(root_dev);
> -#ifdef CONFIG_BLK_DEV_RAM
> -       rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
> -#endif
> 
>   #ifdef CONFIG_IP_PNP
>          if (!ic_set_manually) {
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 9bea5a1e2c52..0ced2e9f100e 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -235,7 +235,7 @@ hdr:
>                  .byte setup_sects - 1
>   root_flags:    .word ROOT_RDONLY
>   syssize:       .long ZO__edata / 16
> -ram_size:      .word 0                 /* Obsolete */
> +ram_size:      .word 0                 /* Used to control initrd, which was removed from Linux in 2025 */

Same, just remove, or make 'reserved' if you need to keep the space.

>   vid_mode:      .word SVGA_MODE
>   root_dev:      .word 0                 /* Default to major/minor 0/0 */
>   boot_flag:     .word 0xAA55
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index f53dd3f319ba..bf56549f79bb 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -4,9 +4,6 @@
> 
>   #include <asm/setup_data.h>
> 
> -/* ram_size flags */
> -#define RAMDISK_IMAGE_START_MASK       0x07FF
> -
>   /* loadflags */
>   #define LOADED_HIGH    (1<<0)
>   #define KASLR_FLAG     (1<<1)
> @@ -37,7 +34,7 @@ struct setup_header {
>          __u8    setup_sects;
>          __u16   root_flags;
>          __u32   syssize;
> -       __u16   ram_size;
> +       __u16   ram_size; /* used to control initrd, which was removed from Linux in 2025 */

Rename it to 'reserved'.

>          __u16   vid_mode;
>          __u16   root_dev;
>          __u16   boot_flag;
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6409e766fb17..797c3c9fc75e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -222,8 +222,6 @@ extern int root_mountflags;
> 
>   unsigned long saved_video_mode;
> 
> -#define RAMDISK_IMAGE_START_MASK       0x07FF
> -
>   static char __initdata command_line[COMMAND_LINE_SIZE];
>   #ifdef CONFIG_CMDLINE_BOOL
>   char builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
> @@ -541,9 +539,6 @@ static void __init parse_boot_params(void)
>          bootloader_version  = bootloader_type & 0xf;
>          bootloader_version |= boot_params.hdr.ext_loader_ver << 4;
> 
> -#ifdef CONFIG_BLK_DEV_RAM
> -       rd_image_start = boot_params.hdr.ram_size & RAMDISK_IMAGE_START_MASK;
> -#endif
>   #ifdef CONFIG_EFI
>          if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
>                       EFI32_LOADER_SIGNATURE, 4)) {
> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
> index f1a1f4c92ded..6320a9cb6686 100644
> --- a/include/linux/initrd.h
> +++ b/include/linux/initrd.h
> @@ -5,9 +5,6 @@
> 
>   #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
> 
> -/* starting block # of image */
> -extern int rd_image_start;
> -
>   /* size of a single RAM disk */
>   extern unsigned long rd_size;
> 
> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index f7d53bc21e41..8e0a774a9c6f 100644
> --- a/init/do_mounts_rd.c
> +++ b/init/do_mounts_rd.c
> @@ -17,11 +17,9 @@
>   static struct file *in_file, *out_file;
>   static loff_t in_pos, out_pos;
> 
> -int __initdata rd_image_start;         /* starting block # of image */

Why do you need to change this really ? In any case this entire file 
goes away in a later patch so you shouldn't bother to update that.

> -
>   static int __init ramdisk_start_setup(char *str)
>   {
> -       rd_image_start = simple_strtol(str,NULL,0);
> +       /* will be removed in next commit */

Useless comment, don't add such burden.

>          return 1;
>   }
>   __setup("ramdisk_start=", ramdisk_start_setup);
> @@ -60,7 +58,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
>          unsigned char *buf;
>          const char *compress_name;
>          unsigned long n;
> -       int start_block = rd_image_start;
> +       int start_block = 0;

Don't change, it is removed later.

> 
>          buf = kmalloc(size, GFP_KERNEL);
>          if (!buf)
> @@ -196,7 +194,7 @@ int __init rd_load_image(char *from)
>          if (IS_ERR(in_file))
>                  goto noclose_input;
> 
> -       in_pos = rd_image_start * BLOCK_SIZE;
> +       in_pos = 0;

Same

>          nblocks = identify_ramdisk_image(in_file, in_pos, &decompressor);
>          if (nblocks < 0)
>                  goto done;
> --
> 2.47.2
> 
> 


