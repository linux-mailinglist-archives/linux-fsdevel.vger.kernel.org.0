Return-Path: <linux-fsdevel+bounces-51429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266BAAD6C7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEBA3ADA27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31DE22B5B8;
	Thu, 12 Jun 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKF38VES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0038C1F92E;
	Thu, 12 Jun 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721543; cv=none; b=HiCvbMIcakXnwjxgRLOOjfJTCuPMcGERw97QI/1Kgul2H+G7lTNejjw1/smkPDSMYT6RYPUagl3qBTCBzfAB5OMc+IeqCNoez5tVAsiYoSl2BkspEG8CxFgGTsbevCzUtmOJPnD3y7lK6A2nf32SDjaU8eldn/zFIYzHSykMFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721543; c=relaxed/simple;
	bh=ISSwJzQtcPMgDfooxcBBf4ZtPTrjUOw20WkC/jwELYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJfWKUi5qTbba3yd40rUzDHBqkPBNfHcgD1bYalCvm/RYsRA7JtgDkb8MDetBi01LNYLBETNvZGXhlrfl0QCXnJrgp2J/8E0xANR3o++HZqSNuhSSWqj4Tt2H6rtuSEtpUu87Gj6x5pLSczxuHjS9POH1YgsB8CVJoJfReNGVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKF38VES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BA1C4CEEA;
	Thu, 12 Jun 2025 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749721542;
	bh=ISSwJzQtcPMgDfooxcBBf4ZtPTrjUOw20WkC/jwELYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKF38VESGU0+8srBj0ZYtbybtVz02QgkU6rGWBDVTttfuUomHrfnmOnKaTPAgzNYR
	 F4NDpGJbh/3Eb/WAcglsv8Djp6SsxK6KsZOQwcU3NRNgHLCzBC8UITwlDv7DuG2hcS
	 F6aAbN67DuvdaZvcJNXc4kxeLDCg/AHp0F+QSvln0BYS8rNlwFVvBe66a5jFUdhVME
	 4DqKwlU2gVoaqH3ZNbkqfyrNdvMMQlAQllO0K4ecW2WJEx9UBnDfysifySWavQbCg2
	 6td9aQcZyyZeqv8Bv89ErSbUccAf/ogOZlDl+gZqggQ9vdO5cmS+i26nprxdNyR43M
	 acYHWxinUo7og==
Date: Thu, 12 Jun 2025 11:45:36 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Zhengyi Fu <i@fuzy.me>
Cc: linux-man@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, 
	Mike Rapoport <rppt@linux.ibm.com>, David Rheinsberg <david@readahead.eu>, 
	Hugh Dickins <hughd@google.com>, Hagen Paul Pfeifer <hagen@jauu.net>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] man/man2/memfd_secret.2: Correct the flags
Message-ID: <7umhm4evxdbhvoezkcnpnt4vpaqoylwia25pzusby6evmvkoib@nfanksvdoq3c>
References: <20250612061705.1177931-1-i@fuzy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y4mw2jlmwswrkrl3"
Content-Disposition: inline
In-Reply-To: <20250612061705.1177931-1-i@fuzy.me>


--y4mw2jlmwswrkrl3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Zhengyi Fu <i@fuzy.me>
Cc: linux-man@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, 
	Mike Rapoport <rppt@linux.ibm.com>, David Rheinsberg <david@readahead.eu>, 
	Hugh Dickins <hughd@google.com>, Hagen Paul Pfeifer <hagen@jauu.net>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] man/man2/memfd_secret.2: Correct the flags
References: <20250612061705.1177931-1-i@fuzy.me>
MIME-Version: 1.0
In-Reply-To: <20250612061705.1177931-1-i@fuzy.me>

[CC +=3D people related to memfd_{create,secret}(2) in the kernel]

Hi Zhengyi,

On Thu, Jun 12, 2025 at 02:17:05PM +0800, Zhengyi Fu wrote:
> memfd_secret returns EINVAL when called with FD_CLOEXEC.  The
> correct flag should be O_CLOEXEC.

