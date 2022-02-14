Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E954B5E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 00:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiBNXJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 18:09:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBNXJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:09:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749651AE714
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 15:09:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnHf3WNIZL9Dg9c8fwFJ3xQYSLTDA761dohNvxK4AmXYljsJuSKa0v+Cp3RRdV9VzXWLcxSGHSXyVee9vO7sVNu7FUccksnE/ZR6SjpvjqNWtpxcET1cNqotObmwy7chXRVEEI/79PpdhSWD5DxDfiMVi4pqIxnjjSLRp3jVsQBKvBFricvp0qEMq1WOF8VdNuhGUO6IGhRVpQjFVZ8CmpD0Rnz6j8dWFBi36bkm2PmVlf3X+UDj5WOmqzLm3COqTVfjpKjrNtv95+oTKaPUtrshve81U0AyhxMARzt5KIYJSRVZrroinafKjKBZt4roF5qePctRviIVo4qD+Jj6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHttrzvdOOkeUO0lKNUrFkOTeL6ev1SMvPBSUGlNN2Y=;
 b=ddhaBb6QBuBoIyIUFW1myNSNIrSGWTzL9v1vEmpAZhP4ArAk1NAmvXm0JNztPHsxmmOS/w1dT0jITnCR5eW27qOlApszOzqmc5hjNCNwIWtxOLNYPGHbjBDXjNj0Jq50JoWMGCFHm28G3XEqI6gzlh+tOKPwaVcPOFrNDtFcOQDQ8Z8DIoW44lG7KWFtIQEpbMvzxyiM3rdYym6jAdppvyT5ESflbKwcFvcdYya8gYSGXjm+O9YkrYmX5yLv2OuNz/STieVEi99evl9cYnhV/Wfk+nt0I3kkyrQY5nAv1hjlydvULvhuZTr+xuW/dT2zYsaCrBl7vz7aM1i6njCaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHttrzvdOOkeUO0lKNUrFkOTeL6ev1SMvPBSUGlNN2Y=;
 b=cfLB1I6RsIpCC3OTjfCA7cfhpULPtG/+3sFoykIM79j7pu9rjlaCw2FZyuMq2oF+u1ykFQNbFJtiKjQAQ3I8hQ5WYRk5tQeaQ7mHIPJULnyRTlzL1yNrmmxzBwxXp2iY1k87vIO+UM4vb5Wv8PugGdVTWPvhF+nGftSgxbuZeFLX0zdEXPaJA07Q96ItEcg9F/iT58RkFzdu0nJtaysundpDams7oTsxGgTaDo5cVpHLmQkV/ERtHVpHbeNHJWwHHi9ChA8yMrGXjgIQksftXkNTgceNeLY4yFiGkxbxzvpmsF2+rGNHRQ+l4vDSHbT6Fxge4WYk/hTAGnoUyZaMnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 23:09:13 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%5]) with mapi id 15.20.4975.014; Mon, 14 Feb 2022
 23:09:13 +0000
