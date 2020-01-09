Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7641363DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgAIXcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:32:21 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:15116 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:32:21 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200109233218epoutp03cdbcc61d64b0dc1dfd82513da27ac019~oW_wO0WXO2289322893epoutp03R
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 23:32:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200109233218epoutp03cdbcc61d64b0dc1dfd82513da27ac019~oW_wO0WXO2289322893epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578612738;
        bh=qYz4RWaAVEIVMPvjWOgfwAbf2N6owWkSInijo+H7HzE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=S1i9hhZVNpfPjjqsl28LkFO5zy05oeLspXYCJe2R9JBnnFnRGzcqJpVFnudH36m6Y
         2Xssd5kDcc90AeUwxsfa0KcsmMy8MkA1iDJGPt+T2mKFig4f2j2szwU+nfeOfGYVB0
         GVoVXQD8tkLCzJm4VFm4XF7f1lK0MutuRlwlAsPs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200109233218epcas1p216a90b721fce9b24ca91cbc9bb16ef7f~oW_v0yS3e0847508475epcas1p2a;
        Thu,  9 Jan 2020 23:32:18 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47v2TF2gt4zMqYkc; Thu,  9 Jan
        2020 23:32:17 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.33.48019.108B71E5; Fri, 10 Jan 2020 08:32:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200109233216epcas1p2c9d7e9d31268733b4fc9c1fc0ad47ebf~oW_uiALBL0850008500epcas1p28;
        Thu,  9 Jan 2020 23:32:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109233216epsmtrp1f80c1e0ab387d2f4542897fa543d7e5a~oW_uhS5zP2048320483epsmtrp15;
        Thu,  9 Jan 2020 23:32:16 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-76-5e17b80151f1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.B6.10238.008B71E5; Fri, 10 Jan 2020 08:32:16 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109233216epsmtip15eefb7ca5f611cab4c5f00ec776304a7~oW_uUON6x2165321653epsmtip1d;
        Thu,  9 Jan 2020 23:32:16 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Arnd Bergmann'" <arnd@arndb.de>
Cc:     =?utf-8?Q?'Pali_Roh=C3=A1r'?= <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "'Linux FS-devel Mailing List'" <linux-fsdevel@vger.kernel.org>,
        "'gregkh'" <gregkh@linuxfoundation.org>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>,
        <sj1557.seo@samsung.com>, <linkinjeon@gmail.com>,
        "'Christoph Hellwig'" <hch@lst.de>
In-Reply-To: <CAK8P3a0S6DBJqDMj4Oy9xeYVhW87HbBX2SqURFPKYT8K1z7fDw@mail.gmail.com>
Subject: RE: [PATCH v9 09/13] exfat: add misc operations
Date:   Fri, 10 Jan 2020 08:32:16 +0900
Message-ID: <001e01d5c745$0765ca80$16315f80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSGi/S1M7UFBjz5N3SW71o+eawLwJob/ETArMVgR4BcbvZIAG7WpyVAtwAkTymkS7JAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmni7jDvE4gwfPhC3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWUw8/ZvJYsu/I6wWl95/YHHg9Pj9axKjx85Zd9k99s9d
        w+6x+2YDm0ffllWMHp83yXkc2v6GLYA9KscmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+g0JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        oUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsaz99PYC+YLV7z8+JGlgXGFUBcjJ4eEgInE05XP
        mLsYuTiEBHYwSrRf/MME4XxilFh3tJ0RwvnGKHFv/TFGmJbrWydCtexllDg+vYkNwnnJKLHy
        chsbSBWbgK7Evz/7wWwRAVWJV092s4MUMQtcYJK487sJLMEpEChx7ONTVhBbWMBC4vWRA0Bx
        Dg4WoIbW7WIgYV4BS4nPHTdZIWxBiZMzn7CA2MwC2hLLFr5mhrhIQeLn02WsELvCJA5fms8E
        USMiMbuzDexSCYF2dokzN7dAveAisXzTFyYIW1ji1fEt7BC2lMTL/jZ2kBskBKolPu6Hmt/B
        KPHiuy2EbSxxc/0GVpASZgFNifW79CHCihI7f89lhFjLJ/Huaw8rxBReiY42aFCrSvRdOgy1
        VFqiq/0D+wRGpVlIHpuF5LFZSB6YhbBsASPLKkax1ILi3PTUYsMCE+TI3sQITrZaFjsY95zz
        OcQowMGoxMObISweJ8SaWFZcmXuIUYKDWUmE9+gNsTgh3pTEyqrUovz4otKc1OJDjKbAYJ/I
        LCWanA/MBHkl8YamRsbGxhYmZuZmpsZK4rwcPy7GCgmkJ5akZqemFqQWwfQxcXBKNTBOXXy2
        dO2FZZ5bFxrF/nFlyInhuL5IoD84YcOV5LuxkyPvO8etVCncGrCk59mr897OV6acKPo424Rr
        4vHXZ1/stHf7uHSqWI6qXuzBj1dtpUtYv7AvPTvHLprNs9893T5J1jL54dxDzI6RUQvyjDVE
        P78+UMg+014mrHli82LbX50tgi4rvLYpsRRnJBpqMRcVJwIAQJzRSswDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSnC7DDvE4g7WrTSz+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWUw8/ZvJYsu/I6wWl95/YHHg9Pj9axKjx85Zd9k99s9d
        w+6x+2YDm0ffllWMHp83yXkc2v6GLYA9issmJTUnsyy1SN8ugSvj9oxdTAWHeSu6tnxhb2Bc
        z9XFyMkhIWAicX3rROYuRi4OIYHdjBI/n3YxQySkJY6dOANkcwDZwhKHDxdD1DxnlPjcugOs
        hk1AV+Lfn/1sILaIgKrEqye72UGKmAWuMUncvveFEaLjDJPEodvLWECqOAUCJY59fMoKYgsL
        WEi8PnKADWQDC1B363YxkDCvgKXE546brBC2oMTJmU/AWpkFtCWe3nwKZy9b+BrqUAWgo5ex
        QhwRJnH40nwmiBoRidmdbcwTGIVnIRk1C8moWUhGzULSsoCRZRWjZGpBcW56brFhgWFearle
        cWJucWleul5yfu4mRnDcaWnuYLy8JP4QowAHoxIPb4aweJwQa2JZcWXuIUYJDmYlEd6jN8Ti
        hHhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamDUNjvwOPKo
        a7BT8Y3KBaqrbjAvNt3XwObqHqLFGNt2zX1G2/vqo4v+hTlc3yCgXXpUTmFGxWfXyRL2Xb5X
        pmbsW3Xrl1wBm/DC6g0nf++T/V/9kyE54szz8KO8ywJaN3BbfJux9LxAdKuR3wrxeRU5oW5P
        tD8Fva5Q/Zn63kvyt+r0jqyC1jglluKMREMt5qLiRABNFRIKtwIAAA==
