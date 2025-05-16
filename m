Return-Path: <linux-fsdevel+bounces-49303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D994ABA4A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 22:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA9C3B208E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 20:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CEE27FD72;
	Fri, 16 May 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9AiR/o8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BA1C84A1;
	Fri, 16 May 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427123; cv=none; b=AxwxI/rXNaoPTdBfzmA37esHKkOjUs6ze82+cu6qgeY0cK0JMp6XaRjHw1Mck67PpbLV0D6r/FXTIGH+gAPrtTiWR3QTONUxpW6tYNkX3CDSERX5QZYpiZ+RVDKY6S3aSuOf0FWri+EaN2RABDtMhmrUCq8GbcmSAXWtxzpmm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427123; c=relaxed/simple;
	bh=Jpg5hbLqNEgrpb3zpI78kn/T1CPCGTWBjcNweWVVCR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYtOnu6ONeapW8Is1hlNZyPc21uQDG/O1zyHVLM6HFDHiLFZCCv5O+v+NFYe+4IZkuUVgNA0QL/Klh67uCN+AiqHxCrA7CYXA690wN0qKj/LbOMgVOdi9OmkZQNYvJ6FlKjHWM6tQ6ASg/KQXkYawVAx2fHID267bIio8SmjxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9AiR/o8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747427121; x=1778963121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jpg5hbLqNEgrpb3zpI78kn/T1CPCGTWBjcNweWVVCR4=;
  b=h9AiR/o8sYneaP0U1lapJYEgKGud9ZdI4dkycL1nRpIHzHD4WONRlSjC
   lSvucI1qtZtW1DAwG8F8BLleqih+NeNXaUE9wE2jzkyF8/XukIwdRzbTs
   s4OTcmUWQC33L2e7jdAPT8DAi2QoGY32SKNr87+JvoDKdU7s9o+S2Fam8
   9BMB2xo0g6PgOFVhL0M4iBVmVMjcuGWgYExf693425ygyq9nCK1XOcYRR
   tRkCJxiOHTc8WE5pjvekUBXhKbafDnSqDz3khgh3WDoqhQEP6rVSNdX6P
   rBP2bdeDevvbJJqD9jpSfzrvvSsLBpZPTl3/EsdtJN2VKtOi8549ocLPw
   Q==;
X-CSE-ConnectionGUID: eM/ct/C+T0+KFLlheDuB+g==
X-CSE-MsgGUID: yZS2sE0rRoyUbg+86XJovA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="66961875"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="66961875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 13:25:20 -0700
X-CSE-ConnectionGUID: tfkXx8IbQUCZwihLYo14uQ==
X-CSE-MsgGUID: ndYB0akyQs+udmNSSWUQHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="143560162"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.109.65]) ([10.125.109.65])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 13:25:18 -0700
Message-ID: <1c004de5-4132-49f2-bbf2-6a0517f25d58@intel.com>
Date: Fri, 16 May 2025 13:25:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "seanjc@google.com" <seanjc@google.com>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "Miao, Jun" <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>,
 "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>,
 "x86@kernel.org" <x86@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
 "tabba@google.com" <tabba@google.com>,
 "quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>,
 "amoorthy@google.com" <amoorthy@google.com>, "pvorel@suse.cz"
 <pvorel@suse.cz>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
 "Annapurve, Vishal" <vannapurve@google.com>,
 "anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
 "Wang, Wei W" <wei.w.wang@intel.com>, "keirf@google.com" <keirf@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>,
 "aik@amd.com" <aik@amd.com>,
 "usama.arif@bytedance.com" <usama.arif@bytedance.com>,
 "fvdl@google.com" <fvdl@google.com>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "bfoster@redhat.com" <bfoster@redhat.com>,
 "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>,
 "willy@infradead.org" <willy@infradead.org>, "Du, Fan" <fan.du@intel.com>,
 "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mic@digikod.net" <mic@digikod.net>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "Aktas, Erdem" <erdemaktas@google.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "hughd@google.com" <hughd@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>,
 "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "anup@brainfault.org" <anup@brainfault.org>, "maz@kernel.org"
 <maz@kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "jthoughton@google.com" <jthoughton@google.com>,
 "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
 "quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>,
 "Shutemov, Kirill" <kirill.shutemov@intel.com>,
 "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
 "Huang, Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
 "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, "nikunj@amd.com" <nikunj@amd.com>,
 "Graf, Alexander" <graf@amazon.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "jroedel@suse.de" <jroedel@suse.de>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "jgowans@amazon.com" <jgowans@amazon.com>, "Xu, Yilun" <yilun.xu@intel.com>,
 "liam.merwick@oracle.com" <liam.merwick@oracle.com>,
 "michael.roth@amd.com" <michael.roth@amd.com>,
 "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
 "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
 "Weiny, Ira" <ira.weiny@intel.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "qperret@google.com"
 <qperret@google.com>, "kent.overstreet@linux.dev"
 <kent.overstreet@linux.dev>, "dmatlack@google.com" <dmatlack@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "hch@infradead.org" <hch@infradead.org>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "pgonda@google.com" <pgonda@google.com>,
 "quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>,
 "roypat@amazon.co.uk" <roypat@amazon.co.uk>,
 "will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>
References: <cover.1747264138.git.ackerleytng@google.com>
 <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
 <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
 <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
 <aCaM7LS7Z0L3FoC8@google.com>
 <7d3b391f3a31396bd9abe641259392fd94b5e72f.camel@intel.com>
 <CAGtprH8EMnmvvVir6_U+L5S3SEvrU1OzLrvkL58fXgfg59bjoA@mail.gmail.com>
 <ce15353884bd67cc2608d36ef40a178a8d140333.camel@intel.com>
 <aCd5wZ_Tp863I6pP@google.com>
 <8e783fa6ee3997567c661e5c10b05b5d456382fb.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <8e783fa6ee3997567c661e5c10b05b5d456382fb.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/25 12:14, Edgecombe, Rick P wrote:
> Meanwhile I'm watching patches to make 5 level paging walks unconditional fly by
> because people couldn't find a cost to the extra level of walk. So re-litigate,
> no. But I'll probably remain quietly suspicious of the exact cost/value. At
> least on the CPU side, I totally missed the IOTLB side at first, sorry.

It's a little more complicated than just the depth of the worst-case walk.

In practice, many page walks can use the mid-level paging structure
caches because the mappings aren't sparse.

With 5-level paging in particular, userspace doesn't actually change
much at all. Its layout is pretty much the same unless folks are opting
in to the higher (5-level only) address space. So userspace isn't
sparse, at least at the scale of what 5-level paging is capable of.

For the kernel, things are a bit more spread out than they were before.
For instance, the direct map and vmalloc() are in separate p4d pages
when they used to be nestled together in the same half of one pgd.

But, again, they're not *that* sparse. The direct map, for example,
doesn't become more sparse, it just moves to a lower virtual address.
Ditto for vmalloc().  Just because 5-level paging has a massive
vmalloc() area doesn't mean we use it.

Basically, 5-level paging adds a level to the top of the page walk, and
we're really good at caching those when they're not accessed sparsely.

CPUs are not as good at caching the leaf side of the page walk. There
are tricks like AMD's TLB coalescing that help. But, generally, each
walk on the leaf end of the walks eats a TLB entry. Those just don't
cache as well as the top of the tree.

That's why we need to be more maniacal about reducing leaf levels than
the levels toward the root.

