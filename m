Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C58710324
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 04:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjEYC56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 22:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbjEYC5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 22:57:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D051135;
        Wed, 24 May 2023 19:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684983472; x=1716519472;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=1T5oBHt4v9dgNLCn0LIaaXKh/Qdc7g6VnudhbwsRtJA=;
  b=n9HzGt0276aVrt67EbIelOk+WnovlL+sn89PT9Utx11uSNw+sehi+8nO
   KqmtDYu/J7pwwtFuiqZ84SYGKvOD+AbBmvb5m3W4ZLk5onUk9uYozrRC6
   oNphsbrm1e3JZ9rQd4OuW/bREsBDsYKwU4PmDByxygd0oyu/yQ59ORb4t
   /65CZQ1DL23q+4zpmCFo4IpOClw+4KszYplP7H1X3lcZYtkAUvUDRGHiR
   h/oJXP9EEUZvUeGdElMwsHS4G1JmtMqXlblUB/toMf7SZgUySDeTfpAF9
   uYYnNJuvcjrc99FbbJY8oZIft2oddpJz6fGrsKW7wayUE9kuoDZJwppUx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="382009241"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="382009241"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 19:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="951274082"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="951274082"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2023 19:57:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 19:57:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 19:57:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 19:57:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5yJ/XHYUw0eBPUaBfBS1zND+JY08jbWAFvcFxX0swcmoUVMSIU9GZVv1CqRIS0hodExDG08ZJv4jaK14MzFWJD4/+elQLldf5Oii1NK3uz5atVUz73/UTjY3ZuiRHazNDqOkEg17Zabl515mNUVS9BcRKX/b///LgM9Y0ly6nnBvfY4cayCSAmsJe7nF6yYbCv/8EJiAMNP6ho6+zgbpEOXbFrOdOmL6S45pCNHDX6nrpWV/TpTjfXv/InejqOy0jK2O4bynRObFxKDEs9XXQP0ZniH1agWcmNpAv0k28AMFWlufLUkyNWZnfiFVyWxd2BBxyTeLglkLYs6qeGaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufl6TAXHJEW5CM4ZSLeV2Jw5e4u5FgdfUetuEtKqlb8=;
 b=BLOPvkTi8Wu4Tj21paIQg+1cP+fEx5O8CpX639irauqFIYIWoxhpI0ZLZignnllqI5crLOJk52vfMteVij+vvUpma3zxh6h7gXqYtMM6zXHn5In4Emuesi7bih9JUPUO+TdUXXNkMk+B1ZF7Ksb+GGSDoUnapLxLCWzfUROYkwHKSxeNQGGhh73Bdicss4IyaUNGhdR2ZgMALGhLK3U481WaT8pIwPZ/CNBPpyik0dUUgyvTIxsyWt9dRRWoy17xORSFFcYhJPi1BPf0gfBMFcLB24ilMysOVbSKmgEbJwG9Do77EoSMZLXh+XN2eHAIKYyi6BeGQC3aQ2G7LMAHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 02:57:42 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::f210:9459:2a5f:564f]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::f210:9459:2a5f:564f%7]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 02:57:42 +0000
