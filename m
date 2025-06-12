Return-Path: <linux-fsdevel+bounces-51523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91445AD7CB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 22:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1927AA864
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 20:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370B2D878B;
	Thu, 12 Jun 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="iZwhEzvY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7F2BE7D7;
	Thu, 12 Jun 2025 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749761681; cv=none; b=eo2VR3UYY7fWZmBReEzIbWrDIdm7WG1IGFIQv64vJIL+OtYQzsTs9mbRLBM8S4v5/Kftsi4g6sRnFr2B4Yp8KX7DKBjmbAqcRzku8qSRzVc8lxa8B/FGWA2q8JVwkktZskBGMOxsyoxRB0QF6LWJte0EQ1RXYpdfyB30G6Jgou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749761681; c=relaxed/simple;
	bh=6P5cbaAl8rTt1XMIQMPvx6uTYWL/JwGk967YHx7eCtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs/CBqJ1v03I2VNSiz6JbCPZzhy7y5EYzmxuuBIinJW7tWLgraWXL7DgWJ9YeZ2P1Fne0IiBoi5lMuiDrrwWxtR1f1Qx+6jSa8wtdVA2JOS/H2xBhCdGDy+HcFhjDwDGDn/Z3PfrNFxQwjnKBq01sFgg7ZjJz8wXnwXuDh09aJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=iZwhEzvY; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bJFBz4y5Jz9t7n;
	Thu, 12 Jun 2025 22:54:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1749761675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMqfz5QP21cfg2NCOI8fXNl9RMD8SNqZRc2zFgJBMAw=;
	b=iZwhEzvYWF83q7vfuMaVVdkC7ni+BF6LjRTCNacgi7U44mGZxBYd2q/TXF7Ca3rRKYdItU
	NUgz7qHGRZMfSmTVAKhe3TxmO+Qk05M9l9tGcoW/2QwmlBvVxX64taW30RoE/wW+D11NOM
	djFNftsO30QF7YJfCkQ/GplV4f4hky6I9UiUH2Z+x1YSc8njtD4/CYqoiGHiakIvAc+dsK
	wAo6UxQlsBF1xc8KbSmLDnd8QliEucrqrX5UyPsP1s0nN/eW/4vkykI9RDo334phcgRNbq
	rTXu+RytbxrtPM8jeGB1yOpaJV3cAC0V4C6sFCmQXSnH4w3d8viTGkZ+Mr0R+g==
Date: Thu, 12 Jun 2025 22:54:28 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de
Subject: Re: [PATCH 4/5] mm: add mm_get_static_huge_zero_folio() routine
Message-ID: <cglmujb275faqkpqmb75mz4tt5dtruvhntpe5t4qyzjr363qyr@vluzyx4hukap>
References: <20250612105100.59144-1-p.raghav@samsung.com>
 <20250612105100.59144-5-p.raghav@samsung.com>
 <e3075e27-93d2-4a11-a174-f05a7497870e@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3075e27-93d2-4a11-a174-f05a7497870e@intel.com>

On Thu, Jun 12, 2025 at 07:09:34AM -0700, Dave Hansen wrote:
> On 6/12/25 03:50, Pankaj Raghav wrote:
> > +/*
> > + * mm_get_static_huge_zero_folio - Get a PMD sized zero folio
> 
> Isn't that a rather inaccurate function name and comment?
I agree. I also felt it was not a good name for the function.

> 
> The third line of the function literally returns a non-PMD-sized zero folio.
> 
> > + * This function will return a PMD sized zero folio if CONFIG_STATIC_PMD_ZERO_PAGE
> > + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
> > + *
> > + * Deduce the size of the folio with folio_size instead of assuming the
> > + * folio size.
> > + */
> > +static inline struct folio *mm_get_static_huge_zero_folio(void)
> > +{
> > +	if(IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE))
> > +		return READ_ONCE(huge_zero_folio);
> > +	return page_folio(ZERO_PAGE(0));
> > +}
> 
> This doesn't tell us very much about when I should use:
> 
> 	mm_get_static_huge_zero_folio()
> vs.
> 	mm_get_huge_zero_folio(mm)
> vs.
> 	page_folio(ZERO_PAGE(0))
> 
> What's with the "mm_" in the name? Usually "mm" means "mm_struct" not
> Memory Management. It's really weird to prefix something that doesn't
> take an "mm_struct" with "mm_"

Got it. Actually, I was not aware of this one.

> 
> Isn't the "get_" also a bad idea since mm_get_huge_zero_folio() does its
> own refcounting but this interface does not?
> 

Agree.

> Shouldn't this be something more along the lines of:
> 
> /*
>  * pick_zero_folio() - Pick and return the largest available zero folio
>  *
>  * mm_get_huge_zero_folio() is preferred over this function. It is more
>  * flexible and can provide a larger zero page under wider
>  * circumstances.
>  *
>  * Only use this when there is no mm available.
>  *
>  * ... then other comments
>  */
> static inline struct folio *pick_zero_folio(void)
> {
> 	if (IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE))
> 		return READ_ONCE(huge_zero_folio);
> 	return page_folio(ZERO_PAGE(0));
> }
> 
> Or, maybe even name it _just_: zero_folio()

I think zero_folio() sounds like a good and straightforward name. In
most cases it will return a ZERO_PAGE() folio. If
CONFIG_STATIC_PMD_ZERO_PAGE is enabled, then we return a PMD page.

Thanks for all your comments Dave.

--
Pankaj

