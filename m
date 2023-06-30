Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2AE743E2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjF3PBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjF3PBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:01:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A93C0E;
        Fri, 30 Jun 2023 08:01:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5577004e21bso854198a12.2;
        Fri, 30 Jun 2023 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688137278; x=1690729278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSsTB0hmYO66HgY14Drqa9YRHmTG+NozNNyOOeYG7lo=;
        b=iKbCzPGkPYpkgH4fM65WJ2wRcQHtPOecpUEm1N0SAWWSKSCSB+V+QKZUDv6kXG7QaI
         zP6wi7hDms3+5uSzyJaflRvwQscjuCc83Vg4aasSgRdVeKjayuu8qJhqUvXGnDjYJFgV
         28EKkAJHk2fog3qt9+fAzSbj+iJH9ljxkC24Z06a2Rutir42QXVUcnN3HfeAbO4AoPBX
         yMKFHtfUEqWjTkD0z3+eiTmX7Xfr/cFyQcOfTBkExCZVh5bKuNg/byS1a+nzTqYgN1XX
         RhMsUWGeqjC62urg+MxGSObqdynQAQ+uPxX+OSO9zsyf5q/6VGqutidZFX1rbSTHrn/s
         Bj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688137278; x=1690729278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSsTB0hmYO66HgY14Drqa9YRHmTG+NozNNyOOeYG7lo=;
        b=MJfragh2VMHvck7M8D0Yo8lcBnjgP3LiE654HTFOpF6g9bJu+ZxM45P9sd0iUwyB9W
         NP+Np4KjXDbDJJ8hzG+myzfa+umC1hh7/SfQNrI9NteAQ0e3rqiBxQFBZbBGD4KGba1c
         fRKnvINQdpjijzjTpoYy0Luit0N4Y9An5PGQ+IVxDxpkHUNHOId0lPr5Qu40jZ3d8GOr
         edkRqLla76tAu7w9GkUlzvoLPNS5nDfZiHacoSvDQ83ymRXwf+xAy3tKv8KAJV2DkXxg
         DDHSqYmfiIgbnpX/lv96YchlgR0Cc6MP9e3gXdi0kV5uyZl+iBb5RO+zq8qjLn1mpQPm
         uq/Q==
X-Gm-Message-State: ABy/qLZzRe8mym4kXpao8qAV2Ke3P7Pn0/6IbPpMkCYenUFzygiECPcY
        pgSpXbP6vF9+ozKCBHXWnJcrKhgfP4djDQ==
X-Google-Smtp-Source: APBJJlE394MygCedoL+MS6kM8cWScMjYRUiThvmF9m2dsizYXYvsssqyJtnCfYrcSQjCd6bCWjxp2A==
X-Received: by 2002:a17:90b:1895:b0:259:466:940f with SMTP id mn21-20020a17090b189500b002590466940fmr1875936pjb.22.1688137277712;
        Fri, 30 Jun 2023 08:01:17 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a199200b0024df6bbf5d8sm4948680pji.30.2023.06.30.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:01:16 -0700 (PDT)
Date:   Fri, 30 Jun 2023 08:01:14 -0700
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v22 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZJ7uOqPIJwMiCuOI@gmail.com>
References: <20230628095426.1886064-1-usama.anjum@collabora.com>
 <20230628095426.1886064-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20230628095426.1886064-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 02:54:23PM +0500, Muhammad Usama Anjum wrote:
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT), swapped
>   (PAGE_IS_SWAPPED) or page has pfn zero (PAGE_IS_PFNZERO).
> - Find pages which have been written-to and/or write protect the pages
>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
> 
> This IOCTL can be extended to get information about more PTE bits. The
> entire address range passed by user [start, end) is scanned until either
> the user provided buffer is full or max_pages have been found.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

<snip>

