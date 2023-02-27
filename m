Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F886A4F97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 00:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjB0XOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 18:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjB0XOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:14:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97541F919;
        Mon, 27 Feb 2023 15:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677539655; x=1709075655;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=N/LVXnlebmafVl89hB3BGvnUtzINNTLNLHQbjS1tsys=;
  b=WgbK9/ThPzvF+Ev4sIdKL7ZizMQf60vd/oU4DuGaBGwUwA02qwffxo9s
   mRdeoQu9lDN25E85+oeo4EI/Dh5FxgqYl5ih+Jkfz4JzGyqAgNtNG9+A8
   76CjMEYa1WK20gp8ykKBuxNnoPz6Qosv5sU9XE3KmONNj8zxLYgWqowZU
   QTc7cMkl5TFyowG81LuixL7meuqwsdH6y7p7GnWbxmpJYyDX5DPbv97MK
   IhKjMVhbsl9o922zoQiGONf7zjSn1+HEGv96sp217oOT1/OwTiwhhx0bz
   IxcebX4HLgRu72VykVnCnJArGpuYpbUorhPGBe9UkQCeyYwR4GRSelHla
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="336278859"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="336278859"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 15:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="783585162"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="783585162"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 27 Feb 2023 15:14:14 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 15:14:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 15:14:14 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 27 Feb 2023 15:14:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYnLnDXVg+RQ/xWMI3pxQ9MJmVYNW+kLvR359eF/TRmsc0iJV1XQC1xNWLZjQQI6Y57eL9GnGK037qp7R3gst2OlRXw/h3YqUCkbyzbxHGxxfRNyvlz+Z1Lq1lc9W2I3GG/fiiO/ImHypVu23/aIpc84N4Oi/CsIy27by6lvDy6A9E3wQly2ITXrGBt+k32W5/6pU78fU6nGLV9Cq1KyF99xGlFg5TRs3oJpE6pfvhCjMa77ilmMRSqrvqqNU3wl+5kkX+oe8W8pQjjtJa0gNAuurK0r77TxTBqYM4JcVO7zvR6Sp8p6Bq973toYUP5xBNcx6o06AT/DDgfZza7PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu9y2hmIrJV7uCtyxLj1eilkdXtnjZEv46JH3HhrSOk=;
 b=N7fafU1Ew7B9gIHPn2JiqkuLJMeTZOj3ZHLhvVACYoeB4b4JMj3yh7g8lw19HzTcZ+apdlmGwIWZNQI4cUwq0WVmyRFmOHYHAWbD7wb/Y6XH283ye84C2s9D5w+VydIdOWlWPD5jqA2cMY4D2xDCZhbrnUT33T/zXiMDeodt39wxFhAkYJgAtQ2b3qCbVGlvhd/HAgJM0nZO8Ke9QmOvqeNBtCnKPLif4GR5Ipm5NiEaaoplPHubtvW42oM4sXnHD1sjKjauv+7pdoqdjIhfCdOEPqt6ZP+4nyVapcZrIvvMSAkYGRwPzZ/+WHSE1nJMalRhwro7VSINqwkU1nzWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5795.namprd11.prod.outlook.com (2603:10b6:510:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 23:14:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6134.025; Mon, 27 Feb 2023
 23:14:11 +0000
Date:   Mon, 27 Feb 2023 15:14:08 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>,
        <lsf-pc@lists.linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
        <viacheslav.dubeyko@bytedance.com>
Subject: RE: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <63fd39406c2dd_276522948@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20230221014114epcas2p1687db1d75765a8f9ed0b3495eab1154d@epcas2p1.samsung.com>
 <20230221014114.64888-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221014114.64888-1-ks0204.kim@samsung.com>
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: d78b4c89-6225-4860-17fb-08db1918558f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35nRvUafMfhXnL1pUw6RfEw7oYBD8EVPj2wD0/QUtWcP/EsdI01YqCZmfjbW2GMdXUWc5NUt1jPIRHf5Mcs/vLiClGXIbM5Vw56k9/eIEQFh1AWFPFlZLh9BDmH5F0Pgh7rRCPwurqMqdK0Fn+MwiXX0LwRFaobnWW8cxK+AWhWTGWd054gw6XLE5sX+FSWWJF1SK2cdaJ26iAWWLj99vvR4qAAsRCafGsV8UOhofVflbj7B3UGsqN3bATIQ+rqxc+Ia33xLWHg9SZy+v8HeX5ocpa23inLpT7TMI/lw3T8wrMdpI2mtpqP3ScrggvKuwCFLnBUzkzbXw6/PoI+DvvOwYP2HjHv7Bs4K8ssb4b19oZSefaBv4seM3ourADa5ctBmPQG+AKD7b2hg4g33OgpFrUEBCKzO6F2MBUbEUXPUOUPJCyuqm56YbP478rD7rt37UNr3XL6vKwjwKTayAK5JKtgVMbTPsgDP1mc+Mchjtzm3CrIst9XMT00uZl2BqoXmo9Ry7YcWQ3bTB62KUvFfQ5rYl4hksjvmZ9iaXqm3nNOpaRYxsFtxki1FFy6vCAhzlnrloJwwVQd5Vgg6ofp1axYyFvl2XOa8yjGJdANncsnEGOywYfuL95Y236STaWLdAMIJz9Di/1h5nNRXAxadhJv06DMxhjWKAFzk1bI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199018)(66899018)(316002)(82960400001)(2906002)(5660300002)(8936002)(86362001)(6512007)(66946007)(186003)(9686003)(26005)(38100700002)(4326008)(66476007)(8676002)(41300700001)(66556008)(6506007)(83380400001)(478600001)(966005)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?m8DSHyKRTCdvXQ5+IochTZFBkmN2ZKuL8oJGUuJSinSekN+bT7RcLzNgAG?=
 =?iso-8859-1?Q?NeAwKFVbFOqxB9g5bW64XRvS4yrD3nRfur8915IQok21boMQ6MHFv0fA4V?=
 =?iso-8859-1?Q?oIq/mVyLIe767F4ql9vXAc6SMXsY+5DnDd1jNIBFaVpB9pBfZGieQQatP0?=
 =?iso-8859-1?Q?Lc4xqWwLfJPHU3iPQveck30V+/sPU01sEhnVJjWF5RkEib4v8Vg+K3FdEM?=
 =?iso-8859-1?Q?JWw8ywSe+ADDZcpJxTlXQJanIoB/14a0gKo7Xi90Gm10uXtzqFgsaQ9Dzd?=
 =?iso-8859-1?Q?4QVAEcpFZj//nhgeGjyIsYJsU+Zl/3XanzT/HWCtvVzdS45isrDldDsD9G?=
 =?iso-8859-1?Q?5FF5qEMBkdVkBZEnn8IC7xev5ZbTZAe61FGEXLO5IQUZ995TcIkjHUz5mf?=
 =?iso-8859-1?Q?Ln9uGawMYGC2Uh183AQltw4ZjxWP6huhWkmHJxzeuL43i2TiHyntGngdqA?=
 =?iso-8859-1?Q?KQDkh5FHW1VryhPScdIBwDKzf9JPz2ymT1KpQu4I04nSKmB/MFtplTj+sR?=
 =?iso-8859-1?Q?gEwPeY39XZricPDlat8eyAA4Op6TFFjsaZP//nLJ7CMjYKu0Ts477mEydb?=
 =?iso-8859-1?Q?W1rTnjW4JhmoECnxDHp7h0xoripy29pR5/xEUDOIh1/7zyfc1ozyTg2pFX?=
 =?iso-8859-1?Q?kZngJVZJ6vISw8sOIfIg0cgxBFePcUGzLRLmlzBW20P2Rf3VLWgco+g6Ll?=
 =?iso-8859-1?Q?68EWRC+vblLVbM3durEpJz9Ze5CQDOyrSNnK1eWe88NjsOETfTsv8UgiLg?=
 =?iso-8859-1?Q?ruMYo3g9d0zHOTjKaKGe5+HEobcfUthxOgmSWcnnnQPscVt0FJq8g++KSb?=
 =?iso-8859-1?Q?3jThcumv2DYyo6WdLMhMxvgKo+//GTPIhj6ixd2Sg5q1yc71Kfc1SqmhIE?=
 =?iso-8859-1?Q?mJ/1vW3mK5QEPMC9w+LOkrEoHnI+sFk2W20JSyB1gUgkdtNJf/totA202b?=
 =?iso-8859-1?Q?1CixZMSWTXAPrJDuAd8qv/+1cKOyYm1qtqXJd3/flxIJg7Q8UqTd/M3O7A?=
 =?iso-8859-1?Q?5hs8mkO2VVFAaM8UTyW1KDNVdlJ9g2ad8Hld9NSUvN8PoR2KwszukxZfBA?=
 =?iso-8859-1?Q?duImdeg6SlA1/nkIe6+BZdZsj8wOuvvUQ0NA/UD21XIwiv6kc5rww2Z4vb?=
 =?iso-8859-1?Q?JmStInC4xpD0dITLfTHqoBdMcQmA61G8chDDLfhk866UwzwwiQtt2lHcL+?=
 =?iso-8859-1?Q?2g879Wh2jze7mLtQZdd5TSVGxPqIwVQ0GU2TS1cV6USxQzs6mtKXKDeH66?=
 =?iso-8859-1?Q?9LYPwCKAHw1NF21+PqaDIIr209Xrl39SZYnOJeLmDY0V8Xp+0benO7uE9k?=
 =?iso-8859-1?Q?Cq94tjfdlEG68dN+0WMh+r3QWiiPSgXgKdVqee7uvelXWN2+zo2nu5znXk?=
 =?iso-8859-1?Q?H62wZBHDwsmrGtX4AsfPiAfTWSIH3Xmu13rwO45BJShVth84kYc01sHSMk?=
 =?iso-8859-1?Q?NwraKfSqyeUzrrEMTZb7uIIepeS9/v1rLxroDXy4czTr4eTNlytOqeuON9?=
 =?iso-8859-1?Q?QZc1LU2kcjH/Tl4Ckidwmu5v+8HtIoEUmVQVsEyCG9+pGyZFvaNhD5fa4e?=
 =?iso-8859-1?Q?GzJ4eslFvnXl/fmG0MXyU96jQPIRonEHJI8HciO9ymaWeChGoc6UrKV2VZ?=
 =?iso-8859-1?Q?Z7CfJ3cxPoENx5WIq0rO77DUX7BUIVgTB3XDmv9P+86gwq6WDl8AsiOw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d78b4c89-6225-4860-17fb-08db1918558f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 23:14:11.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5H8sdweo0AQwXCBtyRR/rG8774yM8lqBG2XaUw5I5pz3C3eXDJUg4IWSext2aXdNHMuJWWztzvRaEPIzBSTwMoaIFZ4psSazd7JCkPTNTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5795
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please be sure to log this in the submission spreadsheet as well. From the
CFP:

---

1) Fill out the following Google form to request attendance and
suggest any topics

        https://forms.gle/VKVXjWGBHZbnsz226

In previous years we have accidentally missed people's attendance
requests because they either didn't cc lsf-pc@ or we simply missed them
in the flurry of emails we get.  Our community is large and our
volunteers are busy, filling this out will help us make sure we don't
miss anybody.


Kyungsan Kim wrote:
> CXL is a promising technology that leads to fundamental changes in
> computing architecture.  To facilitate adoption and widespread of CXL
> memory, we are developing a memory tiering solution, called
> SMDK[1][2].  Using SMDK and CXL RAM device, our team has been working
> with industry and academic partners over last year.  Also, thanks to
> many researcher's effort, CXL adoption stage is gradually moving
> forward from basic enablement to real-world composite usecases.  At
> this moment, based on the researches and experiences gained working on
> SMDK, we would like to suggest a session at LSF/MM/BFP this year to
> propose possible Linux MM changes with a brief of SMDK.
> 
> Adam Manzanares kindly adviced me that it is preferred to discuss
> implementation details on given problem and consensus at LSF/MM/BFP.
> Considering the adoption stage of CXL technology, however, let me
> suggest a design level discussion on the two MM expansions of SMDK
> this year.  When we have design consensus with participants, we want
> to continue follow-up discussions with additional implementation
> details, hopefully.
> 
>  
> 1. A new zone, ZONE_EXMEM We added ZONE_EXMEM to manage CXL RAM
> device(s), separated from ZONE_NORMAL for usual DRAM due to the three
> reasons below.
> 
> 1) a CXL RAM has many different characteristics with conventional DRAM
> because a CXL device inherits and expands PCIe specification.  ex)
> frequency range, pluggability, link speed/width negotiation,
> host/device flow control, power throttling, channel-interleaving
> methodology, error handling, and etc.  It is likely that the primary
> usecase of CXL RAM would be System RAM.  However, to deal with the
> hardware differences properly, different MM algorithms are needed
> accordingly.
> 
> 2) Historically, zone has been expanded by reflecting the evolution of
> CPU, IO, and memory devices.  ex) ZONE_DMA(32), ZONE_HIGHMEM,
> ZONE_DEVICE, and ZONE_MOVABLE.  Each zone applies different MM
> algorithms such as page reclaim, compaction, migration, and
> fragmentation.  At first, we tried reuse of existing zones,
> ZONE_DEVICE and ZONE_MOVABLE, for CXL RAM purpose.  However, the
> purpose and implementation of the zones are not fit for CXL RAM.
> 
> 3) Industry is preparing a CXL-capable system that connects dozens of
> CXL devices in a server system.  When a CXL device becomes a separate
> node, an administrator/programmer needs to be aware of and manually
> control all nodes using 3rd party software, such as numactl and
> libnuma.  ZONE_EXMEM allows the assemble of CXL RAM devices into the
> single ZONE_EXMEM zone, and provides an abstraction to userspace by
> seamlessly managing the devices.  Also, the zone is able to interleave
> assembled devices in a software way to lead to aggregated bandwidth.
> We would like to suggest if it is co-existable with HW interleaving
> like SW/HW raid0.  To help understanding, please refer to the node
> partition part of the picture[3].
> 
> 
> 2. User/Kernelspace Programmable Interface In terms of a memory
> tiering solution, it is typical that the solution attempts to locate
> hot data on near memory, and cold data on far memory as accurately as
> possible.[4][5][6][7] We noticed that the hot/coldness of data is
> determined by the memory access pattern of running application and/or
> kernel context.  Hence, a running context needs a near/far memory
> identifier to determine near/far memory.  When CXL RAM(s) is
> manipulated as a NUMA node, a node id can be function as a CXL
> identifier more or less.  However, the node id has limitation in that
> it is an ephemeral information that dynamically varies according to
> online status of CXL topology and system socket.  In this sense, we
> provides programmable interfaces for userspace and kernelspace context
> to explicitly (de)allocate memory from DRAM and CXL RAM regardless of
> a system change.  Specifically, MAP_EXMEM and GFP_EXMEM flags were
> added to mmap() syscall and kmalloc() siblings, respectively.
> 
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


