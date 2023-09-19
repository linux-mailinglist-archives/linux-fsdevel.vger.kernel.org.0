Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726A37A5779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 04:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjISCr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 22:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjISCrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:47:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4DC103
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695091639; x=1726627639;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=NKkrcfyyITmlblliNqYq7EasTlv6Xbvn3iCRnatTjeU=;
  b=VxryzWcLfcBAIGu8RYRylfHXliiw6tnnWCAe0OcLtwZrOvgpdI4c1gIq
   m6zt3HGm/yhg13NX5e1af5Oo71v58rdXJmQ2BAR05TUVQOWRhiAQZNff6
   AGJZCAv9sGigP0yN/ESAMp6xOwxHt4k5a0wY1zDM4EoNKXuBpHaFTb4nI
   qAbGBcwVpR0Gi7Me/a67kAirTehHAEWSi2ESHFLknlX5aBK7YNU0fUXxw
   bw2a8dKZug/WaReMzWjorKhim6rFxYeO44U5OPaFT27rxCirp50HfgORK
   tVEPSUvk6UmL2Oc18vFtvsD/mMhwNkhjjGM51ORvH9sElBM6AdPc10mIn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="382586767"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="382586767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 19:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861354155"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="861354155"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 19:47:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 19:47:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 19:47:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 19:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFOf/xC1lAi8l8aZzrh11HrNG+8khHZXFTxhc8nHstDp/VnlcygpqopJpAmx5/R+3TeWYC5UoSNGmN7uYHuLku6jEUaWS4qxkH01pnc/MFWjEaxfJ9wosiRu7ls7I5SuBCuuXamnsBV6jJV1zVkfu8kHcnC48O2FlAgpst+RbatJgt23xo6nhUhFl+MOOoWA+stIDqP+cRr+bD8+54tGvoWKO6lHBGJl63cpEoA06i+d6kL/679j7B860et/B8/Pigb0FWDcofQtZcAscrmbW8XLRHUUKB7FCWEa+qHv9e6R8eOue30np20ir07umKzzK38sN8Jczy6wBMLFLP/Zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py+wxrd8IBBbJSlKDqSG8qb65jGNj5CuitGruSujH10=;
 b=JbQo0AJ+FUvCBbF0/FH8lGCGEXcybYBZZv5miKEY7vzUepw+DoG9yFqTquySSHa0MA4g96azLFrNpvY2BhgcRiN4CmKLyd5kAnUWvS/A5A7q66dwE+DfM+IZmZXmdf/mgkg3ceACkaSJesQy+HC2NWfCFnb2vqL4EEEkh7vS5LpCd/a3cmMc+YIrNjjz04ZMHaUbjkkllVkh8k6DIBkyPsPhmoEvrc1Vetuf0nO9FixjFrFwPRoLftJATSNyMzpOZDI4In+QHJa+RaGRBxx/10bfE7UukRBvowVsTevXkuWAs22yF5Fi7g5WyFVFeMJjgYNAy78E9tfyuEI9KngSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ2PR11MB7619.namprd11.prod.outlook.com (2603:10b6:a03:4d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 02:47:15 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 02:47:15 +0000
Date:   Tue, 19 Sep 2023 10:47:04 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Reuben Hawkins <reubenhwk@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
        <amir73il@gmail.com>, <mszeredi@redhat.com>, <willy@infradead.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        Reuben Hawkins <reubenhwk@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] vfs: fix readahead(2) on block devices
