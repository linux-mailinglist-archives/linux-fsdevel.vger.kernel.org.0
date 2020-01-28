Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE414C377
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgA1XTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:19:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36056 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1XTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:19:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so3669224pfv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+hIC30E3bJyImlYZIee7e+CFPKB9pWQXJ+KV9fgdTQ=;
        b=gKXWzx47Itl3gyqzqaIo8pw9z3Yz3S6WqyK9L1kap/q/vFR/FFQrrDUV5mUYeuATvV
         0zyrSpa2mgEKorDPJDC++Rw1JG+7utGGvstK7+FIriCncgCAYcD/LYgd3FjyvX1k0gnT
         S1mkpH1VNQ1/HVfwkh/6rfKdGb/JRFLlUfgKc9ek4txeIDLHC6Om4ZHxXZHO2mToMGGp
         QUYaq9USTyoSRMdTAoxHJi1IHb1cs8YQCL62MPYq3qjCjhyV4VFX0+weM1+4pKhF6NpH
         jy/sWSv5yAnXd+nIXhzoaD++xCHV0Wt4dMeX1MR5NPtGMEuWHnymSIYo4yG4+MX+tVqP
         7AKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+hIC30E3bJyImlYZIee7e+CFPKB9pWQXJ+KV9fgdTQ=;
        b=EIkfIBlwOx1dA7pqcXBxXcjiytslYTiuNehJ37P32r0g5rQdvfaRhlmuCTCv+JatkP
         MxGE2qUtrc5hrZHJ7FBO/7lXyzsBUDcOkh32DETswdyuLiTLSW8pdV8PqLPY8fcXQ8OF
         /sL6ones5TVyHoxO3wxaAwMlFhnh1q3K8QMUeoMtHAjDRdYeUkWfKU64AEm/PeZLNhiV
         bES+MV14kNOPMSt3N5QmstIK+AptxdwaKMa1D4vUZxerl2Ukh2s2lPiHn/cLPxU5UKh9
         x53zJE/0ok/FqhZk+eaTidsex8CiFtJgJKem1WQTQVCGVDGtMJ0KAcw4o7RpprEPLjIF
         gQaQ==
X-Gm-Message-State: APjAAAWKy0ekCklk+Vyyb30UYydWtK5JRcT73hfSWo2KURd8D4XwA/Yh
        ritfHixQ3dhGpTDgN2XBC5ncy8FprDk=
X-Google-Smtp-Source: APXvYqyEiu6hViVgFwy3wWMUPnVHNktYxg5XSBnAOSAEiYQDnPT0p4YzV/jJn5hw+nBLZKE6WTkL1g==
X-Received: by 2002:aa7:9908:: with SMTP id z8mr5989675pff.68.1580253551266;
        Tue, 28 Jan 2020 15:19:11 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::43a7])
        by smtp.gmail.com with ESMTPSA id p24sm156353pgk.19.2020.01.28.15.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:19:10 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com
Subject: [RFC PATCH man-pages] link.2: Document new AT_LINK_REPLACE flag
Date:   Tue, 28 Jan 2020 15:18:57 -0800
Message-Id: <8480e876e2810afb0485a080ce1cef182f86967f.1580253342.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 man2/link.2 | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/man2/link.2 b/man2/link.2
index 649ba00c7..0097e3071 100644
--- a/man2/link.2
+++ b/man2/link.2
@@ -174,6 +174,60 @@ like this:
 linkat(AT_FDCWD, "/proc/self/fd/<fd>", newdirfd,
        newname, AT_SYMLINK_FOLLOW);
 .EE
+.TP
+.BR AT_LINK_REPLACE " (since Linux 5.7)"
+If
+.I newpath
+exists, replace it atomically.
+There is no point at which another process attempting to access
+.I newpath
+will find it missing.
+If
+.I newpath
+exists but the operation fails,
+the original entry specified by
+.I newpath
+will remain in place.
+This does not guarantee data integrity;
+see EXAMPLE below for how to use this for crash-safe file replacement with
+.BR O_TMPFILE .
+.IP
+If
+.I newpath
+is replaced,
+any other hard links referring to the original file are unaffected.
+Open file descriptors for
+.I newpath
+are also unaffected.
+.IP
+.I newpath
+must not be a directory.
+.IP
+If the entry specified by
+.I newpath
+refers to the file specified by
+.I oldpath,
+.BR linkat ()
+does nothing and returns a success status.
+Note that this comparison does not follow mounts on
+.IR newpath .
+.IP
+Otherwise,
+.I newpath
+must not be a mount point in the local namespace.
+If it is a mount point in another namespace and the operation succeeds,
+all mounts are detached from
+.I newpath
+in all namespaces, as is the case for
+.BR rename (2),
+.BR rmdir (2),
+and
+.BR unlink (2).
+.IP
+If
+.I newpath
+refers to a symbolic link,
+the link will be replaced.
 .in
 .PP
 Before kernel 2.6.18, the
