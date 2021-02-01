Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672EF30B2CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 23:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBAWfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 17:35:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57328 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBAWfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:35:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111MUYWq087359;
        Mon, 1 Feb 2021 22:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=uDzLM6n6KhA21x4GgnmxMW2F+QWTm0cohXugxkfow5Y=;
 b=IP9XniS2E10IaqcLq9gJR+IU1Si0wPupfI5U03A2WenmVxy3TX8TyL5zGKFWfF4nnkLP
 sdowLVHf7Gge80+pmbz5MnfnhhX5xxRRykzz39Zh78itXTntP5hLmEi763VSxhF5dEmY
 HH5jWv+9VcxGGFLR9AL1sL3CUp6KMi6/cahP8XTqbpPrPJ2ExMPvVt1KdZcoz/XkuBp9
 jhZlI5GI+2ejlGGrB7o2Mm0taLMSMOl9Wb00elkdyDT7G+rYP4hYkUAKnQEScg7BeQMd
 y54tRbW4pEK1yjrQX4snGfbuAacTnDyNbt9J/87zZn0HXCC+0MuqKeQ/jJz3z04Klp+B gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvqyy12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 22:33:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111MUWrl038932;
        Mon, 1 Feb 2021 22:33:26 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by userp3030.oracle.com with ESMTP id 36dhcvp1p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 22:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqIJ3MUAQ3wiaG+XYC2oQOQkHihyqW78q1Xh1XS5hyOw3It8weG4KeOlQUtlLOWLQOxkdoRugeO9qsauDJCEPz4jleE9ckUpd5UaZoS2SJe6T5MW+7p505Fn34/dZmgLTqv1wbUumiW6xu5yLQiySsyAuXXoSKomvkPUfkrKNey7wUrysVpgtxkf9vpJb+pTo3SkvRfEVfLjUHfDJQbJ58iNntFSHt4iREmuIK0+6TF+nWkjkK+MdvOUV4pBK21Khin8gvhl0zqrpXO72Ex031AJlL7qXwc1t5fceRMwiZLQFTwEr+uoEc8xUWEtr5T+hgBPxu5kF2Nk3BPhDxFR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDzLM6n6KhA21x4GgnmxMW2F+QWTm0cohXugxkfow5Y=;
 b=ieyiWrp1UD30yHRiuP43lPTqEL9a7nRR/Cpul1V3HVOCuhMWQK60GKGRdHSVEsmuf/AzhUlrAFN4UZ5ivew9IkO1EvHppnQcvqSP19Ph+zIiv1HQ8KXHUhmEiGZPxXN54j9f67iWoco36vNAveS+THTFUjHcspfXzZoR9JQgjfQ3VwCwoOE6NVrMd2wkPKPYriI9r7l+YyEEIpqfX+b4b6ERAuhyspgr/6YVN38xXcMON552y0c96CgEZu8rE5duRXUB8UpVESzFB3kVPkqy66JrP95TDqkao0H5FyJF+tugVM5UdSmPRa2ThJfOKERYRCDkjmL+b8KWt7ThW0w81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDzLM6n6KhA21x4GgnmxMW2F+QWTm0cohXugxkfow5Y=;
 b=UDADXDof0F33KpcW0osAvRpFFBeb1rfytLtQA0G115v4ZpAg2CvcLKMqFuLEyGs3z+FVdn2TdD0Clfh5Aqj6ikJhQnHkCUsTCfyR6B0h45DgT59hetr8REPQJTxQe7T3TIQr7ru5RgFaj3VvCokDBu0VripYd62J28Xx2KgxTAg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1853.namprd10.prod.outlook.com (2603:10b6:300:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 22:33:23 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 22:33:22 +0000
Subject: Re: [PATCH v3 4/9] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
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
 <20210128224819.2651899-5-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bdac0f96-1d6a-6450-c58a-6902d985e3e0@oracle.com>
Date:   Mon, 1 Feb 2021 14:33:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210128224819.2651899-5-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:301:1::24) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0014.namprd11.prod.outlook.com (2603:10b6:301:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 22:33:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ee446a-c6af-4c4d-8310-08d8c70161f0
X-MS-TrafficTypeDiagnostic: MWHPR10MB1853:
X-Microsoft-Antispam-PRVS: <MWHPR10MB185372D6F7FAB324B75CD2D5E2B69@MWHPR10MB1853.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTyDsRCl79d4oQRUsr0g4UZs4ujc+BEI7fDOVxUyLr+mhHJqhajKWscXIH43+/a1ShgdRlqoQzTtX62qyBtuaO4IiRaxb8PF/emUzjKGI038JJjfEFdfD+51aOXmsRCHr0ULBWPwp7jFp9xfsSkE5DZ4yZSQfPbdfzpItlsl99NnRpGDYBhDToL99awVh6HhBaD6MhfJAU0zHL1EDSpZNw9vlRh6Pe0pSKhJYsSojhmu0+s8yiUJXH00g06J4Aifrpe08AScLiNDPYSdP4v6aVZQ2HnGT1ToYRIoCGsq+diiDX3npvDP3GBuVIMJh/uxfNPkMI1BDu7zylTqUZOTW3gXc3taJyT0mgOdQ/yn4Sn8LUrWORtZkEptu4dqk0ludPVU7J03jOhMaaxkb0oxY6VN57DHW1T1FK+zd7niim7WfxUGWwriO1n4hBgSxMlDKPU2Uj8oeYU4avfc15ryx79OFy9PgZ3vuI26Ph2vQ19O5oZpUFSwjfS+SxhDE/goAI+0eu9udWGHFhIF7RAmMLTU4FxWX7pvda87t/Oyn4s8Bd2X5Bb5qcZX3nouhS5QPR2S+P5f7qHPYMeGLieJo1P7AmpY/VOqqm8SBO52EZS+2BT+AOrzzraxd+VtPCe3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39860400002)(396003)(86362001)(36756003)(44832011)(7416002)(7406005)(31696002)(478600001)(26005)(4326008)(186003)(16526019)(8676002)(6486002)(53546011)(2616005)(956004)(2906002)(66556008)(66476007)(66946007)(8936002)(16576012)(316002)(110136005)(54906003)(52116002)(5660300002)(31686004)(921005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dlEvUlp1SVNqRXZMYnNHOElrSzVhdlV1VzNRQ0twcjlmN1lXS1lSQ1d4K2Qw?=
 =?utf-8?B?Sjl0R0plbGYxZlZpd2RLaEREOGZsYS9FS3crZUNvSTlTQVdtTnNDRitRZzVo?=
 =?utf-8?B?OVRsQUEyaDFiTk11SXhUZHlHanNiOEhYSlBOcXV3SHZhOEdwdTdKMmJjWVUv?=
 =?utf-8?B?N2FKdDNFNmtJZjdaWWozZXkza0JDd0pZOU5za3l2a3JaTjBMRVJVeE9xOVBG?=
 =?utf-8?B?QnVyU3YvNGVzanNwRGhBOWY5M3NUb3YvRU16aEFYaTh4VlUzMGxsRlpsVjFx?=
 =?utf-8?B?WkVvQUZIRU5xZndMOGJRSVZRMlFsZ1JLUnRNUkZFaDZObEppK1JCSVRGaUdO?=
 =?utf-8?B?QWtRVFBNeEtvTmpiQUZFZ2pWdVcrMlkwUGRYMGNKMGNsdVllcGJ4UjQxQlZj?=
 =?utf-8?B?d25CSlFyTkszMmFlVkVXeG80UnprK0pSNTF3eVRnTHpkVjdmak1rbFZNdVJa?=
 =?utf-8?B?VUR4OGNxc0FQOHN5dkVFSmNvNDkveC9CZ2JHU01FbmV4MUZsVTRmZU9KeTdU?=
 =?utf-8?B?d1RNSHExTWNZWjA5RDlsZGtjY3h6Tzk0TmYyOUl1Q2tQMnk2ckN5Lzg3Rzhp?=
 =?utf-8?B?ZXVCVGtVendQaUJPcmM1OE41OEpxeVFhTGdpWUdXVDI1aUZhNVUzZnZVTkVM?=
 =?utf-8?B?ZmxTaGt1MFR5Z0ZtSDQ1QjhLUG9jL0ZRVFFEdEltR24vQzJJWno5bFo4akJv?=
 =?utf-8?B?eGZKcVM3MkNUaUgxZVpRY3dRSytwalJPcG93ckF4MVNVOXVuL2ZBaDZZRzFV?=
 =?utf-8?B?WWswU2hiOStmTDVmb2NHeE9wSE5jd1Yxc0VIMG0yRGcxeVlUSGpQMzV4eWw1?=
 =?utf-8?B?OG04MzQxZ2ViSzVsUkQ0V3lmWHBPUmxJbjJUemJNeXdlcmdXUTF2N2d3NEZZ?=
 =?utf-8?B?aDZVZVJIdy9HcG9KQkNZM2pjL0drTUIyTG8xdSszL1ExOXZEL3hzaSt5c1VE?=
 =?utf-8?B?TzlRd1BXTnFia2F4WlhWclB5UGdCbnAyV01oUHhpbFhSOUpxUVZCczNZemx3?=
 =?utf-8?B?SkFvZms4SnYwQzI4YWk4N0ZZSjlkZWU0Qm9OVklnR3M3aTBIN3lKbXRWbVBv?=
 =?utf-8?B?Y2FwZ25FbnNGMEFnaDlxbm9jTkh6THVzOUY1VTFBeVVDK1dTRU5nTmR3aks1?=
 =?utf-8?B?T09LK1FuNXY0Ri9KMjFheEwyUkE0bDZwMEF1UWNLT3NiMjdMclBxTkl3OHA0?=
 =?utf-8?B?R0lYdSt2U2t3KzRBOFhwSk9DR09DU1NzL0t1ZHFqNXdodVZvbzV1RlVzU01F?=
 =?utf-8?B?SFdIU1hORlJ2Rzd4dmYvcUtEMGRnM2I0aVRMZVcreDV4bEVWOWJIZzhabHgz?=
 =?utf-8?B?US9pNGh1emxoSHlYRHIwS1Z4dVNFcUI5dUhWMWx2VjVPcVNPeXVGdk5kK2VE?=
 =?utf-8?B?azY4NzBIS3ZiOGV2dUZuRlZmZ1VrWXp0djZXWHpBUmJ1NzlieDloSStXd0lF?=
 =?utf-8?Q?jQqiiyLs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ee446a-c6af-4c4d-8310-08d8c70161f0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 22:33:22.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZHsu/Jp8dKYw+0YZBU67bq0Mi70SJvBrb6aIC1QoUlB1pkg32k1vJyS2sKTrrCs2O3jutoojfaYSLiatD0qAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1853
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010122
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010122
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 2:48 PM, Axel Rasmussen wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
> userfaultfd-wp is always based on pgtable entries, so they cannot be shared.
> 
> Walk the hugetlb range and unshare all such mappings if there is, right before
> UFFDIO_REGISTER will succeed and return to userspace.
> 
> This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
> is completely disabled for userfaultfd-wp registered range.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c             | 45 ++++++++++++++++++++++++++++++++++++
>  include/linux/mmu_notifier.h |  1 +
>  2 files changed, 46 insertions(+)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 894cc28142e7..2c6706ac2504 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -15,6 +15,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/mm.h>
> +#include <linux/mmu_notifier.h>
>  #include <linux/poll.h>
>  #include <linux/slab.h>
>  #include <linux/seq_file.h>
> @@ -1190,6 +1191,47 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
>  	}
>  }
>  
> +/*
> + * This function will unconditionally remove all the shared pmd pgtable entries
> + * within the specific vma for a hugetlbfs memory range.
> + */
> +static void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_HUGETLB_PAGE
> +	struct hstate *h = hstate_vma(vma);
> +	unsigned long sz = huge_page_size(h);
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct mmu_notifier_range range;
> +	unsigned long address;
> +	spinlock_t *ptl;
> +	pte_t *ptep;
> +

