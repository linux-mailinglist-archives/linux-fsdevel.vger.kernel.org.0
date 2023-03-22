Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9222E6C4199
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 05:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCVEeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 00:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCVEeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:34:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7026593
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 21:33:59 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230322043356epoutp0381dd470d7b7b802d0735afef2edc9ce2~Oo6QjpY6g0414204142epoutp03B
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 04:33:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230322043356epoutp0381dd470d7b7b802d0735afef2edc9ce2~Oo6QjpY6g0414204142epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679459636;
        bh=TK+ucOb/DuXKqFnnM7Os9Dwm20NkLiW5TPfl2ftf9No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cers1Qo+aMx2yUlwRmbJFJ0klDgAkx5IeLPtUpsS0PYQPYFmpfJCFu9uOm54lFTgM
         hlDbgx59l1TPJqfPymVPYCdalCOSkIJwhUP6CCkYk/fi8BtpI/JNsNyrjjUI1KN+Z3
         iJtc5dySDK6s1dexJh1Fv8J8fu2l0OVGiqj0wo2c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230322043355epcas2p11ce5cea00b56d26a6e7b8bce038b6f36~Oo6QCmjdg2596825968epcas2p1T;
        Wed, 22 Mar 2023 04:33:55 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PhFwg1jpfz4x9Q5; Wed, 22 Mar
        2023 04:33:55 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.9B.31307.2358A146; Wed, 22 Mar 2023 13:33:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230322043354epcas2p2227bcad190a470d635b92f92587dc69e~Oo6OVFXEY0512905129epcas2p22;
        Wed, 22 Mar 2023 04:33:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230322043354epsmtrp1ab90b9a2f329c757ffba2028f7ce03e2~Oo6OUdHeY0299002990epsmtrp1N;
        Wed, 22 Mar 2023 04:33:54 +0000 (GMT)
X-AuditID: b6c32a46-cee5fa8000007a4b-5e-641a8532d0e1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.8E.18071.1358A146; Wed, 22 Mar 2023 13:33:53 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230322043353epsmtip2ef1f0b7dce9c9cd9b0a819dfa5ee1aa2~Oo6OJH2Q02606026060epsmtip2j;
        Wed, 22 Mar 2023 04:33:53 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     ying.huang@intel.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com
