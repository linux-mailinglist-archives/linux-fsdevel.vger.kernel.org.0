Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C624B5E70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 00:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiBNXv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 18:51:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBNXvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:51:25 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9714036
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 15:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krHYZ+Y5gS+5/g+39wLmjtFT2MYEvVmiHeLmO0z92wrAAJZISvqUIOjckdS0lUQ/RQ9qW1xw6AIkcYgLzZE0HdsCuyLMKWxfujhPkN2C1pO/tWN9ICwwksULM5BAwG26ReKSONTcMKByzDwMUQ5uMouRFcF0sIkwKuAnIxEF5a57u6Y2IZgA0lwoiOe5Y/LwFMCkpcH/mSHpyySvWkjbfJ6c6yhnx9uKjhH4Eg4zKiTIGpM6K7OhQMPBdw53U0u4jAYEvOVr+4KSleFQ7F16BFcl4a1Wb+A/4CE9vWSpmr10Q1FIsTzne/VVIwZN/prXjPDKvlr4y7kU//QvK5w/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wce3rWwasftouIjK9UCxi64Kx0a3CSlP0OXYY3Lfr98=;
 b=S9BEklOY0fxQv3ExPNz4d2WxdMYjHfPVsLy5c/gvzx36HnPF5Q71Xtco/2rdFbzg5aRx7hKUUwNPlwvQMrsXNVsP3Cud2welGdepM5KEhkRNmtiU3zFigCWQqzeRDWPtMfSG+eNOG1QYXf7DTwFSu2/gBn/Ma4D+PXGx2xgTSDQdfjBSHgklCa21ffIBeJnj3SuTnKBivIK/dfuoZW4CfwZunxl2/hwzhovVtfT1InjKRN9j3X93KsPNfn7dsKdi4lhGgN8RNjOwKmfmhlM/ltjJILKdAkjvcUSJ3fVOyC0b8hHVEQ6wt5PqxxuuAfpahwBGu0humhitDERyz2O/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wce3rWwasftouIjK9UCxi64Kx0a3CSlP0OXYY3Lfr98=;
 b=Yqsbo7Uonw/jlMhkygU3UeGIudZ8gOBktrJqlRebUvQZsSijXn9y/0+U+KzR+ws4wKqoeGj6i6oAGxnl6U34Iw0dp6rVXiGEAl3znQ+E1H3SeK/fksoCKHdmwj6i6a/GcsOcyH93lnliCD1S9AEiYSE4ULPYiHwJTl9xfTHabe7QBiyreBLADs5obybSz1o93svIa31GNcdwegoi/B3jXV5PHvDS4YoGJRnKYmBJ6v38fTshDvSbBKn1FGIUZLb6h/GPSy3YGKCLl8F/j4GQyJMSd2odvaPIdzC9dTq8u/C5aX5cTjCZFS0GlpYmjzKP/ZhVtdtNnMnWvB4M6D/Kbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2775.namprd12.prod.outlook.com (2603:10b6:a03:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 23:51:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%5]) with mapi id 15.20.4975.014; Mon, 14 Feb 2022
 23:51:15 +0000
