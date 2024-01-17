Return-Path: <linux-fsdevel+bounces-8132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0950482FF9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 05:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A541C23AB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 04:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD8A6FDC;
	Wed, 17 Jan 2024 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SzNF3lQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94A5CB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 04:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705466494; cv=none; b=Ek09EOpMmYQcHZ0DY4ESwEG9+XA5plXoOSbamDrp2rS4GVKwkC/9VIFOJkibrleH+igkr0nvv9XpqVyI2+yomrdNJ22a/o/nrE4hG/I3aH5nTuhrPe19scpQbSigZqrAnBtLUsHwZNqElCoCcWKb32o7SRf+jtrNnULhObH6O2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705466494; c=relaxed/simple;
	bh=Qzr9zg1+p1Bd/iMhIuiKvCHy5JjGHYMzisOT7Tym+yw=;
	h=Date:DKIM-Signature:X-Report-Abuse:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Migadu-Flow; b=QQsxq57cnoAVU2YOJPRE2hXH7f03RLop8cFU/vA25LC8cFHj8mhONRld7HEmCTQhGu3SwIkgJK1JX8NFRZ8u4PesF//M2/Sb7DRqGinoMPEAtkusLAZLRsu5/yqfGqLyIZH5NFrAtyZHiRrxNJDBafqcePH4OZb9hBGZERvYp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SzNF3lQ/; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 16 Jan 2024 23:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705466489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT2xs/iTZQyQPumh74lkYawLrjrkx0mF5IFfdjGo1zU=;
	b=SzNF3lQ/ViYDUhvlSgoOFXyhd3+jDTorTlpocWhQR8xkbF+WF94sAuj9E2lLXMJL+39Isg
	2tdhwB/cyNg3Y2yCuOE3rdqyWaLkjB7uKuxCJNoQd7ae/eePU+a80SCCZjvjeWtcCmXaZ8
	Kapt/e8Acj1dfKALRwhQtgrnQh+4IB0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <greg@kroah.com>
Cc: Mark Brown <broonie@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>, 
	Philip Li <philip.li@intel.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
References: <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011532-mortician-region-8302@gregkh>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 15, 2024 at 09:13:01PM +0100, Greg KH wrote:
> On Mon, Jan 15, 2024 at 01:42:53PM -0500, Kent Overstreet wrote:
> > > That sounds more like a "(reproducible) tests don't exist" complaint
> > > which is a different thing again to people going off and NIHing fancy
> > > frameworks.
> > 
> > No, it's a leadership/mentorship thing.
> > 
> > And this is something that's always been lacking in kernel culture.
> > Witness the kind of general grousing that goes on at maintainer summits;
> > maintainers complain about being overworked and people not stepping up
> > to help with the grungy responsibilities, while simultaneously we still
> > very much have a "fuck off if you haven't proven yourself" attitude
> > towards newcomers. Understandable given the historical realities (this
> > shit is hard and the penalties of fucking up are high, so there does
> > need to be a barrier to entry), but it's left us with some real gaps.
> > 
> > We don't have enough a people in the senier engineer role who lay out
> > designs and organise people to take on projects that are bigger than one
> > single person can do, or that are necessary but not "fun".
> > 
> > Tests and test infrastructure fall into the necessary but not fun
> > category, so they languish.
> 
> No, they fall into the "no company wants to pay someone to do the work"
> category, so it doesn't get done.
> 
> It's not a "leadership" issue, what is the "leadership" supposed to do
> here, refuse to take any new changes unless someone ponys up and does
> the infrastructure and testing work first?  That's not going to fly, for
> valid reasons.
> 
> And as proof of this, we have had many real features, that benefit
> everyone, called out as "please, companies, pay for this to be done, you
> all want it, and so do we!" and yet, no one does it.  One real example
> is the RT work, it has a real roadmap, people to do the work, a tiny
> price tag, yet almost no one sponsoring it.  Yes, for that specific
> issue it's slowly getting there and better, but it is one example of how
> you view of this might not be all that correct.

Well, what's so special about any of those features? What's special
about the RT work? The list of features and enhancements we want is
never ending.

But good tools are important beacuse they affect the rate of everyday
development; they're a multiplier on the money everone is spending on
salaries.

In everyday development, the rate at which we can run tests and verify
the corectness of the code we're working on is more often than not _the_
limiting factor on rate of development. It's a particularly big deal for
getting new people up to speed, and for work that crosses subsystems.


> And you will see that we now have the infrastructure in places for this.
> The great kunit testing framework, the kselftest framework, and the
> stuff tying it all together is there.  All it takes is people actually
> using it to write their tests, which is slowly happening.
> 
> So maybe, the "leadership" here is working, but in a nice organic way of
> "wouldn't it be nice if you cleaned that out-of-tree unit test framework
> up and get it merged" type of leadership, not mandates-from-on-high that
> just don't work.  So organic you might have missed it :)

Things are moving in the right direction; the testing track at Plumber's
was exciting to see.

Kselftests is not there yet, though. Those tests could all be runnable
with a single command - and _most_ of what's needed is there, the kernel
config dependencies are listed out, but we're still lacking a
testrunner.

I've been trying to get someone interested in hooking them up to ktest
(my ktest, not that other thing), so that we'd have one common
testrunner for running anything that can be a VM test. Similarly with
blktests, mmtests, et cetera.

Having one common way of running all our functional VM tests, and a
common collection of those tests would be a huge win for productivity
because _way_ too many developers are still using slow ad hoc testing
methods, and a good test runner (ktest) gets the edit/compile/test cycle
down to < 1 minute, with the same tests framework for local development
and automated testing in the big test cloud...

