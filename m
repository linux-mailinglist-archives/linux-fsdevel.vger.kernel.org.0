Return-Path: <linux-fsdevel+bounces-22761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6776691BD48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 13:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A681F23122
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2115698D;
	Fri, 28 Jun 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYlWM0BJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094DA1865A;
	Fri, 28 Jun 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719573663; cv=none; b=heWJ3dXIrvh8/yYw5z+DEdWeySuXxJvzMBgG0JZrRGX6rq1nEZehXeGmXa3wXckWEOnv0ktxLA8Opmx0nylbmqRhXPxtII77vhNJ/LBnTTeSwRgbfwG+f1b0RE+7pJZv/L2ZGMUE+2Poanfsqn3HhDi2MQYpts5cVKIhBVhXO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719573663; c=relaxed/simple;
	bh=H9LG7tyQUS6l+gAsK00ygS1kZ4M8p3oxPYVZt9C/r+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCpCOyVgOcANyE9npzvLouZEw52q1OMj6d+B7xLkY8fJs1X57H/5yTVDDsntVTblGpeAtLSv0s2djtn8n2YBzn92DVgLhxnhhWiPL3cVUHtzm8j36DRpE03FMJUzOAtfhl0wzQG2ST6lB6XbK9MXC9wqWJWZuYbXRnp0CHzTbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYlWM0BJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4FDC32781;
	Fri, 28 Jun 2024 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719573662;
	bh=H9LG7tyQUS6l+gAsK00ygS1kZ4M8p3oxPYVZt9C/r+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYlWM0BJiJ2OG0s36uS2+uXWaotADKWSKCcfu93E/TbyqsAzvghaWnuJmeXnVTAOD
	 ZUOkA2cT97saBn6FEZEgHi0F4bMlTl7A5PS6wOBtOmt4JGSVgvT+HGUcOZ+aWrQsDr
	 LE91/+WvTpqEB0V3m8jBmq4/kS/mHbQwIoFPGnTTkw9xkgfRUsl4DoKPFXS0LGbzS6
	 NfnsSeqpVfM7oMCPSeffPkuxqGGVHw9rXu9LWfJ9Q7XCXaKTsZmvpHHdJBmvL4/6HU
	 UN7UtDiDZP4DtHvmBMN9sS56+m/BRGrUC+QgYBSZX48l0zGhUK7PARphiDeTTV/9ZY
	 k52jbP/NOK2yw==
Date: Fri, 28 Jun 2024 13:20:59 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] statmount.2: New page describing the statmount
 syscall
Message-ID: <abzm6cqteoj6etvnwkopridflj34252s3jyabndd2prm3tjars@6jutizrurv2q>
References: <cover.1719425922.git.josef@toxicpanda.com>
 <e202b85c695e90547c75e87d89d9bf1a9b999960.1719425922.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d7qedxtdee2wxenh"
Content-Disposition: inline
In-Reply-To: <e202b85c695e90547c75e87d89d9bf1a9b999960.1719425922.git.josef@toxicpanda.com>


--d7qedxtdee2wxenh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] statmount.2: New page describing the statmount
 syscall
References: <cover.1719425922.git.josef@toxicpanda.com>
 <e202b85c695e90547c75e87d89d9bf1a9b999960.1719425922.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <e202b85c695e90547c75e87d89d9bf1a9b999960.1719425922.git.josef@toxicpanda.com>

On Wed, Jun 26, 2024 at 02:21:39PM GMT, Josef Bacik wrote:
> Add some documentation on the new statmount syscall.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  man/man2/statmount.2 | 285 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 285 insertions(+)
>  create mode 100644 man/man2/statmount.2
>=20
> diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
> new file mode 100644
> index 000000000..2f85bc022
> --- /dev/null
> +++ b/man/man2/statmount.2
> @@ -0,0 +1,285 @@
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
> +.BI "            struct statmount * " statmountbuf ", size_t " bufsize ,

How about a shorter name?  s/statmountbuf/smbuf/

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
> +you must have CAP_SYS_ADMIN in the user namespace.
> +.P
> +This function returns information about a mount,
> +storing it in the buffer pointed to by
> +.IR statmountbuf .
> +The returned buffer is a
> +.I struct statmount
> +with the fields filled in as described below.
> +.P
> +(Note that reserved space and padding is omitted.)
> +.SS The mnt_id_req structure
> +.I req.size
> +is used by the kernel to determine which struct
> +.I mnt_id_req
> +is being passed in,
> +it should always be set to sizeof(struct mnt_id req).

There's a missing '_'.  BTW, since this is inline code, it should be in
italics.  See man-pages(7):

     Expressions, if not written on a separate indented line, should be
     specified in italics.  Again, the use of nonbreaking spaces may be
     appropriate if the expression is inlined with normal text.

So:

=2EIR sizeof(struct\~mnt_id_req) .

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
> +lBl.
> +STATMOUNT_SB_BASIC	/* Want/got sb_... */
> +STATMOUNT_MNT_BASIC	/* Want/got mnt_... */

We normally use glob style for these things: sb_* mnt_*

> +STATMOUNT_PROPAGATE_FROM	/* Want/got propagate_from */
> +STATMOUNT_MNT_ROOT	/* Want/got mnt_root  */
> +STATMOUNT_MNT_POINT	/* Want/got mnt_point */
> +STATMOUNT_FS_TYPE	/* Want/got fs_type */
> +.TE
> +.in
> +.P
> +Note that,
> +in general,
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
> +.IR statmountbuf .
> +Included in this is
> +.I size
> +which indicates the size of the
> +.I statmountbuf
> +that was filled in,
> +including any strings.
> +.I mask
> +which indicates what information in the structure has been filled in.
> +.P
> +It should be noted that the kernel may return fields that weren't reques=
ted
> +and may fail to return fields that were requested,
> +depending on what the backing file system and kernel supports.
> +In either case,
> +.I req.param
> +will not be equal to
> +.IR mask .
> +.P
> +Apart from
> +.I mask
> +(which is described above),

