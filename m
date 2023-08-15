Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD977D69B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 01:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbjHOXWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 19:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbjHOXWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063C10D1;
        Tue, 15 Aug 2023 16:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30C6636E4;
        Tue, 15 Aug 2023 23:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10725C433C7;
        Tue, 15 Aug 2023 23:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692141719;
        bh=reNBqXvvCRZMEH5t3EgVMW5ozRlNJXzgVYKKybLu7+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgYMWvchg/ZUqerIoW+zuO2xrgHp1FjGhIDZf0F7H37BKlHJkiszeodbSFqj3PnGp
         f2uzSQKMyEbBKULD8jUYoWdw+ho2gUgqSPoCpiRRthF97i2hw0AwvOvxRHsnoMNSWD
         gttYLq9bj0BRRJjSljAXyHOfxgy/c0FWZkAugtCSLC0HoJVzRQ6itwmObiMg7S3MLp
         eLTfOBH3K1elFZpgkk9Fi0gRg+xjIRhvBg9Be+iT1N4YlVOZfGuGiWElQwXi9Y4FXf
         FmuAbbOC05PmLzx2GVJ9olOkny6MKI0EpIV4w8sjVE8FBzZs45FzNtmCLwuIp0+0j3
         XjZluhZGnyksA==
Date:   Wed, 16 Aug 2023 00:21:49 +0100
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
Subject: Re: [PATCH v4 09/36] arm64/mm: Allocate PIE slots for EL0 guarded
 control stack
Message-ID: <74cb7458-cdf9-4e7d-972a-3dc81e92ec22@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-9-68cfa37f9069@kernel.org>
 <ZNZEUEqJuHrdEa/c@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RanKLfAULhx4GKnc"
Content-Disposition: inline
In-Reply-To: <ZNZEUEqJuHrdEa/c@arm.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--RanKLfAULhx4GKnc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 11, 2023 at 03:23:12PM +0100, Catalin Marinas wrote:

> >  #define PIE_E1	( \
> > +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_RW)      | \
> > +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_R)      | \

> Had some thoughts on this. Why do we need the EL1 GCS attributes to map
> to RW? The instructions we'd use to write the shadow stack are the GCS
> 'T' variants that run as user already.

> The only instructions we have in the kernel that would run as EL1 on a
> user address are the exclusives (futex code or the old deprecated
> emulation but we don't care about them in this context). So I wonder
> whether the kernel PIE entry could simply be PIE_NONE_O. Would this be
> too restrictive for future uses? Given the coherency between a GCS
> access and a standard data access, we may want to restrict it now until
> we have a use-case.

Good point.  I remember I originally wrote that before I checked into
how things like copying pages for ptrace worked but they don't keep
the GCSness of the page so they're fine.

I don't think we need to worry about future uses since these are slots
reserved for GCS use, if we need a different value later

--RanKLfAULhx4GKnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTcCI0ACgkQJNaLcl1U
h9DbgQf/R35NwygifYB/vR8xKnzjHMpwxWKaHX9I5Hinl2E99odV20pM/bgJZbux
VbIehF+i+Q/QY+dvRrVAvp4oVfOY4ZFJQRtPrLjGoak9Au980nkR6mlKggF6qd4W
EGfizM1nkmqrTmfm8vHfn/gEDGJ/ZRB9mOzZmvW8U41g6naodsr9S/0ChKLV1ppq
IEwo7oiwLNc9Uz1lklKsyq5852jWL3B07QwDzubwM7CJC2UNLQywl8SMW7We551y
ZtE6twEw91+iq9dcBOKkFi+Oay55UKC4eSrci/08sbb1b4lH5Ta9YoiSEDaCqxXm
cB6WkJJkkCL7RY0qBvEEDSWx1WqolQ==
=XTlC
-----END PGP SIGNATURE-----

--RanKLfAULhx4GKnc--
