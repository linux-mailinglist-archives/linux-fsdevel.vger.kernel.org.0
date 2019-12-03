Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDE10FAF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 10:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfLCJlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 04:41:04 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:37763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCJlD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:41:03 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MNc1T-1iQsYQ12xH-00P1Yn; Tue, 03 Dec 2019 10:40:53 +0100
Subject: Re: [RFC v2] binfmt_misc: pass binfmt_misc flags to the interpreter
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20191122150830.15855-1-laurent@vivier.eu>
From:   Laurent Vivier <laurent@vivier.eu>
Message-ID: <27b62e32-1092-d334-6cc0-4029bda19a25@vivier.eu>
Date:   Tue, 3 Dec 2019 10:40:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122150830.15855-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vEqQ39WOdCsrFQCuCjUa8VvyjX2ZQngTuPDxdeDo7C7kVlje/+K
 bJAYckn/GzqLOY5qskaUbacJHjpLF6sVDSyylRNCMRJkC9aQzE5RTJsG9u3ey22dpwO6AQo
 g2vBo4cWOjnimnuMJgaScKJ6xzbw+zlxHtIeev4K2fbFyfzQkAy+SDqCg2FdMvMcka5VnQ3
 8mXwu5edQIacf92FA4+KQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d+Gj1rrjLGA=:DQHLtUzCqCGwx0kY9K0OSF
 WCQvILpbUroJ/x4Wti7+xNpGziV6nPnMefh462T5fTDaQMLobue0guFqPePBw4CFAPrxX4JRL
 uijcIsWVFqY5WsgZHxfW7GvDVwWMZAsA1WvId3o7RP6CCA9VHRYO7VtU+wishSN028f0qNBI+
 XdxGYuH4HapIHpCncdmaJ1C0ostoCp6sRf8nYBxO8HXec7N8YQNmi/6SSIrhGMN9eBoEogO3c
 KOredgUm18CQJishcF7A/+QdtIjd3tKzapB+tZDdf6gbmztJra8gFOBFuESza1oTuwIGpXq4u
 ZdXhqLyE4RPlcTqssHB4OeWpISyEoNyIZhljDtX/5ujMj+t8Y3KN4nwzUQ9etziwos0Bmqn6+
 bX/6srhfpMfVtSsFwDlD7P2LqsJ+b9Z2LrVYxZp/a9uFIT+NJ6U55aXi9Kx5t0GvpyBAHSTWA
 GNsX49KT7jvImFinmCT209rW9X9hKB2IYTfWvT2WPEqcG8aP6b4br714qEW/4XuSDIEM0x/j9
 pBpMNMD9xZRc8M0c7nH510tGnJA+lZUnaPbtfzxS0+Dw3B9oh0dwxrBpYm+GliFWz3RHsMkgo
 KjsSBj6ihLp/tXnPZDdpgtLRb4+62uvETkffKZ/IvgBNJaFbgWK5Z/SZ6z+M5oOj+0/PF6Cl9
 1YkgyBcJPBVw7AwZm5OtQUjhS4f2b4ycefmbi7NLsNz/1/4p54RQYqNAZMlh0IuuSDBxFBrSA
 G+b6p81i11copDmeGJYsm4r77+ERqAn42FambVw057oO9CCx8wSirUjSxxh/UKavxQGU/ELzK
 zAgZPTfUueOiNq86o2BCYVMsDZ5KYIkt3JDtxbnLfw02z285Of3RXOtyLINOg6sIMqpUbv8Yk
 x76YMZK190Z1NXTKrZi4pQXIQ3pb0Cj9LLSbhwlWI=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping

Thanks,
Laurent


Le 22/11/2019 à 16:08, Laurent Vivier a écrit :
> It can be useful to the interpreter to know which flags are in use.
> 
> For instance, knowing if the preserve-argv[0] is in use would
> allow to skip the pathname argument.
> 
> This patch uses an unused auxiliary vector, AT_FLAGS,  to pass the
> content of the binfmt flags (special flags: P, F, C, O).
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v2: only pass special flags (remove Magic and Enabled flags)
> 
>  fs/binfmt_elf.c         | 2 +-
>  fs/binfmt_elf_fdpic.c   | 2 +-
>  fs/binfmt_misc.c        | 6 ++++++
>  include/linux/binfmts.h | 2 +-
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index c5642bcb6b46..7a34c03e5857 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -250,7 +250,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
> -	NEW_AUX_ENT(AT_FLAGS, 0);
> +	NEW_AUX_ENT(AT_FLAGS, bprm->fmt_flags);
>  	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
>  	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
>  	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index d86ebd0dcc3d..8fe839be125e 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -647,7 +647,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
>  	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
> -	NEW_AUX_ENT(AT_FLAGS,	0);
> +	NEW_AUX_ENT(AT_FLAGS,	bprm->fmt_flags);
>  	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
>  	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
>  	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index cdb45829354d..25a392f23409 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -48,6 +48,9 @@ enum {Enabled, Magic};
>  #define MISC_FMT_OPEN_BINARY (1 << 30)
>  #define MISC_FMT_CREDENTIALS (1 << 29)
>  #define MISC_FMT_OPEN_FILE (1 << 28)
> +#define MISC_FMT_FLAGS_MASK (MISC_FMT_PRESERVE_ARGV0 | MISC_FMT_OPEN_BINARY | \
> +			     MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_FILE)
> +
>  
>  typedef struct {
>  	struct list_head list;
> @@ -149,6 +152,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	if (!fmt)
>  		return retval;
>  
> +	/* pass special flags to the interpreter */
> +	bprm->fmt_flags = fmt->flags & MISC_FMT_FLAGS_MASK;
> +
>  	/* Need to be able to load the file after exec */
>  	retval = -ENOENT;
>  	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index b40fc633f3be..dae0d0d7b84d 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -60,7 +60,7 @@ struct linux_binprm {
>  				   different for binfmt_{misc,script} */
>  	unsigned interp_flags;
>  	unsigned interp_data;
> -	unsigned long loader, exec;
> +	unsigned long loader, exec, fmt_flags;
>  
>  	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
>  
> 

