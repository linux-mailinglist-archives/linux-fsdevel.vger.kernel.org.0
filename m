Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83466D1F57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 13:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjCaLm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCaLm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:42:27 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FE191DC
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 04:42:24 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230331114222epoutp04b5088cddfb2dfcb8357a013d37e7fa0a~Rfj6AMqV31935119351epoutp04Z
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 11:42:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230331114222epoutp04b5088cddfb2dfcb8357a013d37e7fa0a~Rfj6AMqV31935119351epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680262942;
        bh=lTX2sWC+EJZ773its1hKDL/I2uGNCdw1deCuU9b1gww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HooBEG2RoKVt34EA/rlU92w5vEkzYDYf2FBP7VRPSGV2VFm9OqC12rWwpEY86mHf+
         XujcgvJyzWYq7o9P5rQ5XEFBOmYQeIOcS2ZUvkLRF0YJKqR0Xdfk0xw38jbDIzXWYB
         JfYKyNQTrsWJGKMNW/KBu61LjZpDLNHLUnL4/6j0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230331114221epcas2p37a0dd5e5fd426bba70c7c5ff6a1bd3a1~Rfj5FU4c20341403414epcas2p3I;
        Fri, 31 Mar 2023 11:42:21 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Pnz0s1t4wz4x9Pw; Fri, 31 Mar
        2023 11:42:21 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.AE.08750.D17C6246; Fri, 31 Mar 2023 20:42:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230331114220epcas2p2d5734efcbdd8956f861f8e7178cd5288~Rfj4JtNB30718507185epcas2p2F;
        Fri, 31 Mar 2023 11:42:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230331114220epsmtrp1acd27f4dd466a63be7ac6e83fcc15964~Rfj4I_G2u1241112411epsmtrp1D;
        Fri, 31 Mar 2023 11:42:20 +0000 (GMT)
X-AuditID: b6c32a47-777ff7000000222e-bf-6426c71da2f0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.42.31821.C17C6246; Fri, 31 Mar 2023 20:42:20 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230331114220epsmtip2c33656c89071d41e45e91240abbf47b8~Rfj38bhw50761607616epsmtip2D;
        Fri, 31 Mar 2023 11:42:20 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     david@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: RE: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Fri, 31 Mar 2023 20:42:20 +0900
