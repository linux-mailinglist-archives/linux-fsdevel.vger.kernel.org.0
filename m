Return-Path: <linux-fsdevel+bounces-56970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A43B1D664
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C5067A72B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DAB277C87;
	Thu,  7 Aug 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCaoB49H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F94231A55;
	Thu,  7 Aug 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565076; cv=none; b=kU+6QeKOzeqS/o80m80goqvz5t8kxFSuFdtFeN6VL8r1m4oWF1ht3ZsK92wK3ROzsbRCG+6dwqGKT6G/B0W/G7Ns/ousdB6G8WTP6QYkawmLauYVH1BJZDB5lY1R6h4Wdk+M8No9zVDQsZjwMCu887UoSr57rfKViTxLLTK4Hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565076; c=relaxed/simple;
	bh=gPoeZoK5liebP6zDwK59tggbgRkDGLyVHXWfBCPFvbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv66UPD3EBjIEDDfPmQBWFi/A5g1hqNg37eWkeCtJSCsVwfhMmpaX/tgQN6J+Ie+NMG0My4PuK0ip6iVR7IspIEA43NExoEAiH/kLiZ0GcJVGquSG3p/ji2swCaMhHolLdhR6PuguIjzhqYFoIowsqAdZaACp3uSG79YbCR5XU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCaoB49H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF8EC4CEEB;
	Thu,  7 Aug 2025 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754565075;
	bh=gPoeZoK5liebP6zDwK59tggbgRkDGLyVHXWfBCPFvbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCaoB49HTCUvH8I8PhurMsQzYrBrbd07Pj1blXzkoj2zhTJC5jfgzRGSEqqmL7nSa
	 WkDHeCT60yksOPDKqdGsbjjrhoeCJm12gc/YEl4QMMMa9eDP1KdDNjuQ/vOqNum/WT
	 2zEmEXQhbjR26qsy/jsrgsPCow4w3YXtxRas1SPYWB3S53qbGfjqN1zpH+DJIsaiRC
	 ag5UBbh+6DIWpqx5k2MNArPV+QKCR8JCTjil6bCUI61KEVsb1POwUkJ4xHxN5pPMaH
	 sc/w4SEvLO3L/XQI5fKw6Jf6ThngmFqAp6wvyzUsKXm/XK5zDhDgTvkU7Srb5roUfi
	 bNZa2dsH3awEg==
Date: Thu, 7 Aug 2025 13:11:06 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 02/11] mount_setattr.2: move mount_attr struct to
 mount_attr.2type
Message-ID: <cselxzuadkkf4cfx45fm3cm77mkq7gxrbzg7idr5726p52w5qa@sarhby7scgp6>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-2-558a27b8068c@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3r3ryjdhw7s6f36v"
Content-Disposition: inline
In-Reply-To: <20250807-new-mount-api-v2-2-558a27b8068c@cyphar.com>


--3r3ryjdhw7s6f36v
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
Subject: Re: [PATCH v2 02/11] mount_setattr.2: move mount_attr struct to
 mount_attr.2type
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-2-558a27b8068c@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250807-new-mount-api-v2-2-558a27b8068c@cyphar.com>

Hi Aleksa,

On Thu, Aug 07, 2025 at 03:44:36AM +1000, Aleksa Sarai wrote:
> As with open_how(2type), it makes sense to move this to a separate man
> page.  In addition, future man pages added in this patchset will want to
> reference mount_attr(2type).
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man/man2/mount_setattr.2      | 17 ++++---------
>  man/man2type/mount_attr.2type | 58 +++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 63 insertions(+), 12 deletions(-)
>=20
> diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> index c96f0657f046..d44fafc93a20 100644
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
> index 000000000000..b7a3ace6b3b9
> --- /dev/null
> +++ b/man/man2type/mount_attr.2type
> @@ -0,0 +1,58 @@
> +

Please remove this blank.  It is not diagnosed by groff(1), but I think
it should be diagnosed (blank lines are diagnosed elsewhere).  I've
reported a bug to groff(1) (Branden will be reading this, anyway).

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
> +.BR "    __u64 attr_set;" "     /* Mount properties to set */"
> +.BR "    __u64 attr_clr;" "     /* Mount properties to clear */"
> +.BR "    __u64 propagation;" "  /* Mount propagation type */"
> +.BR "    __u64 userns_fd;" "    /* User namespace file descriptor */"
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
> +This fields specifies which
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
> +This fields specifies a file descriptor that indicates which user namesp=
ace to

s/fields/field/

> +use as a reference for ID-mapped mounts with
> +.BR MOUNT_ATTR_IDMAP .
> +.SH VERSIONS
> +Extra fields may be appended to the structure,
> +with a zero value in a new field resulting in
> +the kernel behaving as though that extension field was not present.
> +Therefore, a user
> +.I must
> +zero-fill this structure on initialization.

I think this would be more appropriate for HISTORY.  In VERSIONS, we
usually document differences with the BSDs or other systems.

While moving this to HISTORY, it would also be useful to mention the
glibc version that added the structure.  In the future, we'd document
the versions of glibc and Linux that have added members.

> +.SH STANDARDS
> +Linux.
> +.SH SEE ALSO
> +.BR mount_setattr (2)

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--3r3ryjdhw7s6f36v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiUicoACgkQ64mZXMKQ
wqlXXQ/+JjKQpoNg8VTZVt84RZf2V2f+x5+0ztsw78i5Q9KS6szQCG/M7gMlpvEA
OqKz65374rMAws/6+odAbh8bkQT66tT7VwUYprl4ZA+YtDHJ8xgIYtyasg2AOt+L
oVHq7L/k/tSu0Dy+AW81YNDrqIUrfFDGdWcp6CiDf80RXk6J+Z8CAw8vQgam0Gnl
qr12YRIet69fo6/CYwyP4vMrO1S8hq417odfn6SEs/cfkVvP9WrDCO+4ehKp6j0N
gaa35px0M0VLd2Vtz7i8IjQXISmdsHW+/hdJpYE1DERcewNbU6cawZYOfBUQFv7N
3DWhwZffVJ55F7Ru+0OK8dveasa97stao4gHn9Oav5MAIRapcOqPNVXWRdAwpaqC
cmw0C+IapJGtif50j70fiRuktnfzFrZl2ZyfrBgYK6nLaTsVGpeFMOgMBegkP4tN
hBpF1eemiGltuMGEwf6jqFiSTjHv6UQPVBxcWZlFM6pqQEFJW3g3Pu8hleh20iJD
dwJJy+LQwscgyBp50k7NUTB7+1L4ZwomA7WUE4/367yuWBCYrpr179UjJo0ZQuar
udlVYfWunn3E5F/qtDVwXBC09wJExHFnp426qsrtg+QDEg2dhEOviT7fYvO2Dvet
L3dN2YJkNdNGAH1MzyF46LXQ4Md/6TqX7AoXunG9M+JKbgHJyEg=
=39AD
-----END PGP SIGNATURE-----

--3r3ryjdhw7s6f36v--

