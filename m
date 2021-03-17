Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CEC33E98F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 07:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhCQGSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 02:18:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43248 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhCQGSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:18:23 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210317061821epoutp028e1b0ae2e9c0fd1089da38d2b3a74478~tDMmQW5Ci1908919089epoutp02s
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 06:18:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210317061821epoutp028e1b0ae2e9c0fd1089da38d2b3a74478~tDMmQW5Ci1908919089epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615961901;
        bh=SJzaIL19l3ae6Uc0eb4UvLnbtL2WGyqqaDB2thNPw9E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rwaqzMg/TV/nNtZl1Sbgs1aO6jj9KkUE+TiisE7H1/Lf3DdJz/Gy1k/8TJja6zvdR
         Fa0N6Mf2NlNoAvLn+aE1QyFxNA+x5YWZunvoHiUvRcqS/pgnQdrSgLXa/nJ3ZGdgvq
         /+jYZCunaBWedBFyJ4SaCmt8/pq0lwDBwPz5mD0c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210317061820epcas1p21442d7dd37cf11d6508a1b1416905971~tDMlr18l31713617136epcas1p29;
        Wed, 17 Mar 2021 06:18:20 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F0g2M4N6vz4x9Q1; Wed, 17 Mar
        2021 06:18:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.6A.59147.92F91506; Wed, 17 Mar 2021 15:18:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210317061817epcas1p135b2f4e6a73eb09f0e6f37274f832623~tDMieL-ib1357413574epcas1p1I;
        Wed, 17 Mar 2021 06:18:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210317061817epsmtrp237cbfade7689345593d31cf52daad75f~tDMidci8I2771727717epsmtrp2G;
        Wed, 17 Mar 2021 06:18:17 +0000 (GMT)
X-AuditID: b6c32a38-e3dff7000000e70b-a9-60519f29f5e5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.C9.08745.82F91506; Wed, 17 Mar 2021 15:18:17 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210317061816epsmtip1f87d083b25f11b5e6507832d24a296fb~tDMiSJicm1718217182epsmtip1Q;
        Wed, 17 Mar 2021 06:18:16 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20210315041255.174167-1-hyeongseok@gmail.com>
