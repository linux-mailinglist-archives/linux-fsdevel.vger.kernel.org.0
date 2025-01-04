Return-Path: <linux-fsdevel+bounces-38392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0DBA016A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 21:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3886A3A3D7D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 20:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01361D47AF;
	Sat,  4 Jan 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khvyz/6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB7148FF6;
	Sat,  4 Jan 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736021828; cv=none; b=l0fM6ejp+lZ6BlDBFrzuzEw57oB1Oz+90Q6AubtbVKfDQrh0tTKmuGUCNH28FfZu5pPdHhb3fFWwlUnfXDRQGHNcgB/SAAFQzYvEZC5R51kZu4DKkfGv4zfFDgCHyjA00iqAm/i8P2CwUXjvG0GvVkZQXFBJn5vbuVPOZWXZw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736021828; c=relaxed/simple;
	bh=zt9ouSE9R8gSp2duPH2jaiq0XBzrFmN4N/jV/4BNfOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opp3Dy0E7iPKE0wkje3eST/Vuo9SZR3eDw9a2CI0qEZFSePD2YV/IPWAn7KjoOetnyafWz/KtSSR/R0C97KG0BvFSP78rV0/m5am/4QgIkUwv6GnhE3a0wjOfZxF3Kjfx8veinfB3uHT6mZekJ3KqIB3R1ZSNVmuoTZTi5fdqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khvyz/6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917C5C4CED1;
	Sat,  4 Jan 2025 20:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736021827;
	bh=zt9ouSE9R8gSp2duPH2jaiq0XBzrFmN4N/jV/4BNfOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Khvyz/6p+VYbLmfWzHL3aP5CaqbAhiZTZlJQMfCwXxFakyEyxLUN/sc2o2EN+KeWh
	 +wL+TcJkDn6Uz5GDXkN+Dn6wUfpn6q1ilDTAgQ9LXjgC2JtP099V2WFMeQEczrotwd
	 13K+UkDoUZrMt5+Xo2U121QhoR43vC2YUHuz9WeGiu3ZSPig4xt1JEinVIQ6Sw/U2A
	 snNVKZfw279ZrtxEOWXZ8lFLzNBCHDHPxQ/uGYhtoDKtRL30VVw5XkzvGfLsVCaAZa
	 8gyRvt1AjzwZpTLLbUr65To8bE+QqazUhdRJDWlxt/FF3q30W/ohKifJhPFdrY4h2/
	 ZrkDPab1kmrWA==
Date: Sat, 4 Jan 2025 21:17:07 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	dalias@libc.org, brauner@kernel.org
Subject: Re: [PATCH 0/2] man2: Document RWF_NOAPPEND
Message-ID: <73tb73qlzaatvrt2ahe2k6mytb6p3cnvedo3xulygk7q2nv6em@rfz4ufmaei4u>
References: <20241126090847.297371-1-john.g.garry@oracle.com>
 <539b1d48-e0d9-41fc-9c12-fe85b1018297@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cd7shh2fmguqj2fb"
Content-Disposition: inline
In-Reply-To: <539b1d48-e0d9-41fc-9c12-fe85b1018297@oracle.com>


--cd7shh2fmguqj2fb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	dalias@libc.org, brauner@kernel.org
Subject: Re: [PATCH 0/2] man2: Document RWF_NOAPPEND
References: <20241126090847.297371-1-john.g.garry@oracle.com>
 <539b1d48-e0d9-41fc-9c12-fe85b1018297@oracle.com>
MIME-Version: 1.0
In-Reply-To: <539b1d48-e0d9-41fc-9c12-fe85b1018297@oracle.com>

On Mon, Dec 16, 2024 at 10:33:26AM +0000, John Garry wrote:
> On 26/11/2024 09:08, John Garry wrote:
> > This provides an update for Linux pwritev2 flag RWF_NOAPPEND.
>=20
> Hi Alex,
>=20
> I'd say that it is ok to merge these changes now (with your suggested
> modifications), as no one seems to care.

Hi John,

Sorry for the delay.  Would you mind sending updated patches with the
minor fixes I suggested?  Thanks!

Cheers,
Alex

>=20
> Thanks,
> John
>=20
> >=20
> > John Garry (2):
> >    readv.2: Document RWF_NOAPPEND flag
> >    io_submit.2: Document RWF_NOAPPEND flag
> >=20
> >   man/man2/io_submit.2 | 10 ++++++++++
> >   man/man2/readv.2     | 20 ++++++++++++++++++++
> >   2 files changed, 30 insertions(+)
> >=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--cd7shh2fmguqj2fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmd5l0IACgkQnowa+77/
2zKr2w//S501otzDGHU7hSks92QYgz9Qk+nNjXUJ0WzgZ9yMm67VRyMTzdGsqVLa
CSW5qYvxIgLmoHybea/pMHcASVtZrAajNHD/CX4mcuaN6LMb3NiruASjEe4OdF8x
WIJ0qxohWLLhBZltD0WmWvMMxD7qYV0nqlsSm3vweWymoI5aTtoKFtF4MAFYbb8e
kIRjFtYY+JWnVg1zoAiGfPYd0WVIY3wywSsxzJV+gO7ENudL2R8CWrbZHAkPzUJT
2OP7WA1AOXXfIvSYjSPh2g9b+2dCktL6KyO+rMvIiJnQaKjMYzWgvPJp+y/xmAIi
74X1r0XWXgOb1N6T1i8NKm0K7GgOFzyhpKKa4XOgoayIe32MYo28YYZhBngxvRSZ
7RXPJiQzgwk3jITPjyA58ntrhlwj28ktyh8TbefHS2TJ0UWxSFHTcZkjoZUvLozB
t3KEPsJsbxgjsVzRRa6miPgjSb3tr2k+ZMfYH56zrlWTTSzOaD7IoBerBVLTX1ON
LZLEnl+5K4FsKlDFlXBWssGiBeiqcyi1dfSj8l0AFhJGbIsMnPE8MALvoyejQTsx
W48f9c9GAR6PDhhymdLtghyLwaZ8lN9M6fz2xCAf/buuVG3fW85aLGNoRxoHxhUd
Wj8yc1Lsn2dAW3MPRPPleA21e4lc4+OkeVvx7gFzu/4eC6E42mI=
=wwY4
-----END PGP SIGNATURE-----

--cd7shh2fmguqj2fb--

