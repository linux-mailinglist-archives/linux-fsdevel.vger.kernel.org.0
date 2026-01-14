Return-Path: <linux-fsdevel+bounces-73789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6946DD20922
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64327302168C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB32E9ECA;
	Wed, 14 Jan 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4P+di7C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D683009F6;
	Wed, 14 Jan 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412144; cv=none; b=jRr08mRcjwlBXs/qI38ZSeYD5th2m6ELTvYenvTqeglIP9xXMLNgIbTq+9lV0Y7LdrDYnCafG9B9r4+nfdGVtVPNcvWBPV+Ef/BDtiEGfBrvswwz83teocSMuhhw4rxaNC4r7Rxqxh4Q0JXsgw8VPr1IFbm/25pUzCuSMPUQEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412144; c=relaxed/simple;
	bh=6d0+D8M3npsD294KGTf6BdIg5ljQrhhMU0wTjlwEaMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYLLQYdBr9+2Goptt6WKrggj7EYdTl3B5U7oLjNuYVaMYxSB1WxneWvLMTgqXpaLCJLBeJN6x62ASohSX0wYm1xi32PgWXgUkJR5WLq7eYKYVYuzW/RoA1vgyR1+XDqGLeaiYZEez6G0NarxIfnuA5xgWqPG+Ul73yDA7yXV7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4P+di7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC37C19421;
	Wed, 14 Jan 2026 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768412144;
	bh=6d0+D8M3npsD294KGTf6BdIg5ljQrhhMU0wTjlwEaMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t4P+di7C1n26F74E7/cnIfOFe4z9It2MIBCyhBX/sRYZlxvWzJD9EzJ2YidsFZsc5
	 9WgaOYx7P70KhtEbQTAXjqvGBwtz14KEMPRQ7wF6akmA59CLG/sC6OqS5P5J7IUNYk
	 YcA2F9Hc1d1hrBaKEbhFPVyXXAFEhzzN0MVOY2eGL2oE3/br92uieoHPX1348vvgUn
	 4H4vM3SoXuYDb1pK7p3NnrSS/8U7hOYCru9JDIakk+y4QsErDV6YnuYS61y5IFj53l
	 yUS17gyJpya9zxFj+xHuijfDtOcXroWp6W/28Ujo5BlEPXW5sk0iv/4rxJ8bwBTP5k
	 cTqKt+MX0V2zA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 14 Jan 2026 12:35:24 -0500
Subject: [PATCH man-pages v2 1/2] man/man2const: document the new
 F_SETDELEG and F_GETDELEG constants
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-master-v2-1-719f5b47dfe2@kernel.org>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
In-Reply-To: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9237; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6d0+D8M3npsD294KGTf6BdIg5ljQrhhMU0wTjlwEaMA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpZ9PujK8KtFuOxEFFcu0WxSdGllVHP2bvt+xM3
 3L+jgfFBI6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWfT7gAKCRAADmhBGVaC
 FUzaEAC5vUngWXLRL1a9r5Sh1yYqmg6Xqo3IJXbYQq7UQRDbCFGt4LHpvgzdwZvktz2sOnbP0+c
 KLm5Ep6D/Q2AncGPUqQREsGaa0cha8ACcB+up2RCpIdxJBiKnLLLJh3ByIVG9x94BPXboqqUfJa
 5yl9iXRa35s6JMqt23Xq+3lXjtxTcA4KHSgK7WigVti+k4GSVwGk/tBdliQjqMh5uy/FFkYQGuJ
 2iesKnDVqNPqhI2KoNH2pHJkzuryu9qfRwIwpaHVvmVi+Yov59Uf7iBT3TBIQTuzo4g7Wa1hWIH
 cNd63TCVjWewJPTCjGa8GoHF/AvlavuBloVpAfCN1MDGtD2kQEq8FwPLxICByTso0oUOmq9ew63
 4wrcn3wQ0arCCqCelz6rIOs2lVYoQm9u44a6wkZsyXlGgqNQQ6NCP9qpFMvbB4VZTayBrJfJpew
 5CmkrBpDAD7pH6PVD+4EQmfQM2aGQsVv7PG+gEPs8DAXPImGlM4W9c0z4HTxh344FAj3UZkmCLz
 iLrj55MJJNXDTRuMAdN/zXcGWZpJLZay+hlFwrrSVS4/6scxpAsC8iLEV5dQNWjD8bU+oapjjPZ
 NBdNPPzRT5tYOrpPoPYkqL1MqHZGIqOxgayuOw9TDgxA4KTEcXJm/WQezKtwrkfV0ksGZIgwHXE
 MtW9XlluDHcqpTA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With v6.19, userland will be able to request a delegation on a file or
