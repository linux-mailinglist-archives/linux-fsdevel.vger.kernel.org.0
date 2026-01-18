Return-Path: <linux-fsdevel+bounces-74310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 133A4D39789
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 16:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B1203004844
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604EA33121F;
	Sun, 18 Jan 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLTtXgum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC823E330;
	Sun, 18 Jan 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750812; cv=none; b=KTWdkNLLrqsTVDpNzKaU0hvWm7zXUWzT3NINT8Cj2VAFHRrfVjXpVAMmQyXlIsOc/1E8UvGC/1Qa9zG98CbpdtJ1rP6oBwlGTpyQccHYLPbhMYhCkEUzgfOAlSpilqVN/u5mWXpYYnu/w4rURMIxS8spKOgTSLCFl8TZy/kK2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750812; c=relaxed/simple;
	bh=/tnKq7cAETTMDdDbCIElmcUYUsPzbjYe1hCyiG8vK+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6+OWUDLdfvp9bqs1W7bBmQ54WvplHg3Hd8+UmwYSCc+Umo9857PcNxGfrnzlu8qBztspp/DwzmG5grxfk87XApItwZJDrOAhjPJZZnskujJ7RtatAkM6rMxDIqi592WHyaooUb/1DmDBKGVMJM49lGWRNzfDAFreDLPQ1z1Xek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLTtXgum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99386C116D0;
	Sun, 18 Jan 2026 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768750812;
	bh=/tnKq7cAETTMDdDbCIElmcUYUsPzbjYe1hCyiG8vK+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLTtXgumTy4WT2pXtXKyiOTGEurtPzAoGF8OC3mig5plEGU232REEVc7PZ5neRLvR
	 d/9eMRvrHt16d6JSb8vopF8hkMQjZBB85GOrGGw0Bh2s/evbNifw3cViQTAYcrAVX3
	 ZdlYpc4n5bXbrnBJysWjJZxWtSk5RUKcKOUuFYUQeLOXrjAwnrAizH/gO00mLBIomq
	 GpYIg/l6obsSXCKvnKUW7HPb6hhxkWDXRJlxBPo+ablbzQywG6NZ7sKgUimz+WqHDc
	 wz93CVxlq1nISWEYYzuhNLTXfJ+ShVITDoFDLkhKiO73IqQM+juv5bTbJHuDt1as4M
	 4Nekdpr4snPUQ==
Date: Sun, 18 Jan 2026 16:40:09 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 1/2] man/man2const: document the new
 F_SETDELEG and F_GETDELEG constants
Message-ID: <aWz0gFNpGYIS_mF8@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <20260114-master-v2-1-719f5b47dfe2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3it4kbdqsczktu7d"
Content-Disposition: inline
In-Reply-To: <20260114-master-v2-1-719f5b47dfe2@kernel.org>


--3it4kbdqsczktu7d
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 1/2] man/man2const: document the new
 F_SETDELEG and F_GETDELEG constants
Message-ID: <aWz0gFNpGYIS_mF8@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <20260114-master-v2-1-719f5b47dfe2@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260114-master-v2-1-719f5b47dfe2@kernel.org>

Hi Jeff,

On Wed, Jan 14, 2026 at 12:35:24PM -0500, Jeff Layton wrote:
> With v6.19, userland will be able to request a delegation on a file or
> directory. These new objects act a lot like file leases, but are based
> on NFSv4 file and directory delegations.
>=20
> Add new F_GETDELEG and F_SETDELEG manpages to document them.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I've applied a large number of minor changes to the patch.  I have not
applied it yet, as I'd like you to have a look at it, and answer a
question or two.  I'd also like to review it again in case I made any
mistakes.

I've commented below on the changes, and have one or two questions that
need your attention.  I'll also reply with the patch updated with these
changes, so that you don't need to manually apply these changes.

See below.


Have a lovely day!
Alex

