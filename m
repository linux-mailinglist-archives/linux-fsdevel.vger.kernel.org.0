Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFFD30B235
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 22:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBAVku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 16:40:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52294 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhBAVkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:40:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111LSrMB058325;
        Mon, 1 Feb 2021 21:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BYJH3yErQzu6RBUEzYxulVa8HYM3RsZMqyeSQ/fpJL4=;
 b=s/afVB/NwCFuAY2oeLiRGrxD86oarXPsUZympB7MSVl4TLVPcQbVdvyoHXpaoWDOTa3j
 7lpQ+igUohyhEDJ+1ymgAO/YLooHQNEwQkGe4UYfoVNtUuwA8VVstuLY9yGabzwgvc81
 FGhcSWaf1mzbnofO/o+7nZuRm/lwNXEaNBBKYG3mjrweobYADXD8OtqFsYExgJwE+MTs
 HNh5EHo9xMfjjVtIrbEFCMBdflaGLr9v+vvDLAWjxkMf6CHo/ykVGlSa1T3UDywoBpqA
 GeLGTmvULlAr/V53LjN/amvzbSy9dZElf8HyrvTP9ON91xO4y5p3yiu+f64k7KG61jnI vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36cydkqq4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 21:38:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111LUUfF039923;
        Mon, 1 Feb 2021 21:38:56 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by userp3030.oracle.com with ESMTP id 36dhcvm1h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 21:38:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjudZAHWy/YNVoJy5zGqdR54pWag5N/2BPvP//dGZFEMl3hQP6BD33BfsRqW4JfjM15KP+ZXnIjhck6AzDopeO8Neeujklxz5VEUN8rWDrZJJnjpqs/FTopJzq4g8Qr/rrb81c/ErJYz//2gkBladXKsl7WujNd44v80BpVd5ajCjokqDW5qYbl4iv4cGnhRhfikgB9KpaNK2ltJafpDTyxeCp5GeVhX89PzMl+sZHQ4VgAvy8D9rnwcyzJF+Y1ptP/GgYUJBpNk0Mri99hxTHDF/wYST39DLyDaLoVtcXY4hOGY7hGd4zSqJ9HfXdGy0HLtu3DM6Z8VI6mEw1W/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYJH3yErQzu6RBUEzYxulVa8HYM3RsZMqyeSQ/fpJL4=;
 b=T77gWqob1UOPHZxwlcL/07zynb6if0hJpWm4E7ZN5+cXI76ayCzEoGiFHdJXHp6/sukjzeI94RVuoTWDsQWf2sYJctlOTJfHh3BlU7BvwX569pfro8cuXURrHJzF9UAqcqWxDKnHK0/BRzzitYeS/T0woirZ1KFv7KgR37CN0woTeUfffID9PRN9zzsCAc0LCZAFh7aAoVow+eDZawjuHaaBVbZdJ2TgUnHz4Pb9AFA4uL0gmRhOZaf9TfniiKd0eGjFICNfPMD+sFV6D3BLWIUnt6NMhn8LG4D3Mu8a93Cn6rF9TJhsGArprLV6Jy9TrrfnFe9C7yzVxUQsWqDQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYJH3yErQzu6RBUEzYxulVa8HYM3RsZMqyeSQ/fpJL4=;
 b=XkH40Sfly0WIEJ5OGi10zM1ZpMBFcLsrz/K4fMAmAETvRTfdRgj2DiOl2zIrEUm2gl34bOUWTxTD5TDE9sEarFRxr23i+Gv7F42R33KSwIBScEhoiYbZ6fFkHR2SDfLH5bjZZnpYPV1qviaGY3pgUM1bmX/V37GAh8lhQZjA3Oo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1936.namprd10.prod.outlook.com (2603:10b6:300:10c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Mon, 1 Feb
 2021 21:38:53 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 21:38:53 +0000
Subject: Re: [PATCH v4 1/9] hugetlb: Pass vma into huge_pte_alloc()
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
References: <20210128224819.2651899-2-axelrasmussen@google.com>
 <20210128234242.2677079-1-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <67fc15f3-3182-206b-451b-1622f6657092@oracle.com>
Date:   Mon, 1 Feb 2021 13:38:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210128234242.2677079-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:303:86::8) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0183.namprd04.prod.outlook.com (2603:10b6:303:86::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 21:38:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8d830ec-4899-4711-70cc-08d8c6f9c554
X-MS-TrafficTypeDiagnostic: MWHPR10MB1936:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1936EB710D21ECDD69816E3DE2B69@MWHPR10MB1936.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ko2tm75dktaKTvQfLOHihwyDcTDYwnf5rWPFc9BrrcpVlRAhh0eEtvP0XtHLQ8NRpZ5qnYyFat43vab9Y1O+yqRYYskCroW/V7/GZP2KCkJugEx3XVKBI0Izd2hrwSFWh0pGRvvQMQ+uoSVaso6i5svCdgzttx1LPU1GwGbKzAcdEU+qgDXwsztBhG9dbTJJlS8t6vKMVUfzdLyJ2rbbl3HOifllfDZJDQPUXmPxeos4Mai6CuBy2Vb6yDGwRG6aa+Y4nmPdnF7ppYqD/nIs4eefIb1z6a5x8dm4b9UPHhnSJ7OFv7w7S8p9Ks9LagqAA3oE8zkguVGDq5qxyxT7XbjzwPYasvJArUWAr8E7bGSgkTRifvF9tJHseoezHQ1jowQ98wiPA1hhSKMWVMSDjZD4t3eYsquneo/A2f7Z/NTxFgSuY4cZKXEQPyiAIa9fQNjnY8/T3zJP8fykJyz3/fadtwBvL3gk9h2tNx5/y0EAGXm3YMlrZeJUpe1xPYpOrLIfC5nVMjOKU3oNhLVJG190vbwR18axJlFzasg3+dsF1LhwJDPaNp98ahWRKA841LZuN6BnNyU/HJCudNbmqaw2GetrnAR0cQ63gePEZI/+ypj7ox7Sy1/UTFNYbDpYKiiRgjjrBSBpJ63l3kt+xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(366004)(39860400002)(36756003)(5660300002)(7406005)(478600001)(921005)(7416002)(956004)(83380400001)(186003)(2906002)(16526019)(44832011)(66556008)(26005)(2616005)(6486002)(66946007)(66476007)(8676002)(52116002)(53546011)(316002)(8936002)(16576012)(31686004)(4326008)(31696002)(86362001)(110136005)(54906003)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDVRcmNhREhDemdER2ZIbTNUUzVCWkFiQk94eXNIYWhLNEFuWWwvWkFRY2lm?=
 =?utf-8?B?dW5Hc3NOeFJRSTV2VlhxeCtyQ0JSY0hZL3A4eGEwZHI3NzIrTk5HN0Jqc2gr?=
 =?utf-8?B?ZmJURHNOV0JBTkhhc3ZlZ1ZqVzBOaVR1K0k5N0dYK1RqeHZDWnB3SHAzSXI5?=
 =?utf-8?B?TnZwL1hmMjFsaDByY21PaU4yLytSNENTdTRxR1doRDNCbjlSdFREeWNtSms1?=
 =?utf-8?B?dGV6YzV2cmNpTHdUT0N1a3MxTUp3Znp0dzhTL2VLWVNNOTZzb3dUaXU1YWFl?=
 =?utf-8?B?SG12QWlxVzd5Y1lBOEhXbXhaR2g4RWdRU2E4M0FPMEVxc3Z6OTlRSFkvWktU?=
 =?utf-8?B?d2krWkRBZGZSSWhKbkpuM1FiYUFBWTUwQlhPMldzaXJRd0ZldjNKQy9STks4?=
 =?utf-8?B?MkNab0luUVM4TXc3Z1N4YmcvRVh2c0RLcE5MYWVibUVIVUlrZzJuRnF3bjcw?=
 =?utf-8?B?UFc5L1dmNGN6RXZPdWt6M0wyUE00UldsUHYvV1B5UWxlRTQrZkRBWXpzcGs4?=
 =?utf-8?B?dUJncHV3a01Gd1BneU9XK3ovV3p3enkxVTNVWEIzUDZKYk9lbDhoYlNTMS9X?=
 =?utf-8?B?U25KK203SmRQdzVSRGZmZkV0Y0x4bXRVS0w3dVdxN3h2Y2VxWUd6Mng3dFlC?=
 =?utf-8?B?RlNQd1RyaThCalhFd3R5N243N2FGdGt3dC8yUDBMYlBjZmtJVDdKeWdKS25l?=
 =?utf-8?B?dXdLc1QycXg2NHo3L090WEptRU9hb25ySFkvUXJlVEdPZ3ZJODlPTnJxUHBK?=
 =?utf-8?B?b2RjeE5tMEdiMU5hRXZvbm1DZzZyOU9CME1oQkNuZFdGYzY4bTNHWS9RdVdS?=
 =?utf-8?B?THo0OTNDRTIzQzBmc0RvTmNsaDNNajFXQkFPbGdQSzd3MDdrQ1dNQmg0M1p5?=
 =?utf-8?B?VXF3Q2duaHpka2R5T3JwbnIwSU8xUnhISWZjVGg4T3VJd0JPU1ljUG8rTVl0?=
 =?utf-8?B?TDNJQndIdC9Gd3lnMER1bmtNcG1Tby9uaTA2UnE3bUhWd3RmUVd4Nk1lbWRw?=
 =?utf-8?B?NmE1VVlZQnVPWVdPUm1rbTgxQWNhWTh3YWxwMjlQckVYdWMxQ2gwb1JNdUQv?=
 =?utf-8?B?RVViSXgvVEdEZzhzU0Y3eExXckJEazlCUFNjdGRhNkxieElKT3hKVFZjamp0?=
 =?utf-8?B?UlZ5VyszMmt1RGUxaGtEbTVxRlhBWGcvaStHcmEyOTl2MVRXVHFwaUo3KzR6?=
 =?utf-8?B?NVBFd3VFMEdnRkxWblkwelhBWWt1Si9IME1lUjNQeEdoTHBIMWMraFdkbEdm?=
 =?utf-8?B?M0N4c3pZNzF3NjBYU2hWVFhtclBpWXFUQVdBY3MrWkhrSzI2N1IyNkx1cVRu?=
 =?utf-8?B?MFhlL1NpRmxmRERqSy94bUo2dVZwSEZyZEZPb29iNWpsTzFNQlJDWVgrV3Br?=
 =?utf-8?B?a2NzbzJwVGNzTVZlMnJvM2pPWm42TCtlYkF4Y29kbFcxdEdUdi9CdGdnalJt?=
 =?utf-8?Q?VoNEdUfE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d830ec-4899-4711-70cc-08d8c6f9c554
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 21:38:53.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91kzFYfwZvvu1l4/0SuE8XmfoURUy9pz1KYR7yVuDQ/xWikcL4BYKWZxtdnPtQLk5GvMhS0mGMjMAMJRgKsbGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1936
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010117
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 3:42 PM, Axel Rasmussen wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> It is a preparation work to be able to behave differently in the per
> architecture huge_pte_alloc() according to different VMA attributes.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [axelrasmussen@google.com: fixed typo in arch/mips/mm/hugetlbpage.c]
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  arch/arm64/mm/hugetlbpage.c   | 2 +-
>  arch/ia64/mm/hugetlbpage.c    | 3 ++-
>  arch/mips/mm/hugetlbpage.c    | 4 ++--
>  arch/parisc/mm/hugetlbpage.c  | 2 +-
>  arch/powerpc/mm/hugetlbpage.c | 3 ++-
>  arch/s390/mm/hugetlbpage.c    | 2 +-
>  arch/sh/mm/hugetlbpage.c      | 2 +-
>  arch/sparc/mm/hugetlbpage.c   | 2 +-
>  include/linux/hugetlb.h       | 2 +-
>  mm/hugetlb.c                  | 6 +++---
>  mm/userfaultfd.c              | 2 +-
>  11 files changed, 16 insertions(+), 14 deletions(-)

Sorry for the delay in reviewing.

huge_pmd_share() will do a find_vma() to get the vma.  So, it would be
'possible' to not add an extra argument to huge_pmd_alloc() and simply
do the uffd_disable_huge_pmd_share() check inside vma_shareable.  This
would reduce the amount of modified code, but would not be as efficient.
I prefer passing the vma argument as is done here.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
