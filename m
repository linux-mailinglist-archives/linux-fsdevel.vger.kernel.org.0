Return-Path: <linux-fsdevel+bounces-1834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D1A7DF533
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E9FB21396
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778431C29C;
	Thu,  2 Nov 2023 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyhmBDZP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5661BDE6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:36:16 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D2186
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:36:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-777719639adso57853185a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698935773; x=1699540573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGQNRc9zE40ysVevY/WGU/Lu6W4371YJar5QqeiLOSY=;
        b=hyhmBDZP/FH1NQ1CnlAGSiygV2gJrwpH7BGVAbQJAQcL2N4U8BO8Fo/09dEQL4EvlC
         dart+z8obIgWwK5GWLrAl9/IRFYbTxlB7FMfMEdThFsm1J+z6m26G8t+zok3fRATp0A7
         vFegvMIL6Qw9aa6h/bcmDou5sUDII5tk7AJUXc7kgrvXxiFW5T/rNZE2W/O4bwa6fIih
         77NfWyNx8HN9dCe5FEE5Ao9xegwrGlisbnN6uIil88e+FDFtkYCidpr8z2anS05kUEU8
         rsSScaHN3rhVZye2+hKSTgIpFOT5IjkEhBK/J+O8lcaYT19DeBDy4fjsfDebeYmBFUo4
         L32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935773; x=1699540573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGQNRc9zE40ysVevY/WGU/Lu6W4371YJar5QqeiLOSY=;
        b=KLn1oCgZKh4I+y47dVhWfwjroPyHFkF0AI7kuvHmdqJFtb2UYqDfTn/pCeO06rXMHM
         dRHlZXs13mVzkrDecb2VD3SsoabLoYRdj6eq5txZR1F6TTIj/bKYYECH4/bz5WWHajDe
         fL1zjWaK4uIcaZMFJyDvrneI8KOn5IXMlugTcasI0wS4JjTGKwo13a9AULRcGvlS9dqY
         B298LacyF2Lh3fo3vg2xUpkWM5MhckjsIEx5X0veEw1NFIRSxUFTM/M+KdVi4JuFNdKY
         lI9qIpWMnzc58t/qZI0U7e5prnTK+KVlwlLvCOfJkjyL7wDKnX2vlrnRf1hDBkai7W2w
         6EHA==
X-Gm-Message-State: AOJu0YxjoADeNCewd9D6EC5DxV6FkHb1LHnUJbcE4KNqMJsupiAlnmu0
	qQNS3UA0Eu6GBpIJVnsHm99on2kqO+pVbfHVQyPbEQ==
X-Google-Smtp-Source: AGHT+IG3zQONLtNNLFCBisiqnyb2KBBdAZoBcVXn8ZKHSOcO4zLCu8vZ+2T5E0OEe4jyHp5mk0SJgyrOfTeARfH9hlY=
X-Received: by 2002:a05:6214:242e:b0:66d:a90f:c06 with SMTP id
 gy14-20020a056214242e00b0066da90f0c06mr22425828qvb.14.1698935773112; Thu, 02
 Nov 2023 07:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-22-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-22-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 2 Nov 2023 14:35:36 +0000
Message-ID: <CA+EHjTzk0=24wGbxQUApAY4B-K3xO3+SOfLn1tPJk-hVJY0+GQ@mail.gmail.com>
Subject: Re: [PATCH v13 21/35] KVM: Drop superfluous __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
 macro
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
> Drop __KVM_VCPU_MULTIPLE_ADDRESS_SPACE and instead check the value of
> KVM_ADDRESS_SPACE_NUM.
>
> No functional change intended.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/x86/include/asm/kvm_host.h | 1 -
>  include/linux/kvm_host.h        | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 8d60e4745e8b..6702f795c862 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2124,7 +2124,6 @@ enum {
>  #define HF_SMM_MASK            (1 << 1)
>  #define HF_SMM_INSIDE_NMI_MASK (1 << 2)
>
> -# define __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
>  # define KVM_ADDRESS_SPACE_NUM 2
>  # define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_M=
ASK ? 1 : 0)
>  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role=
).smm)
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e3223cafd7db..c3cfe08b1300 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -692,7 +692,7 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm);
>  #define KVM_MEM_SLOTS_NUM SHRT_MAX
>  #define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_INTERNAL_MEM_SLOTS)
>
> -#ifndef __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
> +#if KVM_ADDRESS_SPACE_NUM =3D=3D 1
>  static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>  {
>         return 0;
> --
> 2.42.0.820.g83a721a137-goog
>

