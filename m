Return-Path: <linux-fsdevel+bounces-3743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE97F79FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89D51C20F6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D943B2E831;
	Fri, 24 Nov 2023 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3OadON0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368C364A4;
	Fri, 24 Nov 2023 17:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6680C433C8;
	Fri, 24 Nov 2023 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700845373;
	bh=spAQEHLnkWTw0So+tleUMpl17On0BgAWnZncp1uMdDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3OadON014nWHsSs5rlBRKuXRvvJGgy+8YNd/bysrt6RcyglTmsjpcSpYDHApHyyN
	 gHbfKDRKprR98OGshDHJLUAh/Xe0U3Ky2XKLAnBtAtj8arR9rm+x51hTept0N7XuNm
	 hTW/7442ToWXrTiLKfurDJCvfm4x1/REhoCI2Nc2Gi0wp2zNVIYEQ6wD7Qs/WAtb32
	 dZrKdzwyXLX1Vb5ZDlClv0LypdPMp6xzwu1fB+m2vyM1pU6167qMe5MOCTLa+kC4TY
	 yCL2BVOnVw3bXsaviPOKI6XBn1ajDe0yhCYa69TsbAwFf1XL83PUc0WPKsxSyfN73e
	 zfqQAOnpOTWOQ==
Date: Fri, 24 Nov 2023 17:02:50 +0000
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
Subject: Re: [PATCH v3 22/25] kselftest/arm64: add HWCAP test for FEAT_S1POE
Message-ID: <ZWDXOt/aw73DWAmN@finisterre.sirena.org.uk>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-23-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cy6DkPtJZtCWNOXe"
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-23-joey.gouly@arm.com>
X-Cookie: Slow day.  Practice crawling.


--Cy6DkPtJZtCWNOXe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2023 at 04:35:07PM +0000, Joey Gouly wrote:
> Check that when POE is enabled, the POR_EL0 register is accessible.

Reviewed-by: Mark Brown <broonie@kernel.org>

--Cy6DkPtJZtCWNOXe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVg1zkACgkQJNaLcl1U
h9DF+Qf+McRE5ZenovytNZGzGU8V8IA6TSVcpZqxQ3RA5hJ+YJrVA3LQk7CD5tHD
zB2hHviuiPzojikWvl+ePw3fTZKb2EvJA71mTNhXr3X8MaHj01lIP4JIbcvKNBy2
gkAzwct73nwr//NpZxtBHgLh0gdNKWj6vKnVzB9gNZVfdilsvUef0YQSC/AfHW0m
YUwFr+14yRKtxhffk2Z90cw1JquBirIA+CJX9Dj76oNfhHgKThgwGCfNbgTkz+Yv
T1KD/Db4kD6cWmAxmRGFhERi88XQrGMhpwSu793LBJSBO4eL1akCb6nKG8wBkqRo
XdB6Kk2IQ2ZRPNSc/vPOdmb6ybl2dQ==
=+Tza
-----END PGP SIGNATURE-----

--Cy6DkPtJZtCWNOXe--

