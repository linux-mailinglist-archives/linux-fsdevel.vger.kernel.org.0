Return-Path: <linux-fsdevel+bounces-1545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A908D7DBD86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 17:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4032B20FE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7BD18E11;
	Mon, 30 Oct 2023 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIpHiLlY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF318C15
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 16:10:53 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D5DDA
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 09:10:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da033914f7cso3990941276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698682249; x=1699287049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/eJ4eIlm/QBKFGigGc88HjjNKR0Bxic1+CMFaJ9ygg=;
        b=xIpHiLlYMInUSLi5VCe6TqJpt61TrAn/5ZPqHyszcZVdiUz0c28xoPUwvcEMHNUUBu
         bjF6Yr/DB7VAqku0bXwkoDWpKKaLxSJLtdpMLXIhVr1yBgLYL10+qdippLa24OArU/Ob
         OwQ2TTIYKwbkYktDUAQAIdsnD/M4DgEeFtpYBvnMbhG3d/BCNvQoQVsQPU27dnX1jXDB
         UeMR4FLftEFiRahqkhojZ8222kP2JSVepRntLbr6vFa4dpcBCRJpOWtfBeutPekiBf49
         oUMkfOtdlQQrA4ZJF3Lld7zJYzp8Ky17grYE0WRGw7K9oXCY6meP3JgYnvf8zfFcsScO
         Pq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698682249; x=1699287049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/eJ4eIlm/QBKFGigGc88HjjNKR0Bxic1+CMFaJ9ygg=;
        b=iW6DhNGLeWFkdOh0Dox8qTS53TGFBq3Rr8VOzQIlUKqrL3DoWu2UawZTJdZ0cDnydu
         3MEMG/A6ynlWzuoBaP9m4U8AiJTpNj+HmvZ5QmNGTDhVbLlMJIPVIYe4BdSDyw+O3kr3
         2vsvNBpHFS5jX9aSPSTFfoWlIYXf5wljr1d9qfuuYc32k6CFO6xjZehH4iIdCYZubnR8
         HCj8ZSF1I97//oBDLioNpHevFJARdV1NEqLX9177hgWlYN01ZMdC01nUgr5nCjYVvsV8
         pIZ4oko4yGU0YBU+GJyTdHcoPAd97nyMtkZv2Qv8xcBOsKTiJqzxeuCHHqdJ4CgTb7yK
         qWvQ==
X-Gm-Message-State: AOJu0YyrcukXxAt33xbu3CUFZgIjgpGHv6Z6fjf2i5x3TbILXrsAt83l
	1a3xjJzgAqcTc8Zz/UaiYBoRjS2UZ8s=
X-Google-Smtp-Source: AGHT+IG/nj4LaX3JPzHZqsehR5FWhArOOi7E0ApKeqEkunCLK98IonUlxUU55c5VBDsNlZFSGb1icvfnahw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP id
 v3-20020a056902108300b00d9ac3b84274mr243782ybu.7.1698682249642; Mon, 30 Oct
 2023 09:10:49 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:10:48 +0000
In-Reply-To: <ZT9lQ9c7Bik6FIpw@chao-email>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-14-seanjc@google.com>
 <ZT9lQ9c7Bik6FIpw@chao-email>
Message-ID: <ZT_ViJOW1p4TN_fI@google.com>
Subject: Re: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
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
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Anish Moorthy <amoorthy@google.com>, David Matlack <dmatlack@google.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Maciej Szmigiero <mail@maciej.szmigiero.name>, David Hildenbrand <david@redhat.com>, 
	Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 30, 2023, Chao Gao wrote:
> On Fri, Oct 27, 2023 at 11:21:55AM -0700, Sean Christopherson wrote:
> >From: Chao Peng <chao.p.peng@linux.intel.com>
> >
> >In confidential computing usages, whether a page is private or shared is
> >necessary information for KVM to perform operations like page fault
> >handling, page zapping etc. There are other potential use cases for
> >per-page memory attributes, e.g. to make memory read-only (or no-exec,
> >or exec-only, etc.) without having to modify memslots.
> >
> >Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> >userspace to operate on the per-page memory attributes.
> >  - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
> >    a guest memory range.
> 
> >  - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
> >    memory attributes.
> 
> This ioctl() is already removed. So, the changelog is out-of-date and needs
> an update.

Doh, I lost track of this and the fixup for KVM_CAP_MEMORY_ATTRIBUTES below.

> >+:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> >+:Architectures: x86
> >+:Type: vm ioctl
> >+:Parameters: struct kvm_memory_attributes(in)
> 
> 					   ^ add one space here?

Ah, yeah, that does appear to be the standard.
> 
> 
> >+static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
> >+					  struct kvm_gfn_range *range)
> >+{
> >+	/*
> >+	 * Unconditionally add the range to the invalidation set, regardless of
> >+	 * whether or not the arch callback actually needs to zap SPTEs.  E.g.
> >+	 * if KVM supports RWX attributes in the future and the attributes are
> >+	 * going from R=>RW, zapping isn't strictly necessary.  Unconditionally
> >+	 * adding the range allows KVM to require that MMU invalidations add at
> >+	 * least one range between begin() and end(), e.g. allows KVM to detect
> >+	 * bugs where the add() is missed.  Rexlaing the rule *might* be safe,
> 
> 					    ^^^^^^^^ Relaxing
> 
> >@@ -4640,6 +4850,17 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> > 	case KVM_CAP_BINARY_STATS_FD:
> > 	case KVM_CAP_SYSTEM_EVENT_DATA:
> > 		return 1;
> >+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> >+	case KVM_CAP_MEMORY_ATTRIBUTES:
> >+		u64 attrs = kvm_supported_mem_attributes(kvm);
> >+
> >+		r = -EFAULT;
> >+		if (copy_to_user(argp, &attrs, sizeof(attrs)))
> >+			goto out;
> >+		r = 0;
> >+		break;
> 
> This cannot work, e.g., no @argp in this function and is fixed by a later commit:
> 
> 	fcbef1e5e5d2 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")

I'll post a fixup patch for all of these, thanks much!

