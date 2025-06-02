Return-Path: <linux-fsdevel+bounces-50288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FFFACA9A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639EB189C228
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474651A23BA;
	Mon,  2 Jun 2025 07:01:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B0217A303;
	Mon,  2 Jun 2025 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748847661; cv=none; b=ZKbtkjIKb+Mur8nwMIZOmUeAJU1w57vmPEbahW6LSbmemhz6/ZvfoQ18uoQP8VEvQSkSHTerfg8gONBUKOYbxVKbNMdRc9eAfL2457TTSF9NOTkIznNoDvjOeF7FLbFABlmL1O6v747xdUDNo4fyzHQASIRK2+tVHFBKk/ya5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748847661; c=relaxed/simple;
	bh=QBMJkLc0wQAnxEqTmKS7OyKfGHDBz/H4Ncq1Et+vsWg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=RPPJEuz2UYfCUCgj79zGC3xdT9yFrSBQJyJfrIv9pRfYhMjzoo5tib4NseLXQXtU/PpqbcVMPhHP1DIx0dKOWIBPPGoEHR7+uffRTeGrris7FupnWi59Ve9kYpQ5XSCDU2GKrbw21Ryx1yLXjIfPFsIZvbQNG3LlGyGwqZkBAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4b9l9P2lN3z4xVct;
	Mon,  2 Jun 2025 15:00:41 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 55270TBw046379;
	Mon, 2 Jun 2025 15:00:29 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Jun 2025 15:00:31 +0800 (CST)
Date: Mon, 2 Jun 2025 15:00:31 +0800 (CST)
X-Zmail-TransId: 2afa683d4c0fffffffff94d-4260e
X-Mailer: Zmail v1.0
Message-ID: <20250602150031233VUeNfq2WjnCflANKAZbcb@zte.com.cn>
In-Reply-To: <3ba660af716d87a18ca5b4e635f2101edeb56340.1748537921.git.lorenzo.stoakes@oracle.com>
References: cover.1748537921.git.lorenzo.stoakes@oracle.com,3ba660af716d87a18ca5b4e635f2101edeb56340.1748537921.git.lorenzo.stoakes@oracle.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <lorenzo.stoakes@oracle.com>
Cc: <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <jack@suse.cz>, <Liam.Howlett@oracle.com>,
        <vbabka@suse.cz>, <jannh@google.com>, <pfalcato@suse.de>,
        <david@redhat.com>, <chengming.zhou@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <shr@devkernel.io>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAzLzRdIG1tOiBwcmV2ZW50IEtTTSBmcm9tIGJyZWFraW5nIFZNQSBtZXJnaW5nIGZvciBuZXcgVk1Bcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 55270TBw046379
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 683D4C19.000/4b9l9P2lN3z4xVct

