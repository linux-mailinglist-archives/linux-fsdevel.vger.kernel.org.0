Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F430B3D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 01:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhBBAGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 19:06:42 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42466 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBBAGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:06:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111NxktJ075338;
        Tue, 2 Feb 2021 00:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=789AokD9RJGasym9ZwiMyeuxyEUAh5ZDEm8a2nt9geU=;
 b=zgcsfcPt1ML8JkcK9sMUADJ4z+GfkmIgw9VfGlSQIPeiRH51zF5rFgom0DDZeL0a7L+I
 /kJ1bvvnRCry143i/Et7Y83AFrEr0r5RLeg7Hwwqv5rBsIIsVr1NsJ3Y/U3YNvsLh8vD
 OHZkFApKNRIiv+L5ftNfxqm62+mnya7EQ7TlPa1ZNFTJOBZCFdasixemY+NBiMq+FJwR
 1b2rVK8uRzps1Y5P8zUx46eSO3lmMhpO6TphSuThdAxx28sy7h7F2bVgMFgdIRo9XCNJ
 0P/zwTjZyhbpcKbAi0VpgEGWKjFU8jlVPFMEcypJidLXIsR7Crn9PF/XZkcdm+l3O0Cl jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyarb2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 00:05:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11200ttj093459;
        Tue, 2 Feb 2021 00:05:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 36dhbxdd54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 00:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9BbMmSE+k0IqIuD8++z6K1hoPYwY69GaG5Hrgbmkh2lWa2ntfl+WakbQU/w3ErSgI5otdnHjEjamZcmqXR8NRgG+4SXeipMvNZuqC/i3IQ6Hk3U37MMtbdTuQw9E92cFlAdsRtJz0dt7nyT+pMwT7Y56QC8iFvQHSyYNrERZCuoEcc6ZrEHN9K6kRKM7FbK6r4+mm5uBqNR3owejCvsEnlgpspsI1lH8v5FDNHjFMqA73jKGLVEwATt2UCdm1Wrk4SG2AW/pyE1SomgPzNkEGvpvUs0OGe04eUQeYcuOs4vit2O6OVOt1dfjzm7q0aclC+atGCFeAp4C12djmp8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=789AokD9RJGasym9ZwiMyeuxyEUAh5ZDEm8a2nt9geU=;
 b=EARDjGWaETl/bvuTekESHuVQcXGrgbu19D4rg9tydjZ/Kb4Nu+LhAC27mf90Dn0uDHZX9tEurVvdD+JxCf4V2O90DZFfVOLw7PZJgnGNyaRxB13+Y4tMpBMSqG3u2o91TT69gX72RBpHIUzMIdGSIdKpi69bwrbcuzZyMN4czeTGLVHl3lcObdTf0ElSi+L5LlfMWx3DHgd73xQ3pOdo1PzLNL4RFL+sl6/kxkYGRuD+uasT9h5OBirl23uEQ3ZIvqbXb8FaCHRuhkGt/7/Xf6tXmJwnBgvMklF4BQb5aBo6YTFc9WtEoCNKz0kLuvdyBkN4XqmHK7qo0RZ1oov1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=789AokD9RJGasym9ZwiMyeuxyEUAh5ZDEm8a2nt9geU=;
 b=A+0xaiEY4v8Ld6oaOFABQ0/YJgD4o1/cCJtJOlDA0n5DuTknbSngYyKQiYx1s70PxdrY68w3tgWC0rE9Ubm+0gVJuSYpWA4bicv4bdL1MufeXx/R53CiS2QksCiMhjKygDt9e43Llwk9uner+FACogaf4HQx1zfEVtw6luDNcGk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1936.namprd10.prod.outlook.com (2603:10b6:300:10c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 00:05:06 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 00:05:06 +0000
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com>
 <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com>
 <20210126153448.GA17455@linux>
 <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com>
 <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
 <CAMZfGtWCu95Qve8p9mH7C7rm=F+znsc8+VL_6Z-_k4e5hAHzhA@mail.gmail.com>
 <e200c17e-5c95-025e-37a7-af7cfbb05b18@oracle.com>
 <41160c2e-817d-3ef2-0475-4db58827c1c3@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b854ba65-fc21-658c-a397-65e5c66d1b8a@oracle.com>
Date:   Mon, 1 Feb 2021 16:05:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <41160c2e-817d-3ef2-0475-4db58827c1c3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0033.namprd11.prod.outlook.com
 (2603:10b6:300:115::19) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0033.namprd11.prod.outlook.com (2603:10b6:300:115::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 00:05:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 688c7b51-f793-4e61-0236-08d8c70e3296
X-MS-TrafficTypeDiagnostic: MWHPR10MB1936:
X-Microsoft-Antispam-PRVS: <MWHPR10MB193680CCC3C3670B1B984918E2B59@MWHPR10MB1936.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqSHK3MRY+cTXSyHO7dbHGBz3LGAGHIHYOYpUvktToofVB+qGYXke9tYLsR+lDftzSH6fMRYlkOTPsx8fbv+EIrl2jPBcmSMs1Z1UAltKhkIYGAB1g7gDKxp6gF144iH7K+xQfWwzAo++sZkwdXWAiXzthGMaNlAEJiESYAuxAr2k1ULJsehPbgLL9CIzWgVVaseyW7asiOb5smINlfscw14TkA5FWGhveyPKbTJlNzhdXJm7og+bNAl5J85kKkfg5DKZXqhDLn1FMwTAwHbFr/n10qzt02n9n46C4RnohF3XXZdyLX7Xjmu604XlBEuZAZ/B2lNvAqpeaHrVA3y1Nf0fzqHkoxpl3Jyl6yIQOkGOrnt9awlUpG0EuJP+PIAnTPQOB2yVCg6Nb1XvFLSTHH+Z/TXb7z2p/XLvEtuzU1K460LCJ/2LWTkh+2O36LI5VI8F4yiAIG69JqMmpl2V5RrMsacC7Pqy9BpRD2wFNANivM6SsnJa3WnXwpZ+vpzoqbmJ1qV3RjhWEPfxL2LyYw2QMGBCLRP2VAtpuw+xdAh+fOMgTKAzSxgVruVY4HSq+Jcq4Ka9/MluFazj7tccOjoKg9kM21FvfyB8mPS3hg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(39860400002)(396003)(5660300002)(36756003)(7406005)(478600001)(956004)(7416002)(83380400001)(186003)(2906002)(16526019)(44832011)(66556008)(2616005)(6486002)(26005)(66946007)(66476007)(31686004)(8676002)(52116002)(53546011)(316002)(8936002)(16576012)(4326008)(110136005)(31696002)(54906003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cEloYmV0dkpsMmVndkFGd0FFdzZ6NmJSelRWVENOeC9tNjRXZ3dMcHQ2eDIw?=
 =?utf-8?B?OXdzMFBJU2d1SFg5aFh6TDBCZjVqdkQzbEg2Z3JZQS9OenpQNEJqcDlJRkky?=
 =?utf-8?B?K080WWI2RGMvVnlIdTNhRWRRQXUyaDd6MnFLTnlXb1h0QjdpN2V6Z2NUVU1n?=
 =?utf-8?B?TTlsVGViTmwrNnpTUHE1NGhBK3JQVXk5SmhkUEJBa2xrcnU4WE1yVzdxeUcw?=
 =?utf-8?B?Mk84aUlhM2xJdTdjS0ZrcDRlSGVCamw3dmpqQkt4dkozY0lkSWI3eUhZYXl5?=
 =?utf-8?B?UDlyOHFSZHpwUmRnL2h4MUdBZ3FSQUVVMkE5a3ZPaWVwMUtRaHFjYWN0THpU?=
 =?utf-8?B?Zm0yeWM5M05zRk1CM0Z5UnVPUXB5RDRkZ2VaK0VmMXA5K0lWaFRXOXVjUklo?=
 =?utf-8?B?YlY2ZkpJNjVHWUJHWkpOMDhOcWEzNzAxOGEwT3JKcEtuZkR1cnFxbFRLb2sv?=
 =?utf-8?B?eGNwY1BvMDhLOWtXNkkyS1NCZEhncUFPM083RDZTUnBNekpkeVlmWHQ5elY4?=
 =?utf-8?B?WStBVUYyUUh1cVpWcy9FSHNYRHkwUlJseENxQk8yRnY3OW5mVnJSenBtb3lu?=
 =?utf-8?B?d3dYcFBBcE10Z0kxT1pBSFlGdGNjckpMZE1IZ1Q5L2lGTlZoVDRlZWpZdHNt?=
 =?utf-8?B?T0pKcDZTK0ZocWMzcEJ0QURDN3JqVjN4QmNDUGFaWEZvZjNFbHlmQ1RpVmNB?=
 =?utf-8?B?aDB5R0RxOVppa0d0akdkb3Q2Ykh1a3ZpNjFrWnJYYUpKd25BZDN2aWNlb2pX?=
 =?utf-8?B?ejNyczBBZlZ6alpYZyt0UmtVSU5DTEpDZHp5N0R5b2dZbnl4b2tCT0xhN1p6?=
 =?utf-8?B?MnNPUTlBbW5EUm4rcmd1WlRNVzZ2WnZwY2kxOHFFR0Zlc3pIUHowVW9qTk5v?=
 =?utf-8?B?TTBhRFpjY3loTEVKdEZvdkhHL3pQZnRSa093MDlsYTE0a3NjTkp3M0NVK2cy?=
 =?utf-8?B?eGxzaVE5ZFhrRXJHaVR6ZS95NVMraThqMXZuZ3lLWll5a1FKZ1oxazdHUVlK?=
 =?utf-8?B?ZkowcUJDZzl1djlCZjZXQWxDK2ZWdWhBNmFGS3VWN3hJMWZ4Wm9SYytKUWxX?=
 =?utf-8?B?RjN4RFg4dmpCYWpqWDk0UHQ4VHNJWFlNREgrTElBTnF6ZVFRLzFXM3BhYmJR?=
 =?utf-8?B?Q3lQdHdxYm9pNWdhMGYySWo2L2owT1VSQ0lENW1OVjFvdFU3VUVsSUV0UjdR?=
 =?utf-8?B?MU9kMzBLUnNsNVlCaGxaMTF6SzhrWEduTGFsM3lneHFxVEFlUEpnNlRsdDJx?=
 =?utf-8?B?bCswWHoyVTJxMTRLcndyN1gvUU0wL1lQVHZXWEVCTjFxU05HRkYwLzVTT2FW?=
 =?utf-8?B?SUozMjhtYkpIMDAwOWlMeDAzNUFVR0ZvazZhVkNSdG1ZTTI2eDlqMEpNMnBv?=
 =?utf-8?B?alo0TU95NFFRQkJmNlBINXVuenhrelo5YXFieTRmci9VY0FrMFEvRmZTZG1Y?=
 =?utf-8?Q?LaxBWha9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688c7b51-f793-4e61-0236-08d8c70e3296
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 00:05:06.8245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT4PGq4/xuT/WZ0CYeIsyDzZDz/nBHBcqF6K1perM8keVv5OqhXWcC+Hp58NU05q6hHq0pdyTLod/uNN55iXMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1936
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010136
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010136
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/1/21 8:10 AM, David Hildenbrand wrote:
>>> What's your opinion about this? Should we take this approach?
>>
>> I think trying to solve all the issues that could happen as the result of
>> not being able to dissolve a hugetlb page has made this extremely complex.
>> I know this is something we need to address/solve.  We do not want to add
>> more unexpected behavior in corner cases.  However, I can not help but think
>> about similar issues today.  For example, if a huge page is in use in
>> ZONE_MOVABLE or CMA there is no guarantee that it can be migrated today.
> 
> Yes, hugetlbfs is broken with alloc_contig_range() as e.g., used by CMA and needs fixing. Then, similar problems as with hugetlbfs pages on ZONE_MOVABLE apply.
> 
> 
> hugetlbfs pages on ZONE_MOVABLE for memory unplug are problematic in corner cases only I think:
> 
> 1. Not sufficient memory to allocate a destination page. Well, nothing we can really do about that - just like trying to migrate any other memory but running into -ENOMEM.
> 
> 2. Trying to dissolve a free huge page but running into reservation limits. I think we should at least try allocating a new free huge page before failing. To be tackled in the future.
> 
>> Correct?  We may need to allocate another huge page for the target of the
>> migration, and there is no guarantee we can do that.
>>
> 
> I agree that 1. is similar to "cannot migrate because OOM".
> 
> 
> So thinking about it again, we don't actually seem to lose that much when
> 
> a) Rejecting migration of a huge page when not being able to allocate the vmemmap for our source page. Our system seems to be under quite some memory pressure already. Migration could just fail because we fail to allocate a migration target already.
> 
> b) Rejecting to dissolve a huge page when not able to allocate the vmemmap. Dissolving can fail already. And, again, our system seems to be under quite some memory pressure already.
> 
> c) Rejecting freeing huge pages when not able to allocate the vmemmap. I guess the "only" surprise is that the user might now no longer get what he asked for. This seems to be the "real change".
> 
> So maybe little actually speaks against allowing for migration of such huge pages and optimizing any huge page, besides rejecting freeing of huge pages and surprising the user/admin.
> 
> I guess while our system is under memory pressure CMA and ZONE_MOVABLE are already no longer able to always keep their guarantees - until there is no more memory pressure.
> 

My thinking was similar.  Failing to dissolve a hugetlb page because we could
not allocate vmmemmap pages is not much/any worse than what we do when near
OOM conditions today.  As for surprising the user/admin, we should certainly
log a warning if we can not dissolve a hugetlb page.

One point David R brought up still is a bit concerning.  When getting close
to OOM, there may be users/code that will try to dissolve free hugetlb pages
to give back as much memory as possible to buddy.  I've seen users holding
'big chunks' of memory for a specific purpose and dumping them when needed.
They were not doing this with hugetlb pages, but nothing would surprise me.

In this series, vmmap freeing is 'opt in' at boot time.  I would expect
the use cases that want to opt in rarely if ever free/dissolve hugetlb
pages.  But, I could be wrong.
-- 
Mike Kravetz
