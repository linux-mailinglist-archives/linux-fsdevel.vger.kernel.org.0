Return-Path: <linux-fsdevel+bounces-20331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A6B8D1838
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6194A1F23CFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146391667D4;
	Tue, 28 May 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Zs/bwTn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7E017E8F4;
	Tue, 28 May 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891223; cv=none; b=FBn5CmYB3VAfRGJ6NOuVVTXs6sH9qgJd6NCRpBWmdlbuX5rJf61Lsu4qYYDactH0MLrpyfSUYfL/g02RVQNZnKR0cdhPyGOpxDH1t1R6aPJbrs0xJ/VImwkHz59ruuE4WQ3l31V+WWgeoUmQeWUsAEm7+nW4/GDvcsg0Tq7hkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891223; c=relaxed/simple;
	bh=r0T/2RFOfllq2ZvsI9+qfI2stTKLQsIKOt1ZzrCzz2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh6sl+HRKmsWDEYnJFG3gY3NYe2GWhRKD/q59DNfSLnhhvpwaRHPDWG706e2J1gV1qc7PqO9kyjY3mk5xdfM7So2Y/W6TpKwsGVlNHLh/fxa3SY/q55DfYw2Iiw8WWyHfPwtbKNT1o9nDR0yTEjtE0wpa+1gfsd/epplDh+Iptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Zs/bwTn/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VpSyn3hHWz9sNZ;
	Tue, 28 May 2024 12:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716891217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IlTkJDd3mPfC10j7p6d3xbnwPdgFtV+YqSiluNFgjgk=;
	b=Zs/bwTn/VjSIHTVrhwAqKG/eBdjgud9JAMb0CgjAPmggXZhygVLTpBf0r8HGquwbYF6fYI
	Ye64b5ULXkCy/Hf9HHHEXC/u38s+9sKyA74ozfoSaDxFbo9+McKfvmC3ORuhaXXVXP3ONA
	AQ/R59evehKxXO/SiYFlMK81IGLHOU2MzZdw6kUo2Em5uJ/YCxB3HovHDZjiaJ8i82htdk
	Spy3Na5FckEIl+WlYIft1UMpfY3vvkFB8LJb3AuEeKu2/IEKoHaImLfXHDVk+y0jA4sCff
	KIscCpbXWQfM1yDvBr9ZCmZp0G2WSF2BDvILtRLCYRra82UFgudXPbcn7SeDkA==
Date: Tue, 28 May 2024 10:13:32 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com, hare@suse.de,
	ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <20240528101332.b7uwjjjeifgsugrw@quentin>
References: <20240527210125.1905586-1-willy@infradead.org>
 <20240527220926.3zh2rv43w7763d2y@quentin>
 <ZlULs_hAKMmasUR8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlULs_hAKMmasUR8@casper.infradead.org>

On Mon, May 27, 2024 at 11:39:47PM +0100, Matthew Wilcox wrote:
> On Mon, May 27, 2024 at 10:09:26PM +0000, Pankaj Raghav (Samsung) wrote:
> > > For this version, I fixed the TODO that the maximum folio size was not
> > > being honoured.  I made some other changes too like adding const, moving
> > > the location of the constants, checking CONFIG_TRANSPARENT_HUGEPAGE, and
> > > dropping some of the functions which aren't needed until later patches.
> > > (They can be added in the commits that need them).  Also rebased against
> > > current Linus tree, so MAX_PAGECACHE_ORDER no longer needs to be moved).
> > 
> > Thanks for this! So I am currently running my xfstests on the new series
> > I am planning to send in a day or two based on next-20240523.
> > 
> > I assume this patch is intended to be folded in to the next LBS series?
> 
> Right, that was why I numbered it as 5.1 so as to not preempt your v6.
> 
> > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > index 1ed9274a0deb..c6aaceed0de6 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -204,13 +204,18 @@ enum mapping_flags {
> > >  	AS_EXITING	= 4, 	/* final truncate in progress */
> > >  	/* writeback related tags are not used */
> > >  	AS_NO_WRITEBACK_TAGS = 5,
> > > -	AS_LARGE_FOLIO_SUPPORT = 6,
> > > -	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> > > -	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> > > +	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
> > > +	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
> > >  				   folio contents */
> > > -	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
> > > +	AS_UNMOVABLE = 8,	/* The mapping cannot be moved, ever */
> > > +	AS_FOLIO_ORDER_MIN = 16,
> > > +	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
> > >  };
> > >  
> > > +#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > > +#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> > 
> > As you changed the mapping flag offset, these masks also needs to be
> > changed accordingly.
> 
> That's why I did change them?

Oops, I missed the zeroes at the end.


Btw, I noticed you have removed mapping_align_start_index(). I will add
it back in.

-- 
Pankaj Raghav