Date:   Thu, 25 May 2023 10:59:37 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <dchinner@redhat.com>
CC:     <djwong@kernel.org>, <heng.su@intel.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <lkp@intel.com>
Subject: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Message-ID: <ZG7PGdRED5A68Jyh@xpf.sh.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|IA1PR11MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 08896243-fbbe-4b29-ec39-08db5ccbceec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xB6vyvajoe8curWwtEA4ex2ehdHHUT+/d4KpXL8pc0WdBKHTcX7vMqLDAsw8Q1SiYEaoqyQKz2fP6EszyhCXFuAo1C8YACZ11hX3QIF//ewyojuRFHHHXcg9C0Sz9iXJ1Xnw83DjhebhauMcm1wtJcLK6dawN/c6WGX4aN/ufziUjbWSDCi/k+tjqaifYsNU6HxR33j1U2zIHiomS8MM4O2auezojXunAn8OPSWlfdK/GSbi20howDP+9Gq5N2tIPiRllPIL1QgKkz96CCcn11jRY4evEVUJXAlQuTFIfRf1B82PysBxRi4RE0tKtcOUpCpsFAD5iI7u2XbkhgXonN9+Y/yjd+tFQRZWUunhMxrCsUIJGHU+tJSw17TN3gCJ4QxYAL0EfRBDk6SUbpziovn8+am9wyO/CnWTXVCwfWdB6Xpxj0rE0rRpjy4JHSd/H9rBeo4SnLjJWXEWFSBIOylIo5BbbA1ODu3ANJ6tbzzh5M1b20XtniP49uPw02FvuKnc2eVCkjs1j1qW8ea9ltmvQy/Lrfiiw5021RT01i6M4+tU+CDZ5FrqmmR+ANPEqNurKn4x189sgHMsPTGibUZdulmwyw9kOrEJNWQK8X3AIujsYi13hiWHj/pbnQakpM7w7fXD3LWuPtaKjBwUpiSZRIiD+PaiIlqxNoX5G3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(107886003)(6512007)(8936002)(8676002)(83380400001)(38100700002)(82960400001)(86362001)(6506007)(2906002)(41300700001)(45080400002)(66476007)(66556008)(66946007)(6916009)(6666004)(6486002)(316002)(4326008)(966005)(5660300002)(44832011)(186003)(26005)(478600001)(21314003)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUM2ZTBrRGZPMVRyMXphS2U4Q0tkUVZjcTVqZE1iVHN3M0kveXVwRTJmcG1X?=
 =?utf-8?B?N0VkWjRuZmZPWmdCc0kvaWdtaDFnY3JMeGllTEJ2b0g1eWFuZk44U3B4NGRh?=
 =?utf-8?B?cUNIdDVzeng5bElMOXlqbDVSd3pudEdnQlg2VmY0SThnWFkwU2wrM0hLQlhD?=
 =?utf-8?B?YjA5ek1JNDVaS1N2OXdGSWJ3enR5KzhKNU96Ym55YmlSRm1IUDRPMFZFU0VG?=
 =?utf-8?B?V3dwOVVGQ1UxZXFKUlFjNVdYMU1BMzh0d2tkc0diUTNEcWRKZ2RIL1ordXlj?=
 =?utf-8?B?UlNhcnNQcUQrS0NxQk50ZldqSFBmNDBERkRKSFZuRjlyZEN3M0IvcjVBTnBR?=
 =?utf-8?B?NTZiUlZjOVdsY2lSZCtSSjBHaUttcVhpcC9La3AwTnR6R2ZWVUVjR2k3cElV?=
 =?utf-8?B?cUN3L3J0VWRhQ1FpLzl3Nng1YWtyb0tXUVlXRjhMdmNvL2FVa2FmRjJCb3F2?=
 =?utf-8?B?RGgwTDRVMEp1U0lNTFc5a1p3RHhKUEVFMVNmUUZjeUM4ZkYzdVk4RVFwUWdl?=
 =?utf-8?B?UDA3KzlTN05kZlR5VkRjUEpSNjNEUXJRN2cybVhtc0RVK1J3RlZzSnozL21a?=
 =?utf-8?B?UWoxTTJEYWJxSWlyK1Ftd1lYbDhId1gwRXZ0VDh5ZzZMbFZURXhhRURpWTlL?=
 =?utf-8?B?Y2ZlU3FRZGtSSXIwRGFOeXhoT3QySDIyWld2b2RtTWd2MGlKYkorWnk3RkMw?=
 =?utf-8?B?VnRhdW9VVm1NU2ZoM3pVSWxnQ1hNb1UvK0xHaUNkUVhJUFRNQzRLdTkra1E0?=
 =?utf-8?B?S2ZjOTZSbllYMHc4UXdnbGhEZS92ZmE4SnlnK0VNNWpUaWZ5VVp3RThPeU5O?=
 =?utf-8?B?QVVHSkVORHdOM084WFpqL0UvK3BjTTV2dTJyWHJSbGY5R1gyc1pHUm5peW9v?=
 =?utf-8?B?azZsa0R4OWI1ZGRZYVVEa2YzNVlrZUhwSHVNbTZ6Z2VyUjdBQnA2Y3JvR0dq?=
 =?utf-8?B?M1NPZ0JHQ0g1RmdoaUtxbEFKOTNzZnFadmNqUGN6VHhhVGdoOXFVb3VsR3Rq?=
 =?utf-8?B?blJDUXpyL1pMenhKOEgra05TRFZkdExWNkhFUStGMHZxcnlpTWdKb2EvY1Jx?=
 =?utf-8?B?QUtGa1Y4MHJ2VVZ5Rnk1eUhRMmhiR3R4ZE44R3pwUU5tMEtsK0Yvc2pZWldP?=
 =?utf-8?B?M1N2TXEzcHBwNlN4aFJKWFRWMnhrUnZmNFFyWHU1V2w0NlgrZTY1RloyZkZX?=
 =?utf-8?B?YndlUWVwMi8rVkp1dEM0bzBwY211ejlXa0UyRmozWjA1OGRDeEVIYWZsTG9X?=
 =?utf-8?B?R0xHTzNCS29rOUd6NzBOcEFSVU5CYnpELy9hdGZkb2oxcG9HS1hXdWpMd3hz?=
 =?utf-8?B?U1g4QzVXR0hxRmFqWXFiWmF4bllsdjZibnZWbGkyOE9JelUvMWlXWTBDTnhN?=
 =?utf-8?B?T3luVENNZ0dlaitSdm5CR3NEeWY4YlM4bVRJYWFqcXJBbXd6UWJpa1czRVpV?=
 =?utf-8?B?dmc4blJNVDd4UWordlh2ajgvQjZjdTB0azlpbVhjNWtyb1U1QkxxRFNueUpF?=
 =?utf-8?B?VkNOU0drMzZmZlhrNmVIS1JDOUdtdFhqSDV3TWppcFdqVFZkSnNlbFBTSWFz?=
 =?utf-8?B?SUpia2dNaTBRVjNMT1A4V1ZUTEtZcTJLRmNyUlB6cXl0Zm5OQlNlTlNNMUFE?=
 =?utf-8?B?V3RWWXdLM2tYdjNoVUJiVGh1ZlM4SmwzRW51NVdxZ0V0eVorU0daUk5aVCtF?=
 =?utf-8?B?TUlyNjNtWjdIVWhmZWI1blAyc3ZCdlVzUzdVMXZmeHY4YWxmTDhtWkNtSDVq?=
 =?utf-8?B?ek1TMDcxTkZsb3daK3lwWHlmVC91UExmUVdFTmx4VTUybHhwaGlpSzdOZ21L?=
 =?utf-8?B?dTRkbWpmVUlUVWd0ZlhqbnRkL242VjMwTDlraDJndk1Fc1ZJVXg4OStQUlVM?=
 =?utf-8?B?NW1oRzFoZjFqcjRtTHlxL3dvYkU1U2s0MEhpNFlsNC9hWmJ2cmdaZlJjWkMr?=
 =?utf-8?B?V2lCbWhNL1V0RDE1QVNXMWE0UmFwZ3JoZXRyanpWelM4UGRWRUl3bWhMY2Fh?=
 =?utf-8?B?OVliTDRNRk1pNXVSb3BmRDdra0VwL1lqeE9SUnZoM1NDcGVUOWd2Z0dTSHR5?=
 =?utf-8?B?RVFhVERzRTZ1R1V4NTNnVW04cHorTm5SY3g5UnFwVHZhVWsvYXlIZG1DSUk5?=
 =?utf-8?Q?6VRNLZ4tTMxl4B2nDlOSHHpbL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08896243-fbbe-4b29-ec39-08db5ccbceec
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 02:57:42.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MswOl+9OSLQ8vZMFDhhXccmjrrDaBmCXTqCFS9WOcR4xmPLtnc6CnnS7KYp++8GOQLEPyyrN140Q5Cit5Rcvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

