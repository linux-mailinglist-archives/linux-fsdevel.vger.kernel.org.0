Return-Path: <linux-fsdevel+bounces-59176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4546CB357A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39DD54E31B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC92FD1C2;
	Tue, 26 Aug 2025 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfc/s6Vk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D11FDA89;
	Tue, 26 Aug 2025 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198281; cv=none; b=oVX3fRht+GTURYb5vFmVfE+rxBPBYxyt0MsmuAORMXauCbhjZPxnsTpCwJpwYcPdMYa/imPamZ+JzjgPSZsT99PR2LP/fsWK+iiILRF5EBcbWhiH7k0t47q9WcTp23aAAXPV51IVt2fQaD+2wig5/Kwv3k9Zk6XRap3jaK7G9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198281; c=relaxed/simple;
	bh=gerr9lf4/f5cmAS7cLedSZLzYtkGDyZYKSo7Nca+nTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T46azvKE46s7+3Cu9M/lSLglFrdaSnSOP3v1nB8BkEohcnhfdHgcGoGFHSov4P9+uEqZH/PYzYUf0GTqs1RuzMsuk3RBpDjZn8PJtw0HFl5O+/Kka/W72D+4hpUmTbvFMGm4vUVmbD70qipgdq1vt1tTTWpgsLFaaoxBnMeMgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfc/s6Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0A3C4CEF1;
	Tue, 26 Aug 2025 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756198277;
	bh=gerr9lf4/f5cmAS7cLedSZLzYtkGDyZYKSo7Nca+nTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfc/s6VkqdRwcIvAyqqUwt5+b29OSkjsenf+M+YO5Aw917S6U/JxRGQbNG+fzpWRK
	 qltTjSV3fpzNj89lXSUl/3aMmhZ9d17eoOTY4ku1UMD4PPyf9l0wdwrcMfjo0sqHr0
	 4/OVRIj3L8ivcgH0a5NE8prI3wilis02zaf82ctWAqJYLKS2dLreha1Iqt6mpSnUIF
	 U4gccSwJN6CIDQ0tyANmpCctWig7F0JwMdsktH4eZmyms1lDricp/n1I1VoKIY4+pH
	 knmpQTyt51bzMLBfTDD83hQimpGNSgSlydaIP+LNQhHE6zG4RQdi/dG5zreT517pLV
	 m7tWLGeR2i2nA==
Date: Tue, 26 Aug 2025 10:51:12 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
Message-ID: <ok5dewkwerk46l375ho2b3w7ofedslzqj2jy5e3kllhle5tbd7@avil45wh5yby>
References: <20250825154839.2422856-1-safinaskar@zohomail.com>
 <20250825154839.2422856-2-safinaskar@zohomail.com>
 <rxl7zzllf374j6osujwvpvbvsnrjwikoo5tj2o3pqntfjdmwps@isiyqms4s776>
 <198e5864132.1283ed42534579.7191562270325331624@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sty5fdorgytvr577"
Content-Disposition: inline
In-Reply-To: <198e5864132.1283ed42534579.7191562270325331624@zohomail.com>


--sty5fdorgytvr577
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
References: <20250825154839.2422856-1-safinaskar@zohomail.com>
 <20250825154839.2422856-2-safinaskar@zohomail.com>
 <rxl7zzllf374j6osujwvpvbvsnrjwikoo5tj2o3pqntfjdmwps@isiyqms4s776>
 <198e5864132.1283ed42534579.7191562270325331624@zohomail.com>
MIME-Version: 1.0
In-Reply-To: <198e5864132.1283ed42534579.7191562270325331624@zohomail.com>

Hi Askar,

On Tue, Aug 26, 2025 at 12:37:17PM +0400, Askar Safin wrote:
>  ---- On Mon, 25 Aug 2025 23:13:05 +0400  Alejandro Colomar <alx@kernel.o=
rg> wrote ---=20
>  > Should we say "mount point" instead?  Otherwise, it's inconsistent with
>=20
> d-user@comp:/rbt/man-pages$ grep -E -r -I -i 'mount point' /rbt/man-pages=
/man | wc -l
> 101
> d-user@comp:/rbt/man-pages$ grep -E -r -I -i 'mount-point' /rbt/man-pages=
/man | wc -l
> 9
> d-user@comp:/rbt/man-pages$ grep -E -r -I -i 'mountpoint' /rbt/man-pages/=
man | wc -l
> 4
>=20
> My experiments show that "mount point" is indeed the most popular variant.
>=20
> I changed all "mountpoint" to "mount point".
>=20
> I decided to keep all "per-mount-point".

Thanks!

>  > > +have its existing per-mount-point flags
>  > > +cleared and replaced with those in
>  > > +.I mountflags
>  > > +when
>  > > +.B MS_REMOUNT
>  > > +and
>  > > +.B MS_BIND
>  > > +are specified.
>  >=20
>  > Maybe reverse the sentence to start with this?
>=20
> I decided simply to remove that "MS_REMOUNT and MS_BIND" part
> (because it is already present in previous sentence).

Okay.

>  > > +This means that if
>  >=20
>  > I would move the 'if' to the next line.
>=20
> I moved it. But, please, next time do it youself.
> I don't plan to become regular man-pages contributor.

I do these small things myself if they're the only issue.  If there are
more important issues, I _also_ point these out, just because it's
useful.

In general, when writing documentation sentences, write them similarly
to how you would write them if they were code.  You never put an if at
the end of a line of code; never put it at the end of a line of
documentation text.

> I addressed all complains except for listed above and sent v3.

I'll check.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--sty5fdorgytvr577
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmitdXIACgkQ64mZXMKQ
wqkVnA/9EiLz8VURlT0plLVhS6ibb8VLy0vgJLHhqmY/cyp8mP359+QQ5TYfbAyy
IL6LNwJTjVlAa3BU2NRUvWoW+lze5yofvlOJZuYWtjz/LEA/KDMQWRtUCYEPYqWI
EBpIKGdbKqi40ZHi7C28lUbLTPoAPCpCjcWlZDtOcXcfYnOk9x1WTOGnqSi2sEGw
DY68FTVAQ0szsiR1BEIH/hHqm5pbVP6/sDtTWfDgSismp9/8XwMQfMBr4HbrphTe
f7oldgwd7Icw6B7OpGGze+i3DC+Qn39KweK/EpXEXfb20Jlvv3urAXmlG2z75V9q
RwdNtU5HqCm8wJPEDUjrvMV64wPVxk8VC6miDSX09xdMJYV0BhPcQn66xVql4ITD
2+B09PaskfAE+1MrRlowziSa1yX847RIq3jCVD/8GyIRUkCl0tIp48w+88BV/Y/T
QP56CG5qSKO3mhLqcirtKJFk41f2EkPpIU4b4vpKZit2hc3ckH+olK6z+ZGpXbqP
wtawuoir/f2hjCUIU0e3hFnJYmaM0FtO07QH+Cst8XqCqK+Y1tTG7zXMat4cN6vh
fDtgGL/jyrvJqixrO6WE7fZTWdxmWS/w1zK4RqycpPaWp4EAmueloGN27G3FQfUD
hq4HwT4YJDU/wLRSHD2elXUkvPj4rSPVgHVZmYsts8v9hIW3ags=
=aSuH
-----END PGP SIGNATURE-----

--sty5fdorgytvr577--

