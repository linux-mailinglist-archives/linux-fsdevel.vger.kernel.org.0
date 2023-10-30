Return-Path: <linux-fsdevel+bounces-1555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAF47DBE6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 18:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF038B20DF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3821944C;
	Mon, 30 Oct 2023 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1hEpY+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7841C02
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 17:01:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957EAAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698685272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySiJbXtvuo/ap347BrtctuG5UsffPvyxiWszBOWPpzU=;
	b=O1hEpY+Nsw3YnwC9YPe33jZP0yOrDsmkuEtsJQXpJC1QpblIJYJ9vlZKyckjXSvYTPlswW
	tWld99ZZcUtFTCZni9tkpD4Fb6wKrwpIJyEfQGv2wV90z9QBeRK1NsCUSMjvjKBj5wiuZ+
	4rGx6y+cxnjcylbdatz6jXQTEMNngRs=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-6ZSrbGMnNvyf66T7NpiT2A-1; Mon, 30 Oct 2023 13:01:06 -0400
X-MC-Unique: 6ZSrbGMnNvyf66T7NpiT2A-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e9f6006f9cso6468163fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 10:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698685266; x=1699290066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySiJbXtvuo/ap347BrtctuG5UsffPvyxiWszBOWPpzU=;
        b=w505VLsSPe1rucN+vB521U5+B6nbGEZzmX0ukFWqdhUGlYJzLQnaCLAR3WvLbgaQ9o
         NG6MREhV3BZ9gmfYlwLI/EeLiNQxf2cfoztctqHbkUT4LH8wwxxlBImLvhEOBN1+orlc
         niJkmbdYoN6slyPRNL5ZM2jicquvxlGwGsXmerrG7XPkNbuYCADNgEcj6peGo1+3mrYD
         5H5E46hQXkmauYHYFzQ/u+LgUuH9e6RjuVeLXFyq1fy4X8FSL5PLDwatwIc4k/gIjChr
         +NxMp2bY5W0mY8x41i6vxE6HGmOthNSwmhVwesJmiz5t7t8G9Ibc0YXiLaPUgewxeY/j
         CQHg==
X-Gm-Message-State: AOJu0YwSXXN6XVOfbYiwdAmqxkibNkk3YqFOF12GgjAYhwXWLpMZJ9sv
	Z6+XHoJ+Q2XGN2rWXDN4/BtROcwm2RpZO5C+djOCDIKAd9o4Weq6G3d1wPMn1w2dch7+J4q3ovm
	qIdzCpW+PWWIAmE46G/y8HHZdUzttF/gE7RQk49TXeg==
X-Received: by 2002:a05:6871:5c45:b0:1ea:3f79:defb with SMTP id os5-20020a0568715c4500b001ea3f79defbmr14807550oac.52.1698685265964;
        Mon, 30 Oct 2023 10:01:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExUXzp0cSzQuFI/AWzKwhXt4UU+QvY8z/fyApz/M7sPoBiF5GZjJ7SszJVxAGAXDpAW5+AxTqFEaHAzsc1Bic=
X-Received: by 2002:a05:6871:5c45:b0:1ea:3f79:defb with SMTP id
 os5-20020a0568715c4500b001ea3f79defbmr14807416oac.52.1698685264406; Mon, 30
 Oct 2023 10:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-4-seanjc@google.com>
 <ZT_fnAcDAvuPCwws@google.com>
In-Reply-To: <ZT_fnAcDAvuPCwws@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Oct 2023 18:00:49 +0100
Message-ID: <CABgObfYM4nyb1K3xJVGvV+eQmZoLPAmz2-=1CG8++pCwvVW7Qg@mail.gmail.com>
Subject: Re: [PATCH v13 03/35] KVM: Use gfn instead of hva for mmu_notifier_retry
To: David Matlack <dmatlack@google.com>
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
	Anish Moorthy <amoorthy@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Maciej Szmigiero <mail@maciej.szmigiero.name>, 
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>, 
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 5:53=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2023-10-27 11:21 AM, Sean Christopherson wrote:
> > From: Chao Peng <chao.p.peng@linux.intel.com>
> >
> > Currently in mmu_notifier invalidate path, hva range is recorded and
> > then checked against by mmu_notifier_retry_hva() in the page fault
> > handling path. However, for the to be introduced private memory, a page
>                           ^^^^^^^^^^^^^^^^^^^^^^^^
>
> Is there a missing word here?

No but there could be missing hyphens ("for the to-be-introduced
private memory"); possibly a "soon" could help parsing and that is
what you were talking about?

> >       if (likely(kvm->mmu_invalidate_in_progress =3D=3D 1)) {
> > +             kvm->mmu_invalidate_range_start =3D INVALID_GPA;
> > +             kvm->mmu_invalidate_range_end =3D INVALID_GPA;
>
> I don't think this is incorrect, but I was a little suprised to see this
> here rather than in end() when mmu_invalidate_in_progress decrements to
> 0.

I think that would be incorrect on the very first start?

> > +     }
> > +}
> > +
> > +void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t =
end)
> > +{
> > +     lockdep_assert_held_write(&kvm->mmu_lock);
>
> Does this compile/function on KVM architectures with
> !KVM_HAVE_MMU_RWLOCK?

Yes:

#define lockdep_assert_held_write(l)    \
        lockdep_assert(lockdep_is_held_type(l, 0))

where 0 is the lock-held type used by lock_acquire_exclusive. In turn
is what you get for a spinlock or mutex, in addition to a rwlock or
rwsem that is taken for write.

Instead, lockdep_assert_held() asserts that the lock is taken without
asserting a particular lock-held type.

> > @@ -834,6 +851,12 @@ void kvm_mmu_invalidate_end(struct kvm *kvm, unsig=
ned long start,
>
> Let's add a lockdep_assert_held_write(&kvm->mmu_lock) here too while
> we're at it?

Yes, good idea.

Paolo


