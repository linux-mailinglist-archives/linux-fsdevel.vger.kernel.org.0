Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95BB3FFDB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 06:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfKRFB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 00:01:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35675 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfKRFB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 00:01:58 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191118050155epoutp0130bffa48d274e5a282d1a6b1b016ea9b~YKSaFYFZu1629816298epoutp01z
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2019 05:01:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191118050155epoutp0130bffa48d274e5a282d1a6b1b016ea9b~YKSaFYFZu1629816298epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574053315;
        bh=qksj5JNafUQD7T0YTU4PSfjGdwkAqHXbjyCJ9qhsiw0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HXm45ytkoW7YOsw+g13x5vV70sElTE66vBnNEck5O/yhh/KgrRSEW7k0+hA7fJc5O
         E5HSbBoqk4rtJ2DXjjWcviYV/SnpxNT2v5k8fRqk09oEhWSePqwv7MO9yAe/QLVIlc
         97roy8dUAuHolU1q4ESOiItmSE+8ofmyGe/6C734=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191118050154epcas1p261e7951d6195935094efc70996d192ff~YKSZra_yw1771717717epcas1p2h;
        Mon, 18 Nov 2019 05:01:54 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47GcJ14vWGzMqYkr; Mon, 18 Nov
        2019 05:01:53 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.69.04235.1C522DD5; Mon, 18 Nov 2019 14:01:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191118050153epcas1p105bffdc3150b251c38a8ad63dafed33d~YKSYVfv5t1248312483epcas1p1q;
        Mon, 18 Nov 2019 05:01:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191118050153epsmtrp28f3ce52f8aead0bf2d51f175647edb0d~YKSYUlu9a0884708847epsmtrp2d;
        Mon, 18 Nov 2019 05:01:53 +0000 (GMT)
X-AuditID: b6c32a36-e07ff7000000108b-31-5dd225c17e40
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.97.03654.1C522DD5; Mon, 18 Nov 2019 14:01:53 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191118050153epsmtip2b3e0b7bfe6f2cfd6c7f9eb4ab5575713~YKSYHQK0O2724527245epsmtip2C;
        Mon, 18 Nov 2019 05:01:53 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Markus Elfring'" <Markus.Elfring@web.de>,
        <linux-fsdevel@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linkinjeon@gmail.com>
