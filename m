Return-Path: <linux-fsdevel+bounces-74725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHSBJWbyb2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:23:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4015D4C2EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C328F84EDE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD813AA19D;
	Tue, 20 Jan 2026 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThBtH3Kj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAD3254AE;
	Tue, 20 Jan 2026 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941343; cv=none; b=Vb8gLv/A/LPm8I8243qla5Ge6i139gpSoLwIFnOzHXmdxnPqI/ALGoMFfw7DhTp8tFZPvSzcJ6RIqFGzhRP/6MXvgAUOYPSKW8Sb4836kvuLjl8EYSmOGMKUhiQ/yW7TENNwHBGnWiL4BSW3k4Fjs12O2nL7CJgh9U00H+eEejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941343; c=relaxed/simple;
	bh=5CR3ur4jX2sNhhboCy/HHEZ/XOVUid6khWeDsS7Q5vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWmuAiJpNuSADVlApmqHReungpWSH/olh9R1WVCOcuBIG6c6qPq5La/gZjeCCIMPzgFTnrpU3G3EVJjSHqof6hgnShy5WiQ0afMwYtfcC03QsqPZn6ROqgBQDANKVixS176dP38DLbMuXlu3ICRP77FfwiX24+je8EB5+hegSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThBtH3Kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5A2C16AAE;
	Tue, 20 Jan 2026 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941343;
	bh=5CR3ur4jX2sNhhboCy/HHEZ/XOVUid6khWeDsS7Q5vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThBtH3KjlmvkdQNTIEYHjLBStvlPUWsDPk2yhknC4/nfWXAjbOojiKqtHezOdwFTF
	 mL+kPVD5e/YyjbrAu5QRYHLTmDdAoEOLRvtbyweWxorlmgp36RWZghAlKHz2hNkTR4
	 MR/7Bg/j8MPfAwfKfMtTkaKyL+R+VDg4n02UT5BMXPTec8hQEDLipkFh5NlOBajXX3
	 LHEewDsBByht+RY0ABYUScPk4Sj4+7yupu9enYUtmRtjbIIH4v83x0yedmMgCqG4dD
	 yZ/WLToCfFwa8pAs14Nv6FqmVXnKmEQB23BVjRk0d+tnd2XTxWVNB/wQVl1PhyIWL7
	 bVwur3h5n+Tsw==
Date: Tue, 20 Jan 2026 21:35:39 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: Zack Weinberg <zack@owlfolio.org>, 
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <aW_jz7nucPBjhu0C@devuan>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d5j2slyj4lseju6b"
Content-Disposition: inline
In-Reply-To: <20260120174659.GE6263@brightrain.aerifal.cx>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74725-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4015D4C2EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--d5j2slyj4lseju6b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: Zack Weinberg <zack@owlfolio.org>, 
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <aW_jz7nucPBjhu0C@devuan>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
MIME-Version: 1.0
In-Reply-To: <20260120174659.GE6263@brightrain.aerifal.cx>

Hi Rich, Zack,

On Tue, Jan 20, 2026 at 12:46:59PM -0500, Rich Felker wrote:
> On Tue, Jan 20, 2026 at 12:05:52PM -0500, Zack Weinberg wrote:
> > > On Fri, May 23, 2025 at 02:10:57PM -0400, Zack Weinberg wrote:

[...]

> > Now, the abstract correct behavior is secondary to the fact that we
> > know there are both systems where close should not be retried after
> > EINTR (Linux) and systems where the fd is still open after EINTR
> > (HP-UX).  But it is my position that *portable code* should assume the
> > Linux behavior, because that is the safest option.  If you assume the
> > HP-UX behavior on a machine that implements the Linux behavior, you
> > might close some unrelated file out from under yourself (probably but
> > not necessarily a different thread).  If you assume the Linux behavior
> > on a machine that implements the HP-UX behavior, you have leaked a
> > file descriptor; the worst things that can do are much less severe.
>=20
> Unfortunately, regardless of what happens, code portable to old
> systems needs to avoid getting in the situation to begin with. By
> either not installing interrupting signal handlers or blocking EINTR
> around close.

[...]

> > > While I agree with all of this, I think the tone is way too
> > > proscriptive. The man pages are to document the behaviors, not tell
> > > people how to program.
> >=20
> > I could be persuaded to tone it down a little but in this case I think
> > the man page's job *is* to tell people how to program.  We know lots of
> > existing code has gotten the fine details of close() wrong and we are
> > trying to document how to do it right.
>=20
> No, the job of the man pages absolutely is not "to tell people how to
> program". It's to document behaviors. They are not a programming
> tutorial. They are not polemic diatribes. They are unbiased statements
> of facts. Facts of what the standards say and what implementations do,
> that equip programmers with the knowledge they need to make their own
> informed decisions, rather than blindly following what someone who
> thinks they know better told them to do.

