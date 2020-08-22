Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35E24E9A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 22:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHVUJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 16:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHVUJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:09:01 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A10C061573;
        Sat, 22 Aug 2020 13:09:00 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id e6so4686353oii.4;
        Sat, 22 Aug 2020 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=U7BuDIgtjv1Yd2BgOfS1AgYMQc48B2+MznfIZPlwVkE=;
        b=qplgUSzwptldIZ7T2JeRJVkPP2KSJ1nOIWP7pmjuxJX4pw62s9KH0MNs+xXFHHKHwx
         pBTxNZbsnTCJOPXmiLOqxBy1BKLLqYRWv5nSOCCmIHJGLRtwglyMjtAyHjz46OqfXD0y
         Lq38diUrWjKI5K8mXNtxpwEnvoCD7YEEgr1bQYcoSnaR1MGRtG7M5YSBFOTLfaQt2U5v
         yfh9fR9EYNLa/scT/Wqyb2bXiJwAx0mNLxVXqRQnvKUXW1+RWMbUHGu9yJMFbYZUz00E
         YCHkAkvYlVPzpGCp2crc2ttIldlAxhZqqCSrBvK6hkmRvHwp0jy8Yr+nhRZZh85nj+y5
         LIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=U7BuDIgtjv1Yd2BgOfS1AgYMQc48B2+MznfIZPlwVkE=;
        b=ZXe5zjSEsL6VPV87PPOz16n5ICEB8c1nJc1eGjLm2wMza8AjgjGkTtalI+KwyE3wbT
         altac5C6l/NJOrUppCk73ATY7pBdw5Vk+g7mIF+51cA50k9erTCTq3+wNvN6gtL2X961
         3hvAzijOQrWqdiNu9pXuU3ixmPX7iGmWxizGy8ZROeDe8e3+Rp2aKHyxBas/7+P6M56L
         EFodFVmF7QtT19j+d1ycpCh9b1YtibPXRXg6v9E3GnQEAlvp0agW8JBMsWDt3xXupFAj
         9l14dXjQfMI/mb9SSv9x5Q8bD05MVLf43fjSW/xtPtyYjO1oBN274LSjkGgkKxs+5WbW
         vCEg==
X-Gm-Message-State: AOAM531QW8446SiQnO89ypyY5tIwqsBRd9oHZgwMEYW7d93JiAHVU0eP
        fesfduOv44oZaEFqV1pyM/Sog6OUUtf91aQapvk=
X-Google-Smtp-Source: ABdhPJzwK7zi9EiRpIjL/mOz384MIEXw40UiAt8UDZKBfmH83uD0e1fvCgTF2GBAC/manU6cnvDG4c5IFqm2az1sphM=
X-Received: by 2002:aca:cd56:: with SMTP id d83mr5764388oig.177.1598126939764;
 Sat, 22 Aug 2020 13:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
 <159680896399.29015.5715495435254941002.stgit@warthog.procyon.org.uk>
In-Reply-To: <159680896399.29015.5715495435254941002.stgit@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sat, 22 Aug 2020 22:08:48 +0200
Message-ID: <CAKgNAkhBQsP0GJ6g0Z7jpXgMUSDCdmfDAcBH=pO8NuhcYQU=Zg@mail.gmail.com>
Subject: Re: [PATCH 4/5] Add manpage for fsopen(2) and fsmount(2)
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Fri, 7 Aug 2020 at 16:03, David Howells <dhowells@redhat.com> wrote:
>
> Add a manual page to document the fsopen() and fsmount() system calls.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  man2/fsmount.2 |    1
>  man2/fsopen.2  |  254 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 255 insertions(+)
>  create mode 100644 man2/fsmount.2
>  create mode 100644 man2/fsopen.2
>
> diff --git a/man2/fsmount.2 b/man2/fsmount.2
> new file mode 100644
> index 000000000..2bf59fc3e
> --- /dev/null
> +++ b/man2/fsmount.2
> @@ -0,0 +1 @@
> +.so man2/fsopen.2
> diff --git a/man2/fsopen.2 b/man2/fsopen.2
> new file mode 100644
> index 000000000..b36ea1609
> --- /dev/null
> +++ b/man2/fsopen.2
> @@ -0,0 +1,254 @@
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
> +.TH FSOPEN 2 2020-08-07 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +fsopen, fsmount \- Filesystem parameterisation and mount creation
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.br
> +.B #include <sys/mount.h>
> +.br

