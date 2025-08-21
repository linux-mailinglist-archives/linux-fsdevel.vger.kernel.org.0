Return-Path: <linux-fsdevel+bounces-58571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A2B2EDA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 07:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2AA5C46A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 05:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8B2C21CA;
	Thu, 21 Aug 2025 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5WXVH4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D826A0A7;
	Thu, 21 Aug 2025 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755027; cv=none; b=E9SQDF2AoMXeTbaDDuegrmR/L7iOU71Q67NQnH+6CI35DBY0KmuzULQPOGHCTXViUz+7Zh4MbJkXqYPj5nXYSdCi2BEJBIKUPjhUipECW4bZvQCvORTGlQM9HN0UDOGMKrV65doijp8HccaYj/BznxhZHAPAsDZWm25dGxx403I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755027; c=relaxed/simple;
	bh=Wp7I+WJEXQro1T1vaqb0a2EcFW3Ob8v7DjHO+Wlw9UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcH0boVH/mFLs2MYF0hEW+SsV6ITdtRqc/DR9uo9uGm7FP5Vak/nxhYo+gRLhaeqDACHoKCxXCbMypbno6sfXA6mwnsFOkImeV2d8BxanTLs7Nxe15L7TzH7gRYfJaCVGfkoDAtiQ3P+5XI1obIpzF/0jGrGJPmHxGImOm00gLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5WXVH4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039C2C4CEED;
	Thu, 21 Aug 2025 05:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755755025;
	bh=Wp7I+WJEXQro1T1vaqb0a2EcFW3Ob8v7DjHO+Wlw9UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5WXVH4E4xGegsERez0gsqzU5rqIayhns1AWpNjI/Xnt4p2EBLk+Xur9KeQ1RumrS
	 N7mGDEfOX/1aPNmz2weXWJJQKbAfIbZTC6kcDHs5Yfgv9+LtwF7U4Zv5Q98xocjRjU
	 FupBzrI1Ob/51kGKvudssay5daZwbNdrD0ng73G8oApHG+Y3Ye1wPdgowAWCR0knKQ
	 3HmT2FlocjoVyUyv5kVvbsXxN1heZDLm1SNUUt+dlgbZ18/8S7gsPEkQNwfKy6zzrL
	 jgyIcLv+0ESP23BBo4Yu/nyH7UvoHf/x8UlEMSh3bw6EPQ4OHMEQd1XO1fb64UsFCx
	 +NhctmiG9Q/TA==
Date: Thu, 21 Aug 2025 07:40:36 +0200
From: Nicolas Schier <nsc@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v3 8/8] initramfs_test: add filename padding test case
Message-ID: <aKaxVPGMRX7ywI5L@levanger>
References: <20250819032607.28727-9-ddiss@suse.de>
 <202508200304.wF1u78il-lkp@intel.com>
 <20250820111334.51e91938.ddiss@suse.de>
 <aKY36YpNQTnd1d7Y@levanger>
 <20250821150426.40f14b7f.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kv6GRpoejpiXQgac"
Content-Disposition: inline
In-Reply-To: <20250821150426.40f14b7f.ddiss@suse.de>


--Kv6GRpoejpiXQgac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 03:04:26PM +1000, David Disseldorp wrote:
> On Wed, 20 Aug 2025 23:02:33 +0200, Nicolas Schier wrote:
>=20
> > > >  > 415			.filesize =3D 0,   =20
> > > ... =20
> > > >    425			.filesize =3D sizeof(fdata),
> > > >    426		} }; =20
> > >=20
> > > Thanks. I can send a v4 patchset to address this, or otherwise happy =
to
> > > have line 415 removed by a maintainer when merged. =20
> >=20
> > With that change:
> >=20
> > Acked-by: Nicolas Schier <nsc@kernel.org>
>=20
> Thanks Nicolas!
> Do you have any suggestions regarding how this patchset should proceed -
> would git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git
> kbuild-next be suitable as a pre-merge-window staging area?

yes, Nathan agreed to pick it up for kbuild-next.

Kind regards,
Nicolas

--Kv6GRpoejpiXQgac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmimsUkACgkQB1IKcBYm
Emn/IQ/+P+a+p7M0Ns20jJUitDgWVvbYO4R8Q5fJwFtXczz4wJl2Fcp/J4WjRP2y
GK3HZurpArA98cQIt8TcStCN+wHZUy7mZ2HsGhaOP/o1H6lifHV8vkm29p1Z2Va9
CAOyLIwP29Gltzmg+RY7iI/FUaeni3+hA3zfMF2653tRLk7shdciwCBBs8xvLRhQ
6SZTjXEblKMNSpKkLdw5tpm2o7o2+XduGubKWDLfNsLgFfcN/c2r2c7tKsRlpR9o
MoAwt2wvFfyPMpdvfwHIgmwxjSa3QzntJ7D4gLB6Sa+bIevuikVmj0KtZmG8LCWm
YvP/BilEaCfmIZK9eNwuLAto2w8sz1HDyD0+8gWaYv5uULnL6XnDQihM3KUWfVLP
LDtWMGF7THd+Xjlax5cw/ulZOOhNWYFxu3GLVaLLCNa3YGBL6xMn4HoDZ2G0X6Oa
aWagT4BOJSkeGjAV2W25b3A+AV2fdFyTeVZnBTURPwzfZDOJSt0W/Qqadk4DyeDE
8YftgcGkOijuUN/yGCNSaF19DQ4cWsnLvIiCVFnUQG9S3P9fRnLiLJ9lmrmjRbqq
3GiEnhPQtFHufN20kCrTjQoovEnvIunxeTTuEpfXk+aCXMAS8Ffcohba2HG8A197
J9mxSiVlxUU1qt2kTMI0TPp7zOsFBycNyIIFe+skN6NLGR0L6b0=
=8UJn
-----END PGP SIGNATURE-----

--Kv6GRpoejpiXQgac--

