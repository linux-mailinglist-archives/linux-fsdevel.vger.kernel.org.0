Return-Path: <linux-fsdevel+bounces-1672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD6E7DD815
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 23:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F81EB2115C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 22:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5727451;
	Tue, 31 Oct 2023 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4SA7wVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D62510A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 22:13:28 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B286ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:13:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da04fb79246so5935034276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698790405; x=1699395205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zs8biX5N196Q/2fqRFnHuCbiMBjZx3eWIMZhT9G5lkM=;
        b=W4SA7wVlgYnsfnyWjSbnqmpBT3IZj6Jx7AXEtfYfVIQhoN7WTdhE3pMY+qe3BqhbHJ
         k6acN/4Z7G4dEnyUrKxI7oOPqt1G/RWBDC+4b31xDnzvFGesPIRTsLEa+5wQiAzQJaRD
         aiNWuFgTFqDWS6XZZlXCuHY/STyjZ9MXi/sKT4clIttSE3NWh9YRRv8zMXxkmD3+OGXO
         09pJB8+Vwg2DVeJ4yWFe+gbtV3VySsZN2e95R9SwMUHohnN65GHe0yibjl+kKj/TUcH2
         1CV5aJlWTlPscX++P+sCga044G/3LJqwwcKsdgl5GrN+ylTD5bSKYtHFgYTZWJpNpubn
         02Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698790405; x=1699395205;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zs8biX5N196Q/2fqRFnHuCbiMBjZx3eWIMZhT9G5lkM=;
        b=jd9skl/xOs7swWuvborFlasqBSZl4SfNjhZ6DvmTi3munh1bsqd3xYWOJzNcqL6sgF
         90rY1D8ViYvipQm8YRlIhimWsikm3Nvgx2O5+Sqs3gHoMEQMkXz8oJEmxfoUW+6MdmXB
         VSCNHVf4vNIDpLNzboOslTodxXAninaRvuN5Xdif7nwlg7B+Icd/dF5HdtWzp4i7alr5
         qktf/tUmGG4x3OyYjoCt9uE6dQhjKZNexBfB0R608+e5EDZf2YxYxnrOrODEj9N25/ww
         Xb2vIFLaNkFR7VB9caO8OjJWgcNNxvlxn+PfaCaN3Uw7WJEcJPynRzZhVqoNqLs1sIFl
         Mrlw==
X-Gm-Message-State: AOJu0Ywc6d5TwrY6wsowZJQdXhGhu/ZlmsTVHsKMDEpt/Ux8T62jVHGT
	uw87eLqakIRhEcpMrqQTIdV9OwuQlD4=
X-Google-Smtp-Source: AGHT+IFQSb3cO99m4kmVkxpYDSR1DbV1n07kMYxpUGk3r7RnUdGfKSLZ2dTeiYGKN4sKIS0uvhtR25tzD1o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1746:b0:d9a:59cb:8bed with SMTP id
 bz6-20020a056902174600b00d9a59cb8bedmr238072ybb.5.1698790405257; Tue, 31 Oct
 2023 15:13:25 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:13:23 -0700
In-Reply-To: <CA+EHjTzj4drYKONVOLP19DYpJ4O8kSXcFzw2AKier1QdcFKx_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <CA+EHjTzj4drYKONVOLP19DYpJ4O8kSXcFzw2AKier1QdcFKx_Q@mail.gmail.com>
Message-ID: <ZUF8A5KpwpA6IKUH@google.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
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
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023, Fuad Tabba wrote:
> Hi,
>=20
> On Fri, Oct 27, 2023 at 7:23=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
>=20
> ...
>=20
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/ap=
i.rst
> > index e2252c748fd6..e82c69d5e755 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6079,6 +6079,15 @@ applied.
> >  :Parameters: struct kvm_userspace_memory_region2 (in)
> >  :Returns: 0 on success, -1 on error
> >
> > +KVM_SET_USER_MEMORY_REGION2 is an extension to KVM_SET_USER_MEMORY_REG=
ION that
> > +allows mapping guest_memfd memory into a guest.  All fields shared wit=
h
> > +KVM_SET_USER_MEMORY_REGION identically.  Userspace can set KVM_MEM_PRI=
VATE in
> > +flags to have KVM bind the memory region to a given guest_memfd range =
of
> > +[guest_memfd_offset, guest_memfd_offset + memory_size].  The target gu=
est_memfd
> > +must point at a file created via KVM_CREATE_GUEST_MEMFD on the current=
 VM, and
