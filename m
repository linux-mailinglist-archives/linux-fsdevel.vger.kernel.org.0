Return-Path: <linux-fsdevel+bounces-74727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKUIGSwAcGmUUgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:22:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79B4CE69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 826527CE265
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DED34403D;
	Tue, 20 Jan 2026 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+YkifKD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634F3AEF58;
	Tue, 20 Jan 2026 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941757; cv=none; b=Xa/XR0mfZ/b0ZUjuRm8w4R8WepgtejE05qq9dOiLM+v+yRVlYo5gyTbpcoC6SbsvIrex586ouAwTDml4maROk09mmmPtkHwagZTSiZ4563w17YvS3utW6RBuSA+coaze6/GxXCn8PctLURnP+XJiU64f6SgaAjd0uUbN3Dv9Z4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941757; c=relaxed/simple;
	bh=KfD4BZ20gDEi2Hh4xfvlrI5OIeDWbAbFxm6JU3sZDNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIQW8HO+aEuTWF5FXTzUDkF40ax0HSG0Hv0iTXe9X1dX+2DxjvfQXTmRQy08YabdNIT2z/C9FvAQCfFU8iG/iBJt5VoKqaTaafJ87sHaaoqSyb1svoickmgRKk/9lrLMGThqYGIzZFfdmBRQnUdTwHkpdVF6DXgJqJQh801Fah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+YkifKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3654BC19421;
	Tue, 20 Jan 2026 20:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941757;
	bh=KfD4BZ20gDEi2Hh4xfvlrI5OIeDWbAbFxm6JU3sZDNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+YkifKD1pJgLYdCpvIHXQ58Uy1VA3HvMZPvmovPHrbqkwXS9ul+LlWHVZv46BHVb
	 IZAQKRgzWdlEkmH9m3/9KlM9VT/Zo2vA5vCjpq0d9BERjQ44a1koVQnEFGm8JNICG1
	 tZaxIonJesE6As6Gl/rC+71UZ9jnqjF/bNm/Qga5e4qmfCjPi1yWa3/8DJR1fxaEEL
	 bgbKiQL6rsHK9ZuJKC5oqAVMKmt4nZQ4MybcqEtAAk0KdT93DXaXHtbO23mH+a5a53
	 dt/JCkJSE4MOQhJWpWjYhcYRqroQJJ2e0qrmYMpGeieaKQr4tqe+s4NPzMI3SvhcPe
	 hE71JtEoPt4LQ==
Date: Tue, 20 Jan 2026 21:42:33 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: Zack Weinberg <zack@owlfolio.org>, 
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <aW_olRn5s1lbbjdH@devuan>
References: <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mffhxcp5siirgzb4"
Content-Disposition: inline
In-Reply-To: <aW_jz7nucPBjhu0C@devuan>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74727-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alejandro-colomar.es:url]
X-Rspamd-Queue-Id: CC79B4CE69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--mffhxcp5siirgzb4
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
Message-ID: <aW_olRn5s1lbbjdH@devuan>
References: <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
MIME-Version: 1.0
In-Reply-To: <aW_jz7nucPBjhu0C@devuan>

On Tue, Jan 20, 2026 at 09:35:43PM +0100, Alejandro Colomar wrote:
> Hi Rich, Zack,
>=20
> On Tue, Jan 20, 2026 at 12:46:59PM -0500, Rich Felker wrote:
> > On Tue, Jan 20, 2026 at 12:05:52PM -0500, Zack Weinberg wrote:
> > > > On Fri, May 23, 2025 at 02:10:57PM -0400, Zack Weinberg wrote:
>=20
> [...]
>=20
> > > Now, the abstract correct behavior is secondary to the fact that we
> > > know there are both systems where close should not be retried after
> > > EINTR (Linux) and systems where the fd is still open after EINTR
> > > (HP-UX).  But it is my position that *portable code* should assume the
> > > Linux behavior, because that is the safest option.  If you assume the
> > > HP-UX behavior on a machine that implements the Linux behavior, you
> > > might close some unrelated file out from under yourself (probably but
> > > not necessarily a different thread).  If you assume the Linux behavior
> > > on a machine that implements the HP-UX behavior, you have leaked a
> > > file descriptor; the worst things that can do are much less severe.
> >=20
> > Unfortunately, regardless of what happens, code portable to old
> > systems needs to avoid getting in the situation to begin with. By
> > either not installing interrupting signal handlers or blocking EINTR
> > around close.
>=20
> [...]
>=20
> > > > While I agree with all of this, I think the tone is way too
> > > > proscriptive. The man pages are to document the behaviors, not tell
> > > > people how to program.
> > >=20
> > > I could be persuaded to tone it down a little but in this case I think
> > > the man page's job *is* to tell people how to program.  We know lots =
of
> > > existing code has gotten the fine details of close() wrong and we are
> > > trying to document how to do it right.
> >=20
> > No, the job of the man pages absolutely is not "to tell people how to
> > program". It's to document behaviors. They are not a programming
> > tutorial. They are not polemic diatribes. They are unbiased statements
> > of facts. Facts of what the standards say and what implementations do,
> > that equip programmers with the knowledge they need to make their own
> > informed decisions, rather than blindly following what someone who
> > thinks they know better told them to do.
>=20
> This reminds me a little bit of the realloc(p,0) fiasco of C89 and
> glibc.
>=20
> In most cases, I agree with you that manual pages are and should be
> aseptic, there are cases where I think the manual page needs to be
> tutorial.  Especially when there's such a mess, we need to both explain
> all the possible behaviors (or at least mention them to some degree).

