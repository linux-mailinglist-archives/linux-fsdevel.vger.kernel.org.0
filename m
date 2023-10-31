Return-Path: <linux-fsdevel+bounces-1668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0E7DD7CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 22:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25D91F21877
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A724A06;
	Tue, 31 Oct 2023 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPTQTo4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3BA249ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 21:36:41 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816A2C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 14:36:39 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc5ef7e815so15926625ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698788199; x=1699392999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwUJsYeIlwqw805rRX9kqL0ratglmWsD95jLONcl2+Q=;
        b=vPTQTo4+Lbze4ruoqvra7qc16oGm5+RnY3vtIOlUyWdbMZKdohUG34DqMmDD1ROoTK
         tFhKZY9gFy4uAD49KfZCbRJd6JTNCwRKaUYf+GE4HHdILp51xOM2fu73R5CkCWmdbHOj
         7EvZXgciFKycMEyS1QIANIRo7+Dtljxj1COHbhI4M+RxBX893PsrTlX8KbUeX9QFrdE5
         W9WeYB2rvox2W3e2B8BrsA/CqwSGeixVpBpifZ8X5U3JFyoP8RUhbNoRo2LYD+LWDwli
         02Yh6PlBVp+lL/auqu0+l2jKaav9YP7cE43MbnUIe/k6YJJ1oMBTdYKqJtvmcgyPHIML
         QCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698788199; x=1699392999;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qwUJsYeIlwqw805rRX9kqL0ratglmWsD95jLONcl2+Q=;
        b=lcjxGWHYbB2EfyQPyX0WEhIAiYbOqJHE6eIMR956V6ZWD1bLLaojJgQ861gPIhROHF
         anRYlTYIn31ls0odh7gRUasWFVbY6m+rfjQe+/nYoNgNzW6lbcMAVCWBlxGyenchLZQk
         XmO7DfEcsYAbi37vp+oqDc4lctdloQjYGzRUJ7Rc9HPpQSnhh2N43ZaWHeLrsv3jA+q2
         XHY/Mx8cPAucv/RHibak8ebP/9h6iQUnDWlnZX8/pC3hyDaF949VyG0j6Looh95zNfKG
         9XaqiojFyylFqRA2xvML+rokCl1vPdghDW/KxTgHDkJdL6x429niIQp3kFovBfqZHRcO
         sbFA==
X-Gm-Message-State: AOJu0YznOR00oCt10eQcBtKunCzN7pMub1CynGht/770S/l914L2vKVF
	3n4aNzyMoRTbYZAwDROvuQ/1QGcC/lU=
X-Google-Smtp-Source: AGHT+IErbOn1a7ghsHO7PXtEmrexZ1Aq9PA/AfhJ0FeZy4uT6qmhxk4RVfIH9rjSv+2WH3z2AoAxZzd2jeI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2609:b0:1b8:8c7:31e6 with SMTP id
 jd9-20020a170903260900b001b808c731e6mr249399plb.1.1698788199022; Tue, 31 Oct
 2023 14:36:39 -0700 (PDT)
Date: Tue, 31 Oct 2023 14:36:37 -0700
In-Reply-To: <ZUFGRyQEuWj4RJS0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <ZUFGRyQEuWj4RJS0@google.com>
Message-ID: <ZUFzZf-YmCRYP6qo@google.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
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
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Anish Moorthy <amoorthy@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023, David Matlack wrote:
> On 2023-10-27 11:21 AM, Sean Christopherson wrote:
> > Introduce an ioctl(), KVM_CREATE_GUEST_MEMFD, to allow creating file-ba=
sed
> > memory that is tied to a specific KVM virtual machine and whose primary
> > purpose is to serve guest memory.
> >=20
> > A guest-first memory subsystem allows for optimizations and enhancement=
s
> > that are kludgy or outright infeasible to implement/support in a generi=
c
> > memory subsystem.  With guest_memfd, guest protections and mapping size=
s
> > are fully decoupled from host userspace mappings.   E.g. KVM currently
> > doesn't support mapping memory as writable in the guest without it also
> > being writable in host userspace, as KVM's ABI uses VMA protections to
> > define the allow guest protection.  Userspace can fudge this by
> > establishing two mappings, a writable mapping for the guest and readabl=
e
> > one for itself, but that=E2=80=99s suboptimal on multiple fronts.
> >=20
> > Similarly, KVM currently requires the guest mapping size to be a strict
> > subset of the host userspace mapping size, e.g. KVM doesn=E2=80=99t sup=
port
> > creating a 1GiB guest mapping unless userspace also has a 1GiB guest
> > mapping.  Decoupling the mappings sizes would allow userspace to precis=
ely
> > map only what is needed without impacting guest performance, e.g. to
> > harden against unintentional accesses to guest memory.
> >=20
> > Decoupling guest and userspace mappings may also allow for a cleaner
> > alternative to high-granularity mappings for HugeTLB, which has reached=
 a
