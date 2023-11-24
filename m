Return-Path: <linux-fsdevel+bounces-3745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF857F7A07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283E7B20B7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152EA33063;
	Fri, 24 Nov 2023 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgk/0foz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F32D61F;
	Fri, 24 Nov 2023 17:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F846C433C8;
	Fri, 24 Nov 2023 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700845470;
	bh=GXt96s5il2u/P9SLTNelXJ6lsqLGbKZhXhMZs+TD4NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dgk/0fozNtbyIfkGYRDbJFt01zKJRS5kw/wCE5hBBOLoOMjIE89zpG2lJvHMQCu35
	 kxYM1BjBgJjtDy9mTBcmY6V4i93k58fDa4tLyZrE4AhwtNZmKtQP/JuEW8NrZwFpNF
	 f8e2bXyD4dyCaxlc/TTgNWBTdzeyjV71TRMgGDPY6V6ZfmJG2gYyW8UBCnVtsYt2/B
	 b030M13IOHavs13aFF9L/zTd6hxJeAYCsMwmPjLJCuEynhbEKBl+YiQy8+R7/Qio97
	 y04Z3WJZKAZGDzqDB8njOaAzq1apUz1S8FR6LzABvDSIVYn4H2HqxOuPCczAAOqPNu
	 pmeJss9a6Gamg==
Date: Fri, 24 Nov 2023 17:04:27 +0000
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
Subject: Re: [PATCH v3 24/25] kselftest/arm64: Add test case for POR_EL0
 signal frame records
Message-ID: <ZWDXm7FM2DTjPpkP@finisterre.sirena.org.uk>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-25-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="44RVQTTbBU8xqQ2i"
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-25-joey.gouly@arm.com>
X-Cookie: Slow day.  Practice crawling.


--44RVQTTbBU8xqQ2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2023 at 04:35:09PM +0000, Joey Gouly wrote:

> +++ b/tools/testing/selftests/arm64/signal/.gitignore
> @@ -5,6 +5,7 @@ sme_*
>  ssve_*
>  sve_*
>  tpidr2_*
> +poe_siginfo
>  za_*
>  zt_*
>  !*.[ch]

Please keep this sorted, otherwise

Reviewed-by: Mark Brown <broonie@kernel.org>

--44RVQTTbBU8xqQ2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVg15sACgkQJNaLcl1U
h9Ad2wf/arLABO85+JXaO0h5UHm1Jiq6wXE11hvBlZ1522Yb3TX6Uv874rkDuVO1
EGr7WGWupfHIOShcb1s2tisuP707lwhY1bfPWEENdo4EipGhzgILmjQfRdKVShA5
NM9LSnJnqdzqyKlHWNZUty7QiOrL+QJrFHeFFpAnUo1PC6vscqquaOnXoRwXNeK2
Bfa8RaSAn0dYfvY6VoBTnO1aAh1R8nUeRbia3Ot6moRx4sJBxKfqfzKuwe1ScAUj
IhcPqHMbjY/8dTiOok+7HCbgEnrXEA3pwP9OLppmSKYvlwOYNh85gNCVIPt8DSaG
08iEgSgGlrSuviX/iOsz45OUelKd7w==
=on9u
-----END PGP SIGNATURE-----

--44RVQTTbBU8xqQ2i--

