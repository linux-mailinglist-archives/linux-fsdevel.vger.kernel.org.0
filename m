Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BD13000CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 11:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAVJ3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 04:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbhAVIlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:41:02 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C75C061786;
        Fri, 22 Jan 2021 00:40:18 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q25so5212394oij.10;
        Fri, 22 Jan 2021 00:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=e0T/0FMUpYKFq5BQWC0q9ZRuoujNmvORYqx5Qnxrd6U=;
        b=Qg+bUYVKucO99QnqOD4irrWaQBQMH2hjBBwXFRQi8Pojs8JiwApZXHdXhzAXyM5Pqc
         a+tQUweISQZagSTAGPD69wWhU8GeHSF5kqApp1qa/mBCX2KaFLKcf0Auzv3t4naom4dc
         1gU8KN3/z5DcOduhiBWp++lA9Vf3QqS5FTK0BDE8E2pJz2pp76Lzr4tpAZfHFkOdhEdI
         oN7dqVOhUeojDRk2v6aaAzKTnU4jCSm3crS9fVvVPFpLcV28nkOpJLC+8F17KHKV0hI1
         NMf/rZw7ZMWZexe2AepQEVVARyALk8OczObHNBX2K+bOnM6zUSJYqqT6zgBFAD1wzWXv
         HfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=e0T/0FMUpYKFq5BQWC0q9ZRuoujNmvORYqx5Qnxrd6U=;
        b=R7qVdj0YvRNF6xv2FnDefesiUni2EEPR7tMRvF3k0e1GbHRb316IOF4iQ5bEuelGSx
         xfMkbLlvVo0O+NifzWNxzyd4sjk6I/ph3RzhhEPoVK29SLZAZ03g4N9n0G/nG033Pyrz
         itWPotGFOyBrLlLlcXZMXErODP7Y/U+ycNI/r5LsAwpNSZnIR6qkdjRMMnsoARnZzN6V
         cL4rru58lFO1syEbGZp80UFJhJvnNJaPxcBRrSAgxhf6m6an7siSI1MPmq12NvPdRDwM
         tZeweXPO1J+KDvOs4bZlsCXxF7vgdcBDLUKCtfw8NHmgrwHNPg32KHwVJBaVMMTFkQvb
         aUPA==
X-Gm-Message-State: AOAM530alvsGJPoF8CJ3Z7dCmZ4Gvo1+KhnXWBiN28nvDNdK44EbChiX
        NG5j87OqKu+EuFRfb8rIPEzMDY9yRSaZu+C8pAM=
X-Google-Smtp-Source: ABdhPJxO03NnkN0i+zF1FsF5GZIM81INjIxkYX25MAI0FxT8LEV/GLpukpWNGekHxp3VyVrLV2Dp109fDZqLDGQ89bA=
X-Received: by 2002:aca:ded4:: with SMTP id v203mr2551827oig.148.1611304817605;
 Fri, 22 Jan 2021 00:40:17 -0800 (PST)
MIME-Version: 1.0
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827189767.306468.1803062787718957199.stgit@warthog.procyon.org.uk>
In-Reply-To: <159827189767.306468.1803062787718957199.stgit@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 22 Jan 2021 09:40:06 +0100
Message-ID: <CAKgNAkj=1y51Yei9FchAEKEm=mgY_soVfn-58mRC+Z2Ae2HZZw@mail.gmail.com>
Subject: Re: [PATCH 3/5] Add manpage for fspick(2)
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

On Mon, 24 Aug 2020 at 14:25, David Howells <dhowells@redhat.com> wrote:
>
> Add a manual page to document the fspick() system call.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  man2/fspick.2 |  180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 man2/fspick.2
>
> diff --git a/man2/fspick.2 b/man2/fspick.2
> new file mode 100644
> index 000000000..72bf645dd
> --- /dev/null
> +++ b/man2/fspick.2
> @@ -0,0 +1,180 @@
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
> +.TH FSPICK 2 2020-08-24 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +fspick \- Select filesystem for reconfiguration
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.B #include <sys/mount.h>
> +.B #include <unistd.h>
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
> +the caller.  The file descriptor can be marked close-on-exec by setting
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
> +Don't follow symbolic links in the final component of the path.
> +.TP
> +.B FSPICK_NO_AUTOMOUNT
> +Don't follow automounts in the final component of the path.
> +.TP
> +.B FSPICK_EMPTY_PATH
> +Allow an empty string to be specified as the pathname.  This allows
> +.I dirfd
> +to specify the target mount exactly.
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
> +depth of 8 messages, so it's possible for some to get lost.
> +.SH RETURN VALUE
> +On success, the function returns a file descriptor.  On error, \-1 is returned,
> +and
> +.I errno
> +is set appropriately.
> +.SH ERRORS
> +The error values given below result from filesystem type independent errors.
> +Additionally, each filesystem type may have its own special errors and its own
> +special behavior.  See the Linux kernel source code for details.
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
> +were added to Linux in kernel 5.2.
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
>
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
