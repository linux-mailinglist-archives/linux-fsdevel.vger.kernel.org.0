Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536C23F4470
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 06:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhHWEtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 00:49:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:10598 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhHWEtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 00:49:06 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210823044822epoutp030004b027aac58e12e4693ebfa484a729~d1ibwWFaH2933829338epoutp03C
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 04:48:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210823044822epoutp030004b027aac58e12e4693ebfa484a729~d1ibwWFaH2933829338epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629694102;
        bh=pIalBUDeN+09/OgJzDqcHKMPQUX+EIeR3psru4o1if0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=bnLaKFJ9lnIRslTjjIr54tUw+IS2JeIoMPHjqiADHB0expdK3EQG1yHqI7xk9zJrK
         WFH8f2U/WU0kSDOkWVPO3QEYAVpdY2Wfuz9AOUgHZ14Dr1AGIBJe8SnFhrg9RG2W89
         gzGFn+dEZl9xavhWK1GIiTg59hgPQyw7x0AyVEH4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210823044822epcas1p1b2fa5a951abc99e934441cc305ee3917~d1ibcwrAw1582515825epcas1p1Z;
        Mon, 23 Aug 2021 04:48:22 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.242]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GtKW730cgz4x9QN; Mon, 23 Aug
        2021 04:48:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.1A.09765.29823216; Mon, 23 Aug 2021 13:48:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210823044817epcas1p1597df777cca96327d2e6d409aaaa1a40~d1iW3gnBa1578215782epcas1p1L;
        Mon, 23 Aug 2021 04:48:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210823044817epsmtrp2054a00a1f0d3f361d6a1f8b1c771c12c~d1iW23B8P2765027650epsmtrp24;
        Mon, 23 Aug 2021 04:48:17 +0000 (GMT)
X-AuditID: b6c32a37-8ffff70000002625-c1-612328918cb0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.FE.09091.19823216; Mon, 23 Aug 2021 13:48:17 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210823044817epsmtip22f6e71a5d8e924835ac6241f9171f447~d1iWpr09k0075400754epsmtip2X;
        Mon, 23 Aug 2021 04:48:17 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'David Disseldorp'" <ddiss@suse.de>