Message-ID: <71b8fc74-e98f-6679-9519-3be3c8abfaeb@nvidia.com>
Date:   Mon, 14 Feb 2022 15:51:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH 02/10] mm/truncate: Inline invalidate_complete_page() into
 its one caller
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-3-willy@infradead.org>
 <f711b39b-aea9-b514-1483-76fb128a2319@nvidia.com>
 <YgrmllRrkImmBL/g@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YgrmllRrkImmBL/g@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:a03:167::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94c32c11-73b9-495b-3198-08d9f014e335
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2775EF08AA09D820429E7FB3A8339@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09UNMvrlXEnH/SLgYAu7/pWTf6Axp8jrIYS7FXYp7tO9enr4xolVFY+GCcBjQOnQquufAG9X+p83qGqVq6MWKn0E5Zpr4WOLoTqGSjg4SK4tDgT6HKx2D9wvYPEQsx83K50UH69QUlGxI5Cb+ykhicqqtb3xSzWWNSwaMmuqh9IAs84GGny6kSb5Bbf9VLKICfCMruPD4bOkcOKFhkkkcLkwfcOHic8mQGHdTkMPtSqPbSaN0kxOqY9teFCp0qZg51jjKC8+LbehFWfX6ZJbSkYKmQwfoH/Iv4yRKc5hlraLE/CpgOKTvOpPDP4er9r1zB74aDzV8zjdUPE6liRYTOFZaa4ioNBOBzv8RWRGB4e2s/8dl7fozuQc4+YORuJJTD6oYJqyC0AYIlQnttyfP0P7EahDHlGkMLZD4VsEUui5PM4cz1lSXRmd0AieSOmrdTGtWAoYDXqRIIsNdErkeeHU9KWMx6sQdmAn3sYtwk2qRuq2HmNTcceuzZvJcrB49WTN7iZj8gK5Ghp22WGMMSRBHH0SPdmVKYuG1SIxQACbaLhZ0qzrhkXW27qdo5I+Hw6nyg6b2q+zkJ5+DQ9OJww2IBHaSLMR7uS8ScY0sbKjEiwfJHmE13ycIPj6UslPFOq4o3MJAh/AYh+0dx5M1RAlRSWQ7qlotWtK2f2//tWJqScYSuE213Mgipfap0Oz0mQ3ryaCovt5FQooA8iDcOpkw2o+MjuD/wupdXfvnkgV9auJgr65wYr39uYRkIj4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(53546011)(66946007)(31686004)(66476007)(186003)(2616005)(6916009)(316002)(66556008)(36756003)(8676002)(6506007)(4326008)(2906002)(5660300002)(6512007)(6486002)(86362001)(31696002)(83380400001)(508600001)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0YrbWRZaDlBbTZRWVp2NW96Z0VJRnNFUnJ3WUNlU1cwdVFqaW5JbzJUdStI?=
 =?utf-8?B?L1p5cUNnOEQwRWpneU5JZjBGYnVWSFU0NzZld0ZzbmwzZ0F4a0Y5STVwNEJk?=
 =?utf-8?B?WnlrYS9MTHlNcG4zUDNkQlZFSngrMUIvQ0RCSjdKNW9ZRWlUZlJheVhkNWZp?=
 =?utf-8?B?SXZlc05xVWJhT1Z1cERYTzM4aWV5blluQmVTMGZ6Qk5kK0UzTzJiMVpVU2ph?=
 =?utf-8?B?Y2JXZzV2WnN1NVVWRTFZTHFFcVVjc3Axa01Fam10WVVMQnR3UEdYM1BpbTZE?=
 =?utf-8?B?ZDRTZHFOZGUySllqd2hrZlpHSXdBSWdQUmY5bjZNZSt3MjluZnFZbE5qS1FR?=
 =?utf-8?B?NXh5ZWJJZWZWQ0t5YUxyakxobndXb2dreUkxM1FaSGNoZlNEVXg0NllUdU1n?=
 =?utf-8?B?M2kvZXRLZVIxL1AzNlVaQWI3OEJGYnRxSGNySHpjdDFTckJuQWFUQWVyekZ1?=
 =?utf-8?B?eU0yaVE2OHlFNTlqbitCaU9nUmU1SXljYlUvTWRSeFFacjBMUDg5Mk5RREZ3?=
 =?utf-8?B?a3hidUYrSG1udzB5VWkveXNjeURBcU1oeFJneFZNQlF4MUxyc3dMYXI1bThD?=
 =?utf-8?B?Y0F1NTlJWHAzTkZrODRzbUJuNW9hNDlQdzRBQitQTFVaNFFlak1TMzQrZlZi?=
 =?utf-8?B?cnVKUFp5bVdTTnhzMzlkakdsSkxiQkNhVEhMb2svUU9EYnVWUTVHd1BxYnZG?=
 =?utf-8?B?L09lLzBUY1JXYjBrb3IvK21XNzU0a0t5YTVULzhJRGo3dzVtWVp0WnArLzg0?=
 =?utf-8?B?dE9BdGVDRkVuaVVGR1pQckwxMWFTU21GYmlQcFk4SEpmeS9ieVdrYjY5bE5n?=
 =?utf-8?B?UVBoVlFSbWZXVVVnKzZMWWluVDBIdFZQL0tqWEduVEJNUndZQ1B1S2E0NmpE?=
 =?utf-8?B?UmZNRXhaekZkWlBoT25JVDh1dkpTZU40MHBXSVdGV2R1eEVXWHFPalVhT1RV?=
 =?utf-8?B?V092TXlCMy9leG1tVlJBQ1JVS2xTaStCWDZUcWRqL3p3dmc0ZlNXb1J1a0Jk?=
 =?utf-8?B?UVRoOWZESzBQV1JCdjFnZllTbmM3b0NQS1QxQktIWkFSK2ZXZDlaVVh4U1NJ?=
 =?utf-8?B?ZUgrLzJIak9IVEltV1JUMDVIQUd2TlhRbitmOVM1Z1pzbVJEWEVQOHRxTkpw?=
 =?utf-8?B?ckhKalNLVFQ4S0ZGQWNiRG9qbDdxYW5scUIrVjFxeW52bmtnbmZXV3ZxT0Ny?=
 =?utf-8?B?ZmpFUitFMGpzeEFrQklwR0lPakZJV3U3cGdLSGxoRTMvNm12bnhEc2w1Nk9u?=
 =?utf-8?B?eG1ySm9vOTNGamtwT1FFMVFVbVNJcTQxdStsZ1FTbHdMcXRld05YM2x2R2k5?=
 =?utf-8?B?T2pBeXprZDFCTkdQdEhoaVhYMFEzbUVadUdiR3BSMzZWNFptMGpaTmd4Y2Qv?=
 =?utf-8?B?OEdMMC9ndDhSKzdjVVppeFlIeUJFa2U4UytCTXdmTEhJc240S3NOTDIwLzlB?=
 =?utf-8?B?eEVoQWlGRlJXNG5HQWNHdXFpMElKUzFtV0RuRjZyeDZTSzRhS3RROWE1MkUr?=
 =?utf-8?B?cTRnZSsyMUVISjVUVkwwc0o4dTdFQXJSM0dWNFAxakQrMWQ4ZS9FdENPR1gr?=
 =?utf-8?B?V2tmVnAvMDg0YTNOOVRFaWxrK0N4RkVrREFkT21DM0RmcEJ4RXhYemw2R2Vr?=
 =?utf-8?B?MjBqZ3Yra0F0S1dFWVNPczh4ZnNPeDhUTktXNGdVL3BOKzRGbDZ5ZitTNTJM?=
 =?utf-8?B?Wmg0NkdIOEMzQ3gwbXgvc0VHTTVkempGc2ZVQW00ZGVveDVzOWNxRUZVcG5J?=
 =?utf-8?B?UG1RRytIWmxHdkpmSlNsM1hQcTYvWHY2LzJzekdjekNsdkpndGF4aG0xUVpj?=
 =?utf-8?B?aHluK044TTNQVVQ2bkNiU0VDc2x3Si84alljYSt4Vi9FUVArNXM2Wko5YlZR?=
 =?utf-8?B?YXJtSHJ3eDYwZDJDbTdKTXJvdklTNFI1TFlWbXpZQ0RJWFBsdmdiTWozUFBa?=
 =?utf-8?B?NWJaWWY3aUx1UHBYMG8rTncraGNxUUVlVkJ6cXk0Z3lWbUk2WGp6OTNaQ1Fx?=
 =?utf-8?B?N25KUTF0VnpWSWoySGhkdS8yNjFWbTN1TWxmSnpCNnozQkdsbFQyWjI4MmFm?=
 =?utf-8?B?ejhFK3U2Q2VDb3ZmTFd2MThmNU1sVGpOb3lVZkRtWFB0dGFRa2kzR2Npdkti?=
 =?utf-8?B?bjlIVEpZb1h6c253UmZCYzhsNzh5N0I5MTZSVnBXelZtWGdEQ1hqUk51RGgx?=
 =?utf-8?B?VlF1UUt1T2ZBM2NleE9TQlhrL0U1ck1PaVNOWU5saGVPMW9HcTJYcDlhejVq?=
 =?utf-8?Q?okD8GiJsa3e1LFWpFJqg6+K9l3cOeArStPqamfiE14=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c32c11-73b9-495b-3198-08d9f014e335
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 23:51:15.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMms+0P9aTCsJDwEjb13FFKVteSKQXtgZ4fHDVdmso+5qg7+Q6sif3wPz6wC3Wmpd5WA6PzpxuKxG2chZwBogQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2775
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/22 3:32 PM, Matthew Wilcox wrote:
> On Mon, Feb 14, 2022 at 03:09:09PM -0800, John Hubbard wrote:
>>> @@ -309,7 +288,10 @@ int invalidate_inode_page(struct page *page)
>>
>> It would be nice to retain some of the original comments. May I suggest
>> this (it has an additional paragraph) for an updated version of comments
>> above invalidate_inode_page():
>>
>> /*
>>   * Safely invalidate one page from its pagecache mapping.
>>   * It only drops clean, unused pages. The page must be locked.
>>   *
>>   * This function can be called at any time, and is not supposed to throw away
>>   * dirty pages.  But pages can be marked dirty at any time too, so use
>>   * remove_mapping(), which safely discards clean, unused pages.
>>   *
>>   * Returns 1 if the page is successfully invalidated, otherwise 0.
>>   */
> 
> By the end of this series, it becomes:
> 
> /**
>   * invalidate_inode_page() - Remove an unused page from the pagecache.
>   * @page: The page to remove.
>   *
>   * Safely invalidate one page from its pagecache mapping.
>   * It only drops clean, unused pages.
>   *
>   * Context: Page must be locked.
>   * Return: The number of pages successfully removed.
>   */

OK.

> 
>> Also, as long as you're there, a newline after the mapping declaration
>> would bring this routine into compliance with that convention.
> 
> Again, by the end, we're at:
> 
>          struct folio *folio = page_folio(page);
>          struct address_space *mapping = folio_mapping(folio);
> 
>          /* The page may have been truncated before it was locked */
>          if (!mapping)
>                  return 0;
>          return mapping_shrink_folio(mapping, folio);
> 

Also good.

>> hmmm, now I wonder why this isn't a boolean function. And I think the
>> reason is that it's quite old.
> 
> We could make this return a bool and have the one user that cares
> call folio_nr_pages().  I don't have a strong preference.

Neither do I. No need to add churn for that.


thanks,

-- 
John Hubbard
NVIDIA
