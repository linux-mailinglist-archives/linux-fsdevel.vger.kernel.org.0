Return-Path: <linux-fsdevel+bounces-52370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DB1AE269D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 02:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614343B6DDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 00:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7929B611E;
	Sat, 21 Jun 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y5ncqdnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530FC23BE
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jun 2025 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750464925; cv=none; b=P7kuFNL5cehRvskFiT0X6vghOoFb0KwbPXuhJq+4T6pOecfIhpE0cfa81d8pULGWZfGVs203rAf9NJshOvjPkxi2fdLUSJyujYCQkMrSSSTtd5tT1t95BN8Q2jGXbZdU+wuXX3X5O93Kc6YAyglVyl7Z5bscHQ6+NFtgRy3lFoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750464925; c=relaxed/simple;
	bh=c0MQdQUJ/7PLV4OEIM1qvc7bNbJ+uTYhn9q2lnM0T9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yds1UFAnRUeaMntQZS/IPjGlrQTP8eJXHaQpIdT8CaY9OdpjS+N8E0sNkDGcP0PzcNB7o0BXxYwOV7mwkBb5mkhRpL3A3Q/3BFIuTtqN6Fq+wbd3vgv4L10OFgktu6gJlII49CXxmcIwdqS8t9p2SpBLJcEFyt1/hi46ZN94g+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y5ncqdnj; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 20 Jun 2025 20:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750464918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0MQdQUJ/7PLV4OEIM1qvc7bNbJ+uTYhn9q2lnM0T9g=;
	b=Y5ncqdnjEoxQfeveIvJ0HysP5k8Ta5dQJNxM39qLZagDStIO1tAAErUzUSqsRkM/uekSX8
	sf1HTlIbZIPsW0ZV9If8qgFbfl2M9z/V9zsDjzkfP52QfGNrI6mjvdSETrMP74yzEnD9Mo
	wyzjpASqu8GCKlVimcgwVoA7v0CuUbw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Martin Steigerwald <martin@lichtvoll.de>, 
	Jani Partanen <jiipee@sotapeli.fi>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
Message-ID: <ztqfbkxiuuvsp7r66kqxlnedca3h5ckm5wscopzo2e4z33rrjg@lyundluol5qq>
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <06f75836-8276-428e-b128-8adffd0664ee@sotapeli.fi>
 <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
 <3366564.44csPzL39Z@lichtvoll.de>
 <hewwxyayvr33fcu5nzq4c2zqbyhcvg5ryev42cayh2gukvdiqj@vi36wbwxzhtr>
 <20250620124346.GB3571269@mit.edu>
 <bwhemajjrh7hao5nzs5t2jwcgit6bwyw42ycjbdi5nobjgyj7n@4nscl4fp6cjo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bwhemajjrh7hao5nzs5t2jwcgit6bwyw42ycjbdi5nobjgyj7n@4nscl4fp6cjo>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 20, 2025 at 07:35:04PM -0400, Kent Overstreet wrote:
> So it's hard to fathom what's going on here.

I also need to add that this kind of drama, and these responses to pull
requests - second guessing technical decisions, outright trash talk -
have done an incredible amount of damage, and I think it's time to make
you guys aware of that since it's directly relevant to the story of this
pull request.

I've put a lot of work into building a real community around bcachefs,
because that's critical to making it the rock solid, dependable
filesystem, for eeryone, that I intend it to be: building a community
where people feel free to share observations, bug reports, and where
people trust that those will be acted on responsibly.

That all gets set back whenever drama like this happens. Last time, the
casefolding bugfix pull request, ignited a whole vi. vs. emacs holy war.
Every time this happens, the calm, thoughtful people pull back, and all
I hear from are the angry, dramatic voices.

More than that, I lost a hire because of Linus's constant,
every-other-pull-request "I'm thinking about removing bcachefs from the
kernel". It turns out, smart, thoughtful engineers with stable jobs
become very hesitant about leaving those jobs when that happens, and
that's all their co-workers are seeing.

And the first thing that got cancelled/put aside because of that - work
that was in progress, and hasn't been completed - was tooling for
comprehensive programatic fault injection for on disk format errors.
IOW - the tooling and test coverage that would have caught the subvolume
deletion bug.

That's a really painful loss right now.

Even despite that, bcachefs development has been going incredibly
smoothly, and it's shaping up fast. Like I mentioned before, 100+ TB
filesystems are commonplace, users are commenting every release on how
much smoother is getting. We are, I hope, only a year or less from being
able to take the experimental label off, based on the decline in
critical bug reports I'm seeing.

The only area that gives me cause for concern - and it causes a _lot_ of
concern - is upstream.

