Return-Path: <linux-fsdevel+bounces-62875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9DEBA3B25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653A3741106
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155B2EC0AB;
	Fri, 26 Sep 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOBFf2vL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3961397;
	Fri, 26 Sep 2025 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891117; cv=none; b=IlW+h6TWHKbSW38bEG218IlTdQXgi+5oyjNAheLVzSeSgpCf7VJ7/hnh5UGfGeb6kASr6FZ1jXbM5MtemRcYJRqgW3vV98BZUEHXDbB569JgvRYZuZQ64h3isYDyVitY692MO3RA2mf38HA9zJEF1fF+8mMLSr0fm9fzdkLLYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891117; c=relaxed/simple;
	bh=3Y4O5LMLCQJieRcZdfxcHnfSnXNNprYMqoTOTujBqTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/t+46SQOkBZiHL4uhfPgTaI4ZT8hZzSSQut6Uwydq2XyTAJYTPh4rUacWBBoxQ6Gg3Hc5Xaoe2/sGce7YWffNUBQnCjvr5l9CF7rC4f8wNZ4PR8zr5few/fbbVSEWAXFshXlGKKpvFK5VjRH3HEPUibOhWK7+Kgo2CSvKf1uIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOBFf2vL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86470C116C6;
	Fri, 26 Sep 2025 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891117;
	bh=3Y4O5LMLCQJieRcZdfxcHnfSnXNNprYMqoTOTujBqTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOBFf2vLVWeAV6RnQebajdSIv6gnlUZTSt9UT86Ykm8nBrQr4UXJVFZkTDjFMk/9l
	 pHNXRwXspHMfi6El0t1+bVQV0Jvw9qyChRcMhdlGadYDgAbriVqLOS7WChdRm51lJj
	 UXdXZuQa9jzDKI/FT/qOcqxfokZi7v3ZtrTJpwTrH55pTQm9YbCWDRVV3Pglt5K1+p
	 F1qcPTxX/i5txhntoaiZAAh2XvJYqLPRGk5k7R0hrJv9MtV5Y+fo+MyIdsIEyxXzmU
	 21oP8OEzLYPzt3hFIZXXE9enPqxG+62f5PmuTW3MsFi4sakt8XJRqulnP03eRQVNVA
	 6Nfh2uUwn0XkA==
Date: Fri, 26 Sep 2025 14:51:48 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 4/8] man/man2/fsmount.2: document "new" mount API
Message-ID: <3kewugw6bh6y6ghw44ksqqir6r37wnyckwx7st66ydtdaxbtgk@ibg57jop5mn7>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-4-028fb88023f2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zkcon2xpijdemyux"
Content-Disposition: inline
In-Reply-To: <20250925-new-mount-api-v5-4-028fb88023f2@cyphar.com>


--zkcon2xpijdemyux
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
Subject: Re: [PATCH v5 4/8] man/man2/fsmount.2: document "new" mount API
Message-ID: <3kewugw6bh6y6ghw44ksqqir6r37wnyckwx7st66ydtdaxbtgk@ibg57jop5mn7>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-4-028fb88023f2@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250925-new-mount-api-v5-4-028fb88023f2@cyphar.com>

Hi Aleksa,

On Thu, Sep 25, 2025 at 01:31:26AM +1000, Aleksa Sarai wrote:
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

Thanks!  I've applied this patch.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D24243cc66e191fd917c9c13a01b7ac037ce0972e>


Cheers,
Alex

