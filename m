Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8254F7845E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjHVPmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 11:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjHVPmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2AE7E;
        Tue, 22 Aug 2023 08:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A243265B14;
        Tue, 22 Aug 2023 15:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F198BC433C7;
        Tue, 22 Aug 2023 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692718902;
        bh=U8sk7r3HpjuM6jyf6I/ZCmrrIT4hPUtWgTjlWgfZQ+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ew1lxee1O/Ti1p/vQKYfVrokDQePlcLRRcpwk16Sz433/A4D7AWBgD3BRDBIf4X4a
         fgRp87Xf/4hsKqH1P1veF7eYsQVXiFifYGG80LgQD/9WhpHdqV0wzwdNl9g5n8o4Is
         BU7SEV6UiJDuuKjAcW7KgylZl46xOuShdprb7imzwhaqgdpaWPuAZaW+SgljORXEqk
         bYT4DY30YPyhtbGZeq/Y5wXvmzcvTPRyyMUdQnfal+F/LjJWiqxIGX1Sr3xqwpstgA
         E91ugzTDnLfi50x+F5ZD+ysZzx7G1FYX11oVwClMHP6ycS7PC20BZUcsFSLKaaP2s1
         Z4ILnptB/1A+w==
Date:   Tue, 22 Aug 2023 16:41:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Hildenbrand <david@redhat.com>
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
Subject: Re: [PATCH v5 11/37] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Message-ID: <54b2c1e5-a99d-42c0-b686-1b5cbb849581@sirena.org.uk>
References: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
 <20230822-arm64-gcs-v5-11-9ef181dd6324@kernel.org>
 <8f2cf5af-cad7-a69c-e8ec-39f48deae1cb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rm2VNANgsE/SCWLa"
Content-Disposition: inline
In-Reply-To: <8f2cf5af-cad7-a69c-e8ec-39f48deae1cb@redhat.com>
X-Cookie: MIT:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Rm2VNANgsE/SCWLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2023 at 05:21:09PM +0200, David Hildenbrand wrote:
> On 22.08.23 15:56, Mark Brown wrote:

> > @@ -372,7 +372,17 @@ extern unsigned int kobjsize(const void *objp);
> >    * having a PAGE_SIZE guard gap.
> >    */
> >   # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
> > -#else
> > +#endif
> > +
> > +#if defined(CONFIG_ARM64_GCS)
> > +/*
> > + * arm64's Guarded Control Stack implements similar functionality and
> > + * has similar constraints to shadow stacks.
> > + */
> > +# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
> > +#endif

> Shouldn't that all just merged with the previous define(s)?

> Also, I wonder if we now want to have CONFIG_HAVE_ARCH_SHADOW_STACK or
> similar.

I can certainly update it to do that, I was just trying to fit in with
how the code was written on the basis that there was probably a good
reason for it that had been discussed somewhere.  I can send an
incremental patch for this on top of the x86 patches assuming they go in
during the merge window.

--Rm2VNANgsE/SCWLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTk1ywACgkQJNaLcl1U
h9BD9wf/cB5zRdwIzkkWbWNj7vGmdw/naEVnAbVYCNZ/bHdhOSOrh0n6okk3VIRr
nG08750cw+elIt7ZbSAQPiP1+CFzCr/dshkv4rpO3BsDkOLG5T4fGC1k2lDGxkod
RLVF6XQwgM2ztHvSeEkAR+R4QiLHJ/x+wO/3GmmhU/uI7mEZUGtJSfDCYAVoha5E
vREhonRSaCxOzb+/K+v+oGApAxl15DggL1W5Kz9nwoYd4rnQaxYBKref5sCuZ+xL
znOWuAx8fzyiQO9PxBHSvgI5oddgUpbkmWA9zvZNWysIEtoKN01wlzPxlyv2mHyz
Zct6RQVH8GSydpTlgzb6BPdxyXhOLw==
=WYLZ
-----END PGP SIGNATURE-----

--Rm2VNANgsE/SCWLa--
