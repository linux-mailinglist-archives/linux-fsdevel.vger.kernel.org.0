Return-Path: <linux-fsdevel+bounces-23036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A51926326
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C431DB2C2AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD887139D16;
	Wed,  3 Jul 2024 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="C2fz+mVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C21DA30B;
	Wed,  3 Jul 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015856; cv=none; b=NLgGtzj6VvY8Jao8fQdUfGEoc0FwoE3O2A0I18KClXdE5hIm1+jVy3tmLzbvn5CoaVVNQUMEg7FWqKg79wkmTrIY61v2gK3M3ixPIY1MwiwdEN0uLSNVPmCdURbal9v+14Rqx97KwFuDLWwrgy+B0FQwKXd+u4+tTP0J5zfmAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015856; c=relaxed/simple;
	bh=VrVulKOahEoHnf5UszbeVZhRhb7sGuiMqK2L7prlgXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaswUjmAil98m0SGPdRVBAGMVFZF1Co8XKGauI1HbyGdOvyjs0P0CPyvavafpHDEB+iYEVyBVrhrPFLTLRQDHHmWFORV61mq78UY1h4qQ6F3SErxLRkKZ/ACkMNjQX/nfJKXxv0/DcxzOfH3qemTUeqx+d7YBS2wSqTDUln69lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=C2fz+mVm; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WDhWs3v88z9sm1;
	Wed,  3 Jul 2024 16:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720015849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXpVIyLXa5RONdGy3OA52ljljZmCJJvzA1+hEq9fd9A=;
	b=C2fz+mVmyHPxBeREqrWubAF7AeZ7580YCG6z0/n9hCTbzgkkoOk02uJ+YZ14RU3zE1aLQf
	aoarcg4Ic+bkS5AYM1q9ViOnI0SpvKmFBwHXOOjo1t+BvR4L+B88eYLstczkxT43GmSee7
	L/1VNAugdR7MaAS78PrNXqiCNnoVh+E/zMlEytp7WRTjNgQAIgXruO0cDpWcItZ/BRmZK5
	vCBqXM1B4wJitcNBJN3h7wJzP0HcG+SJkLSHy+z8JPADUemb5V0RL4HGyz5tuSi314dr9r
	fuSMj1M3ES9MPcgt0nWhWNnvKYjQ4zuRMkW7WExrHol7azMjfnjpD2zhj4mMdw==
Date: Wed, 3 Jul 2024 14:10:42 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 03/10] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <20240703141042.ihpay2xxsya44yys@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-4-kernel@pankajraghav.com>
 <20240702193830.GM612460@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702193830.GM612460@frogsfrogsfrogs>

On Tue, Jul 02, 2024 at 12:38:30PM -0700, Darrick J. Wong wrote:
> On Tue, Jun 25, 2024 at 11:44:13AM +0000, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > page_cache_ra_unbounded() was allocating single pages (0 order folios)
> > if there was no folio found in an index. Allocate mapping_min_order folios
> > as we need to guarantee the minimum order if it is set.
> > While we are at it, rework the loop in page_cache_ra_unbounded() to
> > advance with the number of pages in a folio instead of just one page at
> > a time.
> 
> Ok, sounds pretty straightforward so far.
> 
> > page_cache_ra_order() tries to allocate folio to the page cache with a
> > higher order if the index aligns with that order. Modify it so that the
> > order does not go below the mapping_min_order requirement of the page
> > cache. This function will do the right thing even if the new_order passed
> > is less than the mapping_min_order.
> 
> Hmm.  So if I'm understanding this correctly: Currently,
> page_cache_ra_order tries to allocate higher order folios if the
> readahead index happens to be aligned to one of those higher orders.
> With the minimum mapping order requirement, it now expands the readahead
> range upwards and downwards to maintain the mapping_min_order
> requirement.  Right?
> 
Yes. We only expand because the index that was passed needs to included
and not excluded.

> > When adding new folios to the page cache we must also ensure the index
> > used is aligned to the mapping_min_order as the page cache requires the
> > index to be aligned to the order of the folio.
> > 
> > readahead_expand() is called from readahead aops to extend the range of
> > the readahead so this function can assume ractl->_index to be aligned with
> > min_order.
> 
> ...and I guess this function also has to be modified to expand the ra
> range even further if necessary to align with mapping_min_order.  Right?

Yes! This function is a bit different from other two because this is
called from readahead aops callback while the other two are responsible
for calling the readahead aops. That is why we can assume the index
passed is aligned to min order.

