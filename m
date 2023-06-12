Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE78272B539
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 03:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjFLByz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 21:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFLByx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:54:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52367136
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 18:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686534887; x=1718070887;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xS5Xzn1CRAH4mvVzeBr5eTDRNJbeUe76MBJJOGqYDwo=;
  b=Flh6/o1Jl9F/wxvZ0iXrpPT2TiwlS79NPF0dvTuM3oI7Tp1wGjcqOI3s
   RDqyoP8sFYrrrfKZ7L+GkNdWMaBMvZaMAiHWiedLIgN26K066OZEbA4zA
   byqPoSKRuxC1anJWbKfacM6+Jel+FkLMoBr6a/9GqFzyUGPQ4/XHn+2rO
   E6TY4xbFwaA7rjxlDrhmYAedMqui3qltDhZvX9+/7Ekl0kWmRqLKiAaxb
   QQECf5jfeAXrvWni+x2bJBXOLrH3YZQJAvQPAzf1zEXpy78s+ljkqn+On
   pWfriojv/N0gtZpG51iqYYHlILUHQYMoHUefRVHC2a7UAR8toSiycjGL5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="360408485"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="360408485"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 18:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="885238962"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="885238962"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 11 Jun 2023 18:54:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 18:54:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 11 Jun 2023 18:54:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 11 Jun 2023 18:54:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kgt9OiqEiyqGt85n9lBvzgAZYbrMtDLAWQcVklY1xr3bC2yplY/1NWJ6Ez5BHdWxcU+P3D2SgDCQfOghjGxWd0olMx79F0CtBtiOO2IGDlbq08bUuUM4sQLTJuaA7Lc4nr24DiecYiJrwudoZmVgAlqm0mWePKUY+Jtlr+lvOALk+z2DUgaIq6VQkLX5m+NapUxUIcAJWAUVNIkKAXvPYWUqKx5O+ut/sKhQAGD9VDdcYWpaj4UnM4DfiqLLPcyABEZgiRnwiFCjICnOABYEWmrarC1nIXvOJivLsupN/ZrPg+xV8aF0dvYEmVDhcTLVZMLBI+e2CtRsw2yBfAlWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYRbzun8kHJ1B46Vz2Rm5eH58xl58m0FpCvjnKOGuVs=;
 b=ItwuOO7dSWOscOzmgtKfnFeF+25epUGAns/iAOibH26OBW5f/s2fECVNBgdAk5WjMp81kUbtlZqSMQ/XnrQjdg+vzo5c6BTxRUq97597pe9WNbuaCp2J2ob+xhSBFteXEu6PA6wF7LlJHjXsgT00Ib1dj69Y3v8rvS7VosEMR/3mFas8znO/SYpL/qxBnEKG3O/YrT7rBLA2aKNb0uf//MqFt8SJE5ObHxPjeKt5yhw7t+Q5A9VD8xEOF1rFAv1lbqpXxE5Cuvf8nGIqcWExgS3Bwswxd6TouubKdzcgs15WUq53ZQNV0bRMpJnKSrQB40szMj4BCl07lkIuRLpJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 01:54:27 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%6]) with mapi id 15.20.6455.028; Mon, 12 Jun 2023
 01:54:27 +0000
Date:   Mon, 12 Jun 2023 09:54:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     David Howells <dhowells@redhat.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        <linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [axboe-block:for-6.5/block] [block]  1ccf164ec8:
 WARNING:at_mm/gup.c:#try_get_folio
