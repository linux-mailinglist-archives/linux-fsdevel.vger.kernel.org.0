Return-Path: <linux-fsdevel+bounces-8362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDBD835451
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 04:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4588F281C47
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 03:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63EA36132;
	Sun, 21 Jan 2024 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GHwiI4R9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942B36114;
	Sun, 21 Jan 2024 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705807456; cv=none; b=XGEpR1jFtY8vH0mW/oLr7Bcgwp9FYRrc96+Q67lAIHQ8wyxt+G+8f63JwZfaiOTK/A+cV++QctoB960XxTiSm7Nb5avKIG1/BAGTtp259BCQkY1X4TmAvscmvfE6hRSrcRmaRK9aWIKlJ1U1VtPM9AvouFPCcRNk1YWtRGcw2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705807456; c=relaxed/simple;
	bh=wcmf/aOorBM5e7eQSiImvkWOPTSRCqUlnSV1FKys9QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+nVGh1QInGc1yvqEKnNOVojsI+CRt2w6LXBnwdl0uQ1ZRZtSUeKOIzq0McGj7/9ox/OxKDHmbH+h2DRnfXdu3kwpKdiv/kpkS+q3ik/7yYmRY/+IEvxTltQlx6EVK3pSxumkWD1rIs52XJT1Gz8L2CmZmMCI4wtJ2Pq7GU/qF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GHwiI4R9; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 20 Jan 2024 22:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705807452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jOpZnzgSpAJpw2OiDuuykdPLSgVkSPFMKVCSLSDMYA0=;
	b=GHwiI4R9s3oMIchWXoZL1K2QaxLiHwJ45PB40kYV+CAscT3//oXAZ/GAF86O0AOVo0qKeM
	xmA9YmJ3WHV5pINHYzj0AYFy+uj/wbQtyDZ+4fqvcddZTl5wm21gEO3JVou06KGBwplPBM
	/Z0/M2yrFKefmw73jUgfCKHM74IvnAc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>, Neal Gompa <neal@gompa.dev>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>, 
	Philip Li <philip.li@intel.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <vm5fwfqtqoy5yl37meflf4yrmzotyi5aszouwthfv6q7nrtxhq@oucmld5ak4uo>
References: <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
 <20240117055457.GL911245@mit.edu>
 <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
 <c69a3103-ae4d-459a-b5f4-d3bbe2af6fb2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69a3103-ae4d-459a-b5f4-d3bbe2af6fb2@sirena.org.uk>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 17, 2024 at 06:19:43PM +0000, Mark Brown wrote:
> On Wed, Jan 17, 2024 at 08:03:35AM -0500, James Bottomley wrote:
> 
> > I also have to say, that for all the complaints there's just not any
> > open source pull for test tools (there's no-one who's on a mission to
> > make them better).  Demanding that someone else do it is proof of this
> > (if you cared enough you'd do it yourself).  That's why all our testing
> > infrastructure is just some random set of scripts that mostly does what
> > I want, because it's the last thing I need to prove the thing I
> > actually care about works.
> 
> > Finally testing infrastructure is how OSDL (the precursor to the Linux
> > foundation) got started and got its initial funding, so corporations
> > have been putting money into it for decades with not much return (and
> > pretty much nothing to show for a unified testing infrastructure ...
> > ten points to the team who can actually name the test infrastructure
> > OSDL produced) and have finally concluded it's not worth it, making it
> > a 10x harder sell now.
> 
> I think that's a *bit* pessimistic, at least for some areas of the
> kernel - there is commercial stuff going on with kernel testing with
> varying degrees of community engagement (eg, off the top of my head
> Baylibre, Collabora and Linaro all have offerings of various kinds that
> I'm aware of), and some of that does turn into investments in reusable
> things rather than proprietary stuff.  I know that I look at the
> kernelci.org results for my trees, and that I've fixed issues I saw
> purely in there.  kselftest is noticably getting much better over time,
> and LTP is quite active too.  The stuff I'm aware of is more focused
> around the embedded space than the enterprise/server space but it does
> exist.  That's not to say that this is all well resourced and there's no
> problem (far from it), but it really doesn't feel like a complete dead
> loss either.

kselftest is pretty exciting to me; "collect all our integration tests
into one place and start to standarize on running them" is good stuff.

You seem to be pretty familiar with all the various testing efforts, I
wonder if you could talk about what you see that's interesting and
useful in the various projects?

I think a lot of this stems from a lack of organization and a lack of
communication; I see a lot of projects reinventing things in slightly
different ways and failing to build off of each other.

> Some of the issues come from the different questions that people are
> trying to answer with testing, or the very different needs of the
> tests that people want to run - for example one of the reasons
> filesystems aren't particularly well covered for the embedded cases is
> that if your local storage is SD or worse eMMC then heavy I/O suddenly
> looks a lot more demanding and media durability a real consideration.

Well, for filesystem testing we (mostly) don't want to be hammering on
an actual block device if we can help it - there are occasionally bugs
that will only manifest when you're testing on a device with realistic
performance characteristics, and we definitely want to be doing some
amount of performance testing on actual devices, but most of our testing
is best done in a VM where the scratch devices live entirely in dram on
the host.

But that's a minor detail, IMO - that doesn't prevent us from having a
common test runner for anything that doesn't need special hardware.

