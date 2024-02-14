Return-Path: <linux-fsdevel+bounces-11562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4F854C3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD9FB284CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566935C90D;
	Wed, 14 Feb 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="kH0iXx3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77B5BADB;
	Wed, 14 Feb 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923469; cv=none; b=XtnERapfleKE6ptLD+TwxEN1WsA6LZ96HosjH6q3D1cXwdLK6BwoSUz1Cg87LOJpiXZgE/x4hcc9tBBEzbmv/xfF/+ABKyhJCCS/+m/mrXlBRUWN5xyIZh/cGorPmYZhUDw28ynqrMA0iX4ID5QEKXLFpMPRQQV5o2v3gg5DrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923469; c=relaxed/simple;
	bh=PF39l2bZrJFGfu/twCh0/YL/uVsfoTDiSFMxz8HbfrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcOlzuw00g1GNq9J4EA+D5r9iktJ97sSLEBgmKqXFiD54YsxotiCYkxJJxl1GKRnpXd+KXdyDd3qaQIrR3yEfDdCsm79tjB92gr1X7/gbvCQbBSglaxQ0lYmOImBQKFuvJsP95t+/AKBnsApGjZd6NmSS03hYLEDPZU6wbmpSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=kH0iXx3O; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TZhTt1K3zz9sQh;
	Wed, 14 Feb 2024 16:10:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707923458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y5oOwF/jwjqn3ZhiI16vrltxvvH9rJjUK6O56MFSA3w=;
	b=kH0iXx3OU2AoKeH6+Kv7FS4/2NWtV8KoexHqWiCOdkUo/NakgP/SLL8kn3XbonyRiPvxM1
	xweUKOFsXEph+f1Y+4qHbZXJJ5fAmfSGM/7WEMES0alv+D2bW/ce+9YByMx38zZay/6AEZ
	CVscFMEvW50awHywXWFu8qw8IJDRfMiTFa8RLU6ekYW0SODWCv6jisilBIKhE8JmyyUqVB
	wM5W6asehG6X4ku8nSNfuDsIEYAuyLEOjJ87tHBFSTd1QZWTXqPBjfoy5nEs6JyWfqxFtX
	HPsytRboAbF6mpy6GcpR1vakUMivXpK3sGt5PXj1JOa0P1kyotHYuNx1Uz84pw==
Date: Wed, 14 Feb 2024 16:10:51 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 05/14] readahead: align index to mapping_min_order in
 ondemand_ra and force_ra
Message-ID: <dgtdqakqkyqvnjeujt2j5dwkolwlx7cna6ounuask2vrxyj64s@na6tkgwllyoe>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-6-kernel@pankajraghav.com>
 <ZcvtUOecezQD7Mm6@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcvtUOecezQD7Mm6@dread.disaster.area>

> > @@ -324,6 +325,13 @@ void force_page_cache_ra(struct readahead_control *ractl,
> >  	 * be up to the optimal hardware IO size
> >  	 */
> >  	index = readahead_index(ractl);
> > +	if (!IS_ALIGNED(index, min_nrpages)) {
> > +		unsigned long old_index = index;
> > +
> > +		index = round_down(index, min_nrpages);
> > +		nr_to_read += (old_index - index);
> > +	}
> 
> 	new_index = mapping_align_start_index(mapping, index);
> 	if (new_index != index) {
> 		nr_to_read += index - new_index;
> 		index = new_index
Looks good.

> 	}
> 
> > +
> >  	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
> >  	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
> 
> This needs to have a size of at least the minimum folio order size
> so readahead can fill entire folios, not get neutered to the maximum
> IO size the underlying storage supports.

So something like:

> >  	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
> >  	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
nr_to_read = max(nr_to_read, min_order);

> 
> > + * For higher order address space requirements we ensure no initial reads
> > + * are ever less than the min number of pages required.
> > + *
> > + * We *always* cap the max io size allowed by the device.
> >   */
> > -static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
> > +static unsigned long get_init_ra_size(unsigned long size,
> > +				      unsigned int min_nrpages,
> > +				      unsigned long max)
> >  {
> >  	unsigned long newsize = roundup_pow_of_two(size);
> >  
> > +	newsize = max_t(unsigned long, newsize, min_nrpages);
> 
> This really doesn't need to care about min_nrpages. That rounding
> can be done in the caller when the new size is returned.

Sounds good.

> 
> >  	if (newsize <= max / 32)
> >  		newsize = newsize * 4;
> 
> >  
> >  
> > @@ -561,7 +583,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
> >  	unsigned long add_pages;
> >  	pgoff_t index = readahead_index(ractl);
> >  	pgoff_t expected, prev_index;
> > -	unsigned int order = folio ? folio_order(folio) : 0;
> > +	unsigned int min_order = mapping_min_folio_order(ractl->mapping);
> > +	unsigned int min_nrpages = mapping_min_folio_nrpages(ractl->mapping);
> > +	unsigned int order = folio ? folio_order(folio) : min_order;
> 
> Huh? If we have a folio, then the order is whatever that folio is,
> otherwise we use min_order. What if the folio is larger than
> min_order? Doesn't that mean that this:
> 
> > @@ -583,8 +609,8 @@ static void ondemand_readahead(struct readahead_control *ractl,
> >  	expected = round_down(ra->start + ra->size - ra->async_size,
> >  			1UL << order);
> >  	if (index == expected || index == (ra->start + ra->size)) {
> > -		ra->start += ra->size;
> > -		ra->size = get_next_ra_size(ra, max_pages);
> > +		ra->start += round_down(ra->size, min_nrpages);
> > +		ra->size = get_next_ra_size(ra, min_nrpages, max_pages);
> 
> may set up the incorrect readahead range because the folio order is
> larger than min_nrpages?

Hmm... So I think we should just increment ra->start by ra->size, and
make sure to round the new size we get from get_next_ra_size() to
min_nrpages. Then we will not disturb the readahead range and always
increase the range in multiples of min_nrpages:

ra->start += ra->size;
ra->size = round_up(get_next_ra_size(ra, max_pages), min_nrpages);

> 
> >  		ra->async_size = ra->size;
> >  		goto readit;
> >  	}
> > @@ -603,13 +629,18 @@ static void ondemand_readahead(struct readahead_control *ractl,
> >  				max_pages);
> >  		rcu_read_unlock();
> >  
> > +		start = round_down(start, min_nrpages);
> 
> 		start = mapping_align_start_index(mapping, start);
> > +
> > +		VM_BUG_ON(folio->index & (folio_nr_pages(folio) - 1));
> > +
> >  		if (!start || start - index > max_pages)
> >  			return;
> >  
> >  		ra->start = start;
> >  		ra->size = start - index;	/* old async_size */
> > +
> >  		ra->size += req_size;
> > -		ra->size = get_next_ra_size(ra, max_pages);
> > +		ra->size = get_next_ra_size(ra, min_nrpages, max_pages);
> 
> 		ra->size = max(min_nrpages, get_next_ra_size(ra, max_pages));

If this is a round_up of size instead of max operation, we can
always ensure the ra->start from index aligned to min_nrpages. See my
reasoning in the previous comment.

--
Pankaj

