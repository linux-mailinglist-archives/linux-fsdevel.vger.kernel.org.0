Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501057A4463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 10:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbjIRIR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 04:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbjIRIRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:17:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A6519F;
        Mon, 18 Sep 2023 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024875; x=1726560875;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=CcWoueDXKW0jAqdK4BTsPQ/j4S5nzdPHjH40BcY1UPE=;
  b=X10C/l/Tkr4y1o6VOxNTKN++Pe9Qerq7PBaFUrLJtvkWBIIcM9Q+UwL4
   BkjU8gCrv7DLvk0q+QODbM2yH6cxHzHICJwAa6wIsiFqvYhuexbYHon/Y
   7mzoD7TX1lOmkfB8bw4oMffAvQjZTljhVas4sR3pIlKErimXUksN66iZ2
   nkYL7HUbEjnX8DFW5i2PzvM0M9cwlLnrcqeVmtC3MkcEUlNGzUCPuOycG
   qWpdNBYjCxRj6M0xt1Qt1KpbjgGyoXc6uaWD08v5UiTE3P0XDNNxScRRI
   Me1jOD/dtnBwrsiHAFG+xXkn1hty2d6cdI0m1Ci/Op55eJC7weAV/iy/2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="443673031"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443673031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="888941759"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="888941759"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 01:13:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 01:14:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 01:14:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 01:14:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS4eQRy7LzZjvdajCYgdEjdYAznlmclmT6+o4hBlaKZwKGnmDcpUMVkhYnnhIwcsCHpQEl+cwOWfH2UBHfOkDQOSHJYhhyF+bpx0qV2tsX7O9AYCWpvv3OOAic9aSsdzPTJhoOx/hS+bPb3IEUOFnSvyD1uDrrMLGy7HDpwjDfSnzTO3Cn7RV+iK0GsV3eRTsJJ9BBqIA1R24Vd+0uRP+3G5YFdcD0fHRzBrE1leriMYoOmMt+/ZsbUFSUx6Ts5JmlQuVezkXUdeL1C7NgXeuyHPwlm3+8ms/1dJfnbtBZrpXtusRJCa4w83R/POJv0fYf8632YuJ+b4VHQ0NY1WCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoDRkyRmzXguNK0e/E41zzSc8gk9Y+ZGrZADcs+1MtY=;
 b=F+WH7OWvMAsgU2fe0L/j4dIaVKNRUTbbw+ZwIsdui4hfiK2Hh6GMJJMZtFq7aiZd6m1FpZqcXkYJJiCs892HG4SwgdbaB7SEs/jnn1h/8Afs5WSmtN4CMprNSSHBApFzd3T6L6BFWhF4Izpmnhcyni8ANQ/cfsD/iJrNcemijvMGKntJK6huHBoh3cJEopr6N1Dgw4dYGdw85wM3BvVyqZQ57ai9HqReEI9NTPFjOHE/KLI/C/rvEHRSpBU1Y5qa/b3j1CS9E92kX3xgXDXvehkCaU4W10e2ELSbkSUMUhb1ZBI944ClpJdy62a7ddJhknC/Ia+mPaLS3/UUAQYDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB5827.namprd11.prod.outlook.com (2603:10b6:806:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:14:30 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:14:30 +0000
Date:   Mon, 18 Sep 2023 16:14:13 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Sourav Panda <souravpanda@google.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <corbet@lwn.net>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <muchun.song@linux.dev>, <rppt@kernel.org>, <david@redhat.com>,
        <rdunlap@infradead.org>, <chenlinxuan@uniontech.com>,
        <yang.yang29@zte.com.cn>, <souravpanda@google.com>,
        <tomas.mudrunka@gmail.com>, <bhelgaas@google.com>,
        <ivan@cloudflare.com>, <yosryahmed@google.com>,
        <hannes@cmpxchg.org>, <shakeelb@google.com>,
        <kirill.shutemov@linux.intel.com>, <wangkefeng.wang@huawei.com>,
        <adobriyan@gmail.com>, <vbabka@suse.cz>, <Liam.Howlett@oracle.com>,
        <surenb@google.com>, <linux-doc@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] mm: report per-page metadata information
