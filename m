Return-Path: <linux-fsdevel+bounces-59355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2E4B37FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A943B59E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103C72F9992;
	Wed, 27 Aug 2025 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ZapLpL6t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBF2D6E67;
	Wed, 27 Aug 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289918; cv=none; b=UMgK6SD1IBWTrpquf9nSbyHrckyfzwzuh8AxKtjM+WPMrI2c+mTBIKX3gh+Pdwy90tWtrmfmTi9E1GmgOYRY+oxE4AFPhCE9hmZPjy3JBHFXFI9Di0H+scIs5CuFs4BXDVPdQfEsATnZYp/vWlAxdV+NeKRTwfysSqAHuKCK494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289918; c=relaxed/simple;
	bh=XPl2g7WDs3JbKgk26q4rxu9kM2EPxRFCrrBvgQKPo6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWIDqXXxadGYnqSdC4T8jf5iPF/1C7WRnCAfoMZEagd8jdcw55v0NDVBIo6chywvsUAG8lracUU3WLSE++yp4uX7BiQGmuSvl5tlUfjtRM6cBlRR3egtSDQeOofTIJPuSRN6OQkgYmTRVQKwP2ZRA2es9A436aKUpdTwOLIUZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ZapLpL6t; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cBgTs1xGKz9t9B;
	Wed, 27 Aug 2025 12:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1756289905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dBzMc8hW8xZPxTir5qcU2slhopQXs2JBMXrGNOQicxo=;
	b=ZapLpL6tkC/22c/6dUGg0MFIAv6B9qFvyhC1dH+Y4jCzIIFMDR95YIgdQePV/YJ4jk0hvS
	VXrKh/sZv2XZTf+Flhx+UFB8+Z7xj6j3RgbA2eNBp+2qnTJeBdUCWievF6G0lg8P/gIcBJ
	NkJfqKm4Ww+I/DGBh9hFA75kP3KAYN7LFdufr9jdXLbb0kXNm4sMolaIkXGBs3UHGFyIQr
	ofBd0+Npj3xBDW8xy4322hGeIuBarnUFUvpeWI0w6jt12NrvK0fH23UC11nqblTRviMWzx
	zu0iOcXlkkxnj4vIxBIg2HVlXEiiUbOkqcdcQl0eVvJ7+AhvWW5yTsKTLqRtYw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 27 Aug 2025 20:18:03 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jann Horn <jannh@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, 
	Jeff Xu <jeffxu@chromium.org>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
Message-ID: <2025-08-27-dull-careless-mayhem-egg-vSz53F@cyphar.com>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ec6zrxfciyjwefi5"
Content-Disposition: inline
In-Reply-To: <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
X-Rspamd-Queue-Id: 4cBgTs1xGKz9t9B


--ec6zrxfciyjwefi5
Content-Type: text/plain; charset=utf-8; protected-headers=v1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
MIME-Version: 1.0

On 2025-08-22, Jann Horn <jannh@google.com> wrote:
> On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@dig=
ikod.net> wrote:
> > Add a new O_DENY_WRITE flag usable at open time and on opened file (e.g.
> > passed file descriptors).  This changes the state of the opened file by
> > making it read-only until it is closed.  The main use case is for script
> > interpreters to get the guarantee that script' content cannot be altered
> > while being read and interpreted.  This is useful for generic distros
> > that may not have a write-xor-execute policy.  See commit a5874fde3c08
> > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> >
> > Both execve(2) and the IOCTL to enable fsverity can already set this
> > property on files with deny_write_access().  This new O_DENY_WRITE make
>=20
> The kernel actually tried to get rid of this behavior on execve() in
> commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that had
> to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
> because it broke userspace assumptions.

Also the ETXTBSY behaviour for binaries is not always guaranteed to
block writes to the file. When we were discussing this back in 2021 and
when we initially removed it, I remember there being some fairly trivial
ways to get around it anyway (but because process mm is mapped with
MAP_PRIVATE, writes aren't seen by the actual process).

> > it widely available.  This is similar to what other OSs may provide
> > e.g., opening a file with only FILE_SHARE_READ on Windows.
>=20
> We used to have the analogous mmap() flag MAP_DENYWRITE, and that was
> removed for security reasons; as
> https://man7.org/linux/man-pages/man2/mmap.2.html says:
>=20
> |        MAP_DENYWRITE
> |               This flag is ignored.  (Long ago=E2=80=94Linux 2.0 and ea=
rlier=E2=80=94it
> |               signaled that attempts to write to the underlying file
> |               should fail with ETXTBSY.  But this was a source of denia=
l-
> |               of-service attacks.)"
>=20
> It seems to me that the same issue applies to your patch - it would
> allow unprivileged processes to essentially lock files such that other
> processes can't write to them anymore. This might allow unprivileged
> users to prevent root from updating config files or stuff like that if
> they're updated in-place.

Agreed, and this was one of the major issues with the also-now-removed
mandatory locking as well.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--ec6zrxfciyjwefi5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaK7bWxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8BJwEA2r5KJp+0B+qQ4YVavyco
A8Py5UCi+DekvW351onDL/MA/jtLP2AMIDumYZv7AiXGJ1zGg5a9K/A/77644X9d
688I
=E9Y1
-----END PGP SIGNATURE-----

--ec6zrxfciyjwefi5--