Subject: RE: [PATCH] exfat: improve write performance when dirsync enabled
Date:   Wed, 17 Mar 2021 15:18:17 +0900
Message-ID: <9a7c01d71af5$51d17470$f5745d50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHrkVYthcVH6BAyEbje7ZFeNRCC9QIEdcHjqk6jRtA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTX1dzfmCCwa7lZhZ/J35istiz9ySL
        xeVdc9gsfkyvt9jy7wirA6vHzll32T36tqxi9Pi8SS6AOSrHJiM1MSW1SCE1Lzk/JTMv3VbJ
        OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
        v7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQwMDIFKgyISdjyoO7rAVTmCtm7LvM3MB4iqmL
        kZNDQsBE4t+3y0A2F4eQwA5GibsHHzBDOJ8YJT4+ns0K4XxmlPh84B0jTEv7/rVsEIldjBJ3
        WrezgSSEBF4ySnTPDwex2QR0JZ7c+MkMYosIeEg8bjoGto9ZIF5i97Q+sEGcAtYSZ1ZPAbOF
        Bbwk7j2cDlbDIqAqsX/pdBYQm1fAUuL470msELagxMmZT1gg5shLbH87hxniIAWJ3Z+OAtVw
        AO2ykpj7txyiRERidmcb2DcSAj/ZJXYu2wFV7yKxat8OVghbWOLV8S3sELaUxOd3e9kg7HqJ
        //PXskM0tzBKPPy0jQlkgYSAvcT7SxYgJrOApsT6XfoQ5YoSO3/PZYTYyyfx7msPK0Q1r0RH
        mxBEiYrE9w87WWA2XflxlWkCo9IsJI/NQvLYLCQfzEJYtoCRZRWjWGpBcW56arFhgQlyXG9i
        BCdGLYsdjHPfftA7xMjEwXiIUYKDWUmE1zQvIEGINyWxsiq1KD++qDQntfgQoykwqCcyS4km
        5wNTc15JvKGpkbGxsYWJmbmZqbGSOG+SwYN4IYH0xJLU7NTUgtQimD4mDk6pBiaPgs2Ho/qk
        dx6xZa6P+3pu7XdV0/jpGvdKZpkrRt52SLZPVF2/5cdfxedWs7TdfU6qxrC/V0x0FahfkCwo
        qDjnlqnHCr3M1a36s/PMVqwR4p46394n5sSdPe+PukjKfJZdkOnJotSau1lQqi9iT+Qi8W6W
        BHnjy18Dmr1Zey4mm6v9KPoUY120UaHkQ9z6g2ZdN6cUnRLYWvAmKDSf13GOlc3D5thTZa1f
        v66853I61NFLNbGh++Nd9uXPe9a/SXokHSeycUHqTA8PkWdb136asnTh0QKtr2a/r+yt5fhw
        Xs0oKa5WZHLGKu35gh7u8nFdiQadeSWadWadJ6ZW7bwVN2tplqGSlWh18bQHSizFGYmGWsxF
        xYkAQNo3RxUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnK7m/MAEg5k+Fn8nfmKy2LP3JIvF
        5V1z2Cx+TK+32PLvCKsDq8fOWXfZPfq2rGL0+LxJLoA5issmJTUnsyy1SN8ugStjyoO7rAVT
        mCtm7LvM3MB4iqmLkZNDQsBEon3/WrYuRi4OIYEdjBJdt2axdjFyACWkJA7u04QwhSUOHy6G
        KHnOKPGj7SsLSC+bgK7Ekxs/mUFsEQEvif1Nr9lBbGaBRInmL5eYIBp6GCUu93wBW8YpYC1x
        ZvUURhBbGKjh3sPpYHEWAVWJ/Uungw3lFbCUOP57EiuELShxcuYTFpAjmAX0JNo2MkLMl5fY
        /nYOM8T9ChK7Px0FO1lEwEpi7t9yiBIRidmdbcwTGIVnIRk0C2HQLCSDZiHpWMDIsopRMrWg
        ODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzg2tLR2MO5Z9UHvECMTB+MhRgkOZiURXtO8gAQh
        3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamLY2Xj8vPvV9
        pITT8626QRuLpAv93f+v2/dH+CTb6ffPtXU7LbUE7Q4zsR/Vs7+38/XXmZeuRVzl0P/0tfFE
        0qndjw3e7DjFJvDPusPL4klPX3NAiGV2zDHhCxY3266qVRbGKnsoC0e+fVgn5Mgoe/S4/uM9
        fRZaJzm3WG9odahe96jCWmzvtmjBpPfn7Y8s367ezagSeXOPpUvKjrnRCa4vovMvrwgte9jb
        sOjmjpb0FVY/niunrOg/beFt7xgdduT861+BWatVHe5/+dnJsnblfN2M292B/5Nyriw5+mLe
        fqn211eV2A99mJf9nm+JT9uJi+3et/RO/vod9ezmNmGv9JSk/fcV2gU36Pb5P1diKc5INNRi
        LipOBAA+TXBL/AIAAA==
X-CMS-MailID: 20210317061817epcas1p135b2f4e6a73eb09f0e6f37274f832623
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210315041325epcas1p11488673d4f146350dedded4b3b20fd6f
References: <CGME20210315041325epcas1p11488673d4f146350dedded4b3b20fd6f@epcas1p1.samsung.com>
        <20210315041255.174167-1-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Degradation of write speed caused by frequent disk access for cluster
> bitmap update on every cluster allocation could be improved by selective
> syncing bitmap buffer. Change to flush bitmap buffer only for the
> directory related operations.
> 
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>

Looks good.
Thanks for your work.

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>


