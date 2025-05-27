Return-Path: <linux-fsdevel+bounces-49923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FC0AC59B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 20:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97717A99D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 18:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3E2280304;
	Tue, 27 May 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JAx2E2LP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BFE277808;
	Tue, 27 May 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368884; cv=none; b=c7eblK3a0CTQFAwG4rV5snPjWngampR2Xjq4nJ1UUQVQ2Csb+C57t7UTYMKxUZF5ccydbAU0RSpBrVjwcXbrlNvj5I9zHUKYPWydhv8OBnxMW43GFGHTabz/eKjMA3XMw0jbMSNoWUACgJ9YAfNXT0ZX4F3DDo52gRpoEmMcj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368884; c=relaxed/simple;
	bh=rq45Wd9fN1m/TyZMt5EXiDwB96qCaumIAkssFgFE2Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQmZOgbikKO9Qgr9Pdcmu5i2uSlf+vnGLW5o/yd9RbPxtb/OUIM6TvQov5m7eS0IA93qmM2I79xYww3SZIj7wzgvYi7T6SNVpxenOvsQwaikZWqAyxqV1FywUyks25xTmGly8r78o4aSdUGs7+ZkjpzgE5ZbRI1AqhN7NytA2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JAx2E2LP; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4b6L6G48htz9sRk;
	Tue, 27 May 2025 20:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1748368870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDYlu01ERbR/ASESDCpdVLMfWx7Sul+gusj5BFguHbc=;
	b=JAx2E2LPxX/GiBDVDJWYxbga4OGfdUGa6ljxiOeDxJIaivADn5M8vIIkuB4R6ksdfzLQdy
	thbZ9KqY9mRXC2nxJPzkD2p6tcE3lLz/plUI0av79uByUYqWdwU3yuDhCPnZ2zie1HrCFP
	1qwFWtj0HaEzJ3T800KRKKPmTewtI17BfxkFi2fMq4TsfFjsBV/anLEKYpLAlTCCkEM3Jq
	Ek3UoE7/zHNN4RnOUwGsRUiIcvpUSvVQtXcWw5i7HkcwbcAMMLNCnkjGj9bt9PGEalbbKU
	jBCbnODDEpfDdHlYSPaKmeRz1Wyceextp9oSaAODxjdccPtcBgFUCkoJz89+xw==
Date: Tue, 27 May 2025 20:00:50 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, willy@infradead.org, x86@kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
Message-ID: <5dv5hsfvbdwyjlkxaeo2g43v6n4xe6ut7pjf6igrv7b25y2m5a@blllpcht5euu>
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
 <626be90e-fa54-4ae9-8cad-d3b7eb3e59f7@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626be90e-fa54-4ae9-8cad-d3b7eb3e59f7@intel.com>

On Tue, May 27, 2025 at 09:37:50AM -0700, Dave Hansen wrote:
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 055204dc211d..96f99b4f96ea 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -152,6 +152,7 @@ config X86
> >  	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
> >  	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
> >  	select ARCH_WANTS_THP_SWAP		if X86_64
> > +	select ARCH_WANTS_STATIC_PMD_ZERO_PAGE if X86_64
> 
> I don't think this should be the default. There are lots of little
> x86_64 VMs sitting around and 2MB might be significant to them.

This is the feedback I wanted. I will make it optional.

> > +config ARCH_WANTS_STATIC_PMD_ZERO_PAGE
> > +	bool
> > +
> > +config STATIC_PMD_ZERO_PAGE
> > +	def_bool y
> > +	depends on ARCH_WANTS_STATIC_PMD_ZERO_PAGE
> > +	help
> > +	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
> > +	  on demand and deallocated when not in use. This option will always
> > +	  allocate huge_zero_folio for zeroing and it is never deallocated.
> > +	  Not suitable for memory constrained systems.
> 
> "Static" seems like a weird term to use for this. I was really expecting
> to see a 2MB object that gets allocated in .bss or something rather than
> a dynamically allocated page that's just never freed.

My first proposal was along those lines[0] (sorry I messed up version
while sending the patches). David Hilderbrand suggested to leverage the
infrastructure we already have in huge_memory.

> 
> >  menuconfig TRANSPARENT_HUGEPAGE
> >  	bool "Transparent Hugepage Support"
> >  	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 11edc4d66e74..ab8c16d04307 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -203,9 +203,17 @@ static void put_huge_zero_page(void)
> >  	BUG_ON(atomic_dec_and_test(&huge_zero_refcount));
> >  }
> >  
> > +/*
> > + * If STATIC_PMD_ZERO_PAGE is enabled, @mm can be NULL, i.e, the huge_zero_folio
> > + * is not associated with any mm_struct.
> > +*/
> 
> I get that callers have to handle failure. But isn't this pretty nasty
> for mm==NULL callers to be *guaranteed* to fail? They'll generate code
> for the success case that will never even run.
> 

The idea was to still have dynamic allocation possible even if this
config was disabled.

You are right that if this config is disabled, the callers with NULL mm
struct are guaranteed to fail, but we are not generating extra code
because there are still users who want dynamic allocation.

Do you think it is better to have the code with inside an #ifdef instead
of using the IS_ENABLED primitive?

[1] https://lore.kernel.org/linux-fsdevel/20250516101054.676046-2-p.raghav@samsung.com/

--
Pankaj