Message-ID: <f711b39b-aea9-b514-1483-76fb128a2319@nvidia.com>
Date:   Mon, 14 Feb 2022 15:09:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 02/10] mm/truncate: Inline invalidate_complete_page() into
 its one caller
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-3-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220214200017.3150590-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06c08c00-d9ac-4dbe-a126-08d9f00f0421
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2574390912693E29B4313ACAA8339@SN1PR12MB2574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTCp+akPTIhjmFyG3l9D6F3bAUlfnmyU4ggRR/wHEuq3oPmJRGjvB7DVzeR0ijCqeIv7Oh86C/MqzId7lnkH911JR4GqTxxw3PCjWKRD11k2apJ0uCvvXm9DrCWJoRG8crQxQbM3LThi8ZWHOKA9XiIA/2kDohAL079uQgcfGErDcEbf/3s2fR9ae1EYPdm0sBptpITDpm7kRotwUEMcXBI7Gh+YGVAmQpPomGRxaBPDJhx0tQFDN127uEV5yZoWbmeQnEgq7FvbS3B10Z6ChpAkJqVSvWdd4fZElus78uKGh4DFBzgBLVTEUPg4YuqeG5xoJ3LJ/K65AeHHpy5f/TrSGMugzgbmv+DeUscc0M79rwzgbY55Mi+ExFVGZWkuNIRy0vA0GaSC34EVPRo6gFRHvaI9hq8keHPIsx4cvSZgN7Uninthq2Vp9Sn3nNd5C6U0x53FQ6qj5YMdjwlpc/OKDscI/tw4wZ5FMkLbTKNXc0KT7IgcsVPwQ5a7FhwGZoAj1ighX/++3IKbdcN3tUwsqeKPTv3sPOm8TKiT3G8kSTMZA43rNKIqdi0nk4OBm4xdSsikS6hCZkbrWxRaO+Lor2yIUxrI8q+DlkzYMWFP/aZElzPCU8iXwEtufNzrQPjzS1tc/aBm94JkTCU4JNcpM37IFTfOdQXOfDoXNVUaO9OqBoBPMgJb+t1X8jq6yahOe169vq+cp10rIZzF0TAgrlPiSCxGsi5ZOhXo6h8TyJy4nWHY5ybzHjhq6bfj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(31696002)(6506007)(6666004)(38100700002)(8936002)(36756003)(86362001)(2616005)(83380400001)(6512007)(8676002)(26005)(5660300002)(2906002)(508600001)(6486002)(53546011)(186003)(316002)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2R3ekpRcGl2aStZRWZKNnZiTk1GaFJsbFBNRE5PSG1oM0t3eWVhWHdaOXRy?=
 =?utf-8?B?RjRYc00xUytmQndyeHlLb0ZIb3RSaXdIeGJoWmx0RWR4SXdEU3VlV0dXNkFD?=
 =?utf-8?B?b2JueURSaFYyMEJKYlJIbC9CNTd2Q0tJWUErdGs1anQyakYyZE1wcWtTc1JM?=
 =?utf-8?B?d1hKTkJlT1ZtWnh3SnE4Q2o5Uk9LT3BjRFI4djRnWWJDVDhmN0VEQjVUSUoy?=
 =?utf-8?B?L2NRRHpNV05DRkJBWUh3bkdrY3N0VGtPRWxsYXBLeXN4bEJlVWszNnBJZ2xI?=
 =?utf-8?B?NkV6MVFCUVB0SkdZcEtYcC9PekNYeU5sc1JFVUpTcTZYdnluWVZzZjd0QnFp?=
 =?utf-8?B?RDVBVzZ2OTR5K3duMEV2enVocWpYajBiTHhlNkRJdjY5clpBZ0xsSWJKYW9D?=
 =?utf-8?B?bDRuYjdXRXdlRHQ0VytBQllTekgyOEhhVUVsMEdWQm40cVVmK3l0Q05CYTI2?=
 =?utf-8?B?UVVCMFpmNDl3VlJBU1NYWTZvWUxldzM1RWNJYjVWVzQ0bzZjcjFTKzFHRDRV?=
 =?utf-8?B?Rng1d0VHejZqU2tOMHFJSFVoYWMzSWN4UFFJUzdPdStFbFZFMFhZQTltbTlT?=
 =?utf-8?B?ZXZjekROTVljMWpua21SYXR2NnUwQnVtaDZHRjFoY1RvT0lCL3gyQzcyZkYz?=
 =?utf-8?B?b2pvbkdaRktuM201MnNRVnF2WXNpbDYvbno4ajVOcjFPaXgzT2lKU2c4c0Vs?=
 =?utf-8?B?MER6WitFOS9wUGZJSEVkQy9wTHFDL0FReWJoNS8zbm9oS1phNjNqTVo0cDhj?=
 =?utf-8?B?Tmo0TUtsK1YrRWhBMnRGU0hSN05qVHRjSVZPUC8rOGx2YTFGYmpFbEt6RWlX?=
 =?utf-8?B?SlE3TXUwWWxBd21DUXk3RFFVL2UvZmh2T3hIM25SQm90ektPb01TSU9GYnNz?=
 =?utf-8?B?NTFUUzA3Vmlvbmh0TzlMS3ROamhtTC9FTXExeGFRRS9YTUQzSWFYQ3B5cUxK?=
 =?utf-8?B?dDJHcG1UcklMb1MrS3U1NDNjZ3BOaERqYWYzYUdnMk1IQmhRSldaaUd6RnU4?=
 =?utf-8?B?LzM4Q1hEbTNzMUxORXpBYkJPdHpxYmQvUUY1U3JEZFZPZktnZlFkcnJrNGkw?=
 =?utf-8?B?Z2o1V1RNclZDUS9kbUNoczdROGQyWGU5M2FsOFZycGZHRVN6UC8xQnNLREJT?=
 =?utf-8?B?cThONEU0Sk9TRTVPMzJWOGI3TGs3RndBc2U1WWZyeGRyMUpjSmJIRWd5RHI5?=
 =?utf-8?B?eVkySEhISGNGakNTZDF0eFB6S0x4ZVl5QzhPMS9YNTRrRGY5MVY3R2VOUms2?=
 =?utf-8?B?aGhBK0JlOWdxdW4zNjVHZTQ1TTIvWTBzVk9nK01pQkRkNmZWbDJXV09zbnlY?=
 =?utf-8?B?V2JGWEJISG1tMS84ZndPTW1tc1pLWUdjSVJ4R2VLaDJ1cy83bTVtYXp0dWxo?=
 =?utf-8?B?Z00yWkR4NTJiRmZGODFydmszRzd3VGF0ZGdHUm12TFVjcE11M0xqT29YSDV0?=
 =?utf-8?B?cFVrbVBCcVpseTg2V2xuRFdHcFBIQkxKeEdHU3FQMGJ5SkQwcXBLUDU5Q214?=
 =?utf-8?B?ZmRtVWJ1Z2VkdjAvcksxUmhKMmVwWktwQysxZDNMeElEb1d5S00rem5hc1ZM?=
 =?utf-8?B?cWxVRTQwZ2dMc1VncHhIMG9mYXpvN0RyNnFVaHhPVS9LZ01TRnVVZ1QxMGUz?=
 =?utf-8?B?dGFDR2xQUlYxOHFkNzhiaEFFZlVUbysxRG1yRUlXVVQrOHhGVXBXQ3FBK0lu?=
 =?utf-8?B?Yy80UkI0Si9STllpKzBzd1FnQVBiQWgrUk5BSjlrNTNGVXZNWG94TWtBUnUz?=
 =?utf-8?B?ZGhGWUhoVFEzcUdKa0IyWUl4WHBYWGtmckNRdzEyeWdWUUpHby94alFhTUtr?=
 =?utf-8?B?a1EvTFdKQnQ1RDJacEN4M1dHenlHY3A1UzZGeFd3R3AvV0g3RyswbS9Ba1JY?=
 =?utf-8?B?cCtacnhmZ01zSkFEVXRmSVNOUGQwRDN1WURhd3N0TytCTWVZcDVwWERTYWwx?=
 =?utf-8?B?cmlEMjlRb3Z5YjBqQ2sybiszVEJ0SEg3U0RScFZuTiswZmk3T2RrVnhRRkhX?=
 =?utf-8?B?TFdpQ2l0Qk1zbVVnS05oSnZxMHBOekJHRmY0ZURCZjErT2wvN3lIbHZzSTg1?=
 =?utf-8?B?K2tyR0R1c2d0RUFERTRPMWY5N1NwVVVoeW5vK2c0Z3kyN2ZGZGw3eHRXY0hq?=
 =?utf-8?B?Y29Ib1VsUFRiWlhSeW5aK0JPek9pWnFjQW5NS2JtUVpPNzdWaTBTWGxLcGty?=
 =?utf-8?Q?8BV9OJUf4yy/FDfmU+jF5uU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c08c00-d9ac-4dbe-a126-08d9f00f0421
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 23:09:13.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb7YfNv250cGZ6u2r22YbMsWYEieeej2qzZgp/k9b67I+dzJjpA5rd4CZEE0Hpg2eHGRd+dr9EVR8FliETXLXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
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

