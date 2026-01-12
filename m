Return-Path: <linux-fsdevel+bounces-73307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF56FD14CC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 19:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1445F3021F90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303593803F3;
	Mon, 12 Jan 2026 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr/VvOWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F042EC0A2;
	Mon, 12 Jan 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243638; cv=none; b=QYFi4ymaqRA4fRSOqJNhuecWiHOL4y1sTChfRM3+EvJF3lfejmrs4GCMsSNiwUw9gyDpLqi7RCM6+4mJ3d93BfOOtU5fUl8NaM83O/YXw0RHBkmnsCqml3TXs4xyE777HVUG7aUE+css4oHS/HxdAP2Tpg1lHnBFgoDhEe7XZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243638; c=relaxed/simple;
	bh=Tp2CofbNPouTBZUUcyGsxgn+Qks+RhUopwNJ8qo1Af8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U8qm2RkyPXoxeb0MZr70t7Yf4PBxCS8bSN5t2AjeVB6PmWizwUx800WMv7GAvpbQbuiS3160i8golK/Ckq67SfW/f4HF5kvcKEYk0IkgiQ6f2qp+tFyt9oZYdWoAHkU3KsxNlxYAHd6EW7EBohRdmrVIvCTfazyYln1TlbGRuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr/VvOWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50E5C16AAE;
	Mon, 12 Jan 2026 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768243638;
	bh=Tp2CofbNPouTBZUUcyGsxgn+Qks+RhUopwNJ8qo1Af8=;
	h=From:Date:Subject:To:Cc:From;
	b=fr/VvOWS+mOsCyb9gvlzFle7+0e+Ux7lQOLS/FVi1JvwxRmfk9SFbnjz76ZOmXzo6
	 rWw0iWsic1E/3yGUcDRkjZE8FxmzLYoMR/sZuQWYceFbwt2kHI645KCddpHzx+QStK
	 NIc5yZt0FBEOra3sTyKZ112FRHBVKxG1yUceaXkZt1arsq4AYBtQg93OkygcoFf/bj
	 4PnqDk19Pnxh42EyhpRgbnwrqX8xJdjwYHFFFpNni4wfkmBoEs4GRvxY3a8Fg4IpWB
	 eSF0myFVG0dWf+9XoDSzLCNb0M0wbF9EnEM5jDevtjbu1oCD9vw7igtrVClJFfjDpM
	 2FwGoEUDPce3w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 12 Jan 2026 13:47:11 -0500
Subject: [PATCH man-pages] man/man2const: document the new F_SETDELEG and
 F_GETDELEG constants
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-master-v1-1-3948465faaae@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtIBcmuEi2GnGoWmmhEIN09a
 fng8ysUzsIFpq5C5luKnLFB9R2sB8WdUXwz6EHbQSmNgcrFGbUhxZ6dG42FFqfMmzz/aIZAERP
 tTcv7fhJyQYFjAAAA
X-Change-ID: 20260112-master-23a1ede99836
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9122; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Tp2CofbNPouTBZUUcyGsxgn+Qks+RhUopwNJ8qo1Af8=;
 b=owEBbAKT/ZANAwAKAQAOaEEZVoIVAcsmYgBpZUG1JjlBgob8dZtMJAExUe5VE5a+HFMRVAk+B
 OFfqIbdKD+JAjIEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWVBtQAKCRAADmhBGVaC
 FX9TD/iNZPI2Iu/nte5tefWLZzXGcRxwLTSH1DbjhwCLAf96FMmkJwFMVQzZfk+7q3P1jD7B4kE
 6x1+vXmpNlpYxltTYKzQgVdW7peoTs2s/1lqKmeyrpXVQzWLKekn76Mhz5APh/1VCAArFPjabe/
 tYtNEaH0TSp87kx3lNhTzJDlasXUHGXY3OUKUxv9exaQHAZ2nOyFM4ca8+knG4652+k73lejDju
 69CGSaaWHS6WzDZFb38X1bYWoWXg/1gARBcnYkW7PYRGDnZUE15+ak8gve4DujPfYqxb02xfRtt
 a2pj9aUb8Ng8JEbkGaB1wkZoQF2Pi1jbX0z84dg5VSm/tDZt5G0GtgrRPBnynQ9yDMw+xXfRO0N
 VRBpLR7Ljh/k4DEf7e6tKBtBw51AnDiHEoomprqxuWDG/3T4GCHSFS5Gp9jmpH865PljQtEKePd
 51q7tibnr2zFc4FjQpCDMhdAxFk15WtGzzGFNPGQ5vOCgpnxxLITD6LRyqWeL1+bVD6yRn0xszc
 AcQItLH80WSlbjtTFiXKfKlZSo7aJGChzjExEa1HLKt2EfspZkPRM7QtAWEIKh4VSHzN6sln8jd
 LP5qDBS72LT6WPkIxTy3fU5bZel9aN7zxC4rCIke1LXmhwrLEave/kA5FmB2orReO4T9wLXIzGB
 4Fnv6PIhEM+Vi
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With v6.19, userland will be able to request a delegation on a file or
directory. These new objects act a lot like file leases, but are based
on NFSv4 file and directory delegations.

