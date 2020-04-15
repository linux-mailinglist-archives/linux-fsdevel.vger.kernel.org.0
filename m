Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77B1AB45E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 01:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgDOXnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 19:43:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11253 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDOXnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 19:43:49 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200415234345epoutp02311e25b698e01e5b8ad237bef901cce7~GItbu9kIR0312003120epoutp02L
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 23:43:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200415234345epoutp02311e25b698e01e5b8ad237bef901cce7~GItbu9kIR0312003120epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586994225;
        bh=Fk9CvL4cU0mn+lERG4HsulBmjZUnfRyM/M+ZU517FjA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JbbZZbFVxHItr08sK+QyofAzyULaXXb32j9CG9BZI3+WylSUrk3YL38iVprsDV06M
         8V1sjQgM+IJ0OKbx0HV63dVTC9xgFIhecWjaqBKRCUlYdMaV5pzwIBgvHrS3eKl+uH
         vRL68lLQOZgvBNaBJzxZ11jgFJnMn9mypKZMUJgU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200415234344epcas1p45e9ae83c712933e981e69c8171a0a0e8~GItax9WD80924109241epcas1p4p;
        Wed, 15 Apr 2020 23:43:44 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 492f7g1kbyzMqYkZ; Wed, 15 Apr
        2020 23:43:43 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.D2.04658.D2C979E5; Thu, 16 Apr 2020 08:43:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200415234341epcas1p18e65d727f10ebbde8331928fd5d8a688~GItX8WHjw3137931379epcas1p1x;
        Wed, 15 Apr 2020 23:43:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200415234341epsmtrp10fe293d9e4fcb605a03847dd2037017f~GItX7uVqU0171001710epsmtrp1t;
        Wed, 15 Apr 2020 23:43:41 +0000 (GMT)
X-AuditID: b6c32a39-fc7b99e000001232-52-5e979c2d7106
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.09.04158.D2C979E5; Thu, 16 Apr 2020 08:43:41 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200415234341epsmtip289f0c6a6727ba00a0dc4716f731b5b5b~GItX1Be5C0847908479epsmtip2W;
        Wed, 15 Apr 2020 23:43:41 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?utf-8?Q?'Pali_Roh=C3=A1r'?= <pali@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Alexander Viro'" <viro@zeniv.linux.org.uk>
In-Reply-To: <20200415080138.fvmviqavjtyqyi65@pali>
Subject: RE: [PATCH 0/4] Fixes for exfat driver
Date:   Thu, 16 Apr 2020 08:43:40 +0900
Message-ID: <000101d6137f$b1504350$13f0c9f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFfV5+WSZBMDydYf2i5chUPdrlJhwHCHd20AsohPpcA/tShGqk79V5g
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHOd6XbeLsOjUP9sK66Aetuc05neIiSGThIqk+9WF2dTeV7l7Y
        nZIZUhDaLNIItZbSJLQQfFtmaoriS0sSLSNf6kMJWr5kpaESmXS3q+S333n+/+f8z3POESKS
        SjxcmGu20zYzxZC4P9o+ECWXyaqrDIq3HXGa7p5hVPOuqxrXuLpf45q2rUFMM/bXgx3DdO4G
        B6673dYAdL/cB3Xu2WW/dPQck5xDU0baJqXNWRZjrjlbS6adyTieoY5XKGXKRE0CKTVTJlpL
        pujTZam5DJdLSvMpJo8rpVMsS8qPJtsseXZammNh7VqSthoZq1JhjWEpE5tnzo7JspiSlApF
        rJpznmdyGr+1A2tF4CWPc1xwFXQGlAKREBJxcPDZGFYK/IUSogPARy+6Ea8gIVYBnBhL44V1
        AKfuPvfb6ZirWxbwQg+A059WAL9YALDqyyjudeGEDG5t9vo4hFDBsg+NqNeEEC4AW91DmFcQ
        ccL0mw2Bl4MJOWz2OHwRKBEJm67VoF4WE4mw3rGF8BwEh+/P+uoIcRjW1y4h/JGk8PdcPcaH
        pcKP5Z8FvCcEPnAUI95gSEzisHZkCucbUuBjz9I2B8NFT5uA53C4UFbMsZDjQrjSu73/DQDn
        N7Q8c2dubsG8FoSIgs1dcr58CHb+qQF8bCD8vnYL43cRwxvFEt4SCW+PD2xf4j5YWvJTUA5I
        567BnLsGc+4awPk/zAXQBrCXtrKmbJpVWtW7H9sNfH8yOrEDvBzV9wNCCMgAsWKh0iDBqHy2
        wNQPoBAhQ8Qdp6oMErGRKrhM2ywZtjyGZvuBmrv3O0h4aJaF++Fme4ZSHatSqTRx8QnxahUZ
        Jq6YZAwSIpuy0xdp2krbdvr8hKLwqyCzVzZkdR0ZDXGFWZ4yp2f3Z4qXUiIIt00fJJ5M23Pg
        fo9jbuRVa8zqp/fzTEmL6Fro4om0j/ObV2ZQKZpPVxQ+qZvZLNU+ZJOm+yXlZ3+sVK916W8V
        LfSRyTV9s+sn5RETy3jX9SYBduIe85XJauu+UH8THF0rU6OKIr3On0TZHEoZjdhY6h+HvwRU
        qQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXld3zvQ4g/N/2Cz27D3JYnF51xw2
        iwV7TrNZbPl3hNXi/N/jrA6sHptWdbJ59G1ZxejxeZOcx6Ynb5kCWKK4bFJSczLLUov07RK4
        MqZOMi/Yyl3R+3I3cwPjdY4uRk4OCQETiadL37J3MXJxCAnsZpSYu28yC0RCWuLYiTPMXYwc
        QLawxOHDxRA1zxklljbeBathE9CV+PdnPxuILSJgLNF/ay0LSBGzwCJGic/bd7JAdNxmlFj8
        oResihOo6uaF7+wgtrCAvsT6451MIDaLgKrEusa5YFN5BSwllnX+Y4awBSVOznwCFmcW0JZ4
        evMpnL1s4WtmiEsVJH4+XcYKcYWbxO0JD9ghakQkZne2MU9gFJ6FZNQsJKNmIRk1C0nLAkaW
        VYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwRGjpbWD8cSJ+EOMAhyMSjy8Ha+nxQmx
        JpYVV+YeYpTgYFYS4d3hPz1OiDclsbIqtSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTU
        gtQimCwTB6dUA6Pd6uwvem7Hlgnwhf8psDPNquJjTFqbnGw+5+6kiyusuuZ433ZcMvX7kt2H
        n7z1vqnl9OFl+YfioxeajKKFE6+fzBHvFv4723T1qX2Ry7P2XLXaf+Jr56KGuffPyucxHJPY
        VXbwrZTC0Tlzej/Jlh24fjigdtJTztutboGHmavXfD3dctcnZEqjEktxRqKhFnNRcSIApMNH
        6pQCAAA=
