Return-Path: <linux-fsdevel+bounces-73436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C1ED19620
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16EA53019C7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325CC392B9C;
	Tue, 13 Jan 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLupUiYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D43933E9;
	Tue, 13 Jan 2026 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313630; cv=none; b=iaCEUXZGxugr9T3jDc4XwVVqd8J8z7DcZadBJNuj38aUH1+5fI6RPVps02tNIKNo6+J2iq5xiu2c5/CkE3gOKlZIhHl5VBVJwW0yWKJOKRrO6LHPilWrEvnhKjqcHL3dW/aVsWnbqUt3xW0tKmXgugUOvG5O5ZdE4lcc1JAoNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313630; c=relaxed/simple;
	bh=8rE9EZhCN//ArE0zA6OgzzOj00X5vEshKP0avuPe1K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVNw2lBAWrQZ8eynKvBFv7EFHVW0fPmUpQYlplvsQaKBCCL2LnT0/UvWLOJ/6hD1UOSjMdI9+PPZQKbDwZAjeuM0+ZdYLldvSaQUNojonGCVJ+jlpH9gZozpHVoQjQ7txgfIRhFQJhoAVuuTTfPODVYFAKmTJ3g2Obj8hAYA54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLupUiYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EABC16AAE;
	Tue, 13 Jan 2026 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768313630;
	bh=8rE9EZhCN//ArE0zA6OgzzOj00X5vEshKP0avuPe1K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLupUiYF3yOvRQx9u56A3/AxPJsN4AGJZGzm76Zl2MVR16G5J2Hzp4TTh2R3iC/cd
	 hkUYaFh7XctYIX0PyBvvlN2e/jLArHZYU+DiMD1ZbhQ4b+GOmYNLnZKYD02RuSUOKy
	 D9ptJ/HpWZS5rt44jY4IQ5qeD35NQ+tGJ/2khM1UogeMuNVozG10llZ6+FFIP6fbdT
	 WvFq2qcKKDbWUxNrnUr8jpdNx0W9qIXWyjI2z7SkEtq2PSB1xiPxFoddriBiDO3OwZ
	 KihljBFfrrVJwnAFBqlLfO/ctQ9sisZAMrrLFPCqU8NDC+BNWczKG/qUcQHhQO7H5h
	 N3DictSYGzvKA==
Date: Tue, 13 Jan 2026 15:13:47 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages] man/man2const: document the new F_SETDELEG and
 F_GETDELEG constants
Message-ID: <aWZIQA3GJ9QCVywE@devuan>
References: <20260112-master-v1-1-3948465faaae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="55r3eb63qbqtvp7x"
Content-Disposition: inline
In-Reply-To: <20260112-master-v1-1-3948465faaae@kernel.org>


--55r3eb63qbqtvp7x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages] man/man2const: document the new F_SETDELEG and
 F_GETDELEG constants
Message-ID: <aWZIQA3GJ9QCVywE@devuan>
References: <20260112-master-v1-1-3948465faaae@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260112-master-v1-1-3948465faaae@kernel.org>

Hi Jeff,

On Mon, Jan 12, 2026 at 01:47:11PM -0500, Jeff Layton wrote:
> With v6.19, userland will be able to request a delegation on a file or
> directory. These new objects act a lot like file leases, but are based
> on NFSv4 file and directory delegations.
>=20
> Add new F_GETDELEG and F_SETDELEG manpages to document them.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  man/man2/fcntl.2                |   5 +
>  man/man2const/F_GETDELEG.2const | 230 ++++++++++++++++++++++++++++++++++=
++++++
>  man/man2const/F_SETDELEG.2const |   1 +
>  3 files changed, 236 insertions(+)
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
> index 0000000000000000000000000000000000000000..60c7e62f8dbcb6f97fda82e1c=
50f34ecacce2aab
> --- /dev/null
> +++ b/man/man2const/F_GETDELEG.2const
> @@ -0,0 +1,230 @@
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
> +.P
> +.EX
> +/* Argument structure for F_GETDELEG and F_SETDELEG */

I'd say this comment seems redundant, given this structure is defined
in this manual page.

> +struct delegation {
> +        __u32   d_flags;
> +        __u16   d_type;
> +        __u16   __pad;
> +};
> +.EE
> +.P
> +.BI "int fcntl(int " fd ", F_SETDELEG, struct delegation *" deleg );

Is this really not const-qualified?  Does the kernel modify it?

> +.br

This .br seems superfluous.

