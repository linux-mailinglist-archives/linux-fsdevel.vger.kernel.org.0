Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2010D6C5099
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 17:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCVQ1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 12:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCVQ1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:27:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00C954CA8;
        Wed, 22 Mar 2023 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679502406; x=1711038406;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=JlALF8Yx0AxShbljC2iLN5cNW18GCcxqRVibn9fAdDU=;
  b=EVb92jSa5Vb+KC2T6dwcGI7TD0Qdnp8bfCyNqepBV3N223jrNeBRx5pZ
   PmDobxyjv1DSDyZna+dM8u9OfIZix5vvqr3fV31QwidbMyeb0cWeBTJkv
   VRyyXRYehXX71sHF131Vza+mAD9h+VXeUTUxatYJum8evLIZy9XY4Of8u
   /nRUD/FK89JUwGAZQHYG4cD91AurlYwfy101cNqcX2m40GmsW9vezi8HL
   5XKJ5xJFoy8Z5fyL+JbnaPH8i+7MnUnukuuTQ1a1OqvPg+mzbZfPPBOOI
   d/clcZkM8ziNRC0kQn7U9nGdwb0bJhiXgf7sooyAuPd9SLdHPvnxdXNeG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="323107106"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="323107106"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 09:26:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856156770"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="856156770"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2023 09:26:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 09:26:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 09:26:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 09:26:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HF1rzad8721nu4MrF+etUbPjfBBNjTH2cCVeBtuOXm+YsGYGDhYbNhFF2EZHcj6X3qzcR/6yjPJZ099DWxE5c9WqJkXsuxeSX0bmkjCWxNdTEqKqUsrbpgBEhpVSGxd71nPUAgzmMYNLL3DBwABWNolw7DaIGNKehVEvOHS+JlZ9A4Ldu/3pdxnYgOTofi7hnujq9pL7b7h7HDmmrP23UGadj0D1TUdlPbhIkfPv3cVPlAle2zI6BUkj9eKKaLo5NUKH07Lh/71U09DdyEWv8kUOhjQ5JwdvDwY2xYjc32FXklOeGjLyG+4dbXRzIAGxZTFIARLIrXkwzwt7ZGvcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFmJX9YS516ON59AQlhUnyazHJSQh+Ukls6zH5soRY4=;
 b=QjOfwunZhnzJeKr/YfaWpMaD3VmnaXOocQ3rcKI2C6qihUnEdB2/Liqy+zciK0X2TszcWqq1y1FJNpHPidjaeSRDeYr3gBQQRf7n5Guh5g3vO/nvDzRqcIxpIMZ976q5pnul97AGzHqXjRGTLib59oJ/NGfslO5dwZl0+9H8Hn5D6sZC+S50R3hota993L1fMyUKJqMyu/ihFSD9cfH/bLiK0l2USWPO8zKoz8JGw16v0qw0LOaaRjBN7En0IsCFaF384NVOH8aQo+xGZbQS4e/MiIp0PdNGvXKosy/L6wf9mfEJxb/msaa9cUYiDnazb7vaUoNEc9rPQrQ26UR1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA3PR11MB7416.namprd11.prod.outlook.com (2603:10b6:806:316::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:26:06 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:26:06 +0000
Date:   Thu, 23 Mar 2023 00:23:22 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [linus:master] [selftests/mount_setattr] d8e45bf1ae:
 kernel-selftests.mount_setattr.make.fail
Message-ID: <202303230011.43c63f0c-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="zGORFlIilFuPTYMD"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA3PR11MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c29dbfa-4c12-4774-2f6d-08db2af22271
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUoC9seAmBZbbi0omQwfgZSvqbY+4JL5jlthYOSR0jRXB5qkeUO0GzPv7u5wlhQXE+mMVPg6Q1t6L0wgs4ihSD7dkYzgKh7K1w15wbmRDRO68p6b4DbUF3sCZLjphIULpPaR7plwA8r/D8bwMf/HJITpFGV2ICRrQLEQkL9NFhW1TC6jripYWp1vqwTflcA50YLXYIeHgDkBiJFBdb5kUFCiwiuHdCN7dP1FRvukeI22V6r1hyBoh8kyKJumuiP3dezrPNdoo0f5ZP+Qy1dkcoXVhIOmoEpwvYYMGK0qvN5Y3BqteW+b2OhyICqbCAIu8ZBMZB5JMreLkY466xw1LxXsmoKgJQX3pyEk0UQpihuJvg9hRFiYxcswiBzwDvH3TxCMFD8sr2WOFU0XZsvyoW2U7ydk5bNTecYznBtG1UYJOIZ8jHi3uf8gubHixRzuLO7HFeoAOh8UFyYS9dl8YVSho/4wWlPcDpndjt6hFdfA5/3QMzFZaGYZBVsglMchYpjiN4lpFYuhSa9VJz9ZQb5rC0uIy3mXh8iJVP45DGqjasZGK7mOHhMY2GbP0oe0El2LqEQpcR5hn+GgHarMepa3OWciLylyX1GUQMEkVILLb8az1z4ZGFF4hAPLhdOUlMgKbz5otiY1QxKt2M1xDkzfxftSj8sKeM85eqFx8tW5LWskT7tJ9rX2Va+NmSMLYkZo+ZxB4XZ8bXOAbzpADEoYSUxhASGLz9Hf/lGnWUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199018)(6666004)(2616005)(478600001)(21490400003)(83380400001)(38100700002)(6486002)(966005)(33964004)(316002)(44144004)(6512007)(1076003)(6506007)(186003)(8936002)(86362001)(4326008)(235185007)(66556008)(6916009)(82960400001)(26005)(66946007)(66476007)(2906002)(30864003)(5660300002)(41300700001)(8676002)(36756003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWszaFpPenhyYjltOWRWUlQ1RjhkbTBUNzdVYXMyYmk4eS9mdVNjMndzWlZL?=
 =?utf-8?B?Mmx1dnhrTE9TeE5Pa0lWb0RjR3R6S0huWEhWUVN3UzZxeGtvWmZLVDFPMzBk?=
 =?utf-8?B?RWlrYlhNZ0N0ZFdJczg3YlI1dDd6S3lMc25BdUdHQWRvYnFySTRXajRjVDBE?=
 =?utf-8?B?aEFuamhLVkJoTTBCeVViMVJKS1UzRExLR0hjb0E1OUlsRVIwYmh2SldEc2N3?=
 =?utf-8?B?NU8xcVhVbGkvU1RrK0tHdTl1aUxpSmpleXIwMko2V3JMV2FCNk1ERFdnZWxo?=
 =?utf-8?B?THRlYkZ4QllJSlRWVHdTV0NvYVFRNVdTaDJhYmZHTW4yaGtWRUZqN0czOVlT?=
 =?utf-8?B?UmFKeEhPNXhrcUtYNVFGNUJ4QktKclBCSEluK280bUFkR3QreGYzc2dlN2Ri?=
 =?utf-8?B?VWRIdXJvMDVrdDBVTXhpYzc5YmN4YzZSMXRhTHZMTnFCQjlFNzZYRGhPbEl5?=
 =?utf-8?B?YWdQZXI2Y1FBR0xLR2dWOHJyY201K2hKSmhRVUorTGFDbE5KTGlRdEZTczdS?=
 =?utf-8?B?bEx4WjFoRnJ4NENXd1V0VnQvWmtyUjhYcm9kS2RGUnpnSjJ0dXl6UFhPZGZ2?=
 =?utf-8?B?ZGhTeUNYdVdVNExoSEJoRTlRbU9XZnpJVlErbFdrWk9tcTh5UHQvTVhEUm1C?=
 =?utf-8?B?Qmh0aTBVUWRKWEpDUElzL2p0SGJBcU9QdjQrRlRGbHNMcDcrTVhVQlg1akJK?=
 =?utf-8?B?cEFTdVMvRmNMa0ZDbUFlNE5zalRITEEzQ1V1SElJeFEzRmUrQUFOa0t6RWtF?=
 =?utf-8?B?cXR1YmN2eU5ZNUo1czFmZGxBVnBiSGdKdk1OWE9DYVB4U3lpOU9KUGgrK3hM?=
 =?utf-8?B?YjVmNTgxT3Qra0ZWZUFLK0c2ZGhCOURsZVZ0eFpRbWFpa3hoUDFGTzVhV2F1?=
 =?utf-8?B?ck1lNWdFbndnN3FkUDREdDZkMm1FYnBwclF1ZDk1MlhOMWREdXh2OG9vd09k?=
 =?utf-8?B?VFJ6SDBFZU85WUFjV1BXd2NlemRzcWM4OU9nYUpBSTNJRWhDa3FQMGNEWE1Z?=
 =?utf-8?B?L29QTmp3MjdGMllrWi80YUFhWjNSR2ZmTjVaK3ZPK1NieDhiSmE0SExObkor?=
 =?utf-8?B?SnJMa3NsWjArUXA3RGhGbFlTSEc5OG1EOFdHcCszRzRFK29oWVVXK05zN0Fn?=
 =?utf-8?B?bFNubUY4MUVNZmxzZ08xZWhwbWplMmVLNk15MHV1NmtlTWdmNFQ5MzRvQklO?=
 =?utf-8?B?cUFtbThHZWVvQlYybmxqdW9VNWhrYUJoa2d2bFdPUmtaSlY5LzZ3T25ydWNQ?=
 =?utf-8?B?UkpIMjlQNUJBQk1sbEprWDlpMWdCRHpJck95aDlRVjVVMSs2WHhneHlyNHlr?=
 =?utf-8?B?MkJrRWpnTE0wUi9mRE5JRDd5c0p4YTQ0bTBRQWJPTEFpN1crK1lZN282cWdQ?=
 =?utf-8?B?Z0JVNEZ5ajJwTXlXcWV4MjFLQlB2dVBJL0RleVNtSThhZlNpYW03bkYzNzlY?=
 =?utf-8?B?NkFjRldxSkw4bFJhdE9TQklUaUZ5MnZib0VpUFhvTWd2bm9Nbks1bjhZZk1K?=
 =?utf-8?B?UjlFVUxnRHplczUyWlAzZnhZQkh2bTFQWHBOZ1haSnpKczh0U1VWZVVPdVp0?=
 =?utf-8?B?eDh5VFV0T2hYeGU4UnpnMGZ5Zmt0eStTSUxyV1RhZmF5b01NNjMrK3NMU3RZ?=
 =?utf-8?B?SDVIRjhBeTVzdDl1cGtZWm5NVmVyYmRlNXYyemg1UmMzdnRZMWFIelFDS3Ex?=
 =?utf-8?B?QlIvakh2dFpNaVdkdTNIZy9GNDFXMFNpaG1Na0JwR0VzRzlsc0RZZFYvdFM4?=
 =?utf-8?B?MXNBVzJobE5NS1JDRTRiVmh5YWkwemNDWjJkRnpEWGNiSW1pVTdRSGhJVzhp?=
 =?utf-8?B?NTE5MTFNUUpWWDFFSU01R1d0T3Q4aXdqWE96RXE0ZGZ2bkg1bjl5aCtBY1R6?=
 =?utf-8?B?Wk9UTXZoRXFDZEZKbU4remZ4UmV6cXVkc01MdEdSczlHVnYycWRWWk44aXRJ?=
 =?utf-8?B?Tjc5ZEg1T3J4ZGdHa1pudjJNaWxRdkhWQVdHdnBFbmlVT0VjTmUxdm5BaDJ1?=
 =?utf-8?B?OU90cE1XeHF2VUZmOExiODVuamZsVmdRZVZRU3RVVStTR0dHZWNLRXZiOHVY?=
 =?utf-8?B?dnQ4N3p3VEg3WkFndm1lWlROVE8wUUhlalNkOW4zSTJrOVBGR01CUFo4UVcy?=
 =?utf-8?Q?f7s8Ru09OBMvDT8nVrrGR/8AV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c29dbfa-4c12-4774-2f6d-08db2af22271
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:26:06.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9C9lN/Ycaeub9DTAQUzWntVyTW4ihPYZwyo5gSO2mqCGjHHoEjhcPZHif7ggkOe1YAExyScU3JchVz5xj5Zvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7416
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--zGORFlIilFuPTYMD
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

kernel test robot noticed kernel-selftests.mount_setattr.make.fail due to commit (built with gcc-11):

commit: d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8 ("selftests/mount_setattr: fix redefine struct mount_attr build error")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 73f2c2a7e1d2b31fdd5faa6dfa151c437a6c0a5a]

in testcase: kernel-selftests
version: kernel-selftests-i386-75776cf2-1_20221008
with following parameters:

	group: group-02

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt

on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


2023-03-20 06:15:43 make -C mount_setattr
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_setattr'
gcc -g -isystem /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/../../../usr/include -Wall -O2 -pthread     mount_setattr_test.c  -o /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_setattr/mount_setattr_test
mount_setattr_test.c:137:16: warning: ‘struct mount_attr’ declared inside parameter list will not be visible outside of this definition or declaration
  137 |         struct mount_attr *attr, size_t size)
      |                ^~~~~~~~~~
mount_setattr_test.c: In function ‘mount_setattr_thread’:
mount_setattr_test.c:343:9: error: variable ‘attr’ has initializer but incomplete type
  343 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:344:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
  344 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:344:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  344 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for ‘attr’)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:344:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  344 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:345:4: error: ‘struct mount_attr’ has no member named ‘attr_clr’
  345 |   .attr_clr = 0,
      |    ^~~~~~~~
mount_setattr_test.c:345:15: warning: excess elements in struct initializer
  345 |   .attr_clr = 0,
      |               ^
mount_setattr_test.c:345:15: note: (near initialization for ‘attr’)
mount_setattr_test.c:346:4: error: ‘struct mount_attr’ has no member named ‘propagation’
  346 |   .propagation = MS_SHARED,
      |    ^~~~~~~~~~~
mount_setattr_test.c:346:18: warning: excess elements in struct initializer
  346 |   .propagation = MS_SHARED,
      |                  ^~~~~~~~~
mount_setattr_test.c:346:18: note: (near initialization for ‘attr’)
mount_setattr_test.c:343:20: error: storage size of ‘attr’ isn’t known
  343 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:343:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_invalid_attributes’:
mount_setattr_test.c:441:9: error: variable ‘invalid_attr’ has initializer but incomplete type
  441 |  struct mount_attr invalid_attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:442:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
  442 |   .attr_set = (1U << 31),
      |    ^~~~~~~~
mount_setattr_test.c:442:15: warning: excess elements in struct initializer
  442 |   .attr_set = (1U << 31),
      |               ^
mount_setattr_test.c:442:15: note: (near initialization for ‘invalid_attr’)
mount_setattr_test.c:441:20: error: storage size of ‘invalid_attr’ isn’t known
  441 |  struct mount_attr invalid_attr = {
      |                    ^~~~~~~~~~~~
mount_setattr_test.c:441:20: warning: unused variable ‘invalid_attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_extensibility’:
mount_setattr_test.c:475:9: error: variable ‘invalid_attr’ has initializer but incomplete type
  475 |  struct mount_attr invalid_attr = {};
      |         ^~~~~~~~~~
mount_setattr_test.c:475:20: error: storage size of ‘invalid_attr’ isn’t known
  475 |  struct mount_attr invalid_attr = {};
      |                    ^~~~~~~~~~~~
mount_setattr_test.c:477:21: error: field ‘attr1’ has incomplete type
  477 |   struct mount_attr attr1;
      |                     ^~~~~
mount_setattr_test.c:478:21: error: field ‘attr2’ has incomplete type
  478 |   struct mount_attr attr2;
      |                     ^~~~~
mount_setattr_test.c:479:21: error: field ‘attr3’ has incomplete type
  479 |   struct mount_attr attr3;
      |                     ^~~~~
mount_setattr_test.c:475:20: warning: unused variable ‘invalid_attr’ [-Wunused-variable]
  475 |  struct mount_attr invalid_attr = {};
      |                    ^~~~~~~~~~~~
mount_setattr_test.c: In function ‘mount_setattr_basic’:
mount_setattr_test.c:538:9: error: variable ‘attr’ has initializer but incomplete type
  538 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:539:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
  539 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:539:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  539 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for ‘attr’)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:539:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  539 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:540:4: error: ‘struct mount_attr’ has no member named ‘attr_clr’
  540 |   .attr_clr = MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:61:27: warning: excess elements in struct initializer
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:540:15: note: in expansion of macro ‘MOUNT_ATTR__ATIME’
  540 |   .attr_clr = MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:61:27: note: (near initialization for ‘attr’)
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:540:15: note: in expansion of macro ‘MOUNT_ATTR__ATIME’
  540 |   .attr_clr = MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:538:20: error: storage size of ‘attr’ isn’t known
  538 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:538:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_basic_recursive’:
mount_setattr_test.c:574:9: error: variable ‘attr’ has initializer but incomplete type
  574 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:575:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
  575 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:575:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  575 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for ‘attr’)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:575:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  575 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:576:4: error: ‘struct mount_attr’ has no member named ‘attr_clr’
  576 |   .attr_clr = MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:61:27: warning: excess elements in struct initializer
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:576:15: note: in expansion of macro ‘MOUNT_ATTR__ATIME’
  576 |   .attr_clr = MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:61:27: note: (near initialization for ‘attr’)
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:576:15: note: in expansion of macro ‘MOUNT_ATTR__ATIME’
  576 |   .attr_clr = MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:574:20: error: storage size of ‘attr’ isn’t known
  574 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:574:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_mount_has_writers’:
mount_setattr_test.c:668:9: error: variable ‘attr’ has initializer but incomplete type
  668 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:669:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
  669 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:669:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  669 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for ‘attr’)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:669:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  669 |   .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:670:4: error: ‘struct mount_attr’ has no member named ‘attr_clr’
  670 |   .attr_clr = MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:61:27: warning: excess elements in struct initializer
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:670:15: note: in expansion of macro ‘MOUNT_ATTR__ATIME’
  670 |   .attr_clr = MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:61:27: note: (near initialization for ‘attr’)
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:670:15: note: in expansion of macro ‘MOUNT_ATTR__ATIME’
  670 |   .attr_clr = MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:671:4: error: ‘struct mount_attr’ has no member named ‘propagation’
  671 |   .propagation = MS_SHARED,
      |    ^~~~~~~~~~~
mount_setattr_test.c:671:18: warning: excess elements in struct initializer
  671 |   .propagation = MS_SHARED,
      |                  ^~~~~~~~~
mount_setattr_test.c:671:18: note: (near initialization for ‘attr’)
mount_setattr_test.c:668:20: error: storage size of ‘attr’ isn’t known
  668 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:668:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_mixed_mount_options’:
mount_setattr_test.c:725:9: error: variable ‘attr’ has initializer but incomplete type
  725 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:726:4: error: ‘struct mount_attr’ has no member named ‘attr_clr’
  726 |   .attr_clr = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:726:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  726 |   .attr_clr = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for ‘attr’)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:726:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  726 |   .attr_clr = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:727:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
  727 |   .attr_set = MOUNT_ATTR_RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:65:29: warning: excess elements in struct initializer
   65 | #define MOUNT_ATTR_RELATIME 0x00000000
      |                             ^~~~~~~~~~
mount_setattr_test.c:727:15: note: in expansion of macro ‘MOUNT_ATTR_RELATIME’
  727 |   .attr_set = MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:65:29: note: (near initialization for ‘attr’)
   65 | #define MOUNT_ATTR_RELATIME 0x00000000
      |                             ^~~~~~~~~~
mount_setattr_test.c:727:15: note: in expansion of macro ‘MOUNT_ATTR_RELATIME’
  727 |   .attr_set = MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:725:20: error: storage size of ‘attr’ isn’t known
  725 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:725:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_time_changes’:
mount_setattr_test.c:759:9: error: variable ‘attr’ has initializer but incomplete type
  759 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:760:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
  760 |   .attr_set = MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
      |    ^~~~~~~~
mount_setattr_test.c:57:31: warning: excess elements in struct initializer
   57 | #define MOUNT_ATTR_NODIRATIME 0x00000080
      |                               ^~~~~~~~~~
mount_setattr_test.c:760:15: note: in expansion of macro ‘MOUNT_ATTR_NODIRATIME’
  760 |   .attr_set = MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
      |               ^~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:57:31: note: (near initialization for ‘attr’)
   57 | #define MOUNT_ATTR_NODIRATIME 0x00000080
      |                               ^~~~~~~~~~
mount_setattr_test.c:760:15: note: in expansion of macro ‘MOUNT_ATTR_NODIRATIME’
  760 |   .attr_set = MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
      |               ^~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:759:20: error: storage size of ‘attr’ isn’t known
  759 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:759:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_wrong_user_namespace’:
mount_setattr_test.c:963:9: error: variable ‘attr’ has initializer but incomplete type
  963 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:964:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
  964 |   .attr_set = MOUNT_ATTR_RDONLY,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:964:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  964 |   .attr_set = MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for ‘attr’)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:964:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  964 |   .attr_set = MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:963:20: error: storage size of ‘attr’ isn’t known
  963 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:963:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_wrong_mount_namespace’:
mount_setattr_test.c:979:9: error: variable ‘attr’ has initializer but incomplete type
  979 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:980:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
  980 |   .attr_set = MOUNT_ATTR_RDONLY,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:980:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  980 |   .attr_set = MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for ‘attr’)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:980:15: note: in expansion of macro ‘MOUNT_ATTR_RDONLY’
  980 |   .attr_set = MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:979:20: error: storage size of ‘attr’ isn’t known
  979 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:979:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_invalid_fd_negative’:
mount_setattr_test.c:1070:9: error: variable ‘attr’ has initializer but incomplete type
 1070 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1071:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1071 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1071:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1071 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1071:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1071 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1072:4: error: ‘struct mount_attr’ has no member named ‘userns_fd’
 1072 |   .userns_fd = -EBADF,
      |    ^~~~~~~~~
mount_setattr_test.c:1072:16: warning: excess elements in struct initializer
 1072 |   .userns_fd = -EBADF,
      |                ^
mount_setattr_test.c:1072:16: note: (near initialization for ‘attr’)
mount_setattr_test.c:1070:20: error: storage size of ‘attr’ isn’t known
 1070 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1070:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_invalid_fd_large’:
mount_setattr_test.c:1088:9: error: variable ‘attr’ has initializer but incomplete type
 1088 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1089:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1089 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1089:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1089 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1089:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1089 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1090:4: error: ‘struct mount_attr’ has no member named ‘userns_fd’
 1090 |   .userns_fd = INT64_MAX,
      |    ^~~~~~~~~
mount_setattr_test.c:1090:16: warning: excess elements in struct initializer
 1090 |   .userns_fd = INT64_MAX,
      |                ^~~~~~~~~
mount_setattr_test.c:1090:16: note: (near initialization for ‘attr’)
mount_setattr_test.c:1088:20: error: storage size of ‘attr’ isn’t known
 1088 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1088:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_invalid_fd_closed’:
mount_setattr_test.c:1107:9: error: variable ‘attr’ has initializer but incomplete type
 1107 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1108:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1108 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1108:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1108 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1108:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1108 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1107:20: error: storage size of ‘attr’ isn’t known
 1107 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1107:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_invalid_fd_initial_userns’:
mount_setattr_test.c:1130:9: error: variable ‘attr’ has initializer but incomplete type
 1130 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1131:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1131 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1131:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1131 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1131:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1131 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1130:20: error: storage size of ‘attr’ isn’t known
 1130 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1130:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_attached_mount_inside_current_mount_namespace’:
mount_setattr_test.c:1239:9: error: variable ‘attr’ has initializer but incomplete type
 1239 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1240:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1240 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1240:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1240 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1240:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1240 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1239:20: error: storage size of ‘attr’ isn’t known
 1239 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1239:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_attached_mount_outside_current_mount_namespace’:
mount_setattr_test.c:1269:9: error: variable ‘attr’ has initializer but incomplete type
 1269 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1270:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1270 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1270:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1270 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1270:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1270 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1269:20: error: storage size of ‘attr’ isn’t known
 1269 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1269:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_detached_mount_inside_current_mount_namespace’:
mount_setattr_test.c:1299:9: error: variable ‘attr’ has initializer but incomplete type
 1299 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1300:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1300 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1300:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1300 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1300:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1300 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1299:20: error: storage size of ‘attr’ isn’t known
 1299 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1299:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_detached_mount_outside_current_mount_namespace’:
mount_setattr_test.c:1329:9: error: variable ‘attr’ has initializer but incomplete type
 1329 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1330:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1330 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1330:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1330 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1330:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1330 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1329:20: error: storage size of ‘attr’ isn’t known
 1329 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1329:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_change_idmapping’:
mount_setattr_test.c:1361:9: error: variable ‘attr’ has initializer but incomplete type
 1361 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1362:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1362 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1362:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1362 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1362:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1362 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1361:20: error: storage size of ‘attr’ isn’t known
 1361 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1361:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_idmapped_idmap_mount_tree_invalid’:
mount_setattr_test.c:1406:9: error: variable ‘attr’ has initializer but incomplete type
 1406 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1407:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1407 |   .attr_set = MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1407:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1407 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for ‘attr’)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1407:15: note: in expansion of macro ‘MOUNT_ATTR_IDMAP’
 1407 |   .attr_set = MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1406:20: error: storage size of ‘attr’ isn’t known
 1406 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1406:20: warning: unused variable ‘attr’ [-Wunused-variable]
