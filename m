Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15CE7724D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjHGNAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjHGNAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298261BC;
        Mon,  7 Aug 2023 06:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9872D619FD;
        Mon,  7 Aug 2023 13:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31608C433C7;
        Mon,  7 Aug 2023 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691413252;
        bh=VIywjKfIQjCBtdbDPXYlia2uvZPXVd/riPHCXoskQic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvvDU8srIyUZqSC/AZn5tENk73e6b7lcMD0bggv0OZy+kdMv1wzrdao14Ek53Iiyx
         IRdeP2i7dHvG05GYveqesPRozZBWvPkPzVgLAPzRKehV8FG4dTBFTlwNmq6W9aAmXd
         TOJ2NMgyqruEmA77u2ERYj64yfya3426m3ZWoUGeog++a6pvx66c8pChwY38vz523S
         ChaYFX40JW+pa2BW1vXmOmq45J6hBtdc88n5UAJdNuTfAiy2eP80JJIFmiP356Yg99
         NUF9YdSDWmi87A0gAAG2I/js0A4x5VYEjSB7V464D9htKF6RuocFXxnBcwe4+5gtev
         Hkzg/2TxLfPZA==
Date:   Mon, 7 Aug 2023 14:00:42 +0100
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
Subject: Re: [PATCH v3 21/36] arm64/mm: Implement map_shadow_stack()
Message-ID: <3a077ff3-8627-4337-9b4a-6a8828eda0e7@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
 <ZNDFioFIM34VcsuV@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zuyh0JKERt9z219h"
Content-Disposition: inline
In-Reply-To: <ZNDFioFIM34VcsuV@arm.com>
X-Cookie: idleness, n.:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zuyh0JKERt9z219h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2023 at 11:20:58AM +0100, Szabolcs Nagy wrote:
> The 07/31/2023 14:43, Mark Brown wrote:
> > +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
> > +{
> > +	unsigned long alloc_size;
> > +	unsigned long __user *cap_ptr;
> > +	unsigned long cap_val;
> > +	int ret;
> > +
> > +	if (!system_supports_gcs())
> > +		return -EOPNOTSUPP;
> > +
> > +	if (flags)
> > +		return -EINVAL;
> > +
> > +	if (addr % 16)
> > +		return -EINVAL;

> mmap addr must be page aligned (and there is no align req on size).

> i'd expect similar api here.

That's not what the manual page or a quick check of the code suggest
that mmap() does, they say that the kernel just takes it as a hint and
chooses a nearby page boundary, though I didn't test.  I'm not sure why
I have that alignment check at all TBH, and to the extent it's needed I
could just be 8 - this level of code doesn't really care.

> > +	if (size == 16 || size % 16)
> > +		return -EINVAL;

> why %16 and not %8 ?

I don't think that's needed any more - there was some stuff in an
earlier version of the code but no longer.

--zuyh0JKERt9z219h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTQ6voACgkQJNaLcl1U
h9ADtwf9Hi+3Tmw6lo4OcpVr7n1Zx4xMLurjUWXhlQulr3E2yaNH/LoJepX0V/Hy
cYyeMDXfa9itHkAmxF+PWpfByFW2ak1NvN+VB1ywgbz4kJFiAK11hsjQzWuiJw+s
e1it4mLwr1FXHqL0ewxN4pWvkFHmoyVTtKmtIlYrR4K9Xq8KEWrEDi6x5LHrI6tk
HXZ6HBESzDzzrctdnfG91f3YdpxLKuvuE1l+HEVfKlh5EqEHtTxzLT1BCDHy4ebI
URGjT1qEAOxoNDbYkJaaPcVnDkFfcXuSC07xv57tktihM+MnQCtZd0b+IH9lf6Ry
E10gfnUnsEkptjykMZVkmRiHM0iWvQ==
=jbyG
-----END PGP SIGNATURE-----

--zuyh0JKERt9z219h--