Cc:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Namjae Jeon'" <linkinjeon@kernel.org>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20210820151214.37742aad@suse.de>
Subject: RE: [PATCH 0/2] exfat: allow access to paths with trailing dots
Date:   Mon, 23 Aug 2021 13:48:17 +0900
Message-ID: <004e01d797da$16fe0590$44fa10b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNJtgRGwkbJhwlTqXWzyf/suWf68AGvw0D+qI7D1jA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTV3eShnKiwYRFzBZf/09nsZg4bSmz
        xZ69J1kstvw7wurA4rFpVSebR9+WVYwem09Xe3zeJBfAEpVtk5GamJJapJCal5yfkpmXbqvk
        HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0UUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
        X1xiq5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQnfHqwTHWgs/sFQ9fXWZqYFzM1sXI
        ySEhYCJxdFETUxcjF4eQwA5Gid8nr0E5nxgl/v+4ygLhfGOUePpoBlzLw6Mz2SASexklTlyZ
        DVX1glHi4uw7TCBVbAK6Ev/+7AfrEBHQkGjZt5cdxGYWqJR4vnEbK4jNKaAncXP6VUYQW1jA
        Q+LG+s1Agzg4WARUJZY9VAcJ8wpYSiy7f4EFwhaUODnzCQvEGHmJ7W/nMEMcpCDx8+kyVohV
        VhL7fr5jg6gRkZjd2cYMcpuEwFd2iZl337NCNLhI3N91mBHCFpZ4dXwLO4QtJfH53V6oL8sl
        Tpz8xQRh10hsmLePHeQ2CQFjiZ4XJSAms4CmxPpd+hAVihI7f89lhFjLJ/Huaw8rRDWvREeb
        EESJqkTfpcNQA6Uluto/sE9gVJqF5LFZSB6bheSBWQjLFjCyrGIUSy0ozk1PLTYsMIbHdXJ+
        7iZGcFrUMt/BOO3tB71DjEwcjIcYJTiYlUR4/zIpJwrxpiRWVqUW5ccXleakFh9iNAWG9ERm
        KdHkfGBiziuJNzSxNDAxMzKxMLY0NlMS52V8JZMoJJCeWJKanZpakFoE08fEwSnVwMSi9s5U
        vd1N55FxTp/vu/Clkz6szGNsyj1WoJU3bcWHtzZfRblUPnNk2V3g+jDzwauY7XcPmBpMaJJN
        zNnSVKHNFSy3LvFmwKtMtqtPl2vy3A/ttgszjD5yZdLNoND7T39kPys27HWNb7/n0bI6cOn2
        yBusK0t0lklqf73I+epgzfW6LelvH1qXcMz/WFi9/U7Z+UvxKudOC0ps7j34huVWwNRbs299
        /sl5RnWzfu30hoWShvs/fHiw68iPpz1PWJrSXKTXLUh54rlitqiA2o6WuRodKUFm+z4tYT7B
        bt1y5r/C15XR/l7HXzrmyfQp2Fv6aNu+TzpZma3BxP/sgP7qH2Lbz7IVmt0pnZRwtF+JpTgj
        0VCLuag4EQARdjJbFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvO5EDeVEg2dzFC2+/p/OYjFx2lJm
        iz17T7JYbPl3hNWBxWPTqk42j74tqxg9Np+u9vi8SS6AJYrLJiU1J7MstUjfLoEr49WDY6wF
        n9krHr66zNTAuJiti5GTQ0LAROLh0ZlANheHkMBuRon29g3MEAlpiWMnzgDZHEC2sMThw8UQ
        Nc8YJaYsngNWwyagK/Hvz36wQSICGhIt+/ayg9jMAtUSz06eAbOFBOolvq7tZAGxOQX0JG5O
        v8oIYgsLeEjcWL+ZBWQ+i4CqxLKH6iBhXgFLiWX3L7BA2IISJ2c+YYEYqSexfv0cRghbXmL7
        2zlQZypI/Hy6jBXiBCuJfT/fsUHUiEjM7mxjnsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz
        03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI0RLcwfj9lUf9A4xMnEwHmKU4GBWEuH9y6ScKMSb
        klhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTzvStSdZ7w00K
        WOSkfvGb7Mph2uC+IczuwMbk2aZXzjsdmzCbNWD1I3P2tA/3657Yrl95qmX2saOz3ZtYDs/M
        3cx5YOG5Jzs273k2Z1Lhx0tCXjJp8T+TTt1w4dz17OzHnJ3u9jNfbt6hvk1Wr/n8G7aZTGGp
        e+UORHJ6/jPhmtvbfm5PmHDRnvwTsudnBUTkfezvqT6747GLplrwA9PsBreE48uetuSpsn9P
        fRHBvm/30te2N9siXEpT59t/2rLzfOSLVAX9v368bp1v1bQ4vh9NmGFT2CvUMXWWpt7jtfMf
        83+faaQtwC8Xtub1bR3hV3N1fu814lodk/vVVOJm9/Yldyt+syVN2poV0XNNVImlOCPRUIu5
        qDgRAOH39RL/AgAA
X-CMS-MailID: 20210823044817epcas1p1597df777cca96327d2e6d409aaaa1a40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210820131220epcas1p1e97adf5dfc5125571733d42d5d71110c
References: <CGME20210820131220epcas1p1e97adf5dfc5125571733d42d5d71110c@epcas1p1.samsung.com>
        <20210820151214.37742aad@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Date: Wed, 18 Aug 2021 13:11:21 +0200
> From: David Disseldorp <ddiss@suse.de>
> To: linux-fsdevel@vger.kernel.org
> Subject: [PATCH 0/2] exfat: allow access to paths with trailing dots
> 
> 
Hi David,
> This patchset adds a new exfat "keeptail" mount option, which allows users to resolve paths carrying
> trailing period '.' characters.
> I'm not a huge fan of "keeptail" as an option name, but couldn't think of anything better.
We are concerning that this mount option allow to create the filename that
contain trailing period. It will cause the compatibility issues with windows.
I think compatibility with windows is more important than fuse-exfat.

Can we only allow those files to be accessed and prevented from being created?
> 
> Feedback appreciated.

Thanks!
> 
> Cheers, David
> 
> --
> 
>  fs/exfat/exfat_fs.h |  3 ++-
>  fs/exfat/namei.c    | 25 ++++++++++++++-----------
>  fs/exfat/super.c    |  7 +++++++
>  3 files changed, 23 insertions(+), 12 deletions(-)


