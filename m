Return-Path: <linux-fsdevel+bounces-55424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF5B0A2AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37032A83FD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EC12D978C;
	Fri, 18 Jul 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="J9BpGE93"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B82980D3;
	Fri, 18 Jul 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838852; cv=none; b=e6lpoFjUuFi5n/+IswIm/vJCReYKF+cCoDQA2KsaBiiDq8vDaK6ZX4gCyzN5Z862zQU9PXYTtoBvwYKK9AxIMlocp23eAghseBxAMGzdDhKzGvoaB4Ad8WCMXFKe+hTh9Ov2PpF55l/drMgG0ENG9/r4pyt8NN/QokpBJHOXUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838852; c=relaxed/simple;
	bh=mA1MWvNRGWfNtQq0SRgcQjII9Lttlm06XohuZl0OtY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBkndtlv/9FHoBiLnWPmMeaMzEzwsaH3YBg+KK6rIO76CnpmP1ByqLBGxi+QxWKojNuL4sWsb7hRj9h+tZhUvnPHyxX02wtet+NAu4JGyGB/3MPMWFxOu1kFneKbnHLmXujcMpd877+aY0QhXEHjfDsCu97i3HjnaFLR6CnlzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=J9BpGE93; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bk7CD4tVfz9sdT;
	Fri, 18 Jul 2025 13:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1752838840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEkUxZUCi2roY/DEziCCa2toSKkHuTmtSScx7WGI83s=;
	b=J9BpGE93/spo7lVfiSZRNkIE0zyUcHHoJxbPfIvh1KhZMPpz7QpVG/fgxd1vmPkUvrXEEa
	GeKxs8BDnh7VUHoVjq+UHdqEP14BR05+1hptXsUpQDKdM+vPHdAGX4YabhYmr5icCoTxSW
	w0qylEE4h5IAatwCixvQMMDyQWGoBmzSjcBkueXlZ/oSn4b13SzzNgvF+7QFDwVI2aXavm
	FdLvZujbLH4w0I3X6p3dYSnDVRnCQjHAMIXJalW0cUeYQsBuim+X1X1wfh62mNH2Wm9zGb
	mHef4d3roHF9MR3sZc0mszMALoUisoxTedVFBSpZ1xATRZuldaLuwcf2SHfvGg==
Date: Fri, 18 Jul 2025 21:40:29 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: nicolas.bouchinet@oss.cyber.gouv.fr
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vasiliy Kulikov <segooon@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Subject: Re: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
Message-ID: <20250718.113751-obedient.unloader.usable.clocks-2vPOsgY9lE5m@cyphar.com>
References: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
 <20250718.091233-bored.chainsaw.organic.pose-0SJBoWYaT8s@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="or32ekau4muqvukz"
Content-Disposition: inline
In-Reply-To: <20250718.091233-bored.chainsaw.organic.pose-0SJBoWYaT8s@cyphar.com>


--or32ekau4muqvukz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
MIME-Version: 1.0

