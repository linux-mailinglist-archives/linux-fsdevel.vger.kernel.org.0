Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96F1F3250
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 04:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgFICgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 22:36:48 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:30723 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgFICgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:36:47 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200609023643epoutp04f9476cf5cf88ab1fa3d2bbea2c2e77d6~Wv535UHpr1337713377epoutp04K
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 02:36:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200609023643epoutp04f9476cf5cf88ab1fa3d2bbea2c2e77d6~Wv535UHpr1337713377epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591670203;
        bh=dBudZ6Mzu64cqZvBWCOMU39GBABi7dxiLh2TloHh7xM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HRLZafzbqWBw2fVCMKIArHgAIaj0q/9xMGCD0/X9tKXhdGQWl3Xoz+DUKfMb51LXw
         XNyNIUK0aEA/XLE+0kIzQguVG6JeXVlLkD3EAjLJKwH6E41lDT0c5zAS/Ba84p99us
         BUiBhp2VRdBz31CdrmYvYyC0OvnxS+Bv7kKiuu6M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200609023643epcas1p1f40472c6b6c3028f08821cfe28be6b2f~Wv53nyh5Z2369223692epcas1p1M;
        Tue,  9 Jun 2020 02:36:43 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49gvQL1T9szMqYkX; Tue,  9 Jun
        2020 02:36:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.7A.19033.4B5FEDE5; Tue,  9 Jun 2020 11:36:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200609023635epcas1p319a4528b2a0996b407f2e503baa83816~Wv5wu_wAt3190731907epcas1p3c;
        Tue,  9 Jun 2020 02:36:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200609023635epsmtrp10b458805a6b7e8f0da961a09ea5e6579~Wv5wuXg7s0902109021epsmtrp1y;
        Tue,  9 Jun 2020 02:36:35 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-d5-5edef5b4b154
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.00.08303.3B5FEDE5; Tue,  9 Jun 2020 11:36:35 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200609023635epsmtip2531ed9068bfa9cb5a76ca23a41ae2cb6~Wv5weGwVO1207712077epsmtip2D;
        Tue,  9 Jun 2020 02:36:35 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Hyeongseok.Kim'" <hyeongseok@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <sj1557.seo@samsung.com>