Message-ID: <202309181546.fc42f414-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230913173000.4016218-2-souravpanda@google.com>
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 00306013-b896-4cc2-f96d-08dbb81f4866
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMA/XsClQbOix5KrOn6l0C3OlbsZgX27ZXNmOjWCXpe9PsP7T65Z+8jkdsXJigpLqpcMZVHLXIf9BoHK/k22GyFcXHWTuboRh+etUAUX2qGSijANkVCKsXQtQfgynR43WYgPs4p6/TDdjPKcJveqwGgI7iiulWH0dwZdNq6Ud/B2+45pQUx0fuL07v31GGUrGTxkCAjxBRD8wzrR+EI7U6fDAE6JuRJEnU1xwoH3aEyfYO6aIetthpXzGtUlzRWlMyZ+eaMf/+QVG++1zeh3cK7ejG/lGHaKUxkho0oZGktZlNMaTk60K2gTySg63xO0Pq5i5wqbN4jyuD5NRrHs2W2OZPq6q+iO7TwsV2GPOQiPF9QN7hlewBXpn4hZSd02PwfRvYu0bnwpY9eN8zaCD63x7i4QrQQKjfQz/ZxD4WgZOz7zrPZaOxQ+g4EFUTFw/WiSqF74EUL1b5jqGNY9gSBZBekZ6GdzQhy1TC8zjia92fSZ+GEZ5FLDKb+90i8SrkF6efzECGpxYClrVly2YwnkMDsuW1AX12iXomNRj0FQnXkB1S0/i9sxM2MwHc7HdwRgYgc2VQCuWzQHXHu3jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(1800799009)(186009)(451199024)(26005)(82960400001)(2616005)(8936002)(8676002)(4326008)(1076003)(7406005)(7416002)(83380400001)(2906002)(36756003)(5660300002)(86362001)(6506007)(6486002)(966005)(478600001)(6666004)(45080400002)(6916009)(316002)(6512007)(66946007)(38100700002)(66476007)(66556008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWysJd4o+EjLc29UnjWxgOGFZsMEqYSCYeoEZZ1o/mwD2ltz9oZcZwj5DWlo?=
 =?us-ascii?Q?Qppv0flnk5yJPu/gAqgmKCl3ygSJ8JV2Yxdow53hZPHbP+SW/T0DZDs6gn22?=
 =?us-ascii?Q?In3yTjuPezrAJXqsrN34bwZSLzvIv90riykp7dLVbapmP7pIDEUSX7HL0ni3?=
 =?us-ascii?Q?p8zcSDn1t8QzKoRlYCCFz2ImgshOBwrxX3ujPuTbpNugFEqsEDge+BHdayXr?=
 =?us-ascii?Q?0ig/jrlkW+TgYPVdX0vMHMAEl79FJmZFED3xg9aiafODay21bYsdAB5vP3l9?=
 =?us-ascii?Q?5FdKvRL1PtsesNPAqUVY27yAT9QLifOyknjgLdZZq2qjPaHltrIqlQtoebxV?=
 =?us-ascii?Q?4oI5uXQk+JJFVicPkDMHny8bn312oUX3oVi3T46u2bSCh+jnCI8Q2YzRa818?=
 =?us-ascii?Q?cBMm7lUn73ODjkT4yE+mbqx6QqxnJDt5Itj3rT2gbj8Gxq/YwiF0JZov0C3s?=
 =?us-ascii?Q?3EQkN5GfZNe3vaFYzWyJp8DEULq0kYNCW+V0NwJ43LxU4d3V+FFzhSbsY/3D?=
 =?us-ascii?Q?ehCFqxn9Ni5VH7NtwdQWJ42AI6oXAQS++dz+zmj4kqbZspUVTgUf8G8XLsyG?=
 =?us-ascii?Q?CZMiv1DjxgNl1Wl5BUVVO6dnaGW/Cc5uNtwFXqEItTYxsu86Pq0d35xnP4p4?=
 =?us-ascii?Q?XNsEjRYGkMr9WHRuXWqsvlgF1TggeSImZeOfL0RE22Zxn2iKHQOksuvPKmOl?=
 =?us-ascii?Q?1Tj9bUiIk7jkfG5u4ugSi1b00KFK9MU2JWuwrOKllYIhi3Hi98EJUNmi5Oy1?=
 =?us-ascii?Q?MuSMlK8OTTEJuqFCeR/5wMfSTAEgU2czkHnIOi+uK2K8a9f10fNTElUv4RjM?=
 =?us-ascii?Q?oFCGj2fPt2RgAswVLpb7vNbjNhGGKKdgUNL8eO5eSFqGYaXSjMo0YmNxccYu?=
 =?us-ascii?Q?1NzSfE4GoOk9WFON0cRCOeITiKboCyRCamTELTdeDumVk92U05rO+E+N5sAg?=
 =?us-ascii?Q?h5xJKQIQc58g5Zw39WoDfJ42sey2IxNY44ynxsc/1zwA4Dz7s/c95HtIIRVC?=
 =?us-ascii?Q?3nbqvqYIgBaBro6T4mgNIVfTWSypZNuGHY5/vosuWolma/c5fCMncOZFR0nO?=
 =?us-ascii?Q?yxml90+dHplB3nrSlWysXWfQt2xfTliMSutRelOUhu1w0vkGkz/e6AgWuNfO?=
 =?us-ascii?Q?A/tU2f+YjwKAFeHoS9UYHgkGc0WDcY6pRE0GZvyEDa+TvDKqCoHBpcED7xF9?=
 =?us-ascii?Q?4LTDc4aomx97eHubr26ORAUgy6oM1EDBHGNxLM+vpuALwmxVHcXHKslDccRN?=
 =?us-ascii?Q?1L7gxREodAzOLApywqM/AAIAqsXHDJFv4c3VfsTQDPtaVlMdxchXNuYqPBDl?=
 =?us-ascii?Q?QIJ/qRHqD0xImx52kohdFxH0aIol1ycUjtTy3shKgTRFfPTblN0jMbOLg5TN?=
 =?us-ascii?Q?g2gb6PpUTmXJt3HUWJJSguQrlKQ21vYiUBsZHDfttxWBV+nPwB+FAKEs/kBT?=
 =?us-ascii?Q?IebgX3sVH0v4SGcLMVoAViEzi7jPiKD70ILGXLIecRCcBSYL9iJrf6cFAr+U?=
 =?us-ascii?Q?dRXBUlSz4IPavO2jRhV5y2X66cf9rIt86xnaAmSdTmSXEOKjyd7zHLbdBcJw?=
 =?us-ascii?Q?iJWOzXjQ9Z1MZMseTlImKdVmonto3SsBbjC7EfAopm5EqDnqIJIGGkSsGQwd?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00306013-b896-4cc2-f96d-08dbb81f4866
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:14:30.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL1EXzoTeZ5aHqB1tT5N6dCGmGIb8UNFTvOdrBg0ySBAoEsI710H0gC1EM5TJCfCVBvDI1Q/AIUFLOV9WZvfSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5827
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_mm/vmstat.c:#__mod_node_page_state" on:

commit: af92fce0e99952613b7dac06b40a35decef4cad9 ("[PATCH v1 1/1] mm: report per-page metadata information")
url: https://github.com/intel-lab-lkp/linux/commits/Sourav-Panda/mm-report-per-page-metadata-information/20230914-013201
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20230913173000.4016218-2-souravpanda@google.com/
patch subject: [PATCH v1 1/1] mm: report per-page metadata information

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309181546.fc42f414-oliver.sang@intel.com


[    4.596915][    T1] ------------[ cut here ]------------
[ 4.597618][ T1] WARNING: CPU: 0 PID: 1 at mm/vmstat.c:393 __mod_node_page_state (kbuild/src/rand-x86_64-2/mm/vmstat.c:393) 
[    4.598717][    T1] Modules linked in:
[    4.598835][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-00154-gaf92fce0e999 #4
[    4.599915][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 4.601238][ T1] RIP: 0010:__mod_node_page_state (kbuild/src/rand-x86_64-2/mm/vmstat.c:393) 
[ 4.602031][ T1] Code: 5e 41 5f 5d 31 c0 31 d2 31 c9 31 f6 31 ff c3 65 8b 0d bc 7e e0 7e 81 e1 ff ff ff 7f 75 b5 65 8b 0d 11 7c c3 7e 85 c9 74 aa 90 <0f> 0b 90 eb a4 49 83 fe 29 77 26 4e 8d 3c f5 88 33 00 00 f0 4b 01
All code
========
   0:	5e                   	pop    %rsi
   1:	41 5f                	pop    %r15
   3:	5d                   	pop    %rbp
   4:	31 c0                	xor    %eax,%eax
   6:	31 d2                	xor    %edx,%edx
   8:	31 c9                	xor    %ecx,%ecx
   a:	31 f6                	xor    %esi,%esi
   c:	31 ff                	xor    %edi,%edi
   e:	c3                   	ret
   f:	65 8b 0d bc 7e e0 7e 	mov    %gs:0x7ee07ebc(%rip),%ecx        # 0x7ee07ed2
  16:	81 e1 ff ff ff 7f    	and    $0x7fffffff,%ecx
  1c:	75 b5                	jne    0xffffffffffffffd3
  1e:	65 8b 0d 11 7c c3 7e 	mov    %gs:0x7ec37c11(%rip),%ecx        # 0x7ec37c36
  25:	85 c9                	test   %ecx,%ecx
  27:	74 aa                	je     0xffffffffffffffd3
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	eb a4                	jmp    0xffffffffffffffd3
  2f:	49 83 fe 29          	cmp    $0x29,%r14
  33:	77 26                	ja     0x5b
  35:	4e 8d 3c f5 88 33 00 	lea    0x3388(,%r14,8),%r15
  3c:	00 
  3d:	f0                   	lock
  3e:	4b                   	rex.WXB
  3f:	01                   	.byte 0x1

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	eb a4                	jmp    0xffffffffffffffa9
   5:	49 83 fe 29          	cmp    $0x29,%r14
   9:	77 26                	ja     0x31
   b:	4e 8d 3c f5 88 33 00 	lea    0x3388(,%r14,8),%r15
  12:	00 
  13:	f0                   	lock
  14:	4b                   	rex.WXB
  15:	01                   	.byte 0x1
[    4.602165][    T1] RSP: 0000:ffff888100307e20 EFLAGS: 00010202
[    4.602954][    T1] RAX: 00000000001f2cc0 RBX: 0000000000000000 RCX: 0000000000000001
[    4.604020][    T1] RDX: 0000000000000240 RSI: 0000000000000023 RDI: ffffffff83c6ef00
[    4.605021][    T1] RBP: ffff888100307e48 R08: 0000000000000000 R09: 0000000000000000
[    4.605499][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff83c6ef00
[    4.606507][    T1] R13: 00000000001f2ce9 R14: 0000000000000028 R15: 0000000000240000
[    4.607520][    T1] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
[    4.608632][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.608832][    T1] CR2: ffff88843ffff000 CR3: 0000000003644000 CR4: 00000000000406b0
[    4.609842][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    4.612168][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    4.613186][    T1] Call Trace:
[    4.613606][    T1]  <TASK>
[ 4.613982][ T1] ? show_regs (kbuild/src/rand-x86_64-2/arch/x86/kernel/dumpstack.c:479) 
[ 4.614528][ T1] ? __warn (kbuild/src/rand-x86_64-2/kernel/panic.c:677) 
[ 4.615040][ T1] ? __mod_node_page_state (kbuild/src/rand-x86_64-2/mm/vmstat.c:393) 
[ 4.615501][ T1] ? report_bug (kbuild/src/rand-x86_64-2/lib/bug.c:180 kbuild/src/rand-x86_64-2/lib/bug.c:219) 
[ 4.616083][ T1] ? handle_bug (kbuild/src/rand-x86_64-2/arch/x86/kernel/traps.c:237) 
[ 4.616642][ T1] ? exc_invalid_op (kbuild/src/rand-x86_64-2/arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 4.617240][ T1] ? asm_exc_invalid_op (kbuild/src/rand-x86_64-2/arch/x86/include/asm/idtentry.h:568) 
[ 4.617895][ T1] ? __mod_node_page_state (kbuild/src/rand-x86_64-2/mm/vmstat.c:393) 
[ 4.618575][ T1] init_section_page_ext (kbuild/src/rand-x86_64-2/mm/page_ext.c:292) 
[ 4.618836][ T1] page_ext_init (kbuild/src/rand-x86_64-2/mm/page_ext.c:482) 
[ 4.619433][ T1] page_alloc_init_late (kbuild/src/rand-x86_64-2/mm/mm_init.c:2417) 
[ 4.620098][ T1] kernel_init_freeable (kbuild/src/rand-x86_64-2/init/main.c:1325 kbuild/src/rand-x86_64-2/init/main.c:1547) 
[ 4.620765][ T1] ? rest_init (kbuild/src/rand-x86_64-2/init/main.c:1429) 
[ 4.621325][ T1] kernel_init (kbuild/src/rand-x86_64-2/init/main.c:1439) 
[ 4.621880][ T1] ? schedule_tail (kbuild/src/rand-x86_64-2/kernel/sched/core.c:5318) 
[ 4.622167][ T1] ret_from_fork (kbuild/src/rand-x86_64-2/arch/x86/kernel/process.c:153) 
[ 4.622753][ T1] ? rest_init (kbuild/src/rand-x86_64-2/init/main.c:1429) 
[ 4.623314][ T1] ret_from_fork_asm (kbuild/src/rand-x86_64-2/arch/x86/entry/entry_64.S:312) 
[    4.623942][    T1]  </TASK>
[    4.624331][    T1] irq event stamp: 11857
[ 4.624861][ T1] hardirqs last enabled at (11865): __up_console_sem (kbuild/src/rand-x86_64-2/kernel/printk/printk.c:347 (discriminator 1)) 
[ 4.625498][ T1] hardirqs last disabled at (11874): __up_console_sem (kbuild/src/rand-x86_64-2/kernel/printk/printk.c:345 (discriminator 1)) 
[ 4.626689][ T1] softirqs last enabled at (11546): __do_softirq (kbuild/src/rand-x86_64-2/arch/x86/include/asm/preempt.h:27 kbuild/src/rand-x86_64-2/kernel/softirq.c:400 kbuild/src/rand-x86_64-2/kernel/softirq.c:582) 
[ 4.627866][ T1] softirqs last disabled at (11541): __irq_exit_rcu (kbuild/src/rand-x86_64-2/kernel/softirq.c:427 kbuild/src/rand-x86_64-2/kernel/softirq.c:632) 
[    4.628832][    T1] ---[ end trace 0000000000000000 ]---
[    4.694353][    T1] allocated 301989888 bytes of page_ext



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230918/202309181546.fc42f414-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

