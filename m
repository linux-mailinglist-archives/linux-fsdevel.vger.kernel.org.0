Return-Path: <linux-fsdevel+bounces-73443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01FD19983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B8A303C9AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D02D0C97;
	Tue, 13 Jan 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyacrplq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7E2C21F9;
	Tue, 13 Jan 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315514; cv=none; b=gLQTGo0wueiLtOXdHi0SrM7W8n+Ba5zXHLZsiAtybbzWRchsAA8UPNeajSKrgnnh5qwI9qF7dv/Nf6d9l1tgszJIPgDnlP8vhSXQJSW+j3RnYRiHhlhuNqHpxU+GZmvwG/O1/m1eAqIbvRMHG2uP6WLTs/j+bVEpck0NY/KDo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315514; c=relaxed/simple;
	bh=tZBF4nZNjq6VfIxiuXMyhzT51/muMoy4XHIqFzzYdj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RMczO2uE095w1IQ9OxVc490SlUvd6PmjU8JvW0U/VGF75bgABz/NTNt/45XPxlQiy7hrFbVo0g6pZ0psCFdrmtyTp01zyRXFapZiHn+hH9kJPbW0nk2Uk2kmPc1rt9kBloTz3ngXY6MyU5LhYyu82Hp5E8ZmBKYApdCnVrmPxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyacrplq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A0BC116C6;
	Tue, 13 Jan 2026 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768315513;
	bh=tZBF4nZNjq6VfIxiuXMyhzT51/muMoy4XHIqFzzYdj0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NyacrplqNNHgHp6M6vXB4n1I/bmyiFv6+OvCT3hSIm+3ORBaGHnQaR4+axQRWOJQB
	 1+c5if0XrPSIEcgnX34Iqymqm6nvimmJT61Rp+VQZUOQPT0x4DtivTDff0V2HQZ5/O
	 fLBMS1bjm7lNUD2q9ikiUOPkD2WFrjzH9232lS1UgdGesW84yJqysT8cbxGS2LdFWR
	 G408fEHbUUo2VUdflKxBPuZd0WLPl7GHKKSwCiQQU168P9mK+PYW+8Kx9YLo9o8wG+
	 R/8EfYSM0wkuc1De7ZhGr6B8a5uv8FnQNMZXASU377huUguVrLcx2GdgGXvt4bbDmn
	 E9JdaPQ6Drwkw==
Message-ID: <14e88ee6ff3ffd671f579d103c53ebe98b4f92e2.camel@kernel.org>
Subject: Re: [PATCH man-pages] man/man2const: document the new F_SETDELEG
 and F_GETDELEG constants
From: Jeff Layton <jlayton@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Tue, 13 Jan 2026 09:45:11 -0500
In-Reply-To: <aWZIQA3GJ9QCVywE@devuan>
References: <20260112-master-v1-1-3948465faaae@kernel.org>
	 <aWZIQA3GJ9QCVywE@devuan>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-13 at 15:13 +0100, Alejandro Colomar wrote:
> Hi Jeff,
>=20
> On Mon, Jan 12, 2026 at 01:47:11PM -0500, Jeff Layton wrote:
> > With v6.19, userland will be able to request a delegation on a file or
> > directory. These new objects act a lot like file leases, but are based
> > on NFSv4 file and directory delegations.
> >=20
> > Add new F_GETDELEG and F_SETDELEG manpages to document them.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  man/man2/fcntl.2                |   5 +
> >  man/man2const/F_GETDELEG.2const | 230 ++++++++++++++++++++++++++++++++=
++++++++
> >  man/man2const/F_SETDELEG.2const |   1 +
> >  3 files changed, 236 insertions(+)
> >=20
> > diff --git a/man/man2/fcntl.2 b/man/man2/fcntl.2
> > index 7f34e332ef9070867c4cdb51e8c5d4991b4fac22..f05d559da149e6a4cc8ae93=
5ffa32111deabd94d 100644
> > --- a/man/man2/fcntl.2
> > +++ b/man/man2/fcntl.2
> > @@ -78,6 +78,11 @@ indicating that the kernel does not recognize this v=
alue.
> >  .BR F_SETLEASE (2const)
> >  .TQ
> >  .BR F_GETLEASE (2const)
> > +.SS Delegations
> > +.TP
> > +.BR F_SETDELEG (2const)
> > +.TQ
> > +.BR F_GETDELEG (2const)
> >  .SS File and directory change notification (dnotify)
> >  .TP
> >  .BR F_NOTIFY (2const)
> > diff --git a/man/man2const/F_GETDELEG.2const b/man/man2const/F_GETDELEG=
.2const
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..60c7e62f8dbcb6f97fda82e=
1c50f34ecacce2aab
> > --- /dev/null
> > +++ b/man/man2const/F_GETDELEG.2const
> > @@ -0,0 +1,230 @@
> > +.\" Copyright, the authors of the Linux man-pages project
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.\"
> > +.TH F_GETDELEG 2const (date) "Linux man-pages (unreleased)"
> > +.SH NAME
> > +F_GETDELEG,
> > +F_SETDELEG
> > +\-
> > +delegations
> > +.SH LIBRARY
> > +Standard C library
> > +.RI ( libc ,\~ \-lc )
> > +.SH SYNOPSIS
> > +.nf
> > +.B #define _GNU_SOURCE
> > +.B #include <fcntl.h>
> > +.P
> > +.EX
> > +/* Argument structure for F_GETDELEG and F_SETDELEG */
>=20
> I'd say this comment seems redundant, given this structure is defined
> in this manual page.
>=20

