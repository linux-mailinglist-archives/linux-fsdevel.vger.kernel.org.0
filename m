Return-Path: <linux-fsdevel+bounces-58889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE3B32D59
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 05:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC8D7A8AC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 03:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC5A1A239A;
	Sun, 24 Aug 2025 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G9gi+f6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1B1422DD;
	Sun, 24 Aug 2025 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756005032; cv=none; b=uhTxdlGg3+rOBcZFgEG0uqVai0Hy6NWk/eeEY+8gCopZkMDu4DDXnmECG74laR5MR4Q87Ene53rHSNg2d/UU0X6iOo667cPQWzk0k/5UNtihh0XJLG8kx5NRQmlnirz6y/ppuoGg9izc5qdNDn4B0yD7Lzn/IDLs5GrXdVfNZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756005032; c=relaxed/simple;
	bh=hxsdiDtjD36myHxhgd0MtXQGM1Rb5Q1flqONrAEnLpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjcdFSe4tRTyl9/BcbHhuE83szoHlE8Q7mFDw8yfhLbcuqURy9fuaiXtsUToGDQ922DyGoDQGKwRONsPJj0+UgOMBbE/B9oXXslMPEbRrs1NIQRlOlDXRu4lJzWtwVlZ9bkWWuwQVOUN8cDVQf6zQ9w1MpcUmsPKssA0tkNYN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G9gi+f6i; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YuCtKEU6NLMfrz/RnjShMJwQy6/uOjNzT+qWonnx3W0=; b=G9gi+f6igEr0wwPGCWwR1JIB/h
	CfPVJ7p3Ki+Cj5Oxfu43Mx0z73Lr9QVfRr5kmFXw5Aleb2mL3YyZS1RkxHK2TtOarOeReepPqhl3w
	VGLZnZQ8YH0r58JGGxIelSlCUXQXfNMp3wmNOPe9QjCKiql+vWMUc9AZeYTIdSuv7M1JNrT2/4MhY
	slv7vYGbjrUb1tfQYApLRFqrZsmEByZV7LeT6XqlP6n0pl9mbktCjyq0L6W47QXwUJPOJiztibbSn
	FtWTaj/SejVufotIAgjH4G5DDDUCoRG6uHn5MQDocTUiGvEAYrPUH+QxvONqoZ+/bcdjY7BbpzyFu
	ySqukRcA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uq17i-00000004dFj-42Fo;
	Sun, 24 Aug 2025 03:10:27 +0000
Date: Sun, 24 Aug 2025 04:10:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Prithvi Tambewagh <activprithvi@gmail.com>, skhan@linuxfoundation.org,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Document 'name' parameter in name_contains_dotdot()
Message-ID: <20250824031026.GF39973@ZenIV>
References: <20250823142208.10614-1-activprithvi@gmail.com>
 <20250824010623.GE39973@ZenIV>
 <20250824015224.GA12644@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824015224.GA12644@quark>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 23, 2025 at 09:52:24PM -0400, Eric Biggers wrote:
> On Sun, Aug 24, 2025 at 02:06:23AM +0100, Al Viro wrote:
> > On Sat, Aug 23, 2025 at 07:52:08PM +0530, Prithvi Tambewagh wrote:
> > > Add documentation for the 'name' parameter in name_contains_dotdot()
> > > 
> > > Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> > 
> > Out of curiosity, could you describe the process that has lead to
> > that patch?
> > 
> > The reason why I'm asking is that there had been a truly ridiculous
> > amount of identical patches, all dealing with exact same function.
> > 
> > Odds of random coincedence are very low - there's quite lot of
> > similar places, and AFAICS you are the 8th poster choosing the
> > same one.
> > 
> > I would expect that kind of response to a "kernel throws scary
> > warnings on boot for reasonably common setups", but for a comment
> > about a function being slightly wrong this kind of focus is
> > strange.
> > 
> > If that's some AI (s)tool responding to prompts along the lines of
> > "I want to fix some kernel problem, find some low-hanging fruit
> > and gimme a patch", we might be seeing a small-scale preview of
> > a future DDoS with the same underlying mechanism...
> 
> You do know that kernel-doc warns about this, right?
> 
>     $ ./scripts/kernel-doc -v -none include/linux/fs.h
>     [...]
>     Warning: include/linux/fs.h:3287 function parameter 'name' not described in 'name_contains_dotdot'
> 
> It's the only warning in include/linux/fs.h.

; ./scripts/kernel-doc -v -none include/linux/*.h 2>&1|grep -c Warning.*function\ parameter
 145

I rest my point.  If one of those has managed to generate 8 duplicate patches
(and the earliest one has landed in linux-next within a day) and people are
still sending that stuff...  I'd say we have a problem.

Whatever underlying mechanism is in action, it seems to have the makings of
a large DDoS.  I'm not blaming the people sending that and I would really
like to understand the mechanism behind this, er, synchronicity.

