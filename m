Return-Path: <linux-fsdevel+bounces-59716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7988B3D190
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 11:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB43717E24C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34638245010;
	Sun, 31 Aug 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHdO0Gn5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726D4C79;
	Sun, 31 Aug 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631729; cv=none; b=HIEb/+RTTLtFxDN5kHRKWMyLim0Jdq7YMzI1HHB8/qO8B/Z7+kaaEorRkCNW1jw40RbvkDc7KB5pZjKBFhBnJW3IBih4RFpmSuk+d89keulEEGZYFmLCaCNDXEKiCv2VzxB0rHdbvqMyJsdjDf/fyWKJI1pkMmB2nihERIhM3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631729; c=relaxed/simple;
	bh=0n27c6ZwmYdVf6l5gU1sAcbNuJ0NhCTUbl21M489MKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+5gT7ydmCYg/GXvMLfyMbRPXCwFVKY0JzPDQdtLmth2Cvp299pRr8axfUhZr+tzPcxnD2su4zVjmuzqQ1g2vLMKp7H5jxj0ietwcr6Xt2AkoveLTT34vy5Ew4aKCYCe2WavT9zYsTUMjzd3X3gTYKMHEdMhg/XAUNnXhdycdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHdO0Gn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DEFC4CEED;
	Sun, 31 Aug 2025 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756631729;
	bh=0n27c6ZwmYdVf6l5gU1sAcbNuJ0NhCTUbl21M489MKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHdO0Gn50cG7C5xzXiDZdXDp+Bg3QYDsvPKwgfFj0kEQxSEUi/yjYmyjXfj8ehjQv
	 oprXCSzyMoTDAwiQJBvYkStv5Klji+RMig3ySiYcGW4T+2flSzrSKV1ncfeT8Awgh9
	 UIcdWZ+6XB/ak5OrHv/CWd3At/R7lo7AOiaIw+ybzNLFXMBMXoik0DpLkLOyRvATGM
	 mDiDywe3HeE3tky60Irhr/FET7PdWDK47eDPZ+rUjVD7xFKTpHPJsmHtDcytZxRAAa
	 tCsLwr93V7Bv4GTzef6sOVfkgxdb5y54Sna4HOR5cy9ooPCwZZzD8wRrk2R121iYyP
	 EXAHzig670ZHw==
Date: Sun, 31 Aug 2025 11:15:22 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH v3 1/2] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
Message-ID: <i6wgatub7tanaby2qf7jtgqbe2l7hv6xuihqmjb7xn3quqhi7w@pkp3ipbkrt7b>
References: <20250826083227.2611457-1-safinaskar@zohomail.com>
 <20250826083227.2611457-2-safinaskar@zohomail.com>
 <2025-08-27.1756287489-unsure-quiet-flakes-gymnast-P41YdV@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqqujrutpigiysmh"
Content-Disposition: inline
In-Reply-To: <2025-08-27.1756287489-unsure-quiet-flakes-gymnast-P41YdV@cyphar.com>


--aqqujrutpigiysmh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH v3 1/2] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
References: <20250826083227.2611457-1-safinaskar@zohomail.com>
 <20250826083227.2611457-2-safinaskar@zohomail.com>
 <2025-08-27.1756287489-unsure-quiet-flakes-gymnast-P41YdV@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-08-27.1756287489-unsure-quiet-flakes-gymnast-P41YdV@cyphar.com>

Hi Aleksa, Askar,

On Wed, Aug 27, 2025 at 07:42:09PM +1000, Aleksa Sarai wrote:
> On 2025-08-26, Askar Safin <safinaskar@zohomail.com> wrote:
> > My edit is based on experiments and reading Linux code
> >=20
> > Signed-off-by: Askar Safin <safinaskar@zohomail.com>

Thanks!  I've applied the patch, with some tweaks.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Db479b1fe01569d4926cbc59fa31caab8cd01fdad>
(use port 80; this stops AI crawlers.)

