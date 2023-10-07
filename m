Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693B97BC4A6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 06:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjJGE0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 00:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJGE03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 00:26:29 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31192BE
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 21:26:05 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae5ee80c0dso1793686b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 21:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696652764; x=1697257564; darn=vger.kernel.org;
        h=in-reply-to:from:cc:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rslvp6AitoH4rS23dFyU/ODj+5z33u/RNEcErDsfMPw=;
        b=eTqla1j1k3HDRye5PnobNXcjNgPJgqS9uI4LvFESnsXW8AgptQdIyXcEJaMruwpdCl
         0OkaehZTyy4QZKUO2c5RbRAskyY9XTs2xcB90UI115hBf5pvz1YD5L0aiBVnI3IkcqEz
         15wIDrC0g2hMWVPMkfD0PvLj5FwtzD4dPZsEDHO1vccLJZOnmi1C+Ztuhwpigu8U5INK
         2rk4G09on01n3IWmBWZFyX6eln/bBamCY97iSKwhT6Jo8G6o8wfb59iTy1u2x8tviRbc
         0mEp+Pz4yRNmawyobMRgy24FTNpgwE9ciduBDqa0aVq17cDT+TlB8Uledxyw8/mL5ueA
         97WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696652764; x=1697257564;
        h=in-reply-to:from:cc:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rslvp6AitoH4rS23dFyU/ODj+5z33u/RNEcErDsfMPw=;
        b=X9fA3fwSbPQ1d359X0ut36w6nlaqNod62DZ2lhhjpH0D0omv8NCYJ9wbPJxjvOTx/B
         Hfbxgvu6WlupH2Y4qnyMApQAZSNdgQGgSYO/M22yBN6HjNGJPTxoORkiRQAK4qbRQfFQ
         EWfpBwjMydJUnKvj9V8LOO1nBYlgxCUjumRJO693XQQXLU3/ZfgTwmKZUZdpRkqxPHT/
         1oJXZE50AcynF7kWaQBp0g7T5oyWkv6tiyoyB7K5NzaAkO36U2FUIDtm8G3+or3K0LPg
         rD+hmCjE9X4qF1I47B8GyIoaU1+PXs283Unu+6R2R93dKJBSou8PbzomZhL8lYOPZRhm
         QlDA==
X-Gm-Message-State: AOJu0YxcPdwp7C3I6zpkLv03vEzSf7maQHUp/1P0U4its0rI7F2wmBoo
        WiZdjUUJTLNSHZwSKlWLteNx3A==
X-Google-Smtp-Source: AGHT+IHH7Dy75gvrykHzeQf6CZs8dmhESWZVwzioYdWgJ8hBUOo2/Yy34HZgakNb6jz5tW8n9Nqa2A==
X-Received: by 2002:a05:6358:7f1c:b0:143:96ac:96da with SMTP id p28-20020a0563587f1c00b0014396ac96damr7391613rwn.2.1696652764294;
        Fri, 06 Oct 2023 21:26:04 -0700 (PDT)
Received: from [10.254.225.239] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id mt12-20020a17090b230c00b0027b168cb02asm5035336pjb.9.2023.10.06.21.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 21:26:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------0ZF2aWYZwteDjnDjJjSqArOh"
Message-ID: <9d347c17-55dd-a772-4d82-5d18b1206bc4@bytedance.com>
Date:   Sat, 7 Oct 2023 12:25:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 9/9] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
 <20230925035617.84767-10-zhangpeng.00@bytedance.com>
 <20231003184634.bbb5c5ezkvi6tkdv@revolver>
 <58ec7a15-6983-d199-bc1a-6161c3b75e0f@bytedance.com>
 <20231004195347.yggeosopqwb6ftos@revolver>
 <785511a6-8636-04e5-c002-907443b34dad@bytedance.com>
 <20231007011102.koplouxuumlog3cu@revolver>
 <20231007013231.ctzjap6uzvutuant@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20231007013231.ctzjap6uzvutuant@revolver>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0ZF2aWYZwteDjnDjJjSqArOh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/10/7 09:32, Liam R. Howlett 写道:
