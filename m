Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12D4374B24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhEEWW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 18:22:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35768 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbhEEWWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 18:22:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145MDWhY194335;
        Wed, 5 May 2021 22:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SVuXdoyDEIQXnYJjA6d23SBYYcqC6WUdh0awiKnkqTA=;
 b=ab0WKmdYWhavoJzpnZMihy7p7LJHNkXllsSlIO528rqg/t43AUBPT/3WKLwwV3Ul/8nM
 duYDWOVU9k9Hek9QOxzLBnQ1ymnFoaedlSz4P7JrrPwbJDl9Mn90meSZlLfbT/FjLl9c
 vcKV3npp+EBnL1MmPMhAb1CqsXu+VoVNkmsjBJnqVc/Yw8EZFT7h7dhQjuWWSHMvX+R1
 Fjv6DEQtUqemH2+ISWiv6GGYCSxoy3SdSGCnnBs+CSkD3N4Gsn4gyZ7L419i5PEa7GFC
 si9BgkLToPfY3rkj+QK2K0KPrvzIvvKc5Vk35kKN3nyr6gFdBjFAWLuJpIYICI4/M3u3 eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38begjb9an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 22:21:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145MFHIZ058566;
        Wed, 5 May 2021 22:21:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 38bebu912m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 22:21:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6DNR/2BQ+ihNZTgMO2fsFAErviC4wKmYjrQunPwMdjozAIm/st4a7aF+1GqYosn5uNzHIXEQNeJ9Fy6wN9OrNQSKcmcPQcKxAsWkrT0DjB5hJdq/LHHWejMTrZnwJw0kCemGAAgFoUQaCbQRa97JSXKjk6h/W57t+pcVq3br5rRQVzqaAvaMV/deNqd0n6bhIaqq8NIrH7uIdA6ncaLz/yY/+ByMiwTFrJJOzDEyqgu1whEH0FQnmnYCxb+qmvQKdAI0NW24HgMMab6NpxjSX3FLTHHgEMHy66sCLF9g/9M/+RMTfffhSbr0H4bgXRPG4/3Q7XyoCtaEYTUTt2wKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVuXdoyDEIQXnYJjA6d23SBYYcqC6WUdh0awiKnkqTA=;
 b=fRM+9WqSvYaNbeS9AxAopfHdb40hiY+Xj4QlDVsaLRnPmoeifMX3p0Gk4WpIdvNSk4lXxkZms0a3FvV+3Vx+Q6Zo5IMudBBHxPnnMv6WvQxI6WCVhs98x3Vc2OCy8LtoVxnD46b+ArbsXxosFJI3GIzFjvqSvYQ4eOtuat1q0tRVs2uTsgs6oTe7OQUGsOCIBps0x1Kpx6Yryk0ZSn8JBy/N0CM2kQD2C7wHBHhusy6rpB/toIyblJuoZ9ZTzzLAo9t7wUJybsbKNeApmDgoXXc4NVT8owgmgHLv0/C8MR0SlepQIpDgpudxtDq7nYi9GI1GDuF0iPGXvbxXOJ5zOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVuXdoyDEIQXnYJjA6d23SBYYcqC6WUdh0awiKnkqTA=;
 b=j8NdEzcsRURieECXMT/Lek+50tkcGG2lsuemimpzkr9B6QLy6qYR250Ihq1vNrANxbdZFyF2kK+fkF47WTHqyBn8MVmPJCXoQVgoXXcYSOWiRmGkK80O8hCba8NTTWQpXZiir4oD9yTXBFlzt68Sp05L6ilOHNFbTLMqoWOhzIo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Wed, 5 May
 2021 22:21:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 22:21:15 +0000
Subject: Re: [PATCH v22 6/9] mm: hugetlb: alloc the vmemmap pages associated
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
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210430031352.45379-1-songmuchun@bytedance.com>
 <20210430031352.45379-7-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c2e8bc43-44dc-825d-9f59-0de300815fa4@oracle.com>
