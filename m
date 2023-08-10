Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6E777DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjHJQHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbjHJQHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2217C49FE;
        Thu, 10 Aug 2023 09:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF223661D0;
        Thu, 10 Aug 2023 16:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDCAC433CA;
        Thu, 10 Aug 2023 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691683516;
        bh=3dqXqxLfF0EBUTIcyGpG0Y9ki6xtjmzbbUkts8u5Ikg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3iKU92fRFQ5ebgkTvsvwFRj8QHGGGfCT7avNetLStA0oCGGNiMdq5s1BU8wM99Wq
         cpLnFaNt5Y/WyIo/3u3hcU8KPqIxozR1VglUeMDq2sISkdEnj+wwOSJf5AiYhtT/2t
         SlMvoi2pAG8JQpJHfXVLKoIXBMd/GoSC3dKXIxNGFzZv2lBL0ArZI8WA6y2eAtJcRX
         2yzhhaPLgupPXHj9POOF9o54cYVHYP/0Hy8nP/kWQ2V3qULt/iXLK2gYREqJTs0WZH
         k57P/Xu/0fJfpnylthHNhnuqqHv1d5rI1cRLVMcxAkA8mAVUExfN6T2BKpjM/k5CMd
         yEHBV303fFSGA==
Date:   Thu, 10 Aug 2023 17:05:07 +0100
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
Message-ID: <137de09e-6341-4c97-96ca-116e40c9cb8b@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230801141319.GC26253@willie-the-truck>
 <09b7a94d-cc88-4372-85de-52db26bc2daf@sirena.org.uk>
 <20230808133857.GC2369@willie-the-truck>
 <f279ec25-e1c7-48e6-bd9d-5c753e829aad@sirena.org.uk>
 <20230810094016.GA5365@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5H6oHgjZfBXx+cAU"
Content-Disposition: inline
In-Reply-To: <20230810094016.GA5365@willie-the-truck>
X-Cookie: Reunite Gondwondaland!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--5H6oHgjZfBXx+cAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 10:40:16AM +0100, Will Deacon wrote:
> On Tue, Aug 08, 2023 at 09:25:11PM +0100, Mark Brown wrote:

> > I'm not sure that your assumption that the only people would would
> > consider deploying this are those who have deployed SCS is a valid one,
> > SCS users are definitely part of the mix but GCS is expected to be much
> > more broadly applicable.  As you say SCS is very invasive, requires a
> > rebuild of everything with different code generated and as Szabolcs
> > outlined has ABI challenges for general distros.  Any code built (or
> > JITed) with anything other than clang is going to require some explicit
> > support to do SCS (eg, the kernel's SCS support does nothing for
> > assembly code) and there's a bunch of runtime support.  It's very much a
> > specialist feature, mainly practical in well controlled somewhat
> > vertical systems - I've not seen any suggestion that general purpose
> > distros are considering using it.

> I've also seen no suggestion that general purpose distros are considering
> GCS -- that's what I'm asking about here, and also saying that we shouldn=
't
> rush in an ABI without confidence that it actually works beyond unit tests
> (although it's great that you wrote selftests!).

It defintely works substantially beyond selftests.  For the actual
distros there's definitely interest out there, gated on upstreaming.

> > In contrast in the case of GCS one of the nice features is that for most
> > code it's very much non-invasive, much less so than things like PAC/BTI
> > and SCS, which means that the audience is much wider than it is for SCS
> > - it's a *much* easier sell for general purpose distros to enable GCS
> > than to enable SCS.

> This sounds compelling, but has anybody tried running significant parts o=
f a
> distribution (e.g. running Debian source package tests, booting Android,
> using a browser, running QEMU) with GCS enabled? I can well imagine
> non-trivial applications violating both assumptions of the architecture a=
nd
> the ABI.

Android is the main full userspace that people have been working with,
we've not run into anything ABI related yet that I'm aware of - there is
one thing that's being chased down but we're fairly confident that is a
bug somewhere rather than the ABI being unsuitable.

> > > If not, why are we bothering? If so, how much of that distribution has
> > > been brought up and how does the "dynamic linker or other startup cod=
e"
> > > decide what to do?

> > There is active interest in the x86 shadow stack support from distros,
> > GCS is a lot earlier on in the process but isn't fundamentally different
> > so it is expected that this will translate.  There is also a chicken and
> > egg thing where upstream support gates a lot of people's interest, what
> > people will consider carrying out of tree is different to what they'll
> > enable.=20

> I'm not saying we should wait until distros are committed, but Arm should
> be able to do that work on a fork, exactly like we did for the arm64
> bringup. We have the fastmodel, so running interesting stuff with GCS
> enabled should be dead easy, no?

Right, this is happening but your pushback seemed to be "why would
anyone even consider deploying this?" rather than "could anyone deploy
this?", tests on forks can help a bit with the first question but your
concern seemed more at the level of even getting people to look at the
work rather than just rejecting it out of hand.

> > The majority of the full distro work at this point is on the x86 side
> > given the hardware availability, we are looking at that within Arm of
> > course.  I'm not aware of any huge blockers we have encountered thus
> > far.

> Ok, so it sounds like you've started something then? How far have you got?

I'd say thus far text mode embedded/server type stuff is looking pretty
good, especially for C stuff - setjmp/longjmp and an unwinder cover a
*lot*.  We do need to do more here, especially GUI stuff, but it's
progressing well thus far.

> While we'd be daft not to look at what the x86 folks are doing, I don't
> think we should rely solely on them to inform the design for arm64 when
> it should be relatively straightforward to prototype the distro work on
> the model. There's also no rush to land the kernel changes given that
> GCS hardware doesn't exist.

Sure, but we're also in the position where there's only been the very
beginnings of kernel review and obviously that's very important too and
there's often really substantial lead times on that, plus the potential
for need for redoing all the testing if there's issues identified.  I'd
hope to at least be able to get to a point where the major concern
people have is testing.  Another goal here is to feed any concerns we do
have into what's happening with x86 and RISC-V so that we have as much
alignment as possible in how this is supposed to work on Linux, that'll
make everyone's life easier.

In terms of timescales given that users with generic distros are a big
part of the expected audience while we're well in advance of where it's
actually going to be used we do need to be mindful of lead times in
getting support into the software users are likely to want to run so
they've got something they can use when they do get hardware.  We don't
need to rush into anything, but we should probably use that time for
careful consideration.

--5H6oHgjZfBXx+cAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTVCrIACgkQJNaLcl1U
h9BHVwgAgSbEUGUic59Pll+iHR6rMHH93h8r1BQCHM7w3dxRlH4WQAvF84q/FUw2
BvNcZc0s34e1gGq9GO3VlDPB0v1oMiJOjyjZ4V147fI5yH9YpEN93CoddrH+4Q9Z
hN/7EJ0PHxL/eaJM5EKzuAYo3iWQGg1IQRQ4XQugjYa4ID2KHo9OWVXpMTq+swnQ
pgGXC+k61Wjov3YeJwwBcZc8b9Ev2QE0T09jigsR6IRmYS+nD+LQWi2s9Utb7b+v
CE8pnWa10JCf8Or6Pft32TX975ZpuvLHvEoHdRlUHZqpl96Nj5yj9ZFX2q3Efvg1
veMSeRwi5FXGa41z5bay9s/8jeTTMg==
=NmPw
-----END PGP SIGNATURE-----

--5H6oHgjZfBXx+cAU--
