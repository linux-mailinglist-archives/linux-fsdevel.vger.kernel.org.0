Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A881FF2BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 15:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgFRNML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 09:12:11 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:16969 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgFRNMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:12:05 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200618131200epoutp0229f311f56aee297b0c232a2d92cace3e~ZpYHoC-G-1721917219epoutp02R
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 13:12:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200618131200epoutp0229f311f56aee297b0c232a2d92cace3e~ZpYHoC-G-1721917219epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592485920;
        bh=9GSuugBLJ/Lu9fiNSKVsbKdSr1pC/7Nb88fKu1RFidY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=A7KsDbZJkPFDZwSEp1W+zMjE0hnigQWOhk04lbR6Kg+yRIBx+akVV/FU/QwR/l6J+
         aX9JGmP6e1nrRoU2rqJmQqwlNOWUr3KPrVMX6xffGpWvAycddsdVK6MnBFQrMZKUaO
         AeTqB7XXideU2yG0f0bgqvtke49cKinNJh/n3hcc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200618131200epcas1p2cdfeb9139faf12e00a7e2a5db78c7d07~ZpYHHf8K62515325153epcas1p2S;
        Thu, 18 Jun 2020 13:12:00 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49nj5C17SrzMqYkV; Thu, 18 Jun
        2020 13:11:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.C9.18978.F186BEE5; Thu, 18 Jun 2020 22:11:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200618131158epcas1p134ea8ee9f68157fa0c82b1cecece92cd~ZpYFqIWYV0651306513epcas1p1C;
        Thu, 18 Jun 2020 13:11:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200618131158epsmtrp2c4f932e2efdbd64bf4f0e3f348f2a537~ZpYFpfNXG0187101871epsmtrp2J;
        Thu, 18 Jun 2020 13:11:58 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-ea-5eeb681f02ca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.F6.08303.E186BEE5; Thu, 18 Jun 2020 22:11:58 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200618131158epsmtip2119029c71ab894c9ab4754ae90b7ab1f~ZpYFYjMFm2323723237epsmtip2N;
        Thu, 18 Jun 2020 13:11:58 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <aac9d6c7-1d62-a85d-9bcb-d3c0ddc8fcd6@gmail.com>
