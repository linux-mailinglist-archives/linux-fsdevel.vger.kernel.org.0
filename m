Return-Path: <linux-fsdevel+bounces-74311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC6D3978D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 16:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C252300A87B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6562EBDEB;
	Sun, 18 Jan 2026 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0qyM0TW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDDE2836E;
	Sun, 18 Jan 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750960; cv=none; b=HvFHQs8K/paJ99nWDk1kMAgCdpi6QiSEqSPBoWK/c/4T8vzcC757Gz84GEwWw7T7rJQDk3Em+9FFb/Dht8pwCypE092mia6tq5VflrHtLf3zbL99DxFWlsz9JbjQcaClb2e3MmKijgZuV/00DzpLdee3kA7gYeLYtFVNT/uoZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750960; c=relaxed/simple;
	bh=ZGN+UJM4rb3/rWVdrg86OBf/zo0gqcWknxV59oEbkgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p32O/Gv95oMpx31H95uND73K9GBJR+lCM/1XkCZ1GyQwSSOB0sNFxweptMzc1VXO7IqIiKShLflQlHanfafLQ9c11cj1Lp5WHrMHUWYlnebdTo53BoQDY9+TMsbgJjvaydRitT+cGfjXlHWCbAPyLzcT1WS3j2y8JVfc74VYjq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0qyM0TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA1AC116D0;
	Sun, 18 Jan 2026 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768750960;
	bh=ZGN+UJM4rb3/rWVdrg86OBf/zo0gqcWknxV59oEbkgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0qyM0TWL5kgsmX5+FedJdj30vZycuBY+550lg3mtQqfDYVp30NfPsWA6QkPaY6CL
	 H8zL10SUbjfRzmvCXrfC0MbkFZix7JuFzx/6qrYkv+6Y3E/CIHW8eKf2Y7EFa9eask
	 +v1l5it2LMbEyuJCwk320UzNcGgqUmI38q6oH/CrBGNjs8KF5zU0PdZdC4fMLYg0rG
	 lVyAQ4GeSbOCPr+ZXwIPOW81hcNpT4qa1COCF+PB2x828YVIF76SxfDBklZQdV0qrS
	 p3sS+SJ6DPfhgiHOisYy7uV1O2mjdLC5S4A69ibG1DVGSzbZRLmNcbEuNJaYdLQ3Pw
	 d2NbQJso2dM3g==
Date: Sun, 18 Jan 2026 16:42:37 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH v3] man/man2const/F_[SG]ETDELEG.2const, man/man2/fcntl.2:
 Document F_SETDELEG and F_GETDELEG
Message-ID: <5b283a25dbe2ab9ed78719c132885d9d3157f2bb.1768750908.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-master-v2-0-719f5b47dfe2@kernel.org>

From: Jeff Layton <jlayton@kernel.org>

With Linux 6.19, userland will be able to request a delegation on a file
or directory.  These new objects act a lot like file leases, but are
based on NFSv4 file and directory delegations.

Add new F_GETDELEG and F_SETDELEG manpages to document them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
[alx: minor tweaks]
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man/man2/fcntl.2                |   5 +
 man/man2const/F_GETDELEG.2const | 265 ++++++++++++++++++++++++++++++++
 man/man2const/F_SETDELEG.2const |   1 +
 3 files changed, 271 insertions(+)
 create mode 100644 man/man2const/F_GETDELEG.2const
 create mode 100644 man/man2const/F_SETDELEG.2const

diff --git a/man/man2/fcntl.2 b/man/man2/fcntl.2
index 7f34e332e..f05d559da 100644
--- a/man/man2/fcntl.2
+++ b/man/man2/fcntl.2
@@ -78,6 +78,11 @@ .SS Leases
 .BR F_SETLEASE (2const)
 .TQ
 .BR F_GETLEASE (2const)
+.SS Delegations
+.TP
+.BR F_SETDELEG (2const)
+.TQ
+.BR F_GETDELEG (2const)
 .SS File and directory change notification (dnotify)
 .TP
 .BR F_NOTIFY (2const)