This reminds me a little bit of the realloc(p,0) fiasco of C89 and
glibc.

In most cases, I agree with you that manual pages are and should be
aseptic, there are cases where I think the manual page needs to be
tutorial.  Especially when there's such a mess, we need to both explain
all the possible behaviors (or at least mention them to some degree).

But for example, there's the case of realloc(p,0), where we have
a fiasco that was pushed by a compoundment of wrong decisions by the
C Committee, and prior to that from System V.  We're a bit lucky that
C17 accidentally broke it so badly that we now have it as UB, and that
gives us the opportunity to fix it now (which BTW might also be the case
for close(2)).

In the case of realloc(3), I went and documented in the manual page that
glibc is broken, and that ISO C is also broken.

	STANDARDS
	     malloc()
	     free()
	     calloc()
	     realloc()
		    C23, POSIX.1=E2=80=902024.

	     reallocarray()
		    POSIX.1=E2=80=902024.

	   realloc(p, 0)
	     The  behavior of realloc(p, 0) in glibc doesn=E2=80=99t conform to
	     any of C99, C11, POSIX.1=E2=80=902001, POSIX.1=E2=80=902004, POSIX.1=
=E2=80=902008,
	     POSIX.1=E2=80=902013,  POSIX.1=E2=80=902017,  or  POSIX.1=E2=80=90202=
4.   The  C17
	     specification  was changed to make it conforming, but that
	     specification made it impossible to write code that  reli=E2=80=90
	     ably  determines if the input pointer is freed after real=E2=80=90
	     loc(p, 0), and C23 changed it again to make this undefined
	     behavior, acknowledging that  the  C17  specification  was
	     broad enough, so that undefined behavior wasn=E2=80=99t worse than
	     that.

	     reallocarray() suffers the same issues in glibc.

	     musl  libc  and  the BSDs conform to all versions of ISO C
	     and POSIX.1.

	     gnulib provides the realloc=E2=80=90posix module,  which  provides
	     wrappers  realloc() and reallocarray() that conform to all
	     versions of ISO C and POSIX.1.

	     There=E2=80=99s a proposal to standardize the BSD behavior: https:
	     //www.open-std.org/jtc1/sc22/wg14/www/docs/n3621.txt.

	HISTORY
	     malloc()
	     free()
	     calloc()
	     realloc()
		    POSIX.1=E2=80=902001, C89.

	     reallocarray()
		    glibc 2.26.  OpenBSD 5.6, FreeBSD 11.0.

	     malloc() and related functions rejected sizes greater than
	     PTRDIFF_MAX starting in glibc 2.30.

	     free() preserved errno starting in glibc 2.33.

	   realloc(p, 0)
	     C89 was ambiguous in its specification of  realloc(p,  0).
	     C99 partially fixed this.

	     The  original implementation in glibc would have been con=E2=80=90
	     forming to C99.  However, and ironically, trying to comply
	     with C99 before the standard was released,  glibc  changed
	     its  behavior  in glibc 2.1.1 into something that ended up
	     not conforming to the final C99 specification (but this is
	     debated, as the wording of the standard seems self=E2=80=90contra=E2=
=80=90
	     dicting).

	...

	BUGS
	     Programmers  would  naturally  expect  by  induction  that
	     realloc(p, size)  is  consistent  with  free(p)  and  mal=E2=80=90
	     loc(size),  as  that  is the behavior in the general case.
	     This is not explicitly required by  POSIX.1=E2=80=902024  or  C11,
	     but  all  conforming  implementations  are consistent with
	     that.

	     The glibc implementation of realloc()  is  not  consistent
	     with  that,  and as a consequence, it is dangerous to call
	     realloc(p, 0) in glibc.

	     A  trivial  workaround  for  glibc  is   calling   it   as
	     realloc(p, size?size:1).

	     The  workaround for reallocarray() in glibc =E2=80=94=E2=80=94which s=
hares
	     the         same          bug=E2=80=94=E2=80=94          would       =
   be
	     reallocarray(p, n?n:1, size?size:1).


Apart from documenting that glibc and ISO C are broken, we document how
to best deal with it (see the last paragraph in BUGS).  This is
necessary because I fear that just by documenting the different
behaviors, programmers would still not know what to do with that.
Just take into account that even several members of the committee don't
know how to deal with it.

