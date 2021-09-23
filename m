Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284864166FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 22:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbhIWU5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 16:57:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54790 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243192AbhIWU5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:57:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NK18we003111;
        Thu, 23 Sep 2021 20:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nTLWW80EfewisgitRwx/z2rLl6Wgm61sx798HgtuZKg=;
 b=yV6+/PzZuI6cefW4Vk26edf0zHsy7qPgxgvEQl9bxBa4VL3rP+eGHzs7gaqrWw5yTjMh
 lRy3Sv5hqevJ/FBH1WM7mYPdb+F1cOpO/LWhk3rEiXV/rGOeTope4ENm2kW8XbmXwqEr
 uLEqo0Z7yGp33H7zYCR1RhiWH6k5aRQO9mAsOIk3vnPtt4vJykjxuOrZG1ifyhTELXzH
 uOQPBQOkbptp0O4gBhOxp0e4XyP28aejCKdOReIv9P1100Dq0s8T2Y8GQ7OP7/2fuYCk
 31949pf3gK31FCtvrGajgS3qEcztbqa64Sv98taGgffAOYCJwlyU8rb+iAQ67wldxoia fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8qvumdyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 20:55:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NKt6P5161660;
        Thu, 23 Sep 2021 20:55:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by aserp3030.oracle.com with ESMTP id 3b7q5ebcdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 20:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGAPFvvLCd6S6FLvCAoeVJu7gykPKEoQQCWPwRFGhs7NNHvmEVnweS6XGvjm9hx40VSr1mkyS+jz8HoxwHvibGqiQ51mkTWaLyc+n6ya4cTTY6nTjY6Tmi2+61f6ywPQK5BH8oke7bw9sHtDrxd21XTgjgqlX23NEsSkjA2XSRQqPWbTIr2y4S89z/k14VUAcNTDHVG7rlGKAEr0a8wHgXCDrdKsCnhhPU5aF63k59KMQfIUiuAElAK8PnXZnc+34dA9CrA3okRAfqjvV8sm1UYCbWCg1nAEVEG+jl/LkF88ABdx2pvmkdXnrbZM+reXtrgEsRxsc3Zl4MGm5QlqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nTLWW80EfewisgitRwx/z2rLl6Wgm61sx798HgtuZKg=;
 b=l+ctyKa/kdRBnxzyfF+vgGn55Bq5i95XqES3rSAeOKsoS5G072J2jBz3JBJ/cRdHxINgZK7XN35hIv9FdRevn7aUr9pTPwNFlUPpSqC/v9vj54UVLpNum3NZXaHaRfjLQQ/ar39g/vP53FqIuoMOvh13oJAGfREWiVPZXfL7WnY9bCDvBEAOTFVfYs9ajAV5UhAgp25RiZfxwuE8GS8FI3frsLtZHWtuWP/jvAlh4b1jKn+FXBwuwySwTFJW5c0mfbW6h0RkoVg4EaJCgwO9E8FMwkfEzWehyzu30/+mRncUF9qXQeT/jKtW4pg7Dj3n4oP92jy+AUr46DJIXa3R6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTLWW80EfewisgitRwx/z2rLl6Wgm61sx798HgtuZKg=;
 b=0AEpiR+/AWOS1C/tUearMeU7vLgCmGesNGLONnA3uwXZQ0g19EWRP63fQEzLSRBXBUr89wRHw5snx0ZGrN2305uBaiZzgJZl0L///AIIuwitdkjH9j0HdFExkcdq8YRCmI4G1RKQitvNM5Uydx6A1XCe+c2VBJ1hovCldvgLyyo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3670.namprd10.prod.outlook.com (2603:10b6:a03:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 23 Sep
 2021 20:55:44 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%6]) with mapi id 15.20.4523.020; Thu, 23 Sep 2021
 20:55:44 +0000
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
 <20210915161510.GA34830@magnolia>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <324444b0-6121-d14c-a59f-7689bb206f58@oracle.com>
