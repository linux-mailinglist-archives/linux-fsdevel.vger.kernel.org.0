Return-Path: <linux-fsdevel+bounces-1833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21EC7DF529
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573E6281C17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B874D1C284;
	Thu,  2 Nov 2023 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXf4IwJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399561BDC6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:35:21 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD9136
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:35:17 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66cfd874520so5687826d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698935716; x=1699540516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2lJd6XsyJuryPcyY7Aaw/1637wZx+D1R9nKqgAWHhc=;
        b=DXf4IwJAu8bEvsnw7UWI046t/VyHgiyBZCraX3/XvzB+jbzE162rL1B+8jVID/4UQa
         uMy9vCpY1EBqgt3EVus260jVCYgKrDKjYEMK4zZS0HJ4URMKu3bGmeh73RdIYve+z+O0
         nSImY52iUTw5RNo1B/yXW7VKej2QFOgUfJJ6+XoZzZNn8/olpxfuYDZ/cdkfMGGdkxS0
         Lt0FI8eNbT8W41bI/AdzxZ7YFcVDfrcKe+oGcidJl74nLL38BITI6JEXELlZ2L3SfPi7
         OzjeDh7koa76/zJramWfL5VZf2aHM0EwJpCFWlw0YVe0mDgmQhtTHEvIC8Jh9D70XHRH
         CEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935716; x=1699540516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2lJd6XsyJuryPcyY7Aaw/1637wZx+D1R9nKqgAWHhc=;
        b=MEai7HZ7pEinhdWyEUsvLyv5rBJ0JOMHGmvjpLmAtQZrGxwXIWL2Z4Hpyt4LuSaa2N
         pk0nUJKZg5quU8unXFrhdZ/5zZuWnx36FW7gu1t3hdd6+U1P5LNhz/rrpRxuQTPgEC8e
         qC09sWjIMrcDwrCKLkjapnhQY0D0v+NZQOquRFMBwJS0RZVVNoPYMq9JndX3Xos0NHCR
         Mq5Z8yxmVTrxYiXi179ixi2+SAFM0bnjRGq4mbrJ0m65atnr9K9BSywhNdkJTIsrDrpP
         SbH3CcYpTxXZVuMIBQYCQU815oX2aIqkniupTdUoOAte7o+KMrgE428DaNI3g9we4P0d
         +2wA==
X-Gm-Message-State: AOJu0Yx2j6lsLoRpYV7EWJFFaS0PMCmzjUp063n/zLGQCGKhUcDD29vb
	GXWPA6E5JWKAqfTOxwr03tSbNmmu4YsuYyenesVUmA==
X-Google-Smtp-Source: AGHT+IFd3hjmyLuXSjGnT5FsRtAzP075qFDK3w/9FA3uch9hEM0UvybnX5VOnaQIaLR3sNNdinYmhN8LWUDVv4d6UXk=
X-Received: by 2002:ad4:5761:0:b0:671:6003:73b1 with SMTP id
 r1-20020ad45761000000b00671600373b1mr17968741qvx.60.1698935716453; Thu, 02
 Nov 2023 07:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-21-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-21-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 2 Nov 2023 14:34:40 +0000
Message-ID: <CA+EHjTyRwz7rnqy_qRa2ayPWAu_tjW5OeieZJEsaAVvXu1XeMw@mail.gmail.com>
Subject: Re: [PATCH v13 20/35] KVM: x86/mmu: Handle page fault for private memory
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
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> Add support for resolving page faults on guest private memory for VMs
> that differentiate between "shared" and "private" memory.  For such VMs,
> KVM_MEM_PRIVATE memslots can include both fd-based private memory and
> hva-based shared memory, and KVM needs to map in the "correct" variant,
> i.e. KVM needs to map the gfn shared/private as appropriate based on the
> current state of the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE flag.
>
> For AMD's SEV-SNP and Intel's TDX, the guest effectively gets to request
> shared vs. private via a bit in the guest page tables, i.e. what the gues=
t
> wants may conflict with the current memory attributes.  To support such
> "implicit" conversion requests, exit to user with KVM_EXIT_MEMORY_FAULT
> to forward the request to userspace.  Add a new flag for memory faults,
> KVM_MEMORY_EXIT_FLAG_PRIVATE, to communicate whether the guest wants to
> map memory as shared vs. private.
>
> Like KVM_MEMORY_ATTRIBUTE_PRIVATE, use bit 3 for flagging private memory
> so that KVM can use bits 0-2 for capturing RWX behavior if/when userspace
> needs such information, e.g. a likely user of KVM_EXIT_MEMORY_FAULT is to
> exit on missing mappings when handling guest page fault VM-Exits.  In
> that case, userspace will want to know RWX information in order to
> correctly/precisely resolve the fault.
>
> Note, private memory *must* be backed by guest_memfd, i.e. shared mapping=
s
> always come from the host userspace page tables, and private mappings
> always come from a guest_memfd instance.
>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

