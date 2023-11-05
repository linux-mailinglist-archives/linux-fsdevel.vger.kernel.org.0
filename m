Return-Path: <linux-fsdevel+bounces-1991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B67B7E1487
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCA01C20A2F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BBB156EF;
	Sun,  5 Nov 2023 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qs3HRrP3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FD156D0
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:19:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8703DB0
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699201191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5S45DCFEET4FUlleAs+X25SSP8exRtkoxGaiIZR36AY=;
	b=Qs3HRrP3qIhpoKM72TcYby7LjkynOYF2uGUiYgOpf4cM1NTdPhrht9wGz/KnO3gBjJxfUq
	mza5kadjnoQ8KRXMz4halkRbOGmF7JZQRnmEXEipVlcbqxqYJs2bJ/KxI1kMpBJJetCEJF
	dDxtT0VknqS2ie5C9oxIB6gY14EdZkk=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-wlnilJp1NEma5nkwy8asxg-1; Sun, 05 Nov 2023 11:19:50 -0500
X-MC-Unique: wlnilJp1NEma5nkwy8asxg-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4ac2ffa81f1so312121e0c.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Nov 2023 08:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699201190; x=1699805990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S45DCFEET4FUlleAs+X25SSP8exRtkoxGaiIZR36AY=;
        b=M0X69NIH6/JivoK1z2maMDCiz4pBRuDkQ8E6HJpQy0lQNqHD4pSFpXaIv7p21aAUH4
         Kpf6DCVp5PlI+V3N0kW+M67baTWng1ghGOJ4Ta061WmpZuM7JDkorZqkZ2Qlh1X0ACXd
         n+f2mFtGzt/G3HQlTk3WzPksRxQCfJwPiriETlP+aAMsnODHgPr5JKhMYgkyfVp+cLfR
         /bMfCyD7BClLZm4QY680X3QWstGUKNRnCZzqrLDo77XK/Pdej87iM5McPfOUfd/ZidqM
         QGAnfZCE5mgUOWlz68PPORJwEX+xYwz/xlJIC5/XAry7UXCtSVyXNCg6RHEy35OmCCQq
         t9tA==
X-Gm-Message-State: AOJu0YxcLjEY8pCYxmtsWK/M52hbgPJ/HMvc5kqc9an8vSWLzTCG7MxL
	qsJpZ4tl028/a2AGetJ2evH73QP9pozM1Z2XK7yB+LJFXQroi3Qef5XZgmpI9w0mTcgTLr6Ns9N
	lwZr8xDbHUIW/Wc3Wbio1cBRCvn3IBE3lpNKVhRO5YQ==
X-Received: by 2002:a05:6102:4743:b0:45d:8f83:e10f with SMTP id ej3-20020a056102474300b0045d8f83e10fmr5351471vsb.4.1699201189792;
        Sun, 05 Nov 2023 08:19:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9PY/ps/exIZhJtEiBPcrHL5I4MFvN3fWtoZJg4K/o1jMHEXmGlTLfpUZIUzDcxTZUf1dOb3c60KPU/ucxafo=
X-Received: by 2002:a05:6102:4743:b0:45d:8f83:e10f with SMTP id
 ej3-20020a056102474300b0045d8f83e10fmr5351461vsb.4.1699201189503; Sun, 05 Nov
 2023 08:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-21-seanjc@google.com>
 <ZUeSaAKRemlSRQpO@yilunxu-OptiPlex-7050>
In-Reply-To: <ZUeSaAKRemlSRQpO@yilunxu-OptiPlex-7050>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 5 Nov 2023 17:19:36 +0100
Message-ID: <CABgObfb1Wf2ptitGhJPM6VcmkCG9haMoQj2BsttjeoV=9F0O9Q@mail.gmail.com>
Subject: Re: [PATCH v13 20/35] KVM: x86/mmu: Handle page fault for private memory
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
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
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Anish Moorthy <amoorthy@google.com>, David Matlack <dmatlack@google.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Maciej Szmigiero <mail@maciej.szmigiero.name>, 
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>, 
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 2:04=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com> =
wrote:
>
> > +static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> > +                                           struct kvm_page_fault *faul=
t)
> > +{
> > +     kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> > +                                   PAGE_SIZE, fault->write, fault->exe=
c,
> > +                                   fault->is_private);
> > +}
> > +
> > +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> > +                                struct kvm_page_fault *fault)
> > +{
> > +     int max_order, r;
> > +
> > +     if (!kvm_slot_can_be_private(fault->slot)) {
> > +             kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > +             return -EFAULT;
> > +     }
> > +
> > +     r =3D kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault=
->pfn,
> > +                          &max_order);
> > +     if (r) {
> > +             kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > +             return r;
>
> Why report KVM_EXIT_MEMORY_FAULT here? even with a ret !=3D -EFAULT?

The cases are EFAULT, EHWPOISON (which can report
KVM_EXIT_MEMORY_FAULT) and ENOMEM. I think it's fine
that even -ENOMEM can return KVM_EXIT_MEMORY_FAULT,
and it doesn't violate the documentation.  The docs tell you "what
can you do if error if EFAULT or EHWPOISON?"; they don't
exclude that other errnos result in KVM_EXIT_MEMORY_FAULT,
it's just that you're not supposed to look at it

Paolo


