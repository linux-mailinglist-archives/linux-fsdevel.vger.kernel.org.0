Return-Path: <linux-fsdevel+bounces-1583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC397DC12A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D90B20EFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17D21CFA1;
	Mon, 30 Oct 2023 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZxGx5Jf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAE1CF84
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:25:55 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C7F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:25:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5a16fa94so4235319276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698697552; x=1699302352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLe0geP8e2FVj4qDFmgiKe4HSQmMDr9vIKCdz5IJ0b8=;
        b=gZxGx5Jf4pESioEERVkpiRgRf6GIeIS6jl+d8Yr7s6uQ9ZaHbHepyro/oMUFFdM4PR
         BMawDbqaBfuJJZwkImn17Yrle2OYXjuDC3hlpP8Nxe4eJvpM0VUDwJSE/SogMF+NSvLi
         gWZvE+pQnWh3F92G0skb5kQstwvro6UAGWFUqj7MoUxN2thrR6FKWG8NJEJyiSUAbBNN
         22xpYyZ6+nFhjKYuGZK5PTrQfZ0Y9UsqzeVr3BtYcntUFnfWc7GYXKwABNZlq0byz7cX
         uhkL28M6aJNIYED3UANCEqD6E16opDZksaIBtp89bM6rn7XZU3RHsfkKvjrL81sq8kpv
         nFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697552; x=1699302352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLe0geP8e2FVj4qDFmgiKe4HSQmMDr9vIKCdz5IJ0b8=;
        b=CTnNYPJJT2vva3eLgoBbaQSQtETZlYzKHh8be+hFf6ZTxCj1R5udvNhThtzm0L74Vm
         cnCSgcL9/uV/IOzxbsVTtjbwVHuDTrU1sdRzbLpCLt8tWLeKY4flMI4a9peBWQeLiq+8
         T+LT06/Rg/c6bWAjAspvEXVH9Bvjy8SnQkSzAhrmT2KHIE2ZlwvnLKFoH7c83sCUslPW
         6M0Zr0iGRu0qeOJpkctTGV0wqdyaNl0pcRGyDbqRlX4MWAI1Y9d+kfyDDe8ghaMn5fpO
         uqk2eQ9OLm3YU5775bZ31DX5bsEyz5vF0wMM4ONeth02l0piV5rrRhCJvjBDn/9+BANc
         ODgg==
X-Gm-Message-State: AOJu0YwSXGTxO7iz2ZenjHDWlhMfQg7shQtdpqIYuLgHx4Y06V3N78lb
	InVXKZoJinX7rUk2m4WAu14hZCJn97w=
X-Google-Smtp-Source: AGHT+IGlGqmQkLdJGZ9mJzjtHQ/qef61ty+xku12xbQ7aSZ0jjD/v7MM7HUcLrxp67U3zyWvPrrdlUHrpDU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:84cc:0:b0:d89:42d7:e72d with SMTP id
 x12-20020a2584cc000000b00d8942d7e72dmr15389ybm.3.1698697552520; Mon, 30 Oct
 2023 13:25:52 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:25:50 -0700
In-Reply-To: <211d093f-4023-4a39-a23f-6d8543512675@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-9-seanjc@google.com>
 <211d093f-4023-4a39-a23f-6d8543512675@redhat.com>
Message-ID: <ZUARTvhpChFSGF9s@google.com>
Subject: Re: [PATCH v13 08/35] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Xu Yilun <yilun.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Anish Moorthy <amoorthy@google.com>, David Matlack <dmatlack@google.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 30, 2023, Paolo Bonzini wrote:
> On 10/27/23 20:21, Sean Christopherson wrote:
> > 
> > +		if (ioctl == KVM_SET_USER_MEMORY_REGION)
> > +			size = sizeof(struct kvm_userspace_memory_region);
> 
> This also needs a memset(&mem, 0, sizeof(mem)), otherwise the out-of-bounds
> access of the commit message becomes a kernel stack read.

Ouch.  There's some irony.  Might be worth doing memset(&mem, -1, sizeof(mem))
though as '0' is a valid file descriptor and a valid file offset.

> Probably worth adding a check on valid flags here.

Definitely needed.  There's a very real bug here.  But rather than duplicate flags
checking or plumb @ioctl all the way to __kvm_set_memory_region(), now that we
have the fancy guard(mutex) and there are no internal calls to kvm_set_memory_region(),
what if we:

  1. Acquire/release slots_lock in __kvm_set_memory_region()
  2. Call kvm_set_memory_region() from x86 code for the internal memslots
  3. Disallow *any* flags for internal memslots
  4. Open code check_memory_region_flags in kvm_vm_ioctl_set_memory_region()
  5. Pass @ioctl to kvm_vm_ioctl_set_memory_region() and allow KVM_MEM_PRIVATE
     only for KVM_SET_USER_MEMORY_REGION2

E.g. this over ~5 patches

