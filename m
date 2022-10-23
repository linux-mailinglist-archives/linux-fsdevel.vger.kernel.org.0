Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7B6093C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJWOBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 10:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJWOBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:01:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCAE73908;
        Sun, 23 Oct 2022 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666533695; x=1698069695;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=hkiQbyVo7H97fEGA/i24GTjmFlns+4xrMDbq4gG7AAM=;
  b=n4uqcCiKp9YL7BJaszEUxTp9LwR9u2dbS+9v1Hijl51Qqwec85e2aARp
   RNwbtexRIfZ6Lz9ruUbNSTxjcnvzDNqhbuhANH8zsSrQ+7kb8a8/rB0rj
   MUdVyCBGjL6C9mO+V0uCdxXZk1FRHbmQ8Qt6WksMjMOuyaHDFNphWXkYF
   12+i1tRvShFE7+Q23MLHvQNBxnPYR4tqYxiI6zRo2LCiw7qh07GXMCCjX
   6mvHJKwekdO3Vt5NRloo73Ob0rn6hhFKn2MGYm1bazLEGcNfejY7F5WWF
   x8MjDpD0FYPlq5N5NXR6pyOxg3h6oTkhHstKxC/xsm+t1euf+DUr2dWnY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="304880529"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="xz'?yaml'?scan'208";a="304880529"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 07:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="633445540"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="xz'?yaml'?scan'208";a="633445540"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 23 Oct 2022 07:01:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 23 Oct 2022 07:01:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 23 Oct 2022 07:01:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 23 Oct 2022 07:01:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdS3ARw5TVhS1xFZrHntuPsRfBdm9jPr21Po1XKTBZchU4we4z83BSOfRuuDFYx0JneLlx+IVPG69W5WlVD64eydMI5DW2ueXJCyHN01PWaGn21doQ2aczglaA/QMYy+kdK7aeXBK3/n4vn94KsQxay4EkVALh6De5VzGEcqSxGO4Uq0kTaeDvjCpe2R49imCAZ8EtApRjPCF2zrS8vgvRDRi9umP70WCGWXuyvrWz0xJ+3N9AhE3AXyO+pXZfvvDDUNKATgYYr8UCCkZNhiKj3TRbGohv+/ZuldKxR7Bf5ebwWTtj/MQo3N/g1nFfaNoUH9YPGVDN3GX8Dj5BMJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i5o46udRH6FfSD72XSNcLr0SBU5i+1rbgbtuwxORnY=;
 b=Ve6MuRMTyGtdkZ9UgslttWNPhNRPYdBme4hdrRVg0Sva8uzPQnLEj8RcgCe9jckZse27UEjbg/wl8j4JYnGZh6nMHClDc4pG8pKQuNFY5KDSskPyaW8HKSkNlplYkxFz+X9FqnoL3oNy1Tab+TC3f366AqYiNww/RkojR7zRgcYqgluTDxqwpUkshnwe3EVowL6VYg3ZE+LnCzj8AGz/f/5DBYfB+/v4zddKNgNyR5IcZm9MdmT5TbwMIAeXOHahTdDzzEzcV++SKUkk7A8WfOP9xXG+w5CWAmutARV5ObEW/OBTUeguMpuZ5OZps5vXRJI+j1+oYgixnELl3WgJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Sun, 23 Oct
 2022 14:01:22 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::7f2d:39e1:85b6:93c1]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::7f2d:39e1:85b6:93c1%6]) with mapi id 15.20.5746.023; Sun, 23 Oct 2022
 14:01:22 +0000
Date:   Sun, 23 Oct 2022 22:01:09 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-afs@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <linux-nilfs@vger.kernel.org>,
        <linux-mm@kvack.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 09/23] cifs: Convert wdata_alloc_and_fillpages() to
 use filemap_get_folios_tag()
Message-ID: <202210232124.c0b1783d-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="TVg/s+Co+epUfstr"
Content-Disposition: inline
In-Reply-To: <20221017202451.4951-10-vishal.moola@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: 246e6ae3-2c80-499d-136b-08dab4ff1065
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hKCvDZlKvueUGDeLdT4flezSq/b6pLopkvM4p2txDwJGMO/+nq09R8kLgwP+y4ha/ibHa95tzSDUW4dwMzYOMEfURahLDhVPTLvs5ReI7D5Eg9ztMZ1t80YkGWnJZquSoqPuc3xgw6PyaMcdvLZ7Gsp39om7iN/RB+MP6U4tf9scoq9Ztplx8CU953gDxIw/2mcS/Ykp3+USfJaU35J8++SDTxzF3WZoPGJLVpUrEKihwMyGjWM0qc0KxOIHeZXfuTm2hkabIppo+BQBXtz3tdt+o/hA1pDgz5bmEBPTfQg3ENNye3uh8GVhJnaIO4rQsqJyB83CMSTCYHO6LuaFvv9kXajt+s4t22y0JyUDOqTuJ0DBrdB5Uzk9Fn1Fncs+91EIfw8KV+0UrI6u7AQtyKrxGhfiBA2meNd/nmFkxYk2op5D8XCPPcoOGu+efwrLu8GvOo30ge/iay8d4HTkP46Z4SQ2SVhETZDorq89aZdtuzUVXUg7mSCht1UmXYonzAmep0qaHDQanMpXmL2kdlfp0dSBkHlt0OtK6TKMdUxX2mH7KuUjtzlz2Mcqm9aj5WrbhYjeWfzr9ZSALGE1Kk6ME90CeuUgisRgBt5X+7eJX77Z9N+qwpxEP709j5Z7OLLfjiK4oHZLzzaDAWWMHPJi15WR4ColMXQBGEUUIGzl+9QnMg3X40ZJw5had19B4VTMG+z/2MzO5SrUW+Cpk9gOihpxdx+5GSSFCXYsNBqYUbtuWJ8zSAwYuUeey3QLHyINsXtATKRnR9FRin4GmCql4Gf144NfcFKvS2YYV2e+ek8GyjMHiYIiFqeJLazP+qTt3ZmxQ+yhFuFFOqxQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(6486002)(966005)(478600001)(86362001)(83380400001)(21490400003)(45080400002)(66476007)(66556008)(66946007)(6666004)(4326008)(44144004)(36756003)(6506007)(6512007)(8676002)(8936002)(5660300002)(235185007)(26005)(41300700001)(7416002)(6916009)(38100700002)(30864003)(186003)(2616005)(1076003)(2906002)(316002)(82960400001)(2700100001)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWhzNBUvq6ORu/mRe1OI2EFWjIk2JQxHNuKaOxd1H1cRGatgJrhb+6imvj8C?=
 =?us-ascii?Q?jvy4ln2H6I7Uk6xzaOZblhWwfmQvnt1sqp6OCc+62sKRCpGknUFtqI9XxbV0?=
 =?us-ascii?Q?T3Exy5JHcaN96xIs2qkAQHU9MBQyFHLVNzx2H7LMd9F5RTNgOv2NVTtitdJv?=
 =?us-ascii?Q?lgDOF5zaGxohu5tJ8gfwWk/PBP2q1b72OywMxgjQfyRJpGCyOC0nTOJdrgQF?=
 =?us-ascii?Q?SttFyArL3e2qcCbtgaPtF1LHcmocvVAtMlSYMR+vN3u2hRp54tnFfMo8Wsfq?=
 =?us-ascii?Q?QKHUubmwjRE6LOH1uLS9v8mdibVeF3D8phMYFc8qPE7kDZHnDLRSkGBsEwaV?=
 =?us-ascii?Q?a3ugmFV4m1MCicXvS88iz73W3nozml1gkWEohx/evBd0Zc7mdWgUyZ/3FeC9?=
 =?us-ascii?Q?+aTSp2pQzcxTuauqoVRMk3DW6WSfOq4bAwm0bjOV5rq7PS2xtFwreFXC0cqE?=
 =?us-ascii?Q?FQlvPa1Y5IeBnCDU2W7vWMCsWUklVKSDofmqRPHbjXyDsG8XUGj3f2SSlTgS?=
 =?us-ascii?Q?ltmTxLsRti2JrDjg6FPbPJGVhWMyL7aQy06EC64NZNQsNANcdhzSw4OJABhw?=
 =?us-ascii?Q?EYu3KwzTFvdEoHFhik446ARnifJw965oYlgaokvelzVff/65JzARtOXX+rVV?=
 =?us-ascii?Q?UuxbDWac1+DfjjHJhpApV3biaKD6k1PDMQESDddzC6paJz4voz/tiD0fzpD3?=
 =?us-ascii?Q?3Uc7M6DNHsNUz3MYLEUtywsXJuQZlx1afDrNPVXKveCEzJxt2s14fq3n/F/A?=
 =?us-ascii?Q?pmIY3nrGQjVQm9ypt2D+4NVlmRRE69vrBSZr+PGkNbzWc07UdcCPuWxDXRW+?=
 =?us-ascii?Q?DcmeUgQHHE5RTz1y/H2Qk1HnN3A8e6dzamKlt44T/2AX4k+wbHkPyu2RX6GV?=
 =?us-ascii?Q?fNVgjyo8fh6JDNpp22F+lvw19NhnMAAujtzIxzz7w6bLv1QKVBZdymqCINrI?=
 =?us-ascii?Q?DSbJJmTYZTE2E58vf6G+ggFn6vbAqBQAx6uUH/p3zWa6EcluflVFAZavIHf1?=
 =?us-ascii?Q?OTjdKBmoHphBNj7/G07LtDtp79wMs7+YSAlu3WB9yhy8I33dj00lbbhdjZqR?=
 =?us-ascii?Q?0HTrxxqxPNWFJHAmEa6BfbJnkDA0tnQ9+6eKi6vK2MpAU5yxMigeLfSI2LqV?=
 =?us-ascii?Q?tStFEWNPxnRyTqmqr5KGY6ZrgEQQOPTytlxLeyTk0NLk9PW5ZgZvLAQ9oSIC?=
 =?us-ascii?Q?+C0eH9/dGBZK/2iJNHwKz+T/B0pXnYb1VxxFhbsP5HJo2RqmgCkDPFujIpBM?=
 =?us-ascii?Q?X2lNo8f0Ft09ccTgMwlHnQUP/Y4E1pJK8ZA90xFyYL+AQyGGBdMgX9G6s/uO?=
 =?us-ascii?Q?a0xwz0aEMfUm6kQmtWkots0qV8w4Q9RQuWPP7UNNbGZhMdKxxQWxbgCcPNtc?=
 =?us-ascii?Q?0/VeJSwAnEL6LgYbRJVgqN2Z0Xap6BgUGFKvceX6AphfpCzWZz9NUDqP8i/9?=
 =?us-ascii?Q?kFIamVvbtPknpfNIUURs20kgGG2prUC/SjrRVeLqldzW8xcUFvZezIQXq7g/?=
 =?us-ascii?Q?i+cqxyIpef+snzzpzNdCfKLF6d666MpBW1gWbxaHtsdeFP741IsYK0pKH4ti?=
 =?us-ascii?Q?PY1rkLh+i/qXt/XIJRvpN1u9wRVGxHo0WhHrhqwKVsXkirWZ8vjjKv3SpgvJ?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 246e6ae3-2c80-499d-136b-08dab4ff1065
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 14:01:22.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MPNghjpYkHuvMUU926fg4G3F4L4taOVm0GtgP1Hb/Eo9+C2xq0JZhCUbWEPGtW8D6Ul+xryNGp/NlV5lFqxAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--TVg/s+Co+epUfstr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed BUG:Bad_page_state_in_process due to commit (built with gcc-11):

commit: 68e9d45f5b0e8ca96c02dc221a65e54d859303ff ("[PATCH v3 09/23] cifs: Convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()")
url: https://github.com/intel-lab-lkp/linux/commits/Vishal-Moola-Oracle/Convert-to-filemap_get_folios_tag/20221018-042652
base: https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link: https://lore.kernel.org/linux-fsdevel/20221017202451.4951-10-vishal.moola@gmail.com
patch subject: [PATCH v3 09/23] cifs: Convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()

in testcase: xfstests
version: xfstests-x86_64-5a5e419-1_20221017
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv2
	test: generic-group-12

test-description: xfstests is a regression test suite for xfs and other files ystems.
test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git


on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/r/202210232124.c0b1783d-oliver.sang@intel.com


[   89.915631][ T1848] BUG: Bad page state in process smbd  pfn:1194e6
[   89.921904][ T1848] page:000000009b7feda3 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194e6
[   89.931963][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   89.940378][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   89.947587][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   89.956001][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   89.964418][ T1848] page dumped because: non-NULL mapping
[   89.969804][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   90.037090][ T1848] CPU: 7 PID: 1848 Comm: smbd Not tainted 6.1.0-rc1-00014-g68e9d45f5b0e #1
[   90.045508][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   90.054446][ T1848] Call Trace:
[   90.057586][ T1848]  <TASK>
[ 90.060379][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 90.064730][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 90.068993][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 90.073866][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 90.078473][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 90.083430][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 90.088213][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 90.092655][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 90.097962][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 90.102657][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 90.107357][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 90.112318][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 90.116408][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 90.121102][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 90.125800][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 90.130583][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 90.134327][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 90.138603][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   90.144339][ T1848] RIP: 0033:0x7f44ce83fe06
[ 90.148610][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   90.168016][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   90.176266][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   90.184078][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   90.191888][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   90.199698][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   90.207509][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   90.215315][ T1848]  </TASK>
[   90.218194][ T1848] Disabling lock debugging due to kernel taint
[   90.224193][ T1848] BUG: Bad page state in process smbd  pfn:1194e7
[   90.230448][ T1848] page:00000000a81a28a0 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194e7
[   90.240506][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   90.248924][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   90.256145][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   90.264561][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   90.272975][ T1848] page dumped because: non-NULL mapping
[   90.278360][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   90.345634][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   90.355529][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   90.364458][ T1848] Call Trace:
[   90.367597][ T1848]  <TASK>
[ 90.370393][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 90.374743][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 90.379003][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 90.383871][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 90.388492][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 90.393454][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 90.398234][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 90.402670][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 90.407974][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 90.412674][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 90.417371][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 90.422336][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 90.426442][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 90.431143][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 90.435843][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 90.440636][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 90.444389][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 90.448654][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   90.454392][ T1848] RIP: 0033:0x7f44ce83fe06
[ 90.458659][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   90.478066][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   90.486310][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   90.494119][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   90.501933][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   90.509741][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   90.517545][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   90.525353][ T1848]  </TASK>
[   90.528230][ T1848] BUG: Bad page state in process smbd  pfn:1194e8
[   90.534479][ T1848] page:00000000cb832fa7 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194e8
[   90.544540][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   90.552944][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   90.560146][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   90.568562][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   90.576978][ T1848] page dumped because: non-NULL mapping
[   90.582364][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   90.649622][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   90.659505][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   90.668444][ T1848] Call Trace:
[   90.671580][ T1848]  <TASK>
[ 90.674373][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 90.678732][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 90.682990][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 90.687860][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 90.692473][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 90.697432][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 90.702225][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 90.706658][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 90.711959][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 90.716660][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 90.721352][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 90.726318][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 90.730409][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 90.735102][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 90.739801][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 90.744590][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 90.748338][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 90.752607][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   90.758344][ T1848] RIP: 0033:0x7f44ce83fe06
[ 90.762610][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   90.782006][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   90.790250][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   90.798062][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   90.805876][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   90.813689][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   90.821504][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   90.829327][ T1848]  </TASK>
[   90.832207][ T1848] BUG: Bad page state in process smbd  pfn:1194e9
[   90.838450][ T1848] page:00000000de8036b9 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194e9
[   90.848514][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   90.856926][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   90.864143][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   90.872564][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   90.880975][ T1848] page dumped because: non-NULL mapping
[   90.886367][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   90.953634][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   90.963530][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   90.972471][ T1848] Call Trace:
[   90.975610][ T1848]  <TASK>
[ 90.978404][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 90.982757][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 90.987022][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 90.991891][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 90.996499][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 91.001448][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 91.006226][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 91.010660][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 91.015963][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 91.020659][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 91.025352][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 91.030303][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 91.034394][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 91.039088][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 91.043785][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 91.048568][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 91.052312][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 91.056576][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   91.062311][ T1848] RIP: 0033:0x7f44ce83fe06
[ 91.066575][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   91.085972][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   91.094220][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   91.102030][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   91.109839][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   91.117651][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   91.125460][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   91.133274][ T1848]  </TASK>
[   91.136150][ T1848] BUG: Bad page state in process smbd  pfn:1194ea
[   91.142404][ T1848] page:00000000470bcf07 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ea
[   91.152466][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   91.160890][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   91.168097][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   91.176505][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   91.184925][ T1848] page dumped because: non-NULL mapping
[   91.190310][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   91.257580][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   91.267466][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   91.276405][ T1848] Call Trace:
[   91.279541][ T1848]  <TASK>
[ 91.282335][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 91.286687][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 91.290948][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 91.295819][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 91.300426][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 91.305383][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 91.310159][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 91.314598][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 91.319904][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 91.324599][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 91.329298][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 91.334252][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 91.338343][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 91.343039][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 91.347735][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 91.352518][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 91.356262][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 91.360529][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   91.366258][ T1848] RIP: 0033:0x7f44ce83fe06
[ 91.370525][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   91.389932][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   91.398182][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   91.405992][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   91.413798][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   91.421609][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   91.429417][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   91.437226][ T1848]  </TASK>
[   91.440101][ T1848] BUG: Bad page state in process smbd  pfn:1194eb
[   91.446353][ T1848] page:0000000024a0b7d6 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194eb
[   91.456413][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   91.464824][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   91.472028][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   91.480437][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   91.488854][ T1848] page dumped because: non-NULL mapping
[   91.494245][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   91.561524][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   91.571412][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   91.580344][ T1848] Call Trace:
[   91.583482][ T1848]  <TASK>
[ 91.586274][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 91.590621][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 91.594884][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 91.599750][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 91.604358][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 91.609312][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 91.614095][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 91.618535][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 91.623835][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 91.628530][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 91.633230][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 91.638187][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 91.642275][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 91.646973][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 91.651670][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 91.656452][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 91.660197][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 91.664460][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   91.670196][ T1848] RIP: 0033:0x7f44ce83fe06
[ 91.674461][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   91.693859][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   91.702109][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   91.709915][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   91.717726][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   91.725529][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   91.733342][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   91.741150][ T1848]  </TASK>
[   91.744026][ T1848] BUG: Bad page state in process smbd  pfn:1194ec
[   91.750282][ T1848] page:000000004d5f8313 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ec
[   91.760343][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   91.768765][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   91.775969][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   91.784390][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   91.792803][ T1848] page dumped because: non-NULL mapping
[   91.798190][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   91.865439][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   91.875330][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   91.884263][ T1848] Call Trace:
[   91.887403][ T1848]  <TASK>
[ 91.890196][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 91.894548][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 91.898810][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 91.903682][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 91.908292][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 91.913249][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 91.918035][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 91.922473][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 91.927772][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 91.932466][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 91.937161][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 91.942120][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 91.946210][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 91.950908][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 91.955603][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 91.960385][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 91.964125][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 91.968387][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   91.974120][ T1848] RIP: 0033:0x7f44ce83fe06
[ 91.978380][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   91.997780][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   92.006029][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   92.013842][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   92.021653][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   92.029461][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   92.037270][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   92.045080][ T1848]  </TASK>
[   92.047959][ T1848] BUG: Bad page state in process smbd  pfn:1194ed
[   92.054211][ T1848] page:0000000067836541 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ed
[   92.064274][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   92.072697][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   92.079904][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   92.088325][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   92.096740][ T1848] page dumped because: non-NULL mapping
[   92.102127][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   92.169389][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   92.179276][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   92.188211][ T1848] Call Trace:
[   92.191351][ T1848]  <TASK>
[ 92.194145][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 92.198497][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 92.202761][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 92.207630][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 92.212243][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 92.217202][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 92.221983][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 92.226422][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 92.231721][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 92.236417][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 92.241118][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 92.246078][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 92.250166][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 92.254862][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 92.259563][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 92.264347][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 92.268091][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 92.272354][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   92.278091][ T1848] RIP: 0033:0x7f44ce83fe06
[ 92.282353][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   92.301757][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   92.310006][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   92.317820][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   92.325631][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   92.333449][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   92.341260][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   92.349070][ T1848]  </TASK>
[   92.351948][ T1848] BUG: Bad page state in process smbd  pfn:1194ee
[   92.358201][ T1848] page:00000000a7a08c10 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ee
[   92.368265][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   92.376682][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   92.383888][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   92.392309][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   92.400726][ T1848] page dumped because: non-NULL mapping
[   92.406115][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   92.473398][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   92.483288][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   92.492227][ T1848] Call Trace:
[   92.495367][ T1848]  <TASK>
[ 92.498161][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 92.502513][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 92.506783][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 92.511652][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 92.516265][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 92.521224][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 92.526011][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 92.530447][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 92.535750][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 92.540446][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 92.545145][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 92.550101][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 92.554192][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 92.558892][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 92.563591][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 92.568376][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 92.572124][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 92.576389][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   92.582127][ T1848] RIP: 0033:0x7f44ce83fe06
[ 92.586389][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   92.605798][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   92.614052][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   92.621865][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   92.629680][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   92.637493][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   92.645303][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   92.653120][ T1848]  </TASK>
[   92.655996][ T1848] BUG: Bad page state in process smbd  pfn:1194ef
[   92.662249][ T1848] page:00000000285a6a1c refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ef
[   92.672311][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   92.680728][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   92.687938][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   92.696356][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   92.704770][ T1848] page dumped because: non-NULL mapping
[   92.710159][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   92.777420][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   92.787310][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   92.796245][ T1848] Call Trace:
[   92.799381][ T1848]  <TASK>
[ 92.802178][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 92.806527][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 92.810792][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 92.815663][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 92.820277][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 92.825232][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 92.830015][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 92.834457][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 92.839761][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 92.844457][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 92.849150][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 92.854101][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 92.858190][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 92.862891][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 92.867587][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 92.872373][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 92.876116][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 92.880379][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   92.886112][ T1848] RIP: 0033:0x7f44ce83fe06
[ 92.890375][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   92.909774][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   92.918031][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   92.925839][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   92.933643][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   92.941456][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   92.949265][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   92.957075][ T1848]  </TASK>
[   92.959954][ T1848] BUG: Bad page state in process smbd  pfn:118f30
[   92.966203][ T1848] page:00000000d3d1a7a2 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f30
[   92.976260][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   92.984682][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   92.991888][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   93.000301][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   93.008713][ T1848] page dumped because: non-NULL mapping
[   93.014105][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   93.081375][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   93.091265][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   93.100202][ T1848] Call Trace:
[   93.103340][ T1848]  <TASK>
[ 93.106133][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 93.110484][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 93.114751][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 93.119620][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 93.124233][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 93.129186][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 93.133969][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 93.138406][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 93.143709][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 93.148407][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 93.153104][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 93.158063][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 93.162154][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 93.166848][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 93.171544][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 93.176331][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 93.180074][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 93.184341][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   93.190077][ T1848] RIP: 0033:0x7f44ce83fe06
[ 93.194347][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   93.213751][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   93.222001][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   93.229813][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   93.237618][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   93.245433][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   93.253245][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   93.261054][ T1848]  </TASK>
[   93.263934][ T1848] BUG: Bad page state in process smbd  pfn:118f31
[   93.270193][ T1848] page:000000005c2adb74 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f31
[   93.280259][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   93.288688][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   93.295889][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   93.304309][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   93.312720][ T1848] page dumped because: non-NULL mapping
[   93.318109][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   93.385363][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   93.395250][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   93.404180][ T1848] Call Trace:
[   93.407319][ T1848]  <TASK>
[ 93.410115][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 93.414467][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 93.418733][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 93.423604][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 93.428211][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 93.433169][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 93.437956][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 93.442389][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 93.447691][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 93.452389][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 93.457085][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 93.462044][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 93.466131][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 93.470827][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 93.475517][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 93.480302][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 93.484048][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 93.488316][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   93.494047][ T1848] RIP: 0033:0x7f44ce83fe06
[ 93.498314][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   93.517726][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   93.525975][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   93.533781][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   93.541596][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   93.549405][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   93.557216][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   93.565025][ T1848]  </TASK>
[   93.567905][ T1848] BUG: Bad page state in process smbd  pfn:118f32
[   93.574156][ T1848] page:00000000bb78916a refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f32
[   93.584223][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   93.592633][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   93.599843][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   93.608253][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   93.616674][ T1848] page dumped because: non-NULL mapping
[   93.622059][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   93.689328][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   93.699214][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   93.708149][ T1848] Call Trace:
[   93.711284][ T1848]  <TASK>
[ 93.714077][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 93.718429][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 93.722693][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 93.727567][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 93.732173][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 93.737125][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 93.741909][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 93.746347][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 93.751646][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 93.756341][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 93.761039][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 93.765992][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 93.770084][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 93.774782][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 93.779477][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 93.784264][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 93.788004][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 93.792268][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   93.798006][ T1848] RIP: 0033:0x7f44ce83fe06
[ 93.802268][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   93.821674][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   93.829914][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   93.837726][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   93.845541][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   93.853357][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   93.861166][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   93.868979][ T1848]  </TASK>
[   93.871854][ T1848] BUG: Bad page state in process smbd  pfn:118f33
[   93.878112][ T1848] page:000000001512f2f0 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f33
[   93.888172][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   93.896590][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   93.903796][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   93.912215][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   93.920630][ T1848] page dumped because: non-NULL mapping
[   93.926023][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   93.993291][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   94.003174][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   94.012107][ T1848] Call Trace:
[   94.015248][ T1848]  <TASK>
[ 94.018042][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 94.022393][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 94.026661][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 94.031531][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 94.036141][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 94.041096][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 94.045874][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 94.050313][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 94.055620][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 94.060314][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 94.065012][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 94.069966][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 94.074061][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 94.078754][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 94.083449][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 94.088235][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 94.091978][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 94.096242][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   94.101978][ T1848] RIP: 0033:0x7f44ce83fe06
[ 94.106242][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   94.125642][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   94.133893][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   94.141705][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   94.149515][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   94.157327][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   94.165131][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   94.172942][ T1848]  </TASK>
[   94.175822][ T1848] BUG: Bad page state in process smbd  pfn:118f34
[   94.182072][ T1848] page:0000000045698414 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f34
[   94.192130][ T1848] aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
[   94.200546][ T1848] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   94.207753][ T1848] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
[   94.216168][ T1848] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   94.224588][ T1848] page dumped because: non-NULL mapping
[   94.229975][ T1848] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   94.297245][ T1848] CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   94.307140][ T1848] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   94.316072][ T1848] Call Trace:
[   94.319209][ T1848]  <TASK>
[ 94.322001][ T1848] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 94.326353][ T1848] bad_page.cold (mm/page_alloc.c:719) 
[ 94.330617][ T1848] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 94.335491][ T1848] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 94.340095][ T1848] __unfreeze_partials (mm/slub.c:2581) 
[ 94.345053][ T1848] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 94.349834][ T1848] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 94.354272][ T1848] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 94.359574][ T1848] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 94.364272][ T1848] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 94.368967][ T1848] getname_flags (include/linux/audit.h:320 include/linux/audit.h:360 fs/namei.c:135) 
[ 94.373923][ T1848] vfs_fstatat (fs/stat.c:267) 
[ 94.378010][ T1848] __do_sys_newlstat (fs/stat.c:424) 
[ 94.382708][ T1848] ? __ia32_sys_lstat (fs/stat.c:419) 
[ 94.387403][ T1848] ? __do_sys_getcwd (fs/d_path.c:412) 
[ 94.392188][ T1848] ? fput (arch/x86/include/asm/atomic64_64.h:118 include/linux/atomic/atomic-long.h:467 include/linux/atomic/atomic-instrumented.h:1814 fs/file_table.c:371) 
[ 94.395931][ T1848] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 94.400194][ T1848] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   94.405929][ T1848] RIP: 0033:0x7f44ce83fe06
[ 94.410192][ T1848] Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
All code
========
   0:	30 0e                	xor    %cl,(%rsi)
   2:	00 64 c7 00          	add    %ah,0x0(%rdi,%rax,8)
   6:	16                   	(bad)  
   7:	00 00                	add    %al,(%rax)
   9:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   f:	c3                   	retq   
  10:	0f 1f 40 00          	nopl   0x0(%rax)
  14:	41 89 f8             	mov    %edi,%r8d
  17:	48 89 f7             	mov    %rsi,%rdi
  1a:	48 89 d6             	mov    %rdx,%rsi
  1d:	41 83 f8 01          	cmp    $0x1,%r8d
  21:	77 29                	ja     0x4c
  23:	b8 06 00 00 00       	mov    $0x6,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 02                	ja     0x34
  32:	c3                   	retq   
  33:	90                   	nop
  34:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe3094
  3b:	f7 d8                	neg    %eax
  3d:	64 89 02             	mov    %eax,%fs:(%rdx)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 02                	ja     0xa
   8:	c3                   	retq   
   9:	90                   	nop
   a:	48 8b 15 59 30 0e 00 	mov    0xe3059(%rip),%rdx        # 0xe306a
  11:	f7 d8                	neg    %eax
  13:	64 89 02             	mov    %eax,%fs:(%rdx)
