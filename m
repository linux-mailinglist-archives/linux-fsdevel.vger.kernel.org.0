Return-Path: <linux-fsdevel+bounces-22442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F289172A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 22:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85451C2212F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B05E17DE02;
	Tue, 25 Jun 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFbVIruW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DC45BE3;
	Tue, 25 Jun 2024 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348327; cv=none; b=qI2/IchT19OzCTu/UdJPckZ0jBlJiLgfXVufvDaXWshbkeTKfdumEweFu/VNA3Aj4LUqij92Vo4T951t5lOi8CSYhD1wfj56bMO5GoZN7XobkCoyBq8yF5ssKmYFgJkniEpNslT3WqrHqNk//8kMWhYhBqrwLG93YOnK5S81ET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348327; c=relaxed/simple;
	bh=WUd7Gq9KvGb1TVsRR3Vjby50a1ulwJrL+OCX8GMuMd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxfaAgcMALBRfs7C4Q4svuQffVwS3+TYMVniyiIZemK2wpmXQVHyzFEqXUDxQfehUs0UeJ/CvnbHaxHCeGd43mN7OzO7E3IWAlQ9vRSy2ewC1POF1FlXqro0uTice373LvW334edn1guYp1r4orw1VBRhWq8JPEVRQageomlDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFbVIruW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C67C32781;
	Tue, 25 Jun 2024 20:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719348327;
	bh=WUd7Gq9KvGb1TVsRR3Vjby50a1ulwJrL+OCX8GMuMd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFbVIruWS/nLwD+T3MEzF3N0OXGwMVtaohIFNP6RVZIweywiL7bSBJWFpTbzlxoID
	 Sm7SwdAr9ncOyLZnZU6jelnpmusBf62yo553v+p2Qgq8G1JD2VaBOgyDUqw+M60lPU
	 h/KdwouVeD4n1d5GjNePbtVehOTkiPiVIY9KFgYCY4ZQ4KnxDzX/XM4PvzkmTT1OTk
	 k6S5IDmsEUDJoMfBcvMj0I0zC009DzTz5xzyFLSV8sOtlsPtcrx0Shh1cHe76CkDL4
	 RjqUpuI0PAzYJMb5IgIZRa7/LMnMm6Z4N3lX0z4RoEt5Eue7CHbnqsLOUCIR2cpWRt
	 QXMKpZcnMyD5A==
Date: Tue, 25 Jun 2024 22:45:23 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH 2/3] statmount.2: New page describing the statmount
 syscall
Message-ID: <6sodl6py7ati5ka7pfdtn6u2v3oq5alrvbry3gy5bko264rc4c@wfasjcjp2v5h>
References: <cover.1719341580.git.josef@toxicpanda.com>
 <bc242af625a117272e3b7d15a2c55501fea3f7e0.1719341580.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dqkdvaxw7yczo3cg"
Content-Disposition: inline
In-Reply-To: <bc242af625a117272e3b7d15a2c55501fea3f7e0.1719341580.git.josef@toxicpanda.com>


--dqkdvaxw7yczo3cg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH 2/3] statmount.2: New page describing the statmount
 syscall
References: <cover.1719341580.git.josef@toxicpanda.com>
 <bc242af625a117272e3b7d15a2c55501fea3f7e0.1719341580.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <bc242af625a117272e3b7d15a2c55501fea3f7e0.1719341580.git.josef@toxicpanda.com>

On Tue, Jun 25, 2024 at 02:56:05PM GMT, Josef Bacik wrote:
> Add some documentation on the new statmount syscall.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Hi Josef,

I get a few warnings:

$ make lint build check
MANDOC		.tmp/man/man2/statmount.2.lint-man.mandoc.touch
mandoc: .tmp/man/man2/statmount.2:19:40: STYLE: unterminated quoted argument
mandoc: .tmp/man/man2/statmount.2:21:2: STYLE: fill mode already disabled, =
skipping: EX
mandoc: .tmp/man/man2/statmount.2:28:2: STYLE: fill mode already enabled, s=
kipping: fi
make: *** [/home/alx/src/linux/man-pages/man-pages/contrib/share/mk/lint/ma=
n/mandoc.mk:36: .tmp/man/man2/statmount.2.lint-man.mandoc.touch] Error 1

> ---
>  man/man2/statmount.2 | 274 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 274 insertions(+)
>  create mode 100644 man/man2/statmount.2
>=20
> diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
> new file mode 100644
> index 000000000..6d9f505f9
> --- /dev/null
> +++ b/man/man2/statmount.2
> @@ -0,0 +1,274 @@
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
> +.BR "#include <linux/mount.h>" "     /* Definition of STATMOUNT_* consta=
nts */"

