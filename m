Return-Path: <linux-fsdevel+bounces-1426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204EF7D9FF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E461C20F29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC23DFF3;
	Fri, 27 Oct 2023 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0E0PO3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50793DFE0
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:23:10 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0892D4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cc433782so21063467b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698430971; x=1699035771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHuKmbJK++WVHRTr2ixGhZnz3PjglwNcwDhJuJ6xsm0=;
        b=b0E0PO3V6BbDEv0XqXAr9Nx6Vh+PG1z4MkGIHSZW6J6T1WaaOii00m3xouAvDJtmA9
         TRY3h5Pr1OhuWuBYbdZS0J66YeIpzI+qmTOvTABP7xeXdqmevOCzPXeYk73vong/WN99
         kVmdelDJtsyAg+Uzia5GND9GAxUuXnwO+I4n9ogL5tiRBizZ2BDxFUy73Pze5SVX6vU3
         WhvZfYIMiR3xbNMU5nyZWETcPBKZ5DEyy/NhZyEBQvvjxCiBWs6R73VRupQOHMd4qR5u
         KmT4bu4EQHkz74Ym0wBPTsCL/TCszw5tFTLpdWiyPda4nmF0sZkGiHaf5o0gAuHrK5xa
         iytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698430971; x=1699035771;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PHuKmbJK++WVHRTr2ixGhZnz3PjglwNcwDhJuJ6xsm0=;
        b=EoXF3tEMFVI6KfDEOXvrGJEVuX7TLZJRXlYLgcmh51U0VQvrlBXLhl9uLA8yxTgZ2Z
         3gQsacmmKFMv83eD2vVLrdc7YIkLaUeNkPGORS0I6RrLCs06qLHtLkPplg4Ng3x/pyDM
         SSNaxM0owGt28/NHj06q0MiI0NnjlYYW6ftzMR7nm1/zajXOPEinM09VPcKIX9T5AdLQ
         yxTPDqHNQ47sjvdrxBbcDrXMk2MtiquezS8Xiacoo6W1tPvOSAnilXRMNq2UCmEIuirt
         2AinQOvUwhtuLFbrhIOi3sVb93AqNCv0Awg74HBLU6Zol6aDbOdcO1Ai3dqTidm1KLQo
         GVcw==
X-Gm-Message-State: AOJu0YwHVVgJkCNCQreoK5zWvqH5xYGnDGluMaQ77eVYevnsRUzD3pS0
	vbgRzuOakZ3332uBMDmDHon9M6R5Et8=
X-Google-Smtp-Source: AGHT+IHeAi8c5J1JHmkq3P4PpsdNdjX6Wq3XK5NOfAhf9NwJS3eapFdTXpLG2igv2I31VgMM7Gn14gWqO18=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ca97:0:b0:5a1:d4a5:7dff with SMTP id
 m145-20020a0dca97000000b005a1d4a57dffmr73743ywd.6.1698430971510; Fri, 27 Oct
 2023 11:22:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 27 Oct 2023 11:21:55 -0700
In-Reply-To: <20231027182217.3615211-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027182217.3615211-14-seanjc@google.com>
Subject: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
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
Content-Transfer-Encoding: quoted-printable

From: Chao Peng <chao.p.peng@linux.intel.com>

In confidential computing usages, whether a page is private or shared is
necessary information for KVM to perform operations like page fault
handling, page zapping etc. There are other potential use cases for
per-page memory attributes, e.g. to make memory read-only (or no-exec,
or exec-only, etc.) without having to modify memslots.

Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
userspace to operate on the per-page memory attributes.
  - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
    a guest memory range.
  - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
    memory attributes.

Use an xarray to store the per-page attributes internally, with a naive,
not fully optimized implementation, i.e. prioritize correctness over
performance for the initial implementation.

Use bit 3 for the PRIVATE attribute so that KVM can use bits 0-2 for RWX
attributes/protections in the future, e.g. to give userspace fine-grained
control over read, write, and execute protections for guest memory.

Provide arch hooks for handling attribute changes before and after common
code sets the new attributes, e.g. x86 will use the "pre" hook to zap all
relevant mappings, and the "post" hook to track whether or not hugepages
can be used to map the range.

