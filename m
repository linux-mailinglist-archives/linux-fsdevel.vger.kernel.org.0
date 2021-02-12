Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B31631A469
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 19:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhBLSRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 13:17:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33118 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhBLSRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:17:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CI9ic1151939;
        Fri, 12 Feb 2021 18:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=96Ql415IzbtTe6TJ/R7bTHWxGanBk7PVqsjHn8buDRM=;
 b=DCj4eC5dkRTD6zRrNfyeGXiPEyusdQER+nc7EXkp0AnYwfUv2XzL4sh2CvMmkXWlAqN/
 oAjnrhm0BByEbRY5G1GFY8hIDs1vnIoJ6nx9d8UgPM8+kmprzxpKZt9nslxcLfPVy76v
 kG974DLGiP1zOR5Cmjxovo4oFHoHuNbJiZia438kSwsieLxjkvE/s7e3dePVaxMMMsKr
 CbkaoZudTNZv29pFDf/BUltY+wPey+iFfdbz+F7bTXS3AwVisxscVotdjR4HedgY18FF
 wDV9JflH8/PU3x90nASpaBtmENenf5fnFA/SX8Q4hlNkJH6rKxW9/WOqCRP0Itd6wzFK JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36m4uq2qas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 18:15:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CI9cfH098306;
        Fri, 12 Feb 2021 18:15:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3020.oracle.com with ESMTP id 36j515tb50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 18:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKNOXXPkE/58fqmKhiIMToJQLl9v+D3d1NojSDqOInKdq0Q5ipcPEy2h3lhywSTZKm+rbPQZOo0TNuRsqIihIiMStP4sxIRMOIvlRfWm7gVbP892WjVkjfP4fAnyZGzUvbw6vanBCvvnku89Tj/Dh2fJ47jm9KLdz4Wu7nFAPkCwpXJQrm2c4+Bu2RUD9dCW/iTldXFN9FU0d6V+M+rdd9S1FGxgVjQlHvuhtxnhEgS0O/Xm5iy2Ws6uUNspfqPgPhK1WJg6dyBVkuf+uAYDqDREjmnG+xdTbzzLQuwpirY1wAajWiO1wyb8cJaHz+7ySu9vQ1p1gQ0DZjjR2JibKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96Ql415IzbtTe6TJ/R7bTHWxGanBk7PVqsjHn8buDRM=;
 b=Hl+Q/0dB8iK7+Bxoq53JaHKUkMgK4lBkDR7xhM6Gv6S+VmG7cSFtGLmdcpTRXKkjO7Sqc3ZhHkB35m3/AkHbiADh7JKVDHwqfAHMLIcOPKKWiYooCTsZggmSgD//eiAE/dbgHV7c2NiWE5LsHk/ygfWajIc6bB1Pvpfq8BaGQrqYAgSinEkRaKRYwFOTCwcuT1I8Gq5F8kaMOKPnVlW9VIoZuguK0/8t3uzJBkwwnveL7261t26w4t6YqOPj2GiPnO2O1Vh6xm5oXqrQYIbH4qtEz96E7AgAoTvhr4KnfpgItiA7V/RAdobTI7MDXcaWcKM7apAz5Y4HUlIx8Tz+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96Ql415IzbtTe6TJ/R7bTHWxGanBk7PVqsjHn8buDRM=;
 b=nfj8/edQe0hOpGSXIAlEJLTp9TQxG+HKpGwvsBJ32kOCLecVG9laFxYE3JTVrBqvwFeYxD5mvliK+5cjoiFgcKFPX9FYuX2zmdBikJbIuJkRofIyLvpy1WGlfZGumQJU8IOoxOXfFHKIQR9NHSdKPaxFiUot0fmhM7FjEvcEaAE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2110.namprd10.prod.outlook.com (2603:10b6:301:35::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Fri, 12 Feb
 2021 18:11:44 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Fri, 12 Feb 2021
 18:11:42 +0000
Subject: Re: [PATCH v5 04/10] hugetlb/userfaultfd: Unshare all pmds for
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
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-5-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <517f3477-cb80-6dc9-bda0-b147dea68f95@oracle.com>
Date:   Fri, 12 Feb 2021 10:11:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210210212200.1097784-5-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.28 via Frontend Transport; Fri, 12 Feb 2021 18:11:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69842e21-c113-406d-c509-08d8cf81a62f
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2110:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21101918317D167736FF61E2E28B9@MWHPR1001MB2110.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HOwWza90DMWSM44yxLVQWl7ua97judoEl5pmRFhzfFHYjAVCEcW4u0QAvAknhmjjg4fNH/oPEaBE3gXTjMHKbHnYTDVWsV7HI8XGGwe+8zv3pMrOoAxUWy04JgRhuwGvcx5irrmlhR1zAVT9Cv/35ltFLpeuxP1dhFC5r92l86vX5kdO3V5JozyDCqhRO/Bkwc82XuwMa2G46xc4sIOO8i+36DoJvMKm+TlfCNBTv2JxhpivETuGobAsAWoRV/aW05rgW9ZvJpIz/d0MoITX6F1TkwjBDiKrpdFkHL0Jbe4YcqjqQTOmz12GLVvYQCydTahYjt2mkzvPwSOi1+6hWKC+/i68p4jUEYOoeuABKZZTHBKFf8Fp+jYUBEMUhHWLeJohVaXUNFwjeKdlVvz6OfNS+K7KjOh1eNpSbCygFXrgNKOxLiCEPkmmGQ4E3UGSmEusrCtFLiX+nY1xK1cfXw1NLQHAmHZSTCmEi3iExIVIyO5HnDVj0DE4OHQfzXcSrog8x1mzsuZpZPl60on2CodlbQ55alp6GSJdhQUpvraJ90VcW8EThb4fYwnf4K+Z5ITTiYjbwOdC2d1NXHQChBhXgqcqNsD8bjRe9szSixjag71KbkQGHGy+fI0ukyW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(478600001)(2906002)(66946007)(66476007)(66556008)(7406005)(7416002)(4326008)(36756003)(921005)(52116002)(110136005)(316002)(16576012)(54906003)(8936002)(6486002)(5660300002)(8676002)(31686004)(186003)(26005)(31696002)(16526019)(44832011)(86362001)(956004)(83380400001)(53546011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0FRL1JuSlFiaUhmRmJnOUE4S0p4cXM1N2VvdXdZRkVzOStLVXFSNmVkeTF3?=
 =?utf-8?B?Rno4bUNUN0tSVUlJdkNYMGZPOWZhcXdUZnprc204UVdCdVF2STZWcjlMT3Ns?=
 =?utf-8?B?dU5oQUlOMTQ3Q1pNTVpjaHJCOU1UeXhJN2IvMk9pbng2R21selp6ZnF2c1FY?=
 =?utf-8?B?OFZqQzdIem02UlVoV05qWTIzWGpYelpSNDR2VmdON1F4MjhYMWJEUE5DUGpp?=
 =?utf-8?B?MklpRzNYZWh3Q2ZMZS91bDFGbUlCbkt3Y1puTDJick14Ym1ybFNNMWRvMzk4?=
 =?utf-8?B?S2pqRjlrb0dKU2hKMTlmMkZpcFZaVk05TXBMd1UrbithcnU4ZHRFWi9NUER1?=
 =?utf-8?B?RWk5VEcxbFU5QU9NalFLKzQ4am5UNTlMYzQ3L1YzWnI5RStFSFk2bVdZSDFz?=
 =?utf-8?B?cndQcGdtRS9pcUZBaHFrVzRxWFVDNmJuczV4bmFUSDRjL3RXZVNHTkxJcGdl?=
 =?utf-8?B?bUQ1bTBSOUVFRE9NbWhtVGFiZGhCakJ6TGVCYjNEbU9BbHpuMjc4Z0piREVj?=
 =?utf-8?B?NmgwMkV3WkloTy9iUlEyMDNNSWtoNlA5RTkxUDRKVlA3ejd2VHhLOUJtSzlk?=
 =?utf-8?B?STZrd1NibklXVUhGWVlsSTZveFBmZEZlTm9Fb3FBMEhkd3p6NGwrTFZUcjNW?=
 =?utf-8?B?NW84cUhoQjFxRTcwWmg5ME1JeGxWT2VNaGRYOXgyZ0JJVjRZZk1pR0lXRXJW?=
 =?utf-8?B?b2J4S29oNWNzY2hJalVPSXZ0UjNEcSsrenNMemplUllqWGJtZTgvaHlpWnV6?=
 =?utf-8?B?eTRIc1ZRRDVwOU1MTHJaWkFuVkF6eVFLb1pZTUh0NEhsUi93aUF2VEt0WWxM?=
 =?utf-8?B?dmlIbmQrcDlvYUJ5Z1VDU1pFS1NVVDZpbDRsK1JJY284ZlhNc0lhUkZZV2Fs?=
 =?utf-8?B?eXdEMTJEYnVLTVRyNFVyRkx5aHRISzFVWUtJbjJaeDI5UjAzZkF0eTgwRnJo?=
 =?utf-8?B?NkRubGFpczQyTVErUmdsalFIUEJqb2tRQXM2MjlMSnJ4U0Z6cjFCRUlEQlBU?=
 =?utf-8?B?Mlc1R1pNVFFJekRPV3VRT2lzaGNWVW45d2YvdXJsMmFhd3pOdC9UQVU0MzY3?=
 =?utf-8?B?Zmp4VGhaRlVzNXlvUk9LcW1uZncxOHBMbllmd09mU3B5NWI4VjBrMkR6VFdL?=
 =?utf-8?B?UnhHT3dyR0NDNFZza3dWQTg1Q1VhclNwSU5aNzBSOVVPMWw1T040YlNaZE1I?=
 =?utf-8?B?UFdxSFdubHpMQVQvZ0NlVVZLNlVJL0dVNnBKZkExaTRFeTZKenJweHVVbW9J?=
 =?utf-8?B?ZnZFZis5OVBHYUlVWTBkNXRDSEtQSmZ6dFhKcEszeEU1aUJZQmN1bVIrN1Bn?=
 =?utf-8?B?MlVhN1kxVENpVDk2cTlQUXRLVUpFQUdXRmlLSUFjSlMyOEdvN3RQYm9OVkZs?=
 =?utf-8?B?Q2laN09yZXcya29wM2RGK0hwem9SVHZud1BxL3AxUUhXZnNuK0M0Ry9saEFx?=
 =?utf-8?B?TTlqNm5IejlCbnlSNkZiUHYzYkg4Rm90N3RYK2g0WjJaR21VVjRmL3d3V0tn?=
 =?utf-8?B?U2VZN0tweUFmNlZ0M2gwSFRQL2hNNEFraGZJbjlnMWV0eCtMdHlZTE00Wmpx?=
 =?utf-8?B?WVRvbStFZmlhL0xrVk10N21iaE01L3lzMTRYMEwvcW9NbjFjT0pqaUpMcVZo?=
 =?utf-8?B?aG52UXFjQlZkVE1BRE9BRnIzTGp1NG5CcElKMGUrSXh3VHNJVDBUY0ZoR1J0?=
 =?utf-8?B?djZMbmpjejV0ZlNyTHlnZFdTNUVnNElKN0kvMXRpWVN3NWhIK2hNSi92OXlS?=
 =?utf-8?Q?GR8Lf1ffUUetkUrhawbxDKvrbw3tl2wLKwJ3q7D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69842e21-c113-406d-c509-08d8cf81a62f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 18:11:42.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdFcBdsnml7TEqhfObDWmuKJ1JJQgHD5WOyxjo8CSVPwdUw9mgNP+CtNr30/BPp11dRH8yrbhbiZ0nHzHNf1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2110
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120134
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/21 1:21 PM, Axel Rasmussen wrote:
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
>  fs/userfaultfd.c             | 48 ++++++++++++++++++++++++++++++++++++
>  include/linux/mmu_notifier.h |  1 +
>  2 files changed, 49 insertions(+)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 0be8cdd4425a..1f4a34b1a1e7 100644
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
> @@ -1191,6 +1192,50 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
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
> +	if (!(vma->vm_flags & VM_MAYSHARE))
> +		return;
> +
> +	/*
> +	 * No need to call adjust_range_if_pmd_sharing_possible(), because
> +	 * we're going to operate on the whole vma
> +	 */

This code will certainly work as intended.  However, I wonder if we should
try to optimize and only flush and call huge_pmd_unshare for addresses where
sharing is possible.  Consider this worst case example:

vm_start = 8G + 2M
vm_end   = 11G - 2M
The vma is 'almost' 3G in size, yet only the range 9G to 10G is possibly
shared.  This routine will potentially call lock/unlock ptl and call
huge_pmd_share for every huge page in the range.  Ideally, we should only
make one call to huge_pmd_share with address 9G.  If the unshare is
successful or not, we are done.  The subtle manipulation of &address in
huge_pmd_unshare will result in only one call if the unshare is successful,
but if unsuccessful we will unnecessarily call huge_pmd_unshare for each
address in the range.

Maybe we start by rounding up vm_start by PUD_SIZE and rounding down
vm_end by PUD_SIZE.  

> +	mmu_notifier_range_init(&range, MMU_NOTIFY_HUGETLB_UNSHARE,
> +				0, vma, mm, vma->vm_start, vma->vm_end);
> +	mmu_notifier_invalidate_range_start(&range);
> +	i_mmap_lock_write(vma->vm_file->f_mapping);
> +	for (address = vma->vm_start; address < vma->vm_end; address += sz) {

Then, change the loop increment to PUD_SIZE.  And, also ignore the &address
manipulation done by huge_pmd_unshare.

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
> @@ -1449,6 +1494,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
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

I don't claim to know much about mmu notifiers.  Currently, we use other
event notifiers such as MMU_NOTIFY_CLEAR.  I guess we do 'clear' page table
entries if we unshare.  More than happy to have a MMU_NOTIFY_HUGETLB_UNSHARE
event, but will consumers of the notifications know what this new event type
means?  And, if we introduce this should we use this other places where
huge_pmd_unshare is called?
--
Mike Kravetz

>  };
>  
>  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> 