> ---
>  man/man2/fcntl.2                |   5 +
>  man/man2const/F_GETDELEG.2const | 246 ++++++++++++++++++++++++++++++++++=
++++++
>  man/man2const/F_SETDELEG.2const |   1 +
>  3 files changed, 252 insertions(+)
>=20
> diff --git a/man/man2/fcntl.2 b/man/man2/fcntl.2
> index 7f34e332ef9070867c4cdb51e8c5d4991b4fac22..f05d559da149e6a4cc8ae935f=
fa32111deabd94d 100644
> --- a/man/man2/fcntl.2
> +++ b/man/man2/fcntl.2
> @@ -78,6 +78,11 @@ indicating that the kernel does not recognize this val=
ue.
>  .BR F_SETLEASE (2const)
>  .TQ
>  .BR F_GETLEASE (2const)
> +.SS Delegations
> +.TP
> +.BR F_SETDELEG (2const)
> +.TQ
> +.BR F_GETDELEG (2const)
>  .SS File and directory change notification (dnotify)
>  .TP
>  .BR F_NOTIFY (2const)
> diff --git a/man/man2const/F_GETDELEG.2const b/man/man2const/F_GETDELEG.2=
const
> new file mode 100644
> index 0000000000000000000000000000000000000000..43bfac5707b189a4e16b70686=
74d5ddc0ec98913
> --- /dev/null
> +++ b/man/man2const/F_GETDELEG.2const
> @@ -0,0 +1,246 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH F_GETDELEG 2const (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +F_GETDELEG,
> +F_SETDELEG
> +\-
> +delegations
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ,\~ \-lc )
> +.SH SYNOPSIS
> +.nf
> +.B #define _GNU_SOURCE
> +.B #include <fcntl.h>
> +
> +.fi
> +.EX
> +struct delegation {
> +        __u32   d_flags;
> +        __u16   d_type;
> +        __u16   __pad;
> +};
> +.EE
> +.P
> +.nf
> +.BI "int fcntl(int " fd ", F_SETDELEG, const struct delegation *" deleg =
);
> +.BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
> +.fi

I'd reorder this to minimize nf/fi and EX/EE pairs:

	@@ -15,20 +15,18 @@ .SH SYNOPSIS
	 .nf
	 .B #define _GNU_SOURCE
	 .B #include <fcntl.h>
	-
	-.fi
	-.EX
	-struct delegation {
	-        __u32   d_flags;
	-        __u16   d_type;
	-        __u16   __pad;
	-};
	-.EE
	 .P
	-.nf
	 .BI "int fcntl(int " fd ", F_SETDELEG, const struct delegation *" deleg );
	 .BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
	 .fi
	+.P
	+.EX
	+struct delegation {
	+       __u32  d_flags;
	+       __u16  d_type;
	+       __u16  __pad;
	+};
	+.EE
	 .SH DESCRIPTION
	 .B F_SETDELEG
	 and

> +.SH DESCRIPTION
> +.B F_SETDELEG
> +and
> +.B F_GETDELEG
> +are used to establish a new delegation,
> +and retrieve the current delegation,
> +on the open file description referred to by the file descriptor
> +.IR fd .
> +.P
> +A file delegation is a mechanism whereby
> +the process holding the delegation (the "delegation holder")
> +is notified (via delivery of a signal)
> +when a process (the "delegation breaker") tries to
> +.BR open (2)
> +or
> +.BR truncate (2)
> +the file referred to by that file descriptor, or attempts to

I'd s/attempts/tries/, for consistency with the preceding clause.

	@@ -41,11 +39,13 @@ .SH DESCRIPTION
	 A file delegation is a mechanism whereby
	 the process holding the delegation (the "delegation holder")
	 is notified (via delivery of a signal)
	-when a process (the "delegation breaker") tries to
	+when a process (the "delegation breaker")
	+tries to
	 .BR open (2)
	 or
	 .BR truncate (2)
	-the file referred to by that file descriptor, or attempts to
	+the file referred to by that file descriptor,
	+or tries to
	 .BR unlink (2)
	 or
	 .BR rename (2)

> +.BR unlink (2)
> +or
> +.BR rename (2)
> +the dentry that was originally opened for the file.
> +.P
> +Delegations can also be set on directory file descriptors.
> +The holder of a directory delegation will be notified if there is a
> +create, delete or rename of a dirent within the directory.

We use the Oxform comma, which separates also the last two elements in
an or/and chain:

	@@ -53,7 +53,7 @@ .SH DESCRIPTION
	 .P
	 Delegations can also be set on directory file descriptors.
	 The holder of a directory delegation will be notified if there is a
	-create, delete or rename of a dirent within the directory.
	+create, delete, or rename of a dirent within the directory.
	 .TP
	 .B F_SETDELEG
	 Set or remove a file or directory delegation according to the

