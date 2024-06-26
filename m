Return-Path: <linux-fsdevel+bounces-22553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B65919A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227A8B222DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 22:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373C19309D;
	Wed, 26 Jun 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFX82Iiz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29518FC9D;
	Wed, 26 Jun 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439564; cv=none; b=tm2btOM8KM/rxllALPnV5mhXhdkAsuFmyL5u++cygtYB7vgtCFxpn2/IRYRGQoJrCcm5wzrON8vCajxOlNnq5Td+axQQsl+ruNy17V4tB3QdpExSg/0PA6CaqmtjB8+cybjwTgJXp1VZ2LcO6rzDKubvmb0ExI6kxQSB7IR+IDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439564; c=relaxed/simple;
	bh=5UbnwoIEDZ53OngkORLPADesvx/JHJTVy1/Ct8o7b5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOAvy+LiwNe7jvcn4vfu3daeaUShHwxdoK5unoTrBlDOpnSlbErBCyVV0lJXa3Mwv67thVl2FPUCS83mTRTteul1NbeHpoN++6oYFHOJtaURvYM4K6AtelbtZr8oHyTwNGzcNG8Mv8/8nQaXewcs32fMjbhFm4kFLoopWTd9U4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFX82Iiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852A0C116B1;
	Wed, 26 Jun 2024 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719439563;
	bh=5UbnwoIEDZ53OngkORLPADesvx/JHJTVy1/Ct8o7b5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFX82IizfHF48Bbl2FCssejF2zf8HP1C1MF1hslwUB2fu787sgWGyr1ccNDiVWmiM
	 Ee9jD8+rT9z4fB/Xux3rhAM+mhezdECmfCZM6YdmBA3thdcGQrPRgd0Tr70Er0FgQK
	 oC/jhlkT1oYdbAW5vxbnPAnK/2uj5lCwJn9+ozVYeM9bA1iVpD3nV2pcfBg2r3WYHB
	 OWLj9w1fztG+TlDaIcXoC+9mrTecX+MBeFhiMxZPR6Vmq3f90a0fmtsz17IWeaVV7t
	 OpTYtVNHmJL+FlID7U5WKhcJzM6OaMslS8awvuHvoO6Zz/JLIsTpziO5mf5dG7pNRn
	 DNcghJBimgCww==
Date: Thu, 27 Jun 2024 00:06:00 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] man-pages: add documentation for
 statmount/listmount
Message-ID: <z73y6kviht46at5bni3xavecescfvxw4fbdc2fctg344dfqlju@ogfeiz7vp7qk>
References: <cover.1719417184.git.josef@toxicpanda.com>
 <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>
 <20240626180434.GA3370416@perftesting>
 <gsfbaxnh7blhcldfbnhup4wqb2e6gsccpgy4aoyglohvwkoly5@fcctrxviaspy>
 <20240626214407.GA3602100@perftesting>
 <20240626215034.GA3606318@perftesting>
 <x3u4n5bpmi2vko426wjlf5io5l6je7xaeckawe5htgppu2yt5v@lrf5grwbh3i5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g3lwyb7csi3plwft"
Content-Disposition: inline
In-Reply-To: <x3u4n5bpmi2vko426wjlf5io5l6je7xaeckawe5htgppu2yt5v@lrf5grwbh3i5>


--g3lwyb7csi3plwft
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] man-pages: add documentation for
 statmount/listmount
References: <cover.1719417184.git.josef@toxicpanda.com>
 <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>
 <20240626180434.GA3370416@perftesting>
 <gsfbaxnh7blhcldfbnhup4wqb2e6gsccpgy4aoyglohvwkoly5@fcctrxviaspy>
 <20240626214407.GA3602100@perftesting>
 <20240626215034.GA3606318@perftesting>
 <x3u4n5bpmi2vko426wjlf5io5l6je7xaeckawe5htgppu2yt5v@lrf5grwbh3i5>
MIME-Version: 1.0
In-Reply-To: <x3u4n5bpmi2vko426wjlf5io5l6je7xaeckawe5htgppu2yt5v@lrf5grwbh3i5>

On Thu, Jun 27, 2024 at 12:02:07AM GMT, Alejandro Colomar wrote:
> On Wed, Jun 26, 2024 at 05:50:34PM GMT, Josef Bacik wrote:
> > Err that just shows the one error, this is all of them
> >=20
> > https://paste.centos.org/view/b68c2fb1
>=20
> For skipping the cpplint(1) errors (I don't see cpplint(1) being
> packaged for Fedora according to <pkgs.org>), you can do something
> like with checkpatch:
>=20
> 	$ make -t lint-c-cpplint

Ahh, now I see why those clang-diagnostic-empty-translation-unit errors.
The above trick is creating empty translation units.

So, you'll need to do the following steps:

	$ make clean
	$ make -j8 -k lint build check >/dev/null 2>/dev/null
	$ make -t lint-c-checkpatch lint-c-cpplint
	$ make -k lint build check >out.txt 2>&1

This makes sure that you only touch those files that can't be created
otherwise, and not some other intermediate files.

Cheers
Alex


--=20
<https://www.alejandro-colomar.es/>

--g3lwyb7csi3plwft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ8kMgACgkQnowa+77/
2zLwJQ/9FuFgUVZwWspjzE7NoAh3nlwjAeAEvKAnDhZZDeH1S0ynCxVIDULnXj6x
bplBRLVGoo+CbYcka4K5PYPuJWH57KniUzL1ihAJHmealOBCWH4/chCStHjxS6lh
ySNjeeFI92iaA6nUsV5bWi5VICnIsjhm8NwYIGQGYI6dZH6nlHX0FZHGicTfkeBg
tcSxknMQEh6uMRx5qmRRyxcJ/vcbrXbGmcaZE9926lpG51NgNKlVqaxIjIcQ6Rue
RtAqbPuc9gp+6XnGXMQ2vpXiP11NqnzdNoz0IWN+/lA3o4mcoxwkY0z8JvLZ5r9u
+wsHMqAmb3vQqMzkxSn+5WdfWrkhACKosdbOylRN79iD3+unFTdfSeGVBF/gc+UC
w8JOkUmlH+PdCSftW0/p0GBGHxRZmxC5bRWZtLDxgO1K9Eaj4OsbOiQUgXT9Hq9C
NPsH1AA8XODiRuRXA5UUmY+bx9vfz1f1PnmkIx2pfik0BDF5ifLUIbU34aePRl6b
nGSuG7Kc/vQfKoddMyuqNz5MuwS2vu1vStpA3tNxzO1ZrlqhIcpN6INWKCXmoex1
EMtzTI6vSDR2dSy8ooIycyaeXweWn3loqWNi3jmi9kthT6Wdo5ONhRRhDYD7eMdC
+tsUGOlKt1IugtwSBJs4rHYDlTKiFhpvWXBEa/+1bwNUPx7I3uw=
=pGqx
-----END PGP SIGNATURE-----

--g3lwyb7csi3plwft--

