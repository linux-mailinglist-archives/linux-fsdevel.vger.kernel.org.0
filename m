Return-Path: <linux-fsdevel+bounces-62249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AE2B8A8E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C467C6CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B61321274;
	Fri, 19 Sep 2025 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxRWiL3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABB223DE7;
	Fri, 19 Sep 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299062; cv=none; b=bBEWdWOfHFLNLSIE413xCpk/wsYWJKNx3hpE24xM0SYotq00EASsVeJPiK+yDhP5FfRIPBD835huMnxt35fue4h193GTzEtleMmDEmVQEx7MqXjf6HdowP3SUuoFEmL0ihTFWJb68F9q4F4jJMzHrYVD+0Q+JQrrj0V8aXmaI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299062; c=relaxed/simple;
	bh=SHEH22RcaVF0+MY0PIn5jpD+x87RtQxXb0LMN5IwLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4r25a7hocNURC+j/eUi41Bv8SNs1APYthpFbwY95CCxvSGoqbTh/ywWaD3qmDwbM72Fnfbe7FhlxD5+2o7tplbiwc0q6KA4UUsMd0y+Bn6GnJikxXm+5XiDn0Udcmeg3QGBxtBcpJ2y8nszljsMqbR6pDs+c/PmzO6rH4b7Sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxRWiL3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1DCC4CEF0;
	Fri, 19 Sep 2025 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758299061;
	bh=SHEH22RcaVF0+MY0PIn5jpD+x87RtQxXb0LMN5IwLzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxRWiL3z1Hm9V6sMZnSdhEJGiyDnw7VINWklZvidV6e4e7DYCMBXsX3Gxmq40V+kt
	 5RuAXUEGnMCUvC8ThR1f61GYGQJ7cpHL9+UsbQvyrh5Go9MW3HJ6VI75HZdmAXkXB6
	 H1m4z8p8ipSI97DYHTwX64JuI5W/UIA5BNq7xXIH7dBctl98ogC0bmKNl9+w+bM8pJ
	 WII+pBa6mtxlNYDhPr2ueRtb73Dk1yHKuifj0nnzgt8c+ltjVnfaaUrR0jlMy90rkj
	 5bvFLoOhy7wmfnF9bKtqSy+Ql7cEcwkJe8SyN2AKeYZlgTwHSRy0nYln7xpDE0pH/n
	 g1RmztOiqeWQA==
Date: Fri, 19 Sep 2025 18:24:09 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 02/10] man/man2/fsopen.2: document "new" mount API
Message-ID: <zrifsd6vqj6ve25uipyeteuztncgwtzfmfnfsxhcjwcnxf2wen@xjx3y2g77uin>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-2-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fk2sxccfotbwat6m"
Content-Disposition: inline
In-Reply-To: <20250919-new-mount-api-v4-2-1261201ab562@cyphar.com>


--fk2sxccfotbwat6m
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
Subject: Re: [PATCH v4 02/10] man/man2/fsopen.2: document "new" mount API
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-2-1261201ab562@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250919-new-mount-api-v4-2-1261201ab562@cyphar.com>

Hi Aleksa,

On Fri, Sep 19, 2025 at 11:59:43AM +1000, Aleksa Sarai wrote:
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
>  man/man2/fsopen.2 | 384 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 384 insertions(+)
>=20
> diff --git a/man/man2/fsopen.2 b/man/man2/fsopen.2
> new file mode 100644
> index 0000000000000000000000000000000000000000..7cdbeac7d64b7e5c969dee619=
a039ec947d1e981
> --- /dev/null
> +++ b/man/man2/fsopen.2
> @@ -0,0 +1,384 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH fsopen 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +fsopen \- create a new filesystem context
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ,\~ \-lc )
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/mount.h>
> +.P
> +.BI "int fsopen(const char *" fsname ", unsigned int " flags );
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR fsopen ()
> +system call is part of
> +the suite of file descriptor based mount facilities in Linux.

Minor nitpick (I can amend that; no worries):

Because 'file-descriptor-based' works as a single modifier of
facilities, it goes with hyphens.