Greeting!

Platform: Alder lake
There is "soft lockup in __cleanup_mnt" in v6.4-rc3 kernel.

Syzkaller analysis repro.report and bisect detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230524_140757___cleanup_mnt
Guest machine info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/machineInfo0
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.c
Reproduced syscall: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.prog
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/bisect_info.log
Kconfig origin: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/kconfig_origin

Suspected commit is as follow due to 2 skip commits:
 # possible first bad commit: [f8f1ed1ab3babad46b25e2dbe8de43b33fe7aaa6] xfs: return a referenced perag from filestreams allocator
 # possible first bad commit: [571e259282a43f58b1f70dcbf2add20d8c83a72b] xfs: pass perag to filestreams tracing  (skip)
"
fs/xfs/xfs_filestream.c: In function ‘xfs_filestream_pick_ag’:
fs/xfs/xfs_filestream.c:92:4: error: label ‘next_ag’ used but not defined
    goto next_ag;
    ^~~~
make[3]: *** [scripts/Makefile.build:252: fs/xfs/xfs_filestream.o] Error 1
make[2]: *** [scripts/Makefile.build:504: fs/xfs] Error 2
make[1]: *** [scripts/Makefile.build:504: fs] Error 2
make: *** [Makefile:2021: .] Error 2
"

 # possible first bad commit: [eb70aa2d8ed9a6fc3525f305226c550524390cd2] xfs: use for_each_perag_wrap in xfs_filestream_pick_ag (skip)
