Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B46DECA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 09:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDLHgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLHgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:36:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702AB19AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681284977; x=1712820977;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IT3iBaqUQpw5hFdP6LVxiSGgkecNGcDpat/1de0MDbs=;
  b=iKS+3qZ26jKsBrRAPrzjgXxpU1SAQktvlcBLZRZJGGrgL39sUIhgZKS/
   wQIyhCMU3EFdTGKTkR68uuQuDcQkC7zHqEHomxWt1L17lseTPN+4tJOt+
   NGPxEoG8Hs1ydsQWWAykHIk2BRZZwIjZGTIMpBx0vtFTRyXo0nHQNJr2M
   y8gtpyezvAztNU2sUgI/7GApp0qcecMVAPJEEDEyn0R/4pfMlAxFe4e9N
   XBfTf0NWWRsxtIuu5socMOU+yR67bqV0C19T2MTLeN75Gc1xpxEsOJ5Nr
   Ge4auEq/1UfTnaAeUF+b2glhc3/p8vARggynxj6mR9zTVl7UpMWWrvS0n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="430113202"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="430113202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 00:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="778213268"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="778213268"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2023 00:36:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 00:36:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 00:36:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 00:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtxX6IqGzYy17Tv//kRaikAntN1k95HqI5DemTCViaiIv6f+dlC2DODSqr/CU9emN2Ue/vDTQ3+j1LVqhscVHPDzdkjEtHAomThZEOYk53RO1K7Gkhz+KS5S1f6CF90tQsSqUNZ4vl5YljHn1RxSb/JD7M5JT0zxuc7AEzQc3eozAOmQtBJFJTZbRM59DrX9zQNHi74++s4EB4pGhik1XnXgtpV/p/3LgLrUlkoNlkeBMrI+nOLKKKcPILkXatoPyc7aIxjNPG9nW6fOuyNj0i+YsWBe3QfvoYs9fzyJgSKSn0/zjGXubpd68i7HyW+Fsg32PU4EMPr04DjagK6vZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GEbOORqZLYrChPUmgcha8UwMfxV2a+9d1m2/0wIGXQ=;
 b=awgslHoiYsGS2rFuGvttrwFFeoKhGVsGS7IZyotQcwOh1uoHGgVDdhg9GYiS1FyUB8MA4ehBRWtLQLDdAJGZplM3zrE9qvDNUlb499b2w40u3M5TejxQh1YK5U4hzBcsdTp31rVqAR1696PeCWpstq52l7CPgTPpOlcdMHh5ID79Oh8bPuQOpJd8oWbDtYuiCD1GryWTOCsf36+Mbdl0q1c4SFmwjzoeju/nt1nnu/VRcAu0eJIHnSgdvcoc0/jvXxjJunErUqs5nGt1/e3miJw67sP0/0lZ6wL5pimg0ULu3duKwYteG9yflaYjv4hzEoH+q96LPX3RA3JV0cavcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Wed, 12 Apr 2023 07:35:57 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f670:cacc:d75f:fcc4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f670:cacc:d75f:fcc4%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 07:35:56 +0000
