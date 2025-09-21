Return-Path: <linux-fsdevel+bounces-62329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED46CB8D7FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 10:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFBF17CD8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA424886A;
	Sun, 21 Sep 2025 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m22KoIxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702EE22A808;
	Sun, 21 Sep 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758444792; cv=none; b=irKpm1+KvYKTjln8p1UmPvdkHRiIt4YVm6sMkX6mwLoo1KmzVV0U0Nq1PqXS362qwHRnHOSoVyISCW/o8XQuFkVlyDFD5OlAyBxCwylisliGp70mhd+UR8Jb2ieZ5OpBQmItB8vIsxs7yg+HwivUyNIaO5J+FHoY2lr8tGatkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758444792; c=relaxed/simple;
	bh=AnEfkCyt/WsKGtIaGS2ah8pTq0o4xpjSCaH8wdTV6Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m69MxFBXcsEjPeKQ+5YjSiU4Ve5h/ej/cQLGEhe9bHbMrXDpcCBEaTWXCMxu1bxppsek3eEDI7avDXlD1oahlS+jMCOUlkHhpmYI/GXjdUo6vXdPpJB4XCMKV6SGWDax7tj0f+DSGzRMjQJFPboCPH5/YoKC//vhrRzd4NglrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m22KoIxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DACC4CEF7;
	Sun, 21 Sep 2025 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758444792;
	bh=AnEfkCyt/WsKGtIaGS2ah8pTq0o4xpjSCaH8wdTV6Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m22KoIxE+ET8/YA3kMJ1QnFc1eBzHnZENo1z2Bv5puSNyt33U+kY8DzVEMVWpSEST
	 zB/rcCzl0GfTuluJarN7qYLDmyMKtmO6UwSxb7qOpXHWsdlEx9jd/CN9JeMIN1CdhI
	 +7hPY2t4JmGjZm6cTQZ4GFU+uumgW2Db5l0sGLyqdUX8tMUWOZnxzFFn7/2Xifingd
	 q/GYQ9YapT4j8V3N/N3u6fJUnbUC5IDp7Y30jquVlBI04iRu4PZhZmfn0NCBdUKs/n
	 2twEpFrkaR/HMvtDYU5qclc6NYER2OzeOCrVSBOyD92wzFm8oULRoa68g9G/ZotU5C
	 mDIKk24iFyMZQ==
Date: Sun, 21 Sep 2025 10:53:05 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 03/10] man/man2/fspick.2: document "new" mount API
Message-ID: <y77zyujsduf5furdf2biphuszil63kftb44cs74ed2d2hf2gdr@hci7mzt6yh7b>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fnx5hi325cclw5cy"
Content-Disposition: inline
In-Reply-To: <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>


--fnx5hi325cclw5cy
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
Subject: Re: [PATCH v4 03/10] man/man2/fspick.2: document "new" mount API
Message-ID: <y77zyujsduf5furdf2biphuszil63kftb44cs74ed2d2hf2gdr@hci7mzt6yh7b>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>

Hi Aleksa,

On Fri, Sep 19, 2025 at 11:59:44AM +1000, Aleksa Sarai wrote:
> This is loosely based on the original documentation written by David
> Howells and later maintained by Christian Brauner, but has been
> rewritten to be more from a user perspective (as well as fixing a few
> critical mistakes).
>=20
> Co-authored-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-authored-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man/man2/fspick.2 | 342 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 342 insertions(+)
>=20
> diff --git a/man/man2/fspick.2 b/man/man2/fspick.2
> new file mode 100644
> index 0000000000000000000000000000000000000000..1f87293f44658adeb7ab7cffe=
bcac3174888f040
> --- /dev/null
> +++ b/man/man2/fspick.2
> @@ -0,0 +1,342 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH fspick 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +fspick \- select filesystem for reconfiguration
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ,\~ \-lc )
> +.SH SYNOPSIS
> +.nf
> +.BR "#include <fcntl.h>" "          /* Definition of " AT_* " constants =
*/"
> +.B #include <sys/mount.h>
> +.P
> +.BI "int fspick(int " dirfd ", const char *" path ", unsigned int " flag=
s );
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR fspick ()
> +system call is part of
> +the suite of file descriptor based mount facilities in Linux.
> +.P
> +.BR fspick()
> +creates a new filesystem configuration context
> +for the extant filesystem instance
> +associated with the path described by
> +.IR dirfd
> +and
> +.IR path ,
> +places it into reconfiguration mode
> +(similar to
> +.BR mount (8)
> +with the
> +.I -o remount
> +option).
> +A new file descriptor
> +associated with the filesystem configuration context
> +is then returned.
> +The calling process must have the
> +.BR CAP_SYS_ADMIN

This should use '.B. (Bold).  BR means alternating Bold and Roman, but
this only has one token, so it can't alternate.

If you run `make -R build-catman-troff`, this will trigger a diagnostic:

	an.tmac: <page>:<line>: style: .BR expects at least 2 arguments, got 1

