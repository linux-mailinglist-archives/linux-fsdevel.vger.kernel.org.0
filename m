Return-Path: <linux-fsdevel+bounces-23383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC0592B967
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 14:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F141F2626F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66435158D72;
	Tue,  9 Jul 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrR/mQHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF31581FD;
	Tue,  9 Jul 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528030; cv=none; b=mPW65lUasIguurLpDRTkgQF/cxQfNjURGYL4+mbqeCLnU69/1DE+kQ90xRZvYkLNWbaNe9uGT33vT/tK83LQOTo5u3ayoAnT06NsZE/1tnB5Uyp6faIC91Lb7H9xkSD993wOKWxUYaD+2O8MM0lXIVWJuZDN0LeDn9UFFtUkfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528030; c=relaxed/simple;
	bh=GJ6wyzt92LIY+hpCYUWJWfO+Tr6CaiJyt1Ewjh82qPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7SBGVQtzGqPiKPUguYdIytBNOLg+AXuGuWkjUyUVLzRwb08pqH1qmWqJl4SWNfUgrkdjaOjSrel1xr5zJ5OCXMMlS54yHenHBRWWG6hadcexS15+Opfme4sTCFN5UD5R6ZY+WXz0KOa//ov7n5ymIgVO85k+8iYnQHCR05SkPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrR/mQHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22140C32786;
	Tue,  9 Jul 2024 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720528030;
	bh=GJ6wyzt92LIY+hpCYUWJWfO+Tr6CaiJyt1Ewjh82qPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrR/mQHW/6VZGIEgATadiDn5C0uXmFuILyjbsoHp41Uv9EOQeobldlDdyQl0Ikz1p
	 eZ+E5ooKcJgbeqn742PGO0dZBqT3kzMZ23AAdruo8htQraq7dfQ4pURVGwvk+ngcY5
	 f1gndgqh4+NJeY3ddazXkzUsrxPXyQB9rIMDcBBqqnoSKnaSqkZ+JvoYQv3oCDHbpZ
	 qARva3Ynw2LMsU2bqvc8fSfyUFEjY0x7Nd9NqPtAnbZUWWiVKPXOmlzipYOYbMVdu3
	 0AUT+WPUsy8+aVLQp85uK4XNm/TUZyiueNRGLd2vaIgrDtTq1UP8UC7Lxg36/iYFB7
	 mt3Aa99ZuO+4A==
Date: Tue, 9 Jul 2024 14:27:07 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v4 1/2] statmount.2: New page describing the statmount
 syscall
Message-ID: <nejxqd4w2o75w3abumyjtlknehdy2nfruareicfjnubp7yl7yk@jx7pqrfmviud>
References: <cover.1719840964.git.josef@toxicpanda.com>
 <85889ca0f88e79e79bc8bfeb58395c04affe3424.1719840964.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bezsasv5ax3dk2u5"
Content-Disposition: inline
In-Reply-To: <85889ca0f88e79e79bc8bfeb58395c04affe3424.1719840964.git.josef@toxicpanda.com>


--bezsasv5ax3dk2u5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v4 1/2] statmount.2: New page describing the statmount
 syscall
References: <cover.1719840964.git.josef@toxicpanda.com>
 <85889ca0f88e79e79bc8bfeb58395c04affe3424.1719840964.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <85889ca0f88e79e79bc8bfeb58395c04affe3424.1719840964.git.josef@toxicpanda.com>

Hi Josef,

On Mon, Jul 01, 2024 at 09:37:53AM GMT, Josef Bacik wrote:
> Add some documentation on the new statmount syscall.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  man/man2/statmount.2 | 288 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 288 insertions(+)
>  create mode 100644 man/man2/statmount.2
>=20
> diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
> new file mode 100644
> index 000000000..3e13107f5
> --- /dev/null
> +++ b/man/man2/statmount.2
> @@ -0,0 +1,288 @@
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

Nothing in the page describes bufsize, AFAICS.

$ grep bufsize man/man2/statmount.2 | wc -l
1

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

s/you/the caller/

> +.P
> +This function returns information about a mount,
> +storing it in the buffer pointed to by
> +.IR smbuf .
> +The returned buffer is a
> +.I struct statmount
> +with the fields filled in as described below.
> +.P
> +(Note that reserved space and padding is omitted.)
> +.SS The mnt_id_req structure
> +.I req.size
> +is used by the kernel to determine which struct
> +.I mnt_id_req

If you use 'struct\~foo', both words should be in italics.
You can do that, or make only 'foo' italics, and say foo structure.

