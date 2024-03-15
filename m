Return-Path: <linux-fsdevel+bounces-14451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E9287CE06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54816282396
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DEE28DCF;
	Fri, 15 Mar 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="0dRpwze5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4041B940;
	Fri, 15 Mar 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508879; cv=none; b=iHGXlLyUOhHwjYE/OWT/qlD659vTjQkD/EBhzUc/pvDuoyIHr3+Qy7pDNhbfXk9I4Orjd27W5ZkwqG+/G8Pj3zt7oVQs1BWGxp8e83fRVjH/cUhxvdw7Bf0Vh6bENTpdoLwzRFgiLmf4I2fh+F3pXUxVHvGyo/88vhiEXN0rhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508879; c=relaxed/simple;
	bh=c6bsZVO4bBgF10Yi8ZqO5zrzwVSEc8zOjEe3crGhLQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwqw+9UXV7gASA/uKlsod4bjZnuwc9T5HZCBp9lZ4+dlSheTc/Wdd50jcQVNG48acdFykJSiuqVD5FlpLUb6mVAhOpi1DsLjTyYDNjFsnj5NBpNhN7bh6RP3yK+dBPybnvwX+jjcxh92IhW2yimkfDxMi9XybwrNGSWQHG9UNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=0dRpwze5; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tx4dG2Hc8z9sX2;
	Fri, 15 Mar 2024 14:21:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710508866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uL8B8rxdNzZ1QT1jmn8Si5bf2Isce5VLmVW1+mlinGY=;
	b=0dRpwze54JbtFZYv1021iFawCCzzS/F8earDM4Utcgva9wOF+U/UIJ3TePCdr3If0MjxZM
	zzTbiM3XRek/OATou7PoENHWHTXGR0kSvT+nBLo/W/Da39wxs8z5AlE65Idzx0ZdSTIwPS
	8cHKj+IytBGODedJIzr+vcZDnSEX+LEmUUwmsiWaq6vFAf4JYVAqol4u2nba7TeTYFvCds
	197BXrYfukht9gw4Z2umxZ7ahUuTAxrLxOhxIvbObQwhS0yxBK6HIRzdc6WWUCtv6VnN8P
	JhZjNWtHwp4ftJXBe/9j0WBAz0V+vVQiiTevPLL8hT8X6mhXsPcmrRZthiDVbw==
Date: Fri, 15 Mar 2024 14:21:02 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org
Cc: gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de, 
	mcgrof@kernel.org, djwong@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, david@fromorbit.com, akpm@linux-foundation.org, 
	Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <spgk45dlfiohxug6nokmpaakcevr34ml24loatu3764wgxccc6@iwje3all2lxm>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313170253.2324812-4-kernel@pankajraghav.com>
X-Rspamd-Queue-Id: 4Tx4dG2Hc8z9sX2

Hi willy,

> filemap_create_folio() and do_read_cache_folio() were always allocating
> folio of order 0. __filemap_get_folio was trying to allocate higher
> order folios when fgp_flags had higher order hint set but it will default
> to order 0 folio if higher order memory allocation fails.
> 
> Supporting mapping_min_order implies that we guarantee each folio in the
> page cache has at least an order of mapping_min_order. When adding new
> folios to the page cache we must also ensure the index used is aligned to
> the mapping_min_order as the page cache requires the index to be aligned
> to the order of the folio.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  mm/filemap.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Are the changes more inline with what you had in mind?

> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a1cb3ea55fb6..57889f206829 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -849,6 +849,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
> +	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
> +			folio);
>  	mapping_set_update(&xas, mapping);
>  
>  	if (!huge) {
> @@ -1886,8 +1888,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio_wait_stable(folio);
>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
> -		unsigned order = FGF_GET_ORDER(fgp_flags);
> +		unsigned int min_order = mapping_min_folio_order(mapping);
> +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
>  		int err;
> +		index = mapping_align_start_index(mapping, index);
>  
>  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
>  			gfp |= __GFP_WRITE;
> @@ -1927,7 +1931,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  				break;
>  			folio_put(folio);
>  			folio = NULL;
> -		} while (order-- > 0);
> +		} while (order-- > min_order);
>  
>  		if (err == -EEXIST)
>  			goto repeat;
> @@ -2416,13 +2420,16 @@ static int filemap_update_page(struct kiocb *iocb,
>  }
>  
>  static int filemap_create_folio(struct file *file,
> -		struct address_space *mapping, pgoff_t index,
> +		struct address_space *mapping, loff_t pos,
>  		struct folio_batch *fbatch)
>  {
>  	struct folio *folio;
>  	int error;
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +	pgoff_t index;
>  
> -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
> +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
> +				    min_order);
>  	if (!folio)
>  		return -ENOMEM;
>  
> @@ -2440,6 +2447,8 @@ static int filemap_create_folio(struct file *file,
>  	 * well to keep locking rules simple.
>  	 */
>  	filemap_invalidate_lock_shared(mapping);
> +	/* index in PAGE units but aligned to min_order number of pages. */
> +	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
>  	error = filemap_add_folio(mapping, folio, index,
>  			mapping_gfp_constraint(mapping, GFP_KERNEL));
>  	if (error == -EEXIST)
> @@ -2500,8 +2509,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	if (!folio_batch_count(fbatch)) {
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>  			return -EAGAIN;
> -		err = filemap_create_folio(filp, mapping,
> -				iocb->ki_pos >> PAGE_SHIFT, fbatch);
> +		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
>  		if (err == AOP_TRUNCATED_PAGE)
>  			goto retry;
>  		return err;
> @@ -3662,9 +3670,11 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>  repeat:
>  	folio = filemap_get_folio(mapping, index);
>  	if (IS_ERR(folio)) {
> -		folio = filemap_alloc_folio(gfp, 0);
> +		folio = filemap_alloc_folio(gfp,
> +					    mapping_min_folio_order(mapping));
>  		if (!folio)
>  			return ERR_PTR(-ENOMEM);
> +		index = mapping_align_start_index(mapping, index);
>  		err = filemap_add_folio(mapping, folio, index, gfp);
>  		if (unlikely(err)) {
>  			folio_put(folio);
> -- 
> 2.43.0
> 

-- 
Pankaj Raghav