> +.P
> +.BR fsopen ()
> +creates a blank filesystem configuration context within the kernel
> +for the filesystem named by
> +.I fsname
> +and places it into creation mode.
> +A new file descriptor
> +associated with the filesystem configuration context
> +is then returned.
> +The calling process must have the
> +.B \%CAP_SYS_ADMIN
> +capability in order to create a new filesystem configuration context.
> +.P
> +A filesystem configuration context is
> +an in-kernel representation of a pending transaction,
> +containing a set of configuration parameters that are to be applied
> +when creating a new instance of a filesystem
> +(or modifying the configuration of an existing filesystem instance,
> +such as when using
> +.BR fspick (2)).
> +.P
> +After obtaining a filesystem configuration context with
> +.BR fsopen (),
> +the general workflow for operating on the context looks like the followi=
ng:
> +.IP (1) 5
> +Pass the filesystem context file descriptor to
> +.BR fsconfig (2)
> +to specify any desired filesystem parameters.
> +This may be done as many times as necessary.
> +.IP (2)
> +Pass the same filesystem context file descriptor to
> +.BR fsconfig (2)
> +with
> +.B \%FSCONFIG_CMD_CREATE
> +to create an instance of the configured filesystem.
> +.IP (3)
> +Pass the same filesystem context file descriptor to
> +.BR fsmount (2)
> +to create a new detached mount object for
> +the root of the filesystem instance,
> +which is then attached to a new file descriptor.
> +(This also places the filesystem context file descriptor into
> +reconfiguration mode,
> +similar to the mode produced by
> +.BR fspick (2).)
> +Once a mount object has been created with
> +.BR fsmount (2),
> +the filesystem context file descriptor can be safely closed.
> +.IP (4)
> +Now that a mount object has been created,
> +you may
> +.RS
> +.IP (4.1) 7
> +use the detached mount object file descriptor as a
> +.I dirfd
> +argument to "*at()" system calls; and/or
> +.IP (4.2) 7

I'll paste here the formatted part of this page:

        (4)  Now that a mount object has been created, you may
=20
             (4.1)  use the detached mount object file descrip=E2=80=90
                    tor as a dirfd argument to "*at()" system
                    calls; and/or
=20
             (4.2)  attach the mount object to a mount point by
                    passing the mount object file descriptor to
                    move_mount(2).  This will also prevent the
                    mount object from being unmounted and de=E2=80=90
                    stroyed when the mount object file descrip=E2=80=90
                    tor is closed.

             The mount object file descriptor will remain asso=E2=80=90
             ciated with the mount object even after doing the
             above operations, so you may repeatedly use the
             mount object file descriptor with move_mount(2)
             and/or "*at()" system calls as many times as neces=E2=80=90
             sary.

That sublist seems to be an unordered one.  I think we should use
a bullet list for those items (the outer list 1,2,3,4 is okay as is).

       Bullet lists
              Elements are preceded by bullet symbols  (\[bu]).
              Anything  that  doesn't  fit elsewhere is usually
              covered by this type of list.

> +attach the mount object to a mount point
> +by passing the mount object file descriptor to
> +.BR move_mount (2).
> +This will also prevent the mount object from
> +being unmounted and destroyed when
> +the mount object file descriptor is closed.
> +.RE
> +.IP
> +The mount object file descriptor will
> +remain associated with the mount object
> +even after doing the above operations,
> +so you may repeatedly use the mount object file descriptor with
> +.BR move_mount (2)
> +and/or "*at()" system calls
> +as many times as necessary.
> +.P
> +A filesystem context will move between different modes
> +throughout its lifecycle
> +(such as the creation phase
> +when created with
> +.BR fsopen (),
> +the reconfiguration phase
> +when an existing filesystem instance is selected with
> +.BR fspick (2),
> +and the intermediate "awaiting-mount" phase
> +.\" FS_CONTEXT_AWAITING_MOUNT is the term the kernel uses for this.
> +between
> +.BR \%FSCONFIG_CMD_CREATE
> +and
> +.BR fsmount (2)),
> +which has an impact on
> +what operations are permitted on the filesystem context.
> +.P
> +The file descriptor returned by
> +.BR fsopen ()
> +also acts as a channel for filesystem drivers to
> +provide more comprehensive diagnostic information
> +than is normally provided through the standard
> +.BR errno (3)
> +interface for system calls.
> +If an error occurs at any time during the workflow mentioned above,
> +calling
> +.BR read (2)
> +on the filesystem context file descriptor
> +will retrieve any ancillary information about the encountered errors.
> +(See the "Message retrieval interface" section
> +for more details on the message format.)
> +.P
> +.I flags
> +can be used to control aspects of
> +the creation of the filesystem configuration context file descriptor.
> +A value for
> +.I flags
> +is constructed by bitwise ORing
> +zero or more of the following constants:
> +.RS
> +.TP
> +.B FSOPEN_CLOEXEC
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
> +A list of filesystems supported by the running kernel
> +(and thus a list of valid values for
> +.IR fsname )
> +can be obtained from
> +.IR /proc/filesystems .
> +(See also
> +.BR proc_filesystems (5).)
> +.SS Message retrieval interface
> +When doing operations on a filesystem configuration context,
> +the filesystem driver may choose to provide
> +ancillary information to userspace
> +in the form of message strings.
> +.P
> +The filesystem context file descriptors returned by
> +.BR fsopen ()
> +and
> +.BR fspick (2)
> +may be queried for message strings at any time by calling
> +.BR read (2)
> +on the file descriptor.
> +Each call to
> +.BR read (2)
> +will return a single message,
> +prefixed to indicate its class:
> +.RS
> +.TP
> +\fBe\fP <\fImessage\fP>

