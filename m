Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9369A6D7243
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 04:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjDECGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 22:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDECGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:06:37 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244EE1736
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 19:06:35 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230405020633epoutp024e5584360198aeb70c26f952634fbf7d~S57kjtUhJ1592215922epoutp02C
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 02:06:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230405020633epoutp024e5584360198aeb70c26f952634fbf7d~S57kjtUhJ1592215922epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680660393;
        bh=9//bNHds0tR+6x5UH+b1jbtEscRLA5GCyNFoB0Qsfpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVzvYZQ/gHkdhy9eZiWmqSBXbv2URWrqexy4VQ/zxjHNMUfoNYQ/6zsfw4VGZKpd7
         ZHzBOUX5rbJhe0UwFwxuqf2xpcQw9e6RtEfQ/WqUZ92TVsnwDXz9QY2+BGkH7NO29A
         HEHxgX1aRms5gLoJlv5+7g3OCL6Bpf5Z9BYyGqfM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230405020632epcas2p47c19f5f60c85293d4546d7512e1b209c~S57j9hJwV0727507275epcas2p4T;
        Wed,  5 Apr 2023 02:06:32 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Prp080n0Gz4x9Q2; Wed,  5 Apr
        2023 02:06:32 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.63.27926.7A7DC246; Wed,  5 Apr 2023 11:06:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230405020631epcas2p1c85058b28a70bbd46d587e78a9c9c7ad~S57i-8N8h2971329713epcas2p1D;
        Wed,  5 Apr 2023 02:06:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230405020631epsmtrp24285df8097640912067830af1337de9e~S57i-MvJh1337813378epsmtrp2l;
        Wed,  5 Apr 2023 02:06:31 +0000 (GMT)
X-AuditID: b6c32a46-ca9fa70000006d16-bb-642cd7a79f00
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.C6.31821.7A7DC246; Wed,  5 Apr 2023 11:06:31 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230405020631epsmtip24b52791599aba8254bed2a317afbf790~S57iy3BEX2106721067epsmtip2k;
        Wed,  5 Apr 2023 02:06:31 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     fvdl@google.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: RE: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Wed,  5 Apr 2023 11:06:31 +0900
Message-Id: <20230405020631.413965-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPTztWYGdkcdq+yO4aG2C8YYZ0SokxhHQxQK7JmRxXLAuwV00Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmhe6K6zopBk8+M1lMP6xoMX3qBUaL
        IwsWsFmcn3WKxWLP3pMsFvfW/Ge12Pd6L7PFi87jTBYdG94wWmy8/47Ngcvj34k1bB4LNpV6
        LN7zkslj06dJ7B6Tbyxn9OjbsorR4/MmuQD2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGS+/CBScEq04seU1WwPjFcEuRk4OCQETiQ+d
        Cxm7GLk4hAR2MEpse7mOHcL5xCjxZNcWVgjnM6PElslP2GFa7u55B9Wyi1Fi999FLBBOF5PE
        gmW3mECq2AS0Jf5cOc8GYosICEvM+/0OrJtZ4B+jxJ7LkiC2sICPRN/J52BxFgFViSlnV7GA
        2LwCNhIzDr5hhtgmLzHz0newGk6BQIm5N9sZIWoEJU7OfMICMVNd4vCVOYwQtrxE89bZUL0z
        OSSWT3CAsF0kNk24yAphC0u8Or4F6hspic/v9rJB2MUSj1//g4qXSBxe8psFwjaWeHfzOVAv
        B5CtLHHkFtRaPomOw3/ZIcK8Eh1tQhDVKhLb/y1nhpl+ev8mqIkeEis29kIDdAmjRNfBTywT
        GBVmIflmFpJvZiH5ZgEj8ypGsdSC4tz01GKjAiN4DCfn525iBKdWLbcdjFPeftA7xMjEwXiI
        UYKDWUmEV7VLK0WINyWxsiq1KD++qDQntfgQoykwsCcyS4km5wOTe15JvKGJpYGJmZmhuZGp
        gbmSOK+07clkIYH0xJLU7NTUgtQimD4mDk6pBqaO9Dk7hZ/0u12+8E5qTdY2sS8WsaqLWKTe
        BZ85/fX7uQMnVSTuhP0yXyV3JEC5Z7OnqD+Hlsb/L6ezvlkLL1geKj/z3B1+A2e7rUcPaxnw
        WpodXWLxfHfLsUk/r7W/fR3o5NHNMqngCaPlseR7XX17Jc7wxE5SEk2u85fl3f3/s5RwodKU
        5KDrtnn/q9im2/NW++vqzppzq2ezKkNs/ukTr83EzioHCtie+GXwI+Nu7hP3z0eUNPkMPk7l
        1pt3yuiw+oePpz5rmJgdCtv852qvYP3Uy8+FarivnT08Mae6oUBd0uvUI4vm5TlODyWOetw3
        /aNrtKNSPugTs4nF3F2K1w/E7eOabKT+3HuOqb4SS3FGoqEWc1FxIgClbNQxNgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvO7y6zopBmfXKlhMP6xoMX3qBUaL
        IwsWsFmcn3WKxWLP3pMsFvfW/Ge12Pd6L7PFi87jTBYdG94wWmy8/47Ngcvj34k1bB4LNpV6
        LN7zkslj06dJ7B6Tbyxn9OjbsorR4/MmuQD2KC6blNSczLLUIn27BK6Ml18ECk6JVpzY8pqt
        gfGKYBcjJ4eEgInE3T3vGLsYuTiEBHYwSqzbv5QNIiEl8f50GzuELSxxv+UIK0RRB5PE669X
        mUESbALaEn+unAdrEAEqmvf7HTtIETNI0dbL08ESwgI+En0nn4NNYhFQlZhydhULiM0rYCMx
        4+AbZogN8hIzL30Hq+EUCJSYe7Md6CQOoG0BEt33QiDKBSVOznwC1soMNObxvpNsELa8RPPW
        2cwTGAVnISmbhaRsFpKyBYzMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgmNGS2sH
        455VH/QOMTJxMB5ilOBgVhLhVe3SShHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpi
        SWp2ampBahFMlomDU6qBqTB9yTJLU9crm7OWtkSbK5z7x306P6EvxJXtUO/OBA+2JrX0X3a5
        E7SnOM1yKrvy4OWJ0yuvmk7btu5lmUJxfNny1h3HLsRcqmXprBDeM025d+ITMbG8zClXTE99
        ejqpYMPELad+ZcUWz7Le57FxCeeDAsmfcazXjh7VWhhwUKXn5tQbGysWTdu/8NnXC8rTdGcZ
        rTZeoruD3dWox/dFunGG5Zz3D60fCBndUZC0jX4sHmjLmpDOt0lkb+2c8nSu51du7X6/zfLu
        Equqd2Uex17NFYp1OvfOJORX96PgQ5OuxU2e8HqyfYnxgodTfhSsDft843hA6y3xdJnjm9z6
        r7H/zvy9o+1KhvxDvxV27AuUWIozEg21mIuKEwFl0V8pCAMAAA==
