Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047D931152F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhBEWYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:24:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50674 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbhBEOYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:24:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115FdidX122299;
        Fri, 5 Feb 2021 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kw8FXB7UOsXbBrq/R7dvbf/tE3djJ08y1xmEUb96zkc=;
 b=CwLsU4cC73uSiko3dbI8me2543eNYC42BrPVrKnLKbbYhOlRE6LP/+sutMYesYmKNXZG
 RcLwXs1/DkBxxh+ec7NdKqVGB5QpxCE+DcD7VsXRLSkwoifTGGRTXgX/aieDBZUoQ5zX
 TpvhABP3OtqJV/wy0pBfEN3Hr4crNsTUQFKPQPr2seETfLspY/AN9HofxypotGNxiJse
 d6ePcxEnjyE5kUpBdvkmSBKJiSInmk7MboY9RUYO7zKu/5w4pjzY4MHU/GO0Awx5SOwk
 5x+TUw9y2u/DKRboeHTolku2j9H/t/4kZfRnPwf0U/Nf9txaO5HyF7WmQXukNLi3KjsT Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36cydma6e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 16:01:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115Fff01110960;
        Fri, 5 Feb 2021 16:01:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 36dh1u45et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 16:01:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKtUFG7jsP3OGKttGtntLzlJW8lUlq/1mMl39Shi+OFG0LTQR5ZXO6jeprffmiQ1Tmgww20tPrXs969TPkfl8C4Ru05UsjoZJ3rtqjvdPSaiYUuIKbWTudPtBfWGpVDRk0rpoLeu60GKTqDckjW+U8v++ho7glGt8dJAnshPp6AGjhDKiz/58CFwnOUUPNrCd8zrSjc1UfYio8IE0Twx2naMK7bDAbV1/0UB0hDSNoTGNveoPBXW64SjPPtfplgo16ic8l4jNWoKua8Md8KoPwqd8c8qDm7R3J6fZjAvhsHvuyoZK6g/6doCUNvClqDVXRvfFZYF73ZdjT+LwOj4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw8FXB7UOsXbBrq/R7dvbf/tE3djJ08y1xmEUb96zkc=;
 b=RYsW6N17xCBrcWA/KEmHSsOzUKXMLAzYGs0/gzrY2ATlyavWshbHC392gIqNX3XPMG5lK0M0HDPaq4di/IrWtSXVTQeleSDi3/O2mhbxRIoIkSSoFEZxK/5FtR6vQw9g5PFwnvkOC+99aKolTLQVecZRmSo53SI9Aj7xxpz4wKT4mFbTEDdHdWqIig+QCb3gqaGLz1Id8QemA9x+IdnLi6Wx8D5ekBqpt9Rf5WrwX42S6Mco0d+FCXSJ7CrfAwRqSBtqu8ESAxkFeOdPdO9ZP/BxwlrZEMMvFJV4+647gmGB7gnoAJLufrzi316TgQyEGwMkn0/Lo85U0qpnv/Cdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw8FXB7UOsXbBrq/R7dvbf/tE3djJ08y1xmEUb96zkc=;
 b=YrLepVgFcbgL5xfOVYiOCsZ4t9QgUkTRo54lYSTV2aGhhbqwgdfZ4eIymK5AuULb3AK8kKx0MjL01RvOYqyUarZ68XBj62E9I3u73t7pIkUGQhB3YKEJaZQIicdtYfyGcn9s9IJXtQ5EF8+V0BC61QBqM4WW3uYu2kPh6eN3wgA=