Message-Id: <20230331114220.400297-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7c7933df-43da-24e3-2144-0551cde05dcd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmua7scbUUg4U9PBbTDytaTJ96gdHi
        6/pfzBbnZ51isdiz9ySLxb01/1kt9r3ey2zxovM4k0XHhjeMFhvvv2Nz4PL4d2INm8fiPS+Z
        PDZ9msTuMfnGckaP9/uusnn0bVnF6PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Ixph2exFLQZV+zctIatgXGNVhcjJ4eEgInE
        xj9PmboYuTiEBHYwSvz/vpQFwvnEKPF44nUo5zOjxMcrU9lhWpa+nsQGYgsJ7GKUOP6pFKKo
        i0li7rlnYAk2AW2JP1fOg9kiAiISPx6+ZASxmQX+MUrsuSwJYgsLeEhMnzWFGcRmEVCVWPbz
        ApjNK2AjcfLyDkaIZfISMy99B1vMKWAn8XnyfVaIGkGJkzOfsEDMlJdo3jqbGaJ+LodEy9zE
        LkYOINtFYlFPBkRYWOLV8S1Q90tJvOxvg7KLJR6//gdll0gcXvKbBcI2lnh38zkryBhmAU2J
        9bv0ISYqSxy5BbWUT6Lj8F92iDCvREebEESjisT2f8uZYRad3r8JqsRDov+OCSScJjJKnGl8
        wDKBUWEWkldmIXllFsLeBYzMqxjFUguKc9NTi40KjOGxm5yfu4kRnFS13Hcwznj7Qe8QIxMH
        4yFGCQ5mJRHeQmPVFCHelMTKqtSi/Pii0pzU4kOMpsCAnsgsJZqcD0zreSXxhiaWBiZmZobm
        RqYG5krivNK2J5OFBNITS1KzU1MLUotg+pg4OKUamJZ8iJ6jz6g1z27FXQZLr1Wzb8y8qeqf
        J3X0zaWEtVra9nt+Gnk90ArqvyJ+ZO4FgR2hAfmv9L/6t2TwBW/Z+cRfwTCZIzJAzIuHt/H5
        9p2pB1ZVO3XFs+6YL+d6/q+hyif9CX7M6zcuXxiT4rFj0nqxx1UZ3GrMSadzGxr+iPWLr0xV
        MP/hJ1h33L+4uEarsUu+Y+fsuWJnzjUe+7N2naTtUfOMqm3H7aJFJxbmsR1zNE+PLw43TLvM
        kXLvPk9c87VLJ4XFw5KLjHLDxUVMfLZ29N46NcvtNb+7qdfS25m6b1pqqpQCbsgG2nqc45yx
        8WSmiKy0yI+ra2S9/wuqs2vnvJyTFry6a1aF0j8lluKMREMt5qLiRAD+8avMMwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvK7McbUUg3+NBhbTDytaTJ96gdHi
        6/pfzBbnZ51isdiz9ySLxb01/1kt9r3ey2zxovM4k0XHhjeMFhvvv2Nz4PL4d2INm8fiPS+Z
        PDZ9msTuMfnGckaP9/uusnn0bVnF6PF5k1wAexSXTUpqTmZZapG+XQJXxrTDs1gK2owrdm5a
        w9bAuEari5GTQ0LARGLp60lsXYxcHEICOxglzq98zAqRkJJ4f7qNHcIWlrjfcgQsLiTQwSTx
        aGEKiM0moC3x58p5NhBbREBE4sfDl4wgg5hBarZeng6WEBbwkJg+awoziM0ioCqx7OcFMJtX
        wEbi5OUdjBAL5CVmXvoOtoxTwE7i8+T7QMs4gJbZSrw/wA5RLihxcuYTFpAws4C6xPp5QiBh
        ZqDO5q2zmScwCs5CUjULoWoWkqoFjMyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC
        I0ZLawfjnlUf9A4xMnEwHmKU4GBWEuEtNFZNEeJNSaysSi3Kjy8qzUktPsQozcGiJM57oetk
        vJBAemJJanZqakFqEUyWiYNTqoFpWZxc647Xi68G2z4ovB+s03mneWnQQdFNT9e/fduw/caU
        jet8I79/ZbYIdFZzXR35xmH59zsiEnHVR8XKWdRVUvVao2Zue86sMzl3ke+x191ZkbxV3ibX
        rLw9zjcoPdFuOKdqJuWwP+SAa9SyE6biN3XcBQ79WpRaGXbigvOUpzdY1VcW/9vhp7B9U9ET
        5kexWRe4Dlo1VGSKl66Yvrom7J32lfnvdiw7y2UeYrcwMd40mUvpb9T2GR3l+1WsWnbuY1t5
        jG9OQ4Rswg122bf71JySS2vX/baa8bL/h+Vsrxs71rz5wtb2fMKsd08KuFpm35rpw/XtUtA6
        +5kTEv48vSUcO0+n/kbDnvdfIpMuKbEUZyQaajEXFScCAJaB4iYHAwAA
X-CMS-MailID: 20230331114220epcas2p2d5734efcbdd8956f861f8e7178cd5288
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331114220epcas2p2d5734efcbdd8956f861f8e7178cd5288
References: <7c7933df-43da-24e3-2144-0551cde05dcd@redhat.com>
        <CGME20230331114220epcas2p2d5734efcbdd8956f861f8e7178cd5288@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On 24.03.23 14:08, Jørgen Hansen wrote:
>> 
>>> On 24 Mar 2023, at 10.50, Kyungsan Kim <ks0204.kim@samsung.com> wrote:
>>>
>>>> On 24.03.23 10:27, Kyungsan Kim wrote:
>>>>>> On 24.03.23 10:09, Kyungsan Kim wrote:
>>>>>>> Thank you David Hinderbrand for your interest on this topic.
>>>>>>>
>>>>>>>>>
>>>>>>>>>> Kyungsan Kim wrote:
>>>>>>>>>> [..]
>>>>>>>>>>>> In addition to CXL memory, we may have other kind of memory in the
>>>>>>>>>>>> system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>>>>>>>>>>> memory in GPU card, etc.  I guess that we need to consider them
>>>>>>>>>>>> together.  Do we need to add one zone type for each kind of memory?
>>>>>>>>>>>
>>>>>>>>>>> We also don't think a new zone is needed for every single memory
>>>>>>>>>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>>>>>>>>>> manage multiple volatile memory devices due to the increased device
>>>>>>>>>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>>>>>>>>>> represent extended volatile memories that have different HW
>>>>>>>>>>> characteristics.
>>>>>>>>>>
>>>>>>>>>> Some advice for the LSF/MM discussion, the rationale will need to be
>>>>>>>>>> more than "we think the ZONE_EXMEM can be used to represent extended
>>>>>>>>>> volatile memories that have different HW characteristics". It needs to
>>>>>>>>>> be along the lines of "yes, to date Linux has been able to describe DDR
>>>>>>>>>> with NUMA effects, PMEM with high write overhead, and HBM with improved
>>>>>>>>>> bandwidth not necessarily latency, all without adding a new ZONE, but a
>>>>>>>>>> new ZONE is absolutely required now to enable use case FOO, or address
>>>>>>>>>> unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>>>>>>>>> maintainability concern of "fewer degress of freedom in the ZONE
>>>>>>>>>> dimension" starts to dominate.
>>>>>>>>>
>>>>>>>>> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
>>>>>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>>>>
>>>>>>>> That sounds like a bad hack :) .
>>>>>>> I consent you.
>>>>>>>
>>>>>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>>>>
>>>>>>>> I once raised the idea of a ZONE_PREFER_MOVABLE [1], maybe that's
>>>>>>>> similar to what you have in mind here. In general, adding new zones is
>>>>>>>> frowned upon.
>>>>>>>
>>>>>>> Actually, we have already studied your idea and thought it is similar with us in 2 aspects.
>>>>>>> 1. ZONE_PREFER_MOVABLE allows a kernelspace allocation using a new zone
>>>>>>> 2. ZONE_PREFER_MOVABLE helps less fragmentation by splitting zones, and ordering allocation requests from the zones.
>>>>>>>
>>>>>>> We think ZONE_EXMEM also helps less fragmentation.
>>>>>>> Because it is a separated zone and handles a page allocation as movable by default.
>>>>>>
>>>>>> So how is it different that it would justify a different (more confusing
>>>>>> IMHO) name? :) Of course, names don't matter that much, but I'd be
>>>>>> interested in which other aspect that zone would be "special".
>>>>>
>>>>> FYI for the first time I named it as ZONE_CXLMEM, but we thought it would be needed to cover other extended memory types as well.
>>>>> So I changed it as ZONE_EXMEM.
>>>>> We also would like to point out a "special" zone aspeact, which is different from ZONE_NORMAL for tranditional DDR DRAM.
>>>>> Of course, a symbol naming is important more or less to represent it very nicely, though.
>>>>> Do you prefer ZONE_SPECIAL? :)
>>>>
>>>> I called it ZONE_PREFER_MOVABLE. If you studied that approach there must
>>>> be a good reason to name it differently?
>>>>
>>>
>>> The intention of ZONE_EXMEM is a separated logical management dimension originated from the HW diffrences of extended memory devices.
>>> Althought the ZONE_EXMEM considers the movable and frementation aspect, it is not all what ZONE_EXMEM considers.
>>> So it is named as it.
>> 
>> Given that CXL memory devices can potentially cover a wide range of technologies with quite different latency and bandwidth metrics, will one zone serve as the management vehicle that you seek? If a system contains both CXL attached DRAM and, let say, a byte-addressable CXL SSD - both used as (different) byte addressable tiers in a tiered memory hierarchy, allocating memory from the ZONE_EXMEM doesn’t really tell you much about what you get. So the client would still need an orthogonal method to characterize the desired performance characteristics. This method could be combined with a fabric independent zone such as ZONE_PREFER_MOVABLE to address the kernel allocation issue. At the same time, this new zone could also be useful in other cases, such as virtio-mem.
>
>Yes. I still did not get a satisfying answer to my original question: 
>what would be the differences between both zones from a MM point of 
>view? We can discuss that in the session, of course.
>
>Regarding performance differences, I thought the idea was to go with 
>different nodes to express (and model) such.
>

From a MM point of view on the movability aspect, a kernel context is not allocated from ZONE_EXMEM without using GFP_EXMEM explicitly.
In contrast, if we understand the design of ZONE_PREFER_MOVABLE correctly, a kernel context can be allocated from ZONE_PREFER_MOVABLE implicitly as the fallback of ZONE_NORMAL allocation.
However, the movable attribute is not all we are concerning.
In addition, we experienced page allocation and migration issue on the heterogeneous memories.

Given our experiences/design and industry's viewpoints/inquiries,
I will prepare a few slides in the session to explain 
  1. Usecase - user/kernespace memory tiering for near/far placement, memory virtualization between hypervisor/baremetal OS
  2. Issue - movability(movable/unmovable), allocation(explicit/implicit), migration(intented/unintended)
  3. HW - topology(direct, switch, fabric), feature(pluggability,error-handling,etc)


>-- 
>Thanks,
>
>David / dhildenb