Date:   Wed, 5 May 2021 15:21:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210430031352.45379-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR14CA0015.namprd14.prod.outlook.com
 (2603:10b6:300:ae::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR14CA0015.namprd14.prod.outlook.com (2603:10b6:300:ae::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 22:21:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 762e8cc5-8d65-4070-9687-08d9101418b0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3160C53A0BDC26CC9490BADBE2599@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfzGcrRDu8cCiDUjab7EM1YdJEcqZol6XxgjJVOKE6IKFzzvWJGj8Mp9v61IkrtNb87GC6xhIFUzU0Of1aaXT9cmuJK9hE3IV4RYvriTfIhA/C5dz9xD5zOTkgDbb+4Yo+QUlLjXBPh8whOV0kLyKnTLLRqz469ro70Dc376OPp78I6LjaM3e8glV7jaVOeHuxJiNou+5eTkaF/IRJneS3hujRSGONt+rO9QprEdUC3qffi7vw4z74qh1RogqZcLCjYH8//xtQAD+AxLxdTiXaqZThzqO90Sgo68q4fb/H8BLJ42bDxoZKfvj/64eD3eqDrnk1NiHeqeIIiPgoRQ/LzFjRlQuvn8HLgggUG8Zrwcse78V7ZzaFQ9Rab2V5197WDvK5WyIhiKPDaLq9DqfPHTcsZ6POakoDjuPjftwl0Bgm171nSWmOD7h2+tTdKteEaYDwYfN/bzURalu5mRwdV9XxyAMH8pdcx6NiNHROAlCdWZVz17iF5YSdCV0WsLnD5R7y+DjQa1Sw6LPN8rN6JhC9xQ+5xcgiqdMm4j39YDs4Yn/oqfgLaDgiEspGLDo+KD+pM/vmUtNa6e7u1jnQrPetKtzHA/WLLquSb27mpb6zTQUlZvpGhMI+t708UmQtv2278VfBwytSlQJikPvYyUye2BbSPhovZN5VsF03LQL15nV7Vhc+fzi3/z22O4pD6YhawGkg/RTm+mT91hE2CZ8CuP8xRmDCb1kQoUxlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(26005)(186003)(956004)(2616005)(31696002)(8676002)(921005)(2906002)(31686004)(16526019)(53546011)(4326008)(66946007)(66556008)(66476007)(83380400001)(38350700002)(86362001)(44832011)(38100700002)(8936002)(6636002)(7416002)(36756003)(7406005)(5660300002)(478600001)(316002)(16576012)(6486002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzlKcTJLYUJtNWJEUXQ2U1pIaGJZSmRvY05YVlkrdXk0WUFnT25ma2J6cGp4?=
 =?utf-8?B?cUhPQ3dKcXIwdFp6L1MxNzNCWHNtUE9wRzc2OC9VVVFnZlEzbk1DcjF6N1kw?=
 =?utf-8?B?YnlsS2tCU3hZczE3M2RQWTljdnBUM3hUWWlubFViSVNVY0FkTk1OejhLYTl6?=
 =?utf-8?B?K3N5Z2JnUGpaOFVMU0xDOFcwdFNmUGpEOXVOdVcwUU1xSXZiTzF0dFE5WHBv?=
 =?utf-8?B?cFRCZUJDQk9tMnZ0SGNkYzFWWEowOE5mRW5EWHVmMlBvVDAySzBlN0NiclB1?=
 =?utf-8?B?SS9nTk1jeWZzVkErQ0xyUzgzOEN1Y0tsWXlJYXBZZURYaVlRVGxXZnMrcHhI?=
 =?utf-8?B?eVBkdnd5YUVaL3Q5TlJWL2xDNXIxaUZRUmFXNjdJcm1QZkNTeVR4eUtKOWx6?=
 =?utf-8?B?VElQTXFTMDNlcW1uSmkxWGY2d2w3UWRqcyt1NE01ekxuaGhXL2xiTnBCKzBr?=
 =?utf-8?B?d3g2a2pRTWtUaXFFSzJ4eWwrcndqMy9JNzVGci81OTBrUGN0ZnhTV2gvMWFI?=
 =?utf-8?B?SGwzM1VKVks0ZGlVeFd3bFRTS0dqTEpwODl2c1FoclYwNlRscmJIUE8vQWRm?=
 =?utf-8?B?M0lYczg3NDlndmViVGo2SG1hTW94QnB1UllNZjFwNFpXZTVZYWZlZTRWdTNo?=
 =?utf-8?B?MnBibWNhWWN2dFlzZzJkZG80OEdaWk1IVzdlUlVJWXFXMjkrbEl0YTJQbEVC?=
 =?utf-8?B?bzBDYUQwbkIzeitEN2JRUnl6a0VxQzZkVE9yN204dXJNQzUyRk96U1VpSEo1?=
 =?utf-8?B?MDFxT0NrYWJIQkZxNTgzc0tiUWRobGY2MlpranJzVEhhZ0IxQnNXa0FYVmVE?=
 =?utf-8?B?WVpJN3VRWWxsVjErSks3MkdrWEhqaE9lazhmNVFuTFpQUUtCeEszemRwL0ZT?=
 =?utf-8?B?S2tPczhWYW96RjdXU0RRV0g0Ykl2Mlp6QmM5WW5QVW9FdzZiYk5UL2wwcUhP?=
 =?utf-8?B?RTByMTVDbGdnM0lPZTJpNjczMUd2anpoQmp3RC95dU5rampIZVJlOGxtTWpS?=
 =?utf-8?B?a3BTbGZoZW1MOW0yTnplUUk5MFpWb1lUSks4UjdnMkQxaXVwRHU1ZGdwMEJ3?=
 =?utf-8?B?c1NINWlyanBGVEJVNjhSU1gxQWJDTjN4M1lxOWFINU5HM3FYN1lsNTlveXNq?=
 =?utf-8?B?bGZqQnROUUIyVFVjbDRoMk94aUVERVpqL2ZSS0JEQUZFc2d0ekxIMFhVR0hq?=
 =?utf-8?B?WUhlQWtzV2lldmlmY2JnSDNRVElZT3l2OVMvWmJyQnN4MER0bnhJNDlYM25L?=
 =?utf-8?B?R2xiVXp5QmVxdEdUTUo3bitUY2tKY2I1TWVvdlFUdFAzc1NGai9XWUdyenJs?=
 =?utf-8?B?WmYwWlpnU2JuMGxLYzVjRUF3Q2xEUkt4UlJ4WFQrUWZGKzJpWmhyWUluNndz?=
 =?utf-8?B?QUJoL3hUVnZBZDBSYVg2bmpRT3l5WS96WUtYMllCbjFUbGkwTjdQbFE2SlVN?=
 =?utf-8?B?OWcyYmh4N2dtZ3R6akpsUmJ5ZmZlU1lmNEVRUUE1VnpZb1NMVGhhZFR5UnpJ?=
 =?utf-8?B?SzZGYVNTdEM2bk9WeE81MXJCOGx3ZXcvSC9YSDRzMWJJSU1WdVMwSUNaKzdT?=
 =?utf-8?B?VnZjaWt6YWhKemZWYTNnZ1RWa2pZaTRyVHczaWpDSTNzUEE3blBKUlZVYVdQ?=
 =?utf-8?B?STdZbWRPcE1qdFJtY2ZLWThrRVlmM1NmdHc2dmlmazZBMHZ5aURiZjZzTklG?=
 =?utf-8?B?YXAyd3VYdDJ3eU9tS1hUSFlpbElIajhnWnlSSHdoaytYMjJlUFRMK3pxVU9w?=
 =?utf-8?Q?t6OTd3E7Q4igeooR4xvNWSTJ9djv6sksLfwBfaL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762e8cc5-8d65-4070-9687-08d9101418b0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 22:21:15.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFjrXOFQxwQ4uAEUOjzHnMErR2iRf2kvuduQKZjKkb/5boDNlUL6QCYXFrfBRgRcZ47T3ZGqViZhejeh9CIepA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050152
X-Proofpoint-GUID: ZfDNS75Qi7aHG2Cz5mEE3owwsO_PYkT9
X-Proofpoint-ORIG-GUID: ZfDNS75Qi7aHG2Cz5mEE3owwsO_PYkT9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050152
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/29/21 8:13 PM, Muchun Song wrote:
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
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  8 ++
>  Documentation/admin-guide/mm/memory-hotplug.rst | 13 ++++
>  include/linux/hugetlb.h                         |  3 +
>  include/linux/mm.h                              |  2 +
>  mm/hugetlb.c                                    | 98 +++++++++++++++++++++----
>  mm/hugetlb_vmemmap.c                            | 34 +++++++++
>  mm/hugetlb_vmemmap.h                            |  6 ++
>  mm/migrate.c                                    |  5 +-
>  mm/sparse-vmemmap.c                             | 75 ++++++++++++++++++-
>  9 files changed, 227 insertions(+), 17 deletions(-)
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
> index d523a345dc86..d3abaaec2a22 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -525,6 +525,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   *	code knows it has only reference.  All other examinations and
>   *	modifications require hugetlb_lock.
>   * HPG_freed - Set when page is on the free lists.
> + * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
>   *	Synchronization: hugetlb_lock held for examination and modification.

You just moved the Synchronization comment so that it applies to both
HPG_freed and HPG_vmemmap_optimized.  However, HPG_vmemmap_optimized is
checked/modified both with and without hugetlb_lock.  Nothing wrong with
that, just need to update/fix the comment.

Everything else looks good to me,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