Add new F_GETDELEG and F_SETDELEG manpages to document them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man/man2/fcntl.2                |   5 +
 man/man2const/F_GETDELEG.2const | 230 ++++++++++++++++++++++++++++++++++++++++
 man/man2const/F_SETDELEG.2const |   1 +
 3 files changed, 236 insertions(+)

diff --git a/man/man2/fcntl.2 b/man/man2/fcntl.2
index 7f34e332ef9070867c4cdb51e8c5d4991b4fac22..f05d559da149e6a4cc8ae935ffa32111deabd94d 100644
--- a/man/man2/fcntl.2
+++ b/man/man2/fcntl.2
@@ -78,6 +78,11 @@ indicating that the kernel does not recognize this value.
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
index 0000000000000000000000000000000000000000..60c7e62f8dbcb6f97fda82e1c50f34ecacce2aab
--- /dev/null
+++ b/man/man2const/F_GETDELEG.2const
@@ -0,0 +1,230 @@
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
+.EX
+/* Argument structure for F_GETDELEG and F_SETDELEG */
+struct delegation {
+        __u32   d_flags;
+        __u16   d_type;
+        __u16   __pad;
+};
+.EE
+.P
+.BI "int fcntl(int " fd ", F_SETDELEG, struct delegation *" deleg );
+.br
+.BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
+.fi
+.SH DESCRIPTION
+.SS Delegations
+.B F_SETDELEG
+and
+.B F_GETDELEG
+are used to establish a new delegation,
+and retrieve the current delegation, on the open file description
+referred to by the file descriptor
+.IR fd .
+A file delegation is a mechanism whereby the process holding
+the delegation (the "delegation holder") is notified (via delivery of a signal)
+when a process (the "delegation breaker") tries to
+.BR open (2)
+or
+.BR truncate (2)
+the file referred to by that file descriptor, or attempts to
+.BR unlink (2)
+or
+.BR rename (2)
+the dentry that was originally opened for the file.
+.BR F_RDLCK
+delegations can also be set on directory file descriptors, in which case they will
+be recalled if there is a create, delete or rename of a dirent within the directory.
+.TP
+.B F_SETDELEG
+Set or remove a file or directory delegation according to which of the following
+values is specified in the
+.IR d_type
+field of
+.IR deleg :
+.RS
+.TP
+.B F_RDLCK
+Take out a read delegation.
+This will cause the calling process to be notified when
+the file is opened for writing or is truncated, or when the file is unlinked or renamed.
+A read delegation can be placed only on a file descriptor that
+is opened read-only. If
+.IR fd
+refers to a directory, then the calling process
+will be notified if there are changes to filenames within the directory, or when the
+directory itself is renamed.
+.TP
+.B F_WRLCK
+Take out a write delegation.
+This will cause the caller to be notified when
+the file is opened for reading or writing or is truncated or when the file is renamed
+or unlinked.  A write delegation may be placed on a file only if there are no
+other open file descriptors for the file. The file must be opened for write in order
+to set a write delegation on it. Write delegations cannot be set on directory
+file descriptors.
+.TP
+.B F_UNLCK
+Remove our delegation from the file.
+.RE
+.P
+Like leases, delegations are associated with an open file description (see
+.BR open (2)).
+This means that duplicate file descriptors (created by, for example,
+.BR fork (2)
+or
+.BR dup (2))
+refer to the same delegation, and this delegation may be modified
+or released using any of these descriptors.
+Furthermore, the delegation is released by either an explicit
+.B F_UNLCK
+operation on any of these duplicate file descriptors, or when all
+such file descriptors have been closed.
+.P
+An unprivileged process may take out a delegation only on a file whose
+UID (owner) matches the filesystem UID of the process.
+A process with the
+.B CAP_LEASE
+capability may take out delegations on arbitrary files or directories.
+.TP
+.B F_GETDELEG
+Indicates what type of delegation is associated with the file descriptor
+.I fd
+by setting the
+.IR d_type
+field in
+.IR deleg
+to either
+.BR F_RDLCK ", " F_WRLCK ", or " F_UNLCK ,
+indicating, respectively, a read delegation , a write delegation, or no delegation.
+.P
+When a process (the "delegation breaker") performs an activity
+that conflicts with a delegation established via
+.BR F_SETDELEG ,
+the system call is blocked by the kernel and
+the kernel notifies the delegation holder by sending it a signal
+.RB ( SIGIO
+by default).
+The delegation holder should respond to receipt of this signal by doing
+whatever cleanup is required in preparation for the file to be
+accessed by another process (e.g., flushing cached buffers) and
+then either remove or downgrade its delegation.
+A delegation is removed by performing an
+.B F_SETDELEG
+operation specifying
+.I d_type
+in
+.I deleg
+as
+.BR F_UNLCK .
+If the delegation holder currently holds a write delegation on the file,
+and the delegation breaker is opening the file for reading,
+then it is sufficient for the delegation holder to downgrade
+the delegation to a read delegation.
+This is done by performing an
+.B F_SETDELEG
+operation specifying
+.I d_type
+in
+.I deleg
+as
+.BR F_RDLCK .
+.P
+If the delegation holder fails to downgrade or remove the delegation within
+the number of seconds specified in
+.IR /proc/sys/fs/lease\-break\-time ,
+then the kernel forcibly removes or downgrades the delegation holder's delegation.
+.P
+Once a delegation break has been initiated,
+.B F_GETDELEG
+returns the target delegation type in the
+.I d_type
+field in
+.I deleg
+(either
+.B F_RDLCK
+or
+.BR F_UNLCK ,
+depending on what would be compatible with the delegation breaker)
+until the delegation holder voluntarily downgrades or removes the delegation or
+the kernel forcibly does so after the delegation break timer expires.
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
+but this can be changed using the
+.B F_SETSIG
+operation to
+.BR fcntl ().
+If a
+.B F_SETSIG
+operation is performed (even one specifying
+.BR SIGIO ),
+and the signal
+handler is established using
+.BR SA_SIGINFO ,
+then the handler will receive a
+.I siginfo_t
+structure as its second argument, and the
+.I si_fd
+field of this argument will hold the file descriptor of the file with the delegation
+that has been accessed by another process.
+(This is useful if the caller holds delegations against multiple files.)
+.SH NOTES
+Delegations were designed to implement NFSv4 delegations for the Linux NFS server, and
+conform to the delegation semantics described in RFC\ 8881.
+.SH RETURN VALUE
+On success zero is returned. On error, \-1 is returned, and
+.I errno
+is set to indicate the error. A successful F_GETDELEG call will also update the
+.I d_type
+field in the structure to which
+.I deleg
+points.
+.SH ERRORS
+See
+.BR fcntl (2).
+.SH STANDARDS
+Linux, IETF RFC\ 8881.
+.SH HISTORY
+Linux v6.19.
+.SH SEE ALSO
+.BR fcntl (2)
diff --git a/man/man2const/F_SETDELEG.2const b/man/man2const/F_SETDELEG.2const
new file mode 100644
index 0000000000000000000000000000000000000000..acabdfc139fb3d753dbf3061c31d59332d046c63
--- /dev/null
+++ b/man/man2const/F_SETDELEG.2const
@@ -0,0 +1 @@
+.so man2const/F_GETDELEG.2const

---
base-commit: 753ac20a01007417aa993e70d290f51840e2f477
change-id: 20260112-master-23a1ede99836

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