---
 arch/x86/kvm/x86.c       |  2 +-
 include/linux/kvm_host.h |  4 +--
 virt/kvm/kvm_main.c      | 65 +++++++++++++++++-----------------------
 3 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e3eb608b6692..dd3e2017366c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12478,7 +12478,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		m.guest_phys_addr = gpa;
 		m.userspace_addr = hva;
 		m.memory_size = size;
-		r = __kvm_set_memory_region(kvm, &m);
+		r = kvm_set_memory_region(kvm, &m);
 		if (r < 0)
 			return ERR_PTR_USR(r);
 	}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 687589ce9f63..fbb98efe8200 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1170,7 +1170,7 @@ static inline bool kvm_memslot_iter_is_valid(struct kvm_memslot_iter *iter, gfn_
  *   -- just change its flags
  *
  * Since flags can be changed by some of these operations, the following
- * differentiation is the best we can do for __kvm_set_memory_region():
+ * differentiation is the best we can do for __kvm_set_memory_region().
  */
 enum kvm_mr_change {
 	KVM_MR_CREATE,
@@ -1181,8 +1181,6 @@ enum kvm_mr_change {
 
 int kvm_set_memory_region(struct kvm *kvm,
 			  const struct kvm_userspace_memory_region2 *mem);
-int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region2 *mem);
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 23633984142f..39ceee2f67f2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1608,28 +1608,6 @@ static void kvm_replace_memslot(struct kvm *kvm,
 	}
 }
 
-static int check_memory_region_flags(struct kvm *kvm,
-				     const struct kvm_userspace_memory_region2 *mem)
-{
-	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
-
-	if (kvm_arch_has_private_mem(kvm))
-		valid_flags |= KVM_MEM_PRIVATE;
-
-	/* Dirty logging private memory is not currently supported. */
-	if (mem->flags & KVM_MEM_PRIVATE)
-		valid_flags &= ~KVM_MEM_LOG_DIRTY_PAGES;
-
-#ifdef __KVM_HAVE_READONLY_MEM
-	valid_flags |= KVM_MEM_READONLY;
-#endif
-
-	if (mem->flags & ~valid_flags)
-		return -EINVAL;
-
-	return 0;
-}
-
 static void kvm_swap_active_memslots(struct kvm *kvm, int as_id)
 {
 	struct kvm_memslots *slots = kvm_get_inactive_memslots(kvm, as_id);
@@ -2014,11 +1992,9 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
  * space.
  *
  * Discontiguous memory is allowed, mostly for framebuffers.
- *
- * Must be called holding kvm->slots_lock for write.
  */
-int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region2 *mem)
+static int __kvm_set_memory_region(struct kvm *kvm,
+				   const struct kvm_userspace_memory_region2 *mem)
 {
 	struct kvm_memory_slot *old, *new;
 	struct kvm_memslots *slots;
@@ -2028,9 +2004,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	int as_id, id;
 	int r;
 
-	r = check_memory_region_flags(kvm, mem);
-	if (r)
-		return r;
+	guard(mutex)(&kvm->slots_lock);
 
 	as_id = mem->slot >> 16;
 	id = (u16)mem->slot;
@@ -2139,27 +2113,42 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	kfree(new);
 	return r;
 }
-EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
 
 int kvm_set_memory_region(struct kvm *kvm,
 			  const struct kvm_userspace_memory_region2 *mem)
 {
-	int r;
+	/* Flags aren't supported for KVM-internal memslots. */
+	if (WARN_ON_ONCE(mem->flags))
+		return -EINVAL;
 
-	mutex_lock(&kvm->slots_lock);
-	r = __kvm_set_memory_region(kvm, mem);
-	mutex_unlock(&kvm->slots_lock);
-	return r;
+	return __kvm_set_memory_region(kvm, mem);
 }
 EXPORT_SYMBOL_GPL(kvm_set_memory_region);
 
-static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
+static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm, unsigned int ioctl,
 					  struct kvm_userspace_memory_region2 *mem)
 {
+	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
+
+	if (ioctl == KVM_SET_USER_MEMORY_REGION2 &&
+	    kvm_arch_has_private_mem(kvm))
+		valid_flags |= KVM_MEM_PRIVATE;
+
+	/* Dirty logging private memory is not currently supported. */
+	if (mem->flags & KVM_MEM_PRIVATE)
+		valid_flags &= ~KVM_MEM_LOG_DIRTY_PAGES;
+
+#ifdef __KVM_HAVE_READONLY_MEM
+	valid_flags |= KVM_MEM_READONLY;
+#endif
+
+	if (mem->flags & ~valid_flags)
+		return -EINVAL;
+
 	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
-	return kvm_set_memory_region(kvm, mem);
+	return __kvm_set_memory_region(kvm, mem);
 }
 
 #ifndef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
@@ -5145,7 +5134,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		if (copy_from_user(&mem, argp, size))
 			goto out;
 
-		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
+		r = kvm_vm_ioctl_set_memory_region(kvm, ioctl, &mem);
 		break;
 	}
 	case KVM_GET_DIRTY_LOG: {

base-commit: 881375a408c0f4ea451ff14545b59216d2923881
-- 


