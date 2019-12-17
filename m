Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA91225F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 08:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLQH4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 02:56:52 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:12747 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfLQH4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:56:51 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191217075648epoutp02e9eb61e79d7f403ef1890f346a5fdc68~hGYYSsWVa1957919579epoutp02N
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 07:56:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191217075648epoutp02e9eb61e79d7f403ef1890f346a5fdc68~hGYYSsWVa1957919579epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576569408;
        bh=mL/I4yHV55WRTJAVzCtESsXYyYi7jBtpQYmWE+QpRrQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=np8xNulVgY/q7tscIRZmYGMebeZam9Rka9G4whqI0FWMXY3pdP7ZiFEP4pfilfVGj
         UYnAPWxdOXEJl/RVcqwcZngyn8idVjHrUXTCoDn71+rvvFRaTFteHV9bIaxwa4eSiG
         H1D7eIdKy2BM3yI/x3hHbfv2LSZXWkxh+prInJkc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191217075647epcas1p316f7bf0b33b63c424962434d5a56bb66~hGYXwy3nQ0768107681epcas1p3I;
        Tue, 17 Dec 2019 07:56:47 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47cVpQ4WwczMqYkj; Tue, 17 Dec
        2019 07:56:46 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.99.51241.E3A88FD5; Tue, 17 Dec 2019 16:56:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191217075646epcas1p17867269a83c11c832825d9dbf066cd2f~hGYWaDdwF3167031670epcas1p1N;
        Tue, 17 Dec 2019 07:56:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191217075646epsmtrp2337fd950dbd4c4053b7474a5b7918112~hGYWU1gDj1096910969epsmtrp2u;
        Tue, 17 Dec 2019 07:56:46 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-10-5df88a3e53ae
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.48.10238.D3A88FD5; Tue, 17 Dec 2019 16:56:45 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191217075645epsmtip20093fcc40ca3fcc09c9dd5cc035f8e13~hGYWICMC21687116871epsmtip2e;
        Tue, 17 Dec 2019 07:56:45 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Markus Elfring'" <Markus.Elfring@web.de>
Cc:     <linux-kernel@vger.kernel.org>, "'Christoph Hellwig'" <hch@lst.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <a428a92f-d54d-9648-371b-55112874be12@web.de>
Subject: RE: [PATCH v7 01/13] exfat: add in-memory and on-disk structures
 and headers
