Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034987BB76D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjJFMRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 08:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjJFMRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:17:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A555C6;
        Fri,  6 Oct 2023 05:17:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55541C433C7;
        Fri,  6 Oct 2023 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696594630;
        bh=EqGDo44ijwt3PzVq3fJt0gXvMnUdPHnl13/q3Gh+IJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6ltmfDmvp/75b1XYAh+EJYFw/UiG6APNmLiR0Md1c9oGsu9Fiy31mMH20KZXQuYw
         FKgRMGjTR644c3uzTx61Cm80OZQhHhsiyjqVSP+9hqVdDS0OVgHeu/G8tpH/31UT+b
         0YUh9zl6+KPXMGMBPuckQKhdexTkruFBEKPFFXXQBC/eLNKiLVjlv2VGlAJZHHCa0p
         lfCcMGqLD5ybTYvxe7rNBO1RZGUbORUTxeQIcTKtggoyf5KQ/ljs9Xi34jkXztew5n
         5Tr5syleMJi8nkG5skjcn/oaxRzGS0K/pDWsXyFl+a9uj+kpWutmxRROX/rZ7FFEdK
         fdZspU9mRq+gw==
Date:   Fri, 6 Oct 2023 13:17:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
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
Message-ID: <638a7be5-6662-471d-a3ce-0de0ac768e99@sirena.org.uk>
References: <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <ZOYFazB1gYjzDRdA@arm.com>
 <ZRWw7aa3C0LlMPTH@arm.com>
 <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
 <ZRvUxLgMse8QYlGS@arm.com>
 <a7d2fd66-c06b-4033-bca2-4b14afc4904f@sirena.org.uk>
 <ZR7w/mr0xZbpIPc5@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fv2LrnWqf0aiVt0H"
Content-Disposition: inline
In-Reply-To: <ZR7w/mr0xZbpIPc5@arm.com>
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


--fv2LrnWqf0aiVt0H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 05, 2023 at 06:23:10PM +0100, Catalin Marinas wrote:

> It's not just the default size that I dislike (I think the x86
> RLIMIT_STACK or clone3() stack_size is probably good enough) but the
> kernel allocating the shadow stack and inserting it into the user
> address space. The actual thread stack is managed by the user but the
> shadow stack is not (and we don't do this very often). Anyway, I don't
> have a better solution for direct uses of clone() or clone3(), other
> than running those threads with the shadow stack disabled. Not sure
> that's desirable.

Running threads with the shadow stack disabled if they don't explicitly
request it feels like it's asking for trouble - as well as the escape
route from the protection it'd provide I'd expect there to be trouble
for things that do stack pivots, potentially random issues if there's a
mix of ways threads are started.  It's going to be a tradeoff whatever
we do.

--fv2LrnWqf0aiVt0H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUf+rwACgkQJNaLcl1U
h9AHQQf7BUjbkJGRbqVL5lGyELqXE64nUXJxqNVQXzkHQ1ujZqDV/cLF9uojqJh6
yo1MngEonxyKeJjgqupcA6TzR0LGD9KvuzahtnPwSfluLAxLQG5iY2L+sA2Tdwb4
kPqoRiUS0++v1w/Oud9y0kcF6an3/im18MenqLAPGtnHPH+xE3EHipQsrYN53Fos
vsFAhXwuDhqGVonMiS+J1OxVsYZ9cRcVlStwZI0JbcCPGjS/vMUsCiE1j8ERuLYr
ZUNLyxMMQy35iW2uIdk67nRdv03mjTOw9yYr3akjxNW5eJeFrc804fBdZZ7YqrEE
Ju28oLb7xq1zQUOX3lYKlNKWsex4KA==
=iNQp
-----END PGP SIGNATURE-----

--fv2LrnWqf0aiVt0H--
