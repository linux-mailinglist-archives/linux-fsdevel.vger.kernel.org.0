Return-Path: <linux-fsdevel+bounces-69703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB9C81DA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 18:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A923A1C81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 17:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB52F9C0;
	Mon, 24 Nov 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1xK2jXc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE981C3C11;
	Mon, 24 Nov 2025 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004582; cv=none; b=DSMehhBzbrlc+M8s4pqQeHED0YJIlp/6qS1w3wgZjZLjEx9u7apcKT4pk7NoQ0sNHApKvr5i7irMQ6mYWhjnP6Ar2wouddBkdCftOyicTVh46dWxafOzhIrMGm4GiqS6cdTimnxMGWjbSm9TlUVyd5loBnVvJIIE+wpp7tCZhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004582; c=relaxed/simple;
	bh=KHEG/IJMrepTV3Lu6NENjRpQG1H8027i7OVDqzJ25OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3JS4beA/naUr9vRQW9CqYuKVdzWLd79nwi6cHu9y8z1WGvcDEcvX7c4Pn3cK/VF6uLlf68ZC2+c61ot/CQsDXrOkpsXjsQ6cxtB9jlk978naoG6zuG/JB1x+T0vp3RvpDW41c+O+OOOKM33qPRRxER7ljIyuu6C3Z5a7Ohuijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1xK2jXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472A6C4CEF1;
	Mon, 24 Nov 2025 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764004581;
	bh=KHEG/IJMrepTV3Lu6NENjRpQG1H8027i7OVDqzJ25OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1xK2jXc8PdQDskjduwE/SAlaEivpJO5IdVQyTUfnd5ualZm5DBBZe/SkvchRZk8N
	 NycaEGsZXLcE5Pp5wzLKvPBduqBhV+8dbju3RzbVUbPgWZhcGK8gGbazdXdhX3GoT2
	 Vyaz5xLJ7prlycguBZS1yUloigkOlcEm9uIs92opTUMlkfmVtRYND2tcD2Uhy0GAQA
	 FzHwMqUCTirlDfhyR7j5kFZXkC/+Y5Rld1YWT64XuUYd1jh6sHU6sw3NJGZnf+SVID
	 9Xa1exEjk08bT1CDN6f3wfZ+XdASkBfSPSj9Vf6zuoBck5sVMxtaEBcfA061uYBbYK
	 IboFck2kXSD5g==
Date: Mon, 24 Nov 2025 18:16:18 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	linux-fsdevel@vger.kernel.org, "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
Subject: Re: [PATCH v2] man/man2/readv.2: Document RWF_DONTCACHE
Message-ID: <u4docq24vigw45dfqtwtds6iurj6w2eiuae536hou4potzshu2@kefysbpwwdnp>
References: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
 <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
 <6daac09b-dd09-4642-8940-4b70f31ca570@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7dx74m6huo5n4ay3"
Content-Disposition: inline
In-Reply-To: <6daac09b-dd09-4642-8940-4b70f31ca570@kernel.dk>


--7dx74m6huo5n4ay3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	linux-fsdevel@vger.kernel.org, "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
Subject: Re: [PATCH v2] man/man2/readv.2: Document RWF_DONTCACHE
Message-ID: <u4docq24vigw45dfqtwtds6iurj6w2eiuae536hou4potzshu2@kefysbpwwdnp>
References: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
 <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
 <6daac09b-dd09-4642-8940-4b70f31ca570@kernel.dk>
MIME-Version: 1.0
In-Reply-To: <6daac09b-dd09-4642-8940-4b70f31ca570@kernel.dk>

Hi Jens,

On Mon, Sep 01, 2025 at 08:36:49AM -0600, Jens Axboe wrote:
> On 9/1/25 8:22 AM, Alejandro Colomar wrote:
> > Add a description of the RWF_DONTCACHE IO flag, which tells the kernel
> > that any page cache instantiated by this IO, should be dropped when the
> > operation has completed.
> >=20
> > Reported-by: Christoph Hellwig <hch@infradead.org>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Co-authored-by: Jens Axboe <axboe@kernel.dk>
> > [alx: editorial improvements; srcfix, ffix]
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >=20
> > Hi Jens,
> >=20
> > Here's the patch.  We don't need to paste it into writev(2), because
> > writev(2) is documented in readv(2); they're the same page.
> >=20
> > Thanks for the commit message!
> >=20
> > Please sign it, if you like it.
>=20
> Thanks for doing this!
>=20
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Thanks for the help!  It seems I accidentally pushed the patch before
appending this tag.  :|


Have a lovely night!
Alex

> --=20
> Jens Axboe
>=20
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--7dx74m6huo5n4ay3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkkkuEACgkQ64mZXMKQ
wqltaA//QJ8GaCPCaKI4XbGWgBYURUbCvLcf+IDZrvt5RMX+pvcpl3JyRfnSSqNg
U78OJQg1aanmW7Mxg5S0lqX/MSPsZA2CEQjnTwnVLLQVibbx5of4R+XGx58I3RBL
U97hlYa8t6WCNRkdqosdBkPjwISylA6N6XWB8uOA5z48pS16YZvdNGctznrGIFJx
kEc9K2jWvEUnGYEfaDDm2kJVzw0PfDexHa9dBXptE/vBqt9bQ0Oy934EXWMgM+Qt
Qw9FTC69hYVwPJgMh7eNwNYJrencVWzx0DHYuxobnFQMUh3zKTszqv9IJlXKh0Ab
AQgfwHzdbL5K+tXeB8OTOhtsore8eZDBsltdoWa4+B5NM/075aLtMroXCP3OLdVy
PXLCk0Rac4cqnnn9E87/sysVVVxtwRK77rkPsnTAUz0tuEet3ZcLLiBNWT58X1g5
g8lfEw3qYDsTa+f/USKmyk+IfRcKwbCIZrxlYiiOSmxG4wUiC6VcshEqxPX7EWXv
tkEYHz7THNf7ZRL8wGfSEIiLECykCQ85hX3VtW+79YIa3tKvQtFN4iMAcLHTXwTO
lT7sF5PugSpJ8qvsP/N4cSkjDKHGPE/PoemKUAojs8Vp58jlUf01tyfC8pjcGa/P
HMYaXdMVZ2NYTtnZY1Aobr/rCBxuWYAMPcc5VqdJDdA2gru5qu0=
=6Dma
-----END PGP SIGNATURE-----

--7dx74m6huo5n4ay3--

