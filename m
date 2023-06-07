Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F062725478
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 08:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbjFGGkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 02:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjFGGj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:39:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F521723;
        Tue,  6 Jun 2023 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686119997; x=1717655997;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3bFmfJ9le9VxO4Nj/OPC1nKe7g454Jj4ihoL/RS/Lec=;
  b=FQVItAn4+3DpwSruS3StlpXZ/VOYCyz/W5jdnCsmpqoY4/5/iORKGkFS
   MSD+Yv39UNra9iWwNX5cBQSXbk5YRsyA/9lLc4zhY8af/riuj7xoN0k9Y
   1xwUzzRyJ+6Ta9ecCBxrQhPHtZy8EbfksewEXGfwRI3mA153WG6Emuwqd
   g9h5XFY9ZOBb8pIMDDhB5g9LwEpIkCRil2CFKsEyQWTnrYJZiiPHW9SWB
   jaagis/MV3ZLbjjGnh24FpJ7eIqClvZsmFyTHy6Y6NrD+7pFoTC8y+FGs
   dkY5hskKKKH2lLlH80W2oCWQAX9qC0GAW+gg874c4bqXCkEP2aRnl5fVi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="346514160"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="346514160"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 23:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="799177109"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="799177109"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2023 23:39:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 23:39:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 23:39:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 23:39:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZxDXabipF7aZeuPBpDLjuORy2Lbf7cugZz2sGtEr6FgUcqxbNK0A/Fp8Yvs8sxGD3RBdS2pSFfQrVWDQFPIMpvNFTghbndnV5c5/628EszhFkZWufyvWzjRz9BZ+xzalztYoQuoDMs/PytAZPubDX4B4eFDZjI98T2LYz+40iyfRhP5yzk4E3mJxnZfntpg+kWkayXHJzGwkUIaqfGXERvHP2fCgFd0l9oz8QOHKWUr6ZZLXZj35HfZdh/g32cec72hHrbA5eFWqr9IfJVKjZn04Kdar+lcw5DAfhDA/TmdEi4xMD+Gl6u4wsOKlJai84/RTMoKLkJEB8uG3oz9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lifvAZv/zbpvDqn7p2TIfNAls5Y9Z5+3Bu3OWflCcHw=;
 b=FAgXnLHyyMUkWdByLihv8El1uM+3awhaD6isV4h72CZrPCKfgjc+lpXe5SNEIXkpzPmZjOIMLv5/AJVVFvnOzn6AcZgs2lOF+UtYllYFPrv30oi2/1nHwNCCgOdalXj85w0bxA5can/IdJccU/hLTrm7d1nY+4V6Y659DaTCXxQ0qf/tl51QCzaKWQQDynSLkU8QNr1Tw6yz2LaF/z8LqtJ4FXZGryzWbroB0UxuQbEr6pMe2PQID+MEAIGgdbzCSsUsWeLb9KT2mn+aFOcWIwswX7vJdf5NUKPOAF9dTpg29O3PeGht+O4twQmrRQE84VhoGh5sgCQnc1X6hnff6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 06:39:39 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 06:39:39 +0000
