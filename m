Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E326A90C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 07:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCCGJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 01:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCCGI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:08:59 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AADC16AF6;
        Thu,  2 Mar 2023 22:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677823737; x=1709359737;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gGTikq5fLcKifxZAwd+SBP3F4+11XbpH1Bp9r2JtR3E=;
  b=gnGT/h/tfJl6sBcFGAQDeO3RrxKBhTfP9+k2OpwICKd0q0kqgsr7vBGV
   dH4h51oyTHLuMrHEgkhx42n+KALqB0wfWZplz191IdKfmS/dNlpp27spm
   As3XmWq7YQs5n+ANpig7VyN2vTZiAbrT8pGMmmfHpMddqVhVK8hcdo65D
   l3vOqG0JFO2Nh7ZUCPMUmUx386F1IJzLQu1yFeecFwM8sfVLDQKUv+zfi
   Io2H0lVBOyFhCqDZ1LOFR4gqGkcHIibB2opx6AvXagaSzvdSP7877m4FN
   KhnKbH8GZRQEOdOvate0qH7kW8VxK4kVwqDTLlqV4uHALrl+/8m3AuEeA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="336483565"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="336483565"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 22:08:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="625254394"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="625254394"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 22:08:51 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
References: <CGME20230221014114epcas2p1687db1d75765a8f9ed0b3495eab1154d@epcas2p1.samsung.com>
        <20230221014114.64888-1-ks0204.kim@samsung.com>
Date:   Fri, 03 Mar 2023 14:07:54 +0800
In-Reply-To: <20230221014114.64888-1-ks0204.kim@samsung.com> (Kyungsan Kim's
        message of "Tue, 21 Feb 2023 10:41:14 +0900")
Message-ID: <87y1oe74g5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Kyungsan,

Kyungsan Kim <ks0204.kim@samsung.com> writes:

> CXL is a promising technology that leads to fundamental changes in computing architecture.
> To facilitate adoption and widespread of CXL memory, we are developing a memory tiering solution, called SMDK[1][2].
> Using SMDK and CXL RAM device, our team has been working with industry and academic partners over last year.
> Also, thanks to many researcher's effort, CXL adoption stage is gradually moving forward from basic enablement to real-world composite usecases.
> At this moment, based on the researches and experiences gained working on SMDK, we would like to suggest a session at LSF/MM/BFP this year
> to propose possible Linux MM changes with a brief of SMDK.
>
> Adam Manzanares kindly adviced me that it is preferred to discuss implementation details on given problem and consensus at LSF/MM/BFP.
> Considering the adoption stage of CXL technology, however, let me suggest a design level discussion on the two MM expansions of SMDK this year.
> When we have design consensus with participants, we want to continue follow-up discussions with additional implementation details, hopefully.
>
>  
> 1. A new zone, ZONE_EXMEM
> We added ZONE_EXMEM to manage CXL RAM device(s), separated from ZONE_NORMAL for usual DRAM due to the three reasons below.
>
> 1) a CXL RAM has many different characteristics with conventional DRAM because a CXL device inherits and expands PCIe specification.
> ex) frequency range, pluggability, link speed/width negotiation, host/device flow control, power throttling, channel-interleaving methodology, error handling, and etc.
> It is likely that the primary usecase of CXL RAM would be System RAM.
> However, to deal with the hardware differences properly, different MM algorithms are needed accordingly.
>
> 2) Historically, zone has been expanded by reflecting the evolution of CPU, IO, and memory devices.
> ex) ZONE_DMA(32), ZONE_HIGHMEM, ZONE_DEVICE, and ZONE_MOVABLE.
> Each zone applies different MM algorithms such as page reclaim, compaction, migration, and fragmentation.
> At first, we tried reuse of existing zones, ZONE_DEVICE and ZONE_MOVABLE, for CXL RAM purpose.
> However, the purpose and implementation of the zones are not fit for CXL RAM.
>
> 3) Industry is preparing a CXL-capable system that connects dozens of CXL devices in a server system.
> When a CXL device becomes a separate node, an administrator/programmer needs to be aware of and manually control all nodes using 3rd party software, such as numactl and libnuma.
> ZONE_EXMEM allows the assemble of CXL RAM devices into the single ZONE_EXMEM zone, and provides an abstraction to userspace by seamlessly managing the devices.
> Also, the zone is able to interleave assembled devices in a software way to lead to aggregated bandwidth.
> We would like to suggest if it is co-existable with HW interleaving like SW/HW raid0.
> To help understanding, please refer to the node partition part of the picture[3].

In addition to CXL memory, we may have other kind of memory in the
system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
memory in GPU card, etc.  I guess that we need to consider them
together.  Do we need to add one zone type for each kind of memory?

>
> 2. User/Kernelspace Programmable Interface
> In terms of a memory tiering solution, it is typical that the solution attempts to locate hot data on near memory, and cold data on far memory as accurately as possible.[4][5][6][7]
> We noticed that the hot/coldness of data is determined by the memory access pattern of running application and/or kernel context.
> Hence, a running context needs a near/far memory identifier to determine near/far memory. 
> When CXL RAM(s) is manipulated as a NUMA node, a node id can be function as a CXL identifier more or less.
> However, the node id has limitation in that it is an ephemeral information that dynamically varies according to online status of CXL topology and system socket.
> In this sense, we provides programmable interfaces for userspace and kernelspace context to explicitly (de)allocate memory from DRAM and CXL RAM regardless of a system change.
> Specifically, MAP_EXMEM and GFP_EXMEM flags were added to mmap() syscall and kmalloc() siblings, respectively.

In addition to NUMA node, we have defined the following interfaces to
expose information about different kind of memory in the system.

https://www.kernel.org/doc/html/latest/admin-guide/abi-testing.html#abi-sys-devices-virtual-memory-tiering

Best Regards,
Huang, Ying

> Thanks to Adam Manzanares for reviewing this CFP thoroughly.
>
>
> [1]SMDK: https://github.com/openMPDK/SMDK
> [2]SMT: Software-defined Memory Tiering for Heterogeneous Computing systems with CXL Memory Expander, https://ieeexplore.ieee.org/document/10032695
> [3]SMDK node partition: https://github.com/OpenMPDK/SMDK/wiki/2.-SMDK-Architecture#memory-partition
> [4]TMO: Transparent Memory Offloading in Datacenters, https://dl.acm.org/doi/10.1145/3503222.3507731
> [5]TPP: Transparent Page Placement for CXL-Enabled Tiered Memory, https://arxiv.org/abs/2206.02878
> [6]Pond: CXL-Based Memory Pooling Systems for Cloud Platforms, https://dl.acm.org/doi/10.1145/3575693.3578835
> [7]Hierarchical NUMA: https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4656/original/Hierarchical_NUMA_Design_Plumbers_2017.pdf
