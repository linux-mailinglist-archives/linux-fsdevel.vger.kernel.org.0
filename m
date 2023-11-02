Return-Path: <linux-fsdevel+bounces-1857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F67DF750
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 17:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B27B21311
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CCB1DA32;
	Thu,  2 Nov 2023 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJNOze6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B91D69C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 16:03:47 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28015138
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 09:03:45 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5bd18d549bbso974336a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698941024; x=1699545824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iqXbuRKMyvTfyAi0R6oHncN26PfYTo3tctDI41vJWU=;
        b=TJNOze6kt+FsA9v0I74BIpCjw9fge82sCtaK3cxtT6c0KZEdKSzBh4zG31U+RQGN7+
         RBc5D+JpR6UnV3KagOIZh/k0QWAS7g+80tHuxJWkMkRcptC9bydUspTt+ACMT2HAase2
         fXKjWpOYXDOWK/pGCUZdZDZUFeL6l0Um/28DOwX4QiyMEnKher3A3Rm80G3S+GZA8zOu
         8WeQaicXLIC7Cclvl/uP6/detJrBYWN3Khg0/VrDjV7a/4uhH35JM2byF4Fn7t6fjYJG
         lcIyR8iLWXR3b1X3wXSx08815FLcwy3qN//DPxL2Py0ry4RP/UvDUbRELdcVSBVZTg4/
         g/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698941024; x=1699545824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iqXbuRKMyvTfyAi0R6oHncN26PfYTo3tctDI41vJWU=;
        b=mdLY9G8p8ChcRtirxHrhes4v1qJ9CplLul7in6g36znEJk3mH1HgXxsAeEVzdA4bjk
         DGhV+xrn06Tw7f+RuKgRugo/l5UR4ZNIxGNd7uE9AiF2yNSQx6Bq8JXkP3h277KZmMxg
         QE5PzmVKbbO3Bdw9XZahL6VYcH88M3qgPNnDXHtn6mBSGsm6AC165s7H0P/gsypa1BJP
         IIAy4jH3zmAQs7BrBhfJ2xcjwJLA2BztRLKMgSdvFAQL4M3/r4ikf6kGHWT4G8sLNe2o
         lGBZDEfqYlGXmMLU2hOe6CNFGMX+se3bS6hUBIsQI9LZqsMJKhhXg4CYqH0PKWxkBwlb
         7mPQ==
X-Gm-Message-State: AOJu0Yx1zsUyKic5Kepnr1RdX9LJCma/J/CkdHIOTJkBbNijNZFhzaaN
	rQc8H7wJnyFXbj8jLFf4CZjM/xEVsio=
X-Google-Smtp-Source: AGHT+IFM1Nz2eAP9Xmws9JoQjAGGS19Q55KF/ifRxAflcrAzQHFBFIOS8V+26ERzfv1Lm5CG2bErCCPJO0Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1304:b0:1cc:2ffe:5a33 with SMTP id
 iy4-20020a170903130400b001cc2ffe5a33mr266680plb.8.1698941024519; Thu, 02 Nov
 2023 09:03:44 -0700 (PDT)
Date: Thu, 2 Nov 2023 09:03:42 -0700
In-Reply-To: <6642c379-1023-4716-904f-4bbf076744c2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <ZUFGRyQEuWj4RJS0@google.com> <ZUFzZf-YmCRYP6qo@google.com>
 <CALzav=d9eXZfK=op7A=UftbpuPpUbxqV6CmkqqxxBNuNsUU4nw@mail.gmail.com> <6642c379-1023-4716-904f-4bbf076744c2@redhat.com>
Message-ID: <ZUPIXt1XzZrriswG@google.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Matlack <dmatlack@google.com>, Marc Zyngier <maz@kernel.org>, 
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
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Anish Moorthy <amoorthy@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 02, 2023, Paolo Bonzini wrote:
> On 10/31/23 23:39, David Matlack wrote:
> > > > Maybe can you sketch out how you see this proposal being extensible to
> > > > using guest_memfd for shared mappings?
> > > For in-place conversions, e.g. pKVM, no additional guest_memfd is needed.  What's
> > > missing there is the ability to (safely) mmap() guest_memfd, e.g. KVM needs to
> > > ensure there are no outstanding references when converting back to private.
> > > 
> > > For TDX/SNP, assuming we don't find a performant and robust way to do in-place
> > > conversions, a second fd+offset pair would be needed.
> > Is there a way to support non-in-place conversions within a single guest_memfd?
> 
> For TDX/SNP, you could have a hook from KVM_SET_MEMORY_ATTRIBUTES to guest
> memory.  The hook would invalidate now-private parts if they have a VMA,
> causing a SIGSEGV/EFAULT if the host touches them.
> 
> It would forbid mappings from multiple gfns to a single offset of the
> guest_memfd, because then the shared vs. private attribute would be tied to
> the offset.  This should not be a problem; for example, in the case of SNP,
> the RMP already requires a single mapping from host physical address to
> guest physical address.

I don't see how this can work.  It's not a M:1 scenario (where M is multiple gfns),
it's a 1:N scenario (wheren N is multiple offsets).  The *gfn* doesn't change on
a conversion, what needs to change to do non-in-place conversion is the pfn, which
is effectively the guest_memfd+offset pair.

So yes, we *could* support non-in-place conversions within a single guest_memfd,
but it would require a second offset, at which point it makes sense to add a
second file descriptor as well.  Userspace could still use a single guest_memfd
instance, i.e. pass in the same file descriptor but different offsets.

