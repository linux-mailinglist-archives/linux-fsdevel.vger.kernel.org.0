Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5276E1E7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDNIlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDNIlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:41:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5072B5FCE
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 01:41:16 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230414084112epoutp044db59931d3406274419c9bd9fd5f914a~VwHt1Qf8q2477824778epoutp043
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 08:41:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230414084112epoutp044db59931d3406274419c9bd9fd5f914a~VwHt1Qf8q2477824778epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681461672;
        bh=ZaSfFFhgvPnitgO8kcvICQmJWGRjTTy29L6yzuZfq+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYuCEfuRQhKdtHhjywIYKzU6wRmv5Ji3lXN3cqzukFJS/mOIHFBbvyLdZUcQYtwOr
         8RU0ND2AgDAJI3fuZsvg7l0yb/26V3TOdgx/N0uBiqcRCYP9HWem/QxDwOsnBqAtlY
         gzAUe9rTsG4DO29ES5/qHlDL4hLjHlu7dITcQ50Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230414084111epcas2p4e7a16d9abe7ac312c3c5037b2d950113~VwHtL9AF42025620256epcas2p4V;
        Fri, 14 Apr 2023 08:41:11 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PyVKL6X7tz4x9Q2; Fri, 14 Apr
        2023 08:41:10 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.09.09650.6A119346; Fri, 14 Apr 2023 17:41:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230414084110epcas2p20b90a8d1892110d7ca3ac16290cd4686~VwHroHDNm1045510455epcas2p26;
        Fri, 14 Apr 2023 08:41:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230414084109epsmtrp1cf5094ae7005905f7e46696262b24e90~VwHrnAEx72509225092epsmtrp1W;
        Fri, 14 Apr 2023 08:41:09 +0000 (GMT)
X-AuditID: b6c32a48-023fa700000025b2-20-643911a66165
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.5F.08279.5A119346; Fri, 14 Apr 2023 17:41:09 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230414084109epsmtip228fd6889a8ccdf7b62a4282b2a93eca1~VwHrXBILR2743227432epsmtip2s;
        Fri, 14 Apr 2023 08:41:09 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     david@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com, hj96.nam@samsung.com