> > bit of an impasse and is unlikely to ever be merged.
> >=20
> > A guest-first memory subsystem also provides clearer line of sight to
> > things like a dedicated memory pool (for slice-of-hardware VMs) and
> > elimination of "struct page" (for offload setups where userspace _never=
_
> > needs to mmap() guest memory).
>=20
> All of these use-cases involve using guest_memfd for shared pages, but
> this entire series sets up KVM to only use guest_memfd for private
> pages.
>=20
> For example, the per-page attributes are a property of a KVM VM, not the
> underlying guest_memfd. So that implies we will need separate
> guest_memfds for private and shared pages. But a given memslot can have
> a mix of private and shared pages. So that implies a memslot will need
> to support 2 guest_memfds?

Yes, someday this may be true.  Allowing guest_memfd (it was probably calle=
d
something else at that point) for "regular" memory was discussed in I think=
 v10?
We made a concious decision to defer supporting 2 guest_memfds because it i=
sn't strictly
necessary to support the TDX/SNP use cases for which all of this was initia=
lly
designed, and adding a second guest_memfd and the infrastructure needed to =
let
userspace map a guest_memfd can be done on top with minimal overhead.

> But the UAPI only allows 1 and uses the HVA for shared mappings.
>=20
> My initial reaction after reading through this series is that the
> per-page private/shared should be a property of the guest_memfd, not the
> VM. Maybe it would even be cleaner in the long-run to make all memory
> attributes a property of the guest_memfd. That way we can scope the
> support to only guest_memfds and not have to worry about making per-page
> attributes work with "legacy" HVA-based memslots.

Making the private vs. shared state a property of the guest_memfd doesn't w=
ork
for TDX and SNP.  We (upstream x86 and KVM maintainers) have taken a hard s=
tance
that in-place conversion will not be allowed for TDX/SNP due to the ease wi=
th
which a misbehaving userspace and/or guest can crash the host.

We'd also be betting that there would *never* be a use case for per-gfn att=
ributes
for non-standard memory, e.g. virtio-gpu buffers, any kind of device memory=
, etc.

We'd also effectively be signing up to either support swap and page migrati=
on in
guest_memfd, or make those mutually exclusive with per-gfn attributes too.

guest_memfd is only intended for guest DRAM, and if I get my way, will neve=
r support
swap (page migration is less scary).  I.e. guest_memfd isn't intended to be=
 a
one-size-fits-all solution, nor is it intended to wholesale replace memslot=
s,
which is effectively what we'd be doing by deprecating hva-based guest memo=
ry.

And ignoring all that, the ABI would end up being rather bizarre due to way=
 guest_memfd
interacts with memslots.  guest_memfd itself has no real notion of gfns, i.=
e. the
shared vs. private state would be tied to a file offset, not a gfn.  That's=
 a solvable
problem, e.g. we could make a gfn:offset binding "sticky", but that would e=
dd extra
complexity to the ABI, and AFAICT wouldn't buy us that much, if anything.

> Maybe can you sketch out how you see this proposal being extensible to
> using guest_memfd for shared mappings?

For in-place conversions, e.g. pKVM, no additional guest_memfd is needed.  =
What's
missing there is the ability to (safely) mmap() guest_memfd, e.g. KVM needs=
 to
ensure there are no outstanding references when converting back to private.

For TDX/SNP, assuming we don't find a performant and robust way to do in-pl=
ace
conversions, a second fd+offset pair would be needed.

