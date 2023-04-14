Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D076E1E81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDNIli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 04:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDNIlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:41:32 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9C1BC5
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 01:41:23 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230414084122epoutp020e1716df3a154269ea2c26075e5595b4~VwH3Pr8zu3025130251epoutp02E
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 08:41:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230414084122epoutp020e1716df3a154269ea2c26075e5595b4~VwH3Pr8zu3025130251epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681461682;
        bh=2WiLjVJB2lYMJ4GVOV43m9tkB8a+wJa/F+s4trIZaiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+Z5FVP0zVQOZa4qFqhqH+ON5CVJRb+DrLMD+arFtrFwD4AUBrnxx9WXgrH2LOJBZ
         FdLkMUMk0tbU+7hq6R9Ko/VECWmHPPo7TGFJWDFO8GJQ7pJi1KA+qHr0wfZ44/Ce94
         PRt8Vy8rSgoJ4kRuarNYQsGMHyGYjqFfz3S7YZZU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230414084121epcas2p34d71f44b49b7e0637a2275d56c7df9b2~VwH2jQn9Z3175431754epcas2p3D;
        Fri, 14 Apr 2023 08:41:21 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PyVKY1XXcz4x9Pt; Fri, 14 Apr
        2023 08:41:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.16.09961.1B119346; Fri, 14 Apr 2023 17:41:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230414084120epcas2p37f105901350410772a3115a5a490c215~VwH1dqMEq3175431754epcas2p3C;
        Fri, 14 Apr 2023 08:41:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230414084120epsmtrp1adef2571095dcb80dac26126a061bacc~VwH1bd1nV2509225092epsmtrp1e;
        Fri, 14 Apr 2023 08:41:20 +0000 (GMT)
X-AuditID: b6c32a45-e13fa700000026e9-8c-643911b15ee8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.5F.08279.0B119346; Fri, 14 Apr 2023 17:41:20 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230414084120epsmtip2013e99767d5eb96a0166b755a9ef3222~VwH1NLuH52743227432epsmtip2x;
        Fri, 14 Apr 2023 08:41:20 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     ks0204.kim@samsung.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com, hj96.nam@samsung.com
