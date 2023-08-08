Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE5774CB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjHHVOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjHHVO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B66EF08;
        Tue,  8 Aug 2023 13:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E447662972;
        Tue,  8 Aug 2023 20:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642B0C433C7;
        Tue,  8 Aug 2023 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691526321;
        bh=smwaBn/3bhNSBudLMySHNd7VdPh0ay51eRzjOUAiv8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7qPau380MtqBH1YfBjf3ydSe5ZPYOXHkvrPUe9NueiqGF06irfTF61HfBlWIgEFM
         Xene2NE0cZsbfc2/THaiH2McN+fJdiUtfouEeeC+uTCqNKj3ibgNrxGiBbpzXM2Rfr
         SLP2dNBoB4rAy2dAR+EjA+W5kuwIc3bsOHQmGjDMAjdbaal6lB4m2K1kA6RktTFbmO
         02t7XsWWSbtTXvIUWrk8iMcnEOIvFO7Y/cWPTnAO+6lk64SAs11bpXJ/uRCtzNh6CR
         cFThQj0MCTV2OyT9PlJbicNhDswQ0VbfX2XhKiU6rRGAMW/+MAkZniDHdnmuLuo+LK
         255m/CZ2eUo6w==
Date:   Tue, 8 Aug 2023 21:25:11 +0100
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
Message-ID: <f279ec25-e1c7-48e6-bd9d-5c753e829aad@sirena.org.uk>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
 <20230801141319.GC26253@willie-the-truck>
 <09b7a94d-cc88-4372-85de-52db26bc2daf@sirena.org.uk>
 <20230808133857.GC2369@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iuCE+Z3sT2tGztq"
Content-Disposition: inline
In-Reply-To: <20230808133857.GC2369@willie-the-truck>
X-Cookie: You need not be present to win.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--2iuCE+Z3sT2tGztq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 02:38:58PM +0100, Will Deacon wrote:

> But seriously, I think the question is more about what this brings us
> *on top of* SCS, since for the forseeable future folks that care about
> this stuff (like Android) will be using SCS. GCS on its own doesn't make
> sense to me, given the recompilation effort to remove SCS and the lack
> of hardware, so then you have to look at what it brings in addition to
> GCS and balance that against the performance cost.

> Given that, is anybody planning to ship a distribution with this enabled?

I'm not sure that your assumption that the only people would would
consider deploying this are those who have deployed SCS is a valid one,
SCS users are definitely part of the mix but GCS is expected to be much
more broadly applicable.  As you say SCS is very invasive, requires a
rebuild of everything with different code generated and as Szabolcs
outlined has ABI challenges for general distros.  Any code built (or
JITed) with anything other than clang is going to require some explicit
support to do SCS (eg, the kernel's SCS support does nothing for
assembly code) and there's a bunch of runtime support.  It's very much a
specialist feature, mainly practical in well controlled somewhat
vertical systems - I've not seen any suggestion that general purpose
distros are considering using it.

In contrast in the case of GCS one of the nice features is that for most
code it's very much non-invasive, much less so than things like PAC/BTI
and SCS, which means that the audience is much wider than it is for SCS
- it's a *much* easier sell for general purpose distros to enable GCS
than to enable SCS.  For the majority of programs all the support that
is needed is in the kernel and libgcc/libc, there's no impact on the
code generation.  There are no extra instructions in the normal flow
which will impact systems without the feature, and there are no extra
registers in use, so even if the binaries are run on a system without
GCS or for some reason someone decides that it's best to turn the
feature off on a system that is capable of using it the fact that it's
just using the existing bl/ret pairs means that there is minimal
overhead.  This all means that it's much more practical to deploy in
general purpose distros.  On the other hand when active it affects all
code, this improves coverage but the improved coverage can be a worry.

