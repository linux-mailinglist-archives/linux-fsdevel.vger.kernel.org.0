Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB3D0BDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 11:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfJIJwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 05:52:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45431 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIJwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:52:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so2000545wrm.12;
        Wed, 09 Oct 2019 02:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r25i8SYXTytdtOoc5WLwHt/c9HJpbm55Q2yp1XA73+s=;
        b=WI7bSyDWEuvE/rYmc0XsmUwinQxYoO6WqnYHUn2lN+M/PpgNBhDsv0uGssprmo/cDZ
         tCNeVGABFSAlxaWDK3aB6DVUZ3wx1sSM5PXI2/zbbpNm1LuvsoAKxCGkLpvEOrrksHNX
         LXgg6cLb/l4uytMOSXLpm1ZZxqaWSOoKbaz2RFhmfWHROVayghpmZtbXSvve8pzBA9hw
         sbLzS6rTNzEVt2pxfBVSa0YDznknMp6q7HH0gD+IM+6b6VEGdaynUMZggvs/quyJa/Qs
         q3a09y9CWcCn6l8Bwq04/WUKCeOUX8uJkvGZyKScSQX/ztbWAgxw2eaWaW+x6kJs97QP
         HYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r25i8SYXTytdtOoc5WLwHt/c9HJpbm55Q2yp1XA73+s=;
        b=iZ1gOHdWNjzrC0OO0cOglFl3XQxvLKa5EBj/hhyxC+F/rrm+MoIBsShkKTuWAkHWTO
         M2eQ2TQtJSGgXJSgbYUymr4f2TvbClThNkPAm7Bt/0UvuMYkdEQVfsnQrrXRfEaep/PK
         lX7OM/N8t+6E/j3Vob6Ab0rH0DbnY13ScZOcIzJq3kHrM5drVHhuJzMfFGnWGv/D8CFa
         lhtO+2J75rWllN8XdqYc4JB/grgdqBjcZ34ENjguS4P55cLoHD5zElNQ7YOJt+wH7KH6
         3p/o1ZztYkl1DKQq49FnMVrc1+HFt+bc8N2ifgkUxWFD1zzzqFAiVUacIRFnHrCLhv8I
         ngAQ==
X-Gm-Message-State: APjAAAVHooR1Squa9GDeEz8rhQQsUZct2lSk6pOe4D8WYcDyFmpI+CQc
        e61dbGSor6fTGdELnh7qUAU=
X-Google-Smtp-Source: APXvYqx/mvE9ZRZ5+UcHa+uvV23+X8uOIJ3eM0yc2hmOOM3nsGO8vGt7RhLTnmx6WBpeVGqNil89Dw==
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr1995616wrn.24.1570614729162;
        Wed, 09 Oct 2019 02:52:09 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id b130sm2266259wmh.12.2019.10.09.02.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 02:52:08 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [MANPAGE PATCH] Add manpage for fsopen(2), fspick(2) and
 fsmount(2)
To:     David Howells <dhowells@redhat.com>
References: <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <15488.1531263249@warthog.procyon.org.uk>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <17a7dfba-ccf6-77f5-c90e-2cbe841c811a@gmail.com>
Date:   Wed, 9 Oct 2019 11:52:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <15488.1531263249@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

See my previous mail.

With respect to the patch below, would you be willing to review
the content of this man-pages patch to see if it accurately reflects 
what was merged into the kernel, and then resubmit please?

Thanks,

Michael

