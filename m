Return-Path: <linux-fsdevel+bounces-2070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01F7E1F23
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BC7281402
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FC11805E;
	Mon,  6 Nov 2023 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYNcYifD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7531799F
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 11:02:35 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE9BD
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 03:02:32 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a90d6ab962so50006727b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 03:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699268552; x=1699873352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2GJ8/Y90IpmxpdY5rYjfIxqDFVHPJDdAKZ/UZv6WBc=;
        b=vYNcYifDPP598PI8ch9gsg0/D6zQlCvtxo4xnaAmv4fBAEd2qbBuirTXWg5IE8hpfH
         LtHI/BJZARdS5opWd+N0g0u+i2LlMo5/aBnmCjyP2IV/WxnBkXmr0PcFeIEMPxbu5YbF
         WhzEaCkLFxtZmqTJmDxipCXdb4338WocA2daOHgVW2lSr6IC/8HDdprHZgT6OAhepVxi
         jcUco6+YnH8jYxVP6QO7nFuTB7NpiAD/t60K7W81hKm0Aq2zViYGuefiHn/aEYXXGZWk
         DJ+gsmhJHo1Fz6VjGvxRJ1HHcIFRrdotH5oSuvwI2ONM9vf3TJXxVzul3L0SPLqVjJ85
         Msiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699268552; x=1699873352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2GJ8/Y90IpmxpdY5rYjfIxqDFVHPJDdAKZ/UZv6WBc=;
        b=hYBgtky46rfOCLo+itDQi984eP2M5tMbMUmu90vQg4vdT0GX0poAWbXgKlw/3bx8Jz
         63bXeb+vKKTf6U4A1dZVBLKJtEfrUeNBYJ8k8Z5HF1VgfbBHK5y5kWAIifgbZ3ySw/5H
         Cu9l6BxyMpj9OmbQv0DHKudbq72Q31zObRSIxzNY4McNPNGkDkk2+h3y0LY1QDbF1koZ
         zAJk+fcuBr+sC7nDNzjB9g5YS19cJ/s+G9Gkg+q4MDlXPoF5LC0aA+NTLOIJkkVGGR15
         JKBdHgDNTyttBMwUdZwpAxN3CQjwo6kxe0mHzoE/uQfq3ErZxSIFyB7qZCjjro8Cq16V
         R3Zw==
X-Gm-Message-State: AOJu0YxM6LK0tNctqSMm8joo9s/pNAO3WzeeGM9np7lPUPdk5TmtR0It
	BtZb8Wzvxn6c8NerOc5DAqcMpwrpAhTuWswnDqfPpg==
X-Google-Smtp-Source: AGHT+IENsSw7a/V4UHxjgeCZCxumLhfZFTIQeh3gjUw+ULtbqWsBt8O3seLfs1J5njILHP4HGiHHO4KXlr48V0F1FV0=
X-Received: by 2002:a0d:ead2:0:b0:5a2:20ec:40be with SMTP id
 t201-20020a0dead2000000b005a220ec40bemr12462308ywe.29.1699268551723; Mon, 06
 Nov 2023 03:02:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-22-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-22-pbonzini@redhat.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 6 Nov 2023 11:01:56 +0000
Message-ID: <CA+EHjTw33hNZPeRZnoxM8snKE=s3T6ebSgOOAKqCyrb3rDPa9g@mail.gmail.com>
Subject: Re: [PATCH 21/34] KVM: x86: Add support for "protected VMs" that can
 utilize private memory
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 5, 2023 at 4:33=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Add a new x86 VM type, KVM_X86_SW_PROTECTED_VM, to serve as a development
> and testing vehicle for Confidential (CoCo) VMs, and potentially to even
> become a "real" product in the distant future, e.g. a la pKVM.
>
> The private memory support in KVM x86 is aimed at AMD's SEV-SNP and
> Intel's TDX, but those technologies are extremely complex (understatement=
),
> difficult to debug, don't support running as nested guests, and require
> hardware that's isn't universally accessible.  I.e. relying SEV-SNP or TD=
X

(replied to v13 earlier, sorry)

