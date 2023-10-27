Return-Path: <linux-fsdevel+bounces-1420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9857D9FE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06BF1C210D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832BD3DFEC;
	Fri, 27 Oct 2023 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0HIV6Cy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC413DFE1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:22:44 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8139DD5F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:40 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc1682607eso13649215ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698430959; x=1699035759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+AXFJbz5WZr/NYjDBv52nUkuFXaO3S1StF6qZQtTbwQ=;
        b=p0HIV6Cy9yzhL0TnlO6gL6MVTSd0DcelrvEAuO1pZjP74jjDxfjjEzuptTaP7gDaFZ
         b87gBdt1YgS08Dfx/aTRwwOIXoVQx//7UMQNCgaXR6XS3hN7B702jzqLMFxWuq1Bntzg
         thBnhA0W7gN2hygj8ZtBepNk603ATYKKmoJu+8N15GV+I7ejq/kBwsse2lWm9vH3y+R1
         /lfxVBbsSJZZheZ20rlXE26HDaAz928IxvKnAzrJ4hAxfoeTQ6vLOxUW4A3lEdi8P8o2
         hMjTktouJ8IzTRBMLNY5OXa7l/wdqY/EBM79WxPkdmk9FXhCAd0CgiomGFPMy4dTmJ4e
         xRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698430959; x=1699035759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AXFJbz5WZr/NYjDBv52nUkuFXaO3S1StF6qZQtTbwQ=;
        b=UE4rRB18pP457aGPHgfncxhv1DrjS4JjX9RT3oRX2YnGxCAuwwcUIknvlamdpWnICS
         5ZpwUED3ayTH+CDR487JUjoa7KbUXjrPIPOqi00Ml408YPIW6fbvlih/c83jjxFUb9BK
         eIbf2ovLW1WffKlVqXXhaeN/D/GYgKK80NxFX55+Fourq+pKAsOjA+Pnjn2Q58PwhaKK
         fzFhlxahzfwLBrAhK04wbLZBOyJbaaDHGv5dw6DNWu/NvOoVb3dhyAfW4ZBm+p3BG7ir
         QHxHYQhrnsFp9xhoziGouBM5GsnUWNWybwK36eW6gz6pO9HzhfyPJIHIzN0RxT0zUW1g
         LLNA==
X-Gm-Message-State: AOJu0YwrPI2So4WoJvsunY5hcZFRKR3cNN9iE7kcI974XPHzVjM+gqmL
	rfLx1R6nzMnDjAToVY0x2evMej9y2XY=
X-Google-Smtp-Source: AGHT+IEo9repSBGZOxXVda3T/byTyJ1q5UTkkyqwmlpHdlfrn0lBxj3W/oLyvthWFNznN6u5r+uymjEP5Uc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c255:b0:1c3:29c4:c4e8 with SMTP id
 21-20020a170902c25500b001c329c4c4e8mr57345plg.4.1698430959411; Fri, 27 Oct
 2023 11:22:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 27 Oct 2023 11:21:49 -0700
In-Reply-To: <20231027182217.3615211-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027182217.3615211-8-seanjc@google.com>
Subject: [PATCH v13 07/35] KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to CONFIG_KVM_GENERIC_MMU_NOTIFIER
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sean Christopherson <seanjc@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>, 
	David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Convert KVM_ARCH_WANT_MMU_NOTIFIER into a Kconfig and select it where
appropriate to effectively maintain existing behavior.  Using a proper
Kconfig will simplify building more functionality on top of KVM's
mmu_notifier infrastructure.

