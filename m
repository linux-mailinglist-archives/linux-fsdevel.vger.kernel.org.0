Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE6D6A5259
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 05:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjB1Ef7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 23:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjB1Ef6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:35:58 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A424C92
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 20:35:55 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230228043552epoutp02ddf1c6252549adc172e05875b96ad034~H4vqt_KxN1666016660epoutp02U
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 04:35:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230228043552epoutp02ddf1c6252549adc172e05875b96ad034~H4vqt_KxN1666016660epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677558952;
        bh=qv9cPRK6mwicxtYCU4/a4VZVUqNsk0JediXpI7ocLn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7P05FodAp29zVaNDVXQNbCxhkDyx/lDNo5KGVXp0rtdGLJ/zXCcI/f6ezwNsM4rV
         zDAQNCtwr6CAjZVhTQonx+HFnfNdMxgKd2nQpkj7q9PTjP9rQjVpIgQj+FK0oJ2phF
         8NjqrI6l6bBQBLBakTLErraiSO3eA/F8wQCLEbo4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230228043552epcas2p1585a6e975c820132194c4e57d8f97a72~H4vqXVrtO0478604786epcas2p18;
        Tue, 28 Feb 2023 04:35:52 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PQl133QdVz4x9Ps; Tue, 28 Feb
        2023 04:35:51 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.D4.05668.7A48DF36; Tue, 28 Feb 2023 13:35:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230228043551epcas2p3085444899b00b106c2901e1f51814d2c~H4vpW3Jkp2377223772epcas2p3k;
        Tue, 28 Feb 2023 04:35:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230228043551epsmtrp1b07c7ee0f9c5f04d23e97493a894ebde~H4vpWDD8O2963529635epsmtrp1X;
        Tue, 28 Feb 2023 04:35:51 +0000 (GMT)
X-AuditID: b6c32a48-1f7ff70000021624-da-63fd84a7cb34
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.7F.17995.6A48DF36; Tue, 28 Feb 2023 13:35:50 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230228043550epsmtip2fa4f49e6faf58c02ec9cb8464cdbe07f~H4vpJnfEE1945119451epsmtip2c;
        Tue, 28 Feb 2023 04:35:50 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     dan.j.williams@intel.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com
