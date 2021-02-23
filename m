Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5433222ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 01:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhBWACs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 19:02:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57562 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhBWACo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 19:02:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MNxwI3084998;
        Tue, 23 Feb 2021 00:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=n4f4N2f/xl+eYTXOlL6f08QY2lK25sM4KRjKkjkMN48=;
 b=GQppM9Iyc5W9jvg6Wq7Joi4zQAbWzc/KZ19IRG5C30cW98tVFyIi50Wlm+l8JpOl7D1Y
 c1ih8XipinawEXRlD7RdwMHukJ7fOH0GDECk1DNf+GjswJeFXG+WoZ+5IYlET4WOS8jS
 WDpiK2a2HY969uXmOUqUxKAGE9xJ7QVTfw2id6n7+pbvdWyGT+yrJXsabeYtjhD1jVUw
 NOGrI5if8ZDz/ozjvp0nguXyC3xvSR53EcC5np6mBhnlcG6rwdhjeKERb+waZ4l3vinP
 MZ08mF5JwiBMbt/LuItvRNzyDj0QgHVue6twtCBNYFszJS7pg3Vnyx23zlXpX+cBKa+F dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36tsuqwh8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 00:00:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11N00XJ4034980;
        Tue, 23 Feb 2021 00:00:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 36ucaxp5d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 00:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PApgFHaIAX5DTJoQqG70wv6zRpsmGaHE5u2pa+xh8sx4fdysvPsGwZoGJmZXwZOz4IhN8vTE4FKDv8uPrEHZdpYbSuMmcYKzKkqqQBOdUTmtQ9/F6R2WnGmaYrrkOStGKOeI9w+TfIDNL3UsZwuMWQqehZAbR1SROwf99VN00HOEjLxhwVmrigVm0N4MWZt/DwrDzQHR8CdmGH3/QeA/J1CeFGS43uSDNn1bx5WPKOH6u9aMZobSHxlKwYnxxP6nESvCfY4lfa4rriQJ+88p0vPh+/Sh4Po23HKU0ZU47v1+y9NKAXKktQ2E4EM/yZPptl+ISmVvsnQc/+oo+3T2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4f4N2f/xl+eYTXOlL6f08QY2lK25sM4KRjKkjkMN48=;
 b=XUxnzLFpJL3b9IvU+/JRCkuCMxWFtFyQnv5CZIi8I2Llb5jY1TpU+Fi2/qi0wUhzbAv/LFS6fxDjNeoBnh2YIQRzZ5ZFqvi2KurfnveybQDv+yj3OQFyos2X0+F7YRqBITbbAs4AyHA4axvfyhvUHvfK9yOymaJDAWxdjVqArlqA9JKrUMqEDW+hSjMpgSUPu4sgckLz1nRhxbEVJMJEAUA0faRM3oZP11/+TwYIR8/pwvWQax/IndDyOgDtNxMWYTtODLZ0Ii48BBU+d5l1ijhKt5NTjtgTIWV/4CO0HCC35snXOQvbMD6vuDp2WFFr74Cg6rp/ohYb6q3fLgcbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4f4N2f/xl+eYTXOlL6f08QY2lK25sM4KRjKkjkMN48=;
 b=H5/zDwUcNzlO5F9wDR/0JxxzC9+lamMo4P7SQ7ofh9Z22cSFu2s+4nusQcqJtux4IrYa/GXk7PaTMhBA/Mr3bgkI5qzaCgTGXs3YZstrDA3GZBM1G0jG0GIhilNrQgIoR9nOpveegRAXjIK88qGD+v3hpkIxRL5jFUolsyVwd+M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4415.namprd10.prod.outlook.com (2603:10b6:a03:2dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 00:00:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%5]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 00:00:31 +0000
