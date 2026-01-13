Return-Path: <linux-fsdevel+bounces-73447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C28BD19C43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9D18301966F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605C341678;
	Tue, 13 Jan 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1WS/jpV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE43921D8;
	Tue, 13 Jan 2026 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317127; cv=none; b=nsJ+jNmHKUp1JsaRsdPMOpMKcdXMoKiQw6a8Yy6JH9JHcyReSOxRC1dgbrWesO+vvay3RqfRVtbRmzyWpOfjvozH6xqYRpW0yVbcjoBqLHYhNF7nuKWqZ4QImfDQEHgcXA2CkftDzKSqdEpUbmOp+3495zxP2a9beTlp/lRvVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317127; c=relaxed/simple;
	bh=ArbwRXqJCdndWBhXEjzSzZqSs76J6vIFx5ucV2vE5y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/WmIKwqIy2+sDYqE1Y9to9I6Xn3EUVdWgWPqb/B7UgmBjrSbAd1dEJ3PeRGs4e8xhB4apKQiTM12aWdYWUzRFDcvskOtJyC35mFaCawEelGkKdgW4BlsZBZYI+6zHy/NbRJ2GBZGcxwjCQ63QkiOFSf0YTF4LvYdweDHmOUi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1WS/jpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744F8C116C6;
	Tue, 13 Jan 2026 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317127;
	bh=ArbwRXqJCdndWBhXEjzSzZqSs76J6vIFx5ucV2vE5y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1WS/jpVKoDrlt86VFk2vFlZslFuBN7NYvfoXHLcyYRXqRMu/dGDYwsODEOrqovcH
	 cjmuwYWWQ+sRguCX91U+FrA0SccxT/5oRaBdaqE8wfVFvVEEW9uLAnrWRebFQ+X6CE
	 arOk1dTz7dVXn4oLsMnEkXatVKztVW8ORcTLSm2GIr2Q/m5bZxDP9hWATv9XS+cq8g
	 URSBHQlAJy+z1N+bxfxwUuAzDE0YHqikcvWb1v82w1zItDQM4i4Hgg3d4yfNoz+Vl0
	 Tkew6zUZs25v1BuxMD9ktHCgZoBgEfFfBna3VjXYHqVWFXB4t+LKsoQgJi3a0nIPfb
	 rRpMMeC5Du5Lw==
Date: Tue, 13 Jan 2026 16:12:04 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages] man/man2const: document the new F_SETDELEG and
 F_GETDELEG constants
Message-ID: <aWZecUT7o_cYH5Rt@devuan>
References: <20260112-master-v1-1-3948465faaae@kernel.org>
 <aWZIQA3GJ9QCVywE@devuan>
 <14e88ee6ff3ffd671f579d103c53ebe98b4f92e2.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncbzsuplimaijtm4"
Content-Disposition: inline
In-Reply-To: <14e88ee6ff3ffd671f579d103c53ebe98b4f92e2.camel@kernel.org>


--ncbzsuplimaijtm4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages] man/man2const: document the new F_SETDELEG and
 F_GETDELEG constants
Message-ID: <aWZecUT7o_cYH5Rt@devuan>
References: <20260112-master-v1-1-3948465faaae@kernel.org>
 <aWZIQA3GJ9QCVywE@devuan>
 <14e88ee6ff3ffd671f579d103c53ebe98b4f92e2.camel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <14e88ee6ff3ffd671f579d103c53ebe98b4f92e2.camel@kernel.org>

Hi Jeff,

On Tue, Jan 13, 2026 at 09:45:11AM -0500, Jeff Layton wrote:
[...]
> > > +.SH SYNOPSIS
> > > +.nf
> > > +.B #define _GNU_SOURCE
> > > +.B #include <fcntl.h>
> > > +.P
> > > +.EX
> > > +/* Argument structure for F_GETDELEG and F_SETDELEG */
> >=20
> > I'd say this comment seems redundant, given this structure is defined
> > in this manual page.
> >=20
>=20
> Ack. Will remove.
>=20
> > > +struct delegation {
> > > +        __u32   d_flags;
> > > +        __u16   d_type;
> > > +        __u16   __pad;
> > > +};
> > > +.EE
> > > +.P
> > > +.BI "int fcntl(int " fd ", F_SETDELEG, struct delegation *" deleg );
> >=20
> > Is this really not const-qualified?  Does the kernel modify it?
> >=20
>=20
> Yes, it does modify it. F_GETDELEG populates d_type. I have some plans
> to expand this interface in the future so F_GETDELEG may eventually
> return other fields in there too.

