Return-Path: <linux-fsdevel+bounces-63562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A9BC267D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 20:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723934F80F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B00C2E9EBC;
	Tue,  7 Oct 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="GEHtrzcC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6102E975F;
	Tue,  7 Oct 2025 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862275; cv=none; b=RnxqcJ3sZpgT1eBul3Yusqeb8QknG8GxOk8PCr5SCVkLHds4no+woiZQPFw5NT4zsOfO2AeQmxxQ0OnHai7UaZzalO2Ni7ZSrpzIngvPA94Jx54K2nhCWq+i5BbLXCJXrXIAUr5BuLuO9gKxgruAY/Uni/5b81WAWaaRk5EoWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862275; c=relaxed/simple;
	bh=OW97Tb/THZ//CY1tv07c5DTEH+1HJto0+UtSzWYSdRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9IeAI7OSyz4tquZCkwFesVQ+Mgmv9g1952muc6x0JkNwK0J+spQaL9nWGe5qiJWLLDULZamJTRFgkwwuJHN3cjaVzk9p/9GPv8OxiY2LQoHkrSr9CxFyjxiFY6gCWjD7lXcwC2fJNML5UC1UtIpT9UV4xdyG+NFw4BWcG1wUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=GEHtrzcC; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ch4d41s12z9tFt;
	Tue,  7 Oct 2025 20:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1759862264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/07ehBETijAhx+ijXLpSPvP1UzaAqp1PKP1KPLWU09I=;
	b=GEHtrzcCJ4khorGr18uT9OAuYNsm0qpjFg5HifTbvgPyJ3vW89aYKjCE7ULyRpoNcpfQ7F
	RiBeSsLTEbU+hDkq/5WCrzHq7D0YDZYV1OOfset9Da/KsXsRrGAMY5Sh6amo6LYS8ffBWh
	Dh7eGDxnew3fw45z4z2DnyjVelAYXOBhI99vex5XJn5dmMc6c1rMnirkBdPR20bH3a7WlD
	LNIudR/RYnd3EgpYXFPmCR18KAnEZJ0nt+bjCdvHOmW6okgZ8eXKck/ecgPAxjCFYp9TR3
	jRn/cenUapunHLLdI6WyY4fpXoJR6uJkHma1NcFCIcgUKsXuvH8NCZSNEOxVrQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 8 Oct 2025 05:37:32 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
Message-ID: <2025-10-07-greater-dingy-vendetta-kennel-JrnGHl@cyphar.com>
References: <20251006103852.506614-1-luca.boccassi@gmail.com>
 <2hg43wshc3iklydtwx25ulqadzyuldkyi6wylgztzwendi5zhw@kw223cxay7qn>
 <CAMw=ZnR6QMNevxtxWysqi5UkDmbD68Ge=R5cVAxskqtmhb5m5A@mail.gmail.com>
 <bywtfrezkfevzz7y2ecq4w75nfjhz2qqu2cugwl3ml57jlom5k@b5bebz4f24sd>
 <CAMw=ZnSZmW=BFbLLSKsn7sze-FXZroQw6o4eJU9675VmGjzDRw@mail.gmail.com>
 <rleqiwn4mquteybmica3jwilel3mbmaww5p3wr7ju7tfj2d6wt@g6rliisekp2e>
 <CAMw=ZnTDw59GqW-kQkf1aTEHgmBRzcD0z9Rk+wpE_REEmaEJBw@mail.gmail.com>
 <2025-10-06-brief-vague-spines-berms-pzthvt@cyphar.com>
 <CAMw=ZnQki4YR24CfYJMAEWEAQ63yYer-YzSAeH+xFA-fNth-XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h7uukc27yu7yslll"
Content-Disposition: inline
In-Reply-To: <CAMw=ZnQki4YR24CfYJMAEWEAQ63yYer-YzSAeH+xFA-fNth-XQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4ch4d41s12z9tFt


--h7uukc27yu7yslll
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
MIME-Version: 1.0

