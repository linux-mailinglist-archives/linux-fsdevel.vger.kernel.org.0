Return-Path: <linux-fsdevel+bounces-15289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C2D88BCE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490F41F3BA96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0684CE18;
	Tue, 26 Mar 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="S9FEMClW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A22495E5;
	Tue, 26 Mar 2024 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443373; cv=none; b=umDl86JLQMtlGyz1nG8282DVZsL2bcMVTi6VUnHrF/mMhsABCdaL7gTBvnhltZC+G/y1w6NIK1C4cAzk5biPJ4OSYvTdWneXMCPmbh6GqMDZ+Gr58X63HCfNlClLRMmoglBNF/G8MYmARF0xA95XiZBS8BclCNb5jqVkQqY39M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443373; c=relaxed/simple;
	bh=nagYxxDbJgL0+8mtzKa/n0XbQhGhLQBTIa31bE0Psjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUod455J7OLuX7dKOgk7f1xMJOUi+N34/g9iIAFClJlKf5Q98AL4AjQgoVDsk/xtcFjT5kTH9jUTB2PejsKDfVmJ+o8GFC6/j9ekPYd81xFgKbTxMqGPrz2bYMKd4hBmBH8JB5kRvTmi/nge6qmubiWbh5V9cjkzPKyjQfNweWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=S9FEMClW; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4V3kDR6xxLz9sTd;
	Tue, 26 Mar 2024 09:56:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711443368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XpgxVlBKjKrVn9MhWjJ6FRn4nkr5mAP1dQnGjR12Avg=;
	b=S9FEMClWMRg7xZPklOmpzcCTtZL6hs5IPFqYBeDYTHgvVoG9iP+ig0BwtYQ24gWWU2WVCS
	3uSyUcJDu/feCaAGss7hbXuMV1f0RrERROceks+RyRpxyerWfUppHtZrGWbJSjaHHYznXv
	+eBATqmcyV4lMfTtIDODQTaZIjlygvXZWFQoL8bsOcd0LLkhrPGNgD7LX3Xl/9eiqRYQ2n
	3iEMMo/TZU4Y34gywx+YT1J1F24P0n3drx4HOzz70jetX96Gde9+CweznN9KLk2ohW5yxu
	Mmcofwg52MFgM7Ut9N5KR2S766fXlDWgpZnRfbcl+kcz2AORsZYnqAEwDx/b2A==
Date: Tue, 26 Mar 2024 09:56:03 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de, mcgrof@kernel.org, 
	djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 04/11] readahead: rework loop in
 page_cache_ra_unbounded()
Message-ID: <s4jn4t4betknd3y4ltfccqxyfktzdljiz7klgbqsrccmv3rwrd@orlwjz77oyxo>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-5-kernel@pankajraghav.com>
 <ZgHFPZ9tNLLjKZpz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHFPZ9tNLLjKZpz@casper.infradead.org>
X-Rspamd-Queue-Id: 4V3kDR6xxLz9sTd

On Mon, Mar 25, 2024 at 06:41:01PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 13, 2024 at 06:02:46PM +0100, Pankaj Raghav (Samsung) wrote:
> > @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  			 * not worth getting one just for that.
> >  			 */
> >  			read_pages(ractl);
> > -			ractl->_index++;
> > -			i = ractl->_index + ractl->_nr_pages - index - 1;
> > +			ractl->_index += folio_nr_pages(folio);
> > +			i = ractl->_index + ractl->_nr_pages - index;
> >  			continue;
> >  		}
> >  
> > @@ -252,13 +252,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  			folio_put(folio);
> >  			read_pages(ractl);
> >  			ractl->_index++;
> > -			i = ractl->_index + ractl->_nr_pages - index - 1;
> > +			i = ractl->_index + ractl->_nr_pages - index;
> >  			continue;
> >  		}
> 
> You changed index++ in the first hunk, but not the second hunk.  Is that
> intentional?

The reason I didn't use folio_nr_pages(folio) in the second hunk is
because we have already `put` the folio and it is not valid anymore to
use folio_nr_pages right? Because we increase the ref count in
filemap_alloc() and we put if add fails. 

Plus in the second hunk, adding the 0 order folio failed in that index,
so we just move on to the next index. Once we have the min order
support, if adding min order folio failed, we move by min_order.

And your comment on the next patch:

> Hah, you changed this here.  Please move into previous patch.

We can't do that either because I am introducing the concept of min
order in the next patch.

