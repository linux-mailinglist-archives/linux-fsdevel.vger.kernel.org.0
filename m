Return-Path: <linux-fsdevel+bounces-62330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE7FB8D899
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E898189DD13
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8330924BBEE;
	Sun, 21 Sep 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="albyWG3d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E61DED63;
	Sun, 21 Sep 2025 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758446799; cv=none; b=bOR5M45ADpZsh7OQmrmj9IrbwPE9hbdVQpdL1ZQh7/qV6E19Rxk/cGS0iGa8lgejZIeRejZsYY+gI//wRRt0Xi/VqxblrMnqAuxf7MfgUZJjImIG1LU3KW1F4s9WusUmQ0PtySaKETBXCUL4ANDszSvnHfF5kfbFN6jIxObnKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758446799; c=relaxed/simple;
	bh=fCeZz8UQ+Q/xYJdKl83KladdpvpmUk4P4WcQb+PmfgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8r4B0vMcjFgofqhIaD7yP1rIWE4rVOtzykuzmp6ibsSEcj+IXNz7J/mG4Pj2uqGJ/HGrqPBwE3NawpOaTkyPWLElv1zrqfT4edp3CfFGkBaTgQ5f7ZFt/8RcKH8+GgFg6rWylXqqTvj+7Ds5yK0tYkLDXiY0mtiMyBDkjdIY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=albyWG3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19AFC4CEE7;
	Sun, 21 Sep 2025 09:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758446799;
	bh=fCeZz8UQ+Q/xYJdKl83KladdpvpmUk4P4WcQb+PmfgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=albyWG3dk8rf0xwcwNIFfPp8ZEfzatOtDXT9LGjeBaGvumfFh04WlSVB80oZUMuzC
	 +AV3KpzKyk+2sACqs3DvkK86rkSrMLnb7kLIKxxqEHB1eeYFTWfYLqx/c5E0BHCB2D
	 ukRQTgH1HzUxFJiYn6RgeOgl3VEV7vts+1BCBiscRdkV3lVnOGwuN5eXmAqZi0azMz
	 nDxfWSkxM7Bln4Dkqhss5/HTEC3OamsXXH7KSUo9BQqT07gztcnVK89ZcbRpyLpSLq
	 8TN4P3j8d+Ohw1cTt8awPbB7dhySzqxHdqD2TdSX4ZwUJjB6pRRE1EMm3lV+Mt2UOd
	 S77QQx8yLQbfg==
Date: Sun, 21 Sep 2025 11:26:31 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 04/10] man/man2/fsconfig.2: document "new" mount API
Message-ID: <e4jtqbymqguq64zup5qr6rnppwjyveqdzvqdbnz3c7v55zplbs@6bpdfbv6sh7d>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-4-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3ex4dzzzd7usxys"
Content-Disposition: inline
In-Reply-To: <20250919-new-mount-api-v4-4-1261201ab562@cyphar.com>


--x3ex4dzzzd7usxys
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
Subject: Re: [PATCH v4 04/10] man/man2/fsconfig.2: document "new" mount API
Message-ID: <e4jtqbymqguq64zup5qr6rnppwjyveqdzvqdbnz3c7v55zplbs@6bpdfbv6sh7d>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-4-1261201ab562@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250919-new-mount-api-v4-4-1261201ab562@cyphar.com>

Hi Aleksa,

