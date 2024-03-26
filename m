Return-Path: <linux-fsdevel+bounces-15324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3288C2FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F202E5230
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2132773177;
	Tue, 26 Mar 2024 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ZpPpldsn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006EEEA9;
	Tue, 26 Mar 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458517; cv=none; b=lRcSQaSSA9rkRKhT1v8wjd9AGaeGt5TcVKuAkM00foaSQrgSmOLqBuB0mLvrr1J6BBApLCNtjjiXujvtnOjRiBZRU74QcM38RIicG7QyaDr7Fyg8KOHvLDz9x5gcypUxv6TwMFIS3SBs6440RSJLJMsOPfZih1ffwYdMzuCKwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458517; c=relaxed/simple;
	bh=zb+c1eJhGpVi8lvJndVvpd3BeurHRjqMmwzo2z5blnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbAoHWKBjQ/O+/eHxROAqIkKxEM8uGifdEioqpSrZXeNKsP6j4UPsu27iJrdW0Zee9i4c0dtg5WHj3UtyO0I1kNBl1as7ylF1UjVbCNeX+cyTV2rHQdexhTLWnb82VhZ3HgfOPUYIohZ67y7+JT8ifWaA89hBrcd2a2QvV9eopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ZpPpldsn; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V3qqZ1vgkz9sZw;
	Tue, 26 Mar 2024 14:08:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711458506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8d3EYhEfZQrAxbjR62dfoi3Du1p/pSGgH8hAUpFy1wc=;
	b=ZpPpldsnkTVp8fEwuvWULTRBSOBTvIVSqq5FwEnlkX6aBXsg6IxKtbiT4cC9fpCeuZP4Pa
	0QDhOQMjnvd8vrpFFschiKqbVfCx4ldj9We/LGbWrFUZ+Ir2mBlbhAggwldAbACN/BCVYX
	pp8dnbZbIw0pkRhn4wzqUCoFNjvAoBeaJegHoJN/JgNyIkQ1lYl19MUTvT02Ecz9UDlG4l
	MlqfrzPw8n9PoU3e9C9Yjny1M5NoEnesiFxLQUaKqiSQVA8oy2WD4Bai2b6KrJxD16ufLW
	dQb4pWjeeNcY58dCxJOwf/ETisiFLVe3vBEXbnzUXiLoQhRkRNLem3tqSScy7Q==
Date: Tue, 26 Mar 2024 14:08:22 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de, mcgrof@kernel.org, 
	djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 05/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <ftoxbmcyyvrfo5qx6dj2kmifoky36ij3c3wx7h5wl4cg4ml5gw@yi7lxegriowg>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-6-kernel@pankajraghav.com>
 <ZgHJxiYHvN9DfD15@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHJxiYHvN9DfD15@casper.infradead.org>

> > 
> > page_cache_ra_unbounded() was allocating single pages (0 order folios)
> > if there was no folio found in an index. Allocate mapping_min_order folios
> > as we need to guarantee the minimum order if it is set.
> > When read_pages() is triggered and if a page is already present, check
> > for truncation and move the ractl->_index by mapping_min_nrpages if that
> > folio was truncated. This is done to ensure we keep the alignment
> > requirement while adding a folio to the page cache.
> > 
> > page_cache_ra_order() tries to allocate folio to the page cache with a
> > higher order if the index aligns with that order. Modify it so that the
> > order does not go below the min_order requirement of the page cache.
> 
> This paragraph doesn't make sense.  We have an assertion that there's no
> folio in the page cache with a lower order than the minimum, so this
> seems to be describing a situation that can't happen.  Does it need to
> be rephrased (because you're actually describing something else) or is
> it just stale?
> 
Hmm, maybe I need to explain better here.

> > @@ -489,12 +520,18 @@ void page_cache_ra_order(struct readahead_control *ractl,
> >  {
> >  	struct address_space *mapping = ractl->mapping;
> >  	pgoff_t index = readahead_index(ractl);
> > +	unsigned int min_order = mapping_min_folio_order(mapping);
> >  	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
> >  	pgoff_t mark = index + ra->size - ra->async_size;
> >  	int err = 0;
> >  	gfp_t gfp = readahead_gfp_mask(mapping);
> > +	unsigned int min_ra_size = max(4, mapping_min_folio_nrpages(mapping));
> >  
> > -	if (!mapping_large_folio_support(mapping) || ra->size < 4)

I had one question: `4` was used here because we could not support order
1 folios I assume? As we now support order-1 folios, can this fallback
if ra->size < min_nrpages?

> > +	/*
> > +	 * Fallback when size < min_nrpages as each folio should be
> > +	 * at least min_nrpages anyway.
> > +	 */
> > +	if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size)
> >  		goto fallback;
> >  
> >  	limit = min(limit, index + ra->size - 1);
> > @@ -505,9 +542,19 @@ void page_cache_ra_order(struct readahead_control *ractl,
> >  			new_order = MAX_PAGECACHE_ORDER;
> >  		while ((1 << new_order) > ra->size)
> >  			new_order--;
> > +		if (new_order < min_order)
> > +			new_order = min_order;
> 
> I think these are the two lines you're describing in the paragraph that
Yes. At least I tried to ;)

> doesn't make sense to me?  And if so, I think they're useless?

We need this because:
The caller might pass new_order = 0 (such as when we start mmap around)
but ra_order will do the "right" thing by taking care of the page cache
alignment requirements. The previous revision did this other way around
and it felt a bit all over the place.

One of the main changes I did for this revision is to adapt the
functions that alloc and add a folio to respect the min order alignment,
and not on the caller side.

The rationale I went for this is three fold: 
- the callers of page_cache_ra_order() and page_cache_ra_unbounded() 
  requests a range for which we need to do add a folio and read it. They
  don't care about the folios size and alignment.

- file_ra_state also does not need any poking around because we will
  make sure to cover from [ra->start, ra->size] and update ra->size if
  we spilled over due to the min_order requirement(like it was done before).

- And this is also consistent with what we do in filemap where we adjust
  the index before adding the folio to the page cache.

Let me know if this approach makes sense.
> 
> > @@ -515,7 +562,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
> >  		if (index & ((1UL << order) - 1))
> >  			order = __ffs(index);
> >  		/* Don't allocate pages past EOF */
> > -		while (index + (1UL << order) - 1 > limit)
> > +		while (order > min_order && index + (1UL << order) - 1 > limit)
> >  			order--;
> 
> This raises an interesting question that I don't know if we have a test
> for.  POSIX says that if we mmap, let's say, the first 16kB of a 10kB
> file, then we can store into offset 0-12287, but stores to offsets
> 12288-16383 get a signal (I forget if it's SEGV or BUS).  Thus far,
> we've declined to even create folios in the page cache that would let us
> create PTEs for offset 12288-16383, so I haven't paid too much attention
> to this.  Now we're going to have folios that extend into that range, so
> we need to be sure that when we mmap(), we only create PTEs that go as
> far as 12287.
> 
> Can you check that we have such an fstest, and that we still pass it
> with your patches applied and a suitably large block size?

Hmmm, good point.
I think you mean this from the man page:

SIGBUS Attempted access to a page of the buffer that lies beyond the end
of the mapped file.  For an explanation of the treatment of the bytes in
the page that corresponds to the end of a mapped file that is not a 
multiple of the page size, see NOTES.

I will add a test case for this and see what happens. I am not sure if I
need to make some changes or the current implementation should hold.

