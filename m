Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7042C50E9BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbiDYTuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 15:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbiDYTuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:50:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1E62E0A6;
        Mon, 25 Apr 2022 12:47:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PIKmQc022232;
        Mon, 25 Apr 2022 19:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K7meqCHedcrUYHGsunMmHA/IfZHSj4Agf0yWfZxaQFE=;
 b=o1WnTaglDqXrdRZNWjQ6JGL9zoDM+/yfmLATZDm0xTy3pH5LvT/U7FOgRPwuYDpLBk48
 Hs6AewRheSCGG/AaXUo9cJpoc6ce8wlzWS0l4Q0Q7kSWU/ysKmBQUS26EdhL/b9u6H34
 ptbTjLDKTmTWnWW2i7H0AoGgCjXYJROxbvFlFDkmYiY1P9pqLXpP6rAyEuIjKCXkSBlK
 OilaOl8625vYfJUP4Ric4dyvpy9G6UGzw2rWmOkqLzwpGItQcU/00A9YVNJkkmU8tjGv
 2R4S1RR39d8aYSmE9FlPlqtJ4u52aS/vl8YB9a6/5/eDGdEuLbpMxYovE/69ORTSHb0m Iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4cayx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 19:46:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PJaQXq025433;
        Mon, 25 Apr 2022 19:46:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w21ph1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 19:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRMciwcsxYgaUY8YWSuHLTzu9mQihjdF5h8X6NEa5/E70Su4ja7G/ppSQOpyeIxpExM0uLxQUHti8Nb4LEyoN0TgPVgMKsgQyyB5sKOlpH/T3DIVeKwG4qy4eqHhRlOLgis6Ns06cioGbkS3rQ/VJXkzhZcikD6hRz+N/gtNKTcoAd3S2WelX5dJRBb2AJD69WKAb7AboOCwgbcPdyn/UudIruNqp1pr5/iA7zm9K2l/2gj4gv/rYMGKPA9kcFrHqFN2hhqXPApYZZ/T6gXNd6BKBqMxMnwJ+YfCDav5yRojaKqLJnM/CFBir1fsti9SpSeBRRtAK21+QxrMr8WEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7meqCHedcrUYHGsunMmHA/IfZHSj4Agf0yWfZxaQFE=;
 b=LI/WMSKua6womtacYtGcV209jH/JRCogU40Z3Un12IoRLsv0AFM5YZhhEatElill1kav2FuXEqgmOO/kNcXaaDk7snCPVWSoNpsPRPA4j97Xbwq/LE2rQNu1jX5qd+S3fFxfH9ez2EHbBsHwF+/rD4LvBKcwPl3Sk3raw1Fhswtk/Agrt8Sf/2leswwcQnx3zJL1PKIhWbGzlyEbzQXeMSi3OtfCVXptzjH72GxKxrlhQmkt7emZQbXAuvN7Q/IXReNFqGYmdXPjg+ms0BUwJ2Do49JoeBUPHLhp8u4IOfw25hEAeAwEz+IRInHXEClZFUrU0nBLDA9YMZteluShIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7meqCHedcrUYHGsunMmHA/IfZHSj4Agf0yWfZxaQFE=;
 b=fd3AT561Y620CqRtAwL/MFrhAEF61C/i5u5V/jc5fwkg3cLgWthz7TemOIQiPkRjFdSnuQVKGSSz2mhL4pg/0TykDZRnLeVdGB6oE5OcxaMpHHM7hPGHxYWSxVQi9c3tgNnmrV/s5Nechr69f7fOrul9+fMl2qpUwO+L4aiXDnU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3669.namprd10.prod.outlook.com (2603:10b6:a03:119::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 19:46:56 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 19:46:55 +0000
Message-ID: <d2685327-fc5d-b389-88ed-6bad7fda5e36@oracle.com>
Date:   Mon, 25 Apr 2022 12:46:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v21 3/7] NFSD: move create/destroy of laundry_wq to
 init_nfsd and exit_nfsd
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-4-git-send-email-dai.ngo@oracle.com>
 <8640dbe0-cece-4515-fa4f-efa2e0a14303@oracle.com>
 <20220425193545.GG24825@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220425193545.GG24825@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:805:f2::46) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbb176ce-1912-4181-fdbb-08da26f45a59
