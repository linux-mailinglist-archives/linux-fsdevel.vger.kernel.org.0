Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D816D724B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 04:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjDECJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 22:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDECJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:09:27 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6294224
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 19:09:20 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230405020918epoutp02795a32c6140d0852f494b2b5eb5f4b00~S59_rbEKn1604416044epoutp02O
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 02:09:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230405020918epoutp02795a32c6140d0852f494b2b5eb5f4b00~S59_rbEKn1604416044epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680660558;
        bh=62lr6fHerbCsH4KsNTWzIhJm5iXBX/NtBiCLYeGuN3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFu0vJoskf8PUu0IbayuL0ymrMOqroB4wX+J5oFMflGuJGDzKFJUB3GYGatJj/hgb
         B8FM2AU+1q0tR5+sHpCljdbA0hxxvAkNhKdeUIBhvAXxjEogoY91Y8fKgc5o+jfJOi
         TWVJz3pKXS0Z5naQhUyY9PA6WU4cA5Fc0ZSgAVQc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230405020917epcas2p4d0c5877db3bf21015930f6d67b52d736~S5992Ne792889228892epcas2p4o;
        Wed,  5 Apr 2023 02:09:17 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Prp3K1yppz4x9QN; Wed,  5 Apr
        2023 02:09:17 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.62.61927.D48DC246; Wed,  5 Apr 2023 11:09:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230405020916epcas2p24cf04f5354c12632eba50b64b217e403~S598fBaVf1189611896epcas2p2u;
        Wed,  5 Apr 2023 02:09:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230405020916epsmtrp17d1adca4cec149afe52da6c2999d29b7~S598d7S1F0650206502epsmtrp1k;
        Wed,  5 Apr 2023 02:09:16 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-c4-642cd84d63a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.07.31821.C48DC246; Wed,  5 Apr 2023 11:09:16 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230405020916epsmtip2c72f40eb5d89f397e2a072275bd91a1c~S598QDqwg1984819848epsmtip2W;
        Wed,  5 Apr 2023 02:09:16 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     david@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Wed,  5 Apr 2023 11:09:16 +0900
