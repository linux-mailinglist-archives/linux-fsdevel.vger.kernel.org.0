Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2431E32A4FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350012AbhCBLp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:45:29 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:55439 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444478AbhCBCmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:42:21 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210302024135epoutp044d496aec5f1a7238ec4584811631c176~oZkEJ9rnd2187821878epoutp04J
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 02:41:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210302024135epoutp044d496aec5f1a7238ec4584811631c176~oZkEJ9rnd2187821878epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614652895;
        bh=DPkLryloKgyBs38GGzZTdVgStVHNl4wTh2ZZQesbDAM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QTnoaHIOQ2mQryy+Y80j9NDxSSWuor0w5I3GPR0Ckh8t11iaF1FnpcqSozDNiukfS
         AR2I9kOpYxwBQMmpq8AoGwv35tdPvE/0Yi78i2pA4ETolenJRahaVuF2qqz613Eyc2
         M8ROcng09l6ZFsjXluyI6ZfJiDiaWYL9pM4grdzI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210302024135epcas1p1cef446dc3b5619236506db9647e0d828~oZkDntMB-2439824398epcas1p1R;
        Tue,  2 Mar 2021 02:41:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DqLxB2Y9tz4x9Pq; Tue,  2 Mar
        2021 02:41:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.8F.02418.ED5AD306; Tue,  2 Mar 2021 11:41:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210302024133epcas1p27452f6ce2841c1e2a5100405c91b5a75~oZkCS5dQw1004210042epcas1p2a;
        Tue,  2 Mar 2021 02:41:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210302024133epsmtrp1bc53d0483881ee0db9002d572c0302a9~oZkCSQCpd0110001100epsmtrp16;
        Tue,  2 Mar 2021 02:41:33 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-d4-603da5decfd0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.6B.08745.DD5AD306; Tue,  2 Mar 2021 11:41:33 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210302024133epsmtip11ae9ea15c2e4fce7a65096633344f620~oZkCH6bYD1131711317epsmtip1h;
        Tue,  2 Mar 2021 02:41:33 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20210225093333.144829-1-hyeongseok@gmail.com>
