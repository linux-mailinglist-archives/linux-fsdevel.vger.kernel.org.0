Return-Path: <linux-fsdevel+bounces-1729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743B97DE117
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 13:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D65A28182C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2D12E4A;
	Wed,  1 Nov 2023 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkZvBXUU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40512B90
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 12:47:04 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC52913E
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 05:47:02 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-778a20df8c3so469994885a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 05:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698842822; x=1699447622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1rvjvqySA8gfoAJ2h4xCVn6r+FVikEwY0ryqbt6qgE=;
        b=tkZvBXUU99Y6DGHqlV7CmraXsSkiESOXpXjHCqzaKtwOaO25j+k+op3nuWbLqAzLJv
         msff5vgM4xSZGonWvuWKFT/X2NUlwOri+dw2rbRjgxDXjPkef20VwIeful3u/iFk+ZEf
         tvWyN8ZIVEdnb2ds+/NaelJwumxeiLs924jPtosp40oDqOC1W8+ebv8ACD69AmjtNOn/
         U2uu/w6nzTzmwhfFI37qaV2Gu0NWrErmtjh4mvJgEYX5mh/eBhRmL/2p0lRRVZeGvDfI
         KctXwUfDd6Yof1leqTQuWhsPISmIpLC/BGFxNNCTKyjMni9XTcTJZwY5LdOWf7FXWTV9
         Wptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698842822; x=1699447622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1rvjvqySA8gfoAJ2h4xCVn6r+FVikEwY0ryqbt6qgE=;
        b=GxjxgZ2OYe/uVQ12FzVZdWyDlZnL2Kz1yrdHxlNhynDf7/hvFR8WV6HCDJbeHBRHjp
         Pwc2FvWxPcXy9G1tR+v3YgWcIC3EQMKDF8xJ0z0npAJbz4NjhZxpBqO2zQQrau1ljZs5
         HGGtD/EyhQzt/SdLdisFeelym+2qFzJq1kL0Fxn9iUuueOy7lOAzKiHzDXkhMjdNwzsR
         y1u7j8YOQKMYeohFG6Ror5UZewcODzE32tJWC88nDr47A+tHpptoYwKIJ+CQJ6BUTRgE
         cpDNCIrtw4t1kjzBTpuo2EMw2ST5l36Ol7XYMZUYV0DNQvllFYjX7JEiS97LLjZUiVwl
         XbTw==
X-Gm-Message-State: AOJu0Yz+vrzMc3pWsIzSjfZF6F5F6iOcVYeChrQs+x7fejFfkVHBDe7p
	mDkhxHzjqMuW6tt1Tjr6F4Thujm74QAQdtRf7wja4g==
X-Google-Smtp-Source: AGHT+IEwNefwVjOpplfsdA5Dp0BgUdMFZ8Gr0x2pIdj0EOquTk7Lrcu3yjtemmSczlmcSeWnvG38gd5iU/oYIFP7LzQ=
X-Received: by 2002:ad4:5de9:0:b0:65d:31e:b810 with SMTP id
 jn9-20020ad45de9000000b0065d031eb810mr19758846qvb.34.1698842821613; Wed, 01
 Nov 2023 05:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-3-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-3-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 1 Nov 2023 12:46:25 +0000
Message-ID: <CA+EHjTycVAL11xCKQAfm-q4NGbgSH7yMswu+c1XaJdyhUh61zw@mail.gmail.com>
Subject: Re: [PATCH v13 02/35] KVM: Assert that mmu_invalidate_in_progress
 *never* goes negative
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
> Move the assertion on the in-progress invalidation count from the primary
> MMU's notifier path to KVM's common notification path, i.e. assert that
> the count doesn't go negative even when the invalidation is coming from
> KVM itself.
>
> Opportunistically convert the assertion to a KVM_BUG_ON(), i.e. kill only
> the affected VM, not the entire kernel.  A corrupted count is fatal to th=
e
> VM, e.g. the non-zero (negative) count will cause mmu_invalidate_retry()
> to block any and all attempts to install new mappings.  But it's far from
> guaranteed that an end() without a start() is fatal or even problematic t=
o
> anything other than the target VM, e.g. the underlying bug could simply b=
e
> a duplicate call to end().  And it's much more likely that a missed
> invalidation, i.e. a potential use-after-free, would manifest as no
> notification whatsoever, not an end() without a start().
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  virt/kvm/kvm_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0524933856d4..5a97e6c7d9c2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -833,6 +833,7 @@ void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned=
 long start,
>          * in conjunction with the smp_rmb in mmu_invalidate_retry().
>          */
>         kvm->mmu_invalidate_in_progress--;
> +       KVM_BUG_ON(kvm->mmu_invalidate_in_progress < 0, kvm);
>  }
>
>  static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *m=
n,
> @@ -863,8 +864,6 @@ static void kvm_mmu_notifier_invalidate_range_end(str=
uct mmu_notifier *mn,
>          */
>         if (wake)
>                 rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
> -
> -       BUG_ON(kvm->mmu_invalidate_in_progress < 0);
>  }
>
>  static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
> --
> 2.42.0.820.g83a721a137-goog
>