Remove all instances of ".br" here in the SYNOPSIS. They aren't needed
(because of the .nf above).

> +.B #include <unistd.h>
> +.br
> +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> +.PP
> +.BI "int fsopen(const char *" fsname ", unsigned int " flags );
> +.PP
> +.BI "int fsmount(int " fd ", unsigned int " flags ", unsigned int " mount_attrs );
> +.fi
> +.PP
> +.IR Note :
> +There are no glibc wrappers for these system calls.
> +.SH DESCRIPTION
> +.PP
> +.BR fsopen ()
> +creates a blank filesystem configuration context within the kernel for the
> +filesystem named in the
> +.I fsname
> +parameter, puts it into creation mode and attaches it to a file descriptor,
> +which it then returns.  The file descriptor can be marked close-on-exec by
> +setting
> +.B FSOPEN_CLOEXEC
> +in
> +.IR flags .
> +.PP
> +After calling fsopen(), the file descriptor should be passed to the
> +.BR fsconfig (2)
> +system call, using that to specify the desired filesystem and security
> +parameters.
> +.PP
> +When the parameters are all set, the
> +.BR fsconfig ()
> +system call should then be called again with
> +.B FSCONFIG_CMD_CREATE
> +as the command argument to effect the creation.
> +.RS
> +.PP
> +.BR "[!]\ NOTE" :
> +Depending on the filesystem type and parameters, this may rather share an
> +existing in-kernel filesystem representation instead of creating a new one.
> +In such a case, the parameters specified may be discarded or may overwrite the
> +parameters set by a previous mount - at the filesystem's discretion.
> +.RE
> +.PP
> +The file descriptor also serves as a channel by which more comprehensive error,
> +warning and information messages may be retrieved from the kernel using
> +.BR read (2).
> +

Delete blank line above.

> +.PP
> +Once the creation command has been successfully run on a context, the context
> +is switched into need-mount mode which prevents further configuration.  At
> +this point,
> +.BR fsmount ()
> +should be called to create a mount object.
> +.PP
> +.BR fsmount ()
> +takes the file descriptor returned by
> +.BR fsopen ()
> +and creates a mount object for the filesystem root specified there.  The
> +attributes of the mount object are set from the
> +.I mount_attrs
> +parameter.  The attributes specify the propagation and mount restrictions to
> +be applied to accesses through this mount.
> +.PP
> +The mount object is then attached to a new file descriptor that looks like one
> +created by
> +.BR open "(2) with " O_PATH " or " open_tree (2).
> +This can be passed to
> +.BR move_mount (2)
> +to attach the mount object to a mountpoint, thereby completing the process.
> +.PP
> +The file descriptor returned by fsmount() is marked close-on-exec if
> +FSMOUNT_CLOEXEC is specified in
> +.IR flags .
> +.PP
> +After fsmount() has completed, the context created by fsopen() is reset and
> +moved to reconfiguration state, allowing the new superblock to be
> +reconfigured.  See
> +.BR fspick (2)
> +for details.
> +.PP
> +
> +.\"________________________________________________________

Delete preceding THREE lines.

> +.SS Message Retrieval Interface
> +The context file descriptor may be queried for message strings at any time by
> +calling
> +.BR read (2)
> +on the file descriptor.  This will return formatted messages that are prefixed
> +to indicate their class:
> +.TP
> +\fB"e <message>"\fP
> +An error message string was logged.
> +.TP
> +\fB"i <message>"\fP
> +An informational message string was logged.
> +.TP
> +\fB"w <message>"\fP
> +An warning message string was logged.
> +.PP
> +Messages are removed from the queue as they're read.
> +
> +.\"________________________________________________________

