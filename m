Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76F1E755A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 07:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2F2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 01:28:30 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22279 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2F23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 01:28:29 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200529052827epoutp0125dbd21a65392ca0310c1e8f994c92c2~TaJq3TufH2329123291epoutp018
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 05:28:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200529052827epoutp0125dbd21a65392ca0310c1e8f994c92c2~TaJq3TufH2329123291epoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590730107;
        bh=30PGEpM2FZ1Ztf7lzRM4EpjEdOlJgRm/2xBlLToQ7FA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=j/c93bI4Klcyl7yZZN6BBzTv3dHWpdP1Jypn4EzEY/gwKVyPkbd5BaGZfKwNvxXwL
         DuYr5bHr4h24Pjp1dmPyeNeXuIAg3+foia/KVpHWdIOR/vb6WB3gTUqnVICU2r6r7M
         Nr2bQ9XUkgDsVyOA2iWJho+E19XebAUD9LuHgLuc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200529052826epcas1p22e313fa28009238419e1d35078953ae0~TaJqnm-T63213332133epcas1p2X;
        Fri, 29 May 2020 05:28:26 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49YClY4NwYzMqYkk; Fri, 29 May
        2020 05:28:25 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.25.18978.97D90DE5; Fri, 29 May 2020 14:28:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200529052825epcas1p4ed6ebe75442c5d36155ced667cf143a9~TaJpG6gTp1147011470epcas1p4s;
        Fri, 29 May 2020 05:28:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529052825epsmtrp1f3ff76090baf2ecb3a3a662b49cf330f~TaJpGPw443064530645epsmtrp1Q;
        Fri, 29 May 2020 05:28:25 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-96-5ed09d79ea72
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.37.08382.97D90DE5; Fri, 29 May 2020 14:28:25 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200529052825epsmtip130d3ca9aad04ce67f71da388e7cd4f01~TaJo9P7yW2377723777epsmtip1E;
        Fri, 29 May 2020 05:28:25 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <48fe0abe-8b1c-bea2-820f-71ca141af072@gmail.com>
