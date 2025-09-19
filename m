Return-Path: <linux-fsdevel+bounces-62246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A831B8A7F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C293A5A28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A96831D732;
	Fri, 19 Sep 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPBv3DG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC623C4F3;
	Fri, 19 Sep 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297906; cv=none; b=akWUe0npdfMec2LBnpr2V3xGJpPojR/CdKaFQ8XlT2xmOxFCDjt5v1rDyDZIkI/XDaKF/ZtO78gEGiMkLNguD+/IZ9352DGhxExcGzwGrxGRDJpVRGZKeVoEE/Q/g97TL38p/QJe8kTdNPijR+W1b01xKT+UzlmeuHauTp0b4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297906; c=relaxed/simple;
	bh=PMtrmBAyu9kJj4TQ0/QkV3dgRzc5oA5tHBt+BRc/7l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIgwKqRvLXKDOupIAZp0NgRtD3CF1etFLbM8NVn3pho3U2WG8/wNjwTBvDuveOJd8sY2Q3JhN3Fgi8j2lMnLbH9y0ZSixSFjioRZcRQ6OGKmvz/zq8geytKyomkRbsKexOOjLuVQyeOXZkxypp+6IbR8bC9tdAF7j9zvm68GkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPBv3DG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC783C4CEF0;
	Fri, 19 Sep 2025 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758297905;
	bh=PMtrmBAyu9kJj4TQ0/QkV3dgRzc5oA5tHBt+BRc/7l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPBv3DG/SEJExSAlUbMHF1lQpLovcWtBuMrKsfp7T7A0xn5bqwAPjBLgTowk32Mt5
	 xZUSGMSXvWiL+MUvg6zW/679WPfzkbD3N5DYZk/tPg/woG6dTTtazjF6TSGijniD/G
	 kPVAgvaoiCQZ1/4odPLFllRnB6jvHOP0De7C9+JgpYThKgXu18ef3sQihx9Ux8AmWa
	 vt1mSv2jUG2QU7dTtg2yT0quogL2EDXNPuYgg2XceEpEacYzDEOtjNs8lgjIDBJLrO
	 VXtaEWFMAovdRGVT7vPSEU6zPb2z4e0HA+DJ4+hLzBYBjsXKD2v2df3LryiVqlycHC
	 IRUYBFZUjUUhg==
Date: Fri, 19 Sep 2025 18:04:57 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 01/10] man/man2/mount_setattr.2: move mount_attr
 struct to mount_attr(2type)
Message-ID: <r5fqew7m7vfg2mp5mgivxeghotymhzxpdnducp6jejxlbkaphw@7gi63phcgpfd>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-1-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gsbr7iv2jhmeqccn"
Content-Disposition: inline
In-Reply-To: <20250919-new-mount-api-v4-1-1261201ab562@cyphar.com>


--gsbr7iv2jhmeqccn
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
Subject: Re: [PATCH v4 01/10] man/man2/mount_setattr.2: move mount_attr
 struct to mount_attr(2type)
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-1-1261201ab562@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250919-new-mount-api-v4-1-1261201ab562@cyphar.com>

On Fri, Sep 19, 2025 at 11:59:42AM +1000, Aleksa Sarai wrote:
> As with open_how(2type), it makes sense to move this to a separate man
> page.  In addition, future man pages added in this patchset will want to
> reference mount_attr(2type).
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Hi Aleksa,

Thanks!  I've applied this patch.


Have a lovely day!
Alex

