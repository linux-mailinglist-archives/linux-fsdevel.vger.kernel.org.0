Return-Path: <linux-fsdevel+bounces-52193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F78AE020C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F254418993FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775D221546;
	Thu, 19 Jun 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUlOBaun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA34220F5C;
	Thu, 19 Jun 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326606; cv=none; b=S7LX+AOxs3IfBq99K/VVA+Fm75II8vbd8d4/YqQyObyU3i9C2G0V5rZ7ugTwY5NuILZ7u3ih5eYEB/7slW/qO0XhAYO7TjGcvi3/JyV0wjQx2aG8elQBG7GCzzvYIM+Ba9fQkORnbximt37Mc2bL8FsKq8f/z0DdWfkReo/EVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326606; c=relaxed/simple;
	bh=0vDuxYtZQxMHLMyV7Fv6kyC0eDbvjTX2Uthi/5EmmbE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IUi5QXvPuF/t5RtRdS6mv9ecYlyMM3QwbVdzX98f9VCiKXg29YZ4bSVHE5mwuBQptNf9qNGbmOKnAbotRlKr+xTyyY8BZV7fIb7ttP0yjbS4WKNKpRx1fJwRhkx5O8ZPtpd4MoehzwoArm03i1GpKdE4KZ1wQ/tMbAeZo9wqQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUlOBaun; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750326604; x=1781862604;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0vDuxYtZQxMHLMyV7Fv6kyC0eDbvjTX2Uthi/5EmmbE=;
  b=MUlOBaunB2DJEmV/ISEyG72okwgQZqYnyd0MXbyjxlRjJoRXs9LTdG5m
   P8v4rvwW25icPhF5cXl8kgkZ54TzdeEtHgVunf0ecvnIpPMGCGebRtTQS
   humMEPBFK1zI4vbo0jDmmMR5p/AzYyLQ2qtZWhnreqZnPT6zTUq/FUYAA
   lm+FY9OaMF2T6e+Xm2nxSHrxMvp3q81O8YQ5rhLTTOzFw5a+mM2ZRvyK9
   slcfZ3e//X9qwoqXQm7aTyTVwxvKxf2815PzeEkgtBWrdCDUMciz3/r4s
   n71e5+OvJvY8qrM3G4BlXQG0fvNj4PmiV9n1Xyx/kpwaGBpWTmiHBaT+Y
   A==;
X-CSE-ConnectionGUID: yspTpFoXRu2EqWvWP4V1rw==
X-CSE-MsgGUID: qEmKo79QSt+cA7OyArWlvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="62845794"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="62845794"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 02:50:04 -0700
X-CSE-ConnectionGUID: 5YNH3rbDRX+bpMvim0FPzw==
X-CSE-MsgGUID: 0ElUZ+sbQVuiATdt8kiskQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="150153819"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1]) ([10.124.247.1])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 02:49:43 -0700
Message-ID: <df01a89c-2510-4301-9841-de51c9062d7d@intel.com>
Date: Thu, 19 Jun 2025 17:49:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-fsdevel@vger.kernel.org, aik@amd.com, ajones@ventanamicro.com,
 akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com,
 anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com,
 binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com,
 chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com,
 david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk,
 erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com,
 haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
 ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
 james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com,
 jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com,
 jun.miao@intel.com, kai.huang@intel.com, keirf@google.com,
 kent.overstreet@linux.dev, kirill.shutemov@intel.com,
 liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
 mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net,
 michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev,
 nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev,
 palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, pdurrant@amazon.co.uk, peterx@redhat.com,
 pgonda@google.com, pvorel@suse.cz, qperret@google.com,
 quic_cvanscha@quicinc.com, quic_eberman@quicinc.com,
 quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com,
 quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
 richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
 steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com,
 tabba@google.com, thomas.lendacky@amd.com, usama.arif@bytedance.com,
 vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
 vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
 willy@infradead.org, yilun.xu@intel.com, yuzenghui@huawei.com,
 zhiquan1.li@intel.com
