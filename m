Return-Path: <linux-fsdevel+bounces-1909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 961337E0013
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226F0B214C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E169612B80;
	Fri,  3 Nov 2023 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLifHEsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3001170D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 09:42:57 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419BD45
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 02:42:55 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67089696545so10627316d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 02:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699004575; x=1699609375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KR3uUy+lpOtuK74sFvr5LpDDKafluOWW+OG46f9Hrzo=;
        b=PLifHEsmRHpPtO/bkvhueEZllLgnEf4sVw6fk80yY0NqAEoWrTttWEylmGiTW/kb46
         2ok3ePRS9R9U2ILpGsYJe7bLWUG7M9JJI7ZDxHWExAN+5qKG4gqzN6IbjrJklS1GdQi9
         5IrvE85NDccRnOTaSzRWCO+3krPNSZU9Ca4BFDbHxd/NixgAlfBIAarCl3eyi4ff2ZnV
         KIpWMS1ct6ZmKkbjGa705xZrzg1wKXMVJ47GfI1SzW9/E1U/y7y+X2mAiwez7KkSo47A
         7ZulluUL0N9pHvg2X++2Dig8zDdbVBMxzepsYZH04yBYIBcsRuz/pMZw8hSSltN5h97G
         PJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699004575; x=1699609375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KR3uUy+lpOtuK74sFvr5LpDDKafluOWW+OG46f9Hrzo=;
        b=UvnTgAQ+Qgd5amkPbyUek4xK+zK73iq55ESnZbd0PnMJXekmK6HRmzyQEZBLKmWD0h
         GDm0SFkqZWyTtMIg+FUGX5ZtPdngN2f1UWmPMdlw4BiegiBgcc5IP0H8Fj28JUsANmx/
         r4qRzmB7adHT1+fZkCY1H+O0RCTU66wY63VmJdW+L8dCdyed+SPI4279gf7MSFGPiGzk
         M+J2jXI0D0u/LfltJ+RXs5w0SYY5osrR69drjJVsvLVf6+zRwA5t1owXi+llEpMMOwUU
         bENBfVV7P/F8+Becrr5nICMRWBb4qkL/DdBw73ypLekavXrblpiwWEDeROBqHAv6saLJ
         NG3Q==
X-Gm-Message-State: AOJu0YwIA05rw11hiBUy8nUbywxXaJ/pFeVltgsyj50A2mbUd0wCVP48
	ScbVVOpoyocL2Tt2U0RYDzZRVIEAnp7lDNKSA7LAmw==
X-Google-Smtp-Source: AGHT+IHMtnnuJ+fshc7oeOwDt21mO974uTwKm6avpjixqQMFQPk6nu4AOneq997yl+dXgdaxeuVP+cu76MznLmTOvmQ=
X-Received: by 2002:a05:6214:401c:b0:66d:34a8:3ed0 with SMTP id
 kd28-20020a056214401c00b0066d34a83ed0mr22048546qvb.26.1699004574544; Fri, 03
 Nov 2023 02:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-17-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 3 Nov 2023 09:42:17 +0000
Message-ID: <CA+EHjTxEvJpfA7urRj6EbbuwTGWAw6ZYu6NmX9sLT5Cdp5p3eA@mail.gmail.com>
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

Hi,

...

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e2252c748fd6..e82c69d5e755 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst

...

> +4.141 KVM_CREATE_GUEST_MEMFD
> +----------------------------
> +
> +:Capability: KVM_CAP_GUEST_MEMFD
> +:Architectures: none
> +:Type: vm ioctl
> +:Parameters: struct struct kvm_create_guest_memfd(in)

One struct too many.

Cheers,
/fuad

