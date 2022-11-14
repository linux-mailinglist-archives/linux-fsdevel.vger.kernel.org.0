Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C294A6284D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiKNQRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 11:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbiKNQQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:16:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1ED2ED7D
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 08:16:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h9so19209384wrt.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 08:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2wttqJnXSnC6uZPwQbYPo9kiCshXn3+hg9VUqJAS7M=;
        b=AS14hnGGiqK/73Br6q4ctHEmYxSJLtmg4E6RwnYAOOonyG/OWiunyXCsv7l0YMbtxk
         FFiLStmuVhfqOD4nRXePmg33rDgkhxfEKBse9x0PAKsiyCQO1+x208lVfXsnwgKfWyS1
         HhIBvVEFz+mGT3Qdx3QkEcIfFLEiHz2BSWcMpcz2/z43xy9PA/QS5W2OnbWjoBne6CK+
         hql4JFuXceWIKP+O34L+ElNlZzKoe2HGANi6KfdHUujdmLGCS2aMr7ouKbsDBe96/3We
         b0C4ESmCPIstXLjLoytDuMus1COG6HNXX6U+iGPIoLn2zVZCzctbKN2u1+jx8P8GSE1z
         sSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o2wttqJnXSnC6uZPwQbYPo9kiCshXn3+hg9VUqJAS7M=;
        b=TO2Gs3i1dtVguqZdBbCT2RbZtytUlhIvtBV39G0/xeH0rUAFsV0UER4wIOCx0Fy3L9
         u6DfDbyUR6tj+uY/AMV0r8+jwtmcDCU/Juce9c13Pyyxv6mGlnfCbs45Wui+lZDyIclo
         8pPk0stKWrLEhwU7aJ+BxsWjsfldbq4ypyJ95MwMrNrL8VtI88zSMWHL9/oyRnXF65oS
         m/lrv2LuIZM4CuDis32zInXmc/eN73gdZjuI/A9CVdLHCkGgtmXZoFq8Sz11XXwGo9Cq
         gFrGsMLiinRFQ833FTS4j/tylWaplSxtkm03aGhaWL4b83QAbHIRgwdduXbej7d0wOrB
         Zn1g==
X-Gm-Message-State: ANoB5pnohU8OzZUl0xQvaZQNfeMvbNDgidYVeBKzKLx+TJzhzJzlAf4o
        24Hot+ni1nBfwYOT3lesjanArw==
X-Google-Smtp-Source: AA0mqf7ZKNStJWa0mWZO3bJ4kIF1ETNlGvcQZphUqWfvliInpXUyj1tpislQW3IoJFdPrnY5nyeH8Q==
X-Received: by 2002:adf:fac3:0:b0:22e:244d:687a with SMTP id a3-20020adffac3000000b0022e244d687amr8045877wrs.82.1668442607847;
        Mon, 14 Nov 2022 08:16:47 -0800 (PST)
Received: from zen.linaroharston ([185.81.254.11])
        by smtp.gmail.com with ESMTPSA id n18-20020a7bcbd2000000b003cf9bf5208esm18044922wmi.19.2022.11.14.08.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:16:46 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 9F2D91FFB7;
        Mon, 14 Nov 2022 16:16:45 +0000 (GMT)
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-3-chao.p.peng@linux.intel.com>
User-agent: mu4e 1.9.2; emacs 28.2.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 2/8] KVM: Extend the memslot to support fd-based
 private memory
Date:   Mon, 14 Nov 2022 16:04:59 +0000
In-reply-to: <20221025151344.3784230-3-chao.p.peng@linux.intel.com>
Message-ID: <877czxbjf6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Chao Peng <chao.p.peng@linux.intel.com> writes:

> In memory encryption usage, guest memory may be encrypted with special
> key and can be accessed only by the guest itself. We call such memory
> private memory. It's valueless and sometimes can cause problem to allow
> userspace to access guest private memory. This new KVM memslot extension
> allows guest private memory being provided though a restrictedmem
> backed file descriptor(fd) and userspace is restricted to access the
> bookmarked memory in the fd.
>
<snip>
> To make code maintenance easy, internally we use a binary compatible
> alias struct kvm_user_mem_region to handle both the normal and the
> '_ext' variants.

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 0d5d4419139a..f1ae45c10c94 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -103,6 +103,33 @@ struct kvm_userspace_memory_region {
>  	__u64 userspace_addr; /* start of the userspace allocated memory */
>  };
>=20=20
> +struct kvm_userspace_memory_region_ext {
> +	struct kvm_userspace_memory_region region;
> +	__u64 restricted_offset;
> +	__u32 restricted_fd;
> +	__u32 pad1;
> +	__u64 pad2[14];
> +};
> +
> +#ifdef __KERNEL__
> +/*
> + * kvm_user_mem_region is a kernel-only alias of kvm_userspace_memory_re=
gion_ext
> + * that "unpacks" kvm_userspace_memory_region so that KVM can directly a=
ccess
> + * all fields from the top-level "extended" region.
> + */
> +struct kvm_user_mem_region {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size;
> +	__u64 userspace_addr;
> +	__u64 restricted_offset;
> +	__u32 restricted_fd;
> +	__u32 pad1;
> +	__u64 pad2[14];
> +};
> +#endif

I'm not sure I buy the argument this makes the code maintenance easier
because you now have multiple places to update if you extend the field.
Was this simply to avoid changing:

  foo->slot to foo->region.slot

in the underlying code?

