Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D16319742
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 01:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBLABJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 19:01:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47088 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBLABH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:01:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BNtMEk015976;
        Thu, 11 Feb 2021 23:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1paWtOfO2mhJngy+COKzBibROrOKsgW2JJkw9tjmcnE=;
 b=WEeyPhJ8lM5gM0MXQH2DXOjY8Je17Fq/NXkj7OahIWRSUFsc1kFGVxLlJZvIxGKQDHqO
 3S418WujZa1tF2nm5lJh5E8R2fSJDgThbPZxkLRn7/obw2+I79QQz0lm8Y7dd7+3yMuj
 jiESOokVynYCChMrKxavXzvl8rjfhLppSId0mb6RyQPPTWbjefCB+eyHhdDtn/YBtC19
 r8zHsLrCV3Ljizma6lOZ17XzGzeGaIUSmJ7NsxV4e5Ri/M2g5uI21IW6L1N17716ouLe
 o3iCNWeJ71uwTbcKOAqEDD4eFH2mIjxzz/eOpHVbav4adlqc9HoyPQ2hGAc1ddMX7GTv iA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36hkrn9eqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 23:59:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BNtAnR142996;
        Thu, 11 Feb 2021 23:59:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3030.oracle.com with ESMTP id 36j520qqa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 23:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr2earjof1NZ3NR18p9Ifd250LL3L9iGIZld9kBt9ESgLBYYsezFHl/U7luNefw0SsNm78IubV33QoIfcShK87x2oUouGyGHzyjrUlHoJVZA1XqZGarYoqdkd6Vg/hBW2SUBd46kkN1nOqWqd24jkwiI3cZlm19WoS5p4uV/Ue4bqvt77uCfxv0AUCYG2SvikYIj+swPAu5Sah/ephp+7ITK38pDTGbKpf/CKbDr/HLyZmqCAA1VPustNxoumdx9EWxTR9qVMmO8eRiLP3tnxk3QRh3/md6ItrY0qwpUnVJLLkgzPhB34LjM2fgOEJVSKg9pc0xjri2RzK/Yu/zeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1paWtOfO2mhJngy+COKzBibROrOKsgW2JJkw9tjmcnE=;
 b=Fw+ySUnC3nGODsV/6CzMtcWBjfxN5O83fD5omXp5WVh2CS+osdRSXbmrwbm6PQka6VvmQQZGRoomN7njm/7EGFBSligh7i44tHdXPyA1d7Il4joyxacSZPF17btlY9awBozReG5gQ8qrH0aSjfXGNNlR1GklahZvvEs/hu7R5ayCpLct20PE4wGU/lbRf9rxTlHMBA5Fi3Mly9vIoyyIrFoI7OlF9o7Nag2Ry2HnhUM3dcLtgepmRGRm28pbGBMMldhl/gLYRqbam5wqF4n575ohwDyOrPcTJ6YZrZTvLURuW2ALo4RTfjeE2VYH0nUxbFQ8fKPPAdyxeHss1HZDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1paWtOfO2mhJngy+COKzBibROrOKsgW2JJkw9tjmcnE=;
 b=luLiz+eQeJT+pboO2tbbiaTgv/aG5m8/2JXC+2JsQEKKvBtRzsMri55TfvYb7o7Y5wwKtZERcg94OULUVZk+mmkqLe/HfF7dLq/OmWJIVDQ/Z4PEH1+quEzEsNGiLHVhMWwQNalf5gM1SZxzw3B+toSM98g+3NPdGPs63ELghY4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4451.namprd10.prod.outlook.com (2603:10b6:303:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 23:59:11 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 23:59:11 +0000
Subject: Re: [PATCH v5 01/10] hugetlb: Pass vma into huge_pte_alloc() and
 huge_pmd_share()
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-2-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <99dee8e1-dacc-d4d7-2270-dd473b022b74@oracle.com>
Date:   Thu, 11 Feb 2021 15:59:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210210212200.1097784-2-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:303:69::23) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0018.namprd04.prod.outlook.com (2603:10b6:303:69::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 23:59:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77743b2c-3d45-46a7-b476-08d8cee906d5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4451:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4451AF35D79DB3AB84EAAD28E28C9@CO1PR10MB4451.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNdY6vJxIxagAz2AltDHtjW502lCxy3KBB0DPL3kd6uFCyHtZBUcx141uErJI5iaC2cbMENYGZc6oOc6jvY4789FntW/SgVtsDfYvWc2leiGRb3zsRL2UXJXhSuxB+aKhfJFl/U225RYv4ysbEA0kRXXpgZ7XyFfAV9QwM2Lm4cElX+R8BjU/sF0lCPFJpNmje6bYgEgWkwCJDHeWAc9nBCCe+YnengzbZng2+mmzTEj2Lhxu4zQj/1GB9AKIkLMbdJJP41lbJPK6aHrblF7n1narKmqWxsbFUWm1zif5F7cP2ZJlfCgllVoc+96R5ASPnHMSU/pF40TtBbaWQBiyiA223jLpMi5960clfDPJa8RnWfNLD9pjgWVxQwenjKFnh4PTVW0rxw8jq6ecfHsBjpraaSVrhESmMxiH+MwDvrQFwUVwS9V1ISA+z6G4uhUvzdpGLl3R7Lybr0eUnzLhs+3Cqg/I9nh+V5gsItDRFpOb7V8gtFqdA0mMUs95KebWE5ZIvz6GY0QTc1T2AeEpAYHdZE8drVYnwobX2spwnNoYmodSpHvqil8/ib929G97duMOKTopc7/G6z2t2aTFhff+G1eJYqx3iUenDGEtAtW/GwojGK2mNx0upUqWfz6RQZqlZ4YGf9HJxUgl5Ec2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(366004)(39860400002)(83380400001)(8936002)(86362001)(4326008)(2906002)(8676002)(31696002)(186003)(26005)(16526019)(2616005)(31686004)(36756003)(316002)(956004)(110136005)(53546011)(66946007)(66556008)(16576012)(66476007)(54906003)(6486002)(921005)(7406005)(44832011)(7416002)(5660300002)(478600001)(52116002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RSs4MForcnV2SjZ5eXFzeUg3dXZWendTZEZVNEV6eUIxTjVYUmpFSjhjcVZ3?=
 =?utf-8?B?ZkhiYS9TUEk4aUxTN0VqQTdlT3JrUWN3b1hPcnorNVhXVzNpcTdQWmJhUDlO?=
 =?utf-8?B?NUNKQVFsdXl0WWlVTXZVU000bExqVnZwamNnTDBUNzgrMDJUTlAybk9XTmxJ?=
 =?utf-8?B?aEdWTXNEcWFiMll3RVpheTAxbytXenRzeFMxdTk5dzVlbDdhakR6eDUzQjJy?=
 =?utf-8?B?UnZhQ2xnSVpOaW9YMWswR0NYaTBTdDhXT1FQZitnUXRHVk5qdy9QT0VnbHF0?=
 =?utf-8?B?bW1IRTE5UkFrbXZSY0g5Z214UitZMTJybEVwVk5nNmt4OFYyYXVTYnBDaDF0?=
 =?utf-8?B?cUtoaUorUE40cGZVTWErblBKMWRBeHhHUTEwcTVUeGpqUHI1SU5HYXJ6UCtx?=
 =?utf-8?B?ZUd6U01wRXNGMGFTR1lhb2VaMUFWS3RLM2pneUxkUEF2N1FUOGdBQVVFZ2NW?=
 =?utf-8?B?eUc4cWVYUnpRdWM1dTh1a1hmSXQ2T0l1RXVmQ2RhZFVRdkdWTmZzcDRwdGoz?=
 =?utf-8?B?TjlvUjFTUDlWMjUyUG14bm9KWFFiUjJRbEs0TXNCcHJNVEtLWEpia2puQ0hp?=
 =?utf-8?B?Nm1Hby8zOHcrcmFJeTNLSDN6ZjA0VkJ1dnp1M3ZlUnpFVzVGWlAyd3BPUmN1?=
 =?utf-8?B?SHB5dkpkUVMzTHBobGozdThmNm1hWHJSZ2pPeHZlZkNlUGZESTY2dEpsWkNn?=
 =?utf-8?B?WnExUmNxT0p5ZEc2a3ZuWWQ2UUZLcnI2MU44a25WQWZpRlZ0QkVNdVRsRFFk?=
 =?utf-8?B?YjBBWkJveHJ1NWRoMlJHbHZLalVMQjNyUGkwaFprT25FWUtmYVlBTi8zRkcx?=
 =?utf-8?B?UXJOVVZYd25SRUxzR1RqOWo4bGdoV29FbkJOMDhTak5yenk2Ui9ELzh0VDh5?=
 =?utf-8?B?SmtFTHd2bXIxZEpZU0FVNGRTTjBGem1XTmI5c0hYU0tHRTJWblVYZHBOMmVW?=
 =?utf-8?B?dVh0eXdTZk9aMWxJeG1YZzZNbG43eXJiVWxuWjJZd2hGRXJPSG5PTnRjUnlv?=
 =?utf-8?B?bzQvUE5GbVR4L0MzdWdlNmdsUGEwVjZBSDhjNzRQV0xoQUV4SmhaU2pFTS83?=
 =?utf-8?B?dVd2eTF1R0Q5U2dBaUxiUnNFbno0TmF2bzl1aVdja1NLY3gvTDZrMG4rc0JL?=
 =?utf-8?B?bTE0djQ5SFRxcHBPamt1Rm1OM2dJOUY2VTE5YXFHeHF5Mm1Na0dHRmRZdE9O?=
 =?utf-8?B?Wmw3VkE0bnJtbDF3TlRZbkJjdHZIK0I2dTNFYVJpVG90WE9pQmhIQmVWb3J1?=
 =?utf-8?B?Zmw4QTBTZmM2dFVqRzQrclpFTHBpbzRmaUw2cUdBVzM5T0tKaTBFanpseDEr?=
 =?utf-8?B?RUlPbDltWVM1emVodklPb0t4SDRhcVdWWXYxdXUxMW1rZkF3NnREeUw4NEdr?=
 =?utf-8?B?MWhHaFJrZDNhbjhhL0tudGlEdk5hSHpYcm9zbitoK28vSHVyMThOUitFUEho?=
 =?utf-8?B?am1sbWFIOXE1cHBwN05DWnRsMUgyN0svamVmcU41emg1N041VE0rMFB6NVpo?=
 =?utf-8?B?YWJwR3J3UU9obmE3UEhmVFovNTdUVVJEWXJZM0NCMUVIN0pHWFJXeFl0T1RZ?=
 =?utf-8?B?dG85cHZ2c1I3OXRYUXdEc3FtZTVGVU9qa2hQM1c1TDZjS255aTJDajFRUi9i?=
 =?utf-8?B?N0crWWpmNW9xUWJiYlNuNC9qVGRUS3h6QnB3bTVsZUhnSEd1cHY2NjJJK3dR?=
 =?utf-8?B?ZW9McEtDTG0vWS9NUEo3dHNGRFB2cmVLTGFOUXdZSWJ5NTBFSk5wLzhWMkdN?=
 =?utf-8?Q?lotFsP7bawIzoLlTUTLzTXvAtlEhwN0AC2s6Yb3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77743b2c-3d45-46a7-b476-08d8cee906d5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 23:59:11.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //VAsl/Zsow8WzS6NIYdMuj42UTrLK9ompDcidMs9dXAlICBJ1nVLRGvMkee5nylemXiP3zuEsFRyvdQJ05akA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4451
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110185
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110185
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/21 1:21 PM, Axel Rasmussen wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> It is a preparation work to be able to behave differently in the per
> architecture huge_pte_alloc() according to different VMA attributes.
> 
> Pass it deeper into huge_pmd_share() so that we can avoid the find_vma() call.
> 
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  arch/arm64/mm/hugetlbpage.c   |  4 ++--
>  arch/ia64/mm/hugetlbpage.c    |  3 ++-
>  arch/mips/mm/hugetlbpage.c    |  4 ++--
>  arch/parisc/mm/hugetlbpage.c  |  2 +-
>  arch/powerpc/mm/hugetlbpage.c |  3 ++-
>  arch/s390/mm/hugetlbpage.c    |  2 +-
>  arch/sh/mm/hugetlbpage.c      |  2 +-
>  arch/sparc/mm/hugetlbpage.c   |  6 +-----
>  include/linux/hugetlb.h       |  5 +++--
>  mm/hugetlb.c                  | 15 ++++++++-------
>  mm/userfaultfd.c              |  2 +-
>  11 files changed, 24 insertions(+), 24 deletions(-)

Thanks, this will be needed for multiple features where pmd sharing must
be disabled.  And, the need to disable sharing is based on information in
the vma.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
