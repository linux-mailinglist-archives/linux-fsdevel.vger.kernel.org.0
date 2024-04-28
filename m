Return-Path: <linux-fsdevel+bounces-18024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A197E8B4DD1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 22:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5894228130D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 20:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F238BA27;
	Sun, 28 Apr 2024 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="OwNofpHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9286EB661;
	Sun, 28 Apr 2024 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714337966; cv=none; b=U/byvuR7mpS3YDw7x1fKTZA1hFGLZfwJ31SvR6yE3OrqSYkIznjqg4S/9GeUWpQqSX5F2k4Q2ytus/qGT7xG7oF9bKDgwxcDovbUz48oBImBxgxi8SlsEl+Alg5NwdPOxFRbRvapBTL0AODSBVCVQ14sIuo74Ll0//FnngVKj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714337966; c=relaxed/simple;
	bh=5Kbw4/D6LUjCS3NHHCH6xj23QMQ+Nuis92riDkbC/Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm4qqnZ/kIvoE6HkNUbZ8UxWqfTpNjbpBufkkJ4eNooifqX63Ddk7DTCgONDIWgwX505GqgeZlorF4lpOQtUryVynKTKq7c4HcjIVBdXKgi2otwjvOWE3TgY9kSI/Dn24aoERHZplzGrrIH70ikBxpk8teDAdAdutrR3+IiTNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=OwNofpHv; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VSJjh61y0z9sf0;
	Sun, 28 Apr 2024 22:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714337960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVuobLMQ/P3jplHXQkykRM7/2IOlzm4DqmyFCcCzMHA=;
	b=OwNofpHvCUzTevzwB69MRfcQ4Fbi9zpzM6X5SMfGDBgzn3gynhVV3LCVn3LOwQ2HO96cvw
	DVDgfgtvtk05RPjYW9QK0rOq4ILVukQC028R4OuVS+CdvMa02NGQC3PLcJHXzg2GDF+fLL
	Gonw0LlGjlTVqv5AAt8Wb0azbPYvxm5hLx9HUkms218f08GeKdoMw34qjq3VxP+t+VqIeI
	kMlA1FGAp2VKojjNTlYn//rLUvKx0HZF+G89IMQH8zJ0TShQ1Uptu/KpRlupH+VJSAoZOq
	0sMQlXX7XK9JWk+7JKJ+B9turL0HbIhJocLidmpM5TRDcazcHFFa1FM+fPB5Xg==
Date: Sun, 28 Apr 2024 20:59:15 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <20240428205915.2iocwkcf3edc5y2k@quentin>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-4-kernel@pankajraghav.com>
 <20240426151243.GD360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426151243.GD360919@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4VSJjh61y0z9sf0

On Fri, Apr 26, 2024 at 08:12:43AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 25, 2024 at 01:37:38PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > filemap_create_folio() and do_read_cache_folio() were always allocating
> > folio of order 0. __filemap_get_folio was trying to allocate higher
> > order folios when fgp_flags had higher order hint set but it will default
> > to order 0 folio if higher order memory allocation fails.
> > 
> > Supporting mapping_min_order implies that we guarantee each folio in the
> > page cache has at least an order of mapping_min_order. When adding new
> > folios to the page cache we must also ensure the index used is aligned to
> > the mapping_min_order as the page cache requires the index to be aligned
> > to the order of the folio.
> 
> If we cannot find a folio of at least min_order size, what error is sent
> back?
> 
> If the answer is "the same error that you get if we cannot allocate a
> base page today (aka ENOMEM)", then I think I understand this enough to
> say
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Yes. We will get a ENOMEM if we cannot allocate min_order size folio. :)
Thanks!
> 
> --D
> 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  mm/filemap.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 30de18c4fd28..f0c0cfbbd134 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -858,6 +858,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
> >  
> >  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >  	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
> > +	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
> > +			folio);
> >  	mapping_set_update(&xas, mapping);
> >  
> >  	if (!huge) {
> > @@ -1895,8 +1897,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  		folio_wait_stable(folio);
> >  no_page:
> >  	if (!folio && (fgp_flags & FGP_CREAT)) {
> > -		unsigned order = FGF_GET_ORDER(fgp_flags);
> > +		unsigned int min_order = mapping_min_folio_order(mapping);
> > +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
> >  		int err;
> > +		index = mapping_align_start_index(mapping, index);
> >  
> >  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
> >  			gfp |= __GFP_WRITE;
> > @@ -1936,7 +1940,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  				break;
> >  			folio_put(folio);
> >  			folio = NULL;
> > -		} while (order-- > 0);
> > +		} while (order-- > min_order);
> >  
> >  		if (err == -EEXIST)
> >  			goto repeat;
> > @@ -2425,13 +2429,16 @@ static int filemap_update_page(struct kiocb *iocb,
> >  }
> >  
> >  static int filemap_create_folio(struct file *file,
> > -		struct address_space *mapping, pgoff_t index,
> > +		struct address_space *mapping, loff_t pos,
> >  		struct folio_batch *fbatch)
> >  {
> >  	struct folio *folio;
> >  	int error;
> > +	unsigned int min_order = mapping_min_folio_order(mapping);
> > +	pgoff_t index;
> >  
> > -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
> > +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
> > +				    min_order);
> >  	if (!folio)
> >  		return -ENOMEM;
> >  
> > @@ -2449,6 +2456,8 @@ static int filemap_create_folio(struct file *file,
> >  	 * well to keep locking rules simple.
> >  	 */
> >  	filemap_invalidate_lock_shared(mapping);
> > +	/* index in PAGE units but aligned to min_order number of pages. */
> > +	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
> >  	error = filemap_add_folio(mapping, folio, index,
> >  			mapping_gfp_constraint(mapping, GFP_KERNEL));
> >  	if (error == -EEXIST)
> > @@ -2509,8 +2518,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
> >  	if (!folio_batch_count(fbatch)) {
> >  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
> >  			return -EAGAIN;
> > -		err = filemap_create_folio(filp, mapping,
> > -				iocb->ki_pos >> PAGE_SHIFT, fbatch);
> > +		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
> >  		if (err == AOP_TRUNCATED_PAGE)
> >  			goto retry;
> >  		return err;
> > @@ -3708,9 +3716,11 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
> >  repeat:
> >  	folio = filemap_get_folio(mapping, index);
> >  	if (IS_ERR(folio)) {
> > -		folio = filemap_alloc_folio(gfp, 0);
> > +		folio = filemap_alloc_folio(gfp,
> > +					    mapping_min_folio_order(mapping));
> >  		if (!folio)
> >  			return ERR_PTR(-ENOMEM);
> > +		index = mapping_align_start_index(mapping, index);
> >  		err = filemap_add_folio(mapping, folio, index, gfp);
> >  		if (unlikely(err)) {
> >  			folio_put(folio);
> > -- 
> > 2.34.1
> > 
> > 

