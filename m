Return-Path: <linux-fsdevel+bounces-57171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDD8B1F43C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 12:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8110217FC5B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DAF268C55;
	Sat,  9 Aug 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNvvh5Q6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475D265CA2;
	Sat,  9 Aug 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754736303; cv=none; b=oKrXQDMTasvSPS+oYqyxvM9yNyeU/5BItsSL9waYWzdqL0x6qcavnMA5UQU6qNSBbqY0t3Ms+OWuTtDEhpoXeYi2/Jpo27Lq+D8oGfDKlFEEQKiMJGAs7/dbLke03R7nWCYsTmIsl98zkWjtLgw9Ijaf14Tvz0EgeobHGOgVMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754736303; c=relaxed/simple;
	bh=ED/zM7QV6/6pRcc4YG3dIuZ5nk7Fu/DxU1B3KbZxxSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1JMcN9PZEuwzPVs9e4RO63PcyR/roYfSsAizO5fqguMMBJA9SsomQq5HST7CaoFJjkjoCM8eKRKbZeNw/BCd+V770sNiUaVGl7YQ9KqPFZPa+LyX9TtXyXfF/2EL5l9qblEM/3RB/mQlD6tL3QBBv84e74pesMN3na0M7j/qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNvvh5Q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04595C4CEE7;
	Sat,  9 Aug 2025 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754736303;
	bh=ED/zM7QV6/6pRcc4YG3dIuZ5nk7Fu/DxU1B3KbZxxSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNvvh5Q6RHaXOFIyPqTM0FhqtPKd0M0isMqACUmPhNqp6x5UP+GE1TwiZs9WrsaY8
	 f3zjEPJGNMUr9r49UVDRqTJkswFMjo7ze+ghISo8lD2iziRsF2YFIDIgLMVHmWO1cm
	 il2HAK74IxgxlUi427Yt85rv71ADvPsPkZTIw67aqa7w8VHeclZPEpnyp6Pzmxpf1o
	 wva46sI+fvEiZ/9IkvIwNSfflgMFsXdgsCuaSlCzA+M7P1zdGqYk/Cl+j+hUWXuHYX
	 /toQ7fM4CB9cWrUBoU6hy4HNFDx9XA/AoF6VSD+4tA/6WMuuwIFkqPRmXzZeceWaTC
	 PcFrDpHfe+Nuw==
Date: Sat, 9 Aug 2025 12:44:54 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36 syscall
 wrappers
Message-ID: <ri2ne3rb5wgb2aqkaafgrsdvrlbs6ijwbfpnjq3pno7tdtn44h@jzyzjtbvzw6c>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
 <19888fe1066.fcb132d640137.7051727418921685299@zohomail.com>
 <2025-08-08.1754653930-iffy-pickled-agencies-mother-K0e7Hn@cyphar.com>
 <j57inuu7wzzh2tm7sxfnhdogg4u7f4gf3vktmla4qlafuknh3p@ypu3peu3g5k6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4lybdadnu2eyvh5j"
Content-Disposition: inline
In-Reply-To: <j57inuu7wzzh2tm7sxfnhdogg4u7f4gf3vktmla4qlafuknh3p@ypu3peu3g5k6>


--4lybdadnu2eyvh5j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36 syscall
 wrappers
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
 <19888fe1066.fcb132d640137.7051727418921685299@zohomail.com>
 <2025-08-08.1754653930-iffy-pickled-agencies-mother-K0e7Hn@cyphar.com>
 <j57inuu7wzzh2tm7sxfnhdogg4u7f4gf3vktmla4qlafuknh3p@ypu3peu3g5k6>
MIME-Version: 1.0
In-Reply-To: <j57inuu7wzzh2tm7sxfnhdogg4u7f4gf3vktmla4qlafuknh3p@ypu3peu3g5k6>

Hi Aleksa, Askar,

