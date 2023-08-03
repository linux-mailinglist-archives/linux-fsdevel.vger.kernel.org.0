Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D07776ED99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbjHCPJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjHCPJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:09:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C189E73;
        Thu,  3 Aug 2023 08:09:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb775625e2so7780275ad.1;
        Thu, 03 Aug 2023 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691075341; x=1691680141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5s/JrLjZm3/Sn2v9j1gCdilXGNpd8+gNtwp+vcvJtY=;
        b=aXwP1asCyDGD4OQ7ZiOTqhEXsyMwixSeoWrL/WxlI06Bag22WfNyUa/DrnsUpTKA9a
         cU24rkETSXN6igfBAfIlKQTO+ICl7w4uxHc7x65lQ9lYgecinptO4c7lXBfrxdFwlGEZ
         EcYHdib3BRP90Y8mHPYaxjc0hg1LzqcdgVoDs9U8on/+Q72tOICjlQufy4ANCwR2wHtD
         ltiEsVZrIsFMMPfeJmNG6m2fd7ThVCMmAfBhmNH0Ou4qbvyOpVVQ9dm3SWGxavs9ZJuf
         X79cQbMZZZJpsD5LHhwohBy5MUF/yV4rqbbbijg0day5UMYEy5yCJmtT/QXeIi5iZT4r
         INhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691075341; x=1691680141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5s/JrLjZm3/Sn2v9j1gCdilXGNpd8+gNtwp+vcvJtY=;
        b=jwBuB0y0XIycNruvrP3dbsno+skxoDzpEiENSEzPG9BXERJA1pWvPDjfMBydLkWyk6
         axYNzF33rV8SUMu0P9nWDR5Kp7Ybpmaa4B1cyw3s27N6ki+cUnJdlrF5KbD2uTV+I+9C
         qfmZMdxE1vxzy/Bz1PavKt/2WFx9K/ZR42Fk2aaqLhIgDpSqyrvrmUM3QlpsCG3VlDcP
         GAxfYKzjM113ZVlwXwV3mUEmu205GByZeCcCEO8AgAeC1rYNGTaGDJYYKBaLyNlJO3EQ
         qqtvqDJytx9vQqD7iTReYB+1mYqva1FZnzJdNel9t4fHgaPSJH6WhcvjSycEXHAJcekf
         Yk1w==
X-Gm-Message-State: ABy/qLZ3eEu95OKpNnQ8Fu8nmOE92fELaF0cxEEfsdhtNwA1rA1CmBBU
        BQmv3k7K39GFDV6L6Q93hgmZ6PFFpTBxhw==
X-Google-Smtp-Source: APBJJlEGN6K8FJM/VPBmpP0/utJCwSdtmN0sSisLyuEOUczmlt/glOctIL8NKeOWFjgeidEEW+/dLQ==
X-Received: by 2002:a17:902:db06:b0:1b8:76d1:f1e8 with SMTP id m6-20020a170902db0600b001b876d1f1e8mr21988305plx.28.1691075341160;
        Thu, 03 Aug 2023 08:09:01 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:bd71:fea:c430:7b0a])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001b7ffca7dbcsm14497273plb.148.2023.08.03.08.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:09:00 -0700 (PDT)
Date:   Thu, 3 Aug 2023 08:08:57 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZMvDCeUN8qrUmnJV@gmail.com>
References: <20230727093637.1262110-1-usama.anjum@collabora.com>
 <20230727093637.1262110-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20230727093637.1262110-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:36:34PM +0500, Muhammad Usama Anjum wrote:

<snip>

> +
> +static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
> +				       unsigned long addr, unsigned long end,
> +				       unsigned long end_addr)

It hard to figure out what difference between end and end_addr. I would
add a comment here.

