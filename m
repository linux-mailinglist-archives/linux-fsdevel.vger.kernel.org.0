Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0D87A573E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 04:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjISCLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 22:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISCLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:11:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF45510D
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695089474; x=1726625474;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h9W9WUIa46o/I68rRvd+C424KmauKWokMgoIzEocl8Y=;
  b=aAvogL+CiU0+HdFka0HUC9xZh7lkeWZL3A9f7smaOPOLNTtNhniQTLMv
   nu2Ta1EXCUNsQJHEczzuj+7sah8m5kxuGyCpZLk7jNkhbhVk5eYe1pxEu
   7nM9b0nm3fXyYIrMLlqMnOPLG82Et+hCVVMXdR/cP2w/NdD1PGwteBKJW
   9P0s/TiaOFZyvb3TGAhjAiWyvGfqXdvmePPNZn6w4PCluD2zwchazKc5c
   sMNbvT63OdHYq9ekkoN6t125XisBb8R1WRj1HYh0D8gNRDEAxYRTrVX7o
   N/9owJJ1UXwXTUjFtysNbsv0isFG1UQ9/jpngroQmD6rFJgcsR8aSdpa4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383654605"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="383654605"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 19:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="816281354"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="816281354"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 19:11:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 19:11:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 19:11:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 19:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7S8oejxjXCqQrKYbh2p2tjE5DkowkQa4/Y3uEJgakT8Z0k33PQgcKoPtXnpYBxBVSuhtWM/zjS9//LdghBlNmgvpRzySXnGcjGnfIvNosnOB+L5FNMSnpETtnC2YkpyNMnmWsdqHIP2tbl+doNrTFSilqAw6Kj+bpcFHMgvcivuaMEwfCi046uyiljVkQVj05KF2XVkeYqDEMWQWPwxRw/Ms0FRWJ6SHMzt1Og1RmdqHaTnKIT4M3g6ggn3Myt7N1D6/L0uHa40bngrPAaxcqDM9pALRPc22lRHfdA8p1pMyBFhvbCmW6W189khh+yozUegGKBpNgEqJjsRJr1zqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkkvxsn8pPtbfliZ9f5CrW6Ay8s1ivFXbuAmij0IVYY=;
 b=VdqfyBFqFEfbFV9lpq1ZsMPcTeVlJZ/mwZAZ8C10Mq4HpoZBZZ3ax76ykNALUUGQZOp8oWf3j42sFz9NKUdQthv+MDGv9tm/bXFGQvKM1I2WP/+oKnIopg1tSfitfUtWZelwLEwxk6rENtW3g+GTyoTp6LDfjDbRclOb2JzjIozUdEMq0S/S6WlP734aTdu1RTur40OX17+4Ye08Z9EYiGE8wChwN1jjUqcFtriS909BMf2sFa360NvvTLz7h4wkXMk+NLYg/97Egg431CqAjztUTSqhfhb6SzYkwDPg85NVGJ8SoJOpuueHfio4DHIchv4xmOFJZwu/OleR4HAQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 02:11:04 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 02:11:04 +0000
Date:   Tue, 19 Sep 2023 10:10:54 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  d6f1066621:
 WARNING:at_fs/attr.c:#setattr_copy
