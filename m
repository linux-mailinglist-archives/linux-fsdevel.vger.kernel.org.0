Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF0D785813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjHWMvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjHWMvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAEEE47;
        Wed, 23 Aug 2023 05:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A14E8645AF;
        Wed, 23 Aug 2023 12:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4984C433C8;
        Wed, 23 Aug 2023 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692795104;
        bh=aIGZdAZfibpwOhOBqgFa8nf151J9Hk7d7fWvjMeY4zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khDVpCaQdQhHesYs9RGRpVlvH8eWo3qrAoJKrfl6rCMMNb3+VNdzi5pk2+Le8Y9ph
         pjjFWBvFAjVLuMOHcw6ky5TwIBqzGIeijbo2SRxr602ZcPxbmBg0NBa4El+5f1jRbr
         uQ8Gdwk7KGPF1ZuROilSORtcM8Q8jen2QoY/J5xt8KrtGhe6i09i87Gj80vGx+LwzA
         Y4GMrP0i8eRT/b1xndfov0OxmF2Cz4oGiGH00guo7/YhFkDyuUKDLBQ8t5uExGCnkM
         CfV0NIyavGSn7UdSBpuE5djPSMDymoFZn4E8QzB6e0N2EDt8dObvj+9ZSIZtzI6gMq
         dbRiW9VbzcTqQ==
Date:   Wed, 23 Aug 2023 13:51:35 +0100
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
Message-ID: <227e6552-353c-40a9-86c1-280587a40e3c@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZN+qki9EaZ6f9XNi@arm.com>
 <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UdmTiHBngnlr6cvp"
Content-Disposition: inline
In-Reply-To: <ZOXa98SqwYPwxzNP@arm.com>
X-Cookie: Some optional equipment shown.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--UdmTiHBngnlr6cvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 11:09:59AM +0100, Szabolcs Nagy wrote:
> The 08/22/2023 18:53, Mark Brown wrote:
> > On Tue, Aug 22, 2023 at 05:49:51PM +0100, Catalin Marinas wrote:

> > the what but not the why.  For example roughly the current behaviour was
> > already in place in v10 of the original series:

> well the original shstk patches predate clone3 so no surprise there.
> e.g. v6 is from 2018 and clone3 is 2019 linux 5.3
> https://lore.kernel.org/lkml/20181119214809.6086-1-yu-cheng.yu@intel.com/

Ah, that'd do it.  People weren't excited enough on about clone3() when
reviewing the shadow stack patches, I hadn't realised clone3() was so
new.

> > I do worry about the story for users calling the underlying clone3() API
> > (or legacy clone() for that matter) directly, and we would also need to
> > handle the initial GCS enable via prctl() - that's not insurmountable,
> > we could add a size argument there that only gets interpreted during the
> > initial enable for example.

> musl and bionic currently use plain clone for threads.

> and there is user code doing raw clone threads (such threads are
> technically not allowed to call into libc) it's not immediately
> clear to me if having gcs in those threads is better or worse.

Right, that's my big worry - I hadn't realised it was extending as far
as musl/bionic.

> one difference is that userspace can then set gcspr of a new thread
> and e.g. two threads can have overlapping gcs, however i don't think
> this impacts security much since if clone3 is attacker controlled
> then likely all bets are off.

Yeah, I think that's a "you broke it, you get all the pieces" thing. =20

> > My sense is that they deployment story is going to be smoother with
> > defaults being provided since it avoids dealing with the issue of what
> > to do if userspace creates a thread without a GCS in a GCS enabled
> > process but like I say I'd be totally happy to extend clone3().  I will
> > put some patches together for that (probably once the x86 stuff lands).
> > Given the size of this series it might be better split out for
> > manageability if nothing else.

> i would make thread without gcs to implicitly disable gcs, since
> that's what's bw compat with clones outside of libc (the libc can
> guarantee gcs allocation when gcs is enabled).

That'd create a pretty substantial divergence with the x86 patches if
they land this time around, there's not enough time to rework them now -
I suppose it'd mainly bite people implementing libc type stuff but
still, doesn't feel great.

--UdmTiHBngnlr6cvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTmANcACgkQJNaLcl1U
h9CieQf+MMgnojrsBIaDJI83Wq0C8xk7vAXbThpL0v56u9wjmEZMDh7EcY2ddq/2
JABAkm2liE7SLPjWQBEUUN0/IeeUmkf96mYK4WQlULgjiwfY47oi3jWUhZ6k9LhM
8pjyl1KON9bRNIrulNLtQVYAPXm7vhGBmR0BjziAHJsdoaxh/mFuY24eV8GU6M+g
3y8nYYgKNOAjB6E6//Acfg4jVvxYJGMdmVlJl4REhmre1EGrE2R3NAiKDJZ/sKGz
3F4rR/Opy2Sa/VQFqR1eyjhZEjZxVgbrBukhZV+ExyMSjPfagV2qok97yi7jIIXg
lRrBa8MwILXz0GiOAj9Xz5WDbjUsRQ==
=F2xx
-----END PGP SIGNATURE-----

--UdmTiHBngnlr6cvp--