X-MS-TrafficTypeDiagnostic: BYAPR10MB3669:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3669A531B4EB360BCDF1A7CB87F89@BYAPR10MB3669.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Ov0ZQEC5B9FDF2QIG+uX48s3myc1htZ96ImBI0ms9dnoud0uhOPkrOq5li6c/ZBgDWnYzvFDwh2qgoDi4VL270yortGKHhYQIptMiQMVcWnjX608yE8HZ5BWC+t8etX2XbkcuLksiZEAltq+4ECDcndBlJ9ib3ieHCpXV1G7C+LWueCnsA/JX2wEOM8XRzqYCjjhPfuEjNgZFJBvNglxUmLbDmc3MIRUGI9q9NKH8hoP7c4BNYi9LGLaGjiRrxsotD5mLX/a8ERpuewXrjONKiJkUPnz6YXOG7e6vl0xDhrGS7ZApQYvVvOoZ+Ot0vQvSDVMur0HG03XKJpxDkxozWptpHKNodglxOttFOB+vKlmpLcTcQhm12iIH83CpSMhUe0tlhw0lom+UVmlf0eVAc66ggLTqJZ0R6VtKhkwlcvF0FsvwlW10vQAC+097xjjE2Dbpk2ek2pKvFE5QK7KIaxIWNKhzdNLh2242L0yS7x6Qs9l5vyqjRH2/j/x8BS3iNJAF4U1fiyKd/bqJoJ1fTfsprqjHQ7e0KFav8RpPxj7wU1timu1clhefcCmW173jv0Tkh2TAE/i/SaVp1FSTmW3CsRg+rN0g1GVOHIBDFWy5RfyKajZ2NoieGT4YvYf9b7cd4xb8gu6P3370nhYfufHSMI0mmA9mgHDzovfM8mEG7o63gQe8cyRly5i8EyMv4ZAc4qtCAcMx0E97T8cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(6916009)(53546011)(2616005)(66946007)(36756003)(31686004)(38100700002)(508600001)(6666004)(316002)(83380400001)(9686003)(66556008)(6512007)(2906002)(6506007)(6486002)(66476007)(8936002)(5660300002)(86362001)(31696002)(4326008)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEVaR21tbVpQOUgwcVY3VU9pUk5sUCtBRmJUeTBvNDhDNG9aMHdhOXpDZlNT?=
 =?utf-8?B?KzRydVNxczY4dkx4UFZzKzZCaCtBVzhHeUpvM1pUWDJZOEJyaURMMllWOTVs?=
 =?utf-8?B?NzRFMU1NMnB4SklrcVZXL2lScklrZEp0OHV1am4wMDhyQkJYR3JmQWp0Tjdt?=
 =?utf-8?B?VzR3blJrdy9zT3o2TU1VNkNOZnRoa290N3NUcnpsNjRrQ0NjWllYbGY4MTNX?=
 =?utf-8?B?b3B0REYwR0dHckpxa1RTMmlIRk5HMnhnWkN6cklZMHJJOExHeEJyRGpqSFdC?=
 =?utf-8?B?SmFCZURwUlBzc1JqTUkrNHpoeWhOYkJKdnRSR0JsdUFxdzY3alozZVJBczR2?=
 =?utf-8?B?WitacHJOdTN1UWFHMGdzUDJGWHhabjV4dW44YnFITmFIRlRoQXRYREtpZzRM?=
 =?utf-8?B?cXNSa1o4czBMMGxvYm9nbHlhWFgxdm5wa0VKVUhWMkRKbUtvbE9DcUVKN0JU?=
 =?utf-8?B?SVdzZm1DeXBuM1UwV1FMSE1CRkNBaXRMUHRjRnp3OS93aGVXMndOc0wrbVFM?=
 =?utf-8?B?N0NKYVF1czB0ajc5c09rMkszTEhya1lsTS9KMURPRTFtSU1pYWNJUE1ZVWkv?=
 =?utf-8?B?RU1UTngxaGtGNFNmZHRpTEo0Qm9adVRrMnd4b0FvM0JrRTVsZWpzc1E3Z2pm?=
 =?utf-8?B?aWw5eGZTTWl1TXhzNDg3aWVVTkJ2MUFKMWNMV1I3QjdwdktzaXUrUXRucFcx?=
 =?utf-8?B?OE1zY2lZbFNaOWJtN2JDaXkrbnJ5UFQyN3JERTVxdTFHNHJiRGxMcERDbEhN?=
 =?utf-8?B?ejhBQUt1ODlMVkFsTzF5YUptQURuZy9HZmR4QVpUR0xnL2lia1lycXBDWnEy?=
 =?utf-8?B?a3hzZUJpdFFnUXc2UzU2ZEZIZ2p5SG1sVWlJNVRsbWRPelZlVGFtVXZrREdl?=
 =?utf-8?B?TmV6ZUx2a0lrZ28yTCtheFp0VHJrYjBORlBOYng3UGc0UzQ4NitMdFgrdjFC?=
 =?utf-8?B?NWtiZ3U5K0d5UkRVTFcrNnBZUTg0dVdPWmsxczNXOTdVaTFORkZNZWpiTHZN?=
 =?utf-8?B?YXQ3TE03QVozUkZkR3doSjUyNGpXOVRvbUZpeDZZbUpaMDlmZS9KaVdRRWtT?=
 =?utf-8?B?R05IRytPRUdOUHZqdkFqUHZGSUJjL01uQ0xrM3FVMDFyUUhSUjRORXlocERE?=
 =?utf-8?B?T1NuS1IxS09JTmJFYVBIWCt6WDg1d2ZrQm9vU1ErUk54OVdXRTBNTjZrS1Jq?=
 =?utf-8?B?ZUNrSng4bWZoUUI0d0NicTI0cHdxRWRFWUZmUEkvNHNYTGRYSUJXU3JrdmFt?=
 =?utf-8?B?NXVwc29rWEJIZXM4NXlPMXN4TEI2aDM5a0M5Tm5EQy9INU45Rm5kM04zWFov?=
 =?utf-8?B?Z3psZlJKRWJSSTZOYUNJWkVqOU9RRXdHQjJMczN5bW80VDVvRENvRVhoNnpF?=
 =?utf-8?B?TmVpRVhBS1B2L1ZTVHVJdCtZeTNiRHJjWTlEM2xxbW44MnR4UjR4Q0NDSUti?=
 =?utf-8?B?eTluRHgzeUNCWWxuOFgwNWQvL0pnd21VZ3VNeDJkcGJFYUdNSHJWMlBxRUVm?=
 =?utf-8?B?bUFiRnpiT0V4Z3JVSmgwOGMrNzVzWXJPVTgydmd3RmZ1bDZqVktRc1JJdVU1?=
 =?utf-8?B?RXlmUGhvVndVV2M1UUV1UHpOQ1kydGxBZGZNa2JLNWtQUG8yT3NjWktHVDdS?=
 =?utf-8?B?b0NVZmQwWnlXZVpFNm5jakpCV0VmKzJyelUvSkxlbENON1JZaDJ3bnZwbjRq?=
 =?utf-8?B?b0VQZjZwZ2pndkJweEsvN0xCVzVYWG9OVGVSRDJPVFhkM2tCNlRxVkxKSC9m?=
 =?utf-8?B?SkZsRGwyQWVBK2FnUHN3YS9YUjNsU0Z2NThXb2plZGkycnNubTJ5Vnd5MGsy?=
 =?utf-8?B?Q0FEcW9McW12ZExUTzJ2Mkdpc3g1MzZ2Y0pPZ0Y1czJXa0EvNVNlb2dsWTBL?=
 =?utf-8?B?VWVQT1ZEY0NDNkdsaE1maFdJVHo0ZDVBZzNCclRrWE4vMzZuV1N5ZTduUm94?=
 =?utf-8?B?WnloQ1ZxTTQ0eUhxTzJ1NURXNDMveWh0WlMrZFVKU0ZaK25MWFo4RVBLTHdO?=
 =?utf-8?B?Qks3NVlRZTdSZk0zWXdtZ0J0TGRiNVFGL0o3Qm1wZVNteWJUQlA3Uzl3YmVE?=
 =?utf-8?B?Z3YzdHEwOU5KNE9FR0hwb0N6VmpmeDZqd0c2NVl2SGtVVlRia1RQUU5leDk4?=
 =?utf-8?B?cHZqK2tPT0pyQVJpQTlXdEVKb25JVzczbWcvaWxXZzVjUDk4VkVMbFVYRlNC?=
 =?utf-8?B?bk15aXc0aUlhck02ZnBNOUlZS1JEV0FETTMzS3NMdFo5cnczeDVhWVd5Y1Fv?=
 =?utf-8?B?QWRZQURTd2dUK0pkdUZqMHZvRlBEb2JnWFIxam53R3M0OTRsQkhVdXBpZUNr?=
 =?utf-8?B?QXBlUXo4bmhCV21ENjVkWmpnd29DTWlSc2Z2eitDVXJlSTRqY1hydz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb176ce-1912-4181-fdbb-08da26f45a59
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 19:46:55.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDKHh+nEwBq+07181sgMSm2gJ74CktqYVQmrHDbSTJI1Po26bICaRku7GSkWrfSBhj86O7rI6NwGHgBxwnKWxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3669
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250087
X-Proofpoint-GUID: Rx7_l60wC8wWwqvfv9_c5PZoA7C1S18b
X-Proofpoint-ORIG-GUID: Rx7_l60wC8wWwqvfv9_c5PZoA7C1S18b
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/25/22 12:35 PM, J. Bruce Fields wrote:
> On Mon, Apr 25, 2022 at 08:27:22AM -0700, dai.ngo@oracle.com wrote:
>> This patch has problem to build with this error:
>>
>>>> nfsctl.c:(.exit.text+0x0): undefined reference to `laundry_wq'
>>>> mipsel-linux-ld: nfsctl.c:(.exit.text+0x4): undefined reference to `laundry_wq'
>> This happens when CONFIG_NFSD is defined but CONFIG_NFSD_V4
>> is not. I think to fix this we need to also move the declaration
>> of laundry_wq from nfs4state.c to nfsctl.c. However this seems
>> odd since the laundry_wq is only used for v4, unless you have
>> any other suggestion.
> I'd just leave laundry_wq private to nfs4state.c.  Define
> create_laundromat() and destroy_laundromat() in nfs4state.c too.  And in
> nfsd.h, do the usual trick of defining no-op versions of those functions
> in the non-v4 case.  (See e.g. what we do with nfsd4_init/free_slabs().)

