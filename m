Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501116D723C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 04:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjDECB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 22:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjDECB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:01:27 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6742708
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 19:01:25 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230405020123epoutp04e7656ec13cb63d56364ecbe21330d9b0~S53D3dnGA2163521635epoutp04Q
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 02:01:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230405020123epoutp04e7656ec13cb63d56364ecbe21330d9b0~S53D3dnGA2163521635epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680660083;
        bh=4Hkqq5yPgDUmJSoO1cODSHDqLIY1i9aERvlE9gmw2u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGZ182iGEywN5dWknD+D3Hfvqbpsn9/Sk7lSm9mmAWpkxCVIUKnwW4p2UpQefccVw
         65ThqDkkK5+ZvRVZSN/7+ysTR0cuRNt7hDYcrFah0IUqgLk3H3JV9SaqRT6pROBWPQ
         SGLCB8t+pMWHb5A8uHLJh9FWj982Z0v5bbS+0b+Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230405020122epcas2p444155e34741e8dfbb201284791593040~S53DQlKhg2241022410epcas2p4W;
        Wed,  5 Apr 2023 02:01:22 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PrntB1C2pz4x9Q1; Wed,  5 Apr
        2023 02:01:22 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.5F.27926.276DC246; Wed,  5 Apr 2023 11:01:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230405020121epcas2p2d9d39c151b6c5ab9e568ab9e2ab826ce~S53CXxA0A2679826798epcas2p2X;
        Wed,  5 Apr 2023 02:01:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230405020121epsmtrp2b9776bdf6fc11593aa6cca58904de9ca~S53CW9-2a1075410754epsmtrp2D;
        Wed,  5 Apr 2023 02:01:21 +0000 (GMT)
X-AuditID: b6c32a46-a4bff70000006d16-2c-642cd672cb8c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.46.31821.176DC246; Wed,  5 Apr 2023 11:01:21 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230405020121epsmtip2f1f069551ac3bfc9bbcb23d372f720e7~S53CLn1Ny1987219872epsmtip2H;
        Wed,  5 Apr 2023 02:01:21 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     willy@infradead.org
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: RE: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Wed,  5 Apr 2023 11:01:21 +0900
Message-Id: <20230405020121.413658-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZCbjRsmoy1acVN0Z@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmuW7RNZ0Ug0lL2SymH1a0mD71AqPF
        +VmnWCz27D3JYnFvzX9Wi32v9zJbvOg8zmTRseENo8XvH3PYLDbef8fmwOXx78QaNo/NK7Q8
        Fu95yeSx6dMkdo/JN5YzevRtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
        gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB1SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
        lJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjP5PPUwFzwUqema3szUw3ubtYuTkkBAwkXi3
        YxlrFyMXh5DADkaJo58usUE4nxgluj80soBUCQl8ZpTY0lkM03Go/TkLRNEuRom3b+5BtXcx
        SUxp3M0KUsUmoC3x58p5NhBbREBc4tjUk4wgNrPAP0aJPZclQWxhAR+JvpPP2UFsFgFViaNL
        ljGB2LwCNhJ/prSyQ2yTl5h56TuYzQm0+dbzQ8wQNYISJ2c+YYGYKS/RvHU2M0R9J4fE7i2i
        ELaLxOTjU5kgbGGJV8e3QM2Ukvj8bi8bhF0s8fj1P6h4icThJb9ZIGxjiXc3nwP9wgE0X1Ni
        /S59EFNCQFniyC2orXwSHYf/skOEeSU62oQgGlUktv9bzgyz6PT+TVDDPSQOda+AhlQ7o8T6
        +asZJzAqzELyzCwkz8xCWLyAkXkVo1hqQXFuemqxUYERPH6T83M3MYLTqpbbDsYpbz/oHWJk
        4mA8xCjBwawkwqvapZUixJuSWFmVWpQfX1Sak1p8iNEUGNQTmaVEk/OBiT2vJN7QxNLAxMzM
        0NzI1MBcSZxX2vZkspBAemJJanZqakFqEUwfEwenVANT1lkfKb+sva7FNyW2pjbGXpfWkWUx
        dXjdeavB8mTOiSt3/pw6cdPsd9WtdAZt/8enFD5w7XoaL76xOF5OO6BEegnzJ6uy7pdqQtKK
        XGXOFS2NfdFzswL7M+RrblRtfvupq9JJtdR1t1mMmfTaI2preM8vPVrJ0bwn89FMjx/T1zOv
        6uyvctth5PrjwKqD5hWLG++9q1c4s7DB8mKfZrh2I/sNPpdm9dqAl3tWzz6hxGXXv3yHuKCz
        c5b5mvKT38TnvZh3cPJX0chrahuF5LvFtTs+7Qjyj9D7OUM7m/XVQ6f5Pf3Nct79Vhm6H5KX
        ST0TUjW0Y47cuOCOz+o9n/LLakofT7NgSlocU/NYRImlOCPRUIu5qDgRALTqTws0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvG7hNZ0Ug4ZWdYvphxUtpk+9wGhx
        ftYpFos9e0+yWNxb85/VYt/rvcwWLzqPM1l0bHjDaPH7xxw2i43337E5cHn8O7GGzWPzCi2P
        xXteMnls+jSJ3WPyjeWMHn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXR/6mHqeC5QEXP7Ha2
        BsbbvF2MnBwSAiYSh9qfs3QxcnEICexglNi46T4TREJK4v3pNnYIW1jifssRVoiiDiaJ1tVH
        WUASbALaEn+unGcDsUUExCWOTT3JCFLEDFK09fJ0sISwgI9E38nnYJNYBFQlji5ZBraBV8BG
        4s+UVqgN8hIzL30HszmBTrr1/BAziC0kYCzxu2EOI0S9oMTJmU/AFjMD1Tdvnc08gVFgFpLU
        LCSpBYxMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxguNAS2sH455VH/QOMTJxMB5i
        lOBgVhLhVe3SShHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomD
        U6qBqZVVvXe/F1/MRUaOVf6L27oMws1CAp3e+P2Tnrv29Lv9Z64XbtQ84nJi4cs65jifqhsi
        H9WeasyZdGDRSbs6s/vXE8U/TWNdoT0zq0xl7RK2XerPqoJ7fC4yHZhbsKPg8d8Z0gmaIc/N
        KoJ+8Ty6XBYpkPvA9qzc37sTcl7svKa6qE26XbM5NCzp/POJQQtX6M2tuXL/vdWH/N+yzte7
        Yr44TX/81arJWefUdMPJVp4GNmXN9w2jFYze7bZmaVaeUxvDu9fKdsLLko33JxjlFb6onbOn
        Zcv9tyvE37gulrjm/fjaHt6kiUtkL51NmMbc8kRedZqlUs/SS+eWPlUJu5SxdvXTs2suPYjq
        aj1Y8kWJpTgj0VCLuag4EQDEW3RE8gIAAA==
