Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9806C15D76A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 13:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgBNM3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 07:29:33 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:34579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgBNM3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:29:33 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N9dkB-1jWVY02UVB-015YK0; Fri, 14 Feb 2020 13:29:17 +0100
Subject: Re: [PATCH v3] binfmt_misc: pass binfmt_misc flags to the interpreter
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, YunQiang Su <ysu@wavecomp.com>,
        YunQiang Su <syq@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20200128132539.782286-1-laurent@vivier.eu>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d2993cd1-f671-380c-5887-52c987b84cd0@vivier.eu>
Date:   Fri, 14 Feb 2020 13:29:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128132539.782286-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U8ZVyuF3DsPZA0uzJN5toAoN1DG2ycJGri/DO6oMozoCAcFgTpH
 UrPLsCw9M4QNqhy7dXo4PYV0aC/GDnQDr8vKoVax+sLo4yIa2ASWjGSyUUnnvlGIA619Nyh
 Ws5WF6O5GB01SonhIZweJVaMZvXGZ0kmTzbJD5yt82LaX6t/5zyOWosIpIPlUT6/+JD7pz/
 TPfttrK7h4xcOOAOOFFFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:feaoCIt9mAg=:5iteKxbyY/lcCU9a9ty5Uu
 3Ob4JXmpgm4VuLFB0m/v96QPBABhd60N0hbUqGBKLqiEUxsuRJQihvlrJO6HyCr1CcIB4z3pS
 gglj1HcIaIXytW2HPaT5zXe7FLwbH+p3mbEDjNOEx1ZGE9Yu5IVj2SZNL7Nf9Kq42ZJX5lpx/
 MAgRlt/OHaSMEzTOsltjGCnKY3MJ0SxrfgkYNHhDrpfRlCr37XlBP5bLKtdsM/gnsgR6MYiDY
 Q27NRsfH7iK9wn1nmA2cK91k81r9050V4WIVwqep46ZKvHaCpGahzJEOVEeiLowvkz6KslRLq
 J1m5Vzo9nxCEoiEQXE2huSHxxZlpUTCOij+4IiScYQ7Fdnvl5xqy6oZYmTkfFd1GkYPVhhj5a
 h1x8t0qTEOpwLUrrUuUS3jVHYgRjV7jQZGETnwd2ab3p6oJOWj3+Jvu0T+1uSBzSVcZsetZz/
 KbSeWBtUWLSflt9IlZr9L34IKKJ+jN2I/ctmgrfXrpBjhP8VFT73fqis8iexPG70obLK/zTWm
 pzcO1ilyOWKnPSqhu6lyfl5IbhZICqyUCrHbQUDV3La5e/euEaLz/B0hh/viuMCo3FstzXu7I
 TkSlQMshC9RK48hUNL8b9XsPkYTjXI89pZM6ReO8o2ACtcc8M700Exzw/Fk60JXz1XZfE0fo3
 +DJa1dRcN/CTWREiPZxjOGddzvS0j+22fo6K9LddkAQZxZbiHSyqHRFi6n8eHHyVg1h6ck3je
 UBFsqGNNi/GBPP+G2YZQP2kYl1McWJRadNEmP3SYZST77DEAUMdzVrmI79JPYdExTldX2xziT
 tni5I1DjXkxjO1A15VF66lYFCuF+chPDUpBn6Vq9qQrPyZreBfrutovr6ArGoGYtXOUPNzR
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

any comment?

I think I've addressed comments on v2.

Thanks,
Laurent

Le 28/01/2020 à 14:25, Laurent Vivier a écrit :
> It can be useful to the interpreter to know which flags are in use.
> 
> For instance, knowing if the preserve-argv[0] is in use would
> allow to skip the pathname argument.
> 
> This patch uses an unused auxiliary vector, AT_FLAGS, to add a
> flag to inform interpreter if the preserve-argv[0] is enabled.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     This can be tested with QEMU from my branch:
>     
>       https://github.com/vivier/qemu/commits/binfmt-argv0
>     
>     With something like:
>     
>       # cp ..../qemu-ppc /chroot/powerpc/jessie
>     
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
>                             --persistent no --preserve-argv0 yes
>       # systemctl restart systemd-binfmt.service
>       # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>       enabled
>       interpreter //qemu-ppc
>       flags: POC
>       offset 0
>       magic 7f454c4601020100000000000000000000020014
>       mask ffffffffffffff00fffffffffffffffffffeffff
>       # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>       sh
>     
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
>                             --persistent no --preserve-argv0 no
>       # systemctl restart systemd-binfmt.service
>       # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>       enabled
>       interpreter //qemu-ppc
>       flags: OC
>       offset 0
>       magic 7f454c4601020100000000000000000000020014
>       mask ffffffffffffff00fffffffffffffffffffeffff
>       # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>       /bin/sh
>     
>     v3: mix my patch with one from YunQiang Su and my comments on it
>         introduce a new flag in the uabi for the AT_FLAGS
>     v2: only pass special flags (remove Magic and Enabled flags)
> 
>  fs/binfmt_elf.c              | 5 ++++-
>  fs/binfmt_elf_fdpic.c        | 5 ++++-
>  fs/binfmt_misc.c             | 4 +++-
>  include/linux/binfmts.h      | 4 ++++
>  include/uapi/linux/binfmts.h | 4 ++++
>  5 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index ecd8d2698515..ff918042ceed 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -176,6 +176,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>  	unsigned char k_rand_bytes[16];
>  	int items;
>  	elf_addr_t *elf_info;
> +	elf_addr_t flags = 0;
>  	int ei_index = 0;
>  	const struct cred *cred = current_cred();
>  	struct vm_area_struct *vma;
> @@ -250,7 +251,9 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
> -	NEW_AUX_ENT(AT_FLAGS, 0);
> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
> +	NEW_AUX_ENT(AT_FLAGS, flags);
>  	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
>  	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
>  	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 240f66663543..abb90d82aa58 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -507,6 +507,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	char __user *u_platform, *u_base_platform, *p;
>  	int loop;
>  	int nr;	/* reset for each csp adjustment */
> +	unsigned long flags = 0;
>  
>  #ifdef CONFIG_MMU
>  	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
> @@ -647,7 +648,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
>  	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
> -	NEW_AUX_ENT(AT_FLAGS,	0);
> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
> +	NEW_AUX_ENT(AT_FLAGS,	flags);
>  	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
>  	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
>  	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index cdb45829354d..b9acdd26a654 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -154,7 +154,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
>  		goto ret;
>  
> -	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
> +	if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
> +		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
> +	} else {
>  		retval = remove_arg_zero(bprm);
>  		if (retval)
>  			goto ret;
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index b40fc633f3be..265b80d5fd6f 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -78,6 +78,10 @@ struct linux_binprm {
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
>  
> +/* if preserve the argv0 for the interpreter  */
> +#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
> +#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
> +
>  /* Function parameter for binfmt->coredump */
>  struct coredump_params {
>  	const kernel_siginfo_t *siginfo;
> diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
> index 689025d9c185..a70747416130 100644
> --- a/include/uapi/linux/binfmts.h
> +++ b/include/uapi/linux/binfmts.h
> @@ -18,4 +18,8 @@ struct pt_regs;
>  /* sizeof(linux_binprm->buf) */
>  #define BINPRM_BUF_SIZE 256
>  
> +/* if preserve the argv0 for the interpreter  */
> +#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
> +#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
> +
>  #endif /* _UAPI_LINUX_BINFMTS_H */
> 

