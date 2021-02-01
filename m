Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C130B3A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 00:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBAXoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 18:44:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55406 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBAXoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:44:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111Ndoih028154;
        Mon, 1 Feb 2021 23:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Lo6lRtBvWPzycM+EVZElZRRV7xRUHZvpeQCm7FDkkbw=;
 b=HXNgxmV6M4xwvacDQqwI5QT2XjrTfx6ylu016W4PDb3NTa/wWpNfiXAGXeq3N702tOEm
 jV5abh7kEvotl2PA3vAn3kRNwqE90CaPTJKxUa3nSmomadnqtbkWpRiotaE1KEnvLk5c
 JICmyxDn232Mu61kuNYxrbMN1kmI2Q68hRHRuQa08VRBkB7VhyD3RA9f/ibFB1QzmAWa
 AMARjvY4wcpMShXJY032Wem/MtmO31tTwsH9VCLA8zaGYIVU+IPvaaplJmojr+alQ+pk
 etdTpHDxz+kpqL8jd+mO4lF8hyuvDjskuCs7H+SjKMu8cH+sOlnIMRXR+6oncn1MJk4r CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36cvyar9fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 23:42:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111NfTFl189972;
        Mon, 1 Feb 2021 23:42:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3030.oracle.com with ESMTP id 36dh1n4kfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 23:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRcMlWDsVQZ5y4A3ndKEEIWS8lrifGM7WYtZ+7WU371lkkeh3pKEwHwEMVMWwSF9xjxvQGu7/Ci/J6xmhENn/4XQMwocM+WTQ11o5R/psPN2FuvRhRK/9hn3tOEmVyv4eoWp3n+biYVnOgKRk6NajToe/WYHN1fpOcKy2E5sDjUiAWrqJqiSdLKbyC6X8v/zP42MKHEtGX8FDuqcmyVQ38JmySD0K6OY7TA/9GV9AWtOl1/P2GNmCXTLJND1TwP2ZRy82y3pcS/IninooshRshp2/pzh81jO27Ssq7xKGV1oSXMm9QEn08Vf71jAlEyZcDCkDa2RK6ViKEYNbGzRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo6lRtBvWPzycM+EVZElZRRV7xRUHZvpeQCm7FDkkbw=;
 b=F/5dvEib7oArdaqSY4tAee/M60nDSqYtFf03RUDzbEBKaeqsOtb8iYL9V38xJRE2ioiVophPvIJC44H2BVy4nwY3CxD5oS0G2O2X1jEGdt7VIOJLbISYKckDWdmkkG4HkOiQNzH20HXxUJQjfzopSdxeTFKEa8JOdmj5xtfqbEiCqghxELHriyAXw/BWW5QtG/58AaYYV5gqaZlb801bpLCiAXhpH9A7nAJiwrEF5OL5z9G6+W1rX1yPnlDqnH6EzqHk7OyI1umVn4MEkAPOxZb2eHZ9Iam5hiuQn77wrf+mz/tn4rBMvRdNxL/FMH2zWamY/CCCSg49rzMIFPwFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo6lRtBvWPzycM+EVZElZRRV7xRUHZvpeQCm7FDkkbw=;
 b=cVkAK4gSlXf3IcNk+DXkfahasebehwx8HaoCI4zfk/kxGdH/ooHfkWqgkfkeMO+LvGX+8bPJEssqbQZ97jqLlPKZ1h/k0VZK/XAPCKIVY2a9M3pvmMv3jVYDJhJRPSCg3UJT1lZkaDLpU51eCErzgOXPOfYk1DI6a1ak240vaC4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1693.namprd10.prod.outlook.com (2603:10b6:301:a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Mon, 1 Feb
 2021 23:42:05 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 23:42:05 +0000
Subject: Re: [PATCH v3 7/9] userfaultfd: add UFFDIO_CONTINUE ioctl
To:     Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-8-axelrasmussen@google.com>
 <20210201192120.GG260413@xz-x1>
 <CAJHvVciv0-Xq75TKB=g=Sb+HmwMdJEd+CHg885TWX2svYCwFiQ@mail.gmail.com>
 <20210201224034.GK260413@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1b26bd45-085b-b249-a1f6-beefff8648a6@oracle.com>
Date:   Mon, 1 Feb 2021 15:42:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210201224034.GK260413@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0031.namprd11.prod.outlook.com
 (2603:10b6:300:115::17) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0031.namprd11.prod.outlook.com (2603:10b6:300:115::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 23:42:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98f82ade-18de-4288-2c16-08d8c70afac3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1693:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1693DD516E2154D6151273D2E2B69@MWHPR10MB1693.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HX02Q+ijQEBFloJbHlhJGKdjoPVN9X7uW4JHZyhbLtXnOLJs6oNxDauUD1EG7Qq+a01nB31kOIifRh21mhpSOs33fwi8QUE/+A8jHtmC8vWsBOe2IyyUvHDp/+O867lfCwgrGZdU5TIG+zd/jxZjqu+2oll4NMoL1008LH6MEDX+PoIDDuk8NOp0CDPA07M8U0EPltTr1vxT92TXPxlMBmpu6AwL3TvxC9HkkPpAyMXQx5DIBZABiC6V/f5moTq7uQYdLpr9IeaHSD3/M61UsJVoukjpLQ2L03vdf93qNj+ajZsxllf21wse0bWOPHNWdykw6cJ6VM1LW/pEa2BBvrLiJSCKRADtNxU43Jram/hsHLz1yEts0zxsO5+s7r6Sa/2GUS19urZACrv5x/Y1X8G+Sf376IKjcyBkSOJe57sMrmQRRSlk20NyFHBZEPkzf0118UGchwJIJdLkJlti9QtpxmKQBMU0YSQAeeAEHR2LvTq+Gsc994fAAmDmQtnyeoeHKbO2WuYC1yTC/pu9ap3gUaUZhgUsbmwRZb7JNuULfNyBJYE6hcBjjwb3/lfvX5hg6SeKyvDx5/Ko/NZV1vOvxS6tQ4AtKT1j78fPpVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(366004)(396003)(2906002)(31696002)(86362001)(5660300002)(8936002)(53546011)(36756003)(478600001)(2616005)(956004)(44832011)(31686004)(83380400001)(4326008)(7406005)(7416002)(66946007)(66556008)(66476007)(16526019)(6486002)(26005)(52116002)(8676002)(54906003)(110136005)(186003)(16576012)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dkt3TE5CVTdtbFhGK1RKRG11YWFRWkFha2NVQmpWVlVZK3hmQmlUVWhyZjZs?=
 =?utf-8?B?T3pEV1VJd2wxaEFSMDhFTDhITk9PenFFVWFMdm9JcEY5T1QxOUx6RHRsa2lr?=
 =?utf-8?B?RkM5S1BrUTJPSHlFYmFudklJV0dyQVhLR3BuQ0EzTVp2ZDQzdkxic0MrVWdC?=
 =?utf-8?B?emRGVzZLWVBFMjA5WEVzcGR3elBOUnU0a0ZibDZ3T2FWQU5PN3VIRnVXN2Vw?=
 =?utf-8?B?SUtnSzU0bjRwR2dka3FMbUQ4MHBOMWloL3NTWEd1dTMzUklURzI3MklhZDBN?=
 =?utf-8?B?OGp3UE54OGFYcGhFeGdZaG8xL3RIZkJERXNvb29NNzluWWd3a096ZGpmM3BL?=
 =?utf-8?B?SVBWbjdKazRONENESTNVZHhnNjI3MWFyaTFIc2xwMHhwVldySExNRlBkRnpm?=
 =?utf-8?B?N0NQUGQrNEZmenZlZG1SNzNaWmk2UVBteWcybGJZTXlscHhoWkdpcFFYVld0?=
 =?utf-8?B?NFFLWlRIbkZlMWFLTFVYcDhwTHdLM1RyTVBCVi9rQmg2QU9LS09tYlV6RzVr?=
 =?utf-8?B?SVM2WTJxbVVhdmN6WFA4ZDVQTDdGTWhuSkhySnBBU0UwMnE1Nkg0UTRrR09E?=
 =?utf-8?B?VVZQRVE1a080U1JqQm15dU1QM0tySzg5dTcyMmdiS0dXMWZMaUk3aytNL3NR?=
 =?utf-8?B?eTlDTFVEdG5IRVlzMU1WM3ZFYnI0MXdnQVl4elZkaGRwYlphVGRCVWQvK09x?=
 =?utf-8?B?ck1pSGZjTjYweHNMOVo5Rjg3UllsL0ZQWVhnNlhNU2VycFR5dDM2aEVUcFhT?=
 =?utf-8?B?eU1wOG4rTE5hTHBDNmxxMGNoWjNZKzNoSkI3S2dGdTI5RTBYSkE5NHFNWnlH?=
 =?utf-8?B?elBNaSs4eGJiSXh4cDVMVXhELzlRNkVjWWJxTmlUZ1BQS1hDdDhYS3oxbkdB?=
 =?utf-8?B?cGc3TFNSekM2ekxLQ2QvRWZuNWYzM1BVTUExOHM2REsxNUhVYUZqbzl4UGNR?=
 =?utf-8?B?MWJ5bmgyUk85MXM1TjloWHFrNkVROTJKZ09rdE1QaTFDV3JPaUdCNUtzYTBH?=
 =?utf-8?B?TWFjTlRESGZQY2pORXI4R3hSR1o3aGozd0MrcXlJNzNzU3V6WENIaTJZWmZJ?=
 =?utf-8?B?MWZ1QVJKRFpiVk93YWJZelNiTjZPYUhJVkR1elJIZzRBRjdDekhEUnpnSUNS?=
 =?utf-8?B?eHEyMVNxUVhTYVJ2VnZ5ZDRpQzJibU5CQ094cXpPMGEwOUk1cEZDcjdCelNl?=
 =?utf-8?B?QkpqNmRERHkybUR1TkJ6MU5aUnp0QWUyZ2xLaitDWkcrSjJuT2s2UTBHbWNV?=
 =?utf-8?B?dXdod2paWHpaYS9jMmptQ3lTN21nMUFiZStFVm1vY0x5TTNOVFlqb1BrbWZC?=
 =?utf-8?B?bGFGSjI4N045bmxiVzRzSXZ6OHRuSUo3bFJhQ1NLVDc4Ynp0VWpmZVdGanYr?=
 =?utf-8?B?OWpKakdrV2xid3JmZDNiMDVrNzZsYWlnY2xNODNRSGdVWVB6b0J3dlVRclhs?=
 =?utf-8?Q?aQqTRtug?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f82ade-18de-4288-2c16-08d8c70afac3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 23:42:04.9217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzZ4G8QhtYgd5kdXmLzCyP69o3yTqizI8YpRck4UXgxeBqh4iEk25+bFysF5DwZ6au4sUiqCbycj9clfMe0ZJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1693
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010132
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/1/21 2:40 PM, Peter Xu wrote:
> On Mon, Feb 01, 2021 at 02:11:55PM -0800, Axel Rasmussen wrote:
>> On Mon, Feb 1, 2021 at 11:21 AM Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Thu, Jan 28, 2021 at 02:48:17PM -0800, Axel Rasmussen wrote:
>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>> index f94a35296618..79e1f0155afa 100644
>>>> --- a/include/linux/hugetlb.h
>>>> +++ b/include/linux/hugetlb.h
>>>> @@ -135,11 +135,14 @@ void hugetlb_show_meminfo(void);
>>>>  unsigned long hugetlb_total_pages(void);
>>>>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>>>                       unsigned long address, unsigned int flags);
>>>> +#ifdef CONFIG_USERFAULTFD
>>>
>>> I'm confused why this is needed.. hugetlb_mcopy_atomic_pte() should only be
>>> called in userfaultfd.c, but if without uffd config set it won't compile
>>> either:
>>>
>>>         obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
>>
>> With this series as-is, but *without* the #ifdef CONFIG_USERFAULTFD
>> here, we introduce a bunch of build warnings like this:
>>
>>
>>
>> In file included from ./include/linux/migrate.h:8:0,
>>                  from kernel/sched/sched.h:53,
>>                  from kernel/sched/isolation.c:10:
>> ./include/linux/hugetlb.h:143:12: warning: 'enum mcopy_atomic_mode'
>> declared inside parameter list
>>      struct page **pagep);
>>             ^
>> ./include/linux/hugetlb.h:143:12: warning: its scope is only this
>> definition or declaration, which is probably not what you want
>>
>> And similarly we get an error about the "mode" parameter having an
>> incomplete type in hugetlb.c.
>>
>>
>>
>> This is because enum mcopy_atomic_mode is defined in userfaultfd_k.h,
>> and that entire header is wrapped in a #ifdef CONFIG_USERFAULTFD. So
>> we either need to define enum mcopy_atomic_mode unconditionally, or we
>> need to #ifdef CONFIG_USERFAULTFD the references to it also.
>>
>> - I opted not to move it outside the #ifdef CONFIG_USERFAULTFD in
>> userfaultfd_k.h (defining it unconditionally), because that seemed
>> messy to me.
>> - I opted not to define it unconditionally in hugetlb.h, because we'd
>> have to move it to userfaultfd_k.h anyway when shmem or other users
>> are introduced. I'm planning to send a series to add this a few days
>> or so after this series is merged, so it seems churn-y to move it
>> then.
>> - It seemed optimal to not compile hugetlb_mcopy_atomic_pte anyway
>> (even ignoring adding the continue ioctl), since as you point out
>> userfaultfd is the only caller.
>>
>> Hopefully this clarifies this and the next two comments. Let me know
>> if you still feel strongly, I don't hate any of the alternatives, just
>> wanted to clarify that I had considered them and thought this approach
>> was best.
> 
> Then I'd suggest you use a standalone patch to put hugetlb_mcopy_atomic_pte()
> into CONFIG_USERFAULTFD blocks, then propose your change with the minor mode.
> Note that there're two hugetlb_mcopy_atomic_pte() defined in hugetlb.h.
> Although I don't think it a problem since the other one is inlined - I think
> you should still put that one into the same ifdef:
> 
> #ifdef CONFIG_USERFAULTFD
> static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> 						pte_t *dst_pte,
> 						struct vm_area_struct *dst_vma,
> 						unsigned long dst_addr,
> 						unsigned long src_addr,
> 						struct page **pagep)
> {
> 	BUG();
> 	return 0;
> }
> #endif /* CONFIG_USERFAULTFD */
> 
> Let's also see whether Mike would have a preference on this.
> 

No real preference.  Just need to fix up the argument list in that
second definition.

-- 
Mike Kravetz
