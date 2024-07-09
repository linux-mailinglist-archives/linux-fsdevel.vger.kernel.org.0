Return-Path: <linux-fsdevel+bounces-23438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0B292C3EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 21:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FA11C2208E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3572318003A;
	Tue,  9 Jul 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIqm+0HR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C01B86D5;
	Tue,  9 Jul 2024 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720553578; cv=none; b=Ka/yP/7w/b7QR9iOK/jq18mzBSp2zK+Ro3ffojJarwLMpPDtDKaEL7OcWpNyQzJfTbbbCe7ODZM9RzIcVqdJrrDiEZXHPi69mRpXl+1QTjLgqUO7kLxpLiFgZ7Y0B5iU6usk5LhV9B1xapI1sI42H+21Mmwqt2WYL2ZQ4Z4CFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720553578; c=relaxed/simple;
	bh=B6guYP4FGyTRUVdTJF69ZWJGLO+JeNV3l/3We5Sm8RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsjlmZA67u43ZDSqjdf9icfc59nLgivj7sggZS1Dh2xu0Tn47j3fJdgIAacVRG8SjGDPloZQfmu8TRmpB5BHjkleiw0ztAtvBUnBZ0p2E4LolcfFoFTOLYlM2zlr9j3wkv6gmcCZFxwa+btwU7sIG/1j1GFzD6z9Xgtd+tcsthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIqm+0HR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E00C3277B;
	Tue,  9 Jul 2024 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720553578;
	bh=B6guYP4FGyTRUVdTJF69ZWJGLO+JeNV3l/3We5Sm8RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIqm+0HRznrNjClNJQfpXs05bFk4DQN0Scz2hII1hG+nUN5JlAxleDShPs2oga6yG
	 ouOV+bGWYZH4Ip57/ubydKofy2FGvsc+jfxtuVWViLpmn/m+fM+QFWtQueiD9QBvAf
	 4QLN1pZqsBD/qdCsfSriHWw7SvAAe11bHHrLqz0dBgXmu0wHDKNk7IIIalhlEGsdhA
	 AhPgto+Ni5y1S6pFdoWSESxXQV1kknbWbkvPILKFsb4KzpUE7A+twUsKIeb6QcL9lK
	 tkoq17oYjh9teLQabiiNrj5MgoY/H473fI4UXbf+9ia7bXrKJs7KiUM3ZDiH23Q1Pd
	 TYYU9fSUMJOVg==
Date: Tue, 9 Jul 2024 21:32:54 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v6 1/2] statmount.2: New page describing the statmount
 syscall
Message-ID: <pwzhat3oozrvtdeq5b2dtsy3gbkckz3kidjev3sz4fgdhncizx@mnmlof4mrsnu>
References: <cover.1720549824.git.josef@toxicpanda.com>
 <5b4a8408a21970d0ee4bea5cee4c74cb39851c0d.1720549824.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="idc47cgoraqpebqi"
Content-Disposition: inline
In-Reply-To: <5b4a8408a21970d0ee4bea5cee4c74cb39851c0d.1720549824.git.josef@toxicpanda.com>


--idc47cgoraqpebqi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v6 1/2] statmount.2: New page describing the statmount
 syscall
References: <cover.1720549824.git.josef@toxicpanda.com>
 <5b4a8408a21970d0ee4bea5cee4c74cb39851c0d.1720549824.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <5b4a8408a21970d0ee4bea5cee4c74cb39851c0d.1720549824.git.josef@toxicpanda.com>

Hi Josef,

On Tue, Jul 09, 2024 at 02:31:22PM GMT, Josef Bacik wrote:
> Add some documentation on the new statmount syscall.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I've applied the patch, with some tweaks.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D1e607c20633d839d9241da50071d508ef617f878>

Have a lovely day!
Alex


diff --git i/man/man2/statmount.2 w/man/man2/statmount.2
index 2ae1f1bc3..4b54a6c85 100644
--- i/man/man2/statmount.2
+++ w/man/man2/statmount.2
@@ -14,40 +14,42 @@ .SH SYNOPSIS
 .BR "#include <linux/mount.h>" "  /* Definition of STATMOUNT_* constants *=
/"
 .B #include <unistd.h>
 .P
-.BI "int syscall(SYS_statmount, struct mnt_id_req * " req ,
-.BI "            struct statmount * " smbuf ", size_t " bufsize ,
+.BI "int syscall(SYS_statmount, struct mnt_id_req *" req ,
+.BI "            struct statmount *" smbuf ", size_t " bufsize ,
 .BI "            unsigned long " flags );
 .P
 .B #include <linux/mount.h>
+.fi
 .P
