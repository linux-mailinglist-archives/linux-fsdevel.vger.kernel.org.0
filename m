Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA830304D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 00:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbhAYX2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 18:28:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37938 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbhAYX1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:27:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PNNmix110771;
        Mon, 25 Jan 2021 23:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2Hp9nW/lVRL1R7ofU0hE64DLJ9QedoWG9/G7AP/wc2Y=;
 b=sfwlkzLXKQ+xSxKmpxwZ12yk17HQBt2Zx+Xb5Lu/YzBBAkqjN6xL0Tm1oLlCb10cYpl5
 UtVTW7UD99mjzEHgoDd6hJamYmdi1fzqEd3+pSsD9qMFJYsg987kiGYmK6khqvtzH/YZ
 ZfUvIMT+OchB1dVn3KGugcztsuSun8KetXS87e8cfu8oFKr8avZuCCNmnrRobv+kA5NZ
 tU7hJ05bC/z5N5JFY37GiUHIyGo3p60rTeQ+o1p5xqfxBmHebV+IXTWE5w7PGxXR7k/W
 Mvqe64ph4V0sGwLWdvRuiV+Dp5TtTXKQhAAVgub8UOP8WdOPAtyS2YDbi5ayx342wyl3 wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 368b7qquv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 23:25:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PNL1rp168075;
        Mon, 25 Jan 2021 23:25:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3030.oracle.com with ESMTP id 368wcm90k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 23:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq42Xg8ReA85D9yzDhg55pfMzznbIyfDKyPx3p4bpn+dB7EGW2Vvwm0IYsUXbcQm1a0PUNCcRwaDdQZG0kPg3S5lul4uFYwY4aTpy0n7ch/Sqc/gT3d0+HzbiqHIcBHGZkEILhOV+tRxI0HV1A9DRd8hkm7WZqMf5NOeDFhjScCzf9zc2XpihMZHoNZIKRc8jTLkZJ4qIAT7X5ohp4IBFi/HC2FQs9+dBZitkNdId1XGXQCavj03Wbjm+7P/GV6LO3wmvWsOoX/akQhHys7OrZDZak9APlS+GfEAtvK+SNErkWQ1chXcneFPHq+Ugv0jGYoobFo84A0IHJzUi0DOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Hp9nW/lVRL1R7ofU0hE64DLJ9QedoWG9/G7AP/wc2Y=;
 b=i30rAqGjCkllhswseSRpdGnLSNz044QY05khAEisHQobFi7N1PDwEvNTq5Q4Liwd7FrYdfc5h4wUPyElsmNVh8I5kns2/Yuf7+e23ELqpiuXh94deKvKgdgSV/218c+XWPFoqHgWmxCHlnX6D1TRWrLQ+D9SQ3qF1RkTSGrLfLEgXbKCeI4XQvEMxOqUK1bgyz/yqAm/AQQlZfCDxmqCh2L7Qy0UZZXjOEs0J1Kie/ulgkIvwG3wriUhS1p64kc7WtKqBqF62Hx2lWkSsZi4Cmlz+Vs2wSFzFwiVdUW+IMigVrwvsm93vXPPK0S5JZlcmUpJtITMw6JZbyRClJ9c3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Hp9nW/lVRL1R7ofU0hE64DLJ9QedoWG9/G7AP/wc2Y=;
 b=Co9+DDQS42wInGWXHuMrKPKIUXMaYqBGI7CB+Xqb+ZNxlLgHjGcLJJuhmT9q1NTRLVepadMfKrR/v89wx/KQHyldwRB0kW9vg67PYLqpmav1LD0ZijDSbYzg7h3Lz4CfOlnxihVnTI45N/ZZUy0q/1xRAAiLdtQjFwvoR+WOkcg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4625.namprd10.prod.outlook.com (2603:10b6:303:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 23:25:38 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 23:25:37 +0000
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <6a68fde-583d-b8bb-a2c8-fbe32e03b@google.com>
 <CAMZfGtXpg30RhrPm836S6Tr09ynKRPG=_DXtXt9sVTTponnC-g@mail.gmail.com>
 <CAMZfGtX19x8m+Bkvj+8Ue31m5L_4DmgtZevp2fd++JL7nuSzWw@mail.gmail.com>
 <552e8214-bc6f-8d90-0ed8-b3aff75d0e47@redhat.com>
 <CAMZfGtWK=zBri_zAx=uP_dLv2Kh-2_vfjAyN7XtESwqukg5Eug@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b8ef43c1-e4b5-eae2-0cdf-1ce25accc36f@oracle.com>
Date:   Mon, 25 Jan 2021 15:25:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtWK=zBri_zAx=uP_dLv2Kh-2_vfjAyN7XtESwqukg5Eug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 23:25:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13ead9c9-d9b0-42f8-097b-08d8c1888546
X-MS-TrafficTypeDiagnostic: CO1PR10MB4625:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4625F9FE8A827BCC16228AB0E2BD9@CO1PR10MB4625.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtAi6BFz2vOe82fbrDsBhMjR4PxpWm9aYBWdCquCGcZbNXRmILMG2hWk1PdQ2Tvh5WeCkZorVLQn8Uf9j+vVRyIuOiIfxe6xybn8VOXtA1rQzn1YlzJLV/HQs4/MB5Z1Ce50ESXT5HrjGatoheZrrnV90ndqcqvuJQb1yqKdxUx2c4tBMpCYFm2a2cooYwRJR2p/JBW239vcTrgtQj+wH745PF1rCsvfhdtTqwSCYtRryDr/kT4iYrDg5voUjBur3ZtPassBQJENyRr+/i6kamTEhonqABcDAaXHBgzKa4OXbyieyTOfN38uG9gxvMIdDYobCiUewBeeN41+TdzFw+Yv5RKyu6kpytT3RLxfZpg40V588FXNm47NSKq8xUFi9iv3XbWMNaXo44eFsOQOXt9XkRF2ZfWbRzm6U5VmZOvNxjn5NlYQndtI6gruG581ZyHK0y69CJFzPHlC9U5CneJURHUwNrQgIhbLcqAa4IA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(44832011)(956004)(2616005)(86362001)(31696002)(66946007)(66476007)(66556008)(5660300002)(316002)(52116002)(16576012)(110136005)(54906003)(2906002)(6486002)(36756003)(8936002)(53546011)(7416002)(7406005)(26005)(31686004)(4326008)(186003)(16526019)(8676002)(83380400001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y0RQQlNwY2ZXUC9SSE1jckNBemFVblc0RVRCSXZZaE5yMXBZeXdmODdDOVB2?=
 =?utf-8?B?TjhuRHBPSVBNK2VYT1pmNkxzcDdsRkVsMU1kdkF2N0YxNTlhSVZYZHRJVVg0?=
 =?utf-8?B?WTl6S21haTJvbU1oRWhRalJYNnlkTk1uN3dvYys0R09RR1RxRWRRRUNoNk1T?=
 =?utf-8?B?VURJcnN2TmpkSHZ1YXl3ZXg0VXByS2t6YXdUSDdLdXQwYjA2ZmtLaElOOXBm?=
 =?utf-8?B?RHZnSndkOGR6clM5ZE5tejhPdk9UMWJvbERUWkxPaURHbGgreUFYVTM3aHdk?=
 =?utf-8?B?QTF1THlYUHZacVBvK3hGaXhleFJWZVZVMWlnNkRkYnpOcW1pZ1RpTkFZZ1E5?=
 =?utf-8?B?RXpJdk84NUhWTFY1N1ZOYjcyTHUwRENJSW0xN1NBRjNpUDJPbTVpK05SSzJ6?=
 =?utf-8?B?SkVac2dSUEhuV0orcllwcDcwVzh6RnNnajFVaVp2akNmdnFqdEg2a1ZHQ21q?=
 =?utf-8?B?SnNpU0dkUGdKZjRYNnVTLzRhRW15SUgzMW5hM0xSWVFNMnlFOXBsbGQyYzNh?=
 =?utf-8?B?VWRyYzFya3NMVlNMZ2dpNWtUSklrMzNSUWhwcUNYVmlEVDVlN0h0Vmg3bjVF?=
 =?utf-8?B?UVJUMmpESERaWE1NOGdLWmVtODNBa0pISFEyWmY2a3dhYjZiOGo1MnI2VWZV?=
 =?utf-8?B?ZW9NeWxKMWdEMmg1ejVDeDZ5QU4wZXRRVHd0Yk5mMmdaNGU3Ty9XU0xBSWs0?=
 =?utf-8?B?Uy80c2MybVpBSkJqN1A0MDlhaTNEcTJkT3pIQTc1ZW12K3pWWUw2VXVqOGdI?=
 =?utf-8?B?YmFkWlpkSFhKVHVRSDhFWUY3WllwWVBEaXBsZVNabmhSbWFUMnN3UmNxTzNt?=
 =?utf-8?B?b0xsSzJNU0tUN1dJb2t2ZE5KVUNUMEdzdTNhT1FLRjhNQmQySExWcHNFU1Vr?=
 =?utf-8?B?Z1lPM3pIMWhNL3p4LzlCMGFvMjh1eFB1VUtkdWxLbTR4RDJyTUhxMTU5R2JJ?=
 =?utf-8?B?U0RGTGowOWI4THhEa3Q1S25udWxLTW1pbnJZRWdHcTZ3VUQ1OXlPWGkxank2?=
 =?utf-8?B?VWpJYVdaQ0RVYzB0VGpFUWZOZWhPTW5aZHg1K3BIRFdrajJMQmZSZTgySjgv?=
 =?utf-8?B?TU5XUnFXV2RQczh2NFpJOHVMdHpxbHYzaXF2OG81Y3BMLzN2SDBYZWF5UUc5?=
 =?utf-8?B?c3JyQWVWVHhTSTdNRUNwdnpTTU01M3JXRGdmcHJsN1Z3RXRsV1Zzcy9ncHBF?=
 =?utf-8?B?MEl5ZzFvOVhlTmFlRjFSQzVXeHQ0OXU2WFFiZitwZUM3NUE5OUVodGVDMkhF?=
 =?utf-8?B?enRZWHE4Nkw0RkFRd25Wc1l3MUJmQzhVc1dsWEdydk4zWWtwYkd4YmxOY1Qy?=
 =?utf-8?B?em5hUjVWQXNkRkEwTGJFZTJ2aHkzUnBtcDhDTXY2SUJNeHpJVFNYb0gyS0lq?=
 =?utf-8?B?aVFteWtEQ3B3UGM5UUJ4cEhqcGc2L28wYkhYeWtkV0dsb1JhQmc0Q1NWbUJy?=
 =?utf-8?Q?8p42syp9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ead9c9-d9b0-42f8-097b-08d8c1888546
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 23:25:37.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9+p213BeUW1ulCJH0edHNb6VlaKFMF0J3M8ocYbmgW2pRgk7v9xdKfzxBCepZLveyEsScPdjJALn6vYqyGXFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4625
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/21 1:34 AM, Muchun Song wrote:
> On Mon, Jan 25, 2021 at 5:15 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 25.01.21 08:41, Muchun Song wrote:
>>> On Mon, Jan 25, 2021 at 2:40 PM Muchun Song <songmuchun@bytedance.com> wrote:
>>>>
>>>> On Mon, Jan 25, 2021 at 8:05 AM David Rientjes <rientjes@google.com> wrote:
>>>>>
>>>>>
>>>>> On Sun, 17 Jan 2021, Muchun Song wrote:
>>>>>
>>>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>>>> index ce4be1fa93c2..3b146d5949f3 100644
>>>>>> --- a/mm/sparse-vmemmap.c
>>>>>> +++ b/mm/sparse-vmemmap.c
>>>>>> @@ -29,6 +29,7 @@
>>>>>>  #include <linux/sched.h>
>>>>>>  #include <linux/pgtable.h>
>>>>>>  #include <linux/bootmem_info.h>
>>>>>> +#include <linux/delay.h>
>>>>>>
>>>>>>  #include <asm/dma.h>
>>>>>>  #include <asm/pgalloc.h>
>>>>>> @@ -40,7 +41,8 @@
>>>>>>   * @remap_pte:               called for each non-empty PTE (lowest-level) entry.
>>>>>>   * @reuse_page:              the page which is reused for the tail vmemmap pages.
>>>>>>   * @reuse_addr:              the virtual address of the @reuse_page page.
>>>>>> - * @vmemmap_pages:   the list head of the vmemmap pages that can be freed.
>>>>>> + * @vmemmap_pages:   the list head of the vmemmap pages that can be freed
>>>>>> + *                   or is mapped from.
>>>>>>   */
>>>>>>  struct vmemmap_remap_walk {
>>>>>>       void (*remap_pte)(pte_t *pte, unsigned long addr,
>>>>>> @@ -50,6 +52,10 @@ struct vmemmap_remap_walk {
>>>>>>       struct list_head *vmemmap_pages;
>>>>>>  };
>>>>>>
>>>>>> +/* The gfp mask of allocating vmemmap page */
>>>>>> +#define GFP_VMEMMAP_PAGE             \
>>>>>> +     (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN | __GFP_THISNODE)
>>>>>> +
>>>>>
>>>>> This is unnecessary, just use the gfp mask directly in allocator.
>>>>
>>>> Will do. Thanks.
>>>>
>>>>>
>>>>>>  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>>>>>>                             unsigned long end,
>>>>>>                             struct vmemmap_remap_walk *walk)
>>>>>> @@ -228,6 +234,75 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
>>>>>>       free_vmemmap_page_list(&vmemmap_pages);
>>>>>>  }
>>>>>>
>>>>>> +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
>>>>>> +                             struct vmemmap_remap_walk *walk)
>>>>>> +{
>>>>>> +     pgprot_t pgprot = PAGE_KERNEL;
>>>>>> +     struct page *page;
>>>>>> +     void *to;
>>>>>> +
>>>>>> +     BUG_ON(pte_page(*pte) != walk->reuse_page);
>>>>>> +
>>>>>> +     page = list_first_entry(walk->vmemmap_pages, struct page, lru);
>>>>>> +     list_del(&page->lru);
>>>>>> +     to = page_to_virt(page);
>>>>>> +     copy_page(to, (void *)walk->reuse_addr);
>>>>>> +
>>>>>> +     set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>>>>>> +}
>>>>>> +
>>>>>> +static void alloc_vmemmap_page_list(struct list_head *list,
>>>>>> +                                 unsigned long start, unsigned long end)
>>>>>> +{
>>>>>> +     unsigned long addr;
>>>>>> +
>>>>>> +     for (addr = start; addr < end; addr += PAGE_SIZE) {
>>>>>> +             struct page *page;
>>>>>> +             int nid = page_to_nid((const void *)addr);
>>>>>> +
>>>>>> +retry:
>>>>>> +             page = alloc_pages_node(nid, GFP_VMEMMAP_PAGE, 0);
>>>>>> +             if (unlikely(!page)) {
>>>>>> +                     msleep(100);
>>>>>> +                     /*
>>>>>> +                      * We should retry infinitely, because we cannot
>>>>>> +                      * handle allocation failures. Once we allocate
>>>>>> +                      * vmemmap pages successfully, then we can free
>>>>>> +                      * a HugeTLB page.
>>>>>> +                      */
>>>>>> +                     goto retry;
>>>>>
>>>>> Ugh, I don't think this will work, there's no guarantee that we'll ever
>>>>> succeed and now we can't free a 2MB hugepage because we cannot allocate a
>>>>> 4KB page.  We absolutely have to ensure we make forward progress here.
>>>>
>>>> This can trigger a OOM when there is no memory and kill someone to release
>>>> some memory. Right?
>>>>
>>>>>
>>>>> We're going to be freeing the hugetlb page after this succeeeds, can we
>>>>> not use part of the hugetlb page that we're freeing for this memory
>>>>> instead?
>>>>
>>>> It seems a good idea. We can try to allocate memory firstly, if successful,
>>>> just use the new page to remap (it can reduce memory fragmentation).
>>>> If not, we can use part of the hugetlb page to remap. What's your opinion
>>>> about this?
>>>
>>> If the HugeTLB page is a gigantic page which is allocated from
>>> CMA. In this case, we cannot use part of the hugetlb page to remap.
>>> Right?
>>
>> Right; and I don't think the "reuse part of a huge page as vmemmap while
>> freeing, while that part itself might not have a proper vmemmap yet (or
>> might cover itself now)" is particularly straight forward. Maybe I'm
>> wrong :)
>>
>> Also, watch out for huge pages on ZONE_MOVABLE, in that case you also
>> shouldn't allocate the vmemmap from there ...
> 
> Yeah, you are right. So I tend to trigger OOM to kill other processes to
> reclaim some memory when we allocate memory fails.

IIUC, even non-gigantic hugetlb pages can exist in CMA.  They can be migrated
out of CMA if needed (except free pages in the pool, but that is a separate
issue David H already noted in another thread).

When we first started discussing this patch set, one suggestion was to force
hugetlb pool pages to be allocated at boot time and never permit them to be
freed back to the buddy allocator.  A primary reason for the suggestion was
to avoid this issue of needing to allocate memory when freeing a hugetlb page
to buddy.  IMO, that would be an unreasonable restriction for many existing
hugetlb use cases.

A simple thought is that we simply fail the 'freeing hugetlb page to buddy'
if we can not allocate the required vmemmap pages.  However, as David R says
freeing hugetlb pages to buddy is a reasonable way to free up memory in oom
situations.  However, failing the operation 'might' be better than looping
forever trying to allocate the pages needed?  As mentioned in the previous
patch, it would be better to use GFP_ATOMIC to at least dip into reserves if
we can.

I think using pages of the hugetlb for vmemmap to cover pages of the hugetlb
is the only way we can guarantee success of freeing a hugetlb page to buddy.
However, this should only only be used when there is no other option and could
result in vmemmap pages residing in CMA or ZONE_MOVABLE.  I'm not sure how
much better this is than failing the free to buddy operation.

I don't have a solution.  Just wanted to share some thoughts.

BTW, just thought of something else.  Consider offlining a memory section that
contains a free hugetlb page.  The offline code will try to disolve the hugetlb
page (free to buddy).  So, vmemmap pages will need to be allocated.  We will
try to allocate vmemap pages on the same node as the hugetlb page.  But, if
this memory section is the last of the node all the pages will have been
isolated and no allocations will succeed.  Is that a possible scenario, or am
I just having too many negative thoughts?

-- 
Mike Kravetz
