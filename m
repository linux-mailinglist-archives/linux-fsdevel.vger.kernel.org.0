Return-Path: <linux-fsdevel+bounces-37069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713689ED093
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1260166FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DB11D8A0B;
	Wed, 11 Dec 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="OpYDxry5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79B1D8A0A;
	Wed, 11 Dec 2024 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932638; cv=none; b=CRWLTCI4O7/azMu/rPJX4cWlNxnVcn2bMytzSJ7U76xxc2oe8fCk4qlOWosClTL1/Qfa4k5SMv01s26UC9mF+NMb9jIjdPTxqzTRg+kx3GKsHxQvXwN8j1GMhAENLvbFlOEEyARUr3Hr4nfAhenDuKRjqdSI0dLjhFDAsDaxz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932638; c=relaxed/simple;
	bh=LhBWnetEa7EnH0bvc4QTUwUKxwtf1sRM8s722VoNrZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIqWl4rVpNjOgdlJZPaBBVKUnIfoJD4lj0uBIGBjAY+vVMay/uVnDiMvx6ssoFlX0ylQd38tOvI65heFJ+uCSkuHunhJqxwtL45zGPuFAC6Lw6jNT132LZ7OAAL2pfFKNYau1v+e+dJKEczYsYfy8uaKEDS/JFblfX1sCtfHcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=OpYDxry5; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y7gGF6ZXwz9smr;
	Wed, 11 Dec 2024 16:57:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1733932630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f3Qm2BtJvGQLr3jx5ekPIHyYthuTEmSrovK+Z93kgNk=;
	b=OpYDxry5RKhdB/XD6Id+E9LL/0nj29WPTawQuZdiqsRJ23xml701GMuCR7XeM78XmwuaS+
	cNBaiC8oV7O3QwlNQAU7gobvCJ4NhcfOy/z5/8ZkF8zNqpyerXY7TbqmDsgOmbUoaSBNs+
	lXHTOsdUuRxVVN2jhGE614QIg52uioCicpjPEYAsiIakvYWS3EPs6gVfrrzif1t3IPM6jx
	2bcTutHQZkC2WOMFdqNm1pG1TFD30spFwfJ56yNuTcYhPjFg3eStmacWScieiglF9XFl0B
	W5Y80hY965GMP9faDEg9ZpJDnU3P6jxzjzcgsUR5k7WRYlwDsHlCgW+/MRJhlw==
Date: Thu, 12 Dec 2024 02:56:59 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add a prctl to disable ".." traversal in path resolution
Message-ID: <20241211.154841-core.hand.fragrant.rearview-Ajjgdy5TrwhO@cyphar.com>
References: <20241211142929.247692-1-mjg59@srcf.ucam.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="msbivhjxhint4xzu"
Content-Disposition: inline
In-Reply-To: <20241211142929.247692-1-mjg59@srcf.ucam.org>


--msbivhjxhint4xzu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] Add a prctl to disable ".." traversal in path resolution
MIME-Version: 1.0

On 2024-12-11, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> Path traversal attacks remain a common security vulnerability
> (https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=3D%22path+traversal%22)
> and many are due to either failing to filter out ".." when validating a
> path or incorrectly collapsing other sequences of "."s into ".." .
> Evidence suggests that improving education isn't fixing the problem.

I was thinking about adding a RESOLVE_NO_DOTDOT which would do something
like this but on a per-openat2-call basis.

The main problem with making this global for the entire process is that
most tools would not be able to practically enable this for themselves
as it would require auditing the entire execution environment as well as
all dependencies that might dare to use ".." in a path anywhere in their
codebase.

Given that "nosymfollow" was added by Google because of the
impossibility of a similar kind of audit, I feel enabling this would
face a pretty similar issue. I get that returning an error (even if it
kills the program) could be seen as preferable in some cases, but as a
general-purpose tool I don't really see how any program could enable
this without fear of issues. Even if the application itself handles
errors gracefully, there's no way of knowing whether some dependency (or
even the stdlib / runtime) will abort the program if it gets an error.

