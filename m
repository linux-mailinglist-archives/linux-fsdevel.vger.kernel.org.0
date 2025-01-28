Return-Path: <linux-fsdevel+bounces-40225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9DA20A6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205161883C38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F81A841B;
	Tue, 28 Jan 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aexm+d10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D21A83FB;
	Tue, 28 Jan 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738066452; cv=none; b=O91Jz66G2wKcqhXOlaqHFz90egEN4ES05fg8zG+1/pdxI9mec4SDXVHM4/W0C3yj9PIgHZnBzaKRxtkOLYua5QAqZNPMr9rtXx8vAVQGo9LxunFa6/y00CfBAiC1t5CMYeQE2t1C+J8HnKo4vevE8AkhyXn7zjY9yQWix0vbw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738066452; c=relaxed/simple;
	bh=VPmQMeTKshQi8BLPiBnU+quZcCNk2gBWVueKbAAt7hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8zm7HiUpAXDK8bJ6DVWqjWtx2yB2q4m5aO/nFceE6LIzSht1KDqFiAYn1B23JKiXgp/2wuwPW/0/RrALScTZbw7QOD6MAioqt6UVWSnqlZX493IMcQNPB9p7WAxuv5lmNns2acoL2UeGym9LYSRB5rAoSt/52lYDcYjuESs2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aexm+d10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE60C4CED3;
	Tue, 28 Jan 2025 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738066451;
	bh=VPmQMeTKshQi8BLPiBnU+quZcCNk2gBWVueKbAAt7hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aexm+d10gkwLafsjApxGoJimfTgljfCLIWi4xLssNjuUuWMcp+PBzVxu8tHd2EKyx
	 rGqKog1ElS3/OEQDRcD82z/oZezg9Kj6iwBRxVr1t0ual+2v+Dsz+U0w+PGaEZqoJU
	 D/wuOF955EfwSZU5N6M2UxeWFV2adrYgc5ULhfXsLJEsUQv78GuJH3GayfG9YBQy0W
	 JpUZ3da5vaPYEeUbgCxswlXP7AM/ISxcp3Wq8MhtIjogU3ayc+CRIPe+07W3m5cur+
	 zJ75NRTfRh38WdcLevujaJWPQQVkYgn5FrqZKeh0Zbs1iaJ4bSM67/i5IswRyfjmv8
	 GWaTtd2gVwZOg==
Date: Tue, 28 Jan 2025 12:14:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kernelci@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkft@linaro.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <3770d3ed-e261-4093-9a41-90f0dfdd393b@sirena.org.uk>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
 <804bea31-973e-40b6-974a-0d7c6e16ac29@sirena.org.uk>
 <Z5gJcnAPTXMoKwEr@lappy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aZFSBvZRh7wr7T/o"
Content-Disposition: inline
In-Reply-To: <Z5gJcnAPTXMoKwEr@lappy>
X-Cookie: I never did it that way before.


--aZFSBvZRh7wr7T/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 05:32:18PM -0500, Sasha Levin wrote:
> [ Adding in the LKFT folks ]

Oops, sorry - didn't realise they weren't already on the report since it
was on LKFT or I'd have done the same.

> On Mon, Jan 27, 2025 at 08:38:50PM +0000, Mark Brown wrote:

> > have the ability to save the vmlinux.  Poking around the LKFT output it
> > does look like they're doing that for the LKFT builds:

> My understanding was that becuase CONFIG_DEBUG_INFO_NONE=3Dy is set, we
> actually don't have enough info to resolve line numbers.

The arm64 and arm defconfigs which are the main ones I'd end up looking
at both set CONFIG_DEBUG_INFO (_REDUCED in the case of arm64), the trace
you posted was from arm64 so unless it was some config that overrode
things there ought to be info.  x86_64 which I guess you might use more
indeed doesn't have it.

> I've tried running decode_stacktrace.sh on the vmlinux image linked
> above, and indeed we can't get line numbers.

That was a random build I pulled out which turns out to be a tinyconfig
rather than the specific build that was used - if we look at an arm64
defconfig (your trace looked to be from arm64):

    https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-85=
84-gd4639f3659ae/testrun/27028517/suite/build/test/clang-nightly-defconfig-=
40bc7ee5/details/
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2sDW1oYDQrsEOOs4=
L6yoysbu9aS/

I'm able to decode (just feeding a random log message in, no idea what
specific build generated the log message so the line number is almost
certainly wrong):

   $ echo [   62.184178]  d_same_name+0x4c/0xd0 | ./scripts/decode_stacktra=
ce.sh /tmp/vmlinux
   [   62.184178] d_same_name (fs/dcache.c:2127) =20

--aZFSBvZRh7wr7T/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeYyg4ACgkQJNaLcl1U
h9ABLwgAhnkclVNICA/aHT+23arfK9S3L44hGHHrDVOokd5JPC5CibjVlNYz2UM+
U+ZLTV1r6XJlKPI0tgmNhjyrmBSNqwz3BcjPlldwGBJRiDkD04sFjfaVYh+5Rlun
iAQ0QYQvft1v0gquWilwLZ1TrGlI6x81hk2c7Q/b84HIG9zpz7JA+/7Xe4gr99Wi
v2/eFlc2Y/NpacFMJnLPTt+KtugL3TllfyHU/Oh5USO4j7oZyYU9i9PGG89O/9oh
hKkFzlD8/aYhngT8QYGN75uAFZm1fgmkdCv8cLpmJft3OM9zkw8CyJf2zO5J+T9w
KmhavpIYql2a088i5rZnrtnYwnqgaA==
=2o/n
-----END PGP SIGNATURE-----

--aZFSBvZRh7wr7T/o--

