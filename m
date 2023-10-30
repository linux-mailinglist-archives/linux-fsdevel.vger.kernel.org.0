Return-Path: <linux-fsdevel+bounces-1570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E737DC03D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD772814DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C25319BD7;
	Mon, 30 Oct 2023 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt9PLGMx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77219BB4;
	Mon, 30 Oct 2023 19:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94E7C433C8;
	Mon, 30 Oct 2023 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698693057;
	bh=KoOCHQAjFgfhCtHKU5iB/qvkULgq8jiAh0QPWcviyJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rt9PLGMxMiNeMvQuWY/REGAiYQI8uSpe+BFgkQ4cAp/XNu3drRsFEvlEP2nGgEUyZ
	 5WXumKxWr4zQhAqGoF/x+pBrYB0Bw6h3O238/FLCx9B+TC83vGKF7J8MmnGV3Bd/Ad
	 C+zuHa0hMfeU/+2SlhuL11B03JUTKTNbbZGBdc58BElgaRScHjyN2O1A6EKNDyTdbM
	 W94xUR/hkLSyBSVhY+tlMSJyrEWPiz0H8YldwO+2umIol82SaezAUW0UXkEYKPkGCW
	 9griGAf/Tk2TgnzGrH50fYwR4ImPvISIxcUEJFXxdtGrkivuCeQE5pQkWc6g4lIyNp
	 q42GGZjfbF6tQ==
Date: Mon, 30 Oct 2023 19:10:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 15/24] arm64: add POE signal support
Message-ID: <8acd26aa-3540-4c61-92a0-204e192b0dd9@sirena.org.uk>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
 <20231027180850.1068089-16-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1dHpaKcSMcWaIVGq"
Content-Disposition: inline
In-Reply-To: <20231027180850.1068089-16-joey.gouly@arm.com>
X-Cookie: Boy!  Eucalyptus!


--1dHpaKcSMcWaIVGq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 07:08:41PM +0100, Joey Gouly wrote:
> Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.

Reviewed-by: Mark Brown <broonie@kernel.org>

--1dHpaKcSMcWaIVGq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU//7kACgkQJNaLcl1U
h9ASwwf+LYFr9QCDZnpYvk44kXrB+JihFI/WAA9hX73ca9st4227TV7ArGlQjpW4
zijhnCpKPbInaWxj76wkLAdftK18v2B92otNltb/6O0vyuYMFOsGNzTrCvaj+dai
AH7j0xqeNC2CdgDuQ8aWOfz1PcWDrCjvvVKDtBy+99oO9kTgjhH+O26w79wvhd1J
DaeQziZByOJmFKRKFK02OgTndu3aH06X9u+vWr0ekjn5ef55/esbknXYXFO7LR8C
NJhg8XH38Rt+/Rwt83Dx8h5l4TeK4m6xUFCOrXeaviupjyThJTnkPYXIwWSXeXPP
Sesyhuo23630omaijTOSvs51Hto56Q==
=5NE8
-----END PGP SIGNATURE-----

--1dHpaKcSMcWaIVGq--

