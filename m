Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD76CC75E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjC1QCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjC1QCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:02:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E484CA36
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 09:02:14 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230328160212euoutp02f563fe4055dcdf640eaa23b6c0dcd89a~QoK5tN1Lb1093310933euoutp02q
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 16:02:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230328160212euoutp02f563fe4055dcdf640eaa23b6c0dcd89a~QoK5tN1Lb1093310933euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680019332;
        bh=7dPe4cUrgnbdf3HAeVnRIAMKKWilzlUiWCOWvNtQztM=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=oxjP2lIeoHPtK6uDyeQva4IinKzim3e/3wEGlLCzicvmhTcDFodP2vDr1huNrWOEJ
         moFxNh2fqkH7ZJ0Vm2H+U+3+08d+HcWx9EpbG8ifiCYR2ncITiGgakSP4yDHxFvWSe
         lFXzx9dYDwgrB2o5qv/c8HcEq7qJqLulE1Yx85Co=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230328160211eucas1p1658d4fb55db67a0b9fb10fe0d25b6003~QoK5aNQ3s0751007510eucas1p1V;
        Tue, 28 Mar 2023 16:02:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 22.48.10014.38F03246; Tue, 28
        Mar 2023 17:02:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230328160211eucas1p15999058f9b91a8f58b22e648703641d1~QoK5Brd_u2348323483eucas1p1q;
        Tue, 28 Mar 2023 16:02:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230328160211eusmtrp237848036f912b54a84cd65576e23ed3f~QoK5A_VU60282702827eusmtrp2z;
        Tue, 28 Mar 2023 16:02:11 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-91-64230f83c407
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E4.ED.09583.38F03246; Tue, 28
        Mar 2023 17:02:11 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230328160211eusmtip1270d47cc2f9bd98b238cf47fc5736bb7~QoK42ZgMs0950009500eusmtip1C;
        Tue, 28 Mar 2023 16:02:11 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.108) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 28 Mar 2023 17:02:09 +0100
