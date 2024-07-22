Return-Path: <linux-fsdevel+bounces-24096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F19394BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 22:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F6E1F21E7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3156A288D1;
	Mon, 22 Jul 2024 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqAxDNPc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144917C8D;
	Mon, 22 Jul 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680047; cv=none; b=MoiukQdnxUf0gdkVBcwz2JQApN3XQZC19cg1CdHK1axdnkB7h4x0MrbPeOO9laTO7/RAseKunVhj1W0wjvXW2SJZNdvMlwCDQsIgwudi+lvwMZ/YrtO9kuULMljVyf8o4thmEZh5Tzdx+KyDbwHVjERLLkM/8BxJqD52gRsXshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680047; c=relaxed/simple;
	bh=lusNyf/xLjtZRm1x39ktIQYoTwrFggjIGgA1BAnjl/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8nI3iqaU0kHpTfAiRzRi+UTrWnUPOmImQru1TZL63HW478lyrdC7fF1c4ke9v1yBo1i4Pb30XoGXQUCn28QCL2lGK7/Ely5DAu/w0Ik66kEsaxmfFfAfSAhyUSnmbGC7wmtCxMrTvIScLHVQyTA6zIssQ9qh7l7rNWaJ5PnpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqAxDNPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5024C4AF0A;
	Mon, 22 Jul 2024 20:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721680047;
	bh=lusNyf/xLjtZRm1x39ktIQYoTwrFggjIGgA1BAnjl/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqAxDNPcKc8rd7FgITEwgRrmqCBGKdCnZ/a2Sz1jL+T4tMacVFXFRyuRNxvl+Q2mT
	 R795Rn8xJ3x6E+eL/NhCfBJsT78sunqPKDS39RoV/PB75PGOBvcPJI+cU7EllmAOtP
	 BhzuuEbmqV6LSlIaGahCQ7a3cfH/wuGMJ45gJAorOwyXD5fbNcFuaek+C0XF9urfXr
	 dIAgduLTdB4zpIyy/1peJPnpfM3VOvF/FQDVeZxzHZACe2cooIBvwCr/iF4mqegZwn
	 ZjLJTM4fGnvSfhTCG3nevn8IWsCiecg9Yciw3q1uGfdEpsNfelC7CAmeaufdukT73a
	 duVsKEJHcWC1A==
Date: Mon, 22 Jul 2024 22:27:23 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v6 2/2] listmount.2: New page describing the listmount
 syscall
Message-ID: <54hz2cqibnocv7jtv6sxk3dta36bm32i7f6tzdqcjmtf4cmfyt@cv2g25p733y5>
References: <cover.1720549824.git.josef@toxicpanda.com>
 <2d72a44fa49f47bd7258d7efb931926b26de4004.1720549824.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yj2wy4nt2iutayes"
Content-Disposition: inline
In-Reply-To: <2d72a44fa49f47bd7258d7efb931926b26de4004.1720549824.git.josef@toxicpanda.com>


--yj2wy4nt2iutayes
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v6 2/2] listmount.2: New page describing the listmount
 syscall
References: <cover.1720549824.git.josef@toxicpanda.com>
 <2d72a44fa49f47bd7258d7efb931926b26de4004.1720549824.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <2d72a44fa49f47bd7258d7efb931926b26de4004.1720549824.git.josef@toxicpanda.com>

Hi Josef,

On Tue, Jul 09, 2024 at 02:31:23PM GMT, Josef Bacik wrote:
> Add some documentation for the new listmount syscall.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks!  I've applied the patch with some minor tweaks:

	diff --git i/man/man2/listmount.2 w/man/man2/listmount.2
	index 212929fb6..8f7c7afaa 100644
	--- i/man/man2/listmount.2
	+++ w/man/man2/listmount.2
	@@ -4,7 +4,9 @@
	 .\"
	 .TH listmount 2 (date) "Linux man-pages (unreleased)"
	 .SH NAME
	-listmount \- get a list of mount ID's
	+listmount
	+\-
	+get a list of mount ID's
	 .SH LIBRARY
	 Standard C library
	 .RI ( libc ", " \-lc )
	@@ -14,15 +16,15 @@ .SH SYNOPSIS
	 .B #include <unistd.h>
	 .P
	 .BI "int syscall(SYS_listmount, struct mnt_id_req * " req ,
	-.BI "            u64 * " mnt_ids ", size_t " nr_mnt_ids ,
	+.BI "            uint64_t * " mnt_ids ", size_t " nr_mnt_ids ,
	 .BI "            unsigned long " flags );
	 .P
	 .B #include <linux/mount.h>
	 .P
	 .B struct mnt_id_req {
	-.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
	-.BR "    __u64 mnt_id;" "  /* The parent mnt_id being searched */"
	-.BR "    __u64 param;" "   /* The next mnt_id we want to find */"
	+.BR "    __u32  size;" "    /* sizeof(struct mnt_id_req) */"
	+.BR "    __u64  mnt_id;" "  /* The parent mnt_id being searched */"
	+.BR "    __u64  param;" "   /* The next mnt_id we want to find */"
	 .B };
	 .fi
	 .P
	@@ -45,7 +47,8 @@ .SS The mnt_id_req structure
	 is used by the kernel to determine which struct
	 .I mnt_id_req
	 is being passed in,
	-it should always be set to sizeof(struct mnt_id req).
	+it should always be set to
	+.IR \%sizeof(struct\~mnt_id_req) .
	 .P
	 .I req.mnt_id
	 is the parent mnt_id that we will list from,
	@@ -69,7 +72,8 @@ .SS The mnt_id_req structure
	 .SH RETURN VALUE
	 On success, the number of entries filled into
	 .I mnt_ids
	-is returned, 0 if there are no more mounts left.
	+is returned;
	+0 if there are no more mounts left.
	 On error, \-1 is returned, and
	 .I errno
	 is set to indicate the error.

