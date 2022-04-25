Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD69550EBCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiDYWZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbiDYVio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:38:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D1C3700D;
        Mon, 25 Apr 2022 14:35:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PIYMgV025669;
        Mon, 25 Apr 2022 21:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NWLwfkRUpZgQFZYX8aXDtjc1uclDc1aqE8CrWePgRXs=;
 b=XlsnQNjvQqAnl74D4bprdrVH2qWW1UftOSjgzPqqO3nj2Ulx7XbBeTspKprC2XcSI8fK
 AHiRADsFzbxH3szDhAuDPxnQoEc5RnO9NjCg9Xd56bsgaOQXWptXqWEalmxE6P+INZWa
 mqoV506AK5pzbOVinG8hkfHCX6SDQNpjg0H+lZkmdhJjOr34iKkZ8jAaIJjhY+4ALxUS
 wrOcpWFbT9hgxEq/nXYfqkZKUz+eD8kZTrIzhNZ8W3THChQWMlq6VigygdDeTJbxcVoN
 TA2BIpNypTYXidBHp2kqRYpadg/jgrpbbGC9KuWy43NSBzDTlxm29n8xRkryF7dVvuae 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mmfns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 21:35:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PLU7xm006114;
        Mon, 25 Apr 2022 21:35:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w30v4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 21:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG2dS3lKcyl+BkgbmdSXzm1uXCVah+yVawmXZxCzRXkJqbLqBYoXxGhgIMCWMUATUAViuNgP3NghLZL3JDCSXoO8C/pR+pRu/v8QLbdDnfWKlSeqd5U5hFKtuyRfkT5T5wq1CdVj+yVO1bal0KnxIZ0U/diikhnggu22qkaitXLi8tpHKvDYGiq9QYMeq/70jFvhjcUw5wa5dHv2MimdMgg/DZwsza68+ec3NO4kx2ftI/Tt8mRUYFL/Jkm33OAMoroe3gCAkwOYs7Ly99EDcUyf/akbx0TP8z3ySkYFu8XoPskdZeQwLo3W0LrBg28n1x1pTKcOR7/5BgsNZi1yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWLwfkRUpZgQFZYX8aXDtjc1uclDc1aqE8CrWePgRXs=;
 b=PZQB2Qdo6nZUt3ap8HW53a8e06/3n3w12OcEvsxNb9v2oF+v1ZRjbXazLQWvYfqgor8ZPrQeCmsZdhIq50wUBQwSKfG/0Yx+oP4OeItFGcB5QSBoTGW8mw5HSo2DIz2Q8KlTK7cdxS96HcSMBclNuscXnnZ9d53qFR56KB7plO1rUbVYaWi5TvzKs4jHrz2h5r0q8X3T24Q7QmYWtFIWpy37Z6t5pK85+XumBhm+6GxBzqIi1lbkEU6Gmxtx9fTSyuEIbBaofRF4fmKsQbFwhJPbOC5Aoh6PgU7CmTHD4a+YrP6Pe5wQ5WNyHs6znoLF9uZTWgGky38X7sxkKlPZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWLwfkRUpZgQFZYX8aXDtjc1uclDc1aqE8CrWePgRXs=;
 b=puQKMVZFLofjvYbJSqPADLB59Lcpndv2fPEP1enQV3GK2Wa/Ec5iugFnYGv8JBF6BEkDp1SUDYddl9vG7XdK96k8RJBTMFsLcpeb5Ndqpngf+k2PjgHcGEV2xNXbxKTfAIC0ROx17CkURzSVeDQK55HXqSuu1ecEDOZmzj2naAM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB3517.namprd10.prod.outlook.com (2603:10b6:208:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Mon, 25 Apr
 2022 21:35:29 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::29d0:ca61:92c9:32c2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 21:35:29 +0000
Message-ID: <e2b3dfe6-d7c6-3bb1-eebb-0f8cd97c27e7@oracle.com>
Date:   Mon, 25 Apr 2022 14:35:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v21 1/7] NFSD: add courteous server support for thread
 with only delegation
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-2-git-send-email-dai.ngo@oracle.com>
 <20220425185121.GE24825@fieldses.org>
 <90f5ec04-deff-38d0-2b6f-8b2f48b72d9d@oracle.com>
 <20220425204006.GI24825@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220425204006.GI24825@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6052b76e-8e61-4aba-df5a-08da2703850e
