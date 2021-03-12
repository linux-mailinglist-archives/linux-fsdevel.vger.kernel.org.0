Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E34339606
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 19:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhCLSR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 13:17:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43448 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhCLSRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:17:41 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CIADIF139719;
        Fri, 12 Mar 2021 18:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Aeo0U1j1HUaM5Ge+pwklaUgTL0xcvCR4X9yQXLx7oPI=;
 b=B4NuF9Wv3ZI9MdEyF4fapJsRT90PY2Xa9T0ZQguxExCvYb6nhWWPtDhrRArYeGf56hXd
 EnuEFmxdpQ8GSOhobWORHdk+teRJ5KmYSIc5ihjH+wxSWwN8EsFX6AX7Yv6OKFTuZGx0
 hBPTvZasYmZ86wMWa8VVJCp+yc1klMsthdypgU/FtSbGE6s8o6XwcfUNMoExRtT8E+dR
 r0mcoaQkRfQhk/35+OYOS1rs7d+F4O69FsF5UKqPbNjnHAi7kzmS/1GGE6ySS3+tyvrv
 hWSIbmVPYTQ30JVfPE6hyvUnGURb61e+foG6B5nrJW/qMQjmNptl/FoP5zTEPeRHxFGH Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 373y8c2w6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 18:16:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CIDnE3002684;
        Fri, 12 Mar 2021 18:16:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 378cexb719-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 18:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsFw7bKg2Z9srDYFBSH2WWs2WPJ+mEWFCJtxQAi2SN2Sq+KnaWFZ7HUa03hqA+K5mfErT77inVO2GH5Q7VgWhdHtDqnOt6/7JKNuxN9K6o4v5KX+bvjC9/U/msGYfG5BgmDRY384Q2wBG1zbQACdoTwnblQFL1QVuXhha4o3mxkkxivvOpCzd+SI571Q0Cw208NFlo26xurVfxpwfpFXxn72oLEHsE41b2SOZzogvohYHzLzkksyStZbY4UYE8qEhQp3JDSluebRWvEZ0wZm488TD8kI+Gnc5HmZQo9KQjGqSvpju3tXokbaUY8hhm39CMDCWx4ZHczDFhP7AndF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aeo0U1j1HUaM5Ge+pwklaUgTL0xcvCR4X9yQXLx7oPI=;
 b=PLM2M0nDG9Ys84pCoYEAbmACtZsitkfxQgOyPOwNLcbReR9nqH9rGHRX6+y7pZTadNxOjb6qnJVahPkeyeqtRAu2v7FH2J5H+1zxrLI53mISZhbsrR61s5rkH+7G6EAWtEglBitQaSNgMTrppsf0SgjWYn6mnrPgkUKZ65+zruamUyupmkpV3b6gKtD//jzQtX47U7QxCJr+az8TD8OS64kaf2Ix7XVpkTmLvqsx1cEpcZ+/DH2bz3labTty0P1oNZfTvl+iBkDhvt8rGMnvVcUqGHFQxM14SsSbzntVBe3gH/x8SHRHAefVcxlhX0fzpqK8g4Xg7Q9Zgp/2WacnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aeo0U1j1HUaM5Ge+pwklaUgTL0xcvCR4X9yQXLx7oPI=;
 b=N4M1l19fTKGUsZx2R0AEqYVkwhHwz54N2lLTSUjnU5WybRsWNHF78yj+NFatb/GBFnIW4OqZQCquPHZuk1ZrpvkvXjr6N96VlcwWR7mopwUDwEIH8fGAnRU/lIKebGH4lckTt8HLoR7dMvBpc7Eg1zGuxmz3FwwVlk0oIMN1L5M=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4445.namprd10.prod.outlook.com (2603:10b6:a03:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 17:50:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 17:50:40 +0000
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
 <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
 <YEk1+mDZ4u85RKL3@dhcp22.suse.cz>
 <20210310214909.GY2696@paulmck-ThinkPad-P72>
 <68bc8cc9-a15b-2e97-9a2a-282fe6e9bd3f@oracle.com>
 <20210310232851.GZ2696@paulmck-ThinkPad-P72>
 <YEnXllhPEQhT0CRt@dhcp22.suse.cz> <YEoKa5oSm/hdgt5V@dhcp22.suse.cz>
 <45f434da-b55b-da61-be36-c248a301f688@oracle.com>
 <4d4851fd-f0fd-9bfe-d271-b53891fdab6f@oracle.com>
 <YEsjGbKtyrpfas4C@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b6f204af-ff17-3088-c717-d299b33e6fcb@oracle.com>
Date:   Fri, 12 Mar 2021 09:50:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YEsjGbKtyrpfas4C@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0194.namprd04.prod.outlook.com (2603:10b6:303:86::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 17:50:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3627624-02ef-4dbb-dd09-08d8e57f599a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4445FC59C9D296F395B8292FE26F9@SJ0PR10MB4445.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+uG4vPE9VSmW7oHi6PRPs5+cG6qNIfrz1yF1x6r56zj5cWPmxPxR4IW13KoTcsVTb06D9XVQQXF5LeVWCQdBtcI+oHxzTSB2ciHCyHqrYgHQ4kfdxrN+kHh553OOrgH2VMKcY9cBQtPljxxh8IdNdq9XoK5D/tQMCyRJqsSTSAGGqJE5uo/CtgWBYfIh1djDPOxn4/qSMnVPWfzfiSYcRE4rrvKOIieTpBmTfwB6kV7nXuKHbV3o++SgKoTIpr/3Y74amYjtdJXZSVZOEKfrNkTl7R4RMDRjpYakvrp5K1TPgYC4V7LfedCLUgZTZT1lUoAtWmBIZR753xQt11u1F9vgS/Yv+jz9Pr1rhhlSBvzfWSG/aHb+ZdC7M958XWTqWVZc6R0VRxcsSLA5PtvEMXfZAlwvwW0MZzb/RBLJyuwuKTpFtVzthRZ51YdXaefOxbpPuxG4XQ2j4TjLPKU4Ysi+NmBut9vLR1nV9dco7DvQ6z7edCVablu5yiAl0so2FMh5ZWbrvEimnv6ZlQUxCPBkYDjGbAh/9lA7Ec2n79hOna4WJDtoBKkukUqHQyKjW6Btl2XIqFq9xEJeNlRgJpfe913s9YSG5GOuS+9+LjyxI6vyfHJ978uNzFiV0hJ9WaFdQFq8kLN1WsYScMme+r7rwxQJM9VLaRyuYwNItG+IC0fcQ+J8pF0ahoGVT9gjXi5hyPXsX4dFoc0qOZU94bjQsqgm1Do1+/dJGWXp27z6BM7fuHSnZSytX8leC+Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(366004)(136003)(956004)(2616005)(44832011)(26005)(186003)(16526019)(7416002)(4326008)(966005)(478600001)(7406005)(316002)(16576012)(6486002)(8676002)(66476007)(66556008)(86362001)(31696002)(66946007)(5660300002)(52116002)(53546011)(36756003)(31686004)(6916009)(83380400001)(54906003)(2906002)(8936002)(354624002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WWtscmE0ZFJFYjhVRVpwVmdvc3RBbEFWa3NaR09HeEpocmFyZGVDalVQUTNr?=
 =?utf-8?B?UDRERkNoSkI2S1BqM0g2Nm9mWnM4NVRZR2tFRDV1aFlIbWI2ZHhiUEx3ZkVj?=
 =?utf-8?B?dVg2cForSmYvZjg1dTBFV2U1TmtyNG52M2I5aVZaUndLdVhaemFzOEduMFB6?=
 =?utf-8?B?L2pwWmFSSExBeHAzWE5RbitaV3lxV00zYzFSdXRGL2F3dnhKVFpSNUI5TjFE?=
 =?utf-8?B?MW1vTjBaSGJGMllXbkxjcU1LNWhhQ3lCY3lacFVIZkRzMllvOWFMcFVUWUh0?=
 =?utf-8?B?TExXdHk4MVJZWnQyY05ISmpMZ0U2VUwxNmJ0TisvSUU4dy9QcTdiZFI2RU9z?=
 =?utf-8?B?TzNTOTZqRitPVm1PbWpkUXZZNGhQMjRnYURFWTB3dXZRNUk4V1o0UkFqRG1q?=
 =?utf-8?B?NFNNYTFlemRMUFdXa3l4MlhObFJUMHNYN1ozUWNwU2lYVkY4QnNpNEJUYzNj?=
 =?utf-8?B?UTA0UERGdlcyMTM4S0R0MkUySkRzc2l6ZmNBSmluT1pUaUF0MXM3M2I1WjQ3?=
 =?utf-8?B?Tk0rWi9LQjFaOTBpNExWNjhSakxId0RTT0xQS1g2WmRKRGt0eTcyVVdGWG5h?=
 =?utf-8?B?UW5Idjl3ckNoemQyTEJBS3JpNXI5NW9vMHdOWTB6bEVMbUZGN1pnckxoamxP?=
 =?utf-8?B?R0RpNDhDR2xad1J5WDlVYnJiMTl1N0E1Z0JzRmpWVFBLNXVzZnhHOWprTWVI?=
 =?utf-8?B?VXoyZGp5MUU4WUZodEhoNTNOUTlpTzhtN1BDd0laQnp2OXFpb2pkODJZZVFH?=
 =?utf-8?B?elVLOFl5dm92UGxHb2kyQXYwTlpzQXF3ci9tZ3BJZWxXVnhtdjBNdmttclJ1?=
 =?utf-8?B?Yng4NFpndGI1cGMyckJmZngzRFpNZG1BYU1UTEthM2EzQ0tPa3BSUWhRaU4x?=
 =?utf-8?B?cHpHQktPSVBnZ2F5Q2ZITkZhN3pma2FUYmNCVTFQOGNKcWpMc2JWcU1Ob21x?=
 =?utf-8?B?QS9MK1RyaVZQVlhtODZ1M0o3SEU4VityTmZzekdSVjVXaVRqbUhQT2lGT1dN?=
 =?utf-8?B?UWtKZ0Q2Q00yTXNMaGU1Mk0wTk1CV25oUGc5dDBRejN4Q1hiSU1MbDZ2UzdK?=
 =?utf-8?B?RmttUk5xVjNlcUxGTTFWa1dxRUpVbEF4SERjZFFLMVZzT2VKZ2xZZVVHbWNv?=
 =?utf-8?B?SXJ0SnNzdkQzOEcyVHBGMmZ4YXhKS0ltZVpZaStHL3ZEeE5KZno3eEVyN2ZV?=
 =?utf-8?B?UDNWSytpZUMzcHlQVW52dkpKeWZleXFIMnFpVERmWkpieTA4Qm9PUkNPYk1k?=
 =?utf-8?B?QkcvdHJIMmM5YmJjU2NyOTh6K0pZM1ZhSURZTlNMNVk0L0VucS9FWDhUVkEy?=
 =?utf-8?B?MlJ2bDhJWjFYQ0pGUmgzWDhGd2pMNVRXc2tPVFg4elZVZlIvNlVxWksvTklw?=
 =?utf-8?B?ZzVwY0dmRVM5bUdKYkpNdy82ZGNqYzI2NXpYOVRMQnRDN3BwcGdORGp0RFgz?=
 =?utf-8?B?ZkJrb0YwZ3Q2RExqYWZ5S283VnBqcjY1YjU4MmUyTE9ya1pGSHdpMWI4VmxC?=
 =?utf-8?B?WjBuTDZxczdCdlZsa2dtbVJNbURVQkl2RXQrVllSNmxvS29qOENhY3JBTjhO?=
 =?utf-8?B?OU5aTlBlWjBpdStkc2VsZ28zYzcremwxeW9hRXN4UG9QUVZsMlNydHBhcnlM?=
 =?utf-8?B?Y2l0L1pPNldOYzNkcm9ZeHNuOXlpV2R4RjBWb3RkQmM0Zm9jaGVYNFMweGJU?=
 =?utf-8?B?MDFiakppZUkyMjNiN01pcUc0dmtFQzROUGljcEpRaEpXL25pWTlvejJzeU5h?=
 =?utf-8?Q?qTWtPDsDRNhQZy/3mlrH2UtdQM8HLcd567dI1HI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3627624-02ef-4dbb-dd09-08d8e57f599a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 17:50:40.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usZo6rq1QFo2TB2Y+0rFcmUEuap0aLpgHJdxu74n0Qpd7lJ16bHVKNS0tmA/iSqiIuWphthdTKWJbk9JiVFFCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4445
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120134
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/12/21 12:15 AM, Michal Hocko wrote:
> On Thu 11-03-21 14:53:08, Mike Kravetz wrote:
>> On 3/11/21 9:59 AM, Mike Kravetz wrote:
>>> On 3/11/21 4:17 AM, Michal Hocko wrote:
>>>>> Yeah per cpu preempt counting shouldn't be noticeable but I have to
>>>>> confess I haven't benchmarked it.
>>>>
>>>> But all this seems moot now http://lkml.kernel.org/r/YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net
>>>>
>>>
>>> The proper fix for free_huge_page independent of this series would
>>> involve:
>>>
>>> - Make hugetlb_lock and subpool lock irq safe
>>> - Hand off freeing to a workque if the freeing could sleep
>>>
>>> Today, the only time we can sleep in free_huge_page is for gigantic
>>> pages allocated via cma.  I 'think' the concern about undesirable
>>> user visible side effects in this case is minimal as freeing/allocating
>>> 1G pages is not something that is going to happen at a high frequency.
>>> My thinking could be wrong?
>>>
>>> Of more concern, is the introduction of this series.  If this feature
>>> is enabled, then ALL free_huge_page requests must be sent to a workqueue.
>>> Any ideas on how to address this?
>>>
>>
>> Thinking about this more ...
>>
>> A call to free_huge_page has two distinct outcomes
>> 1) Page is freed back to the original allocator: buddy or cma
>> 2) Page is put on hugetlb free list
>>
>> We can only possibly sleep in the first case 1.  In addition, freeing a
>> page back to the original allocator involves these steps:
>> 1) Removing page from hugetlb lists
>> 2) Updating hugetlb counts: nr_hugepages, surplus
>> 3) Updating page fields
>> 4) Allocate vmemmap pages if needed as in this series
>> 5) Calling free routine of original allocator
>>
>> If hugetlb_lock is irq safe, we can perform the first 3 steps under that
>> lock without issue.  We would then use a workqueue to perform the last
>> two steps.  Since we are updating hugetlb user visible data under the
>> lock, there should be no delays.  Of course, giving those pages back to
>> the original allocator could still be delayed, and a user may notice
>> that.  Not sure if that would be acceptable?
> 
> Well, having many in-flight huge pages can certainly be visible. Say you
> are freeing hundreds of huge pages and your echo n > nr_hugepages will
> return just for you to find out that the memory hasn't been freed and
> therefore cannot be reused for another use - recently there was somebody
> mentioning their usecase to free up huge pages to prevent OOM for
> example. I do expect more people doing something like that.
> 
> Now, nr_hugepages can be handled by blocking on the same WQ until all
> pre-existing items are processed. Maybe we will need to have a more
> generic API to achieve the same for in kernel users but let's wait for
> those requests.
> 
>> I think Muchun had a
>> similar setup just for vmemmmap allocation in an early version of this
>> series.
>>
>> This would also require changes to where accounting is done in
>> dissolve_free_huge_page and update_and_free_page as mentioned elsewhere.
> 
> Normalizing dissolve_free_huge_page is definitely a good idea. It is
> really tricky how it sticks out and does half of the job of
> update_and_free_page.
> 
> That being said, if it is possible to have a fully consistent h state
> before handing over to WQ for sleeping operation then we should be all
> fine. I am slightly worried about potential tricky situations where the
> sleeping operation fails because that would require that page to be
> added back to the pool again. As said above we would need some sort of
> sync with in-flight operations before returning to the userspace.

Those sysfs interfaces to allocate/free huge pages will need to be
reworked.  One thing that is totally unacceptable with hugetlb_lock
being irq safe, are the calls to cond_resched_lock(&hugetlb_lock).
We will need to significantly reduce lock hold time in these situations.
I have some ideas on how this might work, but it is going to require
some a good deal of code restructuring and will take some time.
-- 
Mike Kravetz
