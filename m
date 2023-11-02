Return-Path: <linux-fsdevel+bounces-1835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D458E7DF53D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0016B2131E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A6C14A81;
	Thu,  2 Nov 2023 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8ebSa9c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E878613C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:41:35 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5B213D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:41:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03390793fso1188341276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698936092; x=1699540892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhBeRDHIuw2MhHJCiZzpmIP+VopsidfcOzvL++iqJMc=;
        b=E8ebSa9c6or9LYXHIbFKFTAuADYgYjM9eje8EFyHBw87GFEdLwCKcJ8i1m5xxy81u1
         CRy05fuVNYjnG8S/xFRYsuF7mdsaYzuwSiFkg18oH0iky8DUUq5R6Z5dgpjX36yCBdD1
         nkH2lDdLXHQXXHluGOv3deTIP/fInRgWG+/X2dyS3jabjNSq6MktO6nIU4sQfTNhsyxv
         z492XWb4v+voUQCfH2CXS+uivzWYdEjTDaxFPf70Xxr9agZjx6YdIJBoSoxp3pEvfIPX
         H7ufQX/vWv5ohN8/0DPI+udxnJG8E7NBGxZT66sCftP7Xj/OOJeV6NJvDIDZ1UP05ULr
         3TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936092; x=1699540892;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xhBeRDHIuw2MhHJCiZzpmIP+VopsidfcOzvL++iqJMc=;
        b=iUsaHorCxv5V8C7vmoSn30d0kEPoqratdsY2MzRI6Nm6GILizVSqmrjg3hzT/FAA3R
         hq3KxmEAzgpDMq+VW0pJPueQKnMAjleRvYudUgoyWoADFO20cbSduGziFj4gl0vK7EXS
         ekeUhK76qIPGq0GiIllm4rjusme7+rAF/ZSwLKt1BbMl3fjjjRnc0CziAbiRUdNZFPVj
         rZQ6Bwc05Kh9UvHwlPHqwaNIj4QKTrjISR+El4kGr38t6IT2s0kW++ktNIvWF2cOdI/U
         18lGVaiXLaDVZffq5Lfem9LsMzgTsoaZ/kYxXrS3mASse9gITfawIQN8UkXbDlmu0I0R
         RHJg==
X-Gm-Message-State: AOJu0YyEf5etffHZgexJVuicRkbd3pKxkI9gkRE5P7K93GO3LKbjhW69
	fGZRxrvgY/mj4ssTwURyykOGqjrPA6M=
X-Google-Smtp-Source: AGHT+IGookYXrYm1A+ma3WZO34BPnkwMLXQzWy+6HX4P/l5wwOteWAD0NK2vYdNE8zwnCUE9EMm+eRT161A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2fce:0:b0:d9a:f3dc:7d19 with SMTP id
 v197-20020a252fce000000b00d9af3dc7d19mr331431ybv.11.1698936092597; Thu, 02
 Nov 2023 07:41:32 -0700 (PDT)
Date: Thu, 2 Nov 2023 07:41:30 -0700
In-Reply-To: <CA+EHjTyAU9XZ3OgqXjmAKh-BKsLrH_8QtnJihQxF4fhk8WPSYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-13-seanjc@google.com>
 <CA+EHjTyAU9XZ3OgqXjmAKh-BKsLrH_8QtnJihQxF4fhk8WPSYg@mail.gmail.com>
Message-ID: <ZUO1Giju0GkUdF0o@google.com>
Subject: Re: [PATCH v13 12/35] KVM: Prepare for handling only shared mappings
 in mmu_notifier events
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

On Thu, Nov 02, 2023, Fuad Tabba wrote:
> Hi,
>=20
> On Fri, Oct 27, 2023 at 7:22=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Add flags to "struct kvm_gfn_range" to let notifier events target only
> > shared and only private mappings, and write up the existing mmu_notifie=
r
> > events to be shared-only (private memory is never associated with a
> > userspace virtual address, i.e. can't be reached via mmu_notifiers).
> >
> > Add two flags so that KVM can handle the three possibilities (shared,
> > private, and shared+private) without needing something like a tri-state
> > enum.
> >
> > Link: https://lore.kernel.org/all/ZJX0hk+KpQP0KUyB@google.com
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  include/linux/kvm_host.h | 2 ++
> >  virt/kvm/kvm_main.c      | 7 +++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 96aa930536b1..89c1a991a3b8 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -263,6 +263,8 @@ struct kvm_gfn_range {
> >         gfn_t start;
> >         gfn_t end;
> >         union kvm_mmu_notifier_arg arg;
> > +       bool only_private;
> > +       bool only_shared;
>=20
> If these flags aren't used in this patch series, should this patch be
> moved to the other series?

If *both* TDX and SNP need this patch, then I think it's probably worth app=
lying
it now to make their lives easier.  But if only one needs the support, then=
 I
completely agree this should be punted to whichever series needs it (this a=
lso
came up in v11, but we didn't force the issue).

Mike, Isaku?

> Also, if shared+private is a possibility, doesn't the prefix "only_"
> confuse things a bit? I.e., what is shared+private, is it when both
> are 0 or when both are 1? I assume it's the former (both are 0), but
> it might be clearer.

Heh, I was hoping that "only_private && only_shared" would be obviously non=
sensical.

The only alternative I can think would be to add an enum, e.g.

	enum {
		PROCESS_PRIVATE_AND_SHARED,
		PROCESS_ONLY_PRIVATE,
		PROCESS_ONLY_SHARED,
	};

because every other way of expressing the flags either results in more conf=
usion
or an unsafe default.  I.e. I want zapping only private or only shared to r=
equire
the caller to explicitly set a non-zero value, which is how I ended up with
"only_{private,shared}" as opposed to "process_{private,shared}".

