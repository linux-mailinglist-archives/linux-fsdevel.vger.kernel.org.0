Return-Path: <linux-fsdevel+bounces-62338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FC0B8D955
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51F717BFC5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E962580CF;
	Sun, 21 Sep 2025 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM6XhFP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14C1CFBA;
	Sun, 21 Sep 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758449969; cv=none; b=lg/WfMQ/Jo1TsMjA9u9sgd3Dh1Pl/e3YIzhxl8j3AVTlN25FZPwWXYTqsJfQwaaU20cJnW8ypKQAGk04A/BvRqNYmVWjGeEQ74TL82SLhmyb4TREKxtANc6QdHyAd4M4yEydE2EG+EUI78d2U590qvwM7WWYcUz/ZZukEt3IZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758449969; c=relaxed/simple;
	bh=P2l57chXDQtFSlJjs3LoRhHhPpe0OIuvRfNk8Z689zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eldAgdod6OPQlfgON4ywsMPG7OJliTbHs4OVBc+Zxh1JG+DMoN04CJVLXQhnmyLzmtKAG+O0r5+a6nIvoFK9V3Ec6gDb6Fxt/EUy2BDOHhb9TzvKigzWkRJqpIUo4lRbFjLbRNkwLwTacuDD55kDk9XF+yalnqZEWWgX+hATuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM6XhFP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC45C4CEE7;
	Sun, 21 Sep 2025 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758449969;
	bh=P2l57chXDQtFSlJjs3LoRhHhPpe0OIuvRfNk8Z689zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AM6XhFP7NCXS0i3t0250qiXtLjlrX1WmbvKF2BiEi9nDMtZRa+yrJGGf/oTtiOwSq
	 I3e+bx5V8GHa3enNBRANK0+Ue2KQWBM8dVr+UMHOBZt2GoOLLXnssUpxOJhnSpfLD4
	 +cP5K2xsoeljOGOjS/nyrxLL+MKUv4wQvI9y5NPcSX8Do4ktYYsqb+bS6VPpNgwSC4
	 ZI73KcHnIubJEwejfO0iNd2YR3GlkmuP2i+kEh97SInPT/A9miz9K2TJmBe7n32TxL
	 Q8BqvQj8w7DJ+EtNUSd58uJqxCSJhDLcDNPatPrqxOYt9UjODe1FVZP45SSmOSzEDs
	 V0GDtKuV5Yl6Q==
Date: Sun, 21 Sep 2025 12:19:22 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 08/10] man/man2/mount_setattr.2: mirror opening
 sentence from fsopen(2)
Message-ID: <g257patrvd5blq46uyhsw2vuychdutagfkz4bydzxn3wydqztf@j4sngp4ku4qk>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-8-1261201ab562@cyphar.com>
 <fqgxjzw5dxsd6ymm4tmvxmokq4uh2xo6lk5rqhjg4tjw5eblgg@wy5kbuhwmfnx>
 <2025-09-21-sad-swampy-pillar-rigor-ESCPmx@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dfqx5luuiq3rq4o5"
Content-Disposition: inline
In-Reply-To: <2025-09-21-sad-swampy-pillar-rigor-ESCPmx@cyphar.com>


--dfqx5luuiq3rq4o5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 08/10] man/man2/mount_setattr.2: mirror opening
 sentence from fsopen(2)
Message-ID: <g257patrvd5blq46uyhsw2vuychdutagfkz4bydzxn3wydqztf@j4sngp4ku4qk>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-8-1261201ab562@cyphar.com>
 <fqgxjzw5dxsd6ymm4tmvxmokq4uh2xo6lk5rqhjg4tjw5eblgg@wy5kbuhwmfnx>
 <2025-09-21-sad-swampy-pillar-rigor-ESCPmx@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-09-21-sad-swampy-pillar-rigor-ESCPmx@cyphar.com>