mount_setattr_test.c: In function ‘mount_setattr_mount_attr_nosymfollow’:
mount_setattr_test.c:1441:9: error: variable ‘attr’ has initializer but incomplete type
 1441 |  struct mount_attr attr = {
      |         ^~~~~~~~~~
mount_setattr_test.c:1442:4: error: ‘struct mount_attr’ has no member named ‘attr_set’
 1442 |   .attr_set = MOUNT_ATTR_NOSYMFOLLOW,
      |    ^~~~~~~~
mount_setattr_test.c:133:32: warning: excess elements in struct initializer
  133 | #define MOUNT_ATTR_NOSYMFOLLOW 0x00200000
      |                                ^~~~~~~~~~
mount_setattr_test.c:1442:15: note: in expansion of macro ‘MOUNT_ATTR_NOSYMFOLLOW’
 1442 |   .attr_set = MOUNT_ATTR_NOSYMFOLLOW,
      |               ^~~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:133:32: note: (near initialization for ‘attr’)
  133 | #define MOUNT_ATTR_NOSYMFOLLOW 0x00200000
      |                                ^~~~~~~~~~
mount_setattr_test.c:1442:15: note: in expansion of macro ‘MOUNT_ATTR_NOSYMFOLLOW’
 1442 |   .attr_set = MOUNT_ATTR_NOSYMFOLLOW,
      |               ^~~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:1441:20: error: storage size of ‘attr’ isn’t known
 1441 |  struct mount_attr attr = {
      |                    ^~~~
mount_setattr_test.c:1441:20: warning: unused variable ‘attr’ [-Wunused-variable]
make: *** [../lib.mk:145: /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_setattr/mount_setattr_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_setattr'


We did a quick investigation and found it may be related with the
version of libc headers in the system environment.
When libc v2.35 is installed, it fails when building mount_setattr
selftests.
When libc v2.36 is installed, it builds fine.


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202303230011.43c63f0c-yujie.liu@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--zGORFlIilFuPTYMD
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc5-00038-gd8e45bf1aed2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.2.0-rc5 Kernel Configuration
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
CONFIG_BUILD_SALT="4.19.0-8-686-pae"
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
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
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
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

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
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
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_BIGSMP=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_TOSHIBA=m
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=3
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=0
CONFIG_FUNCTION_PADDING_BYTES=4
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
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
CONFIG_PM_ADVANCED_DEBUG=y
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
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
# CONFIG_ACPI_TINY_POWER_BUTTON is not set
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NUMA is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
# CONFIG_ACPI_APEI_EINJ is not set
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

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
CONFIG_X86_PCC_CPUFREQ=m
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_POWERNOW_K8 is not set
CONFIG_X86_GX_SUSPMOD=m
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=m
CONFIG_X86_LONGRUN=m
CONFIG_X86_LONGHAUL=m
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
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

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
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
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
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
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
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
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
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
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT=4
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
# CONFIG_MODULE_SIG_ALL is not set
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
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
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=m
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
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
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_VMAP_PFN=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_GUP_GET_PXX_LOW_HIGH=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
CONFIG_XFRM_INTERFACE=m
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
# CONFIG_NETLABEL is not set
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
# CONFIG_BRIDGE_NETFILTER is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NETFILTER_NETLINK_OSF is not set
CONFIG_NF_CONNTRACK=m
# CONFIG_NF_LOG_SYSLOG is not set
CONFIG_NF_CONNTRACK_MARK=y
# CONFIG_NF_CONNTRACK_SECMARK is not set
CONFIG_NF_CONNTRACK_ZONES=y
# CONFIG_NF_CONNTRACK_PROCFS is not set
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_SNMP is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CONNTRACK_TFTP is not set
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
# CONFIG_NFT_CT is not set
CONFIG_NFT_FLOW_OFFLOAD=m
# CONFIG_NFT_CONNLIMIT is not set
# CONFIG_NFT_LOG is not set
# CONFIG_NFT_LIMIT is not set
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
# CONFIG_NFT_HASH is not set
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
CONFIG_NETFILTER_XTABLES=m

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
# CONFIG_NETFILTER_XT_CONNMARK is not set
# CONFIG_NETFILTER_XT_SET is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
# CONFIG_NETFILTER_XT_TARGET_MASQUERADE is not set
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=m
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
# CONFIG_NETFILTER_XT_MATCH_HL is not set
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
CONFIG_NETFILTER_XT_MATCH_SCTP=m
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
# CONFIG_IP_SET_BITMAP_IP is not set
# CONFIG_IP_SET_BITMAP_IPMAC is not set
# CONFIG_IP_SET_BITMAP_PORT is not set
# CONFIG_IP_SET_HASH_IP is not set
# CONFIG_IP_SET_HASH_IPMARK is not set
# CONFIG_IP_SET_HASH_IPPORT is not set
# CONFIG_IP_SET_HASH_IPPORTIP is not set
# CONFIG_IP_SET_HASH_IPPORTNET is not set
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
# CONFIG_IP_SET_HASH_NET is not set
# CONFIG_IP_SET_HASH_NETNET is not set
# CONFIG_IP_SET_HASH_NETPORT is not set
# CONFIG_IP_SET_HASH_NETIFACE is not set
# CONFIG_IP_SET_LIST_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_AH is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_FILTER is not set
# CONFIG_IP_NF_TARGET_SYNPROXY is not set
CONFIG_IP_NF_NAT=m
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_SECURITY is not set
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
CONFIG_IP6_NF_IPTABLES=m
# CONFIG_IP6_NF_MATCH_AH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_HL is not set
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
# CONFIG_IP6_NF_MATCH_MH is not set
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_FILTER is not set
# CONFIG_IP6_NF_TARGET_SYNPROXY is not set
# CONFIG_IP6_NF_MANGLE is not set
# CONFIG_IP6_NF_RAW is not set
# CONFIG_IP6_NF_SECURITY is not set
CONFIG_IP6_NF_NAT=m
# CONFIG_IP6_NF_TARGET_MASQUERADE is not set
# CONFIG_IP6_NF_TARGET_NPT is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
# CONFIG_ATM is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
CONFIG_LLC2=m
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=m
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_ACT_GATE=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=m
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
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
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=m
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
CONFIG_AF_RXRPC=m
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
# CONFIG_RXPERF is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_PN532_UART is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# CONFIG_NFC_S3FWRN82_UART is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
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
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_COMPAQ=m
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

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
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_MMIO=m
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=m
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=m
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
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
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_FD_RAWCMD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
CONFIG_ZRAM_MEMORY_TRACKING=y
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=m
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
# CONFIG_CS5535_MFGPT is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_PCH_PHUB is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
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
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
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
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

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
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_FDOMAIN_ISA is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=3
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CS5536 is not set
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
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SC1200 is not set
CONFIG_PATA_SCH=m
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_ISAPNP is not set
CONFIG_PATA_MPIIX=m
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_QDI is not set
CONFIG_PATA_RZ1000=m
# CONFIG_PATA_WINBOND_VLB is not set

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
# CONFIG_MD_CLUSTER is not set
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
CONFIG_DM_ERA=m
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
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
CONFIG_SBP_TARGET=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
CONFIG_EQUALIZER=m
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
CONFIG_VXLAN=m
CONFIG_GENEVE=m
CONFIG_BAREUDP=m
CONFIG_GTP=m
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
# CONFIG_CHELSIO_IPSEC_INLINE is not set
# CONFIG_NET_VENDOR_CIRRUS is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
# CONFIG_BE2NET_HWMON is not set
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
# CONFIG_BE2NET_LANCER is not set
# CONFIG_BE2NET_SKYHAWK is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=m
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
# CONFIG_IXGBE_IPSEC is not set
CONFIG_IXGBEVF=m
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
CONFIG_ICE=m
CONFIG_ICE_HWTS=y
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_NET_VENDOR_MARVELL is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=m
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
CONFIG_LXT_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=m
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
# CONFIG_CAN_VCAN is not set
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
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

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

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_USB_NET_DRIVERS=m
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_AX88179_178A=m
# CONFIG_USB_NET_CDCETHER is not set
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
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=m
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=m
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_GPIO=m
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=m
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=m
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_XTKBD=m
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_INPORT=m
# CONFIG_MOUSE_ATIXL is not set
CONFIG_MOUSE_LOGIBM=m
CONFIG_MOUSE_PC110PAD=m
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_HYPERV_KEYBOARD=m
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
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_FOURPORT=m
CONFIG_SERIAL_8250_ACCENT=m
CONFIG_SERIAL_8250_BOCA=m
CONFIG_SERIAL_8250_EXAR_ST16C554=m
CONFIG_SERIAL_8250_HUB6=m
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
# CONFIG_SERIAL_8250_LPSS is not set
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_PCH_UART=m
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=m
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_DTLK=m
CONFIG_APPLICOM=m
CONFIG_SONYPI=m
CONFIG_MWAVE=m
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=m
CONFIG_DEVMEM=y
CONFIG_NVRAM=m
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=m
# CONFIG_TCG_TIS_SPI_CR50 is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
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
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=m
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
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
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_DESIGNWARE_PCI=m
CONFIG_I2C_EG20T=m
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
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=m
CONFIG_SPI_BUTTERFLY=m
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_INTEL_PCI is not set
# CONFIG_SPI_INTEL_PLATFORM is not set
CONFIG_SPI_LM70_LLP=m
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_TOPCLIFF_PCH=m
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
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
CONFIG_PTP_1588_CLOCK_PCH=m
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_IDIO_16=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_VX855=m
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
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
CONFIG_GPIO_CS5535=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCH=m
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=m
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
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
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
# CONFIG_BATTERY_BQ27XXX_I2C is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=m
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
# CONFIG_SBC7240_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=m
CONFIG_MFD_CS5535=m
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=m
# CONFIG_MFD_INTEL_PMC_BXT is not set
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
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
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
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8893 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX77826 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6190 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_IR_ENE is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_XBOX_DVD is not set
CONFIG_CEC_CORE=m

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_AGP_ATI=y
# CONFIG_AGP_AMD is not set
CONFIG_AGP_INTEL=y
CONFIG_AGP_NVIDIA=y
CONFIG_AGP_SIS=y
CONFIG_AGP_SWORKS=y
CONFIG_AGP_VIA=y
CONFIG_AGP_EFFICEON=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_I810=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

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
CONFIG_FB_UVESA=m
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
CONFIG_FB_I810_I2C=y
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
# CONFIG_FB_INTEL is not set
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
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

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
CONFIG_HID_LED=m
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
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=m
CONFIG_USB_LED_TRIG=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
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
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
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
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

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
CONFIG_USB_EZUSB_FX2=m
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
CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
# CONFIG_TYPEC_TCPCI is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=m
# CONFIG_UCSI_STM32G0 is not set
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_ANX7411 is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=m
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=256
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=m
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_OT200 is not set
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
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_GHES is not set
# CONFIG_EDAC_AMD76X is not set
CONFIG_EDAC_E7XXX=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82875P=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I82860=m
CONFIG_EDAC_R82600=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
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
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
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
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_PCH_DMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
CONFIG_UIO_NETX=m
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=m
CONFIG_UIO_HV_GENERIC=m
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VBOXGUEST=m
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=m
CONFIG_VIRTIO_PCI_LIB=m
CONFIG_VIRTIO_PCI_LIB_LEGACY=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
CONFIG_SURFACE_PRO3_BUTTON=m
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
CONFIG_ASUS_WIRELESS=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=m
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_IBM_RTL=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
# CONFIG_INTEL_ATOMISP2_LED is not set
CONFIG_INTEL_ATOMISP2_PM=m
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_INT0002_VGPIO=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=m
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=m
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_X86_ANDROID_TABLETS is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
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
# CONFIG_INTEL_IOMMU is not set
CONFIG_IOMMUFD=m
CONFIG_IOMMUFD_TEST=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
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
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

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

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
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
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
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
CONFIG_EXT4_FS=m
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
CONFIG_FAT_DEFAULT_UTF8=y
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=m
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_QNX6FS_FS=m
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
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
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
# CONFIG_EROFS_FS is not set
# CONFIG_VBOXSF_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
CONFIG_NFS_SWAP=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
CONFIG_NFSD_BLOCKLAYOUT=y
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_SUNRPC_SWAP=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
CONFIG_CEPH_FSCACHE=y
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
CONFIG_CIFS_FSCACHE=y
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
CONFIG_CODA_FS=m
CONFIG_AFS_FS=m
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_FSCACHE=y
# CONFIG_AFS_DEBUG_CURSOR is not set
CONFIG_9P_FS=m
CONFIG_9P_FSCACHE=y
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
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
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
# CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE is not set
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
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
CONFIG_CRYPTO_RNG=m
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=m
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_ENGINE=m
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
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
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=m
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=m
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=m
CONFIG_CRYPTO_JITTERENTROPY=m
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_TWOFISH_586=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_GEODE=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
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
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=m
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_PLDMFW=y

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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
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
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x01b6
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
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
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_KMAP_LOCAL is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
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
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
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
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
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
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
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
# CONFIG_MMIOTRACE_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

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
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
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
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
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
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DYNAMIC_DEBUG is not set
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
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

--zGORFlIilFuPTYMD
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='3G'
	export need_cpu=2
	export kernel_cmdline='sysctl.debug.test_sysctl.boot_int=1'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-skl-d07'
	export tbox_group='lkp-skl-d07'
	export submit_id='6417f462b4eadd2e1c1db39a'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-group-02-debian-11.1-i386-20220923.cgz-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8-20230320-11804-97t9v5-1.yaml'
	export id='4ba55bd3cb789636e7c6a5d94668f44c330a8eb4'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=8
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1'
	export brand='Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz'
	export commit='d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export ucode='0xf0'
	export bisect_dmesg=true
	export need_kconfig='{"FUSE_FS"=>"m"}
{"IPV6_MULTIPLE_TABLES"=>"y"}
{"MACSEC"=>"y"}
{"MISC_FILESYSTEMS"=>"y"}
{"MPTCP"=>"y"}
{"MPTCP_IPV6"=>"y"}
NET_FOU
{"NET_FOU_IP_TUNNELS"=>"y"}
{"NET_L3_MASTER_DEV"=>"y"}
NET_SCH_NETEM
{"NET_VRF"=>"y"}
{"NF_FLOW_TABLE"=>"m"}
{"NF_FLOW_TABLE_INET"=>"m"}
{"NF_FLOW_TABLE_IPV4"=>"m"}
{"NF_FLOW_TABLE_IPV6"=>"m"}
{"NF_TABLES_NETDEV"=>"y"}
{"PROC_FS"=>"y"}
{"PSTORE"=>"y"}
{"PSTORE_CONSOLE"=>"y"}
{"PSTORE_PMSG"=>"y"}
{"PSTORE_RAM"=>"m"}
{"SECCOMP"=>"y"}
{"SECCOMP_FILTER"=>"y"}
{"TEST_BLACKHOLE_DEV"=>"m"}
{"UTS_NS"=>"y"}
VETH
{"X86_CPU_RESCTRL"=>"y"}
{"NFC"=>"m"}
{"NFC_NCI"=>"m"}
{"NFC_VIRTUAL_NCI"=>"m"}'
	export initrds='linux_headers
linux_selftests'
	export kconfig='i386-debian-10.3-kselftests'
	export enqueue_time='2023-03-20 13:51:31 +0800'
	export _id='6417f462b4eadd2e1c1db39a'
	export _rt='/result/kernel-selftests/group-02/lkp-skl-d07/debian-11.1-i386-20220923.cgz/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='7a8ce875e97e8d8b4db9901933b6b2b6eeca6a73'
	export base_commit='fe15c26ee26efa11741a7b632e9f23b01aca4cc6'
	export branch='linus/master'
	export result_root='/result/kernel-selftests/group-02/lkp-skl-d07/debian-11.1-i386-20220923.cgz/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/1'
	export scheduler_version='/lkp/lkp/src'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/group-02/lkp-skl-d07/debian-11.1-i386-20220923.cgz/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/1
BOOT_IMAGE=/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/vmlinuz-6.2.0-rc5-00038-gd8e45bf1aed2
branch=linus/master
job=/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-group-02-debian-11.1-i386-20220923.cgz-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8-20230320-11804-97t9v5-1.yaml
user=lkp
ARCH=i386
kconfig=i386-debian-10.3-kselftests
commit=d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8
sysctl.debug.test_sysctl.boot_int=1
initcall_debug
mem=4G
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
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
	export modules_initrd='/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/modules.cgz'
	export linux_headers_initrd='/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/kernel-selftests_20221008.cgz,/osimage/pkg/debian-11.1-i386-20220923.cgz/kernel-selftests-i386-75776cf2-1_20221008.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/hw_20220927.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.3.0-rc1'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='kernel-selftests.mount_setattr.make.fail'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/vmlinuz-6.2.0-rc5-00038-gd8e45bf1aed2'
	export dequeue_time='2023-03-20 14:14:06 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-group-02-debian-11.1-i386-20220923.cgz-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8-20230320-11804-97t9v5-1.cgz'

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

	run_test group='group-02' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='group-02' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--zGORFlIilFuPTYMD
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--zGORFlIilFuPTYMD
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="kernel-selftests"
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-i386-debian-1=
0.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8
2023-03-20 06:15:36 ln -sf /usr/bin/clang
2023-03-20 06:15:36 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2023-03-20 06:15:36 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2023-03-20 06:15:36 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
LKP SKIP media_tests
2023-03-20 06:15:36 make -C membarrier
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/membarr=
ier'
gcc -g -isystem /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf=
1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/../../../usr/incl=
ude     membarrier_test_single_thread.c -lpthread -o /usr/src/perf_selftest=
s-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tool=
s/testing/selftests/membarrier/membarrier_test_single_thread
gcc -g -isystem /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf=
1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/../../../usr/incl=
ude     membarrier_test_multi_thread.c -lpthread -o /usr/src/perf_selftests=
-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools=
/testing/selftests/membarrier/membarrier_test_multi_thread
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/membarri=
er'
2023-03-20 06:15:37 make quicktest=3D1 run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/membarr=
ier'
TAP version 13
1..2
# selftests: membarrier: membarrier_test_single_thread
# TAP version 13
# 1..13
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, er=
rno =3D 22. Failed as expected
# ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1,=
 errno =3D 22. Failed as expected
# ok 4 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failu=
re test: flags =3D 0, errno =3D 1
# ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not regist=
ered failure test: flags =3D 0, errno =3D 1
# ok 6 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
# ok 7 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags=
 =3D 0
# ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
# ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE t=
est: flags =3D 0
# ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: fla=
gs =3D 0
# ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags=
 =3D 0
# ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# # Totals: pass:13 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: membarrier: membarrier_test_single_thread
# selftests: membarrier: membarrier_test_multi_thread
# TAP version 13
# 1..13
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, er=
rno =3D 22. Failed as expected
# ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1,=
 errno =3D 22. Failed as expected
# ok 4 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failu=
re test: flags =3D 0, errno =3D 1
# ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not regist=
ered failure test: flags =3D 0, errno =3D 1
# ok 6 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
# ok 7 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags=
 =3D 0
# ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
# ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE t=
est: flags =3D 0
# ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: fla=
gs =3D 0
# ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags=
 =3D 0
# ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# # Totals: pass:13 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: membarrier: membarrier_test_multi_thread
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/membarri=
er'
2023-03-20 06:15:37 make -C memfd
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=3D64 -isystem /usr/src/perf_selftests-i386-debian-1=
0.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selft=
ests/../../../usr/include     memfd_test.c common.c  -o /usr/src/perf_selft=
ests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/t=
ools/testing/selftests/memfd/memfd_test
gcc -D_FILE_OFFSET_BITS=3D64 -isystem /usr/src/perf_selftests-i386-debian-1=
0.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selft=
ests/../../../usr/include     fuse_test.c common.c  -o /usr/src/perf_selfte=
sts-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/to=
ols/testing/selftests/memfd/fuse_test
gcc -D_FILE_OFFSET_BITS=3D64 -isystem /usr/src/perf_selftests-i386-debian-1=
0.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selft=
ests/../../../usr/include     fuse_mnt.c -lfuse -pthread -o /usr/src/perf_s=
elftests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97ab=
a8/tools/testing/selftests/memfd/fuse_mnt
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/memfd'
2023-03-20 06:15:38 make quicktest=3D1 run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/memfd'
TAP version 13
1..3
# selftests: memfd: memfd_test
# memfd: CREATE
# memfd: BASIC
# memfd: SEAL-WRITE
# memfd: SEAL-FUTURE-WRITE
# memfd: CREATE
# memfd: BASIC
# memfd: SEAL-WRITE
# memfd: SEAL-FUTURE-WRITE
# memfd: SEAL-SHRINK
# memfd: SEAL-GROW
# memfd: SEAL-RESIZE
# memfd: SHARE-DUP=20
# memfd: SHARE-MMAP=20
# memfd: SHARE-OPEN=20
# memfd: SHARE-FORK=20
# memfd: SHARE-DUP (shared file-table)
# memfd: SHARE-MMAP (shared file-table)
# memfd: SHARE-OPEN (shared file-table)
# memfd: SHARE-FORK (shared file-table)
# memfd: DONE
ok 1 selftests: memfd: memfd_test
# selftests: memfd: run_fuse_test.sh
# opening: ./mnt/memfd
# fuse: DONE
ok 2 selftests: memfd: run_fuse_test.sh
# selftests: memfd: run_hugetlbfs_test.sh
# memfd-hugetlb: CREATE
# memfd-hugetlb: BASIC
# memfd-hugetlb: SEAL-WRITE
# memfd-hugetlb: SEAL-FUTURE-WRITE
# memfd-hugetlb: CREATE
# memfd-hugetlb: BASIC
# memfd-hugetlb: SEAL-WRITE
# memfd-hugetlb: SEAL-FUTURE-WRITE
# memfd-hugetlb: SEAL-SHRINK
# memfd-hugetlb: SEAL-GROW
# memfd-hugetlb: SEAL-RESIZE
# memfd-hugetlb: SHARE-DUP=20
# memfd-hugetlb: SHARE-MMAP=20
# memfd-hugetlb: SHARE-OPEN=20
# memfd-hugetlb: SHARE-FORK=20
# memfd-hugetlb: SHARE-DUP (shared file-table)
# memfd-hugetlb: SHARE-MMAP (shared file-table)
# memfd-hugetlb: SHARE-OPEN (shared file-table)
# memfd-hugetlb: SHARE-FORK (shared file-table)
# memfd: DONE
# opening: ./mnt/memfd
# fuse: DONE
ok 3 selftests: memfd: run_hugetlbfs_test.sh
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/memfd'
2023-03-20 06:15:42 make -C mincore
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mincore=
'
gcc -Wall     mincore_selftest.c  -o /usr/src/perf_selftests-i386-debian-10=
.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selfte=
sts/mincore/mincore_selftest
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mincore'
2023-03-20 06:15:42 make quicktest=3D1 run_tests -C mincore
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mincore=
'
TAP version 13
1..1
# selftests: mincore: mincore_selftest
# TAP version 13
# 1..5
# # Starting 5 tests from 1 test cases.
# #  RUN           global.basic_interface ...
# #            OK  global.basic_interface
# ok 1 global.basic_interface
# #  RUN           global.check_anonymous_locked_pages ...
# #            OK  global.check_anonymous_locked_pages
# ok 2 global.check_anonymous_locked_pages
# #  RUN           global.check_huge_pages ...
# #      SKIP      No huge pages available.
# #            OK  global.check_huge_pages
# ok 3 # SKIP No huge pages available.
# #  RUN           global.check_file_mmap ...
# #      SKIP      fallocate not supported by filesystem.
# #            OK  global.check_file_mmap
# ok 4 # SKIP fallocate not supported by filesystem.
# #  RUN           global.check_tmpfs_mmap ...
# #            OK  global.check_tmpfs_mmap
# ok 5 global.check_tmpfs_mmap
# # PASSED: 5 / 5 tests passed.
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:2 error:0
ok 1 selftests: mincore: mincore_selftest
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mincore'
2023-03-20 06:15:42 make -C mount
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount'
gcc -Wall -O2     unprivileged-remount-test.c  -o /usr/src/perf_selftests-i=
386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/t=
esting/selftests/mount/unprivileged-remount-test
gcc -Wall -O2     nosymfollow-test.c  -o /usr/src/perf_selftests-i386-debia=
n-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/se=
lftests/mount/nosymfollow-test
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount'
2023-03-20 06:15:43 make quicktest=3D1 run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount'
TAP version 13
1..2
# selftests: mount: run_unprivileged_remount.sh
ok 1 selftests: mount: run_unprivileged_remount.sh
# selftests: mount: run_nosymfollow.sh
ok 2 selftests: mount: run_nosymfollow.sh
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount'
2023-03-20 06:15:43 make -C mount_setattr
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_s=
etattr'
gcc -g -isystem /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf=
1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/../../../usr/incl=
ude -Wall -O2 -pthread     mount_setattr_test.c  -o /usr/src/perf_selftests=
-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools=
/testing/selftests/mount_setattr/mount_setattr_test
mount_setattr_test.c:137:16: warning: =E2=80=98struct mount_attr=E2=80=99 d=
eclared inside parameter list will not be visible outside of this definitio=
n or declaration
  137 |         struct mount_attr *attr, size_t size)
      |                ^~~~~~~~~~
mount_setattr_test.c: In function =E2=80=98mount_setattr_thread=E2=80=99:
mount_setattr_test.c:343:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  343 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:344:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  344 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:344:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  344 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:344:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  344 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:345:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  345 |   .attr_clr =3D 0,
      |    ^~~~~~~~
mount_setattr_test.c:345:15: warning: excess elements in struct initializer
  345 |   .attr_clr =3D 0,
      |               ^
mount_setattr_test.c:345:15: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:346:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98propagation=E2=80=99
  346 |   .propagation =3D MS_SHARED,
      |    ^~~~~~~~~~~
mount_setattr_test.c:346:18: warning: excess elements in struct initializer
  346 |   .propagation =3D MS_SHARED,
      |                  ^~~~~~~~~
mount_setattr_test.c:346:18: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:343:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  343 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:343:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_invalid_attributes=
=E2=80=99:
mount_setattr_test.c:441:9: error: variable =E2=80=98invalid_attr=E2=80=99 =
has initializer but incomplete type
  441 |  struct mount_attr invalid_attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:442:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  442 |   .attr_set =3D (1U << 31),
      |    ^~~~~~~~
mount_setattr_test.c:442:15: warning: excess elements in struct initializer
  442 |   .attr_set =3D (1U << 31),
      |               ^
mount_setattr_test.c:442:15: note: (near initialization for =E2=80=98invali=
d_attr=E2=80=99)
mount_setattr_test.c:441:20: error: storage size of =E2=80=98invalid_attr=
=E2=80=99 isn=E2=80=99t known
  441 |  struct mount_attr invalid_attr =3D {
      |                    ^~~~~~~~~~~~
mount_setattr_test.c:441:20: warning: unused variable =E2=80=98invalid_attr=
=E2=80=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_extensibility=E2=
=80=99:
mount_setattr_test.c:475:9: error: variable =E2=80=98invalid_attr=E2=80=99 =
has initializer but incomplete type
  475 |  struct mount_attr invalid_attr =3D {};
      |         ^~~~~~~~~~
mount_setattr_test.c:475:20: error: storage size of =E2=80=98invalid_attr=
=E2=80=99 isn=E2=80=99t known
  475 |  struct mount_attr invalid_attr =3D {};
      |                    ^~~~~~~~~~~~
mount_setattr_test.c:477:21: error: field =E2=80=98attr1=E2=80=99 has incom=
plete type
  477 |   struct mount_attr attr1;
      |                     ^~~~~
mount_setattr_test.c:478:21: error: field =E2=80=98attr2=E2=80=99 has incom=
plete type
  478 |   struct mount_attr attr2;
      |                     ^~~~~
mount_setattr_test.c:479:21: error: field =E2=80=98attr3=E2=80=99 has incom=
plete type
  479 |   struct mount_attr attr3;
      |                     ^~~~~
mount_setattr_test.c:475:20: warning: unused variable =E2=80=98invalid_attr=
=E2=80=99 [-Wunused-variable]
  475 |  struct mount_attr invalid_attr =3D {};
      |                    ^~~~~~~~~~~~
mount_setattr_test.c: In function =E2=80=98mount_setattr_basic=E2=80=99:
mount_setattr_test.c:538:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  538 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:539:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  539 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:539:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  539 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:539:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  539 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:540:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  540 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:61:27: warning: excess elements in struct initializer
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:540:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  540 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:61:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:540:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  540 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:538:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  538 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:538:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_basic_recursive=E2=
=80=99:
mount_setattr_test.c:574:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  574 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:575:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  575 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:575:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  575 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:575:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  575 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:576:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  576 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:61:27: warning: excess elements in struct initializer
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:576:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  576 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:61:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:576:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  576 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:574:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  574 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:574:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_mount_has_writers=
=E2=80=99:
mount_setattr_test.c:668:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  668 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:669:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  669 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:669:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  669 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:669:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  669 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:670:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  670 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:61:27: warning: excess elements in struct initializer
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:670:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  670 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:61:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:670:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  670 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:671:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98propagation=E2=80=99
  671 |   .propagation =3D MS_SHARED,
      |    ^~~~~~~~~~~
mount_setattr_test.c:671:18: warning: excess elements in struct initializer
  671 |   .propagation =3D MS_SHARED,
      |                  ^~~~~~~~~
mount_setattr_test.c:671:18: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:668:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  668 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:668:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_mixed_mount_option=
s=E2=80=99:
mount_setattr_test.c:725:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  725 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:726:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  726 |   .attr_clr =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_=
NOEXEC | MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:726:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  726 |   .attr_clr =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_=
NOEXEC | MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:726:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  726 |   .attr_clr =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_=
NOEXEC | MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:727:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  727 |   .attr_set =3D MOUNT_ATTR_RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:65:29: warning: excess elements in struct initializer
   65 | #define MOUNT_ATTR_RELATIME 0x00000000
      |                             ^~~~~~~~~~
mount_setattr_test.c:727:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RELATIME=E2=80=99
  727 |   .attr_set =3D MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:65:29: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   65 | #define MOUNT_ATTR_RELATIME 0x00000000
      |                             ^~~~~~~~~~
mount_setattr_test.c:727:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RELATIME=E2=80=99
  727 |   .attr_set =3D MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:725:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  725 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:725:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_time_changes=E2=80=
=99:
mount_setattr_test.c:759:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  759 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:760:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  760 |   .attr_set =3D MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
      |    ^~~~~~~~
mount_setattr_test.c:57:31: warning: excess elements in struct initializer
   57 | #define MOUNT_ATTR_NODIRATIME 0x00000080
      |                               ^~~~~~~~~~
mount_setattr_test.c:760:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_NODIRATIME=E2=80=99
  760 |   .attr_set =3D MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
      |               ^~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:57:31: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   57 | #define MOUNT_ATTR_NODIRATIME 0x00000080
      |                               ^~~~~~~~~~
mount_setattr_test.c:760:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_NODIRATIME=E2=80=99
  760 |   .attr_set =3D MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
      |               ^~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:759:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  759 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:759:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_wrong_user_namespa=
ce=E2=80=99:
mount_setattr_test.c:963:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  963 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:964:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  964 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:964:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  964 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:964:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  964 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:963:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  963 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:963:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_wrong_mount_namesp=
ace=E2=80=99:
mount_setattr_test.c:979:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  979 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:980:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  980 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:980:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  980 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:980:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  980 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:979:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  979 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:979:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_invalid_f=
d_negative=E2=80=99:
mount_setattr_test.c:1070:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1070 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1071:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1071 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1071:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1071 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1071:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1071 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1072:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98userns_fd=E2=80=99
 1072 |   .userns_fd =3D -EBADF,
      |    ^~~~~~~~~
mount_setattr_test.c:1072:16: warning: excess elements in struct initialize=
r
 1072 |   .userns_fd =3D -EBADF,
      |                ^
mount_setattr_test.c:1072:16: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:1070:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1070 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1070:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_invalid_f=
d_large=E2=80=99:
mount_setattr_test.c:1088:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1088 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1089:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1089 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1089:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1089 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1089:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1089 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1090:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98userns_fd=E2=80=99
 1090 |   .userns_fd =3D INT64_MAX,
      |    ^~~~~~~~~
mount_setattr_test.c:1090:16: warning: excess elements in struct initialize=
r
 1090 |   .userns_fd =3D INT64_MAX,
      |                ^~~~~~~~~
mount_setattr_test.c:1090:16: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:1088:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1088 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1088:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_invalid_f=
d_closed=E2=80=99:
mount_setattr_test.c:1107:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1107 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1108:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1108 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1108:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1108 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1108:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1108 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1107:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1107 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1107:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_invalid_f=
d_initial_userns=E2=80=99:
mount_setattr_test.c:1130:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1130 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1131:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1131 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1131:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1131 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1131:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1131 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1130:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1130 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1130:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_attached_=
mount_inside_current_mount_namespace=E2=80=99:
mount_setattr_test.c:1239:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1239 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1240:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1240 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1240:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1240 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1240:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1240 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1239:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1239 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1239:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_attached_=
mount_outside_current_mount_namespace=E2=80=99:
mount_setattr_test.c:1269:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1269 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1270:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1270 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1270:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1270 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1270:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1270 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1269:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1269 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1269:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_detached_=
mount_inside_current_mount_namespace=E2=80=99:
mount_setattr_test.c:1299:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1299 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1300:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1300 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1300:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1300 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1300:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1300 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1299:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1299 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1299:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_detached_=
mount_outside_current_mount_namespace=E2=80=99:
mount_setattr_test.c:1329:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1329 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1330:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1330 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1330:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1330 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1330:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1330 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1329:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1329 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1329:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_change_id=
mapping=E2=80=99:
mount_setattr_test.c:1361:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1361 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1362:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1362 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1362:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1362 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1362:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1362 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1361:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1361 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1361:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_idmap_mou=
nt_tree_invalid=E2=80=99:
mount_setattr_test.c:1406:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1406 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1407:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1407 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1407:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1407 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1407:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1407 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1406:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1406 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1406:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_mount_attr_nosymfo=
llow=E2=80=99:
mount_setattr_test.c:1441:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1441 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1442:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1442 |   .attr_set =3D MOUNT_ATTR_NOSYMFOLLOW,
      |    ^~~~~~~~
mount_setattr_test.c:133:32: warning: excess elements in struct initializer
  133 | #define MOUNT_ATTR_NOSYMFOLLOW 0x00200000
      |                                ^~~~~~~~~~
mount_setattr_test.c:1442:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_NOSYMFOLLOW=E2=80=99
 1442 |   .attr_set =3D MOUNT_ATTR_NOSYMFOLLOW,
      |               ^~~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:133:32: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  133 | #define MOUNT_ATTR_NOSYMFOLLOW 0x00200000
      |                                ^~~~~~~~~~
mount_setattr_test.c:1442:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_NOSYMFOLLOW=E2=80=99
 1442 |   .attr_set =3D MOUNT_ATTR_NOSYMFOLLOW,
      |               ^~~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:1441:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1441 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1441:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
make: *** [../lib.mk:145: /usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_s=
etattr/mount_setattr_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_se=
tattr'
2023-03-20 06:15:43 make quicktest=3D1 run_tests -C mount_setattr
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_s=
etattr'
gcc -g -isystem /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf=
1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/../../../usr/incl=
ude -Wall -O2 -pthread     mount_setattr_test.c  -o /usr/src/perf_selftests=
-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools=
/testing/selftests/mount_setattr/mount_setattr_test
mount_setattr_test.c:137:16: warning: =E2=80=98struct mount_attr=E2=80=99 d=
eclared inside parameter list will not be visible outside of this definitio=
n or declaration
  137 |         struct mount_attr *attr, size_t size)
      |                ^~~~~~~~~~
mount_setattr_test.c: In function =E2=80=98mount_setattr_thread=E2=80=99:
mount_setattr_test.c:343:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  343 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:344:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  344 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:344:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  344 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:344:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  344 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:345:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  345 |   .attr_clr =3D 0,
      |    ^~~~~~~~
mount_setattr_test.c:345:15: warning: excess elements in struct initializer
  345 |   .attr_clr =3D 0,
      |               ^
mount_setattr_test.c:345:15: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:346:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98propagation=E2=80=99
  346 |   .propagation =3D MS_SHARED,
      |    ^~~~~~~~~~~
mount_setattr_test.c:346:18: warning: excess elements in struct initializer
  346 |   .propagation =3D MS_SHARED,
      |                  ^~~~~~~~~
mount_setattr_test.c:346:18: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:343:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  343 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:343:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_invalid_attributes=
=E2=80=99:
mount_setattr_test.c:441:9: error: variable =E2=80=98invalid_attr=E2=80=99 =
has initializer but incomplete type
  441 |  struct mount_attr invalid_attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:442:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  442 |   .attr_set =3D (1U << 31),
      |    ^~~~~~~~
mount_setattr_test.c:442:15: warning: excess elements in struct initializer
  442 |   .attr_set =3D (1U << 31),
      |               ^
mount_setattr_test.c:442:15: note: (near initialization for =E2=80=98invali=
d_attr=E2=80=99)
mount_setattr_test.c:441:20: error: storage size of =E2=80=98invalid_attr=
=E2=80=99 isn=E2=80=99t known
  441 |  struct mount_attr invalid_attr =3D {
      |                    ^~~~~~~~~~~~
mount_setattr_test.c:441:20: warning: unused variable =E2=80=98invalid_attr=
=E2=80=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_extensibility=E2=
=80=99:
mount_setattr_test.c:475:9: error: variable =E2=80=98invalid_attr=E2=80=99 =
has initializer but incomplete type
  475 |  struct mount_attr invalid_attr =3D {};
      |         ^~~~~~~~~~
mount_setattr_test.c:475:20: error: storage size of =E2=80=98invalid_attr=
=E2=80=99 isn=E2=80=99t known
  475 |  struct mount_attr invalid_attr =3D {};
      |                    ^~~~~~~~~~~~
mount_setattr_test.c:477:21: error: field =E2=80=98attr1=E2=80=99 has incom=
plete type
  477 |   struct mount_attr attr1;
      |                     ^~~~~
mount_setattr_test.c:478:21: error: field =E2=80=98attr2=E2=80=99 has incom=
plete type
  478 |   struct mount_attr attr2;
      |                     ^~~~~
mount_setattr_test.c:479:21: error: field =E2=80=98attr3=E2=80=99 has incom=
plete type
  479 |   struct mount_attr attr3;
      |                     ^~~~~
mount_setattr_test.c:475:20: warning: unused variable =E2=80=98invalid_attr=
=E2=80=99 [-Wunused-variable]
  475 |  struct mount_attr invalid_attr =3D {};
      |                    ^~~~~~~~~~~~
mount_setattr_test.c: In function =E2=80=98mount_setattr_basic=E2=80=99:
mount_setattr_test.c:538:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  538 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:539:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  539 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:539:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  539 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:539:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  539 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:540:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  540 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:61:27: warning: excess elements in struct initializer
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:540:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  540 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:61:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:540:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  540 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:538:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  538 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:538:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_basic_recursive=E2=
=80=99:
mount_setattr_test.c:574:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  574 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:575:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  575 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:575:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  575 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:575:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  575 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:576:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  576 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:61:27: warning: excess elements in struct initializer
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:576:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  576 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:61:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:576:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  576 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:574:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  574 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:574:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_mount_has_writers=
=E2=80=99:
mount_setattr_test.c:668:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  668 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:669:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  669 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:669:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  669 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:669:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  669 |   .attr_set =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_=
RELATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:670:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  670 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:61:27: warning: excess elements in struct initializer
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:670:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  670 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:61:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   61 | #define MOUNT_ATTR__ATIME 0x00000070
      |                           ^~~~~~~~~~
mount_setattr_test.c:670:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R__ATIME=E2=80=99
  670 |   .attr_clr =3D MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:671:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98propagation=E2=80=99
  671 |   .propagation =3D MS_SHARED,
      |    ^~~~~~~~~~~
mount_setattr_test.c:671:18: warning: excess elements in struct initializer
  671 |   .propagation =3D MS_SHARED,
      |                  ^~~~~~~~~
mount_setattr_test.c:671:18: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:668:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  668 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:668:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_mixed_mount_option=
s=E2=80=99:
mount_setattr_test.c:725:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  725 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:726:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_clr=E2=80=99
  726 |   .attr_clr =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_=
NOEXEC | MOUNT_ATTR__ATIME,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:726:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  726 |   .attr_clr =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_=
NOEXEC | MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:726:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  726 |   .attr_clr =3D MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_=
NOEXEC | MOUNT_ATTR__ATIME,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:727:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  727 |   .attr_set =3D MOUNT_ATTR_RELATIME,
      |    ^~~~~~~~
mount_setattr_test.c:65:29: warning: excess elements in struct initializer
   65 | #define MOUNT_ATTR_RELATIME 0x00000000
      |                             ^~~~~~~~~~
mount_setattr_test.c:727:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RELATIME=E2=80=99
  727 |   .attr_set =3D MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:65:29: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   65 | #define MOUNT_ATTR_RELATIME 0x00000000
      |                             ^~~~~~~~~~
mount_setattr_test.c:727:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RELATIME=E2=80=99
  727 |   .attr_set =3D MOUNT_ATTR_RELATIME,
      |               ^~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:725:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  725 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:725:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_time_changes=E2=80=
=99:
mount_setattr_test.c:759:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  759 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:760:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  760 |   .attr_set =3D MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
      |    ^~~~~~~~
mount_setattr_test.c:57:31: warning: excess elements in struct initializer
   57 | #define MOUNT_ATTR_NODIRATIME 0x00000080
      |                               ^~~~~~~~~~
mount_setattr_test.c:760:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_NODIRATIME=E2=80=99
  760 |   .attr_set =3D MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
      |               ^~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:57:31: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   57 | #define MOUNT_ATTR_NODIRATIME 0x00000080
      |                               ^~~~~~~~~~
mount_setattr_test.c:760:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_NODIRATIME=E2=80=99
  760 |   .attr_set =3D MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
      |               ^~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:759:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  759 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:759:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_wrong_user_namespa=
ce=E2=80=99:
mount_setattr_test.c:963:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  963 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:964:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  964 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:964:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  964 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:964:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  964 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:963:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  963 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:963:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_wrong_mount_namesp=
ace=E2=80=99:
mount_setattr_test.c:979:9: error: variable =E2=80=98attr=E2=80=99 has init=
ializer but incomplete type
  979 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:980:4: error: =E2=80=98struct mount_attr=E2=80=99 has =
no member named =E2=80=98attr_set=E2=80=99
  980 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |    ^~~~~~~~
mount_setattr_test.c:45:27: warning: excess elements in struct initializer
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:980:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  980 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:45:27: note: (near initialization for =E2=80=98attr=E2=
=80=99)
   45 | #define MOUNT_ATTR_RDONLY 0x00000001
      |                           ^~~~~~~~~~
mount_setattr_test.c:980:15: note: in expansion of macro =E2=80=98MOUNT_ATT=
R_RDONLY=E2=80=99
  980 |   .attr_set =3D MOUNT_ATTR_RDONLY,
      |               ^~~~~~~~~~~~~~~~~
mount_setattr_test.c:979:20: error: storage size of =E2=80=98attr=E2=80=99 =
isn=E2=80=99t known
  979 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:979:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_invalid_f=
d_negative=E2=80=99:
mount_setattr_test.c:1070:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1070 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1071:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1071 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1071:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1071 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1071:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1071 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1072:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98userns_fd=E2=80=99
 1072 |   .userns_fd =3D -EBADF,
      |    ^~~~~~~~~
mount_setattr_test.c:1072:16: warning: excess elements in struct initialize=
r
 1072 |   .userns_fd =3D -EBADF,
      |                ^
mount_setattr_test.c:1072:16: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:1070:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1070 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1070:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_invalid_f=
d_large=E2=80=99:
mount_setattr_test.c:1088:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1088 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1089:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1089 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1089:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1089 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1089:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1089 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1090:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98userns_fd=E2=80=99
 1090 |   .userns_fd =3D INT64_MAX,
      |    ^~~~~~~~~
mount_setattr_test.c:1090:16: warning: excess elements in struct initialize=
r
 1090 |   .userns_fd =3D INT64_MAX,
      |                ^~~~~~~~~
mount_setattr_test.c:1090:16: note: (near initialization for =E2=80=98attr=
=E2=80=99)
mount_setattr_test.c:1088:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1088 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1088:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_invalid_f=
d_closed=E2=80=99:
mount_setattr_test.c:1107:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1107 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1108:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1108 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1108:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1108 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1108:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1108 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1107:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1107 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1107:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_invalid_f=
d_initial_userns=E2=80=99:
mount_setattr_test.c:1130:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1130 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1131:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1131 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1131:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1131 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1131:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1131 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1130:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1130 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1130:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_attached_=
mount_inside_current_mount_namespace=E2=80=99:
mount_setattr_test.c:1239:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1239 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1240:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1240 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1240:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1240 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1240:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1240 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1239:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1239 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1239:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_attached_=
mount_outside_current_mount_namespace=E2=80=99:
mount_setattr_test.c:1269:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1269 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1270:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1270 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1270:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1270 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1270:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1270 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1269:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1269 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1269:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_detached_=
mount_inside_current_mount_namespace=E2=80=99:
mount_setattr_test.c:1299:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1299 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1300:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1300 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1300:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1300 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1300:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1300 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1299:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1299 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1299:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_detached_=
mount_outside_current_mount_namespace=E2=80=99:
mount_setattr_test.c:1329:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1329 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1330:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1330 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1330:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1330 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1330:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1330 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1329:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1329 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1329:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_change_id=
mapping=E2=80=99:
mount_setattr_test.c:1361:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1361 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1362:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1362 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1362:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1362 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1362:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1362 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1361:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1361 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1361:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_idmapped_idmap_mou=
nt_tree_invalid=E2=80=99:
mount_setattr_test.c:1406:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1406 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1407:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1407 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |    ^~~~~~~~
mount_setattr_test.c:129:26: warning: excess elements in struct initializer
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1407:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1407 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:129:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  129 | #define MOUNT_ATTR_IDMAP 0x00100000
      |                          ^~~~~~~~~~
mount_setattr_test.c:1407:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_IDMAP=E2=80=99
 1407 |   .attr_set =3D MOUNT_ATTR_IDMAP,
      |               ^~~~~~~~~~~~~~~~
mount_setattr_test.c:1406:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1406 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1406:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
mount_setattr_test.c: In function =E2=80=98mount_setattr_mount_attr_nosymfo=
llow=E2=80=99:
mount_setattr_test.c:1441:9: error: variable =E2=80=98attr=E2=80=99 has ini=
tializer but incomplete type
 1441 |  struct mount_attr attr =3D {
      |         ^~~~~~~~~~
mount_setattr_test.c:1442:4: error: =E2=80=98struct mount_attr=E2=80=99 has=
 no member named =E2=80=98attr_set=E2=80=99
 1442 |   .attr_set =3D MOUNT_ATTR_NOSYMFOLLOW,
      |    ^~~~~~~~
mount_setattr_test.c:133:32: warning: excess elements in struct initializer
  133 | #define MOUNT_ATTR_NOSYMFOLLOW 0x00200000
      |                                ^~~~~~~~~~
mount_setattr_test.c:1442:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_NOSYMFOLLOW=E2=80=99
 1442 |   .attr_set =3D MOUNT_ATTR_NOSYMFOLLOW,
      |               ^~~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:133:32: note: (near initialization for =E2=80=98attr=
=E2=80=99)
  133 | #define MOUNT_ATTR_NOSYMFOLLOW 0x00200000
      |                                ^~~~~~~~~~
mount_setattr_test.c:1442:15: note: in expansion of macro =E2=80=98MOUNT_AT=
TR_NOSYMFOLLOW=E2=80=99
 1442 |   .attr_set =3D MOUNT_ATTR_NOSYMFOLLOW,
      |               ^~~~~~~~~~~~~~~~~~~~~~
mount_setattr_test.c:1441:20: error: storage size of =E2=80=98attr=E2=80=99=
 isn=E2=80=99t known
 1441 |  struct mount_attr attr =3D {
      |                    ^~~~
mount_setattr_test.c:1441:20: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
make: *** [../lib.mk:145: /usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_s=
etattr/mount_setattr_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mount_se=
tattr'
2023-03-20 06:15:44 make -C move_mount_set_group
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/move_mo=
unt_set_group'
gcc -g -isystem /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf=
1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/../../../usr/incl=
ude -Wall -O2     move_mount_set_group_test.c  -o /usr/src/perf_selftests-i=
386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/t=
esting/selftests/move_mount_set_group/move_mount_set_group_test
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/move_mou=
nt_set_group'
2023-03-20 06:15:44 make quicktest=3D1 run_tests -C move_mount_set_group
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/move_mo=
unt_set_group'
TAP version 13
1..0
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/move_mou=
nt_set_group'
2023-03-20 06:15:44 make -C mqueue
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mqueue'
gcc -O2     mq_open_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftest=
s-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tool=
s/testing/selftests/mqueue/mq_open_tests
gcc -O2     mq_perf_tests.c -lrt -lpthread -lpopt -o /usr/src/perf_selftest=
s-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tool=
s/testing/selftests/mqueue/mq_perf_tests
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mqueue'
2023-03-20 06:15:45 make quicktest=3D1 run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mqueue'
TAP version 13
1..2
# selftests: mqueue: mq_open_tests
# Using Default queue path - /test1
#=20
# Initial system state:
# 	Using queue path:		/test1
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
#=20
# Test series 1, behavior when no attr struct passed to mq_open:
# Kernel supports setting defaults separately from maximums:		PASS
# Given sane values, mq_open without an attr struct succeeds:		PASS
# Kernel properly honors default setting knobs:				PASS
# Kernel properly limits default values to lesser of default/max:		PASS
# Kernel properly fails to create queue when defaults would
# exceed rlimit:								PASS
#=20
#=20
# Test series 2, behavior when attr struct is passed to mq_open:
# Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
# Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
# Queue open with total size > 2GB when euid =3D 0 failed:			PASS
# Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
# Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
# Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1 selftests: mqueue: mq_open_tests
# selftests: mqueue: mq_perf_tests
#=20
# Initial system state:
# 	Using queue path:			/mq_perf_tests
# 	RLIMIT_MSGQUEUE(soft):			819200
# 	RLIMIT_MSGQUEUE(hard):			819200
# 	Maximum Message Size:			8192
# 	Maximum Queue Size:			10
# 	Nice value:				0
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):			(unlimited)
# 	RLIMIT_MSGQUEUE(hard):			(unlimited)
# 	Maximum Message Size:			16777216
# 	Maximum Queue Size:			65530
# 	Nice value:				-20
# 	Continuous mode:			(disabled)
# 	CPUs to pin:				7
#=20
# 	Queue /mq_perf_tests created:
# 		mq_flags:			O_NONBLOCK
# 		mq_maxmsg:			65530
# 		mq_msgsize:			16
# 		mq_curmsgs:			0
#=20
# 	Started mqueue performance test thread on CPU 7
# 		Max priorities:			32768
# 		Clock resolution:		1 nsec
#=20
# 	Test #1: Time send/recv message, queue empty
# 		(10000000 iterations)
# 		Send msg:			98.33986144s total time
# 						9803 nsec/msg
# 		Recv msg:			128.60428224s total time
# 						12806 nsec/msg
#=20
# 	Test #2a: Time send/recv message, queue full, constant prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.408293509s
# 		Testing...done.
# 		Send msg:			0.876917816s total time
# 						8769 nsec/msg
# 		Recv msg:			0.814417623s total time
# 						8144 nsec/msg
# 		Draining queue...done.		0.365681290s
#=20
# 	Test #2b: Time send/recv message, queue full, increasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.478476773s
# 		Testing...done.
# 		Send msg:			0.885790717s total time
# 						8857 nsec/msg
# 		Recv msg:			1.41692730s total time
# 						10416 nsec/msg
# 		Draining queue...done.		0.392777470s
#=20
# 	Test #2c: Time send/recv message, queue full, decreasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.479546970s
# 		Testing...done.
# 		Send msg:			0.891166453s total time
# 						8911 nsec/msg
# 		Recv msg:			0.969171924s total time
# 						9691 nsec/msg
# 		Draining queue...done.		0.394244971s
#=20
# 	Test #2d: Time send/recv message, queue full, random prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.479574264s
# 		Testing...done.
# 		Send msg:			0.901740692s total time
# 						9017 nsec/msg
# 		Recv msg:			1.8982536s total time
# 						10089 nsec/msg
# 		Draining queue...done.		0.419402310s
ok 2 selftests: mqueue: mq_perf_tests
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/mqueue'
2023-03-20 06:20:13 make -C nci
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nci'
gcc -Wl,-no-as-needed -Wall   -lpthread   nci_dev.c  -o /usr/src/perf_selft=
ests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/t=
ools/testing/selftests/nci/nci_dev
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nci'
2023-03-20 06:20:13 make quicktest=3D1 run_tests -C nci
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nci'
TAP version 13
1..1
# selftests: nci: nci_dev
# TAP version 13
# 1..8
# # Starting 8 tests from 2 test cases.
# #  RUN           NCI.NCI1_0.init ...
# # nci_dev.c:422:init:Expected self->virtual_nci_fd (-1) > -1 (-1)
# # init: Test terminated by assertion
# #          FAIL  NCI.NCI1_0.init
# not ok 1 NCI.NCI1_0.init
# #  RUN           NCI.NCI1_0.start_poll ...
# # nci_dev.c:422:start_poll:Expected self->virtual_nci_fd (-1) > -1 (-1)
# # start_poll: Test terminated by assertion
# #          FAIL  NCI.NCI1_0.start_poll
# not ok 2 NCI.NCI1_0.start_poll
# #  RUN           NCI.NCI1_0.t4t_tag_read ...
# # nci_dev.c:422:t4t_tag_read:Expected self->virtual_nci_fd (-1) > -1 (-1)
# # t4t_tag_read: Test terminated by assertion
# #          FAIL  NCI.NCI1_0.t4t_tag_read
# not ok 3 NCI.NCI1_0.t4t_tag_read
# #  RUN           NCI.NCI1_0.deinit ...
# # nci_dev.c:422:deinit:Expected self->virtual_nci_fd (-1) > -1 (-1)
# # deinit: Test terminated by assertion
# #          FAIL  NCI.NCI1_0.deinit
# not ok 4 NCI.NCI1_0.deinit
# #  RUN           NCI.NCI2_0.init ...
# # nci_dev.c:422:init:Expected self->virtual_nci_fd (-1) > -1 (-1)
# # init: Test terminated by assertion
# #          FAIL  NCI.NCI2_0.init
# not ok 5 NCI.NCI2_0.init
# #  RUN           NCI.NCI2_0.start_poll ...
# # nci_dev.c:422:start_poll:Expected self->virtual_nci_fd (-1) > -1 (-1)
# # start_poll: Test terminated by assertion
# #          FAIL  NCI.NCI2_0.start_poll
# not ok 6 NCI.NCI2_0.start_poll
# #  RUN           NCI.NCI2_0.t4t_tag_read ...
# # nci_dev.c:422:t4t_tag_read:Expected self->virtual_nci_fd (-1) > -1 (-1)
# # t4t_tag_read: Test terminated by assertion
# #          FAIL  NCI.NCI2_0.t4t_tag_read
# not ok 7 NCI.NCI2_0.t4t_tag_read
# #  RUN           NCI.NCI2_0.deinit ...
# # nci_dev.c:422:deinit:Expected self->virtual_nci_fd (-1) > -1 (-1)
# # deinit: Test terminated by assertion
# #          FAIL  NCI.NCI2_0.deinit
# not ok 8 NCI.NCI2_0.deinit
# # FAILED: 0 / 8 tests passed.
# # Totals: pass:0 fail:8 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: nci: nci_dev # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nci'
nolibc test: not in Makefile
2023-03-20 06:20:13 make TARGETS=3Dnolibc
make[1]: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kself=
tests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/noli=
bc'
Supported targets under selftests/nolibc:
  all          call the "run" target below
  help         this help
  sysroot      create the nolibc sysroot here (uses $ARCH)
  nolibc-test  build the executable (uses $CC and $CROSS_COMPILE)
  initramfs    prepare the initramfs with nolibc-test
  defconfig    create a fresh new default config (uses $ARCH)
  kernel       (re)build the kernel with the initramfs (uses $ARCH)
  run          runs the kernel in QEMU after building it (uses $ARCH, $TEST=
)
  rerun        runs a previously prebuilt kernel in QEMU (uses $ARCH, $TEST=
)
  clean        clean the sysroot, initramfs, build and output files

The output file is "run.out". Test ranges may be passed using $TEST.

Currently using the following variables:
  ARCH          =3D x86
  CROSS_COMPILE =3D=20
  CC            =3D gcc
  OUTPUT        =3D /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e=
45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nolibc
  TEST          =3D=20
  QEMU_ARCH     =3D x86_64 [determined from $ARCH]
  IMAGE_NAME    =3D bzImage [determined from $ARCH]

make[1]: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselft=
ests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nolib=
c'
2023-03-20 06:20:13 make -C nolibc
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nolibc'
Supported targets under selftests/nolibc:
  all          call the "run" target below
  help         this help
  sysroot      create the nolibc sysroot here (uses $ARCH)
  nolibc-test  build the executable (uses $CC and $CROSS_COMPILE)
  initramfs    prepare the initramfs with nolibc-test
  defconfig    create a fresh new default config (uses $ARCH)
  kernel       (re)build the kernel with the initramfs (uses $ARCH)
  run          runs the kernel in QEMU after building it (uses $ARCH, $TEST=
)
  rerun        runs a previously prebuilt kernel in QEMU (uses $ARCH, $TEST=
)
  clean        clean the sysroot, initramfs, build and output files

The output file is "run.out". Test ranges may be passed using $TEST.

Currently using the following variables:
  ARCH          =3D x86
  CROSS_COMPILE =3D=20
  CC            =3D gcc
  OUTPUT        =3D /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e=
45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nolibc/
  TEST          =3D=20
  QEMU_ARCH     =3D x86_64 [determined from $ARCH]
  IMAGE_NAME    =3D bzImage [determined from $ARCH]

make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nolibc'
2023-03-20 06:20:14 make quicktest=3D1 run_tests -C nolibc
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nolibc'
make: *** No rule to make target 'run_tests'.  Stop.
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nolibc'
2023-03-20 06:20:14 make -C nsfs
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nsfs'
gcc -Wall -Werror    owner.c  -o /usr/src/perf_selftests-i386-debian-10.3-k=
selftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/=
nsfs/owner
gcc -Wall -Werror    pidns.c  -o /usr/src/perf_selftests-i386-debian-10.3-k=
selftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/=
nsfs/pidns
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nsfs'
2023-03-20 06:20:14 make quicktest=3D1 run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nsfs'
TAP version 13
1..2
# selftests: nsfs: owner
ok 1 selftests: nsfs: owner
# selftests: nsfs: pidns
ok 2 selftests: nsfs: pidns
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/nsfs'
Discarding device blocks:   1024/102400=08=08=08=08=08=08=08=08=08=08=08=08=
=08             =08=08=08=08=08=08=08=08=08=08=08=08=08done                =
           =20
Creating filesystem with 102400 1k blocks and 25688 inodes
Filesystem UUID: 96818a72-37d6-49d3-91fb-91b39730b6a7
Superblock backups stored on blocks:=20
	8193, 24577, 40961, 57345, 73729

Allocating group tables:  0/13=08=08=08=08=08     =08=08=08=08=08done      =
                     =20
Writing inode tables:  0/13=08=08=08=08=08     =08=08=08=08=08done         =
                  =20
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information:  0/13=08=08=08=
=08=08     =08=08=08=08=08done

2023-03-20 06:20:16 make -C openat2
make: Entering directory '/mnt/selftests/openat2'
gcc -Wall -O2 -g -fsanitize=3Daddress -fsanitize=3Dundefined     openat2_te=
st.c helpers.c helpers.h  -o /mnt/selftests/openat2/openat2_test
gcc -Wall -O2 -g -fsanitize=3Daddress -fsanitize=3Dundefined     resolve_te=
st.c helpers.c helpers.h  -o /mnt/selftests/openat2/resolve_test
gcc -Wall -O2 -g -fsanitize=3Daddress -fsanitize=3Dundefined     rename_att=
ack_test.c helpers.c helpers.h  -o /mnt/selftests/openat2/rename_attack_tes=
t
make: Leaving directory '/mnt/selftests/openat2'
2023-03-20 06:20:22 make quicktest=3D1 run_tests -C openat2
make: Entering directory '/mnt/selftests/openat2'
TAP version 13
1..3
# selftests: openat2: openat2_test
# TAP version 13
# 1..116
# ok 1 openat2 with normal struct argument [misalign=3D0] succeeds
# ok 2 openat2 with normal struct argument [misalign=3D1] succeeds
# ok 3 openat2 with normal struct argument [misalign=3D2] succeeds
# ok 4 openat2 with normal struct argument [misalign=3D3] succeeds
# ok 5 openat2 with normal struct argument [misalign=3D4] succeeds
# ok 6 openat2 with normal struct argument [misalign=3D5] succeeds
# ok 7 openat2 with normal struct argument [misalign=3D6] succeeds
# ok 8 openat2 with normal struct argument [misalign=3D7] succeeds
# ok 9 openat2 with normal struct argument [misalign=3D8] succeeds
# ok 10 openat2 with normal struct argument [misalign=3D9] succeeds
# ok 11 openat2 with normal struct argument [misalign=3D11] succeeds
# ok 12 openat2 with normal struct argument [misalign=3D17] succeeds
# ok 13 openat2 with normal struct argument [misalign=3D87] succeeds
# ok 14 openat2 with bigger struct (zeroed out) argument [misalign=3D0] suc=
ceeds
# ok 15 openat2 with bigger struct (zeroed out) argument [misalign=3D1] suc=
ceeds
# ok 16 openat2 with bigger struct (zeroed out) argument [misalign=3D2] suc=
ceeds
# ok 17 openat2 with bigger struct (zeroed out) argument [misalign=3D3] suc=
ceeds
# ok 18 openat2 with bigger struct (zeroed out) argument [misalign=3D4] suc=
ceeds
# ok 19 openat2 with bigger struct (zeroed out) argument [misalign=3D5] suc=
ceeds
# ok 20 openat2 with bigger struct (zeroed out) argument [misalign=3D6] suc=
ceeds
# ok 21 openat2 with bigger struct (zeroed out) argument [misalign=3D7] suc=
ceeds
# ok 22 openat2 with bigger struct (zeroed out) argument [misalign=3D8] suc=
ceeds
# ok 23 openat2 with bigger struct (zeroed out) argument [misalign=3D9] suc=
ceeds
# ok 24 openat2 with bigger struct (zeroed out) argument [misalign=3D11] su=
cceeds
# ok 25 openat2 with bigger struct (zeroed out) argument [misalign=3D17] su=
cceeds
# ok 26 openat2 with bigger struct (zeroed out) argument [misalign=3D87] su=
cceeds
# ok 27 openat2 with zero-sized 'struct' argument [misalign=3D0] fails with=
 -22 (Invalid argument)
# ok 28 openat2 with zero-sized 'struct' argument [misalign=3D1] fails with=
 -22 (Invalid argument)
# ok 29 openat2 with zero-sized 'struct' argument [misalign=3D2] fails with=
 -22 (Invalid argument)
# ok 30 openat2 with zero-sized 'struct' argument [misalign=3D3] fails with=
 -22 (Invalid argument)
# ok 31 openat2 with zero-sized 'struct' argument [misalign=3D4] fails with=
 -22 (Invalid argument)
# ok 32 openat2 with zero-sized 'struct' argument [misalign=3D5] fails with=
 -22 (Invalid argument)
# ok 33 openat2 with zero-sized 'struct' argument [misalign=3D6] fails with=
 -22 (Invalid argument)
# ok 34 openat2 with zero-sized 'struct' argument [misalign=3D7] fails with=
 -22 (Invalid argument)
# ok 35 openat2 with zero-sized 'struct' argument [misalign=3D8] fails with=
 -22 (Invalid argument)
# ok 36 openat2 with zero-sized 'struct' argument [misalign=3D9] fails with=
 -22 (Invalid argument)
# ok 37 openat2 with zero-sized 'struct' argument [misalign=3D11] fails wit=
h -22 (Invalid argument)
# ok 38 openat2 with zero-sized 'struct' argument [misalign=3D17] fails wit=
h -22 (Invalid argument)
# ok 39 openat2 with zero-sized 'struct' argument [misalign=3D87] fails wit=
h -22 (Invalid argument)
# ok 40 openat2 with smaller-than-v0 struct argument [misalign=3D0] fails w=
ith -22 (Invalid argument)
# ok 41 openat2 with smaller-than-v0 struct argument [misalign=3D1] fails w=
ith -22 (Invalid argument)
# ok 42 openat2 with smaller-than-v0 struct argument [misalign=3D2] fails w=
ith -22 (Invalid argument)
# ok 43 openat2 with smaller-than-v0 struct argument [misalign=3D3] fails w=
ith -22 (Invalid argument)
# ok 44 openat2 with smaller-than-v0 struct argument [misalign=3D4] fails w=
ith -22 (Invalid argument)
# ok 45 openat2 with smaller-than-v0 struct argument [misalign=3D5] fails w=
ith -22 (Invalid argument)
# ok 46 openat2 with smaller-than-v0 struct argument [misalign=3D6] fails w=
ith -22 (Invalid argument)
# ok 47 openat2 with smaller-than-v0 struct argument [misalign=3D7] fails w=
ith -22 (Invalid argument)
# ok 48 openat2 with smaller-than-v0 struct argument [misalign=3D8] fails w=
ith -22 (Invalid argument)
# ok 49 openat2 with smaller-than-v0 struct argument [misalign=3D9] fails w=
ith -22 (Invalid argument)
# ok 50 openat2 with smaller-than-v0 struct argument [misalign=3D11] fails =
with -22 (Invalid argument)
# ok 51 openat2 with smaller-than-v0 struct argument [misalign=3D17] fails =
with -22 (Invalid argument)
# ok 52 openat2 with smaller-than-v0 struct argument [misalign=3D87] fails =
with -22 (Invalid argument)
# ok 53 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D0] fails with -7 (Argument list too long)
# ok 54 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D1] fails with -7 (Argument list too long)
# ok 55 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D2] fails with -7 (Argument list too long)
# ok 56 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D3] fails with -7 (Argument list too long)
# ok 57 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D4] fails with -7 (Argument list too long)
# ok 58 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D5] fails with -7 (Argument list too long)
# ok 59 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D6] fails with -7 (Argument list too long)
# ok 60 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D7] fails with -7 (Argument list too long)
# ok 61 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D8] fails with -7 (Argument list too long)
# ok 62 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D9] fails with -7 (Argument list too long)
# ok 63 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D11] fails with -7 (Argument list too long)
# ok 64 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D17] fails with -7 (Argument list too long)
# ok 65 openat2 with bigger struct (non-zero data in first 'future field') =
argument [misalign=3D87] fails with -7 (Argument list too long)
# ok 66 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D0] fails with -7 (Argument list too long)
# ok 67 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D1] fails with -7 (Argument list too long)
# ok 68 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D2] fails with -7 (Argument list too long)
# ok 69 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D3] fails with -7 (Argument list too long)
# ok 70 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D4] fails with -7 (Argument list too long)
# ok 71 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D5] fails with -7 (Argument list too long)
# ok 72 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D6] fails with -7 (Argument list too long)
# ok 73 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D7] fails with -7 (Argument list too long)
# ok 74 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D8] fails with -7 (Argument list too long)
# ok 75 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D9] fails with -7 (Argument list too long)
# ok 76 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D11] fails with -7 (Argument list too long)
# ok 77 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D17] fails with -7 (Argument list too long)
# ok 78 openat2 with bigger struct (non-zero data in middle of 'future fiel=
ds') argument [misalign=3D87] fails with -7 (Argument list too long)
# ok 79 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D0] fails with -7 (Argument list too long)
# ok 80 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D1] fails with -7 (Argument list too long)
# ok 81 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D2] fails with -7 (Argument list too long)
# ok 82 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D3] fails with -7 (Argument list too long)
# ok 83 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D4] fails with -7 (Argument list too long)
# ok 84 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D5] fails with -7 (Argument list too long)
# ok 85 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D6] fails with -7 (Argument list too long)
# ok 86 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D7] fails with -7 (Argument list too long)
# ok 87 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D8] fails with -7 (Argument list too long)
# ok 88 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D9] fails with -7 (Argument list too long)
# ok 89 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D11] fails with -7 (Argument list too long)
# ok 90 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D17] fails with -7 (Argument list too long)
# ok 91 openat2 with bigger struct (non-zero data at end of 'future fields'=
) argument [misalign=3D87] fails with -7 (Argument list too long)
# ok 92 openat2 with incompatible flags (O_TMPFILE | O_PATH) fails with -22=
 (Invalid argument)
# ok 93 openat2 with incompatible flags (O_TMPFILE | O_CREAT) fails with -2=
2 (Invalid argument)
# ok 94 openat2 with compatible flags (O_PATH | O_CLOEXEC) succeeds
# ok 95 openat2 with compatible flags (O_PATH | O_DIRECTORY) succeeds
# ok 96 openat2 with compatible flags (O_PATH | O_NOFOLLOW) succeeds
# ok 97 openat2 with incompatible flags (O_PATH | O_RDWR) fails with -22 (I=
nvalid argument)
# ok 98 openat2 with incompatible flags (O_PATH | O_CREAT) fails with -22 (=
Invalid argument)
# ok 99 openat2 with incompatible flags (O_PATH | O_EXCL) fails with -22 (I=
nvalid argument)
# ok 100 openat2 with incompatible flags (O_PATH | O_NOCTTY) fails with -22=
 (Invalid argument)
# ok 101 openat2 with incompatible flags (O_PATH | O_DIRECT) fails with -22=
 (Invalid argument)
# ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fails with =
-22 (Invalid argument)
# ok 103 openat2 with non-zero how.mode and O_RDONLY fails with -22 (Invali=
d argument)
# ok 104 openat2 with non-zero how.mode and O_PATH fails with -22 (Invalid =
argument)
# ok 105 openat2 with valid how.mode and O_CREAT succeeds
# ok 106 openat2 with valid how.mode and O_TMPFILE succeeds
# ok 107 openat2 with invalid how.mode and O_CREAT fails with -22 (Invalid =
argument)
# ok 108 openat2 with invalid (very large) how.mode and O_CREAT fails with =
-22 (Invalid argument)
# ok 109 openat2 with invalid how.mode and O_TMPFILE fails with -22 (Invali=
d argument)
# ok 110 openat2 with invalid (very large) how.mode and O_TMPFILE fails wit=
h -22 (Invalid argument)
# ok 111 openat2 with incompatible resolve flags (BENEATH | IN_ROOT) fails =
with -22 (Invalid argument)
# ok 112 openat2 with invalid how.resolve and O_RDONLY fails with -22 (Inva=
lid argument)
# ok 113 openat2 with invalid how.resolve and O_CREAT fails with -22 (Inval=
id argument)
# ok 114 openat2 with invalid how.resolve and O_TMPFILE fails with -22 (Inv=
alid argument)
# ok 115 openat2 with invalid how.resolve and O_PATH fails with -22 (Invali=
d argument)
# ok 116 openat2 with currently unknown bit (1 << 63) fails with -22 (Inval=
id argument)
# # Totals: pass:116 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: openat2: openat2_test
# selftests: openat2: resolve_test
# TAP version 13
# 1..88
# ok 1 [beneath] jump to / fails with -18 (Invalid cross-device link)
# ok 2 [beneath] absolute link to $root fails with -18 (Invalid cross-devic=
e link)
# ok 3 [beneath] chained absolute links to $root fails with -18 (Invalid cr=
oss-device link)
# ok 4 [beneath] jump outside $root fails with -18 (Invalid cross-device li=
nk)
# ok 5 [beneath] temporary jump outside $root fails with -18 (Invalid cross=
-device link)
# ok 6 [beneath] symlink temporary jump outside $root fails with -18 (Inval=
id cross-device link)
# ok 7 [beneath] chained symlink temporary jump outside $root fails with -1=
8 (Invalid cross-device link)
# ok 8 [beneath] garbage links to $root fails with -18 (Invalid cross-devic=
e link)
# ok 9 [beneath] chained garbage links to $root fails with -18 (Invalid cro=
ss-device link)
# ok 10 [beneath] ordinary path to 'root' gives path 'root'
# ok 11 [beneath] ordinary path to 'etc' gives path 'etc'
# ok 12 [beneath] ordinary path to 'etc/passwd' gives path 'etc/passwd'
# ok 13 [beneath] relative symlink inside $root gives path 'etc/passwd'
# ok 14 [beneath] chained-'..' relative symlink inside $root gives path 'et=
c/passwd'
# ok 15 [beneath] absolute symlink component outside $root fails with -18 (=
Invalid cross-device link)
# ok 16 [beneath] absolute symlink target outside $root fails with -18 (Inv=
alid cross-device link)
# ok 17 [beneath] absolute path outside $root fails with -18 (Invalid cross=
-device link)
# ok 18 [beneath] cheeky absolute path outside $root fails with -18 (Invali=
d cross-device link)
# ok 19 [beneath] chained cheeky absolute path outside $root fails with -18=
 (Invalid cross-device link)