Ack. Will remove.

> > +struct delegation {
> > +        __u32   d_flags;
> > +        __u16   d_type;
> > +        __u16   __pad;
> > +};
> > +.EE
> > +.P
> > +.BI "int fcntl(int " fd ", F_SETDELEG, struct delegation *" deleg );
>=20
> Is this really not const-qualified?  Does the kernel modify it?
>=20

Yes, it does modify it. F_GETDELEG populates d_type. I have some plans
to expand this interface in the future so F_GETDELEG may eventually
return other fields in there too.

> > +.br
>=20
> This .br seems superfluous.
>=20

You would think, no? But when I remove it, man seems to stick both
lines togther. I really do not grok groff at all.

I'm happy to accept other suggestions on how to fix that though.

> > +.BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
> > +.fi
> > +.SH DESCRIPTION
> > +.SS Delegations
>=20
> If the entire section is within a subsection, I think the subsection is
> redundant, isn't it?
>=20

Oh ok, I cargo-cult copied most of this from F_GETLEASE.man2const, so
this may be there as well.


> > +.B F_SETDELEG
> > +and
> > +.B F_GETDELEG
> > +are used to establish a new delegation,
> > +and retrieve the current delegation, on the open file description
> > +referred to by the file descriptor
>=20
> Just to confirm: one can't retrieve delegations through a different file
> description that refers to the same inode, right?
>=20

Correct. F_GETDELEG just fills out ->d_type with the type of delegation
set on "fd".
 =20
> > +.IR fd .
>=20
> I'd separate the paragraph here.  The above serves as a brief
> introduction of these two APIs, while the following text describes what
> delegations are.
>=20

Ok.

> > +A file delegation is a mechanism whereby the process holding
> > +the delegation (the "delegation holder") is notified (via delivery of =
a signal)
> > +when a process (the "delegation breaker") tries to
> > +.BR open (2)
> > +or
> > +.BR truncate (2)
> > +the file referred to by that file descriptor, or attempts to
> > +.BR unlink (2)
> > +or
> > +.BR rename (2)
> > +the dentry that was originally opened for the file.
> > +.BR F_RDLCK
> > +delegations can also be set on directory file descriptors, in which ca=
se they will
> > +be recalled if there is a create, delete or rename of a dirent within =
the directory.
>=20
> Please use semantic newlines.  See man-pages(7):
>=20
> $ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
>    Use semantic newlines
>      In the source of a manual page, new sentences should be started on
>      new lines, long sentences should be split  into  lines  at  clause
>      breaks  (commas,  semicolons, colons, and so on), and long clauses
>      should be split at phrase boundaries.  This convention,  sometimes
>      known as "semantic newlines", makes it easier to see the effect of
>      patches, which often operate at the level of individual sentences,
>      clauses, or phrases.
>=20

Ok, I'll reformat that.

> > +.TP
> > +.B F_SETDELEG
> > +Set or remove a file or directory delegation according to which of the=
 following
