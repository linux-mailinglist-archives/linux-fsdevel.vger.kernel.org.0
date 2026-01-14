Return-Path: <linux-fsdevel+bounces-73809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92450D21163
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 20:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54162306704F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D752D6E60;
	Wed, 14 Jan 2026 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ukxqd4jh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446F221FCA;
	Wed, 14 Jan 2026 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420094; cv=none; b=g8GYr4Cyly3HnJ9SbEGDuqI9XdIESTdERXA4jmLSeV9mM25IodNW595e3f5h5EoXPiLcaeUR6ATT0qQeVFpFpl2MkP61rQWvEhu301w5DnVo5DYSqiTiZWofRXosLf//zd+ExqP1XoX5lGGwI47be5iz7R9pqWm2zNskEWN5slc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420094; c=relaxed/simple;
	bh=t3kaTGswuv2DieMWbRYQC9KQrLUW6nbwL1Ux4F2IKw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYFE7rw+r6rUA4bXr9bNCVwt+OhrCW6PZIoIy/TFjiBQe/cbdI+dXdGV6buc0AMAewnAlDK2cejYs/mMm0+19oXP4rC173ncQuWfAtueGz5JhMsPxQJPri26NdKV2CAI67feo51oYBHzw3xF+F/qSjA+J/QHqiIg+fnQVddsNpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ukxqd4jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F81C4CEF7;
	Wed, 14 Jan 2026 19:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768420093;
	bh=t3kaTGswuv2DieMWbRYQC9KQrLUW6nbwL1Ux4F2IKw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ukxqd4jhp8GtiRwpsFxB/v659w6O+ZMCw17SMcrjjhbMTzy3Y74+IJe4M2Ec4UCaY
	 5fJwybzZz5Tjm28xg+BCkAE3go1AYjjSC9fIQa3wMcSilVnpf0r+DP+ZY/9VONM+YV
	 FCusdZV6XtElfYhBwqR2r4KqlFHBK1ZQj2z/v1r5SyU5TjV7dTdpibNvdbAh7XXDUm
	 XO9MYDRJnwIwbgK/NaU9v3OaEAeNPcz7mfsffRAw+gYn9sFG7tbhCgrROnZ8XJaBCz
	 iYi+gLCi9pu4zSmQMpuEGDgvqrR7yB6w0O/zUjPVYuihjD+Jt5Ts4VQ8/rRLA4gk9c
	 ngIrpPvz3JcIA==
Date: Wed, 14 Jan 2026 20:48:10 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] man/man2const: clean up the F_GETLEASE
 manpage
Message-ID: <aWfy0citkX0b1TkU@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <20260114-master-v2-2-719f5b47dfe2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="looj7ygez2tmtbko"
Content-Disposition: inline
In-Reply-To: <20260114-master-v2-2-719f5b47dfe2@kernel.org>


--looj7ygez2tmtbko
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] man/man2const: clean up the F_GETLEASE
 manpage
Message-ID: <aWfy0citkX0b1TkU@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <20260114-master-v2-2-719f5b47dfe2@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260114-master-v2-2-719f5b47dfe2@kernel.org>

Hi Jeff,

On Wed, Jan 14, 2026 at 12:35:25PM -0500, Jeff Layton wrote:
> - Remove a redundant subsection heading
> - Add in the lease-specific error codes
> - Clean up some semantic newline warts
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks!  I've applied it, and split it in two commits.


Have a lovely night!
Alex

