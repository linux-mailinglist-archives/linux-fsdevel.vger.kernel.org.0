Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06041374BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 01:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhEEXIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 19:08:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36316 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhEEXIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 19:08:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145N4QMS148110;
        Wed, 5 May 2021 23:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pIAeXDvMROUoqqzdjRfxq5iJpz0l3mRrXGL3wileBkU=;
 b=yPvCNUlWbBNMQtscE0fRqjWGidwKzu7nqRKHoGczPx6iz6N3CqMS77Mw8Itg9Hw1dR8L
 G0nMwrELe46q4/FHNgR6nBr79UZ0zlIdoUfvA2ZvxIOxBfXL2fgJGCET8H8V+v4Z0QuU
 XqB5bhvtxHErqw8fteaBUDiVcbk2BFxPv1My7BcBD83qwGob2CYZNnw2NROaI7RGEi1K
 o0+gosqvJODC8m++JliFSfl+FOhSwXVpudM9EWK/MKHi+aVYiVbVPgy+XsdhPz+ymjRx
 z0Za2ekC+y/YkN+I1mN0Htbm30e+fuTR1VJ9FoYM/NZk10uuIMUh7a71vJEitYRzXrD9 RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38bebc3d6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 23:06:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145N0LbJ097376;
        Wed, 5 May 2021 23:06:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3020.oracle.com with ESMTP id 38bebk2eq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 23:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWYJsezULTZTbmJA3m/eqStJeX1+vuPi29ae0Q0rKwpVuK7+DBOhQ/ee7PYmTnIYmDKhlLMQ/FMjigkUO1eXDkn0mN8wSiKj17pVshtsqo7Pd3aQkvXDLn1eEEpA2TorXhiSnzYEvSte93j04LZ0hj4BHeMjfS0ZsAGrTfDFdU17RxNDXOlmS6JOMTgBYZc8iOxnjDIts94qVJ6iR79iHwXyn7oZb6czfIm4OpPiOyf0YKPg9c0mxSEqkywgwRfKvA6GdpMbYsiFVGuREFO0gAWCSrBa5+2cQYjPV6tAyS/SEkZV71zV5r4xwRi4MBpnUXkMJOcc5ol20p7jirFbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIAeXDvMROUoqqzdjRfxq5iJpz0l3mRrXGL3wileBkU=;
 b=mAHqrgFelkaGq47L9IqMqwL3XsQbEYB8c6kww9bbJHi6VbDaAsXU2JpnH/L7HLYrs17zl+d3by+7xvDDmXN2l4fi8sFI7Sy88kT7+Ax6w/ofBWfzlWJfumeORb7F1hwgyug+lM3I10UkJ+1YQqNv+0u8G42gFkvv5K7ZXkCVFYZAMWc06auFIXF3fvmD9EXz3XeiJFgTmsohtIOBJJRJqhehS6K7NVoXeMHl5YoWmKFoZ25V56y1BZ3OGfI8k6Lkz6+C8lwEbuXb+wko9aiKRbIJpip1KGB+0C+XthnoWAVuHOid/ttfu7OyoyeFOltcviepAuTaaEsuS3If/YQ6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIAeXDvMROUoqqzdjRfxq5iJpz0l3mRrXGL3wileBkU=;
 b=LWY7mf8trgLWSwDZ72+0zWcyEWan+VFF9q8esPsLgHCvfanucaIl6CU7ro2eRVmGMnAY9v8vZuNq/8SJQRPY5UZxwXDjJtSul5lUMQwFcRQ03Zrm2xev9sOH8l/TyPwSqubmeWsksIghACFa2fUrpgZgiF0Fsd/QfClqEr9xoGQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3972.namprd10.prod.outlook.com (2603:10b6:a03:1b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Wed, 5 May
 2021 23:06:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 23:06:40 +0000
Subject: Re: [PATCH v22 8/9] mm: memory_hotplug: disable memmap_on_memory when
 hugetlb_free_vmemmap enabled
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
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210430031352.45379-1-songmuchun@bytedance.com>
 <20210430031352.45379-9-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e290d7a5-a847-1b84-283b-e9695a1d470c@oracle.com>
Date:   Wed, 5 May 2021 16:06:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210430031352.45379-9-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR07CA0055.namprd07.prod.outlook.com (2603:10b6:100::23)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR07CA0055.namprd07.prod.outlook.com (2603:10b6:100::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 23:06:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7833330-289e-476f-54ef-08d9101a70d5
X-MS-TrafficTypeDiagnostic: BY5PR10MB3972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB39729FC94F5269BCD3407AD1E2599@BY5PR10MB3972.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AfNq5JKjPxGQSF0xLR4m1oEAUNxvK2Ew40abVC+6wd4s5868qu4tU8Fqbm49QYIOOUy4XO8SOJ8JcIb175/vKFCN59kJeH32Pk+2JNSc5kaPpKPko5i7R/Tr3+xJFb8ksG6R/BlmCIC3lWeUqG5L7Q1kN5irtQbL0sNr9XTM7wMwUD38jU0ZsJyb3XtfyihmmcptuQupyCZV1++u/IYkh9lIvyHkrzA3Rv93b9VyIQD7Ct6ZhRz6YZi48+ir5SiLgx5MIFn4r85OS30Tg/MtL+h1vvn53zR15awslGy7msOruDqMT/T3O03dRWsVx3R0oWcp98nB1fzGBXsGZ9OgfP+oEtgDnYkD1nXqG9y8dFHW/4u1M/Hkk6z+8dlYrIItrMpbqfJ9cECRBaSlUqfhvCrrzNbk3feB6YskCV4IYf5A/klTngonkzXnaO43vs0RDALZVRFCcIYkjPx0JMXWz/cC76Ys94fuH1sBHMSm0ecPGm65cAih5IxqghR+j+aqMuMPMxMdl7Ok9otWtJWOV68jKz8pujiIdBpXa5Q9hQH0v902JxorXSr4JaOXINN0MxFGYCfWHjqNbOUkdAMCoDTSk8UvI65B5/gk7pyfrZkppoF3iPkYFXNVf5AeARNqR9/+81dxH94R4gS2urNPedD++T9NpPjKAaZg+FmD0Qgn4LCk/K6uKGhAt1rexTCxGWOgrIAnVVWSs8mcdjv7heRW4VHLC78IaiS8al+Csc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39860400002)(376002)(136003)(52116002)(66946007)(8936002)(921005)(4744005)(36756003)(16576012)(66556008)(31696002)(7406005)(31686004)(6636002)(956004)(66476007)(2616005)(6486002)(2906002)(53546011)(5660300002)(38350700002)(38100700002)(44832011)(4326008)(316002)(16526019)(83380400001)(26005)(7416002)(478600001)(186003)(86362001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N0NsTFBuamFNMHpiVUxpeTIwY1p4S1Y2WE53VFNGamUzKzNEc1gwYmR1L3Zy?=
 =?utf-8?B?VzYxU3ViNU1DakZ0ZThIdXZKeGV0V3pMOGxGa0JyZmlwb2szVllKL2pnRFI3?=
 =?utf-8?B?RTlvQ0pzcFdwc2NuQm9kTW1ZdmRLZ3pxRmJKWnJQMlNFZDcxdEVzeUFiZ0NT?=
 =?utf-8?B?VVlXZGFXT1NUNjVCN056dDJ0ZEY0a0hLeEpmdy9jaXA4K2g5Uld3Zmw5ZkZh?=
 =?utf-8?B?aURqeWg1TkEzcjNEZjNjWndsdDZXdGxEbjdkV0dqQXhrWjZUZ1dnMU13V3ZJ?=
 =?utf-8?B?bHJlMnE3bmc0R1ZuWUtzZUN5K2NqUHJ6bWliUGk5dlhNR0IxK2V4bStwMm5i?=
 =?utf-8?B?MENydGtoUkFyWWkrc2k0bXYrS3pWRWFONmJFWkNSSTVBdm9oTHQ2N3gvUmh1?=
 =?utf-8?B?SkF1eFI0RzdWK2Rub1JQUjFiOUNlUGVqSDNCOUV4a3I4RVNwei9MdEtoTE11?=
 =?utf-8?B?U1lCZ2F0eG9aRnpJdVpaNHk4d3I0SjVsNy9FMG8zcEZDWUM4WGR2VWR3d3FR?=
 =?utf-8?B?cEJZT3JaWTk3TjdwTDJ4YW5JZWlNc0FxdnJpanVmbjhhdmRuMHVWRUlyN21S?=
 =?utf-8?B?bC82ei9lQzlHOTRqZ21GTGk4RFZWNHA5bTlwYU1OSTNQQmhxNDZnSm1YVng0?=
 =?utf-8?B?VjNRb3puejZhdWVNV3BDVlJVUEVNYUFpZXl5MlhrTitRUTZHK1kxQkN6L2JG?=
 =?utf-8?B?cmx2Q0JpclJRZTJNSXVadlBhNGcvSzhmblNBVGI5d0pGWEpRdnc4cFZlbURR?=
 =?utf-8?B?NWZIOS83TkZ1Z1R5TzYvNklQaVNoMVp4NTJDaUc1SitoVE80c2ZxcXBZVGZZ?=
 =?utf-8?B?em1uWmFRYk5OYXl4K0NFK0g2cGY3VklWWk5Gd3VkL3NlYm5TMEZIK0E2cFNo?=
 =?utf-8?B?RHRja1VmdmhLUERsNG80ancyQnhIUjhBRUpzOWtRclF1WHN4YXB5THA4SUw3?=
 =?utf-8?B?aGJXdUh6bU9RZk1BTHZITmlwSDZ3b2FrMGozQ2UvMCtZaUFZTlBtZHEvUUho?=
 =?utf-8?B?dGxtbG56T2RYazdHWDFYWUhwcDU5SWdBaWduenRrQVdDZHZsTlpSU2tsTys2?=
 =?utf-8?B?OXVFRnJOYk1XWlNZbndsWDkxNC83THAxR0ovWVJacTI0ZCt4WGhWaTcwdTB3?=
 =?utf-8?B?RXpFcExuVHpta21xUktEeHFhLzZHWXd4KzJrcGVOUlBkMXlaNHRIbU5rWEVN?=
 =?utf-8?B?clhQVzZtdUVOem9KY2p3Q3lDeGxSZXdNQVM3OHVIem9EdVZFcm9rUjJRS0t3?=
 =?utf-8?B?WjkwS3poTHpJUUxxbFlEb0t5OG5nVnhqRStVZlRXZW9WQ1VSMUtwZ2FzcGE0?=
 =?utf-8?B?OG56UTc5QklaTnNtYlRlYW44RmZCdnJRTHNDUmNTaGJpSkFBQ3hpVlJTazF3?=
 =?utf-8?B?K05Oc1FyNkhnNWNUQ3pRTG9GRUV1YVhaT3piYlluR0tvSENrK1gzMlRiZThp?=
 =?utf-8?B?UHZ2dnBMWG93UmpnRjBVV2lJeTVHWGpiSk5FVUhUdi9MK0hzSTg1SmYxalBZ?=
 =?utf-8?B?UCtyOVZVWlZwVXc4VU5EMk9QUllUK1h2U0RXdnhaQmRtMUpCeDl0ZFRaaTNR?=
 =?utf-8?B?ZU8zNjBBbWJEZFBYb2t3c2tzZVBrU3BCczNBSFAxSU9vSjBYaENTdGc5dUFK?=
 =?utf-8?B?STZXYlc5UUROd21CY0NxU2ViZGZKZXlhYnE2TC9QU1Z0VlNoN2ZTRjNxSFl6?=
 =?utf-8?B?R1JnZTN1aGVjNG8wbTVqMkFlREg0eXVaYkJUZmdldkxhV3hCY3E0b1psNmpa?=
 =?utf-8?Q?IrWHXO6/mA6HpcmuJeT7I0VYHQsZIGYOXCeRww1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7833330-289e-476f-54ef-08d9101a70d5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 23:06:40.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o6Msq4jct9IxKKqzwXXFe8ffIPg26BkSI3vg4o9p1/eQyYVSUIHtQcRkXpcLwo8WQblaPUVxNDGI5OWH21KIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3972
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050159
X-Proofpoint-ORIG-GUID: qxiI2KN_9DJFWpB8KaHXaeVLyeZJ1jSA
X-Proofpoint-GUID: qxiI2KN_9DJFWpB8KaHXaeVLyeZJ1jSA
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050159
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/29/21 8:13 PM, Muchun Song wrote:
> The parameter of memory_hotplug.memmap_on_memory is not compatible with
> hugetlb_free_vmemmap. So disable it when hugetlb_free_vmemmap is
> enabled.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
>  drivers/acpi/acpi_memhotplug.c                  | 1 +
>  mm/memory_hotplug.c                             | 1 +
>  3 files changed, 10 insertions(+)

This seems to have taken all of Oscar's concerns and suggestions into
account.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
