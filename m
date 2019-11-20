Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7528E1035CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 09:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKTIGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 03:06:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40710 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKTIGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:06:31 -0500
Received: by mail-oi1-f195.google.com with SMTP id d22so14748578oic.7;
        Wed, 20 Nov 2019 00:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NHx35a0P8qkljAm5udvepYVHqZ/Vt2w27fHlzYjGi2w=;
        b=BrDw6yK0T0Ob/E5KOmmLFxCluxzA+Yo/uWdzGO8KAff3P2mAlfyvNm34ReqXa5cn4e
         hzzYDG1QoneY/7tCkk2TvjoSveDxLxZjbmb385r4FNZ1FlCRFX/B6F37Fwfa8PUU9Xc2
         H9udFzRd0CoX9udo1AY1xVgrr6HJG85qwKl2eO1nQCHD+2SZP0gEckCK0M6tzRbJUDtl
         ssGENyAG6XHlTqGjbIyofJR6hmKZU5N9DA2Q23qoZ7bsQyh1Hu1QlyytnFcyUSAhJJib
         l0LNAiiHOfMoPBO2SCsUIiEpV1NZT8tI5a6aXIR3L37UqqnZzd/B618pdBNMnu1VSe02
         yEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NHx35a0P8qkljAm5udvepYVHqZ/Vt2w27fHlzYjGi2w=;
        b=tR5g4RFHHFFEx1gxXX76krJ/jatH9N1dDlE1MVvCxemTMZJrVTOwjH4i/3phzAvt6D
         btJ67hYsUQBQDpDz9NBrKaqGYVzZ8D/eKDUs5cJd3GMRpyhiba38rrvIh4ztV56IYz/3
         YOkHlDEgRaNUxTUnNkTWPfJwpz7yAePo5Z/CrzoKCqkrEnXr6pD4Q0lwvBqxrlD6JetC
         wwmkUyP2AhFQNb6ZYfDAJNkd8kbKecI/DuYjDeMu439932SfJg1HIWeRSIyeNSpIf9Ui
         C+bHEPjDd9kz/qVaRUc3mZYQVKW6P5sgcWw9VXZol/9MmHehNTgdUovJimrcBqXDnBF4
         iOGw==
X-Gm-Message-State: APjAAAUeWHPlY6VzW23wiTJUcuFXsbIJYqjhjrBN9VCUHLJyPPFjzPg8
        HC6Hcai8mWkVs1NwTYRq5xgVpliQtIwulwvVFhc=
X-Google-Smtp-Source: APXvYqzZbaUDEmTObrnMshkuzjQeZkeGHrH3trfShTz+SF+ze1HLbCRn7UbCymMVEmgP/Z63mQJGxQEthi2RzQjYckw=
X-Received: by 2002:aca:ed85:: with SMTP id l127mr1676909oih.75.1574237189813;
 Wed, 20 Nov 2019 00:06:29 -0800 (PST)
