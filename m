Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A678EF25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343567AbjHaOCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjHaOCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:02:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB5B8;
        Thu, 31 Aug 2023 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693490532; x=1725026532;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ZMMTw5uCw00HaazfOK3xRmD4cmby9iQJHYpsdHU03J4=;
  b=n4VlQReXaVXI27Tf+z78GXKP9TUENj1wTFmXvzDeVrctZCbMyij/xO9k
   Cn0Xi95Q4g5UcUKNhmMfKLqi/eWba+C79n1VQi5B6RIKrSR6DpnpOs8qc
   oyTpn57nTvYFb+gcaqbbuHWjdNe2iiEDt9+ikKt9ma5RGoVf/PsiCqqI9
   Q/DKAU6xGQ6zeDbbe8CEQMrmU3qsYJlKGjQ6dgsl0wOQanU6bnpkh8SlO
   vn68HjAdNBJ2vTry3S7kKZ2JV86xT0mCxDdAZKslXlgJvYxrBLEI7jueP
   LnoOYnlpBfa5MoCzNLyDBeVFtXZy5u+Fp8s8uWKXP4sVpOOelEn4/GoDG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="366168707"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="366168707"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="863078190"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="863078190"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 06:41:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 06:41:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 06:41:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 06:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBhQWaPOqZ8GnQk9ic6SSuaMEULSlH6aRPs2v0SXOAJc0T1g88pSJIQSI4MsXHXV1vicPk86gKZAhl0Sp0tHMznkF/GAdvv2kUhdX3zOVjLQ7O2436kFZqgH8BmzDpOsisaGnaVlfHXPqy+1M0UWlwCYNLuLZ2KyVBHzKaI5pt03tS/anSvOd8Ug1258/bHq9LxnUcF6nRfq3Udsts+vHrvmfXCS57H4LBTWoHnqa0i1LUIiZXz+xn/jRrPnXILdYza2iOrB+AXVKfVbFzJ9OIpOfq/scZ0h/KHJgbqysSuYVo9uov1g4jsZFAOyTrpGJMCO6CVT1wWhPm8j08o+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/dyKF1wscaqgv3PZb3uBHqlJyDc11MY/ONKyPrmYa4=;
 b=W6+xbH2uGm1ChYuaLsc/2yAOmSCZZ5YfepBoJGXEbPyQ0yUEx3hIXdRI02gUibwayOACMZnEgKrLNEQ4mts4L2EtoDjlWvk/vJ2wKRVbtHR7u9tnobm5MEtB3VDVqNRxSwZMAJXyQosu4rxHflVc9HX684+EzDWs0iNJFuVXud039eEVD3zGtp931SwSoL2AKLlxNOASISddigEyuWWDUwT/8CD1vGklCCqqgM1tcIQBlw1VqNIM+0+LidDPMqceV71oMZ/dxX4inr6d9ou6aeAYMWZf+NWlDnGKLAZO+5YgyX3N9gE2aND2PjU+GxySHi8AUek39HuQpXamkk8Dmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 13:41:04 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 13:41:04 +0000
Date:   Thu, 31 Aug 2023 21:40:51 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <Liam.Howlett@oracle.com>, <corbet@lwn.net>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <brauner@kernel.org>, <surenb@google.com>,
        <michael.christie@oracle.com>, <peterz@infradead.org>,
        <mathieu.desnoyers@efficios.com>, <npiggin@gmail.com>,
        <avagin@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v2 5/6] maple_tree: Update check_forking() and
 bench_forking()
