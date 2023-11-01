Return-Path: <linux-fsdevel+bounces-1738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F27DE247
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 15:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DF4280F5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755F13FF0;
	Wed,  1 Nov 2023 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkQryUlM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1155134DA
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 14:20:06 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AD510C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 07:20:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66fa16092c0so47382366d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698848403; x=1699453203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bjt3QR9Oyt0AfbOrG8Ks+Z2RSKpEyu9CpvIK66pVo08=;
        b=UkQryUlMXVEYXZKB3qeAuXzXF26XyDpTVnZ58C38x1YPAy7VN10o3z+uNSPkXgA9Mq
         7i81H40T71eYPJRgSflSvkjrmoZbsoWGaMEQNiStJ5EPagY5Oh3uW7ze4JTlbrJI78Bm
         oLvvOu/VCHUFyt9ygpLn4kNAIMKfc7S6+xwkzXQbc8Z4QU+HrkaknNzAvWnsBbTVFQ+k
         VnrKjEeoS3n3DM6+4Jm75VhbMPFiaqDPaEd6E0lRKGB8R8EkbsZoLfo6KtpxOs+/WVaB
         SomYQPwsq9FprOBcbREB2FO8YXjKflA60GTLXIUNcx/4ublsfXCb4dmL0FpDNh5DYm+e
         r3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698848403; x=1699453203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bjt3QR9Oyt0AfbOrG8Ks+Z2RSKpEyu9CpvIK66pVo08=;
        b=Qhf2AONqxx7hv9cUHX+lPx/RFZa4DikJXMQQnYg1DETx1b5RKu75Os5syY/JTbM6Ti
         rKykaqDPpziKmr4Hc9SccaSaaP3+DsNfkByLO2S98MeznCvnvuF67ncV/Ziwg2VOG7A7
         GfaxwZho+1PChlzp78pOWZd/fR+Wtd8TpiSEVBwhezAbBbeIICxtrbyIBUoYLGXNnKmi
         fRmcDN2qOY2JeSWLhDMQyDO+jIdAopK+im5MT+BIXoofwRTnw6OPZiznMzfqVHX9Jrd1
         v+LbSvF7mM9F0hWZ4DghxF6aMGRrpjdPwlf/EJTXAGGlAhSItCjxB1hXQa7x3tDB1WK2
         Sl9g==
X-Gm-Message-State: AOJu0Yw2/nveY6zpxv2WHH5LW9U9geI6w7VuKZvBlL2E19XBZ8FBrA6l
	luP3EW9/bK0z1c5yz/TEHq7WXe7RUQsnN36uARjs0w==
X-Google-Smtp-Source: AGHT+IHK1fieD/BgK48oE6vj2OwKc097KW4M2L6co0EoihJHDvl5lPyutAVieGa2E49DOF2qJpRq12aLhod9YaGzUi0=
X-Received: by 2002:ad4:596c:0:b0:65b:220d:72a5 with SMTP id
 eq12-20020ad4596c000000b0065b220d72a5mr16187853qvb.51.1698848403231; Wed, 01
 Nov 2023 07:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-9-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-9-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 1 Nov 2023 14:19:26 +0000
Message-ID: <CA+EHjTwEr4rLcs9VGQnhRKyBW7A_jGOjQe=zxYbmHnium5=W6Q@mail.gmail.com>
Subject: Re: [PATCH v13 08/35] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
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

On Fri, Oct 27, 2023 at 7:22=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Introduce a "version 2" of KVM_SET_USER_MEMORY_REGION so that additional
> information can be supplied without setting userspace up to fail.  The
> padding in the new kvm_userspace_memory_region2 structure will be used to
> pass a file descriptor in addition to the userspace_addr, i.e. allow
> userspace to point at a file descriptor and map memory into a guest that
> is NOT mapped into host userspace.
>
> Alternatively, KVM could simply add "struct kvm_userspace_memory_region2"
> without a new ioctl(), but as Paolo pointed out, adding a new ioctl()
> makes detection of bad flags a bit more robust, e.g. if the new fd field
> is guarded only by a flag and not a new ioctl(), then a userspace bug
> (setting a "bad" flag) would generate out-of-bounds access instead of an
> -EINVAL error.
>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

