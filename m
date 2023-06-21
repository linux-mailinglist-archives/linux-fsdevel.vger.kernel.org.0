Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92C5739171
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 23:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjFUVYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjFUVYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:24:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ABC171C;
        Wed, 21 Jun 2023 14:24:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LK7dVE010373;
        Wed, 21 Jun 2023 21:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=O3WH09cy02Tz5lMmoi5+5H2UymjU0M6qPSSab2FSvog=;
 b=n8DN6QJSOQAR2fUhXNUrBkO0I44BxRZxp2A7KxuH/NrrXFmg7B25KevJ0Hbkec5muM/0
 8zOmCtIeKW4ekLzPDj0s1pSD/5SrM7gduGjxO/XitncsNsQK//OLkIJMO7dXxXskIDdJ
 2BzeGqMTI10KOgj5Mxa5T6FMGXAQ3u8qzGl9EOtltmlWJWewNCXZgYgTmb/IT//zPYu7
 5elEnmmpbS3tR7GOxmlngQtP1jJCsqJS3SSMXUft3p1Ai4PIV7VhbpZOjP9lLzuP2dBI
 BTjXasGSEbdgXZLqb1q9RqS9mJVV5pusajuI+J6l3zk9PsIcAo0960YJt2he1lfJ5nZp nA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcrnw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 21:24:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKCVoA005955;
        Wed, 21 Jun 2023 21:24:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9396d8e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 21:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h107+HCt4q0cDwgIp1ck39K2FY4cU7jHwbHq5e5yCTsMBEUFrP/y4ixd/2IUzFdpdfcIM5k+bUH8Gj+/W1n/btcDWEmN2IdyZzTRITJMMfhXGxExNIsSEp0wmB7kCJJNcwFPjkh2szMAVjF1C3YAHqcoEvSenG0SzlwpG//deGH8TqjeZfnnFERT6nTgPwFtT+sHRgu93gNHVAmv3L0BskaFzDuOlh8haWgKr82Ll1pKFG2q+qOyoZvbNeqNRUq3968ac5bRkfq3zM4VFXWwD3ecl2CR2h4AipXilJ213GSobraS2uxa8KhaHZ1w5LU9BtPXKLT4Wz9nfLJb0r5kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3WH09cy02Tz5lMmoi5+5H2UymjU0M6qPSSab2FSvog=;
 b=ZvNMUqQ5u//zzVvQ2a80FFhkihfLMTmG+DNus5pCLwUlbdrwUxKzkjIhSjGEFb1eQ4rLI8Llt5iQ7w/zaoJ29PjcPIpmuWBl+4iykNVvw5XoGDC68Wp/OVKThmKwt2pxipI4Uln5CcTkQ2iM+7Q8q3/PyfKxapVKj9VHXW+8Doij438sMHrSrBM2Lyy58PevEi7+dYhpQsuMLH6GcMt2yrkCri+C5uO9eXdw93RDzHYUUCgdVvcCVHO+SBqqQ6WJCwez9DkNYCg88NJcyOvahwsv2emIRu5R5UCHGgQVV+BNqy+Qa/7CENLprKNGUS7zX/eo3qSfw3wlAU47LpIjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3WH09cy02Tz5lMmoi5+5H2UymjU0M6qPSSab2FSvog=;
 b=qJ33jvYY22vBKoN/O4yToL8Vkbn6pwzZQ1mqSplLaDTZhZtEGgmjh3f0zfMwQVNDY8NtLt9MDhV3/+JIMfPc5y8IqLIdU/wqvX+9wRE8ANaxgd0jVj0/GA8QK0n+64x0XuWxrjIMwIbAujW2F7HSiKyBW9Set6TuvfY4SificDo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4482.namprd10.prod.outlook.com (2603:10b6:303:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 21:24:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 21:24:07 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 1/2] Revert "page cache: fix page_cache_next/prev_miss off by one"
