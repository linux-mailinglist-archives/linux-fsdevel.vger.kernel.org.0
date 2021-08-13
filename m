Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893DA3EADDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 02:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhHMAWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 20:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhHMAWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 20:22:38 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF0C061756;
        Thu, 12 Aug 2021 17:22:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w6so13291490oiv.11;
        Thu, 12 Aug 2021 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Y2VX+Uwqbdzwcmd7gjxZibjRQvsMW+xHdGOCRMUhAR4=;
        b=i166rBdYB5p5G1m3u8DNN4dJYGpi4y3GlNww97xd2lzdk9Gu9SlF9t5kSUIOn7Qhov
         FUSh1j00WzRS7Z74gH2SoIiaMQN+JniFhMgNWZh2oNddy1B9cZkQOaB2VFqwqRUSaE1l
         Lcs/XpmzofQxiJB3E6rTjxJYIK/jUWTp7lG728wNc2vBMMdFtnmPB8mH0rbxtO6aiRa0
         hJ3AGCsBK2UPHsUXKcGSBwU9x8L2h2sdG7YZV15pr+Z19/+x9fYFtGP7GNGsmkm6Y8rl
         Ww0vlcLIURWZuF4TlAJVuwExdi5GT8+/YqQLGpfGcrXzXQZxvHNVKAX1YOhMPlOyGXCp
         Ba+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Y2VX+Uwqbdzwcmd7gjxZibjRQvsMW+xHdGOCRMUhAR4=;
        b=rNzKrzx1omjvTGRi7GB+1xQVAh32UKeTwhJ4m2nTjhXkpBPo9Qz3swwQS3XmmkfTUZ
         TmRUTUylkSKt4VL35VsJOMIoPmAl1/f7p7MR6WaxtL1N6azTrj/tljxqWuje+/IGHg4N
         BNLDOfRLX/FeaFQChlOEkOyM18PxeImDuzG9jhMb0AI2ZD4OtCy2DIe/LoD9EMtjNq0k
         JZKk86ZdphnKB68QJz/04n72cgMPKbKuJ1npUA/mjxSLwwnVS8JNycbrq4bpaeVVfmos
         Or885zPCrQ9ZDNhZ2MizjlYxIE/UqWh8cwr858HEtkb8d1XNzX1kFCshyPg/WVQus9NJ
         A7JA==
X-Gm-Message-State: AOAM532KVpCGWwfWjHt1T3sXgXoEBXx01+N9mEXu3eCEBNfhryrkBlSf
        UFyWkfCINA9Xeznpy6tpXBlka34Deo0U0BytlRo=
X-Google-Smtp-Source: ABdhPJxd/mjkSohSym+hcG0ZYr6fuHquwpEoZQ7Uy6p0913Aww8mP4AR7w4XtxZXaeXxcr3jz8jd5/io54XBKXYUavg=
X-Received: by 2002:aca:5c57:: with SMTP id q84mr5493929oib.159.1628814132279;
 Thu, 12 Aug 2021 17:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827189767.306468.1803062787718957199.stgit@warthog.procyon.org.uk> <b968aced-c375-4c85-b086-9874d12e07f4@gmail.com>
In-Reply-To: <b968aced-c375-4c85-b086-9874d12e07f4@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 13 Aug 2021 02:22:01 +0200
Message-ID: <CAKgNAkgwvVVSj7RHboUEFXw_Z7j2ErFFRuXTd9VkU8H_MCPwxA@mail.gmail.com>
Subject: Re: [PATCH 3/5] Add manpage for fspick(2)
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

As noted in another mail, I will ping on all of the mails, just to
raise all the patches to the top of the inbox.

Thanks,

Michael

