Return-Path: <linux-fsdevel+bounces-1554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E967DBE4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 17:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931A91C20B87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA919459;
	Mon, 30 Oct 2023 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4aXwTYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57818B10
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 16:53:57 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651AABD
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 09:53:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc34c3420bso9139425ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698684835; x=1699289635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2Qy05fJV7O/T/e2KrUkQigx6UtJsi8HFmlOQKzP0uU=;
        b=g4aXwTYxG6SYMWV89/1gGfk+dsT+IYV65M268WvyrGn5oEAlYJAUhY6EXrwfQA6u9R
         SEop3iWzLu214FGGvdOO0xIRVdmq/th+a0/Pxi/YeA57apt1Puv1haqTPl0cYO7vTUqW
         oc139djDriHdRokSv+FKlFT4+maOs9uRoNnEIS9BtWbOehd9Zp5zC6C4MwcIYjk+WGGb
         oY5ql0TG+5nSZoin0IvKBTtYk3j2NsAnOOCablbvkhkOg1QLJYqiP7cHKKZ2UnmkxoqX
         I4Qf/VFYG29tD9FPwXbn3np0rnCrAbL7OdYuAWxhoIJdzu6DDc0Dewq3AEpV3+cdEhu/
         Cccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698684835; x=1699289635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2Qy05fJV7O/T/e2KrUkQigx6UtJsi8HFmlOQKzP0uU=;
        b=AL8xnagb2YnStQ3ro+2oFN+d8S/R/SKGOk4/uL07gkj5lpWBvMfTZSGpQbr5NiFOt6
         4xq7+XUm+oNplK8uu8HX55t25bAaEuBO0I1h/4SGGcLnMX3nx2IWLSCc688Ck9kckIRz
         TJwAg5QadMvS642XQ10Zt0tY1SwAcAlvOa/C7TmSS75CS1ra5+fb6Veg9VlcYgIBM8im
         DUVfGG8A6+wLcPcXaU9IfuzUr5AEVeVfL/AScIJvW7te4dJb/UknlZdcA8pl/Yhr6LWU
         GCXdZGOWdJlQzafev24HTSYgrhf9gRXkSrsZKAz2n+5evPSyuoSIa2OeIjqYxusE+pA9
         mTxw==
X-Gm-Message-State: AOJu0YxZgjfh76IuerOsBvex+iBGZrqTUu2yW1lGWLMBjHtbZsRvWDWV
	i65WuLNYKYkneUlYobXMvWvoxg==
X-Google-Smtp-Source: AGHT+IELyEzMPCZIK1jGGqzZjOjX483WaD7ycdUy6EWhivpECGBZ90269Yo9hhrNGYoSLvPayW0Jww==
X-Received: by 2002:a17:902:d581:b0:1cc:32ce:bd9 with SMTP id k1-20020a170902d58100b001cc32ce0bd9mr5679200plh.69.1698684834654;
        Mon, 30 Oct 2023 09:53:54 -0700 (PDT)
Received: from google.com (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001cc32f46757sm4438158plz.107.2023.10.30.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 09:53:53 -0700 (PDT)
Date: Mon, 30 Oct 2023 09:53:48 -0700
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Maciej Szmigiero <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>,
	Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v13 03/35] KVM: Use gfn instead of hva for
 mmu_notifier_retry
Message-ID: <ZT_fnAcDAvuPCwws@google.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027182217.3615211-4-seanjc@google.com>

On 2023-10-27 11:21 AM, Sean Christopherson wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Currently in mmu_notifier invalidate path, hva range is recorded and
> then checked against by mmu_notifier_retry_hva() in the page fault
> handling path. However, for the to be introduced private memory, a page
                          ^^^^^^^^^^^^^^^^^^^^^^^^

Is there a missing word here?