Message-Id: <20230405020916.414045-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <25451d4f-978e-8106-3ee6-e9b382bb87a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmma7vDZ0Ug+bPbBbTDytaTJ96gdHi
        6/pfzBbnZ51isdiz9ySLxb01/1kt9r3ey2zxovM4k0XHhjeMFhvvv2Nz4PL4d2INm8fiPS+Z
        PDZ9msTuMfnGckaP9/uusnn0bVnF6PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IxJE+cyF+yxrPhx4xR7A+ML/S5GTg4JAROJ
        9k0HmbsYuTiEBHYwSnxrecME4XxilDj74i8jhPOZUWLvpeksMC2H/nexQyR2MUqcn/eDGSQh
        JNDFJDGllw/EZhPQlvhz5TwbiC0iICLx4+FLRhCbWeAfo8Sey5JdjBwcwgIeEmuncICEWQRU
        Ja79OM0EYvMK2Eh8fHeNCWKXvMTMS9/ZQWxOATuJaxdOskDUCEqcnPmEBWKkusThK3OgxstL
        NG+dDfaOhMBcDolrryYzQgxykXgxrY0NwhaWeHV8CzuELSXxsr8Nyi6WePz6H5RdInF4yW+o
        h40l3t18zgpys4SAssSRW1B7+SQ6Dv9lhwjzSnS0CUFUq0hs/7ecGWb66f2boCZ6SEzdNA0a
        bBMZJba+vMI6gVFhFpJ3ZiF5ZxaSdxYwMq9iFEstKM5NTy02KjCEx3Byfu4mRnBy1XLdwTj5
        7Qe9Q4xMHIyHGCU4mJVEeFW7tFKEeFMSK6tSi/Lji0pzUosPMZoCQ3sis5Rocj4wveeVxBua
        WBqYmJkZmhuZGpgrifNK255MFhJITyxJzU5NLUgtgulj4uCUamDSPWNaOSHvsbRrjf/TfY3e
        zEzni1cWFPUUrHf7waIZbJO0kCs+3cxJY80mwV19djpBzCcXijMcNZ1Y9LB3nw3Lxi+WT3+n
        qeurarL01R67ulWsdemkFavkGYpMT/6w0I5etrByQpeOlWz7hvZ3u55ZblpzdsHhCfXG62xV
        FrV/0C16vWPiwub0uVOaAs6GLWzL1SxcZNwz5/G0c1EKhbxPVyUpTjPdGTD74f7j/+WMLU8/
        2ZNR9W3bqRDj/K0LlBP/vAvgDd31ToxF30XnYPaB5jtH731Srrv26t70O3Hs5xc7dh5UmH14
        soZzwpvNHkefJv9bVyx0q0hVyXDOtuKuhbJsQmcNb+tfyZn/zilOiaU4I9FQi7moOBEA4z8n
        STcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvK7PDZ0Ug1enhCymH1a0mD71AqPF
        1/W/mC3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8fmwOXx78QaNo/Fe14y
        eWz6NIndY/KN5Ywe7/ddZfPo27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujEkT5zIX7LGs+HHj
        FHsD4wv9LkZODgkBE4lD/7vYuxi5OIQEdjBKbGw5xgyRkJJ4f7qNHcIWlrjfcoQVoqiDSeJI
        8zQ2kASbgLbEnyvnwWwRARGJHw9fMoIUMYMUbb08HSjBwSEs4CGxdgoHSA2LgKrEtR+nmUBs
        XgEbiY/vrjFBLJCXmHnpO9gyTgE7iWsXTrKA2EICthJXpi1lhqgXlDg58wlYnBlozuN9J9kg
        bHmJ5q2zmScwCs5CUjYLSdksJGULGJlXMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIE
        x42W1g7GPas+6B1iZOJgPMQowcGsJMKr2qWVIsSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVAPTBXbl8ktZp8qCJ4o7ed7dlHUp8WbcBbdVy2PFq4Tu7j9Y
        fS9hsunhpif8hp489lMntXv9PirxXDLn0V6Wp9eX7kuM4s8+/5z99a8+Vm4lmUtPf2l+ve95
        3+A9+/EFR27nnU246cf77O/ZvU5bBUQqdG1jVZx+NPFP/RLPJrzo6uWzvpX7tK6XXFwtdN7Y
        spzT88ANniNbV11eqHN6e2SdgsQl/umXNzrwhf17d/NMyaf9B9dXh2UFevt9clZOtmsz1Nbg
        39Rw4+EsEW5X5sLjK0LkRFqf/2ovf6tbMH89f9DXJXV/XxhsTvctvpGirNBQmS7/fducpxt+
        Rl9cqSvL2nDKhunntIv/Qy6oPfSzU2Ipzkg01GIuKk4EAIdndnIKAwAA
X-CMS-MailID: 20230405020916epcas2p24cf04f5354c12632eba50b64b217e403
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230405020916epcas2p24cf04f5354c12632eba50b64b217e403
References: <25451d4f-978e-8106-3ee6-e9b382bb87a3@redhat.com>
        <CGME20230405020916epcas2p24cf04f5354c12632eba50b64b217e403@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On 31.03.23 13:42, Kyungsan Kim wrote:
>>> On 24.03.23 14:08, Jørgen Hansen wrote:
>>>>
>>>>> On 24 Mar 2023, at 10.50, Kyungsan Kim <ks0204.kim@samsung.com> wrote:
>>>>>
>>>>>> On 24.03.23 10:27, Kyungsan Kim wrote:
>>>>>>>> On 24.03.23 10:09, Kyungsan Kim wrote:
>>>>>>>>> Thank you David Hinderbrand for your interest on this topic.
>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Kyungsan Kim wrote:
>>>>>>>>>>>> [..]
>>>>>>>>>>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>>>>>>>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>>>>>>>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>>>>>>>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>>>>>>>>>>
>>>>>>>>>>>>> We also don't think a new zone is needed for every single memory
>>>>>>>>>>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>>>>>>>>>>> manage multiple volatile memory devices due to the increased device
>>>>>>>>>>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>>>>>>>>>>> represent extended volatile memories that have different HW
>>>>>>>>>>>>> characteristics.
>>>>>>>>>>>>
>>>>>>>>>>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>>>>>>>>>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>>>>>>>>>>> volatile memories that have different HW characteristics". It needs to
>>>>>>>>>>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>>>>>>>>>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>>>>>>>>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>>>>>>>>>> new ZONE is absolutely required now to enable use case FOO, or address
>>>>>>>>>>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>>>>>>>>>> maintainability concern of "fewer degress of freedom in the ZONE
>>>>>>>>>>>> dimension" starts to dominate.
>>>>>>>>>>>
>>>>>>>>>>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>>>>>>>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>>>>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>>>>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>>>>>>
>>>>>>>>>> That sounds like a bad hack :) .
>>>>>>>>> I consent you.
>>>>>>>>>
>>>>>>>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>>>>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>>>>>>
>>>>>>>>>> I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>>>>>>>>>> similar to what you have in mind here. In general, adding new zones is
>>>>>>>>>> frowned upon.
>>>>>>>>>
>>>>>>>>> Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
>>>>>>>>> 1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
>>>>>>>>> 2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.
>>>>>>>>>
>>>>>>>>> We think ZONE_EXMEM also helps less fragmentation.
>>>>>>>>> Because it is a separated zone and handles a page allocation as movable by default.
>>>>>>>>
>>>>>>>> So how is it different that it would justify a different (more confusing
>>>>>>>> IMHO) name? :) Of course, names don't matter that much, but I'd be
>>>>>>>> interested in which other aspect that zone would be "special".
>>>>>>>
>>>>>>> FYI for the first time I named it as ZONE_CXLMEM, but we thought it would be needed to cover other extended memory types as well.
>>>>>>> So I changed it as ZONE_EXMEM.
>>>>>>> We also would like to point out a "special" zone aspeact, which is different from ZONE_NORMAL for tranditional DDR DRAM.
>>>>>>> Of course, a symbol naming is important more or less to represent it very nicely, though.
>>>>>>> Do you prefer ZONE_SPECIAL? :)
>>>>>>
>>>>>> I called it ZONE_PREFER_MOVABLE. If you studied that approach there must
>>>>>> be a good reason to name it differently?
>>>>>>
>>>>>
>>>>> The intention of ZONE_EXMEM is a separated logical management dimension originated from the HW diffrences of extended memory devices.
>>>>> Althought the ZONE_EXMEM considers the movable and frementation aspect, it is not all what ZONE_EXMEM considers.
>>>>> So it is named as it.
>>>>
>>>> Given that CXL memory devices can potentially cover a wide range of technologies with quite different latency and bandwidth metrics, will one zone serve as the management vehicle that you seek? If a system contains both CXL attached DRAM and, let say, a byte-addressable CXL SSD - both used as (different) byte addressable tiers in a tiered memory hierarchy, allocating memory from the ZONE_EXMEM doesn’t really tell you much about what you get. So the client would still need an orthogonal method to characterize the desired performance characteristics. This method could be combined with a fabric independent zone such as ZONE_PREFER_MOVABLE to address the kernel allocation issue. At the same time, this new zone could also be useful in other cases, such as virtio-mem.
>>>
>>> Yes. I still did not get a satisfying answer to my original question:
>>> what would be the differences between both zones from a MM point of
>>> view? We can discuss that in the session, of course.
>>>
>>> Regarding performance differences, I thought the idea was to go with
>>> different nodes to express (and model) such.
>>>
>> 
>>  From a MM point of view on the movability aspect, a kernel context is not allocated from ZONE_EXMEM without using GFP_EXMEM explicitly.
>> In contrast, if we understand the design of ZONE_PREFER_MOVABLE correctly, a kernel context can be allocated from ZONE_PREFER_MOVABLE implicitly as the fallback of ZONE_NORMAL allocation.
>> However, the movable attribute is not all we are concerning.
>> In addition, we experienced page allocation and migration issue on the heterogeneous memories.
>> 
>> Given our experiences/design and industry's viewpoints/inquiries,
>> I will prepare a few slides in the session to explain
>>    1. Usecase - user/kernespace memory tiering for near/far placement, memory virtualization between hypervisor/baremetal OS
>>    2. Issue - movability(movable/unmovable), allocation(explicit/implicit), migration(intented/unintended)
>>    3. HW - topology(direct, switch, fabric), feature(pluggability,error-handling,etc)
>
>Yes, especially a motivation for GFP_EXMEM and ZONE_EXMEM would be 
>great. New GFP flags and zone are very likely a lot of upstream 
>pushback. So we need a clear motivation and discussion of alternatives 
>(and why this memory has to be treated so special but still wants to be 
>managed by the buddy).
>
>Willy raises some very good points.
>

Please find the slide in preparation[1].
To help clarity, we included SW blocks and interaction of the proposal.

[1] https://github.com/OpenMPDK/SMDK/wiki/93.-%5BLSF-MM-BPF-TOPIC%5D-SMDK-inspired-MM-changes-for-CXL

>-- 
>Thanks,
>
>David / dhildenb
