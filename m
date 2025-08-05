Return-Path: <linux-fsdevel+bounces-56736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711BAB1B294
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 13:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207C9189CE55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EFB24DCF9;
	Tue,  5 Aug 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="PtgDFKnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B811D5CEA;
	Tue,  5 Aug 2025 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754393121; cv=none; b=FFSCfEEQw2OZOZwyu3ooDMFyOwarGeMXOIpHrFAX2nsUACUAuupPzxLtxjHsLyZVA8nnl+768lEI5D/ubX3ZsKbWF39ESXoGArDYO2Jr5i2UnQD+iSUpAu3buFPAAy/lFJZGrM319XqC7nufC8F3Zh1AA3FFZOgRdWTLl6ahngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754393121; c=relaxed/simple;
	bh=mnnifQxifPOWk8/7voqxe3B5s2Ddz6Hobd4XUZ79fjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzOcmUFRTXvqKRABRpeRA3Ar2/Jjs2pf1rE57Ail2HNgj1wT8dIoCWn+pgmgI6015F729yhFAFrIetLo568gRF0uucjeP3XraB28LzuX9uXC/0lqxVkzpeX1lvPkpWh7OJtHCR+OZGdwJyYyelmGfezwBRPC7zf593mh4RT6FN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=PtgDFKnz; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxB0z6nbYz9t6m;
	Tue,  5 Aug 2025 13:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754393108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUqghyW3Gb16EpTzfk2IyTRYy66SrKEo+Ar4DAbeucY=;
	b=PtgDFKnz1FTIzGDYS+qF37UY4zwnjW+1Of3QbKKYeiHOuVqz60tfycdjsMLn31ptCKJCXI
	MCcdzweG19TGdEGmh02rzNll96Wn/rPTEFMJ4e9j2fH+d9sEXXRDmVXl8jhFaROD+xgNlm
	elM0yU3OPkf2Fmnh/F20D9s/Kx4mccUq7pdQlDyq6IZQgPqigw/BVxgfa/amyYplMiuazy
	X/u4zPJPGjs2xtg9i+zZhh+7yK/gIOAshYZz5svDFiZWOy87yPvhLOgiBD7h6dN+BJNQUz
	CYl37Hp4D5yMNssgTN9aAEeGePrhQq87dgwCedPTncwHfoeTLNkafkzPqlJrfQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Tue, 5 Aug 2025 13:24:53 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 4/5]  mm: add largest_zero_folio() routine
Message-ID: <tg6papaakluarhu4cz6tmu2ukgjlyzonvxjdgylbjefl6fmjy3@l6jre7k7sois>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-5-kernel@pankajraghav.com>
 <bcb9940a-18ae-48e6-b000-53fca461fff8@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb9940a-18ae-48e6-b000-53fca461fff8@lucifer.local>
X-Rspamd-Queue-Id: 4bxB0z6nbYz9t6m

On Mon, Aug 04, 2025 at 05:50:46PM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 04, 2025 at 02:13:55PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >
> > Add largest_zero_folio() routine so that huge_zero_folio can be
> > used directly when CONFIG_STATIC_HUGE_ZERO_FOLIO is enabled. This will
> > return ZERO_PAGE folio if CONFIG_STATIC_HUGE_ZERO_FOLIO is disabled or
> > if we failed to allocate a huge_zero_folio.
> >
> > Co-developed-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> This looks good to me minus nit + comment below, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
Thanks.
> > ---
> >  include/linux/huge_mm.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 78ebceb61d0e..c44a6736704b 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -716,4 +716,21 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
> >  	return split_folio_to_list_to_order(folio, NULL, new_order);
> >  }
> >
> > +/*
> 
> Maybe let's make this a kernel doc comment?
Yes, I will change it in the next version :)
> 
> > + * largest_zero_folio - Get the largest zero size folio available
> > + *
> > + * This function will return huge_zero_folio if CONFIG_STATIC_HUGE_ZERO_FOLIO
> > + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
> > + *
> > + * Deduce the size of the folio with folio_size instead of assuming the
> > + * folio size.
> > + */
> > +static inline struct folio *largest_zero_folio(void)
> > +{
> > +	struct folio *folio = get_static_huge_zero_folio();
> > +
> > +	if (folio)
> > +		return folio;
> > +	return page_folio(ZERO_PAGE(0));
> 
> Feels like we should have this in a wrapper function somewhere. Then again it
> seems people generally always open-code 'ZERO_PAGE(0)' anyway so maybe this is
> sort of the 'way things are done'? :P
> 
> > +}
> >  #endif /* _LINUX_HUGE_MM_H */
> > --
> > 2.49.0
> >

