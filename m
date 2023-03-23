Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3F6C6BC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 16:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjCWPBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjCWPAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:00:54 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF153253E
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 08:00:42 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230323150039euoutp013bceac3042d1320f3de61aa346b1653c~PFGv4TCX42270122701euoutp01G
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 15:00:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230323150039euoutp013bceac3042d1320f3de61aa346b1653c~PFGv4TCX42270122701euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679583640;
        bh=Icol1NVQVqXWLETTQ6qBuGxVjyUvKpu5FRVxPfMJI5w=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=a0wEK/WILT2l2yTo7hODi6knqNCGLVGsWm1o9nnVOFmazylpeSUowNYKpW9hbmAdx
         8MhSHQbumCLTtm3Gs9WPa0wNGb01fXT7Mcczv+AaVg7lusT0RJwGXhJk1wBUP3Dwa3
         tpo78MbYZkTmwvgVEYiKrAgK892rDgTohFlCd9qc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230323150039eucas1p2c7b2e1906656e2f9285fe5c95907c5c9~PFGvm1TmA2995529955eucas1p2N;
        Thu, 23 Mar 2023 15:00:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 28.11.09503.7996C146; Thu, 23
        Mar 2023 15:00:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230323150039eucas1p26720ff35cb61c319cf3689f2f692f720~PFGvHi8AG2042820428eucas1p2e;
        Thu, 23 Mar 2023 15:00:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230323150039eusmtrp27e05b1483f2166f1785c5879c94b1e57~PFGvG7Gmy2667426674eusmtrp2p;
        Thu, 23 Mar 2023 15:00:39 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-bc-641c6997ca0e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.39.09583.6996C146; Thu, 23
        Mar 2023 15:00:39 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230323150038eusmtip1bb56ea103192735c274ede4a1e924d2e~PFGu3--cZ1265912659eusmtip1b;
        Thu, 23 Mar 2023 15:00:38 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 23 Mar 2023 15:00:37 +0000
