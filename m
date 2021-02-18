Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532B231E3C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 02:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBRBC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 20:02:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53358 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBRBC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:02:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11I10WCl159527;
        Thu, 18 Feb 2021 01:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hZnrPb5he+pzZDYCpz8R1zRcAuerhH10Aw4XuYgxre0=;
 b=X2xQVEcVvfFPGiaZ6Hs8t/3cUORHLIK76zUQ7xa9Z4NT7g6mxsPe65ReqIn/O4L02k77
 fVDoyTYOtbQT26rlMDJkGaoWr+Mv0G3IKBkUIgPaac2iSwOt5tPqse/PKn2QVyuLKCTz
 ToTFXsrhbGXvJ/rtmRP/PzLncgdC7cR/ds2EBUWn7xVXzg4Yrpw7ETZlQ9Jou0Nqs2+G
 SBCCVzELNObCA/T4MWCpWmYtuFQlx6QpJwL6TiPuuAcy40Jz4bR0JmBcSovCEy9zDsBh
 FZsK+rNKRA70Y0YhhKzjUibXzZAFO6UZZhY5TNWno3vdne13n+Vlmsa/wqvw3h6pgftt lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36p7dnm799-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 01:00:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11I10Eh1081594;
        Thu, 18 Feb 2021 01:00:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 36prp0wbs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 01:00:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2iD6XeYUv7Azc7REFlp6Eor0Lv+guofEbI0452Ar+cftUacAGXNFCEg4TfYs7P3LArDNXynugJ6NgfnpI5+lqTGo/+iJxcjoxYv6LX1yUDYUL56jh+nyo/HtKID/577UODn4BVV29+lHHv5NS4iia91qElhrAsm6ojeDyCBuqJxU2IjJrX/lbSdFOn0DE1E93dghAXkcPkIg3E9TXkEbdyoXn7+zFZKOMlrGzmuwiExl+LKQbeaB5Zljf2kARsTTYuHwIsEmTuAdQAoF2lsmXe225AZu/0T0atXbFBrVuFtqmmuO+VjsCtGYQWJ2nR0Ach1X94DHj5fBSXFx4BYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZnrPb5he+pzZDYCpz8R1zRcAuerhH10Aw4XuYgxre0=;
 b=MUMu7B2Hrxak4Nic/E0HU16UTsNIX0fB4FOa6dJEtPSmXFCn31Xt5Ut1dRAjNhqgItRN6OI+YLkWHwK5Sot0yOt26K/Vg5cPslhkk406udWMyGE0IO5rUzOvu8MqVsNKAU1O+m1AhiYBbskkRSF7JzAsuegx0WywZnl18QSoA96XnnEDYqMfpxve0vf6QEQCkVOEbQ5FiDZxt85/c0F9WfDMBroAF+K6+gY60vgFVUCDRII8EmhMK6gnn6VkecUYZR6mhz7Uhm2WVTqPjMJ3QXQTquikiY/gfDEnF2OdU8LqlRe9BckrAAgym4jWTeRCoMGNQt5Mo09WGVlfbp+uHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZnrPb5he+pzZDYCpz8R1zRcAuerhH10Aw4XuYgxre0=;
 b=scBrKrRlyK2EIODaWYdP7Ds8W6vSpk+uZe1xs2k5vAFiW2bHPgtReozNeKFqzSD45stYncebSL8Ou3z8aIjk1EgePho5vmjLWGkxkqyCRHt9+9URxNTZmaGEEQJcpNrMk3uXntqSjfk0Jv0uY+Jol3oMZfbfqkFj+mAxpGNIbbc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2550.namprd10.prod.outlook.com (2603:10b6:a02:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 18 Feb
 2021 01:00:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 01:00:32 +0000
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
References: <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz>
 <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
 <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
 <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
 <29cdbd0f-dbc2-1a72-15b7-55f81000fa9e@oracle.com>
 <YCzQJIeI+dj9vphw@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f956c39a-6043-6d0e-9f4c-6013f54c2768@oracle.com>
Date:   Wed, 17 Feb 2021 17:00:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YCzQJIeI+dj9vphw@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0336.namprd04.prod.outlook.com (2603:10b6:303:8a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 01:00:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af9a5309-8b8f-4de1-a60d-08d8d3a89742
X-MS-TrafficTypeDiagnostic: BYAPR10MB2550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2550621DB7520B235D6C2D86E2859@BYAPR10MB2550.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWsXAI06sha4X4MewS6V9MDXhtczSk4VIW+DzTRG9zggbH+qTNRoUGXJcr7LjDFL+NUDTWFMzFrwsgiqO6ZEIfhAl2VEl6O3DEvKWVxEoklEhp41wHjHhS1Ji4nJyq2FeWu2akQYLg7yXg2Ui0PlfH/viqLi5JcMXEPVZ36sswVq3utyz4in+kX3a3wbmT0mSb7+5zkPfez29gAbTj8bHmFJnY1ZpOQh/R3oSIp8ua6MyK+ONU7UXVRakB4EwfL7njgsW8kPkf+iC7t20o01ebva/p2enFbcFgc9PQdoOAtB4/doMX10Ba+3pypuSjm+ViF3Sh1J9Wt91bMdSA7MjsEe3MTfP7n+j41A7DU//q5GjGJ79W97xFzhXVCjpGCeb0aVg3BPaOkR6lCv//+o0/Rr/Yg0pGwAVc+xQcH4X71O0KFEVyZJFanNmPpiXiw+NvX9wgL5xJ7TwEknzag3RGbTeoDFUSMdDk3k2mz2z+XPgFCz6huG8ZxId8YC8vFwIXnpT13U7XQYP3M/cPuHyX96doGxMjt9I/DXKpzV9j7AuM3jeWgv8bMHPMHX829cKgOWYUFNDYw+t5OQOBV9no+QOJekqJFnY9isYlMFDYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(26005)(16526019)(7406005)(186003)(8936002)(6486002)(53546011)(6916009)(7416002)(2906002)(44832011)(316002)(5660300002)(16576012)(54906003)(2616005)(956004)(52116002)(4326008)(478600001)(31686004)(86362001)(66556008)(83380400001)(4744005)(31696002)(66946007)(66476007)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SUhrZUlZQkRBWFFoZktxbGhNc1JYU0I2WkVBWUp5NWlLdlNzQmowU0Rpa2Nt?=
 =?utf-8?B?UEVMNGZQN3IzczBMS0p4VWRUVmJKc2dBazEvM0N1ckJNRzhERHNwTTl6SUJn?=
 =?utf-8?B?R0lHZnlYL0kzR29BYldjMU45aTJ2cWY4a0JNQVNsYlNGRXlrb05VQkFJeHBH?=
 =?utf-8?B?NzVnMi9tVjUvME5qVXM5K0pUa3dmREZuU3UyeHczOVJLb1NsU0pDQnFTTUJP?=
 =?utf-8?B?SnlwZzlGM05ITzZiQnlleDBxUlhSWG9GZXg2bkRnSTBmbDF6bHVLcWRWUm9w?=
 =?utf-8?B?dnU2WmUzb3hUdkRaa1JUdVVKKzBsaDFZSjJ1dWtQSDZYak1TVjFtazhHMnBM?=
 =?utf-8?B?Vis4TlowaWtUcmJobFJZdmVpS3RvdUNnV2tFdzZ1RlVVNElBaDVMTG5FOGZF?=
 =?utf-8?B?M0tRaHhNcGdkQmtDODFSSlh0RDB3Y1pkTFNFOW4wWnA2bGlaWWJhbkErYnk2?=
 =?utf-8?B?VEdQMmNDc0hoVWtNcDRkODF1bjE2dUd4bWVGKzJ0NFJoTkVaaG5OTXFzVGFR?=
 =?utf-8?B?cWFIRHV3RHBnWmdQTmQwcUN3SkVKUjZUNXdlK1JkcmhEby9XYlF0OSt6cFE4?=
 =?utf-8?B?bU5ZNUFmM2dkdG9SY3pBajRIbzNUeXYrNENlU294bTFWQmc2VWlvaGRZSFlZ?=
 =?utf-8?B?b3YrNWxjOFdaS244S2ZhMU1hZjkzdGpnQisxNlFlMWNBVjJXZUg2TXlpaXJB?=
 =?utf-8?B?b01IYWpBYXhBQzNJWjZTNVl3b2dobEVlc2QySit1K01GcHRsTlVkWU5leUZa?=
 =?utf-8?B?WXhoN1hPZ0VsWjN3QWM2d3hKYzE2YjRoVVVpamNDaC9lb2tJWFRHcUJZSktQ?=
 =?utf-8?B?YzdOeEFTelZWWXM5TkJvQndMbjhaSW9wYXJ4RFpsZkZ0Y2ZCZ3B6WGpYcnM4?=
 =?utf-8?B?Yk8rdFFUM3czLzJCNXlDOVFQYktCbkZJS09MOGRXZDR1MHdEM1ZZSnZMeWpJ?=
 =?utf-8?B?bXlpR3BQcmEvQ09kbGE5aHRrc2d3ZTZhTHpGVGtHZHZBR3BUMVFxVS9HYjlU?=
 =?utf-8?B?VEV4cGFZWGdpaUc5bHQ0b2ZwRjQyTnp3aTBzUytzejJ3ZWpld25wSkVQTCt2?=
 =?utf-8?B?Q1d5SlF4aU9SZC9oTlBoVk9tUEtIb3dMZ0J0cksvS1F2enNpLzBWRi9WUWJ1?=
 =?utf-8?B?K0tqWTVncnA5YmhTZFNadEhKOWc3Q0FOWTg2WmVkaVlSQ2xaS3VKKzBqS2J6?=
 =?utf-8?B?Nm5FSmhnNU5oeWlOZGI0SENYaktHSGRZb1FXVlVjVkxrZ0dMR0pkS1k5dmI4?=
 =?utf-8?B?RGVQSXdGU1NsNTZBZ2RKYmtPTWVUbndHalVPRytVbEpITHRuZTNwZlhxNUQw?=
 =?utf-8?B?MlNuVHBhVTR3RzBlcXRLWlpicFE3YU5kdFZudm5xcTJQN2x6aFd2SWNDWGRJ?=
 =?utf-8?B?RmsvSFFPZDV6MUpkMTd3c1dMZkU5MjUvUDlHamFkeFR5Q2JISys3dlNHVUJG?=
 =?utf-8?B?ZTQ2ZlVTZ3F2OXd5bGlXWGJCaWhhQjd1RUNQZ0JwYWpsR1RlY1RJdGdyaHV5?=
 =?utf-8?B?U2xmSEhoTzI2bTJ3cWFzNTh0ckxiTXhvTmQzVVNuRWtTNkViaXhIcU5IMEth?=
 =?utf-8?B?WXQzRFpxanRRNFF4TXA5UzY3dTQxOVEvNEFwODQzWHBCeGRKanJUZzlPam1S?=
 =?utf-8?B?bldBT3NpS3BnNDI3NUh0b3lEWGU5M3J5S25xRUdzR3VNR0dETUhVTmtJclMw?=
 =?utf-8?B?c3V1RDFnL2dMVjNzazRiMEtLTUlwdEpnaW9yV1JmSEtFczBPbW51VDhqbWdx?=
 =?utf-8?Q?mFtLaPsQXxfabRr2BS2OtCRoPwcTKtJIS0SrwyB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9a5309-8b8f-4de1-a60d-08d8d3a89742
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 01:00:32.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64vpxsA979xnbY4C9kt+jFHVqsPqtIupSsJzG/KpJMQR+pGY6qVLjlPS/KEIKEPSHDE+Wy5bw1SEHppBWXGlXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2550
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=950
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180003
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180003
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/21 12:13 AM, Michal Hocko wrote:
> On Tue 16-02-21 11:44:34, Mike Kravetz wrote:
> [...]
>> If we are not going to do the allocations under the lock, then we will need
>> to either preallocate or take the workqueue approach.
> 
> We can still drop the lock temporarily right? As we already do before
> calling destroy_compound_gigantic_page...
> 

Yes we can.  I forgot about that.

Actually, very little of what update_and_free_page does needs to be done
under the lock.  Perhaps, just decrementing the global count and clearing
the destructor so PageHuge() is no longer true.
-- 
Mike Kravetz