Add a forward declaration of kvm_gfn_range to kvm_types.h so that
including arch/powerpc/include/asm/kvm_ppc.h's with CONFIG_KVM=n doesn't
generate warnings due to kvm_gfn_range being undeclared.  PPC defines
hooks for PR vs. HV without guarding them via #ifdeffery, e.g.

  bool (*unmap_gfn_range)(struct kvm *kvm, struct kvm_gfn_range *range);
  bool (*age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
  bool (*test_age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
  bool (*set_spte_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);

Alternatively, PPC could forward declare kvm_gfn_range, but there's no
good reason not to define it in common KVM.

Acked-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h   |  2 --
 arch/arm64/kvm/Kconfig              |  2 +-
 arch/mips/include/asm/kvm_host.h    |  2 --
 arch/mips/kvm/Kconfig               |  2 +-
 arch/powerpc/include/asm/kvm_host.h |  2 --
 arch/powerpc/kvm/Kconfig            |  8 ++++----
 arch/powerpc/kvm/powerpc.c          |  4 +---
 arch/riscv/include/asm/kvm_host.h   |  2 --
 arch/riscv/kvm/Kconfig              |  2 +-
 arch/x86/include/asm/kvm_host.h     |  2 --
 arch/x86/kvm/Kconfig                |  2 +-
 include/linux/kvm_host.h            |  6 +++---
 include/linux/kvm_types.h           |  1 +
 virt/kvm/Kconfig                    |  4 ++++
 virt/kvm/kvm_main.c                 | 10 +++++-----
 15 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index af06ccb7ee34..9e046b64847a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -921,8 +921,6 @@ int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events);
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 83c1e09be42e..1a777715199f 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -22,7 +22,7 @@ menuconfig KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 54a85f1d4f2c..179f320cc231 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -810,8 +810,6 @@ int kvm_mips_mkclean_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn);
 pgd_t *kvm_pgd_alloc(void);
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 /* Emulation */
 enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
 int kvm_get_badinstr(u32 *opc, struct kvm_vcpu *vcpu, u32 *out);
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index a8cdba75f98d..c04987d2ed2e 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -25,7 +25,7 @@ config KVM
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select KVM_MMIO
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select INTERVAL_TREE
 	select KVM_GENERIC_HARDWARE_ENABLING
 	help
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 14ee0dece853..4b5c3f2acf78 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -62,8 +62,6 @@
 
 #include <linux/mmu_notifier.h>
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 #define HPTEG_CACHE_NUM			(1 << 15)
 #define HPTEG_HASH_BITS_PTE		13
 #define HPTEG_HASH_BITS_PTE_LONG	12
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 902611954200..b33358ee6424 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -42,7 +42,7 @@ config KVM_BOOK3S_64_HANDLER
 config KVM_BOOK3S_PR_POSSIBLE
 	bool
 	select KVM_MMIO
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 
 config KVM_BOOK3S_HV_POSSIBLE
 	bool
@@ -85,7 +85,7 @@ config KVM_BOOK3S_64_HV
 	tristate "KVM for POWER7 and later using hypervisor mode in host"
 	depends on KVM_BOOK3S_64 && PPC_POWERNV
 	select KVM_BOOK3S_HV_POSSIBLE
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select CMA
 	help
 	  Support running unmodified book3s_64 guest kernels in
@@ -194,7 +194,7 @@ config KVM_E500V2
 	depends on !CONTEXT_TRACKING_USER
 	select KVM
 	select KVM_MMIO
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	help
 	  Support running unmodified E500 guest kernels in virtual machines on
 	  E500v2 host processors.
@@ -211,7 +211,7 @@ config KVM_E500MC
 	select KVM
 	select KVM_MMIO
 	select KVM_BOOKE_HV
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	help
 	  Support running unmodified E500MC/E5500/E6500 guest kernels in
 	  virtual machines on E500MC/E5500/E6500 host processors.
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 8d3ec483bc2b..aac75c98a956 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -632,9 +632,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 #endif
 	case KVM_CAP_SYNC_MMU:
