Return-Path: <linux-fsdevel+bounces-52428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF62AE3332
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 02:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F643AF921
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 00:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A592BA2D;
	Mon, 23 Jun 2025 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFJC0H2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AE1853;
	Mon, 23 Jun 2025 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750640160; cv=none; b=c2xObI8/Fl1lgKEcAVtpP626cKoQFIWMUU4ASqtBWQxdJbj1TK5vqh3kPWjUeVc9IfgoFnoXtORKTxHz3DVsqyVNWeISd+yCAIbR5hxwPn33oaWZPZJuQ2x54pEJpsq1SVodoefX/W+/7YFeWrva2VVsPOzyv4KU3Ree6Ix8FFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750640160; c=relaxed/simple;
	bh=vcABYOkqq14g+eIUIf5QSuzIa5WGou1ACb34ZXbcWMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSnCG6h12HlBC4Gfk0doQsXJZyKcvNsh7hYORGWAslKXEumap2Px+IOpb63G3s0fozaFta7NA18jarfMXVQhbd8h+cnv4FpEyA0UnamU0Yrk2XlKJ/HEsJN9r3GhxiVBlc6iGUGdHZq2rOEcoFPO7BmJBk2tMjb+Ha2iva46/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFJC0H2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334A7C4CEE3;
	Mon, 23 Jun 2025 00:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750640159;
	bh=vcABYOkqq14g+eIUIf5QSuzIa5WGou1ACb34ZXbcWMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFJC0H2Cd1jWpt4llw/3kqfljf/eymIjMOd6+6Sltgh7EyStjfN6KD7HKp6W3r14M
	 HbUSj2uf75tNXzTvCivdLmxfUTINteTLaP+iWpO3FY2MH61IA7SGWwoeyvWAkvxeBq
	 ZN6sYuP4lUe0bYKt9WZ05PkOfwVxmOa8uHn0JNIuFeVd+FFF3TLJ/phx8nX6e64TJk
	 j9xS/eDLjYHxYOOSH06WaUUy2eibHTywlazrSeoTLznhpbeKGvx6/R2Qxn7hB4prN2
	 CCGmSQOVhPzREWaRe+K5ng0IiRtqi4zbe+KcPN3S0j8/0+prl505srVzCDBIGTmDE0
	 h//o+7r/08dlQ==
Date: Mon, 23 Jun 2025 02:55:50 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] statx.2: properly align stx_dio_read_offset_align
Message-ID: <kup2hb4ffghnxc3ceed5qtf4wqgizmjmaika72fhgv55gum25j@fgjqslihhopw>
References: <20250619154455.321848-1-john.g.garry@oracle.com>
 <20250619154455.321848-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3pfq6gjwi44iubs"
Content-Disposition: inline
In-Reply-To: <20250619154455.321848-2-john.g.garry@oracle.com>


--x3pfq6gjwi44iubs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] statx.2: properly align stx_dio_read_offset_align
References: <20250619154455.321848-1-john.g.garry@oracle.com>
 <20250619154455.321848-2-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20250619154455.321848-2-john.g.garry@oracle.com>

Hi John,

On Thu, Jun 19, 2025 at 03:44:54PM +0000, John Garry wrote:
> Align this member in struct statx with the members above it.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Thanks!  I've applied the patch.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D6006fe8bf74e400e060ff70f62ac03d911af13c5>


Have a lovely day!
Alex

> ---
>  man/man2/statx.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index ef7dbbcf9..273d80711 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -73,7 +73,7 @@ struct statx {
>      __u32 stx_atomic_write_segments_max;
>  \&
>      /* File offset alignment for direct I/O reads */
> -    __u32   stx_dio_read_offset_align;
> +    __u32 stx_dio_read_offset_align;
>  };
>  .EE
>  .in
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--x3pfq6gjwi44iubs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhYphUACgkQ64mZXMKQ
wqkFthAAq2tmV1O+v/i0SGWBkOuvAIyAJJrCosjtR9WLmtByFV8veF4ZMYHIz9P+
3+V/1hovEdNTkx48JitK4Ye0RoGEmU4/lgpDFokBqN0zSVNfOJenayAgiTS+24WY
FMFKUUeO6ZT60h/8SpRDgq1njlPjyq8/19yhqZVuwr3nb+lEzDCHIDrzyCxPd/Px
T9IGJ66pNnWR2UryFK+p32g3H8Rd9qebXVgS2AON1lCHlAAut/7LEEpBfCzv+hcS
Dh9RtoEwOe5ix/vKY2Sx5ZR1K8IB9TzoxcmwX9bVCfOIRochX1P/C84v2IVyKtXj
9mHe9lDszZ0jamjJaAZZR88pXO3QG9y3l8NZuVJoFgHfudCJ5EtEoy1iD0YJCfj8
fO4AaIP4xSfHXH4YdDY/0n+ag3tp5QfclK2q3eIjrUXmScQZap5VkuHds1925ZKU
9ac55J1v+mGV0wQkMQypJJQqkuYWTh3QCmi6kj/aGqczMdJQxaIx59fKdmzIqzLe
x6mXxPaY1GF8kHl/+X74zejZh379aYUigivHgiBZceCHyziZKT9VNM+veLeq8QkD
qOx9zg1k6gcJ3J1EoYjum5TJgpOWJBq1sfTxGZP3aC3hkvFRkN1poD2l3YAe0n/r
4ZAJFHJcSJjsq5T/mItL4u0p7dDDDo4XiilFWwnWOFJI7MkDThg=
=fmra
-----END PGP SIGNATURE-----

--x3pfq6gjwi44iubs--