Subject: Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap pages associated
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
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
Date:   Mon, 22 Feb 2021 16:00:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210219104954.67390-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 00:00:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d701b41b-849b-41e5-3ec2-08d8d78e087e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4415BB8C0C8FEF7D10A86BEAE2809@SJ0PR10MB4415.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTL69r3R36iMA+yZux3JMsc8X8NVS7ng5t5/hrkN35Sg1EzH6QCMuv+O0Kg2NHcRqrByJ4Jrcxp8fstdoE7DHnb6W+Tz7gRFeWJmJHEgOdxhNMMuGtQj+meKI3JCWJXsnWQ21A9HC63u0uf0dcQmZywInG/06h5MDbr8AJliLrpRYteoKHnd47Ny53JT8MRJqs5tdoESZcKj1etoDtHKSwMy2BeokC40CGIhVWB/s9B5jAeEzd5FCCv3BmfeporLwF4YSRBYzzXfBc5nmQ0KkQU5cm8+9oPbqgzEo1usuX0z51/tklkx3beqit30oMEqKmlR3ChsTEn4+mmq8Q6mP4+3OxrqPotPYFf9/+ePLK+fskaqwvFul8p/KpIK3wDzSRPOYQPCaFjFiFcSwuFSgYUH5jNwYKmONhGWTn2syIzCyc4ebMl8rYAV/iF2Cn4xUl+6JXvJtRy3Uhscou/kB+Sn61PdBTxfRLjJ+1UzwAVK3Mwqrd+yhyUVVCB3DTD/9oGu3obYjhMpd0xC4pAjRXULffGBw5Kz9liOyqtdmIepGHxXIbBmT3gyjSdggbWTxER+b7tMFyekB5zf6tY0soL7ytPYG4smLw1huBwCDK7lErAay8BiHV9x9UB3kqmL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(6636002)(2906002)(8676002)(921005)(86362001)(66556008)(66476007)(478600001)(5660300002)(83380400001)(36756003)(66946007)(7416002)(44832011)(2616005)(7406005)(4326008)(31696002)(53546011)(31686004)(6486002)(956004)(316002)(16576012)(186003)(16526019)(26005)(30864003)(52116002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bzhNcHdtTkliVit2ZzA1MG1IRWUrTVJXdDhITVBOSkI3TlNwUWlqcndJNEhO?=
 =?utf-8?B?MERFNmJXdVJsOWxaSzd6TkREWE9PbjRPWnlTa3dwYTkrVlVsNWxxNDJvSDlx?=
 =?utf-8?B?OXkwREc1R0pQVkRKWXo1TVBYQmsxQzc5RTdiSG0zVnJJd1VHbWF2QUtTVE9p?=
 =?utf-8?B?MExoZStJdFhleDJXV01rVU10aEYyMjBJTWF6U3lOVlNDc3J2OCtqY0ZDblNk?=
 =?utf-8?B?ZG0zWGhkYTU2cGxBRWJvSGNxcG0vdzczaTdwa0FnU01JTnpQSlhxZWplUGp3?=
 =?utf-8?B?ZU1GYmNKbmx5dlR5c2lld051SDl6VUUyYlpQdFFXbnd2cWxLT3J5dFc1dnV6?=
 =?utf-8?B?bUtRUVI4eHhmSXRpTFQrMEM2MmRGUmFQTFdtYWJmbFZkRy9oNFRRZUJtQXZR?=
 =?utf-8?B?empPcm9pdzRka1N5azZENDk3OUw0L2Y0c0dXdE9OT2Q3ZDUvY1h3eEQwRnpa?=
 =?utf-8?B?RVQyWW9Rb29pMStENDF0QWp3bFcyOUVVRzExTWZlRXJFK3N2YUZTWVE0eU1G?=
 =?utf-8?B?VldtOFN1cDljNUhWSHY3eWtlNlFLZ2d2RG9sS1FWSWtUckliK0pjZklDTE80?=
 =?utf-8?B?TUtmamd0cXcxcWlEU1NLRkNSWEZOSGpHNVBKSnh4dW1yVm5QOGVDUW9MZTNM?=
 =?utf-8?B?RlpRWWFxWUhsYStVTHBXRHdxN2dLUkxlc0JxSjB5dEd0L0dWallNcFJWZkwx?=
 =?utf-8?B?d2pyTU9aVWtoZHRlWVA4WHhETHFvVzg3eG1kOW5ZaVAyVks4QTFGR3hPU01S?=
 =?utf-8?B?QkpkOFkwb2k3RHpqdHRuT3NJRGVZRG4rSkgxTGRZWGtwcnhFd2t0S3RNYlVL?=
 =?utf-8?B?VFNhY2h5YkNYVEw4cUlTSHJUZGZtMGUyWnBOZEZtZDF1M1ZkRWg3UkRnS21o?=
 =?utf-8?B?dE1maHpPK0h5alVya0V3L1JrSlhsQXRvak9aMWoxaDNjbnF4YWRGNVhZQUtU?=
 =?utf-8?B?SHdTNUlCSENIQlhlS256NTlIdU9CTERHZGFzcld2cXhTN05iQUE2REZjOElV?=
 =?utf-8?B?WDBLZHdDUDVacVVuQmVMWkpnVGZvY0JDNUZ6NksvSmdkSmhyT3o5d0UwRzJO?=
 =?utf-8?B?N0xndTBISDhmQ2R1RFoySEM5QUlOK3M1WVNHNlM4b0N5SXdTd3dQWHRvYUxr?=
 =?utf-8?B?bjRvMUI1aExPTGZNMkROZEZMdTlpT1EzUkpKaGNJeWg0T1lhTGhSUEdEaldD?=
 =?utf-8?B?QXRmYVNLRnhpY1RRRlJqYmFaUFB1T0g2WmhUelg5T0RLQllqMnowRkRDTGsr?=
 =?utf-8?B?c3EwVVFkWGc3TXN5TzBNZGVPRG5KeEN1clZuZCtzeFFNRE1heGJYdU8yaTN0?=
 =?utf-8?B?Rlc2WFhQMUxDMTdhVVUvUzBRSytWdXJyZmRPZzcrdG5sMXhpNXdvSjBieWhm?=
 =?utf-8?B?UjZGb0gzVk9tUlBJKzFwY2xmTStBSk52YnN0UWRsS0lLajJiVytFSHZrRjl2?=
 =?utf-8?B?aHpsTDNRU2toVEttN2UzcGlScDRnNGtucjhjaGk0aU9vbUlNcHkrOHJhczE2?=
 =?utf-8?B?RE1UMzRLVXM2UzhTZ3I2L09ya1pOcTErdFVXeHNjbUZBMkJRYi9KU3p6S2F0?=
 =?utf-8?B?R2Z4UG1tS05FRVArZ1RLUWI0dDcwUjBkNGhWQ1NHa2ZYTnE1SUVSNHphRGNN?=
 =?utf-8?B?NndRYW5pUjlwVWp5S2lIMkJlR0NZbFdkcUhuV1Z5ZkdrdVNPMkdkdGh2bVZM?=
 =?utf-8?B?Z2R4eGFCOStRWTltK05NT3AveVFYMmJhaEFCV29sczUrbmUyUXdhOFEzWnJx?=
 =?utf-8?Q?k+Tu14nNWQ+3NLRKg9JC46cZ7vmPP5f5zauGYB0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d701b41b-849b-41e5-3ec2-08d8d78e087e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 00:00:30.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdX1Dchc4K2c4T3RrKn1Ao/2ItKyx77ndCd8InCc9MnbRlzgkKu2S0mcGLuLPbnnpLykyZ8MCH/GwaQHFe4eNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4415
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220207
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220207
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/19/21 2:49 AM, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate
> the vmemmap pages associated with it. But we may cannot allocate vmemmap
> pages when the system is under memory pressure, in this case, we just
> refuse to free the HugeTLB page instead of looping forever trying to
> allocate the pages. This changes some behavior (list below) on some
> corner cases.

Thank you for listing changes in behavior and possible side effects of
not being able to allocate vmemmmap and free huge page to buddy!

I will not repeat Michal's comment about the check for an atomic context
in free_huge_page path.

> 
>  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> 
>     Need try again later by the user.
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
>     pressure, offlining/unplug can be expected to fail.
> 
>  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
>     alloc_contig_range() - once we have that handling in place. Mainly
>     affects CMA and virtio-mem.
> 
>     Similar to 3). virito-mem will handle migration errors gracefully.
>     CMA might be able to fallback on other free areas within the CMA
>     region.
> 
> We do not want to use GFP_ATOMIC to allocate vmemmap pages. Because it
> grants access to memory reserves and we do not think it is reasonable
> to use memory reserves. We use GFP_KERNEL in alloc_huge_page_vmemmap().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst |  8 +++
>  include/linux/mm.h                           |  2 +
>  mm/hugetlb.c                                 | 81 ++++++++++++++++++++--------
>  mm/hugetlb_vmemmap.c                         | 22 ++++++++
>  mm/hugetlb_vmemmap.h                         |  6 +++
>  mm/sparse-vmemmap.c                          | 75 +++++++++++++++++++++++++-
>  6 files changed, 171 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index f7b1c7462991..fb8f649e5635 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -60,6 +60,10 @@ HugePages_Surp
>          the pool above the value in ``/proc/sys/vm/nr_hugepages``. The
>          maximum number of surplus huge pages is controlled by
>          ``/proc/sys/vm/nr_overcommit_hugepages``.
> +	Note: When the feature of freeing unused vmemmap pages associated
> +	with each hugetlb page is enabled, the number of the surplus huge