directory. These new objects act a lot like file leases, but are based
on NFSv4 file and directory delegations.

Add new F_GETDELEG and F_SETDELEG manpages to document them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man/man2/fcntl.2                |   5 +
 man/man2const/F_GETDELEG.2const | 246 ++++++++++++++++++++++++++++++++++++++++
 man/man2const/F_SETDELEG.2const |   1 +
 3 files changed, 252 insertions(+)

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
index 0000000000000000000000000000000000000000..43bfac5707b189a4e16b7068674d5ddc0ec98913
--- /dev/null
+++ b/man/man2const/F_GETDELEG.2const
@@ -0,0 +1,246 @@
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
+
+.fi
+.EX
+struct delegation {
+        __u32   d_flags;
+        __u16   d_type;
+        __u16   __pad;
+};
+.EE
+.P
+.nf
+.BI "int fcntl(int " fd ", F_SETDELEG, const struct delegation *" deleg );
+.BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
+.fi
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
+when a process (the "delegation breaker") tries to
+.BR open (2)
+or
+.BR truncate (2)
+the file referred to by that file descriptor, or attempts to
+.BR unlink (2)
+or
+.BR rename (2)
+the dentry that was originally opened for the file.
+.P
+Delegations can also be set on directory file descriptors.
+The holder of a directory delegation will be notified if there is a
+create, delete or rename of a dirent within the directory.
+.TP
+.B F_SETDELEG
+Set or remove a file or directory delegation according to the
+value specified in
+.IR deleg->d_type :
+.RS
+.TP
+.B F_RDLCK
+Establish a read delegation.
+This will cause the calling process to be notified when the file is opened for writing,
+or is truncated, unlinked or renamed.
+A read delegation can be placed only on a file descriptor that is opened read-only.
+If
+.IR fd
+refers to a directory,
+then the calling process will be notified if there are changes to filenames within the directory,
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
+Like leases, delegations are associated with an open file description (see
+.BR open (2)).
+This means that duplicate file descriptors (created by, for example,
+.BR fork (2)
+or
+.BR dup (2))
+refer to the same delegation,
+and this delegation may be modified or released using any of these descriptors.
+Furthermore, the delegation is released by either an explicit
+.B F_UNLCK
+operation on any of these duplicate file descriptors,
+or when all such file descriptors have been closed.
+.P
+An unprivileged process may take out a delegation only on a file whose UID (owner) matches the filesystem UID of the process.
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
+.BR F_RDLCK ,
+.BR F_WRLCK ,
+or
+.BR F_UNLCK ,
+indicating, respectively, a read delegation, a write delegation, or no delegation.
+.P
+When a process (the "delegation breaker") performs an activity that conflicts with a delegation
+established via
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
+Delegations were designed to implement NFSv4 delegations for the Linux NFS server.
+.SH RETURN VALUE
+On success zero is returned. On error, \-1 is returned, and
+.I errno
+is set to indicate the error. A successful
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
+The operation was prohibited because the file was held open in a way that conflicts with the requested delegation.
+.TP
+.B EINVAL
+The operation was prohibited because the caller tried to set a
+.B F_WRLCK
+delegation and
+.I fd
+represents a directory,
+or
+.I fd
+doesn't represent a file or directory, or
+the underlying filesystem doesn't support delegations.
+.SH STANDARDS
+Linux, IETF RFC\ 8881.
+.SH HISTORY
+Linux 6.19.
+.SH SEE ALSO
+.BR fcntl (2) ,
+.BR F_SETLEASE (2const)
diff --git a/man/man2const/F_SETDELEG.2const b/man/man2const/F_SETDELEG.2const
new file mode 100644
index 0000000000000000000000000000000000000000..acabdfc139fb3d753dbf3061c31d59332d046c63
--- /dev/null
+++ b/man/man2const/F_SETDELEG.2const
@@ -0,0 +1 @@
+.so man2const/F_GETDELEG.2const

-- 
2.52.0


