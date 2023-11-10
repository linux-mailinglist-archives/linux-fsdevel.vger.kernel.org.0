Return-Path: <linux-fsdevel+bounces-2736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AB37E8136
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 19:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9773528107F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDC33A298;
	Fri, 10 Nov 2023 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgceUlkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF73A287
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 18:25:23 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31BAE9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 10:23:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a8ee6a1801so31710997b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699640581; x=1700245381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/u2JG0fndtvz5StB0AokXkOquj7NpP7M8gj3x0QBG2E=;
        b=kgceUlkFOWL5vxm8J4T3HW8CRJFhtUvNgQXZKG4NmhXHIykYFzOaH8R9t4BX7h6pcY
         HnAGZDCjGPnos9hZqCDNV2l+emmhngiroS8qEFh+3weIBlUqS8XO242R4Zqy5ed49D/h
         NAPXdCh011lwe3rpaMDBRWEQX1l7Z72wrQHpfKPLgk+HfW3rUsb0oX81O+V4HvUFf3+J
         wa3wUoXgZf34b9iEXEEW9pJ76Rsj7Z1eFHQx5FB+ycxOuz1YOUa3cKpaFeuSRuBEQCyf
         UU/rQZF+3oHacw25Ju4lyFult928U9vxNrPknXhgKTa4DoZ612/rCj4I5S8HYrEEEt4L
         cPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699640581; x=1700245381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/u2JG0fndtvz5StB0AokXkOquj7NpP7M8gj3x0QBG2E=;
        b=X9I4dLuDl7QK4BJLbV9ukALsO24EfaRWV3828cjjGDFqT+RIbTSvbVi6SoQ+A938g8
         78XWHnxdgvX9oKjIXC3cYRInaQVGmQOw6h3YodjDX6mhE24SBBxMEBuF8iMScYAJMc5/
         LCwNHfqY4U/bAr5JzlqcmV3TD4czHOXE6lClK7yDezXzgiLwhCd95WL0/SO8cq9Xs1gb
         KY3cfled5DEPnAljhaIj+ADo2zYY/vTmDxuEftX7xDaNniRTafDyienBzLjCRJZzz9dL
         SXjhnKBc7FHfulDHMWwZvtB829ubvRoni331IQsnKtVLJt9Cz1oMYAvSfXTe9+Zg1/Bm
         bA9g==
X-Gm-Message-State: AOJu0Yx9jdVlgYQmAZ5MpYl5BsGEINWperSZ1diNYhYsryT36g0EdlPx
	Z0lbTM86zguOZdrrcplLPiM1py8p0DI=
X-Google-Smtp-Source: AGHT+IFilgu1/Q1EZiEoL3sTFYKCQfnhtgAeMBBAfAGcs6DHfZF6Y3nZ5EepLJy80XYZ0ZRT2keQkzxRdJY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ef0c:0:b0:5be:ae71:d70a with SMTP id
 o12-20020a81ef0c000000b005beae71d70amr242444ywm.4.1699640580898; Fri, 10 Nov
 2023 10:23:00 -0800 (PST)
Date: Fri, 10 Nov 2023 10:22:59 -0800
In-Reply-To: <956d8ee3-8b63-4a2d-b0c4-c0d3d74a0f6f@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-16-pbonzini@redhat.com>
 <956d8ee3-8b63-4a2d-b0c4-c0d3d74a0f6f@intel.com>
Message-ID: <ZU51A3U6E3aZXayC@google.com>
Subject: Re: [PATCH 15/34] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
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
	linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>, 
	David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 10, 2023, Xiaoyao Li wrote:
> On 11/6/2023 12:30 AM, Paolo Bonzini wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 68a144cb7dbc..a6de526c0426 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -589,8 +589,20 @@ struct kvm_memory_slot {
> >   	u32 flags;
> >   	short id;
> >   	u16 as_id;
> > +
> > +#ifdef CONFIG_KVM_PRIVATE_MEM
> > +	struct {
> > +		struct file __rcu *file;
> > +		pgoff_t pgoff;
> > +	} gmem;
> > +#endif
> >   };
> > +static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
> > +{
> > +	return slot && (slot->flags & KVM_MEM_GUEST_MEMFD);
> > +}
> > +
> 
> maybe we can move this block and ...
> 
> <snip>
> 
> > @@ -2355,6 +2379,30 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
> >   					struct kvm_gfn_range *range);
> >   bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> >   					 struct kvm_gfn_range *range);
> > +
> > +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +{
> > +	return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM) &&
> > +	       kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> > +}
> > +#else
> > +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +{
> > +	return false;
> > +}
> >   #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
> 
> this block to Patch 18?

It would work, but my vote is to keep them here to minimize the changes to common
KVM code in the x86 enabling.  It's not a strong preference though.  Of course,
at this point, fiddling with this sort of thing is probably a bad idea in terms
of landing guest_memfd.

> > @@ -4844,6 +4875,10 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> >   #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> >   	case KVM_CAP_MEMORY_ATTRIBUTES:
> >   		return kvm_supported_mem_attributes(kvm);
> > +#endif
> > +#ifdef CONFIG_KVM_PRIVATE_MEM
> > +	case KVM_CAP_GUEST_MEMFD:
> > +		return !kvm || kvm_arch_has_private_mem(kvm);
> >   #endif
> >   	default:
> >   		break;
> > @@ -5277,6 +5312,18 @@ static long kvm_vm_ioctl(struct file *filp,
> >   	case KVM_GET_STATS_FD:
> >   		r = kvm_vm_ioctl_get_stats_fd(kvm);
> >   		break;
> > +#ifdef CONFIG_KVM_PRIVATE_MEM
> > +	case KVM_CREATE_GUEST_MEMFD: {
> > +		struct kvm_create_guest_memfd guest_memfd;
> 
> Do we need a guard of below?
> 
> 		r = -EINVAL;
> 		if (!kvm_arch_has_private_mem(kvm))
> 			goto out;

Argh, yeah, that's weird since KVM_CAP_GUEST_MEMFD says "not supported" if the
VM doesn't support private memory.

Enforcing that would break guest_memfd_test.c though.  And having to create a
"special" VM just to test basic guest_memfd functionality would be quite
annoying.

So my vote is to do:

	case KVM_CAP_GUEST_MEMFD:
		return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM);

There's no harm to KVM if userspace creates a file it can't use, and at some
point KVM will hopefully support guest_memfd irrespective of private memory.

