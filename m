Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB98724E99C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 22:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHVUFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 16:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHVUFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:05:50 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221FC061573;
        Sat, 22 Aug 2020 13:05:50 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id v13so4650560oiv.13;
        Sat, 22 Aug 2020 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Rhb8zoMaj7j/ezMOk1MqqzRZF+F99xWaFA/zqFb3LTk=;
        b=N5B0XHjCOFjTtBvQDKlDC0R/Fze/GV8DXPCtz2ykzJmq5yE7B8+KIZjbbRlhjFkNR9
         a3mkHhi4xbMiKlTB6rJpltPdSQG98M0GRN+j/rbkHeeUk//Wl9RooN+4k5wdPaTIvpZG
         IS+qAWCYnEd1IpocYLG05s/ZvxUtFG2LnQsA8FwkKIBF+693CiDjjv/+XEApyrIoJcLX
         V06DmKwS7w5UqhjOygdIvI85YH94IahGlQANpJkzRpH2deCIy19Yf+t9wKoD1YaYhHVU
         no49psKZSqb7Kk5v2xJKNX8EUaMLvr+MjnF1aWfZWZIYibuCM2fbC1k76pWxQVq9uYoa
         ZcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Rhb8zoMaj7j/ezMOk1MqqzRZF+F99xWaFA/zqFb3LTk=;
        b=MsHsQtYGmEVdnxHIoqfyRBS73UZTZuM/K7pgKU6rTcyZRfphfkSejmGnqjl/h61hGS
         o1RSNqmcmEF3B2Q+zDEdrriDQDWib+MaOhlxLL6uoXzEfGNI+W3ieR+lF8uMx/cTqusu
         uely2ioRm5wfzfUJr489jlWqDmiU7xOAWj35uqpN2Ygo30nXW+/4BpsCEtysCfLAnHHK
         By99caK4FP+b3VUfcEQIoAwcig3nJw3MkpYi7F90Ab042E/RI7YNEXQ06crKE67Jlr3U
         f3ZI+UqhBQSThr04rou5vVbvBp09APBOAJxHvfdPoYdAu+DtwVzShlrr6C0xN++EBl5K
         TrTQ==
X-Gm-Message-State: AOAM530Y44IG6Hdzoy1AyYLnEvb+eSOVHte/RNVFZ7YCT9dFShefsmsR
        D1r3cS3a5ffuVYcJdWYUrsrVIKrltICnJLhxk+s=
X-Google-Smtp-Source: ABdhPJy5zJFy0TE8jQUKTerSL7VQThWDNKSQCS36ZSpfKdobh+6pLIXR9VLk3vOqs1jOAMaiVeCUoDe7//80s2Qkpqw=
X-Received: by 2002:a05:6808:b36:: with SMTP id t22mr5574884oij.159.1598126749064;
 Sat, 22 Aug 2020 13:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
 <159680895624.29015.1515546306605977725.stgit@warthog.procyon.org.uk>
In-Reply-To: <159680895624.29015.1515546306605977725.stgit@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sat, 22 Aug 2020 22:05:37 +0200
Message-ID: <CAKgNAkjPL=86+UTTvWYa3asTxfpKHEv=39ePfsj0W9V5QD71Vg@mail.gmail.com>
Subject: Re: [PATCH 3/5] Add manpage for fspick(2)
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

Hello David,

On Fri, 7 Aug 2020 at 16:02, David Howells <dhowells@redhat.com> wrote:
>
> Add a manual page to document the fspick() system call.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  man2/fspick.2 |  195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 195 insertions(+)
>  create mode 100644 man2/fspick.2
>
> diff --git a/man2/fspick.2 b/man2/fspick.2
> new file mode 100644
> index 000000000..24242b98b
> --- /dev/null
> +++ b/man2/fspick.2
> @@ -0,0 +1,195 @@
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
> +.TH FSPICK 2 2020-08-07 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +fspick \- Select filesystem for reconfiguration
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.br

Remove all instances of ".br" here in the SYNOPSIS. They aren't needed
(because of the .nf above).

