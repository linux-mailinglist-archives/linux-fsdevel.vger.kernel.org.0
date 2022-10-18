Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDE602388
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 06:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJREzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 00:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJREzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:55:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35986525F;
        Mon, 17 Oct 2022 21:55:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ms1l168BWz4xFy;
        Tue, 18 Oct 2022 15:55:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666068926;
        bh=CRrHBDsNdrBb28hzgQhlrZd26ZKphtFKLFjDwU/ABaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KoC6hrmzAs9HidJRRxkubIdSZ+CjOXbnqlKmiHN7K59O4vyWF8oo7vyiGEjyg7cjM
         j9OfGRfnR4pdnCe9OvqaTMWdp3Nh9N4O6NDTIi7tQDrRHuJpfWswZRBizWuWkpLraD
         T8/8zHB9obIaN+1OkMvUam8/bJvmm4Vp0YGFRSIS2chyfJObRcOgUXMm7IWZW+JV31
         d6yXY9OxqMxwPepR6E2dTpRBFoM3s+6EXJS9ypIHF0f+/gUr1Qihyah9UO9arldiSe
         bBQ8e3h6lXBihlsh6XhoNxGpldR6cG2UsZSpxg4Yv2h1xearu5CHhfU0i9qSeV47x7
         sfeLbfH8NQ8eg==
Date:   Tue, 18 Oct 2022 15:55:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 0/8] make statx() return DIO alignment information
Message-ID: <20221018155524.5fc4e421@canb.auug.org.au>
In-Reply-To: <20220913063025.4815466c@canb.auug.org.au>
References: <20220827065851.135710-1-ebiggers@kernel.org>
        <YxfE8zjqkT6Zn+Vn@quark>
        <Yx6DNIorJ86IWk5q@quark>
        <20220913063025.4815466c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ta.nZamROACWUZnFj4i7MWy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/Ta.nZamROACWUZnFj4i7MWy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 13 Sep 2022 06:30:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Sun, 11 Sep 2022 19:54:12 -0500 Eric Biggers <ebiggers@kernel.org> wro=
te:
> >
> > Stephen, can you add my git branch for this patchset to linux-next?
> >=20
> > URL: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
> > Branch: statx-dioalign
> >=20
> > This is targeting the 6.1 merge window with a pull request to Linus. =20
>=20
> Added from today.

I notice that this branch has been removed.  Are you finished with it
(i.e. should I remove it from linux-next)?

--=20
Cheers,
Stephen Rothwell

--Sig_/Ta.nZamROACWUZnFj4i7MWy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNOMbwACgkQAVBC80lX
0GxBPwf+NK66Affcx+uOwICiv+ovQ21QIlPm9IJ5LvIoFwf8a6p0CBBV0D87Lz3O
gTyOmmIln6foey0EDLUonmx0R/g/NmDIqlmlTokCTOS3W06Rg+Q/ura6Xy2e16yX
jkvcXxu3VueNdLN/MgKin6PjnB77DyhjPo1xuyXxHE39/XO0h8vTMY9OL44Zg8E9
ZEnV4lTb/mUKb1DU0SiFrM2hcFfCG09gEnUGsA7P/dQnwrHHkD+vWPDsX5yWHX3P
bKtAFYG/Z17S8nIzUbQG+A19u19ajcQasGjV8jDLEERPDX3bOg91nR33ahR4rfQb
T/Xadfe0rtdAKEqBLhNafzUpmGIqxg==
=DyWQ
-----END PGP SIGNATURE-----

--Sig_/Ta.nZamROACWUZnFj4i7MWy--
