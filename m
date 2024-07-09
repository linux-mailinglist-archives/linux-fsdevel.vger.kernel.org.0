Return-Path: <linux-fsdevel+bounces-23428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9821892C2C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BADA51C21EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61F1B86FD;
	Tue,  9 Jul 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1DQPdKZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA58717B023;
	Tue,  9 Jul 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547338; cv=none; b=t3TyGDIbvsEhAio5MBRHuohSQDIwyIbi0pfeILFAy+I2mmL1DOWTVdIqkcEIY4+BI7is6Un01zud5BdlpfHMuZipoFP4O4JX0XIKEwmKM9LLEByuzSHkuslRrqzexkUG98uVUkjSLKfyH4dgb65NdQ6/PmaY2wk5reIVodJSWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547338; c=relaxed/simple;
	bh=58dGzQbr//VYSKrqetCrAN3aqnAZjEW/vzdN9CpqAO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eshKssoON8CXNMwNpdsOYVyXidivl944oSQT5WJo15kdPtDmAjeIZg4eExGRY579DSYq7dXpzGkfh8ALY+kAsnmvm9Hz8jebZhPMCTp7fKCYRz5lzJpf/AXeQfEe0lVqWm3z4AoBJTr+mhSMIktQp5z/F1ZGBBZsNI1uQ4YvIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1DQPdKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF2FC3277B;
	Tue,  9 Jul 2024 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720547337;
	bh=58dGzQbr//VYSKrqetCrAN3aqnAZjEW/vzdN9CpqAO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1DQPdKZ3TG7RsBFmKOFg16qaCQ0bB6UxC1wR+6cXQki/+/GUPuopcfH0q2LT180T
	 4JTq/5C8SUIbqjBGArjN4k77Y9bmNtRySZijtfMf8Gg0FkkqRewVR02TykqEZK6LOl
	 i8/Hb1TlBil4pxXdrorL5y5pbfuLrIq4VkeZyGOHbVy2y3LSldaBJLOwEhMTS4P7db
	 Rthag0m6IglVZVEEa5gSRtcXWbOogy8r9RflB1hsQDySG8ptuOjPtcO7xz/Bm4jo1h
	 +3Y+0VMj3o/DouScddG8gbUIGYN6XNZhBplHOmpQa/ZFswh1XrsqazfRmhlPalIpG1
	 7yu+6qf91keTw==
Date: Tue, 9 Jul 2024 19:48:54 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v5 1/2] statmount.2: New page describing the statmount
 syscall
Message-ID: <fx5grrvxxxjx3cu5dej5uit6qsaownahwc644ku52vxcuzhhn3@dqjkofvlsopn>
References: <cover.1720545710.git.josef@toxicpanda.com>
 <009928cf579a38577f8d6cc644c115556f9a3576.1720545710.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mp5my4yq7gphe3in"
Content-Disposition: inline
In-Reply-To: <009928cf579a38577f8d6cc644c115556f9a3576.1720545710.git.josef@toxicpanda.com>


--mp5my4yq7gphe3in
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v5 1/2] statmount.2: New page describing the statmount
 syscall
References: <cover.1720545710.git.josef@toxicpanda.com>
 <009928cf579a38577f8d6cc644c115556f9a3576.1720545710.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <009928cf579a38577f8d6cc644c115556f9a3576.1720545710.git.josef@toxicpanda.com>

Hi Josef,

On Tue, Jul 09, 2024 at 01:25:42PM GMT, Josef Bacik wrote:
> Add some documentation on the new statmount syscall.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

It's looking good already.  Please see some comments below.

Have a lovely day!
Alex

> ---
>  man/man2/statmount.2 | 280 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 280 insertions(+)
>  create mode 100644 man/man2/statmount.2
>=20
> diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
> new file mode 100644
> index 000000000..c437ea685
> --- /dev/null
> +++ b/man/man2/statmount.2
> @@ -0,0 +1,280 @@
> +'\" t
> +.\" Copyright (c) 2024 Josef Bacik <josef@toxicpanda.com>
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH statmount 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +statmount \- get a mount status
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ", " \-lc )
> +.SH SYNOPSIS
> +.nf
> +.BR "#include <linux/mount.h>" "  /* Definition of STATMOUNT_* constants=
 */"