> fault may not have a hva associated, checking gfn(gpa) makes more sense.
> 
> For existing hva based shared memory, gfn is expected to also work. The
> only downside is when aliasing multiple gfns to a single hva, the
> current algorithm of checking multiple ranges could result in a much
> larger range being rejected. Such aliasing should be uncommon, so the
> impact is expected small.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Cc: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> [sean: convert vmx_set_apic_access_page_addr() to gfn-based API]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c   | 10 ++++++----
>  arch/x86/kvm/vmx/vmx.c   | 11 +++++------
>  include/linux/kvm_host.h | 33 ++++++++++++++++++++------------
>  virt/kvm/kvm_main.c      | 41 +++++++++++++++++++++++++++++++---------
>  4 files changed, 64 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index f7901cb4d2fa..d33657d61d80 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3056,7 +3056,7 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
>   *
>   * There are several ways to safely use this helper:
>   *
> - * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, before
> + * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
>   *   consuming it.  In this case, mmu_lock doesn't need to be held during the
>   *   lookup, but it does need to be held while checking the MMU notifier.
>   *
> @@ -4358,7 +4358,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
>  		return true;
>  
>  	return fault->slot &&
> -	       mmu_invalidate_retry_hva(vcpu->kvm, fault->mmu_seq, fault->hva);
> +	       mmu_invalidate_retry_gfn(vcpu->kvm, fault->mmu_seq, fault->gfn);
>  }
>  
>  static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> @@ -6245,7 +6245,9 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>  
>  	write_lock(&kvm->mmu_lock);
>  
> -	kvm_mmu_invalidate_begin(kvm, 0, -1ul);
> +	kvm_mmu_invalidate_begin(kvm);
> +
> +	kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
>  
>  	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
>  
> @@ -6255,7 +6257,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>  	if (flush)
>  		kvm_flush_remote_tlbs_range(kvm, gfn_start, gfn_end - gfn_start);
>  
> -	kvm_mmu_invalidate_end(kvm, 0, -1ul);
> +	kvm_mmu_invalidate_end(kvm);
>  
>  	write_unlock(&kvm->mmu_lock);
>  }
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 72e3943f3693..6e502ba93141 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6757,10 +6757,10 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
>  		return;
>  
>  	/*
> -	 * Grab the memslot so that the hva lookup for the mmu_notifier retry
> -	 * is guaranteed to use the same memslot as the pfn lookup, i.e. rely
> -	 * on the pfn lookup's validation of the memslot to ensure a valid hva
> -	 * is used for the retry check.
> +	 * Explicitly grab the memslot using KVM's internal slot ID to ensure
> +	 * KVM doesn't unintentionally grab a userspace memslot.  It _should_
> +	 * be impossible for userspace to create a memslot for the APIC when
> +	 * APICv is enabled, but paranoia won't hurt in this case.
>  	 */
>  	slot = id_to_memslot(slots, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT);
>  	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
> @@ -6785,8 +6785,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
>  		return;
>  
>  	read_lock(&vcpu->kvm->mmu_lock);
> -	if (mmu_invalidate_retry_hva(kvm, mmu_seq,
> -				     gfn_to_hva_memslot(slot, gfn))) {
> +	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
>  		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
>  		read_unlock(&vcpu->kvm->mmu_lock);
>  		goto out;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index fb6c6109fdca..11d091688346 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -787,8 +787,8 @@ struct kvm {
>  	struct mmu_notifier mmu_notifier;
>  	unsigned long mmu_invalidate_seq;
>  	long mmu_invalidate_in_progress;
> -	unsigned long mmu_invalidate_range_start;
> -	unsigned long mmu_invalidate_range_end;
> +	gfn_t mmu_invalidate_range_start;
> +	gfn_t mmu_invalidate_range_end;
>  #endif
>  	struct list_head devices;
>  	u64 manual_dirty_log_protect;
> @@ -1392,10 +1392,9 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
>  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
>  #endif
>  
> -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> -			      unsigned long end);
> -void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
> -			    unsigned long end);
> +void kvm_mmu_invalidate_begin(struct kvm *kvm);
> +void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);

What is the reason to separate range_add() from begin()?

