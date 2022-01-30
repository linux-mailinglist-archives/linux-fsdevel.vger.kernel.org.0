Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1434A3388
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 04:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353847AbiA3Dc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jan 2022 22:32:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:54986 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233631AbiA3Dcz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jan 2022 22:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643513575; x=1675049575;
  h=message-id:date:subject:references:in-reply-to:to:cc:
   from:content-transfer-encoding:mime-version;
  bh=95jIHp5Iv+v+3CbkJ8acneH+5VJQWi280Ke1yZOj9dM=;
  b=DEdbkdP9Q0H1JNhNZxvVhITA5OiiClHKlhAivH4ZxG2VNfU67IVCOvYx
   ZWg4vJTksqbtbOpdli3VsqokBz0mpDm/XfFwcPOqL1y1/tM440pxG4KDJ
   f7dHcF5Ba7Ub/8ti+h+HP1Ea0MDePYPmY8LDmt/H6GkvKF51gjAO9DncT
   WXdq3CUDy3Ih0xVzV1Xz60iNI0FCVm/0XrHPUJk15UjurODj3BuNJUCnf
   N26MXY1oZX+DqsBHbl8RU9i+FRFYKLDPK4AR9xi7W0hpA4swO0x/niX24
   MSW5cKWNV+eMUk2MO0+zjb7Bb/w6yW2blFBTxMN79qTSeNlzY72TL3rB4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="227288753"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="227288753"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 19:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="564594763"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2022 19:32:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 29 Jan 2022 19:32:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 29 Jan 2022 19:32:54 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 29 Jan 2022 19:32:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNFuRsk1VJRkS94GY81SkzQH6SGzClqOPhFxOdLsIM7Zd3AqrBZxNrMFXsu+laa2Gb4QT+MOc4CmVegXfkiIRmcSVx4GIZkMAhg/iJS6k2oXzd4RGRIyOSdKkinFuNTysD9MN+/59VKFI4vAMpui0CCXq7NS/9LKQgirKGU8LkPeO3Yj/uJ/UcVR+AYN4d9N68h+lc9HdYIHb67gAfenYpKcj8lL34XqLBbwYY7hokdKqTSZp7e+orHyvVGlPzr8IRphluBBkxRykWtjaoMg2N/BHZ01/Ps6WNIhoL6oWfTWaGiNBeTJoCZEJ77+bb0EtaYAfwurDeBxEbbu3kB2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJw7hfzLH7nrUtCJ5FhkY94HUfFtCtCHMDYHURmdjOA=;
 b=jDPfCPViJJlc3d8RcJtUH0Ef+eCpfxZ9cw1e36OA9yJ88xVf33AI+8xKwjhVaRqpWkJqHP1cl/R66JePUjSYv3G5WaMjaiXfhVn/A+fSjhe39Yav4zypfOew8BZxuN57PzZyzfjOgem1+Dy5o9zlUZ3TaRBtASINkAGdO1uPvZZu7agl8lk4L1bpYLatkjLvwCutvjGJItOwDNRQd/VbdGUQNTNiiduO0FRboXXncAjoY9cScW2R15HqSFb41OlQhnoDf2zdS1MfFvHJgPo5EGuWsSzpyEoKMI9k/sljPcyTkuGrnvUHeiyFDidtYV6EC6dmHHwTJzHrhjkLR1CjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by BN9PR11MB5419.namprd11.prod.outlook.com (2603:10b6:408:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sun, 30 Jan
 2022 03:32:51 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%6]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 03:32:51 +0000
Message-ID: <1d626480-dce8-03ea-d6ed-f060a17edec1@intel.com>
Date:   Sun, 30 Jan 2022 11:32:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: Re: [PATCH v10 9/9] fsdax: set a CoW flag when associate reflink
 mappings
