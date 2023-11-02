Return-Path: <linux-fsdevel+bounces-1826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD47DF455
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61705281C5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7519F1DA4F;
	Thu,  2 Nov 2023 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAr5ZI3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB81DA32
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 13:53:04 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952AA186
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 06:53:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77896da2118so51942285a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698933180; x=1699537980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MiH+OD80Lz6N2WkoQWVzzSH5wdFrVwABmyWNvMjndg=;
        b=bAr5ZI3Rhqn44ga41KdTnAzjxnBdKbpmQ6ngHcC6eLA71WIv1eGpAjpfkKzCcyQ4XR
         rLxO107v7Gk4VcuFbk/vOdMRI/xJG4m1QH+BsbZe5mv8fgoJS+cz4eCGeiX0WqzjRX4K
         fFMteW9ANBVofNd53WmbrTVz6it6mW2BaLakP910RadGv45Rhu8YHuYrWuOCC2hngjrA
         3rIhLy+ZL0fcuGFjLxu2QiKn2kOXJIRRXhrLyTcJK6VM958Wj5smKQT5/4ZyfVGE/zCo
         r3n6LVfyacMkAEKUKgrboLU9O5ItddXORiilY1KCjgwYAFyTGTEGV80nSjAO4ysIJV7q
         acxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933180; x=1699537980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MiH+OD80Lz6N2WkoQWVzzSH5wdFrVwABmyWNvMjndg=;
        b=wkmcGkhea3bBxvzbha6kHFObgCO4RUIHNx0fGu2GgUr4Pw63jB0qLXAewYGqbY8wMa
         9FliU1iTG8nCeUESiDPy+u2WwMGZTwsKPYXAi8VGTVR6tYGHd3Yr2MsOHuK9ZdF2SXWp
         5lx5uK4v4al5zqBrs6P1pylZwtPi6RQ2l8S7568AujM4+7Q6hXkj1UVTAZRbWdKWXkPr
         Pvi6vmybK6qMSu78tfQM6R0Ugs2/RaIcatWvAqybKNYM/joT5Me859t0h6/T7TtfRdF3
         GiZ/bCIIWOcInP9gutiMRcj/Wp5VWg4wxLYH32LJljzK1srYfLxhWL/E7kjv6EzkIU6e
         nPZQ==
X-Gm-Message-State: AOJu0Yz2fj88bBLMGK5ltlwdVLHlk2V8OasaKugpY+WRkT2CeKcz2DgL
	qxNBmLyVCfNiswhdbnFLbzeck6mI7sNlToB0nMUgwg==
X-Google-Smtp-Source: AGHT+IHABEQi7q2gF4GYbu+6KWyVOhp4LTc7vcuWRR/ds6omy7P2Nr93O+4ItCwG4g8ZUZhgbGUZVOPe8u3aj0mVGQs=
X-Received: by 2002:ad4:5761:0:b0:672:4e8c:9aa5 with SMTP id
 r1-20020ad45761000000b006724e8c9aa5mr14682447qvx.47.1698933180583; Thu, 02
 Nov 2023 06:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <CA+EHjTzj4drYKONVOLP19DYpJ4O8kSXcFzw2AKier1QdcFKx_Q@mail.gmail.com>
 <ZUF8A5KpwpA6IKUH@google.com> <CA+EHjTwTT9cFzYTtwT43nLJS01Sgt0NqzUgKAnfo2fiV3tEvXg@mail.gmail.com>
 <ZULJYg5cf1UrNq3e@google.com>
In-Reply-To: <ZULJYg5cf1UrNq3e@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 2 Nov 2023 13:52:23 +0000
Message-ID: <CA+EHjTzGzXnfXHh0m5iHt9m3BxerkUS56EVPDA_az6n2FRnk3w@mail.gmail.com>
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

On Wed, Nov 1, 2023 at 9:55=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Nov 01, 2023, Fuad Tabba wrote:
> > > > > @@ -1034,6 +1034,9 @@ static void kvm_destroy_dirty_bitmap(struct=
 kvm_memory_slot *memslot)
