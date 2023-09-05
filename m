Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310267924C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjIEP7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353360AbjIEGKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:10:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7FE6
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693894236; x=1725430236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jvee1BZdYJkBBGjTLPzs4KNAnftdavbSYdz4uy9wmmI=;
  b=DlqBl5/2MtK1SbL7Vm8EbtbZomtjUZSfw46DaSEi33YYt4p/7N22RrrP
   0Y2Z7fFaU6NKrOwWTSIoIG8Qn+7X0iPl59T46OD5PyMGTBjI6SDYct0GO
   rZV9zcHAwGxIi4urlcbOV4+XewyhNOaSQ51q7e1DiuNXaaNFj66zBBA85
   Phr6NW1lUwkBQygpEcoRLe2LCwS5s8GxcbSSTCawwgI2cMyn395zu4r/l
   xmaM2mcX5FU4cJlOqT18woyb1JJFowN7kzpdZlAiMZ0qswRJEBBUsLMhD
   ypyyTxLZYY+940tT5Ka+oEkIoV6IpOu/ZFtLGgngfc1wz8QsVZcvODOG5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="443115990"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="443115990"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 23:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884202817"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="884202817"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 23:10:27 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 23:10:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 23:10:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 23:10:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dayFtkv0uGQY9ZMnCDU0ryC1jQK+AxuaQndrSwW4r33CptS7hlHuZEZA03sdyMiEjXMQPNrcCljDtuZq6XL7kF5QTQnue9aOB5EMfv5yELVlGbte/V1xgTF6TAMSbRz3bmBRZdWatuiVAJ7MTvzFsYUsvfnbrzQkIuVUq86sZRao5EB25ObeYPdFSCEY+POtddb9VfxC3zE4RyC/O538KEIFe5bcqpLPZgALLfmm+Heo9CcbfurXgLWcdpsA2O9G50cd2ikhTW+m2T8qyqX6V9PUnBxmUeXX+MDjsEzTeAVPLDAaeNnx1jXpc9hPv+3weN3RGSiAPPjMXMHMK16HYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeJ6a3eVOx0igukoohHhbE0T80ufA59uykcRKoZS+tM=;
 b=C+5lyIW9WsSrgWejoP/HuvXkx71YlS8OesCF2McRavvb/VE6ndrdbPjbElCNuEJFvL3hsPXMi8HGLBMrg+dlXorVFfdOlMOn3Ss5YdtfhQuJSudnYEnQ+XSgOLyuBYpGklRJRlTghx3OYtwDM9aU/ju8nVklAct0iL2T511AC3kpuESocCWqiWY8mL+WgRRUBiqf+xw8FeuC+fp5CJvLBeMy19N+5UOluaSwXTgsCNlDWwgZ3kCIor2tb1rpCnYnEdSRlCHbMUQkDVzvHtsehd2wCUMxRp6bGlIhSTpTRsMxlm9+E47nWHLcrpnM+6D8Pj2MvyoSLLgzGXaBYeurrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 06:10:31 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::ad05:7752:a9bd:2eb9]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::ad05:7752:a9bd:2eb9%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 06:10:31 +0000
Date:   Tue, 5 Sep 2023 14:10:22 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <devel@driverdev.osuosl.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        <linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [driver-core:debugfs_cleanup] [sysfs]  868bc4ac86:
 WARNING:at_fs/sysfs/group.c:#sysfs_remove_group
