Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255401F609B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 05:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFKDlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 23:41:11 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:46513 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFKDlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 23:41:11 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200611034108epoutp04ee5b98a59575911a99d4590337a2d222~XYErmhmOI1081210812epoutp04-
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 03:41:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200611034108epoutp04ee5b98a59575911a99d4590337a2d222~XYErmhmOI1081210812epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591846868;
        bh=V6x0CC0dSJI52/fvB4p8HDQIDD1KqNhQ5jAgQ9dlyxM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=E/vzca1LIBKpurSxR3IN96FIQGjzyt9KVRKYHhUIpEFQPPaHnapuWqvN0M/6wC5ZM
         uTu30/7191FiSorIdzvyh22f2fbnERnAuPbyopKCZCg2Cl5QYg0lOaHODjjXI9M9S3
         qCXg3dv7H0KLXQ7KbeNwvuioQ23MWgkGb0AJFjN8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200611034107epcas1p34327c2a7182298862d3f5cff9de4489b~XYErKExDL3020130201epcas1p3W;
        Thu, 11 Jun 2020 03:41:07 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49j8lk4QpqzMqYkV; Thu, 11 Jun
        2020 03:41:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.3E.29173.2D7A1EE5; Thu, 11 Jun 2020 12:41:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200611034106epcas1p195947d55fda88a49228be1ec06401cba~XYEpqcDER2338923389epcas1p1o;
        Thu, 11 Jun 2020 03:41:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200611034105epsmtrp1b6e2ec7bde217b9e3f78a3271024192c~XYEpl0L721381213812epsmtrp1H;
        Thu, 11 Jun 2020 03:41:05 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-2a-5ee1a7d244a4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.EF.08303.1D7A1EE5; Thu, 11 Jun 2020 12:41:05 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200611034105epsmtip27d4824bd0bc082146fa3cc8842c94b8e~XYEpaEU4K0594905949epsmtip2q;
        Thu, 11 Jun 2020 03:41:05 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Dan Carpenter'" <dan.carpenter@oracle.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?iso-8859-1?Q?'Pali_Roh=E1r'?= <pali@kernel.org>,
        "'Markus Elfring'" <Markus.Elfring@web.de>,
        "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>,
        "'Wei Yongjun'" <weiyongjun1@huawei.com>