Message-ID: <8307ce42-7b70-8c4f-105e-bd47e4ef734c@intel.com>
Date:   Wed, 7 Jun 2023 14:40:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 7/7] iomap: Copy larger chunks from userspace
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-8-willy@infradead.org>
 <20230604182952.GH72241@frogsfrogsfrogs>
 <ZH0MDtoTyUMQ7eok@casper.infradead.org>
 <d47f280e-9e98-ffd2-1386-097fc8dc11b5@intel.com>
 <ZH91+QWd3k8a2x/Z@casper.infradead.org>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <ZH91+QWd3k8a2x/Z@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9143c5-4691-44a5-8874-08db6721f7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vu1r0wgPReaJOKk+Qsr8EL44UGtcYIgENaeiWk14rTxSzSRp/BEfFvoTxuofvO5lJIvMte8JmnUopg6/4KriRVX0pQuM/Wqnh2QtdtFcjrPT8F5ZLtxvbPrE/8yLEX/7NhhCBGUNDlW6xKH2EyZzEHnY9bq8oQnE0vVsE0M2IU4Iq/Bb4q8+ikfH+CGT3wjMPFQAlzRTlkIO4B9miDMcLpvwHhaSEwbdubvAZuK9CEWsSS8m9jg9ntnXx31M9u18h7Ej678RBsjq/+jVqYX8J68URYlDdWXrWhTF35QiVE/nXKibZr6idMQzFmMzEPj0v+n+pFneialX/1qjgDSicAzTwI/oJON8oo1nYC+DkM5anDR0xPZHPdLjnzp7EAwRmoQvp6hUWgP63FF5+hyA3CBF3/SzYeJhoK0C6tJbvNhnPG6h5flMrxeoZsv8cXHOt3S9S5VK/jO2EK6HH7/q+xtKb2Apjg7YY12Ph10xqOu4DKgAHRNwT0HX5v3hH/sxe1bAyQPn79miajhvjyqjISx4bnJ3M8ejYlOyEp5X/PUB1f1+gT3uxKpmJlvXhYgg7pCHZ1PCKMUyQ/IAtL/iabn4OYaGju3W/sKHAaqIKZrPVQdCPH139Tq0dF80FZPa2KciyZNW/RNJN426VGlSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(36756003)(26005)(41300700001)(186003)(6512007)(6506007)(53546011)(5660300002)(83380400001)(2616005)(8676002)(8936002)(54906003)(478600001)(66946007)(66556008)(66476007)(4326008)(316002)(6666004)(6486002)(82960400001)(38100700002)(2906002)(6916009)(86362001)(31696002)(66899021)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGdYZ1pQRkN6bGlEY1V2VGM1M0FwcmtLeVNJT1VRMmVkZlVlZVpyajdUbllh?=
 =?utf-8?B?Q1p0Z2t4RU90SExkdWd3T2JwZmZYRzZKRTFVQ0Q5RDBzcVNGNDlqYTVMTVYx?=
 =?utf-8?B?aktrRU1RVFo1SXNLc1h6UWc2L2ZKSFhqSlJBVlEycmtEblRyUFlpTHlGazZq?=
 =?utf-8?B?WlEyckJqb1U0MFc5cjdvS0t5Vi9YZEhTbzJGOVNTMFJlQm41OEtsZS9tVzIv?=
 =?utf-8?B?T3pacDBPNitXdHZQS29nZk82RXprYWlMQ1FnYk5sS1lISU1icE5VMUdnR2Zk?=
 =?utf-8?B?L0VLeGRSU2NMcW9NTWZUNHVEK1dwUkRFS2pmdUgyMElGOFRJakdxOWpHUGdr?=
 =?utf-8?B?cy9yWjZsQjdzYmNwQU5jRm12ZEZmYlJNYWhBalJEcEQvUWsvWklSRVlEOVdM?=
 =?utf-8?B?OVlJZGtocUhGcXRMdHU3eWNBWFplbEZuS1VqVVlBOGhoZmk5QlphdHZKSE83?=
 =?utf-8?B?bFhZb05ZZldwWTM1SENGVnd0K1pENWo5SzUwZ20rYVdURlFhWlM3VGhVa01E?=
 =?utf-8?B?S09hTldGVEFKeVNCWHRuTEdWU0V1aEl4cVdyYkVQUXFseU9OQldvYWhuOWpZ?=
 =?utf-8?B?cXNPdVNDZHM3a0puL3hucFIrSzZSYk1weCtHVS9ELzZibXJWVjRRQTRWeUsr?=
 =?utf-8?B?VUp3SW81NVRETFlBcDg3eU81dFJVQzhqM1NnU0M0K1F4OWlvM3JaM3dpU1VB?=
 =?utf-8?B?ZVdmanlUTDQybUxhRWc3YkI0MjB3K0dyMExxeHdkcy8wOFJJQzEyVkRLZmp6?=
 =?utf-8?B?VTBFUWZYTGwzSDB3RnZZYlVVNW9abXMveEdPYXFJazVGOUZOZitpdTRBRHJB?=
 =?utf-8?B?UDdBdzRWOU1JNUM3UVZLYjQxQ2o4blYvQUJOVjhQcUlLWkhGUzBiTXZBK2Vi?=
 =?utf-8?B?MnVjZVhlb2ZkZUdQVWEraWxvVVE3eDVRbE8zMEdIanNBZG5mTHFHNHhVY3Jq?=
 =?utf-8?B?dWcyK1V4VjRtMVJBYmJSMUN3Vkt6eXNVSm15dThlZE0zUDVXTzVnMmpoejB2?=
 =?utf-8?B?RVZYUGhSdTI4R29zdE11dnk0VVExMVBncThQQTNkUWZPUThqdG4zVlVoV2NM?=
 =?utf-8?B?Qk5zSGdobVlVbk9hUVZBMmgxSVg0aWhtdXpSSkRqNmdNTXB3a2lac2ZuamVM?=
 =?utf-8?B?RDBhRDRVdU5HR0o5c3Q2TFZZa3VkTERJS1phck1xejZKbWVkRUhGM2VlVUJM?=
 =?utf-8?B?c2NoYjJTb1d5U21NdVcrUzdmK0pob0c1NXphbWVNR09QSlE4KzEzOC9Zb05V?=
 =?utf-8?B?Qjc4ZXk1b05mUW8wOGl3MVRtWmpZeXRtbWwweGlMV3I4cHoxaG1BWjRnamp4?=
 =?utf-8?B?U2g2SHV6UHJWWTFEQjRmOGt5VGlNSXJZWVJwQ1p5RStVb1VNWDZZS3htWTRT?=
 =?utf-8?B?bkJ1aUlQN3czSk1DdURORndhSkd1R25ZVnY1WDJ2Yzh1TUlmZElQWVFHK0xT?=
 =?utf-8?B?b2I0Mk1mY2tuTS80UFJhbWVnUklBRDlqd0Q0N0p6S041K21abUtiQktrdnAz?=
 =?utf-8?B?SUdVTkY4RUFXNnFsWUZIMkhudkxIeVZZRE5nMXl6d3Bhd1V5NFZEaGxRTkhV?=
 =?utf-8?B?c25oR0Q1VnlkeHZ5NUxQcjJTSTNBelVNVjN6djZNVU8vTWozaEMydURkSUUv?=
 =?utf-8?B?SklVVjBlWkFOSFJhUWlRZDBXaEdZNVNvSkZub2dSVlNkQ21yaVJpSjV6KzZ2?=
 =?utf-8?B?WXI2cUtLQ3RzMVJ0ckdmR3gxTmZhajBGM1UwLzdlS1g3OFpFUk9jVHQ4anhE?=
 =?utf-8?B?Y3JoQjJnVTVSR3VvVFhOd2pyNU5CVXZFQ3lpZDdXaGtaTmhmeXA3a0R5QUJx?=
 =?utf-8?B?WFJmc1ZuUkpFczU5UEYzVmZ1M0lOeW9wRFNDcU5saXpEUk4zbEZQenJBRmRI?=
 =?utf-8?B?YzlReStHNTdHLzZFMjdNb1FVNDJ1WDB3eVNBVmxyejUzd1k3REFLWW1vVWdF?=
 =?utf-8?B?RlAvaStCUlVua0dHMWZZalhoRHVyUW5qTnF5THJsQ3JIank1ZWRKSnlZNjV5?=
 =?utf-8?B?OS9XWkxjVmw4ejNFYjlKYzVSRjNZaGpOL05yL0JnaDBkRWc2alY3SUI0YzZ3?=
 =?utf-8?B?WU1GQ0QzRU9EYW4zZi9ZSlRhZi85K055L0xMVm0zNjlHU2g0YVNWYmQ5aFJ3?=
 =?utf-8?Q?gJWQnKJC9cMndTdhuu0NKZzWp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9143c5-4691-44a5-8874-08db6721f7e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:39:39.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maL3BmBGzBRyv4ZtZyrsywa3u0vAlJYSOonS8JS8oFXlYlMX0drauYZS6SRqBOpTyQJgqyOdgFmw9Ic0blZ25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
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



