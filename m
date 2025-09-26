Return-Path: <linux-fsdevel+bounces-62876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DBBBA3B83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64347A9816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B62F28ED;
	Fri, 26 Sep 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf13dN7x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72F1EEE6;
	Fri, 26 Sep 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891414; cv=none; b=PS6ELjCF9hEYMWQqcyONfLRhADFtMFSv+ruPOzBns+msGqR9qKYMJ/CTHYRQIAyiwSUkNR2S6hAwih/4wXLXCDenfdMxtud4Pjyow1CUAsHhhdnI+BK1Y9vSmrVx+tbP2P6QpeNv8pN1STovp5AZc+l8iMe/rDT4kvNjd8y394Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891414; c=relaxed/simple;
	bh=KVEkfKEqyJWR7C8PnNDPX9sWYgFWJeWgn44ONH+/BhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdEYAk8f1Nyuhrf0QWibUGUrglmVOtkcFNrDQ3LFCnn/8csz1CyxkU43M9MjNj2jUWU1gUOki2guUD9qaObZpPB7G5v6g83g0hCIN4WT7keqiCfYgj1AAWRq1TTy78LLGbSs6Wzw/9wNWkSHcRlqhhDgAwVELt2TOgf+QP55FLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf13dN7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55F9C4CEF4;
	Fri, 26 Sep 2025 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891413;
	bh=KVEkfKEqyJWR7C8PnNDPX9sWYgFWJeWgn44ONH+/BhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bf13dN7xbEM6/+shWxra64pVahDN+bRu1Y0TlZSNpChy7SA8P5j557LHyEPfapZWC
	 RzTjAmSLd2IJqEksbuK9g9tLbb1IeRAuQQJ+rzZkT5CZjQ/iBstmJAkMg3s+j4CAW6
	 SE9qBoXfdRwPtXn1GNWLstDuK633hmedpsVveW+NM4glh2Q9O0P3tyJl3g+vUI21Jw
	 zGJvTUoiCVclLVAHPUBgr3xQtBELjQHDFn0doGU9kT2yX/L78rCcJ0A+yzgMFSzjoc
	 kSGu4XrXQi8WHD4mmnYSipiXNOf1+sZpMdbLMGk+UPBgYfDlpGsJjEIUBQ1ivrL1sX
	 SG5D9gML9eBDg==
Date: Fri, 26 Sep 2025 14:56:39 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 5/8] man/man2/move_mount.2: document "new" mount API
Message-ID: <pvcrxgmtpfhx3lfdk5ydwuxffmv3avlsy4tagww2bxdb2ywx6s@iqe4y4mudjq6>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-5-028fb88023f2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="goolxarnnegz6rjd"
Content-Disposition: inline
In-Reply-To: <20250925-new-mount-api-v5-5-028fb88023f2@cyphar.com>


--goolxarnnegz6rjd
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
Subject: Re: [PATCH v5 5/8] man/man2/move_mount.2: document "new" mount API
Message-ID: <pvcrxgmtpfhx3lfdk5ydwuxffmv3avlsy4tagww2bxdb2ywx6s@iqe4y4mudjq6>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
 <20250925-new-mount-api-v5-5-028fb88023f2@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250925-new-mount-api-v5-5-028fb88023f2@cyphar.com>

Hi Aleksa,

On Thu, Sep 25, 2025 at 01:31:27AM +1000, Aleksa Sarai wrote:
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

Thanks!  I've applied this patch, with some minor amendments (see below).
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Deb37a3066ccce4f44ab69fae559016a524e4eac>

