Return-Path: <linux-fsdevel+bounces-1720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0A7DDFCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C27328158D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A710A1F;
	Wed,  1 Nov 2023 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yN17iL/N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23E107BC
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 10:52:19 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BC818F
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 03:52:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41cbf31da84so42479811cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 03:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698835928; x=1699440728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1C51gwP1j6EX8xWamHNo0Nti+w4//VV3v7LQeJatAc=;
        b=yN17iL/NtYXNFxdA7kD75XpUtWLJzYPScw1VkdFte29lOZZFAunMkvokTPcjA69NnN
         NHxh2UTDFJ26X7BjAt53QVKfwKqSHqzT7Y1dgiGuut2nXL1gkRF2Jl4bma7mqWlrtazv
         V4mhhOMjopvQbsMccow+vNHXvWJWDfsjHs9d8BJmsD1DQiIX+/DkoWMPcFX8U8uBpvi+
         5E81fEN1KqCuq7OfcCCfxFhBxk/11ieQgLzpt9APa5RNkBtFNmk4jlA0+XsM/kAu7tbK
         vCLXtrccAc3L0J6nmmNH2o+ulE1w/BruqDA7knnRnrGayR05wXCpQzFQu35WL9nsjJL4
         o30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698835928; x=1699440728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1C51gwP1j6EX8xWamHNo0Nti+w4//VV3v7LQeJatAc=;
        b=tebltgKaS0RA+f9uvJ38Bs6qZnNfQd0BfT0SVrIwU5td/kLxD9uPyWLJqcStejC8zd
         Jm3xQ8CBnEwkKi4yxZ+1m16D+9ml1crbJRIF18Da2DSsoIk4PkIAYSWS4jkGKgPGFto/
         AqQbyZZMt1+2b5dPWqSVo9Cv+GRrFCj0uMG0Re3XhXzIfO59Ynx4EZm8VVdvXtWQIQpd
         BXtBBZr4Yf0oCExDcPIlTfez8H3FgV2BaajvYQtW1waWk9qt22gUECs3BA6m1xsEiygi
         9uf6jjpWP94R2l3xpaPs0z9hnAvTKKM7IMbk6Jj/spWNKpDAHBCozxKgtk0cMLlnqQAv
         Ajfw==
X-Gm-Message-State: AOJu0YzPY1ywnsqBCmZqV5dgV5vZeh1C6bpsR0qDdN0sxXybVp6OT21w
	iXZvH7Xv0JHEPU9s5wFd6PB99YpKNNKqkC0MubMNPA==
X-Google-Smtp-Source: AGHT+IGBD7AeuMGXkTRP2ep4CYUi9124TDOVpS389Mu+hB31XqL4gTKvstmlOGh29as6609/Xh60qBUoSzB28pjDL10=
X-Received: by 2002:a0c:d64a:0:b0:675:5111:4cec with SMTP id
 e10-20020a0cd64a000000b0067551114cecmr114725qvj.58.1698835928102; Wed, 01 Nov
 2023 03:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <CA+EHjTzj4drYKONVOLP19DYpJ4O8kSXcFzw2AKier1QdcFKx_Q@mail.gmail.com> <ZUF8A5KpwpA6IKUH@google.com>
In-Reply-To: <ZUF8A5KpwpA6IKUH@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 1 Nov 2023 10:51:31 +0000
Message-ID: <CA+EHjTwTT9cFzYTtwT43nLJS01Sgt0NqzUgKAnfo2fiV3tEvXg@mail.gmail.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
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

Hi Sean,

On Tue, Oct 31, 2023 at 10:13=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Tue, Oct 31, 2023, Fuad Tabba wrote:
> > Hi,
> >
> > On Fri, Oct 27, 2023 at 7:23=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> >
> > ...
> >
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/=
api.rst
> > > index e2252c748fd6..e82c69d5e755 100644
> > > --- a/Documentation/virt/kvm/api.rst
> > > +++ b/Documentation/virt/kvm/api.rst
> > > @@ -6079,6 +6079,15 @@ applied.
> > >  :Parameters: struct kvm_userspace_memory_region2 (in)
> > >  :Returns: 0 on success, -1 on error
> > >
> > > +KVM_SET_USER_MEMORY_REGION2 is an extension to KVM_SET_USER_MEMORY_R=
EGION that
> > > +allows mapping guest_memfd memory into a guest.  All fields shared w=
ith
> > > +KVM_SET_USER_MEMORY_REGION identically.  Userspace can set KVM_MEM_P=
RIVATE in
> > > +flags to have KVM bind the memory region to a given guest_memfd rang=
e of
> > > +[guest_memfd_offset, guest_memfd_offset + memory_size].  The target =
guest_memfd
> > > +must point at a file created via KVM_CREATE_GUEST_MEMFD on the curre=
nt VM, and
> > > +the target range must not be bound to any other memory region.  All =
standard
> > > +bounds checks apply (use common sense).
> > > +
> >
> > Bikeshedding here: Not sure if KVM_MEM_PRIVATE is the best name for
> > this. It gets confusing with KVM_MEMORY_ATTRIBUTE_PRIVATE, i.e., that
> > a region marked as KVM_MEM_PRIVATE is only potentially private. It did
> > confuse the rest of the team when I walked them through a previous
> > version of this code once. Would something like KVM_MEM_GUESTMEM make
> > more sense?
>
> Heh, deja vu.  We discussed this back in v7[*], and I came to the conclus=
ion that
> choosing a name that wasn't explicitly tied to private memory wasn't just=
ified.
> But that was before a KVM-owned guest_memfd was even an idea, and thus be=
fore we
> had anything close to a real use case.
>
> Since we now know that at least pKVM will use guest_memfd for shared memo=
ry, and
> odds are quite good that "regular" VMs will also do the same, i.e. will w=
ant
> guest_memfd with the concept of private memory, I agree that we should av=
oid
> PRIVATE.
>
> Though I vote for KVM_MEM_GUEST_MEMFD (or KVM_MEM_GUEST_MEMFD_VALID or
> KVM_MEM_USE_GUEST_MEMFD).  I.e. do our best to avoid ambiguity between re=
ferring
> to "guest memory" at-large and guest_memfd.

