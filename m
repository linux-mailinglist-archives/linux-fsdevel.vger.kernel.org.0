Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A583082F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 02:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhA2BII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 20:08:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49480 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhA2BHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:07:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10T140gQ091288;
        Fri, 29 Jan 2021 01:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GY0YClb9ibNdjvt0wz9i68Gu7oFX74vT33q2+Ynm0HY=;
 b=ufHRsQPOGA2bk0gFgagOCLPNqrzybo6QYcFWTUqF3e1gPwozqfInDJ4WwOsXMOanoSzi
 PGk3hkKcKKbNmDT7FSe0yVat3wJWnCwBIk5L0KMufM0qHKjAjrbGso5gVE4Jb9x5Jo5q
 aUjaAzvQv+e21kpAuxD5332fKPmHYxjXMu3mSMuT//7SFIlKMoVJcDUjine/8ZYQP8Rn
 B9nA6HaPdQOjftwsUMQYSfxI0ApL8OgRVmigIh5VwJc6BNLqJdQ4DLb7Rt34DQBzdTLK
 dhiKjdltqOVGw5y1A1CsdRuMSJtC609np0g8EAyvVNZxbipL61P3Zlsq0d8YTfzQJV91 aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 368b7r6vbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 01:04:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10T0dtK7084325;
        Fri, 29 Jan 2021 01:04:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 368wjutub8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 01:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXZZXx70Fq5jLWBecyKCVRy/hU+PzChOvc+0lMK8nCPSY61zU1jkROgDYa+mWJKhSFrqHA+6cpeGJjveGPRgNPClyiD+ckHjdlq3YIKUynSfHf9Xww0or2PbGuHA5jHtVTabLNCX8MYJnnJva4q6MPCcJSV/qTYqQcp7UyeiNOPd9PBt4ACeWE0/3m4G5yKQdwkske1PWRMvgxsAneKUkn48L7uldjieFfSkfS+mcPww6BaP2Li5+rXyRwn6NgHI9Stco08TdeWV/l/HZv7Ig9nU2QL6BZM+/KUOmcm0pn+3rJpLjfCoGkk8X0b+mboXZZ1L+fELFr1q/ORm1UR5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY0YClb9ibNdjvt0wz9i68Gu7oFX74vT33q2+Ynm0HY=;
 b=Ls884xyA2ek34eRkj7WzU6dAkDANhIlUZ39ojOZYn+4TU0G5bhvwNOA5RFg5f551R41GykDJ2/RJJKmTo06FUe5dFBDlgleBuXszVLaFXEMWpx/n+gohsK47diQvHriLjvb5wlzkJxO5x8sXRaR8JbEPcbLYL5NkKge4/XO9Hof4FW5e2KI1zhoWA3X0z5JFMC3Nzrp2zYbtplNRwXZhuOISRaIfBRUQakWafeu8sTL9oddjB0ldKvAxMEy53tuf4BSHfk9kzMsdPofKoN+Ct5f9K75tG34+X21XbdnP0Ree74yacAjItKscLnq2yxHzSJyQQp1wOGqsOLk8o1MCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY0YClb9ibNdjvt0wz9i68Gu7oFX74vT33q2+Ynm0HY=;
 b=sNRwTzrR69wXE9CShCQIiGM8FfCTZz7UtoqBv5Sg2h64CP4o8NQrlFDi0M4OuqiUAS5HNA0oFuh5wfs+ve+y8n1yZ9QaKf1ko1Rt3QchbWGy4437+PURxZJTqk5+iUgt8O7Mxiyi8nXuWBQTmse7SygwBuKyfOqmgh2V+SRoyuQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2109.namprd10.prod.outlook.com (2603:10b6:301:2b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 29 Jan
 2021 01:04:34 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 01:04:34 +0000
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e200c17e-5c95-025e-37a7-af7cfbb05b18@oracle.com>
Date:   Thu, 28 Jan 2021 17:04:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtWCu95Qve8p9mH7C7rm=F+znsc8+VL_6Z-_k4e5hAHzhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:303:b9::18) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Fri, 29 Jan 2021 01:04:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f92f2ee-cc16-4f28-7434-08d8c3f1d739
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2109:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21098639C2E32B56DA052227E2B99@MWHPR1001MB2109.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WZM+OI8KrL0rxUgbgAjtbNcgWZQBo4xI2bPxWGXsLg4d4vKqVMqmL7uVi+Bd/Mz3QN87mGd2muKp2AC1d2JY5ZufcYn3Mg6DYfQ6CnLR3pcOrsSzdZGQLNNnpdBtIDOcdcnMvBJN5x4ZWwOxw+6ojda2vnJPLGKaMF1ob/aEvgHLujbPHr/j/Yp3h+OGOJqJsiGiFUWB4EYWAZjFEt9AMX6N1a6pAapnGJs0dyrpl/CCu9cqJ7EQhNPrt+Jyyn60O19k3AshiYssDTsW4wpsBRtTsuc82AnY8AdI+1fd2D7TDvRexYoOXR+1yYAtjbd8+b7yVyoUuifcE+ow/gSJdc7y2y6VSVhd9z2da20xEuH/iL2YTmNXxw8pFDbyu5F4GCmvJEnTFZ0rdfGPfoJ37GOG82kkRO+DzNxVYoNaCHMRmp42TDY6ixY7a4MXVoVL7Ay5emSixAPDWRC22wAz4KGuNSFtYNJ8UTXGNxL+fLnccsOETj3hY4LJodLWJh67HtBrRFHWXq5chOePGZWrzIAqw5h1nltyTz1Cn3xRc+daiHvbsinR/7oT9fF8xim1upNMBPnJurD1XONFH4ERMWFcJOLZhWAaJzTf39MnOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(346002)(396003)(366004)(31696002)(4326008)(31686004)(86362001)(52116002)(66946007)(83380400001)(110136005)(16576012)(316002)(7416002)(7406005)(5660300002)(8676002)(186003)(956004)(2906002)(16526019)(44832011)(53546011)(66556008)(66476007)(36756003)(8936002)(2616005)(478600001)(26005)(54906003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K0lUeHRyME1uRDhKSEtaU1o0Ti9hYVN2aWV6Y2tJREtJREZ0VGQwUDZQRU9N?=
 =?utf-8?B?VUZDYWdzNWRrQlVNVU9zZUtsZUl2S1Fhci9tV2c3SE40Y0JqeTJNaUMrVmxk?=
 =?utf-8?B?czk1Z25YcURMRzljOStuSnB2YUYvSTJNYnhUcmljZjdlbHNaTEY3VndDOGJk?=
 =?utf-8?B?MlRmbGMxR3Q5eURYQm9GcUx3UzZmUTE2c2hzRkpJNklIQzFxUi9iZVQ4allE?=
 =?utf-8?B?bjFpaDBOa0ovV1NSTk9oWEt4NkZhcjI0djlOYmJsYmk2RmpRdnlja0VHMy84?=
 =?utf-8?B?ZGE2SWIrZFdRUFpFakVsSy9hTGU3ZGh3ZnpjTElTazZhVTBGazMxaUR0cnZi?=
 =?utf-8?B?WEZjWVozdzRLOUFhY3ZQa05mZ2thc3I2ZVc1dkhrd3ZjV2lVbHVaRElQUStR?=
 =?utf-8?B?MkQ0SFV5UEd0UU9OQTQyckhaNWREL0JMTzJUalBrSFRpOU80MU5pa1l1WUZH?=
 =?utf-8?B?cHNCTzRwYS8yOEVYc3pvQm1DRHM5UkxFQjA3emdrMjBLdllKaGVEdUdDNDdj?=
 =?utf-8?B?bXAyZ29NcTBpaGVBbFdnZ0s2bndwbFE1MWpwV3plU2E1aS82NElFSHltTHZw?=
 =?utf-8?B?a202S1ovU1JtUDhReHBnNlNNY0xMOGpmMEI5a2t0UE5adE1RVDExeGxNMkVj?=
 =?utf-8?B?QyswUFlXeUFkSFpNUWY3U2xma0I4RGtZTW1iNFdwTjVjVEJpQU5ZUCtsdU1F?=
 =?utf-8?B?bE1KQjVnZkJrWjNodEp4SDAxam1TbS9QL0xoeFRrQitSZ293cDJyTzNaYkNi?=
 =?utf-8?B?N1U4Y1pSZ2ZvNlUyUVJEbkxqczE3N2g5WDN2T3lMVDNFU2Ftd3M0NmJwRTYx?=
 =?utf-8?B?UngrT1lJMnpJYVo1eFE4YTcyZVZ2UHV0Tmh4bE1YOWNTdXNUN1BoaHVoRFpH?=
 =?utf-8?B?ZHhhd1ZHVk5PeGw0blFBSk9FZTRpa2xnMzB5N0VPbFhPNE16UmM3Q3N0U1Fy?=
 =?utf-8?B?OFltdzdEbktFT3NMYlF6TEJvbEo1R3NLR1NmUHFuTGZkY3l5bFBzb0x5MkM1?=
 =?utf-8?B?R2ZjWWFvaGNObEs4L002eEFMQTNldms3V25jamtwdmZpZUFCUzJ5MmQ3cFpk?=
 =?utf-8?B?TVZwdnRnSDVYUjVsNjJ1RWNSRlB3OHhua245Z1dvRHJEZ1Qzc2tlZjRubC9q?=
 =?utf-8?B?NTdlOGlZYy9Hb01BeHd3Rmh2QjJDbG4wZEVxTWdnZks3WFpQZEU0cGtMWkZo?=
 =?utf-8?B?cVJHMUpUaHF0dlpLOGEza2JBR1RCS0pOYlZBSTk3cVR3bk00bXBWL1JKSDg4?=
 =?utf-8?B?MkVmNTBhNG1qTGNhVk43Mm1hN1NjZG5Zd1JPOFBMMjdYcXZ2OWJWT2xuTCtk?=
 =?utf-8?B?aCs3djdsNFdkN1hDVXlCalRrWUpHRWFVdjlyeFlFUEVuUUZFTjZjT1Y1a0t0?=
 =?utf-8?B?K1JMWCtiYlphUHJwSGpXRGlsa2xDWVRuSSs2T1lwc1hUeU5HclV2TWFtK3hD?=
 =?utf-8?Q?1uOTAfSJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f92f2ee-cc16-4f28-7434-08d8c3f1d739
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 01:04:34.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Qk8MtHS0Cf4vAm8UVR/p6uQhp2T/GjKNTnLkS6JTT60oX9WOyxI0j2YscjCjIkvlX6zQTV5erkmSdAk6D/BKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290001
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290002
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 4:37 AM, Muchun Song wrote:
> On Wed, Jan 27, 2021 at 6:36 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.01.21 16:56, David Hildenbrand wrote:
>>> On 26.01.21 16:34, Oscar Salvador wrote:
>>>> On Tue, Jan 26, 2021 at 04:10:53PM +0100, David Hildenbrand wrote:
>>>>> The real issue seems to be discarding the vmemmap on any memory that has
>>>>> movability constraints - CMA and ZONE_MOVABLE; otherwise, as discussed, we
>>>>> can reuse parts of the thingy we're freeing for the vmemmap. Not that it
>>>>> would be ideal: that once-a-huge-page thing will never ever be a huge page
>>>>> again - but if it helps with OOM in corner cases, sure.
>>>>
>>>> Yes, that is one way, but I am not sure how hard would it be to implement.
>>>> Plus the fact that as you pointed out, once that memory is used for vmemmap
>>>> array, we cannot use it again.
>>>> Actually, we would fragment the memory eventually?
>>>>
>>>>> Possible simplification: don't perform the optimization for now with free
>>>>> huge pages residing on ZONE_MOVABLE or CMA. Certainly not perfect: what
>>>>> happens when migrating a huge page from ZONE_NORMAL to (ZONE_MOVABLE|CMA)?
>>>>
>>>> But if we do not allow theose pages to be in ZONE_MOVABLE or CMA, there is no
>>>> point in migrate them, right?
>>>
>>> Well, memory unplug "could" still work and migrate them and
>>> alloc_contig_range() "could in the future" still want to migrate them
>>> (virtio-mem, gigantic pages, powernv memtrace). Especially, the latter
>>> two don't work with ZONE_MOVABLE/CMA. But, I mean, it would be fair
>>> enough to say "there are no guarantees for
>>> alloc_contig_range()/offline_pages() with ZONE_NORMAL, so we can break
>>> these use cases when a magic switch is flipped and make these pages
>>> non-migratable anymore".
>>>
>>> I assume compaction doesn't care about huge pages either way, not sure
>>> about numa balancing etc.
>>>
>>>
>>> However, note that there is a fundamental issue with any approach that
>>> allocates a significant amount of unmovable memory for user-space
>>> purposes (excluding CMA allocations for unmovable stuff, CMA is
>>> special): pairing it with ZONE_MOVABLE becomes very tricky as your user
>>> space might just end up eating all kernel memory, although the system
>>> still looks like there is plenty of free memory residing in
>>> ZONE_MOVABLE. I mentioned that in the context of secretmem in a reduced
>>> form as well.
>>>
>>> We theoretically have that issue with dynamic allocation of gigantic
>>> pages, but it's something a user explicitly/rarely triggers and it can
>>> be documented to cause problems well enough. We'll have the same issue
>>> with GUP+ZONE_MOVABLE that Pavel is fixing right now - but GUP is
>>> already known to be broken in various ways and that it has to be treated
>>> in a special way. I'd like to limit the nasty corner cases.
>>>
>>> Of course, we could have smart rules like "don't online memory to
>>> ZONE_MOVABLE automatically when the magic switch is active". That's just
>>> ugly, but could work.
>>>
>>
>> Extending on that, I just discovered that only x86-64, ppc64, and arm64
>> really support hugepage migration.
>>
>> Maybe one approach with the "magic switch" really would be to disable
>> hugepage migration completely in hugepage_migration_supported(), and
>> consequently making hugepage_movable_supported() always return false.
>>
>> Huge pages would never get placed onto ZONE_MOVABLE/CMA and cannot be
>> migrated. The problem I describe would apply (careful with using
>> ZONE_MOVABLE), but well, it can at least be documented.
> 
> Thanks for your explanation.
> 
> All thinking seems to be introduced by encountering OOM. :-(

Yes.  Or, I think about it as the problem of not being able to dissolve (free
to buddy) a hugetlb page.  We can not dissolve because we can not allocate
vmemmap for all sumpages.

> In order to move forward and free the hugepage. We should add some
> restrictions below.
> 
> 1. Only free the hugepage which is allocated from the ZONE_NORMAL.
Corrected: Only vmemmap optimize hugepages in ZONE_NORMAL

> 2. Disable hugepage migration when this feature is enabled.

I am not sure if we want to fully disable migration.  I may be misunderstanding
but the thought was to prevent migration between some movability types.  It
seems we should be able to migrate form ZONE_NORMAL to ZONE_NORMAL.

Also, if we do allow huge pages without vmemmap optimization in MOVABLE or CMA
then we should allow those to be migrated to NORMAL?  Or is there a reason why
we should prevent that.

> 3. Using GFP_ATOMIC to allocate vmemmap pages firstly (it can reduce
>    memory fragmentation), if it fails, we use part of the hugepage to
>    remap.

I honestly am not sure about this.  This would only happen for pages in
NORMAL.  The only time using part of the huge page for vmemmap would help is
if we are trying to dissolve huge pages to free up memory for other uses.

> What's your opinion about this? Should we take this approach?

I think trying to solve all the issues that could happen as the result of
not being able to dissolve a hugetlb page has made this extremely complex.
I know this is something we need to address/solve.  We do not want to add
more unexpected behavior in corner cases.  However, I can not help but think
about similar issues today.  For example, if a huge page is in use in
ZONE_MOVABLE or CMA there is no guarantee that it can be migrated today.
Correct?  We may need to allocate another huge page for the target of the
migration, and there is no guarantee we can do that.
-- 
Mike Kravetz
