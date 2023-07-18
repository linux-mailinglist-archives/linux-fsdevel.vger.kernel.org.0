Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9958F758531
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjGRSzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGRSza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:55:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA97D123;
        Tue, 18 Jul 2023 11:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB498616AC;
        Tue, 18 Jul 2023 18:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFD5C433C8;
        Tue, 18 Jul 2023 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689706506;
        bh=g90tmctGip5JZ/qUltLRa3L/ha79p8Mr36vMSarsNto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hL9gb0hWnxYQ//PahNxf6ii3EcokNDZCUKPYDDX2Uj5Y9En1S9Qey0qZDQ2RW3P2p
         dTTMDDmfmtisD08Vic4XKPtxlGRvJPgyq8Vz7vooyeMlS1DNpBL5LhEkFy/YxE3mnd
         JGZwQRVkEFMazG6MnqCTiZ62Hf2mFE7KFIDZ1yzZpMPF9iQKXY403xt9uho3pljmBz
         dmdQAiwMPBz8emAKbWggcfJxkiAAU719bIyF0/5kw/Nu71BoYVur9E70n5SstkziYs
         8h5G21sSol6HTKBwHCSG9f3dVB8vIx3V2YTIARB0eTo6wi80Ose2YR2SPxc5OAnBn2
         l/Cl4NVx1FtQA==
Date:   Tue, 18 Jul 2023 19:54:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 01/35] prctl: arch-agnostic prctl for shadow stack
Message-ID: <45489f30-8bb7-45f1-ad09-28de4cebf406@sirena.org.uk>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
 <20230716-arm64-gcs-v1-1-bf567f93bba6@kernel.org>
 <3185fa6c37e54d26d66cd0e87e74fb5492399d78.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KcrOI5lcfTfmau0e"
Content-Disposition: inline
In-Reply-To: <3185fa6c37e54d26d66cd0e87e74fb5492399d78.camel@intel.com>
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


--KcrOI5lcfTfmau0e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 05:45:01PM +0000, Edgecombe, Rick P wrote:
> On Sun, 2023-07-16 at 22:50 +0100, Mark Brown wrote:

> > Three architectures (x86, aarch64, riscv) have announced support for
> > shadow stack.=A0 This patch adds arch-agnostic prtcl support to enable
> > /disable/get/set status of shadow stack and forward control (landing
> > pad)
> > flow cfi statuses.

> What is this about forward control flow? Seems to be just about shadow
> stack.

Sorry, that's the original commit message - the original version of this
also had support for controlling landing pads but I don't need that and
cut them out of the series.  I forgot to update that bit of the commit
message.

> > [Rebased onto current kernels, renumbering to track other allocations
> > =A0already upstream, dropping indirect LP, updating to pass arg to set
> > =A0 by value, fix missing prototypes for weak functions and update
> > title.
> > =A0 -- broonie]

> 1. PR_SET_SHADOW_STACK_STATUS seems like a strange name for the thing
> actually doing the whole enabling of the feature which involves
> allocating memory, etc. And in the future a growing array of different
> things (enabling push, write, etc).

I have no strong opinion on naming here.  _MODE?  I didn't find any
discussions around this in the=20

> 2. x86 only allows one enabling/disabling operation at a time. So you
> can't enable shadow stack AND WRSS with one syscall, for example. This
> is to make it so it's clear which operation failed. Also, since some
> features depend on others (WRSS), there would need to be some ordering
> and rollback logic.=A0There was some discussion about a batch enabling
> arch_prctl() that could report failures independently, but it was
> deemed premature optimization.

I did see that the x86 implementation required a call per flag, the
logic wasn't hugely obvious there - it didn't seem super helpful.
There's nothing stopping userspace turning one flag at a time if it
wants to, we just don't require it.  I wasn't overly concerned about the
rollback logic since I was anticipating that the main complexity is the
base enable and allocate, everything else would just be storing a mode.

We can implement things with the one bit per call approach, I just
didn't see much upside to it.  Perhaps I'm missing some case though.

> 3. It only allows you to lock the whole feature, and not individual
> subfeatures. For things like WRSS, it came up that there might be an
> elf bit, like the shadow stack one, but that works a bit different.
> Instead of only enabling shadow stack when ALL DSOs support the
> feature, it would want to be enabled if ANY DSOs require it. So
> userspace might want to do something like lock shadow stack, but leave
> WRSS unlocked in case a dlopen() call came across a WRSS-requiring DSO.

We could add either a second argument with the lock or a separate lock
prctl() and matching query which takes the same bitmask, being able
to lock per feature does give more flexibility to userspace in how we do
the locking and isn't hugely more costly to implement.  My model for
locking had been that there would be a final decision on what the
features should be, I was modelling "can enable" as equivalent access to
"is enabled" when it came to what was locked.

> 4. To support CRIU, there needed to be a ptrace-only unlock feature.
> The arch_prctl() has a special ptrace route to enforce that this unlock
> is only coming from ptrace. Is there some way to do this with a regular
> prctl()?

For arm64 we need to add a regset to expose the GCS pointer anyway so
the GCS mode is in there, though at the minute we prevent any changes at
all via that mechanism it could be implemented later.  I'm not aware of
any way for prctl() to tell if it is being invoked via ptrace so that'd
need to be dealt with somehow.

> 5. I see in the next patch there is hinted support for write and push
> as well (although I can't find the implementation in the patches, am I
> missing it?). X86 has something close enough to write, but not push.
> What is the idea for when the features don't exactly match?

The implementation is in "arm64/gcs: Implement shadow stack prctl()
interface", it just boils down to turning on or off a register bit.

> I think when Deepak originally brought up this unified prctl-based
> interface, it seemed far away before we could tell if it *could* be
> unified. Do either of you have any thoughts on whether the above points
> could be incorporated?

Other than the issue with CRIU I don't see any huge difficulty.

--KcrOI5lcfTfmau0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS24AAACgkQJNaLcl1U
h9DxkQgAgZwa9pvR8VpxobsPn+zGULF2/Agz87ptksoCHAdiehLbLFMyBPdWVlPE
VpUVG9yRkpPwF6CxIGr7eYT3bdZPRghlak/eJK+2vfEr9OBZrtn5jUDtLcYXHFEh
4zY9eSZj4uM6IEH8PR/edFhVsRmngGx2xU0Y4yqcmKXBT2S4OdfrOQQvQkKQ15eG
oZBMN4uX+3JFgQLViUMNpPj0bbkA+G4kab1alwOZiQZfZEqH1CRuPpk4CHu51Db9
8bP7/Jy0QkCO19VmDm3NC8v3vAUoECs9iGx6GzsL41fRNlNMbEy2yyTxdz4Nu4YH
/Fkhbx2eF0EG2nmwEzbQ+eAsBn/+eg==
=rIz9
-----END PGP SIGNATURE-----

--KcrOI5lcfTfmau0e--
