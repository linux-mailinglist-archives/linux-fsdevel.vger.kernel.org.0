Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A57624E991
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHVUCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHVUCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:02:04 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE95DC061573;
        Sat, 22 Aug 2020 13:02:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z22so4668213oid.1;
        Sat, 22 Aug 2020 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8IiD3vUE6EEJl1AA2/turgrRFDws92XHOWsRzC5fMok=;
        b=qTEUgJSUXzJN5AOuP9ResZi+yF29K13u1JR/YZS/osrDWTI8NfuisUZhpuUGQ+GaFL
         TdM5Egt1DeMhmNvCDnZ8H4AbVKiO2MnAJRCeMfAdrFUChbSKF8+blPb9ev+Q7UXG1Jom
         nQvYm45NDfJZbvmEwLF9FPn4REju4imkst4xVTo0LeDXPLQqgIhvny+8uwWwbDQ6KepL
         i1UdmehHkeMvSxJkEBquZEYQFpY81KTuI53TJ7C6ekyMvIS7a8OpOalEZCKnYlsGDU6u
         g308eTGQrAE/suGt+MLyCD7xfzPCQAwGXhilvmpSlTlx5tWowZWWErS/zbFCpqptSY5M
         WMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8IiD3vUE6EEJl1AA2/turgrRFDws92XHOWsRzC5fMok=;
        b=lT11C1V4nafazr0UlHJy51F9oO2TvZDv1JEkZmvtgfnmSK/aANO0PEOk/w/Eog+Gm5
         ozXKB6vjZR9pQo/J82Yi5WzIwr1HIsISd0oHCUj9d/oBWxGcyNpGiZxpH/zetes5o8gA
         PcGs62ygsN4PzUshGVgsdhw27RAs8wtu3f3u9Ya2t1Z6OPDuw3PWTOOK8a6QCVf4jmY8
         XiccJ59cRuvAoXoWAS+kJnMUAikqRqeHYKRCfo/8JoVZDR/4oohbY41p9URuAyAYHJp4
         syk1THUl8woV0aSP+SS1/wvXcDu/Rs9yiJFFPSr5nuPsM1TNPif10jtB38n+OSMiWUfT
         20Hw==
X-Gm-Message-State: AOAM5309unT+6W4TmHV6Tliv595vVJHD1djzUvNNCwCusfbPkiZhBVJ9
        z2Fc42gxg9tJ1mVmdtbNUoAQZ0AvThTY2MSMuspy5CDCcMd6ww==
X-Google-Smtp-Source: ABdhPJwSYBSkAmUi4ScvQ8LQh+85txZ70bPMwFvGDP2ojBWmyBEoEuWS8WCN9YbjA7dbm9TYWjVPssOOjwxjz/UMIdo=
X-Received: by 2002:aca:cd56:: with SMTP id d83mr5747684oig.177.1598126523142;
 Sat, 22 Aug 2020 13:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
In-Reply-To: <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sat, 22 Aug 2020 22:01:50 +0200
Message-ID: <CAKgNAkiQ7bhvKw3jVT46AZcGDwN-PLPAdYX731a8Dcw+ZDQeaQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] Add manpage for open_tree(2)
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

Thanks for sending these pages!

On Fri, 7 Aug 2020 at 16:02, David Howells <dhowells@redhat.com> wrote:
>
> Add a manual page to document the open_tree() system call.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  man2/open_tree.2 |  260 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 260 insertions(+)
>  create mode 100644 man2/open_tree.2
>
> diff --git a/man2/open_tree.2 b/man2/open_tree.2
> new file mode 100644
> index 000000000..a360b11a5
> --- /dev/null
> +++ b/man2/open_tree.2
> @@ -0,0 +1,260 @@
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
> +.TH OPEN_TREE 2 2020-08-07 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +open_tree \- Pick or clone mount object and attach to fd
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
> +.BI "int open_tree(int " dirfd ", const char *" pathname ", unsigned int " flags );
> +.fi
> +.PP
> +.IR Note :
> +There are no glibc wrappers for these system calls.
> +.SH DESCRIPTION
> +.BR open_tree ()
> +picks the mount object specified by the pathname and attaches it to a new file
> +descriptor or clones it and attaches the clone to the file descriptor.  The
> +resultant file descriptor is indistinguishable from one produced by
> +.BR open "(2) with " O_PATH .
> +.PP
> +In the case that the mount object is cloned, the clone will be "unmounted" and
> +destroyed when the file descriptor is closed if it is not otherwise mounted
> +somewhere by calling
> +.BR move_mount (2).
> +.PP
> +To select a mount object, no permissions are required on the object referred
> +to by the path, but execute (search) permission is required on all of the
> +directories in
> +.I pathname
> +that lead to the object.
> +.PP
> +To clone an object, however, the caller must have mount capabilities and
> +permissions.

Can you reword the last sentence in more detail please, explaining
"mount capabilities and permissions".

> +.PP
> +.BR open_tree ()
> +uses
> +.IR pathname ", " dirfd " and " flags
> +to locate the target object in one of a variety of ways:
> +.TP
> +[*] By absolute path.
> +.I pathname
> +points to an absolute path and
> +.I dirfd
> +is ignored.  The object is looked up by name, starting from the root of the
> +filesystem as seen by the calling process.
> +.TP
> +[*] By cwd-relative path.
> +.I pathname
> +points to a relative path and
> +.IR dirfd " is " AT_FDCWD .
> +The object is looked up by name, starting from the current working directory.
> +.TP
> +[*] By dir-relative path.
> +.I pathname
> +points to relative path and
> +.I dirfd
> +indicates a file descriptor pointing to a directory.  The object is looked up
> +by name, starting from the directory specified by
> +.IR dirfd .
> +.TP
> +[*] By file descriptor.
> +.I pathname
> +is "",
> +.I dirfd
> +indicates a file descriptor and
> +.B AT_EMPTY_PATH
> +is set in
> +.IR flags .
> +The mount attached to the file descriptor is queried directly.  The file
> +descriptor may point to any type of file, not just a directory.
> +

