Return-Path: <linux-fsdevel+bounces-8194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24739830C9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2361F23DC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4422F16;
	Wed, 17 Jan 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adFzkfSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150422EE0;
	Wed, 17 Jan 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515590; cv=none; b=CkqNDY2w/N9BpzN4foTzuOPDgnqvMtHoKv1fQhFtlvjb96LyxXD7XXy1gvAIfMfvXaM3gpdVxikuXZZdWi6nG3zjgAOwl/KgC+XF6g2zPltxaG3iVHK0OZMiHcVsYRhY4enB/jqhWNb+f5bBpKikGqNv6f4YrRzVkykDxchZYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515590; c=relaxed/simple;
	bh=qGlcZRV44crjqbw1JQjmrtKXLKflvsUJg8srLpQ9eco=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=JPVk6j/BIC9MkBXnO1Fon03MyJMeTIuR2lr/iEgHbopUkyD0sKssYOyy4dbDNMA4mmBVsygeXrpanYgne12YVxHmnkwTP+hpV/q5Rpk7KIEz4Tkis5NlnLHaA3ULtZqseJ2jDzwo05/YA+WCbYUEaxqlbx5oB4tpN6ky+LenneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adFzkfSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A2C433C7;
	Wed, 17 Jan 2024 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705515589;
	bh=qGlcZRV44crjqbw1JQjmrtKXLKflvsUJg8srLpQ9eco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adFzkfSOVycGp6YJDdZ0RCzxsP3syYVSeLMqqsOZ2+IuVdDJ2F8BeiEZNAE1+G4nF
	 uwAy1cm7aUll6YGX/rBgIeKNLKAaCuI5SRH0Cz7M9HPA5oXrvwX0jXpLe3F92eTv7T
	 Ogmf+M5bUkMIe876iFliMxq/yQ00eg0kxxKUTe9WQR8fgsEQ/jj17xF8697FV8TOeT
	 KnfylJh+dP0/v2DiUa4OVGZ7NUKojv0MbupGpFswIpMRO2dtm+68PJS0BTDts6m6lO
	 7A9FabHDWunu3/oDuIUv1IZW72VZpvSJeGtaBrmZ49gDYAydA3jj382NAIIRfi13lH
	 di4hlLX2dmdHQ==
Date: Wed, 17 Jan 2024 18:19:43 +0000
From: Mark Brown <broonie@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Greg KH <greg@kroah.com>, Neal Gompa <neal@gompa.dev>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Nikolai Kondrashov <spbnick@gmail.com>,
	Philip Li <philip.li@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <c69a3103-ae4d-459a-b5f4-d3bbe2af6fb2@sirena.org.uk>
References: <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
 <20240117055457.GL911245@mit.edu>
 <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7aTkAu68BodLGEOk"
Content-Disposition: inline
In-Reply-To: <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
X-Cookie: Nostalgia isn't what it used to be.


--7aTkAu68BodLGEOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 17, 2024 at 08:03:35AM -0500, James Bottomley wrote:

> I also have to say, that for all the complaints there's just not any
> open source pull for test tools (there's no-one who's on a mission to
> make them better).  Demanding that someone else do it is proof of this
> (if you cared enough you'd do it yourself).  That's why all our testing
> infrastructure is just some random set of scripts that mostly does what
> I want, because it's the last thing I need to prove the thing I
> actually care about works.

> Finally testing infrastructure is how OSDL (the precursor to the Linux
> foundation) got started and got its initial funding, so corporations
> have been putting money into it for decades with not much return (and
> pretty much nothing to show for a unified testing infrastructure ...
> ten points to the team who can actually name the test infrastructure
> OSDL produced) and have finally concluded it's not worth it, making it
> a 10x harder sell now.

I think that's a *bit* pessimistic, at least for some areas of the
kernel - there is commercial stuff going on with kernel testing with
varying degrees of community engagement (eg, off the top of my head
Baylibre, Collabora and Linaro all have offerings of various kinds that
I'm aware of), and some of that does turn into investments in reusable
things rather than proprietary stuff.  I know that I look at the
kernelci.org results for my trees, and that I've fixed issues I saw
purely in there.  kselftest is noticably getting much better over time,
and LTP is quite active too.  The stuff I'm aware of is more focused
around the embedded space than the enterprise/server space but it does
exist.  That's not to say that this is all well resourced and there's no
problem (far from it), but it really doesn't feel like a complete dead
loss either.

Some of the issues come from the different questions that people are
trying to answer with testing, or the very different needs of the
tests that people want to run - for example one of the reasons
filesystems aren't particularly well covered for the embedded cases is
that if your local storage is SD or worse eMMC then heavy I/O suddenly
looks a lot more demanding and media durability a real consideration.

--7aTkAu68BodLGEOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWoGj8ACgkQJNaLcl1U
h9BXrwf/ax2MGFfufapvl5UITLAL098Oq/M/cEtg80e2uwB7x6eMnWfzLW5If0FL
7TaDVEb9oUXdsBZAVdETKiszFMAVH6+owpWtLGMkd1CWHbsH4OqpzuITEVsfidM0
YogO4PuLXHCJdoPOogl32UraTyhxJKgYRqy3tr8Mv0UNnA+KpvSgfS/dX7AJOw0h
KLFxAYjNa3JG6SbHJgS2Fw40YWY1kw1fdt193Div+CCIWgkd0SVwg+jIA7xsakb5
YDVyHHT3WY5OpUc+5Ay/WeoDxFlFFmS91U457Dokm+/VS5WjYYJWc1eLKGkx6w+X
otunFRoyx0Y6IoJhrDegDIRv82SVvA==
=x1fy
-----END PGP SIGNATURE-----

--7aTkAu68BodLGEOk--

