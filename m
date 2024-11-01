Return-Path: <linux-fsdevel+bounces-33467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A99B9183
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01D21C21CDD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC319F131;
	Fri,  1 Nov 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ21h6SX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D22487A7;
	Fri,  1 Nov 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466460; cv=none; b=nF3s8grJYXnUkSdTjuXcYNrhHC2T/0VtBWWcCARLQkYBuYNM/e0rZU8xXvieH7YNW20Czz+8wX3ILu+4KNvSDTrCu1FqhBZp/ugcj+GlAcbv16JSO0/pOr9pfN84Zs5LXcksbqh9RJpR67JDf/HEbuzmEFY3elTnPbdwlCnj89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466460; c=relaxed/simple;
	bh=9GC6gd/VKTtyyozgny3QU95BtNXTBCGrAw1L2qaH6zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU/TQL1usw7rcu55eeoqsSzMtO/8lXzkBbY/r8ShUIvNajGpRqxaF/dXQT037yxPN/fVL5C0ZtYFVOSGrDb20hGgRqGfeXijlgtgfQO8QS/qnZaa2/+rg1b2XVvq26W0JCd4D4BaYi+jj1eHDEs8kRyEjucfdh8Q3ebwk93P+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ21h6SX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CCBC4CECD;
	Fri,  1 Nov 2024 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466459;
	bh=9GC6gd/VKTtyyozgny3QU95BtNXTBCGrAw1L2qaH6zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZ21h6SXe+A/rZoj4EyHi/WdCvSSULj+rIrIdNq3GjylI/2vkdd35x7+0ORpMihyN
	 1ISZoVSqMOA/hXJa2nw31yU0JptSiysjMVRi2krZdD2ZBgiEI1VDXQPLWefOrHvWbQ
	 dmMOb8DA7hO91xxqQ0ScUzQ9xVzJCX00IR7YzU5BR3P/OGKeIx8C4yXfD20TnYXc8D
	 yt1MVh/CtosfoopEDAoTISReRcZgf1O3HlCuWMPn9RvbcNWWdkZQ4/IuLmohmwRPvp
	 AAMqynU97O1Vajzfq4UgWJ0ylXMfbrtluZWnGB8fCXSuamR5+6iXXc9jt/OulVbjdF
	 NI8BmiGE7o9xw==
Date: Fri, 1 Nov 2024 14:07:32 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Alejandro Colomar <alx.manpages@gmail.com>,
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify.7,fanotify_mark.2: update documentation of
 fanotify w.r.t fsid
Message-ID: <20241101130732.xzpottv5ru63w4wd@devuan>
References: <20241008094503.368923-1-amir73il@gmail.com>
 <20241009153836.xkuzuei2gxeh2ghj@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d723bfrsts26vlyf"
Content-Disposition: inline
In-Reply-To: <20241009153836.xkuzuei2gxeh2ghj@quack3>


--d723bfrsts26vlyf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fanotify.7,fanotify_mark.2: update documentation of
 fanotify w.r.t fsid
MIME-Version: 1.0

Hi Amir, Jan,

On Wed, Oct 09, 2024 at 05:38:36PM +0200, Jan Kara wrote:
> On Tue 08-10-24 11:45:03, Amir Goldstein wrote:
> > Clarify the conditions for getting the -EXDEV and -ENODEV errors.
> >=20
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>=20
> Looks good. Feel free to add:

Please see some minor inline comments below.

> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!

>=20
> But I've read somewhere that Alejandro stepped down as manpages maintainer
> so they are officially unmaintained?

A contract is imminent, and I've started to review/apply old patches
today already.  I'll probably make an official announcement soon.
Maintenance is restored.  (As much as I possibly can, since my region
has limited electricity, water, and internet, after the worst flooding
in centuries.)

Have a lovely day!
Alex

>=20
> 								Honza
>=20
> > Hi Alejandro,
> >=20
> > This is a followup on fanotify changes from v6.8
> > that are forgot to follow up on at the time.
> >=20
> > Thanks,
> > Amir.
> >=20
> >  man/man2/fanotify_mark.2 | 27 +++++++++++++++++++++------
> >  man/man7/fanotify.7      | 10 ++++++++++
> >  2 files changed, 31 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> > index fc9b83459..b5e091c25 100644
> > --- a/man/man2/fanotify_mark.2
> > +++ b/man/man2/fanotify_mark.2
> > @@ -659,17 +659,16 @@ The filesystem object indicated by
> >  .I dirfd
> >  and
> >  .I pathname
> > -is not associated with a filesystem that supports
> > +is associated with a filesystem that reports zero
> >  .I fsid
> >  (e.g.,
> >  .BR fuse (4)).
> > -.BR tmpfs (5)
> > -did not support
> > -.I fsid
> > -prior to Linux 5.13.
> > -.\" commit 59cda49ecf6c9a32fae4942420701b6e087204f6
> >  This error can be returned only with an fanotify group that identifies
> >  filesystem objects by file handles.
> > +Since Linux 6.8,
> > +.\" commit 30ad1938326bf9303ca38090339d948975a626f5
> > +this error can be returned only when