On Sun, Sep 21, 2025 at 08:03:08PM +1000, Aleksa Sarai wrote:
> On 2025-09-21, Alejandro Colomar <alx@kernel.org> wrote:
> > Hi Aleksa,
> >=20
> > On Fri, Sep 19, 2025 at 11:59:49AM +1000, Aleksa Sarai wrote:
> > > All of the other new mount API docs have this lead-in sentence in ord=
er
> > > to make this set of APIs feel a little bit more cohesive.  Despite be=
ing
> > > a bit of a latecomer, mount_setattr(2) is definitely part of this fam=
ily
> > > of APIs and so deserves the same treatment.
> > >=20
> > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> >=20
> > Thanks!  I've applied this patch.
> > <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git=
/commit/?h=3Dcontrib&id=3D7022531182883ed1db5d4c926506cd373e0795ee>
> > (Use port :80/)
>=20
> Ah, you forgot to switch to "file-descriptor-based" like you suggested
> in patch 1. ;)

Oh, thanks for the reminder!  :-)

I've amended it, and now pushed to <kernel.org>.


Cheers,
Alex

>=20
> >=20
> > Cheers,
> > Alex
> >=20
> > > ---
> > >  man/man2/mount_setattr.2 | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> > > index 4b55f6d2e09d00d9bc4b3a085f310b1b459f34e8..b27db5b96665cfb0c387b=
f5b60776d45e0139956 100644
> > > --- a/man/man2/mount_setattr.2
> > > +++ b/man/man2/mount_setattr.2
> > > @@ -19,7 +19,11 @@ .SH SYNOPSIS
> > >  .SH DESCRIPTION
> > >  The
> > >  .BR mount_setattr ()
> > > -system call changes the mount properties of a mount or an entire mou=
nt tree.
> > > +system call is part of
> > > +the suite of file descriptor based mount facilities in Linux.
> > > +.P
> > > +.BR mount_setattr ()
> > > +changes the mount properties of a mount or an entire mount tree.
> > >  If
> > >  .I path
> > >  is relative,
> > >=20
> > > --=20
> > > 2.51.0
> > >=20
> >=20
> > --=20
> > <https://www.alejandro-colomar.es>
> > Use port 80 (that is, <...:80/>).
>=20
>=20
>=20
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--dfqx5luuiq3rq4o5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjP0SkACgkQ64mZXMKQ
wqmf0w//QHPfrYnFJ6Ln5slYg1SK6AwCJhSbj6u1z/PZM783HnFGfLH5LrfWKMVW
Uf8Qp9QZtyDvfcBgKxjxRnJYWHjBnpX297vBzRheIsJk95urEIU8SvPWc7PPmxRJ
PU0+MV7RtC38BxEGmLp75lJjybJeKKIPkhYJw0A2f0XfN3B3y3j472hNYJ58rUra
JXV0y0zeb6CN2dO3uzpS8nwDPJhQQRKol3zKygw3q15cP/5z3x9MPl5uexFVEZzq
NtRsjGkxfseBOxC1re9Ef8BEUUvLuLojjY1exqWxHOkcZo189Eg5h8cnsAAMaR7/
A81bzsfiaMseMClXe3Xo0f06ZiLZVeHt1/vpOV4zZlAblIAcJTYPVsB/0PEHh4se
/HzleLg6A7nI1XaExbnAx5kNvFNTDFCQpF1ZCFNGZzBkmhKbyGqmNEsyGM4xJuSd
bElw/7Z7MPXYgQkTe5qVVerEXvLunm+iog/S9Y5E/KdmI/OR6ILn7JV14V5pZlAv
KSpm728pV+RqD77+YKE1cvQAPnJS8HobN3bqyfgP8Pop91t7mxLca01Rh5k2ua45
aNxVBYyihZ+iOr05tcuX2bdTl/uad3tRamJcDeid7dfviWsQaczEa1Ll2nttRmQm
V0CnirSuCTGpVsuGNslfDYHynJ90SJk4u7/j12BXSejnnMsaaHs=
=SF6J
-----END PGP SIGNATURE-----

--dfqx5luuiq3rq4o5--