References: <cover.1747264138.git.ackerleytng@google.com>
 <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
 <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
 <9b55acfa-688e-49da-9599-f35aee351e3d@intel.com>
 <aFPYLM8U7GhCKkRC@yzhao56-desk.sh.intel.com>
 <30965147-24af-4dc8-aec4-781ea401a3a9@intel.com>
Content-Language: en-US
In-Reply-To: <30965147-24af-4dc8-aec4-781ea401a3a9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2025 5:45 PM, Xiaoyao Li wrote:
> On 6/19/2025 5:28 PM, Yan Zhao wrote:
>> On Thu, Jun 19, 2025 at 05:18:44PM +0800, Xiaoyao Li wrote:
>>> On 6/19/2025 4:59 PM, Xiaoyao Li wrote:
>>>> On 6/19/2025 4:13 PM, Yan Zhao wrote:
>>>>> On Wed, May 14, 2025 at 04:41:39PM -0700, Ackerley Tng wrote:
>>>>>> Hello,
>>>>>>
>>>>>> This patchset builds upon discussion at LPC 2024 and many guest_memfd
>>>>>> upstream calls to provide 1G page support for guest_memfd by taking
>>>>>> pages from HugeTLB.
>>>>>>
>>>>>> This patchset is based on Linux v6.15-rc6, and requires the mmap 
>>>>>> support
>>>>>> for guest_memfd patchset (Thanks Fuad!) [1].
>>>>>>
>>>>>> For ease of testing, this series is also available, stitched 
>>>>>> together,
>>>>>> at
>>>>>> https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-
>>>>>> support-rfc-v2
>>>>> Just to record a found issue -- not one that must be fixed.
>>>>>
>>>>> In TDX, the initial memory region is added as private memory during
>>>>> TD's build
>>>>> time, with its initial content copied from source pages in shared 
>>>>> memory.
>>>>> The copy operation requires simultaneous access to both shared
>>>>> source memory
>>>>> and private target memory.
>>>>>
>>>>> Therefore, userspace cannot store the initial content in shared
>>>>> memory at the
>>>>> mmap-ed VA of a guest_memfd that performs in-place conversion
>>>>> between shared and
>>>>> private memory. This is because the guest_memfd will first unmap a
>>>>> PFN in shared
>>>>> page tables and then check for any extra refcount held for the
>>>>> shared PFN before
>>>>> converting it to private.
>>>>
>>>> I have an idea.
>>>>
>>>> If I understand correctly, the KVM_GMEM_CONVERT_PRIVATE of in-place
>>>> conversion unmap the PFN in shared page tables while keeping the 
>>>> content
>>>> of the page unchanged, right?
>> However, whenever there's a GUP in TDX to get the source page, there 
>> will be an
>> extra page refcount.
> 
> The GUP in TDX happens after the gmem converts the page to private.

May it's not GUP since the page has been unmapped from userspace? (Sorry 
that I'm not familiar with the terminology)

> In the view of TDX, the physical page is converted to private already 
> and it contains the initial content. But the content is not usable for 
> TDX until TDX calls in-place PAGE.ADD
> 
>>>> So KVM_GMEM_CONVERT_PRIVATE can be used to initialize the private 
>>>> memory
>>>> actually for non-CoCo case actually, that userspace first mmap() it and
>>>> ensure it's shared and writes the initial content to it, after it
>>>> userspace convert it to private with KVM_GMEM_CONVERT_PRIVATE.
>> The conversion request here will be declined therefore.
>>
>>
>>>> For CoCo case, like TDX, it can hook to KVM_GMEM_CONVERT_PRIVATE if it
>>>> wants the private memory to be initialized with initial content, and
>>>> just do in-place TDH.PAGE.ADD in the hook.
>>>
>>> And maybe a new flag for KVM_GMEM_CONVERT_PRIVATE for user space to
>>> explicitly request that the page range is converted to private and the
>>> content needs to be retained. So that TDX can identify which case 
>>> needs to
>>> call in-place TDH.PAGE.ADD.
>>>
> 
> 


