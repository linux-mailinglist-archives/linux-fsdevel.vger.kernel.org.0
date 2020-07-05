Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D12149BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 04:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGECyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 22:54:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:36761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgGECyg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 22:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593917667;
        bh=reH0EM3NY6Dzh9E7fRi/i7PHQ0hoqcBxo1DlEoPOkMo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cTIctHmBEZ6LHTYE3RTelriU8ymGK1YZmDYW3kCUYhY6jaZECIjuxwDCBbwB5dnwg
         6G8AW0ScTcEqom0/JeZvKQse6rKzupOLKAT7hhWsqRdCwqa+ePBLQX8Sphg6TThm4R
         DNg9Fc7M+T9X6sC/UP8olkCCy3+cW/bZwrWwe2AU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([88.152.145.75]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1kYyn12ZH2-00h344; Sun, 05
 Jul 2020 04:54:27 +0200
Subject: Re: [PATCH] readfile.2: new page describing readfile(2)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704140250.423345-5-gregkh@linuxfoundation.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <11638f77-45d2-7f4e-3d85-f4c85c520fb7@gmx.de>
Date:   Sun, 5 Jul 2020 04:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200704140250.423345-5-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:idSjTVJKmjlC0x+Gra2TIrDLnOXstI1xv7959V/kdCeSNHWmZ5v
 NpdueYMylNLm2fXWkwse+TUkQHRxKkgi4qZLyfe31zVtmVldUWqAA6CY4vSBziX3n8+PEaB
 02njDM1A+6h4K6gQEN+VXpc/dVlM244iBTMMsxabnPwW6gNBbY+NrxPiwJwThni4inybJ6j
 lw2TrFG2kTueBNqFG39EQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4k3XspndL5M=:V12+fJGbaekd+uNZAcNV1q
 zCe8O1iL6aLL9HWi1ljRi6tq0mGbQXOGti0VtJLFbaFoMWZ03nympzLbDAAkfDFmoKkfp2Uln
 ORuRzNIQXIOAZHGb1Ch14V8u06f447gln+JmItyEUdS//UpRMV2+DVCzwIQIvkwFOT0wWMNZK
 Mr4wAEb88Tf5IHz5UswesSKHTfmMbrKOlT54X8+vEX8s1G7Zr+daIaVBBTtqVxWemcBmi9KjP
 7EBPAiyOEPZ7Oc0N8gRujvV4Vq8/e+I/CmXsEVCouxGqYNgv40Epqj2FpNO0miGcvhCBW3U5u
 qiNqXty+/xPcjtqV5KCPMuCTonQFVTx2hN+d2rlldumAhYrAtZwgNo8v9npxkEiCTTIprumE+
 /m13nndJc6dxYKiBQDWzcJekWIAqn4h5jwnHbaUQLUyzydHMjH8FCSHN5Wps6ZE7/XkD6hDI/
 Dl1uvtTbir8sLAp7so+b9NFMcBlY+UeGoTHey/Cly10PmtLvnepsKBPw6tyuJvwHMJdIBAF9z
 0ng3vJsgytOPCHczAswFuFa+Ul4OFAYbvP3GPxuJztliWB7Q7slj2KrT2BciJKIq258Rt7+/7
 xQP4ByJ4RCIz5DbJ4SFWWwQJ6jJXfQhpd6r0wFdMqTzdWYoJLydj6m7RDi7GiA3Ki3knc0EBq
 29a2d/d9DPpMh9mPNDYNw6Fq7HJRm6XwdVDqiQdTcpE5+5GSbDNZErvKU4PmtDkKCNy7Rq9QG
 JdnvvUONcCcEg90LNV554QbGlwPg1ICzn0udr81o/sc0SPH65NFq0K3i0gF/M6eKFutVOVXOJ
 1Po7Tt3cveiBSQL1dUmEIurjmBx0mhFqVTrH0IkckxBz6fsBow9T3mwSW+1ZOu29yGrh2nMdf
 y70SVn8kNQh/4IgDhnAjDwFZ66dUhg+D+Ojk7W5oz9h6LcdcC3u6ADQyl7v/R/3cssWugvPCw
 7dbuYjmhY0WqZsJFtYJ2eE9eUCTWfGM9Rgqo0m4ZfM6uHM+q4M1X49vPX+E572I58c4Vve+uC
 2aG3f/v/kTb2GEA0mJOtlk1pd7Uw4Xs9I4qE4LsrD/1aDrbGZpeO70HdV1yhtXWMMugKW4wLx
 qH1PnSyvpATMAmtc2nFsCUeQNUuZHe+eVsy36dlQ9qSIwbMNFXW7H6LxUowfiuMFFMWPa8i1U
 8coDAQC/KoXZWZXU/JxNAGZ0aXnwFjQ1tI5dIKVJ7graH2OP0bLv4xcD9b/zm98GejPraHWnj
 h2GHWA5hq0YAUggS1cF9pFE0W9mqBLSVZY4fKAA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/20 4:02 PM, Greg Kroah-Hartman wrote:
> readfile(2) is a new syscall to remove the need to do the
> open/read/close dance for small virtual files in places like procfs or
> sysfs.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>
> This patch is for the man-pages project, not the kernel source tree
>
>  man2/readfile.2 | 159 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 man2/readfile.2
>
> diff --git a/man2/readfile.2 b/man2/readfile.2
> new file mode 100644
> index 000000000000..449e722c3442
> --- /dev/null
> +++ b/man2/readfile.2
> @@ -0,0 +1,159 @@
> +.\" This manpage is Copyright (C) 2020 Greg Kroah-Hartman;
> +.\"  and Copyright (C) 2020 The Linux Foundation
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of thi=
s
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of t=
his
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume =
no
> +.\" responsibility for errors or omissions, or for damages resulting fr=
om
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work=
.
> +.\" %%%LICENSE_END
> +.\"
> +.TH READFILE 2 2020-07-04 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +readfile \- read a file into a buffer
> +.SH SYNOPSIS
> +.nf
> +.B #include <unistd.h>
> +.PP
> +.BI "ssize_t readfile(int " dirfd ", const char *" pathname ", void *" =
buf \
> +", size_t " count ", int " flags );
> +.fi
> +.SH DESCRIPTION
> +.BR readfile ()
> +attempts to open the file specified by
> +.IR pathname
> +and to read up to
> +.I count
> +bytes from the file into the buffer starting at
> +.IR buf .
> +It is to be a shortcut of doing the sequence of