> +void kvm_mmu_invalidate_end(struct kvm *kvm);
>  
>  long kvm_arch_dev_ioctl(struct file *filp,
>  			unsigned int ioctl, unsigned long arg);
> @@ -1970,9 +1969,9 @@ static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
>  	return 0;
>  }
>  
> -static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
> +static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
>  					   unsigned long mmu_seq,
> -					   unsigned long hva)
> +					   gfn_t gfn)
>  {
>  	lockdep_assert_held(&kvm->mmu_lock);
>  	/*
> @@ -1981,10 +1980,20 @@ static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
>  	 * that might be being invalidated. Note that it may include some false
>  	 * positives, due to shortcuts when handing concurrent invalidations.
>  	 */
> -	if (unlikely(kvm->mmu_invalidate_in_progress) &&
> -	    hva >= kvm->mmu_invalidate_range_start &&
> -	    hva < kvm->mmu_invalidate_range_end)
> -		return 1;
> +	if (unlikely(kvm->mmu_invalidate_in_progress)) {
> +		/*
> +		 * Dropping mmu_lock after bumping mmu_invalidate_in_progress
> +		 * but before updating the range is a KVM bug.
> +		 */
> +		if (WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA ||
> +				 kvm->mmu_invalidate_range_end == INVALID_GPA))
> +			return 1;
> +
> +		if (gfn >= kvm->mmu_invalidate_range_start &&
> +		    gfn < kvm->mmu_invalidate_range_end)
> +			return 1;
> +	}
> +
>  	if (kvm->mmu_invalidate_seq != mmu_seq)
>  		return 1;
>  	return 0;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5a97e6c7d9c2..1a577a25de47 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -543,9 +543,7 @@ static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
>  
>  typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
>  
> -typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
> -			     unsigned long end);
> -
> +typedef void (*on_lock_fn_t)(struct kvm *kvm);
>  typedef void (*on_unlock_fn_t)(struct kvm *kvm);
>  
>  struct kvm_mmu_notifier_range {
> @@ -637,7 +635,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
>  				locked = true;
>  				KVM_MMU_LOCK(kvm);
>  				if (!IS_KVM_NULL_FN(range->on_lock))
> -					range->on_lock(kvm, range->start, range->end);
> +					range->on_lock(kvm);
> +
>  				if (IS_KVM_NULL_FN(range->handler))
>  					break;
>  			}
> @@ -742,16 +741,29 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>  	kvm_handle_hva_range(mn, address, address + 1, arg, kvm_change_spte_gfn);
>  }
>  
> -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> -			      unsigned long end)
> +void kvm_mmu_invalidate_begin(struct kvm *kvm)
>  {
> +	lockdep_assert_held_write(&kvm->mmu_lock);
>  	/*
>  	 * The count increase must become visible at unlock time as no
>  	 * spte can be established without taking the mmu_lock and
>  	 * count is also read inside the mmu_lock critical section.
>  	 */
>  	kvm->mmu_invalidate_in_progress++;
> +
>  	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
> +		kvm->mmu_invalidate_range_start = INVALID_GPA;
> +		kvm->mmu_invalidate_range_end = INVALID_GPA;

I don't think this is incorrect, but I was a little suprised to see this
here rather than in end() when mmu_invalidate_in_progress decrements to
0.

> +	}
> +}
> +
> +void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +	lockdep_assert_held_write(&kvm->mmu_lock);

Does this compile/function on KVM architectures with
!KVM_HAVE_MMU_RWLOCK? I assumed we would get an email from the buildbot
if it didn't compile but I don't know if buildbot builds with lockdep
enabled.

On this topic, I wonder if we should just bit the bullet and convert all
architectures to a rwlock_t.

> +
> +	WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
> +
> +	if (likely(kvm->mmu_invalidate_range_start == INVALID_GPA)) {
>  		kvm->mmu_invalidate_range_start = start;
>  		kvm->mmu_invalidate_range_end = end;
>  	} else {
> @@ -771,6 +783,12 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
>  	}
>  }
>  
> +static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
> +	return kvm_unmap_gfn_range(kvm, range);
> +}
> +
>  static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>  					const struct mmu_notifier_range *range)
>  {
> @@ -778,7 +796,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>  	const struct kvm_mmu_notifier_range hva_range = {
>  		.start		= range->start,
>  		.end		= range->end,
> -		.handler	= kvm_unmap_gfn_range,
> +		.handler	= kvm_mmu_unmap_gfn_range,
>  		.on_lock	= kvm_mmu_invalidate_begin,
>  		.on_unlock	= kvm_arch_guest_memory_reclaimed,
>  		.flush_on_ret	= true,
> @@ -817,8 +835,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>  	return 0;
>  }
>  
> -void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
> -			    unsigned long end)
> +void kvm_mmu_invalidate_end(struct kvm *kvm)
>  {
>  	/*
>  	 * This sequence increase will notify the kvm page fault that
> @@ -834,6 +851,12 @@ void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,

Let's add a lockdep_assert_held_write(&kvm->mmu_lock) here too while
we're at it?

>  	 */
>  	kvm->mmu_invalidate_in_progress--;
>  	KVM_BUG_ON(kvm->mmu_invalidate_in_progress < 0, kvm);
> +
> +	/*
> +	 * Assert that at least one range was added between start() and end().
> +	 * Not adding a range isn't fatal, but it is a KVM bug.
> +	 */
> +	WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA);
>  }
>  
>  static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
> -- 
> 2.42.0.820.g83a721a137-goog
> 