X-CMS-MailID: 20230405020121epcas2p2d9d39c151b6c5ab9e568ab9e2ab826ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230405020121epcas2p2d9d39c151b6c5ab9e568ab9e2ab826ce
References: <ZCbjRsmoy1acVN0Z@casper.infradead.org>
        <CGME20230405020121epcas2p2d9d39c151b6c5ab9e568ab9e2ab826ce@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Fri, Mar 31, 2023 at 08:42:20PM +0900, Kyungsan Kim wrote:
>> Given our experiences/design and industry's viewpoints/inquiries,
>> I will prepare a few slides in the session to explain 
>>   1. Usecase - user/kernespace memory tiering for near/far placement, memory virtualization between hypervisor/baremetal OS
>>   2. Issue - movability(movable/unmovable), allocation(explicit/implicit), migration(intented/unintended)
>>   3. HW - topology(direct, switch, fabric), feature(pluggability,error-handling,etc)
>
>I think you'll find everybody else in the room understands these issues
>rather better than you do.  This is hardly the first time that we've
>talked about CXL, and CXL is not the first time that people have
>proposed disaggregated memory, nor heterogenous latency/bandwidth
>systems.  All the previous attempts have failed, and I expect this
>one to fail too.  Maybe there's something novel that means this time
>it really will work, so any slides you do should focus on that.
>
>A more profitable discussion might be:
>
>1. Should we have the page allocator return pages from CXL or should
>   CXL memory be allocated another way?
I think yes. Using CXL DRAM as System RAM interface would be the primary use case in real-world application in regards to compatibility.
So, on the System RAM interface, we think it should be managed by Linux MM subsystem. (Node - Zonelist - buddy page allocator)

>2. Should there be a way for userspace to indicate that it prefers CXL
>   memory when it calls mmap(), or should it always be at the discretion
>   of the kernel?
I think yes. Both implcit and explict ways are meaningful for users on a different purpose.
The dynamic performance variation of CXL DRAM is likely bigger than other memory types due to the topology expansion and link negotiation.
I think it strengthens the needs.


>3. Do we continue with the current ZONE_DEVICE model, or do we come up
>   with something new?
In fact, ZONE_DEVICE was the our first candidate for CXL DRAM.
But because ZONE_DEVICE is not managed by buddy, we thought it does not fit to provide System RAM interface.

