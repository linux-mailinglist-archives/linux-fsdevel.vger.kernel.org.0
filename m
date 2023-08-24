Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE0C787732
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 19:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjHXRiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 13:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242907AbjHXRiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B331BD4;
        Thu, 24 Aug 2023 10:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129E267225;
        Thu, 24 Aug 2023 17:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E96AC433C8;
        Thu, 24 Aug 2023 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692898692;
        bh=U5Ix9ciY5zbF8VwoY15Xy5FGw2K8jCp22zgnZb9yn1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRAf83wpRSrvvYRPjONqLVZzwBYmDLrH/GH1ltQcXP7W3rjLVJZ/rbQnnpP21RlTy
         5KGjtMJZipbDFqU5ETzp7GJ73tNtF5dpUnwDDr93+DtvZb1jyLeSl+LmE0BY19DfG0
         uPlvnfS6yIMSrxs7lb43NF/UkwEC8ZmgXZgoYupKjMkqQCJK1NAHDv0zxo/7o/ajIN
         CJ4lU3O5C10vTHb2rCfGlpE4YUHksa4/+mNGWqC5ATCYJhHg+b7spIRVwe9uCdGewY
         1zpdUkfatB50xUtoUYaupimxaODWpNmJKwGlIdZFKqfVQ56ebQsHXIQR2BFnB9oovK
         2AzqDCkwAPsKA==
Date:   Thu, 24 Aug 2023 18:38:02 +0100
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
Message-ID: <ZOeVeujEVmoJ1eOR@finisterre.sirena.org.uk>
References: <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <227e6552-353c-40a9-86c1-280587a40e3c@sirena.org.uk>
 <ZOY3lz+Zyhd5ZyQ9@arm.com>
 <ZOZEmO6WGyVAcOqK@arm.com>
 <ef7272d2-d807-428f-9915-6fc9febadb5c@sirena.org.uk>
 <ZOd6lzj29VksAp7L@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cR3/e0in3CDt790L"
Content-Disposition: inline
In-Reply-To: <ZOd6lzj29VksAp7L@arm.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--cR3/e0in3CDt790L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2023 at 04:43:19PM +0100, Catalin Marinas wrote:

> If we go for extending clone3, I wonder whether we should also introduce
> a sigaltstack2/3 ;). I haven't checked what the current patches do and
> won't have time until early September (on holiday from the end of today).

The current patches (and the x86 stuff that's in -next) punt on
sigaltstack for now, the discussions around that are unresolved.  My
hope is that whatever we come up with there can be cross platform.

--cR3/e0in3CDt790L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTnlXkACgkQJNaLcl1U
h9BzXwf+PogdlHq+hcG6MNbhOXLdqIdv9ZRGclIgCMqiPry95Dchnj/AqAm6c1KW
hIYF7JwBhdQ+4zYjGG9gBcEs8zpbQepJziTh8cVrno1O9hL573b/rHrspYwVR+7K
SPEa3v+HfOhG2JG1jeX9p7IHLIxR8XjbRTOIjnH0y2H5Mi5GRIdblDl0MFwss65Q
yy4A9M+MErwOLa61qAJVBAXHrPefexcp6OJDaExkFCKA4AUkAEMkx8ewKfn7zep+
8cVT/fpy8yqtFSE9W2tJEp4Cm7tuoUGCvj6wuO8nUTnCRhu7L91iFnXr6jI2NXjq
4lpRD2wGj+qk2c/2UpLnuyaJZC11dg==
=4Dj+
-----END PGP SIGNATURE-----

--cR3/e0in3CDt790L--