> +{
> +	struct page_region *cur_buf = &p->cur_buf;
> +
> +	if (cur_buf->start != addr)
> +		cur_buf->end = addr;
> +	else
> +		cur_buf->start = cur_buf->end = 0;
> +
> +	p->end_addr = end_addr;
> +	p->found_pages -= (end - addr) / PAGE_SIZE;
> +}
> +
> +static int pagemap_scan_output(unsigned long categories,
> +			       struct pagemap_scan_private *p,
> +			       unsigned long addr, unsigned long *end)
> +{
> +	unsigned long n_pages, total_pages;
> +	int ret = 0;
> +
> +	if (!pagemap_scan_is_interesting_page(categories, p)) {
> +		*end = addr;
> +		return 0;
> +	}
> +
> +	if (!p->vec_buf)
> +		return 0;
> +
> +	categories &= p->arg.return_mask;
> +
> +	n_pages = (*end - addr) / PAGE_SIZE;
> +	if (check_add_overflow(p->found_pages, n_pages, &total_pages) ||
> +	    total_pages > p->arg.max_pages) {

why do we need to use check_add_overflow here?

> +		size_t n_too_much = total_pages - p->arg.max_pages;

it is unsafe to use total_pages if check_add_overflow returns non-zero.

> +		*end -= n_too_much * PAGE_SIZE;
> +		n_pages -= n_too_much;
> +		ret = -ENOSPC;
> +	}
> +
> +	if (!pagemap_scan_push_range(categories, p, addr, *end)) {
> +		*end = addr;
> +		n_pages = 0;
> +		ret = -ENOSPC;
> +	}
> +
> +	p->found_pages += n_pages;
> +	if (ret)
> +		p->end_addr = *end;
> +
> +	return ret;
> +}
> +
> +static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
> +				  unsigned long end, struct mm_walk *walk)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long categories;
> +	spinlock_t *ptl;
> +	int ret = 0;
> +
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (!ptl)
> +		return -ENOENT;
> +
> +	categories = p->cur_vma_category | pagemap_thp_category(*pmd);
> +
> +	ret = pagemap_scan_output(categories, p, start, &end);
> +	if (start == end)
> +		goto out_unlock;
> +
> +	if (~p->arg.flags & PM_SCAN_WP_MATCHING)
> +		goto out_unlock;
> +	if (~categories & PAGE_IS_WRITTEN)
> +		goto out_unlock;
> +
> +	/*
> +	 * Break huge page into small pages if the WP operation
> +	 * need to be performed is on a portion of the huge page.
> +	 */
> +	if (end != start + HPAGE_SIZE) {
> +		spin_unlock(ptl);
> +		split_huge_pmd(vma, pmd, start);
> +		pagemap_scan_backout_range(p, start, end, 0);

pagemap_scan_backout_range looks "weird"... imho, it makes the code
harder for understanding.

> +		return -ENOENT;

I think you need to add a comment that this ENOENT is a special case.

> +	}
> +
> +	make_uffd_wp_pmd(vma, start, pmd);
> +	flush_tlb_range(vma, start, end);
> +out_unlock:
> +	spin_unlock(ptl);
> +	return ret;
> +#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> +	return -ENOENT;
> +#endif
> +}
> +
> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +				  unsigned long end, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	pte_t *pte, *start_pte;
> +	unsigned long addr;
> +	bool flush = false;
> +	spinlock_t *ptl;
> +	int ret;
> +
> +	arch_enter_lazy_mmu_mode();
> +
> +	ret = pagemap_scan_thp_entry(pmd, start, end, walk);
> +	if (ret != -ENOENT) {
> +		arch_leave_lazy_mmu_mode();
> +		return ret;
> +	}
> +
> +	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
> +	if (!pte) {
> +		arch_leave_lazy_mmu_mode();
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
> +
> +	for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
> +		unsigned long categories = p->cur_vma_category |
> +					   pagemap_page_category(vma, addr, ptep_get(pte));
> +		unsigned long next = addr + PAGE_SIZE;
> +
> +		ret = pagemap_scan_output(categories, p, addr, &next);
> +		if (next == addr) {
> +			if (!ret)
> +				continue;
> +			break;
> +		}
> +
> +		if (~p->arg.flags & PM_SCAN_WP_MATCHING)
> +			continue;
> +		if (~categories & PAGE_IS_WRITTEN)
> +			continue;
> +
> +		make_uffd_wp_pte(vma, addr, pte);
> +		if (!flush) {
> +			start = addr;
> +			flush = true;
> +		}
> +	}
> +
> +	if (flush)
> +		flush_tlb_range(vma, start, addr);
> +
> +	pte_unmap_unlock(start_pte, ptl);
> +	arch_leave_lazy_mmu_mode();
> +
> +	cond_resched();
> +	return ret;
> +}
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
> +				      unsigned long start, unsigned long end,
> +				      struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long categories;
> +	spinlock_t *ptl;
> +	int ret = 0;
> +	pte_t pte;
> +
> +	if (~p->arg.flags & PM_SCAN_WP_MATCHING) {
> +		/* Go the short route when not write-protecting pages. */
> +
> +		pte = huge_ptep_get(ptep);
> +		categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
> +
> +		return pagemap_scan_output(categories, p, start, &end);
> +	}
> +
> +	i_mmap_lock_write(vma->vm_file->f_mapping);
> +	ptl = huge_pte_lock(hstate_vma(vma), vma->vm_mm, ptep);
> +
> +	pte = huge_ptep_get(ptep);
> +	categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
> +
> +	ret = pagemap_scan_output(categories, p, start, &end);
> +	if (start == end)
> +		goto out_unlock;
> +
> +	if (~categories & PAGE_IS_WRITTEN)
> +		goto out_unlock;
> +
> +	if (end != start + HPAGE_SIZE) {
> +		/* Partial HugeTLB page WP isn't possible. */
> +		pagemap_scan_backout_range(p, start, end, start);
> +		ret = -EINVAL;

Why is it EINVAL in this case?

> +		goto out_unlock;
> +	}
> +
> +	make_uffd_wp_huge_pte(vma, start, ptep, pte);
> +	flush_hugetlb_tlb_range(vma, start, end);
> +
> +out_unlock:
> +	spin_unlock(ptl);
> +	i_mmap_unlock_write(vma->vm_file->f_mapping);
> +
> +	return ret;
> +}
> +#else
> +#define pagemap_scan_hugetlb_entry NULL
> +#endif
> +
> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
> +				 int depth, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	int ret, err;
> +
> +	if (!vma)
> +		return 0;
> +
> +	ret = pagemap_scan_output(p->cur_vma_category, p, addr, &end);
> +	if (addr == end)
> +		return ret;
> +
> +	if (~p->arg.flags & PM_SCAN_WP_MATCHING)
> +		return ret;
> +
> +	err = uffd_wp_range(vma, addr, end - addr, true);
> +	if (err < 0)
> +		ret = err;
> +
> +	return ret;
> +}
> +
> +static const struct mm_walk_ops pagemap_scan_ops = {
> +	.test_walk = pagemap_scan_test_walk,
> +	.pmd_entry = pagemap_scan_pmd_entry,
> +	.pte_hole = pagemap_scan_pte_hole,
> +	.hugetlb_entry = pagemap_scan_hugetlb_entry,
> +};
> +
> +static int pagemap_scan_get_args(struct pm_scan_arg *arg,
> +				 unsigned long uarg)
> +{
> +	if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))
> +		return -EFAULT;
> +
> +	if (arg->size != sizeof(struct pm_scan_arg))
> +		return -EINVAL;
> +
> +	/* Validate requested features */
> +	if (arg->flags & ~PM_SCAN_FLAGS)
> +		return -EINVAL;
> +	if ((arg->category_inverted | arg->category_mask |
> +	     arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
> +		return -EINVAL;
> +
> +	arg->start = untagged_addr((unsigned long)arg->start);
> +	arg->end = untagged_addr((unsigned long)arg->end);
> +	arg->vec = untagged_addr((unsigned long)arg->vec);
> +
> +	/* Validate memory pointers */
> +	if (!IS_ALIGNED(arg->start, PAGE_SIZE))
> +		return -EINVAL;
> +	if (!access_ok((void __user *)arg->start, arg->end - arg->start))
> +		return -EFAULT;
> +	if (!arg->vec && arg->vec_len)
> +		return -EFAULT;
> +	if (arg->vec && !access_ok((void __user *)arg->vec,
> +			      arg->vec_len * sizeof(struct page_region)))
> +		return -EFAULT;
> +
> +	/* Fixup default values */
> +	arg->end = ALIGN(arg->end, PAGE_SIZE);
> +	if (!arg->max_pages)
> +		arg->max_pages = ULONG_MAX;
> +
> +	return 0;
> +}
> +
> +static int pagemap_scan_writeback_args(struct pm_scan_arg *arg,
> +				       unsigned long uargl)
> +{
> +	struct pm_scan_arg __user *uarg	= (void __user *)uargl;
> +
> +	if (copy_to_user(&uarg->walk_end, &arg->walk_end, sizeof(arg->walk_end)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int pagemap_scan_init_bounce_buffer(struct pagemap_scan_private *p)
> +{
> +	if (!p->arg.vec_len) {
> +		/*
> +		 * An arbitrary non-page-aligned sentinel value for
> +		 * pagemap_scan_push_range().
> +		 */
> +		p->cur_buf.start = p->cur_buf.end = ULLONG_MAX;
> +		if (p->arg.vec)
> +			p->vec_buf = ZERO_SIZE_PTR;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Allocate a smaller buffer to get output from inside the page
> +	 * walk functions and walk the range in PAGEMAP_WALK_SIZE chunks.
> +	 * The last range is always stored in p.cur_buf to allow coalescing
> +	 * consecutive ranges that have the same categories returned across
> +	 * walk_page_range() calls.
> +	 */
> +	p->vec_buf_len = min_t(size_t, PAGEMAP_WALK_SIZE >> PAGE_SHIFT,
> +			       p->arg.vec_len - 1);
> +	p->vec_buf = kmalloc_array(p->vec_buf_len, sizeof(*p->vec_buf),
> +				   GFP_KERNEL);
> +	if (!p->vec_buf)
> +		return -ENOMEM;
> +
> +	p->vec_out = (struct page_region __user *)p->arg.vec;
> +
> +	return 0;
> +}
> +
> +static int pagemap_scan_flush_buffer(struct pagemap_scan_private *p)
> +{
> +	const struct page_region *buf = p->vec_buf;
> +	int n = (int)p->vec_buf_index;
> +
> +	if (!n)
> +		return 0;
> +
> +	if (copy_to_user(p->vec_out, buf, n * sizeof(*buf)))
> +		return -EFAULT;
> +
> +	p->arg.vec_len -= n;
> +	p->vec_out += n;
> +
> +	p->vec_buf_index = 0;
> +	p->vec_buf_len = min_t(size_t, p->vec_buf_len, p->arg.vec_len - 1);
> +
> +	return n;
> +}
> +
> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
> +{
> +	unsigned long walk_start, walk_end;
> +	struct mmu_notifier_range range;
> +	struct pagemap_scan_private p;
> +	size_t n_ranges_out = 0;
> +	int ret;
> +
> +	memset(&p, 0, sizeof(p));
> +	ret = pagemap_scan_get_args(&p.arg, uarg);
> +	if (ret)
> +		return ret;
> +
> +	ret = pagemap_scan_init_bounce_buffer(&p);
> +	if (ret)
> +		return ret;
> +
> +	/* Protection change for the range is going to happen. */
> +	if (p.arg.flags & PM_SCAN_WP_MATCHING) {
> +		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
> +					mm, p.arg.start, p.arg.end);
> +		mmu_notifier_invalidate_range_start(&range);
> +	}
> +
> +	walk_start = walk_end = p.arg.start;
> +	for (; walk_end != p.arg.end; walk_start = walk_end) {
> +		int n_out;
> +
> +		walk_end = min_t(unsigned long,
> +				 (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK,
> +				 p.arg.end);
> +

if (fatal_signal_pending(current)) {
	ret = EINTR;
	break;
}

> +		ret = mmap_read_lock_killable(mm);
> +		if (ret)
> +			break;
> +		ret = walk_page_range(mm, walk_start, walk_end,
> +				      &pagemap_scan_ops, &p);
> +		mmap_read_unlock(mm);
> +
> +		n_out = pagemap_scan_flush_buffer(&p);
> +		if (n_out < 0)
> +			ret = n_out;
> +		else
> +			n_ranges_out += n_out;
> +
> +		if (ret)
> +			break;
> +	}
> +
> +	if (p.cur_buf.start != p.cur_buf.end) {
> +		if (copy_to_user(p.vec_out, &p.cur_buf, sizeof(p.cur_buf)))
> +			ret = -EFAULT;
> +		else
> +			++n_ranges_out;
> +	}
> +
> +	/* ENOSPC signifies early stop (buffer full) from the walk. */
> +	if (!ret || ret == -ENOSPC)
> +		ret = n_ranges_out;
> +
> +	p.arg.walk_end = p.end_addr ? p.end_addr : walk_start;
> +	if (pagemap_scan_writeback_args(&p.arg, uarg))
> +		ret = -EFAULT;
> +
> +	if (p.arg.flags & PM_SCAN_WP_MATCHING)
> +		mmu_notifier_invalidate_range_end(&range);
> +
> +	kfree(p.vec_buf);
> +	return ret;
> +}
> +
> +static long do_pagemap_cmd(struct file *file, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	struct mm_struct *mm = file->private_data;
> +
> +	switch (cmd) {
> +	case PAGEMAP_SCAN:
> +		return do_pagemap_scan(mm, arg);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  const struct file_operations proc_pagemap_operations = {
>  	.llseek		= mem_lseek, /* borrow this */
>  	.read		= pagemap_read,
>  	.open		= pagemap_open,
>  	.release	= pagemap_release,
> +	.unlocked_ioctl = do_pagemap_cmd,
> +	.compat_ioctl	= do_pagemap_cmd,
>  };
>  #endif /* CONFIG_PROC_PAGE_MONITOR */
>  
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 0a393bc02f25b..8f8ff07453f22 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -259,6 +259,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  		unsigned long cp_flags);
>  
>  bool is_hugetlb_entry_migration(pte_t pte);
> +bool is_hugetlb_entry_hwpoisoned(pte_t pte);
>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
>  
>  #else /* !CONFIG_HUGETLB_PAGE */
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c5..1bb3c625c2381 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -305,4 +305,62 @@ typedef int __bitwise __kernel_rwf_t;
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>  			 RWF_APPEND)
>  
> +/* Pagemap ioctl */
> +#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
> +
> +/* Bits are set in flags of the page_region and masks in pm_scan_args */
> +#define PAGE_IS_WPALLOWED	(1 << 0)
> +#define PAGE_IS_WRITTEN		(1 << 1)
> +#define PAGE_IS_FILE		(1 << 2)
> +#define PAGE_IS_PRESENT		(1 << 3)
> +#define PAGE_IS_SWAPPED		(1 << 4)
> +#define PAGE_IS_PFNZERO		(1 << 5)
> +
> +/*
> + * struct page_region - Page region with flags
> + * @start:	Start of the region
> + * @end:	End of the region (exclusive)
> + * @categories:	PAGE_IS_* category bitmask for the region
> + */
> +struct page_region {
> +	__u64 start;
> +	__u64 end;
> +	__u64 categories;
> +};
> +
> +/* Flags for PAGEMAP_SCAN ioctl */
> +#define PM_SCAN_WP_MATCHING	(1 << 0)	/* Write protect the pages matched. */
> +#define PM_SCAN_CHECK_WPASYNC	(1 << 1)	/* Abort the scan when a non-WP-enabled page is found. */
> +
> +/*
> + * struct pm_scan_arg - Pagemap ioctl argument
> + * @size:		Size of the structure
> + * @flags:		Flags for the IOCTL
> + * @start:		Starting address of the region
> + * @end:		Ending address of the region
> + * @walk_end:		Ending address of the visited memory is returned
> + *			(This helps if entire range hasn't been visited)
> + * @vec:		Address of page_region struct array for output
> + * @vec_len:		Length of the page_region struct array
> + * @max_pages:		Optional limit for number of returned pages (0 = disabled)
> + * @category_inverted:	PAGE_IS_* categories which values match if 0 instead of 1
> + * @category_mask:	Skip pages for which any category doesn't match
> + * @category_anyof_mask: Skip pages for which no category matches
> + * @return_mask:	PAGE_IS_* categories that are to be reported in `page_region`s returned
> + */
> +struct pm_scan_arg {
> +	__u64 size;
> +	__u64 flags;
> +	__u64 start;
> +	__u64 end;
> +	__u64 walk_end;
> +	__u64 vec;
> +	__u64 vec_len;
> +	__u64 max_pages;
> +	__u64 category_inverted;
> +	__u64 category_mask;
> +	__u64 category_anyof_mask;
> +	__u64 return_mask;
> +};
> +
>  #endif /* _UAPI_LINUX_FS_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a073e6ed8900b..3b07db0a4f2d9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5008,7 +5008,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
>  		return false;
>  }
>  
> -static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
> +bool is_hugetlb_entry_hwpoisoned(pte_t pte)
>  {
>  	swp_entry_t swp;
>  
> -- 
> 2.39.2
> 