> +.B #include <unistd.h>
> +.P
> +.BI "int syscall(SYS_statmount, struct mnt_id_req * " req ,
> +.BI "            struct statmount * " smbuf ", size_t " bufsize ,
> +.BI "            unsigned long " flags );
> +.P
> +.B #include <linux/mount.h>
> +.P
> +.B struct mnt_id_req {
> +.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
> +.BR "    __u64 mnt_id;" "  /* The mnt_id being queried */"
> +.BR "    __u64 param;" "   /* An ORed combination of the STATMOUNT_ cons=
tants */"
> +.B };
> +.P
> +.B struct statmount {
> +.B "    __u32 size;"
> +.B "    __u64 mask;"
> +.B "    __u32 sb_dev_major;"
> +.B "    __u32 sb_dev_minor;"
> +.B "    __u64 sb_magic;"
> +.B "    __u32 sb_flags;"
> +.B "    __u32 fs_type;"
> +.B "    __u64 mnt_id;"
> +.B "    __u64 mnt_parent_id;"
> +.B "    __u32 mnt_id_old;"
> +.B "    __u32 mnt_parent_id_old;"
> +.B "    __u64 mnt_attr;"
> +.B "    __u64 mnt_propagation;"
> +.B "    __u64 mnt_peer_group;"
> +.B "    __u64 mnt_master;"
> +.B "    __u64 propagate_from;"
> +.B "    __u32 mnt_root;"
> +.B "    __u32 mnt_point;"
> +.B "    char  str[];"
> +.B };
> +.fi
> +.P
> +.IR Note :
> +glibc provides no wrapper for
> +.BR statmount (),
> +necessitating the use of
> +.BR syscall (2).
> +.SH DESCRIPTION
> +To access a mount's status,
> +the caller must have CAP_SYS_ADMIN in the user namespace.
> +.P
> +This function returns information about a mount,
> +storing it in the buffer pointed to by
> +.IR smbuf .
> +The returned buffer is a
> +.I struct statmount
> +which is of size
> +.I bufsize
> +with the fields filled in as described below.
> +.P
> +(Note that reserved space and padding is omitted.)
> +.SS The mnt_id_req structure
> +.I req.size
> +is used by the kernel to determine which
> +.I struct\~mnt_id_req
> +is being passed in;
> +it should always be set to
> +.IR sizeof(struct\~mnt_id_req) .
> +.P
> +.I req.mnt_id
> +can be obtained from either
> +.BR statx (2)
> +using
> +.B STATX_MNT_ID_UNIQUE
> +or from
> +.BR listmount (2)
> +and is used as the identifier to query the status of the desired mount p=
oint.
> +.P
> +.I req.param
> +is used to tell the kernel which fields the caller is interested in.
> +It is an ORed combination of the following constants
> +.P
> +.in +4n
> +.TS
> +lB l.
> +STATMOUNT_SB_BASIC	/* Want/got sb_* */
> +STATMOUNT_MNT_BASIC	/* Want/got mnt_* */
> +STATMOUNT_PROPAGATE_FROM	/* Want/got propagate_from */
> +STATMOUNT_MNT_ROOT	/* Want/got mnt_root  */
> +STATMOUNT_MNT_POINT	/* Want/got mnt_point */
> +STATMOUNT_FS_TYPE	/* Want/got fs_type */
> +.TE
> +.in
> +.P
> +In general,
> +the kernel does
> +.I not
> +reject values in
> +.I req.param
> +other than the above.
> +(For an exception,
> +see
> +.B EINVAL
> +in errors.)
> +Instead,
> +it simply informs the caller which values are supported
> +by this kernel and filesystem via the
> +.I statmount.mask
> +field.
> +Therefore,
> +.I "do not"
> +simply set
> +.I req.param
> +to
> +.B UINT_MAX
> +(all bits set),
> +as one or more bits may,
> +in the future,
> +be used to specify an extension to the buffer.
> +.SS The returned information
> +The status information for the target mount is returned in the
> +.I statmount
> +structure pointed to by
> +.IR smbuf .
> +.P
> +The fields in the
> +.I statmount
> +structure are:
> +.TP
> +.I smbuf.size
> +The size of the returned
> +.I smbuf
> +structure,
> +including any of the strings fields that were filled.
> +.TP
> +.I smbuf.mask
> +The ORed combination of
> +.BI STATMOUNT_ *
> +flags indicating which fields were filled in and thus valid.
> +The kernel may return fields that weren't requested,
> +and may fail to return fields that were requested,
> +depending on what the backing file system and kernel supports.
> +In either case,
> +.I req.param
> +will not be equal to
> +.IR mask .
> +.TP
> +.I smbuf.sb_dev_major
> +.TQ
> +.I smbuf.sb_dev_minor
> +The device that is mounted at this mount point.
> +.TP
> +.I smbuf.sb_magic
> +The file system specific super block magic.
> +.TP
> +.I smbuf.sb_flags
> +The flags that are set on the super block,
> +an ORed combination of
> +.BR SB_RDONLY ,
> +.BR SB_SYNCHRONOUS ,
> +.BR SB_DIRSYNC ,
> +.BR SB_LAZYTIME .
> +.TP
> +.I smbuf.fs_type
> +The offset to the location in the
> +.I smbuf.str
> +buffer that contains the string representation of the mounted file syste=
m.
> +It is a null-terminated string.
> +.TP
> +.I smbuf.mnt_id
> +The unique mount ID of the mount.
> +.TP
> +.I smbuf.mnt_parent_id
> +The unique mount ID of the parent mount point of this mount.
> +If this is the root mount point then
> +.IR smbuf.mnt_id\~=3D=3D\~smbuf.parent_mount_id .
> +.TP
> +.I smbuf.mnt_id_old
> +This corresponds to the mount ID that is exported by
> +.IR /proc/ pid /mountinfo .
> +.TP
> +.I smbuf.mnt_parent_id_old
> +This corresponds to the parent mount ID that is exported by
> +.IR /proc/ pid /mountinfo .
> +.TP
> +.I smbuf.mnt_attr
> +The
> +.BI MOUNT_ATTR_ *
> +flags set on this mount point.
> +.TP
> +.I smbuf.mnt_propagation
> +The mount propagation flags,
> +which can be one of
> +.BR MS_SHARED ,
> +.BR MS_SLAVE ,
> +.BR MS_PRIVATE ,
> +.BR MS_UNBINDABLE .
> +.TP
> +.I smbuf.mnt_peer_group
> +The ID of the shared peer group.
> +.TP
> +.I smbuf.mnt_master
> +The mount point receives its propagation from this mount ID.
> +.TP
> +.I smbuf.propagate_from
> +The ID from the namespace we propagated from.
> +.TP
> +.I smbuf.mnt_root
> +The offset to the location in the
> +.I smbuf.str
> +buffer that contains the string representation of the mount
> +relative to the root of the file system.
> +It is a NULL terminated string.

