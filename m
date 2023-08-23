Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC52785C83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbjHWPuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 11:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbjHWPuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45160E70;
        Wed, 23 Aug 2023 08:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0FEA66551;
        Wed, 23 Aug 2023 15:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1268FC433C7;
        Wed, 23 Aug 2023 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692805820;
        bh=LfSPyFOC3BjWg0Lc12kxGpYZXTpAJDmnKm0+E48fsYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXxYB3+fT0UVF4Njt8TKpmeByoZkbsjd3n/9P3Snic8g9RaQqf8z9/1pAOMPSfemQ
         Y9j9vhDsu5y69cyAbfuDB83yGakcbvooWW6sYOU+Rpn6rnfgd6jhycZmd5MwPkAey9
         R/8WjmfnlXliw9apZxQ4dXU84G0pXh4oScGsRUdqq/NLv5BvG+lDtanGz3Qii+HgqF
         AdTJ6+Yywsuf55Jjh+2jDj/MQPRZoAJorkwc4Da/nqn+B25d4cDvqEJmH+OSk9x917
         +rI2H7D87DCVOHmkcb8R18WVGIDXoCwWYwvwnOpIIGT5cEuC8VMxE5zVxbsUFeak9i
         fekkLTSaiJdxg==
Date:   Wed, 23 Aug 2023 16:50:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
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
Message-ID: <b6b654d6-9f77-463e-bbe9-58e8135536ff@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <ZOYFazB1gYjzDRdA@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xcjBCIAjiMPyRAnv"
Content-Disposition: inline
In-Reply-To: <ZOYFazB1gYjzDRdA@arm.com>
X-Cookie: Some optional equipment shown.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--xcjBCIAjiMPyRAnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 02:11:07PM +0100, Catalin Marinas wrote:

> Yes, this should work. Any invocation of clone() or clone3() without a
> shadow stack would disable GCS. What about the reverse, should GCS be
> enabled for a thread even if the clone3() caller has GCS disabled? I
> guess we shouldn't since GCS enabling depends on the prctl() state set
> previously.

It has a fairly obvious intended meaning so we could do it easily enough
but OTOH allowing it opens up the idea of people wanting to specify GCS
flags which starts to seem like more trouble than it's worth compared to
just having them do the prctl() in the new thread.

--xcjBCIAjiMPyRAnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTmKrIACgkQJNaLcl1U
h9Drbgf/ZBUIo14hOU/3qkdtGyzuQHFus+mYzjU/uobIdprMeuTN+xOA0/oVAhlk
taPZwtMKHYyCkcXbZYxy6jKqDlM4zT3mz9WnCHkYtdQdCkyue/ftcKMF1SaZS4nk
Bzily68XoSg2VhZJTZQie/MqOXcwCDJcDHfBX42qmEhLXJZAblCcvtnu2KLwgSFp
nFmK1EGeH/+y6nXB/zoUYMDrWrzdpnZ4LJB8lwXMQHctPGJDyJIkZ+exBKubOR6H
ebKadj+npJxy9L4oLx2VRZ5AOjzR34+qZlQIuTPf8WokNrmtz4xQwPz7F1xBjcgN
jd3C7SSBR98L0uw+V3/L3WK8PKh2Lw==
=CE8H
-----END PGP SIGNATURE-----

--xcjBCIAjiMPyRAnv--
