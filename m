Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A91B4E5046
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbiCWK1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 06:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbiCWK1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:27:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94C07667F;
        Wed, 23 Mar 2022 03:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmEj9e8mnIRRJk0ymSIkBobKCaPY7qohuT7eIOqeErL+/rBM65nHnaneXJz4YapB80wd5JtCgmG3ZmGTaKhgQhCQrsU0850MfUewapsOKmGEVUrTC2P+72+dWsePoVKsc/x+ULng2ckR5mIjNw4gYr0xakB9HoKUbV7uhXnPas5XIauxCDufBRJZZleAPgQMnbQf8gxITMSFBRRnupBHDAwz2Dn87lDqJ5ypaB6MlB++maHwjjpiR8la20qte6NsFTtecjnZuDAsfrutOgOFDH5XMgb9gTtpvaVaCZ93LM99eXaUTdelcsuvh/7qtBUMVBowmV4+aNC1z6TNmTw5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL6qEr3kkwVL8PvVT7VDgNdFwzsdVBjCpfleurkPkj4=;
 b=QECT1XkMjAlh24Yxbo5+V1Zdx3mdAX5X1UvpWb5EkpyphC7UNGXCBfkDkp3cttoi8H379ABUma4leMcwTmpkZMKLvtNPpIJ/9Uravp8KTxslF2hIJYeg7/XDSKObC6sQrb2r/QphqnvO5dmBuyWVgS1QhIGs57UbYIvsDXzOwkFh/gt7AwR0R1+OpfNL/bR+e1tcNVPXrGeSwA0VV8M1RA4QYFCzvEwE5PIXr/q0DhF33aGHebAmQgJV3bKyPlYF+nm+VLWTNRCaWiuHKqBg9eT2uWXKph2rfH+8wCRVjPGfGfdWknFOuxFrigmbPs4ASUA1VJ88DRHfmpFEWICzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL6qEr3kkwVL8PvVT7VDgNdFwzsdVBjCpfleurkPkj4=;
 b=WnDH8omlxOSMMf6nG+Z9hS0Tr2AUbcEGgi9w6zb/bA26VDjGaUTtG1qwx8ZYnUZUksnbf9cE0/MaU5FipFMOI131xyj3udAgVFbGSgeRZv1/y2hyMg2kFAaKuKsBcEABxXd02ZLE9yxWEOoAfULTMfxUcan9SmRaQ9f9jzy7HYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by PH0PR19MB4858.namprd19.prod.outlook.com (2603:10b6:510:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 10:26:18 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::a012:79d3:ea4e:b406]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::a012:79d3:ea4e:b406%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 10:26:18 +0000
