Return-Path: <linux-fsdevel+bounces-23417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC7C92C1EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848782927C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30081A2C01;
	Tue,  9 Jul 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMX8E9xN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC51A2562;
	Tue,  9 Jul 2024 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543407; cv=none; b=U3mAcZaAjeY2oBrZjsqdjXlQOE1hYExd0zT27174DQKA/gvVqG5XDCfgnHaf4cUny1ZqW0xQzKFf/5cqLY/V+7mN0Cm9gpkui+M+bL9v2TcR60df4VBVQR8KG1sYUBtGC5cEV5v/Qxz2WfwiUO4L1UjpjJRENY+wD4JYrL+Z8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543407; c=relaxed/simple;
	bh=UPtTRsdr9bCOPoAKJTaeMJRe5VAvhSreMttWVKjS6q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJhLQdZg5OFSGOnIIe6bPsYHJZ6h1mz6ofZ6hy8jYd70xNPjZ0jLeURvZ/8/nhJMuLgN+K+i2lygvQbOSa408WBdxrvlhY7696oOyxxmNh0By+JSVxnJFNHjo0wEMx3aB6/UFsRNjQglwqo7dDawucWuMn8c2W37X3SQlmLghhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMX8E9xN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C580C3277B;
	Tue,  9 Jul 2024 16:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720543406;
	bh=UPtTRsdr9bCOPoAKJTaeMJRe5VAvhSreMttWVKjS6q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMX8E9xNR2qDOpCFby4JB3SyKhvJs+nBZ5BmtuyjZm7Nm9H0AfmdaUdTXKzHOd6X0
	 EgBkyLG/TsOMXsKy1/xUepNSiucbgIqM6hrgv1zq3BtIAwKcFYATRrn45KZ4HPKQrJ
	 shomeosR1BFyA3VP5PuNGmvqhtcT9xLbyiP9lf/k1SLWFBHWlj1re/M3zbeGlzcRio
	 7bF9j2LN2c2SUPl4mzypQskj1RSGUXz1ayHDYW3bi2/TK4hADcEnZbFjYJPxDDj3u8
	 O/uYFpRFxYBER1UqdaaIdjac4S/nd7ShpBr8Lcndt7CJ45Na60mIw8qaTjgIXiIdIn
	 LmMqAvctASu9g==
Date: Tue, 9 Jul 2024 18:43:23 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 0/3] man2: Document RWF_ATOMIC
Message-ID: <omql3s5mauqxjod5zknewdxjfdsihzv3fi2ypbrzrtkgtcm4yx@peqqpks36isb>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yz2a6qik2qpefojd"
Content-Disposition: inline
In-Reply-To: <20240708114227.211195-1-john.g.garry@oracle.com>


--yz2a6qik2qpefojd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 0/3] man2: Document RWF_ATOMIC
References: <20240708114227.211195-1-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20240708114227.211195-1-john.g.garry@oracle.com>

Hi John,

On Mon, Jul 08, 2024 at 11:42:24AM GMT, John Garry wrote:
> Document RWF_ATOMIC flag for pwritev2().
>=20
> RWF_ATOMIC atomic is used for enabling torn-write protection.
>=20
> We use RWF_ATOMIC as this is legacy name for similar feature proposed in
> the past.
>=20
> Kernel support has now been queued in
> https://lore.kernel.org/linux-block/20240620125359.2684798-1-john.g.garry=
@oracle.com/
>=20
> Differences to v2:
> - rebase
>=20
> Differences to v1:
> - Add statx max segments param
> - Expand readv.2 description
> - Document EINVAL

I don't remember having seen v1 or v2.  This is the first iteration sent
to linux-man@, right?  (No problem with that; just to confirm.)

Cheers,
Alex

>=20
> Himanshu Madhani (2):
>   statx.2: Document STATX_WRITE_ATOMIC
>   readv.2: Document RWF_ATOMIC flag
>=20
> John Garry (1):
>   io_submit.2: Document RWF_ATOMIC
>=20
>  man/man2/io_submit.2 | 17 +++++++++++
>  man/man2/readv.2     | 73 +++++++++++++++++++++++++++++++++++++++++++-
>  man/man2/statx.2     | 29 ++++++++++++++++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.31.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--yz2a6qik2qpefojd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNaKoACgkQnowa+77/
2zLkgw//Qr2Pf6/EYWQnGijRgwRwUsIrBPxYCL3T8b9MoX9losjUc4VtIokLTZhj
LKU2VcsH9sLiFcpAXZzDkhGKzd2VJsLRl6ev0H0CMUfQk7uf2GhVIn26zK4kIavK
PKsaJnXPoAgbBmLW+PA1I7Ir9njt507GF4il71MkXSN9xyiNB9axXTnkB1R6WI83
wVD33mDFTPzoHeCARVp9LHAdZHoBdez7asHl8dvuFLA/v48ivtcQij6JEqwHeG/7
cIeQ5SnC1HZw5mMpMlNo9/wI5tEv1awCaOgSV/7GYxb6xOEnENB5u/XKsx/4WhaM
V9yoEf9ngD6n/nGYmIVLF8s1rn/BtSx9j99N90PMXz3ZGN7ARvJwde6YG6Qb3r6C
ZiPwyubE9kun40zyY+s+TajuJ+GU+n+ZsZfeyw3/m/CrcNtZ6vxOzDey+JDtY6FP
wvb/5DSMm3cbyxu8iix5gn6txf5Qs9XfvamT5DHOX0CeN0Qefbu+v/GvLRPjlCar
mZvlX/Ff2sD/MEwjkQjqU4D0EF54GD9i+6tpT6l7SVaQ5kb5Rrbyh4xapyoBt2Gf
ueAwFm36327cOoHA2uBv2uTsioDxCcx6rbtE1oXj2S4bclGCsiu6hnqfvuoy24Ak
hTf5UZVBrJeCQC2sDEtJUTwVKvnjqdWiYCaL9LswvUNwxMZdr4U=
=YmvW
-----END PGP SIGNATURE-----

--yz2a6qik2qpefojd--

