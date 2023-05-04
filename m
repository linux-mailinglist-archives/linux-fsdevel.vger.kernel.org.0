Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691136F79C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 01:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEDXjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 19:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEDXjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 19:39:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160FD9ED9;
        Thu,  4 May 2023 16:39:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344MLWkH006582;
        Thu, 4 May 2023 23:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=FM8VrX0GqanUAhp6iXqyHtjkWI0km68DpmVt1mVA6N4=;
 b=kEuod16K0tMvkwzHSv9YAUdDUX/dyqOCbBq1i5//1IaG3RLnFlF1bSpJXFuwRFZ0GJDP
 lYSfZg3B6C5D972R+3YlsQKLI3XBApKJldJ3C+KU86vkxU7Y7GLXNylBl6d/X3qOcY2r
 A6t7CtD//mQjTF2LHyIhiwHDvnZ9k/WRPMt2mzjjZDCelIJaFWjg0btwG05S+XZvpvkG
 KwfL3l171KkThsLtdqt0kto/AE9z6O3/c9J2p5dL52uT//opAdzz/4+iyrns4mW0ooWn
 tXBshwAdWzy7m+ESUYa3IrnJ5UreWbcCAj7uIf25DH5T3iELxWAzlGOFnuxiohgu3VVm Hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv38j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 23:39:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344NDcCW027528;
        Thu, 4 May 2023 23:39:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spffbh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 23:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gog4rFXTaCW96lCe3qcd/1+kF5RJKBVzZFgYFM8anZgdxb4u614WIe2rOyO1VRUCJhskdsstRtyI9FsC+swQkgZ08yfBAimfsQ1tHCfoZt57fDDihNrTG2sIXKesN3ygdAMu2vap2FIpAQoiXwytcObXR6MmBS0utWuX1Q9hIzEU9kgh/7wfof6fXPBWBezDgdkRfPO1RVlyhQyL3KD/2pxGb3yDSHtAUfpv6CVVFdrfqU1LWfxsKGg0+zDrbRmaOZckpBv2P/96mfMz4pdiupSzMVaUw4o4cYHZMSsKYent50cL7WiOcFJPg5dC2KmA+F4jArYH3YxwSTMl6u1CtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM8VrX0GqanUAhp6iXqyHtjkWI0km68DpmVt1mVA6N4=;
 b=lV54PWNO63KYlWSaBGD5h/fPA8VnSFNHCnyaqvyTCwoxOEAoG7YWeskksf9yxRGlcpLT1Dfcii20ikMZJxjVJN7JT+DamvCfvK0JTAFcK0dDsVcwIdi2MsXUvyD96g8eM0MEMce1v4DqUY7BbHLcKSOmKpgw07dkL6uYL6GapDNUVRHc8sLm2SmHIAsL4YJUDrP6TY4DJTCj9wStf+aCt/Xetpb1OU3iFQB1yss/FKPQGa6h4GrXsI56h3haVoFfwCA5Ms+9d69tSoQzYQ4HSQp7WDJLxYqFzXnrCci8tlijieXhkn6GYCdUTP6c5+at992/ex+ExpkmY3W5zKAwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM8VrX0GqanUAhp6iXqyHtjkWI0km68DpmVt1mVA6N4=;
 b=MdKYJgazgCJWad0qih2l6kWK56zBt0xRu8a5q3UW2nj4+wk7vrTEdPo7PpbToAk6FlDP945Km+kWeC7DvRjNbriCpkUzWkuRiHf0U8m3p+WfvCD244rsuFEbIlO5QlTEnR43Emhevg3LoIfToXtcOgGs16NMKmCh40g4/5jjaa0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 23:39:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 23:39:05 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, vannapurve@google.com,
        erdemaktas@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/1] fix page_cache_next/prev_miss off by one error
