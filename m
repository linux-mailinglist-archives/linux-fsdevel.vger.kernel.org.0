Return-Path: <linux-fsdevel+bounces-66836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA0C2D322
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD004189A9A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AA3195F0;
	Mon,  3 Nov 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FakmInk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEA3191C7;
	Mon,  3 Nov 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187943; cv=none; b=chh4zYVgVnWrIdpCiWhUPDflzlLItbybPwrDbkERIJPemPIDXF6Sxrt50rKB+EDAmuWe27BpVg3AI/Yk3XEiTsbwR6O1UvydlTbl+lPNyX45Tbs/PRV4hb3UFcZHx6PDY6F1ptXzrTJlPSiHkkUkGVpvPx2pzIWtYbY3fv6e2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187943; c=relaxed/simple;
	bh=MJf28eCwFjXy43H5HkPqmDjsZqFEkChdkvJCw3zVsbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0EjIp2PN+DlaS2U524x5aJJEpHtl2RS/V8HyqOZ24F+KR8N1S46wzNtVTWW0h4LIicqehCa3CPqG9xhSjJEyHmdKmll85RLl0JS34COSAJ0Ygsh6g2PsjGvUHEMzaXZBwXAxPBhqTUXdO9yKxXqOqnA24Gt69Fu+5tZIFVs8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FakmInk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1150C4CEE7;
	Mon,  3 Nov 2025 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187941;
	bh=MJf28eCwFjXy43H5HkPqmDjsZqFEkChdkvJCw3zVsbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FakmInk37hbSkL1UHSx54jy0CI61iH1VgLKnghGMCpnPVWHqwAx5xSsUC0yeqMZi6
	 2GmCQt5UVt1fR2a5SLg1lEvBS+XECag4pIoPR0D9Lvdgj+Qq14VBP6wkKycGgJv44e
	 pyiA1tGhZLqAslFWZedz5dZOTwgI4IC6sqYoeBSqTf0T9UislrqMcrXKujaoF4EYmu
	 w02Lmva3QPEzqjXBtJapusaYj6QieQ7y44LsSMzldDMwnqKBXWFtekdpFbPcrbHeHu
	 bxuJZnFfvsHS66DyHzpz0gK9UBUwrFSerdYrIVLaFVi2ndoMu9lYJEySXC4aHzVRJr
	 vzEz0sSA77Geg==
Message-ID: <6ab96953-3475-41c2-b31b-e50f15088f0d@kernel.org>
Date: Mon, 3 Nov 2025 17:38:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
To: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org,
 Wei Yang <richard.weiyang@gmail.com>
Cc: linmiaohe@huawei.com, jane.chu@oracle.com, kernel@pankajraghav.com,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251031162001.670503-1-ziy@nvidia.com>
 <20251031162001.670503-4-ziy@nvidia.com>
 <20251031233610.ftpqyeosb4cedwtp@master>
 <BE7AC5F3-9E64-4923-861D-C2C4E0CB91EB@nvidia.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <BE7AC5F3-9E64-4923-861D-C2C4E0CB91EB@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ad2fc52651a6..a30fee2001b5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3586,7 +3586,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>    *    uniform_split is true.
>    * 2. buddy allocator like (non-uniform) split: the given @folio is split into
>    *    half and one of the half (containing the given page) is split into half
> - *    until the given @page's order becomes @new_order. This is done when
> + *    until the given @folio's order becomes @new_order. This is done when
>    *    uniform_split is false.
>    *
>    * The high level flow for these two methods are:
> @@ -3595,14 +3595,14 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>    *    along with stats update.
>    * 2. non-uniform split: folio_order - @new_order calls to
>    *    __split_folio_to_order() are expected to be made in a for loop to split
> - *    the @folio to one lower order at a time. The folio containing @page is
> - *    split in each iteration. @xas is split into half in each iteration and
> + *    the @folio to one lower order at a time. The folio containing @split_at
> + *    is split in each iteration. @xas is split into half in each iteration and
>    *    can fail. A failed @xas split leaves split folios as is without merging
>    *    them back.
>    *
>    * After splitting, the caller's folio reference will be transferred to the
> - * folio containing @page. The caller needs to unlock and/or free after-split
> - * folios if necessary.
> + * folio containing @split_at. The caller needs to unlock and/or free
> + * after-split folios if necessary.
>    *
>    * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
>    * split but not to @new_order, the caller needs to check)

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