s/NULL terminated/null-terminated/

NULL is the null pointer constant.
NUL is the ASCII name for the null byte.
We say null-terminated, because someone (probably Michael Kerrisk)
thought NULL and NUL were confusing.  :)

> +.TP
> +.I smbuf.mnt_point
> +The offset to the location in the
> +.I smbuf.str
> +buffer that contains the string representation of the mount
> +relative to the current root (ie if you are in a
> +.BR chroot ).
> +It is a NULL terminated string.

s/NULL terminated/null-terminated/

> +.SH RETURN VALUE
> +On success, zero is returned.
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
> +.I smbuf
> +is NULL or points to a location outside the process's

NULL actually points to a location outside the accessible address space.
We can simplify and not mention NULL.

Normally, I use the _Nullable qualifier on function prototypes that
accept NULL.  See for example recvfrom(2).  If it's not used, passing
NULL is Undefined Behavior.

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
> +is too large.
> +.TP
> +.B EOVERFLOW
> +The size of
> +.I smbuf
> +is too small to contain either the
> +.IR smbuf.fs_type ,
> +.IR smbuf.mnt_root ,
> +or
> +.IR smbuf.mnt_point .
> +Allocate a larger buffer and retry the call.
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
> +.BR listmount (2),
> +.BR statx (2)
> --=20
> 2.43.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--mp5my4yq7gphe3in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNeAAACgkQnowa+77/
2zJY1BAAjRRPt8RPGNiLiKARfyzYIXDVnDubaKyn/NcEoCEm+D1ZobltGgkYDONJ
scuhM5VnxuEqOB4d5iJBdXdtYbW2/zXoaddnYEbG30KdIHi/shO8f8TpTVjYskiT
YKOj/HNuoO64umse6mbIO6Jw0IREw7mO35g8ZlSm72FBpMVNEkhYdxl4VyYxx//Y
H/i1cuqUx/woLfZQqYo7UHpRC2UhqDkyMYlJHi83XbOXWNqGF99EehTn1LiDnjNZ
mWo5EVotK8Qw0IBWpPNACEN9fmn8XcFAaRj0qtUFydqiCqJj8TMY57+hLTMnjzd7
gBsWgELiZ4AZNg8gFc1zCKGaldOIjfmQ2kwwZ5yIsWigl3qHEhQ4FWOHBEs5wshw
h5yYhCFYsVWDHjDt9H2K+eMCyipOqCIMoO4/NTr4bG8qB1l4CnZOgr9Cvvpl9v+W
xfGDoYP79TcSHptye+4mdl+jEyvXepqahbvshhswW9jkzXPFJozqGkxbgX3Tf5V9
J81GR9gnLUVuydIJnFNZHLQMmGDG3FX7356K5qGTwVvsFRhqoWgM0FyLzp48JXM8
XUJVWqgrTJ3pYmq9r8W0wEPIfHFBsRQV4PTAq/SI+ptKIeuDkuVGY/mXZ7ZNBLw5
u/w9p1egBn69b0mRw19cUC4g1F1pu9r6/37A64Jx/yN6hWGplk4=
=tRfr
-----END PGP SIGNATURE-----

--mp5my4yq7gphe3in--

