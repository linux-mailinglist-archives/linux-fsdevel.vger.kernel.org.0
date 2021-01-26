Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4683F304C2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbhAZWbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:31:37 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:28143 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbhAZFPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:15:21 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210126051438epoutp035324f529e64d85b031d68f55a17f99d8~dsEsfQvJI2001620016epoutp03l
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 05:14:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210126051438epoutp035324f529e64d85b031d68f55a17f99d8~dsEsfQvJI2001620016epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611638078;
        bh=V3/RsDa7SlFeveEQjTFri1OGy7EDXG+DF6UqoJ8C288=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oxRsdkqsDS7PmOzGGwWBdj3s9eCGiCiu0FkYUYT9ulOJfJHMFueurdnEeVFOiadqD
         8AtJg/3V2OBs3+jqhMskT8tDnpjC7l2VM29VCGWBNyh/kbMSo4IqeGx6UsjeiADEM7
         5ws4HSeKi/3b8TUsYYbcA1xDv1QZsCNM7y1h4LQY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210126051437epcas1p4d277724b82041b43c51d64ffcb713db0~dsEsJj28I1711317113epcas1p4X;
        Tue, 26 Jan 2021 05:14:37 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DPvzx30fdz4x9QC; Tue, 26 Jan
        2021 05:14:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.3C.09577.D35AF006; Tue, 26 Jan 2021 14:14:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210126051436epcas1p3925eeb28aa57629eb9e2cabf42fa05a7~dsErDp2fL0076600766epcas1p3K;
        Tue, 26 Jan 2021 05:14:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210126051436epsmtrp175719e8c795f64e19457ef962d992f3a~dsErC9i7G2571625716epsmtrp1y;
        Tue, 26 Jan 2021 05:14:36 +0000 (GMT)
X-AuditID: b6c32a39-193b3a8000002569-23-600fa53dcaa7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.60.08745.C35AF006; Tue, 26 Jan 2021 14:14:36 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210126051436epsmtip1c985373c68a856513f7f48e0ca97553b~dsEq0XyHy2211522115epsmtip12;
        Tue, 26 Jan 2021 05:14:36 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Randy Dunlap'" <rdunlap@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>, <syzkaller-bugs@googlegroups.com>,
        "'syzbot'" <syzbot+da4fe66aaadd3c2e2d1c@syzkaller.appspotmail.com>,
        "'Matthew Wilcox'" <willy@infradead.org>
