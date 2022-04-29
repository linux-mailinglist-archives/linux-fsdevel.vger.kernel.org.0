Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34C5514383
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355333AbiD2H6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 03:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355313AbiD2H6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:58:47 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAE239B97
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 00:55:26 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220429075523euoutp01dbdce1831544764a21748de0527b34a5~qTtzVN3500036900369euoutp01Z
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 07:55:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220429075523euoutp01dbdce1831544764a21748de0527b34a5~qTtzVN3500036900369euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651218923;
        bh=bI8Rkw8VYhP6ElpRPvYBxmnt/vOhfFyD8CJi294HeBw=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=HoryqjTOG82NnqnnNj+3vhs/FX2Q5GjZ+wHNNCBoBQ+IDE0GpweNh8zskco917Hmn
         Ksh/uEnpMTVtmvTHZMzlxyoPAN/691uOnOrYYjYQRESFHzOdkYPrZM2dvhVeaQZKcb
         nay2N5cHbEGgWKEd26uPSMz7PdD0Jmg5LOnT6sW4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220429075523eucas1p256537cb0c8ef40f290f7fd4eaf86ac2c~qTtyzy38B2182821828eucas1p2D;
        Fri, 29 Apr 2022 07:55:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 58.9C.10260.BE99B626; Fri, 29
        Apr 2022 08:55:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220429075522eucas1p23cf6e8071f09d7120c1e7f478d7affb7~qTtyWBlWB0294802948eucas1p2h;
        Fri, 29 Apr 2022 07:55:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220429075522eusmtrp195fdb2491c8fe5ebf4b3338c61a748e2~qTtyUgZAB1327413274eusmtrp1p;
        Fri, 29 Apr 2022 07:55:22 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-71-626b99eb914c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7B.66.09404.AE99B626; Fri, 29
        Apr 2022 08:55:22 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220429075522eusmtip22810b8b6a3a13d12d5b555bfcd6aeb24~qTtyKSmCb0091400914eusmtip27;
        Fri, 29 Apr 2022 07:55:22 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.170) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 29 Apr 2022 08:55:19 +0100
Message-ID: <5927dc09-89ca-973a-2e24-99be696d4240@samsung.com>
Date:   Fri, 29 Apr 2022 09:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 12/16] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jaegeuk@kernel.org>, <axboe@kernel.dk>, <snitzer@kernel.org>,
        <hch@lst.de>, <mcgrof@kernel.org>, <naohiro.aota@wdc.com>,
        <sagi@grimberg.me>, <dsterba@suse.com>,
        <johannes.thumshirn@wdc.com>
