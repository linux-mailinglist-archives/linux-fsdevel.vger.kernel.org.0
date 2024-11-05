Return-Path: <linux-fsdevel+bounces-33703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91C9BD8F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 23:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F234B1F23B3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E82216429;
	Tue,  5 Nov 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5VXEGAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE601CCB2D;
	Tue,  5 Nov 2024 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846608; cv=none; b=j1GKo8ypTAmSiOBg3G+awKu6B4WqQj6HFh6auevvzSl4BlZOjyzqKuNd/Jglhkce/tmz+gfuV8nSRH2QtkyxQ2nXzGcInHYSFaCkxKVVEkCGjzf0CM9rb4iVbFyUct6jZIpnU/Yw24wAWl+RsWCytMs4w59ce5jmjHQn/2j6Qp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846608; c=relaxed/simple;
	bh=29VB2TXgezrGxJiDRLSawh3OzeWo4mP3g/A1sgE/KEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEVuVwn0glMADJ1FtDwi47OLgYyQ4k74q/NsjMTJ9IosCKLUR1tiurQDCz+ixpobJ96b02fm/qqpAA2uzSaT8PFntNmuZQF1dErH2BWdYF2w4hqw2zB/0ZX6d0EViBiZMUwMVhWfL1TS39B58ozYOXiCK7SQr2p84Q5Jl8kb/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5VXEGAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B834AC4CECF;
	Tue,  5 Nov 2024 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730846607;
	bh=29VB2TXgezrGxJiDRLSawh3OzeWo4mP3g/A1sgE/KEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5VXEGADucAFWOV/mozkObc6ls8gN8ONauf78U5mrAmyQGc5n9H/3R06b5KaUmemZ
	 CtR9i9BmwyzxqypoMGjxlKSWysalCt05IbvL+m7wLQevz4+ugy40wV+xJ/FF+6zWPG
	 iSTquanDYGKSBeEFWOdXLn49L7skemcJksUQeTrV3PuD5bP6lPhJX7dqvyx3F2RQbq
	 wH5K+ASAtwWFB7TcORUYpUzkL8B72lThzG1S816m2+MAjaSKo5fSdYu6i1Gj/h00PP
	 eSuOOAmit3e2/Fb0lePKcFlfC+MLQg0Vn8xQZA/353JwQNzBzTUIs2UGG6ySVeEKsT
	 USn/iRIaIihtg==
Date: Tue, 5 Nov 2024 23:43:24 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify.7,fanotify_mark.2: update documentation of
 fanotify w.r.t fsid
Message-ID: <6zhqson7n7774gol46cmpcgbgyhsly3ehnpyzl5u54dudd7syl@vosk5uoaifqg>
References: <20241105144939.181820-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kthqnoivccu52h6w"
Content-Disposition: inline
In-Reply-To: <20241105144939.181820-1-amir73il@gmail.com>


--kthqnoivccu52h6w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify.7,fanotify_mark.2: update documentation of
 fanotify w.r.t fsid
References: <20241105144939.181820-1-amir73il@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20241105144939.181820-1-amir73il@gmail.com>

Hi Amir,

On Tue, Nov 05, 2024 at 03:49:39PM GMT, Amir Goldstein wrote:
> Clarify the conditions for getting the -EXDEV and -ENODEV errors.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Patch applied.  Thanks!
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Df6ebb46dfba40902656321f16bfb38daf4d99377>

I've also applied Jan's Review tag, since the changes are minimal.
BTW, I would appreciate range-diffs, as recommended in
<./CONTRIBUTING.d/patches>.

Please have a look at these:
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTRIBUT=
ING.d/patches>
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTRIBUT=
ING.d/git>

Have a lovely night!
Alex

