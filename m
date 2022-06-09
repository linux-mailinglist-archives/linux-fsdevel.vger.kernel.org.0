Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94919544B8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 14:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiFIMRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiFIMRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:17:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66682FC0DA;
        Thu,  9 Jun 2022 05:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHuGtk8c1DlyGUjhFAsTgRWyqnNX4Uho/JFgiYnC/yJAdWZwZxv6liHXFAEIoK+K8HB0FcoOeG/u3UhnWUotjwpwzOYB9VWSiYRUkWHg1HZk2LvR8MBKSfpRDAfnRTXccwBiPmCMlGNn17obROpCB6wXYIapAhhz44dIovdXdjmuhyrt6Tdf5yG12JvB/y1sq4vsX3+WSvdjK6ckhKeENBAjDI2uPpfqz863XDbItgkYkAVG8eVNPQqmQi+AaR3oNQaTrZEneeguXazGuPOBMbYhv/7ME1VJT7hRZKgxcPs8Q5W7Grf+uIWtzIJQgcN7U52w4XgDLVxPkS9MVL/BJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPWneNrHSgJG8GSliH3K5Cwag01OfltiGm34nJYt/rc=;
 b=SQ2UaLQzUf0fw0KQueU+gWKrv9cFv2K0BzP6BtuAC38SFMK5m/s1S88PSeoq1Y9IJsJPuo4SPROHxqTTOqiGvhtfdxsYRrB+siO3OHDfnm/oGFo+OiBdB/vw3aU2SVbuGe9ClBeZz2FUC4FdptEcTAvNyyL0NNhwWX1eGyTLYhrOWD3PXMIs5FHhKpQlTKClGIapXY2Xzbwc2EpKHudmft6/ZQsL2nAecQmIgH9s0mdhJVunzMmqwtRz5KKLJWmd5V/k5AnRrb5t1BLAQdQj6oe7+bqDjIR10FUlU2BXQHP+vuW42kVIfMEfKJRhoB5300FQeYqrqRzsvi/gMw7j+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPWneNrHSgJG8GSliH3K5Cwag01OfltiGm34nJYt/rc=;
 b=oDcROBXyGknnM+XFLz5Z9nkahos205iKDCrBt1OzivASv+kFvKuMZHvTdx/hd3OyZlZDHmr/5i4wzuYfuJt7SJwSk3Vy9NeJDIzGAK5b3o4dV8jiYY7AUr/D3lj8wI+kZJOgkmNyaVEfOZ9yDamFpOnkaJgcDRzza50BdunPfu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Thu, 9 Jun
 2022 12:17:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 12:17:03 +0000
