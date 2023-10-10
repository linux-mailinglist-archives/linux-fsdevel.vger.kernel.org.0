Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D57BFA31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjJJLri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 07:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjJJLri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:47:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB2799;
        Tue, 10 Oct 2023 04:47:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43271C433C7;
        Tue, 10 Oct 2023 11:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696938456;
        bh=dGsrZo+vQ1VzJbbq+maOQwDfORosg5+dHAq6SOZW1fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6w98R1DPjR+hK+Pvfba9+Oe+swBF1fj3sbhODwLVVzS4l0cNsbvPqOyQNlKURMDu
         6nadmgt7plrPizzdJ1voklnWCigMP4z+cRGtDLbXCHx/2WfSMk7JBIB9BF0wh8X22S
         1rSBtn7QQKsiWKay3ZeX2JPUILNKfQIuC03XZbHWENdHW++GPegW8rCBjUhHnc/He8
         60QYi96y4h0xXS2JqshRiHKYttFtMk2O/l6Hgl5Bqx5AdHjOg5b+S3lKeY+nhBWNNK
         o+BhRIn+ukTgFldxd7spQOCVf6FCTGaw825s99Q3IfZ+8HxKxT3szW5RMNhEk6DuP8
         3DvuSsMmkMm5A==
Date:   Tue, 10 Oct 2023 12:47:19 +0100
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
Message-ID: <c47d888c-e6be-47df-9ad2-af0f11fd5714@sirena.org.uk>
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-6-joey.gouly@arm.com>
 <b1e43c42-111f-43e3-9e24-89ddef76fedc@sirena.org.uk>
 <20231010095423.GA2098677@e124191.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c1gCxq1Eu5WP02VS"
Content-Disposition: inline
In-Reply-To: <20231010095423.GA2098677@e124191.cambridge.arm.com>
X-Cookie: I feel partially hydrogenated!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--c1gCxq1Eu5WP02VS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 10, 2023 at 10:54:23AM +0100, Joey Gouly wrote:
> On Thu, Oct 05, 2023 at 03:14:50PM +0100, Mark Brown wrote:
> > On Wed, Sep 27, 2023 at 03:01:08PM +0100, Joey Gouly wrote:

> > > +	if (alternative_has_cap_unlikely(ARM64_HAS_S1POE)) {

> > Why the _unlikely here?

> The only options are alternative_has_cap_{likely,unlikely}().
> I went with unlikely as currently it is unlikely!

Oh, if you have to pick one it doesn't really matter and that seems
sensible.  Usually they're optional so outside of very hot paths they
tend to be an antipattern.

--c1gCxq1Eu5WP02VS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUlOcYACgkQJNaLcl1U
h9CHBQf/ZXcCmrREeYk6HjwOAXBpILDhJEYF552Me/bljo1xHTcfrJ29itnqdzJd
tJO760glWJ/CT+tmsH2Td0cYKaRZENARTmvlIpF0Dn0gUkdvusyYk8MD7s+2gmx1
BaKOAAD0/WcE+4bWknMiYw7au2dFq6unT9xlXJY5ykHubP5YS/EqRrMBM+AEKpY/
tnnjr5FboCv+867dluZHV4RGf09RsTf48iGGGJZjpKmoCB1I4UKMP9PfRJ492+dS
Dy9i0DtFr+dq552w6Sk5FhUV9tsvf5RD0XNUu73vQnBDFQ9TgCkzLOwnjaC/nxh7
2OLfAXCgeMqpBYoe5PHtp6VuSE9Qiw==
=Qpeh
-----END PGP SIGNATURE-----

--c1gCxq1Eu5WP02VS--
