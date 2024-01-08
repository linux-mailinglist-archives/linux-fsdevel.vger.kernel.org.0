Return-Path: <linux-fsdevel+bounces-7559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AA827539
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 17:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C7B22EC0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CDA5467B;
	Mon,  8 Jan 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RtFdrbVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A25466D;
	Mon,  8 Jan 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aGfWPygYz1nY4CFtjZVcFLlWi0jjSyqwOOjAgk37qSo=; b=RtFdrbVXxcyEv3Hw9AHE0pdasJ
	4WhVXtzJvIWEFYjoeympRZfE5lYi7ZtVduMCb+7HdE17lkgyKM5WReBxM3oSM8yYYz1PWnrhpCpu/
	wH73XqXpfw0QcN6p0TaRiEj6FAHxFg/C+GVdSJaWzt+KuMHvejOKOTHv+4JwpQX9MNk4Sbb3ZGOjA
	q39rqdwUOKpasQcL2SXBetHUSn7JTfIJMUg2laV1hq8UDsKcRR7QHHKhvtJC5DxfooM9sY+jlYxwb
	SxuGDhncR20IJ6xVBg0BzzjVPhi9lXUXfOUWzkeul0FsgAeQGhbnya3H23byM41PYsfC/OB3tYTbv
	JoQiomQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rMsY1-007uNT-LX; Mon, 08 Jan 2024 16:32:21 +0000
Date: Mon, 8 Jan 2024 16:32:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] buffer: Add kernel-doc for block_dirty_folio()
Message-ID: <ZZwjlYY+LxuWINHm@casper.infradead.org>
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-3-willy@infradead.org>
 <20240108133117.xtkbzeiqq6dtesm5@localhost>
 <ZZv6Dgsmjnr48BMQ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZv6Dgsmjnr48BMQ@casper.infradead.org>

On Mon, Jan 08, 2024 at 01:35:10PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 08, 2024 at 02:31:17PM +0100, Pankaj Raghav (Samsung) wrote:
> > > + * If the folio has buffers, the uptodate buffers are set dirty, to
> > > + * preserve dirty-state coherency between the folio and the buffers.
> > > + * It the folio does not have buffers then when they are later attached
> > 
> > s/It the folio/If the folio
> > > + * they will all be set dirty.
> > Is it better to rephrase it slightly as follows:
> > 
> > If the folio does not have buffers, they will all be set dirty when they
> > are later attached.
> 
> Yes, I like that better.

Actually, how about:

 * If the folio has buffers, the uptodate buffers are set dirty, to
 * preserve dirty-state coherency between the folio and the buffers.
 * Buffers added to a dirty folio are created dirty.

I considered deleting the sentence entirely as it's not actually related
to what the function does; it's just a note about how the buffer cache
behaves.  That said, information about how buffer heds work is scant
enough that I don't want to delete it.

