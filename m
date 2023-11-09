Return-Path: <linux-fsdevel+bounces-2499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808E7E65C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 09:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4341F281592
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1639C10966;
	Thu,  9 Nov 2023 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miA5Ux6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054F10947
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 08:55:34 +0000 (UTC)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449A1173E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 00:55:33 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-45da94f4b90so273225137.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 00:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699520132; x=1700124932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW/Fx883nWIRZKyM7HAb/UStNZnvbG60FpXDwf7xK7Y=;
        b=miA5Ux6BeoLkFdLSGXU2Gd0DrDaH5LsQLpxIbyvN2jV6Teh/ZNtmOJ599pe0EGfy9X
         mX4dfVVsLeMPJlvjGtNr2mDvltwSZ+jOHBmNg+VQh9KyH/PL/QEi2VJU9XMH8xyAzAyu
         jSgTHY+GFRl7Vsr+LgCkIHMbClE6iV1rHNloImwdpwRopWmzKPEGU5xRPRHzPx8WbyuK
         I/iVowS9lnn4kBu0ebdTtxynUAVaR9tiJuhe0RRjL75xGQrg0gDiNRVOXRIxMezvafLj
         kCWXLJTQBJB/5mjbjp4XRABK4KrmLQ6aWrcWq8oEKqxDjFDP57lWU61fRPbDQ7Pzs17h
         TrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520132; x=1700124932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW/Fx883nWIRZKyM7HAb/UStNZnvbG60FpXDwf7xK7Y=;
        b=bFeNXurY6Ltmtfael5WJXhmKURDTv+4ZLL1yb/owNkNCNQAWUN5jh2vkeAwuCsfLfN
         N/Kmb0G0BIXZ8EJmk7GiinGAfpAKcy3PFjnjmEPDXvyVdCCDvWbRroklSw+UagsS4Wja
         iHQLoLOE6MRMpo9M/IyNLAZMFOv/FpPY/UVDFuJX9tA2pQEy3TNIgty7UFhoFRu2Z5Su
         YY4/6BS2cVlveXUe839B+WUAIkRjQCZLcmHykC58vP7TsiID671y9JknZcwevacCP1nU
         o/NfJq4wGSPyBSRV6HOAXmPlxdtZx3viR6l2W7rbieqlYh0T9MtIDZSZnrqzUIcbwa9g
         w+Mg==
X-Gm-Message-State: AOJu0YwwbZQ6VdAshLZQltNwl8b9x4OMERTvLKJG7DmjHve9hVy0hkZ2
	HS5r8klq3j17Vuhp+blFMPOywFGa3W3aqSRMmWMqPw==
X-Google-Smtp-Source: AGHT+IFw1OMfZ7dogx5GHZ5PY3FJDFYi1Xj9fX4uGT6v90sIMw1YGf7XiATC8vKEmYII9um0nqZKnx8f2F+kXqvVgVE=
X-Received: by 2002:a67:c282:0:b0:45f:65e9:f070 with SMTP id
 k2-20020a67c282000000b0045f65e9f070mr3952209vsj.12.1699520132149; Thu, 09 Nov
 2023 00:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-35-pbonzini@redhat.com>
 <CAF7b7mpmuYLTY6OQfRRoOryfO-2e1ZumQ6SCQDHHPD5XFyhFTQ@mail.gmail.com>
In-Reply-To: <CAF7b7mpmuYLTY6OQfRRoOryfO-2e1ZumQ6SCQDHHPD5XFyhFTQ@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 9 Nov 2023 08:54:55 +0000
Message-ID: <CA+EHjTxxBUHX9Rg=vZ-UTWHUPKf0ujTsOsynueG7JAMt=GZQ0A@mail.gmail.com>
Subject: Re: [PATCH 34/34] KVM: selftests: Add a memory region subtest to
 validate invalid flags
To: Anish Moorthy <amoorthy@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sean Christopherson <seanjc@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Xu Yilun <yilun.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, David Matlack <dmatlack@google.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Maciej Szmigiero <mail@maciej.szmigiero.name>, 
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>, 
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anish,

On Thu, Nov 9, 2023 at 1:08=E2=80=AFAM Anish Moorthy <amoorthy@google.com> =
wrote:
>
> Applying [1] and [2] reveals that this also breaks non-x86 builds- the
> MEM_REGION_GPA/SLOT definitions are guarded behind an #ifdef
> __x86_64__, while the usages introduced here aren't.
>
> Should
>
> On Sun, Nov 5, 2023 at 8:35=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > +       test_invalid_memory_region_flags();
>
> be #ifdef'd, perhaps? I'm not quite sure what the intent is.
>
> Side note: I wasn't able to get [2] to apply by copy-pasting the diff
> and trying "git apply", and that was after checking out the relevant
> commit. Eventually I just did it manually. If anyone can successfully
> apply it, please let me know what you did so I can see what I was
> doing wrong :)

For me I applied the whole series as follows:

Checkout kvm-x86-next-2023.11.01 (45b890f7689e) from
https://github.com/kvm-x86/linux.git . Then use b4:
b4 am -o -  20231105163040.14904-1-pbonzini@redhat.com  | git am -3

Cheers,
/fuad

>
> [1] https://lore.kernel.org/kvm/20231108233723.3380042-1-amoorthy@google.=
com/
> [2] https://lore.kernel.org/kvm/affca7a8-116e-4b0f-9edf-6cdc05ba65ca@redh=
at.com/

