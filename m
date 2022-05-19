Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC86952DE90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbiESUoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 16:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiESUoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 16:44:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F87A815
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 13:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKPQrajki1WRgndqPFurkC0AhxTPt8Zf5XZj98bnEjqit6pakequSEZwzEH2ABG6KHWCjbYmfpN1bGWaRbyypAPdkKRufV6TbcTKOMpgDGZw5DrdrLQetAAXa+opXJTZY4olpBlASLIKFb9i8JWHHgL9CebxLqS0QlARA8hWb/u7UPb6o4JrJUcR0a51zNs41vdl74Hi/Popwvt39ky5Ul6wFJTWTPCjwYnZXlUfMKH/BofS6oXKXzR56M7HZ75TJITU5uU5fu20xkql/5V6gXm02sZecxOnDtVX4dnJMrLr+arMoOHK2nr3ntElUo4PnRIyWUSxESSgJIYQYzVYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhr4My60syRm+/x6bgYSjlePPlHAAxHw5A0z1Q6DnlA=;
 b=iBxRXR42tHndHaF2KWy06MbRXhbArmZm2QINyOkX6xaiay9gFOelo93Wudj53r/V68EhDHo+h8cVMgluLKtVpFIoxQp+crngqbIRT2m6jfFO/Pp1+oFY6K2fCr+tRCkqojB04RWA58QTaxH96JFo1hlQ4egvVnpv7CW2W5C+HKrw20RsOuIWXl6hRoVVaN+W+er+9I8unhaMO3Guidkknya/Smh1xAqwXSUxc7+09TA3U4iEiequfVYLc2JSXce1BcFrqfJtbvgh14DdYu1GuLkGXvGYxTuC9v/OX5Qq3zg5fn7jrROHiufg8JV8/SBQBVbNCfPTnhGTFvOI4auNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhr4My60syRm+/x6bgYSjlePPlHAAxHw5A0z1Q6DnlA=;
 b=CF0+9AR296x2VTyRLTj7IrBt4OYACEoCLPlMTIpu4THhP8dJLeT+B6CnH/CsbOx1gMM8weQkyYYYPFl7nO8a3Em8OFtbynu2kw0trZrlvVM73QnSvCE43yE0CM0aopRPPVlA9ErEXbo4/Iy4iwn657IlAycZHz8JARLsC30OHP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MN2PR19MB3919.namprd19.prod.outlook.com (2603:10b6:208:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 20:43:59 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a%7]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 20:43:59 +0000
Message-ID: <016ca19d-41b8-a69f-42f1-1805a40fd611@ddn.com>
Date:   Thu, 19 May 2022 22:43:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] vfs: allow ->atomic_open() on positive
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dharmendra Singh <dharamhans87@gmail.com>
References: <YoZXro9PoYAPUeh5@miu.piliscsaba.redhat.com>
 <Yoaj7jhLpp34K9+v@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <Yoaj7jhLpp34K9+v@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0133.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::25) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986b3f05-5fef-43f1-e367-08da39d84cc0