Delete preceding two lines.

> +.SH EXAMPLES

Please place the EXAMPLES section just above SEE ALSO

> +To illustrate the process, here's an example whereby this can be used to mount
> +an ext4 filesystem on /dev/sdb1 onto /mnt.
> +.PP
> +.in +4n
> +.nf
> +sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "source", "/dev/sdb1", 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "noatime", NULL, 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "user_attr", NULL, 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "iversion", NULL, 0);
> +fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MS_RELATIME);
> +move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

As pointed out by Karel in
https://lore.kernel.org/lkml/20191126105309.m4k2zpxgxq7tacy2@10.255.255.10/
there are too many arguments in the above call.

> +.fi
> +.in
> +.PP
> +Here, an ext4 context is created first and attached to sfd.  This is then told

PLease replace "this" with a noun (phrase).

> +where its source will be, given a bunch of options and created.  Then
> +fsmount() is called to create a mount object and
> +.BR move_mount (2)
> +is called to attach it to its intended mountpoint.
> +.PP
> +And here's an example of mounting from an NFS server and setting a Smack
> +security module label on it too:
> +.PP
> +.in +4n
> +.nf
> +sfd = fsopen("nfs", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "source", "example.com:/pub", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "nfsvers", "3", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "rsize", "65536", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "wsize", "65536", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "smackfsdef", "foolabel", 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "rdma", NULL, 0);
> +fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mfd = fsmount(sfd, 0, MS_NODEV);
> +move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

As pointed out by Karel in
https://lore.kernel.org/lkml/20191126105309.m4k2zpxgxq7tacy2@10.255.255.10/
there are too many arguments in the above call.

> +.fi
> +.in
> +.PP
> +
> +

Please remove blank lines.

> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Please delete the above three lines.

> +.SH RETURN VALUE
> +On success, both functions return a file descriptor.  On error, \-1 is
> +returned, and
> +.I errno
> +is set appropriately.
> +.SH ERRORS
> +The error values given below result from filesystem type independent
> +errors.
> +Each filesystem type may have its own special errors and its
> +own special behavior.
> +See the Linux kernel source code for details.
> +.TP
> +.B EBUSY
> +The context referred to by
> +.I fd
> +is not in the right state to be used by
> +.BR fsmount ().
> +.TP
> +.B EFAULT
> +One of the pointer arguments points outside the user address space.
> +.TP
> +.B EINVAL
> +.I flags
> +had an invalid flag set.
> +.TP
> +.B EINVAL
> +.I mount_attrs,
> +includes invalid
> +.BR MOUNT_ATTR_*
> +flags.
> +.TP
> +.B EMFILE
> +The system has too many open files to create more.
> +.TP
> +.B ENFILE
> +The process has too many open files to create more.
> +.TP
> +.B ENODEV
> +Filesystem

s/Filesystem/The filesystem/

> +.I fsname
> +not configured in the kernel.
> +.TP
> +.B ENOMEM
> +The kernel could not allocate sufficient memory to complete the call.
> +.TP
> +.B EPERM
> +The caller does not have the required privileges.

Please name the required capability.

> +.SH CONFORMING TO
> +These functions are Linux-specific and should not be used in programs intended
> +to be portable.
> +.SH VERSIONS
> +.BR fsopen "(), and " fsmount ()
> +were added to Linux in kernel 5.1.

5.2.


> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR fsopen "() or " fsmount "()"
> +system calls; call them using
> +.BR syscall (2).
> +.SH SEE ALSO
> +.BR mountpoint (1),
> +.BR fsconfig (2),
> +.BR fspick (2),
> +.BR move_mount (2),
> +.BR open_tree (2),
> +.BR umount (2),
> +.BR mount_namespaces (7),
> +.BR path_resolution (7),
> +.BR findmnt (8),
> +.BR lsblk (8),
> +.BR mount (8),
> +.BR umount (8)

Thanks,

Michael

--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
