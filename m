Return-Path: <linux-fsdevel+bounces-7885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD49D82C5AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 20:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB531C2224E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8902515AD0;
	Fri, 12 Jan 2024 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9HDL39/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084A15AC6;
	Fri, 12 Jan 2024 19:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24469C433F1;
	Fri, 12 Jan 2024 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705086000;
	bh=m7FQqT69FKCbKfRvCdWqVmT0IcxozdYaYKLKAHsotj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9HDL39/2I2klqw7CnGqNvPQQ/uI8qsFjsWr3NcbPJ6LjCBU1yBIFsCPRdky4j1cX
	 7IFXn/4k6avuGL6cV+z206E7GMzA8d4Lo6Ilsk701QKl9tAj5mV+paJsJZEqA/lmwa
	 wbH2Uyd8gHa2MhMHlh1I+87GAL4SVQ1VB32aluX3YpH//WokxoXSXkAZc/Mv7JWcQ7
	 4S5qGVRiiG3bewknXxjK4Ly4Qq4492iX/chfljwoyRQsxyfplcrPhl8kqDpK3XvXJh
	 4APMnguIayyGcDed3HVIo/FBXk3n9T4txlfD0fPgYQfqxuIPxFW8XNQ+7SDWXQ6L9Y
	 cbLiWE3or+73w==
Date: Fri, 12 Jan 2024 18:59:55 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>,
	linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 5/9] selftests/landlock: Test IOCTL support
Message-ID: <d2fe6bbb-eb50-4b16-9ff2-b9b22d90a697@sirena.org.uk>
References: <20231208155121.1943775-1-gnoack@google.com>
 <20231208155121.1943775-6-gnoack@google.com>
 <11cdac1e-e96c-405f-63e8-35b0e2926337@arm.com>
 <ZaF3eWlwAPQcFpoG@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzh4NBdT+D8jFiTn"
Content-Disposition: inline
In-Reply-To: <ZaF3eWlwAPQcFpoG@google.com>
X-Cookie: I want a WESSON OIL lease!!


--hzh4NBdT+D8jFiTn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 06:31:37PM +0100, G=C3=BCnther Noack wrote:

> I tried this with the aarch64-linux-gnu-gcc-13 cross compiler on Debian, =
on
> next-20231215, but I can not reproduce it.

The KernelCI environment for building this is in a Docker container
kernelci/gcc-10_arm64 which is on hub.docker.com - it's just Debian
oldstable with the default toolchain.

> > Full log from a failure:
> > https://storage.kernelci.org/next/master/next-20231215/arm64/defconfig+=
kselftest/gcc-10/logs/kselftest.log

Today's -next log is at:

   https://storage.kernelci.org/next/master/next-20240112/arm64/defconfig/g=
cc-10/logs/kselftest.log

which looks about the same.

> > /tmp/kci/linux/build/usr/include     fs_test.c -lcap -o
> > /tmp/kci/linux/build/kselftest/landlock/fs_test
> > In file included from /tmp/kci/linux/build/usr/include/linux/fs.h:19,
> >                  from fs_test.c:12:
> > /usr/include/aarch64-linux-gnu/sys/mount.h:35:3: error: expected

> The IOCTL patch set has introduced an "#include <linux/fs.h>" at the top =
of
> selftests/landlock/fs_test.c (that file includes some IOCTL command numbe=
rs),
> but that should in my mind normally be safe to include?

I'd have expected so, and nothing in the header looks like it has
implicit dependencies or anything.

> I'm surprised that according to the log, fs.h line 19 is including sys/mo=
unt.h
> instead of linux/mount.h...?  This line says =E2=80=9C#include <linux/mou=
nt.h>=E2=80=9D?

I'm seeing sys/mount.h in -next 20240112 (ie, today):

  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
tools/testing/selftests/landlock/fs_test.c

AFAICT it appears to have been that way since the original commit?

> > identifier before numeric constant
> >    35 |   MS_RDONLY =3D 1,  /* Mount read-only.  */
> >       |   ^~~~~~~~~
> > In file included from common.h:19,
> >                  from fs_test.c:27:

> If you have more leads or more concrete reproduction steps, I'd be intere=
sted to
> know.  Otherwise, I'd have to just hope that it'll work better on the next
> attempt...?

The make command at the top of the logs linked above:

   make KBUILD_BUILD_USER=3DKernelCI FORMAT=3D.xz ARCH=3Darm64 HOSTCC=3Dgcc=
 CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPILE_COMPAT=3Darm-linux-gnueab=
ihf- CC=3D"ccache aarch64-linux-gnu-gcc" O=3D/tmp/kci/linux/build -C/tmp/kc=
i/linux -j10 kselftest-gen_tar

will hopefully DTRT in the above Docker container though I didn't
actually try locally.

--hzh4NBdT+D8jFiTn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWhjCoACgkQJNaLcl1U
h9CODQf6AmmPqgvSdyxKqnTt6JIt1aNsJl2v9OcagGpKYIZaDR6yoYEG/2h0dSwZ
nmjM5mx1uEiQRlRUmtmF7ah5WsWeSo6TpzjDLiEPTbdvt02R9UG14Pq/KcyKn71b
9E0+5pHZGqExAIlchXwTcLMYDcWUX4+WW6ytD85AjTJpEq0DZ+Vahsj+einmKgya
Xieg0TBUQmnCsREaEf81HklAHSGZPmSC4gxZZShfocExpvQPwDAd93O/XwdaOaZ+
sgtOWo9F8ATAzvZY8oMIkRHuYbYP+5IjZBSL8F52JPedj6EMPxu333TpBGPmOzSw
p9ZT+ET4775ynMDY/OZ2A3NZhN/Fqw==
=th9U
-----END PGP SIGNATURE-----

--hzh4NBdT+D8jFiTn--

