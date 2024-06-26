Return-Path: <linux-fsdevel+bounces-22532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8365B91881D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 19:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898EDB217BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB118FC69;
	Wed, 26 Jun 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2rmnaUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526213AA4C;
	Wed, 26 Jun 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421350; cv=none; b=DV2h2pkKXNKT7rRHHY20TesLwyacsnhyFur2j1yibv0DvqSEFzZ610HSIVJsxNGKWNDh2UvCp0JdJCfqH+PdKXOrtv1dseSITMxbDraIMBWY1ZHopf/7AKT4HrTeez6Amc1ViujylbTvwJgn+CXBk1FYUuccrtJFJcTrqcKaBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421350; c=relaxed/simple;
	bh=AlbTRzpYkYNZX0jniCSeWu+/qk14Ofv7q3SZYGsVm/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmjIUWKoP/r7vHY76oKaBAMIAtFDMw0luKvnWcgEqkhWd5HS91dYxyF5oS976APxn5h1JPKkWU/mY+oVf9KFrjoDNPfej3qfArvwmcMfnBi7r36Uy6vz6RziOZZjRLGPS/NJI97f9/cqlcAAEHZxeV1hU2nh4cUGFZYpXhNTsWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2rmnaUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F94FC116B1;
	Wed, 26 Jun 2024 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719421349;
	bh=AlbTRzpYkYNZX0jniCSeWu+/qk14Ofv7q3SZYGsVm/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2rmnaUXmSGG5zBrWmF334//NDXgecStREjQdC+rXLLOBhdQOFGzsSQ4bVnPWsg6i
	 FbeVUJzDFJ4pbXBdDYpHZgVzobNcY3bzk7EvHged8tkRGHaNvSf63IQ1DiT/26vzFP
	 V7eyBFB/X/iwdUlpzDwtht3WscCNLMQ8njzFTuRBMgPuJ9rcQjRBMVCmDikCc3MN2p
	 Si2Z+Q5n/aKm7wAt1XzSzDoSHykmlOCltWHnsYHiZmu7TEhubr1swigMq39/k7UiXX
	 yvRGef/bHz3S6iz8KDDD8m8H/k8y7YG+MBUPE4tPG0ldu3QF5cQQW5mfTsOoqXvEIT
	 7+w3gM0pJGpZQ==
Date: Wed, 26 Jun 2024 19:02:26 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] man-pages: add documentation for
 statmount/listmount
Message-ID: <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>
References: <cover.1719417184.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vfcxupcgjbbzmfvz"
Content-Disposition: inline
In-Reply-To: <cover.1719417184.git.josef@toxicpanda.com>


--vfcxupcgjbbzmfvz
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
MIME-Version: 1.0
In-Reply-To: <cover.1719417184.git.josef@toxicpanda.com>

Hi Josef,

On Wed, Jun 26, 2024 at 11:56:06AM GMT, Josef Bacik wrote:
> V1: https://lore.kernel.org/linux-fsdevel/cover.1719341580.git.josef@toxi=
cpanda.com/
>=20
> v1->v2:
> - Dropped the statx patch as Alejandro already took it (thanks!)
> - Reworked everything to use semantic newlines
> - Addressed all of the comments on the statmount.2 man page
>=20
> I'm still unable to run anything other than make check, and if I do `make=
 -t
> lint-c-checkpatch` and then run make check lint build it fails almost
> immediately on other unrelated things, so I think I'm too dumb to know ho=
w to
> check these patches before I send them.  However I did my best to follow =
all of
> the suggestions.  Thanks,

I'm interested in learning what problems contributors face, so please
let me know those issues, if you don't mind.

You can

	$ make lint build check -j8 -k
	$ make lint build check

to see the full list of failures.

Have a lovely day!
Alex

>=20
> Josef
>=20
> Josef Bacik (2):
>   statmount.2: New page describing the statmount syscall
>   listmount.2: New page describing the listmount syscall
>=20
>  man/man2/listmount.2 | 114 +++++++++++++++++
>  man/man2/statmount.2 | 289 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 403 insertions(+)
>  create mode 100644 man/man2/listmount.2
>  create mode 100644 man/man2/statmount.2
>=20
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--vfcxupcgjbbzmfvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ8SaIACgkQnowa+77/
2zKgdg/+Mbbds5DVU9ozvsZgoPnQZpL7SjKl6KZ2Qss4Drw/SV2iS/3yVmlUTVmi
9E+tnfIGq7R22vCE1blQAPjL6OAdT6MlxWzkDcam8qe/izBWb8O9C0q/8tgVNyld
bORldy61S3g1bqsTGvMOuAssC/DWPY/X0VYuEH9jEwfD9VIjDu27j1lKBA+b2w5y
680xUK/g+wgQWbBa6nBwthckWS4vj6VgsB4fisUODC5K1MJ1VBeKEgb+qsTGwcvm
MfgaHqx/s/6N8HT3avRRPB2jDjRT/NfrKo4NddsI1ygXHUlm3E/KLbG7F0kzDWD5
1mSua3YUkii8JQrX63eMwrSNIKbChFaOU3svuLSkj6i+V5OChJ1L8s91TizREoGa
xU/6ASRPpmJLM0stXBtZsmsdKf1TeNVtCdmXb9eU0Je3hGNg9G2i8mLB2JSFedwR
0OvkLfDrWMyGi1IT/THPCn5pwBJkOBY6N7QaMk5/FVnPFtLTudWfFO2pigVm+aZW
raqyxxhZRPlyRU5qSMYBn9uxhWQWM0SGtqsPSK7P9ikCh+Ffp0NreWPJL/oXk/5U
R5heRSvBVxwTOhhrWsFUFITtaiOrE3sogQ4xGLzdffjiZfMy5c/eqUsATGHCjv6W
CRWzBPiHl2JSNBEEl06pl/apiF71pkgc6JcOTW7hH9YWxA/CZrw=
=kxZX
-----END PGP SIGNATURE-----

--vfcxupcgjbbzmfvz--

