Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B955740278
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjF0Roc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjF0Roa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:44:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E41A297B;
        Tue, 27 Jun 2023 10:44:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RBtbAM007684;
        Tue, 27 Jun 2023 17:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=v3v33DyM6oPRucep+24y1w8r3ESXjCAyCiAqWo1iQQo=;
 b=L82NlmCZDmuLh/fDp3MielH09xbuOnBg+a1SkC92dS/30QYnFuYfGuWvJ0/sf3sFQwBU
 2gl09gmvGUmrhnirGPHOgQIsEQc2jOmKYcCwxnVIL0Nu6xNPOBnrS4k2bw7h620oSIGS
 SK4OrGqSLFrRDE3cEx8h80mLifW/EFfgjsPGvJKRaZW0k51A/q3ZEv60ndJYAESAi5DD
 ZC11lMmpxl0oSlD9lgWG+S3tQQ6g8NIgE6xzIorJ6XFg+vSoeGSI+5L4EY6WyTrMXLHZ
 SCkpMAcjDNi03EpLnOrHwPGP7FapMl8fzyvvdPeIcEsv3z7TXUdITzmOTSwxytyPz5ox eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq935k92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 17:44:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RGUQQG019956;
        Tue, 27 Jun 2023 17:44:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxam0r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 17:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azNtQ6nQpQXcfAHQxgzCL2bp80baSAGkoH8uXXoP42gk81aiYphkoUGCfjq5nU6TzrxfrpdItL91iwyVcVd3EG+TH6bdWDMUkriwvwPrz5oM94NXHeUeYFXe0PCPcqu/nv4CQDZCTHjf4sXqfZirSaAKsXlJlPdJQuViKkWz1ivkjtkVjuV+Dc9frzT5Ez0EE3t9X3BRZkxTROUMFDwLeldFegL2JUd6oY7tQapuic6foEEuITqBvbezsmbIwPFWJyu/mnjB8JwZZInHuuOiQCKWXTMpYPnVZ3BeCqWkmcBi40MrcRv6wWHUI41JQa20pKB6Rjzx4ro51Sza6DTJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3v33DyM6oPRucep+24y1w8r3ESXjCAyCiAqWo1iQQo=;
 b=b6SWvYkM8UDtdopXAxaUrfD0LqTtEBnwTrShfN8xNIjrs/ffJ/I1XNOs4DhkuBRlGkKIcadT4F0RwjDjOFhvxYyU7qOL0jYDTlOLXJ2kZMY1abGQhxUGpdQKO1iRwlETFBYCH/gL+u46btMQLQ95p1E1ZtU0v9X1WVMdZ+64fSQcH4fpmAOi43qQ1XEbqX+PRlw8SzkKKjWjvktILCEeAchGzQ0Ca1pEZm2NWArehcBrPQxhm3AQgtFALiI7mAiqVmxpBMukKwrgYI6iv0boAHV14ieMkPAQIOca2pCSf1wkq9w8fw8gxRS50tRVScJ3W9iZpq0q8F5v/HvaAz/Iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3v33DyM6oPRucep+24y1w8r3ESXjCAyCiAqWo1iQQo=;
 b=aApW0Gnh8zGTQTUu2wYQ3tW+qnmQ8xq0bYPrN91/Wmh/s+aeKzk/G8aonlo455yJ2pl1xArjGh7X4LRz/3lz+a5eEChD0fdIR7i3Le2eXgZcQYFLOSUCLZgb/zf1ySRAXvizUn8VBGZQHPtIunzv7KFqYqMxQJBN1Q0J4LeVDJs=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB6193.namprd10.prod.outlook.com (2603:10b6:208:3a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 17:44:10 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.012; Tue, 27 Jun 2023
 17:44:10 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     akpm@linux-foundation.org, tytso@mit.edu, willy@infradead.org,
        adilger.kernel@dilger.ca, hughd@google.com, hch@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm: increase usage of folio_next_index() helper
Date:   Tue, 27 Jun 2023 10:43:49 -0700
Message-ID: <20230627174349.491803-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:a03:167::43) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 483b3c32-c047-4b68-afad-08db77361cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZgV3Ool1PYtPn5BvxCxxMd8A/MQXI0TSYDeuUY8CQmV8AUvMXamL4ajOmAiYe35S1EmE7baCgYST0AB38II+htUGkpPUqlR5R5nwN66AFQ8NZX4rIEtYmyX8N06EtfktYY6pmIXq0CSGlyPbkMzHtD/uoCCYLBxqPUXSUivBretIh7Nw7guC7wTLdHQYd1l1+Q7if3Ps/Fmi+Pq4Jm3+3207hopsxfhHfiQx6Zs5USIAnRc2k1t+98aLRm9yZgm/AXHoNpTn/ONtyyfYnmthfFdGycUllihoKcNCyOUuRmR2vwPTkjRg5dnmqKV831D86dB7HnHVurKmHtlcqsmFvXrOOfRHhwp3hU+XM7TIWjHai9nq0l0Nbepsual4hu9gzI1dtGZ6FJ0sJIYOhak/ztgl/f3aP8T1runuPCoTI/UIqdhL2gOxLVgA4x/YsJ4aDwS84XsnV8P0RjbEgy+5vNBWpJmHIq5KY/frVLhdQuXa4kN9vs5Ycj99IbbvWQVUNTbEYE+peYjjxVDtkHsXM+xz6wpkTo5hkWObFeQpMpmQh+OtH8wBZGvJHmEcDLP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(66556008)(66476007)(107886003)(6506007)(36756003)(1076003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(6486002)(5660300002)(44832011)(7416002)(66946007)(38100700002)(8676002)(86362001)(316002)(4326008)(41300700001)(8936002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4IU2lUVL9FO7BelvsmUWpwOAW2AlftfHhtKNVmnHvyRMimwXcef9y78M48iJ?=
 =?us-ascii?Q?rP26KYSVtY3zMKZQr3b2O5T7CRSME8CUSmY3j19Hve2voOLmFMmR1/WeuYNb?=
 =?us-ascii?Q?kKR4FwihBJvcJob1IUYw/K/7MI7cXsST2SCACwJAP814FoKG5sXC/n11LDBE?=
 =?us-ascii?Q?O/BaHOc30HjzdAe0mxgKu+fuOENRTnnyLLKkWlFiuiGeK29X9YyaiDrSCrR7?=
 =?us-ascii?Q?JiS81p3La0SOSLGceAO1fHFhQYJlqwotC5RwMrT9ahSUcjVe23dsxerqZEOY?=
 =?us-ascii?Q?8sgxSGdKVaGU/Tne3LQFjxyS9/mQDYTUMaJrCJvg8r3pouNfHxaD89TYdH48?=
 =?us-ascii?Q?C9w4yJuHVhzLCpC8LLP6KhCK84fbw+IzWHUauWChCb60L7M9B+YWDBJoioEH?=
 =?us-ascii?Q?6F7iAYehlbvu2VZ1txp3U41ETfR3xaDAGF9m5QsJT5pUEy3zAXo53jU8Hc87?=
 =?us-ascii?Q?InYkUylvh3U8t8Ek07Y1Y5fas048D0n1f7JXFHsc6MH+BmWzDgvkViWp+kfy?=
 =?us-ascii?Q?Np5s1+WD2AfU4mJMVTrt3z19uusjZ2yr5249/ZjB7OWRhbHvgdmA+03ivZsf?=
 =?us-ascii?Q?ERabBDbj6vS/iAU/GdatHg5ecfG6YsN6Nj7RT1zU3dPGZuvKclusnpZb8kWD?=
 =?us-ascii?Q?GIc1e5EL+aJXkGRUsmm1eOQmd6LXc9LD/O4v+b/q3VvfPUrnEbcfCtsH6+hA?=
 =?us-ascii?Q?eGsn44fv765bg0CcPY759Go/LAUnKRbsX4B1XEWKmHwCwRNamcWR/wP+mcAc?=
 =?us-ascii?Q?ll1fSFsnPH4TzgrGykbBaDcz/3HNbHberaYe87bZhg0Xf1c1MXUQ9EOW8v0b?=
 =?us-ascii?Q?mP4xJHKlSXX8HtYoQv69iUR5bP584ni2XyDYl9gtKQMkl1sPKONncxueAZs9?=
 =?us-ascii?Q?Qx9T+/KvHZoyGnUvrneIyHmdcf+On4t9mxnJxPkiEtLRe5HaoKq3UxiMtuz3?=
 =?us-ascii?Q?uBW5OZ/2m+liiJYa6Id2cku0hLq9cKKW/kLXp2GtQOnGzSTQ/xpf4EkEK4fT?=
 =?us-ascii?Q?3KmiceDCkFBKWKHh/PWEvrKP9lFwEsCZkLEbimphLg528GvWcOslEjqx3aps?=
 =?us-ascii?Q?IgyK/emIcp1CYy6f7cr2Gceil8dzh1abippuqiQTg3/Yv/GX6r3fKagTGDgG?=
 =?us-ascii?Q?mJ5reWxbZKDowYz1MeM3uqGn6dGNY2CkUviD8lhyeBgHhx0tmClDWVgAvzCS?=
 =?us-ascii?Q?r4A+oHby+Bguuj8bIv0cmtaiFd2NofEXNhLcs3bH5BVCU0MtCZ5E+y4+RsPY?=
 =?us-ascii?Q?2SON+VFB6fZfgwkVX2nXhJOUe3mNeUKAx6aQGxhd/GQtdqigla4SDkkZAhYP?=
 =?us-ascii?Q?KFivuPKEJPXDEF2ZKfRHPRMHFoFkZ0KMcLi1nCG+tfEAhYPhQDtGBwBo/ytx?=
 =?us-ascii?Q?M4vCHVxxRid9iOmlw8PIsgLLOXfB6hhGxsdC/ff2A9IAXho4O/bYDgbPT2VL?=
 =?us-ascii?Q?AzMuA+DJ47M+usErXZ8tqIzYWFJHoTCsVzjU9JIlO7rKHzDdkokMmTecQ3ij?=
 =?us-ascii?Q?VLOvEk2NEzdb42/LtzX0fP4OvVUBr2fx3Jqu9Fl21Px8E92I2b60FBSskW1g?=
 =?us-ascii?Q?x8Ejqqh91telsQHoVEycSy5Q5mMI666gD6JDINtjTHo6WnHlTgwV+vbJnHa7?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rTkKCpeOf2PE6pMhNP64ZGZ1m6Sto6b1XTvz7WSGT3ATPupC/tnstvgjjoOr?=
 =?us-ascii?Q?3o9Ldyr3UfZeRl8TyV+tCLdI1v8u4ZsqwwSaoMs0R56jrpRjgSp4/0N0oz61?=
 =?us-ascii?Q?ZLQYsOT6XdBtU7s0nJHUhxXeYhBLpLuTIARlfzzhHzaMb4qS21CJztg/fe9F?=
 =?us-ascii?Q?dxsSulNcr8UJgfEZH6UOMcxie+z3mK/EW/QAkAIFBy0kPq5U0ar5IZ44EuiC?=
 =?us-ascii?Q?lERdASLS+QzyFpL2WO141bNUjlTLCQeq9wmaHpeG4YQRE6d9UpcJ+vnZDMui?=
 =?us-ascii?Q?6wfr+hlGj33G0Qi+53T/N30nTO0Ow2XxPuDxQvm6kkdtMVgW1KkvuNQBc+hr?=
 =?us-ascii?Q?kSzY72A5b4Im50zXKpq+K6Lc2+MArRsUv5vl6yBKInecCrfYAYv93+1jEBFs?=
 =?us-ascii?Q?ZJjS1cIRCtt+bIkqDS6lUDw1KL+JjSmu6OU/sI6udgPpidIOVuQf53WMJ9Pa?=
 =?us-ascii?Q?8tsXBUezyJeTA9OfCVfv7QSoucCWEH1kjx4+c2cmB2ty5419QitMGzhnTPSh?=
 =?us-ascii?Q?OKOx1OoaKPIWlHqnnjGzvYuchsVHdD/hnKGxoQd4waK5KvZdQ5cm933vTNqK?=
 =?us-ascii?Q?7BfnXe+j+l1nFcgZkREQ+MLre4jzIwGxVhiksqtErxRngVZQh1E/04NBzxRS?=
 =?us-ascii?Q?Ub5aJj7ZPxiPnlw3thBr5ZsEF8QWCoYzKMXjMQcEQezsqLvSzsy3UbhMDrD6?=
 =?us-ascii?Q?dTKfL17YlXQ+af22mypzISA800jbhVTVRH02PyC7T0oklmJ1j5eiHxc9mwiB?=
 =?us-ascii?Q?YLOMsOn/8NUJ63E/xbyRfqSk4bmDP9MhJrucCVIqURbANXq7G49s9Bw0UHWN?=
 =?us-ascii?Q?44ErpxbcraQI2Wx98zaKmeZwj0yYPN9KqGyE9NSniuTQWrkJqDQ6TjClu48+?=
 =?us-ascii?Q?Pjv0e3WeLGXfyyvsabsgXXNflUVD09Kwqal9rgXS6u5u1Gl4Eit9t84ToFaO?=
 =?us-ascii?Q?hk30daT5mWFQmOfuxCIV2w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483b3c32-c047-4b68-afad-08db77361cd8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 17:44:10.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts2H7xlUlyGJ2fuDrXKyunMGJlXm5yKqdw/lsYghv7yGXYu74QBam8iTEMWjTtuLx/UxtBsVUSq79KYR04bB8Sf1Q9hxILLcETlefyGGcSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_12,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270161
X-Proofpoint-ORIG-GUID: ylDKhHUzeumFo9-LDMnmKD6LdBfk7PVR
X-Proofpoint-GUID: ylDKhHUzeumFo9-LDMnmKD6LdBfk7PVR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
the existing helper folio_next_index().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
 fs/ext4/inode.c | 4 ++--
 mm/filemap.c    | 8 ++++----
 mm/memory.c     | 2 +-
 mm/shmem.c      | 2 +-
 mm/truncate.c   | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 31b839a0ce8b8..ded4cbb017a51 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1583,7 +1583,7 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 
 			if (folio->index < mpd->first_page)
 				continue;
-			if (folio->index + folio_nr_pages(folio) - 1 > end)
+			if (folio_next_index(folio) - 1 > end)
 				continue;
 			BUG_ON(!folio_test_locked(folio));
 			BUG_ON(folio_test_writeback(folio));
@@ -2481,7 +2481,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 
 			if (mpd->map.m_len == 0)
 				mpd->first_page = folio->index;
-			mpd->next_page = folio->index + folio_nr_pages(folio);
+			mpd->next_page = folio_next_index(folio);
 			/*
 			 * Writeout when we cannot modify metadata is simple.
 			 * Just submit the page. For data=journal mode we
diff --git a/mm/filemap.c b/mm/filemap.c
index 758bbdf300e73..fdac934ce81a6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2075,7 +2075,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		if (!xa_is_value(folio)) {
 			if (folio->index < *start)
 				goto put;
-			if (folio->index + folio_nr_pages(folio) - 1 > end)
+			if (folio_next_index(folio) - 1 > end)
 				goto put;
 			if (!folio_trylock(folio))
 				goto put;
@@ -2174,7 +2174,7 @@ bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
 		return false;
 	if (index >= max)
 		return false;
-	return index < folio->index + folio_nr_pages(folio) - 1;
+	return index < folio_next_index(folio) - 1;
 }
 
 /**
@@ -2242,7 +2242,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (folio_test_hugetlb(folio))
 			*start = folio->index + 1;
 		else
-			*start = folio->index + folio_nr_pages(folio);
+			*start = folio_next_index(folio);
 	}
 out:
 	rcu_read_unlock();
@@ -2359,7 +2359,7 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			break;
 		if (folio_test_readahead(folio))
 			break;
-		xas_advance(&xas, folio->index + folio_nr_pages(folio) - 1);
+		xas_advance(&xas, folio_next_index(folio) - 1);
 		continue;
 put_folio:
 		folio_put(folio);
diff --git a/mm/memory.c b/mm/memory.c
index 21fab27272092..0cabfe9d501d9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3497,7 +3497,7 @@ void unmap_mapping_folio(struct folio *folio)
 	VM_BUG_ON(!folio_test_locked(folio));
 
 	first_index = folio->index;
-	last_index = folio->index + folio_nr_pages(folio) - 1;
+	last_index = folio_next_index(folio) - 1;
 
 	details.even_cows = false;
 	details.single_folio = folio;
diff --git a/mm/shmem.c b/mm/shmem.c
index 85a0f8751a147..d4ca8bc7ab94f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -970,7 +970,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		folio_mark_dirty(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
-			start = folio->index + folio_nr_pages(folio);
+			start = folio_next_index(folio);
 			if (same_folio)
 				end = folio->index;
 		}
diff --git a/mm/truncate.c b/mm/truncate.c
index 95d1291d269b5..2f28cc0e12ef1 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -378,7 +378,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	if (!IS_ERR(folio)) {
 		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
-			start = folio->index + folio_nr_pages(folio);
+			start = folio_next_index(folio);
 			if (same_folio)
 				end = folio->index;
 		}
-- 
2.41.0

