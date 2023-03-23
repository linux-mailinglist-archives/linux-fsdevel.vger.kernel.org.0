Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E046C6D2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjCWQRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 12:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCWQRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:17:16 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F0D31BEE
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 09:17:08 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230323161704euoutp028d7bd735269ff08145b256b79caf55a2~PGJdq3X-90181701817euoutp023
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 16:17:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230323161704euoutp028d7bd735269ff08145b256b79caf55a2~PGJdq3X-90181701817euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679588224;
        bh=NC0js/0E3Lmn93x2gAtkO3H2r7kJun3rlD/UogXKMmk=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Rps3jbjoKJjTPqNLSBDj9URmKyPAV/AbdvYBrpwlA8T2/VndNLxPneUJ8G2VW4mTD
         oLDjBGfBDWjBr8uVSJubBtbuK+aupoyjFYTxT0M5SwVq4QE76cdfirSpd4wgUUORq2
         TS0HiPhch1SsDQIhwNUNmFmxEbkZo76ld9vP/hlk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230323161704eucas1p2faa7b65ac36f6a3d0a17f66f18211380~PGJdJJM6i0730607306eucas1p2C;
        Thu, 23 Mar 2023 16:17:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.D0.09503.F7B7C146; Thu, 23
        Mar 2023 16:17:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230323161703eucas1p1eaaf0da321fcbf807af78fb3224baf59~PGJcztT1q1108211082eucas1p1y;
        Thu, 23 Mar 2023 16:17:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230323161703eusmtrp104829574f193b3aac92abd40a47b5760~PGJczCpJZ1658716587eusmtrp1T;
        Thu, 23 Mar 2023 16:17:03 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-12-641c7b7fee58
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.B6.08862.F7B7C146; Thu, 23
        Mar 2023 16:17:03 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230323161703eusmtip2214de612046c115e47c514f99c83abf2~PGJcnZBIa0225902259eusmtip2f;
        Thu, 23 Mar 2023 16:17:03 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 23 Mar 2023 16:16:59 +0000
