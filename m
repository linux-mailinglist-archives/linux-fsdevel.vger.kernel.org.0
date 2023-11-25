Return-Path: <linux-fsdevel+bounces-3802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447477F8A9A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7562C1C20C4F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AF2F9FA;
	Sat, 25 Nov 2023 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi0kCUmS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129CF9D2;
	Sat, 25 Nov 2023 12:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC66C433C8;
	Sat, 25 Nov 2023 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700914297;
	bh=UCZIOpIvim8Wuoual1/Y21llfG2g3HGz1cM7TVnPnsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mi0kCUmS0pH8Z1vZt6bQqYCGrWOfafij0TD70ubXjH9iBNK88KbKpiPtXX1V7AU7T
	 NiYh/qb8zEX5QSl7qUvhbohTiW2U25CqNWcDQmIjMjuddqQuX7RzDBx5o8WOh0qAxm
	 FLuAXsTx1xlSol8wSBdVsUm/yl7l8e1XNDIIom04jepEbh6bJnfND27f305hK+gfzD
	 Exwzm646vHLcmidye2upQ1dFE5eWpRlgkuEWvLv1HE0AsQDmjYPARdQt3H7cVzX0X5
	 BNopEgtW2x2e8bEa089TEoSsPr4yFieBdSOyTtVkCnKDbOFIWbiwsNV83bEABv/lB/
	 hg4LiJAkOGCOQ==
Date: Sat, 25 Nov 2023 12:11:33 +0000
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
Subject: Re: [PATCH v3 03/25] arm64: cpufeature: add Permission Overlay
 Extension cpucap
Message-ID: <ZWHkdWViv7WpCQm2@finisterre.sirena.org.uk>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-4-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3wbj0ASBS7bOhMDl"
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-4-joey.gouly@arm.com>
X-Cookie: Slow day.  Practice crawling.


--3wbj0ASBS7bOhMDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 04:34:48PM +0000, Joey Gouly wrote:
> This indicates if the system supports POE. This is a CPUCAP_BOOT_CPU_FEAT=
URE
> as the boot CPU will enable POE if it has it, so secondary CPUs must also
> have this feature.
>=20
> Add a new config option: ARM64_POE

For bisection purposes if nothing else I'd expect to see the Kconfig
option added after everything else is in place so that we don't build a
kernel image which has partial POE support available and confuse things,
with no way to enable the config option earlier patches which just build
the !POE case until everything is ready.

--3wbj0ASBS7bOhMDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVh5HQACgkQJNaLcl1U
h9Bz0Qf9EFhTe+LLlrJ0jw8+wZY2dAkmLfFdaQATu6Rwd6WP6JeP+SYmqzki7NDD
fPm7u0c9RbkbmZrGPIZyVKoxL/kOrSFCAVRChyjTuKXmsV4/0RQrxcqaH1dOb5GY
uJ5LIu3b0zbGzVkOnuFwwtSS+j4b5+piUGf/z7Zv2biHYAZUr/uvAFsR7Gxv9Wba
58y8+TAS4we+XLNa46H1QiwJfxWYrUcJlK1JScy0vqITHONkSacBMF2+/bfv8CX+
u1gS5LEqlMzQwa3lY5NaRQwsatzGcIgogieCX7liGGJ/aTHxJfSqyVCZoEugcnDk
BcmCUeqh+vrJ6qF6pe1Z7SZ3/NkRYA==
=EbW+
-----END PGP SIGNATURE-----

--3wbj0ASBS7bOhMDl--

