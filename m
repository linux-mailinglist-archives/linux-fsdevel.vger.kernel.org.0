Return-Path: <linux-fsdevel+bounces-62712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4734B9E962
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 12:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8502B16B487
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0B2EA49C;
	Thu, 25 Sep 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlFkghCc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9928850B;
	Thu, 25 Sep 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795214; cv=none; b=l4FnO0f9sdBFJpfwqbgcqpV3JoK3pVr1B/Z8y1rs5Dq7I7Z1Q2pw0M/ku9QpzPx7ABtVYP4adBr+JOI0apJ1xmIcOOHrp0V6EXbRgx896z3BPEEPhCxrqXFvMbLn2kgMrIxdGwwwPsiRu9M+vcpzxvJw5Dz8e5YTJ/fx/+U3cEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795214; c=relaxed/simple;
	bh=FmmuoEdPE7PUu8EUIKJubbTNL4XAhktWLkvzsHWpSvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdwmcvSGJMg8xtOdizJ8+gMSzz0bcSsNbnrboB1cW92R4tMp91J4K+OE8tAXODq0aUPO48WaYCLxRAqD89Wo4FRpefSWHHpaT0taLfeG9IVFx70HEHuxWspfS83ZaKSZfeEHPgyRIpGTuD7AZ++xc9Sog1sjqd8sYBmG1CfwdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlFkghCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFE8C4CEF0;
	Thu, 25 Sep 2025 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758795212;
	bh=FmmuoEdPE7PUu8EUIKJubbTNL4XAhktWLkvzsHWpSvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlFkghCc6+fVtW7KxixRsN/MLQmVsuJAzZicn5vI4qD0tURLypZjo2Wr8Cy3r0q5H
	 U0Y1Nz6F5OH3mkb1baXv3H9SjkmwMVcuSHvSNUCEuWYKngygnjZVPwSX5ss2g2ZZNT
	 p+8SpZYJSe8i9QRTfDowFmNsDHEyIZ77WnMfLeE+0WuIpExNxOG+yPmcn24GEI78/x
	 uYMUTjPFSWhQR1c9dVu6SCHEw1x1BBgjweVJ6pOKRIWjtJ/60ooeLfgW06Gt4eMQyp
	 fdaSrPjU8B/RJZOfOUdP3DWoITxotHmCIiYuRpRwkiZc/AOmybqe1QHqNxZ3cqL5c/
	 c0EtNVghyFrbA==
Date: Thu, 25 Sep 2025 12:13:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 1/8] man/man2/fsopen.2: document "new" mount API
Message-ID: <5u62uts47ui54bcw6pmjyuop6tazpxjdrezw46t5ygcfzbnonb@yipwnslfinwh>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-1-028fb88023f2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="um5fosvnozlmkdra"
Content-Disposition: inline
In-Reply-To: <20250925-new-mount-api-v5-1-028fb88023f2@cyphar.com>


--um5fosvnozlmkdra
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
Subject: Re: [PATCH v5 1/8] man/man2/fsopen.2: document "new" mount API
Message-ID: <5u62uts47ui54bcw6pmjyuop6tazpxjdrezw46t5ygcfzbnonb@yipwnslfinwh>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-1-028fb88023f2@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250925-new-mount-api-v5-1-028fb88023f2@cyphar.com>

Hi Aleksa,

On Thu, Sep 25, 2025 at 01:31:23AM +1000, Aleksa Sarai wrote:
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

Patch applied.  Thanks!


Have a lovely day!
Alex

> ---
>  man/man2/fsopen.2 | 385 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 385 insertions(+)
>=20
> diff --git a/man/man2/fsopen.2 b/man/man2/fsopen.2
> new file mode 100644
> index 0000000000000000000000000000000000000000..7fbc6c3d28e2e741cd9003c10=
5621b4242abd487
> --- /dev/null
> +++ b/man/man2/fsopen.2
> @@ -0,0 +1,385 @@
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
> +the suite of file-descriptor-based mount facilities in Linux.
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
> +.IP \[bu] 3
> +use the detached mount object file descriptor as a
> +.I dirfd
> +argument to "*at()" system calls;
> +and/or
> +.IP \[bu]
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
> +.B \%FSCONFIG_CMD_CREATE
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
> +.BI e\~ message
> +An error message was logged.
> +This is usually associated with an error being returned
> +from the corresponding system call which triggered this message.
> +.TP
> +.BI w\~ message
> +A warning message was logged.
> +.TP
> +.BI i\~ message
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
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "example.com/pub", 0);
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
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--um5fosvnozlmkdra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjVFcUACgkQ64mZXMKQ
wql6KBAAuha3I2afI78syc7a2g2hlFBtv8tpd+j+4dSzZyJLs0pcC0mGbU38Dy1q
q+E6JBJu3nvS64bh0VfE/PBqb6zx1i2pak3Vlk5+FnffSM1GPTRGjNiWOOq/L7mL
QbxRULDspCER2CLYqW4wZdLShwZnNt84178puIx797JqAKoHl2YbdHSbUj8hDwKw
1tfkt2jwhxP78jhavnTBL54KRs56Z0k7OvQY6b8xKFeJYATT9R72Ghiu7uiI/7sn
/3zzsjf8IRI6P90vW9/NHnYudJOdKhgx1EwRbBwFQq7UDQHQxHpuxTBGh6KQHQ9a
nb4BWuSPugLQ185KLakpaQ72vUDNYHWFRcFKKsyvMf6rlCCJWwDJ49ZY6WsSKLLT
h3GziIKFxddRnjErAAS1x+s1MXfI9I+TrSeWvo+h6hLNvY6QHxRP54/1TlRoBX0S
s4ry732X4SMUYXQsxwEjXOVxGgvRGN7pCPz6bijWbfhi51Gq6Ny1IkX2RCtyTjGH
EiFoTTz9Ytpui+/cQrBYg/+LWu9bSj99k44eIqtN9doDGLsIgRCVB7cZ6b2QFjvL
uJPJRPNGY81mG0NAm8Mdbh/Bk12NyEQCT2bpoMlRSzZvXfHUi4mHfeFLAzfValRt
wlFFXuC1bHVu4Um+w8HKWeldLKI2oPgrmpBFL7ehI5W4DvyjAKM=
=H9w2
-----END PGP SIGNATURE-----

--um5fosvnozlmkdra--