> ---
>  man/man2/move_mount.2 | 646 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 646 insertions(+)
>=20
> diff --git a/man/man2/move_mount.2 b/man/man2/move_mount.2
> new file mode 100644
> index 0000000000000000000000000000000000000000..f954f36c43c444afb167088cc=
665607dfeb10676
> --- /dev/null
> +++ b/man/man2/move_mount.2
> @@ -0,0 +1,646 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH move_mount 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +move_mount \- move or attach mount object to filesystem
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ,\~ \-lc )
> +.SH SYNOPSIS
> +.nf
> +.BR "#include <fcntl.h>" "          /* Definition of " AT_* " constants =
*/"
> +.B #include <sys/mount.h>
> +.P
> +.BI "int move_mount(int " from_dirfd ", const char *" from_path ,
> +.BI "               int " to_dirfd ", const char *" to_path ,
> +.BI "               unsigned int " flags );
> +.fi
> +.SH DESCRIPTION
> +The
> +.BR move_mount ()
> +system call is part of
> +the suite of file-descriptor-based mount facilities in Linux.
> +.P
> +.BR move_mount ()
> +moves the mount object indicated by
> +.I from_dirfd
> +and
> +.I from_path
> +to the path indicated by
> +.I to_dirfd
> +and
> +.IR to_path .
> +The mount object being moved
> +can be an existing mount point in the current mount namespace,
> +or a detached mount object created by
> +.BR fsmount (2)
> +or
> +.BR open_tree (2)
> +with
> +.BR \%OPEN_TREE_CLONE .
> +.P
> +To access the source mount object
> +or the destination mount point,
> +no permissions are required on the object itself,
> +but if either pathname is supplied,
> +execute (search) permission is required
> +on all of the directories specified in
> +.I from_path
> +or
> +.IR to_path .
> +.P
> +The calling process must have the
> +.B \%CAP_SYS_ADMIN
> +capability in order to move or attach a mount object.
> +.P
> +As with "*at()" system calls,
> +.BR move_mount ()
> +uses the
> +.I from_dirfd
> +and
> +.I to_dirfd
> +arguments
> +in conjunction with the
> +.I from_path
> +and
> +.I to_path
> +arguments to determine the source and destination objects to operate on
> +(respectively), as follows:
> +.IP \[bu] 3
> +If the pathname given in
> +.I *_path

In this case, where the non-variable part is already in italics, the
variable part is written in roman, for distinguishing it.  (See
groff_man(7).)


Have a lovely day!
Alex