Small wording change:

	with each hugetlb page is enabled, the number of surplus huge

> +	pages may be temporarily larger than the maximum number of surplus
> +	huge pages when the system is under memory pressure.
>  Hugepagesize
>  	is the default hugepage size (in Kb).
>  Hugetlb
> @@ -80,6 +84,10 @@ returned to the huge page pool when freed by a task.  A user with root
>  privileges can dynamically allocate more or free some persistent huge pages
>  by increasing or decreasing the value of ``nr_hugepages``.
>  
> +Note: When the feature of freeing unused vmemmap pages associated with each
> +hugetlb page is enabled, we can failed to free the huge pages triggered by

Small wording change:

   hugetlb page is enabled, we can fail to free the huge pages triggered by

> +the user when ths system is under memory pressure.  Please try again later.
> +
>  Pages that are used as huge pages are reserved inside the kernel and cannot
>  be used for other purposes.  Huge pages cannot be swapped out under
>  memory pressure.
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d7dddf334779..33c5911afe18 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2981,6 +2981,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>  
>  void vmemmap_remap_free(unsigned long start, unsigned long end,
>  			unsigned long reuse);
> +int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> +			unsigned long reuse, gfp_t gfp_mask);
>  
>  void *sparse_buffer_alloc(unsigned long size);
>  struct page * __populate_section_memmap(unsigned long pfn,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4cfca27c6d32..bcf856974c48 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1305,37 +1305,68 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> -static void update_and_free_page(struct hstate *h, struct page *page)
> +static int update_and_free_page(struct hstate *h, struct page *page)
> +	__releases(&hugetlb_lock) __acquires(&hugetlb_lock)
>  {
>  	int i;
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
> +	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> +	set_page_refcounted(page);

I think you added the set_page_refcounted() because the huge page will
appear as just a compound page without a reference after dropping the
hugetlb lock?  It might be better to set the reference before modifying
the destructor.  Otherwise, page scanning code could find the non-hugetlb
compound page with no reference.  I could not find any code where this
would be a problem, but I think it would be safer to set the reference
first.

> +	spin_unlock(&hugetlb_lock);

I really like the way this code is structured.  It is much simpler than
previous versions with retries or workqueue.  There is nothing wrong with
always dropping the lock here.  However, I wonder if we should think about
optimizing for the case where this feature is not enabled and we are not
freeing a 1G huge page.  I suspect this will be the most common case for
some time, and there is no need to drop the lock in this case.

Please do not change the code based on my comment.  I just wanted to bring
this up for thought.

Is it as simple as checking?
        if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
                spin_unlock(&hugetlb_lock);

        /* before return */
        if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
                spin_lock(&hugetlb_lock);

> +
> +	if (alloc_huge_page_vmemmap(h, page)) {
> +		int zeroed;
> +
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
> +		 * This page is now managed by the hugetlb allocator and has
> +		 * no users -- drop the last reference.
> +		 */
> +		zeroed = put_page_testzero(page);
> +		VM_BUG_ON_PAGE(!zeroed, page);
> +		arch_clear_hugepage_flags(page);
> +		enqueue_huge_page(h, page);
> +
> +		return -ENOMEM;
> +	}
> +
>  	for (i = 0; i < pages_per_huge_page(h); i++) {
>  		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
>  				1 << PG_referenced | 1 << PG_dirty |
>  				1 << PG_active | 1 << PG_private |
>  				1 << PG_writeback);
>  	}
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> -	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> -	set_page_refcounted(page);
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
> +	spin_lock(&hugetlb_lock);
> +
> +	return 0;
>  }
>  
>  struct hstate *size_to_hstate(unsigned long size)
> @@ -1403,9 +1434,9 @@ static void __free_huge_page(struct page *page)
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
> @@ -1693,6 +1724,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  			struct page *page =
>  				list_entry(h->hugepage_freelists[node].next,
>  					  struct page, lru);
> +			ClearHPageFreed(page);

