Return-Path: <linux-fsdevel+bounces-49996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E29CAC71DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF2D189FD10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819EE21FF53;
	Wed, 28 May 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5WtuO9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE681E8332;
	Wed, 28 May 2025 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748462389; cv=none; b=KwLvSaRJCA+tTgR/KuGAslCrFcmGj9nnmwzexU8b32HHde8VirFGjcFfN0/SqE+hxkJPnjYmRrSC+eFaVumBn5BMq7ivmEAT8zjY/FFxqacojGWrRT+AVd6HK00kM/16RHg+rtl1R+gWP0X6mNEz7jCKyOd09YvXk5sr94YQCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748462389; c=relaxed/simple;
	bh=XM3HtVTsglbbTTpWN88/VKWviJFPe6GUo06vUJU5+Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqIYI9LTfGedTnMX3NT+Yi+TXiOpN3CbKjx5e3dFUbTTjDFq7faXr+zs5JS0d+KBE2B8XWosxH5E0vkK3mm0sZCgEy2ViiL7LqIaBl3pvnCh1xPDwiz9FtTUgWYdBp35JJu/NSMM5T4Z4RRVU5ahw3YdkJtgfUBwTbQjAPwujfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5WtuO9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62905C4CEE3;
	Wed, 28 May 2025 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748462388;
	bh=XM3HtVTsglbbTTpWN88/VKWviJFPe6GUo06vUJU5+Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5WtuO9roQYZQc+beAUKPH6dQZQNLx3rf7zTcVKK8wGP9FoH6W14BRbFA1lXYuML7
	 QX+OF2HIPe9ob8EuskQtWMD2ry8RjX2kmRNMbZjN49hf85keiNGscjAB3iwmUD3va9
	 PgXOSd2flgpdlacBz3zlM03nx2EOJz/NGqu6FVmc9IdV0GMuNMKI4TXx2gu6cimoPR
	 JKj3X9JaJ9jTGjS8VdKkX0l0/HkU5VJuLvY4YSuc/8czn7mvDaL8Cgcz00dfvGO3qA
	 xsmO5aaO+ji7RA79PsAMGvjzPBeQOIgog4ENxyESX0dZTYkoocommpJRWd7uGjharP
	 JOGP19DpHT6vg==
Date: Wed, 28 May 2025 21:59:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Improving inode number documentation
Message-ID: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
References: <20250525103344.fe27ugiytfyoadz5@pali>
 <juxbjjsnt5mvtyctd72fcnc4o2u5wamqz7yd5occuor4clzkhx@zvob6krj6sq3>
 <20250528182519.l6kyy5ebiivev2u5@pali>
 <m5drckhk4mkw3l6fzfqyelobscbrmx6jefpjik4nj4j5ala7ff@mrm6ds7a4lk2>
 <20250528194105.dqc2bgfck6n3xfya@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eup7e5amnrxpwdr3"
Content-Disposition: inline
In-Reply-To: <20250528194105.dqc2bgfck6n3xfya@pali>


--eup7e5amnrxpwdr3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Improving inode number documentation
References: <20250525103344.fe27ugiytfyoadz5@pali>
 <juxbjjsnt5mvtyctd72fcnc4o2u5wamqz7yd5occuor4clzkhx@zvob6krj6sq3>
 <20250528182519.l6kyy5ebiivev2u5@pali>
 <m5drckhk4mkw3l6fzfqyelobscbrmx6jefpjik4nj4j5ala7ff@mrm6ds7a4lk2>
 <20250528194105.dqc2bgfck6n3xfya@pali>
MIME-Version: 1.0
In-Reply-To: <20250528194105.dqc2bgfck6n3xfya@pali>

[CC +=3D linux-fsdevel@]

Hi Pali,

On Wed, May 28, 2025 at 09:41:05PM +0200, Pali Roh=C3=A1r wrote:
> On Wednesday 28 May 2025 21:03:04 Alejandro Colomar wrote:
> > Hi Pali!
> >=20
> > On Wed, May 28, 2025 at 08:25:19PM +0200, Pali Roh=C3=A1r wrote:
> > > > > I would like to ask you, could you improve documentation about in=
ode
> > > > > numbers returned by readdir()/getdents() and stat()/statx() funct=
ions?
> > > >=20
> > > > I'd love to do that.  I do not feel experienced enough in this matt=
er to
> > > > write the text myself, but I could try to learn about it.  On the o=
ther
> > > > hand, if you want to send patches yourself, we can go much faster.
> > > > Would you mind sending some patches?
> > >=20
> > > Well, as it affects at least 7 man pages, I do not know how such
> > > information should be ideally structured. Whether to be described just
> > > in the readdir(3) and referenced from all others. Or split across all=
 of
