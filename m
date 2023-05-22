Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B033470B304
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 04:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjEVCFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 22:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVCFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 22:05:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B4DC7;
        Sun, 21 May 2023 19:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684721150; x=1716257150;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vfhpZY9wg6vnnSHA0cRTFw32CLMHifbpKCe6Wb7Cqss=;
  b=G60Jlk7y3UU9GXabprLpeEwbVMDUic2VBNTPAnz8bpRwKoODRMnjrC+I
   sGj9ci0pd8fWu9PmVNtWbPav5DNMawrvZwMr1d2Le6fMMGmWyr8XGD3Ms
   M3vc6owl5Lchhh9JJjx2L1nbslCXEzU62oVg4wEPX95qc7W1OrEyI5zyV
   okc5dKhPl+WWeePGqn76U6ZbOVLWYFgnIDiX6PjsrUubVKhpJphsFxRs8
   txYPu7vqOEed5E2weMNNSDWR4/z4+l+d4URnD8wB0h0lWehgsGYfGnVJQ
   xUQzcNOZ8Voo6CvAuUATfgaXx3g6Kzkw2XTqg5X4GQsDrLB8F/kHk0XIf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="352832089"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="352832089"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 19:05:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="734073720"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="734073720"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2023 19:05:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 21 May 2023 19:05:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 21 May 2023 19:05:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 21 May 2023 19:05:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdgnUve+NvhIZfYkZLzMOASujvCxQcECexFC5SlADqt5Dqi2Q+89z2ngTwEu7YlRA04lYm7yRyyJ1e0nQ0aSrfw9wDs83AcwZ/aikgrxZrOJbLZn6lJI/qK1y0T0x96LC09XOmPE6FTvDbG292Ylm08m7jy+uJpbMxpxqhs1c5Fle3rhLItjVIYMA1pxBfJci+ZvQi1W7RhYM1mZQuMSjQQf7YNeVCQeOMjpcnUUWmVP8o7ZRlgBS7EHhZAUvr2H3tplcCfe5WIYBqwa7QjrS+E51NbeJHRSzyA2T8LBxqCOzeM+H5d9pd/vIhV2MxZCS1XFhr60qcRwow28PCp7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L257pdm/0cEk3hTb4pUI3lh7r2q6vYDLmS9+8Qr2d3U=;
 b=mkrG3QDbmrthry+CiTFLsKhxbRXFEt/8gcMVLfUXsx1nE9Tp1HkgmD7vEINIaoMZzFD204jy/ZjcDKzHvu/99gaHoFg9MyRElSbljd2QleDWLrH30SWo+TumOL6PNr5rx0KYWl02id2a9fmcSVOmpCRaLGoTioUUj7vncIakEOEjlRSB/u8uKI83uVNTpILbXnLNxBaNRJrRKjJ9pqcMiq4hJh2k/zSqVQGLkySeQ01L25t3RQw1fNAe0wRWbIFX9EgPYI0lLuI5o38qszk2zQamMeBGI1S8I8NJTcq22sG2axOKVthqmzS2y5BiLWSyzuTZP3kzOdEcjXgUfIlKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 02:05:36 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7ca2:120f:99dd:7812%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 02:05:35 +0000
Date:   Mon, 22 May 2023 10:07:28 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <heng.su@intel.com>, <dchinner@redhat.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is BUG: unable to handle kernel NULL
 pointer dereference in xfs_extent_free_diff_items in v6.4-rc3