> If a user wishes to enable KSM mergeability for an entire process and all
> fork/exec'd processes that come after it, they use the prctl()
> PR_SET_MEMORY_MERGE operation.
> 
> This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
> (in order to indicate they are KSM mergeable), as well as setting this flag
> for all existing VMAs and propagating this across fork/exec.
> 
> However it also breaks VMA merging for new VMAs, both in the process and
> all forked (and fork/exec'd) child processes.
> 
> This is because when a new mapping is proposed, the flags specified will
> never have VM_MERGEABLE set. However all adjacent VMAs will already have
> VM_MERGEABLE set, rendering VMAs unmergeable by default.
> 
> To work around this, we try to set the VM_MERGEABLE flag prior to
> attempting a merge. In the case of brk() this can always be done.
> 
> However on mmap() things are more complicated - while KSM is not supported
> for MAP_SHARED file-backed mappings, it is supported for MAP_PRIVATE
> file-backed mappings.
> 
> These mappings may have deprecated .mmap() callbacks specified which could,
> in theory, adjust flags and thus KSM eligibility.
> 
> So we check to determine whether this is possible. If not, we set
> VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
> previous behaviour.
> 
> This fixes VMA merging for all new anonymous mappings, which covers the
> majority of real-world cases, so we should see a significant improvement in
> VMA mergeability.
> 
> For MAP_PRIVATE file-backed mappings, those which implement the
> .mmap_prepare() hook and shmem are both known to be safe, so we allow
> these, disallowing all other cases.
> 
> Also add stubs for newly introduced function invocations to VMA userland
> testing.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process") # please no backport!
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


Thanks, everything looks clearer to me.
Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>





> ---
>  include/linux/ksm.h              |  8 +++---
>  mm/ksm.c                         | 18 ++++++++-----
>  mm/vma.c                         | 44 ++++++++++++++++++++++++++++++--
>  tools/testing/vma/vma_internal.h | 11 ++++++++
>  4 files changed, 70 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index d73095b5cd96..51787f0b0208 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -17,8 +17,8 @@
>  #ifdef CONFIG_KSM
>  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  		unsigned long end, int advice, unsigned long *vm_flags);
> -
> -void ksm_add_vma(struct vm_area_struct *vma);
> +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> +			 vm_flags_t vm_flags);
>  int ksm_enable_merge_any(struct mm_struct *mm);
>  int ksm_disable_merge_any(struct mm_struct *mm);
>  int ksm_disable(struct mm_struct *mm);
> @@ -97,8 +97,10 @@ bool ksm_process_mergeable(struct mm_struct *mm);
>  
>  #else  /* !CONFIG_KSM */
>  
> -static inline void ksm_add_vma(struct vm_area_struct *vma)
> +static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
> +		const struct file *file, vm_flags_t vm_flags)
>  {
> +	return vm_flags;
>  }
>  
>  static inline int ksm_disable(struct mm_struct *mm)
> diff --git a/mm/ksm.c b/mm/ksm.c
> index d0c763abd499..18b3690bb69a 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2731,16 +2731,22 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
>  	return 0;
>  }
>  /**
> - * ksm_add_vma - Mark vma as mergeable if compatible
> + * ksm_vma_flags - Update VMA flags to mark as mergeable if compatible
>   *
> - * @vma:  Pointer to vma
> + * @mm:       Proposed VMA's mm_struct
> + * @file:     Proposed VMA's file-backed mapping, if any.
> + * @vm_flags: Proposed VMA"s flags.
> + *
> + * Returns: @vm_flags possibly updated to mark mergeable.
>   */
> -void ksm_add_vma(struct vm_area_struct *vma)
> +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> +			 vm_flags_t vm_flags)
>  {
> -	struct mm_struct *mm = vma->vm_mm;
> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
> +	    __ksm_should_add_vma(file, vm_flags))
> +		vm_flags |= VM_MERGEABLE;
>  
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> -		__ksm_add_vma(vma);
> +	return vm_flags;
>  }
>  
>  static void ksm_add_vmas(struct mm_struct *mm)
> diff --git a/mm/vma.c b/mm/vma.c
> index 7ebc9eb608f4..3e351beb82ca 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2490,7 +2490,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	 */
>  	if (!vma_is_anonymous(vma))
>  		khugepaged_enter_vma(vma, map->flags);
> -	ksm_add_vma(vma);
>  	*vmap = vma;
>  	return 0;
>  
> @@ -2593,6 +2592,40 @@ static void set_vma_user_defined_fields(struct vm_area_struct *vma,
>  	vma->vm_private_data = map->vm_private_data;
>  }
>  
> +static void update_ksm_flags(struct mmap_state *map)
> +{
> +	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
> +}
> +
> +/*
> + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> + */
> +static bool can_set_ksm_flags_early(struct mmap_state *map)
> +{
> +	struct file *file = map->file;
> +
> +	/* Anonymous mappings have no driver which can change them. */
> +	if (!file)
> +		return true;
> +
> +	/*
> +	 * If .mmap_prepare() is specified, then the driver will have already
> +	 * manipulated state prior to updating KSM flags. So no need to worry
> +	 * about mmap callbacks modifying VMA flags after the KSM flag has been
> +	 * updated here, which could otherwise affect KSM eligibility.
> +	 */
> +	if (file->f_op->mmap_prepare)
> +		return true;
> +
> +	/* shmem is safe. */
> +	if (shmem_file(file))
> +		return true;
> +
> +	/* Any other .mmap callback is not safe. */
> +	return false;
> +}
> +
>  static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
> @@ -2603,6 +2636,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
>  	VMA_ITERATOR(vmi, mm, addr);
>  	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
> +	bool check_ksm_early = can_set_ksm_flags_early(&map);
>  
>  	error = __mmap_prepare(&map, uf);
>  	if (!error && have_mmap_prepare)
> @@ -2610,6 +2644,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	if (error)
>  		goto abort_munmap;
>  
> +	if (check_ksm_early)
> +		update_ksm_flags(&map);
> +
>  	/* Attempt to merge with adjacent VMAs... */
>  	if (map.prev || map.next) {
>  		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
> @@ -2619,6 +2656,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  
>  	/* ...but if we can't, allocate a new VMA. */
>  	if (!vma) {
> +		if (!check_ksm_early)
> +			update_ksm_flags(&map);
> +
>  		error = __mmap_new_vma(&map, &vma);
>  		if (error)
>  			goto unacct_error;
> @@ -2721,6 +2761,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * Note: This happens *after* clearing old mappings in some code paths.
>  	 */
>  	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> +	flags = ksm_vma_flags(mm, NULL, flags);
>  	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
>  		return -ENOMEM;
>  
> @@ -2764,7 +2805,6 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  
>  	mm->map_count++;
>  	validate_mm(mm);
> -	ksm_add_vma(vma);
>  out:
>  	perf_event_mmap(vma);
>  	mm->total_vm += len >> PAGE_SHIFT;
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 4505b1c31be1..77b2949d874a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1468,4 +1468,15 @@ static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
>  	(void)vma;
>  }
>  
> +static inline bool shmem_file(struct file *)
> +{
> +	return false;
> +}
> +
> +static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct file *,
> +			 vm_flags_t vm_flags)
> +{
> +	return vm_flags;
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> -- 
> 2.49.0