But I mean F_SETDELEG (with an S).  I expect the setter wouldn't modify,
right?

>=20
> > > +.br
> >=20
> > This .br seems superfluous.
> >=20
>=20
> You would think, no? But when I remove it, man seems to stick both
> lines togther. I really do not grok groff at all.
>=20
> I'm happy to accept other suggestions on how to fix that though.

Ahhh, sorry!  I see why.  So, we have EX/EE nested within nf/fi.  These
don't nest correctly, so one should close nf/fi, then do EX/EE, and then
open a new nf/fi pair.

> > > +.BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
> > > +.fi
> > > +.SH DESCRIPTION
> > > +.SS Delegations
> >=20
> > If the entire section is within a subsection, I think the subsection is
> > redundant, isn't it?
> >=20
>=20
> Oh ok, I cargo-cult copied most of this from F_GETLEASE.man2const, so
> this may be there as well.

I was supposing you had done that, but didn't figure out from which.  :)
Now it makes sense.  Yes, I should remove that from
F_GETLEASE.man2const.  It is a left-over from when I split the page
=66rom fcntl(2).

> > > +.B F_SETDELEG
> > > +and
> > > +.B F_GETDELEG
> > > +are used to establish a new delegation,
> > > +and retrieve the current delegation, on the open file description
> > > +referred to by the file descriptor
> >=20
> > Just to confirm: one can't retrieve delegations through a different file
> > description that refers to the same inode, right?
> >=20
>=20
> Correct. F_GETDELEG just fills out ->d_type with the type of delegation
> set on "fd".

Thanks!

> > > +.IR fd .
> >=20
> > I'd separate the paragraph here.  The above serves as a brief
> > introduction of these two APIs, while the following text describes what
> > delegations are.
> >=20
>=20
> Ok.
>=20
> > > +A file delegation is a mechanism whereby the process holding
> > > +the delegation (the "delegation holder") is notified (via delivery o=
f a signal)
> > > +when a process (the "delegation breaker") tries to
> > > +.BR open (2)
> > > +or
> > > +.BR truncate (2)
> > > +the file referred to by that file descriptor, or attempts to
> > > +.BR unlink (2)
> > > +or
> > > +.BR rename (2)
> > > +the dentry that was originally opened for the file.
> > > +.BR F_RDLCK
> > > +delegations can also be set on directory file descriptors, in which =
case they will
> > > +be recalled if there is a create, delete or rename of a dirent withi=
n the directory.
> >=20
> > Please use semantic newlines.  See man-pages(7):
> >=20
> > $ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
> >    Use semantic newlines
> >      In the source of a manual page, new sentences should be started on
> >      new lines, long sentences should be split  into  lines  at  clause
> >      breaks  (commas,  semicolons, colons, and so on), and long clauses
> >      should be split at phrase boundaries.  This convention,  sometimes
> >      known as "semantic newlines", makes it easier to see the effect of
> >      patches, which often operate at the level of individual sentences,
> >      clauses, or phrases.
> >=20
>=20
> Ok, I'll reformat that.

This applies also to the rest of the page, BTW.