Message-ID: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH0PR11MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d59014-8c90-4188-1504-08db5a6907d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYxnm0ID5+UAYL2Y4NRWonDhna0YmIrP81kzs5faMLgPcjAqWwrjyeVpDd0WBmAFatuhh1LqANnnXDl9bpo6MNJ9DJa6E3FQa8u4d/6/pLJyTMiI4Snh1ZkTHs3Qw7pY1wCfJDbV38uQ9EHxcLo4Ir6koh3m30N2lt+RiSjTkfaZNIOHot8F9J5yoknXwRvkFl3MniyNO1sUaanluo1HGh8sxlHtIe+EzrM1HLRyxb+zG2ROXP4LCm2l428ztipH27bTxc8G9T/s3SgJtoWiOuneeSFpxCezbn4r0XuwxA2a8reujjm4vsndKxwovVGgTGUch0hABm8229zL/GcbYygY/+FkJ3kjfXOJ3I67UhsAnEyZsoL9PTBN2myJTsB8bXM0FqpnxHIkFsou9+NC3hJydw5kTwJ2AxlX6yl90A/U2EGSMLxF0jcGm/G5+zmHfzPzWmJ8TQfMB38djTWC/XDYrT/hDw7uQMcyfky5v6vTcsAhmPbPTz3mL8o+Gvl4j/JCk3dnegNExXwTTFBxynFc4VtdIB0Z0IpsKYZQOHypZAxmxhr9IOUsdGo9s1D9luX5Om3+/7wtsg/gsW8JCjRk7rFcCJs0NengBaau0b/XVmANFL3+dbrEjic1MJUEENo5Su6JliUrRaqnSFIdfVWNPxjKqyOCmGfff4VyUj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(44832011)(83380400001)(186003)(26005)(6512007)(6506007)(86362001)(107886003)(38100700002)(82960400001)(41300700001)(6666004)(6486002)(45080400002)(966005)(66476007)(66556008)(66946007)(316002)(6916009)(4326008)(478600001)(2906002)(21314003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9C9A2eTAJiYw2n4sFSgbGBbb+UM0aRPs0BPiE8IgZdGp6qQftf5lbat2ClXt?=
 =?us-ascii?Q?NrZkoV9SmSLJlDb4+NhzWwukECHFG9UmGjpE78wWGDmljOYuyYKcRMIO6u6f?=
 =?us-ascii?Q?UQiO15YUiUQRUPHzEfhmEc5DEq0FBcgsNKURU2RY+lovh+cHWaxLk+wEmDzk?=
 =?us-ascii?Q?iP59Yb6kjHq2gD0X/873SJlXU25cWH7wjcT9azfY1FRXqbS2CIgrNsZejwHC?=
 =?us-ascii?Q?pm8F4F+WNLjbHdJHfMY/cseF6LE0roXIDIl2EeuOhhU2W6HJ3EblEVu3okZI?=
 =?us-ascii?Q?l+V60mPbnJTp1lv3xq3WkoeIy3gltCMFYii3buF4Cvg7IH4SsChE1NSVtfYd?=
 =?us-ascii?Q?V27QfGlSYdNi8ohCiHkooiN4FNjunypAR/yNecpvHHUg2hCU8ypHpxX5nmgJ?=
 =?us-ascii?Q?LQMhCk20pTU45WpNJwHYcNN2TomwEb6b9gEF/miQS1Fnkw2GHO6aRvlw/PVz?=
 =?us-ascii?Q?oyQpDUbmVB+rt9iWReJhHbEPUnYKOnoYQbqMiYj6FuR6idzcKm/ji+BFAYbv?=
 =?us-ascii?Q?qCTS1kmZ7m0K8HmrSf6KXbbIuub3VSA86lZ/FGn3sFEgbembeg3LC4DYfJra?=
 =?us-ascii?Q?JNqmlMQXWgPFpdjjGymjcFKvQCMUmJmeSTDoAr36MVupuK52Qu5GQz3ChGq/?=
 =?us-ascii?Q?PYULS5/BzlT0Zid4SbGLegOSfUEcKKY8cifxOjo0QaIWaeFOAhfKZv8BmqAU?=
 =?us-ascii?Q?WcMUE3z4IpXdSsrGRkT4zT6NAHbdlDh8OHPxc1mPssVL8iT3H1PxnE8qQgpm?=
 =?us-ascii?Q?zIFoes78IEfbrZpgG5FbpStlsDub5vk23iLQRTxITLKasQ1BGmsJY18ictf6?=
 =?us-ascii?Q?vuoqdEJJdRySxnT/zFr9RRxIHB4hB+UDhseJo5kFxkEzHNbcZA5yXwEhvCqo?=
 =?us-ascii?Q?jN/agGVOTs8IX42WczxdjG8iAjr8VoJIjHbgypvR/mxMmK43yhSKahhdLI51?=
 =?us-ascii?Q?KlFMh/UJkzkA9iqviPa6gvMu9ZOtz6/UMU14n1pg+Fhyvt+hY5S2AkB/zhok?=
 =?us-ascii?Q?dZIIQgkC2PTyVTQy1bZi9NCbdCDGuNSD+3FgmLUU8aOJVcXEHRXEuTbkVEde?=
 =?us-ascii?Q?FxYum7moBhC9SzURUdj3mXEdAVRtBmcKIK9GJRPaSbmvrw6L7HpZgU9HtrfT?=
 =?us-ascii?Q?qfN7oR1XLFMPhDRBwBPK0mJMjOQQNUMGrPefTa2/ogLus/5l7osTlcoVmcBq?=
 =?us-ascii?Q?delGkniK2XZfKpOW3bG7AU2pLNQbyM/zLSo5GemXRkE3YmsRy+gJtADA0y8P?=
 =?us-ascii?Q?yD9STZLu/hVVwZ85yB+o9eFoMxbmKrlmEPvC/+LcZjnvkRDPOvZW/yFiXtop?=
 =?us-ascii?Q?4/qojxvbA4yOXEW9kMnFeRGLX1SHkyZoI3syGlbeTBHDH58j91mW1Tf+gDEM?=
 =?us-ascii?Q?cICs0JVqa8zUkUG2oKIBEitLC79ILMO3TvT1Lk3dX6KUjAZRpjD3DKuC91Lh?=
 =?us-ascii?Q?FntcPh/yrlnUoysLiAZVW1QgYqIQGMJZa4Dq8E+1mtX1csgfaLzZ1dIi8wPI?=
 =?us-ascii?Q?nEIazS8+R6o+CbffB+nosagRqxopbIOxg+/4Qki84M7IAvX32TkUxXW2Qt+I?=
 =?us-ascii?Q?I+qXTNgHnz+8CobBqtnmCQEyZML5P7MiS7nICPqK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d59014-8c90-4188-1504-08db5a6907d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 02:05:35.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/Gb0rFrligeucaE9KGkK6d6FQyCxC4wcuDj0YJy1YBIO3DguSIKgWUbhFmQGYRMWix2Uy/7sGwRQ6TKHAL0Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

Greeting!
There is BUG: unable to handle kernel NULL pointer dereference in
xfs_extent_free_diff_items in v6.4-rc3:

Above issue could be reproduced in v6.4-rc3 and v6.4-rc2 kernel in guest.

Bisected this issue between v6.4-rc2 and v5.11, found the problem commit is:
"
f6b384631e1e xfs: give xfs_extfree_intent its own perag reference
"

report0, repro.stat and so on detailed info is link: https://github.com/xupengfe/syzkaller_logs/tree/main/230521_043336_xfs_extent_free_diff_items
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/repro.c
Syzkaller reproduced prog: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/repro.prog
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_043336_xfs_extent_free_diff_items/v6.4-rc3_reproduce_dmesg.log

v6.4-rc3 reproduced info:
"
[   91.419498] loop0: detected capacity change from 0 to 65536
[   91.420095] XFS: attr2 mount option is deprecated.
[   91.420500] XFS: ikeep mount option is deprecated.
[   91.422379] XFS (loop0): Deprecated V4 format (crc=0) will not be supported after September 2030.
[   91.423468] XFS (loop0): Mounting V4 Filesystem d28317a9-9e04-4f2a-be27-e55b4c413ff6
[   91.428169] XFS (loop0): Ending clean mount
[   91.429120] XFS (loop0): Quotacheck needed: Please wait.
[   91.432182] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   91.432770] #PF: supervisor read access in kernel mode
[   91.433216] #PF: error_code(0x0000) - not-present page
[   91.433640] PGD 0 P4D 0 
[   91.433864] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   91.434232] CPU: 0 PID: 33 Comm: kworker/u4:2 Not tainted 6.4.0-rc3-kvm #2
[   91.434793] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[   91.435445] Workqueue: xfs_iwalk-393 xfs_pwork_work
[   91.435855] RIP: 0010:xfs_extent_free_diff_items+0x27/0x40
[   91.436312] Code: 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 f4 53 48 89 d3 e8 05 73 7d ff 49 8b 44 24 28 48 8b 53 28 5b 41 5c <8b> 40 08 5d 2b 42 08 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00
[   91.437812] RSP: 0000:ffffc9000012b8c0 EFLAGS: 00010246
[   91.438250] RAX: 0000000000000000 RBX: ffff8880015826c8 RCX: ffffffff81d71e41
[   91.438840] RDX: 0000000000000000 RSI: ffff888001ca4800 RDI: 0000000000000002
[   91.439430] RBP: ffffc9000012b8c0 R08: ffffc9000012b8e0 R09: 0000000000000000
[   91.440019] R10: ffff88800613f290 R11: ffffffff83e426c0 R12: ffff888001582230
[   91.440610] R13: ffff888001582428 R14: ffffffff81b042c0 R15: ffffc9000012b908
[   91.441202] FS:  0000000000000000(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
[   91.441864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.442343] CR2: 0000000000000008 CR3: 000000000ed22006 CR4: 0000000000770ef0
[   91.442941] PKRU: 55555554
[   91.443178] Call Trace:
[   91.443394]  <TASK>
[   91.443585]  list_sort+0xb8/0x3a0
[   91.443885]  xfs_extent_free_create_intent+0xb6/0xc0
[   91.444312]  xfs_defer_create_intents+0xc3/0x220
[   91.444711]  ? write_comp_data+0x2f/0x90
[   91.445056]  xfs_defer_finish_noroll+0x9e/0xbc0
[   91.445449]  ? list_sort+0x344/0x3a0
[   91.445768]  __xfs_trans_commit+0x4be/0x630
[   91.446135]  xfs_trans_commit+0x20/0x30
[   91.446473]  xfs_dquot_disk_alloc+0x45d/0x4e0
[   91.446860]  xfs_qm_dqread+0x2f7/0x310
[   91.447192]  xfs_qm_dqget+0xd5/0x300
[   91.447506]  xfs_qm_quotacheck_dqadjust+0x5a/0x230
[   91.447921]  xfs_qm_dqusage_adjust+0x249/0x300
[   91.448313]  xfs_iwalk_ag_recs+0x1bd/0x2e0
[   91.448671]  xfs_iwalk_run_callbacks+0xc3/0x1c0
[   91.449071]  xfs_iwalk_ag+0x32e/0x3f0
[   91.449398]  xfs_iwalk_ag_work+0xbe/0xf0
[   91.449744]  xfs_pwork_work+0x2c/0xc0
[   91.450064]  process_one_work+0x3b1/0x860
[   91.450416]  worker_thread+0x52/0x660
[   91.450739]  ? __pfx_worker_thread+0x10/0x10
[   91.451113]  kthread+0x16d/0x1c0
[   91.451406]  ? __pfx_kthread+0x10/0x10
[   91.451740]  ret_from_fork+0x29/0x50
[   91.452064]  </TASK>
[   91.452261] Modules linked in:
[   91.452530] CR2: 0000000000000008
[   91.452819] ---[ end trace 0000000000000000 ]---
[   91.487979] RIP: 0010:xfs_extent_free_diff_items+0x27/0x40
[   91.488463] Code: 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 f4 53 48 89 d3 e8 05 73 7d ff 49 8b 44 24 28 48 8b 53 28 5b 41 5c <8b> 40 08 5d 2b 42 08 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00
[   91.490021] RSP: 0000:ffffc9000012b8c0 EFLAGS: 00010246
[   91.490472] RAX: 0000000000000000 RBX: ffff8880015826c8 RCX: ffffffff81d71e41
[   91.491080] RDX: 0000000000000000 RSI: ffff888001ca4800 RDI: 0000000000000002
[   91.491689] RBP: ffffc9000012b8c0 R08: ffffc9000012b8e0 R09: 0000000000000000
[   91.492298] R10: ffff88800613f290 R11: ffffffff83e426c0 R12: ffff888001582230
[   91.492909] R13: ffff888001582428 R14: ffffffff81b042c0 R15: ffffc9000012b908
[   91.493516] FS:  0000000000000000(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
[   91.494199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.494695] CR2: 0000000000000008 CR3: 000000000ed22006 CR4: 0000000000770ef0
[   91.495306] PKRU: 55555554
[   91.495549] note: kworker/u4:2[33] exited with irqs disabled
"

I hope it's helpful.
Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Thanks!
BR.
