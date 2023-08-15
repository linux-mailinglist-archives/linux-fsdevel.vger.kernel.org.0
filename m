Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5907C77D6CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 01:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbjHOXy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 19:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbjHOXym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866A5EE;
        Tue, 15 Aug 2023 16:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 073CD62C98;
        Tue, 15 Aug 2023 23:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CCBC433C8;
        Tue, 15 Aug 2023 23:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692143680;
        bh=n6eEACiqimpPB7PLvfd+oUPFPVhzIcPuBLC1dr7dvkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxIy5vbUapbtWP3sld3mWYjZBRmjMrNODKGFDnO97nPi0kw+utGl7YhSUxRcSA55j
         bgF8O8udbd4TU+m5lMdm4Tq8mz2Iji+2duH30c7Uih+GPjDtxMtERbEdC1HkZkRbV1
         vhFKi5KpL9sjgdjBtwcn8MOqnv66AJbhzBkjh1oYLzW8TtTXJwoSBhyLhul3VdRwcO
         1WhbPKDlq0Tm06lqfY+xHm0muT2Lor4Y/lV59laZCZRREuOI6SYgQstfXcPOumpgOw
         HGCLOk+Rs8gWd4G0xWygKex2ny89KElnHHwFax3NDVcmPkRCbi5eOwwkFR7OjQVK7e
         9jsYzSH7oiqSw==
Date:   Wed, 16 Aug 2023 00:54:30 +0100
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
Subject: Re: [PATCH v4 17/36] arm64/mm: Handle GCS data aborts
Message-ID: <752f9f06-69e3-4e60-94ca-49cacb1122ff@sirena.org.uk>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
 <20230807-arm64-gcs-v4-17-68cfa37f9069@kernel.org>
 <ZNZPLTky6IZ47n4l@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bU0eg43A83FLgDHm"
Content-Disposition: inline
In-Reply-To: <ZNZPLTky6IZ47n4l@arm.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--bU0eg43A83FLgDHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 04:09:33PM +0100, Catalin Marinas wrote:
> On Mon, Aug 07, 2023 at 11:00:22PM +0100, Mark Brown wrote:

> > +		if (is_write_abort(esr) &&
> > +		    !(is_gcs_fault(esr) || is_el1_data_abort(esr)))
> > +			return VM_FAULT_BADACCESS;

> Related to my PIE permissions comment: when do we have a valid EL1 data
> write abort that's not a GCS fault? Does a faulting GCSSTTR set the
> ESR_ELx_GCS bit?

Yes, it should do.  The GCS instructions have access descriptors created
with CreateAccDescGCS() which results in the access being flagged as a
GCS access.

> > +	} else {
> > +		/*
> > +		 * GCS faults should never happen for pages that are
> > +		 * not part of a GCS and the operation being attempted
> > +		 * can never succeed.
> > +		 */
> > +		if (is_gcs_fault(esr))
> > +			return VM_FAULT_BADACCESS;

> If one does a GCS push/store to a non-GCS page, do we get a GCS fault or
> something else? I couldn't figure out from the engineering spec. If the
> hardware doesn't generate such exceptions, we might as well remove this
> 'else' branch. But maybe it does generate a GCS-specific fault as you
> added a similar check in is_invalid_el0_gcs_access().

Yes, see AddGCSRecord() and LoadCheckGCSRecord() - all GCS initiated
accesses need to be AccDescGCS so appropriate permissions enforcement
can happen and that's what causes the fault to be flagged as GCS.

> > @@ -595,6 +644,19 @@ static int __kprobes do_page_fault(unsigned long f=
ar, unsigned long esr,
> >  	if (!vma)
> >  		goto lock_mmap;
> > =20
> > +	/*
> > +	 * We get legitimate write faults for GCS pages from GCS
> > +	 * operations and from EL1 writes to EL0 pages but just plain

> What are the EL1 writes to the shadow stack? Would it not use
> copy_to_user_gcs()?

They should, yes - I'll reword the comment.

--bU0eg43A83FLgDHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTcEDYACgkQJNaLcl1U
h9A2rAgAhd1tNqwsfCv0ZnuQlRFZyTwPwFCn76BeqIuV3TYu4Nymed/YLhOECsZ9
H6Fni+Igkf4ckDfRhk742+N6QqLOBZz4ddBTJDV74NJk7EgWWv9srbi10k/thyIT
O/Wz8nVnuUHHXN3dkJIZJQ/l6GjLrzoiskqkrh9ft7HskvTTe1DOL8gFS8Qa5DjS
ut+XhC5VI7HX7iBwhhqw1tEjsQM3ldnl0r/rSd37tFbJbDX6ujuMlgpBKReSH8qV
kfrNbgpcBoxaKvE/rytuAXTIS2oqh/1yHuWi8ujBlZgGf8Vo7OK0alzL8T+oIEaQ
92UJwq3fW51GVCMDxbeaCh1vD7hrKg==
=cuH7
-----END PGP SIGNATURE-----

--bU0eg43A83FLgDHm--