I think "when" is more appropriate in the following line.  It also adds
some consistency with the rest of the patch below (@@762).

> > +trying to add a mount or filesystem mark.
> >  .TP
> >  .B ENOENT
> >  The filesystem object indicated by
> > @@ -768,6 +767,22 @@ which uses a different
> >  than its root superblock.
> >  This error can be returned only with an fanotify group that identifies
> >  filesystem objects by file handles.
> > +Since Linux 6.8,
> > +.\" commit 30ad1938326bf9303ca38090339d948975a626f5
> > +this error will be returned
> > +when trying to add a mount or filesystem mark on a subvolume,
> > +when trying to add inode marks in different subvolumes,
> > +or when trying to add inode marks in a
> > +.BR btrfs (5)
> > +subvolume and in another filesystem.
> > +Since Linux 6.8,
> > +.\" commit 30ad1938326bf9303ca38090339d948975a626f5
> > +this error will also be returned
> > +when trying to add marks in different filesystems,
> > +where one of the filesystems reports zero
> > +.I fsid
> > +(e.g.,
> > +.BR fuse (4)).
> >  .SH STANDARDS
> >  Linux.
> >  .SH HISTORY
> > diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> > index 449af949c..db8fe6c00 100644
> > --- a/man/man7/fanotify.7
> > +++ b/man/man7/fanotify.7
> > @@ -575,6 +575,16 @@ and contains the same value as
> >  .I f_fsid
> >  when calling
> >  .BR statfs (2).
> > +Note that some filesystems (e.g.,
> > +.BR fuse (4))
> > +report zero
> > +.IR fsid .
> > +In these cases, it is not possible to use

Please break the line after the comma.

> > +.I fsid
> > +to associate the event with a specific filesystem instance,
> > +so monitoring different filesystem instances that report zero
> > +.I fsid
> > +with the same fanotify group is not supported.
> >  .TP
> >  .I handle
> >  This field contains a variable-length structure of type
> > --=20
> > 2.34.1
> >=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--=20
<https://www.alejandro-colomar.es/>

--d723bfrsts26vlyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmck0pQACgkQnowa+77/
2zI8yA//T5mqLzgVU/dnY2C22HqDHNCPq2c2rJtzT3Qg7Z7awurqMgkkC3b12vjp
8UbnYC0ohRV4j3TCemTnu9WNExRlezNfJW/nwFHCWdunDycRtFfvQign9vNZhUuB
k7jrMmnVcEzxkobSSb5hUt6qI/mO76ZNHw4loHPP7xZPJ+pmRwbwG3AEuDW1KOwZ
MfXafSyhTe7ScSaFZU10vJ/UObX6Db5RDg0rsnka4Egkkjc6PFQSLtwpCqdNnXiG
GNVwXOldT/dug1m1bzHftcGkaXakQqTfFywBt/3apXTS6gSj9MIcHv1Hd72KzveE
TmMM9gbxleuPmp/55LerFECtCUWqqJ3/DpCcwIXHJZdDiyvYBoCJPzs4tjE19NnG
ATofsqhcs91VhtsJYwGZFaF+inkNgrK9QWJQhPC4Fo3q8b4jJ61lUyzogvCYaB+Q
bvZadubYKVcM+rP6Otv6GHTAVf/Vaq6Jq1M2qXwuXbkfElVgdqwbEFjezdGHep21
6Ey4SF3lpxoiR32a/giGlFF/UaB/U4j5YlgQeH1VHZUqTJ2jO6q8t2Xe3a67gzs0
bxNXUSoGRreM9WlovCrEUOa8x32O7WTj2gGgajiNG6rVjIBUOSvsVYWUYDUmFiOP
/kWXostURUJfZgEEtrIWm5ecXWi6HO7l9Q90DB7iqvg8mbVxb3s=
=pwcC
-----END PGP SIGNATURE-----

--d723bfrsts26vlyf--

