Return-Path: <linux-fsdevel+bounces-2061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DEB7E1E32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B2A2813E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856CB1803A;
	Mon,  6 Nov 2023 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JODhOQh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353517989
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 10:24:27 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CF8BF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 02:24:23 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6707401e1edso26811156d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 02:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699266263; x=1699871063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx7pzo9zslWgjVRljunAjs24sdVG2mkanbp0iYdFwaI=;
        b=JODhOQh6IZK5b57bgt+tbqhYpZqu7mAtmnj1I32IhxvEx0ZCQkkP9PNPPw7my+Se5G
         0hfnoehIHwyUPmlnrOSQaEoWPTKByzqfvvpf+fCCE0DAWR4otXPZlgUbxo0FwwSu2TL6
         +c6hC+umSddz6JJA9YBwnCkfcvFXt7JsvJndnmbqWQ6Y5FV54XMB5SAHiJ+EpaPkk7ZX
         pEGd/4torDbF86UQf7p8JtGsPxnFUuE4vSMo06/30v9R1XZ+L6vEKHC0DvVUBKQYzieZ
         o/hd7mGCBXUTxitZ1Cmf1obG3elW4OIX83b7qYlFZG1t64gSG6XindjeWVThhtilCtrZ
         YMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699266263; x=1699871063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx7pzo9zslWgjVRljunAjs24sdVG2mkanbp0iYdFwaI=;
        b=txXx77MU+e93y4BP0Om1YtrTln4nmzQoBmyLwyetEl/LSsx7/KG6FkpI5s1C3hZB87
         sUUx4ykUizS7ZRx5JjtI79cLz6ypCI3Vg87etrTtcrrmBOTY3VKVbJYwWfQkksFi6xXl
         WET6UwgDvzP23oGRbcxMxm9S9ah9jbWpyVSeO3SJL2xymV88My4/kfT42rUnGffjw0rJ
         Xg7/ZmUiUjCAYCG7V0AiI5nFaIhEGavLp3JWxnPSmDV2dPSQNLVkaJGVF/qAzGZQ9a11
         rmsPZUk/4bL3wLkfiGc7dfjujw4yMDfSsHi+76mrp6jNIFCJlKWQ4YrjeddHC9eNLudy
         P1Kw==
X-Gm-Message-State: AOJu0Yyehf5CYwGvms4nbHGZ0dv56cewGF/LrvBlKXLHQwtSZZby4uLM
	nT7egtLqEgWfEjCAYWNt4CySWJPWiWPpD5scGYPqHA==
X-Google-Smtp-Source: AGHT+IGxqUy2TkFSF/6DzAsvotrbwxLeZiINpO4wtvkCRKfv4JWO0abdv88fQIT6HNBLh2pi2NT5y8KzEPnGx9OmZnQ=
X-Received: by 2002:ad4:5aa3:0:b0:66d:bc21:814c with SMTP id
 u3-20020ad45aa3000000b0066dbc21814cmr37429526qvg.65.1699266262770; Mon, 06
 Nov 2023 02:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-10-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-10-pbonzini@redhat.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 6 Nov 2023 10:23:46 +0000
Message-ID: <CA+EHjTz5F14ULr0ji0-Xq+gAHMZo7EV8tA4KRTkp0pPzZ1dcng@mail.gmail.com>
Subject: Re: [PATCH 09/34] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
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

On Sun, Nov 5, 2023 at 4:32=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> Add a new KVM exit type to allow userspace to handle memory faults that
> KVM cannot resolve, but that userspace *may* be able to handle (without
> terminating the guest).
>
> KVM will initially use KVM_EXIT_MEMORY_FAULT to report implicit
> conversions between private and shared memory.  With guest private memory=
,
> there will be two kind of memory conversions:
>
>   - explicit conversion: happens when the guest explicitly calls into KVM
>     to map a range (as private or shared)
>
>   - implicit conversion: happens when the guest attempts to access a gfn
>     that is configured in the "wrong" state (private vs. shared)
>
> On x86 (first architecture to support guest private memory), explicit
> conversions will be reported via KVM_EXIT_HYPERCALL+KVM_HC_MAP_GPA_RANGE,
> but reporting KVM_EXIT_HYPERCALL for implicit conversions is undesriable
> as there is (obviously) no hypercall, and there is no guarantee that the
> guest actually intends to convert between private and shared, i.e. what
> KVM thinks is an implicit conversion "request" could actually be the
> result of a guest code bug.
>
> KVM_EXIT_MEMORY_FAULT will be used to report memory faults that appear to
> be implicit conversions.
>
> Note!  To allow for future possibilities where KVM reports
> KVM_EXIT_MEMORY_FAULT and fills run->memory_fault on _any_ unresolved
> fault, KVM returns "-EFAULT" (-1 with errno =3D=3D EFAULT from userspace'=
s
> perspective), not '0'!  Due to historical baggage within KVM, exiting to
> userspace with '0' from deep callstacks, e.g. in emulation paths, is
> infeasible as doing so would require a near-complete overhaul of KVM,
> whereas KVM already propagates -errno return codes to userspace even when
> the -errno originated in a low level helper.
>
> Report the gpa+size instead of a single gfn even though the initial usage
> is expected to always report single pages.  It's entirely possible, likel=
y
> even, that KVM will someday support sub-page granularity faults, e.g.
> Intel's sub-page protection feature allows for additional protections at
> 128-byte granularity.
>
> Link: https://lore.kernel.org/all/20230908222905.1321305-5-amoorthy@googl=
e.com
> Link: https://lore.kernel.org/all/ZQ3AmLO2SYv3DszH@google.com
> Cc: Anish Moorthy <amoorthy@google.com>
> Cc: David Matlack <dmatlack@google.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20231027182217.3615211-10-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  Documentation/virt/kvm/api.rst | 41 ++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c             |  1 +
>  include/linux/kvm_host.h       | 11 +++++++++
>  include/uapi/linux/kvm.h       |  8 +++++++
>  4 files changed, 61 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index bdea1423c5f8..481fb0e2ce90 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6846,6 +6846,26 @@ array field represents return values. The userspac=
e should update the return
>  values of SBI call before resuming the VCPU. For more details on RISC-V =
SBI
>  spec refer, https://github.com/riscv/riscv-sbi-doc.
>
> +::
> +
> +               /* KVM_EXIT_MEMORY_FAULT */
> +               struct {
> +                       __u64 flags;
> +                       __u64 gpa;
> +                       __u64 size;
> +               } memory_fault;
> +
> +KVM_EXIT_MEMORY_FAULT indicates the vCPU has encountered a memory fault =
that
> +could not be resolved by KVM.  The 'gpa' and 'size' (in bytes) describe =
the
> +guest physical address range [gpa, gpa + size) of the fault.  The 'flags=
' field
> +describes properties of the faulting access that are likely pertinent.
> +Currently, no flags are defined.
> +
> +Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in tha=
t it
> +accompanies a return code of '-1', not '0'!  errno will always be set to=
 EFAULT
