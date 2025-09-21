Return-Path: <linux-fsdevel+bounces-62333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C6AB8D8DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586D8189C271
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB01255222;
	Sun, 21 Sep 2025 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyIJOoMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9D1A9FB7;
	Sun, 21 Sep 2025 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758448245; cv=none; b=Ty/ChZ4e88Im/6kqscmHsLzPJFbSnfAvAl/21C4KO15RW3Bmtq5uVOH6C8UCn3QCy/Epuv76oRxG0sVyG5474j0t2noV74V8Pp2K9bsI9pn5OjNtvG3e808sOVdc3eAeAzPNALfCnygMulDkGFHoxtCy/Cr5ir+olWhRwk3HN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758448245; c=relaxed/simple;
	bh=N59Z70gVCilCtu6Yr57fTD5r27fdmM7S2RGj49tl7tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9Orj3puoK/KxzWnx10zvBBL2r9IGDkt05c46iwuv0Iv/WyKcPVHP27z3Q1/0ArL5OY6qUisEf3LKMpecTxwBMfI/Afi7KdcQs4jkLbZymQjAWY3cLJ3EpwVtKhIURrwswoLzn1l1QWO1jdWqVrdaVS6qw1xD0g4TJTHWqH5jOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyIJOoMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECE2C4CEE7;
	Sun, 21 Sep 2025 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758448245;
	bh=N59Z70gVCilCtu6Yr57fTD5r27fdmM7S2RGj49tl7tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyIJOoMQnaXN7Hgvo7ZJqgosnyoaK/kvEN+YUGj+H/Psp5mf14Oj7f+JEXOe5mRsq
	 qRQ3Lhzsh/no4MACz5Id72HIf+JYHqKZG+34yoReukwwEx8Y2TLh4JadG4lXWzLTCK
	 yaUopyigSm2VbmG5cFVHIIe0PyUmeCQ10kyOaSp/5jSxdyke1jl0qI6U36ZZz0rPku
	 XL//Vh6OgXSJd9fhyGVIiS/xfWF7Dg2NuNKIcUQZLNJwlsiylVhnXPyJjfG+3RIpT3
	 a7OUhxmMFK8XUje5IMCnB9P1oiWGSpING3JKB2KVfHDce9av29PnCLWp5KV+vOReEH
	 3f0pAGNg3/U3w==
Date: Sun, 21 Sep 2025 11:50:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 08/10] man/man2/mount_setattr.2: mirror opening
 sentence from fsopen(2)
Message-ID: <fqgxjzw5dxsd6ymm4tmvxmokq4uh2xo6lk5rqhjg4tjw5eblgg@wy5kbuhwmfnx>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-8-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l6cl5aj2kuqvmfn3"
Content-Disposition: inline
In-Reply-To: <20250919-new-mount-api-v4-8-1261201ab562@cyphar.com>


--l6cl5aj2kuqvmfn3
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
Message-ID: <fqgxjzw5dxsd6ymm4tmvxmokq4uh2xo6lk5rqhjg4tjw5eblgg@wy5kbuhwmfnx>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-8-1261201ab562@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250919-new-mount-api-v4-8-1261201ab562@cyphar.com>

Hi Aleksa,

On Fri, Sep 19, 2025 at 11:59:49AM +1000, Aleksa Sarai wrote:
> All of the other new mount API docs have this lead-in sentence in order
> to make this set of APIs feel a little bit more cohesive.  Despite being
> a bit of a latecomer, mount_setattr(2) is definitely part of this family
> of APIs and so deserves the same treatment.
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks!  I've applied this patch.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D7022531182883ed1db5d4c926506cd373e0795ee>
(Use port :80/)


Cheers,
Alex

> ---
>  man/man2/mount_setattr.2 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> index 4b55f6d2e09d00d9bc4b3a085f310b1b459f34e8..b27db5b96665cfb0c387bf5b6=
0776d45e0139956 100644
> --- a/man/man2/mount_setattr.2
> +++ b/man/man2/mount_setattr.2
> @@ -19,7 +19,11 @@ .SH SYNOPSIS
>  .SH DESCRIPTION
>  The
>  .BR mount_setattr ()
> -system call changes the mount properties of a mount or an entire mount t=
ree.
> +system call is part of
> +the suite of file descriptor based mount facilities in Linux.
> +.P
> +.BR mount_setattr ()
> +changes the mount properties of a mount or an entire mount tree.
>  If
>  .I path
>  is relative,
>=20
> --=20
> 2.51.0
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--l6cl5aj2kuqvmfn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjPym0ACgkQ64mZXMKQ
wqlqQA//YViaFY14YGkPZkvGfXH09U/qqIi0e46N5YgGFG0hZiU2s+7rqapL2SpA
qHTN0cEYkE8aZS4Km0BYJbF1PIDphUjAyyxE73wvvq4P8vADndIHxBDeRF3H4fOr
Jv5FMQtE9uBfjA8J5CpRupQ8n1+cq6cx3+Z6h9ggAvSgCjE2DgOn5IUhQnM1Dem4
sNihwz9JcUkCKbWnDNBh2cGR9yRGxF19jO2MjJrfrgkqe4ggLO27q92PEGqqtiMk
8jU9/ld3RdpJtx8zYx3nd0hpQmQXdsYmvSRExHikj2Z7Vi4AgvRAAH2Rb2daeBp1
jI6uhKRzoCF3yrczKAx1wnKAd2DznwFcyV+CBUM8EYR4EvVBKoROygW/4PuHQBX/
/IUQotQpYe/Mqd0RoCDEJMhibzqTk/Q7tdWZ4FC7Jw4VJiZ91G4ozRIvOWuGSjVW
eRv5Qo9pVeWZIcYSFa2gZ087t5rzBtBpDnafJ+jSjrXTHGAFQFACM0KTpVutSRP6
2U7M7n/EzMDcZlBEo6b98FNjJi97QgM3v3yFAp0yis+gnuVu6aGX+q9dre4kV19C
IN95x1Bz0kzLYndy7vrthfMrBd2IfkQZKoyPi+TWlfKvY4BJeoNon6ALgUlWwZOX
RCs0jtOLwIfwnJWGVgQwdIpazfOsp5Jd8zF/2nmD+o3F4CDMbxk=
=qxgm
-----END PGP SIGNATURE-----

--l6cl5aj2kuqvmfn3--

