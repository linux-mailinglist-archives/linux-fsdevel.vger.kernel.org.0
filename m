Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CADC7A49D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 14:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbjIRMf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 08:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241872AbjIRMfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:35:55 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981DF1B8
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:35:32 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230918123530euoutp02059011584d43fa80273f7d1162b45925~F-mHRnNWs1640816408euoutp02M
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 12:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230918123530euoutp02059011584d43fa80273f7d1162b45925~F-mHRnNWs1640816408euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695040530;
        bh=i8zc9iaYygMGUIBqdtuTE0T+kxO2lOWm6HxzXg91t0A=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=f8WxOS+sD490Ku8mAk2RRHaG5OUoSM+QIFzy7fI2MX5a8OmyDBWC7bJVDt0pBsEoR
         YjrA55Bo2A4BTYdceI14iaGzzGFeE68fcIykblzXJxmG2KcWFoh5vQVXs75HjT2zdl
         yM22O85vKSiTEd+QcdTfMU4I3nP9gWATykbL8nhE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230918123530eucas1p1b02dd398e6cc9f91afea96d8d9493af9~F-mG5gCKT1129911299eucas1p1c;
        Mon, 18 Sep 2023 12:35:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 72.9A.42423.21448056; Mon, 18
        Sep 2023 13:35:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230918123529eucas1p2eff7928119d9f97e7b4e338408db7a16~F-mGbTQOz2707827078eucas1p2W;
        Mon, 18 Sep 2023 12:35:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230918123529eusmtrp1d6a09092578b08891381f7e1215e6077~F-mGYvN8b1928419284eusmtrp1U;
        Mon, 18 Sep 2023 12:35:29 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-46-65084412f88e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.76.14344.11448056; Mon, 18
        Sep 2023 13:35:29 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230918123529eusmtip19fdff081bcf68bf4c4329787c4676c3e~F-mGPMTH81256512565eusmtip16;
        Mon, 18 Sep 2023 12:35:29 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.18) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 18 Sep 2023 13:35:28 +0100
