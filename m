Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40179F6BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 03:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjINB4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 21:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjINBzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:55:53 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C001BFC
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:40 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56f75e70190so342187a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656540; x=1695261340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/PWByveWahNDDpwQn3dTY8oCHEhRVqmq8s8F8KhgOhw=;
        b=eFPOkpWWd8xq7LTpLgL5afY9xRV7JuEnSft/7W+iLQ8SEPNAPSc1BU9+Rq++vp/jmM
         +B2ZDp/ygrGfDaywVyGk4JbP2gM/uvIe4rcn9j30ICeS9+lvYuafcDxm+/LzgnqeKJSO
         m+aokiGenzhffVe3JNg+AcIzEluVvT6EILnORPWgaloXVbyjtctfbjU/lwLQwxTTNQhZ
         XNQMN52mqUDDAY6Qts6VxvmN4JJd/6Jo3WOg0m/NV5H/QkAX1jLpT0p5w9dv8/DcZiSj
         3MdTJ3kqHDSaL5ueiBdnlpOa0WD0qGwCQzQc5TIT3CBz0elzO4Z7HsAp4uf8xIQh3P8s
         HFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656540; x=1695261340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PWByveWahNDDpwQn3dTY8oCHEhRVqmq8s8F8KhgOhw=;
        b=cr0nKKFS8E+XfZrYQpalCz+CI6ZRevP9Jsl91h6AHG3JNSPjN3r2asr84rZ11ZKR8+
         Rl/mx6aF0efmUA5IdN1w03fKYrSomr/ZIJnJ/m2izo2qkJmqlMceAClhJNCVuGxLhy+C
         u6Lk1/iMePGtz9KTbX/TnFJGKz5SDyMDI1Qd5RLVqOgIjrfTGRoWPg+9LMvJ5TiQOQjq
         B8Sb1IpSuPYvNQZUVXltmOnzTMBNZ8vyhAg/KysPYBiprG9dfBUPJGDOi5AMBNYPILd0
         h1j4rnnWI9mshoxgUKYhe9VySstMyIolIZ2L2ey7VECm8sRdtpUo1ivSnY/AW+rvtxS2
         +Kqw==
X-Gm-Message-State: AOJu0YxJVp7/C5hqv8lypE96RZf7+16CS4hfanX9Uz8UtIxavr3HPb2z
        MxMTaiiaVYJooiJazc91mIAtXilheiE=
X-Google-Smtp-Source: AGHT+IFH7Y8a1vBNnSACzhOpKycbEt9pew6IzwhiL/gw/jXJMO2Ad5b3/QDP/rYw9JwfwFTkI8vz1sHeU4s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:230b:b0:1bf:cc5:7b53 with SMTP id
 d11-20020a170903230b00b001bf0cc57b53mr198908plh.1.1694656539979; Wed, 13 Sep
 2023 18:55:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:00 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-3-seanjc@google.com>
Subject: [RFC PATCH v12 02/33] KVM: Use gfn instead of hva for mmu_notifier_retry
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Currently in mmu_notifier invalidate path, hva range is recorded and
then checked against by mmu_notifier_retry_hva() in the page fault
handling path. However, for the to be introduced private memory, a page
fault may not have a hva associated, checking gfn(gpa) makes more sense.

For existing hva based shared memory, gfn is expected to also work. The
only downside is when aliasing multiple gfns to a single hva, the
current algorithm of checking multiple ranges could result in a much
larger range being rejected. Such aliasing should be uncommon, so the
impact is expected small.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
[sean: convert vmx_set_apic_access_page_addr() to gfn-based API]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c   | 10 ++++++----
 arch/x86/kvm/vmx/vmx.c   | 11 +++++------
 include/linux/kvm_host.h | 33 +++++++++++++++++++++------------
 virt/kvm/kvm_main.c      | 40 +++++++++++++++++++++++++++++++---------
 4 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e1d011c67cc6..0f0231d2b74f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3056,7 +3056,7 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
  *
  * There are several ways to safely use this helper:
  *
- * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, before
+ * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
  *   consuming it.  In this case, mmu_lock doesn't need to be held during the
  *   lookup, but it does need to be held while checking the MMU notifier.
  *
@@ -4358,7 +4358,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 		return true;
 
 	return fault->slot &&
-	       mmu_invalidate_retry_hva(vcpu->kvm, fault->mmu_seq, fault->hva);
+	       mmu_invalidate_retry_gfn(vcpu->kvm, fault->mmu_seq, fault->gfn);
 }
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
@@ -6253,7 +6253,9 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 	write_lock(&kvm->mmu_lock);
 
-	kvm_mmu_invalidate_begin(kvm, 0, -1ul);
+	kvm_mmu_invalidate_begin(kvm);
+
+	kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
 
 	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
 
@@ -6266,7 +6268,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 	if (flush)
 		kvm_flush_remote_tlbs_range(kvm, gfn_start, gfn_end - gfn_start);
 
-	kvm_mmu_invalidate_end(kvm, 0, -1ul);
+	kvm_mmu_invalidate_end(kvm);
 
 	write_unlock(&kvm->mmu_lock);
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 72e3943f3693..6e502ba93141 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6757,10 +6757,10 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 		return;
 
 	/*
-	 * Grab the memslot so that the hva lookup for the mmu_notifier retry
-	 * is guaranteed to use the same memslot as the pfn lookup, i.e. rely
-	 * on the pfn lookup's validation of the memslot to ensure a valid hva
-	 * is used for the retry check.
+	 * Explicitly grab the memslot using KVM's internal slot ID to ensure
+	 * KVM doesn't unintentionally grab a userspace memslot.  It _should_
+	 * be impossible for userspace to create a memslot for the APIC when
+	 * APICv is enabled, but paranoia won't hurt in this case.
 	 */
 	slot = id_to_memslot(slots, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT);
 	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
