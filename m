Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6950F319769
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 01:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBLAWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 19:22:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57218 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhBLAVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:21:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C0EnFc129046;
        Fri, 12 Feb 2021 00:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dQGo2bqWFl9ye6NnLJssNIOUH65r1NDac8AhZFXaDl4=;
 b=lFz9EbN6eVC1x1rSm4RFohNyh766eKl6Z5LFdwlMYpkqHA1aB66mKF6GadKXCKSTc2SO
 CwtLxf00tDXf2zqlIERuchp8LU26OJE9MOvSX6aCQdrTHSv2O/6IzNzQ+vFyI41H/U/e
 lRPoN2teeCb0P8E480UsW7w6MUD/8opf9eoBpet2GU3qBmprclCYIpkynbqxAJ9DqxCT
 R4CNu50OYEtM72kBb4PPNHEQcS+jaOo/JPRw67p47PgXJn2+VlPuOwH48rIWA8BwRHw6
 yeYptQBhaRXO+LI7kw2qPKI+VNbh6rXyFjNojYrwsWD7DcR3Ep9aOD4besYm8w5Es9+M aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36mv9dur3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 00:20:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C0Env2094074;
        Fri, 12 Feb 2021 00:20:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 36j4vv00g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 00:20:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK8p1PfQ/4guWe1OvqrxET2K2QcWE4lUfv5pFe+Y8jjOPaUEX9P3QcH/eAtlagfwaboYT/cXrlzSgZI5CYhG+p9R8uRe2iJUZRRxOg2/9wfjwhs+B8IBAVq6i2ymdWJL3zzCMLpcjfS2Nw35k5chCqFH6FWyGZQB8Jn12iPo0NKWiZDXtTVTD7aRZVpVVRlyuGysbtJpI+aRYNsOBEd+pBw1TqFfn//TnjxssyFTdqk1Y706PHzNePXncq/JlGlVF11XpSW3o9iTOJN1EDZZS5zlXTJSDxCh/DPu41F+qjD2vaVHuEEuWJkekm9qMoCi4njU+qwJycLnEs6K0Iuq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQGo2bqWFl9ye6NnLJssNIOUH65r1NDac8AhZFXaDl4=;
 b=nAY7ztQO4BEWp7IyOqgE5iLslL5NZZZ+c1VZCxgByfjSJfST80rYzJgdIqfHX+PHIQpIEr9QPg7enyqjhLnr+2Ei6oMZruUDMoiiBVTCr7Nfb/OYTiq2QyzmRUnbG4LT/TJGZgZ4J9GDaPoM7rdvt3ZuYJls4okPuOA5Z8HCN0piKZhsn/KtrjdVxhAAkqW3fhdMWpMP4i2ZZnaDwr275XXjM+DWGiWxKC08mazMjVnIOOxt1+82stSIrgWdq/3GSAx7XZxEi6T0q8um3Ay3hBwczI915JAYeqFw6M9aWUMRvuE0Ucq/iVJ/Nu+8/8WfMPB+2z85nbM3qQeRe0uVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQGo2bqWFl9ye6NnLJssNIOUH65r1NDac8AhZFXaDl4=;
 b=pcbsStyfkxt59YDfPnw6ZO+kZDiAE47J2R18nEQtdQx/Z7Hq5x/iMbYHVFC2kCnsg+Eu7Ztr5JUNJ0E7nMmJzUdeXIHFcUBo1DTJnJMFWRZeRjUWu3DD48lAqgpO2sYOASza7gNayIJZnBdnK4a81txxm3lEhu0usR/Y9lJ5uwM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4482.namprd10.prod.outlook.com (2603:10b6:303:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 00:19:57 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Fri, 12 Feb 2021
 00:19:57 +0000
Subject: Re: [PATCH v5 02/10] hugetlb/userfaultfd: Forbid huge pmd sharing
 when uffd enabled
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
 <20210210212200.1097784-3-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0a991b83-18f8-cd76-46c0-4e0dcd5c87a7@oracle.com>
Date:   Thu, 11 Feb 2021 16:19:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210210212200.1097784-3-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:300:13d::26) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR20CA0016.namprd20.prod.outlook.com (2603:10b6:300:13d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 00:19:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc6ed5b-c8a7-45a5-2124-08d8ceebed6e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4482:
X-Microsoft-Antispam-PRVS: <CO1PR10MB44825383B5A4BB2520254B48E28B9@CO1PR10MB4482.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOJjrBLaHlf78EwCAQttsCYSLP1HrhKobRkydWWpSr3DLbgGO1V6NAAc790M0+lm4R7WSjhTDFje+EacdbfcWpng1hYkDcac/txNxQtrL2SwhF8yoAwONMguu9AXY39/zWxabhFhHXHey99KUKrv+SZlBlC0kSYCaQUbC7fO3iKtX8ecTVd6c9JCCYLBGRoE/C7XMIbGw2Q05jvdJWg0bWodAR553saGWPmMzsIYo+ZcHUJY5nOpc4rxNhxY3G4z0vc8HShKQLFnrThDuEOlbhbMj71tfQvX5tpLGAfWPSBQQzzlqyyxn1cLDDChlnHUPItKh7C7VxnY1lY6ywq2jwsK5man2DELAolUIKsVuUcA6I8ncqbKb15n+5Y8a776REXyixXUmVd6xxdzRSqRfpzJG2uVLyB0Ypllmo2ltJH9g1Ogt7qKBDMyGFXf0ZfjKq3lQqf6GHIrTJSW9mC71McG4aJyIduZi6uBxiBNU7ApG45R5nXimoalEUBXQCpw8clwtIldVuGNWBziIK6mzNGsbWQWANuqFlqCYLiDolQnCgSQIcy+FKbmJOELWhax67cbsgLrxxsRJBPHe0WleXOe1IU7eh1u+LtY5+UrGhYPW46PD28LEIzsTr/bx+kJmiCtra1K0hV1l1HS/PWGFS6o3dxzuezgmMricCoBVk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(5660300002)(26005)(478600001)(16526019)(16576012)(316002)(52116002)(86362001)(83380400001)(956004)(2616005)(6486002)(31696002)(8936002)(36756003)(66946007)(53546011)(7416002)(110136005)(44832011)(8676002)(2906002)(4326008)(186003)(921005)(7406005)(66476007)(54906003)(31686004)(66556008)(14583001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MWQzaWt0SmFZSkdScVdTTGkxdm82SlBlMEhZMGplU3lCc3cxOFVrc3JldXFt?=
 =?utf-8?B?TjN3SXBZRDRrZnFFRnlVVnJrdHFyMk1WZVdQWTJzMGlzZHYxZWlhOVJnUkdT?=
 =?utf-8?B?aEMxRmNhT0ZCU0M2VmhrRnlVNjAvNUFTbXdzeGdmT2tGQVlXL21SR3BZYlZH?=
 =?utf-8?B?bFpSemJ3eUhOcmw3MDJzWUtvYXFkWEg3V2xUME5BMnhnakM0OUs1VVFhME5l?=
 =?utf-8?B?bTFOTldKWExrNERyeldMaXd0RDl6M0ZGaVFPcmdqaStoYVFEZzExSWs0RmdL?=
 =?utf-8?B?dVREZDJRbkVDazhudTB2ZHN4T1VaVTkwaUdYYkIzbEJXOE04Y24wYitNWnMy?=
 =?utf-8?B?YU13MERWSkJLZUp2RDYrSElrWE5XL1Via2hONk1FSG5wMExjK3JwSkd4TG9M?=
 =?utf-8?B?ZGN5U2hIZEtQa0RGNUdBYmNjVEg3QUxUMk1IN1MzTEgvNHBlS2gvNGlUZ25o?=
 =?utf-8?B?b2d6eGdsd3hhK1RTTkZCUGZ3b1JyRUxLcTljUlIybUk4N3FaYUxPNTR4RXd6?=
 =?utf-8?B?YTZ5T0ZRL3RQQytKTmk3R3RGNUE2Q2FmaUsyckloWVpIVG1ESXBlM2NMQmNw?=
 =?utf-8?B?ZG5MbDZoODJ0RHk1ZzN3TmVXQ3Z2TTRzUG1DSE1HSktVUnUxTkxrQXM4ZXB0?=
 =?utf-8?B?MEZHTmNDNUQwRDE3MjRFUHA0ejRYYk5ibFBoYTVUdEtRNEtsSjlrTXQyUC9K?=
 =?utf-8?B?UVExVHlmd215R28wRDVFbHpubVJyMnV2QWtiQ2VSZUNrRXpWRnVWRmJVSkxP?=
 =?utf-8?B?YmIzeE5Hdk5TNDZSSElvNTJXUEN1cUZ3RURFYzcrTy9YaENBZ21vYXBxYmY5?=
 =?utf-8?B?S2FIR0U4djZ1dDhtUk9FVk9CUVY5bURqQmVyakZwSkZQWVAzN092NU12Qk8w?=
 =?utf-8?B?NHQwSTJTbnVMT2ZMTnYwdEhCQTl0dFE1a0tnOWdac3NsaHdBSFUyTkViQy9E?=
 =?utf-8?B?NkFybnNhS3BJTGFnMlpiQ2tKTjFKQUltRWlYdStLZkRJRGxQWWI1T21VTVgy?=
 =?utf-8?B?M0s4MDdsVlVjVE9pNTlNK21weTdKRjhoMlFMTTBJcGNTSDNFQ2ZTUkxETldY?=
 =?utf-8?B?QlZhU21uWkk5SCtIQ1B2ZFMreGNheTd0bnNJV2xjbHZqMVp6NklVR2VxNWVN?=
 =?utf-8?B?TnJ5TjQxQ2FrK200cDJRbnZwTExJMXN3TWJ2YUNMODNzVVFNOGZFL0V2R3Yr?=
 =?utf-8?B?UkhmYlJocXpjOW50QUFZcGZPOHFFWmphZzBzblJkMTFUVjAxL3ZDdHJSRnNK?=
 =?utf-8?B?UlB0OS83Y0tSZm5EaWFFTitVN05Zb2FyWDh0UnQvUnErSmsyZmlseDk3RmFG?=
 =?utf-8?B?US9NaC9GdklTZVU5cVdXTTNGZGJvempWQXBXb1BIRW9lV0YwYUtZZldmcEVp?=
 =?utf-8?B?MnlQVVcyd29aV1hrd2QyMzVySmxkUUlIQ2xZeGRocXNpRGt3ZkZkTWo1OUFP?=
 =?utf-8?B?dmh5N1FxbkZVUkFiQWJ3cnNHdythdTRXOXdQZit2T2hyaktHZmQrK0cvMEFV?=
 =?utf-8?B?NndBa1RDeDdmMm1jYmpBRkZBM3A5Rzk4TlcydElFd08yZ2VtdEszOWVVTDBo?=
 =?utf-8?B?Y1NRNk1RVEk2UlZhSGlvTkFxYm9mOERZWlpGWkV0Uyt3WEFkTjRxMXRsTElZ?=
 =?utf-8?B?a3ZFTWNUVVpLWUFyL0svMnlaNnpBU0Q5RGcyMHZxTjJwY09CQWMwOUNCWFpy?=
 =?utf-8?B?MitlN1hDTzNqTzljRFlqUEVmZDZ4ZXBsM2F1ZVFXNWsrZjZkejhVNUNIZnhP?=
 =?utf-8?Q?ueggnYP8/JC8UAoLTuCLNW3MUNU9ND4V6ybZ5Ps?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc6ed5b-c8a7-45a5-2124-08d8ceebed6e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 00:19:57.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGQShNYS1Z0+8tVGPgrlcyYHbWJxVdjNU6LJo/ancTYlB8FvYjic1/ioQjTlfUCcQpmH7T8xjV/hDW6Ao/Ve6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4482
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120000
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/21 1:21 PM, Axel Rasmussen wrote:
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
> Since at it, move vma_shareable() from huge_pmd_share() into want_pmd_share().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  arch/arm64/mm/hugetlbpage.c   |  3 +--
>  include/linux/hugetlb.h       |  2 ++
>  include/linux/userfaultfd_k.h |  9 +++++++++
>  mm/hugetlb.c                  | 20 ++++++++++++++------
>  4 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 6e3bcffe2837..58987a98e179 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -284,8 +284,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 */
>  		ptep = pte_alloc_map(mm, pmdp, addr);
>  	} else if (sz == PMD_SIZE) {
> -		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
> -		    pud_none(READ_ONCE(*pudp)))
> +		if (want_pmd_share(vma, addr) && pud_none(READ_ONCE(*pudp)))
>  			ptep = huge_pmd_share(mm, vma, addr, pudp);
>  		else
>  			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ca6e5ba56f73..d971e7efd17d 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1030,4 +1030,6 @@ static inline __init void hugetlb_cma_check(void)
>  }
>  #endif
>  
> +bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
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
> index 32d4d2e277ad..5710286e1984 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5245,6 +5245,18 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  	return false;
>  }
>  
> +bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
> +{
> +#ifndef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> +	return false;
> +#endif
> +#ifdef CONFIG_USERFAULTFD
> +	if (uffd_disable_huge_pmd_share(vma))
> +		return false;
> +#endif
> +	return vma_shareable(vma, addr);
> +}
> +

