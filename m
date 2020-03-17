Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E85B1891E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 00:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCQXUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 19:20:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:20940 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgCQXUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 19:20:09 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200317232006epoutp04d597cf5a5d3d68c95fb689bfbf634366~9OrgwRND-1761817618epoutp045
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 23:20:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200317232006epoutp04d597cf5a5d3d68c95fb689bfbf634366~9OrgwRND-1761817618epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584487206;
        bh=GhpuUBz1rA8cj0VwatvWYGkiGG6WTdtX3q8CwoVYcoc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hK7Tj8URf1EXMLcBXPCOOEYuZDpKdVn7JhyucC/QzDLLejdR6lsHBuUzDiRCF7Hff
         8JEbhComjSsPP1e/1qBCrUxixBcgajOQrtiWOHUTLiARyqvJ+6UlNqXuaMOb0neWIF
         RibQMAZ00E/5frULe/5PGBxycHFw9ss3OSqvF1d0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200317232006epcas1p4becb6a6bf10457fd8a5e05a212759ab7~9OrgQvheo1640216402epcas1p4J;
        Tue, 17 Mar 2020 23:20:06 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48hpzn0ss2zMqYkg; Tue, 17 Mar
        2020 23:20:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.88.04140.52B517E5; Wed, 18 Mar 2020 08:20:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200317232004epcas1p3713b7807eb7db36f16c6263d83ee9b51~9OrevZUtQ1457714577epcas1p3G;
        Tue, 17 Mar 2020 23:20:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317232004epsmtrp2b7edd941986d0ad76239cd6ccba74d00~9OreuwDEJ0539405394epsmtrp2M;
        Tue, 17 Mar 2020 23:20:04 +0000 (GMT)
X-AuditID: b6c32a36-fa3ff7000000102c-ae-5e715b258cbf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.4E.04158.42B517E5; Wed, 18 Mar 2020 08:20:04 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200317232004epsmtip25593eb00c3f3ab747851e47fb82471c8~9OremXeVr0203002030epsmtip2H;
        Tue, 17 Mar 2020 23:20:04 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?UTF-8?Q?'Pali_Roh=C3=A1r'?= <pali@kernel.org>,
        "'Alexander Viro'" <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <20200317222555.29974-1-pali@kernel.org>
