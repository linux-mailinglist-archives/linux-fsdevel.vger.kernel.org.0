Return-Path: <linux-fsdevel+bounces-37174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE499EE967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE34281D7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20AF215782;
	Thu, 12 Dec 2024 14:55:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A6521571D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015359; cv=none; b=PrMQF7vttXqAUjkIcJhexhBFWwLVMjb6B2CtiJihkTYn7JK52kjYIH12JsMjOEfEpt1u/gt8eT1nxPqMsyJFfv/8ErWauhSc44MpMseBvZqDuWS9Xp3KrXSAw5Q3d8nfHMAcmxDL2HWUy42Je3Y/qKmFWJD9C5uexFiz0NbTBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015359; c=relaxed/simple;
	bh=pDaHmOkG1EbZ5u2fVBqIJ+vQ1ny/bj/VOcowXHSn6gA=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=T2dlsSDWBNsqDu5euPniS4ZVCuk4+D01e2oxk0EZqtK+xPHbQGu4zp/P3t4zVsnfZ+e5uBMJVbO9tq+wciqU4Hsx7nhMYGlX/2MXKmFEvm5pSVFjdXWbbjo9Niv9yTUglcLuTzj6LxRu6krEUdve+jCWD48Jja05QGgOLNLbHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:37672)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tLk5t-00BfnV-H5; Thu, 12 Dec 2024 07:23:09 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:59852 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tLk5s-0070Kb-4n; Thu, 12 Dec 2024 07:23:09 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org,  ricarkol@google.com,
  Liam.Howlett@oracle.com,  Kees Cook <kees@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
Date: Thu, 12 Dec 2024 08:22:47 -0600
In-Reply-To: <d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	(Hajime Tazaki's message of "Thu, 12 Dec 2024 19:12:09 +0900")
Message-ID: <87r06d0ymg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tLk5s-0070Kb-4n;;;mid=<87r06d0ymg.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/f/Wxjl/Fysr+iPoDi9zb/QsVJKuStryA=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Hajime Tazaki <thehajime@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 773 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 12 (1.5%), b_tie_ro: 10 (1.3%), parse: 1.52
	(0.2%), extract_message_metadata: 27 (3.5%), get_uri_detail_list: 3.7
	(0.5%), tests_pri_-2000: 44 (5.7%), tests_pri_-1000: 3.0 (0.4%),
	tests_pri_-950: 1.57 (0.2%), tests_pri_-900: 1.16 (0.1%),
	tests_pri_-90: 244 (31.6%), check_bayes: 226 (29.2%), b_tokenize: 14
	(1.8%), b_tok_get_all: 11 (1.4%), b_comp_prob: 4.1 (0.5%),
	b_tok_touch_all: 191 (24.7%), b_finish: 1.47 (0.2%), tests_pri_0: 418
	(54.0%), check_dkim_signature: 0.78 (0.1%), check_dkim_adsp: 3.1
	(0.4%), poll_dns_idle: 0.72 (0.1%), tests_pri_10: 2.1 (0.3%),
	tests_pri_500: 15 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, kees@kernel.org, Liam.Howlett@oracle.com, ricarkol@google.com, linux-um@lists.infradead.org, thehajime@gmail.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Hajime Tazaki <thehajime@gmail.com> writes:

> As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
> loader, FDPIC ELF loader.  In this commit, we added necessary
> definitions in the arch, as UML has not been used so far.  It also
> updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.

Why does the no mmu case need an alternative elf loader?

Last time I looked the regular binfmt_elf works just fine
without an mmu.  I looked again and at a quick skim the
regular elf loader still looks like it will work without
an MMU.

You would need ET_DYN binaries just so they will load and run
in a position independent way.  But even that seems a common
configuration even with a MMU these days.

There are some funny things in elf_fdpic where it departs
from the ELF standard and is no fun to support unless it
is necessary.  So I am not excited to see more architectures
supporting ELF_FDPIC.

Eric



> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  arch/um/include/asm/mmu.h            | 5 +++++
>  arch/um/include/asm/ptrace-generic.h | 6 ++++++
>  arch/x86/um/asm/elf.h                | 8 ++++++--
>  fs/Kconfig.binfmt                    | 2 +-
>  4 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
> index a3eaca41ff61..01422b761aa0 100644
> --- a/arch/um/include/asm/mmu.h
> +++ b/arch/um/include/asm/mmu.h
> @@ -14,6 +14,11 @@ typedef struct mm_context {
>  	/* Address range in need of a TLB sync */
>  	unsigned long sync_tlb_range_from;
>  	unsigned long sync_tlb_range_to;
> +
> +#ifdef CONFIG_BINFMT_ELF_FDPIC
> +	unsigned long   exec_fdpic_loadmap;
> +	unsigned long   interp_fdpic_loadmap;
> +#endif
>  } mm_context_t;
>  
>  #endif
> diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
> index 4696f24d1492..4ff844bcb1cd 100644
> --- a/arch/um/include/asm/ptrace-generic.h
> +++ b/arch/um/include/asm/ptrace-generic.h
> @@ -29,6 +29,12 @@ struct pt_regs {
>  
>  #define PTRACE_OLDSETOPTIONS 21
>  
> +#ifdef CONFIG_BINFMT_ELF_FDPIC
> +#define PTRACE_GETFDPIC		31
> +#define PTRACE_GETFDPIC_EXEC	0
> +#define PTRACE_GETFDPIC_INTERP	1
> +#endif
> +
>  struct task_struct;
>  
>  extern long subarch_ptrace(struct task_struct *child, long request,
> diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
> index 62ed5d68a978..33f69f1eac10 100644
> --- a/arch/x86/um/asm/elf.h
> +++ b/arch/x86/um/asm/elf.h
> @@ -9,6 +9,7 @@
>  #include <skas.h>
>  
>  #define CORE_DUMP_USE_REGSET
> +#define ELF_FDPIC_CORE_EFLAGS  0
>  
>  #ifdef CONFIG_X86_32
>  
> @@ -190,8 +191,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>  
>  extern unsigned long um_vdso_addr;
>  #define AT_SYSINFO_EHDR 33
> -#define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
> -
> +#define ARCH_DLINFO						\
> +do {								\
> +	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr);		\
> +	NEW_AUX_ENT(AT_MINSIGSTKSZ, 0);			\
> +} while (0)
>  #endif
>  
>  typedef unsigned long elf_greg_t;
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index bd2f530e5740..419ba0282806 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>  config BINFMT_ELF_FDPIC
>  	bool "Kernel support for FDPIC ELF binaries"
>  	default y if !BINFMT_ELF
> -	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> +	depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
>  	select ELFCORE
>  	help
>  	  ELF FDPIC binaries are based on ELF, but allow the individual load

