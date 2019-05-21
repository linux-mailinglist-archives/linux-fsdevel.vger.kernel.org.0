Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB3A247A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 07:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfEUFxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 01:53:05 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37340 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfEUFxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 01:53:04 -0400
Received: by mail-yw1-f67.google.com with SMTP id 186so6852429ywo.4;
        Mon, 20 May 2019 22:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uK0emkVrsqGKeKCiH2odgGuk2wkMBSrXqKthY8RV7To=;
        b=iZ1mSfiSQWFrm2ofUptWw5Ut1AEwOK0wT9dJ+SY1icUbRs1Kw/a2fVQd5m1diS/z3J
         obXO4vmQrmm4ziVe8AjJYb8VEKlH8RV4aq4TtUKp29Xlvq1cPfgBly+1dBUl2hBe8iQg
         LPkweMDY3cU7wRyjjmuolWFuf46pH3Vugbv9RUHklIotqaAkYN8dtjj2IM5hMEbJE+b4
         1fIVnegYI1wksFEmkU0Y85tr1+6JVs6cbiW+80GgYbNuZPBKpJSLlC4jDbeWLm3auiam
         l+MQOPZU+20sudmcvBoCZUiASSNSxzFAvvFnvSnNUgBoD4I3C5cgxk889NbkuMNEjtIG
         TV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uK0emkVrsqGKeKCiH2odgGuk2wkMBSrXqKthY8RV7To=;
        b=AYfZ3YuPJaGPVXscqntdltJj4ABPLILfJUBk+YFQSdn/xe7tV68tD/JZ0thYzy/jGF
         R0dAU9TNZlDhnE6XjJ1tpgg0h8+D4hv+crAsdTxfgpFVN3YZE4NvbD/BPZesqMRMRwTP
         r7EUWcWNg0aZhWOeuQm4/JO0L4nHCVc+cmmeIgJjZqVTnA6Z8OIU6I+lnTLa9re1c6bJ
         e/d6OCSbjUs+JeZll/IXflIXp/u/uvgXNljte9z5LJRFA17t6lQWL26HL95lQalgFvbk
         QcvN2yl7F2Vh/tpCXAb5J6V2x31ftI031b0ZdFlCuc6TOFjzdXx62QKqnhNjCvxw1pDB
         qsRA==
X-Gm-Message-State: APjAAAXGpEwceRP43Pw8enwDxAe2W0zAu/JKmPy9et1iqaNHm+6TW/AZ
        Ff7qlIAgAs5W/kW9ETyJW2TTZl2KgU3ZwLb+eoA=
X-Google-Smtp-Source: APXvYqxBP8n4T+H5UZSoNTkjwpChzWPd5ZPM8sapnzQurKHQZ8lxQHkTjj4jNN/P7vZwXPfz4s4jHh64BZqSFh+XvEw=
X-Received: by 2002:a81:3344:: with SMTP id z65mr5808059ywz.294.1558417983731;
 Mon, 20 May 2019 22:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181203083416.28978-1-david@fromorbit.com> <20181203083952.GC6311@dastard>
In-Reply-To: <20181203083952.GC6311@dastard>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 May 2019 08:52:52 +0300
Message-ID: <CAOQ4uxgeMJWBQn-WRUuqb=Dok4tZ8VBCKusGNLU-MYWGedm89A@mail.gmail.com>
Subject: Re: [PATCH 12/11] man-pages: copy_file_range updates
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        ceph-devel@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 3, 2018 at 10:40 AM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Update with all the missing errors the syscall can return, the
> behaviour the syscall should have w.r.t. to copies within single
> files, etc.

Below are the changes I have made to V2 of this man-page update in accordance to
agreed change of behavior (i.e. short copy up to EOF).

This is a heads up before posting to verify my interpretation is correct.
I still have more testing to do before posting.

The main thing is adding:
 .BR copy_file_range ()
 will return the number of bytes copied between files.
 This could be less than the length originally requested.
+If the file offset of
+.I fd_in
+is at or past the end of file, no bytes are copied, and
+.BR copy_file_range ()
+returns zero.

But see also other changes below...

