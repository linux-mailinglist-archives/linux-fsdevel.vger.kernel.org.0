Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B376F30B29C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 23:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhBAWLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 17:11:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBAWLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:11:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111LiO0J192598;
        Mon, 1 Feb 2021 22:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=frGViDh2nTaD+fHvol7StYbZTZrQTCa9QfqXIjnlA18=;
 b=MH1Knn8Y2U8ruNacZ5Xcjaehlmm3H+588tIm7wewM4EKsbGcd4m8KTKc4SZq0VgLB1Hr
 BGqyJQpd1c0pGNql+itMCmDHJBXIxPaebPxLcVEz84c5hunWrX13TMBRrBfTjG/bPyYA
 NlaWuyyWyBn/Vdf54bTRvG/58c3QJOtXHv/u3RdU/iW4cR9AsH50ANMWqhadmQ7+veLu
 Y3olgLyStJveo9XiuasHSPo49PJCd09jRIpD6GCpqn1XAh23pawfA5AOVWiX+m3yhGoB
 B4fbHDhjSuo8yNSy3r2vqN5jYGQ4knLVDLHNgqo4Leeiz1D7UzUYGOVORRRf/zhgHtP8 tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36cxvqyvs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 22:09:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111Litfs036311;
        Mon, 1 Feb 2021 22:09:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by aserp3020.oracle.com with ESMTP id 36dhbx9dp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 22:09:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIceA2ORi8oJ4zb2jHmM0ttAYff5dMsQZKhp2C7WNcAry8hJV4v4ge2Siey5kp7pSUaTEqUBvTb4PVcCSUA/ZLxGWIRbkoDgaRWRozXFUdWrXWAlg+e/q/x9v2TduiW6k8D7lpHLyC7OcNKQ0Hs4T7Em8xv0o/pIM+6BLbcOU+SU6G1vzYaz3OC2YuQg6AMLIBTE8NfwB1YdsGyMK8hUmicPCOyuAPxujdQYoO5zFuKUBNvbPLXnROajyu6zoyqHtHpY1ZCchhsSHtRrawsOGXN/ysO/pg31wfS33S9eIP7FxQwyfze/c4bTZgarQm+NVlJAQWMMr87nWsLor31blw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frGViDh2nTaD+fHvol7StYbZTZrQTCa9QfqXIjnlA18=;
 b=oWIEEWai1lBR04WMaIUdXNQnxcTX8x+B4L/ema3VfZhAcLdaD7w2PPgLBUOdtBVh2M57BXgep4BPoSBERHWgNqwb7nY4mBaBPFkt82Dv/ubmYOrj2JuHvrj+M+4syoJinzruIe1ojz1YrEjJMZX9Jv53s298Qd2UAx3tP8Fcmt5nszDRCyinMKRsFjk3G6T30n+VIxhXWrj5ppUc7BG54RgfcnZEWf6BrceHBd+4L4i41fVJm5pZo8jMtTZChCdgcAZKC0f8jV59L+c+fZTBW7TjGpx11UgUjDp/kUTwGmev3EeUNzUITba2UDqhy5daGsLxoDyJlk/RzeyD3n6OCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frGViDh2nTaD+fHvol7StYbZTZrQTCa9QfqXIjnlA18=;
 b=QKygKg9trviFvdGX1n46gSivVZtfIyUD7xYJ3Hg2l7KOEJpGnYCN9eXso9e5Zet4nxcuDzMv/NbHQfqKLWbfpO2b8/KbWu/bVuHXpxNDDoubU734uJWtDnPwXpvTPO/BjwFK80pXlHlK9JWYMHRnIIQHadFSk14KA9ko/E+yczI=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 22:09:26 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 22:09:26 +0000
Subject: Re: [PATCH v3 3/9] mm/hugetlb: Move flush_hugetlb_tlb_range() into
 hugetlb.h
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
 <20210128224819.2651899-4-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f0df405c-a8d6-d4c8-02ba-13a6b0c2ba85@oracle.com>
