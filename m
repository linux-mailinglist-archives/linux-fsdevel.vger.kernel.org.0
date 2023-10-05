Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88C17BA12A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjJEOno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbjJEOk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:40:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B029B31;
        Thu,  5 Oct 2023 07:14:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C7CC43397;
        Thu,  5 Oct 2023 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696515297;
        bh=nZ2pQOUK1xxCQH8F9rUTMa70XO6gjHFBAjV0L7xLvLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/3oqz6L0PP/o7CzLKBlV9IstV7GdqYsIOhHkOf7881CYhujPH4Xo9jAQV9vlXdbf
         atjwhOs0mbg0dI/BknjgmeVxqCsvQFYT92lhaCTz3TizCZxFLiJAgPtpZbCw2YHUbP
         tKAhEmwYlC7JgANOh7aodswZAsQHnfJAFZmq6sxlNFYjJd7XsECJ0/Ru7szVzCz1WU
         ZHW4XKMSsaOGXWDxzV2eLNPhvORwm0Gzn2z7Z41KbEk2x3OiBXZx00tC2aRQuJ6fsR
         a7IBL6wekJ+8cSyjJqXr2x1ux2g6gzgoZ4YAivHYhalfYwOrUPSGscyo32Ufn8UdVF
         6nU44bEEg2FyA==
Date:   Thu, 5 Oct 2023 15:14:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, oliver.upton@linux.dev, shuah@kernel.org,
        will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 05/20] arm64: context switch POR_EL0 register
Message-ID: <b1e43c42-111f-43e3-9e24-89ddef76fedc@sirena.org.uk>
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-6-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4H61ssqIvNduKjuy"
Content-Disposition: inline
In-Reply-To: <20230927140123.5283-6-joey.gouly@arm.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4H61ssqIvNduKjuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2023 at 03:01:08PM +0100, Joey Gouly wrote:

> +/* Initial value for Permission Overlay Extension for EL0 */
> +#define POR_EL0_INIT	UL(0x7)

Might be useful to explain why this is the default (and possibly also
define in terms of the constants for POR values)?

> +static void permission_overlay_switch(struct task_struct *next)
> +{
> +	if (alternative_has_cap_unlikely(ARM64_HAS_S1POE)) {

Why the _unlikely here?

--4H61ssqIvNduKjuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUexNoACgkQJNaLcl1U
h9CQ+wf/eLvm0CgQ5tFcdi0/EMV/QJXOwQ3Pb8kGAib65/Ata6WMaKI1N2beahsU
VTMz/iPUnZXCok+njXMxfoF4O1FjDeho8dLcBSWfh5S9DRAvhvmIBbRkmJODaTFN
j2uSWM4RlVZ5LNxnvynwMXSdVILPAsaDIVEMQLqNGE3J74VUv/TRO6wZtmMk63WJ
Y9y1PsJ6Sr9IVrZ2cavoG5eVqs3EsnlrZSPjJ1ka27So6JTH11ehf3o2kZOUeStI
VrPGQbIvi84UKyag5Za1tuUPkf6oqJhTYT32Z2PCvl0DKiwhfI83M6WbphaNExdG
YhLY8PLIbi/ZatgqpS2eg+SlLPdA2w==
=kkEH
-----END PGP SIGNATURE-----

--4H61ssqIvNduKjuy--
