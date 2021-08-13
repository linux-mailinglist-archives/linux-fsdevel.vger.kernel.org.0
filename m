Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE83EADE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 02:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhHMAXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 20:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhHMAXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 20:23:38 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFCDC061756;
        Thu, 12 Aug 2021 17:23:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o185so13285724oih.13;
        Thu, 12 Aug 2021 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=g6aNfvqNLuTnnvr1o1PF/KW4kI0g6a2rgjbPolDXgg4=;
        b=Js11tXJvxKlET6qhbldP58bmdt7RwqQ7UFcZYRJJXjosudSHQhDJ3FLODiqt59LOyS
         MnYWGUKVScynYHWCqj/p2CO9G7GxaBHSjGedqQeOHOkRSwuZ3+44Z6ngXDNaxrTbZ3Le
         vyWZymM3MD5oqeuoiGa/ypYEHuv3YcYB/vQ9TQvYwwCU5WA72pCGjslxUcBqEGqCQ2dO
         oPcvzFMdHYXXmAlcVPETItcg3ZBsCkgdY67eG8uEok8WqPoVTs4vX7N5TQfd6wrReNk/
         KHWuYADhG30HgIug2PYZQ3iRqHO9JfILuAEFzv28nlj4sdsrtsUvxvVHoglULjQJFmIZ
         /bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=g6aNfvqNLuTnnvr1o1PF/KW4kI0g6a2rgjbPolDXgg4=;
        b=NQvIL1esIp2bXX3+1QHMIohNiVhZYhzczbqaKG0Fyis15REeHiXCva62ErbMDmHaIG
         waRjKxzUiBjcik4lcDQzvdalCrJsXTlXB8usapjCX8jjBvVx+yYw6kS/6V2aufaZUy0+
         kzpSI6YoHtT739qc+kRfwRwbbb4oh3xE2W4jLfaosLA9UKHh24VzywCxoJNTduyH4y2R
         YUJaidZDiZUBOsPk5k5rIehlzNyrzcNOO6EwtftnqZWQgi+IXPmaE9dF7gVmOFUK0Pp8
         OrZs4i0QdFG/qjD2vFteokS+jLuE+PIvfntaOvWBOFf8KbCSdBhR5611KTLoj/nY86OX
         mmAQ==
X-Gm-Message-State: AOAM5312FxahZgWhY/EPSebeJ+zGeLWXnoApxDt6DENg5lKUAhnUsz35
        5gjmAdISILB6nW1rKT/SXoK6QDdhe3fXm0JEm4U=
X-Google-Smtp-Source: ABdhPJw6c1nUA4/6/7FT13alfZBxwI64ERG5aNB/Xw5TVpvEVADoZphvLMN2iIOij33J7frGHHzM6c1goR7OymI8Hco=
X-Received: by 2002:a05:6808:250:: with SMTP id m16mr5390631oie.148.1628814191437;
 Thu, 12 Aug 2021 17:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827191245.306468.4903071494263813779.stgit@warthog.procyon.org.uk> <ae623a81-50f5-3ccd-8eee-ea5604664a41@gmail.com>
In-Reply-To: <ae623a81-50f5-3ccd-8eee-ea5604664a41@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 13 Aug 2021 02:23:00 +0200
Message-ID: <CAKgNAkjsbPLgHN=YiVyTts6k3rexemjBQWeXEnXFh5zf4npDrw@mail.gmail.com>
Subject: Re: [PATCH 5/5] Add manpage for fsconfig(2)
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

As noted in another mail, I will ping on all of the mails, just to
raise all the patches to the top of the inbox.

Thanks,

Michael


