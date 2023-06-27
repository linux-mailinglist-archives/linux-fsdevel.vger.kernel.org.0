Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941E173F394
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF0Emm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjF0EmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:42:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B004239;
        Mon, 26 Jun 2023 21:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687840759; x=1719376759;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rq2kVDPiMI1Wo1zgo9JUO+XunGpdeX6OKTf9uKMjTaI=;
  b=gqrEVwlo+Py54EMKApHPDrXRvkWNBnL49VMASszOB+Mf6sn1DyF/sfsh
   bBpeTqgeXlqzBxqoodMZg+eEdUwnHiZrINzAhj1LVM90nlwewCvj6mA0L
   4j5D4J6z8kg9MsZqdusDUAJxdcqh8UqKMUGftrazI7Lo32GHJ8H1wnkYe
   I0YCJJUVSSzRItTyeCcTdf5DuuOh79qCXol2VrDzxf4jdL6RuqbaQaxCQ
   SU3rD4mOuqkvl9YBmhXm/II2MU3motSM+VdUNTmTPA0wwL4eckyjZpIo2
   hiYzgVRHmpdP1FyqiwjmqACyr8O6tIZQ6v+zoU0CLcU2p5c8W6wmfkRTL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="351254965"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="351254965"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 21:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="719635636"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="719635636"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2023 21:39:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 21:39:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 21:39:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 26 Jun 2023 21:39:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3NokU05gI4f2ssQcUN8CjrOKVqwYicqGUNyY9ixx3+sNmYgAxlRd1S4xTxk9+l4zT4mQk+0GQ47sjHUexeEanrKRmbD6o0kTLEFJiPwWLMtmnQUnjY3h+iBWAjbGPY4siOixsx5qOZMH3RRw6QSqNxCiKhclVQn8i/RARk4qfBEGw9kQ/tM9uhFwJltYLEY0ha7KuikcXVKthNjpg0byQmOEffwBVf5BLlH2RvK8TN3eqc4a3iV4tB9lP9BBmJNnbWAChLlAgNQJyp1KXlYw+ejZKLnKQbyCtsp1V3avBplI5NsYZ6uh4UrZjWeck9awu46ndTpdJAk4ixXh2zpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFlVOP/+0wZz4p0EeMJfo8elH5xnV/D1qQ1RgoXl58g=;
 b=cNbg769nnnF3YdEsTCMiQ7Fy+NvDtAcmxmvBlcfFVJxwSMfiLY2zFJEBTVaDBwREYWkwZkT06LPm//ynDoamJcWZNaS9WR12Eycy3Hi/RxY9F7LMpmhaaRRiYWXYFiPgx8TcHBnA0x1VcQ/FecA4cJbFgmObtdb1bEm0J3SRjbZLafdv8u66dR1UlPPzintthtTlq0q1NUn+BnjszQANhrhSIp8uNmG1bgQ3Mt48W+gSJv3KUbaWyFkQrh0og6evAMZu7odSVERTiCfHkft5kA06OfMqVeJq1W3gohlbgDorFMz3b2aMmENtJw9/FIlabk+jT6sc1VImyZv6FdOuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW5PR11MB5883.namprd11.prod.outlook.com (2603:10b6:303:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 04:39:16 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 04:39:16 +0000
Message-ID: <eda0d716-4292-6117-b036-4df64c5df110@intel.com>
Date:   Tue, 27 Jun 2023 12:38:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [linus:master] [page cache] 9425c591e0: vm-scalability.throughput
 -20.0% regression
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Sidhartha Kumar" <sidhartha.kumar@oracle.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>
References: <202306211346.1e9ff03e-oliver.sang@intel.com>
 <20230621152854.GA4155@monkey>
 <126cb393-31aa-d27f-ac0e-f86724eae0db@intel.com>