Subject: RE: [PATCH 1/4] exfat: redefine PBR as boot_sector
Date:   Fri, 29 May 2020 14:28:24 +0900
Message-ID: <0bd201d63579$f9b03d00$ed10b700$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIZHoFQlzEF60igWH7M0f/y+WBvNgEl0VwLAqo9m3IBfJCfIKgOSP6w
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmnm7l3AtxBsf3Klj8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYvFjer0Du8eXOcfZPdom/2P3aD62ks1j56y77B59W1Yx
        enzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISdjztr5bAVzOStOXW5ib2Ccy97FyMkhIWAi8XrqZ9YuRi4OIYEdjBJrjx1ig3A+
        MUosmLmOEcL5xiix8+hSRpiWvq1LmCASexkluk5uhqp6ySjx4eNxJpAqNgFdiSc3fjKD2CIC
        ehInT15nA7GZBRqZJE68zAaxOQVsJX5tbQKrERawlph86SpYDYuAqsSnrevA4rwClhKvpv1j
        g7AFJU7OfMICMUdeYvvbOcwQFylI7P50lBVil5vE74snWSFqRCRmd7YxgxwnITCXQ2L+jg9Q
        DS4SL4/tYIOwhSVeHd8CDQ0piZf9bVB2M6NE311PiOYWRolVO5qgGowlPn3+DPQyB9AGTYn1
        u/QhwooSO3/PZYRYzCfx7msPK0iJhACvREebEESJisT3DztZYFZd+XGVaQKj0iwkr81C8tos
        JC/MQli2gJFlFaNYakFxbnpqsWGBIXJ0b2IEJ1Qt0x2ME99+0DvEyMTBeIhRgoNZSYR3zdnz
        cUK8KYmVValF+fFFpTmpxYcYTYGBPZFZSjQ5H5jS80riDU2NjI2NLUzMzM1MjZXEecVlLsQJ
        CaQnlqRmp6YWpBbB9DFxcEo1MM2y5ZpVWHareYPtVqvMnMc/vLhEoqOUMmV+vGSK3L+nouNW
        mOGKyQG2wkrThCce/pGc4O62S/PNf4bX9g5y9ybwGzTuKV0lW1yrdHviln1fmZxe/S6S0hVd
        0MqwQ4djskRPvd6001bbJyR0Sc3/Yar1bmfYKZ/sdypr4xdxPbX32f10zX3Vp/mmXgYZu8Qs
        w70VTs9fEz1N/ECs/tS5N4N/i28/mtiYealbznyPmdeu2Ph9n2o/KhnVsGWoSF3vP7KIyY/X
        M74gVsTyk5LbMtsFCtOXecrLmUlF8l5dmnLlDPvtkDerfCokVOcVCfyfnP5+7ZuYHl82Id+Q
        xRXRE9nP/2yvO/TXTMNw89k5SizFGYmGWsxFxYkAo/dg9jEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTrdy7oU4g19zOS1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKmLN2PlvBXM6KU5eb2BsY57J3MXJySAiYSPRtXcLUxcjF
        ISSwm1Hi6d2bQA4HUEJK4uA+TQhTWOLw4WKIkueMErNnb2ME6WUT0JV4cuMnM4gtIqAncfLk
        dTaQImaBZiaJ1i/NUENfMkqs6JwIto1TwFbi19YmsA5hAWuJyZeusoHYLAKqEp+2rgOL8wpY
        Srya9o8NwhaUODnzCQuIzSygLdH7sJURwpaX2P52DjPEBwoSuz8dZYW4wk3i98WTrBA1IhKz
        O9uYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg
        uNLS3MG4fdUHvUOMTByMhxglOJiVRHjXnD0fJ8SbklhZlVqUH19UmpNafIhRmoNFSZz3RuHC
        OCGB9MSS1OzU1ILUIpgsEwenVANTVrSda5fEpk/Kq56tKZ/IGPWhf06X7BuxuzLKPArnjjx6
        53ZL4tjvhS5lyreCU55oWH0zea2lpXhkpQnTn4es0v5hrg3mvMumZmQv0r5prHTKaauoWvKa
        eXNOf9Tk3vYs66/U/8Ry8QO+b+bJf9V7+MtXJv5ozWPv58vm27S/8t6VZLC9opFNq+b4i/ni
        8jrLTZNN/e+6eG132fXRicd6T//Blw3zp7lsLNk3NXy7+7cZyQc6b/6RjGflVWqUN9a9NuHM
        pg7esrXtN7ZcW5E800lC+cH1ZZU+/76rPwnYtW7CZN+LTJIZSVPsu43Wnnv+emeMeZ/gK7b1
        E/urd+/X2pG5X2ynbvOkvVOqN1gpKbEUZyQaajEXFScCAKUurGwaAwAA
X-CMS-MailID: 20200529052825epcas1p4ed6ebe75442c5d36155ced667cf143a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200525115110epcas1p491bfb477b12825536e81e376f34c7a02
References: <CGME20200525115110epcas1p491bfb477b12825536e81e376f34c7a02@epcas1p4.samsung.com>
        <20200525115052.19243-1-kohada.t2@gmail.com>
        <040701d634b1$375a2a40$a60e7ec0$@samsung.com>
        <48fe0abe-8b1c-bea2-820f-71ca141af072@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > [snip]
> >> +/* EXFAT: Main and Backup Boot Sector (512 bytes) */ struct
> >> +boot_sector {
> >> +	__u8	jmp_boot[BOOTSEC_JUMP_BOOT_LEN];
> >> +	__u8	oem_name[BOOTSEC_OEM_NAME_LEN];
> >
> > According to the exFAT specification, fs_name and BOOTSEC_FS_NAME_LEN
> > look better.
> 
> Oops.
> I sent v2 patches, before I noticed this comment,
> 
> I'll make another small patch, OK?

No, It make sense to make v3, because you have renamed the variables in
boot_sector on this patch.

> BTW
> I have a concern about fs_name.
> The exfat specification says that this field is "EXFAT".
> 
> I think it's a important field for determining the filesystem.
> However, in this patch, I gave up checking this field.
> Because there is no similar check in FATFS.
> Do you know why Linux FATFS does not check this filed?
> And, what do you think of checking this field?

FATFS has the same field named "oem_name" and whatever is okay for its value.
However, in case of exFAT, it is an important field to determine filesystem.

I think it would be better to check this field for exFAT-fs.
Would you like to contribute new patch for checking it?

> 
> BR