Message-ID: <4dbdcc6c-6bd1-faf4-7187-cc048acd2125@samsung.com>
Date:   Mon, 18 Sep 2023 14:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.15.1
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Pankaj Raghav <kernel@pankajraghav.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>, <da.gomez@samsung.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <djwong@kernel.org>, <linux-mm@kvack.org>,
        <chandan.babu@oracle.com>, <mcgrof@kernel.org>,
        <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZQSnWUF2M1iNzGWM@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.18]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7pCLhypBkuOSFjMWb+GzeLSUTmL
        LcfuMVpcfsJnceblZxaLPXtPslhc3jWHzeLemv+sFrv+7GC3uDHhKaPF7x9z2By4PU4tkvDY
        vELLY9OqTjaPTZ8msXucmPGbxePj01ssHmdXOnp83iQXwBHFZZOSmpNZllqkb5fAldE15S5T
        wUHOihnz5zM2MO5j72Lk5JAQMJF4s2IuI4gtJLCCUWJmv2cXIxeQ/YVRYvmBD2wQzmdGiY/d
        K+A6uhu3s0AkljNKnN67AqHq5qNmqMwuRom/Z98xdTFycPAK2Ek8eBoK0s0ioCpx8/AsJhCb
        V0BQ4uTMJywgtqhAtMTMaQvB7hAWsJX4+OkZK4jNLCAucevJfLAxIgLBEq/PmoGMZxZYyiTx
        4exvFpA4m4CWRGMn2HGcQMf1LO1khmjVlGjd/psdwpaX2P52DjPEA0oSC9vusEHYtRKnttxi
        ApkpIbCaU+JJ/0qohIvEpm3noGxhiVfHt0B9LyNxenIPC4RdLfH0xm9miOYWRon+nevZQA6S
        ELCW6DuTA1HjKHF4xXlmiDCfxI23ghD38ElM2jadeQKj6iykkJiF5ONZSF6YheSFBYwsqxjF
        U0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQIT2Ol/xz/tYJz76qPeIUYmDsZDjBIczEoivDMN
        2VKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MJlLLfY8
        HWCk38EbtU+qT7qkPOfexLVrczh6tkQePjejNmze3CUno67G1//f7jrxv057+NFULzvpyCXJ
        ZZN1PWQyd/3zF1RZ91RddbeRVYKQyJOZ4gXrJj35EzLJ1TzIV9Hh1sWz59NXOCSZuE+x/lJw
        XXXGbndu9vzFTF+D/18zDEm28176cvqbL/4HLaZ92zrb62bjAf6KN1827ZQUvDN5Y81nXc/z
        GgkL8macUr5ntntDqqbqBq9e5QPttaHnsheYtL2+F9F+I/BIqeUWEY6s2Z7MQjtjxCx/V3W9
        dFbynsvaddYwm2tl8/ElL+bvKvjEXGUw8/yjhiiWdkbHJSmKvJeTnsQW/Vjsy33XR4mlOCPR
        UIu5qDgRAGFb1UbPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7qCLhypBhN3mljMWb+GzeLSUTmL
        LcfuMVpcfsJnceblZxaLPXtPslhc3jWHzeLemv+sFrv+7GC3uDHhKaPF7x9z2By4PU4tkvDY
        vELLY9OqTjaPTZ8msXucmPGbxePj01ssHmdXOnp83iQXwBGlZ1OUX1qSqpCRX1xiqxRtaGGk
        Z2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9E15S5TwUHOihnz5zM2MO5j72Lk5JAQ
        MJHobtzO0sXIxSEksJRRYtLql1AJGYmNX66yQtjCEn+udbFBFH1klFh7+i1Uxy5Gie1/bgN1
        cHDwCthJPHgaCtLAIqAqcfPwLCYQm1dAUOLkzCcsICWiAtESXS+NQcLCArYSHz89A5vPLCAu
        cevJfCaQEhGBYInXZ81ApjMLLGWS+HD2N9SqPYwSn16tBitiE9CSaOwEu5MT6IGepZ3MEHM0
        JVq3/2aHsOUltr+dwwxxv5LEwrY7bBB2rcTnv88YJzCKzkJy3SwkZ8xCMmoWklELGFlWMYqk
        lhbnpucWG+kVJ+YWl+al6yXn525iBMb9tmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8Mw3ZUoV4
        UxIrq1KL8uOLSnNSiw8xmgKDaCKzlGhyPjDx5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQn
        lqRmp6YWpBbB9DFxcEo1MC36uuCfcsNOiblvgz/tkLt7peTASu1ZO942fwwp/hT93yjhquHy
        lvSpBVLFW9y33+xamLWYjz/drSaD9USuF8vXdesuWVTzPrxkN0eNiW/ZNcv2JY5RmzO7yifN
        CbxSXKgjGOaUtu5//4UuJxNhweaXEqsFfn9Zw3mJ19WyTPDTn+2xEe9yRZczPbVg3bPh8oZ9
        +97rHFFv+b1r+3UjiZLHDuKZl/xznMUu7pPTylWJWjWz4tOcst5fO+Z6Fl2zkhZlYSlpXpnl
        /pv91J+Ateb+K34HSWv8fvjhROSdOQ88C8UfzA9LkZ2Vol9z5LbcfJ2SH+/2GC9bf5rJg7VO
        ONrALkqq80W2z0Gvyl43PiWW4oxEQy3mouJEAELC1IKEAwAA
X-CMS-MailID: 20230918123529eucas1p2eff7928119d9f97e7b4e338408db7a16
X-Msg-Generator: CA
X-RootMTR: 20230915185016eucas1p18b6d44c1b875ef8d87a9575e3ddff8d1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230915185016eucas1p18b6d44c1b875ef8d87a9575e3ddff8d1
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
        <CGME20230915185016eucas1p18b6d44c1b875ef8d87a9575e3ddff8d1@eucas1p1.samsung.com>
        <ZQSnWUF2M1iNzGWM@casper.infradead.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-09-15 20:50, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 08:38:25PM +0200, Pankaj Raghav wrote:
>> Only XFS was enabled and tested as a part of this series as it has
>> supported block sizes up to 64k and sector sizes up to 32k for years.
>> The only thing missing was the page cache magic to enable bs > ps. However any filesystem
>> that doesn't depend on buffer-heads and support larger block sizes
>> already should be able to leverage this effort to also support LBS,
>> bs > ps.
> 
> I think you should choose whether you're going to use 'bs > ps' or LBS
> and stick to it.  They're both pretty inscrutable and using both
> interchanagbly is worse.
> 

Got it! Probably I will stick to Large block size and explain what it means
at the start of the patchset.

> But I think filesystems which use buffer_heads should be fine to support
> bs > ps.  The problems with the buffer cache are really when you try to
> support small block sizes and large folio sizes (eg arrays of bhs on
> the stack).  Supporting bs == folio_size shouldn't be a problem.
> 

I remember some patches from you trying to avoid the stack limitation while working
with bh. Thanks for the clarification!
