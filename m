Return-Path: <linux-fsdevel+bounces-1836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD97DF556
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260421C20E83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D6E1B27E;
	Thu,  2 Nov 2023 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbxKDP5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837013AD9
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:53:11 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA214138
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:53:08 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d12b3b479so5808196d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698936788; x=1699541588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GvzXOE6ewh/7Rc6C9DonV3a0Npx2I7bSl14yjDuvxo=;
        b=wbxKDP5Ci6ITuNqXJaZc/4v+hCB16rOOImLWZg8H8jfbX+IBe85Gd91QiZPJ0hnJ2J
         ikAVQZGqmh64TlpfaJdzfka9dRtP3Pbl4SG+FX7GgEp02ngMhfwly0nwGIWgwbek0hlO
         I0waYrtN/tQevOHtqJ3y2kLdgpDS/CM9OlSJx3aIz3J6ChXz9ZNSkDMIYZPV1jTjb45v
         d6MvH5/5K7PXnR/GndyxzbC9sK5NJkgJhnI1kmcR1YT6N6UPXjvvXuWo/aBt04PtPhOJ
         1z+XKpE6KANKbN/d3FFnmRF4/KMz36gSwbZ3AzLONCCCeGqie1+SlDdpI9QKf2fCuozL
         KuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936788; x=1699541588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GvzXOE6ewh/7Rc6C9DonV3a0Npx2I7bSl14yjDuvxo=;
        b=F08bO2skPKq6UMFrPcTUWzYlNqdnXE6wm5cXYauBAe5CeL5T4x7mUgxXx1NgqOSV1p
         nNB5SFCp+FDkjRyVvVFJLTGsQc+sdG1pufsfRKwY85y1zDcQ3hyfCV4sgjKq3CLm/jz1
         ihb2qaU2L0xnWlm6GPdsCtQ2qyjOIRQH4LLON8Zr9Ffh/06f0vBaDT0gOcOhQ0f8E1e9
         D45K543TzSxpcI4OoUNUJ38joYPmv3Pwxu7pwd2Cfe4wFSSL956mLmndeEaZz2r7MCeX
         79vnMPYOKSqLNLTvNkLgET53VrnracfkQ+BS+lrAXtJd2zvWULTnGMCgH3GrlZocn7gy
         83fw==
X-Gm-Message-State: AOJu0YyJuELaalxniJ74w3XlZDTssgpNz+GIbOGU6WiJn2pz99p9+VJ4
	3yZGxhHRMw8upA01O/pDMQERftKSFdpgcuM1CV6Vgg==
X-Google-Smtp-Source: AGHT+IHdXDohShBrh/wRwYkeI6kWxrlegOSTv+ByJkK1TLGURCqHB/VgK9oCYE42JR3/Ks/cAKuurxNdHClczp0acF8=
X-Received: by 2002:a05:6214:404:b0:66d:130c:bb9d with SMTP id
 z4-20020a056214040400b0066d130cbb9dmr25099306qvx.13.1698936787681; Thu, 02
 Nov 2023 07:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-23-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-23-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 2 Nov 2023 14:52:31 +0000
