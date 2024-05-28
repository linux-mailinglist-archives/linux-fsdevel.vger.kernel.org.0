Return-Path: <linux-fsdevel+bounces-20320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB08D16F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49CF1F24483
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EEB13D52A;
	Tue, 28 May 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="K92MUdTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03AA4594A;
	Tue, 28 May 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887539; cv=none; b=Hy0BLBIZfevByWi9loA+w4TqzTtlt4/5Zuzv83WcFsTPcSVt5zOf7OHKE9VnMxNXLlp7MxCkJqcyr2mxiraWwLuHB+xjRQJLmJQ3cEEvXfb3RTfxfsRL4/gD9Uugmp48j8wWPlgMVbB0dS79P9K9qcX+P578/X1OKs51Q+WZIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887539; c=relaxed/simple;
	bh=MaP+gw6+Rx0wtt7NrugZhOZGAKPibK0Pozj5+E663jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSmQuGT4AIqpJpV6rBYzYzeBb1srgirtWsTIjG3J0G68jqEruaDkjjHOOcC3mihENfTgSpPSlhrmQhH1SqqLUJaOjRpFsoD7mCOcyt4nEDVujJ6CU2dG70asKU00TrRg8XguOXzQQuBoOtmqgJqDQuNfKwRPpHMKBvxO7jTS118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=K92MUdTJ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VpRbq2GZhz9sXg;
	Tue, 28 May 2024 11:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716887527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6dkW93DnVACbslfNzCM4QmzlxV8HYGQZLUz4MDWvU4=;
	b=K92MUdTJL75TcWOfAZGx+lSgP/CSVK3fRy6W0PEiHaXLvkZEnU2e5ME2bZWJijEije8631
	IYXkXRyiC1fo4CPrma1zhSw+veppPMZRr3+rpFU/gtOlpawwq2TgTnEeLo3qwNzlKb7UvD
	d5LHVMpLvMgodvKF3MgXchJg/vsUEOA4lPU3cjKkzON6tLVzujiY79BllXTb0aVskEV9/5
	g4SwZU+mayqJedRswSDABP9WWTMD7iigfUKvgnxBBKX+DkVOKvm+Su2A+hoHOZfRT1MVJW
	rsyNGz0+Am5TaXPqnwAGNSbKIZHcvzn/NeSomiLXJS2BuScHVmbfoo/3wIGX+A==
Date: Tue, 28 May 2024 09:12:02 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, chandan.babu@oracle.com,
	hare@suse.de, ritesh.list@gmail.com, john.g.garry@oracle.com,
	ziy@nvidia.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <20240528091202.qevisz7zr6n5ouj7@quentin>
References: <20240527210125.1905586-1-willy@infradead.org>
 <20240527220926.3zh2rv43w7763d2y@quentin>
 <ZlULs_hAKMmasUR8@casper.infradead.org>
 <ZlUMnx-6N1J6ZR4i@casper.infradead.org>
 <ZlUQcEaP3FDXpCge@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlUQcEaP3FDXpCge@dread.disaster.area>
X-Rspamd-Queue-Id: 4VpRbq2GZhz9sXg

On Tue, May 28, 2024 at 09:00:00AM +1000, Dave Chinner wrote:
> On Mon, May 27, 2024 at 11:43:43PM +0100, Matthew Wilcox wrote:
> > On Mon, May 27, 2024 at 11:39:47PM +0100, Matthew Wilcox wrote:
> > > > > +	AS_FOLIO_ORDER_MIN = 16,
> > > > > +	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
> > > > >  };
> > > > >  
> > > > > +#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > > > > +#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> > > > 
> > > > As you changed the mapping flag offset, these masks also needs to be
> > > > changed accordingly.
> > > 
> > > That's why I did change them?
> > 
> > How about:
> > 
> > -#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > -#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> > +#define AS_FOLIO_ORDER_MIN_MASK (31 << AS_FOLIO_ORDER_MIN)
> > +#define AS_FOLIO_ORDER_MAX_MASK (31 << AS_FOLIO_ORDER_MAX)
> 
> Lots of magic numbers based on the order having only having 5 bits
> of resolution. Removing that magic looks like this:
> 
> 	AS_FOLIO_ORDER_BITS = 5,

I think this needs to be defined outside of the enum as 5 is already
taken by AS_NO_WRITEBACK_TAGS? But I like the idea of making it generic
like this.

Something like this?

#define AS_FOLIO_ORDER_BITS 5
/*
 * Bits in mapping->flags.
 */
enum mapping_flags {
	AS_EIO		= 0,	/* IO error on async write */
	AS_ENOSPC	= 1,	/* ENOSPC on async write */
	AS_MM_ALL_LOCKS	= 2,	/* under mm_take_all_locks() */
	AS_UNEVICTABLE	= 3,	/* e.g., ramdisk, SHM_LOCK */
	AS_EXITING	= 4, 	/* final truncate in progress */
	/* writeback related tags are not used */
	AS_NO_WRITEBACK_TAGS = 5,
	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
				   folio contents */
	AS_UNMOVABLE = 8,	 /* The mapping cannot be moved, ever */
	/* Bit 16-21 are used for FOLIO_ORDER */
	AS_FOLIO_ORDER_MIN = 16,
	AS_FOLIO_ORDER_MAX = AS_FOLIO_ORDER_MIN + AS_FOLIO_ORDER_BITS, 
};

@willy: I can fold this change that Chinner is proposing if you are fine
with this.

> 	AS_FOLIO_ORDER_MIN = 16,
> 	AS_FOLIO_ORDER_MAX = AS_FOLIO_ORDER_MIN + AS_FOLIO_ORDER_BITS,
> };
> 
> #define AS_FOLIO_ORDER_MASK	((1u << AS_FOLIO_ORDER_BITS) - 1)
> #define AS_FOLIO_ORDER_MIN_MASK	(AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MIN)
> #define AS_FOLIO_ORDER_MAX_MASK	(AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MAX)
> 
> This way if we want to increase the order mask, we only need to
> change AS_FOLIO_ORDER_BITS and everything else automatically
> recalculates.
> 
> Doing this means We could also easily use the high bits of the flag
> word for the folio orders, rather than putting them in the middle of
> the flag space...
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

