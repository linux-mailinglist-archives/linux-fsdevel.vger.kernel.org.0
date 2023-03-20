Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3651F6C219B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCTTeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCTTdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:33:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB561CAF0;
        Mon, 20 Mar 2023 12:28:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KJOVU3018519;
        Mon, 20 Mar 2023 19:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=eT41snYY17D1sdvodOGjVh8lujavACVYV8Anii5TP+A=;
 b=n0sa4SViJY80a0l/kqlZAhv33lBglllWasOX1S3HJqsUzDNgxAdnuWPquSB6MIuLRM3m
 +7x7b8nwF8xffaNljgjFcJsk7GnXY6uERiCC0ZhYcr9USvM6b7MByFODYcIWb0w6wNwn
 WiW1BBGBzLXV9TUomk1xDOKvvv2pXlt5Nz7iLAFgZzGB3NoeieDz6BQy7oaquXkZx9Jd
 YWlPj1SRspbKeuhtYGXiHasNbg91Ukzko+WGeSxE0osmY7kCIEDhqy65LZOecP/m7iWu
 1mvvYlignhPdhpExbebWaZGtZpsPcQ6o7LYo9OZjU/yxVGJ0SWyOhc8s1BnlCtmfX0ER MQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56av9e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 19:28:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KIavdn006331;
        Mon, 20 Mar 2023 19:28:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r4qf52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 19:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caDSgF4tIc3K54J9/WkFd/9x7TAm7BwCL18kU8fMBe6+aPmOj32tt3sdBfW/Qe780J8eLc5yf5I0Lesl59BCprnjmKVGWaDYJqzS0dOEa8NfTJUMFHh+QFgBi/i+8Wdrvgh5emIiRv1Fwm6+w7Wxhxt/dq+547DsqtGlO6YZo57z+XmES3eGhtaTj1zYgvYg4HoehhG6kapTsxpkPXT06JrgsxOwFXO4adrmLpf/Kue9ICKLT/WMi6gvYplr3Reqhy/T5nnQc9HPL8l7O1UBjLS94B8yKFQzQoFzmFalbqoCm0Q1jadALCmlamHZRXeTGHhtqEMTjK60LztyL3jpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT41snYY17D1sdvodOGjVh8lujavACVYV8Anii5TP+A=;
 b=cBC0RhGXFrJj0TaxGCIYxxFaPyjSC2Tm7k5JOIEQCqrayhRZEbwlSRDEQTRf2g/Ff+yUKFSnqPHcmAUln8AMaKZfP6oAwZ4RKWP2jdBRVOpnfAlf2cUB7hVegaN4PwcqBlkTg+6KKmdnxrxSLnqQ1384rqPilxwLLwEO2BuxDTzVlWKf7tDjuoQYMdd+SjaH7qQyPbctO8UhEK8Js+XBTyR5Mr9N7j242LeZYncu+IaKoMj47dSW0NqO8vHUqO6N3QY4pSURS3kuFVTmGs8fzDLEnddoWo0JJus/y5wVE04X4lotgpnAPZMYuIsdISIICb0bqF0HqVe+F5YWqszQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT41snYY17D1sdvodOGjVh8lujavACVYV8Anii5TP+A=;
 b=b7V6vOmVD5XUhK3rDk7BGgBJwfb6RWgrw6n8EfOLMVXz4PoUSPOtuitt9E4nia3b9OgRZNi4+f7C0bLbUSbRJMGRZL0cRifiV8UylDLLqDeWQSOf+7gJTP/6pobTebEvNxf/WhU4PFux8fG0ZhCC3loJ1IvKcXL6dgqMbigHfos=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7414.namprd10.prod.outlook.com (2603:10b6:610:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:27:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 19:27:58 +0000
Date:   Mon, 20 Mar 2023 15:27:56 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vernon Yang <vernon2gm@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: remove the parameter entry of mas_preallocate
Message-ID: <20230320192756.chmdpduys4aseri5@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230110154211.1758562-1-vernon2gm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110154211.1758562-1-vernon2gm@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 0206ed4e-09fc-42ec-2b26-08db29793667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVSNFTZfwoJEWu+z6aulxXyvQmCU88F5Z5ibf2pnCGXgkJzAqSypuGEZCxkGcGVjgbo7zrXb36D+oj33tmIc40GbcKyHhWBUeopemJfyQ6DE+L5BdRsWD14mgvEYBkFBu693Er4qJIp5Z5xCOU6zBR1YuF6mUg8PkXDz/BihVKTMQqNu7SGMf1WkuE3Ozw8kqJ1iQsJzwDinQJDUf5/0/cDXy0N0JXX9wCbcZofn9PvvDa9L1L/t9dJsvL4M87F2WsjUl06UwzLSMXqYd3OpRV42Z4s4XA0u08O2T4UKE6mQBudJTCRh3s3yxtxaOxNbb/yELRfyioJLgp/H0FCPjAlxwH0NdM+Eigss+GQ/GUWWjfsAp3sRRpT2+RlIWTmG2nPqkUWq09/pTcFia4Wr7ynPVzKGc4JC1TXcouyIcSuI8K/l6AreXgpOvINwGG3+ID4GflrcVuDPysysy0Cy1OvcY191egMpqorhExJhMoysDhIHN5ukKQ6gejRUwWIdw0RmaT1yzaL+ywyjUmtY9zrITJfqhEgCiyc7jHND8ueU81bohH/uubOiB/9KmkrmyTvkZXSrU9tC/rungYiK5qOVbYNQFyzoNGgnhUrUv9746mI2nC53c2mH9mYZ3nBk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199018)(6486002)(966005)(478600001)(4326008)(2906002)(5660300002)(316002)(41300700001)(66946007)(30864003)(8936002)(66556008)(8676002)(6916009)(66476007)(6506007)(86362001)(38100700002)(186003)(83380400001)(26005)(9686003)(6512007)(1076003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OpPe3yqpihq2ZNcLy2qGsQecGiYPjOwQgnRhsE8VoDgMhCQ8af6JrRFKq/CO?=
 =?us-ascii?Q?upmWjtiObesZMKOEr1H/7E1QsDj9OUOZZVjnCQXxPH7wk/kQDJhOV7+4A8u0?=
 =?us-ascii?Q?ZOWO4pCHirNL6bUW63Dc/4vkvZXl3Ywione7AlfeOWtqfRbFHMqlmYLhDj8j?=
 =?us-ascii?Q?d5w4yF6GsmBmHr/1EDGT47s8V+H4hQKdwsFPvzPP10OFIsPLY4M+9mStH+i9?=
 =?us-ascii?Q?9DIDhMwF9RPqi94YEdQOf4KwfeFDzLaRGYHA1RiR124+z4prmUEIyzP0YNYY?=
 =?us-ascii?Q?RmNnjG5iKCndXnVBTyNwTflGrRj7bONs76jwSOmZAUYdxAT0h8fF34eJONmm?=
 =?us-ascii?Q?60RImPFQOr/NkwsmKVGJFY6fu6OymI/JGxWXj540wgXdygB0gW9c1zFeH4HC?=
 =?us-ascii?Q?kONPvklfcYbRmRaZusSn/vnFsusid3/l1AtPDWoH+rYd16pIOQEyCvDr2OE0?=
 =?us-ascii?Q?6neX4ooRwO7nmXKQ4jThFg7etKd9dvXq6oWTTS9RdwJ7BH3hjceAqeOqpBgV?=
 =?us-ascii?Q?unSV2eAPkFGkgiC/MO470n22DbJ1CybcyINyv6rD2gEoWODB3uMmpFwUrNn6?=
 =?us-ascii?Q?MzJv+I+84g6ZAAO3BehLxe6wcm28Jp7kZc43ZqBHk7S9xDzLnubSyCKPS+4n?=
 =?us-ascii?Q?mGjuqI0NOsv1fw58h4G3OH+fQihY7FD8XaAx/CtQOW8xPuHxxj08mW6aGi9n?=
 =?us-ascii?Q?XCHtGeWhmhhGS++/UOFfU8qUqVjKarrG9zmvv/Lz6r6BjOa+rDVNv/3SXs9V?=
 =?us-ascii?Q?VUzmtSTl6hlW95jJkUX/POx+/aA7exMjbuVfec+1cIeOLVAyBQp486cEHPDN?=
 =?us-ascii?Q?XM9OwlWpMJkpvhYXhe8mp4mD/EfRe/olJBOlllOsl3DUpond+jq2jKb7ODKt?=
 =?us-ascii?Q?eaadGQBaLzvhg4bvH5TA9rOL+1qb6Wl8yLX2f7U6B7DmckGDWZ+Qixz7d1Oz?=
 =?us-ascii?Q?s+UGFZbm5pKHazl7/PxUWe9ItNDPPtYSCjhKDdYpZMeuW7MTK6fy4oyPWi1q?=
 =?us-ascii?Q?kX34Vt5jqiAkcpcRh+cHstvs+YMNZX7zaryAsBZtz5VAlJYh0dKCEJSwacwC?=
 =?us-ascii?Q?51nyariangggv/IslyfwhZcLRjPBfDJpE5ySnxidrvh0uIitfSpnXllbgH4K?=
 =?us-ascii?Q?Qpl+yvxhoH1SpiYtcaOzhEn78HflKr0GnB112/C/WNVDr4JfKmrZHIvfT9Sq?=
 =?us-ascii?Q?n9L/lCohjX2HrNUMX2/QE/VbWDXV7EGhldNktsfxv2M2ZxDkPidYGQzyuh3e?=
 =?us-ascii?Q?dAgCtUc0bpa2g6upvMHn3XGcF+aIIxntxn/WkWDUGbb9RDAifxU4Zua8R3Yv?=
 =?us-ascii?Q?y712miRb9HCDfSG3mbCh9DHeH9kkDzH0oNfOPtnZOxcUQKFKC4NTkhiXfxmU?=
 =?us-ascii?Q?jIgpSQWNsbh31CipkC3KCg1udvcTJMmzbOkQYmFcql2fgfRUwh7z3cBTtJ7O?=
 =?us-ascii?Q?lTQo5St2fDTQgb+Gn+eS+De1PCZl1guJ/sHx0c3yfBVhcEGoCcG1MEv89dYB?=
 =?us-ascii?Q?NzVsXWb+WEhfPN55YVt7LcajIAbTzzb3HtlWxJmOrhewJKe+PFM/09F2GW7J?=
 =?us-ascii?Q?0Ha/1ywFEbwfIp0xS7dQqQx+gnJmMPWDgu8EtHRRT6Vxz1EcvDcF7vVK8qWP?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9trgn4HHe2C+U1fEgATN6D3Ffob1Oo8+NdxGWggJI94ycVzDq0OY1XhSXID5cggT/IqRejF5MGS+1pBrrTamp5/DEAJ1SXbV4TjwtlHNZTDU9LWQMbm4qZ8f1MX4oVWQcLV6TAhsr2uh5yxR8IfKen9I4eLwxj1LxYk8DMn4Tbq5fu2JPNp/vhDZvOvqxOdASjShfTqSbq5GCJiLtIH5xbZZqhpeeXjcghRbjlQ8g95/l7cxb0EOT097ts64nXZM2xipDlGLiisbDfglhId1E7bOxcHIpNnJwiQc99vhlYHDJN1eIW/3caWzh1DKD71gTTHtCzEqv2bFamn0bS3PYNG/ybV2VS/lY0OBHzlD3irkxy1ZemGS0Z0ws6w13SRUACM+0F85Qy9pmVoQ2BFlQaITBkqKiZK0/gte6VWO5UQHwsU/XMtDsRNLaSTCyalhvAZ84kt6705N1ljluFRMfxJo/hParzPLD61DMw73+h2jEHHCnLlP3T8MAJOoCbDt0XvrtwcYi/2g4G9b/CidSL54ZbqxrBl7czdmh28FwxYTZnng0yHOTSIY5W/OuA7Ao51YnS7rdJBMpUXoO2NI7hzXWuIjpPFEfZLh8oMOOKDvsf/4iFCYSOJ+QV3fghjhqNHnUWm4nQ6wEEZUUmx+cXYhUmOM4rsM9r1MZHCQAojJbJZmbL/AKYoduZvBTvWATKjUn20iLfG+xOXIu6Rg0is0Da2MT6CXcXuh1fqYO0mf2Spz5d5vmXGsrTlPS8LBeOg5UwNhIV2X08FCP36OXg+0JrwttL09xX32NfTLqaE0Xt832qEqZzRjYQo/Fkia9pXImCBhEBJPtbcZHin9dVPaxysEy//Qh3zX31Pg31gGjKrPOiqiHKQM4p7IoLmV7LS2x5Z9RrEPArIy9LPBPw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0206ed4e-09fc-42ec-2b26-08db29793667
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:27:58.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJCQBrF2zNoq20Qzg+i+NcL/vWJnl5a7OJf0YV3QJtbQhLw5bDe8AlA9Fz49Odk5HBHWAQW3vT8FHNxCm+WkEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200164
X-Proofpoint-ORIG-GUID: 1ZhWo_8-NgR1L2YxFW_wVMS2c8LAtqR0
X-Proofpoint-GUID: 1ZhWo_8-NgR1L2YxFW_wVMS2c8LAtqR0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Vernon Yang <vernon2gm@gmail.com> [230110 10:42]:
> The parameter entry of mas_preallocate is not used, so drop it.

This parameter was meant to reduce the allocations needed to store a
given value.  Since NULLs behave differently than actual values (NULLs
are combined), the value being stored was going to be used.

Since the fix to remove GFP_ZERO from the allocator of the maple tree
nodes [1], this may no longer be a worth while optimization.

[1] https://lore.kernel.org/all/20230105160427.2988454-1-Liam.Howlett@oracle.com/


Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> 
> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> ---
>  include/linux/maple_tree.h       |  2 +-
>  lib/maple_tree.c                 |  3 +--
>  mm/mmap.c                        | 16 ++++++++--------
>  mm/nommu.c                       |  8 ++++----
>  tools/testing/radix-tree/maple.c | 32 ++++++++++++++++----------------
>  5 files changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index e594db58a0f1..a0d43087f27a 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -456,7 +456,7 @@ int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
>  void mas_store_prealloc(struct ma_state *mas, void *entry);
>  void *mas_find(struct ma_state *mas, unsigned long max);
>  void *mas_find_rev(struct ma_state *mas, unsigned long min);
> -int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
> +int mas_preallocate(struct ma_state *mas, gfp_t gfp);
>  bool mas_is_err(struct ma_state *mas);
>  
>  bool mas_nomem(struct ma_state *mas, gfp_t gfp);
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 69be9d3db0c8..96fb4b416697 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5712,12 +5712,11 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>  /**
>   * mas_preallocate() - Preallocate enough nodes for a store operation
>   * @mas: The maple state
> - * @entry: The entry that will be stored
>   * @gfp: The GFP_FLAGS to use for allocations.
>   *
>   * Return: 0 on success, -ENOMEM if memory could not be allocated.
>   */
> -int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
> +int mas_preallocate(struct ma_state *mas, gfp_t gfp)
>  {
>  	int ret;
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e06f9ae34ff8..64bdd38e8d8e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -472,7 +472,7 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
>  	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  	struct address_space *mapping = NULL;
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		return -ENOMEM;
>  
>  	if (vma->vm_file) {
> @@ -538,7 +538,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
>  	/* Only handles expanding */
>  	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
>  
> -	if (mas_preallocate(mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(mas, GFP_KERNEL))
>  		goto nomem;
>  
>  	vma_adjust_trans_huge(vma, start, end, 0);
> @@ -712,7 +712,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  		}
>  	}
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		return -ENOMEM;
>  
>  	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
> @@ -1934,7 +1934,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  		/* Check that both stack segments have the same anon_vma? */
>  	}
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		return -ENOMEM;
>  
>  	/* We must make sure the anon_vma is allocated. */
> @@ -2015,7 +2015,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  			return -ENOMEM;
>  	}
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		return -ENOMEM;
>  
>  	/* We must make sure the anon_vma is allocated. */
> @@ -2307,7 +2307,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
>  	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
>  
> -	if (mas_preallocate(mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(mas, GFP_KERNEL))
>  		return -ENOMEM;
>  
>  	mas->last = end - 1;
> @@ -2676,7 +2676,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  			goto free_vma;
>  	}
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +	if (mas_preallocate(&mas, GFP_KERNEL)) {
>  		error = -ENOMEM;
>  		if (file)
>  			goto close_and_free_vma;
> @@ -2949,7 +2949,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
>  	    can_vma_merge_after(vma, flags, NULL, NULL,
>  				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
>  		mas_set_range(mas, vma->vm_start, addr + len - 1);
> -		if (mas_preallocate(mas, vma, GFP_KERNEL))
> +		if (mas_preallocate(mas, GFP_KERNEL))
>  			goto unacct_fail;
>  
>  		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 214c70e1d059..0befa4060aea 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -602,7 +602,7 @@ static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
>  	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +	if (mas_preallocate(&mas, GFP_KERNEL)) {
>  		pr_warn("Allocation of vma tree for process %d failed\n",
>  		       current->pid);
>  		return -ENOMEM;
> @@ -633,7 +633,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
>  {
>  	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +	if (mas_preallocate(&mas, GFP_KERNEL)) {
>  		pr_warn("Allocation of vma tree for process %d failed\n",
>  		       current->pid);
>  		return -ENOMEM;
> @@ -1081,7 +1081,7 @@ unsigned long do_mmap(struct file *file,
>  	if (!vma)
>  		goto error_getting_vma;
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		goto error_maple_preallocate;
>  
>  	region->vm_usage = 1;
> @@ -1358,7 +1358,7 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
>  	if (!new)
>  		goto err_vma_dup;
>  
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +	if (mas_preallocate(&mas, GFP_KERNEL)) {
>  		pr_warn("Allocation of vma tree for process %d failed\n",
>  			current->pid);
>  		goto err_mas_preallocate;
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 81fa7ec2e66a..8170ef39d8c4 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35342,7 +35342,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
>  	for (i = 0; i <= max; i++)
>  		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
>  
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
> @@ -35351,18 +35351,18 @@ static noinline void check_prealloc(struct maple_tree *mt)
>  	allocated = mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated != 0);
>  
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
>  	MT_BUG_ON(mt, allocated != 1 + height * 3);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	mas_destroy(&mas);
>  	allocated = mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated != 0);
>  
>  
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
> @@ -35370,25 +35370,25 @@ static noinline void check_prealloc(struct maple_tree *mt)
>  	mn = mas_pop_node(&mas);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
>  	ma_free_rcu(mn);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	mas_destroy(&mas);
>  	allocated = mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated != 0);
>  
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
>  	MT_BUG_ON(mt, allocated != 1 + height * 3);
>  	mn = mas_pop_node(&mas);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	mas_destroy(&mas);
>  	allocated = mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated != 0);
>  	ma_free_rcu(mn);
>  
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
> @@ -35397,12 +35397,12 @@ static noinline void check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
>  	mas_push_node(&mas, mn);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != allocated);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	mas_destroy(&mas);
>  	allocated = mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated != 0);
>  
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
> @@ -35410,21 +35410,21 @@ static noinline void check_prealloc(struct maple_tree *mt)
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>  
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
>  	MT_BUG_ON(mt, allocated != 1 + height * 3);
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
>  	MT_BUG_ON(mt, allocated != 1 + height * 3);
>  	mas_store_prealloc(&mas, ptr);
>  
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
> @@ -35432,14 +35432,14 @@ static noinline void check_prealloc(struct maple_tree *mt)
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>  	mt_set_non_kernel(1);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated != 0);
>  	mas_destroy(&mas);
>  
>  
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated == 0);
> @@ -35447,7 +35447,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>  	mt_set_non_kernel(1);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated != 0);
> -- 
> 2.34.1
> 