Why not describe .mask like the rest, below?  That would be more
consistent, no?

> +the fields in the
> +.I statmount
> +structure are:
> +.TP
> +.I size

Please use smbuf.size, for consistency with the mnt_id_rew subsection,
which uses req.*

I like that, because it is more explicit (you don't need to check again
in which subsection you are).

> +The size of the returned
> +.I statmountbuf
> +structure.
> +.TP
> +.I sb_dev_major
> +.TQ
> +.I sb_dev_minor
> +The device that is mounted at this mount point.
> +.TP
> +.I sb_magic
> +The file system specific super block magic.
> +.TP
> +.I sb_flags
> +The flags that are set on the super block,
> +an ORed combination of
> +.BR SB_RDONLY ,
> +.BR SB_SYNCHRONOUS ,
> +.BR SB_DIRSYNC ,
> +.BR SB_LAZYTIME .
> +.TP
> +.I fs_type
> +The offset to the location in the
> +.I statmount.str
> +buffer that contains the string representation of the mounted file syste=
m. It is
> +a null-terminated string.
> +.TP
> +.I mnt_id
> +The unique mount ID of the mount.
> +.TP
> +.I mnt_parent_id
> +The unique mount ID of the parent mount point of this mount.
> +If this is the root mount point then
> +.IR mnt_id\~=3D=3D\~parent_mount_id .
> +.TP
> +.I mnt_id_old
> +This corresponds to the mount ID that is exported by
> +.IR /proc/ pid /mountinfo .
> +.TP
> +.I mnt_parent_id_old
> +This corresponds to the parent mount ID that is exported by
> +.IR /proc/ pid /mountinfo .
> +.TP
> +.I mnt_attr
> +The
> +.B MOUNT_ATTR_

=2EBI MOUNT_ATTR_ *

Have a lovely day!
Alex

> +flags set on this mount point.
> +.TP
> +.I mnt_propagation
> +The mount propagation flags,
> +which can be one of
> +.BR MS_SHARED ,
> +.BR MS_SLAVE ,
> +.BR MS_PRIVATE ,
> +.BR MS_UNBINDABLE .
> +.TP
> +.I mnt_peer_group
> +The ID of the shared peer group.
> +.TP
> +.I mnt_master
> +The mount point receives its propagation from this mount ID.
> +.TP
> +.I propagate_from
> +The ID from the namespace we propagated from.
> +.TP
> +.I mnt_root
> +The offset to the location in the
> +.I statmount.str
> +buffer that contains the string representation of the mount relative to =
the root
> +of the file system.
> +It is a NULL terminated string.
> +.TP
> +.I mnt_point
> +The offset to the location in the
> +.I statmount.str
> +buffer that contains the string representation of the mount relative to =
the
> +current root (ie if you are in a
> +.BR chroot ).
> +It is a NULL terminated string.
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
> +.I statmountbuf
> +is NULL or points to a location outside the process's
> +accessible address space.
> +.TP
> +.B EINVAL
> +Invalid flag specified in
> +.IR flags .
> +.TP
> +.B EINVAL
> +.I req
> +is of insufficient size to be utilized.
> +.B E2BIG
> +.I req
> +is too large,
> +the limit is the architectures page size.
> +.TP
> +.B EOVERFLOW
> +The size of
> +.I statmountbuf
> +is too small to contain either the
> +.IR statmountbuf.fs_type ,
> +.IR statmountbuf.mnt_root ,
> +or
> +.IR statmountbuf.mnt_point .
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

--d7qedxtdee2wxenh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ+nJUACgkQnowa+77/
2zI92g//RnU+kZ6OL5MPp4M1/YGHyHY7KTfycPtlgnd/EwlV9UloFd4rF1dIZcSe
9lW9t5JC+4EdV0atr3nunY/PO4vcdgU0f1WPCq3VvlgoUj3ukj7NpjAFs1LSIHMt
5Z1cbfOcAFCxW6WUJ3/8e90ggSjpLLRvnVRUh2oz+amClY0iJ9RHQgUVvc4Q5diV
JbJHB/IiDQ8DDCKVnx/sCdgc91NgT/JuokwwSMxm8payQul2TZaYJLqsHzqKTWlA
5IXpy9c2++gW7Oe6LDvvN05HTDN94KQ6NlRgjgJrXb3HngfidzCsiafG20UWxJNE
pB0CCTu79S6c+NVwts8vcqqYF/S4Xgl1IW47pWOsEggkLKZzSQ+bpLbHI2Re+CkW
KFDwe1PYPLWulKcJs3ZAgN+pWDnAz0XGjwQn/QQvb1lxDvM6q2rGZnyl/EFNXdeX
NRKHnrAz1Rm02Ai7EzhAbG0ql4vTnLmntnlba9rss2JzqVKPJ/8RHrv6ta3D+Mie
GZtGhVLjMCUjQfYFBlYVbhqHW9Xgl109GQ/B3NZT5MH+Wm7ZWqAerFqnMbBJP50/
PsA5dkGReOlmFiFcCurD+TPvGkqM5vYgSO7ObssqH6QZ2YViCfmCwdL2kY5LiJYD
nP69Z7yQgGbtgAVTgE+p2S2CRj2vsh3il8KOsXna94HqWt4lVYw=
=CrzE
-----END PGP SIGNATURE-----

--d7qedxtdee2wxenh--