Please use only 2 spaces before /*.

> +.B #include <unistd.h>
> +.P
> +.BI "int syscall(SYS_statmount, struct mnt_id_req * " req ,
> +.BI "            struct statmount * " statmountbuf ", size_t " bufsize ,
> +.BI "            unsigned long " flags " );

Please add here

	.P
	.B #include <linux/mount.h>

This documents which header provides the type.

> +.P

=2Efi

> +.EX
> +.B struct mnt_id_req {
> +.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
> +.BR "    __u64 mnt_id;" "  /* The mnt_id being queried */"
> +.BR "    __u64 param;" "   /* An ORed combination of the STATMOUNT_ cons=
tants */"
> +.B };
> +.EE
> +.fi

This .fi moved to above.  I guess you started working on these pages
before 2024-06-17 when I fixed that warning.  Sorry.  :)

	commit a911df9e88dedc801bed50eb92c26002729af9c0
	Author: Alejandro Colomar <alx@kernel.org>
	Date:   Mon Jun 17 01:18:39 2024 +0200

	    man/, share/mk/: Fix nested EX/EE within nf/fi
	   =20
	    EX/EE can't be nested within nf/ni.  The mandoc(1) reports weren't
	    spurious.
	   =20
	    Re-enable the mandoc(1) warnings, and fix the code.
	   =20
	    Fixes: 31203a0c8dbf ("share/mk/: Globally disable two spurious mandoc(=
1) warnings")
	    Link: <https://lists.gnu.org/archive/html/groff/2024-06/msg00019.html>
	    Reported-by: Douglas McIlroy <douglas.mcilroy@dartmouth.edu>
	    Cc: "G. Branden Robinson" <branden@debian.org>
	    Signed-off-by: Alejandro Colomar <alx@kernel.org>

> +.P
> +.IR Note :
> +glibc provides no wrapper for
> +.BR statmount (),
> +necessitating the use of
> +.BR syscall (2).
> +.SH DESCRIPTION
> +To access a mount's status, you must have CAP_SYS_ADMIN in the user name=
space.
> +.P
> +This function returns information about a mount, storing it in the buffer

Please use semantic newlines.  See man-pages(7):

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
   Use semantic newlines
     In the source of a manual page, new sentences should be started on
     new lines, long sentences should be split  into  lines  at  clause
     breaks  (commas,  semicolons, colons, and so on), and long clauses
     should be split at phrase boundaries.  This convention,  sometimes
     known as "semantic newlines", makes it easier to see the effect of
     patches, which often operate at the level of individual sentences,
     clauses, or phrases.

> +pointed to by
> +.IR buf .
> +The returned buffer is a structure of the following type:
> +.P
> +.in +4n
> +.EX
> +struct statmount {
> +    __u32 size;
> +    __u64 mask;
> +    __u32 sb_dev_major;
> +    __u32 sb_dev_minor;
> +    __u64 sb_magic;
> +    __u32 sb_flags;
> +    __u32 fs_type;
> +    __u64 mnt_id;
> +    __u64 mnt_parent_id;
> +    __u32 mnt_id_old;
> +    __u32 mnt_parent_id_old;
> +    __u64 mnt_attr;
> +    __u64 mnt_propagation;
> +    __u64 mnt_peer_group;
> +    __u64 mnt_master;
> +    __u64 propagate_from;
> +    __u32 mnt_root;
> +    __u32 mnt_point;
> +    char str[];
> +};

You could move this structure definition to the SYNOPSIS too.

> +.EE
> +.in
> +.P
> +(Note that reserved space and padding is omitted.)
> +.SS The mnt_id_req structure
> +.I req.size
> +is used by the kernel to determine which struct
> +.I mnt_id_req
> +is being passed in, it should always be set to sizeof(struct mnt_id req).
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
> +is used to tell the kernel which fields the caller is interested in.  It=
 is an
> +ORed combination of the following constants
> +.P
> +.in +4n
> +.TS
> +lBl.
> +STATMOUNT_SB_BASIC	/* Want/got sb_... */
> +STATMOUNT_MNT_BASIC	/* Want/got mnt_... */
> +STATMOUNT_PROPAGATE_FROM	/* Want/got propagate_from */
> +STATMOUNT_MNT_ROOT	/* Want/got mnt_root  */
> +STATMOUNT_MNT_POINT	/* Want/got mnt_point */
> +STATMOUNT_FS_TYPE	/* Want/got fs_type */
> +.TE
> +.in
> +.P
> +Note that, in general, the kernel does
> +.I not
> +reject values in
> +.I req.param
> +other than the above.
> +(For an exception, see
> +.B EINVAL
> +in errors.)
> +Instead, it simply informs the caller which values are supported
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
> +as one or more bits may, in the future, be used to specify an
> +extension to the buffer.
> +.SS
> +The returned information

Please put the sub-section title in the same SS line.  I've fixed this
in statx.2:

<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Dc2ee1116f7663c98d06a6b64c842260099f64fd2>

