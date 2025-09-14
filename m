Return-Path: <linux-fsdevel+bounces-61264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F7B56CE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 01:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F97D189A4A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 23:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E623D7E6;
	Sun, 14 Sep 2025 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VH2NAcoq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FY4vMGu7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CE7A13A
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757891231; cv=none; b=J8O4/NT/oWrks/hApBV5cFaWN1+A1w3s8YCgdLLTVN/724KUfHEzeozxKjESd4j4qIpaY0DX2Jq3pMuDg4iGElZ7I8I2CqVqF6YI98l/jJc6Hab94T7UombhqIYqJNazaUuIiQ5CuvWhc47qkubKGvomeWLDO8RW6m0w09/UWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757891231; c=relaxed/simple;
	bh=qDqiUGGSgsYoG/ndpQvRa5FQSH3Ixa3oY3KqMt6u1tE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KPUrUlXU/oxPIqRNuDdY7h4TmOVuNeyAX3eGotR5ceVW5a+VIlbByWcVMoqJDCoIDa+/XABQdRdFGEGQzOjYrYCZZQeYtWxTnKoi/HcdjmwutjBBwJ/y21PV/AQfHfsnoaL49S7lb8Za9M8bfvmOWm0ZCcdbyGBilLzUjpe3QuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VH2NAcoq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FY4vMGu7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E569140019F;
	Sun, 14 Sep 2025 19:07:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 14 Sep 2025 19:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757891229; x=1757977629; bh=KP20626VEmIb4eum88VEc96VVLx4tyFoz6D
	G5wF8wHI=; b=VH2NAcoqXM5iOfjdnqsadDPNKb9Xbf/BmOjn38nh3aPqwHkrCfh
	H0xCp76yobUb2Fw/Uzp6ZNO/zeZW1e4FIofS86eGClwzUbB66W0jRCoK5QG8KxDk
	jxId8LOygbVrKLdhdbil7wxGb3GE/gN46MhpRT3MRCE5cvZcwQ1TRVi/zDALiw38
	aBNapNhjX7W8r+JlQ6QlB9Mrtlgw5pUMxMXTmDgkiPIo8yQn9Ba+J0NXXRBx3qDf
	V/v9iOPOof5US+03NPlpmZd33vAiJQUvCSUyE58Y5fXH4Hg961thj7PNtqW5wpYM
	lSHOKSneuf7MU/rvj8RK6jmVlCdCl/Pcavw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757891229; x=
	1757977629; bh=KP20626VEmIb4eum88VEc96VVLx4tyFoz6DG5wF8wHI=; b=F
	Y4vMGu7o7jYyPAekNFQRRYxh3aGfREOZh4i79EmlUE57T4WZ6mt4Lr6BFT0o0uox
	asjGxp0JeDoGerwGlJGor1QvNEy1bk1Q8dHW/UrS6D5+J7fCi1mfYJIGMxEg9Sjq
	b/DCOYKJ37ExDFmjt8ObCRmDiL8vowfHCyq+crW5tbywzSId4+twFaSVAerRi1LF
	d3uGFlZTh5ydUoGEQSBq2QjFzs3Iz8Es4J/HStirV/9JY4fOAGiCw5M1U4QhbLhk
	O4GIr1RXq5mjof8ZOUz0Gs6lKIgdpy1c7VoiM8MvwMKXY/TUFaZIdZBWwLdLA0/S
	umI1r7lRmrpHx4bHZxsYg==
X-ME-Sender: <xms:nErHaFABB1OH-G9hyv70f2KledFbitnFpXmqeaUJeABFUvHFg5eTMg>
    <xme:nErHaK7l8UgAkZz5uH_LQaLuns4nTUWdF1tfZhhpHRfkBSPjE1m39ez11p0LWbAa8
    LaxpC-6tuKpew>