On 2025-10-06, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> On Mon, 6 Oct 2025 at 14:41, Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2025-10-06, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> > > On Mon, 6 Oct 2025 at 12:57, Alejandro Colomar <alx@kernel.org> wrote:
> > > >
> > > > Hi Luca,
> > > >
> > > > On Mon, Oct 06, 2025 at 12:46:41PM +0100, Luca Boccassi wrote:
> > > > > > > > >  .TP
> > > > > > > > > +.B EINVAL
> > > > > > > > > +The source mount is already mounted somewhere else. Clon=
e it via
> > > > > > [...]
> > > > > > > > > +.BR open_tree (2)
> > > > > > > > > +with
> > > > > > > > > +.B \%OPEN_TREE_CLONE
> > > > > > > > > +and use that as the source instead (since Linux 6.15).
> > > > > > > >
> > > > > > > > The parenthetical in that position makes it unclear if you'=
re saying
> > > > > > > > that one should use open_tree(2) with OPEN_TREE_CLONE since=
 Linux 6.15,
> > > > > > > > or if you're saying that this error can happen since that v=
ersion.
> > > > > > > > Would you mind clarifying?  I think if you mean that the er=
ror can
> > > > > > > > happen since Linux 6.15, we could make it part of the parag=
raph tag, as
> > > > > > > > in unshare(2).
> > > > > > >
> > > > > > > I meant the former, the error is always there, but OPEN_TREE_=
CLONE can
> > > > > > > be used since 6.15 to avoid it. Sent v2 with this and the oth=
er fix,
> > > > > > > thanks for the prompt review.
> > > > > >
> > > > > > Hmmm, I see.  Why not use open_tree(2) and OPEN_TREE_CLONE befo=
re 6.15?
> > > > > > The syscall and flag existed, AFAICS.  I think we should clarif=
y --at
> > > > > > least in the commit message--, why that version is important.
> > > > >
> > > > > It was just not supported at all, so it would still fail with EIN=
VAL
> > > > > before 6.15 even with the clone.
> > > >
> > > > Thanks!  What's the exact commit (or set of commits) that changed t=
his?
> > > > That would be useful for the commit message.
> > > >
> > > > > Would you like me to send a v3 or would you prefer to amend the c=
ommit
> > > > > message yourself?
> > > >
> > > > I can amend myself.
> > >
> > > Sorry, I am not a kernel dev so I do not know where it was introduced
> > > exactly, and quickly skimming the commits list doesn't immediately
> > > reveal anything. I only know that by testing it, it works on 6.15 and
> > > fails earlier.
> >
> > If I'm understanding the new error entry correctly, this might be commit
> > c5c12f871a30 ("fs: create detached mounts from detached mounts"), but
> > Christian can probably verify that.
> >
> > Just to double check that I understand this new error explanation -- the
> > issue is that you had a file descriptor that you thought was a detached
> > mount object but it was actually attached at some point, and the
> > suggestion is to create a new detached bind-mount to use with
> > move_mount(2)? Do you really get EINVAL in that case or does this move
> > the mount?
>=20
> Almost - the use case is that I prep an image as a detached mount, and
> then I want to apply it multiple times, without having to reopen it
> again and again. If I just do 'move_mount()' multiple times, the
> second one returns EINVAL. From 6.15, I can do open_tree with
> OPEN_TREE_CLONE before applying with move_mount, and everything works.

Before each move_mount(2) or just doing it once before all of them? My
quick testing seems to indicate that it needs to be before each one.

I just tried the example in move_mount(2) that I copied from David, and
it doesn't actually work for the reason you outlined (it doesn't work at
all without OPEN_TREE_CLONE, with OPEN_TREE_CLONE the first move works
because it's an attachment but the rest fail with -EINVAL).

   move_mount()  can  also be used in conjunction with file descriptors
   returned from open_tree(2) or open(2):

       int fd =3D open_tree(AT_FDCWD, "/mnt", 0); /* open("/mnt", O_PATH); =
*/
       move_mount(fd, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
       move_mount(fd, "", AT_FDCWD, "/mnt3", MOVE_MOUNT_F_EMPTY_PATH);
       move_mount(fd, "", AT_FDCWD, "/mnt4", MOVE_MOUNT_F_EMPTY_PATH);

   This would move the mount object mounted at /mnt to /mnt2, then
   /mnt3, and then /mnt4.

This example needs to be reworked then...

I'm taking a look at where the error is coming from. As far as I can
see, I think it's from the check_mnt() section in do_move_mount().

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--h7uukc27yu7yslll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaOVd7BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9YOwD/Wu/7k1+5vJL7/1N3LiSo
XyuH1MIijMTtvz6+Ts0rmJYBAMnQIzwdCXWkFK6DVGUSdE6TdfOx6qnIvEQf7Hwl
odUB
=/5cZ
-----END PGP SIGNATURE-----

--h7uukc27yu7yslll--

