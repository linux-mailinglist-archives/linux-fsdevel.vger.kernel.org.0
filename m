Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC22713D62F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 09:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbgAPIwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 03:52:20 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:59187 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbgAPIwT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:52:19 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MVNJ3-1j2lrh3jeR-00SNca; Thu, 16 Jan 2020 09:52:11 +0100
To:     YunQiang Su <syq@debian.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, viro@zeniv.linux.org.uk
Cc:     YunQiang Su <ysu@wavecomp.com>
References: <20200116083031.174367-1-syq@debian.org>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v3] binfmt_misc: pass info about P flag by AT_FLAGS
Message-ID: <47d06a3c-eb5c-7824-b443-0f0e64fab38b@vivier.eu>
Date:   Thu, 16 Jan 2020 09:52:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116083031.174367-1-syq@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s5O2ppCGHU2XOLDKAZsCq6fl3JlKhF5CMFLvjO8GMUj2u9CLTB1
 1qmZFKIFPZIe5iXxaTGTAo5/oFH9dRksVOUb5DuQDAxeOWgiqOLsnmG2GFxVXRDi//QiCcP
 tY0ifa/Ybv9d4ZpSNye7yjLJCidbMg23k/z+kE1LEDsVw8qSgeRMvnImreC1W1oQMGP9Tge
 fhhOHuHLTmUpEEhyVYhcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6iO2UpnTts=:sQQhUIoM+qcYbu2mfSX6om
 JTTxN03V4sPXuF5zRfprT/x9YFo2n/ZVYbbbyw+9CCZ6WHorXvSDpkimns5UHs3+zdp28WLeW
 xWai2QWyL03trChF5HZZrWCdoQhcw7iMEhS1EzatqfLwwMwD6+qOi3VVxHmc5+wAIFnBXYC8H
 2H9c74ZZY+QSjlS5bzzDQFRsa2we0eAkCxHtBTnGPWilmFuWIM5KuAHVk+UqU4me2iM5uyRMm
 5/d4++tUgzsbfA8ks//ZTwdPnW737lJaGF/67UAlZHux2odDecVVhEnVxnA+HkjW0Rvm1wmFy
 W0SySQaMbJOPQNxBnpyCVuTZLZZeoQugwCDOtFTaLYgE+mBqCQso7Zw68Jj5OBnRh9BOdx9Bc
 nsA4jPPh6zWgRQSlEouNCrn9nINHUZKL+ly7amU8yUOWBYHiOA5Ar6eYvaag6Hvdd2/HYuHzq
 TgXNtK+0wlqw4uR51BXkdU5tgNmGxG3TLCoHaJSHgfd2d8+s3onzleRMrEeE+M4WUuFx3IqMp
 6qcJZ8qUrH/hTLMQxw+UE/vQKa2eLt80ylcPTirnR6+9Cpxl/Ay3DTId+5eqcM5wd4nFI/tQP
 inIW/TyN0a6vfOE89BbIuMWhCGe9kzq4uC66tgzU31XRbjl8nppcFRgRdW53H8C6DvnKh0PLC
 6WSoKR3wCm7VkGSHAoXnCgIsYQpG75qQ5O5VXl1LG6sjKZdEYAy0pAOXugxULqFbHkg0lI2FH
 R3Q8P5eO/Xuh1vXAQQlnyooNYlP/DPZEM6oa7i9v+VKvX4UYvvAQE5M2Pf77Kp9qT1LWIK0oR
 J4C1/HpsDqpIeb52ed60wfAEx7sdHkpYeKWkG/1Sg0Aoz4HGBNc3ODjgHpecBhENJ6iGOaTLI
 1mvsaxrTeAv1LWBblXHwMfzICkWNlcBxBDrbOf+Y4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 16/01/2020 à 09:30, YunQiang Su a écrit :
> From: YunQiang Su <ysu@wavecomp.com>
> 
> Currently program invoked by binfmt_misc cannot be aware about whether
> P flag, aka preserve path is enabled.
> 
> Some applications like qemu need to know since it has 2 use case:
>   1. call by hand, like: qemu-mipsel-static test.app OPTION
>      so, qemu have to assume that P option is not enabled.
>   2. call by binfmt_misc. If qemu cannot know about whether P flag is
>      enabled, distribution's have to set qemu without P flag, and
>      binfmt_misc call qemu like:
>        qemu-mipsel-static /absolute/path/to/test.app OPTION
>      even test.app is not called by absoulute path, like
>        ./relative/path/to/test.app
> 
> This patch passes this information by the 0st bits of unused AT_FLAGS.
> Then, in qemu, we can get this info by:
>    getauxval(AT_FLAGS) & (1<<0)
> 
> v2->v3:
>   define a new AT_FLAGS_PRESERVE_ARGV0 as (1<<0), so now we use 0st bit.
> 
> v1->v2:
>   not enable kdebug
> 
> See: https://bugs.launchpad.net/qemu/+bug/1818483
> Signed-off-by: YunQiang Su <ysu@wavecomp.com>
> ---
>  fs/binfmt_elf.c         | 6 +++++-
>  fs/binfmt_elf_fdpic.c   | 6 +++++-
>  fs/binfmt_misc.c        | 2 ++
>  include/linux/binfmts.h | 4 ++++
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index f4713ea76e82..c4efff74223f 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -178,6 +178,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	unsigned char k_rand_bytes[16];
>  	int items;
>  	elf_addr_t *elf_info;
> +	elf_addr_t flags = 0;
>  	int ei_index;
>  	const struct cred *cred = current_cred();
>  	struct vm_area_struct *vma;
> @@ -252,7 +253,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
> -	NEW_AUX_ENT(AT_FLAGS, 0);
> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
> +	}
> +	NEW_AUX_ENT(AT_FLAGS, flags);
>  	NEW_AUX_ENT(AT_ENTRY, e_entry);
>  	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
>  	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 240f66663543..c89a4630efad 100644
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
> @@ -647,7 +648,10 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
>  	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
> -	NEW_AUX_ENT(AT_FLAGS,	0);
> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
> +	}
> +	NEW_AUX_ENT(AT_FLAGS,	flags);
>  	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
>  	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
>  	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index cdb45829354d..cb14e9bbf00f 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -158,6 +158,8 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  		retval = remove_arg_zero(bprm);
>  		if (retval)
>  			goto ret;
> +	} else {
> +		bprm->interp_flags |= AT_FLAGS_PRESERVE_ARGV0;

Keep BINPRM_FLAGS_PRESERVE_ARGV0 here.

>  	}
>  
>  	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index b40fc633f3be..380a30a46db1 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -78,6 +78,10 @@ struct linux_binprm {
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
>  
> +/* if preserve the argv0 for the interpreter  */
> +#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
> +#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
> +

I think it should be added in include/uapi/linux/binfmts.h to be shared
with user space (external API-

Where is defined BINPRM_FLAGS_PRESERVE_ARGV0 now? It should be here
(internal ABI)

Thanks,
Laurent



