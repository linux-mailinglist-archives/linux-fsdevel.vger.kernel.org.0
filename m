Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7462C3247DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 01:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhBYA1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 19:27:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60200 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbhBYA1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 19:27:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P0OprR188313;
        Thu, 25 Feb 2021 00:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=b4S/SZf4xC29+M++OgJm98adPSn94jcHB3NcMQO0VBE=;
 b=SvNTJbyx8/awH07aoqePGgflEIluqhoBak/ca5Vs2hpcaz6bW/dlj0uBsXjbNGYLuLPv
 oofj/VFd5AHa8NmjOZaj2xrK9TDwcgYCpglQ3R4an8jNx+/w6N+HM/Vn/GO5viwCWHtw
 EbTRRPaypATw2e1RARdaXbn/gxy83UyL+lgL3pi4hat5QnmNw56x2U/bGKZ9v+kFaMOz
 roA1vLDh+M8T99J90BLRaEEjDYIjCa1h/jCDK1LNkgU8NVFF62pFuevYXEFqYuYSYp2I
 3edPvIQX2pF87NzNqu2GlVPd44RxiDswC1hUOafMVpBJSwQHyfYmXTOfXcZXCo8+MCvP sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ttcmcsaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 00:25:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P0AdOi137908;
        Thu, 25 Feb 2021 00:25:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 36ucb1cx06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 00:25:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTEU2cEzPRIbtM0SSeNXDKvy7aa9OxNUDHBCuO9JrF5bEF18i6PE8jLSaogPPs5z+6XaV04COBEaZXipUHvnrsH2gEsqG18Geff+gOyTBAxWpuiXJwpJqT/yIuVseqxKktLnLfErZJOJL6Eq+kkLxWCDyWu0hh+vugl06+bn/xS/kVdquR382yS9up3a77LH3BlhdPARgv5hN2zETWFNc80eOpwLKYyJhjdvnkoWLKtM8FGzJmoeJoKSrn78hk3RzUhjN+n3yZwrqTwfSQbiAEs7FPWHCyj334hR+WrmXe07efabqfccxuBCaiHsz3N0bv20WQqQN0ClyuUlWTk9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4S/SZf4xC29+M++OgJm98adPSn94jcHB3NcMQO0VBE=;
 b=gJtibL7FR8ODJ6Vo549zagNkWKuELcBbSLSyrMKWHspr4QY7kjpmiXB6j6QtqyzYo1E3UoloDg46pPX1Dx1VtstiHhfQF8yxNR5oemqG63PlVjlM3vuWZArVTQUADkkiFRRHUycUg6Y/cqEmPF5m/kI9Zgdk2jeij2Z4D7mQA/sY0FNM3/kIAzp/avvf3aMhDiKqHbueJ1DiEZ9Kzm0gaZOUs23WeT80HZb41IPt2jdphisyGt2FqSvGaWczTL7iO7DdHqXXOrXM4nlHz5PSKE2YTczFhjZKK1uzcgEy9AGjpholBa1eUBlbJrBHfi4HFHUkfI2P+JwHsRF5v3CMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4S/SZf4xC29+M++OgJm98adPSn94jcHB3NcMQO0VBE=;
 b=qLcNnormb1OlQHTH7Ksg677bnfne5OJNDPSHag5z5RZseSTyg5Morcav7FkO2PHHS69eCeY/xSm2sjlO9bv0jGI6LEcCP94vFqRdqExf4pGdFADQLY5IbHvhg03YIwzJcJgtoEjLLxOQBKM2Li0w2Oksfa0EIfFyEnNe7MD3ntc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3810.namprd10.prod.outlook.com (2603:10b6:a03:1fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Thu, 25 Feb
 2021 00:25:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 00:25:01 +0000
Subject: Re: [PATCH v7 1/6] userfaultfd: add minor fault registration mode
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
References: <20210219004824.2899045-1-axelrasmussen@google.com>
 <20210219004824.2899045-2-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6aefd704-f720-35dc-d71c-da9840dc93a6@oracle.com>
Date:   Wed, 24 Feb 2021 16:24:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210219004824.2899045-2-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0372.namprd04.prod.outlook.com (2603:10b6:303:81::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 00:24:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d63c9a4-6c48-48ad-c3ac-08d8d923ca14
X-MS-TrafficTypeDiagnostic: BY5PR10MB3810:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3810FD7AB0CA2409955D9FD4E29E9@BY5PR10MB3810.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF4/hZk1RSYr5elF4TLUoRn5TMZJpzC/IAxIauQiQtKyN2ZNZ8XVvXEBUbD2dOt7bYouidVLXUJBZN0hIoR6EV5chHyDaD3/3hHcPu19F2hstOrG+Kk3eCsvDOREAEbNtzSeBTGZLNk7cW7dwldQnRtA8t4vosDl1r1uzCXer/BG7hboaMcC9SSO4TYVpL0FCYrGiMLd0McKdAqfanWhE8cVB9uNGN+cO9e+e8TeSpsBZpwia0T3syi3FlYpiEbY1tZjUnJqq3pc9pReROTo2do/pX2ocTCgaH9u5IrKEOyO7Xv2OmzFidCoS3lJrl6ZtkneRy4hD0hOPk5htk1BxrX7SzoQUr5lfDbL5N7O3ptxJMwBIXWI5VIyTv1uCsRk7HlxVlpEkZaThEVQsJMAsU2IMYVUTIWUMLm8v43AO9E06A37UFUqyhJhF7vj3PIMX91JzErgbmeG32LK8BKv3m81OnLwZNfrtleCK9uE+lpFfzuVje5+HnOOSHQIKBPuiCxjp0Ii/+73IKgLo4Tz90bXrjD3HkhWm9LkcMkimN5G4J7CgF+s8uHpHxt9FWXS17QY+F04yv5dxvuQo27Y94zpjt+mD+rkrHNgkhfQO/UpUqeKMwxOtoooI+JNkgoD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39860400002)(376002)(2616005)(7416002)(44832011)(110136005)(16576012)(7406005)(86362001)(26005)(4326008)(316002)(478600001)(956004)(921005)(54906003)(6486002)(83380400001)(52116002)(8936002)(8676002)(53546011)(66476007)(36756003)(31686004)(66946007)(2906002)(16526019)(5660300002)(31696002)(186003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2NESkF4OXo2YStPOVU5bEp3bFdkQ01hZEI3MTR6TStQY216VGlYR2VTK0cx?=
 =?utf-8?B?SnkyS0UzTFdOaElHT0k5Y2VaZlM1TWQ3UjFjVTdaWFFsSk84Mll1bC9vSmQ5?=
 =?utf-8?B?c1EzakRpZU1Jak12c2pUTFM4cGhBSDBPUURnb0k0Wit0UG1Ea1ZhZDVvT0s4?=
 =?utf-8?B?aGptTDNIaHpIODlTK1M3Nk5JWUZ0dGZEeWxIZ25QQ1BSeTZUR2tMVHU1SHJh?=
 =?utf-8?B?TDRVM1JhUnVxSHZXZ0lMMlJtYXFZeURtLzI5by9BVmlNNUo0RXpzRVYzK1Iy?=
 =?utf-8?B?bnBlY2xMWTJjTlJJLy9tMkZUeTk2VElIVnZLVEZrTC9pR1F1R3pCY3k0NEpz?=
 =?utf-8?B?YzZML0JmM3pJU2M5cnhFVXB3VHlpRi9GVk5hWThqQ25YalZaWWxqbWMxcDFU?=
 =?utf-8?B?dk80bEdyNi84NVpybW1YNjRicDRCanRldTFtSEtNL010bjhrUEFQZUFpd0lt?=
 =?utf-8?B?MktqY0pVTHR6Q0oyczZ1RDV6QlNaV2dnN1hqaGRHZ0VkTlpheUVYdWlVVks0?=
 =?utf-8?B?cUdwbTlmSXlOOWFreGpOV2VHdmRWQ2UrZitoeUk2dU5kbzhxYTBoK3JhclVa?=
 =?utf-8?B?R0RhSlZIZG1NbzVoQ2ZCSWVSNU55WTVZejhidktTWkx1cGtTRGRjMHJFdTcv?=
 =?utf-8?B?bU8xWjZIMjU3Tk0za2svanY1QzZlYS91eHhZWjg2bERUWEVHUEZ5V0pzUGhS?=
 =?utf-8?B?Q1ozRHFFZzlZY09aY1p1NWNIWXZrVGRKT2F4eUZhQzBTdjFUUFBmNTl3VC9R?=
 =?utf-8?B?K3g3dmZTMGhxWmRsQ3FsZnFlZUY4SFhoRzZGeFA4UEJ1UUpuTDZaTWtZOWlv?=
 =?utf-8?B?cDNkOERaYlloQjBVVGx1U1YreWplWUtXMHpMazBSSEJvM240cXpxTXNzSmNn?=
 =?utf-8?B?Zy8vdXJsWktRVGFNY0twU2hHemJsMjNTUUhvc1BzcUhyVVVsdnNSSDFPRGwv?=
 =?utf-8?B?dnJWQ2JGcHRmTUtjSzZoaW1Nb2tacmxzQStUbURLaEpyVXUxSllRUVM3Q3Q4?=
 =?utf-8?B?dzcwMWZEYVVHeG1iNkp3Tm56ZFhGNGozanlvUDJKaGNnNVJYeTFyV01WWmFv?=
 =?utf-8?B?bE1iK2wwSUx5WFNpa3V0YzBnb1VBcnpNbmR0QU5IcEUvOTkyR3NRU1pocHla?=
 =?utf-8?B?SGwyUDZzNzM5Ty9IdXlnZFZOVzFpL2JCUGRZbTg3RFlaTDlhNkw3RmY3bHVW?=
 =?utf-8?B?TkY2SlRmN3ZnS05HalRpU2dQMkFQT3IzU25IUzB2RHdWcXhCSUJFZ2MyQkJj?=
 =?utf-8?B?NVJYWHZ5bTJrZFlYT3BnSVlGVW44ZVNCSUtvRGgrN0VxVEVkeDUvZDVjNllM?=
 =?utf-8?B?d2RlSE1DU2tFdzdSVHlacmhFNTFRSHlUcG55TXZhMHN4MXphVGFWUnhqd1lm?=
 =?utf-8?B?Y3EvWDF0b2g0WEkxRDd6ZEp5Y0hqOUVMZ0paRVNIWjJHZjEwaFJsd0pmTzR1?=
 =?utf-8?B?N0hRMFF4cUpwWjUwWlhXVTNBYUJnSUZHdC81NFQ4WFpTSFpsc1FtWkx1UFdz?=
 =?utf-8?B?NVhIV1VFN2NiSTVjWkt2WWlVeUl5V1Z5UVJTcC9XL0tramdnUFNjWHFjVjcz?=
 =?utf-8?B?bU5GcFh1N3JSMmVMTUNOZU4zakNXNWV4TEJEL1Z6RFo5dFoxWUxIWlAxL0VI?=
 =?utf-8?B?ckdpblJyRHE0b3hsbjM1akUxRTZTUnE4RDR6WnFyYllTU0VRSGM3bGFBVytl?=
 =?utf-8?B?eGdxNkdGMmMvMlYySmtjS3NOUXVSOGRVZ1hnc3lLQ2NMeDY2WjVxL3pPc1Bq?=
 =?utf-8?Q?wsrmpQU6kjLRlaUD/LTh4/jLPzocKI3nlItgG0E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d63c9a4-6c48-48ad-c3ac-08d8d923ca14
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 00:25:01.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUhnMqqgNYClunXYFdPOHp08nAIQc+oA1Bfs2kgnXrrAxn2io13+v0CFlOYGAbQ1nCRgTFF0N67HC1a9rX85ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3810
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250000
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/21 4:48 PM, Axel Rasmussen wrote:
<snip>
> @@ -401,8 +398,10 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  
>  	BUG_ON(ctx->mm != mm);
>  
> -	VM_BUG_ON(reason & ~(VM_UFFD_MISSING|VM_UFFD_WP));
> -	VM_BUG_ON(!(reason & VM_UFFD_MISSING) ^ !!(reason & VM_UFFD_WP));
> +	/* Any unrecognized flag is a bug. */
> +	VM_BUG_ON(reason & ~__VM_UFFD_FLAGS);
> +	/* 0 or > 1 flags set is a bug; we expect exactly 1. */
> +	VM_BUG_ON(!reason || !!(reason & (reason - 1)));

I may be confused, but that seems to be checking for a flag value of 1
as opposed to one flag being set?

>  
>  	if (ctx->features & UFFD_FEATURE_SIGBUS)
>  		goto out;
<snip>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3bfba75f6cbd..0388107da4b1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4352,6 +4352,38 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
> +			ret = handle_userfault(&vmf, VM_UFFD_MINOR);
> +			i_mmap_lock_read(mapping);
> +			mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +			goto out;
> +		}
>  	}
>  
>  	/*
> 

I'm good with the hugetlb.c changes.  Since this in nearly identical to
the other handle_userfault() in this routine, it might be good to create
a common wrapper.  But, that is not required.
-- 
Mike Kravetz
