Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1531A6F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhBLVf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:35:58 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57294 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhBLVfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:35:54 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CLY80o122982;
        Fri, 12 Feb 2021 21:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sRKansEntVq8B9QJ+xvD5x+4jfVGUILXnu4iylVlgCs=;
 b=aWhaqbFPAjYSIG2aUpkxP9XjNVIO1pE8EdHWPYBenbc/Os465/jdYJdIrvXifBaFE1Ez
 npnLeWj0OEfAL85jImIdQnAgn9RlLuDWf14xA5C89S4PKmpAA65qGZ36+1kYWf7pEaad
 smtvPjIwoO+ZGXYE92s3a9KWLUjPhBrZU9xwJtvRkHCzBAA83w51fNk1/jjy7R/cuffL
 9tCdzL1+YWxfaSc4GvCrYQOKAO2K/SPFklKpctCil7KZ+9+6tsGShcP+hmepI9SYFVph
 1Ov4av/kRG2DRlvJmXfzak0JligBec+WunaNi2Mc3r0Ln5ifAiI0RCwDErb/hEVcayX3 pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36hgmavu01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 21:34:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CLTe3I040413;
        Fri, 12 Feb 2021 21:34:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3020.oracle.com with ESMTP id 36j515yw6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 21:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABJi+0xm4Igv2P0oybYCwnBulSeaZ0TNpNNowgZM58JcgyMMn9xS1AECWJCzB0EaJD381SADHPkkrU9MbVkXfGe0bbB8jrazyB7ySdyx6peCa3yQE5QMBoUc2fjSOGtHMJm6w6Z775+Si2Bp0qkTYv7O08FNiShizpe5H6ZSk0rDvIJhcfbXziQfbsQI6AeZaSokFFAyE+/eFSZDg5O/Tf/J7rwrWGOdMDlRTxNOurlm0UDePfVdZuwhpCJRyJ8G1nblebAN16Y6XzwonRw7UHgZWSaZ8wTtm2Sdwr9HJ6bVN6DE3QQEip+sZv01DIm8g4y44j9tGVPB5iETsq/JIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRKansEntVq8B9QJ+xvD5x+4jfVGUILXnu4iylVlgCs=;
 b=m2XmvOoAfoCVr6BCHv7W862zn7COPNOtQad54pejLSOXQqcB8wujyjB6txo2xhVCbgQ0Mx5/AYJE78tYRmbcNdZSCA+Ec/yzZFvq9Vru7Boy/kttUgwbBOh9+WV7vhZeU4BFC/0i51MYAMFWE3vlc87SsfD+8ISiJbR8VyaYPaBoD9YVnQMJkOBxHyIFb66pCf9VdMrpuKSdvAIz6FYQN16l506XyHXWh40+pLhtMIoreQlhEGCe1tO3Z8eDz9m1yWUqAcqDY9jxxSf+YHqnXCRHiV1VLb9pG2cPjvEghyG39qdDOwayTp1T7SJZNu749We8Q/vQqnjSq0H0eYUrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRKansEntVq8B9QJ+xvD5x+4jfVGUILXnu4iylVlgCs=;
 b=OYRoc/KfZlYlBq7BPhyeDEbqMjhfbN0b9aFVySPoLTco7UQdkeqADFnIH140lbuwtK040gJezP10m7Gg3UJQSYLkzg0N7kRxmHYUuxLMDipxM4O/WCkflYQw7irivaiCLFAIzg2flLB+DaEV6suZqAJv7dfRLyADcKHbEBtymGE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Feb
 2021 21:34:05 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Fri, 12 Feb 2021
 21:34:05 +0000
Subject: Re: [PATCH v5 04/10] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
To:     Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
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
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-5-axelrasmussen@google.com>
 <517f3477-cb80-6dc9-bda0-b147dea68f95@oracle.com>
 <20210212211856.GD3171@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a32b5427-0560-fa24-450c-376c427dd166@oracle.com>
