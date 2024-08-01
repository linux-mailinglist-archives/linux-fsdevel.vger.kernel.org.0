Return-Path: <linux-fsdevel+bounces-24728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA069441D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 05:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8385A2816AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143613D889;
	Thu,  1 Aug 2024 03:20:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56F13D62A;
	Thu,  1 Aug 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722482447; cv=none; b=d+s8BStRu1wjqBBlo7Q3jG40x28P364FrhS74WyCR8EyFOEXNdBd/u39AGOusqcrNDCsSbJlEMprWqN4VGwXQSIesWcq8gcEXF7oyvoFfjA8wJ91/RM9z2x3zDHxwvIKj4Ty6oZ1obHVkNMxwknpV9jT5XGqLetaynqrTA/v4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722482447; c=relaxed/simple;
	bh=kWjDjYWdH6KO9iUhYLSwSXoRYfcwQFwK7ilqkN3T0E0=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=HHBwxZmW9OYaNUwyypv2HUPMpdk880NbwKzfBgj/8j2wGMaTnTOKmMJyloh44vP2MX+c8XLhGvvRkkLbPb1ec/AYdfImaPxU62l3iVZ7giDtneBj4XgD8yvcQv03YCKQEmCgymy5dmrwwxIAz4lnovVw/un+5/c8mKz00CAJ47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:49932)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sZLvw-002zLX-5G; Wed, 31 Jul 2024 20:52:52 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:40402 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sZLvu-00GLbI-Q8; Wed, 31 Jul 2024 20:52:51 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Brian Mak <makb@juniper.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Kees Cook
 <kees@kernel.org>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-mm@kvack.org"
 <linux-mm@kvack.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
References: <CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net>
Date: Wed, 31 Jul 2024 21:52:07 -0500
In-Reply-To: <CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net> (Brian Mak's
	message of "Wed, 31 Jul 2024 22:14:15 +0000")
Message-ID: <877cd1ymy0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sZLvu-00GLbI-Q8;;;mid=<877cd1ymy0.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+ZIrQkpc0EQZzhQN6PC7iJUidyY4UMcOc=
X-SA-Exim-Connect-IP: 68.227.165.127
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Brian Mak <makb@juniper.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 768 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 15 (2.0%), b_tie_ro: 13 (1.6%), parse: 2.2 (0.3%),
	 extract_message_metadata: 28 (3.6%), get_uri_detail_list: 6 (0.8%),
	tests_pri_-2000: 40 (5.3%), tests_pri_-1000: 4.5 (0.6%),
	tests_pri_-950: 1.95 (0.3%), tests_pri_-900: 1.56 (0.2%),
	tests_pri_-90: 100 (13.0%), check_bayes: 92 (12.0%), b_tokenize: 26
	(3.3%), b_tok_get_all: 16 (2.1%), b_comp_prob: 6 (0.8%),
	b_tok_touch_all: 37 (4.8%), b_finish: 1.54 (0.2%), tests_pri_0: 551
	(71.8%), check_dkim_signature: 1.22 (0.2%), check_dkim_adsp: 3.9
	(0.5%), poll_dns_idle: 1.09 (0.1%), tests_pri_10: 2.7 (0.3%),
	tests_pri_500: 14 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Brian Mak <makb@juniper.net> writes:

> Large cores may be truncated in some scenarios, such as daemons with stop
> timeouts that are not large enough or lack of disk space. This impacts
> debuggability with large core dumps since critical information necessary to
> form a usable backtrace, such as stacks and shared library information, are
> omitted. We can mitigate the impact of core dump truncation by dumping
> smaller VMAs first, which may be more likely to contain memory for stacks
> and shared library information, thus allowing a usable backtrace to be
> formed.

This sounds theoretical.  Do you happen to have a description of a
motivating case?  A situtation that bit someone and resulted in a core
file that wasn't usable?

A concrete situation would help us imagine what possible caveats there
are with sorting vmas this way.

The most common case I am aware of is distributions setting the core
file size to 0 (ulimit -c 0).

One practical concern with this approach is that I think the ELF
specification says that program headers should be written in memory
order.  So a comment on your testing to see if gdb or rr or any of
the other debuggers that read core dumps cares would be appreciated.


> We implement this by sorting the VMAs by dump size and dumping in that
> order.

Since your concern is about stacks, and the kernel has information about
stacks it might be worth using that information explicitly when sorting
vmas, instead of just assuming stacks will be small.

I expect the priorities would look something like jit generated
executable code segments, stacks, and then heap data.

I don't have enough information what is causing your truncated core
dumps, so I can't guess what the actual problem is your are fighting,
so I could be wrong on priorities.

Though I do wonder if this might be a buggy interaction between
core dumps and something like signals, or io_uring.  If it is something
other than a shortage of storage space causing your truncated core
dumps I expect we should first debug why the coredumps are being
truncated rather than proceed directly to working around truncation.

Eric