X-MS-TrafficTypeDiagnostic: MN2PR19MB3919:EE_
X-Microsoft-Antispam-PRVS: <MN2PR19MB39190C92C01AF69818DCD861B5D09@MN2PR19MB3919.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CsWERm4NIIpZBc90Bq2SmPn5+pKEBKzXZy6OCGrwXC1uDk70xzspY551xxjBxnmq5DjYZYtrg40LK8TiIpakrWAYPlejTTE3/aDifje5R6EGUX9inI/RTGgKclVZ5+uOu3hSzbGP/O/TKL/pQUpP5jfJUJtzo1fOWn4MTaVjjgqAQzRgTtu001XD8iRB9JPRfVOOCz49PXfs7GFm4h2Bgw6rUZhYS0u925bqKXIp1Yai6q02sOKSfjC713iVACsTsGpPao/A+vGRia23ex3BFE3U6ThKSRtuGPzpnis+FTqEKA/eclPwHkbAPcTr4Hvp9Vf63tNyXEJlminVp0jtZSTI8KxwoqOoM+Qs2OAWPijFWFTb4jfpLPiLQgipg4rCvCTSRAt+/llMOrcsEjdl5anMmDHH6HkJIZgOXaEVcszhNkwVdn92m1yBdyWK/Na6q3+Mvkj/OT1GgrH05ptdZw8sjiOXQtu/2MFPc4zOcDA3ZFrBGhAyGp7aIALXuZ0nGrlUapuwuP6ioWkTSJ0E2F5a+q6CNWVRXRld5FdCqkHbgSazNFeQl+t52PQhJLFQhOU5mTLJxGVzRdsay4RVcjrFthkjId9+2v1yIPXarNhI0rWVULyqWIwT+rPTuNo/2Flx8QjWeTmqK1hSxtRwkbp1tlL5+gWewn7DUEcWahrvDKqK4eLjcZ5D7eDiooG3M9XBD4x8CbDQh09r1TsJyDmSIa8bTasQJudLfY0chq969wy2//x1GZZ+qRolFIGXibkZCdfg8sjEdXuK8MIoQS2WKDPcwWk6ISV+IPyzaH6yqUL8RsxI3dc+vNEMZ3t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(8676002)(83380400001)(4326008)(2616005)(31686004)(316002)(53546011)(6666004)(66946007)(6506007)(110136005)(54906003)(36756003)(186003)(5660300002)(6512007)(2906002)(6486002)(38100700002)(966005)(86362001)(508600001)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NRaFgyMHE4RnlGK3BpcWI5Wmxoc2RFV05reEJqa1ZPODVPd2R0anBZa0x0?=
 =?utf-8?B?Z040VHlHUkY5MndhSDlhckZONUlCM1h1WmwrYkZ4WE4zVGs4U2x6aWt0czNz?=
 =?utf-8?B?ZUtTL3hFVEI5ZDExYnpNc3RraHlpOTA0T0JlYUtrYllZZFAvWWFYM29jU3dG?=
 =?utf-8?B?WC9iMmlWSVZYQ0lzL25OV09kZjZkK3laQ05MVDB0a0t1UFlOWlQ1TmgxSXBK?=
 =?utf-8?B?WTJ0RFhIOUpUQVpyVCtwcFFUR3d5OEFjdnpYWVh4SVg1bHYzV2NiakNGSnhx?=
 =?utf-8?B?eWxRZGkxbDhnMS9JeXY3cHZPS201QzVJb0wwT0hwcktMM3R0aWpKVUNWVlBj?=
 =?utf-8?B?ZHJDUWlTUlNkK2pwNW9UVEtDUkZVbTVtL2hWNllWb09GZ3BYYWw3SlNFdUYx?=
 =?utf-8?B?SnBkaFlFZVl0cjE4NnlvbmN4VHhHZ2VEckdMbkhHMHE4Sk5BSXVubVdxMWw2?=
 =?utf-8?B?ZWhxVElLWnRIUC9aVVUvV2hoNEdsN2pZYTZ6d3o1NHpRMEVhUkhMa0dDZy9Z?=
 =?utf-8?B?RXVCQURQcWxwejVLblJTWjc2WEx6SGNsS3JwMmJ5NHlLNktDSTVqM29XSEh1?=
 =?utf-8?B?R3Y5MVkzWDhVZ1doTzVxOU9aRlMwR1B6ajJPd2Y5eTdUWjV4MUsxNGpuZXBn?=
 =?utf-8?B?VWVzSWVUeW9wMXFHVkEyS0lJVWxRSk9mT3pyNmZ6d2VhTVQ0NGVKNHBBS1Nv?=
 =?utf-8?B?TloyN3MwNXRVMW94K1gvaXBxeU5TRDdJSFBzWkVYZ0RpK1gydWNIZkEwbjhn?=
 =?utf-8?B?dlFTK3duN2lJVGRrcXdRYWtObCtyY1Fzb1dWWUwybVU2cGFUYisreXVpUXZT?=
 =?utf-8?B?OGdtSmJxZVhHUDJnYWhhSy9ZOFc2alpzTWVGRk9RTUsrdXVLaEhxeTYrcUts?=
 =?utf-8?B?bWFXcVVTL09ldUxTQ25FTVI1NHU5V1F3ZE1GZHludVpwaDRSZG1oVkFaeWJq?=
 =?utf-8?B?eXlRUkxEbk9xNkdUUHNzYnJabEVxK2tuaUJkaitzSTlDOUVLTjM2bWhiWk1o?=
 =?utf-8?B?czVtSmp4dmc2NGZNRGNHS2o5Y0dUS0hCcjErK3NNL2hJRTFBd1dHWHpCYnVL?=
 =?utf-8?B?T0FWMldXaWEveEhHQlpMODJqdGxhbzVHTk50cHVXcTZMRGVweUh3QzZUald3?=
 =?utf-8?B?QTRSOUFyZ0ZHTUhKUE8zWi8wNjhGYU1STkQ1bVV1RjBRbXVpaUZ3ZmZjSkY5?=
 =?utf-8?B?OW5GT0pOb3NVeDE4cUtBd2JGbTB4Z3dxR2YvYlZ1ay9BeEhlejJWS0dpVlBC?=
 =?utf-8?B?b3NNL0drMW1uTWRXWmEvNFpYemZNWjBqMmpNUGZUa21kRlNmQTVvUHAxa1B1?=
 =?utf-8?B?RzIwbW14NG91VHk3OFQwOWY2Nk5MQnl0UytiTjZsR2JoMEZMRWRmV0pBOUk1?=
 =?utf-8?B?dFc3enRzZTV0c3JlWUhlWFZRMlU4QUJoWHJZUmh6aElmZXMwZ1JKbkxsU1NU?=
 =?utf-8?B?bXRGNzNBMENJaElvalBBWmREemZoOWdwbnNzcm9mUkdzaUUra2JicHk3dkx5?=
 =?utf-8?B?NTN1Sm4vajNpQ2I4YzBZd0g2VFdmVTJRSFZ4TEplVnRjelN6L0xvWXlFMzky?=
 =?utf-8?B?M1RLQVQ0VUNlUjJoZ2w3T2MycVQ5SnNJTGZ1YXdvcjROU3ZlZUtlVjQra1pn?=
 =?utf-8?B?RHloalZrcXpVdklDTW1pTzFscWJYVjVscitXbmIyS1VmeHZnWFd3TVVrUThK?=
 =?utf-8?B?b2tSemtLV0pRalNrS3Ewc2FTdkhMcFp6aW14a1hxR2hJUTM2YWd6K1pHSDJh?=
 =?utf-8?B?NUVVMEVKdFpzbjNlZjFuRUdURHl0VWNwSDZTMGp6Qi9EOFovRkc5YzA0S3FX?=
 =?utf-8?B?Y2pYN2FTODRLN3JQd0RhaXd2anVOWElUT0tOSnV2eHNhaHFjWFJJNkV1TVpt?=
 =?utf-8?B?VGFzOUtzVUJjMlBHellhMFFFM2FLYm1ZQkhiSzhaeUk0L2puT3ZwNG9WR3Mz?=
 =?utf-8?B?NUZ5b3NlNFNQUWYrSHZKL3lnaEZzWHJzYVVBQlRKTW1STklJazBwSE5hcE4z?=
 =?utf-8?B?UG9CMk9DOUluRDRiaFhPOVdJY3hJQ0RPckVjUWZYSUtwN1E4NmRvREJSMWxn?=
 =?utf-8?B?Y25Sd1hHRXhMa2JoZmVIRU9HcHdIN05ncnF4ZG1TdUxySzNjcjZob3JTaXlz?=
 =?utf-8?B?UGxEMk52ZUd1NklFemZBOTVpWlFhM0NiajlxdzdBWTZZZjRiMzdickszb0li?=
 =?utf-8?B?ZTkyS24rcEo2MTdkdk1rRk40a2dEcndIUkJ5b2d0Q2JBRGtXRG1YanNFWmxW?=
 =?utf-8?B?NUVaelJaWjF4dHgrdmU2a3JoWjVhVVZya2xMeVg4QUY4alZUQW9DUlNXTUgx?=
 =?utf-8?B?NzVxUEM5aTNVRnhPQTRwaVhVWHZFZWUySWN6SkRRL1FRa3JVRnF0YUwzWW5G?=
 =?utf-8?Q?mQKKID9Vr7bm27OmJa8wtqnlOaivSb/EDuc3UtVzqRZ8K?=
