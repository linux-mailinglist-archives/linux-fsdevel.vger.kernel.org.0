Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA35450A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 17:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344422AbiFIPWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiFIPW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:22:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096DC4AE28;
        Thu,  9 Jun 2022 08:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnhRWi6MLPVoZ7Y3PBWgkySopgx2sJamUA/Kq4JoGdL81fxwFFNdHCF7e2K4C99v92cBiDq+rcR0Vhw4kHMrOS2A24BAgJLnF/nCYYEZTtFsT0CUPYctZ6KeGB4g8bqGNY+f0Bk17nS4oB1ieRWrPrt3gUJ+31dAGsm73RzoGYyn3ABOkDBGYS0ODolkh3lnRbi/5NEqjlY6fnvGQmuyEiksXkqO9o/qkGgW2YT/7DZpJoGqQuw+v3Tab8A8yOdThC46x7o1XiK6+WE88fuLMNqk3hBzDIimig5Slcv9WfLM45kRuUDEEJupFnEUGBmeInCzV5ERFJpQEMQnTxur/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVq363lMPrhouXqAP695NXtZWkuSYR21NFsgSHk7cGY=;
 b=D56r1seNh0PxSR+9EmaGrx64/N8uqPMMrqwJGFupb5z17URbo2M+LtPMu4HVYe1RSjSZMcaibs7p87lJfqYkZ1/RyHOM7NC19bU2bcV38d4HOiP4Lwu/VsyQVkNgFhFzJnfCekkQtNQQ2MNXShn/uR4UbnHfBiNiZnDgTSRaR6MAEkD3An3r1/a7tOMJ+2lrrbK6ggiswWPGlP7P68TE1nOk531SddCf7L5zkq14i+pQwr/gF63tGhJD3yAMCoGPgqyZ+iqhX/+i+BY1erMtRN/KpY3zYwetpt2hOyQ1cD/7nRiwjrShmqIbcLSOJLzBbNO/1rUIex7Zdu7me6DvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVq363lMPrhouXqAP695NXtZWkuSYR21NFsgSHk7cGY=;
 b=T6iXI2YChjeOhyP1Wyb/Miq8Cm/aR0Y/kDxJjFsH1k9yS5+Y/QxrwtQceodujO1MhJZ2cKHn1D2umClC2u7O2eqlRZh2R50jW6jGUT5ITJtVGHa7MURnB1K0eh03o8gApu8g8vT0/niE9ClN4bu7qcybML7EWzjHmxLBtunvyKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB2354.namprd12.prod.outlook.com (2603:10b6:207:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 15:22:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 15:22:23 +0000
Message-ID: <41dc3e5a-9e90-70df-74df-ccdf8fa5ae86@amd.com>
Date:   Thu, 9 Jun 2022 17:22:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Michal Hocko <mhocko@suse.com>,
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
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d841c1ab-c0d1-5130-11fc-c8ea04cc9511@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <d841c1ab-c0d1-5130-11fc-c8ea04cc9511@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd18c7e9-8d72-4ffc-f341-08da4a2bda0d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2354:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB235451BFB4612E6213DE293283A79@BL0PR12MB2354.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bjor99OySpEADZ5ot/zlyBQTDLb91Cd/ABxZtD0ZLJQLAH1u4bK8DvdNXs1tqy4eFNpOeId/Rl7l/eKas/1FnlDFeCvgiNHWZzT8OAX93CTnaygSl3DyPJj6174/RL6p2gKBDwTO4qXhKAiE4WlHhtnpIBrZi6u5GkaAxF2BIQCD9RMHbxgM4UwVAtEGaf4AhavocIr0vETfrlr3XV9ksvA1xqTEhjUDPViF8Bf5vdNc3XKJFITAnizZchfhtlEsMndJtqXWy7eH89IUAA7xtf4yyU0SZ9YhfWw4nTshon3wEcKzIt2qV1nLwv7TSuK3r7geTZNpmiiHoXcBQNoFhdVud6Ifc7yt2wb9nn3UvdbCf1fs7WgLkcG8OZ4V+xJOWS8X9B9lsU9poFcR2DSdopKf5gJIsuudhf2dJ97Sff82zVT2pSBuYSdtvXswV8SUpoQIcJc0Xh0isChlDfRFMsH3lLP0Lo53zEdJXy/xV2qvbsR2Il2A7I/7l3gc8X4lgPDhdedAskn5+YOiGI8xvsy6Dl0QMQ2UmUUsmermDY1Na/oL3+trOippj/dBvi4yPBWpcI1TetpfNSxqn6M62u8AMit9NC8RvkD8TOCheh7WPiY4ZYFM4apHqjlWgPQSefKEDJBeRBPrMHiowJlKxygeOWxh94UAEol3cbbGnrFEQkzdX0JK7XD5NMyl0Ym0VG9djNJ5F2g/IKzBGPvtqMrNfw63A3yiZAh6henxh5wQnltbH/HWLX4NZTrOUNwL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(2906002)(6512007)(316002)(110136005)(8676002)(186003)(4326008)(66946007)(66556008)(31686004)(36756003)(66574015)(2616005)(66476007)(31696002)(7416002)(83380400001)(508600001)(5660300002)(6486002)(6506007)(86362001)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHRIMXo5MWlPL3FpbEhXV0hMRTAzcGJkM2RzWUFid2VFbldCa0lZQy81RGJE?=
 =?utf-8?B?aG9xTDJ0UFFGN3NMa0pKZlVaYTBHM0RTWVV4eTdQR0F5M0pkclpGYUVxUWNM?=
 =?utf-8?B?UWljTXZSNm9aZXdmZlZMWHRIcldWYVM3MWU2cWFWSUFpRkpiNmdPSklSYzRm?=
 =?utf-8?B?SFRhMkxSTUpDTlA0c2JpSVh3bVA4VUovZEpCTTJCdXRvYXlkdGF6TEpPQUtC?=
 =?utf-8?B?a2tOSndiRDQvYUFIVHNDRmJ5WUpxcy9aMTJFaXRWdXZ4SzhaTnNkcDVLeUVx?=
 =?utf-8?B?RU5EckJwRVR5Zjl5QUNSalNUSy9EU1BLMnNmeXN6MHp3L1hJN3FYUElWVnZU?=
 =?utf-8?B?SWoyaXpETHc4Ukhnd05JcWwrN0x1bzUvZkdnYzEzUHlaWS9mZ1k4aVErMm9U?=
 =?utf-8?B?NlY1RlpOcEVwcE5BZnRwSzVzdURPS0N6ZlN4dWNvN1M3M0Y1bGJPYU1jRzda?=
 =?utf-8?B?U2hDNk96N1ZiY2tKZnc5RENwejlySERVUmJiYVdjNTFpclQ5TmdDQjdnekJs?=
 =?utf-8?B?R0tkSm05Nk44QlFKWHo4eTR6NFd5dmtoUkpxUWRReGdqOHkxWXIwWXRpeXQ0?=
 =?utf-8?B?b25ZRTZRV1ZKR3c5cWhtbDNwaSswYkpITitCZE9nSEEzSXhzWnpHSEFlekov?=
 =?utf-8?B?Y3F6UzExUS9GTWp6S2hxZXAxQnpjZWR5RWFkRVVXeHJkNnBWZHNuRXl4YVlx?=
 =?utf-8?B?TGE1MkpTK0tjdm9BWmtVZldlNWVPUTlRWDhjd1FmYS9ZZ1lpUUd5Z21PWCtw?=
 =?utf-8?B?Z29FQVlNVUNzSTR6V1hqRFlNalVkWGpabWd0Y1Q3NFludDZyaVhCMTdmRnhx?=
 =?utf-8?B?MHU2MEV0VVYzd1MyaTV0aGZUQ3VPREFQNVRYZi82ZXJQRVdDRnVlcWR6dFFs?=
 =?utf-8?B?Q0F3U2w0WU9SNmlyTEJ4Q1N5TkZxVDlscEhUdS9hMnBQS0dCRnVkdWsyQUFw?=
 =?utf-8?B?UTZRMHE5T3ovUkJQT0hFYTB6L21RdWZ6WDhnSmswbTZ0UWVDaE9FdEVNU2Ur?=
 =?utf-8?B?Z2lhUkVFM2wrRUNnUmZzWVNzYk51U3AyY2hUc01UcGtDdW1CVVl3Skl0MFIx?=
 =?utf-8?B?U2c2M1VmNGV1OTRXMWZERlVCWVVuaVJybXQrdlp1QzFUT3lvZTQ1dGI1TFJK?=
 =?utf-8?B?RStucVhnNUJDUndCdkRCYmkzTkFUSmptZFZaMUIrSUtXZlNQTHd3c1o0eFkv?=
 =?utf-8?B?MHptc3J0Z1lPMStGRWoyYTM5ZnBDMUhhdFJ4Uzd0MDlJbHp4eTNlaXhkY25s?=
 =?utf-8?B?a0VCNi9MNkE4ZHFqNjhwRHR0MUJMc2NWTkdPeElHY20xaHVMTWZML0lWTGw2?=
 =?utf-8?B?YXN0MjVVRDhDVVh5MTVsN04rdGc2QlY5Mk5BT2c4aXhvMXlwK3ZzSTFTUkV3?=
 =?utf-8?B?QkNidkdBdUVMMXRXYWZLWFJ2dk9KaVh3MEwremV5ZXlaKzVaRHQrNE54RUsy?=
 =?utf-8?B?NnkxVTN5UmVtQlVhSTZUR20wc05MWDhoTmdoSFZTM1VjZmx0ZEJxVzIvZmZx?=
 =?utf-8?B?L21vemF6OUlNbzNDYjdYS0I0R3Nnd2E4TzJjb0g4MnA4V2planRxVkpvanlk?=
 =?utf-8?B?K1E1eDIvVStOUlk2NkQ2VENmUFhPTGtldTFYTjg3RUlHR0U2MVE3dnVXOWho?=
 =?utf-8?B?bjdTeU5VWlpYOGc1dGpMQWlzcVRkVVFWbXhVTy9jejdhcnRCZWdqck5LcVd0?=
 =?utf-8?B?dmord0FCaUo5TXUyMDhPR0FDQURNaHlSZmdMY3VoUWVLazN6M3ZNMFJRSEM1?=
 =?utf-8?B?ZG56clcvbmdDNUdCNVhwOUt2VHBjYnlHSmx6RTYzcERwaFVYWUdlRUsrWVdy?=
 =?utf-8?B?bnJWK3RwWnJUNjhGa1ZFYUJyOG83cDNXaFFkRis3dWlySXVKSDZBVThlMDQ0?=
 =?utf-8?B?cG5XV0NhdnpYTEs1QkZsNzNaR2llYldCRTU3NTVEM2xnTXhjV1BYUHlBZWpl?=
 =?utf-8?B?c3NwN2wwelgzYnZYV3hzUW5TYVEvdjNLMGthdEt5MEVqQ3A1ajJVcW5BNVd0?=
 =?utf-8?B?NHZRRWRqcUdkRVhxTGJuYmQrVWpPZ1lEY2p1c0tWQzNKWi9idWxQbW9OYXNY?=
 =?utf-8?B?aFJXWmFiN2JHdGlIdjJSZWMrcGJVY1N2RzNWbThMY1YwVnJ5MmpMaVpNZ2FS?=
 =?utf-8?B?YW0xajZPVTl2ejVMRHpKUCtZVnRCck5KYXpyOVJIV2ZOeXRoWXRKby82eWJy?=
 =?utf-8?B?K25CWExQQlM4a3dYSm5yV3pVbXNhbmlTVDNKMXFyZHF4anZnbHcva3BDMUU3?=
 =?utf-8?B?alNzR1NWTkdGRStmQ3pHRXU3ZEpLS0JoNnZLQStid2ZmbWt5RlRXSkkyNUpt?=
 =?utf-8?B?S2dyS09LSVdxMjhjV0h6c2MwODAyY3RBclZMVlY2QXdOcWFLa1IzYkl1UW9z?=
 =?utf-8?Q?41tY+jf6EjeE00RTCQqZaXN8gELe6CQqfPEzLWIY8/SfH?=
X-MS-Exchange-AntiSpam-MessageData-1: VjTGjkvaAuFE8A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd18c7e9-8d72-4ffc-f341-08da4a2bda0d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 15:22:23.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0jO5R68gSJaQQd+QO6mBlSpmZD4Ol9zhjsTBEjzP3D5RcHJXLC/+Bfljsb21NkS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2354
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 09.06.22 um 17:19 schrieb Felix Kuehling:
>
> Am 2022-06-09 um 10:21 schrieb Michal Hocko:
>> On Thu 09-06-22 16:10:33, Christian König wrote:
>>> Am 09.06.22 um 14:57 schrieb Michal Hocko:
>>>> On Thu 09-06-22 14:16:56, Christian König wrote:
>>>>> Am 09.06.22 um 11:18 schrieb Michal Hocko:
>>>>>> On Tue 31-05-22 11:59:57, Christian König wrote:
>>>>>>> This gives the OOM killer an additional hint which processes are
>>>>>>> referencing shmem files with potentially no other accounting for 
>>>>>>> them.
>>>>>>>
>>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>>> ---
>>>>>>>     mm/shmem.c | 6 ++++++
>>>>>>>     1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>>>> index 4b2fea33158e..a4ad92a16968 100644
>>>>>>> --- a/mm/shmem.c
>>>>>>> +++ b/mm/shmem.c
>>>>>>> @@ -2179,6 +2179,11 @@ unsigned long 
>>>>>>> shmem_get_unmapped_area(struct file *file,
>>>>>>>         return inflated_addr;
>>>>>>>     }
>>>>>>> +static long shmem_oom_badness(struct file *file)
>>>>>>> +{
>>>>>>> +    return i_size_read(file_inode(file)) >> PAGE_SHIFT;
>>>>>>> +}
>>>>>> This doesn't really represent the in memory size of the file, 
>>>>>> does it?
>>>>> Well the file could be partially or fully swapped out as anonymous 
>>>>> memory or
>>>>> the address space only sparse populated, but even then just using 
>>>>> the file
>>>>> size as OOM badness sounded like the most straightforward approach 
>>>>> to me.
>>>> It covers hole as well, right?
>>> Yes, exactly.
>> So let's say I have a huge sparse shmem file. I will get killed because
>> the oom_badness of such a file would be large as well...
>
> Would killing processes free shmem files, though? Aren't those 
> persistent anyway? In that case, shmem files should not contribute to 
> oom_badness at all.

At least for the memfd_create() case they do, yes.

Those files were never part of any filesystem in the first place, so by 
killing all the process referencing them you can indeed free the memory 
locked by them.

Regards,
Christian.

>
> I guess a special case would be files that were removed from the 
> filesystem but are still open in some processes.
>
> Regards,
>   Felix
>
>
>>
>>>>> What could happen is that the file is also mmaped and we double 
>>>>> account.
>>>>>
>>>>>> Also the memcg oom handling could be considerably skewed if the 
>>>>>> file was
>>>>>> shared between more memcgs.
>>>>> Yes, and that's one of the reasons why I didn't touched the memcg 
>>>>> by this
>>>>> and only affected the classic OOM killer.
>>>> oom_badness is for all oom handlers, including memcg. Maybe I have
>>>> misread an earlier patch but I do not see anything specific to global
>>>> oom handling.
>>> As far as I can see the oom_badness() function is only used in
>>> oom_kill.c and in procfs to return the oom score. Did I missed
>>> something?
>> oom_kill.c implements most of the oom killer functionality. Memcg oom
>> killing is a part of that. Have a look at select_bad_process.
>>