Message-ID: <d0e2573a-7736-bb3e-9f6a-5fa25e6d31a2@ddn.com>
Date:   Wed, 23 Mar 2022 11:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] getvalues(2) prototype
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <YjrJWf+XMnWVd6K0@kroah.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <YjrJWf+XMnWVd6K0@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0078.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::18) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2178d83-9748-41e3-589c-08da0cb7913b
X-MS-TrafficTypeDiagnostic: PH0PR19MB4858:EE_
X-Microsoft-Antispam-PRVS: <PH0PR19MB4858CB28688022F2B29D1CAFB5189@PH0PR19MB4858.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iRAEQQYYoARXL8iejHHG5+oxusaUeWXJ6HzhhBIl/ttOeV7dNbuvItnVtvJzUr08oP2m+DrPvOazZWasaSLJ/BQi+Ol4G7fOo/y+EngY4adh5HZ4DOoA/+VjuEXfrBNCT9G12dBAS3//d5JWmZeRoskgl7Kf0Z98SY9YUI1af2dm5662QQ4GIJwlaQJRwjluTrlnLRj+Dmctk5PBjpZ0mCDxBnCALUhp8phUQetMlDOSeu2aN4+bd8YZG5rjz3FWssby54xDeOd+GI+P1qRm8Oz5peMGuW7A2MAyLNSPAqg283FNJRU2q0NE6fkjICYpYIauMO3kIVnUZwGTnZRpX3+10Fq+O1CUezdxuTqqsPCYkyTtjkjBQPe4yozBSqRrkceIF/w7syr81ujE2kHa5mFwmpmVSBpkfoRpUSrNh0g0DoYiAxxGDkxb/2zUi/cR5QCXl6g1qaQWKJYq1TVvASC2yyMjqg5ImAaYjeizas5eRfaeB7pgSXpbO3N0l2xZUIhmipSeI6PWkedtRnQJzTibU42gTzsTTlBGpp8HV11tS4TL0SVlkT+QAFo+pRI8wvmvTq2911wJI4CNY0QdHdM1ODLuV/btjcAJ2P9uDTLSlATpSiVDyky8wk4+vbZTzLY9mYw2njei/FBVWJ5NFmqIdPS5qjvDcTWxkmOKMP2pHPPrWiq6SqJFLR4a2SyihQDFuKgdKk4ygAnWq37+G/Gl27duY6fV+/3W8IPtwwu4rzOQSpo6dw/TbWwH+l8jg8BUiWKWLOG3esdksh/Pou3zdJ2/IupoBDB/kXNY0T6CIRWPomMbwYUSYxKiJ42
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(2616005)(4326008)(8676002)(316002)(8936002)(5660300002)(66556008)(66476007)(36756003)(31696002)(86362001)(66946007)(7416002)(53546011)(6666004)(54906003)(6506007)(2906002)(186003)(6512007)(508600001)(31686004)(110136005)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFUbm1wOC9PZnorOTM5ellEZlFMZW44enpDbWFSY2c0dGcxU25tQU44eVJM?=
 =?utf-8?B?cWd3Z2tsVUdlOWI5ZUpvQ2N5MFpCby9BdG12anB4SkUrQVJTd1g3OUdGMVZ5?=
 =?utf-8?B?M25TNEZGWml6QVE1L01vcjUwNnhiN01sSmc1YWFBRGtabHZrdk1yQW1hd3pD?=
 =?utf-8?B?UExWaThyanRaU3hFUmZITE9BcDlheHZaRmlxR1lwSVFZUXRwSnRBQTVTeXRZ?=
 =?utf-8?B?dkVjaWZPUWdoSHpmTGptYXp6aDNhL1dBV2dORExJSGltU0tadHpHeXR1WjZi?=
 =?utf-8?B?dEZGenBZN0FXR1VVUEQvUEt4Y0s2MUNVVm9OTis0RWZibWgzOXhoLzNPcWRS?=
 =?utf-8?B?NW5MS2VMRjBZSXM4ajMxZkplN2xCcE83QzFaMjFlUk9Ud1NNdjJ6WFhyS0FI?=
 =?utf-8?B?VkhDTHNnam5xYmlMSHpjZ1FsSENUUXozWXFwVWFvRUxQdG9Ca0JmSU1sNlM3?=
 =?utf-8?B?QVJHWE1ubUtObndSZFRsMmtkMlJXM1NKbzExdUNxdGdUblB5WlhCSXdRaStl?=
 =?utf-8?B?Q1pFT1pPWjVrRjVHckdZcnNYQ0pUQXhJdHVQekJnb3R6QzhvSG9YWExwSEpJ?=
 =?utf-8?B?anRlUTViNDBDOTFzbC9BWlNXWkpPVnlienZjNmJHaFdnRFBQUjE3VUFjU3N6?=
 =?utf-8?B?aEJhaWVTYWp1VXNWRkZYb3VZaWVsZ3F1R05xc0NIU2FTSGE5S0lsZmU4d2Ro?=
 =?utf-8?B?ZDhOakw5NStObWY5ZzBQTXZLUGZSUnVxK0lYeWx6cGNXeU5hbGtnM01qaVkv?=
 =?utf-8?B?T2xtY3lYN1NIR0pxVGo1WHdvUzBDRnI3dDRRMVNMZW9Kd1ZwZCtCeVJPOXA0?=
 =?utf-8?B?bUxYd0hsRk9aM2grem9VcE90WHhVdDNXZU1keHpOaFlaUnJLY0syYmRLcEsx?=
 =?utf-8?B?cGYyVGZsdEN0cHFhL2NwbGMwYzM0M0FlOXhvZFc4Vm5xaXFFSnkxUHl0Umg3?=
 =?utf-8?B?T2NpZk54ZUlvODlJbUFLcjVsTG5HWGRKUFpTQ21GUVpmTkkzZFlHSS9QQXFS?=
 =?utf-8?B?NXoyN296SUIxVkNDVTR0VGNrMnZ0Z2xkMHpxU05GNURaSE5nTVFIVHFXZFVK?=
 =?utf-8?B?bVhrUi94dm4yejJBS29jMjhCNmlkbWNFemMwU1dlc3krME5MaGJjR2xSTThH?=
 =?utf-8?B?RXZiRW9YMGlMbmF1V2R5M0JEcUZtZVFVWUJnQXNENTNBMko2QkZTbE9GSXFU?=
 =?utf-8?B?bHJ5Ym04amt0K3pkaUZnc2NlZEdva0h6U3lia3hJWENDUmQ4WTl0SXJuLzBi?=
 =?utf-8?B?YjZlc3hLaTVXb3dIY0hjOHJTcGM2Mit0VENXUVdrNmdFVGhTR0ZoNlpGMGhH?=
 =?utf-8?B?aVRQb0drekp2NUluYzNtZmVySFFSaUhOZWNySFdpdDNSWEVYbnZtejV4d0pO?=
 =?utf-8?B?MmNHSk9BSndUVGpKSFNGQVNyS1FDbWFSRlJlYlpEZWVIcW9Tc0hNamI0bTBU?=
 =?utf-8?B?T1B0dEc5SkZRdWE3aWRidlk0VXBQK0FZbHE4VG1QUUFteGUrcFdvSHE1bTBu?=
 =?utf-8?B?ZUhFVFk3bUF1MWVrSG5zRnBMWUdHNDBzcUw1RnN6bU9GQ0xldW52M2hmTkJQ?=
 =?utf-8?B?REFpTnEyQTNuckpOeHhCMVo3ckRPMmthUHgxZXFWcXUvaHVCb25JdWR3R0JS?=
 =?utf-8?B?RVhOYjFBNkxEODVGNXI2WEl6L0lSdTloZXN1Vlo1YjduTkErMVluTE9TVW9v?=
 =?utf-8?B?djFTNHloR0R2TnUzd3FyOW9VRitWb2NBUCs2TmZDZldMMm9qSDlMc1UzUU5P?=
 =?utf-8?B?NmZDN3JzV1dENzhLbTJTbDdIbHhERm5yUU5obDl5TjhzNWorQk5tWTk1SmV3?=
 =?utf-8?B?ZE1PdXJtNFJOeC9YZDhCU1BHU3ZrbDNOK1pndDVlamZPN1YxdG0yRlNucHl0?=
 =?utf-8?B?ZmZzQ3BwYm5ZVXFYcXd0K1pUNHdxWHBjb0lnL0FnTGxTd3J2UEIvT2g1Qksz?=
 =?utf-8?B?cjJPLzJXTjN1NXV3OE9YdFhxOGJ2cDhROFBsZHpHZ05UbDdLSjRGNFNUQkQx?=
 =?utf-8?B?eXd6TGw5Y1RUaU5lS2p5ak1nN0E3QXZoQ3V6MnJrQWpJdjVrME1IZ2d5enNP?=
 =?utf-8?Q?pXeK+a?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2178d83-9748-41e3-589c-08da0cb7913b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 10:26:18.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DI7E6ZETlwtHxPYV9Qj5DTg8CF9uLi/wocBkv2851btLnOdRD/G0EDxqAqchS96F9KEoRfpy0CDP7XY+2FkAHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/22 08:16, Greg KH wrote:
> On Tue, Mar 22, 2022 at 08:27:12PM +0100, Miklos Szeredi wrote:
>> Add a new userspace API that allows getting multiple short values in a
>> single syscall.
>>
>> This would be useful for the following reasons:
>>
>> - Calling open/read/close for many small files is inefficient.  E.g. on my
>>    desktop invoking lsof(1) results in ~60k open + read + close calls under
>>    /proc and 90% of those are 128 bytes or less.
> 
> As I found out in testing readfile():
> 	https://lore.kernel.org/r/20200704140250.423345-1-gregkh@linuxfoundation.org
> 
> microbenchmarks do show a tiny improvement in doing something like this,
> but that's not a real-world application.
> 
> Do you have anything real that can use this that shows a speedup?

Add in network file systems. Demonstrating that this is useful locally 
and with micro benchmarks - yeah, helps a bit to make it locally faster. 
But the real case is when thousands of clients are handled by a few 
network servers. Even reducing wire latency for a single client would 
make a difference here.

There is a bit of chicken-egg problem - it is a bit of work to add to 
file systems like NFS (or others that are not the kernel), but the work 
won't be made there before there is no syscall for it. To demonstrate it 
on NFS one also needs a an official protocol change first. And then 
applications also need to support that new syscall first.
I had a hard time explaining weather physicist back in 2009 that it is 
not a good idea to have millions of 512B files on  Lustre. With recent 
AI workload this gets even worse.

This is the same issue in fact with the fuse patches we are creating 
(https://lwn.net/Articles/888877/). Miklos asked for benchmark numbers - 
we can only demonstrate slight effects locally, but out goal is in fact 
to reduce network latencies and server load.

- Bernd
