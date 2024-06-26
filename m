Return-Path: <linux-fsdevel+bounces-22539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44557918EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9DF6B21408
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 18:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6EE190687;
	Wed, 26 Jun 2024 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRCEHB39"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2E18FC85;
	Wed, 26 Jun 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427270; cv=none; b=FqKvgHkz8bHT6E8n4MA1KAZgI1JVkjg1oU/3+o4wfi2kuNm7xK4f0jRlXA14lHKhXy3KD0BvPnshe41/Qln76YBGwsM3SxyA9F8P9dhxncZNyS26LDNs4L58uYbtCmTZMQhbKkm9x5xM7y0VGIBVl22KzGc3dFlcXfKH/4OKTE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427270; c=relaxed/simple;
	bh=P15pVHpQBQLCg8IsjhfmV7XSADkHliiKfTQZGsJMbMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbRwrPZDhE/uLxDnAkn/qjtDrHGjeKA2LplFnzYsK58cn6QHbkQnLNquJ5eq1OK/+m38o4nrj7DKnia5Xa9kRXmmNxpf913vCoR11eJYGSeKKBpWmf1vyvmYpadeb4bOoTD7bgutOplwQDi9ui3GXvLZ76IRUT58R31w/p39tV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRCEHB39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7369C116B1;
	Wed, 26 Jun 2024 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719427270;
	bh=P15pVHpQBQLCg8IsjhfmV7XSADkHliiKfTQZGsJMbMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRCEHB39kZ1Bg4xlDyS4eI4v92uj/sSgG6mtRnAGTTIosAesliDDP4Od1abUUxmkz
	 9DsOo1aas8NVBGdnDbrbBiG23d8aaXVNuHGfUxM+mxVbCr0UfaJCWzv3Yl/RNDfPss
	 P3436S5tIZN0HWEPDDMhS51KeG/20LrKewgKjwiG3zWy27pkkYlvcL3WqeQ27CTfQ7
	 tJgrufj8HR3SuebNH/h/c16s60Mgc3hNsXEAjW4IpWblRKLDDbDjKF4DXNwd3Kb9UE
	 lmcS47aWXZUvdw00BqLzqtd0uDv64aL+Sx99RMJuhjz7YR/cuSdHKVIuD4j7drdvnN
	 WVbhc/JrpuNlA==
Date: Wed, 26 Jun 2024 20:41:06 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] man-pages: add documentation for
 statmount/listmount
Message-ID: <gsfbaxnh7blhcldfbnhup4wqb2e6gsccpgy4aoyglohvwkoly5@fcctrxviaspy>
References: <cover.1719417184.git.josef@toxicpanda.com>
 <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>
 <20240626180434.GA3370416@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zjyapvzhyvduedj7"
Content-Disposition: inline
In-Reply-To: <20240626180434.GA3370416@perftesting>


--zjyapvzhyvduedj7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] man-pages: add documentation for
 statmount/listmount
References: <cover.1719417184.git.josef@toxicpanda.com>
 <t6z4z33wkaf2ufqzt4dtkpw2xdjrr67pm5p5leikj3uj3ahhkg@jzssz7gcv2h5>
 <20240626180434.GA3370416@perftesting>
MIME-Version: 1.0
In-Reply-To: <20240626180434.GA3370416@perftesting>

Hi Josef,

On Wed, Jun 26, 2024 at 02:04:34PM GMT, Josef Bacik wrote:
> On Wed, Jun 26, 2024 at 07:02:26PM +0200, Alejandro Colomar wrote:
> > You can
> >=20
> > 	$ make lint build check -j8 -k
> > 	$ make lint build check
> >=20
> > to see the full list of failures.
>=20
> I captured the output of
>=20
> make lint build check -j8 -k > out.txt 2>&1

Hmmm, please do the following steps to have a cleaner log:

	## Let's see if the build system itself complains:
	$ make nothing >out0.txt

	## Skip checkpatch stuff:
	$ make -t lint-c-checkpatch

	## Make fast stuff that doesn't break:
	$ make lint build check -j8 -k >/dev/null 2>/dev/null

	## Now log the remaining errors:
	$ make lint build check >out.txt 2>&1

> and pasted it here
>=20
> https://paste.centos.org/view/ed3387a9

BTW, you seem to also be missing cppcheck(1), which at least in Debian
is provided in the cppcheck package.  It also seems to be available in
Fedora, but I don't know if your system will have it.

> Clang messes up a bunch for a variety of different pages.

I suspect the Clang errors to be due to missing libbsd-dev.

> Also I did hit some mandoc warnings on this series, I'll post a v3 in a m=
oment
> with those things fixed.  Thanks,

Thank you!

Have a lovely day!
Alex

>=20
> Josef

--=20
<https://www.alejandro-colomar.es/>

--zjyapvzhyvduedj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ8YMIACgkQnowa+77/
2zIYWg/+J8BZN3S5dK1pHTeXYOfEUh7fjFdYG73NGjakpQGPWjPAax49hORTP1GB
Iq6nGvTyBQ/zD2z3wJK1GZFxBJhJ67OeN7RGInp2diNF+VJjYaSyyBM9SX+Mpqa/
gXye4nh9GXlgE2fLvqpENZxHM3kXcg3JD+yjbL2lFfK8gp6b5I6eq/Fhrjhz7d92
hrIKL65He0cg8QxreyZ445bvUozhfNn9PlA2gd2YIjKgwFOKds6thGLuXPP329AC
MDq5cNy+XUBdIV9zIXxpSoPrx6of1HXYjFtTynn3HFFA9OBrqxa7GHSI8JdOiciB
llRXR4gMEJRoJ8AxInbZ/23OQaTFl62vZFs/nN863a3m1suEW3d2VDCZXyQ3L//U
g4Xdpst7mj+WCqqBIOM96nbJ9nQ03TI6Y14y9LvXHicxGTscNHymhOXMiNW5cbz7
8rirq//1LzuhF23jtfxopEQxAfnEkAEb1lCYCv23mVVv95XhJuzmQJQ2d35DiPBf
/8KzmMCZEGYsE91G1fWFt0YdUra+XnZ/w9MYrofD7R58+M2dLWYYLKLmphkgoOVU
gBaFELm/NHZ85dJNF8ZRekhr/c6pEUWCqSu20WpswIV5/i4JaiXof+HEheh3kVgo
D56tQswECNpIl6oUAVxKQ6vfy8QNjMe/90OEJ+FgEMSbEZKybGc=
=rnn6
-----END PGP SIGNATURE-----

--zjyapvzhyvduedj7--