X-CMS-MailID: 20200415234341epcas1p18e65d727f10ebbde8331928fd5d8a688
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200317222604epcas1p1559308b0199c5320a9c77f5ad9f033a2
References: <CGME20200317222604epcas1p1559308b0199c5320a9c77f5ad9f033a2@epcas1p1.samsung.com>
        <20200317222555.29974-1-pali@kernel.org>
        <000101d5fcb2$96ec6270$c4c52750$@samsung.com>
        <20200415080138.fvmviqavjtyqyi65@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Wednesday 18 March 2020 08:20:04 Namjae Jeon wrote:
> > > This patch series contains small fixes for exfat driver. It removes
> > > conversion from UTF-16 to UTF-16 at two places where it is not
> > > needed and fixes discard support.
> > Looks good to me.
> > Acked-by: Namjae Jeon <namjae.jeon=40samsung.com>
> >
> > Hi Al,
> >
> > Could you please push these patches into your =23for-next ?
> > Thanks=21
>=20
> Al, could you please take this patch series? Based on feedback current
> hashing code is good enough. And we do not want to have broken discard
> support in upcoming Linux kernel version.
Hi Pali,

I will push them to exfat git tree.

Thanks for your work=21
>=20
> > >
> > > Patches are also in my exfat branch:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?
> > > h=3Dexfa
> > > t
> > >
> > > Pali Roh=C3=A1r=20(4):=0D=0A>=20>=20>=20=20=20exfat:=20Simplify=20exf=
at_utf8_d_hash()=20for=20code=20points=20above=20U+FFFF=0D=0A>=20>=20>=20=
=20=20exfat:=20Simplify=20exfat_utf8_d_cmp()=20for=20code=20points=20above=
=20U+FFFF=0D=0A>=20>=20>=20=20=20exfat:=20Remove=20unused=20functions=20exf=
at_high_surrogate()=20and=0D=0A>=20>=20>=20=20=20=20=20exfat_low_surrogate(=
)=0D=0A>=20>=20>=20=20=20exfat:=20Fix=20discard=20support=0D=0A>=20>=20>=0D=
=0A>=20>=20>=20=20fs/exfat/exfat_fs.h=20=7C=20=202=20--=0D=0A>=20>=20>=20=
=20fs/exfat/namei.c=20=20=20=20=7C=2019=20++++---------------=0D=0A>=20>=20=
>=20=20fs/exfat/nls.c=20=20=20=20=20=20=7C=2013=20-------------=0D=0A>=20>=
=20>=20=20fs/exfat/super.c=20=20=20=20=7C=20=205=20+++--=0D=0A>=20>=20>=20=
=204=20files=20changed,=207=20insertions(+),=2032=20deletions(-)=0D=0A>=20>=
=20>=0D=0A>=20>=20>=20--=0D=0A>=20>=20>=202.20.1=0D=0A>=20>=0D=0A>=20>=0D=
=0A>=20>=0D=0A=0D=0A
