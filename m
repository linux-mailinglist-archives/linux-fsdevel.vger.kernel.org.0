Return-Path: <linux-fsdevel+bounces-49317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11644ABA867
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 07:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077A01B6182A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 05:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EA919D080;
	Sat, 17 May 2025 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peWKt6lO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8A175D53;
	Sat, 17 May 2025 05:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747460809; cv=none; b=DdHHrP63EsyyIcyids96PJGXv0DZlkhQgaIj6UMix+KmonUlQO7UNKTlJ07T3kEvAlzcX92Oe6q807G5AUiuuDk9Vfi2b1FIXYNqNPhmiQ9tQrgSaVc5qI3b+bZoaiAPpMt91i1r3BJNYO1zeuj6xsctmmmyPtvWbco1vg/hedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747460809; c=relaxed/simple;
	bh=nWLbEPSM1bn6mrBuuKSMWOJymmWzk7vGG78P4i9l2ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeCcyP+NQ1clzZaIHYTQvm63A0pULeZ4ZhWShIWJbX9RYKVIw1KEd7LriEyxHBwLvKS4DyP4hXNLguhMD+osH4eSI+pI4H3+bS5qySjLc6SriXiiK56Y2w9GmdKZo0bG4fQZKt+meBsRHUBW44sMe9q5qKKitXxMUx6x9VoECuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peWKt6lO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDDDC4CEE3;
	Sat, 17 May 2025 05:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747460808;
	bh=nWLbEPSM1bn6mrBuuKSMWOJymmWzk7vGG78P4i9l2ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peWKt6lOThlv7KkNZPbV8SqJMqOjKxxwuAVhMe3vNbqzwczAAZLratDFziOoSau5c
	 ROda77kbX/WhsT0cydP092MxUS+009vXpYgu27xV4Vi2XMeXT2cbfr0vfUURZ7yMd9
	 RSkdkA7yL7atE9gVKlqdfMNnNfWdrJgNOo0q4s8AT1ylbtyB2noFneJKhykT8Sl3Pd
	 s2TQ+YqzHxc5fLDj+JAL9+rgzc7hJvoCr0KreeRipCJA4jAK2nXpwAAFXSA+ut2fuI
	 le+lPEuc1XI96zAABm5ek7Sx6kC4tw881pj8pjGfWSVi1g7eEFoheXHex+X3bCYbl2
	 isRqTbntVo0CQ==
Date: Sat, 17 May 2025 07:46:42 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Rich Felker <dalias@libc.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <bsvslfjgcmzvcanxp3ay6ohitqulwuawwgzy234nfkj6ecdxbq@2uhld4vpitou>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516142024.GA21503@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7tb5obnp6gurt3al"
Content-Disposition: inline
In-Reply-To: <20250516142024.GA21503@mit.edu>


--7tb5obnp6gurt3al
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Rich Felker <dalias@libc.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516142024.GA21503@mit.edu>
MIME-Version: 1.0
In-Reply-To: <20250516142024.GA21503@mit.edu>

Hi Ted, Rich,

On Fri, May 16, 2025 at 09:05:47AM -0400, Rich Felker wrote:
> FWIW musl adopted the EINPROGRESS as soon as we were made aware of the
> issue, and later changed it to returning 0 since applications
> (particularly, any written prior to this interpretation) are prone to
> interpret EINPROGRESS as an error condition rather than success and
> possibly misinterpret it as meaning the fd is still open and valid to
> pass to close again.

Hmmm, this page will need a kernel/libc differences section where I
should explain this.

On Fri, May 16, 2025 at 10:20:24AM -0400, Theodore Ts'o wrote:
> On Fri, May 16, 2025 at 09:05:47AM -0400, Rich Felker wrote:
> =20
> > In general, raw kernel interfaces do not conform to any version of
> > POSIX; they're just a low-impedance-mismatch set of inferfaces that
> > facilitate implementing POSIX at the userspace libc layer. So I don't
> > think this should be documented as "Linux doesn't conform" but
> > (hopefully, once glibc fixes this) "old versions of glibc did not
> > conform".
>=20
> If glibc maintainers want to deal with breaking userspace, then as a
> kernel developer, I'm happy to let them deal with the
> angry/disappointed users and application programmers.  :-)

Which breakage do you expect from the behavior that musl has chosen?

I agree that the POSIX invention of EINPROGRESS is something that would
break users.  However, in removing the error completely and making it a
success, I don't see the same problem.  That is, if a program calls
close(2) and sees a return of 0, or sees a return of -1 with EINTR on
Linux, both mean "the file descriptor has been closed, and the contents
of the file will *eventually* reach the file".

In which cases do you expect any existing Linux program to behave
differently on 0 and on EINTR?


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--7tb5obnp6gurt3al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgoIq8ACgkQ64mZXMKQ
wqlt8Q//S3kkYdJmTyj5F5ttrA5KQsNl4QiC3EgpRj0qifvlBXQEFEvJE6I0m+xp
BSh2NGzvwHhtgZgVTiMgjMtcC7k69aRlT87ezCMkSAQJinYFViJM9WrJqO5jbqlA
nPMdsN/+T4S39RxMoWN6bq8pRaL3EZiQ7kJe0IjdpdDg8qp5WJtkFqfZC694/xQp
PbvwKllUTI469fslqfkOhQWYnuUoQcPZFUskisxhrMYNpmwceSL9G+6XrdovcfEv
w+L+31LURoTTlBiQIIBJM54UyfO3pBIKepP/7TQ03aAvsLsq+u6/tueQh9cFI2VT
ujgUBOqB5K5KcZewEh4GuswyUC67u60+oBOqF/STN9bQR/COEckrkGB4Jy1oF3uf
K06u8JdtkET0aXgX5fzZurB3w8sWJSQe7dsB0DeVzqvZEczKr/c88vRqrQB238Hl
i7G1B4EYcPM5sf/jVDvpqMLUXAbVPsaHxjvS0kQdgU7HqfXmiEZmHkmvWp9v2fpm
40Kqzh7VzPHhSTrzUgbKw6M/8QXQbrUnxGWLif9e31FIQ7b1oLiq04sBcp5PbmwK
L7Am5vhais+Vy0k0bZQNjRPSKoERDlVkKg9eYkatGUGGgLugqJsO+xg33BKOa+Pv
Jzh7EUaCantB9xP7CUOERIz7ZBswuvf4jDl7EmNV3GcuWcUFzFw=
=+qWM
-----END PGP SIGNATURE-----

--7tb5obnp6gurt3al--

