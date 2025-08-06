Return-Path: <linux-fsdevel+bounces-56865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE849B1CB51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB71218C504F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0D2BCF45;
	Wed,  6 Aug 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="s3/xhnoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0332BE63F;
	Wed,  6 Aug 2025 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502330; cv=none; b=cRsINy6pE4vk55wo4FBEaEUAXdL48dmvNFmLQz1f3r2roEXJfAEoUPx9O2mnfUknSit40Sq4Sdp/FIdptXFYXwYzs8r7rCP8M3km7D4pzPVYLcIsQUQs2Pn2B6T/b7Y+ZHpqlVn71w19P8R7TtfTjMAMOmoOCm+E5dvouBdCbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502330; c=relaxed/simple;
	bh=YqZDnDozwkdg2Pt9cfjnVWsOPSvNBiSa9IakteYzhAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JljtgjmVFNhBqz8Nngk/588qVPhiPvOXNtJdN5tahtZnREgq4cKLoe/nS4tMAfDVZRpKiEUGFt0LarisCMmj0/1sX6nL+WM8ecntl8qctSGLW7TFTGp4gEF0NBr02PNbFUOv1wGEEdD2mfY+4yOxlHKvvCLBR/CCZTnTJbP+y2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=s3/xhnoQ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxyPK2Ptbz9sqy;
	Wed,  6 Aug 2025 19:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65WnrfSaWXYag9/vDU51p8WBVUnXfx9dXJMQvrHv3n4=;
	b=s3/xhnoQHjejYLINY3tFUo1r3yp+9IVKvLppN39/z41ebXkoVFeQjiLzesIMIaqlc8XShR
	BuEVUJsiqhQ7TpG43IFVz5YdDiaaByri+Ffz9fXeCLGhyvl4zK4nhWk9C2RKNmxBuQrP9T
	hGuc1IthBEcFeeza6XIexbuuS19UedOurv1bic03xqmIHrFGz6OYEjEhZ9wnyxYz1uYdQz
	M9wSpCcD/ATJiLY1//rKev6ZIqqqxku7ogskC9iJlIm9/qlwhdWiWrhvzUgJZkBxDLIhWJ
	XvS/NXejXsY21+TzethlRpIWcP66I5K3cdRyWiTC+coIlfLnCodJoFkO75A0ug==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:44:40 +1000
Subject: [PATCH v2 06/11] fsmount.2: document 'new' mount api
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-new-mount-api-v2-6-558a27b8068c@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5778; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=YqZDnDozwkdg2Pt9cfjnVWsOPSvNBiSa9IakteYzhAk=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntKeLXusdOXMsl+cGhncerJ+m2etCS4pfjHx6LKiB
 +sUvc5/7yhlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATmRPE8D/kz/xfDvOld5Xv
 zHoaNrl69nLGJU5Rj1rsLLR90q5rnMpl+B/WYrj6h9+9YMNts49W5PPUymq3XNaff7DFZb7JdF+
 mEhYA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bxyPK2Ptbz9sqy

This is loosely based on the original documentation written by David
Howells and later maintained by Christian Brauner, but has been
rewritten to be more from a user perspective (as well as fixing a few
critical mistakes).

Co-developed-by: David Howells <dhowells@redhat.com>
Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/fsmount.2 | 209 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/man/man2/fsmount.2 b/man/man2/fsmount.2
new file mode 100644
index 000000000000..8c264c3d5aba
--- /dev/null
+++ b/man/man2/fsmount.2
@@ -0,0 +1,209 @@
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
+.BR "#include <sys/mount.h>"
+.P
+.BI "int fsmount(int " fsfd ", unsigned int " flags ", \
+unsigned int " attr_flags ");"
+.fi
+.SH DESCRIPTION
+The
+.BR fsmount ()
+system call is part of the suite of file descriptor based mount facilities
+in Linux.
+.P
+.BR fsmount ()
+takes the created filesystem instance
+referenced by the filesystem context
+associated with the file descriptor
+.I fsfd
+and creates a new mount object
+for the root of the filesystem instance,
+which is then attached to a new file descriptor
+and returned.
+In order to create a mount object with
+.BR fsmount (),
+the calling process must have the
+.BR \%CAP_SYS_ADMIN
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
+for this operation.
+.P
+As with file descriptors returned from
+.BR open_tree (2)
+called with
+.BR OPEN_TREE_CLONE ,
+the returned file descriptor
+can then be used with
+.BR move_mount (2),
+.BR mount_setattr (2),
+or other such system calls
+to do further mount operations.
+This mount object will be unmounted and destroyed
+when the file descriptor is closed
+if it was not otherwise mounted somewhere else
+by calling
+.BR move_mount (2).
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
+specifies the mount attributes
+for the created mount object
+and accepts the same set of
+.BI \%MOUNT_ATTR_ *
+flags as
+.BR mount_setattr (2),
+except for flags such as
+.B \%MOUNT_ATTR_IDMAP
+which require specifying additional fields in
+.BR mount_attr (2type).
+.P
+If the
+.BR fsmount ()
+operation is successful,
+the filesystem context
+associated with the file descriptor
+.I fsfd
+is reset
+and placed into a reconfiguration state,
+similar to the one produced by
+.BR fspick (2).
+You may coninue to use
+.BR fsconfig (2)
+with the
+.B \%FSCONFIG_CMD_RECONFIGURE
+command
+to reconfigure the filesystem instance.
+.P
+Unlike
+.BR open_tree (2),
+.BR fsmount ()
+can only be called once
+to produce a mount object
+for a given filesystem configuration context.
+.SH RETURN VALUE
+On success, a new file descriptor is returned.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EBUSY
+The filesystem context attached to
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
+.B EPERM
+The calling process does not have the required
+.B CAP_SYS_ADMIN
+capability.
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux 5.2.
+.\" commit 93766fbd2696c2c4453dd8e1070977e9cd4e6b6d
+glibc 2.36.
+.SH EXAMPLES
+.in +4n
+.EX
+int fsfd, mntfd, tmpfd;
+\&
+fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
+fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV | MOUNT_ATTR_NOEXEC);
+\&
+/* Create a new file without attaching the mount object. */
+int tmpfd = openat(mntfd, "tmpfile", O_CREAT | O_EXCL | O_RDWR, 0600);
+unlinkat(mntfd, "tmpfile", 0);
+\&
+/* Attach the mount object to "/tmp". */
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
+

-- 
2.50.1


