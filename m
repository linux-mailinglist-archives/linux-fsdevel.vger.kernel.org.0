Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E5E6A362B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 02:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjB0BdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 20:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0BdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 20:33:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29FB74E;
        Sun, 26 Feb 2023 17:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677461592; x=1708997592;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vamxGIGWrXHlHBfpjoCmyuMnG1jrkHJY+uMivnQYDzE=;
  b=GF45bsBkSttZ1boisC5noi7aYOJfJYOPXXM7g3cnMh4zCHaXgipkHkDF
   zLPBm4RJFYpzpf113ZMyJOzuq2VhCP9WTsl+8yHncZuMMYqQ7Ojp7LUKb
   qDVLOjAhtdP5ukx4eScxXydNDdUuU61HNBe8faTIE2GLFPv4mN2Sl1Lya
   k0rqzd2kWpVW40Bcq/S7tfggWtNXLRA9fjadRjCG2QJPdq6rZcjGPSAtU
   WqEIgPPa4Jr/vL58dM4VfaMOeeAe/75lIKm/1DXV+DRko9P0z9VO6iJpN
   y+QV7E+XEcZwfH2IXEkAiFxzgMp1h4puhOsnDxYlQZXHLOhVcMXThOMnT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="396307441"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="xz'341?scan'341,208,341";a="396307441"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 17:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="673565396"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="xz'341?scan'341,208,341";a="673565396"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 26 Feb 2023 17:33:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 26 Feb 2023 17:33:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 26 Feb 2023 17:33:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 26 Feb 2023 17:33:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kljc4G2ZIRybwG4Z2X4SNbxUga1lxOF7lmxRE+sGxf0hHhg+r0nZJqV+pctCmx4LwUj/zYWPK2Ecykf6w0+lkcPvH2GwupaO/W8UY78FNC/gdhLw0G3gTcj3lrxU3146g/yqDs/FIdAvE2/O63Wf0WSb2edJ1rTh+7ANd+NFQYdjyAI9Te57dc+ou3+q+oOrhRP4uDRSYlscJcJepjKgmRc7C+ofPID2BIldhW53a8O20hR76Q1EFaK6HsQXp25xfY/2z1nEGCYkWZpLpI/Px92RbL512KoLXs7C7E2iahFXdebuBYXkLfLZzR/teUu5NdoKX+T7IllUPyCgXDvWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY95Vm7AGbHKGHswl2e8oX9Irdic5BkCShCmKtsBoIA=;
 b=PkmpaQd4mxss5Xe4t8+Z6Q/WBnXWNOpWwHwRDrGQadK0eeHUuVHw8vPkGEI2uTI+RH2iIOJl8KSJqwDs5iqJ4Sx9W3rmOwVrPEcAlMxFNEc6rHoFYDLTjoP+Jm2iDkf4w3m1Qj4qQOq4PaR8vw4jTrGIa/J4yB1xw9rNZlOqlpzxOaK94JpiqguNseJm3D9bZFIaWGzBpm8yO4lOvpsRsjHXv2f2LrQgawcNtfs/DHk9LGxA/2hdL0cu2q9I3+A0nHsfFXSy26RYTGnOKZdqu/pgHrrXr+jhZP4Yamo3en4WC6Gmbl93Z6imvQbgxYWiux0yBd38/7qt/57CpIHI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 01:33:04 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4%7]) with mapi id 15.20.6134.028; Mon, 27 Feb 2023
 01:33:04 +0000
