Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BDA405615
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357560AbhIINRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 09:17:54 -0400
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:16033
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357681AbhIINDP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:03:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH17hFuqA/pi1Nimz1Ntx6N00PEtOii7EZs+Zv5MP8R5NLJGSvQQ2t3DRJnARQ8JOcg77SB0Iia4qNEA0OpGdZ0WYSqAPYqivQczh+ZtbqvIsEa0DEW/Qkwf/vzgaX4YsCFt0/uXQsC0XKGzIrpZ5VVXbszd+TCIZXV0CVyp3/Un7Jzfb1moxIb9LNbcSt8iXc1xqhKQR2SxGbk/oxTChfSushlj8k6k+7Z9yB8N26QIkalgQnllmoMYScOtBrRgdvs2ErZSDyQEFjlS54JQefRNQadiX4YS7D9i8QkEmlf3UTGFW1iP/Aqi0YaGw/g6uBUzuTypL34S8J8Td8PLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rpX1a5tQN2dEESee31DyPmnXlFmmvSJK9zaC52ovp4g=;
 b=f9S9paFC6lSOURgkLUZPpjSxJrH1OhzpNWJnu65tGJrOHptLOpHRyRof6MD5mO7aI2FyQPfUMlBeXyqb+rQoA5XaAYYigb9fUdlsEs4YrOpihQeS3401IsqV52qfU8joY/pYEpvzQUwlyy5QP3HlGUMb5YFP0JPQW3tyPCbdYN7PbGtEqUaU1QeK6EEhc0mZ30zN7Q7YCRnWfzLrM52lIowOwEzRyc6M0ctx8feDSfgO5eUoVwVOS2rE74TNmxAJfEuW2091Blbn18PNQyPUbIZ/5Vpke4lPQv1S1zcAvf3tChTjS9/Wc/7ao24EYFg5xnc3GadKU+NzfqQ7yqOa/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpX1a5tQN2dEESee31DyPmnXlFmmvSJK9zaC52ovp4g=;
 b=h9uGzwAc3cTh9S3704Q30Tf+Ioad9/+0fooTbx8TGO6YP/enaEu4Xv5DTFgIIkT3TnwSejHm70nuR7U+G2E55eQh0wME4Il5a7jOQeaLk07JpMpqP8U5K9tJT4bIxgEFCJgLysGkeLz5QYkYQzRX1NVVwLuc3QDMQappXJPRkjY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 13:01:54 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 13:01:54 +0000
