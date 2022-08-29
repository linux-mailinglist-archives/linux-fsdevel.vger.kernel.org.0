Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5195A5495
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiH2Td1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Td0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:33:26 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C280B79;
        Mon, 29 Aug 2022 12:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI7ZuZruuT1d4/A5KGcYTsCNmlIlHfBGjfRpoByd5SORoEQEsrKO1aQjbJ/lE79wrxOh4B3BF/eNFiWgomB41uflWV8uGByARhrB/ukcqRDNVTkENqC5ud6lPLJ+m7Hm0XctgRe9JoXm0NWjpY99qeKwncha2q4gKC4ECWUi54uoR2AqPVpCKXxfyIHVVMobEWzb6rsSCnatJZrgM65CEvJz2cMRsLrc010XYYGwznVtmH5HuI+selciUI9Q2LqJkA9xrSJ1CMLHAHyvST7qbmTdnRCWkKYV4HnaT74XjQH8bwSDJsRZrLhebQPsbsg/OTgoqCG6FB3muKPx/7KnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l48slpfryBfxnkJVXNMwaYDBp6ehDy7EB6lPEPa8hE=;
 b=iEw5x7w1oouOuhXiNd6QEaj5BedQh6XQ2nduz4VjsstWIBL9m3F/kcKIVBD/XmL8Lr6lHGb/xxHXqutHuB7jN14KgTtzG1Oy878ydCQUTTfT65PjG4+KfzgZjkW4WdTnPXavBc8PKPjt93WbREpBZZJYIHkhqFDXzrwkBXQi+FJ29ZScxaI+lXR2QvlW4pb2bnj7G9NUWOxOg37iAXDxqfbxc/tJSDsypfghvBYzzT6E8DeTCBsCj/gc2XeFb0pdFqNh3EaDUdTuo+GmSRtqSViR/YgktWtDADpdaTzUzmOh9eqb/73WV1aCzisVoUZO8yhnA9SzVWfbju7V3TN19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l48slpfryBfxnkJVXNMwaYDBp6ehDy7EB6lPEPa8hE=;
 b=TonKaWt8ku7R4Fcrq0JDy6LQarD7UyxcMNhpOdweg8fVNB1qVmpTGHq5Z+1jVFOGzpw/uxEhQUOCeCzTy6SxkTnWNUL6s7Z2IFTLgqBCsskVxwXCX31E7tdxveTqdcX4sCgGv3lnGAup1DLqQO+rgwXVH6OLVt6ynXcwUVBKUs2xJT3uW+cMN3SeHeaI93kJcD5K/tLg0zsVSe/IVOH1XZGMaeR5KHs/ln92mR27XGFOUTiLcWBwjGAP6WG5uClXuSJRN2DQ2S0S3AOznA/XRIeKhhLwg0EON01ZPk4l5goSRFjRuWhTU9lRqy7aOO+6MGLXwerI9S9tGQWXVifUKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 29 Aug
 2022 19:33:17 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 19:33:17 +0000
