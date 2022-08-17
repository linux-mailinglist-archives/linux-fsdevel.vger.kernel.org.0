Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9DB596742
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 04:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiHQCHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 22:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbiHQCHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:07:18 -0400
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Aug 2022 19:07:17 PDT
Received: from gimli.rothwell.id.au (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C51698D0D
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 19:07:17 -0700 (PDT)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4M6rpD6n0HzyZr;
        Wed, 17 Aug 2022 12:00:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1660701655;
        bh=dtW8+2kRTTd1rXIAqfFHietP1JcPVL/dXFAV5Z7/924=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B3gicvIbPhiksqYFbDzbrusCOR+IfJfi01CCVe2eHg+IpqhRZTc7FfsNrrGwzN+ny
         zizJAeprJ2hMEi0W4b49akWqiUKlhYT3ySc8mUoZj+LEGuxbelkebrreTAtCljksnt
         VKNSAhGz5ERwPWm5vbbAEUtoPW+CNhIlPZVr9MuBgtF5Rg7I1gIBa0C8Fxhh1279aA
         vSsoUsAFbV+T9f3+3gZdtvMgQD/GFgfjV8iQ9Y9urIHBlkMEVZ/jnWgcZja+/aIo58
         yEhxinFYBcoIxIWEAo6E4gEQUHhfx9vNRmwelGAJlyqnWD5QzbOOiwppYM/cypbtbM
         GkpPulwQSjMTg==
Date:   Wed, 17 Aug 2022 12:00:51 +1000
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [next] arm64: kernel BUG at fs/inode.c:622 - Internal error:
 Oops - BUG: 0 - pc : clear_inode
Message-ID: <20220817120051.20a39b52@oak.ozlabs.ibm.com>
In-Reply-To: <CA+G9fYuLvTmVbyEpU3vrw58QaWfN=Eg8VdrdRei_jmu2Y2OzOg@mail.gmail.com>
References: <CA+G9fYv2Wof_Z4j8wGYapzngei_NjtnGUomb7y34h4VDjrQDBA@mail.gmail.com>
        <CAHk-=wj=u9+0kitx6Z=efRDrGVu_OSUieenyK4ih=TFjZdyMYQ@mail.gmail.com>
        <CA+G9fYuLvTmVbyEpU3vrw58QaWfN=Eg8VdrdRei_jmu2Y2OzOg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p7uJ_iQfq=MtmPXdTyKBMw9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/p7uJ_iQfq=MtmPXdTyKBMw9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

On Wed, 17 Aug 2022 01:09:40 +0530 Naresh Kamboju <naresh.kamboju@linaro.or=
g> wrote:
>
> On Wed, 17 Aug 2022 at 00:40, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Aug 16, 2022 at 12:00 PM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote: =20
> > >
> > > Following kernel BUG found while booting arm64 Qcom dragonboard 410c =
with
> > > Linux next-20220816 kernel Image. =20
> >
> > What kind of environment is this?
> >
> > Havign that inode list corruption makes it smell a *bit* like the
> > crazy memory corruption that we saw with the google cloud instances,
> > but that would only happen wif you actually use VIRTIO for your
> > environment? =20
>=20
> This is a physical hardware db410c device.
> Following VIRTIO configs enabled.
>=20
> CONFIG_BLK_MQ_VIRTIO=3Dy
> CONFIG_NET_9P_VIRTIO=3Dy
> CONFIG_VIRTIO_BLK=3Dy
> CONFIG_SCSI_VIRTIO=3Dy
> CONFIG_VIRTIO_NET=3Dy
> CONFIG_VIRTIO_CONSOLE=3Dy
> CONFIG_VIRTIO_ANCHOR=3Dy
> CONFIG_VIRTIO=3Dy
> CONFIG_VIRTIO_PCI_LIB=3Dy
> CONFIG_VIRTIO_PCI_LIB_LEGACY=3Dy
> CONFIG_VIRTIO_MENU=3Dy
> CONFIG_VIRTIO_PCI=3Dy
> CONFIG_VIRTIO_PCI_LEGACY=3Dy
> CONFIG_VIRTIO_BALLOON=3Dy
> CONFIG_VIRTIO_MMIO=3Dy
> CONFIG_CRYPTO_DEV_VIRTIO=3Dy
>=20
>=20
> >
> > Do you see the same issue with plain v6.0-rc1? =20
>=20
> Nope. I do not notice reported BUG on v6.0-rc1.

Is it reliable enough that you could possibly do a bisection between
v6.0-rc1 and next-20220816?

--=20
Cheers,
Stephen Rothwell

--Sig_/p7uJ_iQfq=MtmPXdTyKBMw9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL8S9MACgkQAVBC80lX
0GzZAQf7Bsp+3irXdvFTPbeYTsFim8hgA9o1L4+3TfIVF5sd1bGcCdpcN20fck2P
7viuEA5w5CXL1S2W6wzMmgKu7TwkhXHvbAGgPIGACHtGaCRjZXdix+sxlO/qX+ly
HdhuvbqFkRW2ed+fj09Ww4KJgGP8/l0zwFemnBOrqao+cwIuNfKsQdbGVyzM43hr
5PttxYZwGZvHar5BjSCqUM2MJ93i5s6frfJkreYg20gWCGaDOx3eZ468gSGPNw4t
e6G/sdlX8e2aB0hhOuF4Fjn09vp5paWMelkEjEPbBlsgRsV04PmvNjEg0nKn8haJ
0Ymh4ddoHGM2pz1ODoXplzCO8ap7uQ==
=q9S1
-----END PGP SIGNATURE-----

--Sig_/p7uJ_iQfq=MtmPXdTyKBMw9--
