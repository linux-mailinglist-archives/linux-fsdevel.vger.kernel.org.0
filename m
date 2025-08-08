Return-Path: <linux-fsdevel+bounces-57103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3EFB1EBCC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6525A3763
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401C2868B2;
	Fri,  8 Aug 2025 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="y3rGnWIT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA04283144;
	Fri,  8 Aug 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666544; cv=none; b=KZffAS0P/ZIhvNco/U3geh1Aqnp8jOPI6Bib596ifQX56Zsz5g8Vrwj6UU0ebczz3pjiGUXaYR0sPJ2SNgxCjyXSXswgkQla39QpVz2EKtcFb3K1TVlXcuJ2Ezp3+cDTuc+RQmBDAX8UmCXJ+GV8yOwzOeXCGrfhBNYo9au5eXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666544; c=relaxed/simple;
	bh=i2kr/HQIK24dxf5O0tMtSXzbpp9Qo6nlSfXJw6XFFZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXYVVzsR8fLh7d9AdTj0Tdzf277n+U9zxlk0i/KLOkEylkr5L9T53w7+qi7V8zdWWUrTx4LAirvKKqa5xf3GLL7tbQhOg/yjMYT1IJOpmoL7Hwy7jzOnbP2zirMvBjGehcd81tH3FsoZnMhpemTap7z68tQwiNOzkQ5G3wxIMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=y3rGnWIT; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bz77F6rS0z9sjF;
	Fri,  8 Aug 2025 17:22:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754666538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q3gRAt9b/NMSEnTJ1vf+GRybO7D4JeKjDRvpJL7hBDY=;
	b=y3rGnWITZpgNlDNf7YB1I96QDjKjY0/T9u/OR6z4NEdX99CRqcrk6GKcHyWOpykvjL+QDJ
	LiGuEQtBB2RC5AYVeCdTjuCV51nX0DCy9xB+Wdwe5hBgTGk1RmnjYsZGH+UyWP3YzwuLZD
	yCzz50L9bz54qnrID5/AXkUcfIFWbqu24k5O2MQTkC2Uu1a6VRQmzhdnTIcTzPDGjct2Mb
	3l1OMvUFuBYfl1jj/Su+5JokcPWD1sIyma82IpuzMJPlr1r4Scs7HW/UTtLQtfthCg+tvb
	WVpmbPwkNDnx9HITr6bHSOZmfPeQGJ/RMbx1/PZd6kpSbHsJcu1GNetYjxk3hw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Sat, 9 Aug 2025 01:22:03 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 05/11] fsconfig.2: document 'new' mount api
Message-ID: <2025-08-08.1754666161-creaky-taboo-miso-cuff-mKwsCC@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-5-558a27b8068c@cyphar.com>
 <19889fbe690.e80d252e42280.4347614991285137048@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6jhfxn4mikc5fhil"
Content-Disposition: inline
In-Reply-To: <19889fbe690.e80d252e42280.4347614991285137048@zohomail.com>
X-Rspamd-Queue-Id: 4bz77F6rS0z9sjF


--6jhfxn4mikc5fhil
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 05/11] fsconfig.2: document 'new' mount api
MIME-Version: 1.0

On 2025-08-08, Askar Safin <safinaskar@zohomail.com> wrote:
> Let's consider this example:
>=20
>            int fsfd, mntfd, nsfd, nsdirfd;
>=20
>            nsfd =3D open("/proc/self/ns/pid", O_PATH);
>            nsdirfd =3D open("/proc/1/ns", O_DIRECTORY);
>=20
>            fsfd =3D fsopen("proc", FSOPEN_CLOEXEC);
>            /* "pidns" changes the value each time. */
>            fsconfig(fsfd, FSCONFIG_SET_PATH, "pidns", "/proc/self/ns/pid"=
, AT_FDCWD);
>            fsconfig(fsfd, FSCONFIG_SET_PATH, "pidns", "pid", NULL, nsdirf=
d);
>            fsconfig(fsfd, FSCONFIG_SET_PATH_EMPTY, "pidns", "", nsfd);
>            fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
>            fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
>            mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
>            move_mount(mntfd, "", AT_FDCWD, "/proc", MOVE_MOUNT_F_EMPTY_PA=
TH);
>=20
> I don't like it. /proc/self/ns/pid is our namespace, which is default any=
way.
> I. e. setting pidns to /proc/self/ns/pid is no-op (assuming that "pidns" =
option is implemented in our kernel, of course).
> Moreover, if /proc is mounted properly, then /proc/1/ns/pid refers to our=
 namespace, too!
> Thus, *all* these fsconfig(FSCONFIG_SET_...) calls are no-op.
> Thus it is bad example.
>=20
> I suggest using, say, /proc/2/ns/pid . It has actual chance to refer to s=
ome other namespace.
>=20
> Also, sentence '"pidns" changes the value each time' is a lie: as I expla=
ined, all these calls are no-ops,
> they don't really change anything.

Right, I see your point.

One other problem with this example is that there is no
currently-existing parameter which accepts all of FSCONFIG_SET_PATH,
FSCONFIG_SET_PATH_EMPTY, FSCONFIG_SET_FD, and FSCONFIG_SET_STRING so
this example is by necessity a little contrived. I suspect that it'd be
better to remove this and re-add it once we actually something that
works this way...

You've replied to the pidns parameter patchset so I shouldn't repeat
myself here too much, but supporting this completely is my plan for the
next version I send. It's just not a thing that exists today (ditto for
overlayfs).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--6jhfxn4mikc5fhil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJYWGwAKCRAol/rSt+lE
b2EsAQD9tz9+Qco8NpwqXkWodBeTDFLFs50YEA3myeSlXFaydAD+Ndr6DDo37Z52
gdgpboeXnabG/WLHmL9hQnr31W/13gI=
=sO7Y
-----END PGP SIGNATURE-----

--6jhfxn4mikc5fhil--