+.EX
 .B struct mnt_id_req {
-.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
-.BR "    __u64 mnt_id;" "  /* The mnt_id being queried */"
-.BR "    __u64 param;" "   /* An ORed combination of the STATMOUNT_ consta=
nts */"
+.BR "    __u32  size;" "    /* sizeof(struct mnt_id_req) */"
+.BR "    __u64  mnt_id;" "  /* The mnt_id being queried */"
+.BR "    __u64  param;" "   /* An ORed combination of the STATMOUNT_ const=
ants */"
 .B };
 .P
 .B struct statmount {
-.B "    __u32 size;"
-.B "    __u64 mask;"
-.B "    __u32 sb_dev_major;"
-.B "    __u32 sb_dev_minor;"
-.B "    __u64 sb_magic;"
-.B "    __u32 sb_flags;"
-.B "    __u32 fs_type;"
-.B "    __u64 mnt_id;"
-.B "    __u64 mnt_parent_id;"
-.B "    __u32 mnt_id_old;"
-.B "    __u32 mnt_parent_id_old;"
-.B "    __u64 mnt_attr;"
-.B "    __u64 mnt_propagation;"
-.B "    __u64 mnt_peer_group;"
-.B "    __u64 mnt_master;"
-.B "    __u64 propagate_from;"
-.B "    __u32 mnt_root;"
-.B "    __u32 mnt_point;"
-.B "    char  str[];"
+.B "    __u32  size;"
+.B "    __u64  mask;"
+.B "    __u32  sb_dev_major;"
+.B "    __u32  sb_dev_minor;"
+.B "    __u64  sb_magic;"
+.B "    __u32  sb_flags;"
+.B "    __u32  fs_type;"
+.B "    __u64  mnt_id;"
+.B "    __u64  mnt_parent_id;"
+.B "    __u32  mnt_id_old;"
+.B "    __u32  mnt_parent_id_old;"
+.B "    __u64  mnt_attr;"
+.B "    __u64  mnt_propagation;"
+.B "    __u64  mnt_peer_group;"
+.B "    __u64  mnt_master;"
+.B "    __u64  propagate_from;"
+.B "    __u32  mnt_root;"
+.B "    __u32  mnt_point;"
+.B "    char   str[];"
 .B };
-.fi
+.EE
 .P
 .IR Note :
 glibc provides no wrapper for
@@ -117,7 +119,7 @@ .SS The mnt_id_req structure
 .I statmount.mask
 field.
 Therefore,
-.I "do not"
+.I do not
 simply set
 .I req.param
 to



> ---
>  man/man2/statmount.2 | 281 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 281 insertions(+)
>  create mode 100644 man/man2/statmount.2
>=20
> diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
> new file mode 100644
> index 000000000..2ae1f1bc3
> --- /dev/null
> +++ b/man/man2/statmount.2
> @@ -0,0 +1,281 @@
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
> +It is a null-terminated string.
> +.TP
> +.I smbuf.mnt_point
> +The offset to the location in the
> +.I smbuf.str
> +buffer that contains the string representation of the mount
> +relative to the current root (ie if you are in a
> +.BR chroot ).
> +It is a null-terminated string.
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
>=20

--=20
<https://www.alejandro-colomar.es/>

--idc47cgoraqpebqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNkGYACgkQnowa+77/
2zKbgRAAp4df6NgMYzzNlHOiLhlSbgcxybaMoaoV42AENYHAhfBuBv+/ZZUadwE8
HDc2R/OGibAp7o/lcez7oWfO5Owha5kfXf/CzP71kiivFxlbolrOnDDO3tmlVl0L
fLHSJXc38BiX5Dso1z6kQ6xFNgfL8YjuL3szCaD5srgB/j5i9PlppJtV5gepNEKH
JE+/Yd46Mj1AkjOHjf3mSawSPG904yhBoE2+WJ+aPEHa0rar8TXmY1XOupydAONu
2+OdrSNk1gohrfYEChmVHQKqtoeW3NH8loRUy0olVcYTvNQL6/cTjrN6EBN7qo5r
iirFJPgM2kW3P3f2daGp50sr295VTMfnkAC5UJb24Am6DG8S1FOxX8u6hR0FbCml
a+preYsLnWOcOSjW4C+iiM5BFzMEPDF7HRxrTHHAO62OezZSQNbqnbRbw75nchGK
Os2HLmJ4Lx8OltQTjg7HcdFKmLagOw5IqLBi0cgqfWpP0utALZSeOOsskq6CBM56
3gqRTZt9U95SODDdumsbdre+/n2T7c1CALYkynczNgZxWJZ1zw0Y9MTTJ2JmDtum
lXXMkOtc/S9lwexb5UG0oSk/Z2NHsYq3NPdKyugndGbtC9NHIGjSoNNrovSNfHEK
rfR5137hL4SN0ROhw1iFvfmUFXX+EuNst36EHp0ntrr9iynVqoc=
=Xtoz
-----END PGP SIGNATURE-----

--idc47cgoraqpebqi--