> +is absolute, then
> +the corresponding
> +.I *_dirfd
> +is ignored.
> +.IP \[bu]
> +If the pathname given in
> +.I *_path
> +is relative and
> +the corresponding
> +.I *_dirfd
> +is the special value
> +.BR \%AT_FDCWD ,
> +then
> +.I *_path
> +is interpreted relative to
> +the current working directory
> +of the calling process (like
> +.BR open (2)).
> +.IP \[bu]
> +If the pathname given in
> +.I *_path
> +is relative,
> +then it is interpreted relative to
> +the directory referred to by
> +the corresponding file descriptor
> +.I *_dirfd
> +(rather than relative to
> +the current working directory
> +of the calling process,
> +as is done by
> +.BR open (2)
> +for a relative pathname).
> +In this case,
> +the corresponding
> +.I *_dirfd
> +must be a directory
> +that was opened for reading
> +.RB ( O_RDONLY )
> +or using the
> +.B O_PATH
> +flag.
> +.IP \[bu]
> +If
> +.I *_path
> +is an empty string,
> +and
> +.I flags
> +contains the appropriate
> +.BI \%MOVE_MOUNT_ * _EMPTY_PATH
> +flag,
> +then the corresponding file descriptor
> +.I *_dirfd
> +is operated on directly.
> +In this case,
> +the corresponding
> +.I *_dirfd
> +may refer to any type of file,
> +not just a directory.
> +.P
> +See
> +.BR openat (2)
> +for an explanation of why the
> +.I *_dirfd
> +arguments are useful.
> +.P
> +.I flags
> +can be used to control aspects of the path lookup
> +for both the source and destination objects,
> +as well as other properties of the mount operation.
> +A value for
> +.I flags
> +is constructed by bitwise ORing
> +zero or more of the following constants:
> +.RS
> +.TP
> +.B MOVE_MOUNT_F_EMPTY_PATH
> +If
> +.I from_path
> +is an empty string, operate on the file referred to by
> +.I from_dirfd
> +(which may have been obtained from
> +.BR open (2),
> +.BR fsmount (2),
> +or
> +.BR open_tree (2)).
> +In this case,
> +.I from_dirfd
> +may refer to any type of file,
> +not just a directory.
> +If
> +.I from_dirfd
> +is
> +.BR \%AT_FDCWD ,
> +.BR move_mount ()
> +will operate on the current working directory
> +of the calling process.
> +.IP
> +This is the most common mechanism
> +used to attach detached mount objects
> +produced by
> +.BR fsmount (2)
> +and
> +.BR open_tree (2)
> +to a mount point.
> +.TP
> +.B MOVE_MOUNT_T_EMPTY_PATH
> +As with
> +.BR \%MOVE_MOUNT_F_EMPTY_PATH ,
> +except operating on
> +.I to_dirfd
> +and
> +.IR to_path .
> +.TP
> +.B MOVE_MOUNT_F_SYMLINKS
> +If
> +.I from_path
> +references a symbolic link,
> +then dereference it.
> +The default behaviour for
> +.BR move_mount ()
> +is to
> +.I not follow
> +symbolic links.
> +.TP
> +.B MOVE_MOUNT_T_SYMLINKS
> +As with
> +.BR \%MOVE_MOUNT_F_SYMLINKS ,
> +except operating on
> +.I to_dirfd
> +and
> +.IR to_path .
> +.TP
> +.B MOVE_MOUNT_F_NO_AUTOMOUNT
> +Do not automount the terminal ("basename") component of
> +.I \%from_path
> +if it is a directory that is an automount point.
> +This allows a mount object
> +that has an automount point at its root
> +to be moved
> +and prevents unintended triggering of an automount point.
> +This flag has no effect
> +if the automount point has already been mounted over.
> +.TP
> +.B MOVE_MOUNT_T_NO_AUTOMOUNT
> +As with
> +.BR \%MOVE_MOUNT_F_NO_AUTOMOUNT ,
> +except operating on
> +.I to_dirfd
> +and
> +.IR to_path .
> +This allows an automount point to be manually mounted over.
> +.TP
> +.BR MOVE_MOUNT_SET_GROUP " (since Linux 5.15)"
> +Add the attached private-propagation mount object indicated by
> +.I to_dirfd
> +and
> +.I to_path
> +into the mount propagation "peer group"
> +of the attached non-private-propagation mount object indicated by
> +.I from_dirfd
> +and
> +.IR from_path .
> +.IP
> +Unlike other
> +.BR move_mount ()
> +operations,
> +this operation does not move or attach any mount objects.
> +Instead, it only updates the metadata
> +of attached mount objects.
> +(Also, take careful note of
> +the argument order\[em]\c
> +the mount object being modified
> +by this operation is the one specified by
> +.I to_dirfd
> +and
> +.IR to_path .)
> +.IP
> +This makes it possible to first create a mount tree
> +consisting only of private mounts
> +and then configure the desired propagation layout afterwards.
> +(See the "SHARED SUBTREES" section of
> +.BR mount_namespaces (7)
> +for more information about mount propagation and peer groups.)
> +.TP
> +.BR MOVE_MOUNT_BENEATH " (since Linux 6.5)"
> +If the path indicated by
> +.I to_dirfd
> +and
> +.I to_path
> +is an existing mount object,
> +rather than attaching or moving the mount object
> +indicated by
> +.I from_dirfd
> +and
> +.I from_path
> +on top of the mount stack,
> +attach or move it beneath the current top mount
> +on the mount stack.
> +.IP
> +After using
> +.BR \%MOVE_MOUNT_BENEATH ,
> +it is possible to
> +.BR umount (2)
> +the top mount
> +in order to reveal the mount object
> +which was attached beneath it earlier.
> +This allows for the seamless (and atomic) replacement
> +of intricate mount trees,
> +which can further be used
> +to "upgrade" a mount tree with a newer version.
> +.IP
> +This operation has several restrictions:
> +.RS
> +.IP \[bu] 3
> +Mount objects cannot be attached beneath the filesystem root,
> +including cases where
> +the filesystem root was configured by
> +.BR chroot (2)
> +or
> +.BR pivot_root (2).
> +To mount beneath the filesystem root,
> +.BR pivot_root (2)
> +must be used.
> +.IP \[bu]
> +The target path indicated by
> +.I to_dirfd
> +and
> +.I to_path
> +must not be a detached mount object,
> +such as those produced by
> +.BR open_tree (2)
> +with
> +.B \%OPEN_TREE_CLONE
> +or
> +.BR fsmount (2).
> +.IP \[bu]
> +The current top mount
> +of the target path's mount stack
> +and its parent mount
> +must be in the calling process's mount namespace.
> +.IP \[bu]
> +The caller must have sufficient privileges
> +to unmount the top mount
> +of the target path's mount stack,
> +to prove they have privileges
> +to reveal the underlying mount.
> +.IP \[bu]
> +Mount propagation events triggered by this
> +.BR move_mount ()
> +operation
> +(as described in
> +.BR mount_namespaces (7))
> +are calculated based on the parent mount
> +of the current top mount
> +of the target path's mount stack.
> +.IP \[bu]
> +The target path's mount
> +cannot be an ancestor in the mount tree of
> +the source mount object.
> +.IP \[bu]
> +The source mount object
> +must not have any overmounts,
> +otherwise it would be possible to create "shadow mounts"
> +(i.e., two mounts mounted on the same parent mount at the same mount poi=
nt).
> +.IP \[bu]
> +It is not possible to move a mount
> +beneath a top mount
> +if the parent mount
> +of the current top mount
> +propagates to the top mount itself.
> +Otherwise,
> +.B \%MOVE_MOUNT_BENEATH
> +would cause the mount object
> +to be propagated
> +to the top mount
> +from the parent mount,
> +defeating the purpose of using
> +.BR \%MOVE_MOUNT_BENEATH .
> +.IP \[bu]
> +It is not possible to move a mount
> +beneath a top mount
> +if the parent mount
> +of the current top mount
> +propagates to the mount object
> +being mounted beneath.
> +Otherwise, this would cause a similar propagation issue
> +to the previous point,
> +also defeating the purpose of using
> +.BR \%MOVE_MOUNT_BENEATH .
> +.RE
> +.RE
> +.P
> +If
> +.I from_dirfd
> +is a mount object file descriptor and
> +.BR move_mount ()
> +is operating on it directly,
> +.I from_dirfd
> +will remain associated with the mount object after
> +.BR move_mount ()
> +succeeds,
> +so you may repeatedly use
> +.I from_dirfd
> +with
> +.BR move_mount (2)
> +and/or "*at()" system calls
> +as many times as necessary.
> +.SH RETURN VALUE
> +On success,
> +.BR move_mount ()
> +returns 0.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EACCES
> +Search permission is denied
> +for one of the directories
> +in the path prefix of one of
> +.I from_path
> +or
> +.IR to_path .
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EBADF
> +One of
> +.I from_dirfd
> +or
> +.I to_dirfd
> +is not a valid file descriptor.
> +.TP
> +.B EFAULT
> +One of
> +.I from_path
> +or
> +.I to_path
> +is NULL
> +or a pointer to a location
> +outside the calling process's accessible address space.
> +.TP
> +.B EINVAL
> +Invalid flag specified in
> +.IR flags .
> +.TP
> +.B EINVAL
> +The path indicated by
> +.I from_dirfd
> +and
> +.I from_path
> +is not a mount object.
> +.TP
> +.B EINVAL
> +The mount object type
> +of the source mount object and target inode
> +are not compatible
> +(i.e., the source is a file but the target is a directory, or vice-versa=
).
> +.TP
> +.B EINVAL
> +The source mount object or target path
> +are not in the calling process's mount namespace
> +(or an anonymous mount namespace of the calling process).
> +.TP
> +.B EINVAL
> +The source mount object's parent mount
> +has shared mount propagation,
> +and thus cannot be moved
> +(as described in
> +.BR mount_namespaces (7)).
> +.TP
> +.B EINVAL
> +The source mount has
> +.B MS_UNBINDABLE
> +child mounts
> +but the target path
> +resides on a mount tree with shared mount propagation,
> +which would otherwise cause the unbindable mounts to be propagated
> +(as described in
> +.BR mount_namespaces (7)).
> +.TP
> +.B EINVAL
> +.B \%MOVE_MOUNT_BENEATH
> +was attempted,
> +but one of the listed restrictions was violated.
> +.TP
> +.B ELOOP
> +Too many symbolic links encountered
> +when resolving one of
> +.I from_path
> +or
> +.IR to_path .
> +.TP
> +.B ENAMETOOLONG
> +One of
> +.I from_path
> +or
> +.I to_path
> +is longer than
> +.BR PATH_MAX .
> +.TP
> +.B ENOENT
> +A component of one of
> +.I from_path
> +or
> +.I to_path
> +does not exist.
> +.TP
> +.B ENOENT
> +One of
> +.I from_path
> +or
> +.I to_path
> +is an empty string,
> +but the corresponding
> +.BI MOVE_MOUNT_ * _EMPTY_PATH
> +flag is not specified in
> +.IR flags .
> +.TP
> +.B ENOTDIR
> +A component of the path prefix of one of
> +.I from_path
> +or
> +.I to_path
> +is not a directory,
> +or one of
> +.I from_path
> +or
> +.I to_path
> +is relative
> +and the corresponding
> +.I from_dirfd
> +or
> +.I to_dirfd
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
> +.\" commit 2db154b3ea8e14b04fee23e3fdfd5e9d17fbc6ae
> +.\" commit 400913252d09f9cfb8cce33daee43167921fc343
> +glibc 2.36.
> +.SH EXAMPLES
> +.BR move_mount ()
> +can be used to move attached mounts like the following:
> +.P
> +.in +4n
> +.EX
> +move_mount(AT_FDCWD, "/a", AT_FDCWD, "/b", 0);
> +.EE
> +.in
> +.P
> +This would move the mount object mounted on
> +.I /a
> +to
> +.IR /b .
> +The above procedure is functionally equivalent to
> +the following mount operation
> +using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/a", "/b", NULL, MS_MOVE, NULL);
> +.EE
> +.in
> +.P
> +.BR move_mount ()
> +can also be used in conjunction with file descriptors returned from
> +.BR open_tree (2)
> +or
> +.BR open (2):
> +.P
> +.in +4n
> +.EX
> +int fd =3D open_tree(AT_FDCWD, "/mnt", 0); /* open("/mnt", O_PATH); */
> +move_mount(fd, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
> +move_mount(fd, "", AT_FDCWD, "/mnt3", MOVE_MOUNT_F_EMPTY_PATH);
> +move_mount(fd, "", AT_FDCWD, "/mnt4", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +This would move the mount object mounted at
> +.I /mnt
> +to
> +.IR /mnt2 ,
> +then
> +.IR /mnt3 ,
> +and then
> +.IR /mnt4 .
> +.P
> +If the source mount object
> +indicated by
> +.I from_dirfd
> +and
> +.I from_path
> +is a detached mount object,
> +.BR move_mount ()
> +can be used to attach it to a mount point:
> +.P
> +.in +4n
> +.EX
> +int fsfd, mntfd;
> +\&
> +fsfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
> +fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "/dev/sda1", 0);
> +fsconfig(fsfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
> +fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV);
> +move_mount(mntfd, "", AT_FDCWD, "/home", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +This would create a new filesystem configuration context for ext4,
> +configure it,
> +create a detached mount object,
> +and then attach it to
> +.IR /home .
> +The above procedure is functionally equivalent to
> +the following mount operation
> +using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/dev/sda1", "/home", "ext4", MS_NODEV, "user_xattr");
> +.EE
> +.in
> +.P
> +The same operation also works with detached bind-mounts created with
> +.BR open_tree (2)
> +with
> +.BR OPEN_TREE_CLONE :
> +.P
> +.in +4n
> +.EX
> +int mntfd =3D open_tree(AT_FDCWD, "/home/cyphar", OPEN_TREE_CLONE);
> +move_mount(mntfd, "", AT_FDCWD, "/root", MOVE_MOUNT_F_EMPTY_PATH);
> +.EE
> +.in
> +.P
> +This would create a new bind-mount of
> +.I /home/cyphar
> +as a detached mount object,
> +and then attach it to
> +.IR /root .
> +The above procedure is functionally equivalent to
> +the following mount operation
> +using
> +.BR mount (2):
> +.P
> +.in +4n
> +.EX
> +mount("/home/cyphar", "/root", NULL, MS_BIND, NULL);
> +.EE
> +.in
> +.SH SEE ALSO
> +.BR fsconfig (2),
> +.BR fsmount (2),
> +.BR fsopen (2),
> +.BR fspick (2),
> +.BR mount (2),
> +.BR mount_setattr (2),
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

--goolxarnnegz6rjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjWjYYACgkQ64mZXMKQ
wqkAjA/+LCm8H/SrKSDG5eFousYe/3cKemG4P+/ptbpg+QuSsrahvqQrYiXJabBe
bZRwP82Y76NKVPKMoVg0/r75ZAM7lgxJ8dQARwyWgD0XgJZ+fyadPWXbHtGNCK++
m5nL+ueYtxTRaVOYTLs6FYBqW/HJOooakmEydLh/Z8A+8/LurHHnWQyODTm/aiym
cdTUX+RDQ2S5Q3X0im7YpZz1uivS9jO28Gh1rnUXFPJxl8RFvhK/YuD/7L4+ivx0
y5YBsjOopm/wwDVK9IougxFnlOR413RQ7TLhZNiTjSj7eTcN1qyP4tO0mBAHSans
RhQMtJku3T85jmzaXM8Cj4rqR4jpKB18QIRvpKeGrxYE8Wz7uFewrCtrVfTNZoeE
od9htZyYisVeTgVqH981ob8SqjwVulVUlIa5Z3VHPR0JBXFt+NcHnL9dB8pA9KoM
c+kMWaqusBY2dsh21WwHhr9a2Revk8QwhQ4274d0aCxeQFtOfVmsGEgMkDvCHGX4
wMb3mf6Tt97MJQ2qRxGWgM25mvUd68ZrugiXw2UB0P6aIowHgw1HIio6heza8Cg/
2mVgAyU2UbGz3mlsJNNA2A+6TeIZYU0w5FE3R+YEfM2IW7PG4TiuxCxm/Z17HejZ
LN6ggSm556vniRPs8uzPnI+ZwCz7JRoY/V45g8bjZHWuspH6f6c=
=Ux1G
-----END PGP SIGNATURE-----

--goolxarnnegz6rjd--

