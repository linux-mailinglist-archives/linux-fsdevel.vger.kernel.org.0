Return-Path: <linux-fsdevel+bounces-5435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A8480BBA0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 15:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B029280DF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 14:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A10C12F;
	Sun, 10 Dec 2023 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z46OPbu3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99267125DE;
	Sun, 10 Dec 2023 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FFDC433C7;
	Sun, 10 Dec 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702218179;
	bh=8tne0aaAREf7h+qiY6KAldko6jyI6LRXnoNCM9fma6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z46OPbu3lxs+nSXwJj7g5+uM236T8qcWVMENzV16W8PRn+wPA90J2c/MU1TR09r9G
	 V7uktPMYA+kX07nhFqGBeWzVnfPGq1sWi8TmA2O/Ypbc+HHzOKCOCc6aUZpI1E2ux5
	 i7a4xJ46nLuCB9P/YSDucazqkfc40Pwk2ruWwXth0yedV7jS/lBPvlu9h8D8FqQQ5E
	 7NrgTVM832Ck4BiiNruf7natGB4ETT1vuYgIR5796kVSPSFEDz9SqMvV2j2pOXJx2O
	 kYv2KFYNFZhj2cny4Ad3h63HQeFh23ezu4307DrPbna88E2yARpEbrhoRhlGsNFA2m
	 xH4AUl7qyB+aQ==
Date: Sun, 10 Dec 2023 14:22:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
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
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 26/39] arm64/ptrace: Expose GCS via ptrace and core
 files
Message-ID: <ZXXJwNdKC/y6bRYn@finisterre.sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-26-201c483bd775@kernel.org>
 <877clney35.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+xOPyWhFp+ttqF+R"
Content-Disposition: inline
In-Reply-To: <877clney35.fsf@linaro.org>
X-Cookie: You might have mail.


--+xOPyWhFp+ttqF+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 09, 2023 at 08:49:02PM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Provide a new register type NT_ARM_GCS reporting the current GCS mode
> > and pointer for EL0.  Due to the interactions with allocation and
> > deallocation of Guarded Control Stacks we do not permit any changes to
> > the GCS mode via ptrace, only GCSPR_EL0 may be changed.

> The code allows disabling GCS. Is that unintended?

No, it's intentional - ptrace has a lot of control over the process,
there's not a huge point trying to protect against it doing a disable.
The reason we prevent enabling is the allocation of a GCS along with
enable, the complexity of doing that on a remote process seemed
unjustified.  If clone3() ends up allowing manual allocation and
placement that'll likely be revised.

--+xOPyWhFp+ttqF+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV1yb8ACgkQJNaLcl1U
h9BWYwf/Tu6vlQCwGJ174Zum1yyKhNrP0gXrNj0hXhil/y9CwTApo4pvBUMmBwQz
JO0qoPePZDOSlxns1bELpj5O5sFq0c8qB1e29Y1nFzNClHf+uyVDswS2nZDBU6Rk
QyW/T7yJerJVj/Lw5Mh1iJMbf8+iOPyRCJ8iMOnYiCbPpOmz7FuarOxPowUXUTqe
e/bnana1ic+ctkWCw67wxEB6SJsOSaN2uW7mCj2ftjf9Cq9GmxzYnn8WuOvPHLxQ
1id5Q0hqIWUqpgKGWDeIng5VHThiIuZDUa4EWQga6fnVZnApv4pRNJY7ttyNS6SS
VfquKJpzBaa9lItRtIz5Dxs2gX1jyg==
=9ttk
-----END PGP SIGNATURE-----

--+xOPyWhFp+ttqF+R--