Subject: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Fri, 14 Apr 2023 17:41:20 +0900
Message-Id: <20230414084120.440801-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221014114.64888-1-ks0204.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmme5GQcsUg4XnWC2mH1a0mD71AqPF
        hzf/WCyO7uGwOD/rFIvFnr0nWSzurfnParHv9V5mixedx5ksOja8YbTYeP8dmwO3x78Ta9g8
        Fu95yeSx6dMkdo/JN5YzevRtWcXo8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
        gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB1SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
        lJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjI8zbrAUPDGpeHzyIXsD4xqdLkZODgkBE4l7
        81vZuxi5OIQEdjBKrJn/mxHC+cQo8X3JDTYI5xujxOWFWxlhWr7eXMYEkdjLKLFu4VdmCKeL
        SeLUqpnMIFVsAtoSf66cZwOxRQSkJKa1r2EBKWIWmMYksWjrWbCEsICDxOaud2BjWQRUJY5P
        vgvUzMHBK2AjsfCHJ8Q2eYmZl76zg9icQOF9O9eAlfMKCEqcnPmEBcRmBqpp3job7AgJgYkc
        Eit2LWGCaHaR+Nu1HOpsYYlXx7ewQ9hSEi/726DsYonHr/9B2SUSh5f8ZoGwjSXe3XzOCnIP
        s4CmxPpd+iCmhICyxJFbUGv5JDoO/2WHCPNKdLQJQTSqSGz/t5wZZtHp/ZugSjwknj/NhIRU
        P6PEv11vmScwKsxC8swsJM/MQti7gJF5FaNYakFxbnpqsVGBITyCk/NzNzGCE6uW6w7GyW8/
        6B1iZOJgPMQowcGsJML7w8U0RYg3JbGyKrUoP76oNCe1+BCjKTCkJzJLiSbnA1N7Xkm8oYml
        gYmZmaG5kamBuZI4r7TtyWQhgfTEktTs1NSC1CKYPiYOTqkGpjzJTPaXD762TPvY2X2yqveL
        wUPmB7Oudr/qit4gVafa8kk8cZHi4v/hh2/pfr/4stHrGr+PiFfVg017zb7UKBV7iAdOWJup
        oeXjLlPa9zjVeXKYrWKgguJLffXF81/nPbY50KN6boe8S8PmL75tBpvipCeVbjEN/D7bZ8/s
        N8kOmXuPvzu1893TDVtnGJ9a/v9s9+kdj1g1d87Z0/MzaMuc7Sssspiu+ArdOre1oPj/1glV
        /HfEJp9Z/efD1bRfltecX366t+Zo3bf5jrP9TxzV+bzeaM3VU7p5d7X+qXGyPWe9cuGlSJSW
        /Gb1+BvRZXuP5vLo2HAyBmtrpsrlv2ViK/Nl1Hz2u2xP2dKHIWZKLMUZiYZazEXFiQDip9SS
        NQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSvO4GQcsUg427JS2mH1a0mD71AqPF
        hzf/WCyO7uGwOD/rFIvFnr0nWSzurfnParHv9V5mixedx5ksOja8YbTYeP8dmwO3x78Ta9g8
        Fu95yeSx6dMkdo/JN5YzevRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGxxk3WAqemFQ8PvmQ
        vYFxjU4XIyeHhICJxNeby5i6GLk4hAR2M0r83NzCBJGQknh/uo0dwhaWuN9yhBWiqINJ4vOD
        ucwgCTYBbYk/V86zgdgiQA3T2tewgBQxCyxgktg4Yw1YkbCAg8TmrneMIDaLgKrE8cl3geIc
        HLwCNhILf3hCLJCXmHnpO9gyTqDwvp1rwMqFBKwl/k78AjaGV0BQ4uTMJywgNjNQffPW2cwT
        GAVmIUnNQpJawMi0ilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOAq0NHcwbl/1Qe8Q
        IxMH4yFGCQ5mJRHeHy6mKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1I
        LYLJMnFwSjUwmUd9XC26pc7piMGvth+zJ9i+Nt46fxGv2cejliJzg2/EXb/jwPZkg2nYLduZ
        Tz9y6YdNvh9fkubd5DxHI/Do6l/Kk0py/85qPZ2tq6dTG7vpwP0NNiz1Rh9Ofb5+qjjtqFrp
        xJ7pNR0ftFNF7xQ8EGLnXHR/xhnVig7TY6d8S9liOcM4L/3M/V/J8H6FhYnaVF3FD1K7Av0n
        zIzb5sA7ZZP2kUKFyllPjleHHS5OCPM7vHvl4y0nzMXn9dT/KbftWOMttofl5IzLRXX2xbbS
        miHr3ilGWu+6cPK/9u07tzbXXVV5cOL3lMDEDa9qTy2qMv988s7Lzwr9jzgussybsrIzXO6K
        7M9FXb7OWefv+iuxFGckGmoxFxUnAgA8cYdF8QIAAA==
X-CMS-MailID: 20230414084120epcas2p37f105901350410772a3115a5a490c215
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230414084120epcas2p37f105901350410772a3115a5a490c215
References: <20230221014114.64888-1-ks0204.kim@samsung.com>
        <CGME20230414084120epcas2p37f105901350410772a3115a5a490c215@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>CXL is a promising technology that leads to fundamental changes in computing architecture.
