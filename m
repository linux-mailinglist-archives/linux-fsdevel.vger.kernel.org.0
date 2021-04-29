Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137F536E348
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 04:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhD2CfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 22:35:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38952 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhD2CfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:35:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T2VB3w140460;
        Thu, 29 Apr 2021 02:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OcjnDgqEeMS7B9pSbILtLRg2VbE+Qgq9ZdV0FbA5cWQ=;
 b=WHF7nnIXZvlYXRorHnUfILflkXLZlFj7B3fVbJ1mJgnSbQaCEfU4QxAr/r7WYvkgFVNf
 KlREKfZK4Dfa32qykk9kD0cnBWRZxMphbc4vDFfoTLFcJLjKpY7XHrk0xmnP+iLBb1fu
 t6u1/PRm96l0grcWAzawrIkhQ2kuyPwtoG9AqtbKlilH4n4PASuK2qa5p9tVypBa6Nwk
 pFMKEkgM4h/dsR/t/rLz0IyESItYOBfztoPJqUcXwAqjEPCRDkdJIOQEzdy8SbhtalCh
 twOf9qmbSWGKZ7foLiYbWH9XaKuyBwnQM4lmCzlQl/WQNtyVLmEP+yvib2cwRos3KcbN Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 385ahbttma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 02:31:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T2UaRb111445;
        Thu, 29 Apr 2021 02:31:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 384w3vjguy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 02:31:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UixyAqEXNS0KMcs1J3gDmw20Mv999cybhfcXMtg/e+D9pjRSst7CSI2Dqh849m7HSSee7mMWWfTeIVV0SGDtA8lY0MKixokSR5wVI/Mp1ZTFApzDC6u5cgWdlp7jLPxsCbY3+Km+tuwxHt/2ijuPyuGZhsPI0PFln2jJV3nUIlxei6iw0tJZJvmpax0SZ2nitN1Va+wSGhb7k7w5M7MvAxmCEz4cXklAZuqcj3NHa4WMqj2E2YKz+HbJM2NjFzH/OPM02Rc5hxT1RYX+3Ob1CYZ5vxCdiR+hYmB2N6JyGg7a+9mfAVrOWXeDu1+JD1fpMW+sVnOO1ZMNirpBpY54Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcjnDgqEeMS7B9pSbILtLRg2VbE+Qgq9ZdV0FbA5cWQ=;
 b=LdvSsqAbfbinQjBCOd/GONaCalWiCqp9IKGfnXmH6NsvkXHcHCd1edM9OmXCzOAj7tRZUtJ2GxPYNseVMyF86SZDG866Fb05izA3kS4tt+VOYC1IdMmm+mdDFjUcdMeusC7Uy3aM2q6Prx8ykURBbsudvaRYOkR7luCeYLwjS1kFJto/DAL5EfIOsJvBvBQNIoJ3pDFDYvY6XAWzmraQHya9Gz0NRTkXt3AnUBAyveuHphnlOlAYYT8bf0OHW5XwZgVpIz3Lhn2Rarf1WBPBPc0Wh5Is8yY8B6wci3xnJ9FlqGQk7KSvacOvAcPv4m8y5JXlymXWdJZyyQtAd4zSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcjnDgqEeMS7B9pSbILtLRg2VbE+Qgq9ZdV0FbA5cWQ=;
 b=hPzs4H+s5bL15H29xDZbrK/qMN42wnBjhlRx5AtcnLafAuzdPLepRwhIc8UbHrVj8Exb8tJIIxwZlD8y4H7l3cu6+YI7qjJ2ojcUNcH61hIflGlwFdGWIzSzGW5TrWlCFMO5EiPsozsrKo6okpPuaZbDfIgdRwiCmSMFIGRTTmw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 29 Apr
 2021 02:31:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 02:31:54 +0000
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <98f191e8-b509-e541-9d9d-76029c74d241@oracle.com>
Date:   Wed, 28 Apr 2021 19:31:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtVbB6YwUMg2ECpdmniQ_vt_3AwdVAuu0GdUJfzWZgQpyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0324.namprd04.prod.outlook.com
 (2603:10b6:303:82::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0324.namprd04.prod.outlook.com (2603:10b6:303:82::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 02:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de27a782-541c-4df0-dfe0-08d90ab6f3fb
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB468636FFCF96E6C8086514B0E25F9@SJ0PR10MB4686.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htXxT16OQAurTD+mI+8pe1x1nfwXmZggUwGvt+Q7S2B/Jf00qor00vhyW/z3W+Z2XcrgrdkZz6CKlviJSIlbPM7T4SB25D0Rhcguumk6+4Rsr0VOBZrxfKw16CwDkk+Ja7v4myfnGF1iEHsWIk4Uy1CMybzguz+bIj6I/TLReS2Zf6YJEz8kN3dboiK8zhh1BdfqRhYRNuKVnGsUSUn5dkbHG7HnVPcXlsVAbyt/fs0YV/Z5sQ+aZED7goarl34gPuhdODX99NYcP4GQtKwgJFq+X3tRBDcodDPEroj7B8VE3cXIISCm2KtPsqpXXiFbmBfR+3Zl0KFIidSURpcwkZsPVT9ASp2AbIcrCVpK3LvqjQ9OmHfdZGFb+cSuwE70yP6HDcLnHpwFSxQ66Kh3Iypl3J0SNBHpxl0/WBgnl4hbbwMBb665o8PcrJKIPgBmXGA4JVWOmVcJqUlnbir/FhPyN88+PBxi0NSQyH3k3sfLfbvazD0+EL9E5l03DmcRLn5EfKUoYHWev/1DT+xDjktDfVD5oX2zWA+E2zIGRpgDgYRY1pHs3e6nQCYjW8QeUVdNqM4mutKmd6+SPZXj3GBOGEGBMsWxIAEsr4ED6wy00/1dlQMwp38Jqrrq2DQs8F5HHCUa4zFOn2zcj9IAf/gN4dRaQDxARZeXJX0ujqACAqV6frYkVEej54HNPpz7/rqknHRMM3usB6eq19ezOUh5NeIIP7zntupZSi3YZes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(396003)(39860400002)(5660300002)(4326008)(2616005)(8936002)(38350700002)(66556008)(54906003)(956004)(8676002)(66476007)(6916009)(186003)(26005)(86362001)(16526019)(66946007)(31686004)(316002)(7406005)(7416002)(478600001)(52116002)(53546011)(6486002)(44832011)(38100700002)(31696002)(83380400001)(36756003)(16576012)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QzJKYVFTaW1nb1B6eUUrWmtzK2pVVnYvYkRjNk1FNWVaZ21yZHN5dnB4RXRK?=
 =?utf-8?B?STdsM2t3cldScEZLMlF5TDU2UlBDV2NtY3lZYjF4eVBhTzFjQ1M0eStkcDZB?=
 =?utf-8?B?MXd0TnBaSWlydThIZEZRU3NnTmhyTm13TkxaVGRrY21HWmdLWVVVRE9qdVB2?=
 =?utf-8?B?VGZJRHA3eG1yZUhMZW4xWEZ4b25ReTRuaC9KYnZEYmNSeElZdWQzZHNLOWNN?=
 =?utf-8?B?Qk9uSXhyM1EvdWlnMkttc0pHeEZrKzVOaGV4M0tRRGE0eVFBb3V6aVlHWG1j?=
 =?utf-8?B?NS9qQXhXYWRSdm1jeXFKQ1F4YTk0cjUrYmRZNUM1eWdOZm1xWHZJWS9xMnpK?=
 =?utf-8?B?WU44SmtBcUlQRlhUTVhIZnNaTzUwWGVGY0Z1eTRwV0trZWtBTW55RzE3Q0hQ?=
 =?utf-8?B?a1dPQ0s1N2l3ZWhGSEVxQ3RLak1ENFhIVkE2bEI3N3BacWhVOXJZYzEwbkMv?=
 =?utf-8?B?WEtTV1UvUlR3aDZPVkRSdEhhWXdHYnkyem5tc0ROV2FxZ004bVVXelpsdDZa?=
 =?utf-8?B?bXV1ajhNa1IrYUNWdkg3R1F5QVYvNFoxeTBIR3QvYTFwM3U4RFBWMXc3RTVt?=
 =?utf-8?B?ZmZEbHhyZHp2M3BkQ0dwa0dxaGdOSk5ENktVRUY4STFMNTZVbzZvWi85SFJX?=
 =?utf-8?B?dGczcWJuUXZtd2U3VysvSjlmV1ZZVkpGeDc0aytBTHNrRWNxVXJrQUdhK0ZW?=
 =?utf-8?B?T1JLZVVjSGQvY3dodzdFZk1vMEw0Mml0U2RlcGxLb2JjNHU2bGtSK0VyUUlS?=
 =?utf-8?B?aStDZktFN3RUZXAxT2plbmRKc20rSWh6TllLRlJCa3lZMEp0bXhwTHFYZFJP?=
 =?utf-8?B?cUtRMnYzT1JlbUNFNGVSelJ4RjUxbmxIZllkdU1UMUpZRGZ6VGcrUFZGOGt3?=
 =?utf-8?B?SHRqZmJOQXFhbU5XZXlENmxSazVXaVhaSTNGdnE5TEcxVmhrMk44dG15VVgy?=
 =?utf-8?B?U294QVdPVnFlUVJ0dWVQTFJQMDFDZTA2RmEzTUVBQTBLMVFJOE1IMTB5bHpU?=
 =?utf-8?B?N3k1VXlPU0tvUmtpSGtJeG84bStMRklqcitxZFI3NG45RnVlaHY5Qi81VVBq?=
 =?utf-8?B?U09IKzg1YlJLMGNUQzBtVVhaWHBPNy94THVGQW5ncmxKSU1oYlpqc1BqRS9o?=
 =?utf-8?B?bG44ekRtZXNycm5nZ1dkRCt4SFJleWZwSGhoVEVzcjgzNlZLc3pGS2hNaE9j?=
 =?utf-8?B?REJJbTFhNlNNRHhXZjZXNmJML1lJUjdSWVVlcjJ2Y0xBNjEyaWJMdE9DVjVB?=
 =?utf-8?B?Rk9IR3lzZjBOdzZmNlkvU2tscUN0cWUvcUlYa3dIRHZVcnRiMmFyTjZlWVF6?=
 =?utf-8?B?Sjg3RHJMQlgyd0N1dHNtOHVZckdlT01Gb2hnc1JmOWsvOStvOHBUTld5d3d0?=
 =?utf-8?B?MXlPcnVrWE9BaXg3K1ZTOTM0MnMzSk4rZllMeFVLaGtFYXFWc3kyTnY0NXo0?=
 =?utf-8?B?RU5zNE05NS9ZY1dPVGI2YWFPVStOQWRxeUVsbnhhUDNDcFZaMEd2WXVIWmhC?=
 =?utf-8?B?d2FZV28rck0rcis2QU9UcndjTW5TNEFiZW1VTmNEOUpnOUtnQk1nZ0QvNWth?=
 =?utf-8?B?Rmc1UFFFUHpna0VxU29wcFdlWWNPRWlFbWpySlhkb0J0R1FXQVBPRWVaWmkw?=
 =?utf-8?B?cnFVUnpTVTl6MDlyYUFEcklGb1NsaGQ3Kys0UE85UTUwQlZYNE1TZ24yS0xU?=
 =?utf-8?B?Q25PUnR1KzYrbjEzSW9JL0dEVjZJaWM4QlFlNmJDekdRTlYvaCsvTnZnNDlh?=
 =?utf-8?Q?iiXNOyMwXzZHd2sK4CSL5jMfC7Kp8RDOSd5/UkQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de27a782-541c-4df0-dfe0-08d90ab6f3fb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 02:31:54.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jlvo0vjS/abva+7JVGCEDkXM2abYLuRsvXSfRS2spMJ4hCZ4sKejhYvqN1DfYjy7u75AcPdEUz1Nktr/zbpXbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4686
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290017
X-Proofpoint-GUID: FRFQCUtwD2O2wuA8BhXhLvy4FQV0dHc6
X-Proofpoint-ORIG-GUID: FRFQCUtwD2O2wuA8BhXhLvy4FQV0dHc6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290017
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/21 5:26 AM, Muchun Song wrote:
> On Wed, Apr 28, 2021 at 7:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> Thanks!  I will take a look at the modifications soon.
>>
>> I applied the patches to Andrew's mmotm-2021-04-21-23-03, ran some tests and
>> got the following warning.  We may need to special case that call to
>> __prep_new_huge_page/free_huge_page_vmemmap from alloc_and_dissolve_huge_page
>> as it is holding hugetlb lock with IRQs disabled.
> 
> Good catch. Thanks Mike. I will fix it in the next version. How about this:
> 
> @@ -1618,7 +1617,8 @@ static void __prep_new_huge_page(struct hstate
> *h, struct page *page)
> 
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
> +       free_huge_page_vmemmap(h, page);
>         __prep_new_huge_page(page);
>         spin_lock_irq(&hugetlb_lock);
>         __prep_account_new_huge_page(h, nid);
>         spin_unlock_irq(&hugetlb_lock);
> @@ -2429,6 +2429,7 @@ static int alloc_and_dissolve_huge_page(struct
> hstate *h, struct page *old_page,
>         if (!new_page)
>                 return -ENOMEM;
> 
> +       free_huge_page_vmemmap(h, new_page);
>  retry:
>         spin_lock_irq(&hugetlb_lock);
>         if (!PageHuge(old_page)) {
> @@ -2489,7 +2490,7 @@ static int alloc_and_dissolve_huge_page(struct
> hstate *h, struct page *old_page,
> 
>  free_new:
>         spin_unlock_irq(&hugetlb_lock);
> -       __free_pages(new_page, huge_page_order(h));
> +       update_and_free_page(h, new_page, false);
> 
>         return ret;
>  }
> 
> 

Another option would be to leave the prep* routines as is and only
modify alloc_and_dissolve_huge_page as follows:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9c617c19fc18..f8e5013a6b46 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2420,14 +2420,15 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 
 	/*
 	 * Before dissolving the page, we need to allocate a new one for the
-	 * pool to remain stable. Using alloc_buddy_huge_page() allows us to
-	 * not having to deal with prep_new_huge_page() and avoids dealing of any
-	 * counters. This simplifies and let us do the whole thing under the
-	 * lock.
+	 * pool to remain stable.  Here, we allocate the page and 'prep' it
+	 * by doing everything but actually updating counters and adding to
+	 * the pool.  This simplifies and let us do most of the processing
+	 * under the lock.
 	 */
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
 		return -ENOMEM;
+	__prep_new_huge_page(h, new_page);
 
 retry:
 	spin_lock_irq(&hugetlb_lock);
@@ -2473,7 +2474,6 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Reference count trick is needed because allocator gives us
 		 * referenced page but the pool requires pages with 0 refcount.
 		 */
-		__prep_new_huge_page(h, new_page);
 		__prep_account_new_huge_page(h, nid);
 		page_ref_dec(new_page);
 		enqueue_huge_page(h, new_page);
@@ -2489,7 +2489,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
-	__free_pages(new_page, huge_page_order(h));
+	update_and_free_page(h, old_page, false);
 
 	return ret;
 }

-- 
Mike Kravetz
