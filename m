Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D292177775D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 13:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjHJLlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjHJLlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A191;
        Thu, 10 Aug 2023 04:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB1565784;
        Thu, 10 Aug 2023 11:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3391FC433C9;
        Thu, 10 Aug 2023 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691667677;
        bh=SjY6cOlS50SecqcUH+vtDGVI75FsC2Isz7CGfrRn3Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBTItZUv0G89tFiv0O0B8TEhjWNjnoNEmZi8nt6DuvO/scAwoxRs7XA6BiURuHLnb
         4Aq2cDA2bbWglZvwEXyOfnCjN38AzLwQwsZN4mG6gfoGXUaFw0f/4i09YWO4gcWvo9
         ooMH/iYINXNk9s5xHIZ/l8yPA4RolpVcnCfTpJUEFbuMe7IwbvQa/cAOEn0/WIwLxX
         Jma2PMvPtsFsaIMl7jjQYY0kzKwqaua6ViLBFNC+1zlvZ81ZtUeCKnh7WBGsyWT0AJ
         0q7MPoQEpgwIXfUQ8+CODBM5Jhp17HRovOb1/sPzqGLFa82MDNsHsLUj71MptXKTqp
         kA8rBQ2dsmgng==
Date:   Thu, 10 Aug 2023 12:41:09 +0100
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
Message-ID: <4e215e53-c7d1-4338-8df9-3f9bf783ced9@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZNSmFmYFHDw3NvvP@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HX3zqelcmaABHbLq"
Content-Disposition: inline
In-Reply-To: <ZNSmFmYFHDw3NvvP@arm.com>
X-Cookie: Reunite Gondwondaland!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--HX3zqelcmaABHbLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2023 at 09:55:50AM +0100, Szabolcs Nagy wrote:
> The 08/09/2023 16:34, Mark Brown wrote:

> > It's actually based on bitrot that I'd initially chosen a smaller value
> > since it's likely that functions will push at least something as you
> > suggest, the patches now just use RLIMIT_STACK.  I'll fix.

> the pcs requires 16byte aligned stack frames, with 8byte per gcs entry
> there is no need for same gcs size as stack size in userspace.

I agree that it's going to be excessive for pretty much all
applications, I adjusted it to match x86 as part of the general effort
to avoid divergence and because I was a bit concerned about non-PCS
cases (eg, JITed code) potentially running into trouble, especially with
smaller stack limits.  It's not an issue I have super strong opinions on
though, as you can see I had implemented it both ways at various times.

--HX3zqelcmaABHbLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTUzNQACgkQJNaLcl1U
h9CX2Af/ZivuFjFTpJA8oad5auH8pxkhXVEAIPD0ff/7T6abVR9+lSwBwNj9fu7u
QzV10fINsZecsGZed5ZdpIR3HeeSZW2rAVaF2fIu1u7L6gXy0UwG1jPkOB21G4Ca
LApqqi+p4OfTtZtySK1optntQ4+DJRFrhFESNYwt/UyKffuB9bbr5xaIB/23ghe+
ZLmOWBXMpL4NaZMPdi9Tm43gAvVlDnXsANCWTZfq0uRGZBJBggQIM7Mwrz9JwmVy
3633R9GviRxPWQm83UqZI7n51wspiOfjdhYYtsqqo7jYwawpnfb4Jj89/3j6QmJO
WdrDN78D2wpFLApdojZDDftk6sXHkg==
=m3b4
-----END PGP SIGNATURE-----

--HX3zqelcmaABHbLq--
