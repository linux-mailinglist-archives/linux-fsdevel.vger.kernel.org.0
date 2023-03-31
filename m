Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED56D1F19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCaLcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 07:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjCaLcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:32:15 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B11D1DF81
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 04:31:52 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230331113150epoutp0247151da433483f55456a0e9fd250573b~RfatBHx5V2131521315epoutp02j
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 11:31:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230331113150epoutp0247151da433483f55456a0e9fd250573b~RfatBHx5V2131521315epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680262310;
        bh=Oitv5yopQeA0fexutVY/k5ElDF3b1N+jbldLHWxDDa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SErZU8oMV4DteO0+F3ngwOSgoIoteORab5EoDFYcQIe5S4LcNSX9dSMFRzk3rZU7I
         oXlxUWcStboY2oiJ6vGD6MhoAD/fPCSTz5mNqpMYD1zpEw2qLOzc5WpePCoOml0z/j
         nROelnV7fsH9iw+R9bwL5SuBytsddvUkRW0u9Mbw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230331113149epcas2p1a1d7e0504a92e1610ef96b5c22961401~Rfar1w9OE2337823378epcas2p1Q;
        Fri, 31 Mar 2023 11:31:49 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Pnymh48Pqz4x9Pw; Fri, 31 Mar
        2023 11:31:48 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.4B.61927.4A4C6246; Fri, 31 Mar 2023 20:31:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230331113147epcas2p12655777fec6839f7070ffcc446e3581b~Rfaqm7BZh2804528045epcas2p1y;
        Fri, 31 Mar 2023 11:31:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230331113147epsmtrp1504753b15de5156965351f4ad565d568~Rfaql71w70592105921epsmtrp11;
        Fri, 31 Mar 2023 11:31:47 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-b7-6426c4a470fb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.45.18071.3A4C6246; Fri, 31 Mar 2023 20:31:47 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230331113147epsmtip274ef97950857f554f2bd32cc8a1511b7~RfaqZksUj0134601346epsmtip2H;
        Fri, 31 Mar 2023 11:31:47 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     Jorgen.Hansen@wdc.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: RE: RE(3): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL
