Return-Path: <linux-fsdevel+bounces-2111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0E7E29A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0851C20AD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD31629413;
	Mon,  6 Nov 2023 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ySAqN7oF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3729402
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 16:25:26 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC3C1BF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 08:25:19 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e72fe47fso3001285b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699287918; x=1699892718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xnGb8Sp7Bw2ldCk3b7+mm/bKINtcTCgeZ/KDZ+GW64=;
        b=ySAqN7oF51WslqTAsZBYQDAR51F5kZ5ot7qgCrPfpSmjVPtcEgBcbD39bwxufl1EcP
         yPyEG4zpQUveZNdV2zq28oAaZ4TO60traeY1rXtM6K3yhuoBF/0cTRT5MAhSnOUQEfzK
         ro8+X30m/hTmUYF7liMk6rN9BOpurtlqYQN9v467MdzTk71trnHZZWjAh9Y+Mmd16zyb
         keVJSJ60oOYsxhas68tyVoruknKeo64lObVhYadQtyrBr7d6H85Mm4+epAkEwnPDKRSH
         gTU5iiWrVtBODpMqIoHJlDd1kwfyLpfo2hdBzPX8mNpgCgeTMkymuGzO4NpZyvzcs0o7
         35DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287918; x=1699892718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xnGb8Sp7Bw2ldCk3b7+mm/bKINtcTCgeZ/KDZ+GW64=;
        b=pEJaLRcd4Zz4pUguwuFj5OUM8ifUPqbshFXBhao56f6134+HL+SWNS38R9D16ZSUwt
         hOP8D0FcPNQrtbi0qD0SO8LzSlhrKEN7UNmL4d6rIoQMAw4ms1WqSi5ZL8JVatz6xH+N
         A2RBaZYUdqonIYAtfu0sfOEhVY/xZ3EiHRKoaTPYqnBw3bfqYPw0bMnUvlwqfjSFZtQK
         GCtWOap+fCCl0TcET2QzzxrVwjSuRjmK3mh/WiMq8R7MCINVSeQOboKqJ+2zkRlRAhfT
         hsBCQaHwNDSFS1bmJ4ldVj5i8UQk2TNsztLVrUpxW1XmuIUI42iBmOJa+VjX+VfqGOTe
         XC6Q==
X-Gm-Message-State: AOJu0Yypfs0pVczRgBrPI6/QVBJlBe4VWM0z+hzdhc7ypQES1OYCmcoY
	WcFe4v/xqBOG/H4/g4xYkV5LZdlUk5h872MfVfVJbQ==
X-Google-Smtp-Source: AGHT+IEz2M905daE9adgBPAvjj9bLaNYp4EiTefEe+KnfTT86zKFKrzhkzHGJH5RS/f9fNDUudL2BwXAULrnwcO9LCk=
X-Received: by 2002:a05:6808:28c:b0:3af:a107:cf68 with SMTP id
 z12-20020a056808028c00b003afa107cf68mr28980109oic.40.1699287918292; Mon, 06
 Nov 2023 08:25:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-26-pbonzini@redhat.com>
 <CA+EHjTxy6TWM3oBG0Q6v5090XTrs+M8_m5=6Z2E1P-HyTkrGWg@mail.gmail.com> <ZUkQjW-yMnLfD7XW@google.com>
In-Reply-To: <ZUkQjW-yMnLfD7XW@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 6 Nov 2023 16:24:42 +0000
Message-ID: <CA+EHjTw8Om6DGatxGhLJHpUb4RY_ma1pidd=mYxTQseE7vDB4A@mail.gmail.com>
Subject: Re: [PATCH 25/34] KVM: selftests: Add helpers to convert guest memory
 b/w private and shared
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 4:13=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Nov 06, 2023, Fuad Tabba wrote:
> > On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> > > +void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t base, uint64=
_t size,
> > > +                           bool punch_hole)
> > > +{
> > > +       const int mode =3D FALLOC_FL_KEEP_SIZE | (punch_hole ? FALLOC=
_FL_PUNCH_HOLE : 0);
> > > +       struct userspace_mem_region *region;
> > > +       uint64_t end =3D base + size;
> > > +       uint64_t gpa, len;
> > > +       off_t fd_offset;
> > > +       int ret;
> > > +
> > > +       for (gpa =3D base; gpa < end; gpa +=3D len) {
> > > +               uint64_t offset;
> > > +
> > > +               region =3D userspace_mem_region_find(vm, gpa, gpa);
> > > +               TEST_ASSERT(region && region->region.flags & KVM_MEM_=
GUEST_MEMFD,
> > > +                           "Private memory region not found for GPA =
0x%lx", gpa);
> > > +
> > > +               offset =3D (gpa - region->region.guest_phys_addr);
> >
> > nit: why the parentheses?
>
> I simply forgot to remove them when I changed the function to support spa=
nning
> multiple memslots, i.e. when the code went from this
>
>         fd_offset =3D region->region.gmem_offset +
>                     (gpa - region->region.guest_phys_addr);
>
> to what you see above.

I wasn't actually expecting an answer, but I literally _did_ ask for it :)

Thanks,
/fuad

