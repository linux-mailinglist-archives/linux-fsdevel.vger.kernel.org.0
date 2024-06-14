Return-Path: <linux-fsdevel+bounces-21699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AFD90875E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E541F22B28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF095192B61;
	Fri, 14 Jun 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ZZR1KZsB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56D18C33A;
	Fri, 14 Jun 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357176; cv=none; b=Y3yMtueTFv58uaUdIdEJ9q8XoPzq8v/UgZRUCtMhW8mKCkp4IaXIYpIiP4KKI/O+9EHM6TyQjgvprPW198FGMpaQVPRKvMpfiG0BWiXTx86C+CEdSzAeHaGeLBF7OZ/x1vi2g57aThOaSqRoPBwh5ZcFpE5Tc2gYcSUp087lLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357176; c=relaxed/simple;
	bh=9fe6/Skaw9o24Cn2omAm3tlR/7pTqWyvJNce2Q08LBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlS8IAhHmoXH/jY4yyWv+vzslLyH58gUKLb+hgKDPtEKiQnt13xg2WtboUKrYJYtb7eSlXQFQzW4tu8RBMNNTfEmDStt3YQq2pgysfn381HdOR0pMzfjmGI2f/d1MOsl/qEX15RWZvijiTOMLIbbugKi82oSEjbEUtpMN+VMBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ZZR1KZsB; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W0v691D0Xz9svV;
	Fri, 14 Jun 2024 11:26:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718357169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKdlyvSF7pCAKamuIrCSdc2r5zUKZ+TWhLzB5NWF7sE=;
	b=ZZR1KZsBATXt8TUkNrnhy8NPhWZ9HUbnl97kMLnlKWta4bA6DEM9xTjmRsLAywUnIo1+uJ
	WmIdOXXLqbhBqN4yKShp/3Jh4Vhh9ndbSK8s2AuJ/UjPiX17lfrdZQLDjQFp7B247DGzAT
	FJeiStNCfo/wUbsWMrDsISWpyYt9wM+6aWeE+RoOaEO254zxRcT3NKpjM9Kr+R5TCZvy1p
	3WfAK7OyQnxP+oo6W/CZ6OFyullms/6FRAX5KX+IeEFQMc5iEEyd/1GPX36S+ja3om8hH7
	UsonYuuQWcaKM09pD9TVtUdBShHkBQRK51vqaAk5F3JUfHvoRXI76i61GMpWmQ==
Date: Fri, 14 Jun 2024 09:26:02 +0000
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
Message-ID: <20240614092602.jc5qeoxy24xj6kl7@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-5-kernel@pankajraghav.com>
 <ZmnuCQriFLdHKHkK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmnuCQriFLdHKHkK@casper.infradead.org>
X-Rspamd-Queue-Id: 4W0v691D0Xz9svV

On Wed, Jun 12, 2024 at 07:50:49PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 07, 2024 at 02:58:55PM +0000, Pankaj Raghav (Samsung) wrote:
> > @@ -230,7 +247,9 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  		struct folio *folio = xa_load(&mapping->i_pages, index + i);
> >  		int ret;
> >  
> > +
> 
> Spurious newline
Oops.
> 
> >  		if (folio && !xa_is_value(folio)) {
> > +			long nr_pages = folio_nr_pages(folio);
> 
> Hm, but we don't have a reference on this folio.  So this isn't safe.
> 

That is why I added a check for mapping after read_pages(). You are
right, we can make it better.

> > @@ -240,12 +259,24 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  			 * not worth getting one just for that.
> >  			 */
> >  			read_pages(ractl);
> > -			ractl->_index += folio_nr_pages(folio);
> > +
> > +			/*
> > +			 * Move the ractl->_index by at least min_pages
> > +			 * if the folio got truncated to respect the
> > +			 * alignment constraint in the page cache.
> > +			 *
> > +			 */
> > +			if (mapping != folio->mapping)
> > +				nr_pages = min_nrpages;
> > +
> > +			VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
> > +			ractl->_index += nr_pages;
> 
> Why not just:
> 			ractl->_index += min_nrpages;

Then we will only move min_nrpages even if the folio we found had a
bigger order. Hannes patches (first patch) made sure we move the
ractl->index by folio_nr_pages instead of 1 and making this change will
defeat the purpose because without mapping order set, min_nrpages will
be 1.

What I could do is the follows:

diff --git a/mm/readahead.c b/mm/readahead.c
index 389cd802da63..92cf45cdb4d3 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -249,7 +249,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 
 
                if (folio && !xa_is_value(folio)) {
-                       long nr_pages = folio_nr_pages(folio);
+                       long nr_pages;
                        /*
                         * Page already present?  Kick off the current batch
                         * of contiguous pages before continuing with the
@@ -266,10 +266,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
                         * alignment constraint in the page cache.
                         *
                         */
-                       if (mapping != folio->mapping)
-                               nr_pages = min_nrpages;
+                       nr_pages = max(folio_nr_pages(folio), (long)min_nrpages);
 
-                       VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
                        ractl->_index += nr_pages;
                        i = ractl->_index + ractl->_nr_pages - index;
                        continue;

Now we will still move respecting the min order constraint but if we had
a bigger folio and we do have a reference, then we move folio_nr_pages.
> 
> like you do below?
Below we add a folio of min_order, so if that fails for some reason, we
can unconditionally move min_nrpages.

