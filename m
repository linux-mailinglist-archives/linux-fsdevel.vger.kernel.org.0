Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6F1985B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgC3Un7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 16:43:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44242 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgC3Un6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:43:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so23302464wrw.11;
        Mon, 30 Mar 2020 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ArkxdX9DeTgpQEB9aUPjFBoR9RMgThJyKdohFIHS6w8=;
        b=QFjGKIEx8filAOHFvTSHeD33qjUIjkG/2fBM4XiAlxYJPO3sat2tGMZeQnb4ATiZ2b
         p6LN+g/ud3AQhrK8esrlnjbP3scj4cE6tp9A2ofy+h1Msou4Cco4kQzxSfejQsKDcoC0
         8CkFjNBpn7bAiff8l4iuZjLHwKlPe4eajx+1ppMrSQB9+RnEH8afGy2yOQVli3e6f4is
         aEEyh2NMCC+QL8wVMbyf6Ez+l3wqkbrahQWPg0MwsKcHKfo7KcTU8XR+/A55S1arHt+P
         jT/G+0b3R/+BD7aVfqSzJMWBoaZIH3SGR8dxTSu5nFFz68mQqFKVolWXoOsrpTJIvkK7
         9oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ArkxdX9DeTgpQEB9aUPjFBoR9RMgThJyKdohFIHS6w8=;
        b=mmWQBr/fAvJRZ9Z4TFT9xBhqXx1/SNykkcYi0oSMkfQPjmfVvO5jvW5IPdy4XDr2jR
         2zCYUGxqmkopMSfI3Z8oxeEhRmq0lf3FLsUiMMKDi0Nu4GnbM5WeVYB9FdwZ8HDFNvD+
         3Rgg49kwBO6WVPdpBBfkHG7b8vGCeTdgK55EDhdhJv8d9vvUo/9cd86Sg6jCUGO6A4kS
         1a0ZdY+vyUKeDFQoO6ZENAQmAdxWbY8EV3uGgp85yxaUrBvWvZlXfVZZtTF3pSRHymf7
         LkjoNDHlUqV+4RNBUsVwJeci+uYzVIZN/l8IV3XY0DbYe4/Gxm7VCLHMxUm34Njv039E
         6YQQ==
X-Gm-Message-State: ANhLgQ1o7qCpL17IxtVtu0APhU3OCUQfldjlYH1k0Hla8qlbO+Fe/Kdc
        Uq2SJLocJp9j+pod4gwq8lu5/c0e
X-Google-Smtp-Source: ADFU+vsfCEY3onxVuy/kTbDNvan1wTg+mk47nEX6mPDwIJFDc69wX90BYGrB8RAf2ozbAHZgu6O7iA==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr10290766wrs.2.1585601035053;
        Mon, 30 Mar 2020 13:43:55 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id j6sm24971482wrb.4.2020.03.30.13.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 13:43:54 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
To:     Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com>
Date:   Mon, 30 Mar 2020 22:43:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200202151907.23587-3-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Aleksa,

On 2/2/20 4:19 PM, Aleksa Sarai wrote:
> Rather than trying to merge the new syscall documentation into open.2
> (which would probably result in the man-page being incomprehensible),
> instead the new syscall gets its own dedicated page with links between
> open(2) and openat2(2) to avoid duplicating information such as the list
> of O_* flags or common errors.
> 
> In addition to describing all of the key flags, information about the
> extensibility design is provided so that users can better understand why
> they need to pass sizeof(struct open_how) and how their programs will
> work across kernels. After some discussions with David Laight, I also
> included explicit instructions to zero the structure to avoid issues
> when recompiling with new headers.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks. I've applied this patch, but also done quite a lot of
editing of the page. The current draft is below (and also pushed 
to Git). Could I ask you to review the page, to see if I injected
any error during my edits.

In addition, I've added a number of FIXMEs in comments
in the page source. Can you please check these, and let me
know your thoughts.

Cheers,

Michael

