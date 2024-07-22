Return-Path: <linux-fsdevel+bounces-24097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A619394C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 22:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659171C21716
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478A374F1;
	Mon, 22 Jul 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stUNONwk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C7224D6;
	Mon, 22 Jul 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680567; cv=none; b=cOA3hGq7Tzn9Edb1pgB26uU/2GNOFuPXS6ZDzeCcTPBvXX4TDjjmF1zqvV/jKecxw1Z5aIu96OoVMh8dEeN6z+BOQtp1JoQ7bBHjsoHopyDGo1gc3jD+a/EtaXypaNXFaq7MfP+Y3dmYs8w2Hcgzs/OQ7r8vCVXoYXa4P6xWJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680567; c=relaxed/simple;
	bh=emcYJXsiz2dOkcm9MBtmRp7e73lJJLOv1NX4J+sSGag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlI1MIILmlIyIMI9/dnoyM9EcKgobfK2dWVY97N7NBCnDGJ14v/DL5sSVtUW22+UEJY+tim3ndcbxbd7Ro28y7nOJ57ahikPIQE9n7AWF9vNKHsFdXvh+tOmbBZckW2LZxW8WWLc0LIkkVwWgPXLXuFw6QPG3zvB1J4cvpcVNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stUNONwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238F3C4AF0B;
	Mon, 22 Jul 2024 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721680567;
	bh=emcYJXsiz2dOkcm9MBtmRp7e73lJJLOv1NX4J+sSGag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stUNONwkaTYtbr3dLlfUEvtcUcqLymZSUEu/emNbOZ6jYB0d6JrBXeEoatoRgatbX
	 NoOzrPZycw6uaQr6m95Sicy8xSftnb7G/CfZp6cWK8ZSxkB12ApeK2WyHtlxZ8UBiL
	 Vd+VrkHE6WbZyPwe++3OfqJuak9SHx9DSVjszkim8gJ2ThfWEisexl4UrgdckO+x0d
	 0/6cTpWlCTGd95u+Sg/bV1bimHfUI9phByeJxlrMXlFVs4rZdET8jDnMnegLx16XjC
	 kVJY0qjQNoUwLfFIUefu9BSIaCS1oMA+ldsUPmR60TrfVjripp2EgB5d0dUmLT+4y+
	 8gaH43k+It2IA==
Date: Mon, 22 Jul 2024 22:36:04 +0200
From: Alejandro Colomar <alx@kernel.org>
To: cel@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	amir73il@gmail.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 0/3] Update fanotify man pages for NFSD filecache
 backports
Message-ID: <patf7ud3lpig5jazixw6mdeexuoeuzoa2wxwcvezbgo4xa33yi@j6iirfeajedc>
References: <20240713181548.38002-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wet5q4axgtcw5m4d"
Content-Disposition: inline
In-Reply-To: <20240713181548.38002-1-cel@kernel.org>


--wet5q4axgtcw5m4d
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: cel@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	amir73il@gmail.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 0/3] Update fanotify man pages for NFSD filecache
 backports
References: <20240713181548.38002-1-cel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240713181548.38002-1-cel@kernel.org>

Hi Chuck, Amir,

On Sat, Jul 13, 2024 at 02:15:45PM GMT, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> I backported a number of NFSD-related fixes to v5.15 and v5.10 LTS
> kernels. The backports include some changes to the fanotify API
> which need to be documented.
>=20
> Changes since v1:
> - Amir added a few items to the original list of updates
>=20
> Chuck Lever (3):
>   fanotify_mark(2): Support for FA_ flags has been backported to LTS
>     kernels
>   fanotify_init(2): Support for FA_ flags has been backported to LTS
>     kernels
>   fanotify(7): Document changes backported to LTS kernels

Thanks for the patches, and for reviewing them; I've applied them all.

Have a lovely night!
Alex

>=20
>  man/man2/fanotify_init.2 | 8 ++++----
>  man/man2/fanotify_mark.2 | 8 ++++----
>  man/man7/fanotify.7      | 2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.45.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--wet5q4axgtcw5m4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaewrMACgkQnowa+77/
2zIrwQ/9GnnwnS6aa52r+KHFR0A6SptjuHOTxQkPda51feRawQXmGXnqQMb3VhD8
v3nFgk0hHgYV23k5BV9Arxt6432NG3rtD1T62+X/HzdL6v8QS3ig6MzRlX9WfY7M
z+6aAM9OiaLGG2smXnKiY0ouAKrnq3J+I4WJMrVjdWscUv1g36hq5Wxfi0aZuSdP
Jd+/AcoR4v5CBZWu4Rr4w7fZ2DMFmHAKJFebKwSJWd70GQbl7DTxQPOZFGRgGuW7
OxJSve3hPG0RKg9lGQGkafoX1ugWbccmnIvJUcrkbC/IJNO2SDAmhzHrPWqxiWa0
Q1obxjdjXQ1GqXHPjiDuDvrD5heH5hFJ/mHXO7HmQ7hjQyTqFth9e2KKgkYJV+gJ
HwdyzQGAx0aOY5GpwzSWuJxwhPS+cWIspUCYWP+dSjtbor5e2bF404TdfxsYBrcH
eeinsWvJlvIJF8TCya8fInJQAu4K0y5hmfOcZZCQS3uBxqa0xKx7dOPavHUvYvOq
JWLqXUUEf+mV1w/YyjlNuTfhnNz6jjsW+46IBotxCi+x79+7GEyYVMh05uu+bNtF
Upf0plC0Vh1imr7pps0FcmXygW0pdhtSFAUxeAZF1xh2cZ9iVUtoL2f6awrkl4CI
81tpXFxi6yLE8Rk+D+OcfXhg4BReYbC5hNAVMQ7ioPCabNPF9bc=
=2Avj
-----END PGP SIGNATURE-----

--wet5q4axgtcw5m4d--

