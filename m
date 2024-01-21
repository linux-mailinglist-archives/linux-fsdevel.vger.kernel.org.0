Return-Path: <linux-fsdevel+bounces-8364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9578355A0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 13:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A403BB21639
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4A36B10;
	Sun, 21 Jan 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UGshX6PL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C536AFB
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705839640; cv=none; b=IgNNgFoX55GrZE3O64hLdxIzQlhrwUT9h/1vpaRdAxMf5Ey5CrgvKE1j6hPqUm127BtytNbAOmGe02nE2ZAiK1UKXZtZmhJ0i045KOn4wgKkKB5MjqHBEbNchmXZkr9UeAnZ2dy3sW0Zzi1GYo64qiFgYgTXoZrDP4HlB4WpRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705839640; c=relaxed/simple;
	bh=JfMnjHNkzRw8i9j0k1upUxvHfwH7uPKDpAZHbblJyGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLV11LbGaJBmtn6Fxhg4kMUD8kb1RTlrZl0l3ug3tTKfpfP5z6B/yl03pFX8Wk4g1+IiitX6iAU9LB9JW7eBlfmMwDINOGQu3rYm4A0BNWsRM477j3FJ/2eKI2EukmoD32XPt+CHeVzLVAc0pFbPTw+DrrTICP/WbG3hTMHHqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UGshX6PL; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 21 Jan 2024 07:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705839636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhNPlaBEpE1xN4v3GTZA0CsrCRKrMbxj54/fyRMaXwg=;
	b=UGshX6PLCyjkuZXe1ylBJ4pAZyxjp5sCWpvlS9QneLoRnDCEWuea+ffZ/c3Uy6IT3whTls
	GqSzZQqyWVehRmwvIT0qPH+u/RoEyQ8Rlqd3f15b3le7T5mV3+HYeOw/OPnNRf7PyDYhH+
	vhW2ETUg2IzOSP9rrlj/g/oFwsSZ5Ys=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>, 
	Philip Li <philip.li@intel.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <32cn5wzlryvq7z64uwo3ztooh7rthlp2ihmbgfyayvehtdbeyt@pnvumkjz4eve>
References: <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
 <20240117055457.GL911245@mit.edu>
 <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
 <20240118024922.GB1353741@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118024922.GB1353741@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 17, 2024 at 09:49:22PM -0500, Theodore Ts'o wrote:
> On Wed, Jan 17, 2024 at 08:03:35AM -0500, James Bottomley wrote:
> > Actually, this is partly our fault.  Companies behave exactly like a
> > selfish contributor does:
> > 
> > https://archive.fosdem.org/2020/schedule/event/selfish_contributor/
> > 
> > The question they ask is "if I'm putting money into it, what am I
> > getting out of it".  If the answer to that is that it benefits
> > everybody, it's basically charity  to the entity being asked (and not
> > even properly tax deductible at that), which goes way back behind even
> > real charitable donations (which at least have a publicity benefit) and
> > you don't even get to speak to anyone about it when you go calling with
> > the collecting tin.  If you can say it benefits these 5 tasks your
> > current employees are doing, you might have a possible case for the
> > engineering budget (you might get in the door but you'll still be
> > queuing behind every in-plan budget item).  The best case is if you can
> > demonstrate some useful for profit contribution it makes to the actual
> > line of business (or better yet could be used to spawn a new line of
> > business), so when you're asking for a tool, it has to be usable
> > outside the narrow confines of the kernel and you need to be able to
> > articulate why it's generally useful (git is a great example, it was
> > designed to solve a kernel specific problem, but not it's in use pretty
> > much everywhere source control is a thing).
> 
> I have on occasion tried to make the "it benefits the whole ecosystem"
> argument, and that will work on the margins.  But it's a lot harder
> when it's more than a full SWE-year's worth of investment, at least
> more recently.  I *have* tried to get more test investment. with an
> eye towards benefitting not just one company, but in a much more
> general fasion ---- but multi-engineer projects are a very hard sell,
> especially recently.  If Kent wants to impugn my leadership skills,
> that's fine; I invite him to try and see if he can get SVP's cough up
> the dough.  :-)

Well, I've tried talking to you about improving our testing tooling - in
particular, what we could do if we had better, more self contained
tools, not just targeted at xfstests, in particular a VM testrunner that
could run kselftests too - and as I recall, your reaction was pretty
much "why would I be interested in that? What does that do for me?"

So yeah, I would call that a fail in leadership. Us filesystem people
have the highest testing requirements and ought to know how to do this
best, and if the poeple with the most experience aren't trying share
that knowledge and experience in the form of collaborating on tooling,
what the fuck are we even doing here?

If I sound frustrated, it's because I am.

> I've certainly had a lot more success with the "Business quid pro quo"
> argument; fscrypt and fsverity was developed for Android and Chrome;
> casefolding support benefited Android and Steam; ext4 fast commits was
> targetted at cloud-based NFS and Samba serving, etc.

Yeah, I keep hearing you talking about the product management angle and
I have to call bullshit. There's a lot more to maintaining the health of
projects in the long term than just selling features to customers.

> Unfortunately, this effect fades over time.  It's a lot easier to fund
> multi-engineer projects which run for more than a year, when a company
> is just starting out, and when it's still trying to attract upstream
> developers, and it has a sizeable "investment" budget.  ("IBM will
> invest a billion dollars in Linux").  But then in later years, the
> VP's have to justify their budget, and so companies tend to become
> more and more "selfish".  After all, that's how capitalism works ---
> "think of the children^H^H^H^H^H^H^H shareholders!"

This stuff doesn't have to be huge multi engineer-year projects to get
anything useful done.

ktest has been a tiny side project for me. If I can turn that into a
full blown CI that runs arbitrary self contained VM tests with quick
turnaround and a nice git log UI, in my spare time, why can't we pitch
in together instead of each running in different directions and
collaborate and communicate a bit better instead of bitching so much?

