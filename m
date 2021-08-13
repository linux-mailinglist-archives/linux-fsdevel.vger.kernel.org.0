Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490213EBB0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhHMRJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:09:48 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:46433
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231602AbhHMRJs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:09:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7h9cEa72/P/Z/VtiliY8vYqmsNze6YaEjbj40NlKqyU32cToOYk1F3hjKipqb8S8qCM73S1DXAcoDU819ugr2h6jNWmL0apyxqa0xudm3f3SCgxRLGvxXlhHiy0dSj0rkB5hByk8THe4LvsEct+rHBCiwJirBmvb51TtlC7FLVDYkzvRRmsY1lslXkgXyuhwwAvM7eQTwPaRfN8j+ifOBNy+j2m55nE0+pufj7TCqhUFl+uztz5UDMMQI1v2ifiGK1geEoo06PvowMsLrU9XGjqsIN5OUj9cE/h39GLknj3zYbcSQt/qpe+s03ZViBbrBEDPH7EZ25tXfXoYWEHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Oux9q7Lp6wTWTOZ5u3rsrrwsvPKJtDqU4/5IhYig+k=;
 b=bAw5qhpycdPLllJdjNHYLcfw2UBgJ3GqHKda1+QXDSb9+f0FvT9F66z2Nf0dy0/nDgpfHZFamkhwtugzG5O2qcSqX0vsD8oC69uSIU5n/qSvM/McxCPDYMHGT9/fdt5yDk9oeIWqQWdE/EeYPBDbDr0Dw5rYfPrJEkGaL0eCmJ6QbewAjRx5/iMZYN3BRUY3fmjL3FMK/nF9VV6eR2JW8fUQZtoM+BzUiQAOYs6vR8Mzej3zazK+CFiilJQtV6mENf9LVEUEhKqzz2GcnR5rwJ5ykWO403mPv0x7LdQUOg7slFiC+m1nhAHrhcm+OmyCbVOGTp29T5KnDT5u0EuQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Oux9q7Lp6wTWTOZ5u3rsrrwsvPKJtDqU4/5IhYig+k=;
 b=hNxz02+dfT3jAz1uT+MXQ2eeAalXdF4cDQOEO6RPB3jG6LdVLQZ5OPxwACeQ3FoGAO+lQDVd5ZrsQcPmHWmmIWPcBCiOUPvuRz86mfXaGM0YELPI+d4Wp5JO1ZQK77rGZtCtgKM1tvo/Ngyf3STzn1vp5z5hSueJdYUXSFOHDBE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 17:09:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:09:03 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
 <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
 <0a819549-e481-c004-7da8-82ba427b13ce@amd.com>
 <20210812100724.t4cdh7xbkuqgnsc3@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <943223d5-5949-6aba-8a49-0b07078d68e1@amd.com>