Message-ID: <202306120931.a9606b88-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="flM30SFYbA/CHDjR"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 239b3824-5258-4294-90c1-08db6ae7f3dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8wvwqZHbAkUqu+BCEAs4uCWMYi+fvGQ03Bk2QZ0hnvZKpvNNo58FtmD3iJMRsjOZTWxS7sitnJygKdEI2WAn2yOrz1q47goeVxIUKoV5/8oB9127mmYDuN4fifUuDdNo6e21AGvkwW3dZLqVu6qs2XCfLK73zDH1ZkW35gO7+WeZecMwG0sBYlwtYPDAfpGprtW/ZWiwSUK+czjqNZTCeFOzLuEL0ednb8gCPucfN6guWYjwweOezuXGLZ+daKaae/FI7sdP4xNi7h6n3jmnWc+EZQYNJ5iDdlZBNycQuziArd0L6DI6mmeRrYRBbcGkCv8Qt4n3oOIDoKXJSGZ0XJ6grmdPthzNoZN/1aYLr0juAHguezKBDhYSD58UafGTIRXEcprpMoEZoHl3jEdge25M3pbcAPbhg1cLcGu3ijQk8dxg/rsOjgv5LncS8J3WgnGvkNq9sZyY7vWGIQ6aoS0reDftThxX2V8UZpGPLvwPREJez52EwZCbY+szyq+vK1skI9YhTjBAc5NcvOJ7RWlVvPRiXsN4u3L456UWrWAVoGAbFLVpVzARnWS57E00izT4KN3YJlMZYycWvOMRGj10p+41FL0JAzwVfS3GcNEGKyv5q4wYSQ4w4ebAMZ1dTtjh9uJRdSzeRXuPJVNOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(66556008)(66476007)(66946007)(316002)(45080400002)(966005)(107886003)(54906003)(6916009)(4326008)(478600001)(6666004)(36756003)(86362001)(6512007)(6506007)(1076003)(26005)(21490400003)(186003)(83380400001)(41300700001)(8936002)(8676002)(7416002)(5660300002)(235185007)(30864003)(2906002)(6486002)(44144004)(82960400001)(2616005)(38100700002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ukimuC/UCvMN/NzDZs/h8El1UgFzM6y9CHzC73AjBRns4DNaBHV16LefVTk?=
 =?us-ascii?Q?kB92z07uV+6795K9CTuLtUsXXrPkASTiBmE+tG6DkElVsghCtdFyvOhATy+W?=
 =?us-ascii?Q?sPyE2Mcsjqvs17CQaRSHFErAyebZzL3Atn8tV9QFBQHmSYKW4PE6OVikYLDH?=
 =?us-ascii?Q?6L3QRIHzCYGWNeJvhSWcNO3NPLrgYUh4t7pDAaD/lp5mtnBOOR0tmsaOCisS?=
 =?us-ascii?Q?0CFYUMwDM3xqPbdWrBitfLKo2o3z2xDsnSU5ajg6f/QXZriqsSklmzBQYWuT?=
 =?us-ascii?Q?lOPnJM4IbMxUsg7QLqH2APEKi6JclXQo2WhpPiWA/uG+GpiQLZ8GVFr32t3Y?=
 =?us-ascii?Q?RYt4+xJlq8D8rzOXnG6FBEnOkemdtZBczE3GS8Pb0U1KUB9PI+ACVZ5B2Pgy?=
 =?us-ascii?Q?JMbPSId2ckLFHyazI0iIwXut00UO13ePxeK0KXqscWnT4iczjzFy/Jr5RmyE?=
 =?us-ascii?Q?3N4mcvlDNgjufBrPUlw9mRdZDoogLnz6dMRS+79jgKc/Ce4AaLYxc4fwXhcg?=
 =?us-ascii?Q?/oQOdfFT7heDfZ2gIECFyyiRGzrSpYUG0+qKyO2+gC5ne9ZR2KkK9r4sR0ZU?=
 =?us-ascii?Q?hV/+CCbcZgwLMwcjVWwKtO4R2YJI4Fc88M6ujKacp27hPzUBhlj818zpHINe?=
 =?us-ascii?Q?HeP6BUBImPujXzXPG3G1oWv/dzPKt9ITbPkgzYCx0lgl572OHsigs8I4d5Or?=
 =?us-ascii?Q?f/+GRrR1yG8JIe+pE86GYXQIXOU9Yv1H8NIPF5RbyyUluQ2tlOnEZyBLsYwU?=
 =?us-ascii?Q?hHGdgkI4m5H0ZzgEU8inQU14mRuSYal5DRwwk007ofXkAVzdYmBuG1JSLczl?=
 =?us-ascii?Q?nWd7UzmCSsmot6Ku2wq3gg7NHBJMGdjD5Baz+4R6da+isexTI8EqcWfZcNV7?=
 =?us-ascii?Q?bO1nAlGKkYkw/XJRl6GKya82iEPH2Ja8uRqMW5jdMxkEBbEmErRVtEHXr2Cj?=
 =?us-ascii?Q?1ghXFeFZggf3OHpy0bj+iMS1wwPgel0uYXoW6zkyAvMKNs5uKRKalDvN0G/P?=
 =?us-ascii?Q?iEYwC1EiiphbJq0x5Cp4LFR89KJ1L2ZincWh6r6huKt75yw1YQo493hDWiZ7?=
 =?us-ascii?Q?c15fn1bAQ3U97jGkcpKnfploG+YDm0aogSHuNuS9tSR2VpwOgRNe3rTc61oT?=
 =?us-ascii?Q?0Z62pefruJswGJJ0vNgkGwUQK7D7DCQL1we5SkCjZxMVxJFrKiHewCq+tIyV?=
 =?us-ascii?Q?au4ib/HKSaSCXgc9C6Ro51UNa0miK50RhGOHsujjwp8ksOlnGaXM4dgUNqJ9?=
 =?us-ascii?Q?u+vDMk7eyby88GljYz+AvcUnPjKqUFOEyRrb3Hw6vXzj0drR7vVEd+OMLfma?=
 =?us-ascii?Q?ptesIHan4WhJUTPBCMSW5KYCv8qXErB/WpJ5hzCzZi4gLLgS6C/EiF3IkCUe?=
 =?us-ascii?Q?emjnMLNOEhYgcXhEf1sIr0tAD2Uje8LpZlohWjAy4HOtWiye7VAEqvgj1hL4?=
 =?us-ascii?Q?ogQMAY5rDL0Dx/Z0tXbrhrhhzsphCbrdd4sAzznYzQNHToJfDfyst+qFa5Yx?=
 =?us-ascii?Q?Pyewh9u7RDC4j3T1ER1+00E7vfVcnxLfThc17QrdsvelJ5yNTxg0kyL5VMhK?=
 =?us-ascii?Q?2HX1hW3P6XsbgfrUVaYYqm8foLo5svgl81rLfjkn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 239b3824-5258-4294-90c1-08db6ae7f3dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 01:54:27.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEQKMelUN7n5chIzUiDMQpaT/xenB8xN4keHVVz5ZpxOuPXF2MVXprKJOEdPbNGOxIQWFYk7k0Ef1a/J/AQXVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--flM30SFYbA/CHDjR
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:at_mm/gup.c:#try_get_folio" on:

commit: 1ccf164ec866cb8575ab9b2e219fca875089c60e ("block: Use iov_iter_extract_pages() and page pinning in direct-io.c")
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-6.5/block

[test failed on linux-next/master 53ab6975c12d1ad86c599a8927e8c698b144d669]

in testcase: xfstests
version: xfstests-x86_64-06c027a-1_20230529
with following parameters:

	disk: 4HDD
	fs: udf
	test: generic-group-45



compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202306120931.a9606b88-oliver.sang@intel.com


[  121.986791][ T2220] ------------[ cut here ]------------
[ 121.992093][ T2220] WARNING: CPU: 6 PID: 2220 at mm/gup.c:76 try_get_folio (mm/gup.c:76 (discriminator 1)) 
[  121.999983][ T2220] Modules linked in: udf crc_itu_t cdrom dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress intel_rapl_msr libcrc32c intel_rapl_common x86_pkg_temp_thermal intel_powerclamp i915 sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 coretemp sg drm_buddy kvm_intel ipmi_devintf intel_gtt ipmi_msghandler kvm irqbypass drm_display_helper crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel syscopyarea ghash_clmulni_intel sysfillrect sysimgblt sha512_ssse3 ahci rapl libahci ttm wmi_bmof mei_wdt video intel_cstate mei_me intel_uncore libata serio_raw mei intel_pch_thermal wmi acpi_pad intel_pmc_core tpm_infineon drm fuse ip_tables
[  122.057874][ T2220] CPU: 6 PID: 2220 Comm: aio-dio-cycle-w Not tainted 6.4.0-rc2-00083-g1ccf164ec866 #1
[  122.067228][ T2220] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[ 122.076153][ T2220] RIP: 0010:try_get_folio (mm/gup.c:76 (discriminator 1)) 
[ 122.081367][ T2220] Code: 49 8d 7f 48 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 cd 00 00 00 49 8b 47 48 a8 01 0f 84 ff fe ff ff 48 83 e8 01 e9 f9 fe ff ff <0f> 0b 48 83 c4 08 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 66 90 be
All code
========
   0:	49 8d 7f 48          	lea    0x48(%r15),%rdi
   4:	48 89 f9             	mov    %rdi,%rcx
   7:	48 c1 e9 03          	shr    $0x3,%rcx
   b:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
   f:	0f 85 cd 00 00 00    	jne    0xe2
  15:	49 8b 47 48          	mov    0x48(%r15),%rax
  19:	a8 01                	test   $0x1,%al
  1b:	0f 84 ff fe ff ff    	je     0xffffffffffffff20
  21:	48 83 e8 01          	sub    $0x1,%rax
  25:	e9 f9 fe ff ff       	jmpq   0xffffffffffffff23
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 83 c4 08          	add    $0x8,%rsp
  30:	31 c0                	xor    %eax,%eax
  32:	5b                   	pop    %rbx
  33:	5d                   	pop    %rbp
  34:	41 5c                	pop    %r12
  36:	41 5d                	pop    %r13
  38:	41 5e                	pop    %r14
  3a:	41 5f                	pop    %r15
  3c:	c3                   	retq   
  3d:	66 90                	xchg   %ax,%ax
  3f:	be                   	.byte 0xbe

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 83 c4 08          	add    $0x8,%rsp
   6:	31 c0                	xor    %eax,%eax
   8:	5b                   	pop    %rbx
   9:	5d                   	pop    %rbp
   a:	41 5c                	pop    %r12
   c:	41 5d                	pop    %r13
   e:	41 5e                	pop    %r14
  10:	41 5f                	pop    %r15
  12:	c3                   	retq   
  13:	66 90                	xchg   %ax,%ax
  15:	be                   	.byte 0xbe
[  122.100738][ T2220] RSP: 0018:ffffc900039df0b8 EFLAGS: 00010082
[  122.106644][ T2220] RAX: 00000000fffffc01 RBX: ffffea0007288134 RCX: 0000000000000000
[  122.114453][ T2220] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffea0007288134
[  122.122260][ T2220] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffea0007288137
[  122.130060][ T2220] R10: fffff94000e51026 R11: ffffffff85865b94 R12: ffffea0007288100
[  122.137861][ T2220] R13: dffffc0000000000 R14: ffffea0007288108 R15: ffffea0007288100
[  122.145665][ T2220] FS:  00007f92332b1740(0000) GS:ffff8883cf700000(0000) knlGS:0000000000000000
[  122.154417][ T2220] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  122.160836][ T2220] CR2: 00007f82f266b514 CR3: 000000013ab7c004 CR4: 00000000003706e0
[  122.168636][ T2220] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  122.176440][ T2220] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  122.184238][ T2220] Call Trace:
[  122.187368][ T2220]  <TASK>
[ 122.190156][ T2220] try_grab_folio (mm/gup.c:155) 
[ 122.194594][ T2220] gup_pte_range (mm/gup.c:2454) 
[ 122.199037][ T2220] ? try_grab_folio (mm/gup.c:2422) 
[ 122.203731][ T2220] ? __module_address (kernel/module/main.c:3198) 
[ 122.208510][ T2220] ? udf_file_write_iter (fs/udf/file.c:115) udf
[ 122.214152][ T2220] ? memtype_copy_nth_element (arch/x86/mm/hugetlbpage.c:28) 
[ 122.219710][ T2220] gup_pgd_range (mm/gup.c:2839 mm/gup.c:2867 mm/gup.c:2892 mm/gup.c:2920) 
[ 122.224146][ T2220] ? gup_huge_pmd (mm/gup.c:2901) 
[ 122.228669][ T2220] ? unwind_get_return_address (arch/x86/kernel/unwind_orc.c:341) 
[ 122.234146][ T2220] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26) 
[ 122.238754][ T2220] lockless_pages_from_mm (arch/x86/include/asm/irqflags.h:134 mm/gup.c:2974) 
[ 122.243968][ T2220] ? gup_pgd_range (mm/gup.c:2946) 
[ 122.248573][ T2220] ? __module_address (kernel/module/main.c:3198) 
[  122.253357][ T2220]  ? 0xffffffffc0c23000
[ 122.257360][ T2220] ? udf_file_write_iter (fs/udf/file.c:115) udf
[ 122.263017][ T2220] internal_get_user_pages_fast (mm/gup.c:3023) 
[ 122.268667][ T2220] ? lockless_pages_from_mm (mm/gup.c:2995) 
[ 122.274051][ T2220] ? is_bpf_text_address (kernel/bpf/core.c:720) 
[ 122.278996][ T2220] ? kernel_text_address (kernel/extable.c:125 kernel/extable.c:94) 
[ 122.284129][ T2220] pin_user_pages_fast (mm/gup.c:3132) 
[ 122.288914][ T2220] ? get_user_pages_fast (mm/gup.c:3132) 
[ 122.293869][ T2220] iov_iter_extract_pages (lib/iov_iter.c:1790 lib/iov_iter.c:1852) 
[ 122.299077][ T2220] ? stack_trace_save (kernel/stacktrace.c:123) 
[ 122.303768][ T2220] ? csum_and_copy_to_iter (lib/iov_iter.c:1846) 
[ 122.309228][ T2220] ? native_queued_spin_lock_slowpath (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 arch/x86/include/asm/qspinlock.h:25 kernel/locking/qspinlock.c:353) 
[ 122.315476][ T2220] ? .slowpath (kernel/locking/qspinlock.c:317) 
[ 122.319570][ T2220] do_direct_IO (fs/direct-io.c:176 fs/direct-io.c:214 fs/direct-io.c:919) 
[ 122.324103][ T2220] ? __create_object (include/linux/rculist.h:79 (discriminator 4) include/linux/rculist.h:128 (discriminator 4) mm/kmemleak.c:715 (discriminator 4)) 
[ 122.328886][ T2220] ? submit_page_section (fs/direct-io.c:909) 
[ 122.334017][ T2220] ? kmem_cache_alloc (mm/slub.c:3453 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 122.338885][ T2220] __blockdev_direct_IO (fs/direct-io.c:1253) 
[ 122.344011][ T2220] ? udf_get_block_wb (fs/udf/inode.c:477) udf
[ 122.349231][ T2220] ? do_direct_IO (fs/direct-io.c:1113) 
[ 122.353933][ T2220] ? udf_get_block_wb (fs/udf/inode.c:477) udf
[ 122.359159][ T2220] udf_direct_IO (fs/udf/inode.c:314) udf
[ 122.364117][ T2220] generic_file_direct_write (mm/filemap.c:3864) 
[ 122.369592][ T2220] __generic_file_write_iter (mm/filemap.c:4024) 
[ 122.375067][ T2220] udf_file_write_iter (fs/udf/file.c:115) udf
[ 122.380550][ T2220] aio_write (fs/aio.c:1524 fs/aio.c:1604) 
[ 122.384642][ T2220] ? cpumask_weight (arch/x86/include/asm/trace//hyperv.h:11) 
[ 122.390197][ T2220] ? get_object (mm/kmemleak.c:608) 
[ 122.394365][ T2220] ? io_submit_one (fs/aio.c:1057 fs/aio.c:2019) 
[ 122.398888][ T2220] ? do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 122.403322][ T2220] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 122.409227][ T2220] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 122.414443][ T2220] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
[ 122.420096][ T2220] ? io_submit_one (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:176 include/linux/refcount.h:272 include/linux/refcount.h:315 include/linux/refcount.h:333 fs/aio.c:1190 fs/aio.c:2026) 
[ 122.424705][ T2220] io_submit_one (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:176 include/linux/refcount.h:272 include/linux/refcount.h:315 include/linux/refcount.h:333 fs/aio.c:1190 fs/aio.c:2026) 
[ 122.429133][ T2220] ? kmem_cache_free (mm/slub.c:1807 mm/slub.c:3786 mm/slub.c:3808) 
[ 122.433914][ T2220] ? __io_submit_one+0x3d0/0x3d0 
[ 122.439726][ T2220] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 122.444765][ T2220] __x64_sys_io_submit (fs/aio.c:2082 fs/aio.c:2052 fs/aio.c:2052) 
[ 122.449718][ T2220] ? __ia32_compat_sys_io_submit (fs/aio.c:2052) 
[ 122.455535][ T2220] ? __x64_sys_openat (fs/open.c:1383) 
[ 122.460407][ T2220] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 122.464928][ T2220] ? exit_to_user_mode_loop (include/linux/sched.h:2341 include/linux/resume_user_mode.h:61 kernel/entry/common.c:171) 
[ 122.470228][ T2220] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 122.474495][ T2220] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  122.480232][ T2220] RIP: 0033:0x7f92333a8f29
[ 122.484496][ T2220] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
All code
========
   0:	00 c3                	add    %al,%bl
   2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 37 8f 0d 00 	mov    0xd8f37(%rip),%rcx        # 0xd8f71
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 37 8f 0d 00 	mov    0xd8f37(%rip),%rcx        # 0xd8f47
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--flM30SFYbA/CHDjR
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc2-00083-g1ccf164ec866"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_CONSTRUCTORS=y
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
# CONFIG_USELIB is not set
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
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
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
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
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
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
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
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
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
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
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
# CONFIG_EXPERT is not set
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
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

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
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
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
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
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
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_INTEL_TDX_GUEST is not set
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBPB_ENTRY=y
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
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
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
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
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
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
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
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

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
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
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
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
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
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
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
# CONFIG_BLK_SED_OPAL is not set
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
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
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
CONFIG_COMPAT_BINFMT_ELF=y
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
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
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
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
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
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_NET_HANDSHAKE=y
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
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
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
# CONFIG_INET_DIAG_DESTROY is not set
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
# CONFIG_TCP_CONG_CDG is not set
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
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
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
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
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
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
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
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
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
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
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
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
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
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
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
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_SOFT_RESERVE=y
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
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
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
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
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
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
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
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
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
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
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
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
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
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
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
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
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
# CONFIG_PATA_SIS is not set
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
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
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
CONFIG_DM_DEBUG=y
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
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
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
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
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
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
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
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
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
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

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
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
# CONFIG_ATH12K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
CONFIG_MAC80211_HWSIM=m
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
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
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
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
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
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
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
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
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
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

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
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

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
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
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
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
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
# CONFIG_SPI_SPIDEV is not set
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
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
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
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
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
# CONFIG_GPIO_FXL6408 is not set
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
# CONFIG_GPIO_ELKHARTLAKE is not set
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
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
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
# CONFIG_MANAGER_SBS is not set
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
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
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
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
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
# CONFIG_SENSORS_FTSTEUTATES is not set
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
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
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
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
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
# CONFIG_SENSORS_W83773G is not set
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
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
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
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

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
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
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
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
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
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
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
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
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
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
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
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
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
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
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
# CONFIG_FB_SM501 is not set
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
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

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
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

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
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
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
# CONFIG_USB_STORAGE_REALTEK is not set
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
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
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
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
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
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
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
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
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
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
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
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
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
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
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
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

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
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IDXD_PERFMON is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
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
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
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
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
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