> ---
>  man/man2/fsmount.2 | 231 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 231 insertions(+)
>=20
> diff --git a/man/man2/fsmount.2 b/man/man2/fsmount.2
> new file mode 100644
> index 0000000000000000000000000000000000000000..b62850a68443bb8f6178389eb=
6cb1a5f9029ab30
> --- /dev/null
> +++ b/man/man2/fsmount.2
> @@ -0,0 +1,231 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH fsmount 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +fsmount \- instantiate mount object from filesystem context
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ,\~ \-lc )
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/mount.h>
> +.P
> +.BI "int fsmount(int " fsfd ", unsigned int " flags \
> +", unsigned int " attr_flags );
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR fsmount ()
> +system call is part of
> +the suite of file-descriptor-based mount facilities in Linux.
> +.P
> +.BR fsmount ()
> +creates a new detached mount object
> +for the root of the new filesystem instance
> +referenced by the filesystem context file descriptor
> +.IR fsfd .
> +A new file descriptor
> +associated with the detached mount object
> +is then returned.
> +In order to create a mount object with
> +.BR fsmount (),
> +the calling process must have the
> +.B \%CAP_SYS_ADMIN
> +capability.
> +.P
> +The filesystem context must have been created with a call to
> +.BR fsopen (2)
> +and then had a filesystem instance instantiated with a call to
> +.BR fsconfig (2)
> +with
> +.B \%FSCONFIG_CMD_CREATE
> +or
> +.B \%FSCONFIG_CMD_CREATE_EXCL
> +in order to be in the correct state
> +for this operation
> +(the "awaiting-mount" mode in kernel-developer parlance).
> +.\" FS_CONTEXT_AWAITING_MOUNT is the term the kernel uses for this.
> +Unlike
> +.BR open_tree (2)
> +with
> +.BR \%OPEN_TREE_CLONE ,
> +.BR fsmount ()
> +can only be called once
> +in the lifetime of a filesystem context
> +to produce a mount object.
> +.P
> +As with file descriptors returned from
> +.BR open_tree (2)
> +called with
> +.BR OPEN_TREE_CLONE ,
> +the returned file descriptor
> +can then be used with
> +.BR move_mount (2),
> +.BR mount_setattr (2),
> +or other such system calls to do further mount operations.
> +This mount object will be unmounted and destroyed
> +when the file descriptor is closed
> +if it was not otherwise attached to a mount point
> +by calling
> +.BR move_mount (2).
> +(Note that the unmount operation on
> +.BR close (2)
> +is lazy\[em]akin to calling
> +.BR umount2 (2)
> +with
> +.BR MNT_DETACH ;
> +any existing open references to files
> +from the mount object
> +will continue to work,
> +and the mount object will only be completely destroyed
> +once it ceases to be busy.)
> +The returned file descriptor
> +also acts the same as one produced by
> +.BR open (2)
> +with
> +.BR O_PATH ,
> +meaning it can also be used as a
> +.I dirfd
> +argument
> +to "*at()" system calls.
> +.P
> +.I flags
> +controls the creation of the returned file descriptor.
> +A value for
> +.I flags
> +is constructed by bitwise ORing
> +zero or more of the following constants:
> +.RS
> +.TP
> +.B FSMOUNT_CLOEXEC
> +Set the close-on-exec
> +.RB ( FD_CLOEXEC )
> +flag on the new file descriptor.
> +See the description of the
> +.B O_CLOEXEC
> +flag in
> +.BR open (2)
> +for reasons why this may be useful.
> +.RE
> +.P
> +.I attr_flags
> +specifies mount attributes
> +which will be applied to the created mount object,
> +in the form of
> +.BI \%MOUNT_ATTR_ *
> +flags.
> +The flags are interpreted as though
> +.BR mount_setattr (2)
> +was called with
> +.I attr.attr_set
> +set to the same value as
> +.IR attr_flags .
> +.BI \%MOUNT_ATTR_ *
> +flags which would require
> +specifying additional fields in
> +.BR mount_attr (2type)
> +(such as
> +.BR \%MOUNT_ATTR_IDMAP )
> +are not valid flag values for
> +.IR attr_flags .
> +.P
> +If the
> +.BR fsmount ()
> +operation is successful,
> +the filesystem context
> +associated with the file descriptor
> +.I fsfd
> +is reset
> +and placed into reconfiguration mode,
> +as if it were just returned by
> +.BR fspick (2).
> +You may continue to use
> +.BR fsconfig (2)
> +with the now-reset filesystem context,
> +including issuing the
> +.B \%FSCONFIG_CMD_RECONFIGURE
> +command
> +to reconfigure the filesystem instance.
> +.SH RETURN VALUE
> +On success, a new file descriptor is returned.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EBUSY
> +The filesystem context associated with
> +.I fsfd
> +is not in the right state
> +to be used by
> +.BR fsmount ().
> +.TP
> +.B EINVAL
> +.I flags
> +had an invalid flag set.
> +.TP
> +.B EINVAL
> +.I attr_flags
> +had an invalid
> +.BI MOUNT_ATTR_ *
> +flag set.
> +.TP
> +.B EMFILE
> +The calling process has too many open files to create more.
> +.TP
> +.B ENFILE
> +The system has too many open files to create more.
> +.TP
> +.B ENOSPC
> +The "anonymous" mount namespace
> +necessary to contain the new mount object
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
> +The calling process does not have the required
> +.B CAP_SYS_ADMIN
> +capability.
> +.SH STANDARDS
> +Linux.
> +.SH HISTORY
> +Linux 5.2.
> +.\" commit 93766fbd2696c2c4453dd8e1070977e9cd4e6b6d
> +.\" commit 400913252d09f9cfb8cce33daee43167921fc343
> +glibc 2.36.
> +.SH EXAMPLES
> +.in +4n
> +.EX
> +int fsfd, mntfd, tmpfd;
> +\&
> +fsfd =3D fsopen("tmpfs", FSOPEN_CLOEXEC);
> +fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC,
> +                MOUNT_ATTR_NODEV | MOUNT_ATTR_NOEXEC);
> +\&
> +/* Create a new file without attaching the mount object */
> +tmpfd =3D openat(mntfd, "tmpfile", O_CREAT | O_EXCL | O_RDWR, 0600);
> +unlinkat(mntfd, "tmpfile", 0);
> +\&
> +/* Attach the mount object to "/tmp" */
> +move_mount(mntfd, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.SH SEE ALSO
> +.BR fsconfig (2),
> +.BR fsopen (2),
> +.BR fspick (2),
> +.BR mount (2),
> +.BR mount_setattr (2),
> +.BR move_mount (2),
> +.BR open_tree (2),
> +.BR mount_namespaces (7)
>=20
> --=20
> 2.51.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--zkcon2xpijdemyux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjWjGQACgkQ64mZXMKQ
wqnZkw//VEWJmFzHgJLA7ZaeZ2efeIHt15CEAGOBq2NkxX5Kg/wBZfLlcftc2Gzh
lksoFZuskAUCcFSo5MNbGCTqN90bPjWZD4XMzDckbZf9s2WU/9d6Ev5BGYIogW2T
HgKIeLxQtMBPUdBFwXIDX3JW9/qLInpiXovIpikLdjJTLFrhnp3Wzh4OxjL4CaqP
Sp9kHRYKcC2kABw8LoH0rX+0Ghe3kRQB3GPw04AXyb19P1k+x8UjFXviXlXZpR7S
dFhbRakjWiMc0gYJlyqjBjyFVT0Sx3bxuD+NrWaeI1QFwHwNx1EdltkcIXpyY/Ck
oUL7+zm+qQAf3k2ttFsJ4vMNGVqPmlZYIQfrnR13UwPnNDTfoUh8ibW+bHNgWMnu
kh5379BaODEr6b/2YkpUSxfPhBrqgOFZiF7q0f5mjGVM24E91zvcEaolFKyy5Yr4
325oQ1mpbikM+lE4xjNM2o2vNCKGsoKKR/EebYydeeIwi4Ok+fWu8uQ88rGb/zrw
tYpWCGfy7BWPojqJNvWvIHz+7v/EOmvbWdXsYxvidujWnfcHwALaUtwznjXX/f4m
+DrM8FNGYn8xT1SuOZtY7q8S9tl63v/Fml4HyhgwpBtP2Ca1WhTHx0wq9uI9XVaz
EIFeSAptwjNh+uCYTjJphz0vKSaphdW4FCODaHskOO6pTU88jls=
=fRyU
-----END PGP SIGNATURE-----

--zkcon2xpijdemyux--