Thanks for the report!  It seems like a bug in the kernel.  The
documentation was written (relatively) consistent with memfd_create(2),
but the implementation was made different.  I say the documentation was
relatively consistent, because memfd_create(2) uses MFD_CLOEXEC, and
memfd_secret(2) documents FD_CLOEXEC, which could be confused, and since
they have the same value, it could be considered just a typo.  However,
O_CLOEXEC is an entirely different flag, which doesn't seem to make
sense here.

	$ grepc -tfld memfd_create . | grep -A4 -e '^[{}.]' -e CLOEXEC;
	./mm/memfd.c:SYSCALL_DEFINE2(memfd_create,
			const char __user *, uname,
			unsigned int, flags)
	{
		struct file *file;
		int fd, error;
		char *name;

	--
		fd =3D get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
		if (fd < 0) {
			error =3D fd;
			goto err_name;
		}
	--
	}

	$ grepc -tfld memfd_secret . | grep -A3 -e '^[{}.]' -e CLOEXEC;
	./mm/secretmem.c:SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
	{
		struct file *file;
		int fd, err;

	--
		BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);

		if (!secretmem_enable || !can_set_direct_map())
			return -ENOSYS;
	--
		if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
			return -EINVAL;
		if (atomic_read(&secretmem_users) < 0)
			return -ENFILE;
	--
		fd =3D get_unused_fd_flags(flags & O_CLOEXEC);
		if (fd < 0)
			return fd;

	--
	}

Let's see who added memfd_create(2):

	alx@devuan:~/src/linux/linux/master$ git blame -- ./mm/memfd.c | grep _CLO=
EXEC
	105ff5339f498 (Jeff Xu                 2022-12-15 00:12:03 +0000 306) #def=
ine MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEX=
EC_SEAL | MFD_EXEC)
	f5dbcd90dacd3 (Isaac J. Manjarres      2025-01-10 08:58:59 -0800 475) 	fd =
=3D get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
	alx@devuan:~/src/linux/linux/master$ git show f5dbcd90dacd3 | grep -e _CLO=
EXEC -e ^diff | grep -B1 -v ^d
	diff --git a/mm/memfd.c b/mm/memfd.c
	-	fd =3D get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
	+	fd =3D get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
	alx@devuan:~/src/linux/linux/master$ git blame f5dbcd90dacd3^ -- mm/memfd.=
c | grep _CLOEXEC
	105ff5339f498 (Jeff Xu                 2022-12-15 00:12:03 +0000 305) #def=
ine MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEX=
EC_SEAL | MFD_EXEC)
	5d752600a8c37 (Mike Kravetz            2018-06-07 17:06:01 -0700 423) 	fd =
=3D get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
	alx@devuan:~/src/linux/linux/master$ git show 5d752600a8c37 | grep -e _CLO=
EXEC -e ^diff | grep -B1 -v ^d
	diff --git a/mm/memfd.c b/mm/memfd.c
	+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
	+	fd =3D get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
	diff --git a/mm/shmem.c b/mm/shmem.c
	-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
	-	fd =3D get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
	alx@devuan:~/src/linux/linux/master$ git blame 5d752600a8c37^ -- mm/shmem.=
c | grep _CLOEXEC
	749df87bd7bee (Mike Kravetz            2017-09-06 16:24:16 -0700 3684) #de=
fine MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
	9183df25fe7b1 (David Rheinsberg        2014-08-08 14:25:29 -0700 3729) 	fd=
 =3D get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
	alx@devuan:~/src/linux/linux/master$ git show 9183df25fe7b1 | grep -e _CLO=