To simplify the implementation wrap the entire sequence with
kvm_mmu_invalidate_{begin,end}() even though the operation isn't strictly
guaranteed to be an invalidation.  For the initial use case, x86 *will*
always invalidate memory, and preventing arch code from creating new
mappings while the attributes are in flux makes it much easier to reason
about the correctness of consuming attributes.

It's possible that future usages may not require an invalidation, e.g.
if KVM ends up supporting RWX protections and userspace grants _more_
protections, but again opt for simplicity and punt optimizations to
if/when they are needed.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com
Cc: Fuad Tabba <tabba@google.com>
Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst |  36 +++++
 include/linux/kvm_host.h       |  18 +++
 include/uapi/linux/kvm.h       |  13 ++
 virt/kvm/Kconfig               |   4 +
 virt/kvm/kvm_main.c            | 233 +++++++++++++++++++++++++++++++++
 5 files changed, 304 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t
index 860216536810..e2252c748fd6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6091,6 +6091,42 @@ applied.
=20
 See KVM_SET_USER_MEMORY_REGION.
=20
+4.140 KVM_SET_MEMORY_ATTRIBUTES
+-------------------------------
+
+:Capability: KVM_CAP_MEMORY_ATTRIBUTES
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_memory_attributes(in)
+:Returns: 0 on success, <0 on error
+
+KVM_SET_MEMORY_ATTRIBUTES allows userspace to set memory attributes for a =
range
+of guest physical memory.
+
+::
+
+  struct kvm_memory_attributes {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+  };
+
+  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+
+The address and size must be page aligned.  The supported attributes can b=
e
+retrieved via ioctl(KVM_CHECK_EXTENSION) on KVM_CAP_MEMORY_ATTRIBUTES.  If
+executed on a VM, KVM_CAP_MEMORY_ATTRIBUTES precisely returns the attribut=
es
+supported by that VM.  If executed at system scope, KVM_CAP_MEMORY_ATTRIBU=
TES
+returns all attributes supported by KVM.  The only attribute defined at th=
is
+time is KVM_MEMORY_ATTRIBUTE_PRIVATE, which marks the associated gfn as be=
ing
+guest private memory.
+
+Note, there is no "get" API.  Userspace is responsible for explicitly trac=
king
+the state of a gfn/page as needed.
+
+The "flags" field is reserved for future extensions and must be '0'.
+
 5. The kvm_run structure
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 89c1a991a3b8..df573229651b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -256,6 +256,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 union kvm_mmu_notifier_arg {
 	pte_t pte;
+	unsigned long attributes;
 };
=20
 struct kvm_gfn_range {
@@ -808,6 +809,9 @@ struct kvm {
=20
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 	struct notifier_block pm_notifier;
+#endif
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	struct xarray mem_attr_array;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
@@ -2340,4 +2344,18 @@ static inline void kvm_prepare_memory_fault_exit(str=
uct kvm_vcpu *vcpu,
 	vcpu->run->memory_fault.flags =3D 0;
 }
=20
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn=
_t gfn)
+{
+	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+}
+
+bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t e=
nd,
+				     unsigned long attrs);
+bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
+					struct kvm_gfn_range *range);
+bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
+					 struct kvm_gfn_range *range);
+#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 7ae9987b48dd..547837feaa28 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1211,6 +1211,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 #define KVM_CAP_USER_MEMORY2 230
 #define KVM_CAP_MEMORY_FAULT_INFO 231
+#define KVM_CAP_MEMORY_ATTRIBUTES 232
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -2277,4 +2278,16 @@ struct kvm_s390_zpci_op {
 /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
 #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
=20
+/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
+#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd2, struct k=
vm_memory_attributes)
+
+struct kvm_memory_attributes {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+};
+
+#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index ecae2914c97e..5bd7fcaf9089 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -96,3 +96,7 @@ config KVM_GENERIC_HARDWARE_ENABLING
 config KVM_GENERIC_MMU_NOTIFIER
        select MMU_NOTIFIER
        bool