Date:   Tue, 17 Dec 2019 16:56:45 +0900
Message-ID: <001401d5b4af$875f1690$961d43b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQFm2LC/h6nQOwj4JCuWUtKX9oQxIwE+vU/YAbPr/rABlbE1VAJShfR7qGTShCA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm287OjtLiOK3eFOx0uoB521zTo7kKkhh0QRAMArGDO7jR2YWd
        GdmFpGCWiZr0o1aSUnRRyxLRdTFxpiWRkXYzlW5mlmmXWWYXa9tZ5L/nfb/nfZ/n+b6PkCpr
        8UjCZHFwdgvL03go1twRo4pfXfI9R/VxdAlz4HQDzlyo65QwN1q7Mabv2kmc+eN6K2OaZm7J
        mN6Pn7C1cn1bVb1cf72/CNeXNdUivbcxWu9p+YDrB0aasUx8K59u5FgDZ6c4S57VYLLk6+gN
        WbnrcrXJKnW8OpVJoSkLa+Z0dMbGzPj1Jt7nhaZ2sHyBr5XJCgKduDrdbi1wcJTRKjh0NGcz
        8Da1ypYgsGahwJKfkGc1p6lVqiStj7mNNw7cuInbprGdbyarJUWoFytBIQSQK+HYFQ8qQaGE
        knQjeNEyJhWLLwjaB19hYvENwcuiesm/kZ7jdbh40IqguOl5kPUewTt3T4CFk/Ew86sN9+MI
        MgEqP3TI/FhKlkqg5nGYH4eQafB84nKAH05ugfJDnQFTGLkMnPdHAnwFmQqT5eVyEYdB9/Fh
        TNwTC2dr/F79jihw3xtDotZmODfQIRE5EXDikDOQB0gvDn0tI8EIGfCme38Qh8P7201yEUeC
        d6LVZ5rw4d3wuS24/yCC0SmdiDXQ33BZ5qdIyRhouJYothfD1Z9VSJSdCxNfS2XiFgUcdCpF
        yjIo6+0IikZBSfEneQWiXbOCuWYFc80K4PovVo2wWjSfswnmfE5Q27SzH7sRBf7pilQ36urZ
        6EEkgeg5CnBM5Shl7A6h0OxBQEjpCIWb8rUUBrZwF2e35toLeE7wIK3v3o9II+flWX2/3uLI
        VWuTNBoNszI5JVmroRcoiO8PcpRkPuvgtnOcjbP/m5MQIZFFaH/2qWc199Imovji0diojDOJ
        q45O4ksXjdcvnzFsOnxpUFMY1tN+sSKrujFOF/NkL5HupZz141YsPPV852vZVKfp7h4j35Wy
        ffBo2tKH5MsvByjz+JrDVU9rnYo6E3VnaNjhHcqervyRMe3KLj2yb+HvR6P20OjKuekVNWXX
        o+N4GhOMrHqF1C6wfwHFLvYxvQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvK5d149Yg80OFs2L17NZrFx9lMli
        z96TLBaXd81hs/g/6zmrxZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2we
        t59tYwlgi+KySUnNySxLLdK3S+DKmPTiDXPBfeaKo81WDYz/mboYOTkkBEwkzs1czdbFyMUh
        JLCbUaLl3D5GiIS0xLETZ5i7GDmAbGGJw4eLIWpeMEpM/nSTDaSGTUBX4t+f/WC2iICexKQ3
        h1lBipgFJjBJbJrUyQzRMZ1J4vDEaWBTOQWsJO6/2wC2WlggVGLF4Udg3SwCqhJt55+xgti8
        ApYSX/r72SFsQYmTM5+wgNjMAtoSvQ9bGWHsZQtfM0NcqiCx4+xrRogr/CSW3z7MBFEjIjG7
        s415AqPwLCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiO
        Ky3NHYyXl8QfYhTgYFTi4ZUo+R4rxJpYVlyZe4hRgoNZSYR3hwJQiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBkZ9mz8P64XC/KLnHwsoZTsknbYoeZLf
        /TcaDHc3zxW1cTyQlRZ0ien/4skxtzi29d4s11R1nq7UqL9F7tD2O3uf3z81va34pFjRj4kH
        NivPXbFrUryo69oTpf6TvsTuW+11g3Hzge+i37953j37ufCD4RbjkH92zT41E6tesqkHl93m
        fet6akqzEktxRqKhFnNRcSIAzxNfmacCAAA=
X-CMS-MailID: 20191217075646epcas1p17867269a83c11c832825d9dbf066cd2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e
References: <20191213055028.5574-2-namjae.jeon@samsung.com>
        <CGME20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e@epcas5p3.samsung.com>
        <088a50ad-dc67-4ff6-624d-a1ac2008b420@web.de>
        <002401d5b46d$543f7ee0$fcbe7ca0$@samsung.com>
        <a428a92f-d54d-9648-371b-55112874be12@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>=20
> > Good catch, I will move it on next version.
>=20
> The declaration for a function like =E2=80=9Cexfat_count_dir_entries=E2=
=80=9D=20can=20eventually=0D=0A>=20be=20moved=20instead=20if=20you=20would=
=20like=20to=20provide=20a=20corresponding=20implementation=0D=0A>=20by=20t=
he=20update=20step=20=E2=80=9C=5BPATCH=20v7=2004/13=5D=20exfat:=20add=20dir=
ectory=20operations=E2=80=9D=20so=20far.=0D=0A>=20Is=20there=20a=20need=20t=
o=20recheck=20the=20function=20grouping=20once=20more?=0D=0AYep,=20I=20will=
=20fix=20them=20together.=0D=0A=0D=0AThanks=21=0D=0A>=20=0D=0A>=20Regards,=
=0D=0A>=20Markus=0D=0A=0D=0A