On Thu, 27 Aug 2020 at 13:07, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello David,
>
> On 8/24/20 2:25 PM, David Howells wrote:
> > Add a manual page to document the fsconfig() system call.
> >
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > ---
> >
> >  man2/fsconfig.2 |  277 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 277 insertions(+)
> >  create mode 100644 man2/fsconfig.2
> >
> > diff --git a/man2/fsconfig.2 b/man2/fsconfig.2
> > new file mode 100644
> > index 000000000..da53d2fcb
> > --- /dev/null
> > +++ b/man2/fsconfig.2
> > @@ -0,0 +1,277 @@
> > +'\" t
> > +.\" Copyright (c) 2020 David Howells <dhowells@redhat.com>
> > +.\"
> > +.\" %%%LICENSE_START(VERBATIM)
> > +.\" Permission is granted to make and distribute verbatim copies of this
> > +.\" manual provided the copyright notice and this permission notice are
> > +.\" preserved on all copies.
> > +.\"
> > +.\" Permission is granted to copy and distribute modified versions of this
> > +.\" manual under the conditions for verbatim copying, provided that the
> > +.\" entire resulting derived work is distributed under the terms of a
> > +.\" permission notice identical to this one.
> > +.\"
> > +.\" Since the Linux kernel and libraries are constantly changing, this
> > +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> > +.\" responsibility for errors or omissions, or for damages resulting from
> > +.\" the use of the information contained herein.  The author(s) may not
> > +.\" have taken the same level of care in the production of this manual,
> > +.\" which is licensed free of charge, as they might when working
> > +.\" professionally.
> > +.\"
> > +.\" Formatted or processed versions of this manual, if unaccompanied by
> > +.\" the source, must acknowledge the copyright and authors of this work.
> > +.\" %%%LICENSE_END
> > +.\"
> > +.TH FSCONFIG 2 2020-08-24 "Linux" "Linux Programmer's Manual"
> > +.SH NAME
> > +fsconfig \- Filesystem parameterisation
> > +.SH SYNOPSIS
> > +.nf
> > +.B #include <sys/types.h>
> > +.B #include <sys/mount.h>
> > +.B #include <unistd.h>
> > +.B #include <sys/mount.h>
> > +.PP
> > +.BI "int fsconfig(int *" fd ", unsigned int " cmd ", const char *" key ,
> > +.br
> > +.BI "             const void __user *" value ", int " aux ");"
> > +.br
>
> Please remove two instances of .br above
>
> > +.BI
> > +.fi
> > +.PP
> > +.IR Note :
> > +There is no glibc wrapper for this system call.
> > +.SH DESCRIPTION
> > +.PP
> > +.BR fsconfig ()
> > +is used to supply parameters to and issue commands against a filesystem
> > +configuration context as set up by
> > +.BR fsopen (2)
> > +or
> > +.BR fspick (2).
> > +The context is supplied attached to the file descriptor specified by
>
> s/by/by the/
>
> > +.I fd
> > +argument.
> > +.PP
> > +The
> > +.I cmd
> > +argument indicates the command to be issued, where some of the commands simply
> > +supply parameters to the context.  The meaning of
> > +.IR key ", " value " and " aux
> > +are command-dependent; unless required for the command, these should be set to
>
> "should" or "must"? If not "must", why not? (It feels like an API design
> error not to require these to be NULL/0 in cases where they are not used.)
>
> > +NULL or 0.
> > +.PP
> > +The available commands are:
> > +.TP
> > +.B FSCONFIG_SET_FLAG
> > +Set the parameter named by
> > +.IR key
> > +to true.  This may fail with error
>
> s/with error/with the error/
> (and multiple times below)
>
> > +.B EINVAL
> > +if the parameter requires an argument.
> > +.TP
> > +.B FSCONFIG_SET_STRING
> > +Set the parameter named by
> > +.I key
> > +to a string.  This may fail with error
> > +.B EINVAL
> > +if the parser doesn't want a parameter here, wants a non-string or the string
> > +cannot be interpreted appropriately.
> > +.I value
> > +points to a NUL-terminated string.
> > +.TP
> > +.B FSCONFIG_SET_BINARY
> > +Set the parameter named by
> > +.I key
> > +to be a binary blob argument.  This may cause
> > +.B EINVAL
> > +to be returned if the filesystem parser isn't expecting a binary blob and it
> > +can't be converted to something usable.
> > +.I value
> > +points to the data and
> > +.I aux
> > +indicates the size of the data.
> > +.TP
> > +.B FSCONFIG_SET_PATH
> > +Set the parameter named by
> > +.I key
> > +to the object at the provided path.
> > +.I value
> > +should point to a NUL-terminated pathname string and aux may indicate
> > +.B AT_FDCWD
> > +or a file descriptor indicating a directory from which to begin a relative
> > +path resolution.  This may fail with error
> > +.B EINVAL
> > +if the parameter isn't expecting a path; it may also fail if the path cannot
> > +be resolved with the typcal errors for that
>
> s/typcal/typical/
>
> > +.RB "(" ENOENT ", " ENOTDIR ", " EPERM ", " EACCES ", etc.)."
> > +.IP
> > +Note that FSCONFIG_SET_STRING can be used instead, implying AT_FDCWD.
>
> I don't understand the preceding sentence. Can you rewrite to supply more
> detail? (E.g., "instead *of what*")
>
> > +.TP
> > +.B FSCONFIG_SET_PATH_EMPTY
> > +As FSCONFIG_SET_PATH, but with
> > +.B AT_EMPTY_PATH
> > +applied to the pathwalk.
>
> Can you please supply a bit more detail here, rather than just referring to
> FSCONFIG_SET_PATH.
>
> > +.TP
> > +.B FSCONFIG_SET_FD
> > +Set the parameter named by
> > +.I key
> > +to the file descriptor specified by
> > +.IR aux .
> > +This will fail with
> > +.B EINVAL
> > +if the parameter doesn't expect a file descriptor or
> > +.B EBADF
> > +if the file descriptor is invalid.
>
> Can you mention some use cases for FSCONFIG_SET_FD here please?
>
> > +.IP
> > +Note that FSCONFIG_SET_STRING can be used instead with the file descriptor
> > +passed as a decimal string.
> > +.TP
> > +.B FSCONFIG_CMD_CREATE
> > +This command triggers the filesystem to take the parameters set in the context
> > +and to try to create filesystem representation in the kernel.  If an existing
> > +representation can be shared, the filesystem may do that instead if the
> > +parameters permit.  This is intended for use with
> > +.BR fsopen (2).
> > +.TP
> > +.B FSCONFIG_CMD_RECONFIGURE
> > +This command causes the driver to alter the parameters of an already live
>
> "the driver" seems like the wrong terminology here. The page never
> mentioned "driver" before this point.) Is there something better?
>
> > +filesystem instance according to the parameters stored in the context.  This
> > +is intended for use with
> > +.BR fspick (2),
> > +but may also by used against the context created by
> > +.BR fsopen()
> > +after
> > +.BR fsmount (2)
> > +has been called on it.
>
> s/it/that context/
>
> > +
> > +.\"________________________________________________________
>
> Please remove above two lines.
>
> > +.SH EXAMPLES
>
> Please move the EXAMPLES section to just above SEE ALSO.
>
> Are the following independent examples or all one big example?
> Can you please add some explanatory text to make it clear?
>
> > +.PP
> > +.in +4n
> > +.nf
> > +fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> > +
> > +fsconfig(sfd, FSCONFIG_SET_STRING, "user_xattr", "false", 0);
> > +
> > +fsconfig(sfd, FSCONFIG_SET_BINARY, "ms_pac", pac_buffer, pac_size);
> > +
> > +fsconfig(sfd, FSCONFIG_SET_PATH, "journal", "/dev/sdd4", AT_FDCWD);
> > +
> > +dirfd = open("/dev/", O_PATH);
> > +fsconfig(sfd, FSCONFIG_SET_PATH, "journal", "sdd4", dirfd);
> > +
> > +fd = open("/overlays/mine/", O_PATH);
> > +fsconfig(sfd, FSCONFIG_SET_PATH_EMPTY, "lower_dir", "", fd);
> > +
> > +pipe(pipefds);
> > +fsconfig(sfd, FSCONFIG_SET_FD, "fd", NULL, pipefds[1]);
> > +.fi
> > +.in
> > +.PP
> > +.SH RETURN VALUE
> > +On success, the function returns 0.  On error, \-1 is returned, and
> > +.I errno
> > +is set appropriately.
> > +.SH ERRORS
> > +The error values given below result from filesystem type independent
> > +errors.
> > +Each filesystem type may have its own special errors and its
>
> s/may/may additionally/
>
> > +own special behavior.
> > +See the Linux kernel source code for details.
> > +.TP
> > +.B EACCES
> > +A component of a path was not searchable.
> > +(See also
> > +.BR path_resolution (7).)
> > +.TP
> > +.B EACCES
> > +Mounting a read-only filesystem was attempted without specifying the
> > +.RB ' ro '
> > +parameter.
> > +.TP
> > +.B EACCES
> > +A specified block device is located on a filesystem mounted with the
> > +.B MS_NODEV
> > +option.
> > +.\" mtk: Probably: write permission is required for MS_BIND, with
> > +.\" the error EPERM if not present; CAP_DAC_OVERRIDE is required.
> > +.TP
> > +.B EBADF
> > +The file descriptor given by
> > +.I fd
> > +or possibly by
> > +.I aux
> > +(depending on the command) is invalid.
> > +.TP
> > +.B EBUSY
> > +The context attached to
> > +.I fd
> > +is in the wrong state for the given command.
> > +.TP
> > +.B EBUSY
> > +The filesystem representation cannot be reconfigured read-only because it still
> > +holds files open for writing.
> > +.TP
> > +.B EFAULT
> > +One of the pointer arguments points outside the accessible address space.
> > +.TP
> > +.B EINVAL
> > +.I fd
> > +does not refer to a filesystem configuration context.
> > +.TP
> > +.B EINVAL
> > +One of the source parameters referred to an invalid superblock.
> > +.TP
> > +.B ELOOP
> > +Too many links encountered during pathname resolution.
> > +.TP
> > +.B ENAMETOOLONG
> > +A path name was longer than
> > +.BR MAXPATHLEN .
> > +.TP
> > +.B ENOENT
> > +A pathname was empty or had a nonexistent component.
> > +.TP
> > +.B ENOMEM
> > +The kernel could not allocate sufficient memory to complete the call.
> > +.TP
> > +.B ENOTBLK
> > +Once of the parameters does not refer to a block device (and a device was
>
> s/Once/One/
>
> > +required).
> > +.TP
> > +.B ENOTDIR
> > +.IR pathname ,
>
> But there is no argument "pathname" mentioned in this page!?
>
> > +or a prefix of
> > +.IR source ,
> > +is not a directory.
>
> But there is no argument "source" mentioned in this page!?
>
> (Can you please review all of the errors listed in this section to
> check that they apply to fsconfig().)
>
> > +.TP
> > +.B EOPNOTSUPP
> > +The command given by
> > +.I cmd
> > +was not valid.
> > +.TP
> > +.B ENXIO
> > +The major number of a block device parameter is out of range.
> > +.TP
> > +.B EPERM
> > +The caller does not have the required privileges.
>
> Please name the capability. Also, there was no mention of privileges in
> the text above, so could you please add some text about why/when
> privilege is needed.
>
> > +.SH CONFORMING TO
> > +These functions are Linux-specific and should not be used in programs intended
> > +to be portable.
> > +.SH VERSIONS
> > +.BR fsconfig ()
> > +was added to Linux in kernel 5.2.
> > +.SH NOTES
> > +Glibc does not (yet) provide a wrapper for the
> > +.BR fsconfig ()
> > +system call; call it using
> > +.BR syscall (2).
> > +.SH SEE ALSO
> > +.BR mountpoint (1),
> > +.BR fsmount (2),
> > +.BR fsopen (2),
> > +.BR fspick (2),
> > +.BR mount_namespaces (7),
> > +.BR path_resolution (7)
>
> Thanks,
>
> Michael
>
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