Message-ID: <202309051359.dcd93d4f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To SJ0PR11MB6792.namprd11.prod.outlook.com
 (2603:10b6:a03:485::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6792:EE_|SA1PR11MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 21cccc93-b8e2-486a-fde6-08dbadd6cf0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ot4dz4Y1ugKzPwD9Qb4gmlV3wp4U3U6GtDDpqKFTIlP/MylX0nGsJ1JaGlPYchaAQubIIl2V2TzNBGbNC0VMk7qNriSSx3Ldz27JJ0/aIlfZ+ZHtHkH+/0rwYrkjyaEnCO2fLHlts3gwWu/FXm+FMJs3RS426p/xvSGiinKs7SX2iWPRXkZ3X/j8tFBVyEQGuztLuSqArn862rbr8C+1d0MkuDpxvLAFkJolUJs//U/s/WmK+3yjb1GAlhSAVznQgcXqKoL7LdJPFJBWQUiEdjmy0aeKOYAtd/el0dZ4um3ZnX8WEMg5mKBSC7P93OQscNJtOzly5VZQb2qQqcQzA70pxowCMtW3QyW48V5vEMkLsLu9S9gV7SnuUzoCdZSqtAXBco2H0bxeWDtHpIxrgukOt9LlOdR63HnG32TAxFcom91Jz0lr1nIWVPpdVWboNzJz6KtBstNSJtHS3/F8uhhxyxzN/dfNl1uwEqbnaDJ/mSNvThgknd/PfrHpsBjQ2zWp8R4doEfElYPkq4qn1orjjmZX6Zj8L9ZLQwMyyqkg3bBaS/K2CY+w4axIryyMEuYRwyPnpoEaLyQOxlLQVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(186009)(451199024)(1800799009)(2906002)(82960400001)(38100700002)(36756003)(86362001)(41300700001)(6512007)(6486002)(6506007)(6916009)(316002)(66476007)(66556008)(66946007)(107886003)(4326008)(8676002)(2616005)(1076003)(8936002)(45080400002)(478600001)(966005)(6666004)(5660300002)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYgpijBuo5dMqkp2zkvB+6ytxjFxQnmr2ylFt1pG8vFTWggEIlhFvV9AXwEY?=
 =?us-ascii?Q?ekQ5elUVZjVwlzraROGHrwr3uyv8QMWyfkQndhuyh/1IbC3OdaOrOFQHdSc7?=
 =?us-ascii?Q?21Ln3XvQRWaVDioWFVqDhs320OlT+6wrimviNldcm/WcJ9dOa1zBviT9aPLR?=
 =?us-ascii?Q?YuTQwooBZ/k573xYmIdqkxKJxK/Vfon2moz8Gco0Oblvc7bA/pUkUcNc0fiJ?=
 =?us-ascii?Q?zt39IMs1adNADd2GVa2auPewCGVHegd5PVykmShPLdPyFZWsj5Yc9J8HyFCF?=
 =?us-ascii?Q?kuDvZv10nZx1re5z/LbN+mkdKwiczyyu8qa1kCXNGETV5fmTASORGLSY9A0B?=
 =?us-ascii?Q?oQaELoVji6Z6F3JJONNmLs6SdRaRH1MxFgiDRZIp6Cwya192luGROm9rnZk9?=
 =?us-ascii?Q?Hl3mSrvAyliEJdoVkx9uk19nuZ0YKVR7VoTZWvTXTtfGnpndco0SDO5TSajh?=
 =?us-ascii?Q?CnnXCMvwtFrFvF7x62XuxYSWA255M/YVIbqeKYe5RmL7OaWsVVVHZWZZaVdW?=
 =?us-ascii?Q?d4xb6Uc/0iC9jqPay7pYkaPk3oVtcoJ4X9OA72O+yyglr94W7pDGXy2VU+mw?=
 =?us-ascii?Q?W0bPXv0/iWldv8i1Jv/fooRtE7Ly3mClnc/3nMjrbB+dFU6g6GHiPKot8U3h?=
 =?us-ascii?Q?yd/xSDJk7X54d/awMmxAEeNYiJubgIvWFfVPe8oH0tMv+VCu52xhDEZhV1OR?=
 =?us-ascii?Q?z5Vs3yLsvz9jNXwUUQTMm99/jVuMZBrjS2De+rRvFQYtkdK87V6qmQp05Mi2?=
 =?us-ascii?Q?eqvZc2c+Ja5S3bYvQc27WfnGm2g5U2cvooA2SyREuBwDw0q3caMsjFibOIfu?=
 =?us-ascii?Q?OXypl46fn7S/vlJmIn9Aw40o6qjWU2hMMhrTvL65vBWuQZ3BEJ/sn20xfQ7o?=
 =?us-ascii?Q?Kw/h59UXcA9e6qq2PVic5Jg2M70HlgBLDRVDFqVGtHGM7hhfEwLva8gZuNuJ?=
 =?us-ascii?Q?39YB5j889+L0+9g3ptP83ASAoEckQHuKyg5KZWBunC5NTCX8sDe6Y9QoD5P9?=
 =?us-ascii?Q?+IvisjHll4Zlmr9OqxZd2HnBN+WpREHFlZ2m//lGtj7soE7JksH8LVA11jPa?=
 =?us-ascii?Q?Cf5Ig3+qaHD9sWCGjv7IWqf7jIVF3lP4pGSYSyNuGKCPWTiOcLWpAkJSf5kK?=
 =?us-ascii?Q?wIA8g0vwYquxl/fFpRG/n4344P/qwy8+FzDsVn3EWV//C45AT0F94S7+Hy3P?=
 =?us-ascii?Q?majBA3ha6P5q33cUvIGBcu6bfsCoy1eNJZV+5Ej+XYqa3M/cbC9oTZnxUgQx?=
 =?us-ascii?Q?Mc37qYOB0bC5kudt6OwIz3PFyz5AUWNyZa7v+ASI0NCleVaCXmquST140KVR?=
 =?us-ascii?Q?C+ULijkNqX1Ok9ZJV99m3WZ2iX2er2bUAzO/bGgLvJSZHl8kPPwR7cVUV5v5?=
 =?us-ascii?Q?WMxzQ8d3QftS26STRtRZ4C09XPETQtiAa7fkQPGknVpRdbsNzxRYZL2Pz4Fc?=
 =?us-ascii?Q?SDJz/qRNcLusR2DWuUPnkcis1klAplyQx1v5CdCHCXmPbgjxC8kBnzL6GUcO?=
 =?us-ascii?Q?CnkB7xDiOq0jGBv2bJGErOxzRDjPOSw6RzY7MtkFGwYBKRcWhISeIzn1g4PM?=
 =?us-ascii?Q?yxtWX9gP/KoQDY7bE7BWoXcfMXAjzPO5A14dIbuIqKbKvk8WFgv6SiIuJAIi?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cccc93-b8e2-486a-fde6-08dbadd6cf0c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 06:10:31.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEEsW6g2Rwdy3F1KKQ1x9PbmGgjjE1NlFJjkFgaF1cjKPhlq5WWVXrKKacfdJ6TmCzNYJzY7EHbdSXBrQD7f1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
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



Hello,

kernel test robot noticed "WARNING:at_fs/sysfs/group.c:#sysfs_remove_group" on:

commit: 868bc4ac8686c4118c66bd6926b777ded345309e ("sysfs: do not create empty directories if no attributes are present")
https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git debugfs_cleanup

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------+------------+------------+
|                                                 | ef43695802 | 868bc4ac86 |
+-------------------------------------------------+------------+------------+
| WARNING:at_fs/sysfs/group.c:#sysfs_remove_group | 0          | 8          |
| RIP:sysfs_remove_group                          | 0          | 8          |
+-------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309051359.dcd93d4f-oliver.sang@intel.com


[   17.350543][    T1] ------------[ cut here ]------------
[   17.351171][    T1] sysfs group 'power' not found for kobject 'serial0'
[ 17.351982][ T1] WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:303 sysfs_remove_group (kbuild/src/rand/fs/sysfs/group.c:301) 
[   17.353035][    T1] Modules linked in:
[   17.353499][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-10211-g868bc4ac8686 #6
[   17.354450][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 17.355602][ T1] RIP: 0010:sysfs_remove_group (kbuild/src/rand/fs/sysfs/group.c:301) 
[ 17.356262][ T1] Code: 8b 34 24 4c 89 f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 86 14 d6 ff 49 8b 17 48 c7 c7 80 b6 f6 84 4c 89 f6 e8 f4 d5 4b ff <0f> 0b e9 fc 00 00 00 e8 a8 4d 81 ff 4c 8b 6d d0 4d 8d 7c 24 20 4c
All code
========
   0:	8b 34 24             	mov    (%rsp),%esi
   3:	4c 89 f8             	mov    %r15,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   e:	74 08                	je     0x18
  10:	4c 89 ff             	mov    %r15,%rdi
  13:	e8 86 14 d6 ff       	call   0xffffffffffd6149e
  18:	49 8b 17             	mov    (%r15),%rdx
  1b:	48 c7 c7 80 b6 f6 84 	mov    $0xffffffff84f6b680,%rdi
  22:	4c 89 f6             	mov    %r14,%rsi
  25:	e8 f4 d5 4b ff       	call   0xffffffffff4bd61e
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 fc 00 00 00       	jmp    0x12d
  31:	e8 a8 4d 81 ff       	call   0xffffffffff814dde
  36:	4c 8b 6d d0          	mov    -0x30(%rbp),%r13
  3a:	4d 8d 7c 24 20       	lea    0x20(%r12),%r15
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 fc 00 00 00       	jmp    0x103
   7:	e8 a8 4d 81 ff       	call   0xffffffffff814db4
   c:	4c 8b 6d d0          	mov    -0x30(%rbp),%r13
  10:	4d 8d 7c 24 20       	lea    0x20(%r12),%r15
  15:	4c                   	rex.WR
[   17.358463][    T1] RSP: 0000:ffffc9000001ee98 EFLAGS: 00010246
[   17.359141][    T1] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
[   17.360026][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   17.360926][    T1] RBP: ffffc9000001eed0 R08: 0000000000000000 R09: 0000000000000000
[   17.361839][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff851d26c0
[   17.362736][    T1] R13: 1ffffffff0a3a4d8 R14: ffffffff851d26a0 R15: ffff88816d32c000
[   17.363619][    T1] FS:  0000000000000000(0000) GS:ffff8883ae800000(0000) knlGS:0000000000000000
[   17.364612][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.365352][    T1] CR2: ffff88843ffff000 CR3: 0000000005c71000 CR4: 00000000000406b0
[   17.366243][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   17.367132][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   17.368042][    T1] Call Trace:
[   17.368423][    T1]  <TASK>
[ 17.368767][ T1] ? show_regs (kbuild/src/rand/arch/x86/kernel/dumpstack.c:479) 
[ 17.369267][ T1] ? __warn (kbuild/src/rand/kernel/panic.c:235) 
[ 17.369764][ T1] ? sysfs_remove_group (kbuild/src/rand/fs/sysfs/group.c:301) 
[ 17.370364][ T1] ? sysfs_remove_group (kbuild/src/rand/fs/sysfs/group.c:301) 
[ 17.370964][ T1] ? report_bug (kbuild/src/rand/lib/bug.c:?) 
[ 17.371492][ T1] ? handle_bug (kbuild/src/rand/arch/x86/kernel/traps.c:237) 
[ 17.371993][ T1] ? exc_invalid_op (kbuild/src/rand/arch/x86/kernel/traps.c:258) 
[ 17.372544][ T1] ? asm_exc_invalid_op (kbuild/src/rand/arch/x86/include/asm/idtentry.h:568) 
[ 17.373122][ T1] ? sysfs_remove_group (kbuild/src/rand/fs/sysfs/group.c:301) 
[ 17.373713][ T1] ? sysfs_remove_group (kbuild/src/rand/fs/sysfs/group.c:301) 
[ 17.374299][ T1] ? sysfs_unmerge_group (kbuild/src/rand/fs/sysfs/group.c:?) 
[ 17.374900][ T1] dpm_sysfs_remove (kbuild/src/rand/drivers/base/power/sysfs.c:?) 
[ 17.375432][ T1] device_del (kbuild/src/rand/drivers/base/core.c:3742) 
[ 17.375928][ T1] ? _raw_spin_unlock_irq (kbuild/src/rand/arch/x86/include/asm/irqflags.h:42 kbuild/src/rand/arch/x86/include/asm/irqflags.h:77 kbuild/src/rand/include/linux/spinlock_api_smp.h:159 kbuild/src/rand/kernel/locking/spinlock.c:202) 
[ 17.376524][ T1] serdev_controller_add (kbuild/src/rand/drivers/tty/serdev/core.c:?) 
[ 17.377124][ T1] ? serdev_controller_alloc (kbuild/src/rand/include/linux/pm_runtime.h:120) 
[ 17.377764][ T1] serdev_tty_port_register (kbuild/src/rand/drivers/tty/serdev/serdev-ttyport.c:302) 
[ 17.378409][ T1] tty_port_register_device_attr_serdev (kbuild/src/rand/drivers/tty/tty_port.c:191) 
[ 17.379186][ T1] serial_core_register_port (kbuild/src/rand/include/linux/err.h:61 kbuild/src/rand/drivers/tty/serial/serial_core.c:3151 kbuild/src/rand/drivers/tty/serial/serial_core.c:3355) 
[ 17.379876][ T1] serial_ctrl_register_port (kbuild/src/rand/drivers/tty/serial/serial_ctrl.c:41) 
[ 17.380497][ T1] uart_add_one_port (kbuild/src/rand/drivers/tty/serial/serial_port.c:75) 
[ 17.381037][ T1] serial8250_register_8250_port (kbuild/src/rand/drivers/tty/serial/8250/8250_core.c:1141) 
[ 17.383151][ T1] serial_pnp_probe (kbuild/src/rand/drivers/tty/serial/8250/8250_pnp.c:448) 
[ 17.383823][ T1] pnp_device_probe (kbuild/src/rand/drivers/pnp/driver.c:113) 
[ 17.384380][ T1] ? __cfi_pnp_device_probe (kbuild/src/rand/drivers/pnp/driver.c:83) 
[ 17.384993][ T1] really_probe (kbuild/src/rand/drivers/base/dd.c:?) 
[ 17.385523][ T1] ? __kasan_check_write (kbuild/src/rand/mm/kasan/shadow.c:37) 
[ 17.386109][ T1] __driver_probe_device (kbuild/src/rand/drivers/base/dd.c:800) 
[ 17.386707][ T1] driver_probe_device (kbuild/src/rand/drivers/base/dd.c:830) 
[ 17.387271][ T1] __driver_attach (kbuild/src/rand/drivers/base/dd.c:1217) 
[ 17.387808][ T1] bus_for_each_dev (kbuild/src/rand/drivers/base/bus.c:367) 
[ 17.388358][ T1] ? __cfi___driver_attach (kbuild/src/rand/drivers/base/dd.c:1157) 
[ 17.388972][ T1] driver_attach (kbuild/src/rand/drivers/base/dd.c:1233) 
[ 17.389487][ T1] bus_add_driver (kbuild/src/rand/drivers/base/bus.c:674) 
[ 17.390031][ T1] driver_register (kbuild/src/rand/drivers/base/driver.c:247) 
[ 17.390573][ T1] ? __cfi_serial8250_init (kbuild/src/rand/drivers/tty/serial/8250/8250_core.c:1220) 
[ 17.391178][ T1] pnp_register_driver (kbuild/src/rand/drivers/pnp/driver.c:274) 
[ 17.391741][ T1] serial8250_pnp_init (kbuild/src/rand/drivers/tty/serial/8250/8250_pnp.c:533) 
[ 17.392309][ T1] serial8250_init (kbuild/src/rand/drivers/tty/serial/8250/8250_core.c:1241) 
[ 17.392838][ T1] do_one_initcall (kbuild/src/rand/init/main.c:1232) 
[ 17.393762][ T1] do_initcall_level (kbuild/src/rand/init/main.c:1293) 
[ 17.394329][ T1] ? kernel_init (kbuild/src/rand/init/main.c:1439) 
[ 17.394845][ T1] do_initcalls (kbuild/src/rand/init/main.c:1307) 
[ 17.395351][ T1] do_basic_setup (kbuild/src/rand/init/main.c:1330) 
[ 17.395871][ T1] kernel_init_freeable (kbuild/src/rand/init/main.c:1548) 
[ 17.396469][ T1] ? __cfi_kernel_init (kbuild/src/rand/init/main.c:1429) 
[ 17.397019][ T1] kernel_init (kbuild/src/rand/init/main.c:1439) 
[ 17.397509][ T1] ? __cfi_kernel_init (kbuild/src/rand/init/main.c:1429) 
[ 17.398057][ T1] ret_from_fork (kbuild/src/rand/arch/x86/kernel/process.c:153) 
[ 17.398552][ T1] ? __cfi_kernel_init (kbuild/src/rand/init/main.c:1429) 
[ 17.399110][ T1] ret_from_fork_asm (kbuild/src/rand/arch/x86/entry/entry_64.S:312) 
[   17.399669][    T1]  </TASK>
[   17.400010][    T1] irq event stamp: 468845
[ 17.400490][ T1] hardirqs last enabled at (468853): __up_console_sem (kbuild/src/rand/arch/x86/include/asm/irqflags.h:19) 
[ 17.401573][ T1] hardirqs last disabled at (468860): __up_console_sem (kbuild/src/rand/kernel/printk/printk.c:345) 
[ 17.402694][ T1] softirqs last enabled at (468874): __irq_exit_rcu (kbuild/src/rand/kernel/softirq.c:612) 
[ 17.403770][ T1] softirqs last disabled at (468869): __irq_exit_rcu (kbuild/src/rand/kernel/softirq.c:612) 
[   17.404828][    T1] ---[ end trace 0000000000000000 ]---
[   17.407738][    T1] serial 00:05: using ACPI '_SB.PCI0.S08.COM1' for 'rs485-term' GPIO lookup
[   17.408738][    T1] acpi PNP0501:01: GPIO: looking up rs485-term-gpios
[   17.409505][    T1] acpi PNP0501:01: GPIO: looking up rs485-term-gpio
[   17.410252][    T1] serial 00:05: using lookup tables for GPIO lookup
[   17.411001][    T1] serial 00:05: No GPIO consumer rs485-term found
[   17.411723][    T1] serial 00:05: using ACPI '_SB.PCI0.S08.COM1' for 'rs485-rx-during-tx' GPIO lookup
[   17.412831][    T1] acpi PNP0501:01: GPIO: looking up rs485-rx-during-tx-gpios
[   17.413677][    T1] acpi PNP0501:01: GPIO: looking up rs485-rx-during-tx-gpio
[   17.414499][    T1] serial 00:05: using lookup tables for GPIO lookup
[   17.415230][    T1] serial 00:05: No GPIO consumer rs485-rx-during-tx found
[   17.417775][    T1] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230905/202309051359.dcd93d4f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