Message-ID: <202309190922.94433d43-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|LV8PR11MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: c956806b-02d7-419b-a712-08dbb8b5ad43
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPtrAGROtMg4uRC1+yq7nMwPDU4GFZ24PV4hXB4dNr9ZJqTWJpxM1ByD2tf1ZVybeAZ5lQEzcVYbgmGqGokV5cX1GTOwwuNVxCLnV5l6VmnR+yUMDmssrS18J3exp8z9GWMV8zzjnDmH++X4DukkYCjiY1PMqN6TaDdWHZS6r8MFPJQ84is5ozAf14C78QCqDJUz0ycPhxxWd/IqZY0ZaUD0N/qa3lkg2vnCVsq3/TfBg3aXVdPA80SocLfhgYAEdb4pk5MdgmJ4MxmyTMKHdUPtyiwy2v4uO65ji0MIBTVUQXqsw3u7CldGv4voOonc3VR59V1CLou8qLLjDdC+eGvqcFVKdQaedN3S648NfkIF+wLLUrfLrt+OpAHl51DNInrEm/FsbLYT7bX1g9/MZFCd/k8uK+7Q4fImiZ8JapISxtFNenGAuZ0TWDcaGuTbelhXleYHSBIAuSGZXhJDKcoXQgRPLjqLJ5B8zucQRfbUMeB9RAlBOZDZDHHb+fpOS+vjLQwBN67BfclrpwmrGbmpbjk5ij6JAJPRW4AbCNS/qy6w+TTA3n9dQDcq5/ONdOHQhN86BgyLY/Xa+eSYxzSrRfDCPexW3x96gznF3HeFUJS2iboHgU8mFl5wDjOZwBo4lqw9V2kinlnTrTiBgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(26005)(5660300002)(8676002)(1076003)(107886003)(8936002)(4326008)(2616005)(2906002)(86362001)(82960400001)(83380400001)(38100700002)(36756003)(66946007)(6486002)(6506007)(966005)(54906003)(66556008)(66476007)(45080400002)(6666004)(478600001)(41300700001)(6512007)(316002)(6916009)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/wUNM4PcCvbq9061Lv0PoUWKbes+VEt3HfKVq8btG8/c5BWKRMiekjXE70kM?=
 =?us-ascii?Q?8fp8fkWrAJgbJX6syXBkLOw09xhBah2R86/mq77s9nn9/YQQtCoyYX+R3Zwi?=
 =?us-ascii?Q?BDEBM/vpH25d/VrzZZwZjv4TzrFnoQVjtwBnW5RNfZ3oaDExUVgq8I2BCqK9?=
 =?us-ascii?Q?6cpPEmarOT+DDQwShHySsZzXywrfnAuFbOmeelAt690lhgcRSKMoWq/aKYvq?=
 =?us-ascii?Q?RhWuWbfSRXJMmZe4N4MNmnKZaXiixzTAwk9WBOfkryi+iw02H04lQ/AvPyWK?=
 =?us-ascii?Q?EkYKVhqQhaRbVKPscke5IQZ1LqtGXoaSrGsOk5ByqbaNZM7epCdxW4rX4jW7?=
 =?us-ascii?Q?nm/oVF86PDylp4cwrAQJbsUaFclpwilioCX8sFHAklbtfe06uG1IxuG4psO7?=
 =?us-ascii?Q?VESKE2Foa2zG51AfjtlZeQuvoxPXuIQwqrJIePfC9YeCq1w7wbNr9s+zoq8W?=
 =?us-ascii?Q?Ad6w4Dg1gjY+PYeOW1fx42mlj1bvzsV6k45qA0xzBkL9pc9mDCpIktZqoUD+?=
 =?us-ascii?Q?10P59HFuepgenXoEBOyduQRFcCywwVl7a9Dh9P36uKlUEW5gOSwrWKC88QBy?=
 =?us-ascii?Q?EBQ2Jm3a6X6/PXlZBuroQbPoPPWergckJFR9fzwjEjbgcZ3P29u+/0EZ0DSL?=
 =?us-ascii?Q?vDRjbFoQXI9TzlKWTAsp+sORJ7Tqilj8G6BNYFRyivV0SHWtvog3FMd3WV/c?=
 =?us-ascii?Q?YffrwhT0kw5X9nDvhL2DUs4iRmnQVQBQ9hjt94r/oq4rcNl5Lh5AZYJW7iKg?=
 =?us-ascii?Q?HHOdhTApCt9b+yxff3i5pyqMSOQD5Md0hnqK8T772KFgp7ol6N4PihGGn96s?=
 =?us-ascii?Q?KMeu0XT3MTKp7MHvnhO4bAVgi71WlnbBJ6OdbW/VBVlnSwej+brbqDp/HsmO?=
 =?us-ascii?Q?icoNEzX/Rbi5/JihrtbvVXDfOnP5JD59HySOV9AW8OJHwW04H3i1ODUt6qyQ?=
 =?us-ascii?Q?wrKN7YmZ4nMYUCAxQqEUnl32djo4EWN4CxDS+hqMy2dsZzMGZTAa1AW6Q7mA?=
 =?us-ascii?Q?/6yLMVceK/jGh9wxyozRge9JtgbN9rv5izMPZc+S+2eA32eVHjPD2K/z1yRB?=
 =?us-ascii?Q?L2zv/YYY3KQTZmkg38x/1suJO1KmD9lGTeAUvWJ6TKpyk6ymx/anYeMQ636z?=
 =?us-ascii?Q?7EI1Xozs4NsxvqoAso3VJbI05rbWksEU4yEhKaVDCFCrMJkdDiT0zPWPgS0J?=
 =?us-ascii?Q?0MI5ipPQSu1xeYAmBs6Mb40Yj4XWRMtf0MbpcNto24rPduMe4UYsAspBlkl1?=
 =?us-ascii?Q?G5YLv6uKgrIT1QYgIeA84P7im8feQYDYBgqgBGboIjeghqTjSWiSkVFUEdSl?=
 =?us-ascii?Q?oj64TcMOyqP1l/QGAazxZJKLt4WdVOhzwYrrmj1/WHjqGgEsxgd7FUiRbpE1?=
 =?us-ascii?Q?Y/iiOSiNnOCWAcEa22keIfkMvG+FtbhxnxSBKaOV/ub+7cMuzPH0ly4BFcuS?=
 =?us-ascii?Q?lSxkLPwk7JExth1au62y+f+4G9jRshCRWeHOBkuft5CzkDirhnjYQ6dw6YLK?=
 =?us-ascii?Q?N5PIKFihd20R+BL3BBDiOpfU/njzQLU5MkC5wtPzMQ+5GT6iMCjcVc2JONrM?=
 =?us-ascii?Q?QvoVRwJolMCLoHnbK+XeAIJ7jntKWTy17SLEnzrO83Vu5gHB2VlMmnLcIgTj?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c956806b-02d7-419b-a712-08dbb8b5ad43
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 02:11:04.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frt/ZhU5T0+L3mTI6FHDoCaanD3y+qAfAdrD/pOsB0C5Hcxu74Bqr6fhSY9oo8M8jGzom3NT6UT9+BVLn6NvZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