Date:   Mon, 27 Feb 2023 09:32:53 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        <linux-perf-users@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [linus:master] [mm/mmap]  0503ea8f5b: kernel_BUG_at_mm/filemap.c
Message-ID: <202302252122.38b2139-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="rUfPHAfZyEX1LoYC"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d9c4c9-383d-470c-f3fc-08db186291e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02MwnMar0tpNrQgpaYR3ilqRV+CIZPAkmXF1K+SqJj644f7j8N3agOv3iRgwaE7ZLdOYXDo6bNH7uW2eZMdfY5FteORYV5yP0sL56QjPSrZJq7DzwR0ZzOLypL2ki7ilLAf675Fo0/5BIO96vUzYMfuc1hJPeafYWPiJppNBER/dVoYF1Dd5ZVfVXfoR1Inggp92kQH7YlBn4fV0DDK9PupGW1r6DAFLHivfkoQuG9Aqq3mGOtygHFOepYIbrHugDqmNYON4EKVbQAdtQJuLiQmYpv9VUfEQtyMdvMxsnkaAZKb15wsqyCikep4F/2FoZthKO/ljQgWI4RzoRssmTWKZtPEj8ez6yO6M4UxJF8Y7M4YuKxn5O3IL730JL+bg8ee/rcaGwbq9pMf6lKtzMshWX4ZtQI3uiiSPvRkLNfJdQjunGeXDxbqWuoxzojBaW1jV6sznTjAkbKNzBbShqtaSOAE7Fk7L2U66WvKT+XescR+RHnenjmk9kgsp4Q1huiOTYXF7VmXdKtmmHrDnmWc9YjmsnDAS/OjlRN4gG3dTcfGifMTgH4VhnTZnjQ3mcDUuzby4e+Bqmf6Sfm7sTnASMymoGwbtA4Kji0JEGniLnrQgUOdTYYUIg7IicnvoEuf7pT84/CVQSuy62ELTZlbzAZqbIJon6NjFZRcOZtnVjB+5IkxDRMP2vnlW0eLwG3xFJkKCXtOSHZUPu082M09X7s+XVnxUCl1fXWLTWoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(38100700002)(82960400001)(6916009)(66946007)(41300700001)(8936002)(66556008)(6512007)(6506007)(66476007)(235185007)(8676002)(2906002)(5660300002)(4326008)(478600001)(1076003)(26005)(2616005)(6666004)(186003)(44144004)(45080400002)(966005)(6486002)(83380400001)(316002)(36756003)(86362001)(54906003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2uZnqlpO03y+awPf5pdQACaRwmqmr0p1594lx9LhpuKxjGa6+Jvpoqo0uwc?=
 =?us-ascii?Q?zsAP4zkN9uQYICG1teZdpypmXv7RXW83p3+p1t4nf6pYMFZ15HX4pd7zTUln?=
 =?us-ascii?Q?0Y6KwE6z7a+898VuUYmCA/slJlrAcbPzSEFFDhxUbYSWvy3ixrobziwpH+2Y?=
 =?us-ascii?Q?Tq4KuO1EEQ9/N1E7xywKD2N8B+iGrkXfPC+z+616UBvRxJgX76+A7FQCO1WY?=
 =?us-ascii?Q?/fcYALQ4+aEN5N4OAHL2yuMpi7chPHsNmYHlxmynlHjQpTFjkM6ZP3lYs1Or?=
 =?us-ascii?Q?JNIHMb/43aHedbK7KFR1a00lmsMb8hBI1VjWe4lxOcHqO5lH2akPckT/n5GN?=
 =?us-ascii?Q?AQ9h/oAyZzZh1iSCXZL1dBg4/gGjt4d++g5vvn+5YI+APzyGwo1dGwOFdTxN?=
 =?us-ascii?Q?qC7QW1GhuN9VO/0RvAO+1EMm8QuVAyeIV+5Y5ohM3df5V5uMqrFmERRjYe6l?=
 =?us-ascii?Q?XVjRaENjQGy9RWEaYlJRn022wjfebmXkiOLKYQoTyC8XZlM6vwwiN9I2lo0v?=
 =?us-ascii?Q?gJAx09OjuMoK+TLJx5Y/kKDGumVtBE9qZNWp7tWVALGmgeGN7ZwRpaBDnRjC?=
 =?us-ascii?Q?Z9s2YZ3yzA2N9a/8gcvbCDSBn892zBOPgRpppzj58gdoks/TX+aJDomFv4F5?=
 =?us-ascii?Q?NWeJXV4sEXxxQNpwWJSKjFgQNGYnvWGY+UFjuvD2CFFQe7TS4YCKHO1pFABV?=
 =?us-ascii?Q?qkGcX980irCxAhqDrrGkP7ZkaKa/s4ZxxofIoiDQsrUNZ5s1BoJKwy7bO+Wp?=
 =?us-ascii?Q?Or1Sb06kmwcmFh3e+07OkV+1kW3wCuDPZlUBiW9PyWMXUVPi3/nwqPtzjfE4?=
 =?us-ascii?Q?nh/7Z2SxnYi/fqqHFfOAr3b7pumKUtWnYKosP6w9bK14O2TFpESUNCHEPIo5?=
 =?us-ascii?Q?6aiXKwzc+JWB8PXUKXbdbMCEQLukoYQtCHWXWW+Aaz6aoft8wiRO5Q6W1hqB?=
 =?us-ascii?Q?OU9k9PAFzoUx1DHUAprh1EYK7KE5rpMdmREiq7qOTcAt4M8fl8ZIR1n4FHz+?=
 =?us-ascii?Q?oblHahe34yVn4ZP5lNXldZgjmW0LihE7bWqFgPZvPBrnoJO2HqW43BWBMWxx?=
 =?us-ascii?Q?7foQdZYJcjHAjIqz3Y1hdR0NY7VJZaKsnX9EA5Fqqh9VoRFGcEbM6wiR8eCa?=
 =?us-ascii?Q?1ejExvXTHb/xDn4b/zeKcqOKUAB3CDihlf+eEVHQrXfk4SeXzzjn/HvHTZN8?=
 =?us-ascii?Q?8t7Tloctp5ma0mYQjSz9t7MpBx7T1gVtwK0wBwqOFrret52lukFD4hdB/ykf?=
 =?us-ascii?Q?cQ5yhisylgiDxmVwkdBX7X+G81MSklFkdK/BWni0QjbCCw/pqpgz9DOKGdJG?=
 =?us-ascii?Q?2epEOcks0fKE5yCgBON/w1iLQ0V19Mku04xgOTPu/UXZ2xG2JY4xUBHg61k8?=
 =?us-ascii?Q?gesvier25Do4z1chQbneFvMB8JcUfmqR/csIfZtgiuB8SCPZ3cJaunQHcULQ?=
 =?us-ascii?Q?j1KVSWVUo/RyqYA/HTXdmYzUmQXj4y5YFJC8hQxeaxV11yI5SzirmgMQgUU/?=
 =?us-ascii?Q?8NOmaBcNmmg4HrCMNMpRUM/4EsZiHkygg+8S6cAM40w38AUgqlmZ8zIn2LyD?=
 =?us-ascii?Q?4iQ88egGZ6efan/wB2wzTCBH5LJMIvozKSqILUOAUcaCoK4CRlHYlEocqaJq?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d9c4c9-383d-470c-f3fc-08db186291e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 01:33:04.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JproW9WTfjEsxzF/B0VaVD94eHUaFJgh7R7nF6TLrEm/v9J0vDWXL2Gv8PZif6Du2w6BNlCkIt2iR5XLuGrJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7592
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--rUfPHAfZyEX1LoYC
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed kernel_BUG_at_mm/filemap.c due to commit (built with gcc-11):

commit: 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a ("mm/mmap: remove __vma_adjust()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 0222aa9800b25ff171d6dcabcabcd5c42c6ffc3f]

in testcase: trinity
version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
with following parameters:

	runtime: 300s
	group: group-04

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


please be noted, as below table, parent also has other type issues, and we
found they happen almost at same position of kernel_BUG_at_mm/filemap.c for
this commit if looking into dmesg (attached two parent dmesgs as well)

we don't have knowledge if this commit fixes some problem in parent then
run further until further issues, but since this commit touches
mm/filemap.c, we just made out this report FYI

BTW, we also noticed there is a fix commit
07dc4b1862035 (" mm/mremap: fix dup_anon_vma() in vma_merge() case 4")
by further testing, BUG_at_mm/filemap.c is still existing there.

+---------------------------------------------+------------+------------+
|                                             | 287051b185 | 0503ea8f5b |
+---------------------------------------------+------------+------------+
| BUG:kernel_NULL_pointer_dereference,address | 11         |            |
| Oops:#[##]                                  | 11         |            |
| RIP:dup_anon_vma                            | 11         |            |
| Kernel_panic-not_syncing:Fatal_exception    | 20         | 9          |
| canonical_address#:#[##]                    | 9          |            |
| RIP:anon_vma_clone                          | 9          |            |
| kernel_BUG_at_mm/filemap.c                  | 0          | 9          |
| invalid_opcode:#[##]                        | 0          | 9          |
| RIP:filemap_unaccount_folio                 | 0          | 9          |
+---------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202302252122.38b2139-oliver.sang@intel.com


[   28.065728][ T4983] ------------[ cut here ]------------
[   28.066480][ T4983] kernel BUG at mm/filemap.c:153!
[   28.067153][ T4983] invalid opcode: 0000 [#1] SMP PTI
[   28.067868][ T4983] CPU: 0 PID: 4983 Comm: trinity-c3 Not tainted 6.2.0-rc4-00443-g0503ea8f5ba7 #1
[   28.069001][ T4983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[ 28.072145][ T4983] RIP: 0010:filemap_unaccount_folio (filemap.c:?) 
[ 28.072927][ T4983] Code: 89 fb 0f ba e0 10 72 05 8b 46 30 eb 0a 8b 46 58 85 c0 7f 07 8b 46 54 85 c0 78 11 48 c7 c6 a0 aa 24 82 48 89 ef e8 0b d2 02 00 <0f> 0b 48 89 ef e8 01 e7 ff ff be 13 00 00 00 48 89 ef 41 89 c4 41
All code
========
   0:	89 fb                	mov    %edi,%ebx
   2:	0f ba e0 10          	bt     $0x10,%eax
   6:	72 05                	jb     0xd
   8:	8b 46 30             	mov    0x30(%rsi),%eax
   b:	eb 0a                	jmp    0x17
   d:	8b 46 58             	mov    0x58(%rsi),%eax
  10:	85 c0                	test   %eax,%eax
  12:	7f 07                	jg     0x1b
  14:	8b 46 54             	mov    0x54(%rsi),%eax
  17:	85 c0                	test   %eax,%eax
  19:	78 11                	js     0x2c
  1b:	48 c7 c6 a0 aa 24 82 	mov    $0xffffffff8224aaa0,%rsi
  22:	48 89 ef             	mov    %rbp,%rdi
  25:	e8 0b d2 02 00       	callq  0x2d235
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 89 ef             	mov    %rbp,%rdi
  2f:	e8 01 e7 ff ff       	callq  0xffffffffffffe735
  34:	be 13 00 00 00       	mov    $0x13,%esi
  39:	48 89 ef             	mov    %rbp,%rdi
  3c:	41 89 c4             	mov    %eax,%r12d
  3f:	41                   	rex.B

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 89 ef             	mov    %rbp,%rdi
   5:	e8 01 e7 ff ff       	callq  0xffffffffffffe70b
   a:	be 13 00 00 00       	mov    $0x13,%esi
   f:	48 89 ef             	mov    %rbp,%rdi
  12:	41 89 c4             	mov    %eax,%r12d
  15:	41                   	rex.B
[   28.075337][ T4983] RSP: 0000:ffffc90000223b08 EFLAGS: 00010046
[   28.076117][ T4983] RAX: 0000000000000039 RBX: ffff8881195e4dd8 RCX: 0000000000000027
[   28.077144][ T4983] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88842fc1c680
[   28.078211][ T4983] RBP: ffffea0005fa0b00 R08: 0000000000000000 R09: 0000000000000019
[   28.079264][ T4983] R10: 0000000000000000 R11: 6d75642065676170 R12: ffffea0005fa0b00
[   28.080312][ T4983] R13: 0000000000000000 R14: ffff8881195e4dd8 R15: 000000000000000c
[   28.081380][ T4983] FS:  0000000000000000(0000) GS:ffff88842fc00000(0063) knlGS:0000000008acb840
[   28.082525][ T4983] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   28.083399][ T4983] CR2: 0000000000200000 CR3: 0000000118c36000 CR4: 00000000000406f0
[   28.084497][ T4983] DR0: fffffffff68cc000 DR1: 0000000000000000 DR2: 0000000000000000
[   28.085589][ T4983] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
[   28.086685][ T4983] Call Trace:
[   28.087222][ T4983]  <TASK>
[ 28.087701][ T4983] __filemap_remove_folio (??:?) 
[ 28.088418][ T4983] ? unmap_mapping_range_tree (memory.c:?) 
[ 28.089168][ T4983] ? mapping_can_writeback+0x5/0xc 
[ 28.089940][ T4983] filemap_remove_folio (??:?) 
[ 28.090627][ T4983] truncate_inode_folio (??:?) 
[ 28.091342][ T4983] shmem_undo_range (shmem.c:?) 
[ 28.092036][ T4983] shmem_truncate_range (??:?) 
[ 28.092753][ T4983] shmem_fallocate (shmem.c:?) 
[ 28.093444][ T4983] vfs_fallocate (??:?) 
[ 28.094128][ T4983] madvise_vma_behavior (madvise.c:?) 
[ 28.094874][ T4983] do_madvise (??:?) 
[ 28.095491][ T4983] __ia32_sys_madvise (??:?) 
[ 28.096166][ T4983] do_int80_syscall_32 (??:?) 
[ 28.096885][ T4983] entry_INT80_compat (??:?) 
[   28.097538][ T4983] RIP: 0023:0x80a3392
[ 28.098133][ T4983] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 c8 a9 ac 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 f0 a9 ac 08 85
All code
========
   0:	89 c8                	mov    %ecx,%eax
   2:	c3                   	retq   
   3:	90                   	nop
   4:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   8:	85 c0                	test   %eax,%eax
   a:	c7 01 01 00 00 00    	movl   $0x1,(%rcx)
  10:	75 d8                	jne    0xffffffffffffffea
  12:	a1 c8 a9 ac 08 eb d1 	movabs 0x9066d1eb08aca9c8,%eax
  19:	66 90 
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	66 90                	xchg   %ax,%ax
  21:	66 90                	xchg   %ax,%ax
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	90                   	nop
  28:	cd 80                	int    $0x80
  2a:*	c3                   	retq   		<-- trapping instruction
  2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
  38:	8b 10                	mov    (%rax),%edx
  3a:	a3                   	.byte 0xa3
  3b:	f0                   	lock
  3c:	a9                   	.byte 0xa9
  3d:	ac                   	lods   %ds:(%rsi),%al
  3e:	08                   	.byte 0x8
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	c3                   	retq   
   1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
   e:	8b 10                	mov    (%rax),%edx
  10:	a3                   	.byte 0xa3
  11:	f0                   	lock
  12:	a9                   	.byte 0xa9
  13:	ac                   	lods   %ds:(%rsi),%al
  14:	08                   	.byte 0x8
  15:	85                   	.byte 0x85
[   28.100541][ T4983] RSP: 002b:00000000ffa5c9b8 EFLAGS: 00000292 ORIG_RAX: 00000000000000db
[   28.101693][ T4983] RAX: ffffffffffffffda RBX: 00000000f500d000 RCX: 000000000014c000
[   28.102812][ T4983] RDX: 0000000000000009 RSI: 0000000000200000 RDI: 0000000000000002
[   28.103946][ T4983] RBP: 00000000000000ff R08: 0000000000000000 R09: 0000000000000000
[   28.105054][ T4983] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   28.106161][ T4983] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   28.107273][ T4983]  </TASK>
[   28.107785][ T4983] Modules linked in: can_bcm can_raw can cn scsi_transport_iscsi sr_mod cdrom ata_generic
[   28.109085][ T4983] ---[ end trace 0000000000000000 ]---
[ 28.109822][ T4983] RIP: 0010:filemap_unaccount_folio (filemap.c:?) 
[ 28.110662][ T4983] Code: 89 fb 0f ba e0 10 72 05 8b 46 30 eb 0a 8b 46 58 85 c0 7f 07 8b 46 54 85 c0 78 11 48 c7 c6 a0 aa 24 82 48 89 ef e8 0b d2 02 00 <0f> 0b 48 89 ef e8 01 e7 ff ff be 13 00 00 00 48 89 ef 41 89 c4 41
All code
========
   0:	89 fb                	mov    %edi,%ebx
   2:	0f ba e0 10          	bt     $0x10,%eax
   6:	72 05                	jb     0xd
   8:	8b 46 30             	mov    0x30(%rsi),%eax
   b:	eb 0a                	jmp    0x17
   d:	8b 46 58             	mov    0x58(%rsi),%eax
  10:	85 c0                	test   %eax,%eax
  12:	7f 07                	jg     0x1b
  14:	8b 46 54             	mov    0x54(%rsi),%eax
  17:	85 c0                	test   %eax,%eax
  19:	78 11                	js     0x2c
  1b:	48 c7 c6 a0 aa 24 82 	mov    $0xffffffff8224aaa0,%rsi
  22:	48 89 ef             	mov    %rbp,%rdi
  25:	e8 0b d2 02 00       	callq  0x2d235
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 89 ef             	mov    %rbp,%rdi
  2f:	e8 01 e7 ff ff       	callq  0xffffffffffffe735
  34:	be 13 00 00 00       	mov    $0x13,%esi
  39:	48 89 ef             	mov    %rbp,%rdi
  3c:	41 89 c4             	mov    %eax,%r12d
  3f:	41                   	rex.B

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 89 ef             	mov    %rbp,%rdi
   5:	e8 01 e7 ff ff       	callq  0xffffffffffffe70b
   a:	be 13 00 00 00       	mov    $0x13,%esi
   f:	48 89 ef             	mov    %rbp,%rdi
  12:	41 89 c4             	mov    %eax,%r12d
  15:	41                   	rex.B


To reproduce:

        # build kernel
	cd linux
	cp config-6.2.0-rc4-00443-g0503ea8f5ba7 .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--rUfPHAfZyEX1LoYC
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc4-00443-g0503ea8f5ba7"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
# CONFIG_X86_UV is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=512
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_VMAP_PFN=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=m
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_VMD is not set
# CONFIG_PCI_HYPERV_INTERFACE is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_MMIO=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=m

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
# CONFIG_CDROM_PKTCDVD is not set
CONFIG_ATA_OVER_ETH=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
CONFIG_PATA_SIS=m
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_AUDIT is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=y
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=y
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
# CONFIG_CHELSIO_T1_1G is not set
CONFIG_CHELSIO_T3=y
CONFIG_CHELSIO_T4=y
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
CONFIG_SUNDANCE=y
CONFIG_SUNDANCE_MMIO=y
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_HWMON is not set
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
# CONFIG_E1000E_HWTS is not set
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=y
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_JME=y
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8851_MLL=y
CONFIG_KSZ884X_PCI=y
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=y
CONFIG_QLCNIC=y
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=y
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=y
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=y
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
CONFIG_SIS190=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=y
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=y
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
# CONFIG_STMMAC_SELFTESTS is not set
CONFIG_STMMAC_PLATFORM=y
# CONFIG_DWMAC_GENERIC is not set
CONFIG_DWMAC_INTEL=y
# CONFIG_DWMAC_LOONGSON is not set
# CONFIG_STMMAC_PCI is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NIU=y
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=y
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=y
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
CONFIG_BROADCOM_PHY=y
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_LXT_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=y
# end of PCS device drivers

CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOE=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
CONFIG_USB_NET_RNDIS_HOST=m
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
CONFIG_USB_NET_CX82310_ETH=y
CONFIG_USB_NET_KALMIA=y
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_USB_RTL8153_ECM=m
CONFIG_WLAN=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
CONFIG_USB_NET_RNDIS_WLAN=m
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
CONFIG_NETDEVSIM=m
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
# CONFIG_INPUT_FF_MEMLESS is not set
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_HYPERV_KEYBOARD=y
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=16
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
# CONFIG_NULL_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_CTL_FAST_LOOKUP=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
# CONFIG_SND_CTL_DEBUG is not set
# CONFIG_SND_JACK_INJECTION_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=y
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_FT260 is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_HYPERV_MOUSE is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
CONFIG_USB_STORAGE_ENE_UB6250=y
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFS_HWMON is not set
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="n"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_UTILS is not set
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=y
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=y
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
CONFIG_CIFS_DEBUG2=y
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_ROOT is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=y
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ARIA is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_VMAC is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--rUfPHAfZyEX1LoYC
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='trinity.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linus/master'
	export commit='0503ea8f5ba73eb3ab13a81c1eefbaf51405385a'
	export kconfig='x86_64-kexec'
	export repeat_to=20
	export nr_vm=300
	export submit_id='63f864d870e43a1c48b1d79d'
	export job_file='/lkp/jobs/scheduled/vm-meta-102/trinity-group-04-300s-yocto-i386-minimal-20190520.cgz-0503ea8f5ba73eb3ab13a81c1eefbaf51405385a-20230224-7240-hzx70n-16.yaml'
	export id='616bfec24e2573516d90ee2d5420a09099f444e4'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='yocto-i386-minimal-20190520.cgz'
	export compiler='gcc-11'
	export enqueue_time='2023-02-24 15:18:48 +0800'
	export _id='63f864ef70e43a1c48b1d7a1'
	export _rt='/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf51405385a'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf51405385a/19'
	export scheduler_version='/lkp/lkp/src'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/yocto/yocto-i386-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf51405385a/19
BOOT_IMAGE=/pkg/linux/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf51405385a/vmlinuz-6.2.0-rc4-00443-g0503ea8f5ba7
branch=linus/master
job=/lkp/jobs/scheduled/vm-meta-102/trinity-group-04-300s-yocto-i386-minimal-20190520.cgz-0503ea8f5ba73eb3ab13a81c1eefbaf51405385a-20230224-7240-hzx70n-16.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-kexec
commit=0503ea8f5ba73eb3ab13a81c1eefbaf51405385a
initcall_debug
nmi_watchdog=0
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf51405385a/modules.cgz'
	export bm_initrd='/osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-i386-x86_64-1c734c75-1_2020-01-06.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.kernel_BUG_at_mm/filemap.c'
	export kbuild_queue_analysis=1
	export meta_host='vm-meta-102'
	export kernel='/pkg/linux/x86_64-kexec/gcc-11/0503ea8f5ba73eb3ab13a81c1eefbaf51405385a/vmlinuz-6.2.0-rc4-00443-g0503ea8f5ba7'
	export dequeue_time='2023-02-24 15:20:20 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-102/trinity-group-04-300s-yocto-i386-minimal-20190520.cgz-0503ea8f5ba73eb3ab13a81c1eefbaf51405385a-20230224-7240-hzx70n-16.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-04' $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--rUfPHAfZyEX1LoYC
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AARZWg==

--rUfPHAfZyEX1LoYC
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-parent-1.xz"
Content-Transfer-Encoding: base64

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
qNgB5t4JhOgr/LHEZ/sCAAAAAARZWg==

--rUfPHAfZyEX1LoYC
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-parent-2.xz"
Content-Transfer-Encoding: base64

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
AgAAAAAEWVo=

--rUfPHAfZyEX1LoYC--
