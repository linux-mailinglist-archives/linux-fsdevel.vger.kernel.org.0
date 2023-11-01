Return-Path: <linux-fsdevel+bounces-1737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F487DE1C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 14:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECD1B21116
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBC5134D3;
	Wed,  1 Nov 2023 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jL3WY9bu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C95134C6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 13:49:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18285A2
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698846595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nWuZfMltD4ivs2KoMTFabKsH4/GDdWsbpvxlt/w2Uk=;
	b=jL3WY9buMvcmSLWYW8VSR+Yzmz3v/6tr0hdtjTAehz4PwjdPhpur56l4p6kZedMQZd2G92
	KoeFoTkAwZARXMScnVviyF+D5ZDVBGmkze5if+aufAK0wO8L5Eq3ynYm01uLBKg+heOri9
	ig/m+JUsrNkva4s0E6KzPF5cUxB64uk=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-M9teFoHeNiWBZf6nVVHufQ-1; Wed, 01 Nov 2023 09:49:53 -0400
X-MC-Unique: M9teFoHeNiWBZf6nVVHufQ-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-457cd8cf4e6so2351564137.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 06:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698846593; x=1699451393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nWuZfMltD4ivs2KoMTFabKsH4/GDdWsbpvxlt/w2Uk=;
        b=fZrB5GgQVzSG0YndaYZj3a9aA0qFSrrMSr5ZsLLC/EftT1SgNIScCjPqQRByGjQZ7u
         cyujSSZavlNuuZh8yFXOtSPW2jGveJJdShjh73OK8eJRdAAxYIccmbFWnu2mloIN2afL
         vMzKrd5C3+T6OjisxVXPUrFHXgdySFoB/2DtStYD09r2oUpkU8YqsLEexnpKqHcBal2g
         kPEEgjh153hi1QyFW6MxHkoJ0XHpnlZbbKXashaVGovazmZlqspEkWE848SQx45wgf53
         GQUkbJ/MMwtrWoPvWqyKWTUaSXm7xgSKoLK1FvT6MmuYW0Duq2knLochP4JaOVz5Vjuy
         WGjw==
X-Gm-Message-State: AOJu0Yx64B7h3jtwdJY2ttyDNHACLeGA3hdVJiv4RFmCDluQu8iwivO1
	5LXBQkRKr2v3VW/Wx9yp+pkeXETGmkF5RAbA1BxttoVXjYS70L/Hlrp+wE0xw8T4FJ+sIMgx7YM
	kLZ7DnuxAsGGgy45UKhzcw3Q07fy0kOCBGRSyHGKULQ==
X-Received: by 2002:a67:a20b:0:b0:45b:529:cffb with SMTP id l11-20020a67a20b000000b0045b0529cffbmr13944631vse.27.1698846593176;
        Wed, 01 Nov 2023 06:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwXCml3dQ0y1Cr/jFjux1lHGIWg//wB9GtnyXEiXbtExQlCwIylI67p1IY3V8uopiP51EusJ56Du+cgZSOAjo=
X-Received: by 2002:a67:a20b:0:b0:45b:529:cffb with SMTP id
 l11-20020a67a20b000000b0045b0529cffbmr13944598vse.27.1698846592873; Wed, 01
 Nov 2023 06:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-18-seanjc@google.com>
 <7c0844d8-6f97-4904-a140-abeabeb552c1@intel.com> <ZUEML6oJXDCFJ9fg@google.com>
 <92ba7ddd-2bc8-4a8d-bd67-d6614b21914f@intel.com> <ZUJVfCkIYYFp5VwG@google.com>
In-Reply-To: <ZUJVfCkIYYFp5VwG@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 1 Nov 2023 14:49:40 +0100
Message-ID: <CABgObfaw4Byuzj5J3k48jdwT0HCKXLJNiuaA9H8Dtg+GOq==Sw@mail.gmail.com>
Subject: Re: [PATCH v13 17/35] KVM: Add transparent hugepage support for
 dedicated guest memory
To: Sean Christopherson <seanjc@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Marc Zyngier <maz@kernel.org>, 
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
	Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Maciej Szmigiero <mail@maciej.szmigiero.name>, 
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>, 
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 2:41=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Nov 01, 2023, Xiaoyao Li wrote:
> > On 10/31/2023 10:16 PM, Sean Christopherson wrote:
> > > On Tue, Oct 31, 2023, Xiaoyao Li wrote:
> > > > On 10/28/2023 2:21 AM, Sean Christopherson wrote:
> > > > > Extended guest_memfd to allow backing guest memory with transpare=
nt
> > > > > hugepages. Require userspace to opt-in via a flag even though the=
re's no
> > > > > known/anticipated use case for forcing small pages as THP is opti=
onal,
> > > > > i.e. to avoid ending up in a situation where userspace is unaware=
 that