@@ -293,10 +347,34 @@ or
 .I newdirfd
 is not a valid file descriptor.
 .TP
+.B EBUSY
+.B AT_LINK_REPLACE
+was specified in
+.IR flags ,
+.I newpath
+does not refer to the file specified by
+.IR oldpath ,
+and
+.I newpath
+is in use by the system
+(for example, it is a mount point in the local namespace).
+.TP
 .B EINVAL
 An invalid flag value was specified in
 .IR flags .
 .TP
+.B EINVAL
+The filesystem does not support one of the flags in
+.IR flags .
+.TP
+.B EISDIR
+.B AT_LINK_REPLACE
+was specified in
+.I flags
+and
+.I newpath
+refers to an existing directory.
+.TP
 .B ENOENT
 .B AT_EMPTY_PATH
 was specified in
@@ -344,6 +422,31 @@ was specified in
 is an empty string, and
 .IR olddirfd
 refers to a directory.
+.TP
+.B EPERM
+.B AT_LINK_REPLACE
+was specified in
+.I flags
+and
+.I newpath
+refers to an immutable or append-only file
+or a file in an immutable or append-only directory.
+(See
+.BR ioctl_iflags (2).)
+.TP
+.BR EPERM " or " EACCES
+.B AT_LINK_REPLACE
+was specified in
+.IR flags ,
+the directory containing
+.I newpath
+has the sticky bit
+.RB ( S_ISVTX )
+set, and the process's effective UID is neither the UID of the file to
+be deleted nor that of the directory containing it, and
+the process is not privileged (Linux: does not have the
+.B CAP_FOWNER
+capability).
 .SH VERSIONS
 .BR linkat ()
 was added to Linux in kernel 2.6.16;
@@ -421,6 +524,94 @@ performs the link creation and dies before it can say so.
 Use
 .BR stat (2)
 to find out if the link got created.
+.SH EXAMPLE
+The following program demonstrates the use of
+.BR linkat ()
+with
+.B AT_LINK_REPLACE
+and
+.BR open (2)
+with
+.B O_TMPFILE
+for crash-safe file replacement.
+.SS Example output
+.in +4n
+.EX
+$ \fBecho bar > foo\fP
+$ \fB./replace foo\fP
+$ \fBcat foo\fP
+hello, world
+.EE
+.in
+.SS Program source (replace.c)
+.EX
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <libgen.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+int
+main(int argc, char *argv[])
+{
+	char *path, *dirc, *basec, *dir, *base;
+	int fd, dirfd;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s PATH\en", argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	path = argv[1];
+
+	dirc = strdup(path);
+	basec = strdup(path);
+	if (!dirc || !basec) {
+		perror("strdup");
+		exit(EXIT_FAILURE);
+	}
+	dir = dirname(dirc);
+	base = basename(basec);
+
+	/* Open the parent directory. */
+	dirfd = open(dir, O_DIRECTORY | O_RDONLY);
+	if (dirfd == -1) {
+		perror("open");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Open a temporary file, write data to it, and persist it. */
+	fd = open(dir, O_TMPFILE | O_RDWR, 0644);
+	if (fd == -1) {
+		perror("open");
+		exit(EXIT_FAILURE);
+	}
+	if (write(fd, "hello, world\en", 13) == -1) {
+		perror("write");
+		exit(EXIT_FAILURE);
+	}
+	if (fsync(fd) == -1) {
+		perror("fsync");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Replace the original file and persist the directory. */
+	if (linkat(fd, "", dirfd, base, AT_EMPTY_PATH | AT_LINK_REPLACE) == -1) {
+		perror("linkat");
+		exit(EXIT_FAILURE);
+	}
+	if (fsync(dirfd) == -1) {
+		perror("fsync");
+		exit(EXIT_FAILURE);
+	}
+
+	exit(EXIT_SUCCESS);
+}
+.EE
 .SH SEE ALSO
 .BR ln (1),
 .BR open (2),
-- 
2.25.0