Message-ID: <202308312115.cad34fed-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230830125654.21257-6-zhangpeng.00@bytedance.com>
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bc91a2-05f4-4ba4-18e5-08dbaa27ec1b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1k58zYOI1hiFWbyzMJG3MilMGJu96ae4OmiyX1MnQ7daCJCcF/SnTu29g027jdCtm2CgeG1rThzoC8667NXsAqBMnYOyqqh4LnAWQy9tj2Xiig2NUVex2f7Cqy3g+I3O25jeSgJZiYDDWpF9DUkd6Mh7w5heNh8r6ov7WNI0bJoyq9LKyxKoH9SxSV9N1j11hog8syNWs/EaA4DuufqO0gaOuutqtKtH7mMMD42i5iflgUEK3aWeVVPESS17I75hYwYky0e/hECa/JjzKstH2A52g0dvHfexcGrpLWW/iw82FwKtXBFzrlnDiWsuVJ5/RkxyxDbCmfftB3Wm396OTeQ8KStqh4AaiRwjR65MI9AswsbY6EcGqT6MamzZSQsc7Bl2Z/gDXah3/yfYNhHW19rq1M/ko09AzOB0A2AhVwLNE+QCeF+WjNGUsc0rQBEdhz4hNAlRTo5U2VYIwqrlvwrtk/++LFGdy8WIxrJuO5OJaYhRa+ic17Ji4YL8El6oVDN+yeCuOx0i6OzzT908Arj9ZbCzBF6e4C9qbQgavGrTHGWn7iOIEWAexvlUhEz5Hl0GPISDbsReANEaC9S4hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(186009)(1800799009)(451199024)(36756003)(41300700001)(1076003)(38100700002)(966005)(26005)(66556008)(66476007)(66946007)(83380400001)(316002)(6916009)(82960400001)(478600001)(6666004)(2906002)(5660300002)(86362001)(8936002)(6512007)(2616005)(107886003)(7416002)(8676002)(15650500001)(6486002)(6506007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EleUiXTB4av8n2OadCjSWFuUPAErCRlqGmz91sQsDitVUZvOJtmfpJeUy73?=
 =?us-ascii?Q?gJN5Wkdv7VJkS3kDCBSRJBkD3Af+hsuN6UkZ7sj6+6nnKIDf6qmCzDDo8E9a?=
 =?us-ascii?Q?1TVztqddJmso8YcSBvoDQAqYFLl/rny/TbLy1X3YKE22gKJYM/fzZQOjVFEy?=
 =?us-ascii?Q?erglcXUaEw929hDg/qTDly8JP6pJEL9W3Y9P+ZZavefsgCzD41ZiKNC8r4qp?=
 =?us-ascii?Q?Vx/5IzeMM7FrHQsZLyQ13Dn5g6YY/4Nxm+79eJ6jeVTXiuOm5D/ByxwDO71o?=
 =?us-ascii?Q?PvPp2Nu/z15DnEYvZtr04V9Y6jWkjefoJjORKpGvboQsh0SDzsHMGOu6KkHc?=
 =?us-ascii?Q?fQzrYsFVpQ5xdepaTuf++sx7sC599/G1uhCF94mJMzh6oQG6ekO1vipJ0nXJ?=
 =?us-ascii?Q?lrFyLwxEtrsoTB/7E5Q2/wOzl8TvzyIiMheBKGJ3QswUaWvBk4velTBFRll+?=
 =?us-ascii?Q?Z96ACTTeQVFyZkB1UrO0x6ja0ZsECR8AkxjgfPhfRfTCAZQPechbs3QddVH3?=
 =?us-ascii?Q?fMef2dVDk+yruu3DupTL+/zG1VvNDBsH/5YVS+aC0a0tjwihur+uFMPAQYFs?=
 =?us-ascii?Q?AALXBZSZqHtw3st1eJGKS1j41yO8SD7ItkH6kw1avkzVaq8oJjeZGHaPIiZE?=
 =?us-ascii?Q?GrS5nE/qwVfd18Uv/OxrPdx8Y76b706Bl9KD+9naJY3BbnHT1Yr8osGCeJzZ?=
 =?us-ascii?Q?ScdZo0RK9psN9WU9vpKR6eGBZIgxUqd2zJN1yj9hMbujNbwXE/tpP3T1pLA8?=
 =?us-ascii?Q?pfxUOBgrTqO/Ods51z5JnRBV6pqRrqxKFgZv5oyH23FH5ag9ztUz+5D47FuL?=
 =?us-ascii?Q?8EQtWyIFztGirlQTF6X3zta/HTM+570WdO5/GYjQAM9KroCNzkWwYR4DjVUw?=
 =?us-ascii?Q?WFGh3fKeGNxhlY7ttDpMTFvvb0ZDVGGKcx0vleEl6VbER2a8Fs12l38SR/Fo?=
 =?us-ascii?Q?qxr9NZBXU42X6nB+CjOWP2/kbwUtzRfdQ4Nu7c7bOP5+0bWijwXqb2G1G2lo?=
 =?us-ascii?Q?0Xv/i/yRBp1k/nRNkpnGC4YTdI/i+ynRcYG39CN3K7WkJ4rq6sopqfKmM15A?=
 =?us-ascii?Q?vu6ev/Nu3cqu0UvTrrDfc/gWVOiwkPXTArTAhGahf3Xfoz9TovYi9jjFJ2li?=
 =?us-ascii?Q?U03G9GeHaKhprSFW4B0nA83buDcc8q6vApWBuDf9gFpYMWQ4wo4XBfIezU6Z?=
 =?us-ascii?Q?WDFPQBEC3JXIsB00+yRRRXZYyFabl1fRI5Tr6e7LNTcmL43b8DerZ3cZPpkC?=
 =?us-ascii?Q?Ta40HGDADMzjhEHzgNM23vlpASNgqrSjymkQ9tNZzNLOYuE+ovB50XfWn3jk?=
 =?us-ascii?Q?T7sHN7xX22balEu4Y9coBuD+Jj4BMILyyipJ8xWWGSjQuF/wuSfDGKMQh426?=
 =?us-ascii?Q?KkrMRVXWny/GvtQ8pMpVSyRvelXzzBUX41RNlCe4SQyGd3Ote+gtVpMPk2Gw?=
 =?us-ascii?Q?P5dEAE2MZfX7OB6oyA7bYQs8+hh7f5BX3TVxyJLa+PoNugc1fT4a4mARUq4h?=
 =?us-ascii?Q?/8idASkUom+ncP83ESYQG1otMB7lL935ezedieSv4B/O/NmyFd0Hb56LwtfF?=
 =?us-ascii?Q?QtmOnYz2RGGAQKEwtlxpWoJbViIwx1wBOGiaW2FGktF/25CNlGx7iIyF2D39?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bc91a2-05f4-4ba4-18e5-08dbaa27ec1b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 13:41:04.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn+mCR49mKbkzj9drUiNhxtYOxppxlQAAWWg6iu8+de/rqV4n9MsjM+26C/SPvvD9KH/XlXBEG5iUGBtrLL+eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:possible_recursive_locking_detected" on:

commit: 2730245bd6b13a94a67e84c10832a9f52fad0aa5 ("[PATCH v2 5/6] maple_tree: Update check_forking() and bench_forking()")
url: https://github.com/intel-lab-lkp/linux/commits/Peng-Zhang/maple_tree-Add-two-helpers/20230830-205847
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20230830125654.21257-6-zhangpeng.00@bytedance.com/
patch subject: [PATCH v2 5/6] maple_tree: Update check_forking() and bench_forking()

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308312115.cad34fed-oliver.sang@intel.com


[   25.146957][    T1] WARNING: possible recursive locking detected
[   25.147110][    T1] 6.5.0-rc4-00632-g2730245bd6b1 #1 Tainted: G                TN
[   25.147110][    T1] --------------------------------------------
[   25.147110][    T1] swapper/1 is trying to acquire lock:
[ 25.147110][ T1] ffffffff86485058 (&mt->ma_lock){+.+.}-{2:2}, at: check_forking (include/linux/spinlock.h:? lib/test_maple_tree.c:1854) 
[   25.147110][    T1]
[   25.147110][    T1] but task is already holding lock:
[ 25.147110][ T1] ffff888110847a30 (&mt->ma_lock){+.+.}-{2:2}, at: check_forking (include/linux/spinlock.h:351 lib/test_maple_tree.c:1854) 
[   25.147110][    T1]
[   25.147110][    T1] other info that might help us debug this:
[   25.147110][    T1]  Possible unsafe locking scenario:
[   25.147110][    T1]
[   25.147110][    T1]        CPU0
[   25.147110][    T1]        ----
[   25.147110][    T1]   lock(&mt->ma_lock);
[   25.147110][    T1]
[   25.147110][    T1]  *** DEADLOCK ***
[   25.147110][    T1]
[   25.147110][    T1]  May be due to missing lock nesting notation
[   25.147110][    T1]
[   25.147110][    T1] 1 lock held by swapper/1:
[ 25.147110][ T1] #0: ffff888110847a30 (&mt->ma_lock){+.+.}-{2:2}, at: check_forking (include/linux/spinlock.h:351 lib/test_maple_tree.c:1854) 
[   25.147110][    T1]
[   25.147110][    T1] stack backtrace:
[   25.147110][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                TN 6.5.0-rc4-00632-g2730245bd6b1 #1
[   25.147110][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   25.147110][    T1] Call Trace:
[   25.147110][    T1]  <TASK>
[ 25.147110][ T1] dump_stack_lvl (lib/dump_stack.c:? lib/dump_stack.c:106) 
[ 25.147110][ T1] validate_chain (kernel/locking/lockdep.c:?) 
[ 25.147110][ T1] ? look_up_lock_class (kernel/locking/lockdep.c:926) 
[ 25.147110][ T1] ? mark_lock (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:4655) 
[ 25.147110][ T1] __lock_acquire (kernel/locking/lockdep.c:?) 
[ 25.147110][ T1] lock_acquire (kernel/locking/lockdep.c:5753) 
[ 25.147110][ T1] ? check_forking (include/linux/spinlock.h:? lib/test_maple_tree.c:1854) 
[ 25.147110][ T1] _raw_spin_lock (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
[ 25.147110][ T1] ? check_forking (include/linux/spinlock.h:? lib/test_maple_tree.c:1854) 
[ 25.147110][ T1] check_forking (include/linux/spinlock.h:? lib/test_maple_tree.c:1854) 
[ 25.147110][ T1] maple_tree_seed (lib/test_maple_tree.c:3583) 
[ 25.147110][ T1] do_one_initcall (init/main.c:1232) 
[ 25.147110][ T1] ? __cfi_maple_tree_seed (lib/test_maple_tree.c:3508) 
[ 25.147110][ T1] do_initcall_level (init/main.c:1293) 
[ 25.147110][ T1] do_initcalls (init/main.c:1307) 
[ 25.147110][ T1] kernel_init_freeable (init/main.c:1550) 
[ 25.147110][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 25.147110][ T1] kernel_init (init/main.c:1439) 
[ 25.147110][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 25.147110][ T1] ret_from_fork (arch/x86/kernel/process.c:151) 
[ 25.147110][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 25.147110][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[   25.147110][    T1]  </TASK>
[   28.697241][   T32] clocksource_wdtest: --- Verify jiffies-like uncertainty margin.
[   28.698316][   T32] clocksource: wdtest-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[   29.714980][   T32] clocksource_wdtest: --- Verify tsc-like uncertainty margin.
[   29.716387][   T32] clocksource: wdtest-ktime: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[   29.721896][   T32] clocksource_wdtest: --- tsc-like times: 1693478138832947444 - 1693478138832945950 = 1494.
[   29.723570][   T32] clocksource_wdtest: --- Watchdog with 0x error injection, 2 retries.
[   31.898906][   T32] clocksource_wdtest: --- Watchdog with 1x error injection, 2 retries.
[   34.043415][   T32] clocksource_wdtest: --- Watchdog with 2x error injection, 2 retries, expect message.
[   34.512462][    C0] clocksource: timekeeping watchdog on CPU0: kvm-clock retried 2 times before success
[   36.169157][   T32] clocksource_wdtest: --- Watchdog with 3x error injection, 2 retries, expect clock skew.
[   36.513464][    C0] clocksource: timekeeping watchdog on CPU0: wd-wdtest-ktime-wd excessive read-back delay of 1000880ns vs. limit of 125000ns, wd-wd read-back delay only 46ns, attempt 3, marking wdtest-ktime unstable
[   36.516829][    C0] clocksource_wdtest: --- Marking wdtest-ktime unstable due to clocksource watchdog.
[   38.412889][   T32] clocksource: wdtest-ktime: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[   38.421249][   T32] clocksource_wdtest: --- Watchdog clock-value-fuzz error injection, expect clock skew and per-CPU mismatches.
[   38.990462][    C0] clocksource: timekeeping watchdog on CPU0: Marking clocksource 'wdtest-ktime' as unstable because the skew is too large:
[   38.992698][    C0] clocksource:                       'kvm-clock' wd_nsec: 479996388 wd_now: 9454aecf2 wd_last: 928aec30e mask: ffffffffffffffff
[   38.994924][    C0] clocksource:                       'wdtest-ktime' cs_nsec: 679996638 cs_now: 17807167426ff864 cs_last: 1780716719e80b86 mask: ffffffffffffffff
[   38.997374][    C0] clocksource:                       Clocksource 'wdtest-ktime' skewed 200000250 ns (200 ms) over watchdog 'kvm-clock' interval of 479996388 ns (479 ms)
[   38.999919][    C0] clocksource:                       'kvm-clock' (not 'wdtest-ktime') is current clocksource.
[   39.001696][    C0] clocksource_wdtest: --- Marking wdtest-ktime unstable due to clocksource watchdog.
[   40.441815][   T32] clocksource: Not enough CPUs to check clocksource 'wdtest-ktime'.
[   40.443303][   T32] clocksource_wdtest: --- Done with test.
[  293.673815][    T1] swapper invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
[  293.675628][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                TN 6.5.0-rc4-00632-g2730245bd6b1 #1
[  293.677082][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  293.677082][    T1] Call Trace:
[  293.677082][    T1]  <TASK>
[ 293.677082][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 293.677082][ T1] dump_header (mm/oom_kill.c:?) 
[ 293.677082][ T1] out_of_memory (mm/oom_kill.c:1159) 
[ 293.677082][ T1] __alloc_pages_slowpath (mm/page_alloc.c:3372 mm/page_alloc.c:4132) 
[ 293.677082][ T1] __alloc_pages (mm/page_alloc.c:4469) 
[ 293.677082][ T1] alloc_slab_page (mm/slub.c:1866) 
[ 293.677082][ T1] new_slab (mm/slub.c:2017 mm/slub.c:2062) 
[ 293.677082][ T1] ? mas_alloc_nodes (lib/maple_tree.c:1282) 
[ 293.677082][ T1] ___slab_alloc (arch/x86/include/asm/preempt.h:80 mm/slub.c:3216) 
[ 293.677082][ T1] ? mas_alloc_nodes (lib/maple_tree.c:1282) 
[ 293.677082][ T1] kmem_cache_alloc_bulk (mm/slub.c:? mm/slub.c:4041) 
[ 293.677082][ T1] mas_alloc_nodes (lib/maple_tree.c:1282) 
[ 293.677082][ T1] mas_nomem (lib/maple_tree.c:?) 
[ 293.677082][ T1] mtree_store_range (lib/maple_tree.c:6191) 
[ 293.677082][ T1] check_dup_gaps (lib/test_maple_tree.c:2623) 
[ 293.677082][ T1] check_dup (lib/test_maple_tree.c:2707) 
[ 293.677082][ T1] maple_tree_seed (lib/test_maple_tree.c:3766) 
[ 293.677082][ T1] do_one_initcall (init/main.c:1232) 
[ 293.677082][ T1] ? __cfi_maple_tree_seed (lib/test_maple_tree.c:3508) 
[ 293.677082][ T1] do_initcall_level (init/main.c:1293) 
[ 293.677082][ T1] do_initcalls (init/main.c:1307) 
[ 293.677082][ T1] kernel_init_freeable (init/main.c:1550) 
[ 293.677082][ T1] ? __cfi_kernel_init (init/main.c:1429) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230831/202308312115.cad34fed-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

