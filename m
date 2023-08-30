Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2078DB15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjH3Sia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343718AbjH3Qmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:42:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FEA19A;
        Wed, 30 Aug 2023 09:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81AD762119;
        Wed, 30 Aug 2023 16:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F379C433C7;
        Wed, 30 Aug 2023 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693413751;
        bh=+cegdjpC7G5umSHFHbrmT1BIlMdov4rtt+v2oJEk1tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjbX4CCwh2T7VRmcGdTip7u/f/TaIxuYGePqe7e+D4VSLmbiZHbmccKJEensZqdYd
         /SkVtQoHfFek1l/akYZpl6ne+8eKdaeb9A2TuvGKtHgX54qQvFDVWxI1azmcGgWe2A
         TCS6C1oK4Z9Yi4kRDMDic1bnoquUGBouKD5MDQ3AY/kt+9FcjbvW5qvdsxbxoapCQj
         m6CelcYTizHCgj7uEUvmooKRW1IDpuIbzMXpLTY63MW/y+bD0wODuEHfxQZ27KwMGs
         UK+r1H9fjVVo3zf7MJOTbhSZBfN9GnYmDVX/HSF7zUQGGf3T2s6/zw2yHd96jP9gqw
         cyxOybFWimvpA==
Date:   Wed, 30 Aug 2023 17:42:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <9992beaf-f57d-41f8-9dbb-8044c783ddf4@sirena.org.uk>
References: <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <227e6552-353c-40a9-86c1-280587a40e3c@sirena.org.uk>
 <ZOY3lz+Zyhd5ZyQ9@arm.com>
 <ZOZEmO6WGyVAcOqK@arm.com>
 <ef7272d2-d807-428f-9915-6fc9febadb5c@sirena.org.uk>
 <ZOd6lzj29VksAp7L@arm.com>
 <ZO84DWEiYk6dU3iR@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K/vjy3MP44rS/waF"
Content-Disposition: inline
In-Reply-To: <ZO84DWEiYk6dU3iR@arm.com>
X-Cookie: Immanuel doesn't pun, he Kant.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--K/vjy3MP44rS/waF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 30, 2023 at 01:37:33PM +0100, Szabolcs Nagy wrote:
> The 08/24/2023 16:43, Catalin Marinas wrote:

> > Is there a use-case for the unlocked configuration to allow disabling
> > the GCS implicitly via a clone syscall?

> how would you handle clone or clone3 without gcs specified?
> (in the cases when clone creates a new thread with new stack)

> (1) fail.
> (2) allocate gcs.
> (3) disable gcs.

...

> problem with (2) is that the size policy and lifetime management
> is in the kernel then. (since only special cases are affected i
> guess that is ok, but i assumed we want to avoid this by moving
> to clone3 and user managed gcs).

Right, it seems like if we go with this then we may as well just allow
plain clone() too.

> the problem with (3) is escaping the security measure, however
> it only applies to very special threads that can always decide
> to opt-in to gcs, so i don't see this as such a bad option and
> at least bw compat with existing code. (in my threat model the
> attacker cannot hijack clone syscalls as that seems stronger
> than hijacking return addresses.)

It doesn't seem great to have a feature which is to a large extent a
security feature where we provide a fairly straightforward mechanism for
disabling the feature and actively expect things to be using it.

Given the timescales until this gets practically deployed on arm64 I
would be inclined to go with making things fail and forcing updates in
the users, though obviously that's less helpful for x86 where the
hardware is in user hands already so it's more of a pressing issue (and
there's already what is effectively option 2 in the code).  We could
have the architectures diverge, as you say the effect is likely to be
mainly in very low level code rather than general software.

--K/vjy3MP44rS/waF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTvcWkACgkQJNaLcl1U
h9BrNwf/ZAr2lf9jr/JbNkYpu9zm6Fga4tZrLQoMWCDnP9PGxphhBn9iAMWz6X+F
0X05x9pIN7D4g7qLffjEzsFOpfukbLwIQ4wH/AdjNW7MvFpuH+4kt7iWwiDparY/
wliRfw6VyCf8lMA40bSac+jlTEJowbBmX+nh1z+EI924BOUXDONu/PGGfoVtn9U0
mOVw+DFx3lACf5cjCPKSE9JfYf74s+y9cH8fk9x1/D6jHuJuX5IOafLld3PytL/v
Yxbc/C9XY0Qa9If9yV/NWPb7irX1i7vTMOcHJ8AAzwzHV7LjOOk2cBgRj0IJ2TBI
1fuiPsv3RNuj2GUC01Od5Md0pPjifQ==
=qSdV
-----END PGP SIGNATURE-----

--K/vjy3MP44rS/waF--