> 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Co-developed-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > ---
> >  mm/readahead.c | 81 +++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 63 insertions(+), 18 deletions(-)
> > 
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 66058ae02f2e..2acfd6447d7b 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -206,9 +206,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  		unsigned long nr_to_read, unsigned long lookahead_size)
> >  {
> >  	struct address_space *mapping = ractl->mapping;
> > -	unsigned long index = readahead_index(ractl);
> > +	unsigned long ra_folio_index, index = readahead_index(ractl);
> >  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> > -	unsigned long i;
> > +	unsigned long mark, i = 0;
> > +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> >  
> >  	/*
> >  	 * Partway through the readahead operation, we will have added
> > @@ -223,10 +224,26 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> 
> I'm not as familiar with this function since xfs/iomap don't use it.

This function ultimately invokes xfs_vm_readahead through read_pages().
So it sort of sits above xfs aops.

> >  	unsigned int nofs = memalloc_nofs_save();
> >  
> >  	filemap_invalidate_lock_shared(mapping);
> > +	index = mapping_align_index(mapping, index);
> > +
> > +	/*
> > +	 * As iterator `i` is aligned to min_nrpages, round_up the
> > +	 * difference between nr_to_read and lookahead_size to mark the
> > +	 * index that only has lookahead or "async_region" to set the
> > +	 * readahead flag.
> > +	 */
> > +	ra_folio_index = round_up(readahead_index(ractl) + nr_to_read - lookahead_size,
> > +				  min_nrpages);
> 
> So at this point we've rounded index down and the readahead region up to
> fit the min_nrpages requirement.  I'm not sure what the lookahead region
> does, since nobody passes nonzero.  Judging from the other functions, I
> guess that's the region that we're allowed to do asynchronously?
> 
> > +	mark = ra_folio_index - index;
> 
> Ah, ok, yes.  We mark the first folio in the "async" region so that we
> (re)start readahead when someone accesses that folio.

Yes. I think we consider it as a hit, so we could expand the readahead
window now.

> 
> > +	if (index != readahead_index(ractl)) {
> > +		nr_to_read += readahead_index(ractl) - index;
> > +		ractl->_index = index;
> > +	}
> 
> So then if we rounded inded down, now we have to add that to the ra
> region.

Yes. I could also make it unconditional because if index ==
readahead_index(ractl), nr_to_read and ractl->_index will just remain
the same. Probably that is more efficient than having a conditinal and
then a substraction.

> 
> > +
> >  	/*
> > +	if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size)
> >  		goto fallback;
> >  
> >  	limit = min(limit, index + ra->size - 1);
> > @@ -507,11 +532,20 @@ void page_cache_ra_order(struct readahead_control *ractl,
> >  		new_order += 2;
> >  		new_order = min(mapping_max_folio_order(mapping), new_order);
> >  		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
> > +		new_order = max(new_order, min_order);
> >  	}
> >  
> >  	/* See comment in page_cache_ra_unbounded() */
> >  	nofs = memalloc_nofs_save();
> >  	filemap_invalidate_lock_shared(mapping);
> > +	/*
> > +	 * If the new_order is greater than min_order and index is
> > +	 * already aligned to new_order, then this will be noop as index
> > +	 * aligned to new_order should also be aligned to min_order.
> > +	 */
> > +	ractl->_index = mapping_align_index(mapping, index);
> > +	index = readahead_index(ractl);
> 
> I guess this also rounds index down to mapping_min_order...
Yes.
> 
> > +
> >  	while (index <= limit) {
> >  		unsigned int order = new_order;
> >  
> > @@ -519,7 +553,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
> >  		if (index & ((1UL << order) - 1))
> >  			order = __ffs(index);
> >  		/* Don't allocate pages past EOF */
> > -		while (index + (1UL << order) - 1 > limit)
> > +		while (order > min_order && index + (1UL << order) - 1 > limit)
> >  			order--;
> 
> ...and then we try to find an order that works and doesn't go below
> min_order.  We already rounded index down to mapping_min_order, so that
> will always succeed.  Right?

Yes. We never go less than min order, even if it means extending
slightly beyond the isize (hence also the mmap fix later on in the
series).

> 
> >  		err = ra_alloc_folio(ractl, index, mark, order, gfp);
> >  		if (err)
> >  
> > @@ -821,9 +864,11 @@ void readahead_expand(struct readahead_control *ractl,
> >  		if (folio && !xa_is_value(folio))
> >  			return; /* Folio apparently present */
> >  
> > -		folio = filemap_alloc_folio(gfp_mask, 0);
> > +		folio = filemap_alloc_folio(gfp_mask, min_order);
> >  		if (!folio)
> >  			return;
> > +
> > +		index = mapping_align_index(mapping, index);
> >  		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
> >  			folio_put(folio);
> >  			return;
> > @@ -833,10 +878,10 @@ void readahead_expand(struct readahead_control *ractl,
> >  			ractl->_workingset = true;
> >  			psi_memstall_enter(&ractl->_pflags);
> >  		}
> > -		ractl->_nr_pages++;
> > +		ractl->_nr_pages += min_nrpages;
> >  		if (ra) {
> > -			ra->size++;
> > -			ra->async_size++;
> > +			ra->size += min_nrpages;
> > +			ra->async_size += min_nrpages;
> 
> ...and here we are expanding the ra window yet again, only now taking
> min order into account.  Right?  Looks ok to me, though again, iomap/xfs
> don't use this function so I'm not that familiar with it.

It is used only by few filesystems but that is the idea. Before we used
to add single pages but now we add min_order worth of pages if it is
set. Very similar to previous patch.

> 
> If the answer to /all/ the questions is 'yes' then
> 
> Acked-by: Darrick J. Wong <djwong@kernel.org>

Thanks, I will add it :)