> ---
>  man/man2const/F_GETLEASE.2const | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/man/man2const/F_GETLEASE.2const b/man/man2const/F_GETLEASE.2=
const
> index 10f7ac7a89a70b83be10a381462d879cff813471..e841f7f8c7c64ba8c6868e68d=
493716040e3dec2 100644
> --- a/man/man2const/F_GETLEASE.2const
> +++ b/man/man2const/F_GETLEASE.2const
> @@ -20,7 +20,6 @@ Standard C library
>  .BI "int fcntl(int " fd ", F_GETLEASE);"
>  .fi
>  .SH DESCRIPTION
> -.SS Leases
>  .B F_SETLEASE
>  and
>  .B F_GETLEASE
> @@ -43,7 +42,7 @@ values is specified in the integer
>  .RS
>  .TP
>  .B F_RDLCK
> -Take out a read lease.
> +Establish a read lease.
>  This will cause the calling process to be notified when
>  the file is opened for writing or is truncated.
>  .\" The following became true in Linux 2.6.10:
> @@ -52,7 +51,7 @@ A read lease can be placed only on a file descriptor th=
at
>  is opened read-only.
>  .TP
>  .B F_WRLCK
> -Take out a write lease.
> +Establish a write lease.
>  This will cause the caller to be notified when
>  the file is opened for reading or writing or is truncated.
>  A write lease may be placed on a file only if there are no
> @@ -86,8 +85,11 @@ capability may take out leases on arbitrary files.
>  Indicates what type of lease is associated with the file descriptor
>  .I fd
>  by returning either
> -.BR F_RDLCK ", " F_WRLCK ", or " F_UNLCK ,
> -indicating, respectively, a read lease , a write lease, or no lease.
> +.BR F_RDLCK,
> +.BR F_WRLCK,
> +or
> +.BR F_UNLCK,
> +indicating, respectively, a read lease, a write lease, or no lease.
>  .I arg
>  is ignored.
>  .P
> @@ -196,6 +198,16 @@ is set to indicate the error.
>  .SH ERRORS
>  See
>  .BR fcntl (2).
> +These operations can also fail with the following error codes:
> +.TP
> +.B EAGAIN
> +The operation is prohibited because the file is open in a way that confl=
icts with the requested lease.
> +.TP
> +.B EINVAL
> +The operation is prohibited because the underlying filesystem doesn't su=
pport leases,
> +or because
> +.I fd
> +does not represent a regular file.
>  .SH STANDARDS
>  Linux.
>  .SH HISTORY
>=20
> --=20
> 2.52.0
>=20

--=20
<https://www.alejandro-colomar.es>

--looj7ygez2tmtbko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmln8voACgkQ64mZXMKQ
wqmeFRAAr1GL/Uy8VsBGoD2JK2hAX3fWYdcXWnz8vr/Bm4XwInqkpftgLAh8EIRM
M8D28E8nXGVTMmfG7QXIWLuhdNQqDZA/2iij2AFG5Rtr+PkepC2yKmClrwYws9PW
qK8rSFE57vfesVtukBImBkvaxynmlEh6AipwhGN70EEE2xxxhdm42cd/VTZbw62o
NgPWGC8QNcdwAD313gMe8BWiTPrJFwuannZ4glpe/Bh9BSsKwwNh9QyMtpuIp3G6
kSsfKcVGII8PXO1GCMMZfaahIfvJERQB1Y2x5fw0ghQgos6NYzjz6sH8YI5Is0E6
ApFJqrS/MQSei1vzPTXhaEfgXtGZWxJdgPu/cz1eASAqRK1h4C7/YoqfDPFc+F3n
eabzyjU8/zEvPtL3Yq7uG8J2RT/ZURPQNDFFqWgAKwbwHGieDxo4rC3yaSoKPkJu
6MRTQiSAL6GMPTA1jdu/brc0pgr0/o5/O5JZ7FnbUNZDrTRM2RwJaBaI35Jq0urZ
NuYyJPZbEddI+malpmCi5Ian1CVbIyJ+2e2yVtopQHsS+5Ko5jSjyzryTmXo1p08
BPniBRONclNCDHDUAErxR9muqNBpvMunw1Xe3/DSh6BbawdkqVX96glGIOnmkghc
yZpDw56IULjDGDkv7yU8MHROp12oITx1u7ks678WTJa2XVPe5/Q=
=3ZUO
-----END PGP SIGNATURE-----

--looj7ygez2tmtbko--