> +capability in order to create a new filesystem configuration context.
> +.P
> +The resultant file descriptor can be used with
> +.BR fsconfig (2)
> +to specify the desired set of changes to
> +filesystem parameters of the filesystem instance.
> +Once the desired set of changes have been configured,
> +the changes can be effectuated by calling
> +.BR fsconfig (2)
> +with the
> +.B \%FSCONFIG_CMD_RECONFIGURE
> +command.
> +Please note that\[em]in contrast to
> +the behaviour of
> +.B MS_REMOUNT
> +with
> +.BR mount (2)\[em] fspick ()

Only have one important keyword per macro call.  In this case, I prefer
em dashes to only be attached to one side, as if they were parentheses,
so we don't need any tricks:

	Please note that
	\[em]in contrast to
	...
	.BR mount (2)\[em]
	.BR fspick ()

> +instantiates the filesystem configuration context
> +with a copy of
> +the extant filesystem's filesystem parameters,
> +meaning that a subsequent
> +.B \%FSCONFIG_CMD_RECONFIGURE
> +operation
> +will only update filesystem parameters
> +explicitly modified with
> +.BR fsconfig (2).
> +.P
> +As with "*at()" system calls,
> +.BR fspick ()
> +uses the
> +.I dirfd
> +argument in conjunction with the
> +.I path
> +argument to determine the path to operate on, as follows:
> +.IP \[bu] 3
> +If the pathname given in
> +.I path
> +is absolute, then
> +.I dirfd
> +is ignored.
> +.IP \[bu]
> +If the pathname given in
> +.I path
> +is relative and
> +.I dirfd
> +is the special value
> +.BR \%AT_FDCWD ,
> +then
> +.I path
> +is interpreted relative to
> +the current working directory
> +of the calling process (like
> +.BR open (2)).
> +.IP \[bu]
> +If the pathname given in
> +.I path
> +is relative,
> +then it is interpreted relative to
> +the directory referred to by the file descriptor
> +.I dirfd
> +(rather than relative to
> +the current working directory
> +of the calling process,
> +as is done by
> +.BR open (2)
> +for a relative pathname).
> +In this case,
> +.I dirfd
> +must be a directory
> +that was opened for reading
> +.RB ( O_RDONLY )
> +or using the
> +.B O_PATH
> +flag.
> +.IP \[bu]
> +If
> +.I path
> +is an empty string,
> +and
> +.I flags
> +contains
> +.BR \%FSPICK_EMPTY_PATH ,
> +then the file descriptor
> +.I dirfd
> +is operated on directly.
> +In this case,
> +.I dirfd
> +may refer to any type of file,
> +not just a directory.
> +.P
> +See
> +.BR openat (2)
> +for an explanation of why the
> +.I dirfd
> +argument is useful.
> +.P
> +.I flags
> +can be used to control aspects of how
> +.I path
> +is resolved and
> +properties of the returned file descriptor.
> +A value for
> +.I flags
> +is constructed by bitwise ORing
> +zero or more of the following constants:
> +.RS
> +.TP
> +.B FSPICK_CLOEXEC
> +Set the close-on-exec
> +.RB ( FD_CLOEXEC )
> +flag on the new file descriptor.
> +See the description of the
> +.B O_CLOEXEC
> +flag in
> +.BR open (2)
> +for reasons why this may be useful.
> +.TP
> +.B FSPICK_EMPTY_PATH
> +If
> +.I path
> +is an empty string,
> +operate on the file referred to by
> +.I dirfd
> +(which may have been obtained from
> +.BR open (2),
> +.BR fsmount (2),
> +or
> +.BR open_tree (2)).
> +In this case,
> +.I dirfd
> +may refer to any type of file,
> +not just a directory.
> +If
> +.I dirfd
> +is
> +.BR \%AT_FDCWD ,
> +.BR fspick ()
> +will operate on the current working directory
> +of the calling process.
> +.TP
> +.B FSPICK_SYMLINK_NOFOLLOW
> +Do not follow symbolic links
> +in the terminal component of
> +.IR path .
> +If
> +.I path
> +references a symbolic link,
> +the returned filesystem context will reference
> +the filesystem that the symbolic link itself resides on.
> +.TP
> +.B FSPICK_NO_AUTOMOUNT
> +Do not automount any automount points encountered
> +while resolving
> +.IR path .
> +This allows you to reconfigure an automount point,
> +rather than the location that would be mounted.
> +This flag has no effect if
> +the automount point has already been mounted over.

