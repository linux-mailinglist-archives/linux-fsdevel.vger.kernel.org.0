Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA77631D126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 20:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBPTqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 14:46:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52694 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPTq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:46:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GJSPqW155487;
        Tue, 16 Feb 2021 19:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7FZhTr0j+zVfQGOrU/d6PqN3xvfw/F44Hb/MTx9HA4c=;
 b=Ic1Xn7FqqRxoSv3AS/16y1TzqY+TAbguUMr+q7JKTaQP6TStxXI8G8JM3aEbn7FWe6J3
 ujHwLrKIRs2y/zaupyfUl4G5z1BZJnLQOmMfdzsuDVzbFElR5iYo+sEZpO6Q+APzyfnu
 YVysk0x7tRw1AqKZ8EkPPllx0mbLV27kamBA1FglaDxvduHfQgA8q/DiXVEFeB9PKswg
 ovsP6e7dM81iC+MBvA/x78ZVUKoPCSiCP2au1NhyXqzzR0DHlqD/WNQ+HCjhfrmDWQjc
 31xD99HsBaxvbltQihA1OzIVzOQ0s4Q14FsME08aB/8nXHnGzcKvloTYUJM6ARuo8Clf 7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36p49b88q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 19:44:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GJUBRK066631;
        Tue, 16 Feb 2021 19:44:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 36prnyc373-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 19:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHoLHEtvUDdiqQKGvJOBE3/rt5irfAA0Hmhw0/hAUJKwgTwdArd5fs8ywZgHXlY7hSch+3vm0tQHfqcRSiHYHY84DsjMoToCJlt/hco7ROTwD63g1ipoMm9IT+/JzqdVesW8VyB11pudXuQezavAGX5q8U+y1PkwdKC3Gyu3ESyIbpd5RxSL/YCfZ6KumuwGu+SKiWww1WwkEzau7i6xzqOwhT6hWq8btV8hnllRQXD36Z5x1BtBDWCdTfKWc77wSAyz/MjR31fpFA3HI47WKbkQ7lnGloM/z7E+DdCam1jeuaXImVThnM770EhuPBV6udChJV7g+xyOjtJSCj6Axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FZhTr0j+zVfQGOrU/d6PqN3xvfw/F44Hb/MTx9HA4c=;
 b=hfkusaM6W9eMhThjxnxyU3cwdj1ce++iELLnUYJWfw2h6v27V5nzjcvoJOupjnEul+qy2fU8I+JsMPk9cgCdLg7xPPTsXA9R+sMFc7F0ZPSEpTtFkPgdRZIuHfUEzu8oQCkBYNCJZoEzIumGyehrXp/J73yz7wVMx3K3C6XD2TxUYkPYTkUz4qOD8k2qVtCBQxgnStgPz9UfCbb/Le3R6STDuOzodfzqq1WfzbAfPNU5SkOjr2uW9YfcjgxyKLinYOq8dBGMDVlA2X6r69oJTCudTVMqxDbQk22pnr4lBxaNH/XgA9QHRiRzKIAcysx52S5g5bvQE1c9XM8fq0/MOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FZhTr0j+zVfQGOrU/d6PqN3xvfw/F44Hb/MTx9HA4c=;
 b=wI2vtd4EoxbmnYcBnb5M2yvJUjl/UEDZBUXK/bD9rc4LVU54aAPobq6am70Tr6Cmnrocgbc714ouaW3D49OqGI9t9lVoADDv99ik/gfnLetxSQRu0RrAMNNeUQ5CYjus8CzqGj2yHjSV6N9Js63+Vsouw0XhT+6N3RopqMAKx9I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 16 Feb
 2021 19:44:36 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.035; Tue, 16 Feb 2021
 19:44:36 +0000
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
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
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210208085013.89436-5-songmuchun@bytedance.com>
 <YCafit5ruRJ+SL8I@dhcp22.suse.cz>
 <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz>
 <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
 <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
 <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <29cdbd0f-dbc2-1a72-15b7-55f81000fa9e@oracle.com>