In-Reply-To: <9e9bac40-109c-3349-24da-532c540638c2@web.de>
Subject: RE: [PATCH 02/13] exfat: add super block operations
Date:   Mon, 18 Nov 2019 14:01:52 +0900
Message-ID: <00bb01d59dcd$4b1791b0$e146b510$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJi6SbXrz5yzPSQA/jPnFS4rCJd9wF2fS/BAWpS4fimXsFCgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0hTYRjHec/Zzo7S4rQsn1RinRhdRN2cm6dyJRWyTMJKiAKxg542aTd2
        pl0/GEWaimXOD55Kyq5aZIjZKk2z0iwMsyw0irIoszJLvJRlbZ5Ffvs97/v/P5f3QuIKDxFC
        ZtpcnNPGWmgiUFJ3Z5E64raqM1Xd36Ni9p+uJpjKi/cw5mpPKPP8ZQ/O1De0SZgnN44TzB/h
        g5SpnbgrZTq/DkriA4zXhZcyY+OJSzLjze4cwlhUW4WMQzVzjc3XPhPGF+/rJMmyLZY4M8dm
        cE4lZ0u3Z2TaTAZ67ca0VWk6vVoToVnCxNJKG2vlDPTqpOSIhEyLtzNamc1asrxLySzP01HL
        45z2LBenNNt5l4HmHBkWh0btiORZK59lM0Wm261LNWp1tM6r3Goxe84MYY4vYTs/PjiL5aDC
        sHwUQAIVAx3D56X5KJBUUB4E7no3IQbfEdSMt+JiMILg59ly2T9LS2ml39KAoOB0gd/Sj2Dw
        XLHUpyKoCJj41Uj4OIhaD7nFZTKfCKcuYJB/YAjzbQRQS6Gyq0ni45lUHLjfliAfSygVtD8V
        JsvJqSXQNlKLiTwD2sreTepxKhzOnfqEiy0pwdP+CYnFVsKvvgq/JgiOHTro1+TKYPioS+TV
        8Gzkkn+cmdDfWuvnEBgaaPA2TXp5D3xr9FvzEPSNGkTWQnf1FalPglOLoPpGlLg8D66Pn0Bi
        1ekwMFwoFbPIIe+gQpSooKjzDiZyKOTnDsqOIFqYMpcwZS5hSv/C/2InkaQKzeYcvNXE8RpH
        9NTLrkGTr3ax3oMqHiU1I4pE9DT56x2PUxVSNpvfZW1GQOJ0kHxdb0eqQp7B7trNOe1pziwL
        xzcjnffYi/GQWel27x+wudI0umitVsvE6GP1Oi0dLCfHvHkoE+vitnOcg3P+82FkQEgOuquf
        cA+WBpfYulPn0HsNsqbHwqipU7EpUd6XV2n9PZ6Sa76/bYPi/mWs6EjX9lusO9F0IHJh+MCc
        JyXxm8urnhcsO/9whiEh9JmQUte+oNXBdh2avyI74dVh6qMJ29exJ7ZclT2W96N+TdKj3sBv
        TZ7wGrnxDdNyz7zlYnBJWEodLeHNrGYx7uTZv00VNqbLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSvO5B1UuxBrfuclk0L17PZrFy9VEm
        i623pC2u373FbLFn70kWi8u75rBZ/J/1nNViy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD2KyyYlNSezLLVI3y6BK6NlyXHmgi6RijPHXrE1MPYJ
        dDFyckgImEgcm7qStYuRi0NIYDejxIYXPSwQCWmJYyfOMHcxcgDZwhKHDxdD1LxglJi2rosZ
        pIZNQFfi35/9bCC2iECgRPvEmewgRcwCa5gklp9fhjD13uTDYB2cAlYSK68eANsgLGAjMeXx
        ZEYQm0VAVeLslVnsIDavgKXEyW9bmCBsQYmTM5+A1TMLaEv0PmxlhLGXLXzNDHGpgsSOs68Z
        Ia5wkvjzYhFUvYjE7M425gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAMC+1XK84
        Mbe4NC9dLzk/dxMjOO60NHcwXl4Sf4hRgINRiYfXoupirBBrYllxZe4hRgkOZiURXr9HF2KF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYMzZEfTvOVNr
        2uNv//4pHFkfL6G1tSpb+9+x5a0Mhb5bWXbPEYm2ny7F/it1seuqKusJzNa957fMWpThlPyo
        N9V5hmny2hRt2RyGaO4V0bJbA/cJfrSMXLtG+PStxEjj33KL9y5MyQn+ue3/xF6mj4GPSoT0
        4yeadEbnz1kzf8PkbJ8ze/YxtiuxFGckGmoxFxUnAgAsXo2StwIAAA==
X-CMS-MailID: 20191118050153epcas1p105bffdc3150b251c38a8ad63dafed33d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191117133037epcas1p31f9cec445144e2193a2d2deac144f797
References: <20191113081800.7672-3-namjae.jeon@samsung.com>
        <CGME20191117133037epcas1p31f9cec445144e2193a2d2deac144f797@epcas1p3.samsung.com>
        <9e9bac40-109c-3349-24da-532c540638c2@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> =E2=80=A6=0D=0A>=20>=20+++=20b/fs/exfat/super.c=0D=0A>=20=E2=80=A6=0D=0A>=
