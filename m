Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA37362C16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 01:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhDPX5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 19:57:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50962 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbhDPX5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:57:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GNu4lP086267;
        Fri, 16 Apr 2021 23:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bU53Hs+WmoW9/PVFPezZlL5mhLSqTBXY3JqloLj1RMg=;
 b=NR9r9bayQq5kk07Vgn2XRrWbzO3GJA7loAzHRiU0uB7KGgFxNKyEwC5WzhGlIt8lRLig
 yAOAGC6Tf+mGgT98U4gBN+gDO5lWx7cmsMqhDAOTcCExZFHc9/lqe9fPmpbkGDBEDRmo
 ZucOdX9dH5g4bI4B5YnMLr2tiyKRgQlmrAmFiRIDqp6YXVhAkSAVHleGNPn10WhQ+2X7
 KCOD6vBWTSIJl94eeQvsKAaofgr040+Ao4A1gQedhQVFzFSKYe7rVV+K/eLWHZDQNanU
 suVd083kcplHZEuDJ13artjOdv07R1RCtYqNXaLGvwJF9qg+hUZueGUXxT6rm7XQbQ9p Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37u3ymth9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 23:56:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GNtgJ6183644;
        Fri, 16 Apr 2021 23:56:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 37unsxwr9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 23:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkQWw6xNeyseWrRSm1wh6HZNJJpX5MuT71imTrHZsi1tbibRQCmPcvbOL261UXqxknvS3jGzGiA0SzyUM2cGOO/4aOalJmcAIeNnwMse0veefX5za5+7rbzR2X0B5kkYCMoWy3Vd1swOU/QqS8szsUDMx81mEnLpX3iN/BCZi7ehZ6G6ccYDw35YlE20EdjTsd0PlLGULojxf98tOsyWkFNmGqwzwOoElkjZZelpKvqqDJJbdKNV9UEGKX0xcJtUUABIFRodcQEm34ncfguX7YOVjmV6OANiaOWa2FBcp3G3mX5H8Kc10Es/lhphpIf9cWTvKKpn5Fcj5U+ZnWNTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bU53Hs+WmoW9/PVFPezZlL5mhLSqTBXY3JqloLj1RMg=;
 b=KvRnQA0XZskFPcelmLxvYI3Fi5lYPHcnthBhzUaL95b5R8iZZYqdYI/yBLEppFTALgOnJyZw6NbtG0tUkKJKck4kkzLhj2ZspY8qNsBsti4SIiKHoxo160w+bkM3la+Bg8qLzQh6I0PByrb3urV+S6fSafyZutGBP8RhjH24CjVul0u1zavb2QP97iN9TV6WJC0zC9IYOkoKTrx46ML11vC7MPsmR4id5G8yWE0U305B9nAoTCsE0zrgsIKdejmwaS/KFlUkL8Na52wKOF4KKrXcVZC4sws2dzUZbgmi1cT3Bb5WKLgSe30dhPVY/+KtimK3uV38NOidRKdFEbxUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bU53Hs+WmoW9/PVFPezZlL5mhLSqTBXY3JqloLj1RMg=;
 b=L1ftXnNN3NYqKgRbW6uX5i8Bbkb7Hg1HBDlOGDa/WnDSv/ynGw8UxuPCl+5L1PnwZvrKuCY+QEJZG7kUbLS6c33Gn5vDj6UZveZpwa5/JEtwkW/ycafGuCJ3BfOIzKTFphWqnPy3LoKQ0dVANK8LMi3ah590o5MjHaF5ZS55u/E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 23:56:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 23:55:59 +0000
