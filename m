Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819F910364D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfKTJCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 04:02:16 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:15401 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfKTJCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:02:16 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191120090213epoutp01968a6a69f97394a6bc84907f7b4e61f8~Y02yRveFH0925009250epoutp01Z
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 09:02:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191120090213epoutp01968a6a69f97394a6bc84907f7b4e61f8~Y02yRveFH0925009250epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574240533;
        bh=dfMXCj9n8r6qNtIvUmluN1atQMpnLaKyM+8HLByEO3I=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=bVTwoeiS/BbOxoUOpTAwpLOZ5ioT87+QZ5MHnWVdd+yOcKkVn8NagXq+lkTEhAAsO
         8yB8gv8eykLnmPpBMKG9jRaumGWF7iIZ29DKS9qd+Q3ST8lWllngNhZROa5xDwVW6E
         U0CSnAaH1sFZCSSAGxCHYWuKrvmCuRsDKVO+2/g4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191120090212epcas1p340b21382da1d3b4cabfcbb2215b4fb62~Y02xpLbnt0972109721epcas1p3F;
        Wed, 20 Nov 2019 09:02:12 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47HxXM2qtYzMqYkV; Wed, 20 Nov
        2019 09:02:11 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.8D.04237.31105DD5; Wed, 20 Nov 2019 18:02:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191120090210epcas1p4d0f2fd524052392f5046495f4851809c~Y02wWQDD62759327593epcas1p4I;
        Wed, 20 Nov 2019 09:02:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191120090210epsmtrp2ce5f70798920b9d801f8ec9fa69ad4f9~Y02wVhflp0720607206epsmtrp2k;
        Wed, 20 Nov 2019 09:02:10 +0000 (GMT)
X-AuditID: b6c32a39-913ff7000000108d-64-5dd501135724
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.DC.03814.21105DD5; Wed, 20 Nov 2019 18:02:10 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191120090210epsmtip15237292a741392c1dc5b598a195a08db~Y02wL_zj52993029930epsmtip1D;
        Wed, 20 Nov 2019 09:02:10 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Markus Elfring'" <Markus.Elfring@web.de>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Daniel Wagner'" <dwagner@suse.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linkinjeon@gmail.com>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <705cb02b-7707-af52-c2b5-70660debc619@web.de>
Subject: RE: [PATCH v3 10/13] exfat: add nls operations
Date:   Wed, 20 Nov 2019 18:02:10 +0900
Message-ID: <00b701d59f81$319c1d90$94d458b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AQKGiVEIZXutAv+r8fum7Kkxtbdn/QHzs3lyAdI0Re0CJVjUg6YCisKg
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0hTcRTut3t379Vc3KbVyajWLYkSdXNOr6IRJXUjISH6I2vYxV3U2qvd
        GT3J6D1Kyv6IrhnWIMhFhplptaytrBVFqT20J2o5VEyLXhTV5l3kf9/5znfO+c7vQWHqW0Q8
        VWp1Cg4rb2aIaLzRPy8lKRY9NWp/dKhZf08lye521xHsOc8dBXu5axr7/HUXxl73BnC2/epJ
        gv0j9SnZht+3lWzbx2F8YTTXLL0muZbq8yR3rbOc4CoaahF36cE27nP9DM53ZZDgXn5oxPOp
        AnN2icCbBIdGsBbZTKXW4hxm+crCxYWGdK0uSZfJZjAaK28RcpjcvPykJaXmkEVGs4k3l4Wo
        fF4UmZQF2Q5bmVPQlNhEZw4j2E1mu05rTxZ5i1hmLU4uslmydFptqiGkXGcu8fSdI+3umM01
        nj68HH0f70JRFNBpcMb7DXOhaEpNNyGobB5AcvAJQWPrW0IOviKoedSt/FcyUnURlxNeBDdq
        n0VK+hG43wdGVQSdBL9/tRBhHEcnQ+WgXxkWYfSwAlrdARRORNFZ4Hl1KYQpKpbOgBPS4jCN
        0wlQ3vlCEcYqOhMe3qwkZTwRAid68TDG6EQ4e3oAkx1poOnhAJL5OKg6uA+T5y4Bz+3W0blA
        HyPh04ceUi7IhftnayPrxEL/3YYIHw+fh7xE2A/Q22CkJdL/AILgtxwZ66Gz7qIyLMHoeVB3
        NUWmZ0Hzz+qIhQkw9OWQUu6iggP71LIkASra/AoZTwPX/mHyCGKkMYtJYxaTxiwj/R9Wg/Ba
        NFmwi5ZiQdTZDWMvux6NPt/5mU2o9VGeD9EUYmJURzrajWolv0ncYvEhoDAmTnX9eYdRrTLx
        W7YKDluho8wsiD5kCJ37USx+UpEt9BmszkKdIVWv17Np6RnpBj0zRUV9f2JU08W8U9ggCHbB
        8a9OQUXFl6M5O3e+7M87NdT1NZH6kRgz25+1jjt2V3PZp20YGY7p28uu3x7lxptuVNSvXjHS
        Fly1qJQ+tcPV3T6dkx48Tj0ZvJAwbsrjqjcbgj3McRP17n3aVHPjigVS9i6jodfVnRuNvwve
        W7N25sIJ+UsLAmkFGu/gsrneZRs3Hr65tpd0i3sYXCzhdfMxh8j/Bd3Mn63UAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSnK4Q49VYg5lLTC0OP57EbtG8eD2b
        xcrVR5kstt6Strh+9xazxZ69J1ksLu+aw2bxf9ZzVost/46wWlx6/4HFgctj56y77B77565h
        99h9s4HNo2/LKkaPzaerPT5vkvM4tP0Nm8ftZ9tYAjiiuGxSUnMyy1KL9O0SuDKWbHzNXDCT
        s+Jd3yWmBsZb7F2MnBwSAiYSH2dvYOli5OIQEtjNKLHm+wVmiIS0xLETZ4BsDiBbWOLw4WKI
        mheMEq+XNDKB1LAJ6Er8+7OfDcQWEdCTmPTmMCtIEbPANyaJ25/PsEN0vGGUmHvxHlgHp4CV
        xOo7mxlBpgoLmEvMnOUMEmYRUJVouHkDrIRXwFLi7IFJ7BC2oMTJmU9YQGxmAW2J3oetjDD2
        soWvoQ5VkNhx9jVUXERidmcbM8RBbhKrjxxjncAoPAvJqFlIRs1CMmoWkvYFjCyrGCVTC4pz
        03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC41BLawfjiRPxhxgFOBiVeHgnXLkcK8SaWFZcmXuI
        UYKDWUmEd8/1K7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4
        OKUaGAUmzg+UNT5puy/zGueKN1kXS28L50vo+vstf9J58brWfaUvF09dZVus+iFwwocCXUHb
        cn/bt6uOPljZ92G+5SqTkv9PmNOfvssTPKjEIqugy6P8t/+0oJx59HW941+Dl8iwZOm2diY8
        b3Z2evb+f46AZ0Xs5gDxRPtVPR27k49eu+43ecO5zUosxRmJhlrMRcWJAF/Xf42/AgAA
