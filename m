Return-Path: <linux-fsdevel+bounces-58796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CAEB31859
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AE31CE5980
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC02FE57D;
	Fri, 22 Aug 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHBwW5pQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341E2FCBFE;
	Fri, 22 Aug 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866993; cv=none; b=sYpyU2fMVn/HHfHnGc8FNx1+NRwgACDar2kmxXRGiAiDjYwl84tHg2yfawQz1vLJ6E5j2OdJv0Odr1D5Yf+Jki3KzIRrwhPQ0CNouyYaZlcuMI22faXFMo3PwHC7bBtbzfuyNiqE0IRqyJp4/jH0j/s6xX9j8SHR/NdOGu4a1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866993; c=relaxed/simple;
	bh=GgoITKPkk885/G9vmfvVHPZiDboFUVRXgRiLfhRuKoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUk4AZJsXqE+PqcvAFnOZzTOLSmnTrGasgCEVE6t+5//gOpN9+fC7xToAXBknRd1/NbkG0No/VqikdxmO5Lbldl6vmMEqZOkIqIbbTcqb9NZtJohE6cq9x/iT+5h7O7CAD87PfcwNNPD55vb7O0L5gXzIWH5GdbWBnE3tfUblL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHBwW5pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE4BC4CEED;
	Fri, 22 Aug 2025 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755866993;
	bh=GgoITKPkk885/G9vmfvVHPZiDboFUVRXgRiLfhRuKoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHBwW5pQBB924uS2EvEaTMVScgoVBGSPTv+vOQDPcBjSqDfUIEij5aS8BqxQbjMlY
	 kjNUu/m5271lML9lw0oX5sfXNPqCTGNWVeBFNHFHEvfMzffdzRuM4Xg4NHYJdz8FDX
	 lIm70hfEXyVOV1Dt5lbf+mEz34DfOyhaEHGY0SotkQ8ELJjFiYj7EJyXb13FPEEWwO
	 U9g9H5iDiqXlmi/2xQ441LdSbrvQMyHtNyWWC4i1iSZGLMqtPIAp15y9ybzeRGssnm
	 WwkqXsuqWvKLS4lPlLmzdV4VYcd2bmM3BelQXhdQb/l9ygWtNhgIISAr93M45ElwX7
	 lVsyqvIWi97wA==
Date: Fri, 22 Aug 2025 14:49:47 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH 1/1] man2/mount.2: expand and clarify docs for MS_REMOUNT
 | MS_BIND
Message-ID: <ir47jua4jwi2ram5jevqxog637nhzyr7vqmkzl22ttisubucmq@skjlfbhez45v>
References: <20250822114315.1571537-1-safinaskar@zohomail.com>
 <20250822114315.1571537-2-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gasaowf4ey5r47ax"
Content-Disposition: inline
In-Reply-To: <20250822114315.1571537-2-safinaskar@zohomail.com>


--gasaowf4ey5r47ax
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH 1/1] man2/mount.2: expand and clarify docs for MS_REMOUNT
 | MS_BIND
References: <20250822114315.1571537-1-safinaskar@zohomail.com>
 <20250822114315.1571537-2-safinaskar@zohomail.com>
MIME-Version: 1.0
In-Reply-To: <20250822114315.1571537-2-safinaskar@zohomail.com>

Hi Askar,

On Fri, Aug 22, 2025 at 11:43:15AM +0000, Askar Safin wrote:
> My edit is based on experiments and reading Linux code
>=20
> Signed-off-by: Askar Safin <safinaskar@zohomail.com>

You could add Cc: tags there for people you CC'd in the patch.
(For next time.)

I'll wait before applying the patch, to allow anyone to review it, in
case they want to comment.


Have a lovely day!
Alex

> ---
>  man/man2/mount.2 | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/man/man2/mount.2 b/man/man2/mount.2
> index 5d83231f9..909b82e88 100644
> --- a/man/man2/mount.2
> +++ b/man/man2/mount.2
> @@ -405,7 +405,19 @@ flag can be used with
>  to modify only the per-mount-point flags.
>  .\" See https://lwn.net/Articles/281157/
>  This is particularly useful for setting or clearing the "read-only"
> -flag on a mount without changing the underlying filesystem.
> +flag on a mount without changing flags of the underlying filesystem.
> +The
> +.I data
> +argument is ignored if
> +.B MS_REMOUNT
> +and
> +.B MS_BIND
> +are specified.
> +The
> +.I mountflags
> +should specify existing per-mount-point flags,
> +except for those parameters
> +that are deliberately changed.
>  Specifying
>  .I mountflags
>  as:
> @@ -416,8 +428,11 @@ MS_REMOUNT | MS_BIND | MS_RDONLY
>  .EE
>  .in
>  .P
> -will make access through this mountpoint read-only, without affecting
> -other mounts.
> +will make access through this mountpoint read-only
> +(and clear all other per-mount-point flags),
> +without affecting
> +other mounts
> +of this filesystem.
>  .\"
>  .SS Creating a bind mount
>  If
> --=20
> 2.47.2
>=20

--=20
<https://www.alejandro-colomar.es/>

--gasaowf4ey5r47ax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmioZ2oACgkQ64mZXMKQ
wqnqvg//aN4s81y1rtPJJkKk72QTf7oVzKnY0ehD8XDJoxz0DX2vz6J/AEJt67UK
iu5+bIrLKgt2kcFhNeTo87Rk+3/5WtyoA2J13jvK8XaGLnNwyCdbydkNLkotv/kt
dIczU5tt8QmG3TAwIkDseGhYioL4REVwQTyDEXLPHEkqL8BY5IsXL+fY0uIkiDPA
O7Kfemrpc1pnkAFdu/2FCoQLpGKmnZp9ly+lQ8pr7MI62n3L62PIaAskimZwGlZs
bDBfd1TB26TYakpu+t27l29HGvomPj5Ihw2mmhjiPNS2cLT7DCMSkFoLieDXmusI
HpU0Ubmr20yR6+hWIuSGwGkhKwKIWjHVwJvk0DnCMxgNro5A2EjIhRSNE4j206Rk
TagmrTOF5Qwlxa3UP3v24ERYJ6uKaW2MU9u8qi0h5UVNsG6P5HGL7i7T5Gidodxa
MF9BqH8+xec5e1GFcM6HOJKVZEy10DAnbdvVrgFzDzGg+y3501mBqB6uQlNbMqNM
XRq8l0TawnioJLjThrwTTjb2oRR3X7OnDHlW/ClF0yILCQ/8VHv1Bgp4JcoJDA6o
QpMkTZZvB1AA7x6X02W43mANn8tswECBVfXGZ+fOzjzD9hQbzACjXPSMV5ewK/o1
RdKfIjccUIEapdTJlBvD3SwU6e8wJk/tSgCvAkvrP0jotrKfCPo=
=hypr
-----END PGP SIGNATURE-----

--gasaowf4ey5r47ax--

