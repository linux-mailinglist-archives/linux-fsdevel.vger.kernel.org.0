Return-Path: <linux-fsdevel+bounces-33406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEF59B8A06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 04:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D6B1C2139E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 03:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327E1428E7;
	Fri,  1 Nov 2024 03:38:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008473FF1;
	Fri,  1 Nov 2024 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432319; cv=none; b=auP/qW2iYlC6p3wUZ3GokBTbVabmyyFnNbMkXN/VyosG965ePTwZwNZiKosDVpL+mQN9QYTiHhN8Vyald6Aer8SiErEwgende5ijF2X8cuvmYzYm8VOx+PCLGpbm9J7t4C4kpMNIw0E9V82m3heIZLfdePbVrrkEJ7ecz3IrQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432319; c=relaxed/simple;
	bh=1wnaL5Mm/Hhcmw4IC2BIDdIecYRO3oCvI4trko7r0CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tYs4BkP8kmMQhV+/lEI65hC6hSOcgu0iHyn2Sd5ULBFm5qJ4R1uks0DC4b7UQG7jq27+P5yZt6xWVSuW/bfv8nukyfja/ZhsfZma3ScK9DxLEzHgfi+TY8csaFu0n/4Ftv+graFzECNloIIE/0LHtCuZlv3oYQHJI/fb5yJRR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XfmgD4GmKz1HLgC;
	Fri,  1 Nov 2024 11:34:00 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id EF921140136;
	Fri,  1 Nov 2024 11:38:30 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 11:38:30 +0800
Message-ID: <f79d2587-2588-598f-f9b2-2e3548067d92@huawei.com>
Date: Fri, 1 Nov 2024 11:38:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] fs/proc: Fix compile warning about variable
 'vmcore_mmap_ops'
Content-Language: en-US
To: Qi Xi <xiqi2@huawei.com>, <bobo.shaobowang@huawei.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <holzheu@linux.vnet.ibm.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
References: <20241031185235.8bb482766ab10d2ab19fd3f6@linux-foundation.org>
 <20241101032306.8344-1-xiqi2@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241101032306.8344-1-xiqi2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/11/1 11:23, Qi Xi wrote:
> When build with !CONFIG_MMU, the variable 'vmcore_mmap_ops'
> is defined but not used:
> 
>>> fs/proc/vmcore.c:458:42: warning: unused variable 'vmcore_mmap_ops'
>      458 | static const struct vm_operations_struct vmcore_mmap_ops = {
> 
> v2: use ifdef instead of __maybe_unused

Changelogs should go after the '---' line, otherwise they
end up in the git history.

> 
> Fixes: 9cb218131de1 ("vmcore: introduce remap_oldmem_pfn_range()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/lkml/202410301936.GcE8yUos-lkp@intel.com/
> Signed-off-by: Qi Xi <xiqi2@huawei.com>
> ---
>  fs/proc/vmcore.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..9ed1f6902c8f 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -455,10 +455,6 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
>  #endif
>  }
>  
> -static const struct vm_operations_struct vmcore_mmap_ops = {
> -	.fault = mmap_vmcore_fault,
> -};
> -
>  /**
>   * vmcore_alloc_buf - allocate buffer in vmalloc memory
>   * @size: size of buffer
> @@ -486,6 +482,11 @@ static inline char *vmcore_alloc_buf(size_t size)
>   * virtually contiguous user-space in ELF layout.
>   */
>  #ifdef CONFIG_MMU
> +
> +static const struct vm_operations_struct vmcore_mmap_ops = {
> +	.fault = mmap_vmcore_fault,
> +};
> +
>  /*
>   * remap_oldmem_pfn_checked - do remap_oldmem_pfn_range replacing all pages
>   * reported as not being ram with the zero page.

