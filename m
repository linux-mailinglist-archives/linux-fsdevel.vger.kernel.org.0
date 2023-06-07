Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933C272520E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 04:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbjFGCVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 22:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240762AbjFGCV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:21:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC481BC0;
        Tue,  6 Jun 2023 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686104486; x=1717640486;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XhZIvrfNEES+z7P+3w5Ph6Gd3ifBNCXNHRejkMTmT/4=;
  b=JXb8zrEbZMmLRlg+FmddXm63uEtLlgCrInBVOfLFKCrIIatfQZLKiZzh
   gDN6OMxnRneVt6DB5ZdW5upXWwSBMMXpzpurmHnLN3kOT0MQLcdwiQ1Qe
   7PQyixLqgdiJp4z0q2fYLdbug7Qyc1Lg3tbIslMBxeiloMV34mBIdMyfW
   Tm7ImpC7yhRxBPyExmSWJZ3w6+oC/NQ+FLPdIfV3aUS8VWqKqucSgmsBV
   mliw9SVvwFaIF6q1hrxZfujcLb/Li05hxTJQEhNBpR9jrmixZpypIj/l0
   ydlxP29lGTZpKes2buCZB5KFi/714LfEQczZotCTQLIi3pWl80F1UWVd0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="359322380"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="359322380"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 19:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774340445"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="774340445"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 19:21:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 19:21:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 19:21:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 19:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+OPgy6ueGy79IlBS/ftRrGFi5H3V6Yakh6/Huj5kNUNAws4PS1kgw2Y19gP3I/HaYNbZSMbSPOuiPgFXQVPTavAL1JS61VNOtozzP5o9VVfFzb6aNniPHMbjAylDRMvYuIJF0JMO68l2otSLNnyFGIv+WX9qLZpOtdX3d1l7ZEQBSPJu5GgDIeuVYrA4J1SR9RveDgSBm0e1bWeCXT0WumJVfv1J5hUKD4jkeY6Y9UJaSkXwydr5tke7v+jXjgP5wVUg/Pw9vTrGyY/Evw9bs5LG67FgPqZ0aHi1LcGjrRd3ftfaPm6zAmS+FcC3b1QZmZ9R1+XWbvba9tOhw+2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2k8MjKIPsSVb9ykFWPKptM7FlcNLgzaWkdvUoFwxrk=;
 b=K5q2yk9GN7C6gpKKB99iRJfXYc0LYj4THo416hc2TMPgzT6DUYX3JMMheyCjbY2N8YEX6195OpPmU/0e6LfIcad75Ak1JuHlkdO/9TlOU8H1zWWFxoJJb8UsBI9MI/NJ0xBbus7khU0e3aw/sVbn5cikKV6/PoJVR18srXUlyL33F1NPyKvyJTQO/6lrFV6SzeKLWxX8V7Ep2UidTO0tpUs5BqGkoh1JEQ9uAiz+dYzQQzb+vnfuKCE05OWyoK1Is/Bvxoe5B9wspvPHqLuFJ1A941ovG7ZSk+ziyAstIcqAJQMkVpmV1YnP7nBkz3tLtV01ba6hcodkk4Q+12hi/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 02:21:18 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 02:21:18 +0000