Date:   Thu, 23 Sep 2021 13:55:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210915161510.GA34830@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0095.namprd12.prod.outlook.com
 (2603:10b6:802:21::30) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from [10.159.139.16] (138.3.200.16) by SN1PR12CA0095.namprd12.prod.outlook.com (2603:10b6:802:21::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 20:55:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d36cf26c-2952-4e36-d0d2-08d97ed482e5
X-MS-TrafficTypeDiagnostic: BYAPR10MB3670:
X-Microsoft-Antispam-PRVS: <BYAPR10MB367085176A9FDD0C08474A7BF3A39@BYAPR10MB3670.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wj1KZbNTFMFkLRWmCA+P7InyTH7MbsvmvLZUnV7wl+pBowNXpuNeszpE1r5L2iZO1pVo6D5XZ1QS+SvHvmHTkkCM6RypxuCnxYjN/cyNuWLTWWe+8I9GXItjooLhm6VsMvHa59sMuv8EQzki+4hpBQ//sC/9P/sic6LDdUyu7VC8E6NBZ1MTk+bYuS1hATVn6mGsI8Jv/BAXgXHDguQKbvgRiQmzlJMdjsukCbK4eM/pJ5w3Za+EWF7nqDCSU0mP4yOkxQcrCNpW3KbF5u3f0hecgXH6Izoq0NOAPY1M2WM5MEvM9TqD9UkZAxLHGviM90DUgW7ohS1+N8nkFXIhR9KtEeB6yMsvgtVoYEo8/QKuAAIYN6YJzKOBdVPPQhejw01UP7vPxalFFwHj0lsTGr6VwKjbem84bO+F/gWPWMEjkkA0+fOE0eIDXJWJ5jFwh9WfXofaQyHKNJzr1pU2wJ/LBFa38NoNUn85+evaYIJs9Gs+T1zQHS0y+fZRZTBwUgY5z0GruHh36aRwC5s9NA3pEXXzFwth+mtrpP7Ay0BNy8bamLu0WFWh73fvhIM5EZ3CNs+vz4Y3QKO78Xmil2ZH9ptz/nu3UC03MWdgvYUMnILHJrpLYWICeglfdmQTl84NLO+hBRqwuK/p57FjEQfl3HWZgwwjdd5tokRFA92l7uxkja2b3QVIEqwaXsFRXmadfSyFijJl0jRloMSR4H+h+P21ffckD406qacUs4Y51NZXNmIeoz/oM/3b7dNqqs7OClA8RQOcNwrb46bKUG6qMTFv9UPgaE8gBRGgM/TuUf4zkoFx0HitXgyxzF2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(316002)(4326008)(186003)(2616005)(956004)(966005)(16576012)(54906003)(5660300002)(66946007)(53546011)(26005)(508600001)(86362001)(36756003)(36916002)(6916009)(7416002)(31696002)(44832011)(31686004)(83380400001)(6486002)(8936002)(66556008)(2906002)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG91Sm1uZklUUTk1UnRPNDdKVEozUFFzLysvc2VtbVpnaHVlMktFRkUrRFl4?=
 =?utf-8?B?Y29OWTBzSWJSdjhxK0RSSFNZdjRkT1NBWE8wUGl2bllXR0s0ckpZQ1VjMGNo?=
 =?utf-8?B?RWlSMEkwanRORGUyNUpuanRzRGlrb2ZjSXJvSFNiUmhzT1BpaXpkYzI4Sm54?=
 =?utf-8?B?ZmY2V2JqS243MFo5WWRpc2ZHUW9GdzRLb09tVTJ5WDNhVHR0QTQ3czFBK2xa?=
 =?utf-8?B?eC9pQjRQUm5oaytaUkpiL1dTTkdHekxKRWFFSUEyd2prNVQ1bWNXSHhDN21V?=
 =?utf-8?B?dTM4MTEvUTJsMHhWWHYxTWR4c3BHY2dQZ2NxOGhWRmdhT25ZZTUxdTlnSGdK?=
 =?utf-8?B?TkFFK250bVlsQVh6RE9abURycHo1QzFDb1FpcWxmNUI3K0xNMENaTkFFcmU1?=
 =?utf-8?B?YzZSWEg4RkowVjV1NHZnQ2IvckcyUmx3Q0xUM2haNmpmTVZpc252T3RzdG8x?=
 =?utf-8?B?VDd6RVRNdDFIdStyTEszbU5oTEtSREJjaXA3NHhKcVVsZU42VUdTamZEM3pi?=
 =?utf-8?B?NXlsUnhpd1l3K0JjWXFVWVBxMzh5a2hzditpNkdob2xveVhNNjhvb3dDM2g4?=
 =?utf-8?B?bGo4c3lXVW4rZExUNldKb3gwK3FqVXNoRlhBNHJ0VHhITmpsS1RNTC8yUkds?=
 =?utf-8?B?WXoxNGJyelJQMlhRYkxqdDkxbDZ2OVdCZ0pjOVArUDdja3JVbHNkVUxXUjNr?=
 =?utf-8?B?S3BnYlV2eHJWczRadEV0WDVxeWpXamttZUtmU1lTWkh6QzJFTmFxcUdNcFJD?=
 =?utf-8?B?RFo0SSs2TkF2OU1sOUF4bURXMTFXNHV6cEozTUZVczZOTUJNN3prZVQ1aHpI?=
 =?utf-8?B?YU84T2tJREtGYTRqdHdkMVljY1JTWm5jd0V3b1VOelhzTjh6cWgrcFJhZG5D?=
 =?utf-8?B?TDRwZ1BrOFRlMENyZmI0aVI5c0h3Rkc3dnNuN0xrbGcrMkZ5VlQvU1lFRERQ?=
 =?utf-8?B?dGFCMmhQL2VVUkVRTGtkVFRLNm8xUzRXaitGSFQ5aW5CbDdjaVpoVzhuUXF4?=
 =?utf-8?B?a2g3Ukt0cFRYaFVpaXFqRm5sM2NUMDZCcTBweUFsUE0zK0d6ZGZBdnh3N1lI?=
 =?utf-8?B?SEFIZytudm9BTHlsWWpKUFdDbGJyVTYrUkFtcG50SzNpMVpueHdwRlVHUTlo?=
 =?utf-8?B?TEoxUjF4SEdUR0wwTHZUb2hzVkQ1V3ZaMkEra1pPYm0vL3RuOXl5ZXRJc1hI?=
 =?utf-8?B?ZGZzaTNTOUQ0Z0xyRUk3L2JHWno1ODhaTGNXdTYyYTlLQzB4YVZIdXV6SnhL?=
 =?utf-8?B?VWtvT25CaklFWTBXYVZ2cXVDbDN6ajROZVc2Q0tvdnJGVmIxMW1WNTlyN0xT?=
 =?utf-8?B?NDcxRVd3SVVReURiaXozMVdNVGtKMFJSWW5ESjFWRFl2c1FZS2M1Qk0rVG5D?=
 =?utf-8?B?WW81Y0daTit1STN5V0M0emNtM3RsMy9QK1pHTm1yNjhxVDhyVGxvNFRIYU5E?=
 =?utf-8?B?ejZrTU44K3RTOFJLUmpJVVdGOCsybGVsY1ppU2tqbURJckJpYXdUKy9KVUUx?=
 =?utf-8?B?dHlkZUtUTzU3VnZna2lhSFNnQTI3UGZzajBCaXJaenFlZ212ckRVaFFiZENx?=
 =?utf-8?B?ZjlIZXg3Unl5WllNd1NnK2hPQTdpclZGRGY5aTJTUE14SFhKeGRpaWE2d0dT?=
 =?utf-8?B?cVUxa0hTQnUyZ056Vk83K0FSU2E4WGZZNUJQdGRjdGtoeXJ2V0FjSy9xdk4y?=
 =?utf-8?B?Skp2UGVhTys3QmRIVDUyeXlpdmZJc3pYSTNjeG1BNHladmlLTm1BMVNHNStv?=
 =?utf-8?Q?ptvRY/vPdpJXoIdNzERfxOCkoLBM9MTf+r7QocF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36cf26c-2952-4e36-d0d2-08d97ed482e5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 20:55:44.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYUgl8RMZLrZ1MQQ4mUmVMhOs9KxXSwNxq9fRd5jkZywLSyETjXj4Wg6/iboHnXN58IOXwg/Eip5zLKlnccvbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3670
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230120
X-Proofpoint-ORIG-GUID: BMESY5HUaBpIl8k-FXraEx0leP1N7uwg
X-Proofpoint-GUID: BMESY5HUaBpIl8k-FXraEx0leP1N7uwg
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/2021 9:15 AM, Darrick J. Wong wrote:
> On Wed, Sep 15, 2021 at 12:22:05AM -0700, Jane Chu wrote:
>> Hi, Dan,
>>
>> On 9/14/2021 9:44 PM, Dan Williams wrote:
>>> On Tue, Sep 14, 2021 at 4:32 PM Jane Chu <jane.chu@oracle.com> wrote:
>>>>
>>>> If pwrite(2) encounters poison in a pmem range, it fails with EIO.
>>>> This is unecessary if hardware is capable of clearing the poison.
>>>>
>>>> Though not all dax backend hardware has the capability of clearing
>>>> poison on the fly, but dax backed by Intel DCPMEM has such capability,
>>>> and it's desirable to, first, speed up repairing by means of it;
>>>> second, maintain backend continuity instead of fragmenting it in
>>>> search for clean blocks.
>>>>
>>>> Jane Chu (3):
>>>>     dax: introduce dax_operation dax_clear_poison
>>>
>>> The problem with new dax operations is that they need to be plumbed
>>> not only through fsdax and pmem, but also through device-mapper.
>>>
>>> In this case I think we're already covered by dax_zero_page_range().
>>> That will ultimately trigger pmem_clear_poison() and it is routed
>>> through device-mapper properly.
>>>
>>> Can you clarify why the existing dax_zero_page_range() is not sufficient?
>>
>> fallocate ZERO_RANGE is in itself a functionality that applied to dax
>> should lead to zero out the media range.  So one may argue it is part
>> of a block operations, and not something explicitly aimed at clearing
>> poison.
> 
> Yeah, Christoph suggested that we make the clearing operation explicit
> in a related thread a few weeks ago:
> https://lore.kernel.org/linux-fsdevel/YRtnlPERHfMZ23Tr@infradead.org/
> 
> I like Jane's patchset far better than the one that I sent, because it
> doesn't require a block device wrapper for the pmem, and it enables us
> to tell application writers that they can handle media errors by
> pwrite()ing the bad region, just like they do for nvme and spinners.
> 
>> I'm also thinking about the MOVEDIR64B instruction and how it
>> might be used to clear poison on the fly with a single 'store'.
>> Of course, that means we need to figure out how to narrow down the
>> error blast radius first.
> 
> That was one of the advantages of Shiyang Ruan's NAKed patchset to
> enable byte-granularity media errors to pass upwards through the stack
> back to the filesystem, which could then tell applications exactly what
> they lost.
> 
> I want to get back to that, though if Dan won't withdraw the NAK then I
> don't know how to move forward...
> 
>> With respect to plumbing through device-mapper, I thought about that,
>> and wasn't sure. I mean the clear-poison work will eventually fall on
>> the pmem driver, and thru the DM layers, how does that play out thru
>> DM?
> 
> Each of the dm drivers has to add their own ->clear_poison operation
> that remaps the incoming (sector, len) parameters as appropriate for
> that device and then calls the lower device's ->clear_poison with the
> translated parameters.
> 
> This (AFAICT) has already been done for dax_zero_page_range, so I sense
> that Dan is trying to save you a bunch of code plumbing work by nudging
> you towards doing s/dax_clear_poison/dax_zero_page_range/ to this series
> and then you only need patches 2-3.

Thanks Darrick for the explanation!
I don't mind to add DM layer support, it sounds straight forward.
I also like your latest patch and am wondering if the clear_poison API
is still of value.

thanks,
-jane

> 
>> BTW, our customer doesn't care about creating dax volume thru DM, so.
> 
> They might not care, but anything going upstream should work in the
> general case.
> 
> --D
> 
>> thanks!
>> -jane
>>
>>
>>>
>>>>     dax: introduce dax_clear_poison to dax pwrite operation
>>>>     libnvdimm/pmem: Provide pmem_dax_clear_poison for dax operation
>>>>
>>>>    drivers/dax/super.c   | 13 +++++++++++++
>>>>    drivers/nvdimm/pmem.c | 17 +++++++++++++++++
>>>>    fs/dax.c              |  9 +++++++++
>>>>    include/linux/dax.h   |  6 ++++++
>>>>    4 files changed, 45 insertions(+)
>>>>
>>>> --
>>>> 2.18.4
>>>>
