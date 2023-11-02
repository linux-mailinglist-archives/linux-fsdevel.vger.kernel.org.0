Return-Path: <linux-fsdevel+bounces-1811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D6D7DF0D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 12:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B555D281A71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D631429E;
	Thu,  2 Nov 2023 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7sseUwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6B1426B
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 11:03:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B5DE
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 04:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698923025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o+sUvKh0Fq9LjCXdXIyTK4b/elLQxFDSaWn4T3QHjyo=;
	b=Q7sseUwtWEEI0egtOu8UQU3mCkNiq7VM/SJXS6Q575qofflvGnxctjBcnccBX7o/sJJFVf
	dCEv8xdgMtfhkKKf9Rz1F+upuvMRLoBzGyvndsLT5HJfZcc5p/FJakVkHLU8+Jwf/KcaCY
	W4PxzFg+IZ+4UW1vC2jByOrmig+yFPg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-d6CWbcDTNZamJgevcLvghw-1; Thu, 02 Nov 2023 07:03:44 -0400
X-MC-Unique: d6CWbcDTNZamJgevcLvghw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ba247e03aeso53522266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 04:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698923023; x=1699527823;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+sUvKh0Fq9LjCXdXIyTK4b/elLQxFDSaWn4T3QHjyo=;
        b=XzwlMc1LPEBEEWc4k5CZObpHMr+Z/QuAO/ZCkdqhGoNw2D8DiLtOJhKwpcGZc6+cfj
         DkROM5X3YOMqJK/qqTsjfYS9fVnYUVEFNhfmn9WeGr3yylbg3fS2ApCCBdix9uo/RsmS
         VxlAlLC25jU9C0xfg9WXr89zyPbZYMRGZQM27G1iuR0VsZiuRJlFP/89dXQUens4A/JN
         2syGo2xlRG7S1PJO6WoH0Es04MaK/NdSLjfuUGVI/jm0YRSp2fCbwrj0JK8uzWn3oqyO
         tmeVcQWKPhTvntYeapdvHUbM8TMKQc9fSrGvF2bqJswOUhMLL2W4LhlTrViT7uKlQpE3
         Nc9w==
X-Gm-Message-State: AOJu0Yz4Odgi+I+8EsRkSfYY3AuRCpRAIFD+tDrWMlzEEqlhh1dnPM6I
	1oGaoByDYVvRKj+tdspsn4R8z1M6lCOO/1ijxrW6VZnt8kLTVqg1TyFSlh32dkTxYnaXB5awo+6
	pU8jPZ2IVrlORzWW2HxAVrnSNJQ==
X-Received: by 2002:a17:907:7b99:b0:9be:30c2:b8fd with SMTP id ne25-20020a1709077b9900b009be30c2b8fdmr4830854ejc.66.1698923023216;
        Thu, 02 Nov 2023 04:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAextU6brGleAr873WsCzugduD1+qH+WMku84F2ppJAKPGqD6aYcxwyzrmazywVumiiQ5fXg==
X-Received: by 2002:a17:907:7b99:b0:9be:30c2:b8fd with SMTP id ne25-20020a1709077b9900b009be30c2b8fdmr4830827ejc.66.1698923022777;
        Thu, 02 Nov 2023 04:03:42 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id hk22-20020a170906c9d600b0099cb0a7098dsm1010698ejb.19.2023.11.02.04.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 04:03:42 -0700 (PDT)
Message-ID: <496b78bb-ad12-4eed-a62c-8c2fd725ec61@redhat.com>
Date: Thu, 2 Nov 2023 12:03:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>,
 "Christopherson,, Sean" <seanjc@google.com>
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
 "mic@digikod.net" <mic@digikod.net>,
 "liam.merwick@oracle.com" <liam.merwick@oracle.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "david@redhat.com" <david@redhat.com>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "amoorthy@google.com" <amoorthy@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "tabba@google.com" <tabba@google.com>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "michael.roth@amd.com" <michael.roth@amd.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "Annapurve, Vishal" <vannapurve@google.com>, "vbabka@suse.cz"
 <vbabka@suse.cz>, "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "maz@kernel.org" <maz@kernel.org>, "willy@infradead.org"
 <willy@infradead.org>, "dmatlack@google.com" <dmatlack@google.com>,
 "anup@brainfault.org" <anup@brainfault.org>,
 "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
 "Xu, Yilun" <yilun.xu@intel.com>, "qperret@google.com" <qperret@google.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "Wang, Wei W"
 <wei.w.wang@intel.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-10-seanjc@google.com>
 <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
 <ZUKMsOdg3N9wmEzy@google.com>
 <64e3764e36ba7a00d94cc7db1dea1ef06b620aaf.camel@intel.com>
 <32cb71700aedcbd1f65276cf44a601760ffc364b.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <32cb71700aedcbd1f65276cf44a601760ffc364b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/23 10:35, Huang, Kai wrote:
> IIUC KVM can already handle the case of poisoned
> page by sending signal to user app: 
> 
> 	static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, 
> 			struct kvm_page_fault *fault)                                               
> 	{       
> 		...
> 
>        		if (fault->pfn == KVM_PFN_ERR_HWPOISON) {
>               		kvm_send_hwpoison_signal(fault->slot, fault->gfn);
>                 	return RET_PF_RETRY;                                          
>         	}
> 	}

EHWPOISON is not implemented by this series, so it should be left out of 
the documentation.


> Currently as mentioned above when
> vepc fault handler cannot allocate EPC page KVM returns -EFAULT to Qemu, and
> Qemu prints ...
> 
> 	...: Bad address
> 	<dump guest cpu registers>
> 
> ... which is nonsense.
> 
> If we can use memory_fault.flags (or is 'fault_reason' a better name?) to carry
> a specific value for EPC to let Qemu know and Qemu can then do more reasonable
> things.

Yes, that's a good idea that can be implemented on top.

Paolo