EXEC -e ^diff | grep -B1 -v ^d
	diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
	+#define MFD_CLOEXEC		0x0001U
	--
	diff --git a/mm/shmem.c b/mm/shmem.c
	+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING)
	+	fd =3D get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);

	alx@devuan:~/src/linux/linux/master$ git show 9183df25fe7b1 | head -n5
	commit 9183df25fe7b194563db3fec6dc3202a5855839c
	Author: David Rheinsberg <david@readahead.eu>
	Date:   Fri Aug 8 14:25:29 2014 -0700

	    shm: add memfd_create() syscall

	alx@devuan:~/src/linux/linux/master$ git log -1 9183df25fe7b1 | grep @
	Author: David Rheinsberg <david@readahead.eu>
	    Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
	    Acked-by: Hugh Dickins <hughd@google.com>
	    Cc: Michael Kerrisk <mtk.manpages@gmail.com>
	    Cc: Ryan Lortie <desrt@desrt.ca>
	    Cc: Lennart Poettering <lennart@poettering.net>
	    Cc: Daniel Mack <zonque@gmail.com>
	    Cc: Andy Lutomirski <luto@amacapital.net>
	    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
	    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

And memfd_secret(2):

	alx@devuan:~/src/linux/linux/master$ git blame -- ./mm/secretmem.c | grep =
_CLOEXEC
	1507f51255c9f (Mike Rapoport           2021-07-07 18:08:03 -0700 238) 	BUI=
LD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
	1507f51255c9f (Mike Rapoport           2021-07-07 18:08:03 -0700 243) 	if =
(flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
	1507f51255c9f (Mike Rapoport           2021-07-07 18:08:03 -0700 248) 	fd =
=3D get_unused_fd_flags(flags & O_CLOEXEC);
	alx@devuan:~/src/linux/linux/master$ git show 1507f51255c9f | grep -e _CLO=
EXEC -e ^diff | grep -B1 -v ^d
	diff --git a/mm/secretmem.c b/mm/secretmem.c
	+	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
	+	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
	+	fd =3D get_unused_fd_flags(flags & O_CLOEXEC);
	alx@devuan:~/src/linux/linux/master$ git show 1507f51255c9f | head -n5
	commit 1507f51255c9ff07d75909a84e7c0d7f3c4b2f49
	Author: Mike Rapoport <rppt@kernel.org>
	Date:   Wed Jul 7 18:08:03 2021 -0700

	    mm: introduce memfd_secret system call to create "secret" memory areas
	alx@devuan:~/src/linux/linux/master$ git log -1 1507f51255c9f | grep @
	Author: Mike Rapoport <rppt@kernel.org>
	    [1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884e=
b3c@linux.intel.com/
	    [akpm@linux-foundation.org: suppress Kconfig whine]
	    Link: https://lkml.kernel.org/r/20210518072034.31572-5-rppt@kernel.org
	    Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
	    Acked-by: Hagen Paul Pfeifer <hagen@jauu.net>
	    Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
	    Cc: Alexander Viro <viro@zeniv.linux.org.uk>
	    Cc: Andy Lutomirski <luto@kernel.org>
	    Cc: Arnd Bergmann <arnd@arndb.de>
	    Cc: Borislav Petkov <bp@alien8.de>
	    Cc: Catalin Marinas <catalin.marinas@arm.com>
	    Cc: Christopher Lameter <cl@linux.com>
	    Cc: Dan Williams <dan.j.williams@intel.com>
	    Cc: Dave Hansen <dave.hansen@linux.intel.com>
	    Cc: Elena Reshetova <elena.reshetova@intel.com>
	    Cc: "H. Peter Anvin" <hpa@zytor.com>
	    Cc: Ingo Molnar <mingo@redhat.com>
	    Cc: James Bottomley <jejb@linux.ibm.com>
	    Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
	    Cc: Matthew Wilcox <willy@infradead.org>
	    Cc: Mark Rutland <mark.rutland@arm.com>
	    Cc: Michael Kerrisk <mtk.manpages@gmail.com>
	    Cc: Palmer Dabbelt <palmer@dabbelt.com>
	    Cc: Palmer Dabbelt <palmerdabbelt@google.com>
	    Cc: Paul Walmsley <paul.walmsley@sifive.com>
	    Cc: Peter Zijlstra <peterz@infradead.org>
	    Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
	    Cc: Roman Gushchin <guro@fb.com>
	    Cc: Shakeel Butt <shakeelb@google.com>
	    Cc: Shuah Khan <shuah@kernel.org>
	    Cc: Thomas Gleixner <tglx@linutronix.de>
	    Cc: Tycho Andersen <tycho@tycho.ws>
	    Cc: Will Deacon <will@kernel.org>
	    Cc: David Hildenbrand <david@redhat.com>
	    Cc: kernel test robot <lkp@intel.com>
	    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
	    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

I've added to CC everyone who had something different than Cc, and
everyone who had Cc in both.

Now about the situation: it seems there is only one user of CLOEXEC
with memfd_secret(2) in Debian: systemtap.
<https://codesearch.debian.net/search?q=3Dmemfd_secret.*CLOEXEC&literal=3D0>

Do we want to fix the bug, or do we want to document it?  This is for
kernel people to respond.

Also, was O_CLOEXEC used on purpose, or was it by accident?  I expect
that either MFD_CLOEXEC should have been used, by imitating
memfd_create(2), or a new MFDS_CLOEXEC could have been invented, but
O_CLOEXEC doesn't make much sense, IMO.


Have a lovely day!
Alex

>=20
> Signed-off-by: Zhengyi Fu <i@fuzy.me>
> ---
>  man/man2/memfd_secret.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/man/man2/memfd_secret.2 b/man/man2/memfd_secret.2
> index 5ba7813c1..c6abd2f5f 100644
> --- a/man/man2/memfd_secret.2
> +++ b/man/man2/memfd_secret.2
> @@ -51,7 +51,7 @@ The following values may be bitwise ORed in
>  to control the behavior of
>  .BR memfd_secret ():
>  .TP
> -.B FD_CLOEXEC
> +.B O_CLOEXEC
>  Set the close-on-exec flag on the new file descriptor,
>  which causes the region to be removed from the process on
>  .BR execve (2).
>=20

--=20
<https://www.alejandro-colomar.es/>

--y4mw2jlmwswrkrl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhKoboACgkQ64mZXMKQ
wqlzeQ/+K5xch9iM3q4DGbnPGkxzDEmxrRjZdLkg8gQ8eEK95ENojQie/eSI2F/Z
PbEaGb2rQz3re4H0jLAKTo9Yyu40JmFuFLQxYmOaouZE+74zQ/hV/67axyic7Kf6
pV5SUq1s57WZEq0vqCbRBWURNup5bJD7Ijtv/7XPMI77hJDIEBNwceh6+kQ0OxMb
Tm9dnuuaaT6Yk2rjko3SkCy8DA/RCii76suUmRdT0qL57XAW3PA0w27bJg/pBKNh
eaZLynwd2QhxGdVJf0fYBH04bpdz8PySd5tBKdxXCIP5N78GqIl3HrpKSjYY44Uc
bmUWTVf+BvU2wclKC+h5jDU5S9ZgSQH4s6gKstGUPeSDtICn1dA2AB0pb9NTIgsu
mGNfsbSyKIGPsQNV68AOrRd0BTSx1lBxfXrimO8fE+HCA9+FoGIGgcOeT+sjcddl
1Zs0FC8XetFUDvnojUKVKLrPvsa0+fuElX9hcwtaVO4s2mbyGx9EugQiof8f4MUr
zHxpJF8TPJhOQSGHS/mS4QtQjg8o5HxcMWJU5MjANDGea+auAYQ0u4RK7ZpAXiVX
4priCtY1yJYkYe8flBhIKL9j2iwXmvOMx61MdXNu3bqEvWB+9XSxiIUtKw5H3D8W
0QTM+dQR1eUBqwzP1bdo+oJbPvrrF1Z5Ydej7GzxG4TNPY9PdAI=
=PZp/
-----END PGP SIGNATURE-----

--y4mw2jlmwswrkrl3--

