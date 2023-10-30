Return-Path: <linux-fsdevel+bounces-1571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D37DC043
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC69281653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA4A1A271;
	Mon, 30 Oct 2023 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvOUhs5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1519BCC;
	Mon, 30 Oct 2023 19:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1171EC433C7;
	Mon, 30 Oct 2023 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698693525;
	bh=dO3G6JDh2nnmC/bwSDOns+y1owi1vju7pdeFjUIx3EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvOUhs5FijnVE8ErysBczECrWZcgEn+hk7JvmEb/KgOSxXGlKXWOKBuk0yS7t4mmL
	 qOJuIhpafKyh5ZC4uT7r42nrmOyW1BhhVnvmdMQ/AkjlszLFIPQwVVJ2rZAGqf4n16
	 xAIfjPQcnTqZr+EySlYMPyIZk3tA26yIPUqutRepbJuk3cSyYveCPVCwNogv5ewlEt
	 TPP8MZavzIt5ZVxu0n6hEZeoaMmZpF1bpN7zeuvkOOLlKlpyVQ0j4RIBR9kG4OlGpq
	 rmrSIk1dUxnsPOoHTAlObp7pM/Ihe2IHjpcZxBhTcQ8HnmsxkIcyb0gnwAaYsKLNt9
	 h/g2o+rbNrMGg==
Date: Mon, 30 Oct 2023 19:18:38 +0000
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
Subject: Re: [PATCH v2 21/24] kselftest/arm64: add HWCAP test for FEAT_S1POE
Message-ID: <1caa89d5-2184-4ab8-9620-8a1c0d7850d3@sirena.org.uk>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
 <20231027180850.1068089-22-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zujnxR0fWdTbL20W"
Content-Disposition: inline
In-Reply-To: <20231027180850.1068089-22-joey.gouly@arm.com>
X-Cookie: Boy!  Eucalyptus!


--zujnxR0fWdTbL20W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 07:08:47PM +0100, Joey Gouly wrote:

> +	{
> +		.name = "POE",
> +		.at_hwcap = AT_HWCAP2,
> +		.hwcap_bit = HWCAP2_POE,
> +		.cpuinfo = "poe",
> +		.sigill_fn = poe_sigill,
> +	},

We should set sigill_reliable here - there's a trap for the POR_EL0 so
the test must fail if the hwcap isn't available.

--zujnxR0fWdTbL20W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVAAY0ACgkQJNaLcl1U
h9CfbAf+Id1VyCAQbxj0V499TJRAchoHYN7/dcWVEyuEUBg5+cAG9dBPQLOf0tOE
4DsEW4Kufll5OrCboNdRqdg1KRK3wpwugd8LkpyLUn6sEs/alUjrc7sICqeBLtNm
caCUgd0p3qIKUxQzmg/fKn3p5lZX9smYdW9RCRwKnkZYw3JSbE1b24iSVdk5vXI8
SqFKjZkm/+96KUx76M3roMtFgQ7i8vE/jhBHojc3lvU7qdTz9U2Usj6/h+Hrf87W
TVMoZGauHJLc2sgLV5aIjEe5lDYolpKa+27WFUJ6HWEzVIihVZGPh59Z6XbLNRXu
Md+2s0TjPvf0tGF58mlHrF7e0OZSBA==
=l9mT
-----END PGP SIGNATURE-----

--zujnxR0fWdTbL20W--

