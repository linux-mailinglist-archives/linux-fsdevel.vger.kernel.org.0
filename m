Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2E76B83E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjHAPKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjHAPKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCE01B1;
        Tue,  1 Aug 2023 08:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7863E615D9;
        Tue,  1 Aug 2023 15:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ABAC433C7;
        Tue,  1 Aug 2023 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690902607;
        bh=+bBPLGmDmXfC/yfM3zDVF6K5Ga/agNFu5ARhnA02LuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8zuzbiIsBm8TplmUwNtJnkj0WqQ7Bj07Nu9yp5ar/EYSV4LQQ3uL73ELCG1L41jq
         YvuaYQlYhxf9lYlvrNjTqqiK+hh/mmVXlCFhYNKELooEaDF+I16iw9dkxuoVH8Tf4r
         MMzAnPUycWbbea6niD+2vJ7S6VYgMcnxfQ/W8n2WzYs3ch5uSe4487LN6555t9Fsr1
         MEStdbDlfoeEftOw+xyV2O2Pyy2neIm2BVU9icTY0M0HKHFlx8zXeaGqKT88HFeDBP
         24CXRV2GJ39ZT5XdVsrhKrH4rhJNw34F9/DVHpaPG+sd+VlTEmdea7RgrgWKh2lT9O
         L985DdCd9UJCA==
Date:   Tue, 1 Aug 2023 16:09:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v3 00/36] arm64/gcs: Provide support for GCS in userspace
Message-ID: <09b7a94d-cc88-4372-85de-52db26bc2daf@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230801141319.GC26253@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eVo2yRFuK2CxHWEO"
Content-Disposition: inline
In-Reply-To: <20230801141319.GC26253@willie-the-truck>
X-Cookie: I thought YOU silenced the guard!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--eVo2yRFuK2CxHWEO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 01, 2023 at 03:13:20PM +0100, Will Deacon wrote:
> On Mon, Jul 31, 2023 at 02:43:09PM +0100, Mark Brown wrote:

> > The arm64 Guarded Control Stack (GCS) feature provides support for
> > hardware protected stacks of return addresses, intended to provide
> > hardening against return oriented programming (ROP) attacks and to make
> > it easier to gather call stacks for applications such as profiling.

> Why is this better than Clang's software shadow stack implementation? It
> would be nice to see some justification behind adding all this, rather
> than it being an architectural tick-box exercise.

Mainly that it's hardware enforced (as the quoted paragraph says).  This
makes it harder to attack, and hopefully it's also a bit faster (how
measurable that might be will be an open question, but even NOPs in
function entry/exit tend to get noticed).

--eVo2yRFuK2CxHWEO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTJIEYACgkQJNaLcl1U
h9BQawf/f0SGHhLVQUgdnRJbAN6lBuDUQfirqOPQbGb1BDJkA5bBH3gggqgDiUP9
iuDR87qdT9VDbUW0rgSKaYDAizuTvWthjfPv3Y0JOAgM9fmGmDmyldhVOSrmbRQF
hW3jgZbWRG0UK44PpWKLX2z13fGx9xVitteScPpIhF9r2o8kmq3SoYO7a681hQLI
usvrKaEpMYgeGeSm+2qlQj5sQnVNNrRD3u1BLbOuu6uRfWWtoUS+cFxUUUMNcmbi
1ZrrHuAy4ZanoowjW4HLjzhtQDVSPleqsZGfnChKMuZhXPqpBl74qWAMs8x9bq/F
iC0yz6XbrIQqfBkmNljqf0Kj03fpLw==
=2KV+
-----END PGP SIGNATURE-----

--eVo2yRFuK2CxHWEO--