> +.BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
> +.fi
> +.SH DESCRIPTION
> +.SS Delegations

If the entire section is within a subsection, I think the subsection is
redundant, isn't it?

> +.B F_SETDELEG
> +and
> +.B F_GETDELEG
> +are used to establish a new delegation,
> +and retrieve the current delegation, on the open file description
> +referred to by the file descriptor

Just to confirm: one can't retrieve delegations through a different file
description that refers to the same inode, right?

> +.IR fd .

I'd separate the paragraph here.  The above serves as a brief
introduction of these two APIs, while the following text describes what
delegations are.

> +A file delegation is a mechanism whereby the process holding
> +the delegation (the "delegation holder") is notified (via delivery of a =
signal)
> +when a process (the "delegation breaker") tries to
> +.BR open (2)
> +or
> +.BR truncate (2)
> +the file referred to by that file descriptor, or attempts to
> +.BR unlink (2)
> +or
> +.BR rename (2)
> +the dentry that was originally opened for the file.
> +.BR F_RDLCK
> +delegations can also be set on directory file descriptors, in which case=
 they will
> +be recalled if there is a create, delete or rename of a dirent within th=
e directory.

Please use semantic newlines.  See man-pages(7):

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
   Use semantic newlines
     In the source of a manual page, new sentences should be started on
     new lines, long sentences should be split  into  lines  at  clause
     breaks  (commas,  semicolons, colons, and so on), and long clauses
     should be split at phrase boundaries.  This convention,  sometimes
     known as "semantic newlines", makes it easier to see the effect of
     patches, which often operate at the level of individual sentences,
     clauses, or phrases.

> +.TP
> +.B F_SETDELEG
> +Set or remove a file or directory delegation according to which of the f=
ollowing
> +values is specified in the
> +.IR d_type

s/IR/I/

IR is for alternating Italics and Roman.

Also, it would be good to use '.d_type' notation, for making it easier
to distinguish struct members.  A few manual pages already do this.
Thus:

	.I .d_type

> +field of
> +.IR deleg :

Maybe we could even simplify this as:

	...
	specified in
	.IR deleg->d_type :

> +.RS
> +.TP
> +.B F_RDLCK
> +Take out a read delegation.

'Take out' means to remove, but by reading the context, I think this
instead creates a read delegation, right?  Would it be correct to say
this?:

	Create a read delegation.