# ok 20 [beneath] tricky '..'-chained symlink outside $root fails with -18 =
(Invalid cross-device link)
# ok 21 [beneath] tricky absolute + '..'-chained symlink outside $root fail=
s with -18 (Invalid cross-device link)
# ok 22 [beneath] tricky garbage link outside $root fails with -18 (Invalid=
 cross-device link)
# ok 23 [beneath] tricky absolute + garbage link outside $root fails with -=
18 (Invalid cross-device link)
# ok 24 [in_root] jump to / gives path '.'
# ok 25 [in_root] absolute symlink to /root gives path '.'
# ok 26 [in_root] chained absolute symlinks to /root gives path '.'
# ok 27 [in_root] '..' at root gives path '.'
# ok 28 [in_root] '../root' at root gives path 'root'
# ok 29 [in_root] relative symlink containing '..' above root gives path 'r=
oot'
# ok 30 [in_root] garbage link to /root gives path 'root'
# ok 31 [in_root] chained garbage links to /root gives path 'root'
# ok 32 [in_root] relative path to 'root' gives path 'root'
# ok 33 [in_root] relative path to 'etc' gives path 'etc'
# ok 34 [in_root] relative path to 'etc/passwd' gives path 'etc/passwd'
# ok 35 [in_root] relative symlink to 'etc/passwd' gives path 'etc/passwd'
# ok 36 [in_root] chained-'..' relative symlink to 'etc/passwd' gives path =
'etc/passwd'
# ok 37 [in_root] chained-'..' absolute + relative symlink to 'etc/passwd' =
gives path 'etc/passwd'
# ok 38 [in_root] absolute symlink to 'etc/passwd' gives path 'etc/passwd'
# ok 39 [in_root] absolute path 'etc/passwd' gives path 'etc/passwd'
# ok 40 [in_root] cheeky absolute path 'etc/passwd' gives path 'etc/passwd'
# ok 41 [in_root] chained cheeky absolute path 'etc/passwd' gives path 'etc=
/passwd'
# ok 42 [in_root] tricky '..'-chained symlink outside $root gives path 'etc=
/passwd'
# ok 43 [in_root] tricky absolute + '..'-chained symlink outside $root give=
s path 'etc/passwd'
# ok 44 [in_root] tricky absolute path + absolute + '..'-chained symlink ou=
tside $root gives path 'etc/passwd'
# ok 45 [in_root] tricky garbage link outside $root gives path 'etc/passwd'
# ok 46 [in_root] tricky absolute + garbage link outside $root gives path '=
etc/passwd'
# ok 47 [in_root] tricky absolute path + absolute + garbage link outside $r=
oot gives path 'etc/passwd'
# ok 48 [in_root] O_CREAT of relative path inside $root gives path 'newfile=
1'
# ok 49 [in_root] O_CREAT of absolute path gives path 'newfile2'
# ok 50 [in_root] O_CREAT of tricky symlink outside root gives path 'newfil=
e3'
# ok 51 [no_xdev] cross into $mnt fails with -18 (Invalid cross-device link=
)
# ok 52 [no_xdev] cross into $mnt/ fails with -18 (Invalid cross-device lin=
k)
# ok 53 [no_xdev] cross into $mnt/. fails with -18 (Invalid cross-device li=
nk)
# ok 54 [no_xdev] goto mountpoint root gives path 'mnt'
# ok 55 [no_xdev] cross up through '..' fails with -18 (Invalid cross-devic=
e link)
# ok 56 [no_xdev] temporary cross up through '..' fails with -18 (Invalid c=
ross-device link)
# ok 57 [no_xdev] temporary relative symlink cross up fails with -18 (Inval=
id cross-device link)
# ok 58 [no_xdev] temporary absolute symlink cross up fails with -18 (Inval=
id cross-device link)
# ok 59 [no_xdev] jump to / directly gives path '/'
# ok 60 [no_xdev] jump to / (from /) directly gives path '/'
# ok 61 [no_xdev] jump to / then proc fails with -18 (Invalid cross-device =
link)
# ok 62 [no_xdev] jump to / then tmp fails with -18 (Invalid cross-device l=
ink)
# ok 63 [no_xdev] cross through magic-link to self/root fails with -18 (Inv=
alid cross-device link)
# ok 64 [no_xdev] cross through magic-link to self/cwd fails with -18 (Inva=
lid cross-device link)
# ok 65 [no_xdev] jump through magic-link to same procfs gives path '/proc'
# ok 66 [no_magiclinks] ordinary relative symlink gives path 'etc/passwd'
# ok 67 [no_magiclinks] symlink to magic-link fails with -40 (Too many leve=
ls of symbolic links)
# ok 68 [no_magiclinks] normal path to magic-link fails with -40 (Too many =
levels of symbolic links)
# ok 69 [no_magiclinks] normal path to magic-link with O_NOFOLLOW gives pat=
h '/proc/2967/exe'
# ok 70 [no_magiclinks] symlink to magic-link path component fails with -40=
 (Too many levels of symbolic links)
