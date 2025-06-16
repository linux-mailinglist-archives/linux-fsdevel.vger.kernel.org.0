Return-Path: <linux-fsdevel+bounces-51726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB00ADAD96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B397916F458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B22980BF;
	Mon, 16 Jun 2025 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="PtBEAxVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A82882D1;
	Mon, 16 Jun 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070513; cv=none; b=orK0/Tu9Du4Aoe640vK3or25xVo7vFY5ddowmZDPYV2rYaHV40ts90q0wPFa4GNqY30UkcSKKrNG+OKCb1MAvEPQU/nAesSw+nLiCKHS6HnAe6GPKkGG26CP5O87FmR/0sC2Ps3QGOUzN241C7kxsgZvEKk1PFLcO0I8JTvoBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070513; c=relaxed/simple;
	bh=9jQvnHzyUbfSeBBYrBGACK8W4qVfv3z2D1HKLv2ml1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAWufnPUobbgfmsWuZxnBWPHbEMz4myzyoKbq0hCOvrrVXzB6Wu0Lv8wVACN7gEXsXe+lgwwU1CKLf5T0/eCtjpSQlnermnflI8bWqdziHezAiXWhfJICtZNGPmu0Xbte/Omko/QlYhh0fuq5ffEmH48/kczW3sDmnjnT4HdBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=PtBEAxVo; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bLRPy4Xyfz9sNv;
	Mon, 16 Jun 2025 12:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750070502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oSk0eziRiPQxIm2xpJSi+rzCVxixCf2/SUD1VuuXvA=;
	b=PtBEAxVon6X+5TauyCHml0gSVf0/dK0Bz09Z5ym8rKg8H0PYZ0URJ2w6F67+4+9YsFlBbj
	2uqpgH2adVdkOzlaFbsakNOPFL//WXshXak1la9GF6kJZzioWFauDyUmTXiQq3gm9Bb7e4
	OX3Lv8MiZ+P5Q1prPdc6ZBk0Bf/U++79fnNB8SFUNatFwc/owqStWtcOjYtcq5Of1BHCAG
	jTVDO6nrqSYc+xd6t2OIpVGjyNy7POqsgHeexXChHIZp+jVRhcqyjGVph/fPLxYFA5ta/z
	j5ZwBcoaSXf5cO5A55o6PN7HSajou51Pgas4/J5heggkVtC13NIjOxpoN9msow==
Date: Mon, 16 Jun 2025 12:41:30 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de
Subject: Re: [PATCH 4/5] mm: add mm_get_static_huge_zero_folio() routine
Message-ID: <xyp7neexwts566fndmfdwivcrg4qmdu2nfv2nppcjukvpog3ib@ieuhruutubos>
References: <20250612105100.59144-1-p.raghav@samsung.com>
 <20250612105100.59144-5-p.raghav@samsung.com>
 <e3075e27-93d2-4a11-a174-f05a7497870e@intel.com>
 <cglmujb275faqkpqmb75mz4tt5dtruvhntpe5t4qyzjr363qyr@vluzyx4hukap>
 <a65ee315-23b7-4058-895a-69045829bd01@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65ee315-23b7-4058-895a-69045829bd01@redhat.com>

On Mon, Jun 16, 2025 at 11:14:07AM +0200, David Hildenbrand wrote:
> On 12.06.25 22:54, Pankaj Raghav (Samsung) wrote:
> > On Thu, Jun 12, 2025 at 07:09:34AM -0700, Dave Hansen wrote:
> > > On 6/12/25 03:50, Pankaj Raghav wrote:
> > > > +/*
> > > > + * mm_get_static_huge_zero_folio - Get a PMD sized zero folio
> > > 
> > > Isn't that a rather inaccurate function name and comment?
> > I agree. I also felt it was not a good name for the function.
> > 
> > > 
> > > The third line of the function literally returns a non-PMD-sized zero folio.
> > > 
> > > > + * This function will return a PMD sized zero folio if CONFIG_STATIC_PMD_ZERO_PAGE
> > > > + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
> > > > + *
> > > > + * Deduce the size of the folio with folio_size instead of assuming the
> > > > + * folio size.
> > > > + */
> > > > +static inline struct folio *mm_get_static_huge_zero_folio(void)
> > > > +{
> > > > +	if(IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE))
> > > > +		return READ_ONCE(huge_zero_folio);
> > > > +	return page_folio(ZERO_PAGE(0));
> > > > +}
> > > 
> > > This doesn't tell us very much about when I should use:
> > > 
> > > 	mm_get_static_huge_zero_folio()
> > > vs.
> > > 	mm_get_huge_zero_folio(mm)
> > > vs.
> > > 	page_folio(ZERO_PAGE(0))
> > > 
> > > What's with the "mm_" in the name? Usually "mm" means "mm_struct" not
> > > Memory Management. It's really weird to prefix something that doesn't
> > > take an "mm_struct" with "mm_"
> > 
> > Got it. Actually, I was not aware of this one.
> > 
> > > 
> > > Isn't the "get_" also a bad idea since mm_get_huge_zero_folio() does its
> > > own refcounting but this interface does not?
> > > 
> > 
> > Agree.
> > 
> > > Shouldn't this be something more along the lines of:
> > > 
> > > /*
> > >   * pick_zero_folio() - Pick and return the largest available zero folio
> > >   *
> > >   * mm_get_huge_zero_folio() is preferred over this function. It is more
> > >   * flexible and can provide a larger zero page under wider
> > >   * circumstances.
> > >   *
> > >   * Only use this when there is no mm available.
> > >   *
> > >   * ... then other comments
> > >   */
> > > static inline struct folio *pick_zero_folio(void)
> > > {
> > > 	if (IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE))
> > > 		return READ_ONCE(huge_zero_folio);
> > > 	return page_folio(ZERO_PAGE(0));
> > > }
> > > 
> > > Or, maybe even name it _just_: zero_folio()
> > 
> > I think zero_folio() sounds like a good and straightforward name. In
> > most cases it will return a ZERO_PAGE() folio. If
> > CONFIG_STATIC_PMD_ZERO_PAGE is enabled, then we return a PMD page.
> 
> "zero_folio" would be confusing I'm afraid.
> 
> At least with current "is_zero_folio" etc.
> 
> "largest_zero_folio" or sth. like that might make it clearer that the size
> we are getting back might actually differ.
> 

That makes sense. I can change that in the next revision.

--
Pankaj