=2E.. and guide programmers about how to best use the API.

I forgot to finish the sentence.

>=20
> But for example, there's the case of realloc(p,0), where we have
> a fiasco that was pushed by a compoundment of wrong decisions by the
> C Committee, and prior to that from System V.  We're a bit lucky that
> C17 accidentally broke it so badly that we now have it as UB, and that
> gives us the opportunity to fix it now (which BTW might also be the case
> for close(2)).
>=20
> In the case of realloc(3), I went and documented in the manual page that
> glibc is broken, and that ISO C is also broken.
>=20
> 	STANDARDS
> 	     malloc()
> 	     free()
> 	     calloc()
> 	     realloc()
> 		    C23, POSIX.1=E2=80=902024.
>=20
> 	     reallocarray()
> 		    POSIX.1=E2=80=902024.
>=20
> 	   realloc(p, 0)
> 	     The  behavior of realloc(p, 0) in glibc doesn=E2=80=99t conform to
> 	     any of C99, C11, POSIX.1=E2=80=902001, POSIX.1=E2=80=902004, POSIX.=
1=E2=80=902008,
> 	     POSIX.1=E2=80=902013,  POSIX.1=E2=80=902017,  or  POSIX.1=E2=80=902=
024.   The  C17
> 	     specification  was changed to make it conforming, but that
> 	     specification made it impossible to write code that  reli=E2=80=90
> 	     ably  determines if the input pointer is freed after real=E2=80=90
> 	     loc(p, 0), and C23 changed it again to make this undefined
> 	     behavior, acknowledging that  the  C17  specification  was
> 	     broad enough, so that undefined behavior wasn=E2=80=99t worse than
> 	     that.
>=20
> 	     reallocarray() suffers the same issues in glibc.
>=20
> 	     musl  libc  and  the BSDs conform to all versions of ISO C
> 	     and POSIX.1.
>=20
> 	     gnulib provides the realloc=E2=80=90posix module,  which  provides
> 	     wrappers  realloc() and reallocarray() that conform to all
> 	     versions of ISO C and POSIX.1.
>=20
> 	     There=E2=80=99s a proposal to standardize the BSD behavior: https:
> 	     //www.open-std.org/jtc1/sc22/wg14/www/docs/n3621.txt.
>=20
> 	HISTORY
> 	     malloc()
> 	     free()
> 	     calloc()
> 	     realloc()
> 		    POSIX.1=E2=80=902001, C89.
>=20
> 	     reallocarray()
> 		    glibc 2.26.  OpenBSD 5.6, FreeBSD 11.0.
>=20
> 	     malloc() and related functions rejected sizes greater than
> 	     PTRDIFF_MAX starting in glibc 2.30.
>=20
> 	     free() preserved errno starting in glibc 2.33.
>=20
> 	   realloc(p, 0)
> 	     C89 was ambiguous in its specification of  realloc(p,  0).
> 	     C99 partially fixed this.
>=20
> 	     The  original implementation in glibc would have been con=E2=80=90
> 	     forming to C99.  However, and ironically, trying to comply
> 	     with C99 before the standard was released,  glibc  changed
> 	     its  behavior  in glibc 2.1.1 into something that ended up
> 	     not conforming to the final C99 specification (but this is
> 	     debated, as the wording of the standard seems self=E2=80=90contra=
=E2=80=90
> 	     dicting).
>=20
> 	...
>=20
> 	BUGS
> 	     Programmers  would  naturally  expect  by  induction  that
> 	     realloc(p, size)  is  consistent  with  free(p)  and  mal=E2=80=90
> 	     loc(size),  as  that  is the behavior in the general case.
> 	     This is not explicitly required by  POSIX.1=E2=80=902024  or  C11,
> 	     but  all  conforming  implementations  are consistent with
> 	     that.
>=20
> 	     The glibc implementation of realloc()  is  not  consistent
> 	     with  that,  and as a consequence, it is dangerous to call
> 	     realloc(p, 0) in glibc.
>=20
> 	     A  trivial  workaround  for  glibc  is   calling   it   as
> 	     realloc(p, size?size:1).
>=20
> 	     The  workaround for reallocarray() in glibc =E2=80=94=E2=80=94which=
 shares
> 	     the         same          bug=E2=80=94=E2=80=94          would     =
     be
