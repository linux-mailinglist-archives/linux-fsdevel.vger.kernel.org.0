Return-Path: <linux-fsdevel+bounces-20705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C98D6F7D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 13:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BD71F22228
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CA84E08;
	Sat,  1 Jun 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pse4ENjE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B97F7CA;
	Sat,  1 Jun 2024 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717241615; cv=none; b=U8EuQ6/QYaY8/b9XL3HaflijyqDeNTCpu3qDlH79INptyE8AD1f05JHNn4+jknBu9cDBEzkFMvjSGi5myDGndBgXQec5QxsOBaAdm16nsLPsdGm9IzZUTVDipPwiJ8S+m/A+1MEyysEay0boDwXmAtAkZrOoAvjUEJJ9x04brq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717241615; c=relaxed/simple;
	bh=1sQLkbFvGo0K2q+/mxnULj8MtZJc0U6foyt7fFEL0Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heE/LGQBjjj8viuGWJVMfmqOFktjRALFUFZX2ZOucO+Uq9+kl7kVteNyrUhzoviRgx2M5HqLMo0rx6sIrZTLDe72O5PoOjTEupAsOWkhDSgjZULqSQwlR2zOJ4zesytfhAD/HnNCPsPF1nTuFYPqUo75c9W3lern+o72DeB4KkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pse4ENjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC40C116B1;
	Sat,  1 Jun 2024 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717241614;
	bh=1sQLkbFvGo0K2q+/mxnULj8MtZJc0U6foyt7fFEL0Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pse4ENjEiWPsplyFVmTE4IAyWq6Kt9wKjNgHZrwIkEK23dzThHnZHJS3BvMNKDO9X
	 9sFs9Qjb2HCk1CqPtAYUs9LvJRiNfjdVVno4rHlwFd8QpxuvA6/W/4lR0rjfJZrnuy
	 /cNfHqY3p3nul1dbZmm9CzQ5LhBTattxxXh7oS6SgZZtDK6FoK8EJnCCvYvLT0cHFs
	 Mwu5K3ZizZZAq8Ic4kIjFdenWGqMZTAKTupS0COfFrTkW3ZPI4OLtCmuAPrPNUcyiG
	 jXidr8VOltAzSj27aDJGxETk/P4Qe+h7Q7pejnIQbvp+MN/WLfgOO+JnoXw+0OQkzd
	 Jpbq0YzbzK/nA==
Date: Sat, 1 Jun 2024 12:33:31 +0100
From: Mark Brown <broonie@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates fro 6.10-rc1
Message-ID: <ZlsHCzAPzp6XwTqw@finisterre.sirena.org.uk>
References: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
 <202405191921.C218169@keescook>
 <2uuhtn5rnrfqvwx7krec6lc57gptqearrwwbtbpedvlbor7ziw@zgbzssfacdbe>
 <a1aa10f9d97b2d80048a26f518df2a4b90c90620.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4CGzBNjsXpkSmh79"
Content-Disposition: inline
In-Reply-To: <a1aa10f9d97b2d80048a26f518df2a4b90c90620.camel@HansenPartnership.com>
X-Cookie: I had pancake makeup for brunch!


--4CGzBNjsXpkSmh79
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2024 at 12:10:31PM -0400, James Bottomley wrote:
> On Sun, 2024-05-19 at 23:52 -0400, Kent Overstreet wrote:

> > I also do (try to) post patches to the list that are doing something
> > interesting and worth discussion; the vast majority this cycle has
> > been boring syzbot crap...

> you still don't say what problem not posting most patches solves?  You
> imply it would slow you down, but getting git-send-email to post to a
> mailing list can actually be automated through a pre-push commit hook
> with no slowdown in the awesome rate at which you apply patches to your
> own tree.

> Linux kernel process exists because it's been found to work over time.
> That's not to say it can't be changed, but it usually requires at least
> some stab at a reason before that happens.

Even if no meaningful review ever happens on the actual posts there's
still utility in having the patches on a list and findable in lore,
since everything is normally on the list people end up with workflows
that assume that they'll be able to find things there.  For example it's
common for test people who identify which patch introduces an issue to
grab the patch from lore in order to review any discussion of the patch,
then report by replying to the patch to help with context for their
report and get some help with figuring out a CC list.  Posting costs
very little and makes people's lives easier.

--4CGzBNjsXpkSmh79
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZbBwcACgkQJNaLcl1U
h9Ctrgf/V6HUvGS/lPiuRfYtqLPYUmt8K87RV8eA9xCDQGpM7WHVSbkFrSSXMJy5
kGecY0z4i1r25gjcaTl1DeqIa7QUs5SBWTzj+UC7dT0Sy4tLdNAT0jTbWetaUBTU
g/7S6c4OED/rNxsh8+uSHRbVZ3HBrtI4oAkG7jF2kuAWEoV4VmktIoeCgMrryNMc
VIfedpdi3QAs3Emog0zyGJBT9W7SL87woIvJYqdEuqePMdKiGol/X7XEXouCuBAz
+tuQSVVCBeAS0CunkIb520pAQP0OQopWQ5VhC6DdBeIHUttRoSfYWsophiULuAhj
bBYASjNxk6wEC/C8ikmxN4WYA0znrQ==
=3llj
-----END PGP SIGNATURE-----

--4CGzBNjsXpkSmh79--

