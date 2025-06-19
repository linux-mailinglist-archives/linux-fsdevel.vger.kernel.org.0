Return-Path: <linux-fsdevel+bounces-52237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E230CAE07AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AF2189F042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A9B1E260C;
	Thu, 19 Jun 2025 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1COMrMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743D1EDA2A;
	Thu, 19 Jun 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340766; cv=none; b=VU2W6rUC561cAiG9QkA07mKOQsuhNW2Ibypius3EPyEWrmZxPNIqFqfDke9Da/BCLvLZ7K4OXcJKO88hi68QTf9LipM/FBhf7/28wdoUaYQRi7PV4UtZ9hs07IFn/UzV/JX64Hzw9rvMIMYwAfM4VQWY278jl6I3ifgVtkaJ/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340766; c=relaxed/simple;
	bh=jQ60UVw4HG69D0KBeaVFSM+MumIBCIoxGLIakI84zyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZs8pEpLgSVwYfKtoYL+NrS/sByrVpHdOh2996w6Uqykp+FcjRMcBwvF9HE+eKPlUGpP6yhKQAwhuNeuLyv2H05vCOuk1lgKebn0bQhG3ZZVJ4y/66UwzshB2UO7cm9dpor6DQyyRSf/NkdeMSRrw3oDtYqm5twBlSciw3wrsWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1COMrMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D551C4CEEA;
	Thu, 19 Jun 2025 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750340765;
	bh=jQ60UVw4HG69D0KBeaVFSM+MumIBCIoxGLIakI84zyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1COMrMpBtgzzt7fRduma97+P3q5Fy8SjhjUeZjw0h4TiY/gLFiwkiQXJYU6/fdPq
	 WkjvpgWB8VjNCjEkMLuKwFA62oz19YmGapoX8qz6YqU7tAxP1lMUnICboALAoLXW2L
	 ayh15G/6wfqh9q6FUlrDDpSG8z89zjE31atPCRJusQuwDNjsegIBwbQQGglMAF5aUu
	 iXiwVYJt9/KQfGtaGEGULT2PeaIaslbLtHjGpsSVjumpbJhPxO/gaJ34SQZ9NKXlxk
	 FkRsRoVIx26xXaXNE/xFb9PGDye0GeogozdVPEHxgTPrAtJV7Nb92Q4E4M/bTKa34z
	 1cX74zbBFMC1g==
Date: Thu, 19 Jun 2025 15:45:52 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] statx.2: Add stx_atomic_write_unit_max_opt
Message-ID: <gemmte63lftx2izscj7jjt7yzo746gfkjywnz2il66b4loht23@3ihpa3i4sudt>
References: <20250619090510.229114-1-john.g.garry@oracle.com>
 <7ret5bl5nbtolpdu2muaoeaheu6klrrfm2pvp3vkdfvfw7jxbr@zwsz2dpx7vxz>
 <e27668ac-5134-4a37-8b50-290e3f04edec@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2gfnqqkq3ig6qvt3"
Content-Disposition: inline
In-Reply-To: <e27668ac-5134-4a37-8b50-290e3f04edec@oracle.com>


--2gfnqqkq3ig6qvt3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] statx.2: Add stx_atomic_write_unit_max_opt
References: <20250619090510.229114-1-john.g.garry@oracle.com>
 <7ret5bl5nbtolpdu2muaoeaheu6klrrfm2pvp3vkdfvfw7jxbr@zwsz2dpx7vxz>
 <e27668ac-5134-4a37-8b50-290e3f04edec@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e27668ac-5134-4a37-8b50-290e3f04edec@oracle.com>

Hi John,

On Thu, Jun 19, 2025 at 02:10:27PM +0100, John Garry wrote:
> On 19/06/2025 12:05, Alejandro Colomar wrote:
> >> @@ -74,6 +74,9 @@ struct statx {
> >>   \&
> >>       /* File offset alignment for direct I/O reads */
> >>       __u32   stx_dio_read_offset_align;
> >> +\&
> >> +    /* Direct I/O atomic write max opt limit */
> >> +    __u32 stx_atomic_write_unit_max_opt;
> > Please align the member with the one above.
>=20
> stx_dio_read_offset_align is actually misaligned (to the member above it):
>=20
>                /* Direct I/O atomic write limits */
>                __u32 stx_atomic_write_unit_min;
>                __u32 stx_atomic_write_unit_max;
>                __u32 stx_atomic_write_segments_max;
>=20
>                /* File offset alignment for direct I/O reads */
>                __u32   stx_dio_read_offset_align;
>=20
> I'll just fix that separately.

Ahh, thanks!  I couldn't see that from the context.  Makes sense.  :)


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--2gfnqqkq3ig6qvt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhUFIkACgkQ64mZXMKQ
wqlAhg/8D/zZ7BG5rLdsS+wKxsy09XNmbXVw3531SdRJ2e/UNHoC6GjBN2EJcah1
81o6IqMOHsR+iJuiS0WuBwEEU7StRl0N2LXGihsLOB5N8nX+JEf7fyJCNxEmVHfd
d2ZRZEksL5lbnrjMoAKQFtjTIWbFWXJUwdeNqQlTP3/wFipsXGuw9jb+QporZvVU
QCgLWi/nMob2x9yNYCoHxO+vZhK1t1IutV/y7m9dOUgvNL/fvZbXVoqJIRt542zd
DjZPXGKSctfdw3uganjB5M1IdF1ZovMecMQXian/CaZpMp+cx7IU3oA6VFNbUUOc
iYB2p3og99Pnu1MLRRuDkr9eBa5zyZmOxwABGSm/PlXXAK2j/+cj0ptb525OK7wA
vidUfY5qnoucd2RV5EiC21Im+6A9p1oaUbHJZHteTzAar41Idj5scEGOONC3Bj3r
2HEIeOYkywOwMSCi80aGRk7k1QSstWpPCx1JE35lODntRTKZ+L/qROZXHKfnZmtY
Ymmh1O4HWLlig0K6tEvQy4TsZ23oeWmy45GEFC3r7qY5lrXl9QXerqlTZ9bLwDKn
5jJtNdGzb19Cn0Bzohcr64VD8JwwtHTxKu5Oxe5hVVoFhQm+HaaTdW3yQWzsehzo
whtbtO1F4OuRefF22+xfHoHyFxZ8QGHXmR2zyDCFejM/dg7Jinc=
=gGd5
-----END PGP SIGNATURE-----

--2gfnqqkq3ig6qvt3--

