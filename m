Return-Path: <linux-fsdevel+bounces-7547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F3A826FF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 14:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D91283393
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2351644C97;
	Mon,  8 Jan 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eka+POpo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530614595B;
	Mon,  8 Jan 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UR7h1vIiNDshvxfSpWSYHrtonMQ7by+0KCwpfJgpgkw=; b=Eka+POpo5B6nLzEkb+Wz8MZ/fg
	JL5iL1PzMjrfiFhietAFQIvrRFjQOxoFAtvKCa/MeRbrIb0lehC5KokV228m0VovNkYguC/n3GJ61
	2CPSaqTp+svHc3nOBBmbTmsq33hmm0Hje0tKmMrpnJ77g5XraEBQzn4MDRzFY9eddDwgTHfvCmetq
	5hfLQmH7Bw22e6bM04vktPus2l6kjGJloU4mYQ1CZ+H+juvYrbZL+2pjppzyZWrWueGpDmfrLG4aP
	H56ZIZs5VEvwzdy2Ve89cA9oin/bn9KS28yTOKtK2ic6s4xmLamaDxsDlZHlZkHlTG3ZOgNfdWBI2
	qGWlwFMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rMpmY-007aCN-GA; Mon, 08 Jan 2024 13:35:10 +0000
Date: Mon, 8 Jan 2024 13:35:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] buffer: Add kernel-doc for block_dirty_folio()
Message-ID: <ZZv6Dgsmjnr48BMQ@casper.infradead.org>
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-3-willy@infradead.org>
 <20240108133117.xtkbzeiqq6dtesm5@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108133117.xtkbzeiqq6dtesm5@localhost>

On Mon, Jan 08, 2024 at 02:31:17PM +0100, Pankaj Raghav (Samsung) wrote:
> > + * If the folio has buffers, the uptodate buffers are set dirty, to
> > + * preserve dirty-state coherency between the folio and the buffers.
> > + * It the folio does not have buffers then when they are later attached
> 
> s/It the folio/If the folio
> > + * they will all be set dirty.
> Is it better to rephrase it slightly as follows:
> 
> If the folio does not have buffers, they will all be set dirty when they
> are later attached.

Yes, I like that better.

> > + *
> > + * The buffers are dirtied before the folio is dirtied.  There's a small
> > + * race window in which writeback may see the folio cleanness but not the
> > + * buffer dirtiness.  That's fine.  If this code were to set the folio
> 