> > > them. So I do not think that I'm the one who can prepare patches.
> > >=20
> > > But I will try at least to propose how the changes could look like:
> > >=20
> > > readdir(3) change:
> > >=20
> > >   d_ino - This is the inode number of the directory entry, which belo=
ngs
> > >   to the filesystem st_dev of the directory on which was readdir() ca=
lled.
> > >   If the directory entry is the mount point then the d_ino differs fr=
om
> > >   the stat's st_ino. d_ino is the inode number of the underlying mount
> > >   point, rather than of the inode number of mounted file system.
> >=20
> > I guess the last sentence applies only as a clarification of the
> > previous one, right?  If so, I'd separate the sentences with ':' instead
> > of '.'.
>=20
> Yes, it is a clarification.
>=20
> > > According
> > >   to POSIX this Linux behavior is considered to be a bug but conforms=
 as
> > >   "historical implementations".
> > >=20
> > > stat(3type) change:
> > >=20
> > >   st_ino - This field contains the file's inode number, which belongs=
 to
> > >   the st_dev. If the stat() was called on the mount point then st_ino
> > >   differs from the readdir's d_ino. st_ino contains the inode number =
of
> > >   mounted file system, whether readdir's d_ino contains the inode num=
ber
> > >   of the underlying mount point.
> >=20
> > These two paragraphs in two pages sound reasonable.  I've prepared a
> > patch, and pushed a new branch to the git repo where we can continue
> > working on it.
> >=20
> > <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=3Di=
no>
> >=20
> >=20
> > >=20
> > > So I suggest if somebody else look at it and prepare improvements
> > > including how should be this information structured.
> >=20
> > Here's the change I propose based on your suggestions:
> > ...
> >=20
> > Does it look good to you?  Would you do anything else?  Please sign the
> > patch if it looks good to you.
> >=20
> >=20
> > Have a lovely day!
> > Alex
> >=20
> > --=20
> > <https://www.alejandro-colomar.es/>
>=20
> As I said I'm not feeling comfortable with it. So I would really like if
> somebody else ideally more skilled recheck it and improve it. Maybe
> asking linux-fsdevel for help?

Sure, let's add them to CC.  I will send the patches as a response to
this thread, so that they can comment.  The full thread of this
discussion can be found at
<https://lore.kernel.org/linux-man/20250528194105.dqc2bgfck6n3xfya@pali/T/#=
t>.

>=20
> What is missing updating also the statx information (because this is
> also syscall which returns inode number) and updating also readdir(2)
> and getdents(2). In the first email I sent list of manpages which are
> affected. It could be quite surprising for people reading documentation
> why old stat syscall has something regarding to inodes and new statx
> syscall does not have.

We can improve it incrementally.  As long as what we add is correct, we
don't need to make it perfect at once.  But I'll keep it in a branch for
now, so we can iterate a bit without committing anything.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--eup7e5amnrxpwdr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmg3ayoACgkQ64mZXMKQ
wqnrOQ//R4W15MXtEIw0IIwt5T6jooaErxkmlOA37RNBbM+hA8B0jkZWKAkvcUMW
CRe240mGm8KeS/iD/tv1E2xrZkX6nYtpOd0e7Veo5Fh5Ba1dqBGeL5ODq1Y506yg
iXFYBqBRtKCCEuoNHZvR81SLXGuXK+tX99laPIoH773LlNMNF0MK0zZ9R3MuTTBC
REk/hYBN+xQy5LtltTqxZn2/4o2Jz/F0EWRNtTQHcXtvsP3pwFkgTkoo83f4kvO2
E0ZCncBlojAFLSULtaLO/9Netm13Li0u4/s8QFbmxRy/o4OK0VYGDjWl+zoltOqk
MIhPr35lHonn3OHgoXqHmuzUt9n09gzFsisX0qrLCF6GVbFAVauSZaheFHPNq9xD
2OcqmMx/Aq2kSJg7XiF3c+u9migAM2Ai9D/RDtuSyTVA+a4AF+T8I9b0Ff6dDvK1
/grtu6SlF1zV0cfRHfIR6PvKclihOkLzJyJFjsGk/afwLQhBpRqnmH8gX5gRDR3B
txjPwg8gSknu9QHqYmZqBqTh4MswO+BABLRfirtAgMcaNF+0QctyKH/ZYpexDvRa
mKfBT6+BOddDT/ztcDKg9Cz6l8KsWQGS56lJQ5VeFEWlr4j9/lda5NuToZ3+ma79
vvH6i2J9rqOzFWnsR7BGqkMF749RIxN+D4m92qMsZsIoD4eFlzU=
=XVvZ
-----END PGP SIGNATURE-----

--eup7e5amnrxpwdr3--