Message-ID: <4e8b083c-cdb4-a5e3-abb5-2aae259bd2d7@intel.com>
Date:   Wed, 12 Apr 2023 15:35:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH 6/6] mm: Run the fault-around code under the VMA lock
To:     Matthew Wilcox <willy@infradead.org>
CC:     "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Agrawal, Punit" <punit.agrawal@bytedance.com>
References: <20230404135850.3673404-1-willy@infradead.org>
 <20230404135850.3673404-7-willy@infradead.org>
 <ZCxA+DYkzVWbLAod@casper.infradead.org>
 <1c700db59114617ca0a7b6e40754a6ea0dbb86e0.camel@intel.com>
 <ZDQZBdJNiG0lIw2v@casper.infradead.org>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZDQZBdJNiG0lIw2v@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d023ec-876e-413f-7781-08db3b288db3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eG28absmxGSla/+xfCFJIV5gtQTzD0P8z0DO8Lci9W6I3xPYQZPwO1GUwkPk82NnpwAwLV/g63LSkyDExN7WHVg56z7TA3PU3AbalWhpJZiWNaaFsLqieG6ATGjdCzYRMjma6H4ttKlz03RNG+pYRzO9QdvXcfLFOzh5DwoBNAGqzJAnXp5W4bBaVK6Hzcqy/tBKrKT8pkvHmcA8BQ5vBiCAQb/jwxvHixxpPpQ9j7Wd94/gw8Cf9bMXau+LTL2+okbKwbnq3H2Dcx96b4ZYP5Rw4Qe7GpiBlTb3QVfz7pjlj9N0kfsqMtZEvts4akhgdzxHv1kBOBmqUOVA27HdqnaL6hKz7xogdBTOcEa/AU+NB6JeS8RIbFMkaDOqk0igqyOQnLJmK2UVihHHUj++x9bfv+fHut2Hbg/rIy8pwIf34kI9qwwotjPjT9S2yVVo1CCtsEU7bbQO/q0DhO4gcAZZDXXqyYLW3MNjm98zdxxdqNob+LJphhO31VKBEmnptLbbehOma4NwR5xtkjJgkc9pGkleMovm64W0FHM9vUYTsQrbqxipldDMyx8ZvSmZSmJJZuGxggO63wCELmCd7gOimi1RjKDOp/3ZgbobtWU3PNmQ2CS3wmBPE+e1bMNHylF5JUgzznLi4+ilTXzRWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(6666004)(8936002)(6486002)(966005)(5660300002)(86362001)(31696002)(4326008)(66946007)(2906002)(66556008)(66476007)(8676002)(478600001)(6916009)(38100700002)(316002)(31686004)(82960400001)(54906003)(53546011)(6512007)(6506007)(26005)(2616005)(83380400001)(41300700001)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU4yakpVZzRpeThxd1p0QkN3ZGVtV1hKQm9qZkZVRkZVZFB0MGIzWE8wMTVS?=
 =?utf-8?B?SXRQZUFGeUYwMFUzMGNoL2JZNlQrQmFxdHVKT2xpNTcvRTBha1lZN3M5VGU2?=
 =?utf-8?B?S3QzVS8zSUpqaHlSSUJ1TDhoazB5SnF6aU9PS09KdytpT0V4OTlNZlBJUTVh?=
 =?utf-8?B?a2lRN2NqdUdtTmtpdVI4NHBxRzljSkorTDhqWjJYRnhzM3YyQnVpQVcyZDdB?=
 =?utf-8?B?MFRqOFlxb3U2MHROblNOdytpSVcvbFpYc2doWkl4V29KcTRHOU1aTjhTZ0VZ?=
 =?utf-8?B?OFZlcFhja0F3T0dZUjdxQkpVNXVFY2Y2RkU3YjQzNnprTlIzakNmaTRvbWh0?=
 =?utf-8?B?bXBaSTUrN0tqVDg0UUNnSTVtZXlUdXYvWmZEU1htWW8vaU42YjkvRUpkV2xa?=
 =?utf-8?B?L2JWckVZYkg0T2R6MGVOaUxJME4xbUtSMVJuUGlmOXdLU2kvdklTdWQya2ZO?=
 =?utf-8?B?TUlpcTNKWGJ0VVlEU0x6a0w1bGFFNGpoWlE0Rmp3VXp5aHVJTUZYSUNrUFdh?=
 =?utf-8?B?dG1jL3EvZ2xOaGlvaXJ4VlpTd0FqalErNnBiZ0g0YnlQTFhpK1F5bEwyMGMy?=
 =?utf-8?B?aGZSUk9heWVocXBOSVo2bWEwQzZIS0JheUQ1dGNaZUFXR0EyM0hFZVVJR1pm?=
 =?utf-8?B?aER0ajFUMzlDUlk5cEx1dS9mdVVMNTFJem1aNUVnRyt2VVRqTEFZOG1XWEFB?=
 =?utf-8?B?alN5KzdxQ1ZJeVgwd0t6dFN4U1FvVGxkTlR3NzBNZzZVSU45bW9CR1JQcFhu?=
 =?utf-8?B?RFZSait0VXVrMlVZYnhGMEFGVUpkRVB2TzFPbUZ3V3VuVUluUlJCOVNFVWZo?=
 =?utf-8?B?OTF6bkFkRXJHU3REaVJyWG5WSTlUQnRaaVhhNStuTkQvdG5wUkMwa0g4Znpa?=
 =?utf-8?B?clBDYllaaXJFNW9xVDdTSlBiaG9BeFhjRVcxeVJKL0lkM0hsdGVTa0Y0Z0Ft?=
 =?utf-8?B?N1BNcWcxSGZhaGFScysvc0k2QUlvUDVuMFpjNzJpa3ZkbWl6cVQxVWV2WG9a?=
 =?utf-8?B?bFZDYTk5b0E3MU9RVkpqNmNocTZlQkVmakgvNytydWhWOUN2a3BMRnd1ZkFT?=
 =?utf-8?B?Mkx3VllRTk9BRHpRYnhBNm9VRElhNWsySURNOGs5ZjhTeWQ1ZXVreEVkcmp3?=
 =?utf-8?B?U3FXWmVNc05TRS9IZzg4c0xDV29RWVpkT2l3MlFwU2FsTE11YnJjYzJ1b2pM?=
 =?utf-8?B?cm1IT3U5b0NEQ0IwaW1LeCtlK1ROMGFyenRCY0h6NDhxL1E1dFg1Mi96Vlp6?=
 =?utf-8?B?aHJqMHlOVlNuc2lIUFA2MktHa0xPcTdwZzFMM2ZEUXRSUlNSZ1ZMcVdZQVFl?=
 =?utf-8?B?a0xjK3NKUUFCMStqSE5zTjZmZHJoVElkV0gybVBFUGphTk1GWlJxcXF1Q2RK?=
 =?utf-8?B?L085UWxGVDRYSlhBWDZ3ZkhZNGM0ZU5hTTdyeGpmc1pLWGxTRW5KSFF6ck91?=
 =?utf-8?B?L00vYS9iQnRvbUxaV2tkMkJ6WnVRVG9NcUxiSVU0NFFkSkxBWEZXYU8yRWRT?=
 =?utf-8?B?dWFOb2xKVjdWVWdTMi9jNHVDTUxra3V5ZXoxRXdyRndPS2llM1FqVk5NM29N?=
 =?utf-8?B?MXoxaEhzMk9ZSWc4cEhEQzJqN2dMU1pOWkpnRjdPUGZrQ2tXNmVEU2J6M3h6?=
 =?utf-8?B?ZkRWbER4OEhndXVtbmJ3M2ZVRzQ5RnVjdHV5ZG5mMEV1WjN4RFMyZDQwWkhr?=
 =?utf-8?B?UGJzS0RETUNaVUk3TFM2dGdwd3BWRWdzb1RvakZ2UGRycTlGdDRIWGhwNTZ6?=
 =?utf-8?B?bFFlNURDM3g2Wld5bTRKMzBNNjIzV3pGbmdmVExUM0FWbVkydzBKSkVjcDhu?=
 =?utf-8?B?SlVBSVZqVjdYWnl3cStpbjBKOHJmYnE0RGZ4TzE1RW1HS3Q2U3BSNmpHcnhv?=
 =?utf-8?B?eEJwaitzVUJ3L2YzeUk2NzM3OFFqeERpUitYNkxGSmMyWVU3cTlBeDFNeHVv?=
 =?utf-8?B?RGEzcE9JQ0REYnp3OUYyK2oyTjNtSDJZN1hvOWUzYWFwTFBKVU4wUzJnRWZw?=
 =?utf-8?B?TjVZODIvTWQxWlgxdmloRFhJOTErSzFJek1zdzFFcUlhTW5nUGMraTZvQ01t?=
 =?utf-8?B?dWJRQmU0NUNOSFd1OVpLQmtuZ2Z5Mm1sQXZDSXpBS1Vua0VxL0NaY3UyQmtQ?=
 =?utf-8?Q?+4LO3I2M36GlapeROLfGz6Dai?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d023ec-876e-413f-7781-08db3b288db3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 07:35:56.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jk4cvHOUmxgvX11UliDiMMxXCrG7hehx3pB9d+zZyUZ5zyNwTE44nYJcyL1g4jmTeBHfDQNAbYNiNnDKZH0OBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/10/2023 10:11 PM, Matthew Wilcox wrote:
> On Mon, Apr 10, 2023 at 04:53:19AM +0000, Yin, Fengwei wrote:
>> On Tue, 2023-04-04 at 16:23 +0100, Matthew Wilcox wrote:
>>> On Tue, Apr 04, 2023 at 02:58:50PM +0100, Matthew Wilcox (Oracle)
>>> wrote:
>>>> The map_pages fs method should be safe to run under the VMA lock
>>>> instead
>>>> of the mmap lock.  This should have a measurable reduction in
>>>> contention
>>>> on the mmap lock.
>>>
>>> https://github.com/antonblanchard/will-it-scale/pull/37/files should
>>> be a good microbenchmark to report numbers from.  Obviously real-
>>> world
>>> benchmarks will be more compelling.
>>>
>>
>> Test result in my side with page_fault4 of will-it-scale in thread 
>> mode is:
>>   15274196 (without the patch) -> 17291444 (with the patch)
>>
>> 13.2% improvement on a Ice Lake with 48C/96T + 192G RAM + ext4 
>> filesystem.
> 
> Thanks!  That is really good news.
> 
>> The perf showed the mmap_lock contention reduced a lot:
>> (Removed the grandson functions of do_user_addr_fault()) 
>>
>> latest linux-next with the patch:
>>     51.78%--do_user_addr_fault
>>             |          
>>             |--49.09%--handle_mm_fault
>>             |--1.19%--lock_vma_under_rcu
>>             --1.09%--down_read
>>
>> latest linux-next without the patch:
>>     73.65%--do_user_addr_fault
>>             |          
>>             |--28.65%--handle_mm_fault
>>             |--17.22%--down_read_trylock
>>             |--10.92%--down_read
>>             |--9.20%--up_read
>>             --7.30%--find_vma
>>
>> My understanding is down_read_trylock, down_read and up_read all are
>> related with mmap_lock. So the mmap_lock contention reduction is quite
>> obvious.
> 
> Absolutely.  I'm a little surprised that find_vma() basically disappeared
> from the perf results.  I guess that it was cache cold after contending
> on the mmap_lock rwsem.  But this is a very encouraging result.