+
+config KVM_GENERIC_MEMORY_ATTRIBUTES
+       select KVM_GENERIC_MMU_NOTIFIER
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 302ccb87b4c1..78a0b09ef2a5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1218,6 +1218,9 @@ static struct kvm *kvm_create_vm(unsigned long type, =
const char *fdname)
 	spin_lock_init(&kvm->mn_invalidate_lock);
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	xa_init(&kvm->mem_attr_array);
+#endif
=20
 	INIT_LIST_HEAD(&kvm->gpc_list);
 	spin_lock_init(&kvm->gpc_lock);
@@ -1398,6 +1401,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	}
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	cleanup_srcu_struct(&kvm->srcu);
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	xa_destroy(&kvm->mem_attr_array);
+#endif
 	kvm_arch_free_vm(kvm);
 	preempt_notifier_dec();
 	hardware_disable_all();
@@ -2396,6 +2402,210 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm =
*kvm,
 }
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
=20
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+/*
+ * Returns true if _all_ gfns in the range [@start, @end) have attributes
+ * matching @attrs.
+ */
+bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t e=
nd,
+				     unsigned long attrs)
+{
+	XA_STATE(xas, &kvm->mem_attr_array, start);
+	unsigned long index;
+	bool has_attrs;
+	void *entry;
+
+	rcu_read_lock();
+
+	if (!attrs) {
+		has_attrs =3D !xas_find(&xas, end - 1);
+		goto out;
+	}
+
+	has_attrs =3D true;
+	for (index =3D start; index < end; index++) {
+		do {
+			entry =3D xas_next(&xas);
+		} while (xas_retry(&xas, entry));
+
+		if (xas.xa_index !=3D index || xa_to_value(entry) !=3D attrs) {
+			has_attrs =3D false;
+			break;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+	return has_attrs;
+}
+
+static u64 kvm_supported_mem_attributes(struct kvm *kvm)
+{
+	if (!kvm)
+		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+	return 0;
+}
+
+static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
+						 struct kvm_mmu_notifier_range *range)
+{
+	struct kvm_gfn_range gfn_range;
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	struct kvm_memslot_iter iter;
+	bool found_memslot =3D false;
+	bool ret =3D false;
+	int i;
+
+	gfn_range.arg =3D range->arg;
+	gfn_range.may_block =3D range->may_block;
+
+	/*
+	 * If/when KVM supports more attributes beyond private .vs shared, this
+	 * _could_ set only_{private,shared} appropriately if the entire target
+	 * range already has the desired private vs. shared state (it's unclear
+	 * if that is a net win).  For now, KVM reaches this point if and only
+	 * if the private flag is being toggled, i.e. all mappings are in play.
+	 */
+	gfn_range.only_private =3D false;
+	gfn_range.only_shared =3D false;
+
+	for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+		slots =3D __kvm_memslots(kvm, i);
+
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, range->start, range->end=
) {
+			slot =3D iter.slot;
+			gfn_range.slot =3D slot;
+
+			gfn_range.start =3D max(range->start, slot->base_gfn);
+			gfn_range.end =3D min(range->end, slot->base_gfn + slot->npages);
+			if (gfn_range.start >=3D gfn_range.end)
+				continue;
+
+			if (!found_memslot) {
+				found_memslot =3D true;
+				KVM_MMU_LOCK(kvm);
+				if (!IS_KVM_NULL_FN(range->on_lock))
+					range->on_lock(kvm);
+			}
+
+			ret |=3D range->handler(kvm, &gfn_range);
+		}
+	}
+
+	if (range->flush_on_ret && ret)
+		kvm_flush_remote_tlbs(kvm);
+
+	if (found_memslot)
+		KVM_MMU_UNLOCK(kvm);
+}
+
+static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
+					  struct kvm_gfn_range *range)
+{
+	/*
+	 * Unconditionally add the range to the invalidation set, regardless of
+	 * whether or not the arch callback actually needs to zap SPTEs.  E.g.
+	 * if KVM supports RWX attributes in the future and the attributes are
+	 * going from R=3D>RW, zapping isn't strictly necessary.  Unconditionally
+	 * adding the range allows KVM to require that MMU invalidations add at
+	 * least one range between begin() and end(), e.g. allows KVM to detect
+	 * bugs where the add() is missed.  Rexlaing the rule *might* be safe,
+	 * but it's not obvious that allowing new mappings while the attributes
+	 * are in flux is desirable or worth the complexity.
+	 */
+	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
+
+	return kvm_arch_pre_set_memory_attributes(kvm, range);
+}
+
+/* Set @attributes for the gfn range [@start, @end). */
+static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t e=
nd,
+				     unsigned long attributes)
+{
+	struct kvm_mmu_notifier_range pre_set_range =3D {
+		.start =3D start,
+		.end =3D end,
+		.handler =3D kvm_pre_set_memory_attributes,
+		.on_lock =3D kvm_mmu_invalidate_begin,
+		.flush_on_ret =3D true,
+		.may_block =3D true,
+	};
+	struct kvm_mmu_notifier_range post_set_range =3D {
+		.start =3D start,
+		.end =3D end,
+		.arg.attributes =3D attributes,
+		.handler =3D kvm_arch_post_set_memory_attributes,
+		.on_lock =3D kvm_mmu_invalidate_end,
+		.may_block =3D true,
+	};
+	unsigned long i;
+	void *entry;
+	int r =3D 0;
+
+	entry =3D attributes ? xa_mk_value(attributes) : NULL;
+
+	mutex_lock(&kvm->slots_lock);
+
+	/* Nothing to do if the entire range as the desired attributes. */
+	if (kvm_range_has_memory_attributes(kvm, start, end, attributes))
+		goto out_unlock;
+
+	/*
+	 * Reserve memory ahead of time to avoid having to deal with failures
+	 * partway through setting the new attributes.
+	 */
+	for (i =3D start; i < end; i++) {
+		r =3D xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
+		if (r)
+			goto out_unlock;
+	}
+
+	kvm_handle_gfn_range(kvm, &pre_set_range);
+
+	for (i =3D start; i < end; i++) {
+		r =3D xa_err(xa_store(&kvm->mem_attr_array, i, entry,
+				    GFP_KERNEL_ACCOUNT));
+		KVM_BUG_ON(r, kvm);
+	}
+
+	kvm_handle_gfn_range(kvm, &post_set_range);
+
+out_unlock:
+	mutex_unlock(&kvm->slots_lock);
+
+	return r;
+}
+static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
+					   struct kvm_memory_attributes *attrs)
+{
+	gfn_t start, end;
+
+	/* flags is currently not used. */
+	if (attrs->flags)
+		return -EINVAL;
+	if (attrs->attributes & ~kvm_supported_mem_attributes(kvm))
+		return -EINVAL;
+	if (attrs->size =3D=3D 0 || attrs->address + attrs->size < attrs->address=
)
+		return -EINVAL;
+	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
+		return -EINVAL;
+
+	start =3D attrs->address >> PAGE_SHIFT;
+	end =3D (attrs->address + attrs->size) >> PAGE_SHIFT;
+
+	/*
+	 * xarray tracks data using "unsigned long", and as a result so does
+	 * KVM.  For simplicity, supports generic attributes only on 64-bit
+	 * architectures.
+	 */
+	BUILD_BUG_ON(sizeof(attrs->attributes) !=3D sizeof(unsigned long));
+
+	return kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
+}
+#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
+
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
 	return __gfn_to_memslot(kvm_memslots(kvm), gfn);
@@ -4640,6 +4850,17 @@ static int kvm_vm_ioctl_check_extension_generic(stru=
ct kvm *kvm, long arg)
 	case KVM_CAP_BINARY_STATS_FD:
 	case KVM_CAP_SYSTEM_EVENT_DATA:
 		return 1;
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	case KVM_CAP_MEMORY_ATTRIBUTES:
+		u64 attrs =3D kvm_supported_mem_attributes(kvm);
+
+		r =3D -EFAULT;
+		if (copy_to_user(argp, &attrs, sizeof(attrs)))
+			goto out;
+		r =3D 0;
+		break;
+	}
+#endif
 	default:
 		break;
 	}
@@ -5022,6 +5243,18 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	case KVM_SET_MEMORY_ATTRIBUTES: {
+		struct kvm_memory_attributes attrs;
+
+		r =3D -EFAULT;
+		if (copy_from_user(&attrs, argp, sizeof(attrs)))
+			goto out;
+
+		r =3D kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
+		break;
+	}
+#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 	case KVM_CREATE_DEVICE: {
 		struct kvm_create_device cd;
=20
--=20
2.42.0.820.g83a721a137-goog