# CONFIG_WPCM450_SOC is not set

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

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
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
# CONFIG_GENERIC_PHY is not set
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
CONFIG_IDLE_INJECT=y
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
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
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
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
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
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
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
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
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
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
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
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
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
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
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
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
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
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
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
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_SUNRPC_XPRT_RDMA is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
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
CONFIG_NLS_ASCII=y
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
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
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
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
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
# CONFIG_CRYPTO_SM4_GENERIC is not set
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
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
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
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
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
CONFIG_CRYPTO_SHA512=y
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
CONFIG_CRYPTO_CRC32C=y
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
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
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
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
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
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
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
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
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
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
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
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
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
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
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
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

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
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
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
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
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
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

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
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
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
# CONFIG_DEBUG_PREEMPT is not set

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

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
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
CONFIG_TRACER_MAX_TRACE=y
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
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
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
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
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
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

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
CONFIG_DEBUG_BOOT_PARAMS=y
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
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
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
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_FAULT_INJECTION_CONFIGFS=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
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
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--flM30SFYbA/CHDjR
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='xfstests'
	export testcase='xfstests'
	export category='functional'
	export need_memory='2G'
	export job_origin='xfstests-generic-part3.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-skl-d07'
	export tbox_group='lkp-skl-d07'
	export submit_id='64849175e2720ad4bfe0e9f3'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-udf-generic-group-45-debian-11.1-x86_64-20220510.cgz-1ccf164ec866cb8575ab9b2e219fca875089c60e-20230610-54463-iyvlk7-3.yaml'
	export id='2480af323e4e9e0fab3fcc0de5d27ddff899c92a'
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
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
UDF_FS'
	export commit='1ccf164ec866cb8575ab9b2e219fca875089c60e'
	export ucode='0xf0'
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2023-06-10 23:06:29 +0800'
	export _id='6484918be2720ad4bfe0e9f5'
	export _rt='/result/xfstests/4HDD-udf-generic-group-45/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e'
	export user='lkp'
	export compiler='gcc-12'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='b697124b270b5c6e41c7dd9f0183af5e14d340f5'
	export base_commit='9561de3a55bed6bdd44a12820ba81ec416e705a7'
	export branch='axboe-block/for-6.5/block'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/xfstests/4HDD-udf-generic-group-45/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/1'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/xfstests/4HDD-udf-generic-group-45/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/1
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/vmlinuz-6.4.0-rc2-00083-g1ccf164ec866
branch=axboe-block/for-6.5/block
job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-udf-generic-group-45-debian-11.1-x86_64-20220510.cgz-1ccf164ec866cb8575ab9b2e219fca875089c60e-20230610-54463-iyvlk7-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=1ccf164ec866cb8575ab9b2e219fca875089c60e
initcall_debug
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20230529.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-06c027a-1_20230529.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.4.0-rc5-07297-gb697124b270b'
	export repeat_to=6
	export stop_repeat_if_found='xfstests.generic.451.fail'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/vmlinuz-6.4.0-rc2-00083-g1ccf164ec866'
	export dequeue_time='2023-06-10 23:07:38 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-udf-generic-group-45-debian-11.1-x86_64-20220510.cgz-1ccf164ec866cb8575ab9b2e219fca875089c60e-20230610-54463-iyvlk7-3.cgz'

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

	run_setup nr_hdd=4 $LKP_SRC/setup/disk

	run_setup fs='udf' $LKP_SRC/setup/fs

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='generic-group-45' $LKP_SRC/tests/wrapper xfstests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='generic-group-45' $LKP_SRC/stats/wrapper xfstests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time xfstests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--flM30SFYbA/CHDjR
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
q9oCq9kQMEaiQbHEZ/sCAAAAAARZWg==