> > > > > KVM can't provide hugepages.
> > > >
> > > > Personally, it seems not so "transparent" if requiring userspace to=
 opt-in.
> > > >
> > > > People need to 1) check if the kernel built with TRANSPARENT_HUGEPA=
GE
> > > > support, or check is the sysfs of transparent hugepage exists; 2)ge=
t the
> > > > maximum support hugepage size 3) ensure the size satisfies the alig=
nment;
> > > > before opt-in it.
> > > >
> > > > Even simpler, userspace can blindly try to create guest memfd with
> > > > transparent hugapage flag. If getting error, fallback to create wit=
hout the
> > > > transparent hugepage flag.
> > > >
> > > > However, it doesn't look transparent to me.
> > >
> > > The "transparent" part is referring to the underlying kernel mechanis=
m, it's not
> > > saying anything about the API.  The "transparent" part of THP is that=
 the kernel
> > > doesn't guarantee hugepages, i.e. whether or not hugepages are actual=
ly used is
> > > (mostly) transparent to userspace.
> > >
> > > Paolo also isn't the biggest fan[*], but there are also downsides to =
always
> > > allowing hugepages, e.g. silent failure due to lack of THP or unalign=
ed size,
> > > and there's precedent in the form of MADV_HUGEPAGE.
> > >
> > > [*] https://lore.kernel.org/all/84a908ae-04c7-51c7-c9a8-119e1933a189@=
redhat.com
> >
> > But it's different than MADV_HUGEPAGE, in a way. Per my understanding, =
the
> > failure of MADV_HUGEPAGE is not fatal, user space can ignore it and
> > continue.
> >
> > However, the failure of KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is fatal, which =
leads
> > to failure of guest memfd creation.
>
> Failing KVM_CREATE_GUEST_MEMFD isn't truly fatal, it just requires differ=
ent
> action from userspace, i.e. instead of ignoring the error, userspace coul=
d redo
> KVM_CREATE_GUEST_MEMFD with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE=3D0.
>
> We could make the behavior more like MADV_HUGEPAGE, e.g. theoretically we=
 could
> extend fadvise() with FADV_HUGEPAGE, or add a guest_memfd knob/ioctl() to=
 let
> userspace provide advice/hints after creating a guest_memfd.  But I suspe=
ct that
> guest_memfd would be the only user of FADV_HUGEPAGE, and IMO a post-creat=
ion hint
> is actually less desirable.
>
> KVM_GUEST_MEMFD_ALLOW_HUGEPAGE will fail only if userspace didn't provide=
 a
> compatible size or the kernel doesn't support THP.  An incompatible size =
is likely
> a userspace bug, and for most setups that want to utilize guest_memfd, la=
ck of THP
> support is likely a configuration bug.  I.e. many/most uses *want* failur=
es due to
> KVM_GUEST_MEMFD_ALLOW_HUGEPAGE to be fatal.
>
> > For current implementation, I think maybe KVM_GUEST_MEMFD_DESIRE_HUGEPA=
GE
> > fits better than KVM_GUEST_MEMFD_ALLOW_HUGEPAGE? or maybe *PREFER*?
>
> Why?  Verbs like "prefer" and "desire" aren't a good fit IMO because they=
 suggest
> the flag is a hint, and hints are usually best effort only, i.e. are igno=
red if
> there is a fundamental incompatibility.
>
> "Allow" isn't perfect, e.g. I would much prefer a straight KVM_GUEST_MEMF=
D_USE_HUGEPAGES
> or KVM_GUEST_MEMFD_HUGEPAGES flag, but I wanted the name to convey that K=
VM doesn't
> (yet) guarantee hugepages.  I.e. KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is strong=
er than
> a hint, but weaker than a requirement.  And if/when KVM supports a dedica=
ted memory
> pool of some kind, then we can add KVM_GUEST_MEMFD_REQUIRE_HUGEPAGE.

I think that the current patch is fine, but I will adjust it to always
allow the flag,
and to make the size check even if !CONFIG_TRANSPARENT_HUGEPAGE.
If hugepages are not guaranteed, and (theoretically) you could have no
hugepage at all in the result, it's okay to get this result even if THP is =
not
available in the kernel.

Paolo