Message-ID: <970b8475-a52e-9adc-65cf-5a95220bd35b@samsung.com>
Date:   Tue, 28 Mar 2023 18:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH 2/5] orangefs: use folios in orangefs_readahead
To:     Matthew Wilcox <willy@infradead.org>
CC:     <martin@omnibond.com>, <axboe@kernel.dk>, <minchan@kernel.org>,
        <akpm@linux-foundation.org>, <hubcap@omnibond.com>,
        <viro@zeniv.linux.org.uk>, <senozhatsky@chromium.org>,
        <brauner@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <mcgrof@kernel.org>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>,
        <linux-mm@kvack.org>, <devel@lists.orangefs.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZCMF+QjynkdSHbn0@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.108]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87rN/MopBnv+q1jMWb+GzWL13X42
        i9eHPzFa7N88hcmi/W4fk8XeW9oWe/aeZLG4vGsOm8W9Nf9ZLU6u/89scWPCU0aLZV/fs1vs
        3riIzeL83+OsFr9/zGFz4PeY3XCRxWPzCi2Py2dLPTat6mTz2PRpErvHiRm/WTwapt5i8/h1
        +w6rx+dNch6bnrxlCuCK4rJJSc3JLEst0rdL4Mr4uryXuWATa8W3yeeYGxjXs3QxcnJICJhI
        3Nz4lKmLkYtDSGAFo8T+hW9YIZwvjBKbni6HynxmlFi0ZyFcy5tty5ghEssZJeb+bmGGqzr0
        r5MNwtnNKHFk0jYmkBZeATuJ/rUzWEFsFgFViQeHJzJCxAUlTs58AjZWVCBKou/2JrAaYQFn
        ic7Fk9m7GDk4RAQ0JN5sMQKZySzQwyzxbcpWsJnMAuISt57MZwKpYRPQkmjsZAcJcwJdd79x
        KxtEiaZE6/bf7BC2vMT2t3OYQcolBJQlfp/3h3imVuLUlltgX0oI3OOUaPzazgaRcJHYe2Ef
        I4QtLPHq+BZ2CFtG4v/O+UwQdrXE0xu/mSGaWxgl+neuZ4NYYC3RdyYHosZR4nz7Eqi9fBI3
        3gpCnMMnMWnbdOYJjKqzkAJiFpLHZiH5YBaSDxYwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvX
        S87P3cQITIGn/x3/uoNxxauPeocYmTgYDzFKcDArifD+vqaUIsSbklhZlVqUH19UmpNafIhR
        moNFSZxX2/ZkspBAemJJanZqakFqEUyWiYNTqoFp5RynzmWcXBGHDtxc63kg5swp0UTpvlS/
        q+J5O/V/zqj217SScnmUXBXN69RfnvREsvJwVvvH2cJHCluEW6eaXvZYaHRxx9K5NYa3/j35
        Jfavn/vvpZbbXCz2b++8+Pnu8NcQtsvuKWzFX9cap+aum+ixbsHLc+YJO48YTfQOWbTH5HT+
        x4PRdr1+fpecg4wTGnrK1q06vey3zetDqt5sRnuNf6bNjbG/b3jywc5XUmcDF5tdN0qJsBOq
        WtsstG5C8ATGnvp909zqt2xi4KqQdPJY27Jxya2ATXaaS6tbDXdG9D9Y8oVV4canXZ4rIkW2
        5igenvL6VLvG4pm2W7hPBk+I0An8t+vH27Oa8nF5SizFGYmGWsxFxYkAr25n7/ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsVy+t/xu7rN/MopBks/8VjMWb+GzWL13X42
        i9eHPzFa7N88hcmi/W4fk8XeW9oWe/aeZLG4vGsOm8W9Nf9ZLU6u/89scWPCU0aLZV/fs1vs
        3riIzeL83+OsFr9/zGFz4PeY3XCRxWPzCi2Py2dLPTat6mTz2PRpErvHiRm/WTwapt5i8/h1
        +w6rx+dNch6bnrxlCuCK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mv4uryXuWATa8W3yeeYGxjXs3QxcnJICJhIvNm2jBnEFhJYyigx6aE5RFxG
        4tOVj+wQtrDEn2tdbF2MXEA1Hxkl+hc+Z4JwdjNKdG/+yQhSxStgJ9G/dgYriM0ioCrx4PBE
        qLigxMmZT8C2iQpESXw+0AI2VVjAWaJz8WQgm4NDREBD4s0WI5CZzAI9zBLfpmyFWvCcUeLw
        p342kAZmAXGJW0/mM4E0sAloSTR2gs3hBPrgfuNWqBJNidbtv9khbHmJ7W/nMIOUSwgoS/w+
        7w/xTK3E57/PGCcwis5Cct0sJAtmIZk0C8mkBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3
        MQLTxrZjP7fsYFz56qPeIUYmDsZDjBIczEoivL+vKaUI8aYkVlalFuXHF5XmpBYfYjQFBtFE
        ZinR5Hxg4soriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamBi/Kdy
        89c9DllBva1zvSWUpu+cwsnYJ9D8efV/yxgrgQiu5JKVXPOFX4ZOVcnXOBBXdcbwWt2ddZk8
        /k+sBJaec9vWnRfxaZ7OnzkCUy9vUZW7bZYjvmudeeeB1Jwbm18qiJ1NNXnW+XTS7IiTbQpH
        lk/sehKQlrGs0WeV2cPpXiscDvjnqE+5uczkjQg/0+mGx766Cw5Xb/u59fl+vmvec9Q37tu+
        dTO/QGF9yrmMN/v2qp730X1p/zDje3Xuws8v/wsYh76Za3N08jrP3X1S5iuvfVjTIMe2KN5U
        /DuboCHby+qK+taA8CfJYhaSd6xmhl1RWsdrO+P4dsGTWv3eYu+dm6sd1Lcweu6tnqGnxFKc
        kWioxVxUnAgAIoc0dKQDAAA=
X-CMS-MailID: 20230328160211eucas1p15999058f9b91a8f58b22e648703641d1
X-Msg-Generator: CA
X-RootMTR: 20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497
References: <20230328112716.50120-1-p.raghav@samsung.com>
        <CGME20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497@eucas1p2.samsung.com>
        <20230328112716.50120-3-p.raghav@samsung.com>
        <ZCMF+QjynkdSHbn0@casper.infradead.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-28 17:21, Matthew Wilcox wrote:
> On Tue, Mar 28, 2023 at 01:27:13PM +0200, Pankaj Raghav wrote:
>> Convert orangefs_readahead() from using struct page to struct folio.
>> This conversion removes the call to page_endio() which is soon to be
>> removed, and simplifies the final page handling.
>>
>> The page error flags is not required to be set in the error case as
>> orangefs doesn't depend on them.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Shouldn't Mike's tested-by be in here?

I mentioned that he tested in my cover letter as I didn't receive a Tested-by
tag from him.
