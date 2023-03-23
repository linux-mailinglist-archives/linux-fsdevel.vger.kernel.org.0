Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCB6C6D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 17:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjCWQWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjCWQWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:22:52 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7112067
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 09:22:51 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230323162249euoutp02bacfb91532fb8b7698c24f4712741f14~PGOe2Dsg50734707347euoutp029
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 16:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230323162249euoutp02bacfb91532fb8b7698c24f4712741f14~PGOe2Dsg50734707347euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679588569;
        bh=7ujf/bKJ7yD6/UNiRCuwv8YzMU2pphMwOGxjA3a/WpY=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=S66famwGxnTjmZ2IDi6wQMo5fjOAnCl1WT4TCpChGehomCgsWU/waSperlmmgSLoz
         BnYnUz+AEOMgm6fEydEP/wQ2+54prHD3+3Z7fBqgHpgTwb/A8uxuRoIqdFUxKwLcuT
         IP/0Qe0PYsfl6JI+duh4KbeF4G9nst6c3IdMx2S0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230323162249eucas1p1492a75aae58e4b5bc6f8e01c7ba429a0~PGOelxMbf1612516125eucas1p13;
        Thu, 23 Mar 2023 16:22:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.B1.09503.9DC7C146; Thu, 23
        Mar 2023 16:22:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230323162248eucas1p187f9aaa15918ebdc18a9ba691f9a1844~PGOeLxzxP1612516125eucas1p10;
        Thu, 23 Mar 2023 16:22:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230323162248eusmtrp12d67246acb3364d89d3061567e106ed1~PGOeLASR22032120321eusmtrp1d;
        Thu, 23 Mar 2023 16:22:48 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-16-641c7cd9114f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.57.08862.8DC7C146; Thu, 23
        Mar 2023 16:22:48 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230323162248eusmtip1239a8f252a853ab3c81fef986196e5b6~PGOeAXP3s1054610546eusmtip1X;
        Thu, 23 Mar 2023 16:22:48 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 23 Mar 2023 16:22:47 +0000
