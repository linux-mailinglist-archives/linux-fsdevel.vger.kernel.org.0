Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECB12FFE67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 09:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhAVIla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 03:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbhAVIku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:40:50 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52DEC06174A;
        Fri, 22 Jan 2021 00:40:09 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id w124so5231705oia.6;
        Fri, 22 Jan 2021 00:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jJv15jov4wFR4m4gKoBMWIBvF9mMPYKTcR8B+JsPFEk=;
        b=mgaJb18Hd6/OV0Ph6wcDG3pRtOBBIoDv/HgMzpsRGbrrPyfXpVzJXV0gthgVtkBG2R
         D8djX4cJlzQBWIKghPVFYo8aGw/bI0KnH6mkpso0vHVhP/viU1EPd2PpcKDRjl91ePP9
         E8pXVJec1aKK56Jx1C4TN3wG4YDwpd0e/ehojihkjwyEywPTwl35eke1GgDVrpYJVQ9V
         ABykcff9e0DsPsX8urxvti6WaNt0SuYw0UfYnaMYX3xBNeXzKVFDoT0ImX8V196GDMep
         z+XRLIQFi+XZpzPnIHWvoepytx+61h+Ua2VVLxDGKf7em5FXqCQatrGI7NhjueRY6vcD
         0qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jJv15jov4wFR4m4gKoBMWIBvF9mMPYKTcR8B+JsPFEk=;
        b=bWLkuH7uuxXthQrrTYf84fDbmNeIEdp6VyWKBu8dwKfy10XxbfJUYluyRjaEbJRxaB
         16aPCDtM2ompJTBls0tmOYlZe0E7pdZJTAyhrF2gY/4uRx7AjR2o3a2vSb1jK2P1dKz2
         7QULzO3NSj0njCaKSNiH5iUluJggGobnY+caCQtThiE5Tn0hAhj+/wJx7hLu+fG1VpH2
         nmZ5l+mfJPt3FEt4Mi4in1dbel+bJfAS/l9aj+5nsw1TLQ5hIB7/XNwsTDrHaA197wuj
         BzyRH2caIMRUWcUbA/vKpYaBAwUAGUqnW3BdmlCLtbAY1MJTVCwM7BXdDdP3YwVpnFBi
         B0vQ==
X-Gm-Message-State: AOAM533oOA63LlEu9okXJqpqzO8W8vIJfVfEO74s5SdlWL0KYh8SkZT4
        4GmbNrmfq0gIJuHIu+5Be89cPJ5gyAr9PkXUOBc=
X-Google-Smtp-Source: ABdhPJw4ZupYTs5m7mJVKBu/HhFd1moUNTmjkWaCSC8CXAvtm9zUaRuX20lXG0nR5ghh3YuwVPz+dWHBfPAUVuK9Efg=
X-Received: by 2002:aca:fd81:: with SMTP id b123mr2541845oii.159.1611304809035;
 Fri, 22 Jan 2021 00:40:09 -0800 (PST)
MIME-Version: 1.0
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827189025.306468.4916341547843731338.stgit@warthog.procyon.org.uk>
In-Reply-To: <159827189025.306468.4916341547843731338.stgit@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 22 Jan 2021 09:39:57 +0100
Message-ID: <CAKgNAkgjaDXeWmoWcfzcqXVTohFt6MU_cr92nFdKo7t0t_dy9g@mail.gmail.com>
Subject: Re: [PATCH 2/5] Add manpages for move_mount(2)
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

Ping!

Thanks,

Michael


