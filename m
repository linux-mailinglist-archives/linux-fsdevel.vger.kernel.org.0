Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F62FFDAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 05:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfKRE7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 23:59:48 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:58902 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfKRE7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 23:59:47 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191118045942epoutp02136f5fc385268e440893a5ceec74bb2c~YKQe5ouW_1795917959epoutp02U
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2019 04:59:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191118045942epoutp02136f5fc385268e440893a5ceec74bb2c~YKQe5ouW_1795917959epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574053182;
        bh=F/g2OIlz0/NDE5SEkzXk6lGEjX00S5KOP/k4w3J8IPk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Ivz9MF7Hz9TAi9mILj5t2tjy1E2Od6/jrpIApC6dsqr+Zgs0Li8/BmXhHxTdyG+bl
         UpqwWMLtccciiH/fvKACqHAO7G3ZSiYu6NbKsxSE5/k+ToaItmidTVOGK31izrO1Dw
         gwnicg7XyLQ8BWV0SGWVshumv9hf2GnvR4TNoM20=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191118045942epcas1p451df2f81cbb35a60dd4ee3014e61fc7c~YKQeRI6_A1381413814epcas1p4o;
        Mon, 18 Nov 2019 04:59:42 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47GcFT4GwtzMqYkn; Mon, 18 Nov
        2019 04:59:41 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.86.04406.D3522DD5; Mon, 18 Nov 2019 13:59:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191118045940epcas1p3b36eb532d8def2cafeb014eebab128e5~YKQc0r9Sr1368213682epcas1p3F;
        Mon, 18 Nov 2019 04:59:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191118045940epsmtrp1b700fb0c572b1f5afa7fb3623dd8fcf5~YKQcz_gJP0339103391epsmtrp1C;
        Mon, 18 Nov 2019 04:59:40 +0000 (GMT)
X-AuditID: b6c32a38-95fff70000001136-39-5dd2253d1ff7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.67.03654.C3522DD5; Mon, 18 Nov 2019 13:59:40 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191118045940epsmtip2a193bb5e28e862e8b4fbf8cee8a0f624~YKQcqg2142534025340epsmtip2V;
        Mon, 18 Nov 2019 04:59:40 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Markus Elfring'" <Markus.Elfring@web.de>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linkinjeon@gmail.com>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <a4bd8e3e-fcdc-9739-5407-5345743fb0b9@web.de>
Subject: RE: [PATCH 01/13] exfat: add in-memory and on-disk structures and
 headers