hi, Jeff Layton,

we reported "[jlayton:noumask] [fs]  f5cb94f57a: WARNING:at_fs/attr.c:#setattr_copy"
on https://lore.kernel.org/all/202309132200.8a23d7bc-oliver.sang@intel.com/

now we noticed this commit is landed in linux-next/master and the WARNING still
happens. report again FYI.


Hello,

kernel test robot noticed "WARNING:at_fs/attr.c:#setattr_copy" on:

commit: d6f106662147d78e9a439608e8deac7d046ca0fa ("fs: have setattr_copy handle multigrain timestamps appropriately")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master e143016b56ecb0fcda5bb6026b0a25fe55274f56]

in testcase: phoronix-test-suite
version: 
with following parameters:

	need_x: true
	test: render-bench-1.1.2
	cpufreq_governor: performance



compiler: gcc-12
test machine: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309190922.94433d43-oliver.sang@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230919/202309190922.94433d43-oliver.sang@intel.com



[   27.504534][  T338] ------------[ cut here ]------------
[   27.509816][  T338] WARNING: CPU: 7 PID: 338 at fs/attr.c:298 setattr_copy+0x106/0x1b0
[   27.517709][  T338] Modules linked in: overlay rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod t10_pi kvm_intel crc64_rocksoft_generic crc64_rocksoft crc64 i915 kvm irqbypass crct10dif_pclmul drm_buddy crc32_pclmul intel_gtt crc32c_intel ghash_clmulni_intel drm_display_helper sha512_ssse3 drm_kms_helper rapl ahci ttm libahci intel_cstate mei_wdt drm mei_me intel_wmi_thunderbolt wmi_bmof i2c_i801 i2c_designware_platform intel_uncore video libata mei idma64 i2c_designware_core intel_pch_thermal i2c_smbus wmi intel_pmc_core acpi_pad
[   27.575529][  T338] CPU: 7 PID: 338 Comm: lkp-init-bootom Not tainted 6.6.0-rc1-00001-gd6f106662147 #1
[   27.584771][  T338] Hardware name: Dell Inc. OptiPlex 7060/0C96W1, BIOS 1.4.2 06/11/2019
[   27.592810][  T338] RIP: 0010:setattr_copy+0x106/0x1b0
[   27.597921][  T338] Code: 44 0f 44 f8 48 8b 43 28 66 44 89 3b 48 8b 40 28 f6 40 08 40 0f 84 59 ff ff ff 45 8b 2c 24 41 f6 c5 40 75 49 41 83 e5 30 74 94 <0f> 0b eb 90 48 8b 43 28 41 8b 54 24 0c 4c 89 f7 48 8b b0 68 04 00
[   27.617252][  T338] RSP: 0018:ffffc900009df6d8 EFLAGS: 00010206
[   27.623132][  T338] RAX: ffffffff82e52700 RBX: ffff888878f57850 RCX: 0000000000000001
[   27.630906][  T338] RDX: ffffc900009df7d8 RSI: ffff888878f57850 RDI: ffffffff82e7a260
[   27.638679][  T338] RBP: ffffc900009df700 R08: 000000006501db14 R09: 0000000008d24c31
[   27.646451][  T338] R10: ffffc900009df7d8 R11: 0000000012c06dd2 R12: ffffc900009df7d8
[   27.654225][  T338] R13: 0000000000000030 R14: ffffffff82e7a260 R15: ffff888878f57850
[   27.661997][  T338] FS:  0000000000000000(0000) GS:ffff8888539c0000(0000) knlGS:0000000000000000
[   27.670717][  T338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.677111][  T338] CR2: 00007f088f007648 CR3: 00000008788c4004 CR4: 00000000003706e0
[   27.684882][  T338] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.692652][  T338] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   27.700423][  T338] Call Trace:
[   27.703551][  T338]  <TASK>
[   27.706329][  T338]  ? setattr_copy+0x106/0x1b0
[   27.710829][  T338]  ? __warn+0x81/0x130
[   27.714729][  T338]  ? setattr_copy+0x106/0x1b0
[   27.719230][  T338]  ? report_bug+0x15d/0x1b0
[   27.723560][  T338]  ? handle_bug+0x3c/0x70
[   27.727716][  T338]  ? exc_invalid_op+0x17/0x70
[   27.732216][  T338]  ? asm_exc_invalid_op+0x1a/0x20
[   27.737066][  T338]  ? setattr_copy+0x106/0x1b0
[   27.741568][  T338]  shmem_setattr+0x170/0x430
[   27.745986][  T338]  ? kiocb_modified+0xb1/0xf0
[   27.750488][  T338]  notify_change+0x22c/0x4f0
[   27.754905][  T338]  ? ovl_set_timestamps+0x7d/0xb0 [overlay]
[   27.761225][  T338]  ovl_set_timestamps+0x7d/0xb0 [overlay]
[   27.767375][  T338]  ovl_set_attr+0x9f/0xb0 [overlay]
[   27.773009][  T338]  ovl_copy_up_metadata+0xb1/0x230 [overlay]
[   27.778814][  T338]  ? ovl_mkdir_real+0x32/0xf0 [overlay]
[   27.784192][  T338]  ovl_copy_up_workdir+0x15f/0x2f0 [overlay]
[   27.789998][  T338]  ovl_do_copy_up+0x9c/0x1f0 [overlay]
[   27.795288][  T338]  ovl_copy_up_one+0x439/0x570 [overlay]
[   27.800751][  T338]  ? kmem_cache_alloc_lru+0x12d/0x270
[   27.805945][  T338]  ovl_copy_up_flags+0xcf/0x130 [overlay]
[   27.811490][  T338]  ? __pfx_ovl_open+0x10/0x10 [overlay]
[   27.816867][  T338]  ovl_maybe_copy_up+0x89/0xb0 [overlay]
[   27.822327][  T338]  ovl_open+0x86/0x130 [overlay]
[   27.827106][  T338]  do_dentry_open+0x200/0x4f0
[   27.831615][  T338]  do_open+0x291/0x430
[   27.835522][  T338]  path_openat+0x130/0x2f0
[   27.839774][  T338]  do_filp_open+0xb3/0x170
[   27.844023][  T338]  do_sys_openat2+0xab/0xf0
[   27.848362][  T338]  __x64_sys_open+0x70/0xb0
[   27.852698][  T338]  do_syscall_64+0x3b/0xb0
[   27.856942][  T338]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   27.862652][  T338] RIP: 0033:0x20d511
[   27.866377][  T338] Code: 48 89 77 38 c3 89 f0 48 8b 1f 48 8b 67 08 48 8b 6f 10 4c 8b 67 18 4c 8b 6f 20 4c 8b 77 28 4c 8b 7f 30 ff 67 38 49 89 ca 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 f7 d8 89 05 0a 81 10 00 48 83 c8 ff c3
[   27.885683][  T338] RSP: 002b:00007fffe3e8ebb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
[   27.893885][  T338] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000020d511
[   27.901656][  T338] RDX: 00000000000001b6 RSI: 0000000000000241 RDI: 0000000000612c00
[   27.909428][  T338] RBP: 00007f088f006448 R08: 0000000000000060 R09: 00007f088f006180
[   27.917199][  T338] R10: 0000000000311260 R11: 0000000000000246 R12: 0000000000612c00
[   27.924968][  T338] R13: 00007f088f0060e0 R14: 0000000000000003 R15: 0000000000000000
[   27.932741][  T338]  </TASK>
[   27.935608][  T338] ---[ end trace 0000000000000000 ]---


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