...
>>>>
>>>>>>>
>>>>>>> [1] https://github.com/kdlucas/byte-unixbench/tree/master
>>>>>>>
>>>>>>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>>>>>>> ---
>>>>>>>     include/linux/mm.h |  1 +
>>>>>>>     kernel/fork.c      | 34 ++++++++++++++++++++----------
>>>>>>>     mm/internal.h      |  3 ++-
>>>>>>>     mm/memory.c        |  7 ++++---
>>>>>>>     mm/mmap.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++--
>>>>>>>     5 files changed, 80 insertions(+), 17 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>>> index 1f1d0d6b8f20..10c59dc7ffaa 100644
>>>>>>> --- a/include/linux/mm.h
>>>>>>> +++ b/include/linux/mm.h
>>>>>>> @@ -3242,6 +3242,7 @@ extern void unlink_file_vma(struct vm_area_struct *);
>>>>>>>     extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>>>>>>>     	unsigned long addr, unsigned long len, pgoff_t pgoff,
>>>>>>>     	bool *need_rmap_locks);
>>>>>>> +extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end);
>>>>>>>     extern void exit_mmap(struct mm_struct *);
>>>>>>>     static inline int check_data_rlimit(unsigned long rlim,
>>>>>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>>>>>> index 7ae36c2e7290..2f3d83e89fe6 100644
>>>>>>> --- a/kernel/fork.c
>>>>>>> +++ b/kernel/fork.c
>>>>>>> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     	int retval;
>>>>>>>     	unsigned long charge = 0;
>>>>>>>     	LIST_HEAD(uf);
>>>>>>> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>>>>>>>     	VMA_ITERATOR(vmi, mm, 0);
>>>>>>>     	uprobe_start_dup_mmap();
>>>>>>> @@ -678,16 +677,25 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     		goto out;
>>>>>>>     	khugepaged_fork(mm, oldmm);
>>>>>>> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
>>>>>>> -	if (retval)
>>>>>>> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
>>>>>>> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
>>>>>>> +	if (unlikely(retval))
>>>>>>>     		goto out;
>>>>>>>     	mt_clear_in_rcu(vmi.mas.tree);
>>>>>>> -	for_each_vma(old_vmi, mpnt) {
>>>>>>> +	for_each_vma(vmi, mpnt) {
>>>>>>>     		struct file *file;
>>>>>>>     		vma_start_write(mpnt);
>>>>>>>     		if (mpnt->vm_flags & VM_DONTCOPY) {
>>>>>>> +			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
>>>>>>> +
>>>>>>> +			/* If failed, undo all completed duplications. */
>>>>>>> +			if (unlikely(mas_is_err(&vmi.mas))) {
>>>>>>> +				retval = xa_err(vmi.mas.node);
>>>>>>> +				goto loop_out;
>>>>>>> +			}
>>>>>>> +
>>>>>>>     			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>>>>>>>     			continue;
>>>>>>>     		}
>>>>>>> @@ -749,9 +757,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     		if (is_vm_hugetlb_page(tmp))
>>>>>>>     			hugetlb_dup_vma_private(tmp);
>>>>>>> -		/* Link the vma into the MT */
>>>>>>> -		if (vma_iter_bulk_store(&vmi, tmp))
>>>>>>> -			goto fail_nomem_vmi_store;
>>>>>>> +		/*
>>>>>>> +		 * Link the vma into the MT. After using __mt_dup(), memory
>>>>>>> +		 * allocation is not necessary here, so it cannot fail.
>>>>>>> +		 */
>>>>>>> +		mas_store(&vmi.mas, tmp);
>>>>>>>     		mm->map_count++;
>>>>>>>     		if (!(tmp->vm_flags & VM_WIPEONFORK))
>>>>>>> @@ -760,15 +770,19 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     		if (tmp->vm_ops && tmp->vm_ops->open)
>>>>>>>     			tmp->vm_ops->open(tmp);
>>>>>>> -		if (retval)
>>>>>>> +		if (retval) {
>>>>>>> +			mpnt = vma_next(&vmi);
>>>>>>>     			goto loop_out;
>>>>>>> +		}
>>>>>>>     	}
>>>>>>>     	/* a new mm has just been created */
>>>>>>>     	retval = arch_dup_mmap(oldmm, mm);
>>>>>>>     loop_out:
>>>>>>>     	vma_iter_free(&vmi);
>>>>>>> -	if (!retval)
>>>>>>> +	if (likely(!retval))
>>>>>>>     		mt_set_in_rcu(vmi.mas.tree);
>>>>>>> +	else
>>>>>>> +		undo_dup_mmap(mm, mpnt);
>>>>>>>     out:
>>>>>>>     	mmap_write_unlock(mm);
>>>>>>>     	flush_tlb_mm(oldmm);
>>>>>>> @@ -778,8 +792,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     	uprobe_end_dup_mmap();
>>>>>>>     	return retval;
>>>>>>> -fail_nomem_vmi_store:
>>>>>>> -	unlink_anon_vmas(tmp);
>>>>>>>     fail_nomem_anon_vma_fork:
>>>>>>>     	mpol_put(vma_policy(tmp));
>>>>>>>     fail_nomem_policy:
>>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>>> index 7a961d12b088..288ec81770cb 100644
>>>>>>> --- a/mm/internal.h
>>>>>>> +++ b/mm/internal.h
>>>>>>> @@ -111,7 +111,8 @@ void folio_activate(struct folio *folio);
>>>>>>>     void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>>>>>>     		   struct vm_area_struct *start_vma, unsigned long floor,
>>>>>>> -		   unsigned long ceiling, bool mm_wr_locked);
>>>>>>> +		   unsigned long ceiling, unsigned long tree_end,
>>>>>>> +		   bool mm_wr_locked);
>>>>>>>     void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>>>>>>>     struct zap_details;
>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>> index 983a40f8ee62..1fd66a0d5838 100644
>>>>>>> --- a/mm/memory.c
>>>>>>> +++ b/mm/memory.c
>>>>>>> @@ -362,7 +362,8 @@ void free_pgd_range(struct mmu_gather *tlb,
>>>>>>>     void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>>>>>>     		   struct vm_area_struct *vma, unsigned long floor,
>>>>>>> -		   unsigned long ceiling, bool mm_wr_locked)
>>>>>>> +		   unsigned long ceiling, unsigned long tree_end,
>>>>>>> +		   bool mm_wr_locked)
>>>>>>>     {
>>>>>>>     	do {
>>>>>>>     		unsigned long addr = vma->vm_start;
>>>>>>> @@ -372,7 +373,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>>>>>>     		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
>>>>>>>     		 * be 0.  This will underflow and is okay.
>>>>>>>     		 */
>>>>>>> -		next = mas_find(mas, ceiling - 1);
>>>>>>> +		next = mas_find(mas, tree_end - 1);
>>>>>>>     		/*
>>>>>>>     		 * Hide vma from rmap and truncate_pagecache before freeing
>>>>>>> @@ -393,7 +394,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>>>>>>     			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>>>>>>>     			       && !is_vm_hugetlb_page(next)) {
>>>>>>>     				vma = next;
>>>>>>> -				next = mas_find(mas, ceiling - 1);
>>>>>>> +				next = mas_find(mas, tree_end - 1);
>>>>>>>     				if (mm_wr_locked)
>>>>>>>     					vma_start_write(vma);
>>>>>>>     				unlink_anon_vmas(vma);
>>>>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>>>>> index 2ad950f773e4..daed3b423124 100644
>>>>>>> --- a/mm/mmap.c
>>>>>>> +++ b/mm/mmap.c
>>>>>>> @@ -2312,7 +2312,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>>>>>>>     	mas_set(mas, mt_start);
>>>>>>>     	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
>>>>>>>     				 next ? next->vm_start : USER_PGTABLES_CEILING,
>>>>>>> -				 mm_wr_locked);
>>>>>>> +				 tree_end, mm_wr_locked);
>>>>>>>     	tlb_finish_mmu(&tlb);
>>>>>>>     }
>>>>>>> @@ -3178,6 +3178,54 @@ int vm_brk(unsigned long addr, unsigned long len)
>>>>>>>     }
>>>>>>>     EXPORT_SYMBOL(vm_brk);
>>>>>>> +void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end)
>>>>>>> +{
>>>>>>> +	unsigned long tree_end;
>>>>>>> +	VMA_ITERATOR(vmi, mm, 0);
>>>>>>> +	struct vm_area_struct *vma;
>>>>>>> +	unsigned long nr_accounted = 0;
>>>>>>> +	int count = 0;
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * vma_end points to the first VMA that has not been duplicated. We need
>>>>>>> +	 * to unmap all VMAs before it.
>>>>>>> +	 * If vma_end is NULL, it means that all VMAs in the maple tree have
>>>>>>> +	 * been duplicated, so setting tree_end to 0 will overflow to ULONG_MAX
>>>>>>> +	 * when using it.
>>>>>>> +	 */
>>>>>>> +	if (vma_end) {
>>>>>>> +		tree_end = vma_end->vm_start;
>>>>>>> +		if (tree_end == 0)
>>>>>>> +			goto destroy;
>>>>>>> +	} else
>>>>>>> +		tree_end = 0;
>>
>> You need to enclose this statement to meet the coding style.  You could
>> just set tree_end = 0 at the start of the function instead, actually I
>> think tree_end = USER_PGTABLES_CEILING unless there is a vma_end.
>>
>>>>>>> +
>>>>>>> +	vma = mas_find(&vmi.mas, tree_end - 1);
>>
>> vma = vma_find(&vmi, tree_end);
>>
>>>>>>> +
>>>>>>> +	if (vma) {
>>
>> Probably would be cleaner to jump to destroy here too:
>> if (!vma)
>> 	goto destroy;
>>
>>>>>>> +		arch_unmap(mm, vma->vm_start, tree_end);
> 
> One more thing, it seems the maple state that is passed into
> unmap_region() needs to point to the _next_ element, or the reset
> doesn't work right between the unmap_vmas() and free_pgtables() call:
> 
> vma_iter_set(&vmi, vma->vm_end);
> 
> 
>>>>>>> +		unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end,
>>>>>>> +			     tree_end, true);
>>>>>>
>>>>>> next is vma_end, as per your comment above.  Using next = vma_end allows
>>>>>> you to avoid adding another argument to free_pgtables().
>>>>> Unfortunately, it cannot be done this way. I fell into this trap before,
>>>>> and it caused incomplete page table cleanup. To solve this problem, the
>>>>> only solution I can think of right now is to add an additional
>>>>> parameter.
>>>>>
>>>>> free_pgtables() will be called in unmap_region() to free the page table,
>>>>> like this:
>>>>>
>>>>> free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
>>>>> 		next ? next->vm_start : USER_PGTABLES_CEILING,
>>>>> 		mm_wr_locked);
>>>>>
>>>>> The problem is with 'next'. Our 'vma_end' does not exist in the actual
>>>>> mmap because it has not been duplicated and cannot be used as 'next'.
>>>>> If there is a real 'next', we can use 'next->vm_start' as the ceiling,
>>>>> which is not a problem. If there is no 'next' (next is 'vma_end'), we
>>>>> can only use 'USER_PGTABLES_CEILING' as the ceiling. Using
>>>>> 'vma_end->vm_start' as the ceiling will cause the page table not to be
>>>>> fully freed, which may be related to alignment in 'free_pgd_range()'. To
>>>>> solve this problem, we have to introduce 'tree_end', and separating
>>>>> 'tree_end' and 'ceiling' can solve this problem.
>>>>
>>>> Can you just use ceiling?  That is, just not pass in next and keep the
>>>> code as-is?  This is how exit_mmap() does it and should avoid any
>>>> alignment issues.  I assume you tried that and something went wrong as
>>>> well?
>>> I tried that, but it didn't work either. In free_pgtables(), the
>>> following line of code is used to iterate over VMAs:
>>> mas_find(mas, ceiling - 1);
>>> If next is passed as NULL, ceiling will be 0, resulting in iterating
>>> over all the VMAs in the maple tree, including the last portion that was
>>> not duplicated.
>>
>> If vma_end is NULL, it means that all VMAs in the maple tree have been
>> duplicated, so shouldn't the correct action in this case be freeing up
>> to ceiling?
Yes, that's correct.
>>
>> If it isn't null, then vma_end->vm_start should work as the end of the
>> area to free.
But there's an issue here. I initially thought the same way, but the
behavior of free_pgtables() is very strange. For the last VMA, it seems
that the ceiling passed to free_pgd_range() must be
USER_PGTABLES_CEILING.

It cannot be used vma_end->vm_start as the ceiling, possibly due to the
peculiar alignment behavior in free_pgd_range().

The code is from free_pgd_range():
	if (ceiling) {
		ceiling &= PMD_MASK;
		if (!ceiling)
			return;
	}
I suspect it is related to this part. The behavior differs when the
ceiling is equal to 0 or non-zero. However, I cannot comprehend all the
details here.

>>
>> With your mas_find(mas, tree_end - 1), then the vma_end will be avoided,
>> but free_pgd_range() will use ceiling anyways:
>>
>> free_pgd_range(tlb, addr, vma->vm_end, floor, next ? next->vm_start : ceiling);
>>
>> Passing in vma_end as next to unmap_region() functions in my testing
>> without adding arguments to free_pgtables().
>>
>> How are you producing the accounting issue you mention above?  Maybe I
>> missed something?
You can apply the patch provided at the bottom, and then use the test
program in Attachment 1 to reproduce the issue.

In dmesg, the kernel will report the following error:
[   14.829561] BUG: non-zero pgtables_bytes on freeing mm: 12288
[   14.832445] BUG: non-zero pgtables_bytes on freeing mm: 12288

diff --git a/kernel/fork.c b/kernel/fork.c
index 5f24f6d68ea4..fcc66acac480 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -688,7 +688,11 @@ static __latent_entropy int dup_mmap(struct 
mm_struct *mm,

  		vma_start_write(mpnt);
  		if (mpnt->vm_flags & VM_DONTCOPY) {
-			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
+			if (!strcmp(current->comm, "fork_test") && ktime_get_ns() % 2) {
+				vmi.mas.node = MA_ERROR(-ENOMEM);
+			} else {
+				mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
+			}

  			/* If failed, undo all completed duplications. */
  			if (unlikely(mas_is_err(&vmi.mas))) {

>>
>>
>>>>
>>>>>
>>>>>>
>>>>>>> +
>>>>>>> +		mas_set(&vmi.mas, vma->vm_end);
>> vma_iter_set(&vmi, vma->vm_end);
>>>>>>> +		do {
>>>>>>> +			if (vma->vm_flags & VM_ACCOUNT)
>>>>>>> +				nr_accounted += vma_pages(vma);
>>>>>>> +			remove_vma(vma, true);
>>>>>>> +			count++;
>>>>>>> +			cond_resched();
>>>>>>> +			vma = mas_find(&vmi.mas, tree_end - 1);
>>>>>>> +		} while (vma != NULL);
>>
>> You can write this as:
>> do { ... } for_each_vma_range(vmi, vma, tree_end);
>>
>>>>>>> +
>>>>>>> +		BUG_ON(count != mm->map_count);
>>>>>>> +
>>>>>>> +		vm_unacct_memory(nr_accounted);
>>>>>>> +	}
>>>>>>> +
>>>>>>> +destroy:
>>>>>>> +	__mt_destroy(&mm->mm_mt);
>>>>>>> +}
>>>>>>> +
>>>>>>>     /* Release all mmaps. */
>>>>>>>     void exit_mmap(struct mm_struct *mm)
>>>>>>>     {
>>>>>>> @@ -3217,7 +3265,7 @@ void exit_mmap(struct mm_struct *mm)
>>>>>>>     	mt_clear_in_rcu(&mm->mm_mt);
>>>>>>>     	mas_set(&mas, vma->vm_end);
>>>>>>>     	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
>>>>>>> -		      USER_PGTABLES_CEILING, true);
>>>>>>> +		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
>>>>>>>     	tlb_finish_mmu(&tlb);
>>>>>>>     	/*
>>>>>>> -- 
>>>>>>> 2.20.1
>>>>>>>
>>>>>>
>>>>>
>>>>
> 
--------------0ZF2aWYZwteDjnDjJjSqArOh
Content-Type: text/plain; charset=UTF-8; name="fork_test.c"
Content-Disposition: attachment; filename="fork_test.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy9t
bWFuLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CgppbnQg
bWFpbigpCnsKCWludCBjbnRfc3VjY2VzcyA9IDAsIGNudF9mYWlsdXJlID0gMDsKCWludCBz
dGF0dXM7CgoJdm9pZCAqYWRkciA9IG1tYXAoTlVMTCwgNDA5NiwgUFJPVF9SRUFEIHwgUFJP
VF9XUklURSwKCQkJICBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsKCWlm
IChhZGRyID09IE1BUF9GQUlMRUQpIHsKCQlwZXJyb3IoIm1tYXAgZmFpbGVkIik7CgkJZXhp
dCgxKTsKCX0KCWlmIChtcHJvdGVjdChhZGRyLCA0MDk2LCBQUk9UX1JFQUQgfCBQUk9UX1dS
SVRFIHwgUFJPVF9FWEVDKSA9PSAtMSkgewoJCXBlcnJvcigibXByb3RlY3QgZmFpbGVkIik7
CgkJZXhpdCgxKTsKCX0KCWlmIChtYWR2aXNlKGFkZHIsIDQwOTYsIE1BRFZfRE9OVEZPUksp
ID09IC0xKSB7CgkJcGVycm9yKCJtYWR2aXNlIGZhaWxlZCIpOwoJCWV4aXQoMSk7Cgl9Cglw
cmludGYoIlZNQSBjcmVhdGVkIGF0IGFkZHJlc3MgJXBcbiIsIGFkZHIpOwoKCWZvciAoaW50
IGkgPSAwOyBpIDwgMTAwMDA7IGkrKykgewoJCXBpZF90IHBpZCA9IGZvcmsoKTsKCQlpZiAo
cGlkID09IC0xKSB7CgkJCWNudF9mYWlsdXJlKys7CgkJfSBlbHNlIGlmIChwaWQgPT0gMCkg
ewoJCQlleGl0KEVYSVRfU1VDQ0VTUyk7CgkJfSBlbHNlIHsKCQkJY250X3N1Y2Nlc3MrKzsK
CQkJd2FpdCgmc3RhdHVzKTsKCQkJaWYgKHN0YXR1cyAhPSAwKSB7CgkJCQlmcHJpbnRmKHN0
ZGVyciwgIkJhZCB3YWl0IHN0YXR1czogMHgleFxuIiwKCQkJCQlzdGF0dXMpOwoJCQkJZXhp
dCgyKTsKCQkJfQoJCX0KCX0KCglwcmludGYoInN1Y2Nlc3M6JWQgZmFpbHVyZTolZFxuIiwg
Y250X3N1Y2Nlc3MsIGNudF9mYWlsdXJlKTsKCXJldHVybiAwOwp9Cg==

--------------0ZF2aWYZwteDjnDjJjSqArOh--
