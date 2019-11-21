Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FA7104DB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 09:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUITi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 03:19:38 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:62968 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKUITh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:19:37 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191121081933epoutp03de450951b85b1518cf0cb56df088216d~ZH60qaVRF2327223272epoutp03b
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 08:19:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191121081933epoutp03de450951b85b1518cf0cb56df088216d~ZH60qaVRF2327223272epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574324373;
        bh=hyW9msNtcA69Qoqns6VYzom8WeRUwrXjtKPDtXTAGKQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MM8zl29VS7UUjHCW+lazL5/2X+WDGhmAl8L8nQJVKS+tAXqvNYzdvwE0fKZzD/zxf
         MehChiNklNAaF+A6JjFUtIzVMNrhBDsq9DiyY7WtPwXkylLElfeDojtLmYQHyVDdTf
         PRW05ydfKM0dhxb5NbvBF4yS/Ts3TaXYjUtpmV0k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191121081932epcas1p1e3dffd93eb9098aeba6b0a973eb9bbc5~ZH6zt7T3Z1859818598epcas1p1b;
        Thu, 21 Nov 2019 08:19:32 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47JXXg1gdczMqYlm; Thu, 21 Nov
        2019 08:19:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.87.04072.39846DD5; Thu, 21 Nov 2019 17:19:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191121081930epcas1p2739cddbebf5cf902b27090a19cbf4406~ZH6yTg72Q0212202122epcas1p2p;
        Thu, 21 Nov 2019 08:19:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191121081930epsmtrp251f133014cbb58830231266be273307c~ZH6ySrMvV0911809118epsmtrp2b;
        Thu, 21 Nov 2019 08:19:30 +0000 (GMT)
X-AuditID: b6c32a35-9a5ff70000000fe8-e5-5dd648939311
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.93.03654.29846DD5; Thu, 21 Nov 2019 17:19:30 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121081930epsmtip1e89010449c7ec453602de874dc049f54~ZH6yFwMBD0989609896epsmtip1S;
        Thu, 21 Nov 2019 08:19:30 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Markus Elfring'" <Markus.Elfring@web.de>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Daniel Wagner'" <dwagner@suse.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Nikolay Borisov'" <nborisov@suse.com>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linkinjeon@gmail.com>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <df089831-038c-3b39-6ec7-684d1f698756@web.de>
