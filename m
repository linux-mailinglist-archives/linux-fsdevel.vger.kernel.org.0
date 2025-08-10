Return-Path: <linux-fsdevel+bounces-57193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C0B1F854
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0986E3BAF6F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF211E1E19;
	Sun, 10 Aug 2025 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="gCjpSsFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99F1DB122
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Aug 2025 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754801104; cv=none; b=sxo81EW4AoF4yu7R7rgbEmeO5Bsi97AEiprkTccpmkcBg0UZCA62VU3bKkBO0n/HJbKIRLYJRuMMPxRnFV8tuNUZNcyjL+MXvtZ/foquY6TzqvQjjezXVLz6SUcsdhiq2HP2tHSpaB2bxXC/bWLBXNGMNks4x8JSEzc5/i+sO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754801104; c=relaxed/simple;
	bh=lA+FGvQLLl2vwVMgBK/VusUOTksog/0l+tfMKgE72ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyUeRI9xJhCCNxX66CcQTDVbakRZmRX2tT8IwqS/jvK6uUDl1ly3KS0xMlyoMNxicVxKxkPHzSkAZzSd9vxXgYWidLkIFtHSY7oGH8ORTUD4fUzNr1Ojtgb+B1XFrq4R52A3gMyasV2sSpN7KxTKngBCjUjCsxMlmM9MIxqagQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=gCjpSsFA; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c04tq5sbbz9srX;
	Sun, 10 Aug 2025 06:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754801091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O5i521x+dJKFucvW1RX/3P7SkHvl0sY6aC2wo6UdY5U=;
	b=gCjpSsFAYbhUVIkWiER9TE17fiEt2lqaMIKP9v3TV32AViaK2W3TVpkuNUI9rL2RexfqA8
	KiRpLd7IWUvxbTRfjQurnLXqh9AMGuUQfQcfryV1BErYj0vNZCBTH3OcJ65UaJOolRJ1He
	OPoaf0ltX0iEgknQrgmMBBMe945iqohh23FnTgrmT2UugUDQKHtcQKwmYvi0Np1runNd1B
	LZyq0OTc5QsZbsev5tfUzYKIPMbgAGONE7K8cFzDZrkDeONO0JQ4atN6SHozBgvIYORkg1
	UWYqf4Np3mlyqNkAW6a+fOapDa1yaJTnLkVMILkT4n9HIEiKmL1H2pyUCrtNng==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Sun, 10 Aug 2025 14:44:40 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: futimens use of utimensat does not support O_PATH fds
Message-ID: <2025-08-09.1754760807-mushy-helpful-shrug-booze-qPqkMg@cyphar.com>
References: <aJUUGyJJrWLgL8xv@localhost>
 <20250808-ziert-erfanden-15e6d972ae43@brauner>
 <aJZJpIEJB2R0x-Hh@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5s6jjxflruahsil"
Content-Disposition: inline
In-Reply-To: <aJZJpIEJB2R0x-Hh@localhost>
X-Rspamd-Queue-Id: 4c04tq5sbbz9srX


--z5s6jjxflruahsil
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: futimens use of utimensat does not support O_PATH fds
MIME-Version: 1.0

On 2025-08-08, Josh Triplett <josh@joshtriplett.org> wrote:
> On Fri, Aug 08, 2025 at 03:22:58PM +0200, Christian Brauner wrote:
> > On Thu, Aug 07, 2025 at 02:01:15PM -0700, Josh Triplett wrote:
> > > I just discovered that opening a file with O_PATH gives an fd that wo=
rks
> > > with
> > >=20
> > > utimensat(fd, "", times, O_EMPTY_PATH)
> > >=20
> > > but does *not* work with what futimens calls, which is:
> > >=20
> > > utimensat(fd, NULL, times, 0)
> >=20
> > It's in line with what we do for fchownat() and fchmodat2() iirc.
> > O_PATH as today is a broken concept imho. O_PATH file descriptors
> > should've never have gained the ability to meaningfully alter state. I
> > think it's broken that they can be used to change ownership or mode and
> > similar.
>=20
> In the absence of having O_PATH file descriptors, what would be the way
> to modify the properties of a symlink using race-free
> file-descriptor-based calls rather than filenames? AFAICT, there's no
> way to get a file descriptor corresponding to a symbolic link without
> using `O_PATH | O_NOFOLLOW`.

Yes, O_PATH|O_NOFOLLOW is the only way to get a file descriptor
referencing a symlink. However, depending on what property you were
talking about, doing

  fooat(parent_dirfd, "terminal-pathname-without-slashes", AT_SYMLINK_NOFOL=
LOW);

is probably sufficient for most programs, and I believe is the pattern
that Solaris was going for when they introduced *at(2) system calls.
Solaris does also have O_SEARCH, but I believe it's more restrictive
than O_PATH.

Yes, if you want to operate on a very specific inode, this approach
doesn't work if an attacker has write access to the parent directory.
But in my experience there are very few cases where you want to operate
on a very specific inode inside an attacker-controlled directory (most
of the time you just want to avoid being tricked to operate on stuff
outside the directory, and any inode inside the directory is fine --
which is what the above gives you).

> It makes sense that a file descriptor for a symbolic link would be able
> to do inode operations but not file operations.

=46rom a kernel developer's perspective, maybe. But what is a file
operation or an inode operation is not immediately obvious to user
space, and the in-kernel distinction really isn't an API that was
intended to be user-visible IMHO.

In general, when it comes to O_PATH some userspace programs would prefer
O_PATH to disallow modifying _any aspect_ of the file descriptor, so
that you can pass them to untrusted programs (like a real
capability-based system). This is no longer achievable on Linux today,
and the fact we keep poking more holes in O_PATH is making the situation
less and less tenable.

I _do_ want a better solution for this, but if we want to keep expanding
O_PATH then we really need to have some way for programs to opt-out of
those expansions. Then we can come up with a default set of allowed
operations on O_PATH that programs can adjust, which will finally break
up the binary nature of O_PATH.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--z5s6jjxflruahsil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJgjuAAKCRAol/rSt+lE
b3ufAQDySGxSDnfG/p/4jwaNLEum5Hxx1A9GoyxC4dvcq90newEAoWhXVRkFL3Xg
1oPPqNKyIAjrp4ycOnYcxJEVKoeDgQE=
=9Q4h
-----END PGP SIGNATURE-----

--z5s6jjxflruahsil--