X-MS-TrafficTypeDiagnostic: MN2PR10MB3517:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB351769DF3A69906665CB2F4687F89@MN2PR10MB3517.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfqY91yLzLdsoaJuBdJhZcq8UQafbh47UXYrfFkyEfahSxIoUU7E4w9sbIQcRRp3zjTx/ImT/KkuGaT7bD5klJRtVNXIrKycrX3aR9Xw/hlChf4TdnDkgqpI2k2dZiy/iiOd4UqKIcjS22O2TOsxEv9PDP51qpDFHCTfp5qwxiRLTUNjnJkWXjxab8Xq8vFJlyNNV6ref+oRCLjcYawyFjvFeGnVBhL5oL339/2of5iFc46Jt5izDPM+jW6hr7mvvjdc8NZn5YQam8PujFlrx0YUqu8i+Cr6acsVJfbe+ilNuo6Q7C3J5yNHKpxT7J4Ib6+/AzG5l1A2j4sRFLJPWHcWxEFPS7cQ2/IX5A+BJpqsLCzzJt/I3PDVQ7uzvda495SGUeQ42HrhhYFsaeio5ndc53/XqVulHfnVbcpkDd8WZYv59m9plLvdLYnL2TwgNoZPQ1dwn4mPihJYJMevkfy+kXzwnQHO0yjXAYeItj5CmiGhOk3DrgdPANg79NbRU7ABZts3GysFbnnLpe8OPyhqQ7dmThYIv5lsOhltDewXAv2Y191o6rU8XZKYMjAMuzWXOcyZQibTo7ojr0LMllXnS/wN7E2HMKTCcqO8LspUCkHR1laALBb3N/3I2nvF3UMIBwCxWPcbufrBusyvGhop5r+4IwL2cdnBY0gjOt+JpSYKZF1CTl7Wdc5fRD7bBqDqoGiqmAKLf0vFO3Kjxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(86362001)(9686003)(6506007)(6512007)(83380400001)(31686004)(31696002)(186003)(2616005)(8936002)(4326008)(66556008)(66476007)(8676002)(53546011)(2906002)(38100700002)(5660300002)(66946007)(36756003)(6486002)(508600001)(6916009)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhjOERaRTZ4WU1zNm1qZlZMemFPWWUreHNCZHVacUYrdHhYNm5NZ2xsQndD?=
 =?utf-8?B?U0paMTYySnpQTXBTTHJUWlhSVFpRdlJ0dnlHWFhLV3c3eVU5Wk5pYjlDOHJC?=
 =?utf-8?B?ZTNzcXVjcGVxcS9uc0ZvZEtDU1dIUTYvd2lsY2Rlb3EzenpMUUdsRkV5OUdh?=
 =?utf-8?B?V0NzZldjNmJzMVByREVlNzFaL0lSMDl6REhBRlJBWUJkMUxMaGlHR0tuVk5h?=
 =?utf-8?B?SmJPbHdCMjBoOVBUV1N1VDlnZUZHaGh5SXdwaVlUUk1WK3lrbFdhaWUxd0Rt?=
 =?utf-8?B?L1NzZkppUlZ3cGdCYWh2amtwbDhJYXREcWJ3VlRmV0puTlFmR1pUSCtqYUd6?=
 =?utf-8?B?bnluQ1pNNzRhWVpwNExoNXJ6V3l3RUFYWGxnK2RkZytid2tGNmZaUWNjWmFs?=
 =?utf-8?B?SGw2Zk1oQTVrcUtHeUxjUUNHNWNVQ09UQVNTVHR4RDk5aFloU2taUXVjWWNB?=
 =?utf-8?B?Y2wvV04yWUt4QkM0N0ZsQ2dhTWJiNXNSLzdCOG9ldEU2YVJYaHByOHUyVjZr?=
 =?utf-8?B?cGhPaVRtM2tjNmpOdzQ3K2FSV2s1dHRiZGYrSlFiMlA5Um1uYkRhRVgra0xU?=
 =?utf-8?B?eHdaWEdEVnViQ1lJZitCU2ZuVzdRSlFnaXJndlE3UTFZTllMS0tUQzdycVJV?=
 =?utf-8?B?Z0YvTHloSmtwZlJxWlpVV3IyV3lsQnhwMk15UW5JakhMVnh5UWNVeDF2UHMw?=
 =?utf-8?B?WjlqMUdORW1uTVlTd0NURFlrZXAxbnBwWW1SUDc2RWJRbjEwVjlxY2lkTmUw?=
 =?utf-8?B?OHI5TGxTRjhuS0ZwMEdKR21EMjZHUEZjbW1GRGhDZlpJTnl1YUtYbVo2NEZY?=
 =?utf-8?B?ZzBoSlpnTnc4QXFXKzNiajY1Z09RenZUYnl3WDZSZklpTUFLa0xTM0xLQ1FU?=
 =?utf-8?B?cWRlZmxaRE9JMzBqQVZ3ZGdLYkgwSVRxaEovMGtZTE14SkNvY1FMNVhWd1BJ?=
 =?utf-8?B?M0R2eXVzT0VPa3dkZjlXa3BQZHM4T0NQN3dnRDJiZ1djR1ovSGg3ZTJqWUxI?=
 =?utf-8?B?a2czSUNpOFV3ekcxS1Y4MmgyMW5Jclh3RHJBdXR1VStmV1REZHNDN3NMU0pj?=
 =?utf-8?B?NHZOeEtPZFhtN2o0SU1wWCtFbzYwVndTQnJMUG5GNGRGN1M4UjJRWkJwVy9i?=
 =?utf-8?B?QVdvRnNBS1hiV2diWFlORUlDVHZyQ0FNeUx4SkxvdjdnSzY1Mkh5M3NER3ly?=
 =?utf-8?B?bURxOHVnUHpJL3lyekpORGhCU0UvcnlicFc0ZVBqWkVZRzI3UDF2a2grQVNI?=
 =?utf-8?B?bUQvSmpTL0dNL2c1UElOTEZ1NURIQTBaNld6VE96VjgzQVJqUitxYnUySlUr?=
 =?utf-8?B?QnhhYjEwaU93dTVuSHpiM1ZnZDNPUnliQzRERnAyc3NrL1p0L1FkWDdNUkRD?=
 =?utf-8?B?eEhwbXlFSTEzWWxrakszOUw1QjhBeE0vQll2U1hGaFpNekhEUVIyMUx2MUxI?=
 =?utf-8?B?d1FkUzJIc2praERyQStsejNLWTAwOHAxNFJqdTdrdnR0cFV3anhrVUtpMkZJ?=
 =?utf-8?B?WG5Nb3JheHFQTGhLY1VZZnRjVVpUOFY1aFBWMHFLZXVHR3JzTTRkZmVNL3JI?=
 =?utf-8?B?eVF3WXI5aWpiT1VkKzdiejZjNFJmOE9hOGZKRTdHZFYyWnU2Y2EydDBnblNu?=
 =?utf-8?B?bGtQRUc0M3JFQTAzTzlZcVJzdEt0Q0JUc0x1N2lWYzRMcWwrc1g1L2dhSEhh?=
 =?utf-8?B?ek4xRDl0WndWRkVBMkRsM2QvTi9MY01MbVRmRkRtWHNpbUhzVCtEei9sSDBO?=
 =?utf-8?B?RW1hVkRwNkF5eXczbHlOSWlBL3lCakJTc0cxYlR1WTRWOEVnaFc4d3Q0ODlJ?=
 =?utf-8?B?TE5TMHY3cDV1V3RpaDdIY0Radm1xTjF2MlpzckY3SFhueW12eVJOaGs3Y0xK?=
 =?utf-8?B?N1N3bFh6V1l6NTNlMzBOaVlzYTBrdHN0SHZlYWlhNmU2emZqalJ4QVZIVHJj?=
 =?utf-8?B?Z2JrRjg2MEZTK2RsRHI1ekdVTWNkeTA4U2c5RzE0aWVSS0V0allMQlNYUkVn?=
 =?utf-8?B?dFArV0pBelozN2ZIMmhKMFEvMi92NjdoMGt6eUlJMFJWZmExc0pDV1RzSWUv?=
 =?utf-8?B?K3MrelRraE1IME52NHdjQllyTVNoSTVPUFgzZGl4VER6Tm1rb05RMWlXOWZZ?=
 =?utf-8?B?aVd1cG9id2xpUm41Q0EzOGZWK1RVbDgyMHpaeldsL0prc1F1cjAzVlpYSmlq?=
 =?utf-8?B?a0Y1bGJMWjZUVS8xelpLcmdnUnZVWEVPMjFmcUxHdEJDcVZQSS9ZSnRjWG1s?=
 =?utf-8?B?bGxkMzVxMjg5N2FiYVpkZWtmajBLcXVKdDFMWlBVWS9ETGx6Z3JvWHkweG1Q?=
 =?utf-8?B?a2x4RVRvNEtidFhSTUNwRS9RN2IzTjdFM0cvYTVqc1h0ODVRR1VlUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6052b76e-8e61-4aba-df5a-08da2703850e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 21:35:29.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TsV1dpyVQky/9hXcAYe0XDCh46iG8N+DxaoaudNwnFl4DwTW8hEPo67OEjXgTy9QIOxRrZLXVL9urrTk4N2fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3517
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250095
X-Proofpoint-GUID: 6sqLVuETyY1azGHMVKy4QAKqXuiN-EM7
X-Proofpoint-ORIG-GUID: 6sqLVuETyY1azGHMVKy4QAKqXuiN-EM7
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/25/22 1:40 PM, J. Bruce Fields wrote:
> On Mon, Apr 25, 2022 at 12:42:58PM -0700, dai.ngo@oracle.com wrote:
>> On 4/25/22 11:51 AM, J. Bruce Fields wrote:
>>> On Sat, Apr 23, 2022 at 11:44:09AM -0700, Dai Ngo wrote:
>>>> This patch provides courteous server support for delegation only.
>>>> Only expired client with delegation but no conflict and no open
>>>> or lock state is allowed to be in COURTESY state.
>>>>
>>>> Delegation conflict with COURTESY client is resolved by setting it
>>>> to EXPIRABLE, queue work for the laundromat and return delay to
>>>> caller. Conflict is resolved when the laudromat runs and expires
>>>> the EXIRABLE client while the NFS client retries the OPEN request.
>>>> Local thread request that gets conflict is doing the retry in
>>>> __break_lease.
>>>>
>>>> Client in COURTESY state is allowed to reconnect and continues to
>>>> have access to its state while client in EXPIRABLE state is not.
>>>> To prevent 2 clients with the same name are on the conf_name_tree,
>>>> nfsd4_setclientid is modified to expire confirmed client in EXPIRABLE
>>>> state.
>>>>
>>>> The spinlock cl_cs_lock is used to handle race conditions between
>>>> conflict resolver, nfsd_break_deleg_cb, and the COURTESY client
>>>> doing reconnect.
>>>>
>>>> find_in_sessionid_hashtbl, find_confirmed_client_by_name and
>>>> find_confirmed_client are modified to activate COURTESY client by
>>>> setting it to ACTIVE state and skip client in EXPIRABLE state.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/nfs4state.c | 129 +++++++++++++++++++++++++++++++++++++++++++++-------
>>>>   fs/nfsd/nfsd.h      |   1 +
>>>>   fs/nfsd/state.h     |  63 +++++++++++++++++++++++++
>>>>   3 files changed, 177 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 234e852fcdfa..fea5e24e7d94 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
>>>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>>>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>>> +static struct workqueue_struct *laundry_wq;
>>>> +
>>>>   static bool is_session_dead(struct nfsd4_session *ses)
>>>>   {
>>>>   	return ses->se_flags & NFS4_SESSION_DEAD;
>>>> @@ -690,6 +692,14 @@ static unsigned int file_hashval(struct svc_fh *fh)
>>>>   static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>>>> +static inline void
>>>> +run_laundromat(struct nfsd_net *nn, bool wait)
>>>> +{
>>>> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>>>> +	if (wait)
>>>> +		flush_workqueue(laundry_wq);
>>>> +}
>>> Let's keep those two things separate.  The "wait" argument isn't
>>> self-documenting when reading the calling code.
>> we can use enum to spell out the intention.
>>
>>>    And the
>>> mod_delayed_work call isn't always needed before flush_workqueue.
>> ok. I'll keep them separate.
>>
>>>> +
>>>>   static void
>>>>   __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
>>>>   {
>>>> @@ -1939,6 +1949,11 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>>>>   	session = __find_in_sessionid_hashtbl(sessionid, net);
>>>>   	if (!session)
>>>>   		goto out;
>>>> +	if (!try_to_activate_client(session->se_client)) {
>>>> +		/* client is EXPIRABLE */
>>>> +		session = NULL;
>>>> +		goto out;
>>> No, we definitely don't want to do this.  As I said before, an
>>> "expirable client" should be treated in every way exactly like any
>>> regular active client.  Literally the only difference is that the
>>> laundromat can try to expire it.
>> Do you mean leave the state as EXPIRABLE but allow the callers
>> to use the client as an ACTIVE client:
> The only place we should even be checking whether a client is EXPIRABLE
> is in the laundromat thread, in the loop over the client_lru.  Even
> there, EXPIRABLE being set doesn't mean the client *has* to be expired,
> the real decision is left to mark_client_expired_locked(), as it
> currently is.
>
>> static inline bool try_to_expire_client(struct nfs4_client *clp)
>> {
>>          bool ret;
>>
>>          spin_lock(&clp->cl_cs_lock);
>>          if (clp->cl_state == NFSD4_EXPIRABLE) {
>>                  spin_unlock(&clp->cl_cs_lock);
>>                  return false;            <<<====== was true
>>          }
>>          ret = NFSD4_COURTESY ==
>>                  cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>          spin_unlock(&clp->cl_cs_lock);
>>          return ret;
>> }
> So, try_to_expire_client(), as I said, should be just
>
>    static bool try_to_expire_client(struct nfs4_client *clp)
>    {
> 	return COURTESY == cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
>    }
>
> Except, OK, I did forget that somebody else could have already set
> EXPIRABLE, and we still want to tell the caller to retry in that case,
> so, oops, let's make it:
>
> 	return ACTIVE != cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);

So functionally this is the same as what i have in the patch, except this
makes it simpler?

Do we need to make any change in try_to_activate_client to work with
this change in try_to_expire_client?

>
> In other words: set EXPIRABLE if and only if the state is COURTESY, and
> then tell the caller to retry the operation if and only if the state was
> previously COURTESY or EXPIRABLE.
>
> But we shouldn't need the cl_cs_lock,

The cl_cs_lock is to synchronize between COURTESY client trying to
reconnect (try_to_activate_client) and another thread is trying to
resolve a delegation/share/lock conflict (try_to_expire_client).
So you don't think this is necessary?

-Dai

>   and certainly shouldn't be failing
> lookups of EXPIRABLE clients.
>
>
>
> --b.
>
>
>> -Dai
>>
>>> And then all this code becomes unnecessary:
>>>
>>>> @@ -702,4 +727,42 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>>>>   extern int nfsd4_client_record_check(struct nfs4_client *clp);
>>>>   extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>>>> +static inline bool try_to_expire_client(struct nfs4_client *clp)
>>>> +{
>>>> +	bool ret;
>>>> +
>>>> +	spin_lock(&clp->cl_cs_lock);
>>>> +	if (clp->cl_state == NFSD4_EXPIRABLE) {
>>>> +		spin_unlock(&clp->cl_cs_lock);
>>>> +		return true;
>>>> +	}
>>>> +	ret = NFSD4_COURTESY ==
>>>> +		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>>> +	spin_unlock(&clp->cl_cs_lock);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static inline bool try_to_activate_client(struct nfs4_client *clp)
>>>> +{
>>>> +	bool ret;
>>>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>>>> +
>>>> +	/* sync with laundromat */
>>>> +	lockdep_assert_held(&nn->client_lock);
>>>> +
>>>> +	/* sync with try_to_expire_client */
>>>> +	spin_lock(&clp->cl_cs_lock);
>>>> +	if (clp->cl_state == NFSD4_ACTIVE) {
>>>> +		spin_unlock(&clp->cl_cs_lock);
>>>> +		return true;
>>>> +	}
>>>> +	if (clp->cl_state == NFSD4_EXPIRABLE) {
>>>> +		spin_unlock(&clp->cl_cs_lock);
>>>> +		return false;
>>>> +	}
>>>> +	ret = NFSD4_COURTESY ==
>>>> +		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_ACTIVE);
>>>> +	spin_unlock(&clp->cl_cs_lock);
>>>> +	return ret;
>>>> +}
>>> --b.