X-ME-Received: <xmr:nErHaGIjjwJG0utYgRbTHfrur4xDhvqAs_4EEYpiRZPWATQtC8UknmubYf7XzrwgnldAFewQRODyXHcHMfSBHAMJN8OD7VgaGUC4oO6ZxDbl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefiedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepthhrohhnughm
    hieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:nErHaLv4VzaEG8s_A2PE0DtvqedxrzWHsgwQNVdeBpwYNueVV_9wQg>
    <xmx:nErHaNJXADLoh_zU8cK4JeAvQmU3wemhS0z9vSYw7MstbMteqSbPOQ>
    <xmx:nErHaM_kWPJCprjI6N17m4iFWciUY7VdrFhksxTPoA33cK022tLBqw>
    <xmx:nErHaOzFjNAUYzRAx1Z-lXKE_dwzohLyI1r_zpy_F-sOfI5l_YYyCQ>
    <xmx:nUrHaAas_U0xPXbbVuQ71Z7RFSvKKFg2vSRKQb1LJ2a37JAGoMZ1w3nX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 19:07:06 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
In-reply-to: <20250914055626.GG39973@ZenIV>
References: <>, <20250908051951.GI31600@ZenIV>,
 <175731272688.2850467.5386978241813293277@noble.neil.brown.name>,
 <20250908090557.GJ31600@ZenIV>, <20250913212815.GE39973@ZenIV>,
 <175781190836.1696783.10753790171717564249@noble.neil.brown.name>,
 <20250914013730.GF39973@ZenIV>, <20250914055626.GG39973@ZenIV>
Date: Mon, 15 Sep 2025 09:07:00 +1000
Message-id: <175789122000.1696783.12073600603531640624@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 14 Sep 2025, Al Viro wrote:
> On Sun, Sep 14, 2025 at 02:37:30AM +0100, Al Viro wrote:
>=20
> > AFAICS, it can happen if you are there from nfs4_file_open(), hit
> > _nfs4_opendata_to_nfs4_state(opendata), find ->rpc_done to be true
> > in there, hit nfs4_opendata_find_nfs4_state(), have it call
> > nfs4_opendata_get_inode() and run into a server without
> > NFS_CAP_ATOMIC_OPEN_V1.  Then you get ->o_arg.claim set to
> > NFS4_OPEN_CLAIM_NULL and hit this:
> >                 inode =3D nfs_fhget(data->dir->d_sb, &data->o_res.fh,
> >                                 &data->f_attr);
> > finding not the same inode as your dentry has attached to it.
> >=20
> > So the test might end up not being true, at least from my reading of
> > that code.
> >=20
> > What I don't understand is the reasons for not failing immediately
> > with EOPENSTALE in that case.
> >=20
> > TBH, I would be a lot more comfortable if the "attach inode to dentry"
> > logics in there had been taken several levels up the call chains - analys=
is
> > would be much easier that way...
> =20
> BTW, that's one place where your scheme with locking dentry might cause
> latency problems - two opens on the same cached dentry could be sent
> in parallel, but if you hold it against renames, etc., you might end up
> with those two roundtrips serialized against each other...
>=20

That is certainly something we need to explore when the time comes,
though at the moment I'm mostly focuses on trying to land APIs to
centralise the locking so that we can easily see what locking is
actually being done and can change it all in one place.

Currently all calls to ->atomic_open are exclusive on the dentry, either
because O_CREATE means the directory is locked exclusively or because
d_alloc_parallel() locked the dentry with DCACHE_PAR_LOOKUP.  ...except
a cached-negative (which was accepted by d_revalidate) without O_CREATE.
I would rather we didn't call ->atomic_open in that case.  If the
filesystem wants us to (which NFS does) they can fail ->d_revalidate
for LOOKUP_OPEN.  I have a patch to do that for NFS so we can drop the
d_alloc_parallel() from nfs_atomic_open().  I think we need that case to
be exclusive anyway.  You achieved that for NFS by using
d_alloc_parallel().

All other atomic_open functions simply call finish_no_open() or return
-ENOENT when given a non-d_in_lookup() dentry and are not asked to
CREATE.  They could all be simplified if we avoided the atomic_open call
in that case.

The proposal is to add a case when O_CREATE isn't requested and the
dentry is no longer d_in_lookup().  Probably that needs exclusive access
to the dentry anyway?  Either way it wouldn't be a regression.

I wonder if maybe we should transition from offering ->atomic_open() to
offering ->lookup_open() which is called instead of the current
lookup_open() (though with locking moved inside the function).

So for a LAST_NORM open the filesystem can take complete control after
the parent has been found.  The VFS can export a bunch of appropriate
helpers which the filesystem can mix and match.  This seems cleaner than
having a ->lookup() which bypasses LOOKUP_OPEN requests and a
->d_revalidate which does the same.

NeilBrown