> +or EHWPOISON when KVM exits with KVM_EXIT_MEMORY_FAULT, userspace should=
 assume
> +kvm_run.exit_reason is stale/undefined for all other error numbers.
> +
>  ::
>
>      /* KVM_EXIT_NOTIFY */
> @@ -7880,6 +7900,27 @@ This capability is aimed to mitigate the threat th=
at malicious VMs can
>  cause CPU stuck (due to event windows don't open up) and make the CPU
>  unavailable to host or other VMs.
>
> +7.34 KVM_CAP_MEMORY_FAULT_INFO
> +------------------------------
> +
> +:Architectures: x86
> +:Returns: Informational only, -EINVAL on direct KVM_ENABLE_CAP.
> +
> +The presence of this capability indicates that KVM_RUN will fill
> +kvm_run.memory_fault if KVM cannot resolve a guest page fault VM-Exit, e=
.g. if
> +there is a valid memslot but no backing VMA for the corresponding host v=
irtual
> +address.
> +
> +The information in kvm_run.memory_fault is valid if and only if KVM_RUN =
returns
> +an error with errno=3DEFAULT or errno=3DEHWPOISON *and* kvm_run.exit_rea=
son is set
> +to KVM_EXIT_MEMORY_FAULT.
> +
> +Note: Userspaces which attempt to resolve memory faults so that they can=
 retry
> +KVM_RUN are encouraged to guard against repeatedly receiving the same
> +error/annotated fault.
> +
> +See KVM_EXIT_MEMORY_FAULT for more information.
> +
>  8. Other capabilities.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7b389f27dffc..8f9d8939b63b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4625,6 +4625,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>         case KVM_CAP_ENABLE_CAP:
>         case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
>         case KVM_CAP_IRQFD_RESAMPLE:
> +       case KVM_CAP_MEMORY_FAULT_INFO:
>                 r =3D 1;
>                 break;
>         case KVM_CAP_EXIT_HYPERCALL:
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4e741ff27af3..96aa930536b1 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2327,4 +2327,15 @@ static inline void kvm_account_pgtable_pages(void =
*virt, int nr)
>  /* Max number of entries allowed for each kvm dirty ring */
>  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
>
> +static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> +                                                gpa_t gpa, gpa_t size)
> +{
> +       vcpu->run->exit_reason =3D KVM_EXIT_MEMORY_FAULT;
> +       vcpu->run->memory_fault.gpa =3D gpa;
> +       vcpu->run->memory_fault.size =3D size;
> +
> +       /* Flags are not (yet) defined or communicated to userspace. */
> +       vcpu->run->memory_fault.flags =3D 0;
> +}
> +
>  #endif
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 308cc70bd6ab..59010a685007 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -275,6 +275,7 @@ struct kvm_xen_exit {
>  #define KVM_EXIT_RISCV_CSR        36
>  #define KVM_EXIT_NOTIFY           37
>  #define KVM_EXIT_LOONGARCH_IOCSR  38
> +#define KVM_EXIT_MEMORY_FAULT     39
>
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -528,6 +529,12 @@ struct kvm_run {
>  #define KVM_NOTIFY_CONTEXT_INVALID     (1 << 0)
>                         __u32 flags;
>                 } notify;
> +               /* KVM_EXIT_MEMORY_FAULT */
> +               struct {
> +                       __u64 flags;
> +                       __u64 gpa;
> +                       __u64 size;
> +               } memory_fault;
>                 /* Fix the size of the union. */
>                 char padding[256];
>         };
> @@ -1212,6 +1219,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
>  #define KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES 230
>  #define KVM_CAP_USER_MEMORY2 231
> +#define KVM_CAP_MEMORY_FAULT_INFO 232
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> --
> 2.39.1
>
>

