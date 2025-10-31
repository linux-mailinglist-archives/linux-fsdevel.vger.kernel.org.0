Return-Path: <linux-fsdevel+bounces-66578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718A8C24CA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 12:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3C74604FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493F345CCA;
	Fri, 31 Oct 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO75K7MR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71F31AF2D;
	Fri, 31 Oct 2025 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910304; cv=none; b=DwHlKZyRP997e9gzzT8xmKRxi5wIFvngoBHR+uEaCv5HUWzmPXbUbaAj6kLkoo7OKJiyQH1ZGqrPcwtHwbQEJIo7SRrKRWWo9e2VCb77ue+LWgv4sC/qxxnk2oqB/nErrMzTFcgrs2CwbVuK+p1/yz4TrU2iYf0FjijVWwXIMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910304; c=relaxed/simple;
	bh=RrFc9m8U1+DkdwSvhGhBjVDNCLowsbK6hLVnLKExON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUuBc0nz61N8o31/zAPNGdggKfcsgSDgkKDZVR6hdivOs0sqtEniAg1T1Y/G6o2g2tN95dkH9AaPOzVm7fxWkGKXvGG2BaqkHzFlhY8sOLhGjSfiJQU7ODpY8Fju75rfRMyv2k22JGK+Ke1V9NXhMN96AdQ/KalCQO9HC5Q+md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO75K7MR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334EBC4CEE7;
	Fri, 31 Oct 2025 11:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761910304;
	bh=RrFc9m8U1+DkdwSvhGhBjVDNCLowsbK6hLVnLKExON4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GO75K7MR6LX4xkI4dhqffOzIYW0xMYeuMKcPRxAMcNXNXDr183QjEco8/NECQUSLI
	 9nOIB7Q+qvB0nC/FdweNNAPFCUA6Pa/21/Ie0Uyuvy1ic1w4ZNGi/HzXII2za4UCef
	 kWvELsxfctVLSO1NV0wH+NuBX6mjLNdOjdoV+8NltF36A1vUtNoowlQU3eLe0Kmc6y
	 WLZmiKiHrUM6pH7ebx0NDX7qMhHAnvo/3FquYMn5CUjI7vAuR0o0ewcnEmjypuQPFI
	 +4u4rlXxpDPZurs+sD0D0Xb83bkyARagZjcjrGxj2GuQ2Tn98iDZ/9plh/1hY9b3fq
	 qEDfzyMn25KQQ==
Date: Fri, 31 Oct 2025 12:31:41 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-man@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	"G. Branden Robinson" <branden@debian.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <grzxwjrxlneaus735jhwh2buo2nvmj2c4iospzmh7rcfs5czel@qjlb5czusc52>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
 <75ug4vsltx6tiwmt7m4rquh7uxsbpqqgopxjj7ethfkkdsmt7v@ycgd272ybqto>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fopat4jgf2mnktsh"
Content-Disposition: inline
In-Reply-To: <75ug4vsltx6tiwmt7m4rquh7uxsbpqqgopxjj7ethfkkdsmt7v@ycgd272ybqto>


--fopat4jgf2mnktsh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-man@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	"G. Branden Robinson" <branden@debian.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <grzxwjrxlneaus735jhwh2buo2nvmj2c4iospzmh7rcfs5czel@qjlb5czusc52>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
 <75ug4vsltx6tiwmt7m4rquh7uxsbpqqgopxjj7ethfkkdsmt7v@ycgd272ybqto>
MIME-Version: 1.0
In-Reply-To: <75ug4vsltx6tiwmt7m4rquh7uxsbpqqgopxjj7ethfkkdsmt7v@ycgd272ybqto>

Hi Jan, Pali,

On Fri, Oct 31, 2025 at 11:56:19AM +0100, Jan Kara wrote:
> On Fri 31-10-25 11:44:14, Alejandro Colomar wrote:
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
>=20
> Thanks! The patch looks good. Feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!

Pali, would you mind signing the patch?  One you do, I'll merge.


Cheers,
Alex

>=20
> 								Honza
>=20
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
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--fopat4jgf2mnktsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkEnhwACgkQ64mZXMKQ
wqkEsQ//Q3Bu8c05Wpq3cyQM+EbEb0GHKL3Xxv/cH3f2OTP+hg94NQUxZS5pfd2K
4+pMS3enau1W/2xSnTnQEj4Yn1LOJJzAodXp6R8Su5m2wf9vdvvI4sbE+dBzRsVE
GMvv79gFchUjCM194H+m/ExT1Ff6F/AiZeq8qRiPq4yDRAsIS7dp+9E3tFyzaT7S
8LGjq82OI2Maks32LHrIqrJ4DFv/B9vInBs2JYn5ZtCVjarebStJnAvvbPmZpt8a
vAh+pvphvpxb8F3ZOuChWPzR9QHlNkX31fkpaFQ2sggdZywLz0+TZ2XRg3dDu+kB
8yrztyL3Wr5cFNF/+rgWAXF7NDWIQMvQ/0UBBb3u1y+xUG+qLxEtoW6HZRKVyqQp
uBiGfTgc6mnZmTP4a4STRPjAvUQ54OZzSH8TmbSIuh+ywWFGfuYh6S4pplKFX24x
ZOFcT+sL3Rho6tppHmSEEm/ZLfs7WqeXx6Y0MZbzrJ4wSU90zXwGSs3ZfvkLts97
X61x5J5vR9WNxPMmSEIOc2fDkbteKmUxozhJp6XmM5a9gb1kfZjWBWAS4UShJfO+
rbTn8vffqd43Fg9tuxn//FRc0mpcCM5G2E/E0GDPM4TknPhgFVDPpZGD6P1cP4fC
X+MtbPFp/H+R8rTdG7aF1f/zU3gWLNBQZzNAzNs/qUvBuImprxA=
=ZRWB
-----END PGP SIGNATURE-----

--fopat4jgf2mnktsh--