Date:   Mon, 1 Feb 2021 14:09:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210128224819.2651899-4-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0399.namprd03.prod.outlook.com
 (2603:10b6:303:115::14) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0399.namprd03.prod.outlook.com (2603:10b6:303:115::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 22:09:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d800ecc3-4d1b-4a33-08c4-08d8c6fe09a9
X-MS-TrafficTypeDiagnostic: CO1PR10MB4516:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4516582A1005231CF77C92A8E2B69@CO1PR10MB4516.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKkG1BIoBTZDkvk9qpEi4DDvTeKPdPip//ES3cv6hiAfViZksQ6uREnxNKZe9BGR/+ZbPs7SWs+vAMk4Ps0GxUfdNxT2JIkRv/kxglBQLPzzifcamH1oUEzGNp/7EsyorOJly4KbsyyuoFZG3rm2NedTh26Z3Elfi8+gZ7IMwSE1vmhQYyZjnnL1DiCT16vs20H5kkgRh6Ope9tira/fb1RWt1zcqFbsNzhc7kXW2tpBGscYxAU7AYJxAMSXaxmNcNyguqe4zIIPVb7nplKb/CjN48s7GoW0YA8zySmMVlDuXGeYtOi09ZMJ+pFhfxWNFVupvKmBX80ThWuZoETugaTsRQpHAONNDDWAtC+BsEwsndcdENnTO7jiE/+z7Hu8Jn3SC+Jp5eSmGH7Ev5I6cz2LTJCmLMFvSX7HgPE5S7NMxhdslhlLvMF2vFrtZ02rUrZs5ewYzNcr5QaLm/UI/5YtvlY/5550lsdPOQ/YBKmBYvKN8cTftRaczZHM8NCxjuPjihyoe/trZWbqCPKAP5GWXv4vh52MYS9NekBVSI0jq6Prqq01INKdKcI+psDqKChB9TCpszxhUX6gvO6uPLiiZ+/WsMrOXPGpN+pQ8xFwgLwMti1VSquz2D86zn8L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(346002)(396003)(366004)(52116002)(66556008)(921005)(316002)(66476007)(478600001)(5660300002)(66946007)(6486002)(36756003)(2906002)(16576012)(26005)(8936002)(186003)(44832011)(31696002)(16526019)(8676002)(86362001)(7416002)(7406005)(31686004)(4326008)(54906003)(110136005)(956004)(53546011)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0E2dXZhRkJEcDBPbWd5U213a1hCN3JQcVZWYWhVQ244VUlDYnlFYm90cWxQ?=
 =?utf-8?B?RkFna25oRW5JV0hNbUdNYWRHc1pPVGczbzBPVllrQWRKR2RpYkhYYVoxNmVi?=
 =?utf-8?B?My9JdUFVSjFlSVgwdFdGaUNBRGprbFNzclVpV0M5Z2xNcTVmbjZyY2Q0VnVM?=
 =?utf-8?B?SVp6b2MwNGdoR1NxTVNNTis0Ly9ZZlVxN2N1ZFNBbFZEa1hKL29nNEJpdllh?=
 =?utf-8?B?U2JNQ1FPRG5tQXJCV2d6NzRjUVg4UWIzcW9Oa3hNZnJlaVhIR0Vub1hSVWMw?=
 =?utf-8?B?bndDcVkrbFRhUEY0RDdPWldiWkI4Lzh2YTBmMEcyMndmYWZaQW1RMzhweGJM?=
 =?utf-8?B?UnBZSXhLTDZkeHdhbGNyTlBxM1Rta1NRN3RqeHhNRXlaRjloWFBwbk5nMit2?=
 =?utf-8?B?Sk9qVXo5M2x1UzEySExlWS9FM3pJdVJmdVdrTEZnQ091MzN6cWcvTElTZE5w?=
 =?utf-8?B?OUtKaWtVUTV1OU9ZR0V5L3hiSnFiOTExM2pnVUZOcVZuUVpadGhyRmVtdXBq?=
 =?utf-8?B?amlsZStPbS9zL0xhTUpKeVBCdjBlY1FuMC8vL2l6WEJuZkVpSXNjT1JKTFNk?=
 =?utf-8?B?QUFIZDFFandWNjF4N0NXanRPNnFvLzFFN0F4Q3VWelVGSDhDa1RWM0REdjVp?=
 =?utf-8?B?SCtrUVJMMUZ5R2o0THFmTllla0x5K2dhSHE4SkVvNmJKSkEvM0FWSndQQXFp?=
 =?utf-8?B?Yjh6OXVENk5ralJkY05oMGxGREN6YUZScC9sVlhLbVpuTkNVbXQ5cGZpOTQx?=
 =?utf-8?B?TCtFYmdWbGZ0SCtMRGtpK1BvTXArdit4OTBhSnk2LzRreGVzZEd0UGpRUG1T?=
 =?utf-8?B?OXVPb1J3N0pNdWZlQmt1YWgxZmFSdGhhY3NlL1ZwR0ptYWYyVTFPbzRTTWh5?=
 =?utf-8?B?TXVqdHN0ejJoRVg2cHBsTzBjRFVGbUp4dkVEMzIzM0NCellNQzJpSDFVbG1o?=
 =?utf-8?B?L2V3ZHMrYnJ5UTY2ZFZ2ZHNMeUJaODVpbTFXcm1IaDBEUFlDUDJrblptNWZ0?=
 =?utf-8?B?eHZudXpIM3lNR1crck15Q2RheXJiQ3RVSmxPUDBQRytadlh4U1hBUElnbURh?=
 =?utf-8?B?R0U5SUM5TGhZSnNDNkJHbzRDenZKd2JJOXIxby9lK1haWCtlTFhxdWtRdUpt?=
 =?utf-8?B?Z1EvR2RpOUdIOGo1b2dlRklOS3o3Mmo5ekNEcTJ3ZS82MmhobjJZZVhOV2Fo?=
 =?utf-8?B?cm9UU21Sdk0wMHdQVjJINmVkaGhtSzB0OURQZzhVMytjNEZKRTZ2VjgwdXBq?=
 =?utf-8?B?WWN0S2dnV3U2azF0QkJ5U0NUMk4yeURCQ21GSERUUHNtM0djTlpqSXJWdnYw?=
 =?utf-8?B?dmhSN05KT01DcGppUGgrUlo4TVZ4T1FHbktqNFJJTmlzcjBmaWpBNnNTdkto?=
 =?utf-8?B?U0tTVFJUT0tOMktieFJQSEhqKzV5YnJIdmhnV3UwMFFIOE4yL2c2Rzc1aEtX?=
 =?utf-8?Q?fKLXVmxv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d800ecc3-4d1b-4a33-08c4-08d8c6fe09a9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 22:09:26.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maczdXCdMbCed6HmQSJff4Ft0MPO2WXU4+XVkc0sCuQh/5yragFLx4FRqOJcj0+gGNiPoP0yq/PFzfmxf6lDhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 2:48 PM, Axel Rasmussen wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Prepare for it to be called outside of mm/hugetlb.c.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  include/linux/hugetlb.h | 8 ++++++++
>  mm/hugetlb.c            | 8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 4508136c8376..f94a35296618 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -962,4 +962,12 @@ static inline bool want_pmd_share(struct vm_area_struct *vma)
>  #endif
>  }
>  
> +#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
> +/*
> + * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
> + * implement this.
> + */
> +#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> +#endif
> +
>  #endif /* _LINUX_HUGETLB_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d46f50a99ff1..30a087dda57d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4924,14 +4924,6 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return i ? i : err;
>  }
>  
> -#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
> -/*
> - * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
> - * implement this.
> - */
> -#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> -#endif
> -
>  unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  		unsigned long address, unsigned long end, pgprot_t newprot)
>  {
> 
