Return-Path: <linux-fsdevel+bounces-62334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA41CB8D8E6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 11:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C595177FAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC9256C6D;
	Sun, 21 Sep 2025 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvyP0J2K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDDE34BA52;
	Sun, 21 Sep 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758448564; cv=none; b=rkzV00V5h+4kY998ZqxtScqihu16VYhQhBhCRQXj/x5MFYL9dIsyTkTqeZebKYUkurltPHpZO4qv9gmu+m7zh/j3TDp2RooFr01ItQtDxgmAeAOq97IVkqN1WpfLeGjPyKP5p/PCmRsI4njaglAirkg7ZkSBNvXYTAxNbtBonv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758448564; c=relaxed/simple;
	bh=8c8ihI9xyzVksPAa/VOjWmcF3T5G47zUizic1JT51x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=durAsdzRO7PGFNEbI0lS7ocEwgF5Cwtgpor19F5v1SWoA5sovXF3dlCsCCPFyAqQ1/AisTESk9L5e4NqNw5vo9rkm60SWLHXrRe2wVJjah5UBlni6qO/yxJVO4fts98whrxEH4oUnsOb7XDAotyhiIo7J3TdHQs9cVkoEhMC4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvyP0J2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF42C4CEF7;
	Sun, 21 Sep 2025 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758448563;
	bh=8c8ihI9xyzVksPAa/VOjWmcF3T5G47zUizic1JT51x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvyP0J2K+XSv9VPU9G2vUhVg0UL9bqSoiuKSB603iK9CjRhmFgSuuW1TsUgPfeLjt
	 5nHUS3lUYtg/0aGy8oRb9OmN95wK4/AtrkzlGq2d/RJEEY8mmqjzBtkHfOCHO/IXjd
	 pKP8mRVclreeM10CXGWtnpQTXUqHn1ZD1vVWM4bqb3268XGsD9UJstFbcsuRYDeM2w
	 L/t19mf3vazMnDnZrr0lynJgyKwWAb1Ot++cB8W5MI0TYC7snLVwhvdXi886FmGzra
	 JA7chbtrNBNCEjgH/gwXUh5rcRstMCykN2lIX9fEUBrHrtckjBK5t5Ni88kaWJV8+t
	 LTIMmLNEB4LMQ==
Date: Sun, 21 Sep 2025 11:55:56 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 09/10] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <vc2xa2tuqqnkuoyg4hrgt6akt23ap6hxho5qs5hfcbc5nsaosv@idi6hwvyo7r5>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-9-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ait5gh3b5i3rfonp"
Content-Disposition: inline
In-Reply-To: <20250919-new-mount-api-v4-9-1261201ab562@cyphar.com>


--ait5gh3b5i3rfonp
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
Subject: Re: [PATCH v4 09/10] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <vc2xa2tuqqnkuoyg4hrgt6akt23ap6hxho5qs5hfcbc5nsaosv@idi6hwvyo7r5>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-9-1261201ab562@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250919-new-mount-api-v4-9-1261201ab562@cyphar.com>

Hi Aleksa,

On Fri, Sep 19, 2025 at 11:59:50AM +1000, Aleksa Sarai wrote:
> This is a new API added in Linux 6.15, and is effectively just a minor
> expansion of open_tree(2) in order to allow for MOUNT_ATTR_IDMAP to be
> changed for an existing ID-mapped mount.  glibc does not yet have a
> wrapper for this.
>=20
> While working on this man-page, I discovered a bug in open_tree_attr(2)
> that accidentally permitted changing MOUNT_ATTR_IDMAP for extant
> detached ID-mapped mount objects.  This is definitely a bug, but there
> is no need to add this to BUGS because the patch to fix this has already
> been accepted (slated for 6.18, and will be backported to 6.15+).

Okay.

>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man/man2/open_tree.2      | 140 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  man/man2/open_tree_attr.2 |   1 +
>  2 files changed, 141 insertions(+)
>=20
> diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
> index 7f85df08b43c7b48a9d021dbbeb2c60092a2b2d4..60de4313a9d5be4ef3ff12170=
51f252506a2ade9 100644
> --- a/man/man2/open_tree.2
> +++ b/man/man2/open_tree.2
> @@ -15,7 +15,19 @@ .SH SYNOPSIS
>  .B #include <sys/mount.h>
>  .P
>  .BI "int open_tree(int " dirfd ", const char *" path ", unsigned int " f=
lags );
> +.P
> +.BR "#include <sys/syscall.h>" "    /* Definition of " SYS_* " constants=
 */"
