Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331057255FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 09:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbjFGHjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjFGHjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:39:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF3A30D4;
        Wed,  7 Jun 2023 00:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686123440; x=1717659440;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zs55pRndfcvTrIXdjZ2XRXLtREKBwPifyha8GUhyp5g=;
  b=WBOL5ERPVb0lBzk6NaYAFRDwokacByBvaruV06XmkDz5/wn3JwfZnQmt
   fp0O/8SP2hdw9g5GuzUcxIo2T0LQV1avVr++c9bPAI5dwe+TQM2m2qTl5
   DzaDFXI6/fliee8EdBzotHLAsbh34LHpblpZ/mIwo75ExsdO5QieAZLts
   Pe85iSGamFY1dA9QHq9p07mRMe4WYOysiKYMCV/51xs5+taotURuuiF/n
   hKaeiNF7hOOF4yKSvFCx1ytIqk4C4Wh4GpWg+HAhQp3lIaWTbYwdQDAbr
   XuUOWicByMcNR5lSDxEVagqojV2LjqlMaXf4pkzSrKdv7eLOqf9zCdIWw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="356925646"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="356925646"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 00:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="742500696"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="742500696"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2023 00:37:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 00:37:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 00:37:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 00:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLvpeQz2QB4z2PkwqbT7WMGkf/Zzran4mVVEuOaPMkOaFTvH9guxnliG1LuP33yBE+IVe4kleRVsgbVb0Ftse8bqyKKdwit+/FfOwNTZiUIjVHcnCtiyyiOAVPqeC7JjXbykxscd+C8UEPmD+CHz27zcvfAcuBOQrLZdhZ9JgJ8lGPQC447oDiD0NjIoXI8tN0eHr/KOXp4eU9Uib6gaQmrz507TyG0RCYX222GnpwCdVqSGAmRS8f7viENE5UxING9AY6dkAdnI5AA3xvx8ffsIxbMI0Z1DExkgpfXvN8dMQzlAG5uAYp+LdinFzJGOxDabQxPKonUdgWSbU6kdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL3HjAaHSbBrqQHlHjE9tS+sS5JTdQ9OtSu2rH0g6B8=;
 b=B4KU29mKGecmeipGy9jv0NCugC6+l+rb1HYSkJFOG4F+tgJdNi7/L0jnVGn58Idgivw3mfwoIcknXayRkHOcCIEJfv0HIT9VFj9fEzqmKcD48fGbtHszM+0qVjd9PT9+9012gEr8BU6VQO6csN1X220kkqBq65rAjou0dqM9eIwJCeZDVuxtIi2In7gaTTKoaDbpFn/XQCbuMB+QF05CLEgtyMQz1MXud0nj3usoEK+z73WCNdKR651yJvN4tWkhZUHIW/LUX4RQxqipGNaTHvVYlaTNuwlU/gBK5vMllZcZCYgSNnrGqF4tQx2sJYjg4BRoEACGOuuvJv/AYmxQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 07:37:10 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 07:37:10 +0000
Date:   Wed, 7 Jun 2023 15:33:57 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Kirill Tkhai <tkhai@ya.ru>
CC:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <vbabka@suse.cz>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <djwong@kernel.org>, <hughd@google.com>, <paulmck@kernel.org>,
        <muchun.song@linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <zhengqi.arch@bytedance.com>,
        <david@fromorbit.com>
Subject: Re: [PATCH v2 2/3] mm: Split unregister_shrinker() in fast and slow
 part
