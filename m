Return-Path: <linux-fsdevel+bounces-3749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0A57F7A24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7851281720
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80493364B1;
	Fri, 24 Nov 2023 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cekIu3Px"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64232D787;
	Fri, 24 Nov 2023 17:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52C0C433C7;
	Fri, 24 Nov 2023 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700846168;
	bh=/haiSAT5M/9mgny5Bgw0OmBZUFXuDa30Ns4h8PlXCg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cekIu3PxBZAfCxSQrqXkd2K6+BafRjSDVRkMPzHcchLFliVfQwdLZ+F22vQcjNhV0
	 cn+20Tu3ADPzdvPCd1WWLVhAhSwK7bXV/JT5+TgxdsTQAk7DGdvWLSBEVbrpsIsU6p
	 dLLYkx+xvaSr83KKxQx9c4I1V3OAEuXJ4SamKSe1xd5ZkG18YWb3SMyIIoIpO9E6uW
	 4mEwnvE/eZ/AoqizeU04qaj0+50XyW54Yhegtk1boGdnVhAYCGHs2zTsCFPiE0084Q
	 A8CctZ49HlJsDe7WB0FhIlro8+f4SDslgf7vfvSnOeXwRlG41ODUR3U9GevjdgLqFV
	 Tuix+eeljrz0A==
Date: Fri, 24 Nov 2023 17:16:05 +0000
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
Subject: Re: [PATCH v3 19/25] kselftest/arm64: move get_header()
Message-ID: <ZWDaVZec1VkMGIOn@finisterre.sirena.org.uk>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-20-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NwUACMYn7wUsX8LP"
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-20-joey.gouly@arm.com>
X-Cookie: Slow day.  Practice crawling.


--NwUACMYn7wUsX8LP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2023 at 04:35:04PM +0000, Joey Gouly wrote:
> Put this function in the header so that it can be used by other tests, without
> needing to link to testcases.c.

It would've been good to explain a bit more of the context here but

Reviewed-by: Mark Brown <broonie@kernel.org>

--NwUACMYn7wUsX8LP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVg2lQACgkQJNaLcl1U
h9BFQwf9FT1sWuszIxMwfuTQ24zmcCPHWMYZBNChucruZbaD0pGFcmy+KXlwh11r
XLTTWMvXlJt9PfLUrxQETK8uwQydTwYtoJpfeUVZj1OHsujYaDtLl6um5KnPN7sS
n483rh3jdFtm0lviuhlZlOx/flRX0ZzsA9TcY5RC8/13Au8YVwfuGZ4VDeDEUkiD
lUUoYJg34CFGtQfA/yYwfaCFuOgz/jOcxRZl6+k7naYavRA0ojxRZ2bo438eWT8I
A+E8iyaNDPIqDkKKeVhY8zjiGj8zj6Zzp4mdyOElkkzUTjaIrXOY0zynTzQoNyDN
0gMLqEAQKV/02I3gmC17KUmQ/3dJWQ==
=NaLT
-----END PGP SIGNATURE-----

--NwUACMYn7wUsX8LP--