> > +the target range must not be bound to any other memory region.  All st=
andard
> > +bounds checks apply (use common sense).
> > +
>=20
> Bikeshedding here: Not sure if KVM_MEM_PRIVATE is the best name for
> this. It gets confusing with KVM_MEMORY_ATTRIBUTE_PRIVATE, i.e., that
> a region marked as KVM_MEM_PRIVATE is only potentially private. It did
> confuse the rest of the team when I walked them through a previous
> version of this code once. Would something like KVM_MEM_GUESTMEM make
> more sense?

Heh, deja vu.  We discussed this back in v7[*], and I came to the conclusio=
n that
choosing a name that wasn't explicitly tied to private memory wasn't justif=
ied.
But that was before a KVM-owned guest_memfd was even an idea, and thus befo=
re we
had anything close to a real use case.

Since we now know that at least pKVM will use guest_memfd for shared memory=
, and
odds are quite good that "regular" VMs will also do the same, i.e. will wan=
t
guest_memfd with the concept of private memory, I agree that we should avoi=
d
PRIVATE.

Though I vote for KVM_MEM_GUEST_MEMFD (or KVM_MEM_GUEST_MEMFD_VALID or
KVM_MEM_USE_GUEST_MEMFD).  I.e. do our best to avoid ambiguity between refe=
rring
to "guest memory" at-large and guest_memfd.

Copying a few relevant points from v7 to save a click or three.

 : I don't have a concrete use case (this is a recent idea on my end), but =
since we're
 : already adding fd-based memory, I can't think of a good reason not make =
it more generic
 : for not much extra cost.  And there are definitely classes of VMs for wh=
ich fd-based
 : memory would Just Work, e.g. large VMs that are never oversubscribed on =
memory don't
 : need to support reclaim, so the fact that fd-based memslots won't suppor=
t page aging
 : (among other things) right away is a non-issue.

...

 : Hrm, but basing private memory on top of a generic FD_VALID would effect=
ively require
 : shared memory to use hva-based memslots for confidential VMs.  That'd yi=
eld a very
 : weird API, e.g. non-confidential VMs could be backed entirely by fd-base=
d memslots,
 : but confidential VMs would be forced to use hva-based memslots.
 :=20
 : Ignore this idea for now.  If there's an actual use case for generic fd-=
based memory
 : then we'll want a separate flag, fd, and offset, i.e. that support could=
 be added
 : independent of KVM_MEM_PRIVATE.

...

 : One alternative would be to call it KVM_MEM_PROTECTED.  That shouldn't c=
ause
 : problems for the known use of "private" (TDX and SNP), and it gives us a=
 little
 : wiggle room, e.g. if we ever get a use case where VMs can share memory t=
hat is
 : otherwise protected.
 :=20
 : That's a pretty big "if" though, and odds are good we'd need more memslo=
t flags and
 : fd+offset pairs to allow differentiating "private" vs. "protected-shared=
" without
 : forcing userspace to punch holes in memslots, so I don't know that hedgi=
ng now will
 : buy us anything.
 :=20
 : So I'd say that if people think KVM_MEM_PRIVATE brings additional and me=
aningful
 : clarity over KVM_MEM_PROTECTECD, then lets go with PRIVATE.  But if PROT=
ECTED is
 : just as good, go with PROTECTED as it gives us a wee bit of wiggle room =
for the
 : future.

[*] https://lore.kernel.org/all/Yuh0ikhoh+tCK6VW@google.com
=20
> > -See KVM_SET_USER_MEMORY_REGION.
> > +A KVM_MEM_PRIVATE region _must_ have a valid guest_memfd (private memo=
ry) and
> > +userspace_addr (shared memory).  However, "valid" for userspace_addr s=
imply
> > +means that the address itself must be a legal userspace address.  The =
backing
> > +mapping for userspace_addr is not required to be valid/populated at th=
e time of
> > +KVM_SET_USER_MEMORY_REGION2, e.g. shared memory can be lazily mapped/a=
llocated
> > +on-demand.
>=20
> Regarding requiring that a private region have both a valid
> guest_memfd and a userspace_addr, should this be
> implementation-specific? In pKVM at least, all regions for protected
> VMs are private, and KVM doesn't care about the host userspace address
> for those regions even when part of the memory is shared.

