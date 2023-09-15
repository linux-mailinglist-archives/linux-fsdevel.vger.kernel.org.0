Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798B67A20D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjIOO00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbjIOO0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:26:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A01FD2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 07:26:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7e8bb74b59so2686726276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694787978; x=1695392778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3wwM0IxTv36mTuzbjanMwII1EwyeoxiFmog5O5ddM4=;
        b=fq/Z51Vl+wsdyQeFFTigKSJR/xZ5ekxgC0VPW+sxlOZjsXFQYVeCN1l4NLXvaxsfPX
         lBZW4eUXMZ5ZpCEcIK9CTAo/kYuG0IuVEK/nJYBUDODEvqV8S2yQXSb8opZue6gk+gR7
         7TKaLmemzjsULzHlVAfxEzORHOEbfrBfrZv0y+UHE3yuSV0QWuuO7/TStU6B1Gu5eE1U
         793YcHzKnwESwHWSIud2iQfG4jbTVZniCyUdD/aFjkGGzcGwzZ/Q/A8ymOekRe7cZMXx
         R2AVrzJjxkBpflOkQj5nyQ7CSVTLosaDnlUtjdyPCGxHfPnIvrJ0XxWa1lidx7r5AMDt
         dP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787978; x=1695392778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3wwM0IxTv36mTuzbjanMwII1EwyeoxiFmog5O5ddM4=;
        b=csflrf0M/f/rjYdRGGP/lVzKYwBXdc3SoNkgQuEZCzJ6zQcG+i8kPGA3n8Ow+00mlf
         xv5i8gumEHPSb7EvzQL2pQYMZSQwA15CgW8U3lpyhXl8Ug+PcTMqViSJf29tiizNmKvu
         HFEYdxz9caqcu7nohrkAITsgMtlD3MilHGFC+JeENXEDQ6HVGxOYTU85yKyYVacKNJyc
         jjM/CqMXe85b2NWoxMJxm6CVZibrr41CQItm8xL4a4EOSNPZuzPRoJMwR58lr7MLBPrF
         nE/EKXzJMgVOblw5rTWHzBTQ7iL4/2EdYNliKU7cHH3cEGCCDcw1pEkK8g554d7mbwwm
         ejjQ==
X-Gm-Message-State: AOJu0YwIWMS1r0urOl/PtnM/U1ow0VUokPtjeQVZ7mXoYZpv4f/iOgv5
        JSn2Y0GpKhCMM5F2RL6wb26YmQiSJ6s=
X-Google-Smtp-Source: AGHT+IEtd+ZFiwjGOxGj1IwoYm6uY+zMlhHeo3LWWwltDCF+cgsfqNfOOXS7Bflkew1pSHX6ZJTGM/96YR0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bc8:0:b0:d80:eb4:9ca with SMTP id
 191-20020a250bc8000000b00d800eb409camr37310ybl.0.1694787978719; Fri, 15 Sep
 2023 07:26:18 -0700 (PDT)
Date:   Fri, 15 Sep 2023 07:26:16 -0700
In-Reply-To: <ZQPuMK6D/7UzDH+D@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-19-seanjc@google.com>
 <ZQPuMK6D/7UzDH+D@yzhao56-desk.sh.intel.com>
Message-ID: <ZQRpiOd1DNDDJQ3r@google.com>
Subject: Re: [RFC PATCH v12 18/33] KVM: x86/mmu: Handle page fault for private memory
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023, Yan Zhao wrote:
> On Wed, Sep 13, 2023 at 06:55:16PM -0700, Sean Christopherson wrote:
> ....
> > +static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> > +					      struct kvm_page_fault *fault)
> > +{
> > +	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> > +				      PAGE_SIZE, fault->write, fault->exec,
> > +				      fault->is_private);
> > +}
> > +
> > +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> > +				   struct kvm_page_fault *fault)
> > +{
> > +	int max_order, r;
> > +
> > +	if (!kvm_slot_can_be_private(fault->slot)) {
> > +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > +		return -EFAULT;
> > +	}
> > +
> > +	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
> > +			     &max_order);
> > +	if (r) {
> > +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > +		return r;
> > +	}
> > +
> > +	fault->max_level = min(kvm_max_level_for_order(max_order),
> > +			       fault->max_level);
> > +	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
> > +
> > +	return RET_PF_CONTINUE;
> > +}
> > +
> >  static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >  {
> >  	struct kvm_memory_slot *slot = fault->slot;
> > @@ -4293,6 +4356,14 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  			return RET_PF_EMULATE;
> >  	}
> >  
> > +	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> In patch 21,
> fault->is_private is set as:
> 	".is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT)",
> then, the inequality here means memory attribute has been updated after
> last check.
> So, why an exit to user space for converting is required instead of a mere retry?
> 
> Or, is it because how .is_private is assigned in patch 21 is subjected to change
> in future? 

This.  Retrying on SNP or TDX would hang the guest.  I suppose we could special
case VMs where .is_private is derived from the memory attributes, but the
SW_PROTECTED_VM type is primary a development vehicle at this point.  I'd like to
have it mimic SNP/TDX as much as possible; performance is a secondary concern.

E.g. userspace needs to be prepared for "spurious" exits due to races on SNP and
TDX, which this can theoretically exercise.  Though the window is quite small so
I doubt that'll actually happen in practice; which of course also makes it less
important to retry instead of exiting.
