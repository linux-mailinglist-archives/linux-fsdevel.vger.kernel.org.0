Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E54D6EF51F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 15:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbjDZNJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 09:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbjDZNJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:09:29 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C203226AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 06:09:25 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230426130922euoutp01befc5c182667e034b812607e98cc41a8~ZfhRy2ti_1336313363euoutp01w
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 13:09:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230426130922euoutp01befc5c182667e034b812607e98cc41a8~ZfhRy2ti_1336313363euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682514562;
        bh=hC8Egsn//5pKfzQNXUjSLdNqRLwtnUlIQyrXHxctICQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=cBYqWZmMXcchH17Eyn+QT7YdRVdpLw4LpuyLcprQb3h0lsNhL4S9HgXw96RYiHTTB
         IX6Rfda+APow/ExY3ZeoNoTohJmw9AdRr4gkbKKRNw1bqI/psMKD0YyqeBo4iEkrty
         1uoU27T5HB+3MLA5du0L4VL1mLmHthHTqAZ14Njw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230426130921eucas1p208bd40a0cac655a2b20580b52f54fdeb~ZfhRbsNVx1807918079eucas1p2-;
        Wed, 26 Apr 2023 13:09:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5F.D7.35386.18229446; Wed, 26
        Apr 2023 14:09:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230426130921eucas1p279078812be7e8d50c1305e47cea53661~ZfhREv2kN1808518085eucas1p2j;
        Wed, 26 Apr 2023 13:09:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230426130921eusmtrp166b0a11733c8dfdc952a32ae2728776d~ZfhRDcP_d0593705937eusmtrp1m;
        Wed, 26 Apr 2023 13:09:21 +0000 (GMT)
X-AuditID: cbfec7f4-cdfff70000028a3a-1f-6449228132ec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FC.EA.14344.18229446; Wed, 26
        Apr 2023 14:09:21 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230426130921eusmtip1aa55278beda33ec5aa586b1123e22dda~ZfhQ40EO-0298802988eusmtip1x;
        Wed, 26 Apr 2023 13:09:21 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 26 Apr 2023 14:09:20 +0100
Date:   Wed, 26 Apr 2023 15:00:33 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <cluster-devel@redhat.com>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        David Howells <dhowells@redhat.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-ext4@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <p.raghav@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 16/17] block: use iomap for writes to block
 devices
