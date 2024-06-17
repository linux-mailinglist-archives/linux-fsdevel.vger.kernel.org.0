Return-Path: <linux-fsdevel+bounces-21830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4536C90B794
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 19:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48CA4B47FA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014DF9C9;
	Mon, 17 Jun 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Y8EFvt7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722671D9524;
	Mon, 17 Jun 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640277; cv=none; b=KCzCklzL87/epvJjVyX/v/36BIwVnDTqTuKu3pejnM7DCw+biS+TJL6TYWYXPS3eD7Bxf6zywYpjPyb4zzXzyuksyWBz7V6bBeNvZS2eES5RFWg3sljn3qrrSTZI6Qdmrkl0doF33EXaO/72hgbcQ7XgFVJlrorOmYdNAH50Hrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640277; c=relaxed/simple;
	bh=wTRQCs62L1SEFfYfLll48egvQUDI6tLeb+m98oi6HoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av2mITRMlVNXtREATOZLQP/WrtNPFFUHAlQhIRBxUR6KERTl0MK/oeWGsOCFe4a/qRQv5AoTriRFTq6pHQxbaPdf96BuREpdf9Eq+G0Fj62Pwyi3ac306GESaNkPkMbQJVxnKLjgK8w3rWVya2gyDZu6tKQYXE3DE0yoQm6iNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Y8EFvt7c; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W2vpK6MSWz9sdW;
	Mon, 17 Jun 2024 18:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718640265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=POREH1u3gVml+HC9orbYJuYAy8z1F4Z7+Xy+bewL5lE=;
	b=Y8EFvt7cE2WPLS33UV4Bnyzd2orjPU2Ro+Nc/DcZXQBmi5pP1ojEEdAWJY7tLuvUWr66eW
	SXSeu6J3nNanv5wjXt0mxXrv24ChuzM3iYekkImJ/fhLOs8q30HRfO4T+F4mp/wvRC+rzO
	vSEDxOXX1SoXK6FmHznnOwUVgZM1OEqFqdl9TEctSDYx3GE+zbkorHhi+eJPpPpa0zxCah
	t70wDX6kquhC1Z1K1oB65vGU7jXWXgq0YuuR5NFbshFdvxL80vFLTTNN/9W8aA1cmBKvtl
	/RC/IQ+Gh1a8p2WIJCQpz5mocGrneJcTJbTJQWmoZq3L2fXUI8vwADEJgmvmUg==
Date: Mon, 17 Jun 2024 16:04:20 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 04/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <20240617160420.ifwlqsm5yth4g7eo@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-5-kernel@pankajraghav.com>
 <ZmnuCQriFLdHKHkK@casper.infradead.org>
 <20240614092602.jc5qeoxy24xj6kl7@quentin>
 <ZnAs6lyMuHyk2wxI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnAs6lyMuHyk2wxI@casper.infradead.org>

On Mon, Jun 17, 2024 at 01:32:42PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 14, 2024 at 09:26:02AM +0000, Pankaj Raghav (Samsung) wrote:
> > > Hm, but we don't have a reference on this folio.  So this isn't safe.
> > 
> > That is why I added a check for mapping after read_pages(). You are
> > right, we can make it better.
> 
> That's not enoughh.
> 
> > > > +			if (mapping != folio->mapping)
> > > > +				nr_pages = min_nrpages;
> > > > +
> > > > +			VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
> > > > +			ractl->_index += nr_pages;
> > > 
> > > Why not just:
> > > 			ractl->_index += min_nrpages;
> > 
> > Then we will only move min_nrpages even if the folio we found had a
> > bigger order. Hannes patches (first patch) made sure we move the
> > ractl->index by folio_nr_pages instead of 1 and making this change will
> > defeat the purpose because without mapping order set, min_nrpages will
> > be 1.
> 
> Hannes' patch is wrong.  It's not safe to call folio_nr_pages() unless
> you have a reference to the folio.
> 
> > @@ -266,10 +266,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >                          * alignment constraint in the page cache.
> >                          *
> >                          */
> > -                       if (mapping != folio->mapping)
> > -                               nr_pages = min_nrpages;
> > +                       nr_pages = max(folio_nr_pages(folio), (long)min_nrpages);
> 
> No.
> 
> > Now we will still move respecting the min order constraint but if we had
> > a bigger folio and we do have a reference, then we move folio_nr_pages.
> 
> You don't have a reference, so it's never safe.
I am hitting my head now because you have literally mentioned that in
the comment:

	 * next batch.  This page may be the one we would
	 * have intended to mark as Readahead, but we don't
	 * have a stable reference to this page, and it's
	 * not worth getting one just for that.

I will move it by min_nrpages as follows:
>	ractl->_index += min_nrpages;


So the following can still be there from Hannes patch as we have a 
stable reference:

 		ractl->_workingset |= folio_test_workingset(folio);
-		ractl->_nr_pages++;
+		ractl->_nr_pages += folio_nr_pages(folio);
+		i += folio_nr_pages(folio);
 	}
 

Thanks for the clarification.

--
Pankaj

