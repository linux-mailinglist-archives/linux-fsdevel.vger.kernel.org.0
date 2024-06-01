Return-Path: <linux-fsdevel+bounces-20708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45398D7067
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35513B21C93
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6F615218F;
	Sat,  1 Jun 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrdpjmcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426E14F9D4;
	Sat,  1 Jun 2024 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717250973; cv=none; b=eN2UzAchL7PUlzzVWJHcKu9rAIMMzre1dR8Sp8PgSl5wA0gkHFrGSIqJKJ/kva1tApj5wpszVWMkG/3DHa+IwItr/XyNX5E8rXkKDOg6fPHWvEIEnEKY6JUE/Nsg6vI4btqy/jK8J/VV7PDe9XSFDFmUnHu1TFPa1hSL41FJuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717250973; c=relaxed/simple;
	bh=CH98rChsYVgD9QB6NwKsJnFDWE+xfbmZZktISZ08DXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omh9jPUboXH0n4yvR+52asvkqzuILT6bzjYDF106f+aocbJ0hGtxMdTuNTRY9UPMugINhIe1kZ3Tx0Nmo5kvf8tlM3IbjnPz5CvvBT/jdeLBUA9NUnsutrUCL3sdc52mtWHi+zNgmvwuYHovgFl0iIAMpH9WqGAjG86fjXmLot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrdpjmcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C70C116B1;
	Sat,  1 Jun 2024 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717250972;
	bh=CH98rChsYVgD9QB6NwKsJnFDWE+xfbmZZktISZ08DXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrdpjmcnkV2/UVGdrhtrRDAKS5XoJLVSB+XD6Rkp5SL+xy20olx0fADE185+Lqupp
	 AcpZHOcxp0KpS8ZwwA7ySOiu8hnKeEfwGYKHeUtdy+3ZOMx81Lh0O9haS9W+oydxab
	 eKXCgfIuDqcsWS4VJ3T8MDyfWdhq5zLvgQS02kkCXZUU4TVH8sR61lGGztvwhXr1qn
	 t1OSYFQ3RkJoSEYM28oQexlnnUv5jmiiXf6uAq8vzN1XU9y/o35YfftTAeQ2vyMCAh
	 7UjqsCnZE2M1OhRPXqq+obaxXzrdDbRKQseF2uRPHZctARLMSfLdaIFwzo8BpI9Wnn
	 i5KmZkeZZl4iw==
Date: Sat, 1 Jun 2024 07:09:32 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates fro 6.10-rc1
Message-ID: <202406010706.E3A0E963FE@keescook>
References: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
 <202405191921.C218169@keescook>
 <2uuhtn5rnrfqvwx7krec6lc57gptqearrwwbtbpedvlbor7ziw@zgbzssfacdbe>
 <a1aa10f9d97b2d80048a26f518df2a4b90c90620.camel@HansenPartnership.com>
 <ZlsHCzAPzp6XwTqw@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlsHCzAPzp6XwTqw@finisterre.sirena.org.uk>

On Sat, Jun 01, 2024 at 12:33:31PM +0100, Mark Brown wrote:
> On Mon, May 20, 2024 at 12:10:31PM -0400, James Bottomley wrote:
> > On Sun, 2024-05-19 at 23:52 -0400, Kent Overstreet wrote:
> 
> > > I also do (try to) post patches to the list that are doing something
> > > interesting and worth discussion; the vast majority this cycle has
> > > been boring syzbot crap...
> 
> > you still don't say what problem not posting most patches solves?  You
> > imply it would slow you down, but getting git-send-email to post to a
> > mailing list can actually be automated through a pre-push commit hook
> > with no slowdown in the awesome rate at which you apply patches to your
> > own tree.
> 
> > Linux kernel process exists because it's been found to work over time.
> > That's not to say it can't be changed, but it usually requires at least
> > some stab at a reason before that happens.
> 
> Even if no meaningful review ever happens on the actual posts there's
> still utility in having the patches on a list and findable in lore,
> since everything is normally on the list people end up with workflows
> that assume that they'll be able to find things there.  For example it's
> common for test people who identify which patch introduces an issue to
> grab the patch from lore in order to review any discussion of the patch,
> then report by replying to the patch to help with context for their
> report and get some help with figuring out a CC list.  Posting costs
> very little and makes people's lives easier.

Exactly. This is the standard workflow that everyone depends on.

So, for example, for my -next trees, I only ever add patches to them via
"b4 am lore-url-here...".

If I've got patches to add to -next from some devel tree, I don't
cherry-pick them to my -next tree: I send them to lore, and then pull
them back down.

But the point is: send your stuff to lore. :)

-- 
Kees Cook

