Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0F4758927
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGRXsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGRXsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:48:35 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E310B
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:33 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b8b30f781cso32250295ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724113; x=1692316113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LxdpiWTpX3B7gMKbPihLQ6FRzF4V55oVGzPxSGe/+4U=;
        b=1t0P5wmE/XmWdqU7J55641EABrTeVarxWaQR4bJ8HE5kvt+bT2Zvilx6zvBC6IhCug
         lxtaG0ZNNeNxKJwNRyofNcY/3UY8SXaGscGhXtOBqjuhZKJLWAvQEL/Od2vXIHWkp721
         m6ADzg8L3JrLCsaJYeIfX0G7ZaqvY3dbA4PpFF78/ivmcmih9CPggzA6FpbWCll6Rc7J
         s/iuth191O25UoKCd/SjRjFkh1FVoiOHo2ymxYD/iPBQpPOGMgrdqXeht4Yx5rEFGAGu
         E6MjDgW0gFgwwVKsMh4xUPmBsbIlsG5Mzs33eQjh6Yww/GhiF/1eZ4NrCcSo7R/KWv9Z
         IRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724113; x=1692316113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxdpiWTpX3B7gMKbPihLQ6FRzF4V55oVGzPxSGe/+4U=;
        b=Quf0T55r1tCXtnsJjGw39lPgGnWdnO71M1yZCblhXal6l3PMsVvYPF0jRb66aTGSLK
         72rUNvQ/quHTX2ZHGEHrHIO5RuBqvIuHpmSQ5n3UbRZw1DK9DA10xB17Js9GU6slgEV0
         d9J9dKBStYljr8+rS6I3oiIhfLMffEaQDWk8dyZPUaQAC7fNXRtHCFIWyEmrLG6V6WtY
         K8QmDRw/8GImGFKeiLIa6Le7Du/JOLlSwGiXaVCyQto3c00rCGPHuQIZrofOaBplm97r
         kMAy9yPmPtfQL6DQhAB40ic0v7bJhbqSHYQKmq7oQGnpyG4RjMj94lu1XraD8bRuqDvb
         fqAw==
X-Gm-Message-State: ABy/qLbxP9EtcU3Q1veuXGEsav9J3+o7EFfSDQUcKcD4LbfGFa0v3CzZ
        5Jj5v+0GgXYq5bnWoYGpsNPivxi8q4I=
X-Google-Smtp-Source: APBJJlECbx+0jj+7Hb3hGFg2pirZsYDF3lE8aX5+9Q/S485STdtV3M1qZMxLbtNxaVklqPoT+BTJIsFwzzk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2349:b0:1b9:de12:475 with SMTP id
 c9-20020a170903234900b001b9de120475mr8788plh.6.1689724113231; Tue, 18 Jul
 2023 16:48:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:44:44 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-2-seanjc@google.com>
Subject: [RFC PATCH v11 01/29] KVM: Wrap kvm_gfn_range.pte in a per-action union
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c       |  2 +-
 arch/mips/kvm/mmu.c        |  2 +-
 arch/riscv/kvm/mmu.c       |  2 +-
 arch/x86/kvm/mmu/mmu.c     |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c |  6 +++---
 include/linux/kvm_host.h   |  5 ++++-
 virt/kvm/kvm_main.c        | 16 ++++++++++------
 7 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6db9ef288ec3..55f03a68f1cd 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1721,7 +1721,7 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 
 bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	kvm_pfn_t pfn = pte_pfn(range->pte);