Message-ID: <CA+EHjTzjzN-0mc6ZUTmSH=EAzRvS4v5dDO97-dCGHb668dTb7Q@mail.gmail.com>
Subject: Re: [PATCH v13 22/35] KVM: Allow arch code to track number of memslot
 address spaces per VM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Xu Yilun <yilun.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>, 
	David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Maciej Szmigiero <mail@maciej.szmigiero.name>, 
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>, 
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 7:23=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Let x86 track the number of address spaces on a per-VM basis so that KVM
> can disallow SMM memslots for confidential VMs.  Confidentials VMs are
> fundamentally incompatible with emulating SMM, which as the name suggests
> requires being able to read and write guest memory and register state.
>
> Disallowing SMM will simplify support for guest private memory, as KVM
> will not need to worry about tracking memory attributes for multiple
> address spaces (SMM is the only "non-default" address space across all
> architectures).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/powerpc/kvm/book3s_hv.c    |  2 +-
>  arch/x86/include/asm/kvm_host.h |  8 +++++++-
>  arch/x86/kvm/debugfs.c          |  2 +-
>  arch/x86/kvm/mmu/mmu.c          |  6 +++---
>  arch/x86/kvm/x86.c              |  2 +-
>  include/linux/kvm_host.h        | 17 +++++++++++------
>  virt/kvm/dirty_ring.c           |  2 +-
>  virt/kvm/kvm_main.c             | 26 ++++++++++++++------------
>  8 files changed, 39 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 130bafdb1430..9b0eaa17275a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6084,7 +6084,7 @@ static int kvmhv_svm_off(struct kvm *kvm)
>         }
>
>         srcu_idx =3D srcu_read_lock(&kvm->srcu);
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 struct kvm_memory_slot *memslot;
>                 struct kvm_memslots *slots =3D __kvm_memslots(kvm, i);
>                 int bkt;
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 6702f795c862..f9e8d5642069 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2124,9 +2124,15 @@ enum {
>  #define HF_SMM_MASK            (1 << 1)
>  #define HF_SMM_INSIDE_NMI_MASK (1 << 2)
>
> -# define KVM_ADDRESS_SPACE_NUM 2
> +# define KVM_MAX_NR_ADDRESS_SPACES     2
>  # define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_M=
ASK ? 1 : 0)
>  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role=
).smm)
> +
> +static inline int kvm_arch_nr_memslot_as_ids(struct kvm *kvm)
> +{
> +       return KVM_MAX_NR_ADDRESS_SPACES;
> +}
> +
>  #else
>  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
>  #endif
> diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
> index ee8c4c3496ed..42026b3f3ff3 100644
> --- a/arch/x86/kvm/debugfs.c
> +++ b/arch/x86/kvm/debugfs.c
> @@ -111,7 +111,7 @@ static int kvm_mmu_rmaps_stat_show(struct seq_file *m=
, void *v)
>         mutex_lock(&kvm->slots_lock);
>         write_lock(&kvm->mmu_lock);
>
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 int bkt;
>
>                 slots =3D __kvm_memslots(kvm, i);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c4e758f0aebb..baeba8fc1c38 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3755,7 +3755,7 @@ static int mmu_first_shadow_root_alloc(struct kvm *=
kvm)
>             kvm_page_track_write_tracking_enabled(kvm))
>                 goto out_success;
>
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 slots =3D __kvm_memslots(kvm, i);
>                 kvm_for_each_memslot(slot, bkt, slots) {
>                         /*
> @@ -6294,7 +6294,7 @@ static bool kvm_rmap_zap_gfn_range(struct kvm *kvm,=
 gfn_t gfn_start, gfn_t gfn_e
>         if (!kvm_memslots_have_rmaps(kvm))
>                 return flush;
>
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 slots =3D __kvm_memslots(kvm, i);
>
>                 kvm_for_each_memslot_in_gfn_range(&iter, slots, gfn_start=
, gfn_end) {
> @@ -6791,7 +6791,7 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm,=
 u64 gen)
>          * modifier prior to checking for a wrap of the MMIO generation s=
o
>          * that a wrap in any address space is detected.
>          */
> -       gen &=3D ~((u64)KVM_ADDRESS_SPACE_NUM - 1);
> +       gen &=3D ~((u64)kvm_arch_nr_memslot_as_ids(kvm) - 1);
>
>         /*
>          * The very rare case: if the MMIO generation number has wrapped,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 824b58b44382..c4d17727b199 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12456,7 +12456,7 @@ void __user * __x86_set_memory_region(struct kvm =
*kvm, int id, gpa_t gpa,
>                 hva =3D slot->userspace_addr;
>         }
>
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 struct kvm_userspace_memory_region2 m;
>
>                 m.slot =3D id | (i << 16);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c3cfe08b1300..687589ce9f63 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -80,8 +80,8 @@
>  /* Two fragments for cross MMIO pages. */
>  #define KVM_MAX_MMIO_FRAGMENTS 2
>
> -#ifndef KVM_ADDRESS_SPACE_NUM
> -#define KVM_ADDRESS_SPACE_NUM  1
> +#ifndef KVM_MAX_NR_ADDRESS_SPACES
> +#define KVM_MAX_NR_ADDRESS_SPACES      1
>  #endif
>
>  /*
> @@ -692,7 +692,12 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm);
>  #define KVM_MEM_SLOTS_NUM SHRT_MAX
>  #define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_INTERNAL_MEM_SLOTS)
>
> -#if KVM_ADDRESS_SPACE_NUM =3D=3D 1
> +#if KVM_MAX_NR_ADDRESS_SPACES =3D=3D 1
> +static inline int kvm_arch_nr_memslot_as_ids(struct kvm *kvm)
> +{
> +       return KVM_MAX_NR_ADDRESS_SPACES;
> +}
> +
>  static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>  {
>         return 0;
> @@ -747,9 +752,9 @@ struct kvm {
>         struct mm_struct *mm; /* userspace tied to this vm */
>         unsigned long nr_memslot_pages;
>         /* The two memslot sets - active and inactive (per address space)=
 */
> -       struct kvm_memslots __memslots[KVM_ADDRESS_SPACE_NUM][2];
> +       struct kvm_memslots __memslots[KVM_MAX_NR_ADDRESS_SPACES][2];
>         /* The current active memslot set for each address space */
> -       struct kvm_memslots __rcu *memslots[KVM_ADDRESS_SPACE_NUM];
> +       struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
>         struct xarray vcpu_array;
>         /*
>          * Protected by slots_lock, but can be read outside if an
> @@ -1018,7 +1023,7 @@ void kvm_put_kvm_no_destroy(struct kvm *kvm);
>
>  static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int a=
s_id)
>  {
> -       as_id =3D array_index_nospec(as_id, KVM_ADDRESS_SPACE_NUM);
> +       as_id =3D array_index_nospec(as_id, KVM_MAX_NR_ADDRESS_SPACES);
>         return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
>                         lockdep_is_held(&kvm->slots_lock) ||
>                         !refcount_read(&kvm->users_count));
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index c1cd7dfe4a90..86d267db87bb 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -58,7 +58,7 @@ static void kvm_reset_dirty_gfn(struct kvm *kvm, u32 sl=
ot, u64 offset, u64 mask)
>         as_id =3D slot >> 16;
>         id =3D (u16)slot;
>
> -       if (as_id >=3D KVM_ADDRESS_SPACE_NUM || id >=3D KVM_USER_MEM_SLOT=
S)
> +       if (as_id >=3D kvm_arch_nr_memslot_as_ids(kvm) || id >=3D KVM_USE=
R_MEM_SLOTS)
>                 return;
>
>         memslot =3D id_to_memslot(__kvm_memslots(kvm, as_id), id);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5d1a2f1b4e94..23633984142f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -615,7 +615,7 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_=
range(struct kvm *kvm,
>
>         idx =3D srcu_read_lock(&kvm->srcu);
>
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 struct interval_tree_node *node;
>
>                 slots =3D __kvm_memslots(kvm, i);
> @@ -1248,7 +1248,7 @@ static struct kvm *kvm_create_vm(unsigned long type=
, const char *fdname)
>                 goto out_err_no_irq_srcu;
>
>         refcount_set(&kvm->users_count, 1);
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 for (j =3D 0; j < 2; j++) {
>                         slots =3D &kvm->__memslots[i][j];
>
> @@ -1398,7 +1398,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  #endif
>         kvm_arch_destroy_vm(kvm);
>         kvm_destroy_devices(kvm);
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>                 kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>         }
> @@ -1681,7 +1681,7 @@ static void kvm_swap_active_memslots(struct kvm *kv=
m, int as_id)
>          * space 0 will use generations 0, 2, 4, ... while address space =
1 will
>          * use generations 1, 3, 5, ...
>          */
> -       gen +=3D KVM_ADDRESS_SPACE_NUM;
> +       gen +=3D kvm_arch_nr_memslot_as_ids(kvm);
>
>         kvm_arch_memslots_updated(kvm, gen);
>
> @@ -2051,7 +2051,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>             (mem->guest_memfd_offset & (PAGE_SIZE - 1) ||
>              mem->guest_memfd_offset + mem->memory_size < mem->guest_memf=
d_offset))
>                 return -EINVAL;
> -       if (as_id >=3D KVM_ADDRESS_SPACE_NUM || id >=3D KVM_MEM_SLOTS_NUM=
)
> +       if (as_id >=3D kvm_arch_nr_memslot_as_ids(kvm) || id >=3D KVM_MEM=
_SLOTS_NUM)
>                 return -EINVAL;
>         if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_add=
r)
>                 return -EINVAL;
> @@ -2187,7 +2187,7 @@ int kvm_get_dirty_log(struct kvm *kvm, struct kvm_d=
irty_log *log,
>
>         as_id =3D log->slot >> 16;
>         id =3D (u16)log->slot;
> -       if (as_id >=3D KVM_ADDRESS_SPACE_NUM || id >=3D KVM_USER_MEM_SLOT=
S)
> +       if (as_id >=3D kvm_arch_nr_memslot_as_ids(kvm) || id >=3D KVM_USE=
R_MEM_SLOTS)
>                 return -EINVAL;
>
>         slots =3D __kvm_memslots(kvm, as_id);
> @@ -2249,7 +2249,7 @@ static int kvm_get_dirty_log_protect(struct kvm *kv=
m, struct kvm_dirty_log *log)
>
>         as_id =3D log->slot >> 16;
>         id =3D (u16)log->slot;
> -       if (as_id >=3D KVM_ADDRESS_SPACE_NUM || id >=3D KVM_USER_MEM_SLOT=
S)
> +       if (as_id >=3D kvm_arch_nr_memslot_as_ids(kvm) || id >=3D KVM_USE=
R_MEM_SLOTS)
>                 return -EINVAL;
>
>         slots =3D __kvm_memslots(kvm, as_id);
> @@ -2361,7 +2361,7 @@ static int kvm_clear_dirty_log_protect(struct kvm *=
kvm,
>
>         as_id =3D log->slot >> 16;
>         id =3D (u16)log->slot;
> -       if (as_id >=3D KVM_ADDRESS_SPACE_NUM || id >=3D KVM_USER_MEM_SLOT=
S)
> +       if (as_id >=3D kvm_arch_nr_memslot_as_ids(kvm) || id >=3D KVM_USE=
R_MEM_SLOTS)
>                 return -EINVAL;
>
>         if (log->first_page & 63)
> @@ -2502,7 +2502,7 @@ static __always_inline void kvm_handle_gfn_range(st=
ruct kvm *kvm,
>         gfn_range.only_private =3D false;
>         gfn_range.only_shared =3D false;
>
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 slots =3D __kvm_memslots(kvm, i);
>
>                 kvm_for_each_memslot_in_gfn_range(&iter, slots, range->st=
art, range->end) {
> @@ -4857,9 +4857,11 @@ static int kvm_vm_ioctl_check_extension_generic(st=
ruct kvm *kvm, long arg)
>         case KVM_CAP_IRQ_ROUTING:
>                 return KVM_MAX_IRQ_ROUTES;
>  #endif
> -#if KVM_ADDRESS_SPACE_NUM > 1
> +#if KVM_MAX_NR_ADDRESS_SPACES > 1
>         case KVM_CAP_MULTI_ADDRESS_SPACE:
> -               return KVM_ADDRESS_SPACE_NUM;
> +               if (kvm)
> +                       return kvm_arch_nr_memslot_as_ids(kvm);
> +               return KVM_MAX_NR_ADDRESS_SPACES;
>  #endif
>         case KVM_CAP_NR_MEMSLOTS:
>                 return KVM_USER_MEM_SLOTS;
> @@ -4967,7 +4969,7 @@ bool kvm_are_all_memslots_empty(struct kvm *kvm)
>
>         lockdep_assert_held(&kvm->slots_lock);
>
> -       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +       for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 if (!kvm_memslots_empty(__kvm_memslots(kvm, i)))
>                         return false;
>         }
> --
> 2.42.0.820.g83a721a137-goog
>