Date:   Thu,  4 May 2023 16:38:57 -0700
Message-Id: <20230504233858.103068-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:303:8e::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: e1efc4ad-d0d8-4aea-1f80-08db4cf8bfc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3NAHyrx1Nof4gQPmwJB43gwfqnMUhg6nkK/2K+Z9pPVi7a7ub/wx6K/Hi5OrhK+S2NtlWEwOLj4bJc4hacZgwXcOw2QICT9cy2u2XcesRuDJSU3h/uer5nf8VgBDgOjBGsTcQSQbmwFcI9y8fEekHJgaPCRgZQvKLQCBqgGI6IZMq42KkbFxgBd32G86ButJrTc6olbotWKZNWqEb6CRSZvqTaQHfNxPeEDsEEOPxKlOmkycQQXW2bgr+qvxIiete+7XxIdH4M3+Ccxaso1z+kn9gfIIcdilXnUoeTO3EeJAFsaGVl5syyW6ihQ/g6lTBA+9GAJKL0ucVwblYrGus6q+Pwx94ByfdBBgE4EeJIH5xqh2bsPiiNpNuCS9wX1opR1WGwWZGEnJcNqYVYdYs4OkGg971aibmMLbs0ssSXcdq5v5rm+1pkjYXhthCDNwI8lMsbHsvfbgAOtDYVdKJq1pTiaj2GoKsgs7IZFbA09wrFrbkBddMipjzkM+cWCOHQxp9hRto8sM2efkO5LeEiGXMez9TVSB4SFapsarn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(66946007)(54906003)(2906002)(478600001)(5660300002)(316002)(8936002)(4326008)(66476007)(41300700001)(8676002)(44832011)(66556008)(38100700002)(86362001)(6486002)(36756003)(6666004)(83380400001)(186003)(107886003)(6512007)(26005)(6506007)(1076003)(966005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KH+C5piD30r0Z+YvJnXXN3qfwo1LAQyTLzE6ttPXEgwHsfhTRNT9wvy9OJkw?=
 =?us-ascii?Q?0RqNq1Qkj3eeAcjs1UZGOCKuhqgqQVhEkwmXWnDyPqMkwxezqEqYsN2a/846?=
 =?us-ascii?Q?u7B4n7nQEPXCB+Yr3Cpn1WapAwG/gx2IL3RQFkJnoHj1rVhKmFIpYaMLJS5n?=
 =?us-ascii?Q?rIM8MeRMRaNuxZt5Ml2CVi4OE2CJqtlD3ia9OgLRGFAOqwcxDgzdFClGA7qP?=
 =?us-ascii?Q?ei/oTll8L78q+BmcnuDMsIc0vW917NFMT52taFSAjvAPjJ8h8d8lMddRiVj8?=
 =?us-ascii?Q?UV/k4L1Tei2zsbbTN2AsOeQ8wv2T3kZK3fZkXLNowo0Z+QcHXF3myMEBqw91?=
 =?us-ascii?Q?yFHVz4oLR47XhZgGKAPeXbP9VvEOc3Ea8L/V0Z42e+3qpJHq695wPgQrKAGL?=
 =?us-ascii?Q?NFdgUm7ba9qOVwMKKA3BiO4+baxpWbQicO7IULl0XZtqQlmFBu73YqYNRMK2?=
 =?us-ascii?Q?/sqZklkzKgNqkyUsKdgmeE2sFWq+Z8/Wib2gY+Yw78WoHrTBJDGF3kRcprnT?=
 =?us-ascii?Q?/rNKoxouJZzdrZ5hUZC6XZh+GJX+MCdhX/iPHHHFmqDrSIT9yHq+8MkvJ+xo?=
 =?us-ascii?Q?ii2PIXdTSQ0U/08iSUJF3pgdZnj7O3iGytyLIb7B9sactiIivbO+DXi7xiyz?=
 =?us-ascii?Q?4uLtDXLEEmBoYziIogoIyoS7UMwaE7o0/dEynw3l6FBR8LZVAJlQ/9NJ8g6i?=
 =?us-ascii?Q?we40YwMDg4NwPrbw5dMhrcmICq12QsSNTNHWHS2Siea7H8xPlYztyJU9N4yG?=
 =?us-ascii?Q?Sy5uAmah3fOKi1lEAsvJdIYRTRmYF5bSyi/aNjksPsiqG8pjgcWc0j4jmzTb?=
 =?us-ascii?Q?0UCSu9HOTn/CSFH+LvfXISh4/GQWFbP2a309GLgCGAb3uvuxzbS1CBf6s3qQ?=
 =?us-ascii?Q?TFm5LFY9VlJbBzr/JY4ZFMpMv26m+siieOc/yWDH45Lzb/w1P9/KWnGcvEMA?=
 =?us-ascii?Q?dhqeWUs7TgHpxqkFoFajqh9dxE8/ARyQaTPmTKPLgFXQlFFur5sBv/BKwYtz?=
 =?us-ascii?Q?Q++OWlhlSmKfn5e4asF9uIuk6bpfsjHQhoGfzHR31aFH7Ce+0wz1NfZSE3L9?=
 =?us-ascii?Q?aSoFuSgQh7w66W4gX8B1YWsGaYr4kX0lDOVsysHvdO47xgCz1vHailLH7gya?=
 =?us-ascii?Q?2PhP2TkxO6gbTenZCWfi7Gr3T5d5/yfrgyAcWxR4caUF6Aiz+8Dekh7LZK9R?=
 =?us-ascii?Q?h47rvgsz/dWf8pzUlsS9gsIhT26s3inqLR84zlBWszY5+GaQYmQDT0lN0BGy?=
 =?us-ascii?Q?Ds8wvs59UzzWf9nCrlzAZVSu2XsGBnTj/9CYgIxtOXY4iPjQKzVKgTezsSZ7?=
 =?us-ascii?Q?qgmfqaCtCJL1MVHqrms1SVIuqs4SMJ+0ScI7/wAgDY+xrY9pUYJA+ipwU1JX?=
 =?us-ascii?Q?gExHz7HC3xRmyvD93crKWdUrDHPRaERPLfxlMyLipHpav3xg3Hi4PgEOBKv9?=
 =?us-ascii?Q?cVTufGXOx70F67KlQXbT6vqUBLKGid5u8ZO9hJbYUlhlb90NihC2aJvRJT1X?=
 =?us-ascii?Q?r8coT4RrzkFH3goVzN7dmXuzvdTDETqA8PL5OPh5DPZj6eApu060TVgTUUDj?=
 =?us-ascii?Q?n4wxH96Q1KViMOf33XUGXtq507lruAfqLWB/3vFG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?omc8i4qAHlCQNCDDe1wPobyJYrOWsutMBrrdoaV0AzWg1SEuPfZUAlauz1uM?=
 =?us-ascii?Q?zTHT71Z2tHaHs8j/Jrz5rQaW/FFrZ7xX/Ux0m5K+f4Javn/mBs81U3bKVqg3?=
 =?us-ascii?Q?KqFl9Qv2uTQ7tnuooxxP75YWnj93pFI1KhLHO/vrOEdSg0839K7jgSPLvyz1?=
 =?us-ascii?Q?Z8SsVz2Q59leAkZadWmbvRB1xsWJSzYdqnYcMOXRXLNhRzMbqp7vf48iv35B?=
 =?us-ascii?Q?ZVnOTU/rQOzZjmFCqzDQZWLRfj1NDVdK6t1ZyGwaRkaWyhRs/3I7TlJixstr?=
 =?us-ascii?Q?c9HjWvprybFdzNVZNuY/G9yvJERPE4N32zTw+eKbQHsIvBSAfN6z3KLxAxHT?=
 =?us-ascii?Q?/yCJ8D+6SUOC6/a2FkGXgTpkMzicA3QjBicyjyrCC0IgBc4UrnbbDLIGvBbh?=
 =?us-ascii?Q?58d51uelVeMAEGfXQlZa7ScYZZh9gstVrgao11V2a2ykSpEQFeJP5hO7z/LP?=
 =?us-ascii?Q?+5AerUqeqNfimVB8Lqq63f8j/IOqX0jnmzpJcIOOQv/0B6gZnwgr069kILZ6?=
 =?us-ascii?Q?CBlEmEUJhPeknGvNG8pY0rRnJtpV+bQC/CYlUt/LGgluCxU0GotH6O7J9T9p?=
 =?us-ascii?Q?Gf3mIJSSKYmCSDasv6ZZYg/qH+cCAoB1UlOB7MTpuHhnAuQ287Gx42BCDlK3?=
 =?us-ascii?Q?xuUSaPKz9TivTSP9aSe6xxcE04eeBgwOkUegsg5b6rO7Ldzu8dbRg8TEvzD4?=
 =?us-ascii?Q?1qL+ERGH0MeIYkEvXUVbTXmpgvo3jSbhx4dnaiGnrSmDuaqTiClIy+AhSQhE?=
 =?us-ascii?Q?zrqpm5sXKR+9visVW6NpK+McPTv6YhZoUqQ39AzajbTPUzrXXSsf3dDUxJtI?=
 =?us-ascii?Q?1FqhnJC8ObqMUdmf6k253/C7/Xfa0oGGMgzv7RSLbBi5AGegkXFBZp+05ZMn?=
 =?us-ascii?Q?ANUxL5gi1GQuDwTNBhysjdDawy49SatEyDSDy6cvsf2oOp3Z5HEgDXCVFm2x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1efc4ad-d0d8-4aea-1f80-08db4cf8bfc7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 23:39:05.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE0AmjSSn28ZhPe5ZyvUOc85i0zsvT3lj+QK73AoDw8OU7n4Flun99D3gFBaw9V5CPbVOHOAY5FPYpRqcehSEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_14,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040190
X-Proofpoint-ORIG-GUID: d5ZMGdwNyHUjklF-rr4dG08XuKHUc7aM
X-Proofpoint-GUID: d5ZMGdwNyHUjklF-rr4dG08XuKHUc7aM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A cover letter is not necessary for this single patch as all information
is present in the commit message.  However, I am not 100% comfortable in
this change and would REALLY like to get comments from Matthew.

When reporting this issue, Ackerley Tng suggested a solution by creating
a new filemap_has_folio() function[1].  I believe that would be an
acceptable way to proceed although we would also need to change the
other use of page_cache_next_miss in hugetlb.c.

When looking more closely, it looks like page_cache_next/prev_miss do
not work exactly as described.  The result is the following patch.

IIUC, prior to hugetlb use of page_cache_next/prev_miss, it was only
used by readahead code.  My patch does change the return value and has
potential to impact the readahead users.  That is why I am not 100%
comfortable with this.

In any case, this is broken in v6.3 so we need a fix.

[1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
Mike Kravetz (1):
  page cache: fix page_cache_next/prev_miss off by one

 mm/filemap.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- 
2.40.0

