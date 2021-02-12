Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48E631A53D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 20:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhBLTUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 14:20:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42142 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhBLTUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:20:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CJ9rEg031507;
        Fri, 12 Feb 2021 19:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WKp7+IhIUz4rowau4/sElFoIDGKVtcAM35oji5o/yDw=;
 b=kcwSQsyQ3HfLQi9v9VUiDa0BJUpeUIEDVZ8+Mt7G1uXyA0tyg8jaCrNelSPsEDKORWyR
 wIC0ptdsVDpizJaOaLngXKuVQNOG3mkwrinvzjx1jNc+lPEXpSaFtPBw5C9EnhGSQtLe
 NaGFnyzrQeETpAzwNUyiQ+8irQMiNTKWkWnb5ZnVdGT4aLulMHSzako9lOAr61L4SQw+
 0T+3MwxkXfh0HUHReuQQyhAGpagsDaYVcdgcyydtLbt8e2degQ8MYs3vW7ENWpFW0p0J
 HXBAzjLes9qB274hthoGUjgfFZ/Bj7LyY51PvixVXkwdqWS2Sdhx4OAQPdou4O9TIPfH /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrnc9qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 19:17:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CJBbXK127703;
        Fri, 12 Feb 2021 19:17:09 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by aserp3020.oracle.com with ESMTP id 36j515v2vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 19:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+pl3I0a67FSKkQhnv1QCzmqOovyHt81vGdBWmDNuoZ5vPSoMGdnBlfUx6tATO6UceAUCMLWpwrpK522XaoaEr3HLl+le1eM+uB7GdAkY0bzIx8iDYwPkG/kzeLsX+b2wTsOpamFpYqkWd6r6i6wA4cH+Os50XG+MQZtL30glWSBCe5qrqCyktoyiBwNTzORiGy1W9VLDL6rdPqQ0qJQHEo2K9OyfADza0wjhP5xMZJnjROsqbX0nY34rQYheI+mNE/0i0UcoWAQhdHptGvVrQQIYy1+xx8dXYZgKzM4h1jFYc9mEUnEUZd4BTwRRZWNhYECVV48ZjQG7O3+LZDRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKp7+IhIUz4rowau4/sElFoIDGKVtcAM35oji5o/yDw=;
 b=gRMbI/8visExsAN5/EIQvNUbasp0/r3a2uEQcCZifqM4OutcY+K6k0wpneABqz9p1vRjyvGCLO6LWfIRZiroUp8fpoaHb1fZAFYDAKmUhJ9N4zLR+7AUlg+UKWxW690x957rZpBnVMiKOAZrVlz77Gyl7Jyb/QE4kE9UBR/V3iimWGQv8rRKMWgQ6BjubEhIXnoMN21mzF0iTHlcj+NYIbHJBnlO6C5me7O1rb1p7SFF+Clc+L8IOzGMKZ5iRedXlbxxtjV0LHI0gIGf/z3St02UfhmtDw5fDGtTJJqRRNbAdMeobvyPmHgAKxmZ/xEI9wUQlM3gbApkxeuATm0RrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKp7+IhIUz4rowau4/sElFoIDGKVtcAM35oji5o/yDw=;
 b=o504QpECl/oaIlFCMVo4XttxPWjOQ+3dmLzustMZblqgq0OohBVbZZmjhypOB3ITKq6EKETgwhSDD53M0UOv6m54tYwwgNrE+r0EG2JL42gtqQtj5rlxxjOZl9hBJcZ9j49MTycZ57XVyuHD3fWPrkcX/o3gnwyAaRbbu+jyam0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1710.namprd10.prod.outlook.com (2603:10b6:301:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Feb
 2021 19:17:06 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Fri, 12 Feb 2021
 19:17:06 +0000
Subject: Re: [PATCH v5 05/10] userfaultfd: add minor fault registration mode
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-6-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <efb3173f-811c-5792-a193-6476905ecdb2@oracle.com>
Date:   Fri, 12 Feb 2021 11:17:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210210212200.1097784-6-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0272.namprd04.prod.outlook.com
 (2603:10b6:303:89::7) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0272.namprd04.prod.outlook.com (2603:10b6:303:89::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 19:17:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb71cde-9eeb-4f08-b738-08d8cf8ac8cc
X-MS-TrafficTypeDiagnostic: MWHPR10MB1710:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1710F8123732C397DEB5A88FE28B9@MWHPR10MB1710.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxbLMc2mYVzgx3rN0NhIgJ1y6VErAQZ7IBoC61+nBdrK6RjzbRnZTObNR833Zb6lBbM6Umw26qNYRNVp/5xvBWatiQQP10G5qnyHuxoFeyyGTy2keVjhk1+JKGHXyO8Y/mmt1P6Wuq2MzNnIFJ7IzYd6CukbqibRKlHpW8GXYsUQWUfB/gQmHik425rY9wae5B5XI8/c51tQMKSh4EzOULKBl1w+/rFWjpJ0qJig5bWYyuXQrScVj0w+98GoN7kuP6LaXzQjUaNJdAR2XVPOF4vgyUCc2706/SSQZqe+7S5WNrqeHEsn1UQoRT8Hu2lDUwH4DsjfnnlMlpyJ8cASdfNQ+9mdHI2f5Rghkczp7cRiyZEsHOvSvLpUBR5fn33QkTkalmHZqA5PQrRele9v1BPw7LpjlsK5vxvFsuNgSLx1MdxXcqJjln8rLKGJZ6CsAkYVbREnbNCBLJui9q45uBfRjtTeEWVk7Buo3Rn2+NQu9qLRKZMldxJclts1H0fbSYyd5NI3bodw7nSPvEXkqrKy85nXfr+wuQBYdz1+QS7nTjZ1PanUPETb3C4mNhpbFPydxaVkgXHQcG1sp9hVv2zRbf9guvysMSaIOp4LKlXZw+xCulxcHFzgRfw5EGwg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(26005)(16526019)(53546011)(921005)(7406005)(44832011)(5660300002)(186003)(316002)(16576012)(2906002)(54906003)(86362001)(7416002)(110136005)(8936002)(52116002)(36756003)(31696002)(8676002)(66556008)(6486002)(66946007)(66476007)(4326008)(31686004)(478600001)(2616005)(83380400001)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWd3VWRzaG1WQTZDR0dsc3J0dll3NzZ1MnBaK2UzSy9rM0VCZnY4MU1yb1Iv?=
 =?utf-8?B?SGhMZ2ZwQXVmZXU4Z05uSXZYckNQQnpqMjFVN0h5ODN0OVpUWWcrWjE4Ulpy?=
 =?utf-8?B?L0NTQkwwWmtvUk9sUS81K2R6bnJleTVhbktkcmNxTTU1ZE9Vc3IxQnBYK25x?=
 =?utf-8?B?M3djUC9JR2ZTL29TdkZGc2ZqRGYzTkZ3YVU0eUlBU0tqMTdjRFNBYm44NGE4?=
 =?utf-8?B?UTRmaXRQdmtqb0llM212NjdqZlc4N2NkQ0pHaHdMcUJtMHFhRWZIa1VHb1Zy?=
 =?utf-8?B?cnpRNXhHUUFFaTl2b3A5SFpmZUE2bzViTUxaWE1IQWt6OHBUWUtYMGUvcitP?=
 =?utf-8?B?OUhGRm5qOHczcmY5TFJSTkdSamY5enlCa3VIbVhkMm5LMWo5WE1rd3lLNHNH?=
 =?utf-8?B?V2NtYTdXemNLMklJem9yNzAvSU00blJzZzBmcXFyaUwwejl1ci9rcjQ4UlJI?=
 =?utf-8?B?QjNjTlM4L0dVYUswV3d4cngrbkIwR0VJeE1YdTlwejZpbmV1ZnMrT3lYeGE5?=
 =?utf-8?B?MzRmbzdLM1pCbktMSVNmZEJ5SVc4ZVpKb0t4SXU0c3ZJbDF4K1NGU1FhblBU?=
 =?utf-8?B?dTZVQUp2UVRkVU9OYU0wQWNsZUVxOEduUk1YN205Q3ZKNktKSjRsejRhZmxk?=
 =?utf-8?B?a2Y4QU53TVVzUDZ5WFFlaDlMbkw2cnBRRzQ2V2d2STA0M0hkdzR2bmNDTlh3?=
 =?utf-8?B?UlNQZmZ0WUFrU252dUJGR2NyRUJ0dGJxZTNWRU9DcnVSVVJ5SXJsWFZnQ2pB?=
 =?utf-8?B?WGZsZHU3SDRvS09nWmNUTjdvL3ZuaUFmWXNNUHpDaFd0Zmp4S2Y2SUZhK1Fn?=
 =?utf-8?B?QVUvVXlKbUw4a0FoN2lITXdpVlNNaW1iZU14WGZ1YWhWaHNBNjVaa2k0QXpz?=
 =?utf-8?B?OUM2S3BsTjhDRlE2aFRkRi9UbXpITG4vRENyaFlKQXNnMUk1NGR6OVpGRXpS?=
 =?utf-8?B?Vjg1cmErZklzcnN1VFY3Q3pCRXFxeDNSbDB5T0plSDZWK2dIcE9hZkFyNml2?=
 =?utf-8?B?Z0hXc2hSdUFKK2grUXJySVRMVXg4NEVOUjI3SFZjd2ttOExxN2lCRWYzZ2Ux?=
 =?utf-8?B?c1lIVDljZVYwdEdFWlppNldIUXpmMGlyQmhrMUxjYWhHUWhZTUs4YzZxN1Bn?=
 =?utf-8?B?QUFGQThvZXYvdVB6U2lBM3dwRjMxTFJPdW5vZlAvaUdQZEpxR3BlamdBcjZZ?=
 =?utf-8?B?WjdzWGpJRFJBRVE0K1BDYi91S3N1OEVheVNncGRjcVJId0ZqUjBVdVRlWnFR?=
 =?utf-8?B?WTA0aUVScXBBQVVYWlpMYjBiemxpZE5nV0JwSjVJbXRSSzJiWllySTlKc0N3?=
 =?utf-8?B?dnRUMHl0MlBzUDB5NmgwV0RiOVZwZEsyVTVGRkhDUm00N3ZyWnVtTW5iTFcr?=
 =?utf-8?B?eGoxQTJYaFQzUmpHTE9SUmRzUk1jbTJUZXlXclg1eG9BTzVPTTlaRE5RT01j?=
 =?utf-8?B?dnBaWXZYdHFBdXp5QXhycFlycE9rMGVjOWxYVVEyc3I1MlZrMVY2OXZvOHVS?=
 =?utf-8?B?ZUxFLytoUVk2SjVLZFQyQjZLRlJ4NTk4WEgzQzZOc0xYbTQ5TitmdnlsNUlJ?=
 =?utf-8?B?aXJoZmpORnlKWVdRODRnZ1drQjYrTkg0Q0lxMStlWUk0Wkk5V3RXM2NZMFF2?=
 =?utf-8?B?MUxVc1RZYmRFVFJsUEZTYVQ1OVkvV2J4MnIvandzUDQyaVBEbXZYTTFFRi83?=
 =?utf-8?B?QVV5OHV1Z3d6eXlnTlNqT2hsS0ZsanVjZE8xZmlLc01tWXBVaEd2M0xFNzdU?=
 =?utf-8?Q?G07td8SpeYGlrGYYPYZUQxTPn95Ow5xPE/0WGLr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb71cde-9eeb-4f08-b738-08d8cf8ac8cc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 19:17:06.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3vJQ563dNkQ8yh5wOha21fg6YHBdMSL1m+Ww/M1IcW6Lxk9Vcrb9m+Xd5x/aiC4iimT+BC2LftVqkbVsArzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1710
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120141
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/21 1:21 PM, Axel Rasmussen wrote:
> This feature allows userspace to intercept "minor" faults. By "minor"
> faults, I mean the following situation:
> 
> Let there exist two mappings (i.e., VMAs) to the same page(s). One of
> the mappings is registered with userfaultfd (in minor mode), and the
> other is not. Via the non-UFFD mapping, the underlying pages have
> already been allocated & filled with some contents. The UFFD mapping
> has not yet been faulted in; when it is touched for the first time,
> this results in what I'm calling a "minor" fault. As a concrete
> example, when working with hugetlbfs, we have huge_pte_none(), but
> find_lock_page() finds an existing page.

Do we want to intercept the fault if it is for a private mapping that
will COW the page in the page cache?  I think 'yes' but just want to
confirm.  The code added to hugetlb_no_page will intercept these COW
accesses.

<snip>

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e41b77cf6cc2..f150b10981a8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4366,6 +4366,38 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  				VM_FAULT_SET_HINDEX(hstate_index(h));
>  			goto backout_unlocked;
>  		}
> +
> +		/* Check for page in userfault range. */
> +		if (userfaultfd_minor(vma)) {
> +			u32 hash;
> +			struct vm_fault vmf = {
> +				.vma = vma,
> +				.address = haddr,
> +				.flags = flags,
> +				/*
> +				 * Hard to debug if it ends up being used by a
> +				 * callee that assumes something about the
> +				 * other uninitialized fields... same as in
> +				 * memory.c
> +				 */
> +			};
> +
> +			unlock_page(page);
> +
> +			/*
> +			 * hugetlb_fault_mutex and i_mmap_rwsem must be dropped
> +			 * before handling userfault.  Reacquire after handling
> +			 * fault to make calling code simpler.
> +			 */
> +
> +			hash = hugetlb_fault_mutex_hash(mapping, idx);
> +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +			i_mmap_unlock_read(mapping);

After dropping all the locks, we only hold a reference to the page in the
page cache.  I 'think' someone else could hole punch the page and remove it
from the cache.  IIUC, state changing while processing uffd faults is something
that users need to deal with?  Just need to make sure there are no assumptions
in the kernel code.

> +			ret = handle_userfault(&vmf, VM_UFFD_MINOR);
> +			i_mmap_lock_read(mapping);
> +			mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +			goto out;
> +		}
>  	}
>  
>  	/*
> 

-- 
Mike Kravetz
