Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594E33255D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 19:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhBYSuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 13:50:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43910 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhBYSuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:50:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PIYpkY049716;
        Thu, 25 Feb 2021 18:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Vxes36Qnz2vXs1LoOGy/DV1sZnh6f5CbUfeod5l9hPE=;
 b=B9AzW/NDFHjJZQKEK3zq/tLmmq5fE/ZEV7H5Z0h2woww4I2E5TtyIrMNh05Mxba2LIlG
 dmgB5LyZps+w0HXl2liYM27BpjWh2FnpaG7ukWD+KMpZLxZVTR7v/w2mNWeuo+o6UibH
 NqGpNoyOxpGhmt1qdhyxVb8mr4/WY4Kz1UzjQyLRfU0YgEQrYUIB6RvWjNoYp8re6CxR
 ccGMn9ExwU3QerfFAksNbsiXUrRbbzEjcmzl4TfCbw2yD+Pv4pZHnukNPQSTGui08zvE
 Mo3T0t8XZe0S6Id3rtEUAOo7s6bBjJz5ZatWvVUgPXPUhR7p3hssuiEdlPwJ//UaA7K1 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36vr629vk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 18:48:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PIagQA074230;
        Thu, 25 Feb 2021 18:48:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 36ucb2dny4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 18:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckVPjlxGARpoqgdp7RsbQWrOtyGnP1VciFNmuu9Z4sFubm7lVUhqeJSrbh9RynnWsN7tF8IpwJVzY/pFCXMk2A8x7vs+3QYURhVCSMsNxjNYciQ/Hy9ULaK2VWROPHEPsYNRWfkeBWXeO3d2g2esbwXFRvOBQEo2sqiD0SatsfvTaO79yAWxnlY+egOr6L2yZGYXA6TC6ko4S8BXWcmdW8fi1hjg5fC4gZGbUdrCYLPq20/WQ1Ipf5XI9vXxfhZTa8Li6XZTjgEYUFGybPEI6jtMLSbSmdtg7ufb4rsFiiw5qqptztdnxTYws4DJPYWszdY9qji9rbVC+QO/l2zizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxes36Qnz2vXs1LoOGy/DV1sZnh6f5CbUfeod5l9hPE=;
 b=hgAbMl1qKpmRDhm2zjUWqURIIAzbI4kNkwqIax/rmUc+1OCa/086hmXS1EtTDDIH58+V8WPT3OHokQPeSlCH/b3IX+doXsgsnM85VEX+Cx79Eyvqp3rKy5c7EOjFK6j5l3VW4T74twlmlD3MkMCTdmbdIaAjGCxO19uM+3Uu1cBjKjwVel/UP+I9fwHuB1HpkO67C7f1WJt6aHL/lJ4hcK0BwHCeyVwYKI6kb2i38YUo8IArimN3Dr6TbSqWLvOSo9HfSFIZUpXOPHgte0coEZAUGqeWdpMWyaUvlPPxiifDCFoW4/dDZpT1U6jpvgQNGTiMunUYF65YyB+27L6Paw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxes36Qnz2vXs1LoOGy/DV1sZnh6f5CbUfeod5l9hPE=;
 b=SGWTj1fHKEmQdSpggB/6VhWXHNGSs0vtS8y4+sDkmjVxfs0ts3uM/sqsnt1UywGComJtkczq6x55RQWTJA6fyC+P+Ig43VLxEe0kf85tA2NYwMV+Mu2aX0oZe+N4gaYy3GrcqX1KtxufvuF6/q3WMn5+ZJsFEDnTy3iu7zQKGyk=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4356.namprd10.prod.outlook.com (2603:10b6:a03:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 18:48:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 18:48:07 +0000
Subject: Re: [PATCH v7 1/6] userfaultfd: add minor fault registration mode
To:     Axel Rasmussen <axelrasmussen@google.com>
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
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
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
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210219004824.2899045-1-axelrasmussen@google.com>
 <20210219004824.2899045-2-axelrasmussen@google.com>
 <6aefd704-f720-35dc-d71c-da9840dc93a6@oracle.com>
 <CAJHvVch4iweAW274Ub5Q_oKgZaTHvEkGnE4=jo6SfxOs1qCf6A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0c0c8e86-cf60-12d1-2260-2a7215493fd5@oracle.com>
Date:   Thu, 25 Feb 2021 10:48:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAJHvVch4iweAW274Ub5Q_oKgZaTHvEkGnE4=jo6SfxOs1qCf6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:301:4b::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1401CA0021.namprd14.prod.outlook.com (2603:10b6:301:4b::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 18:48:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bcadf89-bc8a-4d0e-6b1d-08d8d9bde42d
X-MS-TrafficTypeDiagnostic: BY5PR10MB4356:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43569919098A6D351F1A42BEE29E9@BY5PR10MB4356.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1UmIUu+TYv4rsTRVKIm7D/ydOOXH5z3pY86oIvBokYdIIn2a2YLHikd1sldibs3pvXfz1I/KKO/f5gJvLkllcchWbEpYvShdhi8M+7SxAh67n+srs5kpFYRoQ80zltVRLBPfxU4rx24awtguyX4Q9eMenloHE2y0yHmcZDbEHCEdNBN81jz3IA7lm6k1zwv+xxqzQuDoY1MKk5XBGRG4/yuwPv2O8InkxBWJUoYzu9Lh+BWkDEp20JIunPt8WP7rFCSIaakyYQP+xQHiz1Sj0/yE12Nv2YDenyRW9SCJQYYFCvUuQGiFGCzszEWulyg61GnssYvJT/G0fZkR/Ro8WhaR0OI++NiH472xc0Y18UWh2jyyV90FXSnBAUs+YnkYhRcqFAtOrB3guOwe6b4ft/XND+vmbBCLfsL1n1Vmsi9SGVnItigFefDTjDOY4mQHTdvyriGlDl1Vklr5Jr4dr6kDEtn0x9hUTBGHwl8t0cHqRrt7jM8+JDBQcGjcLaW3CnWuk6YfjZcaPfEKG4WvwQxWyZuBdCcA96bCtm7D2xVW4ZnLB6pySJQXRlj1FALY7lBIL54jNobUeuZcVeiNKmtuV0ljWIBTvecUklkP+s08hrH5iCap3JjL4we6dAvh1vDsaOiRLgubag2U8owlgxQuML0W8oWsnDlOodApD9yklIK68IAF1o8SY+HrdmB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(136003)(39860400002)(31696002)(5660300002)(2906002)(36756003)(966005)(6486002)(66476007)(478600001)(2616005)(52116002)(956004)(186003)(316002)(54906003)(16576012)(44832011)(8936002)(31686004)(8676002)(53546011)(7406005)(66946007)(16526019)(86362001)(7416002)(66556008)(26005)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2F5eDFZZzIwc0pCSHRxV3hrUmF6VW8xY3laU3RjSXZPQUdFTFpvdndUZWtH?=
 =?utf-8?B?a1B4L1NYc2ZsQjNVbVZlaG9sUXQ3Z2NqK1FLd2M1eGJqU2U0dzU2UDdrL01T?=
 =?utf-8?B?ZkxqaElVS2ducWs5ZWkrVk5ybDdYc3puMEpjSXBKQkVRN2tiQkpCMFNZV2Q2?=
 =?utf-8?B?eDJoa2gwWEFiVjB1V0ViZ3RRaENNQk1FYnpMM1N2YXR5VS9tNEUrakJMK2c2?=
 =?utf-8?B?S3Byb2VQRUYzTnUweGcrY242bk9RZjcxbFJiYTArKzhlMDBnMHZrVURKazJO?=
 =?utf-8?B?R2lOR1NVUXQ4TC9mMXltcVc1MFFkY3ZwbDJBNlJlc1JxY3AzZzYyRDh2Z2Jv?=
 =?utf-8?B?QUxCUURQd2ZTcS90dnJpbHV6UnpoWGZvODYrOTJrRVV6QldIR2ZTQjdxZTgz?=
 =?utf-8?B?blpsVmpONjN3TmgwRmo0L1JjTGMwNTZkSVNzMGl2aWMzZGhZeWcyOGpCK1JP?=
 =?utf-8?B?UDcrMUF1N3F2TnRzR0NDTGtRRXNOZkkxb1BGRDQvUTZDTHMxYUdJaGFBcU5n?=
 =?utf-8?B?ZkN3eVRYekRrMlNhSXlSSnUvTXkyWmFOSEZxcVZwN0RQZlpHbVNtdkpscEJI?=
 =?utf-8?B?NWZqVnJqZUFOeWRmSzdUcytZeUF4cGoyNEhpOXdlVDhKeGNDblVQdXE3OGFZ?=
 =?utf-8?B?L0JlcFVXcnhBQ2hhd1g3R0NWNWh4N0FvQTlPU29meDdxb1RnRHVnTW9oUGNX?=
 =?utf-8?B?TC9mTFBXdWc0VDIrSnY2Zi92ajNYeVZJR0lBRzBxYXRlTVArS1dOVERVV1c1?=
 =?utf-8?B?blNtWXgwSEU2S1hEVjd4UkxYNHV5L2twWVNKcDE2TGpoazR2OUVSV3MxSU9V?=
 =?utf-8?B?SzNSaEhhZnE2cU1SYjBITENjZ3pqYjlUOCtJb3BHUXZrZ2MwYVZGTy9IaDl4?=
 =?utf-8?B?eDc3UUdGS3p5WGlGZkE4d1ZIQ1pEdDZ1MzRLdHcyTStLb3ZUSlFaZ3ZieUdq?=
 =?utf-8?B?eWxNOE1sdzJoOGZHYTJZM3cyRVVySjJqMWxNem50Z2JPeWx4a2txRUZTTjds?=
 =?utf-8?B?TEkyMXJXODZoOEpMbHF4WmpYL3NiaTNIQ0xxRDA2TCtLOCtDYjNDb1J0VGFM?=
 =?utf-8?B?aTR4ZTNVd3BremY1VnJ3RC8xY1FWWWNDVjI4ZkFSdzJoWEtiaDA5TDZwSDR6?=
 =?utf-8?B?ZGo3UGVhL3pTcWdmV3BTYU15SUcwbVFIMjNCN3dxNlhNalJUY3BKaGFwajJD?=
 =?utf-8?B?Zmk5L1JoZnpPbWhxZHFPSzJ5MlpSUmoydldLR1dFMHVGV1ArZ0haSnB4NUVD?=
 =?utf-8?B?ZVJ0TGZZR25NMlE3YzA2T29ZNXpJYTNWSlcyMCt6eXlNSHZuS3d2NXEwZUhD?=
 =?utf-8?B?ZFZwWmlRNFo5dmIvRDltb09ZSDM0WExwcGwyQ0dTcS9SaktBTnRKSXVZeFNj?=
 =?utf-8?B?ZWRCVzhwcmFYeTlrNzVIU0VuU2VSUDBYMEVvWDJqSmhIOFRuTk1jMHBNOXJh?=
 =?utf-8?B?Rm5jSm5jQkxTcXFtT2FUK1BwTTY5eWtYTmNEb3ZMb0hLQXNRaVR0NnpqQzhB?=
 =?utf-8?B?NHlTS2RibnRXMWlZK1A5aHpmcmQwT1lPZnQ1bDJaNFhhVmVxTFlPM0FVVlBP?=
 =?utf-8?B?NkFiVFF0allPUWtCNjVrcTR0cTJSRlBoYlNxUHYvT0E1Nnl5VTNKQktHYnRQ?=
 =?utf-8?B?dmk2dk1PNjU2MDluNXluSTY0RFQ0THJMdGRoMWpzdTZHYlpnOWhiT2sxKzNt?=
 =?utf-8?B?WjY4WHFMZEdabTgyTVVuNlJiTURGNG5Sa0hNOU80QTlFOFZnb2hPLzYwSGtK?=
 =?utf-8?Q?M1aJU1jE2IHSRicZvFWngL4soj9llnOWgplkBQi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcadf89-bc8a-4d0e-6b1d-08d8d9bde42d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 18:48:07.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFmBleoTynCIrSviMcezN0mOxdpqQ/LhTxJWq9sr6eiDS7lOfYDAVjusdZjLVFoPifBTxFLwE+AmSKVbdfRBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4356
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250140
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250140
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/25/21 9:49 AM, Axel Rasmussen wrote:
> On Wed, Feb 24, 2021 at 4:26 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 2/18/21 4:48 PM, Axel Rasmussen wrote:
>> <snip>
>>> @@ -401,8 +398,10 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>>
>>>       BUG_ON(ctx->mm != mm);
>>>
>>> -     VM_BUG_ON(reason & ~(VM_UFFD_MISSING|VM_UFFD_WP));
>>> -     VM_BUG_ON(!(reason & VM_UFFD_MISSING) ^ !!(reason & VM_UFFD_WP));
>>> +     /* Any unrecognized flag is a bug. */
>>> +     VM_BUG_ON(reason & ~__VM_UFFD_FLAGS);
>>> +     /* 0 or > 1 flags set is a bug; we expect exactly 1. */
>>> +     VM_BUG_ON(!reason || !!(reason & (reason - 1)));
>>
>> I may be confused, but that seems to be checking for a flag value of 1
>> as opposed to one flag being set?
> 
> (Assuming I implemented it correctly!) It's the logical negation of
> this trick: https://graphics.stanford.edu/~seander/bithacks.html#DetermineIfPowerOf2
> So, it's "VM_BUG_ON(reason is *not* a power of 2)".
> 
> Maybe the double negation makes it overly confusing? It ought to be
> equivalent if we remove it and just say:
> VM_BUG_ON(!reason || (reason & (reason - 1)));

Sorry, my bad.  In my mind I was thinking,

	VM_BUG_ON(!reason || !!(reason && (reason - 1)));

-- 
Mike Kravetz