> > > +.TP
> > > +.B F_SETDELEG
> > > +Set or remove a file or directory delegation according to which of t=
he following
> > > +values is specified in the
> > > +.IR d_type
> >=20
> > s/IR/I/
> >=20
> > IR is for alternating Italics and Roman.
> >=20
> > Also, it would be good to use '.d_type' notation, for making it easier
> > to distinguish struct members.  A few manual pages already do this.
> > Thus:
> >=20
> > 	.I .d_type
> >=20
> > > +field of
> > > +.IR deleg :
> >=20
> > Maybe we could even simplify this as:
> >=20
> > 	...
> > 	specified in
> > 	.IR deleg->d_type :
> >=20
>=20
> Ok
>=20
> > > +.RS
> > > +.TP
> > > +.B F_RDLCK
> > > +Take out a read delegation.
> >=20
> > 'Take out' means to remove, but by reading the context, I think this
> > instead creates a read delegation, right?  Would it be correct to say
> > this?:
> >=20
> > 	Create a read delegation.
> >=20
> > (I'm not a native English speaker, so I may be mistaken.)
> >=20
>=20
> Delegations are returnable, so "take out" in the sense of a library
> book or some other returnable object. I'll rephrase that, since it's
> unclear.
>=20
> > > +This will cause the calling process to be notified when
> > > +the file is opened for writing or is truncated, or when the file is =
unlinked or renamed.
> > > +A read delegation can be placed only on a file descriptor that
> > > +is opened read-only. If
> > > +.IR fd
> > > +refers to a directory, then the calling process
> > > +will be notified if there are changes to filenames within the direct=
ory, or when the
> > > +directory itself is renamed.
> > > +.TP
> > > +.B F_WRLCK
> >=20
> > Are we in time to rename this?
> >=20
> > F_RDLCK blocks essentially writing.
> > F_WRLCK blocks both reading and writing.
> >=20
> > What do you think of this rename:
> >=20
> > 	RD =3D> WR
> > 	WR =3D> RW
> >=20
>=20
> These are constants from file locking. I suppose we could add new
> constants that overload those values?

Ahhh, so this is already a historical thing.  Indeed:

	$ grep -rn F_RDLCK man/
	man/man2const/F_GETLEASE.2const:45:.B F_RDLCK
	man/man2const/F_GETLEASE.2const:89:.BR F_RDLCK ", " F_WRLCK ", or " F_UNLC=
K ,
	man/man2const/F_GETLEASE.2const:123:.BR F_RDLCK .
	man/man2const/F_GETLEASE.2const:133:.B F_RDLCK
	man/man2/fcntl_locking.2:52:    short l_type;    /* Type of lock: F_RDLCK,
	man/man2/fcntl_locking.2:123:.RB ( F_RDLCK )
	man/man2/fcntl_locking.2:143:.B F_RDLCK
	man/man2/fcntl_locking.2:360:.B F_RDLCK

I guess that answers my question: no, we can't rename these.
Let's keep the historical names.

> > > +Take out a write delegation.
> > > +This will cause the caller to be notified when
> > > +the file is opened for reading or writing or is truncated or when th=
e file is renamed
> > > +or unlinked.  A write delegation may be placed on a file only if the=
re are no
> > > +other open file descriptors for the file. The file must be opened fo=
r write in order
> > > +to set a write delegation on it. Write delegations cannot be set on =
directory
> > > +file descriptors.
> > > +.TP
> > > +.B F_UNLCK
> > > +Remove our delegation from the file.
> > > +.RE
> > > +.P
> > > +Like leases, delegations are associated with an open file descriptio=
n (see
> > > +.BR open (2)).
> > > +This means that duplicate file descriptors (created by, for example,
> > > +.BR fork (2)
> > > +or
> > > +.BR dup (2))
> > > +refer to the same delegation, and this delegation may be modified
> > > +or released using any of these descriptors.
> > > +Furthermore, the delegation is released by either an explicit
> > > +.B F_UNLCK
> > > +operation on any of these duplicate file descriptors, or when all
> > > +such file descriptors have been closed.
> > > +.P
> > > +An unprivileged process may take out a delegation only on a file who=
se
> > > +UID (owner) matches the filesystem UID of the process.
> > > +A process with the
> > > +.B CAP_LEASE
> > > +capability may take out delegations on arbitrary files or directorie=
s.
> > > +.TP
> > > +.B F_GETDELEG
> > > +Indicates what type of delegation is associated with the file descri=
ptor
> > > +.I fd
> > > +by setting the
> > > +.IR d_type
> > > +field in
> > > +.IR deleg
> > > +to either
> > > +.BR F_RDLCK ", " F_WRLCK ", or " F_UNLCK ,
> >=20
> > Please use a separate line for each:
> >=20
> > 	.BR F_RDLCK ,
> > 	.BR F_WRLCK ,
> > 	or
> > 	.BR F_UNLCK ,
> >=20
> > > +indicating, respectively, a read delegation , a write delegation, or=
 no delegation.
> >
>=20
> ACK
>=20
> > Spurious white space before comma.
> >=20
>=20
> ACK
>=20
> > > +.P
> > > +When a process (the "delegation breaker") performs an activity
> > > +that conflicts with a delegation established via
> > > +.BR F_SETDELEG ,
> > > +the system call is blocked by the kernel and
> > > +the kernel notifies the delegation holder by sending it a signal
> > > +.RB ( SIGIO
> > > +by default).
> > > +The delegation holder should respond to receipt of this signal by do=
ing
> > > +whatever cleanup is required in preparation for the file to be
> > > +accessed by another process (e.g., flushing cached buffers) and
> > > +then either remove or downgrade its delegation.
> > > +A delegation is removed by performing an
> > > +.B F_SETDELEG
> > > +operation specifying
> > > +.I d_type
> > > +in
> > > +.I deleg
> > > +as
> > > +.BR F_UNLCK .
> > > +If the delegation holder currently holds a write delegation on the f=
ile,
> > > +and the delegation breaker is opening the file for reading,
> > > +then it is sufficient for the delegation holder to downgrade
> > > +the delegation to a read delegation.
> > > +This is done by performing an
> > > +.B F_SETDELEG
> > > +operation specifying
> > > +.I d_type
> > > +in
> > > +.I deleg
> > > +as
> > > +.BR F_RDLCK .
> > > +.P
> > > +If the delegation holder fails to downgrade or remove the delegation=
 within
> > > +the number of seconds specified in
> > > +.IR /proc/sys/fs/lease\-break\-time ,
> > > +then the kernel forcibly removes or downgrades the delegation holder=
's delegation.
> > > +.P
> > > +Once a delegation break has been initiated,
> > > +.B F_GETDELEG
> > > +returns the target delegation type in the
> > > +.I d_type
> > > +field in
> > > +.I deleg
> > > +(either
> > > +.B F_RDLCK
> > > +or
> > > +.BR F_UNLCK ,
> > > +depending on what would be compatible with the delegation breaker)
> > > +until the delegation holder voluntarily downgrades or removes the de=
legation or
> > > +the kernel forcibly does so after the delegation break timer expires.
> > > +.P
> > > +Once the delegation has been voluntarily or forcibly removed or down=
graded,
> > > +and assuming the delegation breaker has not unblocked its system cal=
l,
> > > +the kernel permits the delegation breaker's system call to proceed.
> > > +.P
> > > +If the delegation breaker's blocked system call
> > > +is interrupted by a signal handler,
> > > +then the system call fails with the error
> > > +.BR EINTR ,
> > > +but the other steps still occur as described above.
> > > +If the delegation breaker is killed by a signal while blocked in
> > > +.BR open (2)
> > > +or
> > > +.BR truncate (2),
> > > +then the other steps still occur as described above.
> > > +If the delegation breaker specifies the
> > > +.B O_NONBLOCK
> > > +flag when calling
> > > +.BR open (2),
> > > +then the call immediately fails with the error
> > > +.BR EWOULDBLOCK ,
> > > +but the other steps still occur as described above.
> > > +.P
> > > +The default signal used to notify the delegation holder is
> > > +.BR SIGIO ,
> > > +but this can be changed using the
> > > +.B F_SETSIG
> > > +operation to
> > > +.BR fcntl ().
> > > +If a
> > > +.B F_SETSIG
> > > +operation is performed (even one specifying
> > > +.BR SIGIO ),
> > > +and the signal
> > > +handler is established using
> > > +.BR SA_SIGINFO ,
> > > +then the handler will receive a
> > > +.I siginfo_t
> > > +structure as its second argument, and the
> > > +.I si_fd
> > > +field of this argument will hold the file descriptor of the file wit=
h the delegation
> > > +that has been accessed by another process.
> > > +(This is useful if the caller holds delegations against multiple fil=
es.)
> > > +.SH NOTES
> > > +Delegations were designed to implement NFSv4 delegations for the Lin=
ux NFS server, and
> > > +conform to the delegation semantics described in RFC\ 8881.
> >=20
> > I'd say the part after the comma is redundant with the STANDARDS
> > section.
> >=20
>=20
> Ok.
>=20
> > > +.SH RETURN VALUE
> > > +On success zero is returned. On error, \-1 is returned, and
> > > +.I errno
> > > +is set to indicate the error. A successful F_GETDELEG call will also=
 update the
> >=20
> > F_GETDELEG should be in bold.
> >=20
>=20
> Ok.
>=20
> > > +.I d_type
> > > +field in the structure to which
> > > +.I deleg
> > > +points.
> > > +.SH ERRORS
> > > +See
> > > +.BR fcntl (2).
> >=20
> > I guess there are also errors specific to delegations, right?  I expect
> > for example an error if F_SETDELEG is called with F_WRLCK but more file
> > descriptors are open for the same file.
> >=20
>=20
> Only if the file descriptor was opened non-blocking. The errors are
> basically the same as the ones for leases. I can transplant the
> relevant error messages here though.

Hmm, I see the F_SETLEASE page doesn't document those either.

I think it would be good to document the errors, and in F_GETLEASE too,
if you can.  (Feel free to leave that for a later patch.)

> > > +.SH STANDARDS
> > > +Linux, IETF RFC\ 8881.
> > > +.SH HISTORY
> > > +Linux v6.19.
> >=20
> > Please remove the 'v'.
> >=20
>=20
> ACK.
>=20
> > > +.SH SEE ALSO
> > > +.BR fcntl (2)
> > > diff --git a/man/man2const/F_SETDELEG.2const b/man/man2const/F_SETDEL=
EG.2const
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..acabdfc139fb3d753dbf3=
061c31d59332d046c63
> > > --- /dev/null
> > > +++ b/man/man2const/F_SETDELEG.2const
> > > @@ -0,0 +1 @@
> > > +.so man2const/F_GETDELEG.2const
> >=20
> > Thanks!
> >=20
> >=20
> > Have a lovely day!
> > Alex
>=20
> Thank you for the review! I'll update and send a v2.

Thanks!


Cheers,
Alex

>=20
> Cheers,
> --=20
> Jeff Layton <jlayton@kernel.org>

--=20
<https://www.alejandro-colomar.es>

--ncbzsuplimaijtm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlmYL4ACgkQ64mZXMKQ
wqnuxQ/+JmEBazd+TQtVuTNT1EU9I5pafDjFA6nrt075fNFN5jDVv0vbMYBCFn15
f+nZKZD0pGiIcVJA2QVOhpg1JBWGnQmyG9Qax+XCZ0YENq5+1rq1OPeYmY2NFb2R
XeqwJBDC+TvXMuPZoQpcLVXMVJHY4VUFJsrPJJ9OEU4tuwJpe3ZctpJnuHHXjUze
ZxLg7+6ZVPZ3XvEKGeuKi3qoxs1GNBH8x/wfAG233JO4BUeMSoXAaqw800sY5oWW
bfYa8TlHSeEeGHXNvTCPH+cBmUzZrBjufA0y1Y/eFnlwWrcW1JwQ9jK3YXk1NrKe
29JVnm1eDHoui1/JGeshNajEuGHseg+dKNtZ9pHOTPaJCcr08Szh6FTh1M9Q2eLc
yJbEo4MbQWl0EqqY7rlHMP/rU0LMw6Lck6h8v8IdYall8+KCHWbsTgMw9mvzdw1s
WOIqN6dCVbq3Foo7vqmqwiHzz97LNMadkTeC3m+GhIjmpwsfrewVEttLsfu3vZE9
nt2l6sdYMWSwVrQxkMmu1EhmtXoTA9FFyiNkKCVHjd6eg70TaQtwaxhEFZR1Nxt8
V0kwFoTm7bqPE6id2Wa9pSBXkL1nFYyEAjbwbmTim8L6PxLHzCTKmcMKysazj3ed
EHGIDajTNZKOoA76hbkUCd+fee1LH0ilPMTjqS+3lsoDIoQAiyg=
=VQ5I
-----END PGP SIGNATURE-----

--ncbzsuplimaijtm4--

