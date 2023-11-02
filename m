Return-Path: <linux-fsdevel+bounces-1827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5BF7DF45E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AAE1C20F2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4819A19BCF;
	Thu,  2 Nov 2023 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FuZ9OSc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD4199D4
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 13:55:41 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7884134
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 06:55:39 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-49618e09f16so404012e0c.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698933339; x=1699538139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Yb/48Ns1tpOy5twJOpAhL4i1qPmUF1LLO7pfzUXbus=;
        b=FuZ9OSc+DNLYTFx2ZAnHD26IiNmPDELlQgibZwwNBWqFj+xZKbh3rEmPDk4dwlN5ps
         f6N7kvONIFqMk6YxGh7uH5M6yu0LP5pjEgj30EZ5tpJgCP3ZK+aeMjykv2uYHLZkRSj4
         9KDe2OWSfOnF7tE3VaApiMt5qbuLd6DPNxIGyz/9Gid/YMyH5LdpXNUNj/ZotkWrmJLX
         CFi3qdF6FLhCom1Ak1TKi1cOFDxvT3spVbXTG+D9KSjLNjgTns/DMtFwd99veQIsMnS3
         t1bKhgEdcCH+ZF2lLeUJu+RfdirKBzoHRRp66wNhPytJ1D/Sx4HcIwjWCRHr72bVucoV
         z1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933339; x=1699538139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Yb/48Ns1tpOy5twJOpAhL4i1qPmUF1LLO7pfzUXbus=;
        b=WHvNrGgH9QdWxi4WyRvNLhwpI6wiJLtUoBEnlayLcvDAMYwUnnEHpIsCi2PSs90i4y
         UaNh/2GTxmmibTHUUaiXyf0vqoGh6YUQ8hDdTusI1+E+ILv2QELP1k25/cEbIvwrJc9T
         7WAePCJlYYUaDHxupAlqiiFpCYDHgZWix8C/GdJa4/0B8yA2J4UMIU4O343qFnbkHhYX
         wEFEPSDDVI+OP+aYatlvJGO18BBxqLG0PVNRY0ZqR53Fuv+/J1ECUu4PcJ4ARKmEofKN
         KCGMBHRurPXMkOWJLMF+xrIj5SJYv4Zwmi1+MwjGv46e2R11XOoPGOCi4sLao6g659sY
         3PTQ==
X-Gm-Message-State: AOJu0YzCB2lHXMsYK2+ooSmYpgJ97+i2HSQptsDyhLNwu3E//j9rpkxp
	43AFLUxFZFoePL8p8DE86ONxcPB2dqwLVh8ZS4OEZQ==
X-Google-Smtp-Source: AGHT+IHGemWDnkL7WTN8LWokDsgbdlhg4M3963xhuFMSCwbYM702stLA5BFN7Yk4qTk9o3bsEJ0EqjHFUXiDw4OizcA=
X-Received: by 2002:a1f:984f:0:b0:49d:a52a:4421 with SMTP id
 a76-20020a1f984f000000b0049da52a4421mr16094320vke.4.1698933338782; Thu, 02
 Nov 2023 06:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-11-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-11-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 2 Nov 2023 13:55:03 +0000
Message-ID: <CA+EHjTx4dQwU3CWzoib_x1tgw66HCtBEiGW_7E8yZxttem6+vw@mail.gmail.com>
Subject: Re: [PATCH v13 10/35] KVM: Add a dedicated mmu_notifier flag for
 reclaiming freed memory
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

