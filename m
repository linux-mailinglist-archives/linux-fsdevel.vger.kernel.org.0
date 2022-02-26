Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E34C531D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 02:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiBZBoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 20:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBZBoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:44:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7658673DC;
        Fri, 25 Feb 2022 17:43:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5685FB81F83;
        Sat, 26 Feb 2022 01:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8CBC340E7;
        Sat, 26 Feb 2022 01:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645839810;
        bh=V9ttdSjn6UUrGKE25w061dNm0P8WHEsABbEFmKTz3Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hulgvFrh2VmT00A49MRB2U0nfcnyj7Ke0PuJUSbPOTOG46n6juiAkt+2cBvBoy2V6
         Ub00ivENz41Ha/Vqo/0R0SOiawbNZbpRz5bGYUiim8rOhniX7gM+i521hGlOP4lEOX
         ODuGM7kxKvbrNyDBr1iw5L2l5cU8ahiJmzTrCHKDBV4lfm9/PUmimrvDOf8Zv16y+o
         rqdLfuh/C89kYzC1KZmp9oSJIhpkrnxLRf9v50mszQbRAvHCv9TZjkMILnydIa7m8B
         Ik77s1cqU/+ndpcQehgqeJ+GvqajKP+6+/kXWQvG/nBJ7WpS+q0sQl5/8Bm6ftCcgE
         8A5cSEBiWk/nw==
Date:   Sat, 26 Feb 2022 01:43:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: mmotm 2022-02-23-21-20 uploaded
Message-ID: <YhmFvOb9kE3P8FTC@sirena.org.uk>
References: <20220224052137.BFB10C340E9@smtp.kernel.org>
 <20220223212416.c957b713f5f8823f9b8e0a8d@linux-foundation.org>
 <Yhg60P06ksKTjddP@sirena.org.uk>
 <20220224223701.4dd5245b08feb3e85a1be718@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oRzq/BJu9ALQxAcc"
Content-Disposition: inline
In-Reply-To: <20220224223701.4dd5245b08feb3e85a1be718@linux-foundation.org>
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


--oRzq/BJu9ALQxAcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 10:37:01PM -0800, Andrew Morton wrote:

> And today's fix-all-the-rejects patch is below that.
>=20
> I'll upload all this in 2 secs...

Thanks, this (together with the update for Maple) have helped things go
a lot smoother today.

--oRzq/BJu9ALQxAcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIZhbsACgkQJNaLcl1U
h9DoJAf/Q3KW1y3Keb7BH7/UU6H3GId65zUoIsYSikXJO1pHm/URBg2CKT4K4gek
/mYxmFMAsPcGK8KhZdGI+90jEE0rSgbjdFnn4B0tMBpbboPFOtbgffTpLfgMske0
qobBIiM5rhM4tSO22RcAFmjtFSl/DvsJdTo0lb1aFQbxJQYpD3c/i1y9mdjT2cZR
VRY8lzAyicZZzZ4ahbttwi0isQuSSI0En6PEWTNGenmZjNWGjHZYx93eOolPGRLS
zos3RHbTK63I8LU5JCbKXMmtVCMavUAINrq0cBnu9Wh+TZHH2gweI/+IOorET2BY
WkbMSoxOYnf7rsie4cUAoLGeKt6/Hw==
=uRx5
-----END PGP SIGNATURE-----

--oRzq/BJu9ALQxAcc--
