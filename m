Return-Path: <linux-fsdevel+bounces-1731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DE17DE121
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 13:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAAE6B20AFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA212B9F;
	Wed,  1 Nov 2023 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v29IL5Vy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97A11CAC
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 12:52:00 +0000 (UTC)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321FEF7
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 05:51:56 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4a8737c4305so2751676e0c.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698843115; x=1699447915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3o84LhG/JDs4XT09LqOqAL557WR+kTbV5Toac0tgZE=;
        b=v29IL5VyU3B+aIfMrMdmbix8p5RVup/xW4vUd6RBnr33Bu8rfYh4G9v+WM1qpVJypq
         gUqbJSpQOqW37W/djoRJRIkKHZzIrcfejcAVmEP62zMyHDrCtUV8o5xm9kmK0A5uXqpN
         apJ1xeSyhmnijeGDVHeBGftbSrruIvUPi1PhaD+ZY5fJYApRylMJb9TK7eDjeoSvgGgS
         fGgQaVG7lCLuPpTDIcraWrc5yHng2VtxHRAKVcjqPT7wuVWgNcUO2wyZf05wsrfCjkOW
         LFomWquwgrI4aiqOJaMRYMEiqNFRO4P8TGYhaKNN5Qy9bJ5LxbPFHzUI5OiqEo5kfxQy
         2+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698843115; x=1699447915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3o84LhG/JDs4XT09LqOqAL557WR+kTbV5Toac0tgZE=;
        b=kBH4Sr2WB0pitsQjJdzsdf1q0U3yKwOFJMj7KdmdALyX7iV1LplJZsRHC/HvPBNOa/
         NdTugNaFIZ4IAmVYf42792UH3Jx8r6I+GmuMSS7HXsC5bQQNiJ9UHogRcLD6bb/+owuj
         wM7IJMJCL/h3T//zCqr3ZudDCRMsfRi1zf+woUL8/IeO5vWVjTQELUXh3DGHBI7Wl8C+
         Cvi8FdoqeS5YXqpBEs3C0gBgSiIcFrSKKRdamZGv7EkWa7E1o2YP+mNgYZqUVxIr1d0N
         KWl7BKDxoMqSmVEf7G5pJlaABvJmMJavuncYSBCMbSIDav3e4spigmgkDSpJ6dPmw9zH
         pqcg==
X-Gm-Message-State: AOJu0Yz8hrEYMKYHKhZJwvCBUIHtVY2IbixuHNT2ToAqbw1F9FIw9A/4
	x2E0GgOGkl4novBHeicYydUJwGD/IrVUB4Nh0ag1IA==
X-Google-Smtp-Source: AGHT+IF0GS509bXC109Q/KsllvKKbuNv6izlI+nfo857C1iROxiLKrI4wNuuGIZxmkDtH9Saf2Z2BbskHZJDaldFC6s=
X-Received: by 2002:a1f:9b13:0:b0:4a1:7278:3bf5 with SMTP id
 d19-20020a1f9b13000000b004a172783bf5mr13903007vke.4.1698843115068; Wed, 01
 Nov 2023 05:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-6-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-6-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 1 Nov 2023 12:51:19 +0000
Message-ID: <CA+EHjTxq9zBY02bqsThV5+afLY1mGXyfs+X1yiKL0kM8SSz_Ug@mail.gmail.com>
Subject: Re: [PATCH v13 05/35] KVM: PPC: Drop dead code related to KVM_ARCH_WANT_MMU_NOTIFIER
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
> Assert that both KVM_ARCH_WANT_MMU_NOTIFIER and CONFIG_MMU_NOTIFIER are
> defined when KVM is enabled, and return '1' unconditionally for the
> CONFIG_KVM_BOOK3S_HV_POSSIBLE=3Dn path.  All flavors of PPC support for K=
VM
> select MMU_NOTIFIER, and KVM_ARCH_WANT_MMU_NOTIFIER is unconditionally
> defined by arch/powerpc/include/asm/kvm_host.h.
>
> Effectively dropping use of KVM_ARCH_WANT_MMU_NOTIFIER will simplify a
> future cleanup to turn KVM_ARCH_WANT_MMU_NOTIFIER into a Kconfig, i.e.
> will allow combining all of the
>
>   #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>
> checks into a single
>
>   #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
>
> without having to worry about PPC's "bare" usage of
> KVM_ARCH_WANT_MMU_NOTIFIER.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/powerpc/kvm/powerpc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 7197c8256668..b0a512ede764 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -632,12 +632,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>                 break;
>  #endif
>         case KVM_CAP_SYNC_MMU:
> +#if !defined(CONFIG_MMU_NOTIFIER) || !defined(KVM_ARCH_WANT_MMU_NOTIFIER=
)
> +               BUILD_BUG();
> +#endif
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>                 r =3D hv_enabled;
> -#elif defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> -               r =3D 1;
>  #else
> -               r =3D 0;
> +               r =3D 1;
>  #endif
>                 break;
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> --
> 2.42.0.820.g83a721a137-goog
>