On Mon, 24 Aug 2020 at 14:24, David Howells <dhowells@redhat.com> wrote:
>
> Add manual pages to document the move_mount() system call.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  man2/move_mount.2 |  267 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 267 insertions(+)
>  create mode 100644 man2/move_mount.2
>
> diff --git a/man2/move_mount.2 b/man2/move_mount.2
> new file mode 100644
> index 000000000..2ceb775d9
> --- /dev/null
> +++ b/man2/move_mount.2
> @@ -0,0 +1,267 @@
> +'\" t
> +.\" Copyright (c) 2020 David Howells <dhowells@redhat.com>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.TH MOVE_MOUNT 2 2020-08-24 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +move_mount \- Move mount objects around the filesystem topology
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.B #include <sys/mount.h>
> +.B #include <unistd.h>
> +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> +.PP
> +.BI "int move_mount(int " from_dirfd ", const char *" from_pathname ","
> +.BI "               int " to_dirfd ", const char *" to_pathname ","
> +.BI "               unsigned int " flags );
> +.fi
> +.PP
> +.IR Note :
> +There is no glibc wrapper for this system call.
> +.SH DESCRIPTION
> +The
> +.BR move_mount ()
> +call moves a mount from one place to another; it can also be used to attach an
> +unattached mount that was created by
> +.BR fsmount "() or " open_tree "() with " OPEN_TREE_CLONE .
> +.PP
> +If
> +.BR move_mount ()
> +is called repeatedly with a file descriptor that refers to a mount object,
> +then the object will be attached/moved the first time and then moved
> +repeatedly, detaching it from the previous mountpoint each time.
> +.PP
> +To access the source mount object or the destination mountpoint, no
> +permissions are required on the object itself, but if either pathname is
> +supplied, execute (search) permission is required on all of the directories
> +specified in
> +.IR from_pathname " or " to_pathname .
> +.PP
> +The caller does, however, require the appropriate privilege (Linux: the
> +.B CAP_SYS_ADMIN
> +capability) to move or attach mounts.
> +.PP
> +.BR move_mount ()
> +uses
> +.IR from_pathname ", " from_dirfd " and part of " flags
> +to locate the mount object to be moved and
> +.IR to_pathname ", " to_dirfd " and another part of " flags
> +to locate the destination mountpoint.  Each lookup can be done in one of a
> +variety of ways:
> +.TP
> +[*] By absolute path.
> +The pathname points to an absolute path and the dirfd is ignored.  The file is
> +looked up by name, starting from the root of the filesystem as seen by the
> +calling process.
> +.TP
> +[*] By cwd-relative path.
> +The pathname points to a relative path and the dirfd is
> +.IR AT_FDCWD .
> +The file is looked up by name, starting from the current working directory.
> +.TP
> +[*] By dir-relative path.
> +The pathname points to relative path and the dirfd indicates a file descriptor
> +pointing to a directory.  The file is looked up by name, starting from the
> +directory specified by
> +.IR dirfd .
> +.TP
> +[*] By file descriptor.  The pathname is an empty string (""), the dirfd
> +points directly to the mount object to move or the destination mount point and
> +the appropriate
> +.B *_EMPTY_PATH
> +flag is set.
> +.PP
> +.I flags
> +can be used to influence a path-based lookup.  The value for
> +.I flags
> +is constructed by OR'ing together zero or more of the following constants:
> +.TP
> +.BR MOVE_MOUNT_F_EMPTY_PATH
> +.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
> +If
> +.I from_pathname
> +is an empty string, operate on the file referred to by
> +.IR from_dirfd
> +(which may have been obtained using the
> +.BR open (2)
> +.B O_PATH
> +flag or
> +.BR open_tree ())
> +If
> +.I from_dirfd
> +is
> +.BR AT_FDCWD ,
> +the call operates on the current working directory.
> +In this case,
> +.I from_dirfd
> +can refer to any type of file, not just a directory.
> +This flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
> +.TP
> +.B MOVE_MOUNT_T_EMPTY_PATH
> +As above, but operating on
> +.IR to_pathname " and " to_dirfd .
> +.TP
> +.B MOVE_MOUNT_F_AUTOMOUNTS
> +Don't automount the terminal ("basename") component of
> +.I from_pathname
> +if it is a directory that is an automount point.  This allows a mount object
> +that has an automount point at its root to be moved and prevents unintended
> +triggering of an automount point.
> +The
> +.B MOVE_MOUNT_F_AUTOMOUNTS
> +flag has no effect if the automount point has already been mounted over.  This
> +flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
> +.TP
> +.B MOVE_MOUNT_T_AUTOMOUNTS
> +As above, but operating on
> +.IR to_pathname " and " to_dirfd .
> +This allows an automount point to be manually mounted over.
> +.TP
> +.B MOVE_MOUNT_F_SYMLINKS
> +If
> +.I from_pathname
> +is a symbolic link, then dereference it.  The default for
> +.BR move_mount ()
> +is to not follow symlinks.
> +.TP
> +.B MOVE_MOUNT_T_SYMLINKS
> +As above, but operating on
> +.IR to_pathname " and " to_dirfd .
> +.SH RETURN VALUE
> +On success, 0 is returned.  On error, \-1 is returned, and
> +.I errno
> +is set appropriately.
> +.SH ERRORS
> +.TP
> +.B EACCES
> +Search permission is denied for one of the directories
> +in the path prefix of
> +.IR pathname .
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EBADF
> +.IR from_dirfd " or " to_dirfd
> +is not a valid open file descriptor.
> +.TP
> +.B EFAULT
> +.IR from_pathname " or " to_pathname
> +is NULL or either one point to a location outside the process's accessible
> +address space.
> +.TP
> +.B EINVAL
> +Reserved flag specified in
> +.IR flags .
> +.TP
> +.B ELOOP
> +Too many symbolic links encountered while traversing the pathname.
> +.TP
> +.B ENAMETOOLONG
> +.IR from_pathname " or " to_pathname
> +is too long.
> +.TP
> +.B ENOENT
> +A component of
> +.IR from_pathname " or " to_pathname
> +does not exist, or one is an empty string and the appropriate
> +.B *_EMPTY_PATH
> +was not specified in
> +.IR flags .
> +.TP
> +.B ENOMEM
> +Out of memory (i.e., kernel memory).
> +.TP
> +.B ENOTDIR
> +A component of the path prefix of
> +.IR from_pathname " or " to_pathname
> +is not a directory or one or the other is relative and the appropriate
> +.I *_dirfd
> +is a file descriptor referring to a file other than a directory.
> +.SH VERSIONS
> +.BR move_mount ()
> +was added to Linux in kernel 5.2.
> +.SH CONFORMING TO
> +.BR move_mount ()
> +is Linux-specific.
> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR move_mount ()
> +system call; call it using
> +.BR syscall (2).
> +.SH EXAMPLES
> +The
> +.BR move_mount ()
> +function can be used like the following:
> +.PP
> +.RS
> +.nf
> +move_mount(AT_FDCWD, "/a", AT_FDCWD, "/b", 0);
> +.fi
> +.RE
> +.PP
> +This would move the object mounted on "/a" to "/b".  It can also be used in
> +conjunction with
> +.BR open_tree "(2) or " open "(2) with " O_PATH :
> +.PP
> +.RS
> +.nf
> +fd = open_tree(AT_FDCWD, "/mnt", 0);
> +move_mount(fd, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
> +move_mount(fd, "", AT_FDCWD, "/mnt3", MOVE_MOUNT_F_EMPTY_PATH);
> +move_mount(fd, "", AT_FDCWD, "/mnt4", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.RE
> +.PP
> +This would attach the path point for "/mnt" to fd, then it would move the
> +mount to "/mnt2", then move it to "/mnt3" and finally to "/mnt4".
> +.PP
> +It can also be used to attach new mounts:
> +.PP
> +.RS
> +.nf
> +sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "source", "/dev/sda1", 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "user_xattr", NULL, 0);
> +fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV);
> +move_mount(mfd, "", AT_FDCWD, "/home", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.RE
> +.PP
> +Which would open the Ext4 filesystem mounted on "/dev/sda1", turn on user
> +extended attribute support and create a mount object for it.  Finally, the new
> +mount object would be attached with
> +.BR move_mount ()
> +to "/home".
> +.SH SEE ALSO
> +.BR fsmount (2),
> +.BR fsopen (2),
> +.BR open_tree (2)
>
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