With the missing pad in api.rst fixed:
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  Documentation/virt/kvm/api.rst | 21 +++++++++++++++++++
>  arch/x86/kvm/x86.c             |  2 +-
>  include/linux/kvm_host.h       |  4 ++--
>  include/uapi/linux/kvm.h       | 13 ++++++++++++
>  virt/kvm/kvm_main.c            | 38 +++++++++++++++++++++++++++-------
>  5 files changed, 67 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 21a7578142a1..ace984acc125 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6070,6 +6070,27 @@ writes to the CNTVCT_EL0 and CNTPCT_EL0 registers =
using the SET_ONE_REG
>  interface. No error will be returned, but the resulting offset will not =
be
>  applied.
>
> +4.139 KVM_SET_USER_MEMORY_REGION2
> +---------------------------------
> +
> +:Capability: KVM_CAP_USER_MEMORY2
> +:Architectures: all
> +:Type: vm ioctl
> +:Parameters: struct kvm_userspace_memory_region2 (in)
> +:Returns: 0 on success, -1 on error
> +
> +::
> +
> +  struct kvm_userspace_memory_region2 {
> +       __u32 slot;
> +       __u32 flags;
> +       __u64 guest_phys_addr;
> +       __u64 memory_size; /* bytes */
> +       __u64 userspace_addr; /* start of the userspace allocated memory =
*/
> +  };
> +
> +See KVM_SET_USER_MEMORY_REGION.
> +
>  5. The kvm_run structure
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 41cce5031126..6409914428ca 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12455,7 +12455,7 @@ void __user * __x86_set_memory_region(struct kvm =
*kvm, int id, gpa_t gpa,
>         }
>
>         for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> -               struct kvm_userspace_memory_region m;
> +               struct kvm_userspace_memory_region2 m;
>
>                 m.slot =3D id | (i << 16);
>                 m.flags =3D 0;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 5faba69403ac..4e741ff27af3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1146,9 +1146,9 @@ enum kvm_mr_change {
>  };
>
>  int kvm_set_memory_region(struct kvm *kvm,
> -                         const struct kvm_userspace_memory_region *mem);
> +                         const struct kvm_userspace_memory_region2 *mem)=
;
>  int __kvm_set_memory_region(struct kvm *kvm,
> -                           const struct kvm_userspace_memory_region *mem=
);
> +                           const struct kvm_userspace_memory_region2 *me=
m);
>  void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot=
);
>  void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
>  int kvm_arch_prepare_memory_region(struct kvm *kvm,
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 13065dd96132..bd1abe067f28 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -95,6 +95,16 @@ struct kvm_userspace_memory_region {
>         __u64 userspace_addr; /* start of the userspace allocated memory =
*/
>  };
>
> +/* for KVM_SET_USER_MEMORY_REGION2 */
> +struct kvm_userspace_memory_region2 {
> +       __u32 slot;
> +       __u32 flags;
> +       __u64 guest_phys_addr;
> +       __u64 memory_size;
> +       __u64 userspace_addr;
> +       __u64 pad[16];
> +};
> +
>  /*
>   * The bit 0 ~ bit 15 of kvm_userspace_memory_region::flags are visible =
for
>   * userspace, other bits are reserved for kvm internal use which are def=
ined
> @@ -1192,6 +1202,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_COUNTER_OFFSET 227
>  #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
>  #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
> +#define KVM_CAP_USER_MEMORY2 230
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> @@ -1473,6 +1484,8 @@ struct kvm_vfio_spapr_tce {
>                                         struct kvm_userspace_memory_regio=
n)
>  #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
>  #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
> +#define KVM_SET_USER_MEMORY_REGION2 _IOW(KVMIO, 0x49, \
> +                                        struct kvm_userspace_memory_regi=
on2)
>
>  /* enable ucontrol for s390 */
>  struct kvm_s390_ucas_mapping {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 6e708017064d..3f5b7c2c5327 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1578,7 +1578,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
>         }
>  }
>
> -static int check_memory_region_flags(const struct kvm_userspace_memory_r=
egion *mem)
> +static int check_memory_region_flags(const struct kvm_userspace_memory_r=
egion2 *mem)
>  {
>         u32 valid_flags =3D KVM_MEM_LOG_DIRTY_PAGES;
>
> @@ -1980,7 +1980,7 @@ static bool kvm_check_memslot_overlap(struct kvm_me=
mslots *slots, int id,
>   * Must be called holding kvm->slots_lock for write.
>   */
>  int __kvm_set_memory_region(struct kvm *kvm,
> -                           const struct kvm_userspace_memory_region *mem=
)
> +                           const struct kvm_userspace_memory_region2 *me=
m)
>  {
>         struct kvm_memory_slot *old, *new;
>         struct kvm_memslots *slots;
> @@ -2084,7 +2084,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
>
>  int kvm_set_memory_region(struct kvm *kvm,
> -                         const struct kvm_userspace_memory_region *mem)
> +                         const struct kvm_userspace_memory_region2 *mem)
>  {
>         int r;
>
> @@ -2096,7 +2096,7 @@ int kvm_set_memory_region(struct kvm *kvm,
>  EXPORT_SYMBOL_GPL(kvm_set_memory_region);
>
>  static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
> -                                         struct kvm_userspace_memory_reg=
ion *mem)
> +                                         struct kvm_userspace_memory_reg=
ion2 *mem)
>  {
>         if ((u16)mem->slot >=3D KVM_USER_MEM_SLOTS)
>                 return -EINVAL;
> @@ -4566,6 +4566,7 @@ static int kvm_vm_ioctl_check_extension_generic(str=
uct kvm *kvm, long arg)
>  {
>         switch (arg) {
>         case KVM_CAP_USER_MEMORY:
> +       case KVM_CAP_USER_MEMORY2:
>         case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
>         case KVM_CAP_JOIN_MEMORY_REGIONS_WORKS:
>         case KVM_CAP_INTERNAL_ERROR_DATA:
> @@ -4821,6 +4822,14 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *k=
vm)
>         return fd;
>  }
>
> +#define SANITY_CHECK_MEM_REGION_FIELD(field)                            =
       \
> +do {                                                                    =
       \
> +       BUILD_BUG_ON(offsetof(struct kvm_userspace_memory_region, field) =
!=3D             \
> +                    offsetof(struct kvm_userspace_memory_region2, field)=
);     \
> +       BUILD_BUG_ON(sizeof_field(struct kvm_userspace_memory_region, fie=
ld) !=3D         \
> +                    sizeof_field(struct kvm_userspace_memory_region2, fi=
eld)); \
> +} while (0)
> +
>  static long kvm_vm_ioctl(struct file *filp,
>                            unsigned int ioctl, unsigned long arg)
>  {
> @@ -4843,15 +4852,28 @@ static long kvm_vm_ioctl(struct file *filp,
>                 r =3D kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
>                 break;
>         }
> +       case KVM_SET_USER_MEMORY_REGION2:
>         case KVM_SET_USER_MEMORY_REGION: {
> -               struct kvm_userspace_memory_region kvm_userspace_mem;
> +               struct kvm_userspace_memory_region2 mem;
> +               unsigned long size;
> +
> +               if (ioctl =3D=3D KVM_SET_USER_MEMORY_REGION)
> +                       size =3D sizeof(struct kvm_userspace_memory_regio=
n);
> +               else
> +                       size =3D sizeof(struct kvm_userspace_memory_regio=
n2);
> +
> +               /* Ensure the common parts of the two structs are identic=
al. */
> +               SANITY_CHECK_MEM_REGION_FIELD(slot);
> +               SANITY_CHECK_MEM_REGION_FIELD(flags);
> +               SANITY_CHECK_MEM_REGION_FIELD(guest_phys_addr);
> +               SANITY_CHECK_MEM_REGION_FIELD(memory_size);
> +               SANITY_CHECK_MEM_REGION_FIELD(userspace_addr);
>
>                 r =3D -EFAULT;
> -               if (copy_from_user(&kvm_userspace_mem, argp,
> -                                               sizeof(kvm_userspace_mem)=
))
> +               if (copy_from_user(&mem, argp, size))
>                         goto out;
>
> -               r =3D kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_=
mem);
> +               r =3D kvm_vm_ioctl_set_memory_region(kvm, &mem);
>                 break;
>         }
>         case KVM_GET_DIRTY_LOG: {
> --
> 2.42.0.820.g83a721a137-goog
>

