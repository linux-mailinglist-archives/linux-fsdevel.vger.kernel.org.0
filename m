Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F53011CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 02:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbhAWBBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 20:01:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37810 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbhAWBBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:01:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10N0xd9m010265;
        Sat, 23 Jan 2021 00:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ISMNBWBhvOnU1BYczAOjmxCCFA8CzB1Mvy1L6eZq3P8=;
 b=Vr9Rgh2Z0SvMD79B9e4TMwJq+Nw7MEdzqrpdvo+tOQsYNxzGiDfaRuR1SanohBM+1H5w
 dwcSKS6nAECBMksR+1EhIjJzU7VfH6qvaWJFiUGSYCDfP7+ca0WGtn9wIyxB7axXa6SR
 UXkFN8XVF4fIf4rI4ytiIfSTDS4v0RSky7ttmLCFxQCJ/FAar+6pwd3cR2YEDFPP1xFu
 VzPhX8hlYA2unp17IFiRWmBJTuBuqPf4cjzdvbukwgA5tfmQaoA9Sk2LAxO58TVnIse9
 jqCWPpRSRqg71Vy5rujavqA+z0sBytw/yGAaiHreBk7YRvxP41vC6Gw8886yfqZ5c+dm RQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3668qaps67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jan 2021 00:59:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10N0xqoN053075;
        Sat, 23 Jan 2021 00:59:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3030.oracle.com with ESMTP id 3688wr9nfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jan 2021 00:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWYNUWZN0WQag6vrmvjGsaayWRzUf7AEo1nQgKQKT1U6Mc1P7gwod6Ssb70r34gTZH8W7PSYg3mwcGyCn0PdTgVUq1shrpi6AqkmPRTRL3YnjOGXb3UzSm0illwEdkZIuNJ1JQiuZSyTesyt5Ii8aivIYauGQDfkFglNdenWvWm1GlWnFgbI3RqEiT3O4ddkcQWfVakasVzDBfe/+i5kpXOwVZLdBY5uRG/e/ka5K3hLA/CXpgDlVcRzRJM1wWBpepqODcvRSH0KdNzTaxBF5CqEw/GOJbyCFlMQ/zgQxFG6ILSg3cBz5DgLjXPkPISJ4Yg8qqiWSFuku/YzATjDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISMNBWBhvOnU1BYczAOjmxCCFA8CzB1Mvy1L6eZq3P8=;
 b=Gmoi2ybfg4FkOaLLA8xSIBKSnzB0Y/JWywt1FpaWxH5e00URRPHcXVyZW/Ww6TnD8Cp1xhtk5XJsxQF760JnlxLtFROFEgEP5pvkmXQbrKFageyeXeG3aFOWus1ltWcbwxH2/BlzKJH0Qb+lsHkQUk1I/SljAs9Ut5LWhKuxRxBWk37miY8B9OL3KvUumc51OKH1vFXq3ObrqtrNVORUyi4NibWRRWolOgYGVGhJIsTLo1i4cJnBORLIcuUfZa+OnpoO61DFzfieIQW/Ut3kEa/1plji4V3xDXVPGCDyEbZIk2hdgIRhbJlt0H7Bg4uU11GScacgkUpHaoIS3pC7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISMNBWBhvOnU1BYczAOjmxCCFA8CzB1Mvy1L6eZq3P8=;
 b=gDP7vJtgl7rEQxylUFaKxem6xZUEU9BM7xRCKZOX8i9YAHQg4QMOtCBvVg5rZPqPvA+z4ybelKNtpMFTbJJrdm3tW/pZlGgQfWsgDWZMA/HcMfrr5bcd+DrCBP1PYHrqNAGgSsr5gQ94Q0r+jIPK2Kv9d5HpV2x8/hQvgy7fcwg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB2030.namprd10.prod.outlook.com (2603:10b6:300:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Sat, 23 Jan
 2021 00:59:52 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Sat, 23 Jan 2021
 00:59:52 +0000
Subject: Re: [PATCH v13 03/12] mm: hugetlb: free the vmemmap pages associated
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
        naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f547902d-8dd5-d116-ba8b-f94933679fd3@oracle.com>
Date:   Fri, 22 Jan 2021 16:59:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210117151053.24600-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:303:114::9) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0364.namprd03.prod.outlook.com (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Sat, 23 Jan 2021 00:59:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b1738d-ffc4-4bff-0bba-08d8bf3a3022
X-MS-TrafficTypeDiagnostic: MWHPR10MB2030:
X-Microsoft-Antispam-PRVS: <MWHPR10MB2030A761B6B81E1A2B37FF1EE2BF9@MWHPR10MB2030.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6B8dwKdys++IeRvemHpp9rttguMq4SNJS8zrVWj7inCz7QF89cQrP6ZH5N2c06g66j0RpsXdq1BBIgf0NCzTQR3vks1KbFJv5ohwDD/omHMjc01tnWE7PkLXzrNvArB5t3UHxmIzO4m7GUtyJwKJpHKhKEwaiVeS82LebScpw7KNrfHMg0cTQivFXFzv4KygibLs3PBgE8WtHFyqoalKBrikuI9DmIFRo6aIktBtUqLCa0xtR+3s8ANFbw5ZEXuHXdhI5A93AIrfEIMIH1O21kgr+sKImTiRKQ9aZExNCMg1b7Xsn5GMHB0Lcs6lCetH1hEFCvGAOBnEYqKLqvaPyZzgVqi0hoI/occCpU/a11fmnpcwz8oef93pRHHB3HVI/n8P+HbJZvXqKLRYIZw+MeIAN7gN9IiUMaNkLvxZEbbOH1HT8WWc+JsL+niYt5MCj49f1YrGO3HrjoXqUOmB3kjT5UoSuU6HeD7B/FQ1UIDIupIdr2aU2hIHldF6TOn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(53546011)(316002)(16526019)(26005)(66946007)(8676002)(31696002)(31686004)(7406005)(66556008)(921005)(2906002)(186003)(86362001)(8936002)(16576012)(7416002)(4326008)(66476007)(83380400001)(6486002)(956004)(36756003)(44832011)(52116002)(478600001)(30864003)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dDhyanhXVjF0Q09zVnZ3NTZSYmNXNDNhSmZ1OXROS05Wd3BHUDdjT3N0WmlD?=
 =?utf-8?B?NHZlaUZLaVRpNmdBMkJQQ1pFSkNSQlI1cmtzaEMxcThiaDN5WHNSOTVGMjVp?=
 =?utf-8?B?YVlYZ3lKckxsaU5hTUczZTdubWw0NnI2QTMyUXkwL0l1UWFnYm0vRytSNGFW?=
 =?utf-8?B?aWNSY0MvRDIwUXpiRWFHS2ZBazh2WnIrSmx3ZS9yeThqZ3BCd3VJVHIyaDNw?=
 =?utf-8?B?allpdnlXb3lvOVlhV0lmZ0dZS0pVL0NWUzZkQkVwWncyOXI1d0VuTXhvM3NY?=
 =?utf-8?B?a2RyNi9HdTU5Y2tjdzlyOXNKK3RtbVFKMmZ1blVvTGlQQXltOVc4ek0yNGNY?=
 =?utf-8?B?aEw1TFNUcEdOS3kvWU84SW1lQXR1dFJJTTFpZnNWWHlRbUdCK1R3Zm1paXRO?=
 =?utf-8?B?cVBNdVlNQTZyU3g2amJSZ0N2RDgwMTA1dk5icFRINUh2VXNSVXZjaWxESDh5?=
 =?utf-8?B?V3pOT0lqdW1WTjVtZHFQQkpuOHFZOHdjRXdReVFLcDlEMS9vTjlyY3JSZUZi?=
 =?utf-8?B?ZnBCcDV2a2kvUU56MEFrbVFmQ3V0M1FSdDBqRzJMM0dVZVh5SVk5MHdsbXQr?=
 =?utf-8?B?VlBadEtKTkkrVEZJWjRRand0VDk4U2ZOMXRvMFd5a3ZXSGtqV080OTJ5N0Jh?=
 =?utf-8?B?YVhORVZvcGtSMWFSUFpMcHhLa082Nm51eFYwOHdYYVlRY211bjhrNnY3NzJi?=
 =?utf-8?B?TTJqVDh1U1FTU0tLZkFzcVRYYWdnRmlVRVFCdS95ZnIwb0xWTE1Wb0Q2NDNN?=
 =?utf-8?B?WmtWWThvTFFlb1Q5RXp2M1V1b0cyZC9EVGlDQ1BZV2FpaXdlNEpzTFk5aDUv?=
 =?utf-8?B?SVRJNmN3ZEZHbjdoQ2gwUklRMnRVZG1KeFdFdmtxdElwTjk1UldrQWRFWjNr?=
 =?utf-8?B?dnpnd0IxWktSSWFPSmg3UXJrVFN5WnlWeXFwbDVIbVdOZ1g1azE2ZVBGU1hq?=
 =?utf-8?B?RlZPMjNSODArbytqNW5Ia2h3dnVPeW9BNDNVbnRhcDBya0ptTHhBN3hwUGoy?=
 =?utf-8?B?d1pZbjMrRVJ2WHV3dmtOSUFtQWtvQW9QUWpkT25RZGdkQ01IL2R0bEFFNnY5?=
 =?utf-8?B?ejB0U2xiUnAxb1F1ZWdDc3N2Znh3UUdQcU9zWG90dmovQU92QkNlU2lUbDNJ?=
 =?utf-8?B?S0tySm9IQ0lHUmkwUHI2TEFHaGZLRjJoUUtGT0hFUzR3S01TYmVVSnFTUk9C?=
 =?utf-8?B?TDlvMEFpV1IxMDZlNE9zekZCb2xnTC8xTEdzVjcwVjlMMXUxOVVDd1RHY3RP?=
 =?utf-8?B?d0tVM2s2a1RuZzZOKzdab1lPeHh2RjN4cDVpeGxsRzM3SEVzZ0t2Z3Nrd0pY?=
 =?utf-8?B?d1Z1and4SUpLU0kzSVlkQ2pMVVBXdGM4WmJlQW1ES3dNMEhrVHhiZGJrNWM2?=
 =?utf-8?B?UUsxcEpIeUhoeWZxVk1XMjFTT3NOeEZtZm9YMExwRUJoZFNpRitKVmllRXlB?=
 =?utf-8?Q?Rx12SHRC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b1738d-ffc4-4bff-0bba-08d8bf3a3022
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2021 00:59:51.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvgIzC/EfP9hPXLDsgjiapHI2WLw2oPoDHWzS4Q88PWHGv48jlIbUnpMX4HF/QcOwXlrUUa4+mTNEFI/U1lFMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2030
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101230002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101230002
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/17/21 7:10 AM, Muchun Song wrote:
> Every HugeTLB has more than one struct page structure. We __know__ that
> we only use the first 4(HUGETLB_CGROUP_MIN_ORDER) struct page structures
> to store metadata associated with each HugeTLB.
> 
> There are a lot of struct page structures associated with each HugeTLB
> page. For tail pages, the value of compound_head is the same. So we can
> reuse first page of tail page structures. We map the virtual addresses
> of the remaining pages of tail page structures to the first tail page
> struct, and then free these page frames. Therefore, we need to reserve
> two pages as vmemmap areas.
> 
> When we allocate a HugeTLB page from the buddy, we can free some vmemmap
> pages associated with each HugeTLB page. It is more appropriate to do it
> in the prep_new_huge_page().
> 
> The free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
> pages associated with a HugeTLB page can be freed, returns zero for
> now, which means the feature is disabled. We will enable it once all
> the infrastructure is there.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/bootmem_info.h |  27 +++++-
>  include/linux/mm.h           |   3 +
>  mm/Makefile                  |   1 +
>  mm/hugetlb.c                 |   3 +
>  mm/hugetlb_vmemmap.c         | 211 +++++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.h         |  20 ++++
>  mm/sparse-vmemmap.c          | 198 ++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 462 insertions(+), 1 deletion(-)
>  create mode 100644 mm/hugetlb_vmemmap.c
>  create mode 100644 mm/hugetlb_vmemmap.h

Thank you for the continued updates!  Just some comments below.
I am hoping that others can take a look so we can move this forward.
I do not see any obvious issues.

> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> index 4ed6dee1adc9..ec03a624dfa2 100644
> --- a/include/linux/bootmem_info.h
> +++ b/include/linux/bootmem_info.h
> @@ -2,7 +2,7 @@
>  #ifndef __LINUX_BOOTMEM_INFO_H
>  #define __LINUX_BOOTMEM_INFO_H
>  
> -#include <linux/mmzone.h>
> +#include <linux/mm.h>
>  
>  /*
>   * Types for free bootmem stored in page->lru.next. These have to be in
> @@ -22,6 +22,27 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
>  void get_page_bootmem(unsigned long info, struct page *page,
>  		      unsigned long type);
>  void put_page_bootmem(struct page *page);
> +
> +/*
> + * Any memory allocated via the memblock allocator and not via the
> + * buddy will be marked reserved already in the memmap. For those
> + * pages, we can call this function to free it to buddy allocator.
> + */
> +static inline void free_bootmem_page(struct page *page)
> +{
> +	unsigned long magic = (unsigned long)page->freelist;
> +
> +	/*
> +	 * The reserve_bootmem_region sets the reserved flag on bootmem
> +	 * pages.
> +	 */
> +	VM_BUG_ON_PAGE(page_ref_count(page) != 2, page);
> +
> +	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> +		put_page_bootmem(page);
> +	else
> +		VM_BUG_ON_PAGE(1, page);
> +}
>  #else
>  static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
>  {
> @@ -35,6 +56,10 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
>  				    unsigned long type)
>  {
>  }
> +
> +static inline void free_bootmem_page(struct page *page)
> +{
> +}
>  #endif
>  
>  #endif /* __LINUX_BOOTMEM_INFO_H */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index eabe7d9f80d8..f928994ed273 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3005,6 +3005,9 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>  }
>  #endif
>  
> +void vmemmap_remap_free(unsigned long start, unsigned long end,
> +			unsigned long reuse);
> +
>  void *sparse_buffer_alloc(unsigned long size);
>  struct page * __populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
> diff --git a/mm/Makefile b/mm/Makefile
> index ed4b88fa0f5e..056801d8daae 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_FRONTSWAP)	+= frontswap.o
>  obj-$(CONFIG_ZSWAP)	+= zswap.o
>  obj-$(CONFIG_HAS_DMA)	+= dmapool.o
>  obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
> +obj-$(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)	+= hugetlb_vmemmap.o
>  obj-$(CONFIG_NUMA) 	+= mempolicy.o
>  obj-$(CONFIG_SPARSEMEM)	+= sparse.o
>  obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1f3bf1710b66..140135fc8113 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -42,6 +42,7 @@
>  #include <linux/userfaultfd_k.h>
>  #include <linux/page_owner.h>
>  #include "internal.h"
> +#include "hugetlb_vmemmap.h"
>  
>  int hugetlb_max_hstate __read_mostly;
>  unsigned int default_hstate_idx;
> @@ -1497,6 +1498,8 @@ void free_huge_page(struct page *page)
>  
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
> +	free_huge_page_vmemmap(h, page);
> +
>  	INIT_LIST_HEAD(&page->lru);
>  	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>  	set_hugetlb_cgroup(page, NULL);
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> new file mode 100644
> index 000000000000..4ffa2a4ae2a8
> --- /dev/null
> +++ b/mm/hugetlb_vmemmap.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Free some vmemmap pages of HugeTLB
> + *
> + * Copyright (c) 2020, Bytedance. All rights reserved.
> + *
> + *     Author: Muchun Song <songmuchun@bytedance.com>
> + *
> + * The struct page structures (page structs) are used to describe a physical
> + * page frame. By default, there is a one-to-one mapping from a page frame to
> + * it's corresponding page struct.
> + *
> + * The HugeTLB pages consist of multiple base page size pages and is supported
> + * by many architectures. See hugetlbpage.rst in the Documentation directory
> + * for more details. On the x86-64 architecture, HugeTLB pages of size 2MB and
> + * 1GB are currently supported. Since the base page size on x86 is 4KB, a 2MB
> + * HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
> + * 4096 base pages. For each base page, there is a corresponding page struct.
> + *
> + * Within the HugeTLB subsystem, only the first 4 page structs are used to
> + * contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
> + * provides this upper limit. The only 'useful' information in the remaining
> + * page structs is the compound_head field, and this field is the same for all
> + * tail pages.
> + *
> + * By removing redundant page structs for HugeTLB pages, memory can be returned
> + * to the buddy allocator for other uses.
> + *
> + * Different architectures support different HugeTLB pages. For example, the
> + * following table is the HugeTLB page size supported by x86 and arm64
> + * architectures. Becasue arm64 supports 4k, 16k, and 64k base pages and
> + * supports contiguous entries, so it supports many kinds of sizes of HugeTLB
> + * page.
> + *
> + * +--------------+-----------+-----------------------------------------------+
> + * | Architecture | Page Size |                HugeTLB Page Size              |
> + * +--------------+-----------+-----------+-----------+-----------+-----------+
> + * |    x86-64    |    4KB    |    2MB    |    1GB    |           |           |
> + * +--------------+-----------+-----------+-----------+-----------+-----------+
> + * |              |    4KB    |   64KB    |    2MB    |    32MB   |    1GB    |
> + * |              +-----------+-----------+-----------+-----------+-----------+
> + * |    arm64     |   16KB    |    2MB    |   32MB    |     1GB   |           |
> + * |              +-----------+-----------+-----------+-----------+-----------+
> + * |              |   64KB    |    2MB    |  512MB    |    16GB   |           |
> + * +--------------+-----------+-----------+-----------+-----------+-----------+
> + *
> + * When the system boot up, every HugeTLB page has more than one struct page
> + * structs whose size is (unit: pages):
> + *
> + *    struct_size = HugeTLB_Size / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
> + *
> + * Where HugeTLB_Size is the size of the HugeTLB page. We know that the size
> + * of the HugeTLB page is always n times PAGE_SIZE. So we can get the following
> + * relationship.
> + *
> + *    HugeTLB_Size = n * PAGE_SIZE
> + *
> + * Then,
> + *
> + *    struct_size = n * PAGE_SIZE / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
> + *                = n * sizeof(struct page) / PAGE_SIZE
> + *
> + * We can use huge mapping at the pud/pmd level for the HugeTLB page.
> + *
> + * For the HugeTLB page of the pmd level mapping, then
> + *
> + *    struct_size = n * sizeof(struct page) / PAGE_SIZE
> + *                = PAGE_SIZE / sizeof(pte_t) * sizeof(struct page) / PAGE_SIZE
> + *                = sizeof(struct page) / sizeof(pte_t)
> + *                = 64 / 8
> + *                = 8 (pages)
> + *
> + * Where n is how many pte entries which one page can contains. So the value of
> + * n is (PAGE_SIZE / sizeof(pte_t)).
> + *
> + * This optimization only supports 64-bit system, so the value of sizeof(pte_t)
> + * is 8. And this optimization also applicable only when the size of struct page
> + * is a power of two. In most cases, the size of struct page is 64 (e.g. x86-64
> + * and arm64). So if we use pmd level mapping for a HugeTLB page, the size of
> + * struct page structs of it is 8 pages whose size depends on the size of the
> + * base page.
> + *
> + * For the HugeTLB page of the pud level mapping, then
> + *
> + *    struct_size = PAGE_SIZE / sizeof(pmd_t) * struct_size(pmd)
> + *                = PAGE_SIZE / 8 * 8 (pages)
> + *                = PAGE_SIZE (pages)
> + *
> + * Where the struct_size(pmd) is the size of the struct page structs of a
> + * HugeTLB page of the pmd level mapping.
> + *
> + * Next, we take the pmd level mapping of the HugeTLB page as an example to
> + * show the internal implementation of this optimization. There are 8 pages
> + * struct page structs associated with a HugeTLB page which is pmd mapped.
> + *
> + * Here is how things look before optimization.
> + *
> + *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> + * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> + * |           |                     |     0     | -------------> |     0     |
> + * |           |                     +-----------+                +-----------+
> + * |           |                     |     1     | -------------> |     1     |
> + * |           |                     +-----------+                +-----------+
> + * |           |                     |     2     | -------------> |     2     |
> + * |           |                     +-----------+                +-----------+
> + * |           |                     |     3     | -------------> |     3     |
> + * |           |                     +-----------+                +-----------+
> + * |           |                     |     4     | -------------> |     4     |
> + * |    PMD    |                     +-----------+                +-----------+
> + * |   level   |                     |     5     | -------------> |     5     |
> + * |  mapping  |                     +-----------+                +-----------+
> + * |           |                     |     6     | -------------> |     6     |
> + * |           |                     +-----------+                +-----------+
> + * |           |                     |     7     | -------------> |     7     |
> + * |           |                     +-----------+                +-----------+
> + * |           |
> + * |           |
> + * |           |
> + * +-----------+
> + *
> + * The value of page->compound_head is the same for all tail pages. The first
> + * page of page structs (page 0) associated with the HugeTLB page contains the 4
> + * page structs necessary to describe the HugeTLB. The only use of the remaining
> + * pages of page structs (page 1 to page 7) is to point to page->compound_head.
> + * Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
> + * will be used for each HugeTLB page. This will allow us to free the remaining
> + * 6 pages to the buddy allocator.
> + *
> + * Here is how things look after remapping.
> + *
> + *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> + * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> + * |           |                     |     0     | -------------> |     0     |
> + * |           |                     +-----------+                +-----------+
> + * |           |                     |     1     | -------------> |     1     |
> + * |           |                     +-----------+                +-----------+
> + * |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
> + * |           |                     +-----------+                   | | | | |
> + * |           |                     |     3     | ------------------+ | | | |
> + * |           |                     +-----------+                     | | | |
> + * |           |                     |     4     | --------------------+ | | |
> + * |    PMD    |                     +-----------+                       | | |
> + * |   level   |                     |     5     | ----------------------+ | |
> + * |  mapping  |                     +-----------+                         | |
> + * |           |                     |     6     | ------------------------+ |
> + * |           |                     +-----------+                           |
> + * |           |                     |     7     | --------------------------+
> + * |           |                     +-----------+
> + * |           |
> + * |           |
> + * |           |
> + * +-----------+
> + *
> + * When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
> + * vmemmap pages and restore the previous mapping relationship.
> + *
> + * For the HugeTLB page of the pud level mapping. It is similar to the former.
> + * We also can use this approach to free (PAGE_SIZE - 2) vmemmap pages.
> + *
> + * Apart from the HugeTLB page of the pmd/pud level mapping, some architectures
> + * (e.g. aarch64) provides a contiguous bit in the translation table entries
> + * that hints to the MMU to indicate that it is one of a contiguous set of
> + * entries that can be cached in a single TLB entry.
> + *
> + * The contiguous bit is used to increase the mapping size at the pmd and pte
> + * (last) level. So this type of HugeTLB page can be optimized only when its
> + * size of the struct page structs is greater than 2 pages.
> + */
> +#include "hugetlb_vmemmap.h"
> +
> +/*
> + * There are a lot of struct page structures associated with each HugeTLB page.
> + * For tail pages, the value of compound_head is the same. So we can reuse first
> + * page of tail page structures. We map the virtual addresses of the remaining
> + * pages of tail page structures to the first tail page struct, and then free
> + * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
> + */
> +#define RESERVE_VMEMMAP_NR		2U
> +#define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
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
> +
> +static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> +{
> +	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> +}
> +
> +void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +	unsigned long vmemmap_addr = (unsigned long)head;
> +	unsigned long vmemmap_end, vmemmap_reuse;
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return;
> +
> +	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> +	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> +	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> +
> +	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
> +}
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> new file mode 100644
> index 000000000000..6923f03534d5
> --- /dev/null
> +++ b/mm/hugetlb_vmemmap.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Free some vmemmap pages of HugeTLB
> + *
> + * Copyright (c) 2020, Bytedance. All rights reserved.
> + *
> + *     Author: Muchun Song <songmuchun@bytedance.com>
> + */
> +#ifndef _LINUX_HUGETLB_VMEMMAP_H
> +#define _LINUX_HUGETLB_VMEMMAP_H
> +#include <linux/hugetlb.h>
> +
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +void free_huge_page_vmemmap(struct hstate *h, struct page *head);
> +#else
> +static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +}
> +#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
> +#endif /* _LINUX_HUGETLB_VMEMMAP_H */
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 16183d85a7d5..ce4be1fa93c2 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -27,8 +27,206 @@
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched.h>
> +#include <linux/pgtable.h>
> +#include <linux/bootmem_info.h>
> +
>  #include <asm/dma.h>
>  #include <asm/pgalloc.h>
> +#include <asm/tlbflush.h>
> +

