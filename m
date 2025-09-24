Return-Path: <linux-fsdevel+bounces-62604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F3B9AAEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354A6188F41D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38131281F;
	Wed, 24 Sep 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="m03d7NDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D393126D5;
	Wed, 24 Sep 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727944; cv=none; b=mAi2lLbjrLnWKxI3bLNv7qX4s6sx4l10hK+dyurCRxOBNOjnwuon3bFB5f2VCZ0NryDcBvq0CSWjHYWFT8SBstUMDAgJ3hSE1mMfGu5NehgP9Y5OYvvHGIHP8AFJiavDE0S3Mhz5F5C1NFIpAZpigbNLGGD79zaElaQREif5L10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727944; c=relaxed/simple;
	bh=ChneMzLle+I19p0Vy3bqIHW0I1w/iBP3d0DvcrDAiis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCCIRib+NssDJOseDfcP77hEGSCR/OZn5Rr7zu3jRH1u1wyxyA7B9haPxmxMAv7RxWBSNNLzmsEr6pOjrpqa0ZS7LEwIG+BcE4QqEsUtPKhPN19IKRQrOYMBJCq8SaHM6C0gr1dCmu4er4TM9EmTlfFqKv1tcODqS/B4zxlGMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=m03d7NDb; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cX1762FwCz9t39;
	Wed, 24 Sep 2025 17:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758727938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGi8kxALXCToQwD2Q26NEL4I+n6LW3bxP7Ez9xNeJ+w=;
	b=m03d7NDbx7o4/0bHDp9o5KauXoldB5cOHtpl6MC/m2e0KDF1SktyXQsBqbTha020zSA5Ei
	68DTrNItfoRf6cqUaD6vWOgP7BCoNjgGzzP7j6gwI5Vhb5iGAnCXMKUJt5nCujLR7VtfMz
	RFlYs+u+nVWmaubhOMvenru+NGGEImMGNSvPWG/OgetVLCfEB967Iu12L3Vabi+IJHGTs8
	UCE10ywzf4Sx3Y2misi/ZeBlFLLR63KG4JMEoJcDOScRSuwKO/9mDlYYFnri86pHht/+Av
	4v9YBPXlzooGvwV2GjRUAWqhXOVK02Pj1HeKonbXUyk2FVuzaXFUyP0iS4mNSQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 25 Sep 2025 01:31:26 +1000
Subject: [PATCH v5 4/8] man/man2/fsmount.2: document "new" mount API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-new-mount-api-v5-4-028fb88023f2@cyphar.com>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
In-Reply-To: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6673; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=ChneMzLle+I19p0Vy3bqIHW0I1w/iBP3d0DvcrDAiis=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRc4bv7/oLh40/6/Uwv9wlvYZ6z8Gyd1cJ+pyv9y9JcH
 mnN2B4s0DGRhUGMi8FSTJFlm59n6Kb5i68kf1rJBjOHlQlkiLRIAwMDAwMLA19uYl6pkY6Rnqm2
 oZ6hoY6RjhEDF6cATLXNKob/+fdj306v1+xKO9+kxJnwnuvEtM0nDl9U7jTi2fPcOepBEsNfiQr
 tDf/ZpwbOe1DLM/2V3CvjFraTG/Xfx06Zdiv0fMYhRgA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4cX1762FwCz9t39

This is loosely based on the original documentation written by David
Howells and later maintained by Christian Brauner, but has been
rewritten to be more from a user perspective (as well as fixing a few
critical mistakes).

