Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E4C781436
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379951AbjHRUP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 16:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379968AbjHRUP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:15:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B41BD4;
        Fri, 18 Aug 2023 13:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42CC860DB6;
        Fri, 18 Aug 2023 20:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FBFC433C7;
        Fri, 18 Aug 2023 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692389724;
        bh=WCt+HTyPqpQoM8uuU7vN+x57RA6ZJu12mqg0CzvfAKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWpnqpi65SH3/qdqWBn6Zd1Ci2gAJDST/B3oTk2b0QqR4KzLEHujl/2sXAp34aaQz
         rYf/Hxv4pGdxI4XtXA71/BlwdSjOlALBF8+7Nh/txVG1Pr0etLTfoxWGUJ+zGSMQ13
         12qmiSM3fn6coLaVe6HKubfVBJb5Z/QsLDUtopgpRJBemR/BlWB0eyjCHm7pxUeA6y
         yvGiBvlRhhmOnJmtqJKBgyLZHzlJhtJfhzvqoLPqNP+U1RPimemgLmIq2et3p1jWan
         qRLwKdKD5hl3mrqoXMp+UCe8E/WSmGnN+WQpVc/+3X3jhGCfNqyeGGCMUIAzmPI1DF
         i74Qa8ekO6c+g==
Date:   Fri, 18 Aug 2023 21:15:15 +0100
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
Subject: Re: [PATCH v4 19/36] arm64/gcs: Allocate a new GCS for threads with
 GCS enabled
Message-ID: <3a01ce20-3365-421b-95ff-211946808174@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-19-68cfa37f9069@kernel.org>
 <ZNZhG/4rBpTenYVH@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45mwPxvFeqYyCSA9"
Content-Disposition: inline
In-Reply-To: <ZNZhG/4rBpTenYVH@arm.com>
X-Cookie: Your aim is high and to the right.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--45mwPxvFeqYyCSA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 11, 2023 at 05:26:03PM +0100, Catalin Marinas wrote:
> On Mon, Aug 07, 2023 at 11:00:24PM +0100, Mark Brown wrote:

> > +	mmap_write_lock(mm);
> > +	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
> > +			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);

> Why not PROT_WRITE as well? I guess I need to check the x86 patches
> since the do_mmap() called here has a different prototype than what's in
> mainline.

> This gets confusing since currently the VM_* flags are derived from the
> PROT_* flags passed to mmap(). But you skip the PROT_WRITE in favour of
> adding VM_WRITE directly.

I have to confess that I inherited this from the x86 code and never
thought too hard about it.  I've got a horrible feeling the reasoning is
simply the way in which x86 fits shadow stack into the page tables
without having a mechanism like permission indirection, these don't
apply for us.

> I haven't followed the x86 discussion but did we run out of PROT_* bits
> for a PROT_SHADOW_STACK?

It's more that there are security concerns with having PROT_, especially
in conjunction with needing to provide a token for stack pivot - we not
only need to map pages for the GCS, we also need to write a cap token
into it so that we can pivot to the new stack.  If the GCS can ever be
written to by userspace via normal means then that's an issue for the
basic protection model that the feature is trying to implement.  If we
have the PROT_ but try to check for bad uses of it that makes everything
messy and complicated which is especially non-ideal for a feature with a
security focus.  Having a more packaged system call is easier for
everyone.

More detail in the x86 patch that's currently in -next:

   https://lore.kernel.org/all/20230319001535.23210-34-rick.p.edgecombe@intel.com/

> > +	/* Allocate RLIMIT_STACK with limits of PAGE_SIZE..4G */
> > +	size = PAGE_ALIGN(min_t(unsigned long long,
> > +				rlimit(RLIMIT_STACK), SZ_4G));
> > +	return max(PAGE_SIZE, size);
> > +}

> I saw Szabolcs commenting on the default size as well. Maybe we should
> go for RLIMIT_STACK/2 but let's see how the other sub-thread is going.

I've updated it.

> > +	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
> > +		return 0;

> Is it safe for CLONE_VFORK not to get a new shadow stack? A syscall for
> exec could push something to the stack. I guess the GCS pointer in the
> parent stays the same, so it wouldn't matter.

Yes, pushing should be fine just as for the regular stack.

> That said, I think this check should be somewhere higher up in the
> caller of gcs_alloc_thread_stack(). The copy_thread_gcs() function
> already does most of the above checks. Is the GCS allocation called from
> elsewhere as well?

That's the only place.  I've moved the above check into copy_thread_gcs(),
you're right that the other checks are redundant as they're done in the
caller already.

--45mwPxvFeqYyCSA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTf0VIACgkQJNaLcl1U
h9AK7Af8DxBPnoklDhEt6uL9Qzwyg5iHuvMMz45iQs74RTv9fEM/vR1B1L0U0vxL
LjcRxv98KB+GM2DQ+YOoQK84V2okcpKSNu9l/0CY+hvT8JChP5Ljn/b3azVF3FGY
QYftbzRipJONW9pKxIZ7Svx8+iZIg03PmcwJTtLRsi36gyykxlFbYhzZm/0VbWH6
HDuDWH8yMX1/BQGizf3FM7CxbBmhcI/zzi2eUslQ3EPOoSKywy4JXRc49XAvrxbT
Bu8EbBX7Oapi96h+KlZEAWSiTuD4plJ6pJQsjMdMcELiI//3sTIzNRNqmFxBIgWS
O2Sp933Ku1aQm9TW9TcOY3MVq5dYiQ==
=X4OS
-----END PGP SIGNATURE-----

--45mwPxvFeqYyCSA9--
