Return-Path: <linux-fsdevel+bounces-21812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB80A90AA76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9941C2577B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935C194A43;
	Mon, 17 Jun 2024 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="umgAJ6Pd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB6192B7B;
	Mon, 17 Jun 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618335; cv=none; b=J42plPLkFeVGW0WlR6tM6oBb8G0slN8hYtatQqhEyof4dIJtek76ZWgmrOtfBOcUdoJP8CAEfQQWk5UzeF2rbk6TqPtEGkwEK2KAJgO6uNG5+z0qoMCcPomBXBcLHbTuqmknqrJxhd4E0Nti0H3YA4UgPLFLxGTVWi5X5srHThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618335; c=relaxed/simple;
	bh=HvhKIusqhv0QYOohu6wIC1VtGHOpgCgrv0aENa/RRGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoNUd1wowjMqP2A7Olv8IZnWXwaj4GvOXT4SmUzZTzMTmR5rsWOPaud3uGTWaFXuOcv5qkvMQcmU1IWZV4FKM8f4OWpkETuB//mwohslEre2hKjnSlFz8b3sXx3pMM0dRVZlWig+RBfJQcMuJ5pif8rbr6g9zK7nXIkcqZAReno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=umgAJ6Pd; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W2lhN23x4z9spd;
	Mon, 17 Jun 2024 11:58:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718618324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRAO++uIw1OUPfCgvfEWhKZYeaVhnnf0jX/BR+wX6Vs=;
	b=umgAJ6PdVIvo1wrvo40xC9EWOxHYypeWr0lw6BtV9NA/2Me5+5OvAtUc1A/Nnk9QDeWBj/
	zW2B9Y7M6R+mc40tNnuCFKX5VK7/51W50WOtQK2diJavDG9ddfhPZwv/Pt22DKvS9eda9U
	TNQFQ+xejRkMez8YcZe65whPPPBpNlvGvLnoclr5yT0rJNrO4XXwTBt62Y2XgIoa6mZ+42
	zKFgtPvP0zFDKKv/kuv2xANddBq3awOf+OHay7/HAFWtKW1MWMu7GnIHGwa2tujZ9j5c90
	X0wWDh6Z7bxCpIak+bkdqfPusHr62lqpAnjaxqj+eonmTPYwVoZxK9KNh49oKA==
Date: Mon, 17 Jun 2024 09:58:37 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@lst.de>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
	mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <20240617095837.bzf4xiv2jxv6j7vt@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-4-kernel@pankajraghav.com>
 <20240613084409.GA23371@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613084409.GA23371@lst.de>
X-Rspamd-Queue-Id: 4W2lhN23x4z9spd

On Thu, Jun 13, 2024 at 10:44:10AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 07, 2024 at 02:58:54PM +0000, Pankaj Raghav (Samsung) wrote:
> > +static inline unsigned long mapping_min_folio_nrpages(struct address_space *mapping)
> > +{
> > +	return 1UL << mapping_min_folio_order(mapping);
> > +}
> 
> Overly long line here, just line break after the return type.
> 
> Then again it only has a single user just below and no documentation
> so maybe just fold it into the caller?

I do use it in later patches. I will adjust the long line here :)

> 
> >  no_page:
> >  	if (!folio && (fgp_flags & FGP_CREAT)) {
> > -		unsigned order = FGF_GET_ORDER(fgp_flags);
> > +		unsigned int min_order = mapping_min_folio_order(mapping);
> > +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
> >  		int err;
> > +		index = mapping_align_start_index(mapping, index);
> 
> I wonder if at some point splitting this block that actually allocates
> a new folio into a separate helper would be nice.  It just keep growing
> in size and complexity.
> 

I agree with that. I will put it in my future todo backlog.

> > -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
> > +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
> > +				    min_order);
> 
> Nit: no need to split this into multiple lines.

Ok.
> 
> >  	if (!folio)
> >  		return -ENOMEM;
> >  
> > @@ -2471,6 +2478,8 @@ static int filemap_create_folio(struct file *file,
> >  	 * well to keep locking rules simple.
> >  	 */
> >  	filemap_invalidate_lock_shared(mapping);
> > +	/* index in PAGE units but aligned to min_order number of pages. */
> 
> in PAGE_SIZE units?  Maybe also make this a complete sentence?
Yes, will do.
> 

