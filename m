Return-Path: <linux-fsdevel+bounces-52192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6E9AE01F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99220170A59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A380220F35;
	Thu, 19 Jun 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evWXrDm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B320551C;
	Thu, 19 Jun 2025 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326375; cv=none; b=qs6Q8yFEwDWUoWsgttBzFPrX06gDIz/iMvkJSUd7N7DR6g7WLaygRypeJYLxjn/U3bsWwhFTHcN1aoniIsfqpQy6oVrk0sF25oykmcczNVY6Pk300+u1+5OL2yMG4gcHTfwGQeO5l9YwApmzFs8db9CH77zTSSyM9d1vEScGHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326375; c=relaxed/simple;
	bh=UuLnT9fGW+15a+efSTXHXPlypCxXcrd7PtLcffPU4io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuAjr522VIAcTKSLX50S0604v/MAh6k2ZAWcsR7d8r7LfLEjkpsGAE4vDIHsVyUBgv1rEGyqeHosmRes1FtQKQ4mNHRy9twAd6iUJkP4IxLGQpzMvhqF9nw4Ud0vEwinCg567Kd4l054qxlkzObh50u4473xPYskkp/2y3iUyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evWXrDm0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750326374; x=1781862374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UuLnT9fGW+15a+efSTXHXPlypCxXcrd7PtLcffPU4io=;
  b=evWXrDm0aP9uoQBysECEroC+u9SjKFk4vhG2IoMZGQjYtzYuZrnT+7mc
   s6M0WDGieWFfvmPfZrHsi7WvMomVBRlamyct3YRbjSqOjxDJfpeYhcCmW
   u2DX7UVu1CrdM9MD6l+SFLd6GZf+6vnWrS4qATMvcRg3OddXmQTWbPeWp
   qfAvv2jlivQNrPTnZEOurIn3i8DAl+PmLpHBOHxvpbJvR1MNGLgyLOiW+
   Z/sN3Xq3iBt0Jv4pBRa6r9Z9gseERPKgl5MB+mBFV0vbWNfehTzW6XU9f
   6awZYMaEW/Zryb/oy+kOTiGiWOVYO1bL4PfIwmDACoHV+9WPuq0gq0RJa
   Q==;
X-CSE-ConnectionGUID: AVfndRx6RSqOyJQ5s5gn5g==
X-CSE-MsgGUID: W4XugKNsSMWkm3D42R8GSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="64004279"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="64004279"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 02:46:04 -0700
X-CSE-ConnectionGUID: VpU8txZkSyybrd7ZTLNPZg==
X-CSE-MsgGUID: Hs2fzB2LQS6Ns2HLVkksCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="150370624"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1]) ([10.124.247.1])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 02:45:41 -0700
Message-ID: <30965147-24af-4dc8-aec4-781ea401a3a9@intel.com>
Date: Thu, 19 Jun 2025 17:45:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aFPYLM8U7GhCKkRC@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2025 5:28 PM, Yan Zhao wrote:
> On Thu, Jun 19, 2025 at 05:18:44PM +0800, Xiaoyao Li wrote:
>> On 6/19/2025 4:59 PM, Xiaoyao Li wrote:
>>> On 6/19/2025 4:13 PM, Yan Zhao wrote:
>>>> On Wed, May 14, 2025 at 04:41:39PM -0700, Ackerley Tng wrote:
>>>>> Hello,
>>>>>
>>>>> This patchset builds upon discussion at LPC 2024 and many guest_memfd
>>>>> upstream calls to provide 1G page support for guest_memfd by taking
>>>>> pages from HugeTLB.
>>>>>
>>>>> This patchset is based on Linux v6.15-rc6, and requires the mmap support
>>>>> for guest_memfd patchset (Thanks Fuad!) [1].
>>>>>
>>>>> For ease of testing, this series is also available, stitched together,
>>>>> at
>>>>> https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-
>>>>> support-rfc-v2
>>>> Just to record a found issue -- not one that must be fixed.
>>>>
>>>> In TDX, the initial memory region is added as private memory during
>>>> TD's build
>>>> time, with its initial content copied from source pages in shared memory.
>>>> The copy operation requires simultaneous access to both shared
>>>> source memory
>>>> and private target memory.
>>>>
>>>> Therefore, userspace cannot store the initial content in shared
>>>> memory at the
>>>> mmap-ed VA of a guest_memfd that performs in-place conversion
>>>> between shared and
>>>> private memory. This is because the guest_memfd will first unmap a
>>>> PFN in shared
>>>> page tables and then check for any extra refcount held for the
>>>> shared PFN before
>>>> converting it to private.
>>>
>>> I have an idea.
>>>
>>> If I understand correctly, the KVM_GMEM_CONVERT_PRIVATE of in-place
>>> conversion unmap the PFN in shared page tables while keeping the content
>>> of the page unchanged, right?
> However, whenever there's a GUP in TDX to get the source page, there will be an
> extra page refcount.

The GUP in TDX happens after the gmem converts the page to private.

In the view of TDX, the physical page is converted to private already 
and it contains the initial content. But the content is not usable for 
TDX until TDX calls in-place PAGE.ADD

>>> So KVM_GMEM_CONVERT_PRIVATE can be used to initialize the private memory
>>> actually for non-CoCo case actually, that userspace first mmap() it and
>>> ensure it's shared and writes the initial content to it, after it
>>> userspace convert it to private with KVM_GMEM_CONVERT_PRIVATE.
> The conversion request here will be declined therefore.
> 
> 
>>> For CoCo case, like TDX, it can hook to KVM_GMEM_CONVERT_PRIVATE if it
>>> wants the private memory to be initialized with initial content, and
>>> just do in-place TDH.PAGE.ADD in the hook.
>>
>> And maybe a new flag for KVM_GMEM_CONVERT_PRIVATE for user space to
>> explicitly request that the page range is converted to private and the
>> content needs to be retained. So that TDX can identify which case needs to
>> call in-place TDH.PAGE.ADD.
>>


