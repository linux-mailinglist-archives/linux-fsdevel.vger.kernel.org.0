Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E548447598E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 14:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242824AbhLONXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 08:23:09 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:49100 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbhLONXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:23:08 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211215132306epoutp01f877a9d2aad40ccf8033bd228e78c8a9~A8GZAuA6y0492804928epoutp01H
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Dec 2021 13:23:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211215132306epoutp01f877a9d2aad40ccf8033bd228e78c8a9~A8GZAuA6y0492804928epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639574586;
        bh=pKmeqjyTNT934u0IZtusrpZ6dFyEyLYgWowpW5Xi76Y=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=D96aSDykwNy+TvDq9Md7dvSKWILda1CnV/CGJVyh9HcL1G9cwkml0ByX3uK5pxe+O
         pqKu9bwrN693WeserFrpLFKFxJYm0EJlniEotN7Nj28KHRRQmRmvrVzf9bLws8WXGx
         devtFgHQyk1Fbt356ImM8YUn1oRc6VBus6O7wwfM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211215132305epcas1p3d2e2d503104b409a1931ac3cbc0d5d84~A8GYm7Fs82163321633epcas1p3i;
        Wed, 15 Dec 2021 13:23:05 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JDbXS1nlkz4x9Pr; Wed, 15 Dec
        2021 13:23:04 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.F9.21932.80CE9B16; Wed, 15 Dec 2021 22:22:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211215132303epcas1p39d451d7db07a8d76f86bf6adb0c162f6~A8GWdFSTC2299222992epcas1p3c;
        Wed, 15 Dec 2021 13:23:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211215132303epsmtrp19ca7dd578cd33ba1101b961aa91ad901~A8GWce3yu1874518745epsmtrp1Q;
        Wed, 15 Dec 2021 13:23:03 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-69-61b9ec085fc0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.D7.08738.83CE9B16; Wed, 15 Dec 2021 22:23:04 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211215132303epsmtip16f52d4482c76164a7c79e94d2ddf55a7~A8GWSrkB01481714817epsmtip1F;
        Wed, 15 Dec 2021 13:23:03 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     <linkinjeon@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <HK2PR04MB38919EB7F957C4BBB0B94C3781769@HK2PR04MB3891.apcprd04.prod.outlook.com>
