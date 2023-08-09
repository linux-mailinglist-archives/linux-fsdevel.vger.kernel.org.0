Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FFF7763F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 17:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjHIPfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjHIPff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C466B213C;
        Wed,  9 Aug 2023 08:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0571A63E2D;
        Wed,  9 Aug 2023 15:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAB4C433B8;
        Wed,  9 Aug 2023 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691595287;
        bh=dKpu3DrXlm0fcz/rfbAZnwwY50NvEJw3wKrHilJuxpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+F3tEWJa1ouT3AAeoGwCGDIPVHr8mvewuF9Wv6D3my1b3McT3/boQUwB/4TbUk0B
         kNoEtkqrlkQGWOLC+eAHPeWdquspwCEu1jOP2DLJPyKtjBxqre7G5Gt6s4ZyA+8FUj
         ksjRNloIJXzwHov4xxKk0bR+odlEBkyc9WWw+8Q7LwINdLKAlMo8eHt7sgp2mo0zSP
         6yf4N/N5mQgfkKZNTyeTdpVV8jY50VyORSbm56bg69m/U7esSLYFGhLNopS1fXoXH6
         pZPiq1xcaVBJo5pvOVIcoNTdFhmai7aajMmEDmFbfAJtYhs4C5iTw2HYO9neLymlEh
         iUgc170PfSA4g==
Date:   Wed, 9 Aug 2023 16:34:38 +0100
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
Message-ID: <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k90euu3QCpA7JsXx"
Content-Disposition: inline
In-Reply-To: <ZNOhjrYleGBR6Pbs@arm.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--k90euu3QCpA7JsXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 03:24:14PM +0100, Catalin Marinas wrote:
> On Mon, Aug 07, 2023 at 11:00:08PM +0100, Mark Brown wrote:

> > +* When set PR_SHADOW_STACK_ENABLE flag allocates a Guarded Control Sta=
ck for
>=20
> The 'for' at the end of the line above is not needed.
>=20
> > +  and enables GCS for the thread, enabling the functionality controlle=
d by

I find it a little clearer that it's a per thread stack here but sure.

> > +* PR_LOCK_SHADOW_STACK_STATUS allows any bit to be locked, this allows
> > +  userspace to prevent changes to any future features.

> I presume a new lock prctl() won't allow unlocking but can only extend
> the lock. I haven't looked at the patches yet but it may be worth
> spelling this out.

Yes, there is no unlock prctl() - the lock prctl() just lets you set
locks.

> > +* If GCS is disabled for a thread after having previously been enabled=
 then
> > +  the stack will remain allocated for the lifetime of the thread.

> Sorry if this has been discussed in other threads. What is the issue
> with unmapping/freeing of the shadow stack?

If something was in the middle of looking the GCS (eg, you're trying to
disable GCS during signal handling that preempted something that is
logging the call stack) and you pull the GCS storage from underneath it
then things will go badly.

> > At present
> > +  any attempt to reenable GCS for the thread will be rejected, this ma=
y be
> > +  revisited in future.

> What's the rationale here? Is it that function returns won't work?

We have to work out where to point GCSPR_EL0 when reenabling - at the
top of the old stack, where it was before, on a new stack?  It was
easier to just not support reenabling than to work out what the sensible
answer is when it's not clear that any real use case exists to inform
what makes sense.  We can add support for that later (you can probe by
starting a thread, disabling and trying to reenable) if someone does
come up with a use case.

The use case for disabling is a non-enforcing mode which logs GCS faults
and then disables GCS.

> > +3.  Allocation of Guarded Control Stacks
> > +----------------------------------------

> > +* When GCS is enabled for a thread a new Guarded Control Stack will be
> > +  allocated for it of size RLIMIT_STACK / 2 or 2 gigabytes, whichever =
is
> > +  smaller.

> Is this number based on the fact that a function call would only push
> the LR to GCS while standard function prologue pushes at least two
> registers?

It's actually based on bitrot that I'd initially chosen a smaller value
since it's likely that functions will push at least something as you
suggest, the patches now just use RLIMIT_STACK.  I'll fix.

> > +* When GCS is disabled for a thread the Guarded Control Stack initially
> > +  allocated for that thread will be freed.  Note carefully that if the
> > +  stack has been switched this may not be the stack currently in use by
> > +  the thread.

> Does this not contradict an earlier statement that the GCS is not freed
> for a thread when disabled?

Yes, it was meant to say when the thread is freed rather than when GCS
is disabled.

> > +* When GCS is enabled for the interrupted thread a signal handling spe=
cific
> > +  GCS cap token will be written to the GCS, this is an architectural G=
CS cap
> > +  token with bit 63 set.  The GCSPR_EL0 reported in the signal frame w=
ill
> > +  point to this cap token.

> I lost track of the GCS spec versions. Has the valid cap token format
> been updated? What I have in my spec (though most likely old) is:

>   An entry in the Guarded control stack is defined as a Valid cap entry,
>   if bits [63:12] of the value are same as bits [63:12] of the address
>   where the entry is stored and bits [11:0] contain a Valid cap token.

You have a draft version of the spec, this was changed and now there is
now a token field reserved in the low 12 bits of the register:

#define GCS_CAP_ADDR_MASK		GENMASK(63, 12)
#define GCS_CAP_ADDR_SHIFT		12
#define GCS_CAP_ADDR_WIDTH		52
#define GCS_CAP_ADDR(x)			FIELD_GET(GCS_CAP_ADDR_MASK, x)

#define GCS_CAP_TOKEN_MASK		GENMASK(11, 0)
#define GCS_CAP_TOKEN_SHIFT		0
#define GCS_CAP_TOKEN_WIDTH		12
#define GCS_CAP_TOKEN(x)		FIELD_GET(GCS_CAP_TOKEN_MASK, x)

#define GCS_CAP_VALID_TOKEN		0x1
#define GCS_CAP_IN_PROGRESS_TOKEN	0x5

#define GCS_CAP(x)	((((unsigned long)x) & GCS_CAP_ADDR_MASK) | \
					       GCS_CAP_VALID_TOKEN)

--k90euu3QCpA7JsXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTTsg0ACgkQJNaLcl1U
h9AEfQf+Ka4G6z9Nm1kf+b/l5pKI+rrhbAQGaG8LsctIW9PfOqcL34gYTSwCEcFC
yc7FLvXwOykuy/dMOwhEPvohyCsS/fvouc1WLRs/T1Ur11kjMYjJaMnrLIafdJRC
AH7esh4KGfFfzcq6O2WaLjk/wSLVMF7ZemDSQJwb1zC8tACwL/ycJNx3xi/LgCjn
uegBSqenG7Ehp7OuPFBeZmfL1yMQ5g5GGrF3ga5swfXgxDmne+0X0pXCqoqyQURH
B/4075gZXjwuMcraFsVPFQEdlk4nZNl4BEEdV9IGHXKIBWe1qKOTIFc14Jvt3U5/
AhfIuxGumWGmrTlP/ZBjaZUJaMuFlA==
=LF8s
-----END PGP SIGNATURE-----

--k90euu3QCpA7JsXx--