Date:   Mon, 18 Nov 2019 13:59:40 +0900
Message-ID: <00ba01d59dcc$fc17e010$f447a030$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQDyLF7pV5/eBb/pSO5+MuAyfY69HgGBvdAxAsnJjT2pNOSKMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmnq6t6qVYg5/ruS2aF69ns1i5+iiT
        xdZb0hbX795ittiz9ySLxeVdc9gs/s96zmqx5d8RVotL7z+wOHB67Jx1l91j/9w17B67bzaw
        efRtWcXo8XmTnMeh7W/YPG4/28YSwB6VY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGto
        aWGupJCXmJtqq+TiE6DrlpkDdJmSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQ
        oECvODG3uDQvXS85P9fK0MDAyBSoMiEn48PsvawFx1kqZj1sYW1g3MbSxcjJISFgIvFh/jO2
        LkYuDiGBHYwS21bNZ4JwPjFKLJu8gRnC+cYoMe/RVGaYlmVTt7BAJPYySrRfns8I4bxilGjb
        080EUsUmoCvx789+NhBbREBPYtKbw6wgRcwCJ5kkvi0+DjSKg4NTwEric6sQSI2wQIhE9/Rz
        rCA2i4CqxJrufWDbeAUsJd7+XsEKYQtKnJz5BOxwZgFtiWULX0NdpCCx4+xrRpCRIgJOEq8m
        ckGUiEjM7mwD+0BCoJldYueqvSwgNRICLhLTv3BDtApLvDq+hR3ClpJ42d/GDlFSLfFxP9T0
        DkaJF99tIWxjiZvrN7CClDALaEqs36UPEVaU2Pl7LiPEVj6Jd197WCGm8Ep0tAlBlKhK9F06
        zARhS0t0tX9gn8CoNAvJW7OQvDULyf2zEJYtYGRZxSiWWlCcm55abFhgghzVmxjBaVbLYgfj
        nnM+hxgFOBiVeHgflF+MFWJNLCuuzD3EKMHBrCTC6/foQqwQb0piZVVqUX58UWlOavEhRlNg
        qE9klhJNzgfmgLySeENTI2NjYwsTM3MzU2MlcV6OH0BzBNITS1KzU1MLUotg+pg4OKUaGDsK
        GffmRvk/ZdrWoOslb81h8t/AM78ns0X0saH/3O9N/FVr+B/3ZRV92Lfe3eTDNOd6Ma3p7z4a
        cn7fpmnFdmh5XJiQcEzDQvkb5Y718f2ui3qSykzZAyOiJF5xc9X+EqgtcLr4ao1M9t2VBguW
        r2T9LMRp16hmyPMu69AZT46HgqJLIm4psRRnJBpqMRcVJwIAjlpiCskDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSvK6N6qVYg8W71SyaF69ns1i5+iiT
        xdZb0hbX795ittiz9ySLxeVdc9gs/s96zmqx5d8RVotL7z+wOHB67Jx1l91j/9w17B67bzaw
        efRtWcXo8XmTnMeh7W/YPG4/28YSwB7FZZOSmpNZllqkb5fAlbGweQdzwQ+mijsvP7I2MC5i
        6mLk5JAQMJFYNnULSxcjF4eQwG5GiStrbjFDJKQljp04A2RzANnCEocPF0PUvGCUuNk3A6yZ
        TUBX4t+f/WwgtoiAnsSkN4dZQYqYBc4zSRyecJERbuqGXxNYQSZxClhJfG4VAmkQFgiSWLDx
        IyuIzSKgKrGmex/YYl4BS4m3v1ewQtiCEidnPmEBsZkFtCV6H7YywtjLFr6GOlRBYsfZ14wg
        40UEnCReTeSCKBGRmN3ZxjyBUXgWkkmzkEyahWTSLCQtCxhZVjFKphYU56bnFhsWGOallusV
        J+YWl+al6yXn525iBMecluYOxstL4g8xCnAwKvHwWlRdjBViTSwrrsw9xCjBwawkwuv36EKs
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYwqNQ4KwvqG
        vw0t5kr/N6x375RLfNWiHMXkVxr9Is7eltm8aOfxD3rHXnT/9Jslvly+88U/G08FwcV3PFWs
        t0VPiPTYWVgx61HslxcyF0QmmCiEi17Q+HC1lJn73Bqrcr67Kem/8k75qbOvnJ6xrHhWRwHn
        kUWhch4b96xaw+9+N/K7w0/JN0osxRmJhlrMRcWJAKZvPqy1AgAA
X-CMS-MailID: 20191118045940epcas1p3b36eb532d8def2cafeb014eebab128e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191117122540epcas4p2cd0e2b9658154c81ae9d2e46882efaa0
References: <20191113081800.7672-2-namjae.jeon@samsung.com>
        <CGME20191117122540epcas4p2cd0e2b9658154c81ae9d2e46882efaa0@epcas4p2.samsung.com>
        <a4bd8e3e-fcdc-9739-5407-5345743fb0b9@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> =E2=80=A6=0D=0A>=20>=20+++=20b/fs/exfat/exfat_fs.h=0D=0A>=20>=20=40=40=20=
-0,0=20+1,533=20=40=40=0D=0A>=20=E2=80=A6=0D=0A>=20>=20+/*=20time=20modes=
=20*/=0D=0A>=20>=20+=23define=20TM_CREATE=09=090=0D=0A>=20>=20+=23define=20=
TM_MODIFY=09=091=0D=0A>=20=E2=80=A6=0D=0A>=20=0D=0A>=20Will=20it=20be=20hel=
pful=20to=20work=20with=20more=20enumerations=20(besides=0D=0A>=20=E2=80=9C=
exfat_error_mode=E2=80=9D)=0D=0A>=20at=20such=20places?=0D=0AYep,=20Will=20=
fix=20it=20on=20V2.=0D=0AThanks=20for=20your=20review=21=0D=0A>=20=0D=0A>=
=20Regards,=0D=0A>=20Markus=0D=0A=0D=0A
