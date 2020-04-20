Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031A41B08B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 14:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDTMFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 08:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgDTMFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:05:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F21CC061A0C;
        Mon, 20 Apr 2020 05:05:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n17so7691613ejh.7;
        Mon, 20 Apr 2020 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6c6O1wwYwJaoqXoO8GZUPNWMilZA1Gv+nhWPnSzgWDc=;
        b=fPcrtHjSQDl8DlVnsTiupNvncJPOAUQouyM35zYWIgk58NT/cChPqhv+kGZmvDDP8c
         h2EYKkE+/F2kMCPxy5geoAXEzSw9ic6eEgNZqmGNK+x+EV5WCL+d3RtQ+qGWG9VGHIiW
         /QsDKSMZA3GpDFU1Ru9TwPzcVup5IXJKAvFqi4jwLjOyW3dkY5nFH8dcH3P2NURKa/Sj
         Tz+KwZ/k8QACD7fvNRASUikLP86VtnAj2yQKqk4WA1LAB04F/7vuQdsb7/leS7ZUgD7J
         /hyrqigki2RleIL3wdWBrU95zKS8ZFCA38t5xT9IS0dgIWEtmFbj21S4o7HZXo6KB3Hp
         r5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6c6O1wwYwJaoqXoO8GZUPNWMilZA1Gv+nhWPnSzgWDc=;
        b=R6kDw9lkdFNNax8c4mTjc9FNoahBc8pzuZCOaq5z4zV1esanXXRLasrwNmTm3GFKi3
         TeXOZA6nj320+e2idEUfZrMK/fHo6qTWqSSRMNd+b9zBMbPZL08jse47LoIPtmFa15l8
         ArD8GCc+UmPcD0lluPdKyPQH58k1995mvbhf87LK08H2mE0+AYcKQ4JTR0vFWfKAI6K9
         AAQsMXe11+6kfy/+yG+LurrthYK5x3XdiHg6AU6KSJjeQ7NPiDnC2iRy9MPgBR5kezrN
         irce+9oh06OO59YlCHLG733ZkyVyBeodpO818INzlhLnpmIXYE/w/XxhYulqsEmXdQXe
         0XjQ==
X-Gm-Message-State: AGi0PubwQhel9WDJEtJ9Is9XjYd7v9nagjIBaggZ1M+YwTfV+AJqPUhY
        8SPi7TDih94qHTo62pIZSw3kFe2Rqg3dtWx3JqM=
X-Google-Smtp-Source: APiQypLVnAYHnuZPZntL2kKg0JfFWH4H2pVuyaSrFdXByBXAiDaZXjiPvVMTApWknOtgqyYYyVtduCDDa2+lgWlaIw8=
X-Received: by 2002:a17:906:add7:: with SMTP id lb23mr16554858ejb.6.1587384308776;
 Mon, 20 Apr 2020 05:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <d2979d75-5e45-b145-9ca5-2c315d8ead9c@redhat.com>
 <708b8e2a-2bc2-df38-ec9c-c605203052b5@sandeen.net> <7d74cc3b-52cc-be60-0a69-1a5ee1499f47@sandeen.net>
In-Reply-To: <7d74cc3b-52cc-be60-0a69-1a5ee1499f47@sandeen.net>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 20 Apr 2020 14:04:57 +0200
Message-ID: <CAKgNAkgLekaA6jBtUYTD2F=7u_GgBbXDvq-jc8RCBswYvvZmtg@mail.gmail.com>
Subject: Re: [PATCH 2/2 V2] man2: New page documenting filesystem get/set
 label ioctls
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Eric,

So it seems like this feature eventually got merged in Linux 4.18. Is
this page up to date with what went into the kernel?

Thanks,

Michael

