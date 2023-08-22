Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398497848D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjHVRxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 13:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHVRxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:53:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D663A89;
        Tue, 22 Aug 2023 10:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A356573E;
        Tue, 22 Aug 2023 17:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC73AC433C8;
        Tue, 22 Aug 2023 17:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692726798;
        bh=9a8ZiiIomCgzRUqh/c3WOIoTK7pP7e23UYKPe7n1O5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NY4NsFl/Kb17GSmp6tTl3tq6HBZ6tfOEyr2nKkySYldjxCmkIOOWM7iqF77b8nCf4
         UVqdAAdlgMxXwmJ2meyM9KG3K8p2YzhHWI4CgQq+Jbxvgmn/FpizDXCgHnwTn5EVNy
         MNKdeXAdGmDvq7Vtc+UQdvTVct5u5Umc/8yznPRL1zYD9sNBJsdZpKJqtUHENBJRWt
         QkHHx0bMffrAj5NCFK8Tewx0vNzSfbfF12C39z447W4OkJ29kYznbD+9McT5WFVf1v
         nfkTHZTTgXcVN5CxWl4cxgMHTvJw0w+K8TJgaBSS5u7x+j51W0uEqtVIBQgs+HokPx
         8Vjq8bTHj5KlQ==
Date:   Tue, 22 Aug 2023 18:53:09 +0100
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
Message-ID: <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6BoSdPCvTHZSSkxi"
Content-Disposition: inline
In-Reply-To: <ZOTnL1SDJWZjHPUW@arm.com>
X-Cookie: MIT:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--6BoSdPCvTHZSSkxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2023 at 05:49:51PM +0100, Catalin Marinas wrote:
> On Fri, Aug 18, 2023 at 08:38:02PM +0100, Mark Brown wrote:

> > > stack and pass the pointer/size to clone3()? It saves us from having to
> > > guess what the right size we'd need. struct clone_args is extensible.

> > I can't recall or locate the specific reasoning there right now, perhaps
> > Rick or someone else can?  I'd guess there would be compat concerns for
> > things that don't go via libc which would complicate the story with
> > identifying and marking things as GCS/SS safe, it's going to be more
> > robust to just supply a GCS if the process is using it.  That said
> > having a default doesn't preclude us using the extensibility to allow
> > userspace directly to control the GCS size, I would certainly be in
> > favour of adding support for that.

> It would be good if someone provided a summary of the x86 decision (I'll
> get to those thread but most likely in September). I think we concluded
> that we can't deploy GCS entirely transparently, so we need a libc
> change (apart from the ELF annotations). Since libc is opting in to GCS,

Right, we need changes for setjmp()/longjmp() for example.

> we could also update the pthread_create() etc. to allocate the shadow
> together with the standard stack.

> Anyway, that's my preference but maybe there were good reasons not to do
> this.

Yeah, it'd be good to understand.  I've been through quite a lot of old
versions of the x86 series (I've not found them all, there's 30 versions
or something of the old series plus the current one is on v9) and the
code always appears to have been this way with changelogs that explain
the what but not the why.  For example roughly the current behaviour was
already in place in v10 of the original series:

   https://lore.kernel.org/lkml/20200429220732.31602-26-yu-cheng.yu@intel.com/

I do worry about the story for users calling the underlying clone3() API
(or legacy clone() for that matter) directly, and we would also need to
handle the initial GCS enable via prctl() - that's not insurmountable,
we could add a size argument there that only gets interpreted during the
initial enable for example.

My sense is that they deployment story is going to be smoother with
defaults being provided since it avoids dealing with the issue of what
to do if userspace creates a thread without a GCS in a GCS enabled
process but like I say I'd be totally happy to extend clone3().  I will
put some patches together for that (probably once the x86 stuff lands).
Given the size of this series it might be better split out for
manageability if nothing else.

--6BoSdPCvTHZSSkxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTk9gQACgkQJNaLcl1U
h9BVgwf9G/ojrSlPr8aZQbwQrJaEy9bbEh+ZaykvRKk3iXQUNzFkRRbv4n9vCcYY
BTGBUaIpZRPpRBA9nj2Sxi/BtM5AQ3qVmiWPnRmC7z/D0dsZuRueK1IelalX4QVE
PSkWGZaDmDLG1HsnKru31VU9urXCJln0l5jC9eE3BJR9StAH7ZjBhyRn8GPjiHgP
O3CYORRKsQPZ3yLC4DGo+o6Fe6eMXQUXwufWcm1pZu3gAqB2n0iyQdKliLhTeFDX
pctFRp4JlHB9ZiHGy2Odp4oVBqyaGPF2R+t/Jx0qNZrUm8VJBVFXNj6yMhAJh5ec
WpRWqHYzLck6XKjMVJv0Wf4NS52v+Q==
=qHhB
-----END PGP SIGNATURE-----

--6BoSdPCvTHZSSkxi--
