Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B7C35A8AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 00:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhDIWQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 18:16:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhDIWQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 18:16:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139M9CDp146909;
        Fri, 9 Apr 2021 22:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XyEcDl7LvQm05XDUZDT2gPg3QevePS027K9kaPrtcxE=;
 b=xazXG4QzRiHejA8VSBu0zp25ZHt3+AGJIKs/JNt6VKNkLFhdJrNTgp/yZYI/0ekQzvZA
 8ulmp04jkmqfJmjBy6tkvujbwjX+GpmQJsxM+zfrnOQSGZoa2+33qQACSMhHj36c/0Ye
 uFFM5muOt8kNig/IxlQ+KGUvSEdbo0RC56xTKg4kfXUeHRK315MvB3VA+hEiR2UYmdmZ
 yEksSNLNquaxFE/NhRn7wdcHxmp21GJiKG8Xeyb2AIyzdZHp7uPqRkDUR1FwWbS99vQJ
 0vPxQtBrEN4rnxTz03b1APgBY3u4Vs//pXTGiIVYn6/svHuhPBclr+PeArS7V996ZFMv kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37rvawav07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 22:16:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139MACDI127194;
        Fri, 9 Apr 2021 22:16:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 37rvbhj0fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 22:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQgmbRTgCcKlBFHsF9ewKgJ3HlwImmyWY+xa0hR0Ur0N4hyPofg8RsMq8zyftre4bhZmx+FIT/n8T0ixapCY+myjVz/xemJsT2Vu5YLdbg5Rzaor8IVNhNtJf7S6jyFDj0dH1Bu45wFQYGp07252Eenea0gNsKYE2ajpE/frMNd6pX8rUtNrZ5nxN0kWEhuCmJAtLSIYGsjpjc1wxtEG8KZ02taXE8COep1qAG2LGlmIUWsquRz4lFBGNO9jahRpm65kBT8Gu86HrF9U75/5EnZFOk0DrzYwitHbcxm2FQzdngqBa6HQx8Fcb97TDQzoglhq45+SIjeemJZpw2GvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyEcDl7LvQm05XDUZDT2gPg3QevePS027K9kaPrtcxE=;
 b=k5DzuGjnV4XkzO/0+5yCjiKCo1UdUK14xubx5K6Q6IL9Q43Ln0PZ48m0ggezAoh9vY3PkKvky8cWeYWOHtQSgQBLgqXnHWOur7XbqtVz/OjRfnwpzbMhWNKDUhs1f0FKLS+kXGmHk3ka3jAqIDqqFXtXhyDhq/deTaIrMmytOtkL+UY7+wkNx8RvS2JpX5bAzz7xKtkAsqxXTl2v8Wzlmtf/7yHEqaNDqVD2BM37MSDZkF+fOQuBcpZ3CwgX3Wdgs9BNTQzuxxP/5wD6R3Aa5PXIyqwn4BLVWU0M+WRJvu1vjMhBop22h2Rcv15A5Bl4OAarlh6r7829uYeKhdzmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyEcDl7LvQm05XDUZDT2gPg3QevePS027K9kaPrtcxE=;
 b=YvTorp+ceneOqb1+VFdWK7pVCZ73mw353RCvqw+CiyM+VN92lk/56jw4JdWDhzcmaC5kLdPQ7uKgkgCAuO937S+mbZmhNEBiSNWbmOgfzl0LDOriNktM/xoXQGarNt7yZoTpGiAB6kfUMfpN+ePhhTwM8cnvX1fE0BZ30Tl/Sxo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2456.namprd10.prod.outlook.com (2603:10b6:a02:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 22:16:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 22:16:04 +0000
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling for shmem
To:     Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408220440.aab59f2f06beb840c22377b3@linux-foundation.org>
 <CAJHvVcj84fcuh0vXtHdEPoV+DrFDSXjUg1fO+oLFCOaxWBH13w@mail.gmail.com>
 <20210409211824.GH792100@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ebbde306-0c72-f80f-05f7-0a88495f75b3@oracle.com>
Date:   Fri, 9 Apr 2021 15:16:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210409211824.GH792100@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:302:1::43) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:302:1::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.4 via Frontend Transport; Fri, 9 Apr 2021 22:16:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e6888c7-9457-462f-cb4c-08d8fba510f9
X-MS-TrafficTypeDiagnostic: BYAPR10MB2456:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2456E48330666DD905EAD3ABE2739@BYAPR10MB2456.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIASORPJgVVvmimtp+Eon54pQEiwSAldMPW2dwNTZLT24SjuezIOf1HStvNIRPZqn7gpFERNlgShn21CaA0hEYm2Zb8VvlfCyCqeFbrLTRzerIPMyMkA5B44zUmEGH7Bmnu9Sg7zbDyX1mEvW/gZyJGosttlgWy/xa0YnwKsjKURAIp/jFBfgyah+jEkP2E/zP4lYHV1h1AgYxQVh6L/qB3xDenVIARkiDduV7Or5DlT8Ctp5GCu4eWgvLnRqe/QJgWz4iW3UzBz8JYf4MWd28N2MlVCpw/71AlTgzLHyc5H8d8Tl0/eKFKygOyqxaLo12wgqnp591Fb5bEDAAaKbYeoOYAmG8dXBEyhVOTn8cy484F7Kqc7Kdq/uQ9+AdyQpL1c7uhuSQSZoyGNeKe3JhlURkMJ0VufG3gxpgZdJr/5QqsY6CWSRyq0fvf4m/DJPTUKVnt/7hxoW9oM6Q5tlic3XQcoDa1y3fIIX3t2c5a2ud7LuwqH4qEaA6YlPZ8aj2nB+JpQ39nZByGiw6fm0wgSupowleFMFj0wAzdf8s9ILyi5IzOg+eum+xS/pPYtsgslH3iuwirPtAz2qD66ZOrXIfQHnlmCVZkcA0zV/HGVqc7xTkuXjKG0eAfLH8fg9+wWoMoLQ1/0rWnpwsbFPZB0n9FHekK8UL/3Bv3kGySNWWtObnzzi0OsWsSJPfICIrfM66dKQk7HQFSz8BPehmXt5vMe8AIMfavNbvGnah/pkY/WtIA2YO69uHHBcR8A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(136003)(376002)(36756003)(26005)(83380400001)(66946007)(8676002)(16526019)(86362001)(478600001)(6486002)(186003)(54906003)(4326008)(8936002)(31696002)(110136005)(66556008)(5660300002)(2906002)(316002)(956004)(38100700001)(2616005)(52116002)(7416002)(38350700001)(31686004)(44832011)(16576012)(53546011)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MEMrOEgwblhnT1NBa2UxMmRGdDhNOE52NkJqcGRJUFp6aVRHNWttdzlPdW1Y?=
 =?utf-8?B?OVh2MEpZeUhJRG5wUGp2SDBHTkZQcGRvb3o5VS9EdmFLSDY1T3dmSVBxRWVD?=
 =?utf-8?B?RjdnVVlpcExZMUFkUzhIbEIzcFJaWnFGWlFhcFdyaG5lMVdXaUErY3lQTHNB?=
 =?utf-8?B?cEkrTEZYdTB4QkRrOXhmRHd1dlkzWHNsUmhSbXJrMnJBdkFqMXR5aXFONGxk?=
 =?utf-8?B?QkJsNE1RcTgwNXRYSzBiU0JQMmlkUTZTNHE5UVNGZUxmRHRYRmY3ZlRDQWNB?=
 =?utf-8?B?Z0txbERwS3pNRDZZYmF0Z1lGZHFYRmdYcTE2ZkJDMElCWTRzYmJ3a1NEcWQ1?=
 =?utf-8?B?TVB1UFN6UStERGw3SUkzdWdGZGwvTnZjd1JPcmF2bm9vbTR6elZrZTQ0V3Q4?=
 =?utf-8?B?SWIyK2xXRzRUREpNcURmL2hmbzRxd0VaanBCMWtJVDJZSk9hcStrK256ZlFC?=
 =?utf-8?B?dFB1aTBzeFNSaHlZOFl5a0JPSzZuTitERmxEL3hQU3pVWjJ6MDF1bFlKUk93?=
 =?utf-8?B?dnI2ZzRYb2QxTnRlU01oUzYwa3k4SW5PMlRTSFpkLzBkeDN1RHZZRGlydE1Z?=
 =?utf-8?B?Rk5MVXBJRkNFMTV1Q2x3ZEZPaUY1bGV4aEpybGdMeFFNdWgwSmlKZVlhRlRF?=
 =?utf-8?B?S3MvemJMYkJGbEE2ZlVPTld4dGVWTldIRnRpdFZFRFVhNDVROGw3Rk1XcnN2?=
 =?utf-8?B?OGtjbUJ6VjlTVnFIQWs5YlI5dnVvZkRrcGJvWHYvajNQSUExNTRTeitvTVdO?=
 =?utf-8?B?ckQxMWhiaHFpWlphNzg2S3UxQmVGa0tiSDd1ZU50eGdrT1dPbm5sM3E0NWF5?=
 =?utf-8?B?SkI0TVZBdnRTdERyeFN2bXdqSVVlL2x0aE9WZlVlSTg5VnYwY0EwNTd4cnJp?=
 =?utf-8?B?TUxsMlo1c051S3lmL1dxNTBOaklxY3NudzVwTEV4d1hMbUVTSmVEQUVnMlI3?=
 =?utf-8?B?bEhWc2RiY05wTUxCdDV2enlrTjdmZFpyNzlUaFp4YUNJb2pRUkk2RzFDZmdO?=
 =?utf-8?B?MEtYNVlvdzF6UGJtci91UjgzUDJkOTBOWVZTNGQ0TndpTlRxQ3lEakYzSnpD?=
 =?utf-8?B?bUJsd0tOZ29tWHh6ak1jUDF2WmJOK3plWUk0b1pNTDBTbHZzNlJiRHJMQjZY?=
 =?utf-8?B?d0FsUFlSVE91TTdHTEdFNlZ2enF6WFpOYUpmTHZXWDlVdU5IMW1UWVpyMmh3?=
 =?utf-8?B?MUlnNURTWU5lU1NyUVc2UHptS0llNDJQdFZjaUxpSGtNWVdaOVM4RmNFL2RH?=
 =?utf-8?B?VWVoaUZ3ZE95SFd4RFlnVVFlZmdZN2FrVEEvKzJxSDhxdzA1Tkhha3IvaTJN?=
 =?utf-8?B?MDhHUUVkVzFTV2lPNHBNcklzZWxubkJSWXY5RG5hNkFlWUo2c3pzeWowSE9J?=
 =?utf-8?B?U2VKR2l5R2dDN21pbEpKUlJ0dXp0a3pCUnVocFhlamtxTVBIQkhoelFIQ0J6?=
 =?utf-8?B?aXYyMWdWMmdlMlN4Tnp4RjdPVDBEUHFISWp2QmZ6YndRUHo1Y1NvUWdNeDMv?=
 =?utf-8?B?aVgwYTFKcDhWTm16OG1OQ0ZGcXg4TEYvb0lwejJGakVrQU1RZUZPN0phMmZk?=
 =?utf-8?B?bGJHSDh6NlI3MTJpaTZPdjcrOGlGRnBsbXhSVWo1b1BtSjdHTWtJcmJodmJD?=
 =?utf-8?B?c2VTVHkvWnl1anFGb1lVcjNoeVVjVFM4YTd1QmNkcEtvVVg4V2RuMTk4d1gz?=
 =?utf-8?B?RktzWjZoSDlTeHVIb0FIN0UxRXdMd295VzhYSVlpaUVtZVRrWTFCZlFzTzRs?=
 =?utf-8?Q?JrI0p+CsRH3msc2djUMrlwdFCQVJLmwMF9LjDKn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6888c7-9457-462f-cb4c-08d8fba510f9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 22:16:04.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhRNMHwtnMZ2T2reGxAE77W9d7vq0bYHauoUwSFSl26HZRa4zrliCGeXcmYG7b77DOhrJ4fX8hC/7Q4+c5FnCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2456
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090161
X-Proofpoint-ORIG-GUID: Knz_y7uSBNqA74bPX2lBTs8xQGZi47Qm
X-Proofpoint-GUID: Knz_y7uSBNqA74bPX2lBTs8xQGZi47Qm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090161
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/9/21 2:18 PM, Peter Xu wrote:
> On Fri, Apr 09, 2021 at 10:03:53AM -0700, Axel Rasmussen wrote:
>> On Thu, Apr 8, 2021 at 10:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> On Thu,  8 Apr 2021 16:43:18 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
>>>
>>>> The idea is that it will apply cleanly to akpm's tree, *replacing* the following
>>>> patches (i.e., drop these first, and then apply this series):
>>>>
>>>> userfaultfd-support-minor-fault-handling-for-shmem.patch
>>>> userfaultfd-support-minor-fault-handling-for-shmem-fix.patch
>>>> userfaultfd-support-minor-fault-handling-for-shmem-fix-2.patch
>>>> userfaultfd-support-minor-fault-handling-for-shmem-fix-3.patch
>>>> userfaultfd-support-minor-fault-handling-for-shmem-fix-4.patch
>>>> userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
>>>> userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
>>>> userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
>>>> userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch
>>>
>>> Well.  the problem is,
>>>
>>>> +     if (area_alias == MAP_FAILED)
>>>> +             err("mmap of memfd alias failed");
>>>
>>> `err' doesn't exist until eleventy patches later, in Peter's
>>> "userfaultfd/selftests: unify error handling".  I got tired of (and
>>> lost confidence in) replacing "err(...)" with "fprintf(stderr, ...);
>>> exit(1)" everywhere then fixing up the fallout when Peter's patch came
>>> along.  Shudder.
>>
>> Oof - sorry about that!
>>
>>>
>>> Sorry, all this material pretty clearly isn't going to make 5.12
>>> (potentially nine days hence), so I shall drop all the userfaultfd
>>> patches.  Let's take a fresh run at all of this after -rc1.
>>
>> That's okay, my understanding was already that it certainly wouldn't
>> be in the 5.12 release, but that we might be ready in time for 5.13.
>>
>>>
>>>
>>> I have tentatively retained the first series:
>>>
>>> userfaultfd-add-minor-fault-registration-mode.patch
>>> userfaultfd-add-minor-fault-registration-mode-fix.patch
>>> userfaultfd-disable-huge-pmd-sharing-for-minor-registered-vmas.patch
>>> userfaultfd-hugetlbfs-only-compile-uffd-helpers-if-config-enabled.patch
>>> userfaultfd-add-uffdio_continue-ioctl.patch
>>> userfaultfd-update-documentation-to-describe-minor-fault-handling.patch
>>> userfaultfd-selftests-add-test-exercising-minor-fault-handling.patch
>>>
>>> but I don't believe they have had much testing standalone, without the
>>> other userfaultfd patches present.  So I don't think it's smart to
>>> upstream these in this cycle.  Or I could drop them so you and Peter
>>> can have a clean shot at redoing the whole thing.  Please let me know.
>>
>> From my perspective, both Peter's error handling and the hugetlbfs
>> minor faulting patches are ready to go. (Peter's most importantly; we
>> should establish that as a base, and put all the burden on resolving
>> conflicts with it on us instead of you :).)
>>
>> My memory was that Peter's patch was applied before my shmem series,
>> but it seems I was mistaken. So, maybe the best thing to do is to have
>> Peter send a version of it based on your tree, without the shmem
>> series? And then I'll resolve any conflicts in my tree?
>>
>> It's true that we haven't tested the hugetlbfs minor faults patch
>> extensively *with the shmem one also applied*, but it has had more
>> thorough review than the shmem one at this point (e.g. by Mike
>> Kravetz), and they're rather separate code paths (I'd be surprised if
>> one breaks the other).
> 
> Yes I think the hugetlb part should have got more review done.  IMHO it's a
> matter of whether Mike would still like to do a more thorough review, or seems
> okay to keep them.

I looked pretty closely at the hugetlb specific parts of the minor fault
handling series.  I only took a high level look at the code modifying and
dealing with the userfaultfd API.  The hugetlb specific parts looked fine
to me.  I can take a closer look at the userfaultfd API modifications,
but it would take more time for me to come up to speed on the APIs.
-- 
Mike Kravetz
