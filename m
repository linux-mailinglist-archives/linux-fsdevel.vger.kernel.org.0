Return-Path: <linux-fsdevel+bounces-13856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DCC874C9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C1728775A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B68529A;
	Thu,  7 Mar 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oK3hZtRn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C61D699;
	Thu,  7 Mar 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808242; cv=none; b=IMChZ0DIZEv15P6G+5bVFIHftRgwogHD4OMHIiBlZw/Rgv3hhibx+7p1e3dSZ1xu7pkmff4d3ro94fpUD5ZQEYmt8HG3/he3Y4oJ/wnSS3Flrd8KC+dP8u5qA/zuQR9V4xpMRDzjWNHr981QHXqGi/BDQIHRKFP58gjy0kqNhXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808242; c=relaxed/simple;
	bh=k0wg7qIECji7q28HelXRDU1MuWYWt7ZKoT/fy2ixp8I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FtL87WANMSEzqEvKN0qznI3b6ZICL6GYhyMIbaoz12Q0LV6a4FrpRvaMgsjFpQxmpxcQzPamvv0ILYEmDjG4Vatmk/vw+K8vz81Ek8ePAGhwovWWuQPgAFChPsIa6I76SHMdE8qFI1QP8mNPNBQHmJCe3z6+TlhXAQMh372R0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oK3hZtRn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709808238;
	bh=k0wg7qIECji7q28HelXRDU1MuWYWt7ZKoT/fy2ixp8I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oK3hZtRntHn5hpgtf/gZlqZNjgs9FVIGRX7PODR8hiBxLS2fG9ZXAiZ5M6BGlo4gK
	 oT4oMtkNrUO52Au3E1PB9z/u3VzviqSAkf229UTWGz84wHqJs3DWBINPkFIpsj7MnZ
	 HBOoA8u/UbRHRh1koH72lVaMVOoO5Y73NoEPyiJZ9N+Tykygq5DJy/LNR1veI7tKfL
	 gkBRn4KEaJ5+oCFFK7/9N6r3aYHRsylGkM0Yih7zISIyvCdqctHEK/Y1gEVExefxLp
	 OTeqg9bI5QuY3rgJABjonIPW0GYpVofKM3KzzsfjHnnhJzcH2I0AztdJhVNoiMi+/1
	 QfwF4ugmFIKUg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2CA0F3780EC6;
	Thu,  7 Mar 2024 10:43:52 +0000 (UTC)
Message-ID: <f5e8aee4-4985-48a1-849a-8837dfab07ea@collabora.com>
Date: Thu, 7 Mar 2024 15:44:20 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, upstream+pagemap@sigma-star.at,
 adobriyan@gmail.com, wangkefeng.wang@huawei.com, ryan.roberts@arm.com,
 hughd@google.com, peterx@redhat.com, david@redhat.com, avagin@google.com,
 lstoakes@gmail.com, vbabka@suse.cz, akpm@linux-foundation.org, corbet@lwn.net
Subject: Re: [PATCH 1/2] [RFC] proc: pagemap: Expose whether a PTE is writable
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, linux-mm@kvack.org
References: <20240306232339.29659-1-richard@nod.at>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240306232339.29659-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/24 4:23 AM, Richard Weinberger wrote:
> Is a PTE present and writable, bit 58 will be set.
> This allows detecting CoW memory mappings and other mappings
> where a write access will cause a page fault.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/proc/task_mmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3f78ebbb795f..7c7e0e954c02 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1341,6 +1341,7 @@ struct pagemapread {
>  #define PM_SOFT_DIRTY		BIT_ULL(55)
>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>  #define PM_UFFD_WP		BIT_ULL(57)
> +#define PM_WRITE		BIT_ULL(58)
The name doesn't mention present from its "present and writable"
definition. Maybe some other name like PM_PRESENT_WRITE?

>  #define PM_FILE			BIT_ULL(61)
>  #define PM_SWAP			BIT_ULL(62)
>  #define PM_PRESENT		BIT_ULL(63)
> @@ -1417,6 +1418,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>  			flags |= PM_SOFT_DIRTY;
>  		if (pte_uffd_wp(pte))
>  			flags |= PM_UFFD_WP;
> +		if (pte_write(pte))
> +			flags |= PM_WRITE;
>  	} else if (is_swap_pte(pte)) {
>  		swp_entry_t entry;
>  		if (pte_swp_soft_dirty(pte))
> @@ -1483,6 +1486,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  				flags |= PM_SOFT_DIRTY;
>  			if (pmd_uffd_wp(pmd))
>  				flags |= PM_UFFD_WP;
> +			if (pmd_write(pmd))
> +				flags |= PM_WRITE;
>  			if (pm->show_pfn)
>  				frame = pmd_pfn(pmd) +
>  					((addr & ~PMD_MASK) >> PAGE_SHIFT);
> @@ -1586,6 +1591,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>  		if (huge_pte_uffd_wp(pte))
>  			flags |= PM_UFFD_WP;
>  
> +		if (pte_write(pte))
> +			flags |= PM_WRITE;
> +
>  		flags |= PM_PRESENT;
>  		if (pm->show_pfn)
>  			frame = pte_pfn(pte) +

-- 
BR,
Muhammad Usama Anjum

