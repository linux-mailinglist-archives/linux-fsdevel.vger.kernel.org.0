Return-Path: <linux-fsdevel+bounces-63196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D4BB16D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 19:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6E97A3905
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532629B8C0;
	Wed,  1 Oct 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDvZgpcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6C34BA32;
	Wed,  1 Oct 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341557; cv=none; b=YNe6I4R5kTLkeXEfZ0McAtoCVrM5s+/k03z9N28KlSEPRK1xsuDmscFNb8F01Uylkcd7xEm0i/tDp09p8XlfoJaLhHbKCEcNi2AkgNKmeqjNT+/wdccrKgZ2+Q+AIGw9KgGNQpTpaXE9BMBBUQIVLSoAERPgMjWetYFbuZrznuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341557; c=relaxed/simple;
	bh=YfY9grCgNQq+lMG0Wz+/WSCvPYNLJrY2XV7sPJ5BIZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRY24RGggyodo1/MFgT23EuHGUphpbwyqdtSbO61eTvMjhb5Q7sxGc0DgCWS7Dq1FT6XRw5D4RuzpIC3ZLEbRQBoloWDeHTJofzv4aOf8D1wE6vbQKHPgu/Evdaoam92TF2XSt70TX2Y1mbjs44jcVLka6azUFstJI7m6JWRq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDvZgpcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3129C4CEF1;
	Wed,  1 Oct 2025 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759341557;
	bh=YfY9grCgNQq+lMG0Wz+/WSCvPYNLJrY2XV7sPJ5BIZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDvZgpcbWJ85dDuf3sPzNiBMsQeosVT8QmxcSDyZLkmM560Um8bDKmqdERU4E8nWZ
	 bzL3YdIlPML4TuSsJV06eQTtUmzaouowX6V5qzCBx16TOQvprFdvWmWB7mkL7+tpf0
	 97buXj+QfxztyPG8nCDMhekjMCdlUzmT1uoh/UP6E5WJ9t4aJHUbL1AFXMFX/A4XwZ
	 vlp4Qzra1aUFtorSKah0sntLxjyf7D9zWMgowCgZps/K6A/Kc/0e/P9Ov0iYdPUsZ2
	 V7B5Fdoq82BYGCfBALo7zIXpEDCcETkpzvlXxT7foxeYa2nUZUlo1H5j80/ex7ZlZ0
	 MTkySZlsulImg==
Date: Wed, 1 Oct 2025 19:59:12 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 6/8] man/man2/open_tree.2: document "new" mount API
Message-ID: <umlils2gignsuyqiiwzej5i4ec6f2l6qmhkvmjt7unvphhgjmc@riv7eesk4bbi>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-6-028fb88023f2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="536xxtwybus3qxxe"
Content-Disposition: inline
In-Reply-To: <20250925-new-mount-api-v5-6-028fb88023f2@cyphar.com>


--536xxtwybus3qxxe
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
Subject: Re: [PATCH v5 6/8] man/man2/open_tree.2: document "new" mount API
Message-ID: <umlils2gignsuyqiiwzej5i4ec6f2l6qmhkvmjt7unvphhgjmc@riv7eesk4bbi>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-6-028fb88023f2@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250925-new-mount-api-v5-6-028fb88023f2@cyphar.com>

Hi Aleksa,

On Thu, Sep 25, 2025 at 01:31:28AM +1000, Aleksa Sarai wrote:
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

Patch applied.  Thanks!


Have a lovely night!
Alex

