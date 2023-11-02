Return-Path: <linux-fsdevel+bounces-1807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC57DF011
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C061F22658
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384014298;
	Thu,  2 Nov 2023 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L46DUtDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389A1427A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 10:32:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0EB1A2
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 03:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698921162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EePgrsn5C6IrnNIxegoYsuWMp1Sc1phl1cmFpN1d7s8=;
	b=L46DUtDIQz53ccRCdQJFJW+IAJeOTCUlk/sx4p80wcznfruR810GKiOwtP4ylzCiGlKFDX
	podk5YYZT9sfsW7qPcP6fVrvomodgFreTYDjcy6BU0i0uaDplExrcjosRKYpmitAczB1Dh
	2/MHXbm+gWrsNdckstPhqNzG0zDlYQ4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-LbhXDgGZOXahzwiyDurJKA-1; Thu, 02 Nov 2023 06:32:41 -0400
X-MC-Unique: LbhXDgGZOXahzwiyDurJKA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c749c28651so54683866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 03:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921160; x=1699525960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EePgrsn5C6IrnNIxegoYsuWMp1Sc1phl1cmFpN1d7s8=;
        b=OKxGL+DqrqHt9bZqfz6c/0sqXp652Nh4HMmzVsKH6x2pZprRpTvlRY9blg1JDeW8DC
         RqbtYVrRxYuxvyCCRMZFO/zTXOlsIOnBLtPFKk8+9+JzObPnZzRo5Uj1m0wUJ5Nngoyp
         PmsVGxnHL61yAdk38Nr9R0IM59RsiyVEEJvsTzkKkfSkfP6JaMX1Oz0QJAlNKTz3kTOO
         xlgM8sOh+Tv1sStqpGfI+yGuCDzeG21h9kE/3Blex0vJIJzNWU45lPXSM013SVvAANqD
         zweagDYfcxDwxsSddrOlh20LlQS3k7SzL1qvHGm2oSGdrP2/Yb6boG47FDOFPSFmHoo6
         +srQ==
X-Gm-Message-State: AOJu0Ywgk0sbzW0sWRsb5YCJBAJi9H+Akvui9CHPfOY+8seCNHsTV/Qg
	LAPGmoEEvOs9LC7D7UQhB2NwLBBLOq6FNaw7ClUvdCgmpuyNzcH4cuvf5/PwtdGZjPanxj40gQq
	CdNy/GU4isevF2XkWRX8iK7Evhw==
X-Received: by 2002:a17:907:70a:b0:9bd:9bfe:e410 with SMTP id xb10-20020a170907070a00b009bd9bfee410mr4134664ejb.72.1698921160421;
        Thu, 02 Nov 2023 03:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdKWTZCjPNQtOILp1najbjDKUZt1gJ0TmclwPTaP4Nu9rDAFXiy/5MsPxAUlznxhN/2PedEg==
X-Received: by 2002:a17:907:70a:b0:9bd:9bfe:e410 with SMTP id xb10-20020a170907070a00b009bd9bfee410mr4134618ejb.72.1698921159974;
        Thu, 02 Nov 2023 03:32:39 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id y13-20020a170906470d00b0099bd1a78ef5sm957651ejq.74.2023.11.02.03.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 03:32:39 -0700 (PDT)
Message-ID: <a03d0e36-7b38-4841-9c62-66c9029e388d@redhat.com>
Date: Thu, 2 Nov 2023 11:32:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "Christopherson,, Sean" <seanjc@google.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "maz@kernel.org"
 <maz@kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "willy@infradead.org" <willy@infradead.org>,
 "anup@brainfault.org" <anup@brainfault.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
 "mic@digikod.net" <mic@digikod.net>,
 "liam.merwick@oracle.com" <liam.merwick@oracle.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "david@redhat.com" <david@redhat.com>, "tabba@google.com"
 <tabba@google.com>, "amoorthy@google.com" <amoorthy@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "michael.roth@amd.com" <michael.roth@amd.com>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "Annapurve, Vishal" <vannapurve@google.com>, "vbabka@suse.cz"
 <vbabka@suse.cz>, "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
 "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
 "qperret@google.com" <qperret@google.com>,
 "dmatlack@google.com" <dmatlack@google.com>, "Xu, Yilun"
 <yilun.xu@intel.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "Wang, Wei W"
 <wei.w.wang@intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-14-seanjc@google.com>
 <b486ed5036fab6d6d4e13a6c68abddcb9541d51b.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <b486ed5036fab6d6d4e13a6c68abddcb9541d51b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/23 04:01, Huang, Kai wrote:
