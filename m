Return-Path: <linux-fsdevel+bounces-1847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B17DF6C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F1B2129F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B4C1CFB6;
	Thu,  2 Nov 2023 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2HWGoThm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6B1CF9A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:44:55 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5D1FB
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:44:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b31e000e97so15951727b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698939894; x=1699544694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWop9ChiDn+5U1d7ZFSKgT7XQaKJkOCdphsca+5hdRc=;
        b=2HWGoThmgpVyvN9kveIIciJRpecImS9TZEgN45xXW9mHLuu9UUMwkP7Ihh7vkQrPfD
         fN5nF1K+tpUujdqrvoFgUr4pZJCPpkGN84BDbVFsR1YOsBua0Ygy0M7PER2kk56p0c16
         mD/QAqjgcJScNuOPijWGMD+Vnpe3YssMeRsNFLa5946MrhmQSiTvyJlAxBiIQlwJIRK9
         gvfEaKatBvklsQErDH+doyL9YdAiVrI0vMGbPZjkaEO80f6Jkxaq5SgOdUMCG6aRWPPI
         W9XGBitq36uGiwh4/LmRufUr22rX3mFn3fIna5zJ+JiZAdyEQE1tSTRj5cshaKKjCieh
         +f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939894; x=1699544694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWop9ChiDn+5U1d7ZFSKgT7XQaKJkOCdphsca+5hdRc=;
        b=EoJuDpeQbduxye1CaOx2hQMuDHZmd2NylCg7tRI5r8ecVsjyg5vLCskXoHQ5QUkVX7
         3aBuAAgp+29cf/V70Xe+Lw4avMECjG2BKE8OhZD5YVWDGWJ664PZreZepQISU104S0R/
         tM/AvRnY6i6KJe57J3DvtgsEweDGWKCrJMqq6m4YbmNjWEosk7/URHNFu6gwGWiiUwRh
         3qJVCv9ovYPG82FpSSy9BA96TtUvJK1ktpx1RZpAw4EbrNosEgSHToJIiTEJ4lQccmNa
         GOUhsXjYSBWDwl7Lu5OPsdt6hKvpRF7ihV7E/LJBB+zzrMW6q70GSBLQj/M5qRkCwHHb
         wLKQ==
X-Gm-Message-State: AOJu0YwsvWbBKHderiggQaybs8lSqWfhZAik1sluoHN8XodL1yw/RK1I
	iUTc9HN2xQwhtJ+v8URvyDlC1mRJT7E=
X-Google-Smtp-Source: AGHT+IEDx2fXN1mZpC4wdLenC0gEZqGHeyYGeZi/NHNboFx849UKp0hRFulm5OGynaHR+kwHxlTzuAC9hXU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d785:0:b0:59b:c811:a709 with SMTP id
 z127-20020a0dd785000000b0059bc811a709mr3270ywd.0.1698939893755; Thu, 02 Nov
 2023 08:44:53 -0700 (PDT)
Date: Thu, 2 Nov 2023 08:44:52 -0700
In-Reply-To: <496b78bb-ad12-4eed-a62c-8c2fd725ec61@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-10-seanjc@google.com>
 <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
 <ZUKMsOdg3N9wmEzy@google.com> <64e3764e36ba7a00d94cc7db1dea1ef06b620aaf.camel@intel.com>
 <32cb71700aedcbd1f65276cf44a601760ffc364b.camel@intel.com> <496b78bb-ad12-4eed-a62c-8c2fd725ec61@redhat.com>
Message-ID: <ZUPD9NWF4eOXqeiA@google.com>
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, "mic@digikod.net" <mic@digikod.net>, 
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "david@redhat.com" <david@redhat.com>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "amoorthy@google.com" <amoorthy@google.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "tabba@google.com" <tabba@google.com>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, Vishal Annapurve <vannapurve@google.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "maz@kernel.org" <maz@kernel.org>, 
	"willy@infradead.org" <willy@infradead.org>, "dmatlack@google.com" <dmatlack@google.com>, 
	"anup@brainfault.org" <anup@brainfault.org>, 
	"yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>, Yilun Xu <yilun.xu@intel.com>, 
	"qperret@google.com" <qperret@google.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Wei W Wang <wei.w.wang@intel.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 02, 2023, Paolo Bonzini wrote:
> On 11/2/23 10:35, Huang, Kai wrote:
> > IIUC KVM can already handle the case of poisoned
> > page by sending signal to user app:
> > 
> > 	static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, 			struct
> > kvm_page_fault *fault)                                               	{
> > 		...
> > 
> >        		if (fault->pfn == KVM_PFN_ERR_HWPOISON) {
> >               		kvm_send_hwpoison_signal(fault->slot, fault->gfn);

No, this doesn't work, because that signals the host virtual address

	unsigned long hva = gfn_to_hva_memslot(slot, gfn);

	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva, PAGE_SHIFT, current);

which is the *shared* page.

> >                 	return RET_PF_RETRY;
> > 	}
> > 	}
> 
> EHWPOISON is not implemented by this series, so it should be left out of the
> documentation.

EHWPOISON *is* implemented.  kvm_gmem_get_pfn() returns -EWPOISON as appropriate,
and kvm_faultin_pfn() returns that directly without going through kvm_handle_error_pfn().

  kvm_faultin_pfn_private()
  |
  |-> kvm_gmem_get_pfn()
      |
      |-> if (folio_test_hwpoison(folio)) {
		r = -EHWPOISON;
		goto out_unlock;
	  }

          |
          |-> 	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
			     &max_order);
		if (r) {
			kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
			return r;
		}

		|
		|-> ret = __kvm_faultin_pfn(vcpu, fault);
		    if (ret != RET_PF_CONTINUE)
			    return ret;

		    if (unlikely(is_error_pfn(fault->pfn)))
			    return kvm_handle_error_pfn(vcpu, fault);

