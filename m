Return-Path: <linux-fsdevel+bounces-52210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45039AE0384
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957F4189E99E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0121FF33;
	Thu, 19 Jun 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr8fTo72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75528682;
	Thu, 19 Jun 2025 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332626; cv=none; b=pe41/69KafV65k+Q2OA9FALOMbeI2z/aXlpYV6zhnSdyYvdMHmqAfgJJwFEspjB5qOF9PKke7gV0+vcl+ff6gWNB8/WiUY0vUJ7zyumHgLOvJDROHNrUGtfVwtp1waHy33Dm8vRVG56pMn+2KABoiM1pyrn4U5S9uaiVRSIvHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332626; c=relaxed/simple;
	bh=06dcYr32eMU17iPm3Ydr8GIGR6UG3r1YmzA8+vfi3qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkjdGXmU9F6nFsjmuKWyW8PQs9ExW0wERxNeRyyGwNaQpk67IStBaVOYMscRAKtJ0V6HzZc+mOjfeeKOmL2qYrJJIaD+vDjkbJkUaqF+UIEY/gGnPnrLK9/GUiur8ttWGDyxVEcbNACxgSsYImJezVy9F8iroBPO0SIwVLyPVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr8fTo72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E04FC4CEEA;
	Thu, 19 Jun 2025 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750332625;
	bh=06dcYr32eMU17iPm3Ydr8GIGR6UG3r1YmzA8+vfi3qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xr8fTo72oeNkbWUPP8PMsSo9z4DzmG+KfUj5FdWELQdcuDNxwAI7EURL3yP9m+yjG
	 hG9TNN5IlhYOmNqHxt2zftiFC6uVH14jF98bWvtl8rfChoAZwr2Grt1WfS5oUV0FuH
	 XqZ7Kw7yYyWWh9TeRSObwgz9kdNrROePQl409aHVdVht+KjPgZMKixmUDdBZo4LXnm
	 A+fCMinVinPhZ19RrihdB4Dlo7bv45QmUCpm6nekR/zpmdCgUHF2Rccf+E1E1SZXsu
	 F/ClcLEfRVXnm1c8aKxlDc5OjSNAUkePjnQtE6dpIFjLFlaMW/tgCAbbBCrGUsvbFY
	 PkSZqRGxfvEYg==
Date: Thu, 19 Jun 2025 13:30:17 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] statx.2: Add stx_atomic_write_unit_max_opt
Message-ID: <xuxvvxyka5utcr5rajxrxjjjo7adz66etczfbu4jlgqdoks3b6@4abjfqhqxtux>
References: <20250619090510.229114-1-john.g.garry@oracle.com>
 <7ret5bl5nbtolpdu2muaoeaheu6klrrfm2pvp3vkdfvfw7jxbr@zwsz2dpx7vxz>
 <22295562-ac0e-41df-a995-a52c0ebcaa12@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmw6aukllnz5jphy"
Content-Disposition: inline
In-Reply-To: <22295562-ac0e-41df-a995-a52c0ebcaa12@oracle.com>


--bmw6aukllnz5jphy
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
 <22295562-ac0e-41df-a995-a52c0ebcaa12@oracle.com>
MIME-Version: 1.0
In-Reply-To: <22295562-ac0e-41df-a995-a52c0ebcaa12@oracle.com>

Hi John,

On Thu, Jun 19, 2025 at 12:24:21PM +0100, John Garry wrote:
> > > @@ -514,6 +518,20 @@ is supported on block devices since Linux 6.11.
> > >   The support on regular files varies by filesystem;
> > >   it is supported by xfs and ext4 since Linux 6.13.
> > >   .TP
> > > +.I stx_atomic_write_unit_max_opt
> > > +The maximum size (in bytes) which is optimised for writes issued with
> > > +torn-write protection.
> >=20
> > Please break the line before 'optimized' and remove the current line
> > break.
>=20
> ok, but I am not sure the issue with the current formatting

It's because of

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p';
   Use semantic newlines
       In the source of a manual page, new sentences should be  started
       on  new  lines,  long  sentences  should  be split into lines at
       clause breaks (commas, semicolons, colons, and so on), and  long
       clauses  should be split at phrase boundaries.  This convention,
       sometimes known as "semantic newlines", makes it easier  to  see
       the effect of patches, which often operate at the level of indi=E2=
=80=90
       vidual sentences, clauses, or phrases.

> > > +.I stx_atomic_write_unit_max
> > > +and will not be less than the value in
> > > +.I stx_atomic_write_unit_min.
> >=20
> > This should be IR, and the '.' separated by a space, so that the '.' is
> > not in italics.
>=20
> So you mean like the following:
>=20
> .IR stx_atomic_write_unit_min .
>=20
> right?

Yep.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--bmw6aukllnz5jphy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhT9MgACgkQ64mZXMKQ
wqlcIxAAqeghkLwvrlcRBsM28tC/DTSgf6y8UtyWUYPt7IXvxt6i5zeDxTqCmqXF
cg6coRyI9ZuK5sJ9xMCNHCxmei08BXA8Iia+j7B0tTa4pZzrWnXNl+4ACyUla7NZ
XlF2ykhJmdWX1xg3SX7XHlUAI1kpkqZIOPumPRuukffXUC6bkC4ZLiyG+4obBeZp
hJNJybF+1H4kMY9iIsuX9Jw7dW1LJwnMJ/bywPOs0ck1/hTbFaWv7cBNkmbJZQno
pxoyYWnhjlqfpuMYHeqog2R/V/OU1wrupsjJru7qKup1f7CtV2lxkPC3zIl94TU9
NISWKSuYNaAwr4IcH0bx1qUNeF+9xnf3DMYVwbsZ9ky5A1tCPsupcQyuzwRNC1KX
4PwyG2blcYFWFv5htTCirIiNeOzc7eXaLZmd1Y2uK+t4R/tZgljULdrMXqGb744w
DnbsJtqpwpy154qBA+Yt+IZipieza+ez4+BKRQ5b5Ppi2+Os7F2wbMUN51G+vZDk
KZzLm0p6+1Oy4HJvTKW3K6W66cKsRX3HaVAZ7CGlMus07X7S4EX3t9P2GVBkA1Lm
aA+9xmLMnFp2rPuPcNQh69boIe2M8v81jo4s8V5nc3Pxh0fSIeDr5C1znLtURqB6
f3otGNp5/tN1C1dFSz3iCMhdU8DI1Av8QY29dl3rKi1CE2iaBbQ=
=JLB1
-----END PGP SIGNATURE-----

--bmw6aukllnz5jphy--