In-Reply-To: <126cb393-31aa-d27f-ac0e-f86724eae0db@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW5PR11MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: f68a16fa-357b-46ee-9a5d-08db76c876d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJ5uXiuuqaMClHg+0d2uwFz7ouCxBw+uFf/qeXqrKTyJHg5neZNhBq8U8lpa6f8Eepv7aPoVozPmSnRLk/aKy6yHlc6SFbX4YyT5hc+0GoenQMzbf+G8IN4RmZsnLdhniP1bnGQFOQwf16ZeTqv7NElXY1mtOfI49bBN7SvPTJOW3OlF2ASWw52yA58HVl3O42WFHnK7z10ODr75kXH95MyyY6JMK8xb7tWEwys7Kb2azcg5NAmw2qVPdvSKnUDbCGqTjM6f8bsnrHG2c/uVRWjXxrXG8Q9TQ6Qx3WaL8Ozl00QF0T+lbPR0L/kH0RPKG0kwwzLAuPEr3MNAwmwr8LxLz6MwRtO9rWnr08bSgIrTNBhLnk40XJXZuHTVEe0s62/73fjqbjYmHznigt2olrmFBDFBixFInL6evdYwxzIow/+AguQIfoshQvJZ5lyCgjDal0nEYCO4qg46L4U9vayxA03mN6he30TLLOXautbz3jFwQVrTrJAcTmqbBCKAqAjiNTx5Pr5cXKWcw+VRS33YX4Qwsp71MCgEbVWpnBSMTxyZhkhCHVYMZYBFzpCL7zDiogiBaFYR9DlSfDT69nbV//gy4pM/5s+kSOzl+R/sAzOzKWUu11wjJWZ7GwTCUtLBz/R6QOUFTLds3QtYkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(82960400001)(38100700002)(83380400001)(36756003)(31696002)(86362001)(31686004)(54906003)(966005)(110136005)(2616005)(6486002)(6666004)(41300700001)(66946007)(66476007)(316002)(66556008)(8676002)(8936002)(53546011)(6636002)(26005)(6512007)(4326008)(6506007)(107886003)(186003)(478600001)(2906002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHg1USt5NGdOQk5Mclk0Wm1BV3BGOVRndllJSlhQcUM2ME1kZDVyUDcxWW1J?=
 =?utf-8?B?NWY5S0UvN0ZoTUVoNWtGN3MrYVEzcmVJOTdRcksrZ1M4cFAyVXFNZlB5S0tS?=
 =?utf-8?B?S1B0QjZkNFdFOU5HNGtDRTJuaVlYWjdWSVhaaGIwQVZ1Y0lOcG9OMEdmM2hD?=
 =?utf-8?B?eEwzT1N1TFFHYzgycWRXQVdTQUZla1duN2JZd21ZeEZzblIzSytBbWlOOUVv?=
 =?utf-8?B?MHhuMmdXaXk3YnNnbkZCcEFkUndLOWxWdmVPbWltcWpGWnB6Yk5vTjcxK2RU?=
 =?utf-8?B?bjNldlQ0KzhFKzJDOGpYWHM4KytZSTVqWGNXQWh0RC9UOGFHeTdJemxGWnQ2?=
 =?utf-8?B?NXdTeVNpWWhwbUJRbmE3QlQxMlFMV0Rob0Z4YjI1RHR6cmR0Tlk2aFg2dmhW?=
 =?utf-8?B?UWhYN3d2dWI5Sm5LN2JaaHp4RVF0a2dCTWZKWi9WdDdRVm84aGM0Rm9RV3BR?=
 =?utf-8?B?RC9JSHJsU1JPTFVjb1VZZTU4eFBaVFk1SW51akh0UkdEZno5Z2lZRThKL1Q2?=
 =?utf-8?B?M09OTTNReFQvR3VnM0I4THE4Zkp6ZFhudTZsR0hlRDRyeXViT0M2VjdMazNC?=
 =?utf-8?B?YWI5NGpFZi9XUWdRakZTYjNMYXYvcStIaFZrWDRJRzFrM3Ircm80SWlKT2hJ?=
 =?utf-8?B?bjVCQlQvMGpIc2NCNm1YNngwWjRqdk1SS2tzRG1TaVFaUm90bUZtTGFxMm9S?=
 =?utf-8?B?TXNEckxRL1d5VTg2M3FkWk1DYkV6TmREYU1ZeThJa3FjbG5YdTNxdXd4RHE5?=
 =?utf-8?B?V1UwOURVeEFmVm1maE0ya09xZjk3Nml1RTdkc0ZJZnFFejNRblNUaWh1Z2pQ?=
 =?utf-8?B?SFlpSHNpaHNqOXd4RVJUS2RlYnN6ZUxRSGtKNmJLbjJNeDIzakZEZk5sT2pv?=
 =?utf-8?B?Wnl1SkJjQTd3KzdmOUQ4aWRuR0QrM2NmT3lESENBenpDQnJralNXRE93elZa?=
 =?utf-8?B?U0VEZ3dEaWV0VEZkMktnZUJuWHFMTTloaktLVzdzcEZUZHYzTmRIMUxMemg1?=
 =?utf-8?B?WjBhT1dOeEQ2V3BkdTR6d0c0eHhiejFlS3BXVy9NSFN1UlBUd0xBbUNXRFp1?=
 =?utf-8?B?cEhNdGVqZkNkSTBsN0plYkF6WUNmTDZiQ2Z6ZnFxNjNjZExNOTBYempwY0Rn?=
 =?utf-8?B?VXdrUEtuV0NKVlpUN0cxeENoYzc4R3V1L0hLUWY3T2gzSEJFT2tFVjlEejNh?=
 =?utf-8?B?bWplMnBNK1hZdGR0OGFqSkIxc2hjL25aYXFyaXZVZStrdXM1VkIyVTVydVV4?=
 =?utf-8?B?SVdDSmlZNTI1TTZrdXltVFVrQ0taWitKeDBYYlFUb2xVbE8vT2g1UnhlbVpJ?=
 =?utf-8?B?M3FmU3k0UjJ6ckpGU21ISlphWCtqSnF6L1k2WUNZd1kvYWhwQ1N5RTJyZDYw?=
 =?utf-8?B?ZWRCNUxYN21yWDVMa0dLNjRGSXNPRzFHRFRvNWJIMHg4TzYveW9GekgyRTd2?=
 =?utf-8?B?cklxV3lmV3JuVjJvbU55dnFBcFZmV3RCc3JlZlM0UlFJaEhjQTRZbGdyQ2V5?=
 =?utf-8?B?MkRxeWF0clM1KzhKaGlOOWhHeFFRSGp2ek9rS2RYcHJFWDIwV2dQQzVkUnl2?=
 =?utf-8?B?SWc3cXRZbmZRd0RIU2tDOEQzM1hOd3hDOEpSc1lxS1RKMlZOUFBBWmhmTkxE?=
 =?utf-8?B?T05BNjhCVSs0VE9LY3BOQitaYmZDV0tsbWpOT2c3QVJ3bEpqNU1oY1VqUDJE?=
 =?utf-8?B?MWxML0Fkbkw3NFZ2aGRkV3pETEpja3pyYW1SRE5RcitnU2paeEZ6ZUdZSVBt?=
 =?utf-8?B?Znlja2pQbVhNR3VSS1ZYRHpyaWFBQnNBWHQwMHB4cjdBS3BCVHpWRFBtbTRK?=
 =?utf-8?B?amJUS2hmNk9kaWVUeUdqMlRIajgxMC92UnAzSmxPTzJpbitvc0cyMXpKbnJW?=
 =?utf-8?B?dVp4dDdETkxoNlFJVWV5UXR2cTl6czVQRk13UXlheVJkeUxNMDd6b3lESjJ4?=
 =?utf-8?B?cWdLTHQ3TklLblNjd1lJVUxqOHN3aVhubm1vd1FuY245UmMydHAxZXhHZ0dX?=
 =?utf-8?B?RkZ5cWhIZHRLem5nYjd2T0UxY1FLdStkMmpkcVB4UjAwNHdPMlBlaXhnZFU1?=
 =?utf-8?B?Q2xPNERPZ0c1VGhHS2NoL1hSMEIzVm1UV05aTm9lem5JL1pWdDRrOCtBcCsy?=
 =?utf-8?Q?tm1ETI4Ue07hIsAzdaD6Qabb2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f68a16fa-357b-46ee-9a5d-08db76c876d2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 04:39:16.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiz5oN6r15lT/ijB+31H4Knz4Lhro4ibPhoiVaY5JD6b0Knt7jgdjK696xM0xdshILQIR8XhkPLTc6Wyx5PQmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5883
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



