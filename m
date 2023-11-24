Return-Path: <linux-fsdevel+bounces-3751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBAC7F7A42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4841C20A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A0364CF;
	Fri, 24 Nov 2023 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1N/U2tP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9E381C2;
	Fri, 24 Nov 2023 17:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7252DC433C8;
	Fri, 24 Nov 2023 17:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700846335;
	bh=sK+fQJAPK8KGeQ6taKntsMNZsWAeb8zak5ghGsDM5lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1N/U2tPK5ZqQ9g2aKRZaVClKfC2Lo/VlfQvG0vY5fsO2VzUGbHukDVXY4cFPwR4B
	 3liXQpnow5+8Lw5/KRnQnz77mRP2rHloVBBH7VrJb6lreyaqdqg+0TzinETrdEPsmP
	 DVqKuq9mPEvXN6t+M3vdDfSzK22Uxp/Do0uQsXOdwMAJLvVp/e07UoQrlH/knocrDp
	 2BXUMFMkREC8+yLkWSXHW4VrGfiRL7wzyfO45a11d1Ka+ZoFeuNjC1V+1oNe0tiQ0c
	 GkCTbdFFgcG8A8ZuPuB1CdxkpQdJUn7US8L0qtNf74cf7VECKHdPpApRWiwIZqsEgw
	 sAlfawBFqIvlA==
Date: Fri, 24 Nov 2023 17:18:51 +0000
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
Subject: Re: [PATCH v3 18/25] arm64/ptrace: add support for FEAT_POE
Message-ID: <ZWDa+x6QS1R9vFUK@finisterre.sirena.org.uk>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-19-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rm3m1hdM687sfrem"
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-19-joey.gouly@arm.com>
X-Cookie: Slow day.  Practice crawling.


--rm3m1hdM687sfrem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2023 at 04:35:03PM +0000, Joey Gouly wrote:

> Add a regset for POE containing POR_EL0.

> +++ b/include/uapi/linux/elf.h
> @@ -440,6 +440,7 @@ typedef struct elf64_shdr {
>  #define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
>  #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
>  #define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
> +#define NT_ARM_POE	0x40f		/* ARM POE registers */

Not 0x40e?

Otherwise

Reviewed-by: Mark Brown <broonie@kernel.org>

--rm3m1hdM687sfrem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVg2vsACgkQJNaLcl1U
h9B+Xwf+N61kRXNqFRQdjfMVVQTxy2Qo01O2DOnvWHr80XdShAldXRzqkh3fTEh8
e/kyurMq/O25Tu6wG69gwnEMC7skR5fPoJ+B5urwrmU70ndPjLivTK4nKHuZaBum
85flaUn4C7sO2q+dEgOcn2RiCaOryZG069zqgnkroe+JthVT9AfpoTlRjS/KBMZV
NJLZIzS3dGlw8dJxSdBr0zAYo+I5Q9P8mklK2y/Y65e1VaYSQJnCI3qCUtENp3jj
tEJMlbe4Dub/1rmLWZSTkpPEpDI2XgDzExEQE/uBLIzo2EJcJF53Ho0+WYMpjtIy
UEyDvPz5UwNeEEzVv4jQmSLLy5lNFw==
=lV7A
-----END PGP SIGNATURE-----

--rm3m1hdM687sfrem--

