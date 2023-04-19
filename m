Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF876E795C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 14:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjDSMIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 08:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjDSMID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35112C9C
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 05:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20EA763E4A
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 12:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF81C433D2;
        Wed, 19 Apr 2023 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681906059;
        bh=28weUqf90yoOTBDAfH8y6WWRU18GLBYfAmL/4HiOwt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mpw2lTXl8aSTZSOKR+wFvJzOJZTk2UIbPO/01ldpObgvn7xTR3FjQJngos9EOuH/s
         RuPLipYjmNQWMKiGqNKRSWfZkSX3oS7qtea7A9JrdHvKeXMhQHO0pGncIzWg+hLytZ
         w4t7b4BJOaXagVUuWCKXOaeKS1wIuCFcCTfD997pMZlHV48czO5/al3AFKbJv9MUqx
         NvKtgEmXd+4siZo4ZNvLUCQCVDzZDViVPWIC7bNSQMbudbeugMZMn8t2H7PApBBjYn
         LK/rwH4pOHG8jizJJPL9TIXS5TY0KDgS6UNLrGr7+VwXvqOudtPnwzb75mFp+LrRgg
         gAavl/fFrVE8g==
Date:   Wed, 19 Apr 2023 13:07:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, sfr@canb.auug.org.au,
        hch@lst.de, Eric Biggers <ebiggers@kernel.org>,
        syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH] ext4: Handle error pointers being returned from
 __filemap_get_folio
Message-ID: <fa8f6c0a-9d72-4e13-880e-4e8865098a72@sirena.org.uk>
References: <20230418200636.3006418-1-willy@infradead.org>
 <20230418132321.4cfac3c19488c158a9e08281@linux-foundation.org>
 <ZD8F3qV6eLHZpagX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QxdnLsMbm0UQRrpt"
Content-Disposition: inline
In-Reply-To: <ZD8F3qV6eLHZpagX@casper.infradead.org>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--QxdnLsMbm0UQRrpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 18, 2023 at 10:04:30PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 18, 2023 at 01:23:21PM -0700, Andrew Morton wrote:

> > Or linux-next can carry it as one of its merge/build/other resolution
> > patches?

> That was my expectation.  Very unfortunate collision.  I'm sure Linus
> will love it.

> (Hold off on this precise version; running xfstests against it finds
> something wrong)

I can carry something easily enough, just let me know.

--QxdnLsMbm0UQRrpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ/2YUACgkQJNaLcl1U
h9A8xgf+O2dJXLQbMYCDJYQu5K3hu7fj9FuteS4R4EQVCtmeTrrNMl5V2jRlvERR
6mQ7E+Leu0U6BmsXW7U8FNnpzdNcgYGRIU9a0pNt1BYmYJX4gtiUtJKvBjT+NNXW
R7HmdmvdWoJKfYG9z4He4zxFt2jaTED89H2b9ZX5dFu0Dn1D1SGgW6aj290dmDcN
oa82yoaAOEWQAV1CjreyWkr1khOQ/F8PP8YSHDKE7RYIIi4I+ufvrD8aYUPRc43g
EqF8fkt3SQs4bAa1yxbt8eVCju9eWQPDJ5Wqv6vc7/sxCkOd2XC8zAtTrUNwPnSl
YZNk6KGDpwCNLnIYtQcKBI4OS3ygBg==
=8CCO
-----END PGP SIGNATURE-----

--QxdnLsMbm0UQRrpt--
