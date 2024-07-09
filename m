Return-Path: <linux-fsdevel+bounces-23429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6403692C2CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7BB283078
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A550D17B03A;
	Tue,  9 Jul 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTJgMo5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7521B86CF;
	Tue,  9 Jul 2024 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547396; cv=none; b=tG2N3K2xVbl/aXA7HoVMMjnk52fd/wH5hVfNKQQU2RfKfGsqTo5ym4tkawySKTOBDxUFGtB6Qy68t5XJKPs6hrY3wcZaDKeie1pfhOUAbPt0XFvk4HxP1hTyX1bjPDoHXIPr6lIYq9Nh9Pi6iZZX5B75D4/AsKxpFHIIi7P/qQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547396; c=relaxed/simple;
	bh=NYjL2mkKRHOkL3cYxVe9qiyRafXgspQHNQg+LiwnRos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVYZ0NCLvdCN6REtaK8Za1KQxMyYbcJdWJW50jv0xres3ka/m3FMBl8PgQnPOjF9whOrsvIqO/RuK2MLQpKl/EePs6sThPBQKTUxUVcQF3W6f1dsprewM9QNdglrtXFmMbHhDNfJXIJufCnOJrQuxRoHJmnNKjCcy5wHwXAT9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTJgMo5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F30C3277B;
	Tue,  9 Jul 2024 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720547395;
	bh=NYjL2mkKRHOkL3cYxVe9qiyRafXgspQHNQg+LiwnRos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTJgMo5y5N3CyCtpDz37iXMAZI9Sz1us8af/GT0CV3LH7fRMDAhvbH/GhzWAwUvr+
	 ryWigUhTczfhiteeodkwcnuEAs9mcEvEZ605+jY7z4OX1rZkzPIjcVMXPHC4n2TC33
	 ZA6mPy/liRPmm+PzxSfVv4Zhkup4KLOmHK+NfWGiHLUj27n27ZVxfj5Eb6NNTYvLnh
	 Hssd/76P5yWGlo21xco4MMX0jCVq7s74Snj8MaVjv7lArOUMDGuMpUImh6HjvUMo+g
	 pQJiuZHUzWwBTJhnhDYFywVTWELJo0o4Xezc179DBEMoCNkg9BNihn+l+seigNweYP
	 JUnQhZfM5rTrw==
Date: Tue, 9 Jul 2024 19:49:52 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] listmount.2: New page describing the listmount
 syscall
Message-ID: <2ws56dqn2x47qcl2snrbwndu5hjiu6smb6dfwldoy5v634p2by@xdxjvrhpo2cg>
References: <cover.1720545710.git.josef@toxicpanda.com>
 <9e16975fb6cb9baf11e485368cfcbbbd5fb87207.1720545710.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udjve4sw4uxhekdd"
Content-Disposition: inline
In-Reply-To: <9e16975fb6cb9baf11e485368cfcbbbd5fb87207.1720545710.git.josef@toxicpanda.com>


--udjve4sw4uxhekdd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] listmount.2: New page describing the listmount
 syscall
References: <cover.1720545710.git.josef@toxicpanda.com>
 <9e16975fb6cb9baf11e485368cfcbbbd5fb87207.1720545710.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <9e16975fb6cb9baf11e485368cfcbbbd5fb87207.1720545710.git.josef@toxicpanda.com>

On Tue, Jul 09, 2024 at 01:25:43PM GMT, Josef Bacik wrote:
> Add some documentation for the new listmount syscall.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  man/man2/listmount.2 | 111 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 man/man2/listmount.2
>=20
> diff --git a/man/man2/listmount.2 b/man/man2/listmount.2
> new file mode 100644
> index 000000000..a86f59a6d
> --- /dev/null
> +++ b/man/man2/listmount.2
> @@ -0,0 +1,111 @@
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
> +is NULL or points to a location outside the process's

Remove the mention of NULL for simplicity.

> +accessible address space.
> +.TP
> +.B EINVAL
> +Invalid flag specified in
> +.IR flags .
> +.TP
> +.B EINVAL
> +.I req
> +is of insufficient size to be utilized.

=2ETP

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

--udjve4sw4uxhekdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNeEAACgkQnowa+77/
2zLpNA/+OmiYOLtgrlk0leuybDZkXnIZUeeHSvV+cOStw+M5gSDPPY/xMeeOr+Nx
91+T4HX4Li3c0L9qUSAL1/DszvQY0NlU2Ip76hLoLzhIZRThb9plAprQklh36I6m
E2dtOIPvh5PBTp4Jhnaqf0r9pLTf5i2WfXQBv//8kh9Cgn04bcjaDhQtlabE13zb
HwJqKRJRXXfGY4a1v8TbXBOL7WlpJlDg9yL8EkcG3DMmZb33ZOGTWTzEv8v4+JYO
Qq8re6H6twP5h96NnYEILa1kjGEVi9P+VY21mLNJo3XLzZ8felQ+AgnfW3lS+Ths
wcXFnW81gnYbyEYUhd9pyBhmek7SLfrnsCPGgvRIFx9J44kBvg6s1vVEYmeYMCCE
pobBZOpOPc6o1Z//xhj3kxCN3Jo3Ys9ZhbB3Ax20/AWWP5kH9w6/vVYaWYNTi5zM
YxflvK96y3xX3hLABgOD2P0g39ro30yflay06gsuGS0a/qpO9tnq4kGgMnLCHPzf
m4xAMARcUDTbSKuOCaldVtdDlUaCFzFbdUKkFTDP4ISzVdHcH74HfY3dPIwWOlsd
v3S6SPKaFehjZpSKu/LoId66eD4rIk8igBj9M94zRTatRq2cbxa+Vu9hqjqSbsAL
8MxXyUar/1fwGr7BytU9pWBEVhPRrxWOFpFkN5FJ5QjTdGMfY3I=
=68BO
-----END PGP SIGNATURE-----

--udjve4sw4uxhekdd--

