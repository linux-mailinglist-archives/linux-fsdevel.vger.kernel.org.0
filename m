Return-Path: <linux-fsdevel+bounces-57123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF9B1EEC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A35170099
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2385286411;
	Fri,  8 Aug 2025 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="DDNcni97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCB13790B;
	Fri,  8 Aug 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680082; cv=none; b=s8rVMaVslwwMdne1QM0YEiNLJIAS7kuZ2Jj33lUz7Cvw9ej4c4qgQlbn8T8u7rOHg0xpoKfGjwTdXP8IKz6CMnp4QQksXwEIXZ7d3ghCp3UPRgoGTWozETIYXu9jCNxs43F4DLM0MSte4JU94XIl3pbWezhtR0XBD8auCie2Duc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680082; c=relaxed/simple;
	bh=v90Z/z9h4SuuSRtazOa+PB8Cn9ZuFoeC1O34f0jk86s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqwKlWJnrrEMhmp6fH9iZiEv0U6vF38qCeVPjECvh5LaQPOxHveesYWlxdK57zs/PM3rjDeJb9iTSf7/C2O0rAtcsNcfzG7u/15Bpy6pImNcYxsJJe7yi9NsCo2LU6rigLQI3GGlTPRYkzZIMzJZzwEEuhpxFV1xAQoYTg32kC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=DDNcni97; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bzD7b5SQHz9svT;
	Fri,  8 Aug 2025 21:07:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754680075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ2Bfu9wA7mUyzKiz143rWYgufUqFCbjKIcINHsYjf8=;
	b=DDNcni97QGO1rwlh61XyuEouz6fLhIGe8Nbw/FVqPQgBQDOdAG7y5B6cSfVlEbfJLwlsUt
	pelgbA+icyy9+8+smKZB0WduFzmca1ySTvDtCJ/1ppxkeD31X47SEn5CuDAUqdzpqmlcB1
	9ZVlJGlXtCmNHZfen5qLy99IpAv0C2E7iNgHKdCPiHixgfmiL74OcodTbRoVppWZjB0fg/
	42fzmquvAuB5w6JlBkdtczklL8yCsfBiiQOytjXYXk5HVlrjAqJ7dQvF4Nc81dSsIep6xl
	MICfP3pDTAvX/na3Ip2ogMbR3t2QBKROj7aAkcSe1mShvrQ4tqH3kLCHTGVS8w==
Date: Sat, 9 Aug 2025 05:07:41 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 05/11] fsconfig.2: document 'new' mount api
Message-ID: <2025-08-08.1754679911-hidden-varsity-charts-ragweed-wIijBm@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-5-558a27b8068c@cyphar.com>
 <19889fbe690.e80d252e42280.4347614991285137048@zohomail.com>
 <2025-08-08.1754666161-creaky-taboo-miso-cuff-mKwsCC@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jrcgfz2nxvhfj7eo"
Content-Disposition: inline
In-Reply-To: <2025-08-08.1754666161-creaky-taboo-miso-cuff-mKwsCC@cyphar.com>


--jrcgfz2nxvhfj7eo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 05/11] fsconfig.2: document 'new' mount api
MIME-Version: 1.0

On 2025-08-09, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2025-08-08, Askar Safin <safinaskar@zohomail.com> wrote:
> > Let's consider this example:
> >=20
> >            int fsfd, mntfd, nsfd, nsdirfd;
> >=20
> >            nsfd =3D open("/proc/self/ns/pid", O_PATH);
> >            nsdirfd =3D open("/proc/1/ns", O_DIRECTORY);
> >=20
> >            fsfd =3D fsopen("proc", FSOPEN_CLOEXEC);
> >            /* "pidns" changes the value each time. */
> >            fsconfig(fsfd, FSCONFIG_SET_PATH, "pidns", "/proc/self/ns/pi=
d", AT_FDCWD);
> >            fsconfig(fsfd, FSCONFIG_SET_PATH, "pidns", "pid", NULL, nsdi=
rfd);
> >            fsconfig(fsfd, FSCONFIG_SET_PATH_EMPTY, "pidns", "", nsfd);
> >            fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
> >            fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> >            mntfd =3D fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
> >            move_mount(mntfd, "", AT_FDCWD, "/proc", MOVE_MOUNT_F_EMPTY_=
PATH);
> >=20
> > I don't like it. /proc/self/ns/pid is our namespace, which is default a=
nyway.
> > I. e. setting pidns to /proc/self/ns/pid is no-op (assuming that "pidns=
" option is implemented in our kernel, of course).
> > Moreover, if /proc is mounted properly, then /proc/1/ns/pid refers to o=
ur namespace, too!

This slightly depends on what you mean by "properly". If you deal with
namespaces a lot, running into a situation whether the current process's
pidns doesn't match /proc is quite common (we run into it with container
runtimes all the time).

A proper example with provably different pidns values (such as the
selftests for the pidns parameter) would make for a very lengthy example
program with very little use for readers.

I'm tempted to just delete this example.

> > Thus, *all* these fsconfig(FSCONFIG_SET_...) calls are no-op.
> > Thus it is bad example.
> >=20
> > I suggest using, say, /proc/2/ns/pid . It has actual chance to refer to=
 some other namespace.
> >=20
> > Also, sentence '"pidns" changes the value each time' is a lie: as I exp=
lained, all these calls are no-ops,
> > they don't really change anything.
>=20
> Right, I see your point.
>=20
> One other problem with this example is that there is no
> currently-existing parameter which accepts all of FSCONFIG_SET_PATH,
> FSCONFIG_SET_PATH_EMPTY, FSCONFIG_SET_FD, and FSCONFIG_SET_STRING so
> this example is by necessity a little contrived. I suspect that it'd be
> better to remove this and re-add it once we actually something that
> works this way...
>=20
> You've replied to the pidns parameter patchset so I shouldn't repeat
> myself here too much, but supporting this completely is my plan for the
> next version I send. It's just not a thing that exists today (ditto for
> overlayfs).
>=20
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--jrcgfz2nxvhfj7eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJZK/QAKCRAol/rSt+lE
b+/iAQDQhXvntGxO/K+rTCZQBBOfgc9JQ7KeTbPVMY04ldZghQEAgKQDzFjsiFpR
FkCNDr4PJBoMmWGd6LUiPPR0hlXU4ws=
=W/yu
-----END PGP SIGNATURE-----

--jrcgfz2nxvhfj7eo--

