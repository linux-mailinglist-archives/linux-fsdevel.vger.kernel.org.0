Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADED6861D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 09:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjBAIjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 03:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjBAIjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:39:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BED4346F;
        Wed,  1 Feb 2023 00:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675240780; x=1706776780;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zo8dA526r8YElyja6Ckth0eHvJWjaS1T4BoodPrftC0=;
  b=lUsLxMJnUXuGCdb78qGVjjFWUAVwC5I4UitaOIpeC4qDLNV+5L7uenRA
   /ahA2eypgxtTQndhpK5oI7aWQQpGPkTLHFuXDyS1byKgbiI8+4H0pDpJq
   bvbEtzr9tMuI5qrTavpiCajWz/CoguOXp51ZyT3Od2gUj7SJJBjqonuoz
   +oUAQ52xB3sodjYQyqWRwLiVszojBki/SpL0hcBGyVR7cT9G3fZRAaRpG
   eJQzPkM/7p9RFDqsMOfPAlBeWuYxSLnXzf9I4VzXTQajV9lJgCjBzJ1Um
   rOu1kGPRiEqeG04ufwR8VS1+XpvNfPAuS6rMB00BQWOZHpAKx5WN7+LyS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="316081370"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="316081370"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 00:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="658236983"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="658236983"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2023 00:39:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 00:39:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 00:39:39 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 00:39:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhCJy4V+1nC9fsy88D9XNMgeXQ+E0iCW0W0kScP3YKdh6aqXdro4PgBvK+Qr2gfPaCwNVCXfOI+JiWiJVl+wmTLkFkuzptOemMB2A0Z8L7Wt1hGVqmqbQ7TdOIeSMS7LqxSVmPwR5pwccf0rrryJG6g+aJpWN7vp0W07qfrDpEqpmd/z090gzFb9wxk88aDv0AhgVo6MxYTDjVthbyDjlpLm01eh70r4TLAzTYqrsXo4RzTD3aA92JJt41efoYASadgYyUTFDvVtZ3AcYRer2ajx3LzxC4SRl/Rv6T5GJqj2grKyRRNa7AyErnRoQsTdDcXKk4lQtmW1ylnNPqyVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5i3wz025xAdFHvpcAImu0UqoUr9Gk41E5qbkcHAvVc=;
 b=HaQRipiIf+EzS35ixwD63+s28ub9tdFTF0WBMRb522UFcNh7e4GhBPm8H89iJ4eKGfG0pmFdVidIe+Aqe9yuc8OCc3aB3rlTBGSYPV+T2111GDhWOj+1o2KhCzbiZXyd66dR45JMqgIG/9FfUgZJpWBq3MZGpmJRHvbkuhCupnV3K0OhjKteqxxLIBiRMMZstc5/PB45QRYcUKC4P1y6kRM3z7s6YQXzVx+rJz5n7XfrirV+rpBKsxJdP/o/pnLnJzYTswL0rkUfE85MVGmkQBa0kIs5Affa53F5HuQYNOFMZA/+wgjolHDQyA3fOjnzrpWVM5Hb4t5zzpPsoSSJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 08:39:37 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%6]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 08:39:37 +0000
Date:   Wed, 1 Feb 2023 16:37:00 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [linus:master] [maple_tree] 120b116208:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <Y9okrO+GOYP2Gh4K@yujie-X299>
References: <202301310940.4a37c7af-yujie.liu@intel.com>
 <20230131202635.GA3019407@paulmck-ThinkPad-P17-Gen-1>
 <20230131204520.ad6cf4lvtw5uf27s@revolver>
 <20230131205221.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230131205221.GX2948950@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CO1PR11MB4835:EE_