Subject: RE: FW: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory
Date:   Fri, 14 Apr 2023 17:41:09 +0900
Message-Id: <20230414084109.440697-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f9432319-4df8-00c2-e6df-c0a69932e7e7@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmhe4yQcsUg1WdBhbTDytaTJ96gdHi
        6/pfzBYf3vxjsTg/6xSLxZ69J1ks7q35z2qx7/VeZosXnceZLDo2vGG02Hj/HZsDt8e/E2vY
        PBbvecnksenTJHaPyTeWM3q833eVzaNvyypGj8+b5ALYo7JtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZyy7v4Ct4KdsxemVHg2MJyS6GDk5
        JARMJM6sPM7axcjFISSwg1Gip3URC4TziVHi9cp2RgjnG6PE8nVfGWFa9q79CJXYyyjx9M8j
        dgini0ni49UXLCBVbALaEn+unGcDsUUERCR+PHwJ1sEsMI1JYtHWs2AJYQFPiZenFjF3MXJw
        sAioSkz/qQ0S5hWwkbi9aRHUNnmJmZe+s4PYnAJ2Em9ePWGEqBGUODnzCdguZqCa5q2zmUHm
        SwhM5ZB4/LSFDaLZRaJhYhOULSzx6vgWdghbSuJlfxuUXSzx+PU/KLtE4vCS3ywQtrHEu5vP
        WUFuYxbQlFi/Sx/ElBBQljhyC2otn0TH4b/sEGFeiY42IYhGFYnt/5Yzwyw6vX8TVImHxNb+
        DJCwkMBERolPkyInMCrMQvLLLCS/zEJYu4CReRWjWGpBcW56arFRgQk8epPzczcxghOslscO
        xtlvP+gdYmTiYDzEKMHBrCTC+8PFNEWINyWxsiq1KD++qDQntfgQoykwoCcyS4km5wNTfF5J
        vKGJpYGJmZmhuZGpgbmSOO/HDuUUIYH0xJLU7NTUgtQimD4mDk6pBib3d1M69sax1v/s3yhS
        rqZ5cl35ZiE24+T1d1vvMro/1VSQml2kbSx0zPkrh+Rx1c7NOgsTyt1LhFOOfv2xfFln9cvP
        HVJrvuu2iezWuRjRJ/nJ0juoRrB+gUakZLpX1Na5a26WNhwqb+RMS97VqXKKYcsmBoNpf99+
        WtN+ekfu3fk8cToXnq+dEZ00uU41T2f5AmcR5lMvzF+FW+3l+R/6SnjB7piNyU/Fph+86Nz7
        /lJyxRWOI7dzArxrZSMF2256/U90DNHi2Hc9sTBBeO5Ff/kj4vcUc6dG/PD6LrT+/wKxlUcq
        NTd5NHjvDbE9c5Wlfrngs7xbZ1Pu3mL2Fkmdpuv69e+i1c3i12YIKCmxFGckGmoxFxUnAgAO
        v1EhOQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvO5SQcsUg1MNFhbTDytaTJ96gdHi
        6/pfzBYf3vxjsTg/6xSLxZ69J1ks7q35z2qx7/VeZosXnceZLDo2vGG02Hj/HZsDt8e/E2vY
        PBbvecnksenTJHaPyTeWM3q833eVzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgylt1fwFbw
        U7bi9EqPBsYTEl2MnBwSAiYSe9d+ZOxi5OIQEtjNKPHu2QZ2iISUxPvTbVC2sMT9liOsEEUd
        TBJnLv1iAkmwCWhL/Llyng3EFhEQkfjx8CXYJGaBBUwSG2esYQZJCAt4Srw8tQjI5uBgEVCV
        mP5TGyTMK2AjcXvTIkaIBfISMy99B1vGKWAn8ebVE7C4kICtxJMDC5gh6gUlTs58wgJiMwPV
        N2+dzTyBUWAWktQsJKkFjEyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGC40FLcwfj
        9lUf9A4xMnEwHmKU4GBWEuH94WKaIsSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS
        1OzU1ILUIpgsEwenVANTg4mBSGa7dvWJvX9+hWbz7T0k23XAfc2rnzOUpLlXzezwmqz1eqmp
        WnjXaYbA4peMvz493lVhMSPO1XxNd4CrR/uMk3PO9Vlvn3tE9yqjxcoI0/8vcqcnPaoz7Rad
        9ve8fheX+vSke5uDp1Zu5e4wzL1S80ng1a5pq7/8Nv57U7xh7bWf6XmZsZPtrfV11E/KsF28
        OONTWL+osRLzEp63E9YfX+B95O9L/5MHZE0cube3Xrx0yj4kSl564rXZu8T7Dvqf+NFuvc62
        Ovo7z1XJ/Fdh+1zOdJ9guqTzalqInwnrtrwXXNaezWmCq1Ldmxl1frDpmjTlNLJlbtzgr3pE
        hls2e+6+5/6hFamnb0xTYinOSDTUYi4qTgQA+8EtrvYCAAA=
X-CMS-MailID: 20230414084110epcas2p20b90a8d1892110d7ca3ac16290cd4686
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230414084110epcas2p20b90a8d1892110d7ca3ac16290cd4686
References: <f9432319-4df8-00c2-e6df-c0a69932e7e7@redhat.com>
        <CGME20230414084110epcas2p20b90a8d1892110d7ca3ac16290cd4686@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On 12.04.23 13:10, Kyungsan Kim wrote:
>>>> Gregory Price <gregory.price@memverge.com> writes:
>>>>
>>>>> On Tue, Apr 11, 2023 at 02:37:50PM +0800, Huang, Ying wrote:
>>>>>> Gregory Price <gregory.price@memverge.com> writes:
>>>>>>
>>>>>> [snip]
>>>>>>
>>>>>>> 2. During the migration process, the memory needs to be forced not to be
>>>>>>>      migrated to another node by other means (tiering software, swap,
>>>>>>>      etc).  The obvious way of doing this would be to migrate and
>>>>>>>      temporarily pin the page... but going back to problem #1 we see that
>>>>>>>      ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
>>>>>>>      troublesome.
>>>>>>
>>>>>> Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.) to
>>>>>> avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
>>>>>> but I think it is fixable.
>>>>>>
>>>>>> Best Regards,
>>>>>> Huang, Ying
>>>>>>
>>>>>> [snip]
>>>>>
>>>>> That feels like a hack/bodge rather than a proper solution to me.
>>>>>
>>>>> Maybe this is an affirmative argument for the creation of an EXMEM
>>>>> zone.
>>>>
>>>> Let's start with requirements.  What is the requirements for a new zone
>>>> type?
>>>
>>> I'm stills scratching my head regarding this. I keep hearing all
>>> different kind of statements that just add more confusions "we want it
>>> to be hotunpluggable" "we want to allow for long-term pinning memory"
>>> "but we still want it to be movable" "we want to place some unmovable
>>> allocations on it". Huh?
>>>
>>> Just to clarify: ZONE_MOVABLE allows for pinning. It just doesn't allow
>>> for long-term pinning of memory.
>>>
>>> For good reason, because long-term pinning of memory is just the worst
>>> (memory waste, fragmentation, overcommit) and instead of finding new
>>> ways to *avoid* long-term pinnings, we're coming up with advanced
>>> concepts to work-around the fundamental property of long-term pinnings.
>>>
>>> We want all memory to be long-term pinnable and we want all memory to be
>>> movable/hotunpluggable. That's not going to work.
>> 
>> Looks there is misunderstanding about ZONE_EXMEM argument.
>> Pinning and plubbability is mutual exclusive so it can not happen at the same time.
>> What we argue is ZONE_EXMEM does not "confine movability". an allocation context can determine the movability attribute.
>> Even one unmovable allocation will make the entire CXL DRAM unpluggable.
>> When you see ZONE_EXMEM just on movable/unmoable aspect, we think it is the same with ZONE_NORMAL,
>> but ZONE_EXMEM works on an extended memory, as of now CXL DRAM.
>> 
>> Then why ZONE_EXMEM is, ZONE_EXMEM considers not only the pluggability aspect, but CXL identifier for user/kenelspace API,
>> the abstraction of multiple CXL DRAM channels, and zone unit algorithm for CXL HW characteristics.
>> The last one is potential at the moment, though.
>> 
>> As mentioned in ZONE_EXMEM thread, we are preparing slides to explain experiences and proposals.
>> It it not final version now[1].
>> [1] https://protect2.fireeye.com/v1/url?k=265f4f76-47d45a59-265ec439-74fe485cbfe7-1e8ec1d2f0c2fd0a&q=1&e=727e97be-fc78-4fa6-990b-a86c256978d1&u=https%3A%2F%2Fgithub.com%2FOpenMPDK%2FSMDK%2Fwiki%2F93.-%255BLSF-MM-BPF-TOPIC%255D-SMDK-inspired-MM-changes-for-CXL
>
>Yes, hopefully we can discuss at LSF/MM also the problems we are trying 
>to solve instead of focusing on one solution. [did not have the time to 
>look at the slides yet, sorry]

For sure.. The purpose of LSF/MM this year is weighted on sharing experiences and issues as CXL provider for last couple of years.
We don't think our solution is the only way, but propose it.
Hopefully, we gradually figure out the best way with experts here.

>
>-- 
>Thanks,
>
>David / dhildenb