# ok 71 [no_magiclinks] magic-link path component fails with -40 (Too many =
levels of symbolic links)
# ok 72 [no_magiclinks] magic-link path component with O_NOFOLLOW fails wit=
h -40 (Too many levels of symbolic links)
# ok 73 [no_symlinks] ordinary path to '.' gives path '.'
# ok 74 [no_symlinks] ordinary path to 'root' gives path 'root'
# ok 75 [no_symlinks] ordinary path to 'etc' gives path 'etc'
# ok 76 [no_symlinks] ordinary path to 'etc/passwd' gives path 'etc/passwd'
# ok 77 [no_symlinks] relative symlink target fails with -40 (Too many leve=
ls of symbolic links)
# ok 78 [no_symlinks] relative symlink component fails with -40 (Too many l=
evels of symbolic links)
# ok 79 [no_symlinks] absolute symlink target fails with -40 (Too many leve=
ls of symbolic links)
# ok 80 [no_symlinks] absolute symlink component fails with -40 (Too many l=
evels of symbolic links)
# ok 81 [no_symlinks] cheeky garbage link fails with -40 (Too many levels o=
f symbolic links)
# ok 82 [no_symlinks] cheeky absolute + garbage link fails with -40 (Too ma=
ny levels of symbolic links)
# ok 83 [no_symlinks] cheeky absolute + absolute symlink fails with -40 (To=
o many levels of symbolic links)
# ok 84 [no_symlinks] relative symlink with O_NOFOLLOW gives path 'relsym'
# ok 85 [no_symlinks] absolute symlink with O_NOFOLLOW gives path 'abssym'
# ok 86 [no_symlinks] trailing symlink with O_NOFOLLOW gives path 'cheeky/g=
arbagelink'
# ok 87 [no_symlinks] multiple symlink components with O_NOFOLLOW fails wit=
h -40 (Too many levels of symbolic links)
# ok 88 [no_symlinks] multiple symlink (and garbage link) components with O=
_NOFOLLOW fails with -40 (Too many levels of symbolic links)
# # Totals: pass:88 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: openat2: resolve_test
# selftests: openat2: rename_attack_test
# TAP version 13
# 1..2
# # non-escapes: EAGAIN=3D72184 EXDEV=3D327816 E<other>=3D0 success=3D0
# ok 1 rename attack with RESOLVE_BENEATH (400000 runs, got 0 escapes)
# # non-escapes: EAGAIN=3D380211 EXDEV=3D0 E<other>=3D0 success=3D19789
# ok 2 rename attack with RESOLVE_IN_ROOT (400000 runs, got 0 escapes)
# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 3 selftests: openat2: rename_attack_test
make: Leaving directory '/mnt/selftests/openat2'
perf_events test: not in Makefile
2023-03-20 06:20:49 make TARGETS=3Dperf_events
make[1]: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kself=
tests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/perf=
_events'
gcc -Wl,-no-as-needed -Wall -isystem /usr/src/perf_selftests-i386-debian-10=
.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/usr/include   -lpthr=
ead   sigtrap_threads.c  -o /usr/src/perf_selftests-i386-debian-10.3-kselft=
ests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/perf_=
events/sigtrap_threads
gcc -Wl,-no-as-needed -Wall -isystem /usr/src/perf_selftests-i386-debian-10=
.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/usr/include   -lpthr=
ead   remove_on_exec.c  -o /usr/src/perf_selftests-i386-debian-10.3-kselfte=
sts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/perf_e=
vents/remove_on_exec
make[1]: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselft=
ests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/perf_=
events'
2023-03-20 06:20:50 make -C perf_events
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/perf_ev=
ents'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/perf_eve=
nts'
2023-03-20 06:20:50 make quicktest=3D1 run_tests -C perf_events
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/perf_ev=
ents'
TAP version 13
1..2
# selftests: perf_events: sigtrap_threads
# TAP version 13
# 1..5
# # Starting 5 tests from 1 test cases.
# #  RUN           sigtrap_threads.remain_disabled ...
# #            OK  sigtrap_threads.remain_disabled
# ok 1 sigtrap_threads.remain_disabled
# #  RUN           sigtrap_threads.enable_event ...
# #            OK  sigtrap_threads.enable_event
# ok 2 sigtrap_threads.enable_event
# #  RUN           sigtrap_threads.modify_and_enable_event ...
# #            OK  sigtrap_threads.modify_and_enable_event
# ok 3 sigtrap_threads.modify_and_enable_event
# #  RUN           sigtrap_threads.signal_stress ...
# #            OK  sigtrap_threads.signal_stress
# ok 4 sigtrap_threads.signal_stress
# #  RUN           sigtrap_threads.signal_stress_with_disable ...
# #            OK  sigtrap_threads.signal_stress_with_disable
# ok 5 sigtrap_threads.signal_stress_with_disable
# # PASSED: 5 / 5 tests passed.
# # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: perf_events: sigtrap_threads
# selftests: perf_events: remove_on_exec
# TAP version 13
# 1..4
# # Starting 4 tests from 1 test cases.
# #  RUN           remove_on_exec.fork_only ...
# #            OK  remove_on_exec.fork_only
# ok 1 remove_on_exec.fork_only
# #  RUN           remove_on_exec.fork_exec_then_enable ...
# #            OK  remove_on_exec.fork_exec_then_enable
# ok 2 remove_on_exec.fork_exec_then_enable
# #  RUN           remove_on_exec.enable_then_fork_exec ...
# *#            OK  remove_on_exec.enable_then_fork_exec
# ok 3 remove_on_exec.enable_then_fork_exec
# #  RUN           remove_on_exec.exec_stress ...
# ******************************#            OK  remove_on_exec.exec_stress
# ok 4 remove_on_exec.exec_stress
# # PASSED: 4 / 4 tests passed.
# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: perf_events: remove_on_exec
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/perf_eve=
nts'
2023-03-20 06:20:51 make -C pid_namespace
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/pid_nam=
espace'
gcc -g -isystem /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf=
1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/../../../usr/incl=
ude     regression_enomem.c  -o /usr/src/perf_selftests-i386-debian-10.3-ks=
elftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/p=
id_namespace/regression_enomem
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/pid_name=
space'
2023-03-20 06:20:51 make quicktest=3D1 run_tests -C pid_namespace
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/pid_nam=
espace'
TAP version 13
1..1
# selftests: pid_namespace: regression_enomem
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.regression_enomem ...
# #            OK  global.regression_enomem
# ok 1 global.regression_enomem
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: pid_namespace: regression_enomem
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/pid_name=
space'
LKP SKIP powerpc
prctl test: not in Makefile
2023-03-20 06:20:51 make TARGETS=3Dprctl
make[1]: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kself=
tests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/prct=
l'
Makefile:14: warning: overriding recipe for target 'clean'
../lib.mk:124: warning: ignoring old recipe for target 'clean'
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-tes=
t
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselft=
ests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/prctl=
'
2023-03-20 06:20:52 make -C prctl
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
../lib.mk:124: warning: ignoring old recipe for target 'clean'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/prctl'
2023-03-20 06:20:52 make quicktest=3D1 run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
../lib.mk:124: warning: ignoring old recipe for target 'clean'
TAP version 13
1..3
# selftests: prctl: disable-tsc-ctxt-sw-stress-test
# [No further output means we're all right]
ok 1 selftests: prctl: disable-tsc-ctxt-sw-stress-test
# selftests: prctl: disable-tsc-on-off-stress-test
# [No further output means we're all right]
ok 2 selftests: prctl: disable-tsc-on-off-stress-test
# selftests: prctl: disable-tsc-test
# rdtsc() =3D=3D 8977674487554
# prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
# rdtsc() =3D=3D 8977675161186
# prctl(PR_SET_TSC, PR_TSC_ENABLE)
# rdtsc() =3D=3D 8977675181440
# prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
# rdtsc() =3D=3D [ SIG_SEGV ]
# prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
# prctl(PR_SET_TSC, PR_TSC_ENABLE)
# rdtsc() =3D=3D 8977675302072
ok 3 selftests: prctl: disable-tsc-test
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/prctl'
LKP SKIP proc.proc-pid-vm
2023-03-20 06:21:13 make -C proc
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/proc'
gcc -I../../../../usr/include -Wall -O2 -Wno-unused-function -D_GNU_SOURCE =
  -pthread   fd-001-lookup.c  -o /usr/src/perf_selftests-i386-debian-10.3-k=
selftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/=
proc/fd-001-lookup
gcc -I../../../../usr/include -Wall -O2 -Wno-unused-function -D_GNU_SOURCE =
  -pthread   fd-002-posix-eq.c  -o /usr/src/perf_selftests-i386-debian-10.3=
-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftest=
s/proc/fd-002-posix-eq
gcc -I../../../../usr/include -Wall -O2 -Wno-unused-function -D_GNU_SOURCE =
  -pthread   fd-003-kthread.c  -o /usr/src/perf_selftests-i386-debian-10.3-=
kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests=
/proc/fd-003-kthread
gcc -I../../../../usr/include -Wall -O2 -Wno-unused-function -D_GNU_SOURCE =
  -pthread   proc-loadavg-001.c  -o /usr/src/perf_selftests-i386-debian-10.=
3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftes=
ts/proc/proc-loadavg-001
gcc -I../../../../usr/include -Wall -O2 -Wno-unused-function -D_GNU_SOURCE =
  -pthread   proc-empty-vm.c  -o /usr/src/perf_selftests-i386-debian-10.3-k=
selftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/=
proc/proc-empty-vm
proc-empty-vm.c: In function =E2=80=98main=E2=80=99:
proc-empty-vm.c:350:2: error: #error "implement 'unmap everything'"
  350 | #error "implement 'unmap everything'"
      |  ^~~~~