diff --git a/man/man2const/F_GETDELEG.2const b/man/man2const/F_GETDELEG.2const
new file mode 100644
index 000000000..e4d98feed
--- /dev/null
+++ b/man/man2const/F_GETDELEG.2const
@@ -0,0 +1,265 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH F_GETDELEG 2const (date) "Linux man-pages (unreleased)"
+.SH NAME
+F_GETDELEG,
+F_SETDELEG
+\-
+delegations
+.SH LIBRARY
+Standard C library
+.RI ( libc ,\~ \-lc )
+.SH SYNOPSIS
+.nf
+.B #define _GNU_SOURCE
+.B #include <fcntl.h>
+.P
+.BI "int fcntl(int " fd ", F_SETDELEG, const struct delegation *" deleg );
+.BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
+.fi
+.P
+.EX
+struct delegation {
+	__u32  d_flags;
+	__u16  d_type;
+	__u16  __pad;
+};
+.EE
+.SH DESCRIPTION
+.B F_SETDELEG
+and
+.B F_GETDELEG
+are used to establish a new delegation,
+and retrieve the current delegation,
+on the open file description referred to by the file descriptor
+.IR fd .
+.P
+A file delegation is a mechanism whereby
+the process holding the delegation (the "delegation holder")
+is notified (via delivery of a signal)
+when a process (the "delegation breaker")
+tries to
+.BR open (2)
+or
+.BR truncate (2)
+the file referred to by that file descriptor,
+or tries to
+.BR unlink (2)
+or
+.BR rename (2)
+the dentry that was originally opened for the file.
+.P
+Delegations can also be set on directory file descriptors.
+The holder of a directory delegation will be notified if there is a
+create, delete, or rename of a dirent within the directory.
+.TP
+.B F_SETDELEG
+Set or remove a file or directory delegation according to the
+value specified in
+.IR deleg->d_type :
+.RS
+.TP
+.B F_RDLCK
+Establish a read delegation.
+This will cause the calling process to be notified
+when the file is
+opened for writing,
+or is truncated, unlinked or renamed.
+A read delegation can be placed
+only on a file descriptor that is opened read-only.
+.IP
+If
+.I fd
+refers to a directory,
+then the calling process will be notified
+if there are changes to filenames within the directory,
+or when the directory itself is renamed.
+.TP
+.B F_WRLCK
+Establish a write delegation.
+This will cause the caller to be notified when the file is opened for reading or writing,
+or is truncated, renamed or unlinked.
+A write delegation may be placed on a file only if there are no other open file descriptors for the file.
+The file must be opened for write in order to set a write delegation on it.
+Write delegations cannot be set on directory file descriptors.
+.TP
+.B F_UNLCK
+Remove our delegation from the file.
+.RE
+.P
+Like leases,
+delegations are associated with an open file description
+(see
+.BR open (2)).
+This means that duplicate file descriptors
+(created by, for example,
+.BR fork (2)
+or
+.BR dup (2))
+refer to the same delegation,
+and this delegation may be modified or released
+using any of these descriptors.
+Furthermore,
+the delegation is released by either an explicit
+.B F_UNLCK
+operation on any of these duplicate file descriptors,
+or when all such file descriptors have been closed.
+.P
+An unprivileged process may establish a delegation
+only on a file whose UID (owner) matches the filesystem UID of the process.
+A process with the
+.B CAP_LEASE
+capability may establish delegations on arbitrary files and directories.
+.TP
+.B F_GETDELEG
+Indicates what type of delegation is associated with the file descriptor
+.I fd
+by setting
+.I deleg->d_type
+to either
+.BR F_RDLCK ,
+.BR F_WRLCK ,
+or
+.BR F_UNLCK ,
+indicating, respectively,
+a read delegation, a write delegation, or no delegation.
+.P
+When a process (the "delegation breaker")
+performs an activity that conflicts with a delegation
+established via
+.BR F_SETDELEG ,
+the system call is blocked by the kernel
+and the kernel notifies the delegation holder by sending it a signal
+.RB ( SIGIO
+by default).
+The delegation holder should respond to receipt of this signal
+by doing whatever cleanup is required
+in preparation for the file to be
+accessed by another process
+(e.g., flushing cached buffers)
+and then either remove or downgrade its delegation.
+A delegation is removed by performing an
+.B F_SETDELEG
+operation specifying
+.I deleg->d_type
+as
+.BR F_UNLCK .
+If the delegation holder currently holds
+a write delegation on the file,
+and the delegation breaker
+is opening the file for reading,
+then it is sufficient for the delegation holder to
+downgrade the delegation to a read delegation.
+This is done by performing an
+.B F_SETDELEG
+operation specifying
+.I deleg->d_type
+as
+.BR F_RDLCK .
+.P
+If the delegation holder
+fails to downgrade or remove the delegation
+within the number of seconds specified in
+.IR /proc/sys/fs/lease\-break\-time ,
+then the kernel
+forcibly removes or downgrades the delegation holder's delegation.
+.P
+Once a delegation break has been initiated,
+.B F_GETDELEG
+returns the target delegation type in the
+.I deleg->d_type
+(either
+.B F_RDLCK
+or
+.BR F_UNLCK ,
+depending on what would be compatible with the delegation breaker)
+until the delegation holder voluntarily downgrades or removes the delegation
+or the kernel forcibly does so after the delegation break timer expires.
+.P
+Once the delegation has been voluntarily or forcibly removed or downgraded,
+and assuming the delegation breaker has not unblocked its system call,
+the kernel permits the delegation breaker's system call to proceed.
+.P
+If the delegation breaker's blocked system call
+is interrupted by a signal handler,
+then the system call fails with the error
+.BR EINTR ,
+but the other steps still occur as described above.
+If the delegation breaker is killed by a signal while blocked in
+.BR open (2)
+or
+.BR truncate (2),
+then the other steps still occur as described above.
+If the delegation breaker specifies the
+.B O_NONBLOCK
+flag when calling
+.BR open (2),
+then the call immediately fails with the error
+.BR EWOULDBLOCK ,
+but the other steps still occur as described above.
+.P
+The default signal used to notify the delegation holder is
+.BR SIGIO ,
+but this can be changed using
+.BR F_SETSIG (2const).
+If a
+.BR F_SETSIG (2const)
+operation is performed
+(even one specifying
+.BR SIGIO ),
+and the signal
+handler is established using
+.BR SA_SIGINFO ,
+then the handler will receive a
+.I siginfo_t
+structure as its second argument,
+and the
+.I si_fd
+field of this argument will hold
+the file descriptor of the file with the delegation
+that has been accessed by another process.
+(This is useful if the caller holds delegations against multiple files.)
+.SH NOTES
+Delegations were designed to implement NFSv4 delegations for the Linux NFS server.
+.SH RETURN VALUE
+On success zero is returned.
+On error, \-1 is returned, and
+.I errno
+is set to indicate the error.
+A successful
+.B F_GETDELEG
+call will also update the
+.I deleg->d_type
+field.
+.SH ERRORS
+See
+.BR fcntl (2).
+These operations can also return the following errors:
+.TP
+.B EAGAIN
+The file was held open in a way that
+conflicts with the requested delegation.
+.TP
+.B EINVAL
+The caller tried to set a
+.B F_WRLCK
+delegation and
+.I fd
+represents a directory.
+.TP
+.B EINVAL
+.I fd
+doesn't represent a file or directory.
+.TP
+.B EINVAL
+The underlying filesystem doesn't support delegations.
+.SH STANDARDS
+Linux,
+IETF\ RFC\ 8881.
+.SH HISTORY
+Linux 6.19.
+.SH SEE ALSO
+.BR fcntl (2) ,
+.BR F_SETLEASE (2const)
diff --git a/man/man2const/F_SETDELEG.2const b/man/man2const/F_SETDELEG.2const
new file mode 100644
index 000000000..acabdfc13
--- /dev/null
+++ b/man/man2const/F_SETDELEG.2const
@@ -0,0 +1 @@
+.so man2const/F_GETDELEG.2const

base-commit: f17241696722c472c5fcd06ee3b7af7afc3f1082
-- 
2.51.0


