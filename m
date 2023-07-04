Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF37466ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 03:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGDBlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 21:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGDBlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:41:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254DAE4E;
        Mon,  3 Jul 2023 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688434896; x=1719970896;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+5+xGinDoOC+dX1hr31DAy+3hygUp36IsuwlQ0lfwys=;
  b=jSvP8QOm26HdG66KUoDiLVa6Dt9b3XJJEWYodVBpRd2UZGnqsk/5wcZP
   Sp+fGHH/b34DjHmrQ4gU9lYLOjLWst+1Y5GoZJjAs24Bxc/tup5Joel+4
   soNTAZshMP9rAvYy9zig1QANPSLq9MBaXWSGiXI7AkbdiKLbi74z1AvjL
   78tu66Yf80SmwC7iRnQtysrCzGU7m73heVIEOx3idNITO+1Zu1nDH1fDO
   hiOm2w+he741QbNMRV6+7x5v5i3e7cZ1DB3h+dztoZwlt1BKvEA6z3DDV
   GsLunqBMGY1Dkb7wy1j8CbS8uKSNRgaIoE6Q52ccoNeeajVDeItjzrYUl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="352832219"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="352832219"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 18:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="863240045"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="863240045"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 18:41:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 18:41:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 18:41:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 18:41:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A29QJkA5YrAf21UhPoHHDWJXI3ZRZz5a6JfC65TN/mYxYxs/8rKrMUDE01ghRxoW5yJHxlsr/5xDFIX2H8OpOa1YShF2YQ2fa+b/x53NsVKGzPf7OOQZCwoOlxEKIDt3+775mJE19YiB/rziCHWj66KHh2beg1W8N+XYwqhO5uTFq5EY6T9bU2LvOZAqd6HCUnYG0BPjt6OWiqWtzMU2lRK8ZFiM5P58zKY3wFbevIpMFh16s7jd0DQUIzxxw5aSxDK4JtJ7o6rmafUiaoNHyF/ZHy1U6paYVL0SqrkaG9BjczfKnruAChAtnrgtmv7uU522CVX6Ur+g/KpQwIYs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv855n9ZI4L+4Gnj/IKLhKxQ9RahuSYBgFk/OwHDeBE=;
 b=ECMD10OqUC+hyY6Y7LVJAz8gejGiBk71xE8eHLv4e6bJrby6Q6cAEAA4zEJY6DbjYdHZWj5ekbDl7cGS40ZqQr4wvFkkynQkYMfyxjbDVp2XDqD7VjkpzUwf/T5ZmvSewchUPfhHU+xOzaXRJ/Ynf0zqYUaXlELN0Eh+OWipiuM+8gEChJJagNwT2HAvWnPWvY272ExivGAvIiy3PUXXC+4LgG1Bd8cOoO5d58Chac9lo5ROxNsFh39KSbZenDpcAxcXreGeN+Kjw426oPpEIIKy3wDfe8eKJKbYa7biFQPdPzCdcOp+w8Gn7IUDEnhG+QXF3szMtu5SPaoe9oc/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7265.namprd11.prod.outlook.com (2603:10b6:930:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 01:41:31 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 01:41:31 +0000
Message-ID: <d6957a20-db31-d6ac-8822-003bdb9cd747@intel.com>
Date:   Tue, 4 Jul 2023 09:41:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v2] readahead: Correct the start and size in
 ondemand_readahead()
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <ackerleytng@google.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <oliver.sang@intel.com>
References: <20230628044303.1412624-1-fengwei.yin@intel.com>
 <20230703184928.GB4378@monkey>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230703184928.GB4378@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 115231a3-3560-4428-4211-08db7c2fcac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRcz1qpsw4HU/ZhSp+om1NOXjg4m3syfIRU14rZ4iO0nPaxGC/De9aOvvy4Qn3ZbTP0tRO+g8gVDfuXdXYTPA4BtVjVscK79apR/RiRS7hCettSX85oE7ljMSTqqlBMaebvP/aYpAT8fdyAMEARGQRzStx46QrAf73qnfdpHg+WCogmatLXW8xqJlszIpzcjQwYRma5cO+cAKC6cg3Ied/nK5oepzYSlTLI4VMz3tGyunOtl6b9Q80T6gKbu1tTPALpt/Ldv50unb8i67zMvIPlfM2JqMLEWZ872G4wxE6jVjcdzsNqDH5VpJSwHFIs3E2BySXeS+14N8MgptyKRtaqx3lVOm4u3cZmI6IhSndThq5KHE0Y5Bstwnswr8JO/tHCD4lTJggXk6iMnQWefR5JYjGZw9960F9af+6GtEJ0RMrCXJxa9k80CImIomnuyxPkrgMGxicLdUalFhBHg1bpGnxbz5todpARKM4s09jKpDUs777IV16LLb9YL9vsxEXNEGSXiI+KwWPZJ5eGXDUm8W4Jy+cwqe0TexcllIYeXJPhrnIdYun8ZttBPXfTMP8W3USU+n1K+t67gayglDgu5HR8vYB4f3BzNH9oyksyWE5woJ4VdksQNLd3+1zTqYfXmQ0wMO7iTcA6Nbj9s1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(31696002)(41300700001)(86362001)(38100700002)(6486002)(6666004)(2616005)(82960400001)(107886003)(83380400001)(186003)(6506007)(53546011)(26005)(6512007)(478600001)(2906002)(316002)(36756003)(66476007)(6916009)(4326008)(66946007)(66556008)(8936002)(8676002)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2lmMWJYSUttTW8wc1JpN1B5NVZrQW8vRzdtanFaWEZsWUFGMmJQTXJZMG1U?=
 =?utf-8?B?V2I1Wm5SelgyN1E1aEJNK3ZoR29ZM3ZHaktZN3J5OFhYSk9lcjlIVnl6VS9n?=
 =?utf-8?B?QjBheWdJSVFIWEw5WGVUK1pPdStySFczVVdrTlY5L0k0Y0lBQnlIbENxZjg2?=
 =?utf-8?B?RStKV2FQb3h6TmxxV2swWGVGWS9xMndQWTROOFVKVXcwNHNLZi83YWRXd2Qz?=
 =?utf-8?B?K0tJOGMzVVQxZ040YzE1MVZvakEzbEZNblU5b1h0WHhJdzVtemhlWC8ybkFV?=
 =?utf-8?B?N2F1Y3lkNXZIbGtTRzFweWhYS2g4MmNZbE1MWHR5Nm9MZHBlby9YYVM0VHZl?=
 =?utf-8?B?Q1FoNkZNZi9TN1BhWi9keDB6ZEJkSExvUHh3WSs0WFNwN1ZzazByWjBIdXlt?=
 =?utf-8?B?MjQ5SWRVK2laZVJkTTR5cTdUTDRISjk5SFNHRjZoMUlYOWptSGgydVg2cXQ3?=
 =?utf-8?B?YmM4azZIdGg3VHdtR21Id0U5cytwc0Vqd2xoNHpSVXJ2SWlKemVweExlOU5x?=
 =?utf-8?B?L3BQQ1MvZkx6MCtuaDRabWN1VFh0NkNEb2NkaWU2ZFhFZ3NidTlhZTRlTC9N?=
 =?utf-8?B?ZlQvZ3E5SytMVDVsMGpqbEZaMjVwSWhCUnZweFY0eWcxcGNrZnR5ZVVOeVRI?=
 =?utf-8?B?aWxqZDFiY3pHR1VHY3R6cCtDeEN0TFFKdUJ0MXVBcG1RSnptandiVGVMZURh?=
 =?utf-8?B?RjNYV3M3bXNvYXNnTWUwbU5XN3RZQWZzYllXQTJZK3ZKczlaK0QvVTUyalQz?=
 =?utf-8?B?aFJteDhsNDd0Mkd4MGhFSVhSQzk4dklDRzlidUhBR0xaYzF0Q21KT29HKzFD?=
 =?utf-8?B?dWIyWHVpZExqbmxKTGt5bXFQNmhqM3hWdkhTOHdUcnU5ek1VQlZsSWo2MUlJ?=
 =?utf-8?B?bHA5MEFLUTE0QnNabWNkNi9VZjRqdmlHOUFuUTVIaGdzQm94ejZjWGlCejdU?=
 =?utf-8?B?cEEzN0pqd3FUZFJzV0xVY2g5dVpKTldZTUN1MHV0R0ZybzJDT0FLRWJYV2Rt?=
 =?utf-8?B?clpUaFpSNEpDT3AxOWxJZHM4VlFnRENqbUMrMFRrL2ZENS9IS3ZMS3BNQnUv?=
 =?utf-8?B?bXV1V2t1WFdwLzVUcTVTRXV0YUxBcnJmd1hLc29WNDlKV3Z2VlF4RE9nN2N4?=
 =?utf-8?B?ZXFIVEsyeVJ1elpleUEvU3cvSkw4TEZiS2hscThHUjJ6YktxQ1NhYVdvRkpp?=
 =?utf-8?B?WWovNCtiZjdYV0lCTi9hZmtxWUlnWk9QYzNIem1YUDFuZkE1dXowWUpBRmtN?=
 =?utf-8?B?M1Z4Y0NHVWFzR05KSHI0UTdBaVBORjB3MGNNZlhXNVhHRnhlQkhuSTRoand4?=
 =?utf-8?B?ejdSeWN0Z0gzT3libUFNRVJmZk5qUDdONGc5blFTaGI1WUNoYml5dVVJME1K?=
 =?utf-8?B?NDhVOVlJVWJZRlRvMEpqeGgxeG1zdTJYMk82RFQ2alRhZ2ppWDFReHdPSW9N?=
 =?utf-8?B?K01keFdKd3ZONjNaR1dXQnJBT0dBWnEzcEI0MEdJREJCTmFrdVIzMXlYbVVG?=
 =?utf-8?B?NzJBYVRjb1p3blhyZGEyalRPSWVFdDNNOVpaK3FzTm16VWVCd3gwODZPb3Az?=
 =?utf-8?B?TVpMNzJidmFqOGVlUmc5WlhyRlFzNmRBRUlDMkg5bFB4QWZSLzBnYXJRWlRB?=
 =?utf-8?B?M0Y1Y013OXRoZGxrWjc5S2pOY2QyRG4vM0dUTEcyTEtJWUtrczZidERZVGpj?=
 =?utf-8?B?WStnYnRkWUZtLzBZRkU0Q2JycUhyMlpScUJ3Q3BJMlVwYW0wV01lTHhhbU9C?=
 =?utf-8?B?VGF0SDUxRnJwMUx3QkJDYU9NU0NyRXkvaFBrU1RuY2JFVkdEeFF4NWwwWkRu?=
 =?utf-8?B?SmRWdWF0VUdDVFIrNkZTWHd6K1pUUW40SGE4MlV3SzYzL21XRzBLVTVhRVhi?=
 =?utf-8?B?cEE4MFhxWDVmQXo1Y1RDRDhQUWNreGp2SW14Q0xFSm9EdUJzWnBxOG03MmRJ?=
 =?utf-8?B?RTlrNmFnM1haSU5XZ1d4cUJVNmVrWTNRNnZXWjE5ME4xS0ZON3lVTThjd2FT?=
 =?utf-8?B?NlhJaFlDYjd1R0ViWnB6bWcwRnN2RG1qTXIzODhZNzBta0NhTkg0VTJZcHpx?=
 =?utf-8?B?R2pGemlvUzlSSk0zeTZuRjdidklVWThET0N5eVBWVGFQOXErcUYvcDJBbUYx?=
 =?utf-8?Q?xwDjTzi1fTWA84m8/uIWNqz6F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 115231a3-3560-4428-4211-08db7c2fcac9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 01:41:31.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3qs5zf4GB0ndpi6AIEN8XuI/zK3M7iHaiKir3zKH4WP1lYAS5tGrFJT9bT3eqF48g+oGW4knjChFzO9XJRWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/4/2023 2:49 AM, Mike Kravetz wrote:
> On 06/28/23 12:43, Yin Fengwei wrote:
>> The commit
>> 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
>> updated the page_cache_next_miss() to return the index beyond
>> range.
>>
>> But it breaks the start/size of ra in ondemand_readahead() because
>> the offset by one is accumulated to readahead_index. As a consequence,
>> not best readahead order is picked.
>>
>> Tracing of the order parameter of filemap_alloc_folio() showed:
>>      page order    : count     distribution
>>         0          : 892073   |                                        |
>>         1          : 0        |                                        |
>>         2          : 65120457 |****************************************|
>>         3          : 32914005 |********************                    |
>>         4          : 33020991 |********************                    |
>> with 9425c591e06a9.
>>
>> With parent commit:
>>      page order    : count     distribution
>>         0          : 3417288  |****                                    |
>>         1          : 0        |                                        |
>>         2          : 877012   |*                                       |
>>         3          : 288      |                                        |
>>         4          : 5607522  |*******                                 |
>>         5          : 29974228 |****************************************|
>>
>> Fix the issue by removing the offset by one when page_cache_next_miss()
>> returns no gaps in the range.
>>
>> After the fix:
>>     page order     : count     distribution
>>         0          : 2598561  |***                                     |
>>         1          : 0        |                                        |
>>         2          : 687739   |                                        |
>>         3          : 288      |                                        |
>>         4          : 207210   |                                        |
>>         5          : 32628260 |****************************************|
>>
> 
> Thank you for your detailed analysis!
> 
> When the regression was initially discovered, I sent a patch to revert
> commit 9425c591e06a.  Andrew has picked up this change.  And, Andrew has
> also picked up this patch.
Oh. I didn't notice that you sent revert patch. My understanding is that
commit 9425c591e06a is a good change.

> 
> I have not verified yet, but I suspect that this patch is going to cause
> a regression because it depends on the behavior of page_cache_next_miss
> in 9425c591e06a which has been reverted.
Yes. If the 9425c591e06a was reverted, this patch could introduce regression.
Which fixing do you prefer? reverting 9425c591e06a or this patch? Then we
can suggest to Andrew to take it.


Regards
Yin, Fengwei
