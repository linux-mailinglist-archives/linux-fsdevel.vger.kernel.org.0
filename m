Return-Path: <linux-fsdevel+bounces-14363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8FC87B37F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C9D1F241B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802053E3D;
	Wed, 13 Mar 2024 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fUgkPu16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C72482D3
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365676; cv=none; b=VPEMuemtrBtUxZXAjAXtZ2+z1cW7qFgJuinEvaRjfCc2+6KayqO/JrOSCmSRAUOjyeCsmyVNYnvYdp18b7l7xEnY5HfIMaZYLgcQWz4pYHTVTmL5BQTB60+ln6V6/N6GXM2lkqfLbGR0oAY5OMeE1b2HHiW00OZnDGxpei2WHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365676; c=relaxed/simple;
	bh=78PW4X14ihC5fEleCYrPCzpp+cNooZ+uZ4kgdRyzCH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPpqsMxSqtB01ULvo2yygXNBjy8KDMhcAkv17xeNXnNQm/h0adDe/Fd4R+nJ55+65LcCEm/0BtVp25VAmqT6krTxt3PmdCbW5b5nJCwUtCc5S2RdX8WGtWBgsqxvp9HQxzwwf+z5cl0tFfG63oMMhx+Nt4JbLarc3dNMzl65x3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fUgkPu16; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Mar 2024 17:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710365672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L6S/o0D2CMop6/QZVenetyqvM7me+8gNVf+Uyf/+tF8=;
	b=fUgkPu161w2XGctM6Q8jSdDM/+AiXHZGukaq16SZsbl/Rl+X/9FPrlhzRrXR2f3fBxSD+d
	fnQWYZw5eZNIh6DZmY5fuBr+tIWvZ6QOYEpswJcnxDIuIboKvcHR5boJfHyZ5XE5BOGiuC
	u1Vv4kyf46M8x1wEbIuBj453OemYWA0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.9
Message-ID: <bqlnihgtaxv4gq2k6nah33hq7f3vk73x2sd6mlbdvxln2nbfu6@ypoukdqdqbtb>
References: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
 <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 13, 2024 at 01:47:59PM -0700, Linus Torvalds wrote:
> On Tue, 12 Mar 2024 at 18:10, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Hi Linus, few patches for you - plus a simple merge conflict with VFS
> > changes:
> 
> The conflicts are trivial.
> 
> The "make random bcachefs code be a library function" stuff I looked
> at, decided is senseless, and ended up meaning that I'm not pulling
> this without a lot more explanation (and honestly, I don't think the
> explanations would hold water).
> 
> That "stdio_redirect_printf()" and darray_char stuff is just
> horrendous interfaces with no explanations. The interfaces are
> disgusting.

It's a bidirectional pipe between a kthread and an fd. Not sure what's
complicated about that?

> And if you *do* make it a library thing, it needs to be
> 
>  (a) much more explained
> 
>  (b) have much saner naming, and fewer disgusting and completely
> nonsensical interfaces ("DARRAY()").

DARRAY() is just a dynamic array, aka a c++ vector; we open code those so
much it's _stupid_. I wouldn't be opposed to changing the name to
something more standard (Rust calls it a vector too); I started out with
the CCAN version and rewrote it later for hte kernel.

> And no, finding one other filesystem to share this kind of code is not
> sufficient to try to claim it's a sane interface and sane naming.
> 
> But the main dealbreaker is the insane math.
> 
> And dammit, we talked about the idiotic "mean and variance" garbage
> long ago. It was wrong back then, it's *still* wrong.
> 
> You didn't explain why it couldn't use the *much* simpler MAD (median
> absolute deviation) instead of using variance.

I most certainly did.

I liked your MAD suggestion, but the catch was that we need an
exponentially weighted version, not just the standard version, and I
haven't seen an derivation of exponentially weighted MAD and doing that
is a bit above my statistical pay grade. I explained all this at the
time.

Besides that, the existing code works fine, the u128 stuff is right out
of Knuth (divide is the only even vaguely tricky one), and it's nicely
self contained. It's fine.

> I called it insanely over-engineered back then, and as far as I can
> tell, absolutely *NOTHING* has changed apart from some slight type
> name details.
> 
> As long as you made it some kind of bcachefs-only thing, I don't mind.
> 
> But now you're trying to push this garbage as some kind of generic
> library code that others would use, and that immediately means that I
> *do* mind insanely overengineered interfaces.
> 
> The time_stats stuff otherwise looks at leask like a sane interface
> with names and uses, but the use of that horrendous infrastructure
> scuttles it.

Well, that leaves us at a bit of an impasse then because Darrick wants
this stuff for XFS (he was discovering useful stuff with it pretty much
right away) and I'm just not doing a MAD conversion, sorry. I'm just
being practical here, I like MAD in principle but that's too far outside
my wheelhouse.

Maybe we can get someone else interested? I have a feeling Peter could
whip it out in about 5 minutes...