Date:   Wed, 21 Jun 2023 14:24:02 -0700
Message-ID: <20230621212403.174710-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe5992e-5709-4a82-c7a1-08db729dd8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ht/Kd1irSBhQPnqv4hGcaI/oA5NUjrZKIkVZBpTFx+8L8wvQaL2f9TBxldjDM5uxffBWK7YIWFyeqyIPKU7gPfysf26H6atMGQ3/TZpj25rePTADv0G3G/uFKbPNSRHynhpZ/J6/q1pE9PXQgZlQ04Ry8TVWGY50QJ49fL1NX6hcGVR2p2+uN5zSjwO/pw40YXu0G7K4zjOuQS2ccePfBivNu9RJoFi1Q+Nu8Bi8JVVGbk70Xfy+tQoSKOr6RCyxeOPuLoQZR+vi5b1qPg/p9Yr6VS8l8ZfoVAilUgx9kAYlJOiuHaMB+kabMHkGNR3FqDN8/Swy73kmPatv3mIwfkoXH64WrOsWfQHfw5LQ3VrMTZr0dyM8UwvIcWwFkMmtqBxhmnHlwUIN2daQN91wng79YHkAgK6zNsr50Eq1zwKr0PhOXLtoZRris//PPJlPKmaFL/B8xbiHY/Z2U6G+J31SyG440z1juh3sGCXtVKwRXuXc5qs19cCi1JgiyNq1xJsoN1zOYfwcfORLu93SOOXQbSalWYHqhcuEjfX+uAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(36756003)(66476007)(5660300002)(7416002)(44832011)(86362001)(8936002)(8676002)(41300700001)(66556008)(316002)(38100700002)(66946007)(4326008)(1076003)(6486002)(966005)(2906002)(6512007)(26005)(186003)(6506007)(2616005)(54906003)(83380400001)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oOlUhK3pz13Rg/ilFzu+4a88F4LWW9B0LdAFlzJC/IXQc8dgLaQAS4epn8jE?=
 =?us-ascii?Q?4uQieGllKlnT61t+PUZbHyCMMie7XvMY2ULHA0UYqyOs7WAKGh47PY+xV9MD?=
 =?us-ascii?Q?MQKfEMc6R+ZEIGYe65UVXD3rL0f6+ph1JeVL+UYy7nh2bqBh56EJ+WV4BaZD?=
 =?us-ascii?Q?FvQaCxLct3wpynZ31lsqBbcp3y1/2NB3eKh/6/R4vy+ZljAXoD8ejHcdRlh7?=
 =?us-ascii?Q?wYT+xvoNQaS5DwKxyU+d096jJ7amPEcZvaqnVg1WUdxNTTLiLRHqol05wY4r?=
 =?us-ascii?Q?+HLaySEu+yS/gBTyfuMFQFzhaoWSMD/Y1fPYq/vXRsXpWZz6gYkrkznQHeQV?=
 =?us-ascii?Q?6xdPg/R8Ht61GZNgrOEcizpdRpxJdlEREawRx8qoDfrOw6aK2rjPTJsdlBMm?=
 =?us-ascii?Q?1joxhNn5nIPwspGrdjXM+TPJTm+b6ozkjhCoYCXC0sjguK+3PkrV3FJnXphd?=
 =?us-ascii?Q?L3iPKtHhxAYR2TpKCZi7+F5i02VU0m2T4max+j5AOfx+yzy3GCn3W35WMsmV?=
 =?us-ascii?Q?t3SUJPi03yFqw90hsamRTZBzYlKrq1EzO812FgXVc9B5KRMn4hAxKa6rIhKA?=
 =?us-ascii?Q?zO4PWau+F5ChHgubF713ZdZWbMWaUQJU1aarTzjq/kD9V9ViDRXA10BrpZ9S?=
 =?us-ascii?Q?o2gv7hxTh44Bg60I4i/oV+9PqKT3BGmfS9jCGgsVbshsUCotMsPN6SUqw+nq?=
 =?us-ascii?Q?N93vG5h8KuR0GHOKoHe1X1bXQEntuCMs59w/1AziqYjRzaEPpOdaJhwenyWa?=
 =?us-ascii?Q?n9iHx+l8zZkgSYlpc30CDCmGJ19pWAaFx1hq6MWvvUZvbGHH1EW6/90dSAxn?=
 =?us-ascii?Q?zIDmZ25YXez1Qi3cXmTZNvg8Ek4CDhE9uFLTuZx8x9N0Ana3KGWPygnZlNdM?=
 =?us-ascii?Q?FzDK3RvjZj36l3yJeqo4iqhVDRE6YKz6k8vQyFX03n+rRpfyQDTtX18xqt+P?=
 =?us-ascii?Q?5WxKRqnmee8FUr2SBhf5FTW157TKglnpOL524RcPZd3/xecYpXaeHw2y/elh?=
 =?us-ascii?Q?NMx70sa8YkeZx4HuA325irUQlFveUW1Gjei/Y67le7tqtDKlnBA+MC2DmB5z?=
 =?us-ascii?Q?7E103qv7qv5+q9I6kzbIMgipuX7diq5BnxWaVOfwoAcbOCXHPKv+7GjQPf6D?=
 =?us-ascii?Q?9yxuq/APTT9IH4OnYADdmGyE8mZHVhTyoyvc11mwXzXBlE3W0EdprCREVUKA?=
 =?us-ascii?Q?IM5JYZAsmIJhPEToJ6gjJJLrIyCuKqyWBJgC4HTWOx2bdu9VM/FGmiZR7mIV?=
 =?us-ascii?Q?PVBkh1KQ0vJXmgqH6f+lIcHpvJM6WPQeJjBwspWwO4iO9wAbw19jA3cLjX9R?=
 =?us-ascii?Q?MONEOPPupaqB41x/KwfH53jI9MeYR2IJlHz0YgCIr26gxX2BgvKg/ZJvXv5I?=
 =?us-ascii?Q?KB8Df65skC9kN4/UDQ03r6yj8Yv9AoH/OM7JTYxORW6g2wW29NmKq/P7NhCZ?=
 =?us-ascii?Q?8L2KrILkt1TvHyoyRSosPUOmNZ/0/+fpxhhwMP4d92vyM4+osqMTTT0QkAP6?=
 =?us-ascii?Q?EAnL7NT1Qnm9Ix1WjumoB6Ypz9pqtkOOQPjV1ZSPx3dpPt6TKEJHJEiAQFv5?=
 =?us-ascii?Q?MZbQc65D5d0Yer/LagWSZpHGtFj1PYv9TphcX9OW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LpOqbR7ja7zrycQ+aGSxxEOiwMQDVfnFKpIvQgIoCfmornyI3/1DfVNMJUP9?=
 =?us-ascii?Q?VOR0q9tO6mImOfeDu8/F//nU23dmcaLexuPRN+MpDhemS7GDSvWmP59ACkKy?=
 =?us-ascii?Q?eB1sKcLhppsXakf0lhzg9kT8nY6OvL+przSlux+KzqQJRr8BXqRKixlIWOLc?=
 =?us-ascii?Q?pc8evXwm0BJSvRPaMoLNatw+PMef3Ll/kKh0jMqooLtPrWUGX+cawB/lPMoe?=
 =?us-ascii?Q?A6B8Yu8ONi3c4VpAxr4YrU65DO1D/SYrNo0bWYyn7H5YeakikgR5mu626wN+?=
 =?us-ascii?Q?sY8Z3cWbS84tl32qf5KP+N/cz8qeHm3NmFwE5zAW3vQo+No3VUimG5IQ236I?=
 =?us-ascii?Q?E7oYyRzjVFsmx9lx+Qat+MAGaVKzO1t3vIvkQi80bOaQDrWSzH74ZwjGMqbd?=
 =?us-ascii?Q?L1DYw9dxXpqNHaMmZXrf9hCXWeaVAF2nuK/NkaaoEPZI4DNAb+iH+ebLafl8?=
 =?us-ascii?Q?LRjLX/o0SsAd2OFPVUxh7N9L900XOaNUa/kJBGR478S/gb864pO04RP6bODy?=
 =?us-ascii?Q?0XHATQZ84z20nfAjs5CVmasaHAXTagjyfDbwXUJ0XPwb+XRrSYn1ACaIHaf3?=
 =?us-ascii?Q?sY/bk5b/uZODkMPYuTWMVFOG49vaC+rVn2Wjg/RSvEW4Ogpbx3312oBmWxlp?=
 =?us-ascii?Q?bEmH7r1XU0FL6JCBHd3Jb07G7PMuyU54Ky6Swmpw9oY8zFmFT8Ax/X5mr1Bv?=
 =?us-ascii?Q?H4PlVrcYYlU3v2+in0AjVsNtFfOZnWqGkco6Vh0s9Oy1RbQzwLBLlEIXkov6?=
 =?us-ascii?Q?ZbFMNFdOpqB0bFQGAlmVRhxSRqcGOVKH0RTCrolVTOrDMzVAL9HnwkFUHJ6a?=
 =?us-ascii?Q?rGtyCBzLntox0iDV31op1J0uWMXnAKiQ/Nw66qaUilPJ2eIZoZMWV5ccCtdT?=
 =?us-ascii?Q?3c6JssRG/kyPyXWGizc5c92+wmbxbmvAz2qEoLVPjvXEZw4e2+i58QRoKdE8?=
 =?us-ascii?Q?nztbRsDSZRBwREGqcB+LMOBAinoMmFF7dSIo1pGHwKZKjibSwD5R+JeOfGLK?=
 =?us-ascii?Q?0OCIFKRsB2h6tFhU+7c70bQBCg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe5992e-5709-4a82-c7a1-08db729dd8ba
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 21:24:07.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIafjIq9Ri2oDkIsx2RjP0vuWhpS1pGx1VVTTseB7e+6Is7DnkMHqhl+ftcpjrVS1VEjq0CCoPLtrN1D4uWqZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210179
X-Proofpoint-GUID: n8wHBff92JPazWMLDH-zx09PmdlSh2AL
X-Proofpoint-ORIG-GUID: n8wHBff92JPazWMLDH-zx09PmdlSh2AL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reverts commit 9425c591e06a9ab27a145ba655fb50532cf0bcc9