> +.TP
> +.B F_SETDELEG
> +Set or remove a file or directory delegation according to the
> +value specified in
> +.IR deleg->d_type :
> +.RS
> +.TP
> +.B F_RDLCK
> +Establish a read delegation.
> +This will cause the calling process to be notified when the file is open=
ed for writing,

We have a hard limit of 80 columns in source code.

	@@
	 .TP
	 .B F_RDLCK
	 Establish a read delegation.
	-This will cause the calling process to be notified when the file is opene=
d for writing,
	+This will cause the calling process to be notified
	+when the file is
	+opened for writing,
	 or is truncated, unlinked or renamed.
	-A read delegation can be placed only on a file descriptor that is opened =
read-only.
	+A read delegation can be placed
	+only on a file descriptor that is opened read-only.
	+.IP
	 If

> +or is truncated, unlinked or renamed.
> +A read delegation can be placed only on a file descriptor that is opened=
 read-only.

I'd separate the following sentence into a new paragraph.

> +If
> +.IR fd

s/IR/I/

	@@
	 If
	-.IR fd
	+.I fd
	 refers to a directory,
	 then the calling process will be notified if there are changes to filenam=
es within the directory,
	 or when the directory itself is renamed.

> +refers to a directory,
> +then the calling process will be notified if there are changes to filena=
mes within the directory,
> +or when the directory itself is renamed.

80-col

	@@
	 refers to a directory,
	-then the calling process will be notified if there are changes to filenam=
es within the directory,
	+then the calling process will be notified
	+if there are changes to filenames within the directory,
	 or when the directory itself is renamed.
	 .TP
	 .B F_WRLCK

> +.TP
> +.B F_WRLCK
> +Establish a write delegation.
> +This will cause the caller to be notified when the file is opened for re=
ading or writing,
> +or is truncated, renamed or unlinked.
> +A write delegation may be placed on a file only if there are no other op=
en file descriptors for the file.
> +The file must be opened for write in order to set a write delegation on =
it.
> +Write delegations cannot be set on directory file descriptors.
> +.TP
> +.B F_UNLCK
> +Remove our delegation from the file.
> +.RE
> +.P
> +Like leases, delegations are associated with an open file description (s=
ee
> +.BR open (2)).
> +This means that duplicate file descriptors (created by, for example,
> +.BR fork (2)
> +or
> +.BR dup (2))
> +refer to the same delegation,
> +and this delegation may be modified or released using any of these descr=
iptors.
> +Furthermore, the delegation is released by either an explicit
> +.B F_UNLCK
> +operation on any of these duplicate file descriptors,
> +or when all such file descriptors have been closed.
> +.P
> +An unprivileged process may take out a delegation only on a file whose U=
ID (owner) matches the filesystem UID of the process.