> +.B #include <sys/mount.h>
> +.br
> +.B #include <unistd.h>
> +.br
> +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> +.PP
> +.BI "int fspick(int " dirfd ", const char *" pathname ", unsigned int " flags );
> +.fi
> +.PP
> +.IR Note :
> +There is no glibc wrapper for this system call.
> +.SH DESCRIPTION
> +.PP
> +.BR fspick ()
> +creates a new filesystem configuration context within the kernel and attaches a
> +pre-existing superblock to it so that it can be reconfigured (similar to
> +.BR mount (8)
> +with the "-o remount" option).  The configuration context is marked as being in
> +reconfiguration mode and attached to a file descriptor, which is returned to
> +the caller.  This can be marked close-on-exec by setting

s/This/The file descriptor/

> +.B FSPICK_CLOEXEC
> +in
> +.IR flags .
> +.PP
> +The target is whichever superblock backs the object determined by
> +.IR dfd ", " pathname " and " flags .
> +The following can be set in
> +.I flags
> +to control the pathwalk to that object:
> +.TP
> +.B FSPICK_SYMLINK_NOFOLLOW
> +Don't follow symbolic links in the terminal component of the path.

Better: s/terminal/final/

> +.TP
> +.B FSPICK_NO_AUTOMOUNT
> +Don't follow automounts in the terminal component of the path.

Better: s/terminal/final/

> +.TP
> +.B FSPICK_EMPTY_PATH
> +Allow an empty string to be specified as the pathname.  This allows
> +.I dirfd
> +to specify a path exactly.

The use of "path" in the above line is "off"; dirfd is a file
descriptor. Can you reword?

> +.PP
> +After calling fspick(), the file descriptor should be passed to the
> +.BR fsconfig (2)
> +system call, using that to specify the desired changes to filesystem and
> +security parameters.
> +.PP
> +When the parameters are all set, the
> +.BR fsconfig ()
> +system call should then be called again with
> +.B FSCONFIG_CMD_RECONFIGURE
> +as the command argument to effect the reconfiguration.
> +.PP
> +After the reconfiguration has taken place, the context is wiped clean (apart
> +from the superblock attachment, which remains) and can be reused to make
> +another reconfiguration.
> +.PP
> +The file descriptor also serves as a channel by which more comprehensive error,
> +warning and information messages may be retrieved from the kernel using
> +.BR read (2).
> +
> +
> +.\"________________________________________________________

Please remove above three lines.

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
> +Messages are removed from the queue as they're read and the queue has a limited
> +depth, so it's possible for some to get lost.

s/depth/length/ (or "size").

And, what is the limit? It would be helpful to give the reader a clue.

> +
> +.\"________________________________________________________

Please remove above two lines.

> +.SH EXAMPLES
> +To illustrate the process, here's an example whereby this can be used to
> +reconfigure a filesystem:
> +.PP
> +.in +4n
> +.nf
> +sfd = fspick(AT_FDCWD, "/mnt", FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "user_xattr", "false", 0);
> +fsconfig(sfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
> +.fi
> +.in
> +.PP
> +
> +
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Please remove above *six* lines.

> +.SH RETURN VALUE
> +On success, the function returns a file descriptor.  On error, \-1 is returned,
> +and
> +.I errno
> +is set appropriately.
> +.SH ERRORS
> +The error values given below result from filesystem type independent
> +errors.
> +Each filesystem type may have its own special errors and its

s/Each/Additionally, each/ ?

> +own special behavior.
> +See the Linux kernel source code for details.
> +.TP
> +.B EACCES
> +A component of a path was not searchable.
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EFAULT
> +.I pathname
> +points outside the user address space.
> +.TP
> +.B EINVAL
> +.I flags
> +includes an undefined value.
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
> +.B ENOENT
> +A pathname was empty or had a nonexistent component.
> +.TP
> +.B ENOMEM
> +The kernel could not allocate sufficient memory to complete the call.
> +.TP
> +.B EPERM
> +The caller does not have the required privileges.
> +.SH CONFORMING TO
> +These functions are Linux-specific and should not be used in programs intended
> +to be portable.
> +.SH VERSIONS
> +.BR fsopen "(), " fsmount "() and " fspick ()
> +were added to Linux in kernel 5.1.

5.2!

> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR fspick "()"
> +system call; call it using
> +.BR syscall (2).
> +.SH SEE ALSO
> +.BR mountpoint (1),
> +.BR fsconfig (2),
> +.BR fsopen (2),
> +.BR path_resolution (7),
> +.BR mount (8)

Thanks,

Michael


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
