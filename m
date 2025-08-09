Return-Path: <linux-fsdevel+bounces-57186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222DB1F72E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 01:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AAA621E5C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 23:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA126E714;
	Sat,  9 Aug 2025 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eah1Oj+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD22512FF
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Aug 2025 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754781254; cv=none; b=Me4mdIOTfxrYFDHHOuzSe9CzDtsQGV3N2DNPuaDMa98Zr2fSa1pduwsol0P52cfpQAMufmR1+sVATRICveCidcdZfEZEcj5w5Y8zZW3IpyYmP8iWiqZ9MUjfgNwjl1GLenzgy7OypNyOvp3/GK5W/LCftbM+EU55ZbwDUEuHXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754781254; c=relaxed/simple;
	bh=fmVPHBigGFAaqyMpsLUQ5LM4gMqJVzKCjUYlxvsHllU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdAYm8DBvUdmhO9f6niofbtb4R9ABRbpeO1P7yhBqTK7w1w+abuwVjSeMyn8s5kG4Vj1SGdV3nN/PAeQM4SK2IdKRLVdoZENyjBOglF+M17hlAwHw18VIxMVwXocb8frmlefIrdey+s/DHCs1rYsXZg5NMfT9cGgibDzWXrBeFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eah1Oj+y; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 9 Aug 2025 19:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754781239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iem01Egtfw6SUgLx/wWkmfSpdCk4uMYAUeBV3sOHgNw=;
	b=Eah1Oj+yMrE6PVZeSbwwQqP2AXAVWv0j6qzfWw+zW1unr68t7tS8ixjv+thEUOJZu7ZaY3
	PAT1KUhHkHjxEGW0MzsSXDD4jN48qslluIu/rI3AZeIGmyZqD4UjfBSNMQ89oKLy+6s9nF
	Wm5Wqw3c9nrlIwtNeSHC5i7V6PTO31w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Aquinas Admin <admin@aquinas.su>, 
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <5ip2wzfo32zs7uznaunpqj2bjmz3log4yrrdezo5audputkbq5@uoqutt37wmvp>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <aJfTPliez_WkwOF3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJfTPliez_WkwOF3@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Aug 10, 2025 at 12:01:18AM +0100, Matthew Wilcox wrote:
> On Sat, Aug 09, 2025 at 01:36:39PM -0400, Kent Overstreet wrote:
> > Yes, this is accurate. I've been getting entirely too many emails from
> > Linus about how pissed off everyone is, completely absent of details -
> > or anything engineering related, for that matter. Lots of "you need to
> > work with us better" - i.e. bend to demands - without being willing to
> > put forth an argument that stands to scrutiny.
> 
> Kent, if you genuinely don't understand by now what it is that you do
> that pisses people off, find someone you trust and get them to explain it
> to you.  I've tried.  Other people have tried.  You react by dismissing
> and insulting us, then pretending months later that you've done nothing
> wrong.  Now you've pissed off Linus and he has ultimate power to decide to
> accept your pull requests or not ... and he's decided not to.  You had
> a lot of chances to fix your behaviour before it got to this point.
> It's sad that you chose not to take any of them.
> 
> Can you really not see the difference between, eg Palmer's response here:
> https://lore.kernel.org/lkml/mhng-655602B8-F102-4B0F-AF4A-4AB94A9F231F@Palmers-Mini.rwc.dabbelt.com/
> 
> and your response whenever Linus dares to critique even the smallest
> parts of your pull requests?
> 
> [pointless attempt to divert the conversation to engineering snipped]

There's been pull requests where I've quietly dropped patches and
respun. I've never argued with Linus when it comes to other subsystems,
and there are things I've absolutely changed and addressed about the
bcachefs pull requests (e.g. switching to sending them on Thursdays;
which, unfortunately, took a three day shouting match before it came out
that that was the issue).

But when it comes to getting bugfixes out that users are waiting on; too
many of the pull requests have come over that, and "feedback" on those
has never come in the form of "do we need this? Can we dial things
back?" - too often it's been "oh hell no!"; and when I've got users I'm
supporting that's just not going to go well. Nor is it how things
generally work for other subsystems; Linus at one point gave me examples
of his other pull request feedback, while saying "this is totally
normal" - and my immediate response was, if I'd been getting that kind
of calm reasonable feedback, we'd have been in a very different place.

And you recently took to outright swearing at me on IRC, while I've been
staring at mm bugs and going "ok, the CONFIG_VM_DEBUG approach isn't
working".

And now, I just got an email from Linus saying "we're now talking about
git rm -rf in 6.18", after previously saying we just needed a
go-between.

So if that's the plan, I need to be arguing forcefully here, because a
lot is on the line for a lot of people.

I've heard from so many people saying things along the lines of "when
will it be ready, I _need_ something more reliable because I've been bit
too many times", and up until a month ago I've been telling people
"check back, we're nearly there, but check back soon".

Now, I finally clear out the bug tracker, and the bug reports and
feedback start pointing to "yes, we're pretty much there", and I have
this to face.

Oi vey.