nit: "that isn't"

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> for maintaining guest private memory isn't a realistic option.
>
> At the very least, KVM_X86_SW_PROTECTED_VM will enable a variety of
> selftests for guest_memfd and private memory support without requiring
> unique hardware.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20231027182217.3615211-24-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Documentation/virt/kvm/api.rst  | 32 ++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/kvm_host.h | 15 +++++++++------
>  arch/x86/include/uapi/asm/kvm.h |  3 +++
>  arch/x86/kvm/Kconfig            | 12 ++++++++++++
>  arch/x86/kvm/mmu/mmu_internal.h |  1 +
>  arch/x86/kvm/x86.c              | 16 +++++++++++++++-
>  include/uapi/linux/kvm.h        |  1 +
>  virt/kvm/Kconfig                |  5 +++++
>  8 files changed, 78 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 4a9a291380ad..38882263278d 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -147,10 +147,29 @@ described as 'basic' will be available.
>  The new VM has no virtual cpus and no memory.
>  You probably want to use 0 as machine type.
>
> +X86:
> +^^^^
> +
> +Supported X86 VM types can be queried via KVM_CAP_VM_TYPES.
> +
> +S390:
> +^^^^^
> +
>  In order to create user controlled virtual machines on S390, check
>  KVM_CAP_S390_UCONTROL and use the flag KVM_VM_S390_UCONTROL as
>  privileged user (CAP_SYS_ADMIN).
>
> +MIPS:
> +^^^^^
> +
> +To use hardware assisted virtualization on MIPS (VZ ASE) rather than
> +the default trap & emulate implementation (which changes the virtual
> +memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
> +flag KVM_VM_MIPS_VZ.
> +
> +ARM64:
> +^^^^^^
> +
>  On arm64, the physical address size for a VM (IPA Size limit) is limited
>  to 40bits by default. The limit can be configured if the host supports t=
he
>  extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
> @@ -8766,6 +8785,19 @@ block sizes is exposed in KVM_CAP_ARM_SUPPORTED_BL=
OCK_SIZES as a
>  64-bit bitmap (each bit describing a block size). The default value is
>  0, to disable the eager page splitting.
>
> +8.41 KVM_CAP_VM_TYPES
> +---------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: system ioctl
> +
> +This capability returns a bitmap of support VM types.  The 1-setting of =
bit @n
> +means the VM type with value @n is supported.  Possible values of @n are=
::
> +
> +  #define KVM_X86_DEFAULT_VM   0
> +  #define KVM_X86_SW_PROTECTED_VM      1
> +
>  9. Known KVM API problems
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 75ab0da06e64..a565a2e70f30 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1255,6 +1255,7 @@ enum kvm_apicv_inhibit {
>  };
>
>  struct kvm_arch {
> +       unsigned long vm_type;
>         unsigned long n_used_mmu_pages;
>         unsigned long n_requested_mmu_pages;
>         unsigned long n_max_mmu_pages;
> @@ -2089,6 +2090,12 @@ void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t =
new_pgd);
>  void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
>                        int tdp_max_root_level, int tdp_huge_page_level);
>
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +#define kvm_arch_has_private_mem(kvm) ((kvm)->arch.vm_type !=3D KVM_X86_=
DEFAULT_VM)
> +#else
> +#define kvm_arch_has_private_mem(kvm) false
> +#endif
> +
>  static inline u16 kvm_read_ldt(void)
>  {
>         u16 ldt;
> @@ -2137,14 +2144,10 @@ enum {
>  #define HF_SMM_INSIDE_NMI_MASK (1 << 2)
>
>  # define KVM_MAX_NR_ADDRESS_SPACES     2
> +/* SMM is currently unsupported for guests with private memory. */
> +# define kvm_arch_nr_memslot_as_ids(kvm) (kvm_arch_has_private_mem(kvm) =
? 1 : 2)
>  # define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_M=
ASK ? 1 : 0)
>  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role=
).smm)
> -
> -static inline int kvm_arch_nr_memslot_as_ids(struct kvm *kvm)
> -{
> -       return KVM_MAX_NR_ADDRESS_SPACES;
> -}
> -
>  #else
>  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
>  #endif
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/=
kvm.h
> index 1a6a1f987949..a448d0964fc0 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -562,4 +562,7 @@ struct kvm_pmu_event_filter {
>  /* x86-specific KVM_EXIT_HYPERCALL flags. */
>  #define KVM_EXIT_HYPERCALL_LONG_MODE   BIT(0)
>
> +#define KVM_X86_DEFAULT_VM     0
> +#define KVM_X86_SW_PROTECTED_VM        1
> +
>  #endif /* _ASM_X86_KVM_H */
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index e61383674c75..c1716e83d176 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -77,6 +77,18 @@ config KVM_WERROR
>
>           If in doubt, say "N".
>
> +config KVM_SW_PROTECTED_VM
> +       bool "Enable support for KVM software-protected VMs"
> +       depends on EXPERT
> +       depends on X86_64
> +       select KVM_GENERIC_PRIVATE_MEM
> +       help
> +         Enable support for KVM software-protected VMs.  Currently "prot=
ected"
> +         means the VM can be backed with memory provided by
> +         KVM_CREATE_GUEST_MEMFD.
> +
> +         If unsure, say "N".
> +
>  config KVM_INTEL
>         tristate "KVM for Intel (and compatible) processors support"
>         depends on KVM && IA32_FEAT_CTL
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_inter=
nal.h
> index 86c7cb692786..b66a7d47e0e4 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -297,6 +297,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vc=
pu *vcpu, gpa_t cr2_or_gpa,
>                 .max_level =3D KVM_MAX_HUGEPAGE_LEVEL,
>                 .req_level =3D PG_LEVEL_4K,
>                 .goal_level =3D PG_LEVEL_4K,
> +               .is_private =3D kvm_mem_is_private(vcpu->kvm, cr2_or_gpa =
>> PAGE_SHIFT),
>         };
>         int r;
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f521c97f5c64..6d0772b47041 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4548,6 +4548,13 @@ static int kvm_ioctl_get_supported_hv_cpuid(struct=
 kvm_vcpu *vcpu,
>         return 0;
>  }
>
> +static bool kvm_is_vm_type_supported(unsigned long type)
> +{
> +       return type =3D=3D KVM_X86_DEFAULT_VM ||
> +              (type =3D=3D KVM_X86_SW_PROTECTED_VM &&
> +               IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) && tdp_enabled);
> +}
> +
>  int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  {
>         int r =3D 0;
> @@ -4739,6 +4746,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, =
long ext)
>         case KVM_CAP_X86_NOTIFY_VMEXIT:
>                 r =3D kvm_caps.has_notify_vmexit;
>                 break;
> +       case KVM_CAP_VM_TYPES:
> +               r =3D BIT(KVM_X86_DEFAULT_VM);
> +               if (kvm_is_vm_type_supported(KVM_X86_SW_PROTECTED_VM))
> +                       r |=3D BIT(KVM_X86_SW_PROTECTED_VM);
> +               break;
>         default:
>                 break;
>         }
> @@ -12436,9 +12448,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned l=
ong type)
>         int ret;
>         unsigned long flags;
>
> -       if (type)
> +       if (!kvm_is_vm_type_supported(type))
>                 return -EINVAL;
>
> +       kvm->arch.vm_type =3D type;
> +
>         ret =3D kvm_page_track_init(kvm);
>         if (ret)
>                 goto out;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 8eb10f560c69..e9cb2df67a1d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1227,6 +1227,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_MEMORY_FAULT_INFO 232
>  #define KVM_CAP_MEMORY_ATTRIBUTES 233
>  #define KVM_CAP_GUEST_MEMFD 234
> +#define KVM_CAP_VM_TYPES 235
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 08afef022db9..2c964586aa14 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -104,3 +104,8 @@ config KVM_GENERIC_MEMORY_ATTRIBUTES
>  config KVM_PRIVATE_MEM
>         select XARRAY_MULTI
>         bool
> +
> +config KVM_GENERIC_PRIVATE_MEM
> +       select KVM_GENERIC_MEMORY_ATTRIBUTES
> +       select KVM_PRIVATE_MEM
> +       bool
> --
> 2.39.1
>
>