X-MS-Office365-Filtering-Correlation-Id: 987ae70e-af2d-4d33-8b9f-08db042fd974
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1D2yBjz1WAv3pMP+hLy5wbC2NLqGtkm09eEMuMiOaiAwi85upd2vkaJeZYliW1o55j+elkLKV7wtOFIJRNUXi3uiYYQjGlotCOj18ajgu2/C57r0l0XvAuZJGXv84Q6gkS/qbTIlAV9BnZFGLY78L8OcbMbtm40Sg9LYQIl7ka5MLkolJwckb0wMHgBn3+wbB5cl2V/Nazoepvm3VShHkmEDAYNMJdcHsaSHzPsStGUaOwHkjip4TTOitUBbkToAZq8CnTt9Wn4R+/UV9oEZgNQPlfaveX/AijiXjlL9ODUUMSgDvV6JRpXbg9Gqw9NClaY+BJvvY/MbruzgnWbiutiuufL3wg/4fyAWDoRrL03ndB2p74kdwwRl3DSKf4Op1MY7WfNS4aJcJPvnomwL7goO1fxn9d/FEnPE6oTMD64h74BLCNLkCat1VBXSMuatOg6ddrb22F3ScgYenn1ihGZvd0JwMmfNkchP5wzwya9OUiiYP4zDx+uk11reZBgsnhmLGlg3CntNdadPQRYm2Wq6nbXrrnJ8zk3uZmnidTf5Bdqv5YsgjCnddQohecjT/5n+cS8ukEVkO0HdnMEQz+I7aX0YKUbz79rddA4ZGIybhE+vi+3kDorqD7IJR96c3SMPywkiImqt/snTjTGJhRujJVDuJtKZp0TFyc0mD+Z+Xugg2PmAnqFte3ELx9JN1sw9tJhU8pzDE9dUY3DP+OZiS4hXBb6LLcTS9Q9CiT+E551MrV3cA507d9rrruq8DzQwkSZB6WNGQ8zA/8JgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199018)(83380400001)(66899018)(2906002)(44832011)(41300700001)(6486002)(966005)(9686003)(6512007)(33716001)(26005)(186003)(8936002)(6506007)(5660300002)(110136005)(316002)(38100700002)(478600001)(6666004)(82960400001)(86362001)(66556008)(4326008)(66946007)(66476007)(8676002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d9aDzOpGJfrAIobOil6fgKEs/L3iHLDNXdHEyUkFyVO6VpYhyLqHuutIivkk?=
 =?us-ascii?Q?eb0PYYRs3XRP8vuBeF/BiK42riI6NtfWX+jbuBoxaK3PnP+FLqM5cqrrLpl1?=
 =?us-ascii?Q?GjwBMx3Epuy6LuyTBUD+jnTEmBwevabyu9r4JvuGycYhLAmFpk0caZnNIzrn?=
 =?us-ascii?Q?hczd+KQWHUq1XpR1+w85QgomXq/ymgMbZnmdwpG0M3NKzlKFJLz3r1Kps4DC?=
 =?us-ascii?Q?jbVQY3vVHHieh8Wrcuq8kJMczO4jR6b4ANHHGvR3UnD49MOs/iSfTO2otogT?=
 =?us-ascii?Q?NbZwQFffaCbd3Z4fZGrE8GDEEF9RcoSo/hZRVHsEFLH90GhjCwZbvbs3JoTk?=
 =?us-ascii?Q?yo84i0SL5CoP7l4RacB3lzbpsXe4vzys2nrT5JB6RMBqSRi3q0SAO2myes0X?=
 =?us-ascii?Q?JNJ0c3wGs3HJ2mN+OX7YR2LZ+72W00Ebne7He7Tx6wvj7ac8S38NdbsN9vuc?=
 =?us-ascii?Q?sD9Mdvs0GGDHdmHjLMXyRwFWfmPH2Ul9IbLbCaA9q0oAEREgRcnG+qGPK9Zx?=
 =?us-ascii?Q?Sxz0k9snSkHr6YO6+cYkD7IZ2bqfbWG+c6u8MMKQ2AXiqGe6c5gpIPqsejq0?=
 =?us-ascii?Q?3Q099NkK+b/bSwvU6ojhj2QnKcefy/kr0IMhYi+MI2iYXO/LgbG0BqcQzVbc?=
 =?us-ascii?Q?EJ1jOXZDo0krBo6PdSnyiE68H2XyDXaNUDXgR87Xd2FkMAotA93MgyXUs/qI?=
 =?us-ascii?Q?b0TRLhs8nh+6/wuUPd8wc5fsFgUE/podp0RzxJdkwXxOq++JPw+lcTyvHN8e?=
 =?us-ascii?Q?ZD8lD9mM3fDxaQI/gGreLJ+p4wP74ves6WheHVQI5KEKNhAxNBcmxKFVv8hx?=
 =?us-ascii?Q?yg6so7FA6TfYv+PXQi86cTPZqsAA0Tnr2nDbHyJRhM7rvP5SjbTcyxzkm8qm?=
 =?us-ascii?Q?xuhY3cEo6DswiteWVMPSFvNXHrzPk8/TxQ8IyUQbUOHfR2gyd9b1Tb50Y2Lc?=
 =?us-ascii?Q?TVybuzUfOwjJvXYOdoWKNWHr07oNy13lsE3PRzetxwdbqJQL3eODVLoroiKj?=
 =?us-ascii?Q?//jd1vDl5suQtLMsUOWzTO2VZVOtIII57E61zyUpotygpQJYX0GCMwjaDtuM?=
 =?us-ascii?Q?CzD29u9kiWmugePdqUtTPp2VEK1bNk8PyAXYVfv39lPXywV044zkzJ7FSAIl?=
 =?us-ascii?Q?uHJ+YFmKwH2z99nlJ9bu1wNqU3CW/uMNb0o7tIWgTuBtJy9mz1Zc0d5/MYWa?=
 =?us-ascii?Q?ypwrhuX6hodd6ngJxljr2Q6qNlPmQusNO8TXXA2YSdk7FUZ3b4f2GqNnttIy?=
 =?us-ascii?Q?i0qF4Yc1VmMW+2PA5beRcSEHfeo8lmuV45JVcXYnxfdJbq3CssAQNHCDi5dl?=
 =?us-ascii?Q?doskCPcWGbSnY7oOpfmYlMNALtD1qMoGU1kZpAODqZnKoQmMgLzz8/b9x+VV?=
 =?us-ascii?Q?6wup7Zmsn73F431r5InCVbL7FQ3mwfzrrY6Yc71qPccttFfe5g9uMnBEWYwC?=
 =?us-ascii?Q?MG7eVS5LDX0s1zr0Hsuw+gvIoXefZ73LlsRm1lA0hfbOL/5+gkX7hFfvKNIa?=
 =?us-ascii?Q?I9D8WmFxZxTU9fvX6dX44Dty1WQ8t1V5uUi7SQsPonJMZs4dHpdFTzfGHWQx?=
 =?us-ascii?Q?/RnaE+6p9S5yVaiPK4alTRozPtAZLkoZtbQQErfH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 987ae70e-af2d-4d33-8b9f-08db042fd974
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 08:39:36.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoMIijKcowFhIbjWbPIBM20IvQPO0tphpNWH4q7xPlxzdRlBJDJIpLxZf7HjBy1SAIOs+XflcPGykXo8zRR1OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4835
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

Hi Paul, Hi Liam,

On Tue, Jan 31, 2023 at 12:52:21PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 31, 2023 at 03:45:20PM -0500, Liam R. Howlett wrote:
> > * Paul E. McKenney <paulmck@kernel.org> [230131 15:26]:
> > > On Tue, Jan 31, 2023 at 03:18:22PM +0800, kernel test robot wrote:
> > > > Hi Liam,
> > > > 
> > > > We caught a "task blocked" dmesg in maple tree test. Not sure if this
> > > > is expected for maple tree test, so we are sending this report for
> > > > your information. Thanks.
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed INFO:task_blocked_for_more_than#seconds due to commit (built with clang-14):
> > > > 
> > > > commit: 120b116208a0877227fc82e3f0df81e7a3ed4ab1 ("maple_tree: reorganize testing to restore module testing")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > in testcase: boot
> > > > 
> > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > > 
> > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > 
> > > > 
> > > > [   17.318428][    T1] calling  maple_tree_seed+0x0/0x15d0 @ 1
> > > > [   17.319219][    T1] 
> > > > [   17.319219][    T1] TEST STARTING
> > > > [   17.319219][    T1] 
> > > > [  999.249871][   T23] INFO: task rcu_scale_shutd:59 blocked for more than 491 seconds.
> > > > [  999.253363][   T23]       Not tainted 6.1.0-rc4-00003-g120b116208a0 #1
> > > > [  999.254249][   T23] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > [  999.255390][   T23] task:rcu_scale_shutd state:D stack:30968 pid:59    ppid:2      flags:0x00004000
> > > > [  999.256934][   T23] Call Trace:
> > > > [  999.257418][   T23]  <TASK>
> > > > [  999.257900][   T23]  __schedule+0x169b/0x1f90
> > > > [  999.261677][   T23]  schedule+0x151/0x300
> > > > [  999.262281][   T23]  ? compute_real+0xe0/0xe0
> > > > [  999.263364][   T23]  rcu_scale_shutdown+0xdd/0x130
> > > > [  999.264093][   T23]  ? wake_bit_function+0x2c0/0x2c0
> > > > [  999.268985][   T23]  kthread+0x309/0x3a0
> > > > [  999.269958][   T23]  ? compute_real+0xe0/0xe0
> > > > [  999.270552][   T23]  ? kthread_unuse_mm+0x200/0x200
> > > > [  999.271281][   T23]  ret_from_fork+0x1f/0x30
> > > > [  999.272385][   T23]  </TASK>
> > > > [  999.272865][   T23] 
> > > > [  999.272865][   T23] Showing all locks held in the system:
> > > > [  999.273988][   T23] 2 locks held by swapper/0/1:
> > > > [  999.274684][   T23] 1 lock held by khungtaskd/23:
> > > > [  999.275400][   T23]  #0: ffffffff88346e00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x8/0x30
> > > > [  999.277171][   T23] 
> > > > [  999.277525][   T23] =============================================
> > > > [  999.277525][   T23] 
> > > > [ 1049.050884][    T1] maple_tree: 12610686 of 12610686 tests passed
> > > > 
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > > > | Link: https://lore.kernel.org/oe-lkp/202301310940.4a37c7af-yujie.liu@intel.com
> > > 
> > > Liam brought this to my attention on IRC, and it looks like the root
> > > cause is that the rcuscale code does not deal gracefully with grace
> > > periods that are in much excess of a second in duration.
> > > 
> > > Now, it might well be worth looking into why the grace periods were taking
> > > that long, but if you were running Maple Tree stress tests concurrently
> > > with rcuscale, this might well be expected behavior.
> > > 
> > 
> > This could be simply cpu starvation causing no foward progress in your
> > tests with the number of concurrent running tests and "-smp 2".
> > 
> > It's also worth noting that building in the rcu test module makes the
> > machine turn off once the test is complete.  This can be seen in your
> > console message:
> > [   13.254240][    T1] rcu-scale:--- Start of test: nreaders=2 nwriters=2 verbose=1 shutdown=1
> > 
> > so your machine may not have finished running through the array of tests
> > you have specified to build in - which is a lot.  I'm not sure if this
> > is the best approach considering the load that produces on the system
> > and how difficult it is (was) to figure out which test is causing a
> > stall, or other issue.
> 
> Agreed, both rcuscale and refscale when built in turn the machine off at
> the end of the test.  For providing background stress for some other test
> (in this case Maple Tree tests), rcutorture, locktorture, or scftorture
> might be better choices.

Thanks for looking into this. This is a boot test on a randconfig
kernel, and yes, it happend to select CONFIG_RCU_SCALE_TEST=y together
with CONFIG_TEST_MAPLE_TREE=y, leading to the situation in this case.

I've tested the patch on same config, it does clear up the "task
blocked" log, though it still waits a long time at this step. The test
result is as follows:

[   18.397784][    T1] calling  maple_tree_seed+0x0/0x15d0 @ 1
[   18.398646][    T1]
[   18.398646][    T1] TEST STARTING
[   18.398646][    T1]
[ 1266.450656][    T1] maple_tree: 12610686 of 12610686 tests passed
[ 1266.451749][    T1] initcall maple_tree_seed+0x0/0x15d0 returned 0 after 1248053116 usecs
...

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  clang-14/x86_64-randconfig-a006-20230116/yocto-x86_64-minimal-20190520.cgz/300/vm-snb/boot

commit:
  120b116208a08 ("maple_tree: reorganize testing to restore module testing")
  4b1aafbdb208f ("rcuscale: Move shutdown from wait_event() to wait_event_idle()")

120b116208a08    4b1aafbdb208fb4e10bf7abff1a
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          5:6          -83%            :6     dmesg.INFO:task_blocked_for_more_than#seconds

Tested-by: Yujie Liu <yujie.liu@intel.com>

--
Best Regards,
Yujie
