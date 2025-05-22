Return-Path: <linux-fsdevel+bounces-49669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBE6AC0AFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 14:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878B01BA83FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B71628A73C;
	Thu, 22 May 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Pkv878VW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6828A70A;
	Thu, 22 May 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915243; cv=none; b=nM5kpv8eRrx0N1CVA16apfsjoQ45sAsT26WY8lnYzPighD+YJuKDmBJdN5V1gj1s/g96BHNUVv8EQI2U8FDWSjs/P47CKZO5maizMw1TtFId/mFol4DvAxlGiiw7i+dZ2njXUdxiSuu8+FuXAGRPl8oYfD6dMc3z5L694U0KmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915243; c=relaxed/simple;
	bh=Z4X0XCrbM0mnB5ZH4yaTgRVEEMoqTq9XQP/4zfL/KUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn1aw05fY5unknkMlj3Uvb+oIRHY+2SRsIhyLi0iokn2qe6UOWxcx/7/xpu6e7lQSH7RZnbPdAuno0DLWHMe5hCw1/yq5JXheZo52Kq4PT2dnoBtl6fbyzAE89kfNTPOXeA53X37XiLnL30YBYOA3inO2Wb81Du0bKgU/o1keQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Pkv878VW; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4b36LY6tWDz9sX2;
	Thu, 22 May 2025 14:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1747915238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YiqNVJ3Ja/qa7EwLGVyAuJ+LbC6RFtVqKpoDvDxemGo=;
	b=Pkv878VWYaSiGxGtPIxOgTTFm1YVhgzPuTL6FagLP/Z9FzSB5h1tbzrk4qw07Vv9LJMK5y
	vyxih8RFzNo8TMj7z3HH5GC2HxN57o+ceICE5WE0dVf2oSUE+jSWCrQ7Yset+0BvYKlQCH
	CE9KfRLIi4SlTX41Tn/oBimuri9Kd7rT1Wy2G2ymVxjxDREGRpaRtNz9bPQwxZ3OZICSrU
	mt0ETZMnRrfT7pmyW/qnMtMRbvOQtnCXT0H1x6n5w4VAeDH3y/9fQHMA64mdJOgUZr1hmS
	mPDzZzGytUxb/CKDvMgyjwePoPwUfW72VW2negsBOFtlSo8IzGaFd7BYsW/Mwg==
Date: Thu, 22 May 2025 14:00:14 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Ryan Roberts <ryan.roberts@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Zi Yan <ziy@nvidia.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, gost.dev@samsung.com, 
	hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, x86@kernel.org, mcgrof@kernel.org
Subject: Re: [RFC v2 0/2] add THP_HUGE_ZERO_PAGE_ALWAYS config option
Message-ID: <6lhepdol4nlnht7elb7jx7ot5hhckiegyyl6zeap2hmltdwb5t@ywsaklwnakuh>
References: <20250522090243.758943-1-p.raghav@samsung.com>
 <aC8LGDwJXvlDl866@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC8LGDwJXvlDl866@kernel.org>
X-Rspamd-Queue-Id: 4b36LY6tWDz9sX2

Hi Mike,

> > Add a config option THP_HUGE_ZERO_PAGE_ALWAYS that will always allocate
> > the huge_zero_folio, and it will never be freed. This makes using the
> > huge_zero_folio without having to pass any mm struct and a call to put_folio
> > in the destructor.
> 
> I don't think this config option should be tied to THP. It's perfectly
> sensible to have a configuration with HUGETLB and without THP.
>  

Hmm, that makes sense. You mean something like this (untested):

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2e1527580746..d447a9b9eb7d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -151,8 +151,8 @@ config X86
        select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP   if X86_64
        select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP       if X86_64
        select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
+       select ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS if X86_64
        select ARCH_WANTS_THP_SWAP              if X86_64
-       select ARCH_WANTS_THP_ZERO_PAGE_ALWAYS  if X86_64
        select ARCH_HAS_PARANOID_L1D_FLUSH
        select BUILDTIME_TABLE_SORT
        select CLKEVT_I8253
diff --git a/mm/Kconfig b/mm/Kconfig
index a2994e7d55ba..83a5b95a2286 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -823,9 +823,19 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARCH_WANTS_THP_SWAP
        def_bool n
 
-config ARCH_WANTS_THP_ZERO_PAGE_ALWAYS
+config ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS
        def_bool n
 
+config HUGE_ZERO_PAGE_ALWAYS
+       def_bool y
+       depends on HUGETLB_PAGE && ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS
+       help
+         Typically huge_zero_folio, which is a huge page of zeroes, is allocated
+         on demand and deallocated when not in use. This option will always
+         allocate huge_zero_folio for zeroing and it is never deallocated.
+         Not suitable for memory constrained systems.
+
+
 config MM_ID
        def_bool n
 
@@ -898,15 +908,6 @@ config READ_ONLY_THP_FOR_FS
          support of file THPs will be developed in the next few release
          cycles.
 
-config THP_ZERO_PAGE_ALWAYS
-       def_bool y
-       depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_ZERO_PAGE_ALWAYS
-       help
-         Typically huge_zero_folio, which is a THP of zeroes, is allocated
-         on demand and deallocated when not in use. This option will always
-         allocate huge_zero_folio for zeroing and it is never deallocated.
-         Not suitable for memory constrained systems.
-
 config NO_PAGE_MAPCOUNT
        bool "No per-page mapcount (EXPERIMENTAL)"
        help

--
Pankaj