> +
> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long __arg)
> +{
> +	struct pm_scan_arg __user *uarg = (struct pm_scan_arg __user *)__arg;
> +	unsigned long long start, end, walk_start, walk_end;
> +	unsigned long empty_slots, vec_index = 0;
> +	struct mmu_notifier_range range;
> +	struct page_region __user *vec;
> +	struct pagemap_scan_private p;
> +	struct pm_scan_arg arg;
> +	int ret = 0;
> +
> +	if (copy_from_user(&arg, uarg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	start = untagged_addr((unsigned long)arg.start);
> +	end = untagged_addr((unsigned long)arg.end);
> +	vec = (struct page_region __user *)untagged_addr((unsigned long)arg.vec);
> +
> +	ret = pagemap_scan_args_valid(&arg, start, end, vec);
> +	if (ret)
> +		return ret;
> +
> +	p.max_pages = (arg.max_pages) ? arg.max_pages : ULONG_MAX;
> +	p.found_pages = 0;
> +	p.required_mask = arg.required_mask;
> +	p.anyof_mask = arg.anyof_mask;
> +	p.excluded_mask = arg.excluded_mask;
> +	p.return_mask = arg.return_mask;
> +	p.flags = arg.flags;
> +	p.flags |= ((p.required_mask | p.anyof_mask | p.excluded_mask) &
> +		    PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
> +	p.cur_buf.start = p.cur_buf.len = p.cur_buf.flags = 0;
> +	p.vec_buf = NULL;
> +	p.vec_buf_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
> +
> +	/*
> +	 * Allocate smaller buffer to get output from inside the page walk
> +	 * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
> +	 * we want to return output to user in compact form where no two
> +	 * consecutive regions should be continuous and have the same flags.
> +	 * So store the latest element in p.cur_buf between different walks and
> +	 * store the p.cur_buf at the end of the walk to the user buffer.
> +	 */
> +	if (IS_PM_SCAN_GET(p.flags)) {
> +		p.vec_buf = kmalloc_array(p.vec_buf_len, sizeof(*p.vec_buf),
> +					  GFP_KERNEL);
> +		if (!p.vec_buf)
> +			return -ENOMEM;
> +	}
> +
> +	if (IS_PM_SCAN_WP(p.flags)) {
> +		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
> +					mm, start, end);
> +		mmu_notifier_invalidate_range_start(&range);
> +	}
> +
> +	walk_start = walk_end = start;
> +	while (walk_end < end && !ret) {
> +		if (IS_PM_SCAN_GET(p.flags)) {
> +			p.vec_buf_index = 0;
> +
> +			/*
> +			 * All data is copied to cur_buf first. When more data
> +			 * is found, we push cur_buf to vec_buf and copy new
> +			 * data to cur_buf. Subtract 1 from length as the
> +			 * index of cur_buf isn't counted in length.
> +			 */
> +			empty_slots = arg.vec_len - vec_index;
> +			p.vec_buf_len = min(p.vec_buf_len, empty_slots - 1);
> +		}
> +
> +		ret = mmap_read_lock_killable(mm);
> +		if (ret)
> +			goto return_status;
> +
> +		walk_end = min((walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK, end);
> +
> +		ret = walk_page_range(mm, walk_start, walk_end,
> +				      &pagemap_scan_ops, &p);
> +		mmap_read_unlock(mm);
> +
> +		if (ret && ret != PM_SCAN_FOUND_MAX_PAGES &&
> +		    ret != PM_SCAN_END_WALK)
> +			goto return_status;
> +
> +		walk_start = walk_end;
> +		if (IS_PM_SCAN_GET(p.flags) && p.vec_buf_index) {
> +			if (copy_to_user(&vec[vec_index], p.vec_buf,
> +					 p.vec_buf_index * sizeof(*p.vec_buf))) {
> +				/*
> +				 * Return error even though the OP succeeded
> +				 */
> +				ret = -EFAULT;
> +				goto return_status;
> +			}
> +			vec_index += p.vec_buf_index;
> +		}
> +	}
> +
> +	if (p.cur_buf.len) {
> +		if (copy_to_user(&vec[vec_index], &p.cur_buf, sizeof(p.cur_buf))) {
> +			ret = -EFAULT;
> +			goto return_status;
> +		}
> +		vec_index++;
> +	}
> +
> +	ret = vec_index;
> +
> +return_status:
> +	arg.start = (unsigned long)walk_end;

This doesn't look right. pagemap_scan_pmd_entry can stop early. For
example, it can happen when it hits the max_pages limit. Do I miss
something?

> +	if (copy_to_user(&uarg->start, &arg.start, sizeof(arg.start)))
> +		ret = -EFAULT;
> +
> +	if (IS_PM_SCAN_WP(p.flags))
> +		mmu_notifier_invalidate_range_end(&range);
> +
> +	kfree(p.vec_buf);
> +	return ret;
> +}
> +
