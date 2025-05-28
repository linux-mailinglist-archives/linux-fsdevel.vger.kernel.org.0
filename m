Return-Path: <linux-fsdevel+bounces-49982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B087BAC6D13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC22189BD75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A75728C2D0;
	Wed, 28 May 2025 15:43:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0028C026;
	Wed, 28 May 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447028; cv=none; b=ZLSKPu8VyWg4aFgoTYdldMpgdo8aIDfvM1Z4lg6eqzj+4ClgyStcA4LX83vPwVo6FOqRhn1e4YFaIVXfXfLzDQsjk6knUh9j4ZP6cPHaDCsgmuBKZ6iaSPPhqhmO8MjvTk9NlgV2FsfflNHI5WAfAFafCMrrVUqlgZOGxOuppM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447028; c=relaxed/simple;
	bh=RezGIthMdImr0Wy2tB0Hw84VXGIiLhEAwSmh1rOyRYg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ptDw/Az1Z+LOyl6RdZKsKRND5kU1uaax3ykr2lQmWmCEoYDQSH+0NNhpgBJ0te4C+KD9ZsCkCqNlrr1SlhsRiumbzeCfC6s129t6A1RjgOras7+J81o48f9/7EYjF26JCnIGOhBu47GyOU9A8Bj/79kvAK9ulUN0fbclYUr45DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4b6v175H6zz4x6CY;
	Wed, 28 May 2025 23:43:39 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 54SFhXWW026942;
	Wed, 28 May 2025 23:43:33 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 28 May 2025 23:43:38 +0800 (CST)
Date: Wed, 28 May 2025 23:43:38 +0800 (CST)
X-Zmail-TransId: 2afa68372f2affffffffb80-0948d
X-Mailer: Zmail v1.0
Message-ID: <20250528234338153V_kDYTzOwx6LkHnp-gsXa@zte.com.cn>
In-Reply-To: <e22d9582b0b334a1161ffa150708da370bffb537.1747844463.git.lorenzo.stoakes@oracle.com>
References: cover.1747844463.git.lorenzo.stoakes@oracle.com,e22d9582b0b334a1161ffa150708da370bffb537.1747844463.git.lorenzo.stoakes@oracle.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <lorenzo.stoakes@oracle.com>
Cc: <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <jack@suse.cz>, <Liam.Howlett@oracle.com>,
        <vbabka@suse.cz>, <jannh@google.com>, <pfalcato@suse.de>,
        <david@redhat.com>, <chengming.zhou@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <shr@devkernel.io>, <wang.yaxin@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAyLzRdIG1tOiBrc206IHJlZmVyIHRvIHNwZWNpYWwgVk1BcyB2aWEgVk1fU1BFQ0lBTCBpbiBrc21fY29tcGF0aWJsZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 54SFhXWW026942
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68372F2B.000/4b6v175H6zz4x6CY

> There's no need to spell out all the special cases, also doing it this way
> makes it absolutely clear that we preclude unmergeable VMAs in general, and
> puts the other excluded flags in stark and clear contrast.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>  mm/ksm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 08d486f188ff..d0c763abd499 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -679,9 +679,8 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
>  
>  static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
>  {
> -	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
> -			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
> -			VM_MIXEDMAP | VM_DROPPABLE))
> +	if (vm_flags & (VM_SHARED  | VM_MAYSHARE | VM_SPECIAL |
> +			VM_HUGETLB | VM_DROPPABLE))
>  		return false;		/* just ignore the advice */
>  
>  	if (file_is_dax(file))
> -- 
> 2.49.0

Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>