I'd be willing to have something similar for close(2).


Have a lovely night!
Alex

P.S.:  I have great news about realloc(p,0)!  Microsoft is on-board with
the change.  They told me they like the proposal, and are willing to
fix their realloc(3) implementation.  They'll now conduct tests to make
sure it doesn't break anything too badly, and will come back to me with
any feedback they have from those tests.

I'll put the standards proposal for realloc(3) on hold, waiting for
Microsoft's feedback.

> > > Aside: the reason EINTR *has to* be specified this way is that pthread
> > > cancellation is aligned with EINTR. If EINTR were defined to have
> > > closed the fd, then acting on cancellation during close would also
> > > have closed the fd, but the cancellation handler would have no way to
> > > distinguish this, leading to a situation where you're forced to either
> > > leak fds or introduce a double-close vuln.
> >=20
> > The correct way to address this would be to make close() not be a
> > cancellation point.
>=20
> This would also be a desirable change, one I would support if other
> implementors are on-board with pushing for it.
>=20
> > > An outline of what I'd like to see instead:
> > >
> > > - Clear explanation of why double-close is a serious bug that must
> > >   always be avoided. (I think we all agree on this.)
> > >
> > > - Statement that the historical Linux/glibc behavior and current POSIX
> > >   requirement differ, without language that tries to paint the POSIX
> > >   behavior as a HP-UX bug/quirk. Possibly citing real sources/history
> > >   of the issue (Austin Group tracker items 529, 614; maybe others).
> > >
> > > - Consequence of just assuming the Linux behavior (fd leaks on
> > >   conforming systems).
> > >
> > > - Consequences of assuming the POSIX behavior (double-close vulns on
> > >   GNU/Linux, maybe others).
> > >
> > > - Survey of methods for avoiding the problem (ways to preclude EINTR,
> > >   possibly ways to infer behavior, etc).
> >=20
> > This outline seems more or less reasonable to me but, if it's me
> > writing the text, I _will_ characterize what POSIX currently says
> > about EINTR returns from close() as a bug in POSIX.  As far as I'm
> > concerned, that is a fact, not polemic.
> >=20
> > I have found that arguing with you in particular, Rich, is generally
> > not worth the effort.  Therefore, unless you reply and _accept_ that
> > the final version of the close manpage will say that POSIX is buggy,
> > I am not going to write another version of this text, nor will I be
> > drawn into further debate.
>=20
> I will not accept that because it's a gross violation of the
> responsibility of document writing.
>=20
> Rich

--=20
<https://www.alejandro-colomar.es>

--d5j2slyj4lseju6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlv5xQACgkQ64mZXMKQ
wqmosRAAm9BnJjte7Ncmgs8Q/oNX4J3EKRsgNQ0QJtKzhAdNwCszm2RpsoMb3yIG
6woslHII5FQ+gi9I0nsIxOatyZsdDQoKMByTLIsIIfmzOV2zb/gsKHVDdacT9s49
X/nNmNH6asBbq9wsK8OqrqlapTI6eKMIyv3EmS9QD0R0cEk7ofgSBKo3H34ZqCDN
AD0J/hhVf25k1jwR5gLytgF5QaEniOUhAFEo09njy+nF1m0Cih1rAwcrsHELC2xv
f0CkKbUoaYbdqqmRpbY791ydqi8Mqhiuy3tJhQFyMy6tZxVKoijWuikQkmo8L9G9
NZvIUn+2+BaCIUimOC54SLrXvDJCzlElHPejkR0Ak3G+OnSAYFMWPKEi+GeZch5O
ci4VrNjtr/7OhhLa41xv3f2IXVv6UQy+UEAvczDZQ6QJBKGI1jIx1TthDu7Oxtcv
7Fm0Xogu/7J+/I6PKHTQjhk1uBEjQdn+usYO/Xt7Sd24h3OtccAsGw1cVb4NWuw4
9smN0p+ztjJVQtfWlkA+8QnjPo0F9yA3MjuQQUxBb8ciJJXjO4QomHiWy77pNo8O
FjRUNt/uYd15t1PMoaGxex57cnT6CIvanZpQIFelZsVumDVnLYBDyG1DwEV+3JzK
wI9Mnroh4Gy/SDgKHQ/MjtB4b/USylwFB6ASo1IDpqrALoqDXrU=
=VK6m
-----END PGP SIGNATURE-----

--d5j2slyj4lseju6b--