On Fri, Oct 27, 2023 at 7:22=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Handle AMD SEV's kvm_arch_guest_memory_reclaimed() hook by having
> __kvm_handle_hva_range() return whether or not an overlapping memslot
> was found, i.e. mmu_lock was acquired.  Using the .on_unlock() hook
> works, but kvm_arch_guest_memory_reclaimed() needs to run after dropping
> mmu_lock, which makes .on_lock() and .on_unlock() asymmetrical.
>
> Use a small struct to return the tuple of the notifier-specific return,
> plus whether or not overlap was found.  Because the iteration helpers are
> __always_inlined, practically speaking, the struct will never actually be
> returned from a function call (not to mention the size of the struct will
> be two bytes in practice).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>  virt/kvm/kvm_main.c | 53 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 16 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 3f5b7c2c5327..2bc04c8ae1f4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -561,6 +561,19 @@ struct kvm_mmu_notifier_range {
>         bool may_block;
>  };
>
> +/*
> + * The inner-most helper returns a tuple containing the return value fro=
m the
> + * arch- and action-specific handler, plus a flag indicating whether or =
not at
> + * least one memslot was found, i.e. if the handler found guest memory.
> + *
> + * Note, most notifiers are averse to booleans, so even though KVM track=
s the
> + * return from arch code as a bool, outer helpers will cast it to an int=
. :-(
> + */
> +typedef struct kvm_mmu_notifier_return {
> +       bool ret;
> +       bool found_memslot;
> +} kvm_mn_ret_t;
> +
>  /*
>   * Use a dedicated stub instead of NULL to indicate that there is no cal=
lback
>   * function/handler.  The compiler technically can't guarantee that a re=
al
> @@ -582,22 +595,25 @@ static const union kvm_mmu_notifier_arg KVM_MMU_NOT=
IFIER_NO_ARG;
>              node;                                                       =
    \
>              node =3D interval_tree_iter_next(node, start, last))      \
>
> -static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
> -                                                 const struct kvm_mmu_no=
tifier_range *range)
> +static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *k=
vm,
> +                                                          const struct k=
vm_mmu_notifier_range *range)
>  {
> -       bool ret =3D false, locked =3D false;
> +       struct kvm_mmu_notifier_return r =3D {
> +               .ret =3D false,
> +               .found_memslot =3D false,
> +       };
>         struct kvm_gfn_range gfn_range;
>         struct kvm_memory_slot *slot;
>         struct kvm_memslots *slots;
>         int i, idx;
>
>         if (WARN_ON_ONCE(range->end <=3D range->start))
> -               return 0;
> +               return r;
>
>         /* A null handler is allowed if and only if on_lock() is provided=
. */
>         if (WARN_ON_ONCE(IS_KVM_NULL_FN(range->on_lock) &&
>                          IS_KVM_NULL_FN(range->handler)))
> -               return 0;
> +               return r;
>
>         idx =3D srcu_read_lock(&kvm->srcu);
>
> @@ -631,8 +647,8 @@ static __always_inline int __kvm_handle_hva_range(str=
uct kvm *kvm,
>                         gfn_range.end =3D hva_to_gfn_memslot(hva_end + PA=
GE_SIZE - 1, slot);
>                         gfn_range.slot =3D slot;
>
> -                       if (!locked) {
> -                               locked =3D true;
> +                       if (!r.found_memslot) {
> +                               r.found_memslot =3D true;
>                                 KVM_MMU_LOCK(kvm);
>                                 if (!IS_KVM_NULL_FN(range->on_lock))
>                                         range->on_lock(kvm);
> @@ -640,14 +656,14 @@ static __always_inline int __kvm_handle_hva_range(s=
truct kvm *kvm,
>                                 if (IS_KVM_NULL_FN(range->handler))
>                                         break;
>                         }
> -                       ret |=3D range->handler(kvm, &gfn_range);
> +                       r.ret |=3D range->handler(kvm, &gfn_range);
>                 }
>         }
>
> -       if (range->flush_on_ret && ret)
> +       if (range->flush_on_ret && r.ret)
>                 kvm_flush_remote_tlbs(kvm);
>
> -       if (locked) {
> +       if (r.found_memslot) {
>                 KVM_MMU_UNLOCK(kvm);
>                 if (!IS_KVM_NULL_FN(range->on_unlock))
>                         range->on_unlock(kvm);
> @@ -655,8 +671,7 @@ static __always_inline int __kvm_handle_hva_range(str=
uct kvm *kvm,
>
>         srcu_read_unlock(&kvm->srcu, idx);
>
> -       /* The notifiers are averse to booleans. :-( */
> -       return (int)ret;
> +       return r;
>  }
>
>  static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
> @@ -677,7 +692,7 @@ static __always_inline int kvm_handle_hva_range(struc=
t mmu_notifier *mn,
>                 .may_block      =3D false,
>         };
>
> -       return __kvm_handle_hva_range(kvm, &range);
> +       return __kvm_handle_hva_range(kvm, &range).ret;
>  }
>
>  static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_noti=
fier *mn,
> @@ -696,7 +711,7 @@ static __always_inline int kvm_handle_hva_range_no_fl=
ush(struct mmu_notifier *mn
>                 .may_block      =3D false,
>         };
>
> -       return __kvm_handle_hva_range(kvm, &range);
> +       return __kvm_handle_hva_range(kvm, &range).ret;
>  }
>
>  static bool kvm_change_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *r=
ange)
> @@ -798,7 +813,7 @@ static int kvm_mmu_notifier_invalidate_range_start(st=
ruct mmu_notifier *mn,
>                 .end            =3D range->end,
>                 .handler        =3D kvm_mmu_unmap_gfn_range,
>                 .on_lock        =3D kvm_mmu_invalidate_begin,
> -               .on_unlock      =3D kvm_arch_guest_memory_reclaimed,
> +               .on_unlock      =3D (void *)kvm_null_fn,
>                 .flush_on_ret   =3D true,
>                 .may_block      =3D mmu_notifier_range_blockable(range),
>         };
> @@ -830,7 +845,13 @@ static int kvm_mmu_notifier_invalidate_range_start(s=
truct mmu_notifier *mn,
>         gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end,
>                                           hva_range.may_block);
>
> -       __kvm_handle_hva_range(kvm, &hva_range);
> +       /*
> +        * If one or more memslots were found and thus zapped, notify arc=
h code
> +        * that guest memory has been reclaimed.  This needs to be done *=
after*
> +        * dropping mmu_lock, as x86's reclaim path is slooooow.
> +        */
> +       if (__kvm_handle_hva_range(kvm, &hva_range).found_memslot)
> +               kvm_arch_guest_memory_reclaimed(kvm);
>
>         return 0;
>  }
> --
> 2.42.0.820.g83a721a137-goog
>

