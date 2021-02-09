Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D473147C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 06:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBIFDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 00:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBIFDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:03:01 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FC5C061786;
        Mon,  8 Feb 2021 21:02:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DZW385xCmz9sS8;
        Tue,  9 Feb 2021 16:02:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1612846939;
        bh=Csow+kkuJ/2yUX44H5MgA6XuUlNeuqlukseReSX30x4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XE8ck3uVokA0ODM3KcFJmqOCfKM+lkfFoQ4WGkpXXpGuHpt9mvpPfSUAZv0Clzkon
         ZWIzWQLdBU0+Zqoydovkx/CI3NpSAclytXQpyzwhj6alUBsEt2mxuO3wTwsdofgWgJ
         JBo5IDcx6bII/LRS1P3w4Visbd4mL/WO+UCRQEkxCMHx/nAzfihqhYJHRU4yTpkanO
         Ite0cho14Hmo3I81R713aGUOVdPfHIPHB6JAJR1E/JT8/5ZXRYwWVumIjVHLNINDG/
         Xtna+vYh1xW+5rV3fQNRySVPY1ia6arMnV15z+Xu5iI5Mk4d4+ld0yvR3njhsU2kDh
         gVJC/qDZe6NLg==
Date:   Tue, 9 Feb 2021 16:02:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org,
        linux-media <linux-media@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?UTF-8?B?U8O2ZGVy?= =?UTF-8?B?bHVuZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: mmotm 2021-02-08-15-44 uploaded (drivers/media/i2c/rdacm2*.c)
Message-ID: <20210209160208.2fc39c2b@canb.auug.org.au>
In-Reply-To: <2a0149a9-b1ae-6d41-f4d7-04108fcd1431@infradead.org>
References: <20210208234508.iCc6kmL1z%akpm@linux-foundation.org>
        <2a0149a9-b1ae-6d41-f4d7-04108fcd1431@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LCnxAV6p98/IHSm75GQt19j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/LCnxAV6p98/IHSm75GQt19j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Mon, 8 Feb 2021 20:20:04 -0800 Randy Dunlap <rdunlap@infradead.org> wrot=
e:
>
> on x86_64:
> CONFIG_VIDEO_RDACM20=3Dm
> CONFIG_VIDEO_RDACM21=3Dm
>=20
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_set_s=
erial_link' exported twice. Previous export was in drivers/media/i2c/rdacm2=
0-camera_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_confi=
gure_i2c' exported twice. Previous export was in drivers/media/i2c/rdacm20-=
camera_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_set_h=
igh_threshold' exported twice. Previous export was in drivers/media/i2c/rda=
cm20-camera_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_confi=
gure_gmsl_link' exported twice. Previous export was in drivers/media/i2c/rd=
acm20-camera_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_set_g=
pios' exported twice. Previous export was in drivers/media/i2c/rdacm20-came=
ra_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_clear=
_gpios' exported twice. Previous export was in drivers/media/i2c/rdacm20-ca=
mera_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_enabl=
e_gpios' exported twice. Previous export was in drivers/media/i2c/rdacm20-c=
amera_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_disab=
le_gpios' exported twice. Previous export was in drivers/media/i2c/rdacm20-=
camera_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_verif=
y_id' exported twice. Previous export was in drivers/media/i2c/rdacm20-came=
ra_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_set_a=
ddress' exported twice. Previous export was in drivers/media/i2c/rdacm20-ca=
mera_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_set_d=
eserializer_address' exported twice. Previous export was in drivers/media/i=
2c/rdacm20-camera_module.ko
> WARNING: modpost: drivers/media/i2c/rdacm21-camera_module: 'max9271_set_t=
ranslation' exported twice. Previous export was in drivers/media/i2c/rdacm2=
0-camera_module.ko

This was reported in yesterday' linux-next and is being worked on.

--=20
Cheers,
Stephen Rothwell

--Sig_/LCnxAV6p98/IHSm75GQt19j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmAiF1AACgkQAVBC80lX
0GzVXwf/TACeaLB1CkSR2gSOvl86oSx/35+hVAKWAKfALSEWzENXuI0vB6yDbChm
0/Tlr0m28p9fbt9PT0lNLCnAZWHuXpg/pbgaKSlV1cw5wyGILajRxqOkPAXYlsqR
/CwPjCAPjmgxiD7OToDKWwm7mYFI+S037QlrSrni1xE1rdnjxykHxCzyFlIecu0i
RAq2U5hqlV57cP7Q6+XILX2MXRXEr4ofatRGB7Xi7gqQ9boPQsrIarSAYfiwHGL5
bn1R8Am8im/0LX8uJoC3+kaJGdtbKIMt5K0b8zvNHk6wJsamZbigeXPJbh7h7lLE
FA5/3lmrMqZicd4jUIf9pxfbVxoXmw==
=gQzm
-----END PGP SIGNATURE-----

--Sig_/LCnxAV6p98/IHSm75GQt19j--