[   94.429595][ T1848] RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   94.437841][ T1848] RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
[   94.445653][ T1848] RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
[   94.453462][ T1848] RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
[   94.461272][ T1848] R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
[   94.469082][ T1848] R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
[   94.476891][ T1848]  </TASK>
[   94.641946][ T2350] BUG: Bad page state in process dbench  pfn:1a75dd
[   94.648387][ T2350] page:0000000092f64f04 refcount:0 mapcount:0 mapping:000000006ad6f7fc index:0x1 pfn:0x1a75dd
[   94.658450][ T2350] aops:cifs_addr_ops [cifs] ino:98d4b153c0c70664 dentry name:"BASEMACH.DOC"
[   94.667031][ T2350] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   94.674236][ T2350] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff888426551fb8
[   94.682648][ T2350] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   94.691063][ T2350] page dumped because: non-NULL mapping
[ 94.696447][ T2350] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ah 96.130323][ T2350] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 96.135019][ T2350] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 96.139724][ T2350] cifs_readdir (include/linux/fs.h:1333 fs/cifs/cifsglob.h:1579 fs/cifs/readdir.c:1073) cifs
[ 96.144742][ T2350] ? cifs_dir_info_to_fattr (fs/cifs/readdir.c:1058) cifs
[ 96.150623][ T2350] ? __cond_resched (kernel/sched/core.c:8325) 
[ 96.155152][ T2350] ? down_read_killable (arch/x86/include/asm/atomic64_64.h:34 include/linux/atomic/atomic-long.h:41 include/linux/atomic/atomic-instrumented.h:1280 kernel/locking/rwsem.c:176 kernel/locking/rwsem.c:181 kernel/locking/rwsem.c:249 kernel/locking/rwsem.c:1259 kernel/locking/rwsem.c:1279 kernel/locking/rwsem.c:1534) 
[ 96.160192][ T2350] ? down_read (kernel/locking/rwsem.c:1530) 
[ 96.164452][ T2350] ? fsnotify_perm+0x13b/0x4c0 
[ 96.169669][ T2350] iterate_dir (fs/readdir.c:65) 
[ 96.173932][ T2350] __x64_sys_getdents64 (fs/readdir.c:370 fs/readdir.c:354 fs/readdir.c:354) 
[ 96.178974][ T2350] ? __ia32_sys_getdents (fs/readdir.c:354) 
[ 96.184097][ T2350] ? __x64_sys_getdents (fs/readdir.c:312) 
[ 96.189137][ T2350] ? switch_fpu_return (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:80 arch/x86/kernel/fpu/core.c:755) 
[ 96.194006][ T2350] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 96.198264][ T2350] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   96.203997][ T2350] RIP: 0033:0x7f294a72e387
[ 96.208259][ T2350] Code: 0f 1f 00 48 8b 47 20 c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 81 fa ff ff ff 7f b8 ff ff ff 7f 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 d9 aa 10 00 f7 d8 64 89 02 48
All code
========
   0:	0f 1f 00             	nopl   (%rax)
   3:	48 8b 47 20          	mov    0x20(%rdi),%rax
   7:	c3                   	retq   
   8:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   f:	00 00 00 
  12:	90                   	nop
  13:	48 81 fa ff ff ff 7f 	cmp    $0x7fffffff,%rdx
  1a:	b8 ff ff ff 7f       	mov    $0x7fffffff,%eax
  1f:	48 0f 47 d0          	cmova  %rax,%rdx
  23:	b8 d9 00 00 00       	mov    $0xd9,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 01                	ja     0x33
  32:	c3                   	retq   
  33:	48 8b 15 d9 aa 10 00 	mov    0x10aad9(%rip),%rdx        # 0x10ab13
  3a:	f7 d8                	neg    %eax
  3c:	64 89 02             	mov    %eax,%fs:(%rdx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 01                	ja     0x9
   8:	c3                   	retq   
   9:	48 8b 15 d9 aa 10 00 	mov    0x10aad9(%rip),%rdx        # 0x10aae9
  10:	f7 d8                	neg    %eax
  12:	64 89 02             	mov    %eax,%fs:(%rdx)
  15:	48                   	rex.W
[   96.227653][ T2350] RSP: 002b:00007ffc6f7a81b8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
[   96.235901][ T2350] RAX: ffffffffffffffda RBX: 000055f6e0124340 RCX: 00007f294a72e387
[   96.243707][ T2350] RDX: 0000000000100000 RSI: 000055f6e0124370 RDI: 0000000000000006
[   96.251513][ T2350] RBP: 000055f6e0124370 R08: 00000000000000a0 R09: 0000000000000c02
[   96.259318][ T2350] R10: 00007f294a7c6220 R11: 0000000000000293 R12: ffffffffffffff80
[   96.267129][ T2350] R13: 000055f6e0124344 R14: 0000000000000002 R15: 000055f6e0122920
[   96.274936][ T2350]  </TASK>
[   96.277815][ T2350] BUG: Bad page state in process dbench  pfn:12ffbe
[   96.284239][ T2350] page:0000000058793f2f refcount:0 mapcount:0 mapping:000000006ad6f7fc index:0x1 pfn:0x12ffbe
[   96.294294][ T2350] aops:cifs_addr_ops [cifs] ino:98d4b153c0c70664 dentry name:"BASEMACH.DOC"
[   96.302871][ T2350] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   96.310071][ T2350] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff888426551fb8
[   96.318486][ T2350] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   96.326899][ T2350] page dumped because: non-NULL mapping
[   96.332284][ T2350] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   96.399515][ T2350] CPU: 5 PID: 2350 Comm: dbench Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   96.409572][ T2350] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   96.418503][ T2350] Call Trace:
[   96.421645][ T2350]  <TASK>
[ 96.424437][ T2350] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 96.428788][ T2350] bad_page.cold (mm/page_alloc.c:719) 
[ 96.433050][ T2350] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 96.437921][ T2350] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 96.442525][ T2350] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 96.446964][ T2350] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 96.452087][ T2350] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 96.457388][ T2350] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 96.462085][ T2350] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 96.466784][ T2350] cifs_readdir (include/linux/fs.h:1333 fs/cifs/cifsglob.h:1579 fs/cifs/readdir.c:1073) cifs
[ 96.471800][ T2350] ? cifs_dir_info_to_fattr (fs/cifs/readdir.c:1058) cifs
[ 96.477677][ T2350] ? __cond_resched (kernel/sched/core.c:8325) 
[   96.482201][ T2350]   dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   98.689502][ T2350] CPU: 5 PID: 2350 Comm: dbench Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   98.699564][ T2350] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   98.708492][ T2350] Call Trace:
[   98.711630][ T2350]  <TASK>
[ 98.714425][ T2350] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 98.718774][ T2350] bad_page.cold (mm/page_alloc.c:719) 
[ 98.723041][ T2350] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 98.727907][ T2350] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 98.732514][ T2350] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 98.736952][ T2350] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 98.742083][ T2350] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 98.747389][ T2350] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 98.752090][ T2350] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 98.756781][ T2350] cifs_readdir (include/linux/fs.h:1333 fs/cifs/cifsglob.h:1579 fs/cifs/readdir.c:1073) cifs
[ 98.761799][ T2350] ? cifs_dir_info_to_fattr (fs/cifs/readdir.c:1058) cifs
[ 98.767679][ T2350] ? __cond_resched (kernel/sched/core.c:8325) 
[ 98.772209][ T2350] ? down_read_killable (arch/x86/include/asm/atomic64_64.h:34 include/linux/atomic/atomic-long.h:41 include/linux/atomic/atomic-instrumented.h:1280 kernel/locking/rwsem.c:176 kernel/locking/rwsem.c:181 kernel/locking/rwsem.c:249 kernel/locking/rwsem.c:1259 kernel/locking/rwsem.c:1279 kernel/locking/rwsem.c:1534) 
[ 98.777253][ T2350] ? down_read (kernel/locking/rwsem.c:1530) 
[ 98.781518][ T2350] ? fsnotify_perm+0x13b/0x4c0 
[ 98.786731][ T2350] iterate_dir (fs/readdir.c:65) 
[ 98.790989][ T2350] __x64_sys_getdents64 (fs/readdir.c:370 fs/readdir.c:354 fs/readdir.c:354) 
[ 98.796033][ T2350] ? __ia32_sys_getdents (fs/readdir.c:354) 
[ 98.801159][ T2350] ? __x64_sys_getdents (fs/readdir.c:312) 
[ 98.806201][ T2350] ? switch_fpu_return (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:80 arch/x86/kernel/fpu/core.c:755) 
[ 98.811069][ T2350] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 98.815333][ T2350] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   98.821065][ T2350] RIP: 0033:0x7f294a72e387
[ 98.825328][ T2350] Code: 0f 1f 00 48 8b 47 20 c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 81 fa ff ff ff 7f b8 ff ff ff 7f 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 d9 aa 10 00 f7 d8 64 89 02 48
All code
========
   0:	0f 1f 00             	nopl   (%rax)
   3:	48 8b 47 20          	mov    0x20(%rdi),%rax
   7:	c3                   	retq   
   8:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   f:	00 00 00 
  12:	90                   	nop
  13:	48 81 fa ff ff ff 7f 	cmp    $0x7fffffff,%rdx
  1a:	b8 ff ff ff 7f       	mov    $0x7fffffff,%eax
  1f:	48 0f 47 d0          	cmova  %rax,%rdx
  23:	b8 d9 00 00 00       	mov    $0xd9,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 01                	ja     0x33
  32:	c3                   	retq   
  33:	48 8b 15 d9 aa 10 00 	mov    0x10aad9(%rip),%rdx        # 0x10ab13
  3a:	f7 d8                	neg    %eax
  3c:	64 89 02             	mov    %eax,%fs:(%rdx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 01                	ja     0x9
   8:	c3                   	retq   
   9:	48 8b 15 d9 aa 10 00 	mov    0x10aad9(%rip),%rdx        # 0x10aae9
  10:	f7 d8                	neg    %eax
  12:	64 89 02             	mov    %eax,%fs:(%rdx)
  15:	48                   	rex.W
[   98.844724][ T2350] RSP: 002b:00007ffc6f7a81b8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
[   98.852971][ T2350] RAX: ffffffffffffffda RBX: 000055f6e0124340 RCX: 00007f294a72e387
[   98.860777][ T2350] RDX: 0000000000100000 RSI: 000055f6e0124370 RDI: 0000000000000006
[   98.868583][ T2350] RBP: 000055f6e0124370 R08: 00000000000000a0 R09: 0000000000000c02
[   98.876391][ T2350] R10: 00007f294a7c6220 R11: 0000000000000293 R12: ffffffffffffff80
[   98.884201][ T2350] R13: 000055f6e0124344 R14: 0000000000000002 R15: 000055f6e0122920
[   98.892010][ T2350]  </TASK>
[   98.894886][ T2350] BUG: Bad page state in process dbench  pfn:18f76a
[   98.901310][ T2350] page:0000000011b33e6d refcount:0 mapcount:0 mapping:000000006ad6f7fc index:0x1 pfn:0x18f76a
[   98.911369][ T2350] aops:cifs_addr_ops [cifs] ino:98d4b153c0c70664 dentry name:"BASEMACH.DOC"
[   98.919945][ T2350] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   98.927154][ T2350] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff888426551fb8
[   98.935568][ T2350] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   98.943981][ T2350] page dumped because: non-NULL mapping
[   98.949366][ T2350] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   99.016603][ T2350] CPU: 5 PID: 2350 Comm: dbench Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   99.026667][ T2350] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   99.035598][ T2350] Call Trace:
[   99.038732][ T2350]  <TASK>
[ 99.041528][ T2350] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 99.045876][ T2350] bad_page.cold (mm/page_alloc.c:719) 
[ 99.050137][ T2350] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 99.055008][ T2350] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 99.059614][ T2350] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 99.064051][ T2350] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 99.069179][ T2350] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 99.074481][ T2350] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 99.079179][ T2350] kmem_cache_alloc (mm/slab.h:737 mm/slub.c:3398 mm/slub.c:3406 mm/slub.c:3413 mm/slub.c:3422) 
[ 99.083877][ T2350] cifs_readdir (include/linux/fs.h:1333 fs/cifs/cifsglob.h:1579 fs/cifs/readdir.c:1073) cifs
[ 99.088894][ T2350] ? cifs_dir_info_to_fattr (fs/cifs/readdir.c:1058) cifs
[ 99.094773][ T2350] ? __cond_resched (kernel/sched/core.c:8325) 
[ 99.099297][ T2350] ? down_read_killable (arch/x86/include/asm/atomic64_64.h:34 include/linux/atomic/atomic-long.h:41 include/linux/atomic/atomic-instrumented.h:1280 kernel/locking/rwsem.c:176 kernel/locking/rwsem.c:181 kernel/locking/rwsem.c:249 kernel/locking/rwsem.c:1259 kernel/locking/rwsem.c:1279 kernel/locking/rwsem.c:1534) 
[ 99.104337][ T2350] ? down_read (kernel/locking/rwsem.c:1530) 
[ 99.108598][ T2350] ? fsnotify_perm+0x13b/0x4c0 
[ 99.113813][ T2350] iterate_dir (fs/readdir.c:65) 
[ 99.118085][ T2350] __x64_sys_getdents64 (fs/readdir.c:370 fs/readdir.c:354 fs/readdir.c:354) 
[ 99.123126][ T2350] ? __ia32_sys_getdents (fs/readdir.c:354) 
[ 99.128250][ T2350] ? __x64_sys_getdents (fs/readdir.c:312) 
[ 99.133292][ T2350] ? switch_fpu_return (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:80 arch/x86/kernel/fpu/core.c:755) 
[ 99.138163][ T2350] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 99.142424][ T2350] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   99.148157][ T2350] RIP: 0033:0x7f294a72e387
[ 99.152422][ T2350] Code: 0f 1f 00 48 8b 47 20 c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 81 fa ff ff ff 7f b8 ff ff ff 7f 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 d9 aa 10 00 f7 d8 64 89 02 48
All code
========
   0:	0f 1f 00             	nopl   (%rax)
   3:	48 8b 47 20          	mov    0x20(%rdi),%rax
   7:	c3                   	retq   
   8:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   f:	00 00 00 
  12:	90                   	nop
  13:	48 81 fa ff ff ff 7f 	cmp    $0x7fffffff,%rdx
  1a:	b8 ff ff ff 7f       	mov    $0x7fffffff,%eax
  1f:	48 0f 47 d0          	cmova  %rax,%rdx
  23:	b8 d9 00 00 00       	mov    $0xd9,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 01                	ja     0x33
  32:	c3                   	retq   
  33:	48 8b 15 d9 aa 10 00 	mov    0x10aad9(%rip),%rdx        # 0x10ab13
  3a:	f7 d8                	neg    %eax
  3c:	64 89 02             	mov    %eax,%fs:(%rdx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 01                	ja     0x9
   8:	c3                   	retq   
   9:	48 8b 15 d9 aa 10 00 	mov    0x10aad9(%rip),%rdx        # 0x10aae9
  10:	f7 d8                	neg    %eax
  12:	64 89 02             	mov    %eax,%fs:(%rdx)
  15:	48                   	rex.W
[   99.171814][ T2350] RSP: 002b:00007ffc6f7a81b8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
[   99.180062][ T2350] RAX: ffffffffffffffda RBX: 000055f6e0124340 RCX: 00007f294a72e387
[   99.187870][ T2350] RDX: 0000000000100000 RSI: 000055f6e0124370 RDI: 0000000000000006
[   99.195682][ T2350] RBP: 000055f6e0124370 R08: 00000000000000a0 R09: 0000000000000c02
[   99.203488][ T2350] R10: 00007f294a7c6220 R11: 0000000000000293 R12: ffffffffffffff80
[   99.211299][ T2350] R13: 000055f6e0124344 R14: 0000000000000002 R15: 000055f6e0122920
[   99.219110][ T2350]  </TASK>
[   99.223980][ T2399] BUG: Bad page state in process dmesg  pfn:1be734
[   99.230340][ T2399] page:00000000c592dcf7 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be734
[   99.240399][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[   99.249004][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   99.256217][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[   99.264629][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   99.273044][ T2399] page dumped because: non-NULL mapping
[   99.278432][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   99.345689][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   99.355670][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   99.364602][ T2399] Call Trace:
[   99.367740][ T2399]  <TASK>
[ 99.370529][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 99.374882][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 99.379150][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 99.384014][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 99.388621][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 99.393573][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 99.398351][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 99.402787][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 99.408083][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 99.412780][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 99.417907][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 99.422517][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 99.427124][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 99.431560][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 99.436166][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 99.441466][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 99.445819][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 99.450080][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 99.456073][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 99.460939][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 99.465374][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 99.469546][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 99.473638][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 99.477905][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 99.482514][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 99.487211][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 99.491127][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 99.495826][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 99.501651][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 99.506001][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 99.511127][ T2399] ? open_exec (fs/exec.c:1706) 
[ 99.515219][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 99.519484][ T2399] exec_binprm (fs/exec.c:1769) 
[ 99.523658][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 99.528526][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 99.532879][ T2399] do_execveat_common+0x4c8/0x680 
[ 99.538354][ T2399] ? getname_flags (fs/namei.c:205) 
[ 99.543485][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 99.548008][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 99.552270][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   99.558007][ T2399] RIP: 0033:0x7f089fb17087
[ 99.562273][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[   99.569127][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[   99.577362][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[   99.585171][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[   99.592983][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[   99.600793][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[   99.608603][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[   99.616414][ T2399]  </TASK>
[   99.619291][ T2399] BUG: Bad page state in process dmesg  pfn:1be733
[   99.625632][ T2399] page:0000000065e98b84 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be733
[   99.635692][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[   99.644291][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   99.651492][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[   99.659907][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   99.668321][ T2399] page dumped because: non-NULL mapping
[   99.673703][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[   99.740962][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[   99.750931][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[   99.759860][ T2399] Call Trace:
[   99.763001][ T2399]  <TASK>
[ 99.765792][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 99.770139][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 99.774405][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 99.779275][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 99.783882][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 99.788838][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 99.793620][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 99.798056][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 99.803353][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 99.808048][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 99.813173][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 99.817782][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 99.822391][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 99.826827][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 99.831436][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 99.836734][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 99.841082][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 99.845346][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 99.851336][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 99.856205][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 99.860640][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 99.864814][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 99.868901][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 99.873166][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 99.877773][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 99.882474][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 99.886391][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 99.891085][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 99.896904][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 99.901251][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 99.906382][ T2399] ? open_exec (fs/exec.c:1706) 
[ 99.910468][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 99.914728][ T2399] exec_binprm (fs/exec.c:1769) 
[ 99.918910][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 99.923777][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 99.928126][ T2399] do_execveat_common+0x4c8/0x680 
[ 99.933598][ T2399] ? getname_flags (fs/namei.c:205) 
[ 99.938723][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 99.943243][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 99.947504][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   99.953237][ T2399] RIP: 0033:0x7f089fb17087
[ 99.957499][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[   99.964356][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[   99.972598][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[   99.980406][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[   99.988214][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[   99.996028][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  100.003835][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  100.011644][ T2399]  </TASK>
[  100.014521][ T2399] BUG: Bad page state in process dmesg  pfn:1be732
[  100.020859][ T2399] page:00000000edbb7a50 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be732
[  100.030916][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  100.039516][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  100.046721][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  100.055130][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  100.063538][ T2399] page dumped because: non-NULL mapping
[  100.068926][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  100.136178][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  100.146144][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  100.155077][ T2399] Call Trace:
[  100.158213][ T2399]  <TASK>
[ 100.161007][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 100.165354][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 100.169616][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 100.174483][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 100.179094][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 100.184048][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 100.188830][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 100.193266][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 100.198567][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 100.203265][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 100.208392][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 100.212999][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 100.217611][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 100.222047][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 100.226652][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 100.231953][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 100.236301][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 100.240562][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 100.246553][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 100.251416][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 100.255849][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 100.260024][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 100.264113][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 100.268375][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 100.272984][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 100.277679][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 100.281598][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 100.286292][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 100.292109][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 100.296456][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 100.301586][ T2399] ? open_exec (fs/exec.c:1706) 
[ 100.305676][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 100.309936][ T2399] exec_binprm (fs/exec.c:1769) 
[ 100.314110][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 100.318976][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 100.323322][ T2399] do_execveat_common+0x4c8/0x680 
[ 100.328793][ T2399] ? getname_flags (fs/namei.c:205) 
[ 100.333919][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 100.338435][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 100.342696][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  100.348427][ T2399] RIP: 0033:0x7f089fb17087
[ 100.352688][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  100.359541][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  100.367777][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  100.375583][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  100.383386][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  100.391192][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  100.398997][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  100.406803][ T2399]  </TASK>
[  100.409682][ T2399] BUG: Bad page state in process dmesg  pfn:1be731
[  100.416021][ T2399] page:000000003670a98b refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be731
[  100.426078][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  100.434671][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  100.441871][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  100.450279][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  100.458692][ T2399] page dumped because: non-NULL mapping
[  100.464076][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  100.531329][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  100.541296][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  100.550226][ T2399] Call Trace:
[  100.553361][ T2399]  <TASK>
[ 100.556155][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 100.560506][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 100.564766][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 100.569636][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 100.574244][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 100.579198][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 100.583983][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 100.588416][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 100.593720][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 100.598412][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 100.603539][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 100.608153][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 100.612760][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 100.617199][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 100.621810][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 100.627108][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 100.631462][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 100.635724][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 100.641719][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 100.646588][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 100.651025][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 100.655205][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 100.659300][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 100.663565][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 100.668179][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 100.672882][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 100.676801][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 100.681502][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 100.687323][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 100.691675][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 100.696807][ T2399] ? open_exec (fs/exec.c:1706) 
[ 100.700898][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 100.705165][ T2399] exec_binprm (fs/exec.c:1769) 
[ 100.709342][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 100.714215][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 100.718567][ T2399] do_execveat_common+0x4c8/0x680 
[ 100.724044][ T2399] ? getname_flags (fs/namei.c:205) 
[ 100.729175][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 100.733700][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 100.737967][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  100.743700][ T2399] RIP: 0033:0x7f089fb17087
[ 100.747962][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  100.754824][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  100.763066][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  100.770879][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  100.778690][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  100.786500][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  100.794313][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  100.802124][ T2399]  </TASK>
[  100.805000][ T2399] BUG: Bad page state in process dmesg  pfn:1be730
[  100.811342][ T2399] page:00000000f97030bd refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be730
[  100.821405][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  100.830004][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  100.837215][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  100.845632][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  100.854050][ T2399] page dumped because: non-NULL mapping
[  100.859441][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  100.926743][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  100.936720][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  100.945656][ T2399] Call Trace:
[  100.948796][ T2399]  <TASK>
[ 100.951588][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 100.955941][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 100.960205][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 100.965080][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 100.969686][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 100.974643][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 100.979423][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 100.983862][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 100.989166][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 100.993863][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 100.998993][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 101.003608][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 101.008217][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 101.012656][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 101.017264][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 101.022567][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 101.026922][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 101.031183][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 101.037177][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 101.042045][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 101.046482][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 101.050662][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 101.054756][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 101.059018][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 101.063633][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 101.068325][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 101.072244][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 101.076946][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 101.082767][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 101.087116][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 101.092244][ T2399] ? open_exec (fs/exec.c:1706) 
[ 101.096336][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 101.100599][ T2399] exec_binprm (fs/exec.c:1769) 
[ 101.104775][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 101.109645][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 101.113999][ T2399] do_execveat_common+0x4c8/0x680 
[ 101.119474][ T2399] ? getname_flags (fs/namei.c:205) 
[ 101.124604][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 101.129128][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 101.133392][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  101.139131][ T2399] RIP: 0033:0x7f089fb17087
[ 101.143396][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  101.150254][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  101.158503][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  101.166313][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  101.174120][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  101.181932][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  101.189745][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  101.197561][ T2399]  </TASK>
[  101.200439][ T2399] BUG: Bad page state in process dmesg  pfn:1be7bf
[  101.206778][ T2399] page:000000006de13f3c refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7bf
[  101.216839][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  101.225426][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  101.232631][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  101.241045][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  101.249458][ T2399] page dumped because: non-NULL mapping
[  101.254849][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  101.322115][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  101.332089][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  101.341026][ T2399] Call Trace:
[  101.344164][ T2399]  <TASK>
[ 101.346958][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 101.351311][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 101.355574][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 101.360447][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 101.365056][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 101.370013][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 101.374798][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 101.379231][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 101.384536][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 101.389233][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 101.394363][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 101.398972][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 101.403579][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 101.408015][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 101.412625][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 101.417926][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 101.422279][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 101.426542][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 101.432535][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 101.437405][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 101.441845][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 101.446019][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 101.450114][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 101.454372][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 101.458987][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 101.463681][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 101.467597][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 101.472296][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 101.478118][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 101.482470][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 101.487597][ T2399] ? open_exec (fs/exec.c:1706) 
[ 101.491686][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 101.495951][ T2399] exec_binprm (fs/exec.c:1769) 
[ 101.500127][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 101.504997][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 101.509349][ T2399] do_execveat_common+0x4c8/0x680 
[ 101.514827][ T2399] ? getname_flags (fs/namei.c:205) 
[ 101.519957][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 101.524483][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 101.528747][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  101.534480][ T2399] RIP: 0033:0x7f089fb17087
[ 101.538745][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  101.545604][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  101.553847][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  101.561657][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  101.569467][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  101.577277][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  101.585087][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  101.592896][ T2399]  </TASK>
[  101.595777][ T2399] BUG: Bad page state in process dmesg  pfn:1be7be
[  101.602118][ T2399] page:00000000ba1b916d refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7be
[  101.612175][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  101.620772][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  101.627977][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  101.636393][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  101.644808][ T2399] page dumped because: non-NULL mapping
[  101.650198][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  101.717465][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  101.727439][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  101.736371][ T2399] Call Trace:
[  101.739515][ T2399]  <TASK>
[ 101.742309][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 101.746659][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 101.750928][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 101.755800][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 101.760409][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 101.765368][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 101.770156][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 101.774592][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 101.779896][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 101.784593][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 101.789724][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 101.794333][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 101.798944][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 101.803382][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 101.807993][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 101.813298][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 101.817655][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 101.821917][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 101.827920][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 101.832785][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 101.837224][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 101.841404][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 101.845496][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 101.849761][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 101.854372][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 101.859070][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 101.862986][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 101.867685][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 101.873504][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 101.877853][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 101.882985][ T2399] ? open_exec (fs/exec.c:1706) 
[ 101.887076][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 101.891341][ T2399] exec_binprm (fs/exec.c:1769) 
[ 101.895518][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 101.900390][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 101.904744][ T2399] do_execveat_common+0x4c8/0x680 
[ 101.910224][ T2399] ? getname_flags (fs/namei.c:205) 
[ 101.915357][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 101.919878][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 101.924145][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  101.929880][ T2399] RIP: 0033:0x7f089fb17087
[ 101.934145][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  101.941009][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  101.949254][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  101.957067][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  101.964880][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  101.972690][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  101.980498][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  101.988309][ T2399]  </TASK>
[  101.991188][ T2399] BUG: Bad page state in process dmesg  pfn:1be7bd
[  101.997526][ T2399] page:00000000a18d56de refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7bd
[  102.007589][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  102.016176][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  102.023384][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  102.031801][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  102.040217][ T2399] page dumped because: non-NULL mapping
[  102.045606][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  102.112895][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  102.122869][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  102.131805][ T2399] Call Trace:
[  102.134946][ T2399]  <TASK>
[ 102.137741][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 102.142090][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 102.146351][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 102.151221][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 102.155832][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 102.160790][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 102.165572][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 102.170014][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 102.175316][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 102.180005][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 102.185133][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 102.189747][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 102.194360][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 102.198798][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 102.203411][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 102.208709][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 102.213064][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 102.217327][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 102.223323][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 102.228194][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 102.232628][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 102.236807][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 102.240897][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 102.245166][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 102.249775][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 102.254473][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 102.258394][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 102.263090][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 102.268908][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 102.273259][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 102.278393][ T2399] ? open_exec (fs/exec.c:1706) 
[ 102.282488][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 102.286754][ T2399] exec_binprm (fs/exec.c:1769) 
[ 102.290936][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 102.295807][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 102.300155][ T2399] do_execveat_common+0x4c8/0x680 
[ 102.305627][ T2399] ? getname_flags (fs/namei.c:205) 
[ 102.310760][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 102.315286][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 102.319553][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  102.325286][ T2399] RIP: 0033:0x7f089fb17087
[ 102.329555][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  102.336414][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  102.344661][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  102.352476][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  102.360289][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  102.368101][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  102.375914][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  102.383723][ T2399]  </TASK>
[  102.386599][ T2399] BUG: Bad page state in process dmesg  pfn:1be7bc
[  102.392942][ T2399] page:000000008de84177 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7bc
[  102.403002][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  102.411593][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  102.418804][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  102.427220][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  102.435636][ T2399] page dumped because: non-NULL mapping
[  102.441026][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  102.508313][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  102.518285][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  102.527216][ T2399] Call Trace:
[  102.530356][ T2399]  <TASK>
[ 102.533150][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 102.537500][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 102.541764][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 102.546633][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 102.551237][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 102.556196][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 102.560977][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 102.565420][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 102.570721][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 102.575418][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 102.580549][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 102.585164][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 102.589773][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 102.594209][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 102.598820][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 102.604125][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 102.608480][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 102.612743][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 102.618735][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 102.623606][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 102.628046][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 102.632219][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 102.636314][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 102.640579][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 102.645194][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 102.649887][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 102.653808][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 102.658507][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 102.664334][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 102.668687][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 102.673820][ T2399] ? open_exec (fs/exec.c:1706) 
[ 102.677908][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 102.682176][ T2399] exec_binprm (fs/exec.c:1769) 
[ 102.686355][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 102.691224][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 102.695575][ T2399] do_execveat_common+0x4c8/0x680 
[ 102.701048][ T2399] ? getname_flags (fs/namei.c:205) 
[ 102.706179][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 102.710702][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 102.714969][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  102.720705][ T2399] RIP: 0033:0x7f089fb17087
[ 102.724972][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  102.731831][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  102.740076][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  102.747884][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  102.755696][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  102.763504][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  102.771318][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  102.779131][ T2399]  </TASK>
[  102.782010][ T2399] BUG: Bad page state in process dmesg  pfn:1be7bb
[  102.788349][ T2399] page:00000000da80f945 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7bb
[  102.798411][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  102.807009][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  102.814218][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  102.822633][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  102.831050][ T2399] page dumped because: non-NULL mapping
[  102.836438][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  102.903709][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  102.913680][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  102.922611][ T2399] Call Trace:
[  102.925752][ T2399]  <TASK>
[ 102.928544][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 102.932891][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 102.937160][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 102.942030][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 102.946637][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 102.951594][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 102.956380][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 102.960813][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 102.966115][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 102.970810][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 102.975940][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 102.980547][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 102.985160][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 102.989595][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 102.994201][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 102.999502][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 103.003853][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 103.008114][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 103.014111][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 103.018976][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 103.023414][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 103.027592][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 103.031684][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 103.035948][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 103.040558][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 103.045253][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 103.049168][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 103.053864][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 103.059684][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 103.064034][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 103.069159][ T2399] ? open_exec (fs/exec.c:1706) 
[ 103.073246][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 103.077510][ T2399] exec_binprm (fs/exec.c:1769) 
[ 103.081687][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 103.086552][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 103.090902][ T2399] do_execveat_common+0x4c8/0x680 
[ 103.096379][ T2399] ? getname_flags (fs/namei.c:205) 
[ 103.101509][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 103.106034][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 103.110296][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  103.116032][ T2399] RIP: 0033:0x7f089fb17087
[ 103.120297][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  103.127155][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  103.135390][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  103.143199][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  103.151017][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  103.158827][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  103.166633][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  103.174445][ T2399]  </TASK>
[  103.177322][ T2399] BUG: Bad page state in process dmesg  pfn:1be7ba
[  103.183661][ T2399] page:000000007670454c refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7ba
[  103.193723][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  103.202310][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  103.209513][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  103.217930][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  103.226346][ T2399] page dumped because: non-NULL mapping
[  103.231733][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  103.299008][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  103.308979][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  103.317915][ T2399] Call Trace:
[  103.321053][ T2399]  <TASK>
[ 103.323845][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 103.328192][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 103.332453][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 103.337328][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 103.341937][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 103.346893][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 103.351674][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 103.356112][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 103.361417][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 103.366109][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 103.371236][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 103.375846][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 103.380455][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 103.384894][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 103.389502][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 103.394804][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 103.399158][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 103.403419][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 103.409414][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 103.414287][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 103.418723][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 103.422904][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 103.426995][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 103.431259][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 103.435871][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 103.440574][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 103.444490][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 103.449189][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 103.455012][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 103.459361][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 103.464489][ T2399] ? open_exec (fs/exec.c:1706) 
[ 103.468576][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 103.472841][ T2399] exec_binprm (fs/exec.c:1769) 
[ 103.477020][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 103.481890][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 103.486239][ T2399] do_execveat_common+0x4c8/0x680 
[ 103.491714][ T2399] ? getname_flags (fs/namei.c:205) 
[ 103.496841][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 103.501367][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 103.505628][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  103.511367][ T2399] RIP: 0033:0x7f089fb17087
[ 103.515632][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  103.522490][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  103.530734][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  103.538544][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  103.546357][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  103.554170][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  103.561980][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  103.569794][ T2399]  </TASK>
[  103.572673][ T2399] BUG: Bad page state in process dmesg  pfn:1be7b9
[  103.579014][ T2399] page:00000000a6758727 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7b9
[  103.589076][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  103.597671][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  103.604877][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  103.613287][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  103.621701][ T2399] page dumped because: non-NULL mapping
[  103.627088][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  103.694350][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  103.704323][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  103.713260][ T2399] Call Trace:
[  103.716395][ T2399]  <TASK>
[ 103.719189][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 103.723539][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 103.727800][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 103.732669][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 103.737276][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 103.742229][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 103.747006][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 103.751442][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 103.756741][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 103.761436][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 103.766564][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 103.771172][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 103.775779][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 103.780215][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 103.784825][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 103.790127][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 103.794477][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 103.798736][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 103.804730][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 103.809595][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 103.814029][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 103.818208][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 103.822297][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 103.826561][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 103.831170][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 103.835863][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 103.839779][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 103.844475][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 103.850293][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 103.854649][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 103.859775][ T2399] ? open_exec (fs/exec.c:1706) 
[ 103.863864][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 103.868126][ T2399] exec_binprm (fs/exec.c:1769) 
[ 103.872305][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 103.877173][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 103.881524][ T2399] do_execveat_common+0x4c8/0x680 
[ 103.886999][ T2399] ? getname_flags (fs/namei.c:205) 
[ 103.892127][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 103.896649][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 103.900914][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  103.906647][ T2399] RIP: 0033:0x7f089fb17087
[ 103.910911][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  103.917769][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  103.926011][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  103.933822][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  103.941627][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  103.949434][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  103.957242][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  103.965050][ T2399]  </TASK>
[  103.967927][ T2399] BUG: Bad page state in process dmesg  pfn:1be7b8
[  103.974265][ T2399] page:000000005f881c8e refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7b8
[  103.984319][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  103.992906][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  104.000106][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  104.008517][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  104.016930][ T2399] page dumped because: non-NULL mapping
[  104.022314][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  104.089568][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  104.099542][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  104.108474][ T2399] Call Trace:
[  104.111615][ T2399]  <TASK>
[ 104.114406][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 104.118756][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 104.123017][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 104.127887][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 104.132496][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 104.137452][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 104.142235][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 104.146670][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 104.151967][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 104.156661][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 104.161791][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 104.166404][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 104.171016][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 104.175448][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 104.180059][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 104.185360][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 104.189713][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 104.193975][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 104.199970][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 104.204838][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 104.209273][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 104.213448][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 104.217539][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 104.221802][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 104.226414][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 104.231117][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 104.235029][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 104.239731][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 104.245548][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 104.249895][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 104.255023][ T2399] ? open_exec (fs/exec.c:1706) 
[ 104.259113][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 104.263380][ T2399] exec_binprm (fs/exec.c:1769) 
[ 104.267555][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 104.272425][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 104.276777][ T2399] do_execveat_common+0x4c8/0x680 
[ 104.282253][ T2399] ? getname_flags (fs/namei.c:205) 
[ 104.287383][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 104.291909][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 104.296173][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  104.301904][ T2399] RIP: 0033:0x7f089fb17087
[ 104.306171][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  104.313030][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  104.321272][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  104.329085][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  104.336900][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  104.344713][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  104.352523][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  104.360334][ T2399]  </TASK>
[  104.363210][ T2399] BUG: Bad page state in process dmesg  pfn:1be673
[  104.369551][ T2399] page:00000000d4ef2f42 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be673
[  104.379611][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  104.388209][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  104.395412][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  104.403825][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  104.412241][ T2399] page dumped because: non-NULL mapping
[  104.417628][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  104.484896][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  104.494868][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  104.503804][ T2399] Call Trace:
[  104.506945][ T2399]  <TASK>
[ 104.509737][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 104.514087][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 104.518353][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 104.523225][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 104.527831][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 104.532785][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 104.537568][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 104.542007][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 104.547306][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 104.552003][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 104.557128][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 104.561738][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 104.566350][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 104.570785][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 104.575393][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 104.580694][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 104.585045][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 104.589306][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 104.595300][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 104.600168][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 104.604606][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 104.608787][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 104.612876][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 104.617138][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 104.621750][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 104.626445][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 104.630360][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 104.635059][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 104.640888][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 104.645239][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 104.650368][ T2399] ? open_exec (fs/exec.c:1706) 
[ 104.654459][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 104.658722][ T2399] exec_binprm (fs/exec.c:1769) 
[ 104.662896][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 104.667766][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 104.672115][ T2399] do_execveat_common+0x4c8/0x680 
[ 104.677590][ T2399] ? getname_flags (fs/namei.c:205) 
[ 104.682715][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 104.687238][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 104.691500][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  104.697233][ T2399] RIP: 0033:0x7f089fb17087
[ 104.701494][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  104.708353][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  104.716596][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  104.724405][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  104.732210][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  104.740020][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  104.747828][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  104.755637][ T2399]  </TASK>
[  104.758516][ T2399] BUG: Bad page state in process dmesg  pfn:1be672
[  104.764851][ T2399] page:00000000ee79b635 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be672
[  104.774905][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  104.783503][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  104.790710][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  104.799124][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  104.807538][ T2399] page dumped because: non-NULL mapping
[  104.812924][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  104.880193][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  104.890162][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  104.899096][ T2399] Call Trace:
[  104.902231][ T2399]  <TASK>
[ 104.905028][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 104.909382][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 104.913642][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 104.918514][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 104.923134][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 104.928090][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 104.932871][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 104.937307][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 104.942608][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 104.947306][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 104.952433][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 104.957043][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 104.961652][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 104.966094][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 104.970699][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 104.976002][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 104.980352][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 104.984615][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 104.990610][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 104.995476][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 104.999913][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 105.004089][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 105.008178][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 105.012441][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 105.017056][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 105.021751][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 105.025672][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 105.030368][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 105.036188][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 105.040538][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 105.045664][ T2399] ? open_exec (fs/exec.c:1706) 
[ 105.049756][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 105.054021][ T2399] exec_binprm (fs/exec.c:1769) 
[ 105.058199][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 105.063064][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 105.067416][ T2399] do_execveat_common+0x4c8/0x680 
[ 105.072890][ T2399] ? getname_flags (fs/namei.c:205) 
[ 105.078021][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 105.082544][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 105.086809][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  105.092542][ T2399] RIP: 0033:0x7f089fb17087
[ 105.096804][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  105.103661][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  105.111907][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  105.119717][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  105.127530][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  105.135338][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  105.143149][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  105.150955][ T2399]  </TASK>
[  105.153834][ T2399] BUG: Bad page state in process dmesg  pfn:1be7b0
[  105.160174][ T2399] page:00000000408161c9 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7b0
[  105.170229][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  105.178826][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  105.186028][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  105.194442][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  105.202856][ T2399] page dumped because: non-NULL mapping
[  105.208239][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  105.275537][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  105.285508][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  105.294442][ T2399] Call Trace:
[  105.297583][ T2399]  <TASK>
[ 105.300377][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 105.304730][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 105.308994][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 105.313864][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 105.318476][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 105.323434][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 105.328217][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 105.332653][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 105.337956][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 105.342653][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 105.347780][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 105.352391][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 105.356996][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 105.361434][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 105.366041][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 105.371345][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 105.375696][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 105.379960][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 105.385956][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 105.390825][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 105.395263][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 105.399443][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 105.403535][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 105.407802][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 105.412408][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 105.417106][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 105.421021][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 105.425719][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 105.431541][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 105.435890][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 105.441022][ T2399] ? open_exec (fs/exec.c:1706) 
[ 105.445111][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 105.449373][ T2399] exec_binprm (fs/exec.c:1769) 
[ 105.453553][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 105.458423][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 105.462771][ T2399] do_execveat_common+0x4c8/0x680 
[ 105.468248][ T2399] ? getname_flags (fs/namei.c:205) 
[ 105.473379][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 105.477899][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 105.482163][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  105.487896][ T2399] RIP: 0033:0x7f089fb17087
[ 105.492161][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  105.499020][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  105.507262][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  105.515069][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  105.522880][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  105.530692][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  105.538501][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  105.546310][ T2399]  </TASK>
[  105.549183][ T2399] BUG: Bad page state in process dmesg  pfn:1be83f
[  105.555524][ T2399] page:00000000c2f97082 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83f
[  105.565578][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  105.574163][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  105.581368][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  105.589783][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  105.598195][ T2399] page dumped because: non-NULL mapping
[  105.603579][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  105.670859][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  105.680827][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  105.689764][ T2399] Call Trace:
[  105.692902][ T2399]  <TASK>
[ 105.695697][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 105.700050][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 105.704313][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 105.709184][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 105.713793][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 105.718747][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 105.723530][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 105.727966][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 105.733265][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 105.737965][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 105.743098][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 105.747707][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 105.752314][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 105.756752][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 105.761363][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 105.766669][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 105.771025][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 105.775289][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 105.781284][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 105.786152][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 105.790590][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 105.794772][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 105.798865][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 105.803130][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 105.807742][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 105.812437][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 105.816355][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 105.821054][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 105.826874][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 105.831221][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 105.836349][ T2399] ? open_exec (fs/exec.c:1706) 
[ 105.840439][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 105.844704][ T2399] exec_binprm (fs/exec.c:1769) 
[ 105.848881][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 105.853749][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 105.858101][ T2399] do_execveat_common+0x4c8/0x680 
[ 105.863575][ T2399] ? getname_flags (fs/namei.c:205) 
[ 105.868702][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 105.873227][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 105.877489][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  105.883222][ T2399] RIP: 0033:0x7f089fb17087
[ 105.887489][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  105.894348][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  105.902590][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  105.910400][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  105.918207][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  105.926019][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  105.933829][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  105.941643][ T2399]  </TASK>
[  105.944516][ T2399] BUG: Bad page state in process dmesg  pfn:1be83e
[  105.950855][ T2399] page:00000000d24fd54f refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83e
[  105.960913][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  105.969502][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  105.976709][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  105.985123][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  105.993534][ T2399] page dumped because: non-NULL mapping
[  105.998921][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  106.066168][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  106.076142][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  106.085071][ T2399] Call Trace:
[  106.088208][ T2399]  <TASK>
[ 106.091000][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 106.095350][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 106.099611][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 106.104481][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 106.109086][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 106.114042][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 106.118824][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 106.123265][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 106.128567][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 106.133264][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 106.138389][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 106.142997][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 106.147606][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 106.152041][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 106.156649][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 106.161947][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 106.166300][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 106.170565][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 106.176558][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 106.181426][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 106.185863][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 106.190038][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 106.194130][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 106.198390][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 106.202999][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 106.207694][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 106.211609][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 106.216305][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 106.222121][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 106.226467][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 106.231595][ T2399] ? open_exec (fs/exec.c:1706) 
[ 106.235684][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 106.239946][ T2399] exec_binprm (fs/exec.c:1769) 
[ 106.244120][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 106.248987][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 106.253338][ T2399] do_execveat_common+0x4c8/0x680 
[ 106.258810][ T2399] ? getname_flags (fs/namei.c:205) 
[ 106.263940][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 106.268460][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 106.272721][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  106.278457][ T2399] RIP: 0033:0x7f089fb17087
[ 106.282718][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  106.289577][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  106.297821][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  106.305629][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  106.313441][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  106.321254][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  106.329060][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  106.336867][ T2399]  </TASK>
[  106.339746][ T2399] BUG: Bad page state in process dmesg  pfn:1be83d
[  106.346083][ T2399] page:000000003ef7fe46 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83d
[  106.356144][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  106.364728][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  106.371929][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  106.380347][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  106.388760][ T2399] page dumped because: non-NULL mapping
[  106.394146][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  106.461407][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  106.471379][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  106.480313][ T2399] Call Trace:
[  106.483453][ T2399]  <TASK>
[ 106.486242][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 106.490595][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 106.494858][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 106.499727][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 106.504342][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 106.509293][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 106.514077][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 106.518510][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 106.523809][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 106.528501][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 106.533629][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 106.538243][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 106.542846][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 106.547279][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 106.551893][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 106.557190][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 106.561538][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 106.565802][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 106.571793][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 106.576658][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 106.581093][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 106.585270][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 106.589359][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 106.593618][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 106.598232][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 106.602926][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 106.606844][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 106.611540][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 106.617356][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 106.621707][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 106.626833][ T2399] ? open_exec (fs/exec.c:1706) 
[ 106.630923][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 106.635185][ T2399] exec_binprm (fs/exec.c:1769) 
[ 106.639356][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 106.644227][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 106.648573][ T2399] do_execveat_common+0x4c8/0x680 
[ 106.654044][ T2399] ? getname_flags (fs/namei.c:205) 
[ 106.659172][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 106.663693][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 106.667954][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  106.673682][ T2399] RIP: 0033:0x7f089fb17087
[ 106.677946][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  106.684802][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  106.693041][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  106.700847][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  106.708654][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  106.716460][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  106.724265][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  106.732071][ T2399]  </TASK>
[  106.734947][ T2399] BUG: Bad page state in process dmesg  pfn:1be83c
[  106.741284][ T2399] page:00000000f71df2f6 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83c
[  106.751341][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  106.759929][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  106.767134][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  106.775545][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  106.783956][ T2399] page dumped because: non-NULL mapping
[  106.789342][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  106.856580][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  106.866547][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  106.875479][ T2399] Call Trace:
[  106.878617][ T2399]  <TASK>
[ 106.881408][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 106.885761][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 106.890025][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 106.894894][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 106.899505][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 106.904461][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 106.909244][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 106.913679][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 106.918979][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 106.923673][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 106.928801][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 106.933409][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 106.938018][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 106.942456][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 106.947061][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 106.952359][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 106.956710][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 106.960971][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 106.966965][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 106.971828][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 106.976265][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 106.980439][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 106.984531][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 106.988792][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 106.993404][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 106.998099][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 107.002017][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 107.006715][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 107.012534][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 107.016886][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 107.022011][ T2399] ? open_exec (fs/exec.c:1706) 
[ 107.026100][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 107.030362][ T2399] exec_binprm (fs/exec.c:1769) 
[ 107.034539][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 107.039407][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 107.043757][ T2399] do_execveat_common+0x4c8/0x680 
[ 107.049231][ T2399] ? getname_flags (fs/namei.c:205) 
[ 107.054356][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 107.058876][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 107.063139][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  107.068869][ T2399] RIP: 0033:0x7f089fb17087
[ 107.073134][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  107.079989][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  107.088223][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  107.096030][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  107.103837][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  107.111642][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  107.119452][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  107.127258][ T2399]  </TASK>
[  107.130132][ T2399] BUG: Bad page state in process dmesg  pfn:1be83b
[  107.136476][ T2399] page:000000002b1c8a2e refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83b
[  107.146526][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  107.155115][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  107.162318][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  107.170726][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  107.179142][ T2399] page dumped because: non-NULL mapping
[  107.184526][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  107.251789][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  107.261758][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  107.270686][ T2399] Call Trace:
[  107.273821][ T2399]  <TASK>
[ 107.276615][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 107.280960][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 107.285221][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 107.290096][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 107.294702][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 107.299660][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 107.304440][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 107.308880][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 107.314179][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 107.318873][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 107.324004][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 107.328610][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 107.333219][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 107.337658][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 107.342266][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 107.347567][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 107.351917][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 107.356178][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 107.362172][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 107.367038][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 107.371472][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 107.375652][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 107.379736][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 107.384003][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 107.388615][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 107.393313][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 107.397226][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 107.401922][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 107.407744][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 107.412090][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 107.417222][ T2399] ? open_exec (fs/exec.c:1706) 
[ 107.421308][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 107.425573][ T2399] exec_binprm (fs/exec.c:1769) 
[ 107.429746][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 107.434611][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 107.438960][ T2399] do_execveat_common+0x4c8/0x680 
[ 107.444432][ T2399] ? getname_flags (fs/namei.c:205) 
[ 107.449556][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 107.454076][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 107.458338][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  107.464077][ T2399] RIP: 0033:0x7f089fb17087
[ 107.468340][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  107.475197][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  107.483446][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  107.491251][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  107.499063][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  107.506874][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  107.514679][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  107.522490][ T2399]  </TASK>
[  107.525366][ T2399] BUG: Bad page state in process dmesg  pfn:1be83a
[  107.531707][ T2399] page:0000000086fdc037 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83a
[  107.541760][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  107.550341][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  107.557544][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  107.565952][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  107.574365][ T2399] page dumped because: non-NULL mapping
[  107.579749][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  107.646976][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  107.656947][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  107.665879][ T2399] Call Trace:
[  107.669019][ T2399]  <TASK>
[ 107.671810][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 107.676161][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 107.680420][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 107.685290][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 107.689902][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 107.694854][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 107.699635][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 107.704070][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 107.709370][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 107.714068][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 107.719194][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 107.723799][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 107.728411][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 107.732846][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 107.737449][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 107.742750][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 107.747097][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 107.751359][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 107.757349][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 107.762217][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 107.766654][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 107.770826][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 107.774918][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 107.779175][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 107.783782][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 107.788474][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 107.792392][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 107.797091][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 107.802912][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 107.807262][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 107.812390][ T2399] ? open_exec (fs/exec.c:1706) 
[ 107.816476][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 107.820741][ T2399] exec_binprm (fs/exec.c:1769) 
[ 107.824915][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 107.829786][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 107.834138][ T2399] do_execveat_common+0x4c8/0x680 
[ 107.839610][ T2399] ? getname_flags (fs/namei.c:205) 
[ 107.844735][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 107.849256][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 107.853519][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  107.859249][ T2399] RIP: 0033:0x7f089fb17087
[ 107.863515][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  107.870371][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  107.878615][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  107.886422][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  107.894222][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  107.902031][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  107.909840][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  107.917651][ T2399]  </TASK>
[  107.920527][ T2399] BUG: Bad page state in process dmesg  pfn:1be839
[  107.926865][ T2399] page:000000007e5c1c18 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be839
[  107.936919][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  107.945510][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  107.952713][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  107.961123][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  107.969534][ T2399] page dumped because: non-NULL mapping
[  107.974919][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  108.042165][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  108.052137][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  108.061074][ T2399] Call Trace:
[  108.064209][ T2399]  <TASK>
[ 108.067004][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 108.071354][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 108.075617][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 108.080484][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 108.085092][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 108.090046][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 108.094827][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 108.099262][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 108.104564][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 108.109256][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 108.114381][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 108.118991][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 108.123597][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 108.128033][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 108.132641][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 108.137944][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 108.142294][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 108.146558][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 108.152548][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 108.157416][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 108.161851][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 108.166026][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 108.170112][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 108.174376][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 108.178983][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 108.183675][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 108.187596][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 108.192289][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 108.198110][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 108.202462][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 108.207589][ T2399] ? open_exec (fs/exec.c:1706) 
[ 108.211674][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 108.215939][ T2399] exec_binprm (fs/exec.c:1769) 
[ 108.220113][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 108.224982][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 108.229328][ T2399] do_execveat_common+0x4c8/0x680 
[ 108.234803][ T2399] ? getname_flags (fs/namei.c:205) 
[ 108.239928][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 108.244451][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 108.248712][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  108.254437][ T2399] RIP: 0033:0x7f089fb17087
[ 108.258702][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  108.265553][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  108.273787][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  108.281592][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  108.289394][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  108.297196][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  108.305004][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  108.312812][ T2399]  </TASK>
[  108.315690][ T2399] BUG: Bad page state in process dmesg  pfn:1be838
[  108.322025][ T2399] page:000000005e15c0c5 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be838
[  108.332084][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  108.340678][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  108.347878][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  108.356290][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  108.364695][ T2399] page dumped because: non-NULL mapping
[  108.370083][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  108.437299][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  108.447268][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  108.456188][ T2399] Call Trace:
[  108.459326][ T2399]  <TASK>
[ 108.462115][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 108.466460][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 108.470718][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 108.475588][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 108.480191][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 108.485145][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 108.489930][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 108.494364][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 108.499666][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 108.504360][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 108.509490][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 108.514099][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 108.518708][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 108.523143][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 108.527751][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 108.533049][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 108.537400][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 108.541658][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 108.547651][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 108.552516][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 108.556956][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 108.561127][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 108.565222][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 108.569484][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 108.574097][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 108.578791][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 108.582706][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 108.587402][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 108.593221][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 108.597573][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 108.602701][ T2399] ? open_exec (fs/exec.c:1706) 
[ 108.606788][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 108.611047][ T2399] exec_binprm (fs/exec.c:1769) 
[ 108.615222][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 108.620088][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 108.624439][ T2399] do_execveat_common+0x4c8/0x680 
[ 108.629909][ T2399] ? getname_flags (fs/namei.c:205) 
[ 108.635031][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 108.639548][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 108.643813][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  108.649543][ T2399] RIP: 0033:0x7f089fb17087
[ 108.653811][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  108.660664][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  108.668905][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  108.676713][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  108.684520][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  108.692323][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  108.700128][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  108.707934][ T2399]  </TASK>
[  108.710808][ T2399] BUG: Bad page state in process dmesg  pfn:1be837
[  108.717141][ T2399] page:00000000097b92db refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be837
[  108.727198][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  108.735780][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  108.742976][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  108.751390][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  108.759795][ T2399] page dumped because: non-NULL mapping
[  108.765175][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  108.832409][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  108.842378][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  108.851309][ T2399] Call Trace:
[  108.854447][ T2399]  <TASK>
[ 108.857243][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 108.861591][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 108.865854][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 108.870723][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 108.875332][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 108.880281][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 108.885065][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 108.889501][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 108.894800][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 108.899495][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 108.904625][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 108.909234][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 108.913843][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 108.918274][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 108.922882][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 108.928182][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 108.932533][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 108.936791][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 108.942781][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 108.947647][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 108.952082][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 108.956256][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 108.960346][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 108.964608][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 108.969217][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 108.973905][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 108.977822][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 108.982518][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 108.988336][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 108.992683][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 108.997814][ T2399] ? open_exec (fs/exec.c:1706) 
[ 109.001907][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 109.006166][ T2399] exec_binprm (fs/exec.c:1769) 
[ 109.010343][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 109.015214][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 109.019563][ T2399] do_execveat_common+0x4c8/0x680 
[ 109.025032][ T2399] ? getname_flags (fs/namei.c:205) 
[ 109.030160][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 109.034681][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 109.038940][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  109.044673][ T2399] RIP: 0033:0x7f089fb17087
[ 109.048937][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  109.055793][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  109.064032][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  109.071844][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  109.079657][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  109.087460][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  109.095269][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  109.103081][ T2399]  </TASK>
[  109.105958][ T2399] BUG: Bad page state in process dmesg  pfn:1be836
[  109.112287][ T2399] page:000000006bb9da6f refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be836
[  109.122342][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  109.130941][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  109.138140][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  109.146551][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  109.154964][ T2399] page dumped because: non-NULL mapping
[  109.160351][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  109.227598][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  109.237572][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  109.246508][ T2399] Call Trace:
[  109.249644][ T2399]  <TASK>
[ 109.252438][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 109.256785][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 109.261048][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 109.265921][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 109.270525][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 109.275481][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 109.280264][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 109.284696][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 109.289996][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 109.294696][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 109.299824][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 109.304434][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 109.309040][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 109.313478][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 109.318080][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 109.323376][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 109.327723][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 109.331988][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 109.337984][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 109.342846][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 109.347281][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 109.351456][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 109.355545][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 109.359807][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 109.364414][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 109.369117][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 109.373029][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 109.377727][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 109.383540][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 109.387886][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 109.393008][ T2399] ? open_exec (fs/exec.c:1706) 
[ 109.397099][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 109.401358][ T2399] exec_binprm (fs/exec.c:1769) 
[ 109.405530][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 109.410389][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 109.414735][ T2399] do_execveat_common+0x4c8/0x680 
[ 109.420209][ T2399] ? getname_flags (fs/namei.c:205) 
[ 109.425336][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 109.429857][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 109.434119][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  109.439849][ T2399] RIP: 0033:0x7f089fb17087
[ 109.444111][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  109.450970][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  109.459214][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  109.467021][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  109.474831][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  109.482643][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  109.490447][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  109.498248][ T2399]  </TASK>
[  109.501121][ T2399] BUG: Bad page state in process dmesg  pfn:1be835
[  109.507462][ T2399] page:00000000c88ac0ed refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be835
[  109.517521][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  109.526100][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  109.533297][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  109.541711][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  109.550121][ T2399] page dumped because: non-NULL mapping
[  109.555508][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  109.622739][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  109.632708][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  109.641636][ T2399] Call Trace:
[  109.644771][ T2399]  <TASK>
[ 109.647563][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 109.651916][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 109.656180][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 109.661047][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 109.665656][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 109.670615][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 109.675398][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 109.679836][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 109.685138][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 109.689830][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 109.694952][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 109.699561][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 109.704164][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 109.708600][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 109.713211][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 109.718514][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 109.722861][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 109.727120][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 109.733112][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 109.737978][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 109.742410][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 109.746587][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 109.750678][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 109.754937][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 109.759546][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 109.764240][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 109.768155][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 109.772852][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 109.778671][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 109.783023][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 109.788151][ T2399] ? open_exec (fs/exec.c:1706) 
[ 109.792240][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 109.796502][ T2399] exec_binprm (fs/exec.c:1769) 
[ 109.800679][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 109.805547][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 109.809890][ T2399] do_execveat_common+0x4c8/0x680 
[ 109.815362][ T2399] ? getname_flags (fs/namei.c:205) 
[ 109.820484][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 109.825004][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 109.829271][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  109.835002][ T2399] RIP: 0033:0x7f089fb17087
[ 109.839266][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  109.846125][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  109.854359][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  109.862171][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  109.869976][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  109.877780][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  109.885586][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  109.893387][ T2399]  </TASK>
[  109.896264][ T2399] BUG: Bad page state in process dmesg  pfn:1be834
[  109.902600][ T2399] page:000000000287d1cd refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be834
[  109.912649][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  109.921236][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  109.928431][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  109.936841][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  109.945246][ T2399] page dumped because: non-NULL mapping
[  109.950628][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  110.017855][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  110.027830][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  110.036763][ T2399] Call Trace:
[  110.039898][ T2399]  <TASK>
[ 110.042693][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 110.047046][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 110.051303][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 110.056168][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 110.060771][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 110.065733][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 110.070513][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 110.074946][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 110.080248][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 110.084942][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 110.090075][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 110.094687][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 110.099291][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 110.103724][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 110.108329][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 110.113629][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 110.117978][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 110.122237][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 110.128229][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 110.133095][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 110.137528][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 110.141705][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 110.145799][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 110.150058][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 110.154665][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 110.159359][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 110.163274][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 110.167975][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 110.173796][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 110.178151][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 110.183274][ T2399] ? open_exec (fs/exec.c:1706) 
[ 110.187361][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 110.191622][ T2399] exec_binprm (fs/exec.c:1769) 
[ 110.195796][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 110.200661][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 110.205013][ T2399] do_execveat_common+0x4c8/0x680 
[ 110.210484][ T2399] ? getname_flags (fs/namei.c:205) 
[ 110.215609][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 110.220136][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 110.224397][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  110.230128][ T2399] RIP: 0033:0x7f089fb17087
[ 110.234386][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  110.241248][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  110.249490][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  110.257300][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  110.265105][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  110.272914][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  110.280722][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  110.288530][ T2399]  </TASK>
[  110.291405][ T2399] BUG: Bad page state in process dmesg  pfn:1be736
[  110.297741][ T2399] page:000000009ccecaff refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be736
[  110.307792][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  110.316385][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  110.323594][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  110.332004][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  110.340420][ T2399] page dumped because: non-NULL mapping
[  110.345802][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  110.413072][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  110.423047][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  110.431984][ T2399] Call Trace:
[  110.435119][ T2399]  <TASK>
[ 110.437910][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 110.442261][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 110.446521][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 110.451393][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 110.456002][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 110.460956][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 110.465739][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 110.470173][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 110.475475][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 110.480170][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 110.485298][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 110.489908][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 110.494513][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 110.498951][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 110.503557][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 110.508855][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 110.513208][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 110.517466][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 110.523459][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 110.528325][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 110.532762][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 110.536939][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 110.541030][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 110.545289][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 110.549901][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 110.554599][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 110.558519][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 110.563213][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 110.569030][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 110.573379][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 110.578505][ T2399] ? open_exec (fs/exec.c:1706) 
[ 110.582591][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 110.586856][ T2399] exec_binprm (fs/exec.c:1769) 
[ 110.591026][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 110.595891][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 110.600235][ T2399] do_execveat_common+0x4c8/0x680 
[ 110.605710][ T2399] ? getname_flags (fs/namei.c:205) 
[ 110.610841][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 110.615361][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 110.619621][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  110.625354][ T2399] RIP: 0033:0x7f089fb17087
[ 110.629618][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  110.636472][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  110.644711][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  110.652516][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  110.660326][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  110.668134][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  110.675943][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  110.683752][ T2399]  </TASK>
[  110.686628][ T2399] BUG: Bad page state in process dmesg  pfn:1be735
[  110.692967][ T2399] page:000000007ad36b12 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be735
[  110.703021][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  110.711611][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  110.718813][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  110.727225][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  110.735640][ T2399] page dumped because: non-NULL mapping
[  110.741027][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  110.808310][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  110.818281][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  110.827218][ T2399] Call Trace:
[  110.830359][ T2399]  <TASK>
[ 110.833148][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 110.837498][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 110.841762][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 110.846634][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 110.851243][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 110.856203][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 110.860982][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 110.865421][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 110.870722][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 110.875416][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 110.880547][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 110.885156][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 110.889765][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 110.894205][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 110.898813][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 110.904111][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 110.908462][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 110.912726][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 110.918718][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 110.923589][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 110.928025][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 110.932205][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 110.936297][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 110.940564][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 110.945176][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 110.949871][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 110.953787][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 110.958486][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 110.964303][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 110.968647][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 110.973778][ T2399] ? open_exec (fs/exec.c:1706) 
[ 110.977873][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 110.982137][ T2399] exec_binprm (fs/exec.c:1769) 
[ 110.986319][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 110.991192][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 110.995546][ T2399] do_execveat_common+0x4c8/0x680 
[ 111.001024][ T2399] ? getname_flags (fs/namei.c:205) 
[ 111.006157][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 111.010677][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 111.014936][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  111.020670][ T2399] RIP: 0033:0x7f089fb17087
[ 111.024931][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  111.031784][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  111.040026][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  111.047832][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  111.055639][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  111.063455][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  111.071259][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  111.079076][ T2399]  </TASK>
[  111.081949][ T2399] BUG: Bad page state in process dmesg  pfn:1be832
[  111.088292][ T2399] page:0000000021aa85b8 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be832
[  111.098353][ T2399] aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
[  111.106945][ T2399] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  111.114153][ T2399] raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
[  111.122565][ T2399] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[  111.130980][ T2399] page dumped because: non-NULL mapping
[  111.136365][ T2399] Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
[  111.203625][ T2399] CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  111.213603][ T2399] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  111.222537][ T2399] Call Trace:
[  111.225676][ T2399]  <TASK>
[ 111.228470][ T2399] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 111.232826][ T2399] bad_page.cold (mm/page_alloc.c:719) 
[ 111.237084][ T2399] free_pcppages_bulk (mm/page_alloc.c:1610) 
[ 111.241954][ T2399] free_unref_page (include/linux/spinlock.h:405 mm/page_alloc.c:3506) 
[ 111.246563][ T2399] __unfreeze_partials (mm/slub.c:2581) 
[ 111.251520][ T2399] ? free_unref_page (arch/x86/include/asm/preempt.h:85 mm/page_alloc.c:3506) 
[ 111.256299][ T2399] qlist_free_all (mm/kasan/quarantine.c:182) 
[ 111.260733][ T2399] kasan_quarantine_reduce (include/linux/srcu.h:189 mm/kasan/quarantine.c:295) 
[ 111.266035][ T2399] __kasan_slab_alloc (mm/kasan/common.c:302) 
[ 111.270726][ T2399] kmem_cache_alloc_bulk (mm/slab.h:737 mm/slub.c:3854) 
[ 111.275854][ T2399] mas_alloc_nodes (lib/maple_tree.c:1257) 
[ 111.280467][ T2399] mas_preallocate (lib/maple_tree.c:1316 lib/maple_tree.c:5719) 
[ 111.285076][ T2399] __vma_adjust (mm/mmap.c:715) 
[ 111.289508][ T2399] ? vm_area_alloc (kernel/fork.c:465) 
[ 111.294119][ T2399] ? __ia32_sys_mmap_pgoff (mm/mmap.c:1502) 
[ 111.299423][ T2399] ? vma_expand (mm/mmap.c:619) 
[ 111.303771][ T2399] __split_vma (include/linux/mm.h:2663 mm/mmap.c:2239) 
[ 111.308031][ T2399] do_mas_align_munmap+0x1f0/0xec0 
[ 111.314020][ T2399] ? security_mmap_addr (security/security.c:1604 (discriminator 13)) 
[ 111.318882][ T2399] ? __split_vma (mm/mmap.c:2301) 
[ 111.323321][ T2399] ? do_mmap (mm/mmap.c:1411) 
[ 111.327499][ T2399] ? mas_find (lib/maple_tree.c:6006) 
[ 111.331591][ T2399] __vm_munmap (mm/mmap.c:2775) 
[ 111.335854][ T2399] ? do_mas_munmap (mm/mmap.c:2766) 
[ 111.340461][ T2399] ? get_random_u32 (drivers/char/random.c:511) 
[ 111.345156][ T2399] elf_map (fs/binfmt_elf.c:392) 
[ 111.349072][ T2399] load_elf_binary (include/linux/instrumented.h:72 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:118 fs/binfmt_elf.c:1168) 
[ 111.353773][ T2399] ? load_elf_interp+0xa80/0xa80 
[ 111.359601][ T2399] ? kernel_read (fs/read_write.c:443) 
[ 111.363951][ T2399] search_binary_handler (fs/exec.c:1727) 
[ 111.369077][ T2399] ? open_exec (fs/exec.c:1706) 
[ 111.373170][ T2399] ? nr_iowait (kernel/sched/core.c:5302) 
[ 111.377435][ T2399] exec_binprm (fs/exec.c:1769) 
[ 111.381615][ T2399] bprm_execve (include/linux/slab.h:576 include/linux/slab.h:712 fs/exec.c:1508) 
[ 111.386487][ T2399] ? bprm_execve (fs/exec.c:1474 fs/exec.c:1805) 
[ 111.390836][ T2399] do_execveat_common+0x4c8/0x680 
[ 111.396314][ T2399] ? getname_flags (fs/namei.c:205) 
[ 111.401442][ T2399] __x64_sys_execve (fs/exec.c:2087) 
[ 111.405957][ T2399] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 111.410222][ T2399] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  111.415950][ T2399] RIP: 0033:0x7f089fb17087
[ 111.420218][ T2399] Code: Unable to access opcode bytes at 0x7f089fb1705d.

Code starting with the faulting instruction
===========================================
[  111.427073][ T2399] RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  111.435310][ T2399] RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
[  111.443111][ T2399] RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
[  111.450917][ T2399] RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
[  111.458724][ T2399] R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
[  111.466531][ T2399] R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
[  111.474342][ T2399]  </TASK>
[  111.775877][ T2351] ------------[ cut here ]------------
[  111.781197][ T2351] kernel BUG at mm/rmap.c:1041!
[  111.785907][ T2351] invalid opcode: 0000 [#1] SMP KASAN PTI
[  111.791471][ T2351] CPU: 4 PID: 2351 Comm: dbench Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
[  111.801533][ T2351] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[ 111.810471][ T2351] RIP: 0010:folio_mkclean (mm/rmap.c:1041 (discriminator 1)) 
[ 111.815695][ T2351] Code: 03 74 29 a8 01 48 8d 74 24 30 ba 00 00 00 00 48 89 ef 75 0f e8 ce fa ff ff 44 8b 44 24 20 e9 63 ff ff ff e8 3f f6 ff ff eb ef <0f> 0b 48 8d 74 24 30 48 89 ef e8 ae 0a 0b 00 eb de 48 89 ef e8 24
All code
========
   0:	03 74 29 a8          	add    -0x58(%rcx,%rbp,1),%esi
   4:	01 48 8d             	add    %ecx,-0x73(%rax)
   7:	74 24                	je     0x2d
   9:	30 ba 00 00 00 00    	xor    %bh,0x0(%rdx)
   f:	48 89 ef             	mov    %rbp,%rdi
  12:	75 0f                	jne    0x23
  14:	e8 ce fa ff ff       	callq  0xfffffffffffffae7
  19:	44 8b 44 24 20       	mov    0x20(%rsp),%r8d
  1e:	e9 63 ff ff ff       	jmpq   0xffffffffffffff86
  23:	e8 3f f6 ff ff       	callq  0xfffffffffffff667
  28:	eb ef                	jmp    0x19
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 ae 0a 0b 00       	callq  0xb0ae7
  39:	eb de                	jmp    0x19
  3b:	48 89 ef             	mov    %rbp,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	24                   	.byte 0x24

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
   7:	48 89 ef             	mov    %rbp,%rdi
   a:	e8 ae 0a 0b 00       	callq  0xb0abd
   f:	eb de                	jmp    0xffffffffffffffef
  11:	48 89 ef             	mov    %rbp,%rdi
  14:	e8                   	.byte 0xe8
  15:	24                   	.byte 0x24
[  111.835102][ T2351] RSP: 0018:ffffc90002e07898 EFLAGS: 00010246
[  111.841018][ T2351] RAX: 0017ffffc0000000 RBX: 1ffff920005c0f13 RCX: ffffffff8172db72
[  111.848823][ T2351] RDX: fffff94000afe371 RSI: 0000000000000008 RDI: ffffea00057f1b80
[  111.856644][ T2351] RBP: ffffea00057f1b80 R08: 0000000000000000 R09: ffffea00057f1b87
[  111.864467][ T2351] R10: fffff94000afe370 R11: 0000000000000001 R12: dffffc0000000000
[  111.872284][ T2351] R13: dffffc0000000000 R14: ffffea00057f1b80 R15: ffffc90002e07b90
[  111.880106][ T2351] FS:  00007f294a667740(0000) GS:ffff88837d600000(0000) knlGS:0000000000000000
[  111.888874][ T2351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  111.895309][ T2351] CR2: 0000564db5b63000 CR3: 0000000434706002 CR4: 00000000003706e0
[  111.903119][ T2351] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  111.910935][ T2351] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  111.918746][ T2351] Call Trace:
[  111.921884][ T2351]  <TASK>
[ 111.924677][ T2351] ? rmap_walk_file (mm/rmap.c:1032) 
[ 111.929384][ T2351] ? page_vma_mkclean_one+0x5c0/0x5c0 
[ 111.935643][ T2351] ? __traceiter_remove_migration_pte (mm/rmap.c:1024) 
[ 111.941737][ T2351] folio_clear_dirty_for_io (mm/page-writeback.c:2866) 
[ 111.947048][ T2351] ? folio_wait_writeback (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:520 mm/page-writeback.c:3036) 
[ 111.952182][ T2351] wdata_prepare_pages (fs/cifs/file.c:2604 (discriminator 1)) cifs
[ 111.957807][ T2351] cifs_writepages (fs/cifs/file.c:2748) cifs
[ 111.963177][ T2351] ? wdata_alloc_and_fillpages (fs/cifs/file.c:2671) cifs
[ 111.969498][ T2351] ? cifs_readpage_worker (fs/cifs/file.c:4980) cifs
[ 111.975380][ T2351] ? balance_dirty_pages_ratelimited_flags (arch/x86/include/asm/jump_label.h:27 include/linux/backing-dev.h:168 mm/page-writeback.c:1893) 
[ 111.981977][ T2351] ? generic_perform_write (include/linux/uio.h:261 mm/filemap.c:3843) 
[ 111.987284][ T2351] do_writepages (mm/page-writeback.c:2471) 
[ 111.991722][ T2351] ? writeback_set_ratelimit (mm/page-writeback.c:2461) 
[ 111.997201][ T2351] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 112.002331][ T2351] ? __generic_file_write_iter (mm/filemap.c:3936) 
[ 112.007983][ T2351] ? cifs_put_writer (fs/cifs/misc.c:589) cifs
[ 112.013268][ T2351] ? cifs_strict_writev (fs/cifs/file.c:3703) cifs
[ 112.018983][ T2351] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 112.023598][ T2351] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 112.028728][ T2351] ? wbc_attach_and_unlock_inode (arch/x86/include/asm/jump_label.h:27 include/linux/backing-dev.h:168 fs/fs-writeback.c:694) 
[ 112.034467][ T2351] filemap_fdatawrite_wbc (mm/filemap.c:389 mm/filemap.c:378) 
[ 112.039685][ T2351] __filemap_fdatawrite_range (mm/filemap.c:413) 
[ 112.045159][ T2351] ? delete_from_page_cache_batch (mm/filemap.c:413) 
[ 112.051064][ T2351] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 112.055683][ T2351] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
[ 112.060821][ T2351] filemap_write_and_wait_range (mm/filemap.c:676) 
[ 112.066388][ T2351] cifs_flush (fs/cifs/file.c:3058) cifs
[ 112.071238][ T2351] filp_close (fs/open.c:1420) 
[ 112.075337][ T2351] __x64_sys_close (fs/open.c:1442 fs/open.c:1437 fs/open.c:1437) 
[ 112.079773][ T2351] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 112.084039][ T2351] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  112.089774][ T2351] RIP: 0033:0x7f294a757083
[ 112.094038][ T2351] Code: e9 37 ff ff ff e8 6d f5 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
All code
========
   0:	e9 37 ff ff ff       	jmpq   0xffffffffffffff3c
   5:	e8 6d f5 01 00       	callq  0x1f577
   a:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  11:	00 00 00 
  14:	0f 1f 00             	nopl   (%rax)
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 03 00 00 00       	mov    $0x3,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 45                	ja     0x77
  32:	c3                   	retq   
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 18          	sub    $0x18,%rsp
  3b:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 45                	ja     0x4d
   8:	c3                   	retq   
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 18          	sub    $0x18,%rsp
  11:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  15:	e8                   	.byte 0xe8


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
https://01.org/lkp



--TVg/s+Co+epUfstr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc1-00014-g68e9d45f5b0e"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
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
CONFIG_WATCH_QUEUE=y
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
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_DEFAULT_ON=y
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
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
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
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
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
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
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
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
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
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
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
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
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
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
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
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
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
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
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
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
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
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
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
CONFIG_X86_POWERNOW_K8=m
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
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
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
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
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
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
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

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
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
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
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
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
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
CONFIG_NFT_OBJREF=m
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
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

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

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
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
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
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
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
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
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
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
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
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
CONFIG_NET_EMATCH_IPSET=m
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
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
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
CONFIG_PCI_MSI_IRQ_DOMAIN=y
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
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
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
CONFIG_DEVTMPFS_MOUNT=y
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
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
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
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
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
# CONFIG_PARPORT_AX88796 is not set
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
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
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
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
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

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
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
# CONFIG_SCSI_EFCT is not set
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
CONFIG_MD_CLUSTER=m
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
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
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
CONFIG_DUMMY=m
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
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
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
# CONFIG_IXGB is not set
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
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
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
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
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
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
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
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

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
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
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
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
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
CONFIG_SERIAL_JSM=m
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
# CONFIG_TTY_PRINTK is not set
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
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
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
CONFIG_I2C_SMBUS=m
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
CONFIG_I2C_I801=m
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
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
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
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
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
CONFIG_GPIO_SYSFS=y
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
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
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
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
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
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
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
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
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
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
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
# CONFIG_MFD_INTEL_M10_BMC is not set
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

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
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
# CONFIG_DRM_I915_GVT_KVMGT is not set

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
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
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
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

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

# CONFIG_SOUND is not set

#
# HID support
#
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
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
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
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
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
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
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
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
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
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

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
# CONFIG_MMC_REALTEK_PCI is not set
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
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
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
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
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
CONFIG_EDAC_I5000=m
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
CONFIG_RTC_DRV_V3020=m

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
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
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
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
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
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
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
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
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
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
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
CONFIG_HWSPINLOCK=y

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
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
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
# CONFIG_IDLE_INJECT is not set
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
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
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
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
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
CONFIG_PRINT_QUOTA_WARNING=y
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
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
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
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
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
CONFIG_MINIX_FS=m
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
CONFIG_NFSD_V2_ACL=y
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
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
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
# CONFIG_CIFS_FSCACHE is not set
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
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
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
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
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
CONFIG_CRYPTO_GF128MUL=y
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
CONFIG_CRYPTO_USER_API_HASH=y
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

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
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
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
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
CONFIG_CMA_SIZE_MBYTES=0
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
# CONFIG_FORCE_NR_CPUS is not set
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
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
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
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
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
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
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
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
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
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
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
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--TVg/s+Co+epUfstr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='xfstests'
	export testcase='xfstests'
	export category='functional'
	export need_memory='1G'
	export job_origin='xfstests-cifs.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='lkp-skl-d07'
	export tbox_group='lkp-skl-d07'
	export submit_id='6352c1bbf4463251609e2192'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml'
	export id='fb3de44fc29f0d95db6220dc53d3b73cdf003f4c'
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
EXT4_FS'
	export commit='68e9d45f5b0e8ca96c02dc221a65e54d859303ff'
	export ucode='0xf0'
	export bisect_dmesg=true
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2022-10-21 23:58:52 +0800'
	export _id='6352c1bbf4463251609e2192'
	export _rt='/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='21ef9e7031c1b2d51db5b2bfba2019e7fa3451cf'
	export base_commit='9abf2313adc1ca1b6180c508c25f22f9395cc780'
	export branch='linux-review/Vishal-Moola-Oracle/Convert-to-filemap_get_folios_tag/20221018-042652'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/vmlinuz-6.1.0-rc1-00014-g68e9d45f5b0e
branch=linux-review/Vishal-Moola-Oracle/Convert-to-filemap_get_folios_tag/20221018-042652
job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=68e9d45f5b0e8ca96c02dc221a65e54d859303ff
max_uptime=2100
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs2_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20221017.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-5a5e419-1_20221017.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export stop_repeat_if_found='dmesg.BUG:Bad_page_state_in_process'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/vmlinuz-6.1.0-rc1-00014-g68e9d45f5b0e'
	export dequeue_time='2022-10-22 00:11:47 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.cgz'

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

	run_setup fs='ext4' $LKP_SRC/setup/fs

	run_setup fs='smbv2' $LKP_SRC/setup/fs2

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='generic-group-12' $LKP_SRC/tests/wrapper xfstests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='generic-group-12' $LKP_SRC/stats/wrapper xfstests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time xfstests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--TVg/s+Co+epUfstr
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
CLIHAAHCtAKguBUGkIJIscRn+wIAAAAABFla

--TVg/s+Co+epUfstr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="xfstests"

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
Linux version 6.1.0-rc1-00014-g68e9d45f5b0e (kbuild@8878e37023cc) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP Fri Oct 21 07:20:04 CST 2022
Command line: ip=::::lkp-skl-d07::dhcp root=/dev/ram0 RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/vmlinuz-6.1.0-rc1-00014-g68e9d45f5b0e branch=linux-review/Vishal-Moola-Oracle/Convert-to-filemap_get_folios_tag/20221018-042652 job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=68e9d45f5b0e8ca96c02dc221a65e54d859303ff max_uptime=2100 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 pr
KERNEL supported cpus:
Intel GenuineIntel
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
signal: max sigframe size: 2032
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000100-0x0000000000091bff] usable
BIOS-e820: [mem 0x0000000000091c00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000b30fafff] usable
BIOS-e820: [mem 0x00000000b30fb000-0x00000000b3c7efff] reserved
BIOS-e820: [mem 0x00000000b3c7f000-0x00000000b3e7efff] ACPI NVS
BIOS-e820: [mem 0x00000000b3e7f000-0x00000000b3efefff] ACPI data
BIOS-e820: [mem 0x00000000b3eff000-0x00000000b3efffff] usable
BIOS-e820: [mem 0x00000000b3f00000-0x00000000be7fffff] reserved
BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
BIOS-e820: [mem 0x00000000fed84000-0x00000000fed84fff] reserved
BIOS-e820: [mem 0x00000000fedb0000-0x00000000fedbffff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff700000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000043f7fffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
SMBIOS 2.7 present.
DMI: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
tsc: Detected 3400.000 MHz processor
tsc: Detected 3399.906 MHz TSC
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x43f800 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0xb3f00 max_arch_pfn = 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
Scan for SMP in [mem 0x00091c00-0x00091fff]
Using GB pages for direct mapping
RAMDISK: [mem 0x41dff7000-0x43a7fffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000FBE30 000024 (v02 HPQOEM)
ACPI: XSDT 0x00000000B3EFD0E8 0000B4 (v01 HPQOEM SLIC-WKS 00000000      01000013)
ACPI: FACP 0x00000000B3EF1000 0000F4 (v05 HPQOEM SLIC-WKS 00000000 HP   00000001)
ACPI: DSDT 0x00000000B3ECD000 0209E1 (v02 HPQOEM 802E     00000000 INTL 20121018)
ACPI: FACS 0x00000000B3E6A000 000040
ACPI: SSDT 0x00000000B3EFC000 000108 (v02 HP     ShmTable 00000001 INTL 20121018)
ACPI: TCPA 0x00000000B3EFB000 000032 (v02 HPQOEM EDK2     00000002      01000013)
ACPI: SSDT 0x00000000B3EFA000 0003B8 (v02 HPQOEM TcgTable 00001000 INTL 20121018)
ACPI: UEFI 0x00000000B3E7A000 000042 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: SSDT 0x00000000B3EF4000 0051FA (v02 SaSsdt SaSsdt   00003000 INTL 20121018)
ACPI: SSDT 0x00000000B3EF3000 0005B1 (v01 Intel  PerfTune 00001000 INTL 20121018)
ACPI: WSMT 0x00000000B3EF2000 000028 (v01 HPQOEM 802E     00000001 HP   00000001)
ACPI: HPET 0x00000000B3EF0000 000038 (v01 HPQOEM 802E     00000001 HP   00000001)
ACPI: APIC 0x00000000B3EEF000 0000BC (v01 HPQOEM 802E     00000001 HP   00000001)
ACPI: MCFG 0x00000000B3EEE000 00003C (v01 HPQOEM 802E     00000001 HP   00000001)
ACPI: SSDT 0x00000000B3ECC000 00019A (v02 HPQOEM Sata0Ide 00001000 INTL 20121018)
ACPI: SSDT 0x00000000B3ECB000 000729 (v01 HPQOEM PtidDevc 00001000 INTL 20121018)
ACPI: SSDT 0x00000000B3ECA000 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 20121018)
ACPI: DMAR 0x00000000B3EC9000 0000A8 (v01 INTEL  SKL      00000001 INTL 00000001)
ACPI: ASF! 0x00000000B3EC8000 0000A5 (v32 HPQOEM  UYA     00000001 TFSM 000F4240)
ACPI: FPDT 0x00000000B3EC7000 000044 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: BGRT 0x00000000B3EC6000 000038 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: Reserving FACP table memory at [mem 0xb3ef1000-0xb3ef10f3]
ACPI: Reserving DSDT table memory at [mem 0xb3ecd000-0xb3eed9e0]
ACPI: Reserving FACS table memory at [mem 0xb3e6a000-0xb3e6a03f]
ACPI: Reserving SSDT table memory at [mem 0xb3efc000-0xb3efc107]
ACPI: Reserving TCPA table memory at [mem 0xb3efb000-0xb3efb031]
ACPI: Reserving SSDT table memory at [mem 0xb3efa000-0xb3efa3b7]
ACPI: Reserving UEFI table memory at [mem 0xb3e7a000-0xb3e7a041]
ACPI: Reserving SSDT table memory at [mem 0xb3ef4000-0xb3ef91f9]
ACPI: Reserving SSDT table memory at [mem 0xb3ef3000-0xb3ef35b0]
ACPI: Reserving WSMT table memory at [mem 0xb3ef2000-0xb3ef2027]
ACPI: Reserving HPET table memory at [mem 0xb3ef0000-0xb3ef0037]
ACPI: Reserving APIC table memory at [mem 0xb3eef000-0xb3eef0bb]
ACPI: Reserving MCFG table memory at [mem 0xb3eee000-0xb3eee03b]
ACPI: Reserving SSDT table memory at [mem 0xb3ecc000-0xb3ecc199]
ACPI: Reserving SSDT table memory at [mem 0xb3ecb000-0xb3ecb728]
ACPI: Reserving SSDT table memory at [mem 0xb3eca000-0xb3ecae72]
ACPI: Reserving DMAR table memory at [mem 0xb3ec9000-0xb3ec90a7]
ACPI: Reserving ASF! table memory at [mem 0xb3ec8000-0xb3ec80a4]
ACPI: Reserving FPDT table memory at [mem 0xb3ec7000-0xb3ec7043]
ACPI: Reserving BGRT table memory at [mem 0xb3ec6000-0xb3ec6037]
mapped APIC to ffffffffff5fc000 (        fee00000)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000043f7fffff]
NODE_DATA(0) allocated [mem 0x43f7d5000-0x43f7fffff]
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x000000043f7fffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x0000000000090fff]
node   0: [mem 0x0000000000100000-0x00000000b30fafff]
node   0: [mem 0x00000000b3eff000-0x00000000b3efffff]
node   0: [mem 0x0000000100000000-0x000000043f7fffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000043f7fffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 111 pages in unavailable ranges
On node 0, zone DMA32: 3588 pages in unavailable ranges
On node 0, zone Normal: 16640 pages in unavailable ranges
On node 0, zone Normal: 2048 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
Reserving Intel graphics memory at [mem 0xb6800000-0xbe7fffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 8 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fb000 (fec00000)
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x00091000-0x00091fff]
PM: hibernation: Registered nosave memory: [mem 0x00092000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xb30fb000-0xb3c7efff]
PM: hibernation: Registered nosave memory: [mem 0xb3c7f000-0xb3e7efff]
PM: hibernation: Registered nosave memory: [mem 0xb3e7f000-0xb3efefff]
PM: hibernation: Registered nosave memory: [mem 0xb3f00000-0xbe7fffff]
PM: hibernation: Registered nosave memory: [mem 0xbe800000-0xdfffffff]
PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfcffffff]
PM: hibernation: Registered nosave memory: [mem 0xfd000000-0xfe7fffff]
PM: hibernation: Registered nosave memory: [mem 0xfe800000-0xfebfffff]
PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed0ffff]
PM: hibernation: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
PM: hibernation: Registered nosave memory: [mem 0xfed1a000-0xfed83fff]
PM: hibernation: Registered nosave memory: [mem 0xfed84000-0xfed84fff]
PM: hibernation: Registered nosave memory: [mem 0xfed85000-0xfedaffff]
PM: hibernation: Registered nosave memory: [mem 0xfedb0000-0xfedbffff]
PM: hibernation: Registered nosave memory: [mem 0xfedc0000-0xfedfffff]
PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xff6fffff]
PM: hibernation: Registered nosave memory: [mem 0xff700000-0xffffffff]
[mem 0xbe800000-0xdfffffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
percpu: Embedded 65 pages/cpu s229032 r8192 d29016 u524288
pcpu-alloc: s229032 r8192 d29016 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 4074328
Policy zone: Normal
Kernel command line: ip=::::lkp-skl-d07::dhcp root=/dev/ram0 RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/vmlinuz-6.1.0-rc1-00014-g68e9d45f5b0e branch=linux-review/Vishal-Moola-Oracle/Convert-to-filemap_get_folios_tag/20221018-042652 job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=68e9d45f5b0e8ca96c02dc221a65e54d859303ff max_uptime=2100 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdi
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "nokaslr RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/vmlinuz-6.1.0-rc1-00014-g68e9d45f5b0e branch=linux-review/Vishal-Moola-Oracle/Convert-to-filemap_get_folios_tag/20221018-042652 job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=68e9d45f5b0e8ca96c02dc221a65e54d859303ff max_uptime=2100 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
random: crng init done
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
software IO TLB: area num 8.
Memory: 2998000K/16556592K available (40970K kernel code, 13312K rwdata, 8044K rodata, 3468K init, 4672K bss, 3279504K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Kernel/User page tables isolation: enabled
ftrace: allocating 45478 entries in 178 pages
ftrace: allocated 178 pages with 4 groups
rcu: Hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
Console: colour VGA+ 80x25
printk: console [tty0] enabled
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
ACPI: Core revision 20220331
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
APIC: Switch to symmetric I/O mode setup
DMAR: Host address width 39
DMAR: DRHD base: 0x000000fed90000 flags: 0x0
DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e3ff0505e
DMAR: DRHD base: 0x000000fed91000 flags: 0x1
DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
DMAR: RMRR base: 0x000000b3c37000 end: 0x000000b3c56fff
DMAR: RMRR base: 0x000000b6000000 end: 0x000000be7fffff
DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
DMAR-IR: HPET id 0 under DRHD base 0xfed91000
DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
DMAR-IR: IRQ remapping was enabled on dmar1 but we are not in kdump mode
DMAR-IR: Enabled IRQ remapping in xapic mode
x2apic: IRQ remapping doesn't support X2APIC mode
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 2 pin 0 not connected
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-5 -> IRQ 5 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-10 -> IRQ 10 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-11 -> IRQ 11 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 2 pin 16 not connected
apic 2 pin 17 not connected
apic 2 pin 18 not connected
apic 2 pin 19 not connected
apic 2 pin 20 not connected
apic 2 pin 21 not connected
apic 2 pin 22 not connected
apic 2 pin 23 not connected
apic 2 pin 24 not connected
apic 2 pin 25 not connected
apic 2 pin 26 not connected
apic 2 pin 27 not connected
apic 2 pin 28 not connected
apic 2 pin 29 not connected
apic 2 pin 30 not connected
apic 2 pin 31 not connected
apic 2 pin 32 not connected
apic 2 pin 33 not connected
apic 2 pin 34 not connected
apic 2 pin 35 not connected
apic 2 pin 36 not connected
apic 2 pin 37 not connected
apic 2 pin 38 not connected
apic 2 pin 39 not connected
apic 2 pin 40 not connected
apic 2 pin 41 not connected
apic 2 pin 42 not connected
apic 2 pin 43 not connected
apic 2 pin 44 not connected
apic 2 pin 45 not connected
apic 2 pin 46 not connected
apic 2 pin 47 not connected
apic 2 pin 48 not connected
apic 2 pin 49 not connected
apic 2 pin 50 not connected
apic 2 pin 51 not connected
apic 2 pin 52 not connected
apic 2 pin 53 not connected
apic 2 pin 54 not connected
apic 2 pin 55 not connected
apic 2 pin 56 not connected
apic 2 pin 57 not connected
apic 2 pin 58 not connected
apic 2 pin 59 not connected
apic 2 pin 60 not connected
apic 2 pin 61 not connected
apic 2 pin 62 not connected
apic 2 pin 63 not connected
apic 2 pin 64 not connected
apic 2 pin 65 not connected
apic 2 pin 66 not connected
apic 2 pin 67 not connected
apic 2 pin 68 not connected
apic 2 pin 69 not connected
apic 2 pin 70 not connected
apic 2 pin 71 not connected
apic 2 pin 72 not connected
apic 2 pin 73 not connected
apic 2 pin 74 not connected
apic 2 pin 75 not connected
apic 2 pin 76 not connected
apic 2 pin 77 not connected
apic 2 pin 78 not connected
apic 2 pin 79 not connected
apic 2 pin 80 not connected
apic 2 pin 81 not connected
apic 2 pin 82 not connected
apic 2 pin 83 not connected
apic 2 pin 84 not connected
apic 2 pin 85 not connected
apic 2 pin 86 not connected
apic 2 pin 87 not connected
apic 2 pin 88 not connected
apic 2 pin 89 not connected
apic 2 pin 90 not connected
apic 2 pin 91 not connected
apic 2 pin 92 not connected
apic 2 pin 93 not connected
apic 2 pin 94 not connected
apic 2 pin 95 not connected
apic 2 pin 96 not connected
apic 2 pin 97 not connected
apic 2 pin 98 not connected
apic 2 pin 99 not connected
apic 2 pin 100 not connected
apic 2 pin 101 not connected
apic 2 pin 102 not connected
apic 2 pin 103 not connected
apic 2 pin 104 not connected
apic 2 pin 105 not connected
apic 2 pin 106 not connected
apic 2 pin 107 not connected
apic 2 pin 108 not connected
apic 2 pin 109 not connected
apic 2 pin 110 not connected
apic 2 pin 111 not connected
apic 2 pin 112 not connected
apic 2 pin 113 not connected
apic 2 pin 114 not connected
apic 2 pin 115 not connected
apic 2 pin 116 not connected
apic 2 pin 117 not connected
apic 2 pin 118 not connected
apic 2 pin 119 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3101f59f5e6, max_idle_ns: 440795259996 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 6799.81 BogoMIPS (lpj=3399906)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
Yama: becoming mindful.
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: IBRS
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
RETBleed: Mitigation: IBRS
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
MDS: Mitigation: Clear CPU buffers
MMIO Stale Data: Mitigation: Clear CPU buffers
SRBDS: Mitigation: Microcode
Freeing SMP alternatives memory: 40K
smpboot: CPU0: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (family: 0x6, model: 0x5e, stepping: 0x3)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 3 and lim to 1.
cblist_init_generic: Setting shift to 3 and lim to 1.
cblist_init_generic: Setting shift to 3 and lim to 1.
Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
... version:                4
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
Estimated ratio of average max frequency by base frequency (times 1024): 1024
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
masked ExtINT on CPU#1
#2
masked ExtINT on CPU#2
#3
masked ExtINT on CPU#3
#4
masked ExtINT on CPU#4
MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
#5
masked ExtINT on CPU#5
#6
masked ExtINT on CPU#6
#7
masked ExtINT on CPU#7
smp: Brought up 1 node, 8 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 8 processors activated (54398.49 BogoMIPS)
node 0 deferred pages initialised in 40ms
devtmpfs: initialized
x86/mm: Memory block size: 128MB
ACPI: PM: Registering ACPI NVS region [mem 0xb3c7f000-0xb3e7efff] (2097152 bytes)
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
pinctrl core: initialized pinctrl subsystem
NET: Registered PF_NETLINK/PF_ROUTE protocol family
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1666368834.272:1): state=initialized audit_enabled=0 res=1
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'bang_bang'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
cpuidle: using governor menu
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
PCI: Using configuration type 1 for base access
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
cryptd: max_cpu_qlen set to 1000
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 8 ACPI AML tables successfully acquired and loaded
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
ACPI: EC: EC started
ACPI: EC: interrupt blocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 5 GPEs in block 00 to 7F
ACPI: PM: Power Resource [PG01]
ACPI: PM: Power Resource [PG02]
ACPI: PM: Power Resource [PG00]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME LTR]
acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xbe800000-0xdfffffff window]
pci_bus 0000:00: root bus resource [mem 0x1c00000000-0x1fffffffff window]
pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
pci_bus 0000:00: root bus resource [bus 00-fe]
pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xd0000000-0xd0ffffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xd1020000-0xd102ffff 64bit]
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
pci 0000:00:14.2: reg 0x10: [mem 0xd104a000-0xd104afff 64bit]
pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xd104b000-0xd104bfff 64bit]
pci 0000:00:16.0: PME# supported from D3hot
pci 0000:00:16.3: [8086:a13d] type 00 class 0x070002
pci 0000:00:16.3: reg 0x10: [io  0x3080-0x3087]
pci 0000:00:16.3: reg 0x14: [mem 0xd104f000-0xd104ffff]
pci 0000:00:17.0: [8086:2822] type 00 class 0x010400
pci 0000:00:17.0: reg 0x10: [mem 0xd1048000-0xd1049fff]
pci 0000:00:17.0: reg 0x14: [mem 0xd104e000-0xd104e0ff]
pci 0000:00:17.0: reg 0x18: [io  0x3088-0x308f]
pci 0000:00:17.0: reg 0x1c: [io  0x3090-0x3093]
pci 0000:00:17.0: reg 0x20: [io  0x3060-0x307f]
pci 0000:00:17.0: reg 0x24: [mem 0xd104c000-0xd104c7ff]
pci 0000:00:17.0: PME# supported from D3hot
pci 0000:00:1f.0: [8086:a149] type 00 class 0x060100
pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
pci 0000:00:1f.2: reg 0x10: [mem 0xd1044000-0xd1047fff]
pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
pci 0000:00:1f.3: reg 0x10: [mem 0xd1040000-0xd1043fff 64bit]
pci 0000:00:1f.3: reg 0x20: [mem 0xd1030000-0xd103ffff 64bit]
pci 0000:00:1f.3: PME# supported from D3hot D3cold
pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
pci 0000:00:1f.4: reg 0x10: [mem 0xd104d000-0xd104d0ff 64bit]
pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
pci 0000:00:1f.6: reg 0x10: [mem 0xd1000000-0xd101ffff]
pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
ACPI: PCI: Interrupt link LNKA configured for IRQ 11
ACPI: PCI: Interrupt link LNKA disabled
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKB disabled
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKC disabled
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKD disabled
ACPI: PCI: Interrupt link LNKE configured for IRQ 11
ACPI: PCI: Interrupt link LNKE disabled
ACPI: PCI: Interrupt link LNKF configured for IRQ 11
ACPI: PCI: Interrupt link LNKF disabled
ACPI: PCI: Interrupt link LNKG configured for IRQ 11
ACPI: PCI: Interrupt link LNKG disabled
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
ACPI: PCI: Interrupt link LNKH disabled
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: EC: GPE=0x6e
ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x00091c00-0x0009ffff]
e820: reserve RAM buffer [mem 0xb30fb000-0xb3ffffff]
e820: reserve RAM buffer [mem 0xb3f00000-0xb3ffffff]
e820: reserve RAM buffer [mem 0x43f800000-0x43fffffff]
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: bridge control possible
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 24.000000 MHz counter
clocksource: Switched to clocksource tsc-early
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
pnp: PnP ACPI init
system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
system 00:00: [mem 0xfe000000-0xfe01ffff] has been reserved
system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
system 00:01: [io  0x0680-0x069f] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0x1800-0x18fe] has been reserved
system 00:01: [io  0x164e-0x164f] has been reserved
system 00:02: [io  0x0800-0x087f] has been reserved
system 00:04: [io  0x1854-0x1857] has been reserved
system 00:08: [io  0x0200-0x023f] has been reserved
system 00:08: [mem 0xfedb0000-0xfedbffff] has been reserved
system 00:09: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:09: [mem 0xfed90000-0xfed93fff] could not be reserved
system 00:09: [mem 0xfed45000-0xfed8ffff] could not be reserved
system 00:09: [mem 0xff000000-0xffffffff] could not be reserved
system 00:09: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:09: [mem 0xfedc0000-0xfeddffff] has been reserved
pnp: PnP ACPI: found 11 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
TCP: Hash tables configured (established 131072 bind 65536)
UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xbe800000-0xdfffffff window]
pci_bus 0000:00: resource 8 [mem 0x1c00000000-0x1fffffffff window]
pci_bus 0000:00: resource 9 [mem 0xfd000000-0xfe7fffff window]
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x300 took 26331 usecs
PCI: CLS 0 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Trying to unpack rootfs image as initramfs...
software IO TLB: mapped [mem 0x00000000af0fb000-0x00000000b30fb000] (64MB)
Initialise system trusted keyrings
Key type blacklist registered
workingset: timestamp_bits=36 max_order=22 bucket_order=0
zbud: loaded
9p: Installing v9fs 9p2000 file system support
NET: Registered PF_ALG protocol family
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
ACPI: button: Sleep Button [SLPB]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
ACPI: button: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: button: Power Button [PWRF]
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:07: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-19 -> IRQ 19 Level:1 ActiveLow:1)
0000:00:16.3: ttyS1 at I/O 0x3080 (irq = 19, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
tpm_tis 00:0a: 1.2 TPM (device-id 0x1B, rev-id 16)
tpm tpm0: TPM is disabled/deactivated (0x7)
tpm tpm0: tpm_read_log_acpi: TCPA log area empty
rdac: device handler registered
hp_sw: device handler registered
emc: device handler registered
alua: device handler registered
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 3c:52:82:60:db:86
e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
Intel(R) 2.5G Ethernet Linux Driver
Copyright(c) 2018 Intel Corporation.
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
ixgbe: Copyright (c) 1999-2016 Intel Corporation.
i40e: Intel(R) Ethernet Connection XL710 Network Driver
i40e: Copyright (c) 2013 - 2019 Intel Corporation.
usbcore: registered new interface driver r8152
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.01
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: xHCI Host Controller
usb usb1: Manufacturer: Linux 6.1.0-rc1-00014-g68e9d45f5b0e xhci-hcd
usb usb1: SerialNumber: 0000:00:14.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 16 ports detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.01
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: xHCI Host Controller
usb usb2: Manufacturer: Linux 6.1.0-rc1-00014-g68e9d45f5b0e xhci-hcd
usb usb2: SerialNumber: 0000:00:14.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
rtc_cmos 00:03: registered as rtc0
rtc_cmos 00:03: setting system clock to 2022-10-21T16:13:59 UTC (1666368839)
rtc_cmos 00:03: alarms up to one day, 242 bytes nvram, hpet irqs
rtc_cmos 00:03: RTC can wake from S4
iTCO_vendor_support: vendor-support=0
intel_pstate: HWP enabled by BIOS
intel_pstate: Intel P-state driver initializing
tsc: Refined TSC clocksource calibration: 3407.999 MHz
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fd336761, max_idle_ns: 440795243819 ns
intel_pstate: HWP enabled
clocksource: Switched to clocksource tsc
hid: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
drop_monitor: Initializing network drop monitor service
Initializing XFRM netlink socket
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
NET: Registered PF_PACKET protocol family
9pnet: Installing 9P2000 support
mpls_gso: MPLS GSO support
microcode: sig=0x506e3, pf=0x2, revision=0xf0
microcode: Microcode Update Driver: v2.2.
IPI shorthand broadcast: enabled
... APIC ID:      00000000 (0)
... APIC VERSION: 01060015
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000001000

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 120.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00770020
.......     : max redirection entries: 77
.......     : PRQ implemented: 0
.......     : IO APIC version: 20
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin01, enabled , edge , high, V(01), IRR(0), S(0), remapped, I(0000),  Z(0)
pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped, I(0001),  Z(0)
pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0140), M(2)
pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped, I(0007),  Z(0)
pin09, enabled , level, high, V(09), IRR(0), S(0), remapped, I(0008),  Z(0)
pin0a, disabled, edge , high, V(04), IRR(0), S(0), physical, D(2800), M(2)
pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0c, enabled , edge , high, V(0C), IRR(0), S(0), remapped, I(000B),  Z(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0e, disabled, edge , high, V(08), IRR(0), S(0), remapped, I(4000),  Z(2)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin18, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin19, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin20, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin21, disabled, edge , high, V(00), IRR(0), S(0), physical, D(2E32), M(2)
pin22, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0440), M(2)
pin23, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin24, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin25, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin26, disabled, edge , high, V(40), IRR(0), S(0), physical, D(0468), M(2)
pin27, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin28, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin29, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2d, disabled, edge , high, V(02), IRR(0), S(0), physical, D(0200), M(2)
pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin30, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin31, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin32, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin33, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin34, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin35, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin36, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin37, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin38, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin39, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin40, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin41, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin42, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin43, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin44, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin45, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin46, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin47, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0081), M(2)
pin48, disabled, edge , high, V(00), IRR(0), S(0), remapped, I(0010),  Z(2)
pin49, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4e, disabled, edge , high, V(02), IRR(0), S(0), remapped, I(03C2),  Z(2)
pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin50, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin51, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin52, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin53, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin54, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin55, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin56, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin57, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin58, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin59, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(4000), M(2)
pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5e, disabled, edge , high, V(88), IRR(0), S(0), physical, D(4468), M(2)
pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin60, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin61, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin62, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin63, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin64, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin65, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin66, disabled, edge , high, V(00), IRR(0), S(0), physical, D(4200), M(2)
pin67, disabled, edge , high, V(48), IRR(0), S(0), physical, D(0102), M(2)
pin68, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin69, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6d, disabled, edge , high, V(21), IRR(0), S(0), physical, D(00A8), M(2)
pin6e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin70, disabled, edge , high, V(84), IRR(0), S(0), physical, D(4000), M(2)
pin71, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin72, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin73, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin74, disabled, edge , high, V(08), IRR(0), S(0), physical, D(0004), M(2)
pin75, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin76, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin77, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ19 -> 0:19
.................................... done.
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
sched_clock: Marking stable (7046879235, 1032984386)->(8380586384, -300722763)
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 268acc0dca94d6fae05c920a56c35cca64f9bd3d'
zswap: loaded using pool lzo/zbud
page_owner is disabled
Key type .fscrypt registered
Key type fscrypt-provisioning registered
Freeing initrd memory: 466980K
Key type trusted registered
Key type encrypted registered
e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests ..., OK
IP-Config: Got DHCP answer from 192.168.3.2, my address is 192.168.3.73
IP-Config: Complete:
device=eth0, hwaddr=3c:52:82:60:db:86, ipaddr=192.168.3.73, mask=255.255.255.0, gw=192.168.3.200
host=lkp-skl-d07, domain=lkp.intel.com, nis-domain=(none)
bootserver=192.168.3.200, rootserver=192.168.3.200, rootpath=
nameserver0=192.168.3.200
Freeing unused kernel image (initmem) memory: 3468K
Write protecting the kernel read-only data: 51200k
Freeing unused kernel image (text/rodata gap) memory: 2036K
Freeing unused kernel image (rodata/data gap) memory: 148K
Run /init as init process
with arguments:
/init
nokaslr
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/vmlinuz-6.1.0-rc1-00014-g68e9d45f5b0e
branch=linux-review/Vishal-Moola-Oracle/Convert-to-filemap_get_folios_tag/20221018-042652
job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=68e9d45f5b0e8ca96c02dc221a65e54d859303ff
max_uptime=2100
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.


