Return-Path: <linux-fsdevel+bounces-27197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D798B95F689
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A21281D92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0602194ACF;
	Mon, 26 Aug 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY4qV/uU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1657E1;
	Mon, 26 Aug 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689738; cv=none; b=DD4igEA/r5EXd7G1U5stezy7xM6g9VOtzxnAlSLEqlATVe1VCcWXJZiWgDXHu6/BHYJBHRPa4kPTL+EGgNa75MtLpU2VFmLmadiFX74rMx+he85FT518cFjOWxJIUuPlOC70dLXzwJeVIJWcrZSFLQheaoGtByu/MCKDDF0zbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689738; c=relaxed/simple;
	bh=r0t170+dJDDqs5a9t3WYaX2A2dxrujny3h/WpuN9CS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guXW2vFf40IE+CdATKzghh64LcEU6MhDjuJkIccRAiAXJTwrMfMqskMXA+hQiBX35YCQjCW6TXC+shjDg5ZAK7VyFeahnqfuTVZ7pI+Ptpko5R2xQkp8NvzbmdO6VXejb0HYDcE0bdCfVi6P2GKGg0iDpVT+TsGHXdCbZAVsGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY4qV/uU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9840AC52FC1;
	Mon, 26 Aug 2024 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724689737;
	bh=r0t170+dJDDqs5a9t3WYaX2A2dxrujny3h/WpuN9CS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RY4qV/uUbQq0V52Y09N+EV9otB6jCh8Yt5Mrc9GkfcpizPhYQ0fvs91ZLDdcEkiFU
	 TYW295IAU12snTCJ1YzXlKdoeFUyE/UKDmvmzKrM1Hwq5Xr+EOHspWqryjNaYrglqc
	 vJB54C79w0qHS87lKqPmLM0OM22Pwx9dhwUBiUrgt3G4b4TXONLB+ShkUi6GsURD3X
	 +iUsds6o9VmeCDsQZlSGTQFy7j59v0+yGMAGCsNC6PbKnNm3AmcrmaLP+e1AcOJL3X
	 9rrIaCSOEvad86d09L8ALqT76HLaFMXlk56U4bhRdF7u4nrmo4qssSbWejjdtXyA6x
	 N2jsp30frcK7w==
Date: Mon, 26 Aug 2024 18:28:54 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: linux-man@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document AT_EMPTY_PATH allows using NULL
 instead of "" for pathname
Message-ID: <oy6ccnyva4jt2355ut32me7otbjxdro2rtentxnyr3mhnxvj36@giagon74ilcl>
References: <20240826145718.60675-2-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wz4ypvb6jm4y7icx"
Content-Disposition: inline
In-Reply-To: <20240826145718.60675-2-xry111@xry111.site>


--wz4ypvb6jm4y7icx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: linux-man@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document AT_EMPTY_PATH allows using NULL
 instead of "" for pathname
References: <20240826145718.60675-2-xry111@xry111.site>
MIME-Version: 1.0
In-Reply-To: <20240826145718.60675-2-xry111@xry111.site>

Hi Xi!

On Mon, Aug 26, 2024 at 10:57:19PM GMT, Xi Ruoyao wrote:
> Link: https://git.kernel.org/torvalds/c/0ef625bba6fb
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---

Thanks for the patch.  Please see some small comments below.

>  man/man2/statx.2 | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index f7a06467d..741de10be 100644
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
> +is an empty string (or NULL since Linux 6.11), operate on the file refer=
red
> +to by

Please use semantic newlines.  In this specific case, please break the
line after the ','.  See man-pages(7):

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
   Use semantic newlines
     In the source of a manual page, new sentences should be started on
     new lines, long sentences should be split  into  lines  at  clause
     breaks  (commas,  semicolons, colons, and so on), and long clauses
     should be split at phrase boundaries.  This convention,  sometimes
     known as "semantic newlines", makes it easier to see the effect of
     patches, which often operate at the level of individual sentences,
     clauses, or phrases.


>  .I dirfd
>  (which may have been obtained using the
>  .BR open (2)
> @@ -604,7 +606,11 @@ nor a valid file descriptor.
>  or
>  .I statxbuf
>  is NULL or points to a location outside the process's
> -accessible address space.
> +accessible address space (except since Linux 6.11 if

You could reorder the above to be

"""
=2EI statxbuf
points to a location outside the process's accessible address space
or is NULL
(except ...
"""

which makes the added parenthetical to be next to the mention of NULL.

Have a lovely day!
Alex

> +.B AT_EMPTY_PATH
> +is specified in
> +.IR flags ,
> +pathname is allowed to be NULL)
>  .TP
>  .B EINVAL
>  Invalid flag specified in
> --=20
> 2.46.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--wz4ypvb6jm4y7icx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbMrUAACgkQnowa+77/
2zKGjw//T3J4KMj2Q1vXvOnbgbajvMIKBSYwGza20iNMW4S6cDHybt5oAI8lav8+
ykDQSWGeadPJ72VoYbsg3A639OMzFU+MIejvPvIS3It9W22ohQizxUHU+zozqKGd
TRakwrO6rhJ2AjHCEFh1x0onG3aAQMRaRXjn2z6CHYpAtoqpCwsLhMWI258g48Oq
AwzvlZibp2dPKDRHCR4IO7XmloBHIwXkby0KenTS+Gpjzsf5ZnOB7bhjk+YwA4V2
Xzh5Q4m1K1/JeHYyr0OwpvqK2He8s69+1SEEv0Tu5lHOR4nU12+lmrBfEPk+1lwF
e76vMBCOF2Wn16kAjl4kBeJs5q1DD1/NXz0LuRM4wuLbROBu8JsPF31jA7ZjB7xU
dkx/symQRn2lnYhr7ohaBopdlBjSt/fq28RO0zbB6oHbmlUFJGlC35+SCoSLNFtL
anep4NckS61oJ6YTNy6oPQw2cWY5UIvnOPSyJQtOqT7mI4XE7jVUxUy3vLMHSJVK
yeYhwQMBh3GkaEh1ojGMhROGWXKRL0/BlXBtdGD96md44EzqU7kgq+8F4PNsBtX5
uzfmXOgpbP2IE0xFgfjXCiIcw3Brs8TrNiqut9gvNTKW0EduBUWkqiCZC0Cp1Imk
q+0i9q6q3Gn31DNHpLuIGm5Js+JPwEiXqy43ozBxWMCKFTgvoic=
=Dtse
-----END PGP SIGNATURE-----

--wz4ypvb6jm4y7icx--

