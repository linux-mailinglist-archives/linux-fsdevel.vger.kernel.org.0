Return-Path: <linux-fsdevel+bounces-1730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC417DE11E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 13:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB76B20B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA512B8B;
	Wed,  1 Nov 2023 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ly5ncPVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913011187
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 12:51:05 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57410F4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 05:51:03 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d0252578aso43233036d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698843062; x=1699447862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DytdUoCbq8poGHKLHOEtAO0D5dohgKyWvCysCxFt+wY=;
        b=ly5ncPVNpoivFRlisDYz8Hb0PEqnyA/XOL1PFjBsoMHY4MzfhZ3R17TRt0h1EkyEjz
         3QGvMwZiZRm8l3mc+UdgKXe/WYbIWHxqBvZIQo2mWBKNOBMlLFsjwJ0befWTql4jonoG
         1Wg/Z+yLAslqneYeBHQ5zucEBKpJyIbaJdUNH7+LJhCgzEdEarVuzPc9RVGAX+8Vpylw
         mJspx/gpqRRQgO1xL7LV87CebmifDkfrPTYfrcb1F/lScnAIFMrxitVvih55oReziExH
         /0KH9vi34r91y0hTLMtzcT20rw+kEP6Sp4Z+eGh6I+Fb9chg1XmiyRmdav/2p217PYdA
         4z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698843062; x=1699447862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DytdUoCbq8poGHKLHOEtAO0D5dohgKyWvCysCxFt+wY=;
        b=WwNQGLNUw9y+LelIB3s99Ib0I3Qgo+dveMe0DxgDKNO40ISyaSiPZUDH33bqJXA4uW
         3tvLNJ+xleBMuMRmpSXhJR0I9M49UIpPXVIPL2Oj/6TSsFaHB1YA/RX7pO7FkmapN0s3
         M6iZS0zJ1FafYN7YDyd2yU/jMDVV+67bHSmSMdFsAALXOWyuJl6wWuKbooWUUxBWoIl5
         H8rGtN7eRmJRepY5jJSJ3e3EAD/IEbbdbc1nYWb83XlD+EFxLBof5owQNL9jTRtpxRgR
         NecNpkq5xKu+kENmLrBZJ1iVHTe/GO28MoyuyHE+NWd8PG28TrTpCDm5EJS5h6CPm9zw
         d7lg==
X-Gm-Message-State: AOJu0YyWkyLDbcQJCBbMk1fcvkhaqrGd1yCeC0o4kPp7DHA4fnzgXDQB
	Mgqf4tjNGy4u+/bLWEAWj45hQUOiiM4okhVFJRanBA==
X-Google-Smtp-Source: AGHT+IF4xR6L8cVnqFnyZjdEh5XAFhWOV7M0s6Xt9NyBBttGvtAf21ACAZmexGcVd+eTPklAY7PiFjol+SoHUZLf4NM=
X-Received: by 2002:a05:6214:262e:b0:66f:bd35:e889 with SMTP id
 gv14-20020a056214262e00b0066fbd35e889mr16003984qvb.60.1698843062295; Wed, 01
 Nov 2023 05:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-5-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-5-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 1 Nov 2023 12:50:26 +0000
Message-ID: <CA+EHjTxW3P+_fejO6emoZ1=c9EkWJUH63-ffmSumh=6P6MbTqQ@mail.gmail.com>
Subject: Re: [PATCH v13 04/35] KVM: WARN if there are dangling MMU
 invalidations at VM destruction
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
> Add an assertion that there are no in-progress MMU invalidations when a
> VM is being destroyed, with the exception of the scenario where KVM
> unregisters its MMU notifier between an .invalidate_range_start() call an=
d
> the corresponding .invalidate_range_end().
>
> KVM can't detect unpaired calls from the mmu_notifier due to the above
> exception waiver, but the assertion can detect KVM bugs, e.g. such as the
> bug that *almost* escaped initial guest_memfd development.
>
> Link: https://lore.kernel.org/all/e397d30c-c6af-e68f-d18e-b4e3739c5389@li=
nux.intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  virt/kvm/kvm_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1a577a25de47..4dba682586ee 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1356,9 +1356,16 @@ static void kvm_destroy_vm(struct kvm *kvm)
>          * No threads can be waiting in kvm_swap_active_memslots() as the
>          * last reference on KVM has been dropped, but freeing
>          * memslots would deadlock without this manual intervention.
> +        *
> +        * If the count isn't unbalanced, i.e. KVM did NOT unregister its=
 MMU
> +        * notifier between a start() and end(), then there shouldn't be =
any
> +        * in-progress invalidations.
>          */
>         WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
> -       kvm->mn_active_invalidate_count =3D 0;
> +       if (kvm->mn_active_invalidate_count)
> +               kvm->mn_active_invalidate_count =3D 0;
> +       else
> +               WARN_ON(kvm->mmu_invalidate_in_progress);
>  #else
>         kvm_flush_shadow_all(kvm);
>  #endif
> --
> 2.42.0.820.g83a721a137-goog
>