> ---
>=20
> Changes since v1:
> - Fix review comments [1]
>=20
> [1] https://lore.kernel.org/linux-fsdevel/20241101130732.xzpottv5ru63w4wd=
@devuan/
>=20
>  man/man2/fanotify_mark.2 | 27 +++++++++++++++++++++------
>  man/man7/fanotify.7      | 11 +++++++++++
>  2 files changed, 32 insertions(+), 6 deletions(-)
>=20
> diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> index fc9b83459..47cafb21c 100644
> --- a/man/man2/fanotify_mark.2
> +++ b/man/man2/fanotify_mark.2
> @@ -659,17 +659,16 @@ The filesystem object indicated by
>  .I dirfd
>  and
>  .I pathname
> -is not associated with a filesystem that supports
> +is associated with a filesystem that reports zero
>  .I fsid
>  (e.g.,
>  .BR fuse (4)).
> -.BR tmpfs (5)
> -did not support
> -.I fsid
> -prior to Linux 5.13.
> -.\" commit 59cda49ecf6c9a32fae4942420701b6e087204f6
>  This error can be returned only with an fanotify group that identifies
>  filesystem objects by file handles.
> +Since Linux 6.8,
> +.\" commit 30ad1938326bf9303ca38090339d948975a626f5
> +this error can be returned
> +when trying to add a mount or filesystem mark.
>  .TP
>  .B ENOENT
>  The filesystem object indicated by
> @@ -768,6 +767,22 @@ which uses a different
>  than its root superblock.
>  This error can be returned only with an fanotify group that identifies
>  filesystem objects by file handles.
> +Since Linux 6.8,
> +.\" commit 30ad1938326bf9303ca38090339d948975a626f5
> +this error will be returned
> +when trying to add a mount or filesystem mark on a subvolume,
> +when trying to add inode marks in different subvolumes,
> +or when trying to add inode marks in a
> +.BR btrfs (5)
> +subvolume and in another filesystem.
> +Since Linux 6.8,
> +.\" commit 30ad1938326bf9303ca38090339d948975a626f5
> +this error will also be returned
> +when trying to add marks in different filesystems,
> +where one of the filesystems reports zero
> +.I fsid
> +(e.g.,
> +.BR fuse (4)).
>  .SH STANDARDS
>  Linux.
>  .SH HISTORY
> diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> index 449af949c..b270f3c99 100644
> --- a/man/man7/fanotify.7
> +++ b/man/man7/fanotify.7
> @@ -575,6 +575,17 @@ and contains the same value as
>  .I f_fsid
>  when calling
>  .BR statfs (2).
> +Note that some filesystems (e.g.,
> +.BR fuse (4))
> +report zero
> +.IR fsid .
> +In these cases,
> +it is not possible to use
> +.I fsid
> +to associate the event with a specific filesystem instance,
> +so monitoring different filesystem instances that report zero
> +.I fsid
> +with the same fanotify group is not supported.
>  .TP
>  .I handle
>  This field contains a variable-length structure of type
> --=20
> 2.34.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--kthqnoivccu52h6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmcqn4wACgkQnowa+77/
2zLh8w/9GV+eQy78V1nxTuJjyjrH38fT3VuJHng96dvWAKv8PWQFoF9b8++4svPO
EbMjtisYuilAOXTCYV9Aa7KcAtcnWphX+lTmN0/KqIVzntui2WEDE/YUo1tRTlJy
LD+haPUoMR8cwx5M56UHVJ5gSDaHl1V2Ef2L8mkXz4rhI7+Ca/75v+eZpusyhcu5
7kC3nnHS5PJPsyNwRpHH/5I+4vKtUUGd6UMJkVE+Ux8fh8D5ibfkeTifvn7Vn4Or
8tFpz/XzN0ibYtU6Pr+ypXmPQvvkJ7Zgvw1puN6WX5RhAM1Cbp5ib3olb48fbe1R
z4tPbn+1VeIFHSqPo0m3zNo3PC9TQLLDr5nx/6LAE0U26tdZCWYF+v0l0nsyfsX8
t+bRXsLqYfkFnSWuQBvnmswbTFOAnA9iKBvROPgBl5Fv9JNN7XD2Kei0RvaLJYKJ
GY+fKg8lZUCxLBxFsNoKRsjM6QhjUe1AJYET8t3j1thIpmmVm1SNwY0emiH78+hB
EydUwh3TQzRHOtlJJtdrbKcNn9UHIVo5037x5WaIvX6ncItdkaRq6we/t7PovUM8
oY843zCldeToMsGC2iVnSKFlqyWmtfZwN/ivUTFdQdpUf1r14baxz16GYOZ02fOb
e6qEHU3kQ4yadSxwxH+HfR2uDjK+pxBxH6Xvx7CD6XQKTXn8c+Y=
=gJJa
-----END PGP SIGNATURE-----

--kthqnoivccu52h6w--

