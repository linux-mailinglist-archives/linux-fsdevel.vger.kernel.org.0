Return-Path: <linux-fsdevel+bounces-1769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137647DE7BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 22:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121081C20E1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BE81BDD6;
	Wed,  1 Nov 2023 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yordn67/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B91B299
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 21:55:50 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF23123
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 14:55:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da04fb79246so290028276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698875748; x=1699480548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcqXHpLnYUoCfOstmB/gusaSnz1wSaaIZvticgi9YrM=;
        b=yordn67/B9coJ27wikY+cNB1RREF7cB4b3Ue4KVs4bUxR7NMszr2uB6DsTcvRFezm4
         Mv9vIV4D1zL7Ebq8eYUvDJaTsA+b6DbfwYGOyfYZ+gn6JBg2zh32vssNDt0PgQWyi3Hc
         V30xoKLPHpSqs3H12W5kHbw59Cp3oq89IhbOXGRukrdOHcIips6mw6fvttACqcV26Iao
         o3OJKk/xvzHC16DLzD0pyWC3byA8iAor+alj9Jl/Ez2piZBXn5OAsYe77vVBVgD3KaOP
         Uo0at9aIB4srFmOFz36vXvyhDqsKT+KVB/6JAS3Kq2OtaQ1RroksSDGcgJr8iz7Y9trj
         xkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698875748; x=1699480548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcqXHpLnYUoCfOstmB/gusaSnz1wSaaIZvticgi9YrM=;
        b=NyzxNayNnWGjdNj4mpBFYA0ZAZj5r5KFWTeZXbVSzs4O1EnjfngndAZ/b800iqonJg
         IUTrtVIcK+kQWkzi0B72QI1S+RGFLVDG7RqEUPDk/ofQV+3FPWli44V53JRAqf0+ZIhS
         UaIxjSgs3S7iGSWcJSjPhaIgKj/XDgrBVdrBkw8IYC8ngAoHFR4gjRK1yKcFP1BZczat
         CM1q5uYZJwwylmwSmFSZ7Xgwt3rr5JsSpl1w2rzvahDkK4orj5z59hPsjC0aVj5bA5KI
         /b7l63aui90OA3hiiCpY2nkf5O2Z7xDbdw+zbPaktgPXyaswi2BL9CdqNGG1wxg8FXta
         XbRQ==
X-Gm-Message-State: AOJu0YxMIQol8y/9l77j7VVnk9hObpdse7mHe1c7MDjROS+D1ka5aUMT
	lvMhUHodI/38FxLOG1ek7YVnukBuxvI=
X-Google-Smtp-Source: AGHT+IE2sMY2tsOG0bVHgm+pvNoyezNqlGkOo8OmSBoeRdI+YDBZP5bgBr5ffHZ4bVc102IwBIrDYpGpUa8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP id
 v3-20020a056902108300b00d9ac3b84274mr405001ybu.7.1698875748263; Wed, 01 Nov
 2023 14:55:48 -0700 (PDT)
Date: Wed, 1 Nov 2023 14:55:46 -0700
In-Reply-To: <CA+EHjTwTT9cFzYTtwT43nLJS01Sgt0NqzUgKAnfo2fiV3tEvXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <CA+EHjTzj4drYKONVOLP19DYpJ4O8kSXcFzw2AKier1QdcFKx_Q@mail.gmail.com>
 <ZUF8A5KpwpA6IKUH@google.com> <CA+EHjTwTT9cFzYTtwT43nLJS01Sgt0NqzUgKAnfo2fiV3tEvXg@mail.gmail.com>
Message-ID: <ZULJYg5cf1UrNq3e@google.com>
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
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 01, 2023, Fuad Tabba wrote:
> > > > @@ -1034,6 +1034,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
> > > >  /* This does not remove the slot from struct kvm_memslots data structures */
> > > >  static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
> > > >  {
> > > > +       if (slot->flags & KVM_MEM_PRIVATE)
> > > > +               kvm_gmem_unbind(slot);
> > > > +
> > >
> > > Should this be called after kvm_arch_free_memslot()? Arch-specific ode
> > > might need some of the data before the unbinding, something I thought
> > > might be necessary at one point for the pKVM port when deleting a
> > > memslot, but realized later that kvm_invalidate_memslot() ->
> > > kvm_arch_guest_memory_reclaimed() was the more logical place for it.
> > > Also, since that seems to be the pattern for arch-specific handlers in
> > > KVM.
> >
> > Maybe?  But only if we can about symmetry between the allocation and free paths
> > I really don't think kvm_arch_free_memslot() should be doing anything beyond a
> > "pure" free.  E.g. kvm_arch_free_memslot() is also called after moving a memslot,
> > which hopefully we never actually have to allow for guest_memfd, but any code in
> > kvm_arch_free_memslot() would bring about "what if" questions regarding memslot
> > movement.  I.e. the API is intended to be a "free arch metadata associated with
> > the memslot".
> >
> > Out of curiosity, what does pKVM need to do at kvm_arch_guest_memory_reclaimed()?
> 
> It's about the host reclaiming ownership of guest memory when tearing
> down a protected guest. In pKVM, we currently teardown the guest and
> reclaim its memory when kvm_arch_destroy_vm() is called. The problem
> with guestmem is that kvm_gmem_unbind() could get called before that
> happens, after which the host might try to access the unbound guest
> memory. Since the host hasn't reclaimed ownership of the guest memory
> from hyp, hilarity ensues (it crashes).
> 
> Initially, I hooked reclaim guest memory to kvm_free_memslot(), but
> then I needed to move the unbind later in the function. I realized
> later that kvm_arch_guest_memory_reclaimed() gets called earlier (at
> the right time), and is more aptly named.

Aha!  I suspected that might be the case.

TDX and SNP also need to solve the same problem of "reclaiming" memory before it
can be safely accessed by the host.  The plan is to add an arch hook (or two?)
into guest_memfd that is invoked when memory is freed from guest_memfd.

Hooking kvm_arch_guest_memory_reclaimed() isn't completely correct as deleting a
memslot doesn't *guarantee* that guest memory is actually reclaimed (which reminds
me, we need to figure out a better name for that thing before introducing
kvm_arch_gmem_invalidate()).

The effective false positives aren't fatal for the current usage because the hook
is used only for x86 SEV guests to flush caches.  An unnecessary flush can cause
performance issues, but it doesn't affect correctness. For TDX and SNP, and IIUC
pKVM, false positives are fatal because KVM could assign memory back to the host
that is still owned by guest_memfd.

E.g. a misbehaving userspace could prematurely delete a memslot.  And the more
fun example is intrahost migration, where the plan is to allow pointing multiple
guest_memfd files at a single guest_memfd inode:
https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com

There was a lot of discussion for this, but it's scattered all over the place.
The TL;DR is is that the inode will represent physical memory, and a file will
represent a given "struct kvm" instance's view of that memory.  And so the memory
isn't reclaimed until the inode is truncated/punched.

I _think_ this reflects the most recent plan from the guest_memfd side:
https://lore.kernel.org/all/1233d749211c08d51f9ca5d427938d47f008af1f.1689893403.git.isaku.yamahata@intel.com