> +The status information for the target mount is returned in the
> +.I statmount
> +structure pointed to by
> +.IR statmountbuf .
> +Included in this is
> +.I size
> +which indicates the size of the
> +.I statmountbuf
> +that was filled in, including any strings.
> +.I mask
> +which indicates what information in the structure has been filled in.
> +.P
> +It should be noted that the kernel may return fileds that weren't reques=
ted and
> +may fail to return fields that were requested, depending on what the bac=
king
> +file system and kernel supports.
> +In either case,
> +.I req.param
> +will not be equal to
> +.IR mask .
> +.P
> +Apart from
> +.I mask
> +(which is described above), the fields in the
> +.I statmount
> +structure are:
> +.TP
> +.I size
> +The size of the returned
> +.I statmountbuf
> +structure.
> +.TP
> +.IR sb_dev_major " and " sb_dev_minor

Hmmm, please check
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Db1b482c6ad353906adc4d796d4794fc7649cfea9>

=2ETP
=2EI sb_dev_major
=2ETQ
=2EI sb_dev_minor

> +The device that is mounted at this mount point.
> +.TP
> +.I sb_magic
> +The file system specific super block magic.
> +.TP
> +.I sb_flags
> +The flags that are set on the super block, an ORed combination of
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
> +a NULL terminated string.

null-terminated

> +.TP
> +.I mnt_id
> +The unique mount ID of the mount.
> +.TP
> +.I mnt_parent_id
> +The unique mount ID of the parent mount point of this mount.  If this is=
 the
> +root mount point then
> +.B mnt_id
> +=3D=3D
> +.BR parent_mount_id .

=2EIR mnt_id\~=3D=3D\~parent_mount_id .

> +.TP
> +.I mnt_id_old
> +This corresponds to the mount ID that is exported by /proc/$PID/mountinf=
o.
> +.TP
> +.I mnt_parent_id_old
> +This corresponds to the parent mount ID that is exported by
> +/proc/$PID/mountinfo.

=2EIR /proc/ pid /mountinfo .

See groff_man_style(7):

     .I [text]
            Set  text  in an italic or oblique face.  If no argument is
            given, the macro plants a one=E2=80=90line input trap; text on =
 the
            next  line, which can be further formatted with a macro, is
            set in an italic or oblique face.

            Use italics for file and path names, for environment  vari=E2=
=80=90
            ables,  for  C  data types, for enumeration or preprocessor
            constants in C, for variant (user=E2=80=90replaceable) portions=
  of
            syntax synopses, for the first occurrence (only) of a tech=E2=
=80=90
            nical  concept  being introduced, for names of journals and
            of literary works longer than an article,  and  anywhere  a
            parameter requiring replacement by the user is encountered.
            An  exception  involves  variant  text in a context already
            typeset in italics, such as file or  path  names  with  re=E2=
=80=90
            placeable  components; in such cases, follow the convention
            of mathematical typography: set the file or  path  name  in
            italics  as  usual  but use roman for the variant part (see
            .IR and .RI below), and italics again in running roman text
            when referring to the variant material.

Have a lovely night!
Alex

> +.TP
> +.I mnt_attr
> +The
> +.B MOUNT_ATTR_
> +flags set on this mount point.
> +.TP
> +.I mnt_propagation
> +The mount propagation flags, which can be one of
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
> +of the file system. It is a NULL terminated string.
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
> +is too large, the limit is the architectures page size.
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

--dqkdvaxw7yczo3cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ7LGMACgkQnowa+77/
2zIoPQ//ZKuo/XBMawdnuv8zIyv1UIimlTSLdwSsp6tNEBR4r2/EjrkX3AXXT021
9c3HpxjfBt2zT8lcSrUPyvHDaCWnTo3chNrJHk2rBk732mkzUvIRggyEYjJGbaoM
ceCBQoiiEpZLiYAot0ptf05ddRWkHoMwhZJIvRJCqjI/wkWLvO5zbJjoVD/gNHd7
k4HPdK2XyfGyHsGfWy2AtvB3jxxsnVoXP3Yu+0XoAwP5Q9DSGFakTNsk20mlyz5f
mJYMR2SP6kjCZxLTUQkUSzcwu9aLLIyRQRMxnkQSWNKS4BZI+6eNo64U0Aw7uoSl
pGumm7Cgh+sk5smwuMb9SWcWhDImlNKgTfo2temoH2se7XeoW5rxGSGhCGcZEe5Y
kLtTqigM8NCaFVsDpm06cdgNzs5J4Ftuf7PXS6mEpgCQBnAQYPbPOUQGcjfEocjM
obeL/wfzeKL00y5TWfz/uwPndtvd+sbFp/4YHS9DhDGv9hbm885rwx8hm9qkXQWR
5KI9kzRYCTF3ycLYHzsjRDzZqKSnSvyn7ecK2z6PWH/UKtWYAjI8DSDe6smqVp1Y
a8F3KZyoCj3aLXZh4Db7Q6voFv8+QDCoT7yxkQJdgEl3h5Qmd+6Xsenun7KymIyO
bzcPJ5M20HzG8Ff3LyKainEHaj8zxePuImta0HAOgEkTJ1i18po=
=xLMU
-----END PGP SIGNATURE-----

--dqkdvaxw7yczo3cg--