Message-ID: <fbf5bc8a-6c82-a43e-dd96-8a9d2b7d3bf4@samsung.com>
Date:   Thu, 23 Mar 2023 16:00:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.8.0
Subject: Re: [RFC v2 0/5] remove page_endio()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <senozhatsky@chromium.org>, <viro@zeniv.linux.org.uk>,
        <axboe@kernel.dk>, <brauner@kernel.org>,
        <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <hubcap@omnibond.com>, <martin@omnibond.com>, <mcgrof@kernel.org>,
        <devel@lists.orangefs.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZBtSevjWLybE6S07@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djPc7rTM2VSDPaeUrOYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpNF+90+Jou9t7Qt9uw9yWJxedccNot7a/6zWpxc/5/Z4saEp4wWy76+Z7fY
        vXERm8X5v8dZLX7/mMPmwO8xu+Eii8fmFVoel8+Wemxa1cnmsenTJHaPEzN+s3g0TL3F5vHr
        9h1Wj8+b5Dw2PXnLFMAVxWWTkpqTWZZapG+XwJXRfeQHY8FVnoqVy44zNjC2c3UxcnJICJhI
        zN3zirGLkYtDSGAFo8SDDwfZIZwvjBInzm5kBKkSEvjMKDH9qhFMx54jd9kgipYzSrxbep8V
        rqh7tjREYiejxKu2xywgCV4BO4mDf6aygdgsAqoSLS3vmCHighInZz4BquHgEBWIknjxugwk
        LCygK3FxTydYK7OAuMStJ/OZQEpEBDQk3mwxAhnPLNDDLLFo7S6wVjYBLYnGTnaQck6g2yY9
        WMUO0aop0br9N5QtL7H97RxmiPsVJSbdfM8KYddKnNpyiwlkpoTAPU6Jb+cPskAkXCSWNt+H
        KhKWeHV8CzuELSPxfyfIPSB2tcTTG7+ZIZpbGCX6d65nAzlIQsBaou9MDkSNo8SezedZIcJ8
        EjfeCkLcwycxadt05gmMqrOQAmIWko9nIXlhFpIXFjCyrGIUTy0tzk1PLTbMSy3XK07MLS7N
        S9dLzs/dxAhMf6f/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8LoxS6QI8aYkVlalFuXHF5XmpBYf
        YpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYFK5Munvw7ke7WpXNDg1G5si1rrXhJ3l
        kvw0Revb9oVuDFz7RW+UJL8x3b/sSuzCFN6U53MbE8y8zl5dNCHmq4rC6gP8ov1PpDu443n2
        l12/3trGvMHctir5Y7iJ06kd32YuWDingqH1rqvfj4afS6WfNiwSNdyQVu26LN7xek2IWbag
        h6D896mTJPZ22LBvnLRj8osvFbxPH66S9lyVMfNges/8GI81T47Ha+4wEV7Q+Emut0rmzKGP
        7/SPtTT+YAmIkavcF6je26i07QpzWqWI0EnBpWGZgcFbGg/fVzkauWB2gu1FSYdHuWft2h94
        H1hgev3+09QzrX+Dp3SrBCUqBQfz7zny/znnnQnMr5RYijMSDbWYi4oTAde99cruAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsVy+t/xu7rTM2VSDKbsYbSYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpNF+90+Jou9t7Qt9uw9yWJxedccNot7a/6zWpxc/5/Z4saEp4wWy76+Z7fY
        vXERm8X5v8dZLX7/mMPmwO8xu+Eii8fmFVoel8+Wemxa1cnmsenTJHaPEzN+s3g0TL3F5vHr
        9h1Wj8+b5Dw2PXnLFMAVpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJfRfeQHY8FVnoqVy44zNjC2c3UxcnJICJhI7Dlyl62LkYtDSGApo8Tsc19Y
        IRIyEp+ufGSHsIUl/lzrgir6yCjRMv0EM4Szk1FizYJDbCBVvAJ2Egf/TAWzWQRUJVpa3jFD
        xAUlTs58wgJiiwpESTy9cwgsLiygK3FxTydYnFlAXOLWk/lMXYwcHCICGhJvthiBzGcW6GGW
        mD9rKiPEsh2MEq17r7CAFLEJaEk0doJdxwn0wqQHq9gh5mhKtG7/DWXLS2x/O4cZ4gNFiUk3
        30N9Vivx+e8zxgmMorOQnDcLyRmzkIyahWTUAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmb
        GIGpY9uxn1t2MK589VHvECMTB+MhRgkOZiURXjdmiRQh3pTEyqrUovz4otKc1OJDjKbAMJrI
        LCWanA9MXnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwMymwC
        TpNn7j6sZ8lplHKrTqX15ur7P77v+rnkrcqXpR/fXJPkOXIyfEPPRYuz979NtKlLeF9591cG
        44pOPYG2dXGeZjLHv8zdEKZ47PrZctNFK0tT5r2yefBm/c2TKUlnH00VnnHLnU1JM9VxnhCP
        s0RTcBf3motOn53W7xEurPnRd2bWdNm6Rw6HFnZkvNrgNee2WnpOVcmhfwomqr07Ln+awhMu
        zrz8mo7pgqspWY2H1k5ZmNx4t/4af1bMSsVlbrs39Tq///Tm1nPZBbtCusTsvI/kJRpXVkrf
        a3VjsZrwQjf8xEN9Jw+t3vn84k4++s/dnktzsote1jPrY2uotWj5lPNXpE7YLih68hslluKM
        REMt5qLiRACWM9NJpgMAAA==
X-CMS-MailID: 20230323150039eucas1p26720ff35cb61c319cf3689f2f692f720
X-Msg-Generator: CA
X-RootMTR: 20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c
References: <CGME20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c@eucas1p2.samsung.com>
        <20230322135013.197076-1-p.raghav@samsung.com>
        <ZBtSevjWLybE6S07@casper.infradead.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Open questions:
>> - Willy pointed out that the calls to folio_set_error() and
>>   folio_clear_uptodate() are not needed anymore in the read path when an
>>   error happens[2]. I still don't understand 100% why they aren't needed
>>   anymore as I see those functions are still called in iomap. It will be
>>   good to put that rationale as a part of the commit message.
> 
> page_endio() was generic.  It needed to handle a lot of cases.  When it's
> being inlined into various completion routines, we know which cases we
> need to handle and can omit all the cases which we don't.
> 
> We know the uptodate flag is clear.  If the uptodate flag is set,
> we don't call the filesystem's read path.  Since we know it's clear,
> we don't need to clear it.
> 
Got it.

> We don't need to set the error flag.  Only some filesystems still use
> the error flag, and orangefs isn't one of them.  I'd like to get rid
> of the error flag altogether, and I've sent patches in the past which
> get us a lot closer to that desired outcome.  Not sure we're there yet.
> Regardless, generic code doesn't check the error flag.

Thanks for the explanation. I think found the series you are referring here.

https://lore.kernel.org/linux-mm/20220527155036.524743-1-willy@infradead.org/#t

I see orangefs is still setting the error flag in orangefs_read_folio(), so
it should be removed at some point?

I also changed mpage to **not set** the error flag in the read path. It does beg
the question whether block_read_full_folio() and iomap_finish_folio_read() should
also follow the suit.

--
Pankaj
