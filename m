Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C431514C7B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA2I6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 03:58:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgA2I6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 03:58:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so963859plt.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 00:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+hIC30E3bJyImlYZIee7e+CFPKB9pWQXJ+KV9fgdTQ=;
        b=PsnBsrbwcLVgbUjP3789vu/8BYfFMLg8RX2umDq6dJ+4cxUfClOtUmuyPgTI0g3LOD
         SLu94PZQwo9T0BsFCEDvvVrKiORP0ENQKnuVpJMtchkFdfYVRZp+MVY7sWmilFzE/oa6
         aQc477wukzpz7n6JFwBixzVGQKfEv4FseyTIIx3KWIEAjAAe18EEZ8s2ZubNE9j+DZVK
         KUiRdySKOw6IEb05f6Ca1sJ3Eg8S7WG9ud+fg44czWlGNpDyh5kC9QomWilGNiYPPDRd
         SIzA43SsDzp2k7ilWgzsKYuP9TOTACiGZzLcqJpNsJKJ4Hr5qUOnrFN9VPEHyZ/LfAmW
         L0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+hIC30E3bJyImlYZIee7e+CFPKB9pWQXJ+KV9fgdTQ=;
        b=DYqpru/RqfY5rirnszNllhzwZqb/gk6hsRMT+wWQ9PSCnCZA3ddDNziySelfzsy31T
         Hi9FNccHQb7G11WhT67On4sNmu8ea3/8T18ZObCIbh5dohJDNeIf3cpV2iMWpcgmVvMH
         Mo8ina9JEDBcR+8SooHX6Qi0Ecb8wHYXRAhzpV6kIE5l4E9FBch4BymzbFQmGDjEorfQ
         fHnEZmA5Z6Fl/wlv+K97XcqG+pqdrchlyGDo1q+z5SYRIFKEiVQjn3Y2VPUca3ttLw/K
         mwXxHqu/7/8d/1tAmSRwu1yJrjyU092WXcwSBHqAYiKio5GYZZUBHlnhpQgtsAnsh3Ey
         2Mig==
X-Gm-Message-State: APjAAAUH54JzbBbTzFO0ptfoZFhTwae2w7bnVUuuUsVH9bKx/FVjdTpP
        bhESLVRzSPhfQb4HBMT1Tyct+DqCNfo=
X-Google-Smtp-Source: APXvYqxfQ9jgeN+OG6/H9uT1zi19VUNkWv8hvqKsz1oy2kDg0012roqSSAV5qJm/xeHtWSv62Al1JQ==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr9582581pjw.3.1580288325199;
        Wed, 29 Jan 2020 00:58:45 -0800 (PST)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s131sm1935932pfs.135.2020.01.29.00.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 00:58:44 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>
Subject: [RFC PATCH man-pages] link.2: Document new AT_LINK_REPLACE flag
Date:   Wed, 29 Jan 2020 00:58:28 -0800
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

