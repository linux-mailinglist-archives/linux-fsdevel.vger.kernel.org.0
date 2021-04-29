Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4036F292
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 00:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhD2WZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 18:25:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35900 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhD2WZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 18:25:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TMKZkZ144367;
        Thu, 29 Apr 2021 22:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6z0bKHJO7Uyze6pPXiaznPpezgfZIC9kOFptI6LCL8U=;
 b=l0xusavCXXHdIslNOKnFd+Y/u/oj8y4XtCwSt7XIUj7urnxi+fPNQeoNEUQNsSt7MRX/
 HIb3gUmqOdK/MLbHW2NIHAIfRfU5IiV90ZGnFFIZ8W1pZg/VLz0CkuGov35FfNZu4N5I
 YIx+AItE2pVEMJMC5eH2Uev8hADtGdA9STjsAUPlpWzb9QnN6uct+UOCYf2yadhGAc4b
 xbvQFmYOgv7q/X9IuNKgEwKp0q/Pb/ZypTkSCnDx80hVzvsF2+J51388XKHXa1Rgjjv9
 GW2O6MlgoJ/JM3wcybXWY5KhbqS47rUQzyRuzmfIdFWhyKnioBtE5v95wfX74z9bXZXT qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 385aeq5xtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 22:23:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TMKsBS178661;
        Thu, 29 Apr 2021 22:23:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 3874d45dta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 22:23:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk/gv9WOra9A7DZBXFpbw7Y/SciIRnr0ohQ1HRzmlUzDiHQJrw3AOLYmOBGKdS7WU+RyAQnpJrtGGcGUs9mbmzTn2DQFqfFsUMHiqQrgZmWKTi+dIWHqaFsaMNIBz4ss7TfV9EuqIHaAf6wUytV5q3VWn2DHh0JGv7TuGC6WEJeJlCVSqgihTyvmMlGxNN3zsSiSGBrCF4q6ZujoIpOdVF//GVBltg66hmbfRoxr4pMqGaZ9Xkk+blcV/wnLzER9nM+mpoOkSe3O9aacukg3zHydoWeAptFkUIzwkiT7TLr4/Ka+HPw1OdaHlLJYspy84hNfgkyigAOtRubF562LYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z0bKHJO7Uyze6pPXiaznPpezgfZIC9kOFptI6LCL8U=;
 b=D3EGYOqcgu8p+pyAC6lnw+NWSBIFKB7mqlPupNtSks8YwgilA/nwDNUuHKXwoJp09lNhlm2KNeutSDZSOJWfX4rcW+QKjhSmxEpaM3CPwW+nAx9/NAgew6rACGeehEefc6hEdKOwpH18ZYjPe/g6zNJRwHbv2D5+tL94+EI4BeKDf16QdWaxfGLe36cLpgUdl/sZsiPr075M7r398x0r6AcYcZh74NsaIJSdId3HOqmDeHQYqolQHF+2/AprpoSP3eTlIE6dFH6JSUedfnkagL7/yxJWf62kZxDdyrE2SXxqyEaMEU9N3mCzwtczPKxK1RBGZgoaxiERAA6WZXAeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z0bKHJO7Uyze6pPXiaznPpezgfZIC9kOFptI6LCL8U=;
 b=ZSMglveKk4jXJqkJSbmSvtbJxul6EtEzFVlIF0WEa1Vq4ragLLhKhuK1CGk8bAtPuZgllzF3JIATcs3U94h+9Zf70bEb3k85cklfJ37bSOj4MTrF2HmJmSgZAKcp8Z8mU+td3G6Uj2IWQkYojeT3J8Q83TsbAfP2vArqzwA3eBo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 22:23:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 22:23:48 +0000
Subject: Re: [External] Re: [PATCH v21 0/9] Free some vmemmap pages of HugeTLB
 page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210425070752.17783-1-songmuchun@bytedance.com>
 <ee3903ae-7033-7608-c7ed-1f16f0359663@oracle.com>
 <CAMZfGtVbB6YwUMg2ECpdmniQ_vt_3AwdVAuu0GdUJfzWZgQpyg@mail.gmail.com>
 <98f191e8-b509-e541-9d9d-76029c74d241@oracle.com>
 <CAMZfGtUqE6OzWwK6o5h0j6qHPotfvbKpGbzYpSPLLhYH2nJiAw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4489afcd-be3e-7830-4e37-03abe454486a@oracle.com>
