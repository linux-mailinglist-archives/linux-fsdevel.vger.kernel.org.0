Return-Path: <linux-fsdevel+bounces-6002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BDC811FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 21:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2221F217C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 20:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B16828A;
	Wed, 13 Dec 2023 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw52Vfty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCC7D8B0;
	Wed, 13 Dec 2023 20:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1AFC433C8;
	Wed, 13 Dec 2023 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702497753;
	bh=TWKx/EtzYbtKFgsobV53zPra9sAQTzvSeeX3jZwDlRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rw52VftygnvuTCgOrGI+gXe3TWpHtVdnfgBKILZHSSoQQfWcj4FiDZBF3q0xg/p1U
	 yMyKDh7CfJhMPcfzgFLat+8qbBLeFz+kC6B1tBll2xoDe6ZR+lL4atc7TiTHTaVBXM
	 KlV6aWd7XISTwMfEZMAy3uUu9bt6AO01rkUbbhpNndDZiRNqiRth1R5905LQyKnKba
	 /Gu969kcPjCpd8VYSh4acTvsQvcFLrQg/odEGgysmo+09v0y9yHqoazxNAXt1jERrU
	 3PEg1LuMx6NGBxtg6PTj1VO7B1PTnSanvAI6Vm8xADmZDlQepBudQj+aTfcAbjr2x0
	 iLnlO4srSoqvg==
Date: Wed, 13 Dec 2023 20:02:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 20/39] arm64/gcs: Context switch GCS state for EL0
Message-ID: <b2a717a7-e6d3-4fa9-921e-156c17ad5424@sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-20-201c483bd775@kernel.org>
 <CAKC1njQVB71A8fQBLmBnx++agM12XDLhS=7iL7-A4NTXSqUM+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p5BMo6xEVagOzbFU"
Content-Disposition: inline
In-Reply-To: <CAKC1njQVB71A8fQBLmBnx++agM12XDLhS=7iL7-A4NTXSqUM+A@mail.gmail.com>
X-Cookie: One size fits all.


--p5BMo6xEVagOzbFU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:59:45AM -0800, Deepak Gupta wrote:
> On Wed, Nov 22, 2023 at 1:45=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > +       if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE)
> > +               gcscre0_el1 |=3D GCSCRE0_EL1_RVCHKEN | GCSCRE0_EL1_PCRS=
EL;

> If the intent is to disable, is the GCS stack freed or kept around?
> I expect if libc is taking the decision to disable, kernel should free it=
 up.
> Is it freed in some other flow?

Kept around and freed on thread exit.  There is a potential race between
for example disabling in a signal handler and something trying to walk
the stack so we err on the side of caution.

--p5BMo6xEVagOzbFU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV6Dc8ACgkQJNaLcl1U
h9D/UQf/drLKsAxcIavasAKyvNxy00BF9vIZyHv3vJ+sFZEMcKnnX/8KO6A54p3z
Y5Oowl7starF/ef/S94c9GDD6e9ErIIZiUHOIWoegLpSIr9NL3p3q2pzJTSgEigR
7gxmR840FSDV235o0T16ajXu4aj3hg3eSiDmycP9Wh2TY6lNU+Uab1nhCM6mIgzY
Spu0s0+naKP+fYEkXZjhn15XHplZNEI2qLOIXhEpNJZHiEt1imkFwLa5GqHbaWUz
wqtAF1RUqcDm5hATvxuPbnPA0WsnHFGCniy5C7vyRNlcPGx+FBg2pW0O9Y47ff2a
Vt+12qPfZq/CDUunfX/IvKyQ3YO5+Q==
=JGbe
-----END PGP SIGNATURE-----

--p5BMo6xEVagOzbFU--

