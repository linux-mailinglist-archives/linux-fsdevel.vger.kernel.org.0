Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2C614209
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 01:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKAAC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 20:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKAAC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:02:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CB514D06;
        Mon, 31 Oct 2022 17:02:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m6so12098696pfb.0;
        Mon, 31 Oct 2022 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oS6N/+L/OhffcO3EfR3Iv/UryqKn7hoaC0JJFd1ABbs=;
        b=FEU+ej6a2Z4dObdFfkYQNzqWvGRTS0az/uZN2S7EHoxHRay6dQk1Cm1KybCC1dfxDT
         OyB76sl3fY+1ShqDOwB3Svf48LU6q4YPHuesBoXIj91JVbK+wBWEwsQ/LKaTqEcjqUce
         ApyLN2awgPGKrOu7qBWNVvBywCRkyf+f+BNJpmZyHGXmPvrRmg5V0Opi7kqMaFhl7YC7
         ZfItoBUMXHhr7a2iS6ZLIrKtHZ8b5vdumqDnKfLPIITDYeQ3WWefGuzUL8+oumQUHhW7
         lrYxXkQVjaLUTllewkTl0IIpNOQO9Sv3RFVOqiv2p4SK1UAo9kdR2AdyASdskNj5FmMw
         PhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS6N/+L/OhffcO3EfR3Iv/UryqKn7hoaC0JJFd1ABbs=;
        b=u4w2Mhd+3ftjHC54uzTlbQFWrJu+fudOeBMUnOh7edEQ0E4NOil98cVvPPdZMfLgjV
         7zCyNkzi/uNo2HSgjfrni2565DMe6ywE4wExU1FaXOnvcOtBhOTxkSNoJEUcQQ/rdGxX
         oZ9Nq8p2XWGimKe4nJ2mSF4vlw5UO2RmGnPuenA8AQfhu4WZG3YR/MPpp9Dhw0ED8kJC
         mkR6c3VerApSZ/7H/W4JZvXmgwPyZ5aO8hgijbGaBc9ZukQiYP+aYJmFZOIR6wmuMyG6
         pflUjFUPN0HRIcwqDaOrmFPjnkk8yvYbKIhVceaitMS+GerI3Fvnn35Civuo350YVvse
         uquA==
X-Gm-Message-State: ACrzQf3wbYptGtXNKwlAkyjRcSXhLCT1O/hIQIvGic7E7INuBwkjm8l+
        OJLuNZX3UfNaH+HaVzgeXSM=
X-Google-Smtp-Source: AMsMyM6Ux5ge+1rBOdMB9VQXkykvW/cRl7baTLO/ElNy8RU81cUDIaiW2cViWcwou8S0KckvrDFrgA==
X-Received: by 2002:a05:6a00:805:b0:561:9a81:ef11 with SMTP id m5-20020a056a00080500b005619a81ef11mr29717pfk.86.1667260972541;
        Mon, 31 Oct 2022 17:02:52 -0700 (PDT)
Received: from localhost ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902ed0100b001806445887asm4940403pld.223.2022.10.31.17.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:02:51 -0700 (PDT)
Date:   Mon, 31 Oct 2022 17:02:50 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 7/8] KVM: Handle page fault for private memory
Message-ID: <20221101000250.GA674570@ls.amr.corp.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-8-chao.p.peng@linux.intel.com>
 <20221026215425.GC3819453@ls.amr.corp.intel.com>
 <20221028065545.GD3885130@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028065545.GD3885130@chaop.bj.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:55:45PM +0800,
Chao Peng <chao.p.peng@linux.intel.com> wrote:

