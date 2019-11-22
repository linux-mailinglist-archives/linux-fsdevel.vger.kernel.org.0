Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591641067B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 09:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKVIVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 03:21:40 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:20597 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKVIVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:21:39 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191122082137epoutp022cdd9d3362a8a67088f33d73a399ab75~Zbl6RdTcb1586815868epoutp02v
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2019 08:21:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191122082137epoutp022cdd9d3362a8a67088f33d73a399ab75~Zbl6RdTcb1586815868epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574410897;
        bh=dPZkvk9rCr5QXvbQHGywDicbdDPuogBkdkrVGHH2yT8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aIOLCYqVCE8Xgr4KChFBrVekY1kaB0Rj3e1XApKqgItBnUT1DF7T2iqUhEeLt4/Qc
         E44bC6/FL3ec4W3gWGgwZppm7WUPJTp/iTAVKeK2HWhISpwe2lk9OqTSj07nIGzcpR
         PRLTtocvF/BDQzypV+XkNu6j321VrxJWbDykSz6k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191122082136epcas1p31646194ba715527873e33c0fbbb30ef9~Zbl50LZZE0668106681epcas1p3r;
        Fri, 22 Nov 2019 08:21:36 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47K8Xb3VPszMqYkn; Fri, 22 Nov
        2019 08:21:35 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.9D.51241.F8A97DD5; Fri, 22 Nov 2019 17:21:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191122082134epcas1p1643b57445bfd70ed3e68c45ad6859904~Zbl4N8O7x2895428954epcas1p1R;
        Fri, 22 Nov 2019 08:21:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191122082134epsmtrp1c9c41d95390f43f71f55b07efcba9c67~Zbl4NPZJZ3273632736epsmtrp1a;
        Fri, 22 Nov 2019 08:21:34 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-bc-5dd79a8fe323
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.46.10238.E8A97DD5; Fri, 22 Nov 2019 17:21:34 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191122082134epsmtip1b3b308c3e4f4b6e47dc61f7c034458b1~Zbl38dOgK1289612896epsmtip1j;
        Fri, 22 Nov 2019 08:21:34 +0000 (GMT)
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
In-Reply-To: <0e17c0a7-9b40-12a4-3f3f-500b9abb66de@web.de>
Subject: RE: [PATCH v4 04/13] exfat: add directory operations
Date:   Fri, 22 Nov 2019 17:21:34 +0900
Message-ID: <00a001d5a10d$da529670$8ef7c350$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGvn6iTTExTp6OkCy7f8aJjab+B9AHpvZ4UAavVuMIBPbFUKQFtJvFCAqneanynm4lfkA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0wTWRjdy0xnpmjXa0X9gsZ0x2AEbWmtxamxZBOJmWRNlmj0h6apExgL
        sa90WvCRTYgiImtAZTVSNcGQNYqPKiIUAdHiE4NGUQkomgiCKBF0fWPQtqNZ/p177jnf9537
        YAh1G5XI5Lp8otclOFgqnqxrTdZrywKdVn13zUyutXcvzW2rClLc8RNX47jz3TO4zp5ugmtq
        vklyHRcOUdy3wICC+zZUSHK1Y1cU3L3hEfL3CXxDoIfmWw6fpPnGrgKKL62tRnyw9gHJn7u1
        hf+vZhYfrh+i+Ef9dWSmco1jSY4oZItejejKcmfnuuwW9o+VtqU2U5reoDWYuUWsxiU4RQub
        sTxTuyzXERmW1eQJDn+EyhQkiU1NX+J1+32iJsct+Sys6Ml2eAx6j04SnJLfZddluZ2LDXr9
        AlNEuc6RU97QRnheMBsrm8vJAnSDKUFKBvBC2F89RpSgeEaNQwj6t5Yo5MVbBIP/nqSiKjX+
        gOBT4ZyfjvMDf5OyqBlBZfgqJS9eIjhz6jURVVFYC2NfW2LuBKyDvUOtsbIEriDgymA7Gd1Q
        4sUQuvMuYmCYKdgCTcWrozSJk6CooywmUWEzVDT3UjKeDDcr+mI8gefB0SOvCHkiDYTaXyG5
        12rY908/LWsS4ODOolg2wNU0VHUcI2VDBlT2HFXIeAq8vF5LyzgRBsuK6Og8gLfAm5Yf9YsR
        vPhokbERuoJnFFEJgZMheCFVpn+DhtHDSG77K7x+v0shV1FBcZFaliRB6b3WOBnPgJIdI/Ru
        xAbGBQuMCxYYFyDwf7NKRFajaaJHctpFyeAxjb/rGhR7xynmELp2e3kYYQaxE1W78x9a1Qoh
        T9rkDCNgCDZB1dR536pWZQubNotet83rd4hSGJki576HSJya5Y78CpfPZjAtMBqN3MK0RWkm
        IztdxXy6a1Vju+ATN4iiR/T+9MUxysQCtG7+nM/a5Fn1qX0jutl5c0ffbzYeCDbSmfMLfzE9
        ymhvf5i+Lf3t+kbd6Xr7tKp4W1+X9XTW/QFq5ejnS8Ejf+bV2Z6YhbVfQ6cCSTV/GZ83+cL6
        u88eL00NzR3AZy/eduSXleqHh5V+zQqXeWcK/WWS4fKq7U/L89t6kSLYXZHynCWlHMGQQngl
        4Ts1zK953QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSnG7frOuxBn8mGFscfjyJ3aJ58Xo2
        i5WrjzJZbL0lbXH97i1miz17T7JYXN41h83i/6znrBb/37SwWGz5d4TV4tL7DywO3B47Z91l
        99g/dw27x+6bDWwefVtWMXqs33KVxWPz6WqPz5vkPA5tf8PmcfvZNpYAzigum5TUnMyy1CJ9
        uwSujDdfmtkL3rFW/N60mLWBcQ9LFyMnh4SAicTW591ANheHkMBuRomeQ93sEAlpiWMnzjB3
        MXIA2cIShw8Xg4SFBF4wSvTvtgOx2QR0Jf792c8GYosI6ElMenOYFWQOs8BCZolzcyYwQgw9
        ySSxu30X2DZOASuJHee/gA0VFrCV2NMRBhJmEVCVaLvcD1bCK2ApMXPvYzYIW1Di5MwnYHFm
        AW2J3oetjDD2soWvmSHuVJDYcfY1I8QRYRJTpzxjh6gRkZjd2cY8gVF4FpJRs5CMmoVk1Cwk
        LQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHppbmDsbLS+IPMQpwMCrx8E4o
        vxYrxJpYVlyZe4hRgoNZSYR3z/UrsUK8KYmVValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8s
        Sc1OTS1ILYLJMnFwSjUwFlqeW/T3kMTh38L/9gRWb3vdd/3twrO87SeZBE4sv+1d5W+e/OmW
        z5cfBT5HJnMxaa/tnPj9rptHcqOD5PXFR28ECm/f27mnMTSA9VnBkozIZPM1mmK7Vu84GPht
        ys7TN3bO2yy023uCrXhvAlePhIHMDK513FbTQ64tTFj9fodT8p3ZktsTHimxFGckGmoxFxUn
        AgAVuiAIyAIAAA==