X-CMS-MailID: 20191120090210epcas1p4d0f2fd524052392f5046495f4851809c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119094026epcas1p3eea5c655f3b89383e02c0097c491f0bc
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
        <CGME20191119094026epcas1p3eea5c655f3b89383e02c0097c491f0bc@epcas1p3.samsung.com>
        <20191119093718.3501-11-namjae.jeon@samsung.com>
        <705cb02b-7707-af52-c2b5-70660debc619@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> =E2=80=A6=0D=0A>=20>=20+++=20b/fs/exfat/nls.c=0D=0A>=20=E2=80=A6=0D=0A>=
=20>=20+static=20int=20exfat_load_upcase_table(struct=20super_block=20*sb,=
=0D=0A>=20>=20+=09=09sector_t=20sector,=20unsigned=20long=20long=20num_sect=
ors,=0D=0A>=20>=20+=09=09unsigned=20int=20utbl_checksum)=0D=0A>=20>=20+=7B=
=0D=0A>=20=E2=80=A6=0D=0A>=20>=20+error:=0D=0A>=20>=20+=09if=20(bh)=0D=0A>=
=20>=20+=09=09brelse(bh);=0D=0A>=20=0D=0A>=20I=20am=20informed=20in=20the=
=20way=20that=20this=20function=20tolerates=20the=20passing=0D=0A>=20of=20n=
ull=20pointers.=0D=0A>=20https://protect2.fireeye.com/url?k=3D58476862-0589=
69b1-5846e32d-000babff317b-=0D=0A>=202bdcc1db1dc57528&u=3Dhttps://git.kerne=
l.org/pub/scm/linux/kernel/git/torvalds/=0D=0A>=20linux.git/tree/include/li=
nux/buffer_head.h?id=3Daf42d3466bdc8f39806b26f593604f=0D=0A>=20dc54140bcb=
=23n292=0D=0A>=20https://protect2.fireeye.com/url?k=3D625424d5-3f9a2506-625=
5af9a-000babff317b-=0D=0A>=20a544a35424b18c18&u=3Dhttps://elixir.bootlin.co=
m/linux/v5.4-=0D=0A>=20rc8/source/include/linux/buffer_head.h=23L292=0D=0A>=
=20=0D=0A>=20Thus=20I=20suggest=20to=20omit=20the=20extra=20pointer=20check=
=20also=20at=20similar=20places.=0D=0A>=20=0D=0A>=20Can=20the=20label=20=E2=
=80=9Crelease_bh=E2=80=9D=20be=20more=20helpful?=0D=0AHi=20Markus,=0D=0A=0D=
=0AI=20checked=20not=20only=20review=20point=20but=20also=20your=20review=
=20points=20in=0D=0Aother=20patches,=20I=20will=20fix=20them=20on=20v4.=0D=
=0A=0D=0AThanks=20for=20your=20review=21=0D=0A>=20=0D=0A>=20Regards,=0D=0A>=
=20Markus=0D=0A=0D=0A
