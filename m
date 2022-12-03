Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D656412FE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Dec 2022 02:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiLCBVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 20:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiLCBVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:21:46 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD4E464F;
        Fri,  2 Dec 2022 17:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670030505; x=1701566505;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7vkoBqPJ3TryFNfaW8RMx4dusBRKuvTdipU0MENYgdM=;
  b=RJxlpGmk1zzA2ywxkMXPtF7VB2EGSt6gljvgN3B0aDDfhDxhsnH8Q4wd
   naDdOy0xybT9OuVhze1PX+YJgRFeqEBL0u9ZTQ2xzwLesRfvyQgY/yLXO
   3tK1sheZkVa6YRul605cG5VFu3xLwUQXCsejrp03yJBPb9l0iof91kTcp
   KBi2NQnGgc1Epz4gc1GDO5+k4PhrirF6PTUAktd+WxtGNGeyMVyqXd1GP
   gdscxBQL5Hb9pdd9HmUfaDev3G8J4kVNGKC+S3efdlRCokyp4za16XRhm
   bzI2AFjuwmQTCtkyr4tXCLX2jwt5FWaGqlBbr4fhBqzZCj9vKh5mfMSYv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313717490"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313717490"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 17:21:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="622892556"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="622892556"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2022 17:21:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 17:21:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 17:21:44 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 17:21:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDU6qJCwufBfuWXP/Ov82AqSnUq1nL/u7FsIzDoT+7DE/dyZr+56T6Tj85Ss6zRhnF7cD4cj7YrmEmBmRYiLqiItPxupnWulQDxvR90s1jyFlvRGjp8NWdETj5/nVz8RaxapkRMqAd7ALkQSmlKWTQOynZLEjeZGv6W3GgAuW4OIEwXHbeBPqk5fyJirKAAt1DBSVC5AIvn73cz1S8JJ9UFXOJWt4fjYYL9Zw1pFRzJdCZq2Cguyz2i0jaKvBbUjF7KqD0850B1s7q2ITb7bJOzpIdZSO8D2ffGisGeCsZHzAKd0TtrS4KnZrRJ1a9rKUcpLbQBfqlErh0fvXv2Z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/PALs03XIh7p/szLhzGT11rbG68+DGme3knk3enIY0=;
 b=dc+/ubDGD3gwMZaoIpcMhy+kF7cLx9Q/Q7pNNV+rwy9/2TRuEOnEae7vWkGL3yQLtwSYaAcbHtFwJyONj/+VZelCt9zKcHJmP4BUIQnB/i76+Hv4kQ9cnxtwmlGY3dhLoz4d9tl6tY4iDAoxpVogPf8r/ecTKuPtRu8CdM5KVRhXEUFZvVsd1jyI019jSE58HhMof/3TBzBYSCWMlKmUnauD3fZ6iAMRA6D4HUWAx7gJ75EHuYRPhQ6WtWFG2WN3Nk5DICMuFd+f7adytxSP8zhBmycsvbqlON0/uCtknnLpSbFXsroCWQjzinlddMGHOz4ScWMFKHCbBFjJF5SBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY8PR11MB6868.namprd11.prod.outlook.com
 (2603:10b6:930:5c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Sat, 3 Dec
 2022 01:21:41 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Sat, 3 Dec 2022
 01:21:41 +0000
Date:   Fri, 2 Dec 2022 17:21:38 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: RE: [PATCH v2 0/8] fsdax,xfs: fix warning messages
Message-ID: <638aa4a298879_3cbe0294ba@dwillia2-xfh.jf.intel.com.notmuch>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:a03:333::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY8PR11MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0636e8-9b61-46e6-e825-08dad4ccbb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQ8QWjihgD3EStdsqdjxgrvsDrcozbk/Rb6DFIFNLc/nRLlh2dr9IaFBRAxrYS2Dd9WV1w1OO3NjwdqdLhDYZmxeSxJfPMT/1gsia/Yc18dcgFpIGf/Jvorc7Bqli9Vldoc9lRq2XWnzmnQg+CUGp69ffSv2lleu95cK7TP1qxaTxaVtMrxsPQTOdgCYR4V4kOwF5sky7MVn0ThzQpgf1XgJ7w/LvZOBqgsJ4APM9LCC9acg3LubaMBc1mqqrQ/9c5irEB3QJYxG7CIoCIsrSU1tc4bAvuybm42ocXAL8s+sTUqE6TvIjdyUNnTm/aB+RLHX52Gm8h8juS90kbyWfeZnVN3+HHfopc9LsL2JZhRzapMgU34BX/qzbj6+Zi7Lbj4h7unJMcgjTyi/aI96LZ/ubNaxC0STnZAtOEW6j77vX+KE/SwKkim39moqblBg4WULDvxHAhVuN6Is+vP9R/LdIXWfTxmCmUbK4HTCf6tLP4FIbyw9gFgXzciHkOif2O9WpCqoKoX0S6/7vDl4pAV07p8O3O5N3tAxEiyNSFR5Qm+INWchIai3ar7EDCRCNxArVi/CfucxN8y/EE+s1hL0PDg0nXbjBRKRWjVFmEKUn80xViGBDKmBKV2/5DMQRaMGa39Q0BmddC592ay5seyNcXkjgYbgsGW9f+JepCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(186003)(66556008)(66476007)(478600001)(6486002)(4326008)(8676002)(41300700001)(966005)(66946007)(8936002)(86362001)(6666004)(316002)(2906002)(5660300002)(82960400001)(45080400002)(26005)(83380400001)(6506007)(6512007)(9686003)(15650500001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OvaGh29KozlUah65fXOQf9alDd4MQ9sI807HBgq2IDckthRh8g8JHMEtZPcB?=
 =?us-ascii?Q?51j2qJ8MS3y+mm3S0fnPWzoeA24KTqWZg744XKZ72FDMN0hwzmtoKoqmui0X?=
 =?us-ascii?Q?z8XxkG2GKKM+AT055E8McO8OWH7aiuCqV7ur/XJhEIVWP+t1PX4Izp8RdQKx?=
 =?us-ascii?Q?eWJESVcSz00i9FAn3HOO7E+1nXM7JO/MhDIfEeZLO1aoQup/YKo/1djc2G88?=
 =?us-ascii?Q?WGvFnAdLIhf5YKQ3LA4QcTp6gl6KIMoRJE5G76E4SZE3p8SW9ydJaD2j7NcQ?=
 =?us-ascii?Q?arPXc84JH9GNd7pcYvoQ/qSGNXlEW+wlNfx3FtERT9561UOPstf8r95Dy1p6?=
 =?us-ascii?Q?3t5Uf9nx5A2BDgBGFUHL+7Rhrp18Nbvb+LO1dXMW0eOLRFA6Syi8j/QbF26H?=
 =?us-ascii?Q?mTzxMGgV1NnhXqs5yLCu7RsoFosRZ4k0l7KsnC+RJPo02n43fdBJE4Ws6JOf?=
 =?us-ascii?Q?6nFlPimGuW2FYkX9enuz7aLuekuGQhk4mNuTpHHEpmRCrUSBKHuu007kSP3O?=
 =?us-ascii?Q?cnp1xHfmnN0rU/v1xg4ssc2z8b3LhqGP5me7SZPebw6XQeHeYFZbR+/nJ9Qk?=
 =?us-ascii?Q?0r/c5pmJSWe0uN6HvNnac+HgUnHQYAS5x5HUwfT8vcf8xd26/Ofnqxr6rDCY?=
 =?us-ascii?Q?86m+SbP9gpsHp8jAfzoDhQMVXRdZGPfUnDi8ORvuhC+jFmRU8u90hsXs7j3I?=
 =?us-ascii?Q?avuM/3S5nBZ2AgFnrKertD99YPRCUa/vhD4l40FuU1v7bLqM55c8v4lvsvr/?=
 =?us-ascii?Q?1c58ZwlxGPGE7R6/EH43cKTJJZnp7Ht0v/1uPezddJnDbFGfsW67rHTdHrxh?=
 =?us-ascii?Q?vy7QoBXDCx6x1fcYelIynmxEzUna4jnMkzc6CgsBiWLnpNY8fGT5YAwpicvY?=
 =?us-ascii?Q?MDbaVKzIduCR22o8i/x+vd3ltJPgXlMVTpTpGEeoiy0aQbSEiuaKOSPUg7my?=
 =?us-ascii?Q?bs/SDTTFzj3iF+kDP+keIhvAE/JPXBtVqRhHL4a+bKeWBvDZBIeaUFG5Cz9s?=
 =?us-ascii?Q?RDzP+mBJKGfMb9Lam9uaO4na9THPRIkPcIbR9CpTjH8TArNfgX3P0mC/w6g2?=
 =?us-ascii?Q?nf5RLF6bbLJz4xVkRIph4cU0ZMs/RxdJRuaSVCMx2tQ2sMjKE1sxGWVJYD+v?=
 =?us-ascii?Q?GvoRK0jf+x1LtP2p4o1hae/9o9If+gaWKfhcQbyz6jd6uCr8KErgrrs/Kank?=
 =?us-ascii?Q?WsV4TBX5QkJ4k/FZo0ddb3IR1CTHKHkontc5itukVFctE2WQQIw4JULL3Ls6?=
 =?us-ascii?Q?bDiz7jtLx1V5Yc8wAS8SXMlxXN4jRsEAW7p9ggcqadLCR1WMEezNsYJiy/gh?=
 =?us-ascii?Q?bJmOePse8QbVOQuLVjNfsJbI5lh1Yaam7CVzhCfEqO2LiSG0U2bI9Z4zAsDd?=
 =?us-ascii?Q?43WqDh31cPSHVJQnb4JGJjTJLMVDgRctq+Mdg4mGpzOzdoSW8YJV7MSHnzzN?=
 =?us-ascii?Q?rE4/IavE+RyROGHsnTigmJI9sKJM0vodO0YR80O3Hf5U3RTsqxlBWrB//evM?=
 =?us-ascii?Q?PvyFrPax6vHwLw84Jx5lwApfecMLIALb+/EIdz1Gbmdwg+6UBHaGqrx+0vfR?=
 =?us-ascii?Q?xCv8YRh+EZgSuXY/Zsl+4XouMGVvNIA25Kb2RuXPAbra/vnBpTQaijiA3cem?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0636e8-9b61-46e6-e825-08dad4ccbb53
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 01:21:40.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sihtgPJjfTXWovGehpKk6Ssbvn9mPpyBCa4cycnT85YI8hoyBqvaTqRMDhCnUD0kf8KJEnAxUQrDck8usZJInXyPsdhyYL7zqwX1E36QJ3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6868
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shiyang Ruan wrote:
> Changes since v1:
>  1. Added a snippet of the warning message and some of the failed cases
>  2. Separated the patch for easily review
>  3. Added page->share and its helper functions
>  4. Included the patch[1] that removes the restrictions of fsdax and reflink
> [1] https://lore.kernel.org/linux-xfs/1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com/
> 
> Many testcases failed in dax+reflink mode with warning message in dmesg.
> Such as generic/051,075,127.  The warning message is like this:
> [  775.509337] ------------[ cut here ]------------
> [  775.509636] WARNING: CPU: 1 PID: 16815 at fs/dax.c:386 dax_insert_entry.cold+0x2e/0x69
> [  775.510151] Modules linked in: auth_rpcgss oid_registry nfsv4 algif_hash af_alg af_packet nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter ip_tables x_tables dax_pmem nd_pmem nd_btt sch_fq_codel configfs xfs libcrc32c fuse
> [  775.524288] CPU: 1 PID: 16815 Comm: fsx Kdump: loaded Tainted: G        W          6.1.0-rc4+ #164 eb34e4ee4200c7cbbb47de2b1892c5a3e027fd6d
> [  775.524904] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.0-3-3 04/01/2014
> [  775.525460] RIP: 0010:dax_insert_entry.cold+0x2e/0x69
> [  775.525797] Code: c7 c7 18 eb e0 81 48 89 4c 24 20 48 89 54 24 10 e8 73 6d ff ff 48 83 7d 18 00 48 8b 54 24 10 48 8b 4c 24 20 0f 84 e3 e9 b9 ff <0f> 0b e9 dc e9 b9 ff 48 c7 c6 a0 20 c3 81 48 c7 c7 f0 ea e0 81 48
> [  775.526708] RSP: 0000:ffffc90001d57b30 EFLAGS: 00010082
> [  775.527042] RAX: 000000000000002a RBX: 0000000000000000 RCX: 0000000000000042
> [  775.527396] RDX: ffffea000a0f6c80 RSI: ffffffff81dfab1b RDI: 00000000ffffffff
> [  775.527819] RBP: ffffea000a0f6c40 R08: 0000000000000000 R09: ffffffff820625e0
> [  775.528241] R10: ffffc90001d579d8 R11: ffffffff820d2628 R12: ffff88815fc98320
> [  775.528598] R13: ffffc90001d57c18 R14: 0000000000000000 R15: 0000000000000001
> [  775.528997] FS:  00007f39fc75d740(0000) GS:ffff88817bc80000(0000) knlGS:0000000000000000
> [  775.529474] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  775.529800] CR2: 00007f39fc772040 CR3: 0000000107eb6001 CR4: 00000000003706e0
> [  775.530214] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  775.530592] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  775.531002] Call Trace:
> [  775.531230]  <TASK>
> [  775.531444]  dax_fault_iter+0x267/0x6c0
> [  775.531719]  dax_iomap_pte_fault+0x198/0x3d0
> [  775.532002]  __xfs_filemap_fault+0x24a/0x2d0 [xfs aa8d25411432b306d9554da38096f4ebb86bdfe7]
> [  775.532603]  __do_fault+0x30/0x1e0
> [  775.532903]  do_fault+0x314/0x6c0
> [  775.533166]  __handle_mm_fault+0x646/0x1250
> [  775.533480]  handle_mm_fault+0xc1/0x230
> [  775.533810]  do_user_addr_fault+0x1ac/0x610
> [  775.534110]  exc_page_fault+0x63/0x140
> [  775.534389]  asm_exc_page_fault+0x22/0x30
> [  775.534678] RIP: 0033:0x7f39fc55820a
> [  775.534950] Code: 00 01 00 00 00 74 99 83 f9 c0 0f 87 7b fe ff ff c5 fe 6f 4e 20 48 29 fe 48 83 c7 3f 49 8d 0c 10 48 83 e7 c0 48 01 fe 48 29 f9 <f3> a4 c4 c1 7e 7f 00 c4 c1 7e 7f 48 20 c5 f8 77 c3 0f 1f 44 00 00
> [  775.535839] RSP: 002b:00007ffc66a08118 EFLAGS: 00010202
> [  775.536157] RAX: 00007f39fc772001 RBX: 0000000000042001 RCX: 00000000000063c1
> [  775.536537] RDX: 0000000000006400 RSI: 00007f39fac42050 RDI: 00007f39fc772040
> [  775.536919] RBP: 0000000000006400 R08: 00007f39fc772001 R09: 0000000000042000
> [  775.537304] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
> [  775.537694] R13: 00007f39fc772000 R14: 0000000000006401 R15: 0000000000000003
> [  775.538086]  </TASK>
> [  775.538333] ---[ end trace 0000000000000000 ]---
> 
> This also effects dax+noreflink mode if we run the test after a
> dax+reflink test.  So, the most urgent thing is solving the warning
> messages.
> 
> With these fixes, most warning messages in dax_associate_entry() are
> gone.  But honestly, generic/388 will randomly failed with the warning.
> The case shutdown the xfs when fsstress is running, and do it for many
> times.  I think the reason is that dax pages in use are not able to be
> invalidated in time when fs is shutdown.  The next time dax page to be
> associated, it still remains the mapping value set last time.  I'll keep
> on solving it.

