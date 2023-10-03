Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392877B6AB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjJCNiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjJCNiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:38:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F82A9;
        Tue,  3 Oct 2023 06:38:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35ABC433C7;
        Tue,  3 Oct 2023 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696340293;
        bh=uwtqnUxTMKbAVfD+gZWXN+2nSoPSgsCGQxxJs5nbdeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmdjXMqXyZeGSvyuQRufMD+IbooZlHt4Fl+2QKKDFRxTKFWqLtibJL9fD2WNsXRqn
         PpPdqOp7OhH7MsubfkpS6TMDyTKN/AeMfpIWAAhKiHBW6JEQ3eVUvzKQho+r0c73bq
         uSoe4cVF/Qi/iaTEhllRcf5K1O5CZiHLBq7R6bewNsL3AMIX0hrDkyw4IamVbeEUVY
         H7fYoWgMgUl9JjkhObUuvSdL4RBWAerpg148lOtgda7gOTMm7ojp6Djmbc+MxP93EK
         lDx842uWlD4YM9qLneth2OoHkxGe3TPPF+PSAUpxItWZWQKpSHLSND54oimTw+6Bas
         PVQHDSsJ52lWQ==
Date:   Tue, 3 Oct 2023 14:38:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <3985b0d8-e35e-4cd5-a2bd-6a16d7c7e559@sirena.org.uk>
References: <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <ZOYFazB1gYjzDRdA@arm.com>
 <ZRWw7aa3C0LlMPTH@arm.com>
 <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
 <add914d6ad943139cd4a8f23fea7167b083a53db.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VOYoYIe/0D3GI3W0"
Content-Disposition: inline
In-Reply-To: <add914d6ad943139cd4a8f23fea7167b083a53db.camel@intel.com>
X-Cookie: Oh Dad!  We're ALL Devo!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--VOYoYIe/0D3GI3W0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 09:43:25PM +0000, Edgecombe, Rick P wrote:

> If ARM is thinking of doing things differently than x86, you might
> think about how you weight those tradeoffs. Like, it might be silly to
> worry about clone() support if something else ends up breaking
> compatibility majorly. But, it might be worthwhile it you end up going
> to the proposed extremes around signal alt stacks, to maximize
> compatibility

Yeah, I think Catalin's thinking here was that we're quite a way out
=66rom actual hardware so it's much more tractable to fix up callers than
it is for x86 where the hardware is widely available.

> Also then maybe x86 could copy the ARM ABI some day, if it ends up
> chasing the tradeoff people prefer. It probably goes without saying
> that the closer these features behave from the app developer
> perspective, the better. So a different ABI than x86 that also targets
> a mix would be a bit unfortunate. (not the end of the world though)

If nothing else even if we end up being stricter about things it would
be extremely disappointing if we ended up with something where code for
arm64 won't run when built for x86.

--VOYoYIe/0D3GI3W0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUcGToACgkQJNaLcl1U
h9DGrwf/e1Q1mca/c+Y8gjB9uTmkbz6UTxEP5Ie+SQ8OHE0DeQjg4wUgWFKyhONR
Gja5KPwSLlu7n1otNu8P3ztqCLwd3+sa1yM4Tzhq965l/wqp1cmwh3OcRJwWNO/w
TzGqD8fnAAZY6EyfMg6oP8IcWvD1ru5jttF18YdJdekWjBGQyWI+aZaN8ERdT1hG
8G2Jz0DOJCCRuMo4JWQQ7wyKmgXsaCsO0UeTLsniZYatysygBlZPnxwG+kSlwwrP
jJwDtljE9WONcZZttwNT0Rn/dFpXj4cO5L0RjHX/HPvHmSwOgdnO4fBD2HSL53xL
WSStamx5uiW/Ch8ilcxeRdcT+rL/Jw==
=Wyj+
-----END PGP SIGNATURE-----

--VOYoYIe/0D3GI3W0--