Quick question.  Is this change directly related to the vmemmap changes,
or is it a cleanup that you noticed?

>  			list_del(&page->lru);
>  			h->free_huge_pages--;
>  			h->free_huge_pages_node[node]--;
> @@ -1700,8 +1732,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  				h->surplus_huge_pages--;
>  				h->surplus_huge_pages_node[node]--;
>  			}
> -			update_and_free_page(h, page);
> -			ret = 1;
> +			ret = !update_and_free_page(h, page);
>  			break;
>  		}
>  	}
> @@ -1714,10 +1745,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
> @@ -1768,12 +1803,14 @@ int dissolve_free_huge_page(struct page *page)
>  			SetPageHWPoison(page);
>  			ClearPageHWPoison(head);
>  		}
> +		ClearHPageFreed(page);
>  		list_del(&head->lru);
>  		h->free_huge_pages--;
>  		h->free_huge_pages_node[nid]--;
>  		h->max_huge_pages--;
> -		update_and_free_page(h, head);
> -		rc = 0;
> +		rc = update_and_free_page(h, head);
> +		if (rc)
> +			h->max_huge_pages++;

Since update_and_free_page failed, the number of surplus pages was
incremented.  Surplus pages are the number of pages greater than
max_huge_pages.  Since we are incrementing max_huge_pages, we should
decrement (undo) the addition to surplus_huge_pages and
surplus_huge_pages_node[nid].  So, I think we want
			h->surplus_huge_pages--;
			h->surplus_huge_pages_node[nid]--;
here as well.

>  	}
>  out:
>  	spin_unlock(&hugetlb_lock);

In previous version of this patch series, we discussed and refined the
vmemmap manipulation routines below.  They still look good to me.

In general, I like the approach taken in this patch.  Hopefully, others
will comment and we can move the series forward.
-- 
Mike Kravetz

> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 0209b736e0b4..29a3380f3b20 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -198,6 +198,28 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
>  	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
>  }
>  
> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
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
> +}
> +
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
>  	unsigned long vmemmap_addr = (unsigned long)head;
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 6923f03534d5..e5547d53b9f5 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -11,8 +11,14 @@
>  #include <linux/hugetlb.h>
>  
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head);
>  #else
> +static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +	return 0;
> +}
> +
>  static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
>  }
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
