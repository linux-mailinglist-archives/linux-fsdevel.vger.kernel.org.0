Return-Path: <linux-fsdevel+bounces-5737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE3380F695
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E791C20E31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BBC81E4F;
	Tue, 12 Dec 2023 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfP7DhS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AF81E36;
	Tue, 12 Dec 2023 19:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED42C433C7;
	Tue, 12 Dec 2023 19:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702409007;
	bh=XugEc5jga7y4PNlRm8BjKTZfUw+pu3ZxkmQIpRIWEZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfP7DhS6GQRIPh94PCnUY3D3v9HTUhNBLMgvDIKCSEyZWm7on3QEnlPSEsrB8VAly
	 VxMqSbIZ3bDXLEwsbe1kcsiYY+66gJUk3MPujLh2TLd7piiYzNgT8/mby6PZXl45hv
	 sWza2pUfxy/BGubgyV4ylzDtq0PT2Kjxb2j3/tZYOAyFsmOn3MVP+RVMO0+OJ63ELh
	 8RieySJS8ocPfrZvxa9x9m8fK3pWdefGd7urdXdt3BI/iUUyl4yaoAxKMVxifEh29R
	 ScXKjFti5r284zeeNNlTXHDNkVr0M/tfj7cm/QDJyTpxq4jSK3MjR/isfYySuemepR
	 TnR15vPgid9eA==
Date: Tue, 12 Dec 2023 19:22:24 +0000
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
Subject: Re: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
Message-ID: <d708b493-267a-4418-be91-9bde6b2cf50c@sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
 <CAKC1njSC5cC_fXnyNAPt=WU6cD-OjLKFxo90oVPmsLJbuWf4nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sqzR9iJQv0rAi7An"
Content-Disposition: inline
In-Reply-To: <CAKC1njSC5cC_fXnyNAPt=WU6cD-OjLKFxo90oVPmsLJbuWf4nw@mail.gmail.com>
X-Cookie: If rash develops, discontinue use.


--sqzR9iJQv0rAi7An
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:17:11AM -0800, Deepak Gupta wrote:
> On Wed, Nov 22, 2023 at 1:43=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > +/*
> > + * Set the current shadow stack configuration.  Enabling the shadow
> > + * stack will cause a shadow stack to be allocated for the thread.
> > + */
> > +#define PR_SET_SHADOW_STACK_STATUS      72
> > +# define PR_SHADOW_STACK_ENABLE         (1UL << 0)

> Other architecture may require disabling shadow stack if glibc
> tunables is set to permissive mode.
> In permissive mode, if glibc encounters `dlopen` on an object which
> doesn't support shadow stack,
> glibc should be able to issue PR_SHADOW_STACK_DISABLE.

> Architectures can choose to implement or not but I think arch agnostic
> code should enumerate this.

The current implementation for arm64 and therefore API for the prctl()
is that whatever combination of flags is specified will be set, this
means that setting the status to something that does not include _ENABLE
will result in disabling and we don't need a separate flag for disable.
We have use cases that make active use of disabling at runtime.

Please delete unneeded context from replies, it makes it much easier to
find new content.

--sqzR9iJQv0rAi7An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV4svAACgkQJNaLcl1U
h9Btqwf/bsYteQozf7cPtwIIhQRSI8MqfxjmscBVibOnKEFjdEqlRLo5JjkO6Pr6
Hsm1uhj0HkH+VoTgU/3/1losf+mnWyaEoeE90IUq5vBweWShWNPKbMowY1s1JyJT
eJ8Jv5z8xL0Zd92fTtAv0/Gl/nzqAWu3nWwc0eQH9GFutxYJ/RQceRg37XE/DJ7Z
odJHFuONGqU0YzuzvzYXPwCScKSOq3ym2wrT5xOjARR2ltJqsKxN2gVDflKZzP62
UImi4UsGqWZ2QvQb/fIh6ch/i9mPYGPi81vtynCHbAn91TWcPAvgOCA1Sywzc2p0
32BmmvfZZxpi8FaPWip8qJ7NDQKaeA==
=sM8B
-----END PGP SIGNATURE-----

--sqzR9iJQv0rAi7An--

