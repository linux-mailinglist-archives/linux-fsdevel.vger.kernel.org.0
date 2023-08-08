Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5C7774C6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 23:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjHHVIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjHHVIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CB5106;
        Tue,  8 Aug 2023 13:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F6262CB0;
        Tue,  8 Aug 2023 20:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD7CC433C8;
        Tue,  8 Aug 2023 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691527350;
        bh=KLqUngF3vFNjZyVU1zCXyvfBsVeYIJBflOdj05tEw0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hkx8tFHEcSmSd/pdVhIsTiCpPGZ8uPf9NEXvhA7T1JE0q+KFDzDda7u74mkgkO92P
         D6BrXqWbCduifpG00gPnMKsZMBCqDXpp1kSKJ9YwnTBNfINsZ/X4bV2vVtFJ0BuW4I
         DzywDtHXbqsAHFmmOaUr+A66TeVuRUsMnJOV5LKFRw6aylWaQEdokWI2Ho+l/Jgo9p
         VECTFyGkyg5IJ9/WB3x07RywFKIrHg4+3wffsKp1r8oys5VpCJBVALKOqSWjyTVJpe
         QLSrnevT8KKCV6CCbD8vucQ4bjl5w0l+9tsB8i/nTaItUBRxtIG9ynqlNvE8ald88c
         RSgTwpjk3e9wA==
Date:   Tue, 8 Aug 2023 21:42:20 +0100
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
Message-ID: <0cf8f1fd-f4d4-45b3-ad49-5ec5ebc5a24f@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230731-arm64-gcs-v3-21-cddf9f980d98@kernel.org>
 <ZNDFioFIM34VcsuV@arm.com>
 <3a077ff3-8627-4337-9b4a-6a8828eda0e7@sirena.org.uk>
 <ZNH679dDPtvotp5j@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75LSeCYWaZU9+5nJ"
Content-Disposition: inline
In-Reply-To: <ZNH679dDPtvotp5j@arm.com>
X-Cookie: You need not be present to win.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--75LSeCYWaZU9+5nJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2023 at 09:21:03AM +0100, Szabolcs Nagy wrote:
> The 08/07/2023 14:00, Mark Brown wrote:

> > That's not what the manual page or a quick check of the code suggest
> > that mmap() does, they say that the kernel just takes it as a hint and

> i should have said that i expect MAP_FIXED_NOREPLACE semantics
> (since the x86 code seemed to use that) and then the mapped
> address must match exactly thus page aligned.

Ah, I see.  We do pass MAP_FIXED_NOREPLACE when allocating the stack if
an address was specified but currently leave it up to the VM subsystem
to figure out what to do with the address.  I don't immediately see
where mmap() enforces this requirement, but I have to admit I didn't
look overly hard.  I don't see a problem with enforcing a PAGE_SIZE
constraint here.

> > > > +	if (size == 16 || size % 16)
> > > > +		return -EINVAL;

> > > why %16 and not %8 ?

> > I don't think that's needed any more - there was some stuff in an
> > earlier version of the code but no longer.

> it's kind of important to know the exact logic so the cap token
> location can be computed in userspace for arbitrary size.

> (this is why i wanted to see the map_shadow_stack man page first
> but i was told that comes separately on linux..)

Right, I'd already changed it to % 8 in the version I posted yesterday.

--75LSeCYWaZU9+5nJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTSqKsACgkQJNaLcl1U
h9AuoAf+O+IZyJ2WsrUsv2iiyK/bNfKz6UPd4mztZDvaNs7eb/cJv2LxftttubUm
ylVCfdJZ50MxIN96kAREHXqiG51v7ab8riEFK1puVDbbnCQzP+qPb67HnyeJA+eP
y/G51VNYUA+n9mnB1hQgqwtqkRTCLfgE2uX+rXQj+yoQMO9eqwx7hJU32LaT7ReN
82F1d4g+o08IJR4pqL41OnfuoXtSswkeN+W4ODix90Im31z8oXU+KhOdlg2FPOwf
eYLnaE+2b0TySQGqjik3cLjGTQZySBerzjLi/2SpdzJx+OHzus/8kWzGWsiZOvEg
CyJ1jHyJf+ImWGDIY22GGPPmIHRyQw==
=DrsG
-----END PGP SIGNATURE-----

--75LSeCYWaZU9+5nJ--
