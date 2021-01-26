Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F737304C27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbhAZW21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:28:27 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59671 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbhAZElB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:41:01 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210126044017epoutp0440e45e1ac018728bf47b960d15603877~drmtSLyB22232322323epoutp04a
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 04:40:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210126044017epoutp0440e45e1ac018728bf47b960d15603877~drmtSLyB22232322323epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611636017;
        bh=0IF6BKuNDCmj4pH28NoauTZPK6sU7R4F7lqSF+hRVKs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Um4y5e3d3SO7nues++Ymn50ASVPZHYeE59iB8sHh0TIrDgyjYDC6Vr2iPOCAMShnK
         AavsdBoHXq3djQmCgmigqYrDqf7tVZweghGsi44O5cd4neb/hXiJ3egdbTD7ykES/4
         uvNc8h4iGWZKY10BLJENU6VL7Wr3Xga9CvgOgJGU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210126044011epcas1p26622df0da60c9f1939d6f80e95bf85b5~drmnsy4m-3034030340epcas1p2N;
        Tue, 26 Jan 2021 04:40:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DPvDB39V6z4x9QF; Tue, 26 Jan
        2021 04:40:10 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.A1.63458.A2D9F006; Tue, 26 Jan 2021 13:40:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210126044008epcas1p221ba5820bc563ab57424806003dd5f79~drmlNhZIN0935609356epcas1p2X;
        Tue, 26 Jan 2021 04:40:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210126044008epsmtrp2389eb38a9d75e8653ce7bf7aff9cc33c~drmlMuWuD2174521745epsmtrp2Y;
        Tue, 26 Jan 2021 04:40:08 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-95-600f9d2aa1c6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.EB.08745.82D9F006; Tue, 26 Jan 2021 13:40:08 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210126044008epsmtip1a7a1868a6e334a04496ba5086efe424c~drmlDUX9G0712007120epsmtip1K;
        Tue, 26 Jan 2021 04:40:08 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Matthew Wilcox'" <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>, <syzkaller-bugs@googlegroups.com>,
        "'syzbot'" <syzbot+da4fe66aaadd3c2e2d1c@syzkaller.appspotmail.com>
