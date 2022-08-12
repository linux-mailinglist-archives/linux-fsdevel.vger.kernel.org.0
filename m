Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0649590BBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiHLGCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 02:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiHLGCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:02:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504A474C9;
        Thu, 11 Aug 2022 23:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjUu8bdpxisjN/yM9rGHuyO+TAm4drf8JoeFDQdIEn8abq1o1Hw6J8uaVyd3boabbRXE1DhHtAuhlcoN95QgIqDh+U4EGgTsvvD4s7zc6UShLIQ9a+8nJ3jtT//vXkB6WKRxcVZPBsy1MVb2dwgsc+iug6nr49unFiJ9BLvr9NmTPnrkJerJzuIQCM5/u7nmMG/qAtxQEZhw8G1ozWBebqwweuZNCqkTDsR/stSx7BSjdTcDBHipgRzIbnHLxKetnpT4+Z7AGZ+THF/QqL40VyAtWK87Q1f7b5eJvbkTgSx975cEaZB8NgqEe/5ol7CWhmSf4TaOjtXe9NQrH29mBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+j3ry/HYXAdLfOzgaMLhGtdkK6KMNi80bN2xPWOIZc=;
 b=Pk6h0CTGQUsPdXS4y7ptfV0ApdHhBopdEUlc+sOfo1uM+U+D77RmHUekA9ALTIHB4zdRGC2RluzIgML1sGjuCQNSoHox4fx3yBHuzYg4kDS9F5CO37hYYpRB8tu3lI0I30Hev5QQd1sCmNrkZnAoAENbhUte4R1v+ciytikOLDdF9FhoAThe7FinAPF/pjogVlmIBBqD2coyzZs4ZEc6l3yUzWfFkMJhxiiC1Lckf2UncdoDXT5pxCtvFnUfdgG5cPIXIeD5aSvCqzzYmW2DCZkR9ycIqWFkfjma6qKjizekYoCvBVQFBawRBlTeg57H02IGK04PMm9879vN3gptig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+j3ry/HYXAdLfOzgaMLhGtdkK6KMNi80bN2xPWOIZc=;
 b=3kHu+ALSOwWkL+KjY1wv5FbNpjInyD7902NvHctwTBuwH1aoGVQmtNz33T1gZtmuGp3sl8dD9k7a8Fb/iWsxMh4mdFluVaNEdo+VysGwmUSU/L8Dni0lvSc0Uwnr0SWQ09gnu36KMVmTc4XL1xdxhxnP1pjo1seJOqe0VdmXuXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by SA0PR12MB4383.namprd12.prod.outlook.com
 (2603:10b6:806:94::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 06:02:38 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5504.020; Fri, 12 Aug
 2022 06:02:38 +0000
Message-ID: <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
Date:   Fri, 12 Aug 2022 08:02:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, bharata@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
 <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
 <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
 <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
In-Reply-To: <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a565cd18-4ca1-4672-c4f8-08da7c2841eb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgVftd/usFJWQ3pcGHr/wxaTkOlr95uDC0uZWz4facfuG/qAkzPlSqtiONY399IidA1Hzp6CORGkwp4SBj85+zOBltOKAELrzNexu11rq85bWjBnghU6fGccFnGozQtyXjTnXt6OiUSpT58dWUVILyTxn7gF5havz7Cs76V4HWW0H9Ms6mzm4EM13pDTpTIb2CmYPQExWx1eEfGHX14pp7h6YNUOMgWRie3zIm25jNnIh71waYxSkE0iuKaXU6Wu0M6S/hkZP/1BbPwOuiB2EHp4n2hpgd3La5mAoEeK10JHUed5sM/VEIGnJiS0eGPjd5wpZn/DzW33fzmhIyIyI2npMjzHodTSM+x21fQ7rGqixEXif/xX7cEkcfJ9UJgADh8lk/tbNRaEzLmT/RCIxTA2KAlI2zZwZGK9qNIylHe18aqCCkDOZ7i6AUw5e4IsqkDQTviGAzydzYwjiFhI85xJDq+/xoH5a6CbnxsfLdZyOLvM3spujfpCTVwuSfSpty0uNkJKJfFuzYWp4/CfJWsEeKENTLwiTSDb/MGZcIhyfjpXPXY/Hjh/d4jlB0K9mo1VvzhC8siIh9jKrwHc1uQOIsb6W7u4eLmfvkR9HZtn0oiM7Ar6QeUetPdSAgjwphPdX/uopCv5luh8FerSDK3hfMVICrlancp8iYvXLALGzxC7Rp0f70ufpazmtgKjeYTg75mxkdmjM+ALka0re0gHcG0D9xzIKzor+zFdHawAqRZPuOKSBox/2W6woPufPgipOm0TBvV/6ROTphXYCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(186003)(41300700001)(86362001)(6506007)(2616005)(6666004)(26005)(6512007)(36756003)(83380400001)(110136005)(31696002)(54906003)(316002)(4326008)(66946007)(66476007)(66556008)(2906002)(6486002)(5660300002)(478600001)(966005)(8936002)(8676002)(7416002)(7406005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEc0NHRqQ3dwRnJwOVR1MEJvMERQWUt3WW1ScGdhSEVBN3VVNy9OeDZBZlVn?=
 =?utf-8?B?YkI3WjZwdHgwS2UvVk9ma2RrUytaRDFDQUs3eGNFL2ZxdGNLblJicDBBYStt?=
 =?utf-8?B?VU1SaC9MWCtKSmlnSmxLdUFDUkFHMk9mYzlVSEphNkRpSytyNjNNT1N4alJh?=
 =?utf-8?B?bnEweTBNZDFmS2xybnlNakdwZU1vK3NGZTNTVWRKR2RmOXRIR1JNVVZ1eXB1?=
 =?utf-8?B?NVUyVnN4aWRYQy9PMTFqRkJHNzBQbXBiVWkvVzdIeTBUcERJS0hhc3A0Z0ky?=
 =?utf-8?B?SUZ1cDNzNDZVc01PN05WalZSL0JTdXphS3h3MEhieUxBbzRDeXZMMUlQeUpR?=
 =?utf-8?B?ODcva3NqN0VnQ3ZpeWF6NFl0SG1VTUhKZFlBUWp2MFZGbFgwZ1czZEZKTFBl?=
 =?utf-8?B?RGRPUjFuQW01aVJDV0hQMFVOb3FQTnZuTnVwcXQyVnJLTVBTZnBqWGJzTDA3?=
 =?utf-8?B?dFYxMjBoZTJNWitldS9wK1ZtazlFR24veVZFc3pFVUlzNFFxVDFPd05tQmx1?=
 =?utf-8?B?L0gvWW5iUE4yUGc2ZlRGelpVR1B0ZVVSWnN1TkRxQlFqNG9Ic2N0UlBjU1hM?=
 =?utf-8?B?YWg5QkhUemVBdHRzdlZmWFJBaW9NVHM1c29pb1RnWEZjWndtUjZuMDA2Y0pU?=
 =?utf-8?B?V3VvT2gzSWZnc3llVUJ2UWd2L3RsOGxLbXJzaVJVcmx1Wmw3NGRwdmdGNVZi?=
 =?utf-8?B?S3hYeWordktsdHRPTUtiWkt5YzdZaHd0dnBuWVEzWDBRQWdCQ0xRbFNzV2pn?=
 =?utf-8?B?bm1rZ3dzQ2c1MExQa1FPR21kUm1sZ29jMjhQRlRkaUN5OFBBdjV2ZGR1b1gv?=
 =?utf-8?B?eWtBYXU3bHEvU3NvQ0svdlo5M3FqYjMzdlRRMlY4WXpwMGZFbjJtVzlwaXRt?=
 =?utf-8?B?STcwQUFSQStCdTlrRVdQVi83aEo0Tjk1dGR6SWM2R29Tc1c1OGRuZzVCWEFn?=
 =?utf-8?B?NUloYnEzNkNUaVFpazNwcHpqQzdtOTVMUXNRdHJOU3VsK29GY3BmdW5Bdmsx?=
 =?utf-8?B?aHpsbUVyellVR3pXcjFxWU14alV2cU5qZllGTWN6ZUwzRmozV1N0bHJEekU2?=
 =?utf-8?B?OXJDYmRndVVodTJjZXQ2dXI4U21Ia3BSOThxZ0JnekFTanNaTWt5dEovK1lv?=
 =?utf-8?B?MWkxbUl4dUdQT2VZQmZTNFdBcU4xY01QeWhOSUpDVXpEaXhONDZRdzFGSExn?=
 =?utf-8?B?MzhuaXN1NU5Ua3JSRDJZSUtHNWoxbGpHMVZKSU95TzJnbkpkcko1NW1PaFY5?=
 =?utf-8?B?eHpFNG5BVEZ5UGZsek9VaHFHMG8rNG0yL0FqT0FSZmduckZMZlRrQittVS9k?=
 =?utf-8?B?MlNocU9Ydk9WdkZwQTVJTDgvalpHaXhBcDZHUDIvM2EzbllSZmhTUUxXU01W?=
 =?utf-8?B?R3htT0xHYnlseU1TeXhNQzQvM0puaUdSOWVtcXVpcnV1TFVzYkdVdXc0NS9J?=
 =?utf-8?B?K1Yyc2ZVeGhOUUdyWEZSZmR1TnZXMDdpUzhGQVRDT0tYM1dZNnB4eS9pQzl3?=
 =?utf-8?B?RmFSbUMzazBLZ05nUDdIK1hxTjRPTHZ0Mk5KaVdiblFpTWQwcmg2dmEwZzdn?=
 =?utf-8?B?T3pSMXRDNDRaN0pMYTVvMHZINDVad1ZCbjZraUN2YlFCeE1sVjhTL2NqWG9T?=
 =?utf-8?B?cGwvdXd2MXhPZVRJc0FnYlhlbVMwaTdnUUtNV3NDcDJTZ3pJbEEwOFU1R2FE?=
 =?utf-8?B?MnRoeU1tc09PendPN1pFMlBzZ0xSaVBlSjh6aThxTUw1ZWhjVm80b2pZODFt?=
 =?utf-8?B?alFYK0t3ZzNybTd0TWwyZ2Y1RW9tZFRIN2ZkUGtBZlc4UnVhK3JkckZiazds?=
 =?utf-8?B?cDJrUS9OSUQ1REpuOTRQanBxNFZnQjgycCsxRHlrY3JHNTkvK3JPVm1uUlp0?=
 =?utf-8?B?U201aTVuOEtna1Z1TDh2RDRnNko3YkNKYysxamtuTnNFYm8zZkR5S1cxeDIy?=
 =?utf-8?B?N1Q5U0N3U1hYNmF0cGZmb3JLakYzempkQWxqVTdLY2NFVVlPVHFqb2VZaGMy?=
 =?utf-8?B?TzlWOTBsMHJsajd3dnVxYkxWQ2pSWGVwOEtlckxqbitzZmZyWFNyOXFHamw4?=
 =?utf-8?B?cjU1K2xFajFmaWwyZTJuZ0NxRnFSQ3hNNWc3SGp3Y3I1blVtNzJCY0Fxb1Rv?=
 =?utf-8?Q?Rbsg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a565cd18-4ca1-4672-c4f8-08da7c2841eb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 06:02:37.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiWooUSidBs9LZPUxTuJU0muLpACZhZgzfwjVonSKVY+46DW3J3ODlybwHzqHlXplbr+GVulBttmrGLYTGXvUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>> This is the v7 of this series which tries to implement the fd-based 
>>>>> KVM
>>>>> guest private memory. The patches are based on latest kvm/queue branch
>>>>> commit:
>>>>>
>>>>>     b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
>>>>> split_desc_cache only by default capacity
>>>>>
>>>>> Introduction
>>>>> ------------
>>>>> In general this patch series introduce fd-based memslot which provides
>>>>> guest memory through memory file descriptor fd[offset,size] instead of
>>>>> hva/size. The fd can be created from a supported memory filesystem
>>>>> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
>>>>> and the the memory backing store exchange callbacks when such memslot
>>>>> gets created. At runtime KVM will call into callbacks provided by the
>>>>> backing store to get the pfn with the fd+offset. Memory backing store
>>>>> will also call into KVM callbacks when userspace punch hole on the fd
>>>>> to notify KVM to unmap secondary MMU page table entries.
>>>>>
>>>>> Comparing to existing hva-based memslot, this new type of memslot 
>>>>> allows
>>>>> guest memory unmapped from host userspace like QEMU and even the 
>>>>> kernel
>>>>> itself, therefore reduce attack surface and prevent bugs.
>>>>>
>>>>> Based on this fd-based memslot, we can build guest private memory that
>>>>> is going to be used in confidential computing environments such as 
>>>>> Intel
>>>>> TDX and AMD SEV. When supported, the memory backing store can provide
>>>>> more enforcement on the fd and KVM can use a single memslot to hold 
>>>>> both
>>>>> the private and shared part of the guest memory.
>>>>>
>>>>> mm extension
>>>>> ---------------------
>>>>> Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
>>>>> created with these flags cannot read(), write() or mmap() etc via 
>>>>> normal
>>>>> MMU operations. The file content can only be used with the newly
>>>>> introduced memfile_notifier extension.
>>>>>
>>>>> The memfile_notifier extension provides two sets of callbacks for 
>>>>> KVM to
>>>>> interact with the memory backing store:
>>>>>     - memfile_notifier_ops: callbacks for memory backing store to 
>>>>> notify
>>>>>       KVM when memory gets invalidated.
>>>>>     - backing store callbacks: callbacks for KVM to call into memory
>>>>>       backing store to request memory pages for guest private memory.
>>>>>
>>>>> The memfile_notifier extension also provides APIs for memory backing
>>>>> store to register/unregister itself and to trigger the notifier 
>>>>> when the
>>>>> bookmarked memory gets invalidated.
>>>>>
>>>>> The patchset also introduces a new memfd seal F_SEAL_AUTO_ALLOCATE to
>>>>> prevent double allocation caused by unintentional guest when we only
>>>>> have a single side of the shared/private memfds effective.
>>>>>
>>>>> memslot extension
>>>>> -----------------
>>>>> Add the private fd and the fd offset to existing 'shared' memslot so
>>>>> that both private/shared guest memory can live in one single memslot.
>>>>> A page in the memslot is either private or shared. Whether a guest 
>>>>> page
>>>>> is private or shared is maintained through reusing existing SEV ioctls
>>>>> KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
>>>>>
>>>>> Test
>>>>> ----
>>>>> To test the new functionalities of this patch TDX patchset is needed.
>>>>> Since TDX patchset has not been merged so I did two kinds of test:
>>>>>
>>>>> -  Regresion test on kvm/queue (this patchset)
>>>>>      Most new code are not covered. Code also in below repo:
>>>>>      
>>>>> https://github.com/chao-p/linux/tree/privmem-v7
>>>>>
>>>>>
>>>>> -  New Funational test on latest TDX code
>>>>>      The patch is rebased to latest TDX code and tested the new
>>>>>      funcationalities. See below repos:
>>>>>      Linux: 
>>>>> https://github.com/chao-p/linux/tree/privmem-v7-tdx
>>>>>
>>>>>      QEMU: 
>>>>> https://github.com/chao-p/qemu/tree/privmem-v7
>>>>>
>>>>
>>>> While debugging an issue with SEV+UPM, found that fallocate() returns
>>>> an error in QEMU which is not handled (EINTR). With the below handling
>>>> of EINTR subsequent fallocate() succeeds:
>>>>
>>>>
>>>> diff --git a/backends/hostmem-memfd-private.c 
>>>> b/backends/hostmem-memfd-private.c
>>>> index af8fb0c957..e8597ed28d 100644
>>>> --- a/backends/hostmem-memfd-private.c
>>>> +++ b/backends/hostmem-memfd-private.c
>>>> @@ -39,7 +39,7 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend 
>>>> *backend, Error **errp)
>>>>        MachineState *machine = MACHINE(qdev_get_machine());
>>>>        uint32_t ram_flags;
>>>>        char *name;
>>>> -    int fd, priv_fd;
>>>> +    int fd, priv_fd, ret;
>>>>          if (!backend->size) {
>>>>            error_setg(errp, "can't create backend with size 0");
>>>> @@ -65,7 +65,15 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend 
>>>> *backend, Error **errp)
>>>>                                       backend->size, ram_flags, fd, 
>>>> 0, errp);
>>>>        g_free(name);
>>>>    -    fallocate(priv_fd, 0, 0, backend->size);
>>>> +again:
>>>> +    ret = fallocate(priv_fd, 0, 0, backend->size);
>>>> +    if (ret) {
>>>> +           perror("Fallocate failed: \n");
>>>> +           if (errno == EINTR)
>>>> +                   goto again;
>>>> +           else
>>>> +                   exit(1);
>>>> +    }
>>>>
>>>> However, fallocate() preallocates full guest memory before starting 
>>>> the guest.
>>>> With this behaviour guest memory is *not* demand pinned. Is there a 
>>>> way to
>>>> prevent fallocate() from reserving full guest memory?
>>>
>>> Isn't the pinning being handled by the corresponding host memory 
>>> backend with mmu > notifier and architecture support while doing the 
>>> memory operations e.g page> migration and swapping/reclaim (not 
>>> supported currently AFAIU). But yes, we need> to allocate entire 
>>> guest memory with the new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE 
>>> etc}.
>>
>> That is correct, but the question is when does the memory allocated, 
>> as these flags are set,
>> memory is neither moved nor reclaimed. In current scenario, if I start 
>> a 32GB guest, all 32GB is
>> allocated.
> 
> I guess so if guest memory is private by default.
> 
> Other option would be to allocate memory as shared by default and
> handle on demand allocation and RMPUPDATE with page state change event. 
> But still that would be done at guest boot time, IIUC.

Sorry! Don't want to hijack the other thread so replying here.

I thought the question is for SEV SNP. For SEV, maybe the hypercall with 
the page state information can be used to allocate memory as we use it 
or something like quota based memory allocation (just thinking).

> 
> Might be missing some details on this. So, better to wait for someone 
> more familiar to answer.

Same applies here :)

Thanks,
Pankaj