In-Reply-To: <40b5993e-d99e-b2b9-6568-80e46e2d3cb1@infradead.org>
Subject: RE: UBSAN: shift-out-of-bounds in exfat_fill_super
Date:   Tue, 26 Jan 2021 14:14:36 +0900
Message-ID: <052201d6f3a2$23f468c0$6bdd3a40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKx/jOXwjWHcb1Mo6E7TSXbn6EBcQHuuaE3ApB445ICJF3SPahOIchQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmvq7tUv4EgxWdHBZ79p5ksbi8aw6b
        xds701kstvw7wmpx7zqjxY0tc5ktfv+Yw+bA7rFn4kk2j80rtDz6tqxi9Jj5Vs3j8ya5ANao
        HJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBuUFMoS
        c0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGBgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5
        GRMWTWMq+MJZMXm/RgPjWfYuRg4OCQETiflfc7oYuTiEBHYwSkxedoAFwvnEKHH22zQmCOcz
        o8SGdZ+BMpxgHVP3zmUDsYUEdjFK/PziA1H0klHi7ovrrCAJNgFdiX9/9oMViQjoSNzc/IkR
        pIhZ4AujxK+Xv5lAEpwCjhLvuj8yg9jCAtYSU57uBmtgEVCVePr9MNg2XgFLibPnnkLZghIn
        Zz4Bs5kF5CW2v53DDHGRgsTPp8tYIZa5Sax7tZYVokZEYnZnG1TNRA6Jj61+ELaLxKGPX6C+
        EZZ4dXwLO4QtJfGyvw0aLtUSH/dDtXYwSrz4bgthG0vcXL+BFaSEWUBTYv0ufYiwosTO33MZ
        IbbySbz72sMKMYVXoqNNCKJEVaLv0mEmCFtaoqv9A/sERqVZSP6aheSvWUjun4WwbAEjyypG
        sdSC4tz01GLDAlPkmN7ECE6cWpY7GKe//aB3iJGJg/EQowQHs5II7249ngQh3pTEyqrUovz4
        otKc1OJDjKbAkJ7ILCWanA9M3Xkl8YamRsbGxhYmZuZmpsZK4rxJBg/ihQTSE0tSs1NTC1KL
        YPqYODilGpi6tF+2VL7bGB3/cO8ylUrJbq163UeHvEwFQsKk7qjMUjDmzbiWVH5laUk1S8vd
        Y0ofT05WEv/Iah+bL+j55W3ChLxrTG0yLfEcaZZTRP+uTNj+YZKjTcCXhapH3LrYH+henLXV
        f+nlM3dPm7qba0yx1y3KnxnsazYvNtFh7wzZ7tBkte8Hj/GK92+b+dY38szWLyLWDnMc2y73
        pW5zmL/xxCnHI3dbmi6tmBl/I2iDb0A2/+HSkiqtbRdW/XebZL+04IPT1UtFdaLia+yDLFit
        7s09wHZbPn4d59RJt/PMlzg/S/U1ic6dwagq8oP/0c6uIv27V+o616008X+w+uKV3rCHPzs0
        fxsmBK0vuqDEUpyRaKjFXFScCAAoW5Y8JQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnK7NUv4Eg57HGhZ79p5ksbi8aw6b
        xds701kstvw7wmpx7zqjxY0tc5ktfv+Yw+bA7rFn4kk2j80rtDz6tqxi9Jj5Vs3j8ya5ANYo
        LpuU1JzMstQifbsErowJi6YxFXzhrJi8X6OB8Sx7FyMnh4SAicTUvXPZuhi5OIQEdjBKvGj8
        zQaRkJY4duIMcxcjB5AtLHH4cDFEzXNGie9vD7OA1LAJ6Er8+7MfrF5EQEfi5uZPjCBFzAI/
        GCUmNk9jBUkICbxmlPj0RRfE5hRwlHjX/ZEZxBYWsJaY8nQ3WDOLgKrE0+8QQ3kFLCXOnnsK
        ZQtKnJz5BMxmFtCWeHrzKZQtL7H97RxmiEMVJH4+XcYKcYSbxLpXa1khakQkZne2MU9gFJ6F
        ZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwXGkpbWDcc+q
        D3qHGJk4GA8xSnAwK4nw7tbjSRDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2
        ampBahFMlomDU6qBKbO9bZU+0+p9Vzuar593y27243lavIr31MYHr9+2y+axqbyaf3hdMsel
        H/phzKLhxXbHq7c1qa/ZdjBwok3tri13F2ca56fVmxUfrS3TvpHG8MU423uvwZIoc8WiRHvp
        SkbGqoiz4otlAyJm6xpHzT6924GJvWLZxCC5e2eS+AR0Ji6v57xWms01nX3/Y4cpFayGjasf
        MYS2s17a/Tb0SZPDX6NJwos7Tn89X3P0Xfydu99kOFVc7t2bdjc7dpnky2PJj4UOMp/Um6Kj
        b2M95drDt4ovzomt81Wd9SNkt+ePZzHvAvrFXu07/i9C/2Jms8TM3XdumVrt8qncYxB0wPpv
        gZnVl5aA3Y9slKzVlFiKMxINtZiLihMBz5xrkxIDAAA=
X-CMS-MailID: 20210126051436epcas1p3925eeb28aa57629eb9e2cabf42fa05a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210126043409epcas1p4c035b515ac6e34f1773e890c148d39d7
References: <000000000000c2865c05b9bcee02@google.com>
        <20210125183918.GH308988@casper.infradead.org>
        <CGME20210126043409epcas1p4c035b515ac6e34f1773e890c148d39d7@epcas1p4.samsung.com>
        <40b5993e-d99e-b2b9-6568-80e46e2d3cb1@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 1/25/21 10:39 AM, Matthew Wilcox wrote:
> > On Mon, Jan 25, 2021 at 09:33:14AM -0800, syzbot wrote:
> >> UBSAN: shift-out-of-bounds in fs/exfat/super.c:471:28 shift exponent
> >> 4294967294 is too large for 32-bit type 'int'
> >
> > This is an integer underflow:
> >
> >         sbi->dentries_per_clu = 1 <<
> >                 (sbi->cluster_size_bits - DENTRY_SIZE_BITS);
> >
> > I think the problem is that there is no validation of sect_per_clus_bits.
> > We should check it is at least DENTRY_SIZE_BITS and probably that it's
> > less than ... 16?  64?  I don't know what legitimate values are in
> > this field, but I would imagine that 255 is completely unacceptable.
> 
> Ack all of that. The syzbot boot_sector has sect_per_clus_bits == 3 and sect_size_bits == 0, so sbi-
> >cluster_size_bits is 3, then UBSAN goes bang on:
> 
> 	sbi->dentries_per_clu = 1 <<
> 		(sbi->cluster_size_bits - DENTRY_SIZE_BITS); // 3 - 5
> 
> 
> There is also an unprotected shift at line 480:
> 
> 	if (sbi->num_FAT_sectors << p_boot->sect_size_bits <
> 	    sbi->num_clusters * 4) {
> 
> that should be protected IMO.
Right. I will also add validation for fat_length as well as sect_size_bits before this.

Thanks!
> 
> 
> --
> ~Randy