Subject: RE: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Wed, 22 Mar 2023 13:33:53 +0900
Message-Id: <20230322043353.143487-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87y1oe74g5.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmha5Rq1SKwYS7/BbTDytaTJ96gdHi
        /KxTLBZ79p5ksbi35j+rxb7Xe5ktOja8YbQ4OWsyiwOHx78Ta9g8Fu95yeSx6dMkdo/JN5Yz
        evRtWcXo8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL28
        1BIrQwMDI1OgwoTsjH/vLzMX3DCq+HlmLnsD43XNLkZODgkBE4kz8z+wdjFycQgJ7GCUaF91
        lhnC+cQosa95NyOE841RYvXK02wwLXMO3YJK7GWUeH3lLRuE08Uk0Xx7ElgVm4C2xJ8r58Fs
        EQEJifU7esE6mAXOM0pse/GbvYuRg0NYwEXi1+V4kBoWAVWJT0unM4LYvAI2EhO/HoLaJi8x
        89J3dhCbU8BO4mTvDFaIGkGJkzOfsIDYzEA1zVtnM0PU/2WX2NWZDWG7SLz+cI8RwhaWeHV8
        CzuELSXxsr8Nyi6WePz6H5RdInF4yW8WCNtY4t3N56wgZzILaEqs36UPYkoIKEscuQW1lU+i
        4/Bfdogwr0RHmxBEo4rE9n/LmWEWnd6/CWq4h8SbtbfZISE1kVHizoVtrBMYFWYheWYWkmdm
        ISxewMi8ilEstaA4Nz212KjACB7Byfm5mxjByVPLbQfjlLcf9A4xMnEwHmKU4GBWEuF1Y5ZI
        EeJNSaysSi3Kjy8qzUktPsRoCgzqicxSosn5wPSdVxJvaGJpYGJmZmhuZGpgriTOK217MllI
        ID2xJDU7NbUgtQimj4mDU6qBacWMn0EtLuaHlMue3z76oi7kzLZH7ZtaNoe5fZ3jf/x2vLxW
        kcwE+e/qwm7Hrkp5G5VEFSabmvn8yvvno1ToZ/jpZ173mfDew8yrWlSj/OKfc3zz5ZR+Vm/w
        t8HsWdTj9rAV4TvNjt4/k79/U1wU445TceFb8r7oXmG6Y8Em5aiunBY0maGWbeadJ2+D0n9O
        Nl+6p1F457cT78SOXljs5RtydeJrobbWm0sWt4T2/tzLNS/l7QeTSS8+XpIwfWi7gWHnAp/K
        ZF7maL2yrUpzqk4o1T6Z9PPTPM2bH86sX65v++D+f611jM6/Z874r3xGuM/pwczjt61da0z2
        LLvgsv/vqtbLjzKqhDbPLFOV1FJiKc5INNRiLipOBACZ9vAYJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvK5hq1SKwaTJlhbTDytaTJ96gdHi
        /KxTLBZ79p5ksbi35j+rxb7Xe5ktOja8YbQ4OWsyiwOHx78Ta9g8Fu95yeSx6dMkdo/JN5Yz
        evRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGv/eXmQtuGFX8PDOXvYHxumYXIyeHhICJxJxD
        txi7GLk4hAR2M0oc/PiTBSIhJfH+dBs7hC0scb/lCCtEUQeTxOtny8GK2AS0Jf5cOc8GYosI
        SEis39ELNolZ4CqjxMcXK5m7GDk4hAVcJH5djgepYRFQlfi0dDojiM0rYCMx8eshNogF8hIz
        L30HW8YpYCdxsncGK4gtJGArMXfedah6QYmTM5+A7WUGqm/eOpt5AqPALCSpWUhSCxiZVjFK
        phYU56bnFhsWGOallusVJ+YWl+al6yXn525iBAe6luYOxu2rPugdYmTiYDzEKMHBrCTC68Ys
        kSLEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD00T7pfOm
        SL1a3Hv+4ep7CdcMskursqaqLnAQlW98EXZFrO/L/+i2mGLbRcKLprxbZh/zZsqsqmONJ9+c
        4a25/8Lm1JdXh953xJhG3o6QeRKuy8go8iLp97rfB6I0VMvYzxZZfi3yNtQQn79yZ6Rudlfk
        zRKn8grpacf0wuZd+ee4KHyTboTS5UrN17KF77e/T+++JV7ZoPIx6dep5MB4M59tkw/W3gm5
        9u9wmrLp7M/ax0UWc9fM4dd3WvinqHtBrfyNSy8qg1xjsu9cO3lhZmv41g/VKh/XsXi925O/
        fcZrrTtt5Z89d/60aVP2TfguWCPw74PaLK+u89/O7BOLvGj/ji/v2f6r2x2Px+cfrlNiKc5I
        NNRiLipOBABEez9j4wIAAA==
X-CMS-MailID: 20230322043354epcas2p2227bcad190a470d635b92f92587dc69e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230322043354epcas2p2227bcad190a470d635b92f92587dc69e
References: <87y1oe74g5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CGME20230322043354epcas2p2227bcad190a470d635b92f92587dc69e@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Huang Ying,

I apologize late reply for personal schedule.
Thank you for sharing your viewpoint and the information.