Manual page source should in general never contain blank lines; these
can cause odd renderings in various formats (e.g., PDF). Could you
please fix this in all pages.

> +.\"______________________________________________________________

Please delete the above line.

> +.PP
> +.I flags
> +can be used to control the operation of the function and to influence a
> +path-based lookup.  A value for
> +.I flags
> +is constructed by OR'ing together zero or more of the following constants:
> +.TP
> +.BR AT_EMPTY_PATH
> +.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
> +If
> +.I pathname
> +is an empty string, operate on the file referred to by
> +.IR dirfd
> +(which may have been obtained from
> +.BR open "(2) with"
> +.BR O_PATH ", from " fsmount (2)
> +or from another
> +.BR open_tree ()).
> +If
> +.I dirfd
> +is
> +.BR AT_FDCWD ,
> +the call operates on the current working directory.
> +In this case,
> +.I dirfd
> +can refer to any type of file, not just a directory.
> +This flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
> +.TP
> +.BR AT_NO_AUTOMOUNT
> +Don't automount the terminal ("basename") component of

Better: s/terminal/final/

> +.I pathname
> +if it is a directory that is an automount point.  This flag allows the
> +automount point itself to be picked up or a mount cloned that is rooted on the
> +automount point.  The
> +.B AT_NO_AUTOMOUNT
> +flag has no effect if the mount point has already been mounted over.
> +This flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
> +.TP
> +.B AT_SYMLINK_NOFOLLOW
> +If
> +.I pathname
> +is a symbolic link, do not dereference it: instead pick up or clone a mount
> +rooted on the link itself.
> +.TP
> +.B OPEN_TREE_CLOEXEC
> +Set the close-on-exec flag for the new file descriptor.  This will cause the
> +file descriptor to be closed automatically when a process exec's.
> +.TP
> +.B OPEN_TREE_CLONE
> +Rather than directly attaching the selected object to the file descriptor,
> +clone the object, set the root of the new mount object to that point and
> +attach the clone to the file descriptor.
> +.TP
> +.B AT_RECURSIVE
> +This is only permitted in conjunction with OPEN_TREE_CLONE.  It causes the
> +entire mount subtree rooted at the selected spot to be cloned rather than just
> +that one mount object.
> +
> +

Remove the blank lines above please.

> +.SH EXAMPLE

The standard section order for manual pages (see man-pages(7)) is:
           NAME
           SYNOPSIS
           DESCRIPTION
           RETURN VALUE
           ERRORS
           VERSIONS
           CONFORMING TO
           NOTES
           BUGS
           EXAMPLES
           SEE ALSO

Could you move this section to just above SEE ALSO please (and retitle
as EXAMPLES). Presumably this may need fixing in other pages too.

> +The
> +.BR open_tree ()
> +function can be used like the following:
> +.PP
> +.RS
> +.nf
> +fd1 = open_tree(AT_FDCWD, "/mnt", 0);
> +fd2 = open_tree(fd1, "",
> +                AT_EMPTY_PATH | OPEN_TREE_CLONE | AT_RECURSIVE);
> +move_mount(fd2, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.RE
> +.PP
> +This would attach the path point for "/mnt" to fd1, then it would copy the
> +entire subtree at the point referred to by fd1 and attach that to fd2; lastly,
> +it would attach the clone to "/mnt2".
> +
> +

Please remove blank lines.

> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Lines like the above are rather clutter in the page source. I prefer
not to have them. Could you remove in all pages please.

> +.SH RETURN VALUE
> +On success, the new file descriptor is returned.  On error, \-1 is returned,
> +and
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
> +.I dirfd
> +is not a valid open file descriptor.
> +.TP
> +.B EFAULT
> +.I pathname
> +is NULL or
> +.IR pathname
> +point to a location outside the process's accessible address space.
> +.TP
> +.B EINVAL
> +Reserved flag specified in
> +.IR flags .
> +.TP
> +.B ELOOP
> +Too many symbolic links encountered while traversing the pathname.
> +.TP
> +.B ENAMETOOLONG
> +.I pathname
> +is too long.
> +.TP
> +.B ENOENT
> +A component of
> +.I pathname
> +does not exist, or
> +.I pathname
> +is an empty string and
> +.B AT_EMPTY_PATH
> +was not specified in
> +.IR flags .
> +.TP
> +.B ENOMEM
> +Out of memory (i.e., kernel memory).
> +.TP
> +.B ENOTDIR
> +A component of the path prefix of
> +.I pathname
> +is not a directory or
> +.I pathname
> +is relative and
> +.I dirfd
> +is a file descriptor referring to a file other than a directory.
> +.SH VERSIONS
> +.BR open_tree ()
> +was added to Linux in kernel 4.18.

The version number here is wrong. It's 5.2. I presume this needs to be
fixed in all of the other pages.

> +.SH CONFORMING TO
> +.BR open_tree ()
> +is Linux-specific.
> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR open_tree ()
> +system call; call it using
> +.BR syscall (2).
> +.SH SEE ALSO
> +.BR fsmount (2),
> +.BR move_mount (2),
> +.BR open (2)

Thanks,

Michael

--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
