Return-Path: <linux-fsdevel+bounces-68757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F96C6584F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6B963A125A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E944630CD94;
	Mon, 17 Nov 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X38QDWbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2F30AD0D;
	Mon, 17 Nov 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399531; cv=none; b=kv5A/pcZs2MNzxELfQQXoEldANv6Ee9tRr8AmQrOWcOzLhFizSCOw4rS4CI6CJ7Xem2qDovSVc2EU91A6baNV4euonoyowUW4tEzFG2cm7OreRn4rkrU82YhloDG3uP8nqN5/LW7lCRrbuocrkuXQUkPmNEL42ks6aYZchroBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399531; c=relaxed/simple;
	bh=d5Mnypq6wDJc2sGNmVWWVeUIAR/ILc0h228u/LGZuww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQGSEp/DI9ilWI6yTuBNOTnkJeqV5WK//uT93SrEYWuNHP3k/TiH1XfSmaABsCcfg/RJki7EljvYbtzIaIs95s1gWb651A9ajQPvT13xoUtWhxBQYqOYeCT3UHzKdgIemt+HUAlwI4F0UTLV28oWqelUaeBhPUmWaNLGDo3VWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X38QDWbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F953C19423;
	Mon, 17 Nov 2025 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763399531;
	bh=d5Mnypq6wDJc2sGNmVWWVeUIAR/ILc0h228u/LGZuww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X38QDWbx7NnvZpofmhjuhcucQQctW3dwbl33jMr22mYBTNe4W4yMzWmwXqeZ+TPYx
	 18Zd7RdYuMtJC6b1Ova/QprEbncPpveX8fWmPw3S2CrQ+xAlVjGgyGeML8t6+O7NWd
	 qEnw0hmusYTbsvVwUN6U3Uwyj6duJsHM2Yrwh8SFuYot/p09AjApKIeS+Dxbk26X0O
	 +PARQdPUaQbJYCdgJIW4hvdIchPfgtu3yFfHzSMtY4E8Xd5LuQBFmDh70p+Pkb7CDF
	 VqbrAwAWrAYiIhnH/d2y3hbtm92KfhhvqP8GCx8CPiD7Xdt/mjgCxAHbsZAN51k3I2
	 O+N2LrxCNknHA==
Message-ID: <5f1e139d-cd6f-438f-8b5f-be356314d9aa@kernel.org>
Date: Mon, 17 Nov 2025 18:12:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce
 uniform_split_unmapped_folio_to_zero_order
To: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
 linmiaohe@huawei.com, ziy@nvidia.com
Cc: lorenzo.stoakes@oracle.com, william.roche@oracle.com,
 harry.yoo@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, jane.chu@oracle.com, akpm@linux-foundation.org,
 osalvador@suse.de, muchun.song@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-2-jiaqiyan@google.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251116014721.1561456-2-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.11.25 02:47, Jiaqi Yan wrote:
> When freeing a high-order folio that contains HWPoison pages,
> to ensure these HWPoison pages are not added to buddy allocator,
> we can first uniformly split a free and unmapped high-order folio
> to 0-order folios first, then only add non-HWPoison folios to
> buddy allocator and exclude HWPoison ones.
> 
> Introduce uniform_split_unmapped_folio_to_zero_order, a wrapper
> to the existing __split_unmapped_folio. Caller can use it to
> uniformly split an unmapped high-order folio into 0-order folios.
> 
> No functional change. It will be used in a subsequent commit.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>   include/linux/huge_mm.h | 6 ++++++
>   mm/huge_memory.c        | 8 ++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 71ac78b9f834f..ef6a84973e157 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -365,6 +365,7 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>   		vm_flags_t vm_flags);
>   
>   bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
> +int uniform_split_unmapped_folio_to_zero_order(struct folio *folio);
>   int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   		unsigned int new_order);
>   int min_order_for_split(struct folio *folio);
> @@ -569,6 +570,11 @@ can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>   {
>   	return false;
>   }
> +static inline int uniform_split_unmapped_folio_to_zero_order(struct folio *folio)
> +{
> +	VM_WARN_ON_ONCE_PAGE(1, page);
> +	return -EINVAL;
> +}

IIUC this patch won't be required (I agree that ideally the page 
allocator takes care of this), but for the future, let's consistently 
name these things "folio_split_XXX".

-- 
Cheers

David