On Thu, 10 May 2018 at 19:29, Eric Sandeen <sandeen@sandeen.net> wrote:
>
> This documents the proposed new vfs-level ioctls which can
> get or set a mounted filesytem's label.
>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>
> V2: make primary file ioctl_getfslabel, link ioctl_setfslabel to it
>     note that getfslabel requires CAP_SYS_ADMIN
>
> diff --git a/man2/ioctl_getfslabel.2 b/man2/ioctl_getfslabel.2
> new file mode 100644
> index 0000000..2c3375c
> --- /dev/null
> +++ b/man2/ioctl_getfslabel.2
> @@ -0,0 +1,87 @@
> +.\" Copyright (c) 2018, Red Hat, Inc.  All rights reserved.
> +.\"
> +.\" %%%LICENSE_START(GPLv2+_DOC_FULL)
> +.\" This is free documentation; you can redistribute it and/or
> +.\" modify it under the terms of the GNU General Public License as
> +.\" published by the Free Software Foundation; either version 2 of
> +.\" the License, or (at your option) any later version.
> +.\"
> +.\" The GNU General Public License's references to "object code"
> +.\" and "executables" are to be interpreted as the output of any
> +.\" document formatting or typesetting system, including
> +.\" intermediate and printed output.
> +.\"
> +.\" This manual is distributed in the hope that it will be useful,
> +.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
> +.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +.\" GNU General Public License for more details.
> +.\"
> +.\" You should have received a copy of the GNU General Public
> +.\" License along with this manual; if not, see
> +.\" <http://www.gnu.org/licenses/>.
> +.\" %%%LICENSE_END
> +.TH IOCTL-FSLABEL 2 2018-05-02 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +ioctl_fslabel \- get or set a filesystem label
> +.SH SYNOPSIS
> +.br
> +.B #include <sys/ioctl.h>
> +.br
> +.B #include <linux/fs.h>
> +.sp
> +.BI "int ioctl(int " fd ", FS_IOC_GETFSLABEL, char " label [FSLABEL_MAX]);
> +.br
> +.BI "int ioctl(int " fd ", FS_IOC_SETFSLABEL, char " label [FSLABEL_MAX]);
> +.SH DESCRIPTION
> +If a filesystem supports online label manipulation, these
> +.BR ioctl (2)
> +operations can be used to get or set the filesystem label for the filesystem
> +on which
> +.B fd
> +resides.
> +The
> +.B FS_IOC_SETFSLABEL
> +operation requires privilege
> +.RB ( CAP_SYS_ADMIN ).
> +.SH RETURN VALUE
> +On success zero is returned.  On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +.PP
> +.SH ERRORS
> +Error codes can be one of, but are not limited to, the following:
> +.TP
> +.B EINVAL
> +The specified label exceeds the maximum label length for the filesystem.
> +.TP
> +.B ENOTTY
> +This can appear if the filesystem does not support online label manipulation.
> +.TP
> +.B EPERM
> +The calling process does not have sufficient permissions to set the label.
> +.TP
> +.B EFAULT
> +.I label
> +references an inaccessible memory area.
> +.SH VERSIONS
> +These ioctl operations first appeared in Linux 4.18.
> +They were previously known as
> +.B BTRFS_IOC_GET_FSLABEL
> +and
> +.B BTRFS_IOC_SET_FSLABEL
> +and were private to Btrfs.
> +.SH CONFORMING TO
> +This API is Linux-specific.
> +.SH NOTES
> +The maximum string length for this interface is
> +.BR FSLABEL_MAX ,
> +including the terminating null byte (\(aq\\0\(aq).
> +Filesystems have differing maximum label lengths, which may or
> +may not include the terminating null.  The string provided to
> +.B FS_IOC_SETFSLABEL
> +must always be null-terminated, and the string returned by
> +.B FS_IOC_GETFSLABEL
> +will always be null-terminated.
> +.SH SEE ALSO
> +.BR ioctl (2),
> +.BR blkid (8)
> diff --git a/man2/ioctl_setfslabel.2 b/man2/ioctl_setfslabel.2
> new file mode 100644
> index 0000000..2119835
> --- /dev/null
> +++ b/man2/ioctl_setfslabel.2
> @@ -0,0 +1 @@
> +.so man2/ioctl_getfslabel.2
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
