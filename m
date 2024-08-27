Return-Path: <linux-fsdevel+bounces-27347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4EC9607AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE03B2207E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823C19E7D3;
	Tue, 27 Aug 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq/GnXXj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EC149E0E;
	Tue, 27 Aug 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755323; cv=none; b=N1AntJETbR7dqMOA67jk63jQ5CXqaqq+mai07JbhQSDV7ICzfXZFKPdu+mS+qaEQa5kD0Bq6cVnrXVP3IKjLdFI+YfUTZzEIKNi2Z5SQ8lWKwNPHyU3upY6StRtHcIiku4WVESnjJiyxxEOF2q/KQkqDzk57k18WxqRdQEWl2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755323; c=relaxed/simple;
	bh=Slx8Gl4Zy5csur8o0S+/XOupLYzpJUDF5hx+/586Nd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzVE6CD30XB+HIreL82J4PQmpQOo2ObeAj4BB6w08QkFTKE9OKjHIzZsaci4Ri99Pi+Qn9h/6Kuoh2WMJTs3az91Lcjkm4zoOp2esm14I4Uf8vOqUYuIy7AWP/8m9nUS+aFSTrOMdUy4HLpzFph4f/1CaiBkDSd0e4h0DraW68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq/GnXXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B90C4DE11;
	Tue, 27 Aug 2024 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724755323;
	bh=Slx8Gl4Zy5csur8o0S+/XOupLYzpJUDF5hx+/586Nd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tq/GnXXj1IpP/SwEFhmjzoYBPsil2wdS8Idyop0K+igb2kTa6qCDx80O40hC2Ld7l
	 ioswqSQs5Smw8Q1QmN2Jiy+5wOZJCt/15ujkF7qOFvgJgfIep9cWoLZHJRVkoGt+Nk
	 v7T3s+Ozk7yPdDl9ENqnoF3GhLUcSIM8x+24fxpFV1zSaqTlnmW602cl6n1zXDii41
	 etFrT3ZPmEcW/RPaaFvIJEA7nOuEd8jL2IYsm1uSrVxv1ZNbcBQDAAmuTZeew/i3Zj
	 v3PcSLr7R9xT+ZGiZx83Cqz7ODkp3WAKQkEtqBdpV2/2GN0pYF6kuW/SKNkdMDPjbu
	 rx5E9L54EPaaQ==
Date: Tue, 27 Aug 2024 12:42:00 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: linux-man@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] statx.2: Document AT_EMPTY_PATH allows using NULL
 instead of "" for pathname
Message-ID: <mwap6wdru2twpvzfnyt3a5tgrfv7lgrsybqapcvdz5efq3orhd@txdmm3wxnsei>
References: <20240827102518.43332-2-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k7mkv24nfwxmceit"
Content-Disposition: inline
In-Reply-To: <20240827102518.43332-2-xry111@xry111.site>


--k7mkv24nfwxmceit
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: linux-man@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] statx.2: Document AT_EMPTY_PATH allows using NULL
 instead of "" for pathname
References: <20240827102518.43332-2-xry111@xry111.site>
MIME-Version: 1.0
In-Reply-To: <20240827102518.43332-2-xry111@xry111.site>

Hi Xi,

On Tue, Aug 27, 2024 at 06:25:19PM GMT, Xi Ruoyao wrote:
> Link: https://git.kernel.org/torvalds/c/0ef625bba6fb
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>=20
> Changes from v1:
>=20
> - Use semantic newlines in AT_EMPTY_PATH description.
> - Reorder EFAULT conditions so the added parenthetical describing NULL
>   with AT_EMPTY_PATH is next to "NULL".

Thanks!  Patch applied.

Have a lovely day!
Alex

>=20
>  man/man2/statx.2 | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index f7a06467d..38754d40c 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -20,8 +20,9 @@ Standard C library
>  .BR "#include <fcntl.h>           " "/* Definition of " AT_* " constants=
 */"
>  .B #include <sys/stat.h>
>  .P
> -.BI "int statx(int " dirfd ", const char *restrict " pathname ", int " f=
lags ,
> -.BI "          unsigned int " mask ", struct statx *restrict " statxbuf =
);
> +.BI "int statx(int " dirfd ", const char *_Nullable restrict " pathname ,
> +.BI "          int " flags ", unsigned int " mask ",
> +.BI "          struct statx *restrict " statxbuf );
>  .fi
>  .SH DESCRIPTION
>  This function returns information about a file, storing it in the buffer
> @@ -146,7 +147,7 @@ for an explanation of why this is useful.)
>  By file descriptor
>  If
>  .I pathname
> -is an empty string and the
> +is an empty string (or NULL since Linux 6.11) and the
>  .B AT_EMPTY_PATH
>  flag is specified in
>  .I flags
> @@ -164,7 +165,8 @@ is constructed by ORing together zero or more of the =
following constants:
>  .\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
>  If
>  .I pathname
> -is an empty string, operate on the file referred to by
> +is an empty string (or NULL since Linux 6.11),
> +operate on the file referred to by
>  .I dirfd
>  (which may have been obtained using the
>  .BR open (2)
> @@ -603,8 +605,12 @@ nor a valid file descriptor.
>  .I pathname
>  or
>  .I statxbuf
> -is NULL or points to a location outside the process's
> -accessible address space.
> +points to a location outside the process's accessible address space or i=
s NULL
> +(except since Linux 6.11 if
> +.B AT_EMPTY_PATH
> +is specified in
> +.IR flags ,
> +pathname is allowed to be NULL).
>  .TP
>  .B EINVAL
>  Invalid flag specified in
> --=20
> 2.46.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--k7mkv24nfwxmceit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbNrXgACgkQnowa+77/
2zIYEw//Qz5JH24LGdMqF8dXi+MU5o35LWUKcIDgFjvB16Cyfcb0znjEjFzYLIVM
IsFYSkbgxFzuLE4kyYn6SNOBFeBN7rwk0omo4zktabJ8mRpwOexs7+oWUf3zLFb/
llee8asYvM6ynmARJ8H98xeGdUPRpMCPZedz50LSY0pzZqkAGpnA0wiRYxnAz2ei
mE54iC/Vb4tBCTmjZAugxUSFIITD2dTHMUaR1vQj9T1u7K8nNYzz+qlfg68mI44z
yjgptqtBoz3g0AeG+eaNLIXMnBrD3Z2g1Q9IRExCxwb6BZ/lILPuDQ1l+5uzLib0
Sy6LmJztnhk7KxcJjjC/8IRgb03Ixq8VCYfxBg2GSUnnVreCTctDnBeur0hlqDb+
qQ4WWDs/f6o78Hd0Wi7bjkqbk+5dniLUZlLddUsfyDvUiJy/8xgJENyEtuJ8ey5+
TaqrPdczuAAG7D+3+B/i9iyT2l1KFHg7x5MgQ89eDanLeWfeY6t/BRXMApdKfwVv
T2I+UPqDd22v9gDimyoiECnfcKGBjJ8WD0L+SjQZlXXWkEorSIr6x0Psb/yz6pQt
JlGsyFV+R/fB4RmeU8/HVrM7FvcelnABCxgU/77ICKtWCFUQ8818CD2jU5Lm6uqg
Egr7+uwpuWYpR4KzgLg/sIU3emQI6HL5RDpRX3HkOJsThQtkmk8=
=QrD5
-----END PGP SIGNATURE-----

--k7mkv24nfwxmceit--