@@ -6785,8 +6785,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 		return;
 
 	read_lock(&vcpu->kvm->mmu_lock);
-	if (mmu_invalidate_retry_hva(kvm, mmu_seq,
-				     gfn_to_hva_memslot(slot, gfn))) {
+	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
 		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 		read_unlock(&vcpu->kvm->mmu_lock);
 		goto out;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fb6c6109fdca..11d091688346 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -787,8 +787,8 @@ struct kvm {
 	struct mmu_notifier mmu_notifier;
 	unsigned long mmu_invalidate_seq;
 	long mmu_invalidate_in_progress;
-	unsigned long mmu_invalidate_range_start;
-	unsigned long mmu_invalidate_range_end;
+	gfn_t mmu_invalidate_range_start;
+	gfn_t mmu_invalidate_range_end;
 #endif
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
@@ -1392,10 +1392,9 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
 void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 #endif
 
-void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
-			      unsigned long end);
-void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
-			    unsigned long end);
+void kvm_mmu_invalidate_begin(struct kvm *kvm);
+void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
+void kvm_mmu_invalidate_end(struct kvm *kvm);
 
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
@@ -1970,9 +1969,9 @@ static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 	return 0;
 }
 
-static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
+static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
 					   unsigned long mmu_seq,
-					   unsigned long hva)
+					   gfn_t gfn)
 {
 	lockdep_assert_held(&kvm->mmu_lock);
 	/*
@@ -1981,10 +1980,20 @@ static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
 	 * that might be being invalidated. Note that it may include some false
 	 * positives, due to shortcuts when handing concurrent invalidations.
 	 */
-	if (unlikely(kvm->mmu_invalidate_in_progress) &&
-	    hva >= kvm->mmu_invalidate_range_start &&
-	    hva < kvm->mmu_invalidate_range_end)
-		return 1;
+	if (unlikely(kvm->mmu_invalidate_in_progress)) {
+		/*
+		 * Dropping mmu_lock after bumping mmu_invalidate_in_progress
+		 * but before updating the range is a KVM bug.
+		 */
+		if (WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA ||
+				 kvm->mmu_invalidate_range_end == INVALID_GPA))
+			return 1;
+
+		if (gfn >= kvm->mmu_invalidate_range_start &&
+		    gfn < kvm->mmu_invalidate_range_end)
+			return 1;
+	}
+
 	if (kvm->mmu_invalidate_seq != mmu_seq)
 		return 1;
 	return 0;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0524933856d4..4fad3b01dc1f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -543,9 +543,7 @@ static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
 
 typedef bool (*gfn_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
 
-typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
-			     unsigned long end);
-
+typedef void (*on_lock_fn_t)(struct kvm *kvm);
 typedef void (*on_unlock_fn_t)(struct kvm *kvm);
 
 struct kvm_mmu_notifier_range {
@@ -637,7 +635,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 				locked = true;
 				KVM_MMU_LOCK(kvm);
 				if (!IS_KVM_NULL_FN(range->on_lock))
-					range->on_lock(kvm, range->start, range->end);
+					range->on_lock(kvm);
+
 				if (IS_KVM_NULL_FN(range->handler))
 					break;
 			}
@@ -742,15 +741,26 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	kvm_handle_hva_range(mn, address, address + 1, arg, kvm_change_spte_gfn);
 }
 
-void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
-			      unsigned long end)
+void kvm_mmu_invalidate_begin(struct kvm *kvm)
 {
+	lockdep_assert_held_write(&kvm->mmu_lock);
 	/*
 	 * The count increase must become visible at unlock time as no
 	 * spte can be established without taking the mmu_lock and
 	 * count is also read inside the mmu_lock critical section.
 	 */
 	kvm->mmu_invalidate_in_progress++;
+
+	if (likely(kvm->mmu_invalidate_in_progress == 1))
+		kvm->mmu_invalidate_range_start = INVALID_GPA;
+}
+
+void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
+{
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
+
 	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
 		kvm->mmu_invalidate_range_start = start;
 		kvm->mmu_invalidate_range_end = end;
@@ -771,6 +781,12 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
 	}
 }
 
+static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
+	return kvm_unmap_gfn_range(kvm, range);
+}
+
 static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
 {
@@ -778,7 +794,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	const struct kvm_mmu_notifier_range hva_range = {
 		.start		= range->start,
 		.end		= range->end,
-		.handler	= kvm_unmap_gfn_range,
+		.handler	= kvm_mmu_unmap_gfn_range,
 		.on_lock	= kvm_mmu_invalidate_begin,
 		.on_unlock	= kvm_arch_guest_memory_reclaimed,
 		.flush_on_ret	= true,
@@ -817,8 +833,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	return 0;
 }
 
-void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
-			    unsigned long end)
+void kvm_mmu_invalidate_end(struct kvm *kvm)
 {
 	/*
 	 * This sequence increase will notify the kvm page fault that
@@ -833,6 +848,13 @@ void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
 	 * in conjunction with the smp_rmb in mmu_invalidate_retry().
 	 */
 	kvm->mmu_invalidate_in_progress--;
+
+	/*
+	 * Assert that at least one range must be added between start() and
+	 * end().  Not adding a range isn't fatal, but it is a KVM bug.
+	 */
+	WARN_ON_ONCE(kvm->mmu_invalidate_in_progress &&
+		     kvm->mmu_invalidate_range_start == INVALID_GPA);
 }
 
 static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
-- 
2.42.0.283.g2d96d420d3-goog

