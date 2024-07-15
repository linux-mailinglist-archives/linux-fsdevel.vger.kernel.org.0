Return-Path: <linux-fsdevel+bounces-23667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8B931128
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57221F22E7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D70186E33;
	Mon, 15 Jul 2024 09:26:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209376AC0
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035576; cv=none; b=rCQHTMWVBkYrtxoixlIHiVhw7Xed4tBMe4lWYvoC9AINqtZAke5lQv0sOnPzk53HwuGOugGBFnP4udhrcQ5EKvQf8uE/Z/Mt4VipTcdj1VEa/YL7tZiHHTr7yaAbq/1qI6A7yDPxy9SLEPFTArEnVgR5WbRhBDWU8pnU77LBE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035576; c=relaxed/simple;
	bh=KucS5ULM43WZGpU96NOaXujaM57c3Fj/TphE+Wk6KC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIA/w1GSaszbyq/dTjCPKyv/s2spFXNOp6cytwhNe3jhenwkoR7wghKEcsJfSFLQ5RtDq4fFmLPsIJRsjiOUtXqRNPpEjLE2qm4R6Ft7ZZjxitsc/yl4gSvOf/DY6+euk0/n3x9ewHWHjYtCnuUqSJ6s+29lOwU/S3eMB51Zfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED58ADA7;
	Mon, 15 Jul 2024 02:26:39 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B89E3F73F;
	Mon, 15 Jul 2024 02:26:06 -0700 (PDT)
Message-ID: <1da79356-4cf7-476f-bd16-61123e39598a@arm.com>
Date: Mon, 15 Jul 2024 14:56:03 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/29] arm64: add POIndex defines
To: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
 catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org, x86@kernel.org,
 kvmarm@lists.linux.dev
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-13-joey.gouly@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503130147.1154804-13-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 18:31, Joey Gouly wrote:
> The 3-bit POIndex is stored in the PTE at bits 60..62.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index ef207a0d4f0d..370a02922fe1 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -198,6 +198,16 @@
>  #define PTE_PI_IDX_2	53	/* PXN */
>  #define PTE_PI_IDX_3	54	/* UXN */
>  
> +/*
> + * POIndex[2:0] encoding (Permission Overlay Extension)
> + */
> +#define PTE_PO_IDX_0	(_AT(pteval_t, 1) << 60)
> +#define PTE_PO_IDX_1	(_AT(pteval_t, 1) << 61)
> +#define PTE_PO_IDX_2	(_AT(pteval_t, 1) << 62)
> +
> +#define PTE_PO_IDX_MASK		GENMASK_ULL(62, 60)
> +
> +
>  /*
>   * Memory Attribute override for Stage-2 (MemAttr[3:0])
>   */

Could this patch be folded with a later patch that uses the above indices
and the mask for the first time.

