Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E979B58EAFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiHJLLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 07:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiHJLKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B32F676;
        Wed, 10 Aug 2022 04:10:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8hs4E031943;
        Wed, 10 Aug 2022 11:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=W+HbhXe7u+kZ3PrIDVcErvTI0VYljWAbmdOuNco+Oio=;
 b=lFyfOLa/R2aEXCF3i/f4GUA9P9YRHEjj4ZvHCzJAPz+MJtaP4YHndeoJ97hNMNFH+cWb
 ofR6MrvB2QaQMtxQFo3MfqlKNqucUOQRiJiurvEhcJ5XaB1/4OfmElDvPC3m6kDVMUxs
 t488+dih2tbzZhnenkVd3+vkH4t01n8ptf4EZIr88nDBbrS+JHU1OU1RCD9x3o7f4Iah
 wuaMeRASP/7vCouDpihnU6mKkuIyalZQLJ7hRzatxLhud4wK4yHMPNWkdreRI5pHcT/9
 AtHb8xkwG46+S1xlVxtsioBgYKjhZrZq60VzqlKShFcKPf1DVMceS+9FMD2TIzb9HA46 WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdsj54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9Krwk015352;
        Wed, 10 Aug 2022 11:10:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj1m5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpqIrEB4UBiKoWC47Uo/ZqhFd+ZyXoN/KkJE/5/sU7eaOerUFXoMrHNBc3ZwZ/uiw8PJQ4EmwMGGqGUZ0b5NMkAO+X2nKrct53HoxBMa0vAs7TCqbHmeoSAY0QYWHlWnmQXoUSBiBoe3yz1q21AHyGDf4O2IiEGUDBZq5W8NLa3jg8IQr4Jj9etE42AKBAFvWDpjixi/yRArzlE1zyCLfW0rFCDKf1WLh7bZ0xW+gnh04VRnmrVlB+xIYpAUln7eea55ng4ueiIAOLPJQ/RKytywU7s+0BYIS86UddPOauMeQiMT7ehWWzS0TQ+kpZ3pRdwkrHh2dGATEFy0hryBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+HbhXe7u+kZ3PrIDVcErvTI0VYljWAbmdOuNco+Oio=;
 b=a2l9BxZmFDDfAmEkpINbfgC4mlLDUdkA4c08dxpmHOapIyJuhkR7Q6/VTGdZYG+bUCOFyuuoI3Si4Xs+AOniZ3TpLXx225AfvdjE02agaPlYR5aABSfEd1aX14DUJljovbp6MUUWfS9V4FGODiucOivg2WibdqwCIJLnscH6R4p2a5XTtu4SbZVAZgUnq1UU1ArZjxDvEbCFS/7itmN7nmJRfOVmfyPjxw1m5TOiBHXLYY0sb4dGN3flwuAExFpykUJU5/Z/prDwF06Yp1Z7Zby3emEag6m96dGAaPFS0wRAn/Cqesk+snri9JofVk/fqTYS78kCXf2tnGfnVG8/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+HbhXe7u+kZ3PrIDVcErvTI0VYljWAbmdOuNco+Oio=;
 b=MoNJCr0YMxxbS/WgSo/iTBGfDh0wfUKaebNgg4ctnlAswU6MIzGOejQP+qf4p415tlcSgsdi1Dxi1y7a8q1xG2QOXxa/gfFYUhLJcK+8d0vPpJUTrqUGLdvmocc4zpM8uhfaAzyrrgB878mIJjjDiAyANCak5z/rLQFRSTiOCnc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3431.namprd10.prod.outlook.com (2603:10b6:a03:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 11:10:39 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 11:10:38 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RESEND PATCH 5/5] kernfs: Add a document to describe hashed locks used in kernfs.
