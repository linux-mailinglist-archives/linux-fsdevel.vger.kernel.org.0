Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DDD49AA95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 05:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385298AbiAYDmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 22:42:35 -0500
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:55137
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1446018AbiAXVGO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:06:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3kmyb1J8qvVu3sotWUIcpsiJ7YeuQVi7Vh+9wjZWS95LtON4rnSIUpDAa4PUU+hQYPqR4XZF06hXAAl8dauog0HxfF9xlidnuZMMIPtugk28pHuQH+AvxlE0OjcKR3STwbmXYDMka4u5iRQXhIvnAp2ql9n68SHfTpWhuH1fuy6z6O6aKDzxTdFHfdtJMb02P+HpySiZdZo5AxTDw61hyPuuXtqSvYZenBwac38ZHaa8lBQWA0n/vddj/MjdcwkcGUntmNA7f3ggXNu1Hz5IELQOT/Du8n9wW0Il2Cw0VaMYVxlTXEKqCq1AZpFV0NJNjZ+2bBmEHJQ2mXT8w5wzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDQrdaLjvVYOqCwnNm95+Yp7UtVHJ9icfppg/V4bL4Q=;
 b=FXb2PONEVJaMuIXtoUbfg+KpZEqzKZHTDaFeZfUpYnPqE4MmBr8y35iHWWl47flQxnPBspzS+dwjBEvkVbOmg38zFrLJl8Jh1qjWqk5EoJGj+bGTevSoUMZhjUdDhj2OkuEmQIMzdz7SpsN8kAZ65Tl/JDY05IzupBNEBdM9cvcCjyc+klliQeCiMXeyowMpfJ5G3m7fON+qMzELFlMjIhnj1B7PwjxN2NJKvqbcpKpR+w0SFBkK1mBuLQ8HNnPtkLaDmeARwrtKL9NJdbcC0VmLzr9IdXsAiLd65OrotTYIvjCt7NFEiVJNLppd7DhZRB+PLrpm4VP5Yqwsg9X09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDQrdaLjvVYOqCwnNm95+Yp7UtVHJ9icfppg/V4bL4Q=;
 b=qhxXyA2XUs6ho9DRqFyibqaHX31bdZhcWp7sdrZ9w98l1UBL5f5DAn/woHvbzNbcDpzo6kxxZPx2CBMqXo3JsnpbKzNPl2/0dOMiYgnHRHR0Y9Vg2bHtIH7qJjhhbYaLoIe1Dhz6EaKCl+qH21xznqjuYn/WsCZlJ9fPhXCH6GZLQd4/eUH5NYM8PUlASKe8IbTdhQLa0T868VKBojuAYyjlBElgmb0Tzi2v9/mRxWwirZd3Z85/3qSxlF2vLAXa3Ex6pEQ7Bz3ewvnXOSuNRTDQR2raxruC2M5N76a0Nmv7fg7XEZ0hzTDVQeMVAhavMwpOd4HFB3poeBL73QwpWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN1PR12MB2478.namprd12.prod.outlook.com (2603:10b6:802:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 21:06:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 21:06:07 +0000
Message-ID: <923c30a5-747e-148b-43c9-32dfacda0d0a@nvidia.com>
Date:   Mon, 24 Jan 2022 13:06:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
 <20220124100501.gwkaoohkm2b6h7xl@quack3.lan>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220124100501.gwkaoohkm2b6h7xl@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 359ff0dc-385e-416b-1bd9-08d9df7d56e9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2478:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB247812DF895ECD07E10114DEA85E9@SN1PR12MB2478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/LwclQ3+U4t6SRUdT69suKOvRpRyX7RJo9PvJ8Ok4VPwO4SyOm7hhdjNNHfamwmXaU2l7cZ9PShe7ZI5eXUzWifrWZrBIr0kFvxCi0OJBfFWzctybknhZKu4rB4x4MQGZ3FaGUZHLVvhSf83ytPOZjSsoHW3sGvNJoTTGIXHHUCZ+ej4iHSSpVKrkeYI1WQg1+Ty1jiDp0RdSxrTHwwLHt3gH9VAjiNGjLNqR1bNoYAQKqWzdgAakNwr7Vuyp4nubwFoJ+/elCiVBzrOVqYqhXb34+cAQn1Npy2mxLIqX2sUF2yF6VwkmW/jT6Pc+kgJIp2Xe0esneyTpHWrYZwwtAJ0wY4rZ+TBMCClJaF8IIdvKDT6ahyNSKl4ggjsnZgex2ZqGoQ7ZKga5NyqotlE9bDg1FmedlmqJyciTpwSYqySZWBnhElT0cGUuiZ6akBFDSgYhGpjAywzTsn/uTLeRyc7pv/v89pytNujempOIC/3Wg7Q9nlypALfYEM+iNiBekbZmqelpgIYCKktQLbBcEjmdAx+zGmjEB2h+qmn5nEA5b8fR1ds2ekbGZaw2S7QT1TnpxeWANaTeGg/u9nXq1eW57I0jrUYsQK8b6HW3tGQQBQIvw+eC7A/ZadGuX83P2t5L9WznMyoPN68WdH5dvN/8sn1j4Z67WYQG8WEPPkd8gs6MeOcNpAXwrS0pB5QYQMoop4EaCSHH7WJodNCzC/ZLgtyoYvdJOi48/DRo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6506007)(6916009)(8676002)(4326008)(36756003)(2616005)(31696002)(53546011)(86362001)(186003)(66556008)(316002)(8936002)(6666004)(4744005)(26005)(6512007)(83380400001)(54906003)(508600001)(38100700002)(5660300002)(31686004)(66476007)(66946007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFtV1J2L2tIcU1HZkUxaEZ6RjV2UStHZ2F5NkZ1UDlWQTZhN3o2QlBDSWtB?=
 =?utf-8?B?bXFjWmQ3TnNTK2NvRjd1REdxK280SWJZWUhYWXZpNUNjdmYxTFk0TWtuN0tl?=
 =?utf-8?B?TUM2UnVLYlV5ald4bVlQMElEbGpQcFZRZENSZkt2Qms4dXowNFNNMzZzS2VM?=
 =?utf-8?B?MmIwWE9xZkNxYk5XOXVWWE13SWg4MU0vYW1LRWVMQ09GMDMxMldLeElRa2xV?=
 =?utf-8?B?b3ZXVkFDM3k4blcyOFhjQ0w4d0NJTTBlSlY2TFVWaDQ2eTZaalRrcVRjaHhI?=
 =?utf-8?B?OTFTODJqamh0RjcvYlFxOWw1bi9wUC80WnpmVU9kektXNjNOaGhQdWtMdTRB?=
 =?utf-8?B?cXhJSE9wUWEvdlFxZ2gzRHM4UjNhUnNiV2h1UGVDSWpCOGc1eUcrS3FHdWJ4?=
 =?utf-8?B?MHRYOERVVjVPSDVFNDFkRW1QK1dHTW9pZlFoWUw3b1U5UlZkQWhnL29ETURY?=
 =?utf-8?B?SE9XT2ZVaDVXOGlWQjdoMjV5aVkxVHYxRlhoNzNsTy84M1ZTZGZ6WE1laFdz?=
 =?utf-8?B?S0VhRVZ5L1FXUmFESFVjMmJsNDE5T1JBTU1UNTRIbmNBc3dFMXFGMmpBQmZt?=
 =?utf-8?B?YkpiREpVNWVBeXVUOStTc21LclpKcmZCQzJVOE41U01idk1iVm1zNzlJVXFr?=
 =?utf-8?B?a0RPMmhmYW5qcGUxZ1FRMy9iaGhTeFoybHc4blpzUXNDTzJWUTRnM1d0b2VS?=
 =?utf-8?B?dlVUVXBlYVAyMXIycGx3aUE5VVpEY1JlaUEwWWZXSzkyOWdTWXFqUHhmTmxP?=
 =?utf-8?B?NVZHclFySVc3TEtIY0pxY2Mwb0lSZWpVeTlOVTBiak5qTXRHRFBORWlFaCtW?=
 =?utf-8?B?aXhvWGVWbVJnaWV6OGhzM3NudFBaeEd5L3N2MEppMFYwR25KYkRyYmVGa1VM?=
 =?utf-8?B?WHhEdVNqcEM3czYvMFcvN0FIS044YVF3cEYxYmhaa1dENVVLTzBnR2VIKzZG?=
 =?utf-8?B?ajFYYXNkc3pHTm1rOWtKdmN0czdlNDZaYmROOGlWWmFqNXpyWG9FblArRUZo?=
 =?utf-8?B?ck9tbll0R2Q2dHRONXBLYTBKZWRUM0lLbmZZR3lsU2Rpc3F4MGRTVnYwcUg1?=
 =?utf-8?B?YTFvQXVFTzFIQjEzM20zbnVmd09MWXIvWmdCbk5vR3ZTTmJhd1BzZGM3VWtn?=
 =?utf-8?B?ZjJKVFNXNExibWVsWGN3WTlkODVCMmRMNnU0MTRyYmcwNWU2OUhIQnVDL1Av?=
 =?utf-8?B?dnU5eXUvSUNzT3pQb0lOTzhveER1cU12V1lTbTBxSVMzZ0VXNjVVMTZJVVow?=
 =?utf-8?B?WW43VXJaN29JbHRlaFlFZTkyaTFCWk5PdStWaC9jMjdDaVBEdC93MkVkQm1O?=
 =?utf-8?B?ZzVvR0RUNm1wZHVLV3dvTWMvdnYzSHVuRWlZVjJsenp5LzdPMFc2cGV1M0VN?=
 =?utf-8?B?MUhXUldzQ2IyRGpsVmNlQ1prQk1HRkhRVk5BRGhEanNBZ1VBaURDR1BydlFj?=
 =?utf-8?B?Z3JhOURGa2JtV3JTSDN6SEZjQ1dMVmpkN3VXY3F3Y3hmQU02VXFFekVjUCtQ?=
 =?utf-8?B?V0Y3YlF4UytjcHpDcVZBRFF1Z2pLbTF3TmNwV1MyVCtUM1paM3VrazZISWNs?=
 =?utf-8?B?aHFOOWxPWDlQUVJpYUNNd1c4SnBscGIrZVhkWTRZYjVhNm1SSU80R1gvcmk1?=
 =?utf-8?B?dkZ4UVdSNEtRVldwNDZmTXZFemNnZGpWN1FXL29ndkVFRWNpWFVSOXM2aksy?=
 =?utf-8?B?ZEl2NDJTWkprQ2xWWmV2Y0tGNmkvZTUvQUFKdUYyS3lwd2E0RklVYW1UMEti?=
 =?utf-8?B?alNxYitrZ1lqSmlPaWR2SVQ5dklsTmlaQTJwL01CRDBPYWZ2a1NZZ3I0NEpl?=
 =?utf-8?B?NStTWkFqTEhrUzNPaCtrTHRTMmlVMVROdW4wSkxVS2pjSGpndmd5MkJRWVZa?=
 =?utf-8?B?aFRqZmI0UlU3elVLNFJtRnBUVU4rQjhiK1FKZUtqeXVsYVEvOXpCeE9YYVB4?=
 =?utf-8?B?OUk5ckpqWC9rNWU5UmFNTlQvMWF6UGh0Vlh4aTB4ZWJyaUhZUlJySUs3OXpD?=
 =?utf-8?B?MkVkNXRrTklDcEVsQ1c1b01UVDdWVmNNYnhKU21LVG1qSmRuNEM0N0VuK252?=
 =?utf-8?B?QVN0dDVoMEdrYkJvWjVsNGNKc2lNSW52dVhSTnMwUWdZeTlmR3lzSklBZDIv?=
 =?utf-8?B?MXNWWk0wYTQySVZsTDd6VCtyekF5Y3Y0ektHZ21UYnFwQ1pYNVpRYUhLeUwx?=
 =?utf-8?Q?VH5+Q4N/DKVvgHmMRCwzBFU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359ff0dc-385e-416b-1bd9-08d9df7d56e9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 21:06:07.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liQbpzq3DqMOkj4ggpzi8v60FZPQjB+OyqTRP0s/z3kDdnU4GPU474VHRVCx2QqszUgA82bDqFcIJBlgOpTHlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2478
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/22 02:05, Jan Kara wrote:
...
>> do_direct_IO()
>>      dio_zero_block()
>>          page = ZERO_PAGE(0); <-- This is a problem
>>
>> I'm not sure what to use, instead of that zero page! The zero page
>> doesn't need to be allocated nor tracked, and so any replacement
>> approaches would need either other storage, or some horrid scheme that I
>> won't go so far as to write on the screen. :)
> 
> Well, I'm not sure if you consider this ugly but currently we use
> get_page() in that path exactly so that bio_release_pages() does not have
> to care about zero page. So now we could grab pin on the zero page instead
> through try_grab_page() or something like that...
> 
> 								Honza

So it sounds like you prefer this over checking for the zero page in
bio_release_pages(). I'll take a look at both ideas, then, and see what
it looks like.


thanks,
-- 
John Hubbard
NVIDIA