-#if !defined(CONFIG_MMU_NOTIFIER) || !defined(KVM_ARCH_WANT_MMU_NOTIFIER)
-		BUILD_BUG();
-#endif
+		BUILD_BUG_ON(!IS_ENABLED(CONFIG_KVM_GENERIC_MMU_NOTIFIER));
 		r = 1;
 		break;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 1ebf20dfbaa6..66ee9ff483e9 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -249,8 +249,6 @@ struct kvm_vcpu_arch {
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 #define KVM_RISCV_GSTAGE_TLB_MIN_ORDER		12
 
 void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index dfc237d7875b..ae2e05f050ec 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -30,7 +30,7 @@ config KVM
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
 	select KVM_XFER_TO_GUEST_WORK
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	help
 	  Support hosting virtualized guest machines.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 70d139406bc8..31e84668014e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2129,8 +2129,6 @@ enum {
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
 #endif
 
-#define KVM_ARCH_WANT_MMU_NOTIFIER
-
 int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int kvm_cpu_has_extint(struct kvm_vcpu *v);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index ed90f148140d..091b74599c22 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -24,7 +24,7 @@ config KVM
 	depends on HIGH_RES_TIMERS
 	depends on X86_LOCAL_APIC
 	select PREEMPT_NOTIFIERS
-	select MMU_NOTIFIER
+	select KVM_GENERIC_MMU_NOTIFIER
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_PFNCACHE
 	select HAVE_KVM_IRQFD
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 11d091688346..5faba69403ac 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -253,7 +253,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
-#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 union kvm_mmu_notifier_arg {
 	pte_t pte;
 };
@@ -783,7 +783,7 @@ struct kvm {
 	struct hlist_head irq_ack_notifier_list;
 #endif
 
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 	struct mmu_notifier mmu_notifier;
 	unsigned long mmu_invalidate_seq;
 	long mmu_invalidate_in_progress;
@@ -1946,7 +1946,7 @@ extern const struct _kvm_stats_desc kvm_vm_stats_desc[];
 extern const struct kvm_stats_header kvm_vcpu_stats_header;
 extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
 
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 {
 	if (unlikely(kvm->mmu_invalidate_in_progress))
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 6f4737d5046a..9d1f7835d8c1 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -6,6 +6,7 @@
 struct kvm;
 struct kvm_async_pf;
 struct kvm_device_ops;
+struct kvm_gfn_range;
 struct kvm_interrupt;
 struct kvm_irq_routing_table;
 struct kvm_memory_slot;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 484d0873061c..ecae2914c97e 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -92,3 +92,7 @@ config HAVE_KVM_PM_NOTIFIER
 
 config KVM_GENERIC_HARDWARE_ENABLING
        bool
+
+config KVM_GENERIC_MMU_NOTIFIER
+       select MMU_NOTIFIER
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4dba682586ee..6e708017064d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -535,7 +535,7 @@ void kvm_destroy_vcpus(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_destroy_vcpus);
 
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
 {
 	return container_of(mn, struct kvm, mmu_notifier);
@@ -960,14 +960,14 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 	return mmu_notifier_register(&kvm->mmu_notifier, current->mm);
 }
 
-#else  /* !(CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER) */
+#else  /* !CONFIG_KVM_GENERIC_MMU_NOTIFIER */
 
 static int kvm_init_mmu_notifier(struct kvm *kvm)
 {
 	return 0;
 }
 
-#endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
+#endif /* CONFIG_KVM_GENERIC_MMU_NOTIFIER */
 
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 static int kvm_pm_notifier_call(struct notifier_block *bl,
@@ -1287,7 +1287,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 out_err_no_debugfs:
 	kvm_coalesced_mmio_free(kvm);
 out_no_coalesced_mmio:
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 	if (kvm->mmu_notifier.ops)
 		mmu_notifier_unregister(&kvm->mmu_notifier, current->mm);
 #endif
@@ -1347,7 +1347,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm->buses[i] = NULL;
 	}
 	kvm_coalesced_mmio_free(kvm);
-#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 	mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
 	/*
 	 * At this point, pending calls to invalidate_range_start()
-- 
2.42.0.820.g83a721a137-goog


