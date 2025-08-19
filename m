Return-Path: <linux-fsdevel+bounces-58272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F538B2BC36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D041BA419D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49275315761;
	Tue, 19 Aug 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="RicbzZWT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328B1E98EF;
	Tue, 19 Aug 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593458; cv=none; b=X37fqK5kl42I87toVDwE2k4YlQPwYoZNjrWd+s714B0igqtmsdrGa4xntj2J9I2OA4vxOGrWV+iCwzoP/sHCVn1TpCYs4mdKdXpa5va5QCkcanXPmLgwc0mEPP+E2C68ultjwN7okEouvwfGUyHE5qI6PWmdiDmR5Q7Atd+hxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593458; c=relaxed/simple;
	bh=s4tkw0agwNjoZbMEvc5Aube6vc6jbp2vPgiUvx0ojac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+S157NMTxAfsDlCt6jkADlRBWyBjaksGgNGPeIFA32UOEMweL1X/Edh2Ot6TCuBRK8i2wWv/M9lBd2MY2gJS7dxAGKTOdkLXZEo+IHez+CTkuKssFPISNC2eQIhnNmxUkMPJ4QytkIIVqYNL58zSvQ3+rQOmg6+jWilh63LkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=RicbzZWT; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c5jwQ6SDDz9sdD;
	Tue, 19 Aug 2025 10:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755593446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4tkw0agwNjoZbMEvc5Aube6vc6jbp2vPgiUvx0ojac=;
	b=RicbzZWTrhdND/IB6LktMwM2bHb9SNceUOR1HugqfrOVbjaT7EEwoYahgdXjiFv9lnaC9O
	kFFArJKEhM88Q8nO9o9qJvp9hEXzCPvYt7y/EOVzVhPPjUDByRVD7FOqHcrwWiPNY9NEwR
	mGj2xmSVGYV++vmtiHd2s/s0Y/xpuszB/SeivMtGiqLfY0cS5y+MRjEUvpztv/Sctmstk/
	s5GNiM3D5vHEtNjEcL8rI3vXa5ZOtIGEkHT4KW2DuzE287qAqckLZ+IhGEsKmbKE4dDE6K
	DgEW802cfS3NOk9uj4XoILSonoXY5XMm4ANAo3E4gTxBdPdQA83dvJJYZ04MKw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Tue, 19 Aug 2025 18:50:31 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Askar Safin <safinaskar@zohomail.com>, alx@kernel.org, 
	dhowells@redhat.com, g.branden.robinson@gmail.com, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, mtk.manpages@gmail.com, viro@zeniv.linux.org.uk, 
	Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Message-ID: <2025-08-19.1755593370-twitchy-liquid-houses-wink-kqgdBL@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250817075252.4137628-1-safinaskar@zohomail.com>
 <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>
 <20250819-erhitzen-knacken-e4d52248ca3e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mmwkuzmuzol2efok"
Content-Disposition: inline
In-Reply-To: <20250819-erhitzen-knacken-e4d52248ca3e@brauner>
X-Rspamd-Queue-Id: 4c5jwQ6SDDz9sdD


--mmwkuzmuzol2efok
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
MIME-Version: 1.0

On 2025-08-19, Christian Brauner <brauner@kernel.org> wrote:
> On Mon, Aug 18, 2025 at 02:16:04AM +1000, Aleksa Sarai wrote:
> > On 2025-08-17, Askar Safin <safinaskar@zohomail.com> wrote:
> > > I noticed that you changed docs for automounts. So I dig into
> > > automounts implementation. And I found a bug in openat2. If
> > > RESOLVE_NO_XDEV is specified, then name resolution doesn't cross
> > > automount points (i. e. we get EXDEV), but automounts still happen! I
> > > think this is a bug. Bug is reproduced in 6.17-rc1. In the end of this
> > > mail you will find reproducer. And miniconfig.
> >=20
> > Yes, this is a bug -- we check LOOKUP_NO_XDEV after traverse_mounts()
> > because we want to error out if we actually jumped to a different mount.
> > We should probably be erroring out in follow_automount() as well, and I
> > missed this when I wrote openat2().
> >=20
> > openat2() also really needs RESOLVE_NO_AUTOMOUNT (and probably
> > RESOLVE_NO_DOTDOT as well as some other small features). I'll try to
> > send something soon.
> >=20
> > > Are automounts actually used? Is it possible to deprecate or
> > > remove them? It seems for me automounts are rarely tested obscure
> > > feature, which affects core namei code.
> >=20
> > I use them for auto-mounting NFS shares on my laptop, and I'm sure there
> > are plenty of other users. They are little bit funky but I highly doubt
> > they are "unused". Howells probably disagrees in even stronger terms.
> > Most distributions provide autofs as a supported package (I think it
> > even comes pre-installed for some distros).
> >=20
> > They are not tested by fstests AFAICS, but that's more of a flaw in
> > fstests (automount requires you to have a running autofs daemon, which
> > probably makes testing it in fstests or selftests impractical) not the
> > feature itself.
> >=20
> > > This reproducer is based on "tracing" automount, which
> > > actually *IS* already deprecated. But automount mechanism
> > > itself is not deprecated, as well as I know.
> >=20
> > The automount behaviour of tracefs is different to the general automount
> > mechanism which is managed by userspace with the autofs daemon. I don't
> > know the history behind the deprecation, but I expect that it was
> > deprecated in favour of configuring it with autofs (or just enabling it
> > by default).
> >=20
> > > Also, I did read namei code, and I think that
> > > options AT_NO_AUTOMOUNT, FSPICK_NO_AUTOMOUNT, etc affect
> > > last component only, not all of them. I didn't test this yet.
> > > I plan to test this within next days.
> >=20
> > No, LOOKUP_AUTOMOUNT affects all components. I double-checked this with
> > Christian.
>=20
> Hm? I was asking the question in the chat because I was unsure and not
> in front of a computer you then said that it does affect all components. =
:)

Yeah I misunderstood what you said -- didn't mean to throw you under the
bus, sorry about that!

> > You would think that it's only the last component (like O_DIRECTORY,
> > O_NOFOLLOW, AT_SYMLINK_{,NO}FOLLOW) but follow_automount() is called for
> > all components (i.e., as part of step_into()). It hooks into the regular
> > lookup flow for mountpoints.
> >=20
> > Yes, it is quite funky that AT_NO_AUTOMOUNT is the only AT_* flag that
> > works this way -- hence why I went with a different RESOLVE_* namespace
> > for openat2() (which _always_ act on _all_ components).
> >=20
> > --=20
> > Aleksa Sarai
> > Senior Software Engineer (Containers)
> > SUSE Linux GmbH
> > https://www.cyphar.com/
>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--mmwkuzmuzol2efok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKQ61xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+T+wEAlSeMmOrEV2wl+utJcEEb
qpQ16Td0Br0wrJGYcTw/IfgA/2UtFxJ9pT6LUkwX14HPqUCCpRZipLkUkxiN3Nda
9XsP
=88Ba
-----END PGP SIGNATURE-----

--mmwkuzmuzol2efok--

