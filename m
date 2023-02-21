Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2369D814
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 02:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjBUBl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 20:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjBUBlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:41:25 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2335C22008
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 17:41:19 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230221014116epoutp04398dd79546cf648dce97478ee01e908a~Fs2OGIP5R3276732767epoutp04j
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 01:41:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230221014116epoutp04398dd79546cf648dce97478ee01e908a~Fs2OGIP5R3276732767epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676943676;
        bh=WEUybv9VWfF96kQxDc8qrTU6bMD4lvn/2S8D+4YxiQI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WccSlifx2SuOHKTClB6CVHRYhtMKrRc5RZEM4GlrMpPVsQTjcFGIsBVrb1V6/Y9dh
         DngHYW5YJBsHimgXynJiAkyh96uklEDDDgHIpsv1vTadsxieiGBshPXmRCO9CQqiT9
         npRGRpMywocaWAGq6dbnIfCYKkekgo88TCsVn1l0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230221014116epcas2p40f6da9d19d902fb89020a7088b79294c~Fs2N0zIUA1922519225epcas2p4H;
        Tue, 21 Feb 2023 01:41:16 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PLMSq35DTz4x9QG; Tue, 21 Feb
        2023 01:41:15 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.4F.61927.B3124F36; Tue, 21 Feb 2023 10:41:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230221014114epcas2p1687db1d75765a8f9ed0b3495eab1154d~Fs2M1KaCc1783017830epcas2p1E;
        Tue, 21 Feb 2023 01:41:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230221014114epsmtrp2862f1fb4f6d4ba6ff25f634289578ae7~Fs2M0ZriV1365513655epsmtrp2f;
        Tue, 21 Feb 2023 01:41:14 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-44-63f4213b104c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.D0.17995.A3124F36; Tue, 21 Feb 2023 10:41:14 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230221014114epsmtip2e349dbd81c9e2391a63e7ac21b148977~Fs2MmhEb80990509905epsmtip2I;
        Tue, 21 Feb 2023 01:41:14 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com
Subject: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Tue, 21 Feb 2023 10:41:14 +0900
Message-Id: <20230221014114.64888-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmha614pdkgy0X+SymH1a0OD/rFIvF
        nr0nWSzurfnParHv9V5mi44Nbxgd2Dz+nVjD5rHp0yR2j8k3ljN69G1ZxejxeZNcAGtUtk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM52sm
        sRb8Vak4u2cRUwPjRvkuRk4OCQETiQl7FrJ3MXJxCAnsYJRo2zCXDcL5xCixpGUBlPOZUeLb
        7AOMMC1NE68zQiR2MUq8nX6QBcLpYpLoON7JClLFJqAt8efKeTYQW0RAVeLv+iNgRcwCExgl
        5na2sYAkhAVsJJ59agCzWYCK2t6vZQKxeQWsJWb97GGDWCcvMfPSd3aIuKDEyZlPwOqZgeLN
        W2czgwyVEDjGLrHi6wJ2iAYXibWtz6CahSVeHd8CFZeS+PxuL1S8WOLx639Q8RKJw0t+s0DY
        xhLvbj4H+oADaIGmxPpd+iCmhICyxJFbUGv5JDoO/2WHCPNKdLQJQTSqSGz/t5wZZtHp/Zug
        hntIHNl5BGypkECsRN+lfuYJjPKzkDwzC8kzsxD2LmBkXsUollpQnJueWmxUYAiP1eT83E2M
        4ESo5bqDcfLbD3qHGJk4GA8xSnAwK4nw/uf9nCzEm5JYWZValB9fVJqTWnyI0RQYvBOZpUST
        84GpOK8k3tDE0sDEzMzQ3MjUwFxJnFfa9mSykEB6YklqdmpqQWoRTB8TB6dUA9PcRY3MX19e
        KqgrbVY683zpC9bc33XuX8U2vOO23l3U+dyv6ORxCfFW79RXBrJyh3qFt60vdPjZkbfxwCSH
        dOnA6Xf1Dn1KyTLn4Nxx2ejc92WXvOu/be++O7Mx/JFxrs7jB9qOD48I2zw5a79v9cf3b+qO
        bK2QLDLLLe65GJH6IFY2S9sz0odNaI5cZ8p8j9LEY6nlByZYr3zLKOUrtuHv1aPOF00LPXYv
        flnSWr5F7UHjgoUsBiqfxV87vfhqcPjcoRi9s1djAjNmnVYouXF/0qX2mXcm2ey+OOdHvs6q
        YyUFgVlOvhuNll2IbDvaZLLfqjiw03mCvtwnhqXJFZzufPNnZWq/4n+nvsEkYpcSS3FGoqEW
        c1FxIgDj0q+pDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvK6V4pdkgymX9S2mH1a0OD/rFIvF
        nr0nWSzurfnParHv9V5mi44Nbxgd2Dz+nVjD5rHp0yR2j8k3ljN69G1ZxejxeZNcAGsUl01K
        ak5mWWqRvl0CV8bzNZNYC/6qVJzds4ipgXGjfBcjJ4eEgIlE08TrjF2MXBxCAjsYJXa2LWGC
        SEhJvD/dxg5hC0vcbznCClHUwSTx5McWNpAEm4C2xJ8r58FsEQFVib/rj7CAFDELTGGU2L78
        ENgkYQEbiWefGlhAbBagorb3a8HivALWErN+9rBBbJCXmHnpOztEXFDi5MwnYPXMQPHmrbOZ
        JzDyzUKSmoUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnBwamntYNyz6oPe
        IUYmDsZDjBIczEoivP95PycL8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1
        ILUIJsvEwSnVwNTN/2K32bZHD5817Zu74M+rnZ/D/LInPOhRZtvmIZxqLW4fdm/K/M8b5R/m
        XKn3ZWp+9Flr/YVEQXnBTYo+3huOsir/+L1F8vTF0OWiC75bp51qLp6+xnKtVLD01Z8CdlVb
        ag78f99c9TT+w7kPps2cHE8F8n32B7/YLtqxbLuL0oRWY7XLjzKPzmt+fS3gx1ad4jPMLC3X
        NmafSY65sNfopWLxSs8goag2u2jjJtvTL4uM/0/UOvGlcWLkt5MOjw5ZG659d7VAaveVMrHS
        fL9vD0ObhEvNSzLtkgo4PJL0T+uu93EzyaqL2XJiFSPHwr0ltl5HInzY4t5bzLx2yK7C8F+7
        5cw9lRs/7/zhxa7EUpyRaKjFXFScCADV6dS+vQIAAA==