> ---
>  man/man2/mount_setattr.2      | 17 ++++--------
>  man/man2type/mount_attr.2type | 61 +++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 66 insertions(+), 12 deletions(-)
>=20
> diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> index 586633f48e894bf8f2823aa7755c96adcddea6a6..4b55f6d2e09d00d9bc4b3a085=
f310b1b459f34e8 100644
> --- a/man/man2/mount_setattr.2
> +++ b/man/man2/mount_setattr.2
> @@ -114,18 +114,11 @@ .SH DESCRIPTION
>  .I attr
>  argument of
>  .BR mount_setattr ()
> -is a structure of the following form:
> -.P
> -.in +4n
> -.EX
> -struct mount_attr {
> -    __u64 attr_set;     /* Mount properties to set */
> -    __u64 attr_clr;     /* Mount properties to clear */
> -    __u64 propagation;  /* Mount propagation type */
> -    __u64 userns_fd;    /* User namespace file descriptor */
> -};
> -.EE
> -.in
> +is a pointer to a
> +.I mount_attr
> +structure,
> +described in
> +.BR mount_attr (2type).
>  .P
>  The
>  .I attr_set
> diff --git a/man/man2type/mount_attr.2type b/man/man2type/mount_attr.2type
> new file mode 100644
> index 0000000000000000000000000000000000000000..f5c4f48be46ec1e6c0d3a211b=
6724a1e95311a41
> --- /dev/null
> +++ b/man/man2type/mount_attr.2type
> @@ -0,0 +1,61 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH mount_attr 2type (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +mount_attr \- what mount properties to set and clear
> +.SH LIBRARY
> +Linux kernel headers
> +.SH SYNOPSIS
> +.EX
> +.B #include <sys/mount.h>
> +.P
> +.B struct mount_attr {
> +.BR "    u64 attr_set;" "     /* Mount properties to set */"
> +.BR "    u64 attr_clr;" "     /* Mount properties to clear */"
> +.BR "    u64 propagation;" "  /* Mount propagation type */"
> +.BR "    u64 userns_fd;" "    /* User namespace file descriptor */"
> +    /* ... */
> +.B };
> +.EE
> +.SH DESCRIPTION
> +Specifies which mount properties should be changed with
> +.BR mount_setattr (2).
> +.P
> +The fields are as follows:
> +.TP
> +.I .attr_set
> +This field specifies which
> +.BI MOUNT_ATTR_ *
> +attribute flags to set.
> +.TP
> +.I .attr_clr
> +This field specifies which
> +.BI MOUNT_ATTR_ *
> +attribute flags to clear.
> +.TP
> +.I .propagation
> +This field specifies what mount propagation will be applied.
> +The valid values of this field are the same propagation types described =
in
> +.BR mount_namespaces (7).
> +.TP
> +.I .userns_fd
> +This field specifies a file descriptor that indicates which user namespa=
ce to
> +use as a reference for ID-mapped mounts with
> +.BR MOUNT_ATTR_IDMAP .
> +.SH STANDARDS
> +Linux.
> +.SH HISTORY
> +Linux 5.12.
> +.\" commit 2a1867219c7b27f928e2545782b86daaf9ad50bd
> +glibc 2.36.
> +.P
> +Extra fields may be appended to the structure,
> +with a zero value in a new field resulting in
> +the kernel behaving as though that extension field was not present.
> +Therefore, a user
> +.I must
> +zero-fill this structure on initialization.
> +.SH SEE ALSO
> +.BR mount_setattr (2)
>=20
> --=20
> 2.51.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--gsbr7iv2jhmeqccn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjNfygACgkQ64mZXMKQ
wqmTIQ/+NHy8YgPxvcmYQgOyqfDHhQiCy83I0LH5TUHrfK7J53AanIHUvdESOaMS
sciSRRcfcxU9EOO/GNR2tAAyRxYTeYfYM2jXihF0Vvk57+dVHir9oEp7AnrS9pP7
EA3V7xHskyvNJLfNWnQClSW5l6y6+QdzghOO5Vp3BGi/SjtSfpFcKNWFUUIFID6S
pNRw9wjRcbQ/MC7AswhXFwbvCgNIEiNCAf6K9uCt8gcr9R1Pg06z31K92BrOQrSg
dGax1hYFDymM1jRRr98dkF6GkQ/vtxepMlRFlu2F7URNIN+G5cT2yPiJiXCrY5Kx
oLmM1PmFX02C6uTwTlXunRyI11p7dyy37OKn8fXipJNcIDwxGn/8lsa2beNyLMJu
n5ZH4L33pZEw2gm1nGz/tfcrOzX9LSnz6RODGxOBYSil3AYT5QC1NeOreCLBH4eu
kSdPSWyDhd2wSJvOmpcU7ILqgx5lyZnaWAJ1ZV0ECYYlc+f3A40KAqly/838+/8a
yuyYbh7ZPSzOoh5EhV20O2cutiRYVO1QQOkxppvr1i3YLwYB514e+ojrQWiO5man
xqlm3GfPBgbq41V2w7V5oxX5xzcQy3glKqEy3ct5/UThJe1+JwAQSAOS1NFqTElj
RmqqSIB0pPBSYhQ01qYVM9/4rAr20zFbP+ezWaWBMbujmwNT/SI=
=JcSz
-----END PGP SIGNATURE-----

--gsbr7iv2jhmeqccn--

