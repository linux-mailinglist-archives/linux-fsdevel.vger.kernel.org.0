Return-Path: <linux-fsdevel+bounces-56995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335FCB1D9ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD113B41A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58702262FF3;
	Thu,  7 Aug 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="0jqTmjsY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8DC2367BF;
	Thu,  7 Aug 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576833; cv=none; b=KLOaTnN/DTMfhkkV+IUpDNyoJTCgoMJzQdStOQFWU80g/C3+SHCKM+SepFClWWq6QWlc5lMyd7M7qRdNYUY0CANwQ3z8Vo5TtmQMhu4389oaBaygbHO/R6pyC92misk5GpfdBrMXINAM89sFc/xNDIIh8WTtTfrxiRNzMu/97TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576833; c=relaxed/simple;
	bh=BAzRCPvAifHQrpy+vicDSITuY9c+CQYFbk8WwcsWGI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPk1N/0s8vweN3zvzMhjx4FrUIKoPXW8r7czUrhMveGv2bUHpDipx6UGQqEHuqVIlZuspqyiELSdbKsfNpzNIXlsSgxv7umoSXKg/4hisguQoxwMeaZJedneHQDVVT0ShGRHiGM/wCB5oivPlpBbRe/k2rxEH/lot0jfVt/iHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=0jqTmjsY; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4byTxy09m3z9sqy;
	Thu,  7 Aug 2025 16:27:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754576822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xcZ6yXhLsVLY2MzlKiaDn7jaLc0R1iy1Xv8yKli0aCw=;
	b=0jqTmjsY8jdh2LovRi/QjxR/VMq8iJ07S3UhFydATIms4bMefobIpAJKEKE80NXTnC1d5c
	DzFjMHmJK4xGKCj/2038gxWlgncxA5o+wQ9q5qDYScMFCWezYeT2wRgX5w9QmmuvDZ6BdI
	6bWgpsyWyyu5DkRiQfatnBwUEkNNqV6QmO5R4V4tzwQshp70Qmp/X5BMgb7dtYxng1mvdR
	m/BmHBJjlvVUbn4kVdzivez12iLUFGgFW5rKirTJhbdPO6+1wvnWnG8d7kI+fIiHN846TD
	ac+j1Fww8Xtmm+SxwyuJ5ijSlCKxQ+JZjPObrd/ps7NK+GzZ8SqDCKsq4sHXsg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 8 Aug 2025 00:26:48 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
Message-ID: <2025-08-07.1754576582-puny-spade-blotchy-axiom-winking-overtone-AerGh5@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
 <afty6mfpowwj3kzzbn3p7s4j4ovmput34dtqfzzwa57ocaita4@2jj4qandbnw3>
 <2025-08-07.1754572878-gory-flags-frail-rant-breezy-habits-pRuwdA@cyphar.com>
 <zax5dst65kektsdjgvktpfxmwppzczzl7t2etciywpkl2ywmib@u57e6fkrddcw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hokotbh6rvgvmhcp"
Content-Disposition: inline
In-Reply-To: <zax5dst65kektsdjgvktpfxmwppzczzl7t2etciywpkl2ywmib@u57e6fkrddcw>
X-Rspamd-Queue-Id: 4byTxy09m3z9sqy


--hokotbh6rvgvmhcp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
MIME-Version: 1.0

On 2025-08-07, Alejandro Colomar <alx@kernel.org> wrote:
> Hi Aleksa,
>=20
> On Thu, Aug 07, 2025 at 11:27:04PM +1000, Aleksa Sarai wrote:
> > > I think 'author' is more appropriate than 'developer' for documentati=
on.
> > > It is also more consistent with the Copyright notice, which assigns
> > > copyright to the authors (documented in AUTHORS).  And ironically, ev=
en
> > > the kernel documentation about Co-authored-by talks about authorship
>=20
> (Oops, s/Co-authored-by/Co-developed-by/)
>=20
> > > instead of development:
> > >=20
> > > 	Co-developed-by: states that the patch was co-created by
> > > 	multiple developers; it is used to give attribution to
> > > 	co-authors (in addition to the author attributed by the From:
> > > 	tag) when several people work on a single patch.
> >=20
> > Sure, fixed.
> >=20
> > Can you also clarify whether CONTRIBUTING.d/patches/range-diff is
> > required for submissions? I don't think b4 supports including it (and I
> > really would prefer to not have to use raw git-send-email again just for
> > man-pages -- b4 has so many benefits over raw git-send-email). Is the
> > b4-style changelog I include in the cover-letter sufficient?
>=20
> Yes, that's sufficient.  As Captain Barbossa would say, "the code is
> more what you'd call 'guidelines' than actual rules".  ;)
>=20
> > I like to think of myself as a fairly prolific git user, but I don't
> > think I've ever seen --range-diff=3D output in a git-send-email patch
> > before...
>=20
> Yup, I only learnt about a few years ago.  I have to say it's great as
> a reviewer; it changed my efficiency reviewing code when we started
> using it at $dayjob-1.
>=20
> And even as a submitter, it has also saved me a few times, when I
> introduced a regression in some revision of a patch set, and I could
> easily trace back to the revision where I had introduced it by reading
> the range diffs, which are much shorter than the actual code.
>=20
> Maybe we could ping Konstantin to add this to b4?

Konstantin, would you be interested in a patch to add --range-diff to
the trailing bits of cover letters? I would guess that b4 already has
all of the necessary metadata to reference the right commits.

It seems like a fairly neat way of providing some more metadata about
changes between patchsets, for folks that care about that information.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--hokotbh6rvgvmhcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJS3qAAKCRAol/rSt+lE
b5k7AP9iNmGiDK6uNwSOm/p3ZeH4HLVaykZLd8SvFEvTLN3LigD7BCNDmf4/8ur2
frjCoQQ18Crqo4MlFab0SzzDEuzeEwQ=
=y6o9
-----END PGP SIGNATURE-----

--hokotbh6rvgvmhcp--