>  man/man2/open_tree.2 | 518 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 518 insertions(+)
>=20
> diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
> new file mode 100644
> index 0000000000000000000000000000000000000000..6b04a80927a8b6a394cf7ab34=
1b8d6b29d42d304
> --- /dev/null
> +++ b/man/man2/open_tree.2
> @@ -0,0 +1,518 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH open_tree 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +open_tree \- open path or create detached mount object and attach to fd
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ,\~ \-lc )
> +.SH SYNOPSIS
> +.nf
> +.BR "#define _GNU_SOURCE         " "/* See feature_test_macros(7) */"
> +.BR "#include <fcntl.h>" "          /* Definition of " AT_* " constants =
*/"
> +.B #include <sys/mount.h>
> +.P
> +.BI "int open_tree(int " dirfd ", const char *" path ", unsigned int " f=
lags );
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR open_tree ()
> +system call is part of
> +the suite of file-descriptor-based mount facilities in Linux.
> +.IP \[bu] 3
> +If
> +.I flags
> +contains
> +.BR \%OPEN_TREE_CLONE ,
> +.BR open_tree ()
> +creates a detached mount object
> +which consists of a bind-mount of
> +the path specified by the
> +.IR path .
> +A new file descriptor
> +associated with the detached mount object
> +is then returned.
> +The mount object is equivalent to a bind-mount
> +that would be created by
> +.BR mount (2)
> +called with
> +.BR \%MS_BIND ,
> +except that it is tied to a file descriptor
> +and is not mounted onto the filesystem.
> +.IP
> +As with file descriptors returned from
> +.BR fsmount (2),
> +the resultant file descriptor can then be used with
> +.BR move_mount (2),
> +.BR mount_setattr (2),
> +or other such system calls to do further mount operations.
> +.IP
> +This mount object will be unmounted and destroyed
> +when the file descriptor is closed
> +if it was not otherwise attached to a mount point
> +by calling
> +.BR move_mount (2).
> +This implicit unmount operation is lazy\[em]\c
> +akin to calling
> +.BR umount2 (2)
> +with
> +.BR \%MNT_DETACH ;
> +thus,
> +any existing open references to files
> +from the mount object
> +will continue to work,
> +and the mount object will only be completely destroyed
> +once it ceases to be busy.
> +.IP \[bu]
> +If
> +.I flags
> +does not contain
> +.BR \%OPEN_TREE_CLONE ,
> +.BR open_tree ()
> +returns a file descriptor
> +that is exactly equivalent to
> +one produced by
> +.BR openat (2)
> +when called with the same
> +.I dirfd
> +and
> +.IR path .
> +.P
> +In either case, the resultant file descriptor
> +acts the same as one produced by
> +.BR open (2)
> +with
> +.BR O_PATH ,
> +meaning it can also be used as a
> +.I dirfd
> +argument to
> +"*at()" system calls.
> +However,
> +unlike
> +.BR open (2)
> +called with
> +.BR O_PATH ,
> +automounts will
> +by default
> +be triggered by
> +.BR open_tree ()
> +unless
> +.B \%AT_NO_AUTOMOUNT
> +is included in
> +.IR flags .
> +.P
> +As with "*at()" system calls,
> +.BR open_tree ()
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
> +.RB ( \%O_RDONLY )
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
> +.BR \%AT_EMPTY_PATH ,
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
> +can be used to control aspects of the path lookup
> +and properties of the returned file descriptor.
> +A value for
> +.I flags
> +is constructed by bitwise ORing
> +zero or more of the following constants:
> +.RS
> +.TP
> +.B \%AT_EMPTY_PATH
> +If
> +.I path
> +is an empty string, operate on the file referred to by
> +.I dirfd
> +(which may have been obtained from
> +.BR open (2),
> +.BR fsmount (2),
> +or from another
> +.BR open_tree ()
> +call).
> +In this case,
> +.I dirfd
> +may refer to any type of file, not just a directory.
> +If
> +.I dirfd
> +is
> +.BR \%AT_FDCWD ,
> +.BR open_tree ()
> +will operate on the current working directory
> +of the calling process.
> +This flag is Linux-specific;
> +define
> +.B \%_GNU_SOURCE
> +to obtain its definition.
> +.TP
> +.B \%AT_NO_AUTOMOUNT
> +Do not automount the terminal ("basename") component of
> +.I path
> +if it is a directory that is an automount point.
> +This allows you to create a handle to the automount point itself,
> +rather than the location it would mount.
> +This flag has no effect if the mount point has already been mounted over.
> +This flag is Linux-specific;
> +define
> +.B \%_GNU_SOURCE
> +to obtain its definition.
> +.TP
> +.B \%AT_SYMLINK_NOFOLLOW
> +If
> +.I path
> +is a symbolic link, do not dereference it;
> +instead,
> +create either a handle to the link itself
> +or a bind-mount of it.
> +The resultant file descriptor is indistinguishable from one produced by
> +.BR openat (2)
> +with
> +.BR \%O_PATH | O_NOFOLLLOW .
> +.TP
> +.B \%OPEN_TREE_CLOEXEC
> +Set the close-on-exec
> +.RB ( FD_CLOEXEC )
> +flag on the new file descriptor.
> +See the description of the
> +.B O_CLOEXEC
> +flag in
> +.BR open (2)
> +for reasons why this may be useful.
> +.TP
> +.B \%OPEN_TREE_CLONE
> +Rather than creating an
> +.BR openat (2)-style
> +.B O_PATH
> +file descriptor,
> +create a bind-mount of
> +.I path
> +(akin to
> +.IR \%mount\~\-\-bind )
> +as a detached mount object.
> +In order to do this operation,
> +the calling process must have the
> +.B \%CAP_SYS_ADMIN
> +capability.
> +.TP
> +.B \%AT_RECURSIVE
> +Create a recursive bind-mount of the path
> +(akin to
> +.IR \%mount\~\-\-rbind )
> +as a detached mount object.
> +This flag is only permitted in conjunction with
> +.BR \%OPEN_TREE_CLONE .
> +.SH RETURN VALUE
> +On success, a new file descriptor is returned.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EACCES
> +Search permission is denied for one of the directories
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
> +does not exist, or is a dangling symbolic link.
> +.TP
> +.B ENOENT
> +.I path
> +is an empty string, but
> +.B AT_EMPTY_PATH
> +is not specified in
> +.IR flags .
> +.TP
> +.B ENOTDIR
> +A component of the path prefix of
> +.I path
> +is not a directory, or
> +.I path
> +is relative and
> +.I dirfd
> +is a file descriptor referring to a file other than a directory.
> +.TP
> +.B ENOSPC
> +The "anonymous" mount namespace
> +necessary to contain the
> +.B \%OPEN_TREE_CLONE
> +detached bind-mount mount object
> +could not be allocated,
> +as doing so would exceed
> +the configured per-user limit on
> +the number of mount namespaces in the current user namespace.
> +(See also
> +.BR namespaces (7).)
> +.TP
> +.B ENOMEM
> +The kernel could not allocate sufficient memory to complete the operatio=
n.
> +.TP
> +.B EPERM
> +.I flags
> +contains
> +.B \%OPEN_TREE_CLONE
> +but the calling process does not have the required
> +.B CAP_SYS_ADMIN
> +capability.
> +.SH STANDARDS
> +Linux.
> +.SH HISTORY
> +Linux 5.2.
> +.\" commit a07b20004793d8926f78d63eb5980559f7813404
> +.\" commit 400913252d09f9cfb8cce33daee43167921fc343
> +glibc 2.36.
> +.SH NOTES
> +.SS Mount propagation
> +The bind-mount mount objects created by
> +.BR open_tree ()
> +with
> +.B \%OPEN_TREE_CLONE
> +are not associated with
> +the mount namespace of the calling process.
> +Instead, each mount object is placed
> +in a newly allocated "anonymous" mount namespace
> +associated with the calling process.
> +.P
> +One of the side-effects of this is that
> +(unlike bind-mounts created with
> +.BR mount (2)),
> +mount propagation
> +(as described in
> +.BR mount_namespaces (7))
> +will not be applied to bind-mounts created by
> +.BR open_tree ()
> +until the bind-mount is attached with
> +.BR move_mount (2),
> +at which point the mount object
> +will be associated with the mount namespace
> +where it was attached
> +and mount propagation will resume.
> +Note that any mount propagation events that occurred
> +before the mount object was attached
> +will
> +.I not
> +be propagated to the mount object,
> +even after it is attached.
> +.SH EXAMPLES
> +The following examples show how
> +.BR open_tree ()
> +can be used in place of more traditional
> +.BR mount (2)
> +calls with
> +.BR MS_BIND .
> +.P
> +.in +4n
> +.EX
> +int srcfd =3D open_tree(AT_FDCWD, "/var", OPEN_TREE_CLONE);
> +move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +First,
> +a detached bind-mount mount object of
> +.I /var
> +is created
> +and associated with the file descriptor
> +.IR srcfd .
> +Then, the mount object is attached to
> +.I /mnt
> +using
> +.BR move_mount (2)
> +with
> +.B \%MOVE_MOUNT_F_EMPTY_PATH
> +to request that the detached mount object
> +associated with the file descriptor
> +.I srcfd
> +be moved (and thus attached) to
> +.IR /mnt .
> +.P
> +The above procedure is functionally equivalent to
> +the following mount operation using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/var", "/mnt", NULL, MS_BIND, NULL);
> +.EE
> +.in
> +.P
> +.B \%OPEN_TREE_CLONE
> +can be combined with
> +.B \%AT_RECURSIVE
> +to create recursive detached bind-mount mount objects,
> +which in turn can be attached to mount points
> +to create recursive bind-mounts.
> +.P
> +.in +4n
> +.EX
> +int srcfd =3D open_tree(AT_FDCWD, "/var",
> +                      OPEN_TREE_CLONE | AT_RECURSIVE);
> +move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +The above procedure is functionally equivalent to
> +the following mount operation using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/var", "/mnt", NULL, MS_BIND | MS_REC, NULL);
> +.EE
> +.in
> +.P
> +One of the primary benefits of using
> +.BR open_tree ()
> +and
> +.BR move_mount (2)
> +over the traditional
> +.BR mount (2)
> +is that operating with
> +.IR dirfd -style
> +file descriptors is far easier and more intuitive.
> +.P
> +.in +4n
> +.EX
> +int srcfd =3D open_tree(100, "", AT_EMPTY_PATH | OPEN_TREE_CLONE);
> +move_mount(srcfd, "", 200, "foo", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +The above procedure is roughly equivalent to
> +the following mount operation using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/proc/self/fd/100",
> +      "/proc/self/fd/200/foo",
> +      NULL, MS_BIND, NULL);
> +.EE
> +.in
> +.P
> +In addition, you can use the file descriptor returned by
> +.BR open_tree ()
> +as the
> +.I dirfd
> +argument to any "*at()" system calls:
> +.P
> +.in +4n
> +.EX
> +int dirfd, fd;
> +\&
> +dirfd =3D open_tree(AT_FDCWD, "/etc", OPEN_TREE_CLONE);
> +fd =3D openat(dirfd, "passwd", O_RDONLY);
> +fchmodat(dirfd, "shadow", 0000, 0);
> +close(dirfd);
> +close(fd);
> +/* The bind-mount is now destroyed */
> +.EE
> +.in
> +.SH SEE ALSO
> +.BR fsconfig (2),
> +.BR fsmount (2),
> +.BR fsopen (2),
> +.BR fspick (2),
> +.BR mount (2),
> +.BR mount_setattr (2),
> +.BR move_mount (2),
> +.BR mount_namespaces (7)
>=20
> --=20
> 2.51.0
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--536xxtwybus3qxxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjda/AACgkQ64mZXMKQ
wqlvaQ/7BhhxNgP3+UGQ5fG98IB2zrXWCcDGzWsHExYcgyFYfzbQmLZpg3o6mO57
hLrMWilPlu6ctvegDGQkWEZ4BSeUM3PXicq5gD7PHYtjIsO7mzLimq7UGJGlDL5T
5hXbMfjLKGYZFd34FxMeV4jWh1PobUyxlSWhkSIR2E21EAY74U9Ow3qzcUf/T60i
nRrr9Ag5qxW/T2MDxdXrjgTUR9UIUULUCo7sOO7fM0do2Kx21jmue4q5ugCs+OAx
RXQYb3NKCQ9OQhRlYh11bweKfexCD6mEDUE035MczR7VUbLi5WeUe7Mh2vxrTK2M
mPilWwjXz6uGcthl45COTJLgPhUf487Yv0Lf8QcMUMzNVoZdqv06rH/3d3D0PHUf
/spb7TlaPV831s97RXOHlsMUaMNJlcusl2425ZjjCBMcDF70uFsCFfhEjUB70wL+
H7sQZB1UeR5kocNs0QCFnWO62tVNoFOojyhybkR0jHoFAucjXAhQcKnRnDudRmXi
JFJukJfRUSFq3C18W5m8HaQPPM6zJCDIjExgplj8a/q8P6bavbECsxoftDDZGAvx
mqcrX3mTJ6lPLclzO2zJ48lHnRKhEtnmtS/8OEM4HutxQ9+oafUX8OcghsixCAiJ
Qdje6X9QnHW3661hEIant2c+adbOZLGCNNemxhNZsGDvfatTzH0=
=OEhQ
-----END PGP SIGNATURE-----

--536xxtwybus3qxxe--