> On Wed, Oct 26, 2022 at 02:54:25PM -0700, Isaku Yamahata wrote:
> > On Tue, Oct 25, 2022 at 11:13:43PM +0800,
> > Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > 
> > > A memslot with KVM_MEM_PRIVATE being set can include both fd-based
> > > private memory and hva-based shared memory. Architecture code (like TDX
> > > code) can tell whether the on-going fault is private or not. This patch
> > > adds a 'is_private' field to kvm_page_fault to indicate this and
> > > architecture code is expected to set it.
> > > 
> > > To handle page fault for such memslot, the handling logic is different
> > > depending on whether the fault is private or shared. KVM checks if
> > > 'is_private' matches the host's view of the page (maintained in
> > > mem_attr_array).
> > >   - For a successful match, private pfn is obtained with
> > >     restrictedmem_get_page () from private fd and shared pfn is obtained
> > >     with existing get_user_pages().
> > >   - For a failed match, KVM causes a KVM_EXIT_MEMORY_FAULT exit to
> > >     userspace. Userspace then can convert memory between private/shared
> > >     in host's view and retry the fault.
> > > 
> > > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c          | 56 +++++++++++++++++++++++++++++++--
> > >  arch/x86/kvm/mmu/mmu_internal.h | 14 ++++++++-
> > >  arch/x86/kvm/mmu/mmutrace.h     |  1 +
> > >  arch/x86/kvm/mmu/spte.h         |  6 ++++
> > >  arch/x86/kvm/mmu/tdp_mmu.c      |  3 +-
> > >  include/linux/kvm_host.h        | 28 +++++++++++++++++
> > >  6 files changed, 103 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 67a9823a8c35..10017a9f26ee 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -3030,7 +3030,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
> > >  
> > >  int kvm_mmu_max_mapping_level(struct kvm *kvm,
> > >  			      const struct kvm_memory_slot *slot, gfn_t gfn,
> > > -			      int max_level)
> > > +			      int max_level, bool is_private)
> > >  {
> > >  	struct kvm_lpage_info *linfo;
> > >  	int host_level;
> > > @@ -3042,6 +3042,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
> > >  			break;
> > >  	}
> > >  
> > > +	if (is_private)
> > > +		return max_level;
> > 
> > Below PG_LEVEL_NUM is passed by zap_collapsible_spte_range().  It doesn't make
> > sense.
> > 
> > > +
> > >  	if (max_level == PG_LEVEL_4K)
> > >  		return PG_LEVEL_4K;
> > >  
> > > @@ -3070,7 +3073,8 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> > >  	 * level, which will be used to do precise, accurate accounting.
> > >  	 */
> > >  	fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot,
> > > -						     fault->gfn, fault->max_level);
> > > +						     fault->gfn, fault->max_level,
> > > +						     fault->is_private);
> > >  	if (fault->req_level == PG_LEVEL_4K || fault->huge_page_disallowed)
> > >  		return;
> > >  
> > > @@ -4141,6 +4145,32 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
> > >  	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
> > >  }
> > >  
> > > +static inline u8 order_to_level(int order)
> > > +{
> > > +	BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
> > > +
> > > +	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
> > > +		return PG_LEVEL_1G;
> > > +
> > > +	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
> > > +		return PG_LEVEL_2M;
> > > +
> > > +	return PG_LEVEL_4K;
> > > +}
> > > +
> > > +static int kvm_faultin_pfn_private(struct kvm_page_fault *fault)
> > > +{
> > > +	int order;
> > > +	struct kvm_memory_slot *slot = fault->slot;
> > > +
> > > +	if (kvm_restricted_mem_get_pfn(slot, fault->gfn, &fault->pfn, &order))
> > > +		return RET_PF_RETRY;
> > > +
> > > +	fault->max_level = min(order_to_level(order), fault->max_level);
> > > +	fault->map_writable = !(slot->flags & KVM_MEM_READONLY);
> > > +	return RET_PF_CONTINUE;
> > > +}
> > > +
> > >  static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> > >  {
> > >  	struct kvm_memory_slot *slot = fault->slot;
> > > @@ -4173,6 +4203,22 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> > >  			return RET_PF_EMULATE;
> > >  	}
> > >  
> > > +	if (kvm_slot_can_be_private(slot) &&
> > > +	    fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> > > +		vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
> > > +		if (fault->is_private)
> > > +			vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
> > > +		else
> > > +			vcpu->run->memory.flags = 0;
> > > +		vcpu->run->memory.padding = 0;
> > > +		vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> > > +		vcpu->run->memory.size = PAGE_SIZE;
> > > +		return RET_PF_USER;
> > > +	}
> > > +
> > > +	if (fault->is_private)
> > > +		return kvm_faultin_pfn_private(fault);
> > > +
> > >  	async = false;
> > >  	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
> > >  					  fault->write, &fault->map_writable,
> > > @@ -5557,6 +5603,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
> > >  			return -EIO;
> > >  	}
> > >  
> > > +	if (r == RET_PF_USER)
> > > +		return 0;
> > > +
> > >  	if (r < 0)
> > >  		return r;
> > >  	if (r != RET_PF_EMULATE)
> > > @@ -6408,7 +6457,8 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
> > >  		 */
> > >  		if (sp->role.direct &&
> > >  		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
> > > -							       PG_LEVEL_NUM)) {
> > > +							       PG_LEVEL_NUM,
> > > +							       false)) {
> > >  			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
> > >  
> > >  			if (kvm_available_flush_tlb_with_range())
> > > diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> > > index 582def531d4d..5cdff5ca546c 100644
> > > --- a/arch/x86/kvm/mmu/mmu_internal.h
> > > +++ b/arch/x86/kvm/mmu/mmu_internal.h
> > > @@ -188,6 +188,7 @@ struct kvm_page_fault {
> > >  
> > >  	/* Derived from mmu and global state.  */
> > >  	const bool is_tdp;
> > > +	const bool is_private;
> > >  	const bool nx_huge_page_workaround_enabled;
> > >  
> > >  	/*
> > > @@ -236,6 +237,7 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
> > >   * RET_PF_RETRY: let CPU fault again on the address.
> > >   * RET_PF_EMULATE: mmio page fault, emulate the instruction directly.
> > >   * RET_PF_INVALID: the spte is invalid, let the real page fault path update it.
> > > + * RET_PF_USER: need to exit to userspace to handle this fault.
> > >   * RET_PF_FIXED: The faulting entry has been fixed.
> > >   * RET_PF_SPURIOUS: The faulting entry was already fixed, e.g. by another vCPU.
> > >   *
> > > @@ -252,6 +254,7 @@ enum {
> > >  	RET_PF_RETRY,
> > >  	RET_PF_EMULATE,
> > >  	RET_PF_INVALID,
> > > +	RET_PF_USER,
> > >  	RET_PF_FIXED,
> > >  	RET_PF_SPURIOUS,
> > >  };
> > > @@ -309,7 +312,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> > >  
> > >  int kvm_mmu_max_mapping_level(struct kvm *kvm,
> > >  			      const struct kvm_memory_slot *slot, gfn_t gfn,
> > > -			      int max_level);
> > > +			      int max_level, bool is_private);
> > >  void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
> > >  void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_level);
> > >  
> > > @@ -318,4 +321,13 @@ void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
> > >  void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
> > >  void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
> > >  
> > > +#ifndef CONFIG_HAVE_KVM_RESTRICTED_MEM
> > > +static inline int kvm_restricted_mem_get_pfn(struct kvm_memory_slot *slot,
> > > +					gfn_t gfn, kvm_pfn_t *pfn, int *order)
> > > +{
> > > +	WARN_ON_ONCE(1);
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +#endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
> > > +
> > >  #endif /* __KVM_X86_MMU_INTERNAL_H */
> > > diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
> > > index ae86820cef69..2d7555381955 100644
> > > --- a/arch/x86/kvm/mmu/mmutrace.h
> > > +++ b/arch/x86/kvm/mmu/mmutrace.h
> > > @@ -58,6 +58,7 @@ TRACE_DEFINE_ENUM(RET_PF_CONTINUE);
> > >  TRACE_DEFINE_ENUM(RET_PF_RETRY);
> > >  TRACE_DEFINE_ENUM(RET_PF_EMULATE);
> > >  TRACE_DEFINE_ENUM(RET_PF_INVALID);
> > > +TRACE_DEFINE_ENUM(RET_PF_USER);
> > >  TRACE_DEFINE_ENUM(RET_PF_FIXED);
> > >  TRACE_DEFINE_ENUM(RET_PF_SPURIOUS);
> > >  
> > > diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> > > index 7670c13ce251..9acdf72537ce 100644
> > > --- a/arch/x86/kvm/mmu/spte.h
> > > +++ b/arch/x86/kvm/mmu/spte.h
> > > @@ -315,6 +315,12 @@ static inline bool is_dirty_spte(u64 spte)
> > >  	return dirty_mask ? spte & dirty_mask : spte & PT_WRITABLE_MASK;
> > >  }
> > >  
> > > +static inline bool is_private_spte(u64 spte)
> > > +{
> > > +	/* FIXME: Query C-bit/S-bit for SEV/TDX. */
> > > +	return false;
> > > +}
> > > +
> > 
> > PFN encoded in spte doesn't make sense.  In VMM for TDX, private-vs-shared is
> > determined by S-bit of GFN.
> 
> My understanding is we will have software bit in the spte, will we? In
> current TDX code I see we have SPTE_SHARED_MASK bit defined.

I'm afraid that you're referring old version.  It's not.  For TDX, gfn needs
to be checked.  Which isn't encoded in spte.


> > >  static inline u64 get_rsvd_bits(struct rsvd_bits_validate *rsvd_check, u64 pte,
> > >  				int level)
> > >  {
> > > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > > index 672f0432d777..9f97aac90606 100644
> > > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > > @@ -1768,7 +1768,8 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
> > >  			continue;
> > >  
> > >  		max_mapping_level = kvm_mmu_max_mapping_level(kvm, slot,
> > > -							      iter.gfn, PG_LEVEL_NUM);
> > > +						iter.gfn, PG_LEVEL_NUM,
> > > +						is_private_spte(iter.old_spte));
> > >  		if (max_mapping_level < iter.level)
> > >  			continue;
> > 
> > This is to merge pages into a large page on the next kvm page fault.  large page
> > support is not yet supported.  Let's skip the private slot until large page
> > support is done.
> 
> So what your suggestion is passing in a 'false' at this time for
> 'is_private'? Unless we will decide not use the above is_private_spte,
> this code does not hurt, right? is_private_spte() return false before
> we finally get chance to add the large page support.

Let's pass false always for now.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
