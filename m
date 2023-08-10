Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C34C777E4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjHJQaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjHJQaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A962728;
        Thu, 10 Aug 2023 09:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 982BB63C09;
        Thu, 10 Aug 2023 16:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC34C433C7;
        Thu, 10 Aug 2023 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691685019;
        bh=6q/Y46TIpsSPhXSxrFEF/VLkfW3O+0fXt+mKjW7zycU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBTjQqGMrvrEx1cPGNDE6eBGCUIGSu7QfnO9qJ2fxmYvkPqU3uHCMgyBgqQTf/an2
         Z+gn6DD3Hyi2/XpbY+JVY1qMgaDWQl+2hnwz0tVPTFJ/aQbIQmVZ1kcfhhPjRdTHQE
         pJIv156HmhMPVc4rUaGTnBIRVcIwyce9fqtZavbwMLCcXcb+iIRAvB+N8r6TXlneb4
         UD2iv++wxJLA1MWi34RB4oGLv7/wnHhRqPZEFzgBWFZI+EWK5VqP8eJGXk5oRzCMEx
         VVvgWtIxSwNXI117isSSjrqm7FKpRTocaPXB2KmulJEbsgbDl0ASgz97yEvHnqUTRR
         0d2hwTU0pEbDg==
Date:   Thu, 10 Aug 2023 17:30:07 +0100
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
Message-ID: <e676deee-fc7a-4f7f-8605-41b4af274c81@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
 <ZNOhjrYleGBR6Pbs@arm.com>
 <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
 <ZNSmFmYFHDw3NvvP@arm.com>
 <4e215e53-c7d1-4338-8df9-3f9bf783ced9@sirena.org.uk>
 <ZNTnTGb341TSMuvA@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N3GIhup1qS9ZN5af"
Content-Disposition: inline
In-Reply-To: <ZNTnTGb341TSMuvA@arm.com>
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


--N3GIhup1qS9ZN5af
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2023 at 02:34:04PM +0100, Szabolcs Nagy wrote:
> The 08/10/2023 12:41, Mark Brown wrote:

> > I agree that it's going to be excessive for pretty much all
> > applications, I adjusted it to match x86 as part of the general effort
> > to avoid divergence and because I was a bit concerned about non-PCS
> > cases (eg, JITed code) potentially running into trouble, especially with

> is that even possible?

> 16byte alignment is not a convention but architectural:
> access via unaligned sp traps (at least in userspace).

> it is possible to use bl such that the stack is not involved
> e.g. if there is no bl/ret pairing, but if we base the gcs
> size on the stack size then i'd expect one stack frame per
> bl/ret pair with 16byte alignment, or is there a programming
> model possible that uses 8byte stack per bl?

That's definitely what I'd expect most of the time.  You'd need to be
tracking what needs pushing in some other register but it's possible.
Quite why you'd do this is a separate question, I think I'm being overly
cautious worrying about anyone actually having done it but it wouldn't
be the first time I was surprised by someone doing something unexpected.
Like I say I think it's excessive and was erring on the side of being
conservative.

--N3GIhup1qS9ZN5af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTVEI4ACgkQJNaLcl1U
h9A4Awf/bx8Lj3RQIsL13zO6Rcr8idtjPSrfssjIBQQtk+Ytcou3d6I0srD7ZcYS
KIOrfTZRe8dRpA45iRARURQA9vzzzeS2pMY0bviaHVPz0kbfeiJ8x/PXOgLOHMkX
EV2us3XQYCNpiGAozGpIK5m8GntmZotF3bJtqK8PDxzf+ujeo361xNzQFcBX7js/
YNED0FhW8OeI/+z7ztalZM26vZw05bE2MwbJmazHCO6L/flUyNSyrk+otZdC71s0
UEVhosgX4Ba4KFRmDBvl5JiCIohdEI+k5S3vJOAZiLauPFRDQuFlrNvs1SGkHcMv
WbwxA1SwHdT5GRMpJCXjvIAWhkckqg==
=j9pJ
-----END PGP SIGNATURE-----

--N3GIhup1qS9ZN5af--
