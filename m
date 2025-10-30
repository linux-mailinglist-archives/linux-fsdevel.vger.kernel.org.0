Return-Path: <linux-fsdevel+bounces-66410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B4C1E21A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 03:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82F618857B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 02:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B88329C68;
	Thu, 30 Oct 2025 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oj/IxwZx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD07329C4D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791488; cv=none; b=Sp6tFLuaZ1NgIL5z8YFNNCaVD6/ODh1jNYb3DSlFe8NQdvefjjkzsJcDjF0MS3MCvyjUsTZjaY26lqXFkTzkhlgREV9Mm+Y7ElbMoHqoTktgGjypskJ+B55t/N23xVrAkm07Rx3UHJ+i+KN7jGqc8JwMIUHoFxDW2zYG84nYCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791488; c=relaxed/simple;
	bh=HYCWhzkmmxHErBQ1GkwvcVFu94mXGWZn/YZIGdqpS4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJSanWdDmBB0sUKv1VAEUoa2cvYDhQHwG7NzQILLkHd8kLMsBguQuQTHou4S5Qxwtmw2ymlByDy43LibMIW9zdCsFa3UbGOSDcWpk3GhQbYaGac+W57fb/KHR1zI3xbFaNFe9K8Wj13SdEQntq0BLvdCsnTGvQa64g0ZH9+Psjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oj/IxwZx; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <17dea8a6-b473-44da-82d2-d84223b7cdf1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761791484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gg4L5oAgYBz25YzLH6kOdzXmTMAfYlJEqOAX4aq55Yw=;
	b=oj/IxwZxyaupSvCLMQpNxLfuw7iq585mKCxt6iInm0NvZqxAaK8/HNxYFqEw9lvOX+MYbV
	NsbYr5c5G7phrIlLb6EihUTZUI01NJBIzVYe+4bW4MhClIsxGEw9uX1IkzVx7LCNH566dB
	+B0rDKkAh6TBO9Oprm8pAr6FeFFLIIY=
Date: Thu, 30 Oct 2025 10:31:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: kernel@pankajraghav.com, jane.chu@oracle.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com, david@redhat.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 linmiaohe@huawei.com, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-4-ziy@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251030014020.475659-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/30 09:40, Zi Yan wrote:
> try_folio_split_to_order(), folio_split, __folio_split(), and
> __split_unmapped_folio() do not have correct kernel-doc comment format.
> Fix them.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---

LGTM.

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>   include/linux/huge_mm.h | 10 ++++++----
>   mm/huge_memory.c        | 27 +++++++++++++++------------
>   2 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 34f8d8453bf3..cbb2243f8e56 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -386,9 +386,9 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
>   	return split_huge_page_to_list_to_order(page, NULL, new_order);
>   }
>   
> -/*
> - * try_folio_split_to_order - try to split a @folio at @page to @new_order using
> - * non uniform split.
> +/**
> + * try_folio_split_to_order() - try to split a @folio at @page to @new_order
> + * using non uniform split.
>    * @folio: folio to be split
>    * @page: split to @new_order at the given page
>    * @new_order: the target split order
> @@ -398,7 +398,7 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
>    * folios are put back to LRU list. Use min_order_for_split() to get the lower
>    * bound of @new_order.
>    *
> - * Return: 0: split is successful, otherwise split failed.
> + * Return: 0 - split is successful, otherwise split failed.
>    */
>   static inline int try_folio_split_to_order(struct folio *folio,
>   		struct page *page, unsigned int new_order)
> @@ -486,6 +486,8 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
>   /**
>    * folio_test_pmd_mappable - Can we map this folio with a PMD?
>    * @folio: The folio to test
> + *
> + * Return: true - @folio can be mapped, false - @folio cannot be mapped.
>    */
>   static inline bool folio_test_pmd_mappable(struct folio *folio)
>   {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0e24bb7e90d0..381a49c5ac3f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3567,8 +3567,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>   		ClearPageCompound(&folio->page);
>   }
>   
> -/*
> - * It splits an unmapped @folio to lower order smaller folios in two ways.
> +/**
> + * __split_unmapped_folio() - splits an unmapped @folio to lower order folios in
> + * two ways: uniform split or non-uniform split.
>    * @folio: the to-be-split folio
>    * @new_order: the smallest order of the after split folios (since buddy
>    *             allocator like split generates folios with orders from @folio's
> @@ -3603,8 +3604,8 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>    * folio containing @page. The caller needs to unlock and/or free after-split
>    * folios if necessary.
>    *
> - * For !uniform_split, when -ENOMEM is returned, the original folio might be
> - * split. The caller needs to check the input folio.
> + * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
> + * split but not to @new_order, the caller needs to check)
>    */
>   static int __split_unmapped_folio(struct folio *folio, int new_order,
>   		struct page *split_at, struct xa_state *xas,
> @@ -3722,8 +3723,8 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>   	return true;
>   }
>   
> -/*
> - * __folio_split: split a folio at @split_at to a @new_order folio
> +/**
> + * __folio_split() - split a folio at @split_at to a @new_order folio
>    * @folio: folio to split
>    * @new_order: the order of the new folio
>    * @split_at: a page within the new folio
> @@ -3741,7 +3742,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>    * 1. for uniform split, @lock_at points to one of @folio's subpages;
>    * 2. for buddy allocator like (non-uniform) split, @lock_at points to @folio.
>    *
> - * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
> + * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
>    * split but not to @new_order, the caller needs to check)
>    */
>   static int __folio_split(struct folio *folio, unsigned int new_order,
> @@ -4130,14 +4131,13 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
>   				unmapped);
>   }
>   
> -/*
> - * folio_split: split a folio at @split_at to a @new_order folio
> +/**
> + * folio_split() - split a folio at @split_at to a @new_order folio
>    * @folio: folio to split
>    * @new_order: the order of the new folio
>    * @split_at: a page within the new folio
> - *
> - * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
> - * split but not to @new_order, the caller needs to check)
> + * @list: after-split folios are added to @list if not null, otherwise to LRU
> + *        list
>    *
>    * It has the same prerequisites and returns as
>    * split_huge_page_to_list_to_order().
> @@ -4151,6 +4151,9 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
>    * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
>    *
>    * After split, folio is left locked for caller.
> + *
> + * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
> + * split but not to @new_order, the caller needs to check)
>    */
>   int folio_split(struct folio *folio, unsigned int new_order,
>   		struct page *split_at, struct list_head *list)