Authentication-Results: nec.com; dkim=none (message not signed)
 header.d=none;nec.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2696.namprd10.prod.outlook.com (2603:10b6:a02:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 16:01:05 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Fri, 5 Feb 2021
 16:01:05 +0000
Subject: Re: [PATCH v14 0/8] Free some vmemmap pages of HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com
References: <20210204035043.36609-1-songmuchun@bytedance.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <a14113c5-08ae-2819-7e24-3d2687ef88da@oracle.com>
Date:   Fri, 5 Feb 2021 16:00:51 +0000
In-Reply-To: <20210204035043.36609-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0107.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::23) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0107.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 16:00:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1f62b36-91ae-42ea-0ffb-08d8c9ef3df8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB269678B6166DB20AB022A6D3BBB29@BYAPR10MB2696.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3KfFOqvDhBMw6rsEwWX8RSDucnJXfOIvYjVaM8ZF0BnGjd6nbZh5l8+l+mtOIUKTwPNEAJmYDIJsdOYFG7r79AFXjUf255tk9tAZ5rLzHTR0ATcK4oqM0coUZg6+b6NtyfPdKZqmUepgZdlfCPxHh/8GmujORp4YhHvGSyGr73NoSeBPGqQ0NFL4W5WUfSUF/Jjl8WnrTgdia/FWn4IWT6H3wOAvUQn5RDXLNBGFfka2kpW1jDHhcZiwF2YPGgPn3vndSGvDf8IuTsZwDbaNNdHWlJW/fbV0uzHCy3PUya1uNA3s2szJJUI9rEOVQg5BtowmFlM1c0/ZwA6LMISAtdmFD3la3R7EvUhPF+wmMNlyDeyTL9WpY7CSwGV02mFuI2ISzUe+2zimhzkODellVIdPO23Rj9FbYuhhMZ+ZxWtIZV3WGcU3JcmJYaDlxP2lPxU3K4BgbmqNySucC4NyGw9Ki3MR84gSb/qxaMF0D6OBJ5UL9hOI3Z2uwMrG1sKTcqe9mpaToPmLa6hQxEHpHDAcQAxAY3SQ7AqRjNuhP+Zt0d3jmrnEZM1EOKyaTY/kisoAo4Bn4mU7nHAz/qLvsTwOWTpwlDtbGwIQ1tlhx7rqG1bn8x/f5fmyPW23kUqtWp4MVuba4OfDnwM0qhAc4VxXWYplUg/BMqWUjU6VnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(346002)(376002)(86362001)(16526019)(8936002)(316002)(53546011)(186003)(966005)(31696002)(36756003)(66556008)(66476007)(6666004)(66946007)(31686004)(83380400001)(16576012)(6486002)(2906002)(7416002)(6916009)(5660300002)(478600001)(956004)(8676002)(2616005)(4326008)(7406005)(26005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGRkNlV1d1Y0dHdkT3JSZlJKU21YVXJmbUl5TmRQVDFTQ3AvSGs5ZWFoU2xG?=
 =?utf-8?B?WUlhUTNiLzVLNWtQd0UxRUZrdzl2RGptTHEzOEg4a2d2MFFtNy9jL2xydFZl?=
 =?utf-8?B?NCtaa2s5L3YxMnFFZDhKamdySXE4dTczSk5EbUxqQmtTMHJYTEx2eU5CTUhw?=
 =?utf-8?B?RlBURWZXYzBvSkJ1SVFWVHRSVXE3U21aYU9TbURKK1AzK3dzZ1V2UFNZZm1I?=
 =?utf-8?B?QzEvdjFaeWJpVExuZWxGekhpUndIeDloWGVFbWlENEM1RGdQbjdtdkxBQ1I3?=
 =?utf-8?B?bTlJQi84enNVYlAwZC8vWGFYTDBlL3k1NWs2N1p3S01tUXI4eHJQUTdqTWd1?=
 =?utf-8?B?Z1BCcU1FKy9vUUxvQVBMdVlSQXg0NDBGV0tEdXVyVEsxSUQ0eEFqengvZGRB?=
 =?utf-8?B?OWY2cEdINEppeVBKSE4wRDJ2RHF2dTdtVkZ2RmE0aHVObnl6K2ZFbGZSN0pt?=
 =?utf-8?B?VnVpbHdKMHJGWmZsTllxU2RzdnI5dkVSK20vUnAvd2gyVEUxNEtzWEhtZ2VE?=
 =?utf-8?B?UjVmS0Ria3A4UWdZZVl5QTJ2SG9vVkhsekEvWkFkdVptRWtJNnFEY1ovWUpW?=
 =?utf-8?B?RHA5YldkL0g0Z0U2QWpuRlZaOGo5NlF0MWRSRFNyekFuL0ZJM0lQK2RkcjZz?=
 =?utf-8?B?N3BuZlFhQ2hkNDl6WkV2VnVab2hJUkJJOVFvZHVKQUs1dXpja2FQeFVSQnBL?=
 =?utf-8?B?ZUJJdUZyWmNvRTF2ZytnLzdhaFNVVG5hT01tUFQraWxId1NFU3BpbldNdEpl?=
 =?utf-8?B?d3pMZXJraW9zYm4wVU5WNDhYM1BzZnlrUkZRclM4dUNUYmpCTnY5RXgxbFBU?=
 =?utf-8?B?aWlIaU5iT05kMDNGZXM4RW5rOHZJRkFOVnRyYzQ2V2lzTFhteWpQeENZUENo?=
 =?utf-8?B?b1Z2dnNtdWd1TmtGUjVWWkxzUmxEVWZmcDlKd05IMS9nZXkzVThyeEh1eTR6?=
 =?utf-8?B?RDMwbFJtRUwrc2ZqUkJuMkxMYnBMR3JjUDU3RlJTZVlXNkwvT3Q0aENpaW5P?=
 =?utf-8?B?MEgzMTgzSXY4RzNjaGlSaitwS0s0WmIwVUxMd21VcUJvc243WUJNYjQxSjNN?=
 =?utf-8?B?ZnRlYi9sZndXbjBhQ09EMHBNTTNJREZBei9LWmluM1pTUjJGcnZJNVNTZzNK?=
 =?utf-8?B?TzVsMklhRnFObXlDQlExdDhLQnlpU2U5LzUrUDhsRmdnbTBrVm5kdnlNRU9t?=
 =?utf-8?B?RGwySm5iblNXZVVKa1U0S1hxS2YvTDUvZ3d4THRnM1FJSHhhdFE1VzZQaFpD?=
 =?utf-8?B?YWJ1b2NyMVdnNFVzak5XZXZFWUZ0TDVEYUNUWUFUc0pKZEVNd3hIV2taZjdz?=
 =?utf-8?B?SnBtMVY2RS96ZkhBS2tieGx2N0lNdFpIZFEra3pjeTVNZ29TQ1lHM1NjWFNP?=
 =?utf-8?B?Ymo2bnl6QVI2RjA0eUkyZWhGdVQzUWZuU0JJSEZhZGxVS3hvZmRHN2R1Q3h3?=
 =?utf-8?B?MkZKWFMvaFh5dktiQVZNRFBidjcyeGpEQVg4U21jaktQZmxtYkQyQXA3Z1pF?=
 =?utf-8?B?a01yeGhaVXVJbHdXVWtEM1NaVnZKaU1DdGhRQVJrT1hGUExFaFQ2YS9RQW1U?=
 =?utf-8?B?eHVLMUEycXQrcUhPajFuQXRnTDFyYzF4TWFURWwwWm80T1JVanJXRDNuNFVv?=
 =?utf-8?B?cnhLblRXSm9HT01uTTlkL3kreTdIUWVKVU5hdnFMNENtTTc2WFlmdUVwYjho?=
 =?utf-8?B?V1g3V0U3VHVGRUJOZWh5MGxKeFpWcW81R0dBa3VCS0RmSVMzZ2tTSXpBQzVT?=
 =?utf-8?Q?JzvbXfCwbfrp8iPnjDk22I2yzttTRdzNVM622gN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f62b36-91ae-42ea-0ffb-08d8c9ef3df8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 16:01:04.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Omz6ypj+hxsZ5Il8EP6MBbZr19mTcWRa8UGBuGgs2g4mu2Tu+M+MYxFS0N4+shT0mFr7YlfI/Rg4nw+kzHBPl57oiO2VjIy+/Ouw9RTAuIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2696
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050103
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050103
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/4/21 3:50 AM, Muchun Song wrote:
> Hi all,
> 

[...]

> When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
> vmemmap pages and restore the previous mapping relationship.
> 
> Apart from 2MB HugeTLB page, we also have 1GB HugeTLB page. It is similar
> to the 2MB HugeTLB page. We also can use this approach to free the vmemmap
> pages.
> 
> In this case, for the 1GB HugeTLB page, we can save 4094 pages. This is a
> very substantial gain. On our server, run some SPDK/QEMU applications which
> will use 1024GB hugetlbpage. With this feature enabled, we can save ~16GB
> (1G hugepage)/~12GB (2MB hugepage) memory.
> 
> Because there are vmemmap page tables reconstruction on the freeing/allocating
> path, it increases some overhead. Here are some overhead analysis.

[...]

> Although the overhead has increased, the overhead is not significant. Like Mike
> said, "However, remember that the majority of use cases create hugetlb pages at
> or shortly after boot time and add them to the pool. So, additional overhead is
> at pool creation time. There is no change to 'normal run time' operations of
> getting a page from or returning a page to the pool (think page fault/unmap)".
> 

Despite the overhead and in addition to the memory gains from this series ...
there's an additional benefit there isn't talked here with your vmemmap page
reuse trick. That is page (un)pinners will see an improvement and I presume because
there are fewer memmap pages and thus the tail/head pages are staying in cache more
often.

Out of the box I saw (when comparing linux-next against linux-next + this series)
with gup_test and pinning a 16G hugetlb file (with 1G pages):

	get_user_pages(): ~32k -> ~9k
	unpin_user_pages(): ~75k -> ~70k

Usually any tight loop fetching compound_head(), or reading tail pages data (e.g.
compound_head) benefit a lot. There's some unpinning inefficiencies I am fixing[0], but
with that in added it shows even more:

	unpin_user_pages(): ~27k -> ~3.8k

FWIW, I was also seeing that with devdax and the ZONE_DEVICE vmemmap page reuse equivalent
series[1] but it was mixed with other numbers.

Anyways, JFYI :)

	Joao

[0] https://lore.kernel.org/linux-mm/20210204202500.26474-1-joao.m.martins@oracle.com/
[1] https://lore.kernel.org/linux-mm/20201208172901.17384-1-joao.m.martins@oracle.com/