Message-ID: <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
Date:   Thu, 9 Jun 2022 14:16:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
References: <20220531100007.174649-1-christian.koenig@amd.com>
 <20220531100007.174649-4-christian.koenig@amd.com>
 <YqG67sox6L64E6wV@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <YqG67sox6L64E6wV@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:206:1::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83a2d231-6bbd-4a12-7263-08da4a11f651
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4617B40574098F3D7183046F83A79@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cV7KmA74EyrA0UaZnKaESOqUJEMtRKy6QLHpJEpG8PANAwLjNBHw1hLogrLrfDxn/K5K6ofOE/nci7SSYtEPwzCrpsfkpm1kPJPzbZom2hHZ8pxv+WX/4t5hwB8PxpzY0uSLjfI825hGp344ry2Foc6s4XfUxb4MEhFa5a2XqVACJ1xr3QlMGhqWiLA8dXhU8CtYt6gWF8mRFd3EGzZ6NtCHvI78Bb+rkF5OSAyCDlXgmNyq/GYB3oXdgilWuAu1HIIa1ZcKajY301s+D5xL6gN3lRWDTP4oSdUo/GnN9nuEa/q6tYQ6nkl51MiUpzIQGeY2/GUSlxDkb1AMSeJEZosh2BAzfzfn6aLJPigzT6MNolCpkGhMoLKV6wTL7Z2wLLA2uf9i/PjFZAIWZEUsOxsxDHbU3DEB3QkMnjKop/5sbG0PAN0FMmV4LIplhCQrSRHg0m4dexeSRQADImVEDzXzL0s1QhPxk73hfgBgJWkvjGMDrk84SzwkhxU2DfW/xrJSgYOahy75raPRtaIWymCV3qVUieS6eHmdoOySltT3ffAVcEXe//b0XRDfSwcT7CdCmRSWVj1Fnd9qr1UjefBiC5mj7RWMu5mit8FIRpZe5NKPieu7C1oYfXq3MCnUdpUB2Oj5u9x/b/yXk451hMwOJqPdn/VR4tpf83XFey9VTcCw1myCl84k4JWMNDUHiy5neWWdkIWRipzERH+CCzqiPcpkMdeOBY28I3qTcZnQYtDOsCu9KqHlumW3zW9u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(8936002)(2616005)(66556008)(186003)(316002)(7416002)(31686004)(83380400001)(6512007)(110136005)(66574015)(6506007)(38100700002)(36756003)(2906002)(8676002)(31696002)(5660300002)(66476007)(6486002)(86362001)(4326008)(6666004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDNqbVlQb2FoaStTVXVSN0orMTJ6alFKeWdNZXR4MjFTbHVFbVBsUUpuWEpk?=
 =?utf-8?B?a2tlMHZuYzBsN1FoaS9WcjlnMWhxMFVnOXg4SWJqcXZ2b3Yyc1l4TmhweW5k?=
 =?utf-8?B?cHJxcFp0THdZc2RyK0FPeDd5WkFkWWpLTFZaNHlIU2FOQkJCWkIyM0kxdjBV?=
 =?utf-8?B?cEVGeHdZUUFlaHhubEg4OG0vUW16UDAyb212MUIvN0tNMkVmdXVROHhkRjBj?=
 =?utf-8?B?T3ZTMTJsRXpmbWFKZld5RkcvRVJBVzhjdmJ3VTZjTDhQYWx5bjJ5eGR5WHVs?=
 =?utf-8?B?QUZVUFJBay9jOTYxdkhrR0E5eUo0ZkN3TTFpZ2tNMWc1VXVFWHJ5aUFjYVMy?=
 =?utf-8?B?WEw1dWR6bHc0OE56K1k2YmlpdTdwSUZXZWwyWWN4VmlKRnV5bE9EU2c1Sk00?=
 =?utf-8?B?bVAvc3EyZXYrYlE3Z2tobWwrUEo0RVpYbXdSRzBJWjh5SWxtR3hZUkxMblcz?=
 =?utf-8?B?ekg4OTRkdDdReGpDYkcrOXQ2ZGs1MU9tV1hCZGs2Nk9hbkRFWk1wVk5UaTd5?=
 =?utf-8?B?ajZEU2xENGg0SXFLMm1WK0RCVkxLbEhzRE1xWlRlcU1vMUZ5SGh1blcxbG1X?=
 =?utf-8?B?eHIrRkVCK3Zlei8xVFlzVVh4Z3RwSGFBZDRvRDc3dnpka09vcldyeGphaDN0?=
 =?utf-8?B?TzdRdWt2eWJoTEcrTkJVK3ZDZ09PWldBTlROalhkZ1JMbVBwaHlwWEZTMVJt?=
 =?utf-8?B?d2RzbVExVkRGeEJpVE9oc3pPQ0ZyWG1tUnpMZml0SENlajdKbXZRMjFNWG52?=
 =?utf-8?B?VUduamRCMm9GbVJlSWxKWXNaUWI4S1M0bkJGYVRaUFk3K3VBK08waWdvR2Zs?=
 =?utf-8?B?TWszSHVlZS9XMWZFMDRBcE9qZjVMTFNGNGMxNUt5Vm1sWTFCOEVnU3hlL0Q3?=
 =?utf-8?B?b0xTemJrSXRmREY4c1RDdzdtTkNiVHhxT0tQQ0dlQ0RKZ0lhTkM5QjZpQ3RB?=
 =?utf-8?B?NWdCazdWTFlIeTA5UjJicFpuelNWZ1BFU0dTNWtodEh4dmd2TkdoL0dkdnZo?=
 =?utf-8?B?S2IxZDJta2ljN1owaTdTSlFsQjBSMG0vVGd5RCt5ZGVhUVk2MUhqelZHMk4w?=
 =?utf-8?B?ZjNMQUNmaXJkOTA0OHo0OWpuTWNuRzZFQytsTmM2eE1PWnJVTnU4MVNkczhk?=
 =?utf-8?B?MXJIVDI2RkdHcyt3Q3NJRnpFY0pzMzkrekRaV2hnQktXeFExZEhIT2xyS1Zh?=
 =?utf-8?B?Um5hNmtXWTl0YzNTMnVzU05qVUFrUEsrMlVza2xQUThDOTE5OXhmc2IvQ1A0?=
 =?utf-8?B?bXpqSm5nbUhPRWJUbXMvbU5pSWJpTUdiRnBLalN1UUttOFZ4ZWQxV3ZwZUFD?=
 =?utf-8?B?YXhlaDVVSWZwMTd3OUMvd0RVcEFYcVUwNEdsNm9JUHRhQ2tNZWE4NGRHTi9s?=
 =?utf-8?B?YmR5ekpKZ1RZaHcxazNxYUsvSVJjVi80RUdaUnJ0aXEwSmZXcmV5MTFQSnAz?=
 =?utf-8?B?WnpFVGhpc1E1M2trek5PanhtbzhlM1dyK1IrV1loRGVjc2JRWHFmV1lSbTlJ?=
 =?utf-8?B?Wm50OC8rVmM4SVF4YkFuRGI2M1V4VXBObVJ3SDlTcGt0TlA1cDQxRE1WWElh?=
 =?utf-8?B?WUZMVksyeVB5MElrcUd6YWtCT3dYc2JvMDNhR3VGTHV4bC9tSVdraHp1QktM?=
 =?utf-8?B?eVFVNnJhZ0huNGtmenNKdDhFcDNORGdzUjZ6TEQ1VG1lRkFlbWxXVlhIZmJV?=
 =?utf-8?B?ZG1sckN1NlA0RjkxSkpKODVLK0JGWUV5SDloRXZOb1puZytjT0xxcm5EOHp4?=
 =?utf-8?B?RU5vR1NjdGNNVWlYalVJK1JyQjV3SkdIaWUxODhuMUQvM3FTRWs5RVJWRHNR?=
 =?utf-8?B?dGJ4RnJXM3hQanIxdzhMK0UxZTArRExFeEl0YmlnWS9YMUdZeWJIMU0xMmFh?=
 =?utf-8?B?ZFFWaW56Q1FaS21MYXRSVDVyb25LY09DMFRyRnNVTWJHQkZ6dnROdGZFcitW?=
 =?utf-8?B?V1p6ZkN4SU1WVllsTWMvajYvSHpLVjloUXZKVkpmNi90eUlheHBSb3E0bnpU?=
 =?utf-8?B?eGFaMzVVM0pzZVhnb3pjVWJOQUhKaTVDdHBBeS9nOVY0Qk9iWGtpOUZ4UzUw?=
 =?utf-8?B?M1BGQStMeG9XMHdFa01PQm1ZVDJuVTM1VGtnR29kS203VmNrZHdERDliaXky?=
 =?utf-8?B?ZmxKSThRVU5XdCtVSlZFSEtZQ1kvK1lCSVpxdWdWMkIzWU1rdk5HSlI0ZEgy?=
 =?utf-8?B?RStFd1BTQ2VFL3R3NnMyVXVvRlFsU2Y0MEx6YnZ4L1gxNDZwZERCc3JaM3E4?=
 =?utf-8?B?M1IzbHBraXdySUhlZ1FVRnBaSWpsVUVIVWdCU2drcFV6aHByUFhic25FWXhp?=
 =?utf-8?B?ajBEeFM0UU9Tdm1pVUpZbGU4OVZUcnRxVkpSdWpYWVArRGlYWnZoQzQ4TjRt?=
 =?utf-8?Q?4a35nrjAFGg5czGovXu2jkhq74+LnZju4sOkA3ETXU2Hu?=