We don't use '<' and '>' for indicating variable parts.  We already use
italics for that.  The reason to avoid the '<' and '>' is that it is
confusing: it is often unclear if the '<' are literal or placeholders.

We only use '<' when they're literal.

I suspect your want

	.BI e\~ message

BTW, I'm assuming there's one space between the letter and the message,
and there are no literal '<'/'>', right?


Have a lovely day!
Alex

> +An error message was logged.
> +This is usually associated with an error being returned
> +from the corresponding system call which triggered this message.
> +.TP
> +\fBw\fP <\fImessage\fP>
> +A warning message was logged.
> +.TP
> +\fBi\fP <\fImessage\fP>
> +An informational message was logged.
> +.RE
> +.P
> +Messages are removed from the queue as they are read.
> +Note that the message queue has limited depth,
> +so it is possible for messages to get lost.
> +If there are no messages in the message queue,
> +.B read(2)
> +will return \-1 and
> +.I errno
> +will be set to
> +.BR \%ENODATA .
> +If the
> +.I buf
> +argument to
> +.BR read (2)
> +is not large enough to contain the entire message,
> +.BR read (2)
> +will return \-1 and
> +.I errno
> +will be set to
> +.BR \%EMSGSIZE .
> +(See BUGS.)
> +.P
> +If there are multiple filesystem contexts
> +referencing the same filesystem instance
> +(such as if you call
> +.BR fspick (2)
> +multiple times for the same mount),
> +each one gets its own independent message queue.
> +This does not apply to multiple file descriptors that are
> +tied to the same underlying open file description
> +(such as those created with
> +.BR dup (2)).
> +.P
> +Message strings will usually be prefixed by
> +the name of the filesystem or kernel subsystem
> +that logged the message,
> +though this may not always be the case.
> +See the Linux kernel source code for details.
> +.SH RETURN VALUE
> +On success, a new file descriptor is returned.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EFAULT
> +.I fsname
> +is NULL
> +or a pointer to a location
> +outside the calling process's accessible address space.
> +.TP
> +.B EINVAL
> +.I flags
> +had an invalid flag set.
> +.TP
> +.B EMFILE
> +The calling process has too many open files to create more.
> +.TP
> +.B ENFILE
> +The system has too many open files to create more.
> +.TP
> +.B ENODEV
> +The filesystem named by
> +.I fsname
> +is not supported by the kernel.
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
> +.\" commit 24dcb3d90a1f67fe08c68a004af37df059d74005
> +.\" commit 400913252d09f9cfb8cce33daee43167921fc343
> +glibc 2.36.
> +.SH BUGS
> +.SS Message retrieval interface and \fB\%EMSGSIZE\fP
> +As described in the "Message retrieval interface" subsection above,
> +calling
> +.BR read (2)
> +with too small a buffer to contain
> +the next pending message in the message queue
> +for the filesystem configuration context
> +will cause
> +.BR read (2)
> +to return \-1 and set
> +.BR errno (3)
> +to
> +.BR \%EMSGSIZE .
> +.P
> +However,
> +this failed operation still
> +consumes the message from the message queue.
> +This effectively discards the message silently,
> +as no data is copied into the
> +.BR read (2)
> +buffer.
> +.P
> +Programs should take care to ensure that
> +their buffers are sufficiently large
> +to contain any reasonable message string,
> +in order to avoid silently losing valuable diagnostic information.
> +.\" Aleksa Sarai
> +.\"   This unfortunate behaviour has existed since this feature was merg=
ed, but
> +.\"   I have sent a patchset which will finally fix it.
> +.\"   <https://lore.kernel.org/r/20250807-fscontext-log-cleanups-v3-1-8d=
91d6242dc3@cyphar.com/>
> +.SH EXAMPLES
> +To illustrate the workflow for creating a new mount,
> +the following is an example of how to mount an
> +.BR ext4 (5)
> +filesystem stored on
> +.I /dev/sdb1
> +onto
> +.IR /mnt .
> +.P
> +.in +4n
> +.EX
> +int fsfd, mntfd;
> +\&
> +fsfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_SET_PATH, "source", "/dev/sdb1", AT_FDCWD);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "noatime", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "iversion", NULL, 0)
> +fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_RELATIME);
> +move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +First,
> +an ext4 configuration context is created and attached to the file descri=
ptor
> +.IR fsfd .
> +Then, a series of parameters
> +(such as the source of the filesystem)
> +are provided using
> +.BR fsconfig (2),
> +followed by the filesystem instance being created with
> +.BR \%FSCONFIG_CMD_CREATE .
> +.BR fsmount (2)
> +is then used to create a new mount object attached to the file descriptor
> +.IR mntfd ,
> +which is then attached to the intended mount point using
> +.BR move_mount (2).
> +.P
> +The above procedure is functionally equivalent to
> +the following mount operation using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/dev/sdb1", "/mnt", "ext4", MS_RELATIME,
> +      "ro,noatime,acl,user_xattr,iversion");
> +.EE
> +.in
> +.P
> +And here's an example of creating a mount object
> +of an NFS server share
> +and setting a Smack security module label.
> +However, instead of attaching it to a mount point,
> +the program uses the mount object directly
> +to open a file from the NFS share.
> +.P
> +.in +4n
> +.EX
> +int fsfd, mntfd, fd;
> +\&
> +fsfd =3D fsopen("nfs", 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "example.com/pub/linux", 0=
);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "nfsvers", "3", 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "rsize", "65536", 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "wsize", "65536", 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "smackfsdef", "foolabel", 0);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "rdma", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mntfd =3D fsmount(fsfd, 0, MOUNT_ATTR_NODEV);
> +fd =3D openat(mntfd, "src/linux-5.2.tar.xz", O_RDONLY);
> +.EE
> +.in
> +.P
> +Unlike the previous example,
> +this operation has no trivial equivalent with
> +.BR mount (2),
> +as it was not previously possible to create a mount object
> +that is not attached to any mount point.
> +.SH SEE ALSO
> +.BR fsconfig (2),
> +.BR fsmount (2),
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

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--fk2sxccfotbwat6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjNg6MACgkQ64mZXMKQ
wqnJ2xAAo2WI6i6gCc/BKqjuo+J/UEDWIQch0hww8FwlY7VWE2aU+haQWaD9yGgU
OUbx0uEcyV6ikYFTuMgXNSo15Kn3jycayDOBZZ8+Y9+f/DWghq5P4ZzhnThnqt7W
8G9w3hUAEJtH4s7btKiUmgGlJXk5/DSaipMLyFc78OVvWTXaZDMUnlutSoOvwf51
fkAxVbtTq2e7zKBlj54Gdh1OEGAz/a2JScvef310NQZKftoZnbaQQlQUr2MOQUGz
IzEVbhh+4gSCbkGFO4rvlsEHxSDk+OLdNLdt0Kc+W9W90bufL4B/AtMdO15m2DQc
BDbMrvIgt6rFQtw63iirhj/kQenbH2Bjy7piXSgyziv+qW+sZf3uEKAoN6NhDQCf
2MuK9W6/oZbSJbhi852D8+9SbWLcg/K03x/vh5WUGaVdc0zre+apQbjSrtE3CS2Y
JC7dx8cGxkWwlPovPOtryD8twOOyFOpgWiQjYcDxdNxhHvBqwTRQFFB5D2EOUEnJ
CRqqitBC/SL4bjkXZJdp3VPdKaTmRUyn6lBZeJpaH2IDV3ZSk7By3WeQiNAYI/ix
napBZpSZCHICQKTPFWThY+B4wl5iOdCF78nUT83EBNkbX0Yd6Ban2KYdPJv1Httn
yGE9xSbfDKpySARskZpn0s+NbkGi86SyfgQkmsahgQ2lolU/dD0=
=ceZc
-----END PGP SIGNATURE-----

--fk2sxccfotbwat6m--