> 	     reallocarray(p, n?n:1, size?size:1).
>=20
>=20
> Apart from documenting that glibc and ISO C are broken, we document how
> to best deal with it (see the last paragraph in BUGS).  This is
> necessary because I fear that just by documenting the different
> behaviors, programmers would still not know what to do with that.
> Just take into account that even several members of the committee don't
> know how to deal with it.
>=20
> I'd be willing to have something similar for close(2).
>=20
>=20
> Have a lovely night!
> Alex
>=20
> P.S.:  I have great news about realloc(p,0)!  Microsoft is on-board with
> the change.  They told me they like the proposal, and are willing to
> fix their realloc(3) implementation.  They'll now conduct tests to make
> sure it doesn't break anything too badly, and will come back to me with
> any feedback they have from those tests.
>=20
> I'll put the standards proposal for realloc(3) on hold, waiting for
> Microsoft's feedback.
>=20
> > > > Aside: the reason EINTR *has to* be specified this way is that pthr=
ead
> > > > cancellation is aligned with EINTR. If EINTR were defined to have
> > > > closed the fd, then acting on cancellation during close would also
> > > > have closed the fd, but the cancellation handler would have no way =
to
> > > > distinguish this, leading to a situation where you're forced to eit=
her
> > > > leak fds or introduce a double-close vuln.
> > >=20
> > > The correct way to address this would be to make close() not be a
> > > cancellation point.
> >=20
> > This would also be a desirable change, one I would support if other
> > implementors are on-board with pushing for it.
> >=20
> > > > An outline of what I'd like to see instead:
> > > >
> > > > - Clear explanation of why double-close is a serious bug that must
> > > >   always be avoided. (I think we all agree on this.)
> > > >
> > > > - Statement that the historical Linux/glibc behavior and current PO=
SIX
> > > >   requirement differ, without language that tries to paint the POSIX
> > > >   behavior as a HP-UX bug/quirk. Possibly citing real sources/histo=
ry
> > > >   of the issue (Austin Group tracker items 529, 614; maybe others).
> > > >
> > > > - Consequence of just assuming the Linux behavior (fd leaks on
> > > >   conforming systems).
> > > >
> > > > - Consequences of assuming the POSIX behavior (double-close vulns on
> > > >   GNU/Linux, maybe others).
> > > >
> > > > - Survey of methods for avoiding the problem (ways to preclude EINT=
R,
> > > >   possibly ways to infer behavior, etc).
> > >=20
> > > This outline seems more or less reasonable to me but, if it's me
> > > writing the text, I _will_ characterize what POSIX currently says
> > > about EINTR returns from close() as a bug in POSIX.  As far as I'm
> > > concerned, that is a fact, not polemic.
> > >=20
> > > I have found that arguing with you in particular, Rich, is generally
> > > not worth the effort.  Therefore, unless you reply and _accept_ that
> > > the final version of the close manpage will say that POSIX is buggy,
> > > I am not going to write another version of this text, nor will I be
> > > drawn into further debate.
> >=20
> > I will not accept that because it's a gross violation of the
> > responsibility of document writing.
> >=20
> > Rich
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--mffhxcp5siirgzb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlv6LgACgkQ64mZXMKQ
wqnlyRAAug7IO9+2SRsVILBYyM1+wJksj4EJYlUN5SyQUr/hu91rwk60cFFBLGMz
dNjtY7McZp8OA6EV93WmQhGXBDAb7ry7SKvUepKCwgBRdPwuQGixt0N0dEJ200tF
5yN2cwPBgZ2qE2iMUScC44AjHyB+5A5jjIeYu/7T+KI/MavxrTRSH36ka1la1qW5
16t9wumQ7BA9rO+769pcTjXWT/kDSoI3a+ycuzwe3JOHGuq2RhzFsZ849Hwy2RK5
TR4aFm6shnsG3OCWCH8ZPt0KIWzzqUY+KlDFuie0/j8BYmbMi/KyPT/SnhWRjkvj
2X8xzw4LoRk5jv7C7aQ+IlqXVg6sOKtQKNbwBYaTCf6gLh8LhpiNVvVWO647LUtH
YNlSVLo6YiQT8eq/DGnwurO4yQ4uDh7M/HxQIG/6k+v4RzWHTMT2EzaEv2xt3cNO
eEmzZtrOsxah1l5n3KAYtR06NyTijt7ITTvxKKBw3A4Z1fkckC9ZAzd5ztfWuW14
tYiLWZq8Mk+zpIrQ7Bkzcg4gDFn036SDDHoAl8WFZ/jaKYz3yHWCSze2wJcw/k2g
/w3/+1AwtzumHt1FMvgwlX5oQKkGbfYVyrHX+sQeZ805bKfbuVxBdM3sHQvt/46Y
hLv7ubffpIy5cMu/KtRfLYoazu5evk6rgBZyrBt4c3c8epJQ21M=
=lGEF
-----END PGP SIGNATURE-----

--mffhxcp5siirgzb4--