> +.P
> +.BI "int syscall(SYS_open_tree_attr, int " dirfd ", const char *" path ,
> +.BI "            unsigned int " flags ", struct mount_attr *_Nullable " =
attr ", \
> +size_t " size );

Do we maybe want to move this to its own separate page?

The separate page could perfectly contain the same exact text you're
adding here; you don't need to repeat open_tree() descriptions.

In general, I feel that while this improves discoverability of related
functions, it produces more complex pages.


Cheers,
Alex

>  .fi
> +.P
> +.IR Note :
> +glibc provides no wrapper for
> +.BR open_tree_attr (),
> +necessitating the use of
> +.BR syscall (2).
>  .SH DESCRIPTION
>  The
>  .BR open_tree ()
> @@ -246,6 +258,129 @@ .SH DESCRIPTION
>  as a detached mount object.
>  This flag is only permitted in conjunction with
>  .BR \%OPEN_TREE_CLONE .
> +.SS open_tree_attr()
> +The
> +.BR open_tree_attr ()
> +system call operates in exactly the same way as
> +.BR open_tree (),
> +except for the differences described here.
> +.P
> +After performing the same operation as with
> +.BR open_tree (),
> +.BR open_tree_attr ()
> +will apply the mount attribute changes described in
> +.I attr
> +to the file descriptor before it is returned.
> +(See
> +.BR mount_attr (2type)
> +for a description of the
> +.I mount_attr
> +structure.
> +As described in
> +.BR mount_setattr (2),
> +.I size
> +must be set to
> +.I sizeof(struct mount_attr)
> +in order to support future extensions.)
> +If
> +.I attr
> +is NULL,
> +or has
> +.IR attr.attr_clr ,
> +.IR attr.attr_set ,
> +and
> +.I attr.propagation
> +all set to zero,
> +then
> +.BR open_tree_attr ()
> +has identical behaviour to
> +.BR open_tree ().
> +.P
> +The application of
> +.I attr
> +to the resultant file descriptor
> +has identical semantics to
> +.BR mount_setattr (2),
> +except for the following extensions and general caveats:
> +.IP \[bu] 3
> +Unlike
> +.BR mount_setattr (2)
> +called with a regular
> +.B OPEN_TREE_CLONE
> +detached mount object from
> +.BR open_tree (),
> +.BR open_tree_attr ()
> +can specify a different setting for
> +.B \%MOUNT_ATTR_IDMAP
> +to the original mount object cloned with
> +.BR OPEN_TREE_CLONE .
> +.IP
> +Adding
> +.B \%MOUNT_ATTR_IDMAP
> +to
> +.I attr.attr_clr
> +will disable ID-mapping for the new mount object;
> +adding
> +.B \%MOUNT_ATTR_IDMAP
> +to
> +.I attr.attr_set
> +will configure the mount object to have the ID-mapping defined by
> +the user namespace referenced by the file descriptor
> +.IR attr.userns_fd .
> +(The semantics of which are identical to when
> +.BR mount_setattr (2)
> +is used to configure
> +.BR \%MOUNT_ATTR_IDMAP .)
> +.IP
> +Changing or removing the mapping
> +of an ID-mapped mount is only permitted
> +if a new detached mount object is being created with
> +.I flags
> +including
> +.BR \%OPEN_TREE_CLONE .
> +.\" Aleksa Sarai
> +.\"  At time of writing, this is not actually true because of a bug where
> +.\"  open_tree_attr() would accidentally permit changing MOUNT_ATTR_IDMA=
P for
> +.\"  existing detached mount objects without setting OPEN_TREE_CLONE, bu=
t a
> +.\"  patch to fix it has been slated for 6.18 and will be backported to =
6.15+.
> +.\"  <https://lore.kernel.org/r/20250808-open_tree_attr-bugfix-idmap-v1-=
0-0ec7bc05646c@cyphar.com/>
> +.IP \[bu]
> +If
> +.I flags
> +contains
> +.BR \%AT_RECURSIVE ,
> +then the attributes described in
> +.I attr
> +are applied recursively
> +(just as when
> +.BR mount_setattr (2)
> +is called with
> +.BR \%AT_RECURSIVE ).
> +However, this applies in addition to the
> +.BR open_tree ()-specific
> +behaviour regarding
> +.BR \%AT_RECURSIVE ,
> +and thus
> +.I flags
> +must also contain
> +.BR \%OPEN_TREE_CLONE .
> +.P
> +Note that if
> +.I flags
> +does not contain
> +.BR \%OPEN_TREE_CLONE ,
> +.BR open_tree_attr ()
> +will attempt to modify the mount attributes of
> +the mount object attached at
> +the path described by
> +.I dirfd
> +and
> +.IR path .
> +As with
> +.BR mount_setattr (2),
> +if said path is not a mount point,
> +.BR open_tree_attr ()
> +will return an error.
>  .SH RETURN VALUE
>  On success, a new file descriptor is returned.
>  On error, \-1 is returned, and
> @@ -339,10 +474,15 @@ .SH ERRORS
>  .SH STANDARDS
>  Linux.
>  .SH HISTORY
> +.SS open_tree()
>  Linux 5.2.
>  .\" commit a07b20004793d8926f78d63eb5980559f7813404
>  .\" commit 400913252d09f9cfb8cce33daee43167921fc343
>  glibc 2.36.
> +.SS open_tree_attr()
> +Linux 6.15.
> +.\" commit c4a16820d90199409c9bf01c4f794e1e9e8d8fd8
> +.\" commit 7a54947e727b6df840780a66c970395ed9734ebe
>  .SH NOTES
>  .SS Mount propagation
>  The bind-mount mount objects created by
> diff --git a/man/man2/open_tree_attr.2 b/man/man2/open_tree_attr.2
> new file mode 100644
> index 0000000000000000000000000000000000000000..e57269bbd269bcce0b0a97442=
5644ba75e379f2f
> --- /dev/null
> +++ b/man/man2/open_tree_attr.2
> @@ -0,0 +1 @@
> +.so man2/open_tree.2
>=20
> --=20
> 2.51.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--ait5gh3b5i3rfonp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjPy6sACgkQ64mZXMKQ
wqkmxQ//YZqpzBJH92oRGMIveddnBadKJu2mlESsHg8Lqkp1nNPFhwgeQlh8ERnA
qCcEJHoFnVKjUfcwbvcItSvGQ4oCeRwVudMvnssRJPEseiE1BGQgDQm3OCJKSwqU
1nr+XDGiXxm1X9q3L+jlARFtXW6i1ZjcbAVQRqXqJk6vwEQHUa8O0MqDEiqKyHrK
rW/Ed+1H3nhJg+skD6P4lAaKEsaQGc4vi/BSoHWuHpoaX9oneCgRqpYmTp69DySS
rERavIhRYvEsCtgZyRb35KxvGXwEC42ZNLD397QVgbZvVkU4HBRNCsUsYpuhV0NW
7joIMYaxWFp3XtPIY+j0OCf86VAQBgTbLmLddJegObn6GCRmK8bNkmRYLnK3YaNE
DjoxtMsDoFqNduuOJnJbtmHZOZ2ShYs6FTWi5QKAzXlR7UtvYnsQbBUAX517czzn
mDBZbqpXcw9eJ4wnVFfIVYeYomF+95KzeoqH9f8ncSKwSH2r+GBwozZus6IwWQET
nNi45E/d38uQQswppcbHAcD3qyOyXyl8qTABUE6KOEMU4/A2hEpkm5XbcZPa3wEu
jyonoFMlG3qkj/8cWekhZ9SW2xhAfEF4x7hfkwhNoiWpfxNT+djzA5lt9jkaUys+
XYZQfHNflwGrnaeQBzAvs0ql+WVSlUsc/WAIyu7GkejPSGEmK64=
=hy4s
-----END PGP SIGNATURE-----

--ait5gh3b5i3rfonp--