X-MS-Exchange-AntiSpam-MessageData-1: YajozgJEOG8z+A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986b3f05-5fef-43f1-e367-08da39d84cc0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 20:43:59.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F1EjtlwzQ52zVPy1SxQzeHyhda18e7gXToOxV2TgU06W9I0wda1fzYgNqG3lWE2CgG52+0S4xON4HZfoRHfnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3919
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/19/22 22:09, Vivek Goyal wrote:
> On Thu, May 19, 2022 at 04:43:58PM +0200, Miklos Szeredi wrote:
>> Hi Al,
>>
>> Do you see anything bad with allowing ->atomic_open() to take a positive dentry
>> and possibly invalidate it after it does the atomic LOOKUP/CREATE+OPEN?
>>
>> It looks wrong not to allow optimizing away the roundtrip associated with
>> revalidation when we do allow optimizing away the roundtrip for the initial
>> lookup in the same situation.
>>
>> Thanks,
>> Miklos
>>
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 509657fdf4f5..d35b5cbf7f64 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -3267,7 +3267,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>>   		dput(dentry);
>>   		dentry = NULL;
>>   	}
>> -	if (dentry->d_inode) {
>> +	if (dentry->d_inode && !d_atomic_open(dentry)) {
>>   		/* Cached positive dentry: will open in f_op->open */
>>   		return dentry;
> 
> Hi Miklos,
> 
> I see that lookup_open() calls d_revalidate() first. So basically
> idea is that fuse ->.d_revalidate will skip LOOKUP needed to make sure
> dentry is still valid (Only if atomic lookup+open is implemented) and
> return 1 claiming dentry is valid.
> 
> And later in ->atomic_open(), it will either open the file or
> get an error and invalidate dentry. Hence will save one LOOKUP in
> success case. Do I understand the intent right?

Yeah, I think Dharmendra and I had internally already debated over this. 
In order to reduce complexity for the patches we preferred to go without 
vfs modifications.

I assume the patch is a follow up to this comment
https://lore.kernel.org/all/20220517100744.26849-1-dharamhans87@gmail.com/T/#m8bd440ddea4c135688c829f34e93371e861ba9fa


Thanks,
Bernd
