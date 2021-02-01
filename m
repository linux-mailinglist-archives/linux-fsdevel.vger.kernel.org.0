Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CAA30B285
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 23:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBAWFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 17:05:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40930 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBAWEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:04:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111LiDF0013024;
        Mon, 1 Feb 2021 22:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UUfu2+s12t8S+dgfkJIWEON9seQuTO+hIlGRdatfZaI=;
 b=DmZOeLnX1J10Dah9xPSaiUND9qNUndk1+x1xRWrUdvNbTcG7PMozmAgI4ZqedDbjWMT4
 W3itX32IZCC/yjStsqr9udfTOQZUk+DXtayDQ843pCkeoKIzw+VVOuasfDnM/2AJgQBe
 WFfBcCUhYumfkQJnYJFJga7yei5lfQ08STCX6O16oJzryukHM9NdxO6hnMZxiJi7grFB
 GyMwnDnn877jtfAGTFKsNgjHdnwHpKjo32otwz68dgx21D3tknzQZ/Qcu6kMiqMgqrlQ
 FYLjtbiRpHw4w0iCVvgb9kCwlcm7NlcGv7f9dv7aMhBo/7/l2j4WbGwajuqeYf9iyBqQ hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyar15k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 22:03:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111Litj1036298;
        Mon, 1 Feb 2021 22:01:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 36dhbx96d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 22:01:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuVFhzikADp2xijKTb9mT5+ZlyG7Ah71ANFy+pk8o+po83uB/RxNGJIGFvdjTW0ZXBdYmnnTbTHWQswV8TavZ3rbR0rsKG9AqyvPd16oxby/ZmGBfIt2Nrle6zM9wIyM5eGOXQDls3vewJVDgNMmUsefU78jlcVYL8EB47O1lxKT7zpjQnfY8idwal8XaD/i0LvD1iBF3c/cTnQtXrCm2SRMgBKgUbQVMH+Sg3kSl7O6CeG7qOTQYNx++SJpslvq7ETy+IMUfgvF2yM6ZL9IrHIycd6/T1b9I255cRHVjrUNiJoReMhK+Lp+x5O2+zEJ57ZJxNVV+FyhLuixFJRGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUfu2+s12t8S+dgfkJIWEON9seQuTO+hIlGRdatfZaI=;
 b=b3s6AXKv1wPsIKvVeAF+nUz3TdBBzOg4ffPCdNkyNJ05uEdD8Q5QEBq0+g2jVA242YOgeHHMVon98uBZp3lfPqIvReB+ysj+tR6mwkOkkVS+OP2c7LhEChUvKV5bqNBNSn0O1wSsaNJPzwmr4ZW0as9aYNKXVO4kf7qsoFSbfaPEx0J3QFtE50u8C3uWzWe8uqCKY71b8y71Up0DLBSZ9gwKn/l8bCEWaH1nNeID8sUc8mRjtPx3CydRZqBMf6+K3QHRxYDNcW7/agRGt6U4aFU14IQlYudovbcBvxPlZl7zSnJyZN+CBIOHDXjZHyl/C5C2vYHCCAFekeySQDo6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUfu2+s12t8S+dgfkJIWEON9seQuTO+hIlGRdatfZaI=;
 b=bjVOmKgJ/1MbyTxDzQM7aeAb0us25IDSPbZtRNHfCzQuCX2KW3h2Z7+IsVuYDsRe3H3P4qlE63GHi02qJC6pQjgul90XKQ9qALtTOelxbvC1wKwpMsE7r4UzsgNoYRjPBh+oBUz7yxtVGnG68Mb67CVQ5ckey0TdQYLkIyPkgCw=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4530.namprd10.prod.outlook.com (2603:10b6:303:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 22:01:06 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 22:01:06 +0000
Subject: Re: [PATCH v3 2/9] hugetlb/userfaultfd: Forbid huge pmd sharing when
 uffd enabled
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
        Oliver Upton <oupton@google.com>
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-3-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7471a4cc-189f-64e1-4ddd-f95594a35bdc@oracle.com>
Date:   Mon, 1 Feb 2021 14:01:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210128224819.2651899-3-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:104:6::23) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0097.namprd04.prod.outlook.com (2603:10b6:104:6::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 22:01:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b943bf2-f897-4787-b76b-08d8c6fcdfd2
X-MS-TrafficTypeDiagnostic: CO1PR10MB4530:
X-Microsoft-Antispam-PRVS: <CO1PR10MB453089C90C0BCFA5EA661477E2B69@CO1PR10MB4530.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jNbv/xTM+AXwOzNNUy/9NC0yFm4STMp6pZFX9PD89LCoB3ExSNa+7ljOQvsKqs58PQZCR5txmMkkBn05nz9akv+Yx8PvRUDG8aE/M/b7kAM9KvkwhmlEih5urWAQ2IzPT5NpVaHbPxm/IRkwceeo9D2re8v4yyGCq+6Fe5bEqm+kjndKwZtKuRi0dq3933f2DW1DLlu8QAZWdkHAN1OyZMV9zoifpURAFUWVzsBn4+3MFHErsC2vFBl1wI6scYn8W9pFNgms93qU1Ae3I4pgyzqfrct8YLgpcvr6w8i/9oMnl83UJmKlki1izX4R2ZYc1u64rPbPnaHVpX2hcImabp5kKpa/LIf/Xk2i8GOtQh2DNjIAx3/DaebodJwaPHL5JIArDO1oDN9VWQamxrGMo2D1YN0WqOSs8UHTMZEXsyPbeqd7QD3UEal5KWBzLDvXW1Wos4cfBCVu3KujWbtynT7VVe1VeCK2oE05SY5Fv33s492ln6gjJ15PPgaPR1NjmRO/ILTovcqH5KedNILQYCq1p8gHsqIJxxhgii4EV4LmAOBVEDMs71Jmi/GSbwsDsrZSD+CHqwDI2z+/i0RZMu054UAeXydoJNxkwnlJLz/x/VFLejaUsoR1cnDQOYI1jOzvw2aPg+sEoSgTgKKsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(376002)(396003)(136003)(316002)(7406005)(36756003)(66476007)(186003)(7416002)(31686004)(6486002)(83380400001)(8676002)(16576012)(110136005)(54906003)(52116002)(5660300002)(2906002)(921005)(44832011)(31696002)(86362001)(4326008)(8936002)(53546011)(66556008)(26005)(956004)(66946007)(16526019)(2616005)(478600001)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VGwvbkZTMWxGdE1hMDh2azducldvM1N0UHF1cEF3a24yeTVWK2tCcUF0czJX?=
 =?utf-8?B?bGthNVVDWE80RXVPOGk5WDdjRndPNVdiTmRWbVNjbG9MSW5Ed2Vieml4Z3hx?=
 =?utf-8?B?bElhWjdwQXpIQi9qZG5ud25rUEM4TXdjZ29xR290YjhsaFlLUlVySWJjL3c2?=
 =?utf-8?B?MEErSno1Y2JVN2plZGR4eU9UaXQ0WWpQM0NTdzROdnZaTVdheG03elZOejdh?=
 =?utf-8?B?WXZvYm1PU0hDcWpXWlRLTjZzZDF2eTcyU2FIYnoxM1JzVkJRTzhMODk2ak9w?=
 =?utf-8?B?YmllaTBHNDZ2dll0b1BOeGdqOVYycWdJNzMwR2RjWEt5YWZzTGJXb2hORTh4?=
 =?utf-8?B?dFJudHlGMm8vMzg1THlNSWtmc3dNSnlLV1lXWFJUUW5aNEtNZXo5STFuMEJR?=
 =?utf-8?B?NzhxWmdlRy9YMWxJSzBWVjhLZDN6R1ZWREdUYXk3RDdNLzkrb3pTV2h0Wkk2?=
 =?utf-8?B?SCs5T3FZb2N1TVYvSURHRE1LTGk4dmY2dVlWMGZ4aURCNHViZ2lKajJpalFz?=
 =?utf-8?B?anR5UkZjWjUrTDRWZE1VcG04bW5hanl6MVpMQlk2QUJaK2UrWHR6czZiK0Zl?=
 =?utf-8?B?V3BuS3BWZmovSGRIQ2t6YVM3V2d4VmtpNVpuMEZ3cXhrYjhxdjZKU1ZUTi9v?=
 =?utf-8?B?SG5rbjZUQkpHdTZLWS9FMmdwdTBmR2FWTTZoSnp5NU5Bem1YaW9kYjZpYmU5?=
 =?utf-8?B?TVNxbmNON083dmVhQmRhMkJ4QVdsaFQ1cmhMYTNHVnM0YnJUcElZNXNRUjZF?=
 =?utf-8?B?QUtSbHNnV2ltVmdyWjV0MGRDZUtnWHl3UUtjd1JsYjhSOUl2cGRSbnM1QmN4?=
 =?utf-8?B?bGVlcU55RnFZMnY5a1ZSR0xxNTNabUxaNEtXOTJxZk53OWdqNjdzOXlyWng4?=
 =?utf-8?B?WnVJend2OU1pbDFET2dFai8yMStqaHpRMVVvQmVmL1ZXT01LeG45MHU5WDQx?=
 =?utf-8?B?c0htUnY0TVJHcGtPV3Y5TTRQa2pjN2c3YThzaXFsUzJDMVgyNzd2UjRzTVg4?=
 =?utf-8?B?bTl3NzUyb2tsUndMbXdBOXJBdjk2aFNNb1NiV21DZGpvOC9aRytLVmtjQjVC?=
 =?utf-8?B?NXh1RHNKQ3RwWnd2U21VclZ5bnBxTG8rWFdhTTMvUEJ1eVRucGRjTTUrcDJV?=
 =?utf-8?B?ZnI3VjI0WEIrRzQrb3c1U0xhakx0TEZVZFZ1UVFmd1UvTVdkWHlrdnBWSmhp?=
 =?utf-8?B?YlZsdDBOdkdXekRRK05BaFg0WDdlbXlWZTM1MnVnUlpQT3E3ZHZLcGZSMHM0?=
 =?utf-8?B?SHczdTd1Q0NYc2JkRE1RR052dGh4MXJ2aWdKZ3k0MnJnU1doa3NNRmZvWE5z?=
 =?utf-8?B?R05pRFVXT0s5R0VKTzh0MlJnaDFjSG8ySnNtRU9oT3FBWW8wTy8rSm85aDRT?=
 =?utf-8?B?SHZkeEtsckZWUmF1WkZvcTRaWmpMNkNDK3BPYlBJMmM0ZG9uNlBvYnBEUnVq?=
 =?utf-8?Q?+Xjw0L80?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b943bf2-f897-4787-b76b-08d8c6fcdfd2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 22:01:06.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETMeHirOD4SSCc5LgPZfxS6pXehwyMqMXEjoDwapCaiTII6mfCeFpf3HaAWClrw2z3yCCQi7UaO2B0tlc3NbQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4530
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 2:48 PM, Axel Rasmussen wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Huge pmd sharing could bring problem to userfaultfd.  The thing is that
> userfaultfd is running its logic based on the special bits on page table
> entries, however the huge pmd sharing could potentially share page table
> entries for different address ranges.  That could cause issues on either:
> 
>   - When sharing huge pmd page tables for an uffd write protected range, the
>     newly mapped huge pmd range will also be write protected unexpectedly, or,
> 
>   - When we try to write protect a range of huge pmd shared range, we'll first
>     do huge_pmd_unshare() in hugetlb_change_protection(), however that also
>     means the UFFDIO_WRITEPROTECT could be silently skipped for the shared
>     region, which could lead to data loss.
> 
> Since at it, a few other things are done altogether:
> 
>   - Move want_pmd_share() from mm/hugetlb.c into linux/hugetlb.h, because
>     that's definitely something that arch code would like to use too
> 
>   - ARM64 currently directly check against CONFIG_ARCH_WANT_HUGE_PMD_SHARE when
>     trying to share huge pmd.  Switch to the want_pmd_share() helper.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  arch/arm64/mm/hugetlbpage.c   |  3 +--
>  include/linux/hugetlb.h       | 15 +++++++++++++++
>  include/linux/userfaultfd_k.h |  9 +++++++++
>  mm/hugetlb.c                  |  5 ++---
>  4 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 5b32ec888698..1a8ce0facfe8 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -284,8 +284,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 */
>  		ptep = pte_alloc_map(mm, pmdp, addr);
>  	} else if (sz == PMD_SIZE) {
> -		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
> -		    pud_none(READ_ONCE(*pudp)))
> +		if (want_pmd_share(vma) && pud_none(READ_ONCE(*pudp)))
>  			ptep = huge_pmd_share(mm, addr, pudp);
>  		else
>  			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1e0abb609976..4508136c8376 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -11,6 +11,7 @@
>  #include <linux/kref.h>
>  #include <linux/pgtable.h>
>  #include <linux/gfp.h>
> +#include <linux/userfaultfd_k.h>
>  
>  struct ctl_table;
>  struct user_struct;
> @@ -947,4 +948,18 @@ static inline __init void hugetlb_cma_check(void)
>  }
>  #endif
>  
> +static inline bool want_pmd_share(struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_USERFAULTFD
> +	if (uffd_disable_huge_pmd_share(vma))
> +		return false;

We are testing for uffd conditions that prevent sharing to determine if
huge_pmd_share should be called.  Since we have the vma, perhaps we should
do the vma_sharable() test here as well?  Or, perhaps delay all checks
until we are in huge_pmd_share and add uffd_disable_huge_pmd_share to
vma_sharable?

-- 
Mike Kravetz

> +#endif
> +
> +#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> +	return true;
> +#else
> +	return false;
> +#endif
> +}
> +
>  #endif /* _LINUX_HUGETLB_H */
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index a8e5f3ea9bb2..c63ccdae3eab 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -52,6 +52,15 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>  	return vma->vm_userfaultfd_ctx.ctx == vm_ctx.ctx;
>  }
>  
> +/*
> + * Never enable huge pmd sharing on uffd-wp registered vmas, because uffd-wp
> + * protect information is per pgtable entry.
> + */
> +static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
> +{
> +	return vma->vm_flags & VM_UFFD_WP;
> +}
> +
>  static inline bool userfaultfd_missing(struct vm_area_struct *vma)
>  {
>  	return vma->vm_flags & VM_UFFD_MISSING;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 07b23c81b1db..d46f50a99ff1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5371,7 +5371,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  	*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
>  	return 1;
>  }
> -#define want_pmd_share()	(1)
> +
>  #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
>  pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
>  {
> @@ -5388,7 +5388,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end)
>  {
>  }
> -#define want_pmd_share()	(0)
>  #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
>  
>  #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
> @@ -5410,7 +5409,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			pte = (pte_t *)pud;
>  		} else {
>  			BUG_ON(sz != PMD_SIZE);
> -			if (want_pmd_share() && pud_none(*pud))
> +			if (want_pmd_share(vma) && pud_none(*pud))
>  				pte = huge_pmd_share(mm, addr, pud);
>  			else
>  				pte = (pte_t *)pmd_alloc(mm, pud, addr);
> 
