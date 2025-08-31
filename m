Return-Path: <linux-fsdevel+bounces-59717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4733B3D195
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 11:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3771C189C3EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F392459D1;
	Sun, 31 Aug 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw6OTer3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEC2135C5;
	Sun, 31 Aug 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631799; cv=none; b=nF6vh83FMjkzRcmMTQqypCpTyjkfY8YK7Y0fF9WCOuOSXhxZbld2ChPw/l9+St42N4ljITzNbke3/mLgciVbP5nYhzHfghlN4Ns6ffHWi38HmCiANpNmYEPWQYdsBKYmyhYNfAl7xP6HxsBF88nWWi+ZJ/MtTwLZfFV6swEqRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631799; c=relaxed/simple;
	bh=Dx82mDPhaUcQZF7y0c/CzVWGI7mXyPB2/TV2VBWMHfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irDUKb+rEKe1Bj7jxspWXFAvvsLDGIefDdO5DkesVD6WIefS545DstPac9xeEWWI4qVwtHlapFrZvyL+E/Zju9iNAKbPpTKkc21FogCVS7OlhQgpmf0SrrUGN493nFPvggXahPU0mH/u64g+oxjZO66YlaJc/G2bbGmDvFIJ0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw6OTer3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56125C4CEF5;
	Sun, 31 Aug 2025 09:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756631799;
	bh=Dx82mDPhaUcQZF7y0c/CzVWGI7mXyPB2/TV2VBWMHfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hw6OTer31P/UwYhrWUvhWRYPzf2GVlopOB+OZdfWBcaJPdMFcdPxJjAPX0joHDCjb
	 zHo5Ug07x2BcHZlmjmfcrwsjigUDspiK2aOmHiRZzBpUJ7PKEk09Jq3ffp6NHJEnvq
	 A7rZC20w98S2qUp2WBcqK4bv72eUdTyL3v93e9eFZtpM2xnNPehH4rVOHKpAbs/Xo1
	 URs/Fbhi07mJdecymNsQmzUKNXs4eufzIL8JmE2/yr/YsaM65WBHLPUK4OGL8r6OWK
	 wjhWPmpQSswPeZFr8aV04Ui9+AhokiCQ7GjcsY4jnkcFz8mE5LnmqEcxrlfQXwtkvI
	 1rn2wuTF8mo7A==
Date: Sun, 31 Aug 2025 11:16:33 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH v3 2/2] man2/mount.2: tfix (mountpoint => mount point)
Message-ID: <chyei6blufd4wtincejkakxp4pgp2ih5wox35lhema5pclbhlx@d6xplj52sgjk>
References: <20250826083227.2611457-1-safinaskar@zohomail.com>
 <20250826083227.2611457-3-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nskum25elqcfijzb"
Content-Disposition: inline
In-Reply-To: <20250826083227.2611457-3-safinaskar@zohomail.com>


--nskum25elqcfijzb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH v3 2/2] man2/mount.2: tfix (mountpoint => mount point)
References: <20250826083227.2611457-1-safinaskar@zohomail.com>
 <20250826083227.2611457-3-safinaskar@zohomail.com>
MIME-Version: 1.0
In-Reply-To: <20250826083227.2611457-3-safinaskar@zohomail.com>

On Tue, Aug 26, 2025 at 08:32:27AM +0000, Askar Safin wrote:
> Here we fix the only remaining mention of "mountpoint"
> in all man pages
>=20
> Signed-off-by: Askar Safin <safinaskar@zohomail.com>

Patch applied.  Thanks!


Cheers,
Alex

> ---
>  man/man2/mount.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/man/man2/mount.2 b/man/man2/mount.2
> index 599c2d6fa..9b11fff51 100644
> --- a/man/man2/mount.2
> +++ b/man/man2/mount.2
> @@ -311,7 +311,7 @@ Since Linux 2.6.16,
>  can be set or cleared on a per-mount-point basis as well as on
>  the underlying filesystem superblock.
>  The mounted filesystem will be writable only if neither the filesystem
> -nor the mountpoint are flagged as read-only.
> +nor the mount point are flagged as read-only.
>  .\"
>  .SS Remounting an existing mount
>  An existing mount may be remounted by specifying
> --=20
> 2.47.2
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--nskum25elqcfijzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmi0EvAACgkQ64mZXMKQ
wqlfpxAAune+Ui2pfUFY3PtCmQ5MCrddbponD8hNyhBPAZge1QasV0XoDx7Jo928
t7aT76McFdweoDUlktKS18aJsj97fLjbt6ByVhqMK+ogc0RXFN45+ZupTfj3tGbq
kyvULGdr/eSrRPejBIy+3SQnyOVDDktzbtOaTbf7G/cOMnhZO9+hhsrx2NrfeXq8
zco9Gb9FQ82L7/MuQEGnMZKnPeYXQhzkI8Hqni2TI4QTaZX0HUaeGjIGrGc3NOP6
nR6QatK6n4aqX1175CUnpAJhJCF9HQ/6VrZivV+b9NNHMzYClBn7D+eAzOh6hoA+
+T5wAQVFdmPNCk/UMhjiHYxelO0Q+rRpYr+J/qj8jNI5rB5cubr6wcqzrwKB4dSW
sTnYk6w63vo1+mu+pPzsyHkXv+Akp7/8V+/j3tCkc5ieeO9FIJC+WrTJ/K0A9Dfv
UB2nOCBGFm0GpUC0AMfZE5CM+bwzf/z/votCkggb2L1BiJ5cWVzGo61gbzZBOstK
8tM0lYZ9JqqNh1N23KdrvYEYRCaEbL5tI8X22PSORHT5x9J/zXXoG+D1AORUqAbs
ojgd2HkMppUxsKv5tcwlEYHKNMVsEELhGsPI/LBBEefPZuSzI5Dt/Y5P6QmdhVWE
lkgoMiMSi25Rx2iKcH7etol54Pj6HxbRafJubUVYmQ1NTcMHBK4=
=ngqk
-----END PGP SIGNATURE-----

--nskum25elqcfijzb--