> On Fri, 2023-10-27 at 11:21 -0700, Sean Christopherson wrote:
>> From: Chao Peng <chao.p.peng@linux.intel.com>
>>
>> In confidential computing usages, whether a page is private or shared is
>> necessary information for KVM to perform operations like page fault
>> handling, page zapping etc. There are other potential use cases for
>> per-page memory attributes, e.g. to make memory read-only (or no-exec,
>> or exec-only, etc.) without having to modify memslots.
>>
>> Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
>> userspace to operate on the per-page memory attributes.
>>    - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
>>      a guest memory range.
>>    - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
>>      memory attributes.
>>
>> Use an xarray to store the per-page attributes internally, with a naive,
>> not fully optimized implementation, i.e. prioritize correctness over
>> performance for the initial implementation.
>>
>> Use bit 3 for the PRIVATE attribute so that KVM can use bits 0-2 for RWX
>> attributes/protections in the future, e.g. to give userspace fine-grained
>> control over read, write, and execute protections for guest memory.
>>
>> Provide arch hooks for handling attribute changes before and after common
>> code sets the new attributes, e.g. x86 will use the "pre" hook to zap all
>> relevant mappings, and the "post" hook to track whether or not hugepages
>> can be used to map the range.
>>
>> To simplify the implementation wrap the entire sequence with
>> kvm_mmu_invalidate_{begin,end}() even though the operation isn't strictly
>> guaranteed to be an invalidation.  For the initial use case, x86 *will*
>> always invalidate memory, and preventing arch code from creating new
>> mappings while the attributes are in flux makes it much easier to reason
>> about the correctness of consuming attributes.
>>
>> It's possible that future usages may not require an invalidation, e.g.
>> if KVM ends up supporting RWX protections and userspace grants _more_
>> protections, but again opt for simplicity and punt optimizations to
>> if/when they are needed.
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com
>> Cc: Fuad Tabba <tabba@google.com>
>> Cc: Xu Yilun <yilun.xu@intel.com>
>> Cc: Mickaël Salaün <mic@digikod.net>
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>> Co-developed-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>
> 
> [...]
> 
>> +Note, there is no "get" API.  Userspace is responsible for explicitly tracking
>> +the state of a gfn/page as needed.
>> +
>>
> 
> [...]
> 
>>   
>> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>> +static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
>> +{
>> +	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
>> +}
> 
> Only call xa_to_value() when xa_load() returns !NULL?

This xarray does not store a pointer, therefore xa_load() actually 
returns an integer that is tagged with 1 in the low bit:

static inline unsigned long xa_to_value(const void *entry)
{
         return (unsigned long)entry >> 1;
}

Returning zero for an empty entry is okay, so the result of xa_load() 
can be used directly.


>> +
>> +bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>> +				     unsigned long attrs);
> 
> Seems it's not immediately clear why this function is needed in this patch,
> especially when you said there is no "get" API above.  Add some material to
> changelog?

It's used by later patches; even without a "get" API, it's a pretty 
fundamental functionality.

>> +bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>> +					struct kvm_gfn_range *range);
>> +bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>> +					 struct kvm_gfn_range *range);
> 
> Looks if this Kconfig is on, the above two arch hooks won't have implementation.
> 
> Is it better to have two __weak empty versions here in this patch?
> 
> Anyway, from the changelog it seems it's not mandatory for some ARCH to provide
> the above two if one wants to turn this on, i.e., the two hooks can be empty and
> the ARCH can just use the __weak version.

I think this can be added by the first arch that needs memory attributes 
and also doesn't need one of these hooks.  Or perhaps the x86 
kvm_arch_pre_set_memory_attributes() could be made generic and thus that 
would be the __weak version.  It's too early to tell, so it's better to 
leave the implementation to the architectures for now.

Paolo


