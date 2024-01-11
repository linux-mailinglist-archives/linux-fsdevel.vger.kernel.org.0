Return-Path: <linux-fsdevel+bounces-7779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBE82AA7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C741F23A4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756314F8F;
	Thu, 11 Jan 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BremuP5j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6AE14A9C;
	Thu, 11 Jan 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704963874;
	bh=tm+pzNDRFsAnARFpOm+LIlSach1Kros+MV0VeCv7yrc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BremuP5jvAAl5/MN8tRS5dlaw57LcoGBW2TTIM4OOFuRKcwirKQHetzk7D0NqiaAS
	 H5RNIbFCv0Ky3SauRPuzQblqIa5Pf4jkoiL9oU8QlqCG0tJJojhEmx/qANrnAsq5Fl
	 49vNBz4XWvRIIXYdNFJ/sYHIRDzk4LPli8Eu25j4PtHuAW8EgPOX4iraBgd1xPQ+r1
	 mCF5bJ90HkMS9ItF5QsqKkL50hhACB1vGIAaLXjS0zdbnezhP+HxeSk+KKci0KeUjb
	 /CsyWHFoNFzf5vXbX8q9iZELi28Ha5l8q2ECPKAlqQvssdArkwj5jxWhReAzuCu89Y
	 9h/6shiHJmX+Q==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B8AE3781F80;
	Thu, 11 Jan 2024 09:04:30 +0000 (UTC)
Message-ID: <31c2d7d7-eaee-4730-9d27-05740f8ef911@collabora.com>
Date: Thu, 11 Jan 2024 14:04:36 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, teawater@gmail.com,
 Hui Zhu <teawater@antgroup.com>
Subject: Re: [PATCH] fs/proc/task_mmu.c: add_to_pagemap: Remove useless
 parameter addr
Content-Language: en-US
To: Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 david@redhat.com, avagin@google.com, peterx@redhat.com, hughd@google.com,
 ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com,
 adobriyan@gmail.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20240111084533.40038-1-teawaterz@linux.alibaba.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240111084533.40038-1-teawaterz@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 1:45 PM, Hui Zhu wrote:
> From: Hui Zhu <teawater@antgroup.com>
> 
> Function parameters addr of add_to_pagemap is useless.
> This commit remove it.
> 
> Signed-off-by: Hui Zhu <teawater@antgroup.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  fs/proc/task_mmu.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 62b16f42d5d2..882e2569fc31 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1352,8 +1352,7 @@ static inline pagemap_entry_t make_pme(u64 frame, u64 flags)
>  	return (pagemap_entry_t) { .pme = (frame & PM_PFRAME_MASK) | flags };
>  }
>  
> -static int add_to_pagemap(unsigned long addr, pagemap_entry_t *pme,
> -			  struct pagemapread *pm)
> +static int add_to_pagemap(pagemap_entry_t *pme, struct pagemapread *pm)
>  {
>  	pm->buffer[pm->pos++] = *pme;
>  	if (pm->pos >= pm->len)
> @@ -1380,7 +1379,7 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
>  			hole_end = end;
>  
>  		for (; addr < hole_end; addr += PAGE_SIZE) {
> -			err = add_to_pagemap(addr, &pme, pm);
> +			err = add_to_pagemap(&pme, pm);
>  			if (err)
>  				goto out;
>  		}
> @@ -1392,7 +1391,7 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
>  		if (vma->vm_flags & VM_SOFTDIRTY)
>  			pme = make_pme(0, PM_SOFT_DIRTY);
>  		for (; addr < min(end, vma->vm_end); addr += PAGE_SIZE) {
> -			err = add_to_pagemap(addr, &pme, pm);
> +			err = add_to_pagemap(&pme, pm);
>  			if (err)
>  				goto out;
>  		}
> @@ -1519,7 +1518,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		for (; addr != end; addr += PAGE_SIZE) {
>  			pagemap_entry_t pme = make_pme(frame, flags);
>  
> -			err = add_to_pagemap(addr, &pme, pm);
> +			err = add_to_pagemap(&pme, pm);
>  			if (err)
>  				break;
>  			if (pm->show_pfn) {
> @@ -1547,7 +1546,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		pagemap_entry_t pme;
>  
>  		pme = pte_to_pagemap_entry(pm, vma, addr, ptep_get(pte));
> -		err = add_to_pagemap(addr, &pme, pm);
> +		err = add_to_pagemap(&pme, pm);
>  		if (err)
>  			break;
>  	}
> @@ -1597,7 +1596,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>  	for (; addr != end; addr += PAGE_SIZE) {
>  		pagemap_entry_t pme = make_pme(frame, flags);
>  
> -		err = add_to_pagemap(addr, &pme, pm);
> +		err = add_to_pagemap(&pme, pm);
>  		if (err)
>  			return err;
>  		if (pm->show_pfn && (flags & PM_PRESENT))

-- 
BR,
Muhammad Usama Anjum

