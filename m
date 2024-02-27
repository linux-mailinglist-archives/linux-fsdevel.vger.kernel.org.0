Return-Path: <linux-fsdevel+bounces-12944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979CB868FDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F90B1F2BC13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCD413A881;
	Tue, 27 Feb 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="PtD8UcFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742B13A24B;
	Tue, 27 Feb 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035784; cv=none; b=QCMSVOzSsKjK7riCj+ScTRWtTEyhoxhKNqsbitdU6w4cNtPucneV33TxK86hwiCGjqIzotHqv1Zk78Kce87shkfB5fj7zzEsPbxEp6EF00TQdPRaFP5HsYoIyIf+WjgTc3VRdY/+drmT/a4VrwLBO/wXzgUF1e8dHq2RoQQdd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035784; c=relaxed/simple;
	bh=AkU8U39Dvaa4sQVIMczcI/j0GnygEDtYp/2dJjdVtbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAcr0ytAXf4n1aHl5omPW3MN39fu4HqYendJMSSNK5a2Po1QNEHUdQ7WRP0laUQHG5MIJIXHdtnqvL2sbrkVSfq76+8o0xxzuQebQJKiHd/MM5E+OFIUSH694yB4sAXuifbYCOy4bTaSOXzSHsP6GuDxDHmiBm5hsvUQT8kuR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=PtD8UcFy; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TkbrY3xjCz9stD;
	Tue, 27 Feb 2024 13:09:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709035773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfDncH9SZJfkOzhOAZvW+P0qSEBgSmxkFRXj5ACGhgU=;
	b=PtD8UcFyy7iY2qmUohVq8BmQ1q8to/u2N55TFbcIsQ2cqKPL1hD/DwpxrgeM4kK1hMZ2YH
	sMqQYlpYDSvKZI0w3HIC4rxH2NtK1/G/rDvgMgVGoKGquNbKMaVS8TwOslxea33wQ65X0x
	Z2KLCGuPJpHKkKiSivIPM8KnSOBbOWSHpmFdqsYjJCxdqEiyiogFSiPYLUYmgtj4apqwhi
	rstSxqpTx2lpgd2gsAxir2QfXmy2jXRRzGJp8Xu6cJckPyB4oITGEK9M47WXJbn8Y00TYy
	6j3mF16KRkcJZiS8iQ/0uGOVJGgcLw06ngOSNhNOKXPDwQoR8p6QyKCBpmF7Dw==
Date: Tue, 27 Feb 2024 13:09:27 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david@fromorbit.com, chandan.babu@oracle.com, 
	akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, 
	djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 04/13] filemap: use mapping_min_order while allocating
 folios
Message-ID: <ddosz7msf7aayvalbgyz3lecl4no3mavjcqxot2akqv75wrtqv@orcsmfoae5cc>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-5-kernel@pankajraghav.com>
 <ZdykhSuPbe6knu89@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdykhSuPbe6knu89@casper.infradead.org>

On Mon, Feb 26, 2024 at 02:47:33PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 26, 2024 at 10:49:27AM +0100, Pankaj Raghav (Samsung) wrote:
> > Add some additional VM_BUG_ON() in page_cache_delete[batch] and
> > __filemap_add_folio to catch errors where we delete or add folios that
> > has order less than min_order.
> 
> I don't understand why we need these checks in the deletion path.  The
> add path, yes, absolutely.  But the delete path?
I think we initially added it to check if some split happened which
might mess up the page cache with min order support. But I think it is
not super critical anymore because of the changes in the split_folio
path. I will remove the checks.

> 
> > @@ -896,6 +900,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
> >  			}
> >  		}
> >  
> > +		VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
> > +				folio);
> 
> But I don't understand why you put it here, while we're holding the
> xa_lock.  That seems designed to cause maximum disruption.  Why not put
> it at the beginning of the function with all the other VM_BUG_ON_FOLIO?

Yeah. That makes sense as the folio itself is not changing.

> 
> > @@ -1847,6 +1853,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  		fgf_t fgp_flags, gfp_t gfp)
> >  {
> >  	struct folio *folio;
> > +	unsigned int min_order = mapping_min_folio_order(mapping);
> > +
> > +	index = mapping_align_start_index(mapping, index);
> 
> I would not do this here.
> 
> >  repeat:
> >  	folio = filemap_get_entry(mapping, index);
> > @@ -1886,7 +1895,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  		folio_wait_stable(folio);
> >  no_page:
> >  	if (!folio && (fgp_flags & FGP_CREAT)) {
> > -		unsigned order = FGF_GET_ORDER(fgp_flags);
> > +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
> >  		int err;
> 
> Put it here instead.
> 
> >  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
> > @@ -1912,8 +1921,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> >  			gfp_t alloc_gfp = gfp;
> >  
> >  			err = -ENOMEM;
> > +			if (order < min_order)
> > +				order = min_order;
> >  			if (order > 0)
> >  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> > +
> > +			VM_BUG_ON(index & ((1UL << order) - 1));
> 
> Then you don't need this BUG_ON because it's obvious you just did it.
> And the one in filemap_add_folio() would catch it anyway.

I agree. I will change it in the next revision.