> +
>  /*
>   * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for usersp=
ace,
>   * other bits are reserved for kvm internal use which are defined in
> @@ -110,6 +137,7 @@ struct kvm_userspace_memory_region {
>   */
>  #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
>  #define KVM_MEM_READONLY	(1UL << 1)
> +#define KVM_MEM_PRIVATE		(1UL << 2)
>=20=20
>  /* for KVM_IRQ_LINE */
>  struct kvm_irq_level {
> @@ -1178,6 +1206,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_ZPCI_OP 221
>  #define KVM_CAP_S390_CPU_TOPOLOGY 222
>  #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
> +#define KVM_CAP_PRIVATE_MEM 224
>=20=20
>  #ifdef KVM_CAP_IRQ_ROUTING
>=20=20
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 800f9470e36b..9ff164c7e0cc 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -86,3 +86,6 @@ config KVM_XFER_TO_GUEST_WORK
>=20=20
>  config HAVE_KVM_PM_NOTIFIER
>         bool
> +
> +config HAVE_KVM_RESTRICTED_MEM
> +       bool
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e30f1b4ecfa5..8dace78a0278 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1526,7 +1526,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
>  	}
>  }
>=20=20
> -static int check_memory_region_flags(const struct kvm_userspace_memory_r=
egion *mem)
> +static int check_memory_region_flags(const struct kvm_user_mem_region *m=
em)
>  {
>  	u32 valid_flags =3D KVM_MEM_LOG_DIRTY_PAGES;
>=20=20
> @@ -1920,7 +1920,7 @@ static bool kvm_check_memslot_overlap(struct kvm_me=
mslots *slots, int id,
>   * Must be called holding kvm->slots_lock for write.
>   */
>  int __kvm_set_memory_region(struct kvm *kvm,
> -			    const struct kvm_userspace_memory_region *mem)
> +			    const struct kvm_user_mem_region *mem)
>  {
>  	struct kvm_memory_slot *old, *new;
>  	struct kvm_memslots *slots;
> @@ -2024,7 +2024,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
>=20=20
>  int kvm_set_memory_region(struct kvm *kvm,
> -			  const struct kvm_userspace_memory_region *mem)
> +			  const struct kvm_user_mem_region *mem)
>  {
>  	int r;
>=20=20
> @@ -2036,7 +2036,7 @@ int kvm_set_memory_region(struct kvm *kvm,
>  EXPORT_SYMBOL_GPL(kvm_set_memory_region);
>=20=20
>  static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
> -					  struct kvm_userspace_memory_region *mem)
> +					  struct kvm_user_mem_region *mem)
>  {
>  	if ((u16)mem->slot >=3D KVM_USER_MEM_SLOTS)
>  		return -EINVAL;
> @@ -4627,6 +4627,33 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *k=
vm)
>  	return fd;
>  }
>=20=20
> +#define SANITY_CHECK_MEM_REGION_FIELD(field)					\
> +do {										\
> +	BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=3D		\
> +		     offsetof(struct kvm_userspace_memory_region, field));	\
> +	BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) !=3D		\
> +		     sizeof_field(struct kvm_userspace_memory_region, field));	\
> +} while (0)
> +
> +#define SANITY_CHECK_MEM_REGION_EXT_FIELD(field)					\
> +do {											\
> +	BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=3D			\
> +		     offsetof(struct kvm_userspace_memory_region_ext, field));		\
> +	BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) !=3D			\
> +		     sizeof_field(struct kvm_userspace_memory_region_ext, field));	\
> +} while (0)
> +
> +static void kvm_sanity_check_user_mem_region_alias(void)
> +{
> +	SANITY_CHECK_MEM_REGION_FIELD(slot);
> +	SANITY_CHECK_MEM_REGION_FIELD(flags);
> +	SANITY_CHECK_MEM_REGION_FIELD(guest_phys_addr);
> +	SANITY_CHECK_MEM_REGION_FIELD(memory_size);
> +	SANITY_CHECK_MEM_REGION_FIELD(userspace_addr);
> +	SANITY_CHECK_MEM_REGION_EXT_FIELD(restricted_offset);
> +	SANITY_CHECK_MEM_REGION_EXT_FIELD(restricted_fd);
> +}

Do we have other examples in the kernel that jump these hoops?

>  static long kvm_vm_ioctl(struct file *filp,
>  			   unsigned int ioctl, unsigned long arg)
>  {
> @@ -4650,14 +4677,20 @@ static long kvm_vm_ioctl(struct file *filp,
>  		break;
>  	}
>  	case KVM_SET_USER_MEMORY_REGION: {
> -		struct kvm_userspace_memory_region kvm_userspace_mem;
> +		struct kvm_user_mem_region mem;
> +		unsigned long size =3D sizeof(struct kvm_userspace_memory_region);
> +
> +		kvm_sanity_check_user_mem_region_alias();
>=20=20
>  		r =3D -EFAULT;
> -		if (copy_from_user(&kvm_userspace_mem, argp,
> -						sizeof(kvm_userspace_mem)))
> +		if (copy_from_user(&mem, argp, size))
> +			goto out;
> +
> +		r =3D -EINVAL;
> +		if (mem.flags & KVM_MEM_PRIVATE)
>  			goto out;

Hmm I can see in the later code you explicitly check for the
KVM_MEM_PRIVATE flag with:

		if (get_user(flags, (u32 __user *)(argp + flags_offset)))
			goto out;

		if (flags & KVM_MEM_PRIVATE)
			size =3D sizeof(struct kvm_userspace_memory_region_ext);
		else
			size =3D sizeof(struct kvm_userspace_memory_region);

I think it would make sense to bring that sanity checking forward into
this patch to avoid the validation logic working in two different ways
over the series.

>=20=20
> -		r =3D kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
> +		r =3D kvm_vm_ioctl_set_memory_region(kvm, &mem);
>  		break;
>  	}
>  	case KVM_GET_DIRTY_LOG: {


--=20
Alex Benn=C3=A9e