Subject: RE: [PATCH] exfat: fix erroneous discard when clear cluster bit
Date:   Tue, 2 Mar 2021 11:41:33 +0900
Message-ID: <000001d70f0d$8e882ec0$ab988c40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUPDa1bJ9R3vCNj0JBjwAxCWVZpwLSYI5Bql8LToA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTT/feUtsEgy0LhCz+TvzEZLFn70kW
        i8u75rBZ/Jheb7Hl3xFWB1aPnbPusnv0bVnF6PF5k1wAc1SOTUZqYkpqkUJqXnJ+SmZeuq2S
        d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QRiWFssScUqBQQGJxsZK+nU1RfmlJqkJG
        fnGJrVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk7GqWmP2QresFacbP/M2sD4lKWL
        kZNDQsBE4uqGiexdjFwcQgI7GCU2PZ3MDOF8YpR4t+4jK4TzmVHi2qO7bDAtrS+WskEkdjFK
        fHx4G6r/JaPE9f69rCBVbAK6Ek9u/GQGsUUEPCQeNx1jArGZBeIlFu84DjaJU8BaYv7SBYwg
        tjBQzcPXD8B6WQRUJDoePmYHsXkFLCVeXVvAAmELSpyc+YQFYo68xPa3c5ghLlKQ2P3pKCvE
        LiuJdaf6GSFqRCRmd7ZB1fxllzjyjQ/CdpFYeGkLE4QtLPHq+BZ2CFtK4mV/G5RdL/F//lqw
        xyQEWhglHn7aBtTAAeTYS7y/ZAFiMgtoSqzfpQ9Rriix8/dcqLV8Eu++9rBCVPNKdLQJQZSo
        SHz/sJMFZtOVH1eZJjAqzULy2Cwkj81C8sAshGULGFlWMYqlFhTnpqcWGxYYIkf2JkZwatQy
        3cE48e0HvUOMTByMhxglOJiVRHhPfrZMEOJNSaysSi3Kjy8qzUktPsRoCgzqicxSosn5wOSc
        VxJvaGpkbGxsYWJmbmZqrCTOm2TwIF5IID2xJDU7NbUgtQimj4mDU6qBKSDzcchnocTNfDmm
        NaLbnbdPXbnrgoPIkn/CU+Jit8ffnpcf7Mkxd8GrOC99H8/a518YPjbrllz6de/5BWHb+/0a
        /H+LTl07f1BeLddTtcKGQ352cdzabRGb20z7vzW8ivnTrDpZ0CHdpWeXgHDZxdsav3lMv+5T
        uPmz3dRkYe2bZsY1aVknayZ7/vliJe2zbpKjZ4q3Vv3f3OOrFGI0dBwWbwjdNW/jmurvWW+X
        xU7aye7Exr1fI8Tqkdu8LwvyF8wr4jFvFrlxjNt0/5Sfoee+sBzXb/pv9vHwVe/a+cqnzjeW
        qr/0m2KYPOP5zCDxyWwpfrNX1c80UVZUZJikfWpiu31OeJf4jf2xKrdPKLEUZyQaajEXFScC
        AKzNqMYWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnO7dpbYJBo3fjS3+TvzEZLFn70kW
        i8u75rBZ/Jheb7Hl3xFWB1aPnbPusnv0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJXxqlpj9kK
        3rBWnGz/zNrA+JSli5GTQ0LARKL1xVK2LkYuDiGBHYwSl19cZOpi5ABKSEkc3KcJYQpLHD5c
        DFHynFGiacpVJpBeNgFdiSc3fjKD2CICXhL7m16zg9jMAokSZ5a0sUI09DBKdPdvAGvgFLCW
        mL90ASOILSzgIfHw9QNWEJtFQEWi4+FjsGZeAUuJV9cWsEDYghInZz5hATmCWUBPom0jI8R8
        eYntb+cwQ9yvILH701FWiBusJNad6oeqEZGY3dnGPIFReBaSSbMQJs1CMmkWko4FjCyrGCVT
        C4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC40NLawfjnlUf9A4xMnEwHmKU4GBWEuE9+dky
        QYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYm9xBBx0ON
        UywVKzevWXHVVipt1USHrzrGBmsmhCy5dkzx4byqB0E1pxsyTn8qk/rvWbHNqnLCi5Urbiz/
        3bfl3i5mS5sdQoFKE58lvSpK4K9+8a2FSfrbXp8j8xXmbqtdPO/b3COGs5LOlrKfbd4ylyGw
        JvTLqad396/U0Hn6g39T+qLUuJKDVWIfyl8LlHA+6lIS3/7t70Ox9xaRjB3XK+JtHUvcZH8/
        i/jvt/KWzpWgcsZjlgcL751Y4nck3bPsRuHMqn5J/l1fV02/d2wXz6zP1Z2Jl5vnP9vI0d+4
        qXyB7j+e5VwfHl7p/WsYF7kzeMrqKu7DV87yvVjnK/XNJ4JfModh3iKmx62tU96KWyqxFGck
        GmoxFxUnAgCmmKEh/gIAAA==
X-CMS-MailID: 20210302024133epcas1p27452f6ce2841c1e2a5100405c91b5a75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210225093351epcas1p40377b00fb3532e734e4a7a1233ee72e1
References: <CGME20210225093351epcas1p40377b00fb3532e734e4a7a1233ee72e1@epcas1p4.samsung.com>
        <20210225093333.144829-1-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Subject: [PATCH] exfat: fix erroneous discard when clear cluster bit
> 
> If mounted with discard option, exFAT issues discard command when clear
> cluster bit to remove file. But the input parameter of cluster-to-sector
> calculation is abnormally adds reserved cluster size which is 2, leading
> to discard unrelated sectors included in target+2 cluster.
> 
> Fixes: 1e49a94cf707 ("exfat: add bitmap operations")
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> ---
>  fs/exfat/balloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Looks good.

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

Thanks for your work!
Could you remove the wrong comments above set/clear/find bitmap functions
together?