On Fri, Sep 19, 2025 at 11:59:45AM +1000, Aleksa Sarai wrote:
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
>  man/man2/fsconfig.2 | 727 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 727 insertions(+)
>=20
> diff --git a/man/man2/fsconfig.2 b/man/man2/fsconfig.2
> new file mode 100644
> index 0000000000000000000000000000000000000000..5a18e08c700ac93aa22c341b4=
134944ee3c38d0b
> --- /dev/null
> +++ b/man/man2/fsconfig.2
> @@ -0,0 +1,727 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH fsconfig 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +fsconfig \- configure new or existing filesystem context
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ,\~ \-lc )
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/mount.h>
> +.P
> +.BI "int fsconfig(int " fd ", unsigned int " cmd ,
> +.BI "             const char *_Nullable " key ,
> +.BI "             const void *_Nullable " value ", int " aux );
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR fsconfig ()
> +system call is part of
> +the suite of file descriptor based mount facilities in Linux.
> +.P
> +.BR fsconfig ()
> +is used to supply parameters to
> +and issue commands against
> +the filesystem configuration context
> +associated with the file descriptor
> +.IR fd .
> +Filesystem configuration contexts can be created with
> +.BR fsopen (2)
> +or be instantiated from an extant filesystem instance with
> +.BR fspick (2).
> +.P
> +The
> +.I cmd
> +argument indicates the command to be issued.
> +Some commands supply parameters to the context
> +(equivalent to mount options specified with
> +.BR mount (8)),
> +while others are meta-operations on the filesystem context.
> +The list of valid
> +.I cmd
> +values are:

I think I would have this page split into one page per command.

I would keep an overview in this page, of the main system call, and the
descriptions of each subcommand would go into each separate page.

You could have a look at fcntl(2), which has been the most recent page
split, and let me know what you think.


Have a lovely day!
Alex