On 2025-07-18, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2025-07-18, nicolas.bouchinet@oss.cyber.gouv.fr <nicolas.bouchinet@oss=
=2Ecyber.gouv.fr> wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> >=20
> > The hidepid mount option documentation defines the following modes:
> >=20
> > - "noaccess": user may not access any `/proc/<pid>/ directories but
> >   their own.
> > - "invisible": all `/proc/<pid>/` will be fully invisible to other user=
s.
> > - "ptraceable": means that procfs should only contain `/proc/<pid>/`
> >   directories that the caller can ptrace.
> >=20
> > We thus expect that with "noaccess" and "invisible" users would be able=
 to
> > see their own processes in `/proc/<pid>/`.
> >=20
> > The implementation of hidepid however control accesses using the
> > `ptrace_may_access()` function in any cases. Thus, if a process set
> > itself as non-dumpable using the `prctl(PR_SET_DUMPABLE,
> > SUID_DUMP_DISABLE)` it becomes invisible to the user.
>=20
> In my view, the documentation is wrong here. This behaviour has remained
> effectively unchanged since it was introduced in 0499680a4214 ("procfs:
> add hidepid=3D and gid=3D mount options"), and the documentation was writ=
ten
> by the same author (added to Cc, though they appear to be inactive since
> 2013). hidepid=3Dptraceable was added many years later, and so the current
> documentation seeming somewhat contradictory is probably more a result
> of a new feature being documented without rewriting the old
> documentation, rather than an incorrect implementation.
>=20
> A process marking itself with SUID_DUMP_DISABLE is a *very* strong
> signal that other processes (even processes owned by the same user) must
> have very restricted access to it. Given how many times they have been
> instrumental for protecting against attacks, I am quite hesitant about
> making changes to loosen these restrictions.
>=20
> For instance, container runtimes need to set SUID_DUMP_DISABLE to avoid
> all sorts of breakout attacks (CVE-2016-9962 and CVE-2019-5736 being the
> most famous examples, but there are plenty of others). If a container
> has been configured with a restrictive hidepid, I would expect the
> kernel to block most attempts to interact with such a process to
> non-privileged users. But this patch would loosen said restrictions.
>=20
> Now, many of the bits in /proc/self/* are additionally gated behind
> ptrace_may_access() checks, so this kind of change might be less
> catastrophic than at first glance, but the original concerns that
> motivated hidepid=3D were about /proc/self/cmdline and the uid/euid of
> processes being discoverable, and AFAICS this patch still undoes those
> protections for the cases we care about with SUID_DUMP_DISABLE.
>=20
> What motivated you to want to change this behaviour?
>=20
> > This patch fixes the `has_pid_permissions()` function in order to make
> > its behavior to match the documentation.
> >=20
> > Note that since `ptrace_may_access()` is not called anymore with
> > "noaccess" and "invisible", the `security_ptrace_access_check()` will no
> > longer be called either.
> >=20
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >  fs/proc/base.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index c667702dc69b8ca2531e88e12ed7a18533f294dd..fb128cb5f95fe65016fce96=
c75aee18c762a30f2 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -746,9 +746,12 @@ static bool has_pid_permissions(struct proc_fs_inf=
o *fs_info,
> >  				 struct task_struct *task,
> >  				 enum proc_hidepid hide_pid_min)
> >  {
> > +	const struct cred *cred =3D current_cred(), *tcred;
> > +	kuid_t caller_uid;
> > +	kgid_t caller_gid;
> >  	/*
> > -	 * If 'hidpid' mount option is set force a ptrace check,
> > -	 * we indicate that we are using a filesystem syscall
> > +	 * If 'hidepid=3Dptraceable' mount option is set, force a ptrace chec=
k.
> > +	 * We indicate that we are using a filesystem syscall
> >  	 * by passing PTRACE_MODE_READ_FSCREDS
> >  	 */
> >  	if (fs_info->hide_pid =3D=3D HIDEPID_NOT_PTRACEABLE)
> > @@ -758,7 +761,25 @@ static bool has_pid_permissions(struct proc_fs_inf=
o *fs_info,
> >  		return true;
> >  	if (in_group_p(fs_info->pid_gid))
> >  		return true;
> > -	return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> > +
> > +	task_lock(task);
> > +	rcu_read_lock();
> > +	caller_uid =3D cred->fsuid;
> > +	caller_gid =3D cred->fsgid;
> > +	tcred =3D __task_cred(task);
> > +	if (uid_eq(caller_uid, tcred->euid) &&
> > +	    uid_eq(caller_uid, tcred->suid) &&
> > +	    uid_eq(caller_uid, tcred->uid)  &&
> > +	    gid_eq(caller_gid, tcred->egid) &&
> > +	    gid_eq(caller_gid, tcred->sgid) &&
> > +	    gid_eq(caller_gid, tcred->gid)) {
> > +		rcu_read_unlock();
> > +		task_unlock(task);
> > +		return true;
> > +	}
> > +	rcu_read_unlock();
> > +	task_unlock(task);
> > +	return false;
>=20
> At the very least, this check needs to be gated based on
> ns_capable(get_task_mm(task)->user_ns, CAP_SYS_PTRACE), to avoid
> containers from being able to introspect SUID_DUMP_DISABLE processes
> (such as container runtimes) in the process of joining a user namespaced
> container.

Actually get_task_mm(test)->user_ns =3D=3D current_user_ns() is probably
want you want? ns_capable(..., CAP_SYS_PTRACE) is basically an
equivalent of ptrace_may_access() here. But we very rarely do permission
checks based just on the userns -- we almost always use ns_capable()
since that actually handles the hierarchical relationship between user
namespaces regarding privileges.

Either way, I'm not a fan of this change, to be honest.

>=20
> >  }
> > =20
> > =20
> >=20
> > ---
> > base-commit: 884a80cc9208ce75831b2376f2b0464018d7f2c4
> > change-id: 20250718-hidepid_fix-d0743d0540e7
> >=20
> > Best regards,
> > --=20
> > Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> >=20
> >=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--or32ekau4muqvukz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaHoyrAAKCRAol/rSt+lE
byNSAP9QcB2S49DhCHeBHWe8EQ+quetOJlf5GCSrdxWjWLXlvwD+OKiJdu+jVgY+
J/FABDh2NuemKJGa4rY/iXOrE06q4Ak=
=VRVe
-----END PGP SIGNATURE-----

--or32ekau4muqvukz--