Message-ID: <20230426130033.ps363bz472jwlgl6@localhost>
MIME-Version: 1.0
In-Reply-To: <20230424054926.26927-17-hch@lst.de>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djPc7qNSp4pBp++qVnMWb+GzWL13X42
        iw83JzFZnFz9mM3iXdNvFovLT/gsVq4+ymSx95a2xcx5d9gsLi1yt9iz9yRQatccNot7a/6z
        Wlw4cJrVYtefHewWz3ZvZLb4/WMOm4Ogx+YVWh6Xz5Z6bFrVyeax6dMkdo8TM36zeOxe8JnJ
        Y/fNBjaP9/uusnmsmHaRyePzJrkArigum5TUnMyy1CJ9uwSujJenLrMUzOOo+DntMlsD4wW2
        LkZODgkBE4nl01aydzFycQgJrGCUOHdvIzNIQkjgC6PEi2tcEInPjBKzLk5hhuk4vXUrK0Ri
        OaPE/y2TWOGqjly+wgbhbGGUmHR2NQtIC4uAqsTft5eBEhwcbAJaEo2d7CBhEQEliaevzjKC
        1DML7GaRaDh9ECwhLBAi0bN9Flg9r4C5REt3FUiYV0BQ4uTMJ2AjOQUMJWatewN1kZJEw+Yz
        LBB2rcTe5gNg/0gInOOUmPdjP9SjLhKt75tZIWxhiVfHt7BD2DISpyf3QDVXSzy98ZsZormF
        UaJ/53qwIyQErCX6zuSA1DALZEj8vDsTao6jxKJjTcwQJXwSN94KQpTwSUzaNh0qzCvR0SYE
        Ua0msfreGxaIsIzEuU98ExiVZiF5bBaS+RC2jsSC3Z/YZgF1MAtISyz/xwFhakqs36W/gJF1
        FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmCKPP3v+JcdjMtffdQ7xMjEwXiIUYKDWUmE
        l7fSPUWINyWxsiq1KD++qDQntfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QD05zy
        FeGfFk7Z2PNfZ3GLZ/yqt91S15PYD263eK2fVKDim7UpI07dfb+U5b1fSm+830svCT62z/fy
        aifJhfP2LHaU2ss6pU0y7Zo/x49yxx1ayzT6DTcVa36cFxXU8Cll06OOy45p1+yPTE3Nfzfz
        569vexI3bYl807uk2Tvx1STNPVO2Ptmoe/alyUuVmGCdRVHpiqtFCo06FthUmleJ28jN0dWO
        V7HLCjg63exGndcJy9jsiT6TYq6cuxe/Osep43Lz46lF+ptSf1tZ+nysKL7FmWj4YiVb67Zl
        DnoOnHdYCv/f5ZV6IH30wVNlh9kRJXelvs1onfb2xKu6d7zPeM1Vv/VNzzJJXKvwk/1srhJL
        cUaioRZzUXEiAHGPVigABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xu7qNSp4pBmee8VnMWb+GzWL13X42
        iw83JzFZnFz9mM3iXdNvFovLT/gsVq4+ymSx95a2xcx5d9gsLi1yt9iz9yRQatccNot7a/6z
        Wlw4cJrVYtefHewWz3ZvZLb4/WMOm4Ogx+YVWh6Xz5Z6bFrVyeax6dMkdo8TM36zeOxe8JnJ
        Y/fNBjaP9/uusnmsmHaRyePzJrkArig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NY
        KyNTJX07m5TUnMyy1CJ9uwS9jLn9DSwF91grLp08w9bAuJKli5GTQ0LAROL01q2sXYxcHEIC
        SxklNv/7xwaRkJHY+OUqK4QtLPHnWhcbRNFHRokndxYwQjhbGCWezrwO1sEioCrx9+1lIJuD
        g01AS6Kxkx0kLCKgJPH01VmwemaB3SwSK2c0MYMkhAVCJHq2zwKr5xUwl2jprgIJCwmESdzp
        3ga2mFdAUOLkzCdglzIL6Egs2P0JrJxZQFpi+T8OkDCngKHErHVvmCHuVJJo2HwG6rFaic5X
        p9kmMArPQjJpFpJJsxAmLWBkXsUoklpanJueW2ykV5yYW1yal66XnJ+7iREY/duO/dyyg3Hl
        q496hxiZOBgPMUpwMCuJ8PJWuqcI8aYkVlalFuXHF5XmpBYfYjQFBsREZinR5Hxg+skriTc0
        MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDaXttiKlzVfHqHju2S6Rrv
        bx2IusPDuPFD0hOBklvLd31/wNQdKtfzlN26OtVsb+DbOaqnu3r+vl6XuKoq+2S1/wIN/Yzu
        rfPOW3Z4yYXqmLvf2RoQMH3xyYaOpbnTUvsfBkalJejJ2UfeTP9dpunZFx454VGZVe75/cFM
        UgozeypmSbXeWfX/TafXztOplyOXPN9bfyXBJMN1nUvu89T2Z/a6fem9t/LOT5A9PIU/au/8
        001GUY8ze+sCfotHyrLceXKrzpZ3g88UsdtPz/z7bfx69hyJQxe/CPLPWhzS7D11xeFsW+V3
        ttv/54ukFvVLFcSwKvwM8jdZs1XkNrfBylTbhH5PRZ/TUpf4jyqxFGckGmoxFxUnAgAAg+8w
        hwMAAA==
X-CMS-MailID: 20230426130921eucas1p279078812be7e8d50c1305e47cea53661
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_fbc0e_"
X-RootMTR: 20230426130921eucas1p279078812be7e8d50c1305e47cea53661
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230426130921eucas1p279078812be7e8d50c1305e47cea53661
References: <20230424054926.26927-1-hch@lst.de>
        <20230424054926.26927-17-hch@lst.de>
        <CGME20230426130921eucas1p279078812be7e8d50c1305e47cea53661@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_fbc0e_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Apr 24, 2023 at 07:49:25AM +0200, Christoph Hellwig wrote:
> Use iomap in buffer_head compat mode to write to block devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/Kconfig |  1 +
>  block/fops.c  | 33 +++++++++++++++++++++++++++++----
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 941b2dca70db73..672b08f0096ab4 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -5,6 +5,7 @@
>  menuconfig BLOCK
>         bool "Enable the block layer" if EXPERT
>         default y
> +       select IOMAP

This needs to be FS_IOMAP.

>         select SBITMAP
>         help
>  	 Provide block layer support for the kernel.

------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_fbc0e_
Content-Type: text/plain; charset="utf-8"


------0IIwcNA8CeD.s59tlljyDEq3yyVAinti4bQgYoqzE0B37Kwt=_fbc0e_--
