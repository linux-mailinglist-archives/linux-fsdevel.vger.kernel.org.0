Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CCF4CCD94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 07:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbiCDGKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 01:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiCDGKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:10:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A332E4551F;
        Thu,  3 Mar 2022 22:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BBA361CB8;
        Fri,  4 Mar 2022 06:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB80C340E9;
        Fri,  4 Mar 2022 06:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646374187;
        bh=8mX276/TVowrNYIxcl9Oe74yHkqIqWDq/11YBBlVfgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UT0HXPsSkjri5fh3pcOnzDIyR0lKYGlZ9DIpgs/gXuhynlq/E3Tb0x1uKKKNrvaUn
         Ge+kuBoH3d2HqFv/NBFVkys4b171dOw/W7qc1PmqCkeZmK++ruk9+Oyzg0maPmNj4F
         s7Lh0Hd/0zp9thNoaTRRrJv/gTcjyeKy2/F1jUWNB9t21NWfPODOFK9vkCNWAMGL92
         XNKoBM4ZgK/XfY8gyTDhGE3S/WhGXom5AfZauYkrAv6wRMy31uodpagJTOLmuU53u9
         1upQFFj01MLGy7Ltxv+NatHvPZUDiKwVicmTBrVUQjPgqpbD1uDIlmHm3AYQDsSjqE
         VHDi9HvnoQWJw==
Date:   Fri, 4 Mar 2022 07:09:40 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>
Subject: Re: mmotm 2022-03-02-16-53 uploaded
 (drivers/i2c/busses/i2c-designware-platdrv.c)
Message-ID: <YiGtJFTy9rS7TUZe@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>
References: <20220303005351.D6F91C004E1@smtp.kernel.org>
 <e3946f3c-178f-e348-8a6f-ff3c84b79451@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nfEMyKR2EXdpovbD"
Content-Disposition: inline
In-Reply-To: <e3946f3c-178f-e348-8a6f-ff3c84b79451@infradead.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--nfEMyKR2EXdpovbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> ../drivers/i2c/busses/i2c-designware-platdrv.c:465:12: error: =E2=80=98dw=
_i2c_plat_resume=E2=80=99 defined but not used [-Werror=3Dunused-function]
>  static int dw_i2c_plat_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~
> ../drivers/i2c/busses/i2c-designware-platdrv.c:444:12: error: =E2=80=98dw=
_i2c_plat_suspend=E2=80=99 defined but not used [-Werror=3Dunused-function]
>  static int dw_i2c_plat_suspend(struct device *dev)

Thanks, we have a fix pending:

http://patchwork.ozlabs.org/project/linux-i2c/patch/20220303191713.2402461-=
1-nathan@kernel.org/


--nfEMyKR2EXdpovbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmIhrSEACgkQFA3kzBSg
KbaVPA//WVXaEI7d8347GhWFrLKDkM8GukdCyFfg6lMhEwIAKkxBh7P7QV02ZOGN
HLLNH0WQ2jf/rHbzJWdM4Je+CwIE33X+MBrcEWx6c7WtJg5anVbkiO85cDtllHsX
yTZvHrQcTPEWK6Y9/dRcDxYS/OcvICiWTmvv3Z6l9aUqiY8rjmu+GZswo3/7dgHm
R3Qu01pT6VJ1mU/LwDxaHOqaUnP6zwVIkb03H/7nqy7bjarWPVsW7+a7ytr69bVQ
GAfHRmFXZvPJeELXxz44gNVXy3ePku9zdx+DJOufjlZpOGk3NoHe966m4MiUDo4s
uKyP3LTPlHecBHMdq972G/Nej+x7wWabC5mg1M4RLEZcr0452n1IdiLHAvJP6hL9
DEcGzFmryiAjeFlf8CdYR2G6dUdAOC83GEKCvDE4yz3GN5ZRbn/4/Y29iF12s40n
Q9TXCfReLeTvB1gMUCH2TElKTkzXsainSFIQjm+YjtUv6WTV0tt9nRW0bCDpKHue
pZOWDoyDBWgO9fBGDhLySO7RfS/2l9MatU9AhQcGQzumuH9cpcjlJBj0pQGaYgzX
ilZWuwBBEKcuSzgFLsx5lDqzbaYHEmul9iE16xjNS+80cdgOlm8VhqSFLcDdON/j
wsYht0Uxp7YlJx/e6ZSo8N62o7sOLHW8B5L8Ng/VX8nwaXKw5XI=
=QW0O
-----END PGP SIGNATURE-----

--nfEMyKR2EXdpovbD--
