Return-Path: <linux-fsdevel+bounces-24102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E994093950C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 23:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54382823F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 21:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2A938F83;
	Mon, 22 Jul 2024 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN1LgmCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB2208CA;
	Mon, 22 Jul 2024 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682230; cv=none; b=SyzSZF8XWrvWq1Tztko6XC2ir9j7fsm2yWLMXorKWtO8InwKdnf9cE/crggu6/5YcImoyN172GQp6CMPCUgt+KIUsHTIbxtvp5yREucMYIkFytvBKVkiVePebPsBBbxndTsRiHSOvn+OUO6O9K9iuZPU32vSHNVsYYxOYIC2/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682230; c=relaxed/simple;
	bh=SGM7tjloApAi77PTq+M03dk14dJbbqlYJRDlNO0AhSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3DzWTnn+vYIExQHgHcPAmN9key6lkj3fTHzkoFXrsv5xiAxDboL8+mWjmqPuzL5pN3w+nKIfSsKlSawWEwOe1EisjXw562q7iHa/sM73KBqz1yMY0ydDlJxCLcE+bsvHBaktFfXzLSH/7OwFqbM5+osDyPjMGbJXRdRmMRVtG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN1LgmCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D40C4AF0B;
	Mon, 22 Jul 2024 21:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721682229;
	bh=SGM7tjloApAi77PTq+M03dk14dJbbqlYJRDlNO0AhSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vN1LgmCACd3nTKfkdCd2HQxMxAUXCgO/m1u04dcVA3T9Ww5Ws4qEiZt1UvNJY6mZO
	 Y688WKhcrV6TPB1PWjI6xy+M+3P62hFrMdXwFLA6xeLMkfoOVzLL5GlNooSfw9bZZ2
	 EtfUY3lpGAop960LLsScDnjjeUmFUZ+g2PPjjLLNnHWHDm3DI6NXQWAyB1qOqL8ejH
	 M4RhJT7Wl0MQDA3beyMpTimKKYKNyDs3mweqf8ryLQV9Kci7Oby0jSU+ig7srNDWCX
	 XzNKVEOy5DsW+nLGCTpNdcuKo4UUTNMltsOu+QnNMKcLf/eOMax7F+JeCYCan3FFXe
	 I8ld4a3JMBp5g==
Date: Mon, 22 Jul 2024 23:03:45 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v6 2/2] listmount.2: New page describing the listmount
 syscall
Message-ID: <yienrqsyrpfrsf45owd7tcfsy3ucpgjrgppvmtwf5o3skz5mui@zfpi6cim37ei>
References: <cover.1720549824.git.josef@toxicpanda.com>
 <2d72a44fa49f47bd7258d7efb931926b26de4004.1720549824.git.josef@toxicpanda.com>
 <54hz2cqibnocv7jtv6sxk3dta36bm32i7f6tzdqcjmtf4cmfyt@cv2g25p733y5>
 <20240722204416.GA2392440@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lqnori3mraft3vwx"
Content-Disposition: inline
In-Reply-To: <20240722204416.GA2392440@perftesting>


--lqnori3mraft3vwx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v6 2/2] listmount.2: New page describing the listmount
 syscall
References: <cover.1720549824.git.josef@toxicpanda.com>
 <2d72a44fa49f47bd7258d7efb931926b26de4004.1720549824.git.josef@toxicpanda.com>
 <54hz2cqibnocv7jtv6sxk3dta36bm32i7f6tzdqcjmtf4cmfyt@cv2g25p733y5>
 <20240722204416.GA2392440@perftesting>
MIME-Version: 1.0
In-Reply-To: <20240722204416.GA2392440@perftesting>

Hi Josef,

On Mon, Jul 22, 2024 at 04:44:16PM GMT, Josef Bacik wrote:
> > Would you mind adding an example program in a new patch?
>=20
> Yup I can do that, I was going to follow-up with a patch for the new exte=
nsions
> that have landed in this merge window, after the final release has been c=
ut.  Is
> it cool if I wait until then, or would you like something sooner?  Thanks,

Thanks!  And sure; you can wait as much as necessary.  :-)

Have a lovely night!
Alex

>=20
> Josef
>=20

--=20
<https://www.alejandro-colomar.es/>

--lqnori3mraft3vwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaeyTEACgkQnowa+77/
2zLzcg/+PUOKzZWCBRdkrNa94Ttrv2aRXViaegpHOu19alRAMFu6k1RofTIQ/YxM
g1iPGZMgHtTukqhgri5K+KNZ/fOcHDPp0iu51PULTYcOsyfzmAUX/wEfQ7n/hHNu
S627SwVEBXq9Y3lV4/klcN2A2MF/jhHI09H4cdGSkoK7pyZUNGVFDZCCvjEJ2ZBC
+3YhBRgl9HFBuMOWETDiNaVYs+pL4HNQ9wsY/kqVa2tjkkWS2lx8z19OcyR8qi/G
aKbboMXYdHOCAGk9dFHmcmPTX0tsrYKxO8yQastmSZdhJVgSZCkepqzElZ5Q9+BK
YrYo1GrLYaKsGUPDbFWSu/R7PkeCDO0Ch7qMxcOc5xjHElcxkzsBxPZ3kmHpABjP
T3x1dMyhrTbnYWU1nhn3cWoZHHsHJreF+lJyhrrgmiV3MbTl1QAmMtSMFcX1CLcI
ZwZ+P8+a7LbI+WnfvCfQGCLxldKmWbRzgG6XMgjciM3PmX2C7hP0gDDWw9fhDPp+
rHt/tj+WL01BM+8eo8iqcIhmAokSn9D7qU+reAWr/bW6hjLlV88rdtfkRIW2evpW
VemmxdT+jplApF3ROEDG4VGgr67bRXnEfQPhd14FOAyOMAPccPhKe65RZ1AhHplD
vC5lDPkeLWvGugXzhXkXVcgXrPfGZPsTnR+VgMREaBn/lNhwrf4=
=DK09
-----END PGP SIGNATURE-----

--lqnori3mraft3vwx--