Message-ID: <bcc2d644-33c4-8ea0-aa4e-0ec155b25370@samsung.com>
Date:   Thu, 23 Mar 2023 17:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.8.0
Subject: Re: [RFC v2 0/5] remove page_endio()
Content-Language: en-US
To:     Mike Marshall <hubcap@omnibond.com>
CC:     <senozhatsky@chromium.org>, <viro@zeniv.linux.org.uk>,
        <axboe@kernel.dk>, <willy@infradead.org>, <brauner@kernel.org>,
        <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <martin@omnibond.com>, <mcgrof@kernel.org>,
        <devel@lists.orangefs.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <CAOg9mSRvPDysNF-GV_ZGf8bu1-50wA5y7L=LuZwGp+vEVzsu1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87o3a2RSDNofs1nMWb+GzWL13X42
        i9eHPzFa7N88hcmi/W4fk8XeW9oWe/aeZLG4vGsOm8W9Nf9ZLU6u/89scWPCU0aLZV/fs1vs
        3riIzeL83+OsFr9/zGFz4PeY3XCRxWPzCi2Py2dLPTat6mTz2PRpErvHiRm/WTwapt5i8/h1
        +w6rx+dNch6bnrxlCuCK4rJJSc3JLEst0rdL4Mq4f+IJa8Eh5oqbp1rYGhjvMHUxcnJICJhI
        XJhzibWLkYtDSGAFo8T+a2eZIJwvjBLz7s5ghnA+M0rsnXgbruXwmleMEInljBJvjn9mg6va
        8/so1LCdjBKP73wDynBw8ArYSUzoigfpZhFQlXg7fw07iM0rIChxcuYTFpASUYEoiRevy0DC
        wgK6Ehf3dLKA2MwC4hK3nswHWywioC5x/v4fdpDxzAI9zBLNE/axg/SyCWhJNHaCjeQUCJTY
        /ekjG0SvpkTr9t/sELa8xPa3c5ghHlCUmHTzPSuEXStxasstsJclBO5xSlz/fY8RIuEiseDx
        FKiPhSVeHd/CDmHLSJye3MMCYVdLPL3xmxmiuYVRon/nerB/JQSsJfrO5EDUOErs2XyeFSLM
        J3HjrSDEPXwSk7ZNZ57AqDoLKSRmIXl5FpIXZiF5YQEjyypG8dTS4tz01GLDvNRyveLE3OLS
        vHS95PzcTYzAFHj63/FPOxjnvvqod4iRiYPxEKMEB7OSCK8bs0SKEG9KYmVValF+fFFpTmrx
        IUZpDhYlcV5t25PJQgLpiSWp2ampBalFMFkmDk6pBiY/YffZRY7GCXqK1xbwyzy6fmnrisBn
        shcDhdY+jvY0z+26cawtSLLPiFN+0XGxC3sNOBY/F9/dLj7j85MpN4SnRF5qcI2JFNE9xNqn
        2S/lYK3Ut35G14KyC4VCjFEdfitncXAd6xB3Wv7AP3GZroxYyQprNpmDioHFM625Z11eWKx7
        Nn7xtghehstXuNsXlHw5aqciJtxvWRIW0vpYfZ5IZEGl0ot993deNXULS5yruzJsktUB3n7t
        H9phN6bdzAgx2/qzQ+T85/UM1gnR5z4KlO8+pqa9pHXl3NItCiE7Z8b1yfTfdlr341HDRGe+
        p3b3vyeePeIaLMwkN9fN/0nPlUCjEu8Z+o/MDu56r8RSnJFoqMVcVJwIAKdTUozwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsVy+t/xu7o3amRSDFqvaFvMWb+GzWL13X42
        i9eHPzFa7N88hcmi/W4fk8XeW9oWe/aeZLG4vGsOm8W9Nf9ZLU6u/89scWPCU0aLZV/fs1vs
        3riIzeL83+OsFr9/zGFz4PeY3XCRxWPzCi2Py2dLPTat6mTz2PRpErvHiRm/WTwapt5i8/h1
        +w6rx+dNch6bnrxlCuCK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mu4f+IJa8Eh5oqbp1rYGhjvMHUxcnJICJhIHF7zirGLkYtDSGApo8T5GTeY
        IRIyEp+ufGSHsIUl/lzrYoMo+sgo8er7JKiOnYwSPUcOAXVwcPAK2ElM6IoHaWARUJV4O38N
        WDOvgKDEyZlPWEBsUYEoiad3DoEtEBbQlbi4pxMsziwgLnHryXywi0QE1CXO3//DDjKfWaCH
        WaLl1ypmiGVXGSX+vm8HW8YmoCXR2Am2gFMgUGL3p49sEIM0JVq3/2aHsOUltr+dA/WNosSk
        m+9ZIexaic9/nzFOYBSdheS+WUjumIVk1CwkoxYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P
        3cQITB3bjv3cvINx3quPeocYmTgYDzFKcDArifC6MUukCPGmJFZWpRblxxeV5qQWH2I0BQbS
        RGYp0eR8YPLKK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgWsp4
        dnfSdd9Uwzb+L1lX/SXn7v7PylCRvY1rmsWPFIvVOxfcE6ljPvmhQvPBCvv/bhMW371U3lG7
        NXu7imykZkv5SuaDkScsSpx4bnoVL4sobJhxNM5w+QXd3yxyP80NyiMF3ALn3T76PkT6yE+X
        bv1LKWX1wR/vyiS1/2RcUswU+tveRmuBnKXb1LdzIixZZW+/u2lYamR+wUQ5Q6/jo53Eh3of
        Xo+SU4fnvlN96b9owhMd1TdlFW5JB3iu7O+el9/5bIdS6q2gqRzs2xp7ZGR/MC6P6yrSqBE8
        vJT7fk6OXeIN8V6z0OzY09+1lRY1F+UvPCPzX/fG8a8ns12OKu9Rn+z31+bXXgW3pS+UWIoz
        Eg21mIuKEwGmndr2pgMAAA==
X-CMS-MailID: 20230323162248eucas1p187f9aaa15918ebdc18a9ba691f9a1844
X-Msg-Generator: CA
X-RootMTR: 20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c
References: <CGME20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c@eucas1p2.samsung.com>
        <20230322135013.197076-1-p.raghav@samsung.com>
        <CAOg9mSRvPDysNF-GV_ZGf8bu1-50wA5y7L=LuZwGp+vEVzsu1Q@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-23 15:30, Mike Marshall wrote:
> I have tested this patch on orangefs on top of 6.3.0-rc3, no
> regressions.
> 

Perfect. Thanks a lot. Could I get a Tested-by from you for the
current change?

> It is very easy to build a single host orangefs test system on
> a vm. There are instructions in orangefs.rst, and also I'd
> be glad to help make them better...
> 
Sounds good. I can do it next time if I change the current code.
