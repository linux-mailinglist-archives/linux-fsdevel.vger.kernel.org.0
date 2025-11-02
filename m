Return-Path: <linux-fsdevel+bounces-66695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D8C2970F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 22:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57939188573D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 21:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5B1B81CA;
	Sun,  2 Nov 2025 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq0gfnAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0DF9EC;
	Sun,  2 Nov 2025 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762118230; cv=none; b=X1x8ibqXM62KKnjio0T79lIEn4dZzs5YgmyEPrrjEZ1MmmjjlzApqXVvsk/ed89Uf9m3cKKCkGcbhdgoCfdd+/3vyHoUgtTzIr7NI1HNGd7vH3BRJrlUggIka4OmYhadgel2MBl7Hw+kJ/8m1MfaSWhCJN/QgGgIIKA+AuiCaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762118230; c=relaxed/simple;
	bh=BKCdI+ztTOKrqKa8UA0OoO1P2J4kXXR7fFaSPlcf35U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbpdbQUJqbbxTHgUjToNYamiNSUedtJDMLzy6zR6vNQbYhVSJXjxndLFeXRefEMKQ30IRf+uvHg5uVIs+NhP/6B5MP4sDJF5klXd2QQBPugqOEHl6X+Sqs6z97XkESZ7+dkcsRuECi6AW9cUqUxjb2C9wrTAMMbpIalr55UfhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq0gfnAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E183EC4CEF7;
	Sun,  2 Nov 2025 21:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762118230;
	bh=BKCdI+ztTOKrqKa8UA0OoO1P2J4kXXR7fFaSPlcf35U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gq0gfnAW6IBETj0SpCCVkT57FYlT5l/XOEm/rDznJo5C3OMRiVT6DIqp+7c71lZA7
	 l2yi4HQFFltOF0bMyFfUyr4nCdaO+VLBWL8r71LxZxtV6pkD7f9Z5+rqeBG+BicYzK
	 fTL8Dc/IE8XXwdDLgvfiSHneAtK+Yo+KikzQP65jf4Nj5fs3yTPEPosLTCx40cd77y
	 rDZr4i0pQMJs/p0W6p+PoCD585NioiwgtIgYD/ACTVbis6o01Oq0jbr6Qg6C4eq0ht
	 zEWYYZoVj99BdwAuGkiQCKi8z6QWLKaywJ6Zs3MaRL3Ly6xS8yIgcF2zopiSoRBlfQ
	 qxoslSDieZPHg==
Date: Sun, 2 Nov 2025 22:17:06 +0100
From: Alejandro Colomar <alx@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-man@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <branden@debian.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <rg6xzjm5vw2j5ercxiihm2pdedc4brdslngiih6eknvod66oqk@tz3gue33a7fe>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
 <20251031152531.GP6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5uzgnrk5hx34kj4n"
Content-Disposition: inline
In-Reply-To: <20251031152531.GP6174@frogsfrogsfrogs>


--5uzgnrk5hx34kj4n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-man@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <branden@debian.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <rg6xzjm5vw2j5ercxiihm2pdedc4brdslngiih6eknvod66oqk@tz3gue33a7fe>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
 <20251031152531.GP6174@frogsfrogsfrogs>
MIME-Version: 1.0
In-Reply-To: <20251031152531.GP6174@frogsfrogsfrogs>

Hi Darrick,

