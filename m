Return-Path: <linux-fsdevel+bounces-11555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F32854AC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 14:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3F528BC2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2637554BE2;
	Wed, 14 Feb 2024 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JMRxzCjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22252F85;
	Wed, 14 Feb 2024 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918804; cv=none; b=m4T1DdWIF1eSZHHGPWtVu/Tt8Hyw82QtRvIyejxbOHINJR9mvQjag4vNjt25WQhxTug+poznS4E3kP/hgHoyNmd+4NFLczC87/KRY/uLHof3VNQUQGIQJgZ6a2ZvR/Fxgy/jNJJtTUzx/mWm7d9+wNxnz1txAl47s+YlNUfM1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918804; c=relaxed/simple;
	bh=YpA7bONSsZgNbBAnV91WbZ8toW2ppPhIUw4IaPbutb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiGhhizU1ysnzJC0xASof8agpjSM32UfqpvCKzZBFjlhAa6kJH/DzjtNu4Bkc9aFvohoVzwKpex2PNy64wpVLjn0XPIADNB86WC/nt3AKf04RK5tykLFXWP5yrjxfmkbXBdlrW0y3Ib5/QZrZCjW3uEWu37fDllVH3DSXi+iAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JMRxzCjz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TZfm92ClQz9sSV;
	Wed, 14 Feb 2024 14:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707918793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgaJ49BhAMCLOE6dIaBl/wo8RSey7cGj+RjgTwSx7ZY=;
	b=JMRxzCjz3aXN4ygkKy0nGgnkoH+yYQGcDxiFsx6+ZU9TQNe6YG58EpL5ItS32oE3HuW2ki
	EZk7Eqy9sEIyTczO8ML6OSm8Sb310sk6+0k6CdzDKeLJ5l3Ht1bu95DGVWkk+hRnOtPIMR
	dk+v88kLjoovJGwIuGZjw2d2lNCzXIc/rOrJxPPwIIwyOPSZVEdbCyzYMscEV0cJKmUoqg
	SZBtTVLIu9uqxQwlezn8uEOKshKoYxPhPBGSfW9hu+uOVpu61tG8d5fRYTMCn4yafcYoJP
	YrIcTEpu5EtVONCwsJOYGA/U0ACNBTnwi1W77P63U6mpSOyFytpGDhx06QVnvg==
Date: Wed, 14 Feb 2024 14:53:04 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 04/14] readahead: set file_ra_state->ra_pages to be at
 least mapping_min_order
Message-ID: <npesqtrkkaslbebsnycnvjuoh6znq5lddxau3v3b7ce5ocnd22@ncosz6mtqsz7>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-5-kernel@pankajraghav.com>
 <ZcvosYG9F0ImM9OS@dread.disaster.area>
 <c7fkrrjybapcf3h5sks3skb2ynv7hw4qpplw4kaimjkfas2nls@v522lehxqxqm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7fkrrjybapcf3h5sks3skb2ynv7hw4qpplw4kaimjkfas2nls@v522lehxqxqm>
X-Rspamd-Queue-Id: 4TZfm92ClQz9sSV

On Wed, Feb 14, 2024 at 02:32:20PM +0100, Pankaj Raghav (Samsung) wrote:
> On Wed, Feb 14, 2024 at 09:09:53AM +1100, Dave Chinner wrote:
> > On Tue, Feb 13, 2024 at 10:37:03AM +0100, Pankaj Raghav (Samsung) wrote:
> > > From: Luis Chamberlain <mcgrof@kernel.org>
> > > 
> > > Set the file_ra_state->ra_pages in file_ra_state_init() to be at least
> > > mapping_min_order of pages if the bdi->ra_pages is less than that.
> > > 
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  mm/readahead.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/mm/readahead.c b/mm/readahead.c
> > > index 2648ec4f0494..4fa7d0e65706 100644
> > > --- a/mm/readahead.c
> > > +++ b/mm/readahead.c
> > > @@ -138,7 +138,12 @@
> > >  void
> > >  file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
> > >  {
> > > +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> > > +	unsigned int max_pages = inode_to_bdi(mapping->host)->io_pages;
> > > +
> > >  	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> > > +	if (ra->ra_pages < min_nrpages && min_nrpages < max_pages)
> > > +		ra->ra_pages = min_nrpages;
> > 
> > Why do we want to clamp readahead in this case to io_pages?
> > 
> > We're still going to be allocating a min_order folio in the page
> > cache, but it is far more efficient to initialise the entire folio
> > all in a single readahead pass than it is to only partially fill it
> > with data here and then have to issue and wait for more IO to bring
> > the folio fully up to date before we can read out data out of it,
> > right?

I think I misunderstood your question. I got more context after seeing
your next response.

You are right, I will remove the clamp to io_pages. So a single FSB
might be split into multiple IOs if the underlying block device has
io_pages < min_nrpages.

> 
> We are not clamping it to io_pages. ra_pages is set to min_nrpages if
> bdi->ra_pages is less than the min_nrpages. The io_pages parameter is
> used as a sanity check so that min_nrpages does not go beyond it.
> 
> So maybe, this is not the right place to check if we can at least send
> min_nrpages to the backing device but instead do it during mount?
> 
> > 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com

