Return-Path: <linux-fsdevel+bounces-36501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4C9E460D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 21:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572982825BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915CA18FDCE;
	Wed,  4 Dec 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPiQo1I8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE9C17DFF2;
	Wed,  4 Dec 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733345157; cv=none; b=OsW0w8trE76SaJEg6LOyT5Z3j4Og1UrVfZSHClv2wyt5hehduFapuavzKP1sbsXM08sSg7zoaE48T7H4zb8xnTWz5qoYEeUaQ0z2PaLmSZqiQpqzVtfzSwHjVEcSRHxyyvOaCpxwf7wB2ie6XkMLH6v/lGxV4JkKbm6byPfbVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733345157; c=relaxed/simple;
	bh=EWO25zStvwqvY8x085whXcbEi1yvwOa+EsXR6CmVVYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdK6EQ6+IyIi5Yu7RlcPKj7Lg2jny930lbdZoO4nUBD47dalVY7yl8J9d0Ga19NwNinWHAwAgtD+LlvmosyqqgV8Biof3iI/JERKEmYzwxPwr2Qkn39IMcq1A0m2Cx0dXB5aGP+Kr+UrbRLUHbrxoiba1Gkndiw4nUcs/OSDFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPiQo1I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466BEC4CEDF;
	Wed,  4 Dec 2024 20:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733345156;
	bh=EWO25zStvwqvY8x085whXcbEi1yvwOa+EsXR6CmVVYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPiQo1I8Xf3jgDQoSYPcvPZ8wG6SWrNChu2boQuxIidjla7AnUWm0wY8UxC9EwrbI
	 E5ng/HnAEq9wY6pGdxUb0/wpFU4NxRsoTUKFiy8fM/YjFPHo4epSFQ0IBLuAVChVZ0
	 85nBeF3Pne7AACfETobhQAcWksnnJfbl9l9jD5ibHbcj7WR/YdigE1xr/dBOstZgsf
	 RKz5GRQgARFpIPONOP6V3Qg+7XQVifX5kkaHSJCbhHH8P4Sium6vOWAWiPB9BjdCmn
	 Gjouu4Urf0P17ely55TA8geuGhSvATHuL0+ZEb+s7movA9aWZyw3kBy3uU+YdJN32M
	 FaGc5yvFPlVHA==
Date: Wed, 4 Dec 2024 21:45:53 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
Message-ID: <20241204204553.j7e3nzcbkqzeikou@devuan>
References: <20241203145359.2691972-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x67sanwd52hvirny"
Content-Disposition: inline
In-Reply-To: <20241203145359.2691972-1-john.g.garry@oracle.com>


--x67sanwd52hvirny
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
MIME-Version: 1.0

Hi John,

On Tue, Dec 03, 2024 at 02:53:59PM +0000, John Garry wrote:
> Linux v6.13 will

Is this already in Linus's tree?

> include atomic write support for xfs and ext4, so update
> STATX_WRITE_ATOMIC commentary to mention that.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Thanks for the patch!  Please see some small comment below.

Have a lovely night!
Alex

>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index c5b5a28ec..2d33998c5 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -482,6 +482,15 @@ The minimum and maximum sizes (in bytes) supported f=
or direct I/O
>  .RB ( O_DIRECT )
>  on the file to be written with torn-write protection.
>  These values are each guaranteed to be a power-of-2.
> +.IP
> +.B STATX_WRITE_ATOMIC
> +.RI ( stx_atomic_write_unit_min,
> +.RI stx_atomic_write_unit_max,

There should be a space before the ','.

> +and
> +.IR stx_atomic_write_segments_max )
> +is supported on block devices since Linux 6.11.
> +The support on regular files varies by filesystem;
> +it is supported by xfs and ext4 since Linux 6.13.
>  .TP
>  .I stx_atomic_write_segments_max
>  The maximum number of elements in an array of vectors
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--x67sanwd52hvirny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdQv4AACgkQnowa+77/
2zIW2Q/9F6awyCOWuLbuC9fyPIP/9h5zqmfOcpkHdiQ3eXbQMFKvY+IgvuSAQMq2
R6LEAszjKabh+Pi9MmNdHWxv3fq+zQSmzVw2mOJbatDevcBMGTpYdv9+oO6eYYqM
vQhfDSnvW5JI6K3Xf9sPbvVneK7GR+h6VUGA9+VmiD41s8E3r70Dn3lvrFMpefHR
AnUtTdM9sj/GhLLYPVMx+T6+KdHhYVHCMubrOfIpRgHoo0DkNdIa4zBmdfMXAjG9
98KhMV14k5tSBtsd83qNSqvyu0oIIb/8E5KeHZcfqxN01k+qq02PJhYh43zzX0AZ
a2JmC1xGqS+SKdfE+Z2ibevVW+rTn7T4IZVknJ5sWNx2MbJ6UmslI61mzg/1U3QW
/s9/p4xgkCmp2LeFiZ7rnuTvMdbIZ3sDA74QUyMxtj3e11ii1drdaYUL/wJ6ORp/
JbypDC/pqwuD3B/MybU+keY/uIO/dkKo3ZxzYO9Sn/fDae0j/OUT76b0C6+LyA8b
be1j9YjVZSzmhz+fpBRR9yIY3p/lRJA2WVFVSUY4Kjr6rdMo2KxCfqksH02y+CrQ
+iZtYZp39xIyrWEBmrJ9Nd0G+0KqCrpqZGKKCioA0BDoKqlK8nx4cZDEI9g3AG2f
nnL20aGiEH+2bEAKyIwRnfbzBqLGwFsEjAfVODl0qtaJrYDNsQc=
=pDM3
-----END PGP SIGNATURE-----

--x67sanwd52hvirny--