+	kvm_pfn_t pfn = pte_pfn(range->arg.pte);
 
 	if (!kvm->arch.mmu.pgt)
 		return false;
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index e8c08988ed37..7b2ac1319d70 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -447,7 +447,7 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	gpa_t gpa = range->start << PAGE_SHIFT;
-	pte_t hva_pte = range->pte;
+	pte_t hva_pte = range->arg.pte;
 	pte_t *gpa_pte = kvm_mips_pte_for_gpa(kvm, NULL, gpa);
 	pte_t old_pte;
 
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index f2eb47925806..857f4312b0f8 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -559,7 +559,7 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	int ret;
-	kvm_pfn_t pfn = pte_pfn(range->pte);
+	kvm_pfn_t pfn = pte_pfn(range->arg.pte);
 
 	if (!kvm->arch.pgd)
 		return false;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ec169f5c7dce..d72f2b20f430 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1588,7 +1588,7 @@ static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
 	for_each_slot_rmap_range(range->slot, PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
 				 range->start, range->end - 1, &iterator)
 		ret |= handler(kvm, iterator.rmap, range->slot, iterator.gfn,
-			       iterator.level, range->pte);
+			       iterator.level, range->arg.pte);
 
 	return ret;
 }
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 512163d52194..6250bd3d20c1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1241,7 +1241,7 @@ static bool set_spte_gfn(struct kvm *kvm, struct tdp_iter *iter,
 	u64 new_spte;
 
 	/* Huge pages aren't expected to be modified without first being zapped. */
-	WARN_ON(pte_huge(range->pte) || range->start + 1 != range->end);
+	WARN_ON(pte_huge(range->arg.pte) || range->start + 1 != range->end);
 
 	if (iter->level != PG_LEVEL_4K ||
 	    !is_shadow_present_pte(iter->old_spte))
@@ -1255,9 +1255,9 @@ static bool set_spte_gfn(struct kvm *kvm, struct tdp_iter *iter,
 	 */
 	tdp_mmu_iter_set_spte(kvm, iter, 0);
 
-	if (!pte_write(range->pte)) {
+	if (!pte_write(range->arg.pte)) {
 		new_spte = kvm_mmu_changed_pte_notifier_make_spte(iter->old_spte,
-								  pte_pfn(range->pte));
+								  pte_pfn(range->arg.pte));
 
 		tdp_mmu_iter_set_spte(kvm, iter, new_spte);
 	}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9d3ac7720da9..b901571ab61e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -260,7 +260,10 @@ struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
 	gfn_t start;
 	gfn_t end;
-	pte_t pte;
+	union {
+		pte_t pte;
+		u64 raw;
+	} arg;
 	bool may_block;
 };
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dfbaafbe3a00..d58b7a506d27 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -526,7 +526,10 @@ typedef void (*on_unlock_fn_t)(struct kvm *kvm);
 struct kvm_hva_range {
 	unsigned long start;
 	unsigned long end;
-	pte_t pte;
+	union {
+		pte_t pte;
+		u64 raw;
+	} arg;
 	hva_handler_t handler;
 	on_lock_fn_t on_lock;
 	on_unlock_fn_t on_unlock;
@@ -562,6 +565,10 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 	struct kvm_memslots *slots;
 	int i, idx;
 
+	BUILD_BUG_ON(sizeof(gfn_range.arg) != sizeof(gfn_range.arg.raw));
+	BUILD_BUG_ON(sizeof(range->arg) != sizeof(range->arg.raw));
+	BUILD_BUG_ON(sizeof(gfn_range.arg) != sizeof(range->arg));
+
 	if (WARN_ON_ONCE(range->end <= range->start))
 		return 0;
 
@@ -591,7 +598,7 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 			 * bother making these conditional (to avoid writes on
 			 * the second or later invocation of the handler).
 			 */
-			gfn_range.pte = range->pte;
+			gfn_range.arg.raw = range->arg.raw;
 			gfn_range.may_block = range->may_block;
 
 			/*
@@ -639,7 +646,7 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 	const struct kvm_hva_range range = {
 		.start		= start,
 		.end		= end,
-		.pte		= pte,
+		.arg.pte	= pte,
 		.handler	= handler,
 		.on_lock	= (void *)kvm_null_fn,
 		.on_unlock	= (void *)kvm_null_fn,
@@ -659,7 +666,6 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 	const struct kvm_hva_range range = {
 		.start		= start,
 		.end		= end,
-		.pte		= __pte(0),
 		.handler	= handler,
 		.on_lock	= (void *)kvm_null_fn,
 		.on_unlock	= (void *)kvm_null_fn,
@@ -747,7 +753,6 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	const struct kvm_hva_range hva_range = {
 		.start		= range->start,
 		.end		= range->end,
-		.pte		= __pte(0),
 		.handler	= kvm_unmap_gfn_range,
 		.on_lock	= kvm_mmu_invalidate_begin,
 		.on_unlock	= kvm_arch_guest_memory_reclaimed,
@@ -812,7 +817,6 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	const struct kvm_hva_range hva_range = {
 		.start		= range->start,
 		.end		= range->end,
-		.pte		= __pte(0),
 		.handler	= (void *)kvm_null_fn,
 		.on_lock	= kvm_mmu_invalidate_end,
 		.on_unlock	= (void *)kvm_null_fn,
-- 
2.41.0.255.g8b1d071c50-goog

