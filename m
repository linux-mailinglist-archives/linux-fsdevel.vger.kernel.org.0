Return-Path: <linux-fsdevel+bounces-65691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FE3C0CE98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C791A404A5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DAE2F5473;
	Mon, 27 Oct 2025 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnDrKbSu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA22F363F;
	Mon, 27 Oct 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560117; cv=none; b=qTe3l4n+f9lbugTdKDqWVHRl7iR32EFu+aSf57Afb8bKzwvHhHV9Scemnaas9O6oEGLcK3i6s9hWcibmTcJX1YoHZRz6iV11XEy6GCnNsgVGM459w2IET7aEyZno4uT6zmI1e6HfYoAYSruvL1gwPG1mxVcdF94vCS2uGVEoJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560117; c=relaxed/simple;
	bh=vTE9LPxg24iHozkReY1+Mh5ofYB4jYBXOkSmeqSjVnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDElHIDJ210mut+a/ect81NuJoUqzyvsyzX7KVPmA/EFZNJmhgpMZdkU4WZPwVkCBnyNLWbJPe/TGtzZryhh2R+2PO+EJr9NnbvTTJrm6zrJ3TTFO2UDM6hxti1h7NSg0txWYwqWUuXRJI6tReoX6N9GdznvsPArJ7BooDpTpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnDrKbSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752E1C4CEF1;
	Mon, 27 Oct 2025 10:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761560117;
	bh=vTE9LPxg24iHozkReY1+Mh5ofYB4jYBXOkSmeqSjVnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnDrKbSuingOWZuuo7QqceaTUEXdzwjscNGyHpBW4pAWvtqmychPnVk2SZTkChp0v
	 0faQCyL0fdJSQ9DMxtNd8cMuYpWTR6k4ixDHluJOQH4xZi7/RFKC70hyAqCVClGV3m
	 O2TyzB681P+B/n3SY6g+6AWRQktdCo51qDGgrqfcZXxLPR0lFE20Kqq/FVhkHGcTm1
	 VNq22vv4vAH8At2Sjl83UyXjLs/2Vd9XqSxhGddBKH5Q1NPk6OzbFzp2FqLVk1YEQt
	 fGCzpL+QaDItGvzdA3RoNdgfofBddS2oWdfp+47hrOkEkgHpOqEr6ItCNaGdNWbXpr
	 UdS1ySw+kCpzQ==
Date: Mon, 27 Oct 2025 11:14:55 +0100
From: Joel Granados <joel.granados@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] sysctl: Wrap do_proc_douintvec with the public
 function proc_douintvec_conv
Message-ID: <wxumqnq4u6c3m3oqycvryjghtrrfqn3nbgvrxv2goitprsttdd@i7lilfbyptye>
References: <20251017-jag-sysctl_jiffies-v1-7-175d81dfdf82@kernel.org>
 <202510221719.3ggn070M-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gcejqfjgqta6hmek"
Content-Disposition: inline
In-Reply-To: <202510221719.3ggn070M-lkp@intel.com>


--gcejqfjgqta6hmek
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 05:18:51PM +0800, kernel test robot wrote:
> Hi Joel,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 130e5390ba572bffa687f32ed212dac1105b654a]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Granados/sysc=
tl-Allow-custom-converters-from-outside-sysctl/20251017-163832
> base:   130e5390ba572bffa687f32ed212dac1105b654a
> patch link:    https://lore.kernel.org/r/20251017-jag-sysctl_jiffies-v1-7=
-175d81dfdf82%40kernel.org
> patch subject: [PATCH 7/7] sysctl: Wrap do_proc_douintvec with the public=
 function proc_douintvec_conv