MIME-Version: 1.0
References: <10805.1570726908@warthog.procyon.org.uk>
In-Reply-To: <10805.1570726908@warthog.procyon.org.uk>
From:   Zorro Lang <zorro.lang@gmail.com>
Date:   Wed, 20 Nov 2019 16:06:17 +0800
Message-ID: <CADVQ27qqh=iowaD3K65==7qJWvEXyvePTu+4+HsSDkotMkrHqg@mail.gmail.com>
Subject: Re: [MANPAGE] fsopen.2, fsmount.2
To:     David Howells <dhowells@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:03=E5=86=99=E9=81=93=EF=BC=9A
>
> '\" t
> .\" Copyright (c) 2019 David Howells <dhowells@redhat.com>
> .\"
> .\" %%%LICENSE_START(VERBATIM)
> .\" Permission is granted to make and distribute verbatim copies of this
> .\" manual provided the copyright notice and this permission notice are
> .\" preserved on all copies.
> .\"
> .\" Permission is granted to copy and distribute modified versions of thi=
s
> .\" manual under the conditions for verbatim copying, provided that the
> .\" entire resulting derived work is distributed under the terms of a
> .\" permission notice identical to this one.
> .\"
> .\" Since the Linux kernel and libraries are constantly changing, this
> .\" manual page may be incorrect or out-of-date.  The author(s) assume no
> .\" responsibility for errors or omissions, or for damages resulting from
> .\" the use of the information contained herein.  The author(s) may not
> .\" have taken the same level of care in the production of this manual,
> .\" which is licensed free of charge, as they might when working
> .\" professionally.
> .\"
> .\" Formatted or processed versions of this manual, if unaccompanied by
> .\" the source, must acknowledge the copyright and authors of this work.
> .\" %%%LICENSE_END
> .\"
> .TH FSOPEN 2 2019-10-10 "Linux" "Linux Programmer's Manual"
> .SH NAME
> fsopen, fsmount \- Filesystem parameterisation and mount creation
> .SH SYNOPSIS
> .nf
> .B #include <sys/types.h>
> .br
> .B #include <sys/mount.h>
> .br
> .B #include <unistd.h>
> .br
> .BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> .br
> .BR "#include <sys/mount.h>       "
> .PP
> .BI "int fsopen(const char *" fsname ", unsigned int " flags );
> .PP
> .BI "int fsmount(int " fd ", unsigned int " flags ", unsigned int " mount=
_attrs );
> .fi
> .PP
> .IR Note :
> There are no glibc wrappers for these system calls.
> .SH DESCRIPTION
> .PP
> .BR fsopen ()
> creates a blank filesystem configuration context within the kernel for th=
e
> filesystem named in the
> .I fsname
> parameter, puts it into creation mode and attaches it to a file descripto=
r,
> which it then returns.  The file descriptor can be marked close-on-exec b=
y
> setting
> .B FSOPEN_CLOEXEC
> in
> .IR flags .
> .PP
> After calling fsopen(), the file descriptor should be passed to the
> .BR fsconfig (2)
> system call, using that to specify the desired filesystem and security
> parameters.
> .PP
> When the parameters are all set, the
> .BR fsconfig ()
> system call should then be called again with
> .B FSCONFIG_CMD_CREATE
> as the command argument to effect the creation.
> .RS
> .PP
> .BR "[!]\ NOTE" :
> Depending on the filesystem type and parameters, this may rather share an
> existing in-kernel filesystem representation instead of creating a new on=
e.
> In such a case, the parameters specified may be discarded or may overwrit=
e the
> parameters set by a previous mount - at the filesystem's discretion.
> .RE
> .PP
> The file descriptor also serves as a channel by which more comprehensive =
error,
> warning and information messages may be retrieved from the kernel using
> .BR read (2).
>
> .PP
> Once the creation command has been successfully run on a context, the con=
text
> is switched into need-mount mode which prevents further configuration.  A=
t
> this point,
> .BR fsmount ()
> should be called to create a mount object.
> .PP
> .BR fsmount ()
> takes the file descriptor returned by
> .BR fsopen ()
> and creates a mount object for the filesystem root specified there.  The
> attributes of the mount object are set from the
> .I mount_attrs
> parameter.  The attributes specify the propagation and mount restrictions=
 to
> be applied to accesses through this mount.
> .PP
> The mount object is then attached to a new file descriptor that looks lik=
e one
> created by
> .BR open "(2) with " O_PATH " or " open_tree (2).
> This can be passed to
> .BR move_mount (2)
> to attach the mount object to a mountpoint, thereby completing the proces=
s.
> .PP
> The file descriptor returned by fsmount() is marked close-on-exec if
> FSMOUNT_CLOEXEC is specified in
> .IR flags .
> .PP
> After fsmount() has completed, the context created by fsopen() is reset a=
nd
> moved to reconfiguration state, allowing the new superblock to be
> reconfigured.  See
> .BR fspick (2)
> for details.
> .PP
>
> .\"________________________________________________________
> .SS Message Retrieval Interface
> The context file descriptor may be queried for message strings at any tim=
e by
> calling
> .BR read (2)
> on the file descriptor.  This will return formatted messages that are pre=
fixed
> to indicate their class:
> .TP
> \fB"e <message>"\fP
> An error message string was logged.
> .TP
> \fB"i <message>"\fP
> An informational message string was logged.
> .TP
> \fB"w <message>"\fP
> An warning message string was logged.
> .PP
> Messages are removed from the queue as they're read.
>
> .\"________________________________________________________
> .SH EXAMPLES
> To illustrate the process, here's an example whereby this can be used to =
mount
> an ext4 filesystem on /dev/sdb1 onto /mnt.
> .PP
> .in +4n
> .nf
> sfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> fsconfig(sfd, FSCONFIG_SET_STRING, "source", "/dev/sdb1", 0);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "noatime", NULL, 0);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "user_attr", NULL, 0);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "iversion", NULL, 0);
> fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> mfd =3D fsmount(sfd, FSMOUNT_CLOEXEC, MS_RELATIME);