Subject: RE: [PATCH 0/4] Fixes for exfat driver
Date:   Wed, 18 Mar 2020 08:20:04 +0900
Message-ID: <000101d5fcb2$96ec6270$c4c52750$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFfV5+WSZBMDydYf2i5chUPdrlJhwHCHd20qSyhhOA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmvq5qdGGcwYnJbBZ79p5ksbi8aw6b
        xYI9p9kstvw7wmpx/u9xVgdWj02rOtk8+rasYvT4vEnOY9OTt0wBLFE5NhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZkx+fYi74w1lx4IJ+
        A2MvZxcjJ4eEgInEnhW9LF2MXBxCAjsYJSYs+A/lfGKU+Lb1OzuE841RouNfMytMy5oLy1gh
        EnsZJa79mg3V8pJR4sLO30wgVWwCuhL//uxnA7FFBJIlDlydAGYzCxRIrN17BmwSp4CpxIeX
        68HiwgL6EuuPd4L1sgioSkw63AYW5xWwlGjcOZ8ZwhaUODnzCQvEHG2JZQtfM0NcpCDx8+ky
        VohdVhJ/fi+EqhGRmN3ZBlVzmU1i9Q+op10kVq1tYISwhSVeHd/CDmFLSXx+txdoLweQXS3x
        cT9UawejxIvvthC2scTN9RtYQUqYBTQl1u/ShwgrSuz8PZcRYiufxLuvPawQU3glOtqEIEpU
        JfouHWaCsKUluto/sE9gVJqF5K9ZSP6aheT+WQjLFjCyrGIUSy0ozk1PLTYsMEKO6k2M4BSp
        ZbaDcdE5n0OMAhyMSjy8HBsK4oRYE8uKK3MPMUpwMCuJ8C4uzI8T4k1JrKxKLcqPLyrNSS0+
        xGgKDPaJzFKiyfnA9J1XEm9oamRsbGxhYmZuZmqsJM479XpOnJBAemJJanZqakFqEUwfEwen
        VANjPOPskAvtvwUP3FF/ESosvmF1lcWBBbbGZt6vIm5wMfo0/nRbXq995eYc4z8X+06uW8Cz
        dJ1QyWedRzs0zMQFs+ydL8TZPP9ucrZJ91zPviurCieefy3sH/IuPPeqXtXR0E0m5R/Vj6Yv
        KMtO0N5+9zpbRGKS5iT+WQ3nWiWP3/7By2a8qfKDEktxRqKhFnNRcSIAJdNl2KcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXlclujDOoPWrlMWevSdZLC7vmsNm
        sWDPaTaLLf+OsFqc/3uc1YHVY9OqTjaPvi2rGD0+b5Lz2PTkLVMASxSXTUpqTmZZapG+XQJX
        RveJNqaCV+wVZ++9Y2xgnMHWxcjJISFgIrHmwjLWLkYuDiGB3YwSl371sUAkpCWOnTjD3MXI
        AWQLSxw+XAxR85xR4vb09awgNWwCuhL//uwHGyQikCxxbPJ7ZhCbWaBI4n7veXaIhjZGiZ3L
        /jKBJDgFTCU+vFwP1iAsoC+x/ngnWJxFQFVi0uE2sDivgKVE4875zBC2oMTJmU9YIIZqS/Q+
        bGWEsZctfM0McaiCxM+ny1ghjrCS+PN7IVS9iMTszjbmCYzCs5CMmoVk1Cwko2YhaVnAyLKK
        UTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4YrS0djCeOBF/iFGAg1GJhzdhU0GcEGti
        WXFl7iFGCQ5mJRHexYX5cUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphak
        FsFkmTg4pRoYnT90PpaV2tyUvyH52y3x5wZz5zu3sp55++zVzptn+49fsA02Os0wQ3/GqgZZ
        vtV2/z/bbN/azvDvgEMWt1AZu1/ne5cHO/hCG+omG8y7/11N/fu3y7uumHE8C3whWVMiPL3c
        /M2N1pnzp76O8rm1ou37cq0TW1nMtTLO9KsKpL+23Hu9YLHXcyWW4oxEQy3mouJEAPceOuyU
        AgAA
X-CMS-MailID: 20200317232004epcas1p3713b7807eb7db36f16c6263d83ee9b51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200317222604epcas1p1559308b0199c5320a9c77f5ad9f033a2
References: <CGME20200317222604epcas1p1559308b0199c5320a9c77f5ad9f033a2@epcas1p1.samsung.com>
        <20200317222555.29974-1-pali@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This patch series contains small fixes for exfat driver. It removes
> conversion from UTF-16 to UTF-16 at two places where it is not needed and
> fixes discard support.
Looks good to me.
Acked-by: Namjae Jeon <namjae.jeon=40samsung.com>

Hi Al,

Could you please push these patches into your =23for-next ?
Thanks=21

>=20
> Patches are also in my exfat branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=3De=
xfa
> t
>=20
> Pali Roh=C3=A1r=20(4):=0D=0A>=20=20=20exfat:=20Simplify=20exfat_utf8_d_ha=
sh()=20for=20code=20points=20above=20U+FFFF=0D=0A>=20=20=20exfat:=20Simplif=
y=20exfat_utf8_d_cmp()=20for=20code=20points=20above=20U+FFFF=0D=0A>=20=20=
=20exfat:=20Remove=20unused=20functions=20exfat_high_surrogate()=20and=0D=
=0A>=20=20=20=20=20exfat_low_surrogate()=0D=0A>=20=20=20exfat:=20Fix=20disc=
ard=20support=0D=0A>=20=0D=0A>=20=20fs/exfat/exfat_fs.h=20=7C=20=202=20--=
=0D=0A>=20=20fs/exfat/namei.c=20=20=20=20=7C=2019=20++++---------------=0D=
=0A>=20=20fs/exfat/nls.c=20=20=20=20=20=20=7C=2013=20-------------=0D=0A>=
=20=20fs/exfat/super.c=20=20=20=20=7C=20=205=20+++--=0D=0A>=20=204=20files=
=20changed,=207=20insertions(+),=2032=20deletions(-)=0D=0A>=20=0D=0A>=20--=
=0D=0A>=202.20.1=0D=0A=0D=0A=0D=0A