.\" Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
.\"
.\" %%%LICENSE_START(VERBATIM)
.\" Permission is granted to make and distribute verbatim copies of this
.\" manual provided the copyright notice and this permission notice are
.\" preserved on all copies.
.\"
.\" Permission is granted to copy and distribute modified versions of this
.\" manual under the conditions for verbatim copying, provided that the
.\" entire resulting derived work is distributed under the terms of a
.\" permission notice identical to this one.
.\"
.\" Since the Linux kernel and libraries are constantly changing, this
.\" manual page may be incorrect or out-of-date.  The author(s) assume no
.\" responsibility for errors or omissions, or for damages resulting from
.\" the use of the information contained herein.  The author(s) may not
.\" have taken the same level of care in the production of this manual,
.\" which is licensed free of charge, as they might when working
.\" professionally.
.\"
.\" Formatted or processed versions of this manual, if unaccompanied by
.\" the source, must acknowledge the copyright and authors of this work.
.\" %%%LICENSE_END
.TH OPENAT2 2 2019-12-20 "Linux" "Linux Programmer's Manual"
.SH NAME
openat2 \- open and possibly create a file (extended)
.SH SYNOPSIS
.nf
.B #include <sys/types.h>
.B #include <sys/stat.h>
.B #include <fcntl.h>
.B #include <openat2.h>
.PP
.BI "int openat2(int " dirfd ", const char *" pathname ,
.BI "            struct open_how *" how ", size_t " size ");
.fi
.PP
.IR Note :
There is no glibc wrapper for this system call; see NOTES.
.SH DESCRIPTION
The
.BR openat2 ()
system call is an extension of
.BR openat (2)
and provides a superset of its functionality.
.PP
The
.BR openat2 ()
system call opens the file specified by
.IR pathname .
If the specified file does not exist, it may optionally (if
.B O_CREAT
is specified in
.IR how.flags )
be created.
.PP
As with
.BR openat (2),
if
.I pathname
is a relative pathname, then it is interpreted relative to the
directory referred to by the file descriptor
.I dirfd
(or the current working directory of the calling process, if
.I dirfd
is the special value
.BR AT_FDCWD ).
If
.I pathname
is an absolute pathname, then
.I dirfd
is ignored (unless
.I how.resolve
contains
.BR RESOLVE_IN_ROOT,
in which case
.I pathname
is resolved relative to
.IR dirfd ).
.PP
Rather than taking a single
.I flags
argument, an extensible structure (\fIhow\fP) is passed to allow for
future extensions.
The
.I size
argument must be specified as
.IR "sizeof(struct open_how)" .
.\"
.SS The open_how structure
The
.I how
argument specifies how
.I pathname
should be opened, and acts as a superset of the
.IR flags
and
.IR mode
arguments to
.BR openat (2).
This argument is a pointer to a structure of the following form:
.PP
.in +4n
.EX
struct open_how {
    u64 flags;    /* O_* flags */
    u64 mode;     /* Mode for O_{CREAT,TMPFILE} */
    u64 resolve;  /* RESOLVE_* flags */
    /* ... */
};
.EE
.in
.PP
Any future extensions to
.BR openat2 ()
will be implemented as new fields appended to the above structure,
with a zero value in a new field resulting in the kernel behaving
as though that extension field was not present.
Therefore, the caller
.I must
zero-fill this structure on
initialization.
(See the "Extensibility" section of the
.B NOTES
for more detail on why this is necessary.)
.PP
The fields of the
.I open_how
structure are as follows:
.TP
.I flags
This field specifies
the file creation and file status flags to use when opening the file.
All of the
.B O_*
flags defined for
.BR openat (2)
are valid
.BR openat2 ()
flag values.
.IP
Whereas
.BR openat (2)
ignores unknown bits in its
.I flags
argument,
.BR openat2 ()
returns an error if unknown or conflicting flags are specified in
.IR how.flags .
.TP
.I mode
This field specifies the
mode for the new file, with identical semantics to the
.I mode
argument of
.BR openat (2).
.IP
Whereas
.BR openat (2)
ignores bits other than those in the range
.I 07777
in its
.I mode
argument,
.BR openat2 ()
returns an error if
.I how.mode
contains bits other than
.IR 07777 .
Similarly, an error is returned if
.BR openat2 ()
is called with a non-zero
.IR how.mode
and
.IR how.flags
does not contain
.BR O_CREAT
or
.BR O_TMPFILE .
.TP
.I resolve
This is a bit-mask of flags that modify the way in which
.B all
components of
.I pathname
will be resolved.
(See
.BR path_resolution (7)
for background information.)
.IP
The primary use case for these flags is to allow trusted programs to restrict
how untrusted paths (or paths inside untrusted directories) are resolved.
The full list of
.I resolve
flags is as follows:
.RS
.TP
.B RESOLVE_NO_XDEV
Disallow traversal of mount points during path resolution (including all bind
mounts).
.IP
Applications that employ
this flag are encouraged to make its use configurable (unless it is
used for a specific security purpose), as bind mounts are very widely used by
end-users.
Setting this flag indiscriminately for all uses of
.BR openat2 ()
may result in spurious errors on previously-functional systems.
.\" FIXME I find the "previously-functional systems" in the previous
.\" sentence a little odd (since openat2() ia new sysycall), so I would
.\" like to clarify a little...
.\" Are you referring to the scenario where someone might take an
.\" existing application that uses openat() and replaces the uses
.\" of openat() with openat2()? In which case, is it correct to
.\" understand that you mean that one should not just indiscriminately
.\" add the RESOLVE_NO_XDEV flag to all of the openat2() calls?
.\" If I'm not on the right track, could you point me in the right
.\" direction please.
.TP
.B RESOLVE_NO_SYMLINKS
Disallow resolution of symbolic links during path resolution.
This option implies
.BR RESOLVE_NO_MAGICLINKS .
.IP
If the trailing component (i.e., basename) of
.I pathname
is a symbolic link, and
.I how.flags
contains both
.BR O_PATH
and
.BR O_NOFOLLOW ,
then an
.B O_PATH
file descriptor referencing the symbolic link will be returned.
.IP
Applications that employ
this flag are encouraged to make its use configurable (unless it is
used for a specific security purpose), as symbolic links are very widely used
by end-users.
Setting this flag indiscriminately for all uses of
.BR openat2 ()
may result in spurious errors on previously-functional systems.
.TP
.B RESOLVE_NO_MAGICLINKS
Disallow all magic-link resolution during path resolution.
.IP
If the trailing component (i.e., basename) of
.I pathname
is a magic link, and
.I how.flags
contains both
.BR O_PATH
and
.BR O_NOFOLLOW ,
then an
.B O_PATH
file descriptor referencing the magic link will be returned.
.IP
Magic links are symbolic link-like objects that are most notably found in
.BR proc (5)
(examples include
.IR /proc/[pid]/exe
and
.IR /proc/[pid]/fd/* ).
Due to the potential danger of unknowingly opening these magic links,
it may be
preferable for users to disable their resolution entirely.
.\" FIXME: what specific details in symlink(7) are being referred
.\" by the following sentence? It's not clear.
(See
.BR symlink (7)
for more details.)
.TP
.B RESOLVE_BENEATH
Do not permit the path resolution to succeed if any component of the resolution
is not a descendant of the directory indicated by
.IR dirfd .
This causes absolute symbolic links (and absolute values of
.IR pathname )
to be rejected.
.IP
Currently, this flag also disables magic-link resolution.
However, this may change in the future.
Therefore, to ensure that magic links are not resolved,
the caller should explicitly specify
.BR RESOLVE_NO_MAGICLINKS .
.TP
.B RESOLVE_IN_ROOT
Treat the directory referred to by
.I dirfd
as the root directory while resolving
.IR pathname .
.\" FIXME I found the following hard to understand (in particular, the
.\" meaning of "scoped" is unclear) , and reworded as below. Is it okay?
.\"     Absolute symbolic links and ".." path components will be scoped to
.\"     .IR dirfd .
Absolute symbolic links are interpreted relative to
.IR dirfd .
If a prefix component of
.I pathname
equates to
.IR dirfd ,
then an immediately following
.IR ..
component likewise equates to
.IR dirfd
(just as
.I /..
is traditionally equivalent to
.IR / ).
If
.I pathname
is an absolute path, it is also interpreted relative to
.IR dirfd .
.IP
The effect of this flag is as though the calling process had used
.BR chroot (2)
to (temporarily) modify its root directory (to the directory
referred to by
.IR dirfd ).
However, unlike
.BR chroot (2)
(which changes the filesystem root permanently for a process),
.B RESOLVE_IN_ROOT
allows a program to efficiently restrict path resolution on a per-open basis.
.\" FIXME The next piece is unclear (to me). What kind of ".." escape
.\" attempts does chroot() not detect that RESOLVE_IN_ROOT does?
The
.B RESOLVE_IN_ROOT
flag also has several hardening features
(such as detecting escape attempts during
.I ".."
resolution) which
.BR chroot (2)
does not.
.IP
Currently, this flag also disables magic-link resolution.
However, this may change in the future.
Therefore, to ensure that magic links are not resolved,
the caller should explicitly specify
.BR RESOLVE_NO_MAGICLINKS .
.RE
.IP
If any bits other than those listed above are set in
.IR how.resolve ,
an error is returned.
.SH RETURN VALUE
On success, a new file descriptor is returned.
On error, \-1 is returned, and
.I errno
is set appropriately.
.SH ERRORS
The set of errors returned by
.BR openat2 ()
includes all of the errors returned by
.BR openat (2),
as well as the following additional errors:
.TP
.B E2BIG
An extension that this kernel does not support was specified in
.IR how .
(See the "Extensibility" section of
.B NOTES
for more detail on how extensions are handled.)
.TP
.B EAGAIN
.I how.resolve
contains either
.BR RESOLVE_IN_ROOT
or
.BR RESOLVE_BENEATH ,
and the kernel could not ensure that a ".." component didn't escape (due to a
race condition or potential attack).
The caller may choose to retry the
.BR openat2 ()
call.
.TP
.B EINVAL
An unknown flag or invalid value was specified in
.IR how .
.TP
.B EINVAL
.I mode
is non-zero, but
.I how.flags
does not contain
.BR O_CREAT
or
.BR O_TMPFILE .
.TP
.B EINVAL
.I size
was smaller than any known version of
.IR "struct open_how" .
.TP
.B ELOOP
.I how.resolve
contains
.BR RESOLVE_NO_SYMLINKS ,
and one of the path components was a symbolic link (or magic link).
.TP
.B ELOOP
.I how.resolve
contains
.BR RESOLVE_NO_MAGICLINKS ,
and one of the path components was a magic link.
.TP
.B EXDEV
.I how.resolve
contains either
.BR RESOLVE_IN_ROOT
or
.BR RESOLVE_BENEATH ,
and an escape from the root during path resolution was detected.
.TP
.B EXDEV
.I how.resolve
contains
.BR RESOLVE_NO_XDEV ,
and a path component crosses a mount point.
.SH VERSIONS
.BR openat2 ()
first appeared in Linux 5.6.
.SH CONFORMING TO
This system call is Linux-specific.
.PP
The semantics of
.B RESOLVE_BENEATH
were modeled after FreeBSD's
.BR O_BENEATH .
.SH NOTES
Glibc does not provide a wrapper for this system call; call it using
.BR syscall (2).
.\"
.SS Extensibility
In order to allow for future extensibility,
.BR openat2 ()
requires the user-space application to specify the size of the
.I open_how
structure that it is passing.
By providing this information, it is possible for
.BR openat2 ()
to provide both forwards- and backwards-compatibility, with
.I size
acting as an implicit version number.
(Because new extension fields will always
be appended, the structure size will always increase.)
This extensibility design is very similar to other system calls such as
.BR perf_setattr (2),
.BR perf_event_open (2),
and
.BR clone3 (2).
.PP
If we let
.I usize
be the size of the structure as specified by the user-space application, and
.I ksize
be the size of the structure which the kernel supports, then there are
three cases to consider:
.IP \(bu 2
If
.IR ksize
equals
.IR usize ,
then there is no version mismatch and
.I how
can be used verbatim.
.IP \(bu
If
.IR ksize
is larger than
.IR usize ,
then there are some extension fields that the kernel supports
which the user-space application
is unaware of.
Because a zero value in any added extension field signifies a no-op,
the kernel
treats all of the extension fields not provided by the user-space application
as having zero values.
This provides backwards-compatibility.
.IP \(bu
If
.IR ksize
is smaller than
.IR usize ,
then there are some extension fields which the user-space application
is aware of but which the kernel does not support.
Because any extension field must have its zero values signify a no-op,
the kernel can
safely ignore the unsupported extension fields if they are all-zero.
If any unsupported extension fields are non-zero, then \-1 is returned and
.I errno
is set to
.BR E2BIG .
This provides forwards-compatibility.
.PP
Because the definition of
.I struct open_how
may change in the future (with new fields being added when system headers are
updated), user-space applications should zero-fill
.I struct open_how
to ensure that recompiling the program with new headers will not result in
spurious errors at runtime.
The simplest way is to use a designated
initializer:
.PP
.in +4n
.EX
struct open_how how = { .flags = O_RDWR,
                        .resolve = RESOLVE_IN_ROOT };
.EE
.in
.PP
or explicitly using
.BR memset (3)
or similar:
.PP
.in +4n
.EX
struct open_how how;
memset(&how, 0, sizeof(how));
how.flags = O_RDWR;
how.resolve = RESOLVE_IN_ROOT;
.EE
.in
.PP
A user-space application that wishes to determine which extensions
the running kernel supports can do so by conducting a binary search on
.IR size
with a structure which has every byte nonzero (to find the largest value
which doesn't produce an error of
.BR E2BIG ).
.SH SEE ALSO
.BR openat (2),
.BR path_resolution (7),
.BR symlink (7)

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
