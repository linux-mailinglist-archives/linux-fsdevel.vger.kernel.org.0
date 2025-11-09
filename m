Return-Path: <linux-fsdevel+bounces-67581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2878BC43D16
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 13:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D363AA257
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 12:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3AF2E7BCC;
	Sun,  9 Nov 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heNWA8ss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F042E401;
	Sun,  9 Nov 2025 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690076; cv=none; b=WjyIVEENnjwD8rq39ID5cDQVk7Vy/0o/bqDmmL+QFavowGJxwCPbsLgc+ozDtNhL/aKRwXLqHrA+sCFrT0MmGm5FeD6patMbYHIv38iwT7lvXipK0lwMjqLeHj0hb6PgFd8L+aTlVJHXeZejmpPr/HlcGxbGJHkKKtGW2ve9AdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690076; c=relaxed/simple;
	bh=wt8Tw4gjZkaNxNmkQRYq0c4tnrM8t3SmfvyuWifw7KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIyXqLNhZn4dEtNsNI7/2DvdJvcLS8g5r7ZXPk72rppAvX1UHW9twc+0LCGoP74oqlP+hjB5Z9M4YF2VcoUlgc6Lj3akHYGgCgTZzbCa5R1wGd85cR2J2DbW4tGHJTn90wBpaEdUwkH6k3VqUK5lNgCNn1IwXqz3fRExvDQtwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heNWA8ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D888C116B1;
	Sun,  9 Nov 2025 12:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762690075;
	bh=wt8Tw4gjZkaNxNmkQRYq0c4tnrM8t3SmfvyuWifw7KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heNWA8ssDvVMPu2hNsx+R4Okyv2M/nREqV+VPSvKtaOSrQ7YdEiyVg0wxtrKhq8hr
	 mKDRZ365+lJFHw/5zgIKjA2pEaNMh16vZfrF9tMPm6o3xib89gAxuHKRDu5mkobU5H
	 QGl0LUOMssceEqb7cE6y944DOkrdWe6OjvC+Y5/wq0+mwgz2JVuYVvARCqOvNORWti
	 yR9XluuWtZI8lnbeGxJekZH97BwhKuprtoq1TAx1stS0C/vBLJey0Q+aF9Sn/ce9HS
	 eRC0hvW6r4C6TGCI1KdFCuVWH6GMsjdFESxr/LvKrtgUFeG/9iI5qmbFFgfKAH5/YQ
	 OdiZ2La3m2plg==
Date: Sun, 9 Nov 2025 13:07:52 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-man@vger.kernel.org, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, "G. Branden Robinson" <branden@debian.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <aer4p5dc3ukmqo4ydigujtjdr5evtp6zutcyjgcnedc4eeibdn@eabfm6kibcyy>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
 <20251031152531.GP6174@frogsfrogsfrogs>
 <rg6xzjm5vw2j5ercxiihm2pdedc4brdslngiih6eknvod66oqk@tz3gue33a7fe>
 <tkh3cbnxbixmeuprlfrpfbzm5l6y6ne3i424wswd7ymspuu6as@h2hzgun5moff>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qdpvxircad6tnokw"
Content-Disposition: inline
In-Reply-To: <tkh3cbnxbixmeuprlfrpfbzm5l6y6ne3i424wswd7ymspuu6as@h2hzgun5moff>


--qdpvxircad6tnokw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-man@vger.kernel.org, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, "G. Branden Robinson" <branden@debian.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <aer4p5dc3ukmqo4ydigujtjdr5evtp6zutcyjgcnedc4eeibdn@eabfm6kibcyy>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
 <20251031152531.GP6174@frogsfrogsfrogs>
 <rg6xzjm5vw2j5ercxiihm2pdedc4brdslngiih6eknvod66oqk@tz3gue33a7fe>
 <tkh3cbnxbixmeuprlfrpfbzm5l6y6ne3i424wswd7ymspuu6as@h2hzgun5moff>
MIME-Version: 1.0
In-Reply-To: <tkh3cbnxbixmeuprlfrpfbzm5l6y6ne3i424wswd7ymspuu6as@h2hzgun5moff>

Hi Jan, Darrick, Pali,

On Mon, Nov 03, 2025 at 12:28:21PM +0100, Jan Kara wrote:
> On Sun 02-11-25 22:17:06, Alejandro Colomar wrote:
> > On Fri, Oct 31, 2025 at 08:25:31AM -0700, Darrick J. Wong wrote:
> > > On Fri, Oct 31, 2025 at 11:44:14AM +0100, Alejandro Colomar wrote:
> > > > +If the directory entry is the mount point,
> > >=20
> > > nitpicking english:
> > >=20
> > > "...is a mount point," ?
> >=20
> > I think you're right.  Unless Jan and Pali meant something more
> > specific.  Jan, Pali, can you please confirm?
>=20
> Yes, Darrick is right :).

Thanks!  I've amended the patch with that, added the Reviewed-by tags,
and pushed.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--qdpvxircad6tnokw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkQhBcACgkQ64mZXMKQ
wqnHnBAAmtz9qFn6qvmKCbIgCNEfmLZ4JSiv40ilWecl+EtrEE0EjAMfyzE6AbJY
zGiaax1RRB9ebjMR+QeZYPrOJnfMwSZufdFHfHCDOx4kSFe1ZEvt54cMZ6k5SBdL
UPjFZLmrUtaB5lQmmVntTpftLxMw8QdYR/wM6dtTDEAInBEUMqen39eAt8p5MQ1L
sueOMPjKnMdyfPnI9Bfz3lOQV/MFrnfyywn4A17VO7m5Lk9JeTEjjGWtXvrxaMIY
/pBriPIv5NK3YqCZ2qC7e7+SO/EAW26wFGzxNiwAFm3DOUAMSGW4gAQ1V/JVcQwu
0MiDKnvKKpOlu61UpsqmMihfJQoHWP8Op1AvEihhVGQpMNU3bEu7eExrocfia30n
mZnmAUBmXe4v/c30VcbFsTu47miiXv9+5QI0yxeRRsqMd1uFtrl80MsoAuGG9kSA
PO94SdCTygJ7HvOwf2QZY0ioc1wJ14QdGZAxg/NEWiCDOOFSV6YJEv7NyDMBtMxw
GdbWtgvUJWbbYkUDMfVa0CMrsiHNMApHsfvA2iEjXGlOM3a+80yYUSxtXU0mljjx
HDaSVzzcrfaZSRTmUihAXGYVFdalA7GEOLprPVBWz4DLDUMyBvIkl/Q0pJ462sgi
qpTjMwOzpkjE6B5LHVSoYNJZgHZiC3cwsv0fOZCdzO7NCea8akI=
=Atbb
-----END PGP SIGNATURE-----

--qdpvxircad6tnokw--