X-CMS-MailID: 20230221014114epcas2p1687db1d75765a8f9ed0b3495eab1154d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230221014114epcas2p1687db1d75765a8f9ed0b3495eab1154d
References: <CGME20230221014114epcas2p1687db1d75765a8f9ed0b3495eab1154d@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CXL is a promising technology that leads to fundamental changes in computing architecture.
To facilitate adoption and widespread of CXL memory, we are developing a memory tiering solution, called SMDK[1][2].
Using SMDK and CXL RAM device, our team has been working with industry and academic partners over last year.
Also, thanks to many researcher's effort, CXL adoption stage is gradually moving forward from basic enablement to real-world composite usecases.
At this moment, based on the researches and experiences gained working on SMDK, we would like to suggest a session at LSF/MM/BFP this year
to propose possible Linux MM changes with a brief of SMDK.

Adam Manzanares kindly adviced me that it is preferred to discuss implementation details on given problem and consensus at LSF/MM/BFP.
Considering the adoption stage of CXL technology, however, let me suggest a design level discussion on the two MM expansions of SMDK this year.
When we have design consensus with participants, we want to continue follow-up discussions with additional implementation details, hopefully.

 
1. A new zone, ZONE_EXMEM
We added ZONE_EXMEM to manage CXL RAM device(s), separated from ZONE_NORMAL for usual DRAM due to the three reasons below.

1) a CXL RAM has many different characteristics with conventional DRAM because a CXL device inherits and expands PCIe specification.
ex) frequency range, pluggability, link speed/width negotiation, host/device flow control, power throttling, channel-interleaving methodology, error handling, and etc.
It is likely that the primary usecase of CXL RAM would be System RAM.
However, to deal with the hardware differences properly, different MM algorithms are needed accordingly.

2) Historically, zone has been expanded by reflecting the evolution of CPU, IO, and memory devices.
ex) ZONE_DMA(32), ZONE_HIGHMEM, ZONE_DEVICE, and ZONE_MOVABLE.
Each zone applies different MM algorithms such as page reclaim, compaction, migration, and fragmentation.
At first, we tried reuse of existing zones, ZONE_DEVICE and ZONE_MOVABLE, for CXL RAM purpose.
However, the purpose and implementation of the zones are not fit for CXL RAM.

3) Industry is preparing a CXL-capable system that connects dozens of CXL devices in a server system.
When a CXL device becomes a separate node, an administrator/programmer needs to be aware of and manually control all nodes using 3rd party software, such as numactl and libnuma.
ZONE_EXMEM allows the assemble of CXL RAM devices into the single ZONE_EXMEM zone, and provides an abstraction to userspace by seamlessly managing the devices.
Also, the zone is able to interleave assembled devices in a software way to lead to aggregated bandwidth.
We would like to suggest if it is co-existable with HW interleaving like SW/HW raid0.
To help understanding, please refer to the node partition part of the picture[3].


2. User/Kernelspace Programmable Interface
In terms of a memory tiering solution, it is typical that the solution attempts to locate hot data on near memory, and cold data on far memory as accurately as possible.[4][5][6][7]
We noticed that the hot/coldness of data is determined by the memory access pattern of running application and/or kernel context.
Hence, a running context needs a near/far memory identifier to determine near/far memory. 
When CXL RAM(s) is manipulated as a NUMA node, a node id can be function as a CXL identifier more or less.
However, the node id has limitation in that it is an ephemeral information that dynamically varies according to online status of CXL topology and system socket.
In this sense, we provides programmable interfaces for userspace and kernelspace context to explicitly (de)allocate memory from DRAM and CXL RAM regardless of a system change.
Specifically, MAP_EXMEM and GFP_EXMEM flags were added to mmap() syscall and kmalloc() siblings, respectively.

Thanks to Adam Manzanares for reviewing this CFP thoroughly.


[1]SMDK: https://github.com/openMPDK/SMDK
[2]SMT: Software-defined Memory Tiering for Heterogeneous Computing systems with CXL Memory Expander, https://ieeexplore.ieee.org/document/10032695
[3]SMDK node partition: https://github.com/OpenMPDK/SMDK/wiki/2.-SMDK-Architecture#memory-partition
[4]TMO: Transparent Memory Offloading in Datacenters, https://dl.acm.org/doi/10.1145/3503222.3507731
[5]TPP: Transparent Page Placement for CXL-Enabled Tiered Memory, https://arxiv.org/abs/2206.02878
[6]Pond: CXL-Based Memory Pooling Systems for Cloud Platforms, https://dl.acm.org/doi/10.1145/3575693.3578835
[7]Hierarchical NUMA: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4656/original/Hierarchical_NUMA_Design_Plumbers_2017.pdf