X-CMS-MailID: 20230405020631epcas2p1c85058b28a70bbd46d587e78a9c9c7ad
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230405020631epcas2p1c85058b28a70bbd46d587e78a9c9c7ad
References: <CAPTztWYGdkcdq+yO4aG2C8YYZ0SokxhHQxQK7JmRxXLAuwV00Q@mail.gmail.com>
        <CGME20230405020631epcas2p1c85058b28a70bbd46d587e78a9c9c7ad@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Frank, 
Thank you for your interest on this topic and remaining your opinion.

>On Fri, Mar 31, 2023 at 6:42 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Fri, Mar 31, 2023 at 08:42:20PM +0900, Kyungsan Kim wrote:
>> > Given our experiences/design and industry's viewpoints/inquiries,
>> > I will prepare a few slides in the session to explain
>> >   1. Usecase - user/kernespace memory tiering for near/far placement, memory virtualization between hypervisor/baremetal OS
>> >   2. Issue - movability(movable/unmovable), allocation(explicit/implicit), migration(intented/unintended)
>> >   3. HW - topology(direct, switch, fabric), feature(pluggability,error-handling,etc)
>>
>> I think you'll find everybody else in the room understands these issues
>> rather better than you do.  This is hardly the first time that we've
>> talked about CXL, and CXL is not the first time that people have
>> proposed disaggregated memory, nor heterogenous latency/bandwidth
>> systems.  All the previous attempts have failed, and I expect this
>> one to fail too.  Maybe there's something novel that means this time
>> it really will work, so any slides you do should focus on that.
>>
>> A more profitable discussion might be:
>>
>> 1. Should we have the page allocator return pages from CXL or should
>>    CXL memory be allocated another way?
>> 2. Should there be a way for userspace to indicate that it prefers CXL
>>    memory when it calls mmap(), or should it always be at the discretion
>>    of the kernel?
>> 3. Do we continue with the current ZONE_DEVICE model, or do we come up
>>    with something new?
>>
>>
>
>Point 2 is what I proposed talking about here:
>https://lore.kernel.org/linux-mm/a80a4d4b-25aa-a38a-884f-9f119c03a1da@google.com/T/
>
>With the current cxl-as-numa-node model, an application can express a
>preference through mbind(). But that also means that mempolicy and
>madvise (e.g. MADV_COLD) are starting to overlap if the intention is
>to use cxl as a second tier for colder memory.  Are these the right
>abstractions? Might it be more flexible to attach properties to memory
>ranges, and have applications hint which properties they prefer?

We also think more userspace hints would be meaningful for diverse purposes of application.
Specific intefaces are need to be discussed, though.

FYI in fact, we expanded mbind() and set_mempolicy() as well to explicitly bind DDR/CXL.
  - mbind(,,MPOL_F_ZONE_EXMEM / MPOL_F_ZONE_NOEXMEM) 
  - set_mempolicy(,,MPOL_F_ZONE_EXMEM / MPOL_F_ZONE_NOEXMEM)
madvise() is also a candidate to express tiering intention.

>
>It's an interesting discussion, and I hope it'll be touched on at
>LSF/MM, happy to participate there.
>
>- Frank