=20>=20+static=20int=20exfat_show_options(struct=20seq_file=20*m,=20struct=
=20dentry=20*root)=0D=0A>=20>=20+=7B=0D=0A>=20=E2=80=A6=0D=0A>=20>=20+=09se=
q_printf(m,=20=22,fmask=3D%04o=22,=20opts->fs_fmask);=0D=0A>=20>=20+=09seq_=
printf(m,=20=22,dmask=3D%04o=22,=20opts->fs_dmask);=0D=0A>=20=0D=0A>=20How=
=20do=20you=20think=20about=20to=20combine=20these=20two=20function=20calls=
=20into=20a=20single=20one?=0D=0A>=20=0D=0A>=20=0D=0A>=20>=20+static=20int=
=20__exfat_fill_super(struct=20super_block=20*sb)=0D=0A>=20>=20+=7B=0D=0A>=
=20=E2=80=A6=0D=0A>=20>=20+=09=09exfat_msg(sb,=20KERN_ERR,=20=22unable=20to=
=20read=20boot=20sector=22);=0D=0A>=20>=20+=09=09ret=20=3D=20-EIO;=0D=0A>=
=20>=20+=09=09goto=20out;=0D=0A>=20=E2=80=A6=0D=0A>=20=0D=0A>=20Would=20you=
=20like=20to=20simplify=20this=20place?=0D=0A>=20=0D=0A>=20+=09=09return=20=
-EIO;=0D=0A>=20=0D=0A>=20=0D=0A>=20=E2=80=A6=0D=0A>=20>=20+=09=09exfat_msg(=
sb,=20KERN_ERR,=20=22failed=20to=20load=20upcase=20table=22);=0D=0A>=20>=20=
+=09=09goto=20out;=0D=0A>=20=0D=0A>=20Would=20you=20like=20to=20omit=20this=
=20label?=0D=0A>=20=0D=0A>=20+=09=09return=20ret;=0D=0A>=20=0D=0A>=20=0D=0A=
>=20>=20+static=20int=20exfat_fill_super(struct=20super_block=20*sb,=20stru=
ct=20fs_context=20*fc)=0D=0A>=20>=20+=7B=0D=0A>=20=E2=80=A6=0D=0A>=20>=20+=
=09=09exfat_msg(sb,=20KERN_ERR,=20=22failed=20to=20recognize=20exfat=20type=
=22);=0D=0A>=20>=20+=09=09goto=20failed_mount;=0D=0A>=20=0D=0A>=20The=20loc=
al=20variable=20=E2=80=9Croot_inode=E2=80=9D=20contains=20still=20a=20null=
=20pointer=20at=20this=20place.=0D=0A>=20=0D=0A>=20*=20Thus=20I=20would=20f=
ind=20a=20jump=20target=20like=20=E2=80=9Creset_s_root=E2=80=9D=20more=20ap=
propriate.=0D=0A>=20=0D=0A>=20*=20Can=20the=20corresponding=20pointer=20ini=
tialisation=20be=20omitted=20then?=0D=0A>=20=0D=0A>=20=0D=0A>=20=E2=80=A6=
=0D=0A>=20>=20+failed_mount:=0D=0A>=20>=20+=09if=20(root_inode)=0D=0A>=20>=
=20+=09=09iput(root_inode);=0D=0A>=20=E2=80=A6=0D=0A>=20=0D=0A>=20I=20am=20=
informed=20in=20the=20way=20that=20this=20function=20tolerates=20the=20pass=
ing=0D=0A>=20of=20null=20pointers.=0D=0A>=20https://git.kernel.org/pub/scm/=
linux/kernel/git/torvalds/linux.git/tree/fs/i=0D=0A>=20node.c?id=3D1d4c79ed=
324ad780cfc3ad38364ba1fd585dd2a8=23n1567=0D=0A>=20https://protect2.fireeye.=
com/url?k=3D34e5568f-697957ef-34e4ddc0-0cc47a31307c-=0D=0A>=207f9b30869a6ff=
aa4&u=3Dhttps://elixir.bootlin.com/linux/v5.4-=0D=0A>=20rc7/source/fs/inode=
.c=23L1567=0D=0A>=20=0D=0A>=20Thus=20I=20suggest=20to=20omit=20the=20extra=
=20pointer=20check=20also=20at=20this=20place.=0D=0A>=20=0D=0A>=20=0D=0A>=
=20>=20+static=20int=20__init=20init_exfat_fs(void)=0D=0A>=20>=20+=7B=0D=0A=
>=20=E2=80=A6=0D=0A>=20+=09err=20=3D=20exfat_cache_init();=0D=0A>=20+=09if=
=20(err)=0D=0A>=20+=09=09goto=20error;=0D=0A>=20=0D=0A>=20Can=20it=20be=20n=
icer=20to=20return=20directly?=0D=0A>=20=0D=0A>=20=0D=0A>=20=E2=80=A6=0D=0A=
>=20>=20+=09if=20(=21exfat_inode_cachep)=0D=0A>=20>=20+=09=09goto=20error;=
=0D=0A>=20=0D=0A>=20Can=20an=20other=20jump=20target=20like=20=E2=80=9Cshut=
down_cache=E2=80=9D=20be=20more=20appropriate?=0D=0A>=20=0D=0A>=20=0D=0A>=
=20>=20+=09err=20=3D=20register_filesystem(&exfat_fs_type);=0D=0A>=20>=20+=
=09if=20(err)=0D=0A>=20>=20+=09=09goto=20error;=0D=0A>=20=E2=80=A6=0D=0A>=
=20=0D=0A>=20Can=20the=20label=20=E2=80=9Cdestroy_cache=E2=80=9D=20be=20mor=
e=20appropriate?=0D=0A>=20=0D=0A>=20=0D=0AI=20checked=20your=20all=20points=
,=20Will=20fix=20them=20on=20V2.=0D=0AThanks=20for=20your=20review=21=0D=0A=
=0D=0A>=20Regards,=0D=0A>=20Markus=0D=0A=0D=0A
