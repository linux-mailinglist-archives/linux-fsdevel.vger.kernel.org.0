Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436D4784836
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjHVRFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 13:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjHVRFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012ABD7;
        Tue, 22 Aug 2023 10:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 804EF621B9;
        Tue, 22 Aug 2023 17:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C885FC433C8;
        Tue, 22 Aug 2023 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692723928;
        bh=+/XUXGpY2ACCPD3YzzrpK3JtSQqnOrDZMR5OCAEhgDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G928dxMHkk1xDk/SX1dNnL+spqkcZRuq0C5Z40fu1Tb9wObRKQhtFzT0ipOQBh80X
         M0BVrVcY8VmxczuqKrntaU8eZ0hqbR8EE1e7UAwRJz7snKD2v4GCMfQ9hgFuv0aBvc
         38dD7dDK0lef3oOPG14kshG+9z1JoNQxNiubdga4OgfcfWS0/Ve3yY/2BVaHKd3pvN
         cYaVOE7zu3UopoUb04Il5Y+Q0rXflj/XshyiU6vP1UN0j8lgReDw7ES6DUIaCc0AWt
         YsDqY20pamlKghLyhjkFUTLoZ7KEg8lQf5JmsfEUOmiIbu47LoB18jET0Zcw96dt7s
         2Z35AOyitp5nQ==
Date:   Tue, 22 Aug 2023 18:05:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 21/36] arm64/mm: Implement map_shadow_stack()
Message-ID: <007e1239-1258-4b89-b5db-a1c505e7aff5@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-21-68cfa37f9069@kernel.org>
 <ZNZkADhSnodXuH5F@arm.com>
 <9c722954-8f30-425e-a0a4-6edad463620f@sirena.org.uk>
 <ZOTlBpAbSX6TSZzW@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="exkeVuAAvGvWqCpS"
Content-Disposition: inline
In-Reply-To: <ZOTlBpAbSX6TSZzW@arm.com>
X-Cookie: MIT:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--exkeVuAAvGvWqCpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 05:40:38PM +0100, Catalin Marinas wrote:
> On Fri, Aug 18, 2023 at 06:08:52PM +0100, Mark Brown wrote:

> > mprotect() uses arch_validate_flags() which we're already having cover
> > this so it's already covered.

> I searched the patches and there's no change to the arm64
> arch_validate_flags(). Maybe I missed it.

It's in v5, the update to arch_validate_flags() was one of your comments
=66rom another patch in the series.

--exkeVuAAvGvWqCpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTk6s4ACgkQJNaLcl1U
h9DssAf9EW4nFH7RlADvE4EkIEjYj6kUziCf6Hh2iZGyNLK3aFRxnL1nY1u1zP6j
q/ACfgdD1+OLEnvbezfXu1bJ6avmKqmnJHnkP7zF5C/63tXoF8IUUwodZXV4d3DP
54ezvT4yQ8Yu5AxpmLPCItJkHbeLAezr41EbEpcJWSfkAnXqhT/cO7JREhVKH/3f
czlWXKNy8c+vwIXC7x7mRKOCeBcJ4mofi6i5T8JDYcL1b59ItFYO7zfcB1H/nPh7
qV10AxG61aXsJoiboml1UjyOA8+ZaiLpjgGmxZ1YEZSF3C+TVw2Ul5Z4yHtgdVdA
FQHfQawXdzOTgnqQG2uCel7CjV9LDQ==
=ME24
-----END PGP SIGNATURE-----

--exkeVuAAvGvWqCpS--
