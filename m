Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6D4C3B7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 03:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiBYCML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 21:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiBYCMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:12:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114BD17E0C;
        Thu, 24 Feb 2022 18:11:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65E496152D;
        Fri, 25 Feb 2022 02:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA73C340E9;
        Fri, 25 Feb 2022 02:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645755093;
        bh=7/NWWWGZmubchTDBTFX0t3ZLHY9P4rfU+SUXOhgm+mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuHGcWubRB7o+glyFi2f73c1Kf0GYq25E0WCTibEINXlKL1ctV/45hWjBRjq3picC
         nVgSsezU6NhaBlwDxE8dgaRV5mPS1nLuhIlbG/bKbcuXB51dsEX/vH60txc9CUMDIc
         GaCEneign/ch/gcpjK83pKU3B8z3XxbV5bhztRPF1ThxQVvCROj2CYGkFqwFdLOpCV
         R2+0sf/q7cRGdnQyM2JNkC3rJ4GvQRCsoq8yA90EwuNA04aIgFntuMgEQ9Z3b0KaJF
         JoXD0v71k1SGwH+5ZvDj5Q5xUV1386M9EQLcJZ73ugkTZHSRSrCSLJ9Tbg2dH1EhEO
         1kAyMY7ZrQjcA==
Date:   Fri, 25 Feb 2022 02:11:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: mmotm 2022-02-23-21-20 uploaded
Message-ID: <Yhg60P06ksKTjddP@sirena.org.uk>
References: <20220224052137.BFB10C340E9@smtp.kernel.org>
 <20220223212416.c957b713f5f8823f9b8e0a8d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lUvLP3GXLpu2Xwy5"
Content-Disposition: inline
In-Reply-To: <20220223212416.c957b713f5f8823f9b8e0a8d@linux-foundation.org>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lUvLP3GXLpu2Xwy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2022 at 09:24:16PM -0800, Andrew Morton wrote:
> On Wed, 23 Feb 2022 21:21:36 -0800 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
>=20
> > The mm-of-the-moment snapshot 2022-02-23-21-20 has been uploaded to
> >=20
> >    https://www.ozlabs.org/~akpm/mmotm/
> >=20
>=20
> Below is how I resolved the fallout from jamming today's linux-next
> back on top of the MM queue.

Thanks, this was enormously helpful (there's a bunch of embarrassing
merge fixups in the tree today, but they're all driver error with me fat
fingering the scripts).

--lUvLP3GXLpu2Xwy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIYOs8ACgkQJNaLcl1U
h9CmgQf9FsPQwYEVn1aJ75UG8xJW7002CfpJTz23mA0EtEfQh8LbimuVns3H2IGu
2kib7VN9CqpI7srhitHuw3pI4E3oobYWtTTUhMZqEMOcLg9zIcDiCV4bY6ack4D/
8R0TR5eLjyypgC1L8xEikFNXUbAvQfVwgrtrU/XauXC85DsIPjGtj+gUFXlxt4tV
Ip05B6zd8BbPGpiZLo4Kb45mXyHQrSQ4TZrqE5FOz3J7baSYp8rAdmgilXXFSNOR
FKDawuaznrj/unpGrRrkRQB2dbCoiVqEvDS4wiyhL+sq/1AvheKqkuoCKeu9tZBj
OZt2qR8i2pvP52YtMnpvLSe2rPAaXw==
=dNB1
-----END PGP SIGNATURE-----

--lUvLP3GXLpu2Xwy5--