In-Reply-To: <20210125183918.GH308988@casper.infradead.org>
Subject: RE: UBSAN: shift-out-of-bounds in exfat_fill_super
Date:   Tue, 26 Jan 2021 13:40:08 +0900
Message-ID: <051e01d6f39d$537a0910$fa6e1b30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKx/jOXwjWHcb1Mo6E7TSXbn6EBcQJApmhQAe65oTeoYcKoMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTT1drLn+CwcYNohZ79p5ksbi8aw6b
        xZZ/R1gt7l1ntLixZS6zxe8fc9gc2Dz2TDzJ5rF5hZZH35ZVjB4z36p5fN4kF8AalWOTkZqY
        klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7ReSaEsMacUKBSQ
        WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgaFCgV5yYW1yal66XnJ9rZWhgYGQKVJmQk3Fh5072
        giNsFYc/xTYwTmLtYuTkkBAwkdi89gqQzcUhJLCDUeJA1w52COcTo8S1hm9MEM5nRokLq7sY
        YVrWvT3FApHYxSjRtPQtVMtLRolPG2eygFSxCehK/Puznw3EFhHQkeh6uR1sCbPACUaJK3dO
        g23nFLCW+LrrJ1iDMJA95elusAYWAVWJ/90NYHFeAUuJI1dPMELYghInZz4BizMLyEtsfzuH
        GeIkBYmfT5cBzeQAWuYk8XumBkSJiMTszjZmkL0SAr0cEh/WzQSrkRBwkbg51xCiVVji1fEt
        7BC2lMTnd3vZIEqqJT7uh5rewSjx4rsthG0scXP9BrApzAKaEut36UOEFSV2/p7LCLGVT+Ld
        1x6oRbwSHW1CECWqEn2XDjNB2NISXe0f2CcwKs1C8tYsJG/NQnL/LIRlCxhZVjGKpRYU56an
        FhsWGCFH9SZGcMLUMtvBOOntB71DjEwcjIcYJTiYlUR4d+vxJAjxpiRWVqUW5ccXleakFh9i
        NAUG9ERmKdHkfGDKziuJNzQ1MjY2tjAxMzczNVYS5000eBAvJJCeWJKanZpakFoE08fEwSnV
        wDTvYFZh9qV02cSK++rdPGnht5feWTznz0fe8xaTXafm7n758tSEco3a4mKPOct8Fkb73nJM
        Ob2qdMaVY2naX6Ybrr9xK3BzzDpZg4WC88WUZxrNPlC8OfC185yJj+Je7JFlum8sKZ3KpaYW
        vNoiPdNuTe+d7VWzUr2b1mxxF5BQto2Y4Gsuz2yxNiR2yZMb9yYvXWJz3qbVZ+X7n+z/4msf
        bhKqubTvgtLRx3riAubfpyRxL36YyLOs+U5+0upZLwOWneY6G1S+u6NssaP36wrhh7/sNL8s
        jrdMe/K0Qlg65MDuu87nom/pJp9rZJ9hrvDdTy3/Ufm/4AM/glYFXpojGKOzotadZ1bEfI+6
        omtKLMUZiYZazEXFiQA+k5uiIQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK7GXP4Eg/t3zSz27D3JYnF51xw2
        iy3/jrBa3LvOaHFjy1xmi98/5rA5sHnsmXiSzWPzCi2Pvi2rGD1mvlXz+LxJLoA1issmJTUn
        syy1SN8ugSvjws6d7AVH2CoOf4ptYJzE2sXIySEhYCKx7u0pli5GLg4hgR2MEh+mPWeESEhL
        HDtxhrmLkQPIFpY4fLgYouY5o0THhOMsIDVsAroS//7sZwOxRQR0JLpebmcFKWIWOMMo8b3r
        OtTUbYwSD9Z+AOvgFLCW+LrrJ5gtDGRPebobrJtFQFXif3cDWJxXwFLiyNUTjBC2oMTJmU9Y
        QK5gFtCTaNsIFmYWkJfY/nYOM8ShChI/ny5jBSkREXCS+D1TA6JERGJ2ZxvzBEbhWUgGzUIY
        NAvJoFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOHC2tHYx7Vn3QO8TI
        xMF4iFGCg1lJhHe3Hk+CEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KL
        YLJMHJxSDUzLXpqbBb9yMl/64hN3b1f7ne3Vk0/Nq5H5oltw9W2T+DXXpa7ij+cyq0tdLpjV
        Huyf0rO7aX2j5Z6pSp9ZDEQ2n17EP5VN/5rweg8xvZ6V5xpWmpy+mDVTonyXfNuBjxr2Et9X
        yD+xel3Mxf79ze52FqMzLqXFpq80Nn+/vc81fEv9vbcGyeytIova+ouNxH9qHumTmBSl7j3v
        n847+a0Tlx4/LC/82ylr4du1WWvOX8w4Muk6U/3H9gO3/bc8Mt7P9d9zkdjs68u2p3+/PcNm
        fePZf8zdK8UKj2x/L6bcvty10mzK5OTlaf5vZCo1gvgU+4xON4gJqdZmSheYznKIWGenkVbZ
        cP1+6DyFh5eUWIozEg21mIuKEwF2b5WbCwMAAA==
X-CMS-MailID: 20210126044008epcas1p221ba5820bc563ab57424806003dd5f79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210125184007epcas1p39999c1e4325b738e4ff5e42899b8f6b7
References: <000000000000c2865c05b9bcee02@google.com>
        <CGME20210125184007epcas1p39999c1e4325b738e4ff5e42899b8f6b7@epcas1p3.samsung.com>
        <20210125183918.GH308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Mon, Jan 25, 2021 at 09:33:14AM -0800, syzbot wrote:
> > UBSAN: shift-out-of-bounds in fs/exfat/super.c:471:28 shift exponent
> > 4294967294 is too large for 32-bit type 'int'
> 
> This is an integer underflow:
> 
>         sbi->dentries_per_clu = 1 <<
>                 (sbi->cluster_size_bits - DENTRY_SIZE_BITS);
> 
> I think the problem is that there is no validation of sect_per_clus_bits.
> We should check it is at least DENTRY_SIZE_BITS and probably that it's less than ... 16?  64?  I don't
> know what legitimate values are in this field, but I would imagine that 255 is completely unacceptable.
exfat specification describe sect_per_clus_bits field of boot sector could be at most 32 and
at least 0. And sect_size_bits can also affect this calculation, It also needs validation.
I will fix it.
Thanks!