Subject: RE: [PATCH v4 10/13] exfat: add nls operations
Date:   Thu, 21 Nov 2019 17:19:30 +0900
Message-ID: <000f01d5a044$65ff7b40$31fe71c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AQGvn6iTTExTp6OkCy7f8aJjab+B9AJDFxe8AWy8vCACJQwQE6eyoeVA
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0hTcRTut3t3d2cubmvVrxmxbkVqbO42pzfR6EXdMMQIepHYTS+bucdl
        d5MsAqOnI3rYg1xKRWhk0SqXLtMk7UEPizSzlz1IS3NkJdXAyLZdK//7zjnfd875fg8cUd7D
        1Hiezck5bKyFxKLQmuY4rfYQ8zRL/7Y7mm5+XyKjt5/2YvTZc7ck9JUXMXRH5wuErm+4i9Jt
        dWUYPeT5KKWHAjtQ2vf7ppRu7f+CzhvNXPV0ypjG8vMy5trzIozZ56sCjNfXjjLV97cwA5en
        ME21AYx5+aEGzZSvtaSaOTaXc2g4W449N89mSiPTV2QvzDYm6SktNYdOJjU21sqlkYuWZWoX
        51lCy5KaAtbiCqUyWUEgE+amOuwuJ6cx2wVnGsnxuRae0vM6gbUKLptJl2O3plB6/WxjiLne
        Yg76j0r4AXzTpd4HSBF4J3MDOQ6JRPh6/17gBlG4kvADWNT2ChODbwC6D7ejYvADwJ6+O/8k
        R7pPSMVCA4DHyiokYvAJwOr+YhBmYYQW/v7ViIWxitDBkkBzRIEQpQi82duChgtyIgUGn9Ug
        YTyOSIbdteURjBIz4M6XbyKNFMQceKPuzDAeC++WdkW0CDELVp7qQ8SVNNDf0gfEvAoeL96F
        iIMXw6fXh4DIqZTBlp5UN8BDeBF8EpglpsfBT3d8w87UcOBzAyZStsCvjcPd94Tc/0wTsQE+
        916UhikIEQe9dQlieiq8Olg+vMAY+Pn7XqnYRQH37FKKlBlwX2uzRMQx0L37i+wAID0jbHlG
        2PKMsOL5P+wkQKvABI4XrCZOoHhq5F1fBpF3HG/0g8MPlzUBAgdktMIc256llLIFQqG1CUAc
        IVWK+o4nWUpFLlu4mXPYsx0uCyc0AWPo1A8i6vE59tCvsDmzKeNsg8FAJyYlJxkN5EQFHnyc
        pSRMrJPL5ziec/zVSXC5ugg8CKxT6Ve/iS45tf4GWu/64E/J63qUHN/TVhWn7VqSETWYoZsS
        M2nd5LlUecfyitHX1hTwCTM7jy0f7MjR5he/8xn5lab+jHzVqNrWiseJW30bFaum9VKFF/n9
        0sr02zvmB6cbvOpBotN7AT8gk2/Y5m5s18UGFkysDG56tVRWJyVRwcxS8YhDYP8ACKk1Ed0D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSnO4kj2uxBlPu6VgcfjyJ3aJ58Xo2
        i5WrjzJZbL0lbXH97i1miz17T7JYXN41h83i/6znrBb/37SwWGz5d4TV4tL7DywO3B47Z91l
        99g/dw27x+6bDWwefVtWMXqs33KVxWPz6WqPz5vkPA5tf8PmcfvZNpYAzigum5TUnMyy1CJ9
        uwSujA1XWlgKjrBX9F59x9jA+Ja1i5GTQ0LARGLq0/lANheHkMBuRonHvz4xQiSkJY6dOMPc
        xcgBZAtLHD5cDFHzglFi1YnNYDVsAroS//7sZwOxRQT0JCa9OQw2iFlgIbPEuTkTGCE63jFK
        nPp5jgmkilPASuLHjW3MILawgLnE0+1zwWwWAVWJ1tv3wabyClhKHNy1HMoWlDg58wkLiM0s
        oC3R+7CVEcZetvA1M8SlChI7zr6GiotIzO5sY4a4yE3i2r7/jBMYhWchGTULyahZSEbNQtK+
        gJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcHRqae5gvLwk/hCjAAejEg9vhsbV
        WCHWxLLiytxDjBIczEoivHuuX4kV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvs071ikkEB6Yklq
        dmpqQWoRTJaJg1OqgTGF6aLX2ouvPJjTmQ5x3nqzcU2S/ZtrtxIPSFhxzPz81XpRexX7Hecp
        ctmz1gTI2tzcWrouO23vHqWs7+8stj4rvpzgNUt67oOD+3i+86X0vS1703Fohfk/wVO8cQFW
        718q5s1ePePXao9rqlOUgqKmnvjuqZIq+FLxumdaRefkQ0mL1vfYMEgqsRRnJBpqMRcVJwIA
        CwMtH8oCAAA=
X-CMS-MailID: 20191121081930epcas1p2739cddbebf5cf902b27090a19cbf4406
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052920epcas1p3e5b6c0251e869e265d19798dbeebab4e
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052920epcas1p3e5b6c0251e869e265d19798dbeebab4e@epcas1p3.samsung.com>
        <20191121052618.31117-11-namjae.jeon@samsung.com>
        <df089831-038c-3b39-6ec7-684d1f698756@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +	exfat_msg(sb, KERN_ERR,
> > +			=22failed to load upcase table (idx : 0x%08x, chksum :
> 0x%08x, utbl_chksum : 0x%08x)=5Cn=22,
> > +			index, checksum, utbl_checksum);
> > +
> > +	ret =3D -EINVAL;
>=20
> Can a blank line be omitted between the message and the error code?
Okay.
>=20
>=20
> > +release_bh:
> > +	brelse(bh);
> > +	exfat_free_upcase_table(sb);
> > +	return ret;
> > +=7D
>=20
> I got the impression that the resource management is still questionable
> for this function implementation.
>=20
> 1. Now I suggest to move the call of the function =E2=80=9Cbrelse=E2=80=
=9D=20to=20the=20end=0D=0A>=20=20=20=20of=20the=20while=20loop.=20The=20lab=
el=20=E2=80=9Crelease_bh=E2=80=9D=20would=20be=20renamed=20to=20=E2=80=9Cfr=
ee_table=E2=80=9D=0D=0A>=20then.=0D=0AOkay.=0D=0A>=20=0D=0A>=202.=20Can=20a=
=20variable=20initialisation=20be=20converted=20to=20the=20assignment=20=E2=
=80=9Cret=20=3D=20-EIO;=E2=80=9D=0D=0A>=20=20=20=20in=20an=20if=20branch?=
=0D=0AOkay,=20Will=20fix=20it=20on=20v5.=0D=0A=0D=0AThanks=20for=20your=20r=
eview=21=0D=0A>=20=0D=0A>=20Regards,=0D=0A>=20Markus=0D=0A=0D=0A