Subject: RE: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
Date:   Thu, 18 Jun 2020 22:11:58 +0900
Message-ID: <500801d64572$0bdd2940$23977bc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQF0BoMPlscPSpT3Th8lCwQKqdMbhQJGtMGMAcFEUC0CM27r7Klw7EWA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmvq58xus4gwPfWS1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2Vo
        YGBkClSZkJOx9u4t1oJZXBXH5l1jaWBs4Ohi5OCQEDCR+PsDyOTiEBLYwSjRPXchE4TziVGi
        Zf9KRgjnM6NE853pQBlOsI4bKxZBVe1ilFj/7z07SEJI4CWjRNNUbxCbTUBX4smNn8wgtoiA
        nsTJk9fZQGxmgUYmiRMvs0FWcwrYSry7EQxiCgtYSiy8rgxisgioSuyepgpSzAsUbZ5xnx3C
        FpQ4OfMJC8QQbYllC18zQ1yjILH701FWiEVuEq+vfWKFqBGRmN3ZxgxypYTATA6Jmc8XsUA0
        uEjsmnSHHcIWlnh1fAuULSXx+d1eNgi7XmL3qlMsEM0NjBJHHi2EajaWmN+ykBnkUGYBTYn1
        u/QhwooSO3/PZYRYzCfx7msPKyRweSU62oQgSlQkvn/YyQKz6sqPq0wTGJVmIXltFpLXZiF5
        YRbCsgWMLKsYxVILinPTU4sNCwyRY3oTIziNapnuYJz49oPeIUYmDsZDjBIczEoivM6/X8QJ
        8aYkVlalFuXHF5XmpBYfYjQFhvVEZinR5HxgIs8riTc0NTI2NrYwMTM3MzVWEucVl7kQJySQ
        nliSmp2aWpBaBNPHxMEp1cBUb6y0+/DHvVM+sJzZ36llxZF50DbodYP1QdWNQvIb5E7e8U7o
        jJ70h6sqT6Kmp7ftePAq1n07/3PxuEU5fXDReH5+FYP9nZJ/cetSlzK6SwgvsVEp+iItl5X3
        MqdZx7Ih7VzrHJMlfvY9ayb+KP9291152IasQr2/f/z674oeaGD4cFJqw1f9TRb8c79eEnGe
        mFjrGPHpvfjuVkM7/5SEHxGcW24onnl1kqP81uUD6z+W/BI6trJ0w5arjoXKe378CfoUevnn
        /9fPPqgtsOZgXxd63tfk9o05r586PhQ7sqFKQUDujT6fs4GvUfIcx6sZD/+ef6XySuFm/E2F
        CbNaDyVcnsFYZVjTuSWvWnyGEktxRqKhFnNRcSIAaRZgyywEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXlcu43WcQdMnUYsfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLH5Mr3dg9/gy5zi7R9vkf+wezcdWsnnsnHWX3aNvyypG
        j8+b5ALYorhsUlJzMstSi/TtErgy/j/7wV4wj6uiZ89B9gbGBo4uRk4OCQETiRsrFjF1MXJx
        CAnsYJT4eekcexcjB1BCSuLgPk0IU1ji8OFiiJLnjBITt71lBullE9CVeHLjJ5gtIqAncfLk
        dTaQImaBZiaJ1i/NUENfMEo82POXEWQSp4CtxLsbwSCmsIClxMLryiAmi4CqxO5pqiBjeIGi
        zTPus0PYghInZz5hAbGZBbQleh+2MsLYyxa+ZoY4X0Fi96ejrBAnuEm8vvaJFaJGRGJ2Zxvz
        BEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcUVpa
        Oxj3rPqgd4iRiYPxEKMEB7OSCK/z7xdxQrwpiZVVqUX58UWlOanFhxilOViUxHm/zloYJySQ
        nliSmp2aWpBaBJNl4uCUamBa45q8zWSCfmSV/LInQQf8HOIaH/+aeWSGvvyRllfuPqYyRuw8
        r9YfZ1upF/xiqZbq+4jStlMm/3e++1AUkm139seV1ImPHkhyPWoQP1/nx2OTYsb7W3lnRZba
        n1lT38dkb/njxJ4U8PuTiOPq9S6Na6e5s4i4+1wzPpR8t1t70u15jJf0X/MHTJlqFRtz/l/l
        tCz5vWdWXrbiyOhYZbtZeUKLyIXfTy+k9PKfcmYRdrymueXkkYl/Lj0Skq6ycxTlnFksr7ff
        muWHUvWDqervSrabs4TffS3+YW9Gm6RbobLcglM5FzzmL7nsFPtkeseuELcG9nsXmI9/+bKq
        w9TM1Zv5ss7nrT7c8526ujcpsRRnJBpqMRcVJwIA7O/k1BcDAAA=
X-CMS-MailID: 20200618131158epcas1p134ea8ee9f68157fa0c82b1cecece92cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
        <20200616021808.5222-1-kohada.t2@gmail.com>
        <414101d64477$ccb661f0$662325d0$@samsung.com>
        <aac9d6c7-1d62-a85d-9bcb-d3c0ddc8fcd6@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Since this patch does not resolve 'VOL_DIRTY in ENOTEMPTY' problem you
> > mentioned, it would be better to remove the description above for that
> > and to make new patch.
>=20
> I mentioned rmdir as an example.
> However, this problem is not only with rmdirs.
> VOL_DIRTY remains when some functions abort with an error.
> In original, VOL_DIRTY is not cleared even if performe 'sync'.
> With this patch, it ensures that VOL_DIRTY will be cleared by 'sync'.
>=20
> Is my description insufficient?

I understood what you said. However, it is a natural result
when deleting the related code with EXFAT_SB_DIRTY flag.

So I thought it would be better to separate it into new problems
related to VOL_DIRTY-set under not real errors.

>=20
>=20
> BTW
> Even with this patch applied,  VOL_DIRTY remains until synced in the abov=
e
> case.
> It's not  easy to reproduce as rmdir, but I'll try to fix it in the futur=
e.

I think it's not a problem not to clear VOL_DIRTY under real errors,
because VOL_DIRTY is just like a hint to note that write was not finished c=
learly.

If you mean there are more situation like ENOTEMPTY you mentioned,
please make new patch to fix them.
Thanks.

>=20
>=20
> BR
> ---
> Tetsuhiro Kohada <kohada.t2=40gmail.com>
>=20
>=20