> > ---
> >  man/man2/mount.2 | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/man/man2/mount.2 b/man/man2/mount.2
> > index 5d83231f9..599c2d6fa 100644
> > --- a/man/man2/mount.2
> > +++ b/man/man2/mount.2
> > @@ -405,7 +405,25 @@ flag can be used with
> >  to modify only the per-mount-point flags.
> >  .\" See https://lwn.net/Articles/281157/
> >  This is particularly useful for setting or clearing the "read-only"
> > -flag on a mount without changing the underlying filesystem.
> > +flag on a mount without changing the underlying filesystem parameters.
>=20
> When reading the whole sentence, this feels a bit incomplete
> ("filesystem parameters ... of what?"). Maybe
>=20
>   This is particularly useful for setting or clearing the "read-only"
>   flag on a mount without changing the underlying filesystem's
>   filesystem parameters.
>=20
> or
>=20
>   This is particularly useful for setting or clearing the "read-only"
>   flag on a mount without changing the filesystem parameters of the
>   underlying filesystem.
>=20
> would be better?

Yep; I've taken the second proposal.

>=20
> That one nit aside, feel free to take my
>=20
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks!  Appended.

> > +The
> > +.I data
> > +argument is ignored if
> > +.B MS_REMOUNT
> > +and
> > +.B MS_BIND
> > +are specified.

I have removed the mention of MS_REMOUNT and MS_BIND, since the first
sentence in the paragraph already mentions them.  Otherwise, it felt a
bit confusing why some sentences mentioned it and others not.

> > +The mount point will
> > +have its existing per-mount-point flags

I have reworded this to use present instead of future, and also reversed
the order of the clauses; if feels more readable now.


Have a lovely day!
Alex

> > +cleared and replaced with those in
> > +.IR mountflags .
> > +This means that
> > +if you wish to preserve
> > +any existing per-mount-point flags,
> > +you need to include them in
> > +.IR mountflags ,
> > +along with the per-mount-point flags you wish to set
> > +(or with the flags you wish to clear missing).
> >  Specifying
> >  .I mountflags
> >  as:
> > @@ -416,8 +434,11 @@ MS_REMOUNT | MS_BIND | MS_RDONLY
> >  .EE
> >  .in
> >  .P
> > -will make access through this mountpoint read-only, without affecting
> > -other mounts.
> > +will make access through this mount point read-only
> > +(clearing all other per-mount-point flags),
> > +without affecting
> > +other mounts
> > +of this filesystem.
> >  .\"
> >  .SS Creating a bind mount
> >  If
> > --=20
> > 2.47.2
> >=20
>=20
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--aqqujrutpigiysmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmi0EqoACgkQ64mZXMKQ
wqmV8Q//bXSH4r0XQ4qI+BAoQpK/WRlTzpStJwbR0BiYqn5PsdTE8JX3FRkha50b
Z/BCKGN09aMGSMY/QeW/ZdEeWDz2iXRmxFyKS8yGmXvGzuukopHuZLbLbQFm478D
Nz/mevbjCo12Xa6WFqLKeKXVotRsOZB8EIlzLstKq7k3vaidkwiD5YuVVbAinf5K
ON7qV2J0Yykz7idVyma1eZcnHRWBDXtUqu6n+tWBkrpgr+37FyFvwCRTf0hSy7Ul
ywS5cbEPwwkcYWOzHVtLWJUbfE1QCWI8hX9PCjvitiq84ki2aENyyaNImPBgOKm3
ZJwAdmr/jocyrj7dYUpAiUpYP96VNyrtPTL2gJ8VmBzf3PttJQIRdUpMOSncGm2f
ZTtpiDBmtmu9c/lRGL33uXmQgreogi9y+SPM1fI+h1b9X+AzqneK//8PtOrh9Fjz
+MzugbURII56FXpY7sJYYH+siU0ILRznniM6KmbevEFJ4N4HgkKUuhEjdHLkLRq+
BO4jH4cDqMNSc03I7uofVh59BQOTSrf4t4EIdnjeFnoK97oDIpOzmOddTAVx/Lx4
gZLFIk4Ikx1zplapfqugLYooP+OxxyEVG0PdPHD/QqQhQpz1KSn19vAvyF8zGoSE
eBJ6UsjXSRRBdOz+xoCmYhOAy0KZ/ZgKXRzuwP01Un0JQwmtuWo=
=6FxK
-----END PGP SIGNATURE-----

--aqqujrutpigiysmh--