Hi David,

I tried to mount a XFS by "mfd =3D fsmount(sfd, FSMOUNT_CLOEXEC,
MS_RELATIME);", but it returned EINVAL.
The MS_RELATIME is defined as "(1<<21)" in my
/usr/include/linux/mount.h, but I found that the fsmount syscall has:

        if (attr_flags & ~(MOUNT_ATTR_RDONLY |
                           MOUNT_ATTR_NOSUID |
                           MOUNT_ATTR_NODEV |
                           MOUNT_ATTR_NOEXEC |
                           MOUNT_ATTR__ATIME |
                           MOUNT_ATTR_NODIRATIME))
                return -EINVAL;

And:
        case MOUNT_ATTR_RELATIME:
                mnt_flags |=3D MNT_RELATIME;

The MOUNT_ATTR_RELATIME is defined as 0. I changed the MS_RELATIME to
0 in my test code, then fsmount test passed.

Should we keep using MS_* things, or use MOUNT_ATTR_* things for new mount =
API?

Thanks,
Zorro


> move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> .fi
> .in
> .PP
> Here, an ext4 context is created first and attached to sfd.  This is then=
 told
> where its source will be, given a bunch of options and created.  Then
> fsmount() is called to create a mount object and
> .BR move_mount (2)
> is called to attach it to its intended mountpoint.
> .PP
> And here's an example of mounting from an NFS server and setting a Smack
> security module label on it too:
> .PP
> .in +4n
> .nf
> sfd =3D fsopen("nfs", 0);
> fsconfig(sfd, FSCONFIG_SET_STRING, "source", "example.com/pub/linux", 0);
> fsconfig(sfd, FSCONFIG_SET_STRING, "nfsvers", "3", 0);
> fsconfig(sfd, FSCONFIG_SET_STRING, "rsize", "65536", 0);
> fsconfig(sfd, FSCONFIG_SET_STRING, "wsize", "65536", 0);
> fsconfig(sfd, FSCONFIG_SET_STRING, "smackfsdef", "foolabel", 0);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "rdma", NULL, 0);
> fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> mfd =3D fsmount(sfd, 0, MS_NODEV);
> move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> .fi
> .in
> .PP
>
>
> .\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""=
""""""
> .\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""=
""""""
> .\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""=
""""""
> .SH RETURN VALUE
> On success, both functions return a file descriptor.  On error, \-1 is
> returned, and
> .I errno
> is set appropriately.
> .SH ERRORS
> The error values given below result from filesystem type independent
> errors.
> Each filesystem type may have its own special errors and its
> own special behavior.
> See the Linux kernel source code for details.
> .TP
> .B EBUSY
> The context referred to by
> .I fd
> is not in the right state to be used by
> .BR fsmount ().
> .TP
> .B EFAULT
> One of the pointer arguments points outside the user address space.
> .TP
> .B EINVAL
> .I flags
> had an invalid flag set.
> .TP
> .B EINVAL
> .I mount_attrs,
> includes invalid
> .BR MOUNT_ATTR_*
> flags.
> .TP
> .B EMFILE
> The system has too many open files to create more.
> .TP
> .B ENFILE
> The process has too many open files to create more.
> .TP
> .B ENODEV
> Filesystem
> .I fsname
> not configured in the kernel.
> .TP
> .B ENOMEM
> The kernel could not allocate sufficient memory to complete the call.
> .TP
> .B EPERM
> The caller does not have the required privileges.
> .SH CONFORMING TO
> These functions are Linux-specific and should not be used in programs int=
ended
> to be portable.
> .SH VERSIONS
> .BR fsopen "(), and " fsmount ()
> were added to Linux in kernel 5.1.
> .SH NOTES
> Glibc does not (yet) provide a wrapper for the
> .BR fsopen "() or " fsmount "()"
> system calls; call them using
> .BR syscall (2).
> .SH SEE ALSO
> .BR mountpoint (1),
> .BR fsconfig (2),
> .BR fspick (2),
> .BR move_mount (2),
> .BR open_tree (2),
> .BR umount (2),
> .BR mount_namespaces (7),
> .BR path_resolution (7),
> .BR findmnt (8),
> .BR lsblk (8),
> .BR mount (8),
> .BR umount (8)
