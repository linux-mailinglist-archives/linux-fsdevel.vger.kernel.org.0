Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DA757E48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjGRNzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 09:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjGRNzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1586BF3;
        Tue, 18 Jul 2023 06:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940D7615AE;
        Tue, 18 Jul 2023 13:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA5C433C9;
        Tue, 18 Jul 2023 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689688516;
        bh=5cdUcj3owivIzjkoYFboWBgivdYgnl4YnwjpKC2t3BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtR8XdBBq0j87nz3sJHETW4D6X3f2Tw6KWKHbxPNms4FvpYGnrt2l58e/Z8WBzFx8
         DNt7RnrhN9stbBvq7544R7uMV9bNARXYL2LzHWsxyUCXhSUls0hei52w+8lpyVYXEF
         oE0/i31Y4939oPjN9aTDQI4FKyPOk1ZD076TUNRcFyUcYM5C9vJhxI9IAU62Cp3ajx
         ceAvvBb1KCSF6tMCgvYVDzGSXRKqUbLK/GHALFOskbqze63JjCHM7k7ISPAUBuKDL1
         ubHorZl4nwKmhBbpynhLbHAcK7JRTB3Y8SwVpcNBgRMSrK1qobreFnLxfW/4nbbMkZ
         yEL/pX8hpPQOw==
Date:   Tue, 18 Jul 2023 14:55:07 +0100
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
Subject: Re: [PATCH 22/35] arm64/mm: Implement map_shadow_stack()
Message-ID: <8ea03eda-e630-40c5-acc1-a63f5c5b3102@sirena.org.uk>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
 <20230716-arm64-gcs-v1-22-bf567f93bba6@kernel.org>
 <ZLZW7Kvg2Rep8ySO@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5hKtc1qLwv4bVDN"
Content-Disposition: inline
In-Reply-To: <ZLZW7Kvg2Rep8ySO@arm.com>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Y5hKtc1qLwv4bVDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 10:10:04AM +0100, Szabolcs Nagy wrote:

>   uint64_t *p = map_shadow_stack(0, N*8, 0);

> i'd expect p[N-1] to be the end token and p[N-2] to be the cap token,
> not p[PAGE_ALIGN(N*8)/8-2].

Yes, that probably would be more helpful.

> if we allow misalligned size here (and in munmap) then i think it's
> better to not page align.  size%8!=0 || size<16 can be an error.

Honestly I'd be a lot happier to just not allow misalignment but that
raises the issue with binaries randomly not working when moved to a
kernel with a different page size.  I'll have a think but possibly the
safest thing would be requiring a multiple of 4K then rounding up to our
actual page size.

--Y5hKtc1qLwv4bVDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2mbsACgkQJNaLcl1U
h9AzZAf6AmpARgwgG4zNQzt85k9TDh62vFVaeaSCfpyqUZ4UEHeRf0DJ2hib8MGt
aDz/k1E7ReyhGJhez+M19TlHMBHDoj2Fkh4bdOwzcTERDFTgMTGw8FFyyDjAP3fz
TkDlo1EwKyXZnGnkqYbSFozVhOEZm6WVu6kpN62D5Q2jSEkL96f7C3WjXU0UbR3K
X4Ey8EzUPGBf7SmYnOnGaG9+1bnKutkKj7unAMb6rJVFaAP/FTMpof5WI2kW4ngD
nu5z6uyG6x2pFBgA3wTKmlDUEkhLsvfbDMtSwZTyHfDf6ayYVdMkeVkpxqvc+Nag
BDtHeJXm98VwgwHiGPA6ln6uOvDbOQ==
=EMfO
-----END PGP SIGNATURE-----

--Y5hKtc1qLwv4bVDN--
