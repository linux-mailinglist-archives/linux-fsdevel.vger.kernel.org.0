Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A31405619
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359382AbhIINR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 09:17:59 -0400
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:12783
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356072AbhIINML (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:12:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETocO9MD7awuKcvREmcFgtfAPRiX1/q762wVztU0A21EBXNxUPb2TxJXyFW116FDrIrH7n/ZudjTskpRTQMX1ukJYeCsQqc+OWJli/VyPFZeaYnZkjGDyPyUiykMct6+IPERqgI6a7D3Xvu9S8nkXFkvMA2FjjA9UaI7vP1nveIfOe1UlbpIqOAJSVCuitTG513Bhxp2UdzjNJ/fOzbrGt/HWmTLzgDMgKAO6Cwe27AirY9aiT5Yok4Q2Krm+CtS+z9kUB73uDVc1XTbaU3q2FqAVbk86dxhzSRBxNoao+jh5te6f4QWYb61fIwNChPo8aOmSp2h/jyBqxPCUp55GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y84+NfD7FLJMoALtVzut1WPveI2uTlUXwRmcSqYr1jY=;
 b=ih2p6V4PI0nE/+7slez17tQkGw2epz7BqBALPXRKl2B1iJY4Sb+LgccBYbSCSxEDA1QKr5b0ZT5wtOZR2SL4KAdeCdxmsI7rI8tthHgNa8CpeObzRawBQ1O2/1TwB335DGG6X3yZZCJ4ewdSObHLJFeE4C0X91Uc2Y9Udq5s4gDL4bKNICCfYe+mxjCsWoRmnMiqAX//UWSXB6VGVdfGMtJpqXFsxxa+d2By7sc++1ndlpGMHOLhMQJvkl5hgkfTjkeUIe8/jjONc3FWYZWaWxmfaRSfp8/ZkozY0lndaGDSwAjMC2GVe/jWpurOMcwcW8dMRUzc52DYBovk557vbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y84+NfD7FLJMoALtVzut1WPveI2uTlUXwRmcSqYr1jY=;
 b=ig1LdEzHC+YWtCw2sgYLqwP1tGSSMS2vXfYqw8gUmIlXGQ0YYf4mpDK0EBTR7MW21ljxrNjXWqyOo705a0DSzoD86C7qtEQQBdeRQBobyLx8xAzHNTvSXzygS/nZwGItZDZ7WltBU5AAV1vexrwIpB0ctNh+twhQiMM0FjBGIug=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 13:10:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 13:10:57 +0000
Subject: Re: [PATCH v3 8/8] treewide: Replace the use of mem_encrypt_active()
 with cc_platform_has()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Baoquan He <bhe@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <46a18427dc4e9dda985b10e472965e3e4c769f1d.1631141919.git.thomas.lendacky@amd.com>
 <a9d9a6a7-b3b3-570c-ef3d-2f5f0b61eb0b@csgroup.eu>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <76ace164-92d8-c970-f9e5-d259c3573314@amd.com>
Date:   Thu, 9 Sep 2021 08:10:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <a9d9a6a7-b3b3-570c-ef3d-2f5f0b61eb0b@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:806:27::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SA9PR13CA0125.namprd13.prod.outlook.com (2603:10b6:806:27::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Thu, 9 Sep 2021 13:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4ebcc4-c34d-4506-688a-08d9739342f6
X-MS-TrafficTypeDiagnostic: DM8PR12MB5479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5479A0D2B0392DD6E5F5AE49ECD59@DM8PR12MB5479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K47tNBsaYzzuzlxXL3/vD/zxcrr1/yJ4Gvskt7vedtiQCf87xHqzY4QOah94oDRuAquR6XAP3kdNvZ0Y37vC9x8ta4MScHcRqpulefomH5L1J0tS5Uufnm634CoVOm7y9yTHDloCmNePqISnmnU1QkpjnY3SwklRIRe7RK6E0lmV+5pCQ1kY8wDfdiF2wYT5qGvUImVaBCO8bH3B+veIjq3a8xnO7jLywvu7dz25mFAzWExFjzehck3dYoR6wclHB1+2wQljopz4K79i/ccfAyNZYWdoKV6bdGstsdYQ+ReosB9j85TwkvTi+OY4cyba2tweEQNzbU7VZvWWiG0vK6PiN1hLDlq9QOl9CZPGZqL1Ut9Vq+P7oOajm7VjoZ8PurcoLmHL1bi1f1Sg9bJWiCay1IYGASWQ2djvD0cZ8uNp4U99zJoUolPef3Je60SSjXEYJwROzX2yS2qIi0VRoUN1kwdG0wjqMDCN+1o8vlHpXyF80eOpDClnWexMt52lqv6oXJZmhGJyVTqYuIrwkf/xXtHmSpPNqNZgcUpp9/khby16Jfbz7Vbu2xjzR+UGMxdS4inCGtzzIxoAveutdTbk6uQ4+hmuOsVXlH4v2/6BQQ10lr3vZUmK8rPDJgYJqiLkF3cuyvqYDmqkejlRUdY2KZCpX3EYOhWgV8y+jQTSPCWICFIoasSpV8HOAAKr8USJbnFOLETy40qfJm2g+cfCS/T5tBJ+5wmoNKdPFcasuKSP/mFu6KCo/im6sxQIvMcAmg57BR9suMwoa9k9gaV1ivpJcyk6UNMAmvs42nNBI5xPSAViRTl33OPlINJwzy6pwEeaji3cxtMGy7Kddj1Z2I50UWZ4453Y2Gg32/LFRAypwWpK5fFXf0hdmUa3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(31696002)(31686004)(86362001)(66476007)(66556008)(66946007)(8936002)(921005)(38100700002)(83380400001)(316002)(53546011)(36756003)(2906002)(16576012)(956004)(2616005)(26005)(186003)(5660300002)(8676002)(966005)(4326008)(7416002)(7406005)(478600001)(6486002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkIvQk1IaWJxbGhFeXZZai9xNGdiQTladU1pYW9WNTREcktUY0dEc0pxeWQw?=
 =?utf-8?B?NVVEYXI4bk9KcXluY2ovNWF3ckNDQXphT1BwL3lFWDdueWgxREtEdy9nSkJO?=
 =?utf-8?B?ZEtHd0FPeGxyQmxGVXQ5UEZTTlFMVlkxY0lNbUpYaURVSllxUGtEZCtIbkdx?=
 =?utf-8?B?NTlpUE4yZzg0ei9yR0hmdnl3aUx5ajEzMnFKTTBGWStOZGEwcXQ1WGw3T3NO?=
 =?utf-8?B?MnBKby9RYjVReVJ5Ly9TOVJHV1g5ZU02VUVTcXg0ZXZHNFlxTWtYejlXWk9Q?=
 =?utf-8?B?OGRxVFk2NU5EZHpacWhydzJZSjRMMTU3eXV4cllSNmlVcFNrMjJiZzRyeWV1?=
 =?utf-8?B?UGVOdnVxMVVrdDVySzIrOVhIYU5hSHAvQjJiYTFwWDh1T1Y4T3lzSUlzWDF5?=
 =?utf-8?B?WU1RZTdHWXdFc0hZcnlLcGdqcEJoM0xhUFNEY3pSRUxWUSs2Q3VxSDRuZHJW?=
 =?utf-8?B?L0lhRlJmTEIwSGxKZXNJc2oyMmZyRDFGK25wbWtmMWtkbWIrbkVSdldsYmpP?=
 =?utf-8?B?T2haOHJpa1NwVXFJZEpadWVlVVFNUW9mcHVJMURNYUNNRTlBMEV1aGJraDZV?=
 =?utf-8?B?THBRdm5DRGhlMHJrTTNyTnlzVXZ4cUE2Ly96ZHRYZkdkVEZtVS9PdWtXRFdr?=
 =?utf-8?B?ZFBuVzd2RmREK0ZPYXQxVmZJbkVkaXZSM1RPMDJRQzAxNVlRdGhBQ2ZYL2Vl?=
 =?utf-8?B?MkJ0ZnpRejAyQ0lWdG9wdGprRm9uMk1KMWlDTFo4VEdMYUQ4eGZzYXUwK1VV?=
 =?utf-8?B?bWFIdDJLV1JpUUVYRXVCbitvUVQwb0tKQVBMdHZ6cUtVK25TRVlZM21kNW1z?=
 =?utf-8?B?TFBiWVZuUTlEbW1hTkZJM2hZNXduMWN1WW9ZTDNDWjJnRU1ESUJ5UXYwVktO?=
 =?utf-8?B?MGtXTHBVbVVLK242dWs3VlVkYkg4clo4UTV0UWZWTG02STE1RTdYTXZlQkZK?=
 =?utf-8?B?aU5BeXlaMnRrb2VEeitLeFNtS0daSXRTS29FV25hNG9OU1gzbStqSG9hVHlw?=
 =?utf-8?B?clBidWEvMHg0c3MyWk9wZ203TEtRYWd6R0c4Smh3T3pWQ1d4VWl0TnVId1BB?=
 =?utf-8?B?ZXQ4eXZac25LRGk0SVhGdFNOSWRmeVlvR3VSNG0vaytLbEpaRlJaNnoxNDJV?=
 =?utf-8?B?T1MzS2NlYzg5ajl5V3Qrd1VZWmc4MjRUdlU1ZG1ZazZLbW5OZExhNkNPUlhj?=
 =?utf-8?B?aE8ySGt3U0xyQ0lFeHVlaCs2ZkthYzE2eWdoa3A2Mkw5TXhFNFlVQkVoUmZE?=
 =?utf-8?B?ZUM3UFRyRURKeHdaYzRCWEtrazh2aTY1U29NTU5VWTRpTG5LL2ZJSDNBbUZC?=
 =?utf-8?B?YURMK0hWNWUvcWtnZFhGSEhETkxDT05tbG5FZUFBeTU2eEpKaFVRRGxHL1JF?=
 =?utf-8?B?TzJKWGZnMm90dE1RMWZ1OWN4bkEySXhHNUp4c05uWGZCODVsZWd2VWY5SjNz?=
 =?utf-8?B?UlZ3NVhJc2Y0d1ZiMGxjdXFFOFhJdHlsZGNubnVSL1Nta2xIMmhtQVJGUms5?=
 =?utf-8?B?bzhiUDNwUG55Sk9CYmhEYU53Z1pEZi9kSTFnWDlyNXp2VTBSL2hEQjBuR2l6?=
 =?utf-8?B?anRML1IyOTZaQU5VLzhjTlhDRXFxUFROcXYrSE9zSy9yS3FyR3Y5eDdINmFO?=
 =?utf-8?B?bHVESDlpZjVjTGdDR3lvVFBPa0xFMWRCS3pLay8vMzN3akFNamc4YzZWaFd0?=
 =?utf-8?B?aHdNRmNBNTVzOERpSGVBa0Y0ZUx5RnYvd2pBV3hzV1JRNUpRZitQcXNJdHJB?=
 =?utf-8?Q?8rWV+nyfWW75Hy/CbuTr7nsrSFfY7gpo462nm72?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4ebcc4-c34d-4506-688a-08d9739342f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 13:10:57.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxAPyqV7mZbEtpfsm2iUdAAFImWIav2+gAszeKAjPJ9M2SQqmTftN3mymGAKltwLQ3UXedkqi2rRhaJ95bU76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 2:25 AM, Christophe Leroy wrote:
> 
> 
> On 9/8/21 10:58 PM, Tom Lendacky wrote:
>>
>> diff --git a/arch/powerpc/include/asm/mem_encrypt.h 
>> b/arch/powerpc/include/asm/mem_encrypt.h
>> index ba9dab07c1be..2f26b8fc8d29 100644
>> --- a/arch/powerpc/include/asm/mem_encrypt.h
>> +++ b/arch/powerpc/include/asm/mem_encrypt.h
>> @@ -10,11 +10,6 @@
>>   #include <asm/svm.h>
>> -static inline bool mem_encrypt_active(void)
>> -{
>> -    return is_secure_guest();
>> -}
>> -
>>   static inline bool force_dma_unencrypted(struct device *dev)
>>   {
>>       return is_secure_guest();
>> diff --git a/arch/powerpc/platforms/pseries/svm.c 
>> b/arch/powerpc/platforms/pseries/svm.c
>> index 87f001b4c4e4..c083ecbbae4d 100644
>> --- a/arch/powerpc/platforms/pseries/svm.c
>> +++ b/arch/powerpc/platforms/pseries/svm.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/memblock.h>
>> +#include <linux/cc_platform.h>
>>   #include <asm/machdep.h>
>>   #include <asm/svm.h>
>>   #include <asm/swiotlb.h>
>> @@ -63,7 +64,7 @@ void __init svm_swiotlb_init(void)
>>   int set_memory_encrypted(unsigned long addr, int numpages)
>>   {
>> -    if (!mem_encrypt_active())
>> +    if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>>           return 0;
>>       if (!PAGE_ALIGNED(addr))
>> @@ -76,7 +77,7 @@ int set_memory_encrypted(unsigned long addr, int 
>> numpages)
>>   int set_memory_decrypted(unsigned long addr, int numpages)
>>   {
>> -    if (!mem_encrypt_active())
>> +    if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>>           return 0;
>>       if (!PAGE_ALIGNED(addr))
> 
> This change unnecessarily complexifies the two functions. This is due to 
> cc_platform_has() being out-line. It should really remain inline.

Please see previous discussion(s) on this series for why the function is
implemented out of line and for the naming:

V1: https://lore.kernel.org/lkml/cover.1627424773.git.thomas.lendacky@amd.com/

V2: https://lore.kernel.org/lkml/cover.1628873970.git.thomas.lendacky@amd.com/

Thanks,
Tom

> 
> Before the change we got:
> 
> 0000000000000000 <.set_memory_encrypted>:
>     0:    7d 20 00 a6     mfmsr   r9
>     4:    75 29 00 40     andis.  r9,r9,64
>     8:    41 82 00 48     beq     50 <.set_memory_encrypted+0x50>
>     c:    78 69 04 20     clrldi  r9,r3,48
>    10:    2c 29 00 00     cmpdi   r9,0
>    14:    40 82 00 4c     bne     60 <.set_memory_encrypted+0x60>
>    18:    7c 08 02 a6     mflr    r0
>    1c:    7c 85 23 78     mr      r5,r4
>    20:    78 64 85 02     rldicl  r4,r3,48,20
>    24:    61 23 f1 34     ori     r3,r9,61748
>    28:    f8 01 00 10     std     r0,16(r1)
>    2c:    f8 21 ff 91     stdu    r1,-112(r1)
>    30:    48 00 00 01     bl      30 <.set_memory_encrypted+0x30>
>              30: R_PPC64_REL24    .ucall_norets
>    34:    60 00 00 00     nop
>    38:    38 60 00 00     li      r3,0
>    3c:    38 21 00 70     addi    r1,r1,112
>    40:    e8 01 00 10     ld      r0,16(r1)
>    44:    7c 08 03 a6     mtlr    r0
>    48:    4e 80 00 20     blr
>    50:    38 60 00 00     li      r3,0
>    54:    4e 80 00 20     blr
>    60:    38 60 ff ea     li      r3,-22
>    64:    4e 80 00 20     blr
> 
> After the change we get:
> 
> 0000000000000000 <.set_memory_encrypted>:
>     0:    7c 08 02 a6     mflr    r0
>     4:    fb c1 ff f0     std     r30,-16(r1)
>     8:    fb e1 ff f8     std     r31,-8(r1)
>     c:    7c 7f 1b 78     mr      r31,r3
>    10:    38 60 00 00     li      r3,0
>    14:    7c 9e 23 78     mr      r30,r4
>    18:    f8 01 00 10     std     r0,16(r1)
>    1c:    f8 21 ff 81     stdu    r1,-128(r1)
>    20:    48 00 00 01     bl      20 <.set_memory_encrypted+0x20>
>              20: R_PPC64_REL24    .cc_platform_has
>    24:    60 00 00 00     nop
>    28:    2c 23 00 00     cmpdi   r3,0
>    2c:    41 82 00 44     beq     70 <.set_memory_encrypted+0x70>
>    30:    7b e9 04 20     clrldi  r9,r31,48
>    34:    2c 29 00 00     cmpdi   r9,0
>    38:    40 82 00 58     bne     90 <.set_memory_encrypted+0x90>
>    3c:    38 60 00 00     li      r3,0
>    40:    7f c5 f3 78     mr      r5,r30
>    44:    7b e4 85 02     rldicl  r4,r31,48,20
>    48:    60 63 f1 34     ori     r3,r3,61748
>    4c:    48 00 00 01     bl      4c <.set_memory_encrypted+0x4c>
>              4c: R_PPC64_REL24    .ucall_norets
>    50:    60 00 00 00     nop
>    54:    38 60 00 00     li      r3,0
>    58:    38 21 00 80     addi    r1,r1,128
>    5c:    e8 01 00 10     ld      r0,16(r1)
>    60:    eb c1 ff f0     ld      r30,-16(r1)
>    64:    eb e1 ff f8     ld      r31,-8(r1)
>    68:    7c 08 03 a6     mtlr    r0
>    6c:    4e 80 00 20     blr
>    70:    38 21 00 80     addi    r1,r1,128
>    74:    38 60 00 00     li      r3,0
>    78:    e8 01 00 10     ld      r0,16(r1)
>    7c:    eb c1 ff f0     ld      r30,-16(r1)
>    80:    eb e1 ff f8     ld      r31,-8(r1)
>    84:    7c 08 03 a6     mtlr    r0
>    88:    4e 80 00 20     blr
>    90:    38 60 ff ea     li      r3,-22
>    94:    4b ff ff c4     b       58 <.set_memory_encrypted+0x58>
> 
