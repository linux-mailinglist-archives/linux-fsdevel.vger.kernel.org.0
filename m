Return-Path: <linux-fsdevel+bounces-63197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F92BB1706
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 20:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BF93A8B13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D92D3EE0;
	Wed,  1 Oct 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVZi2/iO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB51258EF0;
	Wed,  1 Oct 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341741; cv=none; b=n+C86GDaNlSClj+kcokFHUR3BFZesZbn/PChgozQQGjctqBbTB0xWbsO0QM6ApHb7uCxENQ10EIOvQioJmiuujLylda8jajgL1Aem8ZnkMk+vl1hEnDiMR0gvmNrYypPR5IUmTDG1b4AkhbdY9dVVJZovb34B8waW8nBzEKkBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341741; c=relaxed/simple;
	bh=+4Me4BxSNkEfQoSLvp5i2e5DL8lW97v/MeE2adVD+6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewc5H0sFuFDwAkH3v9fhdOseBJOjEtKbRC5UbgGpyhKNyF5cOq5U+nY8jq79d4N9XAIb1nzHMvSRdo+7BxLpKqUV7hm7J/bMzmZyAIdvCRHiSHKeIQy2ywL41B8YQ7erysczyRhI/qUljNoeDT9zNC4zqO/Ke0oIPHypJkf4ytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVZi2/iO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45A3C4CEF1;
	Wed,  1 Oct 2025 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759341741;
	bh=+4Me4BxSNkEfQoSLvp5i2e5DL8lW97v/MeE2adVD+6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVZi2/iOWlLlql9b1mBipGNAG68Aqo3X4lSI8qvxKN+SPHJ+ZxN0+ZJC5V4bBZak5
	 muk6GIkAbKPPw31dlESVhZaLXgQoenKFlvgUxGUQbisoJacAZGLzXTa/Dz4WPqCc91
	 1W6x3jktFY6Jc0s0uEOcp+jn2Gbn1pA5nt1+z0vvSkBGiAA/q+M9QWDpXqThh0H83U
	 aI27UCU/znvv2Ar/p7t5SAziDR2cN6/TQmTOq1hULoaScl9j/k5PD7uTZNQsbu5+/r
	 4OkbhLP1JwjOIReaUvV7s9drmrnwFeHAEMCIy+rtiHuU3Xr4HtGOkSyH13dScBjb32
	 RP9jlwpZlBkrw==
Date: Wed, 1 Oct 2025 20:02:16 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, 
	dhowells@redhat.com, g.branden.robinson@gmail.com, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <5ukckeqipdkz6aigdy7rmtsmy5zav5x4rw2hrgbxiwfflrcmgb@jy7yr34cwyat>
References: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
 <20251001003841.510494-1-safinaskar@gmail.com>
 <2025-10-01-brawny-bronze-taste-mounds-zp8G2b@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="67r6dfiqg2gtq4zd"
Content-Disposition: inline
In-Reply-To: <2025-10-01-brawny-bronze-taste-mounds-zp8G2b@cyphar.com>


--67r6dfiqg2gtq4zd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, 
	dhowells@redhat.com, g.branden.robinson@gmail.com, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <5ukckeqipdkz6aigdy7rmtsmy5zav5x4rw2hrgbxiwfflrcmgb@jy7yr34cwyat>
References: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
 <20251001003841.510494-1-safinaskar@gmail.com>
 <2025-10-01-brawny-bronze-taste-mounds-zp8G2b@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-10-01-brawny-bronze-taste-mounds-zp8G2b@cyphar.com>

Hi Aleksa,