Subject: RE: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Tue, 28 Feb 2023 13:35:50 +0900
Message-Id: <20230228043550.88798-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <63fd39406c2dd_276522948@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTTHd5y99kg52HJC2mH1a0mD71AqPF
        +VmnWCz27D3JYnFvzX9Wi32v9zJbdGx4w+jA7vHvxBo2j8V7XjJ5bPo0id1j8o3ljB59W1Yx
        enzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDA
        wMgUqDAhO+PD+7dsBat0K/afn83WwHhKtYuRk0NCwETi1qk3jF2MXBxCAjsYJTqntzNBOJ8Y
        Je5uPsgM4XxmlFjzu4ERpuXotU0sEIldjBLXtx1mg3C6mCS6p7xgBqliE9CW+HPlPBuILSIg
        I7Hh/3awOLPAZkaJ41elQWxhAQeJExMhalgEVCWOn1gOVsMrYC2xbf0mVoht8hIzL31nB7E5
        BTwkmvZ3QtUISpyc+YQFYqa8RPPW2WCnSgh8ZJd4+XEWVLOLxJojh6DOFpZ4dXwLO4QtJfGy
        vw3KLpZ4/PoflF0icXjJbxYI21ji3c3nQHM4gBZoSqzfpQ9iSggoSxy5BbWWT6Lj8F92iDCv
        REebEESjisT2fxCfgCw6vX8TVImHxP3WdEhIzWaU+P51MtsERoVZSJ6ZheSZWQh7FzAyr2IU
        Sy0ozk1PLTYqMIFHcHJ+7iZGcMrU8tjBOPvtB71DjEwcjIcYJTiYlUR4F97+kyzEm5JYWZVa
        lB9fVJqTWnyI0RQY1BOZpUST84FJO68k3tDE0sDEzMzQ3MjUwFxJnFfa9mSykEB6Yklqdmpq
        QWoRTB8TB6dUA1P283KtpqRq5WkpN+u/NM2p6Z370norawD/lFBW3TsyerM+nn4gHihrcER/
        kZn2Cc1J4Xoz5hezGRx93vzyS8w/oe5z2gdFLUQjLds9NvbvKu3+3Dd9YppdkxXDJ91fpXGZ
        8h6vt4fburvmzihlk5qXt03w/d+szh3PTz7qXDxN7+ruyMhb/HK7ePL3Pn8RdklmqtIOX557
        Xr42PzxrpW1WfV7xqVJNu1PsxJHYwNntnrabN67kN6hjmjlJ/G7mGUnW831/DBf53ugLa+eR
        P+YRe9H5eLXfvI3zeCUXLVMoj71oaXbJOeuD4c91TpOUUpY03/XmXpXKWBbD/fqf26Miq19y
        j/aISL3ycEyar8RSnJFoqMVcVJwIAOvRP3YiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvO6ylr/JBr/3WVhMP6xoMX3qBUaL
        87NOsVjs2XuSxeLemv+sFvte72W26NjwhtGB3ePfiTVsHov3vGTy2PRpErvH5BvLGT36tqxi
        9Pi8SS6ALYrLJiU1J7MstUjfLoEr48P7t2wFq3Qr9p+fzdbAeEq1i5GTQ0LAROLotU0sXYxc
        HEICOxgl1u05ywqRkJJ4f7qNHcIWlrjfcoQVoqiDSWLH9ItsIAk2AW2JP1fOg9kiAjISG/5v
        ZwYpYhbYySjRveo02CRhAQeJExMhilgEVCWOn1jODGLzClhLbFu/CWqbvMTMS9/BtnEKeEg0
        7e8EquEA2uYuseSyMES5oMTJmU9YQGxmoPLmrbOZJzAKzEKSmoUktYCRaRWjZGpBcW56brFh
        gVFearlecWJucWleul5yfu4mRnB4a2ntYNyz6oPeIUYmDsZDjBIczEoivAtv/0kW4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgenQzHjpV95b9/9puLnK
        Risq73+lV+i0qaafZKslvmt/3HDT9XScir3x9ebpYmb7LqcFGzruNQ7zU/h3arW64kIf6Q0r
        Hv/dKJngzH1B6YrnvZudz/KW/Uz9/Kp04oayfykTmX5oh+TeWv7lwkXfqc4TUtgVzpx2vz3n
        m8+26sOlt2f4XZskv/RY0fxb23UMDwt2bDM7Z1Uv1m9WEsm8q6FRreRMecWUNrbXKotLnoYq
        HVka43uazyOUvaIuge8TV4VYH+vfw9PmBy51l3mcIf/gV3bZi6bjx7M+i33rcpxX/lpd4tek
        PVeVvdO5TTsTdQLWKL6O239AViCau6nzvee/hnp98aq1F2O28EtMKVViKc5INNRiLipOBAB+
        a9f93gIAAA==
X-CMS-MailID: 20230228043551epcas2p3085444899b00b106c2901e1f51814d2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230228043551epcas2p3085444899b00b106c2901e1f51814d2c
References: <63fd39406c2dd_276522948@dwillia2-xfh.jf.intel.com.notmuch>
        <CGME20230228043551epcas2p3085444899b00b106c2901e1f51814d2c@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you dan for kind reminder of the submission. 
I filled out the form with topic suggestions and required attendees.
Hopefully, we can elaborate the topics with wider opinions revisiting previous kernel designs related.