Message-ID: <a47eef63-0f29-2185-f044-854ffaefae9c@nvidia.com>
Date:   Mon, 29 Aug 2022 12:33:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/6] mm/gup: introduce pin_user_page()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-2-jhubbard@nvidia.com>
 <10a9d33a-58a3-10b3-690b-53100d4e5440@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <10a9d33a-58a3-10b3-690b-53100d4e5440@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce52a157-6ec0-4a68-2205-08da89f5528a
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDKMqwD8sSjXwdzJgeDtE3haNwg2nuxWBfYEaSvYY2yS7LudABXyOWwT7T3mFVZMWFJ9PJL+9j+P2FawDDK7l1sSI3ODGNRiOriIHpFc9A//LmNa5jyPRPSZa55katAACUKYsNDH50FCvSLrQit2lq7jozO0PW04TZJOJLsgRmEHhJ0hYO+U0bNbUWfDuWl5SalAjqpxMea2MFUUD3vnfW6zXCht8GOIC0KTEKHXiK3VYs4YuPm9uD8zR3IljCTHgwsiWi3Nd5//lQ/lUgsT3fz0U3notqZvxfNuJJGRsKjz5qd1dixHM+DXDUupvq1iPeXbJ+5/WFJs7PEDU1JXYcAjI0KHIEKQbliyWdt/IGSt0wjKoj2XtyQjknXbb22WqejBfJ0vn6oT1fch1vlx2R2oYloMeK35c4hgtgzK46D2LB4sDleDpKnyiWkWhyxwqbdA0z8oR0SGznjtSEXwBJREGgq6yB3C4+okP8JHt+kyYewImfZ+vIMxyd3JWio60g708tBleVLpIFb6bjB0/TusFB+3ksxdpMgb8vPJDwD6OFu2i7uqj3NkVuibgwpUyCLIfp3Ryo7cX3jO/m1Sqnn5KiEpVuDmgEO+/qf2NR24plDfZL1Tu33u337yjaOBmP5E1mD9FZQT33qqN/ZBqBhUfqTwW9mOq0Upfk3zAnATMXfEULSHm21lb266NrQKS3sMwCuDlKnFXj39R3NVynmKag3fu9Ty5vIL1dwFQIOvIQkH+rl2QaWbjnd9B9/c9h4beYZZ9MV0gMVEwbbqIvqHO8KKyzQ/NptEs4OjzzYOieAa2fxrga2Dq9FRq3wPjiELJuS6mLsYZjhLrRgSLQI3dfFz0Py9XIuDLseoZcFUsj4vRtEESc/35EdSOyby
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(186003)(38100700002)(31696002)(53546011)(2616005)(5660300002)(54906003)(316002)(6506007)(2906002)(966005)(110136005)(7416002)(6666004)(66476007)(478600001)(8936002)(41300700001)(66556008)(86362001)(36756003)(4326008)(66946007)(6486002)(31686004)(6512007)(8676002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUp2VG5iazVxMldMOVhKYWJSVjI3MUsvNWlYTGZJUW5nN1crNytPRFp2Z1Nv?=
 =?utf-8?B?V0VWZWZTNmNycFVIVkZHK3UwUzhVd01RVlptWEUyNW1FVTFOSU1lUGlBWWNr?=
 =?utf-8?B?SU1CZDFDY1A4b3duTG5MWHFpRHNBZFdGTG5KMGhiSGh4VFpLcm5iTnZrZWZi?=
 =?utf-8?B?OWNERWIwUkdxR3Q1dXFiS25Fc1Jsb3VMZm90dnp5RGplY1duNUM1bU1sMDdG?=
 =?utf-8?B?aFFiTDB0Z29BTW1MN3JPRGI3MUVqL3cwWWl4VGRQUk5lMmRqbisyVloyNFQw?=
 =?utf-8?B?SlUwUzllalo3TUF0a0x0UUptcjBSMitOYVBJRmkwcUh6bno1eUgrTk83cE5Y?=
 =?utf-8?B?NTVYTGNuUFVENXBhc3dFSnhYL2ZpZ2cxSGl1Z2YwZnJacTU1WlA0UHpGZ0hH?=
 =?utf-8?B?bzJ3dnc2YkN1TDNRQno4bDZVd0pIVGZiV0YrandxczdyR2hIZjlFbnNBc2VZ?=
 =?utf-8?B?N3Y1d1hWZGV6WHNQR25YMFNlbm1pZW03M1A5dHZDUmFjRFNIY1NnYnVZbDR1?=
 =?utf-8?B?cTQ4d0xQZXIwUGZIMC9RWUp4SWdOcTl4ZEZQdGJ3dks5V2pGOHlMb1BrZDJx?=
 =?utf-8?B?MVN4bnpiRFNSWWd2d0VoZ0xDNXJiZi9wVlNDQlUwZzIvV0s2cjh3QjU5WmEz?=
 =?utf-8?B?TUtyeWdLVlpOai9mTkVyamQ4RU9aSUFGczdzWFF6NEYvcHdGWFlvMTRYRmtq?=
 =?utf-8?B?TWd1VnFTTUtFQzJZa0hGQi80ZGRGYTJNWkdzcjFCUnNOd3dMQzNJUkpCcHE5?=
 =?utf-8?B?aFNyYjQ3M0JBZFd0OFZuTnNqNS9yQkpLL2lhdDlTcTJpT1dzSTQrSE9uMGZx?=
 =?utf-8?B?ZlVpUGFUUm8vZXY1a2hvT1lyU2pqL0M5NUVCVXR1QmxwRm5RZzc2VFNKWWJy?=
 =?utf-8?B?aUFqZTVoTnZST0NFWkU4UVNTYm04ckl0bjA0MEtSR1dDbFh3YlZrdzdDa1NB?=
 =?utf-8?B?cEJvRTlscWpnYWZ4TFVqZHdDVytpRHBpT05GSXRZWmRjcFJVYnJ6Rnh3MlBi?=
 =?utf-8?B?Y0FNZkdPWmMyTnlVbHdSU1I3QjNDOHN3S2ZMWGVXNTdVZVl1cXc4UC94UC8z?=
 =?utf-8?B?ZUk1dVQrdFNaSnlWSlI0S0xGN2phR2tUYWNDbTVXTWxUaW1NdzNyM2x0RXpV?=
 =?utf-8?B?WlZiL3FHb21nQXJJRjdwdlJWZ0ljYTRQWm1hcVV6OFhJM0F5dVk1cXRLY3kr?=
 =?utf-8?B?NC9YTXdaRldlTGpBQTRpZEdXUFhHbkNnTXdwVzNEQU14OFJEVXBNcUJnd0dl?=
 =?utf-8?B?djFMTlM3c0wwd1o0d0N0OHVJLzZobVBoV2QwUkhvQ3RlZXBZUDVCRzVoN2JX?=
 =?utf-8?B?bng2TnM4akFBODVTdWx6UzZmMHZWZ1pOY1FaK0V5RTJMdG1JblNTU292N1Qw?=
 =?utf-8?B?V1owSkt2T1kwOUg5ZUdHVEhJZmlqdUNRL1EvK0NkZkN2b1c1ZGdTc2tZOEpZ?=
 =?utf-8?B?cENlNFpxeXpndDBGYjBvelFtVHUyMXJIOHFiTTM0ZzBTZm9VTzhFeGxNaUJm?=
 =?utf-8?B?eWJIcmhvNm93ak5qZFNIZmtNWkV6eDdlZ2NhWU5XL0RwU0lGOHhyWmZYOWJ4?=
 =?utf-8?B?SWM3eFQ2dVd2YXdsaUFTZkNZYzBGKzZ2eEJKdXN3bndlUUtUeStQVGpvL3JX?=
 =?utf-8?B?WWtqSmRnUXNuOWZsSEdEZTNaakNEdy9IN0FrRUlvV0FYS2VDNGMrWXVrU1dP?=
 =?utf-8?B?QldGeVNQT2NMWUx2cW14S2wrTGl4cENCa2xLcFZwdUNvR1MxSERnTTNaVjZl?=
 =?utf-8?B?WFlpZExTOVRvTndNSHVTcmtqR1hTU3c5M0RyUExXRDFPQkFzS1ZyZ3hSeUg1?=
 =?utf-8?B?NnVHMEs3T1YxdnQvSjR6WmJiWUk0bFBxQWlRaGRmMDRtN2xWVW1JT1IxSWpE?=
 =?utf-8?B?ODRuZDJPcmp6Y1hlVUpiRWRsTVdJaWtmbVFlYklNOE5wQUJGcFZCb3U1UGcv?=
 =?utf-8?B?anBYM21MUVpmVkV5dGloNFlMZ1Byc1QycCtKL0xOTmZxbHA0UHhaQzBiamM4?=
 =?utf-8?B?WFY5ekQ5VlpFR3RrYjlQQ1lYN1UwNzFhTWo2YXJrVmFaN1MwZWdFMEdIb3VB?=
 =?utf-8?B?aVBncS84ZXlXRFQ5YzFsdVFmdzZnaVBPRTJadmtGUHJoMVo5WWhjOTY3MENM?=
 =?utf-8?Q?gPbx0XrjZxLJh3LuS+gxwKoCR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce52a157-6ec0-4a68-2205-08da89f5528a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 19:33:17.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxtor7i1vUuGYzuyP9yaSemq09fdRJuCZs2h4n3x0t7UbXmyVvrcGhg9rTwMyTwwmGqf30rUxDaFhB5DJgacBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/29/22 05:07, David Hildenbrand wrote:
>> +/**
>> + * pin_user_page() - apply a FOLL_PIN reference to a page
>> + *
>> + * @page: the page to be pinned.
>> + *
>> + * This is similar to get_user_pages(), except that the page's refcount is
>> + * elevated using FOLL_PIN, instead of FOLL_GET.

Actually, my commit log has a more useful documentation of this routine,
and given the questions below, I think I'll change to that:

 * pin_user_page() is an externally-usable version of try_grab_page(), but with
 * semantics that match get_page(), so that it can act as a drop-in replacement
 * for get_page().
 *
 * pin_user_page() elevates a page's refcount using FOLL_PIN rules. This means
 * that the caller must release the page via unpin_user_page().


>> + *
>> + * IMPORTANT: The caller must release the page via unpin_user_page().
>> + *
>> + */
>> +void pin_user_page(struct page *page)
>> +{
>> +	struct folio *folio = page_folio(page);
>> +
>> +	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
>> +
> 
> We should warn if the page is anon and !exclusive.

That would be sort of OK, because pin_user_page() is being created
specifically for file system (O_DIRECT cases) use, and so the pages
should mostly be file-backed, rather than anon. Although I'm a little
vague about whether all of these iov_iter cases are really always
file-backed pages, especially for cases such as splice(2) to an
O_DIRECT-opened file, that Al Viro mentioned [1].

Can you walk me through the reasoning for why we need to keep out
anon shared pages? 

> 
> I assume the intend is to use pin_user_page() only to duplicate pins, right?
> 

Well, yes or no, depending on your use of the term "pin":

pin_user_page() is used on a page that already has a refcount >= 1 (so
no worries about speculative pinning should apply here), but the page
does not necessarily have any FOLL_PIN's applied to it yet (so it's not
"pinned" in the FOLL_PIN sense).


[1] https://lore.kernel.org/all/Ywq5VrSrY341UVpL@ZenIV/


thanks,

-- 
John Hubbard
NVIDIA