>Hi, Kyungsan,
>
>Kyungsan Kim <ks0204.kim@samsung.com> writes:
>
>> CXL is a promising technology that leads to fundamental changes in computing architecture.
>> To facilitate adoption and widespread of CXL memory, we are developing a memory tiering solution, called SMDK[1][2].
>> Using SMDK and CXL RAM device, our team has been working with industry and academic partners over last year.
>> Also, thanks to many researcher's effort, CXL adoption stage is gradually moving forward from basic enablement to real-world composite usecases.
>> At this moment, based on the researches and experiences gained working on SMDK, we would like to suggest a session at LSF/MM/BFP this year
>> to propose possible Linux MM changes with a brief of SMDK.
>>
>> Adam Manzanares kindly adviced me that it is preferred to discuss implementation details on given problem and consensus at LSF/MM/BFP.
>> Considering the adoption stage of CXL technology, however, let me suggest a design level discussion on the two MM expansions of SMDK this year.
>> When we have design consensus with participants, we want to continue follow-up discussions with additional implementation details, hopefully.
>>
>> 
>> 1. A new zone, ZONE_EXMEM
>> We added ZONE_EXMEM to manage CXL RAM device(s), separated from ZONE_NORMAL for usual DRAM due to the three reasons below.
>>
>> 1) a CXL RAM has many different characteristics with conventional DRAM because a CXL device inherits and expands PCIe specification.
>> ex) frequency range, pluggability, link speed/width negotiation, host/device flow control, power throttling, channel-interleaving methodology, error handling, and etc.
>> It is likely that the primary usecase of CXL RAM would be System RAM.
>> However, to deal with the hardware differences properly, different MM algorithms are needed accordingly.
>>
>> 2) Historically, zone has been expanded by reflecting the evolution of CPU, IO, and memory devices.
>> ex) ZONE_DMA(32), ZONE_HIGHMEM, ZONE_DEVICE, and ZONE_MOVABLE.
>> Each zone applies different MM algorithms such as page reclaim, compaction, migration, and fragmentation.
>> At first, we tried reuse of existing zones, ZONE_DEVICE and ZONE_MOVABLE, for CXL RAM purpose.
>> However, the purpose and implementation of the zones are not fit for CXL RAM.
>>
>> 3) Industry is preparing a CXL-capable system that connects dozens of CXL devices in a server system.
>> When a CXL device becomes a separate node, an administrator/programmer needs to be aware of and manually control all nodes using 3rd party software, such as numactl and libnuma.
>> ZONE_EXMEM allows the assemble of CXL RAM devices into the single ZONE_EXMEM zone, and provides an abstraction to userspace by seamlessly managing the devices.
>> Also, the zone is able to interleave assembled devices in a software way to lead to aggregated bandwidth.
>> We would like to suggest if it is co-existable with HW interleaving like SW/HW raid0.
>> To help understanding, please refer to the node partition part of the picture[3].
>
>In addition to CXL memory, we may have other kind of memory in the
>system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>memory in GPU card, etc.  I guess that we need to consider them
>together.  Do we need to add one zone type for each kind of memory?

We also don't think a new zone is needed for every single memory device.
Our viewpoint is the sole ZONE_NORMAL becomes not enough to manage multiple volatile memory devices due to the increased device types.
Including CXL DRAM, we think the ZONE_EXMEM can be used to represent extended volatile memories that have different HW characteristics.
 
>
>>
>> 2. User/Kernelspace Programmable Interface
>> In terms of a memory tiering solution, it is typical that the solution attempts to locate hot data on near memory, and cold data on far memory as accurately as possible.[4][5][6][7]
>> We noticed that the hot/coldness of data is determined by the memory access pattern of running application and/or kernel context.
>> Hence, a running context needs a near/far memory identifier to determine near/far memory.
>> When CXL RAM(s) is manipulated as a NUMA node, a node id can be function as a CXL identifier more or less.
>> However, the node id has limitation in that it is an ephemeral information that dynamically varies according to online status of CXL topology and system socket.
>> In this sense, we provides programmable interfaces for userspace and kernelspace context to explicitly (de)allocate memory from DRAM and CXL RAM regardless of a system change.
>> Specifically, MAP_EXMEM and GFP_EXMEM flags were added to mmap() syscall and kmalloc() siblings, respectively.
>
>In addition to NUMA node, we have defined the following interfaces to
>expose information about different kind of memory in the system.
>
>https://www.kernel.org/doc/html/latest/admin-guide/abi-testing.html#abi-sys-devices-virtual-memory-tiering
>
>Best Regards,
>Huang, Ying

The sysfs looks useful to prioritize a group of fast/slow memory-node using a list of node id.
We would say it is collaborative with the programmable interfaces we suggested.

                  User/Kernel context (MAP_EXMEM/GFP_EXMEM)
                                   |
               ---------------------------------------------
               |                                                    |
[sysfs/memory_tier0 - DDR Node list]   [sysfs/memory_tier1 - CXL Node list]

>
>> Thanks to Adam Manzanares for reviewing this CFP thoroughly.
>>
>>
>> [1]SMDK: https://github.com/openMPDK/SMDK
>> [2]SMT: Software-defined Memory Tiering for Heterogeneous Computing systems with CXL Memory Expander, https://ieeexplore.ieee.org/document/10032695
>> [3]SMDK node partition: https://github.com/OpenMPDK/SMDK/wiki/2.-SMDK-Architecture#memory-partition
>> [4]TMO: Transparent Memory Offloading in Datacenters, https://dl.acm.org/doi/10.1145/3503222.3507731
>> [5]TPP: Transparent Page Placement for CXL-Enabled Tiered Memory, https://arxiv.org/abs/2206.02878
>> [6]Pond: CXL-Based Memory Pooling Systems for Cloud Platforms, https://dl.acm.org/doi/10.1145/3575693.3578835
>> [7]Hierarchical NUMA: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4656/original/Hierarchical_NUMA_Design_Plumbers_2017.pdf
