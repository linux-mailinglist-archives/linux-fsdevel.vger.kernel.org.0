Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501E7781368
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 21:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379626AbjHRTij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379660AbjHRTiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D191FCE;
        Fri, 18 Aug 2023 12:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88B7662D18;
        Fri, 18 Aug 2023 19:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBE7C433C8;
        Fri, 18 Aug 2023 19:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692387492;
        bh=01Q2xEmAO2pVJWHzK9M3MZQdGCIPPOuErEoePLDfq+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvLDUejgDxFNb6IhI4Y0qdql5M25cqQLtbiufVm4Gb1iXmTmAB0Vv7ahIz5a06KAb
         PUVYYrLHaNR/SZqrZU0yrVK5FDSBVeGGfofO9+Df7X5NWY2X9XcazAltA6H9EsHtv+
         fc4AWwR9CKunnY9EpyNqH+5BjOB9QdtB0QMaWXxuq/yd9mPtqlVE1q+rF9jr+uSXsI
         f1NsCWGQH8w59yUVRi8q2TubicSUqChyEh/LQmmTFJ4Z4wetsknCZ6enP2KXAnB49z
         oUn0kP6MHyAsmo5BdzSFWx5eauk1ZDTV4IrU/9IN+nMSi55OIHvkUfyBmizMa3JLC6
         ole8zbgLwOsiA==
Date:   Fri, 18 Aug 2023 20:38:02 +0100
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
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LNILMu582aOVL6hM"
Content-Disposition: inline
In-Reply-To: <ZN+qki9EaZ6f9XNi@arm.com>
X-Cookie: Your aim is high and to the right.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--LNILMu582aOVL6hM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2023 at 06:29:54PM +0100, Catalin Marinas wrote:

> A related question - it may have been discussed intensively on the x86
> thread (I may read it sometime) - why not have the libc map the shadow

Your assumption that this is a single thread feels optimistic there.

> stack and pass the pointer/size to clone3()? It saves us from having to
> guess what the right size we'd need. struct clone_args is extensible.

I can't recall or locate the specific reasoning there right now, perhaps
Rick or someone else can?  I'd guess there would be compat concerns for
things that don't go via libc which would complicate the story with
identifying and marking things as GCS/SS safe, it's going to be more
robust to just supply a GCS if the process is using it.  That said
having a default doesn't preclude us using the extensibility to allow
userspace directly to control the GCS size, I would certainly be in
favour of adding support for that.

> (I plan to get back next week to this series, I'll need to read a bit
> more on the spec)

I've been making changes, mostly in response to your feedback, so there
should be a new version on Monday even if not everything is addressed
yet.

--LNILMu582aOVL6hM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTfyJkACgkQJNaLcl1U
h9Cw3Af8Cnyy0Sa1PU1lq3c1HV/d6eNcVzOoN4kECuID3B/GKxWng90W0Z7wR75z
Wl9H0WZxlDkqd/voFGHAJTEtlcEZMg6xNByq8Rhq2jw6R2EX3O8P6+Uqumjb3UQ8
wb+PJyloj3BhXcQPiMH8vFHAs6b81DyPYo9NtaCLsYbtZv4MwGjgJKRrAl8+O2ct
n/1P1Hpp/XUeTZUZvyWxrBdDUD7nLq9mQe2/+h6NxTtchrNTb98Kvgk7JrRefjrB
7kehDj9XiBJt5vVkoSO+e5aVln7wgwWor3KsjviaeNzyXglWrx+VBIc8OT6FMiJw
VIA6Wrc8ikvi1fZ/oooK9TnU+p5chw==
=RgY5
-----END PGP SIGNATURE-----

--LNILMu582aOVL6hM--
