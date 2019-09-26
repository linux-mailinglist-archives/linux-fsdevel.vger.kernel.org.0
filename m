Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B87BF748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfIZRBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 13:01:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51683 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfIZRBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:01:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so3621120wme.1;
        Thu, 26 Sep 2019 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pW/uWGaE7bNMEfsOi4tJVr90SEqgSV1Za5MlIXTYbVY=;
        b=khzuJx2CmcKxY0oDA1ja5glKR9v2zqGQhA5lZ3LZMziW5D28nWQoq4J3XHh2jIm7Co
         d3X73Jb/rsuRyQclBnOziWZXm8bneFMB53z8TzTTWoKRSP0dlBynWHkP4g+jZLXTu+ev
         XpjoVNc6HnbWqXLY24BOiyyVvCYClUseSHwyl2Wgv5lIzvMwll3zahWmNrcZnSQxKGMf
         TjX/v9SgXZK/hgPKXIophZPSlmuV49Gn/y8bizpZC0rUte0HcBaaIIeYNZ5YBAYwBVMW
         0Xl5VaEccfM4raNfU38J6A7OPcBqjihmfF2VuG4FcxtB0jpM7xHizQ+br1Oc0TX/Ogu2
         Kqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pW/uWGaE7bNMEfsOi4tJVr90SEqgSV1Za5MlIXTYbVY=;
        b=jBl/OIuk/4omDpFr4fQYADjG6iFUHh9xElEQZb0TqHmokwBKs6HoBn++1ivBdS3ax3
         Qq63gIG0udDjvysQ/F1YReW5EKdtNqcPzV+Y9nrkPRqOn5RW1MbsrXRMvMshFkc2boRN
         MJ9IqTYVwHEqgN4BQu9KeerwrxUxI755Vbg+gQK4QabbwwJbDxjqI8IfBKNTRHEcaCHK
         f3DBnB35vpkBc87bYTEca4ID1a4davhZeWvRb2Ee1ZG8Iu8tj10ihwWYg55kQHunGmv9
         dXzNOOUdbd9AqKtFvYQVSABdX2Bmn5sPMiMrWNsUQYQUOjted0RWt8evbsVjcc3ddnEU
         DRRw==
X-Gm-Message-State: APjAAAUp95xpeomvswX1spxUKD/9/fUiqK6pmNmQX8J8BAMuZYWJjITT
        H5qgVRqU7KKNqM78mlIhk2Y=
X-Google-Smtp-Source: APXvYqzXQpsb2NY5D4I5jEPzskqvHAftDGctxyewMKth9Dkb4G3ViHHVUjWQdbubYWF4LCoRSqgT0w==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr3501859wmj.152.1569517290843;
        Thu, 26 Sep 2019 10:01:30 -0700 (PDT)
Received: from localhost.localdomain ([5.102.239.49])
        by smtp.gmail.com with ESMTPSA id t203sm5155459wmf.42.2019.09.26.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:01:30 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH] copy_file_range.2: kernel v5.3 updates
Date:   Thu, 26 Sep 2019 20:01:19 +0300
Message-Id: <20190926170119.10284-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update with all the missing errors the syscall can return, the
behaviour the syscall should have w.r.t. to copies within single
files, etc.

[Amir] updates for final released version.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Michael,

Following update reflects the changes that went into v5.3.
This man page update was initially authored by Dave Chinner and I updated it
to reflect the changed that finally went in.

Most of the changes are introduced by commits:

* 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") - stop
returning -EXDEV for the common case.

* 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return
-EPERM, -ETXTBSY, -EOVERFLOW and short read instead of EINVAL when
offset+length exceeds input file size.

Thanks,
Amir.

 man2/copy_file_range.2 | 89 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 13 deletions(-)

diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
index 2438b63c8..05429b3c9 100644
--- a/man2/copy_file_range.2
+++ b/man2/copy_file_range.2
@@ -42,9 +42,9 @@ without the additional cost of transferring data from the kernel to user space
 and then back into the kernel.
 It copies up to
 .I len
-bytes of data from file descriptor
+bytes of data from the source file descriptor
 .I fd_in
-to file descriptor
+to the target file descriptor
 .IR fd_out ,
 overwriting any data that exists within the requested range of the target file.
 .PP
