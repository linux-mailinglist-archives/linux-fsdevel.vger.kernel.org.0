Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6178C7BA114
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjJEOpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbjJEOmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:42:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B968743C;
        Thu,  5 Oct 2023 07:17:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0F1C433B7;
        Thu,  5 Oct 2023 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696515462;
        bh=n2SbN3LMmLtZSE9PVJTmDtknegCSiJstyBqH3Zf/Plw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBVx2hbugpQP6jkbd1ITw5gHrz3tnj33L0Bd5xv8ZAjC611wa6q9MyhqiemN9sb6i
         pSSE+7llKq8sYdUkF3g7B+tdZrnW7kDEC9S0wZLzi9aPKWXYE1T5JriSGFWheO4L5r
         vIVfSNh0TOx/AHl+AArbb9A15ZpsKCYAYjJkJzI4vPyaXdBPBl8UU/L5NbHCAVY3yT
         uZoL5JSJFwylejnRveHP8whZksWmrSf+nJmFSahNdNtVTMDL+wb099jb1/NIaIxQW3
         L4MM1/m1v+q6kuNS8889jwKaw7o0KSScSd/rPL6+hLBArNISqA3kzMfNDtDI0c59Jd
         s3G0dkOcWRvrA==
Date:   Thu, 5 Oct 2023 15:17:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, oliver.upton@linux.dev, shuah@kernel.org,
        will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 07/20] arm64: enable the Permission Overlay Extension
 for EL0
Message-ID: <421c6b38-4187-4a61-9374-bf0bd4774be4@sirena.org.uk>
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-8-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PE37tXSahyYmW1f1"
Content-Disposition: inline
In-Reply-To: <20230927140123.5283-8-joey.gouly@arm.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--PE37tXSahyYmW1f1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2023 at 03:01:10PM +0100, Joey Gouly wrote:
> Expose a HWCAP and ID_AA64MMFR3_EL1_S1POE to userspace, so they can be used to
> check if the CPU supports the feature.

Please also add the new hwcap to the hwcaps self test.

--PE37tXSahyYmW1f1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUexX8ACgkQJNaLcl1U
h9CMDQf+I3vcui8ynX5ItP/OcgACY7EBmFwb2StucUHwswBNVsj+nKXT2ayn6xps
bW5+7X6b0b/CRko8xIHEw3VzJqyx88nIZV6IKJPJo9PlmIQtFnV3sJ5s2AFMOu4j
C3MYASrlImEzYrcsa8uYSV0jFfEJ7TQUhBiVWS1LJHUnExw6AiaYK3SF4AzHQCxw
ds0e9t++hMWhEfMUACE0XtAYz0RBqNEjetJvPSHFzXZJ47P99RX0wl/ci1WIDcR1
s2ZGUsyZHBTLt0U5+YKQf9f3RNJghEUn/YZnpyv6ITRwEYWYqhIlZtndkZF0D+9v
N00f45ZUZBUQQz1A6RhqRDgO7DOcQQ==
=og9J
-----END PGP SIGNATURE-----

--PE37tXSahyYmW1f1--
