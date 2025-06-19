Return-Path: <linux-fsdevel+bounces-52141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0980ADFA04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 02:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5A8189E243
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 00:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE64A06;
	Thu, 19 Jun 2025 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpaBiocc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F707134BD;
	Thu, 19 Jun 2025 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750291647; cv=none; b=aaNxHZh3wNYA56C7TKHtiisq7C0ScKWOfqatB20pO2dyAfzq5IE4FVYnCwuVx7P8kPYS7BGxJBfAXI5304rCamDPYizc5I7NMmFpCPr0zWleyCENrg8w5i7yJWTuHEzAJHCFv5JebIhhQvau3UGL7Osaa0f56EuDuQsOgkTFuKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750291647; c=relaxed/simple;
	bh=dAiU03fjIPFdubyQ+ApCYOlimY1xmbTJy992dXG7JPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK90d/RZ5nakxy8ChnsDRr/Nee3awP0hhEJXxkMX5sOiugt/BlTpMbu9QJKoKqyyrEFEw57794VOaaE8z95jOBjDfA+LGkNlRLRT+4DLfYLP/A6iN5ocFT/xOdobHtYA191S1oeRyFUUgrEgCAgz+grsp0Bh8MI8v/EQz+eITW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpaBiocc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB5DC4CEE7;
	Thu, 19 Jun 2025 00:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750291647;
	bh=dAiU03fjIPFdubyQ+ApCYOlimY1xmbTJy992dXG7JPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpaBioccwyNJNYbkYrNLGj4zErChYmfWVMZJnHq3+3BxOlkmwye2o2rwClvFNLBDJ
	 wnUaq6bScHI2VqmzWG2xmpfvKaj/JYZCGC4SqilwBmfG93hfcy0SthQh24wNK5ggYW
	 hb1n1l7IV6D6eCtv9K12YAC2hyCYbaqJIAHlrY6QvQOApG1zzXClb2eMZIJuuYcbF2
	 e7q6O+rZpMmoGn9M9TWJwiBBAI+v6mN21O34m3v+86a1t+x2FA59/PimNUstyxREni
	 DhOZh3OhlmrQUlxKC9eterk2g/YE3jUoFrvoYSDxTSpa+yhawu8BAa576KWWIUsN+y
	 urBpAimcVxsWg==
Date: Thu, 19 Jun 2025 02:07:17 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-man@vger.kernel.org, Alexey Gladkov <legion@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] chmod.2: document fchmodat(AT_EMPTY_PATH)
Message-ID: <k3rytfb6tjnxbwz5bxmj2q5hob6ao2qotyzees37cm36mmf3qq@b64p6fleloft>
References: <20250619-fchmod-empty-path-v1-1-feff2c63abe4@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pn57fgp3qgeavnri"
Content-Disposition: inline
In-Reply-To: <20250619-fchmod-empty-path-v1-1-feff2c63abe4@cyphar.com>


--pn57fgp3qgeavnri
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-man@vger.kernel.org, Alexey Gladkov <legion@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] chmod.2: document fchmodat(AT_EMPTY_PATH)
References: <20250619-fchmod-empty-path-v1-1-feff2c63abe4@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250619-fchmod-empty-path-v1-1-feff2c63abe4@cyphar.com>

Hi Aleksa,

On Thu, Jun 19, 2025 at 04:34:30AM +1000, Aleksa Sarai wrote:
> The documentation and behaviour is indentical to the equivalent flag for
> fchownat(2).
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
> This was added back in 2023, but I forgot to send the documentation
> patch for this and only noticed when I was trying to use it and realised
> it wasn't in the man page -- mea culpa!

Thanks!  I've applied the patch:
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Da4535bb6ddc0c1a060cedaee86430c39f590804e>

Have a lovely day!
Alex

> ---
>  man/man2/chmod.2 | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/chmod.2 b/man/man2/chmod.2
> index 307589481593..671e256ba525 100644
> --- a/man/man2/chmod.2
> +++ b/man/man2/chmod.2
> @@ -190,7 +190,30 @@ is absolute, then
>  is ignored.
>  .P
>  .I flags
> -can either be 0, or include the following flag:
> +can either be 0, or include the following flags:
> +.TP
> +.BR AT_EMPTY_PATH " (since Linux 6.6)"
> +.\" commit 5daeb41a6fc9d0d81cb2291884b7410e062d8fa1
> +If
> +.I path
> +is an empty string, operate on the file referred to by
> +.I dirfd
> +(which may have been obtained using the
> +.BR open (2)
> +.B O_PATH
> +flag).
> +In this case,
> +.I dirfd
> +can refer to any type of file, not just a directory.
> +If
> +.I dirfd
> +is
> +.BR AT_FDCWD ,
> +the call operates on the current working directory.
> +This flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
>  .TP
>  .B AT_SYMLINK_NOFOLLOW
>  If
>=20
> ---
> base-commit: 471c38fb3c5c53c6df2fad4a7353559b330c1323
> change-id: 20250619-fchmod-empty-path-7680e8bb5481
>=20
> Best regards,
> --=20
> Aleksa Sarai <cyphar@cyphar.com>
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--pn57fgp3qgeavnri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhTVLQACgkQ64mZXMKQ
wqmmWxAAu2F2K8o8jtvmQadksYYWkWbjTcuIim2CIHgUy2XsmKEYH2G2IHnehH/l
GdEEULookHo3RF0P1OEQA3wOhe/g3qpYFJUEv2+cCkaa1yut/v9D0JFTU6JJdKFd
RUxMXGUFfdOd/qEAmqoOi03ukUtK0u5F/+5hPcimDslVXtKa/BRJAoG5W/KSPjzQ
gkdHAmtGLQTulrZI9bpLzPhTEPEfyrt6cXXetxyrkT9Ij/x+JoS7IF0+j89aaOOB
07UiZFLY3v5IgW581ahjxxNMIQ8uWDeZl3DE+SIF9zwYQpna6SiX3c5t/3PkjFey
sxWO9RpfKCvk0QIGcHLN1acv2rBcpmsb/Rex5DLvrx/wlTYkwvCwg4yyE4IPtUMK
kSU2QGoJjPbedivDjm+69yThHqGKdfgxLX5fPw9vqTFeloi8VExSkLiHmgHsT5jm
+/Z1Jtmfh8eJ9dnsNzzClqXgzchq7XVb6W2Q576VsfqfB+8Z6ET+W9T2wXCxfN/W
VvBp2zz7h+LZOPy5yPytxmwoX783G45RAqzR1rRG81Zo7PSVX5Ewy8wFGuEwLnq0
P2w7uXTQe4dbK2GTd0UQbDx+RiM3VNF6PIZt43GkParthOqMg3ARpsVoSZNLyDOl
AW+qlR3nI38VCx6kB2ZhOjiswYlXBEb7VPMQ7UaLyHCJbP8nIHw=
=KCyj
-----END PGP SIGNATURE-----

--pn57fgp3qgeavnri--