In-Reply-To: <1591663760-6418-1-git-send-email-Hyeongseok@gmail.com>
Subject: RE: [PATCH] exfat: clear filename field before setting initial name
Date:   Tue, 9 Jun 2020 11:36:35 +0900
Message-ID: <00b601d63e06$cb54b360$61fe1a20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKanRnxI8L/ZN3E+aSRuMvHOIRptQGb8AD6pznxIKA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmnu6Wr/fiDB4vYrf4O/ETk8WevSdZ
        LLb8O8LqwOyxc9Zddo++LasYPT5vkgtgjsqxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDU
        NbS0MFdSyEvMTbVVcvEJ0HXLzAFapKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MDQo0CtOzC0uzUvXS87PtTI0MDAyBapMyMm40/+XvaCZvWJp51XmBsZrrF2MnBwSAiYSp/cf
        BLK5OIQEdjBKbF1wiR3C+cQosfj0LSYI5zOjxNlfi5hhWpbMf8oGkdjFKHH762F2kISQwEtG
        iSldOSA2m4CuxL8/+9lAbBEge/WSbWDNzAK2Emcf/AWKc3BwCrhIzJ0WAhIWFvCRaNo7iQXE
        ZhFQkfj05ivYebwClhKPvs+FsgUlTs58wgIxRl5i+9s5UPcoSPx8uowVYpWVRPvKrWwQNSIS
        szvbmEHulBB4yy5xdO1VFogGF4lL7xqg/heWeHV8CzuELSXxsr+NHeQ2CYFqiY/7oeZ3MEq8
        +G4LYRtL3Fy/gRWkhFlAU2L9Ln2IsKLEzt9zGSHW8km8+9rDCjGFV6KjTQiiRFWi79JhJghb
        WqKr/QP7BEalWUgem4XksVlIHpiFsGwBI8sqRrHUguLc9NRiwwIj5KjexAhOglpmOxgnvf2g
        d4iRiYPxEKMEB7OSCG/1gztxQrwpiZVVqUX58UWlOanFhxhNgUE9kVlKNDkfmIbzSuINTY2M
        jY0tTMzMzUyNlcR51WQuxAkJpCeWpGanphakFsH0MXFwSjUwGRWkzDtt0NRxk/c3t9NExWtL
        JLM4DjnO03jFb2RtuN12S+9W/vvpLOJ81tEvNvafcjtS/PZnCu+K5nTlWo+Gs5/0PuR1H/IO
        1U98HOsVcX9L5ak04/CN4du3cKf813JY902/o7FojxInl99JKZauTZVLXO7Pm8s758km7+UR
        e0697Le7f2qDfUVnxunX77JqrK7Y5LxX8T+woN7teE7/dKmZkhKRve9kn0os/fk8/cvx80F7
        55s3CDt28JvGzO+U+dxa5X/N5nappwHTosd+xzcJPzlbl3W2IX+y0IfNR9SNXJVWeXVuXPen
        xOvmqZVC05Y/Mb/Bq7/jQg6nRJWR9IWq6S51JRoeM8tjnWSUWIozEg21mIuKEwFEI5gYCwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSvO7mr/fiDOZ0a1v8nfiJyWLP3pMs
        Flv+HWF1YPbYOesuu0ffllWMHp83yQUwR3HZpKTmZJalFunbJXBl3On/y17QzF6xtPMqcwPj
        NdYuRk4OCQETiSXzn7J1MXJxCAnsYJRYs2M5G0RCWuLYiTPMXYwcQLawxOHDxRA1zxklbv69
        xQRSwyagK/Hvz36wehEge/WSbcwgNrOAvcT3rQeZIBqmMkrsWdHBDjKIU8BFYu60EJAaYQEf
        iaa9k1hAbBYBFYlPb76CHcQrYCnx6PtcKFtQ4uTMJywgrcwCehJtGxkhxstLbH87hxniTAWJ
        n0+XsUKcYCXRvnIrG0SNiMTszjbmCYzCs5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnltsWGCU
        l1quV5yYW1yal66XnJ+7iREcDVpaOxj3rPqgd4iRiYPxEKMEB7OSCG/1gztxQrwpiZVVqUX5
        8UWlOanFhxilOViUxHm/zloYJySQnliSmp2aWpBaBJNl4uCUamAqy9+iE1e3z2OR07FGs9/t
        e8xUj2saWLvViMZtD9jVotC4ROFDV9LE2G1lT7K+/Z3ZoKfkpzHJMHHP0xyP5oOHi+YX31p1
        99Ujx/lJi+9VFd4JmZX47YTMC9cICdOquMf/i1uWML6OdZ00y2FC0P6X2ZmKpUop2888z5l6
        dvauoJZ7B8/8nDh/fVCS88vbP9vMnK7wmaVZHjzMF/FaODF+T9860Y9mDw7XqlsstvuzSeFV
        UdApvw3y5yslr8/8+Gu331Pzwulm8d+WhTKftes0VuvzEFS+9WD1ub0mEdHzFxnVv+kz33Vw
        c77piahD+94++lH9Ovvb/sln9OqWah7eNafgX8bBDzf/FelwnGmuUGIpzkg01GIuKk4EAD/6
        T3T1AgAA
X-CMS-MailID: 20200609023635epcas1p319a4528b2a0996b407f2e503baa83816
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609004931epcas1p3f2b10c4dea5b6d236fd1741532b529ec
References: <CGME20200609004931epcas1p3f2b10c4dea5b6d236fd1741532b529ec@epcas1p3.samsung.com>
        <1591663760-6418-1-git-send-email-Hyeongseok@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hyeongseok,

> Some fsck tool complain that padding part of the FileName Field is not set to the value 0000h. So
> let's follow the filesystem spec.
> 
> Signed-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
> ---
>  fs/exfat/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index de43534..6c9810b 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -424,6 +424,9 @@ static void exfat_init_name_entry(struct exfat_dentry *ep,
>  	exfat_set_entry_type(ep, TYPE_EXTEND);
>  	ep->dentry.name.flags = 0x0;
> 
> +	memset(ep->dentry.name.unicode_0_14, 0,
> +		sizeof(ep->dentry.name.unicode_0_14));
> +
>  	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
>  		ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
>  		if (*uniname == 0x0)
Wouldn't it be better to fill the rest with 0x0000 in this loop?
> --
> 2.7.4