References: <202201290206.TU7AHhWg-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202201290206.TU7AHhWg-lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
X-Forwarded-Message-Id: <202201290206.TU7AHhWg-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e469a7d5-2104-4bdb-a266-08d9e3a1317a
X-MS-TrafficTypeDiagnostic: BN9PR11MB5419:EE_
X-Microsoft-Antispam-PRVS: <BN9PR11MB541913AA71AACD3FC686E4A3FB249@BN9PR11MB5419.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nf+iopEzPElKG0Z3B/his/GUSwijHTMG557geNPJKpxIPJsKJFnNZUH0D6P17KjTWUvGGmz5YGBjI8Z9WwdDImXrlJdSuT7ZQ/SRUDaIVqDm0OZRqGTa24Aguw+pnaZCAR66KwzixcekXS65UK48dc6MXdZrmeqV9YDnmo56UJeQerMETL8Jyb+lWRrIKqMBWCPRSO20nkyl/EB76OOwxHbDaqtPM2jXFq1SAu/4dvAN+72CCPr1ubFqz63wALHMwV2CYneaxBUh8qozPSreorRdZn08vzxV4FmUFcT03HEFOk4AL43uGxI2FH5RsepFprIVODhMfmephzfZfHY7P1KBP5D3LN9qmQR7e1FaJwqP5fMnUb/y8Fd4z6ilfhuNUL+siA48n6oaAObRUigiAWclY2S7F8B3Y+qAPTJT8tagAjqodXxXrvf4/MrGXXI5/KCltzrVzdnU6YZUiWPPwLylaYtuNfiT1Mi7OrByPJgxGUVIAS2H2WE4mzfG0uzhaF7pA1WD6a+zqumrG2Uoe6lNk0nFQerW0fup597Kan4UNTKMKAySd2a3uY5O+M1FYv3XtEAGlIqsW6e8y2PeCvFE7zlZkMQdUylLc1GgFr+8daBB4gtEGMRr+fHQl9++19BSKvJR5D7DfEQ30r0r4OU9oWoIPxK6BmwkKhHCAWcBJanqcGYD/PZgDqvYjsKwT62jmHy4FjR1tL72JkL7X85iCU7yM1tSbVe/6LBjWbpd8E6pFw/Uaw/6k+fg5yBOxrkWjCBnltj8HuiPfHNoiXTMzmcRSh8+tmtXyvIidRhHAYu6WfEWlOktt42FFoXb9mouaIM3KtBVYYuTsaVUyoE82XDwJgAl1lK+ODYAmpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(5660300002)(66946007)(186003)(66556008)(8936002)(66476007)(316002)(8676002)(4326008)(6666004)(38100700002)(2616005)(4001150100001)(31686004)(36756003)(83380400001)(6512007)(6916009)(2906002)(6506007)(966005)(86362001)(6486002)(508600001)(31696002)(82960400001)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE80b1JOSmpBL3h6MUE5SkJVak8vQ2MrK05OU085MDRUQlpaWHN4V0hhYU5r?=
 =?utf-8?B?RjdIcHFOcGgxOTRrNnl3RkxhWU5SV2YyVndLYWVFaWZiWUU4L0dnOXhUd2ho?=
 =?utf-8?B?TEc4eEh0SngrbEVheVlqSVFCZFRteUJOMEI2QXpKQW0vU2pNMnVsQStaZzVs?=
 =?utf-8?B?UXg3ZWlzUUxmV3JtR29jNEdMK1A2ZEhQTmpCVW5rRll1STYwOHBuK3dneHho?=
 =?utf-8?B?dkswZ3VvamxFMVBuV0I0am83ODBGbjdwbmo2UXVaOE5JbUhPMEJNTVhYMHFy?=
 =?utf-8?B?UGhVcXM4ejVrMnUzWDJ1QmpsUVJOSDE5OTJZVytYMkxqbEUwbEJ6c2w0VjYw?=
 =?utf-8?B?NVlhQ3pickg4WWZGOVRaZHBFRk80UmljQTgzM3VxNnZJc1ZIc3RxOXh3eWtF?=
 =?utf-8?B?SzFkb2RXeUlPVUR2MTBDUm9RcEcrUG4vdTF5Ylh2L2hRckdyemlyQTNKNmtQ?=
 =?utf-8?B?ZlRzZ0pTTVY3RWRseXF2a2pCOVllK2JSSWtFUlc2NWFLZ2NpZ3ZrSVNTY1U1?=
 =?utf-8?B?b3JON2gvSDdna0FBdkRlbW1tdU50QmhiajY3SzJWcDBjNVFYS2dVSnJKanhD?=
 =?utf-8?B?ZG9xdGpmd1ZWZ0tPU1pJZUF3MjZ1OXVPakV0WDVSZUZ2clhpZEd6c2s5L0RM?=
 =?utf-8?B?SklLUU5sQjVNblc0M1BHRng0TTVMRStkV2VtUUdWUjRDVkJrMExpbzBRb3h2?=
 =?utf-8?B?bjdDVXM1cklzOE1GWE43V1VzODJiMEdpMFZKV2RKS0VRaTUwQzdUb1ZEdXlv?=
 =?utf-8?B?YXJRNUFTcStUUUxuaFBqb3VKbm9rRTc1V0hTVFRPb2k0L05pTzBNdi9pdHZT?=
 =?utf-8?B?eG0zVlUzN1RTZ29TZVk1aHVQZlA0OUpqclk4d3lPR21ZK3NoNGZhZG9INmhi?=
 =?utf-8?B?WW1KWHIvS2hWTFhqNnlqcHBycmtMOU5KRDFLbnVTRTYxWVZtc1grc2ZjeHph?=
 =?utf-8?B?blJkWkgybWNJb08walVlaC91MkZnb2VtS1FNODJJQVZWVDJnMFdsWmZHZFp0?=
 =?utf-8?B?V0J6czI5U2VFQUk3QnhpMzZDMDRNWWhkTHdHWW9Gemc4VDl6YjFLb1pEcVdz?=
 =?utf-8?B?SlNaMHcvNEMwZWg1UXEvc1hFN0JMKzIrSENiV0xlQWhhTnpUbFBHVkpFZTNj?=
 =?utf-8?B?UnlPRXRBbHNBU29uU0Noa2wxUXZtYk9pOGUrQmdtVTV6S2xCYjRRMHVlOWlm?=
 =?utf-8?B?QXRMdmNmR05iazdvS05mdUQrWmc1VUVaSVNmN3FrclJhRWtaSEFjOXZEekxV?=
 =?utf-8?B?OGNpWUpYYmtLNmVucTQ4LzJOZFZaTWx4M3ZIZVBvRmFIRFIrZFRlUzVNSmVw?=
 =?utf-8?B?LzE0bVl5MDU5OUZYWFRNODRZZXJUV0tPeWl4UHM2djVNdXZLUmd2ZmxrRXVm?=
 =?utf-8?B?YTZDZ1BsalJZTFdFWXZqdk1HbXpGQlA5MjAzaWZsNjAzdU5NamIrbVRZM0ZT?=
 =?utf-8?B?WG5FWUNGQ3NkMzZTdVVQckFydWR1RExxSFdVM3g2UmpvUlkwc241L1BnVnpF?=
 =?utf-8?B?R3hCalhzZzJBTXNYekhML2tNSUtJZElIQjNLZVpGbzd5ZnZ3aDFJK1IwMnhj?=
 =?utf-8?B?Z0dvMU4vcjhGRDVjM1lEeVdYVlZjSlhpVkNyYURpUmJhbjZyVTFuQXl3V1U4?=
 =?utf-8?B?SER5NkRTNjZGRWgrN2lUUm5pVDBCV1ZFSVNnTDBJSklJWXI5eG5aU2tKZkdh?=
 =?utf-8?B?OUpTbDhaR3RuOTRLUjBWZWx6Z0VaK3lvY2daUG1Zc2tWcEFJNnVsaUtUa0E3?=
 =?utf-8?B?aGlYQWlValNtZllrTWJ3dlR6K3lXdEdQaFNHSVRXa0pNcHJJNEpOY0dRSk5w?=
 =?utf-8?B?NGFsWVZNUFMvL1hJWitGL01HOWN4aXFkUHM4OFlLZkRzUGN5TlBmSWM3UkRa?=
 =?utf-8?B?V2dJMmJoLzVaQmg4eVhPYXA2RW43NUw1MG4wQjd2eUJBN21yM01lRUUwL2sy?=
 =?utf-8?B?d0ZWTXRvZXFXK1ljVVp4MjlELzRHSmdad3pkcHk5UlBuYkJncXBZYXNNUUdT?=
 =?utf-8?B?NzdkWkRGc0h0bzVjazUwNlovVjB4dm50Y2VPZWlqQTFoUC91MERsTVh5VmYw?=
 =?utf-8?B?VkdQdnNuN09WeTJidnY5WmQrSU40bUhzRCtCMUdYMTlHZHJVTklpMTA5R2l6?=
 =?utf-8?B?Rm5KUzRvQTlJRXlVRXRqZHJJTmEvT1U0aXZIdU91WlFiVUpSZ2NldzM4bWFz?=
 =?utf-8?Q?Pl7YBpA6fswvKokRdOcc2Nc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e469a7d5-2104-4bdb-a266-08d9e3a1317a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 03:32:51.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ProPGOch8VHjelR2btPPUEuRmT45uk+Oly208/GMjEjyUv5BY6zW0nvgEQsWtn6za8GrpMPHOabRujCsRNxNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5419
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Shiyang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.17-rc1]
[cannot apply to xfs-linux/for-next hnaz-mm/master next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220127-204239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: x86_64-randconfig-c007-20220124 (https://download.01.org/0day-ci/archive/20220129/202201290206.TU7AHhWg-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f32dccb9a43b02ce4e540d6ba5dbbdb188f2dc7d)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/0day-ci/linux/commit/26822296a70d211de3c5f4ef903d4c4cf29179bd
         git remote add linux-review https://github.com/0day-ci/linux
         git fetch --no-tags linux-review Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220127-204239
         git checkout 26822296a70d211de3c5f4ef903d4c4cf29179bd
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/dax.c:339:2: warning: Value stored to 'mapping' is never read [clang-analyzer-deadcode.DeadStores]
            mapping = (struct address_space *)PAGE_MAPPING_DAX_COW;
            ^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/mapping +339 fs/dax.c

d2c997c0f14535 Dan Williams   2017-12-22  328
d2c997c0f14535 Dan Williams   2017-12-22  329  /*
d2c997c0f14535 Dan Williams   2017-12-22  330   * Iterate through all mapped pfns represented by an entry, i.e. skip
d2c997c0f14535 Dan Williams   2017-12-22  331   * 'empty' and 'zero' entries.
d2c997c0f14535 Dan Williams   2017-12-22  332   */
d2c997c0f14535 Dan Williams   2017-12-22  333  #define for_each_mapped_pfn(entry, pfn) \
a77d19f46a37c0 Matthew Wilcox 2018-03-27  334  	for (pfn = dax_to_pfn(entry); \
a77d19f46a37c0 Matthew Wilcox 2018-03-27  335  			pfn < dax_end_pfn(entry); pfn++)
d2c997c0f14535 Dan Williams   2017-12-22  336
26822296a70d21 Shiyang Ruan   2022-01-27  337  static inline void dax_mapping_set_cow_flag(struct address_space *mapping)
26822296a70d21 Shiyang Ruan   2022-01-27  338  {
26822296a70d21 Shiyang Ruan   2022-01-27 @339  	mapping = (struct address_space *)PAGE_MAPPING_DAX_COW;
26822296a70d21 Shiyang Ruan   2022-01-27  340  }
26822296a70d21 Shiyang Ruan   2022-01-27  341

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
