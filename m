Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76AA36F2D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 01:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhD2XV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 19:21:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34508 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD2XV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:21:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TNIxet010148;
        Thu, 29 Apr 2021 23:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Jny8cLWcBSLCrO5pFiQUp78JZqG1YhBSjmUvXZvxV60=;
 b=nj8V3mSid8PhHqjx+lcdmZqABTHA50SSMPqoMQHPilHiyCbLkh6TE3BYf/yEIdZoUGii
 u1jLyaqAUH2TojCZxrr/6GCCfaupQOEQ0vyEp/P0aaSjexwbl0x/OUehLjrTSVSI3Vdv
 Bzsho7GJz3XOtpMQAIGefjZr9NSFUl2IkFu8hJ7bXZ/LbPwiDekyja09v3CikakzfcCM
 MOv3uy9Xbsg37e3oNQqHjKm8wEj/KCOeUCY0eKMHeos/RjyffzlKvK1sX/0flP+SmpAq
 Y/pCShKdi4Q1WyLyXWvwZEmUYXhKXsk5xCKAstqmJmb1ypf+yojKKpejqGD1NLmfHp3B fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 385afq62mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 23:19:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TNFsV9154342;
        Thu, 29 Apr 2021 23:19:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 384w3x1dm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 23:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTQYhFVZxoGNA8FlwizwODRSK0zdVnpKM6ei9o8P46JagLnnKANAV2K/85Td3cW/P/p38tYmRQ6CZtHquQo2foQk7ApTKr9bRa2W8ssdxHIhAjW1iXrgtCqF2sOJHsBRAl+fl4dsqiXfzTa+QIC5He41QxFQEEGK/ixwdI5Fy1q80Mc4wlmT2DTJmSAsJ8u+LPnmODHN9LYa7iuNNAy1ExlmHzAgFlr4YDnzOgFN6RVaPpI5/vD/9O0K637REV6FD3cyeedvRkwmZMxEf3pRp5/itomqmrFcfbnQiMG0s6DqpjDpB/8G1BUKA3qL6F/VgxJgTtuvUiVwQJrgQa8oQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jny8cLWcBSLCrO5pFiQUp78JZqG1YhBSjmUvXZvxV60=;
 b=ahLGC4aBNBKe+/if0R0JNTwUIDKE+xkIUuscEYUPq0ON+++2Ec5KwjVA4YELMAURZ/BSveyTHvsvWslpgs6poyiLc2gluQUEq6JLhNl/dJFI8dt8zTcD6py9u4jSdKW+tDll39cdVfdE2NziQUCtXB4WoKH3WciGS9ViEfs18PCAceOs6OmSkO2q3iD/e4W1E1330yMJyZ1PuhTnkyzzU4mFIOo0RSyEzMXBH19UFM9pNx6Zn9DqAOdQp1thvETguIWgdjrqKlcXzHudZSxZiX7cVpiYc0y7BfI3EqqsQKo0VMdR7jrt6hz7DUIlxeayZzncnvWhlU1flsW0yk5Ibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jny8cLWcBSLCrO5pFiQUp78JZqG1YhBSjmUvXZvxV60=;
 b=MAvMsFkax+cOGBt/76iauMOwWySDrUuH0uVZAXxwYCOxIdTRqasjfFxIJsiQjVSqCG7faejnZSb3LFVegRt4FIgvPZ3r3LD8ecz1yey4UINrTZnGwap41S32Vbsu+fBuXb08MNwKFVyDUKhbc4CfLRJv6mnUWHlcC82uUs4fsDk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3812.namprd10.prod.outlook.com (2603:10b6:a03:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 23:19:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 23:19:43 +0000
Subject: Re: [External] Re: [PATCH v21 0/9] Free some vmemmap pages of HugeTLB
 page
From:   Mike Kravetz <mike.kravetz@oracle.com>
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
 <4489afcd-be3e-7830-4e37-03abe454486a@oracle.com>
Message-ID: <5f363b58-f70a-4a6a-9761-aae93cb49138@oracle.com>
Date:   Thu, 29 Apr 2021 16:19:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <4489afcd-be3e-7830-4e37-03abe454486a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:300:16::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR13CA0010.namprd13.prod.outlook.com (2603:10b6:300:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Thu, 29 Apr 2021 23:19:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73161d10-5e49-400c-2c1c-08d90b65458e
X-MS-TrafficTypeDiagnostic: BY5PR10MB3812:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3812D8E966E36F93C91B1D39E25F9@BY5PR10MB3812.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/Gea8PqF8YT3DWbUrSzuyrHPR+Kz5zCIzbkdtOsGEy3nyXfliOrLdPUKDqlAaKDJ/LFH3CB5yWRLRFNrURZ27aEKUHT3FYHpBaROQRMf0yz/oBoFAIs476ywi9UD8kaDISw/Begh0hK0uX72FREA+4dxUblYZWcs4dvty/FHCvS6DQWUrk1Q8gAsaktbGxarq3AIcGJg7xFHOp7wF0FdXAEQCPWi7fHWi9/65WYK4vs3Xac/oJj8SPBvK8w5/6mLDNmwnZgPMf8wPf36VY5Aa36kJYXjGL9jA3H5zxZJ+zEDTrHC/aPcp9svW/yldV6uGn47OygkgdvAXWVPbUfwEQsu99I+52N5F9NQOBbtnVZeaHfGaz6C/zWwgd/OeUB+VM3zo2XTRnaiRwMyrWtatiSSWXwdONly39JinjKlkGDk0ABbQBVQTSVtYTXfKkosVaMGTDHOvsFD2oo8CTY/prnihBZqURfxBMxzkHTLbtmrwjXlB3uf5vUa7207gP0+TB2crwXGxNm3eaaq7XelDeyct1+Q5TQWiDTB3X+R9ge6rkTkBdEqX5wSu64uV4nzW126hkNjRohU8ogRsvIFchCYdoddvdJmS5px0wTlxRsoroFqIOGykwcRATCFzk8IMtFNUv0EHeVBYk8pNHF6masICsVCicf5wdo8nLuq30ZPAyBCueuzIdl71lc39q4rgNo9d5/+O0mTZKoTRqYQKrcaJzb2dfHyk5i/HtJ80U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(376002)(366004)(136003)(54906003)(83380400001)(2906002)(38350700002)(2616005)(8936002)(36756003)(4326008)(956004)(31696002)(6486002)(16576012)(478600001)(26005)(7406005)(7416002)(186003)(86362001)(6916009)(44832011)(316002)(66556008)(8676002)(66476007)(38100700002)(53546011)(52116002)(31686004)(5660300002)(16526019)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T28xYy9iVmlzNjZHTXBiTjV2WnVhcGNXQVliQUpnSC93TUltWDJoTmVQY1RS?=
 =?utf-8?B?V1BXSUxTZ3NVSmF1Ukp3U2VSSkRzbnBxWVkwRTFWRHNJZGo3d1l1S2hSQklT?=
 =?utf-8?B?Z3pZQW9UdkxWVGhqSnptVmFydG9vZnlkMFhJSUREZW1PN1NVSDhKRXFvMjRT?=
 =?utf-8?B?cStqTjZVQUw2ZWRnV0RISEJ1ZjNkQXltTTU3WWl2R2pFdndnK1N2Mi95OXVC?=
 =?utf-8?B?K21SRWZQQm1LZnF6UmcxNHdYQ05OVUZpeit1SEJTbysvVXhNM0k4eDFURUEr?=
 =?utf-8?B?NVErM2RsRXMxYm1qRkFRanIvOTBIZ2hiV2pFOWo1UnlnNzlwTzlEekoyMkhD?=
 =?utf-8?B?SnJzWDZRQk1ZM0VRNXpwK0FRbjFwL2l3VzBCRmVaZzE0U0dNTzlyUDVFRDJB?=
 =?utf-8?B?OGVSc0Q5R0I5cjk2cGRRUkxuMWhTZWt1OGVJTGlVc0JCZlBIcVFtTktVRU9R?=
 =?utf-8?B?SGxkbnd6dEorSldoaHJOUzUzTXhCcGlsTi95d1hnQU5vUWRObC8vRUtEMzZ1?=
 =?utf-8?B?QzU0a0dxdUZWUENoWENqT2VwRVRoUUx4Zmt1eFNza2hzbTVLdlE5dEJqSytp?=
 =?utf-8?B?eWV6c0hKZ2NYd2xEVjBtUWcvSUpDYUJLd2g0MXErYzVjVEZCUFZZTFpFWFRy?=
 =?utf-8?B?UmZmTFFGZ080c0U1TTVPSG1QdjMrUXBIRlRBRjRCWUFyc0dFMWMycVZNQisx?=
 =?utf-8?B?U3R1YTl5NUltbis0bm40N3pDeStLY2F4YzkvY0cvWVMzLzE2SHd5UjlvYm5X?=
 =?utf-8?B?ZGcvMlc4ek5lbXgva05Na0ErYUtheGZZNFh5bXY0WDF5V2JPOXkzOTJSS01v?=
 =?utf-8?B?UmpGcm5qWktNNE93VmtHY3RmZVhNVi9vTFkvVTlsWnc5WVdvQVpyZ2pmN2xP?=
 =?utf-8?B?VWtReGFSeENLT2FlYjJ0Z3ZiWnJlZ1M0TnJGQXp1dkZtU3hhWXF6OUZTbm9x?=
 =?utf-8?B?L0lvKy9pZ0NLcXBtVGlreGF1bURCeFF1NGpWckFaRVIxWEJEVnpEOXVKdU90?=
 =?utf-8?B?NnI2MGw0Q0wzWDlpaFhFUTcwWXZGL0hDVVd2TEpkdEFPQTZhd3hGdkZyWHRz?=
 =?utf-8?B?RE9LTkFlSm1nN1pueFJIWENwNk1OUEpxd05Ed3R5WnhZQ2pkbE5ZMzMrQ204?=
 =?utf-8?B?ajNiQ1drK1RRMWZuVEFGSnVaWElLWmorOXRxM3hyc0hkNEhpZnI3WERXOWRB?=
 =?utf-8?B?dTJGNS8xNHJpUUFnV2pGT3hjL25iQlFJKzNrWFZ0QzNuTDEwNG1MYlJQSWhT?=
 =?utf-8?B?M2tCSko3K2F0YWxIL0hmdHp3cFVmNVlkdDBxUzh5Z1UvNUdVcHpZSE4vcXdQ?=
 =?utf-8?B?aUJKYTlCQXF5Vzh3S291VTlsa1NVczBQVEtYcEhKU0gva1BZcmM4Tm5rbVZL?=
 =?utf-8?B?WDRNcWR1RlFybWhYRS8rb29XS0dGUjJLd1EzWVZpN08xb0V2anVGZ0RpT3dn?=
 =?utf-8?B?ODRCekJONjk0cGR6S2I1MzFZb2dMaEVmUXlrRXFzQVA4WlBNbWNkdnBmcTJN?=
 =?utf-8?B?Mm9zam8vMkhkQjBqR3d2MHMzd1I2YVdzS0h1TU1LMmxsclhFRzVEOEpDY1JF?=
 =?utf-8?B?b0J5bUQyWXByN29ZclkyeVlKbDdoaUJWaTNOYWQwOHBmb1RPMUp3b2hTOGtJ?=
 =?utf-8?B?MDM1QVFVL1VDS0ovS0FUem9yWG0zK05VMFVYdG02Y29GL2RYdnRudmVoTlpH?=
 =?utf-8?B?bXg4ckxNWElBTDQ0NGlKcVRvZHJTekppWlRjcVFMRXdNb1BaOEI2T0p5dU9K?=
 =?utf-8?Q?S9skc+x0zEQUltrKI7b0nc8aBnaYfCdlbYV+gSL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73161d10-5e49-400c-2c1c-08d90b65458e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 23:19:43.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO9ffCJUNbgZC4k5eYZLNNQQHy6Nu2KUDRI7noEc0zDvG58t5ux+dVLk1yBEoQXng2nRLr3hZ07ABD3ZanGUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3812
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290150
X-Proofpoint-ORIG-GUID: R68rIf_3TafAKvnivr38rkVaOF_AZ7w1
X-Proofpoint-GUID: R68rIf_3TafAKvnivr38rkVaOF_AZ7w1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290150
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/29/21 3:23 PM, Mike Kravetz wrote:
> On 4/28/21 9:02 PM, Muchun Song wrote:
>> On Thu, Apr 29, 2021 at 10:32 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> On 4/28/21 5:26 AM, Muchun Song wrote:
>>>> On Wed, Apr 28, 2021 at 7:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>>
>>>>> Thanks!  I will take a look at the modifications soon.
>>>>>
>>>>> I applied the patches to Andrew's mmotm-2021-04-21-23-03, ran some tests and
>>>>> got the following warning.  We may need to special case that call to
>>>>> __prep_new_huge_page/free_huge_page_vmemmap from alloc_and_dissolve_huge_page
>>>>> as it is holding hugetlb lock with IRQs disabled.
>>>>
>>>> Good catch. Thanks Mike. I will fix it in the next version. How about this:
>>>>
>>>> @@ -1618,7 +1617,8 @@ static void __prep_new_huge_page(struct hstate
>>>> *h, struct page *page)
>>>>
>>>>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>>>>  {
>>>> +       free_huge_page_vmemmap(h, page);
>>>>         __prep_new_huge_page(page);
>>>>         spin_lock_irq(&hugetlb_lock);
>>>>         __prep_account_new_huge_page(h, nid);
>>>>         spin_unlock_irq(&hugetlb_lock);
>>>> @@ -2429,6 +2429,7 @@ static int alloc_and_dissolve_huge_page(struct
>>>> hstate *h, struct page *old_page,
>>>>         if (!new_page)
>>>>                 return -ENOMEM;
>>>>
>>>> +       free_huge_page_vmemmap(h, new_page);
>>>>  retry:
>>>>         spin_lock_irq(&hugetlb_lock);
>>>>         if (!PageHuge(old_page)) {
>>>> @@ -2489,7 +2490,7 @@ static int alloc_and_dissolve_huge_page(struct
>>>> hstate *h, struct page *old_page,
>>>>
>>>>  free_new:
>>>>         spin_unlock_irq(&hugetlb_lock);
>>>> -       __free_pages(new_page, huge_page_order(h));
>>>> +       update_and_free_page(h, new_page, false);
>>>>
>>>>         return ret;
>>>>  }
>>>>
>>>>
>>>
>>> Another option would be to leave the prep* routines as is and only
>>> modify alloc_and_dissolve_huge_page as follows:
>>
>> OK. LGTM. I will use this. Thanks Mike.
> 
> There are issues with my suggested patch below.  I am occasionally
> hitting the BUG that checks for page ref count being zero at put_page
> time.  Still do not fully understand, but I do not hit the same BUG
> with your patch above.  Please do not use my patch below.
> 

Ah!  The issue is pretty obvious.


> @@ -2489,7 +2489,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  
>  free_new:
>  	spin_unlock_irq(&hugetlb_lock);
> -	__free_pages(new_page, huge_page_order(h));
> +	update_and_free_page(h, old_page, false);

That should of course be:
	update_and_free_page(h, new_page, false);

>  
>  	return ret;
>  }
> 

-- 
Mike Kravetz