> +.RS
> +.TP
> +.B FSCONFIG_SET_FLAG
> +Set the flag parameter named by
> +.IR key .
> +.I value
> +must be NULL,
> +and
> +.I aux
> +must be 0.
> +.TP
> +.B FSCONFIG_SET_STRING
> +Set the string parameter named by
> +.I key
> +to the value specified by
> +.IR value .
> +.I value
> +points to a null-terminated string,
> +and
> +.I aux
> +must be 0.
> +.TP
> +.B FSCONFIG_SET_BINARY
> +Set the blob parameter named by
> +.I key
> +to the contents of the binary blob
> +specified by
> +.IR value .
> +.I value
> +points to
> +the start of a buffer
> +that is
> +.I aux
> +bytes in length.
> +.TP
> +.B FSCONFIG_SET_FD
> +Set the file parameter named by
> +.I key
> +to the open file description
> +referenced by the file descriptor
> +.IR aux .
> +.I value
> +must be NULL.
> +.IP
> +You may also use
> +.B \%FSCONFIG_SET_STRING
> +for file parameters,
> +with
> +.I value
> +set to a null-terminated string
> +containing a base-10 representation
> +of the file descriptor number.
> +This mechanism is primarily intended for compatibility
> +with older
> +.BR mount (2)-based
> +programs,
> +and only works for parameters
> +that
> +.I only
> +accept file descriptor arguments.
> +.TP
> +.B FSCONFIG_SET_PATH
> +Set the path parameter named by
> +.I key
> +to the object at a provided path,
> +resolved in a similar manner to
> +.BR openat (2).
> +.I value
> +points to a null-terminated pathname string,
> +and
> +.I aux
> +is equivalent to the
> +.I dirfd
> +argument to
> +.BR openat (2).
> +See
> +.BR openat (2)
> +for an explanation of the need for
> +.BR \%FSCONFIG_SET_PATH .
> +.IP
> +You may also use
> +.B \%FSCONFIG_SET_STRING
> +for path parameters,
> +the behaviour of which is equivalent to
> +.B \%FSCONFIG_SET_PATH
> +with
> +.I aux
> +set to
> +.BR \%AT_FDCWD .
> +.TP
> +.B FSCONFIG_SET_PATH_EMPTY
> +As with
> +.BR \%FSCONFIG_SET_PATH ,
> +except that if
> +.I value
> +is an empty string,
> +the file descriptor specified by
> +.I aux
> +is operated on directly
> +and may be any type of file
> +(not just a directory).
> +This is equivalent to the behaviour of
> +.B \%AT_EMPTY_PATH
> +with most "*at()" system calls.
> +If
> +.I aux
> +is
> +.BR \%AT_FDCWD ,
> +the parameter will be set to
> +the current working directory
> +of the calling process.
> +.TP
> +.B FSCONFIG_CMD_CREATE
> +This command instructs the filesystem driver
> +to instantiate an instance of the filesystem in the kernel
> +with the parameters specified in the filesystem configuration context.
> +.I key
> +and
> +.I value
> +must be NULL,
> +and
> +.I aux
> +must be 0.
> +.IP
> +This command can only be issued once
> +in the lifetime of a filesystem context.
> +If the operation succeeds,
> +the filesystem context
> +associated with file descriptor
> +.I fd
> +now references the created filesystem instance,
> +and is placed into a special "awaiting-mount" mode
> +that allows you to use
> +.BR fsmount (2)
> +to create a mount object from the filesystem instance.
> +.\" FS_CONTEXT_AWAITING_MOUNT is the term the kernel uses for this.
> +If the operation fails,
> +in most cases
> +the filesystem context is placed in a failed mode
> +and cannot be used for any further
> +.BR fsconfig ()
> +operations
> +(though you may still retrieve diagnostic messages
> +through the message retrieval interface,
> +as described in
> +the corresponding subsection of
> +.BR fsopen (2)).
> +.IP
> +This command can only be issued against
> +filesystem configuration contexts
> +that were created with
> +.BR fsopen (2).
> +In order to create a filesystem instance,
> +the calling process must have the
> +.B \%CAP_SYS_ADMIN
> +capability.
> +.IP
> +An important thing to be aware of is that
> +the Linux kernel will
> +.I silently
> +reuse extant filesystem instances
> +depending on the filesystem type
> +and the configured parameters
> +(each filesystem driver has
> +its own policy for
> +how filesystem instances are reused).
> +This means that
> +the filesystem instance "created" by
> +.B \%FSCONFIG_CMD_CREATE
> +may, in fact, be a reference
> +to an extant filesystem instance in the kernel.
> +(For reference,
> +this behaviour also applies to
> +.BR mount (2).)
> +.IP
> +One side-effect of this behaviour is that
> +if an extant filesystem instance is reused,
> +.I all
> +parameters configured
> +for this filesystem configuration context
> +are
> +.I silently ignored
> +(with the exception of the
> +.I ro
> +and
> +.I rw
> +flag parameters;
> +if the state of the read-only flag in the
> +extant filesystem instance and the filesystem configuration context
> +do not match, this operation will return
> +.BR EBUSY ).
> +This also means that
> +.BR \%FSCONFIG_CMD_RECONFIGURE
> +commands issued against
> +the "created" filesystem instance
> +will also affect any mount objects associated with
> +the extant filesystem instance.
> +.IP
> +Programs that need to ensure
> +that they create a new filesystem instance
> +with specific parameters
> +(notably, security-related parameters
> +such as
> +.I acl
> +to enable POSIX ACLs\[em]as described in
> +.BR acl (5))
> +should use
> +.B \%FSCONFIG_CMD_CREATE_EXCL
> +instead.
> +.TP
> +.BR FSCONFIG_CMD_CREATE_EXCL " (since Linux 6.6)"
> +.\" commit 22ed7ecdaefe0cac0c6e6295e83048af60435b13
> +.\" commit 84ab1277ce5a90a8d1f377707d662ac43cc0918a
> +As with
> +.BR \%FSCONFIG_CMD_CREATE ,
> +except that the kernel is instructed
> +to not reuse extant filesystem instances.
> +If the operation
> +would be forced to
> +reuse an extant filesystem instance,
> +this operation will return
> +.B EBUSY
> +instead.
> +.IP
> +As a result (unlike
> +.BR \%FSCONFIG_CMD_CREATE ),
> +if this operation succeeds
> +then the calling process can be sure that
> +all of the parameters successfully configured with
> +.BR fsconfig ()
> +will actually be applied
> +to the created filesystem instance.
> +.TP
> +.B FSCONFIG_CMD_RECONFIGURE
> +This command instructs the filesystem driver
> +to apply the parameters specified in the filesystem configuration context
> +to the extant filesystem instance
> +referenced by the filesystem configuration context.
> +.I key
> +and
> +.I value
> +must be NULL,
> +and
> +.I aux
> +must be 0.
> +.IP
> +This is primarily intended for use with
> +.BR fspick (2),
> +but may also be used to modify
> +the parameters of a filesystem instance
> +after
> +.BR \%FSCONFIG_CMD_CREATE
> +was used to create it
> +and a mount object was created using
> +.BR fsmount (2).
> +In order to reconfigure an extant filesystem instance,
> +the calling process must have the
> +.B CAP_SYS_ADMIN
> +capability.
> +.IP
> +If the operation succeeds,
> +the filesystem context is reset
> +but remains in reconfiguration mode
> +and thus can be reused for subsequent
> +.B \%FSCONFIG_CMD_RECONFIGURE
> +commands.
> +If the operation fails,
> +in most cases
> +the filesystem context is placed in a failed mode
> +and cannot be used for any further
> +.BR fsconfig ()
> +operations
> +(though you may still retrieve diagnostic messages
> +through the message retrieval interface,
> +as described in
> +the corresponding subsection of
> +.BR fsopen (2)).
> +.RE
> +.P
> +Parameters specified with
> +.BI FSCONFIG_SET_ *
> +do not take effect
> +until a corresponding
> +.B \%FSCONFIG_CMD_CREATE
> +or
> +.B \%FSCONFIG_CMD_RECONFIGURE
> +command is issued.
> +.SH RETURN VALUE
> +On success,
> +.BR fsconfig ()
> +returns 0.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +If an error occurs, the filesystem driver may provide
> +additional information about the error
> +through the message retrieval interface for filesystem configuration con=
texts.
> +This additional information can be retrieved at any time by calling
> +.BR read (2)
> +on the filesystem instance or filesystem configuration context
> +referenced by the file descriptor
> +.IR fd .
> +(See the "Message retrieval interface" subsection in
> +.BR fsopen (2)
> +for more details on the message format.)
> +.P
> +Even after an error occurs,
> +the filesystem configuration context is
> +.I not
> +invalidated,
> +and thus can still be used with other
> +.BR fsconfig ()
> +commands.
> +This means that users can probe support for filesystem parameters
> +on a per-parameter basis,
> +and adjust which parameters they wish to set.
> +.P
> +The error values given below result from
> +filesystem type independent errors.
> +Each filesystem type may have its own special errors
> +and its own special behavior.
> +See the Linux kernel source code for details.
> +.TP
> +.B EACCES
> +A component of a path
> +provided as a path parameter
> +was not searchable.
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EACCES
> +.B \%FSCONFIG_CMD_CREATE
> +was attempted
> +for a read-only filesystem
> +without specifying the
> +.RB ' ro '
> +flag parameter.
> +.TP
> +.B EACCES
> +A specified block device parameter
> +is located on a filesystem
> +mounted with the
> +.B \%MS_NODEV
> +option.
> +.TP
> +.B EBADF
> +The file descriptor given by
> +.I fd
> +(or possibly by
> +.IR aux ,
> +depending on the command)
> +is invalid.
> +.TP
> +.B EBUSY
> +The filesystem context associated with
> +.I fd
> +is in the wrong state
> +for the given command.
> +.TP
> +.B EBUSY
> +The filesystem instance cannot be reconfigured as read-only
> +with
> +.B \%FSCONFIG_CMD_RECONFIGURE
> +because some programs
> +still hold files open for writing.
> +.TP
> +.B EBUSY
> +A new filesystem instance was requested with
> +.B \%FSCONFIG_CMD_CREATE_EXCL
> +but a matching superblock already existed.
> +.TP
> +.B EFAULT
> +One of the pointer arguments
> +points to a location
> +outside the calling process's accessible address space.
> +.TP
> +.B EINVAL
> +.I fd
> +does not refer to
> +a filesystem configuration context
> +or filesystem instance.
> +.TP
> +.B EINVAL
> +One of the values of
> +.IR name ,
> +.IR value ,
> +and/or
> +.I aux
> +were set to a non-zero value when
> +.I cmd
> +required that they be zero
> +(or NULL).
> +.TP
> +.B EINVAL
> +The parameter named by
> +.I name
> +cannot be set
> +using the type specified with
> +.IR cmd .
> +.TP
> +.B EINVAL
> +One of the source parameters
> +referred to
> +an invalid superblock.
> +.TP
> +.B ELOOP
> +Too many links encountered
> +during pathname resolution
> +of a path argument.
> +.TP
> +.B ENAMETOOLONG
> +A path argument was longer than
> +.BR PATH_MAX .
> +.TP
> +.B ENOENT
> +A path argument had a non-existent component.
> +.TP
> +.B ENOENT
> +A path argument is an empty string,
> +but
> +.I cmd
> +is not
> +.BR \%FSCONFIG_SET_PATH_EMPTY .
> +.TP
> +.B ENOMEM
> +The kernel could not allocate sufficient memory to complete the operatio=
n.
> +.TP
> +.B ENOTBLK
> +The parameter named by
> +.I name
> +must be a block device,
> +but the provided parameter value was not a block device.
> +.TP
> +.B ENOTDIR
> +A component of the path prefix
> +of a path argument
> +was not a directory.
> +.TP
> +.B EOPNOTSUPP
> +The command given by
> +.I cmd
> +is not valid.
> +.TP
> +.B ENXIO
> +The major number
> +of a block device parameter
> +is out of range.
> +.TP
> +.B EPERM
> +The command given by
> +.I cmd
> +was
> +.BR \%FSCONFIG_CMD_CREATE ,
> +.BR \%FSCONFIG_CMD_CREATE_EXCL ,
> +or
> +.BR \%FSCONFIG_CMD_RECONFIGURE ,
> +but the calling process does not have the required
> +.B \%CAP_SYS_ADMIN
> +capability.
> +.SH STANDARDS
> +Linux.
> +.SH HISTORY
> +Linux 5.2.
> +.\" commit ecdab150fddb42fe6a739335257949220033b782
> +.\" commit 400913252d09f9cfb8cce33daee43167921fc343
> +glibc 2.36.
> +.SH NOTES
> +.SS Generic filesystem parameters
> +Each filesystem driver is responsible for
> +parsing most parameters specified with
> +.BR fsconfig (),
> +meaning that individual filesystems
> +may have very different behaviour
> +when encountering parameters with the same name.
> +In general,
> +you should not assume that the behaviour of
> +.BR fsconfig ()
> +when specifying a parameter to one filesystem type
> +will match the behaviour of the same parameter
> +with a different filesystem type.
> +.P
> +However,
> +the following generic parameters
> +apply to all filesystems and have unified behaviour.
> +They are set using the listed
> +.BI \%FSCONFIG_SET_ *
> +command.
> +.TP
> +\fIro\fP and \fIrw\fP (\fB\%FSCONFIG_SET_FLAG\fP)
> +Configure whether the filesystem instance is read-only.
> +.TP
> +\fIdirsync\fP (\fB\%FSCONFIG_SET_FLAG\fP)
> +Make directory changes on this filesystem instance synchronous.
> +.TP
> +\fIsync\fP and \fIasync\fP (\fB\%FSCONFIG_SET_FLAG\fP)
> +Configure whether writes on this filesystem instance
> +will be made synchronous
> +(as though the
> +.B O_SYNC
> +flag to
> +.BR open (2)
> +was specified for
> +all file opens in this filesystem instance).
> +.TP
> +\fIlazytime\fP and \fInolazytime\fP (\fB\%FSCONFIG_SET_FLAG\fP)
> +Configure whether to reduce on-disk updates
> +of inode timestamps on this filesystem instance
> +(as described in the
> +.B \%MS_LAZYTIME
> +section of
> +.BR mount (2)).
> +.TP
> +\fImand\fP and \fInomand\fP (\fB\%FSCONFIG_SET_FLAG\fP)
> +Configure whether the filesystem instance should permit mandatory lockin=
g.
> +Since Linux 5.15,
> +.\" commit f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3
> +mandatory locking has been deprecated
> +and setting this flag is a no-op.
> +.TP
> +\fIsource\fP (\fB\%FSCONFIG_SET_STRING\fP)
> +This parameter is equivalent to the
> +.I source
> +parameter passed to
> +.BR mount (2)
> +for the same filesystem type,
> +and is usually the pathname of a block device
> +containing the filesystem.
> +This parameter may only be set once
> +per filesystem configuration context transaction.
> +.P
> +In addition,
> +any filesystem parameters associated with
> +Linux Security Modules (LSMs)
> +are also generic with respect to the underlying filesystem.
> +See the documentation for the LSM you wish to configure for more details.
> +.SH CAVEATS
> +.SS Filesystem parameter types
> +As a result of
> +each filesystem driver being responsible for
> +parsing most parameters specified with
> +.BR fsconfig (),
> +some filesystem drivers
> +may have unintuitive behaviour
> +with regards to which
> +.BI \%FSCONFIG_SET_ *
> +commands are permitted
> +to configure a given parameter.
> +.P
> +In order for
> +filesystem parameters to be backwards compatible with
> +.BR mount (2),
> +they must be parseable as strings;
> +this almost universally means that
> +.B \%FSCONFIG_SET_STRING
> +can also be used to configure them.
> +.\" Aleksa Sarai
> +.\"   Theoretically, a filesystem could check fc->oldapi and refuse
> +.\"   FSCONFIG_SET_STRING if the operation is coming from the new API, b=
ut no
> +.\"   filesystems do this (and probably never will).
> +However, other
> +.BI \%FSCONFIG_SET_ *
> +commands need to be opted into
> +by each filesystem driver's parameter parser.
> +.P
> +One of the most user-visible instances of
> +this inconsistency is that
> +many filesystems do not support
> +configuring path parameters with
> +.B \%FSCONFIG_SET_PATH
> +(despite the name),
> +which can lead to somewhat confusing
> +.B EINVAL
> +errors.
> +(For example, the generic
> +.I source
> +parameter\[em]which is usually a path\[em]can only be configured
> +with
> +.BR \%FSCONFIG_SET_STRING .)
> +.P
> +When writing programs that use
> +.BR fsconfig ()
> +to configure parameters
> +with commands other than
> +.BR \%FSCONFIG_SET_STRING ,
> +users should verify
> +that the
> +.BI \%FSCONFIG_SET_ *
> +commands used to configure each parameter
> +are supported by the corresponding filesystem driver.
> +.\" Aleksa Sarai
> +.\"   While this (quite confusing) inconsistency in behaviour is true to=
day
> +.\"   (and has been true since this was merged), this appears to mostly =
be an
> +.\"   unintended consequence of filesystem drivers hand-coding fsparam p=
arsing.
> +.\"   Path parameters are the most eggregious causes of confusion. Hopef=
ully we
> +.\"   can make this no longer the case in a future kernel.
> +.SH EXAMPLES
> +To illustrate the different kinds of flags that can be configured with
> +.BR fsconfig (),
> +here are a few examples of some different filesystems being created:
> +.P
> +.in +4n
> +.EX
> +int fsfd, mntfd;
> +\&
> +fsfd =3D fsopen("tmpfs", FSOPEN_CLOEXEC);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "inode64", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "uid", "1234", 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "huge", "never", 0);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "casefold", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NOEXEC);
> +move_mount(mntfd, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH);
> +\&
> +fsfd =3D fsopen("erofs", FSOPEN_CLOEXEC);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "/dev/loop0", 0);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_CMD_CREATE_EXCL, NULL, NULL, 0);
> +mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NOSUID);
> +move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +Usually,
> +specifying the same parameter named by
> +.I key
> +multiple times with
> +.BR fsconfig ()
> +causes the parameter value to be replaced.
> +However, some filesystems may have unique behaviour:
> +.P
> +.in +4n
> +.EX
> +\&
> +int fsfd, mntfd;
> +int lowerdirfd =3D open("/o/ctr/lower1", O_DIRECTORY | O_CLOEXEC);
> +\&
> +fsfd =3D fsopen("overlay", FSOPEN_CLOEXEC);
> +/* "lowerdir+" appends to the lower dir stack each time. */
> +fsconfig(fsfd, FSCONFIG_SET_FD, "lowerdir+", NULL, lowerdirfd);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "lowerdir+", "/o/ctr/lower2", 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "lowerdir+", "/o/ctr/lower3", 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "lowerdir+", "/o/ctr/lower4", 0);
> +.\" fsconfig(fsfd, FSCONFIG_SET_PATH, "lowerdir+", "/o/ctr/lower5", AT_F=
DCWD);
> +.\" fsconfig(fsfd, FSCONFIG_SET_PATH_EMPTY, "lowerdir+", "", lowerdirfd);
> +.\" Aleksa Sarai: Hopefully these will also be supported in the future.
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "xino", "auto", 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "nfs_export", "off", 0);
> +fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
> +move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +And here is an example of how
> +.BR fspick (2)
> +can be used with
> +.BR fsconfig ()
> +to reconfigure the parameters
> +of an extant filesystem instance
> +attached to
> +.IR /proc :
> +.P
> +.in +4n
> +.EX
> +int fsfd =3D fspick(AT_FDCWD, "/proc", FSPICK_CLOEXEC);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "hidepid", "ptraceable", 0);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "subset", "pid", 0);
> +fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
> +.EE
> +.in
> +.SH SEE ALSO
> +.BR fsmount (2),
> +.BR fsopen (2),
> +.BR fspick (2),
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