On Thu, 27 Aug 2020 at 13:05, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello David,
>
> On 8/24/20 2:24 PM, David Howells wrote:
> > Add a manual page to document the fspick() system call.
> >
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > ---
> >
> >  man2/fspick.2 |  180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 180 insertions(+)
> >  create mode 100644 man2/fspick.2
> >
> > diff --git a/man2/fspick.2 b/man2/fspick.2
> > new file mode 100644
> > index 000000000..72bf645dd
> > --- /dev/null
> > +++ b/man2/fspick.2
> > @@ -0,0 +1,180 @@
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
> > +.TH FSPICK 2 2020-08-24 "Linux" "Linux Programmer's Manual"
> > +.SH NAME
> > +fspick \- Select filesystem for reconfiguration
> > +.SH SYNOPSIS
> > +.nf
> > +.B #include <sys/types.h>
> > +.B #include <sys/mount.h>
> > +.B #include <unistd.h>
> > +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> > +.PP
> > +.BI "int fspick(int " dirfd ", const char *" pathname ", unsigned int " flags );
> > +.fi
> > +.PP
> > +.IR Note :
> > +There is no glibc wrapper for this system call.
> > +.SH DESCRIPTION
> > +.PP
> > +.BR fspick ()
> > +creates a new filesystem configuration context within the kernel and attaches a
> > +pre-existing superblock to it so that it can be reconfigured (similar to
> > +.BR mount (8)
> > +with the "-o remount" option).  The configuration context is marked as being in
> > +reconfiguration mode and attached to a file descriptor, which is returned to
> > +the caller.  The file descriptor can be marked close-on-exec by setting
> > +.B FSPICK_CLOEXEC
> > +in
> > +.IR flags .
> > +.PP
> > +The target is whichever superblock backs the object determined by
> > +.IR dfd ", " pathname " and " flags .
> > +The following can be set in
> > +.I flags
> > +to control the pathwalk to that object:
> > +.TP
> > +.B FSPICK_SYMLINK_NOFOLLOW
> > +Don't follow symbolic links in the final component of the path.
> > +.TP
> > +.B FSPICK_NO_AUTOMOUNT
> > +Don't follow automounts in the final component of the path.
> > +.TP
> > +.B FSPICK_EMPTY_PATH
> > +Allow an empty string to be specified as the pathname.  This allows
> > +.I dirfd
> > +to specify the target mount exactly.
> > +.PP
> > +After calling fspick(), the file descriptor should be passed to the
> > +.BR fsconfig (2)
> > +system call, using that to specify the desired changes to filesystem and
>
> Better: s/using that/in order/
>
> > +security parameters.
> > +.PP
> > +When the parameters are all set, the
> > +.BR fsconfig ()
> > +system call should then be called again with
> > +.B FSCONFIG_CMD_RECONFIGURE
> > +as the command argument to effect the reconfiguration.
> > +.PP
> > +After the reconfiguration has taken place, the context is wiped clean (apart
> > +from the superblock attachment, which remains) and can be reused to make
> > +another reconfiguration.
> > +.PP
> > +The file descriptor also serves as a channel by which more comprehensive error,
> > +warning and information messages may be retrieved from the kernel using
> > +.BR read (2).
> > +.SS Message Retrieval Interface
> > +The context file descriptor may be queried for message strings at any time by
>
> s/descriptor/descriptor returned by fspick()/
>
> > +calling
> > +.BR read (2)
> > +on the file descriptor.  This will return formatted messages that are prefixed
> > +to indicate their class:
> > +.TP
> > +\fB"e <message>"\fP
> > +An error message string was logged.
> > +.TP
> > +\fB"i <message>"\fP
> > +An informational message string was logged.
> > +.TP
> > +\fB"w <message>"\fP
> > +An warning message string was logged.
> > +.PP
> > +Messages are removed from the queue as they're read and the queue has a limited
> > +depth of 8 messages, so it's possible for some to get lost.
>
> What if there are no pending error messages to retrieve? What does
> read() do in that case? Please add an explanation here.
>
> > +.SH RETURN VALUE
> > +On success, the function returns a file descriptor.  On error, \-1 is returned,
> > +and
> > +.I errno
> > +is set appropriately.
> > +.SH ERRORS
> > +The error values given below result from filesystem type independent errors.
> > +Additionally, each filesystem type may have its own special errors and its own
> > +special behavior.  See the Linux kernel source code for details.
> > +.TP
> > +.B EACCES
> > +A component of a path was not searchable.
> > +(See also
> > +.BR path_resolution (7).)
> > +.TP
> > +.B EFAULT
> > +.I pathname
> > +points outside the user address space.
> > +.TP
> > +.B EINVAL
> > +.I flags
> > +includes an undefined value.
> > +.TP
> > +.B ELOOP
> > +Too many links encountered during pathname resolution.
> > +.TP
> > +.B EMFILE
> > +The system has too many open files to create more.
> > +.TP
> > +.B ENFILE
> > +The process has too many open files to create more.
> > +.TP
> > +.B ENAMETOOLONG
> > +A pathname was longer than
> > +.BR MAXPATHLEN .
>
> MAXPATHLEN is not, I think, a constant known in user space. What is this?
> Should it be PATH_MAX?
>
> > +.TP
> > +.B ENOENT
> > +A pathname was empty or had a nonexistent component.
> > +.TP
> > +.B ENOMEM
> > +The kernel could not allocate sufficient memory to complete the call.
> > +.TP
> > +.B EPERM
> > +The caller does not have the required privileges.
>
> Please note the necessary capability here. Also, there was no mention of
> capabilities/privileges in DESCRIPTION. Should there have been?
>
> > +.SH CONFORMING TO
> > +These functions are Linux-specific and should not be used in programs intended
> > +to be portable.
> > +.SH VERSIONS
> > +.BR fsopen "(), " fsmount "() and " fspick ()
> > +were added to Linux in kernel 5.2.
> > +.SH EXAMPLES
> > +To illustrate the process, here's an example whereby this can be used to
> > +reconfigure a filesystem:
> > +.PP
> > +.in +4n
> > +.nf
> > +sfd = fspick(AT_FDCWD, "/mnt", FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC);
> > +fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> > +fsconfig(sfd, FSCONFIG_SET_STRING, "user_xattr", "false", 0);
> > +fsconfig(sfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
> > +.fi
> > +.in
> > +.PP
> > +.SH NOTES
> > +Glibc does not (yet) provide a wrapper for the
> > +.BR fspick "()"
> > +system call; call it using
> > +.BR syscall (2).
> > +.SH SEE ALSO
> > +.BR mountpoint (1),
> > +.BR fsconfig (2),
> > +.BR fsopen (2),
> > +.BR path_resolution (7),
> > +.BR mount (8)
>
> Thanks,
>
> Michael
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