Date:   Thu, 29 Apr 2021 15:23:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtUqE6OzWwK6o5h0j6qHPotfvbKpGbzYpSPLLhYH2nJiAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR2101CA0031.namprd21.prod.outlook.com
 (2603:10b6:302:1::44) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR2101CA0031.namprd21.prod.outlook.com (2603:10b6:302:1::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.2 via Frontend Transport; Thu, 29 Apr 2021 22:23:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476dbf71-e90f-43f2-00cb-08d90b5d7544
X-MS-TrafficTypeDiagnostic: BY5PR10MB4372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB43722FCF7610DD23AC6A8601E25F9@BY5PR10MB4372.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXIOVNq+hF46mqIV1tYH9M0q1fAH5jCzWObpqijKDNvRU2vl1Ulyw5T7hlTFITQPsY2bMtb7Uyb7tiiIRp2ooWv1IjkoG/50WTfw8+97Nv2E4uzEGCRgDKlPU4CFTI0omFHh6yB2ZBCVUV1THJ59GcAY9qbxqLOWYOR5nrBk9klEhMg86LseoE7iuaZH++wn/4muQfiksFX8PAyDU/yVLudLoEeeEmm6YzQkCaUV9tj5j1XlfLELC9k/2HWmLM3z3yUZ7D345ZTxYYNvOy1I4P/iBmsP57JbykxH/jqv7LNbDJ7bufPrlEsAhUKzTVbGGLsd7mT6oE7XVcjtGKmwr6Oxrk073Y2+MXvBhuFNqufAr/zmKxgHRevQo5qHR9ybS+ktNzx5U2m4uzXpMMgP53xyvTR9XeO1kgMoFEOFEhMDXduPl6c/gf8YWTGn+O4XfBJsUTv1dFPzqhTB/K1+PnW3tbPhrtFaPEAcLOCRIE/CLGlAAvxjtKVhHgff8vn3N9nW7Qvy3oM6i61GFYz0OYTW057XmkYB5vhSJTU5SqvU82b92IR6sZ0gJfnnh6fA77RHYSaYPPDqKOfU56lqe30S77IjDKZXmyeVrHBM5U2OXlZi7AYwqJ+oYEl/qtqtZYFd7U2pnUQhfhSkXrZIJQVUPRYz/DGd8WRQJCC4b2sBCyDa2wcAUIARFzWUAyoD5WVkKk0VfDUU+nnDQuBY/ZmF0CZq0kgabB08N2FL0dY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(396003)(39860400002)(38100700002)(7416002)(6916009)(7406005)(31686004)(16576012)(316002)(16526019)(186003)(2906002)(26005)(478600001)(66476007)(52116002)(8676002)(66556008)(44832011)(66946007)(5660300002)(53546011)(86362001)(54906003)(2616005)(83380400001)(8936002)(36756003)(4326008)(38350700002)(956004)(31696002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NURmV0JhUWxDb2xTclpFRXZIdFBGbFhPYlo1VEsrYThJRnVuUzdGWVJURjQz?=
 =?utf-8?B?Yk41bWhvNW9JaU04ZTFVQ0lyejhPOGthc3lzd3FGZU5BTjNWMVBNZnZ4VVQz?=
 =?utf-8?B?WU9NemRkbUV4M0w4SnZpc1lNN3ZEZHphN3hjUWZqenByWW1rRmlWMUkyRnp2?=
 =?utf-8?B?Sk14Q2FNenpUT2hjVTEwRWd0ZkprVmI2OXBzdDdVQmRoUG5ENXd4bDNWVVBH?=
 =?utf-8?B?eDQwa25CcmhKVGhMTXhFUmE3am95RlM5ZE1SY29kUm9KbGNiZ0NoOWtGdWh1?=
 =?utf-8?B?ZDRoQlNOL0ZrOXltMWhieXNUeFZKSmV0TDFpSWs0Z09FVk9MUTdydFRYdWhk?=
 =?utf-8?B?V3BGWE03RkdvMjBSU3htZ21iaHFFa2ZyS25FeGF4dC93SHIxV1NCUlFreVRm?=
 =?utf-8?B?YWh2S0hBa2loWjkweWc4Z0NTZkgxc3laOFMzZHRZWlBGTWwyNUlaZlVKcFdQ?=
 =?utf-8?B?bGxHcmFjZmtVM1NMSGREaW4xMVh5Tmh3MHVlVzZtRGN0c1NDSGQxamNIb2xk?=
 =?utf-8?B?ZnhPUUdOL3AwVVNGT3hXajlNWmxlSkNKd1puMGhzNVdEbGsrUVFsUDNLM1M0?=
 =?utf-8?B?UmV6aUhGZnZnTFlQUTRnVmdNRXpXVm9PQ0RZc0d4Q3pMb1g4WGsyM1d6bzhN?=
 =?utf-8?B?TkxrWGNtUXpkMjRnd29idjRwbWtkejRIZ011TUgwSlY5bHZEZjkyODQxNS96?=
 =?utf-8?B?dHorMHNGRHg0RC9XeGMxbzBhWjVRdlAxRW16N0ZMeXZFMHZFOFlXT0diYjJW?=
 =?utf-8?B?dldQT0xjc1FiS1RLV1AxMllVR1NLaHVWR1JVakpvOTVkR2NSWTgvWlJmYU5Y?=
 =?utf-8?B?UDlRczRtVHo5OG0zQ1FYakh1bjNPU1VpM0pBbkcwUUpzSlVhdGZsd2g1bWQ3?=
 =?utf-8?B?STlEWFVBY0U2alM5MlNaYzFwQzl3R1p0Z2kycG9iaTE5ajVNY0d4NXVxZko2?=
 =?utf-8?B?Z2tWOGMvWmtGLzlLbEFtd0UzRmdPcnpQa2ZrSEVvQ2lMKy9sOUJLN3QrNWdp?=
 =?utf-8?B?U0k1eDk0RTBTbFBOenhyenJOblZac3R2SngrRmZMM2NpN2hiVm9OaWx4OUlq?=
 =?utf-8?B?VVU2Zkk5K1l1MTR2THZVRWlzVDlSa2xEVjhtUXZJM0d0bmxHc3FrY3BUaVNT?=
 =?utf-8?B?Qldyd2Rud1hvUEN0aFNsdHdkR3E0eW5adlJselNjUzZCSTBzeWRGNzlHbXBX?=
 =?utf-8?B?Zk93dy9Ca3VUV3lTZThXb1ZsbDdzb0RIeFRHNnY3N1QrYnZmM25kdmQ2L0ZO?=
 =?utf-8?B?Z2N6czE1bzRSWFJpZEVmS0YxWU9Qb3RkcTVBTHVuSlAvQjFoaURwOVY2elVn?=
 =?utf-8?B?aTBkMGdybFIzbWJtVFMwK0RNY1FPRWtWMldOT3B2enBObzNUOE5iaENIRlA2?=
 =?utf-8?B?ZmhURWdvSGZsZkx2R3BKNjhkSzBKZkpnWlNqZnVxZ0xLaEJTQWN6cjRiZmtT?=
 =?utf-8?B?OFFOOStSS2RhK081a2Q1VVNQemVhbDdDSzV2bEFzMHkwLzhNMkZsUmpHUUNj?=
 =?utf-8?B?QTQ0YlNraS9JeVh3RjczeFdVci93UG1yZHVaU3NrZUJqWE5hREtmUDZGZnJ6?=
 =?utf-8?B?eHBzMW5zRzJGOUdTb1F2VVFrbkFiUms1MDgzeEdBcjRyMmsxaEtOWi9RcjFk?=
 =?utf-8?B?aGxGRlZ5VDQyUUI3TmRsbnpSSWV0WGNvZmVDdEgxV1VpakU4MlNIdHd6alRu?=
 =?utf-8?B?azZDS2tIZmI4TkFTMUJJZE9MZWtMZ1dlQTUxbDNZK0x5S1FrUFowNU9rVDlU?=
 =?utf-8?Q?HRsZXwyVDEQVlsh7V/wJdEhbAZBQvGMkZ6Inf+o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476dbf71-e90f-43f2-00cb-08d90b5d7544
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 22:23:47.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzGZadpob0vT9oosUuhtCGt+RPD3x95QmITiB8+wKwmSeCBjreL5uABJtC/GB897uGU1wc1zFxLxwg2b96NL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290141
X-Proofpoint-ORIG-GUID: 0Jy2JaTsIy493D7tqjDGFoW-CY3n7p7D
X-Proofpoint-GUID: 0Jy2JaTsIy493D7tqjDGFoW-CY3n7p7D
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290141
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/21 9:02 PM, Muchun Song wrote:
> On Thu, Apr 29, 2021 at 10:32 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 4/28/21 5:26 AM, Muchun Song wrote:
>>> On Wed, Apr 28, 2021 at 7:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>
>>>> Thanks!  I will take a look at the modifications soon.
>>>>
>>>> I applied the patches to Andrew's mmotm-2021-04-21-23-03, ran some tests and
>>>> got the following warning.  We may need to special case that call to
>>>> __prep_new_huge_page/free_huge_page_vmemmap from alloc_and_dissolve_huge_page
>>>> as it is holding hugetlb lock with IRQs disabled.
>>>
>>> Good catch. Thanks Mike. I will fix it in the next version. How about this:
>>>
>>> @@ -1618,7 +1617,8 @@ static void __prep_new_huge_page(struct hstate
>>> *h, struct page *page)
>>>
>>>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>>>  {
>>> +       free_huge_page_vmemmap(h, page);
>>>         __prep_new_huge_page(page);
>>>         spin_lock_irq(&hugetlb_lock);
>>>         __prep_account_new_huge_page(h, nid);
>>>         spin_unlock_irq(&hugetlb_lock);
>>> @@ -2429,6 +2429,7 @@ static int alloc_and_dissolve_huge_page(struct
>>> hstate *h, struct page *old_page,
>>>         if (!new_page)
>>>                 return -ENOMEM;
>>>
>>> +       free_huge_page_vmemmap(h, new_page);
>>>  retry:
>>>         spin_lock_irq(&hugetlb_lock);
>>>         if (!PageHuge(old_page)) {
>>> @@ -2489,7 +2490,7 @@ static int alloc_and_dissolve_huge_page(struct
>>> hstate *h, struct page *old_page,
>>>
>>>  free_new:
>>>         spin_unlock_irq(&hugetlb_lock);
>>> -       __free_pages(new_page, huge_page_order(h));
>>> +       update_and_free_page(h, new_page, false);
>>>
>>>         return ret;
>>>  }
>>>
>>>
>>
>> Another option would be to leave the prep* routines as is and only
>> modify alloc_and_dissolve_huge_page as follows:
> 
> OK. LGTM. I will use this. Thanks Mike.

There are issues with my suggested patch below.  I am occasionally
hitting the BUG that checks for page ref count being zero at put_page
time.  Still do not fully understand, but I do not hit the same BUG
with your patch above.  Please do not use my patch below.

-- 
Mike Kravetz

>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 9c617c19fc18..f8e5013a6b46 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2420,14 +2420,15 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>
>>         /*
>>          * Before dissolving the page, we need to allocate a new one for the
>> -        * pool to remain stable. Using alloc_buddy_huge_page() allows us to
>> -        * not having to deal with prep_new_huge_page() and avoids dealing of any
>> -        * counters. This simplifies and let us do the whole thing under the
>> -        * lock.
>> +        * pool to remain stable.  Here, we allocate the page and 'prep' it
>> +        * by doing everything but actually updating counters and adding to
>> +        * the pool.  This simplifies and let us do most of the processing
>> +        * under the lock.
>>          */
>>         new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
>>         if (!new_page)
>>                 return -ENOMEM;
>> +       __prep_new_huge_page(h, new_page);
>>
>>  retry:
>>         spin_lock_irq(&hugetlb_lock);
>> @@ -2473,7 +2474,6 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>                  * Reference count trick is needed because allocator gives us
>>                  * referenced page but the pool requires pages with 0 refcount.
>>                  */
>> -               __prep_new_huge_page(h, new_page);
>>                 __prep_account_new_huge_page(h, nid);
>>                 page_ref_dec(new_page);
>>                 enqueue_huge_page(h, new_page);
>> @@ -2489,7 +2489,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>
>>  free_new:
>>         spin_unlock_irq(&hugetlb_lock);
>> -       __free_pages(new_page, huge_page_order(h));
>> +       update_and_free_page(h, old_page, false);
>>
>>         return ret;
>>  }
>>
>> --
>> Mike Kravetz
