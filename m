Return-Path: <linux-fsdevel+bounces-57265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0F3B201E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D73E189ED34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D282DBF43;
	Mon, 11 Aug 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="XtS6umrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568A1684AC;
	Mon, 11 Aug 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901226; cv=none; b=cXaVaziB+7IfrmvB6QJcK2t1sGmnxHRH6RDlixIju3+XIyq+iA19RRU72NqwPvRIignb1CPreFT0yYElQOIp+jAc/0qLABxwjHYInC2n7bGKTxpi/rvuGhak+he80R7X1BKg68WVsVJeGIyrzLnM1cbumNPt20HC6T6YPT83tGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901226; c=relaxed/simple;
	bh=19//WNniioF1RGdOOKjdwR6H+y6ZEtBrUm+JQpP+7IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM9LObgd0SOsuzY8JNWlaTw7KTtdZP55C1LAnaKkRfegbxGaBojR739411h89fkSowQVrHGyQ218enMz1dchqbBOLmVaSro2QdgVQk4Dgv+Ip+vIO/uus+NZfiJ8I3mszHlFzB+PD9EvAP5TQ90lQF6nd8btb3Z8UO0+f/cEWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=XtS6umrv; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c0nwL3hDmz9t8p;
	Mon, 11 Aug 2025 10:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754901218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4ETZNjirUvV9akuA5/N3WpKRJ7fdFCPYyiPJLhsHNM=;
	b=XtS6umrvBfaWyDKYetycnjHwPkC7sF9zvwuGE7ixK0REHwd2OC63DMCH25SJePZjgrWytT
	/kUhKVKi20Cf6AhWAPcckzhfQePFOjfVHApRENh33pJnvaAO80tVRpCEo9wb+pdQcZJjxD
	IxKy8X58dewt+Z9LvOMZu3YT6x2rAUDXG3Mz8XemXCvXP4K6p/FJk0q3CfzmAWIdCJFY1f
	hfmen7ObaUdD5QWi/DH4XScjSiLfn6xE1p/3YkOo4PFodddJxFgxQZjI8zSsZlVY0/WMnu
	grRVLKhscyOIf1L8kX/6SpnQTSsA98QRgK/EZFA8PEavFD8dmIhQ55jU7GHdWg==
Date: Mon, 11 Aug 2025 10:33:08 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 3/5] mm: add persistent huge zero folio
Message-ID: <cgtgtq7ctkouzu6ki3nvzugw5txcgygtf6nducrqvbok7ajuhd@cqjtygxpsgnr>
References: <20250808121141.624469-1-kernel@pankajraghav.com>
 <20250808121141.624469-4-kernel@pankajraghav.com>
 <731d8b44-1a45-40bc-a274-8f39a7ae0f7f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731d8b44-1a45-40bc-a274-8f39a7ae0f7f@lucifer.local>

> This is much nicer and now _super_ simple, I like it.

Thanks to you and David :)

> 
> A few nits below but generally:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks.
> 
> > ---
> >  include/linux/huge_mm.h | 16 ++++++++++++++++
> >  mm/Kconfig              | 16 ++++++++++++++++
> >  mm/huge_memory.c        | 40 ++++++++++++++++++++++++++++++----------
> >  3 files changed, 62 insertions(+), 10 deletions(-)
> >
> >  static inline int split_folio_to_list_to_order(struct folio *folio,
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index e443fe8cd6cf..fbe86ef97fd0 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -823,6 +823,22 @@ config ARCH_WANT_GENERAL_HUGETLB
> >  config ARCH_WANTS_THP_SWAP
> >  	def_bool n
> >
> > +config PERSISTENT_HUGE_ZERO_FOLIO
> > +	bool "Allocate a PMD sized folio for zeroing"
> > +	depends on TRANSPARENT_HUGEPAGE
> 
> I feel like we really need to sort out what is/isn't predicated on THP... it
> seems like THP is sort of short hand for 'any large folio stuff' but not
> always...
> 
> But this is a more general point :)

I already brought this topic once during THP cabal. I am thinking of
submitting a talk about this topic for LPC Memory Management MC.

> 
> > +	help
> > +	  Enable this option to reduce the runtime refcounting overhead
> > +	  of the huge zero folio and expand the places in the kernel
> > +	  that can use huge zero folios. This can potentially improve
> > +	  the performance while performing an I/O.
> 
> NIT: I think we can drop 'an', and probably refactor this sentence to something
> like 'For instance, block I/O benefits from access to large folios for zeroing
> memory'.
> 
> > +
> > +	  With this option enabled, the huge zero folio is allocated
> > +	  once and never freed. One full huge page worth of memory shall
> > +	  be used.
> 
> NIT: huge page worth -> huge page's worth
> 

Thanks for the comments. I will make those changes and send a new
version.

--
Pankaj

