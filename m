Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694C1365ED1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhDTRuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 13:50:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60820 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDTRuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:50:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KHUB8S099239;
        Tue, 20 Apr 2021 17:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iwDgPb9t2QyfLDopxi1FFx4bZZSwgaKGgsJrHS37Gf4=;
 b=pqqYKzDPLXrkSHJGg2ZZ19YQ4J/I96eom308W2BLSREtKRoHu0MjarUQtFmNZruiVhS7
 P7YLtScnI+TS5ODHDrgs2QmtMg1HJD+v+j2xzEyCoSpRU9gPARzfbJLFTfIEVMCf+OYi
 L+lSHGy6OLqywFp3m1cZz6nsrxOKaKbkkOiq58yckuY6SAJbkVWK2ytpA8bqs9OkYZJe
 XRNo91XzfSF6roEHteckdCgqvQegq5DGGRwdQD0EkxKObpDtIuubrAh/wUi5C7Sasxaa
 WFJEaHFjmQxjW2r6hExrbO9LdLZ4MSWN2FhCNtL3aKy38bb9haRPbFJGtKRLtMjQBfN+ zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37yveafpmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 17:48:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KHTtKh154358;
        Tue, 20 Apr 2021 17:48:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 3809et1q4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 17:48:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egymstaUHrYAn81hO8O74UtC3CEaMNxvvfC4734MJ0GKz80D5e9Mt1g6aG+2FXuN7qvcYKyyVp0kUVffWYOupzmoGiyDyPTjWRHBhKiumvljgNv0iGKNIrUbDWI2r91cydyqkPDtjMNwHOy0AlPSE3pVekUrynTbHF3B8x96j5wBTaoRttC4K7ueTIV1PAIYuIVjbkQmRRwA1n2cEpx1wn0gqVY8rJ3F88sp6gMVftClvYr5V7mMQeBTd/BLw6a4p2UJmcciMjt53q1b+AnzY3yJip/gz1uyJhzYieKHYHvyl/sW8n664glaWtSypAR7les3J/mHUjr2rD/Kg+4Ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwDgPb9t2QyfLDopxi1FFx4bZZSwgaKGgsJrHS37Gf4=;
 b=fOCpZMlNMz7PRhr3JCjism7+zlZUQJtojwgREllC1xFpvaDdd4Nm2uFfaBPbnIze4cd5wX0Z8c0WiQjX8fCLDZ/LD2io4+fn6uAyBdNb3hzmsH24cWTifICX1Trc5cIROTn2V4xIFVGKDM+Io3gzJB15LsPNSzXWsdQpCum5gHWmNtW/+Q7ov5Sqpe6NGMjD2ZPBqhfwZbX1u0OENCuE0uUGdCvvZY4vUQuLMdDEdz2vMyk/9SilYjRfXjruQm7/M0gL/f5No7wZCmmxZ995ZAIVQSsVpC7p/vISw4s+YhAV8V5aNL2yIbyVT55ciucu4gALc78AFVEy+TmXI5Ojng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwDgPb9t2QyfLDopxi1FFx4bZZSwgaKGgsJrHS37Gf4=;
 b=aQ8bl0iq+RVzqtl846vXShKkY7nvCkS1ZyrIOtDC4hut/lagHHbgHIBEDoo1ertPTkftOXVGCiYuxMJ0LrR538XuSWwaVry7v+6zIWsd3c68pMCg8SonX7djce6EwR1RBBpI0c37R4CXCe+ookPmH7jqnoDyRyRwPwo0DvN57/A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3810.namprd10.prod.outlook.com (2603:10b6:a03:1fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 20 Apr
 2021 17:48:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 17:48:37 +0000
Subject: Re: [External] Re: [PATCH v20 6/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
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
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-7-songmuchun@bytedance.com>
 <5f914142-009b-3bfc-9cb2-46154f610e29@oracle.com>
 <CAMZfGtV+_mNRumR1RBWiu6OOqhUsTZyBvp--39CJHEEFKMX5Eg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8de3d7a0-f100-5d50-fe54-b83af07570f4@oracle.com>
Date:   Tue, 20 Apr 2021 10:48:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtV+_mNRumR1RBWiu6OOqhUsTZyBvp--39CJHEEFKMX5Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:303:114::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR02CA0036.namprd02.prod.outlook.com (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 20 Apr 2021 17:48:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ff2a580-955a-4677-4e62-08d904248687
X-MS-TrafficTypeDiagnostic: BY5PR10MB3810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3810E2434650A6D3FF6F72C2E2489@BY5PR10MB3810.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZN8TfGd5ulr8UE7gryvUJpNcxnN0ijFCRrWaXUpHZMq8w9HLEQShFyQ+rn6GatbOskFXwTTRn2OvrpJXLHmVdp65uxl3aycAYca+lVuZjhBm9aNCc5APsQwVL799XTGq3VMysGMhgWmqNtT/xt7DTV3J3xhAIwK8RloOlDAaWo/PF1aIzfQVKYwEwO1AZZo4fYltswDfIC34WJ2HHWEX2fDtH+v9fq0767uJLiEdYWm3IItCF+hQJVOattqcSw4baXrjrRm9PGHFfnD7Uorag7rhCQ8f1I5VOKT9k30uthSapcsFZVW4YB/32zo5f/j1oQJP+226tryrmqu5DIR+PK/FaoOl77ZQOfr4d12oEIwc+u8IcajB76w/yw/tueNYVf0Kf9ZQ8kRrdJ9u7gTQXMaAm0xMx0BCcazCNWxzkYKUcggmv/UUWhW1qxy5vJa/BAHmqtOFc9QI1cKTbunsZmcoGV+T1RM+KkMXtCWJut8Eun4SLeK9OY+vKjNnheMR6tME7Bib3/ExvoJJBG7T8D4IuA374zLpAf/5g+jUh2UYQp4ZkUfAIRum+SuEcCoNDIocblnQz214YE2ikh/loGAt3olej2Q+VZquEvfChDlIoh1FkSQYDVEJksetA7cOJQHP06wc2rQn/6GR1qCdDPicraTKc7ZeHJBZDJ0Uf497ngDSEGoAbdhs88Pw8rEZwNopC5KoFXwUArnzCRR9LXxF493+UguFuhQTnDV2mMs1laYJVSuJlHmLcvE3brj++0koB7+22w5uUItTlO5RDAcvTHkeaIdVdvvs9PjoFBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(7416002)(7406005)(31696002)(86362001)(31686004)(6916009)(8676002)(44832011)(966005)(478600001)(36756003)(83380400001)(186003)(16526019)(2616005)(956004)(6486002)(54906003)(316002)(2906002)(16576012)(26005)(66476007)(66946007)(38100700002)(38350700002)(4326008)(66556008)(52116002)(8936002)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bWttbnE4RVhtaVQ1Q05IZFdtUXZPRE1DUmtlcXNQUkF1cnpkUGZXQ0dTdkp3?=
 =?utf-8?B?bmdSVXNOb1hkS3JBMmtzOTlBSzBWcnFiWUJWMXp4UTdnaG9PMUxHTmpEc0tS?=
 =?utf-8?B?aEQ5cFBkVm1iVjRGUnl5WmdSTTd4dGJoaGRuV01FK0c2Y0FKeDc1MDNjbW5F?=
 =?utf-8?B?NG5zdWUvUmYrVXJURzFXZnF2Vm9kMlpoM1hhYTFWNm9nU0Zvd0d6NzJNUG9r?=
 =?utf-8?B?d0huVFR2UGd5SHNoNVlHZ3k2ZXFSTk15bTBNcVdINEk5RU1VRk1ycElOOGFk?=
 =?utf-8?B?WVJLOGZYYjU1bXkvK3h6RWQ5K2hzTHFudkRpVGpYMWVYbllrYS9ZNnRXMGdo?=
 =?utf-8?B?S2tJMzh4R25lTWtZTTBjMkRIZDcva1JiTXdGUEIxNzBVQURFT1VIeFBzYVNh?=
 =?utf-8?B?ekJ0emJSdjAxTFQ3KzNWeXEvR1loVGI0dDBjL2RpNFlWVUoyZ0JJMU1RUFVk?=
 =?utf-8?B?bHBYbGFyd1Y1Y0x4M3BZa0NqRUQ3andyU0ZCZzkrNVpudjZRdHlya3VxSmwy?=
 =?utf-8?B?RW83bEJtRGlJUE5pb1VJc0hzVUdDMnlmbFkyeGxLaTh1SzNUeElqb1FvemNk?=
 =?utf-8?B?ZGtMdnBWbGpVRWVzbzRGRHBTVGV6SzN6ZzJLczc1WTFPWGdnTmZRNGJGeDZi?=
 =?utf-8?B?V2Y5QzFXZ0s3bVVZTGUvaTZkaUtNUlBRZUdDb2NKaWk0ZnEwc2JoekE5Mk1T?=
 =?utf-8?B?ZHFldXM1MWt0bnZ5UUtnYWtJd2Y4aCtDVTlIMitnQ1hmNHNqTDgyeGowSGNW?=
 =?utf-8?B?eVZQWDJaem5BUmhJU3lsZjIxb1lLczA5SUlBQ2IxVUY2UWRheEhvWW05bS9W?=
 =?utf-8?B?dWtvR29YNkNwUlpUZzFZK0RwNkJtUVZiQ1NmbWZJOWpjazFlbVR0S3o4eEhy?=
 =?utf-8?B?cTA1amxhYXNOelJzYVVIUHArYXovV2Y0Uzk0OENYbUNsYlppS0F2bHk2amhQ?=
 =?utf-8?B?QWNGM0lWMVNFL0tkY2dWU0VKd3I1dVZIK01xa2lxeER5NU9sb3pXZDFDL3gz?=
 =?utf-8?B?cXU4UEdsT1VmbGVTbUg1dzJDcXFESHhQNDVyUml0Mjc0Q2FhM0FWbFR3V0NN?=
 =?utf-8?B?YUpmbmQ1TC84azdwWSswc3JxbG0xL0ZHY1RsZE9kSEVjVDVqbEdOYkM1ZVpn?=
 =?utf-8?B?cFlNM3dMMzFxcVIreXhCVjMvVWNCc0xDYWdIaCtMekRJeGFhUzlDZ293akZL?=
 =?utf-8?B?Q0xpK0hnOS9adGpjbnVaZ0F4Qk5IcUorMCs4K3pKc1FBdnd2UTk1RzloVlZK?=
 =?utf-8?B?SFBkNGJJQ1JscnROUmYwbDRUb0pyUk5hYlRtNTBzaDluVVp1REhIZUdEV2wv?=
 =?utf-8?B?cnVPUlNFTmxNSkhDYjRBU3NQVkM5OWlDT3M0T2lzNkExbm5nTmYwMGdxeEgw?=
 =?utf-8?B?TW0yN3hhM3d3ZFdLMVE0ZG5iemhTWEtpQXFxUVN3V0FBS1FaU2owdHF1S1py?=
 =?utf-8?B?b1I3UWV3MDVaUW5pZ0ErOVRRQ1FvK0ljSTd0aEZLQzFBSnVBdXNPQWFrSnA0?=
 =?utf-8?B?YUNhMDdvYU1XVGtlZnJkZWU4ZkFKR3lTK0UyRUZsaDhXY3RVVHdHZkRhMkY5?=
 =?utf-8?B?Sk5USTdRaDF0bUlaZ2ZwclhqcTFSU29NaitjMGxxRHk5SmxQN1l0MDFCM0RL?=
 =?utf-8?B?Uys1dU5RT1NhbjY3L0JRUStEZzQxYm1hVXBMdGtYSmZ3MFgxRzlBc3FJRUJT?=
 =?utf-8?B?b2NmWlI5Z216Qk9vRUlnTDNWSUxia2IxMGEwMURYaXg3QlVlNE1PQUNMSEtk?=
 =?utf-8?Q?hUQN+nSCLdlUcylgfqKZ07SJO74CR4A84fJ46IN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff2a580-955a-4677-4e62-08d904248687
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 17:48:37.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyOevZ5CYdBK5/lvBsBDkE2Y4SOdb8i1mpAIpqJ+AS2Uy7hJ4c87OY+BQUHXw4NNk+Q235l86/YWOEYakRVD8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3810
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200121
X-Proofpoint-GUID: 4FihcqQlNM4xkRm7WipGlhpFfyqtfne9
X-Proofpoint-ORIG-GUID: 4FihcqQlNM4xkRm7WipGlhpFfyqtfne9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200121
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/20/21 1:46 AM, Muchun Song wrote:
> On Tue, Apr 20, 2021 at 7:20 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 4/15/21 1:40 AM, Muchun Song wrote:
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 0abed7e766b8..6e970a7d3480 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -525,6 +525,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>>   *   code knows it has only reference.  All other examinations and
>>>   *   modifications require hugetlb_lock.
>>>   * HPG_freed - Set when page is on the free lists.
>>> + * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
>>>   *   Synchronization: hugetlb_lock held for examination and modification.
>>
>> I like the per-page flag.  In previous versions of the series, you just
>> checked the free_vmemmap_pages_per_hpage() to determine if vmemmmap
>> should be allocated.  Is there any change in functionality that makes is
>> necessary to set the flag in each page, or is it mostly for flexibility
>> going forward?
> 
> Actually, only the routine of dissolving the page cares whether
> the page is on the buddy free list when update_and_free_page
> returns. But we cannot change the return type of the
> update_and_free_page (e.g. change return type from 'void' to 'int').
> Why? If the hugepage is freed through a kworker, we cannot
> know the return value when update_and_free_page returns.
> So adding a return value seems odd.
> 
> In the dissolving routine, We can allocate vmemmap pages first,
> if it is successful, then we can make sure that
> update_and_free_page can successfully free page. So I need
> some stuff to mark the page which does not need to allocate
> vmemmap pages.
> 
> On the surface, we seem to have a straightforward method
> to do this.
> 
> Add a new parameter 'alloc_vmemmap' to update_and_free_page() to
> indicate that the caller is already allocated the vmemmap pages.
> update_and_free_page() do not need to allocate. Just like below.
> 
>    void update_and_free_page(struct hstate *h, struct page *page, bool atomic,
>            bool alloc_vmemmap)
>    {
>        if (alloc_vmemmap)
>            // allocate vmemmap pages
>    }
> 
> But if the page is freed through a kworker. How to pass
> 'alloc_vmemmap' to the kworker? We can embed this
> information into the per-page flag. So if we introduce
> HPG_vmemmap_optimized, the parameter of
> alloc_vmemmap is also necessary.
> 
> So it seems that introducing HPG_vmemmap_optimized is
> a good choice.

Thanks for the explanation!

Agree that the flag is a good choice.  How about adding a comment like
this above the alloc_huge_page_vmemmap call in dissolve_free_huge_page?

/*
 * Normally update_and_free_page will allocate required vmemmmap before
 * freeing the page.  update_and_free_page will fail to free the page
 * if it can not allocate required vmemmap.  We need to adjust
 * max_huge_pages if the page is not freed.  Attempt to allocate
 * vmemmmap here so that we can take appropriate action on failure.
 */

...
>>> +static void add_hugetlb_page(struct hstate *h, struct page *page,
>>> +                          bool adjust_surplus)
>>> +{
>>
>> We need to be a bit careful with hugepage specific flags that may be
>> set.  The routine remove_hugetlb_page which is called for 'page' before
>> this routine will not clear any of the hugepage specific flags.  If the
>> calling path goes through free_huge_page, most but not all flags are
>> cleared.
>>
>> We had a discussion about clearing the page->private field in Oscar's
>> series.  In the case of 'new' pages we can assume page->private is
>> cleared, but perhaps we should not make that assumption here.  Since we
>> hope to rarely call this routine, it might be safer to do something
>> like:
>>
>>         set_page_private(page, 0);
>>         SetHPageVmemmapOptimized(page);
> 
> Agree. Thanks for your reminder. I will fix this.
> 
>>
>>> +     int nid = page_to_nid(page);
>>> +
>>> +     lockdep_assert_held(&hugetlb_lock);
>>> +
>>> +     INIT_LIST_HEAD(&page->lru);
>>> +     h->nr_huge_pages++;
>>> +     h->nr_huge_pages_node[nid]++;
>>> +
>>> +     if (adjust_surplus) {
>>> +             h->surplus_huge_pages++;
>>> +             h->surplus_huge_pages_node[nid]++;
>>> +     }
>>> +
>>> +     set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>>> +
>>> +     /*
>>> +      * The refcount can possibly be increased by memory-failure or
>>> +      * soft_offline handlers.
>>> +      */
>>> +     if (likely(put_page_testzero(page))) {
>>
>> In the existing code there is no such test.  Is the need for the test
>> because of something introduced in the new code?
> 
> No.
> 
>> Or, should this test be in the existing code?
> 
> Yes. gather_surplus_pages should be fixed. I can fix it
> in a separate patch.
> 
> The possible bad scenario:
> 
> CPU0:                           CPU1:
>                                 set_compound_page_dtor(HUGETLB_PAGE_DTOR);
> memory_failure_hugetlb
>   get_hwpoison_page
>     __get_hwpoison_page
>       get_page_unless_zero
>                                 put_page_testzero()
> 
>   put_page(page)
> 
> 
> More details and discussion can refer to:
> 
> https://lore.kernel.org/linux-doc/CAMZfGtVRSBkKe=tKAKLY8dp_hywotq3xL+EJZNjXuSKt3HK3bQ@mail.gmail.com/
> 

Thanks you!  I did not remember that discussion.

It would be helpful to add a separate patch for gather_surplus_pages.
Otherwise, we have the VM_BUG_ON there and not in add_hugetlb_page.

-- 
Mike Kravetz
