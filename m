Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A606D7241
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 04:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjDECDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 22:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDECDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:03:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B4171C
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 19:03:00 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230405020259epoutp0341e73e6eee28d49cdd564fe078fe781b~S54dHGE6C1092610926epoutp03n
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 02:02:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230405020259epoutp0341e73e6eee28d49cdd564fe078fe781b~S54dHGE6C1092610926epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680660179;
        bh=+L9zNUQHRUB+K9cLmlZlddgvrtYGGAlEqMFdYIxM9y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOAlJz/h/lsHLcNCsJHj0nrglwEp64/efbq24VPMJiFQF8NHoMVc5TR9pGHXGy4B6
         cc1GkyHstOSq+KEMwHa0/qNSmCG29CE56jY+/UwbUGAiTWebpV0px6SbeMfLZq0bPl
         SZWHRyKyKr15Fzlkr/0webbxbfkNub/wWpUGFrZo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230405020258epcas2p41be44a281bae13ec8d06bcc09d7753c9~S54cnfA6q2531825318epcas2p4t;
        Wed,  5 Apr 2023 02:02:58 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Prnw20cmpz4x9QJ; Wed,  5 Apr
        2023 02:02:58 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.80.27926.1D6DC246; Wed,  5 Apr 2023 11:02:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230405020257epcas2p11b253f8c97a353890b96e6ae6eb515d3~S54bnlci40694506945epcas2p1F;
        Wed,  5 Apr 2023 02:02:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230405020257epsmtrp14baf866ce16eccc3f1ca58a84c6a12c3~S54bmgf8Y0322203222epsmtrp1k;
        Wed,  5 Apr 2023 02:02:57 +0000 (GMT)
X-AuditID: b6c32a46-a4bff70000006d16-1d-642cd6d1c1f5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.BA.18071.1D6DC246; Wed,  5 Apr 2023 11:02:57 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230405020257epsmtip18ba5666b48b70718d3088459fa73b2dd~S54bRjDqi1687416874epsmtip1j;
        Wed,  5 Apr 2023 02:02:57 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     gregory.price@memverge.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: RE: RE(4): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes
 for CXL
