Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB8334749
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 19:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhCJS5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 13:57:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35014 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhCJS5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:57:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AIdlQH195555;
        Wed, 10 Mar 2021 18:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yshXYbfsN6dPNF5OYrqYQxTgsawVc8nWLJLNl9zi2co=;
 b=bQmNXmw694viLO7IPBdJ/LP/RgSmGEnp7o+eOsZPtfnTddLh+frNcVOOK2+sEZvTm6o5
 aIqqIPGoosUYjrW2t10x/ZTDX42RYPzQMGSmN5GYDivaci8xA2FGJblcqZT8CJrQNjoi
 rfpUsZsW+8DT2kqnPmCM5wpd4AiM1rkJ6IvYYkap0MSej6BHVSAQyIIlqoejQz4fkVFy
 k+tyo2E3pObBPStm+GIFmO6VGKMWisFEsMI7aw/LA83DGy5jzbqmWwzFElieluEc/gsG
 vo2ktfSVGPeuXWI3tTBXZApDB7X4Art48nU6EmsoS3nM6P8jygS4dUE0VjZnA1X4TkTH QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 373y8bv7vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 18:56:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AIZUYr115379;
        Wed, 10 Mar 2021 18:56:16 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
        by aserp3030.oracle.com with ESMTP id 374kaqmur9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 18:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBnNSFGdP+uPgLzQMD2KY3cyV8gp9keLax9zoGeNgf3tecuilszZh+Hwg36RXmChI0sTxpq3OZuA4h7S+WNCAfsarv/s/rU/s4PXTvF+L6l0KHyDzdYFbhejd31U68VEnF1Vh8zDUBeqS7QVGLnO9TzMFmc82N/XhP5virgX+dzBMM4qaaoyUKl7UDHpcMNQH6OyVocBbjMJQbxeOLEo8+o8WPqyuiBypZPnX3LbQnDqBNmYUpCiuhY4gNfW1Zn0oT3VNx8hi8C4lerL51jrZh9QOlZSiG0LGhR7h61IpGkaYshHbuHQex6rDXS/yw9OZcoWXfAUf1txERlApcQrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yshXYbfsN6dPNF5OYrqYQxTgsawVc8nWLJLNl9zi2co=;
 b=JloWKXOpsc/QevIjooSsfKN+nCiOJfFXyJIy6Kwdyqx5LZiBiMeWGTtGW8Gmq0Jgi6ViE+1sXuQ2/2Cm0G+LiI44Hs6TgdAucfhyHLp6EiLC3rG4rfhB4lnRj5h05TQWpQo4q9+0XP3UJ58sz7/CeD3psjWsQXdcS0hTPa2old8Zeb2Rm87ePOGA0VI9fHlGNQW67Oz4mwoSz8o0GYe8NBNRTUtMB/tVkNoBraS5Di+DbpVzrNXCDy0lOuGFA+r0pug9NHNInzND64fmtr3wS2eBUcNYz9iuOiWh91h2fPl4gUHt+8+N4KwGZERwWWc4pSJCJyH4ZbIqQBM3nXCpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yshXYbfsN6dPNF5OYrqYQxTgsawVc8nWLJLNl9zi2co=;
 b=ggV9LAhsgzBE1pR4aZFLHwTi8gruZ3pltVQdH/fNBJbqtrtUu3+SWyBhjd4xNQMFhZA1yzPkV7NFKsnllaVPt0GkHQ3lI9Ol6Jmd0NqmXInWjqkLQpi+QFy2cCC//zteFtgoehBP8PtrHUy3KYL1ZBCgACW+W6td7NJkLTKQxi8=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3253.namprd10.prod.outlook.com (2603:10b6:a03:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Wed, 10 Mar
 2021 18:56:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 18:56:12 +0000
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
 <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
