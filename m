Return-Path: <linux-fsdevel+bounces-58888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47994B32CF2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 03:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04308481A92
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 01:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23E41A9FB8;
	Sun, 24 Aug 2025 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSEug5dI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18027CA5A;
	Sun, 24 Aug 2025 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756000347; cv=none; b=Nfpv01GWREAgCPD6JqgnB2JfO4boRqsix57ACoAiL48zoZZ5NKhKr2+S19nVLhFDQ4X4iMGLpENsiEwtunQ1Yc5/33HlroZ3sS9QbpzlpKuC3gJztIPjgtEae7Lv0bglCTeTpRmIK7GC3ZdgWkKN9KVAZC2L/XYiC3asJO5qI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756000347; c=relaxed/simple;
	bh=utIESIcgFRVKaWUGs8sAx4c6YLTt8HuTo7W+Fj5oaTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkDnFSnOrj7vTaqly0hQ9rt02q5FxgH2Ul0QGHQouGQr8Sy8Z/mxRCQLH2zt8G7YmwWO9lkh/QJicHUiKFOQkMzPvEitGhLOhP83pN9FLz2WZawE3x3HsTjIsctwYLKcLqZV0JYwlEdSZ2ZXZZEAQ7CtUpBfd6P6eI+eF9j9HZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSEug5dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D982C4CEE7;
	Sun, 24 Aug 2025 01:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756000346;
	bh=utIESIcgFRVKaWUGs8sAx4c6YLTt8HuTo7W+Fj5oaTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSEug5dIRh+grc1hy8Kj1MauAFS4jFtxIWYJF2f9CayMb1WQHhyD6faSxmUHZBQXv
	 KtmyRoODeZJxNcfPQpYGucW5RKvtWiLP0s27XaqWtix1UQ0weXVvdwoYqCE1Wcjmuu
	 HoCVho4/AmA+Zne5hICzJKrqJcmGUtr2BqpPiDJpYzKx73d/pUDdE0JRUkC1Kmgsqa
	 t6cMA9mk+6xMOm2YbgyojY/OrY52/zCZmH0yrwZY+4nbDYd2QKIEVMbEE7qNcnmyrO
	 mX7YiBxV891MZVzq+1A41fah4Drm85mlEs790eT9VM6AiwBwC4IYa70NfaPiYdT5Ed
	 3ub4nCjlkfEEg==
Date: Sat, 23 Aug 2025 21:52:24 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Prithvi Tambewagh <activprithvi@gmail.com>, skhan@linuxfoundation.org,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Document 'name' parameter in name_contains_dotdot()
Message-ID: <20250824015224.GA12644@quark>
References: <20250823142208.10614-1-activprithvi@gmail.com>
 <20250824010623.GE39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824010623.GE39973@ZenIV>

On Sun, Aug 24, 2025 at 02:06:23AM +0100, Al Viro wrote:
> On Sat, Aug 23, 2025 at 07:52:08PM +0530, Prithvi Tambewagh wrote:
> > Add documentation for the 'name' parameter in name_contains_dotdot()
> > 
> > Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> 
> Out of curiosity, could you describe the process that has lead to
> that patch?
> 
> The reason why I'm asking is that there had been a truly ridiculous
> amount of identical patches, all dealing with exact same function.
> 
> Odds of random coincedence are very low - there's quite lot of
> similar places, and AFAICS you are the 8th poster choosing the
> same one.
> 
> I would expect that kind of response to a "kernel throws scary
> warnings on boot for reasonably common setups", but for a comment
> about a function being slightly wrong this kind of focus is
> strange.
> 
> If that's some AI (s)tool responding to prompts along the lines of
> "I want to fix some kernel problem, find some low-hanging fruit
> and gimme a patch", we might be seeing a small-scale preview of
> a future DDoS with the same underlying mechanism...

You do know that kernel-doc warns about this, right?

    $ ./scripts/kernel-doc -v -none include/linux/fs.h
    [...]
    Warning: include/linux/fs.h:3287 function parameter 'name' not described in 'name_contains_dotdot'

It's the only warning in include/linux/fs.h.

- Eric

