Return-Path: <linux-fsdevel+bounces-56867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B232B1CB5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E193B2805
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A62BEC59;
	Wed,  6 Aug 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="XemyqhcY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58A2BEC2F;
	Wed,  6 Aug 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502343; cv=none; b=kJ9/vRhheAHXRhGwO672fAZoRXQcyr06aWcMaLmtLRpGACFWAprcAKp4WHu40QvO45R0BXUGngII39ddY9/9QLAvW3ByL8CB/F1KPTrcr004Ju86+2VrAu8wJrnsNdW3fIwDLL/bV/qa3IY0eMF+4BaNfw2+ie5sqRHGAP1D9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502343; c=relaxed/simple;
	bh=4ZTIn9D1X12x6PVrv/yeSTeywK9pERTHMdyG1D3Nf/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/Pjsaml7RFLFICd00fb+HTQfmqe5C7b8UMUruevdBFhii2CeyIHVJJizaQu1qclPFCtylCiQtxT7xXztqUWtxd+NoD90+7Hx4d3uUGYKu1VW1uJf4ErLTML6olT8UUPfdqRZMZSxxn9udgJqTX93wWBEJ1XPcYHFgu8hfSeC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=XemyqhcY; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxyPY5ypWz9tHy;
	Wed,  6 Aug 2025 19:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGG0l/ryQP/CN7FHdoYEHqi+DiEVNG8C3u5jOcNGqmI=;
	b=XemyqhcYqTexIWWZamMQfWk7N+QCUwd9GSGMm3LgCjKT9kDHMIsESjHaLel7OqbgugDFkb
	xAVBdMgKuA/rrQvWY/AUb7++R827qJyUsCVPleNS9vApFoFZbRqZ3NZwrD0ppbd63SF4vV
	lg66YwsFU5E6/Am1ttxnOrePNpv2AO/FUA/jKepOqGVNH4p3O1C1p7e1kfsvOREaWB/cHn
	QHmFKFhEU6hUNZeB7wQSB1bunUFu0DD4AoifbJf1Ewot28y5CFDEDcJy6rlbzLRbcRwacK
	HJEkSaO2YGUr0T5il6dAIbk2mByL7ZJCfYJMXC6awhzFzwkUiI9RHG+4/FYmdw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:44:42 +1000
Subject: [PATCH v2 08/11] open_tree.2: document 'new' mount api
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-new-mount-api-v2-8-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
In-Reply-To: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10424; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=4ZTIn9D1X12x6PVrv/yeSTeywK9pERTHMdyG1D3Nf/o=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntJ+WWHijF7vPSWl+kEfXfVrvz86e61/5uFyBoOUB
 +p5J195dJSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJFEkyMizctI7106+7chl2
 QU8uhhT0nj5oYnOb5V5/e927eayCgfcZ/qnvSnXbo7vIvfRa96riqr8nvrdU3E+RvX/Y8Eq6vMw
 uEX4A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bxyPY5ypWz9tHy

This is loosely based on the original documentation written by David
Howells and later maintained by Christian Brauner, but has been
rewritten to be more from a user perspective (as well as fixing a few
critical mistakes).

Co-developed-by: David Howells <dhowells@redhat.com>
Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/open_tree.2 | 405 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 405 insertions(+)

diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
new file mode 100644
index 000000000000..3d38e27b5254
--- /dev/null
+++ b/man/man2/open_tree.2
@@ -0,0 +1,405 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH open_tree 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+open_tree \- open path or create detached mount object and attach to fd
+.SH LIBRARY
+Standard C library
+.RI ( libc ,\~ \-lc )
+.SH SYNOPSIS
+.nf
+.BR "#include <fcntl.h>" \
+"          /* Definition of " AT_* " constants */"
+.BR "#include <sys/mount.h>"
+.P
+.BI "int open_tree(int " dirfd ", const char *" path ", unsigned int " flags ");"
+.fi
+.SH DESCRIPTION
+The
+.BR open_tree ()
+system call is part of the suite of file descriptor based mount facilities
+in Linux.
+.P
+If
+.I flags
+contains
+.BR \%OPEN_TREE_CLONE ,
+.BR open_tree ()
+creates a detached mount object
+consisting of a bind-mount of the path
+specified by the
+.IR path ,
+and attaches it to a new file descriptor,
+which is then returned.
+The mount object is equivalent to a bind-mount
+that would be created by
+.BR mount (2)
+called with
+.BR MS_BIND ,
+except that it is tied to a file descriptor
+and is not mounted onto the filesystem.
+.P
+As with file descriptors returned from
+.BR fsmount (2),
+the resultant file descriptor can then be used with
+.BR move_mount (2),
+.BR mount_setattr (2),
+or other such system calls
+to do further mount operations.
+This mount object will be unmounted and destroyed
+when the file descriptor is closed
+if it was not otherwise attached to a mount point
+by calling
+.BR move_mount (2).
+.P
+If
+.I flags
+does not contain
+.BR \%OPEN_TREE_CLONE ,
+.BR open_tree ()
+returns a file descriptor
+that is exactly equivalent to
+one produced by
+.BR open (2).
+.P
+In either case, the resultant file descriptor
+acts the same as one produced by
+.BR open (2)
+with
+.BR O_PATH ,
+meaning it can also be used as a
+.I dirfd
+argument to
+"*at()" system calls.
+.P
+As with "*at()" system calls,
+.BR fspick ()
+uses the
+.I dirfd
+argument in conjunction with the
+.I path
+argument to determine the path to operate on, as follows:
+.IP \[bu] 3
+If the pathname given in
+.I path
+is absolute, then
+.I dirfd
+is ignored.
+.IP \[bu]
+If the pathname given in
+.I path
+is relative and
+.I dirfd
+is the special value
+.BR AT_FDCWD ,
+then
+.I path
+is interpreted relative to
+the current working directory
+of the calling process (like
+.BR open (2)).
+.IP \[bu]
+If the pathname given in
+.I path
+is relative,
+then it is interpreted relative to
+the directory referred to by the file descriptor
+.I dirfd
+(rather than relative to
+the current working directory
+of the calling process,
+as is done by
+.BR open (2)
+for a relative pathname).
+In this case,
+.I dirfd
+must be a directory
+that was opened for reading
+.RB ( O_RDONLY )
+or using the
+.B O_PATH
+flag.
+.IP \[bu]
+If
+.I path
+is an empty string,
+and
+.I flags
+contains
+.BR \%AT_EMPTY_PATH ,
+then the file descriptor referenced by
+.I dirfd
+is operated on directly.
+In this case,
+.I dirfd
+can refer to any type of file,
+not just a directory.
+.P
+.I flags
+can be used to control aspects of the path lookup
+and properties of the returned file descriptor.
+A value for
+.I flags
+is constructed by bitwise ORing
+zero or more of the following constants:
+.RS
+.TP
+.B AT_EMPTY_PATH
+If
+.I path
+is an empty string, operate on the file referred to by
+.I dirfd
+(which may have been obtained from
+.BR open (2),
+.BR fsmount(2),
+or from another
+.BR open_tree ()
+call).
+In this case,
+.I dirfd
+can refer to any type of file, not just a directory.
+If
+.I dirfd
+is
+.BR AT_FDCWD ,
+the call operates on the current working directory
+of the calling process.
+This flag is Linux-specific; define
+.B \%_GNU_SOURCE
+to obtain its definition.
+.TP
+.B AT_NO_AUTOMOUNT
+Don't automount the terminal ("basename") component of
+.I path
+if it is a directory that is an automount point.
+This allows the caller to gather attributes of an automount point
+(rather than the location it would mount).
+This flag has no effect if the mount point has already been mounted over.
+This flag is Linux-specific; define
+.B \%_GNU_SOURCE
+to obtain its definition.
+.TP
+.B AT_SYMLINK_NOFOLLOW
+If
+.I path
+is a symbolic link, do not dereference it; instead,
+create either a handle to the link itself
+or a bind-mount of it.
+The resultant file descriptor is indistinguishable from one produced by
+.BR openat (2)
+with
+.BR \%O_PATH | O_NOFOLLLOW .
+.TP
+.B OPEN_TREE_CLOEXEC
+Set the close-on-exec
+.RB ( FD_CLOEXEC )
+flag on the new file descriptor.
+See the description of the
+.B O_CLOEXEC
+flag in
+.BR open (2)
+for reasons why this may be useful.
+.TP
+.B OPEN_TREE_CLONE
+Rather than opening the path as a regular file
+(a-la
+.BR openat (2)),
+create a detached bind-mount mount object
+and attach it to the file descriptor.
+In order to do this operation,
+the calling process must have the
+.BR \%CAP_SYS_ADMIN
+capability.
+.TP
+.B AT_RECURSIVE
+Create a recursive bind-mount of the path
+(a-la
+.BR mount (2)
+with
+.BR MS_BIND | MS_REC ),
+and attach it to the file descriptor.
+This flag is only permitted in conjunction with
+.BR \%OPEN_TREE_CLONE .
+.SH RETURN VALUE
+On success, a new file descriptor is returned.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EACCES
+Search permission is denied for one of the directories
+in the path prefix of
+.IR path .
+(See also
+.BR path_resolution (7).)
+.TP
+.B EPERM
+.I flags
+contains
+.B \%OPEN_TREE_CLONE
+but the calling process does not have the required
+.B CAP_SYS_ADMIN
+capability.
+.TP
+.B EBADF
+.I path
+is relative but
+.I dirfd
+is neither
+.B AT_FDCWD
+nor a valid file descriptor.
+.TP
+.B EFAULT
+.I path
+is NULL
+or a pointer to a location
+outside the calling process's accessible address space.
+.TP
+.B EINVAL
+Invalid flag specified in
+.IR flags .
+.TP
+.B ELOOP
+Too many symbolic links encountered when resolving
+.IR path .
+.TP
+.B ENAMETOOLONG
+.I path
+is longer than
+.BR PATH_MAX .
+.TP
+.B ENOENT
+A component of
+.I path
+does not exist, or is a dangling symbolic link.
+.TP
+.B ENOENT
+.I path
+is an empty string, but
+.B AT_EMPTY_PATH
+is not specified in
+.IR flags .
+.TP
+.B ENOTDIR
+A component of the path prefix of
+.I path
+is not a directory, or
+.I path
+is relative and
+.I dirfd
+is a file descriptor referring to a file other than a directory.
+.TP
+.B ENOSPC
+The "anonymous" mount namespace
+necessary to contain the
+.B \%OPEN_TREE_CLONE
+detached bind-mount mount object
+could not be allocated,
+as doing so would
+exceed the configured per-user limit
+on the number of mount namespaces
+in the current user namespace.
+(See also
+.BR namespaces (7).)
+.TP
+.B ENOMEM
+The kernel could not allocate sufficient memory to complete the operation.
+.TP
+.B EMFILE
+The calling process has too many open files to create more.
+.TP
+.B ENFILE
+The system has too many open files to create more.
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux 5.2.
+.\" commit a07b20004793d8926f78d63eb5980559f7813404
+glibc 2.36.
+.SH NOTES
+.SS Anonymous mount namespaces
+The bind-mount mount objects created by
+.BR open_tree ()
+with
+.B \%OPEN_TREE_CLONE
+are not attached to the mount namespace of the calling process.
+Instead, each mount object is attached to
+a newly allocated "anonymous" mount namespace
+associated with the calling process.
+.P
+One of the side-effects of this is that
+(unlike bind-mounts created with
+.BR mount (2)),
+mount propagation
+(as described in
+.BR mount_namespaces (7))
+will not be applied to bind-mounts created by
+.BR open_tree ()
+until the bind-mount is attached with
+.BR move_mount (2),
+at which point the mount
+will be associated with the mount namespace
+where it was mounted
+and mount propagation will resume.
+.SH EXAMPLES
+The following examples show how
+.BR open_tree ()
+can be used in place of more traditional
+.BR mount (2)
+calls with
+.BR MS_BIND .
+.P
+.in +4n
+.EX
+int srcfd;
+\&
+/* mount --bind /var /mnt */
+mount("/var", "/mnt", NULL, MS_BIND, NULL);
+/* ... is equivalent to ... */
+srcfd = open_tree(AT_FDCWD, "/var", OPEN_TREE_CLONE);
+move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+\&
+/* mount --rbind /var /mnt */
+mount("/var", "/mnt", NULL, MS_BIND|MS_REC, NULL);
+/* ... is equivalent to ... */
+srcfd = open_tree(AT_FDCWD, "/var", OPEN_TREE_CLONE | AT_RECURSIVE);
+move_mount(srcfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+\&
+/* mount --bind /proc/self/fd/100 /proc/self/fd/200/foo */
+mount("/proc/self/fd/100", "/proc/self/fd/200/foo", NULL, MS_BIND, NULL);
+/* ... is equivalent to ... */
+srcfd = open_tree(100, "", AT_EMPTY_PATH | OPEN_TREE_CLONE);
+move_mount(srcfd, "", 200, "foo", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.P
+In addition, you can use the file descriptor returned by
+.BR open_tree ()
+as the
+.I dirfd
+argument to any "*at()" system calls:
+.P
+.in +4n
+.EX
+int dirfd, fd;
+\&
+dirfd = open_tree(AT_FDCWD, "/etc", OPEN_TREE_CLONE);
+fd = openat(dirfd, "passwd", O_RDONLY);
+fchmodat(dirfd, "shadow", 0000, 0);
+close(dirfd);
+close(fd);
+/* The bind-mount is now destroyed. */
+.EE
+.in
+.SH SEE ALSO
+.BR fsconfig (2),
+.BR fsmount (2),
+.BR fsopen (2),
+.BR fspick (2),
+.BR mount (2),
+.BR mount_setattr (2),
+.BR move_mount (2),
+.BR mount_namespaces (7)

-- 
2.50.1


