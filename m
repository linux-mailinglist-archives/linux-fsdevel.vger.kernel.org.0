Return-Path: <linux-fsdevel+bounces-1572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06787DC045
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DE9281649
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 19:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6C61A263;
	Mon, 30 Oct 2023 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMcPl2U2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798D1865E;
	Mon, 30 Oct 2023 19:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E832BC433CA;
	Mon, 30 Oct 2023 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698693555;
	bh=b1P+xGBpXuHH3zJSQqiq0GgsyhDNe6leXkljzpeIAlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMcPl2U2tgJLpyMgeBDjJgWP4k8GBaiWI0DNxHn13xzQCNz8CuKgNWw4vMQ74ckUf
	 LeWC7Bl+PDJtOCaFWAu00YPCcO6F9GrFmtuD5yb59HS/K5gcoNK5AjG2BsDTsUstj1
	 yW4X628WVmSnwyRcsxJ3MXAeyBP3EV4cGnphf4dgiLNJ77M5Uwt6yOXM1r0NtM91hD
	 8ih6Ijket7ATjUCMAkq734NINSF+vuNsbKWY58vgmnKg5jUMQNu2leX6zJaB2N0Vqg
	 QCm79p7Hu9tN1D1pE9qsMZwq1mUDo6lJHQAosVFzc4F7DT97p76frMkD9oi9T2ozOh
	 8U4ovhQfMX19w==
Date: Mon, 30 Oct 2023 19:19:08 +0000
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
Subject: Re: [PATCH v2 22/24] kselftest/arm64: parse POE_MAGIC in a signal
 frame
Message-ID: <09c186f6-67b0-45e6-a214-86c3d42f7468@sirena.org.uk>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
 <20231027180850.1068089-23-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MDH1g474pEp7uJzA"
Content-Disposition: inline
In-Reply-To: <20231027180850.1068089-23-joey.gouly@arm.com>
X-Cookie: Boy!  Eucalyptus!


--MDH1g474pEp7uJzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 07:08:48PM +0100, Joey Gouly wrote:
> Teach the signal frame parsing about the new POE frame, avoids warning when it
> is generated.

Reviewed-by: Mark Brown <broonie@kernel.org>

--MDH1g474pEp7uJzA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVAAawACgkQJNaLcl1U
h9ByXwf/Qipq20s1AGWakFhuHaAODSH+x5GvEWnhqnyGEXYH5CeuHmz42KglMcTH
klBUtq4GsO6pZtfcH26l2oa7M8Vwlqjb1yJlCQCXUr0rss56yeMy5VEc7sP1ncIZ
258KJFkULSFuke6H28g0I2cq9VFBfeXCZQl4z5mwqiUGMfw/os/GBuL/wv94g9Pv
Uy/0GOfecHn3qcZmu18++tocMCmsQIQgn1lKlzjLHDs96JxhUwoiYGD4ljPVt45e
M/TppJ9+pjUHrrPRbV6xh+QwrOnggYtvDfqxKAhTTdHhrbHf/tcf15tvSzBT/kW9
N9tA70bWLOcUApWqgMvnv0IzuxInRg==
=83hu
-----END PGP SIGNATURE-----

--MDH1g474pEp7uJzA--

