Return-Path: <linux-fsdevel+bounces-55580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 422DFB0C0B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70D4189E18A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD65F28C5B6;
	Mon, 21 Jul 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVLUBORC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338C3C30;
	Mon, 21 Jul 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091538; cv=none; b=IqITqAq/8c6ZvNpH7nJ00dRXOdOheG8lF+JyPGP06418pc772DwKfDkOPGJU5i2COr8A3Kh2h99wHCn6CQ22tr7QzrDe00EXVCz0k5t7MLLNaOHa2/vxdeyFKwU8MvGBnZnVdLj5Uu13yNE7fTY0vZZKxXuZeixaDFH+HqDUpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091538; c=relaxed/simple;
	bh=KT5dNaobRFhxmKwg3aOEGWuaGGHNaN8k9ozAO0yytG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVH6KnbRklXBP1spaKlz6u5Ew52/lqghgv2ZBV39iEVZK+/+c2ptze3KhYA77ETCKfrnNG6SiTQoqsMOhgjZoNN1U8WmI5fC9J5BR5zZzq0jf4g6Lb6oR8sQoXwbvYl0mZ7q8JiWjW+L9quBCFvxMLQxNPV2c36+2MPBUrnci1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVLUBORC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64E6C4CEED;
	Mon, 21 Jul 2025 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753091537;
	bh=KT5dNaobRFhxmKwg3aOEGWuaGGHNaN8k9ozAO0yytG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVLUBORCXbjFfnEj/eN8bIQyiT+nu4wqrLVIuqs3iHCpCwD9olfVyxJWwXkPnq5Ik
	 Lj8qeMctcw1eHuNKDL7OAw2CKO93vE+0lIAYCNF4si79i8O1eN7cZSzQLnPS386tls
	 6w4WOLEO9V5lcjAlTyI0F2XDkPsVl1pez4HIAC5t0XRfmV8twbjFR1ff3x5l/qYq8r
	 pNbjCzoCUKdqFmCp3yAzfN8v106TB70Sa1DV6uazHGTZbUD0dDeg08dGCjx7MLE6j6
	 b5aWjpQ46UzfSC+vXBT1fLmwPGQq/qPGE5kTQ/k5rIgwG0eAF4qe51oHHCIQzGmMlW
	 6NfExBKRLczIA==
Date: Mon, 21 Jul 2025 11:52:14 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] openat2.2: update HISTORY to include epilogue about
 FreeBSD
Message-ID: <ixqohvedvsiytcoxiizsutzwlwgcy337jqvzyspkeetbss4q23@3kxmvfjwt6hz>
References: <20250721-openat2-history-v1-1-994936dd224a@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c6d5ms25ptvphquo"
Content-Disposition: inline
In-Reply-To: <20250721-openat2-history-v1-1-994936dd224a@cyphar.com>


--c6d5ms25ptvphquo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] openat2.2: update HISTORY to include epilogue about
 FreeBSD
References: <20250721-openat2-history-v1-1-994936dd224a@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250721-openat2-history-v1-1-994936dd224a@cyphar.com>

Hi Aleksa,

On Mon, Jul 21, 2025 at 11:55:36AM +1000, Aleksa Sarai wrote:
> While RESOLVE_BENEATH was based on FreeBSD's O_BENEATH, there was a
> well-known safety issue in O_BENEATH that we explicitly avoided
> replicating -- FreeBSD would only verify whether the lookup escaped the
> dirfd *at the end of the path lookup*.
>=20
> This meant that even with O_BENEATH, an attacker could gain information
> about the structure of the filesystem outside of the dirfd through
> timing attacks or other side-channels.
>=20
> Once Linux had RESOLVE_BENEATH, FreeBSD implemented O_RESOLVE_BENEATH to
> mimic the same behaviour[1] and eventually removed O_BENEATH entirely
> from their system[2]. It seems prudent to provide this epilogue in the
> HISTORY section of the openat2(2) man page (the FreeBSD man page does
> for open(2) not reference this historical connection with Linux at all,
> as far as I can tell).
>=20
> [1]: https://reviews.freebsd.org/D25886
> [2]: https://reviews.freebsd.org/D28907
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks!  CI detected a few minor issues:

	remote: an.tmac:.tmp/man/man2/openat2.2:485: style: .BR expects at least 2=
 arguments, got 1
	remote: an.tmac:.tmp/man/man2/openat2.2:491: style: .BR expects at least 2=
 arguments, got 1
	remote: an.tmac:.tmp/man/man2/openat2.2:493: style: .BR expects at least 2=
 arguments, got 1