On Sat, Aug 09, 2025 at 12:42:58PM +0200, Alejandro Colomar wrote:
> Hi Aleksa, Askar,
>=20
> On Fri, Aug 08, 2025 at 09:55:10PM +1000, Aleksa Sarai wrote:
> > On 2025-08-08, Askar Safin <safinaskar@zohomail.com> wrote:
> > > When I render "mount_setattr" from this (v2) pathset, I see weird quo=
te mark. I. e.:
> > >=20
> > > $ MANWIDTH=3D10000 man /path/to/mount_setattr.2
> > > ...
> > > SYNOPSIS
> > >        #include <fcntl.h>       /* Definition of AT_* constants */
> > >        #include <sys/mount.h>
> > >=20
> > >        int mount_setattr(int dirfd, const char *path, unsigned int fl=
ags,
> > >                          struct mount_attr *attr, size_t size);"
> > > ...
> >=20
> > Ah, my bad. "make -R lint-man" told me to put end quotes on the synopsis
> > lines, but I missed that there was a separate quote missing. This should
> > fix it:
> >=20
> > diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> > index d44fafc93a20..46fcba927dd8 100644
> > --- a/man/man2/mount_setattr.2
> > +++ b/man/man2/mount_setattr.2
> > @@ -14,7 +14,7 @@ .SH SYNOPSIS
> >  .B #include <sys/mount.h>
> >  .P
> >  .BI "int mount_setattr(int " dirfd ", const char *" path ", unsigned i=
nt " flags ","
> > -.BI "                  struct mount_attr *" attr ", size_t " size );"
> > +.BI "                  struct mount_attr *" attr ", size_t " size ");"
>=20
> Actually, I'd use
>=20
> .BI "                  struct mount_attr *" attr ", size_t " size );

I've pushed this as a fix.  As a sanity check:

	$ diffman-git HEAD
	--- HEAD^:man/man2/mount_setattr.2
	+++ HEAD:man/man2/mount_setattr.2
	@@ -11,7 +11,7 @@
		#include <sys/mount.h>
	=20
		int mount_setattr(int dirfd, const char *path, unsigned int flags,
	-                         struct mount_attr *attr, size_t size);"
	+                         struct mount_attr *attr, size_t size);
	=20
	 DESCRIPTION
		The mount_setattr() system call changes the mount properties of a mount


Have a lovely day!
Alex

>=20
> >  .fi
> >  .SH DESCRIPTION
> >  The
>=20
> Hmmm, thanks for the catch!  My CI server is down until I come back home
> and have a chance to fix it.
>=20
>=20
> Have a lovely day!
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--4lybdadnu2eyvh5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiXJqYACgkQ64mZXMKQ
wqlYqRAAqvtVsdzcdKCyhcFcywlUmBc9uvKJzG/nIFAecepnz3yGZ3LaqTErRbo2
UXCA1zEHqQUH94LXOuwIVsx1iFq+BHhGTjtfoifrZ30aL3PqvBf5nuqamyeVvm0d
SzXzTis0pr6DbzHWk2nSnadcJ0gOvT04BhQoQ0RABr5z1VhXZgRTsKKrCPoEwR/w
41cRY6xAonDkJ4ngYagU6XsUlqxxuHCX4AcXbLPN9l3dF8aGx6FQrmhUEKBbreFA
A+3KisY+wmfa5lqDloZJ/V7divj/Tlo0m/TWGRtpcGIDG4p4lbk7HEabTsboQV0w
KwY6yjGlnGijlxwTnb9E+oGMlGim5sLDh2JCIadZ1QZADtoRVAq1ObNeYLhk5+8X
PM0ga40WY3D4A9qmQlNoBsIaZEz6nfEZ0tT3MCshd6cvqKiFByxmHaa/gTaScM2X
qayK4l1CKQ2mNG6W7Zr0fOOdoOhApjrZxzye9jXVylH/smgQSnagjANPMqcTM83t
IHBQItAt5QqC/MUbHENbejCP04WI6HVprekFLSa97f/moXU68AufwcPq3GVdNIdx
ukAH9mt1BPbPTVoruLxYhMXN+vT4kPkuqRdUs50UqAQ3FHLeR6e0809yXpxPYrVH
Jyqpf++bqP9Tw+msxxGu8dgKhsy9oLWb1JCi5PwG7QdgRDJwIsc=
=YGPD
-----END PGP SIGNATURE-----

--4lybdadnu2eyvh5j--