@@ -74,6 +74,12 @@ is not changed, but
 .I off_in
 is adjusted appropriately.
 .PP
+.I fd_in
+and
+.I fd_out
+can refer to the same file.
+If they refer to the same file, then the source and target ranges are not
+allowed to overlap.
 .PP
 The
 .I flags
@@ -84,6 +90,11 @@ Upon successful completion,
 .BR copy_file_range ()
 will return the number of bytes copied between files.
 This could be less than the length originally requested.
+If the file offset of
+.I fd_in
+is at or past the end of file, no bytes are copied, and
+.BR copy_file_range ()
+returns zero.
 .PP
 On error,
 .BR copy_file_range ()
@@ -93,12 +104,16 @@ is set to indicate the error.
 .SH ERRORS
 .TP
 .B EBADF
-One or more file descriptors are not valid; or
+One or more file descriptors are not valid.
+.TP
+.B EBADF
 .I fd_in
 is not open for reading; or
 .I fd_out
-is not open for writing; or
-the
+is not open for writing.
+.TP
+.B EBADF
+The
 .B O_APPEND
 flag is set for the open file description (see
 .BR open (2))
@@ -106,24 +121,52 @@ referred to by the file descriptor
 .IR fd_out .
 .TP
 .B EFBIG
-An attempt was made to write a file that exceeds the implementation-defined
-maximum file size or the process's file size limit,
-or to write at a position past the maximum allowed offset.
+An attempt was made to write at a position past the maximum file offset the
+kernel supports.
+.TP
+.B EFBIG
+An attempt was made to write a range that exceeds the allowed maximum file size.
+The maximum file size differs between filesystem implementations and can be
+different from the maximum allowed file offset.
+.TP
+.B EFBIG
+An attempt was made to write beyond the process's file size resource limit.
+This may also result in the process receiving a
+.I SIGXFSZ
+signal.
 .TP
 .B EINVAL
-Requested range extends beyond the end of the source file; or the
+The
 .I flags
 argument is not 0.
 .TP
-.B EIO
-A low-level I/O error occurred while copying.
+.B EINVAL
+.I fd_in
+and
+.I fd_out
+refer to the same file and the source and target ranges overlap.
+.TP
+.B EINVAL
+Either
+.I fd_in
+or
+.I fd_out
+is not a regular file.
 .TP
 .B EISDIR
+Either
 .I fd_in
 or
 .I fd_out
 refers to a directory.
 .TP
+.B EOVERFLOW
+The requested source or destination range is too large to represent in the
+specified data types.
+.TP
+.B EIO
+A low-level I/O error occurred while copying.
+.TP
 .B ENOMEM
 Out of memory.
 .TP
@@ -133,13 +176,33 @@ There is not enough space on the target filesystem to complete the copy.
 .B EXDEV
 The files referred to by
 .IR file_in " and " file_out
-are not on the same mounted filesystem.
+are not on the same mounted filesystem (pre Linux 5.3).
+.TP
+.B TXTBSY
+Either
+.I fd_in
+or
+.I fd_out
+refers to an active swap file.
+.TP
+.B EPERM
+.I fd_out
+refers to an immutable file.
+.TP
 .SH VERSIONS
 The
 .BR copy_file_range ()
 system call first appeared in Linux 4.5, but glibc 2.27 provides a user-space
 emulation when it is not available.
 .\" https://sourceware.org/git/?p=glibc.git;a=commit;f=posix/unistd.h;h=bad7a0c81f501fbbcc79af9eaa4b8254441c4a1f
+.PP
+A major rework of the kernel implementation occurred in 5.3.
+Areas of the API that weren't clearly defined were clarified and the API bounds
+are much more strictly checked than on earlier kernels.
+Applications should target the behaviour and requirements of 5.3 kernels.
+.PP
+First support for cross-filesystem copies was introduced in Linux 5.3.
+Older kernels will return -EXDEV when cross-filesystem copies are attempted.
 .SH CONFORMING TO
 The
 .BR copy_file_range ()
@@ -224,7 +287,7 @@ main(int argc, char **argv)
         }
 
         len \-= ret;
-    } while (len > 0);
+    } while (len > 0 && ret > 0);
 
     close(fd_in);
     close(fd_out);
-- 
2.17.1