On 6/26/23 17:05, Yin, Fengwei wrote:
> Hi Mike,
> 
>> On 06/21/23 15:19, kernel test robot wrote:
>   <snip> 
>> I suspected this change could impact page_cache_next/prev_miss users, but had
>> no idea how much.
>>
>> Unless someone sees something wrong in 9425c591e06a, the best approach
>> might be to revert and then add a simple interface to check for 'folio at
>> a given index in the cache' as suggested by Ackerley Tng.
>> https://lore.kernel.org/linux-mm/98624c2f481966492b4eb8272aef747790229b73.1683069252.git.ackerleytng@google.com/
> 
> Some findings in my side.
> 1. You patch impact the folio order for file readahead. I collect the histogram of
>    order parameter to filemap_alloc_folio() call w/o your patch:
> 
>    With your patch:
>      page order    : count     distribution
>         0          : 892073   |                                        |
>         1          : 0        |                                        |
>         2          : 65120457 |****************************************|
>         3          : 32914005 |********************                    |
>         4          : 33020991 |********************                    |
> 
>    Without your patch:
>      page order    : count     distribution
>         0          : 3417288  |****                                    |
>         1          : 0        |                                        |
>         2          : 877012   |*                                       |
>         3          : 288      |                                        |
>         4          : 5607522  |*******                                 |
>         5          : 29974228 |****************************************|
> 
>    We could see the order 5 dominate the filemap folio without your patch. With your
>    patch, order 2,3,4 are most used for filemap folio.
> 
> 2. My understanding is your patch is correct and shouldn't be reverted. I made
>    a small change based on your patch. The performance regression is gone.
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 47afbca1d122..cca333f9b560 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -610,7 +610,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
>                 pgoff_t start;
> 
>                 rcu_read_lock();
> -               start = page_cache_next_miss(ractl->mapping, index + 1,
> +               start = page_cache_next_miss(ractl->mapping, index,
>                                 max_pages);
>                 rcu_read_unlock();
> 
>    And the filemap folio order is restored also:
>      page order    : count     distribution
>         0          : 3357622  |****                                    |
>         1          : 0        |                                        |
>         2          : 861726   |*                                       |
>         3          : 285      |                                        |
>         4          : 4511637  |*****                                   |
>         5          : 30505713 |****************************************|
> 
>    I still didn't figure out why this simple change can restore the performance.
>    And why index + 1 was used. Will check more.

The thing is the ra initialization after page_cache_next_miss() in function
ondemand_readahead():
  ra->start = start; (start is index + max_pages + 1 + 1 after your patch)
  ra->size = start - index;

And +1 will be accumulated to ra->start and breaks the filemap folio order.


Regards
Yin, Fengwei

> 
> 
> Regards
> Yin, Fengwei