Date:   Tue, 16 Feb 2021 11:44:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:303:69::16) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0011.namprd04.prod.outlook.com (2603:10b6:303:69::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Tue, 16 Feb 2021 19:44:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b06b893e-016f-45b9-80b3-08d8d2b34a43
X-MS-TrafficTypeDiagnostic: CO1PR10MB4609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB460963E26AD9165863F1EE14E2879@CO1PR10MB4609.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IX318zbz5NlE4L4rLq41d9HHCWrXua/99WkVXBZXFGW7FR1jN/yMxTygdjElIi81LcEpHLgDvSnhROnEm4X6vT0g5o5Acd/FOJWbtzNkT3wscjzbb+o4RpeVU8oCZX8NTajpxxushs9jSjCe881lcL8MWe5FfEMSd6Ll3onZzTypCR3rd/hneXb476dE4sWx++bnWiw9y/FDkskhVJQoE7hIEObJDFPX5W9g8K4VF3qbvB8ukmVx7ppG9ZTlmg9lW96U9eT9GAi8l2RENE32hrm1E/9bQr+h9joCs7Ihdaa+q87BgXAnhhTxFEuJu0Rpd7G3h/dOx6ikaQU+FcWQfduYNf0GcN/Lc+1A2MXka/fYVIMAjLT0LNZpEFSjdzyYAzSkU/tExNqqfy0Rm5cWw1UsR+pusOd9/yFdvppBtXVymByG60DSKys7L3THZAMbWrzEmovEKX3A6XLD+SQJZT1YYR9r7nSVQr06dVZ8e99tkFtoKcmIFDPwsMuicN/N+tVLxIbpN98+YAYctXxJR7wMK/kcgbICMny1erfnr/wZ4QD5Xr4tVJ5v52hOxUmAZ2UcuJWr3VLRD0ONBzkVlbiu68UXFyxXkBxU1Z7ADZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(136003)(376002)(54906003)(66476007)(186003)(31686004)(83380400001)(4326008)(8676002)(7406005)(7416002)(26005)(110136005)(16576012)(66556008)(316002)(86362001)(66946007)(31696002)(8936002)(36756003)(6486002)(44832011)(16526019)(53546011)(478600001)(2616005)(5660300002)(956004)(2906002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SE1BZFhDbGs1ZkZzdjkvYmVxSW81SjM1TGQxNUw2bXRTbXltQVZUOUpKakUr?=
 =?utf-8?B?NWpvaXdSRHBIZDdTNjc5eFpndEdVb2gxbmV0emZldThJaG1McG1hMnNrNHpu?=
 =?utf-8?B?YnZUbmxSTlNCOURTcW40ak96bXkwMHNZNDZmSlVYU3djc0RzbHRrR0VUYUsy?=
 =?utf-8?B?c2l6d2lRZmpjR1VFZlRCTi9haFhrUy9vWk4rcU5OcTVqZXJTVUdOTFp0T0Mv?=
 =?utf-8?B?dFhLODRuWWdRU0Z1ZjQ0K1p3a2tYZUJrQW4yNjB0OFRGeVdZVWV1ODZWTE9Z?=
 =?utf-8?B?N2t2cFo3S1d5YkFLM0FJL0h2QkhGajVvMjFRWjBZMVRVUDJ5UVFlTUpUNUJ2?=
 =?utf-8?B?RUczNllhR1BJd001NGdSWk9ZOHV0Wjg2RXo3eDI5NFdxR2xoMHN3YUtrS3dO?=
 =?utf-8?B?K0FjNnFxUUJna2R6dUgycVEyYVA0Q2E1NFpiNWZGYjA3UE51cHJ0MHdZV0ox?=
 =?utf-8?B?T3hYOExzTCtMM01saEtqVzU2bkkwSTBPUHVGdGdxdnE3R3lTYndhMFFrcnR4?=
 =?utf-8?B?ZkFHR1BRU2I1blNXbE5sVUg5QmVSVXpsakdXOVdCSGJTR05iNjJ3MXVmSVNI?=
 =?utf-8?B?YXRVZDFxNG1yT0NRYjcvTUpvTGd4VHozUlpnZ0ppN1BDQmk0RnNvY2xLbFhx?=
 =?utf-8?B?RHZGdm1rbnh4SWhVeG50QzVidm1VMi8zTzJ3cVpXejRLQW9WSWgrV2h6UnA3?=
 =?utf-8?B?cnc0WmJERTNFajUvUlRvMUZpbEY5Vll5STJQNW1vUk5VR3Z5UnN0WGUzR0xC?=
 =?utf-8?B?dkVaWWlrRWxxT1JEOWF0LzBuK01YUzJUcWxSMkxRT0wwSVI4ZW5pdkVVdldO?=
 =?utf-8?B?SlpIazR0eW9FV2poZ3JzOHJ3cmpCeUE0RFNnWHlqODdmZGtjakZDZ3lIOHJ1?=
 =?utf-8?B?aGh0cjFoeHVIcWxvTS84NlV2eUk2cGVqUlYzMnVBS3JaejhTYVN2dys2Unkw?=
 =?utf-8?B?bGdKcXFJSnF5ajhLSVVDZTJMNkQ5dXh5QTh6bjViSGRCbGR5WXNnRDdVbEh2?=
 =?utf-8?B?L1B0d3VoWnF2YmlIMjJiM1hIam1xTllnczY1VjJPalU5eXVMRWdmZGR3dXZL?=
 =?utf-8?B?VXBMR3RxRi9mdU1uTHlJMWZXMXY3eS9Nc0dKT1kveXM3cUtpckdMeXdNM1VQ?=
 =?utf-8?B?U0NJbzdLUU9UaTZEQXNwY1hqcDNRV29sR2lraWYyQ2MzaWltYnBQZGpXc1Bk?=
 =?utf-8?B?N1M3eFlVUzBGSUpHTXlqWjVuWlVMUUFqQ0xNRnM4NXZ4OHJ5SUR4ZzJPOWlw?=
 =?utf-8?B?d0IxOHJMNUcrM1FiZzJQWk9mMGZFV0E1VGhhMS9DRzNpb1dHUnpQeWZZWFVy?=
 =?utf-8?B?dlVxN1pzU1lYenlNNXRtclZMSTM1OU8rSldPbkhGVXVLVjd2TDIwY3loVnRY?=
 =?utf-8?B?Yno1a0NZb2xuSW5yZG1nbUVPdWJ0WUk2UUUxT203Zy9QY1pIangxNXZoeXdy?=
 =?utf-8?B?b2t6TmMzYzdTZW5kWU9vbmFnb3NLRW03MWV4SS9Pekp3RnVZbjR4Q3lyZ09j?=
 =?utf-8?B?OWdzOXpEQnRJYWpyN1FIMFpWQnNZdXladnVLcWY3WCtWWnhrL2dRcFU2NUFZ?=
 =?utf-8?B?WGdPMDZVaVJnRi95UWlWd3RrZm0vQW5QT0tuWTBaWHJlSTJGazlUWW9EZXVM?=
 =?utf-8?B?OGJEQ2NyUGxoaUduL1l4YzFyU3hsS2Rrdk5iY1VCUmFkS3VhWTlicmNXY0VW?=
 =?utf-8?B?cmUrQ3ZyZERJTVlSU1ZTajFNTzB3d2V2c1F1aEkvaEFzUXFiVzV1ZGZrSG0x?=
 =?utf-8?Q?CKMXXWEhI4Bq378oUdUW0dFHE75BRsSnrnJlILt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06b893e-016f-45b9-80b3-08d8d2b34a43
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 19:44:36.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hft2hhPP36mBWvNSAzN0wIVbfxDMwp3yk5hH/WzSNBI2IWCD1dpxumuKO2u8XZDNVdMHaDND0bMnUANs2FPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160162
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160162
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/15/21 8:27 AM, Michal Hocko wrote:
> On Mon 15-02-21 23:36:49, Muchun Song wrote:
> [...]
>>> There shouldn't be any real reason why the memory allocation for
>>> vmemmaps, or handling vmemmap in general, has to be done from within the
>>> hugetlb lock and therefore requiring a non-sleeping semantic. All that
>>> can be deferred to a more relaxed context. If you want to make a
>>
>> Yeah, you are right. We can put the freeing hugetlb routine to a
>> workqueue. Just like I do in the previous version (before v13) patch.
>> I will pick up these patches.
> 
> I haven't seen your v13 and I will unlikely have time to revisit that
> version. I just wanted to point out that the actual allocation doesn't
> have to happen from under the spinlock. There are multiple ways to go
> around that. Dropping the lock would be one of them. Preallocation
> before the spin lock is taken is another. WQ is certainly an option but
> I would take it as the last resort when other paths are not feasible.

Sorry for jumping in late, Monday was a US holiday ...

IIRC, the point of moving the vmemmap allocations under the hugetlb_lock
was just for simplicity.  The idea was to modify the allocations to be
non-blocking so that allocating pages and restoring vmemmap could be done
as part of normal huge page freeing where we are holding the lock.  Perhaps
that is too simplistic of an approach.

IMO, using the workque approach as done in previous patches introduces
too much complexity.

Michal did bring up the question "Do we really want to do all the vmemmap
allocation (even non-blocking) and manipulation under the hugetlb lock?
I'm thinking the answer may be no.  For 1G pages, this will require 4094
calls to alloc_pages.  Even with non-blocking calls this seems like a long
time.

If we are not going to do the allocations under the lock, then we will need
to either preallocate or take the workqueue approach.  One complication with
preallocation is that we do not for sure we will be freeing the huge page
to buddy until we take the hugetlb_lock.  This is because the decision to
free or not is based on counters protected by the lock.  We could of course
check counters without the lock to guess if we will be freeing the page,
and then check again after acquiring the lock.  This may not be too bad in
the case of freeing a single page, but would become more complex when doing
bulk freeing.  After a little thought, the workqueue approach may even end
up simpler.  However, I would suggest a very simple workqueue implementation
with non-blocking allocations.  If we can not quickly get vmemmap pages,
put the page back on the hugetlb free list and treat as a surplus page.
-- 
Mike Kravetz