I'll amend other similar issues if I find them, but in general, I'd put
the 'if' in the next line, as it is more tied to that part of the
sentence (think for example that if you reversed the sentence to say
"if ..., then ...", you'd move the 'if' with what follows it.  You don't
need to search for all of these and fix them; just keep it in mind for
next time.  In general I like the break points you used.


Have a lovely day!
Alex

> +.RE
> +.P
> +As with filesystem contexts created with
> +.BR fsopen (2),
> +the file descriptor returned by
> +.BR fspick ()
> +may be queried for message strings at any time by calling
> +.BR read (2)
> +on the file descriptor.
> +(See the "Message retrieval interface" subsection in
> +.BR fsopen (2)
> +for more details on the message format.)
> +.SH RETURN VALUE
> +On success, a new file descriptor is returned.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EACCES
> +Search permission is denied
> +for one of the directories
> +in the path prefix of
> +.IR path .
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EBADF
> +.I path
> +is relative but
> +.I dirfd
> +is neither
> +.B \%AT_FDCWD
> +nor a valid file descriptor.
> +.TP
> +.B EFAULT
> +.I path
> +is NULL
> +or a pointer to a location
> +outside the calling process's accessible address space.
> +.TP
> +.B EINVAL
> +Invalid flag specified in
> +.IR flags .
> +.TP
> +.B ELOOP
> +Too many symbolic links encountered when resolving
> +.IR path .
> +.TP
> +.B EMFILE
> +The calling process has too many open files to create more.
> +.TP
> +.B ENAMETOOLONG
> +.I path
> +is longer than
> +.BR PATH_MAX .
> +.TP
> +.B ENFILE
> +The system has too many open files to create more.
> +.TP
> +.B ENOENT
> +A component of
> +.I path
> +does not exist,
> +or is a dangling symbolic link.
> +.TP
> +.B ENOENT
> +.I path
> +is an empty string, but
> +.B \%FSPICK_EMPTY_PATH
> +is not specified in
> +.IR flags .
> +.TP
> +.B ENOTDIR
> +A component of the path prefix of
> +.I path
> +is not a directory;
> +or
> +.I path
> +is relative and
> +.I dirfd
> +is a file descriptor referring to a file other than a directory.
> +.TP
> +.B ENOMEM
> +The kernel could not allocate sufficient memory to complete the operatio=
n.
> +.TP
> +.B EPERM
> +The calling process does not have the required
> +.B \%CAP_SYS_ADMIN
> +capability.
> +.SH STANDARDS
> +Linux.
> +.SH HISTORY
> +Linux 5.2.
> +.\" commit cf3cba4a429be43e5527a3f78859b1bfd9ebc5fb
> +.\" commit 400913252d09f9cfb8cce33daee43167921fc343
> +glibc 2.36.
> +.SH EXAMPLES
> +The following example sets the read-only flag
> +on the filesystem instance referenced by
> +the mount object attached at
> +.IR /tmp .
> +.P
> +.in +4n
> +.EX
> +int fsfd =3D fspick(AT_FDCWD, "/tmp", FSPICK_CLOEXEC);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
> +.EE
> +.in
> +.P
> +The above procedure is roughly equivalent to
> +the following mount operation using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount(NULL, "/tmp", NULL, MS_REMOUNT | MS_RDONLY, NULL);
> +.EE
> +.in
> +.P
> +With the notable caveat that
> +in this example,
> +.BR mount (2)
> +will clear all other filesystem parameters
> +(such as
> +.B MS_NOSUID
> +or
> +.BR MS_NOEXEC );
> +.BR fsconfig (2)
> +will only modify the
> +.I ro
> +parameter.
> +.SH SEE ALSO
> +.BR fsconfig (2),
> +.BR fsmount (2),
> +.BR fsopen (2),
> +.BR mount (2),
> +.BR mount_setattr (2),
> +.BR move_mount (2),
> +.BR open_tree (2),
> +.BR mount_namespaces (7)
> +
>=20
> --=20
> 2.51.0
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--fnx5hi325cclw5cy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjPvOoACgkQ64mZXMKQ
wqm/aA/9Fy97Z3tt2tCQlnzt0dRd6KeCdAEN6/rC1ZrT2NtaBp7BoPrl/dyGwET9
D+vGb5lfpP2ResKwRYz6USVcm/feJwGtRSvIC3QlyaIddInHu7YfdsLRulsO+SOw
SwheqTHrRWOQPh1aiXpTYHDXbvPKegMn5bT34En1W3Ax3CBdTOnkZGdfvzg8dOyz
xauBPiWdiVc/h7gJJCWInGvHynWCXMLgmF7/3SYEs/mZPrba1B0abfhko6GGajFW
/ovY3UDvyi/olp8ksmCxz/FXEXryzA0JQMcAv9bCzwVHOCHApp9DV2LTsa5w0Oh1
lpwnMieOB43fa8OaLjoCeigwH/m8H2kfr8u6KbXhTp0CnrC83fMDwUwkFYPW6AUI
mzQ0CiPzAxIhv11AGg2dPmKx0H9k0QTYaDdqW2ySt8DnKJcPT3a/dOeu4o4PZM13
ZuxIlsAxpXwy3FZDxYDyYIWkiQVCkX3VT5r+USiFv5XwdgX2FvwUkQ3Ilnp7e1No
YLNBqkU8qm4wPRM5+nD4lJ1HNUJliZw1XwzXztCYsnhjfJn6iynbNstKzSCeG1L5
wb6mnCcuyG7Ul00UKeLawHNWpnpbc3tZUquCtljMNXsgrh4DUvzwVX4q7kokpOoy
L/iJ9+1iGYx5snoxODnjpm6TL0ZBfCNtLzUoLO2+ivWfpH7hB/Y=
=Oy6O
-----END PGP SIGNATURE-----

--fnx5hi325cclw5cy--

