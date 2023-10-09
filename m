Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4D7BE6B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 18:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377234AbjJIQnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 12:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbjJIQnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:43:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38BDAF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 09:43:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-278eaffd81dso2663638a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1696869781; x=1697474581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG8/7MZsEmSy/+ZOJX4VRYzGIaA1rko7EIxVVdUiS9s=;
        b=BvDuqeNvIowyGjqTkQnQJkWVT5riuDOr1Nq0C+cpB0xjm+CDx9tnPFMf8okavzYR2I
         tAfQccHVoaYwjQlSzqVLMCeyX3mU+yTOFFMkz9OvkBHxkfahy7oQlQeaSRKmkBf0lAKa
         R3BfhYkvZ/fvLDRxovc+mFILUsMRwQuPomyzsG8vvppwIPwd+zSisSqRP2Mp1PpvoPcx
         MEks0OKHlhP2KX5LU2z/uQfITCqX+KaCUC2vRtkYmo9CxbzC/j3MrGxSQ/IEFSgjitT8
         G9HiT1J7kSbutn555/+dFwBSzmTIXL+8OP6Ff94RmAwjjZ+CbYsMj1TddRfoHAED3DyG
         AZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869781; x=1697474581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG8/7MZsEmSy/+ZOJX4VRYzGIaA1rko7EIxVVdUiS9s=;
        b=b1TGWFbJctgXMcwiMxlmmG3ArIAt279ZB9oL0jG+xTD47wXEZxaUcMlZjvD06Vu+jl
         4gFVVm8Gzs85QrYRDyJXu93k/AoHtVE63zhe887G8fvlMcj/V6kWctEPfpheRoCQl7XI
         KkbRs9m1LxPOXV7K1DXTvJled5afcxHJzFPDFN0Xp69jThB19+24uZMMAihzcRm5Dq7C
         LOKImGg4Nk80O8RVDgjgn/VlLKTcc8FC5jd+Cu0Ycnyn8IEGUw5244tBEPg20ui8KRfl
         WomFwmDTF4oYiHifVwdJYrGGyVJYnZ2w1bLaDjAAO15GAIbkgB3X2dw9oqbSElbWUAYV
         zewA==
X-Gm-Message-State: AOJu0Yx30MDBFAA6oVLPdop/WJSn1uGlqQxxOD+tSaWQF7AdnE2i3F9B
        +r/FlUtrUzL2g3lLWtsqPyy+E/1HATp362Xn7Z8PvA==
X-Google-Smtp-Source: AGHT+IHclShG/62PdrOCt9igov7WYEEPxprU1xMMAYDeZ3leyFYnGLVU/OjmfUMLVeZqG6vHv+unNrUci7n642kMqlo=
X-Received: by 2002:a17:90b:3c4:b0:276:757d:8c89 with SMTP id
 go4-20020a17090b03c400b00276757d8c89mr12379576pjb.44.1696869781158; Mon, 09
 Oct 2023 09:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-6-seanjc@google.com>