This one also sounds like it is going to be relevant for CXL PMEM, and
the improvements to the reference counting. CXL has a facility where the
driver asserts that no more writes are in-flight to the device so that
the device can assert a clean shutdown. Part of that will be making sure
that page access ends at fs shutdown.

> The warning message in dax_writeback_one() can also be fixed because of
> the dax unshare.
> 
> 
> Shiyang Ruan (8):
>   fsdax: introduce page->share for fsdax in reflink mode
>   fsdax: invalidate pages when CoW
>   fsdax: zero the edges if source is HOLE or UNWRITTEN
>   fsdax,xfs: set the shared flag when file extent is shared
>   fsdax: dedupe: iter two files at the same time
>   xfs: use dax ops for zero and truncate in fsdax mode
>   fsdax,xfs: port unshare to fsdax
>   xfs: remove restrictions for fsdax and reflink
> 
>  fs/dax.c                   | 220 +++++++++++++++++++++++++------------
>  fs/xfs/xfs_ioctl.c         |   4 -
>  fs/xfs/xfs_iomap.c         |   6 +-
>  fs/xfs/xfs_iops.c          |   4 -
>  fs/xfs/xfs_reflink.c       |   8 +-
>  include/linux/dax.h        |   2 +
>  include/linux/mm_types.h   |   5 +-
>  include/linux/page-flags.h |   2 +-
>  8 files changed, 166 insertions(+), 85 deletions(-)
> 
> -- 
> 2.38.1
> 
> 