Some more semantic newlines:

	@@ -84,23 +89,29 @@ .SH DESCRIPTION
	 Remove our delegation from the file.
	 .RE
	 .P
	-Like leases, delegations are associated with an open file description (see
	+Like leases,
	+delegations are associated with an open file description
	+(see
	 .BR open (2)).
	-This means that duplicate file descriptors (created by, for example,
	+This means that duplicate file descriptors
	+(created by, for example,
	 .BR fork (2)
	 or
	 .BR dup (2))
	 refer to the same delegation,
	-and this delegation may be modified or released using any of these descri=
ptors.
	-Furthermore, the delegation is released by either an explicit
	+and this delegation may be modified or released
	+using any of these descriptors.
	+Furthermore,
	+the delegation is released by either an explicit
	 .B F_UNLCK
	 operation on any of these duplicate file descriptors,
	 or when all such file descriptors have been closed.
	 .P
	-An unprivileged process may take out a delegation only on a file whose UI=
D (owner) matches the filesystem UID of the process.
	+An unprivileged process may establish a delegation
	+only on a file whose UID (owner) matches the filesystem UID of the proces=
s.
	 A process with the
	 .B CAP_LEASE
	-capability may take out delegations on arbitrary files or directories.
	+capability may establish delegations on arbitrary files and directories.
	 .TP
	 .B F_GETDELEG
	 Indicates what type of delegation is associated with the file descriptor


> +A process with the
> +.B CAP_LEASE
> +capability may take out delegations on arbitrary files or directories.
> +.TP
> +.B F_GETDELEG
> +Indicates what type of delegation is associated with the file descriptor
> +.I fd
> +by setting the
> +.IR d_type
> +field in
> +.IR deleg

	@@ -107,6 +118,4 @@ .SH DESCRIPTION
	 .I fd
	-by setting the
	-.IR d_type
	-field in
	-.IR deleg
	+by setting
	+.I deleg->d_type
	 to either

> +to either
> +.BR F_RDLCK ,
> +.BR F_WRLCK ,
> +or
> +.BR F_UNLCK ,
> +indicating, respectively, a read delegation, a write delegation, or no d=
elegation.
> +.P
> +When a process (the "delegation breaker") performs an activity that conf=
licts with a delegation
> +established via
> +.BR F_SETDELEG ,
> +the system call is blocked by the kernel and
> +the kernel notifies the delegation holder by sending it a signal
> +.RB ( SIGIO
> +by default).
> +The delegation holder should respond to receipt of this signal by doing
> +whatever cleanup is required in preparation for the file to be
> +accessed by another process (e.g., flushing cached buffers) and
> +then either remove or downgrade its delegation.

More semantic newlines:

	@@ -116,15 +125,19 @@ .SH DESCRIPTION
	 .BR F_UNLCK ,
	-indicating, respectively, a read delegation, a write delegation, or no de=
legation.
	+indicating, respectively,
	+a read delegation, a write delegation, or no delegation.
	 .P
	-When a process (the "delegation breaker") performs an activity that confl=
icts with a delegation
	+When a process (the "delegation breaker")
	+performs an activity that conflicts with a delegation
	 established via
	 .BR F_SETDELEG ,
	-the system call is blocked by the kernel and
	-the kernel notifies the delegation holder by sending it a signal
	+the system call is blocked by the kernel
	+and the kernel notifies the delegation holder by sending it a signal
	 .RB ( SIGIO
	 by default).
	-The delegation holder should respond to receipt of this signal by doing
	-whatever cleanup is required in preparation for the file to be
	-accessed by another process (e.g., flushing cached buffers) and
	-then either remove or downgrade its delegation.
	+The delegation holder should respond to receipt of this signal
	+by doing whatever cleanup is required
	+in preparation for the file to be
	+accessed by another process
	+(e.g., flushing cached buffers)
	+and then either remove or downgrade its delegation.
	 A delegation is removed by performing an


> +A delegation is removed by performing an
> +.B F_SETDELEG
> +operation specifying
> +.I d_type
> +in
> +.I deleg

	@@ -132,5 +145,3 @@ .SH DESCRIPTION
	 operation specifying
	-.I d_type
	-in
	-.I deleg
	+.I deleg->d_type
	 as

> +as
> +.BR F_UNLCK .
> +If the delegation holder currently holds a write delegation on the file,
> +and the delegation breaker is opening the file for reading,
> +then it is sufficient for the delegation holder to downgrade
> +the delegation to a read delegation.

More semantic newlines:

	@@
	 .BR F_UNLCK .
	-If the delegation holder currently holds a write delegation on the file,
	-and the delegation breaker is opening the file for reading,
	-then it is sufficient for the delegation holder to downgrade
	-the delegation to a read delegation.
	+If the delegation holder currently holds
	+a write delegation on the file,
	+and the delegation breaker
	+is opening the file for reading,
	+then it is sufficient for the delegation holder to
	+downgrade the delegation to a read delegation.
	 This is done by performing an

> +This is done by performing an
> +.B F_SETDELEG
> +operation specifying
> +.I d_type
> +in
> +.I deleg

	@@ -144,5 +157,3 @@ .SH DESCRIPTION
	 operation specifying
	-.I d_type
	-in
	-.I deleg
	+.I deleg->d_type
	 as

> +as
> +.BR F_RDLCK .
> +.P
> +If the delegation holder fails to downgrade or remove the delegation wit=
hin
> +the number of seconds specified in
> +.IR /proc/sys/fs/lease\-break\-time ,
> +then the kernel forcibly removes or downgrades the delegation holder's d=
elegation.
> +.P
> +Once a delegation break has been initiated,
> +.B F_GETDELEG
> +returns the target delegation type in the
> +.I d_type
> +field in
> +.I deleg

	@@ -150,6 +161,8 @@ .SH DESCRIPTION
	 .P
	-If the delegation holder fails to downgrade or remove the delegation with=
in
	-the number of seconds specified in
	+If the delegation holder
	+fails to downgrade or remove the delegation
	+within the number of seconds specified in
	 .IR /proc/sys/fs/lease\-break\-time ,
	-then the kernel forcibly removes or downgrades the delegation holder's de=
legation.
	+then the kernel
	+forcibly removes or downgrades the delegation holder's delegation.
	 .P
	@@ -158,5 +171,3 @@ .SH DESCRIPTION
	 returns the target delegation type in the
	-.I d_type
	-field in
	-.I deleg
	+.I deleg->d_type
	 (either

> +(either
> +.B F_RDLCK
> +or
> +.BR F_UNLCK ,
> +depending on what would be compatible with the delegation breaker)
> +until the delegation holder voluntarily downgrades or removes the delega=
tion or
> +the kernel forcibly does so after the delegation break timer expires.

	@@ -166,4 +177,4 @@ .SH DESCRIPTION
	 depending on what would be compatible with the delegation breaker)
	-until the delegation holder voluntarily downgrades or removes the delegat=
ion or
	-the kernel forcibly does so after the delegation break timer expires.
	+until the delegation holder voluntarily downgrades or removes the delegat=
ion
	+or the kernel forcibly does so after the delegation break timer expires.
	 .P


> +.P
> +Once the delegation has been voluntarily or forcibly removed or downgrad=
ed,
> +and assuming the delegation breaker has not unblocked its system call,
> +the kernel permits the delegation breaker's system call to proceed.
> +.P
> +If the delegation breaker's blocked system call
> +is interrupted by a signal handler,
> +then the system call fails with the error
> +.BR EINTR ,
> +but the other steps still occur as described above.
> +If the delegation breaker is killed by a signal while blocked in
> +.BR open (2)
> +or
> +.BR truncate (2),
> +then the other steps still occur as described above.
> +If the delegation breaker specifies the
> +.B O_NONBLOCK
> +flag when calling
> +.BR open (2),
> +then the call immediately fails with the error
> +.BR EWOULDBLOCK ,
> +but the other steps still occur as described above.
> +.P
> +The default signal used to notify the delegation holder is
> +.BR SIGIO ,
> +but this can be changed using the
> +.B F_SETSIG
> +operation to
> +.BR fcntl ().

Refer to the manual page:

	@@ -193,9 +204,8 @@ .SH DESCRIPTION
	 .BR SIGIO ,
	-but this can be changed using the
	-.B F_SETSIG
	-operation to
	-.BR fcntl ().
	+but this can be changed using
	+.BR F_SETSIG (2const).
	 If a
	-.B F_SETSIG
	-operation is performed (even one specifying
	+.BR F_SETSIG (2const)
	+operation is performed
	+(even one specifying
	 .BR SIGIO ),

> +If a
> +.B F_SETSIG
> +operation is performed (even one specifying
> +.BR SIGIO ),
> +and the signal
> +handler is established using
> +.BR SA_SIGINFO ,
> +then the handler will receive a
> +.I siginfo_t
> +structure as its second argument, and the
> +.I si_fd
> +field of this argument will hold the file descriptor of the file with th=
e delegation
> +that has been accessed by another process.

Semantic newlines:

	@@ -206,5 +216,7 @@ .SH DESCRIPTION
	 .I siginfo_t
	-structure as its second argument, and the
	+structure as its second argument,
	+and the
	 .I si_fd
	-field of this argument will hold the file descriptor of the file with the=
 delegation
	+field of this argument will hold
	+the file descriptor of the file with the delegation
	 that has been accessed by another process.

> +(This is useful if the caller holds delegations against multiple files.)
> +.SH NOTES
> +Delegations were designed to implement NFSv4 delegations for the Linux N=
FS server.

Do we have a link to the NFSv4 specification of delegations?  It would
be useful, I think.

> +.SH RETURN VALUE
> +On success zero is returned. On error, \-1 is returned, and

In source code, we *always* start a new line after period.

	@@ -214,5 +226,7 @@ .SH NOTES
	 .SH RETURN VALUE
	-On success zero is returned. On error, \-1 is returned, and
	+On success zero is returned.
	+On error, \-1 is returned, and
	 .I errno
	-is set to indicate the error. A successful
	+is set to indicate the error.
	+A successful
	 .B F_GETDELEG

> +.I errno
> +is set to indicate the error. A successful
> +.B F_GETDELEG
> +call will also update the
> +.I deleg->d_type
> +field.
> +.SH ERRORS
> +See
> +.BR fcntl (2).
> +These operations can also return the following errors:
> +.TP
> +.B EAGAIN
> +The operation was prohibited because the file was held open in a way tha=
t conflicts with the requested delegation.
> +.TP
> +.B EINVAL
> +The operation was prohibited because the caller tried to set a
> +.B F_WRLCK
> +delegation and
> +.I fd
> +represents a directory,
> +or
> +.I fd
> +doesn't represent a file or directory, or
> +the underlying filesystem doesn't support delegations.

I've split this into 3 separate EINVAL entries, and have removed
superfluous wording.

	@@ -225,18 +239,22 @@ .SH ERRORS
	 These operations can also return the following errors:
	 .TP
	 .B EAGAIN
	-The operation was prohibited because the file was held open in a way that=
 conflicts with the requested delegation.
	+The file was held open in a way that
	+conflicts with the requested delegation.
	 .TP
	 .B EINVAL
	-The operation was prohibited because the caller tried to set a
	+The caller tried to set a
	 .B F_WRLCK
	 delegation and
	 .I fd
	-represents a directory,
	-or
	+represents a directory.
	+.TP
	+.B EINVAL
	 .I fd
	-doesn't represent a file or directory, or
	-the underlying filesystem doesn't support delegations.
	+doesn't represent a file or directory.
	+.TP
	+.B EINVAL
	+The underlying filesystem doesn't support delegations.
	 .SH STANDARDS
	 Linux, IETF RFC\ 8881.
	 .SH HISTORY

> +.SH STANDARDS
> +Linux, IETF RFC\ 8881.

	@@ -241 +259,2 @@ .SH STANDARDS
	-Linux, IETF RFC\ 8881.
	+Linux,
	+IETF\ RFC\ 8881.

> +.SH HISTORY
> +Linux 6.19.
> +.SH SEE ALSO
> +.BR fcntl (2) ,
> +.BR F_SETLEASE (2const)
> diff --git a/man/man2const/F_SETDELEG.2const b/man/man2const/F_SETDELEG.2=
const
> new file mode 100644
> index 0000000000000000000000000000000000000000..acabdfc139fb3d753dbf3061c=
31d59332d046c63
> --- /dev/null
> +++ b/man/man2const/F_SETDELEG.2const
> @@ -0,0 +1 @@
> +.so man2const/F_GETDELEG.2const
>=20
> --=20
> 2.52.0
>=20

--=20
<https://www.alejandro-colomar.es>

--3it4kbdqsczktu7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmls/tMACgkQ64mZXMKQ
wqlJlA/+NLEkHyVtz3TBZqwK6KNhOPULIbCR7fNEqpEPbKbBiX/BYYIHFDHCxixC
U4dMqUFZm7i+EVu8kFl0BD+VLrSDmyvtEMbAWEzwZBlIUK0801xwzipp1nhhtDGn
cE3hSYZVvOsJZEflFltGEBfqRSeI3Ak+96c1k3LbOy+gFboA1muCNqapWS4lGyFl
3dgPm2LxQDmkzTLyMVJy3cXTp0vJkrFhZqT3EKaAs8Fujqxr33dQQ5IBNq+P4N34
qHY9e0lJPCLNWa/g/PN4TqwXNxBn6MXGj/4h0bvJrny4ymXutmKLD0BrA063JuRz
d2M5SU7i5NqHScQ+9WuUx1RE6RtQdaGuxWFPMAL7Gm5PjK0U2tdMb3KGdj75cpYN
OVZ1Mw70o6S/NzeuEwRlCB6fG+2opWAeqCZeqcrVkIe7KNOAYTYVUYvpWmdopKMV
4Xw3WROPLx72tgfBMbrb8h3eEfJcqn9+Ow4uZggMj57hg9jyHqTSoe43A8lS/hUP
qQ3U/q9S1es6J/r3Kr4mfkr7alGLcjDpIzH4sRSg0X3MQZtQhKzjrkjL/JHDFf/r
sS9xBB+BcDz+U8gJqM9WunJmv1S9Q3VeCR5qebxBhVUBhHQXjb/OgiVeM85koquO
3wePYCUJ05l8rV8mOd2aQAha+tJF9kG8EyvKJFmeWuSLSXZqvpE=
=SBbs
-----END PGP SIGNATURE-----

--3it4kbdqsczktu7d--

