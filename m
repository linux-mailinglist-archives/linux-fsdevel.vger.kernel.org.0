Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4877BA14A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbjJEOmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjJEOiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD2759E5;
        Thu,  5 Oct 2023 07:03:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28900C433B7;
        Thu,  5 Oct 2023 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696514628;
        bh=HKEZ6beykV1U+Zd/ammwjoPfpwchP/HWcBClUf6tGDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tb2hd8/59F3EGqO2PeHBLPnaUltp9QPbpc/YPVoMYRWuz2nADY1Qy7vrrpl2mRQIb
         f7RKpsRwB703gUz4fXn9ci4U6kC/HA9L0PdP2haH5FL0kpbEeol771Rz7LfjJixADQ
         SBQGyDdywWTFiD07O6nSvbdGBojyvdFXrxHRI3E+jCg8QDvSE260E7KQ+5rMdxJ1WR
         vcBGE6aoVS9BTuxHxrRCOo2koE2Mz0kaHLEotZ1f72utflOgkfEl44ixmXWIz87r+q
         4VvjohcEn4Ary/q//s3QWLYCOpjgFIa08gGZYCA5qLYieMXrrC15Ed8ZdJ0dmzzBAs
         0UT+YStWRnkJA==
Date:   Thu, 5 Oct 2023 15:03:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, oliver.upton@linux.dev, shuah@kernel.org,
        will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 01/20] arm64/sysreg: add system register POR_EL{0,1}
Message-ID: <f38e79f6-6438-4b0c-a657-480ed0479f98@sirena.org.uk>
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-2-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6yvKGWcAk0ykRJu"
Content-Disposition: inline
In-Reply-To: <20230927140123.5283-2-joey.gouly@arm.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--e6yvKGWcAk0ykRJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2023 at 03:01:04PM +0100, Joey Gouly wrote:
> Add POR_EL{0,1} according to DDI0601 2023-03.

Reviewed-by: Mark Brown <broonie@kernel.org>

--e6yvKGWcAk0ykRJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUewj0ACgkQJNaLcl1U
h9ADfgf+Ki6+gWK2XcfP39+dtpYe/a8jjwMcGAUdiVwp0vcPomk15O6tivRlxM0O
5hqF6Ljm/V/CmnvDDwP/KhIKEGthRALQ21F5y4wQl32IAP1thaJIgxWxOW5NFpi2
o7YCJ5TdJRxV+hX7ElE8FDddzwgBmQnfgbq2KG/8GSRF7WnRKkA7ET/DfArqPsmr
2A6u+iFklSjTovg9ilQ8WnUmiDh75lFy6fKx9hKPqAxZgFWXQ0KHhO+M3NltqzXO
CBPuRl1pFsh+IY2cgsuiHSGutcX31GnOG9OQlX7iQJ79uksPAS1ErCCYhZtuJ3h/
2yloNgPkQagISx3bXbOVavzFuwjwzg==
=EdOr
-----END PGP SIGNATURE-----

--e6yvKGWcAk0ykRJu--