> config: i386-randconfig-063-20251022 (https://download.01.org/0day-ci/arc=
hive/20251022/202510221719.3ggn070M-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251022/202510221719.3ggn070M-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510221719.3ggn070M-lkp=
@intel.com/
>=20
> sparse warnings: (new ones prefixed by >>)
> >> kernel/kstack_erase.c:34:56: sparse: sparse: incorrect type in argumen=
t 3 (different address spaces) @@     expected void *buffer @@     got void=
 [noderef] __user *buffer @@
>    kernel/kstack_erase.c:34:56: sparse:     expected void *buffer
>    kernel/kstack_erase.c:34:56: sparse:     got void [noderef] __user *bu=
ffer
This is probably a false positive where the warning was already there
but it moved up in the output (probably due to the function moving up in
the header?)

This made me look a bit more into the issue and I believe that it does
show an issue. Not with the current series, but with commit 0df8bdd5e3b3
("stackleak: move stack_erasing sysctl to stackleak.c"). In this commit
the buffer argument was changed frim void* to void __user*
but in 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
the "__user" was removed. I'll post another patch to fix this up.


Best

>    kernel/kstack_erase.c:54:35: sparse: sparse: incorrect type in initial=
izer (incompatible argument 3 (different address spaces)) @@     expected i=
nt ( [usertype] *proc_handler )( ... ) @@     got int ( * )( ... ) @@
>    kernel/kstack_erase.c:54:35: sparse:     expected int ( [usertype] *pr=
oc_handler )( ... )
>    kernel/kstack_erase.c:54:35: sparse:     got int ( * )( ... )
>=20
> vim +34 kernel/kstack_erase.c
>=20
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  23 =20
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  24  #ifdef=
 CONFIG_SYSCTL
> 78eb4ea25cd5fd kernel/stackleak.c Joel Granados    2024-07-24  25  static=
 int stack_erasing_sysctl(const struct ctl_table *table, int write,
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  26  			voi=
d __user *buffer, size_t *lenp, loff_t *ppos)
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  27  {
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  28  	int r=
et =3D 0;
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  29  	int s=
tate =3D !static_branch_unlikely(&stack_erasing_bypass);
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  30  	int p=
rev_state =3D state;
> 0e148d3cca0dc1 kernel/stackleak.c Thomas Wei=DFschuh 2024-05-03  31  	str=
uct ctl_table table_copy =3D *table;
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  32 =20
> 0e148d3cca0dc1 kernel/stackleak.c Thomas Wei=DFschuh 2024-05-03  33  	tab=
le_copy.data =3D &state;
> 0e148d3cca0dc1 kernel/stackleak.c Thomas Wei=DFschuh 2024-05-03 @34  	ret=
 =3D proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  35  	state=
 =3D !!state;
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  36  	if (r=
et || !write || state =3D=3D prev_state)
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  37  		retu=
rn ret;
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  38 =20
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  39  	if (s=
tate)
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  40  		stat=
ic_branch_disable(&stack_erasing_bypass);
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  41  	else
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  42  		stat=
ic_branch_enable(&stack_erasing_bypass);
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  43 =20
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  44  	pr_wa=
rn("stackleak: kernel stack erasing is %s\n",
> 62e9c1e8ecee87 kernel/stackleak.c Thorsten Blum    2024-12-22  45  					s=
tr_enabled_disabled(state));
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  46  	retur=
n ret;
> 964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  47  }
> 1751f872cc97f9 kernel/stackleak.c Joel Granados    2025-01-28  48  static=
 const struct ctl_table stackleak_sysctls[] =3D {
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  49  	{
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  50  		.pro=
cname	=3D "stack_erasing",
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  51  		.dat=
a		=3D NULL,
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  52  		.max=
len		=3D sizeof(int),
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  53  		.mod=
e		=3D 0600,
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  54  		.pro=
c_handler	=3D stack_erasing_sysctl,
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  55  		.ext=
ra1		=3D SYSCTL_ZERO,
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  56  		.ext=
ra2		=3D SYSCTL_ONE,
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  57  	},
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  58  };
> 0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  59 =20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

--=20

Joel Granados

--gcejqfjgqta6hmek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmj/RhYACgkQupfNUreW
QU9FlQv/YYZc+g3rOBU0xvyUK50UlyH6BF9vEFQJRIfqnFmnd9UFuO8ZiocZnOum
ewoSNsEEBwuoyRzIHvLALhmAdImySrrXtpRgYpMxMON2sSWKXat5zzZd6FF2n2ED
3EbezK9Gt9t5SmhHrUE9hYQSxFJNFYE7BOgO0VKD64XEeT5lIzR7ad2FGg3r0phR
kjGeQLcvyZlP0X50rRglcNnhJAubalK61pi3ijDdO+0hSPeQ1wjIPWWqmxyKfpk0
EJMybkXN3UTFvj3gbP8szlXa3PkVGm+SwlPN1b9PYWZ/V0Zoy3RMNZaA313lbM74
9N7giX2vLNCP8aSkmZv1Pl94B68LKTmo6LWQTU0ivbGMcAJ52y+WoT9rNgqrvohi
Uhnwvvq/zqDfLotme4uXPluvJY84vdsfIueEx8F2R/GpMx4+xLWVrRuoedIwOj2W
h9HmS16QgyRoMT1bLLXqyILuBddgqLrNy4aGFLppohtBhR2N9MWMyS1LRUmT15Gp
+o9e/fN8
=mi27
-----END PGP SIGNATURE-----

--gcejqfjgqta6hmek--