I've fixed them with the following amendment:

	diff --git a/man/man2/openat2.2 b/man/man2/openat2.2
	index 53687e676..9d0b58777 100644
	--- a/man/man2/openat2.2
	+++ b/man/man2/openat2.2
	@@ -482,15 +482,15 @@ .SH HISTORY
	 but avoided a well-known correctness bug in FreeBSD's implementation that
	 rendered it effectively insecure.
	 Later, FreeBSD 13 introduced
	-.BR O_RESOLVE_BENEATH
	+.B O_RESOLVE_BENEATH
	 to replace the insecure
	 .BR O_BENEATH .
	 .\" https://reviews.freebsd.org/D25886
	 .\" https://reviews.freebsd.org/D28907
	 FreeBSD's
	-.BR O_RESOLVE_BENEATH
	+.B O_RESOLVE_BENEATH
	 semantics are based on Linux's
	-.BR RESOLVE_BENEATH
	+.B RESOLVE_BENEATH
	 and the two are now functionally equivalent.
	 .SH NOTES
	 .SS Extensibility

I've applied the amended commit (which also includes some tweaks in the
commit message):
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D671e1b8cbeee5e81ff1e10d10586521e0ce82cf9>


Have a lovely day!
Alex

> ---
>  man/man2/openat2.2 | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/man/man2/openat2.2 b/man/man2/openat2.2
> index e7d400920049..53687e676ae5 100644
> --- a/man/man2/openat2.2
> +++ b/man/man2/openat2.2
> @@ -478,7 +478,20 @@ Linux 5.6.
>  The semantics of
>  .B RESOLVE_BENEATH
>  were modeled after FreeBSD's
> +.BR O_BENEATH ,
> +but avoided a well-known correctness bug in FreeBSD's implementation that
> +rendered it effectively insecure.
> +Later, FreeBSD 13 introduced
> +.BR O_RESOLVE_BENEATH
> +to replace the insecure
>  .BR O_BENEATH .
> +.\" https://reviews.freebsd.org/D25886
> +.\" https://reviews.freebsd.org/D28907
> +FreeBSD's
> +.BR O_RESOLVE_BENEATH
> +semantics are based on Linux's
> +.BR RESOLVE_BENEATH
> +and the two are now functionally equivalent.
>  .SH NOTES
>  .SS Extensibility
>  In order to allow for future extensibility,
>=20
> ---
> base-commit: 5d53969e60c484673745ed47d6015a1f09c8641e
> change-id: 20250721-openat2-history-2a8f71c9e3b0
>=20
> Best regards,
> --=20
> Aleksa Sarai <cyphar@cyphar.com>
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--c6d5ms25ptvphquo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmh+Dc0ACgkQ64mZXMKQ
wqmW3BAAsBfmf5MHowxilQ/9MO5s82/uJ8TPoXpBFcgxP84D1LdEt35AWXtvnxau
mhRuNcRg1zk/tjt8ttiFjMMP0Eb3+7IH4kwFIfbLd876jgmb8YXUtlTPmnaY8/xS
E8yvagSiY1DfWRoRIoGYuzjH8oHoTpXVozdoQRuiIYtoN2O4PtH0j8gAP4MAtw/A
cLZ4dOiaJX/M/R94rlcmOBRqw7pQ19JScKGDathr+nAdQaU/V0TG5WcZ7WNbDoXN
dYMy4k/ikHLKOuBzFA+DJTpA8ic9bcPRPaFNBXpcwY/sNAGfPTc2oooDw1bFZMar
bDIram/suRNDfMx+96ehy1HUJucYWz0tDKdmI0TjZuCDcgRV6fhJyY89VbzLpQil
bCZpuBo2jwdMT4cz1Hy5NR1QOjOCwauLoBIaRAfmal71Wggi/Bxfm315czypMDVh
uaxCh1mScKzPTHL/REJMdkbKtXx3jW9JcNF97Wv04m4400bS01oBetJ3rs49upOi
g2ofJsqeQINseef3cHk6jXww2uegjYKu2XQMkxzwx+Srtsu8djIGu+jYuWYPTKs5
ThIVhXeLEfZHaCwfZH19Yv/fiGaRTdThR4A3IHX34YF/X5ykzooDOlhvxg+8qNt+
tYFCil1QfFxRNWybkRK5sPW3igBxykcGndKQ2R6nuauzp/3z6jc=
=Bn4p
-----END PGP SIGNATURE-----

--c6d5ms25ptvphquo--