Mou[   26.643515][  T214] ACPI: bus type drm_connector registered
EDAC ie31200: No ECC support
EDAC ie31200: No ECC support
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT:1)
acpi PNP0C14:02: duplicate WMI GUID 2B814318-4BE8-4707-9D84-A190A859B5D0 (first instance was on PNP0C14:00)
IOAPIC[0]: Preconfigured routing entry (2-18 -> IRQ 18 Level:1 ActiveLow:1)
acpi PNP0C14:02: duplicate WMI GUID 41227C2D-80E1-423F-8B8E-87E32755A0EB (first instance was on PNP0C14:00)
i801_smbus 0000:00:1f.4: SPD Write Disable is set
wmi_bus wmi_bus-PNP0C14:02: WQZZ data block query control method not found
i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
pci 0000:00:1f.1: [8086:a120] type 00 class 0x058000
pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
[0m.
libata version 3.00 loaded.
iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
i2c i2c-0: 2/4 memory slots populated (from DMI)
i2c i2c-0: Successfully instantiated SPD at 0x50
i2c i2c-0: Successfully instantiated SPD at 0x52
RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
RAPL PMU: hw unit of domain package 2^-14 Joules
RAPL PMU: hw unit of domain dram 2^-14 Joules
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
;1;39mCreate Vol[   27.200886][  T259] ahci 0000:00:17.0: controller can't do SNTF, turning off CAP_SNTF
atile Files and [   27.216317][  T259] ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
0m] Listening on[   27.234717][  T259] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf impl RAID mode
scsi host0: ahci
scsi host1: ahci
Startin[   27.351572][  T259] scsi host2: ahci
network interfa[   27.360976][  T259] ata1: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c100 irq 125
ata2: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c180 irq 125
ata3: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c200 irq 125
ata4: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c280 irq 125
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
LKP: ttyS0: 335:[   27.767095][  T297] ata1.00: configured for UDMA/100
Kernel tests: B[   27.773552][   T59] scsi 0:0:0:0: Direct-Access     ATA      ST2000DM001-1ER1 HP52 PQ: 0 ANSI: 5
oot OK!
LKP: ttyS0: 335: HOSTNAME lkp-skl-d07, MAC 3c:52:82:60:db:86, kernel 6.1.0-rc1-00014-g68e9d45f5b0e 1
ata2: SATA link down (SStatus 4 SControl 300)
IPMI message handler: version 39.2
See 'systemctl status systemd-logind.service' for details.
i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin failed with error -2
i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/skl_dmc_ver1_27.bin. Disabling runtime power management.
i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
ata3: SATA link down (SStatus 4 SControl 300)
ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata4.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata4.00: ATA-10: INTEL SSDSC2BW480H6, RG21, max UDMA/133
ata4.00: 937703088 sectors, multi 16: LBA48 NCQ (depth 32), AA
ata4.00: Features: Dev-Sleep
ata4.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata4.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      INTEL SSDSC2BW48 RG21 PQ: 0 ANSI: 5
ipmi device interface
scsi 0:0:0:0: Attached scsi generic sg0 type 0
scsi 3:0:0:0: Attached scsi generic sg1 type 0
ipmi_si: IPMI System Interface driver
ipmi_si: Unable to find any System Interface(s)
intel_rapl_common: Found RAPL domain package
sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
sd 3:0:0:0: [sdb] 937703088 512-byte logical blocks: (480 GB/447 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
intel_rapl_common: Found RAPL domain core
sd 0:0:0:0: [sda] 4096-byte physical blocks
intel_rapl_common: Found RAPL domain uncore
sd 0:0:0:0: [sda] Write Protect is off
intel_rapl_common: Found RAPL domain dram
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
SB: OpenIPMI Dri[   29.056157][   T55] sd 3:0:0:0: [sdb] Attached SCSI disk
See 'systemctl status openipmi.service' for details.
sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
raid6: avx2x4   gen() 17777 MB/s
raid6: avx2x2   gen() 15410 MB/s
i915 0000:00:02.0: [drm] failed to retrieve link info, disabling eDP
raid6: avx2x1   gen() 13063 MB/s
raid6: using algorithm avx2x4 gen() 17777 MB/s
raid6: .... xor() 8266 MB/s, rmw enabled
raid6: using avx2x2 recovery algorithm
xor: automatically using best checksumming function   avx       
[drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
Btrfs loaded, crc32c=crc32c-intel, zoned=yes, fsverity=no
BTRFS: device fsid 1a712c4b-81fb-4b80-8196-51326ab4d226 devid 1 transid 15 /dev/sdb1 scanned by systemd-udevd (265)
LKP: stdout: 335: Kernel tests: Boot OK!

LKP: stdout: 335: HOSTNAME lkp-skl-d07, MAC 3c:52:82:60:db:86, kernel 6.1.0-rc1-00014-g68e9d45f5b0e 1

install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/ntpdate_1%3a4.2.8p15+dfsg-1_amd64.deb

/opt/deb/gawk_1%3a5.1.0-1_amd64.deb

/opt/deb/uuid-runtime_2.36.1-8+deb11u1_amd64.deb

/opt/deb/libssl1.1_1.1.1n-0+deb11u3_amd64.deb

/opt/deb/attr_1%3a2.4.48-6_amd64.deb

/opt/deb/libdpkg-perl_1.20.12_all.deb

/opt/deb/patch_2.7.6-7_amd64.deb

/opt/deb/libfakeroot_1.25.3-1.1_amd64.deb

/opt/deb/fakeroot_1.25.3-1.1_amd64.deb

/opt/deb/libfile-dirlist-perl_0.05-2_all.deb

/opt/deb/libfile-which-perl_1.23-1_all.deb

/opt/deb/libfile-homedir-perl_1.006-1_all.deb

/opt/deb/libfile-touch-perl_0.11-1_all.deb

/opt/deb/libio-pty-perl_1%3a1.15-2_amd64.deb

/opt/deb/libipc-run-perl_20200505.0-1_all.deb

/opt/deb/libclass-method-modifiers-perl_2.13-1_all.deb

/opt/deb/libb-hooks-op-check-perl_0.22-1+b3_amd64.deb

/opt/deb/libdynaloader-functions-perl_0.003-1.1_all.deb

/opt/deb/libdevel-callchecker-perl_0.008-1+b2_amd64.deb

/opt/deb/libparams-classify-perl_0.015-1+b3_amd64.deb

/opt/deb/libmodule-runtime-perl_0.016-1_all.deb

/opt/deb/libimport-into-perl_1.002005-1_all.deb

/opt/deb/librole-tiny-perl_2.002004-1_all.deb

/opt/deb/libstrictures-perl_2.000006-1_all.deb

/opt/deb/libsub-quote-perl_2.006006-1_all.deb

/opt/deb/libmoo-perl_2.004004-1_all.deb

/opt/deb/libencode-locale-perl_1.05-1.1_all.deb

/opt/deb/libtimedate-perl_2.3300-2_all.deb

/opt/deb/libhttp-date-perl_6.05-1_all.deb

/opt/deb/libfile-listing-perl_6.14-1_all.deb

/opt/deb/libhtml-tagset-perl_3.20-4_all.deb

/opt/deb/liburi-perl_5.08-1_all.deb

/opt/deb/libhtml-parser-perl_3.75-1+b1_amd64.deb

/opt/deb/libhtml-tree-perl_5.07-2_all.deb

/opt/deb/libio-html-perl_1.004-2_all.deb

/opt/deb/liblwp-mediatypes-perl_6.04-1_all.deb

/opt/deb/libhttp-message-perl_6.28-1_all.deb

/opt/deb/libhttp-cookies-perl_6.10-1_all.deb

/opt/deb/libhttp-negotiate-perl_6.01-1_all.deb

/opt/deb/perl-openssl-defaults_5_amd64.deb

/opt/deb/libnet-ssleay-perl_1.88-3+b1_amd64.deb

/opt/deb/libio-socket-ssl-perl_2.069-1_all.deb

/opt/deb/libnet-http-perl_6.20-1_all.deb

/opt/deb/liblwp-protocol-https-perl_6.10-1_all.deb

/opt/deb/libtry-tiny-perl_0.30-1_all.deb

/opt/deb/libwww-robotrules-perl_6.02-1_all.deb

/opt/deb/libwww-perl_6.52-1_all.deb

/opt/deb/patchutils_0.4.2-1_amd64.deb

/opt/deb/libatomic1_10.2.1-6_amd64.deb

/opt/deb/libquadmath0_10.2.1-6_amd64.deb

/opt/deb/libgcc-10-dev_10.2.1-6_amd64.deb

/opt/deb/gcc-10_10.2.1-6_amd64.deb

/opt/deb/gcc_4%3a10.2.1-1_amd64.deb

/opt/deb/libgdbm-compat-dev_1.19-2_amd64.deb

/opt/deb/libpython2.7-minimal_2.7.18-8_amd64.deb

/opt/deb/python2.7-minimal_2.7.18-8_amd64.deb

/opt/deb/python2-minimal_2.7.18-3_amd64.deb

/opt/deb/mime-support_3.66_all.deb

/opt/deb/libpython2.7-stdlib_2.7.18-8_amd64.deb

/opt/deb/python2.7_2.7.18-8_amd64.deb

/opt/deb/libpython2-stdlib_2.7.18-3_amd64.deb

/opt/deb/python2_2.7.18-3_amd64.deb

/opt/deb/python-is-python2_2.7.18-9_all.deb

/opt/deb/python3-dnspython_2.0.0-1_all.deb

/opt/deb/libpython3.9_3.9.2-1_amd64.deb

/opt/deb/python3-ldb_2%3a2.2.3-2~deb11u1_amd64.deb

/opt/deb/python3-tdb_1.4.3-1+b1_amd64.deb

/opt/deb/libavahi-common-data_0.8-5_amd64.deb

/opt/deb/python3-talloc_2.3.1-2+b1_amd64.deb

/opt/deb/python3-samba_2%3a4.13.13+dfsg-1~deb11u3_amd64.deb

Selecting previously unselected package ntpdate.

(Reading database ... 16440 files and directories currently installed.)

Preparing to unpack .../ntpdate_1%3a4.2.8p15+dfsg-1_amd64.deb ...

Unpacking ntpdate (1:4.2.8p15+dfsg-1) ...

Selecting previously unselected package gawk.

Preparing to unpack .../deb/gawk_1%3a5.1.0-1_amd64.deb ...

Unpacking gawk (1:5.1.0-1) ...

Selecting previously unselected package uuid-runtime.

Preparing to unpack .../uuid-runtime_2.36.1-8+deb11u1_amd64.deb ...

Unpacking uuid-runtime (2.36.1-8+deb11u1) ...

Preparing to unpack .../libssl1.1_1.1.1n-0+deb11u3_amd64.deb ...

Unpacking libssl1.1:amd64 (1.1.1n-0+deb11u3) over (1.1.1n-0+deb11u1) ...

Selecting previously unselected package attr.

Preparing to unpack .../attr_1%3a2.4.48-6_amd64.deb ...

Unpacking attr (1:2.4.48-6) ...

Selecting previously unselected package libdpkg-perl.

Preparing to unpack .../libdpkg-perl_1.20.12_all.deb ...

Unpacking libdpkg-perl (1.20.12) ...

Selecting previously unselected package patch.

Preparing to unpack .../deb/patch_2.7.6-7_amd64.deb ...

Unpacking patch (2.7.6-7) ...

Selecting previously unselected package libfakeroot:amd64.

Preparing to unpack .../libfakeroot_1.25.3-1.1_amd64.deb ...

Unpacking libfakeroot:amd64 (1.25.3-1.1) ...

Selecting previously unselected package fakeroot.

Preparing to unpack .../fakeroot_1.25.3-1.1_amd64.deb ...

Unpacking fakeroot (1.25.3-1.1) ...

Selecting previously unselected package libfile-dirlist-perl.

Preparing to unpack .../libfile-dirlist-perl_0.05-2_all.deb ...

Unpacking libfile-dirlist-perl (0.05-2) ...

Selecting previously unselected package libfile-which-perl.

Preparing to unpack .../libfile-which-perl_1.23-1_all.deb ...

Unpacking libfile-which-perl (1.23-1) ...

Selecting previously unselected package libfile-homedir-perl.

Preparing to unpack .../libfile-homedir-perl_1.006-1_all.deb ...

Unpacking libfile-homedir-perl (1.006-1) ...

Selecting previously unselected package libfile-touch-perl.

Preparing to unpack .../libfile-touch-perl_0.11-1_all.deb ...

Unpacking libfile-touch-perl (0.11-1) ...

Selecting previously unselected package libio-pty-perl.

Preparing to unpack .../libio-pty-perl_1%3a1.15-2_amd64.deb ...

Unpacking libio-pty-perl (1:1.15-2) ...

Selecting previously unselected package libipc-run-perl.

Preparing to unpack .../libipc-run-perl_20200505.0-1_all.deb ...

Unpacking libipc-run-perl (20200505.0-1) ...

Selecting previously unselected package libclass-method-modifiers-perl.

Preparing to unpack .../libclass-method-modifiers-perl_2.13-1_all.deb ...

Unpacking libclass-method-modifiers-perl (2.13-1) ...




Unpacking libb-hooks-op-check-perl (0.22-1+b3) ...

Selecting previously unselected package libdynaloader-functions-perl.

Preparing to unpack .../libdynaloader-functions-perl_0.003-1.1_all.deb ...

Unpacking libdynaloader-functions-perl (0.003-1.1) ...

Selecting previously unselected package libdevel-callchecker-perl.

Preparing to unpack .../libdevel-callchecker-perl_0.008-1+b2_amd64.deb ...

Unpacking libdevel-callchecker-perl (0.008-1+b2) ...

Selecting previously unselected package libparams-classify-perl.

Preparing to unpack .../libparams-classify-perl_0.015-1+b3_amd64.deb ...

Unpacking libparams-classify-perl (0.015-1+b3) ...

Selecting previously unselected package libmodule-runtime-perl.

Preparing to unpack .../libmodule-runtime-perl_0.016-1_all.deb ...

Unpacking libmodule-runtime-perl (0.016-1) ...

Selecting previously unselected package libimport-into-perl.

Preparing to unpack .../libimport-into-perl_1.002005-1_all.deb ...

Unpacking libimport-into-perl (1.002005-1) ...

Selecting previously unselected package librole-tiny-perl.

Preparing to unpack .../librole-tiny-perl_2.002004-1_all.deb ...

Unpacking librole-tiny-perl (2.002004-1) ...

Selecting previously unselected package libstrictures-perl.

Preparing to unpack .../libstrictures-perl_2.000006-1_all.deb ...
[   37.9_all.deb ...

Unpacking libwww-robotrules-perl (6.02-1) ...

Selecting previously unselected package libwww-perl.

Preparing to unpack .../deb/libwww-perl_6.52-1_all.deb ...

Unpacking libwww-perl (6.52-1) ...

Selecting previously unselected package patchutils.

Preparing to unpack .../patchutils_0.4.2-1_amd64.deb ...

Unpacking patchutils (0.4.2-1) ...

Selecting previously unselected package libatomic1:amd64.

Preparing to unpack .../libatomic1_10.2.1-6_amd64.deb ...

Unpacking libatomic1:amd64 (10.2.1-6) ...

Selecting previously unselected package libquadmath0:amd64.

Preparing to unpack .../libquadmath0_10.2.1-6_amd64.deb ...

Unpacking libquadmath0:amd64 (10.2.1-6) ...

Selecting previously unselected package libgcc-10-dev:amd64.

Preparing to unpack .../libgcc-10-dev_10.2.1-6_amd64.deb ...

Unpacking libgcc-10-dev:amd64 (10.2.1-6) ...

Selecting previously unselected package gcc-10.

Preparing to unpack .../deb/gcc-10_10.2.1-6_amd64.deb ...

Unpacking gcc-10 (10.2.1-6) ...

Selecting previously unselected package gcc.

Preparing to unpack .../deb/gcc_4%3a10.2.1-1_amd64.deb ...

Unpacking gcc (4:10.2.1-1) ...

Selecting previously unselected package libgdbm-compat-dev.

Preparing to unpack .../libgdbm-compat-dev_1.19-2_amd64.deb ...

Unpacking libgdbm-compat-dev (1.19-2) ...

Selecting previously unselected package libpython2.7-minimal:amd64.

Preparing to unpack .../libpython2.7-minimal_2.7.18-8_amd64.deb ...

Unpacking libpython2.7-minimal:amd64 (2.7.18-8) ...

Selecting previously unselected package python2.7-minimal.

Preparing to unpack .../python2.7-minimal_2.7.18-8_amd64.deb ...

Unpacking python2.7-minimal (2.7.18-8) ...

Selecting previously unselected package python2-minimal.

Preparing to unpack .../python2-minimal_2.7.18-3_amd64.deb ...

Unpacking python2-minimal (2.7.18-3) ...

Selecting previously unselected package mime-support.

Preparing to unpack .../deb/mime-support_3.66_all.deb ...

Unpacking mime-support (3.66) ...

Selecting previously unselected package libpython2.7-stdlib:amd64.

Preparing to unpack .../libpython2.7-stdlib_2.7.18-8_amd64.deb ...

Unpacking libpython2.7-stdlib:amd64 (2.7.18-8) ...

Selecting previously unselected package python2.7.

Preparing to unpack .../python2.7_2.7.18-8_amd64.deb ...

Unpacking python2.7 (2.7.18-8) ...

Selecting previously unselected package libpython2-stdlib:amd64.

Preparing to unpack .../libpython2-stdlib_2.7.18-3_amd64.deb ...

Unpacking libpython2-stdlib:amd64 (2.7.18-3) ...

Selecting previously unselected package python2.

Preparing to unpack .../deb/python2_2.7.18-3_amd64.deb ...

Unpacking python2 (2.7.18-3) ...

Selecting previously unselected package python-is-python2.

Preparing to unpack .../python-is-python2_2.7.18-9_all.deb ...

Unpacking python-is-python2 (2.7.18-9) ...

Selecting previously unselected package python3-dnspython.

Preparing to unpack .../python3-dnspython_2.0.0-1_all.deb ...

Unpacking python3-dnspython (2.0.0-1) ...

Selecting previously unselected package libpython3.9:amd64.

Preparing to unpack .../libpython3.9_3.9.2-1_amd64.deb ...

Unpacking libpython3.9:amd64 (3.9.2-1) ...

Selecting previously unselected package python3-ldb.

Preparing to unpack .../python3-ldb_2%3a2.2.3-2~deb11u1_amd64.deb ...

Unpacking python3-ldb (2:2.2.3-2~deb11u1) ...

Selecting previously unselected package python3-tdb.

Preparing to unpack .../python3-tdb_1.4.3-1+b1_amd64.deb ...

Unpacking python3-tdb (1.4.3-1+b1) ...

Selecting previously unselected package libavahi-common-data:amd64.

Preparing to unpack .../libavahi-common-data_0.8-5_amd64.deb ...

Unpacking libavahi-common-data:amd64 (0.8-5) ...

Selecting previously unselected package python3-talloc:amd64.

Preparing to unpack .../python3-talloc_2.3.1-2+b1_amd64.deb ...

Unpacking python3-talloc:amd64 (2.3.1-2+b1) ...

Selecting previously unselected package python3-samba.

Preparing to unpack .../python3-samba_2%3a4.13.13+dfsg-1~deb11u3_amd64.deb ...

Unpacking python3-samba (2:4.13.13+dfsg-1~deb11u3) ...

Setting up uuid-runtime (2.36.1-8+deb11u1) ...

Adding group `uuidd' (GID 111) ...

Done.

Warning: The home dir /run/uuidd you specified can't be accessed: No such file or directory

Adding system user `uuidd' (UID 107) ...

Adding new user `uuidd' (UID 107) with group `uuidd' ...

Not creating home directory `/run/uuidd'.

Setting up libssl1.1:amd64 (1.1.1n-0+deb11u3) ...

Setting up attr (1:2.4.48-6) ...

Setting up libdpkg-perl (1.20.12) ...

Setting up patch (2.7.6-7) ...

Setting up libfakeroot:amd64 (1.25.3-1.1) ...

Setting up fakeroot (1.25.3-1.1) ...

update-alternatives: using /usr/bin/fakeroot-sysv to provide /usr/bin/fakeroot (fakeroot) in auto mode

Setting up libfile-dirlist-perl (0.05-2) ...

Setting up libfile-which-perl (1.23-1) ...

Setting up libfile-homedir-perl (1.006-1) ...

Setting up libfile-touch-perl (0.11-1) ...

Setting up libio-pty-perl (1:1.15-2) ...

Setting up libipc-run-perl (20200505.0-1) ...

Setting up libclass-method-modifiers-perl (2.13-1) ...

Setting up libb-hooks-op-check-perl (0.22-1+b3) ...

Setting up libdynaloader-functions-perl (0.003-1.1) ...

Setting up libdevel-callchecker-perl (0.008-1+b2) ...

Setting up libparams-classify-perl (0.015-1+b3) ...

Setting up libmodule-runtime-perl (0.016-1) ...

Setting up libimport-into-perl (1.002005-1) ...

Setting up librole-tiny-perl (2.002004-1) ...

Setting up libstrictures-perl (2.000006-1) ...

Setting up libsub-quote-perl (2.006006-1) ...

Setting up libmoo-perl (2.004004-1) ...

Setting up libencode-locale-perl (1.05-1.1) ...

Setting up libtimedate-perl (2.3300-2) ...

Setting up libhttp-date-perl (6.05-1) ...

Setting up libfile-listing-perl (6.14-1) ...

Setting up libhtml-tagset-perl (3.20-4) ...

Setting up liburi-perl (5.08-1) ...

Setting up libhtml-parser-perl (3.75-1+b1) ...

Setting up libhtml-tree-perl (5.07-2) ...

Setting up libio-html-perl (1.004-2) ...

Setting up liblwp-mediatypes-perl (6.04-1) ...

Setting up libhttp-message-perl (6.28-1) ...

Setting up libhttp-cookies-perl (6.10-1) ...

Setting up libhttp-negotiate-perl (6.01-1) ...

Setting up perl-openssl-defaults:amd64 (5) ...

Setting up libnet-ssleay-perl (1.88-3+b1) ...

Setting up libio-socket-ssl-perl (2.069-1) ...

Setting up libnet-http-perl (6.20-1) ...

Setting up libtry-tiny-perl (0.30-1) ...

Setting up libwww-robotrules-perl (6.02-1) ...

Setting up patchutils (0.4.2-1) ...

Setting up libatomic1:amd64 (10.2.1-6) ...

Setting up libquadmath0:amd64 (10.2.1-6) ...

Setting up libpython2.7-minimal:amd64 (2.7.18-8) ...

Setting up python2.7-minimal (2.7.18-8) ...

Linking and byte-compiling packages for runtime python2.7...

Setting up python2-minimal (2.7.18-3) ...

Setting up python3-dnspython (2.0.0-1) ...

Setting up libpython3.9:amd64 (3.9.2-1) ...

Setting up libavahi-common-data:amd64 (0.8-5) ...

Setting up ntpdate (1:4.2.8p15+dfsg-1) ...

Setting up liblwp-protocol-https-perl (6.10-1) ...

Setting up libwww-perl (6.52-1) ...

Setting up libgdbm-compat-dev (1.19-2) ...

Setting up mime-support (3.66) ...

Setting up libpython2.7-stdlib:amd64 (2.7.18-8) ...

Setting up python2.7 (2.7.18-8) ...

Setting up libpython2-stdlib:amd64 (2.7.18-3) ...

Setting up python2 (2.7.18-3) ...

Setting up python-is-python2 (2.7.18-9) ...

Setting up python3-ldb (2:2.2.3-2~deb11u1) ...

Setting up python3-tdb (1.4.3-1+b1) ...

Setting up python3-talloc:amd64 (2.3.1-2+b1) ...

Setting up python3-samba (2:4.13.13+dfsg-1~deb11u3) ...

Setting up gawk (1:5.1.0-1) ...

Setting up libgcc-10-dev:amd64 (10.2.1-6) ...

Setting up gcc-10 (10.2.1-6) ...

Setting up gcc (4:10.2.1-1) ...

Processing triggers for libc-bin (2.31-13+deb11u3) ...

21 Oct 16:13:17 ntpdate[1313]: step time server 192.168.1.200 offset -80.417731 sec

BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device sdb1): disk space caching is enabled
BTRFS info (device sdb1): enabling ssd optimizations
LKP: ttyS0: 335:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
LKP: stdout: 335:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml

RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/3

job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml

result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/3, TMP_RESULT_ROOT: /tmp/lkp/result

run-job /lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml

/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-86368-jt3ct4-0.yaml&job_state=running -O /dev/null

target ucode: 0xf0

current_version: f0, target_version: f0

2022-10-21 16:13:19 dmsetup remove_all

2022-10-21 16:13:19 wipefs -a --force /dev/sda1

/dev/sda1: 2 bytes were erased at offset 0x00000438 (ext4): 53 ef

2022-10-21 16:13:19 wipefs -a --force /dev/sda2

2022-10-21 16:13:19 wipefs -a --force /dev/sda3

2022-10-21 16:13:19 wipefs -a --force /dev/sda4

2022-10-21 16:13:19 mkfs -t ext4 -q -F /dev/sda3

2022-10-21 16:13:19 mkfs -t ext4 -q -F /dev/sda4

2022-10-21 16:13:19 mkfs -t ext4 -q -F /dev/sda2

2022-10-21 16:13:19 mkfs -t ext4 -q -F /dev/sda1

2022-10-21 16:13:56 mkdir -p /fs/sda1

	ext4

2022-10-21 16:13:56 mount -t ext4 /dev/sda1 /fs/sda1

EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
2022-10-21 16:13:56 mkdir -p /fs/sda2

	ext4

2022-10-21 16:13:56 mount -t ext4 /dev/sda2 /fs/sda2

EXT4-fs (sda2): mounted filesystem with ordered data mode. Quota mode: none.
2022-10-21 16:13:56 mkdir -p /fs/sda3

	ext4

2022-10-21 16:13:56 mount -t ext4 /dev/sda3 /fs/sda3

EXT4-fs (sda3): mounted filesystem with ordered data mode. Quota mode: none.
2022-10-21 16:13:56 mkdir -p /fs/sda4

	ext4

2022-10-21 16:13:56 mount -t ext4 /dev/sda4 /fs/sda4

EXT4-fs (sda4): mounted filesystem with ordered data mode. Quota mode: none.
Added user root.

2022-10-21 16:13:57 mkdir -p /cifs/sda1

2022-10-21 16:13:57 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda1 /cifs/sda1

Key type dns_resolver registered
Key type cifs.spnego registered
Key type cifs.idmap registered
CIFS: Attempting to mount \\localhost\fs
mount cifs success

2022-10-21 16:13:57 mkdir -p /cifs/sda2

2022-10-21 16:13:57 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda2 /cifs/sda2

CIFS: Attempting to mount \\localhost\fs
mount cifs success

2022-10-21 16:13:57 mkdir -p /cifs/sda3

2022-10-21 16:13:57 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda3 /cifs/sda3

CIFS: Attempting to mount \\localhost\fs
mount cifs success

2022-10-21 16:13:57 mkdir -p /cifs/sda4

2022-10-21 16:13:57 timeout 5m mount -t cifs -o vers=2.0 -o user=root,password=pass //localhost/fs/sda4 /cifs/sda4

CIFS: Attempting to mount \\localhost\fs
mount cifs success

x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb39e2000-0xb39e2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb39e2000-0xb39e2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb39e2000-0xb39e2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
EXT4-fs (sda1): unmounting filesystem.
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
EXT4-fs (sda2): unmounting filesystem.
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
EXT4-fs (sda3): unmounting filesystem.
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
EXT4-fs (sda4): unmounting filesystem.
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
2022-10-21 16:13:59 mount /dev/sda1 /fs/sda1

x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1602 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
2022-10-21 16:13:59 mkdir -p /smbv2//cifs/sda1

2022-10-21 16:13:59 export FSTYP=cifs

2022-10-21 16:13:59 export TEST_DEV=//localhost/fs/sda1

2022-10-21 16:13:59 export TEST_DIR=/smbv2//cifs/sda1

2022-10-21 16:13:59 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=2.0,mfsymlinks,actimeo=0

2022-10-21 16:13:59 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-12

2022-10-21 16:13:59 ./check -E tests/cifs/exclude.incompatible-smb2.txt -E tests/cifs/exclude.very-slow.txt generic/240 generic/241 generic/242 generic/243 generic/244 generic/245 generic/246 generic/247 generic/248 generic/249 generic/250 generic/251 generic/252 generic/253 generic/254 generic/255 generic/256 generic/257 generic/258 generic/259

CIFS: Attempting to mount \\localhost\fs
512+0 records in

512+0 records out

FSTYP         -- cifs

PLATFORM      -- Linux/x86_64 lkp-skl-d07 6.1.0-rc1-00014-g68e9d45f5b0e #1 SMP Fri Oct 21 07:20:04 CST 2022



run fstests generic/240 at 2022-10-21 16:14:00
Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
generic/240       [not run] fs block size must be larger than the device block size.  fs block size: 1024, device block size: 4096

run fstests generic/241 at 2022-10-21 16:14:01
Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
262144 bytes (262 kB, 256 KiB) copied, 0.0127582 s, 20.5 MB/s

512+0 records in

512+0 records out

262144 bytes (262 kB, 256 KiB) copied, 0.134122 s, 2.0 MB/s

512+0 records in

512+0 records out

262144 bytes (262 kB, 256 KiB) copied, 0.0936698 s, 2.8 MB/s

BUG: Bad page state in process smbd  pfn:1194e6
page:000000009b7feda3 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194e6
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Not tainted 6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
Disabling lock debugging due to kernel taint
BUG: Bad page state in process smbd  pfn:1194e7
page:00000000a81a28a0 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194e7
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:1194e8
page:00000000cb832fa7 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194e8
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:1194e9
page:00000000de8036b9 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194e9
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:1194ea
page:00000000470bcf07 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ea
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:1194eb
page:0000000024a0b7d6 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194eb
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:1194ec
page:000000004d5f8313 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ec
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:1194ed
page:0000000067836541 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ed
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:1194ee
page:00000000a7a08c10 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ee
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:1194ef
page:00000000285a6a1c refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x1194ef
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:118f30
page:00000000d3d1a7a2 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f30
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:118f31
page:000000005c2adb74 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f31
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:118f32
page:00000000bb78916a refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f32
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:118f33
page:000000001512f2f0 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f33
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process smbd  pfn:118f34
page:0000000045698414 refcount:0 mapcount:0 mapping:0000000063f5da90 index:0x1 pfn:0x118f34
aops:cifs_addr_ops [cifs] ino:98d4b152911bf074 dentry name:"filler.004"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884298abdf8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 7 PID: 1848 Comm: smbd Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
getname_flags+0x4f/0x480
vfs_fstatat+0x3a/0x80
__do_sys_newlstat+0x82/0x100
? __ia32_sys_lstat+0x80/0x80
? __do_sys_getcwd+0x303/0x5c0
? fput+0x19/0x140
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f44ce83fe06
Code: 30 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 c3 90 48 8b 15 59 30 0e 00 f7 d8 64 89 02
RSP: 002b:00007ffc246c6968 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d4ae693780 RCX: 00007f44ce83fe06
RDX: 00007ffc246c69b0 RSI: 00007ffc246c69b0 RDI: 000055d4ae692780
RBP: 00007ffc246c6a80 R08: 0000000000000001 R09: 000055d4ae6771ac
R10: 0000000000000010 R11: 0000000000000246 R12: 000055d4ae692780
R13: 000055d4ae6771b2 R14: 000055d4ae692797 R15: 000055d4ae6771b3
</TASK>
BUG: Bad page state in process dbench  pfn:1a75dd
page:0000000092f64f04 refcount:0 mapcount:0 mapping:000000006ad6f7fc index:0x1 pfn:0x1a75dd
aops:cifs_addr_ops [cifs] ino:98d4b153c0c70664 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff888426551fb8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ah   96.130323][ T2350]  __kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
cifs_readdir+0xbc/0x2180 [cifs]
? cifs_dir_info_to_fattr+0x40/0x40 [cifs]
? __cond_resched+0x1c/0xc0
? down_read_killable+0x146/0x240
? down_read+0x240/0x240
? fsnotify_perm+0x13b/0x4c0
iterate_dir+0x482/0x700
__x64_sys_getdents64+0x12e/0x280
? __ia32_sys_getdents+0x240/0x240
? __x64_sys_getdents+0x240/0x240
? switch_fpu_return+0xe7/0x200
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f294a72e387
Code: 0f 1f 00 48 8b 47 20 c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 81 fa ff ff ff 7f b8 ff ff ff 7f 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 d9 aa 10 00 f7 d8 64 89 02 48
RSP: 002b:00007ffc6f7a81b8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 000055f6e0124340 RCX: 00007f294a72e387
RDX: 0000000000100000 RSI: 000055f6e0124370 RDI: 0000000000000006
RBP: 000055f6e0124370 R08: 00000000000000a0 R09: 0000000000000c02
R10: 00007f294a7c6220 R11: 0000000000000293 R12: ffffffffffffff80
R13: 000055f6e0124344 R14: 0000000000000002 R15: 000055f6e0122920
</TASK>
BUG: Bad page state in process dbench  pfn:12ffbe
page:0000000058793f2f refcount:0 mapcount:0 mapping:000000006ad6f7fc index:0x1 pfn:0x12ffbe
aops:cifs_addr_ops [cifs] ino:98d4b153c0c70664 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff888426551fb8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 5 PID: 2350 Comm: dbench Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
qlist_free_all+0x6d/0x1c0
? _raw_write_lock_irq+0x100/0x100
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
cifs_readdir+0xbc/0x2180 [cifs]
? cifs_dir_info_to_fattr+0x40/0x40 [cifs]
? __cond_resched+0x1c/0xc0
dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 5 PID: 2350 Comm: dbench Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
qlist_free_all+0x6d/0x1c0
? _raw_write_lock_irq+0x100/0x100
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
cifs_readdir+0xbc/0x2180 [cifs]
? cifs_dir_info_to_fattr+0x40/0x40 [cifs]
? __cond_resched+0x1c/0xc0
? down_read_killable+0x146/0x240
? down_read+0x240/0x240
? fsnotify_perm+0x13b/0x4c0
iterate_dir+0x482/0x700
__x64_sys_getdents64+0x12e/0x280
? __ia32_sys_getdents+0x240/0x240
? __x64_sys_getdents+0x240/0x240
? switch_fpu_return+0xe7/0x200
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f294a72e387
Code: 0f 1f 00 48 8b 47 20 c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 81 fa ff ff ff 7f b8 ff ff ff 7f 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 d9 aa 10 00 f7 d8 64 89 02 48
RSP: 002b:00007ffc6f7a81b8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 000055f6e0124340 RCX: 00007f294a72e387
RDX: 0000000000100000 RSI: 000055f6e0124370 RDI: 0000000000000006
RBP: 000055f6e0124370 R08: 00000000000000a0 R09: 0000000000000c02
R10: 00007f294a7c6220 R11: 0000000000000293 R12: ffffffffffffff80
R13: 000055f6e0124344 R14: 0000000000000002 R15: 000055f6e0122920
</TASK>
BUG: Bad page state in process dbench  pfn:18f76a
page:0000000011b33e6d refcount:0 mapcount:0 mapping:000000006ad6f7fc index:0x1 pfn:0x18f76a
aops:cifs_addr_ops [cifs] ino:98d4b153c0c70664 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff888426551fb8
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 5 PID: 2350 Comm: dbench Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
qlist_free_all+0x6d/0x1c0
? _raw_write_lock_irq+0x100/0x100
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc+0x13c/0x300
cifs_readdir+0xbc/0x2180 [cifs]
? cifs_dir_info_to_fattr+0x40/0x40 [cifs]
? __cond_resched+0x1c/0xc0
? down_read_killable+0x146/0x240
? down_read+0x240/0x240
? fsnotify_perm+0x13b/0x4c0
iterate_dir+0x482/0x700
__x64_sys_getdents64+0x12e/0x280
? __ia32_sys_getdents+0x240/0x240
? __x64_sys_getdents+0x240/0x240
? switch_fpu_return+0xe7/0x200
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f294a72e387
Code: 0f 1f 00 48 8b 47 20 c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 81 fa ff ff ff 7f b8 ff ff ff 7f 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 d9 aa 10 00 f7 d8 64 89 02 48
RSP: 002b:00007ffc6f7a81b8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 000055f6e0124340 RCX: 00007f294a72e387
RDX: 0000000000100000 RSI: 000055f6e0124370 RDI: 0000000000000006
RBP: 000055f6e0124370 R08: 00000000000000a0 R09: 0000000000000c02
R10: 00007f294a7c6220 R11: 0000000000000293 R12: ffffffffffffff80
R13: 000055f6e0124344 R14: 0000000000000002 R15: 000055f6e0122920
</TASK>
BUG: Bad page state in process dmesg  pfn:1be734
page:00000000c592dcf7 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be734
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be733
page:0000000065e98b84 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be733
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be732
page:00000000edbb7a50 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be732
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be731
page:000000003670a98b refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be731
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be730
page:00000000f97030bd refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be730
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be7bf
page:000000006de13f3c refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7bf
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be7be
page:00000000ba1b916d refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7be
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be7bd
page:00000000a18d56de refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7bd
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be7bc
page:000000008de84177 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7bc
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be7bb
page:00000000da80f945 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7bb
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be7ba
page:000000007670454c refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7ba
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be7b9
page:00000000a6758727 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7b9
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be7b8
page:000000005f881c8e refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7b8
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be673
page:00000000d4ef2f42 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be673
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be672
page:00000000ee79b635 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be672
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be7b0
page:00000000408161c9 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be7b0
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be83f
page:00000000c2f97082 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83f
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be83e
page:00000000d24fd54f refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83e
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be83d
page:000000003ef7fe46 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83d
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be83c
page:00000000f71df2f6 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83c
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be83b
page:000000002b1c8a2e refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83b
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be83a
page:0000000086fdc037 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be83a
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be839
page:000000007e5c1c18 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be839
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be838
page:000000005e15c0c5 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be838
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be837
page:00000000097b92db refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be837
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be836
page:000000006bb9da6f refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be836
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be835
page:00000000c88ac0ed refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be835
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be834
page:000000000287d1cd refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be834
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be736
page:000000009ccecaff refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be736
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be735
page:000000007ad36b12 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be735
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
BUG: Bad page state in process dmesg  pfn:1be832
page:0000000021aa85b8 refcount:0 mapcount:0 mapping:00000000b6d68789 index:0x1 pfn:0x1be832
aops:cifs_addr_ops [cifs] ino:98d4b153c17e2164 dentry name:"BASEMACH.DOC"
flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000000 dead000000000100 dead000000000122 ffff8884299bd870
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
CPU: 3 PID: 2399 Comm: dmesg Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x34/0x48
bad_page.cold+0xc0/0xe1
free_pcppages_bulk+0x454/0x840
free_unref_page+0x2a0/0x440
__unfreeze_partials+0x16f/0x1c0
? free_unref_page+0x2ab/0x440
qlist_free_all+0x6d/0x1c0
kasan_quarantine_reduce+0x159/0x180
__kasan_slab_alloc+0x48/0x80
kmem_cache_alloc_bulk+0x1b1/0x380
mas_alloc_nodes+0x257/0x6c0
mas_preallocate+0x23c/0x300
__vma_adjust+0x2e4/0x1580
? vm_area_alloc+0x100/0x100
? __ia32_sys_mmap_pgoff+0x1c0/0x1c0
? vma_expand+0x9c0/0x9c0
__split_vma+0x224/0x500
do_mas_align_munmap+0x1f0/0xec0
? security_mmap_addr+0x3c/0x80
? __split_vma+0x500/0x500
? do_mmap+0x70d/0x10c0
? mas_find+0xd6/0x1c0
__vm_munmap+0x131/0x240
? do_mas_munmap+0x240/0x240
? get_random_u32+0x300/0x300
elf_map+0x1c4/0x240
load_elf_binary+0xa40/0x2780
? load_elf_interp+0xa80/0xa80
? kernel_read+0x5d/0x140
search_binary_handler+0x18a/0x480
? open_exec+0x80/0x80
? nr_iowait+0x180/0x180
exec_binprm+0xd6/0x480
bprm_execve+0x489/0x840
? bprm_execve+0x68/0x140
do_execveat_common+0x4c8/0x680
? getname_flags+0x8e/0x480
__x64_sys_execve+0x88/0xc0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f089fb17087
Code: Unable to access opcode bytes at 0x7f089fb1705d.
RSP: 002b:00007ffe6902b998 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055a6e01b8f88 RCX: 00007f089fb17087
RDX: 000055a6e01b5f48 RSI: 000055a6e01b8f88 RDI: 000055a6e01b6240
RBP: 000055a6df0bb46e R08: 000055a6df0bb470 R09: 000055a6df0bb47b
R10: 0000000000000040 R11: 0000000000000246 R12: 000055a6e01b5f48
R13: 0000000000000002 R14: 000055a6e01b5f48 R15: 000055a6e01b6240
</TASK>
------------[ cut here ]------------
kernel BUG at mm/rmap.c:1041!
invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 4 PID: 2351 Comm: dbench Tainted: G    B              6.1.0-rc1-00014-g68e9d45f5b0e #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
RIP: 0010:folio_mkclean+0x183/0x1c0
Code: 03 74 29 a8 01 48 8d 74 24 30 ba 00 00 00 00 48 89 ef 75 0f e8 ce fa ff ff 44 8b 44 24 20 e9 63 ff ff ff e8 3f f6 ff ff eb ef <0f> 0b 48 8d 74 24 30 48 89 ef e8 ae 0a 0b 00 eb de 48 89 ef e8 24
RSP: 0018:ffffc90002e07898 EFLAGS: 00010246
RAX: 0017ffffc0000000 RBX: 1ffff920005c0f13 RCX: ffffffff8172db72
RDX: fffff94000afe371 RSI: 0000000000000008 RDI: ffffea00057f1b80
RBP: ffffea00057f1b80 R08: 0000000000000000 R09: ffffea00057f1b87
R10: fffff94000afe370 R11: 0000000000000001 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffea00057f1b80 R15: ffffc90002e07b90
FS:  00007f294a667740(0000) GS:ffff88837d600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564db5b63000 CR3: 0000000434706002 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
? rmap_walk_file+0x3c0/0x3c0
? page_vma_mkclean_one+0x5c0/0x5c0
? __traceiter_remove_migration_pte+0xc0/0xc0
folio_clear_dirty_for_io+0xcf/0x440
? folio_wait_writeback+0x5a/0x140
wdata_prepare_pages+0x211/0xa40 [cifs]
cifs_writepages+0x7d3/0x1800 [cifs]
? wdata_alloc_and_fillpages+0x540/0x540 [cifs]
? cifs_readpage_worker+0x3c0/0x3c0 [cifs]
? balance_dirty_pages_ratelimited_flags+0x94/0xd00
? generic_perform_write+0x316/0x500
do_writepages+0x175/0x600
? writeback_set_ratelimit+0x140/0x140
? _raw_write_lock_irq+0x100/0x100
? __generic_file_write_iter+0x218/0x440
? cifs_put_writer+0x93/0xc0 [cifs]
? cifs_strict_writev+0x5b9/0xc40 [cifs]
? _raw_spin_lock+0x81/0x100
? _raw_write_lock_irq+0x100/0x100
? wbc_attach_and_unlock_inode+0x21/0x5c0
filemap_fdatawrite_wbc+0x119/0x180
__filemap_fdatawrite_range+0xa7/0x100
? delete_from_page_cache_batch+0x900/0x900
? _raw_spin_lock+0x81/0x100
? _raw_write_lock_irq+0x100/0x100
filemap_write_and_wait_range+0x5c/0xc0
cifs_flush+0x139/0x300 [cifs]
filp_close+0x9b/0x140
__x64_sys_close+0x2c/0x80
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f294a757083
Code: e9 37 ff ff ff e8 6d f5 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007ffc6f7a8398 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 000055f6e0121990 RCX: 00007f294a757083
RDX: 000055f6e01227d0 RSI: 00000000000026df RDI: 0000000000000006
RBP: 00007f294a883228 R08: 1999999999999999 R09: 0000000000000000
R10: 00007f294a7e7ac0 R11: 0000000000000246 R12: 000055f6e01226b0
R13: 00007f294a883228 R14: 00007f294a883278 R15: 000055f6e01227d0
</TASK>
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr sd_mod intel_rapl_common t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 sg x86_pkg_temp_thermal intel_powerclamp ipmi_devintf coretemp kvm_intel ipmi_msghandler i915 drm_buddy intel_gtt kvm irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ghash_clmulni_intel ttm hp_wmi sha512_ssse3 ahci sparse_keymap drm_kms_helper libahci platform_profile mei_wdt video rapl rfkill wmi_bmof intel_cstate intel_uncore mei_me syscopyarea libata i2c_i801 sysfillrect serio_raw i2c_smbus intel_pch_thermal sysimgblt mei fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_mkclean+0x183/0x1c0
Code: 03 74 29 a8 01 48 8d 74 24 30 ba 00 00 00 00 48 89 ef 75 0f e8 ce fa ff ff 44 8b 44 24 20 e9 63 ff ff ff e8 3f f6 ff ff eb ef <0f> 0b 48 8d 74 24 30 48 89 ef e8 ae 0a 0b 00 eb de 48 89 ef e8 24
RSP: 0018:ffffc90002e07898 EFLAGS: 00010246
RAX: 0017ffffc0000000 RBX: 1ffff920005c0f13 RCX: ffffffff8172db72
RDX: fffff94000afe371 RSI: 0000000000000008 RDI: ffffea00057f1b80
RBP: ffffea00057f1b80 R08: 0000000000000000 R09: ffffea00057f1b87
R10: fffff94000afe370 R11: 0000000000000001 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffea00057f1b80 R15: ffffc90002e07b90
FS:  00007f294a667740(0000) GS:ffff88837d600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564db5b63000 CR3: 0000000434706002 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled

--TVg/s+Co+epUfstr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/xfstests-cifs.yaml
suite: xfstests
testcase: xfstests
category: functional
need_memory: 1G
disk: 4HDD
fs: ext4
fs2: smbv2
xfstests:
  test: generic-group-12
job_origin: xfstests-cifs.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d07
tbox_group: lkp-skl-d07
submit_id: 6351d3ca7ebdde7e6116a638
job_file: "/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-97889-1ebtio4-0.yaml"
id: 8bd0f5047bb2ec26ff5779fb165b4c2c52e7e6c3
queuer_version: "/zday/lkp"

#! hosts/lkp-skl-d07
model: Skylake
nr_cpu: 8
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/disk/nr_hdd
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- EXT4_FS

#! include/queue/cyclic
commit: 68e9d45f5b0e8ca96c02dc221a65e54d859303ff

#! include/testbox/lkp-skl-d07
ucode: '0xf0'
bisect_dmesg: true

#! include/fs/OTHERS
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2022-10-21 07:03:39.291957552 +08:00
_id: 6351d3ca7ebdde7e6116a638
_rt: "/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 21ef9e7031c1b2d51db5b2bfba2019e7fa3451cf
base_commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
branch: linux-devel/devel-hourly-20221018-182852
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv2-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/vmlinuz-6.1.0-rc1-00014-g68e9d45f5b0e
- branch=linux-devel/devel-hourly-20221018-182852
- job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv2-generic-group-12-debian-11.1-x86_64-20220510.cgz-68e9d45f5b0e8ca96c02dc221a65e54d859303ff-20221021-97889-1ebtio4-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=68e9d45f5b0e8ca96c02dc221a65e54d859303ff
- max_uptime=2100
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs2_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20221017.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-5a5e419-1_20221017.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20221019174310/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.1.0-rc1-wt-ath-02875-g14754fd1113c
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/68e9d45f5b0e8ca96c02dc221a65e54d859303ff/vmlinuz-6.1.0-rc1-00014-g68e9d45f5b0e"
dequeue_time: 2022-10-21 07:29:40.433870591 +08:00

#! /db/releases/20221020110634/lkp-src/include/site/lkp-wsx01
job_state: running

--TVg/s+Co+epUfstr--