On 2/14/22 12:00, Matthew Wilcox (Oracle) wrote:
> invalidate_inode_page() is the only caller of invalidate_complete_page()
> and inlining it reveals that the first check is unnecessary (because we
> hold the page locked, and we just retrieved the mapping from the page).

I just noticed this yesterday, when reviewing Rik's page poisoning fix.
I had a patch for it squirreled away, but I missed the point about
removing that extraneous mapping check. Glad you spotted it.

...
> @@ -309,7 +288,10 @@ int invalidate_inode_page(struct page *page)

It would be nice to retain some of the original comments. May I suggest
this (it has an additional paragraph) for an updated version of comments
above invalidate_inode_page():

/*
  * Safely invalidate one page from its pagecache mapping.
  * It only drops clean, unused pages. The page must be locked.
  *
  * This function can be called at any time, and is not supposed to throw away
  * dirty pages.  But pages can be marked dirty at any time too, so use
  * remove_mapping(), which safely discards clean, unused pages.
  *
  * Returns 1 if the page is successfully invalidated, otherwise 0.
  */


Also, as long as you're there, a newline after the mapping declaration
would bring this routine into compliance with that convention.

hmmm, now I wonder why this isn't a boolean function. And I think the
reason is that it's quite old.

Either way, looks good:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>   		return 0;
>   	if (page_mapped(page))
>   		return 0;
> -	return invalidate_complete_page(mapping, page);
> +	if (page_has_private(page) && !try_to_release_page(page, 0))
> +		return 0;
> +
> +	return remove_mapping(mapping, page);
>   }
>   
>   /**
> @@ -584,7 +566,7 @@ void invalidate_mapping_pagevec(struct address_space *mapping,
>   }
>   
>   /*
> - * This is like invalidate_complete_page(), except it ignores the page's
> + * This is like invalidate_inode_page(), except it ignores the page's
>    * refcount.  We do this because invalidate_inode_pages2() needs stronger
>    * invalidation guarantees, and cannot afford to leave pages behind because
>    * shrink_page_list() has a temp ref on them, or because they're transiently