Subject: Re: [PATCH v20 5/9] mm: hugetlb: defer freeing of HugeTLB pages
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-6-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <33a4f2fe-72c2-a3a1-9205-461ddde9b162@oracle.com>
Date:   Fri, 16 Apr 2021 16:55:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210415084005.25049-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:104:7::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0111.namprd04.prod.outlook.com (2603:10b6:104:7::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 23:55:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 814891a6-f7f2-4400-dd68-08d901332f0d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB454116513DABC2985BBE8531E24C9@SJ0PR10MB4541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIiJ4SNrnPeyEU9wAYX+ofrinqkTHVMJeXEPMFrJfTDGnjzLwtb3Qf/9weFutcd+BLyHhdPaHhJFQMEOHsXyxTCX7ip+ePS/sR3jTHAk1ugZkHakfxHHls0weoEDa9TqoT6OAY5gXEpvAtysctPijzPgOtNRz+Zw/cpS+lPVeHzqPweSgjmxAyXCCrnObOR3OA9G0jQI7k0dWK6K5tNGmQmviWe+49L6ZQrZRQ+W9GKrtKxR9xjmiatlHYtZdu0F3vFq9dOoxVtWpXCSR1s/C4SEr77IzyQAsO5lyuZ8sm2I+uTC8tbwUjVL1KofwcLYpdZ9MeMNfKvFX9kYzmCE2dkZccxxQ3El+N0GQTGvWBt3tpZD//PD9B4zDjM5fzLclZlVNCXDwjwcOs7K4aWEy+kElhMYSNmmvkkgfHZ2PC1haTJLWC5FNnEl+3cqC2GGkCUfEqZHFI1HdfVk309K/PG+wN3Sz7XWWh0QrqDusXPD/jjeXO3pyQ5uA+mgqeT+89sJ43gYOsrIcw04Kqg7OQlofSKyduUO4G0P0M88qec2dddJF5b7tW2VHT41QcbAZfT7lS9l/Cj5FUwSMMxlqk5ITE13t1n6rGSBUXMBGrPZL9NwbEH6CWncuvIQkm/yfuGZxz7KMjoFVnxi316AGCzaGm3qu6ea/tMcn0Kkp5eMAWCLmOD6cuxLIy9Fw31qXebrXlnpBvi9xpCmFpfvtHCuQC1EXFJ7WA74G9tv8V4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(53546011)(66476007)(6486002)(508600001)(4326008)(66946007)(6636002)(52116002)(31686004)(921005)(8936002)(16526019)(31696002)(26005)(8676002)(86362001)(186003)(66556008)(83380400001)(2616005)(16576012)(316002)(36756003)(5660300002)(956004)(7406005)(2906002)(7416002)(38350700002)(44832011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cWlZcXZjWVhhdk9lcEdtTjZKMUtnSTBERnFZbllVUmVkSGZmYXhwMjcvOVR1?=
 =?utf-8?B?ZTQxTHd0Yi81QXdSbkxqSk5jbGNhcWtKSkgwN2JOaUtnSit2VnhSdWk5YlM3?=
 =?utf-8?B?Q1I4VUtoSVovL2UraGZWL1BpQ1JBc2VpSGhPY2JESEZSTTVOZUxKSDVLOVFs?=
 =?utf-8?B?OUlTVy9JNlByTTFuRWl5Szc1VmxpdDBYODM0VDRLM3R2VDNIYWVOaW9TR2Jq?=
 =?utf-8?B?UnZzYVFWQ1U4RzQweVkraWtUSUt1TUxyREUxRTNmVURFSlk5OUU0Y3JrOEtV?=
 =?utf-8?B?aEljTVBGTm82YTRyYXJDSDkreG9TRndZakpCQ0prWkxZZDBRVVBtQnJHY2FW?=
 =?utf-8?B?UmZlaHhmZnl2UnQyeE5vVkU4VWtUdnp5Q1RpYklBVlJ1aDZEYkRDb1NwcW9I?=
 =?utf-8?B?MXRLaXYvU01hMmtKZmVya24vT0NOOFFqTDNxQnIwOXo2Vm1tczNuQU9Zd0JZ?=
 =?utf-8?B?a0JnRGd2Q0FLOHM0MkhSaGcxZTRYRE80Nk55eU9ONGMrTkRGNy9EUW9pcWY2?=
 =?utf-8?B?SUdZak9LVm1lZy9YSEszYTFQbkdQZmdMWWlBU2R4VEhweGR2djN4SkVkTUo4?=
 =?utf-8?B?cmxqMEtwWmtqcWx1SEk5S2J2emk1cEEzMDdMN3NsMTNsMDBqWE4xOUlkbDZ0?=
 =?utf-8?B?MjBrd2N6Q0ptTmtJVUw0THBxYUhKUEJYd1BqTGVxc0FhVDRYUkM4MTdSeGFo?=
 =?utf-8?B?TmcySjlta3lNY01PSSs2UFBnMERMT2p4K0g5MzRCVVZXTkxzK1JmMGdjVkV1?=
 =?utf-8?B?cWVKcnpCSGhMTHJuMnIwaHN4NlFNR0VTR3gyenlrQnIyYzVEM256Z2FwRnJq?=
 =?utf-8?B?SlNjcm5IcXNXYlFDM3l1NGs0c25PYi9Yc3pnVXllQXBTS3NKRVBqVWl0RTlH?=
 =?utf-8?B?dlQ2dVM4RkJYK09BaHp1aFU5cUxieGw0dythaUt3amNrYXp6YzQwSDR4VHpj?=
 =?utf-8?B?Q2FIa2lHQUtwYlR4dWNRa1FUY1IwQk0wclA1dm16ZGdxUloxMjhpY1liSCsv?=
 =?utf-8?B?ekVxRU0yckphN2dXbTQ0SFRwdkFBc05CdUo5Q1BXR28rbEphOE43VjZCQ3N3?=
 =?utf-8?B?NzdWU21xaHBSdmtlSkw5SHNBUUUwZ3NHdm5ra0YvZ2JSL1U2eVRSWkQrNkJy?=
 =?utf-8?B?aithT0xvcmNXQzQxZXZpS2lpVXFSblpicGpqTW1vajkwc3krY2FFSDBFNTlm?=
 =?utf-8?B?cVlwZkZNZGRlTWVVenhuS0FZRWNoY1ZrRVI5QW0zNUpLZDR6NEpoYlFIMXBz?=
 =?utf-8?B?dmx4UjRXRUIydm13YnZhNFI4VjVoTGhHbm05WXJoMFhnb01XUDBVOFVPbnk4?=
 =?utf-8?B?ZmxSWkxZM3U4dzJsVWNRZUZPRU16VVZnWG1iK1E3bnM3T0hyTmFDVEJjVVRE?=
 =?utf-8?B?c0JqYnVocnZiMGVQcFF3WjFBUXRlTCtkWGMyRjYxbFlrZkwvWXI4cXIyM3Na?=
 =?utf-8?B?aTV1TkZkMFlGQjBWM3ZoaHpvb1NJZ2txdUlzRXllTzBvNU1OYVhyY0UxcjBV?=
 =?utf-8?B?Vld2MWp3N3NTSGsvaVRrWEdvbFVkOUNiSWhESUJOdnZsWFFCcWV1ZzdCYVh4?=
 =?utf-8?B?MzZDdXdSdXpUYkI3ZGNuZS9NaVlZMWFFVHpuL3hIVU5Sd2p5R1NiWTR2d211?=
 =?utf-8?B?YzNTbHpaTE5nVENZMUY4STlPNzJGUXpXV2FUbmVleWF2eElVQ0J6aFVLRjQ4?=
 =?utf-8?B?N0MvTklLNWpQdFI1TjI0UDhTbFVMS1RYSjI4cFFqdkx1N2NTM2xDMTRYN0hK?=
 =?utf-8?Q?DVNQZBCfi+wWx/LOFEgvYxtqC58A40bxFgsxd4H?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814891a6-f7f2-4400-dd68-08d901332f0d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 23:55:59.6950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLtjFrHDo9QaOMEnA071GzSYKVyCbnmaoKkeipyY5UwbcZnH7GToKG5DpOvaUrh+yE+2zK62A7+zyhqt9pWuFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160168
X-Proofpoint-GUID: vi78I6pos9Kyjq9wpcKBg_g3rQT0d2gw
X-Proofpoint-ORIG-GUID: vi78I6pos9Kyjq9wpcKBg_g3rQT0d2gw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160168
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/21 1:40 AM, Muchun Song wrote:
> In the subsequent patch, we should allocate the vmemmap pages when
> freeing a HugeTLB page. But update_and_free_page() can be called
> under any context, so we cannot use GFP_KERNEL to allocate vmemmap
> pages. However, we can defer the actual freeing in a kworker to
> prevent from using GFP_ATOMIC to allocate the vmemmap pages.

Thanks!  I knew we would need to introduce a kworker for this when I
removed the kworker previously used in free_huge_page.

> The __update_and_free_page() is where the call to allocate vmemmmap
> pages will be inserted.

This patch adds the functionality required for __update_and_free_page
to potentially sleep and fail.  More questions will come up in the
subsequent patch when code must deal with the failures.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c         | 73 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  mm/hugetlb_vmemmap.c | 12 ---------
>  mm/hugetlb_vmemmap.h | 17 ++++++++++++
>  3 files changed, 85 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 923d05e2806b..eeb8f5480170 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1376,7 +1376,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>  	h->nr_huge_pages_node[nid]--;
>  }
>  
> -static void update_and_free_page(struct hstate *h, struct page *page)
> +static void __update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	int i;
>  	struct page *subpage = page;
> @@ -1399,12 +1399,73 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	}
>  }
>  
> +/*
> + * As update_and_free_page() can be called under any context, so we cannot
> + * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
> + * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
> + * the vmemmap pages.
> + *
> + * free_hpage_workfn() locklessly retrieves the linked list of pages to be
> + * freed and frees them one-by-one. As the page->mapping pointer is going
> + * to be cleared in free_hpage_workfn() anyway, it is reused as the llist_node
> + * structure of a lockless linked list of huge pages to be freed.
> + */
> +static LLIST_HEAD(hpage_freelist);
> +
> +static void free_hpage_workfn(struct work_struct *work)
> +{
> +	struct llist_node *node;
> +
> +	node = llist_del_all(&hpage_freelist);
> +
> +	while (node) {
> +		struct page *page;
> +		struct hstate *h;
> +
> +		page = container_of((struct address_space **)node,
> +				     struct page, mapping);
> +		node = node->next;
> +		page->mapping = NULL;
> +		h = page_hstate(page);

The VM_BUG_ON_PAGE(!PageHuge(page), page) in page_hstate is going to
trigger because a previous call to remove_hugetlb_page() will
set_compound_page_dtor(page, NULL_COMPOUND_DTOR)

Note how h(hstate) is grabbed before calling update_and_free_page in
existing code.

We could potentially drop the !PageHuge(page) in page_hstate.  Or,
perhaps just use 'size_to_hstate(page_size(page))' in free_hpage_workfn.
-- 
Mike Kravetz

> +
> +		__update_and_free_page(h, page);
> +
> +		cond_resched();
> +	}
> +}
> +static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> +
> +static inline void flush_free_hpage_work(struct hstate *h)
> +{
> +	if (free_vmemmap_pages_per_hpage(h))
> +		flush_work(&free_hpage_work);
> +}
> +
> +static void update_and_free_page(struct hstate *h, struct page *page,
> +				 bool atomic)
> +{
> +	if (!free_vmemmap_pages_per_hpage(h) || !atomic) {
> +		__update_and_free_page(h, page);
> +		return;
> +	}
> +
> +	/*
> +	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap pages.
> +	 *
> +	 * Only call schedule_work() if hpage_freelist is previously
> +	 * empty. Otherwise, schedule_work() had been called but the workfn
> +	 * hasn't retrieved the list yet.
> +	 */
> +	if (llist_add((struct llist_node *)&page->mapping, &hpage_freelist))
> +		schedule_work(&free_hpage_work);
> +}
> +
>  static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
>  {
>  	struct page *page, *t_page;
>  
>  	list_for_each_entry_safe(page, t_page, list, lru) {
> -		update_and_free_page(h, page);
> +		update_and_free_page(h, page, false);
>  		cond_resched();
>  	}
>  }
> @@ -1471,12 +1532,12 @@ void free_huge_page(struct page *page)
>  	if (HPageTemporary(page)) {
>  		remove_hugetlb_page(h, page, false);
>  		spin_unlock_irqrestore(&hugetlb_lock, flags);
> -		update_and_free_page(h, page);
> +		update_and_free_page(h, page, true);
>  	} else if (h->surplus_huge_pages_node[nid]) {
>  		/* remove the page from active list */
>  		remove_hugetlb_page(h, page, true);
>  		spin_unlock_irqrestore(&hugetlb_lock, flags);
> -		update_and_free_page(h, page);
> +		update_and_free_page(h, page, true);
>  	} else {
>  		arch_clear_hugepage_flags(page);
>  		enqueue_huge_page(h, page);
> @@ -1785,7 +1846,7 @@ int dissolve_free_huge_page(struct page *page)
>  		remove_hugetlb_page(h, page, false);
>  		h->max_huge_pages--;
>  		spin_unlock_irq(&hugetlb_lock);
> -		update_and_free_page(h, head);
> +		update_and_free_page(h, head, false);
>  		return 0;
>  	}
>  out:
> @@ -2627,6 +2688,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	 * pages in hstate via the proc/sysfs interfaces.
>  	 */
>  	mutex_lock(&h->resize_lock);
> +	flush_free_hpage_work(h);
>  	spin_lock_irq(&hugetlb_lock);
>  
>  	/*
> @@ -2736,6 +2798,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	/* free the pages after dropping lock */
>  	spin_unlock_irq(&hugetlb_lock);
>  	update_and_free_pages_bulk(h, &page_list);
> +	flush_free_hpage_work(h);
>  	spin_lock_irq(&hugetlb_lock);
>  
>  	while (count < persistent_huge_pages(h)) {
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index e45a138a7f85..cb28c5b6c9ff 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -180,18 +180,6 @@
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
> -{
> -	return 0;
> -}
> -
>  static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
>  {
>  	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 6923f03534d5..01f8637adbe0 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -12,9 +12,26 @@
>  
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
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
> 