> > +values is specified in the
> > +.IR d_type
>=20
> s/IR/I/
>=20
> IR is for alternating Italics and Roman.
>=20
> Also, it would be good to use '.d_type' notation, for making it easier
> to distinguish struct members.  A few manual pages already do this.
> Thus:
>=20
> 	.I .d_type
>=20
> > +field of
> > +.IR deleg :
>=20
> Maybe we could even simplify this as:
>=20
> 	...
> 	specified in
> 	.IR deleg->d_type :
>=20

Ok

> > +.RS
> > +.TP
> > +.B F_RDLCK
> > +Take out a read delegation.
>=20
> 'Take out' means to remove, but by reading the context, I think this
> instead creates a read delegation, right?  Would it be correct to say
> this?:
>=20
> 	Create a read delegation.
>=20
> (I'm not a native English speaker, so I may be mistaken.)
>=20

Delegations are returnable, so "take out" in the sense of a library
book or some other returnable object. I'll rephrase that, since it's
unclear.

> > +This will cause the calling process to be notified when
> > +the file is opened for writing or is truncated, or when the file is un=
linked or renamed.
> > +A read delegation can be placed only on a file descriptor that
> > +is opened read-only. If
> > +.IR fd
> > +refers to a directory, then the calling process
> > +will be notified if there are changes to filenames within the director=
y, or when the
> > +directory itself is renamed.
> > +.TP
> > +.B F_WRLCK
>=20
> Are we in time to rename this?
>=20
> F_RDLCK blocks essentially writing.
> F_WRLCK blocks both reading and writing.
>=20
> What do you think of this rename:
>=20
> 	RD =3D> WR
> 	WR =3D> RW
>=20

These are constants from file locking. I suppose we could add new
constants that overload those values?

> > +Take out a write delegation.
> > +This will cause the caller to be notified when
> > +the file is opened for reading or writing or is truncated or when the =
file is renamed
> > +or unlinked.  A write delegation may be placed on a file only if there=
 are no
> > +other open file descriptors for the file. The file must be opened for =
write in order
> > +to set a write delegation on it. Write delegations cannot be set on di=
rectory
> > +file descriptors.
> > +.TP
> > +.B F_UNLCK
> > +Remove our delegation from the file.
> > +.RE
> > +.P
> > +Like leases, delegations are associated with an open file description =
(see
> > +.BR open (2)).
> > +This means that duplicate file descriptors (created by, for example,
> > +.BR fork (2)
> > +or
> > +.BR dup (2))
> > +refer to the same delegation, and this delegation may be modified
> > +or released using any of these descriptors.
> > +Furthermore, the delegation is released by either an explicit
> > +.B F_UNLCK
> > +operation on any of these duplicate file descriptors, or when all
> > +such file descriptors have been closed.
> > +.P
> > +An unprivileged process may take out a delegation only on a file whose
> > +UID (owner) matches the filesystem UID of the process.
> > +A process with the
> > +.B CAP_LEASE
> > +capability may take out delegations on arbitrary files or directories.
> > +.TP
> > +.B F_GETDELEG
> > +Indicates what type of delegation is associated with the file descript=
or
> > +.I fd
> > +by setting the
> > +.IR d_type
> > +field in
> > +.IR deleg
> > +to either
> > +.BR F_RDLCK ", " F_WRLCK ", or " F_UNLCK ,
>=20
> Please use a separate line for each:
>=20
> 	.BR F_RDLCK ,
> 	.BR F_WRLCK ,
> 	or
> 	.BR F_UNLCK ,
>=20
> > +indicating, respectively, a read delegation , a write delegation, or n=
o delegation.
>

ACK

> Spurious white space before comma.
>=20

ACK

> > +.P
> > +When a process (the "delegation breaker") performs an activity
> > +that conflicts with a delegation established via
> > +.BR F_SETDELEG ,
> > +the system call is blocked by the kernel and
> > +the kernel notifies the delegation holder by sending it a signal
> > +.RB ( SIGIO
> > +by default).
> > +The delegation holder should respond to receipt of this signal by doin=
g
> > +whatever cleanup is required in preparation for the file to be
> > +accessed by another process (e.g., flushing cached buffers) and
> > +then either remove or downgrade its delegation.
> > +A delegation is removed by performing an
> > +.B F_SETDELEG
> > +operation specifying
> > +.I d_type
> > +in
> > +.I deleg
> > +as
> > +.BR F_UNLCK .
> > +If the delegation holder currently holds a write delegation on the fil=
e,
> > +and the delegation breaker is opening the file for reading,
> > +then it is sufficient for the delegation holder to downgrade
> > +the delegation to a read delegation.
> > +This is done by performing an
> > +.B F_SETDELEG
> > +operation specifying
> > +.I d_type
> > +in
> > +.I deleg
> > +as
> > +.BR F_RDLCK .
> > +.P
> > +If the delegation holder fails to downgrade or remove the delegation w=
ithin
> > +the number of seconds specified in
> > +.IR /proc/sys/fs/lease\-break\-time ,
> > +then the kernel forcibly removes or downgrades the delegation holder's=
 delegation.
> > +.P
> > +Once a delegation break has been initiated,
> > +.B F_GETDELEG
> > +returns the target delegation type in the
> > +.I d_type
> > +field in
> > +.I deleg
> > +(either
> > +.B F_RDLCK
> > +or
> > +.BR F_UNLCK ,
> > +depending on what would be compatible with the delegation breaker)
> > +until the delegation holder voluntarily downgrades or removes the dele=
gation or
> > +the kernel forcibly does so after the delegation break timer expires.
> > +.P
> > +Once the delegation has been voluntarily or forcibly removed or downgr=
aded,
> > +and assuming the delegation breaker has not unblocked its system call,
> > +the kernel permits the delegation breaker's system call to proceed.
> > +.P
> > +If the delegation breaker's blocked system call
> > +is interrupted by a signal handler,
> > +then the system call fails with the error
> > +.BR EINTR ,
> > +but the other steps still occur as described above.
> > +If the delegation breaker is killed by a signal while blocked in
> > +.BR open (2)
> > +or
> > +.BR truncate (2),
> > +then the other steps still occur as described above.
> > +If the delegation breaker specifies the
> > +.B O_NONBLOCK
> > +flag when calling
> > +.BR open (2),
> > +then the call immediately fails with the error
> > +.BR EWOULDBLOCK ,
> > +but the other steps still occur as described above.
> > +.P
> > +The default signal used to notify the delegation holder is
> > +.BR SIGIO ,
> > +but this can be changed using the
> > +.B F_SETSIG
> > +operation to
> > +.BR fcntl ().
> > +If a
> > +.B F_SETSIG
> > +operation is performed (even one specifying
> > +.BR SIGIO ),
> > +and the signal
> > +handler is established using
> > +.BR SA_SIGINFO ,
> > +then the handler will receive a
> > +.I siginfo_t
> > +structure as its second argument, and the
> > +.I si_fd
> > +field of this argument will hold the file descriptor of the file with =
the delegation
> > +that has been accessed by another process.
> > +(This is useful if the caller holds delegations against multiple files=
.)
> > +.SH NOTES
> > +Delegations were designed to implement NFSv4 delegations for the Linux=
 NFS server, and
> > +conform to the delegation semantics described in RFC\ 8881.
>=20
> I'd say the part after the comma is redundant with the STANDARDS
> section.
>=20

Ok.

> > +.SH RETURN VALUE
> > +On success zero is returned. On error, \-1 is returned, and
> > +.I errno
> > +is set to indicate the error. A successful F_GETDELEG call will also u=
pdate the
>=20
> F_GETDELEG should be in bold.
>=20

Ok.

> > +.I d_type
> > +field in the structure to which
> > +.I deleg
> > +points.
> > +.SH ERRORS
> > +See
> > +.BR fcntl (2).
>=20
> I guess there are also errors specific to delegations, right?  I expect
> for example an error if F_SETDELEG is called with F_WRLCK but more file
> descriptors are open for the same file.
>=20

Only if the file descriptor was opened non-blocking. The errors are
basically the same as the ones for leases. I can transplant the
relevant error messages here though.

> > +.SH STANDARDS
> > +Linux, IETF RFC\ 8881.
> > +.SH HISTORY
> > +Linux v6.19.
>=20
> Please remove the 'v'.
>=20

ACK.

> > +.SH SEE ALSO
> > +.BR fcntl (2)
> > diff --git a/man/man2const/F_SETDELEG.2const b/man/man2const/F_SETDELEG=
.2const
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..acabdfc139fb3d753dbf306=
1c31d59332d046c63
> > --- /dev/null
> > +++ b/man/man2const/F_SETDELEG.2const
> > @@ -0,0 +1 @@
> > +.so man2const/F_GETDELEG.2const
>=20
> Thanks!
>=20
>=20
> Have a lovely day!
> Alex

Thank you for the review! I'll update and send a v2.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>