On 7/11/18 12:54 AM, David Howells wrote:
> Add a manual page to document the fsopen(), fspick() and fsmount() system
> calls.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  man2/fsmount.2 |    1 
>  man2/fsopen.2  |  357 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  man2/fspick.2  |    1 
>  3 files changed, 359 insertions(+)
>  create mode 100644 man2/fsmount.2
>  create mode 100644 man2/fsopen.2
>  create mode 100644 man2/fspick.2
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
> index 000000000..1bc761ab4
> --- /dev/null
> +++ b/man2/fsopen.2
> @@ -0,0 +1,357 @@
> +'\" t
> +.\" Copyright (c) 2018 David Howells <dhowells@redhat.com>
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
> +.TH FSOPEN 2 2018-06-07 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +fsopen, fsmount, fspick \- Handle filesystem (re-)configuration and mounting
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.br
> +.B #include <sys/mount.h>
> +.br
> +.B #include <unistd.h>
> +.br
> +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> +.PP
> +.BI "int fsopen(const char *" fsname ", unsigned int " flags );
> +.PP
> +.BI "int fsmount(int " fd ", unsigned int " flags ", unsigned int " ms_flags );
> +.PP
> +.BI "int fspick(int " dirfd ", const char *" pathname ", unsigned int " flags );
> +.fi
> +.PP
> +.IR Note :
> +There are no glibc wrappers for these system calls.
> +.SH DESCRIPTION
> +.PP
> +.BR fsopen ()
> +creates a new filesystem configuration context within the kernel for the
> +filesystem named in the
> +.I fsname
> +parameter and attaches it to a file descriptor, which it then returns.  The
> +file descriptor can be marked close-on-exec by setting
> +.B FSOPEN_CLOEXEC
> +in flags.
> +.PP
> +The
> +file descriptor can then be used to configure the desired filesystem parameters
> +and security parameters by using
> +.BR write (2)
> +to pass parameters to it and then writing a command to actually create the
> +filesystem representation.
> +.PP
> +The file descriptor also serves as a channel by which more comprehensive error,
> +warning and information messages may be retrieved from the kernel using
> +.BR read (2).
> +.PP
> +Once the kernel's filesystem representation has been created, it can be queried
> +by calling
> +.BR fsinfo (2)
> +on the file descriptor.  fsinfo() will spot that the target is actually a
> +creation context and look inside that.
> +.PP
> +.BR fsmount ()
> +can then be called to create a mount object that refers to the newly created
> +filesystem representation, with the propagation and mount restrictions to be
> +applied specified in
> +.IR ms_flags .
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
> +moved to reconfiguration state, allowing the new superblock to be reconfigured.
> +.PP
> +.BR fspick ()
> +creates a new filesystem context within the kernel, attaches the superblock
> +specified by
> +.IR dfd ", " pathname ", " flags
> +and puts it into the reconfiguration state and attached the context to a new
> +file descriptor that can then be parameterised with
> +.BR write (2)
> +exactly the same as for the context created by fsopen() above.
> +.PP
> +.I flags
> +is an OR'd together mask of
> +.B FSPICK_CLOEXEC
> +which indicates that the returned file descriptor should be marked
> +close-on-exec and
> +.BR FSPICK_SYMLINK_NOFOLLOW ", " FSPICK_NO_AUTOMOUNT " and " FSPICK_EMPTY_PATH
> +which control the pathwalk to the target object (see below).
> +
> +.\"________________________________________________________
> +.SS Writable Command Interface
> +Superblock (re-)configuration is achieved by writing command strings to the
> +context file descriptor using
> +.BR write (2).
> +Each string is prefixed with a specifier indicating the class of command
> +being specified.  The available commands include:
> +.TP
> +\fB"o <option>"\fP
> +Specify a filesystem or security parameter.
> +.I <option>
> +is typically a key or key=val format string.  Since the length of the option is
> +given to write(), the option may include any sort of character, including
> +spaces and commas or even binary data.
> +.TP
> +\fB"s <name>"\fP
> +Specify a device file, network server or other other source specification.
> +This may be optional, depending on the filesystem, and it may be possible to
> +provide multiple of them to a filesystem.
> +.TP
> +\fB"x create"\fP
> +End the filesystem configuration phase and try and create a representation in
> +the kernel with the parameters specified.  After this, the context is shifted
> +to the mount-pending state waiting for an fsmount() call to occur.
> +.TP
> +\fB"x reconfigure"\fP
> +End a filesystem reconfiguration phase try to apply the parameters to the
> +filesystem representation.  After this, the context gets reset and put back to
> +the start of the reconfiguration phase again.
> +.PP
> +With this interface, option strings are not limited to 4096 bytes, either
> +individually or in sum, and they are also not restricted to text-only options.
> +Further, errors may be given individually for each option and not aggregated or
> +dumped into the kernel log.
> +
> +.\"________________________________________________________
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
> +.SH EXAMPLES
> +To illustrate the process, here's an example whereby this can be used to mount
> +an ext4 filesystem on /dev/sdb1 onto /mnt.  Note that the example ignores the
> +fact that
> +.BR write (2)
> +has a length parameter and that errors might occur.
> +.PP
> +.in +4n
> +.nf
> +sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> +write(sfd, "s /dev/sdb1");
> +write(sfd, "o noatime");
> +write(sfd, "o acl");
> +write(sfd, "o user_attr");
> +write(sfd, "o iversion");
> +write(sfd, "x create");
> +fsinfo(sfd, NULL, ...);
> +mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MS_RELATIME);
> +move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.in
> +.PP
> +Here, an ext4 context is created first and attached to sfd.  This is then told
> +where its source will be, given a bunch of options and created.
> +.BR fsinfo (2)
> +can then be used to query the filesystem.  Then fsmount() is called to create a
> +mount object and
> +.BR move_mount (2)
> +is called to attach it to its intended mountpoint.
> +.PP
> +And here's an example of mounting from an NFS server:
> +.PP
> +.in +4n
> +.nf
> +sfd = fsopen("nfs", 0);
> +write(sfd, "s example.com/pub/linux");
> +write(sfd, "o nfsvers=3");
> +write(sfd, "o rsize=65536");
> +write(sfd, "o wsize=65536");
> +write(sfd, "o rdma");
> +write(sfd, "x create");
> +mfd = fsmount(sfd, 0, MS_NODEV);
> +move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.in
> +.PP
> +Reconfiguration can be achieved by:
> +.PP
> +.in +4n
> +.nf
> +sfd = fspick(AT_FDCWD, "/mnt", FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC);
> +write(sfd, "o ro");
> +write(sfd, "x reconfigure");
> +.fi
> +.in
> +.PP
> +or:
> +.PP
> +.in +4n
> +.nf
> +sfd = fsopen(...);
> +...
> +mfd = fsmount(sfd, ...);
> +...
> +write(sfd, "o ro");
> +write(sfd, "x reconfigure");
> +.fi
> +.in
> +
> +
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.SH RETURN VALUE
> +On success, all three functions return a file descriptor.  On error, \-1 is
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
> +.B EACCES
> +A component of a path was not searchable.
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EACCES
> +Mounting a read-only filesystem was attempted without giving the
> +.B MS_RDONLY
> +flag.
> +.TP
> +.B EACCES
> +The block device
> +.I source
> +is located on a filesystem mounted with the
> +.B MS_NODEV
> +option.
> +.\" mtk: Probably: write permission is required for MS_BIND, with
> +.\" the error EPERM if not present; CAP_DAC_OVERRIDE is required.
> +.TP
> +.B EBUSY
> +.I source
> +cannot be reconfigured read-only, because it still holds files open for
> +writing.
> +.TP
> +.B EFAULT
> +One of the pointer arguments points outside the user address space.
> +.TP
> +.B EINVAL
> +.I source
> +had an invalid superblock.
> +.TP
> +.B EINVAL
> +.I ms_flags
> +includes more than one of
> +.BR MS_SHARED ,
> +.BR MS_PRIVATE ,
> +.BR MS_SLAVE ,
> +or
> +.BR MS_UNBINDABLE .
> +.TP
> +.BR EINVAL
> +An attempt was made to bind mount an unbindable mount.
> +.TP
> +.B ELOOP
> +Too many links encountered during pathname resolution.
> +.TP
> +.B EMFILE
> +The system has too many open files to create more.
> +.TP
> +.B ENFILE
> +The process has too many open files to create more.
> +.TP
> +.B ENAMETOOLONG
> +A pathname was longer than
> +.BR MAXPATHLEN .
> +.TP
> +.B ENODEV
> +Filesystem
> +.I fsname
> +not configured in the kernel.
> +.TP
> +.B ENOENT
> +A pathname was empty or had a nonexistent component.
> +.TP
> +.B ENOMEM
> +The kernel could not allocate sufficient memory to complete the call.
> +.TP
> +.B ENOTBLK
> +.I source
> +is not a block device (and a device was required).
> +.TP
> +.B ENOTDIR
> +.IR pathname ,
> +or a prefix of
> +.IR source ,
> +is not a directory.
> +.TP
> +.B ENXIO
> +The major number of the block device
> +.I source
> +is out of range.
> +.TP
> +.B EPERM
> +The caller does not have the required privileges.
> +.SH CONFORMING TO
> +These functions are Linux-specific and should not be used in programs intended
> +to be portable.
> +.SH VERSIONS
> +.BR fsopen "(), " fsmount "() and " fspick ()
> +were added to Linux in kernel 4.18.
> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR fsopen "() , " fsmount "() or " fspick "()"
> +system calls; call them using
> +.BR syscall (2).
> +.SH SEE ALSO
> +.BR mountpoint (1),
> +.BR move_mount (2),
> +.BR open_tree (2),
> +.BR umount (2),
> +.BR mount_namespaces (7),
> +.BR path_resolution (7),
> +.BR findmnt (8),
> +.BR lsblk (8),
> +.BR mount (8),
> +.BR umount (8)
> diff --git a/man2/fspick.2 b/man2/fspick.2
> new file mode 100644
> index 000000000..2bf59fc3e
> --- /dev/null
> +++ b/man2/fspick.2
> @@ -0,0 +1 @@
> +.so man2/fsopen.2
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
