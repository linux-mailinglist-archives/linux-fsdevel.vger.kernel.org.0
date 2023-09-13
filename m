Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0679EC48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbjIMPPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbjIMPPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:15:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B8DFA
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694618107; x=1726154107;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RXOOs9kwDTSs00+7qr1NvVTXQFy3rw6/3HmcY/wI6fA=;
  b=BS1W3ytpb/ZZ1t2xGd9PIt5eqlDBmMRIT7sBcT0CMG1eIuSZWqtgFDsE
   hVVyq38tfhuYJjiu7HDw2U3UPFAfBFVfz8uE4p7m3XDkCkdTC4j9WOIX0
   P5LUqFzuOMevXTRReLxoquqmciVa0k/OQ84uTRHRIlclAZ/Jp835kSk11
   UQ3gEYWZ/79QLnDb2seb3RapUSlQNEuqFbisqr0H0ZxJypCphczFnAw2F
   S4WlogtZ2UwrS35Vey6MrB6lHPoKvbBJl7qMxi2VGMkmgglzKcYTx0AES
   jFg3iQ82XqQBXyrVQPBo153r2PztBm33T7slyNxb1WVDMk2Unt7d+7pOy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378599482"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378599482"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 08:15:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="917870101"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="917870101"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 08:15:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:15:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 08:15:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 08:14:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoF96UGBx9SIQ6OvjCSCNYhTrwAUHsUkc4JGmUc1QzyH966W1ipcgnwgL5ie/5ZPdvaaFuCQ1Lx1Rhpuoj9Ky9fYm5GceiJOydFM5pfunJr/iNHExWqWh570tEoySKyVPR1NWSyoSwsmzw4NXyq1Y8mriX+KZIoxz/FvVKIa54b41bcDfZDu5U2rEXH+bW18ODQxi9J3CiLanpRvjQ/t0UMsIAgXSCUQSLCbf9uwQKsIpW/M2f30737fZD5V8ya88lP0cTmSKAn7Ll/SPUoFf0/GJK0qqYO82Qj3SQAhnfBC2NaszbOATU18ubFrzetBpnz2XbUmCDIACA5yzCnRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym77PxeCTYJzFJ8oFPzbliHJyGnJoA9NG+9b2acD/80=;
 b=TOX5ChGV6qqJLxC4hAmUNhdqS558pnL/ZlRZf5V8QoOw1vUtioo6FK0TEnNWBW/EL3oOAMZ92U6KMGigoYZlie8Wc8b32/bPQQbIJb/8u9KsosMIP6mopIxzmo9TDo5ZHPZKSaaw/SobsMlYSQ86WU5AjtlViTZ3LNhXUeUcEctxULlbx4MkPTRGkAwOH5x5UPm6wvGqZBV4us6rWeornkcJPhgeobv2YhuhTG6kSmrbz5MuPUqlicPm8JXnLjtUMG7FLhr1ffLWkeAhPmGEjR+4CK33eBVsigDYyvD+qr4Oy4IqMktX3EXstT0QwueksXlECwhyYYmpBiQInEpAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MN6PR11MB8242.namprd11.prod.outlook.com (2603:10b6:208:474::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 15:14:53 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:14:53 +0000
Date:   Wed, 13 Sep 2023 23:14:44 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [jlayton:noumask] [fs]  f5cb94f57a:
 WARNING:at_fs/attr.c:#setattr_copy
Message-ID: <202309132200.8a23d7bc-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MN6PR11MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 465cd31d-2b2e-49af-803b-08dbb46c2e28
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWPfqrx8b5IuapI6N7xrh5MwXVN6UfoxW4iVbgo6kkuUWQIzLpFl9ozVYiSmZeNT8UH3aQppav78rbLJ78cJKOgf1+8jIB2JGHXnVYpWlD+EnYMSxLlEkROdf8aHiOb40RPeFGBL3wV7Ple6ZufJBEwcndEnUeqwCwICwXnLdIvbtylUnWGTWUlKYR4TqYqLqik58kTQB6ExWpHCa+8NX7M89YJdHl/bWFZzu02ILwoSrbnaHtC02ziS0HsleytviDlKUHgSv4OKO+04+QWc5H/nRHFvb30IavTgo7wjNxxet3HpGU+yurwwM5NMgiD5eZeMlaJdDqGLvDZOCc//HkGmysvVGq/E776a2n4+uof/9plS7kGZeKTy8lpNsVuo1Uwk7/TSOwZ1NkpkUoFAHKNoB4ddTwJRgKjWOTrMgAQGOQ7v1L81ooRXyS4i6YdEUTFUk4AX9F95vS3e75BYCVmcTaB7gV8hgKupzK9RXy/RI87nIQxkk/bP1UKWdbmWEmr0mh26DtNPuB3/SotpYzkx1dsiAMwvdrw88YX/923z2+Z+L0E56UaUwI/KI4JQwlsOy1R6QT7hLVDFgfkNuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199024)(1800799009)(186009)(2616005)(5660300002)(8936002)(8676002)(4326008)(83380400001)(6486002)(6666004)(6512007)(26005)(107886003)(1076003)(6506007)(478600001)(45080400002)(66476007)(316002)(66946007)(6916009)(41300700001)(66556008)(86362001)(36756003)(30864003)(2906002)(966005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U7uNDwT+n//63e1S/O/R5+f7MAPiHSUyk09asD7PZZTrELUjzjZEN/FlFpF+?=
 =?us-ascii?Q?uY5pfPRZyyDt6HH0GpQ6kGeU2ykk+zX0+O/MTDehVUJTEA8Mk9peD+XuH+hh?=
 =?us-ascii?Q?Tkd1jLm5CwxrKtmJP5yGy3lF+EJSdzeMpAaejGsoPhnuvyrzNHlBJfzmKtll?=
 =?us-ascii?Q?Bns6MtZYrzYtzpWDBZiWQM2yfwAli+Qka/7cZ4zNuV6BUb2IilHLE3Uw6OId?=
 =?us-ascii?Q?oCSVoWIG98Hp6T3E7BkncciyF+kjxYgYnFyrPdVDpLpSFlLXhF7eEtDSafja?=
 =?us-ascii?Q?VOm7vXeGKdjarRnqab8bkOJlLYeuUfBC4pSetJ6GPrDbIFfFajY50elgkida?=
 =?us-ascii?Q?QxETI6vaHALDZBXBYmRyyMLO85w1xEraHghYQY5IcIX9XeCo4eLSOAQ3O1pg?=
 =?us-ascii?Q?5kD8/nsmCA4BLH9gJt+sSDwKluRPb5dL9n5eHaJvGwivA0EM30gD7aOO2Z7J?=
 =?us-ascii?Q?HtBKlL/XY4WfFwAzGdZGTrktKkk9MSs3aDEagBJz62A+Xl8ohOSIeWe6x7M/?=
 =?us-ascii?Q?/Iqnza3JPw+OL4zZs+FFbQC3keJSktVmmac17mjC3i4LG7LlOc2VFKinsR5/?=
 =?us-ascii?Q?FufIIHe0wuoyPwc6+22NRrkOYgNNeoWLMfpBmysKVi6P53kL+HMkyf99v1Cz?=
 =?us-ascii?Q?FxZ3miAnXjGnPQGrs2x6MA95R+r0dcPUUo7wA8cz7p6/e5id9S5fPolcrza1?=
 =?us-ascii?Q?vexJYQhg7Qf46EkPgAvlhUxSg3XF//77/3Spt+JsjDM9HWVFGxBsZbQCIX/k?=
 =?us-ascii?Q?9K9DWCPKG6RVrZb1jhmdZ+E8YR5btJwL47KXkok9JCt79hnapNW3YX80dC9d?=
 =?us-ascii?Q?6HdwUAB7hiCCtxb7ifGx71NHIGaWcdv4ni1QWU18dYuhpeGUTzBgIkz/fH31?=
 =?us-ascii?Q?tjmN+QsPh/1wye9IOk9Vhg/N7rC1su4lr/TDT36wc05UeG4LZLrA03T51stg?=
 =?us-ascii?Q?5qrAz9wQ9lZPliM+cea0RPJFoa4H2KXA+yKerZRjWXXnkU6cBNi6zYv6dRY/?=
 =?us-ascii?Q?XjLj4Vxli4dBUg8LD2CuDCSSv0uxbiS1LDRveRg2nSKZPnFqZvleHzuoo5w4?=
 =?us-ascii?Q?0T08D0pDrxskSFcHAT04QmiO7eBOSoJOOtugAcTtdRYjM65N/poJnzZ6mI/R?=
 =?us-ascii?Q?tH0evb+6AFsH37l4YN0pwE2vRemIPRE36jNYHYgd6KpRGfobgEUhkxxWpfJF?=
 =?us-ascii?Q?JfXrpebAR6H8XqAJ3EFK61E89+EEQCZwbkp9AqqtamfNBdgZgsa/x0baw6wP?=
 =?us-ascii?Q?43WduqH1c1EPDz/OX+7x42zIpzWf8m3dZukNMUINBK7/E8TMQEjfHiEcLEwP?=
 =?us-ascii?Q?tEo4ZOjvWK5vMwhMYdE/qyDpfm3x8WJGETAEeZjCipYtldZWaAgdGfXGMry0?=
 =?us-ascii?Q?t6iGKzPREkk8a1aPSIAtl4z6TbzIrpobMQru9sqqH1mvlhTY7T019q1OVc9l?=
 =?us-ascii?Q?xzjaXwb0mTx7UOebQzQyYyaJ2J4QYDIcuC+n/lOyTzKN0KmWs5copnpp4+OS?=
 =?us-ascii?Q?+9/LICrbUzOqPp1GIu/PN12+HBejHr6g3uWXoCNxFWEemPPTfCI9AZNz8zOO?=
 =?us-ascii?Q?Lnnio0H3AoR/h62ZUxTpDGXiYSS3+ZYxtPu87U9PfkpdtEoE1hV94y5vw1d9?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 465cd31d-2b2e-49af-803b-08dbb46c2e28
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 15:14:52.9725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+NBM1FLX7S4/PfBxpgVmLRHc36wU/mdWOEV5j51JWm/pFb1vAmVr6F/kfQ+rpjW/SRV6yXn4ZS6aP7cuJxWjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8242
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_fs/attr.c:#setattr_copy" on:

commit: f5cb94f57acb0e595eb8c3d113827fea9874d872 ("fs: have setattr_copy handle multigrain timestamps appropriately")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git noumask

in testcase: xfstests
version: xfstests-x86_64-b15b6cc-1_20230828
with following parameters:

	disk: 4HDD
	fs: ext4
	test: generic-631



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309132200.8a23d7bc-oliver.sang@intel.com


[  215.071844][ T2277] ------------[ cut here ]------------
[ 215.077328][ T2277] WARNING: CPU: 0 PID: 2277 at fs/attr.c:298 setattr_copy (fs/attr.c:298 fs/attr.c:355) 
[  215.085497][ T2277] Modules linked in: overlay dm_mod btrfs blake2b_generic xor intel_rapl_msr raid6_pq intel_rapl_common zstd_compress ipmi_devintf libcrc32c ipmi_msghandler x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 irqbypass crct10dif_pclmul sg crc32_pclmul crc32c_intel ghash_clmulni_intel mei_wdt sha512_ssse3 i915 rapl intel_cstate drm_buddy wmi_bmof ahci intel_gtt mei_me intel_uncore drm_display_helper libahci drm_kms_helper libata mei ttm intel_pch_thermal video wmi intel_pmc_core acpi_pad drm fuse ip_tables
[  215.137833][ T2277] CPU: 0 PID: 2277 Comm: mv Tainted: G          I        6.5.0-12734-gf5cb94f57acb #1
[  215.147529][ T2277] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[ 215.155839][ T2277] RIP: 0010:setattr_copy (fs/attr.c:298 fs/attr.c:355) 
[ 215.161192][ T2277] Code: 89 e2 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e d1 01 00 00 45 8b 2c 24 41 f6 c5 40 75 11 41 83 e5 30 0f 84 36 fd ff ff <0f> 0b e9 2f fd ff ff 48 89 df e8 67 91 ff ff 41 f6 c5 80 0f 85 93
All code
========
   0:	89 e2                	mov    %esp,%edx
   2:	48 c1 ea 03          	shr    $0x3,%rdx
   6:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   a:	84 c0                	test   %al,%al
   c:	74 08                	je     0x16
   e:	3c 03                	cmp    $0x3,%al
  10:	0f 8e d1 01 00 00    	jle    0x1e7
  16:	45 8b 2c 24          	mov    (%r12),%r13d
  1a:	41 f6 c5 40          	test   $0x40,%r13b
  1e:	75 11                	jne    0x31
  20:	41 83 e5 30          	and    $0x30,%r13d
  24:	0f 84 36 fd ff ff    	je     0xfffffffffffffd60
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 2f fd ff ff       	jmpq   0xfffffffffffffd60
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 67 91 ff ff       	callq  0xffffffffffff91a0
  39:	41 f6 c5 80          	test   $0x80,%r13b
  3d:	0f                   	.byte 0xf
  3e:	85                   	.byte 0x85
  3f:	93                   	xchg   %eax,%ebx

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 2f fd ff ff       	jmpq   0xfffffffffffffd36
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 67 91 ff ff       	callq  0xffffffffffff9176
   f:	41 f6 c5 80          	test   $0x80,%r13b
  13:	0f                   	.byte 0xf
  14:	85                   	.byte 0x85
  15:	93                   	xchg   %eax,%ebx
[  215.180862][ T2277] RSP: 0018:ffffc900008befa0 EFLAGS: 00010206
[  215.187036][ T2277] RAX: 0000000000000000 RBX: ffff8881494c1058 RCX: ffffffff81ac75f2
[  215.195071][ T2277] RDX: 1ffff92000117e2f RSI: ffff8881494c1058 RDI: ffffffff84db1ba8
[  215.203095][ T2277] RBP: ffffc900008beff0 R08: 0000000000000001 R09: fffff52000117df2
[  215.211101][ T2277] R10: ffffc900008bef97 R11: 0000000024084fc5 R12: ffffc900008bf178
[  215.219106][ T2277] R13: 0000000000000030 R14: ffffffff84db1ba0 R15: ffff8881494c1080
[  215.227152][ T2277] FS:  00007f4afa0ae800(0000) GS:ffff8887f0c00000(0000) knlGS:0000000000000000
[  215.236179][ T2277] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  215.242831][ T2277] CR2: 00007f4afa1c7f30 CR3: 000000086c588005 CR4: 00000000003706f0
[  215.250887][ T2277] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  215.258984][ T2277] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  215.267036][ T2277] Call Trace:
[  215.270373][ T2277]  <TASK>
[ 215.273403][ T2277] ? __warn (kernel/panic.c:673) 
[ 215.277575][ T2277] ? setattr_copy (fs/attr.c:298 fs/attr.c:355) 
[ 215.282322][ T2277] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 215.286872][ T2277] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 215.291339][ T2277] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 215.296043][ T2277] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 215.300963][ T2277] ? inode_maybe_inc_iversion (arch/x86/include/asm/atomic64_64.h:109 include/linux/atomic/atomic-arch-fallback.h:4232 include/linux/atomic/atomic-instrumented.h:2839 fs/libfs.c:1833) 
[ 215.306452][ T2277] ? setattr_copy (fs/attr.c:298 fs/attr.c:355) 
[ 215.310999][ T2277] ? jbd2_journal_stop (fs/jbd2/transaction.c:1964) 
[ 215.315983][ T2277] ? __ext4_mark_inode_dirty (fs/ext4/inode.c:5929) 
[ 215.321499][ T2277] ext4_setattr (include/linux/fs.h:2266 fs/ext4/inode.c:5480) 
[ 215.325960][ T2277] ? current_time (fs/inode.c:2533 fs/inode.c:2568) 
[ 215.330435][ T2277] ? inode_owner_or_capable (fs/inode.c:2532) 
[ 215.335851][ T2277] ? from_vfsuid (fs/mnt_idmapping.c:137) 
[ 215.340314][ T2277] notify_change (fs/attr.c:543) 
[ 215.344776][ T2277] ? ovl_set_timestamps+0x16d/0x210 overlay
[ 215.351343][ T2277] ? make_vfsgid (fs/mnt_idmapping.c:194) 
[ 215.355802][ T2277] ovl_set_timestamps+0x16d/0x210 overlay
[ 215.362163][ T2277] ? ovl_set_size+0x180/0x180 overlay
[ 215.368212][ T2277] ovl_set_attr (fs/overlayfs/ovl_entry.h:112 fs/overlayfs/ovl_entry.h:117 fs/overlayfs/overlayfs.h:188 fs/overlayfs/copy_up.c:358) overlay
[ 215.374082][ T2277] ? ovl_set_timestamps+0x210/0x210 overlay
[ 215.380633][ T2277] ovl_set_attr (fs/overlayfs/copy_up.c:372) overlay
[ 215.385887][ T2277] ? ovl_copy_xattr (fs/overlayfs/copy_up.c:350) overlay
[ 215.391494][ T2277] ? ovl_set_origin (fs/overlayfs/copy_up.c:454 (discriminator 4)) overlay
[ 215.396933][ T2277] ovl_copy_up_metadata (fs/overlayfs/copy_up.c:668) overlay
[ 215.402889][ T2277] ? ovl_set_origin (fs/overlayfs/copy_up.c:611) overlay
[ 215.408328][ T2277] ? ovl_create_real (fs/overlayfs/dir.c:193) overlay
[ 215.414011][ T2277] ? ovl_mkdir_real (fs/overlayfs/dir.c:173) overlay
[ 215.419592][ T2277] ovl_copy_up_workdir (fs/overlayfs/copy_up.c:746) overlay
[ 215.425464][ T2277] ? ovl_copy_up_tmpfile (fs/overlayfs/copy_up.c:706) overlay
[ 215.431507][ T2277] ? mutex_lock_interruptible (arch/x86/include/asm/atomic64_64.h:109 include/linux/atomic/atomic-arch-fallback.h:4271 include/linux/atomic/atomic-long.h:1476 include/linux/atomic/atomic-instrumented.h:4424 kernel/locking/mutex.c:171 kernel/locking/mutex.c:981) 
[ 215.436923][ T2277] ovl_do_copy_up (fs/overlayfs/copy_up.c:904) overlay
[ 215.442359][ T2277] ? ovl_copy_up_start (fs/overlayfs/overlayfs.h:602 fs/overlayfs/util.c:652) overlay
[ 215.448145][ T2277] ovl_copy_up_one (fs/overlayfs/copy_up.c:1091) overlay
[ 215.453667][ T2277] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2155 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 215.458906][ T2277] ? ovl_do_copy_up (fs/overlayfs/copy_up.c:1036) overlay
[ 215.464511][ T2277] ? depot_alloc_stack (lib/stackdepot.c:309) 
[ 215.469417][ T2277] ? stack_trace_save (kernel/stacktrace.c:123) 
[ 215.474130][ T2277] ? __stack_depot_save (lib/stackdepot.c:441) 
[ 215.479226][ T2277] ovl_copy_up_flags (fs/overlayfs/copy_up.c:1147) overlay
[ 215.484916][ T2277] ovl_rename (fs/overlayfs/dir.c:1138) overlay
[ 215.490092][ T2277] ? preempt_notifier_dec (kernel/sched/core.c:10142) 
[ 215.495165][ T2277] ? ovl_clear_empty (fs/overlayfs/dir.c:1080) overlay
[ 215.500861][ T2277] ? down_write (arch/x86/include/asm/atomic64_64.h:20 include/linux/atomic/atomic-arch-fallback.h:2608 include/linux/atomic/atomic-long.h:79 include/linux/atomic/atomic-instrumented.h:3196 kernel/locking/rwsem.c:143 kernel/locking/rwsem.c:261 kernel/locking/rwsem.c:1305 kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1574) 
[ 215.505148][ T2277] ? rwsem_down_write_slowpath (kernel/locking/rwsem.c:1571) 
[ 215.510822][ T2277] vfs_rename (fs/namei.c:4862) 
[ 215.515112][ T2277] ? path_init (fs/namei.c:4758) 
[ 215.519557][ T2277] ? d_alloc (fs/dcache.c:1862) 
[ 215.523671][ T2277] ? lookup_one_qstr_excl (fs/namei.c:1609) 
[ 215.528838][ T2277] do_renameat2 (fs/namei.c:5018) 
[ 215.533281][ T2277] ? __x64_sys_link (fs/namei.c:4900) 
[ 215.537816][ T2277] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
[ 215.543494][ T2277] ? check_heap_object (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:481 mm/usercopy.c:194) 
[ 215.548485][ T2277] ? __check_object_size (mm/memremap.c:536) 
[ 215.554162][ T2277] ? getname_flags (fs/namei.c:206) 
[ 215.559313][ T2277] __x64_sys_renameat2 (fs/namei.c:5042) 
[ 215.564209][ T2277] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 215.568498][ T2277] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  215.574259][ T2277] RIP: 0033:0x7f4afa1c7f3f
[ 215.578544][ T2277] Code: 44 00 00 48 8b 15 51 8f 17 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 49 89 ca 45 85 c0 74 40 b8 3c 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 39 41 89 c0 83 f8 ff 74 09 44 89 c0 c3 0f 1f
All code
========
   0:	44 00 00             	add    %r8b,(%rax)
   3:	48 8b 15 51 8f 17 00 	mov    0x178f51(%rip),%rdx        # 0x178f5b
   a:	f7 d8                	neg    %eax
   c:	64 89 02             	mov    %eax,%fs:(%rdx)
   f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  14:	c3                   	retq   
  15:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  1b:	49 89 ca             	mov    %rcx,%r10
  1e:	45 85 c0             	test   %r8d,%r8d
  21:	74 40                	je     0x63
  23:	b8 3c 01 00 00       	mov    $0x13c,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 39                	ja     0x6b
  32:	41 89 c0             	mov    %eax,%r8d
  35:	83 f8 ff             	cmp    $0xffffffff,%eax
  38:	74 09                	je     0x43
  3a:	44 89 c0             	mov    %r8d,%eax
  3d:	c3                   	retq   
  3e:	0f                   	.byte 0xf
  3f:	1f                   	(bad)  

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 39                	ja     0x41
   8:	41 89 c0             	mov    %eax,%r8d
   b:	83 f8 ff             	cmp    $0xffffffff,%eax
   e:	74 09                	je     0x19
  10:	44 89 c0             	mov    %r8d,%eax
  13:	c3                   	retq   
  14:	0f                   	.byte 0xf
  15:	1f                   	(bad)  


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230913/202309132200.8a23d7bc-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

