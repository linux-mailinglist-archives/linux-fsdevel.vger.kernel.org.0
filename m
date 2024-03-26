Return-Path: <linux-fsdevel+bounces-15351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F788C669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF89B25DEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1C313C82B;
	Tue, 26 Mar 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ckx1i64Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D512B82;
	Tue, 26 Mar 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465902; cv=none; b=I/SKZ4GuhktGZWq2ffWLZoED1fFtViV4eULpDBL0LhYUEYoh6vu/Bx/oPb05bEleVyasrmLY9Q1kwQtkgO+OSbzUHJWBgAKGDLqSy8MW3etOtnl7sa/TtCLazqmJ7AWYrw+43NmewPK7tI+mZ9jgUmPIoqoN04A4kaqpFADPl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465902; c=relaxed/simple;
	bh=WLa1hi3+Ql113gRhJTdmKN7z9fyxinYMoU43wM1KnpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVu7vvmxC22zfihGmHnZwHK5Ypovsbwu6XVqB3tQYxhmVB2C+iyGCjmCT2TIQb+Q0AOph4r7P5ptkyA4+njdl6FBh81VEwQ22G2toFavzm43i+5AhnZWzFBQQNLiQ5lndsoYmyEkJn3us84/vKJ/vewMbzFZekAP06bEgkHumqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ckx1i64Z; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4V3tYj0QYqz9sqM;
	Tue, 26 Mar 2024 16:11:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711465897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Nr5pbxteCfHgzj/i1W+/blhYMSR+J/eweuH6yYi/Aw=;
	b=ckx1i64ZvOdoSlf/gp1LfF6YwXSO3PDpqi2rnltX3PTl7K8dZc83b+H262KO0u8DvboKq3
	eM5tH0MilsVxjvMhzhWRTp87YG/yvg7MZuAy2A/2KXBcTHJv9fLjURlfu5WhYzbl/sQZi5
	8axc0iDbBul5pMoK0AYCN1DTKc4VDTxvYxQTf3jtFeqtOTWMugNH6btgtA8KZg80nz83kj
	2nL5Hawm8YGEwsg9qDH6ITS8VVbSFRofzZvr89iT/Jy+V7TAK9EgioV5IR8V29desK0FXA
	4LU6yzkA4OxIkBWQaX68XBpwc9IKaAEiRrHUKkXE8y04TB+bDTg9iy/Ul2/2qA==
Date: Tue, 26 Mar 2024 16:11:33 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de, mcgrof@kernel.org, 
	djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 04/11] readahead: rework loop in
 page_cache_ra_unbounded()
Message-ID: <k3pqp6aryvnekneqqs7hnolr7pkdayrudpjpizpptot6jp7xax@cog4esp24yve>
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
X-Rspamd-Queue-Id: 4V3tYj0QYqz9sqM

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
After having some back and forth with Hannes, I see where the confusion
is coming from.

I intended this to be a non-functional change that helps with adding 
min_order support later.

As this is a non-functional change, I will move this patch to be at the
start of the series as preparation patches before we start adding min_order
helpers and support.

--
Pankaj

