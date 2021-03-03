Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EDB32B4EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450177AbhCCFbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:31:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53328 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbhCCCGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:06:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1231sqd6093289;
        Wed, 3 Mar 2021 02:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=F4zkQasWFFg+YxkGgmibWBE3i/yOsMXzMz2DA6Ihs5c=;
 b=jOBEn/FP/hKMmEavgr5UJE/rIWXYvFnAC6UPqlu1tvxRZ91GzQGLSsqT5kTq87URiJEh
 WFV8Jr+NQhX0Wly/UctSe228lqe6m2/a+wx2+GfaVScHs39uDdjRyau16361IVEP4hbe
 NsnMD1X5aj03UToc9oQgN1oKBhW6uyidOhlYKbOwvIpF80u10B5/qpIMs+PX/sAURI7Y
 laMNRvC8pZRQt7+FlKHtjo/rSTjvQyiK2vrJdN3vxJtzfxgQVbaEipH3PlUpnDOeZ29l
 pfLE2fdzrXq3X05A1jO/84gYvPujFmdDsOFV0ckxlSnoJAV30zW1xYRgSqOuBgS/Rucl aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36yeqn1puh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 02:03:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1231t167133650;
        Wed, 3 Mar 2021 02:03:47 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by aserp3030.oracle.com with ESMTP id 36yynpxbr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 02:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsXofXE9ZhHHcQnOsf8+ddNYhDQKnKVLjrTlViOa5svqc6mWWABkuz4lmU/SAaI50mQkbc27jJ6W55nTio9DENZfFWruj9elI57OeFx4C9+2QFd5yibvgoX/4i1l6q/iKgzwYSoz5vdGmJxmcfrXl6jxnJAgNCKqpm/jFhQmkYO/6exzKOzgOuJVZ1DOK9VeAfDXRbNjBqBfkBnfTs+R9Y4/kcFYqj404mYGgQUI268y5hDiK7tdeSP2a1R9PrJf4pHKZx5hurwkL2f+yJ/FNDEpEfOI4kRX5EFpwyQUYfLtkF6jKZxZOkjJoa/i8SS9h9uxkOocarpfibEcLwz4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4zkQasWFFg+YxkGgmibWBE3i/yOsMXzMz2DA6Ihs5c=;
 b=J2H4VzB10wdkJejNtWLRNgLNIQiiMGDc3X4UwGgml22WR+BceDzT+UxbCcB20hNSA9vsIhu4DzB1KKwUWsVr1YVWgKgLfKxbKd9mut7Xe4+8rYFBadfmUYAMK4rfjnB6sJMEKCLSKqxPvOAJSe70yv+cGcCnuO071dtH44mtLtTzyPCI1jld6IJRWXcd5WIqLFPRiaqE2KTDbK7wNlZrdfTN+OF5GNCppFcwG3jqHtHMeyLneeQBcamfi/fB2YhOz6Jt3o2yLYQB0PNH+zxfeY4tp52Cl7KCtdmYc34xuULnnwL2aVzjesLqqeJal+7aD36lUfopiJC3UEqxeKNH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4zkQasWFFg+YxkGgmibWBE3i/yOsMXzMz2DA6Ihs5c=;
 b=bTZLoqEG9nUMJkYfjKQ+Xq5f/4F0FVDmZBYFptG+SAAjtViYqEesGRn8qqw9rdfjvzQcz9j1UUh8oXo8GHhTkbkrI9ugOuomu2t1cmR+dRIWLigbEwOofwJKZfI+Le/E1vT+3vRQglojGS+q9CwxLPQa7DyLrnZOujuoucOpTdI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3301.namprd10.prod.outlook.com (2603:10b6:a03:14d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 02:03:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 02:03:44 +0000
Subject: Re: [PATCH v17 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <af0ee246-7a07-b82f-020f-bcc204631859@oracle.com>
Date:   Tue, 2 Mar 2021 18:03:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210225132130.26451-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0191.namprd03.prod.outlook.com (2603:10b6:303:b8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 02:03:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e22eff4c-b1da-48c1-0db3-08d8dde892f3
X-MS-TrafficTypeDiagnostic: BYAPR10MB3301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB33019F66E59D9677A29C11A9E2989@BYAPR10MB3301.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZsMUbh3P8fCpkPf/AhQHPdWtxWVz9+3kyIz6Zfx872eIaWa/E30v1CPuPJkIkGnBYr8ayqB5ZbG/NultEeOJCwl3fyZEHdeFf3864M87QocnEGRX/gvwGM6x8XL/iphnoVxR2kUexqR2ecdq9ZXRMYO2N80DE522ZDG3AhUTIi+4yBxfjsrEBF6RpfbTB46bQjoWIXFcID2iKFMMzRVKt1Apz2l9okAXT+pLM5gu+5Ki39dYqbe2jx5xivhthezrV4QBZD7OP9NART1Cm9lXC/93eGww6ukSPD5X4NivG71fdt3BdO0aQ44N9pLdVpkjEbkU+BfKiaT6zr29ISARDW9SfEpPEVJc4/QgFnL1Q7dydPbOK/yepY1A4ynbKyynHB/f9CYZLuFfspXAE9Met2rNgT2z6dP4YfGFzKIzl5fRtJ7smpuAlTV+0gV8WDewVtymjbIXRJRtqwtFMXYFx0gYBsDwrLTm9nHSHkaouwzdKKvruK6EmtyUT13f1mLtG0IhgViGfzspR2xO2vV0TOS/eMb1Je40iLVKSsztC7KpDs/Yp/qSoIuD/EVB+GtsCsU0Rk6B9I7lZAKvqwti/O0BQ0gCzvKzA5g1mRPLoTWuzn1y16tt8IIvRcdzwWXNUFzvO/sgUlridvdXOa60uWTnOydhgrKTUMEZiF3ncBsT1LNc3beC5buVz5BEbPTx+5N9TilElHlX1pEY/yNdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(376002)(346002)(8676002)(16526019)(86362001)(186003)(31686004)(26005)(83380400001)(31696002)(6486002)(53546011)(44832011)(36756003)(478600001)(52116002)(966005)(316002)(921005)(8936002)(956004)(16576012)(66476007)(66946007)(6636002)(30864003)(2616005)(2906002)(7406005)(7416002)(4326008)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QXUvNGFiZ1ZBSGFleUtXQVRlZmQ2MWNpK2s5UHpVbEVjb21LWWJNWjAzWTll?=
 =?utf-8?B?OXFVRHRDS0ZMSFdoak1XRWFjYzhscXB2c09hVWdlODJQTXNvVVVJRzhqOHpQ?=
 =?utf-8?B?TTdQcnRGMTVDd20vdlNnNlVlN3ljUVJpSTNnVXNPdTJ1Vmk4aVFjTjhJazlL?=
 =?utf-8?B?M29YYjdBdjJIUHhtZE5nc1cyRGVHZE9jT1VWYndIYTIreDN5WWdLUWJXVnpv?=
 =?utf-8?B?U0JyaFlPdzZSbXQyaVdTbjY3czRYWnpIaWNLSm9XazRjM0FXVVZPb1JDU2pt?=
 =?utf-8?B?bTJOT3dGYzFmUzMrbzhhL0VSVXJDaVh4WGh1bm96REJEYk53VlIrY2pSWTZX?=
 =?utf-8?B?ODlGMlQ0L3o0aytLZFJDVno3VllaRlBHeDVvWmdKcnNKV3ZrOGxyc0VESnVh?=
 =?utf-8?B?VDZIdmlPaENNNUVOZndOdktpZFVLeEEvNTRmMEpMNFllZ0gyVVQ5dmNlL1Ri?=
 =?utf-8?B?dHRWNTArL2RzMkRFcVZpVThwRUllT1AveHVVY0ZYazBpTEJiNThnclFpVXNq?=
 =?utf-8?B?U2xxUktFbHBVRFEybUNLOVo1MW4xakkzeHMxMDNpN0ZxQk83ZUZkTGtPQmtv?=
 =?utf-8?B?NlFwR3BHZFd5N21Zd05ESnJFVCsvTXpGbW9HTjZYRXlVbmZyMGtkdDZuQ3BV?=
 =?utf-8?B?UVNhZjBhK3NqYWNpK2NCd1hBRnFIcmUzOHpTYUEwV01RR2RldHhKQUppcUJM?=
 =?utf-8?B?cEs4RjdFblZZcG1OVDJ6Q2JRRGpGVzA1Nm1SbUFNaVQ3Y2R3b0VOSkd3UnJD?=
 =?utf-8?B?eURlM3pjcEQxU1UvQ05oZHVGUk1sMDlNcHlxNlhad1hpMHV5L3BZajl0aHVZ?=
 =?utf-8?B?TzVmcnVWZFZUNUNNampkV0E4V0dweTRrMTkzcjF0cEIydDIzUUZERlNwNWhT?=
 =?utf-8?B?V3Y0d3hOTy8yU1NGdGxjSG9HSzZJYUlXRWgvU2x5K0pkRDFIR0ZZZjBGOXp5?=
 =?utf-8?B?YTdiOWlCN3JjbG9ma0tPNEN4WGwxQ0RXUTNUYkpHd2RxZHpvRS9VZnpUZ0dT?=
 =?utf-8?B?eDF5T2NoNmJ3elJyOHhWZkRBajhRUCtlbmsyd0g2OWFJTCtIY21ZcFdJNytI?=
 =?utf-8?B?Tlp2ZXdoOVJZZ2FsU2IvYXVIQUhXdXZZTjV2M1R0SWJDTnhLVVE2eU85NnE0?=
 =?utf-8?B?OExZL25PcDZheDJKL2JTVUhMb2ZQajZ6WURoMks5b0llNk82UkJLMHQvTzRr?=
 =?utf-8?B?SmhGU3YxTGQ4aFV1elRVVC9iTjVyY1Q3b2FlV3l2ZUVYMjQ0elhvRHR3d0c2?=
 =?utf-8?B?bDEySjhadnJCUjNYdG1CNmgzWkhsVWYvK2JSTnFkRzFHM094UFRFdEswRjVQ?=
 =?utf-8?B?cnduZEhqS1c4RjRCc1pOMmdyT0wzSndEQ0J5bDRHcWJaY2NXSHhEUjRQUks5?=
 =?utf-8?B?OXFGeHhWZlBaaFBHVFY5NHh3WWtBT3lnazhZVTd1Z2FKVnRidis2dW5YaVVx?=
 =?utf-8?B?bjZVZGZsWkVBMlcwNnJ1ZUtMTi9OTHdwdEFJdFBRRFJPRXh2YUVoT0F0anlL?=
 =?utf-8?B?Ym0yMWlXNlEyYlZKSmd0NWtpaFlvazQreWhaZGFmUjJvMXBNVG82eVNHSnpt?=
 =?utf-8?B?cExWNzNjbitrTldTMWZNUkhrK3k4M29FMmVDMWU3MVJEYjJzcm9zdGRDcDlx?=
 =?utf-8?B?M1BjYVZ4cDRyUDVrQ1cxOVkwMThKWE10MFJmZVJTNWZNSlZGc0t1RCtmVkV3?=
 =?utf-8?B?MmlLL1p3MkI0cndtRDZFRUVuVWFYa09UNVh2L2o4eHZIcFYxR21vMGtHK1Rw?=
 =?utf-8?Q?sfOC6Nu35f6z1S6R6Vbj6FEgQZPf9n0uR4z2Mgl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22eff4c-b1da-48c1-0db3-08d8dde892f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 02:03:44.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31zs7IyehD1BfTOapgm1six4ZhlgLTo1B6YaMa3QZ9Gf94OKLCNViLQ5yCoRLOxh+8HKoIMK1rn3a5rkQavocw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3301
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030012
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030012
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/25/21 5:21 AM, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate
> the vmemmap pages associated with it. But we may cannot allocate vmemmap
> pages when the system is under memory pressure, in this case, we just
> refuse to free the HugeTLB page instead of looping forever trying to
> allocate the pages. This changes some behavior (list below) on some
> cassociated with it.orner cases.

Suggest rewording this as:

When we free a HugeTLB page to the buddy allocator, we need to allocate
the vmemmap pages associated with it.  However, we may not be able to
allocate the vmemmap pages when the system is under memory pressure.  In
this case, we just refuse to free the HugeTLB page.  This changes behavior
in some corner cases as listed below:

> 
>  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> 
>     Need try again later by the user.

	User needs to try again later.
> 
>  2) Failing to free a surplus huge page when freed by the application.
> 
>     Try again later when freeing a huge page next time.
> 
>  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
>     offline_pages().
> 
>     This is a bit unfortunate if we have plenty of ZONE_MOVABLE memory
>     but are low on kernel memory. For example, migration of huge pages
>     would still work, however, dissolving the free page does not work.
>     This is a corner cases. When the system is that much under memory
>     pressure, offlining/unplug can be expected to fail. This is
>     unfortunate because it prevents from the memory offlining which
>     shouldn't happen for movable zones. People depending on the memory
>     hotplug and movable zone should carefuly consider whether savings
>     on unmovable memory are worth losing their hotplug functionality
>     in some situations.
> 

Possible wording change:
      This can happen when we have plenty of ZONE_MOVABLE memory, but
      not enough kernel memory to allocate vmemmmap pages.  We may even
      be able to migrate huge page contents, but will not be able to
      dissolve the source huge page.  This will prevent an offline
      operation and is unfortunate as memory offlining is expected to
      succeed on movable zones.  Users that depend on memory hotplug
      to succeed for movable zones should carefully consider whether the
      memory savings gained from this feature are worth the risk of
      possibly not being able to offline memory in certain situations.

>  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
>     alloc_contig_range() - once we have that handling in place. Mainly
>     affects CMA and virtio-mem.
> 
>     Similar to 3). virito-mem will handle migration errors gracefully.
>     CMA might be able to fallback on other free areas within the CMA
>     region.
> 
> Vmemmap pages are allocated from the page freeing context. In order for
> those allocations to be not disruptive (e.g. trigger oom killer)
> __GFP_NORETRY is used. hugetlb_lock is dropped for the allocation
> because a non sleeping allocation would be too fragile and it could fail
> too easily under memory pressure. GFP_ATOMIC or other modes to access
> memory reserves is not used because we want to prevent consuming
> reserves under heavy hugetlb freeing.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst |  8 +++
>  include/linux/mm.h                           |  2 +
>  mm/hugetlb.c                                 | 92 +++++++++++++++++++++-------
>  mm/hugetlb_vmemmap.c                         | 32 ++++++----
>  mm/hugetlb_vmemmap.h                         | 23 +++++++
>  mm/sparse-vmemmap.c                          | 75 ++++++++++++++++++++++-
>  6 files changed, 197 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index f7b1c7462991..6988895d09a8 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -60,6 +60,10 @@ HugePages_Surp
>          the pool above the value in ``/proc/sys/vm/nr_hugepages``. The
>          maximum number of surplus huge pages is controlled by
>          ``/proc/sys/vm/nr_overcommit_hugepages``.
> +	Note: When the feature of freeing unused vmemmap pages associated
> +	with each hugetlb page is enabled, the number of surplus huge pages
> +	may be temporarily larger than the maximum number of surplus huge
> +	pages when the system is under memory pressure.
>  Hugepagesize
>  	is the default hugepage size (in Kb).
>  Hugetlb
> @@ -80,6 +84,10 @@ returned to the huge page pool when freed by a task.  A user with root
>  privileges can dynamically allocate more or free some persistent huge pages
>  by increasing or decreasing the value of ``nr_hugepages``.
>  
> +Note: When the feature of freeing unused vmemmap pages associated with each
> +hugetlb page is enabled, we can fail to free the huge pages triggered by
> +the user when ths system is under memory pressure.  Please try again later.
> +
>  Pages that are used as huge pages are reserved inside the kernel and cannot
>  be used for other purposes.  Huge pages cannot be swapped out under
>  memory pressure.
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4ddfc31f21c6..77693c944a36 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2973,6 +2973,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>  
>  void vmemmap_remap_free(unsigned long start, unsigned long end,
>  			unsigned long reuse);
> +int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> +			unsigned long reuse, gfp_t gfp_mask);
>  
>  void *sparse_buffer_alloc(unsigned long size);
>  struct page * __populate_section_memmap(unsigned long pfn,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 43fed6785322..b6e4e3f31ad2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1304,16 +1304,59 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> -static void update_and_free_page(struct hstate *h, struct page *page)
> +static int update_and_free_page(struct hstate *h, struct page *page)
> +	__releases(&hugetlb_lock) __acquires(&hugetlb_lock)
>  {
>  	int i;
>  	struct page *subpage = page;
> +	int nid = page_to_nid(page);
>  
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> -		return;
> +		return 0;
>  
>  	h->nr_huge_pages--;
> -	h->nr_huge_pages_node[page_to_nid(page)]--;
> +	h->nr_huge_pages_node[nid]--;
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> +	set_page_refcounted(page);
> +	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> +
> +	/*
> +	 * If the vmemmap pages associated with the HugeTLB page can be
> +	 * optimized or the page is gigantic, we might block in
> +	 * alloc_huge_page_vmemmap() or free_gigantic_page(). In both
> +	 * cases, drop the hugetlb_lock.
> +	 */
> +	if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> +		spin_unlock(&hugetlb_lock);
> +
> +	if (alloc_huge_page_vmemmap(h, page)) {
> +		spin_lock(&hugetlb_lock);
> +		INIT_LIST_HEAD(&page->lru);
> +		set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> +		h->nr_huge_pages++;
> +		h->nr_huge_pages_node[nid]++;
> +
> +		/*
> +		 * If we cannot allocate vmemmap pages, just refuse to free the
> +		 * page and put the page back on the hugetlb free list and treat
> +		 * as a surplus page.
> +		 */
> +		h->surplus_huge_pages++;
> +		h->surplus_huge_pages_node[nid]++;
> +
> +		/*
> +		 * The refcount can be perfectly increased by memory-failure or

Reword		   The refcount can possibly be increased by memory-failure or
		   soft_offline handlers.

> +		 * soft_offline handlers.
> +		 */
> +		if (likely(put_page_testzero(page))) {
> +			arch_clear_hugepage_flags(page);
> +			enqueue_huge_page(h, page);
> +		}
> +
> +		return -ENOMEM;
> +	}
> +
>  	for (i = 0; i < pages_per_huge_page(h);
>  	     i++, subpage = mem_map_next(subpage, page, i)) {
>  		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1321,22 +1364,18 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  				1 << PG_active | 1 << PG_private |
>  				1 << PG_writeback);
>  	}
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> -	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> -	set_page_refcounted(page);
> +
>  	if (hstate_is_gigantic(h)) {
> -		/*
> -		 * Temporarily drop the hugetlb_lock, because
> -		 * we might block in free_gigantic_page().
> -		 */
> -		spin_unlock(&hugetlb_lock);
>  		destroy_compound_gigantic_page(page, huge_page_order(h));
>  		free_gigantic_page(page, huge_page_order(h));
> -		spin_lock(&hugetlb_lock);
>  	} else {
>  		__free_pages(page, huge_page_order(h));
>  	}
> +
> +	if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> +		spin_lock(&hugetlb_lock);
> +
> +	return 0;
>  }
>  
>  struct hstate *size_to_hstate(unsigned long size)
> @@ -1404,9 +1443,9 @@ static void __free_huge_page(struct page *page)
>  	} else if (h->surplus_huge_pages_node[nid]) {
>  		/* remove the page from active list */
>  		list_del(&page->lru);
> -		update_and_free_page(h, page);
>  		h->surplus_huge_pages--;
>  		h->surplus_huge_pages_node[nid]--;
> +		update_and_free_page(h, page);
>  	} else {
>  		arch_clear_hugepage_flags(page);
>  		enqueue_huge_page(h, page);
> @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
>  	/*
>  	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
>  	 */
> -	if (!in_task()) {
> +	if (!in_atomic()) {

That should be "if (in_atomic()) instead of "if (!in_atomic())"

Do note that there is an ongoing discussion about calling free_huge_page
in various contexts.

https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/

This discussion/issue is independent of this patch.  Since that issue
deals with existing code, we will need to come up with a solution there
first.  A solution there may impact how free_huge_page is structured and
may impact this patch.

The in_atomic() check is insufficient to handle all cases.  It is better
than !in_task(), but still does not cover all cases.

The rest of the patch looks good to me.
-- 
Mike Kravetz

>  		/*
>  		 * Only call schedule_work() if hpage_freelist is previously
>  		 * empty. Otherwise, schedule_work() had been called but the
> @@ -1699,8 +1738,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  				h->surplus_huge_pages--;
>  				h->surplus_huge_pages_node[node]--;
>  			}
> -			update_and_free_page(h, page);
> -			ret = 1;
> +			ret = !update_and_free_page(h, page);
>  			break;
>  		}
>  	}
> @@ -1713,10 +1751,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>   * nothing for in-use hugepages and non-hugepages.
>   * This function returns values like below:
>   *
> - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
> - *          (allocated or reserved.)
> - *       0: successfully dissolved free hugepages or the page is not a
> - *          hugepage (considered as already dissolved)
> + *  -ENOMEM: failed to allocate vmemmap pages to free the freed hugepages
> + *           when the system is under memory pressure and the feature of
> + *           freeing unused vmemmap pages associated with each hugetlb page
> + *           is enabled.
> + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
> + *           (allocated or reserved.)
> + *       0:  successfully dissolved free hugepages or the page is not a
> + *           hugepage (considered as already dissolved)
>   */
>  int dissolve_free_huge_page(struct page *page)
>  {
> @@ -1771,8 +1813,12 @@ int dissolve_free_huge_page(struct page *page)
>  		h->free_huge_pages--;
>  		h->free_huge_pages_node[nid]--;
>  		h->max_huge_pages--;
> -		update_and_free_page(h, head);
> -		rc = 0;
> +		rc = update_and_free_page(h, head);
> +		if (rc) {
> +			h->surplus_huge_pages--;
> +			h->surplus_huge_pages_node[nid]--;
> +			h->max_huge_pages++;
> +		}
>  	}
>  out:
>  	spin_unlock(&hugetlb_lock);
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 0209b736e0b4..f7ab3d99250a 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -181,21 +181,31 @@
>  #define RESERVE_VMEMMAP_NR		2U
>  #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
>  
> -/*
> - * How many vmemmap pages associated with a HugeTLB page that can be freed
> - * to the buddy allocator.
> - *
> - * Todo: Returns zero for now, which means the feature is disabled. We will
> - * enable it once all the infrastructure is there.
> - */
> -static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> +static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
>  {
> -	return 0;
> +	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
>  }
>  
> -static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
> -	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> +	unsigned long vmemmap_addr = (unsigned long)head;
> +	unsigned long vmemmap_end, vmemmap_reuse;
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return 0;
> +
> +	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> +	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> +	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> +	/*
> +	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
> +	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> +	 * the range is mapped to the page which @vmemmap_reuse is mapped to.
> +	 * When a HugeTLB page is freed to the buddy allocator, previously
> +	 * discarded vmemmap pages must be allocated and remapping.
> +	 */
> +	return vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> +				   GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
>  }
>  
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 6923f03534d5..a37771b0b82a 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -11,10 +11,33 @@
>  #include <linux/hugetlb.h>
>  
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head);
> +
> +/*
> + * How many vmemmap pages associated with a HugeTLB page that can be freed
> + * to the buddy allocator.
> + *
> + * Todo: Returns zero for now, which means the feature is disabled. We will
> + * enable it once all the infrastructure is there.
> + */
> +static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> +{
> +	return 0;
> +}
>  #else
> +static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +	return 0;
> +}
> +
>  static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
>  }
> +
> +static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
>  #endif /* _LINUX_HUGETLB_VMEMMAP_H */
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index d3076a7a3783..60fc6cd6cd23 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -40,7 +40,8 @@
>   * @remap_pte:		called for each lowest-level entry (PTE).
>   * @reuse_page:		the page which is reused for the tail vmemmap pages.
>   * @reuse_addr:		the virtual address of the @reuse_page page.
> - * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
> + * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
> + *			or is mapped from.
>   */
>  struct vmemmap_remap_walk {
>  	void (*remap_pte)(pte_t *pte, unsigned long addr,
> @@ -237,6 +238,78 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
>  	free_vmemmap_page_list(&vmemmap_pages);
>  }
>  
> +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> +				struct vmemmap_remap_walk *walk)
> +{
> +	pgprot_t pgprot = PAGE_KERNEL;
> +	struct page *page;
> +	void *to;
> +
> +	BUG_ON(pte_page(*pte) != walk->reuse_page);
> +
> +	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> +	list_del(&page->lru);
> +	to = page_to_virt(page);
> +	copy_page(to, (void *)walk->reuse_addr);
> +
> +	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> +}
> +
> +static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> +				   gfp_t gfp_mask, struct list_head *list)
> +{
> +	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
> +	int nid = page_to_nid((struct page *)start);
> +	struct page *page, *next;
> +
> +	while (nr_pages--) {
> +		page = alloc_pages_node(nid, gfp_mask, 0);
> +		if (!page)
> +			goto out;
> +		list_add_tail(&page->lru, list);
> +	}
> +
> +	return 0;
> +out:
> +	list_for_each_entry_safe(page, next, list, lru)
> +		__free_pages(page, 0);
> +	return -ENOMEM;
> +}
> +
> +/**
> + * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
> + *			 to the page which is from the @vmemmap_pages
> + *			 respectively.
> + * @start:	start address of the vmemmap virtual address range that we want
> + *		to remap.
> + * @end:	end address of the vmemmap virtual address range that we want to
> + *		remap.
> + * @reuse:	reuse address.
> + * @gpf_mask:	GFP flag for allocating vmemmap pages.
> + */
> +int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> +			unsigned long reuse, gfp_t gfp_mask)
> +{
> +	LIST_HEAD(vmemmap_pages);
> +	struct vmemmap_remap_walk walk = {
> +		.remap_pte	= vmemmap_restore_pte,
> +		.reuse_addr	= reuse,
> +		.vmemmap_pages	= &vmemmap_pages,
> +	};
> +
> +	/* See the comment in the vmemmap_remap_free(). */
> +	BUG_ON(start - reuse != PAGE_SIZE);
> +
> +	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
> +
> +	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
> +		return -ENOMEM;
> +
> +	vmemmap_remap_range(reuse, end, &walk);
> +
> +	return 0;
> +}
> +
>  /*
>   * Allocate a block of memory to be used to back the virtual memory map
>   * or to back the page tables that are used to create the mapping.
> 