>To facilitate adoption and widespread of CXL memory, we are developing a memory tiering solution, called SMDK[1][2].
>Using SMDK and CXL RAM device, our team has been working with industry and academic partners over last year.
>Also, thanks to many researcher's effort, CXL adoption stage is gradually moving forward from basic enablement to real-world composite usecases.
>At this moment, based on the researches and experiences gained working on SMDK, we would like to suggest a session at LSF/MM/BFP this year
>to propose possible Linux MM changes with a brief of SMDK.
>
>Adam Manzanares kindly adviced me that it is preferred to discuss implementation details on given problem and consensus at LSF/MM/BFP.
>Considering the adoption stage of CXL technology, however, let me suggest a design level discussion on the two MM expansions of SMDK this year.
>When we have design consensus with participants, we want to continue follow-up discussions with additional implementation details, hopefully.
>
> 
>1. A new zone, ZONE_EXMEM
>We added ZONE_EXMEM to manage CXL RAM device(s), separated from ZONE_NORMAL for usual DRAM due to the three reasons below.
>
>1) a CXL RAM has many different characteristics with conventional DRAM because a CXL device inherits and expands PCIe specification.
>ex) frequency range, pluggability, link speed/width negotiation, host/device flow control, power throttling, channel-interleaving methodology, error handling, and etc.
>It is likely that the primary usecase of CXL RAM would be System RAM.
>However, to deal with the hardware differences properly, different MM algorithms are needed accordingly.
>
>2) Historically, zone has been expanded by reflecting the evolution of CPU, IO, and memory devices.
>ex) ZONE_DMA(32), ZONE_HIGHMEM, ZONE_DEVICE, and ZONE_MOVABLE.
>Each zone applies different MM algorithms such as page reclaim, compaction, migration, and fragmentation.
>At first, we tried reuse of existing zones, ZONE_DEVICE and ZONE_MOVABLE, for CXL RAM purpose.
>However, the purpose and implementation of the zones are not fit for CXL RAM.
>
>3) Industry is preparing a CXL-capable system that connects dozens of CXL devices in a server system.
>When a CXL device becomes a separate node, an administrator/programmer needs to be aware of and manually control all nodes using 3rd party software, such as numactl and libnuma.
>ZONE_EXMEM allows the assemble of CXL RAM devices into the single ZONE_EXMEM zone, and provides an abstraction to userspace by seamlessly managing the devices.
>Also, the zone is able to interleave assembled devices in a software way to lead to aggregated bandwidth.
>We would like to suggest if it is co-existable with HW interleaving like SW/HW raid0.
>To help understanding, please refer to the node partition part of the picture[3].
>
>
>2. User/Kernelspace Programmable Interface
>In terms of a memory tiering solution, it is typical that the solution attempts to locate hot data on near memory, and cold data on far memory as accurately as possible.[4][5][6][7]
>We noticed that the hot/coldness of data is determined by the memory access pattern of running application and/or kernel context.
>Hence, a running context needs a near/far memory identifier to determine near/far memory. 
>When CXL RAM(s) is manipulated as a NUMA node, a node id can be function as a CXL identifier more or less.
>However, the node id has limitation in that it is an ephemeral information that dynamically varies according to online status of CXL topology and system socket.
>In this sense, we provides programmable interfaces for userspace and kernelspace context to explicitly (de)allocate memory from DRAM and CXL RAM regardless of a system change.
>Specifically, MAP_EXMEM and GFP_EXMEM flags were added to mmap() syscall and kmalloc() siblings, respectively.
>
>Thanks to Adam Manzanares for reviewing this CFP thoroughly.
>
>
>[1]SMDK: https://github.com/openMPDK/SMDK
>[2]SMT: Software-defined Memory Tiering for Heterogeneous Computing systems with CXL Memory Expander, https://ieeexplore.ieee.org/document/10032695
>[3]SMDK node partition: https://github.com/OpenMPDK/SMDK/wiki/2.-SMDK-Architecture#memory-partition
>[4]TMO: Transparent Memory Offloading in Datacenters, https://dl.acm.org/doi/10.1145/3503222.3507731
>[5]TPP: Transparent Page Placement for CXL-Enabled Tiered Memory, https://arxiv.org/abs/2206.02878
>[6]Pond: CXL-Based Memory Pooling Systems for Cloud Platforms, https://dl.acm.org/doi/10.1145/3575693.3578835
>[7]Hierarchical NUMA: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4656/original/Hierarchical_NUMA_Design_Plumbers_2017.pdf

Let us restate the original CFP as requirement point of view and the thought on that.

1) CXL DRAM pluggability
Issue: a random unmovable allocation makes a CXL DRAM unpluggable. 
It can happen out of userspace e.g.) pinning for DMA buffer, or kernelspace e.g.) pinning for metadata such as struct page, zone, etc.
For this matter, we should separate logical memory on/offline and physical add/remove.
Thought: a CXL DRAM should be able to be used in a selective manner, pluggable or unpluggable.
But, please don't get this wrong. Those are mutual-exclusive, so it cannot happen at the same time on a single CXL DRAM channel.

2) CXL DRAM identifier (API and ABI)
Issue: an user/kernel context has to use the node id of a CXL memory-node to access CXL DRAM explicitly and implicitly.
Thought: Node id would be ephemeral information. An userspace and kernelspace memory tiering solution need a API and/or ABI rather than node id.

3) Prevention of unintended CXL page migration
Issue: while zswap operation, a page on near memory(DIMM DRAM) is allocated to store swapped page on far memory(CXL DRAM).
Our thought: On the swap flow, the far memory should not be promoted to near memory accidentally. 

4) Too many CXL nodes appearing in userland
Issue: many CXL memory nodes would be appeared to userland along with development of a CXL capable server, switch and fabric topology.
Currently, to lead to aggregated bandwidth among the CXL nodes, an userland needs to be aware and manage the nodes using a 3rd party SW such as numactl and libnuma.
Thought: Kernel would provide an abstraction layer for userland to deal with it seamlessly.
By the way, traditionally a node implies multiple memory channels in the same distance, and a node is the largest management unit in MM. i.e.) Node - Zone - Page.
So, we thought that multiple CXL DRAMs can be appeared as a node, so the management dimension for single CXL DRAM should be smaller than node. 