On Fri, Oct 31, 2025 at 08:25:31AM -0700, Darrick J. Wong wrote:
> On Fri, Oct 31, 2025 at 11:44:14AM +0100, Alejandro Colomar wrote:
> > Suggested-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Co-authored-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Co-authored-by: Jan Kara <jack@suse.cz>
> > Cc: "G. Branden Robinson" <branden@debian.org>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >=20
> > Hi Jan,
> >=20
> > I've put your suggestions into the patch.  I've also removed the
> > sentence about POSIX, as Pali discussed with Branden.
> >=20
> > At the bottom of the email is the range-diff against the previous
> > version.
> >=20
> >=20
> > Have a lovely day!
> > Alex
> >=20
> >  man/man3/readdir.3      | 19 ++++++++++++++++++-
> >  man/man3type/stat.3type | 20 +++++++++++++++++++-
> >  2 files changed, 37 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/man/man3/readdir.3 b/man/man3/readdir.3
> > index e1c7d2a6a..220643795 100644
> > --- a/man/man3/readdir.3
> > +++ b/man/man3/readdir.3
> > @@ -58,7 +58,24 @@ .SH DESCRIPTION
> >  structure are as follows:
> >  .TP
> >  .I .d_ino
> > -This is the inode number of the file.
> > +This is the inode number of the file
> > +in the filesystem containing
> > +the directory on which
> > +.BR readdir ()
> > +was called.
> > +If the directory entry is the mount point,
>=20
> nitpicking english:
>=20
> "...is a mount point," ?

I think you're right.  Unless Jan and Pali meant something more
specific.  Jan, Pali, can you please confirm?


Have a lovely night!
Alex

