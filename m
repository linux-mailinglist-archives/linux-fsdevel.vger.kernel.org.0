Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71362E3D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfE2RoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:44:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33367 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfE2Rn7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so2423637wrx.0;
        Wed, 29 May 2019 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WwUXFPt91WsbqtPlQqDtW6uVrMZ3xNSrz8TFzSKWF9s=;
        b=kf/RbiJQg7mY7JWj8U88yy+RrZJtDkshcjme8EVPKqvUbPAssOTDRnNP1VNAJ0h5Gc
         dMWRtByZJr1qKG5Q5uI1w97m56tFxUwmXjOVmyVVC8qlW4dYeec1BKvRZzNLrHr1CNQ0
         5gNMS4EgXXIOzDl+0ogkbeD68WZt6N6Pvg71HoUBeKMJNIcHe4rKQP5qL4ef+hvvCGq3
         nQgv3BPv+/4x5MP6SgimEh+I2+6CkR6rKuaGOJinoqZJXPyZJwyL7jDdmROGnlQ2YoXg
         3KBkdGqgoKoHuXtfwPByykh2zARsr6aaj3dRjfxMGeopSAmzPys3JebTBaKr907nctYO
         +1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WwUXFPt91WsbqtPlQqDtW6uVrMZ3xNSrz8TFzSKWF9s=;
        b=aDtcho74Fc/WehzZZM+QrYOjVhA4gVKRr/vIi/Go5gL5rKISr/qvNOsYK789oyoimF
         ziiGi3W7L6jwhyZqFMfFEtLO9Lp9mQSY4URj2g4EyjZp8dyjyFYzEgOfd7K38wvDCdzP
         TsYUTYMpgy9I0U9SnLNVTlEEKGfyupsFWz9tCMW5GaDuZTGT//Ae3XDh5dWG1AV3Xfyg
         /E/VA2OrPLhKZHTfwoW52KvBjWeWfJeblhyGzDD4M8ZEWczPYwzTC/iGWZFwk2hxzXvg
         SK4hszL72OENbNqWtFzYYIVa/pe0rq/1oLdE8ifk3e3uoYvjISBN3V05VFjnp52JMadU
         ddSQ==
X-Gm-Message-State: APjAAAWmwgpgah5y4p6/RXRnz1ZwIma3MiyRXhX3AzLoim2pvu7J507B
        xNjyYtA+yVsh8GBcM9hAPqs2yXnV2aU=
X-Google-Smtp-Source: APXvYqyiizi1bOIdpKqtlzXoIQKQkDk0I9v+OMY7YcuXQtTDJ6jKNhalBgGr3FYtY4ncHATZsZrOKg==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr45926208wrj.272.1559151834922;
        Wed, 29 May 2019 10:43:54 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:54 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v3 14/13] man-pages: copy_file_range updates
Date:   Wed, 29 May 2019 20:43:18 +0300
Message-Id: <20190529174318.22424-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update with all the missing errors the syscall can return, the
behaviour the syscall should have w.r.t. to copies within single
files, etc.

[Amir] Copying beyond EOF returns zero.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 man2/copy_file_range.2 | 91 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 13 deletions(-)

diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
index 2438b63c8..9f9b081a7 100644
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
@@ -133,13 +176,35 @@ There is not enough space on the target filesystem to complete the copy.
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
+.B EACCES
+The user does not have write permissions for the destination file.
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
@@ -224,7 +289,7 @@ main(int argc, char **argv)
         }
 
         len \-= ret;
-    } while (len > 0);
+    } while (len > 0 && ret > 0);
 
     close(fd_in);
     close(fd_out);
-- 
2.17.1

