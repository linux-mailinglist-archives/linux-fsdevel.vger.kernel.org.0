Return-Path: <linux-fsdevel+bounces-45295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A571BA759E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 13:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68903A93D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 11:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACCA1C07F6;
	Sun, 30 Mar 2025 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ8gQnfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3B4A05;
	Sun, 30 Mar 2025 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743335881; cv=none; b=eQpHSqGRByzN9Q2qim4HTcnRpihKNO2jm4Xk0SYZp6Rhfkc7ngxMs1y+4HWfrJWhTRplllpYQ2LW1NKyf9dlKd3YY+ocHAAEGyGLN9n+y7p4fhc2KvFJ0/Q97ZOgKAvwCIW75GFUtq5s++2SudKQQDu6fe1sJ/49GGtJi18CUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743335881; c=relaxed/simple;
	bh=1FJ+vQV92qoZubCCalX8YibypxVYbfc8SXcjDIok1tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBfTJp/ZPlnQ4pb03pbMPWuWEjqaVZJXOZawCAPVDSgAQqRlinprkHTZAhjCKuo6i23RbmMmsb6Lu0khhvf3MwoaI1GZ3Nv7UvQvo2DtFHx3Jr1jMHdIfhcUHlDUHzyQeRif/Db8dBdFzWzInVcpifAytaSe3C53iAFWAOUFvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ8gQnfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F630C4CEDD;
	Sun, 30 Mar 2025 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743335880;
	bh=1FJ+vQV92qoZubCCalX8YibypxVYbfc8SXcjDIok1tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZ8gQnfc44S5HacDrCshR2rzvEbxt2Y1mSfPYT2BBaLqwsJXWMfB8pNp+Gcgz/jKT
	 F9/8BqcT8FsbTKXuKPb5XdQJPLfPdKG0ZAivQnMuqRJoPv+zFn/dYOUbcSu+tUdNPr
	 8Lg/mSfOgtfvXrwk4ttLOrxKItrQv9c8ivA5SXkgxcQVNgHzanDYoWKJdAycJ7RrYu
	 9HuK4NRo4vLqUWIT0O0NSf9KAMdReT0t2AxjaiyRvwGLYrk4dKqT2733VO2aVkTswy
	 zsnuIpAZgQsoTRLAdle2fzczf+HcFAYvyQJFuSqw5Jr7H4yHOOIr3CQrfSzrY3Va2m
	 hoaxVkI1WMJIA==
Date: Sun, 30 Mar 2025 13:57:55 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@poochiereds.net>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] name_to_handle_at.2: Document the AT_HANDLE_CONNECTABLE
 flag
Message-ID: <hih7dv4ct7bud4mzshjdbfinecmhldq7uqiqebiavqqqgsui5a@deboitvqheo2>
References: <20250330111643.1405265-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tvjsndhfqyr22jj3"
Content-Disposition: inline
In-Reply-To: <20250330111643.1405265-1-amir73il@gmail.com>


--tvjsndhfqyr22jj3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@poochiereds.net>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] name_to_handle_at.2: Document the AT_HANDLE_CONNECTABLE
 flag
References: <20250330111643.1405265-1-amir73il@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250330111643.1405265-1-amir73il@gmail.com>

Hi Amir,

On Sun, Mar 30, 2025 at 01:16:43PM +0200, Amir Goldstein wrote:
> A flag since v6.13 to indicate that the requested file_handle is
> intended to be used for open_by_handle_at(2) to obtain an open file
> with a known path.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Please add explicit CC tags for everyone CCd.