>Please be sure to log this in the submission spreadsheet as well. From the
>CFP:
>
>---
>
>1) Fill out the following Google form to request attendance and
>suggest any topics
>
>        https://forms.gle/VKVXjWGBHZbnsz226
>
>In previous years we have accidentally missed people's attendance
>requests because they either didn't cc lsf-pc@ or we simply missed them
>in the flurry of emails we get.  Our community is large and our
>volunteers are busy, filling this out will help us make sure we don't
>miss anybody.
>
>
>Kyungsan Kim wrote:
>> CXL is a promising technology that leads to fundamental changes in
>> computing architecture.  To facilitate adoption and widespread of CXL
>> memory, we are developing a memory tiering solution, called
>> SMDK[1][2].  Using SMDK and CXL RAM device, our team has been working
>> with industry and academic partners over last year.  Also, thanks to
>> many researcher's effort, CXL adoption stage is gradually moving
>> forward from basic enablement to real-world composite usecases.  At
>> this moment, based on the researches and experiences gained working on
>> SMDK, we would like to suggest a session at LSF/MM/BFP this year to
>> propose possible Linux MM changes with a brief of SMDK.
>>
>> Adam Manzanares kindly adviced me that it is preferred to discuss
>> implementation details on given problem and consensus at LSF/MM/BFP.
>> Considering the adoption stage of CXL technology, however, let me
>> suggest a design level discussion on the two MM expansions of SMDK
>> this year.  When we have design consensus with participants, we want
>> to continue follow-up discussions with additional implementation
>> details, hopefully.
>>
>> 
>> 1. A new zone, ZONE_EXMEM We added ZONE_EXMEM to manage CXL RAM
>> device(s), separated from ZONE_NORMAL for usual DRAM due to the three
>> reasons below.
>>
>> 1) a CXL RAM has many different characteristics with conventional DRAM
>> because a CXL device inherits and expands PCIe specification.  ex)
>> frequency range, pluggability, link speed/width negotiation,
>> host/device flow control, power throttling, channel-interleaving
>> methodology, error handling, and etc.  It is likely that the primary
>> usecase of CXL RAM would be System RAM.  However, to deal with the
>> hardware differences properly, different MM algorithms are needed
>> accordingly.
>>
>> 2) Historically, zone has been expanded by reflecting the evolution of
>> CPU, IO, and memory devices.  ex) ZONE_DMA(32), ZONE_HIGHMEM,
>> ZONE_DEVICE, and ZONE_MOVABLE.  Each zone applies different MM
>> algorithms such as page reclaim, compaction, migration, and
>> fragmentation.  At first, we tried reuse of existing zones,
>> ZONE_DEVICE and ZONE_MOVABLE, for CXL RAM purpose.  However, the
>> purpose and implementation of the zones are not fit for CXL RAM.
>>
>> 3) Industry is preparing a CXL-capable system that connects dozens of
>> CXL devices in a server system.  When a CXL device becomes a separate
>> node, an administrator/programmer needs to be aware of and manually
>> control all nodes using 3rd party software, such as numactl and
>> libnuma.  ZONE_EXMEM allows the assemble of CXL RAM devices into the
>> single ZONE_EXMEM zone, and provides an abstraction to userspace by
>> seamlessly managing the devices.  Also, the zone is able to interleave
>> assembled devices in a software way to lead to aggregated bandwidth.
>> We would like to suggest if it is co-existable with HW interleaving
>> like SW/HW raid0.  To help understanding, please refer to the node
>> partition part of the picture[3].
>>
>>
>> 2. User/Kernelspace Programmable Interface In terms of a memory
>> tiering solution, it is typical that the solution attempts to locate
>> hot data on near memory, and cold data on far memory as accurately as
>> possible.[4][5][6][7] We noticed that the hot/coldness of data is
>> determined by the memory access pattern of running application and/or
>> kernel context.  Hence, a running context needs a near/far memory
>> identifier to determine near/far memory.  When CXL RAM(s) is
>> manipulated as a NUMA node, a node id can be function as a CXL
>> identifier more or less.  However, the node id has limitation in that
>> it is an ephemeral information that dynamically varies according to
>> online status of CXL topology and system socket.  In this sense, we
>> provides programmable interfaces for userspace and kernelspace context
>> to explicitly (de)allocate memory from DRAM and CXL RAM regardless of
>> a system change.  Specifically, MAP_EXMEM and GFP_EXMEM flags were
>> added to mmap() syscall and kmalloc() siblings, respectively.
>>
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
>
