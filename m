Return-Path: <linux-fsdevel+bounces-23421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6822092C1F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0521F24252
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516118561B;
	Tue,  9 Jul 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNcIdul5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844E185609;
	Tue,  9 Jul 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543984; cv=none; b=H3kMkOVbs4h2FSaDg6E4udq+V3T0hTqGObASxDapDOfvEOhfa/EC1Sfk1XWL4/ChiXaoeRRMhvQ0053VbGPTf8P1J9cvM1GJCM/h38c7NXVWIdZLIB3SeD4eL7vzcL0mOYXDd7icwTdUPmDOMVXX1skurrcuKbcSAGwyNGy4jHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543984; c=relaxed/simple;
	bh=sopBccQhkcF/VyhzF+hRZ9srfYcMff9XYmrftpUG5sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb2mndtxmKg1LmpKhtUlQ8NkUdb2eHCG0umpXeeBNLJwAoo5v64CF3I+RwFYs22iDHojZy8ZsPit+Rkc9mouEg3FM1j3lzK+2uXujMN0teSXK1TNFOD7trvLJIVlov6GpKG0G3OeFMGUqHY6bNpsAiq/Ar/5sG039MT4OjW9OqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNcIdul5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1D7C32782;
	Tue,  9 Jul 2024 16:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720543983;
	bh=sopBccQhkcF/VyhzF+hRZ9srfYcMff9XYmrftpUG5sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNcIdul5F7LNqu8gpB8PoJMJ+3UpJS+DGGc4gMx/JeM4EsQ8DwTKRCu4YzpSiUoQX
	 aRrMqTAoDwpRhBMpZKWmwoFOyMpiJm0AYjDfv1tviX/xnaHd0EBTLug41rs4i1PFYD
	 CqpPlsl+wf7LnCoPODpkrLDG+cuKfSoDmWRMLiuOFAwksBPnLy50q+ASt7Gs+jufzS
	 leiUtJD/xPokGiLjI2Nc5yxAYpQwW7ZwRho77ZZY3idfZC8lp3ObGirOV5ZKhtqbUI
	 vB3b4N+CFcrNNilWXa0Crv5BSxooQ9kyH9RN9xKRrENTVfwKmCrzbVJJlJcOBveuvf
	 aHhyaH7l58NgQ==
Date: Tue, 9 Jul 2024 18:52:59 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 3/3] io_submit.2: Document RWF_ATOMIC
Message-ID: <yyqi4f6pphnpjhhlwnbvsdyaxsronpfumg4bjp4eig6rh2d4ka@uyy5y37waxbd>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ozkwhxjlox4ixiqi"
Content-Disposition: inline
In-Reply-To: <20240708114227.211195-4-john.g.garry@oracle.com>


--ozkwhxjlox4ixiqi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 3/3] io_submit.2: Document RWF_ATOMIC
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-4-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20240708114227.211195-4-john.g.garry@oracle.com>

On Mon, Jul 08, 2024 at 11:42:27AM GMT, John Garry wrote:
> Document RWF_ATOMIC for asynchronous I/O.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  man/man2/io_submit.2 | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/man/man2/io_submit.2 b/man/man2/io_submit.2
> index c53ae9aaf..ef6414d24 100644
> --- a/man/man2/io_submit.2
> +++ b/man/man2/io_submit.2
> @@ -140,6 +140,23 @@ as well the description of
>  .B O_SYNC
>  in
>  .BR open (2).
> +.TP
> +.BR RWF_ATOMIC " (since Linux 6.11)"
> +Write a block of data such that a write will never be
> +torn from power fail or similar. See the description
> +of the flag of the same name in

Maybe?:

of this same flag in

> +.BR pwritev2 (2).
> +For usage with
> +.BR IOCB_CMD_PWRITEV,
> +the upper vector limit is in
> +.I stx_atomic_write_segments_max.
> +See
> +.B STATX_WRITE_ATOMIC
> +and
> +.I stx_atomic_write_segments_max
> +description
> +in
> +.BR statx (2).
>  .RE
>  .TP
>  .I aio_lio_opcode
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--ozkwhxjlox4ixiqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNausACgkQnowa+77/
2zJg7A//QEF/NM4ppL3m+uckvtxXej8W9rv5id9HrfcLPjixBiGFekh9aQgBiDFn
+AG4m5vOBu/sSIAk2QvdJTFGrCdpjNADWNdxcoX7d6xHIETdUJYS0VWxFypxyW5I
q7OHFR8aZgmmdxQmYbVU23H2PCckJVvjPnA+I0N+9ZX7QMpi2DCD1IUjrJnmwmzG
Mhnxn4ItMBMh8f4Ici8mOMMuMZ9qL2Zn9Duf9TGYUzOaesUeX2y0HGCM7eiiUHRP
8bhT9KOlTC3ielGVBjafgQyZgGqNKhEctW0HSM2fElYK8D28RXatF/hwwQR6dQvL
upjrBz2rtgYsjriodso8wrMMboW5Tp5PxDyUJVPReA7Qw5GrVW0WuXmH4xZR9CRO
HeT+e9UK6ReWJWqHfALubt4ovXTuCj10GwKzchqKmrPehZxCMX8T/Mclv+1oRbDa
mDb8xWm+AB80NhNNZVszHij12Xj6ZwisKvw0RyyQmVAxTIBHP8WKM7SU1FeHcM1Q
gNGssRM++A5+m3J3uTni4YiIzZN+u/UnrcJhtKM3Rji2IW0HF/0k7gNMHRk7mXSi
qGl/9i22az09Pj42LTKL/UnGhvvHWoU31XqgUD3cma4u+/20VIT4SBGHu46S5cBn
2v/9CU9kBcrzUemvfDFPOsprnAPvdZhXFLDu2WXeHuHgxyxB+FA=
=g+ug
-----END PGP SIGNATURE-----

--ozkwhxjlox4ixiqi--