"
fs/xfs/xfs_filestream.c: In function ‘xfs_filestream_pick_ag’:
fs/xfs/xfs_filestream.c:111:4: error: label ‘next_ag’ used but not defined
    goto next_ag;
    ^~~~
make[3]: *** [scripts/Makefile.build:252: fs/xfs/xfs_filestream.o] Error 1
make[2]: *** [scripts/Makefile.build:504: fs/xfs] Error 2
make[1]: *** [scripts/Makefile.build:504: fs] Error 2
make: *** [Makefile:2021: .] Error 2
"

"
[   29.223473] XFS (loop0): Unmounting Filesystem d408de26-55fb-48ab-a8ab-aacedb20f9dd
[   29.223942] XFS (loop0): SB summary counter sanity check failed
[   29.224173] XFS (loop0): Metadata corruption detected at xfs_sb_write_verify+0x7d/0x180, xfs_sb block 0x0 
[   29.224544] XFS (loop0): Unmount and run xfs_repair
[   29.224731] XFS (loop0): First 128 bytes of corrupted metadata buffer:
[   29.224979] 00000000: 58 46 53 42 00 00 04 00 00 00 00 00 00 00 80 00  XFSB............
[   29.225304] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   29.225603] 00000020: d4 08 de 26 55 fb 48 ab a8 ab aa ce db 20 f9 dd  ...&U.H...... ..
[   29.225902] 00000030: 00 00 00 00 00 00 40 08 00 00 00 00 00 00 00 20  ......@........ 
[   29.226200] 00000040: 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00 22  .......!......."
[   29.226503] 00000050: 00 00 00 04 00 00 40 00 00 00 00 02 00 00 00 00  ......@.........
[   29.226802] 00000060: 00 00 04 98 b4 f5 02 00 02 00 00 02 00 00 00 00  ................
[   29.227101] 00000070: 00 00 00 00 00 00 00 00 0a 09 09 01 0e 00 00 14  ................
[   29.228273] XFS (loop0): Corruption of in-memory data (0x8) detected at _xfs_buf_ioapply+0x5d8/0x5f0 (fs/xfs/xfs_buf.c:1552).  Shutting down filesystem.
[   29.228788] XFS (loop0): Please unmount the filesystem and rectify the problem(s)
[   56.322257] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [repro:529]
[   56.322608] Modules linked in:
[   56.322733] irq event stamp: 22632
[   56.322866] hardirqs last  enabled at (22631): [<ffffffff82fad69e>] irqentry_exit+0x3e/0xa0
[   56.323185] hardirqs last disabled at (22632): [<ffffffff82fab7b3>] sysvec_apic_timer_interrupt+0x13/0xe0
[   56.323550] softirqs last  enabled at (9060): [<ffffffff82fcf8e9>] __do_softirq+0x2d9/0x3c3
[   56.323865] softirqs last disabled at (8463): [<ffffffff81126714>] irq_exit_rcu+0xc4/0x100
[   56.324179] CPU: 1 PID: 529 Comm: repro Not tainted 6.4.0-rc3-44c026a73be8+ #1
[   56.324455] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   56.324877] RIP: 0010:write_comp_data+0x0/0x90
[   56.325056] Code: 85 d2 74 0b 8b 86 c8 1d 00 00 39 f8 0f 94 c0 5d c3 cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <55> 48 89 e5 41 57 49 89 d7 41 56 49 89 fe bf 03 00 00 00 41 55 49
[   56.325736] RSP: 0018:ffffc90000f5bc60 EFLAGS: 00000246
[   56.325936] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81a138ea
[   56.326204] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
[   56.326475] RBP: ffffc90000f5bc68 R08: 0000000000000000 R09: 000000000000001c
[   56.326744] R10: 0000000000000001 R11: ffffffff83d64580 R12: ffffffff81ac0c81
[   56.327011] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8880134bf900
[   56.327278] FS:  00007f85f5814740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   56.327580] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.327798] CR2: 00007fe75831f000 CR3: 000000000deb4004 CR4: 0000000000770ee0
[   56.328067] PKRU: 55555554
[   56.328176] Call Trace:
[   56.328273]  <TASK>
[   56.328359]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   56.328571]  xfs_perag_grab_tag+0x27a/0x460
[   56.328745]  xfs_icwalk+0x31/0xf0
[   56.328884]  xfs_reclaim_inodes+0xc6/0x140
[   56.329051]  xfs_unmount_flush_inodes+0x63/0x80
[   56.329235]  xfs_unmountfs+0x69/0x1f0
[   56.329389]  xfs_fs_put_super+0x5a/0x120
[   56.329548]  ? __pfx_xfs_fs_put_super+0x10/0x10
[   56.329730]  generic_shutdown_super+0xac/0x240
[   56.329909]  kill_block_super+0x46/0x90
[   56.330063]  deactivate_locked_super+0x52/0xb0
[   56.330242]  deactivate_super+0xb3/0xd0
[   56.330400]  cleanup_mnt+0x15e/0x1e0
[   56.330553]  __cleanup_mnt+0x1f/0x30
[   56.330704]  task_work_run+0xb6/0x120
[   56.330853]  exit_to_user_mode_prepare+0x200/0x210
[   56.331045]  syscall_exit_to_user_mode+0x2d/0x60
[   56.331229]  do_syscall_64+0x4a/0x90
[   56.331379]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   56.331575] RIP: 0033:0x7f85f59407db
[   56.331718] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 96 0c 00 f7 d8 64 89 01 48
[   56.332395] RSP: 002b:00007ffd74badbc8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
[   56.332680] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f85f59407db
[   56.332945] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffd74badc70
[   56.333216] RBP: 00007ffd74baecb0 R08: 0000000000fb4333 R09: 0000000000000009
[   56.333486] R10: 0000000000404071 R11: 0000000000000202 R12: 00000000004012c0
[   56.333752] R13: 00007ffd74baedf0 R14: 0000000000000000 R15: 0000000000000000
[   56.334026]  </TASK>
[   56.334116] Kernel panic - not syncing: softlockup: hung tasks
"
I hope this time is accurate and helpful.

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
