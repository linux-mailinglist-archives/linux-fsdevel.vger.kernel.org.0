Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8882348122
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 20:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhCXTCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 15:02:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33886 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhCXTCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:02:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OIxU6K109787;
        Wed, 24 Mar 2021 19:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rLd+vJk2CVVjlRqpOKAyScmyCvTlis0ynx7lxN+jUKU=;
 b=c95z87z88+eg8LBjX3C1sK3R5Orl1fMfKRRnec+BK1JoRWEpBlcLu8sVl0hgsfLMK4pN
 WFh4nqIO5Fh3VWPePpu2KeAhwVN6Hbybo+dKF/qDZC6tgMVPVOfO4TTKnV9fE1GztXdu
 YgucHkkodiFuysIm2yvvHW7iqllOMiYWm4envveMbmQptXBUDX8/FH0DCxLIx/hATXS2
 zMDJD6K/RRkXEBDBpwMAp6VpiTW71gNgqzPK3WzFHni5A+rH/QebFMBsvjn9qdxX09BF
 vaLpXr8UKiE/VolbmcXmflRztfvvYERWIgV2us6JLcGyvCvewPE31Eppfumm6hrT/vgs gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37d90mkvy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 19:01:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OJ1D6D025560;
        Wed, 24 Mar 2021 19:01:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 37dtmr79ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 19:01:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie/yUXwlKqOps1Vv4j6eZPyJzUyr6oSUZGXlj4E91cyw/rXxs4R6oVtx/YiXRGY120P10ms3AB7szs2aJTFdArNzHeDAWAMOljgrw06ZPXbKid9W35HbbveyzXHxgEP4gZuHJiIgVWup+xrzQ12+IN7XM3AMbp8F3MiJObzPdDui1o0Ybw1mcwPPqXq5aqLqZvlMap30XP1EycGc/KsHxY9w1xKkxGd24aSNRVnfqoreTLt9dapIiYRHes1qbv7R8K2A3G2gc0L9lr/lF6v+ylGVd17Qz8Mh165lOrDH1J9EPz1aj/UuRwKn99I7C2vucyWz0hYlwlPHOChNJslz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLd+vJk2CVVjlRqpOKAyScmyCvTlis0ynx7lxN+jUKU=;
 b=laiGj1DtI9VSs4ZebKmFueVKoZa8pYiTO0qrTGvsQtZsHvgA87Ct20NiZRUV78Eb5hkeEO8wATQcVoZDnq59QQAok6DJx0FaMQAPWkKB5jt2miChgE0YY+ntbfHCU/qB6bysVkXVTSaO/IokAxke0QUEIJ/j11j5DeZcF5UR81dpHkW5mZOCjQ1y3aEWRNT1YSETLODvMkvZufof7peI/UbdkRXAF1UBoZZtinwnVmz8w7NUL+3yo/PmwSbA+qU3qAgtMzQz6hoc1IJAu0lkQFEDaMwAMHKC/tQPQ+cgn6DpXrJJJET+dy6kW+Lfze+ToAHZgHZ2sPbEF6msFmbtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLd+vJk2CVVjlRqpOKAyScmyCvTlis0ynx7lxN+jUKU=;
 b=FEPOt8iwcnZkc3TLvo2QOnIz7KvW1Qai+nI7K+u6zeYeoER75DMsupfZ3UPNNSIlMx8YBDmjIJinyZpmDy9pI75OWApH6wgOhY1PiUkZGSEE316zTxaI36CXZsf8pIN3Gw7Bp3nQmoQDK/rEEGD9b6SYCU0a8dbFKx86YrWL26I=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3256.namprd10.prod.outlook.com (2603:10b6:a03:152::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 19:01:07 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 19:01:07 +0000
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
 <CAPcyv4jidaz=33oWFMB_aBPtYDLe-AA_NP-k_pfGADVt=w5Vng@mail.gmail.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <1c87dc74-335e-c9e2-2ae8-1ec7e0cb44c4@oracle.com>
Date:   Wed, 24 Mar 2021 19:00:58 +0000
In-Reply-To: <CAPcyv4jidaz=33oWFMB_aBPtYDLe-AA_NP-k_pfGADVt=w5Vng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LNXP265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::15) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LNXP265CA0051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 19:01:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd34f7ff-cdca-4a1d-6069-08d8eef72e54
X-MS-TrafficTypeDiagnostic: BYAPR10MB3256:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3256EECD0C6B1FB31D91C516BB639@BYAPR10MB3256.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAsINLWZ4MAd51FEM180Wi+0MHKNjgpkDDQtn/ED0pVu8JdUUkqf7e87fL9oE9XJ8PsFhhOtBpVYnJ7D9wB0UyTH8vG8Twp1KDiBE2smkihZkAs+LuM/lP+ORu4VvB9CEScoV8wLqaP/c9xnj+wG8yoqLHDYXJJcFck+xMvydizPYGnXBRz9bkdD2YtZowNlugKqvXkjoeJCCYuuPONpyv7oHhRCGUEx1Ln3EK92LlYgBPtINK73TMbDD1efMi/QmCWLztqIJNbT1euTnt8UMYCDx91NVT7LkXrRScbXEg4jMgFLGKv34PLswNb4X9/+GO+HAYUXwPR5QO/sDu/8pwCN+Z/n7bhdS3P/BmNETfDBJOnAyipqpExPySdXFUq2C+gHRfYe6NFZ4/dJFAMbtpqQ4JopjUui2G64orO1aBkWlCSjY29NoXakm0wutg9k8JqpI1c0tgKSMtBIKBTUQ6LJ/qEVfDNuItxyuQvKOBnyCoIB7+7HMykrE/+bKiXBoKwJcrxvvgs8mJKT2AoO4GiDn6/pgZ98siQB/zkseyy804K5yNNCBfkwoiByqN54eQCteCMPVyKoBFR2+qI/t3FVLwKrsHtb+4at/p0OZNz5DLZjWK1EEwA671w+Qqk58X0iQJHNnjIQpxPwEuQzsp3WC/IxAdMULg4gpOcIcwwJxMrsowbCoDxcBb5AwoVQQSnSgBRsaSsLZHvEWki2jrmwMiwmazYVIQKrjiin/SPCoEVyCcVSz5hIUUfofz2UXOmbpNRxUgKYhVAHkSslzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(6916009)(316002)(86362001)(8676002)(53546011)(83380400001)(966005)(36756003)(7416002)(31696002)(16576012)(8936002)(478600001)(16526019)(956004)(54906003)(2906002)(15650500001)(66556008)(5660300002)(66946007)(26005)(6486002)(2616005)(6666004)(31686004)(186003)(4326008)(38100700001)(66476007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y1RkRzBqa2EyRHkydjh6amlwNHpvY2svNHZ2Y1E1dVBNMGlxTkgzNWpzZWV4?=
 =?utf-8?B?WGkvSUtMZnZMZDBxVy95UkQzNTBwTDlJR1RuZGl3eG4yVzFEMVJOS0ZRK2pS?=
 =?utf-8?B?R29OZEVFNjQ1WGNzc3V6NVllTXRQdXpaUzNHWUN4R3NkcmpXUTZVMjNHOEVh?=
 =?utf-8?B?WStISk9uNng5bDhWOEhrOWZXdXRsZGxFRmYvV282SjliZjBDd1ZlWmRlVjZq?=
 =?utf-8?B?QTFJanI2SFAyNGQyLzhMa05lVkM5Nmw2NVZkSEZyY3E3eXlEYnhGdVVpQkYx?=
 =?utf-8?B?U2JWVDBsN2ptYk5sNG1OSUZoY2xIU3d1d2VmZDEvbGZZeU1TNjg5SFBQdks4?=
 =?utf-8?B?UFIrQVBZUWNMdHhxNk5DVTBUVnh3OUNKcTBPR01wSXFITVN6UHNKdjZnbkVq?=
 =?utf-8?B?RGEvMXRabTlDeXQzZmgwODBJdGJBS0djNmx6R01iTDRIUW10TytZSGkwaXpZ?=
 =?utf-8?B?QUZwbzNvNWppaDBUVVRoN0M1amZ5RmJra0Fqa2I1cnNDR2Z4anFrZ1lyQ0xv?=
 =?utf-8?B?MFRGWFZlS1A3amp4MGhTbllKWHhwdlNWV3dYWVBQQ1dPdDlFeFhxNnlCME1x?=
 =?utf-8?B?MnlwZ1ZWYWxJTFRxWDNmRk5FaUt0SWxEajBjcUtGU0oyUUVUaWkzcmdwT3Ft?=
 =?utf-8?B?MmxYeW8ydGQ1MHg1YWRySS9YUEFxQXN2aThYNVJQYXB6TnJ2emdLeFVOYjBO?=
 =?utf-8?B?dE11T0VxN3l1Y056QlEzV3FMVjRlVUFEOEtKMGl4NGZuVERnbzlHM3o5dldT?=
 =?utf-8?B?OXdvQVNJVXg1dkxoOE1VSnh2T3NrR21vZmczdW1jTG9wZ0dFNnBYeDI3Z09v?=
 =?utf-8?B?MHl1SUtmamVqRjBuR0laMmUyQTg1WTJyUVFBclNscmE2NW00b3lzeXczaDdV?=
 =?utf-8?B?RUY5T2VWdlIvRjlkL2xDZ3dhRUJvcHgyTTdoSTNHeU9tUmV2VzB3bENSZHl3?=
 =?utf-8?B?VzBpeUoyQ3RNby9FME1hNmRPQlR5Q0J4eEEwRVVqR1FubFA3aWJPTXpQRDZQ?=
 =?utf-8?B?YVlTUlRNbzdBMngxZUdjS0N5aEZiTTRmckdtektVUS9NUHNOelNzN0laVG9X?=
 =?utf-8?B?WEhiQkhjWjE1MklwKzFFV1Znem9iUm1GTXdOa3dsNThhbWxtTFNxdmw2SjRC?=
 =?utf-8?B?TzhLOHY1ZlVxQVR1YmVtUHJEUkhYc016SE8vRnF1dDZRdTFGTUdmYTBJdTJP?=
 =?utf-8?B?M0hORWd3NUZXd1A4aGJKNmFRaUxjNm52cTZVZzMrOVRhekNoV1h0UlIvV0V2?=
 =?utf-8?B?WVl3SE94eEhqL0g2aEIzUGNVMnR2VnpYdmxwRTZITUNJM3BmWGRHR1NDd2po?=
 =?utf-8?B?VEVOODRZdnJXRy9LUkpveHpXeGRUZ1lyaG1jZEtQbDJ5QVp4UWMrbTFoeTVL?=
 =?utf-8?B?QzVabVc5eU1mZWNVZlhrU1hkUk1lK3BWSzY1TjBxNUxLYXJRaVF0c0l5UHhu?=
 =?utf-8?B?dW1vdmlaZHBoc0ZvQmwxT2RBOVZ3SzRHR0dIZlN2ZjRPVXNsUDJGak1WVWtX?=
 =?utf-8?B?bHFPTjBQZ0RRVCt5RHpSVzRNNWxNMGx6THRFWWlKVVU1cnNaOGgwNWxGNXY4?=
 =?utf-8?B?NXZnNGpWQzR0dXorbTVYU0hubXdpSDZSVHVUOEhJZ1ppRFI3NXdSR3JpdHJy?=
 =?utf-8?B?RUErZUhETnNITnZ6V29xNm1Ja2Jwakg3RjdWVS9nbEVGcDA4L0tDY1hlWjMw?=
 =?utf-8?B?ZGRBMnR5UEh5VlV5WS9sdkNtWnNNRGgxUWNsd2ZBOVV0aGFlU0VJRThGMEFz?=
 =?utf-8?Q?sEQ3DL9BlUopOkfF8t78Rtcgw14BHMPTcCWpRYv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd34f7ff-cdca-4a1d-6069-08d8eef72e54
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 19:01:07.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEiNX9040d+pt0ZEc3MrjRRpMwkrsl0ccGgk7GoZB+1cejUhzjC3xQimaAL86q/FoWAEhWGl5pS+tFVsnnSsNbAUW4C1f8ctSrT8M+mQeeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3256
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=992 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240136
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240136
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/24/21 5:45 PM, Dan Williams wrote:
> On Thu, Mar 18, 2021 at 3:02 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 3/18/21 4:08 AM, Dan Williams wrote:
>>> Now that device-dax and filesystem-dax are guaranteed to unmap all user
>>> mappings of devmap / DAX pages before tearing down the 'struct page'
>>> array, get_user_pages_fast() can rely on its traditional synchronization
>>> method "validate_pte(); get_page(); revalidate_pte()" to catch races with
>>> device shutdown. Specifically the unmap guarantee ensures that gup-fast
>>> either succeeds in taking a page reference (lock-less), or it detects a
>>> need to fall back to the slow path where the device presence can be
>>> revalidated with locks held.
>>
>> [...]
>>
>>> @@ -2087,21 +2078,26 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>>>  #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
>>>
>>>  #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>>> +
>>>  static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>>>                            unsigned long end, unsigned int flags,
>>>                            struct page **pages, int *nr)
>>>  {
>>>       int nr_start = *nr;
>>> -     struct dev_pagemap *pgmap = NULL;
>>>
>>>       do {
>>> -             struct page *page = pfn_to_page(pfn);
>>> +             struct page *page;
>>> +
>>> +             /*
>>> +              * Typically pfn_to_page() on a devmap pfn is not safe
>>> +              * without holding a live reference on the hosting
>>> +              * pgmap. In the gup-fast path it is safe because any
>>> +              * races will be resolved by either gup-fast taking a
>>> +              * reference or the shutdown path unmapping the pte to
>>> +              * trigger gup-fast to fall back to the slow path.
>>> +              */
>>> +             page = pfn_to_page(pfn);
>>>
>>> -             pgmap = get_dev_pagemap(pfn, pgmap);
>>> -             if (unlikely(!pgmap)) {
>>> -                     undo_dev_pagemap(nr, nr_start, flags, pages);
>>> -                     return 0;
>>> -             }
>>>               SetPageReferenced(page);
>>>               pages[*nr] = page;
>>>               if (unlikely(!try_grab_page(page, flags))) {
>>
>> So for allowing FOLL_LONGTERM[0] would it be OK if we used page->pgmap after
>> try_grab_page() for checking pgmap type to see if we are in a device-dax
>> longterm pin?
> 
> So, there is an effort to add a new pte bit p{m,u}d_special to disable
> gup-fast for huge pages [1]. I'd like to investigate whether we could
> use devmap + special as an encoding for "no longterm" and never
> consult the pgmap in the gup-fast path.
> 
> [1]: https://lore.kernel.org/linux-mm/a1fa7fa2-914b-366d-9902-e5b784e8428c@shipmail.org/
>

Oh, nice! That would be ideal indeed, as we would skip the pgmap lookup enterily.

I suppose device-dax would use pfn_t PFN_MAP while fs-dax memory device would set PFN_MAP
| PFN_DEV (provided vmf_insert_pfn_{pmd,pud} calls mkspecial on PFN_DEV).

I haven't been following that thread, but for PMD/PUD special in vmf_* these might be useful:

https://lore.kernel.org/linux-mm/20200110190313.17144-2-joao.m.martins@oracle.com/
https://lore.kernel.org/linux-mm/20200110190313.17144-4-joao.m.martins@oracle.com/