Message-ID: <ZIAy5T9zUI5pi+uc@yujie-X299>
References: <168599179360.70911.4102140966715923751.stgit@pro.pro>
 <202306071000.4ad4e5ba-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202306071000.4ad4e5ba-oliver.sang@intel.com>
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH8PR11MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c8588a-fe3d-418b-e9e1-08db672a00b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbCaIXCCNJdi9BYrLArDtI15avF8F3bZDUepMkyZ3wQcE0NTQIsI4TUX1HpZuqbUF3jqZtDuLGcMEgcxy2G0XipzxCEMCMl1jLIxRMpA0IdXODNhMi+u0BopdcEUuCRGk+F1PY5pfT24YP3wt+nfSjEUseFkiKiqmtC62sgBjaq29VzAhWtY9tENcQ/dtVAIlhIqWURXouxWgLeGr+So8fAIXKqrun5J8JMGMpaIxwwts0gc/gZK+pQtQC1YLFOokpWrH2YpBDmSXGB0fXQutQbAnmY9tGkmA0vMbC4fIrhgrH2ClAffc4nKTaNQ+PQk10N4aHkX+k+GzciCjbmxm7Aff6voYT4/lqCXiMR4RrUfj/7djXiUQDjixWfYDfvQMdlIUZ4vrMSLYgPF21ty07DrDWIQYXXG/i0KdfdDAE2un4AXKkDfN5ZlBvDkLKVt+dBQnwN+hQNjsHE6EMhI8Q8sHw8ZMRIijoomyQ//cUQL04I/tYSaK1NpHG1nR/uJzMY5o/A4dWqWhQO1AlIuyONJn+sHbK5E8rTkmcR2jl7tYO3jrSws0wQUmGK+NeCA6TuA3TmzfJOKNPOqHjuPgTCKi1dldN3j/C7p2GY62YT8QrQRH5EHoeLOq0xV5PiY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(83380400001)(2906002)(33716001)(86362001)(82960400001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(966005)(8936002)(8676002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6506007)(9686003)(6512007)(45080400002)(26005)(186003)(7416002)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LXFQTUf8BXGhlvPwUsv3HMV6qnsMCJ198sjNTvCyf22WzutkfjKDauBhROas?=
 =?us-ascii?Q?f4leT9qmgLsQY0E2WtN9mLPCqGitDC2GbUGf2gdh72aZlB5pD4zya901An5J?=
 =?us-ascii?Q?SRrQqTJM548AeB7qtiBM+GqeaefltqjZOwJJ4nh8uqD6m5gy0F0W+sAw5FI+?=
 =?us-ascii?Q?1x44L6snPL/HKASquD5nC/hPdApWzSRxzJm/tZGVPrZN6dp326VUJYXWR5Xy?=
 =?us-ascii?Q?wmp8h21KAhD2ocSGjG28EeT1+eYYmdZoanmt6yoC3ZQhVewcFqJOyEnJTyid?=
 =?us-ascii?Q?eVkQRwjH1P5lYlZmLV+WtpbPt3rKVmzc++hnr2+I+O3E+Fv61MOdz4WRHtvF?=
 =?us-ascii?Q?VjKNQe9MgtAh46oQvBewKF/f3ze9ywz/XO0sW15DGHUAnry0iGvgrQ4d3B/2?=
 =?us-ascii?Q?bV73CMCNjHiquS3Gy1wTAz4ktlCJVx3tQLSuKAodYuQfDqGe000rlqf9ebFM?=
 =?us-ascii?Q?px51krg3rluH4VtdWdgfAbv6Oew5q+emaIz68Cr9U9fw7JCK/Wu+hoznhqO9?=
 =?us-ascii?Q?oddq6FmSzfa8/XvYZIPthqq0ISVPKuN4efACkgU7NszTP9ZTq3XcMgQfg477?=
 =?us-ascii?Q?hYhbV4if8coqCY25Ae5dJaPFfUu/j1ODEJsKVyLxig0gQPPRbZSyIZOFhjMc?=
 =?us-ascii?Q?S9gOjmSFJ0iZeBCTkH+LnEUs62sME7yQ8scV7qwUuQKJiNBTEgHeWHB6kWQa?=
 =?us-ascii?Q?WlwWIqJTK+O9oReU/nRIH6ovYvEuEYQ2BLVMLnDlmJhOcJQRDICC8vsjxc4T?=
 =?us-ascii?Q?44whkU0bIUHgLtcq6KuEM7PnL3Y1qQE4MqF5Q4/pPMBmecvM9Q2kkjNtOrZa?=
 =?us-ascii?Q?CP8BcLE+rQ6doLT05nxc8/cduQIoGu1iNw6irriQcRr9JPj3inVv8WGMYX5E?=
 =?us-ascii?Q?euqGKDyFOK1V5t092E/0xiHmrmmJmh7Dhtz3hG91d9uD4GkXkEESZtSAKfiZ?=
 =?us-ascii?Q?U/FXl7JHGR1/fPZ5gYJUgd5bi+vcJVMxMNMQDomLFSUQm9SH8B92IncJiGBL?=
 =?us-ascii?Q?hNcBKk11Gh8jTw4/thysaiPiNjbinlvezM00u7W/LaEV0noX1mJ5UcB8rQiZ?=
 =?us-ascii?Q?tbi7LKEfglYe7346ai+L1C8CoM/ItGMz3VuKuYZD7Znk+luvfzsa9iL4ACSP?=
 =?us-ascii?Q?AlZDXgV+InMTLCA9IvVUKDdhNeYD7hudcuDWkgKhW4s0GjmlM2yBTOu1EYCF?=
 =?us-ascii?Q?ThqtGj3+0YNpqQG9sIzeKd1iVUx6d5CsTc64SXg2T2udPy+mkt7FraANYx7U?=
 =?us-ascii?Q?a4Yetw8Qt3j07Ez2BvRozaWrMvFHweDkYmH3u+G8aYp+TmZJTPZIGjF/fG7E?=
 =?us-ascii?Q?8RoQiyA/waBdGJgKBUoaRsh+yb84yG2PdMPR0Z+6e/VxhaijOaFU9Fcgziwu?=
 =?us-ascii?Q?OKr2BsDqJeUsN6H8JSSPlSH8w/74K2CGPdUTh6lYwZiTg6xbjp5fOCV3Mbn/?=
 =?us-ascii?Q?AhO+UtToagRAvyFqaQPxAxdNHA+AJs/o/sSjXtVpvV+v9JKaaMY0y6QkGGiQ?=
 =?us-ascii?Q?jPplBN4bXT/TCrhmI6Npktd3tSR47uMWxdcqM8UIcRZOLPdseiOG5HXWVuGl?=
 =?us-ascii?Q?DuUVlj7A4lXugx/JBTmnc4LAvWSJoBNRjspPG6NH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c8588a-fe3d-418b-e9e1-08db672a00b3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 07:37:10.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ka047fQOBAIKcsEY5AkxAYnBHB0bV7FJ0jEAFmEBhxPmA5FaycR3XSFViRfxj5Sn1QaKaa3u3wBHl3E4fhnzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:49:55PM +0800, kernel test robot wrote:
> 
> Hello,
> 
> kernel test robot noticed "INFO:trying_to_register_non-static_key" on:
> 
> commit: 107ed33204f77282d67b90f5c37f34c4b1ec9ffb ("[PATCH v2 2/3] mm: Split unregister_shrinker() in fast and slow part")
> url: https://github.com/intel-lab-lkp/linux/commits/Kirill-Tkhai/mm-vmscan-move-shrinker_debugfs_remove-before-synchronize_srcu/20230606-030419
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git f8dba31b0a826e691949cd4fdfa5c30defaac8c5
> patch link: https://lore.kernel.org/all/168599179360.70911.4102140966715923751.stgit@pro.pro/
> patch subject: [PATCH v2 2/3] mm: Split unregister_shrinker() in fast and slow part
> 
> in testcase: boot
> 
> compiler: clang-15
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202306071000.4ad4e5ba-oliver.sang@intel.com

Sorry the stacktrace in the report was broken due to a toolchain issue
in the bot. Please check the correct stacktrace as below:

[ 0.538549][ T0] INFO: trying to register non-static key.
[ 0.539249][ T0] The code is fine but needs lockdep annotation, or maybe
[ 0.539385][ T0] you didn't initialize this object before use?
[ 0.539385][ T0] turning off the locking correctness validator.
[ 0.539385][ T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc5-00004-g107ed33204f7 #1
[ 0.539385][ T0] Call Trace:
[ 0.539385][ T0] dump_stack_lvl (lib/dump_stack.c:?)
[ 0.539385][ T0] dump_stack (lib/dump_stack.c:113)
[ 0.539385][ T0] assign_lock_key (kernel/locking/lockdep.c:?)
[ 0.539385][ T0] register_lock_class (kernel/locking/lockdep.c:?)
[ 0.539385][ T0] __lock_acquire (kernel/locking/lockdep.c:4965)
[ 0.539385][ T0] ? lock_acquire (kernel/locking/lockdep.c:5705)
[ 0.539385][ T0] ? register_shrinker_prepared (mm/vmscan.c:760)
[ 0.539385][ T0] ? __might_resched (kernel/sched/core.c:10115)
[ 0.539385][ T0] lock_acquire (kernel/locking/lockdep.c:5705)
[ 0.539385][ T0] ? register_shrinker_prepared (mm/vmscan.c:762)
[ 0.539385][ T0] ? __might_resched (kernel/sched/core.c:10115)
[ 0.539385][ T0] down_write (kernel/locking/rwsem.c:1573)
[ 0.539385][ T0] ? register_shrinker_prepared (mm/vmscan.c:762)
[ 0.539385][ T0] register_shrinker_prepared (mm/vmscan.c:762)
[ 0.539385][ T0] sget_fc (fs/super.c:616)
[ 0.539385][ T0] ? kill_litter_super (fs/super.c:1121)
[ 0.539385][ T0] ? shmem_reconfigure (mm/shmem.c:3791)
[ 0.539385][ T0] get_tree_nodev (fs/super.c:1144)
[ 0.539385][ T0] shmem_get_tree (mm/shmem.c:3879)
[ 0.539385][ T0] vfs_get_tree (fs/super.c:1511)
[ 0.539385][ T0] vfs_kern_mount (fs/namespace.c:1036 fs/namespace.c:1065)
[ 0.539385][ T0] kern_mount (fs/namespace.c:4455)
[ 0.539385][ T0] shmem_init (mm/shmem.c:4106)
[ 0.539385][ T0] mnt_init (fs/namespace.c:4440)
[ 0.539385][ T0] vfs_caches_init (fs/dcache.c:3355)
[ 0.539385][ T0] start_kernel (init/main.c:1071)
[ 0.539385][ T0] i386_start_kernel (arch/x86/kernel/head32.c:56)
[ 0.539385][ T0] startup_32_smp (arch/x86/kernel/head_32.S:319)
[ 0.539391][ T0] ------------[ cut here ]------------
[ 0.540097][ T0] DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0, owner = 0x81d77c00, curr 0x81d77c00, list not empty
[ 0.540405][ T0] WARNING: CPU: 0 PID: 0 at kernel/locking/rwsem.c:1364 up_write (kernel/locking/rwsem.c:1364)
[ 0.541389][ T0] Modules linked in:
[ 0.542390][ T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc5-00004-g107ed33204f7 #1
[ 0.543389][ T0] EIP: up_write (kernel/locking/rwsem.c:1364)
[ 0.543920][ T0] Code: ee 8f c6 81 39 c1 74 05 bb 7f 8b c4 81 53 52 ff 74 24 08 57 ff 74 24 14 68 44 a3 cb 81 68 6d 1a ce 81 e8 32 68 fb ff 83 c4 1c <0f> 0b 39 f7 0f 85 a8 fe ff ff e9 a8 fe ff ff 0f 0b e9 db fe ff ff
All code
========
 0:     ee      out %al,(%dx)
 1:     8f c6   pop %rsi
 3:     81 39 c1 74 05 bb       cmpl $0xbb0574c1,(%rcx)
 9:     7f 8b   jg 0xffffffffffffff96
 b:     c4 81 53 52     (bad)
 f:     ff 74 24 08     push 0x8(%rsp)
 13:    57      push %rdi
 14:    ff 74 24 14     push 0x14(%rsp)
 18:    68 44 a3 cb 81  push $0xffffffff81cba344
 1d:    68 6d 1a ce 81  push $0xffffffff81ce1a6d
 22:    e8 32 68 fb ff  call 0xfffffffffffb6859
 27:    83 c4 1c        add $0x1c,%esp
 2a:*   0f 0b   ud2             <-- trapping instruction
 2c:    39 f7   cmp %esi,%edi
 2e:    0f 85 a8 fe ff ff       jne 0xfffffffffffffedc
 34:    e9 a8 fe ff ff  jmp 0xfffffffffffffee1
 39:    0f 0b   ud2
 3b:    e9 db fe ff ff  jmp 0xffffffffffffff1b

Code starting with the faulting instruction
===========================================
 0:     0f 0b   ud2
 2:     39 f7   cmp %esi,%edi
 4:     0f 85 a8 fe ff ff       jne 0xfffffffffffffeb2
 a:     e9 a8 fe ff ff  jmp 0xfffffffffffffeb7
 f:     0f 0b   ud2
 11:    e9 db fe ff ff  jmp 0xfffffffffffffef1
[ 0.544391][ T0] EAX: e6de3575 EBX: 81c48b7f ECX: e6de3575 EDX: 81d67dd0
[ 0.545388][ T0] ESI: 831f4c4c EDI: 00000000 EBP: 81d67ed0 ESP: 81d67ea8
[ 0.546389][ T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210292
[ 0.547388][ T0] CR0: 80050033 CR2: ffd98000 CR3: 02280000 CR4: 00040690
[ 0.548392][ T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[ 0.549388][ T0] DR6: fffe0ff0 DR7: 00000400
[ 0.549947][ T0] Call Trace:
[ 0.550391][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:478)
[ 0.550910][ T0] ? up_write (kernel/locking/rwsem.c:1364)
[ 0.551389][ T0] ? __warn (kernel/panic.c:235 kernel/panic.c:673)
[ 0.551869][ T0] ? up_write (kernel/locking/rwsem.c:1364)
[ 0.552389][ T0] ? up_write (kernel/locking/rwsem.c:1364)
[ 0.552921][ T0] ? report_bug (lib/bug.c:199)
[ 0.553390][ T0] ? exc_overflow (arch/x86/kernel/traps.c:337)
[ 0.554390][ T0] ? handle_bug (arch/x86/kernel/traps.c:324)
[ 0.554923][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:345)
[ 0.555390][ T0] ? handle_exception (arch/x86/entry/entry_32.S:1076)
[ 0.556022][ T0] ? arch_report_meminfo (arch/x86/mm/pat/set_memory.c:112)
[ 0.556389][ T0] ? exc_overflow (arch/x86/kernel/traps.c:337)
[ 0.557389][ T0] ? up_write (kernel/locking/rwsem.c:1364)
[ 0.557927][ T0] ? exc_overflow (arch/x86/kernel/traps.c:337)
[ 0.558389][ T0] ? up_write (kernel/locking/rwsem.c:1364)
[ 0.558904][ T0] register_shrinker_prepared (mm/vmscan.c:765)
[ 0.559390][ T0] sget_fc (fs/super.c:616)
[ 0.559887][ T0] ? kill_litter_super (fs/super.c:1121)
[ 0.560390][ T0] ? shmem_reconfigure (mm/shmem.c:3791)
[ 0.561390][ T0] get_tree_nodev (fs/super.c:1144)
[ 0.562390][ T0] shmem_get_tree (mm/shmem.c:3879)
[ 0.563390][ T0] vfs_get_tree (fs/super.c:1511)
[ 0.563914][ T0] vfs_kern_mount (fs/namespace.c:1036 fs/namespace.c:1065)
[ 0.564390][ T0] kern_mount (fs/namespace.c:4455)
[ 0.564908][ T0] shmem_init (mm/shmem.c:4106)
[ 0.565389][ T0] mnt_init (fs/namespace.c:4440)
[ 0.565892][ T0] vfs_caches_init (fs/dcache.c:3355)
[ 0.566390][ T0] start_kernel (init/main.c:1071)
[ 0.567390][ T0] i386_start_kernel (arch/x86/kernel/head32.c:56)
[ 0.568009][ T0] startup_32_smp (arch/x86/kernel/head_32.S:319)
[ 0.568392][ T0] irq event stamp: 1613
[ 0.568888][ T0] hardirqs last enabled at (1613): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[ 0.569389][ T0] hardirqs last disabled at (1612): _raw_spin_lock_irqsave (arch/x86/include/asm/preempt.h:80 include/linux/spinlock_api_smp.h:109 kernel/locking/spinlock.c:162)
[ 0.570389][ T0] softirqs last enabled at (1480): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147)
[ 0.571389][ T0] softirqs last disabled at (1473): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147)
[ 0.572389][ T0] ---[ end trace 0000000000000000 ]---



