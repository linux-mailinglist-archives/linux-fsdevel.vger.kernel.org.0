Return-Path: <linux-fsdevel+bounces-12947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C2A8690CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D231C25078
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B00B13AA51;
	Tue, 27 Feb 2024 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bmCpLI8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A413AA32;
	Tue, 27 Feb 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037787; cv=none; b=aI7xMqGPK7/e98Z8M0oRQgUeyGVJufH5Hj7eAwhbAzDSelL6iPn7SJES6jtFcTCZZRkqFyJPg+yrggFERVjvP6yE+g7PvLrRYl0BpAnnO6AKR9RWlk62IqJ6G6ycgGH5dL10nk+WjQMj+36Yq23RTZ8Ghc9eogi5vGZandw/Tjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037787; c=relaxed/simple;
	bh=6iyAJTNLqqoH87GkMUsaU17nrvjCu0Jjl15UxCv5w78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtohIcKohYYayx5R4BuYCvUq5qVRNRIUBGoF6f6WcTDANJyaQlxsOO1t4ztUq2L+CWozRLGCp0pA/8iz1jwJWbMLw1KZAHRaHD0OMvKjIzD3lsQmF1Z2CjX1pmgN6LE+UWQnR1LDCvwYvSzIWKl8VZ3TM8UkHw2ttkTEbbV6eJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bmCpLI8D; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Tkcb342yWz9sT0;
	Tue, 27 Feb 2024 13:42:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709037775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vzWE63jayd8rqFmT5PVGSy+IQrBduhwjKTDvdq/SGYI=;
	b=bmCpLI8DVlTJaSBUTzBoNBYewMYGQqXIdD2NU8qTG+8Wy0mrD9Y/Fs9os5sYeT+qJlQ/r8
	dmzr9lH8TqWKJq0viwA408RQdgTmzvt7uGAYlDdCd969TIgZmWwIxDsLRIFjcUfAJEg29s
	2LTSx0R42roQmkJA48rGjI1sHH4zv7gvOq2r4ujM2Lzf721doGMXfMtiZGOKa52UAUwwTV
	3HjBZrsHVjqFbasZtHhhCMEQ3XW6sXIv5m1YiKvB2ZfWWMj5UbAwWE53lTdQ0QFaFtQPLz
	N712VSaQukeFA5XWPqHl2YHZhrZHZMVVLcEkA6x8IkYDW7kpX/IoU8Xq0Z9O6A==
Date: Tue, 27 Feb 2024 13:42:51 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david@fromorbit.com, chandan.babu@oracle.com, 
	akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, 
	djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 05/13] readahead: set file_ra_state->ra_pages to be at
 least mapping_min_order
Message-ID: <ea3lppsqtgc6u7o4boj4j72mq5xp74o3csegvd5inkhll4nbpb@d6qcj4vem5ao>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-6-kernel@pankajraghav.com>
 <Zdyk4ErGQHc1q-1W@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdyk4ErGQHc1q-1W@casper.infradead.org>

On Mon, Feb 26, 2024 at 02:49:04PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 26, 2024 at 10:49:28AM +0100, Pankaj Raghav (Samsung) wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Set the file_ra_state->ra_pages in file_ra_state_init() to be at least
> > mapping_min_order of pages if the bdi->ra_pages is less than that.
> 
> Don't we rather want to round up to a multiple of mapping_min_nrpages?

Hmm. That will definitely be more explicit. We might be doing
multiple of min_nrpages now anyway, going beyond the ra_pages(if it 
is not a multiple of min_nrpages).

I will do this instead:

diff --git a/mm/readahead.c b/mm/readahead.c
index 73aef3f080ba..4e3a6f763f5c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -138,11 +138,8 @@
 void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
-       unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
-
-       ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
-       if (ra->ra_pages < min_nrpages)
-               ra->ra_pages = min_nrpages;
+       ra->ra_pages = round_up(inode_to_bdi(mapping->host)->ra_pages,
+                               mapping_min_folio_nrpages(mapping));
        ra->prev_pos = -1;
 }

> 
> >  file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
> >  {
> > +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> > +
> >  	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> > +	if (ra->ra_pages < min_nrpages)
> > +		ra->ra_pages = min_nrpages;
> >  	ra->prev_pos = -1;