> Signed-off-by: Brian Mak <makb@juniper.net>
> ---
>
> Hi all,
>
> My initial testing with a program that spawns several threads and allocates heap
> memory shows that this patch does indeed prioritize information such as stacks,
> which is crucial to forming a backtrace and debugging core dumps.
>
> Requesting for comments on the following:
>
> Are there cases where this might not necessarily prioritize dumping VMAs
> needed to obtain a usable backtrace?
>
> Thanks,
> Brian Mak
>
>  fs/binfmt_elf.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 19fa49cd9907..d45240b0748d 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/fs.h>
> +#include <linux/debugfs.h>
>  #include <linux/log2.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
> @@ -37,6 +38,7 @@
>  #include <linux/elf-randomize.h>
>  #include <linux/utsname.h>
>  #include <linux/coredump.h>
> +#include <linux/sort.h>
>  #include <linux/sched.h>
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/task_stack.h>
> @@ -1990,6 +1992,22 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
>  	shdr4extnum->sh_info = segs;
>  }
>  
> +static int cmp_vma_size(const void *vma_meta_lhs_ptr, const void *vma_meta_rhs_ptr)
> +{
> +	const struct core_vma_metadata *vma_meta_lhs = *(const struct core_vma_metadata **)
> +		vma_meta_lhs_ptr;
> +	const struct core_vma_metadata *vma_meta_rhs = *(const struct core_vma_metadata **)
> +		vma_meta_rhs_ptr;
> +
> +	if (vma_meta_lhs->dump_size < vma_meta_rhs->dump_size)
> +		return -1;
> +	if (vma_meta_lhs->dump_size > vma_meta_rhs->dump_size)
> +		return 1;
> +	return 0;
> +}
> +
> +static bool sort_elf_core_vmas = true;
> +
>  /*
>   * Actual dumper
>   *
> @@ -2008,6 +2026,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	struct elf_shdr *shdr4extnum = NULL;
>  	Elf_Half e_phnum;
>  	elf_addr_t e_shoff;
> +	struct core_vma_metadata **sorted_vmas = NULL;
>  
>  	/*
>  	 * The number of segs are recored into ELF header as 16bit value.
> @@ -2071,11 +2090,27 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
>  		goto end_coredump;
>  
> +	/* Allocate memory to sort VMAs and sort if needed. */
> +	if (sort_elf_core_vmas)
> +		sorted_vmas = kvmalloc_array(cprm->vma_count, sizeof(*sorted_vmas), GFP_KERNEL);
> +
> +	if (!ZERO_OR_NULL_PTR(sorted_vmas)) {
> +		for (i = 0; i < cprm->vma_count; i++)
> +			sorted_vmas[i] = cprm->vma_meta + i;
> +
> +		sort(sorted_vmas, cprm->vma_count, sizeof(*sorted_vmas), cmp_vma_size, NULL);
> +	}
> +
>  	/* Write program headers for segments dump */
>  	for (i = 0; i < cprm->vma_count; i++) {
> -		struct core_vma_metadata *meta = cprm->vma_meta + i;
> +		struct core_vma_metadata *meta;
>  		struct elf_phdr phdr;
>  
> +		if (ZERO_OR_NULL_PTR(sorted_vmas))
> +			meta = cprm->vma_meta + i;
> +		else
> +			meta = sorted_vmas[i];
> +
>  		phdr.p_type = PT_LOAD;
>  		phdr.p_offset = offset;
>  		phdr.p_vaddr = meta->start;
> @@ -2111,7 +2146,12 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	dump_skip_to(cprm, dataoff);
>  
>  	for (i = 0; i < cprm->vma_count; i++) {
> -		struct core_vma_metadata *meta = cprm->vma_meta + i;
> +		struct core_vma_metadata *meta;
> +
> +		if (ZERO_OR_NULL_PTR(sorted_vmas))
> +			meta = cprm->vma_meta + i;
> +		else
> +			meta = sorted_vmas[i];
>  
>  		if (!dump_user_range(cprm, meta->start, meta->dump_size))
>  			goto end_coredump;
> @@ -2128,10 +2168,26 @@ static int elf_core_dump(struct coredump_params *cprm)
>  end_coredump:
>  	free_note_info(&info);
>  	kfree(shdr4extnum);
> +	kvfree(sorted_vmas);
>  	kfree(phdr4note);
>  	return has_dumped;
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +
> +static struct dentry *elf_core_debugfs;
> +
> +static int __init init_elf_core_debugfs(void)
> +{
> +	elf_core_debugfs = debugfs_create_dir("elf_core", NULL);
> +	debugfs_create_bool("sort_elf_core_vmas", 0644, elf_core_debugfs, &sort_elf_core_vmas);
> +	return 0;
> +}
> +
> +fs_initcall(init_elf_core_debugfs);
> +
> +#endif		/* CONFIG_DEBUG_FS */
> +
>  #endif		/* CONFIG_ELF_CORE */
>  
>  static int __init init_elf_binfmt(void)
> @@ -2144,6 +2200,10 @@ static void __exit exit_elf_binfmt(void)
>  {
>  	/* Remove the COFF and ELF loaders. */
>  	unregister_binfmt(&elf_format);
> +
> +#if defined(CONFIG_ELF_CORE) && defined(CONFIG_DEBUG_FS)
> +	debugfs_remove(elf_core_debugfs);
> +#endif
>  }
>  
>  core_initcall(init_elf_binfmt);
>
> base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d

