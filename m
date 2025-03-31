Return-Path: <linux-fsdevel+bounces-45337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F83EA76571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CDB3A6CB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3DA1E32DB;
	Mon, 31 Mar 2025 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhmZNge8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3E1BC073;
	Mon, 31 Mar 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423057; cv=none; b=IJ1lIVCrVWc6E8YJ1JBLOTLt21lQIjtgQ00uTWIdLEAgtY6ZDhfGtIT5PDYBYje6eU68fHLZXCcaXSsrYesTkQH3RPx8EMGmYxucDPz5NXFtwwc0bdSTc6o9SXmKocJt96j7VosBEGUTw3eeZam9YDHRpG8lRHX5CVXfbpmoF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423057; c=relaxed/simple;
	bh=GlFA11aaeLlP4+mdopv4QN65pBT31SFcM+ygWQzrY5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb4Q01YG3zkQiLJgW81A0qOjy4n97BHqmEXFDOP2UkEt090OWAHL+VhlyfJEsp12Q9XwCydfWf1NPTPZl3bO5YQksq56Sh8kXhusdRwxW1nYmQHqhdLXROWLe3TeuRKeANb0TZike5lr1Sa5TiqN4banxo/7SDgPHrMVJqpw83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhmZNge8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186A6C4CEE3;
	Mon, 31 Mar 2025 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423056;
	bh=GlFA11aaeLlP4+mdopv4QN65pBT31SFcM+ygWQzrY5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhmZNge8CCXhHx2p7RNBAOCzVzCU0prhIdijEykOsHon1ADwr3m5x+uV/Rod+PKrq
	 vpEJfX9NX8U5T9d5ViTNxQ4ldkTamD4KcJDvUEKgauII6msL/YQDk2IM+Me0gDnxdy
	 K/6MQdfWWE9ccmV38sNxyW4xK1j8ZauA+pEZi9l0FPhItBG7GiNIfpQLaftr1Z6jMZ
	 inQ8BxiGR4ssMHln8sYaKJirZmrR6LFyrGQLX+40Vzt/kJKL8WPxMer17K3wYZW0nU
	 4dk44yyqGOjpSu+QDXlGIcBOZwiuwlc/krfkhJ3L54g7O247mKsyuVg9FojyP9l455
	 ma1VoIa7TUouA==
Date: Mon, 31 Mar 2025 14:10:52 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Alejandro Colomar <alx.manpages@gmail.com>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Krishna Vivek Vitta <kvitta@microsoft.com>
Subject: Re: [PATCH] fanotify: Document FAN_REPORT_FD_ERROR
Message-ID: <clzz3vdr5wroczrq3kaskaelip5u7bmqfzt4sufnyltsqi4qdb@675aoodlxmcy>
References: <20250330125146.1408717-1-amir73il@gmail.com>
 <vflts4w73gy23iquev6yxrvbzguxkvlx7ccrcuww3hhvjbuw4q@dqr3up7qjwgx>
 <CAOQ4uxhDR8s5yHc-=xoWCeP5AA49dGoGhk=SU=9ykz+ajOco4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="saevwewhqdfyyubw"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhDR8s5yHc-=xoWCeP5AA49dGoGhk=SU=9ykz+ajOco4Q@mail.gmail.com>


--saevwewhqdfyyubw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Alejandro Colomar <alx.manpages@gmail.com>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Krishna Vivek Vitta <kvitta@microsoft.com>
Subject: Re: [PATCH] fanotify: Document FAN_REPORT_FD_ERROR
References: <20250330125146.1408717-1-amir73il@gmail.com>
 <vflts4w73gy23iquev6yxrvbzguxkvlx7ccrcuww3hhvjbuw4q@dqr3up7qjwgx>
 <CAOQ4uxhDR8s5yHc-=xoWCeP5AA49dGoGhk=SU=9ykz+ajOco4Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhDR8s5yHc-=xoWCeP5AA49dGoGhk=SU=9ykz+ajOco4Q@mail.gmail.com>

Hi Amir,

On Mon, Mar 31, 2025 at 01:55:11PM +0200, Amir Goldstein wrote:
> and formatting of:
>=20
> in case of a queue overflow, the value will be
> +.BR "" - EBADF .

The '-' needs to be escaped: \-

Also, I'd keep the '-' also in bold:

=2EBR \-EBADF .


Have a lovely day!
Alex

>=20
> As Alejandro requested in another review.
>=20
> Will post v2 soon.
>=20
> Thanks,
> Amir.

--=20
<https://www.alejandro-colomar.es/>

--saevwewhqdfyyubw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfqhkwACgkQ64mZXMKQ
wqkgDRAAoXcqdvMOixp4kiRJ3kuXanXopwxmZFaa6FMc1dWux18KYZHVCgmpYKsP
esYkd94/wcE84k91jayoQHTO3MJnxVnVCTWjImpH6qOTmYe9/hsdttS3tbyK5Rqa
+BpHBqIncvnP9ShtlWei2tfJhLFylUQGPU50doYiw1ecwPzkVKnrtk8MU/TwFSzN
FgEEnO7Wfu4A7/jebNEm8BpMK+F6cFUB4aVuVBgXfYMm14tVhjfac3BVbr4D4Yxc
kSRTUP5gvWFoqXrM7Uogw30WtYXtzSA2IWvReq1w1uJwCJELs4vNMvMXP4DC7GAJ
OYFOxF40Rud5Bsh/sCXX4EkClQdum1Iw7d41HDF+SlP+NuFpnTFhkJDinMyOAe9J
3UA3n4t8IS/p1Jw2Eg2Q93ed1DuNLu90Zms9DPAMVEoHU+A+R2fsaTGpFpOckR4M
xZLIQ9IimqGpNyX80ajetnRzaXqK8Ik72/NntdCs+7pTZxQ7NQ9yrPA//PG+kub6
AIwClOB8SG5XIQ7BhmA/YjcIA7+657aKMdor3qgKE6QWCWIshzm3Bluq0bg/XviU
kVk9vfPC6EfZ5hZU0Syho2Blet5Ahjk41G9mNl5NuysFxegwKNj1G2ye6fwlF87O
41zacYnF0fhtJt/X1weHKEqu98VA1/tzm2Jwt4mJ9utAz7jR6+Q=
=GrHZ
-----END PGP SIGNATURE-----

--saevwewhqdfyyubw--

