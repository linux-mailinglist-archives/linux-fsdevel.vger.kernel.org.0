Return-Path: <linux-fsdevel+bounces-63145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F0BAF47A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 08:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E3D2A1D10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 06:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A423BD02;
	Wed,  1 Oct 2025 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNWtR0hK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9F1E51D;
	Wed,  1 Oct 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301146; cv=none; b=ZpxF4Dqe5ztzEUcjxRW7/pU1mg+FD8AFKIcc+Snn3lXdOob9CH/ZWrfBlGOLFSThEF+Xy2nWMCYA8s4eAFeRjjGzeINj4k1WYoNMlzAe+46Cbazru52SXojI8/UdmGpwL3l3IxCe8mz8gkoOqhTO0erpgUQ48+uWCZBbFIqhlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301146; c=relaxed/simple;
	bh=S3BBcYbHKl5+u2lBNg/DeL95jsSme/g+zCYH0vYca60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcX5opF51cxLCkIpg0YaFM4a5DRv0L+0h2mBaPJT/FX2MeusKYIb7gju4dv4jeI9JahgvxVr2i5bLByT5IJXpBKkbtGWFz8bNlvAZx3pWTOzb/t3TGDZps7mod1fJQ5DvXMyqzkGo7wflyFROcVHO0yhSZKXtx7gIVAj82I6yXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNWtR0hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47337C4CEF4;
	Wed,  1 Oct 2025 06:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759301145;
	bh=S3BBcYbHKl5+u2lBNg/DeL95jsSme/g+zCYH0vYca60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNWtR0hK0BKb5ys12O9iBwDqIe/9D/MRS8XILtSLBld4BKn96AYg9gZUoY7d+gXX0
	 BF3pl2RDK3wb1/4WKglQrsRuITwRH3z540jXc1xaZMjfIuixbbVtxF+fRNozrccOKJ
	 mD+0pn+G5Jf8EVGMX3dtDgT+QfAKe3dYgwgEOinrKV3KeFfdxlbTaHR5H8vCHuRfcC
	 ZAoVS0yacqrtKEX49FzIVu8fBcuarS2wKdB9Y8wfNGLNQpiIZNoUuOLKNWcBDIHYo5
	 zmGi76LH/Ycx8d+YJIOLjFnEvmF3om04yRrFoSwtjWftkIwxq8Kf+CEkPYGx8Dm1gL
	 bwRdoO2nyuJxw==
Date: Wed, 1 Oct 2025 08:45:40 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: cyphar@cyphar.com, brauner@kernel.org, dhowells@redhat.com, 
	g.branden.robinson@gmail.com, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, 
	mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <ugko3x7tuqrmbyb326aw3dvtvmdozvtps6hc6ff3lmtsijoube@aem2acyk6t2q>
References: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
 <20251001003841.510494-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xmhs745kvpjmwrei"
Content-Disposition: inline
In-Reply-To: <20251001003841.510494-1-safinaskar@gmail.com>


--xmhs745kvpjmwrei
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: cyphar@cyphar.com, brauner@kernel.org, dhowells@redhat.com, 
	g.branden.robinson@gmail.com, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, 
	mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <ugko3x7tuqrmbyb326aw3dvtvmdozvtps6hc6ff3lmtsijoube@aem2acyk6t2q>
References: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
 <20251001003841.510494-1-safinaskar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20251001003841.510494-1-safinaskar@gmail.com>

Hi Askar,

On Wed, Oct 01, 2025 at 03:38:41AM +0300, Askar Safin wrote:
> Aleksa Sarai <cyphar@cyphar.com>:
> > +mntfd2 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > +                   &attr, sizeof(attr));
>=20
> Your whole so-called "open_tree_attr example" doesn't contain any open_tr=
ee_attr
> calls. :)
>=20
> I think you meant open_tree_attr here.

I'll wait for Aleksa to confirm before applying and amending.

> > +\&
> > +/* Create a new copy with the id-mapping cleared */
> > +memset(&attr, 0, sizeof(attr));
> > +attr.attr_clr =3D MOUNT_ATTR_IDMAP;
> > +mntfd3 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > +                   &attr, sizeof(attr));
>=20
> And here.
>=20
> Otherwise your whole patchset looks good. Add to whole patchset:
> Reviewed-by: Askar Safin <safinaskar@gmail.com>

Thanks!  I'll retro-fit that to the commits I've aplied already too, as
I haven't pushed them to master yet.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--xmhs745kvpjmwrei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjczg0ACgkQ64mZXMKQ
wqkQOxAAhBW2r6vgnhWSIcUgonkPBEki5gwvsq/37mKGIdH8p/5DDSaD/1165e62
WnB/LE5dv+m6Qs79kKzswijiXv1sHyr3MmzDUhwq8P73+DrHbVJgKLBoFZIv8j+E
YGbN7ZWT+/JbbpO3/tfoHRvfKZ4mbl5GXpu2VZBgD03+tAW1nzDrmoUwfscVgnGI
USH40XEEAt1+OVwwHBWXyi+S/Pqml/RRmlKH3WXFVwnI+NoUHKKg6OYX7fKMuvr0
HM2XZiemIrGuDHuXr1GA+U+dIVHQTk/6bFiad35lqAHwXWaZ6FodFF8+aUCOd06K
Ao4Ay2foi9nsam3ZzEdwLS866z0Pv3sHshjmd+ALkfw9yEA8E9dGdLtpSX4PKbeD
evKEZXhAXjGH+87oq+YnmsJ06qpM/wFYr1v1hmlo0SyfO2HYCusJU9MX2RRPye/S
hQlRivZ29QvWOegQSRcOIolacow/Ol2wuPnxyLfUNywjO4dIwrec3PY4K1FMPGnb
zITkySWMg4zEkxpzjD6+vh/TIuiKthKqV5AmPsGwlsU5qjzFE/wdIpuWED0fU9Rh
9MK/cQu5x/6Z54t8RY7LaEtpW/krRY5uBgv4C6w2hDBtMTYLgQ0ecWKZZNiwFqfI
hcDDbrYxvKV9gG0IkVtGk7DneDJ47+cxo/djy6cH1FPR7QVvC2E=
=EEI7
-----END PGP SIGNATURE-----

--xmhs745kvpjmwrei--