make: *** [../lib.mk:145: /usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/proc/pr=
oc-empty-vm] Error 1
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/proc'
2023-03-20 06:21:14 make quicktest=3D1 run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/proc'
gcc -I../../../../usr/include -Wall -O2 -Wno-unused-function -D_GNU_SOURCE =
  -pthread   proc-empty-vm.c  -o /usr/src/perf_selftests-i386-debian-10.3-k=
selftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/=
proc/proc-empty-vm
proc-empty-vm.c: In function =E2=80=98main=E2=80=99:
proc-empty-vm.c:350:2: error: #error "implement 'unmap everything'"
  350 | #error "implement 'unmap everything'"
      |  ^~~~~
make: *** [../lib.mk:145: /usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/proc/pr=
oc-empty-vm] Error 1
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/proc'
2023-03-20 06:21:14 make -C pstore
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/pstore'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/pstore'
2023-03-20 06:21:14 make quicktest=3D1 run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/pstore'
TAP version 13
1..2
# selftests: pstore: pstore_tests
# =3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
# UUID=3D37215a68-453a-4dcd-8171-8bc0672a1a61
# Checking pstore backend is registered ... ok
# 	backend=3Dramoops
# 	cmdline=3Dip=3D::::lkp-skl-d07::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/res=
ult/kernel-selftests/group-02/lkp-skl-d07/debian-11.1-i386-20220923.cgz/i38=
6-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/1 =
BOOT_IMAGE=3D/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fd=
dd8985b5bb1aaf774a97aba8/vmlinuz-6.2.0-rc5-00038-gd8e45bf1aed2 branch=3Dlin=
us/master job=3D/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-group-02-d=
ebian-11.1-i386-20220923.cgz-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8-20230=
320-11804-97t9v5-1.yaml user=3Dlkp ARCH=3Di386 kconfig=3Di386-debian-10.3-k=
selftests commit=3Dd8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8 sysctl.debug.te=
st_sysctl.boot_int=3D1 initcall_debug mem=3D4G nmi_watchdog=3D0 max_uptime=
=3D1200 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Dd=
ebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=
=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpan=
ic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 sy=
stemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,11=
5200 console=3DttyS0,115200 vga=3Dnormal rw
# Checking pstore console is registered ... ok
# Checking /dev/pmsg0 exists ... ok
# Writing unique string to /dev/pmsg0 ... ok
ok 1 selftests: pstore: pstore_tests
# selftests: pstore: pstore_post_reboot_tests
# =3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
# UUID=3Dc02eaa0c-7e72-4ef5-b2e4-e6fdc4c7eb4d
# Checking pstore backend is registered ... ok
# 	backend=3Dramoops
# 	cmdline=3Dip=3D::::lkp-skl-d07::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/res=
ult/kernel-selftests/group-02/lkp-skl-d07/debian-11.1-i386-20220923.cgz/i38=
6-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/1 =
BOOT_IMAGE=3D/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fd=
dd8985b5bb1aaf774a97aba8/vmlinuz-6.2.0-rc5-00038-gd8e45bf1aed2 branch=3Dlin=
us/master job=3D/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-group-02-d=
ebian-11.1-i386-20220923.cgz-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8-20230=
320-11804-97t9v5-1.yaml user=3Dlkp ARCH=3Di386 kconfig=3Di386-debian-10.3-k=
selftests commit=3Dd8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8 sysctl.debug.te=
st_sysctl.boot_int=3D1 initcall_debug mem=3D4G nmi_watchdog=3D0 max_uptime=
=3D1200 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Dd=
ebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=
=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpan=
ic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 sy=
stemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,11=
5200 console=3DttyS0,115200 vga=3Dnormal rw
# pstore_crash_test has not been executed yet. we skip further tests.
ok 2 selftests: pstore: pstore_post_reboot_tests # SKIP
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/pstore'
ptp test: not in Makefile
2023-03-20 06:21:15 make TARGETS=3Dptp
make[1]: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kself=
tests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptp'
gcc -isystem /usr/src/perf_selftests-i386-debian-10.3-kselftests-d8e45bf1ae=
d2e5fddd8985b5bb1aaf774a97aba8/usr/include     testptp.c -lrt -o /usr/src/p=
erf_selftests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774=
a97aba8/tools/testing/selftests/ptp/testptp
make[1]: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselft=
ests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptp'
2023-03-20 06:21:15 make -C ptp
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptp'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptp'
2023-03-20 06:21:15 make quicktest=3D1 run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptp'
TAP version 13
1..2
# selftests: ptp: testptp
ok 1 selftests: ptp: testptp
# selftests: ptp: phc.sh
# SKIP: PTP device not provided
ok 2 selftests: ptp: phc.sh
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptp'
2023-03-20 06:21:15 make -C ptrace
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptrace'
gcc -std=3Dc99 -pthread -Wall -isystem /usr/src/perf_selftests-i386-debian-=
10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/self=
tests/../../../usr/include     get_syscall_info.c  -o /usr/src/perf_selftes=
ts-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/too=
ls/testing/selftests/ptrace/get_syscall_info
gcc -std=3Dc99 -pthread -Wall -isystem /usr/src/perf_selftests-i386-debian-=
10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/self=
tests/../../../usr/include     peeksiginfo.c  -o /usr/src/perf_selftests-i3=
86-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/te=
sting/selftests/ptrace/peeksiginfo
gcc -std=3Dc99 -pthread -Wall -isystem /usr/src/perf_selftests-i386-debian-=
10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/self=
tests/../../../usr/include     vmaccess.c  -o /usr/src/perf_selftests-i386-=
debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testi=
ng/selftests/ptrace/vmaccess
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptrace'
2023-03-20 06:21:16 make quicktest=3D1 run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptrace'
TAP version 13
1..3
# selftests: ptrace: get_syscall_info
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.get_syscall_info ...
# #            OK  global.get_syscall_info
# ok 1 global.get_syscall_info
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ptrace: get_syscall_info
# selftests: ptrace: peeksiginfo
# PASS
ok 2 selftests: ptrace: peeksiginfo
# selftests: ptrace: vmaccess
# TAP version 13
# 1..2
# # Starting 2 tests from 1 test cases.
# #  RUN           global.vmaccess ...
# #            OK  global.vmaccess
# ok 1 global.vmaccess
# #  RUN           global.attach ...
# # attach: Test terminated by timeout
# #          FAIL  global.attach
# not ok 2 global.attach
# # FAILED: 1 / 2 tests passed.
# # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 3 selftests: ptrace: vmaccess # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/ptrace'
2023-03-20 06:21:47 make -C rlimits
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/rlimits=
'
gcc -Wall -O2 -g     rlimits-per-userns.c  -o /usr/src/perf_selftests-i386-=
debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testi=
ng/selftests/rlimits/rlimits-per-userns
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/rlimits'
2023-03-20 06:21:47 make quicktest=3D1 run_tests -C rlimits
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/rlimits=
'
TAP version 13
1..1
# selftests: rlimits: rlimits-per-userns
# rlimits-per-userns: (pid=3D4129) Starting testcase
# rlimits-per-userns: (pid=3D4129): Setting RLIMIT_NPROC=3D1
# rlimits-per-userns: (pid=3D4130): New process starting ...
# rlimits-per-userns: (pid=3D4130): Changing to uid=3D60000, gid=3D60000
# rlimits-per-userns: (pid=3D4130): Service running ...
# rlimits-per-userns: (pid=3D4130): Unshare user namespace
# rlimits-per-userns: (pid=3D4130): Executing real service ...
# rlimits-per-userns: (pid=3D4131): New process starting ...
# rlimits-per-userns: (pid=3D4131): Changing to uid=3D60000, gid=3D60000
# rlimits-per-userns: (pid=3D4131): Service running ...
# rlimits-per-userns: (pid=3D4131): Unshare user namespace
# rlimits-per-userns: (pid=3D4131): Executing real service ...
# rlimits-per-userns: (pid=3D4129): pid 4130 killed by signal 10
# rlimits-per-userns: (pid=3D4129): pid 4131 killed by signal 10
# rlimits-per-userns: (pid=3D4129): Test passed
ok 1 selftests: rlimits: rlimits-per-userns
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/rlimits'
2023-03-20 06:21:49 make -C rtc
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/rtc'
gcc -O3 -Wl,-no-as-needed -Wall     rtctest.c -lrt -lpthread -lm -o /usr/sr=
c/perf_selftests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf=
774a97aba8/tools/testing/selftests/rtc/rtctest
gcc -O3 -Wl,-no-as-needed -Wall     setdate.c -lrt -lpthread -lm -o /usr/sr=
c/perf_selftests-i386-debian-10.3-kselftests-d8e45bf1aed2e5fddd8985b5bb1aaf=
774a97aba8/tools/testing/selftests/rtc/setdate
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/rtc'
2023-03-20 06:21:49 make quicktest=3D1 run_tests -C rtc
make: Entering directory '/usr/src/perf_selftests-i386-debian-10.3-kselftes=
ts-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/rtc'
TAP version 13
1..1
# selftests: rtc: rtctest
# TAP version 13
# 1..8
# # Starting 8 tests from 1 test cases.
# #  RUN           rtc.date_read ...
# # rtctest.c:52:date_read:Current RTC date/time is 20/03/2023 06:24:19.
# #            OK  rtc.date_read
# ok 1 rtc.date_read
# #  RUN           rtc.date_read_loop ...
# # rtctest.c:95:date_read_loop:Continuously reading RTC time for 30s (with=
 11ms breaks after every read).