Co-authored-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Co-authored-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/fsmount.2 | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/man/man2/fsmount.2 b/man/man2/fsmount.2
new file mode 100644
index 0000000000000000000000000000000000000000..b62850a68443bb8f6178389eb6cb1a5f9029ab30
--- /dev/null
+++ b/man/man2/fsmount.2
@@ -0,0 +1,231 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH fsmount 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+fsmount \- instantiate mount object from filesystem context
+.SH LIBRARY
+Standard C library
+.RI ( libc ,\~ \-lc )
+.SH SYNOPSIS
+.nf
+.B #include <sys/mount.h>
+.P
+.BI "int fsmount(int " fsfd ", unsigned int " flags \
+", unsigned int " attr_flags );
+.fi
+.SH DESCRIPTION
+The
+.BR fsmount ()
+system call is part of
+the suite of file-descriptor-based mount facilities in Linux.
+.P
+.BR fsmount ()
+creates a new detached mount object
+for the root of the new filesystem instance
+referenced by the filesystem context file descriptor
+.IR fsfd .
+A new file descriptor
+associated with the detached mount object
+is then returned.
+In order to create a mount object with
+.BR fsmount (),
+the calling process must have the
+.B \%CAP_SYS_ADMIN
+capability.
+.P
+The filesystem context must have been created with a call to
+.BR fsopen (2)
+and then had a filesystem instance instantiated with a call to
+.BR fsconfig (2)
+with
+.B \%FSCONFIG_CMD_CREATE
+or
+.B \%FSCONFIG_CMD_CREATE_EXCL
+in order to be in the correct state
+for this operation
+(the "awaiting-mount" mode in kernel-developer parlance).
+.\" FS_CONTEXT_AWAITING_MOUNT is the term the kernel uses for this.
+Unlike
+.BR open_tree (2)
+with
+.BR \%OPEN_TREE_CLONE ,
+.BR fsmount ()
+can only be called once
+in the lifetime of a filesystem context
+to produce a mount object.
+.P
+As with file descriptors returned from
+.BR open_tree (2)
+called with
+.BR OPEN_TREE_CLONE ,
+the returned file descriptor
+can then be used with
+.BR move_mount (2),
+.BR mount_setattr (2),
+or other such system calls to do further mount operations.
+This mount object will be unmounted and destroyed
+when the file descriptor is closed
+if it was not otherwise attached to a mount point
+by calling
+.BR move_mount (2).
+(Note that the unmount operation on
+.BR close (2)
+is lazy\[em]akin to calling
+.BR umount2 (2)
+with
+.BR MNT_DETACH ;
+any existing open references to files
+from the mount object
+will continue to work,
+and the mount object will only be completely destroyed
+once it ceases to be busy.)
+The returned file descriptor
+also acts the same as one produced by
+.BR open (2)
+with
+.BR O_PATH ,
+meaning it can also be used as a
+.I dirfd
+argument
+to "*at()" system calls.
+.P
+.I flags
+controls the creation of the returned file descriptor.
+A value for
+.I flags
+is constructed by bitwise ORing
+zero or more of the following constants:
+.RS
+.TP
+.B FSMOUNT_CLOEXEC
+Set the close-on-exec
+.RB ( FD_CLOEXEC )
+flag on the new file descriptor.
+See the description of the
+.B O_CLOEXEC
+flag in
+.BR open (2)
+for reasons why this may be useful.
+.RE
+.P
+.I attr_flags
+specifies mount attributes
+which will be applied to the created mount object,
+in the form of
+.BI \%MOUNT_ATTR_ *
+flags.
+The flags are interpreted as though
+.BR mount_setattr (2)
+was called with
+.I attr.attr_set
+set to the same value as
+.IR attr_flags .
+.BI \%MOUNT_ATTR_ *
+flags which would require
+specifying additional fields in
+.BR mount_attr (2type)
+(such as
+.BR \%MOUNT_ATTR_IDMAP )
+are not valid flag values for
+.IR attr_flags .
+.P
+If the
+.BR fsmount ()
+operation is successful,
+the filesystem context
+associated with the file descriptor
+.I fsfd
+is reset
+and placed into reconfiguration mode,
+as if it were just returned by
+.BR fspick (2).
+You may continue to use
+.BR fsconfig (2)
+with the now-reset filesystem context,
+including issuing the
+.B \%FSCONFIG_CMD_RECONFIGURE
+command
+to reconfigure the filesystem instance.
+.SH RETURN VALUE
+On success, a new file descriptor is returned.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EBUSY
+The filesystem context associated with
+.I fsfd
+is not in the right state
+to be used by
+.BR fsmount ().
+.TP
+.B EINVAL
+.I flags
+had an invalid flag set.
+.TP
+.B EINVAL
+.I attr_flags
+had an invalid
+.BI MOUNT_ATTR_ *
+flag set.
+.TP
+.B EMFILE
+The calling process has too many open files to create more.
+.TP
+.B ENFILE
+The system has too many open files to create more.
+.TP
+.B ENOSPC
+The "anonymous" mount namespace
+necessary to contain the new mount object
+could not be allocated,
+as doing so would exceed
+the configured per-user limit on
+the number of mount namespaces in the current user namespace.
+(See also
+.BR namespaces (7).)
+.TP
+.B ENOMEM
+The kernel could not allocate sufficient memory to complete the operation.
+.TP
+.B EPERM
+The calling process does not have the required
+.B CAP_SYS_ADMIN
+capability.
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux 5.2.
+.\" commit 93766fbd2696c2c4453dd8e1070977e9cd4e6b6d
+.\" commit 400913252d09f9cfb8cce33daee43167921fc343
+glibc 2.36.
+.SH EXAMPLES
+.in +4n
+.EX
+int fsfd, mntfd, tmpfd;
+\&
+fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
+fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC,
+                MOUNT_ATTR_NODEV | MOUNT_ATTR_NOEXEC);
+\&
+/* Create a new file without attaching the mount object */
+tmpfd = openat(mntfd, "tmpfile", O_CREAT | O_EXCL | O_RDWR, 0600);
+unlinkat(mntfd, "tmpfile", 0);
+\&
+/* Attach the mount object to "/tmp" */
+move_mount(mntfd, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPTY_PATH);
+.EE
+.in
+.SH SEE ALSO
+.BR fsconfig (2),
+.BR fsopen (2),
+.BR fspick (2),
+.BR mount (2),
+.BR mount_setattr (2),
+.BR move_mount (2),
+.BR open_tree (2),
+.BR mount_namespaces (7)

-- 
2.51.0