We made the decision to disable PMD mapping of the vmemmap if this feature
is enabled.  However, that is not until later in the series.  And, the code
which disables PMD mapping is done in arch specific init code.  So, a reader
of this new code in sparse-vmemmap.c might not be aware of this.  But, the
code below depends on vmemmap being base page mapped.

I know your plan is to perhaps remove this restriction in the future.
Perhaps we should have a big comment in the code (?and commit message?)
noting that this is designed to only work with base page mappings so that
people do not get confused?

> +/**
> + * vmemmap_remap_walk - walk vmemmap page table
> + *
> + * @remap_pte:		called for each non-empty PTE (lowest-level) entry.
> + * @reuse_page:		the page which is reused for the tail vmemmap pages.
> + * @reuse_addr:		the virtual address of the @reuse_page page.
> + * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
> + */
> +struct vmemmap_remap_walk {
> +	void (*remap_pte)(pte_t *pte, unsigned long addr,
> +			  struct vmemmap_remap_walk *walk);
> +	struct page *reuse_page;
> +	unsigned long reuse_addr;
> +	struct list_head *vmemmap_pages;
> +};
> +
> +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> +			      unsigned long end,
> +			      struct vmemmap_remap_walk *walk)
> +{
> +	pte_t *pte;
> +
> +	pte = pte_offset_kernel(pmd, addr);
> +
> +	/*
> +	 * The reuse_page is found 'first' in table walk before we start
> +	 * remapping (which is calling @walk->remap_pte).
> +	 */
> +	if (walk->reuse_addr == addr) {
> +		BUG_ON(pte_none(*pte));
> +
> +		walk->reuse_page = pte_page(*pte++);
> +		/*
> +		 * Becasue the reuse address is part of the range that we are
> +		 * walking, skip the reuse address range.
> +		 */
> +		addr += PAGE_SIZE;
> +	}
> +
> +	for (; addr != end; addr += PAGE_SIZE, pte++) {
> +		BUG_ON(pte_none(*pte));
> +
> +		walk->remap_pte(pte, addr, walk);
> +	}
> +}
> +
> +static void vmemmap_pmd_range(pud_t *pud, unsigned long addr,
> +			      unsigned long end,
> +			      struct vmemmap_remap_walk *walk)
> +{
> +	pmd_t *pmd;
> +	unsigned long next;
> +
> +	pmd = pmd_offset(pud, addr);
> +	do {
> +		BUG_ON(pmd_none(*pmd));
> +
> +		next = pmd_addr_end(addr, end);
> +		vmemmap_pte_range(pmd, addr, next, walk);
> +	} while (pmd++, addr = next, addr != end);
> +}
> +
> +static void vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
> +			      unsigned long end,
> +			      struct vmemmap_remap_walk *walk)
> +{
> +	pud_t *pud;
> +	unsigned long next;
> +
> +	pud = pud_offset(p4d, addr);
> +	do {
> +		BUG_ON(pud_none(*pud));
> +
> +		next = pud_addr_end(addr, end);
> +		vmemmap_pmd_range(pud, addr, next, walk);
> +	} while (pud++, addr = next, addr != end);
> +}
> +
> +static void vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
> +			      unsigned long end,
> +			      struct vmemmap_remap_walk *walk)
> +{
> +	p4d_t *p4d;
> +	unsigned long next;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	do {
> +		BUG_ON(p4d_none(*p4d));
> +
> +		next = p4d_addr_end(addr, end);
> +		vmemmap_pud_range(p4d, addr, next, walk);
> +	} while (p4d++, addr = next, addr != end);
> +}
> +
> +static void vmemmap_remap_range(unsigned long start, unsigned long end,
> +				struct vmemmap_remap_walk *walk)
> +{
> +	unsigned long addr = start;
> +	unsigned long next;
> +	pgd_t *pgd;
> +
> +	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> +	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +
> +	pgd = pgd_offset_k(addr);
> +	do {
> +		BUG_ON(pgd_none(*pgd));
> +
> +		next = pgd_addr_end(addr, end);
> +		vmemmap_p4d_range(pgd, addr, next, walk);
> +	} while (pgd++, addr = next, addr != end);
> +
> +	/*
> +	 * We do not change the mapping of the vmemmap virtual address range
> +	 * [@start, @start + PAGE_SIZE) which is belong to the reuse range.
> +	 * So we not need to flush the TLB.
> +	 */
> +	flush_tlb_kernel_range(start - PAGE_SIZE, end);
> +}
> +
> +/*
> + * Free a vmemmap page. A vmemmap page can be allocated from the memblock
> + * allocator or buddy allocator. If the PG_reserved flag is set, it means
> + * that it allocated from the memblock allocator, just free it via the
> + * free_bootmem_page(). Otherwise, use __free_page().
> + */
> +static inline void free_vmemmap_page(struct page *page)
> +{
> +	if (PageReserved(page))
> +		free_bootmem_page(page);
> +	else
> +		__free_page(page);
> +}
> +
> +/* Free a list of the vmemmap pages */
> +static void free_vmemmap_page_list(struct list_head *list)
> +{
> +	struct page *page, *next;
> +
> +	list_for_each_entry_safe(page, next, list, lru) {
> +		list_del(&page->lru);
> +		free_vmemmap_page(page);
> +	}
> +}
> +
> +static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
> +			      struct vmemmap_remap_walk *walk)
> +{
> +	/*
> +	 * Remap the tail pages as read-only to catch illegal write operation
> +	 * to the tail pages.
> +	 */
> +	pgprot_t pgprot = PAGE_KERNEL_RO;
> +	pte_t entry = mk_pte(walk->reuse_page, pgprot);
> +	struct page *page = pte_page(*pte);
> +
> +	list_add(&page->lru, walk->vmemmap_pages);
> +	set_pte_at(&init_mm, addr, pte, entry);
> +}
> +
> +/**
> + * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
> + *			to the page which @reuse is mapped, then free vmemmap
> + *			pages.
> + * @start:	start address of the vmemmap virtual address range.
> + * @end:	end address of the vmemmap virtual address range.
> + * @reuse:	reuse address.
> + */
> +void vmemmap_remap_free(unsigned long start, unsigned long end,
> +			unsigned long reuse)
> +{
> +	LIST_HEAD(vmemmap_pages);
> +	struct vmemmap_remap_walk walk = {
> +		.remap_pte	= vmemmap_remap_pte,
> +		.reuse_addr	= reuse,
> +		.vmemmap_pages	= &vmemmap_pages,
> +	};
> +
> +	/*
> +	 * In order to make remapping routine most efficient for the huge pages,
> +	 * the routine of vmemmap page table walking has the following rules
> +	 * (see more details from the vmemmap_pte_range()):
> +	 *
> +	 * - The @reuse address is part of the range that we are walking.
> +	 * - The @reuse address is the first in the complete range.
> +	 *
> +	 * So we need to make sure that @start and @reuse meet the above rules.
> +	 */

Thanks for adding this comment.

For now this code only works for huge pages.  We need to make sure that is
clear to reviewers and people just reading the code.

-- 
Mike Kravetz

> +	BUG_ON(start - reuse != PAGE_SIZE);
> +
> +	vmemmap_remap_range(reuse, end, &walk);
> +	free_vmemmap_page_list(&vmemmap_pages);
> +}
>  
>  /*
>   * Allocate a block of memory to be used to back the virtual memory map
> 