Date:   Wed,  5 Apr 2023 11:02:57 +0900
Message-Id: <20230405020257.413761-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZCcCDuotjUr7fPLN@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmqe7FazopBs92W1tMP6xoMX3qBUaL
        hqZHLBbnZ51isdiz9ySLxb01/1kt9r3ey2zxovM4k0XHhjeMFhvvv2Nz4PL4d2INm8fiPS+Z
        PDZ9msTuMfnGckaPjR//s3v0bVnF6PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IyjH7rZC+44Vax93srcwPjftIuRk0NCwETi
        1bsbTF2MXBxCAjsYJRrnLmIHSQgJfGKUWL8lHiLxjVFi1dpOoCoOsI4D59kg4nsZJVoXP2eB
        cLqYJKbPA3E4OdgEtCX+XAGp4uQQEZCTuLDvGpjNLPCPUWLPZUkQW1ggVKKv/wDYNhYBVYmZ
        h3cxgti8AjYSS/89YYY4T15i5qXvYDWcAjoS6z9sYIKoEZQ4OfMJC8RMeYnmrbOZQY6QEOjk
        kOjas4cV4lIXiQNbaiHmCEu8Or6FHcKWknjZ3wZlF0s8fv0Pyi6ROLzkNwuEbSzx7uZzsDHM
        ApoS63fpQ0xUljhyC2orn0TH4b/sEGFeiY42IYhGFYnt/5Yzwyw6vX8T1HAPib7et0yQoK2X
        +Lekm2UCo8IsJL/MQvLLLIS9CxiZVzGKpRYU56anFhsVGMFjNzk/dxMjOKlque1gnPL2g94h
        RiYOxkOMEhzMSiK8ql1aKUK8KYmVValF+fFFpTmpxYcYTYEhPZFZSjQ5H5jW80riDU0sDUzM
        zAzNjUwNzJXEeaVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MK1qE7j0ddXSydfZxK2yu+4s6BWW
        sSsx/vueS5Z134loW5+EWSZWv+9HaLHlTmbWOJ3I8DHVyPXI1vs5SuUe/m1rZj2Ven/Y1LYp
        RCjH5VcST8cj2a61zecfBwr1LbnCcWWL/oFPvN6xOc+kX95+ZS0REzTRVHx95hPBk3N+ZXFy
        ZCvzzerddvlo7Hwpg8+5cpca7PiZl8Z/eRtUtFPY5ffUIp3bqz1/Js2YzmPtHrnumUku486J
        r5Y6x51J3iSZ9KLs5ek/5lWRAn7iwd/FE0JaNawZF3yMMtyYcHWR77q83glisQ8VZjzp36U6
        eVL/LOOKZ1uTT6tIbFsQ7/5P0fx7wPu3T4xWSRz5LDO5S4mlOCPRUIu5qDgRAOeZs6MzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO7FazopBt8PSlpMP6xoMX3qBUaL
        hqZHLBbnZ51isdiz9ySLxb01/1kt9r3ey2zxovM4k0XHhjeMFhvvv2Nz4PL4d2INm8fiPS+Z
        PDZ9msTuMfnGckaPjR//s3v0bVnF6PF5k1wAexSXTUpqTmZZapG+XQJXxtEP3ewFd5wq1j5v
        ZW5g/G/axcjBISFgInHgPFsXIxeHkMBuRokLJxcxdjFyAsWlJN6fbmOHsIUl7rccYYUo6mCS
        2PJuEytIgk1AW+LPFZBuTg4RATmJC/uugU1iBinaenk6WEJYIFjixcVbTCA2i4CqxMzDu8A2
        8ArYSCz994QZYoO8xMxL38G2cQroSKz/sAGsXghowfa1H6HqBSVOznzCAmIzA9U3b53NPIFR
        YBaS1CwkqQWMTKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjQEtzB+P2VR/0DjEy
        cTAeYpTgYFYS4VXt0koR4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoR
        TJaJg1OqgYlJOcj0vv2UWvNHu21mFIrNjGVv2rFKqrFQKEMrp375t9r6tezbbKWXtf6/2qOW
        mKnD+lVDoqOIwUH1wYrKR2e+HTbe7JKvoBWkk7Wqsetgo+S8zUEr+u+mOn5cyLMmdvKdrtJn
        E7vMfCKcedL/C++fL3Eq2b1S+8h7F7W8N2wvFTcvDtKZtYBn3pfamgMGglfi3T9c21xtFdA8
        VyxL9p2ckNLTo+/VtXlU/c3+2NjwZn5LW1T2xqJ401eVAwdm52190ft0Vr/ZjdnL6oye5nHs
        6bBjvsfcWxwTtEdgmRbj7NAgzUleD3c2iE07LDLrtFnNffuUpa2dN4IKtQ/840tcoJX16KiK
        jssc2Y52JZbijERDLeai4kQAjH3RrPICAAA=
X-CMS-MailID: 20230405020257epcas2p11b253f8c97a353890b96e6ae6eb515d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230405020257epcas2p11b253f8c97a353890b96e6ae6eb515d3
References: <ZCcCDuotjUr7fPLN@memverge.com>
        <CGME20230405020257epcas2p11b253f8c97a353890b96e6ae6eb515d3@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Fri, Mar 31, 2023 at 08:34:17PM +0900, Kyungsan Kim wrote:
>> Hi Gregory Price. 
>> Thank you for joining this topic and share your viewpoint.
>> I'm sorry for late reply due to some major tasks of our team this week.
>> 
>> >On Fri, Mar 24, 2023 at 05:48:08PM +0900, Kyungsan Kim wrote:
>> >> 
>> >> Indeed, we tried the approach. It was able to allocate a kernel context from ZONE_MOVABLE using GFP_MOVABLE.
>> >> However, we think it would be a bad practice for the 2 reasons.
>> >> 1. It causes oops and system hang occasionally due to kernel page migration while swap or compaction. 
>> >> 2. Literally, the design intention of ZONE_MOVABLE is to a page movable. So, we thought allocating a kernel context from the zone hurts the intention.
>> >> 
>> >> Allocating a kernel context out of ZONE_EXMEM is unmovable.
>> >>   a kernel context -  alloc_pages(GFP_EXMEM,)
>> >
>> >What is the specific use case of this?  If the answer is flexibility in
>> >low-memory situations, why wouldn't the kernel simply change to free up
>> >ZONE_NORMAL (swapping user memory, migrating user memory, etc) and
>> >allocate as needed?
>> >
>> >I could see allocating kernel memory from local memory expanders
>> >(directly attached to local CXL port), but I can't think of a case where
>> >it would be preferable for kernel resources to live on remote memory.
>> 
>> We have thought kernelspace memory tiering cases.
>> What memory tiering we assumes is to locate a hot data in fast memory and a cold data in slow memory.
>> We think zswap, pagecache, and Meta TPP(page promotion/demotion among nodes) as the kernelspace memory tiering cases.
>>
>
>So, to clarify, when you say "kernel space memory tiering cases", do you
>mean "to support a kernel-space controlled memory tiering service" or do
>you mean "tiering of kernel memory"?

Actually, both. 
Bollowing your expression :), we imply "kernel-space controlled memory tiering service that tiers kernel memory".
For example, while zswap operation (=a kernel space memory tiering case) of vanilla kernel,
when an user page from CXL DRAM is swapped-out, zbud allocator of zswap can allocate a zswap page from DDR_DRAM(=tiering of kernel memory).
We think it is odd, because the swapped page is promoted from CXL DRAM(far memory) to DDR DRAM(near memory).

>Because if it's the former, rather than a new zone, it seems like a
>better proposal would be to extend the numa system to add additional
>"cost/feature" attributes, rather than modifying the zone of the memory
>blocks backing the node.
>
>Note that memory zones can apply to individual blocks within a node, and
>not the entire node uniformly.  So when making tiering decisions, it
>seems more expedient to investigate a node rather than a block.
>
>
>> >Since local memory expanders are static devices, there shouldn't be a
>> >great need for hotplug, which means the memory could be mapped
>> >ZONE_NORMAL without issue.
>> >
>> 
>> IMHO, we think hot-add/remove is one of the key feature of CXL due to the composability aspect.
>> Right now, CXL device and system connection is limited. 
>> But industry is preparing a CXL capable system that allows more than 10 CXL channels at backplane, pluggable with EDSFF. 
>> Not only that, along with the progress of CXL topology - from direct-attached to switch, multi-level switch, and fabric connection -
>> I think the hot-add/remove usecase would become more important.
>> 
>> 
>
>Hot add/remove is somewhat fairly represented by ZONE_MOVABLE. What's I
>think confusing many people is that creating a new zone that's intended
>to be hot-pluggable *and* usable by kernel for kernel-resources/memory
>are presently exclusive operations.
>
>The underlying question is what situation is being hit in which kernel
>memory wants to be located in ZONE_MOVABLE/ZONE_EXMEM that cannot simply
>be serviced by demoting other, movable memory to these regions.
>
>The concept being that kernel allocations are a higher-priority
>allocation than userland, and as such should have priority in DRAM.
>
>For example - there is at least one paper that examined the cost of
>placing page tables on CXL Memory Expansion (on the local CXL complex,
>not remote) and found the cost is significant.  Page tables are likely
>the single largest allocation the kernel will make to service large
>memory structures, so the answer to this problem is not necessarily to
>place that memory in CXL as well, but to use larger page sizes (which is
>less wasteful as memory usage is high and memory is abundant).
>
>I just don't understand what kernel resources would meet the following
>attributes:
>
>1) Do not have major system performance impacts in high-latency memory
>2) Are sufficiently large to warrant tiering
>and
>3) Are capable of being moved (i.e. no pinned areas, no dma areas, etc)
>