--flM30SFYbA/CHDjR
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="xfstests"

2023-06-10 15:09:16 export TEST_DIR=/fs/sda1
2023-06-10 15:09:16 export TEST_DEV=/dev/sda1
2023-06-10 15:09:16 export FSTYP=udf
2023-06-10 15:09:16 export SCRATCH_MNT=/fs/scratch
2023-06-10 15:09:16 mkdir /fs/scratch -p
2023-06-10 15:09:16 export DISABLE_UDF_TEST=1
2023-06-10 15:09:16 export SCRATCH_DEV=/dev/sda4
2023-06-10 15:09:16 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-45
2023-06-10 15:09:16 ./check generic/450 generic/451 generic/453 generic/454 generic/456 generic/458 generic/459
FSTYP         -- udf
PLATFORM      -- Linux/x86_64 lkp-skl-d07 6.4.0-rc2-00083-g1ccf164ec866 #1 SMP PREEMPT_DYNAMIC Sun Jun  4 15:18:19 CST 2023
MKFS_OPTIONS  -- /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /fs/scratch

generic/450       [not run] Only test on sector size < half of block size
generic/451       _check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//generic/451.dmesg)
- output mismatch (see /lkp/benchmarks/xfstests/results//generic/451.out.bad)
    --- tests/generic/451.out	2023-05-29 18:02:38.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/451.out.bad	2023-06-10 15:10:44.363460887 +0000
    @@ -1,2 +1,10 @@
     QA output created by 451
    +get stale data from buffer read
    +00000000  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
    +000a0000
    +get stale data from DIO read
    +00000000  55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55  UUUUUUUUUUUUUUUU
    +*
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/451.out /lkp/benchmarks/xfstests/results//generic/451.out.bad'  to see the entire diff)
generic/453       [not run] udf does not allow unrestricted byte streams for names
generic/454       [not run] attr namespace user not supported by this filesystem type: udf
generic/456       [not run] xfs_io falloc  failed (old kernel/wrong fs?)
generic/458       [not run] Reflink not supported by scratch filesystem type: udf
generic/459       [not run] udf does not support freezing
Ran: generic/450 generic/451 generic/453 generic/454 generic/456 generic/458 generic/459
Not run: generic/450 generic/453 generic/454 generic/456 generic/458 generic/459
Failures: generic/451
Failed 1 of 7 tests


--flM30SFYbA/CHDjR
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/xfstests-generic-part3.yaml
suite: xfstests
testcase: xfstests
category: functional
need_memory: 2G
disk: 4HDD
fs: udf
xfstests:
  test: generic-group-45
job_origin: xfstests-generic-part3.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d07
tbox_group: lkp-skl-d07
submit_id: 64839465e2720ab3a931b872
job_file: "/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-udf-generic-group-45-debian-11.1-x86_64-20220510.cgz-1ccf164ec866cb8575ab9b2e219fca875089c60e-20230610-45993-1mardbz-0.yaml"
id: 56e76b973a3fe71c30766d01b3fd87415e43d23a
queuer_version: "/zday/lkp"

#! /db/releases/20230603003305/lkp-src/hosts/lkp-skl-d07
model: Skylake
nr_cpu: 8
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz

#! /db/releases/20230603003305/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:
kmemleak:

#! /db/releases/20230603003305/lkp-src/include/disk/nr_hdd
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- UDF_FS

#! /db/releases/20230603003305/lkp-src/include/queue/cyclic
commit: 1ccf164ec866cb8575ab9b2e219fca875089c60e

#! /db/releases/20230603003305/lkp-src/include/testbox/lkp-skl-d07
ucode: '0xf0'

#! /db/releases/20230603003305/lkp-src/include/fs/OTHERS
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2023-06-10 05:06:46.009038582 +08:00
_id: 64839465e2720ab3a931b872
_rt: "/result/xfstests/4HDD-udf-generic-group-45/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e"

#! schedule options
user: lkp
compiler: gcc-12
LKP_SERVER: internal-lkp-server
head_commit: b697124b270b5c6e41c7dd9f0183af5e14d340f5
base_commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
branch: linux-devel/devel-hourly-20230607-040231
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/xfstests/4HDD-udf-generic-group-45/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/xfstests/4HDD-udf-generic-group-45/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/vmlinuz-6.4.0-rc2-00083-g1ccf164ec866
- branch=linux-devel/devel-hourly-20230607-040231
- job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-udf-generic-group-45-debian-11.1-x86_64-20220510.cgz-1ccf164ec866cb8575ab9b2e219fca875089c60e-20230610-45993-1mardbz-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=1ccf164ec866cb8575ab9b2e219fca875089c60e
- initcall_debug
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20230529.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-06c027a-1_20230529.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230608122651/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.4.0-rc5-08526-g276bc5cd9151

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-12/1ccf164ec866cb8575ab9b2e219fca875089c60e/vmlinuz-6.4.0-rc2-00083-g1ccf164ec866"
dequeue_time: 2023-06-10 06:12:32.757893239 +08:00

#! /db/releases/20230609191406/lkp-src/include/site/lkp-wsx01
job_state: finished
loadavg: 1.31 0.75 0.31 1/184 3869
start_time: '1686348852'
end_time: '1686348952'
version: "/lkp/lkp/.src-20230609-144412:bc7b9a6c1637:b3ddff16a57c"

--flM30SFYbA/CHDjR
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

dmsetup remove_all
wipefs -a --force /dev/sda1
wipefs -a --force /dev/sda2
wipefs -a --force /dev/sda3
wipefs -a --force /dev/sda4
mkfs -t udf /dev/sda1
mkfs -t udf /dev/sda3
mkfs -t udf /dev/sda4
mkfs -t udf /dev/sda2
mkdir -p /fs/sda1
modprobe udf
mount -t udf /dev/sda1 /fs/sda1
mkdir -p /fs/sda2
mount -t udf /dev/sda2 /fs/sda2
mkdir -p /fs/sda3
mount -t udf /dev/sda3 /fs/sda3
mkdir -p /fs/sda4
mount -t udf /dev/sda4 /fs/sda4
export TEST_DIR=/fs/sda1
export TEST_DEV=/dev/sda1
export FSTYP=udf
export SCRATCH_MNT=/fs/scratch
mkdir /fs/scratch -p
export DISABLE_UDF_TEST=1
export SCRATCH_DEV=/dev/sda4
sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-45
./check generic/450 generic/451 generic/453 generic/454 generic/456 generic/458 generic/459

--flM30SFYbA/CHDjR--
