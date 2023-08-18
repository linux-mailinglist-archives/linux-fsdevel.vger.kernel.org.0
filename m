Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67778113F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378900AbjHRRJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 13:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378915AbjHRRJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4978510C0;
        Fri, 18 Aug 2023 10:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC7B162BC5;
        Fri, 18 Aug 2023 17:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610E8C433C7;
        Fri, 18 Aug 2023 17:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692378541;
        bh=1JiWSPRDzlcQkonHOTJfOlbVQmRCyzrqNmv6BEdoPCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeDGkINQMUZMOv0CaERFn8GmpN/lFFhAiO84OP7u1x7AFZUtfVsRfzTEFzC+ygpsR
         Y9xpRo/IlegEekeP1Dut+AJzPtf3KaySn86syYV9hvhBj7tYI7hwm7WVjGwkVpEbKQ
         ZjgkorrFmrhhByHlHzjOB7PJonhx3wFLnve5nNkSRvFS4Qnnbvl/LHsJGsoNKavGlh
         wQaSzUFSZnBSxJIIJQqmSVEnLqSDKMGJQhsBsfKCrvRcquTSr/kacVzGcONadDoykq
         GZMPrwKnsKvdT1EyR550F0bV2J9QMoG16RUnCOQNCw1zWjT6j+ubsWMcE8yFgXt2oD
         mtaDQp5RlwIFg==
Date:   Fri, 18 Aug 2023 18:08:52 +0100
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
Message-ID: <9c722954-8f30-425e-a0a4-6edad463620f@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-21-68cfa37f9069@kernel.org>
 <ZNZkADhSnodXuH5F@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6HZ5j30fo2L27Lx"
Content-Disposition: inline
In-Reply-To: <ZNZkADhSnodXuH5F@arm.com>
X-Cookie: Your aim is high and to the right.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--t6HZ5j30fo2L27Lx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 11, 2023 at 05:38:24PM +0100, Catalin Marinas wrote:

> Given that we won't have an mmap(PROT_SHADOW_STACK), are we going to
> have restrictions on mprotect()? E.g. it would be useful to reject a
> PROT_EXEC on the shadow stack.

mprotect() uses arch_validate_flags() which we're already having cover
this so it's already covered.

--t6HZ5j30fo2L27Lx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTfpaMACgkQJNaLcl1U
h9CmuAf/Y7ANc4Kk+mnfQwnFeS/EQ5r5NF8oVlV+xJ9aNN/eMcDpeaYBvln2GA6v
ki7svYKRiiuRDNr3/h0fyHapLK3tsJpZxS76iqNbYh6EFBbZ5vX5njXBuLHneFL2
Kc18LKu7USgVA0WGmDvkClBhnSmeoOFrZjnrBJyJZFHNjTwRNM+tVnOCBeKTS/Ur
zPyUEIEB9wq1bs+NTA1CgvI82vIVrO3nLu00IP/35zQpX665RocIKw3craz+6Efl
8NH22NdfYjWPNSv9WI5pf2WG+CX2AOQ3v1IMF+S3jrN6NVdf5oOrpAYiejOjtf50
5MKlsT1RWl3PNInSnsIkRNYXCDmr7A==
=lwGM
-----END PGP SIGNATURE-----

--t6HZ5j30fo2L27Lx--