(I'm not a native English speaker, so I may be mistaken.)

> +This will cause the calling process to be notified when
> +the file is opened for writing or is truncated, or when the file is unli=
nked or renamed.
> +A read delegation can be placed only on a file descriptor that
> +is opened read-only. If
> +.IR fd
> +refers to a directory, then the calling process
> +will be notified if there are changes to filenames within the directory,=
 or when the
> +directory itself is renamed.
> +.TP
> +.B F_WRLCK

Are we in time to rename this?

F_RDLCK blocks essentially writing.
F_WRLCK blocks both reading and writing.

What do you think of this rename:

	RD =3D> WR
	WR =3D> RW

> +Take out a write delegation.
> +This will cause the caller to be notified when
> +the file is opened for reading or writing or is truncated or when the fi=
le is renamed
> +or unlinked.  A write delegation may be placed on a file only if there a=
re no
> +other open file descriptors for the file. The file must be opened for wr=
ite in order
> +to set a write delegation on it. Write delegations cannot be set on dire=
ctory
> +file descriptors.
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
> +refer to the same delegation, and this delegation may be modified
> +or released using any of these descriptors.
> +Furthermore, the delegation is released by either an explicit
> +.B F_UNLCK
> +operation on any of these duplicate file descriptors, or when all
> +such file descriptors have been closed.
> +.P
> +An unprivileged process may take out a delegation only on a file whose
> +UID (owner) matches the filesystem UID of the process.
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
> +to either
> +.BR F_RDLCK ", " F_WRLCK ", or " F_UNLCK ,

Please use a separate line for each:

	.BR F_RDLCK ,
	.BR F_WRLCK ,
	or
	.BR F_UNLCK ,

> +indicating, respectively, a read delegation , a write delegation, or no =
delegation.

Spurious white space before comma.

> +.P
> +When a process (the "delegation breaker") performs an activity
> +that conflicts with a delegation established via
> +.BR F_SETDELEG ,
> +the system call is blocked by the kernel and
> +the kernel notifies the delegation holder by sending it a signal
> +.RB ( SIGIO
> +by default).
> +The delegation holder should respond to receipt of this signal by doing
> +whatever cleanup is required in preparation for the file to be
> +accessed by another process (e.g., flushing cached buffers) and
> +then either remove or downgrade its delegation.
> +A delegation is removed by performing an
> +.B F_SETDELEG
> +operation specifying
> +.I d_type
> +in
> +.I deleg
> +as
> +.BR F_UNLCK .
> +If the delegation holder currently holds a write delegation on the file,
> +and the delegation breaker is opening the file for reading,
> +then it is sufficient for the delegation holder to downgrade
> +the delegation to a read delegation.
> +This is done by performing an
> +.B F_SETDELEG
> +operation specifying
> +.I d_type
> +in
> +.I deleg
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
> +(either
> +.B F_RDLCK
> +or
> +.BR F_UNLCK ,
> +depending on what would be compatible with the delegation breaker)
> +until the delegation holder voluntarily downgrades or removes the delega=
tion or
> +the kernel forcibly does so after the delegation break timer expires.
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
> +(This is useful if the caller holds delegations against multiple files.)
> +.SH NOTES
> +Delegations were designed to implement NFSv4 delegations for the Linux N=
FS server, and
> +conform to the delegation semantics described in RFC\ 8881.

I'd say the part after the comma is redundant with the STANDARDS
section.

> +.SH RETURN VALUE
> +On success zero is returned. On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error. A successful F_GETDELEG call will also upd=
ate the

F_GETDELEG should be in bold.

> +.I d_type
> +field in the structure to which
> +.I deleg
> +points.
> +.SH ERRORS
> +See
> +.BR fcntl (2).

I guess there are also errors specific to delegations, right?  I expect
for example an error if F_SETDELEG is called with F_WRLCK but more file
descriptors are open for the same file.

> +.SH STANDARDS
> +Linux, IETF RFC\ 8881.
> +.SH HISTORY
> +Linux v6.19.

Please remove the 'v'.

> +.SH SEE ALSO
> +.BR fcntl (2)
> diff --git a/man/man2const/F_SETDELEG.2const b/man/man2const/F_SETDELEG.2=
const
> new file mode 100644
> index 0000000000000000000000000000000000000000..acabdfc139fb3d753dbf3061c=
31d59332d046c63
> --- /dev/null
> +++ b/man/man2const/F_SETDELEG.2const
> @@ -0,0 +1 @@
> +.so man2const/F_GETDELEG.2const

Thanks!


Have a lovely day!
Alex

> ---
> base-commit: 753ac20a01007417aa993e70d290f51840e2f477
> change-id: 20260112-master-23a1ede99836
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--55r3eb63qbqtvp7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlmUxQACgkQ64mZXMKQ
wqnBPRAAnHPU5Jhmn5yUnAJ9XCQz/lQvT3qea67oW7mRWJnn2h2/ZmthMiH0pDuC
Zg6XTCZCQYeAVc5WpvqqPeQ4haI3e454XK6DTYSoCz7LhII7ImR9MooZmqzIbHW2
AZA0oAOK3g/mG40e8W9kza5KkA+wdl3KsnbQieGuHhVfJiwl298rdvhC5RqOy15/
gYB3AW0KiWpdcfelNgbZtJI1zv3PR9eKMJNH9SKC+hWjg7z9aZIFghKY3XH5Rj30
NfwItJx9hAmEgt1jxYtUhjBE2jCSBToCUiKXYM+TuVuQ9R9o+fPQc3eSrVOAwJ1h
gmAeb5vR7OcBp7Dlc7V1YwUEtcmZaip4JGBZftp587aYCFDW2X9wp76+dmwdIQef
7KyV1+6KjOfeg9cZicpz1lQX8mASFVC4dTH4WrkF7THMpI+9GSkF7ZFIXyHEYK1N
iGfm1uM04q6R7mbZHE/HjnIZQs7wW8vj3USAIiRYFjFlwxrTY+5DPWLDUsH0EiKq
2miJ3c3MqdOIl/DBaX1CTaBCV8Ry2RL9H2KAvYHYJ1lKdmhw2WzFlVQhkZv6+9BS
oxzRseY0ygW1YlWG5XbARFUJ/ktbOglfruJE6P2pyW0/TUaM8147HCUmYXpJflkg
b9oqHRnytlXiR2KfuQYe5BV1PC/AcFDJraQ6Sho7j0rs/hIY0IA=
=ebAI
-----END PGP SIGNATURE-----

--55r3eb63qbqtvp7x--

