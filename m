Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3157785F69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 20:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbjHWSRG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjHWSRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:17:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25637CC7;
        Wed, 23 Aug 2023 11:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6A1463D52;
        Wed, 23 Aug 2023 18:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03400C433C7;
        Wed, 23 Aug 2023 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692814621;
        bh=z4aynHRzkI+QjbnRFX6g1vVxQ5ejtsIbs5rrGfHFHGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOmP4hLKyqUTY4Rpo3iF4nxe1oNnRDDYIYRbZ/skZ0s1Z1rqv3ybf1aNIxyXlfoZi
         XzisYoLx7TaoSyRzhpiq5y79KygxbLW8f3Y0aJffZZZK7hn134I1xclZvmJl/advUK
         FV3HcydgfFsNEx1mO4o6fk/h0jrhMpmi1nPkkVh+mPt1TaLdb9rJOn2FjvFo2V5SVn
         0YorKgoH/DUEFkI5en//P98Di0z8jX8gihJYc5+yYn8tQilGMhbF79vDUmtEfqzTPE
         LDNRjNI1lzg8m7cs4daU/NrYVTQWUoyjFGUHdKTLpL2Geei5FDlJv0IUpwuMr4GMxk
         ZGPH+S1BybA6w==
Date:   Wed, 23 Aug 2023 19:16:52 +0100
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
Message-ID: <ef7272d2-d807-428f-9915-6fc9febadb5c@sirena.org.uk>
References: <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <227e6552-353c-40a9-86c1-280587a40e3c@sirena.org.uk>
 <ZOY3lz+Zyhd5ZyQ9@arm.com>
 <ZOZEmO6WGyVAcOqK@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eccODu5HN5W02WFY"
Content-Disposition: inline
In-Reply-To: <ZOZEmO6WGyVAcOqK@arm.com>
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


--eccODu5HN5W02WFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 06:40:40PM +0100, Szabolcs Nagy wrote:

> i don't know if we can allow disabled gcs thread creation with locked
> gcs state. (i can see arguments both ways, so further prctl flag may
> be needed which may be another divergence from x86)

I think that if we do add a new flag that'd just be new functionality,
the divergence would be in allowing configuration via clone3() rather
than the flag.  TBH I'm not sure I see a use case for locking but
providing a mechanism for getting out of the lock, that seems very
questionable.

--eccODu5HN5W02WFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTmTRMACgkQJNaLcl1U
h9AFoAf/Rmp/X+zsA/zDX+bXBUla+v8qz72JS4cU/67DmXv5Fb8FKCj4nY5j/OnZ
3G9+lHZYYRFTA8sdQH2qULPo0S6QafNbebM0WxsjYuiCw8CKuztE1jOm+l6aVyf7
G/h5YxEOQBb4ChLezEXXQWZC0wR/S+7bf34IxDycvRh6Y0700VL4eZ7pu4fc8WDu
rHrMeB82zAlQCr3fdUgu5FzPQFUiY4dbDzPrJHpuVIq+Vnpk7RK7b1vkYZa4fo5o
2YB87p19ylZBQa0LvKdA+RkgDNvExeujREoO1O+WrBVa1bdtKw80kGgvXJC3oy0f
P8bazSIfrut0e41Y3agZotCijYwTlg==
=JX+L
-----END PGP SIGNATURE-----

--eccODu5HN5W02WFY--