In-Reply-To: <20230914015531.1419405-6-seanjc@google.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 Oct 2023 22:12:49 +0530
Message-ID: <CAAhSdy3J_3g0F4yNXD4pv9Xhe1qEk3045jdZoshxASopazksWw@mail.gmail.com>
Subject: Re: [RFC PATCH v12 05/33] KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to CONFIG_KVM_GENERIC_MMU_NOTIFIER
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 7:25=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Convert KVM_ARCH_WANT_MMU_NOTIFIER into a Kconfig and select it where
> appropriate to effectively maintain existing behavior.  Using a proper
> Kconfig will simplify building more functionality on top of KVM's
> mmu_notifier infrastructure.
>
> Add a forward declaration of kvm_gfn_range to kvm_types.h so that
> including arch/powerpc/include/asm/kvm_ppc.h's with CONFIG_KVM=3Dn doesn'=
t
> generate warnings due to kvm_gfn_range being undeclared.  PPC defines
> hooks for PR vs. HV without guarding them via #ifdeffery, e.g.
>
>   bool (*unmap_gfn_range)(struct kvm *kvm, struct kvm_gfn_range *range);
>   bool (*age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
>   bool (*test_age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
>   bool (*set_spte_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
>
> Alternatively, PPC could forward declare kvm_gfn_range, but there's no
> good reason not to define it in common KVM.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Looks good to me.

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/arm64/include/asm/kvm_host.h   |  2 --
>  arch/arm64/kvm/Kconfig              |  2 +-
>  arch/mips/include/asm/kvm_host.h    |  2 --
>  arch/mips/kvm/Kconfig               |  2 +-
>  arch/powerpc/include/asm/kvm_host.h |  2 --
>  arch/powerpc/kvm/Kconfig            |  8 ++++----
>  arch/powerpc/kvm/powerpc.c          |  4 +---
>  arch/riscv/include/asm/kvm_host.h   |  2 --
>  arch/riscv/kvm/Kconfig              |  2 +-
>  arch/x86/include/asm/kvm_host.h     |  2 --
>  arch/x86/kvm/Kconfig                |  2 +-
>  include/linux/kvm_host.h            |  6 +++---
>  include/linux/kvm_types.h           |  1 +
>  virt/kvm/Kconfig                    |  4 ++++
>  virt/kvm/kvm_main.c                 | 10 +++++-----
>  15 files changed, 22 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/k=
vm_host.h
> index af06ccb7ee34..9e046b64847a 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -921,8 +921,6 @@ int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
>  int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>                               struct kvm_vcpu_events *events);
>
> -#define KVM_ARCH_WANT_MMU_NOTIFIER
> -
>  void kvm_arm_halt_guest(struct kvm *kvm);
>  void kvm_arm_resume_guest(struct kvm *kvm);
>
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 83c1e09be42e..1a777715199f 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -22,7 +22,7 @@ menuconfig KVM
>         bool "Kernel-based Virtual Machine (KVM) support"
>         depends on HAVE_KVM
>         select KVM_GENERIC_HARDWARE_ENABLING
> -       select MMU_NOTIFIER
> +       select KVM_GENERIC_MMU_NOTIFIER
>         select PREEMPT_NOTIFIERS
>         select HAVE_KVM_CPU_RELAX_INTERCEPT
>         select KVM_MMIO
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm=
_host.h
> index 54a85f1d4f2c..179f320cc231 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -810,8 +810,6 @@ int kvm_mips_mkclean_gpa_pt(struct kvm *kvm, gfn_t st=
art_gfn, gfn_t end_gfn);
>  pgd_t *kvm_pgd_alloc(void);
>  void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
>
> -#define KVM_ARCH_WANT_MMU_NOTIFIER
> -
>  /* Emulation */
>  enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
>  int kvm_get_badinstr(u32 *opc, struct kvm_vcpu *vcpu, u32 *out);
> diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
> index a8cdba75f98d..c04987d2ed2e 100644
> --- a/arch/mips/kvm/Kconfig
> +++ b/arch/mips/kvm/Kconfig
> @@ -25,7 +25,7 @@ config KVM
>         select HAVE_KVM_EVENTFD
>         select HAVE_KVM_VCPU_ASYNC_IOCTL
>         select KVM_MMIO
> -       select MMU_NOTIFIER
> +       select KVM_GENERIC_MMU_NOTIFIER
>         select INTERVAL_TREE
>         select KVM_GENERIC_HARDWARE_ENABLING
>         help
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 14ee0dece853..4b5c3f2acf78 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -62,8 +62,6 @@
>
>  #include <linux/mmu_notifier.h>
>
> -#define KVM_ARCH_WANT_MMU_NOTIFIER
> -
>  #define HPTEG_CACHE_NUM                        (1 << 15)
>  #define HPTEG_HASH_BITS_PTE            13
>  #define HPTEG_HASH_BITS_PTE_LONG       12
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 902611954200..b33358ee6424 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -42,7 +42,7 @@ config KVM_BOOK3S_64_HANDLER
>  config KVM_BOOK3S_PR_POSSIBLE
>         bool
>         select KVM_MMIO
> -       select MMU_NOTIFIER
> +       select KVM_GENERIC_MMU_NOTIFIER
>
>  config KVM_BOOK3S_HV_POSSIBLE
>         bool
> @@ -85,7 +85,7 @@ config KVM_BOOK3S_64_HV
>         tristate "KVM for POWER7 and later using hypervisor mode in host"
>         depends on KVM_BOOK3S_64 && PPC_POWERNV
>         select KVM_BOOK3S_HV_POSSIBLE
> -       select MMU_NOTIFIER
> +       select KVM_GENERIC_MMU_NOTIFIER
>         select CMA
>         help
>           Support running unmodified book3s_64 guest kernels in
> @@ -194,7 +194,7 @@ config KVM_E500V2
>         depends on !CONTEXT_TRACKING_USER
>         select KVM
>         select KVM_MMIO
> -       select MMU_NOTIFIER
> +       select KVM_GENERIC_MMU_NOTIFIER
>         help
>           Support running unmodified E500 guest kernels in virtual machin=
es on
>           E500v2 host processors.
> @@ -211,7 +211,7 @@ config KVM_E500MC
>         select KVM
>         select KVM_MMIO
>         select KVM_BOOKE_HV
> -       select MMU_NOTIFIER
> +       select KVM_GENERIC_MMU_NOTIFIER
>         help
>           Support running unmodified E500MC/E5500/E6500 guest kernels in
>           virtual machines on E500MC/E5500/E6500 host processors.
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 8d3ec483bc2b..aac75c98a956 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -632,9 +632,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>                 break;
>  #endif
>         case KVM_CAP_SYNC_MMU:
> -#if !defined(CONFIG_MMU_NOTIFIER) || !defined(KVM_ARCH_WANT_MMU_NOTIFIER=
)
> -               BUILD_BUG();
> -#endif
> +               BUILD_BUG_ON(!IS_ENABLED(CONFIG_KVM_GENERIC_MMU_NOTIFIER)=
);
>                 r =3D 1;
>                 break;
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 1ebf20dfbaa6..66ee9ff483e9 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -249,8 +249,6 @@ struct kvm_vcpu_arch {
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
>
> -#define KVM_ARCH_WANT_MMU_NOTIFIER
> -
>  #define KVM_RISCV_GSTAGE_TLB_MIN_ORDER         12
>
>  void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index dfc237d7875b..ae2e05f050ec 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -30,7 +30,7 @@ config KVM
>         select KVM_GENERIC_HARDWARE_ENABLING
>         select KVM_MMIO
>         select KVM_XFER_TO_GUEST_WORK
> -       select MMU_NOTIFIER
> +       select KVM_GENERIC_MMU_NOTIFIER
>         select PREEMPT_NOTIFIERS
>         help
>           Support hosting virtualized guest machines.
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 1a4def36d5bb..3a2b53483524 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2131,8 +2131,6 @@ enum {
>  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
>  #endif
>
> -#define KVM_ARCH_WANT_MMU_NOTIFIER
> -
>  int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
>  int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
>  int kvm_cpu_has_extint(struct kvm_vcpu *v);
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index ed90f148140d..091b74599c22 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -24,7 +24,7 @@ config KVM
>         depends on HIGH_RES_TIMERS
>         depends on X86_LOCAL_APIC
>         select PREEMPT_NOTIFIERS
> -       select MMU_NOTIFIER
> +       select KVM_GENERIC_MMU_NOTIFIER
>         select HAVE_KVM_IRQCHIP
>         select HAVE_KVM_PFNCACHE
>         select HAVE_KVM_IRQFD
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 11d091688346..5faba69403ac 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -253,7 +253,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t =
cr2_or_gpa,
>  int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
>  #endif
>
> -#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
> +#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
>  union kvm_mmu_notifier_arg {
>         pte_t pte;
>  };
> @@ -783,7 +783,7 @@ struct kvm {
>         struct hlist_head irq_ack_notifier_list;
>  #endif
>
> -#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> +#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
>         struct mmu_notifier mmu_notifier;
>         unsigned long mmu_invalidate_seq;
>         long mmu_invalidate_in_progress;
> @@ -1946,7 +1946,7 @@ extern const struct _kvm_stats_desc kvm_vm_stats_de=
sc[];
>  extern const struct kvm_stats_header kvm_vcpu_stats_header;
>  extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
>
> -#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> +#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
>  static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mm=
u_seq)
>  {
>         if (unlikely(kvm->mmu_invalidate_in_progress))
> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index 6f4737d5046a..9d1f7835d8c1 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -6,6 +6,7 @@
>  struct kvm;
>  struct kvm_async_pf;
>  struct kvm_device_ops;
> +struct kvm_gfn_range;
>  struct kvm_interrupt;
>  struct kvm_irq_routing_table;
>  struct kvm_memory_slot;
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 484d0873061c..ecae2914c97e 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -92,3 +92,7 @@ config HAVE_KVM_PM_NOTIFIER
>
>  config KVM_GENERIC_HARDWARE_ENABLING
>         bool
> +
> +config KVM_GENERIC_MMU_NOTIFIER
> +       select MMU_NOTIFIER
> +       bool
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4fad3b01dc1f..8d21757cd5e9 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -535,7 +535,7 @@ void kvm_destroy_vcpus(struct kvm *kvm)
>  }
>  EXPORT_SYMBOL_GPL(kvm_destroy_vcpus);
>
> -#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> +#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
>  static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
>  {
>         return container_of(mn, struct kvm, mmu_notifier);
> @@ -960,14 +960,14 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>         return mmu_notifier_register(&kvm->mmu_notifier, current->mm);
>  }
>
> -#else  /* !(CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER) */
> +#else  /* !CONFIG_KVM_GENERIC_MMU_NOTIFIER */
>
>  static int kvm_init_mmu_notifier(struct kvm *kvm)
>  {
>         return 0;
>  }
>
> -#endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
> +#endif /* CONFIG_KVM_GENERIC_MMU_NOTIFIER */
>
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>  static int kvm_pm_notifier_call(struct notifier_block *bl,
> @@ -1287,7 +1287,7 @@ static struct kvm *kvm_create_vm(unsigned long type=
, const char *fdname)
>  out_err_no_debugfs:
>         kvm_coalesced_mmio_free(kvm);
>  out_no_coalesced_mmio:
> -#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> +#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
>         if (kvm->mmu_notifier.ops)
>                 mmu_notifier_unregister(&kvm->mmu_notifier, current->mm);
>  #endif
> @@ -1347,7 +1347,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>                 kvm->buses[i] =3D NULL;
>         }
>         kvm_coalesced_mmio_free(kvm);
> -#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> +#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
>         mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
>         /*
>          * At this point, pending calls to invalidate_range_start()
> --
> 2.42.0.283.g2d96d420d3-goog
>