In-Reply-To: <20200610172213.GA90634@mwanda>
Subject: RE: [PATCH v2] exfat: add missing brelse() calls on error paths
Date:   Thu, 11 Jun 2020 12:41:05 +0900
Message-ID: <00a801d63fa2$230d14c0$69273e40$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRrAfa6wiWBnxmC0CvH5lIv9XJ0gH3LYStqEwybXA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmvu6l5Q/jDN7cUbR4/W86i8XWW9IW
        P+beZrHYs/cki8XlXXPYLP7Pes5qsWDPaTaLLf+OsFoc/rKLzYHTY+esu+weLUfesnpsWtXJ
        5vHx6S0Wj74tqxg9Pm+S87j9bBtLAHtUjk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
        pYW5kkJeYm6qrZKLT4CuW2YO0GVKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAJD
        gwK94sTc4tK8dL3k/FwrQwMDI1OgyoScjFWn1jIXXGGqePTmPlMD4zymLkZODgkBE4mTR56z
        djFycQgJ7GCUaJhwAMr5xCjxp3k7I4TzmVHi25l+RpiWFVtPsEAkdjFKHD+3mB3Cecko8Xn7
        RRaQKjYBXYl/f/azgdgiAgYS906+AOtgFjjHJPH/5GlWkASngI7E1WV7wWxhAQ+Jf1c2MoPY
        LAKqEkuWLQGL8wpYSiw4fJQNwhaUODnzCdgCZgE9iRtTp7BB2PIS29/OYYY4T0Hi59NlQL0c
        QIutJGYtroEoEZGY3dnGDHKDhMAODokTu59CveMisWn9DDYIW1ji1fEt7BC2lMTL/jZ2kDkS
        AtUSH/dDje9glHjx3RbCNpa4uX4DK4StKLHz91xGiF18Eu++9rBCtPJKdLQJQZSoSvRdOgwN
        d2mJrvYP7BMYlWYheWwWksdmIXlsFpIPFjCyrGIUSy0ozk1PLTYsMEaO7k2M4HSrZb6Dcdrb
        D3qHGJk4GA8xSnAwK4nwCoo/jBPiTUmsrEotyo8vKs1JLT7EaAoM64nMUqLJ+cCEn1cSb2hq
        ZGxsbGFiZm5maqwkzutrdSFOSCA9sSQ1OzW1ILUIpo+Jg1OqgelSz4FPUi77//Zcyp2/4i+L
        aW71Zp4H0lIJz1tYOe3ZIvSfXmPtmCojI13h/F3mWOWutB1m6pXXTjy9Ir6L6W5N4UHH/5u4
        Fd8wp6nFTndy2fWT2Ufm2Mrapd8z7SpXd93x4L37+OqdLcu2+drvuLZOyPrCkuXPb+RtKpRZ
        sVJzroTcY78OhR/3NDVfy4U3P3ldK7fp51/B/ZyfD/5b5H11lsoJlyS1L/Zv/A2Ot3zoOKb1
        PMbl+v7MQ7Xe67LnPG7Lvrlbp3fv2pqw9R0Za0UXr5ysdyTkpP9pr2+yFssTPihwKQVP0Tld
        27bidCHLbEdujd8fUid0SOXtn/Ow8rb/h/YbbObXPFa/+N6uMXW9EktxRqKhFnNRcSIATWuw
        s0AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvO7F5Q/jDNY2m1u8/jedxWLrLWmL
        H3Nvs1js2XuSxeLyrjlsFv9nPWe1WLDnNJvFln9HWC0Of9nF5sDpsXPWXXaPliNvWT02repk
        8/j49BaLR9+WVYwenzfJedx+to0lgD2KyyYlNSezLLVI3y6BK2PVqbXMBVeYKh69uc/UwDiP
        qYuRk0NCwERixdYTLF2MXBxCAjsYJRbdvgCVkJY4duIMcxcjB5AtLHH4cDFEzXNGiVl3z4PV
        sAnoSvz7s58NxBYRMJC4d/IF2CBmgStMEvu2zmcDaRYSqJVYc1gUpIZTQEfi6rK9rCC2sICH
        xL8rG5lBbBYBVYkly5aAxXkFLCUWHD7KBmELSpyc+YQFxGYGmn//UAcrhC0vsf3tHGaIOxUk
        fj5dxgqySkTASmLW4hqIEhGJ2Z1tzBMYhWchmTQLyaRZSCbNQtKygJFlFaNkakFxbnpusWGB
        UV5quV5xYm5xaV66XnJ+7iZGcMRpae1g3LPqg94hRiYOxkOMEhzMSiK8guIP44R4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzfp21ME5IID2xJDU7NbUgtQgmy8TBKdXA1LtzXvXkK5f9mKuvMk7g
        qqnN3BW/3WLb5CmNqt1fb0eu1/u97P3WMhUuD8M67SPzxZ9On17zz3/z/glc1wWVxQ4e5s24
        /nVeDsuKhGNL1rpNcKxpCXSu7Fh+bQtPTLBWSaSPn7vCBQejKUaN09/ofCmZ+m9a/qFVi8O2
        x03+rpOuri7aZqmodKPxwE+W2pNnOu4vebVwqRiviCFTv7IQj9rE/86WjuaCEv2WNauLV3zY
        MjXZ/LDpm6XaT9nOlVdHLHTYGm0nps1w/+fkVzvPuLrenfTu+oOU1Qqsm5Kefl1nKDhDaqW4
        5aLf3LpnrR2zWrj4TRmW9r7jeOfiICq6Z1L7mwPepzWvXFVrbtS6psRSnJFoqMVcVJwIAFwI
        fD4nAwAA
X-CMS-MailID: 20200611034106epcas1p195947d55fda88a49228be1ec06401cba
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200610172239epcas1p1facf5f0026208683a593eeb7271c8cce
References: <CGME20200610172239epcas1p1facf5f0026208683a593eeb7271c8cce@epcas1p1.samsung.com>
        <20200610172213.GA90634@mwanda>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> If the second exfat_get_dentry() call fails then we need to release "old_bh" before returning.  There
> is a similar bug in exfat_move_file().
> 
> Fixes: 5f2aa075070c ("exfat: add inode operations")
> Reported-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied. Thanks!