X-MS-Exchange-AntiSpam-MessageData-1: nUUj7FIWfvqV1A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a2d231-6bbd-4a12-7263-08da4a11f651
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:17:03.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45k76p0B/TLKx/YAjEiRq55YehYfWN1Wm4WNxfSQtUV7pfGR/SotvC632uXEpVkw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 09.06.22 um 11:18 schrieb Michal Hocko:
> On Tue 31-05-22 11:59:57, Christian König wrote:
>> This gives the OOM killer an additional hint which processes are
>> referencing shmem files with potentially no other accounting for them.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   mm/shmem.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 4b2fea33158e..a4ad92a16968 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2179,6 +2179,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
>>   	return inflated_addr;
>>   }
>>   
>> +static long shmem_oom_badness(struct file *file)
>> +{
>> +	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
>> +}
> This doesn't really represent the in memory size of the file, does it?

Well the file could be partially or fully swapped out as anonymous 
memory or the address space only sparse populated, but even then just 
using the file size as OOM badness sounded like the most straightforward 
approach to me.

What could happen is that the file is also mmaped and we double account.

> Also the memcg oom handling could be considerably skewed if the file was
> shared between more memcgs.

Yes, and that's one of the reasons why I didn't touched the memcg by 
this and only affected the classic OOM killer.

Thanks for the comments,
Christian.