Yes. find_vma() was surprise. So I did more check about it.
1. re-run the testing for more 3 times in case I made stupid mistake.
   All testing show same behavior for find_vma().

2. perf report for find_vma() shows:
	6.26%--find_vma                                       
		|                                             
		--0.66%--mt_find                             
			|                                  
			--0.60%--mtree_range_walk

   The most time used in find_vma() is not mt_find. It's mmap_assert_locked(mm).

3. perf annotate of find_vma shows:
          │    ffffffffa91e9f20 <load0>:                                                                                                                         
     0.07 │      nop                                                                                                                                             
     0.07 │      sub  $0x10,%rsp                                                                                                                                 
     0.01 │      mov  %gs:0x28,%rax                                                                                                                              
     0.05 │      mov  %rax,0x8(%rsp)                                                                                                                             
     0.02 │      xor  %eax,%eax                                                                                                                                  
          │      mov  %rsi,(%rsp)                                                                                                                                
     0.00 │      mov  0x70(%rdi),%rax     --> This is rwsem_is_locked(&mm->mmap_lock)                                                                                                                      
    99.60 │      test %rax,%rax                                                                                                                                  
          │    ↓ je   4e                                                                                                                                         
     0.09 │      mov  $0xffffffffffffffff,%rdx                                                                                                                   
          │      mov  %rsp,%rsi

   I believe the line "mov  0x70(%rdi),%rax" should occupy 99.60% runtime of find_vma()
   instead of line "test %rax,%rax". And it's accessing the mmap_lock. With this series,
   the mmap_lock contention is reduced a lot with page_fault4 of will-it-scale. It
   makes mmap_lock access fast also.


Regards
Yin, Fengwei