> ---
>  man/man2/open_by_handle_at.2 | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/open_by_handle_at.2 b/man/man2/open_by_handle_at.2
> index 6b9758d42..ce3a2cec8 100644
> --- a/man/man2/open_by_handle_at.2
> +++ b/man/man2/open_by_handle_at.2
> @@ -127,6 +127,7 @@ The
>  .I flags
>  argument is a bit mask constructed by ORing together zero or more of
>  .BR AT_HANDLE_FID ,
> +.BR AT_HANDLE_CONNECTABLE,
>  .BR AT_EMPTY_PATH ,
>  and
>  .BR AT_SYMLINK_FOLLOW ,
> @@ -147,6 +148,29 @@ with the returned
>  .I file_handle
>  may fail.
>  .P
> +When
> +.I flags
> +contain the
> +.BR AT_HANDLE_CONNECTABLE " (since Linux 6.13)"
> +.\" commit a20853ab8296d4a8754482cb5e9adde8ab426a25
> +flag, the caller indicates that the returned
> +.I file_handle
> +is needed to open a file with known path later,
> +so it should be expected that a subsequent call to
> +.BR open_by_handle_at ()
> +with the returned
> +.I file_handle
> +may fail if the file was moved,
> +but otherwise,
> +the path of the opened file is expected to be visible
> +from the
> +.IR /proc/ pid /fd/*

Literal parts of a path name should be in italics, but variable parts
should be in roman.  Thus:

	.IR /proc/ pid /fd/ *

> +magic link.
> +This flag can not be used in combination with the flags
> +.BR AT_HANDLE_FID ,

for only two items, we don't need a comma here.  It's for three or more
items, that Oxford comma applies.

> +and

Maybe it's better to say 'and/or'?  Otherwise, one may wonder if
combining with only one of those but not both may be valid?


Have a lovely day!
Alex

> +.BR AT_EMPTY_PATH .
> +.P
>  Together, the
>  .I pathname
>  and
> @@ -311,7 +335,7 @@ points outside your accessible address space.
>  .TP
>  .B EINVAL
>  .I flags
> -includes an invalid bit value.
> +includes an invalid bit value or an invalid bit combination.
>  .TP
>  .B EINVAL
>  .I handle\->handle_bytes
> @@ -398,6 +422,11 @@ was acquired using the
>  .B AT_HANDLE_FID
>  flag and the filesystem does not support
>  .BR open_by_handle_at ().
> +This error can also occur if the
> +.I handle
> +was acquired using the
> +.B AT_HANDLE_CONNECTABLE
> +flag and the file was moved to a different parent.
>  .SH VERSIONS
>  FreeBSD has a broadly similar pair of system calls in the form of
>  .BR getfh ()
> --=20
> 2.34.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--tvjsndhfqyr22jj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfpMb0ACgkQ64mZXMKQ
wqkNEQ//S2YuaMGhnsufRNYajlGVFAQ7sF9ll4gZH6P4PMXuoleGLXoV3nYg8H2V
ArZYPYR+bgtB5D6xV6NG/8d6DX7V9gom7UpcKEqF/xbOaUNIWFSV3Qmi5O6cTKrF
kL/JQikJAFW7IekjT9HS5JrWSWF8tfTHFqSscUhmNFflXug2Cm3T3VK6ncu0N9JR
CWW9EJaFKSsv9Y0adG1a6uFY7fxvdWIkdxEotBRHsMSRoZvGsq7/WLw2S8l3D0n2
d/PFyAGN6aeTjjWdqDcoeLHqgsVPD3uc94iNa3mk2AQ0HZ6PBwea1Wu55bGcH7/B
5/9YddMxWyKfTKrTvvtmZ/3njXKn76zDucqt4NQTCepK1sjDAYtFxjaoxdHgNJxd
9dbCNeSdHNkaxT+ElqUW1t2tv1Otuj7P+j+GX9+Xag9iGna3f2k6QLNHanaiBMVr
enyWD5B3LEPymEIcw+tZF6lru3mtSwZfqf68jH9vyzi1UWhVaw8iDZGBk46pFVw+
E5xZ5nyiJNQy47O97/cp/rhaX3nvrwR52lJvNKpWc67XUFnqF9pPkgw+fY/kDnK4
eDsKwj7VBsEa4tHSGHUACUBSkQvd290GpKERWEfInyWNRWWrL6+kpjjLD0PA2RFj
jR4ZWw2mmLkP15V+vydJlOTMArcFcsqu78rfcyDtC2zYgQL8NNk=
=l/0/
-----END PGP SIGNATURE-----

--tvjsndhfqyr22jj3--

