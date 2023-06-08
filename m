Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77E72743E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 03:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjFHBXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjFHBXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:23:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF3C210C;
        Wed,  7 Jun 2023 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686187417; x=1717723417;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PWkDFfxfVdFp2PKdHZWJ7FL5smHx8oU8TUB7EnfH4uE=;
  b=NmPHQE3WKa0WSoHg21/A+3dLQwI26i9Ebq7Rx2WsItjUoN92dXvJjKVV
   lNEvAutXZicUsApw8XMYX0c6bDFdOOkeGFOnC1zlTe8GYjQowGA629p9/
   rw4FIWQ/SDMO2Mq6DhepoqlPo0I8MEv6/3xYmLumTeBqT24Zp3vc5VWtk
   yHmuCjXsUUZ0wIwQBNtgj8gPJqIj3mOOJeOX28dPE0ac2r6Rnu3D8RDW+
   QdaTzE6qskGsv4mAr7XKkrSqKJ0x9B5oKa4HY0aOLIc6TrgMVBWgVEKz7
   RJj8mQSmSJhoBeJ1ZkJSvCWw3BPCEr5LS1tshgNDp6H6tIO9GUElnOJdp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="359632424"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="359632424"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 18:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="854131121"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="854131121"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2023 18:21:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 18:21:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 18:21:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 18:21:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHYNvS0Ni03PF20mGyigl6h6JDq5uxhGzCzq3PHX9J4zrI3c22o/BRrJ7eO/MM/MLQEIRfJC0CGQ/CeipMJxP25SQtg6jE5x5JcUDvmIbQkElLDnIUNmYIfItH8SSxTedPHZ/93YVZpOjCje5LeQToujyUn4LNyiXmG2+xmt3m5yIcnHKLrcxMPQyJ9PRnH8t+MFWhJzzAy6R20XInC/zU2EHAO0pnyaEiyiBPVOd3YgiDLlkT8JDsCS02m+gvaalGOk5Wy978l63SSVjPO7XYHAPVQZCvjR/31AJ7864dq/r6jbSj0ZYIwUvMdHr0cfqiw/77otFyz3b9kykShCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yylPlBkyIDgr5muec++6vqEAIKiT3nlpb0oc8W9v3Q=;
 b=I264AU4YyIS+eWdpevsIWulyDU1CEAiI+Qw6nY40ILwlBC89/NUT+MmOodCq2kUjl1M5S6kp071YIrKs/5wYMJh3dpXJUsExfg50ECsFGLruu4Nagt3vphjP3C/kedn9YL5kuKo+4e0pTFVoS4NAEaE4gK19Vagc0+t6pITM4IHPEGPLPUE0C61sLusUeuUixKEnamc4u22lPbhvYvDV0jM5L6j2x9gije/pSCz9wvv5QMYEwPVB1OKLPWMcxXH1vau+moH4bccCUCMvsEo1t2tFUJbJ9JfNt9nGH4i6LRIKTAPgMYOakq4wBSXw4kwkRRx2d/8bjWgIHdI0XtASCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM6PR11MB4548.namprd11.prod.outlook.com (2603:10b6:5:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 01:21:44 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:21:44 +0000
Message-ID: <8fa8decd-82ca-43cd-e94c-ebfc1c2782b5@intel.com>
Date:   Thu, 8 Jun 2023 09:22:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 7/7] iomap: Copy larger chunks from userspace
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
 <2b5d8e17-403d-78e9-8903-659bd1253de3@intel.com>
 <ZICoXy5TEgSy0yFr@casper.infradead.org>
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <ZICoXy5TEgSy0yFr@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM6PR11MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 128cab2c-f477-49ec-a046-08db67beb876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHCYbA1OLTNjK9NGLvK97C96SVa3mDsr9m/ezXaTXAVRzIUiABy6cQNcaeLEXz8UEcfUVqDu6333U19vNtDv21lPyK7oBQKWa7oUBtofAs9BKgnJ3x12RbGZQshXAfrhVxGXCaLslPSvK5jKChzzTvmFYxXaM5RinjYFuYQ15+yuv15l1NoIn9Ot8x1HFCxeSXuC46lXNJtDIPUUs0omeSNVWdDZ/EnqbnK5Ynt5zwt24jjxiLylUpC3wOgPKDv4nVkEJviCErEEuhiPmJXPgHmQfFikk4pCAaBMw1e9d4LFkiX9aBzTnIBW38vL0YvZ3WHPMHK8m4o3kwMII5I/ATvBkUP+9Q2xzVaE/OwCsHQ66KcUei2o99AkaQ5v0CFZjVlWShhQ6hXk2GTa/P7DwnHx5hbqFYRoxBq2N1JrgacfVg8tU5y77FZGJqaSltExxIERdlwLClQOJoxm4j47fsNgLK/jA2qie7H2Qsq3ERfZ13119GPtCGoELq788g8wOxmHKUV7eo9xdZHUjBMh0jWIIpDs4wIkg9su0nLdsSly/5bJKWHpkfhlEDBM9GgQl9dcmXa2sdIc5f1rpylWaRXENJwbZP6VBiLeYZhLxXyKTl8n20cVpkL5CqZptqL0MB5x5cBSbpSroYi7ihu9Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(186003)(6506007)(6512007)(26005)(53546011)(2616005)(31686004)(86362001)(6486002)(82960400001)(36756003)(6666004)(2906002)(8936002)(8676002)(478600001)(316002)(38100700002)(6916009)(5660300002)(31696002)(4326008)(41300700001)(66476007)(66946007)(54906003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZmNkZZV3paMmw4VnVCVGZWcDFubkYvRnFSVm83Y0d5eW1PZXlQOExlRTQ3?=
 =?utf-8?B?eWUzWm5UWkVPT3A5ZFRuS2JTajZ4bW5PR2RaaGlsbVoweUFmZkZMV1ZpT1NE?=
 =?utf-8?B?Q3AyM2NuQVN6d2dhZ0orYlFUZzJmVW53VDdCNFJRbXVvRUY4UEl5aFJpN1di?=
 =?utf-8?B?bTV1VERnS05LWVljUlZhM0V0MmpwSVVHRGZnRldqT3FtQ2lCYnBCaVlpdnY3?=
 =?utf-8?B?SUJvNDBKYWpWM3QwRENNSlRVVkpGVWhJTndzcHRFQ3ExSDhzZzJnbS9kVWJO?=
 =?utf-8?B?THlKMEdWRk5VRUVaUndzNUhiWlQ2RU1RQ3hNS2VnRW9CdWNNUTZMdE1Da3BO?=
 =?utf-8?B?YVpzVWFXY2Y1SkVQU2hVMlFVWHFtZjIvODBzaWE3TWQyWjFrcEhObUdwMkpL?=
 =?utf-8?B?bERNc0NESktLeU5RTDFIQTU2VVhZWWtORHg2T3ozRzBQRkQ5RzhBL2RJTVJG?=
 =?utf-8?B?a1JVRDZFOEFBK2NCdVdUS3kva1BuUXZ2ZkkvS1BsVDgxVytrQlh0OEhUMHgv?=
 =?utf-8?B?cms4UDVZNU5EeE1oSWhNcjM1K2txSXJFbG1RL2I0U2JUU3RQaEE3RGovN1JR?=
 =?utf-8?B?c2NDSzJueGg0MnE3N2MvTlJRbGNZR3I2cXZLbmEvV21tNzMySXFyUXRjSHU3?=
 =?utf-8?B?SHVuV05sOURKZ1doRWp5clR2cXIxYWJJdnpYZEZreGx6REdrS2ZGWEFyMFRD?=
 =?utf-8?B?UDQzWWJaelJYdHUreTUrTTUza1VCOFBvc3phdXU4ZjNYUkxZRFJadk9WNE51?=
 =?utf-8?B?dm1ISXh1Y3BRKzN4N216VXB1cnNtMURNL1pwTU8wZWxnekk0aXpKNkVPUUxP?=
 =?utf-8?B?bkZXaE9BOWpTMlZFVjRQMkg4eG91RTBEYVFkVjhXbkdGZDBndDJJejgvb1dU?=
 =?utf-8?B?TDJBS1I0bG05UzRZRmNXSTA4MmNXV0pPK0VLUkNjZmNHRWpQdHhXa0pQQmU2?=
 =?utf-8?B?OGtsRXJJS01VSXdvd2FkUkk2cGNrRnVsV0hma3FiR3B0YmFJMFdnTkJJblJK?=
 =?utf-8?B?WWJQSWhJeGNVaGZsV0NMdDhYOEZOVzJsRnZ1NW1NbDE1VEJKSC9uZTV5SWJM?=
 =?utf-8?B?VDVEUTAzenRrYk9HTjcyME9adHRoMW1EZUJUTFhBZFNNdEZxSElRTnJSZFRq?=
 =?utf-8?B?Z3BSVDhRcW9MOHVSeFhNeGNXYVFkUGVpU3c4QmNja25qQ0JodzAyODBmSXZV?=
 =?utf-8?B?aWxOVjJFTGNPbGJackRsdHUzV3lwMmloZ1ZOODhRY2tQZEF5eDBUWld5bWtu?=
 =?utf-8?B?N0ZiMmM5OFA3cDNmWVppYVZ0Yk4vcFM4bGFYUnhCbjZXQWJRT1YyRUJOa1A3?=
 =?utf-8?B?TmZZNjlzNklkWXpWaDdKRkxxcG5iS3ZGa1pRdmdGNXA1RkVSMEpJdG53TnN6?=
 =?utf-8?B?cTVnYTZkM1V0OS9zWUJURlZRaUw1dlc2ZGQxRk9WU0FnaWZ6WUdwRmxKbm9h?=
 =?utf-8?B?YmxrYUNhTHk3d1pwSlVFaHROSUNzUWN3SHRiTXBoMGhRelJyMWFweE4weU02?=
 =?utf-8?B?cTFiY3VxaGQyL0JZYWp6RHlmbkJpRllWa3pqWnIyVmxMWHBGS3dISE5ERHky?=
 =?utf-8?B?UVlyMlJWb1VRNE4zRnRvM0lQYi9VKzBsMEVQRnFyNmJNcGsyaDJnMUtqZjdM?=
 =?utf-8?B?bW8xOGM2ckVVRXZrdzArUXdVZDNBeEpBUlB1M1FXY3gweVVlY09qclNuMmxX?=
 =?utf-8?B?WldOa2dlL002TVRENlYveFJQa2FVcnAxUmNCVXpwenpRaE0rdklvdXhpUHM4?=
 =?utf-8?B?VTN1RjU5a3B5Mm94YWQ5eGpUSzRyYVZtcnJBRG9UL2M2ZkdjeTh4OFpLb2dS?=
 =?utf-8?B?ZkNYWnNIYVd5aWs5WXBJREhJNjlVdEllbXdRSzgweWpsNWdwRFpsbDhSVHVG?=
 =?utf-8?B?c3BBb1dYK3VjOXBDUFZtUUt6dWhIQ0xOci9ZR3VyNTZLY2llQmZTMENUTDhv?=
 =?utf-8?B?Rk1tS0Mxb2YyR09lZTk4WExTR3FKZzN0NGtNS2F1Q1lWVTljRklja0Q5SVNK?=
 =?utf-8?B?SzVlTWNxSVMybFBlUW9BcG1uYm5ueG9NVi9SZXJLaDFEMWladktaV3Jzejhn?=
 =?utf-8?B?bzR0YmlkazRycWR2YmJad0RTWjJKZDZMLzBDMzRoaG43cEU5OWhrb0VCRUJj?=
 =?utf-8?Q?6tQ/37nAvH2GwD8WVy+NYTs/p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 128cab2c-f477-49ec-a046-08db67beb876
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:21:44.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVAD9OuUbfaWF02vkHtXkGmJN02msL1h8sp4RscfMti0v4+EWYF2jdxQoC3ealpnZusPBozLQap3wvutAzzZ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/7/23 23:55, Matthew Wilcox wrote:
> On Wed, Jun 07, 2023 at 10:21:41AM +0800, Yin Fengwei wrote:
>> On 6/7/23 02:07, Matthew Wilcox wrote:
>>> +++ b/lib/iov_iter.c
>>> @@ -857,24 +857,36 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
>>>  }
>>>  EXPORT_SYMBOL(iov_iter_zero);
>>>  
>>> -size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
>>> -				  struct iov_iter *i)
>>> +size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
>>> +		size_t bytes, struct iov_iter *i)
>>>  {
>>> -	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
>>> -	if (!page_copy_sane(page, offset, bytes)) {
>>> -		kunmap_atomic(kaddr);
>>> +	size_t n = bytes, copied = 0;
>>> +
>>> +	if (!page_copy_sane(page, offset, bytes))
>>>  		return 0;
>>> -	}
>>> -	if (WARN_ON_ONCE(!i->data_source)) {
>>> -		kunmap_atomic(kaddr);
>>> +	if (WARN_ON_ONCE(!i->data_source))
>>>  		return 0;
>>> +
>>> +	page += offset / PAGE_SIZE;
>>> +	offset %= PAGE_SIZE;
>>> +	if (PageHighMem(page))
>>> +		n = min_t(size_t, bytes, PAGE_SIZE);
>> This is smart.
> 
> Thanks ;-)
> 
>>> +	while (1) {
>>> +		char *kaddr = kmap_atomic(page) + offset;
>>> +		iterate_and_advance(i, n, base, len, off,
>>> +			copyin(kaddr + off, base, len),
>>> +			memcpy_from_iter(i, kaddr + off, base, len)
>>> +		)
>>> +		kunmap_atomic(kaddr);
>>> +		copied += n;
>>> +		if (!PageHighMem(page) || copied == bytes || n == 0)
>>> +			break;
>> My understanding is copied == bytes could cover !PageHighMem(page).
> 
> It could!  But the PageHighMem test serves two purposes.  One is that
> it tells the human reader that this is all because of HighMem.  The
> other is that on !HIGHMEM systems it compiles to false:
> 
> PAGEFLAG_FALSE(HighMem, highmem)
> 
> static inline int Page##uname(const struct page *page) { return 0; }
> 
> So it tells the _compiler_ that all of this code is ignorable and
> it can optimise it out.  Now, you and I know that it will always
> be true, but it lets the compiler remove the test.  Hopefully the
> compiler can also see that:
> 
> 	while (1) {
> 		...
> 		if (true)
> 			break;
> 	}
> 
> means it can optimise away the entire loop structure and just produce
> the same code that it always did.
I thought about the first purpose. But the second purpose is new thing
I learned from this thread. Thanks a lot for detail explanation.


Regards
Yin, Fengwei

