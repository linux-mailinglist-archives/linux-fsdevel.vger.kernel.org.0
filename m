Return-Path: <linux-fsdevel+bounces-2109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41AF7E297B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CE4281574
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D221029419;
	Mon,  6 Nov 2023 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oe1xs7MQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD928E1C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 16:13:05 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE2B1BF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 08:13:03 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cf717bacso63996077b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 08:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699287183; x=1699891983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmoUoGnC/t23H3IPxV2qsT2AAyd7sUSE5gGiJgJlDX0=;
        b=Oe1xs7MQxbs5oPRVpc1SJfxw+zaBXWx0tAzWWUfGeY0ZnxLo3TUCZUwSHoYrsLcen+
         0T98De4h1V0jyIRipVTcdvrBJ3Gf6ahV4xyT5pGJZOMVm2tQZItGID1uzEtmhh/aG+xd
         iN5yBgGbHR5grM6zMLTpWxCSPRcfeObuMhPxbVqdGo94SCvbVIL/p7EHqsDDYVZS7oux
         38cAa3a5BNG2BF/RGEaagKWyzMT3MhudxuLj0b7sjmXHkLqn1bXVwZoG0xgvZmFfzo6o
         qOXxpsu4IIKS84P9O1shcP+44+bOV0AFRJXACHqrQAZ8unbvgtfM8pN2zOg6LTUiLAxB
         P8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287183; x=1699891983;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mmoUoGnC/t23H3IPxV2qsT2AAyd7sUSE5gGiJgJlDX0=;
        b=tXYxHcjBFbAmab282E+xdBxGUmksmFDGd+e1AxWMyt86t5mapiL0Z3EAZ8nTaAVqeA
         lBYcvjLBtTxhmUfv+J6JdqPDXP4XxjcNVu7uFUyptdjmGs30CNj85GP+VrslLiAynaSJ
         Kvu27lgXxZkd1YlPH0hjbxKz3ZtZRyrQ0Gko0GqAR1zbuQRxfGiDcMIASVKiwT6NURHs
         b7I6WnTibv4A5lFwmPIIztBCN5N0pRnaEssCXzCVYr2hIkX7HbcTFrwtqS/UnW1sUkN1
         NurBVJEyQXYWq27/IlipWQ5Miex2wkc1jxSXRlAyt9KqAF/xpDHkFcAhzuY3+Y3MFB/6
         GMcg==
X-Gm-Message-State: AOJu0Yz+RQTBLTYkJ+ZyhQvt2FbzeUG7bFPPOHLVTZu2FIKnDoNUaAO7
	fmooHc2E7lWXf0PJ7PsthEwUGTbAzQ4=
X-Google-Smtp-Source: AGHT+IEuz2kxbbqGFRlRrYjmJAAmCd5YL62xYCCumvx9nTcHzja2SicRUTSCOZ5GtJw0RknzXE1Az5YHDFw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d5d2:0:b0:5a7:ad67:b4b6 with SMTP id
 x201-20020a0dd5d2000000b005a7ad67b4b6mr228755ywd.2.1699287183068; Mon, 06 Nov
 2023 08:13:03 -0800 (PST)
Date: Mon, 6 Nov 2023 08:13:01 -0800
In-Reply-To: <CA+EHjTxy6TWM3oBG0Q6v5090XTrs+M8_m5=6Z2E1P-HyTkrGWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-26-pbonzini@redhat.com>
 <CA+EHjTxy6TWM3oBG0Q6v5090XTrs+M8_m5=6Z2E1P-HyTkrGWg@mail.gmail.com>
Message-ID: <ZUkQjW-yMnLfD7XW@google.com>
Subject: Re: [PATCH 25/34] KVM: selftests: Add helpers to convert guest memory
 b/w private and shared
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023, Fuad Tabba wrote:
> On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> > +void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t base, uint64_t=
 size,
> > +                           bool punch_hole)
> > +{
> > +       const int mode =3D FALLOC_FL_KEEP_SIZE | (punch_hole ? FALLOC_F=
L_PUNCH_HOLE : 0);
> > +       struct userspace_mem_region *region;
> > +       uint64_t end =3D base + size;
> > +       uint64_t gpa, len;
> > +       off_t fd_offset;
> > +       int ret;
> > +
> > +       for (gpa =3D base; gpa < end; gpa +=3D len) {
> > +               uint64_t offset;
> > +
> > +               region =3D userspace_mem_region_find(vm, gpa, gpa);
> > +               TEST_ASSERT(region && region->region.flags & KVM_MEM_GU=
EST_MEMFD,
> > +                           "Private memory region not found for GPA 0x=
%lx", gpa);
> > +
> > +               offset =3D (gpa - region->region.guest_phys_addr);
>=20
> nit: why the parentheses?

I simply forgot to remove them when I changed the function to support spann=
ing
multiple memslots, i.e. when the code went from this

	fd_offset =3D region->region.gmem_offset +
		    (gpa - region->region.guest_phys_addr);

to what you see above.

