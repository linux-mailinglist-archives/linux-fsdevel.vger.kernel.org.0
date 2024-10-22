Return-Path: <linux-fsdevel+bounces-32622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FB09AB9C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 00:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400C51F24227
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 22:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F41CF281;
	Tue, 22 Oct 2024 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XANmPJLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C81CEE94;
	Tue, 22 Oct 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637901; cv=none; b=dHqkCHXBw/jFnwFUlMi0R7STt1tWSaUBCy7NuQhwp/ykkzE6qXsYzEcfjuigyknFIVn0w8uebsYv4S2vWT11FXXZCJL0vbMJr0sT2Y0+dlaZNY42W+l7NZG7SjE4neJ3fcVPwS9fF+MHGDiT0SZ2hoU7z6cbkhp/ptXW5fS96mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637901; c=relaxed/simple;
	bh=LppYdUsMIER80LrBQvaZektPYyEGIeG/zNXB8jqSRZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLe6fl/QOBoG5w5Yryw4XUyV5Um9lsoZ4iTgU6ApOvkDPDI+ddGo5EFNw9bYKkrAiBVgVchIM1xMGT+C1Xr3rgSakJUye/jHrPYHN0ITIowxsigpAtrFvPmrAfAo3vFCb+RPoTGjAs7T43YVz9EB3jX2E5smD+8J6yY/cma/irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XANmPJLB; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 18:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729637894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2D9SnjSf1zOnS6WF2Ttzy/TgN5LLfpg5eh2hw1wYNIE=;
	b=XANmPJLBEPn4hEezpWvRgQBQg+/w0HaOqzQKCVPDtB+Zk8OIYKspVk3MYyFMFWvAHGmr7F
	XInKAWc6yYFJ53FLi9pH9bBFHHejP0hpPRkMQq2kurIZCwGyMJjeWnRS1qkhujqNtRxj+P
	5kcozFx299bvXG7k2WJTrFIDFUGJkrk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kees@kernel.org, hch@infradead.org, broonie@kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <dctt3tf65qsvwyr5exvee7bkmwh6aejqcd4t7uwfzvjiowqtzk@fncmtmgdbg5b>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
 <Zxf3vp82MfPTWNLx@sashalap>
 <20241022204931.GL21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022204931.GL21836@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 22, 2024 at 01:49:31PM -0700, Darrick J. Wong wrote:
> On Tue, Oct 22, 2024 at 03:06:38PM -0400, Sasha Levin wrote:
> > On Tue, Oct 22, 2024 at 01:39:10PM -0400, Kent Overstreet wrote:
> > > 
> > > The following changes since commit 5e3b72324d32629fa013f86657308f3dbc1115e1:
> > > 
> > >  bcachefs: Fix sysfs warning in fstests generic/730,731 (2024-10-14 05:43:01 -0400)
> > > 
> > > are available in the Git repository at:
> > > 
> > >  https://github.com/koverstreet/bcachefs tags/bcachefs-2024-10-22
> > 
> > Hi Linus,
> > 
> > There was a sub-thread on the linus-next discussion around improving
> > telemetry around -next/lore w.r.t soaking time and mailing list reviews
> > (https://lore.kernel.org/all/792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org/).
> > 
> > I've prototyped a set of scripts based on suggestions in the thread, and
> > wanted to see if you'd find it useful. A great way to test it out is with
> > a random pull request you'd review anyway :)
> > 
> > Is the below useful in any way? Or do you already do something like this
> > locally and I'm just wasting your time?
> > 
> > If it's useful, is bot reply to PRs the best way to share this? Any
> > other information that would be useful?
> 
> As a maintainer I probably would've found this to be annoying, but with
> all my other outside observer / participant hats on, I think it's very
> good to have a bot to expose maintainers not following the process.

That's the interesting about face...

Personally, I'm curious what people are trying to achieve here.