With my limited understanding of kvm-x86 mmu code:
Reviewed-by: Fuad Tabba <tabba@google.com>

Tested the x86 code (as part of this patch series) on qemu. The x86
fault handling code was used as a guide to how it should be done for
pKVM/arm64 (with similar code added there):
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  Documentation/virt/kvm/api.rst  |   8 ++-
>  arch/x86/kvm/mmu/mmu.c          | 101 ++++++++++++++++++++++++++++++--
>  arch/x86/kvm/mmu/mmu_internal.h |   1 +
>  include/linux/kvm_host.h        |   8 ++-
>  include/uapi/linux/kvm.h        |   1 +
>  5 files changed, 110 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 7f00c310c24a..38dc1fda4f45 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6837,6 +6837,7 @@ spec refer, https://github.com/riscv/riscv-sbi-doc.
>
>                 /* KVM_EXIT_MEMORY_FAULT */
>                 struct {
> +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE (1ULL << 3)
>                         __u64 flags;
>                         __u64 gpa;
>                         __u64 size;
> @@ -6845,8 +6846,11 @@ spec refer, https://github.com/riscv/riscv-sbi-doc=
.
>  KVM_EXIT_MEMORY_FAULT indicates the vCPU has encountered a memory fault =
that
>  could not be resolved by KVM.  The 'gpa' and 'size' (in bytes) describe =
the
>  guest physical address range [gpa, gpa + size) of the fault.  The 'flags=
' field
> -describes properties of the faulting access that are likely pertinent.
> -Currently, no flags are defined.
> +describes properties of the faulting access that are likely pertinent:
> +
> + - KVM_MEMORY_EXIT_FLAG_PRIVATE - When set, indicates the memory fault o=
ccurred
> +   on a private memory access.  When clear, indicates the fault occurred=
 on a
> +   shared access.
>
>  Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in tha=
t it
>  accompanies a return code of '-1', not '0'!  errno will always be set to=
 EFAULT
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4167d557c577..c4e758f0aebb 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3147,9 +3147,9 @@ static int host_pfn_mapping_level(struct kvm *kvm, =
gfn_t gfn,
>         return level;
>  }
>
> -int kvm_mmu_max_mapping_level(struct kvm *kvm,
> -                             const struct kvm_memory_slot *slot, gfn_t g=
fn,
> -                             int max_level)
> +static int __kvm_mmu_max_mapping_level(struct kvm *kvm,
> +                                      const struct kvm_memory_slot *slot=
,
> +                                      gfn_t gfn, int max_level, bool is_=
private)
>  {
>         struct kvm_lpage_info *linfo;
>         int host_level;
> @@ -3161,6 +3161,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
>                         break;
>         }
>
> +       if (is_private)
> +               return max_level;
> +
>         if (max_level =3D=3D PG_LEVEL_4K)
>                 return PG_LEVEL_4K;
>
> @@ -3168,6 +3171,16 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
>         return min(host_level, max_level);
>  }
>
> +int kvm_mmu_max_mapping_level(struct kvm *kvm,
> +                             const struct kvm_memory_slot *slot, gfn_t g=
fn,
> +                             int max_level)
> +{
> +       bool is_private =3D kvm_slot_can_be_private(slot) &&
> +                         kvm_mem_is_private(kvm, gfn);
> +
> +       return __kvm_mmu_max_mapping_level(kvm, slot, gfn, max_level, is_=
private);
> +}
> +
>  void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_faul=
t *fault)
>  {
>         struct kvm_memory_slot *slot =3D fault->slot;
> @@ -3188,8 +3201,9 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu,=
 struct kvm_page_fault *fault
>          * Enforce the iTLB multihit workaround after capturing the reque=
sted
>          * level, which will be used to do precise, accurate accounting.
>          */
> -       fault->req_level =3D kvm_mmu_max_mapping_level(vcpu->kvm, slot,
> -                                                    fault->gfn, fault->m=
ax_level);
> +       fault->req_level =3D __kvm_mmu_max_mapping_level(vcpu->kvm, slot,
> +                                                      fault->gfn, fault-=
>max_level,
> +                                                      fault->is_private)=
;
>         if (fault->req_level =3D=3D PG_LEVEL_4K || fault->huge_page_disal=
lowed)
>                 return;
>
> @@ -4261,6 +4275,55 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vc=
pu, struct kvm_async_pf *work)
>         kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true, NULL);
>  }
>
> +static inline u8 kvm_max_level_for_order(int order)
> +{
> +       BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
> +
> +       KVM_MMU_WARN_ON(order !=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G) &&
> +                       order !=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M) &&
> +                       order !=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_4K));
> +
> +       if (order >=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
> +               return PG_LEVEL_1G;
> +
> +       if (order >=3D KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
> +               return PG_LEVEL_2M;
> +
> +       return PG_LEVEL_4K;
> +}
> +
> +static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> +                                             struct kvm_page_fault *faul=
t)
> +{
> +       kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> +                                     PAGE_SIZE, fault->write, fault->exe=
c,
> +                                     fault->is_private);
> +}
> +
> +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> +                                  struct kvm_page_fault *fault)
> +{
> +       int max_order, r;
> +
> +       if (!kvm_slot_can_be_private(fault->slot)) {
> +               kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +               return -EFAULT;
> +       }
> +
> +       r =3D kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault=
->pfn,
> +                            &max_order);
> +       if (r) {
> +               kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +               return r;
> +       }
> +
> +       fault->max_level =3D min(kvm_max_level_for_order(max_order),
> +                              fault->max_level);
> +       fault->map_writable =3D !(fault->slot->flags & KVM_MEM_READONLY);
> +
> +       return RET_PF_CONTINUE;
> +}
> +
>  static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_faul=
t *fault)
>  {
>         struct kvm_memory_slot *slot =3D fault->slot;
> @@ -4293,6 +4356,14 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu=
, struct kvm_page_fault *fault
>                         return RET_PF_EMULATE;
>         }
>
> +       if (fault->is_private !=3D kvm_mem_is_private(vcpu->kvm, fault->g=
fn)) {
> +               kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +               return -EFAULT;
> +       }
> +
> +       if (fault->is_private)
> +               return kvm_faultin_pfn_private(vcpu, fault);
> +
>         async =3D false;
>         fault->pfn =3D __gfn_to_pfn_memslot(slot, fault->gfn, false, fals=
e, &async,
>                                           fault->write, &fault->map_writa=
ble,
> @@ -7173,6 +7244,26 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
>  }
>
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
> +                                       struct kvm_gfn_range *range)
> +{
> +       /*
> +        * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 o=
nly
> +        * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like =
KVM
> +        * can simply ignore such slots.  But if userspace is making memo=
ry
> +        * PRIVATE, then KVM must prevent the guest from accessing the me=
mory
> +        * as shared.  And if userspace is making memory SHARED and this =
point
> +        * is reached, then at least one page within the range was previo=
usly
> +        * PRIVATE, i.e. the slot's possible hugepage ranges are changing=
.
> +        * Zapping SPTEs in this case ensures KVM will reassess whether o=
r not
> +        * a hugepage can be used for affected ranges.
> +        */
> +       if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
> +               return false;
> +
> +       return kvm_unmap_gfn_range(kvm, range);
> +}
> +
>  static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
>                                 int level)
>  {
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_inter=
nal.h
> index decc1f153669..86c7cb692786 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -201,6 +201,7 @@ struct kvm_page_fault {
>
>         /* Derived from mmu and global state.  */
>         const bool is_tdp;
> +       const bool is_private;
>         const bool nx_huge_page_workaround_enabled;
>
>         /*
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 7de93858054d..e3223cafd7db 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2358,14 +2358,18 @@ static inline void kvm_account_pgtable_pages(void=
 *virt, int nr)
>  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
>
>  static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> -                                                gpa_t gpa, gpa_t size)
> +                                                gpa_t gpa, gpa_t size,
> +                                                bool is_write, bool is_e=
xec,
> +                                                bool is_private)
>  {
>         vcpu->run->exit_reason =3D KVM_EXIT_MEMORY_FAULT;
>         vcpu->run->memory_fault.gpa =3D gpa;
>         vcpu->run->memory_fault.size =3D size;
>
> -       /* Flags are not (yet) defined or communicated to userspace. */
> +       /* RWX flags are not (yet) defined or communicated to userspace. =
*/
>         vcpu->run->memory_fault.flags =3D 0;
> +       if (is_private)
> +               vcpu->run->memory_fault.flags |=3D KVM_MEMORY_EXIT_FLAG_P=
RIVATE;
>  }
>
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 33d542de0a61..29e9eb51dec9 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -527,6 +527,7 @@ struct kvm_run {
>                 } notify;
>                 /* KVM_EXIT_MEMORY_FAULT */
>                 struct {
> +#define KVM_MEMORY_EXIT_FLAG_PRIVATE   (1ULL << 3)
>                         __u64 flags;
>                         __u64 gpa;
>                         __u64 size;
> --
> 2.42.0.820.g83a721a137-goog
>