Yeah I remember that discussion, but I didn't realize how confusing it
was until I was presenting my work so far to the rest of the team, and
it confused them quite a bit. I'm happy with any of the other
alternatives that you suggest, as long as the distinction is clear.

> > > -See KVM_SET_USER_MEMORY_REGION.
> > > +A KVM_MEM_PRIVATE region _must_ have a valid guest_memfd (private me=
mory) and
> > > +userspace_addr (shared memory).  However, "valid" for userspace_addr=
 simply
> > > +means that the address itself must be a legal userspace address.  Th=
e backing
> > > +mapping for userspace_addr is not required to be valid/populated at =
the time of
> > > +KVM_SET_USER_MEMORY_REGION2, e.g. shared memory can be lazily mapped=
/allocated
> > > +on-demand.
> >
> > Regarding requiring that a private region have both a valid
> > guest_memfd and a userspace_addr, should this be
> > implementation-specific? In pKVM at least, all regions for protected
> > VMs are private, and KVM doesn't care about the host userspace address
> > for those regions even when part of the memory is shared.
>
> Hmm, as of this patch, no, because the pKVM usage doesn't exist.  E.g.
>
> .  Because this literally documents the current ABI.  When

Ack.

> > > +When mapping a gfn into the guest, KVM selects shared vs. private, i=
.e consumes
> > > +userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIB=
UTE_PRIVATE
> > > +state.  At VM creation time, all memory is shared, i.e. the PRIVATE =
attribute
> > > +is '0' for all gfns.  Userspace can control whether memory is shared=
/private by
> > > +toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES =
as needed.
> >
> > In pKVM, guest memory is private by default, and most of it will
> > remain so for the lifetime of the VM. Userspace could explicitly mark
> > all the guest's memory as private at initialization, but it would save
> > a slight amount of work. That said, I understand that it might be
> > better to be consistent across implementations.
>
> Yeah, we discussed this in v12[*].  The default really doesn't matter for=
 memory
> overheads or performances once supports range-based xarray entries, and i=
f that
> isn't sufficient, KVM can internally invert the polarity of PRIVATE.
>
> But for the ABI, I think we put a stake in the ground and say that all me=
mory is
> shared by default.  That way CoCo VMs and regular VMs (i.e VMs without th=
e concept
> of private memory) all have the same ABI.  Practically speaking, the cost=
 to pKVM
> (and likely every other CoCo VM type) is a single ioctl() during VM creat=
ion to
> "convert" all memory to private.
>
> [*] https://lore.kernel.org/all/ZRw6X2BptZnRPNK7@google.com

Ack.

...

> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 78a0b09ef2a5..5d1a2f1b4e94 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -798,7 +798,7 @@ void kvm_mmu_invalidate_range_add(struct kvm *kvm=
, gfn_t start, gfn_t end)
> > >         }
> > >  }
> > >
> > > -static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_=
range *range)
> > > +bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *=
range)
> > >  {
> > >         kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
> > >         return kvm_unmap_gfn_range(kvm, range);
> > > @@ -1034,6 +1034,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm=
_memory_slot *memslot)
> > >  /* This does not remove the slot from struct kvm_memslots data struc=
tures */
> > >  static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot=
 *slot)
> > >  {
> > > +       if (slot->flags & KVM_MEM_PRIVATE)
> > > +               kvm_gmem_unbind(slot);
> > > +
> >
> > Should this be called after kvm_arch_free_memslot()? Arch-specific ode
> > might need some of the data before the unbinding, something I thought
> > might be necessary at one point for the pKVM port when deleting a
> > memslot, but realized later that kvm_invalidate_memslot() ->
> > kvm_arch_guest_memory_reclaimed() was the more logical place for it.
> > Also, since that seems to be the pattern for arch-specific handlers in
> > KVM.
>
> Maybe?  But only if we can about symmetry between the allocation and free=
 paths
> I really don't think kvm_arch_free_memslot() should be doing anything bey=
ond a
> "pure" free.  E.g. kvm_arch_free_memslot() is also called after moving a =
memslot,
> which hopefully we never actually have to allow for guest_memfd, but any =
code in
> kvm_arch_free_memslot() would bring about "what if" questions regarding m=
emslot
> movement.  I.e. the API is intended to be a "free arch metadata associate=
d with
> the memslot".
>
> Out of curiosity, what does pKVM need to do at kvm_arch_guest_memory_recl=
aimed()?

It's about the host reclaiming ownership of guest memory when tearing
down a protected guest. In pKVM, we currently teardown the guest and
reclaim its memory when kvm_arch_destroy_vm() is called. The problem
with guestmem is that kvm_gmem_unbind() could get called before that
happens, after which the host might try to access the unbound guest
memory. Since the host hasn't reclaimed ownership of the guest memory
from hyp, hilarity ensues (it crashes).

Initially, I hooked reclaim guest memory to kvm_free_memslot(), but
then I needed to move the unbind later in the function. I realized
later that kvm_arch_guest_memory_reclaimed() gets called earlier (at
the right time), and is more aptly named.

Thanks,
/fuad

