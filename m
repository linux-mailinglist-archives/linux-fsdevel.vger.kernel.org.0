Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C02199FCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 22:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgCaUMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 16:12:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38961 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaUMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:12:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so27691335wrt.6;
        Tue, 31 Mar 2020 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RUmPx3cevd5HZrmJAUoNAL0yIpKXpLkOD4yFNFX1yoU=;
        b=npyePQy8NbdBmc1YC1LMGz/bFjU+8XHeYhdTjCxlwuasRIKbBvchVKMttTRkTSRkxZ
         2tbdIV0bW9GOyOWmN577i1quhz9M1+xoSGLzvFpJzCleJyzg2rtXfNvlMxe/FJNZ+05J
         xMvm0UrcFusDPGkNJSr9r2xsTiu7YrafZeW1IMAf4llJ8u8yu7h6HrafmYiEZ0tDr5Zv
         KxRJhAw/m5KAFBL+fpU9g8nUitWHiejc9F/MznGeZ6lmGQljDr3hyCQLEBvpxjX6ebHj
         lc3n9rQPouoYxgidALQ4sfe3U62t1OGba+V/TsSJHwtKaEiBoKa1ZXYuCKo/elh44/x+
         iZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RUmPx3cevd5HZrmJAUoNAL0yIpKXpLkOD4yFNFX1yoU=;
        b=KjkkoNkWF+JvTsPOsAjpv9tiUpjPo7d7bY0WNo/717DTQTxWM1vVCvxCMcKdlqmzQZ
         Uq80Pu1kCItyVuSSFqaqMibqqjFf98whK4X0CnsDNcm9/mwCQcpmTmXjLXFECgdKINKO
         MagokDol9N1dR2s3O07zrCjcMGMapzCg2xTW2VJ3Ys8nVjVNIAxQLlBfIOqtAoDU3CFt
         3kOV5bZaC6TysFB8QtMDDx0aewvZPdSdWqMUwzF7UiATkMWT9WLd/wlVPyJZxP+D0Fm6
         z7nRiZOXHQVF5pFn4gG/F7o49t6dsOdN+Bwb3Rim3F7Osctb8R81K/tgfJ+g3Tpq1de3
         CZgA==
X-Gm-Message-State: ANhLgQ1U3AcNTMwrdtAI/kZkDxb9Tyr17+Iq6AKJxNK10ZzhC6osIsK0
        pw1tXYAHdeUyOgaiB7DoW1YDEqUn
X-Google-Smtp-Source: ADFU+vuu2swnichiks2Lj/ihW0G02ubfVMQczz01OL3K+e+8SgMvcZ+yDC59CMOWBd7lXFOZ5gtvTA==
X-Received: by 2002:adf:ee12:: with SMTP id y18mr21325311wrn.289.1585685519143;
        Tue, 31 Mar 2020 13:11:59 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id m11sm5109328wmf.9.2020.03.31.13.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 13:11:58 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, christian.brauner@ubuntu.com, oleg@redhat.com,
        luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de,
        linux-man <linux-man@vger.kernel.org>
Subject: RFC: pidfd_getfd(2) manual page
To:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200107175927.4558-1-sargun@sargun.me>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <5ea5233c-9247-aa7c-2819-51b7670de127@gmail.com>
Date:   Tue, 31 Mar 2020 22:11:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200107175927.4558-1-sargun@sargun.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Sargun et al.

I've taken a shot at writing a manual page for pidfd_getfd().
I would be happy to receive comments, suggestions for
improvements, etc. The text is as follows (the groff source 
is at the foot of this mail):

NAME
       pidfd_getfd  -  obtain  a  duplicate  of  another  process's  file
       descriptor

SYNOPSIS
       int pidfd_getfd(int pidfd, int targetfd, unsigned int flags);

DESCRIPTION
       The pidfd_getfd() system call allocates a new file  descriptor  in
       the  calling  process.  This new file descriptor is a duplicate of
       an existing file descriptor, targetfd, in the process referred  to
       by the PID file descriptor pidfd.

       The  duplicate  file  descriptor  refers  to  the  same  open file
       description (see open(2)) as the original file descriptor  in  the
       process referred to by pidfd.  The two file descriptors thus share
       file status flags and file offset.  Furthermore, operations on the
       underlying  file  object  (for  example, assigning an address to a
       socket object using bind(2)) can be equally be performed  via  the
       duplicate file descriptor.

       The  close-on-exec  flag  (FD_CLOEXEC; see fcntl(2)) is set on the
       file descriptor returned by pidfd_getfd().

       The flags argument is reserved for future use.  Currently, it must
       be specified as 0.

       Permission  to duplicate another process's file descriptor is gov‐
       erned by a ptrace access mode  PTRACE_MODE_ATTACH_REALCREDS  check
       (see ptrace(2)).