> +is being passed in,

s/,/;/

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
> +lBl.

Let's put some space there:

lB l.

> +STATMOUNT_SB_BASIC	/* Want/got sb_* */
> +STATMOUNT_MNT_BASIC	/* Want/got mnt_* */
> +STATMOUNT_PROPAGATE_FROM	/* Want/got propagate_from */
> +STATMOUNT_MNT_ROOT	/* Want/got mnt_root  */
> +STATMOUNT_MNT_POINT	/* Want/got mnt_point */
> +STATMOUNT_FS_TYPE	/* Want/got fs_type */
> +.TE
> +.in
> +.P
> +Note that,

I'd remove the above, and start with "In general, ...".

Usually, everything is noteworthy, and if not, it should not go into the
documentation, or go into a footnote where it's marked as "unnecessary
on a first reading".  :)

See also:
<https://lore.kernel.org/linux-man/20230105225235.6cjtz6orjzxzvo6v@illithid=
/>

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
> +.IR smbuf .

I think I'd move the text after this point to the descriptions of
smbuf.size and smbuf.mask.

> +Included in this is
> +.I size
> +which indicates the size of the
> +.I smbuf
> +that was filled in,
> +including any strings.
> +.I mask
> +which indicates what information in the structure has been filled in.

> +.P
> +It should be noted that the kernel may return fields that weren't reques=
ted

s/It should be noted that the/The/

For the reasons noted above.

> +and may fail to return fields that were requested,
> +depending on what the backing file system and kernel supports.
> +In either case,
> +.I req.param
> +will not be equal to
> +.IR mask .
> +.P
> +The fields in the
> +.I statmount
> +structure are:
> +.TP
> +.I smbuf.size
> +The size of the returned
> +.I smbuf
> +structure.
> +.TP
> +.I smbuf.mask
> +The ORed combination of
> +.B STATMOUNT_

=2EBI STATMOUNT_ *

> +flags indicating which fields were filled in and thus valid.
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
m. It is

New sentence, new line.

> +a null-terminated string.
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
> +buffer that contains the string representation of the mount relative to =
the root

I'd break the line right before "relative".

> +of the file system.
> +It is a NULL terminated string.
> +.TP
> +.I smbuf.mnt_point
> +The offset to the location in the
> +.I smbuf.str
> +buffer that contains the string representation of the mount relative to =
the

I'd break the line right before "relative".

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
> +.I smbuf
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

I think the user should not know that the limit is a page size.
The user shall specify it as sizeof(struct mnt_id_req), and should
ignore any implementation details of the kernel.

So: "req is too large."

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

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--bezsasv5ax3dk2u5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNLJUACgkQnowa+77/
2zJNuRAAmytkUvNnArzmVvxRpo/ToYwOEfVZ0TJaD/Foj6qvtqrs6L2pRbEYEWVK
6YWxCq5t6eb4cE4KKHq7g0ytWBRAyKeTeEaD1vrJg52pzJMh/SJpXI2s2CAp8ogl
ATMTdSilbdcnSaE6e9Gf+x0YJD1eanyS+9hx47/ALeKog86+596O+sZnRaNRse31
Tgn5owq/bXjsHDReiwX3vdJF8msnnzkp3nMhyW3te8C7Av7CEBVvDgJelBwkQJo2
LjZyXnKHFnVoCXbdgDqKb9We72z1RfzjcV/Pntsn+sBOhXyyDdl0ULL9RvehV4zQ
CbmVpK8cfLUa2aj+iqsp90o7auTdRI5gMW3ujVJ3Tzt1dkZHJ7b3Hj3wiQFwbTYQ
OXTxpBunNZdTy8saGJPJgUm/bHkvqY/u+hqGe8rWr8b7GAddFPUkZj0D4UgCA9tH
0LC/6MuLAUGoDNg0AMQDfJ+J8xg6wclLoY/KiUyuX7wcYoeZkp6xpIqgIgqDiprl
NVavh7vPl+rua0Zr4hW8gY+XdDtoUfK9dFjkuDEa6Co2IS7vnFnQPywryh6p0zp4
KvPyJ+pS7pEgNh34b2CylNb0DDmF10QhPPaiVsMr6M4HOYIWDRw98cEVg72IL81u
UvBBjanL0PItfd/eftGGPt3IAB2WKeG7YduNkpcQNfcnUJMx+m8=
=uZ7a
-----END PGP SIGNATURE-----

--bezsasv5ax3dk2u5--

