Return-Path: <linux-fsdevel+bounces-5409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA4F80B488
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 14:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096042810DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6569A14F63;
	Sat,  9 Dec 2023 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6jE7XNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA313AE3;
	Sat,  9 Dec 2023 13:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783C1C433C8;
	Sat,  9 Dec 2023 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702127389;
	bh=BXmvRrbuQ7Zo9bps7+7CLsTiu05XaN6dU9PEwdxs+ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6jE7XNTUdBp/jI1nNZw36YjJLxRXIwjeEtof8D9IiRzLKGfNItYmAr+VT2iAQ38c
	 38YNmmUUIYntBWbwZ9cGSSxaGQim7h9NbXYE8xNDouYR8+TMgLcesHT+cipBw2tgX/
	 4lThPROQalN7MagIZParOBO4e1O2Pg4g6V0ixyjV2R33hTQ+sgi2mNYzJWJbwJzmJw
	 rUnZe+RUTAfAHW4aOwHkof8lj7+6t1uk4lf7Y6WTHOwc+fOGo2/av3fMhf6zCZfn9v
	 KMPF5McGv4f6VX8d9RocfRsJKSW7FslB0ZP2s+OE7BGvUVe1zwkJUq28+7u8No8Z/8
	 zs4EO1JDtaj9w==
Date: Sat, 9 Dec 2023 13:09:45 +0000
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
Subject: Re: [PATCH v7 24/39] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <ZXRnGbYI+uq7m9sA@finisterre.sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-24-201c483bd775@kernel.org>
 <8734wcgj79.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37w+xraunaVzWRvI"
Content-Disposition: inline
In-Reply-To: <8734wcgj79.fsf@linaro.org>
X-Cookie: You might have mail.


--37w+xraunaVzWRvI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 09, 2023 at 12:15:22AM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> > +	/* The cap must have the low bits set to a token value */
> > +	if (GCS_CAP_TOKEN(val) != 0)
> > +		return false;

> I found the comment above a little confusing, since the if condition
> actually checks that low bits aren't set at all. Perhaps reword to
> something like "The token value of a signal cap must be 0"?

Right, that's bitrot from the previous token format.

> I'm still not proficient enough in GCS to know how exactly this could be
> abused (e.g., somehow writing the desired return location right above
> one of these inactive caps and arranging for GCSPR to point to the cap
> before returning from a signal) but to be safe or paranoid, perhaps zero
> the location of the cap before returning?

Right, ideally we'd be doing a compare and exchange here to substitute
in a zero.

--37w+xraunaVzWRvI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV0ZxYACgkQJNaLcl1U
h9AoDgf/VkzebhdvDSlUlS84JXdoOeqvCdQEoqmGKLcuFu0afYS5oNsgjYoWfoXD
aoXaZBnOjvf3Wmp5hO2MtDSGOlnNYMS9btFUd+2docNaeKRynVrPd2hEwST4I/yq
ZeT2mGf5o2wyv6qxW6RsXkgz4UUscznq2pitjl0x4ca+pOIeX+qxPQjayUJhPGtL
Us1MullRxipMfAZE5H9eGQ5UrEO940lmaqa3GOexHuqAmzs/znZexqoZYXOStiBS
DTmANL89uVAgAarTtMNsXKkO8mOZ8D9pNtu+zPEO0JNSrVzQgDD363lTYbIjKz5P
QroAHMW7izjjkY7CBtP6RwOmok0Uvw==
=u7l1
-----END PGP SIGNATURE-----

--37w+xraunaVzWRvI--