Date:   Wed, 10 Mar 2021 10:56:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0083.namprd15.prod.outlook.com
 (2603:10b6:101:20::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0083.namprd15.prod.outlook.com (2603:10b6:101:20::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 18:56:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12edf775-1f81-4f42-c82c-08d8e3f62cb7
X-MS-TrafficTypeDiagnostic: BYAPR10MB3253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB32534594BD67FC71BD3D105BE2919@BYAPR10MB3253.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHb2d27HcJhHnbwBDdPc5WSMA+QgVghF3JvMb78NZ1xuWV6pE2HljUyCiY/ox9puXsUkOqMnY8ymYVB1s5FTmRzc5h2uq9IdSkDHQ1v3tnR1k3VvvxDW6iQHI9hJQfOKIatG94ibo7x2GQLOFy0aiuinEwCXp5j5FWvT7XFoLObRaY9VkJW/5/cmsnbfEXnfh7kes4uNrpFTBe32/+VxFwBATQ/zcDC0vf7cJRvVw0gkRZghGwYBEoxj+J6jYTBsQUexENdCj9QkjkcoA5J3zf9dN7yxe5UNm9XD+Rb0gdqgRxnyrnqpAokwofcTfhIjmdM07nFwBxEe53x5YU89A+itTZ0RSM+ChgAPZuCzdV39u130HOTNhRuHjbkWZ3Mz9RxeOpjI1VDLE6vZk69CDZ5J402wXhnWAMdMhArhTLcX877skcWbTXICHV2e353r1y4VYF8/7P69lMGNQ7VtARx6vFv4n+siMeoZhPyYqLlgClco1pOvTzLI+YOUlpxsvboHHR2t8XvZ96pHZLnN4bnqoM4czQfRPHHRe84IH/smAytBfUl3zqWhqlTwDbpmTMS450LoeZnddPMvZhdFsRfxBIq1TIc9cVjCt5WQozE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(376002)(39860400002)(52116002)(16526019)(31686004)(186003)(53546011)(5660300002)(86362001)(6666004)(8676002)(16576012)(54906003)(83380400001)(110136005)(316002)(26005)(66476007)(66946007)(2906002)(66556008)(31696002)(8936002)(6486002)(44832011)(2616005)(4326008)(36756003)(956004)(7416002)(7406005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WG44TENYOUVqUFlZUU5wV3M1YllFWVVyeS9jRFBNMHg3a0g4ejhneGxqbFBx?=
 =?utf-8?B?MWVCYWc3NUFDNFM3QmJWelNJZmphdTNWUmJFdGg5eWttOUM1Q0IrQVh3aVJM?=
 =?utf-8?B?TTlOdkR4cTNvd1NRbjlNd2VsbTRZb0lLMEZBR3B5a3BCSndMY2Fab3JuQ2o5?=
 =?utf-8?B?ckxobzJsNUluMlUwRkZMSFNTU2VTcUYwLzBobktjWjYzdm4wRU5Qb1FrSWdE?=
 =?utf-8?B?OHRzcTFmaFE1KytnYTlrVEJWZHJCM0tZVFljN0xwdkxFa05lVGFBcmZCQmp6?=
 =?utf-8?B?eHJiRVNwSGtGQ09seU9wU1F6MFNYUHJSMC9xVTdQVExIQmRGeFpURW84U0Iy?=
 =?utf-8?B?YVRoRUpaWml2cXV2Z3gxcFRlZGxJWnAxL1RvQmJrcWhiU1UwdDN5SmlqakN3?=
 =?utf-8?B?a3NmSGRDMDV5L2h1YzZRWjJzcCtVUWtVK3A0QjZaL2FZQktOdzhrS3pIZ2VD?=
 =?utf-8?B?OUFGbHRYVWtpa09Hd2lqRXBZU21MNitwQU5JQkFCbmM3ZjN5akVvd0JLZ0pa?=
 =?utf-8?B?enFNWjJSVXZRZE9YbHVjSW9VbExRMFhXakdQNlI3YlVqaWVmNUFaTXBESDEw?=
 =?utf-8?B?enV4dk0zYm9nNk9KaXBCZnlTU3N0Q2FtV05oQmJvZ1dzZWwwWE1qY2gwMVY3?=
 =?utf-8?B?OE9rL2dmUVJ1R2t5K2FSRWxXdHVLWlVOM0Z4aDk5a2h5Vk0vVGY5OXpZdWF5?=
 =?utf-8?B?WHNDWkdnR294NGcyOGJWdG02Ui82b1ZHOUVla1JUU1lncHNMOVhXUzlJd2h0?=
 =?utf-8?B?YUhGMzhKVmdHVjdCZ2lHcWZUMWx4Yk9yVDBCWm42V3FXU3FIbDRzV0VHUURj?=
 =?utf-8?B?ZVlvVWhldEJDQUxxQU5WNzZDQWwxekNwNjJpa1YzTnA1NmQwRW4zYkZTUFhV?=
 =?utf-8?B?RElybzExRDRXTmJPaHR1eHgrSDkyQ0NHK0dSWmxVS3RtcFVTRFQ4Mjk2Zi9T?=
 =?utf-8?B?RktUeHZOLy9UQ1R4NHIxeTNZdWxHWDRnU2VpTXNZNmIzSldjQWRaSXpwZUNN?=
 =?utf-8?B?M2tDSjhjMzVUUW1BNFJHajNXQ3VxTlVZVDBZM2tZaXhUckJlR0w0eXozc013?=
 =?utf-8?B?NTdvTlZOdXRLODdlLzZuM21lM1JOM1YweERMb0ptcGlsdTV2Q3NObXMxUnI5?=
 =?utf-8?B?Um5qVGdDWWJTeVB5c21CK3MzZHZtRzRzYnkzbkZ2a3RtcnV0c0tqTGZXSllN?=
 =?utf-8?B?U1lscVlXUTQyRXd0SjVGSjhjOHpxb0Z4RFZTSWZiK0JVUEh0aTdiNkI4K1hT?=
 =?utf-8?B?U3U2NGVtOWlyakdvZVhvc2ZvT0RqMlBGRXdhaG9mOVBEa3JCaDVST2I1VEd6?=
 =?utf-8?B?OHlKUWpndmF6T2FUNy9mdElCTWFxZ0hrNnZ3S2haM0tTbEx3TjNoRmM1QUxa?=
 =?utf-8?B?UHVpbGpZN3B0SHlBbEd0S0dsL2JtQ2hjRjAwOHU4RjV3ZS9yOUVZYmlmQ291?=
 =?utf-8?B?K3RGYUwrTk5tTFNEUy9CaHRHNm8yTjZmdlF6OVY5NTQ1QTF5TnRMK2JSMkZi?=
 =?utf-8?B?Rzh3MXR0dnZITFhXMDRIaVg4T1Z6enZySjgyc0F3alQxbXNrN0QzNTJOWVQz?=
 =?utf-8?B?eWc2QUVxcVd2UHZoM2Q1czI1a1lKQ1ZlbENuVXJlRE5ZWmIxMStmSWpJTTNj?=
 =?utf-8?B?QTRjdG5LcFRUUG9iUGI2cEN3NmZ5NG1UNTZqVDFFbDBHeU51aks4aTg0ZEpr?=
 =?utf-8?B?bWRxWW5DNndNbk1XVm8yQ1h5cUZ4bUZBR0RmRjZ5RlZINkJ6NUdJaW9sOVR0?=
 =?utf-8?Q?dzxIZ4XjdCMmi63VbjcQp8eTe8cEXEZ4aqHI09B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12edf775-1f81-4f42-c82c-08d8e3f62cb7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 18:56:12.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFyaqmrLxsWrW5OYAQb4z7JdvoSGMBo2yd0Z0XjNwSWSRU04enZblntGordD7c9s8iUlMLxxZj2x/2O0sRVOHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3253
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100089
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/21 7:19 AM, Michal Hocko wrote:
> On Mon 08-03-21 18:28:02, Muchun Song wrote:
> [...]
>> @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
>>  	/*
>>  	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
>>  	 */
>> -	if (!in_task()) {
>> +	if (in_atomic()) {
> 
> As I've said elsewhere in_atomic doesn't work for CONFIG_PREEMPT_COUNT=n.
> We need this change for other reasons and so it would be better to pull
> it out into a separate patch which also makes HUGETLB depend on
> PREEMPT_COUNT.

Yes, the issue of calling put_page for hugetlb pages from any context
still needs work.  IMO, that is outside the scope of this series.  We
already have code in this path which blocks/sleeps.

Making HUGETLB depend on PREEMPT_COUNT is too restrictive.  IIUC,
PREEMPT_COUNT will only be enabled if we enable:
PREEMPT "Preemptible Kernel (Low-Latency Desktop)"
PREEMPT_RT "Fully Preemptible Kernel (Real-Time)"
or, other 'debug' options.  These are not enabled in 'more common'
kernels.  Of course, we do not want to disable HUGETLB in common
configurations.

I'll put together a separate patch where we can discuss the merits of
making the change from !in_task to in_atomic, and what work remains in
this put_page area.
-- 
Mike Kravetz
