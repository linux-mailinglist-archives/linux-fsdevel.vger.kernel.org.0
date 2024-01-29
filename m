Return-Path: <linux-fsdevel+bounces-9334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20537840111
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5A9281B4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526585577A;
	Mon, 29 Jan 2024 09:13:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EC154FAD;
	Mon, 29 Jan 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519607; cv=none; b=qVNAfWkEUfdXn8Eh4fNSsd7PJu4Dr0K2z3DH7mjTGKxzdBbcBB76Ue3J2u4lWe7HOVOQxgVWveL99l1lTqbbYI7xt/CIpNKwjppZPpfU/8Tzim/hB9HF5zvFi0yNDA8PLmBYutmpXNn298IwpSy8bNfB/pmmYrNKzEh89sySmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519607; c=relaxed/simple;
	bh=cXt+OGtv30hUZByKLrVjTnqqtdTy72PNWwKZLJAJgSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHRDLvl1iDb4xzqDGpH0Z4rzet/XrkMpFTZnRgAsrvmTqhFBbddtm/L48cUtH8HuZlS4T5MbOAunqrqT4nfDqzUdT6TovlTdWlitLLzgjkD6FKK2BpHXz3BeXjZsVxYYDTafu6VuTFctYkq5tWDDqwfgD7oA4VNeuGyZPxrO+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 334BF1FB;
	Mon, 29 Jan 2024 01:14:07 -0800 (PST)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 091873F762;
	Mon, 29 Jan 2024 01:13:11 -0800 (PST)
Message-ID: <8b5dfed3-f881-4f0a-be81-d7fcf3be0deb@arm.com>
Date: Mon, 29 Jan 2024 14:43:08 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 05/35] mm: cma: Don't append newline when
 generating CMA area name
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 mhiramat@kernel.org, rppt@kernel.org, hughd@google.com
Cc: pcc@google.com, steven.price@arm.com, vincenzo.frascino@arm.com,
 david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-6-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-6-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/25/24 22:12, Alexandru Elisei wrote:
> cma->name is displayed in several CMA messages. When the name is generated
> by the CMA code, don't append a newline to avoid breaking the text across
> two lines.

An example of such mis-formatted CMA output from dmesg could be added
here in the commit message to demonstrate the problem better.

> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---

Regardless, LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> 
> Changes since rfc v2:
> 
> * New patch. This is a fix, and can be merged independently of the other
> patches.

Right, need not be part of this series. Hence please send it separately to
the MM list.

> 
>  mm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 7c09c47e530b..f49c95f8ee37 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -204,7 +204,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  	if (name)
>  		snprintf(cma->name, CMA_MAX_NAME, name);
>  	else
> -		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
> +		snprintf(cma->name, CMA_MAX_NAME,  "cma%d", cma_area_count);
>  
>  	cma->base_pfn = PFN_DOWN(base);
>  	cma->count = size >> PAGE_SHIFT;