Date:   Fri, 31 Mar 2023 20:31:47 +0900
Message-Id: <20230331113147.399972-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <E224146D-058D-48B3-8788-A6BC3370044F@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmue6SI2opBuc3SVtMP6xoMX3qBUaL
        vgmPmS3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8fmwOXx78QaNo/Fe14y
        eWz6NIndY/KN5YwefVtWMXp83iTn0X6gmymAPSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7U
        zMBQ19DSwlxJIS8xN9VWycUnQNctMwfoPCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJq
        QUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsb0bV+ZCy4bV1zb+I6xgXGTVhcjJ4eEgIlE
        z9b/zF2MXBxCAjsYJbY/uMoO4XxilHh9+wIThPONUeLlg62MMC1vl/xhhEjsZZRYu+oflNPF
        JNFw7AETSBWbgLbEnyvn2UBsEQFJiZUb1oDFmQX+MUrsuSwJYgsLBEq8uLOTBcRmEVCVaH5y
        lxXE5hWwkbg44TU7xDZ5iZmXvoPZnALWEk+bJkHVCEqcnPmEBWKmvETz1tlgT0gIzOSQ2NX4
        lw2i2UXi3o2DUGcLS7w6vgVqqJTEy/42KLtY4vHrf1B2icThJb9ZIGxjiXc3nwMt4wBaoCmx
        fpc+iCkhoCxx5BbUWj6JjsN/2SHCvBIdbUIQjSoS2/8tZ4ZZdHr/JqjhHhKX5z9iAykXEuhj
        lJjNOoFRYRaSX2Yh+WUWwtoFjMyrGMVSC4pz01OLjQoM4fGbnJ+7iRGcWLVcdzBOfvtB7xAj
        EwfjIUYJDmYlEd5CY9UUId6UxMqq1KL8+KLSnNTiQ4ymwJCeyCwlmpwPTO15JfGGJpYGJmZm
        huZGpgbmSuK80rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqYzvzNrqyT27hE6/6X+7wv/n/LOHNU
        P5nD8tVR4c/eQQ2br363vFr8YtOUuVV8kc3/3sQIsq5aK1N57cehDv34orLicI/9z1W+HCli
        2Oxx3KuB4dhTy06pNVrdVva884Lc3z5ri6rYcnNCc/nO+Bn81UbCxvae+57xhU336U+e6Lfr
        TYCjmNSOyOpP2zW6dCQOX3OZ9YmdU7Ou6sid41rZHw/9ljuZtPT7klsvYuQMo+3mByR8fpfh
        dmLe4g12P3/t2HRKLWzTtQRlkxmG3Kx/E1lOX9/RxbGu9pWbgPG6pohNdS8j816xuxkddeO/
        stBaer6MveZJhvLEB0cNsy+sF88QPb2wJb8o+odfTFCWEktxRqKhFnNRcSIAp4dZczUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvO7iI2opBt836llMP6xoMX3qBUaL
        vgmPmS3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8fmwOXx78QaNo/Fe14y
        eWz6NIndY/KN5YwefVtWMXp83iTn0X6gmymAPYrLJiU1J7MstUjfLoErY/q2r8wFl40rrm18
        x9jAuEmri5GTQ0LAROLtkj+MXYxcHEICuxklJq/fzwaRkJJ4f7qNHcIWlrjfcoQVxBYS6GCS
        WHreCMRmE9CW+HPlPFi9iICkxMoNa5hABjGD1Gy9PB0owcEhLOAvcbUHrJ5FQFWi+cldsDm8
        AjYSFye8hpovLzHz0ncwm1PAWuJp0ySoXVYSx0+cZYaoF5Q4OfMJC8hIZgF1ifXzhEDCzECt
        zVtnM09gFJyFpGoWQtUsJFULGJlXMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER4yW
        5g7G7as+6B1iZOJgPMQowcGsJMJbaKyaIsSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB
        9MSS1OzU1ILUIpgsEwenVANTC0MR64O4xvWfuHv2ThXxS2nfcJD56oP1p1VrOdynbVkfkFpc
        /u1ygGSWOGuW1YVfcqbCYudU1vtzS8212RrHK8u2Wi5ZfcL176bnMoNvOb8vv39LP6Gk8e1+
        C71fvTxB0pHPeY6dP3AlIcN625Z/C7RuRR1I7cxQOm5XlKJwdvHZugrGo7rvZHZtDesoSTrT
        eNHVeNH7nslMzGemy3ioGhjEt0QHdilPee9xs2GOzoNPgZZaPNY9bAIrTykUxM4tnhd/Wvej
        /pJP4X8W8txWkXkXJ9To57g2/BLHg4gDG55czEuzuDZX+WrxqbO/Uj+ebK9ZIVRk2FzLy9ZZ
        OIlz8ur53lt2f9nt7+EpekiJpTgj0VCLuag4EQCKYSbxBwMAAA==
X-CMS-MailID: 20230331113147epcas2p12655777fec6839f7070ffcc446e3581b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331113147epcas2p12655777fec6839f7070ffcc446e3581b
References: <E224146D-058D-48B3-8788-A6BC3370044F@wdc.com>
        <CGME20230331113147epcas2p12655777fec6839f7070ffcc446e3581b@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jorgen Hansen.
Thank you for joining this topic and share your thoughts.
I'm sorry for late reply due to some major tasks of our team this week.

