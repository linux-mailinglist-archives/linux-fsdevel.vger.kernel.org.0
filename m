Return-Path: <linux-fsdevel+bounces-21693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D5908430
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 09:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40508283456
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 07:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5F148833;
	Fri, 14 Jun 2024 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sVrApOnI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AB17C72;
	Fri, 14 Jun 2024 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348920; cv=none; b=StLPt91NyOjoNBTtvqIIAj4sZlxpkpKJlhxQPJ74R22mDBUQWKFot4oWtSE+RNSyITsKXL6oAPsj7N4gVhSZ75SjlBM9Hl6+1AYN+g3lAmxUh/nj6+VNvShy5BuQbe7DT1mi7ayufSeMuzypI/sieAPMpAP+kk4zhLHZMQT6wpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348920; c=relaxed/simple;
	bh=RHbpY37ublUsDaREUds7wvom8IV9SmFjqR7Mbhiqfy4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E+g6LDefD6MnSBL8Ar0z0oZEM/JgLtnkmwP8NTg3u2yoxTeiJyte9/0qev3O6wvPPTHdzw6OLWN/ieg1uDpaoEfMpa3mFwhf2TUEVCsIR1MtuhnctYCHoxdDoz2dwc+9oVXXzsvQtejP9BNmLOpiUTu1g1AFac31yF6X9N0Bl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sVrApOnI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718348911;
	bh=RHbpY37ublUsDaREUds7wvom8IV9SmFjqR7Mbhiqfy4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sVrApOnINBCRnnn76mp46BkvFXNx4hoPNQthHRDQZt2nhysWrvmkYfMgTQcGFgqQl
	 0gvsE/09DEQMtLHrg16DCpfyHrjf0Gk4rN2/mYYPewtTLKAGvhatORAgiXMUTI4VgW
	 0UMwjZDt7fosSxi6fISGaGFBEJs6nXg9efH8ydwf2xRLCFaByScf//Suk/fnh3wgfd
	 MzuaLjA5TRY8eVX8eohB/JYcUnn4VN7ME0wDDKUhVtBzdBKzQOJnMOXMkF2w4tJDes
	 cMRuEKx4VVOkPIo6j58xw1mnYInFv02WzNIlMRALlDnjFvPqDZWSPzoDqmoPUSqfnQ
	 5AbOUUHQ4ZjBw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8064737820A7;
	Fri, 14 Jun 2024 07:08:28 +0000 (UTC)
Message-ID: <ba97a544-eef8-4e48-8c8c-fe73fff6ae15@collabora.com>
Date: Fri, 14 Jun 2024 12:09:04 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Andrei Vagin <avagin@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix uninitialized variable in
 pagemap_pmd_range()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <9d6eaba7-92f8-4a70-8765-38a519680a87@moroto.mountain>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <9d6eaba7-92f8-4a70-8765-38a519680a87@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/24 7:34 PM, Dan Carpenter wrote:
> The "folio" pointer is tested for NULL, but it's either valid or
> uninitialized.  Initialize it to NULL.
> 
> Fixes: 84f57f8b8914 ("fs/proc: move page_mapcount() to fs/proc/internal.h")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 631371cb80a0..6ed1f56b32b4 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1492,7 +1492,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		u64 flags = 0, frame = 0;
>  		pmd_t pmd = *pmdp;
>  		struct page *page = NULL;
> -		struct folio *folio;
> +		struct folio *folio = NULL;
>  
>  		if (vma->vm_flags & VM_SOFTDIRTY)
>  			flags |= PM_SOFT_DIRTY;
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

-- 
BR,
Muhammad Usama Anjum

