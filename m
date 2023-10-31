Return-Path: <linux-fsdevel+bounces-1662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A847DD5FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 19:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AD8B21016
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932022309;
	Tue, 31 Oct 2023 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXXCc/Ey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3B21364
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 18:24:15 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F1E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 11:24:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc1e1e74beso42095955ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698776653; x=1699381453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fA4BSuC8POmGjMQJ0k8vnna5BPAxY9Ekm8SCU7EDDBY=;
        b=pXXCc/EymZAI1UfbBeV5XR71rJrHgRQDUI+akFhgXsPfgrMeKf3TltpNq883kc+Ihu
         1qmVyqyIJuErRmSkaVwfEL8WigX4tzxKfuYTviGsSTGl6jekGQ71OKEZ7bpv5cYxYL8l
         LLsSt+Tpm3NOmyuXbcLqSLtimYgKpEfLzmdJARApIikDo0k5vQcc0DwflTL8jMw/uDs8
         aXRDjVO3HuVdjkVUEJ75WF1WkeoDES5/XCb8dAxlwOO4J3Qu8nLSFlhdv/IacwLrtgX1
         jePZ+d1Bh7cLoCKTRLq/EIe+IX92jP3G1HMuSH0Yb+88y6p2TuvEwJIpd8mVDEhfXIwR
         Rmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698776653; x=1699381453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fA4BSuC8POmGjMQJ0k8vnna5BPAxY9Ekm8SCU7EDDBY=;
        b=K2/J9St8QQnHonevPqp9ggd38pujGhWtT5akwvaZFlw3sCqZuLAWeLi+F2iA44TUEz
         Hk25pXk0uPc2jC4KEPcLyM8+cHzN+FGWOGvP5mec0QZfRvx3/SFokKvXQA/7FhqlxJkW
         3qAYA/WBs4vSCuSzSE3bhWvTzGfEGnkOkHTd8OuOszKHe6J8VjWaxLdIUN9feqhrhPF4
         NWy4jzEyZr9Ha2jQePoxnM2HSSiiUlhs9ndp/6Opk7a1TGAOzsW7iQbAc2Oo0VR0TtsF
         VscQ+i6WIqmNIL72KG63NuaUWfJ87jTwVanVIyT16j8iA19xoyG1Epgl4rfZXJ+R1LTD
         5+jg==
X-Gm-Message-State: AOJu0Yz4rryjwoK6nGhSzBuxVawb77QvpgghO9MYyHG2GcMEb2t6WcrW
	AUjhr/fHgE+QilYg4i1wwj2rmw==
X-Google-Smtp-Source: AGHT+IFxkiDdZGGfHsdazjXYZcfW0cI1Huw/6T3VggKB9s0vUh/sA7Jolgtag5oCOtU2pTLnT1L5FA==
X-Received: by 2002:a17:902:ecca:b0:1cc:54b5:b4fa with SMTP id a10-20020a170902ecca00b001cc54b5b4famr5681643plh.18.1698776652868;
        Tue, 31 Oct 2023 11:24:12 -0700 (PDT)
Received: from google.com (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001c5dea67c26sm1620267pll.233.2023.10.31.11.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:24:11 -0700 (PDT)
Date: Tue, 31 Oct 2023 11:24:07 -0700
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Maciej Szmigiero <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>,
	Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
Message-ID: <ZUFGRyQEuWj4RJS0@google.com>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-17-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231027182217.3615211-17-seanjc@google.com>

On 2023-10-27 11:21 AM, Sean Christopherson wrote:
> Introduce an ioctl(), KVM_CREATE_GUEST_MEMFD, to allow creating file-based
> memory that is tied to a specific KVM virtual machine and whose primary
> purpose is to serve guest memory.
> 
> A guest-first memory subsystem allows for optimizations and enhancements
> that are kludgy or outright infeasible to implement/support in a generic
> memory subsystem.  With guest_memfd, guest protections and mapping sizes
> are fully decoupled from host userspace mappings.   E.g. KVM currently
> doesn't support mapping memory as writable in the guest without it also
> being writable in host userspace, as KVM's ABI uses VMA protections to
> define the allow guest protection.  Userspace can fudge this by
> establishing two mappings, a writable mapping for the guest and readable
> one for itself, but that’s suboptimal on multiple fronts.
> 
> Similarly, KVM currently requires the guest mapping size to be a strict
> subset of the host userspace mapping size, e.g. KVM doesn’t support
> creating a 1GiB guest mapping unless userspace also has a 1GiB guest
> mapping.  Decoupling the mappings sizes would allow userspace to precisely
> map only what is needed without impacting guest performance, e.g. to
> harden against unintentional accesses to guest memory.
> 
> Decoupling guest and userspace mappings may also allow for a cleaner
> alternative to high-granularity mappings for HugeTLB, which has reached a
> bit of an impasse and is unlikely to ever be merged.
> 
> A guest-first memory subsystem also provides clearer line of sight to
> things like a dedicated memory pool (for slice-of-hardware VMs) and
> elimination of "struct page" (for offload setups where userspace _never_
> needs to mmap() guest memory).

All of these use-cases involve using guest_memfd for shared pages, but
this entire series sets up KVM to only use guest_memfd for private
pages.

For example, the per-page attributes are a property of a KVM VM, not the
underlying guest_memfd. So that implies we will need separate
guest_memfds for private and shared pages. But a given memslot can have
a mix of private and shared pages. So that implies a memslot will need
to support 2 guest_memfds? But the UAPI only allows 1 and uses the HVA
for shared mappings.

My initial reaction after reading through this series is that the
per-page private/shared should be a property of the guest_memfd, not the
VM. Maybe it would even be cleaner in the long-run to make all memory
attributes a property of the guest_memfd. That way we can scope the
support to only guest_memfds and not have to worry about making per-page
attributes work with "legacy" HVA-based memslots.

Maybe can you sketch out how you see this proposal being extensible to
using guest_memfd for shared mappings?