Subject: Re: [PATCH v3 0/8] Implement generic cc_platform_has() helper
 function
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <bde05ba8-c1b7-5df7-4147-44c38f4f3acf@de.ibm.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9b343e40-d892-b556-c5e6-fa46fae61079@amd.com>
Date:   Thu, 9 Sep 2021 08:01:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <bde05ba8-c1b7-5df7-4147-44c38f4f3acf@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SN6PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:805:106::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.3 via Frontend Transport; Thu, 9 Sep 2021 13:01:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe46845-74d6-47a5-a65c-08d97391ff27
X-MS-TrafficTypeDiagnostic: DM4PR12MB5279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5279A7D3B874B087A509A87FECD59@DM4PR12MB5279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8azszEYDBgIcFSiw1oNOvgD7E1IhXES5E6w2h5NgETx64gpCnDg9zvbnQB9qkb4yQd19JI14VVRqKEWfjnYsHpKemszYNEDyq/9cQ4X9py2ZoMa5iuDLYA3Os+QHnOp9T8hK2a+UdOIMyWH6S4ARpJxa7RR8edpOCCDaglO+UcKLOJsHoDrw/6sKsnoDpDLWF2uHtUPEQzXrJNXlICAJfG6mGNQi8vQcXdd4kjegt0nKOsLZVrS5KZqF4SSCmJYiOugNe6YZLG4c7Y9F+dvyltd7gt2agYFH7Y9hObsDhtki1SSoG+TK0ckBmZfZ34UIQ+rP6gb3TuwOydJrSbSYlzAJQ17DGg16NS+9oQocedMY9wHwR4DaVZfrED2IOaTaV9ueHCUkEnPiUcU9PP5DyvGXmSofkJn9pcBrMES9/Bxm3pRgZyGchK/Ncy3cR1crCLICHnfECzwXM6Jio1DSYdDSW1BwYINArbeKe0ok54Ny3Pe69K77UbgvYcQeFQkjghksiYpP2+TGiyqfmiHfjjwzIE4EEkOEaDvPag+JFxeZASGherqFGZStf42rr2/RWI9xFv0FSI9Gomcgg9JQi3P5tLw7MejxAi0xlCCM0MINvwmKuR8rzF/xD5IQS8e5y+4EpKqJmoTVS3cZxzAq9kvMdAZ+dvbhpZjhdgoXGAFr7und1HYPk9AOk1HDn6xkN57pgEfGxwfVOSjO1YlOmQH1pEp5Jrca+puHMOh8HZP3JL1gHPjvMPSOoezRv09Z92FGPa5gMtvI2XrO0yAXFUtHYttFZY4gYifuQPRffBkt2AcFqQ0WoKrQNbhTzcaJgQjZe9KmAYLSJktWn/EVEQFit2seosGRO5S5LOk6ppQrP9w+DXnuOeu6CZaYyy6Lno7thwqlcagGienEwrB2wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(31696002)(31686004)(86362001)(66556008)(66476007)(66946007)(8936002)(921005)(38100700002)(54906003)(83380400001)(36756003)(316002)(53546011)(2906002)(16576012)(956004)(2616005)(26005)(186003)(5660300002)(45080400002)(8676002)(966005)(4326008)(7416002)(7406005)(478600001)(6486002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NCenA2RzlrWm14QW9qN0dENUJsZmFuQ1ZqN3NtT1dEcHh0eEhRUURtVUpx?=
 =?utf-8?B?Q2JHZ0wyS05wN3JOZmlUUXdqNkJ4cWlZU3hGSENBbnR6L01SbWNpMXNlS1Vw?=
 =?utf-8?B?RHg2YldiWDduV2RpdmlZaTZHU2x6WGowM2FELzlNK0V0TjVCcTlmamZCMUo3?=
 =?utf-8?B?ZWI1dXBGd09LQjBpTU9JTHZrSSsxaGxobkFnZ0pxM0NZRGthSVpyZGhWZzNI?=
 =?utf-8?B?NGpPTnY1V0pGTzdJanIycThsMTNWaS9XYnZWWk8vU0ZldkIxVW5nMEl5NkNL?=
 =?utf-8?B?SWw3L3hIZXJLTFo5NUN3ZWFYMnFYbXhONUd1WDNaMnZjSUh5bWtYcUJ3WlpR?=
 =?utf-8?B?QnYxelNtQlU1UkxIQjJGYUh0Y0h0YWR6QU9nWHpYN3hXTmJ1dThKNFEwOVRK?=
 =?utf-8?B?dm1YN3dOMVRpOFkxWG9vN3pZb2JkOXFwL09ia1M1Q0JacWVDK082bWVvSnVq?=
 =?utf-8?B?MGxjbzRXTWFVak1OWk5pbVRZL0ZCUWRmR2dkNmhwRW12VUFTeUtCU3gvNUlN?=
 =?utf-8?B?ZXl2YnFkRGNteWFmMWdRNHlVa1N2akxXQ1EyQXY2alRLOW1FeFFCbTZsYjJl?=
 =?utf-8?B?bzZ3alNPYXVPVEhMTXFPb3kzVmV6aTJGSGw2NE5sZ1RxbFUxNnArWVpDWmJt?=
 =?utf-8?B?UWhoOVBESldRSjdGZEZTRjZvYno4V2JyWFVNNXh1UjNzOXZ0TzZvTjFqQk9E?=
 =?utf-8?B?b1d1MnAvU3lwTGVQZlIvalpkMmxrdUJvdXBvR05UMDd5RXBRNVJxQnI4VFA3?=
 =?utf-8?B?OUh2L2NmOE03TnU3V2cweCthQUhYN2tyY3BqNXArU0EzbjVkQUozb3o5K3Jr?=
 =?utf-8?B?WGZrQUkzVEpqcy9lUHl4ejB6dk9CODNJdUwzVUpvTHpEMFF1VlpZTlBuU3lh?=
 =?utf-8?B?cWUvc1pLR25vcXoxbEowVmNUNTRkSWNQWWVIbWVSbll0N2lBcHIzS2UrcVE3?=
 =?utf-8?B?NWJQRVg0MnA1SFczUzEyTkVoZWNrNmhnb29BRWx6OVkrUUNUcUZCd1RaaTF4?=
 =?utf-8?B?MFdIbFZxb3VKV1dmdUpmaldPYjNON1UwcGx5OWdKSWFwdGdWdU4xTWJzT2t0?=
 =?utf-8?B?QzdkenltODY3MjhUVVNrZzZxRGkwdW5CYWdDdUhiTDRnVFJyMFVlZFBMVXVI?=
 =?utf-8?B?d095R2xENm5oM0NYbnI4SEUxOFVjOFN2TzZmcEN0Q2wyQnBvSmNFMk9iWVdX?=
 =?utf-8?B?Nk14TTl0TFJiM1NmOElmOXVMVXhIbXhldGdydDNaNTRNMTloU0crQ0RrYjRx?=
 =?utf-8?B?QjJJdEhpTjZ2SWgrK2xYUFplTlJQUHliUFkwRUhZK0EyVUFnYjJMY1FLcCs0?=
 =?utf-8?B?OWdLam8xWjcxbXZ2NWVoT0UyZE93aUZ3aTkwU3pyaFlmWHJRMyt1UmVSQ3lT?=
 =?utf-8?B?aXhHWjlOckhTRng5R1BTNGFUNysxd3ZzZ0JBbHNUUUllYVFLcmU3OXU0QkdQ?=
 =?utf-8?B?TGxCR0VMMnRGdXp4bkhrV0YzK3VZK0RCWDlUdlRVNS95UnIzRC9tSmd6N0hO?=
 =?utf-8?B?ekRQQXlpckJVZlo4ZUxTRmpBRDErcmh2bDFOWFcvVytxL3Z2WnZXR2Y5OXJv?=
 =?utf-8?B?a1djcERWSGpFQ3hZTkU3d1dhcmVRN25nZmY5a3VnSGlaeU9jRENxeEVsSjd4?=
 =?utf-8?B?dlBIL3RqNVNKeHhoNnJOclRKVHF1NWwweGNqamxpOUhIN3o2YXErbVhRSkZC?=
 =?utf-8?B?L1FaQVl4bTJ1N0pENko0RXZCWXp4S0FOWEtBWXE4YTRVMHRJMnpHdXg0d1dC?=
 =?utf-8?Q?A2M+sJAvQGlm+uPvsG27j3t3H/XfZPzqwDPzML/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe46845-74d6-47a5-a65c-08d97391ff27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 13:01:54.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANZ57FOLue2D/RaeIjmO2WoLtLG51gGpPVQrrA3t7YDPLPRVgfHokrCbZywnjveuP8+/ExrGdyKOWUbE4yoOag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 2:32 AM, Christian Borntraeger wrote:
> 
> 
> On 09.09.21 00:58, Tom Lendacky wrote:
>> This patch series provides a generic helper function, cc_platform_has(),
>> to replace the sme_active(), sev_active(), sev_es_active() and
>> mem_encrypt_active() functions.
>>
>> It is expected that as new confidential computing technologies are
>> added to the kernel, they can all be covered by a single function call
>> instead of a collection of specific function calls all called from the
>> same locations.
>>
>> The powerpc and s390 patches have been compile tested only. Can the
>> folks copied on this series verify that nothing breaks for them.
> 
> Is there a tree somewhere?

I pushed it up to github:

https://github.com/AMDESE/linux/tree/prot-guest-has-v3

Thanks,
Tom

> 
>   Also,
>> a new file, arch/powerpc/platforms/pseries/cc_platform.c, has been
>> created for powerpc to hold the out of line function.
>>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Christoph Hellwig <hch@infradead.org>
>>
>> ---
>>
>> Patches based on:
>>    
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7C5cd71ef2c2ce4b90060708d973640358%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637667695657121432%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=FVngrPSxCCRKutAaIMtU2Nk8WArFQB1dEE2wN7v8RgA%3D&amp;reserved=0 
>> master
>>    4b93c544e90e ("thunderbolt: test: split up test cases in 
>> tb_test_credit_alloc_all")
>>
>> Changes since v2:
>> - Changed the name from prot_guest_has() to cc_platform_has()
>> - Took the cc_platform_has() function out of line. Created two new files,
>>    cc_platform.c, in both x86 and ppc to implment the function. As a
>>    result, also changed the attribute defines into enums.
>> - Removed any received Reviewed-by's and Acked-by's given changes in this
>>    version.
>> - Added removal of new instances of mem_encrypt_active() usage in powerpc
>>    arch.
>> - Based on latest Linux tree to pick up powerpc changes related to the
>>    mem_encrypt_active() function.
>>
>> Changes since v1:
>> - Moved some arch ioremap functions within #ifdef CONFIG_AMD_MEM_ENCRYPT
>>    in prep for use of prot_guest_has() by TDX.
>> - Added type includes to the the protected_guest.h header file to prevent
>>    build errors outside of x86.
>> - Made amd_prot_guest_has() EXPORT_SYMBOL_GPL
>> - Used amd_prot_guest_has() in place of checking sme_me_mask in the
>>    arch/x86/mm/mem_encrypt.c file.
>>
>> Tom Lendacky (8):
>>    x86/ioremap: Selectively build arch override encryption functions
>>    mm: Introduce a function to check for confidential computing features
>>    x86/sev: Add an x86 version of cc_platform_has()
>>    powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
>>    x86/sme: Replace occurrences of sme_active() with cc_platform_has()
>>    x86/sev: Replace occurrences of sev_active() with cc_platform_has()
>>    x86/sev: Replace occurrences of sev_es_active() with cc_platform_has()
>>    treewide: Replace the use of mem_encrypt_active() with
>>      cc_platform_has()
>>
>>   arch/Kconfig                                 |  3 +
>>   arch/powerpc/include/asm/mem_encrypt.h       |  5 --
>>   arch/powerpc/platforms/pseries/Kconfig       |  1 +
>>   arch/powerpc/platforms/pseries/Makefile      |  2 +
>>   arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++
>>   arch/powerpc/platforms/pseries/svm.c         |  5 +-
>>   arch/s390/include/asm/mem_encrypt.h          |  2 -
>>   arch/x86/Kconfig                             |  1 +
>>   arch/x86/include/asm/io.h                    |  8 ++
>>   arch/x86/include/asm/kexec.h                 |  2 +-
>>   arch/x86/include/asm/mem_encrypt.h           | 14 +---
>>   arch/x86/kernel/Makefile                     |  3 +
>>   arch/x86/kernel/cc_platform.c                | 21 +++++
>>   arch/x86/kernel/crash_dump_64.c              |  4 +-
>>   arch/x86/kernel/head64.c                     |  4 +-
>>   arch/x86/kernel/kvm.c                        |  3 +-
>>   arch/x86/kernel/kvmclock.c                   |  4 +-
>>   arch/x86/kernel/machine_kexec_64.c           | 19 +++--
>>   arch/x86/kernel/pci-swiotlb.c                |  9 +-
>>   arch/x86/kernel/relocate_kernel_64.S         |  2 +-
>>   arch/x86/kernel/sev.c                        |  6 +-
>>   arch/x86/kvm/svm/svm.c                       |  3 +-
>>   arch/x86/mm/ioremap.c                        | 18 ++--
>>   arch/x86/mm/mem_encrypt.c                    | 57 +++++++------
>>   arch/x86/mm/mem_encrypt_identity.c           |  3 +-
>>   arch/x86/mm/pat/set_memory.c                 |  3 +-
>>   arch/x86/platform/efi/efi_64.c               |  9 +-
>>   arch/x86/realmode/init.c                     |  8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  4 +-
>>   drivers/gpu/drm/drm_cache.c                  |  4 +-
>>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          |  4 +-
>>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c          |  6 +-
>>   drivers/iommu/amd/init.c                     |  7 +-
>>   drivers/iommu/amd/iommu.c                    |  3 +-
>>   drivers/iommu/amd/iommu_v2.c                 |  3 +-
>>   drivers/iommu/iommu.c                        |  3 +-
>>   fs/proc/vmcore.c                             |  6 +-
>>   include/linux/cc_platform.h                  | 88 ++++++++++++++++++++
>>   include/linux/mem_encrypt.h                  |  4 -
>>   kernel/dma/swiotlb.c                         |  4 +-
>>   40 files changed, 267 insertions(+), 114 deletions(-)
>>   create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
>>   create mode 100644 arch/x86/kernel/cc_platform.c
>>   create mode 100644 include/linux/cc_platform.h
>>
>>
>> base-commit: 4b93c544e90e2b28326182d31ee008eb80e02074
>>