This code certainly does the right thing, however I wonder if it should
be structured a little differently.

want_pmd_share() is currently just a check for CONFIG_ARCH_WANT_HUGE_PMD_SHARE.
How about leaving that mostly as is, and adding the new vma checks to
vma_shareable().  vma_shareable() would then be something like:

	if (!(vma->vm_flags & VM_MAYSHARE))
		return false;
#ifdef CONFIG_USERFAULTFD
	if (uffd_disable_huge_pmd_share(vma)
		return false;
#endif
#ifdef /* XXX */
	/* add other checks for things like uffd wp and soft dirty here */
#endif /* XXX */

	if (range_in_vma(vma, base, end)
		return true;
	return false;

Of course, this would require we leave the call to vma_shareable() at the
beginning of huge_pmd_share.  It also means that we are always making a
function call into huge_pmd_share to determine if sharing is possible.
That is not any different than today.  If we do not want to make that extra
function call, then I would suggest putting all that code in want_pmd_share.
It just seems that all the vma checks for sharing should be in one place
if possible.
-- 
Mike Kravetz

>  /*
>   * Determine if start,end range within vma could be mapped by shared pmd.
>   * If yes, adjust start and end to cover range associated with possible
> @@ -5301,9 +5313,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	pte_t *pte;
>  	spinlock_t *ptl;
>  
> -	if (!vma_shareable(vma, addr))
> -		return (pte_t *)pmd_alloc(mm, pud, addr);
> -
>  	i_mmap_assert_locked(mapping);
>  	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
>  		if (svma == vma)
> @@ -5367,7 +5376,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  	*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
>  	return 1;
>  }
> -#define want_pmd_share()	(1)
> +
>  #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
>  		      unsigned long addr, pud_t *pud)
> @@ -5385,7 +5394,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end)
>  {
>  }
> -#define want_pmd_share()	(0)
>  #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
>  
>  #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
> @@ -5407,7 +5415,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			pte = (pte_t *)pud;
>  		} else {
>  			BUG_ON(sz != PMD_SIZE);
> -			if (want_pmd_share() && pud_none(*pud))
> +			if (want_pmd_share(vma, addr) && pud_none(*pud))
>  				pte = huge_pmd_share(mm, vma, addr, pud);
>  			else
>  				pte = (pte_t *)pmd_alloc(mm, pud, addr);
> 
