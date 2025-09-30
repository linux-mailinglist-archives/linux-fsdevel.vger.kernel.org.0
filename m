Return-Path: <linux-fsdevel+bounces-63119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD5FBADFA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 17:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899E84C1EFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63077308F24;
	Tue, 30 Sep 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Oe2z1UoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C632505AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247534; cv=none; b=Lf+Qj/Bpf2gGc6tWRemIUamhzxCQ9ihZTPge4g6ebiSzIzeJpA01IV+Z75t1WFwq9NmD67/aAnh9YkGssafsXHirfVUsDWuGISk+3Jb4WnS2zqADBbmkOq5IKjQF8sKgM/aRtiUuuz+ZJ2I0mmL8Km4HQwZrjGM3sgo3wCcgvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247534; c=relaxed/simple;
	bh=Jwo1nfDGTjIWmG9cvdjgJDXOj/gGfPJGkekPHSQ7lu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4cOt8ik0JHXTAFhKUDZAX7KYjMjEFIdwG/vlZkuVFjhfYWiUwSqRDqa09lKzuYVjyNoXL8gUa/ONacW0vZxvvaSE4loaDVv7swDRdJjKCVs327B1KFXxjVRpTsUEICHof9Sti9jGtbjmZt9HotDoQrSuqBK10qYx3frHC9v8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Oe2z1UoB; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cbjHC39Qrz9tSL;
	Tue, 30 Sep 2025 17:52:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1759247527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CdiBOlpd/2drqikpy3t44xz7MPgX0WLp0RFYtq9hFyU=;
	b=Oe2z1UoB2s0QeorJ9E7bZSpCl+R6Yro5JsjTyQ4aiFMacXf+Zmm9nSskuva51P2tYpHp0E
	EcwspjrVM2JbMcwONBh1uh363QXjgu9f4+emt35fzs9wnDlqp/zOmh9R1OUX+jGK5rAkY5
	4TZdnX439TFzWWho86WSQjVEcwbrasHB0EULh1xCWL5nezIgMiCaJT1d+mLHPF6mYx9f6k
	55kJzQVCcQyx8qfcv6Z/vvNXLzzrJk49wXhEGFviWGlWjJpxOt8mOtB2MOgM7WGDRCpJ3m
	AsNIRCbGgqdpP7lvRS3Z/YDex0pEU/uHSa1ehSNAhBax6QpxAPR/sK88m7D9HA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 1 Oct 2025 01:51:53 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: brauner@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC 0/6] proc: restrict overmounting of ephemeral entities
Message-ID: <2025-09-30-emerald-unsure-pillow-prism-nKVGLB@cyphar.com>
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
 <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cmo3t3oeowmhuf2q"
Content-Disposition: inline
In-Reply-To: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
X-Rspamd-Queue-Id: 4cbjHC39Qrz9tSL


--cmo3t3oeowmhuf2q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/6] proc: restrict overmounting of ephemeral entities
MIME-Version: 1.0

On 2025-09-30, Petr Vorel <pvorel@suse.cz> wrote:
> From: Christian Brauner <brauner@kernel.org>
>=20
> Hi Christian, all,
>=20
> > (Preface because I've been panick-approached by people at conference
> >  when we discussed this before: overmounting any global procfs files
> >  such as /proc/status remains unaffected and is an existing and
> >  supported use-case.)
>=20
> > It is currently possible to mount on top of various ephemeral entities
> > in procfs. This specifically includes magic links. To recap, magic links
> > are links of the form /proc/<pid>/fd/<nr>. They serve as references to
> > a target file and during path lookup they cause a jump to the target
> > path. Such magic links disappear if the corresponding file descriptor is
> > closed.
>=20
> > Currently it is possible to overmount such magic links:
>=20
> > int fd =3D open("/mnt/foo", O_RDONLY);
> > sprintf(path, "/proc/%d/fd/%d", getpid(), fd);
> > int fd2 =3D openat(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
> > mount("/mnt/bar", path, "", MS_BIND, 0);
>=20
> > Arguably, this is nonsensical and is mostly interesting for an attacker
> > that wants to somehow trick a process into e.g., reopening something
> > that they didn't intend to reopen or to hide a malicious file
> > descriptor.
>=20
> > But also it risks leaking mounts for long-running processes. When
> > overmounting a magic link like above, the mount will not be detached
> > when the file descriptor is closed. Only the target mountpoint will
> > disappear. Which has the consequence of making it impossible to unmount
> > that mount afterwards. So the mount will stick around until the process
> > exits and the /proc/<pid>/ directory is cleaned up during
> > proc_flush_pid() when the dentries are pruned and invalidated.
>=20
> > That in turn means it's possible for a program to accidentally leak
> > mounts and it's also possible to make a task leak mounts without it's
> > knowledge if the attacker just keeps overmounting things under
> > /proc/<pid>/fd/<nr>.
>=20
> > I think it's wrong to try and fix this by us starting to play games with
> > close() or somewhere else to undo these mounts when the file descriptor
> > is closed. The fact that we allow overmounting of such magic links is
> > simply a bug and one that we need to fix.
>=20
> > Similar things can be said about entries under fdinfo/ and map_files/ so
> > those are restricted as well.
>=20
> > I have a further more aggressive patch that gets out the big hammer and
> > makes everything under /proc/<pid>/*, as well as immediate symlinks such
> > as /proc/self, /proc/thread-self, /proc/mounts, /proc/net that point
> > into /proc/<pid>/ not overmountable. Imho, all of this should be blocked
> > if we can get away with it. It's only useful to hide exploits such as i=
n [1].
>=20
> > And again, overmounting of any global procfs files remains unaffected
> > and is an existing and supported use-case.
>=20
> > Link: https://righteousit.com/2024/07/24/hiding-linux-processes-with-bi=
nd-mounts [1]
>=20
> this is fixing a security issue, right? Wouldn't it be worth to backport =
these
> commits to active stable/LTS kernels. I guess it was considered as a new =
feature
> that's why it was not backported (looking at 6.11, 6.6 and 6.1).

It's a security hardening against some attack methods, but it's not
necessarily fixing a specific security issue. It is possible to operate
on such paths safely in most situations[1] so it's not a critical issue
(though I am happy to see the fix, as it makes openat2 more trivially
useful for this case and protects unprivileged programs).

I suspect Christian didn't mark it for stable because there was a risk
of breaking programs (fwiw, it did "break" some tests I had for the
library I linked in [1] since we had test scenarios to make sure we
handled this attack pattern safely, but that was expected -- I don't
think any actual user was affected by this change). And yes, it's
arguably a new feature.

[1]: https://docs.rs/pathrs/latest/pathrs/procfs/struct.ProcfsHandle.html#m=
ethod.open_follow

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--cmo3t3oeowmhuf2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaNv8lhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8fSwD/amnUy59ZXiYnRHP57VD+
tQhEMHExuVlXOzo8smNcGgEA/i+mdFEKtXi1x9Odgj5aB58eKZdaIdVgERnl2Z7Y
AlwM
=b80l
-----END PGP SIGNATURE-----

--cmo3t3oeowmhuf2q--