I can see that systems that have gone through all the effort of enabling
SCS might not rush to implement GCS, though there should be no harm in
having the two features running side by side beyond the doubled memory
requirements so you can at least have a transition plan (GCS does have
some allowances which enable hardware to mitigate some of the memory
bandwidth requirements at least).  You do still get the benefit of the
additional hardware protections GCS offers, and the coverage of all
branch and ret instructions will be of interest both for security and
for unwinders.  It's definitely offers less of an incremental
improvement on top of SCS than it is without SCS though.

GCS and SCS are comparable features in terms of the protection they aim
to add but their system integration impacts are different.

> If not, why are we bothering? If so, how much of that distribution has
> been brought up and how does the "dynamic linker or other startup code"
> decide what to do?

There is active interest in the x86 shadow stack support from distros,
GCS is a lot earlier on in the process but isn't fundamentally different
so it is expected that this will translate.  There is also a chicken and
egg thing where upstream support gates a lot of people's interest, what
people will consider carrying out of tree is different to what they'll
enable.  Architecture specific feedback on the implementation can also
be fed back into the still ongoing review of the ABI that is being
established for x86, there will doubtless be pushback about variations
between architectures from userspace people.

The userspace decision about enablement will primarily be driven by an
ELF marking which the dynamic linker looks at to determine if the
binaries it is loading can support GCS, a later dlopen() can either
refuse to load an additional library if the process currently has GCS
enabled, ignore the issue and hope things work out (there's a good
chance they will but obviously that's not safe) or (more complicatedly)
go round all the threads and disable GCS before proceeding.  The main
reason any sort of rebuild is required for most code is to add the ELF
marking, there will be a compiler option to select it.  Static binaries
should know if everything linked into them is GCS compatible and enable
GCS if appropriate in their startup code.

The majority of the full distro work at this point is on the x86 side
given the hardware availability, we are looking at that within Arm of
course.  I'm not aware of any huge blockers we have encountered thus
far.

It is fair to say that there's less active interest on the arm64 side
since as you say the feature is quite a way off making it's way into
hardware, though there are also long lead times on getting the full
software stack to end users and kernel support becomes a blocker for
the userspace stack.

> After the mess we had with BTI and mprotect(), I'm hesitant to merge
> features like this without knowing that the ABI can stand real code.

The equivalent x86 feature is in current hardware[1], there has been
some distro work (I believe one of the issues x86 has had is coping with
a distro which shipped an early out of tree ABI, that experience has
informed the current ABI which as the cover letter says we are following
closely).  AIUI the biggest blocker on userspace work for x86 right now
is landing the kernel side of things so that everyone else has a stable
ABI to work from and don't need to carry out of tree patches, I've heard
frustration expressed at the deployment being held up.  IIRC Fedora were
on the leading edge in terms of active interest, they tend to be given
that they're one of the most quickly iterating distros. =20

This definitely does rely fairly heavily on the x86 experience for
confidence in the ABI, and to be honest one of the big unknowns at this
point is if you or Catalin will have opinions on how things are being
done.

[1] https://edc.intel.com/content/www/us/en/design/ipla/software-developmen=
t-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-=
processors-datasheet-volume-1-of-2/009/shadow-stack/

--2iuCE+Z3sT2tGztq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTSpKYACgkQJNaLcl1U
h9Bm7wf/TWEY6FZexKo9ZslcLVc8FfZTGr2JbqBTjc0hIyi6JIvIUPaBtV8B4GKh
aJOvjQlkWGfIrVsezaRToCVgoxhsnRmsKCDr1gABiWQuJDCL5mLR1BRMF6XfJC+g
FANZz3+vabPD5HlypgtGUsdgtm1d3vPwRnOcI1XK5ARt53I+3Wbd1Gc/Kzsv8qz2
KmEbIIR0tk/KpUJwAokBaHnsH6pnZKxUDy0Ei3i9zFBtcRjqWOJSgjJ0fKKscJQa
uIKhZ7no7GVtdNnfO1XBllyefendmwyKNc9QdFsNgE3WgXy2iiaMbWmp4JJU6GHr
BamhHq9n+PvDZVvrISCsTZxmnjcGVg==
=YAxR
-----END PGP SIGNATURE-----

--2iuCE+Z3sT2tGztq--
