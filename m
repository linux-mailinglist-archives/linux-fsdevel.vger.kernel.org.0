Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F93364EC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 01:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhDSXm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 19:42:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33254 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhDSXmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 19:42:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JNeNmS076184;
        Mon, 19 Apr 2021 23:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1TN5aw5eLK44CIuRHTMnucu76EYBChGUTd5TFLyz8x4=;
 b=Xmbt2gPZoey4vwNvAzU2HdE8H10u8jL6Kgu2JhCmWyGXekjm+ZxtviAx9T0pFJeMtXvX
 K2KrFH2uPVKVptcL5yisehx3SXdzmeWj0JJ+bfMTRIyJufM+irdy70arhSWDXcQbeiIQ
 qnCmvfbBQiOSLDu/a4UgT5f9mF1K06juPIWTX9+TVpVqPTEAtlAdJXMqDqEMwSiivswi
 GggwS+6DbSxixXd67UeNzfgfFDGn5yxYmm1X4ecvN1v1R6byIZuaEkZ37eoOjjbjwO/z
 NnGkA1utpo6WjJhO7v81OseP31M+kbail4xcOosZaTuAaR9GgaD7AfkP37bIJO1mn80D ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37yn6c5fys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 23:41:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JNe4eu122301;
        Mon, 19 Apr 2021 23:41:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3020.oracle.com with ESMTP id 3809jygst7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 23:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejQkeRoCOWOqL+57ckTq4Lcbnvo/oo5B3q2ZWkV7wbgwvpP4MHBTkNZYwOiSJgRDuEAxRLbRVk49iAZfJPmQpWgiaQwSZbCvDt9BY4fElGFe99OcGNAH8c1DDstNcmBuDyoRiUeyCIA5PB5mpQM1aVI2Hor/9IeG8MVouybxMywvs1SnOd9peYgM1h729phN2wqiQuWfpL8KB1dSimWFkwMj2hPhSFpvZCL3vs549oANL77lP4frBV+eSR5R7/4LZDl13IqOxl9H3/AXgiKBi3MEIKrtpiuHtjtT06kAkygQKr0lMnOLFXZ62uK/TxLOCXdvVv8tw8gLXSkeEgiBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TN5aw5eLK44CIuRHTMnucu76EYBChGUTd5TFLyz8x4=;
 b=UNFzk60nfz877ocGNQzKBmQxkq8gnpr3R1swRiIo0r59TTwvfpc3RldB4jFaxK3ZouskZLlGLR8pOiCZyW04Wolg3YkUs7lyEcwzbkdOC5s4AG0ttHURs3bxWG9dLg5LvkyFJPMz85Rza9yH4MOaxVyLF71/SSDvVY+KiwrBtgfW5N5kC5FejzbkEkLzJTuTIIWLsDkyNYhANyeZR1hjRw21xxAEdZxNMhgsMkzG76y96l08k/Y+Owu9/u8TIPOmaD4pnIEPS6AoxTAPgmR5O5U1QFqKzVQ7qXK1aUUnGzFDHZJzm63DfT1gQRYvdVFkH4cbqrkBqSYHoxbTcxuaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TN5aw5eLK44CIuRHTMnucu76EYBChGUTd5TFLyz8x4=;
 b=w7aTqXy2k8wG0Tv1Fecd4sGwPhX0B64TqnHT4rbAM0Rb10Z4VFcCyPCbFYDuF6zMLxmC3zprDpb6HX40mJyTph8hZsFoho40n5hMLhEQTUXkzz07N8c6d1Jzh5B3xuDXKmh8r4kz/g1ShZUXB7jUDVKcLLQsI36GXG3IG0p1000=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2856.namprd10.prod.outlook.com (2603:10b6:a03:89::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 23:41:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 23:41:28 +0000
Subject: Re: [PATCH v20 7/9] mm: hugetlb: add a kernel parameter
 hugetlb_free_vmemmap
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-8-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c1a3e914-e7f0-c92f-efd0-bdded6a412d8@oracle.com>
Date:   Mon, 19 Apr 2021 16:41:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210415084005.25049-8-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0067.namprd15.prod.outlook.com
 (2603:10b6:101:20::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0067.namprd15.prod.outlook.com (2603:10b6:101:20::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 23:41:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 482e4142-2b40-4752-d424-08d9038ca6b1
X-MS-TrafficTypeDiagnostic: BYAPR10MB2856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB28567E8597F12D650AC2EE70E2499@BYAPR10MB2856.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzRDqxS2eXaRAncH+D2PJueko77d5P031kem7ksOkjhmIicRfURB7PRqfqjC8DkqUqjDQZMqO7gVvnoXVRNuVytVWwv7UxeUJKFiKxilDTBP+ut3SHcYQ26zY4aOe/opdihlq7U+cT+Sr9cK7XQQ776gcKjaoAQxGDzdq3oCjNR9d114rFFHvrOiGpiO3M9vzn+YqSN0ZfE4hXycb1BcXT4Y2qFn4jkODcoCpzGXviGcGK4me1E7y+SbgVGFSSVtwDYCf9HYYDKMvHAmcVqatMqXTKtFc0ziav141EcE2AZpznV3NFt8fjN0AnfiDenYq/ZWsf38qZ3mf5FrJek358ZkSOTHf2bJHq8KttbYfvLVt0TYjH6A2tfLKU4G4HjqkjP4yaWd67M0T4FKD8cGSyqVReskzWsPV3wcfthS1XXc6rtEyo/7Md9q3EkCUSPvE1AL4+3o+oRH2X1CsjD7ZJQ2CJQ8RDwgGr3vf73ie65F4TlavAeBe8FpshTX7vf4SGnSezS9BK6Umee68vVYFUohW/DHRvjBePXZ91hq4dJOwxzkYCn1bpzkS+E0npRE34/t1eQfKovkmPkBj3SnAK94CaTIuWGN7PQRNFKSgHKofk7QyZnBTynPSqEchRKDe7i+5etLlgPqvmmJtzeMPZBLzFfppXzgpftjpo7rAqjNNKnV7TI+V6CxjxYG5y6wcToCtK1jGGgHWvP+3iNSEgPQFd/uPNJE6eIVoqgu/hA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(136003)(376002)(26005)(478600001)(921005)(956004)(186003)(31686004)(7416002)(86362001)(54906003)(66556008)(8936002)(53546011)(8676002)(2616005)(16576012)(66946007)(2906002)(44832011)(4326008)(7406005)(316002)(5660300002)(36756003)(52116002)(6486002)(31696002)(16526019)(38350700002)(6636002)(66476007)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTRiYndDa0gxdURiVGhXMFFyQWFCcEszei9YQVl3YjYzTXpkUnl4VUszNGJl?=
 =?utf-8?B?aDFPbUFKUmEzOUpZT2hRV1lVdG1MK1E4RXFWT2pJMzB1UGlHdHR5OUM4SmR2?=
 =?utf-8?B?ak1BZWxkYndobm9XaVRhQnEyMUEyTlVJZFRqQzYrM1h3bnNzeGsxaVo1RDRB?=
 =?utf-8?B?OW1lb215V2ozV2JlZWdzei8xU3h6NGxUa1MzTUdGNjVScjlENTk5QzlweEo2?=
 =?utf-8?B?YWdEYm1lclAwbW1oNmVwU3hZVFRrYnpncUsxYkpRMm9ra2ZDZ1g0N3I0di9N?=
 =?utf-8?B?RXNYRnRlVmRnV0hWVlpHOWVNQk0vYi9QdElDUm04RFhyb3Vld3BoSi9tbE5J?=
 =?utf-8?B?b2N5T1RyWmZGWkV3QlpQZ2UwRVJLY3NiVzRpam1LVzN1QkVTRVhWWVBybXA4?=
 =?utf-8?B?cE0zRW5CZUxjNnZUNXdmeTE5WC9ybHErTVNwSzdtTGNRai9lTVVsTGI0cUhz?=
 =?utf-8?B?MSt4VmFzajdZN1FRUWNOL1Q3c0J4bU5hK0hCaDBOY25VWlcxOEZHZVlkUGxa?=
 =?utf-8?B?TXVqVlUzV0JhTUl4djhpdW1jbUl3eDFOWFMyRk1hR2lvcTRIY04xdFRNSExP?=
 =?utf-8?B?djB3UU5pMGdKRzQrOElidi82djg5cmwwVzdZYW55aHk2YXc5ZEdVeXlGOWIy?=
 =?utf-8?B?VUFDNWV2OStjcGwvaVVqckY2Nk45KytjT3g1N2xTTGhJc1lvWFJ0TExjdDh6?=
 =?utf-8?B?K1pCOHZJN1A5aWxsYVlYZ0FnQVVab0ROVk9nSUpFV3J0UmNHaVU1ZVkvWmtO?=
 =?utf-8?B?Nm1RbElDTmtISlRjNjBDYkdTc2xqaXNkNjVQTWZYOVZiTGJCTUo5blRQS0w2?=
 =?utf-8?B?TFNndzlONHlobGNqVTJ4TFMxWHpraGoyUHRoTU91TjV3UmRKYjlnTUlnbkxT?=
 =?utf-8?B?YVhMQ3p3VnFYTWF3S0JpV3p2cmN5R1p2Ung0M21qWld5aWlhckNzM0pNdFhL?=
 =?utf-8?B?bmhhVG8xeVJhMUZhV0FsWlBkZnp1T3laSjNodnZCdEpjdVA3L1UxaXdYT21F?=
 =?utf-8?B?UUxKSE00ZmFnTkJtZHpicTVIMVRlU3pjNXcwYTlpS3ZQMEhFK255RTNZOEc3?=
 =?utf-8?B?TGpTK2p2SVJwWkhoZVE5cTNTZ0hrQ2ZKSmdzN3Y4amg2OEpSLzZDV082VnV6?=
 =?utf-8?B?V25CYjNGTzFqRG4yMmV2Yno4SkdFUzlyZ1UyM3pYeFRzMlo2OW1FdXZKTnJX?=
 =?utf-8?B?dFhUdTE2bFY2MHNSM0I5YXpNL3pmRzFWY0dwOEVHV053U2d6YWlld3ZFd0pI?=
 =?utf-8?B?enVPYkJXTXU0aXNNSDRVOE52RnF2cWdNMWg4L3drRnZ1Ti9sKy93Y0JCMlVw?=
 =?utf-8?B?cExwUmxCZVhWY2MxSklVSlNGRWRKcXZ0SStjZ290OE16LzliQkN1SWNycGcw?=
 =?utf-8?B?cWZEVGxkUmFEK0g3Rm1pYitCNis0SER2VCsyMjkyY204VXQ0cTB5eVIwWEVt?=
 =?utf-8?B?Mkp5OFhHK1pqNWMrdW9RekVnQit5cHhlVWwrT1hWTmgrcC9xb1kyL0dRc3Fj?=
 =?utf-8?B?MjdRVERFTkZuZUtxN0FyVmp2T2VzOEpXclZCVDJiQzl3akdLMUZXQUJVUWdF?=
 =?utf-8?B?aTFBMFBJMzU4dWgyZERpMjB0cW41UVhuWmthRWphYlp5ZzEyZU9WeWQrdUdS?=
 =?utf-8?B?ZkFxY3o1YmhhdngvSWt6aCtWWWo2ZjZKR3p5emIrVmxsTldvZ2xPRXlwUldL?=
 =?utf-8?B?bWk3c3B0RlBZc1FkODF1Y0Y1UVJRcU9scmxlRFU0T2dNSiswU1BIbi9QbERT?=
 =?utf-8?Q?liDvtcF8Vwjw2gb6ruY0Aoo/M7gm9NXS99GYOiD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482e4142-2b40-4752-d424-08d9038ca6b1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 23:41:27.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+7aR2cIxoy2gYPTms+dHL2SEzGkrv32nWyvC5uVOSeFk5eWOlq+kEMXgWt1xXzqSVoGZIqc+x16TKgpWSRgmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2856
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190163
X-Proofpoint-GUID: L6xYBkcP2-UJTY3yeYHEsvXw0wO63IEK
X-Proofpoint-ORIG-GUID: L6xYBkcP2-UJTY3yeYHEsvXw0wO63IEK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190163
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/21 1:40 AM, Muchun Song wrote:
> Add a kernel parameter hugetlb_free_vmemmap to enable the feature of
> freeing unused vmemmap pages associated with each hugetlb page on boot.
> 
> We disables PMD mapping of vmemmap pages for x86-64 arch when this
> feature is enabled. Because vmemmap_remap_free() depends on vmemmap
> being base page mapped.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Tested-by: Chen Huang <chenhuang5@huawei.com>
> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++++++++
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
>  arch/x86/mm/init_64.c                           |  8 ++++++--
>  include/linux/hugetlb.h                         | 19 +++++++++++++++++++
>  mm/hugetlb_vmemmap.c                            | 24 ++++++++++++++++++++++++
>  5 files changed, 69 insertions(+), 2 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
