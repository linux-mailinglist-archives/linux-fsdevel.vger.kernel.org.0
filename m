Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B205364E8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 01:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhDSXVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 19:21:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52340 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhDSXVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 19:21:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JNJiOh052534;
        Mon, 19 Apr 2021 23:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Bk8wwxYd+kDH3jpezSgSgjutEs0HZtZdSGOtpK33yuk=;
 b=EWFAAH+pkJb0OxYy/R8vRXbHKi1wgVk/lQ0vkk3RSVk1IwvWbLi12zqFVIG/h/cWIpk4
 AFanydbmdoNys0rdxy42/r7OkpuwkJWe+nLtx70L+Rek6npJd2s1K5nxvNajRT2a5ZnJ
 MWESoCIgdVmaPe+pjgXrYCIPwEs04SBiSkwQueDNL+ZA9ELXWdc0j0ZuJIvTkrFZfhyo
 r9KFxboCUlIcd+HhLEFj6tDRlKGNKPEtoWgBCDmOOvPcARUghk8tvaVXtY/kWTUTG0AI
 hI8BxIHm2qgLsxxyK8vhZuIwvru4oF/FBRIvp3qoUuSog4BB+Az8UWntW54QMCcrpEvQ nA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37yn6c5es4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 23:19:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JNG5dP053623;
        Mon, 19 Apr 2021 23:19:53 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by aserp3020.oracle.com with ESMTP id 3809jyg9dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 23:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMEYCBtNdQL75+o3QabmIcs6rO7RhvkG6hiS1RGRIY7bAkW4yNdbsoboKu5MSbLXiBG4f3j1DqX3zWDe6j66hyHRF/JKvfF42ges+Y/cnLDdG44g7UXi+igMCYwLsDiluabuwO+MvbMiWjeLg7mQrQcGorJwQ4Y7LwRmWTK6qw0el2UXbu7iyqlQFNGTeBEeE98bjfSyOgsaWTrsNUkestttQ8G5KrgaoKK1PWywoxh6QHJX4AqeGAwbyna6IVoI45eBleqW45nx2wZxfn4jkUyssIvk+dm0gdW5Z6YzSQaMuokIkMro8kirYOTFhtZpoE9KKlRoIpAzhktIghfR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk8wwxYd+kDH3jpezSgSgjutEs0HZtZdSGOtpK33yuk=;
 b=l9Z+q7a4aMPFzMa7NZMo6s6/8g1MsArISpbqCKzN4sksF30NGCK7dGGo66IEKShNAm1DJhZxEe/6NQ94Dsz9O6STJEPbNcdONPRXfVTD06MmRbdIFeiQ5/sdtGgETOMoEWV3zq1K/6hpf/y0YAmLtJIroLndB/5voxpRh7NJYRTMITikeNUhuMwSiHNAqpKnlJhW+sTC64JAeTBPFF3HzlUILEiNNqkRwnySkddgiWOmBb+4jWekMTRtjVfDET2W1TIPfJ2h89dE2YDcDcdR/lCvyjdonuBfk7ZxNIHiiWSuBq718ieVvXbmzLd0xS7HgOBVJoydkrKjkM8SpPRhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk8wwxYd+kDH3jpezSgSgjutEs0HZtZdSGOtpK33yuk=;
 b=SxbAvzHAIoxt13wHpM7jn1MEBnt5UdTKjmEIW+ja0xo8AfUWscETFFbIDR2b3HJHelORxUmL1FmDAb5FBUQ6EQ7/zYdpRhlORH8oLy2HRga7zZJEiLI6BA+ybNAuttG9GJsZsWPlixAHEgL1LQkcmr5p6pa3IkFqj9CF4Yev6FY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5486.namprd10.prod.outlook.com (2603:10b6:a03:301::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 23:19:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 23:19:50 +0000
Subject: Re: [PATCH v20 6/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
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
 <20210415084005.25049-7-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5f914142-009b-3bfc-9cb2-46154f610e29@oracle.com>
Date:   Mon, 19 Apr 2021 16:19:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210415084005.25049-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:101:1f::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0047.namprd15.prod.outlook.com (2603:10b6:101:1f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 23:19:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07a1ba31-bea4-48a7-9ec9-08d90389a0e8
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5486371FFB356662010C7108E2499@SJ0PR10MB5486.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gf7KB+yqPfCs5qgJYAoHbdEuqPbbBzYLzIBUxEkecw5k4ZqAto5/WKEoXPveL+s6UCLJkK7hRGwunk4/jNIoM9YCkeS0Ml9FjruPIsL+yYYIr1tjnLaOBYdNfOLSYF8HZ6KgskrQqrali0B2AEjXef3RITQ8mR7pyXq8olnMlQ4oYOo1OcvfE8fvNpFm0N8pQ2eWTqB/ftcBnWyuT2utcZD05wXRA6LgcD1OPC3gVTeUXbfgXu7jngd5RZym5PAQGtQ8LNCBLlXzfOiA3k2QJ5Ms2cUAht3p21bT9J0dAN149o8+Dum4ve/o7VArdiQqjAhiSv7/sabqQs5b9cfJDabtvitnVayE5Vers3esV6O2Sbcwkc5fXzHv1O6OSeS+iSATJPZs+JETU0XLQKKWO/+89dAGeSIn5xk2m3SMk3a2q4GahzT6mdYHRqGXeTS8RBj63MDzI6MfdQsT37AR0qao6BFKM5O1DPWaWKf391ZjXkhPvLWG3WNsRtJoccaGOSKwLvm4PFEp9TYh9g/u04GegiRGPkrREsNpDov1GXlw+L0uGYB7NydG9m0A/YiK/l04YbJITDRyYXTXzhzwPHCADCIVbqX4HihiSJsXKdBgKGqBR3KZ/ZtsbE4O+AcTNQ+ip3lDEOX0WNzqZLstA7fxzl0J7F4SVoLn+swO2vkR9aiBcuxHerozG48CEXmTRR8+wI+jYHGFCa7EUYP/B9gSIHvpl/SZr5i0jOzbaUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(376002)(346002)(6636002)(66476007)(66556008)(5660300002)(66946007)(8676002)(53546011)(26005)(16526019)(7406005)(478600001)(86362001)(31686004)(186003)(83380400001)(7416002)(16576012)(2616005)(316002)(8936002)(38350700002)(36756003)(2906002)(6486002)(44832011)(52116002)(38100700002)(4326008)(956004)(30864003)(921005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NWFQaWJ4NVBFQk9BeUpCUkh3YlBtd08wT2N6Z2d3YXBaNUxnRDJpUzBvd2Y1?=
 =?utf-8?B?QmlYdTRtcUYvbGlaRlBzcjBYTE5xTmM2aXhCdTV4WkdPYitUdzVUM0hyek1J?=
 =?utf-8?B?Y1NXUEVGSzRqbW5VUXhQWjRrS3F5a0dXODlRT1Q4dVRYeEVwcGRCOGxqKzJB?=
 =?utf-8?B?S0hEdnBsbXFoUU13MVAwZmpwQWx6dmlWaFFrMUZtRkgzWW5YVklUUEh3djcz?=
 =?utf-8?B?YU5HUjBYNVE0cEZYSWZSMXlCRnFtdFlDTFNFR3JlWUliN2FHaWlLVHMzUlRC?=
 =?utf-8?B?aE4ydDMyY2RpbmNaMXFsdE9xU0NXaXN5MFRHcW9iQ2IvZHJmUGxMSzE5WlFP?=
 =?utf-8?B?SXZ4ekxMUi91REw1VWRQekZxS01HT3pjVHYrZDF1WFoyN2tWTEUzTlU0T0d0?=
 =?utf-8?B?VnBxMitZZW9TSVptOThiMzNYczExYWFKVC92bUdTQ3d1N1p0Q0k4UjdnNHpD?=
 =?utf-8?B?c0N1UktWYW1XRnh3UmUyUGw0RHBONkt0SitZQ2F0TmdlOVZKN0UyTXNmSEpO?=
 =?utf-8?B?YzFBR1lXeEhjWnlIcE5VMzZ0elpGempGa29zV0FMNG4yc1N2S0xPdWZhdU1s?=
 =?utf-8?B?Zjhsbk5yZTAxRVJVMThvbmFMUk53MWczTlRCQ1pmbDJQNzQ3cmRJM2NsZnZr?=
 =?utf-8?B?ODdpdjhWeFVBbHB3T0JUUzV3dGt0eHN5b2tCeW1qTVJRNzIvd1UvVnh1RThh?=
 =?utf-8?B?djIyTE4wTjJscGVueFFhcktxV3hJdGd4ZnpZVEdySDEvKzhNR2ZKVmhIekph?=
 =?utf-8?B?eVRUc3pMdE1ISkxSaXBPdEdMZU9tR3laYmhKTE5nWTJjdDhDV3E3WFJVcC93?=
 =?utf-8?B?c3NMbGJtSXVuRjd2aXlVYSt0QWVBb1JhVExqa0VNdFBQZlBKQXZ3c3UwaGNX?=
 =?utf-8?B?dlVWeXpCQVE0T3NtWHRNTDV1SnMvM0ZEWmFFNTl1YTNFRlhBQ1NVVXMwUUFB?=
 =?utf-8?B?RVo0SGJyaGQvNHpnTHEwVnZLcjZ1eldkcERINGFxUG9UNkRqR3RSYlAyOVI4?=
 =?utf-8?B?QWtvYnlOZFZXOW1WZzl4WlF1WjdLUmlpRmVZL1dZalRzWVFmVmowNDluRnZE?=
 =?utf-8?B?SlVXOEhNZGl5NFY4VnU4SThyWkhnQWlsYjN4dUZDN0VJUXdCR0RSa0p3SFUy?=
 =?utf-8?B?MHh2RU5SQWtVY0U3MFZXWS96S0JzZ3FpbFMxcG5Lcm1IVWNzMEkyUDh1cXJj?=
 =?utf-8?B?bmFLNHhRZTJRT3h5QXNnZUFsN014dEVqWjJ1Ri95TFBnQy9yL1FUbzRiTkhO?=
 =?utf-8?B?MitCN2dHUlBqUGFMOThWYW41RFc0Titseithb2xCcS9MejJnS2hQWERyUlY3?=
 =?utf-8?B?ejdFZGUwRzgrLzhuK1NxaU1OMVJWaUVWUVYzdUQ2V2xXdVc2NVY1YkJGYmZY?=
 =?utf-8?B?elltaU9Na0RMYjI0eUJteW5OK2JscEhtZWV3enBIVkUwZEhCSkFLaG0xT1lx?=
 =?utf-8?B?RGZ2V2lWU1E2dmhVVGFCSVJlbnJYa1ZORHBvOER6eVJZUzlOQmpuUmNldWFU?=
 =?utf-8?B?OWVwbi9JOVV2d1d2Rlo3TWpUY25RRTdsaHU1eFRsQTJySHdXY3hsK1JoQXZ6?=
 =?utf-8?B?RWNxRkRyU1A2Y2hpYlQxS0tlalNOVHc1VllTZ1hiZDZYTkNSZUZOM0laRC9B?=
 =?utf-8?B?K3RMSEJuSjZubklhY2ZJWFltL1MwQXZnMENIT3BvNmF4VEUyemVmSW9mSWNU?=
 =?utf-8?B?ek9ya2k5K1pMLzd1bHd1ck04YVo2c08zVFNhRzNaamVaUjVDU1RvcklXK3JK?=
 =?utf-8?Q?MGf9iHsnPuLch6LJEhO5GNwDJf6N8NagpGjPwcw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a1ba31-bea4-48a7-9ec9-08d90389a0e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 23:19:50.1010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trpNs6e1w3ujiUwL4/wN/aRPg8QwqFKjZlyeSG0TaFj8c7MAntJAnRuWSGJPwTf4v1NBfxnbAgSy3xRDIti4KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5486
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190160
X-Proofpoint-GUID: C3CLMp5Pw-mIGtEW9KwEUam3H0jQmOef
X-Proofpoint-ORIG-GUID: C3CLMp5Pw-mIGtEW9KwEUam3H0jQmOef
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190160
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/21 1:40 AM, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we need to allocate
> the vmemmap pages associated with it. However, we may not be able to
> allocate the vmemmap pages when the system is under memory pressure. In
> this case, we just refuse to free the HugeTLB page. This changes behavior
> in some corner cases as listed below:
> 
>  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> 
>     User needs to try again later.
> 
>  2) Failing to free a surplus huge page when freed by the application.
> 
>     Try again later when freeing a huge page next time.
> 
>  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
>     offline_pages().
> 
>     This can happen when we have plenty of ZONE_MOVABLE memory, but
>     not enough kernel memory to allocate vmemmmap pages.  We may even
>     be able to migrate huge page contents, but will not be able to
>     dissolve the source huge page.  This will prevent an offline
>     operation and is unfortunate as memory offlining is expected to
>     succeed on movable zones.  Users that depend on memory hotplug
>     to succeed for movable zones should carefully consider whether the
>     memory savings gained from this feature are worth the risk of
>     possibly not being able to offline memory in certain situations.
> 
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
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  8 +++
>  Documentation/admin-guide/mm/memory-hotplug.rst | 13 ++++
>  include/linux/hugetlb.h                         |  3 +
>  include/linux/mm.h                              |  2 +
>  mm/hugetlb.c                                    | 85 ++++++++++++++++++++-----
>  mm/hugetlb_vmemmap.c                            | 34 ++++++++++
>  mm/hugetlb_vmemmap.h                            |  6 ++
>  mm/sparse-vmemmap.c                             | 75 +++++++++++++++++++++-
>  8 files changed, 210 insertions(+), 16 deletions(-)
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
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 05d51d2d8beb..c6bae2d77160 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -357,6 +357,19 @@ creates ZONE_MOVABLE as following.
>     Unfortunately, there is no information to show which memory block belongs
>     to ZONE_MOVABLE. This is TBD.
>  
> +   Memory offlining can fail when dissolving a free huge page on ZONE_MOVABLE
> +   and the feature of freeing unused vmemmap pages associated with each hugetlb
> +   page is enabled.
> +
> +   This can happen when we have plenty of ZONE_MOVABLE memory, but not enough
> +   kernel memory to allocate vmemmmap pages.  We may even be able to migrate
> +   huge page contents, but will not be able to dissolve the source huge page.
> +   This will prevent an offline operation and is unfortunate as memory offlining
> +   is expected to succeed on movable zones.  Users that depend on memory hotplug
> +   to succeed for movable zones should carefully consider whether the memory
> +   savings gained from this feature are worth the risk of possibly not being
> +   able to offline memory in certain situations.
> +
>  .. note::
>     Techniques that rely on long-term pinnings of memory (especially, RDMA and
>     vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 0abed7e766b8..6e970a7d3480 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -525,6 +525,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   *	code knows it has only reference.  All other examinations and
>   *	modifications require hugetlb_lock.
>   * HPG_freed - Set when page is on the free lists.
> + * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
>   *	Synchronization: hugetlb_lock held for examination and modification.

I like the per-page flag.  In previous versions of the series, you just
checked the free_vmemmap_pages_per_hpage() to determine if vmemmmap
should be allocated.  Is there any change in functionality that makes is
necessary to set the flag in each page, or is it mostly for flexability
going forward?

>   */
>  enum hugetlb_page_flags {
> @@ -532,6 +533,7 @@ enum hugetlb_page_flags {
>  	HPG_migratable,
>  	HPG_temporary,
>  	HPG_freed,
> +	HPG_vmemmap_optimized,
>  	__NR_HPAGEFLAGS,
>  };
>  
> @@ -577,6 +579,7 @@ HPAGEFLAG(RestoreReserve, restore_reserve)
>  HPAGEFLAG(Migratable, migratable)
>  HPAGEFLAG(Temporary, temporary)
>  HPAGEFLAG(Freed, freed)
> +HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a4d160ddb749..d0854828bb9c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3048,6 +3048,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>  
>  void vmemmap_remap_free(unsigned long start, unsigned long end,
>  			unsigned long reuse);
> +int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> +			unsigned long reuse, gfp_t gfp_mask);
>  
>  void *sparse_buffer_alloc(unsigned long size);
>  struct page * __populate_section_memmap(unsigned long pfn,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index eeb8f5480170..1c37f0098e00 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1376,6 +1376,34 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>  	h->nr_huge_pages_node[nid]--;
>  }
>  
> +static void add_hugetlb_page(struct hstate *h, struct page *page,
> +			     bool adjust_surplus)
> +{

We need to be a bit careful with hugepage specific flags that may be
set.  The routine remove_hugetlb_page which is called for 'page' before
this routine will not clear any of the hugepage specific flags.  If the
calling path goes through free_huge_page, most but not all flags are
cleared.

We had a discussion about clearing the page->private field in Oscar's
series.  In the case of 'new' pages we can assume page->private is
cleared, but perhaps we should not make that assumption here.  Since we
hope to rarely call this routine, it might be safer to do something
like:

	set_page_private(page, 0);
	SetHPageVmemmapOptimized(page);

> +	int nid = page_to_nid(page);
> +
> +	lockdep_assert_held(&hugetlb_lock);
> +
> +	INIT_LIST_HEAD(&page->lru);
> +	h->nr_huge_pages++;
> +	h->nr_huge_pages_node[nid]++;
> +
> +	if (adjust_surplus) {
> +		h->surplus_huge_pages++;
> +		h->surplus_huge_pages_node[nid]++;
> +	}
> +
> +	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> +
> +	/*
> +	 * The refcount can possibly be increased by memory-failure or
> +	 * soft_offline handlers.
> +	 */
> +	if (likely(put_page_testzero(page))) {

In the existing code there is no such test.  Is the need for the test
because of something introduced in the new code?  Or, should this test
be in the existing code?

Sorry, I am not seeing why this is needed.

> +		arch_clear_hugepage_flags(page);
> +		enqueue_huge_page(h, page);
> +	}
> +}
> +
>  static void __update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	int i;
> @@ -1384,6 +1412,18 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
>  
> +	if (alloc_huge_page_vmemmap(h, page)) {
> +		spin_lock_irq(&hugetlb_lock);
> +		/*
> +		 * If we cannot allocate vmemmap pages, just refuse to free the
> +		 * page and put the page back on the hugetlb free list and treat
> +		 * as a surplus page.
> +		 */
> +		add_hugetlb_page(h, page, true);
> +		spin_unlock_irq(&hugetlb_lock);
> +		return;
> +	}
> +
>  	for (i = 0; i < pages_per_huge_page(h);
>  	     i++, subpage = mem_map_next(subpage, page, i)) {
>  		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1444,7 +1484,7 @@ static inline void flush_free_hpage_work(struct hstate *h)
>  static void update_and_free_page(struct hstate *h, struct page *page,
>  				 bool atomic)
>  {
> -	if (!free_vmemmap_pages_per_hpage(h) || !atomic) {
> +	if (!HPageVmemmapOptimized(page) || !atomic) {
>  		__update_and_free_page(h, page);
>  		return;
>  	}

When update_and_free_pages_bulk was added it was done to avoid
lock/unlock cycles with each page.  At the time, I thought about the
addition of code to allocate vmmemmap, and the possibility that those
allocations could fail.  I thought it might make sense to perhaps
process the pages one at a time so that we could quit at the first
allocation failure.  After more thought, I think it is best to leave the
code to do bulk operations as you have done above.  Why?
- Just because one allocation fails does not mean the next will fail.
  It is possible the allocations could be from different nodes/zones.
- We will still need to put the requested number of pages into surplus
  state.

I am not suggesting you change anything.  Just wanted to share my
thoughts in case someone thought otherwise.

> @@ -1790,10 +1830,14 @@ static struct page *remove_pool_huge_page(struct hstate *h,
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
> @@ -1835,19 +1879,30 @@ int dissolve_free_huge_page(struct page *page)
>  			goto retry;
>  		}
>  
> -		/*
> -		 * Move PageHWPoison flag from head page to the raw error page,
> -		 * which makes any subpages rather than the error page reusable.
> -		 */
> -		if (PageHWPoison(head) && page != head) {
> -			SetPageHWPoison(page);
> -			ClearPageHWPoison(head);
> -		}
>  		remove_hugetlb_page(h, page, false);
>  		h->max_huge_pages--;
>  		spin_unlock_irq(&hugetlb_lock);
> -		update_and_free_page(h, head, false);
> -		return 0;
> +
> +		rc = alloc_huge_page_vmemmap(h, page);
> +		if (!rc) {
> +			/*
> +			 * Move PageHWPoison flag from head page to the raw
> +			 * error page, which makes any subpages rather than
> +			 * the error page reusable.
> +			 */
> +			if (PageHWPoison(head) && page != head) {
> +				SetPageHWPoison(page);
> +				ClearPageHWPoison(head);
> +			}
> +			update_and_free_page(h, head, false);
> +		} else {
> +			spin_lock_irq(&hugetlb_lock);
> +			add_hugetlb_page(h, page, false);
> +			h->max_huge_pages++;
> +			spin_unlock_irq(&hugetlb_lock);
> +		}
> +
> +		return rc;
>  	}
>  out:
>  	spin_unlock_irq(&hugetlb_lock);

Changes in the files below have not changed in any significant way
since the previous version.  The code looks good to me, but I would
like to see if there are comments from others.

Thanks,
-- 
Mike Kravetz

> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index cb28c5b6c9ff..a897c7778246 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -185,6 +185,38 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
>  	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
>  }
>  
> +/*
> + * Previously discarded vmemmap pages will be allocated and remapping
> + * after this function returns zero.
> + */
> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +	int ret;
> +	unsigned long vmemmap_addr = (unsigned long)head;
> +	unsigned long vmemmap_end, vmemmap_reuse;
> +
> +	if (!HPageVmemmapOptimized(head))
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
> +	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> +				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> +
> +	if (!ret)
> +		ClearHPageVmemmapOptimized(head);
> +
> +	return ret;
> +}
> +
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
>  	unsigned long vmemmap_addr = (unsigned long)head;
> @@ -203,4 +235,6 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
>  	 */
>  	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
> +
> +	SetHPageVmemmapOptimized(head);
>  }
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 01f8637adbe0..a37771b0b82a 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -11,6 +11,7 @@
>  #include <linux/hugetlb.h>
>  
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head);
>  
>  /*
> @@ -25,6 +26,11 @@ static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
>  	return 0;
>  }
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
> index 7d40b5bd7046..693de0aec7a8 100644
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
> @@ -224,6 +225,78 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
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
