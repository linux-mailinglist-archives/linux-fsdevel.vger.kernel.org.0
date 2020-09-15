Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0926B2BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgIOWwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:52:41 -0400
Received: from ozlabs.org ([203.11.71.1]:42063 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbgIOWwZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 18:52:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Brdln15Ryz9sSs;
        Wed, 16 Sep 2020 08:52:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1600210343;
        bh=EPzAMIcHsLtJmMMKyEMteGFNclnevagytfnflOTYbfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GbYM1BL9fvc61W6wXdnQUb86KCCHjKfW4hg8Ln8O+7SiSzCSgYwcq144/xZq64DyR
         znMao3PBbpaZ1eUAp2UeyhCy5XC5WHiUKEE6WtsMUKUWZ4D1n09rJSM2XlfnJ60Nkt
         81223glfSux2yRfeFArzZILTBG7zIhlXQmPbgNJGEzQZrvkUM4vgHj+siCSS9J7eEo
         OfTqlBBRTwC+q/y9crODmaSESwfMTtgYdOKHgVWsPy/LoZP7V5x9FcOa33ZLGXms/2
         NcoZdQLsfytDz7WQbQDqHkPkLCPOS6VTrSWscpNLidHUAUrnftIBe32Nkvpa7/gnKv
         HbzSJHg0Zoy9g==
Date:   Wed, 16 Sep 2020 08:52:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        gandalf@winds.org, Qian Cai <cai@lca.pw>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: RIP:
 0010:shmem_getpage_gfp.isra.0+0x470/0x750
Message-ID: <20200916085220.4906a985@canb.auug.org.au>
In-Reply-To: <20200915131048.GF5449@casper.infradead.org>
References: <CA+G9fYvmut-pJT-HsFRCxiEzOnkOjC8UcksX4v8jUvyLYeXTkQ@mail.gmail.com>
        <20200914115559.GN6583@casper.infradead.org>
        <20200915165243.58379eb7@canb.auug.org.au>
        <20200915131048.GF5449@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oUjubHQkRs3rJ5X8Uo5nyMt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/oUjubHQkRs3rJ5X8Uo5nyMt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Sep 2020 14:10:48 +0100 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Tue, Sep 15, 2020 at 04:52:43PM +1000, Stephen Rothwell wrote:
> > I have applied that to linux-next today. =20
>=20
> Thanks!  Can you also pick up these two:
>=20
> https://lore.kernel.org/linux-mm/20200914112738.GM6583@casper.infradead.o=
rg/
> https://lore.kernel.org/linux-mm/20200914165032.GS6583@casper.infradead.o=
rg/

I have added both those to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/oUjubHQkRs3rJ5X8Uo5nyMt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9hRaQACgkQAVBC80lX
0GymTgf6AxNAk5p0NU6ylCs1AaisXUyjZOsIm92KIniATCh88zPrBEDwE+OSVifu
ABAomXzcCaSWrkyzofL2UXZ8lusXm03nx95KaqCox7Eyc2RmGMgyCE81swVkfk9D
oefLZWlksKLwDBnAJ/ClhUHIgM4yLkmIwPJAnN+JMjgJpFya9aEyaXkFjqjoab9e
uHJW+i2GtT1ZmkhdpCCU8b4Iou0hs0QqHHA7hgMDrqgwk/SVQNUiKpXVscSUyYzM
f4NWOoY9MNmzPyhDqZWdSSc8s0z1Y69FmHEsYi59VuCRJoPDbIAcmy9ZE4+j3/sn
K+Lqu1Z0DyfS5YYRUQTfMyfaksmuuA==
=nbxA
-----END PGP SIGNATURE-----

--Sig_/oUjubHQkRs3rJ5X8Uo5nyMt--