On Wed, Oct 01, 2025 at 05:35:45PM +1000, Aleksa Sarai wrote:
> On 2025-10-01, Askar Safin <safinaskar@gmail.com> wrote:
> > Aleksa Sarai <cyphar@cyphar.com>:
> > > +mntfd2 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > > +                   &attr, sizeof(attr));
> >=20
> > Your whole so-called "open_tree_attr example" doesn't contain any open_=
tree_attr
> > calls. :)
> >=20
> > I think you meant open_tree_attr here.
>=20
> Oops.
>=20
> >=20
> > > +\&
> > > +/* Create a new copy with the id-mapping cleared */
> > > +memset(&attr, 0, sizeof(attr));
> > > +attr.attr_clr =3D MOUNT_ATTR_IDMAP;
> > > +mntfd3 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > > +                   &attr, sizeof(attr));
> >=20
> > And here.
>=20
> Oops x2.
>=20
> > Otherwise your whole patchset looks good. Add to whole patchset:
> > Reviewed-by: Askar Safin <safinaskar@gmail.com>

I've applied the patch, with the following amendment:

	diff --git i/man/man2/open_tree.2 w/man/man2/open_tree.2
	index 8b48f3b78..f6f2fbecd 100644
	--- i/man/man2/open_tree.2
	+++ w/man/man2/open_tree.2
	@@ -683,14 +683,14 @@ .SS open_tree_attr()
	 .\" Using .attr_clr is not strictly necessary but makes the intent cleare=
r.
	 attr.attr_set =3D MOUNT_ATTR_IDMAP;
	 attr.userns_fd =3D nsfd2;
	-mntfd2 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
	-                   &attr, sizeof(attr));
	+mntfd2 =3D open_tree_attr(mntfd1, "", OPEN_TREE_CLONE,
	+                        &attr, sizeof(attr));
	 \&
	 /* Create a new copy with the id-mapping cleared */
	 memset(&attr, 0, sizeof(attr));
	 attr.attr_clr =3D MOUNT_ATTR_IDMAP;
	-mntfd3 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
	-                   &attr, sizeof(attr));
	+mntfd3 =3D open_tree_attr(mntfd1, "", OPEN_TREE_CLONE,
	+                        &attr, sizeof(attr));
	 .EE
	 .in
	 .P


(Hopefully I got it right.)


Cheers,
Alex

>=20
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--67r6dfiqg2gtq4zd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjdbKcACgkQ64mZXMKQ
wqlMiQ/9EykJJBkUIdFwo1qmdB5bkx84veu9BT1YydFqhzkaPbTYrR2wo9AVPrNl
MNixrSBXH4geyrDmYtZGa1WRLDyB8aQ6Nl5QYjojKIkz9ziCV9hRLsNh8yYK+HtN
Xck0IM2oK3Ze21RqusRV2wiPr9liTJ/G01zJzOBWPy0BcbQW872ymsR1rpRzAMM9
34QeHdfnESkxd+3P//0B5yqVI91TXMBg1b0XxZlhdYfy7VyQ5TQjJk6F4bZymegt
pvfRSEWEpcrd66S3e6yGnDzQDlSpIeXr9UkZqLq5r5UsRss4QHPc8a/N9jJ7nhmb
U2itqIRMtThWgyZDZLetLW2IGVzTKP36a7ArCnx7djQd0LUMhXLArFSbYEtC2Co5
DqiiB4N0nQlUZnn8ClR5znIOstyjdmYf7pi2CURkuEfrYIJHlJ5C7PKo09wUni3H
MLaDczci3MG9oearRWOCGTSmOWjVMYLh6A4yXT+8nYsVsNXM9ZktC6iiKODKXcge
9PTdL9kQpGYQAsvHMKK73/4dpmClAuz2ogvoXiooO/E9NTZb+vSv3rL0hFWEiDzz
VQcNi9wp6OTlgKBLpcURrZYQf59EcdwKvA8AmvdSYP1zGis6ox5PoRvM0Bbqxqbw
9Ftw2ay6PLRmIgdwh5uoYv8GYPEqIg9S6ziS2Tf9znnZh7suEPY=
=4285
-----END PGP SIGNATURE-----

--67r6dfiqg2gtq4zd--

