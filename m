Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E47810F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378746AbjHRQvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 12:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378784AbjHRQum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:50:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6CA3C3F;
        Fri, 18 Aug 2023 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692377438; x=1723913438;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XEyI0IIL/YGMtvbZcH0MNGt6dSkAzc7HaZPWB5iL8+s=;
  b=MEFAsmIFsD05O3kTfSgDhPejEDeROtY12IeB/fiAH8oA9bc5fGEXRbXK
   nzq2bNY6TTc9GUIgbO0AgNR+jGwkboZikGOZ4ky/YWCzt3xM8OQToiFKp
   UfMPZzh/UhLBaL1ZPUdFUEuwJl18co9LIk5kdklH4RG4v4P/5sILEtgOO
   jOljKVl0BTARpYbM3Gi0e08MpKAXeTH4TEsyIzSLv0f4oeTfi8wKGPSEZ
   n9HQkOCVOkWbgnBOUkabGeox8gyrADH7IzwrHUwYQ12qfTZ2DYma9WxzZ
   NJK/ytwWK5JVIGvWBvQZ3DlHhqSqXzE01TiH6We+LVCMrcNzetmwAW9li
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="459500012"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="459500012"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 09:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="981714242"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="981714242"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2023 09:50:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 09:50:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 09:50:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 09:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1497kVgfr43QKf7dmZio6j8cbAq+jX7dzU35rI9pQQBm+9mhAl+Px8qiN0MQ9h6c1YwLNjJJzjcuSjB00/rpI9Cm8lumivn4zkGzjBuAdyCOkMy+E9phkrAlpU2elPNKDI0p8GA470HvqTglm3UA5aAjgp9Aq0dNrQ8D5cjQOranN8W7mPHXb7loUEBIPdQigeTbFJWpRvLKW1GAvhStmWDUTn2W/Wivr5XamQSgBavHv9GLBchSIJLie7ZH+4Mt3BTLlKtE3BBvIUTWL1covBtcxQujMoQRZ2QbWoIZZQ08zEpjdj3KGmOG3GHe3vavsaISGSqopn5dHS4ESQ0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV0+sjnLaFHpPC7zDOLHUxAPnu95gTMt5IzmnRel3I0=;
 b=JYL1otHDanTguXbfTgd/TDgru8HlHZ6hdntbxIxF+iUASVUlqQEB76noLGqgXLG9nK7j2oDC7cfErTWTAuRYLlHeiPDRLGQR0v0BzKsjzjphHjcTmKyIUHBRvImleF4VkCUGvT4GyoWVPY5HIkJlHbOLWhVaKqTryniOccEsmEXrDsK76vZxOT4hmwisLnR4pi6tXjiAPt32+dzbMzZ84J2jnUPJI3HizGwA2rAcK1UmPHWX60xpnjRcwKC1NUblOddKW/jS5QE2IEPr7j6Qrh1Lom4enigcG5d8TSk3gjL+fMTgd6UCWlTkPZgTqi0yMh02xJXAPpjEVFXMdvreIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 16:50:21 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:50:21 +0000
Date:   Sat, 19 Aug 2023 00:50:04 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     syzbot <syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com>
CC:     <adilger.kernel@dilger.ca>, <linkinjeon@kernel.org>,
        <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <rafael.j.wysocki@intel.com>, <sj1557.seo@samsung.com>,
        <syzkaller-bugs@googlegroups.com>, <tytso@mit.edu>,
        <wendy.wang@intel.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in __writeback_inodes_sb_nr (6)