Subject: RE: [PATCH] exfat: remove argument 'sector' from exfat_get_dentry()
Date:   Wed, 15 Dec 2021 22:23:03 +0900
Message-ID: <054301d7f1b6$e3d380f0$ab7a82d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKBraH801cCLk1f6v1nGU93CDkKTAMc91kuqscqS9A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmri7Hm52JBh0zOS0mTlvKbLFn70kW
        i8u75rBZbPl3hNWBxWPTqk42j74tqxg9Pm+SC2COyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
        NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqmpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
        Si1IySkwK9ArTswtLs1L18tLLbEyNDAwMgUqTMjO2L1sD0vBfpaKAy97WBsYLzF3MXJwSAiY
        SCy4wtvFyMUhJLCDUWLXk62MEM4nRomubY/ZIZzPjBLLt88D6uAE61jX8oANIrGLUeL+y8es
        EM5LRon9UzexglSxCehKPLnxE6xDREBaYt7FKUwgNrNAvMTiHcfZQGxOgViJ9ovr2UFsYQEf
        icMNH8DiLAKqEqd/bAaL8wpYSpzubGSGsAUlTs58wgIxR15i+9s5UBcpSOz+dJQVYpeVxNyd
        X9kgakQkZne2MYMcJyHwlV3izfqnLBANLhLvWu9ANQtLvDq+hR3ClpJ42d/GDtGwilFiw/rL
        bBDOakaJm7eus0CCzF7i/SULEJNZQFNi/S59iF5FiZ2/5zJCLOaTePe1hxWimleio00IokRF
        4vuHnSwwq678uMo0gVFpFpLXZiF5bRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAEHtvJ+bmbGMEp
        UctiB+Pctx/0DjEycTAeYpTgYFYS4V1qsDNRiDclsbIqtSg/vqg0J7X4EKMpMLAnMkuJJucD
        k3JeSbyhiaWBiZmRiYWxpbGZkjjvc//piUIC6YklqdmpqQWpRTB9TBycUg1MSdeWzzywLb98
        2tfU9uC1GiFNX5b5brCLeFi5/l/Zl13+arKW39it/dde0tiotqe/Yv4E9iPF0e7LPSasSma4
        pb9JkTXqvMJ/b/MCnds28zRyeSeeZBR8VpSlUL1N29HomfxftWOs+w+3a/W1MXLtSrcVqO/l
        TW/j6Hzaz9f9gEP9S6+5urTMrn1qd0rM4q6lfTxgJnHvofiCBQKtOdbCbc3Mq59/330n9Pse
        G/EWXsaUSxNDJ65f8MaQ3zwhM9/o2YmF29weKjDo+ge8zD5SFPpR5EFh991VNSt/K981stO4
        6XH+gk+A+CaJ+3/L3i1gnik0/c7UzmclX+I7s7er3RRkfyulYJXz7+7977FKLMUZiYZazEXF
        iQCLE01+EgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSnK7Fm52JBs9eM1tMnLaU2WLP3pMs
        Fpd3zWGz2PLvCKsDi8emVZ1sHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJWxe9keloL9LBUH
        XvawNjBeYu5i5OSQEDCRWNfygK2LkYtDSGAHo0Rf+w2WLkYOoISUxMF9mhCmsMThw8UQJc8Z
        JXp+PWEF6WUT0JV4cuMn2BwRAWmJeRenMIHYzAKJEmeWtLFCNKxjlLj04gcLSIJTIFai/eJ6
        dhBbWMBH4nDDBzYQm0VAVeL0j81gcV4BS4nTnY3MELagxMmZT8DuYRbQk2jbyAgxX15i+9s5
        UPcrSOz+dJQV4gYribk7v7JB1IhIzO5sY57AKDwLyaRZCJNmIZk0C0nHAkaWVYySqQXFuem5
        xYYFRnmp5XrFibnFpXnpesn5uZsYwXGhpbWDcc+qD3qHGJk4GA8xSnAwK4nwLjXYmSjEm5JY
        WZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD04oUQ7N8lfz7M8Ty
        379kyOo8HGbHdPORqsPBO9yrOXxymbr3mzMeZvnAFu6tvUec7wL7YSPBTJutfq9OTWfNl1eQ
        XxpqXL3886/DVgpu3Pl2u95Xmazwy1uTv/Gye2+ZJ9OBmOg9U10/dlg8+7j7iMz242vO3Q4r
        WjtpyzGRJ/Mbu7buPOrJpMFxxMB//ne7e6lrD5nP9rjTNu2s4rdrG5i9BWrP7lp4bu7y3d5P
        Fn5yUHY6oHf2Tt2qPS/+T9zWqf2of8vV3DNSM1wELml4tIrN0xfwVOCR+cYlcvOBwbPp7brc
        WyU2LJweIn6um19T865Bn1nfnatbzhR92Vs2vWbHpeV/AqUd7Tgc3iqu/q3EUpyRaKjFXFSc
        CADreoH1+gIAAA==
X-CMS-MailID: 20211215132303epcas1p39d451d7db07a8d76f86bf6adb0c162f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211215051307epcas1p30f013371a7f2e346ce5851b0157abedc
References: <CGME20211215051307epcas1p30f013371a7f2e346ce5851b0157abedc@epcas1p3.samsung.com>
        <HK2PR04MB38919EB7F957C4BBB0B94C3781769@HK2PR04MB3891.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> No any function uses argument 'sector', remove it.
> 
> Signed-off-by: Yuezhang.Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy.Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama, Wataru <wataru.aoyama@sony.com>

Looks good!
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/balloc.c   |  2 +-
>  fs/exfat/dir.c      | 36 ++++++++++++++----------------------
>  fs/exfat/exfat_fs.h |  3 +--
>  fs/exfat/namei.c    | 42 ++++++++++++++++--------------------------
>  fs/exfat/nls.c      |  2 +-
>  5 files changed, 33 insertions(+), 52 deletions(-)