>=20
> --D
>=20
> > +then
> > +.I .d_ino
> > +differs from
> > +.I .st_ino
> > +returned by
> > +.BR stat (2)
> > +on this file:
> > +.I .d_ino
> > +is the inode number of the mount point,
> > +while
> > +.I .st_ino
> > +is the inode number of the root directory of the mounted filesystem.
> >  .TP
> >  .I .d_off
> >  The value returned in
> > diff --git a/man/man3type/stat.3type b/man/man3type/stat.3type
> > index 76ee3765d..ea9acc5ec 100644
> > --- a/man/man3type/stat.3type
> > +++ b/man/man3type/stat.3type
> > @@ -66,7 +66,25 @@ .SH DESCRIPTION
> >  macros may be useful to decompose the device ID in this field.)
> >  .TP
> >  .I .st_ino
> > -This field contains the file's inode number.
> > +This field contains the file's inode number
> > +in the filesystem on
> > +.IR .st_dev .
> > +If
> > +.BR stat (2)
> > +was called on the mount point,
> > +then
> > +.I .st_ino
> > +differs from
> > +.I .d_ino
> > +returned by
> > +.BR readdir (3)
> > +for the corresponding directory entry in the parent directory.
> > +In this case,
> > +.I .st_ino
> > +is the inode number of the root directory of the mounted filesystem,
> > +while
> > +.I .d_ino
> > +is the inode number of the mount point in the parent filesystem.
> >  .TP
> >  .I .st_mode
> >  This field contains the file type and mode.
> >=20
> > Range-diff against v2:
> > 1:  d3eeebe81 ! 1:  bfa7e72ea man/man3/readdir.3, man/man3type/stat.3ty=
pe: Improve documentation about .d_ino and .st_ino
> >     @@ Commit message
> >     =20
> >          Suggested-by: Pali Roh=C3=A1r <pali@kernel.org>
> >          Co-authored-by: Pali Roh=C3=A1r <pali@kernel.org>
> >     +    Co-authored-by: Jan Kara <jack@suse.cz>
> >          Cc: "G. Branden Robinson" <branden@debian.org>
> >          Cc: <linux-fsdevel@vger.kernel.org>
> >          Signed-off-by: Alejandro Colomar <alx@kernel.org>
> >     @@ man/man3/readdir.3: .SH DESCRIPTION
> >       .TP
> >       .I .d_ino
> >      -This is the inode number of the file.
> >     -+This is the inode number of the file,
> >     -+which belongs to the filesystem
> >     -+.I .st_dev
> >     -+(see
> >     -+.BR stat (3type))
> >     -+of the directory on which
> >     ++This is the inode number of the file
> >     ++in the filesystem containing
> >     ++the directory on which
> >      +.BR readdir ()
> >      +was called.
> >      +If the directory entry is the mount point,
> >      +then
> >      +.I .d_ino
> >      +differs from
> >     -+.IR .st_ino :
> >     ++.I .st_ino
> >     ++returned by
> >     ++.BR stat (2)
> >     ++on this file:
> >      +.I .d_ino
> >     -+is the inode number of the underlying mount point,
> >     ++is the inode number of the mount point,
> >      +while
> >      +.I .st_ino
> >     -+is the inode number of the mounted file system.
> >     -+According to POSIX,
> >     -+this Linux behavior is considered to be a bug,
> >     -+but is nevertheless conforming.
> >     ++is the inode number of the root directory of the mounted filesyst=
em.
> >       .TP
> >       .I .d_off
> >       The value returned in
> >     @@ man/man3type/stat.3type: .SH DESCRIPTION
> >       .TP
> >       .I .st_ino
> >      -This field contains the file's inode number.
> >     -+This field contains the file's inode number,
> >     -+which belongs to the
> >     ++This field contains the file's inode number
> >     ++in the filesystem on
> >      +.IR .st_dev .
> >      +If
> >      +.BR stat (2)
> >      +was called on the mount point,
> >      +then
> >     -+.I .d_ino
> >     -+differs from
> >     -+.IR .st_ino :
> >     -+.I .d_ino
> >     -+is the inode number of the underlying mount point,
> >     -+while
> >      +.I .st_ino
> >     -+is the inode number of the mounted file system.
> >     ++differs from
> >     ++.I .d_ino
> >     ++returned by
> >     ++.BR readdir (3)
> >     ++for the corresponding directory entry in the parent directory.
> >     ++In this case,
> >     ++.I .st_ino
> >     ++is the inode number of the root directory of the mounted filesyst=
em,
> >     ++while
> >     ++.I .d_ino
> >     ++is the inode number of the mount point in the parent filesystem.
> >       .TP
> >       .I .st_mode
> >       This field contains the file type and mode.
> >=20
> > base-commit: f305f7647d5cf62e7e764fb7a25c4926160c594f
> > --=20
> > 2.51.0
> >=20
> >=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--5uzgnrk5hx34kj4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkHykwACgkQ64mZXMKQ
wqm5Yg/9FR4cDG97II4L0r6WDI3L37TyezmMozbxb482rBS0waeVo65b1Ky5DM4K
OHIUQ+05v7K8Ww/ui4gzefDsRE5b369L/6L/iQW2QqLEWDw3pH1dlccLkwgKfiLq
1adZLFtyHc4HjCMeRdtugb1O0WAYcf0dzLb/eeff8P2UozJW4m9gsp+qnhEXwEq6
TvfKa163IbsoNXrcujHA2qrwC28fE5xd2vy56bAji5aPh50B/jIyXK/RID/J1Oms
6TNE878wWg6I2j1lWq6mH93CueNVph4mRn5+dp3p6kZeD13MzFWRO2YWi1n9iXAk
nKRJ2XW4+b4AK4sHgIUvsJh2WXXt93FvjQ6Qh3K4whrQ0FtftiTJmSNaSi2TQ5rJ
t3zTV9gRXFL3oF5znRCZEfP6gsXKXN5s942WVypgfibbrn7FmA2ZPH/cpX1OOG6z
K5BKuFcyncRKW9fuuvOz1ChTX7dip6zbxxkf+n4vUVml3TLvZ1G53ODHc/y/tMey
SW/alSlLaUACF728edvrwojHs1qFC88LEGuGGkmYbN9/uyYWqZaI7GSJmtFsfQvc
DmUebX3kfi8oO2//lZ7c3tIADxS8fu4XiZVYpvXWpq3/kNFbTwZ17jpzdHUBPyYq
qkiLysHt/fvUAl/PpbPd7gHAJMgDahtSTAnq5tgespH9+v1/jiU=
=xZ5p
-----END PGP SIGNATURE-----

--5uzgnrk5hx34kj4n--

