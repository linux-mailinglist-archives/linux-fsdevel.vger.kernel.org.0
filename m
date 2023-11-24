Return-Path: <linux-fsdevel+bounces-3747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6810C7F7A13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1031C20E87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE7535F19;
	Fri, 24 Nov 2023 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9f27DY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA12E859;
	Fri, 24 Nov 2023 17:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C576C433C7;
	Fri, 24 Nov 2023 17:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700845662;
	bh=k4mQRY9ktaiTbFxSEI3izt0tLlfHV8eElmgj1GxHaeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9f27DY70LWRjTMC4/+Jq1zqen2o4HE0Nsq0MrYwBkrHt1wG5KGjhX74edhy7OzdK
	 qYdrvjuiMLxKIbTy0QcdqXK5dywo9ktO32i+XnMeFLgaBBL7MieIbSah2r6YcD7KFs
	 qxzqr0SO4gkcF/6bWCDuZ8RSQMRlYzAzXdCXuB2eyB+RhzeiKF+INCpeuxncEr2dIf
	 gDuGxoJaYjkZUP2DUzyQF/toz4cPpxqztYlD5K2Yi2cj9XmMfESb5ga1xIXrR/Clia
	 nOJhcaSOlQm/4y8wCt9VqzTBpGcdDhG2pwujSF1tU5O8Ei134NqPYtd1ek/hz/kf/B
	 eBCktCiE2EMaw==
Date: Fri, 24 Nov 2023 17:07:39 +0000
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
Subject: Re: [PATCH v3 25/25] KVM: selftests: get-reg-list: add Permission
 Overlay registers
Message-ID: <ZWDYW0cjtCsauIrz@finisterre.sirena.org.uk>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-26-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V+yoxhtAjNavAuxz"
Content-Disposition: inline
In-Reply-To: <20231124163510.1835740-26-joey.gouly@arm.com>
X-Cookie: Slow day.  Practice crawling.


--V+yoxhtAjNavAuxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2023 at 04:35:10PM +0000, Joey Gouly wrote:
> Add new system registers:
>   - POR_EL1
>   - POR_EL0

Reviewed-by: Mark Brown <broonie@kernel.org>

--V+yoxhtAjNavAuxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVg2FsACgkQJNaLcl1U
h9Du4wf/QbEyJScocmjBLoL9Na4wwhu5ptS65iVSJ8NUJUmw3SjqBoyz9NXAm6qe
8K49B58fJYJlKIhsuulwIkJPnIAOxyk1P2f4LdZYHRIYdqi4DRN44X8kzIGmCycP
VW3gToofxJltX5VIfvKLXt7+cOE87DyJQvxNg7hJPo+WOzmuuKcoHq3Vg2osXt9b
Ii7Cs0GiYekE77k8bhsxKOkMqeqhfM/e+NTFo82cRBQiAY1J56Ct/hL2+KOihG8Z
pLhfr61mJ9+2JNEBwQhVI3LNKuOaGE24hzphsvWAKKL+kS8UyiySze1uXe9n6go2
L+ttmthGaqt/5/FEs2MEwlEA/GQh+w==
=FDjs
-----END PGP SIGNATURE-----

--V+yoxhtAjNavAuxz--