CC:     <linux-kernel@vger.kernel.org>, <clm@fb.com>,
        <gost.dev@samsung.com>, <chao@kernel.org>, <josef@toxicpanda.com>,
        <jonathan.derrick@linux.dev>, <agk@redhat.com>,
        <kbusch@kernel.org>, <kch@nvidia.com>,
        <linux-nvme@lists.infradead.org>, <bvanassche@acm.org>,
        <jiangbo.365@bytedance.com>, <linux-fsdevel@vger.kernel.org>,
        <matias.bjorling@wdc.com>, <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <a68a2d40-dff4-bac6-bb05-57c5c88af66e@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.170]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxj2O+f0nEMX6gFc+MTpshqyzU0u0yVfhnEM0Jxk+7EsShhLplVO
        gLW0pIV5gcUSioZ7gcmgmpRdMrAMOkDLWAfRLlzkbqEKBOhgrRAIoEKXsdZulFMX/j3v8z3P
        +77Pm4/Gg+vJMDpdnsUp5RKZmBQSpp7N4cPLtdJzUT02Chn7e3DUOFNOouonmzgauD6Eocry
        Ggq5h0ZwNPp3HoZuNXZjyGHU4ajk7hMCPS+a3eI0czjyzEWjSstDgJw2HYY6p95Cv3XeJ9DY
        rzdJpP/RSSHtVReOJrROgCp62wSoeXmNQH1T+2IhOzb+Ievt+4lkK/JXKXZktoVgx4ay2VZD
        Icl+q76Os20/XGHNk2qSLc1fJdmOAruAXeuykazxto1gtW0tAna99QB77W4x9jGTLDyWwsnS
        v+SUkcfPCtN+H7JSmQbqYkv9IqkGc4IiEEBD5ih0LjRTRUBIBzMNAOpKrSRfbAA43WXD+WId
        wPkRA/7C8kjznV9VD+BgdS3xv6r4zqK/mRnA5appymcJZI7DZzXdWyqaJphwuDT6OU8Hwfu1
        DsKHX2aSYLVukPThEOYENDf9u83jTCiccugxX889jBvAseFVga/AGQ0O1x5bKV9TkjkE8wq3
        ZwUwJ6FlwS7gzW/CgnY3xeNXYfvKTX+Eg7BqYhzj8VewqWdwe2nIdAvh9PCi/zQJUG2vJ3kc
        Apd6b1M8fgUOVJUQPM6Bzgk3zps1AJZ3GEnfQpCJgWWDMl7zAXx6Te2nRXBiJYjfRwQrTd/g
        WhCu23EL3Y7Muh0RdDsi1AHCAEK5bFVGKqc6IucuRKgkGapseWrEeUVGK9j6ywPeXtcvoGHp
        aYQFYDSwAEjj4j2BG+a0c8GBKZJLlzml4owyW8apLGAfTYhDA8+n/ywJZlIlWZyU4zI55YtX
        jA4IU2O5+sAkz+66tv2y+XB3abhl7WvPzNspFa8XBtzQwxx5rgMJmsZsKwew4ob+vTVzu06p
        pJXNhs737OaFyBys7M5u9vRMFLvRGvPGOm7cDNKqZ2Pql4KTTgrdj2H8maxkhWRKp/9r0rQL
        5D0znFosinP9mZwf2SDyvBMtFn0xlxfywPtZndZe1uey6aURVwIw01XFEW9YRlzsa573T3S9
        NH4x5aPnDIjbW2I6LdxPK5QPNKuiS5sd6luPPhElHhPE3ku4kOCIP3jPelgqvuFtjO87Wrn2
        abt2fsU1/s9MgdOqHLW7Eh8mSjKrrIvJ3xv7L2dNlv9hXD8bpyjZeDc3Skyo0iTRh3ClSvIf
        T3lrRzoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsVy+t/xe7qvZmYnGUxtVrVYf+oYs8Xqu/1s
        FtM+/GS2OD31LJPFpP4Z7Ba/z55ntrjwo5HJYuXqo0wWT9bPYrboOfCBxeJv1z2gWMtDZos/
        Dw0tJh26xmjx9OosJou9t7Qt9uw9yWJxedccNov5y56yW0xo+8pscWPCU0aLicc3s1qse/2e
        xeLELWkHCY/LV7w9/p1Yw+Yxsfkdu8f5extZPC6fLfXYtKqTzWNhw1Rmj81L6j1232xg8+ht
        fsfmsbP1PqvH+31X2TzWb7nK4jFh80ZWj8+b5DzaD3QzBQhE6dkU5ZeWpCpk5BeX2CpFG1oY
        6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GUcPnuJvWAVe8XG5S/YGhgfsnYxcnJI
        CJhIXG9ZxNbFyMUhJLCUUWL7mZdQCRmJT1c+skPYwhJ/rnVBFX1klJj1bR8LhLObUeJV318m
        kCpeATuJTzOOAiU4OFgEVCVeXYiDCAtKnJz5hAXEFhWIkHiw+yzYAmEBV4nda/+DxZkFxCVu
        PZnPBDJTROA3o8Tlc+9YQRxmgRZmiffPLrFDbHvLJPHzaD8zyAY2AS2Jxk6w8zgF3CQOPb/P
        CjFJU6J1+292CFteYvvbOcwQLyhLTL5xhQnCrpV4dX834wRG0VlIDpyF5JBZSEbNQjJqASPL
        KkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBktu3Yzy07GFe++qh3iJGJg/EQowQHs5II75fd
        GUlCvCmJlVWpRfnxRaU5qcWHGE2BgTSRWUo0OR+YTvNK4g3NDEwNTcwsDUwtzYyVxHk9CzoS
        hQTSE0tSs1NTC1KLYPqYODilGpjqJDZZJUXe2X7Drj5mwR71qudZQQV9ieWPJNYlTelvy/vE
        5ah3fqHe3O3hz72kI1Vsplp0XU/SzOTLSj7LP+ni/OdLW++a9lyz1s+a7/2Vv/CCfe0Ua8/o
        wptTow783PMocZb4B8MwE+NDs2+IW3dP/D5nYpmXjYB089qQWr//LAZ8nO9u71TTvCw6/Rdb
        VZzbNrtIF+Wvea9Ybh1R/3DnTB1n5VqXM05JomGv9zZmSih0O8qt6fgUycHiaHjmbeRaHp8e
        vxNPGZauN78l0xa78equlZu6raSMtm7ZtveNC++qLP15mfOcNr918HtwJWzlvaC7C66vvlFt
        bcHOtZ/nXzwfz3/G6NshvR53bJVYijMSDbWYi4oTARtV/pXvAwAA
X-CMS-MailID: 20220429075522eucas1p23cf6e8071f09d7120c1e7f478d7affb7
X-Msg-Generator: CA
X-RootMTR: 20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44@eucas1p2.samsung.com>
        <20220427160255.300418-13-p.raghav@samsung.com>
        <bfc1ddc3-5db3-6879-b6ab-210a00b82c6b@opensource.wdc.com>
        <c490bd45-deab-8c2b-151c-c8db9f97e10c@samsung.com>
        <a68a2d40-dff4-bac6-bb05-57c5c88af66e@opensource.wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Damien,
On 2022-04-28 23:49, Damien Le Moal wrote:
> This is still not convincing given the code I saw. Additional test cases
> need to be added with data verification & concurrent regular writes also
> sent while doing copy to verify locking.
> 
> Which also reminds me that I have not seen any change to mq-deadline zone
> write locking for this series. What is the assumption ? That users should
> not be issuing writes when a copy is on-going ? What a bout the reverse
> case ? at the very least, it seems that blk_issue_copy() should be taking
> the zone write lock.
> 
I think you posted this comment in this thread instead of posting it in
the copy offload thread.

>> I will make sure to add my private tree for zonefs in my cover letter in
>> the next rev. But even without that change, a typical emulated npo2
>> device should work fine because the changes are applicable only for
>> "runt" zones.
> 
> 