Date:   Fri, 12 Feb 2021 13:34:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210212211856.GD3171@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:104:3::15) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR06CA0057.namprd06.prod.outlook.com (2603:10b6:104:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 21:34:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fa7a275-68fd-45b0-0d3e-08d8cf9debd6
X-MS-TrafficTypeDiagnostic: CO1PR10MB4594:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4594CFE3B04EBDB1B77F8410E28B9@CO1PR10MB4594.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McK/ir9inX0HkuZ87UfmSbdskJzWDNzAKy60YjRRJoLopmCEjnGUpO9CY+ToTBYodISCkSlWJQneKhkQm98Hn8pJH5bCjAcpla6RzlLwhI2LtKlgPaOaSnsKHrfiB4UPUCSPyy8qJb7Z80gZZ6Sq6ReHxmv5phk3OdHN12T/+56NFp5uKCmAlHWZ9Jq/ec/xxS/Hlk5GNc+OaNRqboXNN/3142YeKw+uUvktAYIpzF7k7JzcIsVtI/Fdh9irqh08/erqfn2VHgG8AWsYF9cWb2zvkYXbzKrQwnIz2T+98H+TgK/CzO/lpLJUrJbWrybBAMtJ1/6UZERwXS4OIx8hjoDQYoW560WsH58aPR6V11rs4qeZUKn/cR+vg5oiiMi9w9UYF5JBbzg/LbrxSuI97YWe+o6w1kwX/GWLWmODPkHDJEjdGSFZTcfKU2Bhp1+phmfy2NuTyYBl6Pp7/hrqH/pxxS8h4IK3grN7NABLSkBM4j4ZMfRh85iE1IgtR4uxlsAcy5ZUutY8TcDscoPSkHOGTZkwHRgF9+btxASslyAc3Kblfb5RHckkSYtkiJhHWxBSIQI6uAvAdxDxL9D5dsY6qj1n9xYM00pbiT+VfMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(366004)(396003)(66946007)(66476007)(5660300002)(956004)(54906003)(4326008)(478600001)(52116002)(31686004)(16576012)(44832011)(6916009)(8676002)(31696002)(8936002)(66556008)(86362001)(26005)(7416002)(6486002)(7406005)(36756003)(2906002)(83380400001)(16526019)(2616005)(53546011)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b3BGSEs3dTlpZFV3V25CUUVuZDFKNzRnWmlkYVpUaDlwenpGcm1SbmY3UDdh?=
 =?utf-8?B?QlFLT3ViRFdTTWNOYTNCeTlSTWhNdXB2WnprMVgzVXZYM1ZxdFlKT2hJbURI?=
 =?utf-8?B?N09mcnVtM3N2VGFSNzZKUFB2ckNhUlVaNVhDUE1UR2lmQXVvWVR5c3dvRGpi?=
 =?utf-8?B?V3pEMDZXRy9TZWd4bEdPbVpjOW5CVnBUSy9jbVVUa2hiSTRCTUJYRlI4QTBU?=
 =?utf-8?B?UUV3ZE9MRWE4Q3ZkaUlzbGVPNDE5Q25vUFY3QkREdWYxSlBZQzZ3OUE4WHpj?=
 =?utf-8?B?VlFKTG9kNDh1SndzejYrYjJCeHN5Rm1TUWlpSzV1Y2pVZ3hnSk9USTRjWGlt?=
 =?utf-8?B?UmJDL0ZNL0trUGF2OEJoQktOY3hneGU4dmlkM1NPOXNoZmh2c3kzY20yamRX?=
 =?utf-8?B?d1IwTDZJM2hlRWtoT0h1Tk5XUjN5cXFjS2d1TkR1aXRZNWcrRXdkOEFQNW1F?=
 =?utf-8?B?RWw0dTMycVFRR294WXpYb1lHN0RmYkwvZXhNVGpmcisrdUdKVTFtaVhxais3?=
 =?utf-8?B?NGh2K0hUTjFPL09iZHBtWnpUSldSOEd6Zkl4WWY2am15RjdYd2U5QVYxeG1i?=
 =?utf-8?B?Ny9pTnBBY0tqbm50dXlBa0FhN1gzUGhkZWtqdkRsaEJDVVJXRk4zNjJEVldN?=
 =?utf-8?B?MC9yQWlwbERiNWh1cTRnSGJXTmZGZWRVUEpUb2JyOW1OMVhTYkcwS1hUYmZh?=
 =?utf-8?B?OHplMDI3YUNqMVl3UTZBdHR6bjhxRHB6U3AzTnZoQWVCWjRWWjA3OVVFbThO?=
 =?utf-8?B?dktHeTZYOTN4bi9zWnVUUlVmeW9rL2lHemtpWmVmWlhhM3UxT1BVQ2tmcERO?=
 =?utf-8?B?d3MrZHZ5VkNtNDBESDRvVis2KytRdzdSbmZjSnFvUlV5U2dsTVpacU9YaXNu?=
 =?utf-8?B?eDA2NGY2K3RrV3hlVjRVdXNySWFHbFlpdFliNitCNWc4eXkrc01JYzJYU1hv?=
 =?utf-8?B?WldiMXR2a2lsRVlSZ0ovdUxDYjNaam44TzhzdWEyOU5RU2M3Q2ZRekFndHZ6?=
 =?utf-8?B?SmtJeGtXM0FUREhqYmJlTXpBOHdHVEpUUC9KUGk1MmVIS0J2ZEFJaVVCYnhY?=
 =?utf-8?B?bFVyaXh5NXpobHQvTVdzUFA2VFVIVVFPNjJIVk1qakQzTkdhaTNkWHkzcmlq?=
 =?utf-8?B?bGZOc1N2T2VnZEczcmhrdmYrcEVVNFF4bkx0MXJhUTZTUk54dTRYUmhxeE0x?=
 =?utf-8?B?R1liaUpUd1g2bDhvMjlFRWFSdVBuUU9wWGwyaGxoR29sU1hxdGxjL3pOUlY3?=
 =?utf-8?B?a0lFRG9RVWhUN1lYc0l2RVVlZklubVppYWJSaTNqTlkrc3RUWHV3TmZoYlc5?=
 =?utf-8?B?S25BcVMxWjVZR3hpNis4TmxtYi8vbnRMakQ3Y1BzMmlRdndvZlNRWlE0MXNF?=
 =?utf-8?B?Y3ZQM05NNkR6VTdMVWhCZkdKUFpkeDZHRUpNMVQxb3lZa21uNnpWS285YzR2?=
 =?utf-8?B?eE9pdFM2a0JwOEJyQVY0MmFXNnFRZjhuOGdMb0FiWEt1YWtPOVliZUs2RWRh?=
 =?utf-8?B?K0EyUktMMGg5MkpvbzF6S3NFOGVobHZqMTREU1lmR3k4SUxoYTVOUVhXVWV0?=
 =?utf-8?B?U25OWlFOTzFTL25oSElyYmpKb202TjdSdzhzS0xvenVEaDJ5NCt4amV0MHN5?=
 =?utf-8?B?YkE3czRmeTd0YUZGT0U3MURGNFZuRS8vcU5zWnFDL1pvdXBTUlBnMlI3dHgz?=
 =?utf-8?B?OWRSOE0yMTZ1eHErTkpzV0tjQ2Z0d25acHNlTU1ONGVBb0w5THZ1bmFZS0lm?=
 =?utf-8?Q?+9ydZ+9tI3d2hY2gq+Rm2mFVQ3YqWgwL31ceutS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa7a275-68fd-45b0-0d3e-08d8cf9debd6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 21:34:04.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhTIVDJYXc3AqAiTy8XmTS/VGp3hRQ2cAO4JD57X98U2Y+PbcmL8whFxeww3zP31tR2Ymu8vxK4kP12mZg/gIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120159
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120159
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/21 1:18 PM, Peter Xu wrote:
> On Fri, Feb 12, 2021 at 10:11:39AM -0800, Mike Kravetz wrote:
>> On 2/10/21 1:21 PM, Axel Rasmussen wrote:
>>> From: Peter Xu <peterx@redhat.com>
>>> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
>>> index b8200782dede..ff50c8528113 100644
>>> --- a/include/linux/mmu_notifier.h
>>> +++ b/include/linux/mmu_notifier.h
>>> @@ -51,6 +51,7 @@ enum mmu_notifier_event {
>>>  	MMU_NOTIFY_SOFT_DIRTY,
>>>  	MMU_NOTIFY_RELEASE,
>>>  	MMU_NOTIFY_MIGRATE,
>>> +	MMU_NOTIFY_HUGETLB_UNSHARE,
>>
>> I don't claim to know much about mmu notifiers.  Currently, we use other
>> event notifiers such as MMU_NOTIFY_CLEAR.  I guess we do 'clear' page table
>> entries if we unshare.  More than happy to have a MMU_NOTIFY_HUGETLB_UNSHARE
>> event, but will consumers of the notifications know what this new event type
>> means?  And, if we introduce this should we use this other places where
>> huge_pmd_unshare is called?
> 
> Yeah AFAICT that is a new feature to mmu notifiers and it's not really used a
> lot by consumers yet.  Hmm... is there really any consumer at all? I simply
> grepped MMU_NOTIFY_UNMAP and see no hook took special care of that.  So it's
> some extra information that the upper layer would like to deliever to the
> notifiers, it's just not vastly used so far.
> 
> So far I didn't worry too much on that either.  MMU_NOTIFY_HUGETLB_UNSHARE is
> introduced here simply because I tried to make it explicit, then it's easy to
> be overwritten one day if we think huge pmd unshare is not worth a standalone
> flag but reuse some other common one.  But I think at least I owe one
> documentation of that new enum. :)
> 
> I'm not extremely willing to touch the rest callers of huge pmd unshare yet,
> unless I've a solid reason.  E.g., one day maybe one mmu notifier hook would
> start to monitor some events, then that's a better place imho to change them.
> Otherwise any of my future change could be vague, imho.
> 
> For this patch - how about I simply go back to use MMU_NOTIFIER_CLEAR instead?

I'm good with the new MMU_NOTIFY_HUGETLB_UNSHARE and agree with your reasoning
for adding it.  I really did not know enough about usage which caused me to
question.
-- 
Mike Kravetz
