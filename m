Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999D1350833
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 22:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbhCaU3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 16:29:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34930 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbhCaU3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:29:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VKOoEc097658;
        Wed, 31 Mar 2021 20:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rmEyL1CSJyXrEEM+XdWFeYxJuIducjk+MDYiLx6QH90=;
 b=TnhlEYC7GeAupB7lqyCrtDPux4QmFTfouB7x1QDoPbZDiQpwB2CnEc8RND8zVZrcc5ky
 d+5m5jfjZngmkDSqw0RTGCqmZH+ZMY3oxqqkdapdBYh/htIP/XJErKEwpt1YD5cSwY6F
 AE4SiuihRMwhWANSzqsYKugzJm+GqOR8Zsra6rfQ4sjhb1QzZBOSPFOrri1PIUoHz5w5
 9gzm+uNS0U1jsjeEEwvz4Mdyp2SGGZtxpSdYqIL1VtGB9e955E8ZSOdDtmc6c90BgQKP
 4cle0KqoxXQt2jX6zXzBBx8V2wEo/g9g5vjvKbmKqtVT/clxldU1tW24Oh8L/5z323Gi zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37mafv3jh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 20:28:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VKOsrI127725;
        Wed, 31 Mar 2021 20:28:17 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        by aserp3020.oracle.com with ESMTP id 37mac947w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 20:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTJRI7O6/Q9sU0HT8sKYgfc2jgbs2n+i9RCIkOZINqmJxtjDA0/7qTDhE2T6ckyAGFgZTk4DdOZ1Msg6mYdAkS/dzoilrchQWSuiCj1tz87TngYb/GIdZ+wJsJoI7C+TOJ6S9eSUwtxNWS40N+wNF4L5BhDoeCll3UMr370gzZYVho3YMD3exK6JYzUq+jtoKNt1uNIlGF+UvX1SW24T1HpxszOyvx4O9Q2LsChKDQZdmRPXWC5KClVaNXXZhs7/2fj/+uFmhdIQf+nByIwrIXUS3xa/zMoQEUe3esHb5FCoU9v8uG5StfeOyh8xXHWw2GkPHWbo9xYvi1JKYTwSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmEyL1CSJyXrEEM+XdWFeYxJuIducjk+MDYiLx6QH90=;
 b=EH/6Rz4sF/gQ1tNNzIL3qBvG3QnSxnk64ggSrHFaI5GKc1ba9aN6FxZonT81GC/qu87M6hInJrpJjpqipIrL+6xfqKZZlABtYGf9R5SLh95mT0jsolPPoL5bShh7JEos0cJqvoW18uL33N/DiJskgbxTBvsMs4jz2Y1BmL+J5jz+zMr2IBkOwxEqjKv1HG8Hvu+gLz6rYyWpPjGIGJUtZRE90eugM01DaBqaf7L026px9v+wSy4kvr/EQ9EgE+5OFok0d16mn2a91fXrkJCfThpu/DYJKUsCcGGdIoc3oErHaofqYsphK9GloQW97lV5qWA7F99bKRCN1NeQVfafeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmEyL1CSJyXrEEM+XdWFeYxJuIducjk+MDYiLx6QH90=;
 b=XjPGOg3ImbpWs98v1oy+Q4tTW21uEqLKVxTiQQk3AUbUoVVcwYedSnP0z/4ZviQEvTdaJN81Bp/rodfut4QNFDSr6hakY1yCYZTFuZ4Qz+LEL/YoiNckm42pQ7STvST9pr90OXUd6uhkw2B3tLfg5/GL9QeT8ICJPAGnKR+hkfw=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by BLAPR10MB5380.namprd10.prod.outlook.com (2603:10b6:208:333::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 31 Mar
 2021 20:28:14 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 20:28:14 +0000
Subject: Re: [RFC v2 01/43] mm: add PKRAM API stubs and Kconfig
To:     Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
 <1617140178-8773-2-git-send-email-anthony.yznaga@oracle.com>
 <b7c635e2-e607-03bb-30f4-66bd00bff69e@infradead.org>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Message-ID: <f8069662-7515-b524-a589-7e4785d07585@oracle.com>
Date:   Wed, 31 Mar 2021 13:28:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <b7c635e2-e607-03bb-30f4-66bd00bff69e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [148.87.23.9]
X-ClientProxiedBy: BY5PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:a03:167::31) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.159.250.116] (148.87.23.9) by BY5PR17CA0054.namprd17.prod.outlook.com (2603:10b6:a03:167::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 20:28:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8702e856-2f63-4055-82a4-08d8f483827f
X-MS-TrafficTypeDiagnostic: BLAPR10MB5380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB53800ECD1025000E4DB099C6EC7C9@BLAPR10MB5380.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPNZ7ErjR0bvtOigIucBJbpgYqu+tFn2R0J5lqgAA/BxL1IiIq0x48VvKoMVl9hQZjD/nzMD0abehA+BiRlY35tx6tJYmxuJ0tDRkgNxu4SHDVTmCfm4B2k8yZy5gVWdy8Cc2mhLWsUSFhbUNouVZo4NTEjeJ5Oazpd6wb1OHwxK0IdOgOvccKAEFFwhEd+2ciicajxvytYpqS0fFFCZoh6Jsm5ymyyfheU6byPlTvoaH98Zln5dbo6cKlnBLgmFa3kVo9HAB6VeSVmXErCgeFvP4smQ64hK/J3A5aJESonpvxmBL71xdoAPLDoDgU4BQuaa6TqkMc8mvph8RNp+gX4f6H/7liE9urAnBLfU9LcOMhL2csaolaFi4gVwtBi4sIrYPpxDMPhl0goHlWZUfwz6Ods5QMbKEgSLQRtC6kl1sMSAyvb0Aed+2QZ4i1WLiSnDLY4QwYTsxQoJmwnN3Oal8C2UXsiXuT1J2ouW2q8LOidOO496fzBrHu3BJ2dFLWgYoiFceafBVy5IyZtJxHpUQqWMQSCJ3jYG0v/Y3DQVOQS7dd44yqCO2OjhdCQuZ3LOHCkrEzf9gwue0B4B+NCH0CVHq+wh7pVF4VaIzfoB2TCY0OobL9Gn6W4OTHaBeppgtOLKp7QxB2nkL4UXCAUs+Do1Okv6fnDcMdfxLjMXtY7RkKIbclZpLjkWi7mB3CseqXvJBbV1EQ1gtQae7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(7416002)(31696002)(38100700001)(83380400001)(498600001)(53546011)(26005)(16526019)(186003)(6486002)(31686004)(8676002)(4326008)(8936002)(66946007)(86362001)(66476007)(66556008)(16576012)(7406005)(36756003)(2616005)(956004)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NkZiektBNnF4cFZUL0h3dythdDBESGI4U25MYkhtR1ZEbGR4NzIyNmI1WUda?=
 =?utf-8?B?YStTaENGYXVOSEtPSnVUc1BwOHF4VFRsQVp0MXZkMFJwVWg1NVVxV2RrdmVY?=
 =?utf-8?B?djRJUGc3aWpsb3YzZnBoem04MEhQV08wZE43STBheDllZk01SHNFTmhGeVhx?=
 =?utf-8?B?QWhvV3JlckxsOVpCQ1FmUUI0S0VUaGEwelcrbzVPWU5GTyt6REJweng5UHJJ?=
 =?utf-8?B?VDZTRDVBTUlGaVZuWEdheUhPU1Z3SlhDZ1cwMk1hUHZnS3czd2RHOVZUMDYx?=
 =?utf-8?B?aS8xQk55TmNTbllXMVpkOHFMODNmWFc0YThOSmI1ZG1CWTJBRkwrd1o1R1Fi?=
 =?utf-8?B?ZjduUW4xdWo5bkNHeUlRK2xnUTVwd1NLYzRpc09YSi9aRCtEUmhVbVRwMW1G?=
 =?utf-8?B?ZGw1M2FwL1oxUlpWeE90d1pwWlQ2QVRLRDJUQXhLTE5ucjkxZjhHc2hKazlu?=
 =?utf-8?B?NzdUQ1l0TS9LcmE0SFN3ZVlsQ1Q2MkVyMDRDZlJHVjFkcVlPUTVmcTNuN09k?=
 =?utf-8?B?VC9FK2I2cGVFbFUwMmtkYmxDcGl0ckxUak1nQzl0ekRaSHErVDBzMmN2akVv?=
 =?utf-8?B?SW1wK1pCc3g0RWpGdzcrc3ZXS1QxUUc1VUl4T3NsN0hPbS93VklTQzZYZHlW?=
 =?utf-8?B?a3YzZi93SXU4MWppbk4zRVV3cGp0MGFLSmdVNnd6RnUvTnNXNmRhbjZrM0Rh?=
 =?utf-8?B?ZXFpWWVwaFgyNThubitZUEdxZHd5bUZjeG5ZRjBFL3JXVVVKTDJ1dWdUeE5O?=
 =?utf-8?B?dmoxTHpPTWlDdndVUTBZckRCbUZUTlVpQ3BlbTI0STRlbGMrazFOWk5MdDBT?=
 =?utf-8?B?Q0F4RzJvQnRhSjBENmJWNTdiNmF6bTgySDlnZmtHOEdwT2FVQjcvN1loZ1k2?=
 =?utf-8?B?K2hxUDBqLzlZRWZDbWY0dFNpbFU3SXluVW1PSDU0VDFEa0hOVXdWcXcxU2lk?=
 =?utf-8?B?RUgySVkyeEdlOUV1b053WWg3Qk9ENnVMd1dGbU9MeS94aU1CT0hrRHd6SU1Y?=
 =?utf-8?B?MHBYb2hRL0plU2hlT2RjWGtSNUZzQjlKUWlYa3VkNCtoLzlJUnA3RFBmR0dL?=
 =?utf-8?B?dVV6RmcwenQ3R0NvMTNYOE9laVE1NVBCL1VxcDYzY3kwSWZ2MHJWRHJzRWtB?=
 =?utf-8?B?dzIveEFVUHBDU1krODAzRlEzQitRUkMyQmdyMkxiakhRdzR5ZVlBREl1WlJJ?=
 =?utf-8?B?R3cvZGdSOTVaYkpzTllBUzlkd2syMjNrSzMvUEpTc0s3K283a2ZuY0dNUUhS?=
 =?utf-8?B?MFR0bm5kZFFyZ09uVmFZZGYvbXZGS3ZrdGhHYUNWUkpYVVR5MnpzbXB4L0t2?=
 =?utf-8?B?M2R5cnYxREdUWmZ3WkFXSDRUYlc0RFhOdVo4dWxCMTVZZ0lTK3FoM1l4NFRH?=
 =?utf-8?B?Rnk5VldoVVJDc1VzRFRKbWdrUEdtRDFBWm4zdkszUzA5cmQzWHU3WUMvZ2Z1?=
 =?utf-8?B?UTV6YzFSbkxxODNSUEp0OG90RHoxMmpXRU83Ui9ON2FHQTIvSnBHOEVIOElN?=
 =?utf-8?B?UWR1a3Z6TWJPUFZiNHMwZm12dnd0eE45UkFISVhVeDd6NGlSc3lsblZyRzNh?=
 =?utf-8?B?aS9rUHd1bUVTZVJibHBEOHhUQVRJZ2lkR241YWVzc21obmE3Rkh0SGVEVk95?=
 =?utf-8?B?NFkyOEFBcWpXSDQ0ZzdRamxVaU5uQ0Q4SFNhdThaVHN0OWJGbk5TNHRXdVpR?=
 =?utf-8?B?SXJGd2dwdVpIWTNkckRIeG1jZXZSbjZlZ3JPUHpUdzcrRkNoNTdhZWw2NHVW?=
 =?utf-8?Q?fa92mTGUU09VN52IdMGPzvdLfy7zMSknnB3HKTt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8702e856-2f63-4055-82a4-08d8f483827f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 20:28:14.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMyPu1nxlrDb7MpkUk14VJH0o+laofs8apTByEMd3P09OD3h/BebkwICzTCxbUHlfsbCcE2qNLHYmdVltXiG5skXjHaeEKiTUkHOELuxtTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5380
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310142
X-Proofpoint-ORIG-GUID: IKPKiKBG_5rZIxJQzI1Yl4ZHvz6qkulS
X-Proofpoint-GUID: IKPKiKBG_5rZIxJQzI1Yl4ZHvz6qkulS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310142
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/31/21 11:43 AM, Randy Dunlap wrote:
> On 3/30/21 2:35 PM, Anthony Yznaga wrote:
>> Preserved-across-kexec memory or PKRAM is a method for saving memory
>> pages of the currently executing kernel and restoring them after kexec
>> boot into a new one. This can be utilized for preserving guest VM state,
>> large in-memory databases, process memory, etc. across reboot. While
>> DRAM-as-PMEM or actual persistent memory could be used to accomplish
>> these things, PKRAM provides the latency of DRAM with the flexibility
>> of dynamically determining the amount of memory to preserve.
>>
> ...
>
>> Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>  include/linux/pkram.h |  47 +++++++++++++
>>  mm/Kconfig            |   9 +++
>>  mm/Makefile           |   1 +
>>  mm/pkram.c            | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 236 insertions(+)
>>  create mode 100644 include/linux/pkram.h
>>  create mode 100644 mm/pkram.c
>>
>> diff --git a/mm/pkram.c b/mm/pkram.c
>> new file mode 100644
>> index 000000000000..59e4661b2fb7
>> --- /dev/null
>> +++ b/mm/pkram.c
>> @@ -0,0 +1,179 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/err.h>
>> +#include <linux/gfp.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mm.h>
>> +#include <linux/pkram.h>
>> +#include <linux/types.h>
>> +
> Hi,
>
> There are several doc blocks that begin with "/**" but that are not
> in kernel-doc format (/** means kernel-doc format when inside the kernel
> source tree).
>
> Please either change those to "/*" or convert them to kernel-doc format.
> The latter is preferable for exported interfaces.
Thank you.  I'll fix these up.

>
>> +/**
>> + * Create a preserved memory node with name @name and initialize stream @ps
>> + * for saving data to it.
>> + *
>> + * @gfp_mask specifies the memory allocation mask to be used when saving data.
>> + *
>> + * Returns 0 on success, -errno on failure.
>> + *
>> + * After the save has finished, pkram_finish_save() (or pkram_discard_save() in
>> + * case of failure) is to be called.
>> + */
>
> b) from patch 00/43:
>
>  documentation/core-api/xarray.rst       |    8 +
>
> How did "documentation" become lower case (instead of Documentation)?
That is odd.  The patch (41) has it correct.

Anthony

>
>
> thanks.