# # rtctest.c:122:date_read_loop:Performed 2739 RTC time reads.
# #            OK  rtc.date_read_loop
# ok 2 rtc.date_read_loop
# #  RUN           rtc.uie_read ...
# #            OK  rtc.uie_read
# ok 3 rtc.uie_read
# #  RUN           rtc.uie_select ...
# #            OK  rtc.uie_select
# ok 4 rtc.uie_select
# #  RUN           rtc.alarm_alm_set ...
# # rtctest.c:221:alarm_alm_set:Alarm time now set to 06:24:59.
# # rtctest.c:241:alarm_alm_set:data: 1a0
# #            OK  rtc.alarm_alm_set
# ok 5 rtc.alarm_alm_set
# #  RUN           rtc.alarm_wkalm_set ...
# # rtctest.c:281:alarm_wkalm_set:Alarm time now set to 20/03/2023 06:25:02=
.
# #            OK  rtc.alarm_wkalm_set
# ok 6 rtc.alarm_wkalm_set
# #  RUN           rtc.alarm_alm_set_minute ...
# # rtctest.c:331:alarm_alm_set_minute:Alarm time now set to 06:26:00.
# # rtctest.c:351:alarm_alm_set_minute:data: 1a0
# #            OK  rtc.alarm_alm_set_minute
# ok 7 rtc.alarm_alm_set_minute
# #  RUN           rtc.alarm_wkalm_set_minute ...
# # rtctest.c:391:alarm_wkalm_set_minute:Alarm time now set to 20/03/2023 0=
6:27:00.
# #            OK  rtc.alarm_wkalm_set_minute
# ok 8 rtc.alarm_wkalm_set_minute
# # PASSED: 8 / 8 tests passed.
# # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: rtc: rtctest
make: Leaving directory '/usr/src/perf_selftests-i386-debian-10.3-kselftest=
s-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/tools/testing/selftests/rtc'

--zGORFlIilFuPTYMD
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 3G
need_cpu: 2
kernel-selftests:
  group: group-02
kernel_cmdline: sysctl.debug.test_sysctl.boot_int=1
job_origin: kernel-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d07
tbox_group: lkp-skl-d07
submit_id: 6417e831b4eadd2b6e4ce63c
job_file: "/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-group-02-debian-11.1-i386-20220923.cgz-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8-20230320-11118-194u6ql-0.yaml"
id: 0a762bc40a2c9c87a7ed354233b7ea96ed373191
queuer_version: "/zday/lkp"

#! /db/releases/20230217153843/lkp-src/hosts/lkp-skl-d07
model: Skylake
nr_cpu: 8
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz

#! /db/releases/20230217153843/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:

#! /db/releases/20230217153843/lkp-src/include/queue/cyclic
commit: d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8
rootfs: debian-11.1-i386-20220923.cgz

#! /db/releases/20230217153843/lkp-src/include/testbox/lkp-skl-d07
ucode: '0xf0'
bisect_dmesg: true

# for sysctl

#! /db/releases/20230217153843/lkp-src/include/kernel-selftests
need_kconfig:
- FUSE_FS: m
- IPV6_MULTIPLE_TABLES: y
- MACSEC: y
- MISC_FILESYSTEMS: y
- MPTCP: y
- MPTCP_IPV6: y
- NET_FOU
- NET_FOU_IP_TUNNELS: y
- NET_L3_MASTER_DEV: y
- NET_SCH_NETEM
- NET_VRF: y
- NF_FLOW_TABLE: m
- NF_FLOW_TABLE_INET: m
- NF_FLOW_TABLE_IPV4: m
- NF_FLOW_TABLE_IPV6: m
- NF_TABLES_NETDEV: y
- PROC_FS: y
- PSTORE: y
- PSTORE_CONSOLE: y
- PSTORE_PMSG: y
- PSTORE_RAM: m
- SECCOMP: y
- SECCOMP_FILTER: y
- TEST_BLACKHOLE_DEV: m
- UTS_NS: y
- VETH
- X86_CPU_RESCTRL: y
- NFC: m
- NFC_NCI: m
- NFC_VIRTUAL_NCI: m
initrds:
- linux_headers
- linux_selftests
kconfig: i386-debian-10.3-kselftests
enqueue_time: 2023-03-20 12:59:30.094413137 +08:00
_id: 6417e831b4eadd2b6e4ce63c
_rt: "/result/kernel-selftests/group-02/lkp-skl-d07/debian-11.1-i386-20220923.cgz/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 7a8ce875e97e8d8b4db9901933b6b2b6eeca6a73
base_commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
branch: linux-devel/devel-hourly-20230307-154727
result_root: "/result/kernel-selftests/group-02/lkp-skl-d07/debian-11.1-i386-20220923.cgz/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/0"
scheduler_version: "/lkp/lkp/src"
arch: i386
max_uptime: 1200
initrd: "/osimage/debian/debian-11.1-i386-20220923.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/group-02/lkp-skl-d07/debian-11.1-i386-20220923.cgz/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/0
- BOOT_IMAGE=/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/vmlinuz-6.2.0-rc5-00038-gd8e45bf1aed2
- branch=linux-devel/devel-hourly-20230307-154727
- job=/lkp/jobs/scheduled/lkp-skl-d07/kernel-selftests-group-02-debian-11.1-i386-20220923.cgz-d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8-20230320-11118-194u6ql-0.yaml
- user=lkp
- ARCH=i386
- kconfig=i386-debian-10.3-kselftests
- commit=d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8
- sysctl.debug.test_sysctl.boot_int=1
- initcall_debug
- mem=4G
- nmi_watchdog=0
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/modules.cgz"
linux_headers_initrd: "/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/kernel-selftests_20221008.cgz,/osimage/pkg/debian-11.1-i386-20220923.cgz/kernel-selftests-i386-75776cf2-1_20221008.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/hw_20220927.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-i386.cgz"
site: lkp-wsx01

#! /db/releases/20230312204942/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.3.0-rc2-wt-ath-04421-g90a7556ca43e
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/i386-debian-10.3-kselftests/gcc-11/d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8/vmlinuz-6.2.0-rc5-00038-gd8e45bf1aed2"
dequeue_time: 2023-03-20 13:26:34.489637572 +08:00

#! /db/releases/20230319113320/lkp-src/include/site/lkp-wsx01
job_state: finished
loadavg: 1.47 4.38 2.34 1/160 4669
start_time: '1679290093'
end_time: '1679290591'
version: "/lkp/lkp/.src-20230319-113613:d632e65a559b:92634f46ce10"

--zGORFlIilFuPTYMD
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

ln -sf /usr/bin/clang
ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -C membarrier
make quicktest=1 run_tests -C membarrier
make -C memfd
make quicktest=1 run_tests -C memfd
make -C mincore
make quicktest=1 run_tests -C mincore
make -C mount
make quicktest=1 run_tests -C mount
make -C mount_setattr
make quicktest=1 run_tests -C mount_setattr
make -C move_mount_set_group
make quicktest=1 run_tests -C move_mount_set_group
make -C mqueue
make quicktest=1 run_tests -C mqueue
make -C nci
make quicktest=1 run_tests -C nci
make TARGETS=nolibc
make -C nolibc
make quicktest=1 run_tests -C nolibc
make -C nsfs
make quicktest=1 run_tests -C nsfs
make -C openat2
make quicktest=1 run_tests -C openat2
make TARGETS=perf_events
make -C perf_events
make quicktest=1 run_tests -C perf_events
make -C pid_namespace
make quicktest=1 run_tests -C pid_namespace
make TARGETS=prctl
make -C prctl
make quicktest=1 run_tests -C prctl
make -C proc
make quicktest=1 run_tests -C proc
make -C pstore
make quicktest=1 run_tests -C pstore
make TARGETS=ptp
make -C ptp
make quicktest=1 run_tests -C ptp
make -C ptrace
make quicktest=1 run_tests -C ptrace
make -C rlimits
make quicktest=1 run_tests -C rlimits
make -C rtc
make quicktest=1 run_tests -C rtc

--zGORFlIilFuPTYMD--
