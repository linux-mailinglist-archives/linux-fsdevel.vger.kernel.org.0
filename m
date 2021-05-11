Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A703E379BE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 03:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEKBNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 21:13:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33034 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEKBNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 21:13:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14B1AlFv125114;
        Tue, 11 May 2021 01:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6hS9GIRR7BbfjVLkpDO4mDkpIkxNHmj71tBTZ6oJbEU=;
 b=zaRv+Nf9r+a2cak4ILkD9iSLbS/0Q0qZ8jIw5ZfTguUA7SaU8iiGyppG+IlvBO8010/G
 P4mf4o7K0nlDcViTnZ2e6x4Ifk0x+Sb1ZlpYldYWZIPwhXp0KthDY4qlf3tR4kHfcxB6
 Ek2u29PDjehut+7DLdmpY21FX3OvhKVsCwyvui+l8NPNViT4K/RaFrFvPGZDRKUUGDVN
 IiF27X01xZV9y0cnRXODgBfVbYvhZ0tdCZZPzpJmq2lI3LutLkb4GV/zAGOOlDn9Q2yS
 3xJw0hQBjltYO/Bk9t4OCloGwv3fu64VIWMXgzWdq7LgZ41l7ONMfD8U69w0ZME6Q/A5 eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38e285cagu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 01:10:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14B15ZNt136302;
        Tue, 11 May 2021 01:10:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by userp3030.oracle.com with ESMTP id 38dfrwd6vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 01:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbLbKzVO86sNvDAHNB8D7skkdDnpTi934VNhxlz7ZeUnqX9BKGiyaVsUz6MexjklXJpNLj7qolfR7TTKoZHdySkjwchWFFDwqRUu4gmZi06Cr5kZP6kC21Whqa668Eu4AvC70d3n/6VruQACoNmanhvFm7qZgJm3dqr8CckUthyIBeDChbrr7qnKJ0xnFQQjlVhTDlE3G6kLtKQvInYc9/6VajmHP9E9/EdULuXPaSA6AA4XiZF+nrylEotUd8y0d9yvgkNmUXS8Ava1CPnj2H6yL9Sre0X7HDDP3dW2ysNuUtQWd9Gxq/0FswghJom6pvplw3cyV7rdzktlQUghhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hS9GIRR7BbfjVLkpDO4mDkpIkxNHmj71tBTZ6oJbEU=;
 b=b2TAso/y9pdr5papcqvlsUbpChC7nV7Diu9zzJiDwHqn0paFUPXSfztZzTb3HRXhgiUwb/gFwBfNlwBDptFB1mfSLqFs/UxkWSvCYoYX5Lzi40zpDHEhXSRHIji8ANCJPB9nYTuRQANnXTnLTiE2Dh/i+W2DDlq2Q5QHKlyOAY5Aa5aMQGfAkfMeGpQs36SIvvEEjNPSrwVnRl9FN3cySPhwmr3fbFHGPEcqtHkGmSETuHD0CS4P66zl5hB1dyAzb41Snr1hZxY6fYKUvTVdgx6hzRutTNbBe546nsnEBl18qVkjPfjKWi19pDIW+VNToDFUko9SUefEeEWjrT6ryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hS9GIRR7BbfjVLkpDO4mDkpIkxNHmj71tBTZ6oJbEU=;
 b=N6HFFjKmwPyCjB+v5UUdyxpYLqba1nJ8JOkesk0YRQdtchr91MFF/Kjo0R6oLZuNS7AYLdR8mcjv67a/+3vZE/ox48DLSklR4fE8iYrY+0EgK39NAjGL8Mwnf9nyke6mfzKxw2TIe5J4U8onSqXxVR0ViIhwM8NQd7qlMGLx6S4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3494.namprd10.prod.outlook.com (2603:10b6:a03:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 01:10:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 01:10:43 +0000
Subject: Re: [External] Re: [PATCH v23 6/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
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
References: <20210510030027.56044-1-songmuchun@bytedance.com>
 <20210510030027.56044-7-songmuchun@bytedance.com>
 <20210510104524.GD22664@linux>
 <CAMZfGtUrYismcOai6zsx+X+Mixy=uUtrWU0CQJLxJn8kcfB+8A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <188b3f52-05d7-7fe8-70e0-88009d7d70b8@oracle.com>
Date:   Mon, 10 May 2021 18:10:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtUrYismcOai6zsx+X+Mixy=uUtrWU0CQJLxJn8kcfB+8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:300:16::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR13CA0013.namprd13.prod.outlook.com (2603:10b6:300:16::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Tue, 11 May 2021 01:10:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb31f344-8587-4e37-14ea-08d91419998f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3494054C232D61A719703C9BE2539@BYAPR10MB3494.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3pdoP3Pw3C8L0txT9qRMuIodMWlLoTLwuAeUHJQOeJN5CvumqyO1lx4ewfk288MKPaHsBSlCLfFwNKMY9byQJit6csq9MbZp0ldeT/6lhlttanBh1+7gANwv9R90WZeuaLmOxuXu+3ZECS9qGR+9M6QECKy4LSgVGhguk4sBqrks6Cm1eK09PuM404Em8/0mYbjgq+L+Uae1tfsEJ+8W5nEY6QSJ2HyaT5HW9En0EnXAGAhtaqZATMA8p4mHtaFff+oeFjLL0jPsBLzmotsS7SE/iMESIVz8M+7wmzvdZwW9LpJyykjllTQEaxKCZZ8lzDv69bS8ZGkipk2uDtbrGXk6BvAA8ar/JpS4e8Sv1z14Jtrjd6jyYzskggmOvvaOf5J9pW2QQablSvxK4go8aHBwKq+4gvyhLXJHFCBT9pcLGfisMKhEe1KsFH3i5/8srQSqSBOZcUljlEwKwPrx+ru4X9gWs8MsZdUC8U5ICnENhQScD0a9TzrvXagXNXINpAu1CqkXh/DGlauAMa3fM/+Ca3YBW9AXGRptAN6op6T8l+exHAz1ONHD8OkK2sSYPN/jthS9yQxaRZUbFjeM+QFnDg4nS394IquLRHDx6bR5FU1jn8CjSYPmr32v6hh5xXFevL5um1gpeeorLv7w/1x+bJ1HQrUzg0q8MvxmmFa121RgSvorfgOYqChPRww8V3R/pECBobeJ0XxJnwI9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39860400002)(6486002)(8676002)(16576012)(54906003)(316002)(31696002)(31686004)(44832011)(36756003)(2616005)(53546011)(52116002)(956004)(26005)(5660300002)(16526019)(110136005)(478600001)(186003)(7416002)(66476007)(66946007)(2906002)(38100700002)(4326008)(7406005)(8936002)(38350700002)(83380400001)(86362001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aTdldHVEcDlWVHlzUHdRdHhhTWRQTXBpOWk2VUlqUTRJOFNyYUlPWHpuZm9I?=
 =?utf-8?B?K0gxcDdPb3Z1aHczQVFlemRBSW12YlNnTXEzRm1DSXdGVzBBUzlYeENMMXll?=
 =?utf-8?B?RTNNK1NFQWJjUk02VnBoRURqcmlYMGp4RUdyd0JGUXYzdFh6T1A1WEplYnIy?=
 =?utf-8?B?NE5zMEhwcHhhZEJnNElXT0ZoZFh5WDVVVTRFWmpJZDFCbDJJZHUvbGNUaSs4?=
 =?utf-8?B?b3N4TXQ1aWtjTW80ZjYyY1BWNGtUUFZTaDkyV0d2MFZOcjBIRzVJK29LakZR?=
 =?utf-8?B?bEpkUkZ0UTFFK0tLNXBzc2FRRjE3UXJPcERZUGpDNjc0WDZuZ0FWTzUwMEFx?=
 =?utf-8?B?MGNVamJIQkFvVHVvOGwzTWVjZFd4OXQzVnJYSE9Yb0t0dEUrZDMxalJNeUZI?=
 =?utf-8?B?OVcxNFFFcjVReFdLamVER1dOR2d5ais0SDQwMVNBTk10R2tOWmVOeW1OTVZu?=
 =?utf-8?B?NmJCV29mS0p0Ri80WFRTWmJnTGQ1eXJ5WFVpcEZZNXc4NTBvaDR1MG5YRkcw?=
 =?utf-8?B?MEFoWXdaMnlrQ2YzMjlwVS9oZExPUmN1WEVlRk10REtaOVFQZ2xjL05iWXAz?=
 =?utf-8?B?bndCYnZ0aFUxYzBrbytlWEwwMU51SlkwWmI1bk9KZml1bEJEN211TjVjT0hy?=
 =?utf-8?B?dFRJa0plbUwxYjhGb1NLMEtvZENtclZDLzQySEpzYWF4SnR6a0puNWx1OUl1?=
 =?utf-8?B?SzQ5RlI4aWNKYldaT09LNDg0RzFlQ1g1V09lUTV1dlN3RUt3V3VVV1Rub0NV?=
 =?utf-8?B?bTM3dlVyejBiRFJ1aU5KVFJjUkxRaU9GUFJiYXZiWDdtcUI1b3ZCbU9PVlRP?=
 =?utf-8?B?b3dyd2JNdmREOWpTOFhMaGtjMkgvMG5ZNWEzR0ZhU1F3VnN1dEtpT1N5NmFT?=
 =?utf-8?B?MDBTTU1ZQ0ZxNFdESGFTb3NaRlJxUUhQVlBXSmJKcng5eUF5Mkk5QTJMeGRS?=
 =?utf-8?B?Qm5wUlpPSkxFQlhCcW5sU3prdTVpMkhzalE1eWhOdHRiU0NyUWk4SFhpZFow?=
 =?utf-8?B?MTRHREVsb0V5dG1vVS9pZGtPUHpZbExEK2F5ZHY1LytrcXZLaWZrbWFEYkJ2?=
 =?utf-8?B?TUk3S2JPeTBSWENCYWppMmRXdm1WbmVZaFpoOG16UEl0Vmwxc05qdWtkMGt5?=
 =?utf-8?B?dXhtRXVYcm5FcVF4cVNBcEFQdWhFdXpOTTg5Q0IxUWQvWE1pVC9qL2ZmenNX?=
 =?utf-8?B?RHo4NmJKdXJBc1UvUGRZMW1ySENOUXVVZFhsams0cjRrc2o1ZGxISHMxYlBQ?=
 =?utf-8?B?TUZsNGFvRmg2RWJ1L1Urdmt5RTJQVGVkWE9NZnBkTXJpc3JscTcxdXdmb2Zt?=
 =?utf-8?B?WWJxcmNtczhoZGpyQ282aHEwYWdGMnlXNGptVXNPam1kSDRFRHVjQldHS1RM?=
 =?utf-8?B?QnFQUXRkUkVDMHVWOFZnMVJCZkh5eWFFYjkrUHJhbVpBbnY1Z2VZem1wVm5Y?=
 =?utf-8?B?bzVjREZzWjZiWWZtKzJidURKSHh6WGVsb0pxS3E5cHJRaHBweENXMldVamdy?=
 =?utf-8?B?U2JUaGwxUS9OYUNobDIvZlVrSGFDaDVZY29iVXJBc3Z3ekxkZXBtb2tnYzR3?=
 =?utf-8?B?QllESTZ2K0w5QjE4NWQ5aWRMaWlSK3lnVENDcDRvc3ByWGl5bVc4b2Y2cUhl?=
 =?utf-8?B?OVVzTTVkL0Y5MWpBWXBwdlZEci9URnczbWliangyenlPTSt5K2U4dnU0cUNR?=
 =?utf-8?B?M1NJSTFsYVBuTTM4bEhqWU9YQWRWMVkvSEdZeG5RR0hMSnF4SHNvUGVwOGpG?=
 =?utf-8?Q?wG7ZWgP8Z8MMF94HMFErcNt+uoyR/m6BDvyN2Ik?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb31f344-8587-4e37-14ea-08d91419998f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 01:10:43.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DG1B1kNS9Nsj1ARTTLp94HbVs3JSkTW6XB46NfEQ6UoOY0doHFBCC49/TopmcnOfmTdRwmmDwd0fqnYz+JXUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3494
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110004
X-Proofpoint-GUID: Mt3O7UaO0JmlT3Gs3aDUfpFdoFROjkPs
X-Proofpoint-ORIG-GUID: Mt3O7UaO0JmlT3Gs3aDUfpFdoFROjkPs
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110004
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/21 5:19 AM, Muchun Song wrote:
> On Mon, May 10, 2021 at 6:45 PM Oscar Salvador <osalvador@suse.de> wrote:
>>
>> On Mon, May 10, 2021 at 11:00:24AM +0800, Muchun Song wrote:
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1376,6 +1376,39 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>>>       h->nr_huge_pages_node[nid]--;
>>>  }
>>>
>>> +static void add_hugetlb_page(struct hstate *h, struct page *page,
>>> +                          bool adjust_surplus)
>>> +{
<snip>
>>
>> I think this function would benefit from some renaming. add_hugetlb_page() gives
>> me no hint of what is this about, although I can figure it out reading the code.
> 
> Because I think it is the reverse operation of remove_hugetlb_page,
> I named it add_hugetlb_page. Do you have any suggestions for
> renaming?
> 

FWIW, I am fine with the naming.  As Muchun mentions, it is the opposite
of remove_hugetlb_page.  At one time, I created a function with the same
name to be used by set_max_huge_pages and other routines which add pages
to the hugetlb pool.  It would be much more obvious than the current
code path in which we call put_page which calls the hugetlb destructor
free_huge_page to add the page to the pool.
-- 
Mike Kravetz