--x3ex4dzzzd7usxys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjPxMcACgkQ64mZXMKQ
wqmW2Q//WHnlSQNQxN5MWOc5gMLQ1G9AOnt61xpc0/IBe0jQfOuCU2mJWZAeEEF5
h592a2YEmNAbkL7WRFpxJwNlflHqpZKbCIbwKpVJmIWERSZyuJNYVCwHznP0fobU
sCErrjA7ePtO2z3yWsckWynW+JlGTcXR045vXaLYt30z9KZfd5E32g23F/2EtJWF
DlGbpYFT15zQiC/osliGd0VbwKCrZZ/MCvu3x14EVU8fZrQ8V4Z0MeJQ0T8kf/+d
pgxx+AlJEwn/KypwUE7Na4OjZh+I2r8mDlW7RzuxNbmWw5roMuuC9Je2KPAPX0bI
5VxNXH/lWddhN6blTkPq9JdRLSu71Hoc0YYjTapmpfRiiM8nRxycnTvpDIDLgIRy
Sgji/FRUzbTbfc93yrmM68+sqSjzu2ZR1V6flnzGOxfZI1hIU5gNiHaORiccJYbD
hTwy+mf1YKA8o487CS1ILyXf/6pfcOKTFkpgnbWGziIDzMKWXYoFNZPVyo9+V2+2
hJ5E9OYFPqNKD2DXLebsbR5/K+jPm/SmyXsR2yxex3T9aRPDk28cm+JflSjSZN1t
riKgpIOyuk0A17DlSXReO9BWpIciMu1B2aqpFgh5VoA5meBW9v9goPn3RWbz4fME
ozZlMPSfEIT5ioyjmltAcHBNBlctgrhwM+6X4fkIRMaXXnvKvHs=
=jp9t
-----END PGP SIGNATURE-----

--x3ex4dzzzd7usxys--