Message-ID: <2b5d8e17-403d-78e9-8903-659bd1253de3@intel.com>
Date:   Wed, 7 Jun 2023 10:21:41 +0800
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
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccc2746-0a43-4172-dbef-08db66fde035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYCz0CP/ksEZUkx5CZlMzQ9umYMv24z6xfmpYSBgZujTHtHK3OMp/ACCwiaV7VEmUMbsBJXrNfPl4ZE3hFzTfkrAfnFZW+vu2P+kaDjrAMKAX3wXkL3sHF962WaHnQNm6o9TJHHNxiPrF+UJmWeKq4x6dc7arHdrtiYSx9nBmLZAn3VeGFsMt2vyfw8chduQgfVzTba13drIXDTELfOpvfDpPC7iONhnIaWRvg9wWpjqeM4aNd0hDZiroCkLSRHmvRXs1ucsKHvtby1t4GkhNbRkEUR5bbo1jOnY43x63jAy+ZpeHGMq3pQWcPmFX6+kq6nuO7EBRd+nPCTBr6PM/ycxHBKCDor9cYbx6bD6BGVL4bqG4LQjILiDJjCFEJ2oGLP9MgG4fo2L+JkQj6OWoFY9J+X2/KPtIJQZzJmxIEzKUPVkcj3jmhLpg8za94Fmhj14wt6d644s1VEvxWWIzFMw8TsLfLqgTnsM4HMbhtp32Os08xw39oljQWDbaFO2sof/YrkeoWvg6/yUQeoo/iVOEL1X2wBt1fAqiiYZ6qKKzGk6cWjLYKnRVlt40Luaqm1k9huffObyDUPP0Ka7KSygF0iqJQP7eE8VMkjnfTumddQfmTaNTiRVX1UUoiRQFmaX2c1zsvW5BBuCP8XpwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(83380400001)(2906002)(2616005)(31696002)(36756003)(86362001)(82960400001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(8936002)(8676002)(478600001)(54906003)(66946007)(66556008)(66476007)(6916009)(4326008)(31686004)(6506007)(66899021)(53546011)(6512007)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emhWU29ZMHYvVHFibThKK3pGLzlyYU9JL0JWOXU0R3lGOTlHejFBb2VMK0M3?=
 =?utf-8?B?Mi9FbnlRVUozU1BQWFpWbWU4TnVjV2g0cThka1hDSUJodHZPb2M3dTNHY1Yx?=
 =?utf-8?B?UFhBT0drUDhXY2p3R3Uxa01xMnM0dm5CdWxOU0dYWlNJdGtySEQ4eFdNUmJG?=
 =?utf-8?B?N0RLWTBjNFhzRGtXcG91clNseUs2YTFMRHllTkU5U3A4MGw1MTBUZzBDV29N?=
 =?utf-8?B?MUljL2pyMzkwRUhNUkw0NDRoRDhWd0wyejQveG9yWXh0cWQzekk3b05vYysv?=
 =?utf-8?B?U3hSd1NMMndGNnc0dEFjUXlmZFNWNFdHVE5aWEM0Q3Z4T3pld3UwYmlmM0lm?=
 =?utf-8?B?dlJCM3NxazVOM2g0d2RHOVhsTzh1ZmdYa1FUZTlnZXpxazJWMTJ1NUhnKzRR?=
 =?utf-8?B?WFFGZWhBN3dXR0ZaS1FocVFnK2NCUjRSVldzTUY1MzloVWRLdkhQbG9uZUcx?=
 =?utf-8?B?SG96TEFvS2lnOFRGeTAvOXJFdVkyN3J4Vm5ReXh0MUZ5d0RZM0t4S0dxb1Z0?=
 =?utf-8?B?Y1ZFcHpWbEhPS2pDYlpVQnhsa1NqRVAxZG8wTDdLTlJ4bnE3UzBKcEZEY0ZL?=
 =?utf-8?B?eDVRT0R1UDQ2YTg1bGpZQmdOUC9PK28yQ2lWWHhCV2M4R3VWeUc1S1J3cGNI?=
 =?utf-8?B?MVg0ekVBYUI5SGZpU3FIeE5MWW15QmxjeU5IUHpYUUlUVno0SWlaQjA1Mmx2?=
 =?utf-8?B?YTY0UTFFTG5xdTRuWEl3dW15NGhGT1V1cGdpalhpZVgzQXJqeWt6WDdMS0Rp?=
 =?utf-8?B?bW5Rb0pLUC9kQ3JpZU9KQnovZ2tSVXNIYXdrMStrbjFwNzljNFFRRmFZRmU2?=
 =?utf-8?B?SlE3UmFjQ0ovUlFUMnNNQndHdnY0eGtESERLTVRhcWsvVVFlZGVENm1SRXhU?=
 =?utf-8?B?NEFzNXVZUUluc3lUNXhVWUJmVC9pMXM5L1cwbGREVjcveFVEZFFvQWc0Vndp?=
 =?utf-8?B?QkxEdEV2UkozT3oxazBDcVdtUW96NWVsMUFPZFJZMWZxSnhaMkMzZGtjQit1?=
 =?utf-8?B?VjBNNW1JU2ViUHVsS3NHdFJNNEdJODJpNXZGckJsZmhCckt1eVZUUU5PM291?=
 =?utf-8?B?Z2xOaE82Z3RxNC9EcVhUempFeVltdHFFdFY0eFd5eUdUN2pLQjYzSnhHQlVE?=
 =?utf-8?B?M0pzUGFyUTFkOVpod1NaZE1TbTJnT2RqcjhBM0hyd29jSHQ5VXMzdEhlSnBu?=
 =?utf-8?B?KzZLcnExanVDTmN2SXBvNVgzMGVVZUxBQ0NSOStOZXIwUTlaU0FjUTFJUzZX?=
 =?utf-8?B?ZVZqV1hMWG4yeUJjTHByNW5LTnBsQ2hOU0VMWVRIVXhYaGI1RXRGUE5CM3VS?=
 =?utf-8?B?TW5mU2Y0Zmt6VUZRMk5USXJRSlpNMTl0SFQ2R0VPUG9QTE85REVhY0laU1pN?=
 =?utf-8?B?L1pmNGtnN3ZnVE1uY01sSXFOOU9La2YwNGlDbVlIVzVYWmlLRW1zWjYxN0FD?=
 =?utf-8?B?MlA2Y2RWRmg0UCs4YTlTd3ZqcWxPR21ndG4zRU1uK2o5Y2JNSmMxU2c0L3Ji?=
 =?utf-8?B?cEtKaWkxOWxTNE54L09LUW9raWVpVFFTeTJmZmZ1c2tpNE5KOFZMcHM4TjFv?=
 =?utf-8?B?UTBwUVp1d04wcVpFSUpoZFJ0aTVJVWVkMitSTTcwS21Jc21DalZKVjk0ZmFx?=
 =?utf-8?B?cUdPQ1RUY0Q4ZzRMZG5OTE4zcXZzTGQ0TzhUV2EyQnZKNlY2SXJ6cE5uOTRB?=
 =?utf-8?B?eUU3Y2hiRENtdTFRQ3VyUGxReHQwRm9vaXB6UFc5MUpEWmVicS9tN1hlUlNY?=
 =?utf-8?B?RTJYNjJGYU52RTVaMHJDaERvTTd0b1pJRVp4VEdxamxpaWkxcW9xaEo5TkVa?=
 =?utf-8?B?MUpMWStkMzduSURHRGsrREtESFo4Y0xOajF2R0hTM1d4RURRZE53UFdZNDVR?=
 =?utf-8?B?VFkvS1BUMjY5THZTbXlHTVFxbWtPd1Ywb2p4Q1FMckJEd2lqY1BZZmE3UWhT?=
 =?utf-8?B?VG0wRGgwV3Z2djBHaXl6YXBVSXBSYjdldEsrbTdXUWNHNWpGQUhiTXVreTA5?=
 =?utf-8?B?Y2lOUlZ4a3BKTWdhREFBUzh2ZGlRSEk2TjNWSlViOG0zbHJwei8vVk1SeDk5?=
 =?utf-8?B?dHR2Uy9oSDhXYW5pNEVkMm9DSndMTW9iZXZhVXlTQlZPYVhDZkd0R0Z3OE9D?=
 =?utf-8?Q?8UrgatnoJyp1AnN1pt/ogfl5W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccc2746-0a43-4172-dbef-08db66fde035
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 02:21:18.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7pFyrmqj3mnquWimNAN9floXuiIP5fYZxQ6cO0AT5nzc+LwrfrS0CKuvpvQy7/uy59YYkBQ3jZqhoz2IQKKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
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
This is smart.

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
My understanding is copied == bytes could cover !PageHighMem(page).

> +		offset += n;
> +		page += offset / PAGE_SIZE;
Should be page += n / PAGE_SIZE? Thanks.


Regards
Yin, Fengwei

> +		offset %= PAGE_SIZE;
> +		n = min_t(size_t, bytes - copied, PAGE_SIZE);
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