> The majority of internet-facing applications are unlikely to require the
> ability to handle ".." in a path after startup, and many are unlikely to
> require it at all. This patch adds a prctl() to simply request that the
> VFS path resolution code return -EPERM if it hits a ".." in the process.
> Applications can either call this themselves, or a service manager can
> do this on their behalf before execing them.

I would suggest making this -EXDEV to match the rest of the RESOLVE_*
flags (in particular, RESOLVE_BENEATH).

> Note that this does break resolution of symlinks with ".." in them,
> which means it breaks the common case of /etc/whatever/sites-available.d
> containing site-specific configuration, with
> /etc/whatever/sites-enabled.d containing a set of relative symlinks to
> ../sites-available.d/ entries. In this case either configuration would
> need to be updated before deployment, or the process would call prctl()
> itself after parsing configuration (and then disable and re-enable the
> feature whenever re-reading configuration). Getting this right for all
> scenarios involving symlinks seems awkward and I'm not sure it's worth
> it, but also I don't even play a VFS expert on TV so if someone has
> clever ideas here we can extend this to support that case.

I think RESOLVE_BENEATH is usually more along the lines of what programs
that are trying to restrict themselves would want (RESOLVE_IN_ROOT is
what extraction tools want, on the other hand) as it only blocks ".."
components that move you out of the directory you expect.

It also blocks absolute symlinks, which this proposal does nothing about
(it even blocks magic-links, which can be an even bigger issue depending
on what kind of program we are talking about). Alas, RESOLVE_BENEATH
requires education...

> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> ---
>  fs/namei.c                 | 7 +++++++
>  include/linux/sched.h      | 1 +
>  include/uapi/linux/prctl.h | 3 +++
>  kernel/sys.c               | 5 +++++
>  4 files changed, 16 insertions(+)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 9d30c7aa9aa6..01d0fa415b64 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2431,6 +2431,13 @@ static int link_path_walk(const char *name, struct=
 nameidata *nd)
> =20
>  		switch(lastword) {
>  		case LAST_WORD_IS_DOTDOT:
> +			/*
> +			 * Deny .. in resolution if the process has indicated
> +			 * it wants to protect against path traversal
> +			 * vulnerabilities
> +			 */
> +			if (unlikely(current->deny_path_traversal))
> +				return -EPERM;
>  			nd->last_type =3D LAST_DOTDOT;
>  			nd->state |=3D ND_JUMPED;
>  			break;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d380bffee2ef..9fc7f4c11645 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1008,6 +1008,7 @@ struct task_struct {
>  	/* delay due to memory thrashing */
>  	unsigned                        in_thrashing:1;
>  #endif
> +	unsigned                        deny_path_traversal:1;
>  #ifdef CONFIG_PREEMPT_RT
>  	struct netdev_xmit		net_xmit;
>  #endif
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 5c6080680cb2..d289acecef6c 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -353,4 +353,7 @@ struct prctl_mm_map {
>   */
>  #define PR_LOCK_SHADOW_STACK_STATUS      76
> =20
> +/* Block resolution of "../" in paths, returning -EPERM instead */
> +#define PR_SET_PATH_TRAVERSAL_BLOCK      77
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index c4c701c6f0b4..204ea88d5597 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2809,6 +2809,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		error =3D arch_lock_shadow_stack_status(me, arg2);
>  		break;
> +	case PR_SET_PATH_TRAVERSAL_BLOCK:
> +		if ((arg2 > 1) || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		current->deny_path_traversal =3D !!arg2;
> +		break;
>  	default:
>  		error =3D -EINVAL;
>  		break;
> --=20
> 2.47.0
>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--msbivhjxhint4xzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZ1m2SwAKCRAol/rSt+lE
byVvAPwNDSnF2OWpYiNQVfsXwh3F5v9rjAIAw8jPxfmD5liUpwEAjjAZyl/S97bP
Hk6WcKgr1Lfn8CpB2fQClgTfv1aoYgE=
=NUaL
-----END PGP SIGNATURE-----

--msbivhjxhint4xzu--