X-CMS-MailID: 20200109233216epcas1p2c9d7e9d31268733b4fc9c1fc0ad47ebf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082406epcas1p268f260d90213bdaabee25a7518f86625
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082406epcas1p268f260d90213bdaabee25a7518f86625@epcas1p2.samsung.com>
        <20200102082036.29643-10-namjae.jeon@samsung.com>
        <20200102091902.tk374bxohvj33prz@pali> <20200108180304.GE14650@lst.de>
        <CAK8P3a0S6DBJqDMj4Oy9xeYVhW87HbBX2SqURFPKYT8K1z7fDw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Wed, Jan 8, 2020 at 7:03 PM Christoph Hellwig <hch=40lst.de> wrote:
> >
> > Arnd, can you review the exfat time handling, especially vs y2038
> > related issues?
>=20
> Sure, thanks for adding me to the loop
>=20
> > On Thu, Jan 02, 2020 at 10:19:02AM +0100, Pali Roh=C3=A1r=20wrote:=0D=
=0A>=20>=20>=20On=20Thursday=2002=20January=202020=2016:20:32=20Namjae=20Je=
on=20wrote:=0D=0A>=20>=20>=20>=20+=23define=20TIMEZONE_CUR_OFFSET()=20=20=
=20=20=20=20((sys_tz.tz_minuteswest=20/=20(-15))=0D=0A>=20&=200x7F)=0D=0A>=
=20>=20>=20>=20+/*=20Convert=20linear=20UNIX=20date=20to=20a=20FAT=20time/d=
ate=20pair.=20*/=20void=0D=0A>=20>=20>=20>=20+exfat_time_unix2fat(struct=20=
exfat_sb_info=20*sbi,=20struct=20timespec64=0D=0A>=20*ts,=0D=0A>=20>=20>=20=
>=20+=20=20=20=20=20=20=20=20=20=20=20struct=20exfat_date_time=20*tp)=20=7B=
=0D=0A>=20>=20>=20>=20+=20=20=20time_t=20second=20=3D=20ts->tv_sec;=0D=0A>=
=20>=20>=20>=20+=20=20=20time_t=20day,=20month,=20year;=0D=0A>=20>=20>=20>=
=20+=20=20=20time_t=20ld;=20/*=20leap=20day=20*/=0D=0A>=20>=20>=0D=0A>=20>=
=20>=20Question=20for=20other=20maintainers:=20Has=20kernel=20code=20alread=
y=20time_t=0D=0A>=20>=20>=20defined=20as=2064bit?=20Or=20it=20is=20still=20=
just=2032bit=20and=2032bit=20systems=20and=0D=0A>=20>=20>=20some=20time64_t=
=20needs=20to=20be=20used?=20I=20remember=20that=20there=20was=20discussion=
=0D=0A>=20>=20>=20about=20these=20problems,=20but=20do=20not=20know=20if=20=
it=20was=20changed/fixed=20or=0D=0A>=20>=20>=20not...=20Just=20a=20pointer=
=20for=20possible=20Y2038=20problem.=20As=20=22ts=22=20is=20of=20type=0D=0A=
>=20>=20>=20timespec64,=20but=20=22second=22=20of=20type=20time_t.=0D=0A>=
=20=0D=0A>=20I=20am=20actually=20very=20close=20to=20sending=20the=20patche=
s=20to=20remove=20the=20time_t=0D=0A>=20definition=20from=20the=20kernel,=
=20at=20least=20in=20yesterday's=20version=20there=20were=20no=0D=0A>=20use=
rs.=0D=0A>=20=0D=0A>=20exfat_time_unix2fat()=20seems=20to=20be=20a=20copy=
=20of=20the=20old=20fat_time_unix2fat()=0D=0A>=20that=20we=20fixed=20a=20wh=
ile=20ago,=20please=20have=20a=20look=20at=20that=20implementation=20based=
=0D=0A>=20on=20time64_to_tm(),=20which=20avoids=20time_t.=0D=0AOkay,=20Pali=
=20reported=20it=20and=20suggested=20to=20check=20your=20patch=20in=20stagi=
ng/exfat.=0D=0AI=20will=20fix=20it=20on=20v10.=0D=0A=0D=0AThanks=20for=20yo=
ur=20review=21=0D=0A>=20=0D=0A>=20=20=20=20=20=20=20Arnd=0D=0A=0D=0A