Message-ID: <655ddc1c-8b64-1168-0f6b-76c565363325@samsung.com>
Date:   Thu, 23 Mar 2023 17:16:59 +0100
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
In-Reply-To: <ZBxxPw9BTdkE4KF0@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87r11TIpBr/X21jMWb+GzWL13X42
        i9eHPzFa7N88hcmi/W4fk8XeW9oWe/aeZLG4vGsOm8W9Nf9ZLU6u/89scWPCU0aLZV/fs1vs
        3riIzeL83+OsFr9/zGFz4PeY3XCRxWPzCi2Py2dLPTat6mTz2PRpErvHiRm/WTwapt5i8/h1
        +w6rx+dNch6bnrxlCuCK4rJJSc3JLEst0rdL4MqYf2U6c8EalorJtywaGHczdzFyckgImEic
        /vCLpYuRi0NIYAWjRMvnY+wQzhdGiX1fXoBVCQl8ZpT4OsURpuPqpE1sEEXLGSWOthxmhXCA
        ij7e3w/l7GSUeNu7lKmLkYODV8BOYsJ7X5BuFgFViQMtW9lBbF4BQYmTM5+wgJSICkRJvHhd
        BhIWFtCVuLinkwXEZhYQl7j1ZD7YFBEBDYk3W4xApjML9DBLLFq7C6yVTUBLorETbCIn0G1v
        3y9jhWjVlGjd/psdwpaX2P52DtTHihKTbr5nhbBrJU5tucUEMlNC4B6nxLMjh9ghEi4S6x7P
        gLKFJV4d3wJly0icntzDAmFXSzy98ZsZormFUaJ/53o2kIMkBKwl+s7kQNQ4SuzZfJ4VIswn
        ceOtIMQ9fBKTtk1nnsCoOgspIGYh+XgWkhdmIXlhASPLKkbx1NLi3PTUYsO81HK94sTc4tK8
        dL3k/NxNjMDkd/rf8U87GOe++qh3iJGJg/EQowQHs5IIrxuzRIoQb0piZVVqUX58UWlOavEh
        RmkOFiVxXm3bk8lCAumJJanZqakFqUUwWSYOTqkGpv5rv5R+i8nVBNoYTv7xwn3fJF3Bb/xF
        M7+fayrzN1wpbmPQWmeUVL3w6el366/4Sqln1SVnMn69cyoz9+O2XXfnaInv9mm0+Ofw9dLh
        qIqvz9mNZjWcyNzfW9l6ffXHs74PT8Q6nzfMlXY05vz07tzhkLCTsgINfyPiJZ78USzr5jqw
        V3PiFv2tVv1P8pufOJklKMmu2q7h4i05wz588YmAyk0b6p0vzl3De9dJI6pPgmtVP8+q89Kr
        rl3dsaBhOa/ByV0zGr5VMfKXhMif8Nxz4E9Iy9Sg0rO1t27rfsrdXDy5PypfqUHrZXBybWH6
        F+nfx0/OkmiYJN+fNu/g7ejJwQmXfTeELnqRXGaarcRSnJFoqMVcVJwIAOVFs6ftAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsVy+t/xe7r11TIpBve+qFrMWb+GzWL13X42
        i9eHPzFa7N88hcmi/W4fk8XeW9oWe/aeZLG4vGsOm8W9Nf9ZLU6u/89scWPCU0aLZV/fs1vs
        3riIzeL83+OsFr9/zGFz4PeY3XCRxWPzCi2Py2dLPTat6mTz2PRpErvHiRm/WTwapt5i8/h1
        +w6rx+dNch6bnrxlCuCK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0MuYf2U6c8EalorJtywaGHczdzFyckgImEhcnbSJrYuRi0NIYCmjxPv5F9kg
        EjISn658ZIewhSX+XOuCKvrIKNFw6D8zhLOTUWL6mU+sXYwcHLwCdhIT3vuCNLAIqEocaNkK
        1swrIChxcuYTFhBbVCBK4umdQ2CbhQV0JS7u6QSLMwuIS9x6Mp8JZIyIgIbEmy1GIOOZBXqY
        JebPmsoIsWs6k8SFmdPZQYrYBLQkGjvB5nMCffD2/TJWiDmaEq3bf7ND2PIS29/OgfpSUWLS
        zfesEHatxOe/zxgnMIrOQnLeLCRnzEIyahaSUQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefn
        bmIEpo1tx35u3sE479VHvUOMTByMhxglOJiVRHjdmCVShHhTEiurUovy44tKc1KLDzGaAsNo
        IrOUaHI+MHHllcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwBXK9
        7G2peeHeeG6y3EwRrtM/zSLNXgopyy74Vp2p/4Z/7a6qmbO3RSWr3z5/e7Ot9TzGqVZBPs8V
        V3YenSiwW6VD+UicRKZ9Yf43gxOu7w6LPLmypc+q9P4P7ivcaxzPz+At/H2MaZ7/TfGGG88D
        uQKV9aeeNOx74C3OHMPPdFjq/Gzn8+JZNyK0VuzcHmvwsC+gKlPPZK47U+49Bf7TdxNvdmpk
        PzKuf+PcHHNeV+hJ8uo5V943hzJJbGq58T/9RHnf1YW7W/13fzyYYauxfOb1SScZjZdqXXu5
        uMFuRqeLrZHFw52rG6s/rFS+mHDg2Jz8ws57F963nPSUDPoo8Kk8xV47xHvpWVa71suHlFiK
        MxINtZiLihMBLWdwS6QDAAA=
X-CMS-MailID: 20230323161703eucas1p1eaaf0da321fcbf807af78fb3224baf59
X-Msg-Generator: CA
X-RootMTR: 20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c
References: <CGME20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c@eucas1p2.samsung.com>
        <20230322135013.197076-1-p.raghav@samsung.com>
        <ZBtSevjWLybE6S07@casper.infradead.org>
        <fbf5bc8a-6c82-a43e-dd96-8a9d2b7d3bf4@samsung.com>
        <ZBxxPw9BTdkE4KF0@casper.infradead.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> I also changed mpage to **not set** the error flag in the read path. It does beg
>> the question whether block_read_full_folio() and iomap_finish_folio_read() should
>> also follow the suit.
> 
> Wrong.  mpage is used by filesystems which *DO* check the error flag.
> You can't remove it being set until they're fixed to not check it.
Got it. I think after your explanation on the Error flag, it makes sense why mpage
needs to set the error flag, for now. I will change it as a part of the next version
along with the other comment on Patch 4.