Hmm, as of this patch, no, because the pKVM usage doesn't exist.  E.g.=20

.  Because this literally documents the current ABI.  When

> > +When mapping a gfn into the guest, KVM selects shared vs. private, i.e=
 consumes
> > +userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUT=
E_PRIVATE
> > +state.  At VM creation time, all memory is shared, i.e. the PRIVATE at=
tribute
> > +is '0' for all gfns.  Userspace can control whether memory is shared/p=
rivate by
> > +toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as=
 needed.
>=20
> In pKVM, guest memory is private by default, and most of it will
> remain so for the lifetime of the VM. Userspace could explicitly mark
> all the guest's memory as private at initialization, but it would save
> a slight amount of work. That said, I understand that it might be
> better to be consistent across implementations.

Yeah, we discussed this in v12[*].  The default really doesn't matter for m=
emory
overheads or performances once supports range-based xarray entries, and if =
that
isn't sufficient, KVM can internally invert the polarity of PRIVATE.

But for the ABI, I think we put a stake in the ground and say that all memo=
ry is
shared by default.  That way CoCo VMs and regular VMs (i.e VMs without the =
concept
of private memory) all have the same ABI.  Practically speaking, the cost t=
o pKVM
(and likely every other CoCo VM type) is a single ioctl() during VM creatio=
n to
"convert" all memory to private.

[*] https://lore.kernel.org/all/ZRw6X2BptZnRPNK7@google.com

> > --- /dev/null
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -0,0 +1,548 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/backing-dev.h>
> > +#include <linux/falloc.h>
> > +#include <linux/kvm_host.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/anon_inodes.h>
>=20
> nit: should this include be first (to maintain alphabetical ordering
> of the includes)?

Heh, yeah.  I would argue this isn't a nit though ;-)

> > +static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, lo=
ff_t len)
> > +{
> > +       struct list_head *gmem_list =3D &inode->i_mapping->private_list=
;
> > +       pgoff_t start =3D offset >> PAGE_SHIFT;
> > +       pgoff_t end =3D (offset + len) >> PAGE_SHIFT;
> > +       struct kvm_gmem *gmem;
> > +
> > +       /*
> > +        * Bindings must stable across invalidation to ensure the start=
+end
>=20
> nit: Bindings must _be/stay?_ stable

"be" is what's intended.

> ...
>=20
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 78a0b09ef2a5..5d1a2f1b4e94 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -798,7 +798,7 @@ void kvm_mmu_invalidate_range_add(struct kvm *kvm, =
gfn_t start, gfn_t end)
> >         }
> >  }
> >
> > -static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_ra=
nge *range)
> > +bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *ra=
nge)
> >  {
> >         kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
> >         return kvm_unmap_gfn_range(kvm, range);
> > @@ -1034,6 +1034,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm_m=
emory_slot *memslot)
> >  /* This does not remove the slot from struct kvm_memslots data structu=
res */
> >  static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *=
slot)
> >  {
> > +       if (slot->flags & KVM_MEM_PRIVATE)
> > +               kvm_gmem_unbind(slot);
> > +
>=20
> Should this be called after kvm_arch_free_memslot()? Arch-specific ode
> might need some of the data before the unbinding, something I thought
> might be necessary at one point for the pKVM port when deleting a
> memslot, but realized later that kvm_invalidate_memslot() ->
> kvm_arch_guest_memory_reclaimed() was the more logical place for it.
> Also, since that seems to be the pattern for arch-specific handlers in
> KVM.

Maybe?  But only if we can about symmetry between the allocation and free p=
aths
I really don't think kvm_arch_free_memslot() should be doing anything beyon=
d a
"pure" free.  E.g. kvm_arch_free_memslot() is also called after moving a me=
mslot,
which hopefully we never actually have to allow for guest_memfd, but any co=
de in
kvm_arch_free_memslot() would bring about "what if" questions regarding mem=
slot
movement.  I.e. the API is intended to be a "free arch metadata associated =
with
the memslot".

Out of curiosity, what does pKVM need to do at kvm_arch_guest_memory_reclai=
med()?