> > > > >  /* This does not remove the slot from struct kvm_memslots data s=
tructures */
> > > > >  static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_=
slot *slot)
> > > > >  {
> > > > > +       if (slot->flags & KVM_MEM_PRIVATE)
> > > > > +               kvm_gmem_unbind(slot);
> > > > > +
> > > >
> > > > Should this be called after kvm_arch_free_memslot()? Arch-specific =
ode
> > > > might need some of the data before the unbinding, something I thoug=
ht
> > > > might be necessary at one point for the pKVM port when deleting a
> > > > memslot, but realized later that kvm_invalidate_memslot() ->
> > > > kvm_arch_guest_memory_reclaimed() was the more logical place for it=
.
> > > > Also, since that seems to be the pattern for arch-specific handlers=
 in
> > > > KVM.
> > >
> > > Maybe?  But only if we can about symmetry between the allocation and =
free paths
> > > I really don't think kvm_arch_free_memslot() should be doing anything=
 beyond a
> > > "pure" free.  E.g. kvm_arch_free_memslot() is also called after movin=
g a memslot,
> > > which hopefully we never actually have to allow for guest_memfd, but =
any code in
> > > kvm_arch_free_memslot() would bring about "what if" questions regardi=
ng memslot
> > > movement.  I.e. the API is intended to be a "free arch metadata assoc=
iated with
> > > the memslot".
> > >
> > > Out of curiosity, what does pKVM need to do at kvm_arch_guest_memory_=
reclaimed()?
> >
> > It's about the host reclaiming ownership of guest memory when tearing
> > down a protected guest. In pKVM, we currently teardown the guest and
> > reclaim its memory when kvm_arch_destroy_vm() is called. The problem
> > with guestmem is that kvm_gmem_unbind() could get called before that
> > happens, after which the host might try to access the unbound guest
> > memory. Since the host hasn't reclaimed ownership of the guest memory
> > from hyp, hilarity ensues (it crashes).
> >
> > Initially, I hooked reclaim guest memory to kvm_free_memslot(), but
> > then I needed to move the unbind later in the function. I realized
> > later that kvm_arch_guest_memory_reclaimed() gets called earlier (at
> > the right time), and is more aptly named.
>
> Aha!  I suspected that might be the case.
>
> TDX and SNP also need to solve the same problem of "reclaiming" memory be=
fore it
> can be safely accessed by the host.  The plan is to add an arch hook (or =
two?)
> into guest_memfd that is invoked when memory is freed from guest_memfd.
>
> Hooking kvm_arch_guest_memory_reclaimed() isn't completely correct as del=
eting a
> memslot doesn't *guarantee* that guest memory is actually reclaimed (whic=
h reminds
> me, we need to figure out a better name for that thing before introducing
> kvm_arch_gmem_invalidate()).

I see. I'd assumed that that was what you're using. I agree that it's
not completely correct, so for the moment, I assume that if that
happens we have a misbehaving host, teardown the guest and reclaim its
memory.

> The effective false positives aren't fatal for the current usage because =
the hook
> is used only for x86 SEV guests to flush caches.  An unnecessary flush ca=
n cause
> performance issues, but it doesn't affect correctness. For TDX and SNP, a=
nd IIUC
> pKVM, false positives are fatal because KVM could assign memory back to t=
he host
> that is still owned by guest_memfd.

Yup.

> E.g. a misbehaving userspace could prematurely delete a memslot.  And the=
 more
> fun example is intrahost migration, where the plan is to allow pointing m=
ultiple
> guest_memfd files at a single guest_memfd inode:
> https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com
>
> There was a lot of discussion for this, but it's scattered all over the p=
lace.
> The TL;DR is is that the inode will represent physical memory, and a file=
 will
> represent a given "struct kvm" instance's view of that memory.  And so th=
e memory
> isn't reclaimed until the inode is truncated/punched.
>
> I _think_ this reflects the most recent plan from the guest_memfd side:
> https://lore.kernel.org/all/1233d749211c08d51f9ca5d427938d47f008af1f.1689=
893403.git.isaku.yamahata@intel.com

Thanks for pointing that out. I think this might be the way to go.
I'll have a closer look at this and see how to get it to work with
pKVM.

Cheers,
/fuad