X-CMS-MailID: 20191122082134epcas1p1643b57445bfd70ed3e68c45ad6859904
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052917epcas1p259b8cb61ab86975cabc0cf4815a8dc38
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052917epcas1p259b8cb61ab86975cabc0cf4815a8dc38@epcas1p2.samsung.com>
        <20191121052618.31117-5-namjae.jeon@samsung.com>
        <498a958f-9066-09c6-7240-114234965c1a@web.de>
        <004901d5a0e0$f7bf1030$e73d3090$@samsung.com>
        <0e17c0a7-9b40-12a4-3f3f-500b9abb66de@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> >> =E2=80=A6=0D=0A>=20>>>=20+++=20b/fs/exfat/dir.c=0D=0A>=20>>=20=E2=80=
=A6=0D=0A>=20>>>=20+static=20int=20exfat_readdir(struct=20inode=20*inode,=
=20struct=20exfat_dir_entry=0D=0A>=20>>=20*dir_entry)=0D=0A>=20>>>=20+=7B=
=0D=0A>=20>>=20=E2=80=A6=0D=0A>=20>>>=20+=09=09=09if=20(=21ep)=20=7B=0D=0A>=
=20>>>=20+=09=09=09=09ret=20=3D=20-EIO;=0D=0A>=20>>>=20+=09=09=09=09goto=20=
free_clu;=0D=0A>=20>>>=20+=09=09=09=7D=0D=0A>=20>>=0D=0A>=20>>=20How=20do=
=20you=20think=20about=20to=20move=20a=20bit=20of=20common=20exception=20ha=
ndling=20code=0D=0A>=20>>=20(at=20similar=20places)?=0D=0A>=20>=20Not=20sur=
e=20it=20is=20good.=0D=0A>=20=0D=0A>=20The=20software=20development=20opini=
ons=20can=20vary=20also=20for=20this=20change=20pattern=0D=0A>=20according=
=20to=20different=20design=20goals.=0D=0A>=20Is=20such=20a=20transformation=
=20just=20another=20possibility=20to=20reduce=20duplicate=0D=0A>=20source=
=20code=20a=20bit?=0D=0AI=20changed=20it=20without=20unnecessary=20goto=20a=
buse.=20Look=20at=20the=20next=20version=20later.=0D=0AThanks=21=0D=0A>=20=
=0D=0A>=20Regards,=0D=0A>=20Markus=0D=0A=0D=0A