The reverted commit fixed up routines primarily used by readahead code
such that they could also be used by hugetlb.  Unfortunately, this
caused a performance regression as pointed out by the Closes: tag.

The hugetlb code which uses page_cache_next_miss will be addressed in
a subsequent patch.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202306211346.1e9ff03e-oliver.sang@intel.com
Fixes: 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/filemap.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3b73101f9f86..9e44a49bbd74 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1728,9 +1728,7 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
  *
  * Return: The index of the gap if found, otherwise an index outside the
  * range specified (in which case 'return - index >= max_scan' will be true).
- * In the rare case of index wrap-around, 0 will be returned.  0 will also
- * be returned if index == 0 and there is a gap at the index.  We can not
- * wrap-around if passed index == 0.
+ * In the rare case of index wrap-around, 0 will be returned.
  */
 pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
@@ -1740,13 +1738,12 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
 	while (max_scan--) {
 		void *entry = xas_next(&xas);
 		if (!entry || xa_is_value(entry))
-			return xas.xa_index;
-		if (xas.xa_index == 0 && index != 0)
-			return xas.xa_index;
+			break;
+		if (xas.xa_index == 0)
+			break;
 	}
 
-	/* No gaps in range and no wrap-around, return index beyond range */
-	return xas.xa_index + 1;
+	return xas.xa_index;
 }
 EXPORT_SYMBOL(page_cache_next_miss);
 
@@ -1767,9 +1764,7 @@ EXPORT_SYMBOL(page_cache_next_miss);
  *
  * Return: The index of the gap if found, otherwise an index outside the
  * range specified (in which case 'index - return >= max_scan' will be true).
- * In the rare case of wrap-around, ULONG_MAX will be returned.  ULONG_MAX
- * will also be returned if index == ULONG_MAX and there is a gap at the
- * index.  We can not wrap-around if passed index == ULONG_MAX.
+ * In the rare case of wrap-around, ULONG_MAX will be returned.
  */
 pgoff_t page_cache_prev_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
@@ -1779,13 +1774,12 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 	while (max_scan--) {
 		void *entry = xas_prev(&xas);
 		if (!entry || xa_is_value(entry))
-			return xas.xa_index;
-		if (xas.xa_index == ULONG_MAX && index != ULONG_MAX)
-			return xas.xa_index;
+			break;
+		if (xas.xa_index == ULONG_MAX)
+			break;
 	}
 
-	/* No gaps in range and no wrap-around, return index beyond range */
-	return xas.xa_index - 1;
+	return xas.xa_index;
 }
 EXPORT_SYMBOL(page_cache_prev_miss);
 
-- 
2.41.0

