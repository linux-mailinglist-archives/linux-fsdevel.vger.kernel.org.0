Return-Path: <linux-fsdevel+bounces-18107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C318B59E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 15:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB621F20222
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF9C6F510;
	Mon, 29 Apr 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iZOgrpSG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746442055;
	Mon, 29 Apr 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397308; cv=none; b=QRDGwS9kTC6XPVAksyRgHLb0BN9CRQOgJQa0cYW2HKOmwlUUw8XaDozEhegwyg+FA9LLNgCzxVOBM1kSsxz88i9tY+PrienmLEcwdU5O0UyUqeEs0n2nkibn/MEdsMOhXY+gsV2hzJaxukw1/1IBdK1y6ZtCX8y+kEyCrCIU5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397308; c=relaxed/simple;
	bh=w3I0KB3Wx4VUBmPLi5oXkCJcbKLadPaoVRj5i8XU6Lg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f3gU/e+rVXWSIMrR7ep638U26Qj/eqZNE9why9TKjdkIbv3DM8GVFLS3WfTWb6v5w8JdXGjT4+D3F36yaL+B2ScAqch3vNnkfTV0KBm00QtA9LdS2EjWn1tiq2L8N4QTFedt5yfCFdAw0WV7WKIWLL/lX+i3bu5Jr6okGhjzbSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iZOgrpSG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714397305;
	bh=w3I0KB3Wx4VUBmPLi5oXkCJcbKLadPaoVRj5i8XU6Lg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iZOgrpSGYFamkt2yD9BicbFgxnhdSs/yuGP6l/j6ZBNgNUmhGWlMTORX2defVI0se
	 jy5V2yW9njRyq7xaxVNNw0npZa1qoYBH4yRy9b7R3jOLF4YdA/FF0cJGez2wTWN7Yo
	 W4Pv02X9j2RBS8a2oeIozt+WO4ZoODUCbFUVh79pLd8k9H+kgXxbhT4XdLmC4rD0wW
	 f1q9gXNpO8QSMOnDeWUoQ5v/OwkJbaZx/qZv/pAQ1wmNMk3XvA60wzNQ+RHhIHPa8t
	 6FsYuVP8AaaSBzbigltgMMJb6kE4GVvDTQ2OL67bLICmDLvdj8B+nT8PrcC89q3pa0
	 MBxpQ/IiEGDUQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A333A3780C22;
	Mon, 29 Apr 2024 13:28:23 +0000 (UTC)
Message-ID: <700ae50c-2fd6-4bcc-8840-f426558b847f@collabora.com>
Date: Mon, 29 Apr 2024 18:28:53 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] fs/proc/task_mmu: Fix loss of young/dirty bits during
 pagemap scan
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20240429114017.182570-1-ryan.roberts@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240429114017.182570-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks!

On 4/29/24 4:40 PM, Ryan Roberts wrote:
> make_uffd_wp_pte() was previously doing:
> 
>   pte = ptep_get(ptep);
>   ptep_modify_prot_start(ptep);
>   pte = pte_mkuffd_wp(pte);
>   ptep_modify_prot_commit(ptep, pte);
> 
> But if another thread accessed or dirtied the pte between the first 2
> calls, this could lead to loss of that information. Since
> ptep_modify_prot_start() gets and clears atomically, the following is
> the correct pattern and prevents any possible race. Any access after the
> first call would see an invalid pte and cause a fault:
> 
>   pte = ptep_modify_prot_start(ptep);
>   pte = pte_mkuffd_wp(pte);
>   ptep_modify_prot_commit(ptep, pte);
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 23fbab954c20..af4bc1da0c01 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1825,7 +1825,7 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
>  		pte_t old_pte;
> 
>  		old_pte = ptep_modify_prot_start(vma, addr, pte);
> -		ptent = pte_mkuffd_wp(ptent);
> +		ptent = pte_mkuffd_wp(old_pte);
>  		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
>  	} else if (is_swap_pte(ptent)) {
>  		ptent = pte_swp_mkuffd_wp(ptent);
> --
> 2.25.1
> 

-- 
BR,
Muhammad Usama Anjum