ok, thanks.

-Dai

>
> --b.
>
>> -Dai
>>
>> On 4/23/22 11:44 AM, Dai Ngo wrote:
>>> This patch moves create/destroy of laundry_wq from nfs4_state_start
>>> and nfs4_state_shutdown_net to init_nfsd and exit_nfsd to prevent
>>> the laundromat from being freed while a thread is processing a
>>> conflicting lock.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/nfsd/nfs4state.c | 15 ++-------------
>>>   fs/nfsd/nfsctl.c    |  6 ++++++
>>>   fs/nfsd/nfsd.h      |  1 +
>>>   3 files changed, 9 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index b08c132648b9..b70ba2eb5665 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -125,7 +125,7 @@ static void free_session(struct nfsd4_session *);
>>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>> -static struct workqueue_struct *laundry_wq;
>>> +struct workqueue_struct *laundry_wq;
>>>   static bool is_session_dead(struct nfsd4_session *ses)
>>>   {
>>> @@ -7798,22 +7798,12 @@ nfs4_state_start(void)
>>>   {
>>>   	int ret;
>>> -	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
>>> -	if (laundry_wq == NULL) {
>>> -		ret = -ENOMEM;
>>> -		goto out;
>>> -	}
>>>   	ret = nfsd4_create_callback_queue();
>>>   	if (ret)
>>> -		goto out_free_laundry;
>>> +		return ret;
>>>   	set_max_delegations();
>>>   	return 0;
>>> -
>>> -out_free_laundry:
>>> -	destroy_workqueue(laundry_wq);
>>> -out:
>>> -	return ret;
>>>   }
>>>   void
>>> @@ -7850,7 +7840,6 @@ nfs4_state_shutdown_net(struct net *net)
>>>   void
>>>   nfs4_state_shutdown(void)
>>>   {
>>> -	destroy_workqueue(laundry_wq);
>>>   	nfsd4_destroy_callback_queue();
>>>   }
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index 16920e4512bd..884e873b46ad 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1544,6 +1544,11 @@ static int __init init_nfsd(void)
>>>   	retval = register_cld_notifier();
>>>   	if (retval)
>>>   		goto out_free_all;
>>> +	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
>>> +	if (laundry_wq == NULL) {
>>> +		retval = -ENOMEM;
>>> +		goto out_free_all;
>>> +	}
>>>   	return 0;
>>>   out_free_all:
>>>   	unregister_pernet_subsys(&nfsd_net_ops);
>>> @@ -1566,6 +1571,7 @@ static int __init init_nfsd(void)
>>>   static void __exit exit_nfsd(void)
>>>   {
>>> +	destroy_workqueue(laundry_wq);
>>>   	unregister_cld_notifier();
>>>   	unregister_pernet_subsys(&nfsd_net_ops);
>>>   	nfsd_drc_slab_free();
>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>> index 23996c6ca75e..d41dcf1c4312 100644
>>> --- a/fs/nfsd/nfsd.h
>>> +++ b/fs/nfsd/nfsd.h
>>> @@ -72,6 +72,7 @@ extern unsigned long		nfsd_drc_max_mem;
>>>   extern unsigned long		nfsd_drc_mem_used;
>>>   extern const struct seq_operations nfs_exports_op;
>>> +extern struct workqueue_struct *laundry_wq;
>>>   /*
>>>    * Common void argument and result helpers