Date:   Fri, 13 Aug 2021 12:08:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210812100724.t4cdh7xbkuqgnsc3@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:806:28::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA9PR13CA0157.namprd13.prod.outlook.com (2603:10b6:806:28::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Fri, 13 Aug 2021 17:09:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50889268-2304-4264-f1dc-08d95e7d0d28
X-MS-TrafficTypeDiagnostic: DM4PR12MB5344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53444D5E8E6C3632AF33E92FECFA9@DM4PR12MB5344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q63veiVi9Sd+d5FxVHDqXmQrNFjPeMriTBiUPjzpEXdDLMyhuXi8KWcHxW7/UucnVh83s+milQzv3+iqqvLtYUgYayIT7ww/ubkUcGfrsRWfJViKJWIAb3tiG86XVhRtW8+aqZhLs9oTUVPi5jCX8oqbZ8ELzuY3ztB7Wy7Cj/tMYdBiMJtx7keiPVKDtQCJs4D1dCbrwZFqjLp8FjHoEYvvjUQP0iTyGJrokucNOQRCJZ0n22WwvpIcJAy+8H9n6quKBXw6gkgjy1ybayInuZ5+V1svrmUMut7qRwUuneZUnqgW50Jcmx8Knfl/lxYJI1GE369ENoNMoWmruU4Ql9zGIxLlasAsQu2Dr/FIDzrw6s9ZI/GJm+uoyaJr9CCiMv1Py2zlw2wvBG2BrTEnsAPcNcH28F5YIMl5czSMGOoJtmZstS96wnCAv/ORKycOut7XaPdugVLX5QM5MGeKs+0lq1t/Fbx0vnLu3F3eiHj79n1cIiE/T2GxwDIMfV1BXnVMXh0CRsqvY/bF/6UFnzxtrBbo307UO3rfzDtxrTWEchnQ79dQizP6/2K6AuC8tVoR3JG0CH66yj8jEb/2kpXtjjTLXUR9FvmPAA02BvsDu6c6kzydm7MMOylM6QomUUYb6RiSg9OlOaCa2U2ZSbo9whUXnGq3PPO48zQLToNksr7sAJ+iM+lZhWNvrfIhEHexeGooQjmxlFbat6z7aRU7sAc2s7uGQMyzwjTFRg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(86362001)(8676002)(2616005)(5660300002)(31686004)(54906003)(2906002)(38100700002)(31696002)(6506007)(36756003)(53546011)(6916009)(6512007)(478600001)(8936002)(83380400001)(4326008)(7406005)(186003)(7416002)(6486002)(26005)(956004)(316002)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3pETFlsM01tdm1WMEdtdUgvcUExSkROM09LWXcyS3ZyNVJjeENabnJEcmV2?=
 =?utf-8?B?aDhNZUM2QzU4ZGkyUUVOSVdzclZRdXdGUDdHYldibk82bHpZeHFFYmxDVmVR?=
 =?utf-8?B?dEx6bHc5MEVjd2FnaGJ3WitHZzJlRzZyVzlhamhzSWtBVlRkVFBQWmZ5UGxr?=
 =?utf-8?B?V3hCNk05eHZtYkpET2k1MGlOMTdQeTg0MU1kU0kxLzlmeG83NDhvME5FMzdx?=
 =?utf-8?B?TjFpZEJWcmlNY3hwOHNyRUdjTWdIL1RRWklYZmlZMTRzenBsZDJCWVNLeWIx?=
 =?utf-8?B?aGgwMTNxNzdob2lDTGdFcW5ZZ2Fod0pHT1R6akRTMlZURi93VktEMzZvaWhM?=
 =?utf-8?B?eUFXMFdDeWplVC84dk9CZjJmZW1GT0EvYi94WVAxS09kTXhtcFlQU0VwdVpz?=
 =?utf-8?B?eTBlQ2NZLzVEYzloWlVZUVBYem1Sb2JYQStNRkF6WHZBbXdVRmZvaEFUZDRJ?=
 =?utf-8?B?Um03bk84Mm41NWhNd3FVSGxkMHBycno1OElDalppdXdpYnpWajVLZzNSbnNm?=
 =?utf-8?B?NnVCK3lpNWJuVEIwS1h4dWw2QU82UFI2dnI0NDJqYmVyUjczbWlyZnUyV3Js?=
 =?utf-8?B?bXhkbSt0RDNWcm1hRFphQVg2SlV1NWdJVFZSN0FQNVM1L0xQRWdtVmpZSTJE?=
 =?utf-8?B?ZTVJN3llSXhveWxWSGJrVTNjbTNxMWwxeXVnNkZmUEE1NEE4SDA0enNWVEhu?=
 =?utf-8?B?eGJlYTU4VmV5UHpBVXZWQUd6WVhjK09zSFRyelpQeGlnTVZ3NU9pU093VTJR?=
 =?utf-8?B?ZTFZbSsvR0VxSi94V0JKVDVDdytRU01Qb1BSaVBQN2VZSGNRM28rYVpGOHAv?=
 =?utf-8?B?KzZTdnU0RzYxODE5MVpRb25uR0poRXhmTHV1SW13M1Z6S3lvQVd6Q1VuWDIv?=
 =?utf-8?B?dWtLcDFiZFkyVUQ1Y2pGa1BvZGlIS1JpdVJMWFJzaEZlN2hGRVoyejErQllU?=
 =?utf-8?B?YkhhRFhEL1pyMFZhTUlpc3p3ZU9jT1QxbU5LTjJ5SWY1dnJNWUlIRVdFTnZw?=
 =?utf-8?B?WUIrQ05xQXQ2UkZDSDlVMXhqS2pINk1Icnc0c2gwZUs2ZEtQNVlpUDVtRitv?=
 =?utf-8?B?dkQ4Zy81VStWU2x1YTRrNjlCRHV4Uk1kN1BXNTRvUnpKeHprNHorL3NBTzNY?=
 =?utf-8?B?T3lHVis5WC9WV1BmdE9KSHRxMEtrakV5K3ZubkhRYlM3cjE2ckovYTE5VEIr?=
 =?utf-8?B?YnFXWHd4RjNuUmd5VFcydVdTaWpQNjFWVENsLzJ0MGlQcjV4NUZ5eTVDeEt0?=
 =?utf-8?B?R09Qd0hLTUkrSE5Celhucm1WNkF1NGl2MmVzYTEyeVM0aGpKeGdPcDlWZEFG?=
 =?utf-8?B?T2Y0RTh5YXh5OTlXbWI1OGgxd24wMS9zN1FnelpnaGVhdUt2bGtLUVBhdy9u?=
 =?utf-8?B?b2gyZWFFUnVnZTZCZVkxaHB3aklMR3dpd3ZZbGhmT1JIak1JT1hzZCtBMmhB?=
 =?utf-8?B?bklyR2VMRHJHeFNJeXpvR0pwU3FGamtSRlJpMy83dUJjaWRyS3VZN011K3Zm?=
 =?utf-8?B?bE9IRU40cUMrcDcvNlpSSmJSVDNGbEZHVE5hMlVxcjJqUXpaMFRuRUdWV3FY?=
 =?utf-8?B?UHl4K3BabVRSakw0V1VtbVU5THp2MWU1V09Cb3Z0MFQ1dUFCZjh4eHFGbys2?=
 =?utf-8?B?a2x2UnlNQmY1emttd3pSNmowaEFNZzNaOVE2Vi9lYndQbUpYTFg0NndFUTJG?=
 =?utf-8?B?Zkw3ZEpGSkl5akREMUVZd1VXcjZYRTM0VUtVTHNYQk5lWEtaTlRvK2VyTFZL?=
 =?utf-8?Q?xPclah53KtKOSImQbvJ5QZ5voq8Am7B6fErogyk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50889268-2304-4264-f1dc-08d95e7d0d28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:09:03.5929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: its5y84wE4atTYo1NDVSaH7SF7GU5qqBNtjEwyCJTBnY3K7m3SwYCf2Gp8qYKdn9AGpktMFWQT5x9dIC+X30Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/21 5:07 AM, Kirill A. Shutemov wrote:
> On Wed, Aug 11, 2021 at 10:52:55AM -0500, Tom Lendacky wrote:
>> On 8/11/21 7:19 AM, Kirill A. Shutemov wrote:
>>> On Tue, Aug 10, 2021 at 02:48:54PM -0500, Tom Lendacky wrote:
>>>> On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
...
>>> Looking at code agains, now I *think* the reason is accessing a global
>>> variable from __startup_64() inside TDX version of prot_guest_has().
>>>
>>> __startup_64() is special. If you access any global variable you need to
>>> use fixup_pointer(). See comment before __startup_64().
>>>
>>> I'm not sure how you get away with accessing sme_me_mask directly from
>>> there. Any clues? Maybe just a luck and complier generates code just right
>>> for your case, I donno.
>>
>> Hmm... yeah, could be that the compiler is using rip-relative addressing
>> for it because it lives in the .data section?
> 
> I guess. It has to be fixed. It may break with complier upgrade or any
> random change around the code.

I'll look at doing that separate from this series.

> 
> BTW, does it work with clang for you?

I haven't tried with clang, I'll check on that.

Thanks,
Tom

> 