>> On 24 Mar 2023, at 10.50, Kyungsan Kim <ks0204.kim@samsung.com> wrote:
>> 
>>> On 24.03.23 10:27, Kyungsan Kim wrote:
>>>>> On 24.03.23 10:09, Kyungsan Kim wrote:
>>>>>> Thank you David Hinderbrand for your interest on this topic.
>>>>>> 
>>>>>>>> 
>>>>>>>>> Kyungsan Kim wrote:
>>>>>>>>> [..]
>>>>>>>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>>>>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>>>>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>>>>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>>>>>>> 
>>>>>>>>>> We also don't think a new zone is needed for every single memory
>>>>>>>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>>>>>>>> manage multiple volatile memory devices due to the increased device
>>>>>>>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>>>>>>>> represent extended volatile memories that have different HW
>>>>>>>>>> characteristics.
>>>>>>>>> 
>>>>>>>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>>>>>>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>>>>>>>> volatile memories that have different HW characteristics". It needs to
>>>>>>>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>>>>>>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>>>>>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>>>>>>> new ZONE is absolutely required now to enable use case FOO, or address
>>>>>>>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>>>>>>> maintainability concern of "fewer degress of freedom in the ZONE
>>>>>>>>> dimension" starts to dominate.
>>>>>>>> 
>>>>>>>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>>>>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>>> 
>>>>>>> That sounds like a bad hack :) .
>>>>>> I consent you.
>>>>>> 
>>>>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>>> 
>>>>>>> I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>>>>>>> similar to what you have in mind here. In general, adding new zones is
>>>>>>> frowned upon.
>>>>>> 
>>>>>> Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
>>>>>> 1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
>>>>>> 2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.
>>>>>> 
>>>>>> We think ZONE_EXMEM also helps less fragmentation.
>>>>>> Because it is a separated zone and handles a page allocation as movable by default.
>>>>> 
>>>>> So how is it different that it would justify a different (more confusing
>>>>> IMHO) name? :) Of course, names don't matter that much, but I'd be
>>>>> interested in which other aspect that zone would be "special".
>>>> 
>>>> FYI for the first time I named it as ZONE_CXLMEM, but we thought it would be needed to cover other extended memory types as well.
>>>> So I changed it as ZONE_EXMEM.
>>>> We also would like to point out a "special" zone aspeact, which is different from ZONE_NORMAL for tranditional DDR DRAM.
>>>> Of course, a symbol naming is important more or less to represent it very nicely, though.
>>>> Do you prefer ZONE_SPECIAL? :)
>>> 
>>> I called it ZONE_PREFER_MOVABLE. If you studied that approach there must
>>> be a good reason to name it differently?
>>> 
>> 
>> The intention of ZONE_EXMEM is a separated logical management dimension originated from the HW diffrences of extended memory devices.
>> Althought the ZONE_EXMEM considers the movable and frementation aspect, it is not all what ZONE_EXMEM considers.
>> So it is named as it.
>
>Given that CXL memory devices can potentially cover a wide range of technologies with quite different latency and bandwidth metrics, will one zone serve as the management vehicle that you seek? If a system contains both CXL attached DRAM and, let say, a byte-addressable CXL SSD - both used as (different) byte addressable tiers in a tiered memory hierarchy, allocating memory from the ZONE_EXMEM doesn’t really tell you much about what you get. So the client would still need an orthogonal method to characterize the desired performance characteristics. 

I agree that a heterogeneous system would be able to adopt multiple types of extended memory devices.
We think ZONE_EXMEM can apply different management algorithms for each extended memory type. 
What we think is ZONE_NORMAL : ZONE_EXMEM = 1 : N, where N is the number of HW device type.
ZONE_NORMAL is for conventional DDR DRAM on DIMM F/F, while ZONE_EXMEM is for extended memories, CXL DRAM, CXL SSD, etc on other F/Fs such as EDSFF. 

We think the movable attribute is a requirement for CXL DRAM device. 
However, there are other SW points we are concerning - implicit allocation and unintended migration - with CXL HW differences.
So, I'm not sure if it is possible or good to cover the matters by combination of ZONE_MOVABLE and ZONE_PREFER_MOVABLE design.
Let me point out again, we proposed the ZONE_EXMEM for the special logical management of extended memory devices.

Specifically, for the performance metric, we think it would be handled not in the zone, but in a node unit.


>This method could be combined with a fabric independent zone such as ZONE_PREFER_MOVABLE to address the kernel allocation issue. At the same time, this new zone could also be useful in other cases, such as virtio-mem.

We agree with your thought. Along with adoption of CXL memory pool and fabric, virtualization SW layers would be added.
Considering not only baremetal OS, but memory inflation/deflation between baremetal OS and a hypervisor, we think ZONE_EXMEM can be useful as the identifier for CXL memory.


>
>Thanks,
>Jorgen