Perhaps we should add a quick to see if vma is sharable.  Might be as
simple as !(vma->vm_flags & VM_MAYSHARE).  I see a comment/question in
a later patch about only doing minor fault processing on shared mappings.

Code below looks fine, but it would be a wast to do all that for a vma
that could not be shared.

-- 
Mike Kravetz

> +	/*
> +	 * No need to call adjust_range_if_pmd_sharing_possible(), because
> +	 * we're going to operate on the whole vma
> +	 */
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_HUGETLB_UNSHARE,
> +				0, vma, mm, vma->vm_start, vma->vm_end);
> +	mmu_notifier_invalidate_range_start(&range);
> +	i_mmap_lock_write(vma->vm_file->f_mapping);
> +	for (address = vma->vm_start; address < vma->vm_end; address += sz) {
> +		ptep = huge_pte_offset(mm, address, sz);
> +		if (!ptep)
> +			continue;
> +		ptl = huge_pte_lock(h, mm, ptep);
> +		huge_pmd_unshare(mm, vma, &address, ptep);
> +		spin_unlock(ptl);
> +	}
> +	flush_hugetlb_tlb_range(vma, vma->vm_start, vma->vm_end);
> +	i_mmap_unlock_write(vma->vm_file->f_mapping);
> +	/*
> +	 * No need to call mmu_notifier_invalidate_range(), see
> +	 * Documentation/vm/mmu_notifier.rst.
> +	 */
> +	mmu_notifier_invalidate_range_end(&range);
> +#endif
> +}
> +
>  static void __wake_userfault(struct userfaultfd_ctx *ctx,
>  			     struct userfaultfd_wake_range *range)
>  {
> @@ -1448,6 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		vma->vm_flags = new_flags;
>  		vma->vm_userfaultfd_ctx.ctx = ctx;
>  
> +		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> +			hugetlb_unshare_all_pmds(vma);
> +
>  	skip:
>  		prev = vma;
>  		start = vma->vm_end;
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index b8200782dede..ff50c8528113 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -51,6 +51,7 @@ enum mmu_notifier_event {
>  	MMU_NOTIFY_SOFT_DIRTY,
>  	MMU_NOTIFY_RELEASE,
>  	MMU_NOTIFY_MIGRATE,
> +	MMU_NOTIFY_HUGETLB_UNSHARE,
>  };
>  
>  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> 