Message-ID: <ZN+hPEqTKjGIzaLX@chenyu5-mobl2>
References: <000000000000f59fa505fe48748f@google.com>
 <000000000000761f5f0603324129@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <000000000000761f5f0603324129@google.com>
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA3PR11MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2a6c7d-a386-48b7-e291-08dba00b35b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2rkQjdMYO8TUXzpqgEWItQdAgVC/eoT/c3ngNtD9npHwX0AZ2sgDFIEBHD2SJMdZJ0TXUbFJ3aY5aPohwHjz3QBooB9zp3H/edchHXvj/wWy6Rtp1iyLPy9UbfSda+P3Wdlsfyqo3vVLQFXMjoPNvW6AtcYO5vIH8gYIPQLPIBFOvzYKxWyU5XslCNkDAiF72whm0Omt2H/Ua4Q3y/00672XmuzCYEv/2WGnbIDvsHrmDMhQYRisFJIs7RiizFByLiRX4iHF18KYG2thEj9Jdxk+fWPRpCuyp5qXg+QBgpKWvR0eQpGG5tQT6uJ5mCJjWwLgr8Z3u/a/JEDidZ/ZJXCZifXJR7jcMojlbSe90b7LcKOgY+pXVUji609bJ8oT1iAIvEz7OIQjWvqoDODehnd4JWhj/CbA6KYQGm49hr4gpRBB+2gCV2GNc0jG6UeQEYvGlsrMBSk565L9UIy0OyegqRFmw8NzE1elhw4JbLRHVfCib03GQ8y7dMzFHTsjK1aOYXveRvybG7Wpc4UlwoHIym5Dss2YIQR7Szz1hoYA2DjWMzVixYvVQbHYGZQiYSONRVyACuMY0dHW7dDUPG0EP8t50Wtfhf4oc6TTUfJ//LRBKnkfRTmdWLWAKZTqyte3iNcHAHOZdphg8U89YlMDOuosWxAPUuBapUz/Js=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(186009)(1800799009)(86362001)(33716001)(38100700002)(82960400001)(5660300002)(966005)(107886003)(478600001)(66476007)(6666004)(6506007)(66556008)(316002)(6486002)(53546011)(66946007)(4326008)(9686003)(26005)(6512007)(8936002)(8676002)(41300700001)(7416002)(2906002)(83380400001)(99710200001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NSNn80WEpbletQJ3haVv3syjLXijqKDhslDxQb7H6gp7S+700eJzUwBLyZJS?=
 =?us-ascii?Q?AJi0bocI10yHU8lYLfwkyV0bkiAndR5jOY3MM07ikSysec+nejimdbvzz3HM?=
 =?us-ascii?Q?uewDVzYyk/xFcYYG6uFA7iPnDkNlwg74knQU2YOFpBhpsq5EwE+yg27EjGZn?=
 =?us-ascii?Q?cmfMjSfy3Guz2anKmySMPaETCMs1FcwLA6ZvKsh2z0oR6b2nZdS+EktSQljO?=
 =?us-ascii?Q?d+yWsKK9bIxrKkApdMEvHagn+AgWEk9PV2g5S9TxMHoYmgVbNt7mVLTFj9ma?=
 =?us-ascii?Q?ik5/IqATMC8CDUQ9Ku2z1eeqjtlSb9YCe2pchPyed6MM0D7MSdVKqeF2B/vp?=
 =?us-ascii?Q?UuEiJ/VzviKLFQi8ceq7hsYWmbcde21X9ygQVnmrp+RKp8W8Z4KMuPOgINOZ?=
 =?us-ascii?Q?XliWUSsSFx5NlS9rfoIL9ImT7k8aQ/xsSGBVtBj12lPRCfUPQn46w4qoSR7c?=
 =?us-ascii?Q?AhdFHNjS0+tQvngiCfFBoV0EXdJGKsOyDTklZng7vw9xOjA+U3nXVP2u+zcp?=
 =?us-ascii?Q?EOiMpnRUME6UkXh5Pqgw6f/V3vTKFyDGZq/Ms+FHB/3aIvC56TU7AI/qGKCA?=
 =?us-ascii?Q?8/JhJvr8Dnwd6LH4E4rYWUOTZtYz14daHDgyyo5kGsaXgfJUvXZ8h9XSAYQC?=
 =?us-ascii?Q?O4S+UuXTkzlIRSK6Oun3b1XWPMbXRZeHpMCWTRJjyebUU7ZYxaMYpZyK++dK?=
 =?us-ascii?Q?IY5u/vDFI5VKDjvmZoGf7fwkOva3jlXhKsKDCNYNtSqboZKqHk7NdfQhQU/4?=
 =?us-ascii?Q?/F4BsVVOCXWPi4TSbiZJ43ANFbJHIwPHCDLgCNQ18Wgne8SdwpypZ2MSxHOD?=
 =?us-ascii?Q?CvxZi29SEv/2XEbFYLCW5zi8YWKDQ9pI9B+tjzkFuPsiSM/2NkjBDlz9i8wo?=
 =?us-ascii?Q?V5sx5kZJQ6XPJArnmMPhO/m20LL+OcVi2u4RXKcdqHv8VdDjDmct2tME/TzQ?=
 =?us-ascii?Q?rc2TWdDDkpRDB7w92fE9B0rks11N83NIm5jUcM51RoAoQivz1AxUqy3fRSaX?=
 =?us-ascii?Q?XdKV4gTFbNL7Lf+y+AjH7hqp4s9xeyT9hPP+RVpIjv3tDSn6TAh9ruU22XCr?=
 =?us-ascii?Q?g/XdptmaBDyZiW27ZV3LqNzLADkZnlVL8Ps88vgwV+02CcqchMFlY7TmanXY?=
 =?us-ascii?Q?7facXeb91iRJ1CBLx/15zt9W20uKD9TychT9C2EbiRKjeYe1CH/ANlQ6yLIB?=
 =?us-ascii?Q?hP8mfLMat9AxmtDbgCsrsAsmWTCRlTufE8DXdWxRMFViLQHP7CZAlZxh4x08?=
 =?us-ascii?Q?5D2pQfMXsHKwZCLSwZmuk0YrZsOfoYXEmIravQo7/EeD5NYmVJ8c1vLI5n1q?=
 =?us-ascii?Q?DrxnLNeFd5T35+/0jDs/Q0XWWwjrvZlsFo67LbVk6xn2Mv3aV1qr4Lyqn68R?=
 =?us-ascii?Q?k/LKgIoiAmuTuJGB2llNT5gMzkg6oawzHPhGK0u54dc7LI/s0tGGmK2+YBSl?=
 =?us-ascii?Q?AyxGglU9u19e4UO7HLoHtzAnetiVJVyUbdbsyLpibJVg7ikg0013X0zGLqC+?=
 =?us-ascii?Q?iBjyxgjQzm6NGdDsvxxQYLKb7d/TWQ1uGLvS7Y9naw7AWQ7xIjEeJIn7TcAj?=
 =?us-ascii?Q?rowlGkxikZO0SCfsAPihdBZtloXnGQbL799PN1PA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2a6c7d-a386-48b7-e291-08dba00b35b3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:50:21.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpXFRZuNwpVM/j5jRfxDter87EkDE6AtbvgkRdbvSOmqJieYQtjS+WdF01v45DY4ubhe12Eh50tGyPyjkcv48g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7527
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2023-08-18 at 06:10:41 -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 5904de0d735bbb3b4afe9375c5b4f9748f882945
> Author: Chen Yu <yu.c.chen@intel.com>
> Date:   Fri Apr 14 12:10:42 2023 +0000
> 
>     PM: hibernate: Do not get block device exclusively in test_resume mode
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1275be4ba80000
> start commit:   4853c74bd7ab Merge tag 'parisc-for-6.5-rc7' of git://git.k..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1175be4ba80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1675be4ba80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
> dashboard link: https://syzkaller.appspot.com/bug?extid=38d04642cea49f3a3d2e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171242cfa80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17934703a80000
> 
> Reported-by: syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com
> Fixes: 5904de0d735b ("PM: hibernate: Do not get block device exclusively in test_resume mode")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Thanks for reporting this, the commit has set the exclusive open mode incorrectly
for non-snapshot_test mode, I'll post a fix patch.

thanks,
Chenyu
