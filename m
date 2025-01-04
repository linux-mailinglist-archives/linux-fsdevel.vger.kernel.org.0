Return-Path: <linux-fsdevel+bounces-38394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73785A016BD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 21:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC7E160400
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 20:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE531B5ECB;
	Sat,  4 Jan 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh68dom9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5C928377;
	Sat,  4 Jan 2025 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736022882; cv=none; b=scU8GSV7e7Ak1IDlherfk6yK5BEOzIy1mnl6QwDNmJyQ5VsbwPTauMqhHDNBAjmmtyGN1AtusM/uSKcPjvrdSJwga5zSuO3RJ42C4/IAzHW0FHEiBL+Zo6bOOrZ/tZx2PsmZXY7TdDBcmz3QAL14gOyH1bjwRbNp/CKEHkJTHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736022882; c=relaxed/simple;
	bh=c3tA/QCkj9YKl1ULgDzHneB38Y259oX1qxi2wQADoZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0c96Axwm2IUymTSbCDhL4jeRyoZ+5ywxYD1BehxK9O3M/SoBRbIMlSegWG+f0YMK0NZ6gsAst++EBtu4XffcpxradAYOMi7FeBqv34F3eEAlUFDmXJnJ7aj+P7S1uVDyVN9I3xXTX+fJ5gwl1XjiudqoQs4rwYyFHo7mAyK8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh68dom9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268B3C4CED1;
	Sat,  4 Jan 2025 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736022881;
	bh=c3tA/QCkj9YKl1ULgDzHneB38Y259oX1qxi2wQADoZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sh68dom92q8emSCYHPfHks4WhWtqohv0/klWP84Xi7p2TeckVhmLmHSbyORAXj+2a
	 qu1YQcFLNvWFT3s1k/IJS83IC5+sGbCKv3WpiVCDkEKGRbDYqH2d0RYgym6m47Tsps
	 80jyucmeL0IYpXI1UB/QdrAV4E87GfxreLtBgaLjPa5CW3Gia3lEtlPS2oMwgK10Vt
	 +reYQJRHtXPDqmwFO56cpr2vVHfKJH7XiW+0/RdpbO2m2M87Qh4AaWZIJ2j3Ezp928
	 Olgj5oyY1JXMYlQ/4RhturNaOZuHq8i4ajHu8Im+/fYHN0/af49dUfAnRwAKUNpAcQ
	 01iC9enoxCoqg==
Date: Sat, 4 Jan 2025 21:34:40 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	dalias@libc.org, brauner@kernel.org
Subject: Re: [PATCH 1/2] readv.2: Document RWF_NOAPPEND flag
Message-ID: <5cszonzejbryjfdrd6kv6iyxtcpblcf34wrkhkknbgcrh3sync@xlofakb33466>
References: <20241126090847.297371-1-john.g.garry@oracle.com>
 <20241126090847.297371-2-john.g.garry@oracle.com>
 <20241126115257.r4riru6oot5nn6x6@devuan>
 <5459b3a5-a9a0-43be-8e61-a3799848dafb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gqirbykydtnls4ah"
Content-Disposition: inline
In-Reply-To: <5459b3a5-a9a0-43be-8e61-a3799848dafb@oracle.com>


--gqirbykydtnls4ah
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	dalias@libc.org, brauner@kernel.org
Subject: Re: [PATCH 1/2] readv.2: Document RWF_NOAPPEND flag
References: <20241126090847.297371-1-john.g.garry@oracle.com>
 <20241126090847.297371-2-john.g.garry@oracle.com>
 <20241126115257.r4riru6oot5nn6x6@devuan>
 <5459b3a5-a9a0-43be-8e61-a3799848dafb@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5459b3a5-a9a0-43be-8e61-a3799848dafb@oracle.com>

Hi John,

On Tue, Nov 26, 2024 at 11:57:44AM +0000, John Garry wrote:
> On 26/11/2024 11:52, Alejandro Colomar wrote:
> > Hi John,
> >=20
> > On Tue, Nov 26, 2024 at 09:08:46AM +0000, John Garry wrote:
> > > Document flag introduced in Linux v6.9
> > >=20
> > > Signed-off-by: John Garry<john.g.garry@oracle.com>
> > > ---
> > >   man/man2/readv.2 | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > >=20
> > > diff --git a/man/man2/readv.2 b/man/man2/readv.2
> > > index 78232c19f..836612bbe 100644
> > > --- a/man/man2/readv.2
> > > +++ b/man/man2/readv.2
> > > @@ -238,6 +238,26 @@ However, if the
> > >   .I offset
> > >   argument is \-1, the current file offset is updated.
> > >   .TP
> > > +.BR RWF_NOAPPEND " (since Linux 6.9)"
> > > +The
> > > +.BR pwritev2 ()
> > > +system call does not honor the
> > The other surrounding paragraphs talk in imperative (e.g., "Do not
> > wait").  This should be consistent with them.  How about this?:
> >=20
> > 	Do not honor the O_APPEND open(2) flag.  This flag is meaningful
> > 	only for pwritev2().  ...
> >=20
>=20
> That sounds fine.
>=20
> > Thanks for the patch!
>=20
> No worries. Let's wait a bit to see if any comments from fsdevel people.

I've applied this patch already.  Thanks!
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D64fc4bb4ae09a4559a5789a6ede952c0f8570b39>

Cheers,
Alex

>=20
> Thanks,
> John
>=20

--=20
<https://www.alejandro-colomar.es/>

--gqirbykydtnls4ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmd5m2AACgkQnowa+77/
2zLYhQ/+KvuP3KIGC0moQ/+niQdzD7hYcmNpLl+CroZWYnKtJ61q8XMjQeeIPCVA
ux0pvir4zsY7ZitUwsHAxpihCrYqxyKZbT2Ruq+cL8usP600QALmObZ6w23STfg6
/6OP2sqQ2SJ5nD6WPi9usrl5cKYHAH8CRxVNDDTFeI6IMuOj/bXuJLbt7oiGsm/J
llma2RDESqjFXv5M4SU+8M9uY+Cb7t9ruO1+piL/U0c5wdZHm2XNkgOgc3o106Tv
MP9ipzvxe50IUtxlTtXKRM5Id/dBpnrTHZYYkUgCbuqf9i8Ti8q+zh3dPR61V/EF
fcM0ciphDCKSoHGOIIRERxSBoi7rvAqJgGLD54V9/QV388VvC8wdil4cb1eQxlqv
0p1Q1DgEkViR1INmA6H2rp/G1nRg/XM2Nhw0UxF4LG2Z8vB9TF/fBMPc1QECJTCB
p/agL2pv59dJi0loPE5Pzhz6VPOqr15P89+D8RoFJpCnYfLXIYBbh4Ock/+Sjwzd
JJ/9AtVX5TGc1YdgO73O784P/dhy11mmTH/IlMxnp5+pL7fBvII0CnTpUvYdwFRL
5eJxrjRtWjrLWo4QWvKusPnD9MAB51HJkooTKYnpePEGA+KLQh1LO49j1il1j+X5
g9C8+KVJnDPUgcHG3+BbfoQdhsV/RBRSUUUc+KZZXlIuABXbWkY=
=S5aO
-----END PGP SIGNATURE-----

--gqirbykydtnls4ah--

