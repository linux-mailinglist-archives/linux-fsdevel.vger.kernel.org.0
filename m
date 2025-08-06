Return-Path: <linux-fsdevel+bounces-56826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6C8B1C1AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 09:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086113B8104
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69F921CA0D;
	Wed,  6 Aug 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="0b2IpAP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C621B196;
	Wed,  6 Aug 2025 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467179; cv=none; b=QPSymd7h+QqCqwNE7TxFB6pi9QqQxe2d34yJyYhYxcigp2F3ipVducKQCN/W9uDJQaSiDdnj6gQ1Cy2OgBupuOP/T0pghhvmLDBiXFvq7mm3Emo27PDisaMXe5UamdHJJ+rAtQ4ZtS+FTEMO/WNrS5/cOjNffBiSZQ0pDbKVn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467179; c=relaxed/simple;
	bh=trhDUCIG43TQqInyEvd9Cbwg7kM97yUh+fTLm/66F68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZAp2fPOHa4GMA6CNAF3MMlHwF1WnEtRI5+b95vy/Q/gk3ZBLtH5nTMvKk8JFwuppxzTGoHMS3Sq//++QW4mbWqskyHS0TODGYq+/lJt1LRZjFCSDujiA6QS7HddE96GxNdU+vc9AHVaaW1ASXlZ/HvxMBcG7dgzmJYMjvPFvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=0b2IpAP4; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxjPH4Y4lz9tBc;
	Wed,  6 Aug 2025 09:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754467171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Izcp9KuJI+N7osGOh6Vm4q57YAFEIRc/7Ly3D8UvEW0=;
	b=0b2IpAP4U2GqYHCfS3+UCXCCMobCaNQBdn2HGjCQ6RNQQ9gNcDTGQUO+CZEO3246QD63Ni
	fh6mCF9nihlKauPvY082zw9Nfx4EO6h2h/BpmtFKHsIkVLKZBLADDsL+VoinXKZhDSpX7c
	NU4zLg/9psNKroMwzfLs92f0IM/SBfNKzzfHi0l1Cw9z7R1hwpfuBtJxbZOR75G1TcreIz
	XtHEEsg404RxpgElhPyVSFsoWaJ6CRRgvKXkddHZ1XwHujLWm4ShBv/5oS3P8YELj1mb27
	MrRivpRTh+BcvvaumZ/v9iQ9sGZmesjimdBkYzHEfwFzC0wiy/CslvUT6CX2FA==
Date: Wed, 6 Aug 2025 09:59:15 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 4/5] mm: add largest_zero_folio() routine
Message-ID: <ib67jxoli3qaw4ntmgrhhumlkrn4hicjnjzbocmwwi7t2vls73@fczc5msyhy37>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-5-kernel@pankajraghav.com>
 <b810103c-ee95-4cc9-8b59-4dc6b1847d1e@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b810103c-ee95-4cc9-8b59-4dc6b1847d1e@intel.com>

On Tue, Aug 05, 2025 at 09:42:14AM -0700, Dave Hansen wrote:
> On 8/4/25 05:13, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Add largest_zero_folio() routine so that huge_zero_folio can be
> > used directly when CONFIG_STATIC_HUGE_ZERO_FOLIO is enabled. This will
> > return ZERO_PAGE folio if CONFIG_STATIC_HUGE_ZERO_FOLIO is disabled or
> > if we failed to allocate a huge_zero_folio.
> 
> This changelog is telling a lot of the "what" but none of the "why".
> 
> The existing huge zero folio API is for users that have an mm. This is
> *only* for folks that want a huge zero folio but don't have an mm.
> That's _why_ this function is needed. It's in this series because there
> was no way to get a huge zero folio before the permanent one was
> introduced in this series.
> 
> Can we please get some of that into the function comment and changelog?
> It's critical.

Valid point. I will include that in the next version.

> 
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 78ebceb61d0e..c44a6736704b 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -716,4 +716,21 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
> >  	return split_folio_to_list_to_order(folio, NULL, new_order);
> >  }
> >  
> > +/*
> > + * largest_zero_folio - Get the largest zero size folio available
> > + *
> > + * This function will return huge_zero_folio if CONFIG_STATIC_HUGE_ZERO_FOLIO
> > + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
> > + *
> > + * Deduce the size of the folio with folio_size instead of assuming the
> > + * folio size.
> > + */
> 
> This comment needs to get fleshed out. It at _least_ needs to say
> something along the lines of:
> 
> 	Use this when a huge zero folio is needed but there is no mm
> 	lifetime to tie it to. Basically, use this when you can't use
> 	mm_get_huge_zero_folio().
> 

Agreed.

> > +static inline struct folio *largest_zero_folio(void)
> > +{
> > +	struct folio *folio = get_static_huge_zero_folio();
> > +
> > +	if (folio)
> > +		return folio;
> 
> There needs to be a newline in here.
> 
> > +	return page_folio(ZERO_PAGE(0));
> > +}
> >  #endif /* _LINUX_HUGE_MM_H */
> 
> The code is fine, but the changelog and comments need quite a bit of work.

Sounds good to me. I will make the changes. Thanks Dave.

--
Pankaj