>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  man2/copy_file_range.2 | 94 +++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 77 insertions(+), 17 deletions(-)
>
> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> index 20374abb21f0..23b00c2f3fea 100644
> --- a/man2/copy_file_range.2
> +++ b/man2/copy_file_range.2
> @@ -42,9 +42,9 @@ without the additional cost of transferring data from the kernel to user space
>  and then back into the kernel.
>  It copies up to
>  .I len
> -bytes of data from file descriptor
> +bytes of data from the source file descriptor
>  .I fd_in
> -to file descriptor
> +to target file descriptor
>  .IR fd_out ,
>  overwriting any data that exists within the requested range of the target file.
>  .PP
> @@ -74,6 +74,11 @@ is not changed, but
>  .I off_in
>  is adjusted appropriately.
>  .PP
> +.I fd_in
> +and
> +.I fd_out
> +can refer to the same file. If they refer to the same file, then the source and
> +target ranges are not allowed to overlap.
>  .PP
>  The
>  .I flags
> @@ -93,34 +98,73 @@ is set to indicate the error.
>  .SH ERRORS
>  .TP
>  .B EBADF
> -One or more file descriptors are not valid; or
> +One or more file descriptors are not valid.
> +.TP
> +.B EBADF
>  .I fd_in
>  is not open for reading; or
>  .I fd_out
> -is not open for writing; or
> -the
> +is not open for writing.
> +.TP
> +.B EBADF
> +The
>  .B O_APPEND
>  flag is set for the open file description referred to by
>  .IR fd_out .
>  .TP
>  .B EFBIG
> -An attempt was made to write a file that exceeds the implementation-defined
> -maximum file size or the process's file size limit,
> -or to write at a position past the maximum allowed offset.
> +An attempt was made to write at a position past the maximum file offset the
> +kernel supports.

Updated to "...attempt made to read or write..."

> +.TP
> +.B EFBIG
> +An attempt was made to write a range that exceeds the allowed maximum file size.
> +The maximum file size differs between filesystem implemenations and can be
> +different to the maximum allowed file offset.
> +.TP
> +.B EFBIG
> +An attempt was made to write beyond the process's file size resource
> +limit. This may also result in the process receiving a
> +.I SIGXFSZ
> +signal.
>  .TP
>  .B EINVAL
> -Requested range extends beyond the end of the source file; or the

Removed this.

> -.I flags
> -argument is not 0.
> +.I (off_in + len)
> +spans the end of the source file.
>  .TP
> -.B EIO
> -A low-level I/O error occurred while copying.
> +.B EINVAL
> +.I fd_in
> +and
> +.I fd_out
> +refer to the same file and the source and target ranges overlap.
> +.TP
> +.B EINVAL
> +.I fd_in
> +or
> +.I fd_out
> +is not a regular file.
>  .TP
>  .B EISDIR
>  .I fd_in
>  or
>  .I fd_out
>  refers to a directory.
> +.B EINVAL
> +The
> +.I flags
> +argument is not 0.
> +.TP
> +.B EINVAL
> +.I off_in
> +or
> +.I (off_in + len)
> +is beyond the maximum valid file offset.

Removed this. Updated entry for EFBIG with in offset.

> +.TP
> +.B EOVERFLOW
> +The requested source or destination range is too large to represent in the
> +specified data types.
> +.TP
> +.B EIO
> +A low-level I/O error occurred while copying.
>  .TP
>  .B ENOMEM
>  Out of memory.
> @@ -128,16 +172,32 @@ Out of memory.
>  .B ENOSPC
>  There is not enough space on the target filesystem to complete the copy.
>  .TP
> -.B EXDEV
> -The files referred to by
> -.IR file_in " and " file_out

Kept this one with added "(pre Linux 5.3)"

> -are not on the same mounted filesystem.
> +.B TXTBSY
> +.I fd_in
> +or
> +.I fd_out
> +refers to an active swap file.
> +.TP
> +.B EPERM
> +.I fd_out
> +refers to an immutable file.
> +.TP
> +.B EACCES
> +The user does not have write permissions for the destination file.
>  .SH VERSIONS
>  The
>  .BR copy_file_range ()
>  system call first appeared in Linux 4.5, but glibc 2.27 provides a user-space
>  emulation when it is not available.
>  .\" https://sourceware.org/git/?p=glibc.git;a=commit;f=posix/unistd.h;h=bad7a0c81f501fbbcc79af9eaa4b8254441c4a1f
> +.PP
> +A major rework of the kernel implementation occurred in 4.21. Areas of the API
> +that weren't clearly defined were clarified and the API bounds are much more
> +strictly checked than on earlier kernels. Applications should target the
> +behaviour and requirements of 4.21 kernels.
> +.PP
> +First support for cross-filesystem copies was introduced in Linux 4.21. Older
> +kernels will return -EXDEV when cross-filesystem copies are attempted.
>  .SH CONFORMING TO
>  The
>  .BR copy_file_range ()

Updates example loop termination condition to:
         len \-= ret;
-    } while (len > 0);
+    } while (len > 0 && ret > 0);


WIP is available here:
https://github.com/amir73il/man-pages/commits/copy_file_range

Thanks,
Amir.
