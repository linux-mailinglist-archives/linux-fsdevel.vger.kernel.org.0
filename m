Return-Path: <linux-fsdevel+bounces-57021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D78B1DF11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 23:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A586D562AC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1433230274;
	Thu,  7 Aug 2025 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="1OrH32r8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4F80BEC
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754603508; cv=none; b=e923LYD04MghCtstGH6V7r0qLjmiHuJmIXRaXeIbUfVt5cVKQ8X3+n7cYNU7yQO/y7KFK9ctoQo3G6OA4NvdvEJ3uM2c16q5ACbmYJUdOaA0slHzsr10Ls+upz2ETlK1ec4VFiv1w9sXBHQmYwkN9EfJ5CPyQicS7nrSyDkwbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754603508; c=relaxed/simple;
	bh=8Un6LULDpiwvyOmQu+dqjfK0GTVAWCW/TjmXHC6FVQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNWd3hFbc2UWcpQDgnRaHItRKqktr+uz/kdXkJuDCfRphSG6aY8P0gOLv0xL1F07sN+vYVv2befrLLe/8IJVw80rdGrZ04FW9Fwj1IenYYumVjmyrwn6IZBWixdlHFc8qjOcFifmYFspDWUjmcOzO6/c/NkfR4FQvX8QAMEMY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=1OrH32r8; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bygpw0P02z9t7d;
	Thu,  7 Aug 2025 23:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754603496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggc+jF2HLl/703f3G3twtWJNGcv1Qm8UJrcNbMCm4PM=;
	b=1OrH32r84RAS1LHN0SnTwKHX3mey9XJfyDM0RDv3xpLz71OWaiHonjve+Knu+Q6cbqZ/81
	E6roIYOEOOAaI53ElPOlksKk9HbUdxS44zJ6/7tcF3IBOSXMvH+dMx5Hzjtm/9xxSZ2/Ri
	Q+L18MIEt0YZQTcCuB04IRnQNZSJTlwcUVwjwEsktemOO9v9/V4ii71IQIholUUU+U0op8
	8B22Jc3eGGDuiU3UOns2qpNiOIhaYVq153ZpyD8R2rr5Uvi4HjrEtqYZNQgAGlvmujqirF
	OyWyWjmgN8ALN71PWWQPD75dk5WNiBEcjQVw1xjU64cm9rcTogforStQ+zXMDw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 8 Aug 2025 07:51:26 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: futimens use of utimensat does not support O_PATH fds
Message-ID: <2025-08-07.1754602716-spare-cyan-roughage-volcano-lW6q7A@cyphar.com>
References: <aJUUGyJJrWLgL8xv@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6nxbd3oiyonbovf2"
Content-Disposition: inline
In-Reply-To: <aJUUGyJJrWLgL8xv@localhost>
X-Rspamd-Queue-Id: 4bygpw0P02z9t7d


--6nxbd3oiyonbovf2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: futimens use of utimensat does not support O_PATH fds
MIME-Version: 1.0

On 2025-08-07, Josh Triplett <josh@joshtriplett.org> wrote:
> I just discovered that opening a file with O_PATH gives an fd that works
> with
>=20
> utimensat(fd, "", times, O_EMPTY_PATH)

I guess you mean AT_EMPTY_PATH? We don't have O_EMPTY_PATH on Linux
(yet, at least...).

> but does *not* work with what futimens calls, which is:
>=20
> utimensat(fd, NULL, times, 0)
>=20
> The former will go through do_utimes_fd, while the latter goes through
> do_utimes_path. I would have expected these two cases to end up in the
> same codepath once they'd discovered they were operating on a file
> descriptor, and I would have expected both to support O_PATH file
> descriptors if either does.
>=20
> This is true for both symlinks (with O_NOFOLLOW | O_PATH) and regular
> files (with just O_PATH). This is on 6.12, in case it matters.
>=20
> Quick and dirty test program (in Rust, using rustix to make syscalls):
>=20
> ```
> use rustix::fs::{AtFlags, OFlags, Timespec, Timestamps, UTIME_OMIT};
>=20
> fn main() -> std::io::Result<()> {
>     let f =3D rustix::fs::open("oldfile", OFlags::PATH | OFlags::CLOEXEC,=
 0o666.into())?;
>     let times =3D Timestamps {
>         last_access: Timespec { tv_sec: 0, tv_nsec: UTIME_OMIT },
>         last_modification: Timespec { tv_sec: 0, tv_nsec: 0 },
>     };
>     let ret =3D rustix::fs::utimensat(&f, "", &times, AtFlags::EMPTY_PATH=
);
>     println!("utimensat: {ret:?}");
>     let ret =3D rustix::fs::futimens(&f, &times);
>     println!("futimens: {ret:?}");
>     Ok(())
> }
> ```
>=20
> Is this something that would be reasonable to fix? Would a patch be
> welcome that makes both cases work identically and support O_PATH file
> descriptors?

The set of things that are and are not allowed on O_PATH file
descriptors is a bit of a hodge-podge these days. Originally the
intention was for all of these things to be blocked by O_PATH (kind of
like O_SEARCH on other *nix systems) but the existence of AT_EMPTY_PATH
(and /proc/self/fd/... hackery) slowly led more and more things to be
allowed.

The current stalemate is that stuff which operates on the fd directly
(fchmod/fchown) tends to not allow operations on O_PATH file
descriptors, while stuff that operates on paths with AT_EMPTY_PATH
(fchmodat/fchownat) does. Why? My impression is that this is mainly
because the man-page (and the original descriptions by Al) says that the
former set of functions don't work on O_PATH. (Though Al probably has a
different viewpoint.)

I was working on an attempted solution for this mess (as part of work to
add O_EMPTY_PATH support while also plugging some holes in the
re-opening semantics on Linux), but it's on the backburner for now.
The core issue is that O_PATH is a very minimalistic capability system,
and different users expect different things from O_PATH, and there isn't
a nice way to make everyone happy with just one bit.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--6nxbd3oiyonbovf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJUf3gAKCRAol/rSt+lE
b7LOAQDot3ThUgSxK31vwY1G231gylr9p0cIiKhqOHK3XLoBrwEAmDEP3tUwpPTY
XDIGobJu6bsZE/3ChZXGoPrZyop8gAg=
=jXs3
-----END PGP SIGNATURE-----

--6nxbd3oiyonbovf2--