Date:   Wed, 10 Aug 2022 21:10:17 +1000
Message-Id: <20220810111017.2267160-6-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810111017.2267160-1-imran.f.khan@oracle.com>
References: <20220810111017.2267160-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0134.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d917f083-24e9-43fc-3269-08da7ac0f4c2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbpGUrq50ZtHiokwY+OgA0TB7eU7ZGviaowKzT3XjsSD3slO6lsyM6/gBcvmSyF6vZ16OoGgR6GctvdS7JKhjZMRgLnbt1oVO+9aQyI8EIx3omK2ioqQCUVvcDg/W9ncbr1QGB2v7sgAI08jzAxao1f30bCygV3aUMFf6Ve4zUi2ZE9uBXdl2lhaHOc1Nm6NiNR/F4NvpTMArPlroKyF33oalVV6fhTjlKyNp9Oln0D7YjJrBFTHOdlVh2UnZ16C6QnzYFbMQ4E0gl54+Zdpnwqc91MmqdOGyUGQE/l8UfEdT2Y9mQfganJCO2WOYgZhuC+7TapLf5q9uqPizATyshvO+RWxmJY6MjT4msLXNSt8wP04EojRx9UZmv3hfW5IYB00iVILsphW3v87iYmnL3DN47ivzSO0e6fswZSIqdhSDXkMSipdDaAZ7Klx/WlQFQDjz6HM6jbGytozflCIeDPjtM+8WvBl2+Jzoyh3wMoSbfz3GwEhgjaSuEJGyruQNFwSinKex61OTq+mBqmIB4YeD/qdd/ykyrKbUBuKfUCESaW4ZNPc8Rytlkh9biibf+dZ0fAXBJMwvxbrE2dSRk+AJDkb/55Z+SF96PZ/3kMptbfOxULAadWsjzryj+rJgFd0p7h9d2mVh6Kdg2wz1W+9BuOyyTC1TGbppwFzOsjVYOSRM1Rd8rlHEW6VuRVJznn/LucqpAGx1jxcrdh7Ugs/TZLZ+Zygij3xlJA3wfb8tmnicyS1b0LTCm4+KvYWIUFTAaLVUtR8KO+5+yc6LL0nSG1VzuelTXUFcIDCMS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(376002)(39860400002)(8936002)(66556008)(4326008)(186003)(66476007)(36756003)(1076003)(103116003)(316002)(5660300002)(8676002)(6486002)(86362001)(66946007)(478600001)(2616005)(41300700001)(83380400001)(6512007)(26005)(6666004)(2906002)(6506007)(38350700002)(52116002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x2n7EfG2ZX8JkTqDiWle8h3AH1hiLZTmssCi6UPo4nt9xFipWCHvJ8iUahfh?=
 =?us-ascii?Q?SvHpT1ma1K9wagxdcRsvYWA+th80ONT+RtDWAUk2+ZK05wHZZSMCWz3ka/N3?=
 =?us-ascii?Q?pdao8PioAidDJZo8FQjzcLzSjfwORSolZTOGulDpyKHBLc0S7SK4qepC9VXK?=
 =?us-ascii?Q?GgpEz/aUYB87PG65ZL5rbCTOYnFv87c2zB18yMwN8HlDTx0msSZYdl5IQwhO?=
 =?us-ascii?Q?pz8+2j6fF6kWY0M2UdhROBqOF5N4Ucb7aSs00niuNDWxSZirvmxuoDpgw/7w?=
 =?us-ascii?Q?E4qYrrkYFJF+CJbcL/DsoDzFG1Nb3oRSsqPkVlRuRooqIVSYFaWrb/bkkCHd?=
 =?us-ascii?Q?R+WVHgbL0q9IeKZDrdEpZejLxy2/wcnIbkBFMiBqB9D3vbu0O8tLwCBn6dmW?=
 =?us-ascii?Q?osVrTZZr/FhGsm2fwSD4zqmfXyyofjKS1z8Hi30rKGiiteH9eh/JWXeSrguL?=
 =?us-ascii?Q?bBJKRF+XPPGQQ/QM/v8NArxXfFCE2ebeqVEofVyQ4oDX2fiYt+vjYpDph+Zp?=
 =?us-ascii?Q?uuDar0HqaAaj0KlrMvff239/PNMeLerSlCs9ZLl55LquRY4r/rvH4a648HNY?=
 =?us-ascii?Q?/Ckv2/AfLIvFpzb5ANFkIbAFDIfVOcG1QS5ax5nhVV4NGdfyFu9SMHSOltA3?=
 =?us-ascii?Q?OtzgZaNucDBLwQLsTNvugJaSL21vU0Izl4SXVKHaHj1Vl7c5SxOxzCMA6jCR?=
 =?us-ascii?Q?Myt+nbwxeHnxr1VqmgePkl2gNNwPDASlaPIppwZRFZPJ+wmEafTjEi3h5mvV?=
 =?us-ascii?Q?kHHbyujLe6XhW+WZJtKwWsxaiHZENLOzdfdH2R6tHyQEx8LTf27/nfyyCG27?=
 =?us-ascii?Q?IVyJkGpspkBXEOrPfN6u3LEnjy12OCNHucP+6RkHf+p0tNtYA37FESMgVQjK?=
 =?us-ascii?Q?LCSStaFJjolYkZ9w4N+fdA1A5gDCA7BBwEqc/uoCVc9FFADhgqsSooQXGL4g?=
 =?us-ascii?Q?XKRyY0HmThayhfb+KbsXopONy0yp7UsckCYxVT4p0f/c+YD5eXTfMi6NrnCX?=
 =?us-ascii?Q?nOu+w1r8A/srE1nY54TT8e/dT3eCr0GcQJLJNqwIYtd1geCqutj78/TyZO2a?=
 =?us-ascii?Q?sq6IgzK6RhKOu72F1IU+KbklSJ4JXzKs0pokffKsajIY17HLb7SphRpqjeJc?=
 =?us-ascii?Q?TGlxB2ZzblnjFnjOPJyV/E7/tTdwaKigOuw//iSFnc0LbMgDTYnKyhqX0co3?=
 =?us-ascii?Q?Y63HYeyTfUtTXUdN4ZfGeKXORojoWI56XLr9hPaV40l8qnsG9FbSMNqlrdqs?=
 =?us-ascii?Q?3p/cC3xev95HiZZBO57RWruDyCfUQboVHNaq6bNK/9CP1Tyqc2Ufj9dzjJzd?=
 =?us-ascii?Q?Pw1BFMfVTM0gvMeDH/yyIVwnawR+uLqDmmLvJN0LuTfFR5IlqAcj/cAZRuzS?=
 =?us-ascii?Q?tSDuJgcfAASmkMl2Ic5giQVq1N3ui+KOcIpp8BLviEfPcNP0HjKpLR0clc7y?=
 =?us-ascii?Q?C3C2VVJvJa1olgC+UrJARFAQTj2xmqq6EGAd0uPmn09axKY0JRrk9ktKlat2?=
 =?us-ascii?Q?ypQj6zSU37zj4ceMlQLkRML8QX9bLIsLUfyi8SgKrU2Mjo5ej/d5V/l7giXn?=
 =?us-ascii?Q?K+Lt83KDGXFl21muL81/K4JKc32asndo+KCguZkUea3GYP7wGDa2NbRRcPsz?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d917f083-24e9-43fc-3269-08da7ac0f4c2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 11:10:38.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5iXrEzUvZ1aTf5nIUzdvxXZVvN/nKtK1R67H47shVUkdaooq9RIF/xjNWy798eZAhMcmnM0x9ffwz7mFUPMiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100034
X-Proofpoint-GUID: IwcEA6Z9qp4SFPmCUiVorzP71n24-kk_
X-Proofpoint-ORIG-GUID: IwcEA6Z9qp4SFPmCUiVorzP71n24-kk_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This document describes usage and proof of various hashed locks
introduced in this patch set.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 .../filesystems/kernfs-hashed-locks.rst       | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 Documentation/filesystems/kernfs-hashed-locks.rst

diff --git a/Documentation/filesystems/kernfs-hashed-locks.rst b/Documentation/filesystems/kernfs-hashed-locks.rst
new file mode 100644
index 000000000000..a000e6fcf78c
--- /dev/null
+++ b/Documentation/filesystems/kernfs-hashed-locks.rst
@@ -0,0 +1,214 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+===================
+kernfs hashed locks
+===================
+
+kernfs uses following hashed locks
+
+1. Hashed mutexes
+2. Hashed rwsem
+
+In certain cases hashed rwsem needs to work in conjunction with a per-fs mutex
+(Described further below).So this document describes this mutex as well.
+
+A kernfs_global_locks object (defined below) provides hashed mutexes,
+hashed spinlocks and hashed rwsems.
+
+	struct kernfs_global_locks {
+		struct mutex open_file_mutex[NR_KERNFS_LOCKS];
+		struct rw_semaphore kernfs_rwsem[NR_KERNFS_LOCKS];
+	};
+
+For all hashed locks address of a kernfs_node object acts as hashing key.
+
+For the remainder of this document a node means a kernfs_node object. The
+node can refer to a file, directory or symlink of a kernfs based file system.
+Also a node's mutex or rwsem refers to hashed mutex, or hashed rwsem
+corresponding to the node. It does not mean any locking construct embedded in
+the kernfs_node itself.
+
+What is protected by hashed locks
+=================================
+
+(1) There's one kernfs_open_file for each open file and all kernfs_open_file
+    instances corresponding to a kernfs_node are maintained in a list.
+    hashed mutexes or kernfs_global_locks.open_file_mutex[index]  protects
+    this list.
+
+(2) Hashed rwsems or kernfs_global_locks.kernfs_rwsem[index] protects node's
+    state and synchronizes operations that change state of a node or depend on
+    the state of a node.
+
+(3) per-fs mutex (mentioned earlier) provides synchronization between lookup
+    and remove operations. It also protects against topology change.
+    While looking for a node we will not have address of corresponding node
+    so we can't acquire node's rwsem right from the beginning.
+    On the other hand a parallel remove operation for the same node can acquire
+    corresponding rwsem and go ahead with node removal. So it may happen that
+    search operation for the node finds and returns it but before it can be
+    pinned or used, the remove operation, that was going on in parallel, removes
+    the node and hence makes its any future use wrong.
+    per-fs mutex ensures that for competing search and remove operations only
+    one proceeds at a time and since object returned by search is pinned before
+    releasing the per-fs mutex, it will be available for subsequent usage.
+
+    This per-fs mutex also protects against topology change during path walks.
+    During path walks we need to acquire and release rwsems corresponding to
+    directories so that these directories don't move and their children RB tree
+    does not change. Since these rwsems can't be taken under a spinlock,
+    kernfs_rename_lock can't be used and needed protection against topology
+    change is provided by per-fs mutex.
+
+Lock usage and proof
+=======================
+
+(1) Hashed mutexes
+
+    Since hashed mutexes protect the list of kernfs_open_file instances
+    corresponding to a kernfs_node, ->open and ->release backends of
+    file_operations need to acquire hashed mutex corresponding to kernfs_node.
+    Also when a kernfs_node is removed, all of its kernfs_open_file instances
+    are drained after deactivating the node. This drain operation acquires
+    hashed mutex to traverse list of kernfs_open_file instances.
+    So addition (via ->open), deletion (via ->release) and traversal
+    (during kernfs_drain) of kernfs_open_file list occurs in a synchronous
+    manner.
+
+(2) Hashed rwsems
+
+	3.1. A node's rwsem protects its state and needs to be acquired to:
+		3.1.a. Remove the node
+		3.1.b. Move the node
+		3.1.c. Travers or modify a node's children RB tree (for
+		       directories), i.e to add/remove files/subdirectories
+		       within/from a directory.
+		3.1.d. Modify or access node's inode attributes
+
+	3.2. Hashed rwsems are used in following operations:
+
+		3.2.a. Addition of a new node
+
+		While adding a new kernfs_node under a kernfs directory
+		kernfs_add_one acquires directory node's rwsem for
+		writing. Clause 3.1.a ensures that directory exists
+		throughout the operation. Clause 3.1.c ensures proper
+		updation of children rb tree (i.e ->dir.children).
+		Clause 3.1.d ensures correct modification of inode
+		attribute to reflect timestamp of this operation.
+		If the directory gets removed while waiting for semaphore,
+		the subsequent checks in kernfs_add_one will fail resulting
+		in early bail out from kernfs_add_one.
+
+		3.2.b. Removal of a node
+
+		Removal of a node involves recursive removal of all of its
+		descendants as well. per-fs mutex (i.e kernfs_rm_mutex) avoids
+		concurrent node removals even if the nodes are different.
+
+		At first node's rwsem is acquired. Clause 3.1.c avoids parallel
+		modification of descendant tree and while holding this rwsem
+		each of the descendants are deactivated.
+
+		Once a descendant has been deactivated and drained, its parent's
+		rwsem is taken. Clause 3.1.c ensures proper unlinking of this
+		descendant from its siblings. Clause 3.1.d ensures that parent's
+		inode attributes are correctly updated to record time stamp of
+		removal.
+
+		3.2.c. Movement of a node
+
+		Moving or renaming a node (kernfs_rename_ns) acquires rwsem for
+		node and its old and new parents. Clauses 3.1.b and 3.1.c avoid
+		concurrent move operations for the same node.
+		Also if old parent of a node changes while waiting for rwsem,
+		the acquisition of rwsem for 3 involved nodes is attempted
+		again. It is always ensured that as far as old parent is
+		concerned, rwsem corresponding to current parent is acquired.
+
+		3.2.d. Reading a directory
+
+		For diectory reading kernfs_fop_readdir acquires directory
+		node's rwsem for reading. Clause 3.1.c ensures a consistent view
+		of children RB tree.
+		As far as directroy being read is concerned, if it gets removed
+		while waiting for semaphore, the for loop that iterates through
+		children will be ineffective. So for this operation acquiring
+		directory node's rwsem for reading is enough.
+
+		3.2.e. Dentry revalidation
+
+		A dentry revalidation (kernfs_dop_revalidate) can happen for a
+		negative or for a normal dentry.
+		For negative dentries we just need to check parent change, so in
+		this case acquiring parent kernfs_node's rwsem for reading is
+		enough.
+		For a normal dentry acquiring node's rwsem for reading is enough
+		(Clause 3.1.a and 3.1.b).
+		If node gets removed while waiting for the lock subsequent checks
+		in kernfs_dop_revalidate will fail and kernfs_dop_revalidate will
+		exit early.
+
+		3.2.f. kernfs_node lookup
+
+		While searching for a node under a given parent
+		(kernfs_find_and_get_ns, kernfs_walk_and_get_ns) rwsem of parent
+		node is acquired for reading. Clause 3.1.c ensures a consistent
+		view of parent's children RB tree. To avoid parallel removal of
+		found node before it gets pinned, these operation make use of
+		per-fs mutex (kernfs_rm_mutex) as explained earlier.
+		This per-fs mutex is also taken during kernfs_node removal
+		(__kernfs_remove).
+
+		If the node being searched gets removed while waiting for the
+		mutex or rwsem, the subsequent kernfs_find_ns or kernfs_walk_ns
+		will fail.
+
+		3.2.g. kenfs_node's inode lookup
+
+		Looking up for inode instances via kernfs_iop_lookup involves
+		node lookup. So locks acquired are same as ones required in 3.2.f.
+		Also once node lookup is complete parent's rwsem is released and
+		rwsem of found node is acquired to get corresponding inode.
+		Since we are operating under per-fs kernfs_rm_mutex the found node
+		will not disappear in the middle.
+
+		3.2.h. Updating or reading inode attribute
+
+		Interfaces that change inode attributes(i.e kernfs_setattr and
+		kernfs_iop_setattr) acquire node's rwsem for writing.
+		If the kernfs_node gets removed while waiting for the semaphore
+		the subsequent __kernfs_setattr will fail.
+		From 3.2.a and 3.2.b we know that updates due to addition or
+		removal of nodes will not happen in parallel.
+		So just locking the kernfs_node in these cases is enough to
+		guarantee correct modification of inode attributes.
+		Similarly the interfaces that read inode attributes
+		(i.e kernfs_iop_getattr, kernfs_iop_permission) just need to
+		acquire involved node's rwsem for reading.
+
+		3.2.i. kernfs file event generation
+
+		kernfs_notify pins involved node before scheduling
+		kernfs_notify_work and kernfs_notify_workfn acquires node's
+		rwsem. Clauses in 3.1 ensure a consistent view of node state
+		throughout execution of work handler.
+
+		3.2.j. mount
+
+		kernfs_fill_super, invoked during mount operation, acquires root
+		node's rwsem. During mount process there can't be other execution
+		contexts trying to move or delete the node so just locking the
+		involved node(i.e the root node) is enough.
+
+		3.2.k. while activating a node
+
+		For a node that started as deactivated, kernfs_activate
+		activates the node. In this case acquiring node's rwsem is
+		enough. Since the node is not active yet any parallel removal
+		that wins the race for rwsem will skip this node and its
+		descendents. Also user space can't see a deactivated node so we
+		don't have any parallel access emanating from their as well.
+
+	3.3  For operations that involve locking multiple nodes at the same time
+	     locks are acquired in order of their addresses.
-- 
2.30.2