RETURN VALUE
       On  success,  pidfd_getfd() returns a nonnegative file descriptor.
       On error, -1 is returned and errno is set to indicate the cause of
       the error.

ERRORS
       EBADF  pidfd is not a valid PID file descriptor.

       EBADF  targetfd  is  not  an  open  file descriptor in the process
              referred to by pidfd.

       EINVAL flags is not 0.

       EMFILE The per-process limit on the number of open  file  descrip‐
              tors has been reached (see the description of RLIMIT_NOFILE
              in getrlimit(2)).

       ENFILE The system-wide limit on the total number of open files has
              been reached.

       ESRCH  The  process  referred to by pidfd does not exist (i.e., it
              has terminated and been waited on).

VERSIONS
       pidfd_getfd() first appeared in Linux 5.6.

CONFORMING TO
       pidfd_getfd() is Linux specific.

NOTES
       Currently, there is no glibc wrapper for this system call; call it
       using syscall(2).

       For a description of PID file descriptors, see pidfd_open(2).

SEE ALSO
       clone3(2), kcmp(2), pidfd_open(2)

Cheers,

Michael

.\" Copyright (c) 2020 by Michael Kerrisk <mtk.manpages@gmail.com>
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
.\"
.TH PIDFD_GETFD 2 2020-03-31 "Linux" "Linux Programmer's Manual"
.SH NAME
pidfd_getfd \- obtain a duplicate of another process's file descriptor
.SH SYNOPSIS
.nf
.BI "int pidfd_getfd(int " pidfd ", int " targetfd ", unsigned int " flags );
.fi
.SH DESCRIPTION
The
.BR pidfd_getfd ()
system call allocates a new file descriptor in the calling process.
This new file descriptor is a duplicate of an existing file descriptor,
.IR targetfd ,
in the process referred to by the PID file descriptor
.IR pidfd .
.PP
The duplicate file descriptor refers to the same open file description (see
.BR open (2))
as the original file descriptor in the process referred to by
.IR pidfd .
The two file descriptors thus share file status flags and file offset.
Furthermore, operations on the underlying file object
(for example, assigning an address to a socket object using
.BR bind (2))
can be equally be performed via the duplicate file descriptor.
.PP
The close-on-exec flag
.RB ( FD_CLOEXEC ;
see
.BR fcntl (2))
is set on the file descriptor returned by
.BR pidfd_getfd ().
.PP
The
.I flags
argument is reserved for future use.
Currently, it must be specified as 0.
.PP
Permission to duplicate another process's file descriptor
is governed by a ptrace access mode
.B PTRACE_MODE_ATTACH_REALCREDS
check (see
.BR ptrace (2)).
.SH RETURN VALUE
On success,
.BR pidfd_getfd ()
returns a nonnegative file descriptor.
On error, \-1 is returned and
.I errno
is set to indicate the cause of the error.
.SH ERRORS
.TP
.B EBADF
.I pidfd
is not a valid PID file descriptor.
.TP
.B EBADF
.I targetfd
is not an open file descriptor in the process referred to by
.IR pidfd .
.BR 
.TP
.B EINVAL
.I flags
is not 0.
.TP
.B EMFILE
The per-process limit on the number of open file descriptors has been reached
(see the description of
.BR RLIMIT_NOFILE
in
.BR getrlimit (2)).
.TP
.B ENFILE
The system-wide limit on the total number of open files has been reached.
.TP
.B ESRCH
The process referred to by
.I pidfd
does not exist
(i.e., it has terminated and been waited on).
.SH VERSIONS
.BR pidfd_getfd ()
first appeared in Linux 5.6.
.\" commit 8649c322f75c96e7ced2fec201e123b2b073bf09
.SH CONFORMING TO
.BR pidfd_getfd ()
is Linux specific.
.SH NOTES
Currently, there is no glibc wrapper for this system call; call it using
.BR syscall (2).
.PP
For a description of PID file descriptors, see
.BR pidfd_open (2).
.SH SEE ALSO
.BR clone3 (2),
.BR kcmp (2),
.BR pidfd_open (2)

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
