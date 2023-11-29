Return-Path: <linux-fsdevel+bounces-4283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931D77FE4EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 01:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2112822D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 00:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049577F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 00:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKOG9J8P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E212F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 14:40:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d10f5bf5d9so5714807b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 14:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701297621; x=1701902421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDVeTl61QPCCxPz+sfODK89nbVJMVG6TQMGABDOMFAw=;
        b=LKOG9J8P+mG4QldxEixU4nB2idYJM4SeHhEBhDVj3jmhJ59aFXkmpxvJcXp3YziOws
         EJKHbDMRlvEQoEjUjtTkHHwvcG62eRT9QSgeQ+1jS0CNOdxvfcHcIoQKdXTHSaamRxea
         gKYqm2bD416nXJLK6oA9yXijCi5RGoR1J8dG5QnBx+u285lvHiu6LoM56deEONAiDvQe
         LA9r5U8SDDZxAOVfj/ODtx/M7sSy+rndBdxLxCmhJkUZWtJIbiPsDDMqEf0wLjiVBcDM
         tIaj64/4ziykuu49iGmyY9nDWR8+ltDTxsiF7vwSQMuTwiX8tIRdRxkmvICKSVGHtERU
         Z8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297621; x=1701902421;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LDVeTl61QPCCxPz+sfODK89nbVJMVG6TQMGABDOMFAw=;
        b=RFwD+93bwAEiEJ6C5H20jdZPVP9EzpduycvM3OFyKWzNr0HfgAuO8l+ejuT9XqytmI
         4JjFGnBL/dqWCCLJ4iRlI3BsX1rhGq+1TR7alXs082SIC1BcoZ539KxFwbRhRXPsdrxC
         0SoydzDSznve8NN3SMwO9tBlKB1WPZm3TCPfVeauYreKi5iLEJOuwsjOsOg1fm/7zAx4
         1lB4FU1qMr2kkGUyRbubSLh/jA7auYJMkMVb56TDfcixqniETpHnyrGctZWYKTFhJPys
         xjBcvBNhA4POWI1wudE+SNgTDCdsgjCGC7MeOm/IU/3ZO0zoJSsuuOKWudHBnJM5asEW
         Xo7g==
X-Gm-Message-State: AOJu0Yyt/E6s5QoWNwkKJiIqKzO66EPD7hDU+1g+nOa2j78mIrovNwhp
	H7cYrIrNPete1uLxmqC30d9Skttr1Og=
X-Google-Smtp-Source: AGHT+IH9RxzmajTLifcNJivXHXF15GYt6RNI6hyz68HWdvvEFKxSVfujRMym9vZDynLvRqNw698SRRht3dY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:842:b0:5cc:cd5e:8f0e with SMTP id
 bz2-20020a05690c084200b005cccd5e8f0emr592433ywb.0.1701297621195; Wed, 29 Nov
 2023 14:40:21 -0800 (PST)
Date: Wed, 29 Nov 2023 14:40:19 -0800
In-Reply-To: <81628606-ca9b-866f-5e71-91001e856871@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <92ba7ddd-2bc8-4a8d-bd67-d6614b21914f@intel.com>
 <ZUJVfCkIYYFp5VwG@google.com> <CABgObfaw4Byuzj5J3k48jdwT0HCKXLJNiuaA9H8Dtg+GOq==Sw@mail.gmail.com>
 <ZUJ-cJfofk2d_I0B@google.com> <4ca2253d-276f-43c5-8e9f-0ded5d5b2779@redhat.com>
 <ZULSkilO-tdgDGyT@google.com> <CABgObfbq_Hg0B=jvsSDqYH3CSpX+RsxfwB-Tc-eYF4uq2Qw9cg@mail.gmail.com>
 <ZUPCWfO1iO77-KDA@google.com> <CABgObfa=DH7FySBviF63OS9sVog_wt-AqYgtUAGKqnY5Bizivw@mail.gmail.com>
 <81628606-ca9b-866f-5e71-91001e856871@suse.cz>
Message-ID: <ZWe90784ek9VvHa5@google.com>
Subject: Re: [PATCH v13 17/35] KVM: Add transparent hugepage support for
 dedicated guest memory
From: Sean Christopherson <seanjc@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>, 
	David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Maciej Szmigiero <mail@maciej.szmigiero.name>, 
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>, 
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023, Vlastimil Babka wrote:
> On 11/2/23 16:46, Paolo Bonzini wrote:
> > On Thu, Nov 2, 2023 at 4:38=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >> Actually, looking that this again, there's not actually a hard depende=
ncy on THP.
> >> A THP-enabled kernel _probably_  gives a higher probability of using h=
ugepages,
> >> but mostly because THP selects COMPACTION, and I suppose because using=
 THP for
> >> other allocations reduces overall fragmentation.
> >=20
> > Yes, that's why I didn't even bother enabling it unless THP is
> > enabled, but it makes even more sense to just try.
> >=20
> >> So rather than honor KVM_GUEST_MEMFD_ALLOW_HUGEPAGE iff THP is enabled=
, I think
> >> we should do the below (I verified KVM can create hugepages with THP=
=3Dn).  We'll
> >> need another capability, but (a) we probably should have that anyways =
and (b) it
> >> provides a cleaner path to adding PUD-sized hugepage support in the fu=
ture.
> >=20
> > I wonder if we need KVM_CAP_GUEST_MEMFD_HUGEPAGE_PMD_SIZE though. This
> > should be a generic kernel API and in fact the sizes are available in
> > a not-so-friendly format in /sys/kernel/mm/hugepages.
> >=20
> > We should just add /sys/kernel/mm/hugepages/sizes that contains
> > "2097152 1073741824" on x86 (only the former if 1G pages are not
> > supported).
> >=20
> > Plus: is this the best API if we need something else for 1G pages?
> >=20
> > Let's drop *this* patch and proceed incrementally. (Again, this is
> > what I want to do with this final review: identify places that are
> > stil sticky, and don't let them block the rest).
> >=20
> > Coincidentially we have an open spot next week at plumbers. Let's
> > extend Fuad's section to cover more guestmem work.
>=20
> Hi,
>=20
> was there any outcome wrt this one?

No, we punted on hugepage support for the initial guest_memfd merge.  We de=
finitely
plan on adding hugeapge support sooner than later, but we haven't yet agree=
d on
exactly what that will look like.

> Based on my experience with THP's it would be best if userspace didn't ha=
ve
> to opt-in, nor care about the supported size. If the given size is unalig=
ned,
> provide a mix of large pages up to an aligned size, and for the rest fall=
back
> to base pages, which should be better than -EINVAL on creation (is it
> possible with the current implementation? I'd hope so so?).

guest_memfd serves a different use case than THP.  For modern VMs, and espe=
cially
for slice-of-hardware VMs that are one of the main targets for guest_memfd,=
 if not
_the_ main target, guest memory should _always_ be backed by hugepages in t=
he
physical domain.  The actual guest mappings might not be huge, e.g. x86 nee=
ds to
do partial mappings to skip over (legacy) memory holes, but KVM already gra=
cefully
handles that.

In other words, for most guest_memfd use cases, if userspace wants hugepage=
s but
KVM can't provide hugepages, then it is much more desirable to return an er=
ror
than to silently fall back to small pages.

I 100% agree that having to opt-in is suboptimal, but IMO providing "error =
on an
incompatible configuration" semantics without requiring userspace to opt-in=
 is an
even worse experience for userspace.

> A way to opt-out from huge pages could be useful although there's always =
the
> risk of some initial troubles resulting in various online sources cargo-c=
ult
> recommending to opt-out forever.

