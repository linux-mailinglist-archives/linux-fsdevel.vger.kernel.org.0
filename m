Return-Path: <linux-fsdevel+bounces-36524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45649E51CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 11:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A563D283EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20352144A6;
	Thu,  5 Dec 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJlNEBKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840C2139D4;
	Thu,  5 Dec 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392934; cv=none; b=YSLWVTS3a4DW3Bc+SLGa7XvTcAsTuKH3p0+jruKJ24gO/NlOOLUTpfvF4GpG1YqQRjGhF7j33q0u7uFNgppYV7NzdyGDgVNgYIne64yDIjCk+NiLH6+vdjhBKpddK8T5NjRWOafVUMORwZEAEUYRakwt1xzHZau709K1BZypi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392934; c=relaxed/simple;
	bh=LHYr/GIHOT9dNLoR7pHfURKHDhQJQmbRO3S1WH8uIwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxExNZ+x3FsNYXIDyqBacNHtVI8LEyfMzZroBSHcTyiWiG8FnFKGxVRe/HGgGhPKhDSl7FbWyppTQaCZLBlyn8Ddhbsj4rxjKD9NO40qxBmu4NbGMBeMCv+rDiaqqrC4Z2gNxj5sru6ZAUtm12Ty29flnc/M28EgIVwuWLYUlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJlNEBKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E9AC4CED1;
	Thu,  5 Dec 2024 10:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733392933;
	bh=LHYr/GIHOT9dNLoR7pHfURKHDhQJQmbRO3S1WH8uIwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJlNEBKTzVHfR5C+pE3YhWkri4DJwx9tAJ0MHA4EyTz9zzwNJO+l1L0ZRtaS2lPAT
	 z/CjpKr41+H1OOchDXZ3oWdfnvr1eWV2DREXeTNyfwIR8VpCqtfew+hOoPdyDdaRuQ
	 eJdTToMVkyP4hCCnuVb4/m9R/Ah54ZIiHOrwlsHUoXmaQPicWuk1Ws5ZrY7tNS9NJU
	 ZtUN/QJTQx/Wgg3/U86xKg9WEOikz3nNlTsA1GG7lIZysgge0buyEY6LfD0dY6MAGX
	 ziBwZ056qfhkhdiMiirH5YL2TGePnyuCQqBZR9YsNl+TVi3HdOWFGjKjVxfRpeSORn
	 pBPP3G4Zw7yfA==
Date: Thu, 5 Dec 2024 11:02:10 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
Message-ID: <20241205100210.vm6gmigeq3acuoen@devuan>
References: <20241203145359.2691972-1-john.g.garry@oracle.com>
 <20241204204553.j7e3nzcbkqzeikou@devuan>
 <430694cf-9e34-41d4-9839-9d11db8515fb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pe33nua7prk5j3ci"
Content-Disposition: inline
In-Reply-To: <430694cf-9e34-41d4-9839-9d11db8515fb@oracle.com>


--pe33nua7prk5j3ci
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
MIME-Version: 1.0

Hi John,

On Thu, Dec 05, 2024 at 09:33:18AM +0000, John Garry wrote:
> On 04/12/2024 20:45, Alejandro Colomar wrote:
> > Hi John,
> >=20
> > On Tue, Dec 03, 2024 at 02:53:59PM +0000, John Garry wrote:
> > > Linux v6.13 will
> >=20
> > Is this already in Linus's tree?
>=20
> The code to support xfs and ext4 is in Linus' tree from v6.13-rc1, but v6=
=2E13
> final is not released yet.
>=20
> So maybe you want to hold off on this patch until v6.13 final is released.

Nah, we can apply it already.  Just let me know if anything changes
before the release.

> > > diff --git a/man/man2/statx.2 b/man/man2/statx.2
> > > index c5b5a28ec..2d33998c5 100644
> > > --- a/man/man2/statx.2
> > > +++ b/man/man2/statx.2
> > > @@ -482,6 +482,15 @@ The minimum and maximum sizes (in bytes) support=
ed for direct I/O
> > >   .RB ( O_DIRECT )
> > >   on the file to be written with torn-write protection.
> > >   These values are each guaranteed to be a power-of-2.
> > > +.IP
> > > +.B STATX_WRITE_ATOMIC
> > > +.RI ( stx_atomic_write_unit_min,
> > > +.RI stx_atomic_write_unit_max,
> >=20
> > There should be a space before the ','.
> >=20
> > > +and
> > > +.IR stx_atomic_write_segments_max )
>=20
> How about this:
>=20
> .B STATX_WRITE_ATOMIC
> .RI ( stx_atomic_write_unit_min,
> .I stx_atomic_write_unit_max,
> and
> .IR stx_atomic_write_segments_max )
>=20
> I think that this looks right.

No; the comma shouldn't be in italics.

=2EB STATX_WRITE_ATOMIC
=2ERI ( stx_atomic_write_unit_min ,
=2EIR stx_atomic_write_unit_max ,
and
=2EIR stx_atomic_write_segments_max )


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--pe33nua7prk5j3ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdReiIACgkQnowa+77/
2zKLQg/9ExiLpvDZXe9bEuk8BN4T4qJe3TiKqXkNcLyZ8KEP94BUxaNRvFim16nV
1dGlZA0aFXX4o8eeMQlTmP1cE9vQ9zBk6OaVCMbnFMU+D7D2I4tuiOQOn3GHWEi/
tjSxZ+gZd3r1pdFM7WuK4F9FxEX4DTsLOa3nX2top1qVAsviEilv8Ql8Q69txEfo
dRj6kpNEdyRYHYLckFkzz8S4J30uky9ezSSN6i/tvUiASPDWRBiVWTxepA3o+Luy
xNXbv4+i5cJ8zEOpGwZl6Psk4V2HGKNNXdeOeO6CGiOuHMTjXJzrHKj0AwDdXrMY
5ERn5Uu2ZyVbQ8uDWpEtdNkdzLZkDqhCwuvEGTx3CgrhU0FN1OQfa/q72mIvSBat
k0pBS94tYrLgxUmfX377qAt87fHyZFsAb0lTW8sdYqtEA92BkLeZraZVpTQajnvN
1am03wdt9pJjiDUxXrVHptDWzT3hms1xqdGp/rHjCKqdnoZ8BOEpi1FfGYtCNOpq
UthnRtl26ihsorufB34D8aJcB+4HIv0YDn5jfPZoeL0Cum6Mh9Z0WWvn+TNEARVX
utAXsnqrBuAsuDuINLoTyzfhO5mg90X+QnXVj4qkd8LXUHsMj6ly0YdOh9LDIznK
WV7awNcC0T1kI694A58zKxv7mQIuwsVoCA8MGZXxvEDREFeAL0c=
=DF9o
-----END PGP SIGNATURE-----

--pe33nua7prk5j3ci--

