Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E3374A2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhEEVby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 17:31:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41226 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhEEVbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 17:31:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145LJrso112566;
        Wed, 5 May 2021 21:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=a8jisN5m4z5D9OkxPgf0OwinBQiE1mLygoPx8AQxxdg=;
 b=VVPgiPSAg3v6lTqhvRTK3ZnPH9DwDTzvFgkRkaT92TkOgIwI2Usmqf7MZ7vsqYNI4ozz
 GkBMObq619AEzbpNs15DB5CGHrLGaJUr8h2U7rRYGUjQ8j0jS9qfLGkuMtR4L7mVqQJJ
 8L13tUP3Ha3E7/AdZvR7PoYuGZ4E0kz0Bd5o+tjJ49e3n/G62HuVRm3E62NZKjS8iG38
 09zWRKbKvR8XiEw+QdUdjuKW6tJBPkacU3CUZYn2QOIswl36j5Iwh5nQ/zalonUa373b
 lFl7PFCKGJTaTVOaLUwXiaBy0yA0RYSxRdmxecMHK/LCXP0PpEjcJUD5um7qwQuQWRaf pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 38begjb6jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 21:29:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145LLgqU145658;
        Wed, 5 May 2021 21:29:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 38bewrf4nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 21:29:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YioLzOKteok5Dv8U2QPC30vo/cSoEVZE/I6/DuagNxOdhdYCOWJ7p4RI8nUj8md2XZlKSA6W0iyuxAs3SE1QF5WSLK7JUqtXVCerdhK+VMQsizi8WH7Eww2nxS2/4utpZr7oEp0t/dgWRWGYKpqX3LF1atVJUxJ5Pu4eNLKJXmmPjxDQ6GJQYAwMKKjrE+GmDjo5Cl/jHyT9dTcxAtDMN7mMdyfC37X3LPGjyyyEVynesdvCuH0u7jBIx8tqPR/pzP8qDfEpZqgxebxEShS2QbBMhXeKRbi7twnr2yKCYIflvv0dbKgl7YedQENIyHTZfLX0lt6m7k0cHLEP1Ge4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8jisN5m4z5D9OkxPgf0OwinBQiE1mLygoPx8AQxxdg=;
 b=KJQAYjuIaIYgWnE9fdxKj/+TY3A4Ig/ACtPqRp4uAZ8p88svgIWs9XY3CwD0W4JHrHB5/Q52jrqJrgPXnTyaWJLbnvqVEDZx9XlSfQuYVF/eL2389W9TCZ0CByFQEKPv8lbg1ciKE/u08eS4WqFwPc73x7hOy2ccHmfX4Kg2oP2Mf/vhvS/wfk0FGmJGeIQm3tw/l5gGs5wkJ2Fbl5m8ZIa8VKPZ/wPrj+g+SegJndD70BNBFf9vFly3kR2enVHlp5ZY6YvTz+beE//eX0cp21oRotcdK1hgj9ZUpOGUNqBb5CWCAqcF3og1ugJV/CHBqafO3Mxelsw72xqxUYmVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8jisN5m4z5D9OkxPgf0OwinBQiE1mLygoPx8AQxxdg=;
 b=JkYCwSZgOVsTtv9XNeqRgk0spTpoi1ITR7rrVbKH9WeVAsDcUZYMRv5euZQfeSxsUxcQ2eL88Jc9ka+yO8XFImSrTqCNeJ+OMgmwJDm8C/cCN6lVbilh2casEHzhMfzypJSqyWidI7D76X+q8GVhHsweaHLs9i0mQboPJEI3zEg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5455.namprd10.prod.outlook.com (2603:10b6:a03:3b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Wed, 5 May
 2021 21:29:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 21:29:25 +0000
Subject: Re: [PATCH v22 5/9] mm: hugetlb: defer freeing of HugeTLB pages
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
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210430031352.45379-1-songmuchun@bytedance.com>
 <20210430031352.45379-6-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0fc1be18-22d3-ba6b-7f6f-1c79abce93a0@oracle.com>
Date:   Wed, 5 May 2021 14:29:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210430031352.45379-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Wed, 5 May 2021 21:29:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c08fc82e-5c3c-41dd-b747-08d9100cdb64
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5455F40559393A59C31713B7E2599@SJ0PR10MB5455.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /s+jU6zgZTfk5Hv+O1TidtbD23AhDB7f12ZydCG/kqLLJo0+xHA5il+uE7vwONNI7hfe6GnanVjnySmFR2zCDq9+aopiV7gFsFtlC0fpDN+X97b8nLFLHwMSyjaWOPeIu9whzpZm+xnwuJeCShfHiOJcp5PEsxVO7E2WXsF2NSr/66ADIocO2VifDQ6keBEra/WSnxwM2ep07PMOZM8Q2LOEa/H2mjLbyEWCedCzZZltZue9k1iIT8tLxd0Mnxg9SvbvPHKCO7WXJshP3NuaOx/TdsOXlbjvcfc4pjI4ne7scQAR5d/fjw3xNQKQh4hbL9w0kqZy2F1Q+M1Tz46IeVcoEPtOOq6RBk9xVb9CCOK57CGMeNmHV9zfWTQF4xqdpYUsUyAXOxZH6RlgWtHO25X17EFBdXNEXAZdZMKDMH7Y896g3/5ODZ/6utbgjRQgMKjJkYyFCZ6KlmGP1TBs8BHFfw4zwVhXkjF2aOc+2xHiOZw71vc1Z4N3RlQk82VWTjCb3jTXhKkdWB69DSgz6irQgLHNad3QcxdvCVU+McRzCOaoPR9tNJfX2s/1JZffvw4lsbU3OtMZ6Q0qCODcUDmdLMI8df5NAZBCJC1vCBcveid84vjruOp3R9rhHbZCv/tL+zMut9hYTUFYFznG98KYFY0bmiLAuS6nxL5+/Sbky1aMws4ONwnJQ3vZBAiWwFERyNpKEVzzg1vC3c/IMsTTWBR0chQGD3I+iMTtfHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(136003)(39860400002)(478600001)(16576012)(6486002)(31686004)(4326008)(44832011)(956004)(921005)(5660300002)(36756003)(38100700002)(31696002)(8676002)(2616005)(16526019)(83380400001)(7416002)(8936002)(26005)(86362001)(186003)(66946007)(316002)(6636002)(7406005)(53546011)(38350700002)(2906002)(66556008)(66476007)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cnBRWEdSWG96WHZkMDVBMTdPMW9XUGhCTXd1cEtWSUR5aElVWTJDMnlFR0Jr?=
 =?utf-8?B?YTFhcnpiK2NlK2piZXQvNG1LWmk4cC9wbERzMEZRR2I3b2phcEFyN2wwVnRU?=
 =?utf-8?B?MWlRQmtvUEJzTzJXeHVWb1NteER1bXcyVitobDBjL3Z3SGowWVBnNXRzaGFQ?=
 =?utf-8?B?UktZRzByVTdhQWVnQThGK2NGa01HOGpYaUhDRmI5L1ZjaE5RMGtnNzRIdTlE?=
 =?utf-8?B?OGdMM3hmMDdMZDZuSFpJY2lpeUxtMmNYY1M5L21CTy9yOHVCcTg3VURoMDFa?=
 =?utf-8?B?VFdxbmIwZHArTEE1cVZxQ0phK1dKdjVKRHlWeXQ1eUY2cTg4b0JsZXJVclZQ?=
 =?utf-8?B?R2Z0Vko5cjh6M3kxWkU4cE9XRHZoZ2lKKytpT01lUkNCYTBpWXplSzR3WGJP?=
 =?utf-8?B?WE1vMWxpRndRNG9hOVB5aDNUZC9lVFYyZlB0bUpZZ1NsNkM2NVYzcU5vTlNJ?=
 =?utf-8?B?aTA5ZURFd1lIa0NFMHJPU2pPNUdBSDVjejdBQ3ZGWXlISjJvTEFCVklvc3h3?=
 =?utf-8?B?aXpPTDBvY1M1NVdzK0lrODByejBPY05zRUxsYzRSVDc3V1JmdVZMdjR3UFZW?=
 =?utf-8?B?RjIxeUtVTEVCUUpHZ1Z2cTBNZnF3TVU5NkJEcHlXQWhqenhmdjIwNVM4eGl2?=
 =?utf-8?B?UUI0QytwR0xUN09mOGxQOGUyNlJRdm1uRUpzTGpwQUNzamFIZGl4YlNFczRF?=
 =?utf-8?B?SER3dXVBSm9vT0FML0g0M1hZaUdFcWhUV21CYXFFeHJwSWZ2Z3k1OGFEdUdS?=
 =?utf-8?B?cCtKZ1pERW93YXpZd2tsVDB4d1laODcyZGVEZzd4R0dWWHRCZ0Q0N0ltVFlx?=
 =?utf-8?B?dW9kMGZqRncvRlFHVW1pUG02RjBFb3BwWHdRZVpNY3lTMmNOaW4zNENNSUVk?=
 =?utf-8?B?alVKK0g5d2JTdWZVV200dEQwQ3BlMDkvMi9XQ1FtaWh4RGNveGt6ZVNlOHM0?=
 =?utf-8?B?aTE4ODBQNkpLWndMSG4yckpEYXI0UUlCV3Eva1BweHl3dS8vOVFQWHQwWVdW?=
 =?utf-8?B?TEE0R1NZbjlweHJvZkNhOGk1YjR0a2R5RVE1OWxjSEVacHRDakJXT0dQemV6?=
 =?utf-8?B?NC9ZdnZQZjR0YmV1aFVVamtlSlVCR3RWeW9YWjJFUFJMRFJBU0tDRWczelNL?=
 =?utf-8?B?ZTNzemtldCtmWEs5cGRINXRpZjZTbXhRUlk3UHdaNk5Ic25uTjVrdlM1Wm1u?=
 =?utf-8?B?TVBhaWVJMll5WkoxZ29KWldmV0ZyKzIyamtzUGN4ZTZ2SE5zWnc5c2dVbW9O?=
 =?utf-8?B?dC9MbjRla1lFTHpXODhUd2ZVaU1aeHBkRi9TeUw5b25TQXUzZDZ2Qk0waDI4?=
 =?utf-8?B?K21WTE9SWlBZZk4rTjdINGRYYjlXTzFNODEvM0I1WG4rRVJUWW0rQzVVenlP?=
 =?utf-8?B?TkU1bmNBblMwZWJobjVMdS93NE96VXBPR3ZZS211YmZZeFMrYTMrcEY4N2JB?=
 =?utf-8?B?SVpIVkNnVlc1bW9saGVpWEZxNS8ySkRBejZJSW4raVp3eHBuTjB4YlVZSG1q?=
 =?utf-8?B?Z09wMUkxdnlPTG43Qmp2YU5JY0EzLzlURkwvK0pBTWx0L1FaK0hwWUcrTzJC?=
 =?utf-8?B?dllRTjVTQnRjcFJPZ3BwWHJoSzE5TDdUSVpXQXBoMjA3dU5oZVNwMDJqeitK?=
 =?utf-8?B?K3N5T0tvdERTM1hoUTlyWjJraDRvdTZTUDFKL2dueXk4YlRGWGVTMTByRm1L?=
 =?utf-8?B?SUVDVHIxcy9rb0tSVWlwSFk3TXFVbnFMV0xDTnlzRjZBeUVucWtLRGgrdGFn?=
 =?utf-8?Q?XUrmy0F9RMwSUCMOM5UkdRIlsffeepIqnK9RoiE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08fc82e-5c3c-41dd-b747-08d9100cdb64
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 21:29:25.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QImKSzhBVzFuY9bzv+FRZHfHKWQq2Lk+vZUnJIiic1dLO0EKKxwmdi+GjmG2XpqWP68zAh5F2vMqEwBk41vsJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5455
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050147
X-Proofpoint-GUID: lgDkRF5hgqSm1Vr6krk_YT6YnB8R1ikm
X-Proofpoint-ORIG-GUID: lgDkRF5hgqSm1Vr6krk_YT6YnB8R1ikm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050147
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/29/21 8:13 PM, Muchun Song wrote:
> In the subsequent patch, we should allocate the vmemmap pages when
> freeing a HugeTLB page. But update_and_free_page() can be called
> under any context, so we cannot use GFP_KERNEL to allocate vmemmap
> pages. However, we can defer the actual freeing in a kworker to
> prevent from using GFP_ATOMIC to allocate the vmemmap pages.
> 
> The __update_and_free_page() is where the call to allocate vmemmmap
> pages will be inserted.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c         | 83 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  mm/hugetlb_vmemmap.c | 12 --------
>  mm/hugetlb_vmemmap.h | 17 +++++++++++
>  3 files changed, 93 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index fd39fc94b23f..a3629c664f6a 100644
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
> @@ -1399,12 +1399,79 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
> +		/*
> +		 * The VM_BUG_ON_PAGE(!PageHuge(page), page) in page_hstate()
> +		 * is going to trigger because a previous call to
> +		 * remove_hugetlb_page() will set_compound_page_dtor(page,
> +		 * NULL_COMPOUND_DTOR), so do not use page_hstate() directly.
> +		 */
> +		h = size_to_hstate(page_size(page));
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

I like the addition of the atomic bool.  The only time atomic will be
set is in calls from free_huge_page.  And, depending on the workload
free_huge_page may only rarely free the page via update_and_free_page.
Pool adjustments via set_max_huge_pages where many pages are freed will
be done without atomic set and we will not defer to the work queue.

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
> @@ -1471,12 +1538,12 @@ void free_huge_page(struct page *page)
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
> @@ -1798,7 +1865,7 @@ int dissolve_free_huge_page(struct page *page)
>  		remove_hugetlb_page(h, page, false);
>  		h->max_huge_pages--;
>  		spin_unlock_irq(&hugetlb_lock);
> -		update_and_free_page(h, head);
> +		update_and_free_page(h, head, false);
>  		return 0;
>  	}
>  out:
> @@ -2343,14 +2410,14 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		 * Pages have been replaced, we can safely free the old one.
>  		 */
>  		spin_unlock_irq(&hugetlb_lock);
> -		update_and_free_page(h, old_page);
> +		update_and_free_page(h, old_page, false);
>  	}
>  
>  	return ret;
>  
>  free_new:
>  	spin_unlock_irq(&hugetlb_lock);
> -	update_and_free_page(h, new_page);
> +	update_and_free_page(h, new_page, false);
>  
>  	return ret;
>  }
> @@ -2764,6 +2831,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	 * pages in hstate via the proc/sysfs interfaces.
>  	 */
>  	mutex_lock(&h->resize_lock);
> +	flush_free_hpage_work(h);
>  	spin_lock_irq(&hugetlb_lock);
>  
>  	/*
> @@ -2873,6 +2941,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	/* free the pages after dropping lock */
>  	spin_unlock_irq(&hugetlb_lock);
>  	update_and_free_pages_bulk(h, &page_list);
> +	flush_free_hpage_work(h);

The above calls to flush the work queue make sense in set_max_huge_pages
as we are adjusting the pool count and want to make sure there is no
outstanding work before doing so.

I wonder if there are any other places where we want to flush the queue?
I can not think of any myself.

The addition of the work queue for deferred free processing is the
primary change from the previously reviewed version of this patch.  The
changes for this look correct to me.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

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
