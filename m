Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4E7BE37B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbjJIOti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjJIOth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:49:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A4A3;
        Mon,  9 Oct 2023 07:49:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C75C433C8;
        Mon,  9 Oct 2023 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696862976;
        bh=MSivuo8AKmLVLL5BhIEYGzpxs7sNu4scT3T+p4zcemc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arSRzQASZCM61uyG5UNNz0oX5n+yrneIH1O4kajySq+txAE5n7374cLDr4YU+donp
         Pu2A0W/6GYgakZhpZKz6uc5tqfI6zE9SoMUMnrSsgZ8gwMAXucX1WrEwrr2sCn51Vg
         eMk1tejZZ8PEQAwGGeS5o7tdvc2mVBAHg8K0hvDRbk/IAgp+dAh7H8W/dpUxCUhISi
         +Yf3emEUX/VnwzprwkSWlgnuxPSF6OMtnxqVgQYuTM0/C2qD7hagnM5gILiL6TSLAp
         mzluUf9RJm79G+L4Fr066DkxQmlv3LZHAz78TA4RsUXQ2z61JbcnpjVg2RsAIpvVHC
         9MHKddnlx8oqQ==
Date:   Mon, 9 Oct 2023 15:49:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, oliver.upton@linux.dev, shuah@kernel.org,
        will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 15/20] arm64: add POE signal support
Message-ID: <9fd11f36-3987-4f45-94be-7cf89a05ad04@sirena.org.uk>
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-16-joey.gouly@arm.com>
 <a6e6c8a3-15b1-48e3-84fa-810ce575c09a@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmKS1l7Zjsd4RYgP"
Content-Disposition: inline
In-Reply-To: <a6e6c8a3-15b1-48e3-84fa-810ce575c09a@sirena.org.uk>
X-Cookie: What is the sound of one hand clapping?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--nmKS1l7Zjsd4RYgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 05, 2023 at 03:34:29PM +0100, Mark Brown wrote:
> On Wed, Sep 27, 2023 at 03:01:18PM +0100, Joey Gouly wrote:
> > Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.

> It'd be nice to have at least a basic test that validates that we
> generate a POE signal frame when expected, though that should be a very
> minor thing which is unlikely to ever actually spot anything.

Actually, now I think about it we at least need an update to the frame
parser in userspace so it knows about the new frame.  Without that it'll
warn whenver it parses the signal context on any system that has POE
enabled.

--nmKS1l7Zjsd4RYgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUkEvgACgkQJNaLcl1U
h9AVigf9GW/Sur/45PGTLZb/7jQO+xOnDx1zRfo2IrXNG3IyiCvy6MJbw4Wv1Me+
ggms5XnKqT0GLbnGF/OKAODHgjJj4hF3aSGtBk7/bockrXXG3xiUamZrQrGUjsmN
d+Q/1QqnNT3uw+VDK19MmpcSpEChFwiEkjqXll4dGoPzedG0OaGcnOG1P/qZeMre
lsNGs5TaxU6CCmmXeFblLiNusTDroowNsgBI52wN5Y2c56fxOljdzTvgqdiMfHoC
d25fd46QkLNVA7YZBsDz3ILcv09PJ7FBeiLO5K2deQN9QbNgvGPgW0mkhrcRNAgZ
MTyYe0dvsQn3/Bj85noS1xH4idZ7OQ==
=e4nN
-----END PGP SIGNATURE-----

--nmKS1l7Zjsd4RYgP--