Message-ID: <202309191018.68ec87d7-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230909043806.3539-1-reubenhwk@gmail.com>
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ2PR11MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9db6cc-311b-456d-988b-08dbb8babba8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0/IS8OYgS2/81hm0TMzTgxHVqQ0IusqMsVbmWa/fibLyUWjWmYogSwKySifPCa0MXUmP+Kh0XxNHQ/KxAECfWmI7oR7UovpI+fz8SdwOPqBuln+57GY/Sm8K3ueX1kdoQMDwVHklQOq5l/syoPwVla7FUQTZh8grY7MbPFIae/bGFJTsIQrRWLic7dyCHW2RKsMlFUILpPBvWgCoYW4aGbNEU/hZxwT17v6Ll3ldcusq4sABzcvSbxcmUGE/DglUI5yQv4Qoxp5qezCbAOV+tkOf1bFo3LSrKdgwGQuUqnIRTCOKhW+dex2uSpgtL73ZigwSxkjfQnXhipR558rqRO7SKFmTWWNBSRKcS2bPZEhEb3gcnh++aekFAkQAutq/7J24R1aKghax6DsLuWlKCUG/4tsNOXF97CADknValR8Xh3LRhJC/KTRPk1dCdTIx/jPi1Gi66CxaeuyFhAq8Fr2dNbv9mY7Eqc85Tb0BDpYnxeN3xp3N0/3Z686exeooGomPqx0EF9JRNfF12sZTMCV7EPKGCJHYzIGXOBZ8by11L0fb9s4Zh1puecrywAtpqvMISL5fC0G9w76SolaCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(186009)(1800799009)(451199024)(5660300002)(83380400001)(6512007)(107886003)(26005)(1076003)(2616005)(41300700001)(6916009)(316002)(66556008)(66946007)(66476007)(8676002)(8936002)(6666004)(4326008)(2906002)(6486002)(478600001)(966005)(6506007)(86362001)(82960400001)(38100700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VK+BygoIDYPwUlypYLxhMYJQSjiwCm7ZLg6jTkbAGyildorP6RmtIgosEMMM?=
 =?us-ascii?Q?WuD33CGChQOjE5HNuxILkloZTLq6ZQYjyQCcm0VLPiMlmWbP102sypZXY8eI?=
 =?us-ascii?Q?g5s/Nzko1OuciVe+IRsgq9KzihQOA5LC6I/7ZfFSd2OYocuKDjf8e7VuZNHr?=
 =?us-ascii?Q?tBAzmR0LpM0Gvzlf2LtLQ7PPSXruEOYo2suQNsnR1cE3Wy311iTo0N3rT3ie?=
 =?us-ascii?Q?LWBBnIjm8w2QCxyReEF+55NiLXbAe8p69M2FbyzDZZmRL+0qnyZdv9soOdz1?=
 =?us-ascii?Q?YEe7bSwtaR/idbJtCh/rGODOk1rIVpGOzT/0pLPZ9nryfaORjUuYBPpAAnu7?=
 =?us-ascii?Q?jvHpLuoCzl35a7YDV+tXda8s5/A4fdSid8nd/W4nM4QskLZitwa5rZpngTPS?=
 =?us-ascii?Q?czJzT/OKfF44HES3Ecz/G83eKxlbwIJPkkVVA4Me5c4IUoyKaJmzWddwA2jy?=
 =?us-ascii?Q?Ryj4LneO/LfXhBJsDYTPRr/pcbG0wowpS5Objj/2o57qgdUw72eiLoZVYu6/?=
 =?us-ascii?Q?b2ZIgrWzeFarTjfmDOjHsqZan+whIb9WAdukLFl1LD2jQA0Yaswe/CCVimFA?=
 =?us-ascii?Q?HopWRXGrRO93R6wzUXen15SuSH+EpW0hXxux4NrjpTbjsUOz/AIMgwK4+/8M?=
 =?us-ascii?Q?RZSKIFAo5z47J6YPFDye1NrM0JivMbwMTZqlOEmyGuS/ARhbcQrX1fROXicE?=
 =?us-ascii?Q?stBdrBAhfNGvimSeI/z6CrhjWDe+4ZpePx5/3mlsH3jKF9P7PXvG2uIJKM/b?=
 =?us-ascii?Q?9KS5IIob7DdRGp8lWjFw9QH4Y+cCdNWdoXxI0iOIdG2LVKEnw6zQrEmuiiKg?=
 =?us-ascii?Q?exqhbcxiwHJoLtFGK3KBimhmxyUlf2j6firth7y+MU2e/P86y6cEtRO7J3dc?=
 =?us-ascii?Q?zFBSCsdmzTwozkKdXf6D2aNgnn1FDn5Ze7AzQ3rdMrtDuA37zWOThfHsEEGb?=
 =?us-ascii?Q?g84hRQlPkmvCCr6DGf+rMA+ZWyjYpe/9HJjAUub0qc3mdL5QdzjH7pzcg1d6?=
 =?us-ascii?Q?mBoy0SfScqnBYvwRqPTzrry+PRhlPLseu8IJgDL8wCKYHphgB646r/GJjYPO?=
 =?us-ascii?Q?rqeyIQqCmlRQrhKrC7G1dyXxNvYaFCehBuNIvOl87E0ScBbxXwYjq8l7vozr?=
 =?us-ascii?Q?TSKxpYRZ0JIM93hTM/HdSIIORpRQA7sx6ijdm1aVYqAT5alZx03g2Z/pLq+W?=
 =?us-ascii?Q?8JZlw6tM8y+huJ/t2GPm53g8op+jGmeJ6A1Ogbo6p2WGmfY+RoFZMz1j+qIE?=
 =?us-ascii?Q?cLOdeXbNwLjb/rYySOWGrrENlaxlM4+Ny7UWcZFLdfVtexd+SpHk7E+oyI/L?=
 =?us-ascii?Q?BQtsEjj3Z7xcgmaPbWL2RAF8QM2X+BEcWl80zJrS4CmO7FbhQ1u9+AHu4ucF?=
 =?us-ascii?Q?I+zEKMRGrl5inoZ0xmI7fmSQ28fku1XRO7GNePxhKSsZeHwUEklxzm8+wa07?=
 =?us-ascii?Q?pv1A+Evv4yTJTXukwLhYq7/xaoGR/3X59jgSFr0ftezhaVLwTSp8DeitpOOP?=
 =?us-ascii?Q?ENHVjgwoaVLlcmDhSTqOlCOfeR6nUJSfOfm5O6JwiUAB/myEkPofTuTf8m8J?=
 =?us-ascii?Q?CINPpDiX3HSYvd8tITgi6PyzcTdouuH4mHIMPDC1RCwejkMcL14uzQRflwkK?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9db6cc-311b-456d-988b-08dbb8babba8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 02:47:15.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/sk+jRrzYQCS5uIrYHQ4xJhwQxrvX3+nZ42RaAPWqkGdGu3FD9PoJ6Se3t1hbofN6fMTQLn8wwqdcxFsKI6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7619
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed "ltp.readahead01.fail" on:

commit: f49a20c992d7fed16e04c4cfa40e9f28f18f81f7 ("[PATCH] vfs: fix readahead(2) on block devices")
url: https://github.com/intel-lab-lkp/linux/commits/Reuben-Hawkins/vfs-fix-readahead-2-on-block-devices/20230909-124349
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 32bf43e4efdb87e0f7e90ba3883e07b8522322ad
patch link: https://lore.kernel.org/all/20230909043806.3539-1-reubenhwk@gmail.com/
patch subject: [PATCH] vfs: fix readahead(2) on block devices

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	disk: 1HDD
	fs: ext4
	test: syscalls-00/readahead01



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309191018.68ec87d7-oliver.sang@intel.com



COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 3917     -n 3917 -p -f /fs/sdb2/tmpdir/ltp-R8Bqhtsv5t/alltests -l /lkp/benchmarks/ltp/results/LTP_RUN_ON-2023_09_13-20h_17m_53s.log  -C /lkp/benchmarks/ltp/output/LTP_RUN_ON-2023_09_13-20h_17m_53s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_ON-2023_09_13-20h_17m_53s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2023_09_13-20h_17m_53s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2023_09_13-20h_17m_53s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2023_09_13-20h_17m_53s.tconf
Running tests.......
<<<test_start>>>
tag=readahead01 stime=1694636274
cmdline="readahead01"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
readahead01.c:36: TINFO: test_bad_fd -1
readahead01.c:37: TPASS: readahead(-1, 0, getpagesize()) : EBADF (9)
readahead01.c:39: TINFO: test_bad_fd O_WRONLY
readahead01.c:45: TPASS: readahead(fd, 0, getpagesize()) : EBADF (9)
readahead01.c:54: TINFO: test_invalid_fd pipe
readahead01.c:56: TPASS: readahead(fd[0], 0, getpagesize()) : EINVAL (22)
readahead01.c:60: TINFO: test_invalid_fd socket
readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded

Summary:
passed   3
failed   1
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20230516-75-g2e582e743

       ###############################################################

            Done executing testcases.
            LTP Version:  20230516-75-g2e582e743
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230919/202309191018.68ec87d7-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

