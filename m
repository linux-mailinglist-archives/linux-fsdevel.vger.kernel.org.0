Return-Path: <linux-fsdevel+bounces-63493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEF3BBE335
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 15:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8C6E4EBB7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D335F2D23B8;
	Mon,  6 Oct 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="OPE/0+p+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94342D1F7B;
	Mon,  6 Oct 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758073; cv=none; b=eLQ+IThM821PeNnbvIbfMjLHN2E305Hcz8qCxBEKV4hiU7Z2K+G3atJUcXOd8HWV5irUppdTqsCaljUAF1aYIS8LKyVuu5I9eZch3Zsw4leBsm7Hyu3A9CWfqHIJ4R9lfJAfpXg2syUmpJLoefZdW6f1tSbhl5V4z1lGIi89Tj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758073; c=relaxed/simple;
	bh=L01rCQqy0hf/FkMDMqJNHX5gRfZhoJ6LNF4oevuSnVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0dMTotUM6P5BTEv7FXGM5/wnUpae+uQ4aGxfPjPDre0hHNhjuHnQ/6J7pqAwqcaB3ZrkPD/2JhRUKB0nvqkg9qK6nlTBf78ZTWSueoHlu8vJ5sAkBZq4DTnlyLiYSlcdNMVQlFtNakVkMT+ExIck3n5njbaKUBtehMGCstZSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=OPE/0+p+; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cgL5801fLz9t8p;
	Mon,  6 Oct 2025 15:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1759758060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3KkJ4qDrCjMKH10kwDDGLOQeXCC9orY5Doe49stdl4=;
	b=OPE/0+p+wb8bbPHX4ipA752zLXziOz0t98tMdlyyMU0Z5DfhwYOQktxMtvnG/m8FE5emXt
	HloNGORBDRM8M8Rt5Sy1eIMm0DojQbWE8ICl5TvKnVLnPa86Mu6aefzcOQcnvGDXeoiUaK
	viQKbUMIXV40fH7dglAcNTcl9zlNnuyI8Z7tLe20WFpIkSxAitRwGsZZWt4liTyYz0YA5G
	52qyH8Ii/F5ByzeyzLxORIZV2K7PHC6IbxJOa6AY4FZei13KcesLdVjc+PcbXSG5D1NlkM
	h5DPiue23/LNuN9jbme4C0RnzvjSTZWjFau9ZbFLH52JB2KfkOI2HRGAmdIaqg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Tue, 7 Oct 2025 00:40:47 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
Message-ID: <2025-10-06-brief-vague-spines-berms-pzthvt@cyphar.com>
References: <20251006103852.506614-1-luca.boccassi@gmail.com>
 <2hg43wshc3iklydtwx25ulqadzyuldkyi6wylgztzwendi5zhw@kw223cxay7qn>
 <CAMw=ZnR6QMNevxtxWysqi5UkDmbD68Ge=R5cVAxskqtmhb5m5A@mail.gmail.com>
 <bywtfrezkfevzz7y2ecq4w75nfjhz2qqu2cugwl3ml57jlom5k@b5bebz4f24sd>
 <CAMw=ZnSZmW=BFbLLSKsn7sze-FXZroQw6o4eJU9675VmGjzDRw@mail.gmail.com>
 <rleqiwn4mquteybmica3jwilel3mbmaww5p3wr7ju7tfj2d6wt@g6rliisekp2e>
 <CAMw=ZnTDw59GqW-kQkf1aTEHgmBRzcD0z9Rk+wpE_REEmaEJBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tlamafgjkvrndiis"
Content-Disposition: inline
In-Reply-To: <CAMw=ZnTDw59GqW-kQkf1aTEHgmBRzcD0z9Rk+wpE_REEmaEJBw@mail.gmail.com>
X-Rspamd-Queue-Id: 4cgL5801fLz9t8p


--tlamafgjkvrndiis
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
MIME-Version: 1.0

On 2025-10-06, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> On Mon, 6 Oct 2025 at 12:57, Alejandro Colomar <alx@kernel.org> wrote:
> >
> > Hi Luca,
> >
> > On Mon, Oct 06, 2025 at 12:46:41PM +0100, Luca Boccassi wrote:
> > > > > > >  .TP
> > > > > > > +.B EINVAL
> > > > > > > +The source mount is already mounted somewhere else. Clone it=
 via
> > > > [...]
> > > > > > > +.BR open_tree (2)
> > > > > > > +with
> > > > > > > +.B \%OPEN_TREE_CLONE
> > > > > > > +and use that as the source instead (since Linux 6.15).
> > > > > >
> > > > > > The parenthetical in that position makes it unclear if you're s=
aying
> > > > > > that one should use open_tree(2) with OPEN_TREE_CLONE since Lin=
ux 6.15,
> > > > > > or if you're saying that this error can happen since that versi=
on.
> > > > > > Would you mind clarifying?  I think if you mean that the error =
can
> > > > > > happen since Linux 6.15, we could make it part of the paragraph=
 tag, as
> > > > > > in unshare(2).
> > > > >
> > > > > I meant the former, the error is always there, but OPEN_TREE_CLON=
E can
> > > > > be used since 6.15 to avoid it. Sent v2 with this and the other f=
ix,
> > > > > thanks for the prompt review.
> > > >
> > > > Hmmm, I see.  Why not use open_tree(2) and OPEN_TREE_CLONE before 6=
=2E15?
> > > > The syscall and flag existed, AFAICS.  I think we should clarify --=
at
> > > > least in the commit message--, why that version is important.
> > >
> > > It was just not supported at all, so it would still fail with EINVAL
> > > before 6.15 even with the clone.
> >
> > Thanks!  What's the exact commit (or set of commits) that changed this?
> > That would be useful for the commit message.
> >
> > > Would you like me to send a v3 or would you prefer to amend the commit
> > > message yourself?
> >
> > I can amend myself.
>=20
> Sorry, I am not a kernel dev so I do not know where it was introduced
> exactly, and quickly skimming the commits list doesn't immediately
> reveal anything. I only know that by testing it, it works on 6.15 and
> fails earlier.

If I'm understanding the new error entry correctly, this might be commit
c5c12f871a30 ("fs: create detached mounts from detached mounts"), but
Christian can probably verify that.

Just to double check that I understand this new error explanation -- the
issue is that you had a file descriptor that you thought was a detached
mount object but it was actually attached at some point, and the
suggestion is to create a new detached bind-mount to use with
move_mount(2)? Do you really get EINVAL in that case or does this move
the mount?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--tlamafgjkvrndiis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaOPG3xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9FZgEAoFfG3ZP4lBGgp98Vka9V
e7xGzzt56PT9T3QwjNVvs60A/19Ih7ANi3rAtn4Bsy3gsqVj9YFuLpD7emwKKG0z
FVMJ
=bHP7
-----END PGP SIGNATURE-----

--tlamafgjkvrndiis--

