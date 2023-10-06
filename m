Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663527BB8F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjJFNXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJFNX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:23:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B8E83;
        Fri,  6 Oct 2023 06:23:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6A1C433C8;
        Fri,  6 Oct 2023 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696598608;
        bh=EaTnbJI4I15tCsE5PAEOFEMV2gEpZ5O8xv29SdDb+qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7kN1bhYCxtxsrayiH2/Qvakhgo3xCg+wGyDWqoba/ZC5pHVgpQDCCyLUBMq5h54g
         ECPy9lW5VnfDNKExrrh7fEdQi/U/bsZ892xqQHM3S72mb56W82U4MfmqpjVIrrIJyB
         qr4LzQDOov95/YlKhpIXNX+7KimqRGoyORxBH1I2m/XYsnYxcLtqw4e1YjQNFIDBA5
         tnW4b6DBxOSfdtiaDHBr9QAGaSCEQWZ729s1flrAd+bmsOCjhqUZ+msIzUEQjcpObI
         fcYAdK0dvdOg+7/O/AD46RjkpZyTdrX3BsQGRWK8UKSyIfp93PxVJs9Zo8bm/vRFfv
         hsYBCwh6ppprg==
Date:   Fri, 6 Oct 2023 14:23:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
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
        linux-riscv@lists.infradead.org,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <b100a80c-4460-4258-92b8-d232f553cab6@sirena.org.uk>
References: <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <ZOYFazB1gYjzDRdA@arm.com>
 <ZRWw7aa3C0LlMPTH@arm.com>
 <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
 <ZRvUxLgMse8QYlGS@arm.com>
 <a7d2fd66-c06b-4033-bca2-4b14afc4904f@sirena.org.uk>
 <ZR7w/mr0xZbpIPc5@arm.com>
 <638a7be5-6662-471d-a3ce-0de0ac768e99@sirena.org.uk>
 <87y1ggylvq.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ji8GpeD8VVTZwCCT"
Content-Disposition: inline
In-Reply-To: <87y1ggylvq.fsf@email.froward.int.ebiederm.org>
X-Cookie: Rome wasn't burnt in a day.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Ji8GpeD8VVTZwCCT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 06, 2023 at 07:29:45AM -0500, Eric W. Biederman wrote:
> Mark Brown <broonie@kernel.org> writes:

> >> It's not just the default size that I dislike (I think the x86
> >> RLIMIT_STACK or clone3() stack_size is probably good enough) but the
> >> kernel allocating the shadow stack and inserting it into the user
> >> address space. The actual thread stack is managed by the user but the
> >> shadow stack is not (and we don't do this very often). Anyway, I don't
> >> have a better solution for direct uses of clone() or clone3(), other
> >> than running those threads with the shadow stack disabled. Not sure
> >> that's desirable.

> > Running threads with the shadow stack disabled if they don't explicitly
> > request it feels like it's asking for trouble - as well as the escape
> > route from the protection it'd provide I'd expect there to be trouble
> > for things that do stack pivots, potentially random issues if there's a
> > mix of ways threads are started.  It's going to be a tradeoff whatever
> > we do.

> Something I haven't seen in the discussion is that one of the ways I
> have seen a non-libc clone used is to implement a fork with flags.
> That is a new mm is created, and effectively a new process.  Which
> makes the characterization different.

> In general creating a thread with clone and bypassing libc is
> incompatible with pthreads, and the caller gets to keep both pieces.

> As long as there is enough information code can detect that
> shadow stacks are in use, and the code is able to create their own
> I don't see why it shouldn't be the callers responsibility.

> On the other hand I don't see the maintainer of clone Christian Brauner
> or the libc folks especially Florian cc'd on this thread.  So I really
> don't think you have the right folks in on this conversation.

Well, copying them in now.  The discussion here is about allocation of
shadow stacks for the arm64 implementation of the feature (the arm64
feature is called Guarded Control Stack in the architecture).  These
maintain a second copy of the stack with only the return targets in
memory allocated with special protections so userspace can't write to it
directly and use this when doing returns to ensure that the returns
haven't been redirected.  These shadow stacks can be allocated directly
by userspace using a new system call map_shadow_stack(), doing this via
mmap() was extensively discussed but it was concluded that this was very
likely to lead to security problems so we've got this new syscall that
ensures that shadow stack memory is never accessible to userspace via
other means.

The x86 implementation that has already been merged into mainline will
allocate a new shadow stack for newly created threads when the creating
thread has one.  There was a suggestion to have arm64 diverge and
require that threads be created with clone3() and manualy provide a
shadow stack but then concerns were raised that as well as the issues
with divergence this would be too disruptive for adoption due to
non-libc thread creation.  It's not controversial that it'd be good to
have clone3() by able to explicitly specify a shadow stack, just if it
should be required.

--Ji8GpeD8VVTZwCCT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUgCkUACgkQJNaLcl1U
h9DirQf/ftVM53t8n7Iz/c70/XaZOa6o2/1qaxs00hlLIEkmuVk5LjL0TViJlfRw
qIRUvbR8y9MkOCjJOTAErDvidq4rFwmPiuk9mFZViDpRkDxpG13xvHCHIqZ4NPUe
Eve09ZqsJK5dCaW8G4/FCkSIZF2yD1lGttWRhYwckUPBSHMVZevuylvin7vdrWAr
sPCe3qp4gWYgplUtfxKadGeowpldz9LRCbARrBYB1jqSXcJbskcDd0L3KUH9ElFv
kYT+Iyoh0j36gEZFuwWXioYTEbQcD5qsqcftvc5LW0vRiUlKo/MUND/c07YdRoBy
DfP12K7+lLpdbS17lq6f6DfTuLAwcg==
=J8v2
-----END PGP SIGNATURE-----

--Ji8GpeD8VVTZwCCT--