On 6/7/23 02:07, Matthew Wilcox wrote:
> On Mon, Jun 05, 2023 at 04:25:22PM +0800, Yin, Fengwei wrote:
>> On 6/5/2023 6:11 AM, Matthew Wilcox wrote:
>>> On Sun, Jun 04, 2023 at 11:29:52AM -0700, Darrick J. Wong wrote:
>>>> On Fri, Jun 02, 2023 at 11:24:44PM +0100, Matthew Wilcox (Oracle) wrote:
>>>>> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
>>>>> +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
>>>>
>>>> I think I've gotten lost in the weeds.  Does copy_page_from_iter_atomic
>>>> actually know how to deal with a multipage folio?  AFAICT it takes a
>>>> page, kmaps it, and copies @bytes starting at @offset in the page.  If
>>>> a caller feeds it a multipage folio, does that all work correctly?  Or
>>>> will the pagecache split multipage folios as needed to make it work
>>>> right?
>>>
>>> It's a smidgen inefficient, but it does work.  First, it calls
>>> page_copy_sane() to check that offset & n fit within the compound page
>>> (ie this all predates folios).
>>>
>>> ... Oh.  copy_page_from_iter() handles this correctly.
>>> copy_page_from_iter_atomic() doesn't.  I'll have to fix this
>>> first.  Looks like Al fixed copy_page_from_iter() in c03f05f183cd
>>> and didn't fix copy_page_from_iter_atomic().
>>>
>>>> If we create a 64k folio at pos 0 and then want to write a byte at pos
>>>> 40k, does __filemap_get_folio break up the 64k folio so that the folio
>>>> returned by iomap_get_folio starts at 40k?  Or can the iter code handle
>>>> jumping ten pages into a 16-page folio and I just can't see it?
>>>
>>> Well ... it handles it fine unless it's highmem.  p is kaddr + offset,
>>> so if offset is 40k, it works correctly on !highmem.
>> So is it better to have implementations for !highmem and highmem? And for
>> !highmem, we don't need the kmap_local_page()/kunmap_local() and chunk
>> size per copy is not limited to PAGE_SIZE. Thanks.
> 
> No, that's not needed; we can handle that just fine.  Maybe this can
> use kmap_local_page() instead of kmap_atomic().  Al, what do you think?
> I haven't tested this yet; need to figure out a qemu config with highmem ...
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 960223ed9199..d3d6a0789625 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -857,24 +857,36 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
>  }
>  EXPORT_SYMBOL(iov_iter_zero);
>  
> -size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
> -				  struct iov_iter *i)
> +size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
> +		size_t bytes, struct iov_iter *i)
>  {
> -	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
> -	if (!page_copy_sane(page, offset, bytes)) {
> -		kunmap_atomic(kaddr);
> +	size_t n = bytes, copied = 0;
> +
> +	if (!page_copy_sane(page, offset, bytes))
>  		return 0;
> -	}
> -	if (WARN_ON_ONCE(!i->data_source)) {
> -		kunmap_atomic(kaddr);
> +	if (WARN_ON_ONCE(!i->data_source))
>  		return 0;
> +
> +	page += offset / PAGE_SIZE;
> +	offset %= PAGE_SIZE;
> +	if (PageHighMem(page))
> +		n = min_t(size_t, bytes, PAGE_SIZE);
Should be PAGE_SIZE - offset instead of PAGE_SIZE?

> +	while (1) {
> +		char *kaddr = kmap_atomic(page) + offset;
> +		iterate_and_advance(i, n, base, len, off,
> +			copyin(kaddr + off, base, len),
> +			memcpy_from_iter(i, kaddr + off, base, len)
> +		)
> +		kunmap_atomic(kaddr);
> +		copied += n;
> +		if (!PageHighMem(page) || copied == bytes || n == 0)
> +			break;
> +		offset += n;
> +		page += offset / PAGE_SIZE;
> +		offset %= PAGE_SIZE;
> +		n = min_t(size_t, bytes - copied, PAGE_SIZE);

Should be PAGE_SIZE - offset instead of PAGE_SIZE? Thanks.


Regards
Yin, Fengwei

>  	}
> -	iterate_and_advance(i, bytes, base, len, off,
> -		copyin(p + off, base, len),
> -		memcpy_from_iter(i, p + off, base, len)
> -	)
> -	kunmap_atomic(kaddr);
> -	return bytes;
> +	return copied;
>  }
>  EXPORT_SYMBOL(copy_page_from_iter_atomic);
>  