I agree the entire level of page table should be on near memory.
In general, a data need to be handled quickly prefer a near memory such as indexing.
For far memory needs, it would be a data that is less user-interactive and latency-senstive.
Basically, our approach is on memory provider stance, not on memory consumer stance. 

>> >> Allocating a user context out of ZONE_EXMEM is movable.
>> >>   a user context - mmap(,,MAP_EXMEM,) - syscall - alloc_pages(GFP_EXMEM | GFP_MOVABLE,)
>> >> This is how ZONE_EXMEM supports the two cases.
>> >> 
>
>So if MAP_EXMEM is not used, EXMEM would not be used?
>
>That seems counter intuitive.  If an allocation via mmap would be
>eligible for ZONE_MOVABLE, why wouldn't it be eligible for ZONE_EXMEM?
>
>I believe this is another reason why some folks are confused what the
>distinction between MOVABLE and EXMEM are.  They seem to ultimately
>reduce to whether the memory can be moved.

Not really. We intended EXMEM can be used both implicitly and explicitly.
Please further refer to the answer below.

>
>> >
>> >Is it intended for a user to explicitly request MAP_EXMEM for it to get
>> >used at all?  As in, if i simply mmap() without MAP_EXMEM, will it
>> >remain unutilized?
>> 
>> Our intention is to allow below 3 cases
>> 1. Explicit DDR allocation - mmap(,,MAP_NORMAL,)
>>  : allocation from ZONE_NORMAL or ZONE_MOVABLE, or allocation fails.
>> 2. Explicit CXL allocation - mmap(,,MAP_EXMEM,)
>>  : allocation from ZONE_EXMEM, of allocation fails.
>> 3. Implicit Memory allocation - mmap(,,,) 
>>  : allocation from ZONE_NORMAL, ZONE_MOVABLE, or ZONE_EXMEM. In other words, no matter where DDR or CXL DRAM.
>> 
>> Among that, 3 is similar with vanilla kernel operation in that the allocation request traverses among multiple zones or nodes.
>> We think it would be good or bad for the mmap caller point of view.
>> It is good because memory is allocated, while it could be bad because the caller does not have idea of allocated memory type.
>> The later would hurt QoS metrics or userspace memory tiering operation, which expects near/far memory.
>> 
>
>For what it's worth, mmap is not the correct api for userland to provide
>kernel hints on data placement.  That would be madvise and friends.

Yes, our key intention is to provide a hint to userland.
Not only mmap(), but mbind(), set_mempolicy(), madvise(), etc

>
>But further, allocation of memory from userland must be ok with having
>its memory moved/swapped/whatever unless additional assistance from the
>kernel is provided (page pinning, mlock, whatever) to ensure it will
>not be moved.  Presumably this is done to ensure the kernel can make
>runtime adjustments to protect itself from being denied memory and
>causing instability and/or full system faults.

Yes. in case of the implicit allocation, our proposal is fully compatible with vanilla linux MM.
Our thought is to provide both explcit and implicit ways.

>
>
>I think you need to clarify your intents for this zone, in particular
>your intent for exactly what data can and cannot live in this zone and
>the reasons for this.  "To assist kernel tiering operations" is very
>vague and not a description of what memory is and is not allowed in the
>zone.

We don't confine a data for ZONE_EXMEM. 
Our intention is to allow both movable and ummovable allocation from a kernel and user context.
Also, an allocation context is able to determine the movability.
In other words, the ZONE_EXMEM is not inteded to confine a usecase, but provide ways to do a usecase on CXL DRAM.

>
>~Gregory
