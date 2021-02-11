Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FF03191E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 19:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhBKSJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 13:09:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhBKSH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:07:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BHhoCl139241;
        Thu, 11 Feb 2021 18:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZehWqMSHukTWgSu3KgloYLYvZQxkegyAN1gR7WfrTp8=;
 b=V7PzM8+2GlKjhWA9FO2sSJ+w+yjdu8xmWverxQpaQsp2ucjUf2lIoqzQC8PTWsyUTlai
 laBHMegJgGU4W1TCr6Aks8qHkMyuZy9h9r00lLhXeRfQWVhLfsXJLJ5BK68cEQTpxZ32
 1thKKWd1ERYQjUkf8AgISW1e+SvgRnHQQUrj6LcroxqI2UvaOQz2ubswl+sGRyLsUVE6
 hp9sVaVcv/4wslqt7FlfeM3WYjJWUhRCdfXraMNV5Ako6bKq5v/clA53OpYVEkuxlpNS
 B4nixogINSQgT3ajRZHf5U78W01tV1fkXe7czzBQ1TIXyxbmypK906t87K8/e7kTDkZt 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrn8g0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 18:05:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BHk4tS041016;
        Thu, 11 Feb 2021 18:05:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3030.oracle.com with ESMTP id 36j4prw0uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 18:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ3RB9YrORn6J8Um+sP5fJCjg5riffMpBPYG5KrNy0WD0mbiHu9Nd53MfFb9avvhESIOMOxszjSbOuP8XqPLMo8FuVaEOAnV0uma+zgapBJlDFh8ImeoWNMTl/jWU97WZxKGf6+SQA+FPB1rqO1OXYfuM9p7q0EJeGn4HnQe9DBEiFl0OHFnAPo2KSLF9du3pmr9vidh2opEn8nWTW33Su6o4gxHkgXu/sfmwFLy6Yc1jph3Wd+5zrvxSZnoeLi6xyyycNOPKxhe9/fuNQKBaRYw2o3tIuGIn0AQ5ps6A1UKoIQTv5xG4cIjWRTv3+RyLnkO72ENv7aSq3YcYxp5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZehWqMSHukTWgSu3KgloYLYvZQxkegyAN1gR7WfrTp8=;
 b=MpR9L6ECgo7m8y865ovuzMAcr1EUO56JiqoCo66nJqGIkjdgdrxbDKTCiEtap6JCxpP/rEKPEtS1bbAOyYDUi791TmLOQAgXdUR4DW3TWIKEIT3PnuBLxo+UMRTcNf+acO64UaiftfNQhnQd5huu6/esKvRXqUg6dQheNJONjlK1CpXNUvdoOtCihmoiqCZnYeFP4vDwa6T3Co5cxH9FfZf9EpUPJAjMWx0gxEulwiKB2nIKvAgikDwxPWjOuflNEIcRNnN9IUu057VSPh8779hWVZ4adxWZop1ayX1ei4ArsMRCkZB/iO8lzg+VT5UD6B8D4VFPOq+uTw5USNv6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZehWqMSHukTWgSu3KgloYLYvZQxkegyAN1gR7WfrTp8=;
 b=J2GVM4RybH18h99A52Tpvg2XdRfWnQVinSA9ljywJYmjYcPe4R4SGZkQnqzsC8ReIJ7wq1ViAxsaj43NVBFJl9p1qrfO4Ykozr9n+3u6eYj1wphlJL57ZnEZGRUUL48g5TzHHaBvCcxUKxEJm5eB7yJBh0Cg5KqyY2bjnxfEuL4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1758.namprd10.prod.outlook.com (2603:10b6:301:9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 11 Feb
 2021 18:05:22 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 18:05:22 +0000
Subject: Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210208085013.89436-1-songmuchun@bytedance.com>
 <20210208085013.89436-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <72e772bc-7103-62da-d834-059eb5a3ce5b@oracle.com>
Date:   Thu, 11 Feb 2021 10:05:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210208085013.89436-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:300:95::31) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR13CA0045.namprd13.prod.outlook.com (2603:10b6:300:95::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Thu, 11 Feb 2021 18:05:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be3b790a-6370-4d67-3e0c-08d8ceb79959
X-MS-TrafficTypeDiagnostic: MWHPR10MB1758:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1758387C415F3A99966FF426E28C9@MWHPR10MB1758.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uEHhYgSZpi/+XR8WxcfJnAvwLrggnbkdoiXm8iE/yKuKg2i9EtoPH8h8DiwruklNbNysgD2iCvrHvPEYGJ5n9tfqv3UnhMDANAmisg7ScuL7lwRmpxhSaeXOTY3NYxtvNkstGSp6sLAarlbGzbKMkb/za+XW8QCy+tej7aj07A4QO3gSWHG0VB14BsehUY6pIkJ60iNscrfNd5WDgKYyHkF+TlLIgo6B7BAkXB4zieAw+kZkNU89fLVIFr558P5uK/le9nw6fwoLRz/ggbVggxyh1Sx+YMgsahb999U81L1kyay6craviCfnnCilDCwvqQenlNm2hDgPAe0ASxOkJ/vT8YjUvijeAC14The6Yovpp16Ug3YN2RUFgT80rW95QnFUay2l2z8X2+Umytpz9yDY7zwMnuHr/6Uy0SAIVqJazOI5blG9phC8Epq6fGhu/jczQME6Vyi2EyNRuCHOMKvyEXXgeh0bhhdPcQGrd7WRQyyNxXn+X9xFaVY2i+40F8ryB9Jo9Fa/1pnCAd8SzGi6+o0C/gx2XPVneOg3MnywmI18xGjHzYiURPG4022K+j57LmFvV87zpttxGTc4uxKQZNGJYfi8dzjLuXwpdywzkhrKZ/z7J/9PUzsJBZaTVldXkM0qKy0Nd+4OECfRuFYJTCjoociy4q4jNFJU+OIVoQUN4U/+cVj5gg926BYmtmokyOzPsGF65e+FNxnBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(86362001)(8676002)(7406005)(31696002)(31686004)(36756003)(921005)(7416002)(83380400001)(6636002)(2906002)(4326008)(16576012)(5660300002)(52116002)(478600001)(966005)(8936002)(66556008)(66946007)(6486002)(26005)(316002)(16526019)(186003)(53546011)(66476007)(956004)(2616005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVBxenVRUU9QcmliSTNMbGYvR0g4ZHNLNTd6QnNOamkvUnl3OXMvWTUvbDN3?=
 =?utf-8?B?U1VmQlhVR3Z4bU5aQi9RV1FycWN0UXBCdWlrNFovK0w2VDhlanZ3dG53WEt2?=
 =?utf-8?B?Yms2eDF0QkRKbDRFNHNyQThiNVFuSzhKUmliWkJvMzFheUo4SnpHcXVpZ1BG?=
 =?utf-8?B?aUx6KzJkN3BDNmd6NmdSUkREek5EU1FxTHQ4c2J5VkExUEVNa29sS0Q1WGZm?=
 =?utf-8?B?T1I4bW0rbmdMd0wzZkNGckxzNGhwbVpJYW5iYUFxUnZLcStueHcvQWFibm05?=
 =?utf-8?B?K0tJRUt2THplNTNBSzN5MFNTakp3TVpmRVNiWUtXV3I2WmtRWG5CZ3lFUzdO?=
 =?utf-8?B?RlRTcEt6NEtQQXh4cW9oN1lESmxSQ2hQOWxBUkZNeXJqRGtyWEhML3BJaU5a?=
 =?utf-8?B?djdvMVduQ1ZkNTF5S2Q3SzBCbmV2QVg0SzlTVEc3a3RWdUs2SStCTUdYb0NS?=
 =?utf-8?B?bDE2TUh1dG5NSHF1V2E5b2RGYmtRT29jMEFiUy94d0paa1RZWnVZU1FpTFAx?=
 =?utf-8?B?RXE5ZS9BV3M0Y2diSHFObWxhL3VVaENLODF4Y1hUNkhjTVV4dWIzaFBnQWNs?=
 =?utf-8?B?OGhBdExINWFVd0VyNjhNdVdmTEhIMXhTeGJlVmtmbFpqb21SSWVJWm5FNnNi?=
 =?utf-8?B?VDlkTlB2Nm5ydmpoTG9nSXlYSldGZXdVSEZHa09xSkwydUs1RFh1Ny9CUVZi?=
 =?utf-8?B?RFlXMi9TZEl2aDR4S01iM0E3UTgrQkszQ1creVcvb3pQS3RnaFMwckhrM0FI?=
 =?utf-8?B?dnc0Q2NDZGlKcFRsT0FqVzJLWmxPVjFOVW1keXd5S0dHbzV3eVNNTmEza2ta?=
 =?utf-8?B?UUZFa1NMdlZzM0xPYmprcFVVU0hYbWRieUF6Nml6ODZmS2JRTlE0ekRSTmd3?=
 =?utf-8?B?a0RDWCtXQ0UrNzd0K1Y2NkdmZldLYXlOb1F3VGNtNG9ocmk5UnFaZTRlSnlr?=
 =?utf-8?B?c0NnL0JxUGxvSHRybTZUaDhyWEdXRHpvK3ZRUXRvcW9EekxCMzJtbkpBN3Rv?=
 =?utf-8?B?K01CZ0NqMVVqK0hZWmY2UXJsT2NCbkJqeFptK3F0QkIvVkRiT3o0VE5IOVFj?=
 =?utf-8?B?ZGdaU3FDMEdFL3FhRzlJc2FWeXNCKzVocDZNR1ZWL2RkTm1VSlRBQWJtVHJV?=
 =?utf-8?B?dUdybTU0Y2QrQ21NTlpFVk8zNHZxdDF6Q0JhS1V0SXY5K2ZDSHY2OXVLV1NQ?=
 =?utf-8?B?QjVpRUg2KzRUQTFoeUw1Y0pJOHpkckY1QjNRVFNUUlp3dE5FcWorNWZZcy92?=
 =?utf-8?B?Tm5rSVhGaHovTUVQUnl2SGN5dDh6Vk9lUWlOalFOWDNLVmYraHVnWHFNcGFV?=
 =?utf-8?B?MmhxZEhEalQ1c2NMMWZyaDJJcnZoRTcvNDZmSGlsUVltbHJDTUlDcWY0NFZN?=
 =?utf-8?B?VmVrd3lBTDFtL0tnblQ1NUduaXpIb1pvYStDUEhxRmRvL0tVRUJObzNhNENQ?=
 =?utf-8?B?aExBVTRRQ2t6b2ttcWhhbTQ5d0l5N2gxRVlvL3VYY0ZPWmI2Qjk5c1RIejJE?=
 =?utf-8?B?cGRWL2Rnc1pGV0ZzWDg1Tm54MHFhTmhyakp1R1ZZWnhBbFZOQ3pwQkczcCtS?=
 =?utf-8?B?VDlMYytDVGdSK1pBanFLYUVKYkdxL3lvNnFhQ0VyQ3Q1RzdCSnRRVjNHb1Y1?=
 =?utf-8?B?N3lxZzVTSHdkUTVuNHRyOSttMlhqNlJqRHgxeWp3clp5clA3VE9kYWxoTTl6?=
 =?utf-8?B?RVZJOFhvTlRZNW1VdFMyTjNibkkzQVB1RVE1OEtMN3luUkJZdXh3ejVTQzZ3?=
 =?utf-8?Q?YR6haXUCD9YPITnbolrY67yJUknlbUrALeeheEX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3b790a-6370-4d67-3e0c-08d8ceb79959
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 18:05:22.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zf6JxGMDc7hEgJf6jXBOCZB606ALvRnKHBZkIHWb2XOqyHrR04EUnwI6UMqBqRvJCP/Z5IuMVfbL1I9Rfv8+SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1758
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110145
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110145
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/8/21 12:50 AM, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate the
> vmemmap pages associated with it. But we may cannot allocate vmemmap pages
> when the system is under memory pressure, in this case, we just refuse to
> free the HugeTLB page instead of looping forever trying to allocate the
> pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/mm.h   |  2 ++
>  mm/hugetlb.c         | 19 ++++++++++++-
>  mm/hugetlb_vmemmap.c | 30 +++++++++++++++++++++
>  mm/hugetlb_vmemmap.h |  6 +++++
>  mm/sparse-vmemmap.c  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 130 insertions(+), 2 deletions(-)

Muchun has done a great job simplifying this patch series and addressing
issues as they are brought up.  This patch addresses the issue which seems
to be the biggest stumbling block to this series.  The need to allocate
vmemmap pages to dissolve a hugetlb page to the buddy allocator.  The way
it is addressed in this patch is to simply fail to dissolve the hugetlb
page if the vmmemmap pages can not be allocated.  IMO, this is an 'acceptable'
strategy.  If we find ourselves in this situation then we are likely to be
hitting other corner cases in the system.  I wish there was a perfect way
to address this issue, but we have been unable to come up with one.

There was a decent discussion about this is a previous version of the
series starting here:
https://lore.kernel.org/linux-mm/20210126092942.GA10602@linux/
In this thread various other options were suggested and discussed.

I would like to come to some agreement on an acceptable way to handle this
specific issue.  IMO, it makes little sense to continue refining other
parts of this series if we can not figure out how to move forward on this
issue.

It would be great if David H, David R and Michal could share their opinions
on this.  No need to review details the code yet (unless you want), but
let's start a discussion on how to move past this issue if we can.
-- 
Mike Kravetz
