Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E2F15061C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 13:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgBCMZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 07:25:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36321 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgBCMZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:25:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so7503862pfv.3;
        Mon, 03 Feb 2020 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:in-reply-to:references:mime-version
         :date:user-agent:content-transfer-encoding;
        bh=FKUC96H2QwgVAGrgpxfMD76drSTiMD3FF9MdbiCIpS8=;
        b=HPO1AgLlnfZ+pZluxQyqrCTra6XSAwt2F+Uj29FPvo2c4XwRnwT72wrZ+jzbuurIXK
         C+KAlWeBcVrPXX07WgD5kWbvkehjRGvGKZQgBoP0gwGp/plQRcySiHHb5RRmYdGynuFO
         +6CW/ZwP1YlgBAwyBIfaF82nh2r+7uSzFgcqnSB7L0Ar2naG8oEpogeO6sS6BCcQSrly
         w+hw8kJA2NPNK+AuCvFQ7AMOSzwWz+nMuvLX170Ds2yLbr7vi6SNZQo/UXA/r4tDj7+z
         fq17M4t1bk1moTxFhigPrcp3YpYftiVCzykWuOr7B0IQEqFbckyfzpcj7P97SNzmhpHA
         KJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:in-reply-to
         :references:mime-version:date:user-agent:content-transfer-encoding;
        bh=FKUC96H2QwgVAGrgpxfMD76drSTiMD3FF9MdbiCIpS8=;
        b=GfIBf4FFurTz53R2CekLfe/A0TtObbyGOwzcPClzD8DeFfMIQvT8gG3FrgZh6YUYvD
         UbuwnXVRNkLmOKdqpHNA0r26GnW/N86UGrdODyWl1d1QWpxHYaFh+WA/fyyOEATxI+9a
         dIFHYZy0f6uek3F4scA0e3jWLS+zlRqQ+GVbXC+0Z6plxSd0MeqJR9UKLTQwEDWVCVOJ
         Cf+jBYAkbYR1Ai9zMNzl1w5VVgIS30Qv5/vQOuBt27LKDpHt+GzDVM68T77RE6UCq3Mp
         GpJwNC0FNwKxWC1MLbt+pS8w26COc9mq4zw9kX7vHe7gpObv1rWFGNMkFsaPcJDiyAQn
         YC7Q==
X-Gm-Message-State: APjAAAV7qqHIiYhLd3gio9EaM1XkiVZXBOrd90dKENCKToEK9uIw7Bml
        WRSIwvJJIWCyf7UmIe2FWg+b1tsN+IEq+OTa
X-Google-Smtp-Source: APXvYqxOxWVTsRcvd9C4m7tKFtSR+8DtXkqhasjaCOq+nAlY3nENXgj29dpRAJjfDVd0Kr5ww8JTBA==
X-Received: by 2002:aa7:820d:: with SMTP id k13mr25350332pfi.10.1580732734710;
        Mon, 03 Feb 2020 04:25:34 -0800 (PST)
Received: from xps ([103.125.232.133])
        by smtp.gmail.com with ESMTPSA id o16sm19905855pgl.58.2020.02.03.04.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 04:25:33 -0800 (PST)
From:   YunQiang Su <wzssyqa@gmail.com>
X-Google-Original-From: YunQiang Su <ysu@wavecomp.com>
Message-ID: <cca45705edcdd27898188be06c9f31ec824a6b50.camel@wavecomp.com>
Subject: Re: [EXTERNAL][PATCH v3] binfmt_misc: pass binfmt_misc flags to
 the interpreter
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200128132539.782286-1-laurent@vivier.eu>
References: <20200128132539.782286-1-laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Sun, 02 Feb 2020 20:15:43 +0800
User-Agent: Evolution 3.34.1-3 
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2020-01-28二的 14:25 +0100，Laurent Vivier写道：
> It can be useful to the interpreter to know which flags are in use.
> 
> For instance, knowing if the preserve-argv[0] is in use would
> allow to skip the pathname argument.
> 
> This patch uses an unused auxiliary vector, AT_FLAGS, to add a
> flag to inform interpreter if the preserve-argv[0] is enabled.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: YunQiang Su <ysu@wavecomp.com>

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
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential
> yes \
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
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential
> yes \
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
> @@ -176,6 +176,7 @@ create_elf_tables(struct linux_binprm *bprm,
> struct elfhdr *exec,
>  	unsigned char k_rand_bytes[16];
>  	int items;
>  	elf_addr_t *elf_info;
> +	elf_addr_t flags = 0;
>  	int ei_index = 0;
>  	const struct cred *cred = current_cred();
>  	struct vm_area_struct *vma;
> @@ -250,7 +251,9 @@ create_elf_tables(struct linux_binprm *bprm,
> struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
> -	NEW_AUX_ENT(AT_FLAGS, 0);
> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
> +	NEW_AUX_ENT(AT_FLAGS, flags);
>  	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
>  	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred-
> >uid));
>  	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred-
> >euid));
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 240f66663543..abb90d82aa58 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -507,6 +507,7 @@ static int create_elf_fdpic_tables(struct
> linux_binprm *bprm,
>  	char __user *u_platform, *u_base_platform, *p;
>  	int loop;
>  	int nr;	/* reset for each csp adjustment */
> +	unsigned long flags = 0;
>  
>  #ifdef CONFIG_MMU
>  	/* In some cases (e.g. Hyper-Threading), we want to avoid L1
> evictions
> @@ -647,7 +648,9 @@ static int create_elf_fdpic_tables(struct
> linux_binprm *bprm,
>  	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
>  	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
> -	NEW_AUX_ENT(AT_FLAGS,	0);
> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
> +	NEW_AUX_ENT(AT_FLAGS,	flags);
>  	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
>  	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred-
> >user_ns, cred->uid));
>  	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred-
> >user_ns, cred->euid));
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index cdb45829354d..b9acdd26a654 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -154,7 +154,9 @@ static int load_misc_binary(struct linux_binprm
> *bprm)
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
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 <<
> BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
>  
> +/* if preserve the argv0 for the interpreter  */
> +#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
> +#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 <<
> BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
> +
>  /* Function parameter for binfmt->coredump */
>  struct coredump_params {
>  	const kernel_siginfo_t *siginfo;
> diff --git a/include/uapi/linux/binfmts.h
> b/include/uapi/linux/binfmts.h
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

