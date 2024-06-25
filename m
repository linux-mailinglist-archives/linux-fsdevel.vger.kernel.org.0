Return-Path: <linux-fsdevel+bounces-22439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680B7917116
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 21:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1DECB23170
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AEC17C7DE;
	Tue, 25 Jun 2024 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQClqeHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172117C7CB;
	Tue, 25 Jun 2024 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719343625; cv=none; b=hBUCDewHbzC6rpvrhxNOr203hg2LCRJ06ugnO1vNOKs3Nu5kMcqCy7fzXiWrXV8PFz9MmEngVXPBImIu4pywuncy/gnBHDoomKUKR7IlHiaG9LSHFCMQ1Qh6FXsxdSCl5MSzLXT30d1Dms8HGK6oEJdEFKX0VqHQ2NQvyqLLgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719343625; c=relaxed/simple;
	bh=u+kw7Sd6gKUbAf5rF06B8yjsUOOZnPWqt6sC3m7yxwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spSbnQAbbAhNdX2g2wgmCf+MWgnn8JqecFcdKATP6sonTThPKFE0E/JcShzFgDLj6dYomnl5FFN0ZqgOSidicQ/DQHrkaazgNP23a8T7wO7x6nQQunaQhhF1QEjLvJSoLAqLP2yt0vefZnQMYLyX3h+ZyRnNPwqiOK1wig8JvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQClqeHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A493FC32781;
	Tue, 25 Jun 2024 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719343625;
	bh=u+kw7Sd6gKUbAf5rF06B8yjsUOOZnPWqt6sC3m7yxwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQClqeHGOJG2w+2N9Qv4rcWUfjGXBdQfdlXCJ5TNEL6sNh+9fa6mfPOLtXuPjv1/z
	 aMOnuR+9Kx3pUL6O0CeginYj1SN+i6+G71/Wntc+joXC1v3qQ+qBbdLYjK1DgSUmIk
	 OjyBrIoxeNu4lNuNQg5EdSojW9VPvQLlLkQ5uaWSO3EDlp8ysO7LGvxgbJ/Yn1bZFq
	 DKpH7R9k1ZKmM1tAJqCypiTo24TxG2d8oCrpPoh9ivl0xWMqyjPDwxDnLN+vBSnCew
	 4hdPxKwMg4wVxIxCZDUw/6wbVM5iDEPMuVn61LW2Qcrh3VZAmY/4wpHjNKYa6y+Sjm
	 Ptp2XnohaLzbg==
Date: Tue, 25 Jun 2024 21:27:01 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH 0/3] man-pages: add documentation for statmount/listmount
Message-ID: <amoj5jdyvmhqogbgosu233rthx6d27mtc5jum2qiadnzjb33pf@bttezenparrs>
References: <cover.1719341580.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="txk55qogdtffvsov"
Content-Disposition: inline
In-Reply-To: <cover.1719341580.git.josef@toxicpanda.com>


--txk55qogdtffvsov
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH 0/3] man-pages: add documentation for statmount/listmount
References: <cover.1719341580.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <cover.1719341580.git.josef@toxicpanda.com>

On Tue, Jun 25, 2024 at 02:56:03PM GMT, Josef Bacik wrote:
> Hello,

Hi Josef,

> We don't have docs for statmount(2) or listmount(2) yet, so here is a fir=
st pass
> at this.  I've never had to write man pages, and the `make lint` thing do=
esn't
> work because it's looking for checkpatch, but if I put checkpatch.pl in m=
y path
> it messes up.

You should be able to `make -t lint-c-checkpatch` to skip those.

> I was able to run make check and fix up a variety of format things, so ho=
pefully
> these are usable.

Great.  I'll help if there are any problems.

>=20
> In any case I've added to the statx(2) doc for the new STATX_MNT_ID_UNIQU=
E that
> is needed to utlize any of this.
>=20
> I've added two man pages, one for statmount(2) and listmount(2).  This re=
flects
> the current state of what is in Linus's tree, it doesn't have any of the
> additions Christian and I have done recently, I will fix them up later wh=
en
> those changes are merged.  Thanks,
>=20
> Josef

Thanks!

Have a lovely day!
Alex

>=20
> Josef Bacik (3):
>   statx.2: Document STATX_MNT_ID_UNIQUE
>   statmount.2: New page describing the statmount syscall
>   listmount.2: New page describing the listmount syscall
>=20
>  man/man2/listmount.2 | 107 +++++++++++++++++
>  man/man2/statmount.2 | 274 +++++++++++++++++++++++++++++++++++++++++++
>  man/man2/statx.2     |  12 +-
>  3 files changed, 391 insertions(+), 2 deletions(-)
>  create mode 100644 man/man2/listmount.2
>  create mode 100644 man/man2/statmount.2
>=20
> --=20
> 2.43.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--txk55qogdtffvsov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ7GgUACgkQnowa+77/
2zIhBw//S7eWY3nmlSYSQjm+KmCJsthCdz8Wsf4kfkt70EEpQpBRMSE+W6kU5dM6
m0JRYtNujEFbVbjGFC80qRCbvdupUaiY/JxKjjgx5W+Q9GOBnwqLC4fcJmoHZMfg
uuJ46IrhhvQPKZIg37MCEXGA8dJpKAgk97a0knC2+zBMcnRmetBXIVr8VvlduCLS
vrNZQQhS1L+pmDSOyPz7i3HLzp/c64sUzXROiBiWiC+JR/88QqRXXa9ePHbXcxqG
8Q1qBuLttrtofpEUgmJQm5jnTIzWXKzoLUrD+L6kzaHG6f96vBH6bjL4N5GyqASB
LWzaCZpUURs8llo90LMyzhfIwkJCvdDQYZtXA/UMulROJTgsSe8RhWxkfVt5hKk4
+W0lsw/5jGwDkw0TiIsWPx9KIVzaZyKPKZtc2R3a6gSBpL54bKsBLP+gv9mXrROS
supsqr3rWhEgMF68FHfq+fblD2GxpGaWilX99kwM8b7Bf/wjEhsAfw8HIWNxzgeu
uIiTvjUSTt2sPTMl2ZzpzNEkAMCgNJf1sBVxQPDXxIBwjPsqHUsTzbYaS1mjePS6
q8yRtsIKD64yu5qVJ6H08SuRiNYYYQQ10cwdMR74El3Xvfn5Bs9INIDtelsyDzJk
OmhcnhlxyX6aorFz9n4MDnx3NuT09GrUo9F43wxezv3qCG/DMdQ=
=ReeC
-----END PGP SIGNATURE-----

--txk55qogdtffvsov--

