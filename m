Return-Path: <linux-fsdevel+bounces-1749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB7A7DE4A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A671C20DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A914A99;
	Wed,  1 Nov 2023 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yuFCX/+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE111CBB
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 16:36:04 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A52410F
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 09:36:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso7620142276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698856562; x=1699461362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azJu2Dh8gujl5qnxyYwo1n6krfiG0RwudOI1y5vnuB4=;
        b=yuFCX/+hNdCQoExuPOLtehV1sJV5YXuIC4dK84hnQsWhPdH2Z3iLN7bxdeMtxGj+WB
         cyzEaD66/7stT4SYcguXXwRhJjsUPKJnPLc7tlAGTT6QQ7U8Hc2NurenL8NF3eoKj+4P
         RfWTVWvFfkqVD2gRfDU09y5lBFNvzjzueEpuaO2xsVY5I4+kSjoC83fBVUIBnh3QJaL8
         RsG8orHK+MB9w4bObQ/9WLURAj4uIVelYqCRJKbCGCOjf013V/nSWEedtPb+5hmOsFjL
         r6GSwII+CK6XrhP83YYhH3pshpbwSDDI4qB9CrX5BKhf+VGh0py3HXKrLZViwVuSh4mC
         zYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856562; x=1699461362;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azJu2Dh8gujl5qnxyYwo1n6krfiG0RwudOI1y5vnuB4=;
        b=EKAqPTur/fEnj9eTwXcgMLL/62bz8tYJ++AZBEmAY0swL3tOkA33mfsoLOsVgxgSLs
         rlpGidpRka8hS7AS+g9VC7KY7vrNVWjCaQFMQfJYYiKm+m1Hhiz7KVdSfOgovEKzHATM
         hpFFTbwwr46nXw690X4PTsJwMNUwZFvHsT4Tp2Go8epGF9dOX0yVoCCkBjLsb9lkJiCo
         n9jATcoNUwRaW12EiHBF8B3TJr2rcesHWRkUHo5GnD6c4Mb978cqtJ65Bn6dou3Usk8K
         Rq1zIBBBj+sKzK6S+rdjuIj7DIQ7Mg07rr9IHcENeKCj7zxHP+cmqsnsMhc0cB9CSI6F
         2/8g==
X-Gm-Message-State: AOJu0YxO7S1M7xDsumiz2eicSe5uECn0Y5cWSFjXwkPe/ydV67QjlK/t
	+4QsdDjkTNzrPDV7CnJg6jgDyYxBKTU=
X-Google-Smtp-Source: AGHT+IFqCABorYKmfCmJZy/oBSeOXTtnBU+krovHVjWnvhFIdm8AwbTMBJoMdfZ9FR5pLbycY5bTrtHt4Z4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:770f:0:b0:da0:73c2:db78 with SMTP id
 s15-20020a25770f000000b00da073c2db78mr326876ybc.9.1698856562473; Wed, 01 Nov
 2023 09:36:02 -0700 (PDT)
Date: Wed, 1 Nov 2023 09:36:00 -0700
In-Reply-To: <CABgObfaw4Byuzj5J3k48jdwT0HCKXLJNiuaA9H8Dtg+GOq==Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-18-seanjc@google.com>
 <7c0844d8-6f97-4904-a140-abeabeb552c1@intel.com> <ZUEML6oJXDCFJ9fg@google.com>
 <92ba7ddd-2bc8-4a8d-bd67-d6614b21914f@intel.com> <ZUJVfCkIYYFp5VwG@google.com>
 <CABgObfaw4Byuzj5J3k48jdwT0HCKXLJNiuaA9H8Dtg+GOq==Sw@mail.gmail.com>
Message-ID: <ZUJ-cJfofk2d_I0B@google.com>
Subject: Re: [PATCH v13 17/35] KVM: Add transparent hugepage support for
 dedicated guest memory
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
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
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023, Paolo Bonzini wrote:
> On Wed, Nov 1, 2023 at 2:41=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Wed, Nov 01, 2023, Xiaoyao Li wrote:
> > > On 10/31/2023 10:16 PM, Sean Christopherson wrote:
> > > > On Tue, Oct 31, 2023, Xiaoyao Li wrote:
> > > > > On 10/28/2023 2:21 AM, Sean Christopherson wrote:
> > > But it's different than MADV_HUGEPAGE, in a way. Per my understanding=
, the
> > > failure of MADV_HUGEPAGE is not fatal, user space can ignore it and
> > > continue.
> > >
> > > However, the failure of KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is fatal, whic=
h leads
> > > to failure of guest memfd creation.
> >
> > Failing KVM_CREATE_GUEST_MEMFD isn't truly fatal, it just requires diff=
erent
> > action from userspace, i.e. instead of ignoring the error, userspace co=
uld redo
> > KVM_CREATE_GUEST_MEMFD with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE=3D0.
> >
> > We could make the behavior more like MADV_HUGEPAGE, e.g. theoretically =
we could
> > extend fadvise() with FADV_HUGEPAGE, or add a guest_memfd knob/ioctl() =
to let
> > userspace provide advice/hints after creating a guest_memfd.  But I sus=
pect that
> > guest_memfd would be the only user of FADV_HUGEPAGE, and IMO a post-cre=
ation hint
> > is actually less desirable.
> >
> > KVM_GUEST_MEMFD_ALLOW_HUGEPAGE will fail only if userspace didn't provi=
de a
> > compatible size or the kernel doesn't support THP.  An incompatible siz=
e is likely
> > a userspace bug, and for most setups that want to utilize guest_memfd, =
lack of THP
> > support is likely a configuration bug.  I.e. many/most uses *want* fail=
ures due to
> > KVM_GUEST_MEMFD_ALLOW_HUGEPAGE to be fatal.
> >
> > > For current implementation, I think maybe KVM_GUEST_MEMFD_DESIRE_HUGE=
PAGE
> > > fits better than KVM_GUEST_MEMFD_ALLOW_HUGEPAGE? or maybe *PREFER*?
> >
> > Why?  Verbs like "prefer" and "desire" aren't a good fit IMO because th=
ey suggest
> > the flag is a hint, and hints are usually best effort only, i.e. are ig=
nored if
> > there is a fundamental incompatibility.
> >
> > "Allow" isn't perfect, e.g. I would much prefer a straight KVM_GUEST_ME=
MFD_USE_HUGEPAGES
> > or KVM_GUEST_MEMFD_HUGEPAGES flag, but I wanted the name to convey that=
 KVM doesn't
> > (yet) guarantee hugepages.  I.e. KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is stro=
nger than
> > a hint, but weaker than a requirement.  And if/when KVM supports a dedi=
cated memory
> > pool of some kind, then we can add KVM_GUEST_MEMFD_REQUIRE_HUGEPAGE.
>=20
> I think that the current patch is fine, but I will adjust it to always
> allow the flag, and to make the size check even if !CONFIG_TRANSPARENT_HU=
GEPAGE.
> If hugepages are not guaranteed, and (theoretically) you could have no
> hugepage at all in the result, it's okay to get this result even if THP i=
s not
> available in the kernel.

Can you post a fixup patch?  It's not clear to me exactly what behavior you=
 intend
to end up with.

