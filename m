Return-Path: <linux-fsdevel+bounces-2110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DF17E2993
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106F3281170
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5829415;
	Mon,  6 Nov 2023 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3o8M6NtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3028E3F
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 16:17:47 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F791BF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 08:17:46 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d13ac2796so30033036d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699287466; x=1699892266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUV8zKIdpTV0f8ZMhx633GQ2l+XRSBNMcsvYJoEfTx4=;
        b=3o8M6NtHBemcOm+WImExN2FSkf9rn450dHn/P65eZjlIW2aCrACWXBwOyfiWzwA0QA
         df03rptJDJdDFyoyBXZQMrx8x+zr4/6Yho5Vq99CZOwdBOT1kOO4ZrxBi5VSfG7/g+i2
         42W6TbW7eDdDtEnIrogMhtX8k2PHMwCNFCtBhwTOp5ZndPZSh88xacBL38yksWV4tbmd
         YssaPajDRIXn9V+UEvZla/fNVG9vrw3IAHWjNnhcIL+B6UWMtixB3zKHyQ0J9uJjpjLT
         ADMfKVdRzDOZC3f8Kf0ejMMB6+1chRy6YFVtxYxOc27YRb4a/ZBquILr8L4z6bW4Z1s9
         dFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287466; x=1699892266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUV8zKIdpTV0f8ZMhx633GQ2l+XRSBNMcsvYJoEfTx4=;
        b=FJfANmO/I3uXiS7FyWgciRwi20A2uf0fKrIeiwp4Zo+l5dKDMpFXixCLiqYRmbzrXq
         tp3bMpTowAG3xZLeJNlrSXMgTd6+g0tvmGunt285B+VXs7rwkIvMZMhYBu8+iG1lwPQT
         N4httBzTq/48dQZU1OWt6kdJbKYIbpxYA43jBUkqB5c+M6Ir32rjS0Q9ncFJiuhVm++j
         CjEf/TgBIq/2BzAKxV60ATkBJXM/hFXktGLs4WglcvygJz4LVpzJx34gTwES5aoEnABi
         CRmgaI24m3iTS99q/ekbWXrLkhcwMEW8isjlKMHLBDULVQmUYknSKq3zscR+GoTc0rjg
         Zr0w==
X-Gm-Message-State: AOJu0Yw2iMV7MPP+jtvOTB3OG6k7vY5OLiRPv6633YIZ5PHwJbZbl6rF
	KJoF2ju8WcwtR5M/c23xeYkrcBUF2jXbNC0ttLNPsg==
X-Google-Smtp-Source: AGHT+IFFqaeUa+zb1fqYMH2SBG8qERPcG1V2EKOvlLONFWJF+9JT7SC3ACnaIHdf6fX4zUtKFZJjWCRYHGHhXFDqHvM=
X-Received: by 2002:ad4:5c83:0:b0:670:9f8d:f7be with SMTP id
 o3-20020ad45c83000000b006709f8df7bemr44676404qvh.13.1699287465633; Mon, 06
 Nov 2023 08:17:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-28-pbonzini@redhat.com>
 <CA+EHjTxz-e_JKYTtEjjYJTXmpvizRXe8EUbhY2E7bwFjkkHVFw@mail.gmail.com> <ZUkOgdTMbH40XFGE@google.com>
In-Reply-To: <ZUkOgdTMbH40XFGE@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 6 Nov 2023 16:17:09 +0000
Message-ID: <CA+EHjTzc4zwN1atU1mSnbi3Lvb0c83MATQSk1uSWxae2iKi0aw@mail.gmail.com>
Subject: Re: [PATCH 27/34] KVM: selftests: Introduce VM "shape" to allow tests
 to specify the VM type
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

On Mon, Nov 6, 2023 at 4:04=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Nov 06, 2023, Fuad Tabba wrote:
> > On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> > >
> > > From: Sean Christopherson <seanjc@google.com>
> > >
> > > Add a "vm_shape" structure to encapsulate the selftests-defined "mode=
",
> > > along with the KVM-defined "type" for use when creating a new VM.  "m=
ode"
> > > tracks physical and virtual address properties, as well as the prefer=
red
> > > backing memory type, while "type" corresponds to the VM type.
> > >
> > > Taking the VM type will allow adding tests for KVM_CREATE_GUEST_MEMFD=
,
> > > a.k.a. guest private memory, without needing an entirely separate set=
 of
> > > helpers.  Guest private memory is effectively usable only by confiden=
tial
> > > VM types, and it's expected that x86 will double down and require uni=
que
> > > VM types for TDX and SNP guests.
> > >
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > Message-Id: <20231027182217.3615211-30-seanjc@google.com>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> >
> > nit: as in a prior selftest commit messages, references in the commit
> > message to guest _private_ memory. Should these be changed to just
> > guest memory?
>
> Hmm, no, "private" is mostly appropriate here.  At this point in time, on=
ly x86
> supports KVM_CREATE_GUEST_MEMFD, and x86 only supports it for private mem=
ory.
> And the purpose of letting x86 selftests specify KVM_X86_SW_PROTECTED_VM,=
 i.e.
> the reason this patch exists, is purely to get private memory.
>
> Maybe tweak the second paragraph to this?
>
> Taking the VM type will allow adding tests for KVM_CREATE_GUEST_MEMFD
> without needing an entirely separate set of helpers.  At this time,
> guest_memfd is effectively usable only by confidential VM types in the
> form of guest private memory, and it's expected that x86 will double down
> and require unique VM types for TDX and SNP guests.

sgtm
/fuad