Would you mind adding an example program in a new patch?

Have a lovely night!
Alex

> ---
>  man/man2/listmount.2 | 112 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 man/man2/listmount.2
>=20
> diff --git a/man/man2/listmount.2 b/man/man2/listmount.2
> new file mode 100644
> index 000000000..212929fb6
> --- /dev/null
> +++ b/man/man2/listmount.2
> @@ -0,0 +1,112 @@
> +.\" Copyright (c) 2024 Josef Bacik <josef@toxicpanda.com>
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH listmount 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +listmount \- get a list of mount ID's
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ", " \-lc )
> +.SH SYNOPSIS
> +.nf
> +.BR "#include <linux/mount.h>" "  /* Definition of struct mnt_id_req con=
stants */"
> +.B #include <unistd.h>
> +.P
> +.BI "int syscall(SYS_listmount, struct mnt_id_req * " req ,
> +.BI "            u64 * " mnt_ids ", size_t " nr_mnt_ids ,
> +.BI "            unsigned long " flags );
> +.P
> +.B #include <linux/mount.h>
> +.P
> +.B struct mnt_id_req {
> +.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
> +.BR "    __u64 mnt_id;" "  /* The parent mnt_id being searched */"
> +.BR "    __u64 param;" "   /* The next mnt_id we want to find */"
> +.B };
> +.fi
> +.P
> +.IR Note :
> +glibc provides no wrapper for
> +.BR listmount (),
> +necessitating the use of
> +.BR syscall (2).
> +.SH DESCRIPTION
> +To access the mounts in your namespace,
> +you must have CAP_SYS_ADMIN in the user namespace.
> +.P
> +This function returns a list of mount IDs under the
> +.BR req.mnt_id .
> +This is meant to be used in conjuction with
> +.BR statmount (2)
> +in order to provide a way to iterate and discover mounted file systems.
> +.SS The mnt_id_req structure
> +.I req.size
> +is used by the kernel to determine which struct
> +.I mnt_id_req
> +is being passed in,
> +it should always be set to sizeof(struct mnt_id req).
> +.P
> +.I req.mnt_id
> +is the parent mnt_id that we will list from,
> +which can either be
> +.B LSMT_ROOT
> +which means the root mount of the current mount namespace,
> +or a mount ID obtained from either
> +.BR statx (2)
> +using
> +.B STATX_MNT_ID_UNIQUE
> +or from
> +.BR listmount (2) .
> +.P
> +.I req.param
> +is used to tell the kernel what mount ID to start the list from.
> +This is useful if multiple calls to
> +.BR listmount (2)
> +are required.
> +This can be set to the last mount ID returned + 1 in order to
> +resume from a previous spot in the list.
> +.SH RETURN VALUE
> +On success, the number of entries filled into
> +.I mnt_ids
> +is returned, 0 if there are no more mounts left.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EPERM
> +Permission is denied for accessing this mount.
> +.TP
> +.B EFAULT
> +.I req
> +or
> +.I mnt_ids
> +points to a location outside the process's accessible
> +address space.
> +.TP
> +.B EINVAL
> +Invalid flag specified in
> +.IR flags .
> +.TP
> +.B EINVAL
> +.I req
> +is of insufficient size to be utilized.
> +.TP
> +.B E2BIG
> +.I req
> +is too large,
> +the limit is the architectures page size.
> +.TP
> +.B ENOENT
> +The specified
> +.I req.mnt_id
> +doesn't exist.
> +.TP
> +.B ENOMEM
> +Out of memory (i.e., kernel memory).
> +.SH STANDARDS
> +Linux.
> +.SH SEE ALSO
> +.BR statmount (2),
> +.BR statx (2)
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--yj2wy4nt2iutayes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaewKsACgkQnowa+77/
2zJHPBAAlySwhcchiob/GvV2NgLLpGCN64jDzBbZ62OqpaLV8Nv82fL7ugxQJmpC
l690gBTX97OYKgui03skHzr5D7810zOwoeTahkUo5u18ngXhil/HF1LNOoenQh6y
REtkRPKEhanP853x3qls1CcaiZbR/1INwlcUL6b3npxfzJhdfdxQBorAsVv8/2et
T2u9OPGnHFjRap74iSPyO3Vi73CMGP+2Q+A4Xk7LIc3PZBjrjCmGDN8VFJ3L/jjG
vrEpcmQdxNB7YLthB/FKflcBmoiCmVHDLFAQTi+7ALUkJSul7ze8xhbYY5QyMNNp
HVHCQLEpzXHLtECWZG31PVZFRXicHccrFRh17ARaOeJCBTkvghi9mZuQ7PZlzF+I
dIH9Oui/EC96RCp39l0UqwXX3AeYAhwycjDCiqgS/4dh6UN9wQynzi6RcCwGPv3r
f+IWomSAWIijStZONaL2loywmrXmMYuMPBtn/daSqsXd0r1Vzd3Ef4Tdf5KfPW7F
jiwWwJ35HSOnwYvDyLofXfw42IOhJESc70FFlIY2weizfCsl5rR0HJZ4uSjLI22u
+hL9XjC3pyeHUk7MNC39pBMvj76N3y4ebB8rX3bUtK879URkTtZ1ZxlYEZv1FVya
NDHK1k8A0AVqeZUQt4ETmovoUBFa5r7kOujbnAnhIkxwnLMYXck=
=ELYg
-----END PGP SIGNATURE-----

--yj2wy4nt2iutayes--