Just my personal preference for concise language:

It replaces the sequence of

> +.BR open ()
> +and then

%s/and then /, /

> +.BR read ()
> +and then

%s/and then/, and/

> +.BR close ()
> +for small files that are read frequently, such as those in

". It reduces system call overheads especially for small files, like
those in"

readfile() makes sense even if each individual file is only read once,
not frequently.

Below you describe that file up to 2GiB can be read. So readfile() seems
to be a shortcut for larger files too.

> +.B procfs
> +or
> +.BR sysfs .

Executing readfile() generates the same file notification events as said
individual calls (cf. fanotify.7, inotify.7).

> +.PP
> +If the size of file is smaller than the value provided in
> +.I count
> +then the whole file will be copied into
> +.IR buf .
> +.PP
> +If the file is larger than the value provided in
> +.I count
> +then only
> +.I count
> +number of bytes will be copied into
> +.IR buf .
> +.PP
> +The argument
> +.I flags
> +may contain one of the following
> +.IR "access modes" :
> +.BR O_NOFOLLOW ", or " O_NOATIME .
> +.PP
> +If the pathname given in
> +.I pathname
> +is relative, then it is interpreted relative to the directory
> +referred to by the file descriptor
> +.IR dirfd .
> +.PP
> +If
> +.I pathname
> +is relative and
> +.I dirfd
> +is the special value
> +.BR AT_FDCWD ,
> +then
> +.I pathname
> +is interpreted relative to the current working
> +directory of the calling process (like
> +.BR openat ()).
> +.PP
> +If
> +.I pathname
> +is absolute, then
> +.I dirfd
> +is ignored.

readfile() blocks until either the whole file has been read, the buffer
is completely filled, or the system specific limit (see below) has been
reached.

> +.SH RETURN VALUE
> +On success, the number of bytes read is returned.
> +It is not an error if this number is smaller than the number of bytes
> +requested; this can happen if the file is smaller than the number of
> +bytes requested.

"It is not an error ..." is very vague. Are there any other cases where
a file is only partially read and the number of bytes returned is less
then the minimum of buffer size and file size? How would I discover
truncation?

Or can I rely on the call returning either an error or said minimum
number of bytes? In the latter case:

"When reading from a block device this always equals the minimum of the
buffer size specified by 'count', the file size, and the system specific
limit for read.2 calls (see below)."

> +.PP
> +On error, \-1 is returned, and
> +.I errno
> +is set appropriately.
> +.SH ERRORS
> +.TP
> +.B EFAULT
> +.I buf
> +is outside your accessible address space.
> +.TP
> +.B EINTR
> +The call was interrupted by a signal before any data was read; see
> +.BR signal (7).
> +.TP
> +.B EINVAL
> +.I flags
> +was set to a value that is not allowed.
> +.TP
> +.B EIO
> +I/O error.
> +This will happen for example when the process is in a
> +background process group, tries to read from its controlling terminal,
> +and either it is ignoring or blocking

Can we copy the description from read.2 which gives more information or
refer to it?

> +.B SIGTTIN
> +or its process group
> +is orphaned.
> +It may also occur when there is a low-level I/O error
> +while reading from a disk or tape.
> +A further possible cause of
> +.B EIO
> +on networked filesystems is when an advisory lock had been taken
> +out on the file descriptor and this lock has been lost.
> +See the
> +.I "Lost locks"
> +section of
> +.BR fcntl (2)
> +for further details.

EPERM is missing in this section. Cf. fanotify.7.

Best regards

Heinrich

> +.SH CONFORMING TO
> +None, this is a Linux-specific system call at this point in time.
> +.SH NOTES
> +The type
> +.I size_t
> +is an unsigned integer data type specified by POSIX.1.
> +.PP
> +On Linux,
> +.BR read ()
> +(and similar system calls) will transfer at most
> +0x7ffff000 (2,147,479,552) bytes,
> +returning the number of bytes actually transferred.
> +.\" commit e28cc71572da38a5a12c1cfe4d7032017adccf69
> +(This is true on both 32-bit and 64-bit systems.)
> +.SH BUGS
> +None yet!
> +.SH SEE ALSO
> +.BR close (2),
> +.BR open (2),
> +.BR openat (2),
> +.BR read (2),
> +.BR fread (3)
>

